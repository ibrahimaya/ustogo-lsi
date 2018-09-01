/******************************************************************************
*
* Copyright (C) 2009 - 2014 Xilinx, Inc.  All rights reserved.
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included in
* all copies or substantial portions of the Software.
*
* Use of the Software is limited solely to applications:
* (a) running on a Xilinx device, or
* (b) that interact with a Xilinx device through a bus or interconnect.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
* XILINX  BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
* WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF
* OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
* SOFTWARE.
*
* Except as contained in this notice, the name of the Xilinx shall not be used
* in advertising or otherwise to promote the sale, use or other dealings in
* this Software without prior written authorization from Xilinx.
*
******************************************************************************/

#include <stdio.h>
#include <string.h>

#include "echo.h"
#include "params.h"
#include "xil_io.h"
#if defined (__arm__) || defined (__aarch64__)
#include "xil_printf.h"
#endif

// TODO should just rename this file.

// Counters of the nappe index, total (across insonifications)
abs_current_nappe = 0;
abs_next_rf_nappe = 0;
int current_run = 0;
int ready_nappe_count = 0;
// Counter of the nappe index, relative (within this insonification)
int rel_current_nappe = 0;

int compound_operator = 0;
volatile char *tx_ok = "ok#";
void *mem_pointer = (void *)NAPPE_MEMORY;
char rx_message[20]; //TODO worst-case string sizing to avoid continuous malloc/free, but a bit fragile
int counter = 0;

// These two take care of fragmentation of input RF samples across packets
u_char leftovers[4];
int leftover_bytes;

enum OPMODE op_mode = MODE_FIFO;

err_t send_ok(struct tcp_pcb *tpcb)
{
	err_t err = tcp_write(tpcb, (void *)tx_ok, 3, 1);
	if (err != 0)
		xil_printf("ERROR: transmission error %d\n\r", err);
	tcp_output(tpcb);
	return err;
}

err_t recv_callback(void *arg, struct tcp_pcb *tpcb,
                               struct pbuf *p, err_t err)
{
	/* do not read the packet if we are not in ESTABLISHED state */
	if (!p) {
		tcp_close(tpcb);
		tcp_recv(tpcb, NULL);
		return ERR_OK;
	}

	/* indicate that the packet has been received */
	tcp_recved(tpcb, p->len);
	pcb2 = tpcb;

	int end_rf = 0;

	/* process the communication */
	switch (state)
	{
		case AWAITING:
			memcpy(rx_message, p->payload + p->len - 6, 6); //TODO this operation could be functionized
			rx_message[6] = '\0';

			if (strstr(rx_message, "#") != NULL)
			{
				int zone_cmd_switch = 1;
				int zone_count = (int)rx_message[0]; // Along each axis
				// Char [1] is an underscore
				int compound_count = (int)(rx_message[2]);
				if (compound_count == 1)
					zone_cmd_switch = 0;
				else
					zone_cmd_switch = 1;
				compound_operator = (int)(rx_message[4]);
				// Communicate the parameters to the beamformer
				int options_reg_value = zone_cmd_switch + (zone_count << 1) + (compound_count << 5);
				Xil_Out32(BEAMFORMER_OPTIONS_REG, options_reg_value);
				state = RECEIVEDOPTIONS;
#ifdef DEEP_DEBUG
				xil_printf("zone_cmd_switch: %d, Zone Count: %d, Compound Count: %d, Compound_Operator: %d, options: %x\n\r", zone_cmd_switch, zone_count, compound_count, compound_operator, options_reg_value);
				xil_printf("Moving to new state RECEIVEDOPTIONS\n\r");
#endif
				send_ok(tpcb);
			}
		break;
		case RECEIVEDOPTIONS:
			memcpy(rx_message, p->payload + p->len - 13, 13);
			rx_message[13] = '\0';
			if (strstr(rx_message, "NN:") != NULL)
			{
				int next_nappe = (rx_message[4] - '0') * 100 + (rx_message[5] - '0') * 10 + (rx_message[6] - '0');
				abs_next_rf_nappe = (current_run * RADIAL_LINES + next_nappe - 1) % 65536;
				
				if (rx_message[8] == 'F' && rx_message[9] == 'I' && rx_message[10] == 'F' && rx_message[11] == 'O')
				{
					// Flush the AXI Stream FIFO for a bit (bit [3])
					Xil_Out32(BEAMFORMER_COMMAND_REG, 14);
					int status_reg_value;
					// Just bide some time in a way that the compiler won't optimize away
					for (int cnt = 0; cnt < 100; cnt ++)
						status_reg_value = (int)Xil_In32(BEAMFORMER_STATUS_REG);
					// Flushing done, just configure it for the imaging mode
					Xil_Out32(BEAMFORMER_COMMAND_REG, 6);
					op_mode = MODE_FIFO;
					Xil_Out32(BEAMFORMER_RF_DEPTH_REG, RF_DEPTH);
				}
				else if (rx_message[8] == 'S' && rx_message[9] == 'T' && rx_message[10] == 'R' && rx_message[11] == 'M')
				{
					Xil_Out32(BEAMFORMER_COMMAND_REG, 4);
					op_mode = MODE_STRM;
					Xil_Out32(BEAMFORMER_RF_DEPTH_REG, RF_DEPTH);
				}
				else if (rx_message[8] == 'U' && rx_message[9] == 'B' && rx_message[10] == 'L' && rx_message[11] == 'Z')
				{
					Xil_Out32(BEAMFORMER_COMMAND_REG, 0);
					op_mode = MODE_UBLZ;
					// TODO very weird value and calculation
					Xil_Out32(BEAMFORMER_RF_DEPTH_REG, 2886);
				}
				else
					xil_printf("ERROR: Received message '%s' while RECEIVEDOPTIONS (expected: 'NN: xxx XXXX')\n\r", rx_message);
#ifdef DEEP_DEBUG
				xil_printf("Moved to mode: %s\n\r", op_mode == MODE_FIFO ? "MODE_FIFO" : op_mode == MODE_STRM ? "MODE_STRM" : "MODE_UBLZ");
#endif

				// Reprogram the zero offset only if necessary, because this operation
				// resets the offset, which we don't want in between RF transmissions
				// of a single frame.
				int current_zero_offset = (int)Xil_In32(BEAMFORMER_ZERO_OFF_REG);
				if (current_zero_offset != ZERO_OFF)
					Xil_Out32(BEAMFORMER_ZERO_OFF_REG, ZERO_OFF);

				// This is a workaround to move on to the next run
				if (next_nappe > RADIAL_LINES)
					current_run++;
#ifdef DEEP_DEBUG
				xil_printf("Next relative nappe with rf data: %d\n\r", next_nappe);
				xil_printf("Next absolute nappe with rf data: %d\n\r", (abs_next_rf_nappe + 1) % 65536);
#endif
			}
			else
				xil_printf("ERROR: Received message '%s' while RECEIVEDOPTIONS (expected: 'NN: xxx')\n\r", rx_message);
#ifdef DEEP_DEBUG
			int status_reg_value = (int)Xil_In32(BEAMFORMER_STATUS_REG);
		   	xil_printf("Beamformer status in RECEIVEDOPTIONS: 0x%x\n\r", status_reg_value);
#endif
			if (op_mode == MODE_STRM || op_mode == MODE_UBLZ)
			{
#ifdef DEEP_DEBUG
				xil_printf("Moving to new state RECEIVEDLENGTH\n\r");
#endif
				state = RECEIVEDLENGTH;
				send_ok(tpcb);
			}
			else if (op_mode == MODE_FIFO)
			{
#ifdef DEEP_DEBUG
				xil_printf("Moving to new state WAITINGBF\n\r");
#endif
				state = WAITINGBF;
				// Do not send an "ok" for this message!! It is not expected in listen only mode.
			}
		break;
		case RECEIVEDLENGTH:
			memcpy(rx_message, p->payload + p->len - 7, 7);
			rx_message[7] = '\0';
			if (strstr(rx_message, "sendrf#") != NULL)
			{
				state = RECEIVINGRF;
#ifdef DEEP_DEBUG
				xil_printf("Moving to new state RECEIVINGRF\n\r");
#endif
				send_ok(tpcb);
			}
		break;
		case RECEIVINGRF:
			if (op_mode == MODE_UBLZ)
			{
				// First check for "startbf#" at the end of the packet
				memcpy(rx_message, p->payload + p->len - 8, 8);
				rx_message[8] = '\0';
				if (strstr(rx_message, "startbf#") != NULL)
				{
					end_rf = 1;
					p->len = p->len - 8;
#ifdef DEEP_DEBUG
					xil_printf("Received startbf# command!\n\r");
#endif
				}
			}
			else if (op_mode == MODE_STRM)
			{
				// First check for "sendnappes#" at the end of the packet
				memcpy(rx_message, p->payload + p->len - 11, 11);
				rx_message[11] = '\0';
				if (strstr(rx_message, "sendnappes#") != NULL)
				{
					end_rf = 1;
					p->len = p->len - 11;
#ifdef DEEP_DEBUG
					xil_printf("Received sendnappes# command!\n\r");
#endif
				}
			}
			// Then check for anything else or anything before
			if (p->len > 0)
			{
				// Input RF sample from the Ethernet port
				volatile u32 input_rf_sample = 0;

				// First check if there are 1-3 leftover bytes from the previous packet, and if so,
				// add them in together with the first bytes of this packet
				for (int i = 0; i < 4; i ++)
				{
					// The first few bytes of the word may be leftovers
					if (i < leftover_bytes)
						input_rf_sample = input_rf_sample + (leftovers[i] << 8 * i);
					// The rest come from the packet
					else
						input_rf_sample = input_rf_sample + (((u_char *)p->payload)[i - leftover_bytes] << 8 * i);
				}
				Xil_Out32(BEAMFORMER_BRAM_REG, input_rf_sample);
#ifdef DEEP_DEBUG
				if ((counter % 64) < 30)
					// TODO does not handle negative samples (also below)
					xil_printf("Programmed sample %d %0d.%0d\n\r", counter, input_rf_sample / 4, (input_rf_sample & 0x3) * 25);
				if (counter % 2048 == 0)
					xil_printf("Programmed sample %d\n\r", counter);
				int status2_reg_value = (int)Xil_In32(BEAMFORMER_STATUS2_REG);
				xil_printf("Beamformer status2: 0x%08x\n\r", status2_reg_value);
#endif
				counter ++;

				// Now that this is done, pretend that the packet we got has fewer bytes
				p->payload = p->payload + (4 - leftover_bytes);
				p->len = p->len - (4 - leftover_bytes);
				// Now work on the samples arrived with this packet
				for (int i = 0; i < p->len / 4; i ++)
				{
					// TODO there should be a faster way to do this manipulation
					input_rf_sample = ((u_char *)p->payload)[i * 4] | ((u_char *)p->payload)[i * 4 + 1] << 8 | ((u_char *)p->payload)[i * 4 + 2] << 16 | ((u_char *)p->payload)[i * 4 + 3] << 24;
					Xil_Out32(BEAMFORMER_BRAM_REG, input_rf_sample);
#ifdef DEEP_DEBUG
					if ((counter % 64) < 30)
						xil_printf("Programmed sample %d %0d.%0d\n\r", counter, input_rf_sample / 4, (input_rf_sample & 0x3) * 25);
#endif
					// TODO this useless printf fixes the transition from a streaming image to a UBLZ image
					if (counter % 32768 == 0)
					{
						int status_reg_value = (int)Xil_In32(BEAMFORMER_STATUS_REG);
						// The ready counter is in the 16 MSBs
						ready_nappe_count = (status_reg_value & 0xFFFF0000) >> 16;
						int status2_reg_value = (int)Xil_In32(BEAMFORMER_STATUS2_REG);
						xil_printf("Programmed sample %d; reached offset %d and nappe %d\n\r", counter, status2_reg_value & 0x0000FFFF, ready_nappe_count);
					}
//#endif
					counter ++;
				}
				// Finally, remember any leftovers from this packet to merge into the next one
				leftover_bytes = 0;
				for (int i = (p->len / 4) * 4; i < p->len; i ++)
				{
					leftovers[leftover_bytes] = ((u_char *)p->payload)[i];
					leftover_bytes ++;
				}
			}
			// At the end of the reception of RF data
			if (end_rf == 1)
			{
#ifdef DEEP_DEBUG
				int status2_reg_value = (int)Xil_In32(BEAMFORMER_STATUS2_REG);
				int status3_reg_value = (int)Xil_In32(BEAMFORMER_STATUS3_REG);
				xil_printf("In total, written %d samples, status2 = 0x%08x status3 = 0x%08x\n\r", counter, status2_reg_value, status3_reg_value);
#endif
				counter = 0;
				if (op_mode == MODE_UBLZ)
				{
					send_ok(tpcb);
					state = RUNNINGBF;
					run_beamformer();
#ifdef DEEP_DEBUG
					xil_printf("Moving to new state RUNNINGBF\n\r");
#endif
				}
				else if (op_mode == MODE_STRM)
				{
					state = WAITINGBF;
#ifdef DEEP_DEBUG
					xil_printf("Moving to new state WAITINGBF\n\r");
#endif
				}
			}
		break;
		case RUNNINGBF:
			memcpy(rx_message, p->payload + p->len - 11, 11);
			rx_message[11] = '\0';
			if (strstr(rx_message, "sendnappes#") != NULL)
			{
				state = SENDINGNAPPES;
#ifdef DEEP_DEBUG
				xil_printf("Moving to new state SENDINGNAPPES\n\r");
#endif
			}
			else if (strstr(rx_message, "sendrf#") != NULL)
			{
				state = RECEIVEDOPTIONS;
				send_ok(tpcb);
#ifdef DEEP_DEBUG
				xil_printf("Moving to new state RECEIVEDOPTIONS\n\r");
#endif
			}
			break;
		case WAITINGBF:
			// Do nothing. The main detects we are in this state and keeps checking
			// for nappe readiness, then takes the FSM into SENDINGNAPPES. That is done
			// out-of-thread to avoid lockups (lengthy while() polling makes Ethernet unresponsive)
			break;
		case SENDINGNAPPES:
			// Do nothing. The main detects we are in this state and sends
			// data out, then takes the FSM out of this state. That is done
			// out-of-thread to avoid memory allocation problems
			break;
		default:
			break;
	}

	/* free the received pbuf */
	pbuf_free(p);

	return ERR_OK;
}

// This function starts the beamformer and waits until there's valid voxels on the output.
err_t run_beamformer()
{
	err_t err = 0;
	int status_reg_value = (int)Xil_In32(BEAMFORMER_STATUS_REG);
	// bit [0]
	int ready_bit = status_reg_value & 0x00000001;
#ifdef DEEP_DEBUG
	// bit [1]
	int busy_bit = (status_reg_value & 0x00000002) >> 1;
#endif
	if (ready_bit == 0)
	{
		err = 1;
		xil_printf("ERROR: Beamformer is not ready at RECEIVINGRF! Status: %d\n\r", status_reg_value);
	}
#ifdef DEEP_DEBUG
	else
	{
		xil_printf("Beamformer is ready at RECEIVINGRF, status: 0x%x\n\r", status_reg_value);
		xil_printf("Telling beamformer to start a nappe... ");
	}
#endif

	if (op_mode == MODE_UBLZ)
	{
		// Run until we reach the next nappe needing fresh RF data
		while (abs_current_nappe < abs_next_rf_nappe || (abs_current_nappe > 32768 && abs_next_rf_nappe < 32768))
		{
			// This command tells the beamformer to start calculating
			Xil_Out32(BEAMFORMER_COMMAND_REG, 1);

			// Wait until there are nappes in the output buffer of the beamformer
			while (ready_nappe_count == abs_current_nappe)
			{
				status_reg_value = (int)Xil_In32(BEAMFORMER_STATUS_REG);
				// The ready counter is in the 16 MSBs
				ready_nappe_count = (status_reg_value & 0xFFFF0000) >> 16;
			}

			// We have moved one up
			abs_current_nappe = ready_nappe_count;
		}
	}
	else if (op_mode == MODE_STRM || op_mode == MODE_FIFO)
	{
		// Run until we reach the next nappe needing fresh RF data
		ready_nappe_count = 0;
		do
		{
			status_reg_value = (int)Xil_In32(BEAMFORMER_STATUS_REG);
#ifdef DEEP_DEBUG
			int status2_reg_value = (int)Xil_In32(BEAMFORMER_STATUS2_REG);
			int status3_reg_value = (int)Xil_In32(BEAMFORMER_STATUS3_REG);
			int status4_reg_value = (int)Xil_In32(BEAMFORMER_STATUS4_REG);
			int status5_reg_value = (int)Xil_In32(BEAMFORMER_STATUS5_REG);
			xil_printf("Still waiting, at nappe %d of target %d, status2 %08x, status3 %08x, status4 %08x, status5 %08x\n\r", ready_nappe_count, abs_next_rf_nappe, status2_reg_value, status3_reg_value, status4_reg_value, status5_reg_value);
#endif
			// The ready counter is in the 16 MSBs
			ready_nappe_count = (status_reg_value & 0xFFFF0000) >> 16;

		} while (ready_nappe_count < abs_next_rf_nappe || (ready_nappe_count > 32768 && abs_next_rf_nappe < 32768));
	
		abs_current_nappe = ready_nappe_count;
	}

#ifdef DEEP_DEBUG
	int status2_reg_value = (int)Xil_In32(BEAMFORMER_STATUS2_REG);
	int status3_reg_value = (int)Xil_In32(BEAMFORMER_STATUS3_REG);
	int status4_reg_value = (int)Xil_In32(BEAMFORMER_STATUS4_REG);
	int status5_reg_value = (int)Xil_In32(BEAMFORMER_STATUS5_REG);
	xil_printf("Nappe %d reached, status 0x%08x, status2 0x%08x, status3 0x%08x, status4 0x%08x, status5 0x%08x\n\r", ready_nappe_count, status_reg_value, status2_reg_value, status3_reg_value, status4_reg_value, status5_reg_value);
	// bit [1]
	busy_bit = (status_reg_value & 0x00000002) >> 1;
	// bit [0]
	ready_bit = status_reg_value & 0x00000001;
	if (busy_bit == 1 && ready_bit == 1)
	{
		xil_printf("ERROR: Beamformer claims to be both busy and ready!\n\r");
		err = 2;
	}
	if (busy_bit == 0 && ready_bit == 0)
	{
		xil_printf("ERROR: Beamformer claims to be neither busy nor ready!\n\r");
		err = 3;
	}
#endif
	return err;
}

// This function reads voxels from the beamformer and sends them out over the Ethernet.
int send_nappes(struct tcp_pcb *tpcb, int prev_sent_voxels)
{
#ifdef DEEP_DEBUG
	xil_printf("Sending out as requested nappe %d from address %x (previous count is %d)\n\r", rel_current_nappe, mem_pointer, prev_sent_voxels);
#endif
	// Read out all the nappe data. Place a limit on the amount we read out so we
	// don't overflow the TCP buffers
	int voxels_to_send = TCP_MSS / 4;
	if (prev_sent_voxels + voxels_to_send > ELEVATION_LINES * AZIMUTH_LINES)
		voxels_to_send = ELEVATION_LINES * AZIMUTH_LINES - prev_sent_voxels;
	int total_sent_voxels = prev_sent_voxels + voxels_to_send;

#ifdef DEEP_DEBUG
	xil_printf("Sending now %d voxels\n\r", voxels_to_send);
#endif
#ifdef DEEP_DEBUG
	if (prev_sent_voxels == 0)
	{
		int *int_ptr = (int *)mem_pointer;
		for (int deb = 0; deb < 30; deb ++)
			xil_printf("Returning from %x sample %d: %0d.%0d\n\r", int_ptr, deb, int_ptr[deb] / 4, (int_ptr[deb] & 0x3) * 25);
	}
#endif

	// mem_pointer points to a location in external memory where the beamformer
	// stores the finished nappes. After every transfer, increase the pointer.
	err_t err = tcp_write(tpcb, mem_pointer, voxels_to_send * 4, 1);
	if (err != 0)
		xil_printf("ERROR: transmission error %d\n\r", err);
	tcp_output(tpcb);
	mem_pointer = mem_pointer + voxels_to_send * 4;

	if (total_sent_voxels == ELEVATION_LINES * AZIMUTH_LINES)
	{
#ifdef DEEP_DEBUG
		xil_printf("Sending nappe %d done!\n\r", rel_current_nappe + 1);
		int status_reg_value = (int)Xil_In32(BEAMFORMER_STATUS_REG);
		// The ready counter is in the 16 MSBs
		int ready_nappe_count = (status_reg_value & 0xFFFF0000) >> 16;
		// bit [1]
		int busy_bit = (status_reg_value & 0x00000002) >> 1;
		// bit [0]
		int ready_bit = status_reg_value & 0x00000001;
		if (busy_bit == 1 && ready_bit == 1)
			xil_printf("ERROR: Beamformer claims to be both busy and ready!\n\r");
		if (busy_bit == 0 && ready_bit == 0)
			xil_printf("ERROR: Beamformer claims to be neither busy nor ready!\n\r");
#endif

		// Reset this counter for the next nappe.
		total_sent_voxels = 0;
		send_ok(tpcb);
		if (rel_current_nappe == RADIAL_LINES - 1)
		{
			rel_current_nappe = 0;
			// Reset the memory pointer to the beginning of the volume
			mem_pointer = (void *)NAPPE_MEMORY;
			state = AWAITING;
#ifdef DEEP_DEBUG
			xil_printf("Moving to new state AWAITING\n\r");
			int status_reg_value = (int)Xil_In32(BEAMFORMER_STATUS_REG);
			int status2_reg_value = (int)Xil_In32(BEAMFORMER_STATUS2_REG);
			int status3_reg_value = (int)Xil_In32(BEAMFORMER_STATUS3_REG);
			int status4_reg_value = (int)Xil_In32(BEAMFORMER_STATUS4_REG);
			int status5_reg_value = (int)Xil_In32(BEAMFORMER_STATUS5_REG);
			xil_printf("Beamformer status just after last nappe: 0x%08x, 0x%08x, 0x%08x, 0x%08x, 0x%08x\n\r", status_reg_value, status2_reg_value, status3_reg_value, status4_reg_value, status5_reg_value);
#endif
		}
		else
			rel_current_nappe ++;
	}

	return total_sent_voxels;
}

err_t accept_callback(void *arg, struct tcp_pcb *newpcb, err_t err)
{
	static int connection = 1;

	/* set the receive callback for this connection */
	tcp_recv(newpcb, recv_callback);

	/* just use an integer number indicating the connection id as the
	   callback argument */
	tcp_arg(newpcb, (void*)(UINTPTR)connection);

	/* increment for subsequent accepted connections */
	connection++;

	return ERR_OK;
}

int start_application()
{
	err_t err;
	unsigned port = 7;

	/* create new TCP PCB structure */
	struct tcp_pcb *pcb = tcp_new();
	if (!pcb) {
		xil_printf("ERROR: Out of memory while creating PCB!\n\r");
		return -1;
	}

	/* bind to specified @port */
	err = tcp_bind(pcb, IP_ADDR_ANY, port);
	if (err != ERR_OK) {
		xil_printf("ERROR: Unable to bind to port %d: err = %d\n\r", port, err);
		return -2;
	}

	/* we do not need any arguments to callback functions */
	tcp_arg(pcb, NULL);

	/* listen for connections */
	pcb = tcp_listen(pcb);
	if (!pcb) {
		xil_printf("ERROR: Out of memory while tcp_listen\n\r");
		return -3;
	}

	/* specify callback to use for incoming connections */
	tcp_accept(pcb, accept_callback);

	xil_printf("Application started @ port %d\n\r", port);

	state = AWAITING;
#ifdef DEEP_DEBUG
	xil_printf("Moving to new state AWAITING\n\r");
	int status_reg_value = (int)Xil_In32(BEAMFORMER_STATUS_REG);
	int status2_reg_value = (int)Xil_In32(BEAMFORMER_STATUS2_REG);
	int status3_reg_value = (int)Xil_In32(BEAMFORMER_STATUS3_REG);
	int status4_reg_value = (int)Xil_In32(BEAMFORMER_STATUS4_REG);
	int status5_reg_value = (int)Xil_In32(BEAMFORMER_STATUS5_REG);
	xil_printf("Beamformer status just after boot: 0x%08x, 0x%08x, 0x%08x, 0x%08x, 0x%08x\n\r", status_reg_value, status2_reg_value, status3_reg_value, status4_reg_value, status5_reg_value);
#endif

	// White-out the target memory area, to help with debugging possible problems.
	mem_pointer = (void *)NAPPE_MEMORY;
	for (int count = 0; count < AZIMUTH_LINES * RADIAL_LINES * 4; count ++)
	{
		*(char *)mem_pointer = 0xff;
		mem_pointer ++;
	}
	mem_pointer = (void *)NAPPE_MEMORY;

	return 0;
}

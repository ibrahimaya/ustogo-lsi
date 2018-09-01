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
#include "xparameters.h"
#include "netif/xadapter.h"
#include "platform.h"
#include "platform_config.h"
#if defined (__arm__) || defined(__aarch64__)
#include "xil_printf.h"
#endif
#include "lwip/tcp.h"
#include "xil_cache.h"
#if LWIP_DHCP==1
#include "lwip/dhcp.h"
#endif
#include "xil_io.h"

#include "echo.h"
#include "params.h"

/* defined by each RAW mode application */
void print_app_header();
int start_application();
int transfer_data();
void tcp_fasttmr(void);
void tcp_slowtmr(void);

/* missing declaration in lwIP */
void lwip_init();

#if LWIP_DHCP==1
extern volatile int dhcp_timoutcntr;
err_t dhcp_start(struct netif *netif);
#endif

extern volatile int TcpFastTmrFlag;
extern volatile int TcpSlowTmrFlag;
static struct netif server_netif;
struct netif *echo_netif;

void
print_ip(char *msg, struct ip_addr *ip) 
{
	print(msg);
	xil_printf("%d.%d.%d.%d\n\r", ip4_addr1(ip), ip4_addr2(ip), 
			ip4_addr3(ip), ip4_addr4(ip));
}

void
print_ip_settings(struct ip_addr *ip, struct ip_addr *mask, struct ip_addr *gw)
{

	print_ip("Board IP: ", ip);
	print_ip("Netmask : ", mask);
	print_ip("Gateway : ", gw);
}

#if defined (__arm__) && !defined (ARMR5)
#if XPAR_GIGE_PCS_PMA_SGMII_CORE_PRESENT == 1 || XPAR_GIGE_PCS_PMA_1000BASEX_CORE_PRESENT == 1
int ProgramSi5324(void);
int ProgramSfpPhy(void);
#endif
#endif
int main()
{
	/* Initialize ICache */
	Xil_ICacheInvalidate ();
	Xil_ICacheEnable ();
	/* Initialize DCache */
	Xil_DCacheInvalidate ();
	Xil_DCacheEnable ();
	struct ip_addr ipaddr, netmask, gw;
	/* the mac address of the board. this should be unique per board */
	unsigned char mac_ethernet_address[] =
	{ 0x00, 0x0a, 0x35, 0x00, 0x01, 0x02 };

	echo_netif = &server_netif;
#if defined (__arm__) && !defined (ARMR5)
#if XPAR_GIGE_PCS_PMA_SGMII_CORE_PRESENT == 1 || XPAR_GIGE_PCS_PMA_1000BASEX_CORE_PRESENT == 1
	ProgramSi5324();
	ProgramSfpPhy();
#endif
#endif

	init_platform();

#if LWIP_DHCP==1
    ipaddr.addr = 0;
	gw.addr = 0;
	netmask.addr = 0;
#else
	/* initialize IP addresses to be used */
	IP4_ADDR(&ipaddr,  192, 168,   1, 10);
	IP4_ADDR(&netmask, 255, 255, 255,  0);
	IP4_ADDR(&gw,      192, 168,   1,  1);
#endif	

	lwip_init();

  	/* Add network interface to the netif_list, and set it as default */
	if (!xemac_add(echo_netif, &ipaddr, &netmask,
						&gw, mac_ethernet_address,
						PLATFORM_EMAC_BASEADDR)) {
		xil_printf("Error adding N/W interface\n\r");
		return -1;
	}
	netif_set_default(echo_netif);

	/* now enable interrupts */
	platform_enable_interrupts();

	/* specify that the network if is up */
	netif_set_up(echo_netif);

#if (LWIP_DHCP==1)
	/* Create a new DHCP client for this interface.
	 * Note: you must call dhcp_fine_tmr() and dhcp_coarse_tmr() at
	 * the predefined regular intervals after starting the client.
	 */
	dhcp_start(echo_netif);
	dhcp_timoutcntr = 24;

	while(((echo_netif->ip_addr.addr) == 0) && (dhcp_timoutcntr > 0))
		xemacif_input(echo_netif);

	if (dhcp_timoutcntr <= 0) {
		if ((echo_netif->ip_addr.addr) == 0) {
			xil_printf("DHCP Timeout\r\n");
			xil_printf("Configuring default IP of 192.168.1.10\r\n");
			IP4_ADDR(&(echo_netif->ip_addr),  192, 168,   1, 10);
			IP4_ADDR(&(echo_netif->netmask), 255, 255, 255,  0);
			IP4_ADDR(&(echo_netif->gw),      192, 168,   1,  1);
		}
	}

	ipaddr.addr = echo_netif->ip_addr.addr;
	gw.addr = echo_netif->gw.addr;
	netmask.addr = echo_netif->netmask.addr;
#endif

	print_ip_settings(&ipaddr, &netmask, &gw);

	/* start the application (web server, rxtest, txtest, etc..) */
	start_application();

	/* receive and process packets */
	int transmitted_voxels = 0;
	while (1)
	{
		// TODO it looks like this code belongs somewhere else,
		// but putting it into the receive handler locks the application up
		// (maybe memory allocation issues)
		if (state == WAITINGBF)
		{
			int status_reg_value = (int)Xil_In32(BEAMFORMER_STATUS_REG);
			// The ready counter is in the 16 MSBs
			int ready_nappe_count = (status_reg_value & 0xFFFF0000) >> 16;
#ifdef DEEP_DEBUG
			int status2_reg_value = (int)Xil_In32(BEAMFORMER_STATUS2_REG);
			int status3_reg_value = (int)Xil_In32(BEAMFORMER_STATUS3_REG);
			int status4_reg_value = (int)Xil_In32(BEAMFORMER_STATUS4_REG);
			int status5_reg_value = (int)Xil_In32(BEAMFORMER_STATUS5_REG);
			xil_printf("Still waiting, at nappe %d of target %d, status 0x%08x, status2 0x%08x, status3 0x%08x, status4 0x%08x, status5 0x%08x\n\r", ready_nappe_count, abs_next_rf_nappe, status_reg_value, status2_reg_value, status3_reg_value, status4_reg_value, status5_reg_value);
#endif
			if (ready_nappe_count >= abs_next_rf_nappe && (ready_nappe_count < 32768 || abs_next_rf_nappe > 32768))
			{
				abs_current_nappe = abs_next_rf_nappe;
#ifdef DEEP_DEBUG
				int status2_reg_value = (int)Xil_In32(BEAMFORMER_STATUS2_REG);
				int status3_reg_value = (int)Xil_In32(BEAMFORMER_STATUS3_REG);
				int status4_reg_value = (int)Xil_In32(BEAMFORMER_STATUS4_REG);
				int status5_reg_value = (int)Xil_In32(BEAMFORMER_STATUS5_REG);
				xil_printf("Nappe %d reached, status 0x%08x, status2 0x%08x, status3 0x%08x, status4 0x%08x, status5 0x%08x\n\r", ready_nappe_count, status_reg_value, status2_reg_value, status3_reg_value, status4_reg_value, status5_reg_value);
#endif
				state = SENDINGNAPPES;
			}
		}
		else if (state == SENDINGNAPPES)
		{
			// Send out a packet of nappe voxels. "transmitted_voxels" accumulates the count of
			// how many voxels have gone. When "transmitted_voxels" reaches the end of the nappe,
			// the function send_nappes itself will finalize the transmission and
			// reset "transmitted_voxels" to 0.
			// TODO the check below is quite unclear and numbers are hardcoded
			if (4 * 365 < pcb2->snd_buf && pcb2->snd_queuelen * 2 < TCP_SND_QUEUELEN)
				transmitted_voxels = send_nappes(pcb2, transmitted_voxels);
		}

		if (TcpFastTmrFlag) {
			tcp_fasttmr();
			TcpFastTmrFlag = 0;
		}
		if (TcpSlowTmrFlag) {
			tcp_slowtmr();
			TcpSlowTmrFlag = 0;
		}
		xemacif_input(echo_netif);
		//transfer_data();
	}

	/* never reached */
	cleanup_platform();

	return 0;
}

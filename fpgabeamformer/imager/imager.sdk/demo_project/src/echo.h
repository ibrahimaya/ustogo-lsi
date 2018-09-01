/*
 * echo.h
 *
 *  Created on: Oct 4, 2016
 *      Author: mitsumono
 */

#ifndef SRC_ECHO_H_
#define SRC_ECHO_H_

#include "lwip/err.h"
#include "lwip/tcp.h"

// Enable this #define for additional debug messages
//#define DEEP_DEBUG 1

struct tcp_pcb *pcb2;

enum fsm_state {
  AWAITING,
  RECEIVEDOPTIONS,
  RECEIVEDLENGTH,
  RECEIVINGRF,
  RUNNINGBF,
  WAITINGBF,
  SENDINGNAPPES
};

enum fsm_state state;
int abs_current_nappe;
int abs_next_rf_nappe;

enum OPMODE {
  MODE_FIFO,
  MODE_STRM,
  MODE_UBLZ
};

err_t run_beamformer();
int send_nappes(struct tcp_pcb *tpcb, int k);
err_t end_nappe(struct tcp_pcb *tpcb);
void compound();

#endif /* SRC_ECHO_H_ */


#ifndef _TSEV_IRQ_OPS_H
#define _TSEV_IRQ_OPS_H

#include <linux/kernel.h>
#include <linux/interrupt.h>

#include "tsev_private.h"

/*
** ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
*/

irqreturn_t tsev_irq_dpc(int irq, void* hDvc);
irqreturn_t tsev_irq_handler(int irq, void* hDvc);
void        tsev_irq_init(pT_TSEV_DEVICE pDvc);

#endif

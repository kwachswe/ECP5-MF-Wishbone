
#include "tsev_irq_ops.h"

//
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//          tsev_irq_dpc
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//
irqreturn_t tsev_irq_dpc(int irq, void* hDvc) {
   pT_TSEV_DEVICE     _pDvc;


   printk(KERN_INFO "ea90_dma: tsev_irq_dpc()");

   _pDvc    = (pT_TSEV_DEVICE)hDvc;

   printk(KERN_INFO "ea90_dma: Fifo Count = %0x\n", ioread32(&_pDvc->addrBaseRegs->hpDmaRegs.regFifoCount));
   printk(KERN_INFO "ea90_dma: CmdSta = 0x%08x\n", ioread32(&_pDvc->addrBaseRegs->hpDmaRegs.regCmdSta));
   
   while (!(ioread32(&_pDvc->addrBaseRegs->hpDmaRegs.regCmdSta) & TSEV_DMA_STA_DP_EMPTY)) {}
   
   iowrite8(1 << (TSEV_BPOS_DMA_INT_ACK - 8), ((u8*)&_pDvc->addrBaseRegs->hpDmaRegs.regCmdSta) + (TSEV_BPOS_DMA_INT_ACK / 8));  
   
   if (_pDvc->mUseMSI < 0) 
      iowrite8(ioread8((u8*)&_pDvc->addrBaseRegs->hpDmaRegs.regCmdSta) | (u8)TSEV_DMA_CMD_INT_EN, (u8*)&_pDvc->addrBaseRegs->hpDmaRegs.regCmdSta);         
   
   complete(&_pDvc->mDmaState);
   return IRQ_HANDLED;
   }
   

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//          tsev_irq_handler
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
irqreturn_t tsev_irq_handler(int irq, void* hDvc) {

   unsigned long        _IrqFlags;
   pT_TSEV_DEVICE       _pDvc;


   _pDvc    = (pT_TSEV_DEVICE)hDvc;
   
   spin_lock_irqsave(&_pDvc->mLockDvc, _IrqFlags);
   
   if (_pDvc->mUseMSI < 0) {
      if (! (ioread32(&_pDvc->addrBaseRegs->hpDmaRegs.regCmdSta) & TSEV_DMA_CMD_INT_REQ))
         return IRQ_NONE;
      else 
         iowrite8(ioread8((u8*)&_pDvc->addrBaseRegs->hpDmaRegs.regCmdSta) & (u8)~TSEV_DMA_CMD_INT_EN, (u8*)&_pDvc->addrBaseRegs->hpDmaRegs.regCmdSta);         
      }
   
   spin_unlock_irqrestore(&_pDvc->mLockDvc, _IrqFlags);
   
   return IRQ_WAKE_THREAD;
   }

/*
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//          tsev_irq_init
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
*/
void tsev_irq_init(pT_TSEV_DEVICE pDvc) {


   }

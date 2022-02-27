
#include "tsev_file_ops.h"

extern T_TSEV_DRV   ea90_dma;

/*
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//          tsev_fopen
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
*/
int tsev_fopen(struct inode* inode, struct file* fp) {
   
   pT_TSEV_FILE_CTX     _pFileCtx;

   
   _pFileCtx = (pT_TSEV_FILE_CTX)kmalloc(sizeof(T_TSEV_FILE_CTX), GFP_KERNEL);
   memset((void*)_pFileCtx, 0, sizeof(T_TSEV_FILE_CTX));

   _pFileCtx->pTsevDvc  = &ea90_dma.tsevDevice[iminor(inode)];

   fp->private_data  = _pFileCtx;
   
   return 0;   
   }

/*
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//          tsev_fclose
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
*/
int tsev_fclose(struct inode* inode, struct file* fp) {
   
   pT_TSEV_FILE_CTX     _pFileCtx;

   
   _pFileCtx         = fp->private_data;
   fp->private_data  = NULL;
   kfree(_pFileCtx);
   
   return 0;
   }

/*
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//          tsev_fread
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
*/
ssize_t tsev_fread(struct file *fp, char __user *userBuf, size_t len, loff_t *offp) {
   int               ix;
   int                  _MapCount;
   unsigned long        _NumPages;
   u32                  _RegDmaHadrHigh;
   dma_addr_t           _SgAdr;
   u32                  _SgHaddrHigh;
   u32                  _SgLength;   
   u32                  _XferFlags;
   ssize_t              _XferSz = 0;
   struct page*         _pCurPage;
   u8*                  _pDmaBuf;
   pT_TSEV_DEVICE       _pDvc;
   pT_TSEV_FILE_CTX     _pFileCtx;
   struct scatterlist*  _pSgList;
   void __user*         _pUserBuf;


   printk(KERN_INFO "ea90_dma: tsev_fread()\n");
   
   _pFileCtx         = fp->private_data;
   _pDvc             = _pFileCtx->pTsevDvc;   

	_NumPages         = (len / PAGE_SIZE) + ((len % PAGE_SIZE) == 0 ? 0 : 1);
   _pUserBuf         = (void __user *)userBuf;

   
   _pDmaBuf    = (u8*)vmalloc(len);
   if (!_pDmaBuf) {
      printk(KERN_ERR "ea90_dma: Could not allocate DMA copy-buffer for transfer from Device\n");
      return 0;
      }
   
   _pSgList = vmalloc(_NumPages * sizeof(struct scatterlist));
   printk(KERN_INFO "ea90_dma: vmalloc _pSgList returns %x\n", ((u32)_pSgList & 0xFFFFFFFF));

   sg_init_table(_pSgList, _NumPages);
   
      // Lock the buffer pages in memory
   for (ix = 0; ix < _NumPages; ix++) {
      _pCurPage   = vmalloc_to_page((void*)(_pDmaBuf + (ix * PAGE_SIZE)));
      lock_page(_pCurPage);
      sg_set_page(&_pSgList[ix], _pCurPage, PAGE_SIZE, 0);
      }   
   
#ifdef CONFIG_X86_64
   _MapCount   = pci_map_sg(_pDvc->pPciDev, _pSgList, _NumPages, PCI_DMA_FROMDEVICE);
#else
   _MapCount   = dma_map_sg(&_pDvc->pPciDev->dev, _pSgList, _NumPages, PCI_DMA_FROMDEVICE);
#endif

   printk(KERN_INFO "ea90_dma: pci_map_sg MapCount = 0x%08x\n", _MapCount);

   iowrite8((1 << (TSEV_BPOS_DMA_CMD_CLR - 8)) |
            (1 << (TSEV_BPOS_DMA_INT_ACK - 8)), ((u8*)&_pDvc->addrBaseRegs->hpDmaRegs.regCmdSta) + (TSEV_BPOS_DMA_CMD_CLR / 8));
   
   mb();
   iowrite32(CVAL_REG_ALL_CLR,         &_pDvc->addrBaseRegs->hpDmaRegs.regHostAdrHigh);
   iowrite32(CVAL_REG_ALL_CLR,         &_pDvc->addrBaseRegs->hpDmaRegs.regHostAdrLow);
   iowrite32(TSEV_DMA_ATTRIB_HOST_WR,  &_pDvc->addrBaseRegs->hpDmaRegs.regXferFlags);
   iowrite32(CVAL_REG_ALL_CLR,         &_pDvc->addrBaseRegs->hpDmaRegs.regLocalAdr);
   iowrite32(CVAL_REG_ALL_CLR,         &_pDvc->addrBaseRegs->hpDmaRegs.regCmdSta);
   
   mb();
   _RegDmaHadrHigh   = CVAL_REG_ALL_CLR;
   _XferFlags        = CVAL_REG_ALL_CLR;
   
   printk(KERN_INFO "ea90_dma: Fifo Count = %0x\n", ioread32(&_pDvc->addrBaseRegs->hpDmaRegs.regFifoCount));
   printk(KERN_INFO "ea90_dma: CmdSta = 0x%08x\n", ioread32(&_pDvc->addrBaseRegs->hpDmaRegs.regCmdSta));

   mb();
   
   for (ix = 0; ix < _MapCount; ix++) {
      _SgAdr      = sg_dma_address(&_pSgList[ix]);
      _SgLength   = sg_dma_len(&_pSgList[ix]);
      mb();

      _SgHaddrHigh   = (u32)(_SgAdr >> 32);
      
      if (ix == (_MapCount - 1)) {
         iowrite32(ioread32(&_pDvc->addrBaseRegs->hpDmaRegs.regXferFlags) | TSEV_DMA_ATTRIB_SEQ_LAST, &_pDvc->addrBaseRegs->hpDmaRegs.regXferFlags);
         printk(KERN_INFO "ea90_dma : XferFlags = 0x%08x\n", ioread32(&_pDvc->addrBaseRegs->hpDmaRegs.regXferFlags));
         }
         
      iowrite32((u32)(_SgAdr & 0xffffffff), &_pDvc->addrBaseRegs->hpDmaRegs.regHostAdrLow);
      iowrite32(_SgHaddrHigh, &_pDvc->addrBaseRegs->hpDmaRegs.regHostAdrHigh);
      iowrite32(_SgLength, &_pDvc->addrBaseRegs->hpDmaRegs.regXferSize);
      mb();
      iowrite8(1 << (TSEV_BPOS_DMA_CMD_PUSH - 8), ((u8*)&_pDvc->addrBaseRegs->hpDmaRegs.regCmdSta) + (TSEV_BPOS_DMA_CMD_PUSH / 8));

      printk(KERN_INFO "ea90_dma : Push Adr_H = %0x, Adr_L = %0x, count = %d\n", 
             (u32)(_SgAdr >> 32), (u32)(_SgAdr & 0xffffffff), _SgLength);
      
      mb();      
      }
   
	init_completion(&_pDvc->mDmaState);
   mb();

   printk(KERN_INFO "ea90_dma (1): Fifo Count = %0x\n", ioread32(&_pDvc->addrBaseRegs->hpDmaRegs.regFifoCount));
   printk(KERN_INFO "ea90_dma (1): CmdSta = 0x%08x\n", ioread32(&_pDvc->addrBaseRegs->hpDmaRegs.regCmdSta));
   
   iowrite8(TSEV_DMA_CMD_INT_DIS_LFE | TSEV_DMA_CMD_INT_DIS_HFE, (u8*)&_pDvc->addrBaseRegs->hpDmaRegs.regCmdSta);
   mb();
   iowrite8(TSEV_DMA_CMD_INT_DIS_LFE | TSEV_DMA_CMD_INT_DIS_HFE | TSEV_DMA_CMD_INT_EN | TSEV_DMA_CMD_EN, (u8*)&_pDvc->addrBaseRegs->hpDmaRegs.regCmdSta);
      
   printk(KERN_INFO "ea90_dma (2): Fifo Count = %0x\n", ioread32(&_pDvc->addrBaseRegs->hpDmaRegs.regFifoCount));
   printk(KERN_INFO "ea90_dma (2): CmdSta = 0x%08x\n", ioread32(&_pDvc->addrBaseRegs->hpDmaRegs.regCmdSta));
   
   wait_for_completion_timeout(&_pDvc->mDmaState, msecs_to_jiffies(10000));

   pci_dma_sync_sg_for_cpu(_pDvc->pPciDev, _pSgList, _MapCount, PCI_DMA_FROMDEVICE);
   
   if (copy_to_user(_pUserBuf, _pDmaBuf, len)) {
      printk(KERN_ERR "ea90_dma: Could not copy dma-buffer to user memory\n");
      _XferSz  = 0;
      }   
   else
      _XferSz  = len;
      
      // Unlock the buffer pages in memory
   for (ix = 0; ix < _NumPages; ix++) {
      _pCurPage   = vmalloc_to_page((void*)(_pDmaBuf + (ix * PAGE_SIZE)));
      unlock_page(_pCurPage);
      }  
      
   vfree(_pSgList);
   vfree(_pDmaBuf);
   

   mb();
   printk(KERN_INFO "ea90_dma (3): Fifo Count = %0x\n", ioread32(&_pDvc->addrBaseRegs->hpDmaRegs.regFifoCount));
   printk(KERN_INFO "ea90_dma (3): CmdSta = 0x%08x\n", ioread32(&_pDvc->addrBaseRegs->hpDmaRegs.regCmdSta));
   printk(KERN_INFO "ea90_dma (3): Xfer Pos. = 0x%08x\n", ioread32(&_pDvc->addrBaseRegs->hpDmaRegs.regXferPos));
  
   return _XferSz;
   }

/*
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//          tsev_fwrite
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
*/
ssize_t tsev_fwrite(struct file *fp, const char __user *userBuf, size_t len, loff_t *offp) {

   int               ix;
   int                  _MapCount;
   unsigned long        _NumPages;
   u32                  _RegDmaHadrHigh;
   dma_addr_t           _SgAdr;
   u32                  _SgHaddrHigh;
   u32                  _SgLength;   
   u32                  _XferFlags;
   ssize_t              _XferSz = 0;
   struct page*         _pCurPage;
   u8*                  _pDmaBuf;
   pT_TSEV_DEVICE       _pDvc;
   pT_TSEV_FILE_CTX     _pFileCtx;
   struct scatterlist*  _pSgList;
   void __user*         _pUserBuf;


   printk(KERN_INFO "ea90_dma: tsev_fwrite()\n");
   
   _pFileCtx         = fp->private_data;
   _pDvc             = _pFileCtx->pTsevDvc;   

	_NumPages         = (len / PAGE_SIZE) + ((len % PAGE_SIZE) == 0 ? 0 : 1);
   _pUserBuf         = (void __user *)userBuf;

   
   _pDmaBuf    = (u8*)vmalloc(len);
   if (!_pDmaBuf) {
      printk(KERN_ERR "ea90_dma: Could not allocate DMA copy-buffer for transfer to Device\n");
      return -ENOMEM;
      }
   
   if (copy_from_user(_pDmaBuf, _pUserBuf, len)) {
      printk(KERN_ERR "ea90_dma: Could not copy user buffer to dma-buffer\n");
      return -EFAULT;
      }   
   
   _pSgList = vmalloc(_NumPages * sizeof(struct scatterlist));
   printk(KERN_INFO "ea90_dma: vmalloc _pSgList returns %x\n", ((u32)_pSgList & 0xFFFFFFFF));

   sg_init_table(_pSgList, _NumPages);
   
      // Lock the buffer pages in memory
   for (ix = 0; ix < _NumPages; ix++) {
      _pCurPage   = vmalloc_to_page((void*)(_pDmaBuf + (ix * PAGE_SIZE)));
      lock_page(_pCurPage);
      sg_set_page(&_pSgList[ix], _pCurPage, PAGE_SIZE, 0);
      }   
   
#ifdef CONFIG_X86_64
   _MapCount   = pci_map_sg(_pDvc->pPciDev, _pSgList, _NumPages, PCI_DMA_TODEVICE);
#else
   _MapCount   = dma_map_sg(&_pDvc->pPciDev->dev, _pSgList, _NumPages, PCI_DMA_TODEVICE);
#endif

   printk(KERN_INFO "ea90_dma: pci_map_sg MapCount = 0x%08x\n", _MapCount);

   iowrite8((1 << (TSEV_BPOS_DMA_CMD_CLR - 8)) |
            (1 << (TSEV_BPOS_DMA_INT_ACK - 8)), ((u8*)&_pDvc->addrBaseRegs->hpDmaRegs.regCmdSta) + (TSEV_BPOS_DMA_CMD_CLR / 8));
   
   mb();
   iowrite32(CVAL_REG_ALL_CLR, &_pDvc->addrBaseRegs->hpDmaRegs.regHostAdrHigh);
   iowrite32(CVAL_REG_ALL_CLR, &_pDvc->addrBaseRegs->hpDmaRegs.regHostAdrLow);
   iowrite32(CVAL_REG_ALL_CLR, &_pDvc->addrBaseRegs->hpDmaRegs.regXferFlags);
   iowrite32(CVAL_REG_ALL_CLR, &_pDvc->addrBaseRegs->hpDmaRegs.regLocalAdr);
   iowrite32(CVAL_REG_ALL_CLR, &_pDvc->addrBaseRegs->hpDmaRegs.regCmdSta);
   
    mb(); 
   _RegDmaHadrHigh   = CVAL_REG_ALL_CLR;
   _XferFlags        = CVAL_REG_ALL_CLR;

   printk(KERN_INFO "ea90_dma: Fifo Count = %0x\n", ioread32(&_pDvc->addrBaseRegs->hpDmaRegs.regFifoCount));
   printk(KERN_INFO "ea90_dma: CmdSta = 0x%08x\n", ioread32(&_pDvc->addrBaseRegs->hpDmaRegs.regCmdSta));

   mb();
   
   for (ix = 0; ix < _MapCount; ix++) {
      _SgAdr      = sg_dma_address(&_pSgList[ix]);
      _SgLength   = sg_dma_len(&_pSgList[ix]);
      mb();

      _SgHaddrHigh   = (u32)(_SgAdr >> 32);
      
      if (ix == (_MapCount - 1)) {
         iowrite32(ioread32(&_pDvc->addrBaseRegs->hpDmaRegs.regXferFlags) | TSEV_DMA_ATTRIB_SEQ_LAST, &_pDvc->addrBaseRegs->hpDmaRegs.regXferFlags);
         printk(KERN_INFO "ea90_dma : XferFlags = 0x%08x\n", ioread32(&_pDvc->addrBaseRegs->hpDmaRegs.regXferFlags));
         }
         
      iowrite32((u32)(_SgAdr & 0xffffffff), &_pDvc->addrBaseRegs->hpDmaRegs.regHostAdrLow);
      iowrite32(_SgHaddrHigh, &_pDvc->addrBaseRegs->hpDmaRegs.regHostAdrHigh);
      iowrite32(_SgLength, &_pDvc->addrBaseRegs->hpDmaRegs.regXferSize);
      mb();
      iowrite8(1 << (TSEV_BPOS_DMA_CMD_PUSH - 8), ((u8*)&_pDvc->addrBaseRegs->hpDmaRegs.regCmdSta) + (TSEV_BPOS_DMA_CMD_PUSH / 8));

      printk(KERN_INFO "ea90_dma : Push Adr_H = %0x, Adr_L = %0x, count = %d\n", 
             (u32)(_SgAdr >> 32), (u32)(_SgAdr & 0xffffffff), _SgLength);
      
      mb();      
      }

   pci_dma_sync_sg_for_device(_pDvc->pPciDev, _pSgList, _MapCount, PCI_DMA_TODEVICE);
   
	init_completion(&_pDvc->mDmaState);
   mb();

   printk(KERN_INFO "ea90_dma (1): Fifo Count = %0x\n", ioread32(&_pDvc->addrBaseRegs->hpDmaRegs.regFifoCount));
   printk(KERN_INFO "ea90_dma (1): CmdSta = 0x%08x\n", ioread32(&_pDvc->addrBaseRegs->hpDmaRegs.regCmdSta));
   
   iowrite8(TSEV_DMA_CMD_INT_DIS_LFE | TSEV_DMA_CMD_INT_DIS_HFE, (u8*)&_pDvc->addrBaseRegs->hpDmaRegs.regCmdSta);
   mb();
   iowrite8(TSEV_DMA_CMD_INT_DIS_LFE | TSEV_DMA_CMD_INT_DIS_HFE | TSEV_DMA_CMD_INT_EN | TSEV_DMA_CMD_EN, (u8*)&_pDvc->addrBaseRegs->hpDmaRegs.regCmdSta);
      
   printk(KERN_INFO "ea90_dma (2): Fifo Count = %0x\n", ioread32(&_pDvc->addrBaseRegs->hpDmaRegs.regFifoCount));
   printk(KERN_INFO "ea90_dma (2): CmdSta = 0x%08x\n", ioread32(&_pDvc->addrBaseRegs->hpDmaRegs.regCmdSta));
   
   wait_for_completion_timeout(&_pDvc->mDmaState, msecs_to_jiffies(10000));

      // Unlock the buffer pages in memory
   for (ix = 0; ix < _NumPages; ix++) {
      _pCurPage   = vmalloc_to_page((void*)(_pDmaBuf + (ix * PAGE_SIZE)));
      unlock_page(_pCurPage);
      }  
      
   vfree(_pSgList);
   vfree(_pDmaBuf);
   
   _XferSz  = len;

   mb();
   printk(KERN_INFO "ea90_dma (3): Fifo Count = %0x\n", ioread32(&_pDvc->addrBaseRegs->hpDmaRegs.regFifoCount));
   printk(KERN_INFO "ea90_dma (3): CmdSta = 0x%08x\n", ioread32(&_pDvc->addrBaseRegs->hpDmaRegs.regCmdSta));
   printk(KERN_INFO "ea90_dma (3): Xfer Pos. = 0x%08x\n", ioread32(&_pDvc->addrBaseRegs->hpDmaRegs.regXferPos));
  
   return _XferSz;
   }

/*
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//          tsev_ioctl
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
*/
#if (LINUX_VERSION_CODE < KERNEL_VERSION(2,6,35))
   int tsev_ioctl(struct inode *i, struct file *fp, unsigned int cmd, unsigned long arg) {
#else
   long tsev_ioctl(struct file *fp, unsigned int cmd, unsigned long arg) {
#endif

   return 0;
   }

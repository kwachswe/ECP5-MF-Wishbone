/*
    /usr/src/linux/include/linux
*/

#include <linux/init.h>
#include <linux/module.h>
#include <linux/version.h>
#include <linux/kernel.h>

#include <linux/cdev.h>
#include <linux/mm.h>
#include <linux/pagemap.h>
#include <linux/pci.h>
#include <linux/proc_fs.h>
#include <linux/seq_file.h>

//#include "ea90_dma_public.h"
#include "tsev_private.h"
#include "tsev_file_ops.h"
#include "tsev_irq_ops.h"

#ifndef CONFIG_PCI
   #error No PCI Bus Support in kernel!
#endif

/*
** ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
*/

#define USE_PROC  /* For debugging  */

/*
** ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
*/

MODULE_AUTHOR("Trellisys Ltd.");
MODULE_DESCRIPTION("High Performance DMA Demo");

/* License this so no annoying messages when loading module */
MODULE_LICENSE("Dual BSD/GPL");

MODULE_ALIAS("ea90_dma");

/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~  */
/*    The driver's global database of all boards and run-time information.    */
/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~  */
T_TSEV_DRV     ea90_dma;

static const char*   DeviceName[2] = {"ea90_dma", "ea90_dma"};

static const char    BuildId[32] = "$LastChangedRevision: 159 $\0\0\0\0";

static struct pci_device_id tsev_id_tbl[] =  {
   { 0x1204, 0xA906, PCI_ANY_ID, PCI_ANY_ID, },    /* TSEV HP-DMA Card    */
   { }                                             /* Terminating entry          */
   };

MODULE_DEVICE_TABLE(pci, tsev_id_tbl);


static int   debug = 0;

module_param(debug, int, 0);
MODULE_PARM_DESC(debug, "ea90_dma enable debugging (0-1)");

/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~  */
/*       Forward declarations                                                 */
/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~  */

static int __init tsev_probe(struct pci_dev  *pdev, const struct pci_device_id   *ent);

static void __exit tsev_remove(struct pci_dev *pdev);


static void tsev_shutdown (struct pci_dev *pdev);

#if LINUX_VERSION_CODE < KERNEL_VERSION(3,11,1)
   static int tsev_proc_read_regs(char *page, char **start, off_t off, int count, int *eof, void *data);
#else
   static int tsev_proc_open(struct inode *inode, struct file *file);
   static int tsev_proc_read_regs(struct seq_file *m, void *v);
#endif

/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~  */

   /*
   // See (e.g.) /usr/src/linux/include/linux/pci.h
   */
static struct pci_driver ea90_dma_driver = {
   .name       = "ea90_dma",
   .id_table   = tsev_id_tbl,
   .probe      = tsev_probe,
   .remove     = __exit_p(tsev_remove),
   .shutdown   = tsev_shutdown,
   };

   /*
   // See (e.g.) /usr/src/linux/include/linux/fs.h
   */
static struct file_operations drvr_fops = {
   .owner   = THIS_MODULE,
   .open    = tsev_fopen,
   .read    = tsev_fread,
   .write   = tsev_fwrite,
   .release = tsev_fclose,
#if (LINUX_VERSION_CODE < KERNEL_VERSION(2,6,35))
   .ioctl   = tsev_ioctl,
#else
   .unlocked_ioctl = tsev_ioctl,
#endif
   };

#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,11,1)
   static const struct file_operations proc_fops = {
      .open           = tsev_proc_open,
      .read           = seq_read,
      .llseek         = seq_lseek,
      .release        = single_release,
      };
#endif

/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~  */
/*          initDevice                                                        */
/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~  */
static pT_TSEV_DEVICE   initDevice(struct pci_dev *PCI_Dev_Cfg, void * devID) {

   unsigned long        barSize;
   unsigned long        barStart;
   int                  ix;
   pT_TSEV_DEVICE       pDvc;
   u16                  pciDeviceID;
   u16                  pciVendorID;


   pDvc        = &ea90_dma.tsevDevice[ea90_dma.numDevices];
   pDvc->pDrv  = &ea90_dma;   

   if (pci_read_config_word(PCI_Dev_Cfg, PCI_VENDOR_ID, &pciVendorID)) {
      printk(KERN_ERR "ea90_dma: Could not get Vendor ID of TSEV HP-DMA Board!\n");
      return(NULL);
      }
   if (pci_read_config_word(PCI_Dev_Cfg, PCI_DEVICE_ID, &pciDeviceID)) {
      printk(KERN_ERR "ea90_dma: Could not get Device ID of TSEV HP-DMA Board!\n");
      return(NULL);
      }

   pDvc->ID       = pciDeviceID;
   pDvc->pPciDev  = PCI_Dev_Cfg;
   pDvc->majorNum = MAJOR(ea90_dma.drvDevNum);
   pDvc->minorNum = MINOR(ea90_dma.drvDevNum) + ea90_dma.numDevices;

   for (ix = 0; ix < 5; ix++) {
      barStart = pci_resource_start(PCI_Dev_Cfg, ix);
      barSize  = pci_resource_len(PCI_Dev_Cfg, ix);

      switch (ix) {
         case 0 :
            if (pci_resource_flags(PCI_Dev_Cfg, 0) & IORESOURCE_MEM)
               printk(KERN_INFO "ea90_dma: Mem-Space Resource\n");
            
            pDvc->addrBaseRegs   = (pT_TSEV_REGS)ioremap(barStart, barSize);
            break;
            
         default:
            break;
         };
      }

   spin_lock_init(&pDvc->mLockDvc);
      
   ++ea90_dma.numDevices;
   return (pDvc);
   }
   
/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~  */
/*          tsev_init                                                      */
/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~  */
static int __init tsev_init(void) {

   int                     err;
   int                     result;


   printk(KERN_INFO "ea90_dma: _init()   debug=%d\n", debug);

   memset(&ea90_dma, 0, sizeof(ea90_dma));

   result = alloc_chrdev_region(&ea90_dma.drvDevNum,   // return allocated Device Num here
                                0,                            // first minor number
                                MAX_MINORS,
                                "ea90_dma");

   if (result < 0) {
      printk(KERN_ERR "ea90_dma: can't get major/minor numbers!\n");
      return(result);
      }

#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,12))
   ea90_dma.sysClass = class_create(THIS_MODULE, "ea90_dma");
#else
   ea90_dma.sysClass = class_simple_create(THIS_MODULE, "ea90_dma");
#endif
   
   if (IS_ERR(ea90_dma.sysClass)) {
      printk(KERN_ERR "ea90_dma: Error creating simple class interface\n");
      return(-1);
      }

   err = pci_register_driver(&ea90_dma_driver);

   if (err < 0)
      return(err);

   return (0);
   }

/*
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//       tsev_exit    - Remove the driver
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
*/
static void __exit tsev_exit(void) {

   printk(KERN_INFO "ea90_dma: _exit()\n");

   pci_unregister_driver(&ea90_dma_driver);

#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,12))
   class_destroy(ea90_dma.sysClass);
#else
   class_simple_destroy(ea90_dma.sysClass);
#endif

 //unregister_chrdev_region(ea90_dma.drvDevNum, MAX_MINORS);

   printk(KERN_INFO "ea90_dma: _exit() End\n");

   return;
   }
   
/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~  */
/*             tsev_get_dma_attribs                                             */
/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~  */
static int tsev_get_dma_attribs(struct pci_dev  *pdev) {
   if (!pci_set_dma_mask(pdev, DMA_BIT_MASK(48)))
      if (!pci_set_consistent_dma_mask(pdev, DMA_BIT_MASK(48)))
            /* Device will use 64-bit addressing   */
         return 1;

   if (!pci_set_dma_mask(pdev, DMA_BIT_MASK(36)))
      if (!pci_set_consistent_dma_mask(pdev, DMA_BIT_MASK(36)))
            /* Device will use 64-bit addressing   */
         return 1;

   if (!pci_set_dma_mask(pdev, DMA_BIT_MASK(32)))
      if (!pci_set_consistent_dma_mask(pdev, DMA_BIT_MASK(32)))
            /* Device will use 32-bit addressing   */
         return 0;

   return -1;
   }
   
/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~  */
/*             tsev_probe                                             */
/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~  */
static int __init tsev_probe(struct          pci_dev        *pdev,
                             const struct    pci_device_id  *ent) {

   static char devNameStr[16] = "ea90_dma__";

   int                  err;
   pT_TSEV_DEVICE       pDvc;


   printk(KERN_INFO "ea90_dma: _probe(). VMALLOC Memory Size = 0x%x\n", VMALLOC_END - VMALLOC_START);

   devNameStr[13] = '0' + ea90_dma.numDevices;

   err = pci_request_regions(pdev, devNameStr);
   if (err) {
      printk(KERN_ERR "ea90_dma: pci_request_regions() failed\n");
      return err;
      }

   err = pci_enable_device(pdev);
   if (err) {
      printk(KERN_ERR "ea90_dma: Error enabling PCI Device\n");
      return err;
      }

   pci_set_master(pdev);

   if (tsev_get_dma_attribs(pdev) < 0) {
      printk(KERN_ERR "ea90_dma: DMA Init() failed. Could not initialise DMA mask");
      return err;
      }

   pDvc  = initDevice(pdev, (void*)ent);
   if (pDvc == NULL) {
      printk(KERN_ERR "ea90_dma: Error initialising HP-DMA Device\n");
         // Clean up any resources we acquired along the way
      pci_release_regions(pdev);

      return(-1);
      }

   pDvc->mUseMSI  = pci_enable_msi(pdev);
   if (pDvc->mUseMSI < 0) {
      printk(KERN_WARNING "ea90_dma: Could not acquire MSI");
      }
      
   pDvc->charDev.owner  = THIS_MODULE;
   pDvc->charDev.ops    = &drvr_fops;
   kobject_set_name(&pDvc->charDev.kobj, "ea90_dma");

   cdev_init(&pDvc->charDev, &drvr_fops);

   if (pDvc->mUseMSI >= 0)
      err = request_threaded_irq(pdev->irq, tsev_irq_handler, tsev_irq_dpc, 0, KBUILD_MODNAME, pDvc);
   else
      err = request_threaded_irq(pdev->irq, tsev_irq_handler, tsev_irq_dpc, IRQF_SHARED, KBUILD_MODNAME, pDvc);
   if (err) {
      printk(KERN_ERR "ea90_dma: Unable to acquire Interrupt");
      return err;
      }

   err = cdev_add (&pDvc->charDev, MKDEV(pDvc->majorNum, pDvc->minorNum), 1);
   if (err) {
      printk(KERN_ERR "ea90_dma: Error adding Char Device\n");
      return err;
      }

#if LINUX_VERSION_CODE > KERNEL_VERSION(2,6,27)
   device_create(ea90_dma.sysClass,
                 NULL,
                 MKDEV(pDvc->majorNum, pDvc->minorNum),
                 &(pdev->dev),   // this is of type struct device, the PCI device?
                 "%s_%d",
                 DeviceName[pDvc->deviceType],
                 pDvc->instanceNum);
#elif (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,12))
   class_device_create(ea90_dma.sysClass,
                       NULL,
                       MKDEV(pDvc->majorNum, pDvc->minorNum),
                       &(pdev->dev),   // this is of type struct device, the PCI device?
                       "%s_%d",
                       DeviceName[pDvc->deviceType],
                       pDvc->instanceNum);
#else
   class_simple_device_add(ea90_dma.sysClass,
                           MKDEV(pDvc->majorNum, pDvc->minorNum),
                           NULL,       // this is of type struct device, but who?????
                           "%s_%d",
                           DeviceName[pDvc->deviceType],
                           pDvc->instanceNum);
#endif

   #ifdef USE_PROC /* only when available */
      sprintf(pDvc->mProcName, "driver/ea90_dma_%02d", pDvc->minorNum);

      pDvc->mProcDirEntry  = proc_mkdir(pDvc->mProcName, NULL);
      if (pDvc->mProcDirEntry) {

#if LINUX_VERSION_CODE < KERNEL_VERSION(3,11,1)
         pDvc->mProcRegs = create_proc_read_entry("regs", 0, pDvc->mProcDirEntry, tsev_proc_read_regs, NULL);
#else
         pDvc->mProcRegs = proc_create_data("regs", 0, pDvc->mProcDirEntry, &proc_fops, NULL);
#endif
         
         if (! pDvc->mProcRegs) {
            printk(KERN_WARNING "ea90_dma: Cannot Create Proc Regs Entry\n");
            }            
         }
      else {
         printk(KERN_WARNING "ea90_dma: Cannot Create Proc Directory\n");
         }
   #endif

   printk(KERN_INFO "ea90_dma: Loading driver version 0.0.1.%4s\n", &BuildId[22]);

   pci_set_drvdata(pdev, pDvc);

   return 0;
   }

   /*
   //  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   //             tsev_proc_read_regs
   //  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   */
#if LINUX_VERSION_CODE < KERNEL_VERSION(3,11,1)
   static int tsev_proc_read_regs(char *page, char **start, off_t off,
                                  int count, int *eof, void *data) {

      pT_TSEV_DEVICE    pDvc;
      pT_TSEV_REGS      pTsevRegs;
      int               vLen = 0;

      pDvc        = &ea90_dma.tsevDevice[0];
      pTsevRegs   = pDvc->addrBaseRegs;

      vLen += sprintf(page + vLen, "Nr. Devices     : %d\n", ea90_dma.numDevices);
      vLen += sprintf(page + vLen, "SoC Revision    : 0x%08x\n\n", ioread32(&pTsevRegs->regSocRevision));
      vLen += sprintf(page + vLen, "DMA Command/Status   : 0x%08x\n", ioread32(&pTsevRegs->hpDmaRegs.regCmdSta));

      *eof = 1;
      return 0;
      }
   
#else
   static int tsev_proc_open(struct inode *inode, struct file *file) {
      return single_open(file, tsev_proc_read_regs, PDE_DATA(inode));
      }

   static int tsev_proc_read_regs(struct seq_file *m, void *v) {
      pT_TSEV_DEVICE    pDvc;
      pT_TSEV_REGS      pTsevRegs;

      pDvc        = &ea90_dma.tsevDevice[0];
      pTsevRegs   = pDvc->addrBaseRegs;
      
      seq_printf(m, "Nr. Devices     : %d\n", ea90_dma.numDevices);
      seq_printf(m, "SoC Revision    : 0x%08x\n\n", ioread32(&pTsevRegs->regSocRevision));
      seq_printf(m, "DMA Command/Status   : 0x%08x\n", ioread32(&pTsevRegs->hpDmaRegs.regCmdSta));

      return 0;
      }
#endif      
/*
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//             tsev_remove    - Unload the device
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
*/
static void __exit tsev_remove(struct pci_dev *pdev) {

   pT_TSEV_DEVICE    pDvc;
   

   pDvc  = pci_get_drvdata(pdev);
   
   printk(KERN_INFO "ea90_dma: _remove()\n");

   #ifdef USE_PROC
      if (pDvc->mProcRegs) {
         #if LINUX_VERSION_CODE < KERNEL_VERSION(3,11,1)
            remove_proc_entry(pDvc->mProcRegs->name, pDvc->mProcDirEntry);
         #else
            remove_proc_entry("regs", pDvc->mProcDirEntry);
         #endif

         pDvc->mProcRegs   = NULL;            
         }

      if (pDvc->mProcDirEntry) {
         remove_proc_entry(pDvc->mProcName, NULL);
         pDvc->mProcDirEntry  = NULL;
         }

   #endif


   //haltDMA(pDvc);

   free_irq(pdev->irq, pDvc);

   pci_disable_msi(pdev);

   pci_release_regions(pdev);
   cdev_del(&pDvc->charDev);

   unregister_chrdev_region(MKDEV(pDvc->majorNum, pDvc->minorNum), MINORS_PER_DEVICE);

#if LINUX_VERSION_CODE > KERNEL_VERSION(2,6,27)
   device_destroy(ea90_dma.sysClass, MKDEV(pDvc->majorNum, pDvc->minorNum));
#elif (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,12))
   class_device_destroy(ea90_dma.sysClass, MKDEV(pDvc->majorNum, pDvc->minorNum));
#else
   class_simple_device_remove(MKDEV(pDvc->majorNum, pDvc->minorNum));
#endif

   pci_disable_device(pdev);

   return;
   }

/*
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//             tsev_shutdown    - Shutdown the device
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
*/
static void tsev_shutdown (struct pci_dev *pdev) {

   pT_TSEV_DEVICE    pDvc;


   printk(KERN_INFO "ea90_dma: tsev_shutdown()\n");

   pDvc  = pci_get_drvdata(pdev);

   //haltDMA(pDvc);
   }
   
/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~  */
module_init(tsev_init);
module_exit(tsev_exit);

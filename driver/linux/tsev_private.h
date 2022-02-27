
#ifndef _TSEV_PRIVATE_H_

#define _TSEV_PRIVATE_H_

#include <linux/version.h>
#include <linux/kernel.h>

#include <linux/cdev.h>
#include <linux/interrupt.h>
#include <linux/pci.h>

/*
** ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
*/

#define NUM_DEVICES              4                 // 4 TSEV-PCIe devices per system
#define MAX_DEVICES              (NUM_DEVICES)
#define MINORS_PER_DEVICE        1                 // 1 minor number per discrete device
#define MAX_MINORS               (NUM_DEVICES * MINORS_PER_DEVICE)

#define CVAL_REG_ALL_CLR            0x00000000
#define CVAL_REG_ALL_SET            0xFFFFFFFF

#define TSEV_BPOS_DMA_CMD_CLR       12
#define TSEV_BPOS_DMA_CMD_PUSH      10
#define TSEV_BPOS_DMA_INT_ACK       9

#define TSEV_DMA_ATTRIB_HOST_WR     0x00000001
#define TSEV_DMA_ATTRIB_SGE_IRQ     0x00000002
#define TSEV_DMA_ATTRIB_SEQ_LAST    0x00000004
#define TSEV_DMA_CMD_CLR            (1 << TSEV_BPOS_DMA_CMD_CLR)
#define TSEV_DMA_CMD_EN             0x00000001
#define TSEV_DMA_CMD_HCMD_PUSH      0x00000400
#define TSEV_DMA_CMD_INT_ACK        (1 << TSEV_BPOS_DMA_INT_ACK)
#define TSEV_DMA_CMD_INT_DIS_HFE    0x00000004
#define TSEV_DMA_CMD_INT_DIS_LFE    0x00000008
#define TSEV_DMA_CMD_INT_EN         0x00000002
#define TSEV_DMA_CMD_INT_REQ        0x00020000
#define TSEV_DMA_STA_DP_EMPTY       0x00800000

/*
** ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
*/
typedef struct _T_TSEV_DRV*   pT_TSEV_DRV;


/*
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//          Structure describing the DMA Controller Register Interface
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
*/
typedef  struct _T_TSEV_DMA_REGS {
   u32   regCmdSta;
   u32   regXferSize;
   u32   regHostAdrLow;
   u32   regHostAdrHigh;
   u32   regXferFlags;
   u32   regLocalAdr;
   u32   regXferPos;
   u32   regFifoCount;

   } T_TSEV_DMA_REGS, *pT_TSEV_DMA_REGS;
   
/*
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//          Structure for accessing FPGA Registers
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
*/
typedef  struct _T_TSEV_REGS {
   T_TSEV_DMA_REGS   hpDmaRegs;

   u32   regSocID;
   u32   regGlobalSta;
   u32   regSocRevision;
   u32   regDummy_0;
   u32   regPioLed;
   u32   regSegDisplay;
   u32   regPioSwitch;
   u32   regDummy_1;

   } T_TSEV_REGS, *pT_TSEV_REGS;

/*
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//          Structure describing a Device Instance
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
*/
typedef struct _T_TSEV_DEVICE {
   u32   deviceType;
   u32   ID;            /**< PCI device ID of the board (0x5303, 0xe235, etc) */
   u32   instanceNum;   /**< tracks number of identical board,demo devices in system */
   u32   majorNum;      /**< copy of driver's Major number for use in places where only device exists */
   u32   minorNum;      /**< specific Minor number asigned to this board */

   pT_TSEV_REGS            addrBaseRegs;
   
   struct cdev             charDev;    /**< the character device implemented by this driver */
   
   struct completion	      mDmaState;
   spinlock_t              mLockDvc;   
   struct proc_dir_entry*  mProcDirEntry;
   char                    mProcName[32];
   struct proc_dir_entry*  mProcRegs;
   int                     mUseMSI;

   struct work_struct      mWorkRayFifoSglist;

   struct pci_dev*         pPciDev;    /**< pointer to the PCI core representation of the board */

   pT_TSEV_DRV             pDrv;  
   } T_TSEV_DEVICE, *pT_TSEV_DEVICE;

/*
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//          Structure describing Device Driver
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
*/
typedef struct _T_TSEV_DRV {

   dev_t                drvDevNum;                 /**> starting [MAJOR][MINOR] device number for this driver */
   u32                  numDevices;                /**> total number of boards controlled by driver */
   T_TSEV_DEVICE        tsevDevice[NUM_DEVICES];   /**> Database of LSC PCIe Eval Boards Installed */

#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,12))
   struct class*           sysClass;   /**> the top entry point of lscpcie2 in /sys/class */
#else
   struct class_simple*    sysClass;   /**> the top entry point of lscpcie2 in /sys/class */
#endif
   } T_TSEV_DRV;

#endif

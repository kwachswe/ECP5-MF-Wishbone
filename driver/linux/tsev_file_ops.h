
#ifndef _TSEV_FILE_OPS_H
#define _TSEV_FILE_OPS_H

#include <linux/dma-direction.h>
#include <linux/kernel.h>
#include <linux/fs.h>
#include <linux/mm.h>
#include <linux/pagemap.h>
#include <linux/scatterlist.h>
#include <linux/sched.h>
#include <linux/slab.h>
#include <linux/uaccess.h>
#include <linux/vmalloc.h>

//#include "tsev_public.h"
#include "tsev_private.h"

/*
** ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
*/


//
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//          Structure for describing a File Context
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//
typedef struct _T_TSEV_FILE_CTX {
   pT_TSEV_DEVICE    pTsevDvc;

   } T_TSEV_FILE_CTX, *pT_TSEV_FILE_CTX;
   
/*
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//          Function Prototypes
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
*/
int     tsev_fopen(struct inode* inode,  struct file* fp);
ssize_t tsev_fread(struct file *fp, char __user *userBuf, size_t len, loff_t *offp);
ssize_t tsev_fwrite(struct file *fp, const char __user *userBuf, size_t len, loff_t *offp);
int     tsev_fclose(struct inode* inode, struct file* fp);

#if (LINUX_VERSION_CODE < KERNEL_VERSION(2,6,35))
   int tsev_ioctl(struct inode *i, struct file *fp, unsigned int cmd, unsigned long arg);
#else
   long tsev_ioctl(struct file *fp, unsigned int cmd, unsigned long arg);
#endif

#endif

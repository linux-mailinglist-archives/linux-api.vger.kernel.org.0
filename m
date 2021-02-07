Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 393B33122AC
	for <lists+linux-api@lfdr.de>; Sun,  7 Feb 2021 09:29:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230270AbhBGI3P (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sun, 7 Feb 2021 03:29:15 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:12473 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230077AbhBGI1I (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sun, 7 Feb 2021 03:27:08 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4DYMf66C4CzjKdj;
        Sun,  7 Feb 2021 16:25:02 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.498.0; Sun, 7 Feb 2021 16:26:15 +0800
From:   Zhou Wang <wangzhou1@hisilicon.com>
To:     <linux-kernel@vger.kernel.org>, <iommu@lists.linux-foundation.org>,
        <linux-mm@kvack.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-api@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
CC:     <gregkh@linuxfoundation.org>, <song.bao.hua@hisilicon.com>,
        <jgg@ziepe.ca>, <kevin.tian@intel.com>, <jean-philippe@linaro.org>,
        <eric.auger@redhat.com>, <liguozhu@hisilicon.com>,
        <zhangfei.gao@linaro.org>, Zhou Wang <wangzhou1@hisilicon.com>,
        Sihang Chen <chensihang1@hisilicon.com>
Subject: [RFC PATCH v3 1/2] mempinfd: Add new syscall to provide memory pin
Date:   Sun, 7 Feb 2021 16:18:03 +0800
Message-ID: <1612685884-19514-2-git-send-email-wangzhou1@hisilicon.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1612685884-19514-1-git-send-email-wangzhou1@hisilicon.com>
References: <1612685884-19514-1-git-send-email-wangzhou1@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

SVA(share virtual address) offers a way for device to share process virtual
address space safely, which makes more convenient for user space device
driver coding. However, IO page faults may happen when doing DMA
operations. As the latency of IO page fault is relatively big, DMA
performance will be affected severely when there are IO page faults.
From a long term view, DMA performance will be not stable.

In high-performance I/O cases, accelerators might want to perform
I/O on a memory without IO page faults which can result in dramatically
increased latency. Current memory related APIs could not achieve this
requirement, e.g. mlock can only avoid memory to swap to backup device,
page migration can still trigger IO page fault.

Various drivers working under traditional non-SVA mode are using
their own specific ioctl to do pin. Such ioctl can be seen in v4l2,
gpu, infiniband, media, vfio, etc. Drivers are usually doing dma
mapping while doing pin.

But, in SVA mode, pin could be a common need which isn't necessarily
bound with any drivers, and neither is dma mapping needed by drivers
since devices are using the virtual address of CPU. Thus, It is better
to introduce a new common syscall for it.

This patch leverages the design of userfaultfd and adds mempinfd for pin
to avoid messing up mm_struct. A fd will be got by mempinfd, then user
space can do pin/unpin pages by ioctls of this fd, all pinned pages under
one file will be unpinned in file release process. Like pin page cases in
other places, can_do_mlock is used to check permission and input
parameters.

Signed-off-by: Zhou Wang <wangzhou1@hisilicon.com>
Signed-off-by: Sihang Chen <chensihang1@hisilicon.com>
Suggested-by: Barry Song <song.bao.hua@hisilicon.com>
---
 arch/arm64/include/asm/unistd.h   |   2 +-
 arch/arm64/include/asm/unistd32.h |   2 +
 fs/Makefile                       |   1 +
 fs/mempinfd.c                     | 199 ++++++++++++++++++++++++++++++++++++++
 include/linux/syscalls.h          |   1 +
 include/uapi/asm-generic/unistd.h |   4 +-
 include/uapi/linux/mempinfd.h     |  23 +++++
 init/Kconfig                      |   6 ++
 8 files changed, 236 insertions(+), 2 deletions(-)
 create mode 100644 fs/mempinfd.c
 create mode 100644 include/uapi/linux/mempinfd.h

diff --git a/arch/arm64/include/asm/unistd.h b/arch/arm64/include/asm/unistd.h
index 86a9d7b3..949788f 100644
--- a/arch/arm64/include/asm/unistd.h
+++ b/arch/arm64/include/asm/unistd.h
@@ -38,7 +38,7 @@
 #define __ARM_NR_compat_set_tls		(__ARM_NR_COMPAT_BASE + 5)
 #define __ARM_NR_COMPAT_END		(__ARM_NR_COMPAT_BASE + 0x800)
 
-#define __NR_compat_syscalls		442
+#define __NR_compat_syscalls		443
 #endif
 
 #define __ARCH_WANT_SYS_CLONE
diff --git a/arch/arm64/include/asm/unistd32.h b/arch/arm64/include/asm/unistd32.h
index cccfbbe..3f49529 100644
--- a/arch/arm64/include/asm/unistd32.h
+++ b/arch/arm64/include/asm/unistd32.h
@@ -891,6 +891,8 @@ __SYSCALL(__NR_faccessat2, sys_faccessat2)
 __SYSCALL(__NR_process_madvise, sys_process_madvise)
 #define __NR_epoll_pwait2 441
 __SYSCALL(__NR_epoll_pwait2, compat_sys_epoll_pwait2)
+#define __NR_mempinfd 442
+__SYSCALL(__NR_mempinfd, sys_mempinfd)
 
 /*
  * Please add new compat syscalls above this comment and update
diff --git a/fs/Makefile b/fs/Makefile
index 999d1a2..e1cbf12 100644
--- a/fs/Makefile
+++ b/fs/Makefile
@@ -54,6 +54,7 @@ obj-$(CONFIG_COREDUMP)		+= coredump.o
 obj-$(CONFIG_SYSCTL)		+= drop_caches.o
 
 obj-$(CONFIG_FHANDLE)		+= fhandle.o
+obj-$(CONFIG_MEMPINFD)		+= mempinfd.o
 obj-y				+= iomap/
 
 obj-y				+= quota/
diff --git a/fs/mempinfd.c b/fs/mempinfd.c
new file mode 100644
index 0000000..23d3911
--- /dev/null
+++ b/fs/mempinfd.c
@@ -0,0 +1,199 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (c) 2021 HiSilicon Limited. */
+#include <linux/anon_inodes.h>
+#include <linux/fs.h>
+#include <linux/mm.h>
+#include <linux/mm_types.h>
+#include <linux/slab.h>
+#include <linux/syscalls.h>
+#include <linux/uaccess.h>
+#include <linux/vmalloc.h>
+#include <linux/xarray.h>
+#include <uapi/linux/mempinfd.h>
+
+struct mem_pin_container {
+	struct xarray array;
+	struct mutex lock;
+};
+
+struct pin_pages {
+	unsigned long first;
+	unsigned long nr_pages;
+	struct page **pages;
+};
+
+static int mempinfd_release(struct inode *inode, struct file *file)
+{
+	struct mem_pin_container *priv = file->private_data;
+	struct pin_pages *p;
+	unsigned long idx;
+
+	xa_for_each(&priv->array, idx, p) {
+		unpin_user_pages(p->pages, p->nr_pages);
+		xa_erase(&priv->array, p->first);
+		vfree(p->pages);
+		kfree(p);
+	}
+
+	mutex_destroy(&priv->lock);
+	xa_destroy(&priv->array);
+	kfree(priv);
+
+	return 0;
+}
+
+static int mempinfd_input_check(u64 addr, u64 size)
+{
+	if (!size || addr + size < addr)
+		return -EINVAL;
+
+	if (!can_do_mlock())
+		return -EPERM;
+
+	return 0;
+}
+
+static int mem_pin_page(struct mem_pin_container *priv,
+			struct mem_pin_address *addr)
+{
+	unsigned int flags = FOLL_FORCE | FOLL_WRITE;
+	unsigned long first, last, nr_pages;
+	struct page **pages;
+	struct pin_pages *p;
+	int ret;
+
+	if (mempinfd_input_check(addr->addr, addr->size))
+		return -EINVAL;
+
+	first = (addr->addr & PAGE_MASK) >> PAGE_SHIFT;
+	last = ((addr->addr + addr->size - 1) & PAGE_MASK) >> PAGE_SHIFT;
+	nr_pages = last - first + 1;
+
+	pages = vmalloc(nr_pages * sizeof(struct page *));
+	if (!pages)
+		return -ENOMEM;
+
+	p = kzalloc(sizeof(*p), GFP_KERNEL);
+	if (!p) {
+		ret = -ENOMEM;
+		goto free;
+	}
+
+	mutex_lock(&priv->lock);
+
+	ret = pin_user_pages_fast(addr->addr & PAGE_MASK, nr_pages,
+				  flags | FOLL_LONGTERM, pages);
+	if (ret != nr_pages) {
+		pr_err("mempinfd: Failed to pin page\n");
+		goto unlock;
+	}
+	p->first = first;
+	p->nr_pages = nr_pages;
+	p->pages = pages;
+
+	ret = xa_insert(&priv->array, p->first, p, GFP_KERNEL);
+	if (ret)
+		goto unpin_pages;
+
+	mutex_unlock(&priv->lock);
+
+	return 0;
+
+unpin_pages:
+	unpin_user_pages(pages, nr_pages);
+unlock:
+	mutex_unlock(&priv->lock);
+	kfree(p);
+free:
+	vfree(pages);
+	return ret;
+}
+
+static int mem_unpin_page(struct mem_pin_container *priv,
+			  struct mem_pin_address *addr)
+{
+	unsigned long first, last, nr_pages;
+	struct pin_pages *p;
+	int ret;
+
+	first = (addr->addr & PAGE_MASK) >> PAGE_SHIFT;
+	last = ((addr->addr + addr->size - 1) & PAGE_MASK) >> PAGE_SHIFT;
+	nr_pages = last - first + 1;
+
+	mutex_lock(&priv->lock);
+
+	p = xa_load(&priv->array, first);
+	if (!p) {
+		ret = -ENODEV;
+		goto unlock;
+	}
+
+	if (p->nr_pages != nr_pages) {
+		ret = -EINVAL;
+		goto unlock;
+	}
+
+	unpin_user_pages(p->pages, p->nr_pages);
+	xa_erase(&priv->array, first);
+
+	mutex_unlock(&priv->lock);
+
+	vfree(p->pages);
+	kfree(p);
+
+	return 0;
+
+unlock:
+	mutex_unlock(&priv->lock);
+	return ret;
+}
+
+static long mempinfd_ioctl(struct file *file, unsigned int cmd,
+			   unsigned long arg)
+{
+	struct mem_pin_container *p = file->private_data;
+	struct mem_pin_address addr;
+
+	if (copy_from_user(&addr, (void __user *)arg,
+			   sizeof(struct mem_pin_address)))
+		return -EFAULT;
+
+	switch (cmd) {
+	case MEM_CMD_PIN:
+		return mem_pin_page(p, &addr);
+
+	case MEM_CMD_UNPIN:
+		return mem_unpin_page(p, &addr);
+
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct file_operations mempinfd_fops = {
+	.release	= mempinfd_release,
+	.unlocked_ioctl = mempinfd_ioctl,
+};
+
+SYSCALL_DEFINE0(mempinfd)
+{
+	struct mem_pin_container *p;
+	int fd;
+
+	WARN_ON(!current->mm);
+
+	p = kzalloc(sizeof(*p), GFP_KERNEL);
+	if (!p)
+		return -ENOMEM;
+	xa_init(&p->array);
+	mutex_init(&p->lock);
+
+	fd = anon_inode_getfd("[mempinfd]", &mempinfd_fops, p, O_CLOEXEC);
+	if (fd < 0) {
+		mutex_destroy(&p->lock);
+		xa_destroy(&p->array);
+		kfree(p);
+	}
+
+	return fd;
+}
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 7688bc9..0960257 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -1005,6 +1005,7 @@ asmlinkage long sys_execveat(int dfd, const char __user *filename,
 			const char __user *const __user *argv,
 			const char __user *const __user *envp, int flags);
 asmlinkage long sys_userfaultfd(int flags);
+asmlinkage long sys_mempinfd(void);
 asmlinkage long sys_membarrier(int cmd, unsigned int flags, int cpu_id);
 asmlinkage long sys_mlock2(unsigned long start, size_t len, int flags);
 asmlinkage long sys_copy_file_range(int fd_in, loff_t __user *off_in,
diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index 7287529..2625b62 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -861,9 +861,11 @@ __SYSCALL(__NR_faccessat2, sys_faccessat2)
 __SYSCALL(__NR_process_madvise, sys_process_madvise)
 #define __NR_epoll_pwait2 441
 __SC_COMP(__NR_epoll_pwait2, sys_epoll_pwait2, compat_sys_epoll_pwait2)
+#define __NR_mempinfd 442
+__SYSCALL(__NR_mempinfd, sys_mempinfd)
 
 #undef __NR_syscalls
-#define __NR_syscalls 442
+#define __NR_syscalls 443
 
 /*
  * 32 bit systems traditionally used different
diff --git a/include/uapi/linux/mempinfd.h b/include/uapi/linux/mempinfd.h
new file mode 100644
index 0000000..ade3e15
--- /dev/null
+++ b/include/uapi/linux/mempinfd.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef _LINUX_MEMPINFD_H
+#define _LINUX_MEMPINFD_H
+
+#include <linux/types.h>
+
+/**
+ * struct mem_pin_address - Expected pin user space address and size
+ * @addr: Address to pin
+ * @size: Size of pin address
+ */
+struct mem_pin_address {
+	__u64 addr;
+	__u64 size;
+};
+
+/* MEM_CMD_PIN: Pin a range of memory */
+#define MEM_CMD_PIN		_IOW('M', 0, struct mem_pin_address)
+
+/* UACCE_CMD_UNPIN: Unpin a range of memory */
+#define MEM_CMD_UNPIN		_IOW('M', 1, struct mem_pin_address)
+
+#endif /* _LINUX_MEMPINFD_H */
diff --git a/init/Kconfig b/init/Kconfig
index b77c60f..5f2ba55 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1731,6 +1731,12 @@ config USERFAULTFD
 	  Enable the userfaultfd() system call that allows to intercept and
 	  handle page faults in userland.
 
+config MEMPINFD
+	bool "Enable mempinfd() system call"
+	help
+	  Enable the mempinfd() system call that allows to pin/unpin memory
+	  in userland.
+
 config ARCH_HAS_MEMBARRIER_CALLBACKS
 	bool
 
-- 
2.8.1


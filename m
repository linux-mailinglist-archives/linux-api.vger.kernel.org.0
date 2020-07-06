Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C45A8215CF1
	for <lists+linux-api@lfdr.de>; Mon,  6 Jul 2020 19:21:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729660AbgGFRVQ (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 6 Jul 2020 13:21:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:55638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729297AbgGFRVQ (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Mon, 6 Jul 2020 13:21:16 -0400
Received: from aquarius.haifa.ibm.com (nesher1.haifa.il.ibm.com [195.110.40.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E9EEF2070C;
        Mon,  6 Jul 2020 17:21:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594056074;
        bh=gpU//KoB2AQw6lM5U9/1D23NU/iK4dZQIlaoURlM/+U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sItZIrXZ/9cLSrFN/w75UXMTS4LtOXPowbFdJ9pRWNWmDA5foohxAJPNin3nSVl2P
         9C6/KLh8osZmgU0eZx+bD9IyOFFQU+f4P36C8grrvGwKH/+l4gjOCdS4cYP2D3UIl3
         s0R39gvYRimYTiyQYFYF02LfbA86VEB94newtMws=
From:   Mike Rapoport <rppt@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Alan Cox <alan@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Christopher Lameter <cl@linux.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Idan Yaniv <idan.yaniv@ibm.com>,
        James Bottomley <jejb@linux.ibm.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Reshetova, Elena" <elena.reshetova@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tycho Andersen <tycho@tycho.ws>, linux-api@vger.kernel.org,
        linux-mm@kvack.org, Mike Rapoport <rppt@linux.ibm.com>
Subject: [RFC PATCH v2 3/5] mm: extend memfd with ability to create "secret" memory areas
Date:   Mon,  6 Jul 2020 20:20:49 +0300
Message-Id: <20200706172051.19465-4-rppt@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200706172051.19465-1-rppt@kernel.org>
References: <20200706172051.19465-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

From: Mike Rapoport <rppt@linux.ibm.com>

Extend memfd_create() system call with the ability to create memory areas
visible only in the context of the owning process and not mapped not only
to other processes but in the kernel page tables as well.

The user will create a file descriptor using the memfd_create system call.
The user than has to use ioctl() to define the desired protection mode for
the memory associated with that file descriptor and only when the mode is
set it is possible to mmap() the memory. For instance, the following
exapmple will create an uncached mapping (error handling is omitted):

        fd = memfd_create("secret", MFD_SECRET);
        ioctl(fd, MFD_SECRET_UNCACHED);
	ftruncate(fd. MAP_SIZE);
        ptr = mmap(NULL, MAP_SIZE, PROT_READ | PROT_WRITE, MAP_SHARED,
		   fd, 0);

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 include/linux/memfd.h      |   9 ++
 include/uapi/linux/magic.h |   1 +
 include/uapi/linux/memfd.h |   6 +
 mm/Kconfig                 |   3 +
 mm/Makefile                |   1 +
 mm/memfd.c                 |  10 +-
 mm/secretmem.c             | 247 +++++++++++++++++++++++++++++++++++++
 7 files changed, 275 insertions(+), 2 deletions(-)
 create mode 100644 mm/secretmem.c

diff --git a/include/linux/memfd.h b/include/linux/memfd.h
index 4f1600413f91..d3ca7285f51a 100644
--- a/include/linux/memfd.h
+++ b/include/linux/memfd.h
@@ -13,4 +13,13 @@ static inline long memfd_fcntl(struct file *f, unsigned int c, unsigned long a)
 }
 #endif
 
+#ifdef CONFIG_MEMFD_SECRETMEM
+extern struct file *secretmem_file_create(const char *name, unsigned int flags);
+#else
+static inline struct file *secretmem_file_create(const char *name, unsigned int flags)
+{
+	return ERR_PTR(-EINVAL);
+}
+#endif
+
 #endif /* __LINUX_MEMFD_H */
diff --git a/include/uapi/linux/magic.h b/include/uapi/linux/magic.h
index f3956fc11de6..35687dcb1a42 100644
--- a/include/uapi/linux/magic.h
+++ b/include/uapi/linux/magic.h
@@ -97,5 +97,6 @@
 #define DEVMEM_MAGIC		0x454d444d	/* "DMEM" */
 #define Z3FOLD_MAGIC		0x33
 #define PPC_CMM_MAGIC		0xc7571590
+#define SECRETMEM_MAGIC		0x5345434d	/* "SECM" */
 
 #endif /* __LINUX_MAGIC_H__ */
diff --git a/include/uapi/linux/memfd.h b/include/uapi/linux/memfd.h
index 7a8a26751c23..3320a79b638d 100644
--- a/include/uapi/linux/memfd.h
+++ b/include/uapi/linux/memfd.h
@@ -8,6 +8,12 @@
 #define MFD_CLOEXEC		0x0001U
 #define MFD_ALLOW_SEALING	0x0002U
 #define MFD_HUGETLB		0x0004U
+#define MFD_SECRET		0x0008U
+
+/* ioctls for secret memory */
+#define MFD_SECRET_IOCTL '-'
+#define MFD_SECRET_EXCLUSIVE	_IOW(MFD_SECRET_IOCTL, 0x13, unsigned long)
+#define MFD_SECRET_UNCACHED	_IOW(MFD_SECRET_IOCTL, 0x14, unsigned long)
 
 /*
  * Huge page size encoding when MFD_HUGETLB is specified, and a huge page
diff --git a/mm/Kconfig b/mm/Kconfig
index f2104cc0d35c..20dfcc54cc7a 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -872,4 +872,7 @@ config ARCH_HAS_HUGEPD
 config MAPPING_DIRTY_HELPERS
         bool
 
+config MEMFD_SECRETMEM
+        def_bool MEMFD_CREATE && ARCH_HAS_SET_DIRECT_MAP
+
 endmenu
diff --git a/mm/Makefile b/mm/Makefile
index 6e9d46b2efc9..a9459c8a655a 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -121,3 +121,4 @@ obj-$(CONFIG_MEMFD_CREATE) += memfd.o
 obj-$(CONFIG_MAPPING_DIRTY_HELPERS) += mapping_dirty_helpers.o
 obj-$(CONFIG_PTDUMP_CORE) += ptdump.o
 obj-$(CONFIG_PAGE_REPORTING) += page_reporting.o
+obj-$(CONFIG_MEMFD_SECRETMEM) += secretmem.o
diff --git a/mm/memfd.c b/mm/memfd.c
index 2647c898990c..3e1cc37e0389 100644
--- a/mm/memfd.c
+++ b/mm/memfd.c
@@ -245,7 +245,8 @@ long memfd_fcntl(struct file *file, unsigned int cmd, unsigned long arg)
 #define MFD_NAME_PREFIX_LEN (sizeof(MFD_NAME_PREFIX) - 1)
 #define MFD_NAME_MAX_LEN (NAME_MAX - MFD_NAME_PREFIX_LEN)
 
-#define MFD_ALL_FLAGS (MFD_CLOEXEC | MFD_ALLOW_SEALING | MFD_HUGETLB)
+#define MFD_SECRET_MASK (MFD_CLOEXEC | MFD_SECRET)
+#define MFD_ALL_FLAGS (MFD_CLOEXEC | MFD_ALLOW_SEALING | MFD_HUGETLB | MFD_SECRET)
 
 SYSCALL_DEFINE2(memfd_create,
 		const char __user *, uname,
@@ -257,6 +258,9 @@ SYSCALL_DEFINE2(memfd_create,
 	char *name;
 	long len;
 
+	if (flags & ~(unsigned int)MFD_SECRET_MASK)
+		return -EINVAL;
+
 	if (!(flags & MFD_HUGETLB)) {
 		if (flags & ~(unsigned int)MFD_ALL_FLAGS)
 			return -EINVAL;
@@ -296,7 +300,9 @@ SYSCALL_DEFINE2(memfd_create,
 		goto err_name;
 	}
 
-	if (flags & MFD_HUGETLB) {
+	if (flags & MFD_SECRET) {
+		file = secretmem_file_create(name, flags);
+	} else if (flags & MFD_HUGETLB) {
 		struct user_struct *user = NULL;
 
 		file = hugetlb_file_setup(name, 0, VM_NORESERVE, &user,
diff --git a/mm/secretmem.c b/mm/secretmem.c
new file mode 100644
index 000000000000..df8f8c958cc2
--- /dev/null
+++ b/mm/secretmem.c
@@ -0,0 +1,247 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/mm.h>
+#include <linux/fs.h>
+#include <linux/mount.h>
+#include <linux/memfd.h>
+#include <linux/printk.h>
+#include <linux/pagemap.h>
+#include <linux/pseudo_fs.h>
+#include <linux/set_memory.h>
+#include <linux/sched/signal.h>
+
+#include <uapi/linux/memfd.h>
+#include <uapi/linux/magic.h>
+
+#include <asm/tlbflush.h>
+
+#include "internal.h"
+
+#undef pr_fmt
+#define pr_fmt(fmt) "secretmem: " fmt
+
+#define SECRETMEM_EXCLUSIVE	0x1
+#define SECRETMEM_UNCACHED	0x2
+
+struct secretmem_ctx {
+	unsigned int mode;
+};
+
+static struct page *secretmem_alloc_page(gfp_t gfp)
+{
+	/*
+	 * FIXME: use a cache of large pages to reduce the direct map
+	 * fragmentation
+	 */
+	return alloc_page(gfp);
+}
+
+static vm_fault_t secretmem_fault(struct vm_fault *vmf)
+{
+	struct address_space *mapping = vmf->vma->vm_file->f_mapping;
+	struct inode *inode = file_inode(vmf->vma->vm_file);
+	pgoff_t offset = vmf->pgoff;
+	unsigned long addr;
+	struct page *page;
+	int ret = 0;
+
+	if (((loff_t)vmf->pgoff << PAGE_SHIFT) >= i_size_read(inode))
+		return vmf_error(-EINVAL);
+
+	page = find_get_entry(mapping, offset);
+	if (!page) {
+		page = secretmem_alloc_page(vmf->gfp_mask);
+		if (!page)
+			return vmf_error(-ENOMEM);
+
+		ret = add_to_page_cache_lru(page, mapping, offset, vmf->gfp_mask);
+		if (unlikely(ret))
+			goto err_put_page;
+
+		ret = set_direct_map_invalid_noflush(page);
+		if (ret)
+			goto err_del_page_cache;
+
+		addr = (unsigned long)page_address(page);
+		flush_tlb_kernel_range(addr, addr + PAGE_SIZE);
+
+		__SetPageUptodate(page);
+
+		ret = VM_FAULT_LOCKED;
+	}
+
+	vmf->page = page;
+	return ret;
+
+err_del_page_cache:
+	delete_from_page_cache(page);
+err_put_page:
+	put_page(page);
+	return vmf_error(ret);
+}
+
+static const struct vm_operations_struct secretmem_vm_ops = {
+	.fault = secretmem_fault,
+};
+
+static int secretmem_mmap(struct file *file, struct vm_area_struct *vma)
+{
+	struct secretmem_ctx *ctx = file->private_data;
+	unsigned long mode = ctx->mode;
+	unsigned long len = vma->vm_end - vma->vm_start;
+
+	if (!mode)
+		return -EINVAL;
+
+	if (mlock_future_check(vma->vm_mm, vma->vm_flags | VM_LOCKED, len))
+		return -EAGAIN;
+
+	switch (mode) {
+	case SECRETMEM_UNCACHED:
+		vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
+		fallthrough;
+	case SECRETMEM_EXCLUSIVE:
+		vma->vm_ops = &secretmem_vm_ops;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	vma->vm_flags |= VM_LOCKED;
+
+	return 0;
+}
+
+static long secretmem_ioctl(struct file *file, unsigned cmd, unsigned long arg)
+{
+	struct secretmem_ctx *ctx = file->private_data;
+	unsigned long mode = ctx->mode;
+
+	if (mode)
+		return -EINVAL;
+
+	switch (cmd) {
+	case MFD_SECRET_EXCLUSIVE:
+		mode = SECRETMEM_EXCLUSIVE;
+		break;
+	case MFD_SECRET_UNCACHED:
+		mode = SECRETMEM_UNCACHED;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	ctx->mode = mode;
+
+	return 0;
+}
+
+const struct file_operations secretmem_fops = {
+	.mmap		= secretmem_mmap,
+	.unlocked_ioctl = secretmem_ioctl,
+	.compat_ioctl	= secretmem_ioctl,
+};
+
+static bool secretmem_isolate_page(struct page *page, isolate_mode_t mode)
+{
+	return false;
+}
+
+static int secretmem_migratepage(struct address_space *mapping,
+				 struct page *newpage, struct page *page,
+				 enum migrate_mode mode)
+{
+	return -EBUSY;
+}
+
+static void secretmem_freepage(struct page *page)
+{
+	set_direct_map_default_noflush(page);
+}
+
+static const struct address_space_operations secretmem_aops = {
+	.freepage	= secretmem_freepage,
+	.migratepage	= secretmem_migratepage,
+	.isolate_page	= secretmem_isolate_page,
+};
+
+static struct vfsmount *secretmem_mnt;
+
+struct file *secretmem_file_create(const char *name, unsigned int flags)
+{
+	struct inode *inode = alloc_anon_inode(secretmem_mnt->mnt_sb);
+	struct file *file = ERR_PTR(-ENOMEM);
+	struct secretmem_ctx *ctx;
+
+	if (IS_ERR(inode))
+		return ERR_CAST(inode);
+
+	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
+	if (!ctx)
+		goto err_free_inode;
+
+	file = alloc_file_pseudo(inode, secretmem_mnt, "secretmem",
+				 O_RDWR, &secretmem_fops);
+	if (IS_ERR(file))
+		goto err_free_ctx;
+
+	mapping_set_unevictable(inode->i_mapping);
+
+	inode->i_mapping->private_data = ctx;
+	inode->i_mapping->a_ops = &secretmem_aops;
+
+	/* pretend we are a normal file with zero size */
+	inode->i_mode |= S_IFREG;
+	inode->i_size = 0;
+
+	file->private_data = ctx;
+
+	return file;
+
+err_free_ctx:
+	kfree(ctx);
+err_free_inode:
+	iput(inode);
+	return file;
+}
+
+static void secretmem_evict_inode(struct inode *inode)
+{
+	struct secretmem_ctx *ctx = inode->i_private;
+
+	truncate_inode_pages_final(&inode->i_data);
+	clear_inode(inode);
+	kfree(ctx);
+}
+
+static const struct super_operations secretmem_super_ops = {
+	.evict_inode = secretmem_evict_inode,
+};
+
+static int secretmem_init_fs_context(struct fs_context *fc)
+{
+	struct pseudo_fs_context *ctx = init_pseudo(fc, SECRETMEM_MAGIC);
+
+	if (!ctx)
+		return -ENOMEM;
+	ctx->ops = &secretmem_super_ops;
+
+	return 0;
+}
+
+static struct file_system_type secretmem_fs = {
+	.name		= "secretmem",
+	.init_fs_context = secretmem_init_fs_context,
+	.kill_sb	= kill_anon_super,
+};
+
+static int secretmem_init(void)
+{
+	int ret = 0;
+
+	secretmem_mnt = kern_mount(&secretmem_fs);
+	if (IS_ERR(secretmem_mnt))
+		ret = PTR_ERR(secretmem_mnt);
+
+	return ret;
+}
+fs_initcall(secretmem_init);
-- 
2.26.2


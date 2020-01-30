Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3EBB514DF06
	for <lists+linux-api@lfdr.de>; Thu, 30 Jan 2020 17:23:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727268AbgA3QXu (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 30 Jan 2020 11:23:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:34336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727158AbgA3QXt (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 30 Jan 2020 11:23:49 -0500
Received: from rapoport-lnx (unknown [87.70.26.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 191D7206D5;
        Thu, 30 Jan 2020 16:23:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580401428;
        bh=jvT8ASMY18+e02XqrKSnl8MpU2A9gIiQzaWCpgyJEUM=;
        h=Date:From:To:Cc:Subject:From;
        b=dr0p7lYmQYvPE0VJDxVR41oDv/8ofFzQnWOzVSPfaNRMpY6pjEUCvPev4eQQQ6fIb
         OGY8tf6JW3EClkz1F1OvS+ulGYt0sELShIp493+T97ph/viRDkytOEN1RZO1Uyao+F
         8/mb6uFL8OwDV58L7IYRghyj/knp2GE0K+IWSJVA=
Date:   Thu, 30 Jan 2020 18:23:41 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Alan Cox <alan@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Christopher Lameter <cl@linux.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        James Bottomley <jejb@linux.ibm.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Reshetova, Elena" <elena.reshetova@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tycho Andersen <tycho@tycho.ws>, linux-api@vger.kernel.org,
        linux-mm@kvack.org
Subject: [RFC PATCH] mm: extend memfd with ability to create "secret" memory
 areas
Message-ID: <20200130162340.GA14232@rapoport-lnx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hi,

This is essentially a resend of my attempt to implement "secret" mappings
using a file descriptor [1]. 

I've done a couple of experiments with secret/exclusive/whatever
memory backed by a file-descriptor using a chardev and memfd_create
syscall. There is indeed no need for VM_ flag, but there are still places
that would require special care, e.g vm_normal_page(), madvise(DO_FORK), so
it won't be completely free of core mm modifications.

Below is a POC that implements extension to memfd_create() that allows
mapping of a "secret" memory. The "secrecy" mode should be explicitly set
using ioctl(), for now I've implemented exclusive and uncached mappings.

The POC primarily indented to illustrate a possible userspace API for
fd-based secret memory. The idea is that user will create a file
descriptor using a system call. The user than has to use ioctl() to define
the desired mode of operation and only when the mode is set it is possible
to mmap() the memory. I.e something like

	fd = memfd_create("secret", MFD_SECRET);
	ioctl(fd, MFD_SECRET_UNCACHED);
	ptr = mmap(NULL, MAP_SIZE, PROT_READ | PROT_WRITE, MAP_SHARED,
		   fd, 0);


The ioctl() allows a lot of flexibility in how the secrecy should be
defined. It could be either a request for a particular protection (e.g.
exclusive, uncached) or something like "secrecy level" from "a bit more
secret than normally" to "do your best even at the expense of performance".
The POC implements the first option and the modes are mutually exclusive
for now, but there is no fundamental reason they cannot be mixed.

I've chosen memfd over a chardev as it seem to play more neatly with
anon_inodes and would allow simple (ab)use of the page cache for tracking
pages allocated for the "secret" mappings as well as using
address_space_operations for e.g. page migration callbacks.

The POC implementation uses set_memory/pageattr APIs to manipulate the
direct map and does not address the direct map fragmentation issue.

Of course this is something that must be addressed, as well as
modifications to core mm to required keep the secret memory secret, but I'd
really like to focus on the userspace ABI first.

[1] https://lore.kernel.org/lkml/1572171452-7958-1-git-send-email-rppt@kernel.org/
[1] https://lore.kernel.org/lkml/20191205153400.GA25575@rapoport-lnx/

From 5ca6fb6fc3e68d7b27ef04faa19bed4e2813f7f9 Mon Sep 17 00:00:00 2001
From: Mike Rapoport <rppt@linux.ibm.com>
Date: Mon, 18 Nov 2019 09:32:22 +0200
Subject: [PATCH] mm: extend memfd with ability to create "secret" memory areas

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
 mm/Kconfig                 |   4 +
 mm/Makefile                |   1 +
 mm/memfd.c                 |  10 +-
 mm/secretmem.c             | 244 +++++++++++++++++++++++++++++++++++++
 7 files changed, 273 insertions(+), 2 deletions(-)
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
index 3ac436376d79..c0104e6da894 100644
--- a/include/uapi/linux/magic.h
+++ b/include/uapi/linux/magic.h
@@ -95,5 +95,6 @@
 #define DMA_BUF_MAGIC		0x444d4142	/* "DMAB" */
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
index ab80933be65f..2a8956d9048d 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -739,4 +739,8 @@ config ARCH_HAS_HUGEPD
 config MAPPING_DIRTY_HELPERS
         bool
 
+config MEMFD_SECRETMEM
+        def_bool MEMFD_CREATE && ARCH_HAS_SET_DIRECT_MAP
+
+
 endmenu
diff --git a/mm/Makefile b/mm/Makefile
index 1937cc251883..9399e823ccdb 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -108,3 +108,4 @@ obj-$(CONFIG_ZONE_DEVICE) += memremap.o
 obj-$(CONFIG_HMM_MIRROR) += hmm.o
 obj-$(CONFIG_MEMFD_CREATE) += memfd.o
 obj-$(CONFIG_MAPPING_DIRTY_HELPERS) += mapping_dirty_helpers.o
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
index 000000000000..ac67a67aa29c
--- /dev/null
+++ b/mm/secretmem.c
@@ -0,0 +1,244 @@
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
+#define SECRETMEM_EXCLUSIVE	0x1
+#define SECRETMEM_UNCACHED	0x2
+
+struct secretmem_state {
+	unsigned int mode;
+	unsigned long nr_pages;
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
+static int secretmem_check_limits(struct vm_fault *vmf)
+{
+	struct secretmem_state *state = vmf->vma->vm_file->private_data;
+	struct inode *inode = file_inode(vmf->vma->vm_file);
+	unsigned long limit;
+
+	if (((loff_t)vmf->pgoff << PAGE_SHIFT) >= i_size_read(inode))
+		return -EINVAL;
+
+	limit = rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
+	if (state->nr_pages + 1 >= limit)
+		return -EPERM;
+
+	return 0;
+}
+
+static vm_fault_t secretmem_fault(struct vm_fault *vmf)
+{
+	struct secretmem_state *state = vmf->vma->vm_file->private_data;
+	struct address_space *mapping = vmf->vma->vm_file->f_mapping;
+	pgoff_t offset = vmf->pgoff;
+	unsigned long addr;
+	struct page *page;
+	int ret;
+
+	ret = secretmem_check_limits(vmf);
+	if (ret)
+		return vmf_error(ret);
+
+	page = find_get_entry(mapping, offset);
+	if (!page) {
+		page = secretmem_alloc_page(vmf->gfp_mask);
+		if (!page)
+			return vmf_error(-ENOMEM);
+
+		ret = add_to_page_cache_lru(page, mapping, offset, vmf->gfp_mask);
+		if (unlikely(ret)) {
+			put_page(page);
+			return vmf_error(ret);
+		}
+
+		ret = set_direct_map_invalid_noflush(page);
+		if (ret) {
+			delete_from_page_cache(page);
+			return vmf_error(ret);
+		}
+
+		addr = (unsigned long)page_address(page);
+		flush_tlb_kernel_range(addr, addr + PAGE_SIZE);
+
+		__SetPageUptodate(page);
+
+		state->nr_pages++;
+		ret = VM_FAULT_LOCKED;
+	}
+
+	vmf->page = page;
+	return ret;
+}
+
+static const struct vm_operations_struct secretmem_vm_ops = {
+	.fault = secretmem_fault,
+};
+
+static int secretmem_mmap(struct file *file, struct vm_area_struct *vma)
+{
+	struct secretmem_state *state = file->private_data;
+	unsigned long mode = state->mode;
+
+	if (!mode)
+		return -EINVAL;
+
+	switch (mode) {
+	case SECRETMEM_UNCACHED:
+		vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
+		/* fallthrough */
+	case SECRETMEM_EXCLUSIVE:
+		vma->vm_ops = &secretmem_vm_ops;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static long secretmem_ioctl(struct file *file, unsigned cmd, unsigned long arg)
+{
+	struct secretmem_state *state = file->private_data;
+	unsigned long mode = state->mode;
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
+	state->mode = mode;
+
+	return 0;
+}
+
+static int secretmem_release(struct inode *inode, struct file *file)
+{
+	struct secretmem_state *state = file->private_data;
+
+	kfree(state);
+
+	return 0;
+}
+
+const struct file_operations secretmem_fops = {
+	.release	= secretmem_release,
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
+	struct secretmem_state *state;
+
+	if (IS_ERR(inode))
+		return ERR_CAST(inode);
+
+	state = kzalloc(sizeof(*state), GFP_KERNEL);
+	if (!state)
+		goto err_free_inode;
+
+	file = alloc_file_pseudo(inode, secretmem_mnt, "secretmem",
+				 O_RDWR, &secretmem_fops);
+	if (IS_ERR(file))
+		goto err_free_state;
+
+	mapping_set_unevictable(inode->i_mapping);
+
+	inode->i_mapping->private_data = state;
+	inode->i_mapping->a_ops = &secretmem_aops;
+
+	/* pretend we are a normal file with zero size */
+	inode->i_mode |= S_IFREG;
+	inode->i_size = 0;
+
+	file->private_data = state;
+
+	return file;
+
+err_free_state:
+	kfree(state);
+err_free_inode:
+	iput(inode);
+	return file;
+}
+
+static int secretmem_init_fs_context(struct fs_context *fc)
+{
+	return init_pseudo(fc, SECRETMEM_MAGIC) ? 0 : -ENOMEM;
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
2.24.0


-- 
Sincerely yours,
Mike.

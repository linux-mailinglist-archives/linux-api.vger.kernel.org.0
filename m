Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E2F0311439E
	for <lists+linux-api@lfdr.de>; Thu,  5 Dec 2019 16:34:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729047AbfLEPeN (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 5 Dec 2019 10:34:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:60224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726028AbfLEPeM (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 5 Dec 2019 10:34:12 -0500
Received: from rapoport-lnx (nesher1.haifa.il.ibm.com [195.110.40.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E915B21823;
        Thu,  5 Dec 2019 15:34:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575560051;
        bh=4YGKZOcuDObRc45svNyo/31sR/2ry3qXGOa836Pg/SQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PXIxXcuHqyeWxcmzT84/OQfHg6J7fNjIS+eOCFw9BM4jt+mGJN/5q7OUNO/mPxKjv
         cbh7ZUsX3pniXKSPcgy5U0gUQfJ/SPwsWH4m+wl7bwE6+el1ZCQw/GYX4BAzmFuJnE
         dM36b9KCicFJhWs3hZ52XUhCWbsgF0sEIw1TgihY=
Date:   Thu, 5 Dec 2019 17:34:01 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        James Bottomley <jejb@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linux API <linux-api@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, X86 ML <x86@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Alan Cox <alan@linux.intel.com>,
        "Reshetova, Elena" <elena.reshetova@intel.com>,
        Tycho Andersen <tycho@tycho.ws>,
        Christopher Lameter <cl@linux.com>
Subject: Re: [PATCH RFC] mm: add MAP_EXCLUSIVE to create exclusive user
 mappings
Message-ID: <20191205153400.GA25575@rapoport-lnx>
References: <1572171452-7958-1-git-send-email-rppt@kernel.org>
 <CA5C22D9-BC3E-4B69-8DD9-4D3B75E40BD5@amacapital.net>
 <20191029093254.GE18773@rapoport-lnx>
 <CALCETrUuuc4DS0cdMBtS550Wkp0x9ND3M3SgtaMgyRROnDR5Kg@mail.gmail.com>
 <20191030084005.GC20624@rapoport-lnx>
 <CALCETrXajrY+0SmzkL7t++ndYwRoYLLE9VPKwSGSyW8HZx-TeA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrXajrY+0SmzkL7t++ndYwRoYLLE9VPKwSGSyW8HZx-TeA@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, Oct 30, 2019 at 02:28:21PM -0700, Andy Lutomirski wrote:
> 
> IMO a major benefit of a chardev approach is that you don't need a new
> VM_ flag and you don't need to worry about wiring it up everywhere in
> the core mm code.

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

Of course this is something that must be addresses, as well as
modifications to core mm to required keep the secret memory secret, but I'd
really like to focus on the userspace ABI first.

From 0e1bd1b63f38685ffc5aab8c89b31086bde3da7b Mon Sep 17 00:00:00 2001
From: Mike Rapoport <rppt@linux.ibm.com>
Date: Mon, 18 Nov 2019 09:32:22 +0200
Subject: [PATCH] mm: extend memfd with ability to create secret memory

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 include/linux/memfd.h      |   9 ++
 include/uapi/linux/magic.h |   1 +
 include/uapi/linux/memfd.h |   6 +
 mm/Kconfig                 |   3 +
 mm/Makefile                |   1 +
 mm/memfd.c                 |  10 +-
 mm/secretmem.c             | 233 +++++++++++++++++++++++++++++++++++++
 7 files changed, 261 insertions(+), 2 deletions(-)
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
index 903cc2d2750b..3dad6208c8de 100644
--- a/include/uapi/linux/magic.h
+++ b/include/uapi/linux/magic.h
@@ -94,5 +94,6 @@
 #define ZSMALLOC_MAGIC		0x58295829
 #define DMA_BUF_MAGIC		0x444d4142	/* "DMAB" */
 #define Z3FOLD_MAGIC		0x33
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
index a5dae9a7eb51..aa828f240287 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -736,4 +736,7 @@ config ARCH_HAS_PTE_SPECIAL
 config ARCH_HAS_HUGEPD
 	bool
 
+config MEMFD_SECRETMEM
+        def_bool MEMFD_CREATE && ARCH_HAS_SET_DIRECT_MAP
+
 endmenu
diff --git a/mm/Makefile b/mm/Makefile
index d996846697ef..54cb8a60d698 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -107,3 +107,4 @@ obj-$(CONFIG_PERCPU_STATS) += percpu-stats.o
 obj-$(CONFIG_ZONE_DEVICE) += memremap.o
 obj-$(CONFIG_HMM_MIRROR) += hmm.o
 obj-$(CONFIG_MEMFD_CREATE) += memfd.o
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
index 000000000000..e787b8dc925b
--- /dev/null
+++ b/mm/secretmem.c
@@ -0,0 +1,233 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/mm.h>
+#include <linux/fs.h>
+#include <linux/printk.h>
+#include <linux/fs.h>
+#include <linux/mount.h>
+#include <linux/memfd.h>
+#include <linux/pseudo_fs.h>
+#include <linux/set_memory.h>
+#include <uapi/linux/memfd.h>
+#include <uapi/linux/magic.h>
+
+#include <asm/tlb.h>
+
+#define SECRETMEM_EXCLUSIVE	0x1
+#define SECRETMEM_UNCACHED	0x2
+
+struct secretmem_state {
+	unsigned int mode;
+};
+
+static vm_fault_t secretmem_fault(struct vm_fault *vmf)
+{
+	struct secretmem_state *state = vmf->vma->vm_file->private_data;
+	struct address_space *mapping = vmf->vma->vm_file->f_mapping;
+	pgoff_t offset = vmf->pgoff;
+	unsigned long addr;
+	struct page *page;
+	int err;
+
+	page = find_get_page(mapping, offset);
+	if (!page) {
+		page = pagecache_get_page(mapping, offset,
+					  FGP_CREAT|FGP_FOR_MMAP,
+					  vmf->gfp_mask);
+		if (!page)
+			return vmf_error(-ENOMEM);
+
+		__SetPageUptodate(page);
+	}
+
+	if (state->mode == SECRETMEM_EXCLUSIVE)
+		err = set_direct_map_invalid_noflush(page);
+	else if (state->mode == SECRETMEM_UNCACHED)
+		err = set_pages_array_uc(&page, 1);
+	else
+		BUG();
+
+	if (err) {
+		delete_from_page_cache(page);
+		return vmf_error(err);
+	}
+
+	addr = (unsigned long)page_address(page);
+	flush_tlb_kernel_range(addr, addr + PAGE_SIZE);
+
+	vmf->page = page;
+	return  0;
+}
+
+static void secretmem_close(struct vm_area_struct *vma)
+{
+	struct secretmem_state *state = vma->vm_file->private_data;
+	struct address_space *mapping = vma->vm_file->f_mapping;
+	struct page *page;
+	pgoff_t index;
+
+	xa_for_each(&mapping->i_pages, index, page) {
+		get_page(page);
+		lock_page(page);
+
+		if (state->mode == SECRETMEM_EXCLUSIVE)
+			set_direct_map_default_noflush(page);
+		else if (state->mode == SECRETMEM_UNCACHED)
+			set_pages_array_wb(&page, 1);
+		else
+			BUG();
+
+		__ClearPageDirty(page);
+		delete_from_page_cache(page);
+
+		unlock_page(page);
+		put_page(page);
+	}
+}
+
+static const struct vm_operations_struct secretmem_vm_ops = {
+	.fault = secretmem_fault,
+	.close = secretmem_close,
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
+static void secretmem_putback_page(struct page *page)
+{
+}
+
+static const struct address_space_operations secretmem_aops = {
+	.migratepage	= secretmem_migratepage,
+	.isolate_page	= secretmem_isolate_page,
+	.putback_page	= secretmem_putback_page,
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

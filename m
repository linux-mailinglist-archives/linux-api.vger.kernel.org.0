Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A01525D79E
	for <lists+linux-api@lfdr.de>; Fri,  4 Sep 2020 13:41:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730018AbgIDLlb (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 4 Sep 2020 07:41:31 -0400
Received: from mx01.bbu.dsd.mx.bitdefender.com ([91.199.104.161]:49536 "EHLO
        mx01.bbu.dsd.mx.bitdefender.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729582AbgIDLlZ (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 4 Sep 2020 07:41:25 -0400
Received: from smtp.bitdefender.com (smtp01.buh.bitdefender.com [10.17.80.75])
        by mx01.bbu.dsd.mx.bitdefender.com (Postfix) with ESMTPS id 837D3307C93E;
        Fri,  4 Sep 2020 14:31:08 +0300 (EEST)
Received: from localhost.localdomain (unknown [195.189.155.252])
        by smtp.bitdefender.com (Postfix) with ESMTPSA id A0DD33072786;
        Fri,  4 Sep 2020 14:31:07 +0300 (EEST)
From:   =?UTF-8?q?Adalbert=20Laz=C4=83r?= <alazar@bitdefender.com>
To:     linux-mm@kvack.org
Cc:     linux-api@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Graf <graf@amazon.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Mihai=20Don=C8=9Bu?= <mdontu@bitdefender.com>,
        Mircea Cirjaliu <mcirjaliu@bitdefender.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Sargun Dhillon <sargun@sargun.me>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        =?UTF-8?q?Adalbert=20Laz=C4=83r?= <alazar@bitdefender.com>
Subject: [RESEND RFC PATCH 4/5] mm/remote_mapping: use a pidfd to access memory belonging to unrelated process
Date:   Fri,  4 Sep 2020 14:31:15 +0300
Message-Id: <20200904113116.20648-5-alazar@bitdefender.com>
In-Reply-To: <20200904113116.20648-1-alazar@bitdefender.com>
References: <20200904113116.20648-1-alazar@bitdefender.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

From: Mircea Cirjaliu <mcirjaliu@bitdefender.com>

Remote mapping creates a mirror VMA that exposes memory owned by another
process in a zero-copy manner. The pages are mapped in the current process'
address space with no memory management involved and little impact on the
remote process operation. Currently incompatible with THP.

Signed-off-by: Mircea Cirjaliu <mcirjaliu@bitdefender.com>
Signed-off-by: Adalbert Lazăr <alazar@bitdefender.com>
---
 include/linux/remote_mapping.h      |   22 +
 include/uapi/linux/remote_mapping.h |   36 +
 mm/Kconfig                          |   11 +
 mm/Makefile                         |    1 +
 mm/remote_mapping.c                 | 1273 +++++++++++++++++++++++++++
 5 files changed, 1343 insertions(+)
 create mode 100644 include/linux/remote_mapping.h
 create mode 100644 include/uapi/linux/remote_mapping.h
 create mode 100644 mm/remote_mapping.c

diff --git a/include/linux/remote_mapping.h b/include/linux/remote_mapping.h
new file mode 100644
index 000000000000..5c1d43e8f669
--- /dev/null
+++ b/include/linux/remote_mapping.h
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef _LINUX_REMOTE_MAPPING_H
+#define _LINUX_REMOTE_MAPPING_H
+
+#include <linux/sched.h>
+
+#ifdef CONFIG_REMOTE_MAPPING
+
+extern int task_remote_map(struct task_struct *task, int fds[]);
+
+#else /* CONFIG_REMOTE_MAPPING */
+
+static inline int task_remote_map(struct task_struct *task, int fds[])
+{
+	return -EINVAL;
+}
+
+#endif /* CONFIG_REMOTE_MAPPING */
+
+
+#endif /* _LINUX_REMOTE_MAPPING_H */
diff --git a/include/uapi/linux/remote_mapping.h b/include/uapi/linux/remote_mapping.h
new file mode 100644
index 000000000000..5d2828a6aa47
--- /dev/null
+++ b/include/uapi/linux/remote_mapping.h
@@ -0,0 +1,36 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+
+#ifndef __UAPI_REMOTE_MAPPING_H__
+#define __UAPI_REMOTE_MAPPING_H__
+
+#include <linux/types.h>
+#include <linux/ioctl.h>
+
+// device file interface
+#define REMOTE_PROC_MAP	_IOW('r', 0x01, int)
+
+
+// pidfd interface
+#define PIDFD_IO_MAGIC	'p'
+
+struct pidfd_mem_map {
+	uint64_t address;
+	off_t offset;
+	off_t size;
+	int flags;
+	int padding[7];
+};
+
+struct pidfd_mem_unmap {
+	off_t offset;
+	off_t size;
+};
+
+#define PIDFD_MEM_MAP	_IOW(PIDFD_IO_MAGIC, 0x01, struct pidfd_mem_map)
+#define PIDFD_MEM_UNMAP _IOW(PIDFD_IO_MAGIC, 0x02, struct pidfd_mem_unmap)
+#define PIDFD_MEM_LOCK	_IOW(PIDFD_IO_MAGIC, 0x03, int)
+
+#define PIDFD_MEM_REMAP _IOW(PIDFD_IO_MAGIC, 0x04, unsigned long)
+// TODO: actually this is not for pidfd, find better names
+
+#endif /* __UAPI_REMOTE_MAPPING_H__ */
diff --git a/mm/Kconfig b/mm/Kconfig
index c1acc34c1c35..0ecc3f41a98e 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -804,6 +804,17 @@ config HMM_MIRROR
 	bool
 	depends on MMU
 
+config REMOTE_MAPPING
+	bool "Remote memory mapping"
+	depends on X86_64 && MMU && !TRANSPARENT_HUGEPAGE
+	select MMU_NOTIFIER
+	default n
+	help
+	  Allows a client process to gain access to an unrelated process'
+	  address space on a range-basis. The feature maps pages found at
+	  the remote equivalent address in the current process' page tables
+	  in a lightweight manner.
+
 config DEVICE_PRIVATE
 	bool "Unaddressable device memory (GPU memory, ...)"
 	depends on ZONE_DEVICE
diff --git a/mm/Makefile b/mm/Makefile
index fccd3756b25f..ce1a00e7bc8c 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -112,3 +112,4 @@ obj-$(CONFIG_MEMFD_CREATE) += memfd.o
 obj-$(CONFIG_MAPPING_DIRTY_HELPERS) += mapping_dirty_helpers.o
 obj-$(CONFIG_PTDUMP_CORE) += ptdump.o
 obj-$(CONFIG_PAGE_REPORTING) += page_reporting.o
+obj-$(CONFIG_REMOTE_MAPPING) += remote_mapping.o
diff --git a/mm/remote_mapping.c b/mm/remote_mapping.c
new file mode 100644
index 000000000000..1dc53992424b
--- /dev/null
+++ b/mm/remote_mapping.c
@@ -0,0 +1,1273 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Remote memory mapping.
+ *
+ * Copyright (C) 2017-2020 Bitdefender S.R.L.
+ *
+ * Author:
+ *   Mircea Cirjaliu <mcirjaliu@bitdefender.com>
+ */
+#define pr_fmt(fmt)	KBUILD_MODNAME ": " fmt
+
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/spinlock.h>
+#include <linux/mutex.h>
+#include <linux/module.h>
+#include <linux/printk.h>
+#include <linux/mm.h>
+#include <linux/mman.h>
+#include <linux/pid.h>
+#include <linux/file.h>
+#include <linux/mmu_notifier.h>
+#include <linux/sched/task.h>
+#include <linux/sched/mm.h>
+#include <linux/sched/signal.h>
+#include <linux/interval_tree_generic.h>
+#include <linux/refcount.h>
+#include <linux/miscdevice.h>
+#include <uapi/linux/remote_mapping.h>
+#include <linux/pfn_t.h>
+#include <linux/errno.h>
+#include <linux/limits.h>
+#include <linux/anon_inodes.h>
+#include <linux/fdtable.h>
+#include <asm/tlb.h>
+#include "internal.h"
+
+struct remote_file_context {
+	refcount_t refcount;
+
+	struct srcu_struct fault_srcu;
+	struct mm_struct *mm;
+
+	bool locked;
+	struct rb_root_cached rb_view;		/* view offset tree */
+	struct mutex views_lock;
+
+};
+
+struct remote_view {
+	refcount_t refcount;
+
+	unsigned long address;
+	unsigned long size;
+	unsigned long offset;
+	bool valid;
+
+	struct rb_node target_rb;		/* link for views tree */
+	unsigned long rb_subtree_last;		/* in remote_file_context */
+
+	struct mmu_interval_notifier mmin;
+	spinlock_t user_lock;
+
+	/*
+	 * interval tree for mapped ranges (indexed by source process HVA)
+	 * because of GPA->HVA aliasing, multiple ranges may overlap
+	 */
+	struct rb_root_cached rb_rmap;		/* rmap tree */
+	struct rw_semaphore rmap_lock;
+};
+
+struct remote_vma_context {
+	struct vm_area_struct *vma;		/* link back to VMA */
+	struct remote_view *view;		/* corresponding view */
+
+	struct rb_node rmap_rb;			/* link for rmap tree */
+	unsigned long rb_subtree_last;
+};
+
+/* view offset tree */
+static inline unsigned long view_start(struct remote_view *view)
+{
+	return view->offset + 1;
+}
+
+static inline unsigned long view_last(struct remote_view *view)
+{
+	return view->offset + view->size - 1;
+}
+
+INTERVAL_TREE_DEFINE(struct remote_view, target_rb,
+	unsigned long, rb_subtree_last, view_start, view_last,
+	static inline, view_interval_tree)
+
+#define view_tree_foreach(view, root, start, last)			\
+	for (view = view_interval_tree_iter_first(root, start, last);	\
+	     view; view = view_interval_tree_iter_next(view, start, last))
+
+/* rmap interval tree */
+static inline unsigned long ctx_start(struct remote_vma_context *ctx)
+{
+	struct vm_area_struct *vma = ctx->vma;
+	struct remote_view *view = ctx->view;
+	unsigned long offset = vma->vm_pgoff << PAGE_SHIFT;
+
+	return offset - view->offset + view->address;
+}
+
+static inline unsigned long ctx_last(struct remote_vma_context *ctx)
+{
+	struct vm_area_struct *vma = ctx->vma;
+	struct remote_view *view = ctx->view;
+	unsigned long offset;
+
+	offset = (vma->vm_pgoff << PAGE_SHIFT) + (vma->vm_end - vma->vm_start);
+
+	return offset - view->offset + view->address;
+}
+
+static inline unsigned long ctx_rmap_start(struct remote_vma_context *ctx)
+{
+	return ctx_start(ctx) + 1;
+}
+
+static inline unsigned long ctx_rmap_last(struct remote_vma_context *ctx)
+{
+	return ctx_last(ctx) - 1;
+}
+
+INTERVAL_TREE_DEFINE(struct remote_vma_context, rmap_rb,
+	unsigned long, rb_subtree_last, ctx_rmap_start, ctx_rmap_last,
+	static inline, rmap_interval_tree)
+
+#define rmap_foreach(ctx, root, start, last)				\
+	for (ctx = rmap_interval_tree_iter_first(root, start, last);	\
+	     ctx; ctx = rmap_interval_tree_iter_next(ctx, start, last))
+
+static int mirror_zap_pte(struct vm_area_struct *vma, unsigned long addr,
+			  pte_t *pte, int rss[], struct mmu_gather *tlb,
+			  struct zap_details *details)
+{
+	pte_t ptent = *pte;
+	struct page *page;
+	int flags = 0;
+
+	page = vm_normal_page(vma, addr, ptent);
+	//ptent = ptep_get_and_clear_full(mm, addr, pte, tlb->fullmm);
+	ptent = ptep_clear_flush_notify(vma, addr, pte);
+	//tlb_remove_tlb_entry(tlb, pte, addr);
+
+	if (pte_dirty(ptent)) {
+		flags |= ZAP_PTE_FLUSH;
+		set_page_dirty(page);
+	}
+
+	return flags;
+}
+
+static void
+zap_remote_range(struct vm_area_struct *vma,
+		 unsigned long start, unsigned long end,
+		 bool atomic)
+{
+	struct mmu_notifier_range range;
+	struct mmu_gather tlb;
+	struct zap_details details = {
+		.atomic = atomic,
+	};
+
+	pr_debug("%s: vma %lx-%lx, zap range %lx-%lx\n",
+		__func__, vma->vm_start, vma->vm_end, start, end);
+
+	tlb_gather_mmu(&tlb, vma->vm_mm, start, end);
+
+	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0,
+				vma, vma->vm_mm, start, end);
+	if (atomic)
+		mmu_notifier_invalidate_range_start_nonblock(&range);
+	else
+		mmu_notifier_invalidate_range_start(&range);
+
+	unmap_page_range(&tlb, vma, start, end, &details);
+
+	mmu_notifier_invalidate_range_end(&range);
+	tlb_finish_mmu(&tlb, start, end);
+}
+
+static bool
+mirror_clear_view(struct remote_view *view,
+		  unsigned long start, unsigned long last, bool atomic)
+{
+	struct remote_vma_context *ctx;
+	unsigned long src_start, src_last;
+	unsigned long vma_start, vma_last;
+
+	pr_debug("%s: view %p [%lx-%lx), range [%lx-%lx)", __func__, view,
+		 view->offset, view->offset + view->size, start, last);
+
+	if (likely(!atomic))
+		down_read(&view->rmap_lock);
+	else if (!down_read_trylock(&view->rmap_lock))
+		return false;
+
+	rmap_foreach(ctx, &view->rb_rmap, start, last) {
+		struct vm_area_struct *vma = ctx->vma;
+
+		// intersect intervals (source process address range)
+		src_start = max(start, ctx_start(ctx));
+		src_last = min(last, ctx_last(ctx));
+
+		// translate to destination process address range
+		vma_start = vma->vm_start + (src_start - ctx_start(ctx));
+		vma_last = vma->vm_end - (ctx_last(ctx) - src_last);
+
+		zap_remote_range(vma, vma_start, vma_last, atomic);
+	}
+
+	up_read(&view->rmap_lock);
+
+	return true;
+}
+
+static bool mmin_invalidate(struct mmu_interval_notifier *interval_sub,
+			    const struct mmu_notifier_range *range,
+			    unsigned long cur_seq)
+{
+	struct remote_view *view =
+		container_of(interval_sub, struct remote_view, mmin);
+
+	pr_debug("%s: reason %d, range [%lx-%lx)\n", __func__,
+		 range->event, range->start, range->end);
+
+	spin_lock(&view->user_lock);
+	mmu_interval_set_seq(interval_sub, cur_seq);
+	spin_unlock(&view->user_lock);
+
+	/* mark view as invalid before zapping the page tables */
+	if (range->event == MMU_NOTIFY_RELEASE)
+		WRITE_ONCE(view->valid, false);
+
+	return mirror_clear_view(view, range->start, range->end,
+				 !mmu_notifier_range_blockable(range));
+}
+
+static const struct mmu_interval_notifier_ops mmin_ops = {
+	.invalidate = mmin_invalidate,
+};
+
+static void view_init(struct remote_view *view)
+{
+	refcount_set(&view->refcount, 1);
+	view->valid = true;
+	RB_CLEAR_NODE(&view->target_rb);
+	view->rb_rmap = RB_ROOT_CACHED;
+	init_rwsem(&view->rmap_lock);
+	spin_lock_init(&view->user_lock);
+}
+
+/* return working view or reason why it failed */
+static struct remote_view *
+view_alloc(struct mm_struct *mm, unsigned long address, unsigned long size, unsigned long offset)
+{
+	struct remote_view *view;
+	int result;
+
+	view = kzalloc(sizeof(*view), GFP_KERNEL);
+	if (!view)
+		return ERR_PTR(-ENOMEM);
+
+	view_init(view);
+
+	view->address = address;
+	view->size = size;
+	view->offset = offset;
+
+	pr_debug("%s: view %p [%lx-%lx)", __func__, view,
+		 view->offset, view->offset + view->size);
+
+	result = mmu_interval_notifier_insert(&view->mmin, mm, address, size, &mmin_ops);
+	if (result) {
+		kfree(view);
+		return ERR_PTR(result);
+	}
+
+	return view;
+}
+
+static void
+view_insert(struct remote_file_context *fctx, struct remote_view *view)
+{
+	view_interval_tree_insert(view, &fctx->rb_view);
+	refcount_inc(&view->refcount);
+}
+
+static struct remote_view *
+view_search_get(struct remote_file_context *fctx,
+	unsigned long start, unsigned long last)
+{
+	struct remote_view *view;
+
+	lockdep_assert_held(&fctx->views_lock);
+
+	/*
+	 * loop & return the first view intersecting interval
+	 * further checks will be done down the road
+	 */
+	view_tree_foreach(view, &fctx->rb_view, start, last)
+		break;
+
+	if (view)
+		refcount_inc(&view->refcount);
+
+	return view;
+}
+
+static void
+view_put(struct remote_view *view)
+{
+	if (refcount_dec_and_test(&view->refcount)) {
+		pr_debug("%s: view %p [%lx-%lx) bye bye", __func__, view,
+			 view->offset, view->offset + view->size);
+
+		mmu_interval_notifier_remove(&view->mmin);
+		kfree(view);
+	}
+}
+
+static void
+view_remove(struct remote_file_context *fctx, struct remote_view *view)
+{
+	view_interval_tree_remove(view, &fctx->rb_view);
+	RB_CLEAR_NODE(&view->target_rb);
+	view_put(view);
+}
+
+static bool
+view_overlaps(struct remote_file_context *fctx,
+	unsigned long start, unsigned long last)
+{
+	struct remote_view *view;
+
+	view_tree_foreach(view, &fctx->rb_view, start, last)
+		return true;
+
+	return false;
+}
+
+static struct remote_view *
+alloc_identity_view(struct mm_struct *mm)
+{
+	return view_alloc(mm, 0, ULONG_MAX, 0);
+}
+
+static void remote_file_context_init(struct remote_file_context *fctx)
+{
+	refcount_set(&fctx->refcount, 1);
+	init_srcu_struct(&fctx->fault_srcu);
+	fctx->locked = false;
+	fctx->rb_view = RB_ROOT_CACHED;
+	mutex_init(&fctx->views_lock);
+}
+
+static struct remote_file_context *remote_file_context_alloc(void)
+{
+	struct remote_file_context *fctx;
+
+	fctx = kzalloc(sizeof(*fctx), GFP_KERNEL);
+	if (fctx)
+		remote_file_context_init(fctx);
+
+	pr_debug("%s: fctx %p\n", __func__, fctx);
+
+	return fctx;
+}
+
+static void remote_file_context_get(struct remote_file_context *fctx)
+{
+	refcount_inc(&fctx->refcount);
+}
+
+static void remote_file_context_put(struct remote_file_context *fctx)
+{
+	struct remote_view *view, *n;
+
+	if (refcount_dec_and_test(&fctx->refcount)) {
+		pr_debug("%s: fctx %p\n", __func__, fctx);
+
+		rbtree_postorder_for_each_entry_safe(view, n,
+			&fctx->rb_view.rb_root, target_rb)
+			view_put(view);
+
+		if (fctx->mm)
+			mmdrop(fctx->mm);
+
+		kfree(fctx);
+	}
+}
+
+static void remote_vma_context_init(struct remote_vma_context *ctx)
+{
+	RB_CLEAR_NODE(&ctx->rmap_rb);
+}
+
+static struct remote_vma_context *remote_vma_context_alloc(void)
+{
+	struct remote_vma_context *ctx;
+
+	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
+	if (ctx)
+		remote_vma_context_init(ctx);
+
+	return ctx;
+}
+
+static void remote_vma_context_free(struct remote_vma_context *ctx)
+{
+	kfree(ctx);
+}
+
+static int mirror_dev_open(struct inode *inode, struct file *file)
+{
+	struct remote_file_context *fctx;
+
+	pr_debug("%s: file %p\n", __func__, file);
+
+	fctx = remote_file_context_alloc();
+	if (!fctx)
+		return -ENOMEM;
+	file->private_data = fctx;
+
+	return 0;
+}
+
+static int do_remote_proc_map(struct file *file, int pid)
+{
+	struct remote_file_context *fctx = file->private_data;
+	struct task_struct *req_task;
+	struct mm_struct *req_mm;
+	struct remote_view *id;
+	int result = 0;
+
+	pr_debug("%s: pid %d\n", __func__, pid);
+
+	req_task = find_get_task_by_vpid(pid);
+	if (!req_task)
+		return -ESRCH;
+
+	req_mm = get_task_mm(req_task);
+	put_task_struct(req_task);
+	if (!req_mm)
+		return -EINVAL;
+
+	/* error on 2nd call or multithreaded race */
+	if (cmpxchg(&fctx->mm, (struct mm_struct *)NULL, req_mm) != NULL) {
+		result = -EALREADY;
+		goto out;
+	} else
+		mmgrab(req_mm);
+
+	id = alloc_identity_view(req_mm);
+	if (IS_ERR(id)) {
+		mmdrop(req_mm);
+		result = PTR_ERR(id);
+		goto out;
+	}
+
+	/* one view only, don't need to take mutex */
+	view_insert(fctx, id);
+	view_put(id);			/* usage reference */
+
+out:
+	mmput(req_mm);
+
+	return result;
+}
+
+static long mirror_dev_ioctl(struct file *file, unsigned int ioctl,
+	unsigned long arg)
+{
+	long result;
+
+	switch (ioctl) {
+	case REMOTE_PROC_MAP: {
+		int pid = (int)arg;
+
+		result = do_remote_proc_map(file, pid);
+		break;
+	}
+
+	default:
+		pr_debug("%s: ioctl %x not implemented\n", __func__, ioctl);
+		result = -ENOTTY;
+	}
+
+	return result;
+}
+
+/*
+ * This is called after all reference to the file have been dropped,
+ * including mmap()s, even if the file is close()d first.
+ */
+static int mirror_dev_release(struct inode *inode, struct file *file)
+{
+	struct remote_file_context *fctx = file->private_data;
+
+	pr_debug("%s: file %p\n", __func__, file);
+
+	remote_file_context_put(fctx);
+
+	return 0;
+}
+
+static struct page *mm_remote_get_page(struct mm_struct *req_mm,
+	unsigned long address, unsigned int flags)
+{
+	struct page *req_page = NULL;
+	long nrpages;
+
+	might_sleep();
+
+	flags |= FOLL_ANON | FOLL_MIGRATION;
+
+	/* get host page corresponding to requested address */
+	nrpages = get_user_pages_remote(NULL, req_mm, address, 1,
+		flags, &req_page, NULL, NULL);
+	if (unlikely(nrpages == 0)) {
+		pr_err("no page at %lx\n", address);
+		return ERR_PTR(-ENOENT);
+	}
+	if (IS_ERR_VALUE(nrpages)) {
+		pr_err("get_user_pages_remote() failed: %d\n", (int)nrpages);
+		return ERR_PTR(nrpages);
+	}
+
+	/* limit introspection to anon memory (this also excludes zero-page) */
+	if (!PageAnon(req_page)) {
+		put_page(req_page);
+		pr_err("page at %lx not anon\n", address);
+		return ERR_PTR(-EINVAL);
+	}
+
+	return req_page;
+}
+
+/*
+ * avoid PTE allocation in this function for 2 reasons:
+ * - it runs under user_lock, which is a spinlock and can't sleep
+ *   (user_lock can be a mutex is allocation is needed)
+ * - PTE allocation triggers reclaim, which causes a possible deadlock warning
+ */
+static vm_fault_t remote_map_page(struct vm_fault *vmf, struct page *page)
+{
+	struct vm_area_struct *vma = vmf->vma;
+	pte_t entry;
+
+	if (vmf->prealloc_pte) {
+		vmf->ptl = pmd_lock(vma->vm_mm, vmf->pmd);
+		if (unlikely(!pmd_none(*vmf->pmd))) {
+			spin_unlock(vmf->ptl);
+			goto map_pte;
+		}
+
+		mm_inc_nr_ptes(vma->vm_mm);
+		pmd_populate(vma->vm_mm, vmf->pmd, vmf->prealloc_pte);
+		spin_unlock(vmf->ptl);
+		vmf->prealloc_pte = NULL;
+	} else {
+		BUG_ON(pmd_none(*vmf->pmd));
+	}
+
+map_pte:
+	vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd, vmf->address, &vmf->ptl);
+
+	if (!pte_none(*vmf->pte))
+		goto out_unlock;
+
+	entry = mk_pte(page, vma->vm_page_prot);
+	set_pte_at_notify(vma->vm_mm, vmf->address, vmf->pte, entry);
+
+out_unlock:
+	pte_unmap_unlock(vmf->pte, vmf->ptl);
+	return VM_FAULT_NOPAGE;
+}
+
+static vm_fault_t mirror_vm_fault(struct vm_fault *vmf)
+{
+	struct vm_area_struct *vma = vmf->vma;
+	struct mm_struct *mm = vma->vm_mm;
+	struct remote_vma_context *ctx = vma->vm_private_data;
+	struct remote_view *view = ctx->view;
+	struct file *file = vma->vm_file;
+	struct remote_file_context *fctx = file->private_data;
+	unsigned long req_addr;
+	unsigned int gup_flags;
+	struct page *req_page;
+	vm_fault_t result = VM_FAULT_SIGBUS;
+	struct mm_struct *src_mm = fctx->mm;
+	unsigned long seq;
+	int idx;
+
+fault_retry:
+	seq = mmu_interval_read_begin(&view->mmin);
+
+	idx = srcu_read_lock(&fctx->fault_srcu);
+
+	/* check if view was invalidated */
+	if (unlikely(!READ_ONCE(view->valid))) {
+		pr_debug("%s: region [%lx-%lx) was invalidated!!\n", __func__,
+			view->offset, view->offset + view->size);
+		goto out_invalid;		/* VM_FAULT_SIGBUS */
+	}
+
+	/* drop current mm semapchore */
+	up_read(&current->mm->mmap_sem);
+
+	/* take remote mm semaphore */
+	if (vmf->flags & FAULT_FLAG_ALLOW_RETRY) {
+		if (!down_read_trylock(&src_mm->mmap_sem)) {
+			pr_debug("%s: couldn't take source semaphore!!\n", __func__);
+			goto out_retry;
+		}
+	} else
+		down_read(&src_mm->mmap_sem);
+
+	/* set GUP flags depending on the VMA */
+	gup_flags = 0;
+	if (vma->vm_flags & VM_WRITE)
+		gup_flags |= FOLL_WRITE | FOLL_FORCE;
+
+	/* translate file offset to source process HVA */
+	req_addr = (vmf->pgoff << PAGE_SHIFT) - view->offset + view->address;
+	req_page = mm_remote_get_page(src_mm, req_addr, gup_flags);
+
+	/* check for validity of the page */
+	if (IS_ERR_OR_NULL(req_page)) {
+		up_read(&src_mm->mmap_sem);
+
+		if (PTR_ERR(req_page) == -ERESTARTSYS ||
+		    PTR_ERR(req_page) == -EBUSY) {
+			goto out_retry;
+		} else
+			goto out_err;	/* VM_FAULT_SIGBUS */
+	}
+
+	up_read(&src_mm->mmap_sem);
+
+	/* retake current mm semapchore */
+	down_read(&current->mm->mmap_sem);
+
+	/* expedite retry */
+	if (mmu_interval_check_retry(&view->mmin, seq)) {
+		put_page(req_page);
+
+		srcu_read_unlock(&fctx->fault_srcu, idx);
+
+		goto fault_retry;
+	}
+
+	/* make sure the VMA hasn't gone away */
+	vma = find_vma(current->mm, vmf->address);
+	if (vma == vmf->vma) {
+		spin_lock(&view->user_lock);
+
+		if (mmu_interval_read_retry(&view->mmin, seq)) {
+			spin_unlock(&view->user_lock);
+
+			put_page(req_page);
+
+			srcu_read_unlock(&fctx->fault_srcu, idx);
+
+			goto fault_retry;
+		}
+
+		result = remote_map_page(vmf, req_page);  /* install PTE here */
+
+		spin_unlock(&view->user_lock);
+	}
+
+	put_page(req_page);
+
+	srcu_read_unlock(&fctx->fault_srcu, idx);
+
+	return result;
+
+out_err:
+	/* retake current mm semapchore */
+	down_read(&current->mm->mmap_sem);
+out_invalid:
+	srcu_read_unlock(&fctx->fault_srcu, idx);
+
+	return result;
+
+out_retry:
+	/* retake current mm semapchore */
+	down_read(&current->mm->mmap_sem);
+
+	srcu_read_unlock(&fctx->fault_srcu, idx);
+
+	/* TODO: some optimizations work here when we arrive with FAULT_FLAG_ALLOW_RETRY */
+	/* TODO: mmap_sem doesn't need to be taken, then dropped */
+
+	/*
+	 * If FAULT_FLAG_ALLOW_RETRY is set, the mmap_sem must be released
+	 * before returning VM_FAULT_RETRY only if FAULT_FLAG_RETRY_NOWAIT is
+	 * not set.
+	 *
+	 * If FAULT_FLAG_ALLOW_RETRY is set but FAULT_FLAG_KILLABLE is not
+	 * set, VM_FAULT_RETRY can still be returned if and only if there are
+	 * fatal_signal_pending()s, and the mmap_sem must be released before
+	 * returning it.
+	 */
+	if (vmf->flags & (FAULT_FLAG_ALLOW_RETRY | FAULT_FLAG_TRIED)) {
+		if (!(vmf->flags & FAULT_FLAG_KILLABLE))
+			if (current && fatal_signal_pending(current)) {
+				up_read(&current->mm->mmap_sem);
+				return VM_FAULT_RETRY;
+			}
+
+		if (!(vmf->flags & FAULT_FLAG_RETRY_NOWAIT))
+			up_read(&mm->mmap_sem);
+
+		return VM_FAULT_RETRY;
+	} else
+		return VM_FAULT_SIGBUS;
+}
+
+/*
+ * This is called in remove_vma() at the end of __do_munmap() after the address
+ * space has been unmapped and the page tables have been freed.
+ */
+static void mirror_vm_close(struct vm_area_struct *vma)
+{
+	struct remote_vma_context *ctx = vma->vm_private_data;
+	struct remote_view *view = ctx->view;
+
+	pr_debug("%s: VMA %lx-%lx (%lu bytes)\n", __func__,
+		vma->vm_start, vma->vm_end, vma->vm_end - vma->vm_start);
+
+	/* will wait for any running invalidate notifiers to finish */
+	down_write(&view->rmap_lock);
+	rmap_interval_tree_remove(ctx, &view->rb_rmap);
+	up_write(&view->rmap_lock);
+	view_put(view);
+
+	remote_vma_context_free(ctx);
+}
+
+/* prevent partial unmap of destination VMA */
+static int mirror_vm_split(struct vm_area_struct *area, unsigned long addr)
+{
+	return -EINVAL;
+}
+
+static const struct vm_operations_struct mirror_vm_ops = {
+	.close = mirror_vm_close,
+	.fault = mirror_vm_fault,
+	.split = mirror_vm_split,
+	.zap_pte = mirror_zap_pte,
+};
+
+static bool is_mirror_vma(struct vm_area_struct *vma)
+{
+	return vma->vm_ops == &mirror_vm_ops;
+}
+
+static struct remote_view *
+getme_matching_view(struct remote_file_context *fctx,
+		    unsigned long start, unsigned long last)
+{
+	struct remote_view *view;
+
+	/* lookup view for the VMA offset range */
+	view = view_search_get(fctx, start, last);
+	if (!view)
+		return NULL;
+
+	/* make sure the interval we're after is contained in the view */
+	if (start < view->offset || last > view->offset + view->size) {
+		view_put(view);
+		return NULL;
+	}
+
+	return view;
+}
+
+static struct remote_view *
+getme_exact_view(struct remote_file_context *fctx,
+		 unsigned long start, unsigned long last)
+{
+	struct remote_view *view;
+
+	/* lookup view for the VMA offset range */
+	view = view_search_get(fctx, start, last);
+	if (!view)
+		return NULL;
+
+	/* make sure the interval we're after is contained in the view */
+	if (start != view->offset || last != view->offset + view->size) {
+		view_put(view);
+		return NULL;
+	}
+
+	return view;
+}
+
+static int mirror_dev_mmap(struct file *file, struct vm_area_struct *vma)
+{
+	struct remote_file_context *fctx = file->private_data;
+	struct remote_vma_context *ctx;
+	unsigned long start, length, last;
+	struct remote_view *view;
+
+	start = vma->vm_pgoff << PAGE_SHIFT;
+	length = vma->vm_end - vma->vm_start;
+	last = start + length;
+
+	pr_debug("%s: VMA %lx-%lx (%lu bytes), offsets %lx-%lx\n", __func__,
+		vma->vm_start, vma->vm_end, length, start, last);
+
+	if (!(vma->vm_flags & VM_SHARED)) {
+		pr_debug("%s: VMA is not shared\n", __func__);
+		return -EINVAL;
+	}
+
+	/* prepare the context */
+	ctx = remote_vma_context_alloc();
+	if (!ctx)
+		return -ENOMEM;
+
+	/* lookup view for the VMA offset range */
+	mutex_lock(&fctx->views_lock);
+	view = getme_matching_view(fctx, start, last);
+	mutex_unlock(&fctx->views_lock);
+	if (!view) {
+		pr_debug("%s: no view for range %lx-%lx\n", __func__, start, last);
+		remote_vma_context_free(ctx);
+		return -EINVAL;
+	}
+
+	/* VMA must be linked to ctx before adding to rmap tree !! */
+	vma->vm_private_data = ctx;
+	ctx->vma = vma;
+
+	/* view may already be invalidated by the time it's linked */
+	down_write(&view->rmap_lock);
+	ctx->view = view;	/* view reference goes here */
+	rmap_interval_tree_insert(ctx, &view->rb_rmap);
+	up_write(&view->rmap_lock);
+
+	/* set basic VMA properties */
+	vma->vm_flags |= VM_DONTCOPY | VM_DONTDUMP | VM_DONTEXPAND;
+	vma->vm_ops = &mirror_vm_ops;
+
+	return 0;
+}
+
+static const struct file_operations mirror_ops = {
+	.open = mirror_dev_open,
+	.unlocked_ioctl = mirror_dev_ioctl,
+	.compat_ioctl = mirror_dev_ioctl,
+	.llseek = no_llseek,
+	.mmap = mirror_dev_mmap,
+	.release = mirror_dev_release,
+};
+
+static struct miscdevice mirror_dev = {
+	.minor = MISC_DYNAMIC_MINOR,
+	.name = "mirror-proc",
+	.fops = &mirror_ops,
+};
+
+builtin_misc_device(mirror_dev);
+
+static int pidfd_mem_remap(struct remote_file_context *fctx, unsigned long address)
+{
+	struct vm_area_struct *vma;
+	unsigned long start, last;
+	struct remote_vma_context *ctx;
+	struct remote_view *view, *new_view;
+	int result = 0;
+
+	pr_debug("%s: address %lx\n", __func__, address);
+
+	down_write(&current->mm->mmap_sem);
+
+	vma = find_vma(current->mm, address);
+	if (!vma || !is_mirror_vma(vma)) {
+		result = -EINVAL;
+		goto out_vma;
+	}
+
+	ctx = vma->vm_private_data;
+	view = ctx->view;
+
+	if (view->valid)
+		goto out_vma;
+
+	start = vma->vm_pgoff << PAGE_SHIFT;
+	last = start + (vma->vm_end - vma->vm_start);
+
+	/* lookup view for the VMA offset range */
+	mutex_lock(&fctx->views_lock);
+	new_view = getme_matching_view(fctx, start, last);
+	mutex_unlock(&fctx->views_lock);
+	if (!new_view) {
+		result = -EINVAL;
+		goto out_vma;
+	}
+	/* do not link to another invalid view */
+	if (!new_view->valid) {
+		view_put(new_view);
+		result = -EINVAL;
+		goto out_vma;
+	}
+
+	/* we have current->mm->mmap_sem in write mode, so no faults going on */
+	down_write(&view->rmap_lock);
+	rmap_interval_tree_remove(ctx, &view->rb_rmap);
+	up_write(&view->rmap_lock);
+	view_put(view);		/* ctx reference */
+
+	/* replace with the new view */
+	down_write(&new_view->rmap_lock);
+	ctx->view = new_view;	/* new view reference goes here */
+	rmap_interval_tree_insert(ctx, &new_view->rb_rmap);
+	up_write(&new_view->rmap_lock);
+
+out_vma:
+	up_write(&current->mm->mmap_sem);
+
+	return result;
+}
+
+static long
+pidfd_mem_map_ioctl(struct file *file, unsigned int ioctl, unsigned long arg)
+{
+	struct remote_file_context *fctx = file->private_data;
+	long result = 0;
+
+	switch (ioctl) {
+	case PIDFD_MEM_REMAP:
+		result = pidfd_mem_remap(fctx, arg);
+		break;
+
+	default:
+		pr_debug("%s: ioctl %x not implemented\n", __func__, ioctl);
+		result = -ENOTTY;
+	}
+
+	return result;
+}
+
+static void pidfd_mem_lock(struct remote_file_context *fctx)
+{
+	pr_debug("%s:\n", __func__);
+
+	mutex_lock(&fctx->views_lock);
+	fctx->locked = true;
+	mutex_unlock(&fctx->views_lock);
+}
+
+static int pidfd_mem_map(struct remote_file_context *fctx, struct pidfd_mem_map *map)
+{
+	struct remote_view *view;
+	int result = 0;
+
+	pr_debug("%s: offset %lx, size %lx, address %lx\n",
+		__func__, map->offset, map->size, (long)map->address);
+
+	if (!PAGE_ALIGNED(map->offset))
+		return -EINVAL;
+	if (!PAGE_ALIGNED(map->size))
+		return -EINVAL;
+	if (!PAGE_ALIGNED(map->address))
+		return -EINVAL;
+
+	/* make sure we're creating the view for a valid address space */
+	if (!mmget_not_zero(fctx->mm))
+		return -EINVAL;
+
+	view = view_alloc(fctx->mm, map->address, map->size, map->offset);
+	if (IS_ERR(view)) {
+		result = PTR_ERR(view);
+		goto out_mm;
+	}
+
+	mutex_lock(&fctx->views_lock);
+
+	/* locked ? */
+	if (unlikely(fctx->locked)) {
+		pr_debug("%s: views locked\n", __func__);
+		result = -EINVAL;
+		goto out;
+	}
+
+	/* overlaps another view ? */
+	if (view_overlaps(fctx, map->offset, map->offset + map->size)) {
+		pr_debug("%s: range overlaps\n", __func__);
+		result = -EALREADY;
+		goto out;
+	}
+
+	view_insert(fctx, view);
+
+out:
+	mutex_unlock(&fctx->views_lock);
+
+	view_put(view);			/* usage reference */
+out_mm:
+	mmput(fctx->mm);
+
+	return result;
+}
+
+static int pidfd_mem_unmap(struct remote_file_context *fctx, struct pidfd_mem_unmap *unmap)
+{
+	struct remote_view *view;
+
+	pr_debug("%s: offset %lx, size %lx\n",
+		__func__, unmap->offset, unmap->size);
+
+	if (!PAGE_ALIGNED(unmap->offset))
+		return -EINVAL;
+	if (!PAGE_ALIGNED(unmap->size))
+		return -EINVAL;
+
+	mutex_lock(&fctx->views_lock);
+
+	if (unlikely(fctx->locked)) {
+		mutex_unlock(&fctx->views_lock);
+		return -EINVAL;
+	}
+
+	view = getme_exact_view(fctx, unmap->offset, unmap->offset + unmap->size);
+	if (!view) {
+		mutex_unlock(&fctx->views_lock);
+		return -EINVAL;
+	}
+
+	view_remove(fctx, view);
+
+	mutex_unlock(&fctx->views_lock);
+
+	/*
+	 * The view may still be refernced by a mapping VMA, so dropping
+	 * a reference here may not delete it. The view will be marked as
+	 * invalid, together with all the VMAs linked to it.
+	 */
+	WRITE_ONCE(view->valid, false);
+
+	/* wait until local faults finish */
+	synchronize_srcu(&fctx->fault_srcu);
+
+	/*
+	 * because the view is marked as invalid, faults will not succeed, so
+	 * we don't have to worry about synchronizing invalidations/faults
+	 */
+	mirror_clear_view(view, 0, ULONG_MAX, false);
+
+	view_put(view);			/* usage reference */
+
+	return 0;
+}
+
+static long
+pidfd_mem_ctrl_ioctl(struct file *file, unsigned int ioctl, unsigned long arg)
+{
+	struct remote_file_context *fctx = file->private_data;
+	void __user *argp = (void __user *)arg;
+	long result = 0;
+
+	switch (ioctl) {
+	case PIDFD_MEM_MAP: {
+		struct pidfd_mem_map map;
+
+		result = -EINVAL;
+		if (copy_from_user(&map, argp, sizeof(map)))
+			return result;
+
+		result = pidfd_mem_map(fctx, &map);
+		break;
+	}
+
+	case PIDFD_MEM_UNMAP: {
+		struct pidfd_mem_unmap unmap;
+
+		result = -EINVAL;
+		if (copy_from_user(&unmap, argp, sizeof(unmap)))
+			return result;
+
+		result = pidfd_mem_unmap(fctx, &unmap);
+		break;
+	}
+
+	case PIDFD_MEM_LOCK:
+		pidfd_mem_lock(fctx);
+		break;
+
+	default:
+		pr_debug("%s: ioctl %x not implemented\n", __func__, ioctl);
+		result = -ENOTTY;
+	}
+
+	return result;
+}
+
+static int pidfd_mem_ctrl_release(struct inode *inode, struct file *file)
+{
+	struct remote_file_context *fctx = file->private_data;
+
+	pr_debug("%s: file %p\n", __func__, file);
+
+	remote_file_context_put(fctx);
+
+	return 0;
+}
+
+static const struct file_operations pidfd_mem_ctrl_ops = {
+	.owner = THIS_MODULE,
+	.unlocked_ioctl = pidfd_mem_ctrl_ioctl,
+	.compat_ioctl = pidfd_mem_ctrl_ioctl,
+	.llseek = no_llseek,
+	.release = pidfd_mem_ctrl_release,
+};
+
+static unsigned long
+pidfd_mem_get_unmapped_area(struct file *file, unsigned long addr,
+	unsigned long len, unsigned long pgoff, unsigned long flags)
+{
+	struct remote_file_context *fctx = file->private_data;
+	unsigned long start = pgoff << PAGE_SHIFT;
+	unsigned long last = start + len;
+	unsigned long remote_addr, align_offset;
+	struct remote_view *view;
+	struct vm_area_struct *vma;
+	unsigned long result;
+
+	pr_debug("%s: addr %lx, len %lx, pgoff %lx, flags %lx\n",
+		__func__, addr, len, pgoff, flags);
+
+	if (flags & MAP_FIXED) {
+		if (addr == 0)
+			return -ENOMEM;
+		else
+			return addr;
+	}
+
+	// TODO: ellaborate on this case, we must still have alignment !!!!!!!!!
+	// TODO: only if THP enabled
+	if (addr == 0)
+		return current->mm->get_unmapped_area(file, addr, len, pgoff, flags);
+
+	/* use this backing VMA */
+	vma = find_vma(current->mm, addr);
+	if (!vma) {
+		pr_debug("%s: no VMA found at %lx\n", __func__, addr);
+		return -EINVAL;
+	}
+
+	/* VMA was mapped with PROT_NONE */
+	if (vma_is_accessible(vma)) {
+		pr_debug("%s: VMA at %lx is not a backing VMA\n", __func__, addr);
+		return -EINVAL;
+	}
+
+	/*
+	 * if the view somehow gets removed afterwards, we're gonna create a
+	 * VMA for which there's no backing view, so mmap() will fail
+	 */
+	mutex_lock(&fctx->views_lock);
+	view = getme_matching_view(fctx, start, last);
+	mutex_unlock(&fctx->views_lock);
+	if (!view) {
+		pr_debug("%s: no view for range %lx-%lx\n", __func__, start, last);
+		return -EINVAL;
+	}
+
+	/* this should be enough to ensure VMA alignment */
+	remote_addr = start - view->offset + view->address;
+	align_offset = remote_addr % PMD_SIZE;
+
+	if (addr % PMD_SIZE <= align_offset)
+		result = (addr & PMD_MASK) + align_offset;
+	else
+		result = (addr & PMD_MASK) + align_offset + PMD_SIZE;
+
+	view_put(view);		/* usage reference */
+
+	return result;
+}
+
+static const struct file_operations pidfd_mem_map_fops = {
+	.owner = THIS_MODULE,
+	.mmap = mirror_dev_mmap,
+	.get_unmapped_area = pidfd_mem_get_unmapped_area,
+	.unlocked_ioctl = pidfd_mem_map_ioctl,
+	.compat_ioctl = pidfd_mem_map_ioctl,
+	.llseek = no_llseek,
+	.release = mirror_dev_release,
+};
+
+int task_remote_map(struct task_struct *task, int fds[])
+{
+	struct mm_struct *mm;
+	struct remote_file_context *fctx;
+	struct file *ctrl, *map;
+	int ret;
+
+	// allocate common file context
+	fctx = remote_file_context_alloc();
+	if (!fctx)
+		return -ENOMEM;
+
+	// create these 2 fds
+	fds[0] = fds[1] = -1;
+
+	fds[0] = anon_inode_getfd("[pidfd_mem.ctrl]", &pidfd_mem_ctrl_ops, fctx,
+				  O_RDWR | O_CLOEXEC);
+	if (fds[0] < 0) {
+		ret = fds[0];
+		goto out;
+	}
+	remote_file_context_get(fctx);
+
+	ctrl = fget(fds[0]);
+	ctrl->f_mode |= FMODE_WRITE_IOCTL;
+	fput(ctrl);
+
+	fds[1] = anon_inode_getfd("[pidfd_mem.map]", &pidfd_mem_map_fops, fctx,
+				  O_RDWR | O_CLOEXEC | O_LARGEFILE);
+	if (fds[1] < 0) {
+		ret = fds[1];
+		goto out;
+	}
+	remote_file_context_get(fctx);
+
+	map = fget(fds[1]);
+	map->f_mode |= FMODE_LSEEK | FMODE_UNSIGNED_OFFSET | FMODE_RANDOM;
+	fput(map);
+
+	mm = get_task_mm(task);
+	if (!mm) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	/* reference this mm in fctx */
+	mmgrab(mm);
+	fctx->mm = mm;
+
+	mmput(mm);
+	remote_file_context_put(fctx);		/* usage reference */
+
+	return 0;
+
+out:
+	if (fds[0] != -1) {
+		__close_fd(current->files, fds[0]);
+		remote_file_context_put(fctx);
+	}
+
+	if (fds[1] != -1) {
+		__close_fd(current->files, fds[1]);
+		remote_file_context_put(fctx);
+	}
+
+	// TODO: using __close_fd() does not guarantee success, use other means
+	// for file allocation & error recovery
+
+	remote_file_context_put(fctx);
+
+	return ret;
+}

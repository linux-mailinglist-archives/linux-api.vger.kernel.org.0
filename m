Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 25BF023933
	for <lists+linux-api@lfdr.de>; Mon, 20 May 2019 16:02:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391214AbfETOBZ (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 20 May 2019 10:01:25 -0400
Received: from relay.sw.ru ([185.231.240.75]:39924 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390963AbfETOBZ (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Mon, 20 May 2019 10:01:25 -0400
Received: from [172.16.25.169] (helo=localhost.localdomain)
        by relay.sw.ru with esmtp (Exim 4.91)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1hSiqF-00084l-Gn; Mon, 20 May 2019 17:00:39 +0300
Subject: [PATCH v2 7/7] mm: Add process_vm_mmap()
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
To:     akpm@linux-foundation.org, dan.j.williams@intel.com,
        ktkhai@virtuozzo.com, mhocko@suse.com, keith.busch@intel.com,
        kirill.shutemov@linux.intel.com, alexander.h.duyck@linux.intel.com,
        ira.weiny@intel.com, andreyknvl@google.com, arunks@codeaurora.org,
        vbabka@suse.cz, cl@linux.com, riel@surriel.com,
        keescook@chromium.org, hannes@cmpxchg.org, npiggin@gmail.com,
        mathieu.desnoyers@efficios.com, shakeelb@google.com, guro@fb.com,
        aarcange@redhat.com, hughd@google.com, jglisse@redhat.com,
        mgorman@techsingularity.net, daniel.m.jordan@oracle.com,
        jannh@google.com, kilobyte@angband.pl, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Date:   Mon, 20 May 2019 17:00:39 +0300
Message-ID: <155836083941.2441.1939229815005692644.stgit@localhost.localdomain>
In-Reply-To: <155836064844.2441.10911127801797083064.stgit@localhost.localdomain>
References: <155836064844.2441.10911127801797083064.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

This adds a new syscall to duplicate a VMA of other
process to current. Flag PVMMAP_FIXED may be specified,
its meaning is similar to mmap()'s MAP_FIXED.

VMA are merged on destination, i.e. if source task
has VMA with address [start; end], and we map it sequentially
twice:

process_vm_mmap(@pid, start, start + (end - start)/2, ...);
process_vm_mmap(@pid, start + (end - start)/2, end,   ...);

the destination task will have single vma [start, end].

v2:
    Add PVMMAP_FIXED_NOREPLACE flag.
    Use find_vma_without_flags() and may_mmap_overlapped_region() helpers.
    Fix whitespaces.

    Previous version has a possibility to duplicate VMA from
    current to remote process, but there was a error, so I
    removed that. It's needed to advance get_unmapped_area
    to make it working with remote VMA (which I missed
    initially). This requires a lot of refactoring, which
    may hide the main logic away from a reader, so let's
    I do that later in a separate series.

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
---
 include/linux/mm.h                     |    4 +
 include/linux/mm_types.h               |    2 +
 include/uapi/asm-generic/mman-common.h |    6 ++
 mm/mmap.c                              |  107 ++++++++++++++++++++++++++++++++
 mm/process_vm_access.c                 |   69 +++++++++++++++++++++
 5 files changed, 188 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 65ceb56acd44..9d1c79a44128 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2385,6 +2385,10 @@ extern int __do_munmap(struct mm_struct *, unsigned long, size_t,
 		       struct list_head *uf, bool downgrade);
 extern int do_munmap(struct mm_struct *, unsigned long, size_t,
 		     struct list_head *uf);
+extern unsigned long mmap_process_vm(struct mm_struct *, unsigned long,
+				     struct mm_struct *, unsigned long,
+				     unsigned long, unsigned long,
+				     struct list_head *);
 
 static inline unsigned long
 do_mmap_pgoff(struct file *file, unsigned long addr,
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 1815fbc40926..885f256f2fb7 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -261,11 +261,13 @@ struct vm_region {
 
 #ifdef CONFIG_USERFAULTFD
 #define NULL_VM_UFFD_CTX ((struct vm_userfaultfd_ctx) { NULL, })
+#define IS_NULL_VM_UFFD_CTX(uctx) ((uctx)->ctx == NULL)
 struct vm_userfaultfd_ctx {
 	struct userfaultfd_ctx *ctx;
 };
 #else /* CONFIG_USERFAULTFD */
 #define NULL_VM_UFFD_CTX ((struct vm_userfaultfd_ctx) {})
+#define IS_NULL_VM_UFFD_CTX(uctx) (true)
 struct vm_userfaultfd_ctx {};
 #endif /* CONFIG_USERFAULTFD */
 
diff --git a/include/uapi/asm-generic/mman-common.h b/include/uapi/asm-generic/mman-common.h
index abd238d0f7a4..91803e6ada7c 100644
--- a/include/uapi/asm-generic/mman-common.h
+++ b/include/uapi/asm-generic/mman-common.h
@@ -28,6 +28,12 @@
 /* 0x0100 - 0x80000 flags are defined in asm-generic/mman.h */
 #define MAP_FIXED_NOREPLACE	0x100000	/* MAP_FIXED which doesn't unmap underlying mapping */
 
+/*
+ * Flags for process_vm_mmap
+ */
+#define PVMMAP_FIXED		0x01
+#define PVMMAP_FIXED_NOREPLACE	0x02		/* PVMAP_FIXED which doesn't unmap underlying mapping */
+
 /*
  * Flags for mlock
  */
diff --git a/mm/mmap.c b/mm/mmap.c
index 260e47e917e6..3123ecee5fb8 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -3282,6 +3282,113 @@ struct vm_area_struct *copy_vma(struct vm_area_struct **vmap,
 	return NULL;
 }
 
+static int do_mmap_process_vm(struct vm_area_struct *src_vma,
+			      unsigned long src_addr,
+			      struct mm_struct *dst_mm,
+			      unsigned long dst_addr,
+			      unsigned long len,
+			      struct list_head *uf)
+{
+	struct vm_area_struct *dst_vma;
+	unsigned long pgoff, ret;
+	bool unused;
+
+	if (do_munmap(dst_mm, dst_addr, len, uf))
+		return -ENOMEM;
+
+	if (src_vma->vm_flags & VM_ACCOUNT) {
+		if (security_vm_enough_memory_mm(dst_mm, len >> PAGE_SHIFT))
+			return -ENOMEM;
+	}
+
+	pgoff = src_vma->vm_pgoff +
+			((src_addr - src_vma->vm_start) >> PAGE_SHIFT);
+	dst_vma = copy_vma(&src_vma, dst_mm, dst_addr,
+			   len, pgoff, &unused, false);
+	if (!dst_vma) {
+		ret = -ENOMEM;
+		goto unacct;
+	}
+
+	ret = copy_page_range(dst_mm, src_vma->vm_mm, src_vma,
+			      dst_addr, src_addr, src_addr + len);
+	if (ret) {
+		do_munmap(dst_mm, dst_addr, len, uf);
+		return -ENOMEM;
+	}
+
+	if (dst_vma->vm_file)
+		uprobe_mmap(dst_vma);
+	perf_event_mmap(dst_vma);
+
+	dst_vma->vm_flags |= VM_SOFTDIRTY;
+	vma_set_page_prot(dst_vma);
+
+	vm_stat_account(dst_mm, dst_vma->vm_flags, len >> PAGE_SHIFT);
+	return 0;
+
+unacct:
+	vm_unacct_memory(len >> PAGE_SHIFT);
+	return ret;
+}
+
+unsigned long mmap_process_vm(struct mm_struct *src_mm,
+			      unsigned long src_addr,
+			      struct mm_struct *dst_mm,
+			      unsigned long dst_addr,
+			      unsigned long len,
+			      unsigned long flags,
+			      struct list_head *uf)
+{
+	struct vm_area_struct *src_vma, *dst_vma;
+	unsigned long gua_flags = 0;
+	unsigned long ret;
+
+	src_vma = find_vma_without_flags(src_mm, src_addr, len,
+				VM_HUGETLB|VM_DONTEXPAND|VM_PFNMAP|VM_IO);
+	if (IS_ERR(src_vma))
+		return -EFAULT;
+	if (dst_mm->map_count > sysctl_max_map_count - 2)
+		return -ENOMEM;
+	if (!IS_NULL_VM_UFFD_CTX(&src_vma->vm_userfaultfd_ctx))
+		return -ENOTSUPP;
+
+	if (src_vma->vm_flags & VM_SHARED)
+		gua_flags |= MAP_SHARED;
+	else
+		gua_flags |= MAP_PRIVATE;
+	if (vma_is_anonymous(src_vma) || vma_is_shmem(src_vma))
+		gua_flags |= MAP_ANONYMOUS;
+	if (flags & PVMMAP_FIXED)
+		gua_flags |= MAP_FIXED;
+	if (flags & PVMMAP_FIXED_NOREPLACE)
+		gua_flags |= MAP_FIXED | MAP_FIXED_NOREPLACE;
+
+	ret = get_unmapped_area(src_vma->vm_file, dst_addr, len,
+				src_vma->vm_pgoff +
+				((src_addr - src_vma->vm_start) >> PAGE_SHIFT),
+				gua_flags);
+	if (offset_in_page(ret))
+                return ret;
+	if (flags & PVMMAP_FIXED_NOREPLACE) {
+		dst_vma = find_vma(dst_mm, dst_addr);
+		if (dst_vma && dst_vma->vm_start < dst_addr + len)
+			return -EEXIST;
+	}
+
+	dst_addr = ret;
+
+	/* Check against address space limit. */
+	if (!may_mmap_overlapped_region(dst_mm, src_vma->vm_flags, dst_addr, len))
+		return -ENOMEM;
+
+	ret = do_mmap_process_vm(src_vma, src_addr, dst_mm, dst_addr, len, uf);
+	if (ret)
+                return ret;
+
+	return dst_addr;
+}
+
 /*
  * Return true if the calling process may expand its vm space by the passed
  * number of pages
diff --git a/mm/process_vm_access.c b/mm/process_vm_access.c
index a447092d4635..e2073f52415b 100644
--- a/mm/process_vm_access.c
+++ b/mm/process_vm_access.c
@@ -17,6 +17,8 @@
 #include <linux/ptrace.h>
 #include <linux/slab.h>
 #include <linux/syscalls.h>
+#include <linux/mman.h>
+#include <linux/userfaultfd_k.h>
 
 #ifdef CONFIG_COMPAT
 #include <linux/compat.h>
@@ -295,6 +297,66 @@ static ssize_t process_vm_rw(pid_t pid,
 	return rc;
 }
 
+static unsigned long process_vm_mmap(pid_t pid, unsigned long src_addr,
+				     unsigned long len, unsigned long dst_addr,
+				     unsigned long flags)
+{
+	struct mm_struct *src_mm, *dst_mm;
+	struct task_struct *task;
+	unsigned long ret;
+	int depth = 0;
+	LIST_HEAD(uf);
+
+	len = PAGE_ALIGN(len);
+	src_addr = round_down(src_addr, PAGE_SIZE);
+	if (flags & PVMMAP_FIXED)
+		dst_addr = round_down(dst_addr, PAGE_SIZE);
+	else
+		dst_addr = round_hint_to_min(dst_addr);
+
+	if ((flags & ~(PVMMAP_FIXED|PVMMAP_FIXED_NOREPLACE)) ||
+	    len == 0 || len > TASK_SIZE || src_addr == 0 ||
+	    dst_addr > TASK_SIZE - len || pid <= 0)
+		return -EINVAL;
+	task = find_get_task_by_vpid(pid);
+	if (!task)
+		return -ESRCH;
+	if (unlikely(task->flags & PF_KTHREAD)) {
+		ret = -EINVAL;
+		goto out_put_task;
+	}
+
+	src_mm = mm_access(task, PTRACE_MODE_ATTACH_REALCREDS);
+	if (!src_mm || IS_ERR(src_mm)) {
+		ret = IS_ERR(src_mm) ? PTR_ERR(src_mm) : -ESRCH;
+		goto out_put_task;
+	}
+	dst_mm = current->mm;
+	mmget(dst_mm);
+
+	/* Double lock mm in address order: smallest is the first */
+	if (src_mm < dst_mm) {
+		down_write(&src_mm->mmap_sem);
+		depth = SINGLE_DEPTH_NESTING;
+	}
+	down_write_nested(&dst_mm->mmap_sem, depth);
+	if (src_mm > dst_mm)
+		down_write_nested(&src_mm->mmap_sem, SINGLE_DEPTH_NESTING);
+
+	ret = mmap_process_vm(src_mm, src_addr, dst_mm, dst_addr, len, flags, &uf);
+
+	up_write(&dst_mm->mmap_sem);
+	if (dst_mm != src_mm)
+		up_write(&src_mm->mmap_sem);
+
+	userfaultfd_unmap_complete(dst_mm, &uf);
+	mmput(src_mm);
+	mmput(dst_mm);
+out_put_task:
+	put_task_struct(task);
+	return ret;
+}
+
 SYSCALL_DEFINE6(process_vm_readv, pid_t, pid, const struct iovec __user *, lvec,
 		unsigned long, liovcnt, const struct iovec __user *, rvec,
 		unsigned long, riovcnt,	unsigned long, flags)
@@ -310,6 +372,13 @@ SYSCALL_DEFINE6(process_vm_writev, pid_t, pid,
 	return process_vm_rw(pid, lvec, liovcnt, rvec, riovcnt, flags, 1);
 }
 
+SYSCALL_DEFINE5(process_vm_mmap, pid_t, pid,
+		unsigned long, src_addr, unsigned long, len,
+		unsigned long, dst_addr, unsigned long, flags)
+{
+	return process_vm_mmap(pid, src_addr, len, dst_addr, flags);
+}
+
 #ifdef CONFIG_COMPAT
 
 static ssize_t


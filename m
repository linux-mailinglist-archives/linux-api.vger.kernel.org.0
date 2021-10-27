Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A830E43CFDC
	for <lists+linux-api@lfdr.de>; Wed, 27 Oct 2021 19:37:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236251AbhJ0RkB (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 27 Oct 2021 13:40:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239649AbhJ0Rjt (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 27 Oct 2021 13:39:49 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C613C061570;
        Wed, 27 Oct 2021 10:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+U+TxjmDEPvzkPUOSLMih1c9b9tYKtaDNEtCOsPckX4=; b=MhNVFNLpDRUsAk22yqxGXf2hdN
        S+E7PX+d59PXSbymwpHFeoR/6YXdjXE6dyecvEb5G2dVwEjO9M4rzQPW4iSLyq32W1wH8r14eXg1/
        utcx3tWj/odhlV/L34rMy7ava45qwnqx4zgA1hLR1fiuNTFWyxlcje2uFfufHoTKXZNuSYHFi8203
        51Wxv+WGijDzds9e576R8w59ZgYby09WMoBY/Z1Bquov2zNljEy5iC6wHcV4OGJorLlaxYTRPcsrL
        fbKHbG9vctPJj8tfH+jrvaTd60x2Ac7lNnH1YVtOUrulHEoVa7RW0U1cz20HVzsFKDO2GdLEo4m0K
        hz0o1tkQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mfmnq-000D7i-Lv; Wed, 27 Oct 2021 17:33:45 +0000
Date:   Wed, 27 Oct 2021 18:33:30 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, Rik van Riel <riel@surriel.com>,
        Minchan Kim <minchan@kernel.org>,
        Christian Brauner <christian@brauner.io>,
        Christoph Hellwig <hch@infradead.org>,
        Oleg Nesterov <oleg@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Jann Horn <jannh@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Florian Weimer <fweimer@redhat.com>,
        Jan Engelhardt <jengelh@inai.de>,
        Linux API <linux-api@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@android.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Andrea Arcangeli <aarcange@redhat.com>
Subject: Re: [PATCH 1/1] mm: prevent a race between process_mrelease and
 exit_mmap
Message-ID: <YXmNaoV4dBTOJ3+w@casper.infradead.org>
References: <20211022014658.263508-1-surenb@google.com>
 <YXJwUUPjfg9wV6MQ@dhcp22.suse.cz>
 <CAJuCfpEcSbK8WrufZjDj-7iUxiQtrmVTqHOxFUOvLhYGz6_ttQ@mail.gmail.com>
 <CAJuCfpFccBJHHqfOKixJvLr7Xta_ojkdHGfGomwTDNKffzziRQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJuCfpFccBJHHqfOKixJvLr7Xta_ojkdHGfGomwTDNKffzziRQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, Oct 27, 2021 at 09:08:21AM -0700, Suren Baghdasaryan wrote:
> Unconditional mmap_write_lock around free_pgtables in exit_mmap seems
> to me the most semantically correct way forward and the pushback is on
> the basis of regressing performance of the exit path. I would like to
> measure that regression to confirm this. I don't have access to a big
> machine but will ask someone in another Google team to try the test
> Michal wrote here
> https://lore.kernel.org/all/20170725142626.GJ26723@dhcp22.suse.cz/ on
> a server with and without a custom patch.

Sorry to hijack this, but could you ask that team to also test this
patch?  I think there's probably a good-sized win here, but I have no
profiles to share at this point.  I've only done light testing, and
it may have bugs.

NB: I only did the exit() path here.  fork() conversion is left as an
exercise for the reader^W^W Liam.

From 5f9daa14a5e58c86a73eccf59abe23d131004926 Mon Sep 17 00:00:00 2001
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Date: Wed, 27 Oct 2021 13:28:35 -0400
Subject: [PATCH] mm: Add vmavec

The vmavec lets us allocate and free batches of VMAs instead of
one at a time.  Should improve fork() and exit() performance.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/vmavec.h | 38 ++++++++++++++++++++++++++++++++++++++
 kernel/fork.c          | 17 +++++++++++++++++
 mm/mmap.c              | 30 ++++++++++++++++++++++--------
 3 files changed, 77 insertions(+), 8 deletions(-)
 create mode 100644 include/linux/vmavec.h

diff --git a/include/linux/vmavec.h b/include/linux/vmavec.h
new file mode 100644
index 000000000000..8a324e2e1258
--- /dev/null
+++ b/include/linux/vmavec.h
@@ -0,0 +1,38 @@
+/*
+ * A vma vector is an array of vm_area_structs, with a counter.
+ */
+
+struct vm_area_struct;
+
+#define VMAVEC_SIZE	15
+
+struct vmavec {
+	unsigned char nr;
+	void *vmas[VMAVEC_SIZE];
+};
+
+#define VMAVEC(name)	struct vmavec name = { }
+
+static inline bool vmavec_full(struct vmavec *vmavec)
+{
+	return vmavec->nr == VMAVEC_SIZE;
+}
+
+static inline bool vmavec_empty(struct vmavec *vmavec)
+{
+	return vmavec->nr == 0;
+}
+
+static inline
+void vmavec_push(struct vmavec *vmavec, struct vm_area_struct *vma)
+{
+	vmavec->vmas[vmavec->nr++] = vma;
+}
+
+static inline struct vm_area_struct *vmavec_pop(struct vmavec *vmavec)
+{
+	return vmavec->vmas[--vmavec->nr];
+}
+
+void vm_area_free_vec(struct vmavec *vmavec);
+void vm_area_alloc_vec(struct mm_struct *mm, struct vmavec *vmavec);
diff --git a/kernel/fork.c b/kernel/fork.c
index 38681ad44c76..ea7e8bd00be8 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -97,6 +97,7 @@
 #include <linux/scs.h>
 #include <linux/io_uring.h>
 #include <linux/bpf.h>
+#include <linux/vmavec.h>
 
 #include <asm/pgalloc.h>
 #include <linux/uaccess.h>
@@ -375,6 +376,22 @@ void vm_area_free(struct vm_area_struct *vma)
 	kmem_cache_free(vm_area_cachep, vma);
 }
 
+void vm_area_alloc_vec(struct mm_struct *mm, struct vmavec *vmavec)
+{
+	int i;
+
+	vmavec->nr = kmem_cache_alloc_bulk(vm_area_cachep, GFP_KERNEL,
+				VMAVEC_SIZE, vmavec->vmas);
+	for (i = 0; i < vmavec->nr; i++)
+		vma_init(vmavec->vmas[i], mm);
+}
+
+void vm_area_free_vec(struct vmavec *vmavec)
+{
+	kmem_cache_free_bulk(vm_area_cachep, vmavec->nr, vmavec->vmas);
+	vmavec->nr = 0;
+}
+
 static void account_kernel_stack(struct task_struct *tsk, int account)
 {
 	void *stack = task_stack_page(tsk);
diff --git a/mm/mmap.c b/mm/mmap.c
index 88dcc5c25225..bff4e94eec8c 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -47,6 +47,7 @@
 #include <linux/pkeys.h>
 #include <linux/oom.h>
 #include <linux/sched/mm.h>
+#include <linux/vmavec.h>
 
 #include <linux/uaccess.h>
 #include <asm/cacheflush.h>
@@ -172,19 +173,24 @@ void unlink_file_vma(struct vm_area_struct *vma)
 	}
 }
 
-/*
- * Close a vm structure and free it, returning the next.
- */
-static struct vm_area_struct *remove_vma(struct vm_area_struct *vma)
+static void __remove_vma(struct vm_area_struct *vma)
 {
-	struct vm_area_struct *next = vma->vm_next;
-
 	might_sleep();
 	if (vma->vm_ops && vma->vm_ops->close)
 		vma->vm_ops->close(vma);
 	if (vma->vm_file)
 		fput(vma->vm_file);
 	mpol_put(vma_policy(vma));
+}
+
+/*
+ * Close a vm structure and free it, returning the next.
+ */
+static struct vm_area_struct *remove_vma(struct vm_area_struct *vma)
+{
+	struct vm_area_struct *next = vma->vm_next;
+
+	__remove_vma(vma);
 	vm_area_free(vma);
 	return next;
 }
@@ -3125,6 +3131,7 @@ void exit_mmap(struct mm_struct *mm)
 {
 	struct mmu_gather tlb;
 	struct vm_area_struct *vma;
+	VMAVEC(vmavec);
 	unsigned long nr_accounted = 0;
 
 	/* mm's last user has gone, and its about to be pulled down */
@@ -3179,9 +3186,16 @@ void exit_mmap(struct mm_struct *mm)
 	while (vma) {
 		if (vma->vm_flags & VM_ACCOUNT)
 			nr_accounted += vma_pages(vma);
-		vma = remove_vma(vma);
-		cond_resched();
+		__remove_vma(vma);
+		vmavec_push(&vmavec, vma);
+		vma = vma->vm_next;
+		if (vmavec_full(&vmavec)) {
+			vm_area_free_vec(&vmavec);
+			cond_resched();
+		}
 	}
+	if (!vmavec_empty(&vmavec))
+		vm_area_free_vec(&vmavec);
 	vm_unacct_memory(nr_accounted);
 }
 
-- 
2.33.0


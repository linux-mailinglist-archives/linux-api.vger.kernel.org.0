Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B309F23928
	for <lists+linux-api@lfdr.de>; Mon, 20 May 2019 16:02:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732639AbfETOBI (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 20 May 2019 10:01:08 -0400
Received: from relay.sw.ru ([185.231.240.75]:39888 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390963AbfETOBI (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Mon, 20 May 2019 10:01:08 -0400
Received: from [172.16.25.169] (helo=localhost.localdomain)
        by relay.sw.ru with esmtp (Exim 4.91)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1hSipo-00082c-KS; Mon, 20 May 2019 17:00:12 +0300
Subject: [PATCH v2 2/7] mm: Extend copy_vma()
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
Date:   Mon, 20 May 2019 17:00:12 +0300
Message-ID: <155836081252.2441.9024100415314519956.stgit@localhost.localdomain>
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

This prepares the function to copy a vma between
two processes. Two new arguments are introduced.

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
---
 include/linux/mm.h |    4 ++--
 mm/mmap.c          |   33 ++++++++++++++++++++++++---------
 mm/mremap.c        |    4 ++--
 3 files changed, 28 insertions(+), 13 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 0e8834ac32b7..afe07e4a76f8 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2329,8 +2329,8 @@ extern void __vma_link_rb(struct mm_struct *, struct vm_area_struct *,
 	struct rb_node **, struct rb_node *);
 extern void unlink_file_vma(struct vm_area_struct *);
 extern struct vm_area_struct *copy_vma(struct vm_area_struct **,
-	unsigned long addr, unsigned long len, pgoff_t pgoff,
-	bool *need_rmap_locks);
+	struct mm_struct *, unsigned long addr, unsigned long len,
+	pgoff_t pgoff, bool *need_rmap_locks, bool clear_flags_ctx);
 extern void exit_mmap(struct mm_struct *);
 
 static inline int check_data_rlimit(unsigned long rlim,
diff --git a/mm/mmap.c b/mm/mmap.c
index 57803a0a3a5c..99778e724ad1 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -3195,19 +3195,21 @@ int insert_vm_struct(struct mm_struct *mm, struct vm_area_struct *vma)
 }
 
 /*
- * Copy the vma structure to a new location in the same mm,
- * prior to moving page table entries, to effect an mremap move.
+ * Copy the vma structure to new location in the same vma
+ * prior to moving page table entries, to effect an mremap move;
  */
 struct vm_area_struct *copy_vma(struct vm_area_struct **vmap,
-	unsigned long addr, unsigned long len, pgoff_t pgoff,
-	bool *need_rmap_locks)
+				struct mm_struct *mm, unsigned long addr,
+				unsigned long len, pgoff_t pgoff,
+				bool *need_rmap_locks, bool clear_flags_ctx)
 {
 	struct vm_area_struct *vma = *vmap;
 	unsigned long vma_start = vma->vm_start;
-	struct mm_struct *mm = vma->vm_mm;
+	struct vm_userfaultfd_ctx uctx;
 	struct vm_area_struct *new_vma, *prev;
 	struct rb_node **rb_link, *rb_parent;
 	bool faulted_in_anon_vma = true;
+	unsigned long flags;
 
 	/*
 	 * If anonymous vma has not yet been faulted, update new pgoff
@@ -3220,15 +3222,25 @@ struct vm_area_struct *copy_vma(struct vm_area_struct **vmap,
 
 	if (find_vma_links(mm, addr, addr + len, &prev, &rb_link, &rb_parent))
 		return NULL;	/* should never get here */
-	new_vma = vma_merge(mm, prev, addr, addr + len, vma->vm_flags,
-			    vma->anon_vma, vma->vm_file, pgoff, vma_policy(vma),
-			    vma->vm_userfaultfd_ctx);
+
+	uctx = vma->vm_userfaultfd_ctx;
+	flags = vma->vm_flags;
+	if (clear_flags_ctx) {
+		uctx = NULL_VM_UFFD_CTX;
+		flags &= ~(VM_UFFD_MISSING | VM_UFFD_WP | VM_MERGEABLE |
+			   VM_LOCKED | VM_LOCKONFAULT | VM_WIPEONFORK |
+			   VM_DONTCOPY);
+	}
+
+	new_vma = vma_merge(mm, prev, addr, addr + len, flags, vma->anon_vma,
+			    vma->vm_file, pgoff, vma_policy(vma), uctx);
 	if (new_vma) {
 		/*
 		 * Source vma may have been merged into new_vma
 		 */
 		if (unlikely(vma_start >= new_vma->vm_start &&
-			     vma_start < new_vma->vm_end)) {
+			     vma_start < new_vma->vm_end) &&
+			     vma->vm_mm == mm) {
 			/*
 			 * The only way we can get a vma_merge with
 			 * self during an mremap is if the vma hasn't
@@ -3249,6 +3261,9 @@ struct vm_area_struct *copy_vma(struct vm_area_struct **vmap,
 		new_vma = vm_area_dup(vma);
 		if (!new_vma)
 			goto out;
+		new_vma->vm_mm = mm;
+		new_vma->vm_flags = flags;
+		new_vma->vm_userfaultfd_ctx = uctx;
 		new_vma->vm_start = addr;
 		new_vma->vm_end = addr + len;
 		new_vma->vm_pgoff = pgoff;
diff --git a/mm/mremap.c b/mm/mremap.c
index 37b5b2ad91be..9a96cfc28675 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -352,8 +352,8 @@ static unsigned long move_vma(struct vm_area_struct *vma,
 		return err;
 
 	new_pgoff = vma->vm_pgoff + ((old_addr - vma->vm_start) >> PAGE_SHIFT);
-	new_vma = copy_vma(&vma, new_addr, new_len, new_pgoff,
-			   &need_rmap_locks);
+	new_vma = copy_vma(&vma, mm, new_addr, new_len, new_pgoff,
+			   &need_rmap_locks, false);
 	if (!new_vma)
 		return -ENOMEM;
 


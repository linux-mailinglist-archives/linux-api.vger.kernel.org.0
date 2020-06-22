Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54F21204056
	for <lists+linux-api@lfdr.de>; Mon, 22 Jun 2020 21:29:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728140AbgFVT3S (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 22 Jun 2020 15:29:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728402AbgFVT3Q (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 22 Jun 2020 15:29:16 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 038C8C061573;
        Mon, 22 Jun 2020 12:29:16 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id i12so313735pju.3;
        Mon, 22 Jun 2020 12:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HbFOH3KsLkwu7mV1dH7vf2Ocr0jZ4TZspcDQfB1XUms=;
        b=rEIKdVkMazTFPzZQJ2KD9SLUAMOrte84CbOi/Nz3xck63bBdvKxIDQ5TyuVbNh+XYY
         tghe8jzq4aPitM88+4KbeY08RsF1ZoRU0z3x5YWhQFwdYTK1TpqguWoqrTjWgSWFHDbs
         3S3hYlLCJm4E4A0d2PGz5A01sN+Lte5qUfQ158EIV+k+ol8LCLdHVDpmaPSuN4PUVKT6
         uTQwf4sewPNYVI0axuluv7YvpEHkY5qy1Vgqj5AnAfeh7EjUq1oY7HZFZUELjMqGte5V
         rFLohzAKjqayqJqZIqahh/l7yvvfD13ILWIX0HWe4JWcKu1uzw0uz6/UcIVj/3lp9G+L
         M+8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=HbFOH3KsLkwu7mV1dH7vf2Ocr0jZ4TZspcDQfB1XUms=;
        b=LxnIQyTJzNYx/bmUZxb9XprEt2VMgHovQ87IWGVbyPEZroQBP9FZTnGDdJqHtnpMoq
         YquY+NyGsAF1qPNlydqCpYVk5TAU1qu/8D7SDfePizmlhz+ithig+rn6R5p/0dGsRpX/
         avAehRe1wLUKJQ7QmywmP7Fip2E5Ne4tQpOAaVI1GJzR0JpTXADkO0hDhskLrdDe+Jjj
         auahXf70mOVpt3tono6A6pHaTXvH71NnmSc+hv5V1CQSdVRO9zGN0KP6VFwLgmPyWiyN
         /6TCqBUv7Mh4nhi0N5Fg6ruVohR43/GPyUuECwodpO8VQG+RXN/n954ECseIs1pmw3AA
         sETA==
X-Gm-Message-State: AOAM533D+2rtee9X1DTLDFDyEPcaG5Wd62iOW9RqHoaZHZcZmnZOotyA
        ytk1oWPQWmB8onBKQA/BbLg=
X-Google-Smtp-Source: ABdhPJyOOiWfPOPOJcVsXa//HJW72lKt13LEjf5hYDr2gZYAmOXaIhIvxB38Qzw3t3IFn/QNKUg5Mw==
X-Received: by 2002:a17:90a:de0f:: with SMTP id m15mr18815977pjv.21.1592854155501;
        Mon, 22 Jun 2020 12:29:15 -0700 (PDT)
Received: from bbox-1.mtv.corp.google.com ([2620:15c:211:1:3e01:2939:5992:52da])
        by smtp.gmail.com with ESMTPSA id mu17sm264603pjb.53.2020.06.22.12.29.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 12:29:14 -0700 (PDT)
From:   Minchan Kim <minchan@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        linux-mm <linux-mm@kvack.org>, linux-api@vger.kernel.org,
        oleksandr@redhat.com, Suren Baghdasaryan <surenb@google.com>,
        Tim Murray <timmurray@google.com>,
        Sandeep Patil <sspatil@google.com>,
        Sonny Rao <sonnyrao@google.com>,
        Brian Geffon <bgeffon@google.com>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        John Dias <joaodias@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Jann Horn <jannh@google.com>,
        alexander.h.duyck@linux.intel.com, sj38.park@gmail.com,
        David Rientjes <rientjes@google.com>,
        Arjun Roy <arjunroy@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>, Jens Axboe <axboe@kernel.dk>,
        Daniel Colascione <dancol@google.com>,
        Christian Brauner <christian@brauner.io>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        SeongJae Park <sjpark@amazon.de>, linux-man@vger.kernel.org
Subject: [PATCH v8 1/4] mm/madvise: pass task and mm to do_madvise
Date:   Mon, 22 Jun 2020 12:28:57 -0700
Message-Id: <20200622192900.22757-2-minchan@kernel.org>
X-Mailer: git-send-email 2.27.0.111.gc72c7da667-goog
In-Reply-To: <20200622192900.22757-1-minchan@kernel.org>
References: <20200622192900.22757-1-minchan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Patch series "introduce memory hinting API for external process", v8.

Now, we have MADV_PAGEOUT and MADV_COLD as madvise hinting API.  With
that, application could give hints to kernel what memory range are
preferred to be reclaimed.  However, in some platform(e.g., Android), the
information required to make the hinting decision is not known to the app.
Instead, it is known to a centralized userspace daemon(e.g.,
ActivityManagerService), and that daemon must be able to initiate reclaim
on its own without any app involvement.

To solve the concern, this patch introduces new syscall -
process_madvise(2).  Bascially, it's same with madvise(2) syscall but it
has some differences.

1. It needs pidfd of target process to provide the hint

2.  It supports only MADV_{COLD|PAGEOUT|MERGEABLE|UNMEREABLE} at this
   moment.  Other hints in madvise will be opened when there are explicit
   requests from community to prevent unexpected bugs we couldn't support.

3.  Only privileged processes can do something for other process's
   address space.

For more detail of the new API, please see "mm: introduce external memory
hinting API" description in this patchset.

This patch (of 4):

In upcoming patches, do_madvise will be called from external process
context so we shouldn't asssume "current" is always hinted process's
task_struct.

Furthermore, we must not access mm_struct via task->mm, but obtain it
via access_mm() once (in the following patch) and only use that pointer
[1], so pass it to do_madvise() as well.  Note the vma->vm_mm pointers
are safe, so we can use them further down the call stack.

And let's pass *current* and current->mm as arguments of do_madvise so
it shouldn't change existing behavior but prepare next patch to make
review easy.

Note: io_madvise passes NULL as target_task argument of do_madvise because
it couldn't know who is target.

[1] http://lore.kernel.org/r/CAG48ez27=pwm5m_N_988xT1huO7g7h6arTQL44zev6TD-h-7Tg@mail.gmail.com

[vbabka@suse.cz: changelog tweak]
[minchan@kernel.org: use current->mm for io_uring]
  Link: http://lkml.kernel.org/r/20200423145215.72666-1-minchan@kernel.org
[akpm@linux-foundation.org: fix it for upstream changes]
[akpm@linux-foundation.org: whoops]
[rdunlap@infradead.org: add missing includes]
Link: http://lkml.kernel.org/r/20200302193630.68771-2-minchan@kernel.org
Signed-off-by: Minchan Kim <minchan@kernel.org>
Reviewed-by: Suren Baghdasaryan <surenb@google.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Jann Horn <jannh@google.com>
Cc: Tim Murray <timmurray@google.com>
Cc: Daniel Colascione <dancol@google.com>
Cc: Sandeep Patil <sspatil@google.com>
Cc: Sonny Rao <sonnyrao@google.com>
Cc: Brian Geffon <bgeffon@google.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Shakeel Butt <shakeelb@google.com>
Cc: John Dias <joaodias@google.com>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Alexander Duyck <alexander.h.duyck@linux.intel.com>
Cc: SeongJae Park <sj38.park@gmail.com>
Cc: Christian Brauner <christian@brauner.io>
Cc: Kirill Tkhai <ktkhai@virtuozzo.com>
Cc: Oleksandr Natalenko <oleksandr@redhat.com>
Cc: SeongJae Park <sjpark@amazon.de>
Cc: Christian Brauner <christian.brauner@ubuntu.com>
Cc: <linux-man@vger.kernel.org>
---
 fs/io_uring.c      |  2 +-
 include/linux/mm.h |  3 ++-
 mm/madvise.c       | 40 +++++++++++++++++++++++-----------------
 3 files changed, 26 insertions(+), 19 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 59c8871464b6..063946e17a59 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -3586,7 +3586,7 @@ static int io_madvise(struct io_kiocb *req, bool force_nonblock)
 	if (force_nonblock)
 		return -EAGAIN;
 
-	ret = do_madvise(ma->addr, ma->len, ma->advice);
+	ret = do_madvise(NULL, current->mm, ma->addr, ma->len, ma->advice);
 	if (ret < 0)
 		req_set_fail_links(req);
 	io_cqring_add_event(req, ret);
diff --git a/include/linux/mm.h b/include/linux/mm.h
index e6ff54a7b284..30729f675b98 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2541,7 +2541,8 @@ extern int __do_munmap(struct mm_struct *, unsigned long, size_t,
 		       struct list_head *uf, bool downgrade);
 extern int do_munmap(struct mm_struct *, unsigned long, size_t,
 		     struct list_head *uf);
-extern int do_madvise(unsigned long start, size_t len_in, int behavior);
+extern int do_madvise(struct task_struct *target_task, struct mm_struct *mm,
+		unsigned long start, size_t len_in, int behavior);
 
 static inline unsigned long
 do_mmap_pgoff(struct file *file, unsigned long addr,
diff --git a/mm/madvise.c b/mm/madvise.c
index dd1d43cf026d..551ed816eefe 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -22,12 +22,14 @@
 #include <linux/file.h>
 #include <linux/blkdev.h>
 #include <linux/backing-dev.h>
+#include <linux/compat.h>
 #include <linux/pagewalk.h>
 #include <linux/swap.h>
 #include <linux/swapops.h>
 #include <linux/shmem_fs.h>
 #include <linux/mmu_notifier.h>
 #include <linux/sched/mm.h>
+#include <linux/uio.h>
 
 #include <asm/tlb.h>
 
@@ -255,6 +257,7 @@ static long madvise_willneed(struct vm_area_struct *vma,
 			     struct vm_area_struct **prev,
 			     unsigned long start, unsigned long end)
 {
+	struct mm_struct *mm = vma->vm_mm;
 	struct file *file = vma->vm_file;
 	loff_t offset;
 
@@ -289,12 +292,12 @@ static long madvise_willneed(struct vm_area_struct *vma,
 	 */
 	*prev = NULL;	/* tell sys_madvise we drop mmap_lock */
 	get_file(file);
-	mmap_read_unlock(current->mm);
+	mmap_read_unlock(mm);
 	offset = (loff_t)(start - vma->vm_start)
 			+ ((loff_t)vma->vm_pgoff << PAGE_SHIFT);
 	vfs_fadvise(file, offset, end - start, POSIX_FADV_WILLNEED);
 	fput(file);
-	mmap_read_lock(current->mm);
+	mmap_read_lock(mm);
 	return 0;
 }
 
@@ -683,7 +686,6 @@ static int madvise_free_pte_range(pmd_t *pmd, unsigned long addr,
 	if (nr_swap) {
 		if (current->mm == mm)
 			sync_mm_rss(mm);
-
 		add_mm_counter(mm, MM_SWAPENTS, nr_swap);
 	}
 	arch_leave_lazy_mmu_mode();
@@ -763,6 +765,8 @@ static long madvise_dontneed_free(struct vm_area_struct *vma,
 				  unsigned long start, unsigned long end,
 				  int behavior)
 {
+	struct mm_struct *mm = vma->vm_mm;
+
 	*prev = vma;
 	if (!can_madv_lru_vma(vma))
 		return -EINVAL;
@@ -770,8 +774,8 @@ static long madvise_dontneed_free(struct vm_area_struct *vma,
 	if (!userfaultfd_remove(vma, start, end)) {
 		*prev = NULL; /* mmap_lock has been dropped, prev is stale */
 
-		mmap_read_lock(current->mm);
-		vma = find_vma(current->mm, start);
+		mmap_read_lock(mm);
+		vma = find_vma(mm, start);
 		if (!vma)
 			return -ENOMEM;
 		if (start < vma->vm_start) {
@@ -825,6 +829,7 @@ static long madvise_remove(struct vm_area_struct *vma,
 	loff_t offset;
 	int error;
 	struct file *f;
+	struct mm_struct *mm = vma->vm_mm;
 
 	*prev = NULL;	/* tell sys_madvise we drop mmap_lock */
 
@@ -852,13 +857,13 @@ static long madvise_remove(struct vm_area_struct *vma,
 	get_file(f);
 	if (userfaultfd_remove(vma, start, end)) {
 		/* mmap_lock was not released by userfaultfd_remove() */
-		mmap_read_unlock(current->mm);
+		mmap_read_unlock(mm);
 	}
 	error = vfs_fallocate(f,
 				FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE,
 				offset, end - start);
 	fput(f);
-	mmap_read_lock(current->mm);
+	mmap_read_lock(mm);
 	return error;
 }
 
@@ -1051,7 +1056,8 @@ madvise_behavior_valid(int behavior)
  *  -EBADF  - map exists, but area maps something that isn't a file.
  *  -EAGAIN - a kernel resource was temporarily unavailable.
  */
-int do_madvise(unsigned long start, size_t len_in, int behavior)
+int do_madvise(struct task_struct *target_task, struct mm_struct *mm,
+		unsigned long start, size_t len_in, int behavior)
 {
 	unsigned long end, tmp;
 	struct vm_area_struct *vma, *prev;
@@ -1089,7 +1095,7 @@ int do_madvise(unsigned long start, size_t len_in, int behavior)
 
 	write = madvise_need_mmap_write(behavior);
 	if (write) {
-		if (mmap_write_lock_killable(current->mm))
+		if (mmap_write_lock_killable(mm))
 			return -EINTR;
 
 		/*
@@ -1104,12 +1110,12 @@ int do_madvise(unsigned long start, size_t len_in, int behavior)
 		 * but for now we have the mmget_still_valid()
 		 * model.
 		 */
-		if (!mmget_still_valid(current->mm)) {
-			mmap_write_unlock(current->mm);
+		if (!mmget_still_valid(mm)) {
+			mmap_write_unlock(mm);
 			return -EINTR;
 		}
 	} else {
-		mmap_read_lock(current->mm);
+		mmap_read_lock(mm);
 	}
 
 	/*
@@ -1117,7 +1123,7 @@ int do_madvise(unsigned long start, size_t len_in, int behavior)
 	 * ranges, just ignore them, but return -ENOMEM at the end.
 	 * - different from the way of handling in mlock etc.
 	 */
-	vma = find_vma_prev(current->mm, start, &prev);
+	vma = find_vma_prev(mm, start, &prev);
 	if (vma && start > vma->vm_start)
 		prev = vma;
 
@@ -1154,19 +1160,19 @@ int do_madvise(unsigned long start, size_t len_in, int behavior)
 		if (prev)
 			vma = prev->vm_next;
 		else	/* madvise_remove dropped mmap_lock */
-			vma = find_vma(current->mm, start);
+			vma = find_vma(mm, start);
 	}
 out:
 	blk_finish_plug(&plug);
 	if (write)
-		mmap_write_unlock(current->mm);
+		mmap_write_unlock(mm);
 	else
-		mmap_read_unlock(current->mm);
+		mmap_read_unlock(mm);
 
 	return error;
 }
 
 SYSCALL_DEFINE3(madvise, unsigned long, start, size_t, len_in, int, behavior)
 {
-	return do_madvise(start, len_in, behavior);
+	return do_madvise(current, current->mm, start, len_in, behavior);
 }
-- 
2.27.0.111.gc72c7da667-goog


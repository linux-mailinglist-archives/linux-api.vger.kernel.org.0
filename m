Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 500C316397F
	for <lists+linux-api@lfdr.de>; Wed, 19 Feb 2020 02:44:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727951AbgBSBol (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 18 Feb 2020 20:44:41 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34974 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727533AbgBSBol (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 18 Feb 2020 20:44:41 -0500
Received: by mail-pf1-f193.google.com with SMTP id i19so357481pfa.2;
        Tue, 18 Feb 2020 17:44:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=U441bp8yLD7zhTeaUoTB6L8WmIONwt6EuO7mCtDR3jk=;
        b=WaRaAenOs0MDGImoHYFoaLaHA86WLxPhfJpdaqXi7bRQfARrfzoWMPFt/AwW47E5BL
         uY31jClnXdOu612TR8Tz6xj9WFVDsQ3xrzLcAQRtZ6o2QAJvkewwsQDuA0o+ZB/i4xmP
         c9tUYM/MAgRgsbMr9P30t6OUirkxdmxYedxTvpn9hpkRMi9hshZIGoxHCLlH6NuB3QBa
         ADjstIoi+3sn4uQhXCoS7ksF4oy54nan6DwPamwt7XLWrZPh783Z8Q4yO/qOUlqVS6Ly
         riUuVOtuCFhUX9cqmK8g2VJ9zgWHj4q4OYPdu5eN2yvs8l1Pf/blQHMvH/PryuHpNb1l
         k3QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=U441bp8yLD7zhTeaUoTB6L8WmIONwt6EuO7mCtDR3jk=;
        b=moKZ8pmRqB8QjURlK+bgeuetSI+XPYVL9py5NKzz1hpwPrYDujRj+F7zqI6AkfgafW
         gLoxQAbj1ezrkvFIe5VvST17+noZEG7c+Genr4bRoQYh+WQLSwrUq4ulBAMczzr9tLfO
         MDB7UfTf+U9J3724TeYb9FWHgd2M8q/O16xHKhf+BfbdEAYOwH2VmhfNna+BwrIaZ20i
         +Vl+QIBP+9EUmx5j+JEsfXVskqcrWVLfdtuhGA7xGdaUeHcm5rrnUZr7M1DmHwX/VDrm
         IlljGBj60V/iX/jIRAGkFoIx+p3cHSCPPTTFQ8n0epCXLYsqm1LhH3n4FSqpfnExBnzi
         DJGg==
X-Gm-Message-State: APjAAAXLibOVBdIhQxqA4iAwmNsenBJg35qWA2gcD6Wpof+dW81nmqoB
        IuYr/yMVUt0CFDoR0FrJdoCufrTg
X-Google-Smtp-Source: APXvYqzXq/OZnK3iB4xbrIIkSj/5cY2MpiGhd7fHIV0eCy3l9wmAbFQmykZPiLaW86rgiwOFJGnpYQ==
X-Received: by 2002:a62:f251:: with SMTP id y17mr25166200pfl.204.1582076678946;
        Tue, 18 Feb 2020 17:44:38 -0800 (PST)
Received: from bbox-1.mtv.corp.google.com ([2620:15c:211:1:3e01:2939:5992:52da])
        by smtp.gmail.com with ESMTPSA id t186sm221192pgd.26.2020.02.18.17.44.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2020 17:44:37 -0800 (PST)
From:   Minchan Kim <minchan@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
        linux-api@vger.kernel.org, oleksandr@redhat.com,
        Suren Baghdasaryan <surenb@google.com>,
        Tim Murray <timmurray@google.com>,
        Daniel Colascione <dancol@google.com>,
        Sandeep Patil <sspatil@google.com>,
        Sonny Rao <sonnyrao@google.com>,
        Brian Geffon <bgeffon@google.com>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        John Dias <joaodias@google.com>,
        Joel Fernandes <joel@joelfernandes.org>, sj38.park@gmail.com,
        alexander.h.duyck@linux.intel.com, Jann Horn <jannh@google.com>,
        Minchan Kim <minchan@kernel.org>, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH v6 1/7] mm: pass task and mm to do_madvise
Date:   Tue, 18 Feb 2020 17:44:27 -0800
Message-Id: <20200219014433.88424-2-minchan@kernel.org>
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
In-Reply-To: <20200219014433.88424-1-minchan@kernel.org>
References: <20200219014433.88424-1-minchan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

In upcoming patches, do_madvise will be called from external process
context so we shouldn't asssume "current" is always hinted process's
task_struct. Furthermore, we couldn't access mm_struct via task->mm
once it's verified by access_mm which will be introduced in next
patch[1]. And let's pass *current* and current->mm as arguments of
do_madvise so it shouldn't change existing behavior but prepare
next patch to make review easy.

Note: io_madvise pass NULL as target_task argument of do_madvise
because it couldn't know who is target.

[1] http://lore.kernel.org/r/CAG48ez27=pwm5m_N_988xT1huO7g7h6arTQL44zev6TD-h-7Tg@mail.gmail.com

Cc: Jens Axboe <axboe@kernel.dk>
Cc: Jann Horn <jannh@google.com>
Signed-off-by: Minchan Kim <minchan@kernel.org>
---
 fs/io_uring.c      |  2 +-
 include/linux/mm.h |  3 ++-
 mm/madvise.c       | 34 +++++++++++++++++++---------------
 3 files changed, 22 insertions(+), 17 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 63beda9bafc5..a858da2ae2f4 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -2736,7 +2736,7 @@ static int io_madvise(struct io_kiocb *req, struct io_kiocb **nxt,
 	if (force_nonblock)
 		return -EAGAIN;
 
-	ret = do_madvise(ma->addr, ma->len, ma->advice);
+	ret = do_madvise(NULL, req->work.mm, ma->addr, ma->len, ma->advice);
 	if (ret < 0)
 		req_set_fail_links(req);
 	io_cqring_add_event(req, ret);
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 52269e56c514..bc16c8774328 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2323,7 +2323,8 @@ extern int __do_munmap(struct mm_struct *, unsigned long, size_t,
 		       struct list_head *uf, bool downgrade);
 extern int do_munmap(struct mm_struct *, unsigned long, size_t,
 		     struct list_head *uf);
-extern int do_madvise(unsigned long start, size_t len_in, int behavior);
+extern int do_madvise(struct task_struct *target_task, struct mm_struct *mm,
+		unsigned long start, size_t len_in, int behavior);
 
 static inline unsigned long
 do_mmap_pgoff(struct file *file, unsigned long addr,
diff --git a/mm/madvise.c b/mm/madvise.c
index 43b47d3fae02..f75c86b6c463 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -254,6 +254,7 @@ static long madvise_willneed(struct vm_area_struct *vma,
 			     struct vm_area_struct **prev,
 			     unsigned long start, unsigned long end)
 {
+	struct mm_struct *mm = vma->vm_mm;
 	struct file *file = vma->vm_file;
 	loff_t offset;
 
@@ -288,12 +289,12 @@ static long madvise_willneed(struct vm_area_struct *vma,
 	 */
 	*prev = NULL;	/* tell sys_madvise we drop mmap_sem */
 	get_file(file);
-	up_read(&current->mm->mmap_sem);
+	up_read(&mm->mmap_sem);
 	offset = (loff_t)(start - vma->vm_start)
 			+ ((loff_t)vma->vm_pgoff << PAGE_SHIFT);
 	vfs_fadvise(file, offset, end - start, POSIX_FADV_WILLNEED);
 	fput(file);
-	down_read(&current->mm->mmap_sem);
+	down_read(&mm->mmap_sem);
 	return 0;
 }
 
@@ -676,7 +677,6 @@ static int madvise_free_pte_range(pmd_t *pmd, unsigned long addr,
 	if (nr_swap) {
 		if (current->mm == mm)
 			sync_mm_rss(mm);
-
 		add_mm_counter(mm, MM_SWAPENTS, nr_swap);
 	}
 	arch_leave_lazy_mmu_mode();
@@ -756,6 +756,8 @@ static long madvise_dontneed_free(struct vm_area_struct *vma,
 				  unsigned long start, unsigned long end,
 				  int behavior)
 {
+	struct mm_struct *mm = vma->vm_mm;
+
 	*prev = vma;
 	if (!can_madv_lru_vma(vma))
 		return -EINVAL;
@@ -763,8 +765,8 @@ static long madvise_dontneed_free(struct vm_area_struct *vma,
 	if (!userfaultfd_remove(vma, start, end)) {
 		*prev = NULL; /* mmap_sem has been dropped, prev is stale */
 
-		down_read(&current->mm->mmap_sem);
-		vma = find_vma(current->mm, start);
+		down_read(&mm->mmap_sem);
+		vma = find_vma(mm, start);
 		if (!vma)
 			return -ENOMEM;
 		if (start < vma->vm_start) {
@@ -818,6 +820,7 @@ static long madvise_remove(struct vm_area_struct *vma,
 	loff_t offset;
 	int error;
 	struct file *f;
+	struct mm_struct *mm = vma->vm_mm;
 
 	*prev = NULL;	/* tell sys_madvise we drop mmap_sem */
 
@@ -845,13 +848,13 @@ static long madvise_remove(struct vm_area_struct *vma,
 	get_file(f);
 	if (userfaultfd_remove(vma, start, end)) {
 		/* mmap_sem was not released by userfaultfd_remove() */
-		up_read(&current->mm->mmap_sem);
+		up_read(&mm->mmap_sem);
 	}
 	error = vfs_fallocate(f,
 				FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE,
 				offset, end - start);
 	fput(f);
-	down_read(&current->mm->mmap_sem);
+	down_read(&mm->mmap_sem);
 	return error;
 }
 
@@ -1044,7 +1047,8 @@ madvise_behavior_valid(int behavior)
  *  -EBADF  - map exists, but area maps something that isn't a file.
  *  -EAGAIN - a kernel resource was temporarily unavailable.
  */
-int do_madvise(unsigned long start, size_t len_in, int behavior)
+int do_madvise(struct task_struct *target_task, struct mm_struct *mm,
+		unsigned long start, size_t len_in, int behavior)
 {
 	unsigned long end, tmp;
 	struct vm_area_struct *vma, *prev;
@@ -1082,10 +1086,10 @@ int do_madvise(unsigned long start, size_t len_in, int behavior)
 
 	write = madvise_need_mmap_write(behavior);
 	if (write) {
-		if (down_write_killable(&current->mm->mmap_sem))
+		if (down_write_killable(&mm->mmap_sem))
 			return -EINTR;
 	} else {
-		down_read(&current->mm->mmap_sem);
+		down_read(&mm->mmap_sem);
 	}
 
 	/*
@@ -1093,7 +1097,7 @@ int do_madvise(unsigned long start, size_t len_in, int behavior)
 	 * ranges, just ignore them, but return -ENOMEM at the end.
 	 * - different from the way of handling in mlock etc.
 	 */
-	vma = find_vma_prev(current->mm, start, &prev);
+	vma = find_vma_prev(mm, start, &prev);
 	if (vma && start > vma->vm_start)
 		prev = vma;
 
@@ -1130,19 +1134,19 @@ int do_madvise(unsigned long start, size_t len_in, int behavior)
 		if (prev)
 			vma = prev->vm_next;
 		else	/* madvise_remove dropped mmap_sem */
-			vma = find_vma(current->mm, start);
+			vma = find_vma(mm, start);
 	}
 out:
 	blk_finish_plug(&plug);
 	if (write)
-		up_write(&current->mm->mmap_sem);
+		up_write(&mm->mmap_sem);
 	else
-		up_read(&current->mm->mmap_sem);
+		up_read(&mm->mmap_sem);
 
 	return error;
 }
 
 SYSCALL_DEFINE3(madvise, unsigned long, start, size_t, len_in, int, behavior)
 {
-	return do_madvise(start, len_in, behavior);
+	return do_madvise(current, current->mm, start, len_in, behavior);
 }
-- 
2.25.0.265.gbab2e86ba0-goog


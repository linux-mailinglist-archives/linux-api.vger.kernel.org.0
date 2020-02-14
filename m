Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0798115E948
	for <lists+linux-api@lfdr.de>; Fri, 14 Feb 2020 18:06:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387637AbgBNRGD (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 14 Feb 2020 12:06:03 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34131 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388586AbgBNRGA (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 14 Feb 2020 12:06:00 -0500
Received: by mail-pg1-f193.google.com with SMTP id j4so5264194pgi.1;
        Fri, 14 Feb 2020 09:06:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YcmNAmrbG8b4Q1zbELocvrBQuIWTW45ghRZPxCURlKs=;
        b=LGkW4u1S5E8xLFpgR5v7sW2j06MK3yVNHxU7BxIbb9dw1hQNkkR9C95XGIutlBVZOy
         j8OibtW7kRPNZT2UUXzy9Dgv2DDs1BGd0VUrSg2/0vA8DUg/j32AxBQ2C7RdXdwvUXNL
         zHKcDvcx+gPUB5hUFZait/vJHSaLNM2JvzhGrVil3ImfSx1lp50ncoYm1Wd3OgrjHAd1
         xpd0FtDIbiOYHB4Rkp7zI1TWkowpx1OzmcdbBlOjAKznDFnzI4hJfkYd7ctzMoxlg72/
         nJ8yoXws8+0Bd6iILckuNlmrBEVs2h5EdCTqLg1zaNHAj3k2CYrsO/InLKrbGbiVOPj9
         vJzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=YcmNAmrbG8b4Q1zbELocvrBQuIWTW45ghRZPxCURlKs=;
        b=IJ9sEJG1BHTw6D0S8RsfKjCQmyd8vitb/aMTAMQaTNM0Zb6SPybOVFucuFuePtT+1Y
         s2Q/jVlNhn9MqjU1ty/rtlJYnJ3jLh+gRHJTXlpYpaE1OO/JSD6dQ8GPCLOJZnUeZz3g
         YOahr+q41D8DMDP5q9mVP1FzVh5WYg2Z+IGgvef5vYdr6iVcTt2iBYALRIu5xbyvEJjq
         68zj176KAitdEcv9YER6bl8n7f/J6aP1AMOMXDgCRWy+PYJ+KJ7tzU0htptFMX6a5Hof
         NWUuPqj09pxwIQQc4eA9yQA1obg7BUu+v6TXrFspTbqO22SWA+fbtMyzRkK0BzGApQQB
         7L4w==
X-Gm-Message-State: APjAAAUBz1Dxjtv0o7+9aC42q+KjxZO1OPZ/crktHCpUsms+MSNlFeGZ
        CzR3AIDaUO0ep2++t/BJnVA=
X-Google-Smtp-Source: APXvYqwqHc9Z5itNolbOM6+dAnfpFmB5PRq+nvJ3VvlFX7h3R8ChYUzXC6dGwCHonYwcsiCsEH02xA==
X-Received: by 2002:a63:86c2:: with SMTP id x185mr4373491pgd.245.1581699959469;
        Fri, 14 Feb 2020 09:05:59 -0800 (PST)
Received: from bbox-1.mtv.corp.google.com ([2620:15c:211:1:3e01:2939:5992:52da])
        by smtp.gmail.com with ESMTPSA id a13sm7662924pfg.65.2020.02.14.09.05.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2020 09:05:51 -0800 (PST)
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
        Minchan Kim <minchan@kernel.org>
Subject: [PATCH v5 1/7] mm: pass task and mm to do_madvise
Date:   Fri, 14 Feb 2020 09:05:14 -0800
Message-Id: <20200214170520.160271-2-minchan@kernel.org>
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
In-Reply-To: <20200214170520.160271-1-minchan@kernel.org>
References: <20200214170520.160271-1-minchan@kernel.org>
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

[1] http://lore.kernel.org/r/CAG48ez27=pwm5m_N_988xT1huO7g7h6arTQL44zev6TD-h-7Tg@mail.gmail.com

Cc: Jann Horn <jannh@google.com>
Signed-off-by: Minchan Kim <minchan@kernel.org>
---
 fs/io_uring.c      |  2 +-
 include/linux/mm.h |  3 ++-
 mm/madvise.c       | 34 +++++++++++++++++++---------------
 3 files changed, 22 insertions(+), 17 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 63beda9bafc5..bf111675307c 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -2736,7 +2736,7 @@ static int io_madvise(struct io_kiocb *req, struct io_kiocb **nxt,
 	if (force_nonblock)
 		return -EAGAIN;
 
-	ret = do_madvise(ma->addr, ma->len, ma->advice);
+	ret = do_madvise(current, current->mm, ma->addr, ma->len, ma->advice);
 	if (ret < 0)
 		req_set_fail_links(req);
 	io_cqring_add_event(req, ret);
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 52269e56c514..beb9259f9ed1 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2323,7 +2323,8 @@ extern int __do_munmap(struct mm_struct *, unsigned long, size_t,
 		       struct list_head *uf, bool downgrade);
 extern int do_munmap(struct mm_struct *, unsigned long, size_t,
 		     struct list_head *uf);
-extern int do_madvise(unsigned long start, size_t len_in, int behavior);
+extern int do_madvise(struct task_struct *task, struct mm_struct *mm,
+		unsigned long start, size_t len_in, int behavior);
 
 static inline unsigned long
 do_mmap_pgoff(struct file *file, unsigned long addr,
diff --git a/mm/madvise.c b/mm/madvise.c
index 43b47d3fae02..24566f59b89b 100644
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
+int do_madvise(struct task_struct *task, struct mm_struct *mm,
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


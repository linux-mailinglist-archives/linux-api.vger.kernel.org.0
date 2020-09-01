Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02FC92584A6
	for <lists+linux-api@lfdr.de>; Tue,  1 Sep 2020 02:08:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726192AbgIAAHz (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 31 Aug 2020 20:07:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbgIAAHu (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 31 Aug 2020 20:07:50 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A916C061573;
        Mon, 31 Aug 2020 17:07:50 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id h2so4056250plr.0;
        Mon, 31 Aug 2020 17:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9v0toS4YEWMYzK02MEFlXArA+LdQ8YNff+2tLjRKFE8=;
        b=loncq7c6CT+AEoKDTBJeM5bSVJwnYUmCav1ptE1n063QgFNE+8rPq3hINxu9nCjGo7
         0ji4wtAxZlGbmP0dRWQjrccM9maOKSJiJ++HBj0v3y3HjWsUML4N5hI6xIoV6RbsMWpY
         YZytYZlrEJx4zOhYOnsfRWQQd34a1vQCND3tyNficVkuj3htbAespGz6J6rVgY/KCxsa
         /bBIGlpkIxHTJspvAwAg8Ybq/aaY+kNfYSItb+WAo1okZTSRNY3eN3e2NWF7LjqxKxKq
         qD2exgxLj9A5HWX3STiTlvb0jAN9qeLAyIDW3OJYQWVDxBmPRVJthnOzPFzygTj2BnSv
         GCsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=9v0toS4YEWMYzK02MEFlXArA+LdQ8YNff+2tLjRKFE8=;
        b=BGQwJZmAnefWUa3ybGXGYRJ0I0HjnfPv9zk4Z9f7gJY9u//09Mbyd9S/lGCjkegsef
         tFPoimocPXUfZdR2vGV+gkJiKWr+uRFEFEJ/kyMYN4Wjro5mdwUJbFj/4fuwMyW8Ypcs
         7CNlCCHN12SWheR9/usUkRw12iAFz1ou4BI6xRrY0vGcqY7idxq1jx7B1mxwL6SF20Fx
         u4/bd9EL2brEnVpzNf0aRiXMfC50rgHmLbt5acNP690+xFcvdSH5LIFnkZokhqf5mxHx
         lcwZ/zYcwPcLayJiEsF8Me58XfXCglasLrLp5jD6jWMvYLjdqTfb5trbcKavBoF6AG0r
         U3zA==
X-Gm-Message-State: AOAM532pXNmvylYFDdiJWO6C3wSZGXJHtgGP0gervse6RxpEXqlwNLsV
        cvbXW5JMR66aJcz6k0h6mg8=
X-Google-Smtp-Source: ABdhPJx1GFPW+c6yEJLwrJXLnT6GZ2kh1PjSdZHUxZHP4IaAqCPy2tDZk7LgzqeJ2r3EK5Jrn6rNhw==
X-Received: by 2002:a17:90b:4a10:: with SMTP id kk16mr1603213pjb.203.1598918869690;
        Mon, 31 Aug 2020 17:07:49 -0700 (PDT)
Received: from bbox-1.mtv.corp.google.com ([2620:15c:211:1:7220:84ff:fe09:5e58])
        by smtp.gmail.com with ESMTPSA id k5sm769777pjq.5.2020.08.31.17.07.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2020 17:07:48 -0700 (PDT)
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
        Linus Torvalds <torvalds@linux-foundation.org>,
        Minchan Kim <minchan@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>, Jens Axboe <axboe@kernel.dk>,
        Daniel Colascione <dancol@google.com>,
        Christian Brauner <christian@brauner.io>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        SeongJae Park <sjpark@amazon.de>, linux-man@vger.kernel.org
Subject: [PATCH v9 1/3] mm/madvise: pass mm to do_madvise
Date:   Mon, 31 Aug 2020 17:06:31 -0700
Message-Id: <20200901000633.1920247-2-minchan@kernel.org>
X-Mailer: git-send-email 2.28.0.402.g5ffc5be6b7-goog
In-Reply-To: <20200901000633.1920247-1-minchan@kernel.org>
References: <20200901000633.1920247-1-minchan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Patch series "introduce memory hinting API for external process", v9.

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

And let's pass current->mm as arguments of do_madvise so it shouldn't
change existing behavior but prepare next patch to make review easy.

[vbabka@suse.cz: changelog tweak]
[minchan@kernel.org: use current->mm for io_uring]
  Link: http://lkml.kernel.org/r/20200423145215.72666-1-minchan@kernel.org
[akpm@linux-foundation.org: fix it for upstream changes]
[akpm@linux-foundation.org: whoops]
[rdunlap@infradead.org: add missing includes]
Link: http://lkml.kernel.org/r/20200622192900.22757-1-minchan@kernel.org
Link: http://lkml.kernel.org/r/20200302193630.68771-2-minchan@kernel.org
Link: http://lkml.kernel.org/r/20200622192900.22757-2-minchan@kernel.org
Signed-off-by: Minchan Kim <minchan@kernel.org>
Reviewed-by: Suren Baghdasaryan <surenb@google.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Acked-by: David Rientjes <rientjes@google.com>
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
 include/linux/mm.h |  2 +-
 mm/madvise.c       | 32 ++++++++++++++++++--------------
 3 files changed, 20 insertions(+), 16 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 94b9b5cf5971..cfb8003be09c 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -3823,7 +3823,7 @@ static int io_madvise(struct io_kiocb *req, bool force_nonblock)
 	if (force_nonblock)
 		return -EAGAIN;
 
-	ret = do_madvise(ma->addr, ma->len, ma->advice);
+	ret = do_madvise(current->mm, ma->addr, ma->len, ma->advice);
 	if (ret < 0)
 		req_set_fail_links(req);
 	io_req_complete(req, ret);
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 517751310dd2..a12354e63e49 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2570,7 +2570,7 @@ extern int __do_munmap(struct mm_struct *, unsigned long, size_t,
 		       struct list_head *uf, bool downgrade);
 extern int do_munmap(struct mm_struct *, unsigned long, size_t,
 		     struct list_head *uf);
-extern int do_madvise(unsigned long start, size_t len_in, int behavior);
+extern int do_madvise(struct mm_struct *mm, unsigned long start, size_t len_in, int behavior);
 
 #ifdef CONFIG_MMU
 extern int __mm_populate(unsigned long addr, unsigned long len,
diff --git a/mm/madvise.c b/mm/madvise.c
index 4d87b31a1576..3bf5c8261f1c 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -255,6 +255,7 @@ static long madvise_willneed(struct vm_area_struct *vma,
 			     struct vm_area_struct **prev,
 			     unsigned long start, unsigned long end)
 {
+	struct mm_struct *mm = vma->vm_mm;
 	struct file *file = vma->vm_file;
 	loff_t offset;
 
@@ -291,10 +292,10 @@ static long madvise_willneed(struct vm_area_struct *vma,
 	get_file(file);
 	offset = (loff_t)(start - vma->vm_start)
 			+ ((loff_t)vma->vm_pgoff << PAGE_SHIFT);
-	mmap_read_unlock(current->mm);
+	mmap_read_unlock(mm);
 	vfs_fadvise(file, offset, end - start, POSIX_FADV_WILLNEED);
 	fput(file);
-	mmap_read_lock(current->mm);
+	mmap_read_lock(mm);
 	return 0;
 }
 
@@ -763,6 +764,8 @@ static long madvise_dontneed_free(struct vm_area_struct *vma,
 				  unsigned long start, unsigned long end,
 				  int behavior)
 {
+	struct mm_struct *mm = vma->vm_mm;
+
 	*prev = vma;
 	if (!can_madv_lru_vma(vma))
 		return -EINVAL;
@@ -770,8 +773,8 @@ static long madvise_dontneed_free(struct vm_area_struct *vma,
 	if (!userfaultfd_remove(vma, start, end)) {
 		*prev = NULL; /* mmap_lock has been dropped, prev is stale */
 
-		mmap_read_lock(current->mm);
-		vma = find_vma(current->mm, start);
+		mmap_read_lock(mm);
+		vma = find_vma(mm, start);
 		if (!vma)
 			return -ENOMEM;
 		if (start < vma->vm_start) {
@@ -825,6 +828,7 @@ static long madvise_remove(struct vm_area_struct *vma,
 	loff_t offset;
 	int error;
 	struct file *f;
+	struct mm_struct *mm = vma->vm_mm;
 
 	*prev = NULL;	/* tell sys_madvise we drop mmap_lock */
 
@@ -852,13 +856,13 @@ static long madvise_remove(struct vm_area_struct *vma,
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
 
@@ -1046,7 +1050,7 @@ madvise_behavior_valid(int behavior)
  *  -EBADF  - map exists, but area maps something that isn't a file.
  *  -EAGAIN - a kernel resource was temporarily unavailable.
  */
-int do_madvise(unsigned long start, size_t len_in, int behavior)
+int do_madvise(struct mm_struct *mm, unsigned long start, size_t len_in, int behavior)
 {
 	unsigned long end, tmp;
 	struct vm_area_struct *vma, *prev;
@@ -1084,10 +1088,10 @@ int do_madvise(unsigned long start, size_t len_in, int behavior)
 
 	write = madvise_need_mmap_write(behavior);
 	if (write) {
-		if (mmap_write_lock_killable(current->mm))
+		if (mmap_write_lock_killable(mm))
 			return -EINTR;
 	} else {
-		mmap_read_lock(current->mm);
+		mmap_read_lock(mm);
 	}
 
 	/*
@@ -1095,7 +1099,7 @@ int do_madvise(unsigned long start, size_t len_in, int behavior)
 	 * ranges, just ignore them, but return -ENOMEM at the end.
 	 * - different from the way of handling in mlock etc.
 	 */
-	vma = find_vma_prev(current->mm, start, &prev);
+	vma = find_vma_prev(mm, start, &prev);
 	if (vma && start > vma->vm_start)
 		prev = vma;
 
@@ -1132,19 +1136,19 @@ int do_madvise(unsigned long start, size_t len_in, int behavior)
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
+	return do_madvise(current->mm, start, len_in, behavior);
 }
-- 
2.28.0.402.g5ffc5be6b7-goog


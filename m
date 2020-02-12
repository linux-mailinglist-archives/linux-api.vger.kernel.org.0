Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C453615B4E2
	for <lists+linux-api@lfdr.de>; Thu, 13 Feb 2020 00:39:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729259AbgBLXjx (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 12 Feb 2020 18:39:53 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43873 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729237AbgBLXjw (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 12 Feb 2020 18:39:52 -0500
Received: by mail-pg1-f195.google.com with SMTP id u12so1674882pgb.10;
        Wed, 12 Feb 2020 15:39:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CaESisSBxNPE2doLDk535d6lHmOCff9MNldO17oRtwM=;
        b=JS+hQMpjCiSL/bIcob819JXcAFntb6DAajrrH2XpwlMNN6RJhPqFesgZv9GtSgnfoB
         aUKzPlRpzQU80yQftWr2vGL/FZdbBys3oDgZXPHnsoqgaJ2VEWPw8op4HsMyuBddKH/q
         B8vHpU/IxHuFiOqwXizS1lpENgPDFdB7hfFPhSwCXTMSKwXI8o5cYcO/SFSu+rufyWep
         //bioNwQy39ikfsAvjCe+X9yT2lNBl8bpy22qfMdminq2e0AQlUqvnV6Mn/S81lmkwGG
         ayz7J/S53s8PWQyY7fJ7vkmG7TDqoWt+keVJFHkOS4fyvDuMZO6vvM6vrbHIh9Nk5AJF
         1nxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=CaESisSBxNPE2doLDk535d6lHmOCff9MNldO17oRtwM=;
        b=HEtbi3p1dXWLReLYXeiCKZgTERfMxLF4ntpDzEuFyoymIqzdB7r9rR3jMWGFnJvaYE
         dC4F9JruQmpVIv7yTzPmZ6sDzcfMFXedg4Im8KuYho6SyBxSMoEpNPs8SQWxaPl4rcem
         p6XJiFfwak8HX1yqVj2qtyJOw8jsCp+47j7LA/hF1AFk/Yvu6UvToE395SBjlkhL0Wio
         DTxp5yxmn2/EgzpPXYxbzUyhMuEcbAejNCsZns4wQhHbPq5ZWGn8AJyaSwl/gUk16ndW
         iuZM/NOvXM5yjjXF4bvTu3YiJfgcji1ul3LOV/vQvD0Oe9dxK268lIx48Ls7l0+UYBLN
         QXmQ==
X-Gm-Message-State: APjAAAW04YjbIh/Bp6mUUvPis76lzTraCWEgttBJg9GqwhbYAU9U6BfH
        eh4YZPfL26l/ZBLtvcBuphc=
X-Google-Smtp-Source: APXvYqyUCxZWmHJ5S2Cx4UhfOoURZcoQU6tgdwR9R+D7NvOkBNmrWtkBNpJggLo/YZLejL+o9stwDA==
X-Received: by 2002:aa7:85d9:: with SMTP id z25mr11119876pfn.223.1581550792005;
        Wed, 12 Feb 2020 15:39:52 -0800 (PST)
Received: from bbox-1.mtv.corp.google.com ([2620:15c:211:1:3e01:2939:5992:52da])
        by smtp.gmail.com with ESMTPSA id k5sm296664pju.29.2020.02.12.15.39.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2020 15:39:50 -0800 (PST)
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
        Joel Fernandes <joel@joelfernandes.org>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Minchan Kim <minchan@kernel.org>
Subject: [PATCH v4 1/8] mm: pass task to do_madvise
Date:   Wed, 12 Feb 2020 15:39:39 -0800
Message-Id: <20200212233946.246210-2-minchan@kernel.org>
X-Mailer: git-send-email 2.25.0.225.g125e21ebc7-goog
In-Reply-To: <20200212233946.246210-1-minchan@kernel.org>
References: <20200212233946.246210-1-minchan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

In upcoming patches, do_madvise will be called from external process
context so it shouldn't asssume "current" is always hinted process's
task_struct. Thus, let's get the mm_struct from vma->vm_mm, not
current because vma is always hinted process's one. And let's pass
*current* as new task argument of do_madvise so it shouldn't change
existing behavior.

Signed-off-by: Minchan Kim <minchan@kernel.org>
---
 fs/io_uring.c      |  2 +-
 include/linux/mm.h |  3 ++-
 mm/madvise.c       | 37 ++++++++++++++++++++-----------------
 3 files changed, 23 insertions(+), 19 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 63beda9bafc5..6307206b970f 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -2736,7 +2736,7 @@ static int io_madvise(struct io_kiocb *req, struct io_kiocb **nxt,
 	if (force_nonblock)
 		return -EAGAIN;
 
-	ret = do_madvise(ma->addr, ma->len, ma->advice);
+	ret = do_madvise(current, ma->addr, ma->len, ma->advice);
 	if (ret < 0)
 		req_set_fail_links(req);
 	io_cqring_add_event(req, ret);
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 52269e56c514..8cb41131ec96 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2323,7 +2323,8 @@ extern int __do_munmap(struct mm_struct *, unsigned long, size_t,
 		       struct list_head *uf, bool downgrade);
 extern int do_munmap(struct mm_struct *, unsigned long, size_t,
 		     struct list_head *uf);
-extern int do_madvise(unsigned long start, size_t len_in, int behavior);
+extern int do_madvise(struct task_struct *task, unsigned long start,
+			size_t len_in, int behavior);
 
 static inline unsigned long
 do_mmap_pgoff(struct file *file, unsigned long addr,
diff --git a/mm/madvise.c b/mm/madvise.c
index 43b47d3fae02..ab4011ba2d9e 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -256,6 +256,7 @@ static long madvise_willneed(struct vm_area_struct *vma,
 {
 	struct file *file = vma->vm_file;
 	loff_t offset;
+	struct mm_struct *mm = vma->vm_mm;
 
 	*prev = vma;
 #ifdef CONFIG_SWAP
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
 
@@ -674,9 +675,7 @@ static int madvise_free_pte_range(pmd_t *pmd, unsigned long addr,
 	}
 out:
 	if (nr_swap) {
-		if (current->mm == mm)
-			sync_mm_rss(mm);
-
+		sync_mm_rss(mm);
 		add_mm_counter(mm, MM_SWAPENTS, nr_swap);
 	}
 	arch_leave_lazy_mmu_mode();
@@ -756,6 +755,7 @@ static long madvise_dontneed_free(struct vm_area_struct *vma,
 				  unsigned long start, unsigned long end,
 				  int behavior)
 {
+	struct mm_struct *mm = vma->vm_mm;
 	*prev = vma;
 	if (!can_madv_lru_vma(vma))
 		return -EINVAL;
@@ -763,8 +763,8 @@ static long madvise_dontneed_free(struct vm_area_struct *vma,
 	if (!userfaultfd_remove(vma, start, end)) {
 		*prev = NULL; /* mmap_sem has been dropped, prev is stale */
 
-		down_read(&current->mm->mmap_sem);
-		vma = find_vma(current->mm, start);
+		down_read(&mm->mmap_sem);
+		vma = find_vma(mm, start);
 		if (!vma)
 			return -ENOMEM;
 		if (start < vma->vm_start) {
@@ -818,6 +818,7 @@ static long madvise_remove(struct vm_area_struct *vma,
 	loff_t offset;
 	int error;
 	struct file *f;
+	struct mm_struct *mm = vma->vm_mm;
 
 	*prev = NULL;	/* tell sys_madvise we drop mmap_sem */
 
@@ -845,13 +846,13 @@ static long madvise_remove(struct vm_area_struct *vma,
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
 
@@ -1044,7 +1045,8 @@ madvise_behavior_valid(int behavior)
  *  -EBADF  - map exists, but area maps something that isn't a file.
  *  -EAGAIN - a kernel resource was temporarily unavailable.
  */
-int do_madvise(unsigned long start, size_t len_in, int behavior)
+int do_madvise(struct task_struct *task, unsigned long start,
+					size_t len_in, int behavior)
 {
 	unsigned long end, tmp;
 	struct vm_area_struct *vma, *prev;
@@ -1053,6 +1055,7 @@ int do_madvise(unsigned long start, size_t len_in, int behavior)
 	int write;
 	size_t len;
 	struct blk_plug plug;
+	struct mm_struct *mm = task->mm;
 
 	start = untagged_addr(start);
 
@@ -1082,10 +1085,10 @@ int do_madvise(unsigned long start, size_t len_in, int behavior)
 
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
@@ -1093,7 +1096,7 @@ int do_madvise(unsigned long start, size_t len_in, int behavior)
 	 * ranges, just ignore them, but return -ENOMEM at the end.
 	 * - different from the way of handling in mlock etc.
 	 */
-	vma = find_vma_prev(current->mm, start, &prev);
+	vma = find_vma_prev(mm, start, &prev);
 	if (vma && start > vma->vm_start)
 		prev = vma;
 
@@ -1130,19 +1133,19 @@ int do_madvise(unsigned long start, size_t len_in, int behavior)
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
+	return do_madvise(current, start, len_in, behavior);
 }
-- 
2.25.0.225.g125e21ebc7-goog


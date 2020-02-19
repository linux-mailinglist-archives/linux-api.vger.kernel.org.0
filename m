Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 892E9163983
	for <lists+linux-api@lfdr.de>; Wed, 19 Feb 2020 02:44:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728092AbgBSBos (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 18 Feb 2020 20:44:48 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:55217 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728078AbgBSBor (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 18 Feb 2020 20:44:47 -0500
Received: by mail-pj1-f68.google.com with SMTP id dw13so1858409pjb.4;
        Tue, 18 Feb 2020 17:44:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=S6I7FkbWENtipd9zPITUUz5qzwuADyMhSE4JPk/5aKo=;
        b=grpW1aOcWY7IHSfhWkaQekrHm6oGkQJgAbcYNwHWWr8RBl8yhAq7SWaWmfi9gFhATr
         7WszFDcQhbjWb2XWYhUE6Iw0vro+RRY0MiqfowH/YpmjfpbbiLMQQMKCqURY3XS80SFW
         DEcTlHoQDPpBLtE5WA6aRVkzBDDyXmQt9wU2OrYaGJPFgNpU0vrRRHNr/Q9wPhIbCTHA
         lHxnnz0SMDaqyThdCgCiYimxOspulO3xIsDK06unf7EefYUcpQOqE+brGSsec/s2VmvY
         r0JB2w3NHhYOWizQgKT7ddX7eLIecrq+HG90y9k4bu0zm9NaKFWs04ufT7Nd8cwb0nUB
         giiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=S6I7FkbWENtipd9zPITUUz5qzwuADyMhSE4JPk/5aKo=;
        b=lqpE6bN4PUscLAUL3D9WZF4v82Zxe0uadmP5l6vTrvc/SIabtYf3msBWX47uDwJfer
         7LjRkcj0JPYnIVqC4MXkGoVdOJcTDCMSEePSpL3kyWPo81rozE6WQG2TIufJO5At/UR1
         LKK1qvPhmSf4lD8LbnnSEphl8btXKz8d3+eSH68XM//7Un9zuus0mCk3IVrBqFSVTpSC
         wQ7QPY5s5v+iXOA0Qi0TBeooWVEEqAd+K5+ELkEMDtpCaR6w7PPb94pkDbSoBQXRiGjg
         /bN6xMo73Ki6UCGDnqfQHeHVdxQ29etQHZBugbinqD9tJZ5McjlWrrIfI0BmvRz3ga3W
         doEQ==
X-Gm-Message-State: APjAAAVYccTj9bDIRxqfgefJNnfefG8aH8UbADqXEO7VkP19r3VXGfbe
        /1OtwPqEFKWl+rT+foacF5s=
X-Google-Smtp-Source: APXvYqyWYkd0WFT38bEZICS0jffyP4aaTQq2M2uUcJYdPWz+zOIDDDnU29CSI021/GJpxVHswXHbuw==
X-Received: by 2002:a17:902:462:: with SMTP id 89mr23938662ple.270.1582076686098;
        Tue, 18 Feb 2020 17:44:46 -0800 (PST)
Received: from bbox-1.mtv.corp.google.com ([2620:15c:211:1:3e01:2939:5992:52da])
        by smtp.gmail.com with ESMTPSA id t186sm221192pgd.26.2020.02.18.17.44.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2020 17:44:45 -0800 (PST)
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
        Minchan Kim <minchan@kernel.org>,
        Christian Brauner <christian@brauner.io>,
        Kirill Tkhai <ktkhai@virtuozzo.com>
Subject: [PATCH v6 5/7] mm: support both pid and pidfd for process_madvise
Date:   Tue, 18 Feb 2020 17:44:31 -0800
Message-Id: <20200219014433.88424-6-minchan@kernel.org>
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
In-Reply-To: <20200219014433.88424-1-minchan@kernel.org>
References: <20200219014433.88424-1-minchan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

There is a demand[1] to support pid as well pidfd for process_madvise
to reduce unnecessary syscall to get pidfd if the user has control of
the target process(ie, they could guarantee the process is not gone
or pid is not reused. Or, it might be okay to give a hint to wrong
process).

This patch aims for supporting both options like waitid(2). So, the
syscall is currently,

	int process_madvise(int which, pid_t pid, void *addr,
		size_t length, int advise, unsigned long flag);

@which is actually idtype_t for userspace libray and currently,
it supports P_PID and P_PIDFD.

[1]  https://lore.kernel.org/linux-mm/9d849087-3359-c4ab-fbec-859e8186c509@virtuozzo.com/

Cc: Christian Brauner <christian@brauner.io>
Suggested-by: Kirill Tkhai <ktkhai@virtuozzo.com>
Signed-off-by: Minchan Kim <minchan@kernel.org>
---
 include/linux/syscalls.h |  3 ++-
 mm/madvise.c             | 34 ++++++++++++++++++++++------------
 2 files changed, 24 insertions(+), 13 deletions(-)

diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index e4cd2c2f8bb4..f5ada20e2943 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -876,7 +876,8 @@ asmlinkage long sys_munlockall(void);
 asmlinkage long sys_mincore(unsigned long start, size_t len,
 				unsigned char __user * vec);
 asmlinkage long sys_madvise(unsigned long start, size_t len, int behavior);
-asmlinkage long sys_process_madvise(int pidfd, unsigned long start,
+
+asmlinkage long sys_process_madvise(int which, pid_t pid, unsigned long start,
 			size_t len, int behavior, unsigned long flags);
 asmlinkage long sys_remap_file_pages(unsigned long start, unsigned long size,
 			unsigned long prot, unsigned long pgoff,
diff --git a/mm/madvise.c b/mm/madvise.c
index def1507c2030..f6d9b9e66243 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -1182,11 +1182,10 @@ SYSCALL_DEFINE3(madvise, unsigned long, start, size_t, len_in, int, behavior)
 	return do_madvise(current, current->mm, start, len_in, behavior);
 }
 
-SYSCALL_DEFINE5(process_madvise, int, pidfd, unsigned long, start,
+SYSCALL_DEFINE6(process_madvise, int, which, pid_t, upid, unsigned long, start,
 		size_t, len_in, int, behavior, unsigned long, flags)
 {
 	int ret;
-	struct fd f;
 	struct pid *pid;
 	struct task_struct *task;
 	struct mm_struct *mm;
@@ -1197,20 +1196,31 @@ SYSCALL_DEFINE5(process_madvise, int, pidfd, unsigned long, start,
 	if (!process_madvise_behavior_valid(behavior))
 		return -EINVAL;
 
-	f = fdget(pidfd);
-	if (!f.file)
-		return -EBADF;
+	switch (which) {
+	case P_PID:
+		if (upid <= 0)
+			return -EINVAL;
+
+		pid = find_get_pid(upid);
+		if (!pid)
+			return -ESRCH;
+		break;
+	case P_PIDFD:
+		if (upid < 0)
+			return -EINVAL;
 
-	pid = pidfd_pid(f.file);
-	if (IS_ERR(pid)) {
-		ret = PTR_ERR(pid);
-		goto fdput;
+		pid = pidfd_get_pid(upid);
+		if (IS_ERR(pid))
+			return PTR_ERR(pid);
+		break;
+	default:
+		return -EINVAL;
 	}
 
 	task = get_pid_task(pid, PIDTYPE_PID);
 	if (!task) {
 		ret = -ESRCH;
-		goto fdput;
+		goto put_pid;
 	}
 
 	mm = mm_access(task, PTRACE_MODE_ATTACH_FSCREDS);
@@ -1223,7 +1233,7 @@ SYSCALL_DEFINE5(process_madvise, int, pidfd, unsigned long, start,
 	mmput(mm);
 release_task:
 	put_task_struct(task);
-fdput:
-	fdput(f);
+put_pid:
+	put_pid(pid);
 	return ret;
 }
-- 
2.25.0.265.gbab2e86ba0-goog


Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19A0414005E
	for <lists+linux-api@lfdr.de>; Fri, 17 Jan 2020 01:00:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726189AbgAQAAR (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 16 Jan 2020 19:00:17 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40994 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387651AbgAQAAN (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 16 Jan 2020 19:00:13 -0500
Received: by mail-pg1-f193.google.com with SMTP id x8so10729264pgk.8;
        Thu, 16 Jan 2020 16:00:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QglLgkqFjKQCxygZipmvR3GsUGfJTk60o5ZOd6nyvzM=;
        b=A5GN7q7x2GgL0yPH12L2wx30f/yE2I9iB0owJ5yvV6hgmMPnJliTxnId1SVEnEGQpd
         QvlmNEQyMO0r00oVtIp6KNJj/mc6EGd+aeeqNfrLm7+djbPkDqYAUwmkn8tD3JtS+QoY
         oh5qRUm0J8PChTC7+42Ua/aMp6heo62nShftwWrQZo4vyJWOdqVqg/Rrc9Vt0A0T4JwX
         5bxaKMe+tXS7W+igmL+rFGNTMRuh8nXhpJWEohjzJKTG6fKgHto/dIcDsfe5JQxOLW0+
         sgPsdAE6RPWPazEoIO+1MTqZjkBjylWA3gDkPE0/1rERbm+P70i7VztTgwVGKggowswh
         qDlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=QglLgkqFjKQCxygZipmvR3GsUGfJTk60o5ZOd6nyvzM=;
        b=S2VgiuywyGEYZH5/FmLqAJ2cO2PHdE8V/PSCkBTRayAQQUE9MfSz0e3uhae4DCLSC9
         VYanx+qvgituQqGRAIpPfhi0qzMGsqekIQ/CIk2Rb0jn+upq+8muZ/bnUPxgdSfpOcz7
         lHK+jNtlbe27L1MgW95d+zmn7LiOQI6dPSme4V7821NXdnCvT87gztDjd0oR05OF9Kuy
         rcB7dV4ebG/1XpjfGMvFroin/tEMJPkBVoCrrGXKuAcfQkQqOxGS8gIMAXLYJpx9CAbO
         sr/jARoP0cl9tSqncfGojNOgVDD68ZmbhuZYh6J0f3zjIZgqD1uzSeu2YnxVZ60zbbXv
         TuEQ==
X-Gm-Message-State: APjAAAWflUCmSYug9kZ9bmACYJqKvrM2CQ4d8fv3k4KD014pXd8/rCeo
        Qn0vqPGczFheM4HhRxftUqU=
X-Google-Smtp-Source: APXvYqwsJcCW+qt7R9B04B+vnwPfGrVGJtCei/LJzA5JSNhEEvKUwibk1XtW2akSOZv3EZr4Odh6TA==
X-Received: by 2002:a63:dd58:: with SMTP id g24mr41178134pgj.102.1579219212474;
        Thu, 16 Jan 2020 16:00:12 -0800 (PST)
Received: from bbox-1.mtv.corp.google.com ([2620:15c:211:1:3e01:2939:5992:52da])
        by smtp.gmail.com with ESMTPSA id z4sm26584885pfn.42.2020.01.16.16.00.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2020 16:00:11 -0800 (PST)
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
        John Dias <joaodias@google.com>, ktkhai@virtuozzo.com,
        christian.brauner@ubuntu.com, sjpark@amazon.de,
        Minchan Kim <minchan@kernel.org>
Subject: [PATCH v2 5/5] mm: support both pid and pidfd for process_madvise
Date:   Thu, 16 Jan 2020 15:59:53 -0800
Message-Id: <20200116235953.163318-6-minchan@kernel.org>
X-Mailer: git-send-email 2.25.0.rc1.283.g88dfdc4193-goog
In-Reply-To: <20200116235953.163318-1-minchan@kernel.org>
References: <20200116235953.163318-1-minchan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

There is a demand[1] to support pid as well pidfd for process_madvise
to reduce unncessary syscall to get pidfd if the user has control of
the targer process(ie, they could gaurantee the process is not gone
or pid is not reused. Or, it might be okay to give a hint to wrong
process).

This patch aims for supporting both options like waitid(2). So, the
syscall is currently,

	int process_madvise(int which, pid_t pid, void *addr,
		size_t length, int advise, unsigned long flag);

@which is actually idtype_t for userspace libray and currently,
it supports P_PID and P_PIDFD.

[1]  https://lore.kernel.org/linux-mm/9d849087-3359-c4ab-fbec-859e8186c509@virtuozzo.com/
Signed-off-by: Minchan Kim <minchan@kernel.org>
---
 include/linux/pid.h      |  1 +
 include/linux/syscalls.h |  3 ++-
 kernel/exit.c            | 17 -----------------
 kernel/pid.c             | 17 +++++++++++++++++
 mm/madvise.c             | 34 ++++++++++++++++++++++------------
 5 files changed, 42 insertions(+), 30 deletions(-)

diff --git a/include/linux/pid.h b/include/linux/pid.h
index 998ae7d24450..023d9c3a8edc 100644
--- a/include/linux/pid.h
+++ b/include/linux/pid.h
@@ -75,6 +75,7 @@ extern const struct file_operations pidfd_fops;
 struct file;
 
 extern struct pid *pidfd_pid(const struct file *file);
+extern struct pid *pidfd_get_pid(unsigned int fd);
 
 static inline struct pid *get_pid(struct pid *pid)
 {
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 1b58a11ff49f..27060e59db37 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -877,7 +877,8 @@ asmlinkage long sys_munlockall(void);
 asmlinkage long sys_mincore(unsigned long start, size_t len,
 				unsigned char __user * vec);
 asmlinkage long sys_madvise(unsigned long start, size_t len, int behavior);
-asmlinkage long sys_process_madvise(int pidfd, unsigned long start,
+
+asmlinkage long sys_process_madvise(int which, pid_t pid, unsigned long start,
 			size_t len, int behavior, unsigned long flags);
 asmlinkage long sys_remap_file_pages(unsigned long start, unsigned long size,
 			unsigned long prot, unsigned long pgoff,
diff --git a/kernel/exit.c b/kernel/exit.c
index bcbd59888e67..7698843b1411 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -1466,23 +1466,6 @@ static long do_wait(struct wait_opts *wo)
 	return retval;
 }
 
-static struct pid *pidfd_get_pid(unsigned int fd)
-{
-	struct fd f;
-	struct pid *pid;
-
-	f = fdget(fd);
-	if (!f.file)
-		return ERR_PTR(-EBADF);
-
-	pid = pidfd_pid(f.file);
-	if (!IS_ERR(pid))
-		get_pid(pid);
-
-	fdput(f);
-	return pid;
-}
-
 static long kernel_waitid(int which, pid_t upid, struct waitid_info *infop,
 			  int options, struct rusage *ru)
 {
diff --git a/kernel/pid.c b/kernel/pid.c
index 2278e249141d..a41a89d5dad2 100644
--- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -496,6 +496,23 @@ struct pid *find_ge_pid(int nr, struct pid_namespace *ns)
 	return idr_get_next(&ns->idr, &nr);
 }
 
+struct pid *pidfd_get_pid(unsigned int fd)
+{
+	struct fd f;
+	struct pid *pid;
+
+	f = fdget(fd);
+	if (!f.file)
+		return ERR_PTR(-EBADF);
+
+	pid = pidfd_pid(f.file);
+	if (!IS_ERR(pid))
+		get_pid(pid);
+
+	fdput(f);
+	return pid;
+}
+
 /**
  * pidfd_create() - Create a new pid file descriptor.
  *
diff --git a/mm/madvise.c b/mm/madvise.c
index 89557998d287..2ac62716e5b8 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -1192,11 +1192,10 @@ SYSCALL_DEFINE3(madvise, unsigned long, start, size_t, len_in, int, behavior)
 	return madvise_common(current, current->mm, start, len_in, behavior);
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
@@ -1207,20 +1206,31 @@ SYSCALL_DEFINE5(process_madvise, int, pidfd, unsigned long, start,
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
@@ -1233,7 +1243,7 @@ SYSCALL_DEFINE5(process_madvise, int, pidfd, unsigned long, start,
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
2.25.0.rc1.283.g88dfdc4193-goog


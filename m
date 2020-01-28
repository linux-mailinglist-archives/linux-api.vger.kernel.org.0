Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F251A14AD10
	for <lists+linux-api@lfdr.de>; Tue, 28 Jan 2020 01:17:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727409AbgA1ARG (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 27 Jan 2020 19:17:06 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40297 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727349AbgA1ARG (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 27 Jan 2020 19:17:06 -0500
Received: by mail-pg1-f196.google.com with SMTP id k25so6006336pgt.7;
        Mon, 27 Jan 2020 16:17:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DFddCGft10v2bQSudyfgAPH5BoTHwqkfOKU43Rs2xJE=;
        b=aIehdGRAgVBVPEq2gRJ0LE0eSQ+ycX1FJyYgSNugQH/5B66O76XPt/VYuSGHHZMiKr
         ZWqld+TqHK46psw2qThyQOFRl403+9ZdBIQSCMs6MqcEa8RvutS6hVC/nziwY4Ezx2lx
         EM/4TnPC5ngC7rdFkyu3Tlc1F9rJ8P3N8rc+6YOVu6j+iAriWg9nvMt6GX1FtCqdN6bo
         mJGS8yb0K0NzYHlX9ZgyYm2JdWYm+2Hb3QtTvWBYpfneNidSLKKv8Zg2edABy9ypSUuW
         J4eECDCRfFC+7n80ls04tZFQ3bbzcMQjgvQdKWuBnU3qStV2u4byHtY2lNl1rysXY/Wf
         I/bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=DFddCGft10v2bQSudyfgAPH5BoTHwqkfOKU43Rs2xJE=;
        b=lLzc01IGqbcMFD/oCV05wtxj6rtAgau7JSOQ5LKgPdGPsu7gegYSIskDLZluNznf3D
         3+8mx0rFwJs5m53ImcH2rSqpXrRcshYLeXAHo19PcKV7XL3jYZCU5cG8MWyOnXKhjF0w
         QDPEu9HSYUim8OTbqHh+J52Xg1jzwhPvD9+BeKZKn8Wvbys311ru0oijhsDc5DP1LPpt
         hfLUNvsxF7YKT8FJ+f1x1lRFlHE33qhOzltekYhVGSikmcKOoERwsZsCUaj/+cn8fb6i
         lH4+Licu8yAuguNdYOmRM5IVtEytoIx7kea1P8GLEvR1z/RUe0IwRrtei0YXGOwA+4O7
         MbbQ==
X-Gm-Message-State: APjAAAVRRhfLKMXOIYJJWoWsqJ8BH7y22GnqKxRVIzE6i4mr/2+29kqz
        serKDpttIp4DiOGwn3ykse8=
X-Google-Smtp-Source: APXvYqz072ZRCKWyoVYCQKz+MnVhFgtgIa6SRKQwU7Wnjg7uDw3D/Jd26+3lolr41UxLe9ftFCOCiA==
X-Received: by 2002:aa7:81c7:: with SMTP id c7mr1235750pfn.203.1580170625323;
        Mon, 27 Jan 2020 16:17:05 -0800 (PST)
Received: from bbox-1.mtv.corp.google.com ([2620:15c:211:1:3e01:2939:5992:52da])
        by smtp.gmail.com with ESMTPSA id q28sm11301461pfl.153.2020.01.27.16.17.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2020 16:17:04 -0800 (PST)
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
        Minchan Kim <minchan@kernel.org>
Subject: [PATCH v3 5/5] mm: support both pid and pidfd for process_madvise
Date:   Mon, 27 Jan 2020 16:16:41 -0800
Message-Id: <20200128001641.5086-6-minchan@kernel.org>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
In-Reply-To: <20200128001641.5086-1-minchan@kernel.org>
References: <20200128001641.5086-1-minchan@kernel.org>
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
index 39c40cbb389e..ba3a9bd8ea27 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -1197,11 +1197,10 @@ SYSCALL_DEFINE3(madvise, unsigned long, start, size_t, len_in, int, behavior)
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
@@ -1212,20 +1211,31 @@ SYSCALL_DEFINE5(process_madvise, int, pidfd, unsigned long, start,
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
@@ -1238,7 +1248,7 @@ SYSCALL_DEFINE5(process_madvise, int, pidfd, unsigned long, start,
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
2.25.0.341.g760bfbb309-goog


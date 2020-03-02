Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E550176421
	for <lists+linux-api@lfdr.de>; Mon,  2 Mar 2020 20:38:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbgCBTiS (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 2 Mar 2020 14:38:18 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:42605 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727413AbgCBTgw (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 2 Mar 2020 14:36:52 -0500
Received: by mail-pl1-f195.google.com with SMTP id u3so182310plr.9;
        Mon, 02 Mar 2020 11:36:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pHysGZtRm9DpDxh7VwFObxgb2rj7KREaKfoe8EJ8zu8=;
        b=jdVlEcSDzo3ybdd7sN6kE2OKzk9oA7bpxTLKHadgEWCMOybjQ+xvZnJGVZ7fZjEfQg
         uMEDZ86LuVgP1Q6ZD7VtneBpW3iteqpuTrP3/PWga/dBDviAOIX7pwxJvpurzCqOj7fN
         jQT25IdzQdbEKTplDxwjaE6/Sp8da28vTFvaqYVQXWMS/ijYzC9/vT04XJhzJeUyFmi5
         W1dY2xG14HMz217CZrrz7AQLnie7ovjZYjeZ46ICnLv/i7QSZQi050GPkvgyUDs+oPaF
         p9OjX1JTqSRH+dMbwMtnn3Yrjt7fT/yKlKug7rJY5AteQTiqrX7VGVvcPd+bOjNPIBRu
         c9OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=pHysGZtRm9DpDxh7VwFObxgb2rj7KREaKfoe8EJ8zu8=;
        b=ckLOo4o0u8ITN4DCQ4XKB96swS7lcsNV2lzNaLQeuBcUJsio0oze2TSwqX3Q2pADhD
         IvG7SKNuscIGnMBjaH6M6hkcgYDX8JQCQt//wQZYZWZW095/1G3LgRObiXL+28rVsudf
         mtcF0Q4iWtGKoN1kcSAuZKLI8dP3Wg+7pAkdukmiwPrsvTvcz6UsoIrOWbLEBiyuXXPm
         ZWvQ7HzfycDxtBLYyttPzgya040QCSiP2JSQRhv3urI+afnpgZNcCXONWOvNfcbVS3J7
         /XdxMtbAaF9bveaazbRwNHjL3kkkGrimPqLQXIWcdWvKnSMeI1lo7Gj1uXdQnNk6xeCQ
         tW9A==
X-Gm-Message-State: ANhLgQ0zQ/YzWdnBESuVTRsRZqxy+ZqzFgakHVRssPpQlwDY6FvnzOiP
        6tXKvwToL+N4b5ahJcUtYLw=
X-Google-Smtp-Source: ADFU+vuNMy9czC34xQNT/3L0cavE3HOPPROCVeNfLMB3n1LQxWwOUbMYURhKYhirIyIz1qSVT3nMgQ==
X-Received: by 2002:a17:90a:ec10:: with SMTP id l16mr37690pjy.19.1583177810150;
        Mon, 02 Mar 2020 11:36:50 -0800 (PST)
Received: from bbox-1.mtv.corp.google.com ([2620:15c:211:1:3e01:2939:5992:52da])
        by smtp.gmail.com with ESMTPSA id hg6sm35441pjb.22.2020.03.02.11.36.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2020 11:36:49 -0800 (PST)
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
        Jann Horn <jannh@google.com>,
        alexander.h.duyck@linux.intel.com, sj38.park@gmail.com,
        Minchan Kim <minchan@kernel.org>,
        Christian Brauner <christian@brauner.io>,
        Kirill Tkhai <ktkhai@virtuozzo.com>
Subject: [PATCH v7 5/7] mm: support both pid and pidfd for process_madvise
Date:   Mon,  2 Mar 2020 11:36:28 -0800
Message-Id: <20200302193630.68771-6-minchan@kernel.org>
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
In-Reply-To: <20200302193630.68771-1-minchan@kernel.org>
References: <20200302193630.68771-1-minchan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

There is a demand[1] to support pid as well pidfd for process_madvise
to reduce unnecessary syscall to get pidfd if the user has control of
the target process(ie, they could guarantee the process is not gone
or pid is not reused).

This patch aims for supporting both options like waitid(2). So, the
syscall is currently,

	int process_madvise(int which, pid_t pid, void *addr,
		size_t length, int advise, unsigned long flag);

@which is actually idtype_t for userspace libray and currently,
it supports P_PID and P_PIDFD.

[1]  https://lore.kernel.org/linux-mm/9d849087-3359-c4ab-fbec-859e8186c509@virtuozzo.com/

Cc: Christian Brauner <christian@brauner.io>
Reviewed-by: Suren Baghdasaryan <surenb@google.com>
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
index 6543f2bfc3d8..e794367f681e 100644
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


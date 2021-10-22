Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96FA4436F90
	for <lists+linux-api@lfdr.de>; Fri, 22 Oct 2021 03:47:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231603AbhJVBtV (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 21 Oct 2021 21:49:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231502AbhJVBtU (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 21 Oct 2021 21:49:20 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19577C061764
        for <linux-api@vger.kernel.org>; Thu, 21 Oct 2021 18:47:03 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id t7-20020a258387000000b005b6d7220c79so2365065ybk.16
        for <linux-api@vger.kernel.org>; Thu, 21 Oct 2021 18:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=OSz5Xs/L17ZVVFibJw8deZ4Hpezvx7aG8ZEAixdJaAQ=;
        b=HtioIS3XvjJWvKb20k1mf4Zj5siAmZj1FBi/lBdkkAdxYzwIqeBQm0wDo8mScUhPtz
         /6aeFgG9jBeyNeSwA8rRbd4Ty7xf7sy2LA0VfTezC85UujHZQoMDuWgFEM7A7XmrTZZ6
         yPwkg+vN9HhSJtHfOUM+HTAwKuarMvUC7lEqnpOaDt9Ns1ohpR3Xfzt6l+lbF5XJX2ri
         OZn2jlAFqSDDV3FRJ8rs254BxBIblUb1PBSVgVg55cy4GHBlBlFZmXDR29h7JnoOubg/
         Y8i9IMtLYPS7ZGxNEgDMj+ldVTgdVmWTMN/AJEKsJtmDbQTAjFFgPyUDN3a9u/gJKTM/
         jxNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=OSz5Xs/L17ZVVFibJw8deZ4Hpezvx7aG8ZEAixdJaAQ=;
        b=hPheIii97USSawZZWQdnH2szx3AN7mC0d7cjHBpUiwx2AQM91guDRbkDz0sTcEP/RU
         9go9PpCFtC5nz90pD+8ue1rMe+NbzQoZZqBCYYFSPEX9Do3oHw9nq28g58e5mpEd/xVC
         qsq6HbQz7XK/uiNLDs5A1wTbiI7MQDeckvk3xUAgHWCktqD3ifAfXLlKNIgqb8XoXAYo
         yW4JPqgBJb/nI2ZsdwOehR3fDZlNQnt6uOGkl2X5UFrGPLAt2YVH1U0/XIqt0QwaBW9h
         DLKumTZ2jsQCXZcuYTh1q1d15nV7jqe9ON3gp+Ls7pEr5mGxsUE7c+f6adIwURYFbbww
         9X5g==
X-Gm-Message-State: AOAM533otizFkE195/pWh42Lw2Cgld2dwTxDCGs4tmHbVQhxwWowdiLP
        cWdkvvEgJYVoKMxndDo/Vaqd0fHLDGM=
X-Google-Smtp-Source: ABdhPJyPE9Pi2rOd+GtIRKy74MwB8b6FJ6jUd7F71YgVyepNEY0BZggKczOYEcmw6bLz121N12RDlg9MYXA=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:c063:38ee:4ca3:d373])
 (user=surenb job=sendgmr) by 2002:a25:c344:: with SMTP id t65mr10532797ybf.409.1634867222322;
 Thu, 21 Oct 2021 18:47:02 -0700 (PDT)
Date:   Thu, 21 Oct 2021 18:46:58 -0700
Message-Id: <20211022014658.263508-1-surenb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.1079.g6e70778dc9-goog
Subject: [PATCH 1/1] mm: prevent a race between process_mrelease and exit_mmap
From:   Suren Baghdasaryan <surenb@google.com>
To:     akpm@linux-foundation.org
Cc:     mhocko@kernel.org, mhocko@suse.com, rientjes@google.com,
        willy@infradead.org, hannes@cmpxchg.org, guro@fb.com,
        riel@surriel.com, minchan@kernel.org, christian@brauner.io,
        hch@infradead.org, oleg@redhat.com, david@redhat.com,
        jannh@google.com, shakeelb@google.com, luto@kernel.org,
        christian.brauner@ubuntu.com, fweimer@redhat.com, jengelh@inai.de,
        linux-api@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        surenb@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Race between process_mrelease and exit_mmap, where free_pgtables is
called while __oom_reap_task_mm is in progress, leads to kernel crash
during pte_offset_map_lock call. oom-reaper avoids this race by setting
MMF_OOM_VICTIM flag and causing exit_mmap to take and release
mmap_write_lock, blocking it until oom-reaper releases mmap_read_lock.
Reusing MMF_OOM_VICTIM for process_mrelease would be the simplest way to
fix this race, however that would be considered a hack. Fix this race
by elevating mm->mm_users and preventing exit_mmap from executing until
process_mrelease is finished. Patch slightly refactors the code to adapt
for a possible mmget_not_zero failure.
This fix has considerable negative impact on process_mrelease performance
and will likely need later optimization.

Fixes: 884a7e5964e0 ("mm: introduce process_mrelease system call")
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 mm/oom_kill.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index 831340e7ad8b..989f35a2bbb1 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -1150,7 +1150,7 @@ SYSCALL_DEFINE2(process_mrelease, int, pidfd, unsigned int, flags)
 	struct task_struct *task;
 	struct task_struct *p;
 	unsigned int f_flags;
-	bool reap = true;
+	bool reap = false;
 	struct pid *pid;
 	long ret = 0;
 
@@ -1177,15 +1177,15 @@ SYSCALL_DEFINE2(process_mrelease, int, pidfd, unsigned int, flags)
 		goto put_task;
 	}
 
-	mm = p->mm;
-	mmgrab(mm);
-
-	/* If the work has been done already, just exit with success */
-	if (test_bit(MMF_OOM_SKIP, &mm->flags))
-		reap = false;
-	else if (!task_will_free_mem(p)) {
-		reap = false;
-		ret = -EINVAL;
+	if (mmget_not_zero(p->mm)) {
+		mm = p->mm;
+		if (task_will_free_mem(p))
+			reap = true;
+		else {
+			/* Error only if the work has not been done already */
+			if (!test_bit(MMF_OOM_SKIP, &mm->flags))
+				ret = -EINVAL;
+		}
 	}
 	task_unlock(p);
 
@@ -1201,7 +1201,8 @@ SYSCALL_DEFINE2(process_mrelease, int, pidfd, unsigned int, flags)
 	mmap_read_unlock(mm);
 
 drop_mm:
-	mmdrop(mm);
+	if (mm)
+		mmput(mm);
 put_task:
 	put_task_struct(task);
 put_pid:
-- 
2.33.0.1079.g6e70778dc9-goog


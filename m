Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22F0C48E10E
	for <lists+linux-api@lfdr.de>; Fri, 14 Jan 2022 00:40:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238286AbiAMXkQ (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 13 Jan 2022 18:40:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238277AbiAMXkP (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 13 Jan 2022 18:40:15 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37CCAC061751
        for <linux-api@vger.kernel.org>; Thu, 13 Jan 2022 15:40:15 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id h2-20020a5b0a82000000b0061192499188so14727344ybq.9
        for <linux-api@vger.kernel.org>; Thu, 13 Jan 2022 15:40:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=M6CqLRKobTxmQJYwGP116eObFPKtwslTaqzW/rSJTK8=;
        b=qMGBjdhvTEK6hecBGOuRoK6F9ospIcTv+bSkzHtDzzW7elpIvv8C06+6MKkfz7rono
         PuJSCFA3CXEtek3Rf9jxxOyl/l7tTBEZ04+rY1/G7T+btp87CZdeFeT3eLx7mSuseTHi
         iUvCt0mbOOYItyWq9/z/yf7UhMvCB6omSP+9cILENtov+4CzMlPKk4ChS/CCDgOGcR7x
         rYu6FH+COfsfs2ihA+0r4LYfiiAGOXB0NDa+BWnm9ZmHakjHKtseaH4QESWTp8WFfWnH
         58XhmuiKFvO8OPBHefgWNMoqmUWy+6FE+BPuXyneucVFuZG5qCO1pP3RrHlwIjnG+ltC
         yX+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=M6CqLRKobTxmQJYwGP116eObFPKtwslTaqzW/rSJTK8=;
        b=qYQQcUqEcl+U6rzZqiLZyVdar6bhrgHG+o7K9ReFt7/zaKaOMwKh2W7FZ9QkI1f+LG
         MOMCEBTa798n3e79hLxSzZVLz1rn5h+eHAqwofQgTi5svhTYB+OSaza41lwL6GaMCv57
         HyVUH+m39PAjm8lVJ3zPU7kpRGANWt16ppvxE8XJNG76NTQYqOf2l+NxZwolaaHpNEcC
         2cGVUK80TF2OH5yQtvu2mmfilObzQYNYJdZxED85CNbbLTL9AsFUKgD7p4KFOUKMG4Dt
         QP1wdpGwT3TgnydSYwBCjT7VQ/eN5hRDwxDSUXLLMSbrAQN8x+BSI+SBSGHkNGCexkpt
         9miQ==
X-Gm-Message-State: AOAM533X6valO5So0rUMGLsKIffPwPm/ifzi6zseMNYBWUDtwC8fLfae
        t7XUkExiRnUTPUAoUqWWwfVSlyj9
X-Google-Smtp-Source: ABdhPJyMyvqiBBmhkwL82olAcxjEEcUWe5ozz1YnPt/AtCMregTQoiHsk98ChHrmtDs/+uO8eeFVk5cL
X-Received: from posk.svl.corp.google.com ([2620:15c:2cd:202:c548:e79f:8954:121f])
 (user=posk job=sendgmr) by 2002:a25:ae8b:: with SMTP id b11mr9266950ybj.453.1642117214365;
 Thu, 13 Jan 2022 15:40:14 -0800 (PST)
Date:   Thu, 13 Jan 2022 15:39:40 -0800
In-Reply-To: <20220113233940.3608440-1-posk@google.com>
Message-Id: <20220113233940.3608440-6-posk@google.com>
Mime-Version: 1.0
References: <20220113233940.3608440-1-posk@google.com>
X-Mailer: git-send-email 2.34.1.703.g22d0c6ccf7-goog
Subject: [RFC PATCH v2 5/5] sched: UMCG: allow to sys_umcg_kick UMCG servers
From:   Peter Oskolkov <posk@google.com>
To:     Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com,
        tglx@linutronix.de, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-api@vger.kernel.org, x86@kernel.org, pjt@google.com,
        posk@google.com, avagin@google.com, jannh@google.com,
        tdelisle@uwaterloo.ca, posk@posk.io
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Add enum umcg_kick_flags:
  @UMCG_KICK_RESCHED: reschedule the task; used for worker preemption
  @UMCG_KICK_TTWU: wake the task; used to wake servers.

It is sometimes useful to wake UMCG servers from the userspace, for
example when a server detects a worker wakeup and wakes an idle server to
run the newly woken worker.

Signed-off-by: Peter Oskolkov <posk@google.com>
---
 include/uapi/linux/umcg.h | 10 ++++++++++
 kernel/sched/umcg.c       |  7 +++++--
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/umcg.h b/include/uapi/linux/umcg.h
index 93fccb44283b..a29e5e91a251 100644
--- a/include/uapi/linux/umcg.h
+++ b/include/uapi/linux/umcg.h
@@ -148,4 +148,14 @@ enum umcg_ctl_flag {
 	UMCG_CTL_WORKER		= 0x10000,
 };
 
+/**
+ * enum umcg_kick_flag - flags to pass to sys_umcg_kick
+ * @UMCG_KICK_RESCHED: reschedule the task; used for worker preemption
+ * @UMCG_KICK_TTWU: wake the task; used to wake servers
+ */
+enum umcg_kick_flag {
+	UMCG_KICK_RESCHED	= 0x001,
+	UMCG_KICK_TTWU		= 0x002,
+};
+
 #endif /* _UAPI_LINUX_UMCG_H */
diff --git a/kernel/sched/umcg.c b/kernel/sched/umcg.c
index b85dec6b82e4..e33ec9eddc3e 100644
--- a/kernel/sched/umcg.c
+++ b/kernel/sched/umcg.c
@@ -669,12 +669,15 @@ SYSCALL_DEFINE2(umcg_kick, u32, flags, pid_t, tid)
 	if (!task)
 		return -ESRCH;
 
-	if (flags)
+	if (flags != UMCG_KICK_RESCHED && flags != UMCG_KICK_TTWU)
 		return -EINVAL;
 
 #ifdef CONFIG_SMP
-	smp_send_reschedule(task_cpu(task));
+	if (flags == UMCG_KICK_RESCHED)
+		smp_send_reschedule(task_cpu(task));
 #endif
+	if (flags == UMCG_KICK_TTWU)
+		try_to_wake_up(task, TASK_NORMAL, 0);
 
 	return 0;
 }
-- 
2.34.1.703.g22d0c6ccf7-goog


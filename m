Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E30E1A529F
	for <lists+linux-api@lfdr.de>; Sat, 11 Apr 2020 17:40:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726107AbgDKPki (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sat, 11 Apr 2020 11:40:38 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:43842 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726070AbgDKPkh (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sat, 11 Apr 2020 11:40:37 -0400
Received: by mail-pl1-f194.google.com with SMTP id z6so1692947plk.10;
        Sat, 11 Apr 2020 08:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7U7Efuw8t67Rzr9PB6Om5XS263l3YQcwzV0qInrnhi0=;
        b=RZ/Nep5FA/eoP432Pixq5KwLC6KOxPerlfUpAkTwwskEX2y+jfmylFkNiDFqETTzYc
         Yl8YDBK8+5WKmT0uflg50XFIpiFjj2wh9YKuMq93gX2ZD7dQ5z/+i5SMlGF4aj2mtIWJ
         JM5pu1+bwSpFi00JHdRYBM82o4T60qukNp0i/mW08VgcURQlXOPnZSxYZQGTEDLvQxGy
         nirTWxBUtlq52W+qyVY0lblqyMCdkB0p8UY4wsuhotAlI4gKXf3vDslLY9SiUnuqOM4b
         Pjw+r6Bem/VTbDss4zGycuwEYWfqS+u4MeoMcZSKDoxIfqwx8IKi4NS9V4mwzYtITaC8
         Qouw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7U7Efuw8t67Rzr9PB6Om5XS263l3YQcwzV0qInrnhi0=;
        b=Q7bQrSLTtbTzVKLIe8zzHuCSvWEaYzOSoLdovKA/giNuXqVd4Zl2VUsNWoeqwccGkE
         eWqyRNgSqDCQWoQAuXCHvtF4HTWBtWcvCxubSWSvGnmPktOnGzglPG5JoCxTOMfKdqHA
         wAmPuUD/YTtKwV269dszSAxBvvBBtgGXKnOmDb6vHrdDG1J5xgJ8iEI6IIIm3JBPTx/h
         q3QSmPM9n8BS9/dOU5TYsx5mxTCPOVFktH4EpKRwz6rcgsyUyfflrNdr1Jd/KyB3xwka
         6Z27EphenweYdSJUAfxO3EVeBcnRWt+LmIv9FUAE5kqhi2yRWpmeWy+iH9qxcB8g/VMH
         klxw==
X-Gm-Message-State: AGi0PuZakunoEoF6NYC3h/EAKdIda22e7OyS2H88m4TFIEzvMr80i66o
        6zvH6xT4znlFOJ18OgHWhCo=
X-Google-Smtp-Source: APiQypJjVb3+jeLZxVkN2Y1SWlS++J8/wCQre/x82HylISwdOHnUBwWYwIx3eDHlBi7pS9kFY0/uKA==
X-Received: by 2002:a17:90a:3266:: with SMTP id k93mr2098322pjb.118.1586619637196;
        Sat, 11 Apr 2020 08:40:37 -0700 (PDT)
Received: from laptop.hsd1.wa.comcast.net ([2601:600:817f:a132:df3e:521d:99d5:710d])
        by smtp.gmail.com with ESMTPSA id 18sm4508988pfv.118.2020.04.11.08.40.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Apr 2020 08:40:36 -0700 (PDT)
From:   Andrei Vagin <avagin@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>
Cc:     linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrei Vagin <avagin@gmail.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>
Subject: [PATCH v2] timens: show clock symbolic names in /proc/pid/timens_offsets
Date:   Sat, 11 Apr 2020 08:40:31 -0700
Message-Id: <20200411154031.642557-1-avagin@gmail.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <96bedbaf-49ea-f24b-b7b1-fb9a57fb6c7d@gmail.com>
References: <96bedbaf-49ea-f24b-b7b1-fb9a57fb6c7d@gmail.com>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Michael Kerrisk suggested to replace numeric clock IDs on symbolic
names.

Now the content of these files looks like this:
$ cat /proc/774/timens_offsets
monotonic      864000         0
boottime      1728000         0

For setting offsets, both representations of clocks can be used.

As for compatibility, it is acceptable to change things as long as
userspace doesn't care. The format of timens_offsets files is very
new and there are no userspace tools that rely on this format.

But three projects crun, util-linux and criu rely on the interface of
setting time offsets and this is why we need to continue supporting the
clock IDs in this case.

Fixes: 04a8682a71be ("fs/proc: Introduce /proc/pid/timens_offsets")
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Eric W. Biederman <ebiederm@xmission.com>
Cc: Dmitry Safonov <0x7f454c46@gmail.com>
Acked-by: Michael Kerrisk <mtk.manpages@gmail.com>                                                                                                                                            
Tested-by: Michael Kerrisk <mtk.manpages@gmail.com> 
Suggested-by: Michael Kerrisk <mtk.manpages@gmail.com>
Signed-off-by: Andrei Vagin <avagin@gmail.com>
---

v2: use the more compact format of timens_offsets files.

 fs/proc/base.c          | 14 +++++++++++++-
 kernel/time/namespace.c | 15 ++++++++++++++-
 2 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index 6042b646ab27..572898dd16a0 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -1573,6 +1573,7 @@ static ssize_t timens_offsets_write(struct file *file, const char __user *buf,
 	noffsets = 0;
 	for (pos = kbuf; pos; pos = next_line) {
 		struct proc_timens_offset *off = &offsets[noffsets];
+		char clock[10];
 		int err;
 
 		/* Find the end of line and ensure we don't look past it */
@@ -1584,10 +1585,21 @@ static ssize_t timens_offsets_write(struct file *file, const char __user *buf,
 				next_line = NULL;
 		}
 
-		err = sscanf(pos, "%u %lld %lu", &off->clockid,
+		err = sscanf(pos, "%9s %lld %lu", clock,
 				&off->val.tv_sec, &off->val.tv_nsec);
 		if (err != 3 || off->val.tv_nsec >= NSEC_PER_SEC)
 			goto out;
+
+		clock[sizeof(clock) - 1] = 0;
+		if (strcmp(clock, "monotonic") == 0 ||
+		    strcmp(clock, __stringify(CLOCK_MONOTONIC)) == 0)
+			off->clockid = CLOCK_MONOTONIC;
+		else if (strcmp(clock, "boottime") == 0 ||
+			 strcmp(clock, __stringify(CLOCK_BOOTTIME)) == 0)
+			off->clockid = CLOCK_BOOTTIME;
+		else
+			goto out;
+
 		noffsets++;
 		if (noffsets == ARRAY_SIZE(offsets)) {
 			if (next_line)
diff --git a/kernel/time/namespace.c b/kernel/time/namespace.c
index e6ba064ce773..757581d64246 100644
--- a/kernel/time/namespace.c
+++ b/kernel/time/namespace.c
@@ -338,7 +338,20 @@ static struct user_namespace *timens_owner(struct ns_common *ns)
 
 static void show_offset(struct seq_file *m, int clockid, struct timespec64 *ts)
 {
-	seq_printf(m, "%d %lld %ld\n", clockid, ts->tv_sec, ts->tv_nsec);
+	char *clock;
+
+	switch (clockid) {
+	case CLOCK_BOOTTIME:
+		clock = "boottime";
+		break;
+	case CLOCK_MONOTONIC:
+		clock = "monotonic";
+		break;
+	default:
+		clock = "unknown";
+		break;
+	}
+	seq_printf(m, "%-10s %10lld %9ld\n", clock, ts->tv_sec, ts->tv_nsec);
 }
 
 void proc_timens_show_offsets(struct task_struct *p, struct seq_file *m)
-- 
2.24.1


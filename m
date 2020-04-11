Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D30C01A4E68
	for <lists+linux-api@lfdr.de>; Sat, 11 Apr 2020 08:52:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725867AbgDKGwZ (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sat, 11 Apr 2020 02:52:25 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:53705 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725866AbgDKGwZ (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sat, 11 Apr 2020 02:52:25 -0400
Received: by mail-pj1-f67.google.com with SMTP id cl8so399368pjb.3;
        Fri, 10 Apr 2020 23:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=QxI9j3NlnSjbuxkMs8tAcOtL4DLxmX3HBpKck2zblr4=;
        b=GQgxVNJU6SPCAKtxmwiXz/7EnXDV9vTJPI86ojacjQw2zc3C1+Ou/142DjbWEmexz7
         XNa9/OzmGExTmqq4mjUFSYCkobbHxK7BhK6FvmjIfTbI5R7cWvuvQ+l44O5R2Ae6paNY
         lzJ/toaFB0VOVPF3wGjosunl5T2dbzfTyrsZ7DoRFGLk6RYG9/hYNKNxrzYRLNw8NfCh
         nGQtqMab7XALnIfjbR9WVh0pCBMUWAMT3J2Q0/Q6nVrT1cPm2i3nZNtUSNVu6vPqxNya
         7iI0V2pSouNy4MexnfKnPgEloPuy34N+jUHm5AsRjZ33Kwpdn2AoglJ2KEMAU9jPC6us
         lcZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=QxI9j3NlnSjbuxkMs8tAcOtL4DLxmX3HBpKck2zblr4=;
        b=SzcXOgMYhI44ghN9K+QaPwjldJ5EU6rQYBOg0Jxy/HZZgzKK1WyCpREuVtEat1g7PE
         YN7H51vVKlbl/Xa5dZPQoc/Awj1xl6bA6uYx0KmBaIByzeJFKZzVA292t2XWmfx5z5f5
         D/AQxNh5thPAqkBD9aOV41nEXC8sos8eqqmGB362H+QbUiNvYA15iHze0Z81h2mZ0eVw
         JxqxECE1xHkvdRM1kKhVj37I/9zrRGDQf2qUfKJlkL02O8BDzrODXqoCuhldKY6F07NG
         VQcO5GZK49nd5wqRxIlWz/RLQWQPyP8mhhoMNmhJG86+C+vHEgiAAXvSKFC6zOTYdLoU
         r/uA==
X-Gm-Message-State: AGi0PuagpVnM8o3lo2/ZlPYQt4iEwbwKZpURy4YSy8Ns+V1BPy0KB4TR
        EaDIa6YRyc/XOXtfwH5u7MU=
X-Google-Smtp-Source: APiQypIabp1UQIS0H8H5xI1rpzyubD1aJhnP9zYNFcR4w404tVswHRWxL8voW68n8/Ut/pjVV+vhfA==
X-Received: by 2002:a17:902:694a:: with SMTP id k10mr8290192plt.82.1586587944369;
        Fri, 10 Apr 2020 23:52:24 -0700 (PDT)
Received: from laptop.hsd1.wa.comcast.net ([2601:600:817f:a132:df3e:521d:99d5:710d])
        by smtp.gmail.com with ESMTPSA id i8sm3500978pfr.138.2020.04.10.23.52.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2020 23:52:23 -0700 (PDT)
From:   Andrei Vagin <avagin@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrei Vagin <avagin@gmail.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>
Subject: [PATCH] timens: show clock symbolic names in /proc/pid/timens_offsets
Date:   Fri, 10 Apr 2020 23:52:09 -0700
Message-Id: <20200411065209.622679-1-avagin@gmail.com>
X-Mailer: git-send-email 2.17.2
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Michael Kerrisk suggested to replace numeric clock IDs on symbolic
names.

Now the content of these files looks like this:
$ cat /proc/5362/timens_offsets
monotonic	   9504000	         0
boottime	   3456000	         0

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
Cc: Michael Kerrisk <mtk.manpages@gmail.com>
Cc: Dmitry Safonov <0x7f454c46@gmail.com>
Suggested-by: Michael Kerrisk <mtk.manpages@gmail.com>
Signed-off-by: Andrei Vagin <avagin@gmail.com>
---
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
index e6ba064ce773..8127d2647064 100644
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
+	seq_printf(m, "%s\t%10lld\t%10ld\n", clock, ts->tv_sec, ts->tv_nsec);
 }
 
 void proc_timens_show_offsets(struct task_struct *p, struct seq_file *m)
-- 
2.24.1


Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 314D415E954
	for <lists+linux-api@lfdr.de>; Fri, 14 Feb 2020 18:07:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403948AbgBNRGX (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 14 Feb 2020 12:06:23 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:43286 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394502AbgBNRGW (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 14 Feb 2020 12:06:22 -0500
Received: by mail-pl1-f195.google.com with SMTP id p11so3938114plq.10;
        Fri, 14 Feb 2020 09:06:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gRy5L/NnyJoS2OmlDqUm+MfIJpvKwHXn+HXMaRFsP54=;
        b=a3RgWYknp3aBE8KobRcbN/rCDxpNx9DBj5n7uvvVHS2JEIrakFpt7XwPXPmxZzG3l6
         +wuaX5L6PqE1/IqPrTWiEMrTiUydOnsonFMYRhixjJyhg/DNlrNh1F9KetYktv0wevo9
         A3/rVuwX1FxopwKr7ShZ3xoBw/ZoX3HQwpvBjuR2zBSX6fh4hXXCkSDZvoq+Xgv4wPyH
         jMfRW2dIg+uPxb1dxWa12TvwNbgnvfh5AQhdGLQWXxhBWYBg5cNoOmeizIPe6ucXYZYG
         LRupuxhsdoMeF9i/JkdpqJXoYZzzb5HmAIg0fWbRVIhQA1kNYwaQ4xZmr/khBwvy+InK
         GMYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=gRy5L/NnyJoS2OmlDqUm+MfIJpvKwHXn+HXMaRFsP54=;
        b=QSkyIET1HhjLQOIeVGM7f7n/ctMOF1lbwoiLsHOPNk3FXn66Ei/mKvU88BFZrZW/rx
         ZKohrf1SrINdqP4o9ND6T75KFprnnyZLZLQilBlSraJKuGl9XcswvVPGbRQ13EQQkl/2
         e759tdHZKOqgewwDyGhGZAxO3DmSm/m5m+RpWUWyg70Ne58aB/AHsQoB6rovVl31CmkQ
         UtS7+OtcnUvXg0S/riwZJOfr2jtHptED36HNySAvrDZMXzM3VDVPwfOl3Me9FTrpFaAU
         nLgu4b7ZG9MVdlXyW2a0bfyHsRg3jRBZX5h8kC4O7/Htq2OOr9KrwFXa7sE+Fgyf27Tu
         TJrQ==
X-Gm-Message-State: APjAAAULtjokXqnh9fKnzLRld/t+PI2PeLPmoCAMllCxOk4Qm/2JiPnU
        2OS8YhoOKYvbfkk7p2R+G98=
X-Google-Smtp-Source: APXvYqxkQjUfp4sJ7OTXS5M1xqiEpED7kh+kjiS+rgHdddd36PL3o1LAU+jD/WiYx/YX1/Cx4dhMoA==
X-Received: by 2002:a17:902:b215:: with SMTP id t21mr4293214plr.190.1581699981877;
        Fri, 14 Feb 2020 09:06:21 -0800 (PST)
Received: from bbox-1.mtv.corp.google.com ([2620:15c:211:1:3e01:2939:5992:52da])
        by smtp.gmail.com with ESMTPSA id a13sm7662924pfg.65.2020.02.14.09.06.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2020 09:06:19 -0800 (PST)
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
        Christian Brauner <christian@brauner.io>
Subject: [PATCH v5 4/7] pid: export pidfd_get_pid
Date:   Fri, 14 Feb 2020 09:05:17 -0800
Message-Id: <20200214170520.160271-5-minchan@kernel.org>
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
In-Reply-To: <20200214170520.160271-1-minchan@kernel.org>
References: <20200214170520.160271-1-minchan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

process_madvise syscall needs pidfd_get_pid function to translate
pidfd to pid so this patch exports the function.

Cc: Christian Brauner <christian@brauner.io>
Suggested-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
Reviewed-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
Signed-off-by: Minchan Kim <minchan@kernel.org>
---
 include/linux/pid.h |  1 +
 kernel/exit.c       | 17 -----------------
 kernel/pid.c        | 17 +++++++++++++++++
 3 files changed, 18 insertions(+), 17 deletions(-)

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
diff --git a/kernel/exit.c b/kernel/exit.c
index 0b81b26a872a..43375f9d8bbc 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -1470,23 +1470,6 @@ static long do_wait(struct wait_opts *wo)
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
index 0f4ecb57214c..360ba480a2a9 100644
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
-- 
2.25.0.265.gbab2e86ba0-goog


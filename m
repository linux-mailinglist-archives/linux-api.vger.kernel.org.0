Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A9A715B4EA
	for <lists+linux-api@lfdr.de>; Thu, 13 Feb 2020 00:40:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729400AbgBLXkJ (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 12 Feb 2020 18:40:09 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:45985 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729385AbgBLXkH (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 12 Feb 2020 18:40:07 -0500
Received: by mail-pl1-f194.google.com with SMTP id b22so1542130pls.12;
        Wed, 12 Feb 2020 15:40:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WYzOGpKVdAHMy+iPLX1CcTtO6CKLdGBLsdfZj/dlK3Y=;
        b=f9JXNeGAff+DANp8AqHpgqhG0pAWgaP0mE4TLt1CG3ZDpPOXz2JYJGRXmrWlobmcnF
         Mrn5rstIOGszz+lI+JIIh+klaU6x0ERcKL0TYzj3lkFXWflMZX+fm2G6xnm14WCb9R1k
         RFZ05uPkwQjJQrRPEpYl/Vs5739i9oE7+XvsTNP9+z4WXqjrTc4cxnCfTNZDoEQ3ZIIT
         i9zUyW6xeMUWB2J2LhMKpFjmHPwhiRHTjbuZ3Peh1psbX1k9N3+WNeb1yNfuanPaaUNg
         awpJNeuvthozvWL97pCmIOtTM+W4LvhEoSBsu+kqIX6bRIzmE8GOwPGjOlnA9H0q+9iv
         IWyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=WYzOGpKVdAHMy+iPLX1CcTtO6CKLdGBLsdfZj/dlK3Y=;
        b=do+Ezg6csRUKh1eCfVSH7FXzNQWXYCuZVO0F2Pa3Vl+gSu8hbC3kGdFgHQam84Okl7
         mks6/K5ZD/07tRaS7vcaWSZKxVbLoGPjH3J2Wrbka0hXWtakuzpgQT20oHVb+4GYQu+6
         SLN+pAXC+20TX01LC4OZDclKq4VEFpW5c/p8te2doEFwD52/uYkP8ltb/oJQtsjeTYKV
         +Z+lLd6WVIli4I/N9ZE/ST8Pd9QuGGwu2Q7uNyyjusRAp7nzLPHXQ7D4JkInuIYpqdry
         ji4xmrh4N1mEwmzRaDR4jyD2gsgei74qgcTiBQbnG4YrbC754V5+b3rSlPGd6371NKtX
         J+/w==
X-Gm-Message-State: APjAAAU0KmDhGgLoLcZSiqtn/4XKUKKDP9XNcxgoczaJg3YcZCbr8GmF
        5aPUCzIZB2MgyRObG6IDzcY=
X-Google-Smtp-Source: APXvYqxzdMSgjet/sJg2AzFVv1VfQOV4vJS4AINZURSRk4raXqtjTGX7apkA6Ratnn2Z2ah6CRpUnw==
X-Received: by 2002:a17:902:302:: with SMTP id 2mr26208596pld.58.1581550805243;
        Wed, 12 Feb 2020 15:40:05 -0800 (PST)
Received: from bbox-1.mtv.corp.google.com ([2620:15c:211:1:3e01:2939:5992:52da])
        by smtp.gmail.com with ESMTPSA id k5sm296664pju.29.2020.02.12.15.40.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2020 15:40:04 -0800 (PST)
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
        Minchan Kim <minchan@kernel.org>,
        Christian Brauner <christian@brauner.io>
Subject: [PATCH v4 7/8] pid: export pidfd_get_pid
Date:   Wed, 12 Feb 2020 15:39:45 -0800
Message-Id: <20200212233946.246210-8-minchan@kernel.org>
X-Mailer: git-send-email 2.25.0.225.g125e21ebc7-goog
In-Reply-To: <20200212233946.246210-1-minchan@kernel.org>
References: <20200212233946.246210-1-minchan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

process_madvise syscall needs pidfd_get_pid function to translate
pidfd to pid so this patch exports the function.

Cc: Christian Brauner <christian@brauner.io>
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
2.25.0.225.g125e21ebc7-goog


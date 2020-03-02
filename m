Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3AB1217641C
	for <lists+linux-api@lfdr.de>; Mon,  2 Mar 2020 20:38:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727753AbgCBTgv (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 2 Mar 2020 14:36:51 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44816 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727729AbgCBTgt (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 2 Mar 2020 14:36:49 -0500
Received: by mail-pg1-f195.google.com with SMTP id a14so297154pgb.11;
        Mon, 02 Mar 2020 11:36:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CAuMT51bd2tPZq5AmNznMJxSdkpdINt7X9+EcbWTH9c=;
        b=Qngfc7kD/lQSumCWFxpAqPzefGO/9bxaitrChg4vLFdSK1L1Q7wGmkyyv1AjrjzI7m
         AOaWowDalt1ETXKpq2oK2AZtCOt/lTlNicrt04FuObfW734BiJoSfgLB+MwH3k0LTPXV
         fth+eqkYXRt1R6Ar4Y/dyeA/5jw0oiYHDxqDiu1aLgkVNZfussho1t563flM2VPHZklK
         hxx3betvqjiki7SXAUyx5SbIqyAjvKvnx9McT/oaJeXtT8FJPrPzR9uJFJAqWYuR5s4m
         zhrBXYTDOFPkR0tTqnc4zWIgM9LKY/G44kvXhi4vTKFYQEoPiSp9i9vISnIXGZWFcsoa
         Kf6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=CAuMT51bd2tPZq5AmNznMJxSdkpdINt7X9+EcbWTH9c=;
        b=GWUHkHPk9r9N0Cbzx5LPqDozjuOQEhseMpgW6s8mAA8jXr7Vn6ZIOymAcTD+6NUZQT
         YpmxYOcQk1U7dzp2eeJDzvf2CTDQnr3l94BhWz+OheUql2UmA+a5sudMxoNcmmI5Zk/1
         eymk7SqOShgltb04c6pxMlrxM4+5qtu4NUvCOj2dYQDT9UgW3Eb5IvTybPPz5Uhk7zxh
         T7BQBuIA0dCuGUuYQQfXgfeylZM5SpHmu35l7eARPcVAx11sdTiy7Ifq+bsf/bHA5hbt
         wVQvFrL7hYt47ZQ/GCmlDWRWnvJICHKszY7dMMBYjemt0DypNq6yd2xF4y2tj5qiI2bu
         nVvg==
X-Gm-Message-State: ANhLgQ1Qk3At0jwNMoLEjlVska1f3njTStB7OZpnQy9KIXCM3+lLDr17
        NGo0UkXTfMdD2b6xCzqAY8M=
X-Google-Smtp-Source: ADFU+vtNTGw0O0BZ3Z3bAo+W/YdJ+VqxqzAEvQMOOjmVfJ07p6EQ0TGFmHTrPNVwtIVNv7ajfyHprA==
X-Received: by 2002:a62:ce48:: with SMTP id y69mr578428pfg.8.1583177808587;
        Mon, 02 Mar 2020 11:36:48 -0800 (PST)
Received: from bbox-1.mtv.corp.google.com ([2620:15c:211:1:3e01:2939:5992:52da])
        by smtp.gmail.com with ESMTPSA id hg6sm35441pjb.22.2020.03.02.11.36.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2020 11:36:47 -0800 (PST)
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
        Christoph Hellwig <hch@infradead.org>,
        Christian Brauner <christian@brauner.io>
Subject: [PATCH v7 4/7] pid: move pidfd_get_pid function to pid.c
Date:   Mon,  2 Mar 2020 11:36:27 -0800
Message-Id: <20200302193630.68771-5-minchan@kernel.org>
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
In-Reply-To: <20200302193630.68771-1-minchan@kernel.org>
References: <20200302193630.68771-1-minchan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

process_madvise syscall needs pidfd_get_pid function to translate
pidfd to pid so this patch move the function to kernel/pid.c.

Cc: Christoph Hellwig <hch@infradead.org>
Cc: Christian Brauner <christian@brauner.io>
Reviewed-by: Suren Baghdasaryan <surenb@google.com>
Suggested-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
Reviewed-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
Signed-off-by: Minchan Kim <minchan@kernel.org>
---
 include/linux/pid.h |  1 +
 kernel/exit.c       | 17 -----------------
 kernel/pid.c        | 17 +++++++++++++++++
 3 files changed, 18 insertions(+), 17 deletions(-)

diff --git a/include/linux/pid.h b/include/linux/pid.h
index 998ae7d24450..993f68cb45c2 100644
--- a/include/linux/pid.h
+++ b/include/linux/pid.h
@@ -75,6 +75,7 @@ extern const struct file_operations pidfd_fops;
 struct file;
 
 extern struct pid *pidfd_pid(const struct file *file);
+struct pid *pidfd_get_pid(unsigned int fd);
 
 static inline struct pid *get_pid(struct pid *pid)
 {
diff --git a/kernel/exit.c b/kernel/exit.c
index 764960fabfa1..8cad838c26d6 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -1471,23 +1471,6 @@ static long do_wait(struct wait_opts *wo)
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


Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6955D163985
	for <lists+linux-api@lfdr.de>; Wed, 19 Feb 2020 02:44:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727743AbgBSBop (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 18 Feb 2020 20:44:45 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:53990 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728071AbgBSBop (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 18 Feb 2020 20:44:45 -0500
Received: by mail-pj1-f68.google.com with SMTP id n96so1859826pjc.3;
        Tue, 18 Feb 2020 17:44:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zcb6D3u81fCeQ2AWI9laxyN/xHYitLuojX9wxAp2vtU=;
        b=dP4zgAzSfngeY16XyCngdzYL3pA1g5T7uI7IbBGs38Cq9dhKFWbybu8yMh8d3nAD4l
         /smEEZHCE8hdOT1p5Ki7jOPlAOMdxzFeVJpT9MyA6I06e+Qa2TrhbleCy3DxunYXCIB5
         D8GzFREe6yi8L2+5EabIqS4RtkmKjOH3XX5gBw386Q6653dNSqn6QYCGdDD6ky9ct7PC
         hmsAWGl1MPwo1xiXi9NkuxlWWdOk8VEPVGoPVf5vp15fDxY1BhsrwI64d3tyXz0oU8dJ
         15XR2gKbskMrpyjLEm1yKNrut0+p2Rmv43IVU9hL6gPIA/zlWyZ7DJr/gZUvxZP//EY5
         +3qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=zcb6D3u81fCeQ2AWI9laxyN/xHYitLuojX9wxAp2vtU=;
        b=kgT22ekkYYvXWgiwoHilMfU25m5X0NJvdKuse3yzvJIeoHIXA8/TO4UQ3fXX3zkBxM
         MsdNNU5KZGbsGubZZWjDiRDQKHFR/EFqM9C3yh6GFgGVlLhLFJ4zVr+DIuNAbR9KQcB5
         T8GmroqeQp+7AwTq9ShK/4fAV7UMUhY36qm97CiU6NQ6s2CwelKnpmh0P2yo+6u6beRm
         dQJoyK9ekXnukfq7HL91OJkeUkjQ4ZzKnk9YMT21F3YxGGj2vJzTYOnJhMfNp7V68MI2
         7HuKT0Uxa8IEFcrEKe6GJo8kOelcdN7d+sBEHnztRM7oCrUcfJGN+wTTRxiuWNQQCyQD
         emuw==
X-Gm-Message-State: APjAAAXplYKSJ6KqvrxeYge9QYlT3a6/L+DVfZeY3w7TjNifRCO4DCTQ
        g1+KrEBYNQodi3P2A5XGFiM=
X-Google-Smtp-Source: APXvYqwB1UZyTj2FO+7mAGa5Fn4Vvj4rqp0gh1on14j7stLGrsDNA8wBC6nZZTSkwSGyGrI+AfiauQ==
X-Received: by 2002:a17:902:740c:: with SMTP id g12mr24779284pll.166.1582076684396;
        Tue, 18 Feb 2020 17:44:44 -0800 (PST)
Received: from bbox-1.mtv.corp.google.com ([2620:15c:211:1:3e01:2939:5992:52da])
        by smtp.gmail.com with ESMTPSA id t186sm221192pgd.26.2020.02.18.17.44.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2020 17:44:43 -0800 (PST)
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
        Christoph Hellwig <hch@infradead.org>,
        Christian Brauner <christian@brauner.io>
Subject: [PATCH v6 4/7] pid: move pidfd_get_pid function to pid.c
Date:   Tue, 18 Feb 2020 17:44:30 -0800
Message-Id: <20200219014433.88424-5-minchan@kernel.org>
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
In-Reply-To: <20200219014433.88424-1-minchan@kernel.org>
References: <20200219014433.88424-1-minchan@kernel.org>
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


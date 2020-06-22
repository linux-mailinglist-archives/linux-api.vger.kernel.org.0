Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4953204057
	for <lists+linux-api@lfdr.de>; Mon, 22 Jun 2020 21:29:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728548AbgFVT3T (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 22 Jun 2020 15:29:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728435AbgFVT3S (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 22 Jun 2020 15:29:18 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AD40C061573;
        Mon, 22 Jun 2020 12:29:18 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id d8so7993178plo.12;
        Mon, 22 Jun 2020 12:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yZx/xJiu3yLYxBeu4W9X7ae9mJRIdzivgJHXdOhNnmc=;
        b=d0aupIxhn/FLHpBpdH0gcA+xKWtWIytAq0I1cOCDzgpj3aVoyfPoYMOonaPxhXLiwD
         yZ28ZuPwULQfqiNeE4/HS1JThab4ZmnHX8xrKEJy1f6P3yrKoyv5IfDyeVcgAvgJzTCV
         Zs/UF0zlwmfCGyR5P9laCu5HxXQ89Uba9YUqbYyknlQJ99NeCtpftlCb8CG3kjYYNmAl
         ooxlZ74ngTTpC95X+P7TvBWHQybJdQstLjFRMeQ4vrBy8Y+DV4J5I/sWQqwnoMLtYkg4
         cAF7k5tPc5drdC3gE7FPbKTvq9iQiaiLhRtqoCIALzDCIAJ8YPyEswzeQEgqqEfyg69W
         RLhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=yZx/xJiu3yLYxBeu4W9X7ae9mJRIdzivgJHXdOhNnmc=;
        b=luurvQftUqxLRFV6JDkDvEysCxnuhg6eK6bYbEBA2A9AZGdjWcwnUJuDxPSaKdNjbP
         PTWLrt31MZo4bCigbWGY2fjZZEv9gY2kc1TL18kHT7sUh+FTCo/n1MDwn5UmwsJk9PFp
         tfIVDo9Qahia36zsBBJK7832wmMQsSQZptNUlAKFCikKEauPI8Ruvap/2pnwqcA0QMGd
         TLMvLG4l0MnpzFtVnBkn7sa/cnt+m9I3ahZ6SiUmPAfo5hpfqnVogGEjGiwxAruKuaw8
         cY8bYZJN+nHeYDyn16O4EJ1bq8z0rlKFADndyxVtLhFmzkEfqKL3mj3bhD3yipiKjZYW
         6BqQ==
X-Gm-Message-State: AOAM530xdSp0JHvfY4pbN2Hdl43EWgPhIpIqAImP2FvrKsfD6VDWkLT1
        TStrBYeQksEuKVd/EnKzRY8=
X-Google-Smtp-Source: ABdhPJwHJM4Ndj1kL9SxsYssjyeNpOvrkStklgev1hE+d9lOsEaIWOk0EsCCmknPMMW3ePgOf2akJg==
X-Received: by 2002:a17:90a:cf17:: with SMTP id h23mr20123616pju.139.1592854157967;
        Mon, 22 Jun 2020 12:29:17 -0700 (PDT)
Received: from bbox-1.mtv.corp.google.com ([2620:15c:211:1:3e01:2939:5992:52da])
        by smtp.gmail.com with ESMTPSA id mu17sm264603pjb.53.2020.06.22.12.29.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 12:29:16 -0700 (PDT)
From:   Minchan Kim <minchan@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        linux-mm <linux-mm@kvack.org>, linux-api@vger.kernel.org,
        oleksandr@redhat.com, Suren Baghdasaryan <surenb@google.com>,
        Tim Murray <timmurray@google.com>,
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
        David Rientjes <rientjes@google.com>,
        Arjun Roy <arjunroy@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>, Jens Axboe <axboe@kernel.dk>,
        Daniel Colascione <dancol@google.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        SeongJae Park <sjpark@amazon.de>, linux-man@vger.kernel.org
Subject: [PATCH v8 2/4] pid: move pidfd_get_pid() to pid.c
Date:   Mon, 22 Jun 2020 12:28:58 -0700
Message-Id: <20200622192900.22757-3-minchan@kernel.org>
X-Mailer: git-send-email 2.27.0.111.gc72c7da667-goog
In-Reply-To: <20200622192900.22757-1-minchan@kernel.org>
References: <20200622192900.22757-1-minchan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

process_madvise syscall needs pidfd_get_pid function to translate pidfd to
pid so this patch move the function to kernel/pid.c.

Link: http://lkml.kernel.org/r/20200302193630.68771-5-minchan@kernel.org
Signed-off-by: Minchan Kim <minchan@kernel.org>
Reviewed-by: Suren Baghdasaryan <surenb@google.com>
Suggested-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
Reviewed-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Jann Horn <jannh@google.com>
Cc: Brian Geffon <bgeffon@google.com>
Cc: Daniel Colascione <dancol@google.com>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: John Dias <joaodias@google.com>
Cc: Kirill Tkhai <ktkhai@virtuozzo.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Oleksandr Natalenko <oleksandr@redhat.com>
Cc: Sandeep Patil <sspatil@google.com>
Cc: SeongJae Park <sj38.park@gmail.com>
Cc: SeongJae Park <sjpark@amazon.de>
Cc: Shakeel Butt <shakeelb@google.com>
Cc: Sonny Rao <sonnyrao@google.com>
Cc: Tim Murray <timmurray@google.com>
Cc: Christian Brauner <christian.brauner@ubuntu.com>
Cc: <linux-man@vger.kernel.org>
---
 include/linux/pid.h |  1 +
 kernel/exit.c       | 17 -----------------
 kernel/pid.c        | 17 +++++++++++++++++
 3 files changed, 18 insertions(+), 17 deletions(-)

diff --git a/include/linux/pid.h b/include/linux/pid.h
index 176d6cf80e7c..86e0e7cb7872 100644
--- a/include/linux/pid.h
+++ b/include/linux/pid.h
@@ -77,6 +77,7 @@ extern const struct file_operations pidfd_fops;
 struct file;
 
 extern struct pid *pidfd_pid(const struct file *file);
+struct pid *pidfd_get_pid(unsigned int fd);
 
 static inline struct pid *get_pid(struct pid *pid)
 {
diff --git a/kernel/exit.c b/kernel/exit.c
index 00d77e5ba700..8acb702e8241 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -1475,23 +1475,6 @@ static long do_wait(struct wait_opts *wo)
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
index f1496b757162..3122043fe364 100644
--- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -518,6 +518,23 @@ struct pid *find_ge_pid(int nr, struct pid_namespace *ns)
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
2.27.0.111.gc72c7da667-goog


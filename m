Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C4A32584A5
	for <lists+linux-api@lfdr.de>; Tue,  1 Sep 2020 02:08:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726292AbgIAAHz (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 31 Aug 2020 20:07:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726131AbgIAAHx (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 31 Aug 2020 20:07:53 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BB86C061575;
        Mon, 31 Aug 2020 17:07:52 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id y6so4047578plt.3;
        Mon, 31 Aug 2020 17:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DLrWB5wvlVoAHy2euEKq1/3sc+u67i1HMsT7/g7abhI=;
        b=e7ZLBG31SV7c0gtn6AOaBNrUKcsq5hL42yheyfoeAR9hyarTJ+VUPrehun41ljsLg9
         4Tpl4o5uuXxH8bEqTgjS3qV4+7MlVUbhR3YDQojiszl5v5/0FB3KuFWnc5ut6mQ1zmBr
         TllJQEmbFX4u29FNsBl+OnFi8+6ToXEhYp+GolAG7n773KJi5O7g97DUg5/OWebgpRtN
         1wXxR/kmTGNhdLgCupP9oN9a/0aetpbM0z6rKChNJhIzfrGuR/oJcnwhnCrBOG2fotVo
         O2qziM/71jC+T7i2rp5oKekaFUecZGj6lfYIUnfOApdsLiCk1Sw2yXfdfwQ5/krt5FkM
         Z4pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=DLrWB5wvlVoAHy2euEKq1/3sc+u67i1HMsT7/g7abhI=;
        b=guTXJPENiV2/NhAb25rO5yphC+SvVVaIOQEkFc3GG02BRd4t0etUAtqv4fWLKITvvG
         JACncc34w+GAyA1yNKkEyuirm6sGwCx4BkI2IhTJ9DfQUMa4QDi2Dfr8CEtn2hFp/54p
         VVmLf64q2L8kNDdo5Vc0izt775zWnyr4T1YsgjuYeL0clTB6mRE3nNVbWx6bOM4ZMWO4
         Ru35lDZ1UC2J+w749K45h6aIypcJwNL12B6BysiU5wXoRkzpeE9KTI5Ks+SyY9KsSNhU
         dJ+dVztfTnR+zaJlkWr3e6amfvpK+TiMXBNBbRHeoJLDg4Sl7+CQcnstxzeow4+xlr6R
         VuKQ==
X-Gm-Message-State: AOAM533ilCOxghQXYrXSlzhLdRfjBoUanPstaI3SrNU2IsR09YLUKRjQ
        2D/dZc70iOEGvzHUONI9gGY=
X-Google-Smtp-Source: ABdhPJw2+WxtE41OsXoPEhJhRlvcrNZ9QSecDn4o5oJjldeazK7KiDpmQOeo4Dv4MTpUiQRZkG7bLA==
X-Received: by 2002:a17:90a:5a48:: with SMTP id m8mr1659813pji.181.1598918872055;
        Mon, 31 Aug 2020 17:07:52 -0700 (PDT)
Received: from bbox-1.mtv.corp.google.com ([2620:15c:211:1:7220:84ff:fe09:5e58])
        by smtp.gmail.com with ESMTPSA id k5sm769777pjq.5.2020.08.31.17.07.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2020 17:07:50 -0700 (PDT)
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
        Linus Torvalds <torvalds@linux-foundation.org>,
        Minchan Kim <minchan@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>, Jens Axboe <axboe@kernel.dk>,
        Daniel Colascione <dancol@google.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        SeongJae Park <sjpark@amazon.de>, linux-man@vger.kernel.org
Subject: [PATCH v9 2/3] pid: move pidfd_get_pid() to pid.c
Date:   Mon, 31 Aug 2020 17:06:32 -0700
Message-Id: <20200901000633.1920247-3-minchan@kernel.org>
X-Mailer: git-send-email 2.28.0.402.g5ffc5be6b7-goog
In-Reply-To: <20200901000633.1920247-1-minchan@kernel.org>
References: <20200901000633.1920247-1-minchan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

process_madvise syscall needs pidfd_get_pid function to translate pidfd to
pid so this patch move the function to kernel/pid.c.

Link: http://lkml.kernel.org/r/20200302193630.68771-5-minchan@kernel.org
Link: http://lkml.kernel.org/r/20200622192900.22757-3-minchan@kernel.org
Reviewed-by: Suren Baghdasaryan <surenb@google.com>
Suggested-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
Reviewed-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Acked-by: David Rientjes <rientjes@google.com>
Signed-off-by: Minchan Kim <minchan@kernel.org>
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
index 733e80f334e7..62912406d74a 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -1474,23 +1474,6 @@ static long do_wait(struct wait_opts *wo)
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
index 2b97bedc1d9f..54e153ec6b74 100644
--- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -519,6 +519,23 @@ struct pid *find_ge_pid(int nr, struct pid_namespace *ns)
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
2.28.0.402.g5ffc5be6b7-goog


Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14DE415E95A
	for <lists+linux-api@lfdr.de>; Fri, 14 Feb 2020 18:07:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394505AbgBNRGf (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 14 Feb 2020 12:06:35 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:33405 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394142AbgBNRGd (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 14 Feb 2020 12:06:33 -0500
Received: by mail-pl1-f193.google.com with SMTP id ay11so3962464plb.0;
        Fri, 14 Feb 2020 09:06:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=V7GUkh8wE1dRQiutiAZwQygV0oqWtMLGFWC+ZDS/JnU=;
        b=RQvOq32m45tdZVuQ4eP1UET1YZUzdiMgqS7sSPeokFVt7jEldPUoBqPTKGstnRngbF
         75+1ncGimpxQlYmLre/iK7NDvLq5nH9Hi2GOxUwGhbRCZJZt2puGtJKk1yDtaNxdvTOa
         H/HYX/Zmw9vTr3fPSoY7uBY66RtNlMV/AMAWXeRe+em474RVFHaMWlLU35ynOr5o0Aln
         3w27QgjvOu2G2AsRfDdNSepSUB0fIO/aFIzpGmYcuoM5LFW+01oXGF0iKP2e7kzay49e
         Mv30kROuXKTJkKiBAtSpcvfYw77pEgG193ErM30jobYpwJHikPO41vYt6EZFzgMttboN
         PzsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=V7GUkh8wE1dRQiutiAZwQygV0oqWtMLGFWC+ZDS/JnU=;
        b=ZSmsquOoGvWnzQGKYysxZcpEsUnO/fK6GzLXlgAKioyWgq3pQuqCpH8jJp4e2Ag4rC
         /fu3soyR1pA3vUIUxCzcNMSAW52Q9tAUdjd99lZ9pgeg/eAE6EI1cXTHddD5ncahXB02
         FGLK6il+3yoW5OCrCZsnpisARiPxAvwUovJGil3XkgSi9+7/CYJ2lysC6nE3HHdujx+r
         8kZXVK5rH9lAS3jvsFt/nXo9l9oWlW170Z8F6ztF5+ZAI6yZTTnbdrO4hcMf4hELkof4
         yaKPHTsayET7lSdmtjotm+yFN8bRFLdTQq1T+7Qr1ELQjNd5PFM2JVrXcnIAUyGqCSMS
         ItKQ==
X-Gm-Message-State: APjAAAXKHRhZJbD695PZ17sXiObCZIFkddj+Feu1dMts3/y8V+2VYJq9
        2HJHt9edm0Atc1p018uVwOU=
X-Google-Smtp-Source: APXvYqxGn47fJ2zoDaJU+qvDPEHLfhiapXpwP4YiNrmS4xOrwHPdDO5MUL/VY69qyCv30aJDRferSg==
X-Received: by 2002:a17:90b:46cf:: with SMTP id jx15mr4967429pjb.2.1581699993075;
        Fri, 14 Feb 2020 09:06:33 -0800 (PST)
Received: from bbox-1.mtv.corp.google.com ([2620:15c:211:1:3e01:2939:5992:52da])
        by smtp.gmail.com with ESMTPSA id a13sm7662924pfg.65.2020.02.14.09.06.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2020 09:06:30 -0800 (PST)
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
        Minchan Kim <minchan@kernel.org>
Subject: [PATCH v5 6/7] mm/madvise: employ mmget_still_valid for write lock
Date:   Fri, 14 Feb 2020 09:05:19 -0800
Message-Id: <20200214170520.160271-7-minchan@kernel.org>
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
In-Reply-To: <20200214170520.160271-1-minchan@kernel.org>
References: <20200214170520.160271-1-minchan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

From: Oleksandr Natalenko <oleksandr@redhat.com>

Do the very same trick as we already do since 04f5866e41fb. KSM hints
will require locking mmap_sem for write since they modify vm_flags, so
for remote KSM hinting this additional check is needed.

Signed-off-by: Oleksandr Natalenko <oleksandr@redhat.com>
Signed-off-by: Minchan Kim <minchan@kernel.org>
---
 mm/madvise.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/madvise.c b/mm/madvise.c
index bbbfea93396a..762a68205e65 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -1117,6 +1117,8 @@ int do_madvise(struct task_struct *task, struct mm_struct *mm,
 	if (write) {
 		if (down_write_killable(&mm->mmap_sem))
 			return -EINTR;
+		if (current->mm != mm && !mmget_still_valid(mm))
+			goto skip_mm;
 	} else {
 		down_read(&mm->mmap_sem);
 	}
@@ -1167,6 +1169,7 @@ int do_madvise(struct task_struct *task, struct mm_struct *mm,
 	}
 out:
 	blk_finish_plug(&plug);
+skip_mm:
 	if (write)
 		up_write(&mm->mmap_sem);
 	else
-- 
2.25.0.265.gbab2e86ba0-goog


Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3878B15B4F1
	for <lists+linux-api@lfdr.de>; Thu, 13 Feb 2020 00:40:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729363AbgBLXkE (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 12 Feb 2020 18:40:04 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43535 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729356AbgBLXkC (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 12 Feb 2020 18:40:02 -0500
Received: by mail-pf1-f193.google.com with SMTP id s1so2007421pfh.10;
        Wed, 12 Feb 2020 15:40:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZMr8LhEVC9oO5IOdT1EAti6B5+7g8NKkMYB8pLjiUts=;
        b=FZrxKnddlcDw5zyfExhzpFB7yNfAtSGotiVUgDx7kQeEtRk96KD2mjuJAwspjEWZEN
         8KQGuw5rgbMTjblF/1hERi1coEcedKQRj0A3ZDpTh/rLPLJ01OSf3UbmgfW6utovZI3H
         qKbek4ZUVtEesWnc8Jz1oh3eReFVrokHuT8LrXYSlGbQs0tKXLnC7cKdOT9I8H90mNP/
         6LeqDCmJSqRfYdC0SBilvY0LlpVtSqLG7Oof/zDRge1nTZaZh3bSa2QLWuT7PpN2E/V8
         MufG1jDdEtKBDxSNXo3mv7bob5OGe9IF3J0ofzL96vWBtLLs9Lykq6WoQHJCnrmHn7sj
         g+/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=ZMr8LhEVC9oO5IOdT1EAti6B5+7g8NKkMYB8pLjiUts=;
        b=P3y+bgE0nFKK9IKIISHhoWHBaSJ+xqXZmCXROVPjQ9kJgRTQ3laqlIz+nTs8pL3jUL
         5eyD4zP0ClsyBJUTI6em3Usnng1JNLXv/bx6P/Nm8YwR7SIAVd5qO/B0F6wgt9yGuJRF
         OyPBJMA2/XaeEt/ucGLJ3gsFcP1ilIDb6xD9slyVk187iqHJD+T0V6u7r7bUz7CqS0Hi
         A0se8XJQa4XgjhKJkIvx4mVhJ6Y2gMmAi5fFWkeC7kv3g3jv0Ylx8bELQ+fxeb5J6yWk
         h65L2TD6URaKbk9xDVSsAXzw/uaGpvOgl4y5nQG6HoAuODGjIbk3uArvWNJFh8bd4gvE
         MsWw==
X-Gm-Message-State: APjAAAW7b04lUdboo1PH1kQ37ofbFkFuadwgesCeJoxynW3heIfSFpie
        v1vOBoLhsH0fT4uqxU7TlTVSsh0R
X-Google-Smtp-Source: APXvYqyTYiXBm1zUHh7AFeoGz7OUaVklPnIUFSpjd2o7FpUwNPngIaBgYKUhERpn7MoMtdc1mZ47HA==
X-Received: by 2002:a65:645a:: with SMTP id s26mr10828696pgv.135.1581550801457;
        Wed, 12 Feb 2020 15:40:01 -0800 (PST)
Received: from bbox-1.mtv.corp.google.com ([2620:15c:211:1:3e01:2939:5992:52da])
        by smtp.gmail.com with ESMTPSA id k5sm296664pju.29.2020.02.12.15.39.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2020 15:40:00 -0800 (PST)
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
        Minchan Kim <minchan@kernel.org>
Subject: [PATCH v4 5/8] mm/madvise: employ mmget_still_valid for write lock
Date:   Wed, 12 Feb 2020 15:39:43 -0800
Message-Id: <20200212233946.246210-6-minchan@kernel.org>
X-Mailer: git-send-email 2.25.0.225.g125e21ebc7-goog
In-Reply-To: <20200212233946.246210-1-minchan@kernel.org>
References: <20200212233946.246210-1-minchan@kernel.org>
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
index 276b9d81c1dd..71f0ba199ae8 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -1120,6 +1120,8 @@ int do_madvise(struct task_struct *task, unsigned long start,
 	if (write) {
 		if (down_write_killable(&mm->mmap_sem))
 			return -EINTR;
+		if (current->mm != mm && !mmget_still_valid(mm))
+			goto skip_mm;
 	} else {
 		down_read(&mm->mmap_sem);
 	}
@@ -1170,6 +1172,7 @@ int do_madvise(struct task_struct *task, unsigned long start,
 	}
 out:
 	blk_finish_plug(&plug);
+skip_mm:
 	if (write)
 		up_write(&mm->mmap_sem);
 	else
-- 
2.25.0.225.g125e21ebc7-goog


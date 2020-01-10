Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08EE913788A
	for <lists+linux-api@lfdr.de>; Fri, 10 Jan 2020 22:34:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727249AbgAJVep (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 10 Jan 2020 16:34:45 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35147 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726912AbgAJVeo (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 10 Jan 2020 16:34:44 -0500
Received: by mail-pg1-f196.google.com with SMTP id l24so1589606pgk.2;
        Fri, 10 Jan 2020 13:34:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=89Kh03xU7w1BbnZNyOorUIvmlI1tvq4/L3B5YcvwpqQ=;
        b=CN5DkxBOYcoZgoiH2Jg3EQwKATglnYi/wVLvJpLQHlzdJyFu/8fl8QjLSRY+E089Dv
         UBb1RvbJ7SWnmO8UDEIvtF3nSSLvDitBa+gvxVGttXpwCiS7xqI5oDIBRq/7tzUJLVGa
         bbTykYCi84W6ZUPr9/Otr5aamOfMUSZeM0mKCemPrw0+VLcm/ifCMQVmN54xb4XWUQ3Q
         qgMB+KMUKiYOnyXMzJnOdXcwW6JSms1sYN3mcPyf9Q1p5NQIg8PbUfrddxPob5rSSht2
         WsOgwCVDy/Sv604e3Sl3xT3h+USBKk1WH2Y9+mR76qdS/AYSjae1hGw51oxcFZeYOBAt
         PICw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=89Kh03xU7w1BbnZNyOorUIvmlI1tvq4/L3B5YcvwpqQ=;
        b=eAYUEhN57UCHNXB3iN6W+Ys6mDFOGcyGergm4Hp9oyYiEOfSjhlCzsOA6knBNlCzGu
         Z+exof2peOo94+OMf39o4AsADLO9qqIGkEOHYZFEJ/m+UK64W4t+NWR1J9Z4LHmQgOJq
         SQqWvyNSxa6lNTDsVfx6VRx3bFg4wDStAp195VaMlaHziM9TB/clxC2w1AeS+V/SJnxy
         blTawTOEeUv0NwSET+gTXwYZcnUS2SNnlIirZ59R12c3aw2QtCxpqSguESULpb++hOMK
         vuWlsBagJW5TjpSA9B8A8gBhNnT6P9r84/WJGPv9NqJsXF78X3DrRmr+M9cPBS1Az4Ca
         T4gA==
X-Gm-Message-State: APjAAAWYEK51uxKsF9rmh+1lVH9SdvfvV9oKBhL6NeM3lkdzep6BiF8i
        MqEOd8Upv+nCSHJqbtKDvo8=
X-Google-Smtp-Source: APXvYqz7Q5MwkbpSHvKG6GzBJj5sOFfZsoHRNrjc1+Ap4AxBr5ADxxl2rO10KMu4ykwTZzwAJ7B1cw==
X-Received: by 2002:a63:5920:: with SMTP id n32mr6683623pgb.443.1578692083372;
        Fri, 10 Jan 2020 13:34:43 -0800 (PST)
Received: from bbox-1.mtv.corp.google.com ([2620:15c:211:1:3e01:2939:5992:52da])
        by smtp.gmail.com with ESMTPSA id t137sm3692307pgb.40.2020.01.10.13.34.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2020 13:34:42 -0800 (PST)
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
        Minchan Kim <minchan@kernel.org>
Subject: [PATCH 3/4] mm/madvise: employ mmget_still_valid for write lock
Date:   Fri, 10 Jan 2020 13:34:32 -0800
Message-Id: <20200110213433.94739-4-minchan@kernel.org>
X-Mailer: git-send-email 2.25.0.rc1.283.g88dfdc4193-goog
In-Reply-To: <20200110213433.94739-1-minchan@kernel.org>
References: <20200110213433.94739-1-minchan@kernel.org>
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
index e15dfb4df7bf..eb42b2b7f49b 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -1059,6 +1059,8 @@ static int madvise_common(struct task_struct *task, struct mm_struct *mm,
 	if (write) {
 		if (down_write_killable(&mm->mmap_sem))
 			return -EINTR;
+		if (current->mm != mm && !mmget_still_valid(mm))
+			goto skip_mm;
 	} else {
 		down_read(&mm->mmap_sem);
 	}
@@ -1109,6 +1111,7 @@ static int madvise_common(struct task_struct *task, struct mm_struct *mm,
 	}
 out:
 	blk_finish_plug(&plug);
+skip_mm:
 	if (write)
 		up_write(&mm->mmap_sem);
 	else
-- 
2.25.0.rc1.283.g88dfdc4193-goog


Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0DC52473DC
	for <lists+linux-api@lfdr.de>; Sun, 16 Jun 2019 10:58:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727177AbfFPI6q (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sun, 16 Jun 2019 04:58:46 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38460 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727166AbfFPI6p (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sun, 16 Jun 2019 04:58:45 -0400
Received: by mail-wr1-f66.google.com with SMTP id d18so6689863wrs.5
        for <linux-api@vger.kernel.org>; Sun, 16 Jun 2019 01:58:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BH7q4sQxtlW7GBy0Ndsur0wfVLJQqa1DwxMiAYKl/M8=;
        b=ieYHnS9hDjpcZkl6f48ZuLOhjsEpP1Tg1qQ0gE3cjrr0KUht04KxvACEi0ynu7IkCv
         CF/QyCP6T01gI5dUqmcLtb4/7BaH3/dosH4ICLd/et6KddpWvs1H9iggar78JATnza/P
         71AT5PQypjbFxYDt55x4y8/8q0xKebn6b/H8ff3aENToj/HuT2B4KKRDIYY87QtI6sus
         aOQfB/SQmX12AibA4kZx+pEgH7vOgPWVpL3WKWYf0i+Pbyi1EpL64enW+6f9oy8Fg0v7
         htfNr87XywVqAsIiIgrrpKWiKUEuiIW7S12gAwoWJbyIkDnM63qware3LCVYVrmWdg2m
         hp7g==
X-Gm-Message-State: APjAAAUXGfx35nr+o6e9Fj6jUXPkkoCYDmcbjfjBnIT6WHUJem8wK4tv
        ++zwMO4IVEnkMo7BaAJ1VL2kAg==
X-Google-Smtp-Source: APXvYqz8xNHGO6SpiHfeRXmpPOlMaBmRTs2Z+ZnB2utwNn6Sw4tv3GLfcp5kGY1tE4/gW0/NkQufFQ==
X-Received: by 2002:a5d:5702:: with SMTP id a2mr28113288wrv.89.1560675523661;
        Sun, 16 Jun 2019 01:58:43 -0700 (PDT)
Received: from localhost (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id e7sm6195627wmd.0.2019.06.16.01.58.42
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 16 Jun 2019 01:58:43 -0700 (PDT)
From:   Oleksandr Natalenko <oleksandr@redhat.com>
To:     Minchan Kim <minchan@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-api@vger.kernel.org
Subject: [PATCH NOTFORMERGE 4/5] mm/madvise: employ mmget_still_valid for write lock
Date:   Sun, 16 Jun 2019 10:58:34 +0200
Message-Id: <20190616085835.953-5-oleksandr@redhat.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190616085835.953-1-oleksandr@redhat.com>
References: <20190616085835.953-1-oleksandr@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Do the very same trick as we already do since 04f5866e41fb. KSM hints
will require locking mmap_sem for write since they modify vm_flags, so
for remote KSM hinting this additional check is needed.

Signed-off-by: Oleksandr Natalenko <oleksandr@redhat.com>
---
 mm/madvise.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/madvise.c b/mm/madvise.c
index 9755340da157..84f899b1b6da 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -1049,6 +1049,8 @@ static int madvise_common(struct task_struct *task, struct mm_struct *mm,
 	if (write) {
 		if (down_write_killable(&mm->mmap_sem))
 			return -EINTR;
+		if (current->mm != mm && !mmget_still_valid(mm))
+			goto skip_mm;
 	} else {
 		down_read(&mm->mmap_sem);
 	}
@@ -1099,6 +1101,7 @@ static int madvise_common(struct task_struct *task, struct mm_struct *mm,
 	}
 out:
 	blk_finish_plug(&plug);
+skip_mm:
 	if (write)
 		up_write(&mm->mmap_sem);
 	else
-- 
2.22.0


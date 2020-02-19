Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF4F8163988
	for <lists+linux-api@lfdr.de>; Wed, 19 Feb 2020 02:45:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728025AbgBSBo5 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 18 Feb 2020 20:44:57 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:46273 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728093AbgBSBos (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 18 Feb 2020 20:44:48 -0500
Received: by mail-pl1-f194.google.com with SMTP id y8so8842798pll.13;
        Tue, 18 Feb 2020 17:44:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/6BKpu6I9GWZilmKCDR/xIEf9kb10U/fQ/hS1RFxo/E=;
        b=AeiF/BUIODJ7Elpdb3GXCCzXBoQS9IDbCw9VSMC/jL+pPhcr/hr375CchvyTPhz7Pw
         0UOfnIko0AblDWL/yTdmeiTlRoIfhMWdWFD3hNHRiqveweEiIFdLmzsDjyssGqVlyrTi
         febRwSW0h0+kaMkhfKy6efdR7uMe5zL+d+KmyIKLPs0rgr5VxIwjrVpWWZEPFxsMwZ23
         J/8duxiMxzzsojGZ4V6XQhchtynRJdtbiMasGQl4+ZCJDiom8Qude7YarbGY5V0fKzVt
         AFoKRAVeNBBiW7zrGGHfvJ2A02+p1VpXuF6g0cnYJV37hKbKe7v2cv28gZItVOFqnAa3
         aTPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=/6BKpu6I9GWZilmKCDR/xIEf9kb10U/fQ/hS1RFxo/E=;
        b=X6bBqnh+Vay65Dt7+KWdz9qnZChyqpyeUDcRs7GFRhcmfLQAx2d7p4lEGWnGDNymss
         lv0zIO013ayjHzwaSbKZPtbQeTbclxZGqpOwDVepQp80JTv3/tHNdLx0gw0FdKEou29k
         qqgdy7uAsxaN0p+xjZwFfta+A5huVscI/LkyQqYg3aIivb+0P9xCLTuRRl2GzC05Ww52
         X45s/K0kTz6CX7g0AW8uM0rcKQRxq5AavjKvqvj2AP8Uwsyf57Eq0Kr6zFA5tcyIFBt3
         /JUhCXydd6fmqqSV6NoO/0iq9ubCSEBQVnp9xe88bxcwEmy27Ehix2Dp7Zk5+u7gEr5L
         oW3A==
X-Gm-Message-State: APjAAAXIuviPlr27hGfTalXtCPJlW1GjgkcAdLgGXic2bXtoLmgarRma
        Liee8CgWhDjrefZ6idchxRQ=
X-Google-Smtp-Source: APXvYqwwKle6VVN2am3/CWIym5vOlHdjzCyQZW3QPgCSqnuGkU97ImrWpOZRQFtL2HjvnrD66h8CEw==
X-Received: by 2002:a17:902:8f8e:: with SMTP id z14mr24068362plo.195.1582076688168;
        Tue, 18 Feb 2020 17:44:48 -0800 (PST)
Received: from bbox-1.mtv.corp.google.com ([2620:15c:211:1:3e01:2939:5992:52da])
        by smtp.gmail.com with ESMTPSA id t186sm221192pgd.26.2020.02.18.17.44.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2020 17:44:46 -0800 (PST)
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
Subject: [PATCH v6 6/7] mm/madvise: employ mmget_still_valid for write lock
Date:   Tue, 18 Feb 2020 17:44:32 -0800
Message-Id: <20200219014433.88424-7-minchan@kernel.org>
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
In-Reply-To: <20200219014433.88424-1-minchan@kernel.org>
References: <20200219014433.88424-1-minchan@kernel.org>
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
index f6d9b9e66243..c55a18fe71f9 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -1118,6 +1118,8 @@ int do_madvise(struct task_struct *target_task, struct mm_struct *mm,
 	if (write) {
 		if (down_write_killable(&mm->mmap_sem))
 			return -EINTR;
+		if (current->mm != mm && !mmget_still_valid(mm))
+			goto skip_mm;
 	} else {
 		down_read(&mm->mmap_sem);
 	}
@@ -1169,6 +1171,7 @@ int do_madvise(struct task_struct *target_task, struct mm_struct *mm,
 	}
 out:
 	blk_finish_plug(&plug);
+skip_mm:
 	if (write)
 		up_write(&mm->mmap_sem);
 	else
-- 
2.25.0.265.gbab2e86ba0-goog


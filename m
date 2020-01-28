Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E7D614AD0C
	for <lists+linux-api@lfdr.de>; Tue, 28 Jan 2020 01:17:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727235AbgA1ARC (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 27 Jan 2020 19:17:02 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35516 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727161AbgA1ARC (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 27 Jan 2020 19:17:02 -0500
Received: by mail-pg1-f195.google.com with SMTP id l24so6019706pgk.2;
        Mon, 27 Jan 2020 16:17:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7ENo+LQFzsHhuty3BkKJoKSguVUYkFockJe29Qo4mpc=;
        b=ocy2wX7gUdRsBNsZtjkPnol+rZ0Sop0TW/0noNZIYQe9cywJ4kuUDLVz6W/4bZa1JN
         Vd69qPExlyDn3MiBXaWe+VvVgp0zy3YRP7D4FGETClcNbSREVFMPWOSZs2h63TUPp5Y1
         THEdG1kMsLAA4yju/MOS+H8eEnnler7ddnjDtHvOThEauG1iq44o6jm8hfoy5ws158K2
         f+vxjtb++SGSDHg7XWuch2FiOImDaMMebd1nTD3TsZk96lu3uR5RXVhKyYqDrIcUsrbu
         uC3by1mmMITnfCvhWH8dP5yUC1YVRtCfFW9PxEPO2OVCnqIeuPlrVsE5w8dWcJAP9MQu
         mGjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=7ENo+LQFzsHhuty3BkKJoKSguVUYkFockJe29Qo4mpc=;
        b=riS+gLNCKAU4els03f4wUvauplzi386yXOl7CYdk1eE7AWAdFdtTRRUIFoWGEOLBtZ
         VIe60G8PwwbA5sqc/TXVUg72e0hqt3SwSV9+UmLKtQmdPwu8/ejGbMmHP2tWD8GVHAoB
         HtBY6bay4SwsOHLjNB1Bf6xg65TQRZYvCxcHSQMO/I1QlPrM95fPpTx+oj0P7twtBN3u
         SLIus5Y1jDyp5qdylTsD3rNjPyQImIKnydkxuqCxeS4eeCdbTFGxOaHU9Q3yM8W1BlVO
         7qdZcafqVDtIcldNeOfw/qaqsM47luHLllQuj3qRXXDB8+AFlrpQ5HWPbFYfCzsTDJ7u
         OLow==
X-Gm-Message-State: APjAAAUOEMEChtDCagaZQpkAdPwDxO/rocy/3M3jfMbHMOiTH8Ymiiqy
        S8TD7Xb8MaYsj31vAOPMssyG9DJB
X-Google-Smtp-Source: APXvYqxvtzXGZuKMApqovR5A3qE1li5m7ePPP7dsGl0yzPx5L9d58S5ZdqIYJrNtvnpx/R9nRTBvHw==
X-Received: by 2002:a63:2ad8:: with SMTP id q207mr22011778pgq.45.1580170621689;
        Mon, 27 Jan 2020 16:17:01 -0800 (PST)
Received: from bbox-1.mtv.corp.google.com ([2620:15c:211:1:3e01:2939:5992:52da])
        by smtp.gmail.com with ESMTPSA id q28sm11301461pfl.153.2020.01.27.16.17.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2020 16:17:00 -0800 (PST)
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
        Minchan Kim <minchan@kernel.org>
Subject: [PATCH v3 3/5] mm/madvise: employ mmget_still_valid for write lock
Date:   Mon, 27 Jan 2020 16:16:39 -0800
Message-Id: <20200128001641.5086-4-minchan@kernel.org>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
In-Reply-To: <20200128001641.5086-1-minchan@kernel.org>
References: <20200128001641.5086-1-minchan@kernel.org>
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
index 00ffa7e92f79..bc0a72dbf80e 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -1061,6 +1061,8 @@ static int madvise_common(struct task_struct *task, struct mm_struct *mm,
 	if (write) {
 		if (down_write_killable(&mm->mmap_sem))
 			return -EINTR;
+		if (current->mm != mm && !mmget_still_valid(mm))
+			goto skip_mm;
 	} else {
 		down_read(&mm->mmap_sem);
 	}
@@ -1111,6 +1113,7 @@ static int madvise_common(struct task_struct *task, struct mm_struct *mm,
 	}
 out:
 	blk_finish_plug(&plug);
+skip_mm:
 	if (write)
 		up_write(&mm->mmap_sem);
 	else
-- 
2.25.0.341.g760bfbb309-goog


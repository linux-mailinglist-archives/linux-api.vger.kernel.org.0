Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DBD44473DF
	for <lists+linux-api@lfdr.de>; Sun, 16 Jun 2019 10:59:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726087AbfFPI7C (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sun, 16 Jun 2019 04:59:02 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37696 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbfFPI6m (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sun, 16 Jun 2019 04:58:42 -0400
Received: by mail-wr1-f67.google.com with SMTP id v14so6688191wrr.4
        for <linux-api@vger.kernel.org>; Sun, 16 Jun 2019 01:58:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3ITCIjtRiKXBETAqnfXapAAbycKyMBn7c3dUFh4aTVw=;
        b=P6SKSExNeZ962qr+DE2N3gtKv4Td7FVBAnlRfo/LjHezBcsFFABQ1NNNJbAlbhLJYa
         sv/4kH7vKdW+mo8LYwwsqIkl1R+KJYF4lra+N6eVWdvW0Qq5+ZAur4f9zz2A0Prt5Z9K
         htOHQQEWzN2FbAa+KaQ85gU5TRsQC9o3wNKtvCoedfe0hM0OgSwAgpZNIU+vnGkk95AX
         5cAQOMgmHH1elM8seTUakOpnRRPqPSQ0ALV4aqy8suATtMrA4Nz4G0rJza0hzaamb5Cj
         e3XCgliwjkuEpYUlcBjhLVUNPoOyZnvt+f+chp7vfNzOuR6wfW9W3pSAyJXxdJT3nyws
         8Yog==
X-Gm-Message-State: APjAAAWmi0HAyk2yDX/hWaHos9rD7pVnM33zkw4+nvOW4IML4wYUeuWd
        QFtrADoJ3U3MD6xiMaxEfT8osQ==
X-Google-Smtp-Source: APXvYqzQMjvzDFYnOgTdFM99hcnJUp0/uTV59QLuRVfafS23C/DUgS5gTgJZNRO0B4DaEtyvurzykA==
X-Received: by 2002:a5d:6a42:: with SMTP id t2mr6432594wrw.352.1560675520784;
        Sun, 16 Jun 2019 01:58:40 -0700 (PDT)
Received: from localhost (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id t1sm7728752wra.74.2019.06.16.01.58.40
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 16 Jun 2019 01:58:40 -0700 (PDT)
From:   Oleksandr Natalenko <oleksandr@redhat.com>
To:     Minchan Kim <minchan@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-api@vger.kernel.org
Subject: [PATCH NOTFORMERGE 2/5] mm: revert madvise_inject_error line split
Date:   Sun, 16 Jun 2019 10:58:32 +0200
Message-Id: <20190616085835.953-3-oleksandr@redhat.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190616085835.953-1-oleksandr@redhat.com>
References: <20190616085835.953-1-oleksandr@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Just to highlight it after our conversation.

Signed-off-by: Oleksandr Natalenko <oleksandr@redhat.com>
---
 mm/madvise.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/mm/madvise.c b/mm/madvise.c
index edb7184f665c..70aeb54f3e1c 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -1041,8 +1041,7 @@ static int madvise_common(struct task_struct *task, struct mm_struct *mm,
 
 #ifdef CONFIG_MEMORY_FAILURE
 	if (behavior == MADV_HWPOISON || behavior == MADV_SOFT_OFFLINE)
-		return madvise_inject_error(behavior,
-					start, start + len_in);
+		return madvise_inject_error(behavior, start, start + len_in);
 #endif
 
 	write = madvise_need_mmap_write(behavior);
-- 
2.22.0


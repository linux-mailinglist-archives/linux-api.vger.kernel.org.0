Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29D8D32806
	for <lists+linux-api@lfdr.de>; Mon,  3 Jun 2019 07:37:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbfFCFhU (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 3 Jun 2019 01:37:20 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37415 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726257AbfFCFhU (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 3 Jun 2019 01:37:20 -0400
Received: by mail-pg1-f193.google.com with SMTP id 20so7606244pgr.4;
        Sun, 02 Jun 2019 22:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AspJoK2TnbwgjAatSkGxez0VLRm0DAxlcRNfqD2t6lc=;
        b=sPcwms7LYj4OL0DvDW4nBr5ZoY9hI81X1IP/z3cTp0vq+ISknRS5WqE6Zw8bwdF1Sg
         yvbs53EAb/7oq1V6nr51+aJkcyrxHNvFmHHLSNvUb6ZOgkOKpazX8IPcwl1VbQuR1hd8
         Qpn/AscGh273pm+aEcqMzd3eQ64p3IcnT2e5OFQsccb3pMmblaCx37gA1Uk2W6gmH174
         J36Nb/oBVslBf/K7IHRDzps+IdfImuzteUG++SbBm9HjFenHj/eh3aqLpTn6pVfugtYk
         HoPaCxRCQ8aicl8uWFhoOKf49ggJZvYN/PKYwPokllmdUqk2vB0MaRcq8x+dRrxtN00s
         hG/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=AspJoK2TnbwgjAatSkGxez0VLRm0DAxlcRNfqD2t6lc=;
        b=KqymcQ2od+doElbJTc+O7lgZALdkSlmg/bcHEKSdfPQAGGbnV7AWGatTP5K4DYf6Sw
         6S4Kn/VfM/m0g04CQd2ygyY2lmTI89iMgwGeP67dX96uNFSfdIsQlzS72MUilXHVDasU
         H1LQGLeKMrwezyiJV+60JbJ6elfiz9d3kVjdJDefptwzm6ssypas7NKJ9Z4dyyT5cTAZ
         W9kIHAuEhSPhRQhTsIvBuawOk+T90gq90OeKrLflctcdVdodqzM4jhg0QySmnZJKAVBi
         /uxEAr8w8uXgMnEerQ1uVBoGCa2vCSqx6h0BYpHIJ6oERYFLiKFCHJ2Px91z2gzcXznl
         fVtA==
X-Gm-Message-State: APjAAAXgHSA0hDrPsVpBZ0eJoMnSm8fkT+RchZzO4SIOUWGc48U0eQeo
        DRPL3foYFs4dAo7xFIhPHF8=
X-Google-Smtp-Source: APXvYqz0WzWbOPH7SHnTOp8MB+cFakTtiCbidmfpKSiMxWd9qnxaF17/qkGfGsSNuehNI7zsyP+OdA==
X-Received: by 2002:a63:788a:: with SMTP id t132mr26741639pgc.52.1559540239802;
        Sun, 02 Jun 2019 22:37:19 -0700 (PDT)
Received: from bbox-2.seo.corp.google.com ([2401:fa00:d:0:98f1:8b3d:1f37:3e8])
        by smtp.gmail.com with ESMTPSA id a18sm5986222pjq.0.2019.06.02.22.37.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 02 Jun 2019 22:37:18 -0700 (PDT)
From:   Minchan Kim <minchan@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        linux-api@vger.kernel.org, Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tim Murray <timmurray@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Daniel Colascione <dancol@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Sonny Rao <sonnyrao@google.com>,
        Brian Geffon <bgeffon@google.com>, jannh@google.com,
        oleg@redhat.com, christian@brauner.io, oleksandr@redhat.com,
        hdanton@sina.com, Minchan Kim <minchan@kernel.org>
Subject: [PATCH v1 2/4] mm: change PAGEREF_RECLAIM_CLEAN with PAGE_REFRECLAIM
Date:   Mon,  3 Jun 2019 14:36:53 +0900
Message-Id: <20190603053655.127730-3-minchan@kernel.org>
X-Mailer: git-send-email 2.22.0.rc1.311.g5d7573a151-goog
In-Reply-To: <20190603053655.127730-1-minchan@kernel.org>
References: <20190603053655.127730-1-minchan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

The local variable references in shrink_page_list is PAGEREF_RECLAIM_CLEAN
as default. It is for preventing to reclaim dirty pages when CMA try to
migrate pages. Strictly speaking, we don't need it because CMA didn't allow
to write out by .may_writepage = 0 in reclaim_clean_pages_from_list.

Moreover, it has a problem to prevent anonymous pages's swap out even
though force_reclaim = true in shrink_page_list on upcoming patch.
So this patch makes references's default value to PAGEREF_RECLAIM and
rename force_reclaim with ignore_references to make it more clear.

This is a preparatory work for next patch.

* RFCv1
 * use ignore_referecnes as parameter name - hannes

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Minchan Kim <minchan@kernel.org>
---
 mm/vmscan.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 84dcb651d05c..0973a46a0472 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1102,7 +1102,7 @@ static unsigned long shrink_page_list(struct list_head *page_list,
 				      struct scan_control *sc,
 				      enum ttu_flags ttu_flags,
 				      struct reclaim_stat *stat,
-				      bool force_reclaim)
+				      bool ignore_references)
 {
 	LIST_HEAD(ret_pages);
 	LIST_HEAD(free_pages);
@@ -1116,7 +1116,7 @@ static unsigned long shrink_page_list(struct list_head *page_list,
 		struct address_space *mapping;
 		struct page *page;
 		int may_enter_fs;
-		enum page_references references = PAGEREF_RECLAIM_CLEAN;
+		enum page_references references = PAGEREF_RECLAIM;
 		bool dirty, writeback;
 		unsigned int nr_pages;
 
@@ -1247,7 +1247,7 @@ static unsigned long shrink_page_list(struct list_head *page_list,
 			}
 		}
 
-		if (!force_reclaim)
+		if (!ignore_references)
 			references = page_check_references(page, sc);
 
 		switch (references) {
-- 
2.22.0.rc1.311.g5d7573a151-goog


Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 193C464FDD
	for <lists+linux-api@lfdr.de>; Thu, 11 Jul 2019 03:25:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727779AbfGKBZv (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 10 Jul 2019 21:25:51 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38535 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727906AbfGKBZv (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 10 Jul 2019 21:25:51 -0400
Received: by mail-pg1-f195.google.com with SMTP id z75so2077603pgz.5;
        Wed, 10 Jul 2019 18:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ytlBWMtHJbXM/Fdr0Dw34etRRl/dA5ETgcx25kBAXTE=;
        b=scmCxifB8StBEnmKJK3AL4Hjoo98qxRNoQ8Fk3T8R9JuJObsuBeHZD00xDTlmTG4lh
         BzuC9uPW4vFnIP4tbOwbF3cqX08QGsRYfP2p+KEsQG5xIuaSSWt7oxSdFKZjc/ofymfx
         qw8C+OcxbqqZk22YmTmHhF8Mp/eKpdhQi+NAjVTUMZiePcw0acmeucdEhdmeeE+aiX3n
         gRwdmJpdShHc94ZVrAYoPS7XXlnnyC6tXr4cQj2bhACNORepwXVk2b2tOmJO2srqMWit
         qXgqphbd2UH5Wt76dnSGGMN6OabavY6+qQ2dpOslFYo1NQUYJE5KTS3xQ0D5pJ3G5Cow
         U1JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=ytlBWMtHJbXM/Fdr0Dw34etRRl/dA5ETgcx25kBAXTE=;
        b=AA05vU76d2FRMVphcLF6N3SZKbn921+zBXQUUB1cm07HYP1l8sJ3TykzLR1ecpSI6y
         nQt4e58ULd49n9vmpNsSnydkUbGEHCH1N2WN4QK6/LsMRTmv5iH3BhdePrhtAv1shsw/
         VhS1p92Cwt72XxL2MB04jiMGwNuiEw0NZtxJjAGSg7v7zS5EJTBcXC4sf87K0qx8+/Wj
         /S8+jngZDT7XD27eUV80xhSnIYqOLUCg6R69UglUy0+EXjxCQwWnydPe+glTwK+tGgQ1
         wHAhsf09Kdi3408ZaggUVjJ0spQcXgPkF+C6QtVbTF9rC0dm7Ve4CWBIMJ8UqWC/na8H
         ewFg==
X-Gm-Message-State: APjAAAUFWAWPKN9eUaRzEixmiFpQtjsedJtVHZMB84hDdIOQClfpophJ
        NkU9D650MnyBZEzvrhxVlLY=
X-Google-Smtp-Source: APXvYqwoGIjOCi1444aQyMZiTm8AH1PhVwM3KaGhWog4eNCwyVy0z+FnrWXmbFQXXt10zF79f3fcAA==
X-Received: by 2002:a63:9a51:: with SMTP id e17mr1412020pgo.212.1562808350302;
        Wed, 10 Jul 2019 18:25:50 -0700 (PDT)
Received: from bbox-2.seo.corp.google.com ([2401:fa00:d:0:98f1:8b3d:1f37:3e8])
        by smtp.gmail.com with ESMTPSA id b37sm10031974pjc.15.2019.07.10.18.25.45
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 10 Jul 2019 18:25:49 -0700 (PDT)
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
        Sonny Rao <sonnyrao@google.com>, oleksandr@redhat.com,
        hdanton@sina.com, lizeb@google.com,
        Dave Hansen <dave.hansen@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Minchan Kim <minchan@kernel.org>
Subject: [PATCH v4 2/4] mm: change PAGEREF_RECLAIM_CLEAN with PAGE_REFRECLAIM
Date:   Thu, 11 Jul 2019 10:25:26 +0900
Message-Id: <20190711012528.176050-3-minchan@kernel.org>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
In-Reply-To: <20190711012528.176050-1-minchan@kernel.org>
References: <20190711012528.176050-1-minchan@kernel.org>
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

Acked-by: Michal Hocko <mhocko@suse.com>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Minchan Kim <minchan@kernel.org>
---
 mm/vmscan.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index a0301edd8d03..b4fa04d10ba6 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1119,7 +1119,7 @@ static unsigned long shrink_page_list(struct list_head *page_list,
 				      struct scan_control *sc,
 				      enum ttu_flags ttu_flags,
 				      struct reclaim_stat *stat,
-				      bool force_reclaim)
+				      bool ignore_references)
 {
 	LIST_HEAD(ret_pages);
 	LIST_HEAD(free_pages);
@@ -1133,7 +1133,7 @@ static unsigned long shrink_page_list(struct list_head *page_list,
 		struct address_space *mapping;
 		struct page *page;
 		int may_enter_fs;
-		enum page_references references = PAGEREF_RECLAIM_CLEAN;
+		enum page_references references = PAGEREF_RECLAIM;
 		bool dirty, writeback;
 		unsigned int nr_pages;
 
@@ -1264,7 +1264,7 @@ static unsigned long shrink_page_list(struct list_head *page_list,
 			}
 		}
 
-		if (!force_reclaim)
+		if (!ignore_references)
 			references = page_check_references(page, sc);
 
 		switch (references) {
-- 
2.22.0.410.gd8fdbe21b5-goog


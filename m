Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 56C9375D12
	for <lists+linux-api@lfdr.de>; Fri, 26 Jul 2019 04:35:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725867AbfGZCe5 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 25 Jul 2019 22:34:57 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46657 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725842AbfGZCe5 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 25 Jul 2019 22:34:57 -0400
Received: by mail-pg1-f195.google.com with SMTP id k189so4942782pgk.13;
        Thu, 25 Jul 2019 19:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kQxMbqrsX/nZiD0N6XPZDIM95WzOo92zapucPy1vlUg=;
        b=oKcEphqrcIJTXgzvD1uIGdr1uqZO2gHbJqUCYNEjScVnAblxZ7V2fe3YaOhp91mxei
         HMBTDS5xNe4zP8el69NOJvVwqVrbeZ4vhgV39daqg1CBlxo1/Y0l1fJlXb2u0POuHO+G
         +fR8O/S29Hirw56Er6PMRq7F+Vh3GI18riHLeQYpDi6lRimdRcOAePdbgZFqMWzIeJRZ
         wfLljhwWF8vsCNEVuFI9iu9LiKanPYdZ0cOZ7vhxfgQ7CnngyxpbiaKc8mM2UEo7piE/
         CEtQMq6PjMVOCWeKRpdJPWERXx4gZj0BLLz1IUhQV2CVQ7ZIL+/i8gkgUlPDYMRdHKHm
         a5+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=kQxMbqrsX/nZiD0N6XPZDIM95WzOo92zapucPy1vlUg=;
        b=RKkME6Twf8QisiXx8XOZTzCM344Y0c0jA/4UrIZfEiFXOYb2UAJanbpidDwH8ETTB5
         T74uq4j3i5RSbvbkx1/030dR+LUUadKPw9fUoQzjLaZ/FPtP/lf6Ji9Wii7WdBkU/Sv3
         cxFeB+HrCFs5KF7eHemw/NtqMUE2AOtMydB5lO6qAE1EjtfY9zrBqsj6iN0u9I+oGqlW
         qpJZTDMuQkiY2frNQQL05lxNfq8V646yUzNTU/6kle8n1siu3EnkUvvVHlI56RXgjF+i
         xa2mdG08XsOOx23buS1XDKa3i1dze3U5t8ScDrZRnnXLTRc4LXB6MxhGRBSgH2f879XB
         QSbg==
X-Gm-Message-State: APjAAAVkGfGxODxpveOrH7B+neyK4h6k4sTfmgG8t74seN0UV5RlfXwP
        lqA5/iAPD1eXIMOnsD9Qv7k=
X-Google-Smtp-Source: APXvYqwCBy1Zc5tBK+qCsIuV/IuM/t64Rz0ADnQpNhj+o/kGXbRTjM5yaRilbKPxid2BEuggsNOknw==
X-Received: by 2002:a63:3805:: with SMTP id f5mr55887841pga.272.1564108496625;
        Thu, 25 Jul 2019 19:34:56 -0700 (PDT)
Received: from bbox-2.seo.corp.google.com ([2401:fa00:d:0:98f1:8b3d:1f37:3e8])
        by smtp.gmail.com with ESMTPSA id l31sm88958450pgm.63.2019.07.25.19.34.51
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 25 Jul 2019 19:34:55 -0700 (PDT)
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
Subject: [PATCH v7 2/5] mm: change PAGEREF_RECLAIM_CLEAN with PAGE_REFRECLAIM
Date:   Fri, 26 Jul 2019 11:34:32 +0900
Message-Id: <20190726023435.214162-3-minchan@kernel.org>
X-Mailer: git-send-email 2.22.0.709.g102302147b-goog
In-Reply-To: <20190726023435.214162-1-minchan@kernel.org>
References: <20190726023435.214162-1-minchan@kernel.org>
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
index 82e1e229eef21..436577236dd3e 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1124,7 +1124,7 @@ static unsigned long shrink_page_list(struct list_head *page_list,
 				      struct scan_control *sc,
 				      enum ttu_flags ttu_flags,
 				      struct reclaim_stat *stat,
-				      bool force_reclaim)
+				      bool ignore_references)
 {
 	LIST_HEAD(ret_pages);
 	LIST_HEAD(free_pages);
@@ -1138,7 +1138,7 @@ static unsigned long shrink_page_list(struct list_head *page_list,
 		struct address_space *mapping;
 		struct page *page;
 		int may_enter_fs;
-		enum page_references references = PAGEREF_RECLAIM_CLEAN;
+		enum page_references references = PAGEREF_RECLAIM;
 		bool dirty, writeback;
 		unsigned int nr_pages;
 
@@ -1269,7 +1269,7 @@ static unsigned long shrink_page_list(struct list_head *page_list,
 			}
 		}
 
-		if (!force_reclaim)
+		if (!ignore_references)
 			references = page_check_references(page, sc);
 
 		switch (references) {
-- 
2.22.0.709.g102302147b-goog


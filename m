Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9DA49711DF
	for <lists+linux-api@lfdr.de>; Tue, 23 Jul 2019 08:26:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730404AbfGWG0B (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 23 Jul 2019 02:26:01 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:33648 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730328AbfGWG0A (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 23 Jul 2019 02:26:00 -0400
Received: by mail-pl1-f193.google.com with SMTP id c14so20133107plo.0;
        Mon, 22 Jul 2019 23:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bnIASPZxrrGOWF/G5OfEZ1yV57NTr/ruSeiXKsRM3nk=;
        b=uuhLoA0BBoERKypNBgrn/ZlmpMF92srWO/6MUGEN3xX1GzOTomN23OaW/P/sopLIED
         2Xzsuj6Co6dKvk0D5MbrA8TfP4zStCUOHX6h5EBFSgLyStisdYhYvIEJEqB78ObpfvQx
         CIGiXaI8bQsfzUcHQORkIa8aacyWCE9dLGwtRaXBrzmU5hzTk6jGGgYCl9PXzw3/0bkL
         xe3svs11oSO6Hq0wAytjsddI9jOX0atWt4ZiE7429kLMyXjLHClGvJP6kuBdw9t/NZ/n
         Pj8j5fZXo7JbPhPs7ets5aP15dM9d29pdU+nhxzKURWL9WBl7Y2iQjcanm0fOfDBvhjW
         LBnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=bnIASPZxrrGOWF/G5OfEZ1yV57NTr/ruSeiXKsRM3nk=;
        b=Qg7sFoN8v9aEFntfIYN2OTqQH0rdlzXVciGjS7c4WzWq1emR/EHfi+HTJ80tDTwc1F
         86gQEgE+XknvGFO0cXzSmZF3zbHuxwKRsfPqfsfBRUxhHh+p0UquJRgMjafgg2c/+pEl
         C3FfaLNH187S3KV4gH9hBuFz616XLEf/KRfQUC48drUN+PSK5RMYvhtDSBFkAgv00qMW
         qOdOH+miXNtMk0WM8vKs5C9GlCBkd6W/KYYJtnOnsiIHh/F0Jegbg3RGORGOFxcLlPiq
         jbIHeaGR+/Et5dPYNIUzFmEx/oRKHA+8AtxyTnr15w6BaPQb51HGu6jdjlJgrMxQ7KSX
         KhAg==
X-Gm-Message-State: APjAAAW8yLhzlFdo+yeE5ht1pq2aPPo4RuLiu6aQMAKuxnSDBNjhyB9S
        Lbj/lZ1EDoVzZ0uys6zMCzA=
X-Google-Smtp-Source: APXvYqyOx95R0nQcXqx5AoqfhCHYUJ6uEq79frQnW+ZOvXT1NvMLzarqUl004ZEy3UbXm7PLzVCYcQ==
X-Received: by 2002:a17:902:290b:: with SMTP id g11mr77632984plb.26.1563863159650;
        Mon, 22 Jul 2019 23:25:59 -0700 (PDT)
Received: from bbox-2.seo.corp.google.com ([2401:fa00:d:0:98f1:8b3d:1f37:3e8])
        by smtp.gmail.com with ESMTPSA id s66sm44630376pfs.8.2019.07.22.23.25.54
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 22 Jul 2019 23:25:58 -0700 (PDT)
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
Subject: [PATCH v6 2/5] mm: change PAGEREF_RECLAIM_CLEAN with PAGE_REFRECLAIM
Date:   Tue, 23 Jul 2019 15:25:36 +0900
Message-Id: <20190723062539.198697-3-minchan@kernel.org>
X-Mailer: git-send-email 2.22.0.657.g960e92d24f-goog
In-Reply-To: <20190723062539.198697-1-minchan@kernel.org>
References: <20190723062539.198697-1-minchan@kernel.org>
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
index f4fd02ae233ef..f68449ce0c44c 100644
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
2.22.0.657.g960e92d24f-goog


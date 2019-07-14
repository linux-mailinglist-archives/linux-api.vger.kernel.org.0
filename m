Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DEB76681A6
	for <lists+linux-api@lfdr.de>; Mon, 15 Jul 2019 01:34:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728982AbfGNXeW (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sun, 14 Jul 2019 19:34:22 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:43014 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728980AbfGNXeW (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sun, 14 Jul 2019 19:34:22 -0400
Received: by mail-pl1-f194.google.com with SMTP id 4so399812pld.10;
        Sun, 14 Jul 2019 16:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dXmXb4hHePla+El29aWi3bvhcbCN7txGRytZMqhI7AI=;
        b=WfvIdRNOEo5M3yqFQ95X+vfDsPgzs25Ux+W4a/3b0F9+lSPVhBU179TivXn7eJEcmJ
         V22evIfrP5qzt8j3EEbNGr9Cvxr5RHydDispLsawnpwS+nHo6VkqM/P9PGR0X+UElKV4
         mDKb2zjj60mKgRGXZyWtcGNLiUVwP5GSH0k1GPzGyIpiAhSSsdEVzGdg0PrI9ahJXM1e
         o5dJpgB4/blnAaNTpN3xA/Sq69f7umq2GgXLfqmnvzrQNcc3ouReHxWXqU2OrRkNua08
         4m8cNSl/Tn3dM+2HjgPGqx9RgjsKf+mLls7u+Guu/TTd5spfTGYh/uTQBOUOwl9q6GAm
         TVsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=dXmXb4hHePla+El29aWi3bvhcbCN7txGRytZMqhI7AI=;
        b=Eni0RDWOTfyfb1PTvIFU9CIAvqVnLgqkNCQYe+QHLTdVKYsqgsL0JZxlT7lrAvG3VH
         kODUWqKJc1HJ5MZxIGb6N0xfvsNXEao+CT+n+C2bQouSSCfDfNl4Ut+SkJjuaeAkAecR
         F9R5hnNiGugQ2G+QyVeOHDd0E2g7RV/Y+VCpq5RDqNyuOrgSjioefLJTkCEwokJPIq1d
         9w3QyI3po6IQ1Czvk3KqHAz+2XAtzMGSLl3Cal3HnUgUEM7eq440pNukEIkCjvQeD4M/
         weq8cpk4+5IgrcASDLSzblD5p9mRmzzfjKnlwhkf2yTVf11tCHtEtZzTQ21Q03OkkmzY
         6qNg==
X-Gm-Message-State: APjAAAVYePi5OObOQ7mWmTwMzZc6i/H39SwuXjv0mCVYpXpinrjVxU5Q
        9YmGEwkeOqwZRdDJVuaFhW0=
X-Google-Smtp-Source: APXvYqyoIoiBc9BVkZkT+Mht+XPRNWcu2bkpsPgUKHDpHhdXHUndHSbJNQ8VyCvOS+D5QoVIUDIXhg==
X-Received: by 2002:a17:902:e011:: with SMTP id ca17mr25554044plb.328.1563147261258;
        Sun, 14 Jul 2019 16:34:21 -0700 (PDT)
Received: from bbox-2.seo.corp.google.com ([2401:fa00:d:0:98f1:8b3d:1f37:3e8])
        by smtp.gmail.com with ESMTPSA id n26sm16256923pfa.83.2019.07.14.16.34.16
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 14 Jul 2019 16:34:20 -0700 (PDT)
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
Subject: [PATCH v5 2/5] mm: change PAGEREF_RECLAIM_CLEAN with PAGE_REFRECLAIM
Date:   Mon, 15 Jul 2019 08:33:57 +0900
Message-Id: <20190714233401.36909-3-minchan@kernel.org>
X-Mailer: git-send-email 2.22.0.510.g264f2c817a-goog
In-Reply-To: <20190714233401.36909-1-minchan@kernel.org>
References: <20190714233401.36909-1-minchan@kernel.org>
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
2.22.0.510.g264f2c817a-goog


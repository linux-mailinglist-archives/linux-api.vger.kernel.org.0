Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C7181581E1
	for <lists+linux-api@lfdr.de>; Thu, 27 Jun 2019 13:54:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbfF0Ly0 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 27 Jun 2019 07:54:26 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33520 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726308AbfF0Ly0 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 27 Jun 2019 07:54:26 -0400
Received: by mail-pf1-f196.google.com with SMTP id x15so1131413pfq.0;
        Thu, 27 Jun 2019 04:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AAp8d968Yh2opGUVOFegnzF6eMOu3mT7GyxCSQBbrz4=;
        b=IusLSOBjKyjzEsTIjCyYaX7iDxTc+jt9jznyuZqnSu292hsSCly7AXcCPkLqGadrsU
         GS3+VBsW8saL2SZYTRKOIxeQ4qrKDrv/fiq8yO1AsrJVbWUPIQa18kwtFnCB6EmUDQgY
         zmFLUSMSOckUpxgrm8gQPnSy/5YIi0WHywEMXVeEd1M2sABbbe81pzPqtIg8yXZhe15d
         VSCTBlwiaMVgs+x0+j5D2+nmM5ulbkKn9ovG7BEb6bOsx8UVMyJ5E4LoQaQ5FWBAiiTp
         mOtBV7bnx9ZmbLyR2+r9g1qY63mV6QqOqAD6BZmkxF9j2IcLNTQNhQupulksZ+bvJWl1
         jO6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=AAp8d968Yh2opGUVOFegnzF6eMOu3mT7GyxCSQBbrz4=;
        b=LzESbHmcyhjLwcRj1ToOSS2fWacgRw9ixcfRk0H2F71tsetjuyYXoUjOkPrc0UcXUN
         J1wCn270ZHT8Ab4FmY8uFBlgN0WUrfwbDaxAvprYYbsBSbS0SUOlgxSj4LYHzudr3E8e
         m75ZIKkAgua5krGE7wtXK/4SuHu9LbyIr72DDN5z+V5Ki/K96T93dbOHsvh4UWBzeWUi
         /awEDVDkXZ3cTxJlkGrHi1gIcDabKvdXoc/UkrQJ3abMepy6Zdtm71tCPYd86MoIXJ3E
         XUaAsWbEeb6G//1vuZTMQILCS/Je/8vqSPWuBA1RWv49EIBy7T76M4y8IllvxjTP5TjK
         Q8DQ==
X-Gm-Message-State: APjAAAWQArBrjf5IlvkcB//sXVMI+BQbUR24ZYj2sK6nGJd77ufzwTM1
        7wSVFOPn5XsNaBnbiLZGTrM=
X-Google-Smtp-Source: APXvYqw+UmMVOCkMwFhSUPGnw/i5c2zgEVNDeOFbpvqoW2kE2ETfKhNvJF6jlv44hoNP2zJ6SNMOdg==
X-Received: by 2002:a63:4553:: with SMTP id u19mr3404760pgk.420.1561636465689;
        Thu, 27 Jun 2019 04:54:25 -0700 (PDT)
Received: from bbox-1.seo.corp.google.com ([2401:fa00:d:0:d988:f0f2:984f:445b])
        by smtp.gmail.com with ESMTPSA id x14sm3241419pfq.158.2019.06.27.04.54.20
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 27 Jun 2019 04:54:24 -0700 (PDT)
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
Subject: [PATCH v3 2/5] mm: change PAGEREF_RECLAIM_CLEAN with PAGE_REFRECLAIM
Date:   Thu, 27 Jun 2019 20:54:02 +0900
Message-Id: <20190627115405.255259-3-minchan@kernel.org>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
In-Reply-To: <20190627115405.255259-1-minchan@kernel.org>
References: <20190627115405.255259-1-minchan@kernel.org>
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
index 9e3292ee5c7c..49e9ee4d771d 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1117,7 +1117,7 @@ static unsigned long shrink_page_list(struct list_head *page_list,
 				      struct scan_control *sc,
 				      enum ttu_flags ttu_flags,
 				      struct reclaim_stat *stat,
-				      bool force_reclaim)
+				      bool ignore_references)
 {
 	LIST_HEAD(ret_pages);
 	LIST_HEAD(free_pages);
@@ -1131,7 +1131,7 @@ static unsigned long shrink_page_list(struct list_head *page_list,
 		struct address_space *mapping;
 		struct page *page;
 		int may_enter_fs;
-		enum page_references references = PAGEREF_RECLAIM_CLEAN;
+		enum page_references references = PAGEREF_RECLAIM;
 		bool dirty, writeback;
 		unsigned int nr_pages;
 
@@ -1262,7 +1262,7 @@ static unsigned long shrink_page_list(struct list_head *page_list,
 			}
 		}
 
-		if (!force_reclaim)
+		if (!ignore_references)
 			references = page_check_references(page, sc);
 
 		switch (references) {
-- 
2.22.0.410.gd8fdbe21b5-goog


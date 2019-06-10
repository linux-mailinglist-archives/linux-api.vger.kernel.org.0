Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A6E53B3D5
	for <lists+linux-api@lfdr.de>; Mon, 10 Jun 2019 13:13:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389267AbfFJLNQ (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 10 Jun 2019 07:13:16 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35605 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389001AbfFJLNP (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 10 Jun 2019 07:13:15 -0400
Received: by mail-pg1-f196.google.com with SMTP id s27so4882830pgl.2;
        Mon, 10 Jun 2019 04:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rtdW0n4Q4ONaBgNzSNMHKzSk3rd1hSsd9/TPUeo4Zf4=;
        b=C/EGTTb9dJdZwxuMIvqZVsbbUIRUqEq0Y0GOsoig6NyIpHoHymWCD8ih6Z7c/JT9EQ
         TPYVc6XiFmXsMqqJzzrQfDUkaww3pkzUGlgYKvwRnrUDUd7rMI6YVnlA4QVMw+Iz1ICW
         il5vU458YFkhGj2rBqvx8tEeXt4JQ+GJPR9SuoRXU/7NfzDgWKFqLp8mtwue9uFuOZJE
         YvB9yTdlV946j0YWbsCSQ18+xYS863GYrva8WhdjFwLVK1Ghishf2h2q+kiQAraavvvH
         Yx/2mN058ASCIvAQo909hzJ5sk4SkIChiKgnRD+he2K94Fe8/w89Q5FDi11PRzboCdya
         lsuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=rtdW0n4Q4ONaBgNzSNMHKzSk3rd1hSsd9/TPUeo4Zf4=;
        b=hmQKx18ipyH5wl41NgmYqrlA5VhBq9NNohJ9NeneEtDrWsOAmoZOMzE4aXB+dOtrBB
         1TSBskasyWVpDHVfSacTK7W+9xvytCPLUcMvGMOunjIXSy/ZN98UUWpbuxm/f+lKYGBX
         qVMaEOSMBMl/AP+0SgcjCoju0W+WuRoL1zZ9J4TU06/dNYKGEtNOKyD9OREzf+JtzocA
         YtrPD79epw4G0Q0TWknXeVVMRchApEXeAGZxegrTafJy1n+NU5avALYCtCBCFwVzRRjd
         srkgZbF5Hk6pU+IRxtKcFCdQlTGK9CwlCoraojWPX/oBG5u/0CAI4pGRFxVQx9Nm18lQ
         DreA==
X-Gm-Message-State: APjAAAULlLmK9SJ7zI53wb7OqxLRFFRg+CKoeIBfvuPQedo3UrzHorQM
        hA2bTIzBDbe2f+7oJvGnevQ=
X-Google-Smtp-Source: APXvYqzUKtfBzCkt8JOrcNL3JVApJN7IuSow2TUbfeFGWUJOWH42s56iyctqroAHvajIeMPIzhFSOA==
X-Received: by 2002:a17:90b:d8b:: with SMTP id bg11mr20724547pjb.30.1560165195244;
        Mon, 10 Jun 2019 04:13:15 -0700 (PDT)
Received: from bbox-2.seo.corp.google.com ([2401:fa00:d:0:98f1:8b3d:1f37:3e8])
        by smtp.gmail.com with ESMTPSA id h14sm9224633pgj.8.2019.06.10.04.13.09
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 10 Jun 2019 04:13:13 -0700 (PDT)
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
        hdanton@sina.com, lizeb@google.com,
        Minchan Kim <minchan@kernel.org>
Subject: [PATCH v2 2/5] mm: change PAGEREF_RECLAIM_CLEAN with PAGE_REFRECLAIM
Date:   Mon, 10 Jun 2019 20:12:49 +0900
Message-Id: <20190610111252.239156-3-minchan@kernel.org>
X-Mailer: git-send-email 2.22.0.rc2.383.gf4fbbf30c2-goog
In-Reply-To: <20190610111252.239156-1-minchan@kernel.org>
References: <20190610111252.239156-1-minchan@kernel.org>
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
2.22.0.rc2.383.gf4fbbf30c2-goog


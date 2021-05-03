Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07F64371F49
	for <lists+linux-api@lfdr.de>; Mon,  3 May 2021 20:08:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231867AbhECSJQ (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 3 May 2021 14:09:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231998AbhECSJB (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 3 May 2021 14:09:01 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2C84C061353
        for <linux-api@vger.kernel.org>; Mon,  3 May 2021 11:07:58 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id u7-20020a259b470000b02904dca50820c2so8684715ybo.11
        for <linux-api@vger.kernel.org>; Mon, 03 May 2021 11:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=DoWXx87b+Num+Reqv5sSHd1wfcUc2x8Dquy/B9+1IoU=;
        b=nvwXd3Q7vwLtpi5zok2xV+bzBipiCzcjLFfLaLjrW3LnM2BxxbcRTwblxJc2oN8Nsj
         k9449XsNR7OXw68xhaizvXpCfBzb5QfIg3A6TRWZi7/5lg9FTL3cHLk3FOvP/X0ZV0Is
         onU3vCJUkeqyL4f/kSilwcEhU95cN5Ud2/M7kRjXHAGJT5zoatWaSYmiRU1dZLLqIrHP
         J3tLvtFtiYW82BuflVjKfw9mtaPXfyBk2ouzNWsdlJj/KkTgLRS+wwn9pU1EnP5nqIry
         hGIYPD3PVyvS3WmKXKbOVxUgXehclcwOqRNYhvSF8K4yp9IUT7EEcH3Dxt/7Jvwdr0g4
         hfDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=DoWXx87b+Num+Reqv5sSHd1wfcUc2x8Dquy/B9+1IoU=;
        b=JEVzYZzD+wbo7btoojvGQe7YtbGoKO1lQ9aQ+f4E0FLRphvXDawTYTj7fNpRZPgLEr
         ehQSb5RnCfFMQS26VLzjjW6rsdYM1pOhLBXy7hSgpxX8Ml9Ovt9uoQmVl5Sn+oZWr1xZ
         uqnXmmMnDHy8HKK1F5YL4UZ+Soe4sC2htPFWIcOhJemeLfuTBqsbJtaPEjTC08E4kH7G
         GxykBlMsTO1GiYt3F+oUQuPqyM6UB5mvImwbcKmX1UGrb7pf2VCgQyZj++y1LXi7Jx57
         VKk+k57sW63mXd5E8qPbJkk+Rr4I70WbJvL4x5ZfgCKslTuvzPzC+oZDW0EWQHYm8tP8
         IzLQ==
X-Gm-Message-State: AOAM530Q+pkTz7Y9961+iWj4LtU8jfnZ33MF9te+AedY2auOnHNqBNtW
        K2USgSA8B4Jo3T9EQ4G6S6HqmTfbJoe8MLVaSpKM
X-Google-Smtp-Source: ABdhPJwuU013RuhBQO/T92u+GOekQFViLlft8ynCR7Gl8N6K8mV5+xEqVTnMsrhevMFtXctpx6HhHAvJdQpR6qe5zVCL
X-Received: from ajr0.svl.corp.google.com ([2620:15c:2cd:203:3d79:e69a:a4f9:ef0])
 (user=axelrasmussen job=sendgmr) by 2002:a25:880f:: with SMTP id
 c15mr28912270ybl.373.1620065278099; Mon, 03 May 2021 11:07:58 -0700 (PDT)
Date:   Mon,  3 May 2021 11:07:35 -0700
In-Reply-To: <20210503180737.2487560-1-axelrasmussen@google.com>
Message-Id: <20210503180737.2487560-9-axelrasmussen@google.com>
Mime-Version: 1.0
References: <20210503180737.2487560-1-axelrasmussen@google.com>
X-Mailer: git-send-email 2.31.1.527.g47e6f16901-goog
Subject: [PATCH v6 08/10] userfaultfd/selftests: create alias mappings in the
 shmem test
From:   Axel Rasmussen <axelrasmussen@google.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Joe Perches <joe@perches.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Peter Xu <peterx@redhat.com>, Shaohua Li <shli@fb.com>,
        Shuah Khan <shuah@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Wang Qing <wangqing@vivo.com>
Cc:     linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, Axel Rasmussen <axelrasmussen@google.com>,
        Brian Geffon <bgeffon@google.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Mina Almasry <almasrymina@google.com>,
        Oliver Upton <oupton@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Previously, we just allocated two shm areas: area_src and area_dst. With
this commit, change this so we also allocate area_src_alias, and
area_dst_alias.

area_*_alias and area_* (respectively) point to the same underlying
physical pages, but are different VMAs. In a future commit in this
series, we'll leverage this setup to exercise minor fault handling
support for shmem, just like we do in the hugetlb_shared test.

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
---
 tools/testing/selftests/vm/userfaultfd.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/vm/userfaultfd.c b/tools/testing/selftests/vm/userfaultfd.c
index fc40831f818f..1f65c4ab7994 100644
--- a/tools/testing/selftests/vm/userfaultfd.c
+++ b/tools/testing/selftests/vm/userfaultfd.c
@@ -278,13 +278,29 @@ static void shmem_release_pages(char *rel_area)
 
 static void shmem_allocate_area(void **alloc_area)
 {
-	unsigned long offset =
-		alloc_area == (void **)&area_src ? 0 : nr_pages * page_size;
+	void *area_alias = NULL;
+	bool is_src = alloc_area == (void **)&area_src;
+	unsigned long offset = is_src ? 0 : nr_pages * page_size;
 
 	*alloc_area = mmap(NULL, nr_pages * page_size, PROT_READ | PROT_WRITE,
 			   MAP_SHARED, shm_fd, offset);
 	if (*alloc_area == MAP_FAILED)
 		err("mmap of memfd failed");
+
+	area_alias = mmap(NULL, nr_pages * page_size, PROT_READ | PROT_WRITE,
+			  MAP_SHARED, shm_fd, offset);
+	if (area_alias == MAP_FAILED)
+		err("mmap of memfd alias failed");
+
+	if (is_src)
+		area_src_alias = area_alias;
+	else
+		area_dst_alias = area_alias;
+}
+
+static void shmem_alias_mapping(__u64 *start, size_t len, unsigned long offset)
+{
+	*start = (unsigned long)area_dst_alias + offset;
 }
 
 struct uffd_test_ops {
@@ -314,7 +330,7 @@ static struct uffd_test_ops shmem_uffd_test_ops = {
 	.expected_ioctls = SHMEM_EXPECTED_IOCTLS,
 	.allocate_area	= shmem_allocate_area,
 	.release_pages	= shmem_release_pages,
-	.alias_mapping = noop_alias_mapping,
+	.alias_mapping = shmem_alias_mapping,
 };
 
 static struct uffd_test_ops hugetlb_uffd_test_ops = {
-- 
2.31.1.527.g47e6f16901-goog


Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3A053661EF
	for <lists+linux-api@lfdr.de>; Wed, 21 Apr 2021 00:08:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234303AbhDTWIz (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 20 Apr 2021 18:08:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234288AbhDTWIy (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 20 Apr 2021 18:08:54 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8713DC06138A
        for <linux-api@vger.kernel.org>; Tue, 20 Apr 2021 15:08:20 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id v3-20020a05690204c3b02904e65b70792dso13557480ybs.1
        for <linux-api@vger.kernel.org>; Tue, 20 Apr 2021 15:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=kyyFN9AtGZG7sxPS2jLvKjxCRLZ+illjJVxTiN8fbrw=;
        b=JMFOJKQD6VWL9XWjUHGhpO9LBqTgy+Ns6fTSXa2N2FAVemnw5VhmoB8JVGyLKXRMoP
         2G0wdlLBgdOhhK5YQ4CSnnXRozuBjZZcnXpkq6Q7qi9RjHZX57x01gxijHUwYLiy5CPv
         eZOhPdwcNIQDcKY4LVYGz9rmDpo3AI21KJqv2M2PFmKqLgMg0CFV1rH55+7lNFzi/hNG
         0aKGqwvkAagADR6EWdoAt9UMb2LAN8yei0RbDGmaJPGEn24BE7e20Y4iUGKusAy3Sk0A
         qVVk2k/ceUjOT+szFnzRtbQL0hxobpqxT/CVfwYY34M4ctoIWzzco4mrUAXOe1tEoLj9
         SM4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=kyyFN9AtGZG7sxPS2jLvKjxCRLZ+illjJVxTiN8fbrw=;
        b=MC2vKtyaSMCT7Q7DwlXS9a7XgKAsRQB9hWZ+Wj0gg1Q36SoiGbj1TCRFvG3nNWiGQp
         OjjtMwS3zLNKPGkDh4UKmMiMiESZAVNg5e04Ql8yk1yu52lNctbB/W0LKA3YPlmy5lh5
         /sCblMS7K0PucB72KMUP3/NEDQdmMUIkQw2PgtU+OkgRCBDJbiL42dbNnyfgHfGPYShe
         J/QCy2EmrSaT7X9NIqM3SXSDk6zbhMfhPRguWUpPG5XVynwy0e6Se4OwBCMzUpRtUZYt
         LCjl6OK5W45GVkrzilQOhYpbol6Ul0IjZjRHrp4ChCDWDBGSA2ld9NyY9emofPwpEsdf
         W4SQ==
X-Gm-Message-State: AOAM530xN8SgppLBdA7qFXSz7Ta9xpQcQmtzqSPjr473hF6DrCchL9fs
        H3cVVuoci7fUx7qGo1zIhpJK4fIkM6mmZXW93R6e
X-Google-Smtp-Source: ABdhPJzOQ0vCMNocHti08k8y48bjZn+N/2oUus8q+tA8xkgknLfFG8icRrTM906qaAXAFK5MEo2EA5AqfEAfnZrS1QUz
X-Received: from ajr0.svl.corp.google.com ([2620:15c:2cd:203:c40e:ee2c:2ab8:257a])
 (user=axelrasmussen job=sendgmr) by 2002:a25:ce41:: with SMTP id
 x62mr26398558ybe.402.1618956499844; Tue, 20 Apr 2021 15:08:19 -0700 (PDT)
Date:   Tue, 20 Apr 2021 15:08:00 -0700
In-Reply-To: <20210420220804.486803-1-axelrasmussen@google.com>
Message-Id: <20210420220804.486803-7-axelrasmussen@google.com>
Mime-Version: 1.0
References: <20210420220804.486803-1-axelrasmussen@google.com>
X-Mailer: git-send-email 2.31.1.368.gbe11c130af-goog
Subject: [PATCH v4 06/10] userfaultfd/selftests: create alias mappings in the
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
2.31.1.368.gbe11c130af-goog


Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E315371F5A
	for <lists+linux-api@lfdr.de>; Mon,  3 May 2021 20:09:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbhECSKp (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 3 May 2021 14:10:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232052AbhECSJF (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 3 May 2021 14:09:05 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D638C06135C
        for <linux-api@vger.kernel.org>; Mon,  3 May 2021 11:08:02 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id o5-20020ac872c50000b02901c32e7e3c21so1929551qtp.8
        for <linux-api@vger.kernel.org>; Mon, 03 May 2021 11:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ntouV34m2zzK96oVKUjz7Unp11YYIFITerKCQ/PICUo=;
        b=AabA9pNdVHR8wrAzCpx2+upbcMZBKVFarGpOoH4Xk/pMoNwzxHSVAVZbMSVw5xg+fw
         7/C+w4V3s83Qq2uRdOkxN3vqlsdzIJTWPCiLHlFYuFvXL216RqNGqAqQT0xJOz6rlGuu
         7jTjsObZhjLM6eIlBM9C+dl5P5tu+bZ7yF8CPjYkJgsyLmyOmSZt/dZwNN0GTnF+0lic
         isndnsawZBzxPFoBuMwYiCgrcK6McGt9MZZMQXBNufkSumKB5sbDo4c4tOQ7kxe0SLSh
         HO79/mVXzjgFKOxf0OVFfenBh5T/OvVrNJZfk777uxUhclay/uqQCEHduvlyoPcts/yn
         /ktA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ntouV34m2zzK96oVKUjz7Unp11YYIFITerKCQ/PICUo=;
        b=FlEGzr1KH7fAzd0EDVJ6JhBTZv5xVpHJb3sxSehMgqYmTg054ISj9fxmWfEa8pB8TI
         gxBPnhHYlFvmx60aDZXJLtJvjO2GN+1JyLS31oNyYBnknI43g3CHX2KtIgv6rMvRHOLg
         9s5uAaQPZPScuErMkdMe8b7yKC77VG3bp4tpyBBVGubKzSfsNFNxTcP0U+NfhFK/esRE
         lWG8nCanUCgtM3lDctEGVVqPoZ526zjxLdX2TffjDXyyWFJIgRHuBD5QuYzORWuLebeo
         Bolv6sMEYD45NVGMtSY6AofTjiuOOVvXre6PcKqWQ4pXnxpcZguBm+DZGuV7vF2cwYKM
         guyQ==
X-Gm-Message-State: AOAM532HZfgJuf2n4GwIj2pfvtR8pLZdRLUy2Llyt0SwoJQZBnYbDHSI
        XKQjyBW/oS+DD/sNocuNW4Cc3equogqqTneurE80
X-Google-Smtp-Source: ABdhPJwrhkcA07r1npaWCK9fxUqJ2Xw1p2+5ZZDXTYqOYqIOwOPfPfCd9E+z83gXUpu5S4gSaGrtBt+b+HU5WgQxVGvi
X-Received: from ajr0.svl.corp.google.com ([2620:15c:2cd:203:3d79:e69a:a4f9:ef0])
 (user=axelrasmussen job=sendgmr) by 2002:ad4:4f82:: with SMTP id
 em2mr20912806qvb.55.1620065281620; Mon, 03 May 2021 11:08:01 -0700 (PDT)
Date:   Mon,  3 May 2021 11:07:37 -0700
In-Reply-To: <20210503180737.2487560-1-axelrasmussen@google.com>
Message-Id: <20210503180737.2487560-11-axelrasmussen@google.com>
Mime-Version: 1.0
References: <20210503180737.2487560-1-axelrasmussen@google.com>
X-Mailer: git-send-email 2.31.1.527.g47e6f16901-goog
Subject: [PATCH v6 10/10] userfaultfd/selftests: exercise minor fault handling
 shmem support
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

Enable test_uffdio_minor for test_type == TEST_SHMEM, and modify the
test slightly to pass in / check for the right feature flags.

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
---
 tools/testing/selftests/vm/userfaultfd.c | 29 ++++++++++++++++++++----
 1 file changed, 25 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/vm/userfaultfd.c b/tools/testing/selftests/vm/userfaultfd.c
index 3fbc69f513dc..a7ecc9993439 100644
--- a/tools/testing/selftests/vm/userfaultfd.c
+++ b/tools/testing/selftests/vm/userfaultfd.c
@@ -474,6 +474,7 @@ static void wp_range(int ufd, __u64 start, __u64 len, bool wp)
 static void continue_range(int ufd, __u64 start, __u64 len)
 {
 	struct uffdio_continue req;
+	int ret;
 
 	req.range.start = start;
 	req.range.len = len;
@@ -482,6 +483,17 @@ static void continue_range(int ufd, __u64 start, __u64 len)
 	if (ioctl(ufd, UFFDIO_CONTINUE, &req))
 		err("UFFDIO_CONTINUE failed for address 0x%" PRIx64,
 		    (uint64_t)start);
+
+	/*
+	 * Error handling within the kernel for continue is subtly different
+	 * from copy or zeropage, so it may be a source of bugs. Trigger an
+	 * error (-EEXIST) on purpose, to verify doing so doesn't cause a BUG.
+	 */
+	req.mapped = 0;
+	ret = ioctl(ufd, UFFDIO_CONTINUE, &req);
+	if (ret >= 0 || req.mapped != -EEXIST)
+		err("failed to exercise UFFDIO_CONTINUE error handling, ret=%d, mapped=%" PRId64,
+		    ret, (int64_t) req.mapped);
 }
 
 static void *locking_thread(void *arg)
@@ -1182,7 +1194,7 @@ static int userfaultfd_minor_test(void)
 	void *expected_page;
 	char c;
 	struct uffd_stats stats = { 0 };
-	uint64_t features = UFFD_FEATURE_MINOR_HUGETLBFS;
+	uint64_t req_features, features_out;
 
 	if (!test_uffdio_minor)
 		return 0;
@@ -1190,9 +1202,17 @@ static int userfaultfd_minor_test(void)
 	printf("testing minor faults: ");
 	fflush(stdout);
 
-	uffd_test_ctx_init_ext(&features);
-	/* If kernel reports the feature isn't supported, skip the test. */
-	if (!(features & UFFD_FEATURE_MINOR_HUGETLBFS)) {
+	if (test_type == TEST_HUGETLB)
+		req_features = UFFD_FEATURE_MINOR_HUGETLBFS;
+	else if (test_type == TEST_SHMEM)
+		req_features = UFFD_FEATURE_MINOR_SHMEM;
+	else
+		return 1;
+
+	features_out = req_features;
+	uffd_test_ctx_init_ext(&features_out);
+	/* If kernel reports required features aren't supported, skip test. */
+	if ((features_out & req_features) != req_features) {
 		printf("skipping test due to lack of feature support\n");
 		fflush(stdout);
 		return 0;
@@ -1426,6 +1446,7 @@ static void set_test_type(const char *type)
 		map_shared = true;
 		test_type = TEST_SHMEM;
 		uffd_test_ops = &shmem_uffd_test_ops;
+		test_uffdio_minor = true;
 	} else {
 		err("Unknown test type: %s", type);
 	}
-- 
2.31.1.527.g47e6f16901-goog


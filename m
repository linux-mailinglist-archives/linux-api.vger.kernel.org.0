Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00A193661F0
	for <lists+linux-api@lfdr.de>; Wed, 21 Apr 2021 00:08:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233992AbhDTWI5 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 20 Apr 2021 18:08:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234282AbhDTWIx (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 20 Apr 2021 18:08:53 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6381C06138F
        for <linux-api@vger.kernel.org>; Tue, 20 Apr 2021 15:08:18 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id d89-20020a25a3620000b02904dc8d0450c6so13312700ybi.2
        for <linux-api@vger.kernel.org>; Tue, 20 Apr 2021 15:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=q0uullLY89k5tjNP5bU3tD7YqwSbU41Jf2SRzlEhX2Q=;
        b=sDY5fiUuvC0Rx6q5+VtW2pUXtXPN28Dpcq442NoR4o5Q7ncPbrml5nRuyZyd2xyYJO
         zduDulUJHI6EWSx9HKsTUErWdKEUuFYZr+xR9rJNfE/H6mkaRUzEAjms+9w6kvxskGj1
         Nur1rZu+ynGqrWgwuUXixlMLcKGLtjKwC07MFESZpxI3GRbWslF6J9bleAcqYL/P3N0L
         ZVDSqYoudAuN+pF5eP6HhajJbpFGdoc4dcwVz8YQcclCijhrbExCMgqfkGczNNfmjgwI
         IH7UY9zoBuqr4U01GJqpSd7amvWJNhrFWpBlHU26toc+qlCBox4xow+ryia3+5CyH0zV
         a8lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=q0uullLY89k5tjNP5bU3tD7YqwSbU41Jf2SRzlEhX2Q=;
        b=OwoRijetESSJWseJC22oBfvP4GyPMAfXjz2rB6sSF8ExVPk8W/Z6aOcRBI4a7A2o4V
         a3hDPCqGDfT01QEnL6NjNaUW6yN0K3qEaa8VSr2rBr/XR1ucu6sFUzwjhNVrjbmU9n6F
         b+tmGsvJLwl7NqI0vLzPXifwP6xqCqGUkU2YtuJPW/zN/UrG/KQRoWKO9g04feohx3Pw
         mVqZAqeFH5hRjqX1aH68Geg5VF6wC8h+hU5AI2NzJTLM3B1liLafu3hXyCc9sHC18MPB
         0EkqFS5hSoqN+b7F7ju3n00WHbRtG2ONFUVXxtNeiGJO8DY8V2KD9b/RiZIwMYacEQr6
         6QiQ==
X-Gm-Message-State: AOAM530FaBRCRzzq3phML2BGjIH++QjBgKtStXcZOGwkx3w5UUZOj57K
        /9wP/5CKSjo+tApK++qA7B1Z1CgiYNbAmOJx6fkg
X-Google-Smtp-Source: ABdhPJyA40/+Xy2TbPk+Aikm9mHvgdzpsA+t59tWYmD21etDLRSCFrGCxDix1NluigV9XQ6hkCLRuykY3gFHdMw/G/jI
X-Received: from ajr0.svl.corp.google.com ([2620:15c:2cd:203:c40e:ee2c:2ab8:257a])
 (user=axelrasmussen job=sendgmr) by 2002:a25:b983:: with SMTP id
 r3mr28386146ybg.238.1618956497914; Tue, 20 Apr 2021 15:08:17 -0700 (PDT)
Date:   Tue, 20 Apr 2021 15:07:59 -0700
In-Reply-To: <20210420220804.486803-1-axelrasmussen@google.com>
Message-Id: <20210420220804.486803-6-axelrasmussen@google.com>
Mime-Version: 1.0
References: <20210420220804.486803-1-axelrasmussen@google.com>
X-Mailer: git-send-email 2.31.1.368.gbe11c130af-goog
Subject: [PATCH v4 05/10] userfaultfd/selftests: use memfd_create for shmem
 test type
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

This is a preparatory commit. In the future, we want to be able to setup
alias mappings for area_src and area_dst in the shmem test, like we do
in the hugetlb_shared test. With a VMA obtained via
mmap(MAP_ANONYMOUS | MAP_SHARED), it isn't clear how to do this.

So, mmap() with an fd, so we can create alias mappings. Use memfd_create
instead of actually passing in a tmpfs path like hugetlb does, since
it's more convenient / simpler to run, and works just as well.

Future commits will:

1. Setup the alias mappings.
2. Extend our tests to actually take advantage of this, to test new
   userfaultfd behavior being introduced in this series.

Also, a small fix in the area we're changing: when the hugetlb setup
fails in main(), pass in the right argv[] so we actually print out the
hugetlb file path.

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
---
 tools/testing/selftests/vm/userfaultfd.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/vm/userfaultfd.c b/tools/testing/selftests/vm/userfaultfd.c
index 6339aeaeeff8..fc40831f818f 100644
--- a/tools/testing/selftests/vm/userfaultfd.c
+++ b/tools/testing/selftests/vm/userfaultfd.c
@@ -85,6 +85,7 @@ static bool test_uffdio_wp = false;
 static bool test_uffdio_minor = false;
 
 static bool map_shared;
+static int shm_fd;
 static int huge_fd;
 static char *huge_fd_off0;
 static unsigned long long *count_verify;
@@ -277,8 +278,11 @@ static void shmem_release_pages(char *rel_area)
 
 static void shmem_allocate_area(void **alloc_area)
 {
+	unsigned long offset =
+		alloc_area == (void **)&area_src ? 0 : nr_pages * page_size;
+
 	*alloc_area = mmap(NULL, nr_pages * page_size, PROT_READ | PROT_WRITE,
-			   MAP_ANONYMOUS | MAP_SHARED, -1, 0);
+			   MAP_SHARED, shm_fd, offset);
 	if (*alloc_area == MAP_FAILED)
 		err("mmap of memfd failed");
 }
@@ -1448,6 +1452,16 @@ int main(int argc, char **argv)
 			err("Open of %s failed", argv[4]);
 		if (ftruncate(huge_fd, 0))
 			err("ftruncate %s to size 0 failed", argv[4]);
+	} else if (test_type == TEST_SHMEM) {
+		shm_fd = memfd_create(argv[0], 0);
+		if (shm_fd < 0)
+			err("memfd_create");
+		if (ftruncate(shm_fd, nr_pages * page_size * 2))
+			err("ftruncate");
+		if (fallocate(shm_fd,
+			      FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE, 0,
+			      nr_pages * page_size * 2))
+			err("fallocate");
 	}
 	printf("nr_pages: %lu, nr_pages_per_cpu: %lu\n",
 	       nr_pages, nr_pages_per_cpu);
-- 
2.31.1.368.gbe11c130af-goog


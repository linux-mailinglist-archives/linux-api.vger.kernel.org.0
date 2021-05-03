Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A49E371F45
	for <lists+linux-api@lfdr.de>; Mon,  3 May 2021 20:08:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231537AbhECSJP (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 3 May 2021 14:09:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232000AbhECSJB (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 3 May 2021 14:09:01 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEC43C061761
        for <linux-api@vger.kernel.org>; Mon,  3 May 2021 11:07:56 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id t10-20020a25780a0000b02904f62bfcc4ccso8118092ybc.23
        for <linux-api@vger.kernel.org>; Mon, 03 May 2021 11:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Xac2BuhJWUqyH5WnNjzkjLemK7LFrvUwXp8Wxy1Y0Zs=;
        b=Dp+eYm9V8pZWxqVn9dwHTmOQieeOZFLVSfiZ0cB8hyg/Se1Z0xBe3ZybxDqks2XPjY
         8UY79cMWP+Hjxb01Sw3pTvJ0KocvdaAW7w+lNbr++xYwJ3LBdxqsDvl37hdnwhLcIGkJ
         W901lPAsz24G6F3civKoUw7LlPZyZE85p3LpdSnc9T3I282uaYSz2ZaClGGV2NIuxODx
         s6C6PVVd5L6Y6Fywsuts+SizzKGyGBRgg8Bg2r5IrRM7rkaSxYjci6FH5h1vsPuNYT9G
         a4eaJbsGTfQJyzntteD/+XhOxllNr9eCBVCRyBiHKxy+a0MoZTknH98spga/D0k1x2a7
         VbNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Xac2BuhJWUqyH5WnNjzkjLemK7LFrvUwXp8Wxy1Y0Zs=;
        b=siV8uHqHecrQQHxXGSNBWNl6ZA3qhZgfK5N8nLy7bz2cW6CMYQYNN6w1R/tVH98B+q
         b5ZbfXmKTZDiPlTwtGADukXa3+07X1Qy1h8+yb2SO7ElhvznLJUUboHbqWQRlsFAFNoY
         0o2fJMaLxMcllW5TMt/KJWlasfMwDZzEcIxIpf7VFSlsZx/9IaHbngXaI4AAPjJGKXN/
         c3yksBm8rVNxUZ8ry0BQX+iTOc3Oktne1ORNjwCOg725ChxTgeJ/KRLjbd9xGHt4O7HI
         yY7zjs9v1BTuXmuE1gbaUCfOPN30dHglSmcLujxzdHh0DKacgOiJqjgbQKShh5UFll3O
         nP6w==
X-Gm-Message-State: AOAM533eyadB+v06H3G4h+T76Jod2J59bNWuivrMPKsALDmvZh1fM+9X
        RBGoOQ1Oy4XyJ8xWEFXRngeSB3Hj+si/liSHwTZG
X-Google-Smtp-Source: ABdhPJx+jXbiz0zAjVjFU2FT4iWpi3DJuyrx4MPp0buQPJJtAqRHzn6LRuVX4gpKOL6VG9z3xIXvY7lqv2L1UxWsKKT+
X-Received: from ajr0.svl.corp.google.com ([2620:15c:2cd:203:3d79:e69a:a4f9:ef0])
 (user=axelrasmussen job=sendgmr) by 2002:a05:6902:4ab:: with SMTP id
 r11mr29737692ybs.70.1620065276077; Mon, 03 May 2021 11:07:56 -0700 (PDT)
Date:   Mon,  3 May 2021 11:07:34 -0700
In-Reply-To: <20210503180737.2487560-1-axelrasmussen@google.com>
Message-Id: <20210503180737.2487560-8-axelrasmussen@google.com>
Mime-Version: 1.0
References: <20210503180737.2487560-1-axelrasmussen@google.com>
X-Mailer: git-send-email 2.31.1.527.g47e6f16901-goog
Subject: [PATCH v6 07/10] userfaultfd/selftests: use memfd_create for shmem
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
2.31.1.527.g47e6f16901-goog


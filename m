Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 809DF162CF4
	for <lists+linux-api@lfdr.de>; Tue, 18 Feb 2020 18:32:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbgBRRc3 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 18 Feb 2020 12:32:29 -0500
Received: from mail-pj1-f74.google.com ([209.85.216.74]:59109 "EHLO
        mail-pj1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726783AbgBRRc2 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 18 Feb 2020 12:32:28 -0500
Received: by mail-pj1-f74.google.com with SMTP id ie20so474209pjb.8
        for <linux-api@vger.kernel.org>; Tue, 18 Feb 2020 09:32:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=2uoNUUGtHwnITLt2DMb1JQQT22YDWW1bocfB8RTH9Fw=;
        b=dVsc5heFCl4J22LEz6upTHD2gNOjl3TlZgwD22VL9ixDYsOL6JUZ9RD9dhwsF5kIeB
         MsqvJwF9oGLPLQlNNT/pK6+DZTC4+Z2NdosRBWdj9xOsMyRbamJJWqkA9jglaBaVtY2X
         TqUkxrRksMbhgh0elbm1yUgQGiTnztygwoaEVOg4cYeqNQ2svZdOxYAdqNDRowKKadlN
         bo54zVRxWanbCYms9m8LGYR0TfIKpaZB9IEmFbjayqKuNJRA/b48ZcCN58kKLDh6uUEg
         +WzWQsqF4q0wjQqAOBXRXpXvoXUvZUgICyQckiRyV9o8ytGRvdiAqCzy6D0gsHx6+Uj9
         nf1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=2uoNUUGtHwnITLt2DMb1JQQT22YDWW1bocfB8RTH9Fw=;
        b=XSU7T/AGL9rEoBWRQlI3dq8ngu2tbCo0fU35jXGZsGhmut71zXfDou58ssXZp3M7Kt
         LZ49IpRMu3UVZnaFe8KUf/Bt0IO8RQGTN72Ww/msSUBVXv4DX+aTLH2ID8MKbKFlNKRd
         56+m8rLQu7ie7A9mIPo7Hd0sc5HFyCLuAVgIkEwIESMkbvZzjMZIdswcaHufYAlrk7gD
         ev+ifioVw5S+pIx+OfjNrxD4rWEJBpdAVfiOFu6PuhzW8pt6SrHEkU5rL9dnxgmx8arR
         kZvLVUUnderZpjvaCPmTjzNlwcU+fexjjMmc6lIgPkl06VLK1rdplNRWE4hXUEONLAUT
         VWrw==
X-Gm-Message-State: APjAAAXNHJOw9r+QE2e6kEknHUlleHPv4o559mwo6+aOeHExroRGwZlM
        l1YXhozVObpDxaz/pq/o0z+ss5hy+LOZ
X-Google-Smtp-Source: APXvYqzmdJV0euZbN5r9fOn9hcRMubD/PJBZubsR4EFkjREC7iKjmkdXyQeZAkpooEGfBe8piptVijirdm9d
X-Received: by 2002:a63:4d8:: with SMTP id 207mr23985494pge.269.1582047147663;
 Tue, 18 Feb 2020 09:32:27 -0800 (PST)
Date:   Tue, 18 Feb 2020 09:32:21 -0800
In-Reply-To: <20200218173221.237674-1-bgeffon@google.com>
Message-Id: <20200218173221.237674-2-bgeffon@google.com>
Mime-Version: 1.0
References: <20200218173221.237674-1-bgeffon@google.com>
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
Subject: [PATCH v6 2/2] selftest: Add MREMAP_DONTUNMAP selftest.
From:   Brian Geffon <bgeffon@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Michael S . Tsirkin" <mst@redhat.com>,
        Brian Geffon <bgeffon@google.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-api@vger.kernel.org,
        Andy Lutomirski <luto@amacapital.net>,
        Will Deacon <will@kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Sonny Rao <sonnyrao@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Yu Zhao <yuzhao@google.com>,
        Jesse Barnes <jsbarnes@google.com>,
        Florian Weimer <fweimer@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Add a few simple self tests for the new flag MREMAP_DONTUNMAP,
they are simple smoke tests which also demonstrate the behavior.

Signed-off-by: Brian Geffon <bgeffon@google.com>
---
 tools/testing/selftests/vm/Makefile           |   1 +
 tools/testing/selftests/vm/mremap_dontunmap.c | 326 ++++++++++++++++++
 tools/testing/selftests/vm/run_vmtests        |  15 +
 3 files changed, 342 insertions(+)
 create mode 100644 tools/testing/selftests/vm/mremap_dontunmap.c

diff --git a/tools/testing/selftests/vm/Makefile b/tools/testing/selftests/vm/Makefile
index 9534dc2bc929..4b2b969fc3c7 100644
--- a/tools/testing/selftests/vm/Makefile
+++ b/tools/testing/selftests/vm/Makefile
@@ -12,6 +12,7 @@ TEST_GEN_FILES += map_fixed_noreplace
 TEST_GEN_FILES += map_populate
 TEST_GEN_FILES += mlock-random-test
 TEST_GEN_FILES += mlock2-tests
+TEST_GEN_FILES += mremap_dontunmap
 TEST_GEN_FILES += on-fault-limit
 TEST_GEN_FILES += thuge-gen
 TEST_GEN_FILES += transhuge-stress
diff --git a/tools/testing/selftests/vm/mremap_dontunmap.c b/tools/testing/selftests/vm/mremap_dontunmap.c
new file mode 100644
index 000000000000..de2a861c7c6d
--- /dev/null
+++ b/tools/testing/selftests/vm/mremap_dontunmap.c
@@ -0,0 +1,326 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Tests for mremap w/ MREMAP_DONTUNMAP.
+ *
+ * Copyright 2020, Brian Geffon <bgeffon@google.com>
+ */
+#define _GNU_SOURCE
+#include <sys/mman.h>
+#include <errno.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <stdlib.h>
+#include <unistd.h>
+
+#include "../kselftest.h"
+
+#ifndef MREMAP_DONTUNMAP
+#define MREMAP_DONTUNMAP 4
+#endif
+
+unsigned long page_size;
+char *page_buffer;
+
+static void dump_maps(void)
+{
+        char cmd[32];
+
+        snprintf(cmd, sizeof(cmd), "cat /proc/%d/maps", getpid());
+        system(cmd);
+}
+
+#define BUG_ON(condition, description)					      \
+	do {								      \
+		if (condition) {					      \
+			fprintf(stderr, "[FAIL]\t%s():%d\t%s:%s\n", __func__, \
+				__LINE__, (description), strerror(errno));    \
+			dump_maps();                                          \
+			exit(1);					      \
+		} 							      \
+	} while (0)
+
+// Try a simple operation for to "test" for kernel support this prevents
+// reporting tests as failed when it's run on an older kernel.
+static int kernel_support_for_mremap_dontunmap()
+{
+        int ret = 0;
+        unsigned long num_pages = 1;
+        void *source_mapping = mmap(NULL, num_pages * page_size, PROT_NONE,
+                                    MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+        BUG_ON(source_mapping == MAP_FAILED, "mmap");
+
+        // This simple remap should only fail if MREMAP_DONTUNMAP isn't
+        // supported.
+        void *dest_mapping =
+            mremap(source_mapping, num_pages * page_size, num_pages * page_size,
+                   MREMAP_DONTUNMAP | MREMAP_MAYMOVE, 0);
+        if (dest_mapping == MAP_FAILED) {
+                ret = errno;
+        } else {
+                BUG_ON(munmap(dest_mapping, num_pages * page_size) == -1,
+                       "unable to unmap destination mapping");
+        }
+
+        BUG_ON(munmap(source_mapping, num_pages * page_size) == -1,
+               "unable to unmap source mapping");
+        return ret;
+}
+
+// This helper will just validate that an entire mapping contains the expected
+// byte.
+static int check_region_contains_byte(void *addr, unsigned long size, char byte)
+{
+        BUG_ON(size & (page_size - 1),
+               "check_region_contains_byte expects page multiples");
+        BUG_ON((unsigned long)addr & (page_size - 1),
+               "check_region_contains_byte expects page alignment");
+
+        memset(page_buffer, byte, page_size);
+
+        unsigned long num_pages = size / page_size;
+        unsigned long i;
+
+        // Compare each page checking that it contains our expected byte.
+        for (i = 0; i < num_pages; ++i) {
+                int ret =
+                    memcmp(addr + (i * page_size), page_buffer, page_size);
+                if (ret) {
+                        return ret;
+                }
+        }
+
+        return 0;
+}
+
+// this test validates that MREMAP_DONTUNMAP moves the pagetables while leaving
+// the source mapping mapped.
+static void mremap_dontunmap_simple()
+{
+        unsigned long num_pages = 5;
+
+        void *source_mapping =
+            mmap(NULL, num_pages * page_size, PROT_READ | PROT_WRITE,
+                 MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+        BUG_ON(source_mapping == MAP_FAILED, "mmap");
+
+        memset(source_mapping, 'a', num_pages * page_size);
+
+        // Try to just move the whole mapping anywhere (not fixed).
+        void *dest_mapping =
+            mremap(source_mapping, num_pages * page_size, num_pages * page_size,
+                   MREMAP_DONTUNMAP | MREMAP_MAYMOVE, NULL);
+        BUG_ON(dest_mapping == MAP_FAILED, "mremap");
+
+        // Validate that the pages have been moved, we know they were moved if
+        // the dest_mapping contains a's.
+        BUG_ON(check_region_contains_byte
+               (dest_mapping, num_pages * page_size, 'a') != 0,
+               "pages did not migrate");
+        BUG_ON(check_region_contains_byte
+               (source_mapping, num_pages * page_size, 0) != 0,
+               "source should have no ptes");
+
+        BUG_ON(munmap(dest_mapping, num_pages * page_size) == -1,
+               "unable to unmap destination mapping");
+        BUG_ON(munmap(source_mapping, num_pages * page_size) == -1,
+               "unable to unmap source mapping");
+}
+
+// This test validates MREMAP_DONTUNMAP will move page tables to a specific
+// destination using MREMAP_FIXED, also while validating that the source
+// remains intact.
+static void mremap_dontunmap_simple_fixed()
+{
+        unsigned long num_pages = 5;
+
+        // Since we want to guarantee that we can remap to a point, we will
+        // create a mapping up front.
+        void *dest_mapping =
+            mmap(NULL, num_pages * page_size, PROT_READ | PROT_WRITE,
+                 MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+        BUG_ON(dest_mapping == MAP_FAILED, "mmap");
+        memset(dest_mapping, 'X', num_pages * page_size);
+
+        void *source_mapping =
+            mmap(NULL, num_pages * page_size, PROT_READ | PROT_WRITE,
+                 MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+        BUG_ON(source_mapping == MAP_FAILED, "mmap");
+        memset(source_mapping, 'a', num_pages * page_size);
+
+        void *remapped_mapping =
+            mremap(source_mapping, num_pages * page_size, num_pages * page_size,
+                   MREMAP_FIXED | MREMAP_DONTUNMAP | MREMAP_MAYMOVE,
+                   dest_mapping);
+        BUG_ON(remapped_mapping == MAP_FAILED, "mremap");
+        BUG_ON(remapped_mapping != dest_mapping,
+               "mremap should have placed the remapped mapping at dest_mapping");
+
+        // The dest mapping will have been unmap by mremap so we expect the Xs
+        // to be gone and replaced with a's.
+        BUG_ON(check_region_contains_byte
+               (dest_mapping, num_pages * page_size, 'a') != 0,
+               "pages did not migrate");
+
+        // And the source mapping will have had its ptes dropped.
+        BUG_ON(check_region_contains_byte
+               (source_mapping, num_pages * page_size, 0) != 0,
+               "source should have no ptes");
+
+        BUG_ON(munmap(dest_mapping, num_pages * page_size) == -1,
+               "unable to unmap destination mapping");
+        BUG_ON(munmap(source_mapping, num_pages * page_size) == -1,
+               "unable to unmap source mapping");
+}
+
+// This test validates that we can MREMAP_DONTUNMAP for a portion of an
+// existing mapping.
+static void mremap_dontunmap_partial_mapping()
+{
+        /*
+         *  source mapping:
+         *  --------------
+         *  | aaaaaaaaaa |
+         *  --------------
+         *  to become:
+         *  --------------
+         *  | aaaaa00000 |
+         *  --------------
+         *  With the destination mapping containing 5 pages of As.
+         *  ---------
+         *  | aaaaa |
+         *  ---------
+         */
+        unsigned long num_pages = 10;
+        void *source_mapping =
+            mmap(NULL, num_pages * page_size, PROT_READ | PROT_WRITE,
+                 MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+        BUG_ON(source_mapping == MAP_FAILED, "mmap");
+        memset(source_mapping, 'a', num_pages * page_size);
+
+        // We will grab the last 5 pages of the source and move them.
+        void *dest_mapping =
+            mremap(source_mapping + (5 * page_size), 5 * page_size,
+                   5 * page_size,
+                   MREMAP_DONTUNMAP | MREMAP_MAYMOVE, NULL);
+        BUG_ON(dest_mapping == MAP_FAILED, "mremap");
+
+        // We expect the first 5 pages of the source to contain a's and the
+        // final 5 pages to contain zeros.
+        BUG_ON(check_region_contains_byte(source_mapping, 5 * page_size, 'a') !=
+               0, "first 5 pages of source should have original pages");
+        BUG_ON(check_region_contains_byte
+               (source_mapping + (5 * page_size), 5 * page_size, 0) != 0,
+               "final 5 pages of source should have no ptes");
+
+        // Finally we expect the destination to have 5 pages worth of a's.
+        BUG_ON(check_region_contains_byte(dest_mapping, 5 * page_size, 'a') !=
+               0, "dest mapping should contain ptes from the source");
+
+        BUG_ON(munmap(dest_mapping, 5 * page_size) == -1,
+               "unable to unmap destination mapping");
+        BUG_ON(munmap(source_mapping, num_pages * page_size) == -1,
+               "unable to unmap source mapping");
+}
+
+// This test validates that we can shrink an existing mapping via the normal
+// mremap behavior along with the MREMAP_DONTUNMAP flag.
+static void mremap_dontunmap_shrink_mapping()
+{
+        /*
+         * We shrink the source by 5 pages while remapping.
+         *  source mapping:
+         *  --------------
+         *  | aaaaaaaaaa |
+         *  --------------
+         *  to become:
+         *  ---------
+         *  | 00000 |
+         *  ---------
+         *  With the destination mapping containing 5 pages of As followed by
+         *  the original pages of Xs.
+         *  --------------
+         *  | aaaaaXXXXX |
+         *  --------------
+         */
+
+        unsigned long num_pages = 10;
+
+        // We use MREMAP_FIXED because we don't want the mremap to place the
+        // remapped mapping behind the source, if it did
+        // we wouldn't be able to validate that the mapping was in fact
+        // adjusted.
+        void *dest_mapping =
+            mmap(NULL, num_pages * page_size, PROT_READ | PROT_WRITE,
+                 MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+        BUG_ON(dest_mapping == MAP_FAILED, "mmap");
+        memset(dest_mapping, 'X', num_pages * page_size);
+
+        void *source_mapping =
+            mmap(NULL, num_pages * page_size, PROT_READ | PROT_WRITE,
+                 MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+        BUG_ON(source_mapping == MAP_FAILED, "mmap");
+        memset(source_mapping, 'a', num_pages * page_size);
+
+        // We are shrinking the mapping while also using MREMAP_DONTUNMAP
+        void *remapped_mapping =
+            mremap(source_mapping, num_pages * page_size, 5 * page_size,
+                   MREMAP_FIXED | MREMAP_DONTUNMAP | MREMAP_MAYMOVE,
+                   dest_mapping);
+        BUG_ON(remapped_mapping == MAP_FAILED, "mremap");
+        BUG_ON(remapped_mapping != dest_mapping,
+               "expected mremap to place mapping at dest");
+
+        // The last 5 pages of source should have become unmapped while the
+        // first 5 remain.
+        unsigned char buf[5];
+        int ret = mincore(source_mapping + (5 * page_size), 5 * page_size, buf);
+        BUG_ON((ret != -1 || (ret == -1 && errno != ENOMEM)),
+               "we expect -ENOMEM from mincore.");
+
+        BUG_ON(check_region_contains_byte(source_mapping, 5 * page_size, 0) !=
+               0, "source should have no ptes");
+        BUG_ON(check_region_contains_byte(dest_mapping, 5 * page_size, 'a') !=
+               0, "dest mapping should contain ptes from the source");
+
+        // And the second half of the destination should be unchanged.
+        BUG_ON(check_region_contains_byte(dest_mapping + (5 * page_size),
+                                          5 * page_size, 'X') != 0,
+               "second half of dest shouldn't be touched");
+
+        // Cleanup
+        BUG_ON(munmap(dest_mapping, num_pages * page_size) == -1,
+               "unable to unmap destination mapping");
+        BUG_ON(munmap(source_mapping, 5 * page_size) == -1,
+               "unable to unmap source mapping");
+}
+
+int main(void)
+{
+        page_size = sysconf(_SC_PAGE_SIZE);
+
+        // test for kernel support for MREMAP_DONTUNMAP skipping the test if
+        // not.
+        if (kernel_support_for_mremap_dontunmap() != 0) {
+		printf("No kernel support for MREMAP_DONTUNMAP\n");
+		return KSFT_SKIP;
+	}
+
+        // Keep a page sized buffer around for when we need it.
+        page_buffer =
+            mmap(NULL, page_size, PROT_READ | PROT_WRITE,
+                 MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+        BUG_ON(page_buffer == MAP_FAILED, "unable to mmap a page.");
+
+        mremap_dontunmap_simple();
+        mremap_dontunmap_simple_fixed();
+        mremap_dontunmap_partial_mapping();
+        mremap_dontunmap_shrink_mapping();
+
+        BUG_ON(munmap(page_buffer, page_size) == -1,
+               "unable to unmap page buffer");
+
+        printf("OK\n");
+        return 0;
+}
diff --git a/tools/testing/selftests/vm/run_vmtests b/tools/testing/selftests/vm/run_vmtests
index 951c507a27f7..d380b95c5de5 100755
--- a/tools/testing/selftests/vm/run_vmtests
+++ b/tools/testing/selftests/vm/run_vmtests
@@ -227,4 +227,19 @@ else
 	exitcode=1
 fi
 
+echo "------------------------------------"
+echo "running MREMAP_DONTUNMAP smoke test"
+echo "------------------------------------"
+./mremap_dontunmap
+ret_val=$?
+
+if [ $ret_val -eq 0 ]; then
+	echo "[PASS]"
+elif [ $ret_val -eq $ksft_skip ]; then
+	 echo "[SKIP]"
+	 exitcode=$ksft_skip
+else
+	echo "[FAIL]"
+	exitcode=1
+fi
 exit $exitcode
-- 
2.25.0.265.gbab2e86ba0-goog


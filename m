Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A72BB15D0EC
	for <lists+linux-api@lfdr.de>; Fri, 14 Feb 2020 05:10:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728621AbgBNEKi (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 13 Feb 2020 23:10:38 -0500
Received: from mail-ua1-f73.google.com ([209.85.222.73]:46954 "EHLO
        mail-ua1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728416AbgBNEKi (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 13 Feb 2020 23:10:38 -0500
Received: by mail-ua1-f73.google.com with SMTP id 107so2044297uau.13
        for <linux-api@vger.kernel.org>; Thu, 13 Feb 2020 20:10:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=2uoNUUGtHwnITLt2DMb1JQQT22YDWW1bocfB8RTH9Fw=;
        b=LQPVFDje4iIkzs/Lq0cNUS+xTINGSTgVULCElCh14tLPD2INxCJgjei1vspVBaASzc
         SNvStdSwbZHxBn9lokVpawwO/wQYX96pM0XptK3rG94rH8GSzWDQETZ5vx6BxXjFOI94
         mF6mjr/L1Hop7uop0gby+4xGRz0rXQGcFmb1T6sELlHiQQRrZvO7osvNUuCtj3oBOz9A
         Jslh6nUYoKu5+/57XX62hH5IYioZBtV0Ds/zIl5qaTMp9CII8H7XfKf3KWQyC1HWgI33
         0x5LGgag6SOYQOCN8MCorkurk+8dmPR4pewBKH2QD9hxq74tVaJVqY7KipQc5zM+lw3a
         xX+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=2uoNUUGtHwnITLt2DMb1JQQT22YDWW1bocfB8RTH9Fw=;
        b=YlXQ2MoMkWulMbljcdZ3TVdz9QDOz2nLj3TPGi/R9dhOQHTJA9U25PD+rlOXKthCTH
         rTD5fSxiBM0c5Gs3GQUZCKr/eOxjdlXr1Ej16jrgJMgH8UJKk7ub0y8GCQvrOFRSUSTj
         KL3MCsWNS05ZASW5U/jeR/zqwCz6Ax2yjtroGU4C7IHYgWHshU52A1VfsUwfj64Z2j61
         i4omMSiPGkSRK19w45pVtQyb8qH+dkcjGUh2HKo2tWEqkujK87lhamobUQn/UdDOIoeV
         qSFy+n3Hv/3+J3zS27v5+c65mpzD20Q1ZLp14CYXqs0V04foflKbCt2ML6LYamyO9OL0
         dPmQ==
X-Gm-Message-State: APjAAAX/XNmHaqhdrnAc0TkNQq8foKJu9XanfSquwXf4DHoNRbkm0NJm
        RfS/fLyRGC5fkV/QoKq+KWOyDkuDAOWv
X-Google-Smtp-Source: APXvYqwsH7G0kvl5P2gwLIJaneCn1/p4BLpgvi86EadxVGGeuN+Um7Lvo0ziXTBjXF+U0dp2mijCA+5q7ug2
X-Received: by 2002:ab0:248a:: with SMTP id i10mr590373uan.108.1581653435831;
 Thu, 13 Feb 2020 20:10:35 -0800 (PST)
Date:   Thu, 13 Feb 2020 20:09:52 -0800
In-Reply-To: <20200214040952.43195-1-bgeffon@google.com>
Message-Id: <20200214040952.43195-2-bgeffon@google.com>
Mime-Version: 1.0
References: <20200207201856.46070-1-bgeffon@google.com> <20200214040952.43195-1-bgeffon@google.com>
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
Subject: [PATCH v5 2/2] selftest: Add MREMAP_DONTUNMAP selftest.
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
        Nathan Chancellor <natechancellor@gmail.com>,
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


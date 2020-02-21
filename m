Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C9BC168542
	for <lists+linux-api@lfdr.de>; Fri, 21 Feb 2020 18:42:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728842AbgBURmz (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 21 Feb 2020 12:42:55 -0500
Received: from mail-pl1-f202.google.com ([209.85.214.202]:54468 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726342AbgBURmz (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 21 Feb 2020 12:42:55 -0500
Received: by mail-pl1-f202.google.com with SMTP id v16so1515790ply.21
        for <linux-api@vger.kernel.org>; Fri, 21 Feb 2020 09:42:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=mMN2AJ2iVZyAfP6/cmGGBfcy1GqdY+F7I2vUH989Hak=;
        b=vbF7GVSLa2GKvEaaLuBD1ulkJQbljqLLevyQMZ41z2dvTatk7+XWBYOdsVrYkoUXfB
         tMxdUtlrwGB+GR+Yukyqd60lgptMIpPOuyPaYMUkELqiUOqreC8BOeC7cA38/NGrpMZB
         uoy3kOeInfk+obXYHfcsniPTB9oj4NzW8BfqvhBdKIfr+zsNfZfsk3mxnLDitFurYfSJ
         4XSpfobL8p3pJjgwYaHxdhMhqrHJIErNWXQchxIQtb5gtUOqXcHYbjkOsEEG8fcQQ6oi
         ZicJYGqTrv9e0pp66CCfvWIJlA+N/UOtbAl3McnHUNCgfORT8zATiW2Oe+rchvcc43M5
         2HkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=mMN2AJ2iVZyAfP6/cmGGBfcy1GqdY+F7I2vUH989Hak=;
        b=VLQSZRON1YvI9nqSY31+Y1xaEnTWYFocInbHMAqSYYYvZhxwaVmBiH863apKWn7XCp
         0Uc44At364atcaiKbk1OAPxeWoQX2G+z7JGQkPTGINZ59MeFeJIuZC9uD+lqbHksD3Fn
         OcP4AvL+54RfFTf1MyAHbtJ5hTxu7Wi5Cf+kZjF+ZyNvrdWN1EluZfPRR08y2QXlFTle
         hatwOb9SZ2PAopsKh9ZpCYg5aNeOiM3ozKFNuQhklBfBC3flD9jhM9CzbrXv9WEUhgw6
         DYSZKk5tn74z8Z3YbYA/XKM/p7rQgCr994PICGoTLjn3/VjjsThcjaqJbLRoUQQLbASp
         PX1g==
X-Gm-Message-State: APjAAAVVdV+YPEUcVDRxeOTttkda2VhFVkW2KZetU9wCij0LeT0GAQ3y
        2Mj5QQuJN6V+KT4nKvY8zhawJhc7W+C6
X-Google-Smtp-Source: APXvYqwk3sLiB1JWwEJHOu+U1s/5JDlU6kI4s7NhCkFnx9h6ZfyvKC8HTZzgYjwIdDSUlM0AhDZzlQ48xHcg
X-Received: by 2002:a63:d49:: with SMTP id 9mr38311175pgn.249.1582306974264;
 Fri, 21 Feb 2020 09:42:54 -0800 (PST)
Date:   Fri, 21 Feb 2020 09:42:47 -0800
In-Reply-To: <20200221174248.244748-1-bgeffon@google.com>
Message-Id: <20200221174248.244748-2-bgeffon@google.com>
Mime-Version: 1.0
References: <20200221174248.244748-1-bgeffon@google.com>
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
Subject: [PATCH v7 2/2] selftest: Add MREMAP_DONTUNMAP selftest.
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
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        mtk.manpages@gmail.com, linux-man@vger.kernel.org
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
 tools/testing/selftests/vm/mremap_dontunmap.c | 313 ++++++++++++++++++
 tools/testing/selftests/vm/run_vmtests        |  15 +
 3 files changed, 329 insertions(+)
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
index 000000000000..23240ee1e384
--- /dev/null
+++ b/tools/testing/selftests/vm/mremap_dontunmap.c
@@ -0,0 +1,313 @@
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
+	char cmd[32];
+
+	snprintf(cmd, sizeof(cmd), "cat /proc/%d/maps", getpid());
+	system(cmd);
+}
+
+#define BUG_ON(condition, description)					      \
+	do {								      \
+		if (condition) {					      \
+			fprintf(stderr, "[FAIL]\t%s():%d\t%s:%s\n", __func__, \
+				__LINE__, (description), strerror(errno));    \
+			dump_maps();					  \
+			exit(1);					      \
+		} 							      \
+	} while (0)
+
+// Try a simple operation for to "test" for kernel support this prevents
+// reporting tests as failed when it's run on an older kernel.
+static int kernel_support_for_mremap_dontunmap()
+{
+	int ret = 0;
+	unsigned long num_pages = 1;
+	void *source_mapping = mmap(NULL, num_pages * page_size, PROT_NONE,
+				    MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+	BUG_ON(source_mapping == MAP_FAILED, "mmap");
+
+	// This simple remap should only fail if MREMAP_DONTUNMAP isn't
+	// supported.
+	void *dest_mapping =
+	    mremap(source_mapping, num_pages * page_size, num_pages * page_size,
+		   MREMAP_DONTUNMAP | MREMAP_MAYMOVE, 0);
+	if (dest_mapping == MAP_FAILED) {
+		ret = errno;
+	} else {
+		BUG_ON(munmap(dest_mapping, num_pages * page_size) == -1,
+		       "unable to unmap destination mapping");
+	}
+
+	BUG_ON(munmap(source_mapping, num_pages * page_size) == -1,
+	       "unable to unmap source mapping");
+	return ret;
+}
+
+// This helper will just validate that an entire mapping contains the expected
+// byte.
+static int check_region_contains_byte(void *addr, unsigned long size, char byte)
+{
+	BUG_ON(size & (page_size - 1),
+	       "check_region_contains_byte expects page multiples");
+	BUG_ON((unsigned long)addr & (page_size - 1),
+	       "check_region_contains_byte expects page alignment");
+
+	memset(page_buffer, byte, page_size);
+
+	unsigned long num_pages = size / page_size;
+	unsigned long i;
+
+	// Compare each page checking that it contains our expected byte.
+	for (i = 0; i < num_pages; ++i) {
+		int ret =
+		    memcmp(addr + (i * page_size), page_buffer, page_size);
+		if (ret) {
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+// this test validates that MREMAP_DONTUNMAP moves the pagetables while leaving
+// the source mapping mapped.
+static void mremap_dontunmap_simple()
+{
+	unsigned long num_pages = 5;
+
+	void *source_mapping =
+	    mmap(NULL, num_pages * page_size, PROT_READ | PROT_WRITE,
+		 MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+	BUG_ON(source_mapping == MAP_FAILED, "mmap");
+
+	memset(source_mapping, 'a', num_pages * page_size);
+
+	// Try to just move the whole mapping anywhere (not fixed).
+	void *dest_mapping =
+	    mremap(source_mapping, num_pages * page_size, num_pages * page_size,
+		   MREMAP_DONTUNMAP | MREMAP_MAYMOVE, NULL);
+	BUG_ON(dest_mapping == MAP_FAILED, "mremap");
+
+	// Validate that the pages have been moved, we know they were moved if
+	// the dest_mapping contains a's.
+	BUG_ON(check_region_contains_byte
+	       (dest_mapping, num_pages * page_size, 'a') != 0,
+	       "pages did not migrate");
+	BUG_ON(check_region_contains_byte
+	       (source_mapping, num_pages * page_size, 0) != 0,
+	       "source should have no ptes");
+
+	BUG_ON(munmap(dest_mapping, num_pages * page_size) == -1,
+	       "unable to unmap destination mapping");
+	BUG_ON(munmap(source_mapping, num_pages * page_size) == -1,
+	       "unable to unmap source mapping");
+}
+
+// This test validates MREMAP_DONTUNMAP will move page tables to a specific
+// destination using MREMAP_FIXED, also while validating that the source
+// remains intact.
+static void mremap_dontunmap_simple_fixed()
+{
+	unsigned long num_pages = 5;
+
+	// Since we want to guarantee that we can remap to a point, we will
+	// create a mapping up front.
+	void *dest_mapping =
+	    mmap(NULL, num_pages * page_size, PROT_READ | PROT_WRITE,
+		 MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+	BUG_ON(dest_mapping == MAP_FAILED, "mmap");
+	memset(dest_mapping, 'X', num_pages * page_size);
+
+	void *source_mapping =
+	    mmap(NULL, num_pages * page_size, PROT_READ | PROT_WRITE,
+		 MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+	BUG_ON(source_mapping == MAP_FAILED, "mmap");
+	memset(source_mapping, 'a', num_pages * page_size);
+
+	void *remapped_mapping =
+	    mremap(source_mapping, num_pages * page_size, num_pages * page_size,
+		   MREMAP_FIXED | MREMAP_DONTUNMAP | MREMAP_MAYMOVE,
+		   dest_mapping);
+	BUG_ON(remapped_mapping == MAP_FAILED, "mremap");
+	BUG_ON(remapped_mapping != dest_mapping,
+	       "mremap should have placed the remapped mapping at dest_mapping");
+
+	// The dest mapping will have been unmap by mremap so we expect the Xs
+	// to be gone and replaced with a's.
+	BUG_ON(check_region_contains_byte
+	       (dest_mapping, num_pages * page_size, 'a') != 0,
+	       "pages did not migrate");
+
+	// And the source mapping will have had its ptes dropped.
+	BUG_ON(check_region_contains_byte
+	       (source_mapping, num_pages * page_size, 0) != 0,
+	       "source should have no ptes");
+
+	BUG_ON(munmap(dest_mapping, num_pages * page_size) == -1,
+	       "unable to unmap destination mapping");
+	BUG_ON(munmap(source_mapping, num_pages * page_size) == -1,
+	       "unable to unmap source mapping");
+}
+
+// This test validates that we can MREMAP_DONTUNMAP for a portion of an
+// existing mapping.
+static void mremap_dontunmap_partial_mapping()
+{
+	/*
+	 *  source mapping:
+	 *  --------------
+	 *  | aaaaaaaaaa |
+	 *  --------------
+	 *  to become:
+	 *  --------------
+	 *  | aaaaa00000 |
+	 *  --------------
+	 *  With the destination mapping containing 5 pages of As.
+	 *  ---------
+	 *  | aaaaa |
+	 *  ---------
+	 */
+	unsigned long num_pages = 10;
+	void *source_mapping =
+	    mmap(NULL, num_pages * page_size, PROT_READ | PROT_WRITE,
+		 MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+	BUG_ON(source_mapping == MAP_FAILED, "mmap");
+	memset(source_mapping, 'a', num_pages * page_size);
+
+	// We will grab the last 5 pages of the source and move them.
+	void *dest_mapping =
+	    mremap(source_mapping + (5 * page_size), 5 * page_size,
+		   5 * page_size,
+		   MREMAP_DONTUNMAP | MREMAP_MAYMOVE, NULL);
+	BUG_ON(dest_mapping == MAP_FAILED, "mremap");
+
+	// We expect the first 5 pages of the source to contain a's and the
+	// final 5 pages to contain zeros.
+	BUG_ON(check_region_contains_byte(source_mapping, 5 * page_size, 'a') !=
+	       0, "first 5 pages of source should have original pages");
+	BUG_ON(check_region_contains_byte
+	       (source_mapping + (5 * page_size), 5 * page_size, 0) != 0,
+	       "final 5 pages of source should have no ptes");
+
+	// Finally we expect the destination to have 5 pages worth of a's.
+	BUG_ON(check_region_contains_byte(dest_mapping, 5 * page_size, 'a') !=
+	       0, "dest mapping should contain ptes from the source");
+
+	BUG_ON(munmap(dest_mapping, 5 * page_size) == -1,
+	       "unable to unmap destination mapping");
+	BUG_ON(munmap(source_mapping, num_pages * page_size) == -1,
+	       "unable to unmap source mapping");
+}
+
+// This test validates that we can remap over only a portion of a mapping.
+static void mremap_dontunmap_partial_mapping_overwrite()
+{
+	/*
+	 *  source mapping:
+	 *  ---------
+	 *  |aaaaa|
+	 *  ---------
+	 *  dest mapping initially:
+	 *  -----------
+	 *  |XXXXXXXXXX|
+	 *  ------------
+	 *  Source to become:
+	 *  ---------
+	 *  |00000|
+	 *  ---------
+	 *  With the destination mapping containing 5 pages of As.
+	 *  ------------
+	 *  |aaaaaXXXXX|
+	 *  ------------
+	 */
+	void *source_mapping =
+	    mmap(NULL, 5 * page_size, PROT_READ | PROT_WRITE,
+		 MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+	BUG_ON(source_mapping == MAP_FAILED, "mmap");
+	memset(source_mapping, 'a', 5 * page_size);
+
+	void *dest_mapping =
+	    mmap(NULL, 10 * page_size, PROT_READ | PROT_WRITE,
+		 MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+	BUG_ON(dest_mapping == MAP_FAILED, "mmap");
+	memset(dest_mapping, 'X', 10 * page_size);
+
+	// We will grab the last 5 pages of the source and move them.
+	void *remapped_mapping =
+	    mremap(source_mapping, 5 * page_size,
+		   5 * page_size,
+		   MREMAP_DONTUNMAP | MREMAP_MAYMOVE | MREMAP_FIXED, dest_mapping);
+	BUG_ON(dest_mapping == MAP_FAILED, "mremap");
+	BUG_ON(dest_mapping != remapped_mapping, "expected to remap to dest_mapping");
+
+	BUG_ON(check_region_contains_byte(source_mapping, 5 * page_size, 0) !=
+	       0, "first 5 pages of source should have no ptes");
+
+	// Finally we expect the destination to have 5 pages worth of a's.
+	BUG_ON(check_region_contains_byte(dest_mapping, 5 * page_size, 'a') != 0,
+			"dest mapping should contain ptes from the source");
+
+	// Finally the last 5 pages shouldn't have been touched.
+	BUG_ON(check_region_contains_byte(dest_mapping + (5 * page_size),
+				5 * page_size, 'X') != 0,
+			"dest mapping should have retained the last 5 pages");
+
+	BUG_ON(munmap(dest_mapping, 10 * page_size) == -1,
+	       "unable to unmap destination mapping");
+	BUG_ON(munmap(source_mapping, 5 * page_size) == -1,
+	       "unable to unmap source mapping");
+}
+
+int main(void)
+{
+	page_size = sysconf(_SC_PAGE_SIZE);
+
+	// test for kernel support for MREMAP_DONTUNMAP skipping the test if
+	// not.
+	if (kernel_support_for_mremap_dontunmap() != 0) {
+		printf("No kernel support for MREMAP_DONTUNMAP\n");
+		return KSFT_SKIP;
+	}
+
+	// Keep a page sized buffer around for when we need it.
+	page_buffer =
+	    mmap(NULL, page_size, PROT_READ | PROT_WRITE,
+		 MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+	BUG_ON(page_buffer == MAP_FAILED, "unable to mmap a page.");
+
+	mremap_dontunmap_simple();
+	mremap_dontunmap_simple_fixed();
+	mremap_dontunmap_partial_mapping();
+	mremap_dontunmap_partial_mapping_overwrite();
+
+	BUG_ON(munmap(page_buffer, page_size) == -1,
+	       "unable to unmap page buffer");
+
+	printf("OK\n");
+	return 0;
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


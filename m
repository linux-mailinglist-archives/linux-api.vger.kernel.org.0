Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 536B71F7D30
	for <lists+linux-api@lfdr.de>; Fri, 12 Jun 2020 20:51:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726381AbgFLSvj (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 12 Jun 2020 14:51:39 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:37988 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbgFLSvi (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 12 Jun 2020 14:51:38 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: tonyk)
        with ESMTPSA id D53412A57E9
From:   =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
To:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        peterz@infradead.org
Cc:     krisman@collabora.com, kernel@collabora.com,
        andrealmeid@collabora.com, dvhart@infradead.org, mingo@redhat.com,
        pgriffais@valvesoftware.com, fweimer@redhat.com,
        libc-alpha@sourceware.org, malteskarupke@web.de,
        linux-api@vger.kernel.org
Subject: [RFC 3/4] selftests: futex: Add futex2 timeout test
Date:   Fri, 12 Jun 2020 15:51:21 -0300
Message-Id: <20200612185122.327860-4-andrealmeid@collabora.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200612185122.327860-1-andrealmeid@collabora.com>
References: <20200612185122.327860-1-andrealmeid@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Adapt existing futex wait timeout file to test the same mechanism for
futex2.

Signed-off-by: André Almeida <andrealmeid@collabora.com>
---
 .../futex/functional/futex_wait_timeout.c     | 27 ++++++++++++++++---
 1 file changed, 23 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/futex/functional/futex_wait_timeout.c b/tools/testing/selftests/futex/functional/futex_wait_timeout.c
index ee55e6d389a3..e0b802fcb005 100644
--- a/tools/testing/selftests/futex/functional/futex_wait_timeout.c
+++ b/tools/testing/selftests/futex/functional/futex_wait_timeout.c
@@ -11,6 +11,7 @@
  *
  * HISTORY
  *      2009-Nov-6: Initial version by Darren Hart <dvhart@linux.intel.com>
+ *      2020-Jun-11: Add futex2 test by André <andrealmeid@collabora.com>
  *
  *****************************************************************************/
 
@@ -20,7 +21,7 @@
 #include <stdlib.h>
 #include <string.h>
 #include <time.h>
-#include "futextest.h"
+#include "futex2test.h"
 #include "logging.h"
 
 #define TEST_NAME "futex-wait-timeout"
@@ -40,6 +41,7 @@ void usage(char *prog)
 int main(int argc, char *argv[])
 {
 	futex_t f1 = FUTEX_INITIALIZER;
+	time_t abs_to;
 	struct timespec to;
 	int res, ret = RET_PASS;
 	int c;
@@ -65,11 +67,17 @@ int main(int argc, char *argv[])
 	}
 
 	ksft_print_header();
-	ksft_set_plan(1);
+	ksft_set_plan(2);
 	ksft_print_msg("%s: Block on a futex and wait for timeout\n",
 	       basename(argv[0]));
 	ksft_print_msg("\tArguments: timeout=%ldns\n", timeout_ns);
 
+	/* setting absolute timeout for futex2 */
+	if (clock_gettime(CLOCK_MONOTONIC, &to))
+		error("clock_gettime failed\n", errno);
+
+	abs_to = (NSEC_PER_SEC * to.tv_sec) + to.tv_nsec + timeout_ns;
+
 	/* initialize timeout */
 	to.tv_sec = 0;
 	to.tv_nsec = timeout_ns;
@@ -77,10 +85,21 @@ int main(int argc, char *argv[])
 	info("Calling futex_wait on f1: %u @ %p\n", f1, &f1);
 	res = futex_wait(&f1, f1, &to, FUTEX_PRIVATE_FLAG);
 	if (!res || errno != ETIMEDOUT) {
-		fail("futex_wait returned %d\n", ret < 0 ? errno : ret);
+		ksft_test_result_fail("futex_wait returned %d\n", ret < 0 ? errno : ret);
+		ret = RET_FAIL;
+	} else {
+		ksft_test_result_pass("futex_wait timeout succeeds\n");
+	}
+
+	info("Calling futex2_wait on f1: %u @ %p\n", f1, &f1);
+	res = futex2_wait(&f1, f1, FUTEX_PRIVATE_FLAG | FUTEX_32, &abs_to);
+	if (!res || errno != ETIMEDOUT) {
+		ksft_test_result_fail("futex2_wait returned %d\n", ret < 0 ? errno : ret);
 		ret = RET_FAIL;
+	} else {
+		ksft_test_result_pass("futex2_wait timeout succeeds\n");
 	}
 
-	print_result(TEST_NAME, ret);
+	ksft_print_cnts();
 	return ret;
 }
-- 
2.27.0


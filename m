Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 469201F7D32
	for <lists+linux-api@lfdr.de>; Fri, 12 Jun 2020 20:51:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbgFLSvo (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 12 Jun 2020 14:51:44 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:38004 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbgFLSvn (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 12 Jun 2020 14:51:43 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: tonyk)
        with ESMTPSA id BCC592A57EB
From:   =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
To:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        peterz@infradead.org
Cc:     krisman@collabora.com, kernel@collabora.com,
        andrealmeid@collabora.com, dvhart@infradead.org, mingo@redhat.com,
        pgriffais@valvesoftware.com, fweimer@redhat.com,
        libc-alpha@sourceware.org, malteskarupke@web.de,
        linux-api@vger.kernel.org
Subject: [RFC 4/4] selftests: futex: Add futex2 wouldblock test
Date:   Fri, 12 Jun 2020 15:51:22 -0300
Message-Id: <20200612185122.327860-5-andrealmeid@collabora.com>
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

Adapt existing futex wait wouldblock file to test the same mechanism for
futex2.

Signed-off-by: André Almeida <andrealmeid@collabora.com>
---
 .../futex/functional/futex_wait_wouldblock.c  | 34 ++++++++++++++++---
 1 file changed, 29 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/futex/functional/futex_wait_wouldblock.c b/tools/testing/selftests/futex/functional/futex_wait_wouldblock.c
index 0ae390ff8164..67374d9db70c 100644
--- a/tools/testing/selftests/futex/functional/futex_wait_wouldblock.c
+++ b/tools/testing/selftests/futex/functional/futex_wait_wouldblock.c
@@ -12,6 +12,7 @@
  *
  * HISTORY
  *      2009-Nov-14: Initial version by Gowrishankar <gowrishankar.m@in.ibm.com>
+ *      2020-Jun-11: Add futex2 test by André <andrealmeid@collabora.com>
  *
  *****************************************************************************/
 
@@ -21,7 +22,7 @@
 #include <stdlib.h>
 #include <string.h>
 #include <time.h>
-#include "futextest.h"
+#include "futex2test.h"
 #include "logging.h"
 
 #define TEST_NAME "futex-wait-wouldblock"
@@ -38,7 +39,8 @@ void usage(char *prog)
 
 int main(int argc, char *argv[])
 {
-	struct timespec to = {.tv_sec = 0, .tv_nsec = timeout_ns};
+	time_t abs_to;
+	struct timespec to;
 	futex_t f1 = FUTEX_INITIALIZER;
 	int res, ret = RET_PASS;
 	int c;
@@ -61,18 +63,40 @@ int main(int argc, char *argv[])
 	}
 
 	ksft_print_header();
-	ksft_set_plan(1);
+	ksft_set_plan(2);
 	ksft_print_msg("%s: Test the unexpected futex value in FUTEX_WAIT\n",
 	       basename(argv[0]));
 
+	/* setting absolute timeout for futex2 */
+	if (clock_gettime(CLOCK_MONOTONIC, &to))
+		error("clock_gettime failed\n", errno);
+
+	abs_to = (NSEC_PER_SEC * to.tv_sec) + to.tv_nsec + timeout_ns;
+
+	/* initialize timeout */
+	to.tv_sec = 0;
+	to.tv_nsec = timeout_ns;
+
 	info("Calling futex_wait on f1: %u @ %p with val=%u\n", f1, &f1, f1+1);
 	res = futex_wait(&f1, f1+1, &to, FUTEX_PRIVATE_FLAG);
 	if (!res || errno != EWOULDBLOCK) {
-		fail("futex_wait returned: %d %s\n",
+		ksft_test_result_fail("futex_wait returned: %d %s\n",
+		     res ? errno : res, res ? strerror(errno) : "");
+		ret = RET_FAIL;
+	} else {
+		ksft_test_result_pass("futex_wait wouldblock succeeds\n");
+	}
+
+	info("Calling futex2_wait on f1: %u @ %p with val=%u\n", f1, &f1, f1+1);
+	res = futex2_wait(&f1, f1+1, FUTEX_PRIVATE_FLAG | FUTEX_32, &abs_to);
+	if (!res || errno != EWOULDBLOCK) {
+		ksft_test_result_fail("futex2_wait returned: %d %s\n",
 		     res ? errno : res, res ? strerror(errno) : "");
 		ret = RET_FAIL;
+	} else {
+		ksft_test_result_pass("futex2_wait wouldblock succeeds\n");
 	}
 
-	print_result(TEST_NAME, ret);
+	ksft_print_cnts();
 	return ret;
 }
-- 
2.27.0


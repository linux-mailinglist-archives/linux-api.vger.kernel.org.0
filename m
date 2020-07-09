Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2009821A686
	for <lists+linux-api@lfdr.de>; Thu,  9 Jul 2020 20:01:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728519AbgGISA7 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 9 Jul 2020 14:00:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726936AbgGISA6 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 9 Jul 2020 14:00:58 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C741C08C5CE;
        Thu,  9 Jul 2020 11:00:58 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: tonyk)
        with ESMTPSA id 9C1B42A65F9
From:   =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
To:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        peterz@infradead.org
Cc:     krisman@collabora.com, kernel@collabora.com,
        andrealmeid@collabora.com, dvhart@infradead.org, mingo@redhat.com,
        pgriffais@valvesoftware.com, fweimer@redhat.com,
        libc-alpha@sourceware.org, malteskarupke@web.de,
        linux-api@vger.kernel.org, arnd@arndb.de
Subject: [RFC v2 4/4] selftests: futex: Add futex2 wouldblock test
Date:   Thu,  9 Jul 2020 14:59:21 -0300
Message-Id: <20200709175921.211387-5-andrealmeid@collabora.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200709175921.211387-1-andrealmeid@collabora.com>
References: <20200709175921.211387-1-andrealmeid@collabora.com>
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
 .../futex/functional/futex_wait_wouldblock.c  | 33 ++++++++++++++++---
 1 file changed, 29 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/futex/functional/futex_wait_wouldblock.c b/tools/testing/selftests/futex/functional/futex_wait_wouldblock.c
index 0ae390ff8164..8187f0754cd2 100644
--- a/tools/testing/selftests/futex/functional/futex_wait_wouldblock.c
+++ b/tools/testing/selftests/futex/functional/futex_wait_wouldblock.c
@@ -12,6 +12,7 @@
  *
  * HISTORY
  *      2009-Nov-14: Initial version by Gowrishankar <gowrishankar.m@in.ibm.com>
+ *      2020-Jul-9: Add futex2 test by André <andrealmeid@collabora.com>
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
@@ -39,6 +40,7 @@ void usage(char *prog)
 int main(int argc, char *argv[])
 {
 	struct timespec to = {.tv_sec = 0, .tv_nsec = timeout_ns};
+	struct timespec64 to64;
 	futex_t f1 = FUTEX_INITIALIZER;
 	int res, ret = RET_PASS;
 	int c;
@@ -61,18 +63,41 @@ int main(int argc, char *argv[])
 	}
 
 	ksft_print_header();
-	ksft_set_plan(1);
+	ksft_set_plan(2);
 	ksft_print_msg("%s: Test the unexpected futex value in FUTEX_WAIT\n",
 	       basename(argv[0]));
 
 	info("Calling futex_wait on f1: %u @ %p with val=%u\n", f1, &f1, f1+1);
 	res = futex_wait(&f1, f1+1, &to, FUTEX_PRIVATE_FLAG);
 	if (!res || errno != EWOULDBLOCK) {
-		fail("futex_wait returned: %d %s\n",
+		ksft_test_result_fail("futex_wait returned: %d %s\n",
 		     res ? errno : res, res ? strerror(errno) : "");
 		ret = RET_FAIL;
+	} else {
+		ksft_test_result_pass("futex_wait wouldblock succeeds\n");
 	}
 
-	print_result(TEST_NAME, ret);
+	/* setting absolute timeout for futex2 */
+	if (gettime64(CLOCK_MONOTONIC, &to64))
+		error("gettime64 failed\n", errno);
+
+	to64.tv_nsec += timeout_ns;
+
+	if (to64.tv_nsec >= 1000000000) {
+		to64.tv_sec++;
+		to64.tv_nsec -= 1000000000;
+	}
+
+	info("Calling futex2_wait on f1: %u @ %p with val=%u\n", f1, &f1, f1+1);
+	res = futex2_wait(&f1, f1+1, FUTEX_PRIVATE_FLAG | FUTEX_32, &to64);
+	if (!res || errno != EWOULDBLOCK) {
+		ksft_test_result_fail("futex2_wait returned: %d %s\n",
+		     res ? errno : res, res ? strerror(errno) : "");
+		ret = RET_FAIL;
+	} else {
+		ksft_test_result_pass("futex2_wait wouldblock succeeds\n");
+	}
+
+	ksft_print_cnts();
 	return ret;
 }
-- 
2.27.0


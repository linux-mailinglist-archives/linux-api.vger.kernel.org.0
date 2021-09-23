Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 312BC416421
	for <lists+linux-api@lfdr.de>; Thu, 23 Sep 2021 19:13:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242570AbhIWROy (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 23 Sep 2021 13:14:54 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:47256 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242687AbhIWROb (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 23 Sep 2021 13:14:31 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: tonyk)
        with ESMTPSA id 4E8311F44619
From:   =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     kernel@collabora.com, krisman@collabora.com,
        linux-api@vger.kernel.org, libc-alpha@sourceware.org,
        mtk.manpages@gmail.com, Davidlohr Bueso <dave@stgolabs.net>,
        Arnd Bergmann <arnd@arndb.de>,
        =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
Subject: [PATCH v2 21/22] selftests: futex: Test sys_futex_waitv() wouldblock
Date:   Thu, 23 Sep 2021 14:11:10 -0300
Message-Id: <20210923171111.300673-22-andrealmeid@collabora.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210923171111.300673-1-andrealmeid@collabora.com>
References: <20210923171111.300673-1-andrealmeid@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Test if futex_waitv() returns -EWOULDBLOCK correctly when the expected
value is different from the actual value for a waiter.

Signed-off-by: André Almeida <andrealmeid@collabora.com>
---
 .../futex/functional/futex_wait_wouldblock.c  | 41 +++++++++++++++++--
 1 file changed, 37 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/futex/functional/futex_wait_wouldblock.c b/tools/testing/selftests/futex/functional/futex_wait_wouldblock.c
index 0ae390ff8164..7d7a6a06cdb7 100644
--- a/tools/testing/selftests/futex/functional/futex_wait_wouldblock.c
+++ b/tools/testing/selftests/futex/functional/futex_wait_wouldblock.c
@@ -22,6 +22,7 @@
 #include <string.h>
 #include <time.h>
 #include "futextest.h"
+#include "futex2test.h"
 #include "logging.h"
 
 #define TEST_NAME "futex-wait-wouldblock"
@@ -42,6 +43,12 @@ int main(int argc, char *argv[])
 	futex_t f1 = FUTEX_INITIALIZER;
 	int res, ret = RET_PASS;
 	int c;
+	struct futex_waitv waitv = {
+			.uaddr = (uintptr_t)&f1,
+			.val = f1+1,
+			.flags = FUTEX_32,
+			.__reserved = 0
+		};
 
 	while ((c = getopt(argc, argv, "cht:v:")) != -1) {
 		switch (c) {
@@ -61,18 +68,44 @@ int main(int argc, char *argv[])
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
-		     res ? errno : res, res ? strerror(errno) : "");
+		ksft_test_result_fail("futex_wait returned: %d %s\n",
+				      res ? errno : res,
+				      res ? strerror(errno) : "");
 		ret = RET_FAIL;
+	} else {
+		ksft_test_result_pass("futex_wait\n");
 	}
 
-	print_result(TEST_NAME, ret);
+	if (clock_gettime(CLOCK_MONOTONIC, &to)) {
+		error("clock_gettime failed\n", errno);
+		return errno;
+	}
+
+	to.tv_nsec += timeout_ns;
+
+	if (to.tv_nsec >= 1000000000) {
+		to.tv_sec++;
+		to.tv_nsec -= 1000000000;
+	}
+
+	info("Calling futex_waitv on f1: %u @ %p with val=%u\n", f1, &f1, f1+1);
+	res = futex_waitv(&waitv, 1, 0, &to, CLOCK_MONOTONIC);
+	if (!res || errno != EWOULDBLOCK) {
+		ksft_test_result_pass("futex_waitv returned: %d %s\n",
+				      res ? errno : res,
+				      res ? strerror(errno) : "");
+		ret = RET_FAIL;
+	} else {
+		ksft_test_result_pass("futex_waitv\n");
+	}
+
+	ksft_print_cnts();
 	return ret;
 }
-- 
2.33.0


Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66D25409B46
	for <lists+linux-api@lfdr.de>; Mon, 13 Sep 2021 19:53:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241878AbhIMRys (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 13 Sep 2021 13:54:48 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:57702 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245074AbhIMRyr (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 13 Sep 2021 13:54:47 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: tonyk)
        with ESMTPSA id AF3991F42D02
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
Subject: [PATCH v3 6/6] selftests: futex2: Test futex_waitv timeout
Date:   Mon, 13 Sep 2021 14:52:49 -0300
Message-Id: <20210913175249.81074-7-andrealmeid@collabora.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210913175249.81074-1-andrealmeid@collabora.com>
References: <20210913175249.81074-1-andrealmeid@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Test if the futex_waitv timeout is working as expected, using the
supported clockid options.

Signed-off-by: André Almeida <andrealmeid@collabora.com>
---
 .../futex/functional/futex_wait_timeout.c     | 21 ++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/futex/functional/futex_wait_timeout.c b/tools/testing/selftests/futex/functional/futex_wait_timeout.c
index 1f8f6daaf1e7..4cdada0fcb81 100644
--- a/tools/testing/selftests/futex/functional/futex_wait_timeout.c
+++ b/tools/testing/selftests/futex/functional/futex_wait_timeout.c
@@ -17,6 +17,7 @@
 
 #include <pthread.h>
 #include "futextest.h"
+#include "futex2test.h"
 #include "logging.h"
 
 #define TEST_NAME "futex-wait-timeout"
@@ -96,6 +97,12 @@ int main(int argc, char *argv[])
 	struct timespec to;
 	pthread_t thread;
 	int c;
+	struct futex_waitv waitv = {
+			.uaddr = (uintptr_t)&f1,
+			.val = f1,
+			.flags = FUTEX_32,
+			.__reserved = 0
+		};
 
 	while ((c = getopt(argc, argv, "cht:v:")) != -1) {
 		switch (c) {
@@ -118,7 +125,7 @@ int main(int argc, char *argv[])
 	}
 
 	ksft_print_header();
-	ksft_set_plan(7);
+	ksft_set_plan(9);
 	ksft_print_msg("%s: Block on a futex and wait for timeout\n",
 	       basename(argv[0]));
 	ksft_print_msg("\tArguments: timeout=%ldns\n", timeout_ns);
@@ -175,6 +182,18 @@ int main(int argc, char *argv[])
 	res = futex_lock_pi(&futex_pi, NULL, 0, FUTEX_CLOCK_REALTIME);
 	test_timeout(res, &ret, "futex_lock_pi invalid timeout flag", ENOSYS);
 
+	/* futex_waitv with CLOCK_MONOTONIC */
+	if (futex_get_abs_timeout(CLOCK_MONOTONIC, &to, timeout_ns))
+		return RET_FAIL;
+	res = futex_waitv(&waitv, 1, 0, &to);
+	test_timeout(res, &ret, "futex_waitv monotonic", ETIMEDOUT);
+
+	/* futex_waitv with CLOCK_REALTIME */
+	if (futex_get_abs_timeout(CLOCK_REALTIME, &to, timeout_ns))
+		return RET_FAIL;
+	res = futex_waitv(&waitv, 1, FUTEX_CLOCK_REALTIME, &to);
+	test_timeout(res, &ret, "futex_waitv realtime", ETIMEDOUT);
+
 	ksft_print_cnts();
 	return ret;
 }
-- 
2.33.0


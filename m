Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69E0838B62C
	for <lists+linux-api@lfdr.de>; Thu, 20 May 2021 20:36:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235671AbhETSh4 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 20 May 2021 14:37:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235661AbhETShz (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 20 May 2021 14:37:55 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CFFFC061760
        for <linux-api@vger.kernel.org>; Thu, 20 May 2021 11:36:32 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id s8-20020a5b04480000b029049fb35700b9so23985215ybp.5
        for <linux-api@vger.kernel.org>; Thu, 20 May 2021 11:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=GF6IQET16CbWiLSpp1g7dBz7aEEoM3ThdSv7nONiCT0=;
        b=bYn3Iyte+zbhoMUIrESR91NtSoaIaaY2JXALfvyxZwheD8M3ixUZRW68aZ6SB4uZ2W
         lVk+UxV4Ge3jnkCMxl2bZab1nBkoCWANWQmbpT2WPzLZmvO6merb12eTyAHchYwo9Swg
         K1ipEUFF80nHhJJlnmcw1saejXaQTXvqmWTmY3ntyjcED/LBFjHErXsKyoaXY8zFgMYM
         JoJ1QEAbHzcrMrz6W3UGFKWIOP3ptve4ukhB2gErwWJ+KpKlHlywu3TndwPynYS6dRBt
         I7EES31NjCRJlgJaz42bZMCQphxojC8YS2uNwP1BoqQ5dMwcFagsNa49bazkOqt6pEqp
         LIxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=GF6IQET16CbWiLSpp1g7dBz7aEEoM3ThdSv7nONiCT0=;
        b=RTjPKdSLeVw8zyzLZW7BNPGNU4gVxwmRkcpIBBB1/jTRS2h4+sAgat2m8IDUUFH7wt
         eXMXYNDHHppjnPv+CdzBpqoinH4EbFlJwWszgIRtDToyPJWmgcG+X4uYrmm+fzxCl3QG
         U175y8tYUX4oaebQQ2rZvvRb1B4OycpgVwctMDMtriVsL3HmqzAal3VgIlobqA3TxzhF
         1saR47xENMPMp7IoCTDe5aOF08IZODVtL5jB4HqCMFq9cq7wsSjhaS6JVj9CKfs5hs0r
         SK4JcnNaKbory/B0VX7spaW1c96zbfoYUo3AldUf619RnsBQCWX7+NW1JEwcspT8XV1c
         G2VQ==
X-Gm-Message-State: AOAM533xZhMDJkVFQy4fMM0P/sCn+Y+7FKyX6MEr6Swm3eN2jrGCcLc3
        2QnZerDP+R47CZmAsMHqoxRAMB/J
X-Google-Smtp-Source: ABdhPJw+LgysJJZYDal5krvfI9Z8HAv9YZVf9VSZTXyQpj/foLiZfkuu8VRuCQSd7uZi4CtzHyGYWeKn
X-Received: from posk.svl.corp.google.com ([2620:15c:2cd:202:f13e:18cf:76e6:2dc4])
 (user=posk job=sendgmr) by 2002:a25:d8d0:: with SMTP id p199mr4993557ybg.261.1621535791803;
 Thu, 20 May 2021 11:36:31 -0700 (PDT)
Date:   Thu, 20 May 2021 11:36:11 -0700
In-Reply-To: <20210520183614.1227046-1-posk@google.com>
Message-Id: <20210520183614.1227046-7-posk@google.com>
Mime-Version: 1.0
References: <20210520183614.1227046-1-posk@google.com>
X-Mailer: git-send-email 2.31.1.818.g46aad6cb9e-goog
Subject: [RFC PATCH v0.1 6/9] selftests/umcg: add UMCG core API selftest
From:   Peter Oskolkov <posk@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Cc:     Paul Turner <pjt@google.com>, Ben Segall <bsegall@google.com>,
        Peter Oskolkov <posk@google.com>,
        Peter Oskolkov <posk@posk.io>,
        Joel Fernandes <joel@joelfernandes.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrei Vagin <avagin@google.com>,
        Jim Newsome <jnewsome@torproject.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Add UMCG core API selftests. In particular, test that
umcg_wait/umcg_wake/umcg_swap behave correctly when racing
with each other.

Signed-off-by: Peter Oskolkov <posk@google.com>
---
 tools/testing/selftests/umcg/.gitignore       |   2 +
 tools/testing/selftests/umcg/Makefile         |  13 +
 tools/testing/selftests/umcg/umcg_core_test.c | 347 ++++++++++++++++++
 3 files changed, 362 insertions(+)
 create mode 100644 tools/testing/selftests/umcg/.gitignore
 create mode 100644 tools/testing/selftests/umcg/Makefile
 create mode 100644 tools/testing/selftests/umcg/umcg_core_test.c

diff --git a/tools/testing/selftests/umcg/.gitignore b/tools/testing/selftests/umcg/.gitignore
new file mode 100644
index 000000000000..89cca24e5907
--- /dev/null
+++ b/tools/testing/selftests/umcg/.gitignore
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0-only
+umcg_core_test
diff --git a/tools/testing/selftests/umcg/Makefile b/tools/testing/selftests/umcg/Makefile
new file mode 100644
index 000000000000..b151098e2ed1
--- /dev/null
+++ b/tools/testing/selftests/umcg/Makefile
@@ -0,0 +1,13 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+TOOLSDIR := $(abspath ../../..)
+LIBUMCGDIR := $(TOOLSDIR)/lib/umcg
+
+CFLAGS += -g -O0 -I$(LIBUMCGDIR) -I$(TOOLSDIR)/include/ -I../../../../usr/include/
+LDLIBS += -lpthread -static
+
+TEST_GEN_PROGS := umcg_core_test
+
+include ../lib.mk
+
+$(OUTPUT)/umcg_core_test: umcg_core_test.c $(LIBUMCGDIR)/libumcg.c
diff --git a/tools/testing/selftests/umcg/umcg_core_test.c b/tools/testing/selftests/umcg/umcg_core_test.c
new file mode 100644
index 000000000000..4dc20131ace7
--- /dev/null
+++ b/tools/testing/selftests/umcg/umcg_core_test.c
@@ -0,0 +1,347 @@
+// SPDX-License-Identifier: GPL-2.0
+#define _GNU_SOURCE
+#include "libumcg.h"
+
+#include <pthread.h>
+#include <stdatomic.h>
+
+#include "../kselftest_harness.h"
+
+#define CHECK_CONFIG()						\
+{								\
+	int ret = sys_umcg_api_version(1, 0);			\
+	if (ret == -1 && errno == ENOSYS)			\
+		SKIP(return, "CONFIG_UMCG not set");	\
+}
+
+TEST(umcg_api_version) {
+	CHECK_CONFIG();
+	ASSERT_EQ(0, sys_umcg_api_version(1, 0));
+	ASSERT_EQ(1, sys_umcg_api_version(1234, 0));
+}
+
+/* Test that forked children of UMCG enabled tasks are not UMCG enabled. */
+TEST(register_and_fork) {
+	CHECK_CONFIG();
+	pid_t pid;
+	int wstatus;
+	umcg_tid utid;
+
+	/* umcg_unregister should fail without registering earlier. */
+	ASSERT_NE(0, umcg_unregister_task());
+
+	utid = umcg_register_core_task(0);
+	ASSERT_TRUE(utid != UMCG_NONE);
+
+	pid = fork();
+	if (pid == 0) {
+		/* This is child. umcg_unregister_task() should fail. */
+		if (!umcg_unregister_task()) {
+			fprintf(stderr, "umcg_unregister_task() succeeded in "
+					"the forked child.\n");
+			exit(1);
+		}
+		exit(0);
+	}
+
+	ASSERT_EQ(pid, waitpid(pid, &wstatus, 0));
+	ASSERT_TRUE(WIFEXITED(wstatus));
+	ASSERT_EQ(0, WEXITSTATUS(wstatus));
+	ASSERT_EQ(0, umcg_unregister_task());
+}
+
+struct test_waiter_args {
+	umcg_tid	utid;
+	bool		stop;
+	bool		waiting;
+};
+
+/* Thread FN for the test waiter: calls umcg_wait() in a loop until stopped. */
+static void *test_waiter_threadfn(void *arg)
+{
+	struct test_waiter_args *args = (struct test_waiter_args *)arg;
+	uint64_t counter = 0;
+
+	atomic_store_explicit(&args->utid, umcg_register_core_task(0),
+			memory_order_relaxed);
+	if (!args->utid) {
+		fprintf(stderr, "umcg_register_core_task failed: %d.\n", errno);
+		exit(1);
+	}
+
+	while (!atomic_load_explicit(&args->stop, memory_order_seq_cst)) {
+		bool expected = false;
+
+		if (!atomic_compare_exchange_strong_explicit(&args->waiting,
+					&expected, true,
+					memory_order_seq_cst,
+					memory_order_seq_cst)) {
+			fprintf(stderr, "Failed to set waiting flag.\n");
+			exit(1);
+		}
+
+		++counter;
+		if (counter % 5 == 0)
+			usleep(1);  /* Trigger a race with ucmg_wake(). */
+
+		if (umcg_wait(NULL)) {
+			fprintf(stderr, "umcg_wait failed: %d.\n", errno);
+			exit(1);
+		}
+	}
+
+	if (umcg_unregister_task()) {
+		fprintf(stderr, "umcg_register_core_task failed: %d.\n", errno);
+		exit(1);
+	}
+
+	return (void *)counter;
+}
+
+/* Test wake/wait pair racing with each other. */
+TEST(umcg_wake_wait) {
+	CHECK_CONFIG();
+	struct test_waiter_args args;
+	const int steps = 10000;
+	bool expected = true;
+	void *result;
+	pthread_t t;
+	int ret;
+
+	args.utid = UMCG_NONE;
+	args.stop = false;
+	args.waiting = false;
+
+	ASSERT_EQ(0, pthread_create(&t, NULL, &test_waiter_threadfn, &args));
+
+	while (!atomic_load_explicit(&args.utid, memory_order_relaxed))
+		;
+
+	for (int step = 0; step < steps; ++step) {
+		/* Spin until the waiter indicates it is going to wait. */
+		while (!atomic_compare_exchange_weak_explicit(&args.waiting,
+					&expected, false,
+					memory_order_seq_cst,
+					memory_order_seq_cst)) {
+			expected = true;
+		}
+
+		ASSERT_EQ(0, umcg_wake(args.utid));
+	}
+
+	/* Carefully shut down. */
+	expected = true;
+	while (!atomic_compare_exchange_weak_explicit(&args.waiting, &expected,
+			false, memory_order_seq_cst, memory_order_seq_cst)) {
+		expected = true;
+	}
+	atomic_store_explicit(&args.stop, true, memory_order_seq_cst);
+	ret = umcg_wake(args.utid);
+
+	/* If the worker immediately exits upon wake, we may get ESRCH. */
+	ASSERT_TRUE((ret == 0) || (errno == ESRCH));
+
+	ASSERT_EQ(0, pthread_join(t, &result));
+	ASSERT_EQ(steps + 1, (uint64_t)result);
+}
+
+struct test_ping_pong_args {
+	bool		ping;  /* Is this worker doing pings or pongs? */
+	umcg_tid	utid_self;
+	umcg_tid	utid_peer;
+	int		steps;
+	bool		use_swap;  /* Use umcg_swap or wake/wait. */
+	bool		payload;   /* call gettid() if true at each iteration. */
+
+	/*
+	 * It is not allowed to wake a task that has a wakeup queued, so
+	 * normally the test "softly" synchronizes ping and pong tasks so
+	 * that pong calls umcg_wait() to wait for the first ping.
+	 *
+	 * However, it is allowed to do mutual umcg_swap(), so in the
+	 * test flavor when both ping and pong tasks use swaps we also
+	 * run the test without pong waiting for the initial ping.
+	 */
+	bool		pong_waits;
+};
+
+/* Thread FN for ping-pong workers. */
+static void *test_ping_pong_threadfn(void *arg)
+{
+	struct test_ping_pong_args *args = (struct test_ping_pong_args *)arg;
+	struct timespec start, stop;
+	int counter;
+
+	atomic_store_explicit(&args->utid_self, umcg_register_core_task(0),
+			memory_order_relaxed);
+	if (!args->utid_self) {
+		fprintf(stderr, "umcg_register_core_task failed: %d.\n", errno);
+		exit(1);
+	}
+
+	while (!atomic_load_explicit(&args->utid_peer, memory_order_acquire))
+		;
+
+	if (args->pong_waits && !args->ping) {
+		/* This is pong: we sleep first. */
+		if (umcg_wait(NULL)) {
+			fprintf(stderr, "umcg_wait failed: %d.\n", errno);
+			exit(1);
+		}
+	}
+
+	if (args->ping) {  /* The "ping" measures the running time. */
+		if (clock_gettime(CLOCK_MONOTONIC, &start)) {
+			fprintf(stderr, "clock_gettime() failed.\n");
+			exit(1);
+		}
+	}
+
+	for (counter = 0; counter < args->steps; ++counter) {
+		int ret;
+
+		if (args->payload)
+			gettid();
+
+		if (args->use_swap) {
+			ret = umcg_swap(args->utid_peer, NULL);
+		} else {
+			ret = umcg_wake(args->utid_peer);
+			if (!ret)
+				ret = umcg_wait(NULL);
+		}
+
+		if (ret) {
+			if (args->use_swap)
+				fprintf(stderr, "umcg_swap failed: %d.\n", errno);
+			else
+				fprintf(stderr, "umcg_wake/wait failed: %d.\n", errno);
+			exit(1);
+		}
+	}
+
+	if (args->ping) {
+		uint64_t duration;
+
+		if (clock_gettime(CLOCK_MONOTONIC, &stop)) {
+			fprintf(stderr, "clock_gettime() failed.\n");
+			exit(1);
+		}
+
+		duration = (stop.tv_sec - start.tv_sec) * 1000000000LL +
+		stop.tv_nsec - start.tv_nsec;
+		printf("completed %d ping-pong iterations in %lu ns: "
+				"%lu ns per context switch\n",
+			args->steps, duration, duration / (args->steps * 2));
+	}
+
+	if (args->pong_waits && args->ping) {
+		/* This is ping: we wake pong at the end. */
+		if (umcg_wake(args->utid_peer)) {
+			fprintf(stderr, "umcg_wake failed: %d.\n", errno);
+			exit(1);
+		}
+	}
+
+	if (umcg_unregister_task()) {
+		fprintf(stderr, "umcg_unregister_task failed: %d.\n", errno);
+		exit(1);
+	}
+
+	return NULL;
+}
+
+enum ping_pong_flavor {
+	NO_SWAPS,	/* Use wake/wait pairs on both sides. */
+	ONE_SWAP,	/* Use wake/wait on one side and swap on the other. */
+	ALL_SWAPS	/* Use swaps on both sides. */
+};
+
+static void test_ping_pong_flavored(enum ping_pong_flavor flavor,
+		bool pong_waits, bool payload)
+{
+	struct test_ping_pong_args ping, pong;
+	pthread_t ping_t, pong_t;
+	const int STEPS = 100000;
+
+	ping.ping = true;
+	ping.utid_self = UMCG_NONE;
+	ping.utid_peer = UMCG_NONE;
+	ping.steps = STEPS;
+	ping.pong_waits = pong_waits;
+	ping.payload = payload;
+
+	pong.ping = false;
+	pong.utid_self = UMCG_NONE;
+	pong.utid_peer = UMCG_NONE;
+	pong.steps = STEPS;
+	pong.pong_waits = pong_waits;
+	pong.payload = payload;
+
+	switch (flavor) {
+	case NO_SWAPS:
+		ping.use_swap = false;
+		pong.use_swap = false;
+		break;
+	case ONE_SWAP:
+		ping.use_swap = true;
+		pong.use_swap = false;
+		break;
+	case ALL_SWAPS:
+		ping.use_swap = true;
+		pong.use_swap = true;
+		break;
+	default:
+		fprintf(stderr, "Unknown ping/pong flavor.\n");
+		exit(1);
+	}
+
+	if (pthread_create(&ping_t, NULL, &test_ping_pong_threadfn, &ping)) {
+		fprintf(stderr, "pthread_create(ping) failed.\n");
+		exit(1);
+	}
+
+	while (!atomic_load_explicit(&ping.utid_self, memory_order_relaxed))
+		;
+	pong.utid_peer = ping.utid_self;
+
+	if (pthread_create(&pong_t, NULL, &test_ping_pong_threadfn, &pong)) {
+		fprintf(stderr, "pthread_create(pong) failed.\n");
+		exit(1);
+	}
+
+	while (!atomic_load_explicit(&pong.utid_self, memory_order_relaxed))
+		;
+	atomic_store_explicit(&ping.utid_peer, pong.utid_self,
+			memory_order_relaxed);
+
+	pthread_join(ping_t, NULL);
+	pthread_join(pong_t, NULL);
+}
+
+TEST(umcg_ping_pong_no_swaps_nop) {
+	CHECK_CONFIG();
+	test_ping_pong_flavored(NO_SWAPS, true, false);
+}
+TEST(umcg_ping_pong_one_swap_nop) {
+	CHECK_CONFIG();
+	test_ping_pong_flavored(ONE_SWAP, true, false);
+}
+TEST(umcg_ping_pong_all_swaps_nop) {
+	CHECK_CONFIG();
+	test_ping_pong_flavored(ALL_SWAPS, true, false);
+}
+TEST(umcg_ping_pong_all_swaps_loose_nop) {
+	CHECK_CONFIG();
+	test_ping_pong_flavored(ALL_SWAPS, false, false);
+}
+TEST(umcg_ping_pong_no_swaps_payload) {
+	CHECK_CONFIG();
+	test_ping_pong_flavored(NO_SWAPS, true, true);
+}
+TEST(umcg_ping_pong_all_swaps_payload) {
+	CHECK_CONFIG();
+	test_ping_pong_flavored(ALL_SWAPS, true, true);
+}
+
+TEST_HARNESS_MAIN
-- 
2.31.1.818.g46aad6cb9e-goog


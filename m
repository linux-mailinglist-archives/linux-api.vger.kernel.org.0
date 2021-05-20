Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0F2738B635
	for <lists+linux-api@lfdr.de>; Thu, 20 May 2021 20:37:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236098AbhETSiR (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 20 May 2021 14:38:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235773AbhETSiB (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 20 May 2021 14:38:01 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A46A3C06138B
        for <linux-api@vger.kernel.org>; Thu, 20 May 2021 11:36:38 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id 1-20020aed31010000b029019d1c685840so13031101qtg.3
        for <linux-api@vger.kernel.org>; Thu, 20 May 2021 11:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=2I0X9v0dJgQjMRRuUZOaNPmbh6GSSvEWwVCe9Ujfz8U=;
        b=C3xqf0+UAg9Xwtf3qSMNPtj55FVzIxrKGURuri+lM3l3Eybi0B/VjHSauNPDNm+szO
         SHcJqYsFtqgNL7QQ1mbNGEQXHzzpLyJrgTBrTDlw7Rgy3D4mVZ9lxN++zuRVkeic0cUj
         0ptNtzHH3GESwdpDAH18U5MiQ5g/DeJthBABL+CPIAAPbUoP8JgV5KEGn3oPXt0pBCV5
         FiJL2D+C0CSUc7xF4tSPpi/sHosPuQD08yNkDiepDE50CS7XiOdiM24wSQUL1sOhwfBh
         +cVTdfxSEEODarZ11/Y+WaBNIkqamwtKjbykuGM+ZjGZx893lS3ym3sgMbeKDZlfGIXk
         Furg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=2I0X9v0dJgQjMRRuUZOaNPmbh6GSSvEWwVCe9Ujfz8U=;
        b=FNh7gxljrTIZwor5+jvscW24WWsV5meW/NF19wcMKGy6byy0Hd6yk+HXtzbRckINrv
         UU2pbr3dwqmNjjbsC/ZI8qBaLXzhYG+68UDqWQAf4ED8IAeZW0U/8NBapaPf1Czd0zeS
         72Mpxh5pyeKmyLDKnaBHOYTPfAtTZqKxsMEJRv7Jchyk8QX8r7YIcyQDsxS2fAZWKJRU
         IX98LjpsXQ/qokC5AkUAbWUBQEP2K5XRhO7EJYxapOmAj9FSfIKRxo2wL1dsCZ249rsq
         /9ObN1hSBiDr6GmVtF/QO2RQhdoalZ7jpGcMDWQrTAkR3knWjyJ0jPhnUDX3Kb5vZ18Z
         wMDg==
X-Gm-Message-State: AOAM532cqjY8S5RV9NGVwE9iQnwM+FkcbbSFnqEsRVRwMO0rv6vq9QzQ
        lkIE08nV7mz/H0hMjkp7nRPCVWBj
X-Google-Smtp-Source: ABdhPJzdaO85atzIR8SmPfcsO+1s3GIZZGd77MvO+jQbKJWb1gxRuPa3Gkrth9LgmjXmjBDS62+0+5Hc
X-Received: from posk.svl.corp.google.com ([2620:15c:2cd:202:f13e:18cf:76e6:2dc4])
 (user=posk job=sendgmr) by 2002:a05:6214:126f:: with SMTP id
 r15mr7180696qvv.35.1621535797790; Thu, 20 May 2021 11:36:37 -0700 (PDT)
Date:   Thu, 20 May 2021 11:36:14 -0700
In-Reply-To: <20210520183614.1227046-1-posk@google.com>
Message-Id: <20210520183614.1227046-10-posk@google.com>
Mime-Version: 1.0
References: <20210520183614.1227046-1-posk@google.com>
X-Mailer: git-send-email 2.31.1.818.g46aad6cb9e-goog
Subject: [RFC PATCH v0.1 9/9] selftests/umcg: add UMCG server/worker API selftest
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

Add UMCG server/worker API selftests. These are only basic
tests, they do not cover many important use cases/conditions.

More to come.

Signed-off-by: Peter Oskolkov <posk@google.com>
---
 tools/testing/selftests/umcg/.gitignore  |   1 +
 tools/testing/selftests/umcg/Makefile    |   4 +-
 tools/testing/selftests/umcg/umcg_test.c | 475 +++++++++++++++++++++++
 3 files changed, 479 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/umcg/umcg_test.c

diff --git a/tools/testing/selftests/umcg/.gitignore b/tools/testing/selftests/umcg/.gitignore
index 89cca24e5907..f488ec82882a 100644
--- a/tools/testing/selftests/umcg/.gitignore
+++ b/tools/testing/selftests/umcg/.gitignore
@@ -1,2 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0-only
 umcg_core_test
+umcg_test
diff --git a/tools/testing/selftests/umcg/Makefile b/tools/testing/selftests/umcg/Makefile
index b151098e2ed1..916897d82e53 100644
--- a/tools/testing/selftests/umcg/Makefile
+++ b/tools/testing/selftests/umcg/Makefile
@@ -6,8 +6,10 @@ LIBUMCGDIR := $(TOOLSDIR)/lib/umcg
 CFLAGS += -g -O0 -I$(LIBUMCGDIR) -I$(TOOLSDIR)/include/ -I../../../../usr/include/
 LDLIBS += -lpthread -static
 
-TEST_GEN_PROGS := umcg_core_test
+TEST_GEN_PROGS := umcg_core_test umcg_test
 
 include ../lib.mk
 
 $(OUTPUT)/umcg_core_test: umcg_core_test.c $(LIBUMCGDIR)/libumcg.c
+
+$(OUTPUT)/umcg_test: umcg_test.c $(LIBUMCGDIR)/libumcg.c
diff --git a/tools/testing/selftests/umcg/umcg_test.c b/tools/testing/selftests/umcg/umcg_test.c
new file mode 100644
index 000000000000..2c01a61ec3f4
--- /dev/null
+++ b/tools/testing/selftests/umcg/umcg_test.c
@@ -0,0 +1,475 @@
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
+	int ret = sys_umcg_api_version(1, 0);	\
+								\
+	if (ret == -1 && errno == ENOSYS)			\
+		SKIP(return, "CONFIG_UMCG not set");	\
+}
+
+struct worker_args {
+	umcg_t		group;  /* Which group the worker should join. */
+	umcg_tid	utid;   /* This worker's utid. */
+	void *(*thread_fn)(void *);  /* Function to run. */
+	void		*thread_arg;
+	intptr_t	tag;
+};
+
+static void validate_state(umcg_tid utid, u32 expected, const char *ctx)
+{
+	u32 state = umcg_get_task_state(utid);
+
+	if (state == expected)
+		return;
+
+	fprintf(stderr, "BAD state for %ld: expected: %u; got: %u; ctx :%s\n",
+			utid, expected, state, ctx);
+	exit(1);
+}
+
+static void *worker_fn(void *arg)
+{
+	void *result;
+	umcg_tid utid;
+	struct worker_args *args = (struct worker_args *)arg;
+
+	validate_state(umcg_get_utid(), UMCG_TASK_NONE, "worker_fn start");
+
+	atomic_thread_fence(memory_order_acquire);
+	atomic_store_explicit(&args->utid, umcg_get_utid(),
+			memory_order_seq_cst);
+
+	utid = umcg_register_worker(args->group, args->tag);
+	if (args->utid != utid) {
+		fprintf(stderr, "umcg_register_worker failed.\n");
+		exit(1);
+	}
+	validate_state(umcg_get_utid(), UMCG_TASK_RUNNING, "worker_fn in");
+
+	/* Fence args->thread_arg */
+	atomic_thread_fence(memory_order_acquire);
+
+	result = args->thread_fn(args->thread_arg);
+	validate_state(umcg_get_utid(), UMCG_TASK_RUNNING, "worker_fn out");
+
+	if (umcg_unregister_task()) {
+		fprintf(stderr, "umcg_unregister_task failed.\n");
+		exit(1);
+	}
+	validate_state(umcg_get_utid(), UMCG_TASK_NONE, "worker_fn finish");
+
+	return result;
+}
+
+static void *simple_running_worker(void *arg)
+{
+	bool *checkpoint = (bool *)arg;
+
+	atomic_store_explicit(checkpoint, true, memory_order_relaxed);
+	return NULL;
+}
+
+TEST(umcg_poll_run_test) {
+	pthread_t worker;
+	bool checkpoint = false;
+	struct worker_args worker_args;
+
+	CHECK_CONFIG();
+
+	worker_args.utid = UMCG_NONE;
+	worker_args.group = umcg_create_group(0);
+	ASSERT_NE(UMCG_NONE, worker_args.group);
+
+	worker_args.thread_fn = &simple_running_worker;
+	worker_args.thread_arg = &checkpoint;
+	worker_args.tag = 0;
+
+	ASSERT_EQ(0, pthread_create(&worker, NULL, &worker_fn, &worker_args));
+
+	/* Wait for the worker to start. */
+	while (UMCG_NONE == atomic_load_explicit(&worker_args.utid,
+				memory_order_relaxed))
+		;
+
+	/*
+	 * Make sure that the worker does not checkpoint until the server
+	 * runs it.
+	 */
+	usleep(1000);
+	ASSERT_FALSE(atomic_load_explicit(&checkpoint, memory_order_relaxed));
+
+	ASSERT_NE(0, umcg_register_server(worker_args.group, 0));
+
+	/*
+	 * Run the worker until it exits. Need to loop because the worker
+	 * may pagefault and wake the server.
+	 */
+	do {
+		u32 state;
+
+		/* Poll the worker. */
+		ASSERT_EQ(worker_args.utid, umcg_poll_worker());
+		validate_state(worker_args.utid, UMCG_TASK_RUNNABLE, "wns poll");
+
+		umcg_tid utid = umcg_run_worker(worker_args.utid);
+		if (utid == UMCG_NONE) {
+			ASSERT_EQ(0, errno);
+			break;
+		}
+
+		ASSERT_EQ(utid, worker_args.utid);
+
+		state = umcg_get_task_state(utid);
+		ASSERT_TRUE(state == UMCG_TASK_BLOCKED || UMCG_TASK_UNBLOCKED);
+	} while (true);
+
+	ASSERT_TRUE(atomic_load_explicit(&checkpoint, memory_order_relaxed));
+
+	/* Can't destroy group while this thread still belongs to it. */
+	ASSERT_NE(0, umcg_destroy_group(worker_args.group));
+	ASSERT_EQ(0, umcg_unregister_task());
+	ASSERT_EQ(0, umcg_destroy_group(worker_args.group));
+	ASSERT_EQ(0, pthread_join(worker, NULL));
+}
+
+static void *sleeping_worker(void *arg)
+{
+	int *checkpoint = (int *)arg;
+
+	atomic_store_explicit(checkpoint, 1, memory_order_relaxed);
+	usleep(2000);
+	atomic_store_explicit(checkpoint, 2, memory_order_relaxed);
+
+	return NULL;
+}
+
+TEST(umcg_sleep_test) {
+	pthread_t worker;
+	u32 state;
+	int checkpoint = 0;
+	struct worker_args worker_args;
+
+	CHECK_CONFIG();
+
+	worker_args.utid = UMCG_NONE;
+	worker_args.group = umcg_create_group(0);
+	ASSERT_NE(UMCG_NONE, worker_args.group);
+
+	worker_args.thread_fn = &sleeping_worker;
+	worker_args.thread_arg = &checkpoint;
+	worker_args.tag = 0;
+
+	ASSERT_EQ(0, pthread_create(&worker, NULL, &worker_fn, &worker_args));
+
+	/* Wait for the worker to start. */
+	while (UMCG_NONE == atomic_load_explicit(&worker_args.utid,
+				memory_order_relaxed))
+		;
+
+	/*
+	 * Make sure that the worker does not checkpoint until the server
+	 * runs it.
+	 */
+	usleep(1000);
+	ASSERT_EQ(0, atomic_load_explicit(&checkpoint, memory_order_relaxed));
+
+	validate_state(umcg_get_utid(), UMCG_TASK_NONE, "sws prereg");
+
+	ASSERT_NE(0, umcg_register_server(worker_args.group, 0));
+
+	validate_state(umcg_get_utid(), UMCG_TASK_PROCESSING, "sws postreg");
+
+	/*
+	 * Run the worker until it checkpoints 1. Need to loop because
+	 * the worker may pagefault and wake the server.
+	 */
+	do {
+		ASSERT_EQ(worker_args.utid, umcg_poll_worker());
+		validate_state(worker_args.utid, UMCG_TASK_RUNNABLE,
+				"sws poll");
+
+		umcg_tid utid = umcg_run_worker(worker_args.utid);
+		ASSERT_EQ(utid, worker_args.utid);
+	} while (1 != atomic_load_explicit(&checkpoint, memory_order_relaxed));
+
+	state = umcg_get_task_state(worker_args.utid);
+	ASSERT_TRUE(state == UMCG_TASK_BLOCKED || UMCG_TASK_UNBLOCKED);
+	validate_state(umcg_get_utid(), UMCG_TASK_PROCESSING, "sws mid");
+
+	/* The worker cannot reach checkpoint 2 without the server running it. */
+	usleep(2000);
+	ASSERT_EQ(1, atomic_load_explicit(&checkpoint, memory_order_relaxed));
+
+	state = umcg_get_task_state(worker_args.utid);
+	ASSERT_TRUE(state == UMCG_TASK_BLOCKED || UMCG_TASK_UNBLOCKED);
+
+	/* Run the worker until it exits. */
+	do {
+		ASSERT_EQ(worker_args.utid, umcg_poll_worker());
+		umcg_tid utid = umcg_run_worker(worker_args.utid);
+		if (utid == UMCG_NONE) {
+			ASSERT_EQ(0, errno);
+			break;
+		}
+
+		ASSERT_EQ(utid, worker_args.utid);
+	} while (true);
+
+	/* The final check and cleanup. */
+	ASSERT_EQ(2, atomic_load_explicit(&checkpoint, memory_order_relaxed));
+	validate_state(umcg_get_utid(), UMCG_TASK_PROCESSING, "sws preunreg");
+	ASSERT_EQ(0, pthread_join(worker, NULL));
+	ASSERT_EQ(0, umcg_unregister_task());
+	validate_state(umcg_get_utid(), UMCG_TASK_NONE, "sws postunreg");
+	ASSERT_EQ(0, umcg_destroy_group(worker_args.group));
+}
+
+static void *waiting_worker(void *arg)
+{
+	int *checkpoint = (int *)arg;
+
+	atomic_store_explicit(checkpoint, 1, memory_order_relaxed);
+	if (umcg_wait(NULL)) {
+		fprintf(stderr, "umcg_wait() failed.\n");
+		exit(1);
+	}
+	atomic_store_explicit(checkpoint, 2, memory_order_relaxed);
+
+	return NULL;
+}
+
+TEST(umcg_wait_wake_test) {
+	pthread_t worker;
+	int checkpoint = 0;
+	struct worker_args worker_args;
+
+	CHECK_CONFIG();
+
+	worker_args.utid = UMCG_NONE;
+	worker_args.group = umcg_create_group(0);
+	ASSERT_NE(UMCG_NONE, worker_args.group);
+
+	worker_args.thread_fn = &waiting_worker;
+	worker_args.thread_arg = &checkpoint;
+	worker_args.tag = 0;
+
+	ASSERT_EQ(0, pthread_create(&worker, NULL, &worker_fn, &worker_args));
+
+	/* Wait for the worker to start. */
+	while (UMCG_NONE == atomic_load_explicit(&worker_args.utid,
+				memory_order_relaxed))
+		;
+
+	/*
+	 * Make sure that the worker does not checkpoint until the server
+	 * runs it.
+	 */
+	usleep(1000);
+	ASSERT_EQ(0, atomic_load_explicit(&checkpoint, memory_order_relaxed));
+
+	ASSERT_NE(0, umcg_register_server(worker_args.group, 0));
+
+	/*
+	 * Run the worker until it checkpoints 1. Need to loop because
+	 * the worker may pagefault and wake the server.
+	 */
+	do {
+		ASSERT_EQ(worker_args.utid, umcg_poll_worker());
+		ASSERT_EQ(worker_args.utid, umcg_run_worker(worker_args.utid));
+	} while (1 != atomic_load_explicit(&checkpoint, memory_order_relaxed));
+
+	validate_state(worker_args.utid, UMCG_TASK_RUNNABLE, "wait_wake wait");
+
+	/* The worker cannot reach checkpoint 2 without the server waking it. */
+	usleep(2000);
+	ASSERT_EQ(1, atomic_load_explicit(&checkpoint, memory_order_relaxed));
+	validate_state(worker_args.utid, UMCG_TASK_RUNNABLE, "wait_wake wait");
+
+
+	ASSERT_EQ(0, umcg_wake(worker_args.utid));
+
+	/*
+	 * umcg_wake() above marks the worker as RUNNING; it will become
+	 * UNBLOCKED upon wakeup as it does not have a server. But this may
+	 * be delayed.
+	 */
+	while (umcg_get_task_state(worker_args.utid) != UMCG_TASK_UNBLOCKED)
+		;
+
+	/* The worker cannot reach checkpoint 2 without the server running it. */
+	usleep(2000);
+	ASSERT_EQ(1, atomic_load_explicit(&checkpoint, memory_order_relaxed));
+
+	/* Run the worker until it exits. */
+	do {
+		ASSERT_EQ(worker_args.utid, umcg_poll_worker());
+		umcg_tid utid = umcg_run_worker(worker_args.utid);
+		if (utid == UMCG_NONE) {
+			ASSERT_EQ(0, errno);
+			break;
+		}
+
+		ASSERT_EQ(utid, worker_args.utid);
+	} while (true);
+
+	/* The final check and cleanup. */
+	ASSERT_EQ(2, atomic_load_explicit(&checkpoint, memory_order_relaxed));
+	ASSERT_EQ(0, pthread_join(worker, NULL));
+	ASSERT_EQ(0, umcg_unregister_task());
+	ASSERT_EQ(0, umcg_destroy_group(worker_args.group));
+}
+
+static void *swapping_worker(void *arg)
+{
+	umcg_tid next;
+
+	atomic_thread_fence(memory_order_acquire);
+	next = (umcg_tid)arg;
+
+	if (next == UMCG_NONE) {
+		if (0 != umcg_wait(NULL)) {
+			fprintf(stderr, "swapping_worker: umcg_wait failed\n");
+			exit(1);
+		}
+	} else {
+		if (0 != umcg_swap(next, NULL)) {
+			fprintf(stderr, "swapping_worker: umcg_swap failed\n");
+			exit(1);
+		}
+	}
+
+	return NULL;
+}
+
+TEST(umcg_swap_test) {
+	const int n_workers = 10;
+	struct worker_args *worker_args;
+	int swap_chain_wakeups = 0;
+	umcg_tid utid = UMCG_NONE;
+	bool *workers_polled;
+	pthread_t *workers;
+	umcg_t group_id;
+	int idx;
+
+	CHECK_CONFIG();
+
+	group_id = umcg_create_group(0);
+	ASSERT_NE(UMCG_NONE, group_id);
+
+	workers = malloc(n_workers * sizeof(pthread_t));
+	worker_args = malloc(n_workers * sizeof(struct worker_args));
+	workers_polled = malloc(n_workers * sizeof(bool));
+	if (!workers || !worker_args || !workers_polled) {
+		fprintf(stderr, "malloc failed\n");
+		exit(1);
+	}
+
+	memset(worker_args, 0, n_workers * sizeof(struct worker_args));
+
+	/* Start workers. All will block in umcg_register_worker(). */
+	for (idx = 0; idx < n_workers; ++idx) {
+		workers_polled[idx] = false;
+
+		worker_args[idx].group = group_id;
+		worker_args[idx].thread_fn = &swapping_worker;
+		worker_args[idx].tag = idx;
+		atomic_thread_fence(memory_order_release);
+
+		ASSERT_EQ(0, pthread_create(&workers[idx], NULL, &worker_fn,
+					&worker_args[idx]));
+	}
+
+	/* Wait for all workers to update their utids. */
+	for (idx = 0; idx < n_workers; ++idx) {
+		uint64_t counter = 0;
+		while (UMCG_NONE == atomic_load_explicit(&worker_args[idx].utid,
+					memory_order_seq_cst)) {
+			++counter;
+			if (!(counter % 1000000))
+				fprintf(stderr, "looping for utid: %d %lu\n",
+						idx, counter);
+		}
+	}
+
+	/* Update worker args. */
+	for (idx = 0; idx < (n_workers - 1); ++idx) {
+		worker_args[idx].thread_arg = (void *)worker_args[idx + 1].utid;
+	}
+	atomic_thread_fence(memory_order_release);
+
+	ASSERT_NE(0, umcg_register_server(group_id, 0));
+
+	/* Poll workers. */
+	for (idx = 0; idx < n_workers; ++idx) {
+		utid = umcg_poll_worker();
+
+		ASSERT_NE(UMCG_NONE, utid);
+		workers_polled[umcg_get_task_tag(utid)] = true;
+
+		validate_state(utid, UMCG_TASK_RUNNABLE, "swap poll");
+	}
+
+	/* Check that all workers have been polled. */
+	for (idx = 0; idx < n_workers; ++idx) {
+		ASSERT_TRUE(workers_polled[idx]);
+	}
+
+	/* Run the first worker; the swap chain will lead to the last worker. */
+	utid = worker_args[0].utid;
+	idx = 0;
+	do {
+		uint32_t state;
+
+		utid = umcg_run_worker(utid);
+		if (utid == worker_args[n_workers - 1].utid &&
+				umcg_get_task_state(utid) == UMCG_TASK_RUNNABLE)
+			break;
+
+		/* There can be an occasional mid-swap wakeup due to pagefault. */
+		++swap_chain_wakeups;
+
+		/* Validate progression. */
+		ASSERT_GE(umcg_get_task_tag(utid), idx);
+		idx = umcg_get_task_tag(utid);
+
+		/* Validate state. */
+		state = umcg_get_task_state(utid);
+		ASSERT_TRUE(state == UMCG_TASK_BLOCKED ||
+				state == UMCG_TASK_UNBLOCKED);
+
+		ASSERT_EQ(utid, umcg_poll_worker());
+	} while (true);
+
+	ASSERT_LT(swap_chain_wakeups, 4);
+	if (swap_chain_wakeups)
+		fprintf(stderr, "WARNING: %d swap chain wakeups\n",
+				swap_chain_wakeups);
+
+	/* Finally run/release all workers. */
+	for (idx = 0; idx < n_workers; ++idx) {
+		utid = worker_args[idx].utid;
+		do {
+			utid = umcg_run_worker(utid);
+			if (utid) {
+				ASSERT_EQ(utid, worker_args[idx].utid);
+				ASSERT_EQ(utid, umcg_poll_worker());
+			}
+		} while (utid != UMCG_NONE);
+	}
+
+	/* Cleanup. */
+	for (idx = 0; idx < n_workers; ++idx)
+		ASSERT_EQ(0, pthread_join(workers[idx], NULL));
+	ASSERT_EQ(0, umcg_unregister_task());
+	ASSERT_EQ(0, umcg_destroy_group(group_id));
+}
+
+TEST_HARNESS_MAIN
-- 
2.31.1.818.g46aad6cb9e-goog


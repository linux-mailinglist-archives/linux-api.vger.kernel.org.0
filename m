Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFCF5459677
	for <lists+linux-api@lfdr.de>; Mon, 22 Nov 2021 22:13:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240166AbhKVVQq (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 22 Nov 2021 16:16:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240114AbhKVVQo (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 22 Nov 2021 16:16:44 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9CAFC061574
        for <linux-api@vger.kernel.org>; Mon, 22 Nov 2021 13:13:36 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id n8so15209500plf.4
        for <linux-api@vger.kernel.org>; Mon, 22 Nov 2021 13:13:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=posk.io; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pVmGx19ELVDuoPXPzIXomJWLTrmq641OjBjYtrakPX4=;
        b=by6UX2qTm/oXUn32V0DBl5uO9cBZZATnhfwCuQCUrupzZ63zUi4QAEd6i3MlQK1f8h
         6h0Vxs9m120PcMk2jvlLurGC8MJf/mlDTuWG2GMzZg8zoc1OojqaNHRteXkj1QGeTohL
         WIUer9r45OV/DufSSXpa0pFqdnSxwuGHHC1Pt5quwFTMYLTvtEhmpUv1qgzTvZh6pZY2
         P6HBvj8NgPiauVNAp/ROp0kGxa4N/1CFUnwAzlxLARePv7kCm8V6NtH+OmVbtTHrUsMB
         rKcfdgdW6PBPPBSLvhU+jAhf0Bf96RTFhF7X7ZsTSEthHxSTXdjs98y8KY4zvPjFThqB
         CGRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pVmGx19ELVDuoPXPzIXomJWLTrmq641OjBjYtrakPX4=;
        b=SghdoMYSYRjXk0wgUP6vOsa1Z48ezTDxRXuohBh5q1q952wGX8Cs7dy9UyRUICv3El
         SsknrM9WL/Cc3gFpDdqRA356Y3hgFG/t9Id6vP1ZtdsoWF7ona2QXq5gN/JE6OJ9OacE
         8Ve7h1aJLcmZfswz9/ybeaYQJcq+TwIUEgCvYJd1vbMfHu7HM3fonHFI0OeIuzYyzXw2
         uRc/jb6yX0Wvvpt3bAk0wdJ2vsPM1YZddMG28zJjOEeBn8DnRLcEcTaRDO+QKCHqxp1m
         W5RMexHNZ9iJdWeBK5q/dYS1LoUEbXwK0ixkmh2q0dJLqyFuGXh6brA4s2WY2STxFfeY
         6dUA==
X-Gm-Message-State: AOAM531oYJMFHCFyqzf+YIDU0Ijr+iuyUtpggL0+zjC3zv/hQ8fMiWwF
        9BYn0VhORzmBM8dCFP3+PS5ljA==
X-Google-Smtp-Source: ABdhPJyK47aF05/ogxZKRXc7zO1G7xp8LHCy+vvJqkLWxdqdrbwE0zNeMtv0Y43OG6pEsKhbcCZPtQ==
X-Received: by 2002:a17:90a:3488:: with SMTP id p8mr36163593pjb.114.1637615615903;
        Mon, 22 Nov 2021 13:13:35 -0800 (PST)
Received: from posk-p1g4.localdomain (23-118-52-46.lightspeed.sntcca.sbcglobal.net. [23.118.52.46])
        by smtp.gmail.com with ESMTPSA id h3sm10453671pfi.207.2021.11.22.13.13.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Nov 2021 13:13:35 -0800 (PST)
From:   Peter Oskolkov <posk@posk.io>
X-Google-Original-From: Peter Oskolkov <posk@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Cc:     Paul Turner <pjt@google.com>, Ben Segall <bsegall@google.com>,
        Peter Oskolkov <posk@google.com>,
        Peter Oskolkov <posk@posk.io>,
        Andrei Vagin <avagin@google.com>, Jann Horn <jannh@google.com>,
        Thierry Delisle <tdelisle@uwaterloo.ca>
Subject: [PATCH v0.9.1 4/6] sched/umcg, lib/umcg: implement libumcg
Date:   Mon, 22 Nov 2021 13:13:25 -0800
Message-Id: <20211122211327.5931-5-posk@google.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211122211327.5931-1-posk@google.com>
References: <20211122211327.5931-1-posk@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Implement libumcg in tools/lib/umcg. Define higher-level UMCG
API that hides kernel-level UMCG API intricacies.

As a higher-level API, libumcg makes subtle changes to server/worker
interactions, compared to the kernel UMCG API, and introduces
the following new concepts:

- UMCG Group: a collection of servers and workers in a process
  that can interact with each other; UMCG groups are useful to
  partition servers and workers within a process in order to, for
  example, affine work to specific NUMA nodes;
- UMCG basic tasks: these are UMCG servers, from the kernel point
  of view; they do not interact with UMCG workers and thus
  do not need in UMCG groups; used for cooperative wait/wake/swap
  operations.

The main difference of server/worker interaction in libumcg
vs the kernel-side UMCG API is that a wakeup can be queued:
if umcg_wake() is called on a RUNNING UMCG task, the fact is
recorded (in the userspace), and when the task calls umcg_wait()
or umcg_swap(), the wakeup is consumed and the task is not
marked IDLE.

Libumcg exports the following API:
        umcg_enabled()
        umcg_get_utid()
        umcg_set_task_tag()
        umcg_get_task_tag()
        umcg_create_group()
        umcg_destroy_group()
        umcg_register_basic_task()
        umcg_register_worker()
        umcg_register_server()
        umcg_unregister_task()
        umcg_wait()
        umcg_wake()
        umcg_swap()
        umcg_get_idle_worker()
        umcg_run_worker()
        umcg_preempt_worker()
        umcg_get_time_ns()

See tools/lib/umcg/libumcg.txt for details.

Notes:
- this is still somewhat work-in-progress: while the kernel side
  code has been more or less stable over the last couple of months,
  the userspace side of things is less so;
- while libumcg is intended to be the main/primary/only direct user
  of the kernel UMCG API, at the moment the implementation is more
  geared more towards testing and correctness than live production
  usage, with a lot of asserts and similar development helpers;
- I have a number of umcg selftests that I plan to clean up and
  post shortly.

Signed-off-by: Peter Oskolkov <posk@google.com>
---
 tools/lib/umcg/.gitignore |    4 +
 tools/lib/umcg/Makefile   |   11 +
 tools/lib/umcg/libumcg.c  | 1202 +++++++++++++++++++++++++++++++++++++
 tools/lib/umcg/libumcg.h  |  299 +++++++++
 4 files changed, 1516 insertions(+)
 create mode 100644 tools/lib/umcg/.gitignore
 create mode 100644 tools/lib/umcg/Makefile
 create mode 100644 tools/lib/umcg/libumcg.c
 create mode 100644 tools/lib/umcg/libumcg.h

diff --git a/tools/lib/umcg/.gitignore b/tools/lib/umcg/.gitignore
new file mode 100644
index 000000000000..ea55ae666041
--- /dev/null
+++ b/tools/lib/umcg/.gitignore
@@ -0,0 +1,4 @@
+PDX-License-Identifier: GPL-2.0-only
+libumcg.a
+libumcg.o
+
diff --git a/tools/lib/umcg/Makefile b/tools/lib/umcg/Makefile
new file mode 100644
index 000000000000..cef44b681cb1
--- /dev/null
+++ b/tools/lib/umcg/Makefile
@@ -0,0 +1,11 @@
+# SPDX-License-Identifier: GPL-2.0
+
+CFLAGS += -g -I../../include/ -I../../../usr/include/ -Wall -Werror
+
+libumcg.a: libumcg.o
+	ar rc libumcg.a libumcg.o
+
+libumcg.o: libumcg.c
+
+clean :
+	rm libumcg.a libumcg.o
diff --git a/tools/lib/umcg/libumcg.c b/tools/lib/umcg/libumcg.c
new file mode 100644
index 000000000000..8f8dfd515712
--- /dev/null
+++ b/tools/lib/umcg/libumcg.c
@@ -0,0 +1,1202 @@
+// SPDX-License-Identifier: GPL-2.0
+#define _GNU_SOURCE
+#include "libumcg.h"
+
+#include <assert.h>
+#include <errno.h>
+#include <pthread.h>
+#include <signal.h>
+#include <stdatomic.h>
+#include <stdbool.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <threads.h>
+#include <time.h>
+
+#include <linux/kernel.h>
+
+static int sys_umcg_ctl(uint32_t flags, struct umcg_task *umcg_task)
+{
+	return syscall(__NR_umcg_ctl, flags, umcg_task);
+}
+
+static int sys_umcg_wait(uint32_t flags, uint64_t abs_timeout)
+{
+	return syscall(__NR_umcg_wait, flags, abs_timeout);
+}
+
+bool umcg_enabled(void)
+{
+	int ret = sys_umcg_ctl(UMCG_CTL_REGISTER, NULL);
+
+	if (ret && errno == EINVAL)
+		return true;
+
+	return false;
+}
+
+uint64_t umcg_get_time_ns(void)
+{
+	struct timespec ts;
+
+	if (clock_gettime(CLOCK_REALTIME, &ts)) {
+		fprintf(stderr, "clock_gettime failed\n");
+		abort();
+	}
+
+	return ts.tv_sec * NSEC_PER_SEC + ts.tv_nsec;
+}
+
+struct umcg_task_tls;
+
+/**
+ * struct umcg_group - describes UMCG group.
+ *
+ * See tools/lib/umcg/libumcg.txt for detals.
+ */
+struct umcg_group {
+	/**
+	 * @idle_workers_head: points to the kernel-side list of idle
+	 *                     workers, i.e. the address of this field
+	 *                     is passed to the kernel in
+	 *                     struct umcg_task.idle_workers_ptr.
+	 */
+	uint64_t		idle_workers_head;
+
+	/**
+	 * @nr_tasks: the number of tasks (servers and workers) registered
+	 *            in this group.
+	 */
+	uint64_t		nr_tasks;
+
+	/**
+	 * @idle_worker_lock: protects @idle_workers below.
+	 */
+	pthread_spinlock_t	idle_worker_lock;
+
+	/**
+	 * @idle_server_lock: protects @idle_servers below.
+	 */
+	pthread_spinlock_t	idle_server_lock;
+
+	/**
+	 * @idle_workers: points to the userspace-side list of idle workers.
+	 *
+	 * When a server polls for an idle worker via umcg_poll_worker(),
+	 * the server first consults @idle_workers; if the list is empty,
+	 * the value of the variable is swapped with @idle_workers_head.
+	 */
+	uint64_t		*idle_workers;
+
+	/**
+	 * @idle_servers: points to the userspace-side list of idle servers.
+	 *
+	 * When a server polls for an idle worker via umcg_poll_worker(),
+	 * and none is available, the server is added to the list and blocks
+	 * via sys_umcg_wait().
+	 */
+	struct umcg_task_tls	*idle_servers;
+
+	/**
+	 * @idle_server_tid: the TID of one of the idle servers.
+	 *
+	 * The address of this field is passed to the kernel in
+	 * struct umct_task.idle_server_tid_ptr.
+	 */
+	uint32_t		idle_server_tid;
+} __attribute((aligned(8)));
+
+/**
+ * struct umcg_task_tls - per thread struct used to identify/manage UMCG tasks
+ *
+ * Each UMCG task requires an instance of struct umcg_task passed to
+ * sys_umcg_ctl. This struct contains it, as well as several additional
+ * fields useful for the userspace UMCG API.
+ *
+ * The alignment is driven by the alignment of struct umcg_task.
+ */
+struct umcg_task_tls {
+	struct umcg_task	umcg_task;
+	struct umcg_group	*group;  /* read only */
+	umcg_tid		peer;    /* server or worker or UMCG_NONE */
+	umcg_tid		self;    /* read only */
+	intptr_t		tag;
+	pid_t			tid;     /* read only */
+	bool			worker;  /* read only */
+
+	struct umcg_task_tls	*next;   /* used in group->idle_servers */
+} __attribute((aligned(8 * sizeof(uint64_t))));
+
+static thread_local struct umcg_task_tls *umcg_task_tls;
+
+umcg_tid umcg_get_utid(void)
+{
+	return (umcg_tid)&umcg_task_tls;
+}
+
+static struct umcg_task_tls *utid_to_utls(umcg_tid utid)
+{
+	assert(utid != UMCG_NONE);
+	return *(struct umcg_task_tls **)utid;
+}
+
+uint64_t umcg_get_task_state(umcg_tid task)
+{
+	struct umcg_task_tls *utls = utid_to_utls(task);
+	uint64_t state;
+
+	if (!utls)
+		return UMCG_TASK_NONE;
+
+	state = atomic_load_explicit(&utls->umcg_task.state_ts, memory_order_acquire);
+	return state & UMCG_TASK_STATE_MASK_FULL;
+}
+
+/* Update the state variable, set new timestamp. */
+static bool umcg_update_state(uint64_t *state, uint64_t *prev, uint64_t next)
+{
+	uint64_t prev_ts = (*prev) >> (64 - UMCG_STATE_TIMESTAMP_BITS);
+	struct timespec now;
+	uint64_t next_ts;
+	int res;
+
+	/*
+	 * clock_gettime(CLOCK_MONOTONIC, ...) takes less than 20ns on a
+	 * typical Intel processor on average, even when run concurrently,
+	 * so the overhead is low enough for most applications.
+	 *
+	 * If this is still too high, `next_ts = prev_ts + 1` should work
+	 * as well. The only real requirement is that the "timestamps" are
+	 * uniqueue per thread within a reasonable time frame.
+	 */
+	res = clock_gettime(CLOCK_MONOTONIC, &now);
+	assert(!res);
+	next_ts = (now.tv_sec * NSEC_PER_SEC + now.tv_nsec) >>
+		UMCG_STATE_TIMESTAMP_GRANULARITY;
+
+	/* Cut higher order bits. */
+	next_ts &= ((1ULL << UMCG_STATE_TIMESTAMP_BITS) - 1);
+
+	if (next_ts == prev_ts)
+		++next_ts;
+
+#ifndef NDEBUG
+	if (prev_ts > next_ts) {
+		fprintf(stderr, "%s: time goes back: prev_ts: %lu "
+				"next_ts: %lu diff: %lu\n", __func__,
+				prev_ts, next_ts, prev_ts - next_ts);
+	}
+#endif
+
+	/* Remove old timestamp, if any. */
+	next &= ((1ULL << (64 - UMCG_STATE_TIMESTAMP_BITS)) - 1);
+
+	/* Set the new timestamp. */
+	next |= (next_ts << (64 - UMCG_STATE_TIMESTAMP_BITS));
+
+	/*
+	 * TODO: review whether memory order below can be weakened to
+	 * memory_order_acq_rel for success and memory_order_acquire for
+	 * failure.
+	 */
+	return atomic_compare_exchange_strong_explicit(state, prev, next,
+			memory_order_seq_cst, memory_order_seq_cst);
+}
+
+static bool umcg_worker_in_idle_queue(umcg_tid worker)
+{
+	struct umcg_task_tls *worker_utls = utid_to_utls(worker);
+	struct umcg_task *worker_ut = &worker_utls->umcg_task;
+
+	assert(worker_utls->worker);
+
+	return (uint64_t)&worker_utls->group->idle_workers_head !=
+		atomic_load_explicit(&worker_ut->idle_workers_ptr,
+					memory_order_acquire);
+}
+
+void umcg_set_task_tag(umcg_tid utid, intptr_t tag)
+{
+	utid_to_utls(utid)->tag = tag;
+}
+
+intptr_t umcg_get_task_tag(umcg_tid utid)
+{
+	return utid_to_utls(utid)->tag;
+}
+
+static bool try_task_lock(struct umcg_task_tls *task, uint64_t expected_state,
+				uint64_t new_state)
+{
+	uint64_t next;
+	uint64_t prev = atomic_load_explicit(&task->umcg_task.state_ts,
+				memory_order_acquire);
+
+	if (prev & UMCG_TF_LOCKED)
+		return false;
+
+	if ((prev & UMCG_TASK_STATE_MASK) != expected_state)
+		return false;
+
+	next = (prev & ~UMCG_TASK_STATE_MASK) | new_state | UMCG_TF_LOCKED;
+	return umcg_update_state((uint64_t *)&task->umcg_task.state_ts, &prev, next);
+}
+
+static void task_lock(struct umcg_task_tls *task, uint64_t expected_state,
+			uint64_t new_state)
+{
+	int loop_counter = 0;
+
+	while (!try_task_lock(task, expected_state, new_state))
+		assert(++loop_counter < 1000 * 1000 * 100);
+}
+
+static void task_unlock(struct umcg_task_tls *task, uint64_t expected_state,
+		uint64_t new_state)
+{
+	bool ok;
+	uint64_t next;
+	uint64_t prev = atomic_load_explicit((uint64_t *)&task->umcg_task.state_ts,
+					memory_order_acquire);
+
+	next = ((prev & ~UMCG_TASK_STATE_MASK_FULL) | new_state) & ~UMCG_TF_LOCKED;
+	assert(next != prev);
+	assert((prev & UMCG_TASK_STATE_MASK_FULL & ~UMCG_TF_LOCKED) == expected_state);
+
+	ok = umcg_update_state((uint64_t *)&task->umcg_task.state_ts, &prev, next);
+	assert(ok);
+}
+
+umcg_tid umcg_register_basic_task(intptr_t tag)
+{
+	int ret;
+
+	if (umcg_task_tls != NULL) {
+		errno = EINVAL;
+		return UMCG_NONE;
+	}
+
+	umcg_task_tls = malloc(sizeof(struct umcg_task_tls));
+	if (!umcg_task_tls) {
+		errno = ENOMEM;
+		return UMCG_NONE;
+	}
+	memset(umcg_task_tls, 0, sizeof(struct umcg_task_tls));
+
+	umcg_task_tls->umcg_task.state_ts = UMCG_TASK_RUNNING;
+	umcg_task_tls->self = (umcg_tid)&umcg_task_tls;
+	umcg_task_tls->tag = tag;
+	umcg_task_tls->tid = gettid();
+
+	ret = sys_umcg_ctl(UMCG_CTL_REGISTER, &umcg_task_tls->umcg_task);
+	if (ret) {
+		free(umcg_task_tls);
+		umcg_task_tls = NULL;
+		errno = ret;
+		return UMCG_NONE;
+	}
+
+	return umcg_task_tls->self;
+}
+
+static umcg_tid umcg_register_task_in_group(umcg_t group_id, intptr_t tag,
+						bool server)
+{
+	int ret;
+	uint32_t self_tid;
+	struct umcg_group *group;
+	struct umcg_task_tls *curr;
+
+	if (group_id == UMCG_NONE) {
+		errno = EINVAL;
+		return UMCG_NONE;
+	}
+
+	if (umcg_task_tls != NULL) {
+		errno = EINVAL;
+		return UMCG_NONE;
+	}
+
+	group = (struct umcg_group *)group_id;
+
+	curr = malloc(sizeof(struct umcg_task_tls));
+	if (!curr) {
+		errno = ENOMEM;
+		return UMCG_NONE;
+	}
+	memset(curr, 0, sizeof(struct umcg_task_tls));
+
+	self_tid = gettid();
+	curr->umcg_task.state_ts = server ? UMCG_TASK_RUNNING : UMCG_TASK_BLOCKED;
+	curr->umcg_task.idle_server_tid_ptr = server ? 0UL :
+		(uint64_t)&group->idle_server_tid;
+	curr->umcg_task.idle_workers_ptr =
+		(uint64_t)&group->idle_workers_head;
+	curr->group = group;
+	curr->tag = tag;
+	curr->tid = self_tid;
+	curr->self = (umcg_tid)&umcg_task_tls;
+	curr->worker = !server;
+
+	/*
+	 * Need to set umcg_task_tls before registering, as a server
+	 * may pick up this worker immediately, and use @self.
+	 */
+	atomic_store_explicit(&umcg_task_tls, curr, memory_order_release);
+
+	ret = sys_umcg_ctl(server ? UMCG_CTL_REGISTER :
+					UMCG_CTL_REGISTER | UMCG_CTL_WORKER,
+				&curr->umcg_task);
+	if (ret) {
+		free(curr);
+		errno = ret;
+		atomic_store_explicit(&umcg_task_tls, NULL, memory_order_release);
+		return UMCG_NONE;
+	}
+
+	atomic_fetch_add_explicit(&group->nr_tasks, 1, memory_order_relaxed);
+
+	return umcg_task_tls->self;
+}
+
+umcg_tid umcg_register_worker(umcg_t group_id, intptr_t tag)
+{
+	return umcg_register_task_in_group(group_id, tag, false);
+}
+
+umcg_tid umcg_register_server(umcg_t group_id, intptr_t tag)
+{
+	return umcg_register_task_in_group(group_id, tag, true);
+}
+
+int umcg_unregister_task(void)
+{
+	int ret;
+
+	if (!umcg_task_tls) {
+		errno = EINVAL;
+		return -1;
+	}
+
+	/* If this is a worker, wake the server. */
+	if (umcg_task_tls->worker) {
+		struct umcg_task_tls *curr = umcg_task_tls;
+		struct umcg_task_tls *utls_server;
+
+		task_lock(curr, UMCG_TASK_RUNNING, UMCG_TASK_IDLE);
+		utls_server = utid_to_utls(curr->peer);
+		assert(utls_server->tid == atomic_load_explicit(
+					&curr->umcg_task.next_tid,
+					memory_order_acquire));
+		curr->peer = UMCG_NONE;
+		atomic_store_explicit(&curr->umcg_task.next_tid, 0,
+				memory_order_release);
+
+		utls_server->peer = UMCG_NONE;
+		atomic_store_explicit(&utls_server->umcg_task.next_tid, 0,
+					memory_order_release);
+
+		/* Keep the worker locked to avoid needing the server. */
+		if (utls_server) {
+			curr->worker = false;  /* umcg_wake tries to lock */
+			ret = umcg_wake(utls_server->self, false);
+			assert(!ret || errno == ESRCH);
+		}
+	}
+
+	ret = sys_umcg_ctl(UMCG_CTL_UNREGISTER, NULL);
+	if (ret) {
+		errno = ret;
+		return -1;
+	}
+
+	if (umcg_task_tls->group)
+		atomic_fetch_sub_explicit(&umcg_task_tls->group->nr_tasks, 1,
+						memory_order_relaxed);
+
+	free(umcg_task_tls);
+	atomic_store_explicit(&umcg_task_tls, NULL, memory_order_release);
+	return 0;
+}
+
+/* Helper return codes. */
+enum umcg_prepare_op_result {
+	UMCG_OP_DONE,
+	UMCG_OP_SYS,
+	UMCG_OP_AGAIN,
+	UMCG_OP_ERROR
+};
+
+static enum umcg_prepare_op_result umcg_prepare_wait_may_lock(void)
+{
+	struct umcg_task *ut;
+	uint64_t prev_state, next_state;
+
+	if (!umcg_task_tls) {
+		errno = EINVAL;
+		return UMCG_OP_ERROR;
+	}
+
+	ut = &umcg_task_tls->umcg_task;
+
+	prev_state = atomic_load_explicit(&ut->state_ts, memory_order_acquire);
+	next_state = umcg_task_tls->worker ?
+		UMCG_TASK_IDLE | UMCG_TF_LOCKED | UMCG_UTF_WORKER_IN_WAIT :
+		UMCG_TASK_IDLE;
+	if (((prev_state & UMCG_TASK_STATE_MASK_FULL) == UMCG_TASK_RUNNING) &&
+		umcg_update_state((uint64_t *)&ut->state_ts, &prev_state, next_state))
+		return UMCG_OP_SYS;
+
+	if ((prev_state & UMCG_TASK_STATE_MASK_FULL) !=
+			(UMCG_TASK_RUNNING | UMCG_UTF_WAKEUP_QUEUED)) {
+#ifndef NDEBUG
+		fprintf(stderr, "libumcg: unexpected state before wait: %lu\n",
+				prev_state);
+		assert(false);
+#endif
+		errno = EINVAL;
+		return UMCG_OP_ERROR;
+	}
+
+	if (umcg_update_state((uint64_t *)&ut->state_ts, &prev_state, UMCG_TASK_RUNNING))
+		return UMCG_OP_DONE;
+
+#ifndef NDEBUG
+	/* Raced with another wait/wake? This is not supported. */
+	fprintf(stderr, "libumcg: failed to remove the wakeup flag: %lu\n",
+			prev_state);
+	assert(false);
+#endif
+	errno = EINVAL;
+	return UMCG_OP_ERROR;
+}
+
+/* Always return -1 because the user needs to see ETIMEDOUT in errno */
+static int handle_timedout(void)
+{
+	struct umcg_task *ut = &umcg_task_tls->umcg_task;
+	uint64_t umcg_state;
+
+retry:
+	/* Restore RUNNING state if the task is still IDLE. */
+	umcg_state = atomic_load_explicit(&ut->state_ts,
+			memory_order_acquire);
+	if ((umcg_state & UMCG_TASK_STATE_MASK) == UMCG_TASK_RUNNING)
+		return -1;
+
+	assert((umcg_state & UMCG_TASK_STATE_MASK) == UMCG_TASK_IDLE);
+
+	if (umcg_update_state((uint64_t *)&ut->state_ts, &umcg_state, UMCG_TASK_RUNNING))
+		return -1;
+
+	/* A wakeup could have been queued. */
+	goto retry;
+}
+
+static int umcg_do_wait(uint64_t timeout)
+{
+	struct umcg_task *ut = &umcg_task_tls->umcg_task;
+	uint32_t flags = 0;
+
+	/* If this is a worker, need to change the state of the server. */
+	if (umcg_task_tls->worker &&
+			atomic_load_explicit(&ut->next_tid, memory_order_acquire)) {
+		bool ok;
+		struct umcg_task *server_ut =
+			&utid_to_utls(umcg_task_tls->peer)->umcg_task;
+		uint64_t server_state = atomic_load_explicit(&server_ut->state_ts,
+				memory_order_acquire);
+
+		assert((server_state & UMCG_TASK_STATE_MASK_FULL) == UMCG_TASK_IDLE);
+		ok = umcg_update_state((uint64_t *)&server_ut->state_ts,
+				&server_state, UMCG_TASK_RUNNING);
+		assert(ok);
+	} else if (!umcg_task_tls->worker)
+		atomic_store_explicit(&ut->next_tid, 0, memory_order_release);
+
+	do {
+		uint64_t umcg_state;
+		int ret;
+
+		ret = sys_umcg_wait(flags, timeout);
+		if (!ret)
+			return 0;
+
+		if (ret && errno == EINTR) {
+			umcg_state = atomic_load_explicit(&ut->state_ts,
+					memory_order_acquire) & UMCG_TASK_STATE_MASK;
+			if (umcg_state == UMCG_TASK_RUNNING)
+				return 0;
+			continue;
+		}
+
+		if (errno == ETIMEDOUT)
+			return handle_timedout();
+
+		return -1;
+	} while (true);
+}
+
+int umcg_wait(uint64_t timeout)
+{
+	switch (umcg_prepare_wait_may_lock()) {
+	case UMCG_OP_DONE:
+		return 0;
+	case UMCG_OP_SYS:
+		break;
+	case UMCG_OP_ERROR:
+		return -1;
+	default:
+		assert(false);
+		return -1;
+	}
+
+	return umcg_do_wait(timeout);
+}
+
+static void enqueue_idle_worker(struct umcg_task_tls *utls)
+{
+	struct umcg_task *ut = &utls->umcg_task;
+	uint64_t *node = (uint64_t *)&ut->idle_workers_ptr;
+	uint64_t head = *node;
+	uint64_t *head_ptr = (uint64_t *)head;
+	uint64_t first = (uint64_t)node;
+
+	assert(utls->worker);
+	assert(&utls->group->idle_workers_head == head_ptr);
+
+	/* Mark the worker as pending. */
+	atomic_store_explicit(node, UMCG_IDLE_NODE_PENDING, memory_order_release);
+
+	/* Make the head point to the worker. */
+	first = atomic_exchange_explicit(head_ptr, first, memory_order_acq_rel);
+
+	/* Make the worker point to the previous head. */
+	atomic_store_explicit(node, first, memory_order_release);
+}
+
+static enum umcg_prepare_op_result umcg_prepare_wake_may_lock(
+		struct umcg_task_tls *next_utls, bool for_swap)
+{
+	struct umcg_task *next_ut = &next_utls->umcg_task;
+	uint64_t curr_state, next_state;
+	enum umcg_prepare_op_result result = UMCG_OP_DONE;
+	bool enqueue_worker = false;
+
+	curr_state = atomic_load_explicit(&next_ut->state_ts, memory_order_acquire);
+
+	if (curr_state & (UMCG_TF_LOCKED | UMCG_UTF_WAKEUP_QUEUED))
+		return UMCG_OP_AGAIN;
+
+	/* Start with RUNNING tasks. */
+	if ((curr_state & UMCG_TASK_STATE_MASK_FULL) == UMCG_TASK_RUNNING)
+		next_state = UMCG_TASK_RUNNING | UMCG_UTF_WAKEUP_QUEUED;
+	else if (curr_state & UMCG_UTF_WORKER_IN_WAIT) {
+		/* Next, check workers in wait. */
+		assert(next_utls->worker);
+		assert((curr_state & UMCG_TASK_STATE_MASK) == UMCG_TASK_IDLE);
+
+		if (for_swap) {
+			next_state = UMCG_TASK_RUNNING;
+			result = UMCG_OP_SYS;
+		} else {
+			next_state = UMCG_TASK_IDLE;
+			enqueue_worker = true;
+		}
+	} else if ((curr_state & UMCG_TASK_STATE_MASK_FULL) == UMCG_TASK_IDLE) {
+		/* Next, check IDLE tasks. */
+		if (next_utls->worker) {
+			if (for_swap) {
+				next_state = UMCG_TASK_RUNNING | UMCG_TF_LOCKED;
+				result = UMCG_OP_SYS;
+			} else {
+				return UMCG_OP_AGAIN;
+			}
+		} else {
+			atomic_store_explicit(&next_utls->umcg_task.next_tid,
+						0, memory_order_release);
+			next_state = UMCG_TASK_RUNNING;
+			result = UMCG_OP_SYS;
+		}
+	} else {
+		/* Finally, deal with BLOCKED workers. */
+		assert((curr_state & UMCG_TASK_STATE_MASK) == UMCG_TASK_BLOCKED);
+		assert(next_utls->worker);
+
+		return UMCG_OP_AGAIN;
+	}
+
+	if (umcg_update_state((uint64_t *)&next_ut->state_ts, &curr_state, next_state)) {
+		if (enqueue_worker)
+			enqueue_idle_worker(next_utls);
+		return result;
+	}
+
+	return UMCG_OP_AGAIN;
+}
+
+static int umcg_do_wake_or_swap(uint32_t next_tid, bool should_wait,
+				uint64_t timeout, bool wf_current_cpu,
+				struct umcg_task_tls *next_utls)
+{
+	struct umcg_task *ut;
+	uint32_t flags = 0;
+	uint32_t server_tid = 0;
+	int ret;
+
+	/* wf_current_cpu is possible in wake-only scenarios. */
+	assert(!should_wait || !wf_current_cpu);
+	assert(umcg_task_tls != NULL);
+
+	ut = &umcg_task_tls->umcg_task;
+
+	/*
+	 * This is a worker waking another task: lock it so that next_tid
+	 * is not interpreted as a server if this worker pagefaults.
+	 */
+	if (umcg_task_tls->worker && !should_wait) {
+		server_tid = atomic_load_explicit(&ut->next_tid,
+				memory_order_acquire);
+		assert(server_tid);
+		assert(utid_to_utls(umcg_task_tls->peer)->tid == server_tid);
+		task_lock(umcg_task_tls, UMCG_TASK_RUNNING, UMCG_TASK_IDLE);
+	}
+
+	atomic_store_explicit(&ut->next_tid, next_tid, memory_order_release);
+
+	if (!should_wait)
+		flags |= UMCG_WAIT_WAKE_ONLY;
+	if (wf_current_cpu)
+		flags |= UMCG_WAIT_WF_CURRENT_CPU;
+
+	if (next_utls && next_utls->worker)
+		task_unlock(next_utls, UMCG_TASK_RUNNING, UMCG_TASK_RUNNING);
+	ret = sys_umcg_wait(flags, should_wait ? timeout : 0);
+
+	/* If we locked this worker, unlock it. */
+	if (server_tid) {
+		atomic_store_explicit(&ut->next_tid, server_tid,
+				memory_order_release);
+		task_unlock(umcg_task_tls, UMCG_TASK_IDLE, UMCG_TASK_RUNNING);
+	}
+
+	if (ret && errno == ETIMEDOUT)
+		return handle_timedout();
+
+	return ret;
+}
+
+int umcg_wake(umcg_tid next, bool wf_current_cpu)
+{
+	struct umcg_task_tls *utls = utid_to_utls(next);
+	uint64_t loop_counter = 0;
+
+	if (!utls) {
+		errno = EINVAL;
+		return -1;
+	}
+
+again:
+	assert(++loop_counter < (1ULL << 31));
+	switch (umcg_prepare_wake_may_lock(utls, false /* for_swap */)) {
+	case UMCG_OP_DONE:
+		return 0;
+	case UMCG_OP_SYS:
+		break;
+	case UMCG_OP_ERROR:
+		return -1;
+	case UMCG_OP_AGAIN:
+		goto again;
+	default:
+		assert(false);
+		return -1;
+	}
+
+	return umcg_do_wake_or_swap(utls->tid, false, 0, wf_current_cpu, utls);
+}
+
+static void transfer_server_locked(struct umcg_task_tls *next)
+{
+	struct umcg_task_tls *curr = umcg_task_tls;
+	struct umcg_task_tls *server = utid_to_utls(curr->peer);
+
+	atomic_thread_fence(memory_order_acquire);
+	assert(curr->worker);
+	assert(next->worker);
+	assert(curr->peer != UMCG_NONE);
+	assert(next->peer == UMCG_NONE);
+
+	next->peer = curr->peer;
+	curr->peer = UMCG_NONE;
+	next->umcg_task.next_tid = curr->umcg_task.next_tid;
+	curr->umcg_task.next_tid = 0;
+
+	server->peer = next->self;
+	server->umcg_task.next_tid = next->tid;
+	atomic_thread_fence(memory_order_release);
+}
+
+int umcg_swap(umcg_tid next, uint64_t timeout)
+{
+	struct umcg_task_tls *utls = utid_to_utls(next);
+	bool should_wake, should_wait;
+	uint64_t loop_counter = 0;
+
+	assert(umcg_task_tls);
+
+again:
+	assert(++loop_counter < (1ULL << 31));
+	switch (umcg_prepare_wake_may_lock(utls, true /* for_swap */)) {
+	case UMCG_OP_DONE:
+		should_wake = false;
+		break;
+	case UMCG_OP_SYS:
+		should_wake = true;
+		break;
+	case UMCG_OP_ERROR:
+		return -1;
+	case UMCG_OP_AGAIN:
+		goto again;
+	default:
+		assert(false);
+	}
+
+	switch (umcg_prepare_wait_may_lock()) {
+	case UMCG_OP_DONE:
+		should_wait = false;
+		break;
+	case UMCG_OP_SYS:
+		should_wait = true;
+		break;
+	case UMCG_OP_ERROR:
+		return -1;
+	default:
+		assert(false);
+	}
+
+	if (should_wait && should_wake && umcg_task_tls->worker)
+		transfer_server_locked(utls);
+
+	if (should_wake)
+		return umcg_do_wake_or_swap(utls->tid, should_wait, timeout,
+				false, utls);
+
+	if (should_wait)
+		return umcg_do_wait(timeout);
+
+	return 0;
+}
+
+/* A noop SIGUSR1 handler, used in worker preemption. */
+static void sigusr_handler(int signum)
+{
+}
+
+umcg_t umcg_create_group(uint32_t flags)
+{
+	struct umcg_group *group;
+	int res;
+
+	if (flags && flags != UMCG_GROUP_ENABLE_PREEMPTION) {
+		errno = EINVAL;
+		return UMCG_NONE;
+	}
+
+	group = malloc(sizeof(struct umcg_group));
+	if (!group) {
+		errno = ENOMEM;
+		return UMCG_NONE;
+	}
+
+	memset(group, 0, sizeof(*group));
+
+	res = pthread_spin_init(&group->idle_worker_lock, PTHREAD_PROCESS_PRIVATE);
+	if (res) {
+		errno = res;
+		goto error;
+	}
+
+	res = pthread_spin_init(&group->idle_server_lock, PTHREAD_PROCESS_PRIVATE);
+	if (res) {
+		errno = res;
+		res = pthread_spin_destroy(&group->idle_worker_lock);
+		assert(!res);
+		goto error;
+	}
+
+	if (flags & UMCG_GROUP_ENABLE_PREEMPTION) {
+		if (SIG_ERR == signal(SIGUSR1, sigusr_handler)) {
+			res = pthread_spin_destroy(&group->idle_worker_lock);
+			assert(!res);
+			res = pthread_spin_destroy(&group->idle_server_lock);
+			assert(!res);
+			goto error;
+		}
+	}
+
+	return (intptr_t)group;
+
+error:
+	free(group);
+	return UMCG_NONE;
+}
+
+int umcg_destroy_group(umcg_t umcg)
+{
+	int res;
+	struct umcg_group *group = (struct umcg_group *)umcg;
+
+	if (atomic_load_explicit(&group->nr_tasks, memory_order_acquire)) {
+		errno = EBUSY;
+		return -1;
+	}
+
+	res = pthread_spin_destroy(&group->idle_worker_lock);
+	assert(!res);
+	res = pthread_spin_destroy(&group->idle_server_lock);
+	assert(!res);
+
+	free(group);
+	return 0;
+}
+
+static void detach_worker(void)
+{
+	struct umcg_task_tls *server_utls = umcg_task_tls;
+	struct umcg_task_tls *worker_utls;
+
+	assert(server_utls->group != NULL);
+
+	atomic_thread_fence(memory_order_acquire);
+	if (!server_utls->peer)
+		return;
+
+	worker_utls = utid_to_utls(server_utls->peer);
+	assert(server_utls->peer == worker_utls->self);
+	assert(worker_utls->peer == server_utls->self);
+
+	umcg_task_tls->umcg_task.next_tid = 0;
+	worker_utls->umcg_task.next_tid = 0;
+	worker_utls->peer = UMCG_NONE;
+	server_utls->peer = UMCG_NONE;
+
+	atomic_thread_fence(memory_order_release);
+}
+
+umcg_tid umcg_run_worker(umcg_tid worker)
+{
+	struct umcg_task_tls *worker_utls = utid_to_utls(worker);
+	struct umcg_task_tls *server_utls = umcg_task_tls;
+	struct umcg_task *server_ut = &umcg_task_tls->umcg_task;
+	struct umcg_task *worker_ut;
+	uint64_t curr_state, next_state;
+	int ret;
+	bool ok;
+
+	assert(server_utls->group != NULL);
+	assert(server_utls->group == worker_utls->group);
+	assert(worker_utls->worker);
+
+	atomic_thread_fence(memory_order_acquire);
+	assert(server_utls->peer == UMCG_NONE);
+	assert(worker_utls->peer == UMCG_NONE);
+
+	worker_ut = &worker_utls->umcg_task;
+
+	assert(!umcg_worker_in_idle_queue(worker));
+
+	/*
+	 * Mark the server IDLE before marking the worker RUNNING: preemption
+	 * can happen immediately after the worker is marked RUNNING.
+	 */
+	curr_state = atomic_load_explicit((uint64_t *)&server_ut->state_ts,
+			memory_order_acquire);
+	assert((curr_state & UMCG_TASK_STATE_MASK_FULL) == UMCG_TASK_RUNNING);
+	ok = umcg_update_state((uint64_t *)&server_ut->state_ts, &curr_state,
+			UMCG_TASK_IDLE);
+	assert(ok);
+
+	/* Lock the worker in preparation to run it. */
+	curr_state = atomic_load_explicit((uint64_t *)&worker_ut->state_ts,
+			memory_order_acquire);
+	assert((curr_state & UMCG_TASK_STATE_MASK) == UMCG_TASK_IDLE);
+	assert(!(curr_state & UMCG_TF_LOCKED));
+	next_state = curr_state & UMCG_UTF_WAKEUP_QUEUED ?
+		UMCG_TASK_RUNNING | UMCG_UTF_WAKEUP_QUEUED :
+		UMCG_TASK_RUNNING;
+	ok = umcg_update_state((uint64_t *)&worker_ut->state_ts, &curr_state,
+			next_state | UMCG_TF_LOCKED);
+
+	assert(ok);
+
+	/* Attach the server to the worker. */
+	atomic_thread_fence(memory_order_acquire);
+	server_ut->next_tid = worker_utls->tid;
+	worker_ut->next_tid = server_utls->tid;
+	worker_utls->peer = server_utls->self;
+	server_utls->peer = worker;
+
+	atomic_thread_fence(memory_order_release);
+	task_unlock(worker_utls, next_state, next_state);
+
+	ret = sys_umcg_wait(0, 0);
+
+	atomic_thread_fence(memory_order_acquire);
+	if (!server_utls->peer) {
+		assert(server_ut->next_tid == 0);
+		/*
+		 * The worker woke early due to umcg_state change
+		 * and unregistered/exited.
+		 */
+		assert(!ret || errno == ESRCH);
+		errno = 0;
+		return UMCG_NONE;
+	}
+
+	assert(!ret);
+
+	/* Detach the server from the worker. */
+	worker_utls = utid_to_utls(server_utls->peer);
+	detach_worker();
+
+	return worker_utls->self;
+}
+
+int umcg_preempt_worker(umcg_tid worker)
+{
+	struct umcg_task_tls *worker_utls = utid_to_utls(worker);
+	struct umcg_task *worker_ut = &worker_utls->umcg_task;
+	uint32_t worker_tid = worker_utls->tid;
+	uint64_t curr_state;
+	int ret;
+
+	curr_state = atomic_load_explicit(&worker_ut->state_ts,
+			memory_order_acquire);
+	if ((curr_state & UMCG_TASK_STATE_MASK_FULL) != UMCG_TASK_RUNNING) {
+		errno = EAGAIN;
+		return -1;
+	}
+
+	if (!umcg_update_state((uint64_t *)&worker_ut->state_ts, &curr_state,
+			UMCG_TASK_RUNNING | UMCG_TF_PREEMPTED)) {
+		errno = EAGAIN;
+		return -1;
+	}
+
+	/*
+	 * It is possible that this thread is descheduled here, the worker
+	 * pagefaults, wakes up, and then exits; in this case tgkill() below
+	 * will fail with errno == ESRCH.
+	 */
+	ret = tgkill(getpid(), worker_tid, SIGUSR1);
+	assert(!ret || errno == ESRCH);
+	return 0;
+}
+
+static void wake_idle_server(void)
+{
+	struct umcg_group *group = umcg_task_tls->group;
+	int res;
+
+	res = pthread_spin_lock(&group->idle_server_lock);
+	assert(!res);
+
+	if (group->idle_servers) {
+		struct umcg_task_tls *server = group->idle_servers;
+
+		group->idle_servers = server->next;
+		server->next = NULL;
+
+		assert((atomic_load_explicit(&server->umcg_task.state_ts,
+						memory_order_acquire) &
+					UMCG_TASK_STATE_MASK_FULL) == UMCG_TASK_IDLE);
+
+		res = umcg_wake(server->self, false);
+		assert(!res);
+	}
+
+	res = pthread_spin_unlock(&group->idle_server_lock);
+	assert(!res);
+}
+
+static umcg_tid get_idle_worker(void)
+{
+	struct umcg_group *group = umcg_task_tls->group;
+	umcg_tid result = UMCG_NONE;
+	uint64_t *head;
+	int res;
+
+	res = pthread_spin_lock(&group->idle_worker_lock);
+	assert(!res);
+
+	head = group->idle_workers;
+
+once_again:
+	/* First, check the userspace idle worker list. */
+	if (head) {
+		uint64_t next;
+		struct umcg_task *worker;
+		struct umcg_task_tls *worker_utls;
+
+		worker = container_of((__u64 *)head, struct umcg_task, idle_workers_ptr);
+		worker_utls = container_of(worker, struct umcg_task_tls, umcg_task);
+
+		/* Spin while the worker is pending. */
+		do {
+			next = atomic_load_explicit(head, memory_order_acquire);
+		} while (next == UMCG_IDLE_NODE_PENDING);
+
+		/* Wait for the worker's server to detach in umcg_run_worker(). */
+		while (atomic_load_explicit(&worker_utls->peer,
+						memory_order_relaxed))
+			;
+
+		/* Pull the worker out of the idle worker list. */
+		group->idle_workers = (uint64_t *)next;
+		atomic_store_explicit(&worker->idle_workers_ptr,
+				(uint64_t)&group->idle_workers_head,
+				memory_order_release);
+
+		if (next)
+			wake_idle_server();
+
+		result = worker_utls->self;
+		goto out;
+	}
+
+	/*
+	 * Get the kernel's idle worker list.
+	 *
+	 * TODO: review whether memory order below can be weakened to
+	 * memory_order_acq_rel.
+	 */
+	head = (uint64_t *)atomic_exchange_explicit(&group->idle_workers_head,
+			0ULL, memory_order_seq_cst);
+
+	if (!head)
+		goto out;
+
+	group->idle_workers = head;
+	goto once_again;
+
+out:
+	res = pthread_spin_unlock(&group->idle_worker_lock);
+	assert(!res);
+
+	return result;
+}
+
+static void enqueue_idle_server(void)
+{
+	struct umcg_task_tls *server = umcg_task_tls;
+	struct umcg_group *group = server->group;
+	int res;
+
+	res = pthread_spin_lock(&group->idle_server_lock);
+	assert(!res);
+
+	assert(server->next == NULL);
+	assert((atomic_load_explicit(&server->umcg_task.state_ts,
+					memory_order_acquire) &
+				UMCG_TASK_STATE_MASK_FULL) == UMCG_TASK_IDLE);
+
+	server->next = group->idle_servers;
+	group->idle_servers = server;
+
+	res = pthread_spin_unlock(&group->idle_server_lock);
+	assert(!res);
+}
+
+static umcg_tid idle_server_wait(void)
+{
+	struct umcg_task_tls *server_utls = umcg_task_tls;
+	struct umcg_task *server_ut = &umcg_task_tls->umcg_task;
+	uint32_t server_tid = server_utls->tid;
+	struct umcg_group *group = umcg_task_tls->group;
+	umcg_tid worker;
+	uint32_t prev = 0ULL;
+	uint64_t state;
+	bool ok;
+
+	state = atomic_load_explicit((uint64_t *)&server_ut->state_ts, memory_order_acquire);
+	assert((state & UMCG_TASK_STATE_MASK_FULL) == UMCG_TASK_RUNNING);
+	ok = umcg_update_state((uint64_t *)&server_ut->state_ts, &state, UMCG_TASK_IDLE);
+	assert(ok);
+
+	/*
+	 * Try to become THE idle server that the kernel will wake.
+	 *
+	 * TODO: review whether memory order below can be weakened to
+	 * memory_order_acq_rel for success and memory_order_acquire
+	 * for failure.
+	 */
+	ok = atomic_compare_exchange_strong_explicit(&group->idle_server_tid,
+			&prev, server_tid,
+			memory_order_seq_cst, memory_order_seq_cst);
+
+	if (!ok) {
+		assert(prev != server_tid);
+		enqueue_idle_server();
+		umcg_do_wait(0);
+		assert(server_utls->next == NULL);
+
+		return UMCG_NONE;
+	}
+
+	/* We need to ensure no idle workers enqueued before going to sleep. */
+	worker = get_idle_worker();
+
+	if (worker) {
+		state = atomic_load_explicit(&server_ut->state_ts,
+				memory_order_acquire);
+		if ((state & UMCG_TASK_STATE_MASK_FULL) != UMCG_TASK_RUNNING) {
+			ok = umcg_update_state((uint64_t *)&server_ut->state_ts,
+					&state, UMCG_TASK_RUNNING);
+			assert(ok || ((state & UMCG_TASK_STATE_MASK_FULL) ==
+						UMCG_TASK_RUNNING));
+		}
+	} else
+		umcg_do_wait(0);
+
+	/*
+	 * If the server calls umcg_get_idle_worker() in a loop, the worker
+	 * that pulled the server at step N (and thus zeroed idle_server_tid)
+	 * may wake the server at step N+1 without cleaning idle_server_tid,
+	 * so the server needs to clean idle_server_tid in case this happens.
+	 *
+	 * TODO: review whether memory order below can be weakened to
+	 * memory_order_acq_rel for success and memory_order_acquire
+	 * for failure.
+	 */
+	prev = server_tid;
+	ok = atomic_compare_exchange_strong_explicit(
+				&group->idle_server_tid, &prev, 0UL,
+				memory_order_seq_cst, memory_order_seq_cst);
+	assert(ok || (prev != server_tid));
+	return worker;
+}
+
+umcg_tid umcg_get_idle_worker(bool wait)
+{
+	umcg_tid result = UMCG_NONE;
+
+	assert(umcg_task_tls->peer == UMCG_NONE);
+	assert((atomic_load_explicit(&umcg_task_tls->umcg_task.state_ts,
+				memory_order_acquire) & UMCG_TASK_STATE_MASK_FULL) ==
+			UMCG_TASK_RUNNING);
+
+	do {
+		result = get_idle_worker();
+
+		if (result || !wait)
+			break;
+
+		result = idle_server_wait();
+	} while (!result);
+
+	assert((atomic_load_explicit(&umcg_task_tls->umcg_task.state_ts,
+				memory_order_acquire) & UMCG_TASK_STATE_MASK_FULL) ==
+			UMCG_TASK_RUNNING);
+	return result;
+}
diff --git a/tools/lib/umcg/libumcg.h b/tools/lib/umcg/libumcg.h
new file mode 100644
index 000000000000..8d97d4032667
--- /dev/null
+++ b/tools/lib/umcg/libumcg.h
@@ -0,0 +1,299 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef __LIBUMCG_H
+#define __LIBUMCG_H
+
+#define _GNU_SOURCE
+#include <errno.h>
+#include <limits.h>
+#include <unistd.h>
+#include <linux/types.h>
+#include <stdbool.h>
+#include <stdint.h>
+#include <syscall.h>
+#include <time.h>
+
+#include <linux/umcg.h>
+
+/*
+ * UMCG: User Managed Concurrency Groups.
+ *
+ * LIBUMCG provides userspace UMCG API that hides some of the intricacies
+ * of sys_umcg_ctl() and sys_umcg_wait() syscalls.
+ *
+ * Note that this API is still quite low level and is designed as
+ * a toolkit for building higher-level userspace schedulers.
+ *
+ * See tools/lib/umcg/libumcg.txt for detals.
+ */
+
+typedef intptr_t umcg_t;   /* UMCG group ID. */
+typedef intptr_t umcg_tid; /* UMCG thread ID. */
+
+#define UMCG_NONE	(0)
+
+/**
+ * umcg_enabled - indicates whether UMCG syscalls are available.
+ */
+bool umcg_enabled(void);
+
+/**
+ * umcg_get_utid - return the UMCG ID of the current thread.
+ *
+ * The function always succeeds, and the returned ID is guaranteed to be
+ * stable over the life of the thread.
+ *
+ * The ID is NOT guaranteed to be unique over the life of the process.
+ */
+umcg_tid umcg_get_utid(void);
+
+/**
+ * umcg_set_task_tag - add an arbitrary tag to a registered UMCG task.
+ *
+ * Note: not-thread-safe: the user is responsible for proper memory fencing.
+ */
+void umcg_set_task_tag(umcg_tid utid, intptr_t tag);
+
+/**
+ * umcg_get_task_tag - get the task tag. Returns zero if none set.
+ *
+ * Note: not-thread-safe: the user is responsible for proper memory fencing.
+ */
+intptr_t umcg_get_task_tag(umcg_tid utid);
+
+/**
+ * enum umcg_create_group_flag - flags to pass to umcg_create_group
+ * @UMCG_GROUP_ENABLE_PREEMPTION: enable worker preemption.
+ *
+ * See tools/lib/libumcg.txt for detals.
+ */
+enum umcg_create_group_flag {
+	UMCG_GROUP_ENABLE_PREEMPTION	= 1
+};
+
+/**
+ * umcg_create_group - create a UMCG group
+ * @flags:             a combination of values from enum umcg_create_group_flag
+ *
+ * See tools/lib/libumcg.txt for detals.
+ *
+ * Return:
+ * UMCG_NONE     - an error occurred. Check errno.
+ * != UMCG_NONE  - the ID of the group, to be used in e.g. umcg_register.
+ */
+umcg_t umcg_create_group(uint32_t flags);
+
+/**
+ * umcg_destroy_group - destroy a UMCG group
+ * @umcg:               ID of the group to destroy
+ *
+ * The group must be empty (no server or worker threads).
+ *
+ * Return:
+ * 0            - Ok
+ * -1           - an error occurred. Check errno.
+ *                errno == EAGAIN: the group has server or worker threads
+ */
+int umcg_destroy_group(umcg_t umcg);
+
+/**
+ * umcg_register_basic_task - register the current thread as a UMCG basic task
+ * @tag:          An arbitrary tag to be associated with the task.
+ *
+ * See tools/lib/libumcg.txt for detals.
+ *
+ * Return:
+ * UMCG_NONE     - an error occurred. Check errno.
+ * != UMCG_NONE  - the ID of the thread to be used with UMCG API (guaranteed
+ *                 to match the value returned by umcg_get_utid).
+ */
+umcg_tid umcg_register_basic_task(intptr_t tag);
+
+/**
+ * umcg_register_worker - register the current thread as a UMCG worker
+ * @group_id:      The ID of the UMCG group the thread should join;
+ * @tag:           an arbitrary tag to be associated with the task.
+ *
+ * Return:
+ * UMCG_NONE     - an error occurred. Check errno.
+ * != UMCG_NONE  - the ID of the thread to be used with UMCG API (guaranteed
+ *                 to match the value returned by umcg_get_utid).
+ */
+umcg_tid umcg_register_worker(umcg_t group_id, intptr_t tag);
+
+/**
+ * umcg_register_server - register the current thread as a UMCG server
+ * @group_id:      The ID of the UMCG group the thread should join;
+ * @tag:           an arbitrary tag to be associated with the task.
+ *
+ * Return:
+ * UMCG_NONE     - an error occurred. Check errno.
+ * != UMCG_NONE  - the ID of the thread to be used with UMCG API (guaranteed
+ *                 to match the value returned by umcg_get_utid).
+ */
+umcg_tid umcg_register_server(umcg_t group_id, intptr_t tag);
+
+/**
+ * umcg_unregister_task - unregister the current thread.
+ *
+ * Return:
+ * 0              - OK
+ * -1             - the current thread is not a UMCG thread
+ */
+int umcg_unregister_task(void);
+
+/**
+ * umcg_wait - block the current thread
+ * @timeout:   absolute timeout in nanoseconds
+ *
+ * Blocks the current thread, which must have been registered via umcg_register,
+ * until it is waken via umcg_wake or swapped into via umcg_swap. If the current
+ * thread has a wakeup queued (see umcg_wake), returns zero immediately,
+ * consuming the wakeup.
+ *
+ * Return:
+ * 0         - OK, the thread was waken;
+ * -1        - did not wake normally;
+ *               errno:
+ *                 EINTR: interrupted
+ *                 EINVAL: some other error occurred
+ */
+int umcg_wait(uint64_t timeout);
+
+/**
+ * umcg_wake - wake @next; non-blocking.
+ * @next:            ID of the thread to wake;
+ * @wf_current_cpu:  an advisory hint indicating that the current thread
+ *                   is going to block in the immediate future and that
+ *                   the wakee should be woken on the current CPU;
+ *
+ * If @next is blocked via umcg_wait or umcg_swap, wake it if @next is
+ * a server or a basic task; if @next is a worker, it will be queued
+ * in the idle worker list. If @next is running, queue the wakeup,
+ * so that a future block of @next will consume the wakeup and will not block.
+ *
+ * umcg_wake can queue at most one wakeup; if waking or queueing a wakeup
+ * is not possible, umcg_wake will SPIN.
+ *
+ * See tools/lib/umcg/libumcg.txt for detals.
+ *
+ * Return:
+ * 0         - OK, @next has woken, or a wakeup has been queued;
+ * -1        - an error occurred.
+ */
+int umcg_wake(umcg_tid next, bool wf_current_cpu);
+
+/**
+ * umcg_swap - wake @next, put the current thread to sleep
+ * @next:      ID of the thread to wake
+ * @timeout:   absolute timeout in ns
+ *
+ * umcg_swap is semantically equivalent to
+ *
+ *     int ret = umcg_wake(next, true);
+ *     if (ret)
+ *             return ret;
+ *     return umcg_wait(timeout);
+ *
+ * but may do a synchronous context switch into @next on the current CPU.
+ *
+ * Note: if @next is a worker, it must be IDLE, but not in the idle worker list.
+ * See tools/lib/umcg/libumcg.txt for detals.
+ */
+int umcg_swap(umcg_tid next, u64 timeout);
+
+/**
+ * umcg_get_idle_worker - get an idle worker, if available
+ * @wait: if true, block until an idle worker becomes available
+ *
+ * The current thread must be a UMCG server. If there is a list/queue of
+ * waiting IDLE workers in the server's group, umcg_get_idle_worker
+ * picks one; if there are no IDLE workers, the current thread sleeps in
+ * the idle server queue if @wait is true.
+ *
+ * Note: servers waiting for idle workers must NOT be woken via umcg_wake(),
+ *       as this will leave them in inconsistent state.
+ *
+ * See tools/lib/umcg/libumcg.txt for detals.
+ *
+ * Return:
+ * UMCG_NONE         - an error occurred; check errno;
+ * != UMCG_NONE      - a RUNNABLE worker.
+ */
+umcg_tid umcg_get_idle_worker(bool wait);
+
+/**
+ * umcg_run_worker - run @worker as a UMCG server
+ * @worker:          the ID of a RUNNABLE worker to run
+ *
+ * The current thread must be a UMCG "server".
+ *
+ * See tools/lib/umcg/libumcg.txt for detals.
+ *
+ * Return:
+ * UMCG_NONE    - if errno == 0, the last worker the server was running
+ *                unregistered itself; if errno != 0, an error occurred
+ * != UMCG_NONE - the ID of the last worker the server was running before
+ *                the worker was blocked or preempted.
+ */
+umcg_tid umcg_run_worker(umcg_tid worker);
+
+/**
+ * umcg_preempt_worker - preempt a RUNNING worker.
+ * @worker:          the ID of a RUNNING worker to preempt.
+ *
+ * See tools/lib/umcg/libumcg.txt for detals.
+ *
+ * Return:
+ * 0        - Ok;
+ * -1       - an error occurred; check errno and `man tgkill()`. In addition
+ *            to tgkill() errors, EAGAIN is also returned if the worker
+ *            is not in RUNNING state (in this case tgkill() was not called).
+ */
+int umcg_preempt_worker(umcg_tid worker);
+
+/**
+ * umcg_get_task_state - return the UMCG state of @task, including state
+ * flags, without the timestamp.
+ *
+ * Note that in most situations the state value can be changed at any time
+ * by a concurrent thread, so this function is exposed for debugging/testing
+ * purposes only.
+ */
+uint64_t umcg_get_task_state(umcg_tid task);
+
+#ifndef NSEC_PER_SEC
+#define NSEC_PER_SEC	1000000000L
+#endif
+
+/**
+ * umcg_get_time_ns - returns the absolute current time in nanoseconds.
+ *
+ * The function uses CLOCK_MONOTONIC; the returned value can be used
+ * to set absolute timeouts for umcg_wait() and umcg_swap().
+ */
+uint64_t umcg_get_time_ns(void);
+
+/**
+ * UMCG userspace-only task state flag: wakeup queued.
+ *
+ * see umcg_wake() above.
+ */
+#define UMCG_UTF_WAKEUP_QUEUED	(1ULL << 17)
+
+/**
+ * UMCG userspace-only task state flag: worker in sys_umcg_wait().
+ *
+ * IDLE workers can be in two substates:
+ * - waiting in sys_umcg_wait(): in this case UTF_WORKER_IN_WAIT flag is set;
+ * - waiting in the idle worker list: in this case the flag is not set.
+ *
+ * If the worker is IDLE in sys_umcg_wait, umcg_wake() clears the flag
+ * and adds the worker to the idle worker list.
+ *
+ * If the worker is IDLE in the idle worker list, umcg_wake() sets
+ * the wakeup queued flag.
+ */
+#define UMCG_UTF_WORKER_IN_WAIT	(1ULL << 16)
+
+#endif  /* __LIBUMCG_H */
--
2.25.1


Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86B6438B62B
	for <lists+linux-api@lfdr.de>; Thu, 20 May 2021 20:36:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235606AbhETShy (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 20 May 2021 14:37:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235630AbhETShw (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 20 May 2021 14:37:52 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6AE1C061761
        for <linux-api@vger.kernel.org>; Thu, 20 May 2021 11:36:30 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id w15-20020ac857cf0000b02901e11cd2e82fso13006397qta.12
        for <linux-api@vger.kernel.org>; Thu, 20 May 2021 11:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=CiYj3xqa/3sBIT+R8Q57s77BdvC1TkRWShRTcp4bolo=;
        b=tZXEbCkDQJ+6wLLjrPP8nUVwzG2bUC5k3GqLx5LHDrNEHe892Koo89lKLm3Xsu2Ovw
         MXNR6bVM0819HDDm510QNmGJN7UwuEirV0J3uE6Eid8r+qLoSzjMpamTzwDy93ABkaHE
         g5uqvWTLj6CQzFR3jc5Nh8d3hh+pdfIYPIr9i9rWVKOhjdueiaeQ7acDkrWZ+4AsQj6p
         uLrDxK3chu8kLWPpUWLhNVIakUM4vehc198rboYbv8GcX5wJXQCHl2l+g0OL++mKDH4D
         l/eD4rgL3vWbFRLq0V2zy44Bqpsdk9+GMfWtURE5b+/+yzV21KUFXDc63yTWW5HMhSpn
         91zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=CiYj3xqa/3sBIT+R8Q57s77BdvC1TkRWShRTcp4bolo=;
        b=bXSddVL85wBFVvI3DDZAzltXFzWlk0QTV+3hfb6NiOpjFqiJaUHxdIyxkOFNmG4/MK
         POuV7ynBBh32rEK9IfIdoRlgNmm9JMj3pfxHwXJ5wYDGCINBpajAtuwbycHKwnAc7leY
         CDld3rNrowkGPPqnjTyUO8v+lLMDb6hjJkEkCg26C/IGH0iLNG10t/Hbv+m53k86xcqX
         osp2XlU3U3p0zow0G0j5iGdonFz63hNe2rJkN8xmp5qf/BknaKEiqCNRoeBy8TeMxa9s
         PcRxjxt0Uz1Ysg3kTyaErzBfOToMbMkYfWRdZFG6PPa8JnCbw/dL6yLnvWuFwpa0GN0Q
         wnDg==
X-Gm-Message-State: AOAM533hA2ln2NqeCjLgh5TbJWfUrkRAra+4rgdGJQjgPnnArLvBGHDy
        eBB7eQ85oG7yR3BRKVSU+V5OsUdp
X-Google-Smtp-Source: ABdhPJy87EdzjLGTZce486+xBvwPmlC9FsJxGv1NOqgtocZwZj/3HhaUKfB+vJmNYFIbG7US02n4foOE
X-Received: from posk.svl.corp.google.com ([2620:15c:2cd:202:f13e:18cf:76e6:2dc4])
 (user=posk job=sendgmr) by 2002:a0c:fb45:: with SMTP id b5mr3470588qvq.48.1621535789760;
 Thu, 20 May 2021 11:36:29 -0700 (PDT)
Date:   Thu, 20 May 2021 11:36:10 -0700
In-Reply-To: <20210520183614.1227046-1-posk@google.com>
Message-Id: <20210520183614.1227046-6-posk@google.com>
Mime-Version: 1.0
References: <20210520183614.1227046-1-posk@google.com>
X-Mailer: git-send-email 2.31.1.818.g46aad6cb9e-goog
Subject: [RFC PATCH v0.1 5/9] lib/umcg: implement UMCG core API for userspace
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

UMCG (= User Managed Concurrency Groups) kernel API
is designed to be minimalistic and requires tightly
coupled userspace code to make it easy to use.

Add userspace UMCG core API to achieve this goal.

Signed-off-by: Peter Oskolkov <posk@google.com>
---
 tools/lib/umcg/.gitignore |   4 +
 tools/lib/umcg/Makefile   |  11 ++
 tools/lib/umcg/libumcg.c  | 350 ++++++++++++++++++++++++++++++++++++++
 tools/lib/umcg/libumcg.h  | 154 +++++++++++++++++
 4 files changed, 519 insertions(+)
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
index 000000000000..fa53fd5a851a
--- /dev/null
+++ b/tools/lib/umcg/Makefile
@@ -0,0 +1,11 @@
+# SPDX-License-Identifier: GPL-2.0
+
+CFLAGS += -g -I../../../usr/include/ -I../../include/
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
index 000000000000..b177fb1d4b17
--- /dev/null
+++ b/tools/lib/umcg/libumcg.c
@@ -0,0 +1,350 @@
+// SPDX-License-Identifier: GPL-2.0
+#define _GNU_SOURCE
+#include "libumcg.h"
+
+#include <errno.h>
+#include <pthread.h>
+#include <signal.h>
+#include <stdatomic.h>
+#include <stdbool.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <threads.h>
+
+/* UMCG API version supported by this library. */
+static const uint32_t umcg_api_version = 1;
+
+struct umcg_group {
+	uint32_t group_id;
+};
+
+/**
+ * struct umcg_task_tls - per thread struct used to identify/manage UMCG tasks
+ *
+ * Each UMCG task requires an instance of struct umcg_task passed to
+ * sys_umcg_register. This struct contains it, as well as several additional
+ * fields.
+ */
+struct umcg_task_tls {
+	struct umcg_task	umcg_task;
+	umcg_tid		self;
+	intptr_t		tag;
+	pid_t			tid;
+
+} __attribute((aligned(4 * sizeof(uint64_t))));
+
+static thread_local struct umcg_task_tls *umcg_task_tls;
+
+umcg_tid umcg_get_utid(void)
+{
+	return (umcg_tid)&umcg_task_tls;
+}
+
+static umcg_tid umcg_task_to_utid(struct umcg_task *ut)
+{
+	if (!ut)
+		return UMCG_NONE;
+
+	return ((struct umcg_task_tls *)ut)->self;
+}
+
+static struct umcg_task_tls *utid_to_utls(umcg_tid utid)
+{
+	if (!utid || !*(struct umcg_task_tls **)utid) {
+		fprintf(stderr, "utid_to_utls: NULL\n");
+		/* Kill the process rather than corrupt memory. */
+		raise(SIGKILL);
+		return NULL;
+	}
+	return *(struct umcg_task_tls **)utid;
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
+umcg_tid umcg_register_core_task(intptr_t tag)
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
+
+	umcg_task_tls->umcg_task.state = UMCG_TASK_NONE;
+	umcg_task_tls->self = (umcg_tid)&umcg_task_tls;
+	umcg_task_tls->tag = tag;
+	umcg_task_tls->tid = gettid();
+
+	ret = sys_umcg_register_task(umcg_api_version, UMCG_REGISTER_CORE_TASK,
+			UMCG_NOID, &umcg_task_tls->umcg_task);
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
+int umcg_unregister_task(void)
+{
+	int ret;
+
+	if (!umcg_task_tls) {
+		errno = EINVAL;
+		return -1;
+	}
+
+	ret = sys_umcg_unregister_task(0);
+	if (ret) {
+		errno = ret;
+		return -1;
+	}
+
+	free(umcg_task_tls);
+	atomic_store_explicit(&umcg_task_tls, NULL, memory_order_seq_cst);
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
+static enum umcg_prepare_op_result umcg_prepare_wait(void)
+{
+	struct umcg_task *ut;
+	uint32_t umcg_state;
+	int ret;
+
+	if (!umcg_task_tls) {
+		errno = EINVAL;
+		return UMCG_OP_ERROR;
+	}
+
+	ut = &umcg_task_tls->umcg_task;
+
+	umcg_state = UMCG_TASK_RUNNING;
+	if (atomic_compare_exchange_strong_explicit(&ut->state,
+			&umcg_state, UMCG_TASK_RUNNABLE,
+			memory_order_seq_cst, memory_order_seq_cst))
+		return UMCG_OP_SYS;
+
+	if (umcg_state != (UMCG_TASK_RUNNING | UMCG_TF_WAKEUP_QUEUED)) {
+		fprintf(stderr, "libumcg: unexpected state before wait: %u\n",
+				umcg_state);
+		errno = EINVAL;
+		return UMCG_OP_ERROR;
+	}
+
+	if (atomic_compare_exchange_strong_explicit(&ut->state,
+			&umcg_state, UMCG_TASK_RUNNING,
+			memory_order_seq_cst, memory_order_seq_cst)) {
+		return UMCG_OP_DONE;
+	}
+
+	/* Raced with another wait/wake? This is not supported. */
+	fprintf(stderr, "libumcg: failed to remove the wakeup flag: %u\n",
+			umcg_state);
+	errno = EINVAL;
+	return UMCG_OP_ERROR;
+}
+
+static int umcg_do_wait(const struct timespec *timeout)
+{
+	uint32_t umcg_state;
+	int ret;
+
+	do {
+		ret = sys_umcg_wait(0, timeout);
+		if (ret != 0 && errno != EAGAIN)
+			return ret;
+
+		umcg_state = atomic_load_explicit(
+				&umcg_task_tls->umcg_task.state,
+				memory_order_acquire);
+	} while (umcg_state == UMCG_TASK_RUNNABLE);
+
+	return 0;
+}
+
+int umcg_wait(const struct timespec *timeout)
+{
+	switch (umcg_prepare_wait()) {
+	case UMCG_OP_DONE:
+		return 0;
+	case UMCG_OP_SYS:
+		break;
+	case UMCG_OP_ERROR:
+		return -1;
+	default:
+		fprintf(stderr, "Unknown pre_op result.\n");
+		exit(1);
+		return -1;
+	}
+
+	return umcg_do_wait(timeout);
+}
+
+static enum umcg_prepare_op_result umcg_prepare_wake(struct umcg_task_tls *utls)
+{
+	struct umcg_task *ut = &utls->umcg_task;
+	uint32_t umcg_state, next_state;
+
+	next_state = UMCG_TASK_RUNNING;
+	umcg_state = UMCG_TASK_RUNNABLE;
+	if (atomic_compare_exchange_strong_explicit(&ut->state,
+			&umcg_state, next_state,
+			memory_order_seq_cst, memory_order_seq_cst))
+		return UMCG_OP_SYS;
+
+	if (umcg_state != UMCG_TASK_RUNNING) {
+		if (umcg_state == (UMCG_TASK_RUNNING | UMCG_TF_WAKEUP_QUEUED)) {
+			/*
+			 * With ping-pong mutual swapping using wake/wait
+			 * without synchronization this can happen.
+			 */
+			return UMCG_OP_AGAIN;
+		}
+		fprintf(stderr, "libumcg: unexpected state in umcg_wake(): %u\n",
+				umcg_state);
+		errno = EINVAL;
+		return UMCG_OP_ERROR;
+	}
+
+	if (atomic_compare_exchange_strong_explicit(&ut->state,
+			&umcg_state, UMCG_TASK_RUNNING | UMCG_TF_WAKEUP_QUEUED,
+			memory_order_seq_cst, memory_order_seq_cst)) {
+		return UMCG_OP_DONE;
+	}
+
+	if (umcg_state != UMCG_TASK_RUNNABLE) {
+		fprintf(stderr, "libumcg: unexpected state in umcg_wake (1): %u\n",
+				umcg_state);
+		errno = EINVAL;
+		return UMCG_OP_ERROR;
+	}
+
+	return UMCG_OP_AGAIN;
+}
+
+static int umcg_do_wake_or_swap(struct umcg_task_tls *next_utls,
+				uint64_t prev_wait_counter, bool should_wait,
+				const struct timespec *timeout)
+{
+	int ret;
+
+again:
+
+	if (should_wait)
+		ret = sys_umcg_swap(0, next_utls->tid, 0, timeout);
+	else
+		ret = sys_umcg_wake(0, next_utls->tid);
+
+	if (ret && errno == EAGAIN)
+		goto again;
+
+	return ret;
+}
+
+int umcg_wake(umcg_tid next)
+{
+	struct umcg_task_tls *utls = *(struct umcg_task_tls **)next;
+	uint64_t prev_wait_counter;
+
+	if (!utls) {
+		errno = EINVAL;
+		return -1;
+	}
+
+again:
+	switch (umcg_prepare_wake(utls)) {
+	case UMCG_OP_DONE:
+		return 0;
+	case UMCG_OP_SYS:
+		break;
+	case UMCG_OP_ERROR:
+		return -1;
+	case UMCG_OP_AGAIN:
+		goto again;
+	default:
+		fprintf(stderr, "libumcg: unknown pre_op result.\n");
+		exit(1);
+		return -1;
+	}
+
+	return umcg_do_wake_or_swap(utls, prev_wait_counter, false, NULL);
+}
+
+int umcg_swap(umcg_tid next, const struct timespec *timeout)
+{
+	struct umcg_task_tls *utls = *(struct umcg_task_tls **)next;
+	bool should_wake, should_wait;
+	uint64_t prev_wait_counter;
+	int ret;
+
+	if (!utls) {
+		errno = EINVAL;
+		return -1;
+	}
+
+again:
+	switch (umcg_prepare_wake(utls)) {
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
+		fprintf(stderr, "lubumcg: unknown pre_op result.\n");
+		exit(1);
+		return -1;
+	}
+
+	switch (umcg_prepare_wait()) {
+	case UMCG_OP_DONE:
+		should_wait = false;
+		break;
+	case UMCG_OP_SYS:
+		should_wait = true;
+		break;
+	case UMCG_OP_ERROR:
+		return -1;
+	default:
+		fprintf(stderr, "lubumcg: unknown pre_op result.\n");
+		exit(1);
+		return -1;
+	}
+
+	if (should_wake)
+		return umcg_do_wake_or_swap(utls, prev_wait_counter,
+				should_wait, timeout);
+
+	if (should_wait)
+		return umcg_do_wait(timeout);
+
+	return 0;
+}
diff --git a/tools/lib/umcg/libumcg.h b/tools/lib/umcg/libumcg.h
new file mode 100644
index 000000000000..31ef786d1965
--- /dev/null
+++ b/tools/lib/umcg/libumcg.h
@@ -0,0 +1,154 @@
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
+static int sys_umcg_api_version(uint32_t requested_api_version, uint32_t flags)
+{
+	return syscall(__NR_umcg_api_version, requested_api_version, flags);
+}
+
+static int sys_umcg_register_task(uint32_t api_version, uint32_t flags,
+		uint32_t group_id, struct umcg_task *umcg_task)
+{
+	return syscall(__NR_umcg_register_task, api_version, flags, group_id,
+			umcg_task);
+}
+
+static int sys_umcg_unregister_task(uint32_t flags)
+{
+	return syscall(__NR_umcg_unregister_task, flags);
+}
+
+static int sys_umcg_wait(uint32_t flags, const struct timespec *timeout)
+{
+	return syscall(__NR_umcg_wait, flags, timeout);
+}
+
+static int sys_umcg_wake(uint32_t flags, uint32_t next_tid)
+{
+	return syscall(__NR_umcg_wake, flags, next_tid);
+}
+
+static int sys_umcg_swap(uint32_t wake_flags, uint32_t next_tid,
+		uint32_t wait_flags, const struct timespec *timeout)
+{
+	return syscall(__NR_umcg_swap, wake_flags, next_tid,
+			wait_flags, timeout);
+}
+
+typedef intptr_t umcg_tid; /* UMCG thread ID. */
+
+#define UMCG_NONE	(0)
+
+/**
+ * umcg_get_utid - return the UMCG ID of the current thread.
+ *
+ * The function always succeeds, and the returned ID is guaranteed to be
+ * stable over the life of the thread (and multiple
+ * umcg_register/umcg_unregister calls).
+ *
+ * The ID is NOT guaranteed to be unique over the life of the process.
+ */
+umcg_tid umcg_get_utid(void);
+
+/**
+ * umcg_set_task_tag - add an arbitrary tag to a registered UMCG task.
+ *
+ * Note: non-thread-safe: the user is responsible for proper memory fencing.
+ */
+void umcg_set_task_tag(umcg_tid utid, intptr_t tag);
+
+/*
+ * umcg_get_task_tag - get the task tag. Returns zero if none set.
+ *
+ * Note: non-thread-safe: the user is responsible for proper memory fencing.
+ */
+intptr_t umcg_get_task_tag(umcg_tid utid);
+
+/**
+ * umcg_register_core_task - register the current thread as a UMCG core task
+ *
+ * Return:
+ * UMCG_NONE     - an error occurred. Check errno.
+ * != UMCG_NONE  - the ID of the thread to be used with UMCG API (guaranteed
+ *                 to match the value returned by umcg_get_utid).
+ */
+umcg_tid umcg_register_core_task(intptr_t tag);
+
+/**
+ * umcg_unregister_task - unregister the current thread
+ *
+ * Return:
+ * 0              - OK
+ * -1             - the current thread is not a UMCG thread
+ */
+int umcg_unregister_task(void);
+
+/**
+ * umcg_wait - block the current thread
+ * @timeout:   absolute timeout (not supported at the moment)
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
+int umcg_wait(const struct timespec *timeout);
+
+/**
+ * umcg_wake - wake @next
+ * @next:      ID of the thread to wake (IDs are returned by umcg_register).
+ *
+ * If @next is blocked via umcg_wait, or umcg_swap, wake it. If @next is
+ * running, queue the wakeup, so that a future block of @next will consume
+ * the wakeup but will not block.
+ *
+ * umcg_wake is non-blocking, but may retry a few times to make sure @next
+ * has indeed woken.
+ *
+ * umcg_wake can queue at most one wakeup; if @next has a wakeup queued,
+ * an error is returned.
+ *
+ * Return:
+ * 0         - OK, @next has woken, or a wakeup has been queued;
+ * -1        - an error occurred.
+ */
+int umcg_wake(umcg_tid next);
+
+/**
+ * umcg_swap - wake @next, put the current thread to sleep
+ * @next:      ID of the thread to wake
+ * @timeout:   absolute timeout (not supported at the moment)
+ *
+ * umcg_swap is semantically equivalent to
+ *
+ *     int ret = umcg_wake(next);
+ *     if (ret)
+ *             return ret;
+ *     return umcg_wait(timeout);
+ *
+ * but may do a synchronous context switch into @next on the current CPU.
+ */
+int umcg_swap(umcg_tid next, const struct timespec *timeout);
+
+#endif  /* __LIBUMCG_H */
-- 
2.31.1.818.g46aad6cb9e-goog


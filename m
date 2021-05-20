Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC84D38B631
	for <lists+linux-api@lfdr.de>; Thu, 20 May 2021 20:36:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235884AbhETSiK (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 20 May 2021 14:38:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235676AbhETSh7 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 20 May 2021 14:37:59 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B00D0C061760
        for <linux-api@vger.kernel.org>; Thu, 20 May 2021 11:36:36 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id d18-20020a05620a2052b02902eabc6fa35eso13321122qka.17
        for <linux-api@vger.kernel.org>; Thu, 20 May 2021 11:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=8yffkhZDmWpXGMStlaSYXLuhZAjuOm4fNCo0Z04i/w8=;
        b=GsucztYPrzjbOEykp+tocWZBX5jNJAupJQLIid9XblEsjBdjSWCYjb2OQqeu+/LXzt
         yg3UHC5fcuu1oxbmgTOVx2X5kWO8zLoaZ2eLUWeQ96tsNDtrRFmqUWygjmdtT9ELmzf6
         c91kql2y3mt9QsDM2UMXrud0t54Zyp7qofJeqDJf09xjv3VOARq026mxZBr0RIjcKvtu
         5fYGGC7us9SImZBY3EdaJJQTeP/vY7sPRJGi/aXrGXMpLVL9aGdNlHvi2xmq8d15Moca
         u0jfMvahIAMzjHH+PEuwXIph/SdhODeDZL5kOXyS5llGWWTnyj7JGO7b1HZRExwkrVCo
         QS2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=8yffkhZDmWpXGMStlaSYXLuhZAjuOm4fNCo0Z04i/w8=;
        b=QHxKDOw7hm6Ff4jR+mVT0HMIJvU5EWY4VPzgyi8qPnH83OfvLaXrx69SfbJm8LykRZ
         kYNZLj1hwb4Maj8UVB3WzCxTA+A7VySL5Srkpkp46FyBAyWCoh9cPLSdzYGHXfmtsxtW
         oE/cQyfCa7t+eXO6/H6AXR+BWjxjfKyLVLFSqQ4bMVCb10o+SyaC8bP38pLfUQIF+5or
         PkGkj+zWNvJr2lQb7RcYXtOYfI9UtP1xDyIMyc9zP7kH7UULUj6fl9WZ4sJn9PtuC5rD
         ehKnZEWG5TzW+Qhck1xds+WEDa218EZ1Lev+YdYRTrzMzPxAUBs6FYslr1D5B69jArNf
         leQA==
X-Gm-Message-State: AOAM530tMbq7gpTrBZTGc62NG2yGgjxjnB8oNpDnNE50iIjYkZQSqS+H
        XgqUzACQw4GGuD5obyN8fbJGL9O9
X-Google-Smtp-Source: ABdhPJzgNvQy260TxIj9DoxZx5NnKywTTcckKGMG6Ktp38J7v63Sc/ZqVhtb6WmiDi7H8/baqKse2d5s
X-Received: from posk.svl.corp.google.com ([2620:15c:2cd:202:f13e:18cf:76e6:2dc4])
 (user=posk job=sendgmr) by 2002:a0c:8bd1:: with SMTP id a17mr7340347qvc.62.1621535795802;
 Thu, 20 May 2021 11:36:35 -0700 (PDT)
Date:   Thu, 20 May 2021 11:36:13 -0700
In-Reply-To: <20210520183614.1227046-1-posk@google.com>
Message-Id: <20210520183614.1227046-9-posk@google.com>
Mime-Version: 1.0
References: <20210520183614.1227046-1-posk@google.com>
X-Mailer: git-send-email 2.31.1.818.g46aad6cb9e-goog
Subject: [RFC PATCH v0.1 8/9] lib/umcg: add UMCG server/worker API (early RFC)
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

Add userspace UMCG server/worker API.

This is an early RFC patch, with a lot of changes expected on the way.

Signed-off-by: Peter Oskolkov <posk@google.com>
---
 tools/lib/umcg/libumcg.c | 222 +++++++++++++++++++++++++++++++++++++++
 tools/lib/umcg/libumcg.h | 108 +++++++++++++++++++
 2 files changed, 330 insertions(+)

diff --git a/tools/lib/umcg/libumcg.c b/tools/lib/umcg/libumcg.c
index b177fb1d4b17..a11c2fc9e6e1 100644
--- a/tools/lib/umcg/libumcg.c
+++ b/tools/lib/umcg/libumcg.c
@@ -101,6 +101,86 @@ umcg_tid umcg_register_core_task(intptr_t tag)
 	return umcg_task_tls->self;
 }
 
+umcg_tid umcg_register_worker(umcg_t group_id, intptr_t tag)
+{
+	int ret;
+	struct umcg_group *group;
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
+	ret = sys_umcg_register_task(umcg_api_version, UMCG_REGISTER_WORKER,
+			group->group_id, &umcg_task_tls->umcg_task);
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
+umcg_tid umcg_register_server(umcg_t group_id, intptr_t tag)
+{
+	int ret;
+	struct umcg_group *group;
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
+	ret = sys_umcg_register_task(umcg_api_version, UMCG_REGISTER_SERVER,
+			group->group_id, &umcg_task_tls->umcg_task);
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
 int umcg_unregister_task(void)
 {
 	int ret;
@@ -348,3 +428,145 @@ int umcg_swap(umcg_tid next, const struct timespec *timeout)
 
 	return 0;
 }
+
+umcg_t umcg_create_group(uint32_t flags)
+{
+	int res = sys_umcg_create_group(umcg_api_version, flags);
+	struct umcg_group *group;
+
+	if (res < 0) {
+		errno = -res;
+		return -1;
+	}
+
+	group = malloc(sizeof(struct umcg_group));
+	if (!group) {
+		errno = ENOMEM;
+		return UMCG_NONE;
+	}
+
+	group->group_id = res;
+	return (intptr_t)group;
+}
+
+int umcg_destroy_group(umcg_t umcg)
+{
+	int res;
+	struct umcg_group *group = (struct umcg_group *)umcg;
+
+	res = sys_umcg_destroy_group(group->group_id);
+	if (res) {
+		errno = -res;
+		return -1;
+	}
+
+	free(group);
+	return 0;
+}
+
+umcg_tid umcg_poll_worker(void)
+{
+	struct umcg_task *server_ut = &umcg_task_tls->umcg_task;
+	struct umcg_task *worker_ut;
+	uint32_t expected_state;
+	int ret;
+
+	expected_state = UMCG_TASK_PROCESSING;
+	if (!atomic_compare_exchange_strong_explicit(&server_ut->state,
+			&expected_state, UMCG_TASK_POLLING,
+			memory_order_seq_cst, memory_order_seq_cst)) {
+		fprintf(stderr, "umcg_poll_worker: wrong server state before: %u\n",
+				expected_state);
+		exit(1);
+		return UMCG_NONE;
+	}
+	ret = sys_umcg_poll_worker(0, &worker_ut);
+
+	expected_state = UMCG_TASK_POLLING;
+	if (!atomic_compare_exchange_strong_explicit(&server_ut->state,
+			&expected_state, UMCG_TASK_PROCESSING,
+			memory_order_seq_cst, memory_order_seq_cst)) {
+		fprintf(stderr, "umcg_poll_worker: wrong server state after: %u\n",
+				expected_state);
+		exit(1);
+		return UMCG_NONE;
+	}
+
+	if (ret) {
+		fprintf(stderr, "sys_umcg_poll_worker: unexpected result %d\n",
+				errno);
+		exit(1);
+		return UMCG_NONE;
+	}
+
+	return umcg_task_to_utid(worker_ut);
+}
+
+umcg_tid umcg_run_worker(umcg_tid worker)
+{
+	struct umcg_task_tls *worker_utls;
+	struct umcg_task *server_ut = &umcg_task_tls->umcg_task;
+	struct umcg_task *worker_ut;
+	uint32_t expected_state;
+	int ret;
+
+	worker_utls = atomic_load_explicit((struct umcg_task_tls **)worker,
+			memory_order_seq_cst);
+	if (!worker_utls)
+		return UMCG_NONE;
+
+	worker_ut = &worker_utls->umcg_task;
+
+	expected_state = UMCG_TASK_RUNNABLE;
+	if (!atomic_compare_exchange_strong_explicit(&worker_ut->state,
+			&expected_state, UMCG_TASK_RUNNING,
+			memory_order_seq_cst, memory_order_seq_cst)) {
+		fprintf(stderr, "umcg_run_worker: wrong worker state: %u\n",
+				expected_state);
+		exit(1);
+		return UMCG_NONE;
+	}
+
+	expected_state = UMCG_TASK_PROCESSING;
+	if (!atomic_compare_exchange_strong_explicit(&server_ut->state,
+			&expected_state, UMCG_TASK_SERVING,
+			memory_order_seq_cst, memory_order_seq_cst)) {
+		fprintf(stderr, "umcg_run_worker: wrong server state: %u\n",
+				expected_state);
+		exit(1);
+		return UMCG_NONE;
+	}
+
+again:
+	ret = sys_umcg_run_worker(0, worker_utls->tid, &worker_ut);
+	if (ret && errno == EAGAIN)
+		goto again;
+
+	if (ret) {
+		fprintf(stderr, "umcg_run_worker failed: %d %d\n", ret, errno);
+		return UMCG_NONE;
+	}
+
+	expected_state = UMCG_TASK_SERVING;
+	if (!atomic_compare_exchange_strong_explicit(&server_ut->state,
+			&expected_state, UMCG_TASK_PROCESSING,
+			memory_order_seq_cst, memory_order_seq_cst)) {
+		fprintf(stderr, "umcg_run_worker: wrong server state: %u\n",
+				expected_state);
+		exit(1);
+		return UMCG_NONE;
+	}
+
+	return umcg_task_to_utid(worker_ut);
+}
+
+uint32_t umcg_get_task_state(umcg_tid task)
+{
+	struct umcg_task_tls *utls = atomic_load_explicit(
+			(struct umcg_task_tls **)task, memory_order_seq_cst);
+
+	if (!utls)
+		return UMCG_TASK_NONE;
+
+	return atomic_load_explicit(&utls->umcg_task.state, memory_order_relaxed);
+}
diff --git a/tools/lib/umcg/libumcg.h b/tools/lib/umcg/libumcg.h
index 31ef786d1965..4307bc0bd08e 100644
--- a/tools/lib/umcg/libumcg.h
+++ b/tools/lib/umcg/libumcg.h
@@ -49,6 +49,28 @@ static int sys_umcg_swap(uint32_t wake_flags, uint32_t next_tid,
 			wait_flags, timeout);
 }
 
+static int32_t sys_umcg_create_group(uint32_t api_version, uint32_t flags)
+{
+	return syscall(__NR_umcg_create_group, api_version, flags);
+}
+
+static int sys_umcg_destroy_group(int32_t group_id)
+{
+	return syscall(__NR_umcg_destroy_group, group_id);
+}
+
+static int sys_umcg_poll_worker(uint32_t flags, struct umcg_task **ut)
+{
+	return syscall(__NR_umcg_poll_worker, flags, ut);
+}
+
+static int sys_umcg_run_worker(uint32_t flags, uint32_t worker_tid,
+		struct umcg_task **ut)
+{
+	return syscall(__NR_umcg_run_worker, flags, worker_tid, ut);
+}
+
+typedef intptr_t umcg_t;   /* UMCG group ID. */
 typedef intptr_t umcg_tid; /* UMCG thread ID. */
 
 #define UMCG_NONE	(0)
@@ -88,6 +110,28 @@ intptr_t umcg_get_task_tag(umcg_tid utid);
  */
 umcg_tid umcg_register_core_task(intptr_t tag);
 
+/**
+ * umcg_register_worker - register the current thread as a UMCG worker
+ * @group_id:      The ID of the UMCG group the thread should join.
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
+ * @group_id:      The ID of the UMCG group the thread should join.
+ *
+ * Return:
+ * UMCG_NONE     - an error occurred. Check errno.
+ * != UMCG_NONE  - the ID of the thread to be used with UMCG API (guaranteed
+ *                 to match the value returned by umcg_get_utid).
+ */
+umcg_tid umcg_register_server(umcg_t group_id, intptr_t tag);
+
 /**
  * umcg_unregister_task - unregister the current thread
  *
@@ -151,4 +195,68 @@ int umcg_wake(umcg_tid next);
  */
 int umcg_swap(umcg_tid next, const struct timespec *timeout);
 
+/**
+ * umcg_create_group - create a UMCG group
+ * @flags:             Reserved.
+ *
+ * UMCG groups have worker and server threads.
+ *
+ * Worker threads are either RUNNABLE/RUNNING "on behalf" of server threads
+ * (see umcg_run_worker), or are BLOCKED/UNBLOCKED. A worker thread can be
+ * running only if it is attached to a server thread (interrupts can
+ * complicate the matter - TBD).
+ *
+ * Server threads are either blocked while running worker threads or are
+ * blocked waiting for available (=UNBLOCKED) workers. A server thread
+ * can "run" only one worker thread.
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
+ * umcg_poll_worker - wait for the first available UNBLOCKED worker
+ *
+ * The current thread must be a UMCG server. If there is a list/queue of
+ * waiting UNBLOCKED workers in the server's group, umcg_poll_worker
+ * picks the longest waiting one; if there are no UNBLOCKED workers, the
+ * current thread sleeps in the polling queue.
+ *
+ * Return:
+ * UMCG_NONE         - an error occurred; check errno;
+ * != UMCG_NONE      - a RUNNABLE worker.
+ */
+umcg_tid umcg_poll_worker(void);
+
+/**
+ * umcg_run_worker - run @worker as a UMCG server
+ * @worker:          the ID of a RUNNABLE worker to run
+ *
+ * The current thread must be a UMCG "server".
+ *
+ * Return:
+ * UMCG_NONE    - if errno == 0, the last worker the server was running
+ *                unregistered itself; if errno != 0, an error occurred
+ * != UMCG_NONE - the ID of the last worker the server was running before
+ *                the worker was blocked or preempted.
+ */
+umcg_tid umcg_run_worker(umcg_tid worker);
+
+uint32_t umcg_get_task_state(umcg_tid task);
+
 #endif  /* __LIBUMCG_H */
-- 
2.31.1.818.g46aad6cb9e-goog


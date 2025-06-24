Return-Path: <linux-api+bounces-3966-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BE47AE6E1C
	for <lists+linux-api@lfdr.de>; Tue, 24 Jun 2025 20:08:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C58AF7AE091
	for <lists+linux-api@lfdr.de>; Tue, 24 Jun 2025 18:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FD492E7F32;
	Tue, 24 Jun 2025 18:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EC1C8hiE"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C9672E7F16;
	Tue, 24 Jun 2025 18:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750788470; cv=none; b=cJh4A8M5e80d+nVbZflWbgRXd8kbfVLtk0XdKyNXakGE9RdOf0WyJArQgMsZ2qZBzmUunm8HZxsFzBthSVR99tUFU09VmptPIdp4DHIDbgeyG7mdzIzn3/D8a6HUvexF/FVZon+7jLTf0VOBYPWi85CIBVuWvKwns5i6B6J6cqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750788470; c=relaxed/simple;
	bh=4CMcX+ukeI0NVC7/rUfURT44bLCvCWYouiKAtEToeCI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qdGrL0lCjFGzK+xaH+HbPxUe6ky+BjTCJ3Qn+h/ttJQ31lAxZ/o20rwJ7l6oVT5VmAnCHu4vCS/Q0WY7p/QC9MZfSmoaw6z3sFaNMCdxm3o5H7nGZc3Qla2ayBxo8Z3/Ae/CKssg196pm6ZoPeVCvlyG+XjtqSZEYI3F6ACimYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EC1C8hiE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4531C19422;
	Tue, 24 Jun 2025 18:07:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750788470;
	bh=4CMcX+ukeI0NVC7/rUfURT44bLCvCWYouiKAtEToeCI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EC1C8hiEjT87Z8rJIQ165w+DsEeUaT4BztHiScFyxLC8qf7N/zdpfH0xsXv65VRM9
	 +Ijo/eJly6QxOiwevjcYFUy8Cb3SEXak+9qA/r5LydHQSYE7PDw1upgMzku/bVNfjT
	 7RhJBqtWnY71GP8gUQHhoF1xn2fwEXq+pdUp4IRNtwd6hDeSEmD4mVn4MEsdWQV9++
	 zzd7wAh2jDUKMewMEQbHE8v7/Jg6uACZ+MZIQCYiNTEcNh0Wqsx+H7/D5eqHFyEYCS
	 F7MgB6rR8JkKMCa6GHvj00rx7TLG4gb0rmXPFth5UZ7qj9J3i1c9EIzq3VDB7y7j4g
	 OtCOdkCTfFZOQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-doc@vger.kernel.org,
	linux-api@vger.kernel.org,
	workflows@vger.kernel.org,
	tools@kernel.org,
	Sasha Levin <sashal@kernel.org>
Subject: [RFC v2 05/22] eventpoll: add API specification for epoll_wait
Date: Tue, 24 Jun 2025 14:07:25 -0400
Message-Id: <20250624180742.5795-6-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250624180742.5795-1-sashal@kernel.org>
References: <20250624180742.5795-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add kernel API specification for the epoll_wait() system call.

Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/eventpoll.c | 187 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 187 insertions(+)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index b0334f1af0875..dc2c7d7e777f3 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -3026,6 +3026,193 @@ static int do_epoll_wait(int epfd, struct epoll_event __user *events,
 	return ep_poll(ep, events, maxevents, to);
 }
 
+
+DEFINE_KERNEL_API_SPEC(sys_epoll_wait)
+	KAPI_DESCRIPTION("Wait for events on an epoll instance")
+	KAPI_LONG_DESC("Waits for events on the epoll instance referred to by epfd. "
+		       "The function blocks the calling thread until either at least one of the "
+		       "file descriptors referred to by epfd becomes ready for some I/O operation, "
+		       "the call is interrupted by a signal handler, or the timeout expires.")
+	KAPI_CONTEXT(KAPI_CTX_PROCESS | KAPI_CTX_SLEEPABLE)
+
+	KAPI_PARAM(0, "epfd", "int", "File descriptor referring to the epoll instance")
+		KAPI_PARAM_FLAGS(KAPI_PARAM_IN)
+		KAPI_PARAM_TYPE(KAPI_TYPE_FD)
+		KAPI_PARAM_CONSTRAINT_TYPE(KAPI_CONSTRAINT_NONE)
+	KAPI_PARAM_END
+
+	KAPI_PARAM(1, "events", "struct epoll_event __user *", "Buffer where ready events will be stored")
+		KAPI_PARAM_FLAGS(KAPI_PARAM_OUT | KAPI_PARAM_USER)
+		KAPI_PARAM_TYPE(KAPI_TYPE_USER_PTR)
+		KAPI_PARAM_SIZE(sizeof(struct epoll_event))  /* Base size of single element */
+		.size_param_idx = 2,  /* Size determined by maxevents parameter */
+		.size_multiplier = sizeof(struct epoll_event),
+		KAPI_PARAM_CONSTRAINT_TYPE(KAPI_CONSTRAINT_NONE)
+		KAPI_PARAM_CONSTRAINT("Must point to an array of at least maxevents epoll_event structures")
+	KAPI_PARAM_END
+
+	KAPI_PARAM(2, "maxevents", "int", "Maximum number of events to return")
+		KAPI_PARAM_FLAGS(KAPI_PARAM_IN)
+		KAPI_PARAM_TYPE(KAPI_TYPE_INT)
+		KAPI_PARAM_RANGE(1, INT_MAX / sizeof(struct epoll_event))  /* EP_MAX_EVENTS */
+		KAPI_PARAM_CONSTRAINT_TYPE(KAPI_CONSTRAINT_RANGE)
+		KAPI_PARAM_CONSTRAINT("Must be greater than zero and not exceed system limits")
+	KAPI_PARAM_END
+
+	KAPI_PARAM(3, "timeout", "int", "Timeout in milliseconds")
+		KAPI_PARAM_FLAGS(KAPI_PARAM_IN)
+		KAPI_PARAM_TYPE(KAPI_TYPE_INT)
+		KAPI_PARAM_CONSTRAINT_TYPE(KAPI_CONSTRAINT_NONE)
+		KAPI_PARAM_CONSTRAINT("-1 blocks indefinitely, 0 returns immediately, >0 specifies milliseconds to wait")
+	KAPI_PARAM_END
+
+	KAPI_RETURN("long", "Number of ready file descriptors on success, negative error code on failure")
+		.type = KAPI_TYPE_INT,
+		.check_type = KAPI_RETURN_RANGE,
+		.success_min = 0,
+		.success_max = INT_MAX,
+	KAPI_RETURN_END
+
+	KAPI_ERROR(0, -EBADF, "EBADF", "epfd is not a valid file descriptor",
+		   "The epoll file descriptor is invalid or has been closed.")
+	KAPI_ERROR(1, -EFAULT, "EFAULT", "events points outside accessible address space",
+		   "The memory area pointed to by events is not accessible with write permissions.")
+	KAPI_ERROR(2, -EINTR, "EINTR", "Call interrupted by signal handler",
+		   "The call was interrupted by a signal handler before any events "
+		   "became ready or the timeout expired.")
+	KAPI_ERROR(3, -EINVAL, "EINVAL", "Invalid parameters",
+		   "epfd is not an epoll file descriptor, or maxevents is less than or equal to zero.")
+
+	.error_count = 4,
+	.param_count = 4,
+	.since_version = "2.6",
+
+	/* Side effects */
+	KAPI_SIDE_EFFECT(0, KAPI_EFFECT_MODIFY_STATE,
+			 "ready list",
+			 "Removes events from the epoll ready list as they are reported")
+		KAPI_EFFECT_CONDITION("When events are available and level-triggered")
+		KAPI_EFFECT_REVERSIBLE
+	KAPI_SIDE_EFFECT_END
+
+	KAPI_SIDE_EFFECT(1, KAPI_EFFECT_SCHEDULE,
+			 "process state",
+			 "Blocks the calling thread until events are available or timeout")
+		KAPI_EFFECT_CONDITION("When timeout != 0 and no events are immediately available")
+	KAPI_SIDE_EFFECT_END
+
+	KAPI_SIDE_EFFECT(2, KAPI_EFFECT_MODIFY_STATE,
+			 "user memory",
+			 "Writes event data to user-provided buffer")
+		KAPI_EFFECT_CONDITION("When events are available")
+	KAPI_SIDE_EFFECT_END
+
+	KAPI_SIDE_EFFECT(3, KAPI_EFFECT_PROCESS_STATE,
+			 "signal state",
+			 "Clears TIF_SIGPENDING if a signal was pending")
+		KAPI_EFFECT_CONDITION("When returning due to signal interruption")
+	KAPI_SIDE_EFFECT_END
+
+	KAPI_SIDE_EFFECT_COUNT(4)
+
+	/* State transitions */
+	KAPI_STATE_TRANS(0, "process", "running", "blocked",
+			 "Process blocks waiting for events")
+		KAPI_STATE_TRANS_COND("When no events available and timeout != 0")
+	KAPI_STATE_TRANS_END
+
+	KAPI_STATE_TRANS(1, "process", "blocked", "running",
+			 "Process wakes up due to events, timeout, or signal")
+		KAPI_STATE_TRANS_COND("When wait condition is satisfied")
+	KAPI_STATE_TRANS_END
+
+	KAPI_STATE_TRANS(2, "epoll ready list", "has events", "events consumed",
+			 "Ready events are consumed from the epoll instance")
+		KAPI_STATE_TRANS_COND("When returning events to userspace")
+	KAPI_STATE_TRANS_END
+
+	KAPI_STATE_TRANS(3, "events buffer", "uninitialized", "contains event data",
+			 "User buffer is populated with ready events")
+		KAPI_STATE_TRANS_COND("When events are available")
+	KAPI_STATE_TRANS_END
+
+	KAPI_STATE_TRANS_COUNT(4)
+
+	/* Signal specifications */
+	KAPI_SIGNAL(0, 0, "ANY", KAPI_SIGNAL_RECEIVE, KAPI_SIGNAL_ACTION_RETURN)
+		KAPI_SIGNAL_CONDITION("Any pending signal")
+		KAPI_SIGNAL_DESC("Any signal delivered to the thread will interrupt epoll_wait() "
+				 "and cause it to return -EINTR. This is checked via signal_pending() "
+				 "after checking for available events.")
+		KAPI_SIGNAL_RESTARTABLE
+	KAPI_SIGNAL_END
+
+	KAPI_SIGNAL(1, SIGKILL, "SIGKILL", KAPI_SIGNAL_RECEIVE, KAPI_SIGNAL_ACTION_TERMINATE)
+		KAPI_SIGNAL_CONDITION("Always delivered, cannot be blocked")
+		KAPI_SIGNAL_DESC("SIGKILL will terminate the process. The epoll_wait call will "
+				 "not return as the process is terminated immediately.")
+	KAPI_SIGNAL_END
+
+	KAPI_SIGNAL(2, SIGSTOP, "SIGSTOP", KAPI_SIGNAL_RECEIVE, KAPI_SIGNAL_ACTION_STOP)
+		KAPI_SIGNAL_CONDITION("Always delivered, cannot be blocked")
+		KAPI_SIGNAL_DESC("SIGSTOP will stop the process. When continued with SIGCONT, "
+				 "epoll_wait may return -EINTR if the timeout has not expired.")
+	KAPI_SIGNAL_END
+
+	KAPI_SIGNAL(3, SIGCONT, "SIGCONT", KAPI_SIGNAL_RECEIVE, KAPI_SIGNAL_ACTION_CONTINUE)
+		KAPI_SIGNAL_CONDITION("When process is stopped")
+		KAPI_SIGNAL_DESC("SIGCONT resumes a stopped process. If epoll_wait was interrupted "
+				 "by SIGSTOP, it may return -EINTR when continued.")
+	KAPI_SIGNAL_END
+
+	KAPI_SIGNAL(4, SIGALRM, "SIGALRM", KAPI_SIGNAL_RECEIVE, KAPI_SIGNAL_ACTION_RETURN)
+		KAPI_SIGNAL_CONDITION("Timer expiration")
+		KAPI_SIGNAL_DESC("SIGALRM from timer expiration will interrupt epoll_wait with -EINTR")
+		KAPI_SIGNAL_RESTARTABLE
+	KAPI_SIGNAL_END
+
+	.signal_count = 5,
+	.signal_mask_count = 0, /* No signal mask manipulation in epoll_wait */
+
+	/* Locking specifications */
+	KAPI_LOCK(0, "ep->lock", KAPI_LOCK_SPINLOCK)
+		KAPI_LOCK_ACQUIRED
+		KAPI_LOCK_RELEASED
+		KAPI_LOCK_DESC("Protects the ready list while checking for and consuming events")
+	KAPI_LOCK_END
+
+	KAPI_LOCK(1, "ep->mtx", KAPI_LOCK_MUTEX)
+		KAPI_LOCK_ACQUIRED
+		KAPI_LOCK_RELEASED
+		KAPI_LOCK_DESC("Protects against concurrent epoll_ctl operations during wait")
+	KAPI_LOCK_END
+
+	.lock_count = 2,
+
+	KAPI_EXAMPLES("struct epoll_event events[10];\n"
+		      "int nfds = epoll_wait(epfd, events, 10, 1000);\n"
+		      "if (nfds == -1) {\n"
+		      "    perror(\"epoll_wait\");\n"
+		      "    exit(EXIT_FAILURE);\n"
+		      "}\n"
+		      "for (int n = 0; n < nfds; ++n) {\n"
+		      "    if (events[n].data.fd == listen_sock) {\n"
+		      "        accept_new_connection();\n"
+		      "    } else {\n"
+		      "        handle_io(events[n].data.fd);\n"
+		      "    }\n"
+		      "}")
+	KAPI_NOTES("The timeout uses CLOCK_MONOTONIC and may be rounded up to system clock granularity. "
+		   "A timeout of -1 causes epoll_wait to block indefinitely, while a timeout of 0 "
+		   "causes it to return immediately even if no events are available. "
+		   "The struct epoll_event is defined as containing events (uint32_t) and data (epoll_data_t union). "
+		   "Edge-triggered mode (EPOLLET) can cause starvation if not all available data is "
+		   "drained when an event is received - new events are only generated on transitions "
+		   "from no data to data available. Always read/write until EAGAIN to avoid missing events. "
+		   "When using dup() or fork(), events may be delivered to multiple epoll instances "
+		   "monitoring the same file descriptor.")
+KAPI_END_SPEC;
+
 SYSCALL_DEFINE4(epoll_wait, int, epfd, struct epoll_event __user *, events,
 		int, maxevents, int, timeout)
 {
-- 
2.39.5



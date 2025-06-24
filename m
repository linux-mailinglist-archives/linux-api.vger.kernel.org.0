Return-Path: <linux-api+bounces-3967-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04BCCAE6E1D
	for <lists+linux-api@lfdr.de>; Tue, 24 Jun 2025 20:08:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F3A13B3CFB
	for <lists+linux-api@lfdr.de>; Tue, 24 Jun 2025 18:08:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 521EB2E92A7;
	Tue, 24 Jun 2025 18:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tqb2teII"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2069B2E8DFF;
	Tue, 24 Jun 2025 18:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750788471; cv=none; b=ZMI6tja/CSdqPuLTX0KILvcfS66z+CfFqLcolTO9DRR2QYvlDPnmgaomf6j+7Yx672ZwrdIUCxvd9Fc9w7NruVZ+CleyczvFkBCViR2gFlKNYMLGxpXBbNzFIX9Tg0OBmkmihkSVirIhLffDqWXLcKrgxOI3jVDmNy4Le7lUfYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750788471; c=relaxed/simple;
	bh=PkPUBngP0eNKNIf57EhrF01lVrPMtPUDy/ox/F5xpHw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Nvv5srvuBgW7LMeWBBFp1S7/VzmASYWm6jLjqUyv/NJlDMQQfQ6dFTYqZsHO/vKyr60jrxoIdu1i5+ql6ZNfulRM+OQK56RpKJzOMwA24EBBq6tT5li16jFmaJE0YBIFNzJwm3HUttrh6drsbmS5y9i3zIoTHWdBYDVpQufImic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tqb2teII; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56A55C4CEEF;
	Tue, 24 Jun 2025 18:07:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750788470;
	bh=PkPUBngP0eNKNIf57EhrF01lVrPMtPUDy/ox/F5xpHw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Tqb2teIIuAEcE6O2LVLczeyYnKi0tiz16GokCQcGme4hRYxhH3J7HM1BxIL+BkcmW
	 t0uVK5HSWR4SaTZtQgYr5YI/pdJQxuQaJJ8QTz0PpSyNksvTJ+Zfdku5WEU3qEZYAW
	 KnKnvGXOvYb4XJZ1754gpesxxT8wMuLcT8Qe93npXOKb/l5fCKDjJdYkGeuzZ7rDIZ
	 4d6bHbLGC49r5TxyfIMc5ramWdQSsNjW9/I1h+zF0gAKP1sf+dlt2QUEv10QPCNWxg
	 FEFo9zeUHvbRTRUIBB/Lq6oCVW81Ex4uIQZXRa3+4cCT0lMZ0QEvhx2D7u7Q+zcbCu
	 3RrHjWmoDS73w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-doc@vger.kernel.org,
	linux-api@vger.kernel.org,
	workflows@vger.kernel.org,
	tools@kernel.org,
	Sasha Levin <sashal@kernel.org>
Subject: [RFC v2 06/22] eventpoll: add API specification for epoll_pwait
Date: Tue, 24 Jun 2025 14:07:26 -0400
Message-Id: <20250624180742.5795-7-sashal@kernel.org>
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

Add kernel API specification for the epoll_pwait() system call.

Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/eventpoll.c | 234 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 234 insertions(+)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index dc2c7d7e777f3..07477643b9380 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -3247,6 +3247,240 @@ static int do_epoll_pwait(int epfd, struct epoll_event __user *events,
 	return error;
 }
 
+
+DEFINE_KERNEL_API_SPEC(sys_epoll_pwait)
+	KAPI_DESCRIPTION("Wait for events on an epoll instance with signal handling")
+	KAPI_LONG_DESC("Similar to epoll_wait(), but allows the caller to safely wait for "
+		       "either events on the epoll instance or the delivery of a signal. "
+		       "The sigmask argument specifies a signal mask which is atomically "
+		       "set during the wait, allowing signals to be blocked while not waiting "
+		       "and ensuring no signal is lost between checking for events and blocking.")
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
+		KAPI_PARAM_SIZE(sizeof(struct epoll_event))
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
+	KAPI_PARAM(4, "sigmask", "const sigset_t __user *", "Signal mask to atomically set during wait")
+		KAPI_PARAM_FLAGS(KAPI_PARAM_IN | KAPI_PARAM_USER | KAPI_PARAM_OPTIONAL)
+		KAPI_PARAM_TYPE(KAPI_TYPE_USER_PTR)
+		KAPI_PARAM_SIZE(sizeof(sigset_t))
+		KAPI_PARAM_CONSTRAINT_TYPE(KAPI_CONSTRAINT_NONE)
+		KAPI_PARAM_CONSTRAINT("Can be NULL if no signal mask change is desired")
+	KAPI_PARAM_END
+
+	KAPI_PARAM(5, "sigsetsize", "size_t", "Size of the signal set in bytes")
+		KAPI_PARAM_FLAGS(KAPI_PARAM_IN)
+		KAPI_PARAM_TYPE(KAPI_TYPE_UINT)
+		KAPI_PARAM_RANGE(sizeof(sigset_t), sizeof(sigset_t))
+		KAPI_PARAM_CONSTRAINT_TYPE(KAPI_CONSTRAINT_RANGE)
+		KAPI_PARAM_CONSTRAINT("Must be sizeof(sigset_t)")
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
+	KAPI_ERROR(1, -EFAULT, "EFAULT", "Memory area not accessible",
+		   "The memory area pointed to by events or sigmask is not accessible.")
+	KAPI_ERROR(2, -EINTR, "EINTR", "Call interrupted by signal handler",
+		   "The call was interrupted by a signal handler before any events "
+		   "became ready or the timeout expired; see signal(7).")
+	KAPI_ERROR(3, -EINVAL, "EINVAL", "Invalid parameters",
+		   "epfd is not an epoll file descriptor, maxevents is less than or equal to zero, "
+		   "or sigsetsize is not equal to sizeof(sigset_t).")
+
+	.error_count = 4,
+	.param_count = 6,
+	.since_version = "2.6.19",
+
+	/* Side effects */
+	KAPI_SIDE_EFFECT(0, KAPI_EFFECT_MODIFY_STATE,
+			 "signal mask",
+			 "Atomically sets the signal mask for the calling thread")
+		KAPI_EFFECT_CONDITION("When sigmask is not NULL")
+		KAPI_EFFECT_REVERSIBLE
+	KAPI_SIDE_EFFECT_END
+
+	KAPI_SIDE_EFFECT(1, KAPI_EFFECT_MODIFY_STATE,
+			 "ready list",
+			 "Removes events from the epoll ready list as they are reported")
+		KAPI_EFFECT_CONDITION("When events are available and level-triggered")
+		KAPI_EFFECT_REVERSIBLE
+	KAPI_SIDE_EFFECT_END
+
+	KAPI_SIDE_EFFECT(2, KAPI_EFFECT_SCHEDULE,
+			 "process state",
+			 "Blocks the calling thread until events are available, timeout, or signal")
+		KAPI_EFFECT_CONDITION("When timeout != 0 and no events are immediately available")
+	KAPI_SIDE_EFFECT_END
+
+	KAPI_SIDE_EFFECT(3, KAPI_EFFECT_MODIFY_STATE,
+			 "user memory",
+			 "Writes event data to user-provided buffer")
+		KAPI_EFFECT_CONDITION("When events are available")
+	KAPI_SIDE_EFFECT_END
+
+	KAPI_SIDE_EFFECT(4, KAPI_EFFECT_PROCESS_STATE,
+			 "saved signal mask",
+			 "Saves and restores the original signal mask")
+		KAPI_EFFECT_CONDITION("When sigmask is not NULL")
+		KAPI_EFFECT_REVERSIBLE
+	KAPI_SIDE_EFFECT_END
+
+	KAPI_SIDE_EFFECT_COUNT(5)
+
+	/* State transitions */
+	KAPI_STATE_TRANS(0, "signal mask", "original mask", "user-specified mask",
+			 "Thread's signal mask is atomically changed to the provided mask")
+		KAPI_STATE_TRANS_COND("When sigmask is not NULL")
+	KAPI_STATE_TRANS_END
+
+	KAPI_STATE_TRANS(1, "process", "running", "blocked",
+			 "Process blocks waiting for events with specified signal mask")
+		KAPI_STATE_TRANS_COND("When no events available and timeout != 0")
+	KAPI_STATE_TRANS_END
+
+	KAPI_STATE_TRANS(2, "process", "blocked", "running",
+			 "Process wakes up due to events, timeout, or unblocked signal")
+		KAPI_STATE_TRANS_COND("When wait condition is satisfied")
+	KAPI_STATE_TRANS_END
+
+	KAPI_STATE_TRANS(3, "signal mask", "user-specified mask", "original mask",
+			 "Thread's signal mask is restored to its original value")
+		KAPI_STATE_TRANS_COND("When returning from epoll_pwait")
+	KAPI_STATE_TRANS_END
+
+	KAPI_STATE_TRANS(4, "pending signals", "blocked", "deliverable",
+			 "Signals that were blocked by the temporary mask become deliverable")
+		KAPI_STATE_TRANS_COND("When signal mask is restored and signals were pending")
+	KAPI_STATE_TRANS_END
+
+	KAPI_STATE_TRANS_COUNT(5)
+
+	/* Signal specifications */
+	KAPI_SIGNAL(0, 0, "ANY_UNBLOCKED", KAPI_SIGNAL_RECEIVE, KAPI_SIGNAL_ACTION_RETURN)
+		KAPI_SIGNAL_CONDITION("Signal not blocked by provided sigmask")
+		KAPI_SIGNAL_DESC("Any signal not blocked by the sigmask parameter will interrupt "
+				 "epoll_pwait() and cause it to return -EINTR. The signal mask is "
+				 "atomically set via set_user_sigmask() and restored via "
+				 "restore_saved_sigmask_unless() before returning.")
+		KAPI_SIGNAL_RESTARTABLE
+	KAPI_SIGNAL_END
+
+	KAPI_SIGNAL(1, SIGKILL, "SIGKILL", KAPI_SIGNAL_RECEIVE, KAPI_SIGNAL_ACTION_TERMINATE)
+		KAPI_SIGNAL_CONDITION("Cannot be blocked by sigmask")
+		KAPI_SIGNAL_DESC("SIGKILL cannot be blocked and will terminate the process immediately. "
+				 "The epoll_pwait call will not return.")
+	KAPI_SIGNAL_END
+
+	KAPI_SIGNAL(2, SIGSTOP, "SIGSTOP", KAPI_SIGNAL_RECEIVE, KAPI_SIGNAL_ACTION_STOP)
+		KAPI_SIGNAL_CONDITION("Cannot be blocked by sigmask")
+		KAPI_SIGNAL_DESC("SIGSTOP cannot be blocked and will stop the process. When continued "
+				 "with SIGCONT, epoll_pwait may return -EINTR.")
+	KAPI_SIGNAL_END
+
+	KAPI_SIGNAL(3, 0, "BLOCKED_SIGNALS", KAPI_SIGNAL_BLOCK, KAPI_SIGNAL_ACTION_DEFAULT)
+		KAPI_SIGNAL_CONDITION("Signals in provided sigmask")
+		KAPI_SIGNAL_DESC("Signals specified in the sigmask parameter are blocked for the "
+				 "duration of the epoll_pwait call. They remain pending and will be "
+				 "delivered after the signal mask is restored.")
+	KAPI_SIGNAL_END
+
+	KAPI_SIGNAL(4, SIGCONT, "SIGCONT", KAPI_SIGNAL_RECEIVE, KAPI_SIGNAL_ACTION_CONTINUE)
+		KAPI_SIGNAL_CONDITION("When process is stopped")
+		KAPI_SIGNAL_DESC("SIGCONT resumes a stopped process. If epoll_pwait was interrupted "
+				 "by SIGSTOP, it may return -EINTR when continued.")
+	KAPI_SIGNAL_END
+
+	.signal_count = 5,
+
+	/* Signal mask specifications */
+	KAPI_SIGNAL_MASK(0, "user_sigmask", "User-provided signal mask atomically applied")
+		.description = "The signal mask provided in the sigmask parameter is atomically "
+			       "set for the duration of the wait operation. This prevents race "
+			       "conditions between checking for events and blocking. The original "
+			       "signal mask is restored before epoll_pwait returns, unless the "
+			       "return value is -EINTR (in which case the mask is restored by "
+			       "the signal delivery mechanism)."
+	KAPI_SIGNAL_MASK_END
+
+	.signal_mask_count = 1,
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
+	KAPI_EXAMPLES("sigset_t sigmask;\n"
+		      "struct epoll_event events[10];\n\n"
+		      "/* Block SIGINT during epoll_pwait */\n"
+		      "sigemptyset(&sigmask);\n"
+		      "sigaddset(&sigmask, SIGINT);\n\n"
+		      "int nfds = epoll_pwait(epfd, events, 10, 1000, &sigmask, sizeof(sigmask));\n"
+		      "if (nfds == -1) {\n"
+		      "    if (errno == EINTR) {\n"
+		      "        /* Handle signal */\n"
+		      "    }\n"
+		      "    perror(\"epoll_pwait\");\n"
+		      "    exit(EXIT_FAILURE);\n"
+		      "}")
+	KAPI_NOTES("epoll_pwait() is equivalent to atomically executing:\n"
+		   "    sigset_t origmask;\n"
+		   "    pthread_sigmask(SIG_SETMASK, &sigmask, &origmask);\n"
+		   "    ready = epoll_wait(epfd, events, maxevents, timeout);\n"
+		   "    pthread_sigmask(SIG_SETMASK, &origmask, NULL);\n"
+		   "This atomicity prevents race conditions where a signal could be delivered "
+		   "after checking for events but before blocking in epoll_wait(). "
+		   "The signal mask is always restored before epoll_pwait() returns. "
+		   "Edge-triggered mode (EPOLLET) can cause starvation if not all available data is "
+		   "drained when an event is received. Always read/write until EAGAIN. "
+		   "When using dup() or fork(), events may be delivered to multiple epoll instances "
+		   "monitoring the same file descriptor.")
+KAPI_END_SPEC;
+
 SYSCALL_DEFINE6(epoll_pwait, int, epfd, struct epoll_event __user *, events,
 		int, maxevents, int, timeout, const sigset_t __user *, sigmask,
 		size_t, sigsetsize)
-- 
2.39.5



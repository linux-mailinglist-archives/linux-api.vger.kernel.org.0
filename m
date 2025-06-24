Return-Path: <linux-api+bounces-3968-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B38D3AE6E27
	for <lists+linux-api@lfdr.de>; Tue, 24 Jun 2025 20:09:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFB41166EF1
	for <lists+linux-api@lfdr.de>; Tue, 24 Jun 2025 18:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D93662E9EDF;
	Tue, 24 Jun 2025 18:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ez1mPUs5"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3D592E9729;
	Tue, 24 Jun 2025 18:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750788471; cv=none; b=JApKIiBF94mPcJ2frqlcH3Uvy1PAcC+9o+DC2KXFvCsP45K5P3pur0WgaQlWXY+QPyt93ykfEP0BZTgSQWpubY3Ec+yvLqHn4e33z3Qm6Hw9YPDAmZbXRVtXkNxEjaKrLLYNRM+PGRg1qRMJjly+axIxqgImXz/DlUZewkwiyFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750788471; c=relaxed/simple;
	bh=o1/gkkZiq7Iqu53E5cn758GVnqXDIXQDFRm1K1BtVPs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Vfqw79Y+PHbScArPdUYjBns826uy6NQy1neIYY4klWSJBvO7umY1fXRoh5IgB462GgpJ60rGKByjxwTVubu+I5ydarDWanFGitYyBV6qFJWhzaa6HxSeA3ZoxqVn2Uk2iCgnNy66B/zn3CZ8lmq9HJVf/X1f01+mMkQgO03xpxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ez1mPUs5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA9FBC4CEF2;
	Tue, 24 Jun 2025 18:07:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750788471;
	bh=o1/gkkZiq7Iqu53E5cn758GVnqXDIXQDFRm1K1BtVPs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ez1mPUs5J6Gccrrb2uHP5+2/H8p5V1b3TA8Fil5YSnp1z3uki2fHvM23EKEeImUa0
	 Rtm8xEDTvm5RNjvMhHzlaJT+h/eRvqsTUzxuI0BblCDxrsIuTlGGOPRKc9In7XZV6j
	 qSTD1JG7MYyu6wuyy/w+kH8MdYGrrPQXkgfTq92TEXb5KjeH1YeNu5QKe+jwWmvJTS
	 f0DicH1vX3RT7hrn1l6AlwlaJJbXFm5t5WkxQ1D0KqMt1hVOLYm7Sh7ZY+DWIJBLqU
	 sZT3Qbgr7nzJhziYvFe5qLVcTa9YK5za81Q2/woVxNu9rcOJAv7k0Zm0AH1mzVxLml
	 cihZdYILGT29w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-doc@vger.kernel.org,
	linux-api@vger.kernel.org,
	workflows@vger.kernel.org,
	tools@kernel.org,
	Sasha Levin <sashal@kernel.org>
Subject: [RFC v2 07/22] eventpoll: add API specification for epoll_pwait2
Date: Tue, 24 Jun 2025 14:07:27 -0400
Message-Id: <20250624180742.5795-8-sashal@kernel.org>
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

Add kernel API specification for the epoll_pwait2() system call.

Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/eventpoll.c | 248 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 248 insertions(+)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 07477643b9380..438551d3e13fd 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -3492,6 +3492,254 @@ SYSCALL_DEFINE6(epoll_pwait, int, epfd, struct epoll_event __user *, events,
 			      sigmask, sigsetsize);
 }
 
+
+DEFINE_KERNEL_API_SPEC(sys_epoll_pwait2)
+	KAPI_DESCRIPTION("Wait for events on an epoll instance with nanosecond precision timeout")
+	KAPI_LONG_DESC("Similar to epoll_pwait(), but takes a timespec structure that allows "
+		       "nanosecond precision for the timeout value. This provides more accurate "
+		       "timeout control compared to the millisecond precision of epoll_pwait(). "
+		       "Like epoll_pwait(), it atomically sets a signal mask during the wait.")
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
+	KAPI_PARAM(3, "timeout", "const struct __kernel_timespec __user *", "Timeout with nanosecond precision")
+		KAPI_PARAM_FLAGS(KAPI_PARAM_IN | KAPI_PARAM_USER | KAPI_PARAM_OPTIONAL)
+		KAPI_PARAM_TYPE(KAPI_TYPE_USER_PTR)
+		KAPI_PARAM_SIZE(sizeof(struct __kernel_timespec))
+		KAPI_PARAM_CONSTRAINT_TYPE(KAPI_CONSTRAINT_NONE)
+		KAPI_PARAM_CONSTRAINT("NULL means block indefinitely, {0, 0} returns immediately, "
+			       "negative values are invalid")
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
+		   "The memory area pointed to by events, timeout, or sigmask is not accessible.")
+	KAPI_ERROR(2, -EINTR, "EINTR", "Call interrupted by signal handler",
+		   "The call was interrupted by a signal handler before any events "
+		   "became ready or the timeout expired.")
+	KAPI_ERROR(3, -EINVAL, "EINVAL", "Invalid parameters",
+		   "epfd is not an epoll file descriptor, maxevents is less than or equal to zero, "
+		   "sigsetsize is not equal to sizeof(sigset_t), or timeout values are invalid.")
+
+	.error_count = 4,
+	.param_count = 6,
+	.since_version = "5.11",
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
+			 "Blocks the calling thread until events, timeout, or signal")
+		KAPI_EFFECT_CONDITION("When timeout != NULL or timeout->tv_sec/tv_nsec != 0")
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
+	KAPI_SIDE_EFFECT(5, KAPI_EFFECT_MODIFY_STATE,
+			 "timer precision",
+			 "Timeout may be rounded up to system timer granularity")
+		KAPI_EFFECT_CONDITION("When timeout is specified")
+	KAPI_SIDE_EFFECT_END
+
+	KAPI_SIDE_EFFECT_COUNT(6)
+
+	/* State transitions */
+	KAPI_STATE_TRANS(0, "signal mask", "original mask", "user-specified mask",
+			 "Thread's signal mask is atomically changed to the provided mask")
+		KAPI_STATE_TRANS_COND("When sigmask is not NULL")
+	KAPI_STATE_TRANS_END
+
+	KAPI_STATE_TRANS(1, "process", "running", "blocked",
+			 "Process blocks waiting for events with specified signal mask")
+		KAPI_STATE_TRANS_COND("When no events available and not immediate return")
+	KAPI_STATE_TRANS_END
+
+	KAPI_STATE_TRANS(2, "process", "blocked", "running",
+			 "Process wakes up due to events, timeout expiry, or unblocked signal")
+		KAPI_STATE_TRANS_COND("When wait condition is satisfied")
+	KAPI_STATE_TRANS_END
+
+	KAPI_STATE_TRANS(3, "signal mask", "user-specified mask", "original mask",
+			 "Thread's signal mask is restored to its original value")
+		KAPI_STATE_TRANS_COND("When returning from epoll_pwait2")
+	KAPI_STATE_TRANS_END
+
+	KAPI_STATE_TRANS(4, "pending signals", "blocked", "deliverable",
+			 "Signals that were blocked by the temporary mask become deliverable")
+		KAPI_STATE_TRANS_COND("When signal mask is restored and signals were pending")
+	KAPI_STATE_TRANS_END
+
+	KAPI_STATE_TRANS(5, "timeout timer", "not started", "armed with nanosecond precision",
+			 "High resolution timer is armed with the specified timeout")
+		KAPI_STATE_TRANS_COND("When timeout is specified and > 0")
+	KAPI_STATE_TRANS_END
+
+	KAPI_STATE_TRANS_COUNT(6)
+
+	/* Signal specifications */
+	KAPI_SIGNAL(0, 0, "ANY_UNBLOCKED", KAPI_SIGNAL_RECEIVE, KAPI_SIGNAL_ACTION_RETURN)
+		KAPI_SIGNAL_CONDITION("Signal not blocked by provided sigmask")
+		KAPI_SIGNAL_DESC("Any signal not blocked by the sigmask parameter will interrupt "
+				 "epoll_pwait2() and cause it to return -EINTR. Signal handling is "
+				 "identical to epoll_pwait().")
+		KAPI_SIGNAL_RESTARTABLE
+	KAPI_SIGNAL_END
+
+	KAPI_SIGNAL(1, SIGKILL, "SIGKILL", KAPI_SIGNAL_RECEIVE, KAPI_SIGNAL_ACTION_TERMINATE)
+		KAPI_SIGNAL_CONDITION("Cannot be blocked by sigmask")
+		KAPI_SIGNAL_DESC("SIGKILL cannot be blocked and will terminate the process immediately.")
+	KAPI_SIGNAL_END
+
+	KAPI_SIGNAL(2, SIGSTOP, "SIGSTOP", KAPI_SIGNAL_RECEIVE, KAPI_SIGNAL_ACTION_STOP)
+		KAPI_SIGNAL_CONDITION("Cannot be blocked by sigmask")
+		KAPI_SIGNAL_DESC("SIGSTOP cannot be blocked and will stop the process.")
+	KAPI_SIGNAL_END
+
+	KAPI_SIGNAL(3, 0, "BLOCKED_SIGNALS", KAPI_SIGNAL_BLOCK, KAPI_SIGNAL_ACTION_DEFAULT)
+		KAPI_SIGNAL_CONDITION("Signals in provided sigmask")
+		KAPI_SIGNAL_DESC("Signals specified in the sigmask parameter are blocked during "
+				 "the epoll_pwait2 call.")
+	KAPI_SIGNAL_END
+
+	KAPI_SIGNAL(4, SIGCONT, "SIGCONT", KAPI_SIGNAL_RECEIVE, KAPI_SIGNAL_ACTION_CONTINUE)
+		KAPI_SIGNAL_CONDITION("When process is stopped")
+		KAPI_SIGNAL_DESC("SIGCONT resumes a stopped process. If epoll_pwait2 was interrupted "
+				 "by SIGSTOP, it may return -EINTR when continued.")
+	KAPI_SIGNAL_END
+
+	KAPI_SIGNAL(5, SIGALRM, "SIGALRM", KAPI_SIGNAL_RECEIVE, KAPI_SIGNAL_ACTION_RETURN)
+		KAPI_SIGNAL_CONDITION("Timer expiration")
+		KAPI_SIGNAL_DESC("SIGALRM or other timer signals will interrupt epoll_pwait2 with -EINTR "
+				 "if not blocked by sigmask")
+		KAPI_SIGNAL_RESTARTABLE
+	KAPI_SIGNAL_END
+
+	.signal_count = 6,
+
+	/* Signal mask specifications */
+	KAPI_SIGNAL_MASK(0, "user_sigmask", "User-provided signal mask atomically applied")
+		.description = "The signal mask is atomically set and restored exactly as in "
+			       "epoll_pwait(), providing the same race-condition prevention."
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
+		      "struct epoll_event events[10];\n"
+		      "struct __kernel_timespec ts;\n\n"
+		      "/* Block SIGINT during epoll_pwait2 */\n"
+		      "sigemptyset(&sigmask);\n"
+		      "sigaddset(&sigmask, SIGINT);\n\n"
+		      "/* Wait for 1.5 seconds */\n"
+		      "ts.tv_sec = 1;\n"
+		      "ts.tv_nsec = 500000000; /* 500 milliseconds */\n\n"
+		      "int nfds = epoll_pwait2(epfd, events, 10, &ts, &sigmask, sizeof(sigmask));\n"
+		      "if (nfds == -1) {\n"
+		      "    if (errno == EINTR) {\n"
+		      "        /* Handle signal */\n"
+		      "    }\n"
+		      "    perror(\"epoll_pwait2\");\n"
+		      "    exit(EXIT_FAILURE);\n"
+		      "}\n\n"
+		      "/* Example with infinite timeout */\n"
+		      "nfds = epoll_pwait2(epfd, events, 10, NULL, &sigmask, sizeof(sigmask));")
+	KAPI_NOTES("epoll_pwait2() provides nanosecond precision timeouts, addressing the limitation "
+		   "of epoll_pwait() which only supports millisecond precision. The timeout parameter "
+		   "uses struct __kernel_timespec which is compatible with 64-bit time values, making "
+		   "it Y2038-safe. Like epoll_pwait(), the signal mask operation is atomic. "
+		   "The timeout is still subject to system timer granularity and may be rounded up. "
+		   "Edge-triggered mode (EPOLLET) can cause starvation if not all available data is "
+		   "drained when an event is received. Always read/write until EAGAIN. "
+		   "When using dup() or fork(), events may be delivered to multiple epoll instances "
+		   "monitoring the same file descriptor.")
+KAPI_END_SPEC;
+
 SYSCALL_DEFINE6(epoll_pwait2, int, epfd, struct epoll_event __user *, events,
 		int, maxevents, const struct __kernel_timespec __user *, timeout,
 		const sigset_t __user *, sigmask, size_t, sigsetsize)
-- 
2.39.5



Return-Path: <linux-api+bounces-3910-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F5D6AD9D11
	for <lists+linux-api@lfdr.de>; Sat, 14 Jun 2025 15:49:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EC21179F8E
	for <lists+linux-api@lfdr.de>; Sat, 14 Jun 2025 13:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8E132E2EE7;
	Sat, 14 Jun 2025 13:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pyu9KU7O"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88BE2E1746;
	Sat, 14 Jun 2025 13:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749908945; cv=none; b=H5x3gdvKXauukYofvvgOh0JPKo8APHpoK3d43ozVHrvxe1iMpoHlP4w2FcpJY4EjVGioGnUzQ/1bE1qz6uR1hMFAsrGy/6idAFkxuH3TzlIQ06ePv5JlDCAwXJZwQ+v7lsLocLK4tbC/uY10Y3HyYcehGybRuN7sE1VELZ1m5Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749908945; c=relaxed/simple;
	bh=tsynXkXHj5iuDjiZyCfJZGrDQrbT0Giwhd4VvYtKm/I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Z9sZb4HmvMP1D5Jel1b3NzQn0z6lBIIjjHQnbuO3upLPBOvJ00y+NCJGW/tWC4s4ECroOU+nmptnyqyF5dT6tsHW/sW7BdIgUnsJgAXg4Q4NUGEjjC+tqj0b4Vfj4as7VGtdYydmrfMY03PFBwI51c+u6zyEcJLtJsYbeYMOOkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pyu9KU7O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02477C4CEF0;
	Sat, 14 Jun 2025 13:49:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749908945;
	bh=tsynXkXHj5iuDjiZyCfJZGrDQrbT0Giwhd4VvYtKm/I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Pyu9KU7Oto+SK0cKYRCB/J8DjUNW3hD8TdmpKb+lUDjhZXziQ+NodABgb0GLB/1G3
	 +X+2K8p3DXezqTCPyAPRCpk7mvHdB3L4rv9p3J0NFkWdtOdwpdgPHSEgdntBtyrqto
	 BiOcMdqUQrc84Y0fPLTvPpwzmEoKN0K+eKCmHcyDe9M76IPN0VRqMjdlTAg8SVtZBJ
	 sCRwOKUzsz0qAR0oP/ccJgsdl0fM88HPiw7q/O0ziHLKUxkqCpN9PYD7XcIBgQCkZJ
	 RI+uRVAxzHiBpJ/S4aQyKbbWMy8D9uRE03vURnb2GCBcK9i+GbszP6tM72RdklOLs0
	 04HS/sEcXyoUQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-api@vger.kernel.org,
	workflows@vger.kernel.org,
	tools@kernel.org,
	Sasha Levin <sashal@kernel.org>
Subject: [RFC 05/19] eventpoll: add API specification for epoll_wait
Date: Sat, 14 Jun 2025 09:48:44 -0400
Message-Id: <20250614134858.790460-6-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250614134858.790460-1-sashal@kernel.org>
References: <20250614134858.790460-1-sashal@kernel.org>
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
 fs/eventpoll.c | 182 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 182 insertions(+)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 409a0c440f112..254b50d687d37 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -2932,6 +2932,188 @@ static int do_epoll_wait(int epfd, struct epoll_event __user *events,
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
+		.type = KAPI_TYPE_FD,
+		.constraint_type = KAPI_CONSTRAINT_NONE,
+	KAPI_PARAM_END
+
+	KAPI_PARAM(1, "events", "struct epoll_event __user *", "Buffer where ready events will be stored")
+		KAPI_PARAM_FLAGS(KAPI_PARAM_OUT | KAPI_PARAM_USER)
+		.type = KAPI_TYPE_USER_PTR,
+		KAPI_PARAM_SIZE(sizeof(struct epoll_event))  /* Base size of single element */
+		.size_param_idx = 2,  /* Size determined by maxevents parameter */
+		.size_multiplier = sizeof(struct epoll_event),
+		.constraint_type = KAPI_CONSTRAINT_NONE,
+		.constraints = "Must point to an array of at least maxevents epoll_event structures",
+	KAPI_PARAM_END
+
+	KAPI_PARAM(2, "maxevents", "int", "Maximum number of events to return")
+		KAPI_PARAM_FLAGS(KAPI_PARAM_IN)
+		.type = KAPI_TYPE_INT,
+		KAPI_PARAM_RANGE(1, INT_MAX / sizeof(struct epoll_event))  /* EP_MAX_EVENTS */
+		.constraint_type = KAPI_CONSTRAINT_RANGE,
+		.constraints = "Must be greater than zero and not exceed system limits",
+	KAPI_PARAM_END
+
+	KAPI_PARAM(3, "timeout", "int", "Timeout in milliseconds")
+		KAPI_PARAM_FLAGS(KAPI_PARAM_IN)
+		.type = KAPI_TYPE_INT,
+		.constraint_type = KAPI_CONSTRAINT_NONE,
+		.constraints = "-1 blocks indefinitely, 0 returns immediately, >0 specifies milliseconds to wait",
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
+	.examples = "struct epoll_event events[10];\n"
+		    "int nfds = epoll_wait(epfd, events, 10, 1000);\n"
+		    "if (nfds == -1) {\n"
+		    "    perror(\"epoll_wait\");\n"
+		    "    exit(EXIT_FAILURE);\n"
+		    "}\n"
+		    "for (int n = 0; n < nfds; ++n) {\n"
+		    "    if (events[n].data.fd == listen_sock) {\n"
+		    "        accept_new_connection();\n"
+		    "    } else {\n"
+		    "        handle_io(events[n].data.fd);\n"
+		    "    }\n"
+		    "}",
+	.notes = "The timeout uses CLOCK_MONOTONIC and may be rounded up to system clock granularity. "
+		 "A timeout of -1 causes epoll_wait to block indefinitely, while a timeout of 0 "
+		 "causes it to return immediately even if no events are available. "
+		 "The struct epoll_event is defined as containing events (uint32_t) and data (epoll_data_t union).",
+KAPI_END_SPEC;
+
 SYSCALL_DEFINE4(epoll_wait, int, epfd, struct epoll_event __user *, events,
 		int, maxevents, int, timeout)
 {
-- 
2.39.5



Return-Path: <linux-api+bounces-3909-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F2D22AD9D12
	for <lists+linux-api@lfdr.de>; Sat, 14 Jun 2025 15:49:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86CD61892598
	for <lists+linux-api@lfdr.de>; Sat, 14 Jun 2025 13:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BB012E0B54;
	Sat, 14 Jun 2025 13:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dyhGK3LX"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 308912C327C;
	Sat, 14 Jun 2025 13:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749908945; cv=none; b=a+X/5G1HVvKErQbQLlkbvGhNQHwLpXOjVFEK7lRqJhVm2gY8rwCQqw4hgqA/cj1w7lzPX++OVUOZhSBXbUii9Ft6yK2XZzT/JtbKOpDFEr33GMFLFT2WvsIMeomGVhqLB7ZTpbrcd0ks9AzvzWq5aOphwztMiA1pRtH6/hSub/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749908945; c=relaxed/simple;
	bh=YYNIrR9iBWnDzlT+z7s/BKJnGkQz73iGzIzH0z/SgP8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LymzuS6OXCJsOact4JuHSq5mpWH644w3dQXGoaPw7DetuVuSRRHdWr3c1HAy0IrkKBrjTbPY8iucghe8Uzsb/EPTXesXdZcxez9K5GVp/c2cRPyFj08ynVkXK0BIkDBo5v81mEZWFs0t05y/2RcEXkGttbJfg4Ot2CGazMfuLw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dyhGK3LX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 179F9C4CEF1;
	Sat, 14 Jun 2025 13:49:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749908944;
	bh=YYNIrR9iBWnDzlT+z7s/BKJnGkQz73iGzIzH0z/SgP8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dyhGK3LXEKlmW+/QCjXj/Dp7aWAMGMhLWU8BBtPgtHXB8CapL1h6cliFu/Je/0kJ5
	 aQ2JpB3Gx4x0n3cI2H+flSwRIWwgNXfhbA8/jmZhAVEhrobeeaxNaFfW9lFnwrHsiB
	 w1muA4oTCLFpQhUjiHlSjVz9cFavjGNXWlCX8nRaPsByfAz08y0TBf+CsX0h9Choip
	 8zfALBWpGh4oqVzdYXRO9CS0+FShTQPEBOWpkIaZmtB5UTIfaSQPqZH3SCLj3aExX3
	 LHjc2G2J3sA96lm7cuSTelBpwzGw5v50kFzBlG/fxcmR0Hq3ipK4FrMfP4/wG76+OP
	 4ppKprzMm0uHw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-api@vger.kernel.org,
	workflows@vger.kernel.org,
	tools@kernel.org,
	Sasha Levin <sashal@kernel.org>
Subject: [RFC 04/19] eventpoll: add API specification for epoll_ctl
Date: Sat, 14 Jun 2025 09:48:43 -0400
Message-Id: <20250614134858.790460-5-sashal@kernel.org>
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

Add kernel API specification for the epoll_ctl() system call.

Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/eventpoll.c | 203 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 203 insertions(+)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 50adea7ba43d1..409a0c440f112 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -2647,6 +2647,209 @@ int do_epoll_ctl(int epfd, int op, int fd, struct epoll_event *epds,
  * the eventpoll file that enables the insertion/removal/change of
  * file descriptors inside the interest set.
  */
+
+/* Valid values for epoll_ctl op parameter */
+static const s64 epoll_ctl_valid_ops[] = {
+	EPOLL_CTL_ADD,
+	EPOLL_CTL_DEL,
+	EPOLL_CTL_MOD,
+};
+
+DEFINE_KERNEL_API_SPEC(sys_epoll_ctl)
+	KAPI_DESCRIPTION("Control interface for an epoll file descriptor")
+	KAPI_LONG_DESC("Performs control operations on the epoll instance referred to by epfd. "
+		       "It requests that the operation op be performed for the target file "
+		       "descriptor fd. Valid operations are adding, modifying, or deleting "
+		       "file descriptors from the interest set.")
+	KAPI_CONTEXT(KAPI_CTX_PROCESS | KAPI_CTX_SLEEPABLE)
+
+	KAPI_PARAM(0, "epfd", "int", "File descriptor referring to the epoll instance")
+		KAPI_PARAM_FLAGS(KAPI_PARAM_IN)
+		.type = KAPI_TYPE_FD,
+		.constraint_type = KAPI_CONSTRAINT_NONE,
+	KAPI_PARAM_END
+
+	KAPI_PARAM(1, "op", "int", "Operation to be performed")
+		KAPI_PARAM_FLAGS(KAPI_PARAM_IN)
+		.type = KAPI_TYPE_INT,
+		.constraint_type = KAPI_CONSTRAINT_ENUM,
+		.enum_values = epoll_ctl_valid_ops,
+		.enum_count = ARRAY_SIZE(epoll_ctl_valid_ops),
+		.constraints = "Must be EPOLL_CTL_ADD, EPOLL_CTL_DEL, or EPOLL_CTL_MOD",
+	KAPI_PARAM_END
+
+	KAPI_PARAM(2, "fd", "int", "File descriptor to be monitored")
+		KAPI_PARAM_FLAGS(KAPI_PARAM_IN)
+		.type = KAPI_TYPE_FD,
+		.constraint_type = KAPI_CONSTRAINT_NONE,
+		.constraints = "Must refer to a file that supports poll operations",
+	KAPI_PARAM_END
+
+	KAPI_PARAM(3, "event", "struct epoll_event __user *", "Settings for the file descriptor")
+		KAPI_PARAM_FLAGS(KAPI_PARAM_IN | KAPI_PARAM_USER | KAPI_PARAM_OPTIONAL)
+		.type = KAPI_TYPE_USER_PTR,
+		KAPI_PARAM_SIZE(sizeof(struct epoll_event))
+		.constraints = "Required for ADD and MOD operations, ignored for DEL",
+	KAPI_PARAM_END
+
+	KAPI_RETURN("long", "0 on success, negative error code on failure")
+		.type = KAPI_TYPE_INT,
+		.check_type = KAPI_RETURN_EXACT,
+		KAPI_RETURN_SUCCESS(0)
+	KAPI_RETURN_END
+
+	KAPI_ERROR(0, -EBADF, "EBADF", "epfd or fd is not a valid file descriptor",
+		   "One of the file descriptors is invalid or has been closed.")
+	KAPI_ERROR(1, -EEXIST, "EEXIST", "op is EPOLL_CTL_ADD and fd is already registered",
+		   "The file descriptor is already present in the epoll instance.")
+	KAPI_ERROR(2, -EINVAL, "EINVAL", "Invalid operation or parameters",
+		   "epfd is not an epoll file descriptor, epfd == fd, op is not valid, "
+		   "or EPOLLEXCLUSIVE was specified with invalid events.")
+	KAPI_ERROR(3, -ENOENT, "ENOENT", "op is EPOLL_CTL_MOD or EPOLL_CTL_DEL and fd is not registered",
+		   "The file descriptor is not registered with this epoll instance.")
+	KAPI_ERROR(4, -ENOMEM, "ENOMEM", "Insufficient kernel memory",
+		   "There was insufficient memory to handle the requested operation.")
+	KAPI_ERROR(5, -EPERM, "EPERM", "Target file does not support epoll",
+		   "The target file fd does not support poll operations.")
+	KAPI_ERROR(6, -ELOOP, "ELOOP", "Circular monitoring detected",
+		   "fd refers to an epoll instance and this operation would result "
+		   "in a circular loop of epoll instances monitoring one another.")
+	KAPI_ERROR(7, -EFAULT, "EFAULT", "event points outside accessible address space",
+		   "The memory area pointed to by event is not accessible with write permissions.")
+	KAPI_ERROR(8, -EAGAIN, "EAGAIN", "Nonblocking mode and lock not available",
+		   "The operation was called in nonblocking mode and could not acquire necessary locks.")
+	KAPI_ERROR(9, -ENOSPC, "ENOSPC", "User epoll watch limit exceeded",
+		   "The limit on the total number of epoll watches was exceeded. "
+		   "See /proc/sys/fs/epoll/max_user_watches.")
+	KAPI_ERROR(10, -EINTR, "EINTR", "Interrupted by signal",
+		   "The system call was interrupted by a signal before completion.")
+
+	.error_count = 11,
+	.param_count = 4,
+	.since_version = "2.6",
+
+	/* Locking specifications */
+	KAPI_LOCK(0, "ep->mtx", KAPI_LOCK_MUTEX)
+		KAPI_LOCK_ACQUIRED
+		KAPI_LOCK_RELEASED
+		KAPI_LOCK_DESC("Protects the epoll instance during control operations")
+	KAPI_LOCK_END
+
+	KAPI_LOCK(1, "epnested_mutex", KAPI_LOCK_MUTEX)
+		KAPI_LOCK_DESC("Global mutex to prevent circular epoll structures (acquired for nested epoll)")
+	KAPI_LOCK_END
+
+	.lock_count = 2,
+
+	/* Side effects */
+	KAPI_SIDE_EFFECT(0, KAPI_EFFECT_MODIFY_STATE | KAPI_EFFECT_ALLOC_MEMORY,
+			 "epoll interest list",
+			 "Adds new epitem structure to the epoll interest list")
+		KAPI_EFFECT_CONDITION("When op is EPOLL_CTL_ADD")
+		KAPI_EFFECT_REVERSIBLE
+	KAPI_SIDE_EFFECT_END
+
+	KAPI_SIDE_EFFECT(1, KAPI_EFFECT_MODIFY_STATE | KAPI_EFFECT_FREE_MEMORY,
+			 "epoll interest list",
+			 "Removes epitem structure from the epoll interest list")
+		KAPI_EFFECT_CONDITION("When op is EPOLL_CTL_DEL")
+		KAPI_EFFECT_REVERSIBLE
+	KAPI_SIDE_EFFECT_END
+
+	KAPI_SIDE_EFFECT(2, KAPI_EFFECT_MODIFY_STATE,
+			 "epoll event mask",
+			 "Modifies the event mask for an existing epitem")
+		KAPI_EFFECT_CONDITION("When op is EPOLL_CTL_MOD")
+		KAPI_EFFECT_REVERSIBLE
+	KAPI_SIDE_EFFECT_END
+
+	KAPI_SIDE_EFFECT(3, KAPI_EFFECT_MODIFY_STATE,
+			 "file reference count",
+			 "Increases reference count on the monitored file")
+		KAPI_EFFECT_CONDITION("When op is EPOLL_CTL_ADD")
+		KAPI_EFFECT_REVERSIBLE
+	KAPI_SIDE_EFFECT_END
+
+	KAPI_SIDE_EFFECT(4, KAPI_EFFECT_MODIFY_STATE,
+			 "file reference count",
+			 "Decreases reference count on the monitored file")
+		KAPI_EFFECT_CONDITION("When op is EPOLL_CTL_DEL")
+		KAPI_EFFECT_REVERSIBLE
+	KAPI_SIDE_EFFECT_END
+
+	KAPI_SIDE_EFFECT(5, KAPI_EFFECT_SCHEDULE,
+			 "process state",
+			 "May wake up processes waiting on the epoll instance if events become available")
+		KAPI_EFFECT_CONDITION("When adding or modifying entries that match current events")
+	KAPI_SIDE_EFFECT_END
+
+	KAPI_SIDE_EFFECT_COUNT(6)
+
+	/* State transitions */
+	KAPI_STATE_TRANS(0, "epoll entry", "non-existent", "monitored",
+			 "File descriptor is added to epoll interest list")
+		KAPI_STATE_TRANS_COND("When op is EPOLL_CTL_ADD")
+	KAPI_STATE_TRANS_END
+
+	KAPI_STATE_TRANS(1, "epoll entry", "monitored", "non-existent",
+			 "File descriptor is removed from epoll interest list")
+		KAPI_STATE_TRANS_COND("When op is EPOLL_CTL_DEL")
+	KAPI_STATE_TRANS_END
+
+	KAPI_STATE_TRANS(2, "epoll entry", "monitored with events A", "monitored with events B",
+			 "Event mask for file descriptor is modified")
+		KAPI_STATE_TRANS_COND("When op is EPOLL_CTL_MOD")
+	KAPI_STATE_TRANS_END
+
+	KAPI_STATE_TRANS(3, "epoll ready list", "empty or partial", "contains new events",
+			 "Ready list may be updated if new/modified entry has pending events")
+		KAPI_STATE_TRANS_COND("When monitored fd has events matching the mask")
+	KAPI_STATE_TRANS_END
+
+	KAPI_STATE_TRANS_COUNT(4)
+
+	/* Signal specifications */
+	KAPI_SIGNAL(0, SIGINT, "SIGINT", KAPI_SIGNAL_RECEIVE, KAPI_SIGNAL_ACTION_RETURN)
+		KAPI_SIGNAL_CONDITION("During mutex acquisition or memory allocation")
+		KAPI_SIGNAL_DESC("Returns -EINTR if interrupted before completing the operation")
+		KAPI_SIGNAL_RESTARTABLE
+	KAPI_SIGNAL_END
+
+	KAPI_SIGNAL(1, SIGTERM, "SIGTERM", KAPI_SIGNAL_RECEIVE, KAPI_SIGNAL_ACTION_RETURN)
+		KAPI_SIGNAL_CONDITION("During mutex acquisition or memory allocation")
+		KAPI_SIGNAL_DESC("Returns -EINTR if interrupted before completing the operation")
+		KAPI_SIGNAL_RESTARTABLE
+	KAPI_SIGNAL_END
+
+	KAPI_SIGNAL(2, SIGKILL, "SIGKILL", KAPI_SIGNAL_RECEIVE, KAPI_SIGNAL_ACTION_TERMINATE)
+		KAPI_SIGNAL_CONDITION("At any point during the syscall")
+		KAPI_SIGNAL_DESC("Process is terminated immediately, operation may be partially completed")
+	KAPI_SIGNAL_END
+
+	KAPI_SIGNAL(3, SIGHUP, "SIGHUP", KAPI_SIGNAL_RECEIVE, KAPI_SIGNAL_ACTION_RETURN)
+		KAPI_SIGNAL_CONDITION("During blocking operations")
+		KAPI_SIGNAL_DESC("Returns -EINTR if terminal hangup occurs")
+		KAPI_SIGNAL_RESTARTABLE
+	KAPI_SIGNAL_END
+
+	KAPI_SIGNAL(4, SIGURG, "SIGURG", KAPI_SIGNAL_IGNORE, KAPI_SIGNAL_ACTION_DEFAULT)
+		KAPI_SIGNAL_CONDITION("May be generated by monitored sockets")
+		KAPI_SIGNAL_DESC("Urgent data signals from monitored sockets do not affect epoll_ctl")
+	KAPI_SIGNAL_END
+
+	.signal_count = 5,
+
+	.examples = "struct epoll_event ev;\n"
+		    "ev.events = EPOLLIN | EPOLLOUT;\n"
+		    "ev.data.fd = fd;\n"
+		    "if (epoll_ctl(epfd, EPOLL_CTL_ADD, fd, &ev) == -1)\n"
+		    "    handle_error();\n",
+	.notes = "EPOLL_CTL_DEL ignores the event parameter (can be NULL). "
+		 "EPOLLEXCLUSIVE flag has restrictions and cannot be used with EPOLL_CTL_MOD. "
+		 "The epoll instance maintains a reference to registered files until they are "
+		 "explicitly removed with EPOLL_CTL_DEL or the epoll instance is closed.",
+KAPI_END_SPEC;
+
 SYSCALL_DEFINE4(epoll_ctl, int, epfd, int, op, int, fd,
 		struct epoll_event __user *, event)
 {
-- 
2.39.5



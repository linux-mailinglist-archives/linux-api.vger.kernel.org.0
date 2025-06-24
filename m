Return-Path: <linux-api+bounces-3964-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC3AFAE6E1F
	for <lists+linux-api@lfdr.de>; Tue, 24 Jun 2025 20:08:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF5151671D5
	for <lists+linux-api@lfdr.de>; Tue, 24 Jun 2025 18:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 894D42E7629;
	Tue, 24 Jun 2025 18:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sJZlsbi8"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 574672E7181;
	Tue, 24 Jun 2025 18:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750788469; cv=none; b=bQaIIZl0uj+nbCmzWM+RwpNjCz2oBhodz59fsse0jymtf5rVmVDxrxZCAZlNTXE6y66IGWoA9ubx67XBVsWXJ/oblhmNlhXoleBnl/9YmMX6auO6/YQyW3lipco1AtgrxUuC7BF1NNt3OPg3WyZT+7YHWDmzDU3MYAIVQrUBIS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750788469; c=relaxed/simple;
	bh=UVxI8xEl8ZwckK3wSexDZDRtNX2KabMv5Wcfa7+XhMk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=phl0LlF0LO9D2zWh85xhkOwqv30HhuFoP3lUEgvu8UCAPioobrQJ4DZ+GQJSdw5sLvmtUHUQbGRqL7wV4TJEnuZX0UH7a6EuPqzEUbYDJssodbzydhS/t744TIvuMCh2uW4F2Pjfd+CVkwdmTuDhth3EGJzRY64bP/kLSsUMIDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sJZlsbi8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DF97C4CEEF;
	Tue, 24 Jun 2025 18:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750788469;
	bh=UVxI8xEl8ZwckK3wSexDZDRtNX2KabMv5Wcfa7+XhMk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sJZlsbi8yZU96//ZuWwDBkynlJlVDyrmApYvYl7qoC5cGgkQtCIiyyTCEhxmn9MCf
	 pR5QZaF96CZEbKTUqo9F71DyuUDaC/gsrhL2XzQUl82VBtNdPT3WMRZxAtH7HbRB75
	 GF4rlQmOniRkwzwRKlu9W9T/1PS831rZC2OjFy0h/ENn07AuERWtx65CagOG2Rdctp
	 QjSL2VLysmmZwZn6WU2v8abrjyM+0OSdX41bu7fnFY4NpUJVByL2VLfHj9SWH0rdr2
	 OUHZrA/JoftdvunEA7r+rsVKiaezUr/afRwWL80MHpmkwvAqwxoXM0UlFqQsdBSrWg
	 W/xaRj47we05w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-doc@vger.kernel.org,
	linux-api@vger.kernel.org,
	workflows@vger.kernel.org,
	tools@kernel.org,
	Sasha Levin <sashal@kernel.org>
Subject: [RFC v2 03/22] eventpoll: add API specification for epoll_create
Date: Tue, 24 Jun 2025 14:07:23 -0400
Message-Id: <20250624180742.5795-4-sashal@kernel.org>
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

Add kernel API specification for the epoll_create() system call.

Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/eventpoll.c                  | 122 +++++++++++++++++++++++++++++++-
 include/linux/kernel_api_spec.h |  13 ++++
 2 files changed, 132 insertions(+), 3 deletions(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 620de3ccc7708..c3c16f8e6ac7d 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -2300,8 +2300,8 @@ DEFINE_KERNEL_API_SPEC(sys_epoll_create1)
 	KAPI_ERROR(4, -EINTR, "EINTR", "Interrupted by signal",
 		   "The system call was interrupted by a signal before the epoll instance could be created.")
 
-	.error_count = 5,
-	.param_count = 1,
+	KAPI_ERROR_COUNT(5)
+	KAPI_PARAM_COUNT(1)
 	.since_version = "2.6.27",
 	KAPI_EXAMPLES("int epfd = epoll_create1(EPOLL_CLOEXEC);")
 	KAPI_NOTES("EPOLL_CLOEXEC sets the close-on-exec (FD_CLOEXEC) flag on the new file descriptor. "
@@ -2366,7 +2366,7 @@ DEFINE_KERNEL_API_SPEC(sys_epoll_create1)
 		KAPI_SIGNAL_QUEUE("uncatchable")
 	KAPI_SIGNAL_END
 
-	.signal_count = 3,
+	KAPI_SIGNAL_COUNT(3)
 
 	/* Additional constraints */
 	KAPI_CONSTRAINT(0, "User Watch Limit",
@@ -2394,6 +2394,122 @@ SYSCALL_DEFINE1(epoll_create1, int, flags)
 	return do_epoll_create(flags);
 }
 
+
+DEFINE_KERNEL_API_SPEC(sys_epoll_create)
+	KAPI_DESCRIPTION("Create an epoll instance (obsolete)")
+	KAPI_LONG_DESC("Creates a new epoll instance and returns a file descriptor "
+		       "referring to that instance. This is the obsolete interface; "
+		       "new applications should use epoll_create1() instead.")
+	KAPI_CONTEXT(KAPI_CTX_PROCESS | KAPI_CTX_SLEEPABLE)
+
+	KAPI_PARAM(0, "size", "int", "Ignored hint about expected number of file descriptors")
+		KAPI_PARAM_FLAGS(KAPI_PARAM_IN)
+		KAPI_PARAM_RANGE(1, INT_MAX)
+		KAPI_PARAM_CONSTRAINT_TYPE(KAPI_CONSTRAINT_RANGE)
+		KAPI_PARAM_CONSTRAINT("Must be greater than zero (ignored since Linux 2.6.8)")
+	KAPI_PARAM_END
+
+	KAPI_RETURN("long", "File descriptor on success, negative error code on failure")
+		KAPI_RETURN_TYPE(KAPI_TYPE_INT)
+		KAPI_RETURN_CHECK_TYPE(KAPI_RETURN_FD)
+	KAPI_RETURN_END
+
+	KAPI_ERROR(0, -EINVAL, "EINVAL", "size <= 0",
+		   "The size parameter must be greater than zero.")
+	KAPI_ERROR(1, -EMFILE, "EMFILE", "Per-process file descriptor limit reached",
+		   "The per-process limit on the number of open file descriptors has been reached.")
+	KAPI_ERROR(2, -ENFILE, "ENFILE", "System file table overflow",
+		   "The system-wide limit on the total number of open files has been reached.")
+	KAPI_ERROR(3, -ENOMEM, "ENOMEM", "Insufficient kernel memory",
+		   "There was insufficient kernel memory to create the epoll instance.")
+	KAPI_ERROR(4, -EINTR, "EINTR", "Interrupted by signal",
+		   "The system call was interrupted by a signal before the epoll instance could be created.")
+
+	KAPI_ERROR_COUNT(5)
+	KAPI_PARAM_COUNT(1)
+	KAPI_SINCE_VERSION("2.6")
+	KAPI_DEPRECATED
+	KAPI_REPLACEMENT("epoll_create1")
+	KAPI_EXAMPLES("int epfd = epoll_create(1024); // size is ignored since Linux 2.6.8")
+	KAPI_NOTES("Since Linux 2.6.8, the size argument is ignored but must be greater than zero. "
+		   "The kernel dynamically sizes the data structures as needed. "
+		   "For new applications, epoll_create1() should be preferred as it allows "
+		   "setting close-on-exec flag atomically. "
+		   "Memory consumption: Each registered fd uses approximately 90 bytes on 32-bit kernels "
+		   "and 160 bytes on 64-bit kernels. The total number of file descriptors registered "
+		   "across all epoll instances is limited by /proc/sys/fs/epoll/max_user_watches. "
+		   "When using dup() or fork(), multiple file descriptors may refer to the same epoll "
+		   "instance and all will receive events.")
+
+	/* Side effects */
+	KAPI_SIDE_EFFECT(0, KAPI_EFFECT_RESOURCE_CREATE | KAPI_EFFECT_ALLOC_MEMORY,
+			 "epoll instance",
+			 "Creates a new epoll instance and allocates kernel memory for it")
+		KAPI_EFFECT_CONDITION("Always when successful")
+		KAPI_EFFECT_REVERSIBLE
+	KAPI_SIDE_EFFECT_END
+
+	KAPI_SIDE_EFFECT(1, KAPI_EFFECT_RESOURCE_CREATE,
+			 "file descriptor",
+			 "Allocates a new file descriptor in the process's file descriptor table")
+		KAPI_EFFECT_CONDITION("Always when successful")
+		KAPI_EFFECT_REVERSIBLE
+	KAPI_SIDE_EFFECT_END
+
+	KAPI_SIDE_EFFECT(2, KAPI_EFFECT_MODIFY_STATE,
+			 "kernel file table",
+			 "Adds new file structure to system-wide file table")
+		KAPI_EFFECT_CONDITION("Always when successful")
+		KAPI_EFFECT_REVERSIBLE
+	KAPI_SIDE_EFFECT_END
+
+	KAPI_SIDE_EFFECT_COUNT(3)
+
+	/* State transitions */
+	KAPI_STATE_TRANS(0, "epoll instance", "non-existent", "created and empty",
+			 "A new epoll instance is created with no monitored file descriptors")
+		KAPI_STATE_TRANS_COND("On successful creation")
+	KAPI_STATE_TRANS_END
+
+	KAPI_STATE_TRANS(1, "file descriptor", "unallocated", "allocated and open",
+			 "A new file descriptor is allocated in the process's fd table")
+		KAPI_STATE_TRANS_COND("On successful creation")
+	KAPI_STATE_TRANS_END
+
+	KAPI_STATE_TRANS_COUNT(2)
+
+	/* Signal specifications */
+	KAPI_SIGNAL(0, SIGINT, "SIGINT", KAPI_SIGNAL_RECEIVE, KAPI_SIGNAL_ACTION_RETURN)
+		KAPI_SIGNAL_CONDITION("During kernel memory allocation")
+		KAPI_SIGNAL_DESC("If interrupted during memory allocation or fd allocation, returns -EINTR")
+		KAPI_SIGNAL_RESTARTABLE
+	KAPI_SIGNAL_END
+
+	KAPI_SIGNAL(1, SIGTERM, "SIGTERM", KAPI_SIGNAL_RECEIVE, KAPI_SIGNAL_ACTION_RETURN)
+		KAPI_SIGNAL_CONDITION("During kernel memory allocation")
+		KAPI_SIGNAL_DESC("If interrupted during memory allocation or fd allocation, returns -EINTR")
+		KAPI_SIGNAL_RESTARTABLE
+	KAPI_SIGNAL_END
+
+	KAPI_SIGNAL(2, SIGKILL, "SIGKILL", KAPI_SIGNAL_RECEIVE, KAPI_SIGNAL_ACTION_TERMINATE)
+		KAPI_SIGNAL_CONDITION("At any point during the syscall")
+		KAPI_SIGNAL_DESC("Process is terminated immediately, epoll instance creation may be incomplete")
+	KAPI_SIGNAL_END
+
+	KAPI_SIGNAL(3, SIGHUP, "SIGHUP", KAPI_SIGNAL_RECEIVE, KAPI_SIGNAL_ACTION_RETURN)
+		KAPI_SIGNAL_CONDITION("During kernel operations")
+		KAPI_SIGNAL_DESC("If process is being terminated due to terminal hangup, may return -EINTR")
+		KAPI_SIGNAL_RESTARTABLE
+	KAPI_SIGNAL_END
+
+	KAPI_SIGNAL(4, SIGPIPE, "SIGPIPE", KAPI_SIGNAL_IGNORE, KAPI_SIGNAL_ACTION_DEFAULT)
+		KAPI_SIGNAL_CONDITION("Never generated by epoll_create")
+		KAPI_SIGNAL_DESC("This signal is not relevant to epoll_create as it doesn't involve pipes")
+	KAPI_SIGNAL_END
+
+	KAPI_SIGNAL_COUNT(5)
+KAPI_END_SPEC;
+
 SYSCALL_DEFINE1(epoll_create, int, size)
 {
 	if (size <= 0)
diff --git a/include/linux/kernel_api_spec.h b/include/linux/kernel_api_spec.h
index d8439d411f41e..1ee76a5f3ee1f 100644
--- a/include/linux/kernel_api_spec.h
+++ b/include/linux/kernel_api_spec.h
@@ -963,6 +963,19 @@ struct kernel_api_spec {
 #define KAPI_NOTES(n) \
 	.notes = n,
 
+/**
+ * KAPI_DEPRECATED - Mark API as deprecated
+ */
+#define KAPI_DEPRECATED \
+	.deprecated = true,
+
+/**
+ * KAPI_REPLACEMENT - Set replacement API for deprecated function
+ * @repl: Replacement API name
+ */
+#define KAPI_REPLACEMENT(repl) \
+	.replacement = repl,
+
 /**
  * KAPI_SIGNAL - Define a signal specification
  * @idx: Signal index
-- 
2.39.5



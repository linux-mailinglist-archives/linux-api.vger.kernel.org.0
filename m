Return-Path: <linux-api+bounces-3908-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E8A2DAD9D0E
	for <lists+linux-api@lfdr.de>; Sat, 14 Jun 2025 15:49:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C2D9170B8F
	for <lists+linux-api@lfdr.de>; Sat, 14 Jun 2025 13:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62AFB2DA75C;
	Sat, 14 Jun 2025 13:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qzO2PTLh"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D6D2DA74C;
	Sat, 14 Jun 2025 13:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749908944; cv=none; b=oUIt4tIfcdFUleaL7eim1MEmT2GKn0fuIwVxmhil4gZG0c37Zpg6GVjk4HYn+xzEaq0/i2I/LNtpY4uvW/QKMnCmvNM7M/H3vy3djjx3KOw/5+qGOkvbK0gJEQXtS712JPgQLDsVLZLMD2bWUG+5ikMOHZ1xK7FkB46IzSnkrmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749908944; c=relaxed/simple;
	bh=iQT/MtoEuRsG20rli2jzMl+0g6mMlRhX4GeT2c666kA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WS+9PhT1SQF2HVnV83Jdx7NhXhnYmf9dvtUwS5Hu2EeRx9igRfvKkeoPJioZc857dKh9irlmmYl9kOQROD7VEu0I0lE+EjK5WWefIzfHXhspB708jishGhkY998NqEGJk8uFeF6vJB7Kj+XzJOI7qzVnDGuhhZmujKGMpS3Z9WE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qzO2PTLh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A9B9C4CEF3;
	Sat, 14 Jun 2025 13:49:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749908943;
	bh=iQT/MtoEuRsG20rli2jzMl+0g6mMlRhX4GeT2c666kA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qzO2PTLhMew6aDwiLgpRNDF/86BmzgQ7bBAGLq/+UaBs5mIdamXZb1oDs2v96CeK9
	 AK4eD7PoHwqa06wof91oVx97OtCpsuHpLNptWiwVYimYH0lvN/L8Dq6TGibA+VHnth
	 VIqbqCC2qkzpNXcOotfV7ghrnH6rdvegckExmzmmI1rrY34+UHebYxA6vibWYpICjr
	 DussrWk4cuWyuKvhhvUg64Qk99jA8Z674D+Sl130WYzJTS5E12cE0JFNirevyQAx3e
	 eiLbnF91V22Ghb9qGneDU3VFvft+YJQTUOvZ/xF11FCS3OoxjoVoJpW773/33PbbAZ
	 pywPzMWXyjk0A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-api@vger.kernel.org,
	workflows@vger.kernel.org,
	tools@kernel.org,
	Sasha Levin <sashal@kernel.org>
Subject: [RFC 03/19] eventpoll: add API specification for epoll_create
Date: Sat, 14 Jun 2025 09:48:42 -0400
Message-Id: <20250614134858.790460-4-sashal@kernel.org>
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

Add kernel API specification for the epoll_create() system call.

Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/eventpoll.c | 111 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 111 insertions(+)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 8f8a64ebbaef6..50adea7ba43d1 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -2356,6 +2356,117 @@ SYSCALL_DEFINE1(epoll_create1, int, flags)
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
+		.constraint_type = KAPI_CONSTRAINT_RANGE,
+		.constraints = "Must be greater than zero (ignored since Linux 2.6.8)",
+	KAPI_PARAM_END
+
+	KAPI_RETURN("long", "File descriptor on success, negative error code on failure")
+		.type = KAPI_TYPE_INT,
+		.check_type = KAPI_RETURN_FD,
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
+	.error_count = 5,
+	.param_count = 1,
+	.since_version = "2.6",
+	.deprecated = true,
+	.replacement = "epoll_create1",
+	.examples = "int epfd = epoll_create(1024); // size is ignored since Linux 2.6.8",
+	.notes = "Since Linux 2.6.8, the size argument is ignored but must be greater than zero. "
+		 "The kernel dynamically sizes the data structures as needed. "
+		 "For new applications, epoll_create1() should be preferred as it allows "
+		 "setting close-on-exec flag atomically.",
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
+	.signal_count = 5,
+KAPI_END_SPEC;
+
 SYSCALL_DEFINE1(epoll_create, int, size)
 {
 	if (size <= 0)
-- 
2.39.5



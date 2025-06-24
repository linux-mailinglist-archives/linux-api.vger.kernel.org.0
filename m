Return-Path: <linux-api+bounces-3963-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3F40AE6E16
	for <lists+linux-api@lfdr.de>; Tue, 24 Jun 2025 20:08:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7E7C3AE75A
	for <lists+linux-api@lfdr.de>; Tue, 24 Jun 2025 18:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA4662E6D2C;
	Tue, 24 Jun 2025 18:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FGBIP0xJ"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B991D2E6D20;
	Tue, 24 Jun 2025 18:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750788468; cv=none; b=CCrKPAZLpNvj/BoM0tLLtOBl0z7w6esxp5r68sbArH+rgsyZfoZ0uVAayFqAycFjBxP1+1MK/uyq/jNmFPhVZmi6S88ED2q5++kFskW9ItJv7kDlQh0oSHIX8QrPSFY77DIi0hhalDWzmm2d7XCFzPoohydFqxZN6MwpWjA1N7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750788468; c=relaxed/simple;
	bh=d4SjjNQ6q0CfCPzNYhNUSMolfhOF2vMo6a66bvc1LvM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aoB4jMayNFibMi4XKk7Ml3XU/eNVMtd/ikA1Nde44kb6xnhStSjL2i5G5LCw72rxO7OgqOBrmGWgrTR1et+x3iWzXNUkSF0+77zk8igCEKOxLDegmJ5vQvBeRWgzZQMjNyIAwj9Lx9IO9HHbrQBjDiGIzD8jVLHOlG+qXh9njAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FGBIP0xJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06E80C116C6;
	Tue, 24 Jun 2025 18:07:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750788468;
	bh=d4SjjNQ6q0CfCPzNYhNUSMolfhOF2vMo6a66bvc1LvM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FGBIP0xJxRCM7VE/paPWgYsA47X/+9cWRaM1wQkHS8cDWpfRn/twKAKMi1wF6Js5u
	 zXZZuAl32RimUPcAyrqE3l0zTzvv5UoeEl3RPtWoDPeXdZFjsn+di+K1DZHJve9G91
	 q/dlaavPFH5xdZmCQodYQhJkdsV10QkdxTCLPkk16F8qnxladG0LhXblF2/crQWAG0
	 9No8v0dTRYQUcY5Pz9EC8pMT7igpyd8+evUcI5dHjye8pFaiHfjUWggbDB5cTdp7JJ
	 x4Os6zb8HlaQkA3axGwQPOy5FOTrwndOOyqZJnk/LYNZ6sH7YioOZTnfJ/H1zgCqkS
	 apLEfIXp0L15g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-doc@vger.kernel.org,
	linux-api@vger.kernel.org,
	workflows@vger.kernel.org,
	tools@kernel.org,
	Sasha Levin <sashal@kernel.org>
Subject: [RFC v2 02/22] eventpoll: add API specification for epoll_create1
Date: Tue, 24 Jun 2025 14:07:22 -0400
Message-Id: <20250624180742.5795-3-sashal@kernel.org>
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

Add kernel API specification for the epoll_create1() system call.

Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/eventpoll.c | 124 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 124 insertions(+)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index d4dbffdedd08e..620de3ccc7708 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -21,6 +21,7 @@
 #include <linux/hash.h>
 #include <linux/spinlock.h>
 #include <linux/syscalls.h>
+#include <linux/syscall_api_spec.h>
 #include <linux/rbtree.h>
 #include <linux/wait.h>
 #include <linux/eventpoll.h>
@@ -2265,6 +2266,129 @@ static int do_epoll_create(int flags)
 	return error;
 }
 
+
+/* Valid values for epoll_create1 flags parameter */
+static const s64 epoll_create1_valid_values[] = { 0, EPOLL_CLOEXEC };
+
+DEFINE_KERNEL_API_SPEC(sys_epoll_create1)
+	KAPI_DESCRIPTION("Create an epoll instance")
+	KAPI_LONG_DESC("Creates a new epoll instance and returns a file descriptor "
+		       "referring to that instance. The file descriptor is used for all "
+		       "subsequent calls to the epoll interface.")
+	KAPI_CONTEXT(KAPI_CTX_PROCESS | KAPI_CTX_SLEEPABLE)
+
+	KAPI_PARAM(0, "flags", "int", "Creation flags for the epoll instance")
+		KAPI_PARAM_FLAGS(KAPI_PARAM_IN)
+		KAPI_PARAM_CONSTRAINT_TYPE(KAPI_CONSTRAINT_ENUM)
+		KAPI_PARAM_ENUM_VALUES(epoll_create1_valid_values)
+		KAPI_PARAM_CONSTRAINT("Must be 0 or EPOLL_CLOEXEC")
+	KAPI_PARAM_END
+
+	KAPI_RETURN("long", "File descriptor on success, negative error code on failure")
+		KAPI_RETURN_TYPE(KAPI_TYPE_INT)
+		KAPI_RETURN_CHECK_TYPE(KAPI_RETURN_FD)
+	KAPI_RETURN_END
+
+	KAPI_ERROR(0, -EINVAL, "EINVAL", "Invalid flags specified",
+		   "The flags parameter contains invalid values. Only EPOLL_CLOEXEC is allowed.")
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
+	.since_version = "2.6.27",
+	KAPI_EXAMPLES("int epfd = epoll_create1(EPOLL_CLOEXEC);")
+	KAPI_NOTES("EPOLL_CLOEXEC sets the close-on-exec (FD_CLOEXEC) flag on the new file descriptor. "
+		   "When all file descriptors referring to an epoll instance are closed, the kernel "
+		   "destroys the instance and releases associated resources. "
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
+		KAPI_EFFECT_REVERSIBLE
+	KAPI_SIDE_EFFECT_END
+
+	KAPI_SIDE_EFFECT(1, KAPI_EFFECT_RESOURCE_CREATE,
+			 "file descriptor",
+			 "Allocates a new file descriptor in the process's file descriptor table")
+		KAPI_EFFECT_REVERSIBLE
+	KAPI_SIDE_EFFECT_END
+
+	KAPI_SIDE_EFFECT_COUNT(2)
+
+	/* State transitions */
+	KAPI_STATE_TRANS(0, "epoll instance", "non-existent", "created and empty",
+			 "A new epoll instance is created with no monitored file descriptors")
+	KAPI_STATE_TRANS_END
+
+	KAPI_STATE_TRANS_COUNT(1)
+
+	/* Signal specifications */
+	KAPI_SIGNAL(0, SIGINT, "SIGINT", KAPI_SIGNAL_RECEIVE, KAPI_SIGNAL_ACTION_RETURN)
+		KAPI_SIGNAL_CONDITION("During creation if process receives SIGINT")
+		KAPI_SIGNAL_DESC("If interrupted during kernel memory allocation, returns -EINTR")
+		KAPI_SIGNAL_TIMING(KAPI_SIGNAL_TIME_DURING)
+		KAPI_SIGNAL_PRIORITY(1)
+		KAPI_SIGNAL_INTERRUPTIBLE
+		KAPI_SIGNAL_ERROR(-EINTR)
+		KAPI_SIGNAL_STATE_REQ(KAPI_SIGNAL_STATE_RUNNING | KAPI_SIGNAL_STATE_SLEEPING)
+		KAPI_SIGNAL_RESTARTABLE
+	KAPI_SIGNAL_END
+
+	KAPI_SIGNAL(1, SIGTERM, "SIGTERM", KAPI_SIGNAL_RECEIVE, KAPI_SIGNAL_ACTION_RETURN)
+		KAPI_SIGNAL_CONDITION("During creation if process receives SIGTERM")
+		KAPI_SIGNAL_DESC("If interrupted during kernel memory allocation, returns -EINTR")
+		KAPI_SIGNAL_TIMING(KAPI_SIGNAL_TIME_DURING)
+		KAPI_SIGNAL_PRIORITY(1)
+		KAPI_SIGNAL_INTERRUPTIBLE
+		KAPI_SIGNAL_ERROR(-EINTR)
+		KAPI_SIGNAL_STATE_REQ(KAPI_SIGNAL_STATE_RUNNING | KAPI_SIGNAL_STATE_SLEEPING)
+		KAPI_SIGNAL_RESTARTABLE
+	KAPI_SIGNAL_END
+
+	KAPI_SIGNAL(2, SIGKILL, "SIGKILL", KAPI_SIGNAL_RECEIVE, KAPI_SIGNAL_ACTION_TERMINATE)
+		KAPI_SIGNAL_CONDITION("At any point during the syscall")
+		KAPI_SIGNAL_DESC("Process is terminated immediately, epoll instance creation may be incomplete")
+		KAPI_SIGNAL_TIMING(KAPI_SIGNAL_TIME_ANYTIME)
+		KAPI_SIGNAL_PRIORITY(0)
+		KAPI_SIGNAL_QUEUE("uncatchable")
+	KAPI_SIGNAL_END
+
+	.signal_count = 3,
+
+	/* Additional constraints */
+	KAPI_CONSTRAINT(0, "User Watch Limit",
+			"Although epoll_create1() itself doesn't register any watches, the "
+			"user is subject to a global limit on total watches across all epoll "
+			"instances. This limit is configured via /proc/sys/fs/epoll/max_user_watches "
+			"(default: 1/25 of lowmem or 1/32 of total memory). Each registered "
+			"file descriptor counts against this limit.")
+		KAPI_CONSTRAINT_EXPR("current_user_watches < max_user_watches")
+	KAPI_CONSTRAINT_END
+
+	KAPI_CONSTRAINT(1, "Memory Accounting",
+			"Each epoll instance consumes kernel memory that is not swappable. "
+			"The instance itself uses approximately 1KB, plus additional memory "
+			"for each registered file descriptor (90 bytes on 32-bit, 160 bytes "
+			"on 64-bit systems). This memory is charged to the user's locked "
+			"memory limit if memory cgroups are enabled.")
+	KAPI_CONSTRAINT_END
+
+	KAPI_CONSTRAINT_COUNT(2)
+
+KAPI_END_SPEC;
 SYSCALL_DEFINE1(epoll_create1, int, flags)
 {
 	return do_epoll_create(flags);
-- 
2.39.5



Return-Path: <linux-api+bounces-3907-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2113AD9D0D
	for <lists+linux-api@lfdr.de>; Sat, 14 Jun 2025 15:49:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 478427A5440
	for <lists+linux-api@lfdr.de>; Sat, 14 Jun 2025 13:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A1BA2D9EEB;
	Sat, 14 Jun 2025 13:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CmZVLvre"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E4A22D9EE5;
	Sat, 14 Jun 2025 13:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749908943; cv=none; b=m3XCahc44k1rPJb5xuqf1+HgW2EYABKI3Ksrx/D+HgoszFoQlX7aTOGYuJOv6w3RWT3qC/utnrD7phfEhjZanWNA/NU8hk+7ezN8PtbFj5nmfmkVsAfsifv6Pq/LGeOLYA5iBpiDswvFukwOTUm5X9quy9KsZyCk205r/dqttBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749908943; c=relaxed/simple;
	bh=BUrldnQPJ42xUrag3Jg1xnpVhRl3Q67bMpKOc+Wgtbs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fkB6StdTLki959HlSXVChaFoPTgf8nFtfEgengSUoVLMon0plMQ2oA7t+rsGR5II4ZPxj0CXy1qTPu1zXiHk7sz5ZZFrKb2TwyhiCDUthRR56d4NHTKhl+TIYFHmRxdnCx865IA23/58PxtHmXQuOgmC7h0kVQoQMy5FDQmgPd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CmZVLvre; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40041C4CEF0;
	Sat, 14 Jun 2025 13:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749908942;
	bh=BUrldnQPJ42xUrag3Jg1xnpVhRl3Q67bMpKOc+Wgtbs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CmZVLvreLZ7ZPfep9/dudxMmrWK4WXhVHYZNeVNro1rbdVt+FztARkn49hP8NU1Ri
	 7nKa+pBUDdJnOvnv40X48Y6ekIvf3YKIsMHz33MH5WwaU6x1yDLpB2DZLE1YQwuMsK
	 6RBAqXs72GojYZIAi3zn0/dPHQwihhKV6YNLVguSWEtsTxkb6HeJJkTvWaGQB8/Fdw
	 ZuAedZweI+wuKXlVoDjB31p0TsbhIpaSZfFvDjVFy/TdsOfrfzi4YEkJyRmrc/Yxe+
	 dY/8QDClcThvtvs2UPB56W5Yijh7Tpy4j+I11lvAmjqDFgiEtqU+ceZdslMcpLj+3Q
	 1pF+Xc5M4XpSQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-api@vger.kernel.org,
	workflows@vger.kernel.org,
	tools@kernel.org,
	Sasha Levin <sashal@kernel.org>
Subject: [RFC 02/19] eventpoll: add API specification for epoll_create1
Date: Sat, 14 Jun 2025 09:48:41 -0400
Message-Id: <20250614134858.790460-3-sashal@kernel.org>
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

Add kernel API specification for the epoll_create1() system call.

Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/eventpoll.c | 86 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 86 insertions(+)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index d4dbffdedd08e..8f8a64ebbaef6 100644
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
@@ -2265,6 +2266,91 @@ static int do_epoll_create(int flags)
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
+		.constraint_type = KAPI_CONSTRAINT_ENUM,
+		.enum_values = epoll_create1_valid_values,
+		.enum_count = ARRAY_SIZE(epoll_create1_valid_values),
+		.constraints = "Must be 0 or EPOLL_CLOEXEC",
+	KAPI_PARAM_END
+
+	KAPI_RETURN("long", "File descriptor on success, negative error code on failure")
+		.type = KAPI_TYPE_INT,
+		.check_type = KAPI_RETURN_FD,
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
+	.examples = "int epfd = epoll_create1(EPOLL_CLOEXEC);",
+	.notes = "EPOLL_CLOEXEC sets the close-on-exec (FD_CLOEXEC) flag on the new file descriptor. "
+		 "When all file descriptors referring to an epoll instance are closed, the kernel "
+		 "destroys the instance and releases associated resources.",
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
+		KAPI_SIGNAL_RESTARTABLE
+	KAPI_SIGNAL_END
+
+	KAPI_SIGNAL(1, SIGTERM, "SIGTERM", KAPI_SIGNAL_RECEIVE, KAPI_SIGNAL_ACTION_RETURN)
+		KAPI_SIGNAL_CONDITION("During creation if process receives SIGTERM")
+		KAPI_SIGNAL_DESC("If interrupted during kernel memory allocation, returns -EINTR")
+		KAPI_SIGNAL_RESTARTABLE
+	KAPI_SIGNAL_END
+
+	KAPI_SIGNAL(2, SIGKILL, "SIGKILL", KAPI_SIGNAL_RECEIVE, KAPI_SIGNAL_ACTION_TERMINATE)
+		KAPI_SIGNAL_CONDITION("At any point during the syscall")
+		KAPI_SIGNAL_DESC("Process is terminated immediately, epoll instance creation may be incomplete")
+	KAPI_SIGNAL_END
+
+	.signal_count = 3,
+KAPI_END_SPEC;
 SYSCALL_DEFINE1(epoll_create1, int, flags)
 {
 	return do_epoll_create(flags);
-- 
2.39.5



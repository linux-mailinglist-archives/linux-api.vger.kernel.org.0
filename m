Return-Path: <linux-api+bounces-1805-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C764691CF1F
	for <lists+linux-api@lfdr.de>; Sat, 29 Jun 2024 23:04:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83A7428268C
	for <lists+linux-api@lfdr.de>; Sat, 29 Jun 2024 21:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14DF1139CFE;
	Sat, 29 Jun 2024 21:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZQBRWXOY"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2AC94B5A6;
	Sat, 29 Jun 2024 21:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719695046; cv=none; b=NrfpuymRXtREDsbj6JdnTg+hFLv86WfgAWY+iGZ4MgAsM1UYpCK16yo9QSA+HG2B6lhoQ/C1pO6THlxG7jB6Oroyr8izULzKt2gwrFqX5gAQeVhOQmvCnMYPF9FLdu4g/UiRDQNz4oO7hR+SBk//P7XFdJxsxlxrtlmbzQpw7Rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719695046; c=relaxed/simple;
	bh=m/yNJEhb5BzeQMP8vX+LrhZlQykraSLPqSVe5MB1HLs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=X1ZK3KB1Z2JtTmwwtItTajEuOZiUQ6gTBLE0aCGaTTjGaSDMYi/hbFKe0j6l8vs0z1rSZPB3FYh/LESiGNAhJbVPt9cEAIRZCBl48frITizTTuWjgWpB7/Ikd0aDEheEX9ctVUG4NVPJPxbwWXgqbK3d7fyrsk+hUzskAhrfXRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZQBRWXOY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29E3DC2BBFC;
	Sat, 29 Jun 2024 21:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719695045;
	bh=m/yNJEhb5BzeQMP8vX+LrhZlQykraSLPqSVe5MB1HLs=;
	h=From:To:Cc:Subject:Date:From;
	b=ZQBRWXOYlsMN1RcJHl1t13bQmGkOx1YbPd1hztXwwce0Hb6tJn1J5KULEZM7FA4Su
	 Hy2hLqck/PA1ca2XWL+sAu5hMAfNUUngXaCgIXS451X5E4lfT0cYiEFKJYC4c4Nqok
	 Q5+cSIZYsH6hnnkkVJqCLxNoMu5x90BouvCQt976UY79IMrdsF9/fKEcNCcwzlWItV
	 oO88JS0nu2r7iE0B7CpvY1Fh4tDagdjpQJH6qkAJfRY+X2m2FzqVZCU9XiDatUR182
	 ZKSLkJaQjrm2K1UyFa24eIo+1Ne0/4x394fA+wCn4SWDJ3wNKJJquDP+L/2OSIx2W8
	 ou5Q77TIE0QGQ==
From: Arnd Bergmann <arnd@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>,
	Helge Deller <deller@gmx.de>
Cc: Guenter Roeck <linux@roeck-us.net>,
	linux-api@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] syscalls: fix sys_fanotify_mark prototype
Date: Sat, 29 Jun 2024 23:03:37 +0200
Message-Id: <20240629210359.94426-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

My earlier fix missed an incorrect function prototype that shows up on
native 32-bit builds:

In file included from fs/notify/fanotify/fanotify_user.c:14:
include/linux/syscalls.h:248:25: error: conflicting types for 'sys_fanotify_mark'; have 'long int(int,  unsigned int,  u32,  u32,  int,  const char *)' {aka 'long int(int,  unsigned int,  unsigned int,  unsigned int,  int,  const char *)'}
 1924 | SYSCALL32_DEFINE6(fanotify_mark,
      | ^~~~~~~~~~~~~~~~~
include/linux/syscalls.h:862:17: note: previous declaration of 'sys_fanotify_mark' with type 'long int(int,  unsigned int,  u64,  int, const char *)' {aka 'long int(int,  unsigned int,  long long unsigned int,  int,  const char *)'}

On x86 and powerpc, the prototype is also wrong but hidden in an #ifdef,
so it never caused problems.

Add another alternative declaration that matches the conditional function
definition.

Fixes: 403f17a33073 ("parisc: use generic sys_fanotify_mark implementation")
Reported-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
I've queued this fix in the asm-generic tree now

 include/linux/syscalls.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 63424af87bba..fff820c3e93e 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -859,9 +859,15 @@ asmlinkage long sys_prlimit64(pid_t pid, unsigned int resource,
 				const struct rlimit64 __user *new_rlim,
 				struct rlimit64 __user *old_rlim);
 asmlinkage long sys_fanotify_init(unsigned int flags, unsigned int event_f_flags);
+#if defined(CONFIG_ARCH_SPLIT_ARG64)
+asmlinkage long sys_fanotify_mark(int fanotify_fd, unsigned int flags,
+                                unsigned int mask_1, unsigned int mask_2,
+				int dfd, const char  __user * pathname);
+#else
 asmlinkage long sys_fanotify_mark(int fanotify_fd, unsigned int flags,
 				  u64 mask, int fd,
 				  const char  __user *pathname);
+#endif
 asmlinkage long sys_name_to_handle_at(int dfd, const char __user *name,
 				      struct file_handle __user *handle,
 				      int __user *mnt_id, int flag);
-- 
2.39.2



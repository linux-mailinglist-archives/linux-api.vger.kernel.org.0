Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DCF6BBE2FD
	for <lists+linux-api@lfdr.de>; Wed, 25 Sep 2019 19:00:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389763AbfIYRAR (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 25 Sep 2019 13:00:17 -0400
Received: from mx2.mailbox.org ([80.241.60.215]:11662 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2440084AbfIYRAR (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 25 Sep 2019 13:00:17 -0400
Received: from smtp2.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:105:465:1:1:0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id 5CD2AA1C4D;
        Wed, 25 Sep 2019 19:00:14 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.240])
        by hefe.heinlein-support.de (hefe.heinlein-support.de [91.198.250.172]) (amavisd-new, port 10030)
        with ESMTP id R9YPquIgVEuV; Wed, 25 Sep 2019 19:00:10 +0200 (CEST)
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Christian Brauner <christian@brauner.io>
Cc:     Aleksa Sarai <cyphar@cyphar.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        libc-alpha@sourceware.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/4] clone3: switch to copy_struct_from_user()
Date:   Wed, 25 Sep 2019 18:59:13 +0200
Message-Id: <20190925165915.8135-3-cyphar@cyphar.com>
In-Reply-To: <20190925165915.8135-1-cyphar@cyphar.com>
References: <20190925165915.8135-1-cyphar@cyphar.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

The change is very straightforward, and helps unify the syscall
interface for struct-from-userspace syscalls. Additionally, explicitly
define CLONE_ARGS_SIZE_VER0 to match the other users of the
struct-extension pattern.

Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
---
 include/uapi/linux/sched.h |  2 ++
 kernel/fork.c              | 34 +++++++---------------------------
 2 files changed, 9 insertions(+), 27 deletions(-)

diff --git a/include/uapi/linux/sched.h b/include/uapi/linux/sched.h
index b3105ac1381a..0945805982b4 100644
--- a/include/uapi/linux/sched.h
+++ b/include/uapi/linux/sched.h
@@ -47,6 +47,8 @@ struct clone_args {
 	__aligned_u64 tls;
 };
 
+#define CLONE_ARGS_SIZE_VER0 64 /* sizeof first published struct */
+
 /*
  * Scheduling policies
  */
diff --git a/kernel/fork.c b/kernel/fork.c
index 541fd805fb88..a86e3841ee4e 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2530,39 +2530,19 @@ SYSCALL_DEFINE5(clone, unsigned long, clone_flags, unsigned long, newsp,
 #ifdef __ARCH_WANT_SYS_CLONE3
 noinline static int copy_clone_args_from_user(struct kernel_clone_args *kargs,
 					      struct clone_args __user *uargs,
-					      size_t size)
+					      size_t usize)
 {
+	int err;
 	struct clone_args args;
 
-	if (unlikely(size > PAGE_SIZE))
+	if (unlikely(usize > PAGE_SIZE))
 		return -E2BIG;
-
-	if (unlikely(size < sizeof(struct clone_args)))
+	if (unlikely(usize < CLONE_ARGS_SIZE_VER0))
 		return -EINVAL;
 
-	if (unlikely(!access_ok(uargs, size)))
-		return -EFAULT;
-
-	if (size > sizeof(struct clone_args)) {
-		unsigned char __user *addr;
-		unsigned char __user *end;
-		unsigned char val;
-
-		addr = (void __user *)uargs + sizeof(struct clone_args);
-		end = (void __user *)uargs + size;
-
-		for (; addr < end; addr++) {
-			if (get_user(val, addr))
-				return -EFAULT;
-			if (val)
-				return -E2BIG;
-		}
-
-		size = sizeof(struct clone_args);
-	}
-
-	if (copy_from_user(&args, uargs, size))
-		return -EFAULT;
+	err = copy_struct_from_user(&args, sizeof(args), uargs, usize);
+	if (err)
+		return err;
 
 	/*
 	 * Verify that higher 32bits of exit_signal are unset and that
-- 
2.23.0


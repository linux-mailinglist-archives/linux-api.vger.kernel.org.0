Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD8F3C28FE
	for <lists+linux-api@lfdr.de>; Mon, 30 Sep 2019 23:45:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726005AbfI3Vnu (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 30 Sep 2019 17:43:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:56944 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730096AbfI3Vnu (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Mon, 30 Sep 2019 17:43:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 130EAB12C;
        Mon, 30 Sep 2019 19:16:40 +0000 (UTC)
From:   Aleksa Sarai <asarai@suse.de>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Christian Brauner <christian@brauner.io>,
        Kees Cook <keescook@chromium.org>
Cc:     Aleksa Sarai <cyphar@cyphar.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        libc-alpha@sourceware.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH RESEND v3 2/4] clone3: switch to copy_struct_from_user()
Date:   Tue,  1 Oct 2019 05:15:24 +1000
Message-Id: <20190930191526.19544-3-asarai@suse.de>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190930191526.19544-1-asarai@suse.de>
References: <20190930191526.19544-1-asarai@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

From: Aleksa Sarai <cyphar@cyphar.com>

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
index f9572f416126..2ef529869c64 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2525,39 +2525,19 @@ SYSCALL_DEFINE5(clone, unsigned long, clone_flags, unsigned long, newsp,
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


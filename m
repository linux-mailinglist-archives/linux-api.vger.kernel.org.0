Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CEE8CBE8BA
	for <lists+linux-api@lfdr.de>; Thu, 26 Sep 2019 01:04:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbfIYXEz (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 25 Sep 2019 19:04:55 -0400
Received: from mx2.mailbox.org ([80.241.60.215]:28370 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726114AbfIYXEz (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 25 Sep 2019 19:04:55 -0400
Received: from smtp2.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id 0BD53A012D;
        Thu, 26 Sep 2019 01:04:53 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.240])
        by gerste.heinlein-support.de (gerste.heinlein-support.de [91.198.250.173]) (amavisd-new, port 10030)
        with ESMTP id kO7xxPjyD2R1; Thu, 26 Sep 2019 01:04:49 +0200 (CEST)
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
Subject: [PATCH v2 3/4] sched_setattr: switch to copy_struct_from_user()
Date:   Thu, 26 Sep 2019 01:03:31 +0200
Message-Id: <20190925230332.18690-4-cyphar@cyphar.com>
In-Reply-To: <20190925230332.18690-1-cyphar@cyphar.com>
References: <20190925230332.18690-1-cyphar@cyphar.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

The change is very straightforward, and helps unify the syscall
interface for struct-from-userspace syscalls. Ideally we could also
unify sched_getattr(2)-style syscalls as well, but unfortunately the
correct semantics for such syscalls are much less clear (see [1] for
more detail). In future we could come up with a more sane idea for how
the syscall interface should look.

[1]: commit 1251201c0d34 ("sched/core: Fix uclamp ABI bug, clean up and
     robustify sched_read_attr() ABI logic and code")

Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
---
 kernel/sched/core.c | 43 +++++++------------------------------------
 1 file changed, 7 insertions(+), 36 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index df9f1fe5689b..cdb2f5e29b88 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4900,9 +4900,6 @@ static int sched_copy_attr(struct sched_attr __user *uattr, struct sched_attr *a
 	u32 size;
 	int ret;
 
-	if (!access_ok(uattr, SCHED_ATTR_SIZE_VER0))
-		return -EFAULT;
-
 	/* Zero the full structure, so that a short copy will be nice: */
 	memset(attr, 0, sizeof(*attr));
 
@@ -4910,45 +4907,19 @@ static int sched_copy_attr(struct sched_attr __user *uattr, struct sched_attr *a
 	if (ret)
 		return ret;
 
-	/* Bail out on silly large: */
-	if (size > PAGE_SIZE)
-		goto err_size;
-
 	/* ABI compatibility quirk: */
 	if (!size)
 		size = SCHED_ATTR_SIZE_VER0;
-
-	if (size < SCHED_ATTR_SIZE_VER0)
+	if (size < SCHED_ATTR_SIZE_VER0 || size > PAGE_SIZE)
 		goto err_size;
 
-	/*
-	 * If we're handed a bigger struct than we know of,
-	 * ensure all the unknown bits are 0 - i.e. new
-	 * user-space does not rely on any kernel feature
-	 * extensions we dont know about yet.
-	 */
-	if (size > sizeof(*attr)) {
-		unsigned char __user *addr;
-		unsigned char __user *end;
-		unsigned char val;
-
-		addr = (void __user *)uattr + sizeof(*attr);
-		end  = (void __user *)uattr + size;
-
-		for (; addr < end; addr++) {
-			ret = get_user(val, addr);
-			if (ret)
-				return ret;
-			if (val)
-				goto err_size;
-		}
-		size = sizeof(*attr);
+	ret = copy_struct_from_user(attr, sizeof(*attr), uattr, size);
+	if (ret) {
+		if (ret == -E2BIG)
+			goto err_size;
+		return ret;
 	}
 
-	ret = copy_from_user(attr, uattr, size);
-	if (ret)
-		return -EFAULT;
-
 	if ((attr->sched_flags & SCHED_FLAG_UTIL_CLAMP) &&
 	    size < SCHED_ATTR_SIZE_VER1)
 		return -EINVAL;
@@ -5148,7 +5119,7 @@ sched_attr_copy_to_user(struct sched_attr __user *uattr,
  * sys_sched_getattr - similar to sched_getparam, but with sched_attr
  * @pid: the pid in question.
  * @uattr: structure containing the extended parameters.
- * @usize: sizeof(attr) that user-space knows about, for forwards and backwards compatibility.
+ * @usize: sizeof(attr) for fwd/bwd comp.
  * @flags: for future extension.
  */
 SYSCALL_DEFINE4(sched_getattr, pid_t, pid, struct sched_attr __user *, uattr,
-- 
2.23.0


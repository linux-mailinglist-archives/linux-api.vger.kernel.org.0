Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6BE15C277F
	for <lists+linux-api@lfdr.de>; Mon, 30 Sep 2019 22:58:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728310AbfI3U6Q (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 30 Sep 2019 16:58:16 -0400
Received: from mx2.mailbox.org ([80.241.60.215]:54504 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729366AbfI3U6P (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Mon, 30 Sep 2019 16:58:15 -0400
Received: from smtp2.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id 526EAA1893;
        Mon, 30 Sep 2019 20:29:09 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.240])
        by spamfilter04.heinlein-hosting.de (spamfilter04.heinlein-hosting.de [80.241.56.122]) (amavisd-new, port 10030)
        with ESMTP id ydpASaiTM1cS; Mon, 30 Sep 2019 20:29:06 +0200 (CEST)
From:   Aleksa Sarai <cyphar@cyphar.com>
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
Subject: [PATCH v3 4/4] perf_event_open: switch to copy_struct_from_user()
Date:   Tue,  1 Oct 2019 04:28:10 +1000
Message-Id: <20190930182810.6090-5-cyphar@cyphar.com>
In-Reply-To: <20190930182810.6090-1-cyphar@cyphar.com>
References: <20190930182810.6090-1-cyphar@cyphar.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

The change is very straightforward, and helps unify the syscall
interface for struct-from-userspace syscalls.

Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
---
 kernel/events/core.c | 47 +++++++++-----------------------------------
 1 file changed, 9 insertions(+), 38 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 4655adbbae10..3f0cb82e4fbc 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -10586,55 +10586,26 @@ static int perf_copy_attr(struct perf_event_attr __user *uattr,
 	u32 size;
 	int ret;
 
-	if (!access_ok(uattr, PERF_ATTR_SIZE_VER0))
-		return -EFAULT;
-
-	/*
-	 * zero the full structure, so that a short copy will be nice.
-	 */
+	/* Zero the full structure, so that a short copy will be nice. */
 	memset(attr, 0, sizeof(*attr));
 
 	ret = get_user(size, &uattr->size);
 	if (ret)
 		return ret;
 
-	if (size > PAGE_SIZE)	/* silly large */
-		goto err_size;
-
-	if (!size)		/* abi compat */
+	/* ABI compatibility quirk: */
+	if (!size)
 		size = PERF_ATTR_SIZE_VER0;
-
-	if (size < PERF_ATTR_SIZE_VER0)
+	if (size < PERF_ATTR_SIZE_VER0 || size > PAGE_SIZE)
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
 	attr->size = size;
 
 	if (attr->__reserved_1)
-- 
2.23.0


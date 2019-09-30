Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0BA9CC2905
	for <lists+linux-api@lfdr.de>; Mon, 30 Sep 2019 23:46:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731991AbfI3VoE (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 30 Sep 2019 17:44:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:56908 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728635AbfI3Vnu (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Mon, 30 Sep 2019 17:43:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1B6BAB125;
        Mon, 30 Sep 2019 19:16:53 +0000 (UTC)
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
Subject: [PATCH RESEND v3 4/4] perf_event_open: switch to copy_struct_from_user()
Date:   Tue,  1 Oct 2019 05:15:26 +1000
Message-Id: <20190930191526.19544-5-asarai@suse.de>
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


Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D365410C852
	for <lists+linux-api@lfdr.de>; Thu, 28 Nov 2019 13:02:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbfK1MCR (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 28 Nov 2019 07:02:17 -0500
Received: from mout-p-202.mailbox.org ([80.241.56.172]:47986 "EHLO
        mout-p-202.mailbox.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbfK1MCR (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 28 Nov 2019 07:02:17 -0500
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mout-p-202.mailbox.org (Postfix) with ESMTPS id 47Nx8Q6xgVzQkJy;
        Thu, 28 Nov 2019 13:02:14 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter05.heinlein-hosting.de (spamfilter05.heinlein-hosting.de [80.241.56.123]) (amavisd-new, port 10030)
        with ESMTP id Gwi2Q3_e3tmn; Thu, 28 Nov 2019 13:02:11 +0100 (CET)
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Michael Kerrisk <mtk.manpages@gmail.com>
Cc:     linux-man@vger.kernel.org, linux-api@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@infradead.org>,
        Thadeu Lima de Souza Cascardo <cascardo@canonical.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Aleksa Sarai <cyphar@cyphar.com>
Subject: [PATCH] sched_getattr.2: update to include changed size semantics
Date:   Thu, 28 Nov 2019 23:01:40 +1100
Message-Id: <20191128120140.20367-1-cyphar@cyphar.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Due to a userspace breakage, commit 1251201c0d34 ("sched/core: Fix
uclamp ABI bug, clean up and robustify sched_read_attr() ABI logic and
code") changed the semantics of sched_getattr(2) when the userspace
struct is smaller than the kernel struct. Now, any trailing non-zero
data in the kernel structure is ignored when copying to userspace.

Ref: 1251201c0d34 ("sched/core: Fix uclamp ABI bug, clean up and
                    robustify sched_read_attr() ABI logic and code")
Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
---
 man2/sched_setattr.2 | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/man2/sched_setattr.2 b/man2/sched_setattr.2
index 76ffa14eba85..fbb67b8eb98b 100644
--- a/man2/sched_setattr.2
+++ b/man2/sched_setattr.2
@@ -284,10 +284,8 @@ structure,
 the additional bytes in the user-space structure are not touched.
 If the caller-provided structure is smaller than the kernel
 .I sched_attr
-structure and the kernel needs to return values outside the provided space,
-.BR sched_getattr ()
-fails with the error
-.BR E2BIG .
+structure, the kernel will silently not return any values which would be stored
+outside the provided space.
 As with
 .BR sched_setattr (),
 these semantics allow for future extensibility of the interface.
-- 
2.24.0


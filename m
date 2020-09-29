Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAF3F27DC21
	for <lists+linux-api@lfdr.de>; Wed, 30 Sep 2020 00:36:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728124AbgI2WgH (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 29 Sep 2020 18:36:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728115AbgI2WgH (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 29 Sep 2020 18:36:07 -0400
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [IPv6:2001:67c:2050::465:101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4711C061755;
        Tue, 29 Sep 2020 15:36:06 -0700 (PDT)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:105:465:1:1:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4C1DkW1lMCzKmcx;
        Wed, 30 Sep 2020 00:36:03 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter02.heinlein-hosting.de (spamfilter02.heinlein-hosting.de [80.241.56.116]) (amavisd-new, port 10030)
        with ESMTP id fyAF0BbuO_ye; Wed, 30 Sep 2020 00:35:59 +0200 (CEST)
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     mtk.manpages@gmail.com
Cc:     Aleksa Sarai <cyphar@cyphar.com>,
        Thadeu Lima de Souza Cascardo <cascardo@canonical.com>,
        Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@infradead.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-man@vger.kernel.org, linux-api@vger.kernel.org
Subject: [PATCH 1/2] sched_getattr.2: update to include changed size semantics
Date:   Wed, 30 Sep 2020 08:35:08 +1000
Message-Id: <20200929223509.11783-1-cyphar@cyphar.com>
In-Reply-To: <CAKgNAkiMNssJ2kCtGXd9ZUMFrG6uVtECBXMLGf2EZeS5-rkPKA@mail.gmail.com>
References: <CAKgNAkiMNssJ2kCtGXd9ZUMFrG6uVtECBXMLGf2EZeS5-rkPKA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-SPAM-Probability: **
X-Rspamd-Score: 2.70 / 15.00 / 15.00
X-Rspamd-Queue-Id: 53B41150C
X-Rspamd-UID: bf32a2
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Due to a userspace breakage, commit 1251201c0d34 ("sched/core: Fix
uclamp ABI bug, clean up and robustify sched_read_attr() ABI logic and
code") changed the semantics of sched_getattr(2) when the userspace
struct is smaller than the kernel struct. Now, any trailing non-zero
data in the kernel structure is ignored when copying to userspace. We
also document the original error code correctly (it was EFBIG not
E2BIG) in the BUGS section.

Ref: 1251201c0d34 ("sched/core: Fix uclamp ABI bug, clean up and
                    robustify sched_read_attr() ABI logic and code")
Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
---
 man2/sched_setattr.2 | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/man2/sched_setattr.2 b/man2/sched_setattr.2
index 2592a761a086..da0972a6a86d 100644
--- a/man2/sched_setattr.2
+++ b/man2/sched_setattr.2
@@ -286,10 +286,8 @@ structure,
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
@@ -416,6 +414,16 @@ failed with the error
 instead of
 .BR E2BIG
 for the case described in ERRORS.
+.PP
+In Linux versions up to 5.3,
+.BR sched_getattr ()
+failed with the error
+.BR EFBIG
+if the in-kernel
+.IR sched_attr
+structure was larger than the
+.IR size
+passed by user space.
 .\" In Linux versions up to up 3.15,
 .\" FIXME . patch from Peter Zijlstra pending
 .\" .BR sched_setattr ()
-- 
2.28.0


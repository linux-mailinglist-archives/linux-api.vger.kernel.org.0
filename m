Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1629327DC24
	for <lists+linux-api@lfdr.de>; Wed, 30 Sep 2020 00:36:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728197AbgI2WgL (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 29 Sep 2020 18:36:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728115AbgI2WgL (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 29 Sep 2020 18:36:11 -0400
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [IPv6:2001:67c:2050::465:102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB75DC061755;
        Tue, 29 Sep 2020 15:36:10 -0700 (PDT)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:105:465:1:1:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4C1Dkc4Cw5zKmQv;
        Wed, 30 Sep 2020 00:36:08 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by hefe.heinlein-support.de (hefe.heinlein-support.de [91.198.250.172]) (amavisd-new, port 10030)
        with ESMTP id nOMzIZXoFrZq; Wed, 30 Sep 2020 00:36:05 +0200 (CEST)
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
Subject: [PATCH 2/2] openat2.2: fix minor reference typo
Date:   Wed, 30 Sep 2020 08:35:09 +1000
Message-Id: <20200929223509.11783-2-cyphar@cyphar.com>
In-Reply-To: <20200929223509.11783-1-cyphar@cyphar.com>
References: <CAKgNAkiMNssJ2kCtGXd9ZUMFrG6uVtECBXMLGf2EZeS5-rkPKA@mail.gmail.com>
 <20200929223509.11783-1-cyphar@cyphar.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-SPAM-Probability: **
X-Rspamd-Score: 2.87 / 15.00 / 15.00
X-Rspamd-Queue-Id: 7E5F213E2
X-Rspamd-UID: 413b08
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
---
 man2/openat2.2 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/man2/openat2.2 b/man2/openat2.2
index 29b716d97ac4..53056ee6d292 100644
--- a/man2/openat2.2
+++ b/man2/openat2.2
@@ -493,7 +493,7 @@ acting as an implicit version number.
 (Because new extension fields will always
 be appended, the structure size will always increase.)
 This extensibility design is very similar to other system calls such as
-.BR perf_setattr (2),
+.BR sched_setattr (2),
 .BR perf_event_open (2),
 and
 .BR clone3 (2).
-- 
2.28.0


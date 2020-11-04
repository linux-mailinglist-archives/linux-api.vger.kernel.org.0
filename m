Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDCED2A6F75
	for <lists+linux-api@lfdr.de>; Wed,  4 Nov 2020 22:18:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730609AbgKDVSY (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 4 Nov 2020 16:18:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726152AbgKDVSY (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 4 Nov 2020 16:18:24 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35BC5C0613D3
        for <linux-api@vger.kernel.org>; Wed,  4 Nov 2020 13:18:23 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id 23so6774pfp.21
        for <linux-api@vger.kernel.org>; Wed, 04 Nov 2020 13:18:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=ylYV+FRxCY6p7eAm6CnIKwGDUr9mModfAMf52CohP6I=;
        b=HbDTUve4BGxc+g1JqNZ9J1NCh8VaK0Q7AYCH5rcm/DruBvruKhBy/I97IIt0nZEp+w
         pUjtl4Rbr+UZERwmWR6eTW1itBrXafa5B0dTQREApa++h/YzLU8THH3N93bby4SmsDVJ
         r+BYLN9rH1KXo3o/tAd8lWjjRjIZJ2v3xVoYwmVL9J3bm0+owypQWzr4X/aLbF6p59z6
         9yqwgdTxQFRfxofEnEi5V989rCRLHfF8hBkwVO6v+eUOP6fCzhZnGRlOZ3fhKEfBsf2u
         oCAnEUfHwnOlLZhVZaaJ+lSlrDSxhVESRpHqT26iINjapfSVZT6YmwLrtdj+2NUEiIQi
         XuRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ylYV+FRxCY6p7eAm6CnIKwGDUr9mModfAMf52CohP6I=;
        b=pi7d6LjCjWXVPn/7oBXtuUxMGnm1OEdeQFHntxSL8jdroQytPbcj43ZJTVEViv62ol
         AYBGqaLHRLowmVy4G01m65sVE8iduyV6KCBd2LTzf1SARDbYP5i+Zvgody7sm3dG1aJM
         dvaSYo07RhCg4zMHlcKXWzrvYFNveeXEO7jY9aH4B+oQ4sQyVnYaU90k/UBV9SgSclUT
         qTFTLQTjcjYHa/E0AEooD6JBA3p1zCX7XqK69dcbNKX2uQExtjCYqz1Rr88oIIB8kD1H
         YZMcnyK6V+IMAlc1cuefk9AZcLo1UhrXTXuIHJvPqn7xmOXqwGrdfF+QCSIeZKS0dndl
         xssg==
X-Gm-Message-State: AOAM530ni7FbCC7916XtNcjVquPf/6WKcc+HbofZAJ9KOLJ4YiJjPgax
        0ZttpbXxLSU3Y+Ik2qsTyq9Ov0s=
X-Google-Smtp-Source: ABdhPJw4Gf+sPXFMB9HbjxkqGFJgpgBdVCc2LnEDuq3unX0ECkR9xLz59EE2ns5emauueCd/uNsz7/0=
Sender: "pcc via sendgmr" <pcc@pcc-desktop.svl.corp.google.com>
X-Received: from pcc-desktop.svl.corp.google.com ([2620:15c:2ce:0:7220:84ff:fe09:385a])
 (user=pcc job=sendgmr) by 2002:a17:90b:293:: with SMTP id az19mr682203pjb.1.1604524702368;
 Wed, 04 Nov 2020 13:18:22 -0800 (PST)
Date:   Wed,  4 Nov 2020 13:18:05 -0800
In-Reply-To: <cover.1604523707.git.pcc@google.com>
Message-Id: <64c7ea2041dea52a9cc6f03fc3cf137c21fcc25a.1604523707.git.pcc@google.com>
Mime-Version: 1.0
References: <cover.1604523707.git.pcc@google.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [PATCH v14 2/8] parisc: start using signal-defs.h
From:   Peter Collingbourne <pcc@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Will Deacon <will@kernel.org>, Oleg Nesterov <oleg@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>
Cc:     Peter Collingbourne <pcc@google.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Richard Henderson <rth@twiddle.net>, linux-api@vger.kernel.org,
        Helge Deller <deller@gmx.de>,
        David Spickett <david.spickett@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

We currently include signal-defs.h on all architectures except parisc.
Make parisc fall in line. This will make maintenance easier once the
flag bits are moved here.

Signed-off-by: Peter Collingbourne <pcc@google.com>
Acked-by: Helge Deller <deller@gmx.de>
Acked-by: "Eric W. Biederman" <ebiederm@xmission.com>
Link: https://linux-review.googlesource.com/id/If03a5135fb514fe96548fb74610e6c3586a04064
---
 arch/parisc/include/uapi/asm/signal.h | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/arch/parisc/include/uapi/asm/signal.h b/arch/parisc/include/uapi/asm/signal.h
index d9c51769851a..9e6f87bc8a73 100644
--- a/arch/parisc/include/uapi/asm/signal.h
+++ b/arch/parisc/include/uapi/asm/signal.h
@@ -68,14 +68,7 @@
 #define MINSIGSTKSZ	2048
 #define SIGSTKSZ	8192
 
-
-#define SIG_BLOCK          0	/* for blocking signals */
-#define SIG_UNBLOCK        1	/* for unblocking signals */
-#define SIG_SETMASK        2	/* for setting the signal mask */
-
-#define SIG_DFL	((__sighandler_t)0)	/* default signal handling */
-#define SIG_IGN	((__sighandler_t)1)	/* ignore signal */
-#define SIG_ERR	((__sighandler_t)-1)	/* error return from signal */
+#include <asm-generic/signal-defs.h>
 
 # ifndef __ASSEMBLY__
 
@@ -84,10 +77,6 @@
 /* Avoid too many header ordering problems.  */
 struct siginfo;
 
-/* Type of a signal handler.  */
-typedef void __signalfn_t(int);
-typedef __signalfn_t __user *__sighandler_t;
-
 typedef struct sigaltstack {
 	void __user *ss_sp;
 	int ss_flags;
-- 
2.29.1.341.ge80a0c044ae-goog


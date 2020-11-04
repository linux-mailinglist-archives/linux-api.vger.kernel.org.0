Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86C1B2A6F74
	for <lists+linux-api@lfdr.de>; Wed,  4 Nov 2020 22:18:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730576AbgKDVSV (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 4 Nov 2020 16:18:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726152AbgKDVSU (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 4 Nov 2020 16:18:20 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6521C0613D3
        for <linux-api@vger.kernel.org>; Wed,  4 Nov 2020 13:18:20 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id t12so14824945pgv.0
        for <linux-api@vger.kernel.org>; Wed, 04 Nov 2020 13:18:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=zQ9ZG27PC4T2UhOkIr1ET2llXl/uqON3X+uZtU3Wp9k=;
        b=YR40EJOnUJ2wZbch+5OoWQK5WENv3OyA699VBIFzxMudtSDk4C38S0eVzjubGmrHu/
         nqC+u2ZIHiFj38xUWsqYBMWz2t8QDc+6pkaJsRsop0Y2iCvp7weW97xtih2J+kwzY14c
         F3L9w7ZeUS7FLut89dGMDfYqsPDhs94dMFhQD6AehCea0cyyAoX+J2Gd5z+kRnp4pB85
         P8Ghb5LaAuuYnUYjuRQ9of6vm0CtihDYtxAF9+pG2dF6G+fvjuW9rR2c1qlV5asctCXz
         1md4nv3zWKgmZP1W08ZuXXNk1IGUZK1qIKaDD4O10kWUT+Y+RK3Q9Y7TcqnfyzExluBY
         tB0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=zQ9ZG27PC4T2UhOkIr1ET2llXl/uqON3X+uZtU3Wp9k=;
        b=TYuqvwCs4rKhlhHFDo19B4TgLsfS+e5OcNHPQUZ3cWaEgzZEGs4cpXx/pUHL0NssBz
         xIdB0vZRfkgNeyUyVBgH+RSbVUZmK+Et+IM7bngJn40FG0LM1xIYJDqbG+MjbvATHw92
         sFbXcr8+lSsKvFIdD50nS+bvFoDL4FQkPbEmacK/xnYsjHZfjvkpn8n15FOWT2O6H9KM
         3m4f55Czr5RgujqSXYsmDM2ToYBx+ymd1H5im/J2TGUwD3Pe01v1PHovMCWvnvKnbclT
         lh/BkXO0ixM73yJ8fEfdNIzSxUU4WWElxWuPfdFWfH3lLaAj1t0T1OaiCZ4GQ8rjbgrP
         CM6Q==
X-Gm-Message-State: AOAM531SuhtWiHfvQ/Vz5ZaHOP/HGGYXTK7zQwTYnk83pHki2SYUo5ey
        QZtB87710SNQu0aVZlc1QUaXFhQ=
X-Google-Smtp-Source: ABdhPJwr/ZzAL7HuL7q2O5xmm55OgL/Kj2Okdcdj7UkpXExhKiueYv3WmnwMzwDaIEspkn8HEge6Xk8=
Sender: "pcc via sendgmr" <pcc@pcc-desktop.svl.corp.google.com>
X-Received: from pcc-desktop.svl.corp.google.com ([2620:15c:2ce:0:7220:84ff:fe09:385a])
 (user=pcc job=sendgmr) by 2002:a17:90a:1b8a:: with SMTP id
 w10mr5856017pjc.145.1604524700098; Wed, 04 Nov 2020 13:18:20 -0800 (PST)
Date:   Wed,  4 Nov 2020 13:18:04 -0800
In-Reply-To: <cover.1604523707.git.pcc@google.com>
Message-Id: <8fed1621dcbf4d6de765e76e8bba37e22cc3868a.1604523707.git.pcc@google.com>
Mime-Version: 1.0
References: <cover.1604523707.git.pcc@google.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [PATCH v14 1/8] parisc: Drop parisc special case for __sighandler_t
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

From: Helge Deller <deller@gmx.de>

I believe we can and *should* drop this parisc-specific typedef for
__sighandler_t when compiling a 64-bit kernel. The reasons:

1. We don't have a 64-bit userspace yet, so nothing (on userspace side)
can break.

2. Inside the Linux kernel, this is only used in kernel/signal.c, in
function kernel_sigaction() where the signal handler is compared against
SIG_IGN.  SIG_IGN is defined as (__sighandler_t)1), so only the pointers
are compared.

3. Even when a 64-bit userspace gets added at some point, I think
__sighandler_t should be defined what it is: a function pointer struct.

I compiled kernel/signal.c with and without the patch, and the produced code
is identical in both cases.

Signed-off-by: Helge Deller <deller@gmx.de>
Signed-off-by: Peter Collingbourne <pcc@google.com>
Acked-by: "Eric W. Biederman" <ebiederm@xmission.com>
Reviewed-by: Peter Collingbourne <pcc@google.com>
Link: https://linux-review.googlesource.com/id/I21c43f21b264f339e3aa395626af838646f62d97
---
 arch/parisc/include/uapi/asm/signal.h | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/parisc/include/uapi/asm/signal.h b/arch/parisc/include/uapi/asm/signal.h
index e605197b462c..d9c51769851a 100644
--- a/arch/parisc/include/uapi/asm/signal.h
+++ b/arch/parisc/include/uapi/asm/signal.h
@@ -85,16 +85,8 @@
 struct siginfo;
 
 /* Type of a signal handler.  */
-#if defined(__LP64__)
-/* function pointers on 64-bit parisc are pointers to little structs and the
- * compiler doesn't support code which changes or tests the address of
- * the function in the little struct.  This is really ugly -PB
- */
-typedef char __user *__sighandler_t;
-#else
 typedef void __signalfn_t(int);
 typedef __signalfn_t __user *__sighandler_t;
-#endif
 
 typedef struct sigaltstack {
 	void __user *ss_sp;
-- 
2.29.1.341.ge80a0c044ae-goog


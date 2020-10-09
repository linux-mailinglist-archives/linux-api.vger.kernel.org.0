Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5A4B287F89
	for <lists+linux-api@lfdr.de>; Fri,  9 Oct 2020 02:44:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729003AbgJIAoh (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 8 Oct 2020 20:44:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725852AbgJIAoh (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 8 Oct 2020 20:44:37 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B09CBC0613D2
        for <linux-api@vger.kernel.org>; Thu,  8 Oct 2020 17:44:36 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id u17so4603115qvt.23
        for <linux-api@vger.kernel.org>; Thu, 08 Oct 2020 17:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=GagRhE3KnM5+8gfhBJu+OJNKNxRyBwQicVKCRLn19b8=;
        b=OGNPlDXDQgKGq8UqKdKpvnc9XHW8UpmB/THmmk8TP1O2ZYny7wiF+T248cQoBDA0ar
         1SW5rDl02K8OuTMaVt3x0ooqCk+Z+t0rM43SvHspE6bWK6Ro6Ej4XcaKsg+lULhrnANE
         a+/tUfImFqmkvY7LjuGHF8Y3wu3ojbqQjNo0Xw0y5f3B+rlJzSP2eSfntKNh+H6oLB+a
         IWPDQBaVZGg/GyN8w1r1dbuhpq0dItcYTQiD84w1ewr2/39ngRxMoQXuT4CUwhZ08dvx
         AStowEXfhZC5cABJ3OBY9BUquE7zcvlxQ/rE3EuXkfxdAQ00o3H0QxeFpW3X4KGG99hu
         4VPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=GagRhE3KnM5+8gfhBJu+OJNKNxRyBwQicVKCRLn19b8=;
        b=DEjoQZgeA9Vnhv8OOTIBKqgZnaFh2ZhQRRzdbXoBB5LFErKJMEaaj2ZXBszU9M81yT
         H4k9gQSJ03B8D7ZIC1Ffmju+9KR5+rvsq8IGlaDsp2tuRqNbyD2OKTdmsvpuvpiq9Gws
         1K04Y1yrpzznEh8ynlBC0X/WJzxSVWT3dWdQuqGETXloRTEjxFq4b2W0wBRi9EZNuMjl
         RV1hgq1EQFFZG33pbKtAPV6xPPIQ98CHzmeXu02Hf/kNDfdeCeHrvRfP2R2zBXc1lf+4
         cPoA3GbpU8wDaUVkzS5gyPf883V7hUCq2jP1KEUidYQJrZU39i3iP34j117Bb1TfcyKG
         TiCw==
X-Gm-Message-State: AOAM530jFLFrv7iyqfAMBRf0dJL/f2+1+TV2dOB8g1xza6ACc0H2MFsc
        26gsUaB5XXhVNlYNwaKsSghHTMc=
X-Google-Smtp-Source: ABdhPJwHOdh7uFiiOVF/0GibAYouvoelcOASyryt3z5qKAhL1vDUkNo2HrJdN1F5P9D6VhCbg4w1reE=
Sender: "pcc via sendgmr" <pcc@pcc-desktop.svl.corp.google.com>
X-Received: from pcc-desktop.svl.corp.google.com ([2620:15c:2ce:0:7220:84ff:fe09:385a])
 (user=pcc job=sendgmr) by 2002:ad4:59cf:: with SMTP id el15mr11045611qvb.17.1602204275842;
 Thu, 08 Oct 2020 17:44:35 -0700 (PDT)
Date:   Thu,  8 Oct 2020 17:44:13 -0700
In-Reply-To: <cover.1602204097.git.pcc@google.com>
Message-Id: <8237561e70b7a4692994d2afd7d05b3ea7215c8d.1602204097.git.pcc@google.com>
Mime-Version: 1.0
References: <cover.1602204097.git.pcc@google.com>
X-Mailer: git-send-email 2.28.0.1011.ga647a8990f-goog
Subject: [PATCH v11 2/8] parisc: start using signal-defs.h
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
Link: https://linux-review.googlesource.com/id/If03a5135fb514fe96548fb74610e6c3586a04064
---
 arch/parisc/include/uapi/asm/signal.h | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/arch/parisc/include/uapi/asm/signal.h b/arch/parisc/include/uapi/asm/signal.h
index f1fd4fa880d7..e67b1bfb82ba 100644
--- a/arch/parisc/include/uapi/asm/signal.h
+++ b/arch/parisc/include/uapi/asm/signal.h
@@ -69,14 +69,7 @@
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
 
@@ -85,10 +78,6 @@
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
2.28.0.1011.ga647a8990f-goog


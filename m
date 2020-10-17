Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0267E290FCD
	for <lists+linux-api@lfdr.de>; Sat, 17 Oct 2020 08:01:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411865AbgJQGBi (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sat, 17 Oct 2020 02:01:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2411567AbgJQGBf (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sat, 17 Oct 2020 02:01:35 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83983C0613D6
        for <linux-api@vger.kernel.org>; Fri, 16 Oct 2020 17:12:46 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id b7so2630047qkh.20
        for <linux-api@vger.kernel.org>; Fri, 16 Oct 2020 17:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=uYcIrQSk4fWbF8fX+2DV0rs7plcXpFRzMpdoSUroJXo=;
        b=WH2AP0AkCjNMSfLVkc8VhN6QwYCVnbC5vr8npIUN7aHpUCkWkLaZX6gWA41Nn10iJe
         PoKQ16WoiC1ZLug3cdS4vYH+ZMhM/ZJxdB6C9U/07jIN42fQb4IPlOwUaCYxt4M+OaRV
         Cg0UeFJog0WhAynf8yP0H6HUuHqMZbMQnkishy/oi65hD++pF7A5RQQ1bZt4cbMHWhkF
         zMH3cSkfawb4nruNQ0+W+/qLrEA3ulaKV8dqSsriltWoQw3nKm7/CXASTCmG7ShMVVUj
         JJUH9lgCZ4OtI+CtxgEeprtUyB7h8lMJ+ciKJoOIdE6S/FV/8SLNxOtpBAgGS5pu8boo
         jyzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=uYcIrQSk4fWbF8fX+2DV0rs7plcXpFRzMpdoSUroJXo=;
        b=bxxChIACguO6SWEZ7ne5TrBG+MMPK4MFhyBGo2A7X3aGwA42WRL6J8D4n+RpiRqKJ6
         U+C/hBlbtZwMxT/FOEGSEUvXbI9SNivI815Xpc/nSHLn3TJubhnNeLS3oZa7SYU2UPtT
         7NHK2JYnlDjM16hyQ/bjPHHCsVm81cP4DeJyeUJuNBUFIs51snln94fghDEYSrfPiK4A
         vDH4k5MwqBAxAlscWU0wrmKHAVf3ibD93+rbtyjukDQCShAkwkFgIqXu6etzfMy9b4t1
         b2km59mjEHHAl1J+iPr6I0kZ23Sf6B5LaLm+ptKVleprSvLSg3Eemqnt1DZSqd2QfBq5
         hSWQ==
X-Gm-Message-State: AOAM530wiHH2M6/gw6c+0AJRUIxdP1w0QjZjrHOFWsaFyz1glJzRyxHy
        seOKrpUhMu3ClxzxZ2ozbEiGoR0=
X-Google-Smtp-Source: ABdhPJwt73T6PAA4DUCKDWlDma4y0MLFG6EPJOdVJPSpeE5zz2EnIsFSBs8wyzk82m43uVLWtKZK0OQ=
Sender: "pcc via sendgmr" <pcc@pcc-desktop.svl.corp.google.com>
X-Received: from pcc-desktop.svl.corp.google.com ([2620:15c:2ce:0:7220:84ff:fe09:385a])
 (user=pcc job=sendgmr) by 2002:a0c:edb1:: with SMTP id h17mr6018821qvr.7.1602893565579;
 Fri, 16 Oct 2020 17:12:45 -0700 (PDT)
Date:   Fri, 16 Oct 2020 17:12:26 -0700
In-Reply-To: <cover.1602892799.git.pcc@google.com>
Message-Id: <bd8b045e49908acf6fabd4cc5b567c04a64e7b43.1602892799.git.pcc@google.com>
Mime-Version: 1.0
References: <cover.1602892799.git.pcc@google.com>
X-Mailer: git-send-email 2.29.0.rc1.297.gfa9743e501-goog
Subject: [PATCH v12 1/8] parisc: Drop parisc special case for __sighandler_t
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
2.29.0.rc1.297.gfa9743e501-goog


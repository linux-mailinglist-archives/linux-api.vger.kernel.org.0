Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A311287F88
	for <lists+linux-api@lfdr.de>; Fri,  9 Oct 2020 02:44:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728922AbgJIAoe (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 8 Oct 2020 20:44:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725852AbgJIAoe (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 8 Oct 2020 20:44:34 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40116C0613D2
        for <linux-api@vger.kernel.org>; Thu,  8 Oct 2020 17:44:34 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id d143so7147833ybh.11
        for <linux-api@vger.kernel.org>; Thu, 08 Oct 2020 17:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=rj7in+8IIVm0apAnSXQYohfxkCFLELTP7g1Jm/57rKs=;
        b=OE5W0oqnqIeN1PAEEDhTnZBwLevBnU6skwcZBLhkI743Qgjsw7UKi8B2N9dotyNKR2
         p2kCjMiMrK+spZiGVJRHY/YuBxsMG0o1h4R1N7lfelieKb2t6ikmmjO69o+fILKNqTdS
         i61FEPgWd+qw4r3wX1ZC0yqaxYrrr4w54hfKGU5d5VA4cZmM+6RR5rKt6NyAwla4N98r
         q+zEOqlWmt6QhY+1QVSMGv6l8Ebt/52uEiwdI+Hjpv+3x46BqBly0g9m/WoiK4wzb221
         dV38KtCJxkgZINxq8Tc9e8r394yvolEzmoudMBTS/U9LDFHrCfKi1UIomORHVQU5P4Cn
         10Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=rj7in+8IIVm0apAnSXQYohfxkCFLELTP7g1Jm/57rKs=;
        b=qzNq+PV9a2PvKq20R2bxgroLRQS8FCAGmPndhjj4Bz1WehnNrsNCb1Y/VzhXvp0j3w
         sCSV37iWD8NSBSfjSFzFuSOU/Kzk2td2e/uz6EF5qkVhl231xoWIVqUrrkRU5GE9y3Hr
         tE5GZZCY8pcGBLRnYLG2ObWjm/ffJxH2V6kUJrbd2q5e0AFwk+KuXTfJtxW0xhPAQSgY
         hccB2dRtQhw6ciH+PkLN2h1incPUq0NygMTkBoQ/4BdEAdL7V6abYGjbqBe9XnJWsiHA
         Il/utQe1UhQcIiiYn76OSlqkzMrCEPYel4qJxUAkfCLG0VzE0kk2d7PlBFsp62mrwgIR
         jU7A==
X-Gm-Message-State: AOAM530f9CEZIBjotegXMk8EcT1SBhSBtrDvP2spX9wd0Dfd9jUC60Pk
        O+7m3p4BW7tuKf/PITiD1ZbR3h8=
X-Google-Smtp-Source: ABdhPJxAiET3UOMW7Z8xRwHnQbfDK+z112tyAX2Lx6acIXiepWOtgGMUMIgPl7fF2g2RvzPOvrG1iSI=
Sender: "pcc via sendgmr" <pcc@pcc-desktop.svl.corp.google.com>
X-Received: from pcc-desktop.svl.corp.google.com ([2620:15c:2ce:0:7220:84ff:fe09:385a])
 (user=pcc job=sendgmr) by 2002:a25:900b:: with SMTP id s11mr13810076ybl.426.1602204273252;
 Thu, 08 Oct 2020 17:44:33 -0700 (PDT)
Date:   Thu,  8 Oct 2020 17:44:12 -0700
In-Reply-To: <cover.1602204097.git.pcc@google.com>
Message-Id: <485de4315edc2e16a7206c19cb8406fecad457f1.1602204097.git.pcc@google.com>
Mime-Version: 1.0
References: <cover.1602204097.git.pcc@google.com>
X-Mailer: git-send-email 2.28.0.1011.ga647a8990f-goog
Subject: [PATCH v11 1/8] parisc: Drop parisc special case for __sighandler_t
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
index d38563a394f2..f1fd4fa880d7 100644
--- a/arch/parisc/include/uapi/asm/signal.h
+++ b/arch/parisc/include/uapi/asm/signal.h
@@ -86,16 +86,8 @@
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
2.28.0.1011.ga647a8990f-goog


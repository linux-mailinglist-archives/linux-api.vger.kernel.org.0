Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4054E2A3B4A
	for <lists+linux-api@lfdr.de>; Tue,  3 Nov 2020 05:10:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725953AbgKCEKF (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 2 Nov 2020 23:10:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725940AbgKCEKF (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 2 Nov 2020 23:10:05 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A6D3C0617A6
        for <linux-api@vger.kernel.org>; Mon,  2 Nov 2020 20:10:04 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id a24so4436946pfo.3
        for <linux-api@vger.kernel.org>; Mon, 02 Nov 2020 20:10:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=C0TIbQB7eewXGq+mkhd2tlN81pQlKE4q4NIfExPeYcU=;
        b=MdN/swhJbVZmU2L45sgheMs89SJkwKosV9dEveiUjIyhLKzWtBpoVwVKe3Fmw7y014
         g3net6srkCWA4cL0AZ/La1DYQYetohJR2tu1HvZN7NY65nusfo97AXvaouvHNGzaVIHO
         uFPIQ/r4kOPhQynf3xGnWFew6z8+hlsrbhe+5fvR/EFrU6eyl4WhwWvpkSXV8L8UFSwS
         bWkxcMvR8URArlldkISwlzpkzJp98bnLGjAKEc8vVWYvbZwy6cniePQgthRljTX644gj
         ZgYD9YSKRGKFBqH9qwuoTImd/Py0JDBE9vtx58oxTFTya7FTk4oUuwJfWbJpzldS8oL/
         CAkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=C0TIbQB7eewXGq+mkhd2tlN81pQlKE4q4NIfExPeYcU=;
        b=qOohL6xAAdcZZy36DWGdFh9Law7yLUnskZxCGxPND/TqQQGYRSwDRghRZH1QrJww93
         IgvBnQPdneK3Nt1p0Hel7P99dmgRW84FBLgCnXz9VNiDSNhroFDshmYztmU0303OJRCF
         A35mmqKiAr1mSW63Nd1gZCUk+3YRHy6FlQ4uqUlaG86fmyZaYKNAszLLgTXU23zXuj5i
         x+M0tPQduQp5WJuoIt1YWCc5ulANkWzuccchZmyG+FPJNAX4UOTArpROl8cHd+L2oUPw
         GA0KJrWbrWIUpCpBa3P6F2RSmht45gPVEzVCxZ741v4mQZkKQfbp1RjXUqpWKSaUY02q
         Jnrg==
X-Gm-Message-State: AOAM530vwo5QY1EjLNSlfm0YkWEz0vOD85sudhXwq+ySyAoFuqpG5Ysc
        nFZYO/9248fYkJdEbsZRCmckBz8=
X-Google-Smtp-Source: ABdhPJyGzPg5saVpLYjXlfgiW1QNWjNEIs7vXynV+qWn/lgpC5rG5mAj/PFowByubg5FhkBneJ/f+LY=
Sender: "pcc via sendgmr" <pcc@pcc-desktop.svl.corp.google.com>
X-Received: from pcc-desktop.svl.corp.google.com ([2620:15c:2ce:0:7220:84ff:fe09:385a])
 (user=pcc job=sendgmr) by 2002:a17:90b:602:: with SMTP id gb2mr1667259pjb.12.1604376603688;
 Mon, 02 Nov 2020 20:10:03 -0800 (PST)
Date:   Mon,  2 Nov 2020 20:09:37 -0800
In-Reply-To: <cover.1604376407.git.pcc@google.com>
Message-Id: <7e26600459cb08c5016611b37fe88c23098b40eb.1604376407.git.pcc@google.com>
Mime-Version: 1.0
References: <cover.1604376407.git.pcc@google.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [PATCH v13 1/8] parisc: Drop parisc special case for __sighandler_t
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
2.29.1.341.ge80a0c044ae-goog


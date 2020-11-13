Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E7BA2B1461
	for <lists+linux-api@lfdr.de>; Fri, 13 Nov 2020 03:46:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726050AbgKMCqQ (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 12 Nov 2020 21:46:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726017AbgKMCqQ (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 12 Nov 2020 21:46:16 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0A10C0613D6
        for <linux-api@vger.kernel.org>; Thu, 12 Nov 2020 18:46:15 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id t1so5134015pgo.23
        for <linux-api@vger.kernel.org>; Thu, 12 Nov 2020 18:46:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=Cj3ohG6AGzFwKEeqk7COc5B2oFqfXRtq/LSxYZ/FfmU=;
        b=XWWu8xbQTEnMgyV/l7A2+RaAhXwJM3Fh+C/A2/yLH6Ov5SKF9ghuyZ42k39rHuVqdu
         WfPOS9c+o8yL1yB8IdT3S+7B5anETavwX+3TFXEDPihy4sxrBlXQCiAldo5EbAepU0uA
         Gwyvy51Gc3pJsNf2wAB2aVLwoRe42ClZ/Phr9tUSLrEfbg1YIO1R53L92NglEcSaQY0p
         d9O6ylpxRi3nyW2N26voSGziDBxwRnxmp5BpMxnfUTdR7C0JRdr1hUz/U7eLlqh+2Ofq
         DkXApTH6hlvu0+XOA2PRmf3yQAsX9cfvPAwJH0avo9m2zKsD/5Wtt9+fRHjYoVesAx2w
         7nlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Cj3ohG6AGzFwKEeqk7COc5B2oFqfXRtq/LSxYZ/FfmU=;
        b=aMfUpcdg2hO2dzDL60LsOA47A2wvID5yE2Xm05RjmHDz4o/oSL4+r1LXOtB6/bU+lp
         3lXakMy/PvOZmp0v+YcpwraWM9hNFpOJKiZEbVP2LK3VWKOkiHbhxiKyenur5zgVaiOP
         1OtsedEDRtpFFuupXlQZbYgVe+VPAJh6A/fDJ37zZFuslfR7rjCBmOobZ+HmWsZbY6Um
         bmaT27p67mJP87lGM4jRTo+kq/xRi5EXRc1IPyQHhB3jdFkX/cZyFrZ0bm07+oeTtLyF
         j/koLAHloClTMEw4wvefEmpkTwIneT4WlqXn6RDAlynj86w0x4nUPkYaYQ8N7QW0eGrZ
         zfbA==
X-Gm-Message-State: AOAM53181HJ6PxKTBtotxmARdtGbU/5/bqdJwQjw6I0Gtl2SMP2m2Wv3
        GWE1U20goyVOMlWAWsH3LvQKDxc=
X-Google-Smtp-Source: ABdhPJzBRQNSCK5XSuTdDaHfqTWdehX4qlzCllbxoB8iQnY219QwSEDzK8+DhhEnotpQrh5PdEeh2lY=
Sender: "pcc via sendgmr" <pcc@pcc-desktop.svl.corp.google.com>
X-Received: from pcc-desktop.svl.corp.google.com ([2620:15c:2ce:0:7220:84ff:fe09:385a])
 (user=pcc job=sendgmr) by 2002:a17:90b:78d:: with SMTP id l13mr362766pjz.57.1605235575534;
 Thu, 12 Nov 2020 18:46:15 -0800 (PST)
Date:   Thu, 12 Nov 2020 18:46:03 -0800
In-Reply-To: <cover.1605235488.git.pcc@google.com>
Message-Id: <be8f3680ef2d0a1a120994e3ae0b11d82f373279.1605235488.git.pcc@google.com>
Mime-Version: 1.0
References: <cover.1605235488.git.pcc@google.com>
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
Subject: [PATCH v15 2/6] parisc: start using signal-defs.h
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
        linux-api@vger.kernel.org, Helge Deller <deller@gmx.de>,
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
2.29.2.299.gdc1121823c-goog


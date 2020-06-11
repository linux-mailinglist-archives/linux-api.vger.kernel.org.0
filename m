Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA88E1F6356
	for <lists+linux-api@lfdr.de>; Thu, 11 Jun 2020 10:12:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726696AbgFKIMY (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 11 Jun 2020 04:12:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726626AbgFKIMW (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 11 Jun 2020 04:12:22 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 113ACC08C5C1
        for <linux-api@vger.kernel.org>; Thu, 11 Jun 2020 01:12:22 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id l11so5165835wru.0
        for <linux-api@vger.kernel.org>; Thu, 11 Jun 2020 01:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BzbzYQlqTcjq/Z54VA5i0Fc++eCI+FzbgD9c7ww6d1Y=;
        b=NO1lPPu9si97eriO3CEk6BJvVIzLod+4jP8SwlnQ/+S1AvLzgMA/M39Y/MdRwgXzMx
         EN66CvT6OgdHmVHndUmEffKpvKiOGrYngmZybRYdaZijNxeKXNEs1htbYZdc5ZVofpV9
         yJBD+sgpvnRfFo4+B7ldbG3mmyPLItf8kxueFFUGggID365ETPXLKlRESRJfpvT6AzLP
         Gs7/FRIKlaxG5eQOYqqIrKFDK6UR4He2PjfxuVgvc/3CAHtCxnEks5bWadjoGqFUYqiH
         ejJJvp91B3YKSAkSNVR/OD5cF82+e8jHyMmrDzcFJku10pR20Ya74ZPQovLF5WRrDAEE
         Esfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BzbzYQlqTcjq/Z54VA5i0Fc++eCI+FzbgD9c7ww6d1Y=;
        b=Y3VqtDOxkFqxkV62kO68kjRE4Y69pBKPKGEaP8bqeJN2e9Lq3cGDQ5oMUoihUoeerD
         KjVEVPJAjcip0R/aGL10bHm2mcVB7OgmqA3qTh4BLS/EB4xKMkmrQvhpDqURSVeLpT5M
         e3+iXj8q01ru0KA1zrTJUkPPJMgnBKryC8QpEETrT0K2OlcedNHwqZw5Fvt7PmwuDohG
         5iTugEPvX2yiLzqW++9H312BTECGtcJBPqrX0x2ZGGoc93SV3ixq9/7LWlkVa1nJF104
         i1Hty6ZzohDhn0TV4BIsMkDP+EPOlbyfudDPK9hqvElpI32mXfdKxyNuV1ESkb4002qJ
         lstA==
X-Gm-Message-State: AOAM530r3MqvVh9qDpWBUyALCRxaSpop+pEvnY3N9y0nds82gkVmPL5v
        Hogim55otbBQqQVZnT9nnH85l0Qr
X-Google-Smtp-Source: ABdhPJzgTo5usegOpe/iVSOA7fm0pSEeo2rTUxOf7vOJjB1ErBF9OdbQWSt16LmfBhq9t1XurwBUTg==
X-Received: by 2002:a5d:6550:: with SMTP id z16mr8738316wrv.392.1591863140736;
        Thu, 11 Jun 2020 01:12:20 -0700 (PDT)
Received: from bobo.ibm.com (193-116-110-116.tpgi.com.au. [193.116.110.116])
        by smtp.gmail.com with ESMTPSA id w17sm3604826wra.71.2020.06.11.01.12.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2020 01:12:20 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linuxppc-dev@lists.ozlabs.org
Cc:     Nicholas Piggin <npiggin@gmail.com>, musl@lists.openwall.com,
        libc-dev@lists.llvm.org, linux-api@vger.kernel.org
Subject: [PATCH 1/2] powerpc/64s/exception: treat NIA below __end_interrupts as soft-masked
Date:   Thu, 11 Jun 2020 18:12:02 +1000
Message-Id: <20200611081203.995112-2-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200611081203.995112-1-npiggin@gmail.com>
References: <20200611081203.995112-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

The scv instruction causes an interrupt which can enter the kernel with
MSR[EE]=1, thus allowing interrupts to hit at any time. These must not
be taken as normal interrupts, because they come from MSR[PR]=0 context,
and yet the kernel stack is not yet set up and r13 is not set to the
PACA).

Treat this as a soft-masked interrupt regardless of the soft masked
state. This does not affect behaviour yet, because currently all
interrupts are taken with MSR[EE]=0.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/exceptions-64s.S | 27 ++++++++++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index e70ebb5c318c..388e34665b4a 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -508,8 +508,24 @@ DEFINE_FIXED_SYMBOL(\name\()_common_real)
 
 .macro __GEN_COMMON_BODY name
 	.if IMASK
+		.if ! ISTACK
+		.error "No support for masked interrupt to use custom stack"
+		.endif
+
+		/* If coming from user, skip soft-mask tests. */
+		andi.	r10,r12,MSR_PR
+		bne	2f
+
+		/* Kernel code running below __end_interrupts is implicitly
+		 * soft-masked */
+		LOAD_HANDLER(r10, __end_interrupts)
+		cmpld	r11,r10
+		li	r10,IMASK
+		blt-	1f
+
+		/* Test the soft mask state against our interrupt's bit */
 		lbz	r10,PACAIRQSOFTMASK(r13)
-		andi.	r10,r10,IMASK
+1:		andi.	r10,r10,IMASK
 		/* Associate vector numbers with bits in paca->irq_happened */
 		.if IVEC == 0x500 || IVEC == 0xea0
 		li	r10,PACA_IRQ_EE
@@ -540,7 +556,7 @@ DEFINE_FIXED_SYMBOL(\name\()_common_real)
 
 	.if ISTACK
 	andi.	r10,r12,MSR_PR		/* See if coming from user	*/
-	mr	r10,r1			/* Save r1			*/
+2:	mr	r10,r1			/* Save r1			*/
 	subi	r1,r1,INT_FRAME_SIZE	/* alloc frame on kernel stack	*/
 	beq-	100f
 	ld	r1,PACAKSAVE(r13)	/* kernel stack to use		*/
@@ -2838,7 +2854,8 @@ masked_interrupt:
 	ld	r10,PACA_EXGEN+EX_R10(r13)
 	ld	r11,PACA_EXGEN+EX_R11(r13)
 	ld	r12,PACA_EXGEN+EX_R12(r13)
-	/* returns to kernel where r13 must be set up, so don't restore it */
+	ld	r13,PACA_EXGEN+EX_R13(r13)
+	/* May return to masked low address where r13 is not set up */
 	.if \hsrr
 	HRFI_TO_KERNEL
 	.else
@@ -2997,6 +3014,10 @@ EXC_COMMON_BEGIN(ppc64_runlatch_on_trampoline)
 
 USE_FIXED_SECTION(virt_trampolines)
 	/*
+	 * All code below __end_interrupts is treated as soft-masked. If
+	 * any code runs here with MSR[EE]=1, it must then cope with pending
+	 * soft interrupt being raised (i.e., by ensuring it is replayed).
+	 *
 	 * The __end_interrupts marker must be past the out-of-line (OOL)
 	 * handlers, so that they are copied to real address 0x100 when running
 	 * a relocatable kernel. This ensures they can be reached from the short
-- 
2.23.0


Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 300882B1476
	for <lists+linux-api@lfdr.de>; Fri, 13 Nov 2020 03:53:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726325AbgKMCxs (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 12 Nov 2020 21:53:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725965AbgKMCxs (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 12 Nov 2020 21:53:48 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1477AC0613D1
        for <linux-api@vger.kernel.org>; Thu, 12 Nov 2020 18:53:47 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id j10so8698404ybl.19
        for <linux-api@vger.kernel.org>; Thu, 12 Nov 2020 18:53:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=Cj3ohG6AGzFwKEeqk7COc5B2oFqfXRtq/LSxYZ/FfmU=;
        b=iwYp5l/iYcfWgKNjg4mxKDL1vZEjBi4/g2lHxXpTqbgxveDBdx3wDz88VRGiYTMqN0
         btvZohDB2fYJbrC4HCrq3infzlfrODfhKKqPpzVX1O48THjDF2y3AbWSV9y/9if27AFK
         1M9cCIp4MnUkYhHqgzjEdlWq3vLQy6OOhkuy6WrPFnF9QtQ8R7pwNJ0DkZrx0e5ldUK+
         WTClOVgzV/XyMtA4bw6lMnlQ1VA+CfzXDg30qFN+vb+IzbJL25Ic5EG1Je166yYr1TMq
         eJSllbz8COBo3SJRuRi39U/TZwr6OL4bO6WGbI2mvfyyoawx6k6bR3TfFkkxr9wlWX6j
         /j8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Cj3ohG6AGzFwKEeqk7COc5B2oFqfXRtq/LSxYZ/FfmU=;
        b=IYlJ+fX59HgLQhNMNDuyvdnwLTnmocFMmKw46Bn7s5mPeydtXVcBvk7BMspwTaO2HO
         bmTER5IvbOlwLyj564SB1ZOiT0rtHrAxUxlLwa+zwcuhhT8/zq+Ly1jHjQCWDTH46IlO
         4rTqIJLk8KeqIVjHrRPV8pXZ5xisvU2JIcX0q/l83YTX1hS3eywjN3BwZWwEFbRpI3qJ
         4IlP63yg3eDR87KHGs8281vfIofcHohCfs3xTsZ0+6/VK+jp34W7T4UWjfd7xm7ZpaTP
         fkMSfRipTb23hEQKiRQGR82p9l7+2d3npHLtzs2kfzVgb4vMTaOXExBCT/0542FWWK1B
         ibSA==
X-Gm-Message-State: AOAM5330J6UFK08K2uQ5U4sO+9/MT5hlrIbDJRKwYdVW3zeL8c2mlSsB
        I9enq1YFQPzgEDPlUByEGYLzNVU=
X-Google-Smtp-Source: ABdhPJx9tue4dJD997+WobT2w1p+Nr0FBMb9fWvi9DixbRjFKx/AcByUsbwoq0OhS/r1CsnF3qdmde4=
Sender: "pcc via sendgmr" <pcc@pcc-desktop.svl.corp.google.com>
X-Received: from pcc-desktop.svl.corp.google.com ([2620:15c:2ce:0:7220:84ff:fe09:385a])
 (user=pcc job=sendgmr) by 2002:a25:3b87:: with SMTP id i129mr88887yba.237.1605236026254;
 Thu, 12 Nov 2020 18:53:46 -0800 (PST)
Date:   Thu, 12 Nov 2020 18:53:32 -0800
In-Reply-To: <cover.1605235762.git.pcc@google.com>
Message-Id: <be8f3680ef2d0a1a120994e3ae0b11d82f373279.1605235762.git.pcc@google.com>
Mime-Version: 1.0
References: <cover.1605235762.git.pcc@google.com>
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
Subject: [PATCH v16 2/6] parisc: start using signal-defs.h
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


Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFF8C2A3B4B
	for <lists+linux-api@lfdr.de>; Tue,  3 Nov 2020 05:10:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725958AbgKCEKI (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 2 Nov 2020 23:10:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725940AbgKCEKI (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 2 Nov 2020 23:10:08 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 021C7C0617A6
        for <linux-api@vger.kernel.org>; Mon,  2 Nov 2020 20:10:08 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id a12so16560185ybc.20
        for <linux-api@vger.kernel.org>; Mon, 02 Nov 2020 20:10:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=59sGcNP4h61z0LUyEOMh2LU3GdIsYbG4zMxVp1QCZaQ=;
        b=nhcnUQV+Byb3ifYqbQkCCg8IY9rPRL0347EucNliC0NqmvFmaiBkmyZp5cIvQ9hlIw
         IyLzUKkOXBOhAGSHs/09QezCh7ljT2ztGTwV9S3iePR7Z6StEye3HcXwi6x6jS1e7/sR
         FDhJG2priVeJ9iuszueKBTOm8HosvQJAZBPSwLJWdZKMubyYMdGMLlFsWEKYlq3z1FKR
         Z6YpdC/L31XgeIySGH/JAOrQ6GoYqTpuGr6Xwn3QEd2LXFgMyIx2QHMvFxl8jVQRk6Ec
         jHwc0SohuSb5WmIQwbjIdyFk2TAEZyNOBtKh/mP8AL4nuBUG6lXxQcnSNBoU3BJefZGY
         KRCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=59sGcNP4h61z0LUyEOMh2LU3GdIsYbG4zMxVp1QCZaQ=;
        b=VyaCko0nyh4W0jUUiv8sTadFeWCgJRbzPEJayMLFXqfhmRcH42hZYEI8P58rWV9IO0
         HAhhewqwA25+nyijHIB+hUrbcw9xBUAcYlp3do1pcorFA2Iq3OOktAjy8Kk7kI+Dulbn
         NuL2IoWtD9IXvpQ5wAJ9hRUROP50Gt86BscScuGK1d4G1pdjZbwQQce9bSWdviogaxsR
         o1rT9lvGgvMk4kT66UfWDxPL4Cm6DKcVv2oz3PyLxznDZ/wMl2HPyUUzWtkiZfklM6oT
         0e0dkgteD1kurDWqkcaaDn6B/npfIDpmwvl4fL//kyqzlp6pngC46c2ADnvXrkyEzw5d
         w9OQ==
X-Gm-Message-State: AOAM533/fYpGgY2HdVHcZqMXeicTX+HO0VWeuCvOHLl/wpcnepSM3P7X
        mdOW3j111dFE8E0XiNRhvrOINNg=
X-Google-Smtp-Source: ABdhPJwV8ieWMf2XUr77nrZx/jVanpdK1gWvrJKo+dNmFv+nBgOFcbPfJhQ5TN8IAM8eLFXXT5N2Z+c=
Sender: "pcc via sendgmr" <pcc@pcc-desktop.svl.corp.google.com>
X-Received: from pcc-desktop.svl.corp.google.com ([2620:15c:2ce:0:7220:84ff:fe09:385a])
 (user=pcc job=sendgmr) by 2002:a25:9701:: with SMTP id d1mr24145918ybo.409.1604376607226;
 Mon, 02 Nov 2020 20:10:07 -0800 (PST)
Date:   Mon,  2 Nov 2020 20:09:38 -0800
In-Reply-To: <cover.1604376407.git.pcc@google.com>
Message-Id: <e67e653cd06c573e932e7d72223dd7d48fcd21d3.1604376407.git.pcc@google.com>
Mime-Version: 1.0
References: <cover.1604376407.git.pcc@google.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [PATCH v13 2/8] parisc: start using signal-defs.h
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


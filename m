Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC8EA35EC97
	for <lists+linux-api@lfdr.de>; Wed, 14 Apr 2021 07:55:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347991AbhDNFzR (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 14 Apr 2021 01:55:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233339AbhDNFzQ (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 14 Apr 2021 01:55:16 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC378C061574;
        Tue, 13 Apr 2021 22:54:55 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id j7so4222248pgi.3;
        Tue, 13 Apr 2021 22:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kz+2y2O3gxdpZ0DuYw6Aqbtz8RqP4p8r4SUXEVxAEjc=;
        b=gAzbxW5mGOxCiuogT7ZmDaQeABjlxmLbc9dFUuv/vUNLgVbEgZIzH/U4JQCETVBH0R
         wi8JTjPXSv51Np6samyY61aeyWtlFstkUoWu0dPAwVdaoTqFmfE8pzkbDB35Dicbzmsw
         wGzXMWqxc+u8mraJzUvYRIyQ1pp0Q520rOVjs05qspQzSBhS24Cx1Y8X3OWrZUmVwCER
         zmiEuZBfbEzLfS15NHq06AU6s6k03Rc9zp2+p2wNGKfd9qsF2oMKYRG9wazsX1Bbz7ti
         TbPnmEVHtOfY+Ck2DuzwH6pK4pSLAJn5Czxz8JuveDLrAn/svBks4WZxroBtXUl41dI4
         tVVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kz+2y2O3gxdpZ0DuYw6Aqbtz8RqP4p8r4SUXEVxAEjc=;
        b=dxUOmgT0mWS687Nu6WP48ut579OqTHSMTg02QhXMKDhMtkT043k7kxinmpcsa8v4bq
         Zd67gG6+Iki1reFzEfOVS7+183e5P2PjO8Awt+MLjW9eMKWUu78NEiKG+GkmbUYz+lM0
         OCa1piZFPTDjrOhr92yn+Wi92YWlS/92DQ4/c2IZoUbXH86pi2+osYYxLvfM6StnKA0D
         A/ApWGTkZF/aqmY9x5MXHOoycuekon55N7zIl248SqU//XBBLyCTMvn93Y7MhaoYkVs+
         O8U8+is6TrmvqwVlIwZzr6QRe2EA1gQsVUAL9MOpzdBWFcG4PM9kGAzu8RoZLHWHDauG
         QD3g==
X-Gm-Message-State: AOAM533lnBfzj1fvrWAwQCpoD/7ovzkgU0rG/0tmCoWQQDiF67iJI3ZX
        /wIzzw/1efR2XRSBYXH2tQZWqJM9a5ES5hxm
X-Google-Smtp-Source: ABdhPJxeGX/lbWAFOpxLwjjnPfOzM9aCexo0emH5GWQfuu+lpIogaOnY38Jq+PTKfqA9j70+OBRHsA==
X-Received: by 2002:a63:ee54:: with SMTP id n20mr19101537pgk.415.1618379694969;
        Tue, 13 Apr 2021 22:54:54 -0700 (PDT)
Received: from laptop.hsd1.wa.comcast.net ([2601:600:8500:5f14:d627:c51e:516e:a105])
        by smtp.gmail.com with ESMTPSA id u17sm13728969pfm.113.2021.04.13.22.54.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 22:54:54 -0700 (PDT)
From:   Andrei Vagin <avagin@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Cc:     linux-um@lists.infradead.org, criu@openvz.org, avagin@google.com,
        Andrei Vagin <avagin@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Ingo Molnar <mingo@redhat.com>, Jeff Dike <jdike@addtoit.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Richard Weinberger <richard@nod.at>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 1/4] signal: add a helper to restore a process state from sigcontex
Date:   Tue, 13 Apr 2021 22:52:14 -0700
Message-Id: <20210414055217.543246-2-avagin@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210414055217.543246-1-avagin@gmail.com>
References: <20210414055217.543246-1-avagin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

It will be used to implement process_vm_exec.

Signed-off-by: Andrei Vagin <avagin@gmail.com>
---
 arch/x86/kernel/signal.c | 78 ++++++++++++++++++++++------------------
 1 file changed, 43 insertions(+), 35 deletions(-)

diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
index be0d7d4152ec..cc269a20dd5f 100644
--- a/arch/x86/kernel/signal.c
+++ b/arch/x86/kernel/signal.c
@@ -79,51 +79,43 @@ static void force_valid_ss(struct pt_regs *regs)
 # define CONTEXT_COPY_SIZE	sizeof(struct sigcontext)
 #endif
 
-static int restore_sigcontext(struct pt_regs *regs,
-			      struct sigcontext __user *usc,
+static int __restore_sigcontext(struct pt_regs *regs,
+			      struct sigcontext __user *sc,
 			      unsigned long uc_flags)
 {
-	struct sigcontext sc;
-
-	/* Always make any pending restarted system calls return -EINTR */
-	current->restart_block.fn = do_no_restart_syscall;
-
-	if (copy_from_user(&sc, usc, CONTEXT_COPY_SIZE))
-		return -EFAULT;
-
 #ifdef CONFIG_X86_32
-	set_user_gs(regs, sc.gs);
-	regs->fs = sc.fs;
-	regs->es = sc.es;
-	regs->ds = sc.ds;
+	set_user_gs(regs, sc->gs);
+	regs->fs = sc->fs;
+	regs->es = sc->es;
+	regs->ds = sc->ds;
 #endif /* CONFIG_X86_32 */
 
-	regs->bx = sc.bx;
-	regs->cx = sc.cx;
-	regs->dx = sc.dx;
-	regs->si = sc.si;
-	regs->di = sc.di;
-	regs->bp = sc.bp;
-	regs->ax = sc.ax;
-	regs->sp = sc.sp;
-	regs->ip = sc.ip;
+	regs->bx = sc->bx;
+	regs->cx = sc->cx;
+	regs->dx = sc->dx;
+	regs->si = sc->si;
+	regs->di = sc->di;
+	regs->bp = sc->bp;
+	regs->ax = sc->ax;
+	regs->sp = sc->sp;
+	regs->ip = sc->ip;
 
 #ifdef CONFIG_X86_64
-	regs->r8 = sc.r8;
-	regs->r9 = sc.r9;
-	regs->r10 = sc.r10;
-	regs->r11 = sc.r11;
-	regs->r12 = sc.r12;
-	regs->r13 = sc.r13;
-	regs->r14 = sc.r14;
-	regs->r15 = sc.r15;
+	regs->r8 = sc->r8;
+	regs->r9 = sc->r9;
+	regs->r10 = sc->r10;
+	regs->r11 = sc->r11;
+	regs->r12 = sc->r12;
+	regs->r13 = sc->r13;
+	regs->r14 = sc->r14;
+	regs->r15 = sc->r15;
 #endif /* CONFIG_X86_64 */
 
 	/* Get CS/SS and force CPL3 */
-	regs->cs = sc.cs | 0x03;
-	regs->ss = sc.ss | 0x03;
+	regs->cs = sc->cs | 0x03;
+	regs->ss = sc->ss | 0x03;
 
-	regs->flags = (regs->flags & ~FIX_EFLAGS) | (sc.flags & FIX_EFLAGS);
+	regs->flags = (regs->flags & ~FIX_EFLAGS) | (sc->flags & FIX_EFLAGS);
 	/* disable syscall checks */
 	regs->orig_ax = -1;
 
@@ -136,10 +128,26 @@ static int restore_sigcontext(struct pt_regs *regs,
 		force_valid_ss(regs);
 #endif
 
-	return fpu__restore_sig((void __user *)sc.fpstate,
+	return fpu__restore_sig((void __user *)sc->fpstate,
 			       IS_ENABLED(CONFIG_X86_32));
 }
 
+static int restore_sigcontext(struct pt_regs *regs,
+			      struct sigcontext __user *usc,
+			      unsigned long uc_flags)
+{
+	struct sigcontext sc;
+
+	/* Always make any pending restarted system calls return -EINTR */
+	current->restart_block.fn = do_no_restart_syscall;
+
+	if (copy_from_user(&sc, usc, CONTEXT_COPY_SIZE))
+		return -EFAULT;
+
+	return __restore_sigcontext(regs, &sc, uc_flags);
+}
+
+
 static __always_inline int
 __unsafe_setup_sigcontext(struct sigcontext __user *sc, void __user *fpstate,
 		     struct pt_regs *regs, unsigned long mask)
-- 
2.29.2


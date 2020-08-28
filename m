Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFC0E2559E4
	for <lists+linux-api@lfdr.de>; Fri, 28 Aug 2020 14:16:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729123AbgH1MQa (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 28 Aug 2020 08:16:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726904AbgH1MQ1 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 28 Aug 2020 08:16:27 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD408C061264;
        Fri, 28 Aug 2020 05:16:26 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id c142so498317pfb.7;
        Fri, 28 Aug 2020 05:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BPWyeQjOL84Jb5AfPDrFdN4woon9x0ZwzLXbpOLTTvw=;
        b=oZj2kw/tuWcySMJ3pIpznfWs1Tb76fRPK+UPKfChBdpRWtKNKZM71bcgVXOiXWeV8S
         metA9nojJNE/wVZF7Sn2L6B88MV2zKqk4/I8pqzJ9ffk+/0lguyBVAQsTr2zUIxEtmik
         vnyw7nu1eir0ZWAX1+ZAyWmkWaH2Oq9K53trAB6TcY5CzRVAdeUAqSCV1myf8xEa4I7B
         4I/ou0TbSQuoQp9M5pgfi7KgJluF5CJgAyTKDJ02qbUCPD9aCqWrYwwo56FZl4ML6OKB
         TQAArFggP3VkMgGwmLwpGOp+IkxOEtnNiOSeHRiA4/qQpLMEsfmp2HLpNVWLXo4S8ubp
         V3kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BPWyeQjOL84Jb5AfPDrFdN4woon9x0ZwzLXbpOLTTvw=;
        b=ZRtK4eXiRscpwWpBYWcoaXAxmmKFsRFCrosyl7FfVkhdD+PbqpGTCMIvmqSYTvWoIV
         TOLtL4UCt4hC9JhRACvkLm6j0+GRYtV3FOoItZALvqaJYYtzkTrnuLERu8M8s8YtLtjw
         M4KJTDWxNgZBa2T6N0D28GpNEeg5uYZRw+xd4LFANPVh2D1WoG7zhwKxLZAYYt9nnS1t
         fX6qdFuhwLozw7M7l33d1+UtT0LvDA12Vx4Pl58u39TmETdXMGh+O5IWo58YW8RyKjIn
         ldAqrRKGLKyHqM9PxCQm04+63x24iBw/vlIOnvEXHsJJNGXxaanUYW4XuScMQ2QVCQ3s
         jpGg==
X-Gm-Message-State: AOAM532eM0LKGzfuW2S9z0TUI5tWbfTSyNxWaLhpUdIMzYLSg3VYob5R
        Iigc/faDchZvaZdppbrjDC40/n6+1FU=
X-Google-Smtp-Source: ABdhPJwlNyi2HHYjvilBjQHIXwHhmD+zLvJYyiC0r4Usr0k9psbQAuxr3ZWPb2W1OKeofbcRkVD2aw==
X-Received: by 2002:a63:455d:: with SMTP id u29mr447012pgk.178.1598616986108;
        Fri, 28 Aug 2020 05:16:26 -0700 (PDT)
Received: from gnu-cfl-2.localdomain (c-69-181-90-243.hsd1.ca.comcast.net. [69.181.90.243])
        by smtp.gmail.com with ESMTPSA id s6sm1172834pjz.17.2020.08.28.05.16.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2020 05:16:25 -0700 (PDT)
Received: from gnu-cfl-2.localdomain (localhost [IPv6:::1])
        by gnu-cfl-2.localdomain (Postfix) with ESMTP id CA5BA1A014F;
        Fri, 28 Aug 2020 05:16:24 -0700 (PDT)
From:   "H.J. Lu" <hjl.tools@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-api@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH] x86: Extend arch_prctl (int, ...) to 5 arguments
Date:   Fri, 28 Aug 2020 05:16:24 -0700
Message-Id: <20200828121624.108243-1-hjl.tools@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Extend x86 arch_prctl (int, ...) to 5 arguments so that more arguments
can be passed to the kernel in registers.  The initial usage is to support
shadow stack in Intel CET.  In the current glibc, there is no arch_prctl
wrapper for i386.  There are arch_prctl wrappers with 2 arguments for
x86-64 and x32.  Since the first user of the new arch_prctl extension is
the C library, there should be no issue with the extension.

Signed-off-by: H.J. Lu <hjl.tools@gmail.com>
---
 arch/x86/include/asm/proto.h |  3 ++-
 arch/x86/kernel/process.c    |  3 ++-
 arch/x86/kernel/process_32.c |  6 ++++--
 arch/x86/kernel/process_64.c | 13 +++++++++----
 4 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/arch/x86/include/asm/proto.h b/arch/x86/include/asm/proto.h
index 28996fe19301..98bcada76fac 100644
--- a/arch/x86/include/asm/proto.h
+++ b/arch/x86/include/asm/proto.h
@@ -36,6 +36,7 @@ void x86_report_nx(void);
 extern int reboot_force;
 
 long do_arch_prctl_common(struct task_struct *task, int option,
-			  unsigned long cpuid_enabled);
+			  unsigned long cpuid_enabled, unsigned long arg3,
+			  unsigned long arg4, unsigned long arg5);
 
 #endif /* _ASM_X86_PROTO_H */
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 994d8393f2f7..9f8bc3b9a495 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -972,7 +972,8 @@ unsigned long get_wchan(struct task_struct *p)
 }
 
 long do_arch_prctl_common(struct task_struct *task, int option,
-			  unsigned long cpuid_enabled)
+			  unsigned long cpuid_enabled, unsigned long arg3,
+			  unsigned long arg4, unsigned long arg5)
 {
 	switch (option) {
 	case ARCH_GET_CPUID:
diff --git a/arch/x86/kernel/process_32.c b/arch/x86/kernel/process_32.c
index 4f2f54e1281c..bd8d9c61b092 100644
--- a/arch/x86/kernel/process_32.c
+++ b/arch/x86/kernel/process_32.c
@@ -221,7 +221,9 @@ __switch_to(struct task_struct *prev_p, struct task_struct *next_p)
 	return prev_p;
 }
 
-SYSCALL_DEFINE2(arch_prctl, int, option, unsigned long, arg2)
+SYSCALL_DEFINE5(arch_prctl, int, option, unsigned long, arg2,
+		unsigned long, arg3, unsigned long, arg4,
+		unsigned long, arg5)
 {
-	return do_arch_prctl_common(current, option, arg2);
+	return do_arch_prctl_common(current, option, arg2, arg3, arg4, arg5);
 }
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index 9afefe325acb..6441aa912561 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -815,21 +815,26 @@ long do_arch_prctl_64(struct task_struct *task, int option, unsigned long arg2)
 	return ret;
 }
 
-SYSCALL_DEFINE2(arch_prctl, int, option, unsigned long, arg2)
+SYSCALL_DEFINE5(arch_prctl, int, option, unsigned long, arg2,
+		unsigned long, arg3, unsigned long, arg4,
+		unsigned long, arg5)
 {
 	long ret;
 
 	ret = do_arch_prctl_64(current, option, arg2);
 	if (ret == -EINVAL)
-		ret = do_arch_prctl_common(current, option, arg2);
+		ret = do_arch_prctl_common(current, option, arg2, arg3, arg4,
+					   arg5);
 
 	return ret;
 }
 
 #ifdef CONFIG_IA32_EMULATION
-COMPAT_SYSCALL_DEFINE2(arch_prctl, int, option, unsigned long, arg2)
+COMPAT_SYSCALL_DEFINE5(arch_prctl, int, option, unsigned long, arg2,
+		       unsigned long, arg3, unsigned long, arg4,
+		       unsigned long, arg5)
 {
-	return do_arch_prctl_common(current, option, arg2);
+	return do_arch_prctl_common(current, option, arg2, arg3, arg4, arg5);
 }
 #endif
 
-- 
2.26.2


Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09C6A4198C8
	for <lists+linux-api@lfdr.de>; Mon, 27 Sep 2021 18:21:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235339AbhI0QWl (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 27 Sep 2021 12:22:41 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:39550 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235341AbhI0QWk (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 27 Sep 2021 12:22:40 -0400
Received: from relay1.suse.de (relay1.suse.de [149.44.160.133])
        by smtp-out2.suse.de (Postfix) with ESMTP id B1E5520174;
        Mon, 27 Sep 2021 16:21:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1632759661; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=OhdVD9gOAiEfK7wpJLmapbTk6U8empUyrJJ+9sKjxDc=;
        b=UE0ndxT/7SMUQi2S12WiU1L8o3vezLNsivOroJUx3J6QMJZLqypB8enMbr/LXtEAwGfFAK
        NzJ4YnTh1xfRrxWsdPLZurdMg5t7WZFYMs4KALj0b0mNHEFMJXFyVTgeZZs4VR5x0dP06T
        Q0cDAVQEP9WHufbko8M+3o9EQbDZ9BY=
Received: from g78.suse.de (unknown [10.163.24.38])
        by relay1.suse.de (Postfix) with ESMTP id A3FD825D3E;
        Mon, 27 Sep 2021 16:20:58 +0000 (UTC)
From:   Richard Palethorpe <rpalethorpe@suse.com>
To:     x86@kernel.org
Cc:     Richard Palethorpe <rpalethorpe@suse.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>, rpalethorpe@richiejp.com,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        ltp@lists.linux.it
Subject: [PATCH] x86/entry/ia32: Ensure s32 is sign extended to s64
Date:   Mon, 27 Sep 2021 17:19:55 +0100
Message-Id: <20210927161955.28494-1-rpalethorpe@suse.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Presently ia32 registers stored in ptregs are unconditionally cast to
unsigned int by the ia32 stub. They are then cast to long when passed
to __se_sys*, but will not be sign extended.

This takes the sign of the syscall argument into account in the ia32
stub. It still casts to unsigned int to avoid implementation specific
behavior. However then casts to int or unsigned int as necessary. So
that the following cast to long sign extends the value.

This fixes the io_pgetevents02 LTP test when compiled with
-m32. Presently the systemcall io_pgetevents_time64 unexpectedly
accepts -1 for the maximum number of events. It doesn't appear other
systemcalls with signed arguments are effected because they all have
compat variants defined and wired up. A less general solution is to
wire up the systemcall:
https://lore.kernel.org/ltp/20210921130127.24131-1-rpalethorpe@suse.com/

Fixes: ebeb8c82ffaf ("syscalls/x86: Use 'struct pt_regs' based syscall calling for IA32_EMULATION and x32")
Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
Suggested-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/s390/include/asm/syscall_wrapper.h |  2 --
 arch/x86/include/asm/syscall_wrapper.h  | 25 +++++++++++++++++++++----
 include/linux/syscalls.h                |  1 +
 3 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/arch/s390/include/asm/syscall_wrapper.h b/arch/s390/include/asm/syscall_wrapper.h
index ad2c996e7e93..25ab58b0ded1 100644
--- a/arch/s390/include/asm/syscall_wrapper.h
+++ b/arch/s390/include/asm/syscall_wrapper.h
@@ -7,8 +7,6 @@
 #ifndef _ASM_S390_SYSCALL_WRAPPER_H
 #define _ASM_S390_SYSCALL_WRAPPER_H
 
-#define __SC_TYPE(t, a) t
-
 #define SYSCALL_PT_ARG6(regs, m, t1, t2, t3, t4, t5, t6)\
 	SYSCALL_PT_ARG5(regs, m, t1, t2, t3, t4, t5),	\
 		m(t6, (regs->gprs[7]))
diff --git a/arch/x86/include/asm/syscall_wrapper.h b/arch/x86/include/asm/syscall_wrapper.h
index 6a2827d0681f..811139a82b13 100644
--- a/arch/x86/include/asm/syscall_wrapper.h
+++ b/arch/x86/include/asm/syscall_wrapper.h
@@ -58,12 +58,29 @@ extern long __ia32_sys_ni_syscall(const struct pt_regs *regs);
 		,,regs->di,,regs->si,,regs->dx				\
 		,,regs->r10,,regs->r8,,regs->r9)			\
 
+
+/* SYSCALL_PT_ARGS is Adapted from s390x */
+#define SYSCALL_PT_ARG6(m, t1, t2, t3, t4, t5, t6)			\
+	SYSCALL_PT_ARG5(m, t1, t2, t3, t4, t5), m(t6, (regs->bp))
+#define SYSCALL_PT_ARG5(m, t1, t2, t3, t4, t5)				\
+	SYSCALL_PT_ARG4(m, t1, t2, t3, t4),  m(t5, (regs->di))
+#define SYSCALL_PT_ARG4(m, t1, t2, t3, t4)				\
+	SYSCALL_PT_ARG3(m, t1, t2, t3),  m(t4, (regs->si))
+#define SYSCALL_PT_ARG3(m, t1, t2, t3)					\
+	SYSCALL_PT_ARG2(m, t1, t2), m(t3, (regs->dx))
+#define SYSCALL_PT_ARG2(m, t1, t2)					\
+	SYSCALL_PT_ARG1(m, t1), m(t2, (regs->cx))
+#define SYSCALL_PT_ARG1(m, t1) m(t1, (regs->bx))
+#define SYSCALL_PT_ARGS(x, ...) SYSCALL_PT_ARG##x(__VA_ARGS__)
+
+#define __SC_COMPAT_CAST(t, a)						\
+	(__typeof(__builtin_choose_expr(__TYPE_IS_L(t), 0, 0U)))	\
+	(unsigned int)a
+
 /* Mapping of registers to parameters for syscalls on i386 */
 #define SC_IA32_REGS_TO_ARGS(x, ...)					\
-	__MAP(x,__SC_ARGS						\
-	      ,,(unsigned int)regs->bx,,(unsigned int)regs->cx		\
-	      ,,(unsigned int)regs->dx,,(unsigned int)regs->si		\
-	      ,,(unsigned int)regs->di,,(unsigned int)regs->bp)
+	SYSCALL_PT_ARGS(x, __SC_COMPAT_CAST,				\
+			__MAP(x, __SC_TYPE, __VA_ARGS__))		\
 
 #define __SYS_STUB0(abi, name)						\
 	long __##abi##_##name(const struct pt_regs *regs);		\
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 69c9a7010081..a492276a11f1 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -122,6 +122,7 @@ enum landlock_rule_type;
 #define __TYPE_IS_LL(t) (__TYPE_AS(t, 0LL) || __TYPE_AS(t, 0ULL))
 #define __SC_LONG(t, a) __typeof(__builtin_choose_expr(__TYPE_IS_LL(t), 0LL, 0L)) a
 #define __SC_CAST(t, a)	(__force t) a
+#define __SC_TYPE(t, a)	t
 #define __SC_ARGS(t, a)	a
 #define __SC_TEST(t, a) (void)BUILD_BUG_ON_ZERO(!__TYPE_IS_LL(t) && sizeof(t) > sizeof(long))
 
-- 
2.31.1


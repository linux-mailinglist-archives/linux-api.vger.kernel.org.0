Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 196963884F2
	for <lists+linux-api@lfdr.de>; Wed, 19 May 2021 04:50:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237116AbhESCvt (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 18 May 2021 22:51:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236512AbhESCvt (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 18 May 2021 22:51:49 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A3D9C06175F
        for <linux-api@vger.kernel.org>; Tue, 18 May 2021 19:50:30 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id g6-20020a17090adac6b029015d1a9a6f1aso2738584pjx.1
        for <linux-api@vger.kernel.org>; Tue, 18 May 2021 19:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=cWQFzxhZycEzz2TPKI8LNP/whPnYVsPv2PnECv9BXUc=;
        b=cZow6f+1zRszSqH/3ePyeyl1icp8IwEGnsZRWPYmD0xy+6zHngx87MPKP/+vbU1qvP
         Tx8p3qqB0SeFb/b5nyx2/NyDayGcMY5w/ScjbKk4z/iFNK6QvVouB6vpA5qDeRdOMw+i
         KbXJ5BGsizsaJs0KCzwbjFCAz8X7CmJiFmCdPwPsmQ2IqmstQuPYZDAxJuTXdfEMkyNI
         3gNMLCzcXj5RyqG2hXAX9oMdpyx27dehDqLvHHLS+2Os9GRvReK2FEY5e03/ZylauuSA
         ECaY3cgOpZnWIyygQQ+DuBgO0jOVDWwc/L/uWfamvFETOSt5VhXEQvme7jN27PRwIG13
         hdWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=cWQFzxhZycEzz2TPKI8LNP/whPnYVsPv2PnECv9BXUc=;
        b=Oyb4LXD4uzznYFHNLqT7x70blfb2I99NUPAEMfbKXJIVRM5d8mI0KFpdNlXPDDdIb/
         2/ESw1+FMJAVwWT0SEbRgROXALmvelXdj3Qoykzw8xvXld+xUb9+KridvQ/7Jzh7RzZ0
         kS6h87zAikAOkjwGMlK8syrf46iKa37S3vujyQS8UVWiBIDM72ct8kAl2OwFXLS48aGD
         Rm/ZW6PmUXZqPM1RCJoJNhNairrrcmkSRe/Hzu7X+lF3C/8Etx1aLxFV8tDByLnbVajt
         hGxjQ9Vp52kMZEDmXrxH8waDI+a/pe/y6xHaOlHR/SO1KXCL49pRNNiHE5RQTaSTKdP9
         JRuQ==
X-Gm-Message-State: AOAM532n9gx10E6YV8VRFZHDew8iulpTF8QzAVk7TLVVKspbq+jztthu
        lf6uEsY7zqnSU1azSVbCcUU=
X-Google-Smtp-Source: ABdhPJwDcXEMRseuSruQGmCaMPdDStr4laYhCXRJ1PsxjkPgfdindWrV3H9h/r7BFaOztH7tFGiGYg==
X-Received: by 2002:a17:90a:df8d:: with SMTP id p13mr8470070pjv.67.1621392629847;
        Tue, 18 May 2021 19:50:29 -0700 (PDT)
Received: from localhost (14-201-155-8.tpgi.com.au. [14.201.155.8])
        by smtp.gmail.com with ESMTPSA id s65sm14173897pjd.15.2021.05.18.19.50.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 19:50:29 -0700 (PDT)
Date:   Wed, 19 May 2021 12:50:24 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: Linux powerpc new system call instruction and ABI
To:     "Dmitry V. Levin" <ldv@altlinux.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     libc-dev@lists.llvm.org, linux-api@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, musl@lists.openwall.com,
        Matheus Castanho <msc@linux.ibm.com>, libc-alpha@sourceware.org
References: <20200611081203.995112-1-npiggin@gmail.com>
        <20210518231331.GA8464@altlinux.org>
In-Reply-To: <20210518231331.GA8464@altlinux.org>
MIME-Version: 1.0
Message-Id: <1621385544.nttlk5qugb.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Excerpts from Dmitry V. Levin's message of May 19, 2021 9:13 am:
> Hi,
>=20
> On Thu, Jun 11, 2020 at 06:12:01PM +1000, Nicholas Piggin wrote:
> [...]
>> - Error handling: The consensus among kernel, glibc, and musl is to move=
 to
>>   using negative return values in r3 rather than CR0[SO]=3D1 to indicate=
 error,
>>   which matches most other architectures, and is closer to a function ca=
ll.
>=20
> Apparently, the patchset merged by commit v5.9-rc1~100^2~164 was
> incomplete: all functions defined in arch/powerpc/include/asm/ptrace.h an=
d
> arch/powerpc/include/asm/syscall.h that use ccr are broken when scv is us=
ed.
> This includes syscall_get_error() and all its users including
> PTRACE_GET_SYSCALL_INFO API, which in turn makes strace unusable
> when scv is used.
>=20
> See also https://bugzilla.redhat.com/1929836

I see, thanks. Using latest strace from github.com, the attached kernel
patch makes strace -k check results a lot greener.

Some of the remaining failing tests look like this (I didn't look at all
of them yet):

signal(SIGUSR1, 0xfacefeeddeadbeef)     =3D 0 (SIG_DFL)
write(1, "signal(SIGUSR1, 0xfacefeeddeadbe"..., 50signal(SIGUSR1, 0xfacefee=
ddeadbeef) =3D 0 (SIG_DFL)
) =3D 50
signal(SIGUSR1, SIG_IGN)                =3D 0xfacefeeddeadbeef
write(2, "errno2name.c:461: unknown errno "..., 41errno2name.c:461: unknown=
 errno 559038737) =3D 41
write(2, ": Unknown error 559038737\n", 26: Unknown error 559038737
) =3D 26
exit_group(1)                           =3D ?

I think the problem is glibc testing for -ve, but it should be comparing
against -4095 (+cc Matheus)

  #define RET_SCV \
      cmpdi r3,0; \
      bgelr+; \
      neg r3,r3;

With this patch, I think the ptrace ABI should mostly be fixed. I think=20
a problem remains with applications that look at system call return=20
registers directly and have powerpc specific error cases. Those probably
will just need to be updated unfortunately. Michael thought it might be
possible to return an indication via ptrace somehow that the syscall is
using a new ABI, so such apps can be updated to test for it. I don't=20
know how that would be done.

Thanks,
Nick

--
diff --git a/arch/powerpc/include/asm/ptrace.h b/arch/powerpc/include/asm/p=
trace.h
index 9c9ab2746168..b476a685f066 100644
--- a/arch/powerpc/include/asm/ptrace.h
+++ b/arch/powerpc/include/asm/ptrace.h
@@ -19,6 +19,7 @@
 #ifndef _ASM_POWERPC_PTRACE_H
 #define _ASM_POWERPC_PTRACE_H
=20
+#include <linux/err.h>
 #include <uapi/asm/ptrace.h>
 #include <asm/asm-const.h>
=20
@@ -152,25 +153,6 @@ extern unsigned long profile_pc(struct pt_regs *regs);
 long do_syscall_trace_enter(struct pt_regs *regs);
 void do_syscall_trace_leave(struct pt_regs *regs);
=20
-#define kernel_stack_pointer(regs) ((regs)->gpr[1])
-static inline int is_syscall_success(struct pt_regs *regs)
-{
-	return !(regs->ccr & 0x10000000);
-}
-
-static inline long regs_return_value(struct pt_regs *regs)
-{
-	if (is_syscall_success(regs))
-		return regs->gpr[3];
-	else
-		return -regs->gpr[3];
-}
-
-static inline void regs_set_return_value(struct pt_regs *regs, unsigned lo=
ng rc)
-{
-	regs->gpr[3] =3D rc;
-}
-
 #ifdef __powerpc64__
 #define user_mode(regs) ((((regs)->msr) >> MSR_PR_LG) & 0x1)
 #else
@@ -235,6 +217,31 @@ static __always_inline void set_trap_norestart(struct =
pt_regs *regs)
 	regs->trap |=3D 0x1;
 }
=20
+#define kernel_stack_pointer(regs) ((regs)->gpr[1])
+static inline int is_syscall_success(struct pt_regs *regs)
+{
+	if (trap_is_scv(regs))
+		return !IS_ERR_VALUE((unsigned long)regs->gpr[3]);
+	else
+		return !(regs->ccr & 0x10000000);
+}
+
+static inline long regs_return_value(struct pt_regs *regs)
+{
+	if (trap_is_scv(regs))
+		return regs->gpr[3];
+
+	if (is_syscall_success(regs))
+		return regs->gpr[3];
+	else
+		return -regs->gpr[3];
+}
+
+static inline void regs_set_return_value(struct pt_regs *regs, unsigned lo=
ng rc)
+{
+	regs->gpr[3] =3D rc;
+}
+
 #define arch_has_single_step()	(1)
 #define arch_has_block_step()	(true)
 #define ARCH_HAS_USER_SINGLE_STEP_REPORT
diff --git a/arch/powerpc/include/asm/syscall.h b/arch/powerpc/include/asm/=
syscall.h
index fd1b518eed17..e8b40149bf7e 100644
--- a/arch/powerpc/include/asm/syscall.h
+++ b/arch/powerpc/include/asm/syscall.h
@@ -41,11 +41,20 @@ static inline void syscall_rollback(struct task_struct =
*task,
 static inline long syscall_get_error(struct task_struct *task,
 				     struct pt_regs *regs)
 {
-	/*
-	 * If the system call failed,
-	 * regs->gpr[3] contains a positive ERRORCODE.
-	 */
-	return (regs->ccr & 0x10000000UL) ? -regs->gpr[3] : 0;
+	if (trap_is_scv(regs)) {
+		unsigned long error =3D regs->gpr[3];
+
+		if (task_is_32bit(task))
+			error =3D (long)(int)error;
+
+		return IS_ERR_VALUE(error) ? error : 0;
+	} else {
+		/*
+		 * If the system call failed,
+		 * regs->gpr[3] contains a positive ERRORCODE.
+		 */
+		return (regs->ccr & 0x10000000UL) ? -regs->gpr[3] : 0;
+	}
 }
=20
 static inline long syscall_get_return_value(struct task_struct *task,
@@ -58,18 +67,22 @@ static inline void syscall_set_return_value(struct task=
_struct *task,
 					    struct pt_regs *regs,
 					    int error, long val)
 {
-	/*
-	 * In the general case it's not obvious that we must deal with CCR
-	 * here, as the syscall exit path will also do that for us. However
-	 * there are some places, eg. the signal code, which check ccr to
-	 * decide if the value in r3 is actually an error.
-	 */
-	if (error) {
-		regs->ccr |=3D 0x10000000L;
-		regs->gpr[3] =3D error;
+	if (trap_is_scv(regs)) {
+		regs->gpr[3] =3D (long) error ?: val;
 	} else {
-		regs->ccr &=3D ~0x10000000L;
-		regs->gpr[3] =3D val;
+		/*
+		 * In the general case it's not obvious that we must deal with
+		 * CCR here, as the syscall exit path will also do that for us.
+		 * However there are some places, eg. the signal code, which
+		 * check ccr to decide if the value in r3 is actually an error.
+		 */
+		if (error) {
+			regs->ccr |=3D 0x10000000L;
+			regs->gpr[3] =3D error;
+		} else {
+			regs->ccr &=3D ~0x10000000L;
+			regs->gpr[3] =3D val;
+		}
 	}
 }
=20
diff --git a/arch/powerpc/include/asm/thread_info.h b/arch/powerpc/include/=
asm/thread_info.h
index b4ec6c7dd72e..c4bb9f305eaf 100644
--- a/arch/powerpc/include/asm/thread_info.h
+++ b/arch/powerpc/include/asm/thread_info.h
@@ -165,8 +165,10 @@ static inline bool test_thread_local_flags(unsigned in=
t flags)
=20
 #ifdef CONFIG_COMPAT
 #define is_32bit_task()	(test_thread_flag(TIF_32BIT))
+#define task_is_32bit(task) (test_tsk_thread_flag(task, TIF_32BIT))
 #else
 #define is_32bit_task()	(IS_ENABLED(CONFIG_PPC32))
+#define task_is_32bit(task) (IS_ENABLED(CONFIG_PPC32))
 #endif
=20
 #if defined(CONFIG_PPC64)

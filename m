Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40012290FCB
	for <lists+linux-api@lfdr.de>; Sat, 17 Oct 2020 08:01:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411808AbgJQGBh (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sat, 17 Oct 2020 02:01:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2411568AbgJQGBg (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sat, 17 Oct 2020 02:01:36 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73282C0613DE
        for <linux-api@vger.kernel.org>; Fri, 16 Oct 2020 17:12:59 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id z12so2406879qto.4
        for <linux-api@vger.kernel.org>; Fri, 16 Oct 2020 17:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=qwEoEKPmJc1tj+BPwD+iI+G1y4JwH1z2YmLFdsGqgCc=;
        b=XSJ/TZjJugasX3NsHBentjORzIZjmbW4W1RtjaXJSW3pZDCUoIbAkHKA4/3vMm1q1w
         Q5tAndQGj5kDPKj4IUgE+CCxtoUZ0rfVmlQrbop+EtvMOOwS+MjJJrs52KJItlS6U0Bx
         9QOGmS+hKxEvIJpWOiNoQmuSs2FhlCqoBUcrvY+piCPt5LSguJjHrSkObcE8ItupSiUS
         lxtHpupMKeSVjOA1ODVL/c42f5jwUDl4BTEw9uavAAaJD0YoZEZTU07r8HojdAH5mLJC
         FZbWLXLNhlmx5zTHhwVCZK5vX7+N6XtO5FjNE71rIsEu13yT1QIwN3pc8Z77HerVLNZT
         PxRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=qwEoEKPmJc1tj+BPwD+iI+G1y4JwH1z2YmLFdsGqgCc=;
        b=Xj0JYB77yltLHXWdoCcGh1Tqv56LLae85yjWCSNby9uoUBM3umpf6CMvcwsq3/eSlr
         P4qlBmivpuCR3o2CVcNWWIpBUrhstRYKrqZtbltVF2gGZr099fTEHPlrbsCmQEjZps09
         QYWDkK6qQgTZ/PXdH3oxEsJ//hLMcFJXFs8eASkUbunXO3bquDTDETkXsRxxvMMB8noQ
         ifJ0hAOOftWHqP04b1/NSNZdYJbuuPajz2gOGlQcEp7kzHN+RZVbl0eX6vZJYQWSJrZs
         POq8FyNKgeJF6UA3M2PgQtgc16ug5gOybiEg5xjZwEjLSgy+wlaL9QcjlARJL3xhNlI0
         P94w==
X-Gm-Message-State: AOAM532uaJ3X01PNhT4c/rV2yntBCs5qwwUj1HKuGPSIUXiY12zgjm+m
        ZagYmf9j+T1vG/GJifKhloNel+s=
X-Google-Smtp-Source: ABdhPJw6cnQMh3iT8u1+UOPRnpsfFuQlrd5IDufexOTWGhYyQ31XtCbCi6sL9tlTTVHdGEgYQEf74Lg=
Sender: "pcc via sendgmr" <pcc@pcc-desktop.svl.corp.google.com>
X-Received: from pcc-desktop.svl.corp.google.com ([2620:15c:2ce:0:7220:84ff:fe09:385a])
 (user=pcc job=sendgmr) by 2002:ad4:5843:: with SMTP id de3mr6560716qvb.12.1602893578577;
 Fri, 16 Oct 2020 17:12:58 -0700 (PDT)
Date:   Fri, 16 Oct 2020 17:12:32 -0700
In-Reply-To: <cover.1602892799.git.pcc@google.com>
Message-Id: <7cc72abf960871135bc6e7fb11c8fc747401957b.1602892799.git.pcc@google.com>
Mime-Version: 1.0
References: <cover.1602892799.git.pcc@google.com>
X-Mailer: git-send-email 2.29.0.rc1.297.gfa9743e501-goog
Subject: [PATCH v12 7/8] signal: define the field siginfo.si_xflags
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

This field will contain flags that may be used by signal handlers to
determine whether other fields in the _sigfault portion of siginfo are
valid. An example use case is the following patch, which introduces
the si_addr_tag_bits{,_mask} fields.

A new sigcontext flag, SA_XFLAGS, is introduced in order to allow
a signal handler to require the kernel to set the field (but note
that the field will be set anyway if the kernel supports the flag,
regardless of its value). In combination with the previous patches,
this allows a userspace program to determine whether the kernel will
set the field.

It is possible for an si_xflags-unaware program to cause a signal
handler in an si_xflags-aware program to be called with a provided
siginfo data structure by using one of the following syscalls:

- ptrace(PTRACE_SETSIGINFO)
- pidfd_send_signal
- rt_sigqueueinfo
- rt_tgsigqueueinfo

So we need to prevent the si_xflags-unaware program from causing an
uninitialized read of si_xflags in the si_xflags-aware program when
it uses one of these syscalls.

The last three cases can be handled by observing that each of these
syscalls fails if si_code >= 0. We also observe that kill(2) and
tgkill(2) may be used to send a signal where si_code == 0 (SI_USER),
so we define si_xflags to only be valid if si_code > 0.

There is no such check on si_code in ptrace(PTRACE_SETSIGINFO), so
we make ptrace(PTRACE_SETSIGINFO) clear the si_xflags field if it
detects that the signal would use the _sigfault layout, and introduce
a new ptrace request type, PTRACE_SETSIGINFO2, that a si_xflags-aware
program may use to opt out of this behavior.

It is also possible for the kernel to inject a signal specified to
use _sigfault by calling force_sig (e.g. there are numerous calls to
force_sig(SIGSEGV)). In this case si_code is set to SI_KERNEL and the
_kill union member is used, so document that si_code must be < SI_KERNEL.

Ideally this field could have just been named si_flags, but that
name was already taken by ia64, so a different name was chosen.

I considered making ia64's si_flags a generic field and having it
appear at the end of _sigfault (in the same place as this patch has
si_xflags) on non-ia64, keeping it in the same place on ia64. ia64's
si_flags is a 32-bit field with only one flag bit allocated, so we
would have 31 bits to use if we do this. However, it seems simplest
to avoid entangling these fields.

Signed-off-by: Peter Collingbourne <pcc@google.com>
Link: https://linux-review.googlesource.com/id/Ide155ce29366c3eab2a944ae4c51205982e5b8b2
---
v12:
- Change type of si_xflags to u32 to avoid increasing alignment
- Add si_xflags to signal_compat.c test cases

v11:
- update comment to say that si_code must > 0
- change ptrace(PTRACE_SETSIGINFO2) to take a flags argument

v10:
- make the new field compatible with the various ways
  that a siginfo can be injected from another process
- eliminate some duplication by adding a refactoring patch
  before this one

 arch/powerpc/platforms/powernv/vas-fault.c |  1 +
 arch/x86/kernel/signal_compat.c            |  7 +++--
 include/linux/compat.h                     |  2 ++
 include/linux/signal_types.h               |  2 +-
 include/uapi/asm-generic/siginfo.h         |  4 +++
 include/uapi/asm-generic/signal-defs.h     |  4 +++
 include/uapi/linux/ptrace.h                | 12 ++++++++
 kernel/ptrace.c                            | 32 ++++++++++++++++++----
 kernel/signal.c                            |  3 ++
 9 files changed, 58 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/vas-fault.c b/arch/powerpc/platforms/powernv/vas-fault.c
index 3d21fce254b7..3bbb335561f5 100644
--- a/arch/powerpc/platforms/powernv/vas-fault.c
+++ b/arch/powerpc/platforms/powernv/vas-fault.c
@@ -154,6 +154,7 @@ static void update_csb(struct vas_window *window,
 	info.si_errno = EFAULT;
 	info.si_code = SEGV_MAPERR;
 	info.si_addr = csb_addr;
+	info.si_xflags = 0;
 
 	/*
 	 * process will be polling on csb.flags after request is sent to
diff --git a/arch/x86/kernel/signal_compat.c b/arch/x86/kernel/signal_compat.c
index ddfd919be46c..243a8cc3b41b 100644
--- a/arch/x86/kernel/signal_compat.c
+++ b/arch/x86/kernel/signal_compat.c
@@ -121,8 +121,8 @@ static inline void signal_compat_build_tests(void)
 #endif
 
 	CHECK_CSI_OFFSET(_sigfault);
-	CHECK_CSI_SIZE  (_sigfault, 4*sizeof(int));
-	CHECK_SI_SIZE   (_sigfault, 8*sizeof(int));
+	CHECK_CSI_SIZE  (_sigfault, 8*sizeof(int));
+	CHECK_SI_SIZE   (_sigfault, 16*sizeof(int));
 
 	BUILD_BUG_ON(offsetof(siginfo_t, si_addr) != 0x10);
 	BUILD_BUG_ON(offsetof(compat_siginfo_t, si_addr) != 0x0C);
@@ -138,6 +138,9 @@ static inline void signal_compat_build_tests(void)
 	BUILD_BUG_ON(offsetof(siginfo_t, si_pkey) != 0x20);
 	BUILD_BUG_ON(offsetof(compat_siginfo_t, si_pkey) != 0x14);
 
+	BUILD_BUG_ON(offsetof(siginfo_t, si_xflags) != 0x48);
+	BUILD_BUG_ON(offsetof(compat_siginfo_t, si_xflags) != 0x28);
+
 	CHECK_CSI_OFFSET(_sigpoll);
 	CHECK_CSI_SIZE  (_sigpoll, 2*sizeof(int));
 	CHECK_SI_SIZE   (_sigpoll, 4*sizeof(int));
diff --git a/include/linux/compat.h b/include/linux/compat.h
index 14d514233e1d..ea77a24ce6a2 100644
--- a/include/linux/compat.h
+++ b/include/linux/compat.h
@@ -236,7 +236,9 @@ typedef struct compat_siginfo {
 					char _dummy_pkey[__COMPAT_ADDR_BND_PKEY_PAD];
 					u32 _pkey;
 				} _addr_pkey;
+				compat_uptr_t _pad[6];
 			};
+			u32 _xflags;
 		} _sigfault;
 
 		/* SIGPOLL */
diff --git a/include/linux/signal_types.h b/include/linux/signal_types.h
index a7887ad84d36..75ca861d982a 100644
--- a/include/linux/signal_types.h
+++ b/include/linux/signal_types.h
@@ -78,6 +78,6 @@ struct ksignal {
 
 #define UAPI_SA_FLAGS                                                          \
 	(SA_NOCLDSTOP | SA_NOCLDWAIT | SA_SIGINFO | SA_ONSTACK | SA_RESTART |  \
-	 SA_NODEFER | SA_RESETHAND | __ARCH_UAPI_SA_FLAGS)
+	 SA_NODEFER | SA_RESETHAND | SA_XFLAGS | __ARCH_UAPI_SA_FLAGS)
 
 #endif /* _LINUX_SIGNAL_TYPES_H */
diff --git a/include/uapi/asm-generic/siginfo.h b/include/uapi/asm-generic/siginfo.h
index 7aacf9389010..8158d5df666a 100644
--- a/include/uapi/asm-generic/siginfo.h
+++ b/include/uapi/asm-generic/siginfo.h
@@ -91,7 +91,9 @@ union __sifields {
 				char _dummy_pkey[__ADDR_BND_PKEY_PAD];
 				__u32 _pkey;
 			} _addr_pkey;
+			void *_pad[6];
 		};
+		__u32 _xflags;
 	} _sigfault;
 
 	/* SIGPOLL */
@@ -152,6 +154,8 @@ typedef struct siginfo {
 #define si_trapno	_sifields._sigfault._trapno
 #endif
 #define si_addr_lsb	_sifields._sigfault._addr_lsb
+/* si_xflags is only valid if 0 < si_code < SI_KERNEL */
+#define si_xflags	_sifields._sigfault._xflags
 #define si_lower	_sifields._sigfault._addr_bnd._lower
 #define si_upper	_sifields._sigfault._addr_bnd._upper
 #define si_pkey		_sifields._sigfault._addr_pkey._pkey
diff --git a/include/uapi/asm-generic/signal-defs.h b/include/uapi/asm-generic/signal-defs.h
index 0126ebda4d31..cd522819f4ba 100644
--- a/include/uapi/asm-generic/signal-defs.h
+++ b/include/uapi/asm-generic/signal-defs.h
@@ -20,6 +20,9 @@
  * so this bit allows flag bit support to be detected from userspace while
  * allowing an old kernel to be distinguished from a kernel that supports every
  * flag bit.
+ * SA_XFLAGS indicates that the signal handler requires the siginfo.si_xflags
+ * field to be valid. Note that if the kernel supports SA_XFLAGS, the field will
+ * be valid regardless of the value of this flag.
  *
  * SA_ONESHOT and SA_NOMASK are the historical Linux names for the Single
  * Unix names RESETHAND and NODEFER respectively.
@@ -49,6 +52,7 @@
 #define SA_RESETHAND	0x80000000
 #endif
 #define SA_UNSUPPORTED	0x00000400
+#define SA_XFLAGS	0x00000800
 
 #define SA_NOMASK	SA_NODEFER
 #define SA_ONESHOT	SA_RESETHAND
diff --git a/include/uapi/linux/ptrace.h b/include/uapi/linux/ptrace.h
index a71b6e3b03eb..93946edf0139 100644
--- a/include/uapi/linux/ptrace.h
+++ b/include/uapi/linux/ptrace.h
@@ -101,6 +101,18 @@ struct ptrace_syscall_info {
 	};
 };
 
+#define PTRACE_SETSIGINFO2	0x420f
+/*
+ * These flags are passed as the addr argument to ptrace.
+ */
+
+/*
+ * Asserts that the caller is aware of the field siginfo.si_xflags. Prevents
+ * the kernel from automatically setting the field to 0 when the signal uses
+ * a sigfault layout.
+ */
+#define PTRACE_SIGINFO_XFLAGS	0x1
+
 /*
  * These values are stored in task->ptrace_message
  * by tracehook_report_syscall_* to describe the current syscall-stop.
diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index 43d6179508d6..85b5b4e38661 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -687,18 +687,32 @@ static int ptrace_getsiginfo(struct task_struct *child, kernel_siginfo_t *info)
 	return error;
 }
 
-static int ptrace_setsiginfo(struct task_struct *child, const kernel_siginfo_t *info)
+static int ptrace_setsiginfo(struct task_struct *child, unsigned long flags,
+			     kernel_siginfo_t *info)
 {
-	unsigned long flags;
+	unsigned long lock_flags;
 	int error = -ESRCH;
 
-	if (lock_task_sighand(child, &flags)) {
+	if (flags & ~PTRACE_SIGINFO_XFLAGS) {
+		return -EINVAL;
+	}
+
+	/*
+	 * If the caller is unaware of si_xflags and we're using a layout that
+	 * requires it, set it to 0 which means "no fields are available".
+	 */
+	if (!(flags & PTRACE_SIGINFO_XFLAGS) &&
+	    siginfo_layout_is_fault(
+		    siginfo_layout(info->si_signo, info->si_code)))
+		info->si_xflags = 0;
+
+	if (lock_task_sighand(child, &lock_flags)) {
 		error = -EINVAL;
 		if (likely(child->last_siginfo != NULL)) {
 			copy_siginfo(child->last_siginfo, info);
 			error = 0;
 		}
-		unlock_task_sighand(child, &flags);
+		unlock_task_sighand(child, &lock_flags);
 	}
 	return error;
 }
@@ -1038,9 +1052,12 @@ int ptrace_request(struct task_struct *child, long request,
 		break;
 
 	case PTRACE_SETSIGINFO:
+		addr = 0;
+
+	case PTRACE_SETSIGINFO2:
 		ret = copy_siginfo_from_user(&siginfo, datavp);
 		if (!ret)
-			ret = ptrace_setsiginfo(child, &siginfo);
+			ret = ptrace_setsiginfo(child, addr, &siginfo);
 		break;
 
 	case PTRACE_GETSIGMASK: {
@@ -1347,10 +1364,13 @@ int compat_ptrace_request(struct task_struct *child, compat_long_t request,
 		break;
 
 	case PTRACE_SETSIGINFO:
+		addr = 0;
+
+	case PTRACE_SETSIGINFO2:
 		ret = copy_siginfo_from_user32(
 			&siginfo, (struct compat_siginfo __user *) datap);
 		if (!ret)
-			ret = ptrace_setsiginfo(child, &siginfo);
+			ret = ptrace_setsiginfo(child, addr, &siginfo);
 		break;
 #ifdef CONFIG_HAVE_ARCH_TRACEHOOK
 	case PTRACE_GETREGSET:
diff --git a/kernel/signal.c b/kernel/signal.c
index acdfd5a6d424..5c715a01942f 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1656,6 +1656,7 @@ static void set_sigfault_common_fields(struct kernel_siginfo *info, int sig,
 	info->si_errno = 0;
 	info->si_code = code;
 	info->si_addr = addr;
+	info->si_xflags = 0;
 }
 
 int force_sig_fault_to_task(int sig, int code, void __user *addr
@@ -3269,6 +3270,7 @@ void copy_siginfo_to_external32(struct compat_siginfo *to,
 #ifdef __ARCH_SI_TRAPNO
 		to->si_trapno = from->si_trapno;
 #endif
+		to->si_xflags = from->si_xflags;
 	}
 
 	switch (layout) {
@@ -3344,6 +3346,7 @@ static int post_copy_siginfo_from_user32(kernel_siginfo_t *to,
 #ifdef __ARCH_SI_TRAPNO
 		to->si_trapno = from->si_trapno;
 #endif
+		to->si_xflags = from->si_xflags;
 	}
 
 	switch (layout) {
-- 
2.29.0.rc1.297.gfa9743e501-goog


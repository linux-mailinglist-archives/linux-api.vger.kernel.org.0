Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBCC22A3B50
	for <lists+linux-api@lfdr.de>; Tue,  3 Nov 2020 05:10:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726042AbgKCEKT (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 2 Nov 2020 23:10:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725940AbgKCEKT (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 2 Nov 2020 23:10:19 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6F35C0617A6
        for <linux-api@vger.kernel.org>; Mon,  2 Nov 2020 20:10:17 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id l23so16477649ybl.23
        for <linux-api@vger.kernel.org>; Mon, 02 Nov 2020 20:10:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=oh08SfZTC31NmVbPsuxr1F22k8Dkrv4jx/jjMmRblto=;
        b=Sqge/AMO11IZz1IVu5/yiWToi6JKteyVUgbIA754B9dGk8+hDYBgprn6/fgXC+lqDK
         8Vh7MjX6rjOdvDEy1jO9hHLUU/S6/8Bi4YvqbRwHpRT5rByVng5s2fqCkYrEX/SbRsD+
         fvbMPfVaNWPt6JtdNTxhGtmv6SYAgv1NxJxOkW2Xlnm15JIjB0xeLyWoUgcCAUZ79bvb
         YQBwadmJTmVZxvVhjZt1u3nc1wTVCHY6xUdKIDK4vvApsqFMIfHxsN6e5glR16PckJXw
         SJXQT7kkx1gIW2zRSbuspXE50hfHNpDo1g8LPGcBhM2DfECiuCSKVUxp2nlkYE466dJM
         o17Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=oh08SfZTC31NmVbPsuxr1F22k8Dkrv4jx/jjMmRblto=;
        b=bmYlL7wgaOROx1XnWXcQPXOgTs0GtaqhWX4AwTyIzVWn2n3DVuCJD76UlbsKECWOSl
         aRM0wV9LRDg3Pmuj3yIGHpy6SF8WD2QnbBETE8RfbeVtXUaoDSrB+GRpV0AhWU3Y/dUu
         NDfe2UvKW2PU9+tK2w3VYa0muY4ztzzZ6TVWqodPecUJSya6mU6oPdKivru7jb8wo9UN
         pST/zdsvIhrQPvLg7Iw/nRiC58vusGHIeKwIGtTX3sq++AXywDWl+aDhZRS6SUAEGExY
         m6ZeuGHSO8Rb0Peu4YVsdUTsWo9BIBeOrETCprKPsOkj9D3E8c2xcIIe90kUgEO9oqi6
         mM1A==
X-Gm-Message-State: AOAM530Lo1ajAyC6cGKXS+OfQcuqIYif4VkPGV3TshY72cb5w/8QgOUP
        ASBDWK4XAWsCN6fCZO/cAqZ5T/0=
X-Google-Smtp-Source: ABdhPJxWgaMFCGIaWo4hjsQ1YsChL7zVu2H+6rj0mC9GHmHFMCcH1XZlvx2CrQHyivdNSdTcIXS8DLg=
Sender: "pcc via sendgmr" <pcc@pcc-desktop.svl.corp.google.com>
X-Received: from pcc-desktop.svl.corp.google.com ([2620:15c:2ce:0:7220:84ff:fe09:385a])
 (user=pcc job=sendgmr) by 2002:a25:c382:: with SMTP id t124mr27510412ybf.476.1604376616839;
 Mon, 02 Nov 2020 20:10:16 -0800 (PST)
Date:   Mon,  2 Nov 2020 20:09:43 -0800
In-Reply-To: <cover.1604376407.git.pcc@google.com>
Message-Id: <743fef80a8617378027d5d2b0538cfc36ea106a1.1604376407.git.pcc@google.com>
Mime-Version: 1.0
References: <cover.1604376407.git.pcc@google.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [PATCH v13 7/8] signal: define the field siginfo.si_faultflags
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

A new sigcontext flag, SA_FAULTFLAGS, is introduced in order to allow
a signal handler to require the kernel to set the field (but note
that the field will be set anyway if the kernel supports the flag,
regardless of its value). In combination with the previous patches,
this allows a userspace program to determine whether the kernel will
set the field.

It is possible for an si_faultflags-unaware program to cause a signal
handler in an si_faultflags-aware program to be called with a provided
siginfo data structure by using one of the following syscalls:

- ptrace(PTRACE_SETSIGINFO)
- pidfd_send_signal
- rt_sigqueueinfo
- rt_tgsigqueueinfo

So we need to prevent the si_faultflags-unaware program from causing an
uninitialized read of si_faultflags in the si_faultflags-aware program when
it uses one of these syscalls.

The last three cases can be handled by observing that each of these
syscalls fails if si_code >= 0. We also observe that kill(2) and
tgkill(2) may be used to send a signal where si_code == 0 (SI_USER),
so we define si_faultflags to only be valid if si_code > 0.

There is no such check on si_code in ptrace(PTRACE_SETSIGINFO), so
we make ptrace(PTRACE_SETSIGINFO) clear the si_faultflags field if it
detects that the signal would use the _sigfault layout, and introduce
a new ptrace request type, PTRACE_SETSIGINFO2, that a si_faultflags-aware
program may use to opt out of this behavior.

It is also possible for the kernel to inject a signal specified to
use _sigfault by calling force_sig (e.g. there are numerous calls to
force_sig(SIGSEGV)). In this case si_code is set to SI_KERNEL and the
_kill union member is used, so document that si_code must be < SI_KERNEL.

Ideally this field could have just been named si_flags, but that
name was already taken by ia64, so a different name was chosen.

I considered making ia64's si_flags a generic field and having it
appear at the end of _sigfault (in the same place as this patch has
si_faultflags) on non-ia64, keeping it in the same place on ia64. ia64's
si_flags is a 32-bit field with only one flag bit allocated, so we
would have 31 bits to use if we do this. However, it seems simplest
to avoid entangling these fields.

Signed-off-by: Peter Collingbourne <pcc@google.com>
Link: https://linux-review.googlesource.com/id/Ide155ce29366c3eab2a944ae4c51205982e5b8b2
---
v13:
- renamed si_xflags to si_faultflags
- use fallthrough macros in kernel/ptrace.c
- fixed a style warning pointed out by checkpatch.pl

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
 kernel/ptrace.c                            | 33 ++++++++++++++++++----
 kernel/signal.c                            |  3 ++
 9 files changed, 59 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/vas-fault.c b/arch/powerpc/platforms/powernv/vas-fault.c
index 3d21fce254b7..877e7d5fb4a2 100644
--- a/arch/powerpc/platforms/powernv/vas-fault.c
+++ b/arch/powerpc/platforms/powernv/vas-fault.c
@@ -154,6 +154,7 @@ static void update_csb(struct vas_window *window,
 	info.si_errno = EFAULT;
 	info.si_code = SEGV_MAPERR;
 	info.si_addr = csb_addr;
+	info.si_faultflags = 0;
 
 	/*
 	 * process will be polling on csb.flags after request is sent to
diff --git a/arch/x86/kernel/signal_compat.c b/arch/x86/kernel/signal_compat.c
index ddfd919be46c..222ff6178571 100644
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
 
+	BUILD_BUG_ON(offsetof(siginfo_t, si_faultflags) != 0x48);
+	BUILD_BUG_ON(offsetof(compat_siginfo_t, si_faultflags) != 0x28);
+
 	CHECK_CSI_OFFSET(_sigpoll);
 	CHECK_CSI_SIZE  (_sigpoll, 2*sizeof(int));
 	CHECK_SI_SIZE   (_sigpoll, 4*sizeof(int));
diff --git a/include/linux/compat.h b/include/linux/compat.h
index 14d514233e1d..84d3b72be701 100644
--- a/include/linux/compat.h
+++ b/include/linux/compat.h
@@ -236,7 +236,9 @@ typedef struct compat_siginfo {
 					char _dummy_pkey[__COMPAT_ADDR_BND_PKEY_PAD];
 					u32 _pkey;
 				} _addr_pkey;
+				compat_uptr_t _pad[6];
 			};
+			u32 _faultflags;
 		} _sigfault;
 
 		/* SIGPOLL */
diff --git a/include/linux/signal_types.h b/include/linux/signal_types.h
index a7887ad84d36..7501209eae33 100644
--- a/include/linux/signal_types.h
+++ b/include/linux/signal_types.h
@@ -78,6 +78,6 @@ struct ksignal {
 
 #define UAPI_SA_FLAGS                                                          \
 	(SA_NOCLDSTOP | SA_NOCLDWAIT | SA_SIGINFO | SA_ONSTACK | SA_RESTART |  \
-	 SA_NODEFER | SA_RESETHAND | __ARCH_UAPI_SA_FLAGS)
+	 SA_NODEFER | SA_RESETHAND | SA_FAULTFLAGS | __ARCH_UAPI_SA_FLAGS)
 
 #endif /* _LINUX_SIGNAL_TYPES_H */
diff --git a/include/uapi/asm-generic/siginfo.h b/include/uapi/asm-generic/siginfo.h
index 7aacf9389010..f43778355b77 100644
--- a/include/uapi/asm-generic/siginfo.h
+++ b/include/uapi/asm-generic/siginfo.h
@@ -91,7 +91,9 @@ union __sifields {
 				char _dummy_pkey[__ADDR_BND_PKEY_PAD];
 				__u32 _pkey;
 			} _addr_pkey;
+			void *_pad[6];
 		};
+		__u32 _faultflags;
 	} _sigfault;
 
 	/* SIGPOLL */
@@ -152,6 +154,8 @@ typedef struct siginfo {
 #define si_trapno	_sifields._sigfault._trapno
 #endif
 #define si_addr_lsb	_sifields._sigfault._addr_lsb
+/* si_faultflags is only valid if 0 < si_code < SI_KERNEL */
+#define si_faultflags	_sifields._sigfault._faultflags
 #define si_lower	_sifields._sigfault._addr_bnd._lower
 #define si_upper	_sifields._sigfault._addr_bnd._upper
 #define si_pkey		_sifields._sigfault._addr_pkey._pkey
diff --git a/include/uapi/asm-generic/signal-defs.h b/include/uapi/asm-generic/signal-defs.h
index 0126ebda4d31..e27bf959d4c4 100644
--- a/include/uapi/asm-generic/signal-defs.h
+++ b/include/uapi/asm-generic/signal-defs.h
@@ -20,6 +20,9 @@
  * so this bit allows flag bit support to be detected from userspace while
  * allowing an old kernel to be distinguished from a kernel that supports every
  * flag bit.
+ * SA_FAULTFLAGS indicates that the signal handler requires the siginfo.si_faultflags
+ * field to be valid. Note that if the kernel supports SA_FAULTFLAGS, the field will
+ * be valid regardless of the value of this flag.
  *
  * SA_ONESHOT and SA_NOMASK are the historical Linux names for the Single
  * Unix names RESETHAND and NODEFER respectively.
@@ -49,6 +52,7 @@
 #define SA_RESETHAND	0x80000000
 #endif
 #define SA_UNSUPPORTED	0x00000400
+#define SA_FAULTFLAGS	0x00000800
 
 #define SA_NOMASK	SA_NODEFER
 #define SA_ONESHOT	SA_RESETHAND
diff --git a/include/uapi/linux/ptrace.h b/include/uapi/linux/ptrace.h
index a71b6e3b03eb..722a2c8a4d3d 100644
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
+ * Asserts that the caller is aware of the field siginfo.si_faultflags. Prevents
+ * the kernel from automatically setting the field to 0 when the signal uses
+ * a sigfault layout.
+ */
+#define PTRACE_SIGINFO_FAULTFLAGS	0x1
+
 /*
  * These values are stored in task->ptrace_message
  * by tracehook_report_syscall_* to describe the current syscall-stop.
diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index 43d6179508d6..ab0618b4602c 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -687,18 +687,31 @@ static int ptrace_getsiginfo(struct task_struct *child, kernel_siginfo_t *info)
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
+	if (flags & ~PTRACE_SIGINFO_FAULTFLAGS)
+		return -EINVAL;
+
+	/*
+	 * If the caller is unaware of si_faultflags and we're using a layout that
+	 * requires it, set it to 0 which means "no fields are available".
+	 */
+	if (!(flags & PTRACE_SIGINFO_FAULTFLAGS) &&
+	    siginfo_layout_is_fault(
+		    siginfo_layout(info->si_signo, info->si_code)))
+		info->si_faultflags = 0;
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
@@ -1038,9 +1051,13 @@ int ptrace_request(struct task_struct *child, long request,
 		break;
 
 	case PTRACE_SETSIGINFO:
+		addr = 0;
+		fallthrough;
+
+	case PTRACE_SETSIGINFO2:
 		ret = copy_siginfo_from_user(&siginfo, datavp);
 		if (!ret)
-			ret = ptrace_setsiginfo(child, &siginfo);
+			ret = ptrace_setsiginfo(child, addr, &siginfo);
 		break;
 
 	case PTRACE_GETSIGMASK: {
@@ -1347,10 +1364,14 @@ int compat_ptrace_request(struct task_struct *child, compat_long_t request,
 		break;
 
 	case PTRACE_SETSIGINFO:
+		addr = 0;
+		fallthrough;
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
index d18930aafbf4..1fd1f0d12174 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1657,6 +1657,7 @@ static void set_sigfault_common_fields(struct kernel_siginfo *info, int sig,
 	info->si_errno = 0;
 	info->si_code = code;
 	info->si_addr = addr;
+	info->si_faultflags = 0;
 }
 
 int force_sig_fault_to_task(int sig, int code, void __user *addr
@@ -3270,6 +3271,7 @@ void copy_siginfo_to_external32(struct compat_siginfo *to,
 #ifdef __ARCH_SI_TRAPNO
 		to->si_trapno = from->si_trapno;
 #endif
+		to->si_faultflags = from->si_faultflags;
 	}
 
 	switch (layout) {
@@ -3345,6 +3347,7 @@ static int post_copy_siginfo_from_user32(kernel_siginfo_t *to,
 #ifdef __ARCH_SI_TRAPNO
 		to->si_trapno = from->si_trapno;
 #endif
+		to->si_faultflags = from->si_faultflags;
 	}
 
 	switch (layout) {
-- 
2.29.1.341.ge80a0c044ae-goog


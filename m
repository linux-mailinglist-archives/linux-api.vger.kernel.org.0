Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36E9B2A6F76
	for <lists+linux-api@lfdr.de>; Wed,  4 Nov 2020 22:18:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730697AbgKDVSZ (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 4 Nov 2020 16:18:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726152AbgKDVSZ (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 4 Nov 2020 16:18:25 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0629DC0613D3
        for <linux-api@vger.kernel.org>; Wed,  4 Nov 2020 13:18:25 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id y9so13821209pll.18
        for <linux-api@vger.kernel.org>; Wed, 04 Nov 2020 13:18:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=CJJ0rjxW0WLgBGe7C8MxYBgWekK6/78/b2MUEp43O38=;
        b=A+J1btA5Y1kuLGUMCPIM7qN7hLU+zm24DMqqt0Ct9S3BvbZiAoHrdE+G4YN770HPHp
         8RGJW1IIp2wTkYQtkp7ESpErViKFSxzZ2MWO4gKMFzbpV4GDqcWGzl6PsgqGTOjXYH/j
         x4TLnjsjPn3KNX0cy9gxCjB7HZQUUGqQC/qdk7TjvveRO7raZncvIPbEG7GMpX+NyvhM
         QpyQn3PLXqEnrPXGym6oTLyIwFcqt4UV+i90b0saO7DYIbR5FvbErkHVoQVOxPxsdtSo
         rSLIUGBw+VHFU41bPp7yh+Wb4HGMOKnHuMuftK9pzT7Z03GLnOm6KQNcto3kknWI4ob+
         0U9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=CJJ0rjxW0WLgBGe7C8MxYBgWekK6/78/b2MUEp43O38=;
        b=KKlibe0ZoQRIRIwpbvavn8kZvqrlZG2vkgAmgDDWt/rjCunx67M+5nHeViLVsIP+q3
         MwC3I34ospq7LWrl7AbhX1yDnuMEMsXKog4CkAD26ANHrqAic6UAkWNqqWOa5UEPTvtC
         DNCeiowe8jqbVdast0SuQU/MbdVah+AT2OrJmJIxVkUFaR4e3qHhWRk3emmbZ2QVZP9K
         1wM9lnClei/ztHUx3A7zjA8zGkBvyRvrBHbKaH022bKjY0NWNWumq/NwqsKiF5iUMNJ4
         i/SnOKttSg8DUw3V+b39Ifh1MHes7zDJ8DUz2XtZqnO9DOAXZ1BR7Le0v3aUbfj8WE/g
         /GHQ==
X-Gm-Message-State: AOAM530xSXBVJCq4nFPoMNdoT1r1scsml1UPaEg9U6yKJQa43XmkqT2W
        nFFJYk8U6R9QzBvzuzQTvsDLDmQ=
X-Google-Smtp-Source: ABdhPJxMY0zrRmmq8tIa8fmsvNKZqpIrRESugE/LICLdR/E86t4oCDUpXaLqQ1SUu+asLo9noIY4W5k=
Sender: "pcc via sendgmr" <pcc@pcc-desktop.svl.corp.google.com>
X-Received: from pcc-desktop.svl.corp.google.com ([2620:15c:2ce:0:7220:84ff:fe09:385a])
 (user=pcc job=sendgmr) by 2002:a62:7883:0:b029:18a:e054:edf1 with SMTP id
 t125-20020a6278830000b029018ae054edf1mr16930196pfc.70.1604524704447; Wed, 04
 Nov 2020 13:18:24 -0800 (PST)
Date:   Wed,  4 Nov 2020 13:18:06 -0800
In-Reply-To: <cover.1604523707.git.pcc@google.com>
Message-Id: <206cfc54563a0ce371120b54f4a46d900273b5a2.1604523707.git.pcc@google.com>
Mime-Version: 1.0
References: <cover.1604523707.git.pcc@google.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [PATCH v14 3/8] arch: move SA_* definitions to generic headers
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
        David Spickett <david.spickett@linaro.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Most architectures with the exception of alpha, mips, parisc and
sparc use the same values for these flags. Move their definitions into
asm-generic/signal-defs.h and allow the architectures with non-standard
values to override them. Also, document the non-standard flag values
in order to make it easier to add new generic flags in the future.

A consequence of this change is that on powerpc and x86, the constants'
values aside from SA_RESETHAND change signedness from unsigned
to signed. This is not expected to impact realistic use of these
constants. In particular the typical use of the constants where they
are or'ed together and assigned to sa_flags (or another int variable)
would not be affected.

Signed-off-by: Peter Collingbourne <pcc@google.com>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
Acked-by: "Eric W. Biederman" <ebiederm@xmission.com>
Reviewed-by: Dave Martin <Dave.Martin@arm.com>
Link: https://linux-review.googlesource.com/id/Ia3849f18b8009bf41faca374e701cdca36974528
---
v14:
- revert unintentional removal of SA_RESTORER on arm as pointed
  out by Eric

v11:
- tweak the commit message to point out the change from unsigned
  to signed

v10:
- move the comments around and add one for SA_SIGINFO

 arch/alpha/include/uapi/asm/signal.h   | 14 --------
 arch/arm/include/uapi/asm/signal.h     | 27 ++-------------
 arch/h8300/include/uapi/asm/signal.h   | 24 -------------
 arch/ia64/include/uapi/asm/signal.h    | 24 -------------
 arch/m68k/include/uapi/asm/signal.h    | 24 -------------
 arch/mips/include/uapi/asm/signal.h    | 12 -------
 arch/parisc/include/uapi/asm/signal.h  | 13 -------
 arch/powerpc/include/uapi/asm/signal.h | 24 -------------
 arch/s390/include/uapi/asm/signal.h    | 24 -------------
 arch/sparc/include/uapi/asm/signal.h   |  4 +--
 arch/x86/include/uapi/asm/signal.h     | 24 -------------
 arch/xtensa/include/uapi/asm/signal.h  | 24 -------------
 include/uapi/asm-generic/signal-defs.h | 47 ++++++++++++++++++++++++++
 include/uapi/asm-generic/signal.h      | 29 ----------------
 14 files changed, 51 insertions(+), 263 deletions(-)

diff --git a/arch/alpha/include/uapi/asm/signal.h b/arch/alpha/include/uapi/asm/signal.h
index 74c750bf1c1a..a69dd8d080a8 100644
--- a/arch/alpha/include/uapi/asm/signal.h
+++ b/arch/alpha/include/uapi/asm/signal.h
@@ -60,20 +60,6 @@ typedef unsigned long sigset_t;
 #define SIGRTMIN	32
 #define SIGRTMAX	_NSIG
 
-/*
- * SA_FLAGS values:
- *
- * SA_ONSTACK indicates that a registered stack_t will be used.
- * SA_RESTART flag to get restarting signals (which were the default long ago)
- * SA_NOCLDSTOP flag to turn off SIGCHLD when children stop.
- * SA_RESETHAND clears the handler when the signal is delivered.
- * SA_NOCLDWAIT flag on SIGCHLD to inhibit zombies.
- * SA_NODEFER prevents the current signal from being masked in the handler.
- *
- * SA_ONESHOT and SA_NOMASK are the historical Linux names for the Single
- * Unix names RESETHAND and NODEFER respectively.
- */
-
 #define SA_ONSTACK	0x00000001
 #define SA_RESTART	0x00000002
 #define SA_NOCLDSTOP	0x00000004
diff --git a/arch/arm/include/uapi/asm/signal.h b/arch/arm/include/uapi/asm/signal.h
index 9b4185ba4f8a..c9a3ea1d8d41 100644
--- a/arch/arm/include/uapi/asm/signal.h
+++ b/arch/arm/include/uapi/asm/signal.h
@@ -60,33 +60,12 @@ typedef unsigned long sigset_t;
 #define SIGSWI		32
 
 /*
- * SA_FLAGS values:
- *
- * SA_NOCLDSTOP		flag to turn off SIGCHLD when children stop.
- * SA_NOCLDWAIT		flag on SIGCHLD to inhibit zombies.
- * SA_SIGINFO		deliver the signal with SIGINFO structs
- * SA_THIRTYTWO		delivers the signal in 32-bit mode, even if the task 
- *			is running in 26-bit.
- * SA_ONSTACK		allows alternate signal stacks (see sigaltstack(2)).
- * SA_RESTART		flag to get restarting signals (which were the default long ago)
- * SA_NODEFER		prevents the current signal from being masked in the handler.
- * SA_RESETHAND		clears the handler when the signal is delivered.
- *
- * SA_ONESHOT and SA_NOMASK are the historical Linux names for the Single
- * Unix names RESETHAND and NODEFER respectively.
+ * SA_THIRTYTWO historically meant deliver the signal in 32-bit mode, even if
+ * the task is running in 26-bit. But since the kernel no longer supports
+ * 26-bit mode, the flag has no effect.
  */
-#define SA_NOCLDSTOP	0x00000001
-#define SA_NOCLDWAIT	0x00000002
-#define SA_SIGINFO	0x00000004
 #define SA_THIRTYTWO	0x02000000
 #define SA_RESTORER	0x04000000
-#define SA_ONSTACK	0x08000000
-#define SA_RESTART	0x10000000
-#define SA_NODEFER	0x40000000
-#define SA_RESETHAND	0x80000000
-
-#define SA_NOMASK	SA_NODEFER
-#define SA_ONESHOT	SA_RESETHAND
 
 #define MINSIGSTKSZ	2048
 #define SIGSTKSZ	8192
diff --git a/arch/h8300/include/uapi/asm/signal.h b/arch/h8300/include/uapi/asm/signal.h
index e15521037348..2cd0dce2b6a6 100644
--- a/arch/h8300/include/uapi/asm/signal.h
+++ b/arch/h8300/include/uapi/asm/signal.h
@@ -57,30 +57,6 @@ typedef unsigned long sigset_t;
 #define SIGRTMIN	32
 #define SIGRTMAX	_NSIG
 
-/*
- * SA_FLAGS values:
- *
- * SA_ONSTACK indicates that a registered stack_t will be used.
- * SA_RESTART flag to get restarting signals (which were the default long ago)
- * SA_NOCLDSTOP flag to turn off SIGCHLD when children stop.
- * SA_RESETHAND clears the handler when the signal is delivered.
- * SA_NOCLDWAIT flag on SIGCHLD to inhibit zombies.
- * SA_NODEFER prevents the current signal from being masked in the handler.
- *
- * SA_ONESHOT and SA_NOMASK are the historical Linux names for the Single
- * Unix names RESETHAND and NODEFER respectively.
- */
-#define SA_NOCLDSTOP	0x00000001
-#define SA_NOCLDWAIT	0x00000002 /* not supported yet */
-#define SA_SIGINFO	0x00000004
-#define SA_ONSTACK	0x08000000
-#define SA_RESTART	0x10000000
-#define SA_NODEFER	0x40000000
-#define SA_RESETHAND	0x80000000
-
-#define SA_NOMASK	SA_NODEFER
-#define SA_ONESHOT	SA_RESETHAND
-
 #define SA_RESTORER	0x04000000
 
 #define MINSIGSTKSZ	2048
diff --git a/arch/ia64/include/uapi/asm/signal.h b/arch/ia64/include/uapi/asm/signal.h
index aa98ff1b9e22..38166a88e4c9 100644
--- a/arch/ia64/include/uapi/asm/signal.h
+++ b/arch/ia64/include/uapi/asm/signal.h
@@ -53,30 +53,6 @@
 #define SIGRTMIN	32
 #define SIGRTMAX	_NSIG
 
-/*
- * SA_FLAGS values:
- *
- * SA_ONSTACK indicates that a registered stack_t will be used.
- * SA_RESTART flag to get restarting signals (which were the default long ago)
- * SA_NOCLDSTOP flag to turn off SIGCHLD when children stop.
- * SA_RESETHAND clears the handler when the signal is delivered.
- * SA_NOCLDWAIT flag on SIGCHLD to inhibit zombies.
- * SA_NODEFER prevents the current signal from being masked in the handler.
- *
- * SA_ONESHOT and SA_NOMASK are the historical Linux names for the Single
- * Unix names RESETHAND and NODEFER respectively.
- */
-#define SA_NOCLDSTOP	0x00000001
-#define SA_NOCLDWAIT	0x00000002
-#define SA_SIGINFO	0x00000004
-#define SA_ONSTACK	0x08000000
-#define SA_RESTART	0x10000000
-#define SA_NODEFER	0x40000000
-#define SA_RESETHAND	0x80000000
-
-#define SA_NOMASK	SA_NODEFER
-#define SA_ONESHOT	SA_RESETHAND
-
 #define SA_RESTORER	0x04000000
 
 /*
diff --git a/arch/m68k/include/uapi/asm/signal.h b/arch/m68k/include/uapi/asm/signal.h
index 915cc755a184..4619291df601 100644
--- a/arch/m68k/include/uapi/asm/signal.h
+++ b/arch/m68k/include/uapi/asm/signal.h
@@ -57,30 +57,6 @@ typedef unsigned long sigset_t;
 #define SIGRTMIN	32
 #define SIGRTMAX	_NSIG
 
-/*
- * SA_FLAGS values:
- *
- * SA_ONSTACK indicates that a registered stack_t will be used.
- * SA_RESTART flag to get restarting signals (which were the default long ago)
- * SA_NOCLDSTOP flag to turn off SIGCHLD when children stop.
- * SA_RESETHAND clears the handler when the signal is delivered.
- * SA_NOCLDWAIT flag on SIGCHLD to inhibit zombies.
- * SA_NODEFER prevents the current signal from being masked in the handler.
- *
- * SA_ONESHOT and SA_NOMASK are the historical Linux names for the Single
- * Unix names RESETHAND and NODEFER respectively.
- */
-#define SA_NOCLDSTOP	0x00000001
-#define SA_NOCLDWAIT	0x00000002
-#define SA_SIGINFO	0x00000004
-#define SA_ONSTACK	0x08000000
-#define SA_RESTART	0x10000000
-#define SA_NODEFER	0x40000000
-#define SA_RESETHAND	0x80000000
-
-#define SA_NOMASK	SA_NODEFER
-#define SA_ONESHOT	SA_RESETHAND
-
 #define MINSIGSTKSZ	2048
 #define SIGSTKSZ	8192
 
diff --git a/arch/mips/include/uapi/asm/signal.h b/arch/mips/include/uapi/asm/signal.h
index 53104b10aae2..e6c78a15cb2f 100644
--- a/arch/mips/include/uapi/asm/signal.h
+++ b/arch/mips/include/uapi/asm/signal.h
@@ -62,18 +62,6 @@ typedef unsigned long old_sigset_t;		/* at least 32 bits */
 #define SIGRTMAX	_NSIG
 
 /*
- * SA_FLAGS values:
- *
- * SA_ONSTACK indicates that a registered stack_t will be used.
- * SA_RESTART flag to get restarting signals (which were the default long ago)
- * SA_NOCLDSTOP flag to turn off SIGCHLD when children stop.
- * SA_RESETHAND clears the handler when the signal is delivered.
- * SA_NOCLDWAIT flag on SIGCHLD to inhibit zombies.
- * SA_NODEFER prevents the current signal from being masked in the handler.
- *
- * SA_ONESHOT and SA_NOMASK are the historical Linux names for the Single
- * Unix names RESETHAND and NODEFER respectively.
- *
  * SA_RESTORER used to be defined as 0x04000000 but only the O32 ABI ever
  * supported its use and no libc was using it, so the entire sa-restorer
  * functionality was removed with lmo commit 39bffc12c3580ab for 2.5.48
diff --git a/arch/parisc/include/uapi/asm/signal.h b/arch/parisc/include/uapi/asm/signal.h
index 9e6f87bc8a73..e5a2657477ac 100644
--- a/arch/parisc/include/uapi/asm/signal.h
+++ b/arch/parisc/include/uapi/asm/signal.h
@@ -41,19 +41,6 @@
 #define SIGRTMIN	32
 #define SIGRTMAX	_NSIG
 
-/*
- * SA_FLAGS values:
- *
- * SA_ONSTACK indicates that a registered stack_t will be used.
- * SA_RESTART flag to get restarting signals (which were the default long ago)
- * SA_NOCLDSTOP flag to turn off SIGCHLD when children stop.
- * SA_RESETHAND clears the handler when the signal is delivered.
- * SA_NOCLDWAIT flag on SIGCHLD to inhibit zombies.
- * SA_NODEFER prevents the current signal from being masked in the handler.
- *
- * SA_ONESHOT and SA_NOMASK are the historical Linux names for the Single
- * Unix names RESETHAND and NODEFER respectively.
- */
 #define SA_ONSTACK	0x00000001
 #define SA_RESETHAND	0x00000004
 #define SA_NOCLDSTOP	0x00000008
diff --git a/arch/powerpc/include/uapi/asm/signal.h b/arch/powerpc/include/uapi/asm/signal.h
index 85b0a7aa43e7..04873dd311c2 100644
--- a/arch/powerpc/include/uapi/asm/signal.h
+++ b/arch/powerpc/include/uapi/asm/signal.h
@@ -60,30 +60,6 @@ typedef struct {
 #define SIGRTMIN	32
 #define SIGRTMAX	_NSIG
 
-/*
- * SA_FLAGS values:
- *
- * SA_ONSTACK is not currently supported, but will allow sigaltstack(2).
- * SA_RESTART flag to get restarting signals (which were the default long ago)
- * SA_NOCLDSTOP flag to turn off SIGCHLD when children stop.
- * SA_RESETHAND clears the handler when the signal is delivered.
- * SA_NOCLDWAIT flag on SIGCHLD to inhibit zombies.
- * SA_NODEFER prevents the current signal from being masked in the handler.
- *
- * SA_ONESHOT and SA_NOMASK are the historical Linux names for the Single
- * Unix names RESETHAND and NODEFER respectively.
- */
-#define SA_NOCLDSTOP	0x00000001U
-#define SA_NOCLDWAIT	0x00000002U
-#define SA_SIGINFO	0x00000004U
-#define SA_ONSTACK	0x08000000U
-#define SA_RESTART	0x10000000U
-#define SA_NODEFER	0x40000000U
-#define SA_RESETHAND	0x80000000U
-
-#define SA_NOMASK	SA_NODEFER
-#define SA_ONESHOT	SA_RESETHAND
-
 #define SA_RESTORER	0x04000000U
 
 #define MINSIGSTKSZ	2048
diff --git a/arch/s390/include/uapi/asm/signal.h b/arch/s390/include/uapi/asm/signal.h
index 9a14a611ed82..0189f326aac5 100644
--- a/arch/s390/include/uapi/asm/signal.h
+++ b/arch/s390/include/uapi/asm/signal.h
@@ -65,30 +65,6 @@ typedef unsigned long sigset_t;
 #define SIGRTMIN        32
 #define SIGRTMAX        _NSIG
 
-/*
- * SA_FLAGS values:
- *
- * SA_ONSTACK indicates that a registered stack_t will be used.
- * SA_RESTART flag to get restarting signals (which were the default long ago)
- * SA_NOCLDSTOP flag to turn off SIGCHLD when children stop.
- * SA_RESETHAND clears the handler when the signal is delivered.
- * SA_NOCLDWAIT flag on SIGCHLD to inhibit zombies.
- * SA_NODEFER prevents the current signal from being masked in the handler.
- *
- * SA_ONESHOT and SA_NOMASK are the historical Linux names for the Single
- * Unix names RESETHAND and NODEFER respectively.
- */
-#define SA_NOCLDSTOP    0x00000001
-#define SA_NOCLDWAIT    0x00000002
-#define SA_SIGINFO      0x00000004
-#define SA_ONSTACK      0x08000000
-#define SA_RESTART      0x10000000
-#define SA_NODEFER      0x40000000
-#define SA_RESETHAND    0x80000000
-
-#define SA_NOMASK       SA_NODEFER
-#define SA_ONESHOT      SA_RESETHAND
-
 #define SA_RESTORER     0x04000000
 
 #define MINSIGSTKSZ     2048
diff --git a/arch/sparc/include/uapi/asm/signal.h b/arch/sparc/include/uapi/asm/signal.h
index ff9505923b9a..53758d53ac0e 100644
--- a/arch/sparc/include/uapi/asm/signal.h
+++ b/arch/sparc/include/uapi/asm/signal.h
@@ -137,13 +137,11 @@ struct sigstack {
 #define SA_STACK	_SV_SSTACK
 #define SA_ONSTACK	_SV_SSTACK
 #define SA_RESTART	_SV_INTR
-#define SA_ONESHOT	_SV_RESET
+#define SA_RESETHAND	_SV_RESET
 #define SA_NODEFER	0x20u
 #define SA_NOCLDWAIT    0x100u
 #define SA_SIGINFO      0x200u
 
-#define SA_NOMASK	SA_NODEFER
-
 #define SIG_BLOCK          0x01	/* for blocking signals */
 #define SIG_UNBLOCK        0x02	/* for unblocking signals */
 #define SIG_SETMASK        0x04	/* for setting the signal mask */
diff --git a/arch/x86/include/uapi/asm/signal.h b/arch/x86/include/uapi/asm/signal.h
index e5745d593dc7..164a22a72984 100644
--- a/arch/x86/include/uapi/asm/signal.h
+++ b/arch/x86/include/uapi/asm/signal.h
@@ -62,30 +62,6 @@ typedef unsigned long sigset_t;
 #define SIGRTMIN	32
 #define SIGRTMAX	_NSIG
 
-/*
- * SA_FLAGS values:
- *
- * SA_ONSTACK indicates that a registered stack_t will be used.
- * SA_RESTART flag to get restarting signals (which were the default long ago)
- * SA_NOCLDSTOP flag to turn off SIGCHLD when children stop.
- * SA_RESETHAND clears the handler when the signal is delivered.
- * SA_NOCLDWAIT flag on SIGCHLD to inhibit zombies.
- * SA_NODEFER prevents the current signal from being masked in the handler.
- *
- * SA_ONESHOT and SA_NOMASK are the historical Linux names for the Single
- * Unix names RESETHAND and NODEFER respectively.
- */
-#define SA_NOCLDSTOP	0x00000001u
-#define SA_NOCLDWAIT	0x00000002u
-#define SA_SIGINFO	0x00000004u
-#define SA_ONSTACK	0x08000000u
-#define SA_RESTART	0x10000000u
-#define SA_NODEFER	0x40000000u
-#define SA_RESETHAND	0x80000000u
-
-#define SA_NOMASK	SA_NODEFER
-#define SA_ONESHOT	SA_RESETHAND
-
 #define SA_RESTORER	0x04000000
 
 #define MINSIGSTKSZ	2048
diff --git a/arch/xtensa/include/uapi/asm/signal.h b/arch/xtensa/include/uapi/asm/signal.h
index 005dec5bfde4..79ddabaa4e5d 100644
--- a/arch/xtensa/include/uapi/asm/signal.h
+++ b/arch/xtensa/include/uapi/asm/signal.h
@@ -72,30 +72,6 @@ typedef struct {
 #define SIGRTMIN	32
 #define SIGRTMAX	(_NSIG-1)
 
-/*
- * SA_FLAGS values:
- *
- * SA_ONSTACK indicates that a registered stack_t will be used.
- * SA_RESTART flag to get restarting signals (which were the default long ago)
- * SA_NOCLDSTOP flag to turn off SIGCHLD when children stop.
- * SA_RESETHAND clears the handler when the signal is delivered.
- * SA_NOCLDWAIT flag on SIGCHLD to inhibit zombies.
- * SA_NODEFER prevents the current signal from being masked in the handler.
- *
- * SA_ONESHOT and SA_NOMASK are the historical Linux names for the Single
- * Unix names RESETHAND and NODEFER respectively.
- */
-#define SA_NOCLDSTOP	0x00000001
-#define SA_NOCLDWAIT	0x00000002 /* not supported yet */
-#define SA_SIGINFO	0x00000004
-#define SA_ONSTACK	0x08000000
-#define SA_RESTART	0x10000000
-#define SA_NODEFER	0x40000000
-#define SA_RESETHAND	0x80000000
-
-#define SA_NOMASK	SA_NODEFER
-#define SA_ONESHOT	SA_RESETHAND
-
 #define SA_RESTORER	0x04000000
 
 #define MINSIGSTKSZ	2048
diff --git a/include/uapi/asm-generic/signal-defs.h b/include/uapi/asm-generic/signal-defs.h
index e9304c95ceea..493953fe319b 100644
--- a/include/uapi/asm-generic/signal-defs.h
+++ b/include/uapi/asm-generic/signal-defs.h
@@ -4,6 +4,53 @@
 
 #include <linux/compiler.h>
 
+/*
+ * SA_FLAGS values:
+ *
+ * SA_NOCLDSTOP flag to turn off SIGCHLD when children stop.
+ * SA_NOCLDWAIT flag on SIGCHLD to inhibit zombies.
+ * SA_SIGINFO delivers the signal with SIGINFO structs.
+ * SA_ONSTACK indicates that a registered stack_t will be used.
+ * SA_RESTART flag to get restarting signals (which were the default long ago)
+ * SA_NODEFER prevents the current signal from being masked in the handler.
+ * SA_RESETHAND clears the handler when the signal is delivered.
+ *
+ * SA_ONESHOT and SA_NOMASK are the historical Linux names for the Single
+ * Unix names RESETHAND and NODEFER respectively.
+ *
+ * The following bits are used in architecture-specific SA_* definitions and
+ * should be avoided for new generic flags: 3, 4, 5, 6, 7, 8, 9, 16, 24, 25, 26.
+ */
+#ifndef SA_NOCLDSTOP
+#define SA_NOCLDSTOP	0x00000001
+#endif
+#ifndef SA_NOCLDWAIT
+#define SA_NOCLDWAIT	0x00000002
+#endif
+#ifndef SA_SIGINFO
+#define SA_SIGINFO	0x00000004
+#endif
+#ifndef SA_ONSTACK
+#define SA_ONSTACK	0x08000000
+#endif
+#ifndef SA_RESTART
+#define SA_RESTART	0x10000000
+#endif
+#ifndef SA_NODEFER
+#define SA_NODEFER	0x40000000
+#endif
+#ifndef SA_RESETHAND
+#define SA_RESETHAND	0x80000000
+#endif
+
+#define SA_NOMASK	SA_NODEFER
+#define SA_ONESHOT	SA_RESETHAND
+
+/*
+ * New architectures should not define the obsolete
+ *	SA_RESTORER	0x04000000
+ */
+
 #ifndef SIG_BLOCK
 #define SIG_BLOCK          0	/* for blocking signals */
 #endif
diff --git a/include/uapi/asm-generic/signal.h b/include/uapi/asm-generic/signal.h
index 5c716a952cbe..f634822906e4 100644
--- a/include/uapi/asm-generic/signal.h
+++ b/include/uapi/asm-generic/signal.h
@@ -52,35 +52,6 @@
 #define SIGRTMAX	_NSIG
 #endif
 
-/*
- * SA_FLAGS values:
- *
- * SA_ONSTACK indicates that a registered stack_t will be used.
- * SA_RESTART flag to get restarting signals (which were the default long ago)
- * SA_NOCLDSTOP flag to turn off SIGCHLD when children stop.
- * SA_RESETHAND clears the handler when the signal is delivered.
- * SA_NOCLDWAIT flag on SIGCHLD to inhibit zombies.
- * SA_NODEFER prevents the current signal from being masked in the handler.
- *
- * SA_ONESHOT and SA_NOMASK are the historical Linux names for the Single
- * Unix names RESETHAND and NODEFER respectively.
- */
-#define SA_NOCLDSTOP	0x00000001
-#define SA_NOCLDWAIT	0x00000002
-#define SA_SIGINFO	0x00000004
-#define SA_ONSTACK	0x08000000
-#define SA_RESTART	0x10000000
-#define SA_NODEFER	0x40000000
-#define SA_RESETHAND	0x80000000
-
-#define SA_NOMASK	SA_NODEFER
-#define SA_ONESHOT	SA_RESETHAND
-
-/*
- * New architectures should not define the obsolete
- *	SA_RESTORER	0x04000000
- */
-
 #if !defined MINSIGSTKSZ || !defined SIGSTKSZ
 #define MINSIGSTKSZ	2048
 #define SIGSTKSZ	8192
-- 
2.29.1.341.ge80a0c044ae-goog


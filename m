Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7A861BF115
	for <lists+linux-api@lfdr.de>; Thu, 30 Apr 2020 09:17:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726857AbgD3HRD (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 30 Apr 2020 03:17:03 -0400
Received: from mail.cs.msu.ru ([188.44.42.39]:50498 "EHLO mail.cs.msu.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726793AbgD3HQy (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 30 Apr 2020 03:16:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=cs.msu.ru;
         s=dkim; h=Subject:Content-Transfer-Encoding:MIME-Version:References:
        In-Reply-To:Message-Id:Date:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=q4rTBPHhB2Du4aU8d5pixx6IYGJjFwP40GIGH1s1K4M=; b=cEEWLyDx36BVOjcydHqtowCVQ6
        KKLw5dCvW7zYsLgzLKIEyv54ZTe78poS+rcK9kEx76Prs5MovFUFsNHCvC756ROylmTolupsmTkh4
        i+VfkBWgu2hoxU6r7NVgZtHdy89vo1eyC7bJ3WAXIkc9+esVYmd7K6nAZcLcY33bz0sZSXYgLQ6iJ
        v2ulbmNlZOFqCq9Icv7eR7HWd1+ChP0ivZnavMUpBiH9EDeWZtNuIF2zVOYo1MG21My3K8b4RaE7A
        wa8ZQSrFDK8vEc+2WhBy4GT1HHgwmw53xZy711Z5mgX83HEl5QMfPe1jN5UDnzwCBPXtvKQnMr5Bl
        BqhglWnw==;
Received: from [37.204.119.143] (port=42272 helo=localhost.localdomain)
        by mail.cs.msu.ru with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93.0.4 (FreeBSD))
        (envelope-from <ar@cs.msu.ru>)
        id 1jU2uu-000B4I-6U; Thu, 30 Apr 2020 09:43:28 +0300
From:   Arseny Maslennikov <ar@cs.msu.ru>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Arseny Maslennikov <ar@cs.msu.ru>, Rob Landley <rob@landley.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Pavel Machek <pavel@ucw.cz>, linux-api@vger.kernel.org,
        "Vladimir D. Seleznev" <vseleznv@altlinux.org>
Date:   Thu, 30 Apr 2020 09:42:55 +0300
Message-Id: <20200430064301.1099452-2-ar@cs.msu.ru>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200430064301.1099452-1-ar@cs.msu.ru>
References: <20200430064301.1099452-1-ar@cs.msu.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 37.204.119.143
X-SA-Exim-Mail-From: ar@cs.msu.ru
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on mail.cs.msu.ru
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_ADSP_ALL autolearn=no autolearn_force=no version=3.4.4
Subject: [PATCH v3 1/7] signal.h: Define SIGINFO on all architectures
X-SA-Exim-Version: 4.2.1
X-SA-Exim-Scanned: Yes (on mail.cs.msu.ru)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

This complementary patch defines SIGINFO as a synonym for SIGPWR
on every architecture supported by the kernel.

SIGPWR looks like a nice candidate for this role, because it is
defined on every supported arch; it is currently only used to inform
PID 1 of power failures, and daemons that care about low-level
events do not tend to have a controlling terminal.

However, on sparcs SIGPWR is a synonym for SIGLOST, a signal unique
to that architecture, with a narrow set of intended uses that do not
combine well with interactively requesting status.
SIGLOST is not used by any kernel code at the moment.

SIGINFO is not defined as a real-time signal for the following reasons:
* SIGRTMIN and SIGRTMAX can not be changed without breaking userspace
* the lack of queuing is irrelevant for the main use-case, since the
  consumption rate of information by a terminal user and the
  practical tty keypress processing rates are much slower than SIGINFO
  processing by the line discipline.

Signed-off-by: Arseny Maslennikov <ar@cs.msu.ru>
---
 arch/arm/include/uapi/asm/signal.h     | 1 +
 arch/h8300/include/uapi/asm/signal.h   | 1 +
 arch/ia64/include/uapi/asm/signal.h    | 1 +
 arch/m68k/include/uapi/asm/signal.h    | 1 +
 arch/mips/include/uapi/asm/signal.h    | 1 +
 arch/parisc/include/uapi/asm/signal.h  | 1 +
 arch/powerpc/include/uapi/asm/signal.h | 1 +
 arch/s390/include/uapi/asm/signal.h    | 1 +
 arch/sparc/include/uapi/asm/signal.h   | 2 ++
 arch/x86/include/uapi/asm/signal.h     | 1 +
 arch/xtensa/include/uapi/asm/signal.h  | 1 +
 include/uapi/asm-generic/signal.h      | 1 +
 12 files changed, 13 insertions(+)

diff --git a/arch/arm/include/uapi/asm/signal.h b/arch/arm/include/uapi/asm/signal.h
index 9b4185ba4..b80b53a17 100644
--- a/arch/arm/include/uapi/asm/signal.h
+++ b/arch/arm/include/uapi/asm/signal.h
@@ -50,6 +50,7 @@ typedef unsigned long sigset_t;
 #define SIGLOST		29
 */
 #define SIGPWR		30
+#define SIGINFO		SIGPWR
 #define SIGSYS		31
 #define	SIGUNUSED	31
 
diff --git a/arch/h8300/include/uapi/asm/signal.h b/arch/h8300/include/uapi/asm/signal.h
index e15521037..7a2b783af 100644
--- a/arch/h8300/include/uapi/asm/signal.h
+++ b/arch/h8300/include/uapi/asm/signal.h
@@ -50,6 +50,7 @@ typedef unsigned long sigset_t;
 #define SIGLOST		29
 */
 #define SIGPWR		30
+#define SIGINFO		SIGPWR
 #define SIGSYS		31
 #define	SIGUNUSED	31
 
diff --git a/arch/ia64/include/uapi/asm/signal.h b/arch/ia64/include/uapi/asm/signal.h
index aa98ff1b9..b4c98cb17 100644
--- a/arch/ia64/include/uapi/asm/signal.h
+++ b/arch/ia64/include/uapi/asm/signal.h
@@ -45,6 +45,7 @@
 #define SIGLOST		29
 */
 #define SIGPWR		30
+#define SIGINFO		SIGPWR
 #define SIGSYS		31
 /* signal 31 is no longer "unused", but the SIGUNUSED macro remains for backwards compatibility */
 #define	SIGUNUSED	31
diff --git a/arch/m68k/include/uapi/asm/signal.h b/arch/m68k/include/uapi/asm/signal.h
index 915cc755a..a0b4e4108 100644
--- a/arch/m68k/include/uapi/asm/signal.h
+++ b/arch/m68k/include/uapi/asm/signal.h
@@ -50,6 +50,7 @@ typedef unsigned long sigset_t;
 #define SIGLOST		29
 */
 #define SIGPWR		30
+#define SIGINFO		SIGPWR
 #define SIGSYS		31
 #define	SIGUNUSED	31
 
diff --git a/arch/mips/include/uapi/asm/signal.h b/arch/mips/include/uapi/asm/signal.h
index 53104b10a..975a6f0d3 100644
--- a/arch/mips/include/uapi/asm/signal.h
+++ b/arch/mips/include/uapi/asm/signal.h
@@ -43,6 +43,7 @@ typedef unsigned long old_sigset_t;		/* at least 32 bits */
 #define SIGCHLD		18	/* Child status has changed (POSIX).  */
 #define SIGCLD		SIGCHLD /* Same as SIGCHLD (System V).	*/
 #define SIGPWR		19	/* Power failure restart (System V).  */
+#define SIGINFO		SIGPWR	/* Keyboard status request (4.2 BSD). */
 #define SIGWINCH	20	/* Window size change (4.3 BSD, Sun).  */
 #define SIGURG		21	/* Urgent condition on socket (4.2 BSD).  */
 #define SIGIO		22	/* I/O now possible (4.2 BSD).	*/
diff --git a/arch/parisc/include/uapi/asm/signal.h b/arch/parisc/include/uapi/asm/signal.h
index d38563a39..fe2e00d59 100644
--- a/arch/parisc/include/uapi/asm/signal.h
+++ b/arch/parisc/include/uapi/asm/signal.h
@@ -22,6 +22,7 @@
 #define SIGUSR2		17
 #define SIGCHLD		18
 #define SIGPWR		19
+#define SIGINFO		SIGPWR
 #define SIGVTALRM	20
 #define SIGPROF		21
 #define SIGIO		22
diff --git a/arch/powerpc/include/uapi/asm/signal.h b/arch/powerpc/include/uapi/asm/signal.h
index 85b0a7aa4..e7f388590 100644
--- a/arch/powerpc/include/uapi/asm/signal.h
+++ b/arch/powerpc/include/uapi/asm/signal.h
@@ -53,6 +53,7 @@ typedef struct {
 #define SIGLOST		29
 */
 #define SIGPWR		30
+#define SIGINFO		SIGPWR
 #define SIGSYS		31
 #define	SIGUNUSED	31
 
diff --git a/arch/s390/include/uapi/asm/signal.h b/arch/s390/include/uapi/asm/signal.h
index 9a14a611e..12ee62987 100644
--- a/arch/s390/include/uapi/asm/signal.h
+++ b/arch/s390/include/uapi/asm/signal.h
@@ -58,6 +58,7 @@ typedef unsigned long sigset_t;
 #define SIGLOST         29
 */
 #define SIGPWR          30
+#define SIGINFO         SIGPWR
 #define SIGSYS		31
 #define SIGUNUSED       31
 
diff --git a/arch/sparc/include/uapi/asm/signal.h b/arch/sparc/include/uapi/asm/signal.h
index ff9505923..b65516319 100644
--- a/arch/sparc/include/uapi/asm/signal.h
+++ b/arch/sparc/include/uapi/asm/signal.h
@@ -71,6 +71,8 @@
 #define SIGWINCH	28
 #define SIGLOST		29
 #define SIGPWR		SIGLOST
+/* XXX: is it OK for SIGINFO to collide with LOST? */
+#define SIGINFO		SIGPWR
 #define SIGUSR1		30
 #define SIGUSR2		31
 
diff --git a/arch/x86/include/uapi/asm/signal.h b/arch/x86/include/uapi/asm/signal.h
index e5745d593..1539bb288 100644
--- a/arch/x86/include/uapi/asm/signal.h
+++ b/arch/x86/include/uapi/asm/signal.h
@@ -55,6 +55,7 @@ typedef unsigned long sigset_t;
 #define SIGLOST		29
 */
 #define SIGPWR		30
+#define SIGINFO		SIGPWR
 #define SIGSYS		31
 #define	SIGUNUSED	31
 
diff --git a/arch/xtensa/include/uapi/asm/signal.h b/arch/xtensa/include/uapi/asm/signal.h
index 005dec5bf..d64423430 100644
--- a/arch/xtensa/include/uapi/asm/signal.h
+++ b/arch/xtensa/include/uapi/asm/signal.h
@@ -65,6 +65,7 @@ typedef struct {
 #define SIGPOLL		SIGIO
 /* #define SIGLOST		29 */
 #define SIGPWR		30
+#define SIGINFO		SIGPWR
 #define SIGSYS		31
 #define	SIGUNUSED	31
 
diff --git a/include/uapi/asm-generic/signal.h b/include/uapi/asm-generic/signal.h
index 5c716a952..9f9a1db0d 100644
--- a/include/uapi/asm-generic/signal.h
+++ b/include/uapi/asm-generic/signal.h
@@ -43,6 +43,7 @@
 #define SIGLOST		29
 */
 #define SIGPWR		30
+#define SIGINFO		SIGPWR
 #define SIGSYS		31
 #define	SIGUNUSED	31
 
-- 
2.26.2


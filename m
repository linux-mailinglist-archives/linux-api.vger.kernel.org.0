Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67D6C3CAE1C
	for <lists+linux-api@lfdr.de>; Thu, 15 Jul 2021 22:46:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231896AbhGOUtM (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 15 Jul 2021 16:49:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230515AbhGOUtM (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 15 Jul 2021 16:49:12 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BE0EC06175F
        for <linux-api@vger.kernel.org>; Thu, 15 Jul 2021 13:46:18 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id z39-20020a25ada70000b029056092741626so9378662ybi.19
        for <linux-api@vger.kernel.org>; Thu, 15 Jul 2021 13:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=py55da35odqXUKPz6mWY1d6sBAOGNrGbD2bahMQ95KA=;
        b=uqGtzYpj2e8Z7+9ZlSjER81JDMWTIgZmRpSoY38r/yzbX63hLoY5Ns2VG8zSRAyxPH
         pT4LcI38pq2Kl7GvVXCBZ83eaWZkMgFOO4JGpqsVuFgKLBIrHoFesbxv/iEnPPk6jn51
         xtnVXYn0rK2hSQE41rsOZHVKiIcDIGAY9PDk4vB1eKADuDr8q/CXrAYqsXoN8zxSWVvv
         nrCUcXqOLRwuOTdvRy+xweAFlHuCPTw4Crf01lzsU1nSsNuPJcyLkAZ5FAm/bxK2sLjn
         jLGBWUGAPKJ/xmPBTSPUpbdTBBnYhM6HW3MBSUA3GCMb1bqYhesNs5ehiKuMD9hHpZ/i
         Zofw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=py55da35odqXUKPz6mWY1d6sBAOGNrGbD2bahMQ95KA=;
        b=S5xrThH1b1gW+2BUovSWmaljGb2bIABuy5L2VVkD5fw3IxCZyzGycLi6Kx5hLnKVQ0
         1UOHh3zfwvrVbOeFutxpRL5BIJvxSrFMqW8/LYmPEc2RXLW88Cra8FPg4y5Pebj8NdCo
         sHkHvdXYPG2qu+YyrzzkPkGVaPuilLBWDDPwBqt8HzwymwZQzTQbsfnZimM98DGF0zlv
         sSLhB6kQHxq3dkOnQk5m2TwcW0tIjuu0P02YCMM5bnz/9V6oOBtjPDCHbnODww3mPdEO
         UEW6JI3a1jaRy/gFJdIsdzEvotv3gWcKW77BQGQWl72XjsD3BL9/qsF7NLAy8lgCVrKu
         Nlnw==
X-Gm-Message-State: AOAM530VaAoPeW9Ky6RDa5+CcPRLUxk9Mcx+iSZhzWRAxGBeJ2x2WfW9
        yTlKG7gTTi43FwJgkbXSt4w/1k8=
X-Google-Smtp-Source: ABdhPJxhM8MljKIEIqE1GyuEISKGfborLYfirArTvxCiqV41qv3cOIt4ZBh4F8EmX8+WHMIUosb9VwI=
X-Received: from pcc-desktop.svl.corp.google.com ([2620:15c:2ce:200:5c63:3fc6:856c:f8d])
 (user=pcc job=sendgmr) by 2002:a5b:801:: with SMTP id x1mr7983259ybp.137.1626381977487;
 Thu, 15 Jul 2021 13:46:17 -0700 (PDT)
Date:   Thu, 15 Jul 2021 13:46:10 -0700
Message-Id: <20210715204610.575999-1-pcc@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.402.g57bb445576-goog
Subject: [PATCH v4] sigaction.2: Document SA_EXPOSE_TAGBITS and the flag
 support detection protocol
From:   Peter Collingbourne <pcc@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Will Deacon <will@kernel.org>, Oleg Nesterov <oleg@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Alejandro Colomar <alx.manpages@gmail.com>
Cc:     Peter Collingbourne <pcc@google.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        linux-api@vger.kernel.org, Helge Deller <deller@gmx.de>,
        David Spickett <david.spickett@linaro.org>,
        linux-man@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Signed-off-by: Peter Collingbourne <pcc@google.com>
---
v4:
- s/.BR/.BR/ in one location
- 4 space indentation
- raise(SIGSEGV) instead of manual SIGSEGV
- use C99 initialization

v3:
- s/5.x/5.11/g
- s/.IR/.I/ in one location

v2:
- fix formatting
- address feedback from Dave

 man2/sigaction.2 | 123 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 123 insertions(+)

diff --git a/man2/sigaction.2 b/man2/sigaction.2
index 57ad6418c..4bf6f095e 100644
--- a/man2/sigaction.2
+++ b/man2/sigaction.2
@@ -261,6 +261,44 @@ This flag is meaningful only when establishing a signal handler.
 .\" .I sa_sigaction
 .\" field was added in Linux 2.1.86.)
 .\"
+.TP
+.B SA_UNSUPPORTED
+Used to dynamically probe for flag bit support.
+.IP
+If an attempt to register a handler succeeds with this flag set in
+.I act->sa_flags
+alongside other flags that are potentially unsupported by the kernel,
+and an immediately subsequent
+.BR sigaction ()
+call specifying the same signal number n and with non-NULL
+.I oldact
+yields
+.B SA_UNSUPPORTED
+.I clear
+in
+.IR oldact->sa_flags ,
+then
+.I oldact->sa_flags
+may be used as a bitmask
+describing which of the potentially unsupported flags are,
+in fact, supported.
+See the section "Dynamically probing for flag bit support"
+below for more details.
+.TP
+.BR SA_EXPOSE_TAGBITS " (since Linux 5.11)"
+Normally, when delivering a signal,
+an architecture-specific set of tag bits are cleared from the
+.I si_addr
+field of
+.IR siginfo_t .
+If this flag is set,
+an architecture-specific subset of the tag bits will be preserved in
+.IR si_addr .
+.IP
+Programs that need to be compatible with Linux versions older than 5.11
+must use
+.B SA_UNSUPPORTED
+to probe for support.
 .SS The siginfo_t argument to a SA_SIGINFO handler
 When the
 .B SA_SIGINFO
@@ -846,6 +884,91 @@ Triggered by a
 .BR seccomp (2)
 filter rule.
 .RE
+.SS Dynamically probing for flag bit support
+The
+.BR sigaction ()
+call on Linux accepts unknown bits set in
+.I act->sa_flags
+without error.
+The behavior of the kernel starting with Linux 5.11 is that a second
+.BR sigaction ()
+will clear unknown bits from
+.IR oldact->sa_flags .
+However, historically, a second
+.BR sigaction ()
+call would typically leave those bits set in
+.IR oldact->sa_flags .
+.PP
+This means that support for new flags cannot be detected
+simply by testing for a flag in
+.IR sa_flags ,
+and a program must test that
+.B SA_UNSUPPORTED
+has been cleared before relying on the contents of
+.IR sa_flags .
+.PP
+Since the behavior of the signal handler cannot be guaranteed
+unless the check passes,
+it is wise to either block the affected signal
+while registering the handler and performing the check in this case,
+or where this is not possible,
+for example if the signal is synchronous, to issue the second
+.BR sigaction ()
+in the signal handler itself.
+.PP
+In kernels that do not support a specific flag,
+the kernel's behavior is as if the flag was not set,
+even if the flag was set in
+.IR act->sa_flags .
+.PP
+The flags
+.BR SA_NOCLDSTOP ,
+.BR SA_NOCLDWAIT ,
+.BR SA_SIGINFO ,
+.BR SA_ONSTACK ,
+.BR SA_RESTART ,
+.BR SA_NODEFER ,
+.BR SA_RESETHAND ,
+and, if defined by the architecture,
+.B SA_RESTORER
+may not be reliably probed for using this mechanism,
+because they were introduced before Linux 5.11.
+However, in general, programs may assume that these flags are supported,
+since they have all been supported since Linux 2.6,
+which was released in the year 2003.
+.PP
+The following example program exits with status 0 if
+.B SA_EXPOSE_TAGBITS
+is determined to be supported, and 1 otherwise.
+.PP
+.EX
+#include <signal.h>
+#include <stdio.h>
+#include <unistd.h>
+
+void handler(int signo, siginfo_t *info, void *context) {
+    struct sigaction oldact;
+    if (sigaction(SIGSEGV, 0, &oldact) == 0 &&
+        !(oldact.sa_flags & SA_UNSUPPORTED) &&
+        (oldact.sa_flags & SA_EXPOSE_TAGBITS)) {
+        _exit(0);
+    } else {
+        _exit(1);
+    }
+}
+
+int main(void) {
+    struct sigaction act = {0};
+    act.sa_flags = SA_SIGINFO | SA_UNSUPPORTED | SA_EXPOSE_TAGBITS;
+    act.sa_sigaction = handler;
+    if (sigaction(SIGSEGV, &act, 0) != 0) {
+        perror("sigaction");
+        return 1;
+    }
+
+    raise(SIGSEGV);
+}
+.EE
 .SH RETURN VALUE
 .BR sigaction ()
 returns 0 on success; on error, \-1 is returned, and
-- 
2.32.0.402.g57bb445576-goog


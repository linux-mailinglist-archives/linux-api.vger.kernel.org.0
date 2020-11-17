Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B46192B72B9
	for <lists+linux-api@lfdr.de>; Wed, 18 Nov 2020 00:55:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbgKQXy4 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 17 Nov 2020 18:54:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbgKQXy4 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 17 Nov 2020 18:54:56 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D34B3C0617A6
        for <linux-api@vger.kernel.org>; Tue, 17 Nov 2020 15:54:55 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id t1so22718pgo.23
        for <linux-api@vger.kernel.org>; Tue, 17 Nov 2020 15:54:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=F67sbUoPJ71YXDG7sdUK0EmBqROtcgMmtrjF66jycJ4=;
        b=Md/nmo4uiAVyWtqr7sCUzbTACIHP4eOwwozR73nab59SpdXPs8GapTu+xjzW6JH2aE
         GhtfmU+lugSfD10mpukhmiFFxA6gkp/sbPB8yqpft1lJ3WHXzK4lqwNG9k10dQv1JEND
         31erme1g+RM0BrFqmT+73UMO86i2vdv+rBA5xBkG/V5kagU8zEPZTS9/QaRq162rltRZ
         LXZunBwniZET8NRFdhhIyl3LQEiF5YI+25bLj61nDddPxmAFCR8drF+PNifaIWTRt9Fx
         pVuRy67Ap5XQxuZZDpiHe/ggdaMv0sMklDkbZTNnIPBqMY/yW8DwLHCJdrW0XzkvFkDt
         iLRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=F67sbUoPJ71YXDG7sdUK0EmBqROtcgMmtrjF66jycJ4=;
        b=MfwPQEhk8l5zh2ydhYnMpza7RXcaw2AGeITS/G0XNvv7BVPsIhQD9gFbBMhEeUDS0V
         m5dN3ISDildsyPUkLGqHi28BhwATVdwCsFFrw+UgNpvv4Bt/SbOhLGYyQ5oM1rx2BnDO
         X4cLjXUbzE2L6KuJE8uAFix8Y4JpB0BJTwhI637x8oMY8ejlQ5NAauoPtj/QtQOO1+sR
         KVsPDMa/2tE6rXDpmzpn8Tc7vUEH1oq6CGpcNxHpSf82RtOyS3ROnxWX3OAGmYbbDYS8
         GOT+dwUCIS195kb1l+ip/nzNQ/Ghjjo01D62xXSXRTadZZSTzL3NgorySrhL3NDcfwCy
         dZ9A==
X-Gm-Message-State: AOAM531kv413rpF62gTBzm1O0/oeqTSC+zw61A3Uw/4izHEbBe4J5mIb
        SRqxk53x5x/Dcn/kDaiKcwfDUIo=
X-Google-Smtp-Source: ABdhPJwlmN1K/jlt1uoHIVnW31y/VSYJ7CSIVvxjavwBUeC71cH00smjXcq31zUDviTB4xHMlEgLniE=
Sender: "pcc via sendgmr" <pcc@pcc-desktop.svl.corp.google.com>
X-Received: from pcc-desktop.svl.corp.google.com ([2620:15c:2ce:0:7220:84ff:fe09:385a])
 (user=pcc job=sendgmr) by 2002:a62:17c8:0:b029:18b:5a97:a8d1 with SMTP id
 191-20020a6217c80000b029018b5a97a8d1mr1823895pfx.15.1605657295349; Tue, 17
 Nov 2020 15:54:55 -0800 (PST)
Date:   Tue, 17 Nov 2020 15:54:47 -0800
Message-Id: <20201117235447.816252-1-pcc@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
Subject: [PATCH v2] sigaction.2: Document SA_EXPOSE_TAGBITS and the flag
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
        Andrey Konovalov <andreyknvl@google.com>,
        linux-api@vger.kernel.org, Helge Deller <deller@gmx.de>,
        David Spickett <david.spickett@linaro.org>,
        linux-man@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Signed-off-by: Peter Collingbourne <pcc@google.com>
---
These features are implemented in this patch series:
  https://lore.kernel.org/linux-arm-kernel/cover.1605235762.git.pcc@google.com/
which is still under review, so the patch should not be applied
yet.

Alejandro, thanks for the review. Since the patch was almost
rewritten I didn't base this on your patch, instead I tried to
use the correct formatting in this patch.

v2:
- fix formatting
- address feedback from Dave

 man2/sigaction.2 | 125 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 125 insertions(+)

diff --git a/man2/sigaction.2 b/man2/sigaction.2
index 6a8142324..0e4236a43 100644
--- a/man2/sigaction.2
+++ b/man2/sigaction.2
@@ -250,6 +250,44 @@ This flag is meaningful only when establishing a signal handler.
 .\" .I sa_sigaction
 .\" field was added in Linux 2.1.86.)
 .\"
+.TP
+.BR SA_UNSUPPORTED
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
+.IR oldact->sa_flags
+may be used as a bitmask
+describing which of the potentially unsupported flags are,
+in fact, supported.
+See the section "Dynamically probing for flag bit support"
+below for more details.
+.TP
+.BR SA_EXPOSE_TAGBITS " (since Linux 5.x)"
+Normally, when delivering a signal,
+an architecture-specific set of tag bits are cleared from the
+.I si_addr
+field of
+.IR siginfo_t .
+If this flag is set,
+an architecture-specific subset of the tag bits will be preserved in
+.IR si_addr .
+.IP
+Programs that need to be compatible with Linux versions older than 5.x
+must use
+.B SA_UNSUPPORTED
+to probe for support.
 .SS The siginfo_t argument to a SA_SIGINFO handler
 When the
 .B SA_SIGINFO
@@ -833,6 +871,93 @@ Triggered by a
 .BR seccomp (2)
 filter rule.
 .RE
+.SS Dynamically probing for flag bit support
+The
+.BR sigaction ()
+call on Linux accepts unknown bits set in
+.I act->sa_flags
+without error.
+The behavior of the kernel starting with Linux 5.x is that a second
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
+because they were introduced before Linux 5.x.
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
+  struct sigaction oldact;
+  if (sigaction(SIGSEGV, 0, &oldact) == 0 &&
+      !(oldact.sa_flags & SA_UNSUPPORTED) &&
+      (oldact.sa_flags & SA_EXPOSE_TAGBITS)) {
+    _exit(0);
+  } else {
+    _exit(1);
+  }
+}
+
+int main(void) {
+  struct sigaction act = {};
+  act.sa_flags = SA_SIGINFO | SA_UNSUPPORTED | SA_EXPOSE_TAGBITS;
+  act.sa_sigaction = handler;
+  if (sigaction(SIGSEGV, &act, 0) != 0) {
+    perror("sigaction");
+    return 1;
+  }
+
+  /* Force a SIGSEGV. */
+  *(volatile int *)0 = 0;
+  return 1;
+}
+.EE
 .SH RETURN VALUE
 .BR sigaction ()
 returns 0 on success; on error, \-1 is returned, and
-- 
2.29.2.299.gdc1121823c-goog


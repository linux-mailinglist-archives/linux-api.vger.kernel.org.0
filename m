Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22DEF3C6829
	for <lists+linux-api@lfdr.de>; Tue, 13 Jul 2021 03:39:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbhGMBl6 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 12 Jul 2021 21:41:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233491AbhGMBlv (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 12 Jul 2021 21:41:51 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 668CEC0613E9
        for <linux-api@vger.kernel.org>; Mon, 12 Jul 2021 18:39:01 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id 12-20020ac8570c0000b02902520e309f5dso11371720qtw.8
        for <linux-api@vger.kernel.org>; Mon, 12 Jul 2021 18:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=S3Wii2PyRZQO2OtmxcTVnGt9js4+EH2ry2mkpjbEdlE=;
        b=nzQUAZ1GYvknrVwxrh0lgikVtRIXfhnrORO3nXyMwP0F7lB3NbGmszB3786OS4x6qf
         dnlbI9meyD7JO59yJNuyvMH3JuOWU1EDjFwo2T8wi+BK/9T+H6ALE0UPSvKsRp6LB3Tb
         AceWkGjDgT9uzEv1amInfcrUPUUW002B/xFdloCbRWzZ+2qwdLnumT9uBOe503s/Yst0
         iwpVPrPpE9E7HkShQZIifHmLjU/ltgpgypSe4qNk+BKkmuVmeXAT2mwaZNRKeXqRTsce
         uDBUbnezlmSjSqNSU7XIiZWYPka6VbiYwamweHZPzXBKUlJRx3gBLO7i/zngqaRjGFm7
         NfmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=S3Wii2PyRZQO2OtmxcTVnGt9js4+EH2ry2mkpjbEdlE=;
        b=e5j3JU8fyCnPcx5d6gDMoNwZMa2UqYQqjs7vlg5Nr8JDKVgvOWGM7dBdZZ2pVtk6JT
         yLmp29I0Uro6v/zDx2+0JITom5iIQa1NDn+nmmtW62ObunJM1orvXq3Ob5taUIb2a+0u
         n7dLOE0vo8M2zK1zdDUFx+Nms1PeYAtFuYTvEDgXuhv4ZK+DOwLX4s+jMea2RIt0sTlp
         yKLP5Lrow+4P115Huq6o4yAijz/QNIAW9wqLrs62PV5I8MawEdHBIiKjUmghpYGNhd14
         wq2NdwJ8r4EaX7HINWNEpQXh8E1Tlj4VTzbu8ra48MdX9P691aKXNqycx/GnQBuVIQX5
         gBSQ==
X-Gm-Message-State: AOAM5326ubXiEdYCWudRkMXISlIrKltOiyTTJRohE5sj5WBhNUHqcR4I
        pMkHTNFxB4e/Bn0Rr7FQ/BKXbz4=
X-Google-Smtp-Source: ABdhPJw1p94roLuMlaAO8me3nT8WYuLNraxllNXIec9KgctyxfyVbU1pJGp2xX1xFCgddw9Fcj6PJVg=
X-Received: from pcc-desktop.svl.corp.google.com ([2620:15c:2ce:200:5ef:57d6:e87d:2958])
 (user=pcc job=sendgmr) by 2002:a05:6214:68d:: with SMTP id
 r13mr2186600qvz.36.1626140340164; Mon, 12 Jul 2021 18:39:00 -0700 (PDT)
Date:   Mon, 12 Jul 2021 18:38:57 -0700
Message-Id: <20210713013857.3237634-1-pcc@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
Subject: [PATCH v3] sigaction.2: Document SA_EXPOSE_TAGBITS and the flag
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
This feature landed back in 5.11, but the manpage
update seems to have fallen through the cracks.
Here's a v3 with the introducing version specified
and with one formatting nit fixed.

v3:
- s/5.x/5.11/g
- s/.IR/.I/ in one location

v2:
- fix formatting
- address feedback from Dave

 man2/sigaction.2 | 125 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 125 insertions(+)

diff --git a/man2/sigaction.2 b/man2/sigaction.2
index 57ad6418c..6b90982d4 100644
--- a/man2/sigaction.2
+++ b/man2/sigaction.2
@@ -261,6 +261,44 @@ This flag is meaningful only when establishing a signal handler.
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
@@ -846,6 +884,93 @@ Triggered by a
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
2.32.0.93.g670b81a890-goog


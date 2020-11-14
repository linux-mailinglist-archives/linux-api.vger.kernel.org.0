Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC7192B3126
	for <lists+linux-api@lfdr.de>; Sat, 14 Nov 2020 23:22:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726125AbgKNWWO (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sat, 14 Nov 2020 17:22:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbgKNWWM (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sat, 14 Nov 2020 17:22:12 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A265C0613D1;
        Sat, 14 Nov 2020 14:22:10 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id a3so19938665wmb.5;
        Sat, 14 Nov 2020 14:22:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3ssMnzK9+Tf5itgz6j0CoOgfa2ffAC9LTASibshJr7o=;
        b=hnY5QsMEXhC2aY5D4KCLUqThyzz7f6UwD5tvwgjGjlyXfzwk4khtvneMwXflhb1i/h
         o+DDeo0ocgQyx/46vED99y/hQxpNZUf+pEZ6McAYDkKk9R/K0cEFQpZNNpPW6Tz3eiVS
         mVNEAhuOdDS4nZcfwDd5wr+u6KQTF2EIquOb7Ka5ZLB0vKWXBionjLFBmn6fqTzlzzOK
         QSSRUdpOhZG+si0IXh1R0tOhx7lvONO0xsrvZgg22Del1ZrRh4AOQMPdG9xf/logGRQ+
         kiUGwz3PcnVt5EzVG1/4e+FUkpLtD8tvu4ohYVHBmqKLCDuBgwz49nsPYF8GpzScF+E5
         F80g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3ssMnzK9+Tf5itgz6j0CoOgfa2ffAC9LTASibshJr7o=;
        b=GXqOgqACHpFouclCdHrVOZguTZZchgaP6yEjHx5UQpE79j2uT6qNrBfOaDGctJFKzi
         6bFNobkk7lsgcD/wK9PzzpFAYFqaSJs3jjrzmuuMJ98BnIYavmL98fSx/84aoD8C6s1K
         0Tv+QafGo21Q1PNFPNo3X74AoQOawGUdcuHxN8TyuqeVtpVyZRGeckjfIJE44K+ZyTDa
         S1siWf51rC2Dfj81RzGXZiHzXLZdTXUi1dndnqHrBFqJx0O+EFOKDVw8PL8F/Wv/t3qo
         cut0TRbTMigAxV5O/RFZxGj3ibnKumEFQjspLkI4ZZ+D11D9o2QVDyTa0GEGQEQsRKoQ
         f6Ww==
X-Gm-Message-State: AOAM532KcNv6tIn/X64tzm1gIpxcsWRqHuel2a4/ClkVWbOdsVpt9Bci
        fFqlFWxFiFwMIIzb0g/CN5Q=
X-Google-Smtp-Source: ABdhPJwUusLonRJPfLhID5eqG5hv9dEooBLirv2Q0V3Al1ERtM61F/Ze8oONhADBQzsOzTKlzXYPtw==
X-Received: by 2002:a1c:4302:: with SMTP id q2mr8543859wma.182.1605392528005;
        Sat, 14 Nov 2020 14:22:08 -0800 (PST)
Received: from localhost.localdomain ([170.253.49.0])
        by smtp.googlemail.com with ESMTPSA id 89sm16826357wrp.58.2020.11.14.14.22.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2020 14:22:07 -0800 (PST)
From:   Alejandro Colomar <alx.manpages@gmail.com>
X-Google-Original-From: Alejandro Colomar <colomar.6.4.3@gmail.com>
To:     pcc@google.com, mtk.manpages@gmail.com
Cc:     Dave.Martin@arm.com, James.Bottomley@hansenpartnership.com,
        andreyknvl@google.com, catalin.marinas@arm.com,
        david.spickett@linaro.org, deller@gmx.de, ebiederm@xmission.com,
        eugenis@google.com, kcc@google.com, kevin.brodsky@arm.com,
        linux-api@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-man@vger.kernel.org, oleg@redhat.com,
        vincenzo.frascino@arm.com, will@kernel.org,
        Alejandro Colomar <alx.manpages@gmail.com>
Subject: [PATCH] sigaction.2: Document SA_EXPOSE_TAGBITS and the flag support detection protocol
Date:   Sat, 14 Nov 2020 22:49:15 +0100
Message-Id: <20201114214914.177815-1-colomar.6.4.3@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201114014132.2439310-1-pcc@google.com>
References: <20201114014132.2439310-1-pcc@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

From: Peter Collingbourne <pcc@google.com>

Signed-off-by: Peter Collingbourne <pcc@google.com>
[alx: srcfix + ffix]
Cowritten-by: Alejandro Colomar <alx.manpages@gmail.com>
Signed-off-by: Alejandro Colomar <alx.manpages@gmail.com>
---

Hi Michael,

as Peter noted, this patch is not ready
(code hasn't been merged into the kernel yet).

And a spin-off question:
How would you prefer it?:
[
.B SA_*
] (there are 79 similar cases in the pages [1])
or
[
.BR SA_ *
] (there are 3 similar cases in the pages [2])


Hi Peter,

I improved a few minor things in your patch:

- Use semantic newlines (see man-pages(7)).
- Change explicit blank lines to [.PP]
  (see 'Formatting conventions(general)' in man-pages(7)).
- Use Oxford comma.


Thanks,

Alex


[1](grep -r "_\*" man? | wc -l)
[2](grep -r "_ \*" man? | wc -l)

 man2/sigaction.2 | 65 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/man2/sigaction.2 b/man2/sigaction.2
index 22da658d0..91c46f3e3 100644
--- a/man2/sigaction.2
+++ b/man2/sigaction.2
@@ -251,6 +251,19 @@ This flag is meaningful only when establishing a signal handler.
 .\" .I sa_sigaction
 .\" field was added in Linux 2.1.86.)
 .\"
+.TP
+.BR SA_UNSUPPORTED " (since Linux 5.??)"
+This flag bit will never be supported by the kernel.
+It is used as part of the flag support detection protocol described below.
+.TP
+.BR SA_EXPOSE_TAGBITS " (since Linux 5.??)"
+Normally, when delivering a signal,
+an architecture-specific set of tag bits are cleared from the
+.I si_addr
+field of
+.IR siginfo_t .
+If this flag is set, the tag bits will be preserved in
+.IR si_addr .
 .SS The siginfo_t argument to a SA_SIGINFO handler
 When the
 .B SA_SIGINFO
@@ -834,6 +847,58 @@ Triggered by a
 .BR seccomp (2)
 filter rule.
 .RE
+.SS Detecting flag support in sa_flags
+The Linux kernel supports a mechanism for programs to
+detect kernel support for
+.B SA_*
+flags in
+.IR sa_flags .
+This mechanism is quite subtle for backwards compatibility reasons
+related to the historical behavior of the kernel.
+.PP
+Starting with Linux 5.??,
+the kernel will clear any unrecognized bits from the
+.I sa_flags
+value returned via
+.I oldact
+if those bits were set when the signal handler was originally installed.
+Therefore, a program that only needs to be compatible with
+Linux 5.?? and above
+may test for flag bit support by issuing a second call to
+.BR sigaction ()
+and testing whether the bit remains set in
+.IR oldact.sa_flags .
+.PP
+Prior to Linux 5.x, unrecognized flag bits were preserved in
+.I oldact.sa_flags
+so this protocol on its own would not be sufficient to allow a
+userspace program to test for flag bit support
+if it needs to be compatible with kernel versions older than 5.??.
+Therefore, the
+.B SA_UNSUPPORTED
+flag bit was defined,
+which the kernel will always consider to be unknown.
+A userspace program that sets this flag bit in
+.I act.sa_flags
+and finds that it has been cleared in
+.I oldact.sa_flags
+in a subsequent call to
+.BR sigaction ()
+may trust that any other unknown flag bits have been cleared.
+.PP
+A reasonably modern program may trust that the flags
+.BR SA_NOCLDSTOP ,
+.BR SA_NOCLDWAIT ,
+.BR SA_SIGINFO ,
+.BR SA_ONSTACK ,
+.BR SA_RESTART ,
+.BR SA_NODEFER ,
+.BR SA_RESETHAND ,
+and, if defined by the architecture,
+.B SA_RESTORER
+are supported by the kernel,
+without relying on the flag bit support detection protocol,
+since these flags have all been supported since Linux 2.6.
 .SH RETURN VALUE
 .BR sigaction ()
 returns 0 on success; on error, \-1 is returned, and
-- 
2.28.0


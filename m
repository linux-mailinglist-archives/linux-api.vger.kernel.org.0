Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AA052B2A7F
	for <lists+linux-api@lfdr.de>; Sat, 14 Nov 2020 02:43:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726255AbgKNBls (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 13 Nov 2020 20:41:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726105AbgKNBls (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 13 Nov 2020 20:41:48 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 982A6C0613D1
        for <linux-api@vger.kernel.org>; Fri, 13 Nov 2020 17:41:46 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id b34so3970213pgb.18
        for <linux-api@vger.kernel.org>; Fri, 13 Nov 2020 17:41:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=7gRXkAxv9FSHZJPu4qkNB+4GIdmBPg8D68cb6lJq7ZA=;
        b=Sxa78iw0YlEtV3CRU86rl3UfFmqcBLywcZKQOkIKC3UotS733oOkm+Cn/tJqRcd8gT
         XvQcCEy4d510dKGngdtqB5wMwMS6m28PyxLcs9a/vLaF4/1qIgxhF6GtOnuoaPoQe0d/
         6o4JwUmUcXf1KczGy9fGk0xiiULruqlE2pukgY3IC4k/RwwPOE7jkeRV3LPo9TZYHjWy
         Bgm0IhRc/whIIQYWvjGCxHOWDku+zZwj/lo+7s/tM30lnUCyzhUzZ4vTsoMK5DKwi84y
         hOIkuog3ff4gunpKiL510SwRYfhimj6ktf7bRly/DnWWhcgocXmaEVCS97wipLzfGGPk
         XExQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=7gRXkAxv9FSHZJPu4qkNB+4GIdmBPg8D68cb6lJq7ZA=;
        b=PHuJ/tneUx6k151PRJqBjJufBC6G3kmnugMyKcDOCfV6wUmWP1HZJNkJxFbiOnY7Kb
         qHLETGlkbBLCO1hADXDiNydG6PHBf8yf5btm/Ex6xcfFfZ5SacnxYDojcvN0N0cM/ZHX
         oJ4i3A2d0Eb/W5hsw6MeIC1d5vExTNJILw47CWv8FFPKDgcb2DDLCHRiXtgaZFijsgEE
         T9+l1vgLWxCi1xl0pMoum9/TkdRHuPonKDtJYIlVG13ru9Lnk2QuvMajp7F4YbL2tTfG
         UnxAV9Z1kqToWMJunZhgTuVaBX7OHvU3gg5VtftgKpbCYrO9LfHITqHVgqnVUjuTUWnl
         7YIg==
X-Gm-Message-State: AOAM531qDYBERDT8AI3G6+/LZZqq7essIpXtAKsbe+QCP6mszFOaZMif
        e5gLV9DfYl36AH2kksHVbBucjv8=
X-Google-Smtp-Source: ABdhPJwXH636vTk98vGGJZ3D7xTHRzsIDuD+3UJjwyqN+hdtllDfwf0FWiAihLbQJfFWgfM+M3ZFqts=
Sender: "pcc via sendgmr" <pcc@pcc-desktop.svl.corp.google.com>
X-Received: from pcc-desktop.svl.corp.google.com ([2620:15c:2ce:0:7220:84ff:fe09:385a])
 (user=pcc job=sendgmr) by 2002:a17:902:a9c9:b029:d6:2d8f:f7b4 with SMTP id
 b9-20020a170902a9c9b02900d62d8ff7b4mr4501708plr.2.1605318106075; Fri, 13 Nov
 2020 17:41:46 -0800 (PST)
Date:   Fri, 13 Nov 2020 17:41:32 -0800
Message-Id: <20201114014132.2439310-1-pcc@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
Subject: [PATCH] sigaction.2: Document SA_EXPOSE_TAGBITS and the flag support
 detection protocol
From:   Peter Collingbourne <pcc@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Will Deacon <will@kernel.org>, Oleg Nesterov <oleg@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>
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

---
These features are implemented in this patch series:
  https://lore.kernel.org/linux-arm-kernel/cover.1605235762.git.pcc@google.com/
which is still under review, so the patch should not be applied
yet.

 man2/sigaction.2 | 62 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/man2/sigaction.2 b/man2/sigaction.2
index 6a8142324..82fb69e26 100644
--- a/man2/sigaction.2
+++ b/man2/sigaction.2
@@ -250,6 +250,19 @@ This flag is meaningful only when establishing a signal handler.
 .\" .I sa_sigaction
 .\" field was added in Linux 2.1.86.)
 .\"
+.TP
+.BR SA_UNSUPPORTED " (since Linux 5.x)"
+This flag bit will never be supported by the kernel. It is used as
+part of the flag support detection protocol described below.
+.TP
+.BR SA_EXPOSE_TAGBITS " (since Linux 5.x)"
+Normally, when delivering a signal, an architecture-specific
+set of tag bits are cleared from the
+.I si_addr
+field of
+.IR siginfo_t .
+If this flag is set, the tag bits will be preserved in
+.IR si_addr .
 .SS The siginfo_t argument to a SA_SIGINFO handler
 When the
 .B SA_SIGINFO
@@ -833,6 +846,55 @@ Triggered by a
 .BR seccomp (2)
 filter rule.
 .RE
+.SS Detecting flag support in sa_flags
+The Linux kernel supports a mechanism for programs to detect kernel
+support for
+.B SA_*
+flags in
+.IR sa_flags .
+This mechanism is quite subtle for backwards compatibility reasons
+related to the historical behavior of the kernel.
+
+Starting with Linux 5.x, the kernel will clear any unrecognized bits
+from the
+.I sa_flags
+value returned via
+.I oldact
+if those bits were set when the signal handler was originally installed.
+Therefore, a program that only needs to be compatible with Linux 5.x
+and above may test for flag bit support by issuing a second call to
+.BR sigaction ()
+and testing whether the bit remains set in
+.IR oldact.sa_flags .
+
+Prior to Linux 5.x, unrecognized flag bits were preserved in
+.I oldact.sa_flags
+so this protocol on its own would not be sufficient to allow a
+userspace program to test for flag bit support if it needs to be
+compatible with kernel versions older than 5.x. Therefore, the
+.B SA_UNSUPPORTED
+flag bit was defined, which the kernel will always consider to be
+unknown. A userspace program that sets this flag bit in
+.I act.sa_flags
+and finds that it has been cleared in
+.I oldact.sa_flags
+in a subsequent call to
+.BR sigaction ()
+may trust that any other unknown flag bits have been cleared.
+
+A reasonably modern program may trust that the flags
+.BR SA_NOCLDSTOP ,
+.BR SA_NOCLDWAIT ,
+.BR SA_SIGINFO ,
+.BR SA_ONSTACK ,
+.BR SA_RESTART ,
+.BR SA_NODEFER ,
+.B SA_RESETHAND
+and, if defined by the architecture,
+.B SA_RESTORER
+are supported by the kernel, without relying on the flag bit support
+detection protocol, since these flags have all been supported
+since Linux 2.6.
 .SH RETURN VALUE
 .BR sigaction ()
 returns 0 on success; on error, \-1 is returned, and
-- 
2.29.2.299.gdc1121823c-goog


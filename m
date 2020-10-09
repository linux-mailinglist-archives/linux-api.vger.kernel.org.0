Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C41F2287F87
	for <lists+linux-api@lfdr.de>; Fri,  9 Oct 2020 02:44:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728890AbgJIAo1 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 8 Oct 2020 20:44:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725852AbgJIAo1 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 8 Oct 2020 20:44:27 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56057C0613D2
        for <linux-api@vger.kernel.org>; Thu,  8 Oct 2020 17:44:27 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id v7so4810514plp.23
        for <linux-api@vger.kernel.org>; Thu, 08 Oct 2020 17:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=wgLDmet0HQ/Xo2ByGpci+vz8VBS9/9z68p4dWkDW0X8=;
        b=fC1SgTU+dqQL8OvzSShRrO2Scq85nI6Xq3wmeRZWZ9JYtRCu+iZTYXS3G0oAPBovcf
         ddUQrG9eazCPogzxEbiqEJhBJZi2EiLu6zPRMF2bmGek9bFKPdXjwCQWLHoMO2ivwkhb
         28Bf+87z+INzm23aAwDo3RKCdZq4BCwAzf5QOh3AblLB4h1NFRDtD2h05MsqUoLKgDKy
         JL9IyfxlCOgfM4KaXREugnJduaQDeiuEB6W/4pcD7pi3Qwz5me1vsuZhaMlJLul07led
         M2oD1T1vWVCVehvdHcm+wrQLPbfTcQABwd2AEOpbPNCuGvyI8vTG/060IhfS/UaXHJB/
         RS9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=wgLDmet0HQ/Xo2ByGpci+vz8VBS9/9z68p4dWkDW0X8=;
        b=OXBSBEgYnysrNS+73OVe7cTWt/VeVGSr/kQGqkWKTT+e9ZmDKbVd+qSsDWb95w6Buv
         n4EaVqWTxvexQ1bwSc7/ht8NLA31se+Isp52XNo3Rqr5n1NsQoH7WYvFKiOVnR1wxujn
         23py45qMdREj3fWUqPGD+I+ltOgZt2GYEqmSKeGFBd19Nte68knxt4mfNxI6G/VButxA
         bds0nIEhbRqb+fgBeV7gwkzsbhOyhATzEWzuHkzdt5OvOhY8fzzJMAiaSiYWRkLvf7dZ
         QNkYJPGywyUfLQDTcm3AdTmk3MSDQ74l5gxakfCiJcvQOfhVxW2hvqArGpcnUvgl5DUx
         egYA==
X-Gm-Message-State: AOAM5302qDx9Nu/xZErfEFMmUDCAqJzUL2b23bIsjY0241qdLnED+MKa
        MGU9SgSnclU+QzCSXKc62xn8Orc=
X-Google-Smtp-Source: ABdhPJzrYThPrARCgXTOK3iFT+O4tYAwz1aOLL12BpI4pcGQowJXbqoXR7qHKJn+te3MZ10OGk2nNOI=
Sender: "pcc via sendgmr" <pcc@pcc-desktop.svl.corp.google.com>
X-Received: from pcc-desktop.svl.corp.google.com ([2620:15c:2ce:0:7220:84ff:fe09:385a])
 (user=pcc job=sendgmr) by 2002:a17:90b:891:: with SMTP id bj17mr1629152pjb.44.1602204266808;
 Thu, 08 Oct 2020 17:44:26 -0700 (PDT)
Date:   Thu,  8 Oct 2020 17:44:11 -0700
Message-Id: <cover.1602204097.git.pcc@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.1011.ga647a8990f-goog
Subject: [PATCH v11 0/8] arm64: expose FAR_EL1 tag bits in siginfo
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

The kernel currently clears the tag bits (i.e. bits 56-63) in the fault
address exposed via siginfo.si_addr and sigcontext.fault_address. However,
the tag bits may be needed by tools in order to accurately diagnose
memory errors, such as HWASan [1] or future tools based on the Memory
Tagging Extension (MTE).

We should not stop clearing these bits in the existing fault address
fields, because there may be existing userspace applications that are
expecting the tag bits to be cleared. Instead, create a new pair of
union fields in siginfo._sigfault, and store the tag bits of FAR_EL1
there, together with a mask specifying which bits are valid.

However, one does not simply add fields to siginfo, at least not without
a mechanism for userspace to detect that they are present and valid.
Therefore, the first seven patches in this series introduce a mechanism
for userspace to detect the presence of our new siginfo fields,
and the last patch uses it to advertise the presence of said fields.

The series can be viewed on Gerrit here:
https://linux-review.googlesource.com/q/Ia8876bad8c798e0a32df7c2ce1256c4771c81446

[1] http://clang.llvm.org/docs/HardwareAssistedAddressSanitizerDesign.html

Helge Deller (1):
  parisc: Drop parisc special case for __sighandler_t

Peter Collingbourne (7):
  parisc: start using signal-defs.h
  arch: move SA_* definitions to generic headers
  signal: clear non-uapi flag bits when passing/returning sa_flags
  signal: define the SA_UNSUPPORTED bit in sa_flags
  signal: deduplicate code dealing with common _sigfault fields
  signal: define the field siginfo.si_xflags
  arm64: expose FAR_EL1 tag bits in siginfo

 Documentation/arm64/tagged-pointers.rst    |  21 +++-
 arch/alpha/include/uapi/asm/signal.h       |  14 ---
 arch/arm/include/asm/signal.h              |   2 +
 arch/arm/include/uapi/asm/signal.h         |  28 +----
 arch/arm64/include/asm/exception.h         |   2 +-
 arch/arm64/include/asm/signal.h            |  17 +++
 arch/arm64/include/asm/system_misc.h       |   2 +-
 arch/arm64/include/asm/traps.h             |   6 +-
 arch/arm64/kernel/debug-monitors.c         |   5 +-
 arch/arm64/kernel/entry-common.c           |   2 -
 arch/arm64/kernel/ptrace.c                 |   7 +-
 arch/arm64/kernel/sys_compat.c             |   5 +-
 arch/arm64/kernel/traps.c                  |  29 ++---
 arch/arm64/mm/fault.c                      |  59 ++++-----
 arch/h8300/include/uapi/asm/signal.h       |  24 ----
 arch/ia64/include/uapi/asm/signal.h        |  24 ----
 arch/m68k/include/uapi/asm/signal.h        |  24 ----
 arch/mips/include/uapi/asm/signal.h        |  12 --
 arch/parisc/include/asm/signal.h           |   2 +
 arch/parisc/include/uapi/asm/signal.h      |  34 +-----
 arch/powerpc/include/uapi/asm/signal.h     |  24 ----
 arch/powerpc/platforms/powernv/vas-fault.c |   1 +
 arch/s390/include/uapi/asm/signal.h        |  24 ----
 arch/sparc/include/uapi/asm/signal.h       |   4 +-
 arch/x86/include/uapi/asm/signal.h         |  24 ----
 arch/x86/kernel/signal_compat.c            |  11 +-
 arch/xtensa/include/uapi/asm/signal.h      |  24 ----
 include/linux/compat.h                     |   4 +
 include/linux/signal.h                     |  29 +++++
 include/linux/signal_types.h               |  12 ++
 include/uapi/asm-generic/siginfo.h         |  14 +++
 include/uapi/asm-generic/signal-defs.h     |  58 +++++++++
 include/uapi/asm-generic/signal.h          |  29 -----
 include/uapi/linux/ptrace.h                |  12 ++
 kernel/ptrace.c                            |  32 ++++-
 kernel/signal.c                            | 134 +++++++++++----------
 36 files changed, 328 insertions(+), 427 deletions(-)
 create mode 100644 arch/arm64/include/asm/signal.h

-- 
2.28.0.1011.ga647a8990f-goog


Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0169B2A6F73
	for <lists+linux-api@lfdr.de>; Wed,  4 Nov 2020 22:18:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730574AbgKDVSU (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 4 Nov 2020 16:18:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726152AbgKDVSU (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 4 Nov 2020 16:18:20 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFBA7C0613D3
        for <linux-api@vger.kernel.org>; Wed,  4 Nov 2020 13:18:18 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id p63so118301ybc.7
        for <linux-api@vger.kernel.org>; Wed, 04 Nov 2020 13:18:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=cuLwzoZx7Fk9HE0G2CFWiG+xOnjHMGBrKLR1e4PXIW0=;
        b=Q3HiY3Ox60/4Sh+YrXrcYC/m4poSKxf4mQC6xIEsFnOv5CTjEN1oBsjnxOQWW5fZQh
         nKJdrlkAQhoCiqXqYH2mh34g91jxnfvanPfaUCnbjaOON6/RSxA0LGiuUK4dJxmP1jQF
         G2U8Bh6Jd7ozIw6Wx77/FxkTcAlP9GXQSj3QK7PwIHAS8ssn3HwwY6Wyt2RPTbTmEsig
         NAUL6p8oQx6ooEoBz0bdiWFE0ryVa2icSlyyF8lI8fAfTkR/WU3K25+57pyap4/WGFaK
         PE6IYSLp/X9/mPf4EfNWEcv/P0spmgTmfluU/JfbMzzzMCc/xHyj5v4UF+xwOyjNv0y/
         ESiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=cuLwzoZx7Fk9HE0G2CFWiG+xOnjHMGBrKLR1e4PXIW0=;
        b=rEPxggapGkuwSroM9RqhBec1Zcg6tfKZtxF1a/5dw2olJVpf7aEgOROJIBpxXTjqQt
         LXYDzQOH1VdaGjKjDNWQ6onsOa92vNGxMFqZHIbNbWjTKFJ/nnFiWQBD/aR16kdTC4Y2
         Y0eFZNCUudaLWS1GjFjHvH7o7HKqDiUE6P0LW/+8lcjiFxdhdlhRN9FEqsBhPGXKSuml
         0QHi+otggmKnPcoysJgHVFtt7miQWrT2LXa4Fl9595ROtLYdOuJQLwuo64mL72gaO13r
         OApoTMk8A5II+WOwfzyn9q+sdGoWe9t93e9426lxn/ShpS2Iqww0IcpgFT51ClEWBN4R
         COsw==
X-Gm-Message-State: AOAM531ro+wAudLmyOtCu6z8itH7yfb+VD3KEQZJL09e2PT0IlqXsEmy
        GMOkq+nFOH+fraIPQTfx0CLME9E=
X-Google-Smtp-Source: ABdhPJwk7uVrLU5g3VOrgOCTiWTr2GTYc9lpO92ajBOkg27LLvNuEcBtfG8EbDAqgSYd6bcRCrYv4S4=
Sender: "pcc via sendgmr" <pcc@pcc-desktop.svl.corp.google.com>
X-Received: from pcc-desktop.svl.corp.google.com ([2620:15c:2ce:0:7220:84ff:fe09:385a])
 (user=pcc job=sendgmr) by 2002:a25:2fc3:: with SMTP id v186mr36015631ybv.448.1604524697999;
 Wed, 04 Nov 2020 13:18:17 -0800 (PST)
Date:   Wed,  4 Nov 2020 13:18:03 -0800
Message-Id: <cover.1604523707.git.pcc@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [PATCH v14 0/8] arm64: expose FAR_EL1 tag bits in siginfo
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
  signal: deduplicate code dealing with common _sigfault fields
  signal: clear non-uapi flag bits when passing/returning sa_flags
  signal: define the SA_UNSUPPORTED bit in sa_flags
  signal: define the field siginfo.si_faultflags
  arm64: expose FAR_EL1 tag bits in siginfo

 Documentation/arm64/tagged-pointers.rst    |  21 +++-
 arch/alpha/include/uapi/asm/signal.h       |  14 ---
 arch/arm/include/asm/signal.h              |   2 +
 arch/arm/include/uapi/asm/signal.h         |  27 +----
 arch/arm64/include/asm/exception.h         |   2 +-
 arch/arm64/include/asm/signal.h            |  31 +++++
 arch/arm64/include/asm/system_misc.h       |   2 +-
 arch/arm64/include/asm/traps.h             |   6 +-
 arch/arm64/kernel/debug-monitors.c         |   5 +-
 arch/arm64/kernel/entry-common.c           |   2 -
 arch/arm64/kernel/ptrace.c                 |   7 +-
 arch/arm64/kernel/sys_compat.c             |   5 +-
 arch/arm64/kernel/traps.c                  |  29 ++---
 arch/arm64/mm/fault.c                      |  68 ++++++-----
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
 arch/x86/kernel/signal_compat.c            |  19 +--
 arch/xtensa/include/uapi/asm/signal.h      |  24 ----
 include/linux/compat.h                     |   4 +
 include/linux/signal.h                     |  29 +++++
 include/linux/signal_types.h               |  12 ++
 include/uapi/asm-generic/siginfo.h         |  17 +++
 include/uapi/asm-generic/signal-defs.h     |  58 +++++++++
 include/uapi/asm-generic/signal.h          |  29 -----
 include/uapi/linux/ptrace.h                |  12 ++
 kernel/ptrace.c                            |  33 ++++-
 kernel/signal.c                            | 134 +++++++++++----------
 36 files changed, 361 insertions(+), 428 deletions(-)
 create mode 100644 arch/arm64/include/asm/signal.h

-- 
2.29.1.341.ge80a0c044ae-goog


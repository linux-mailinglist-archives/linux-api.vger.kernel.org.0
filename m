Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 336A72A3B49
	for <lists+linux-api@lfdr.de>; Tue,  3 Nov 2020 05:10:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725952AbgKCEKC (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 2 Nov 2020 23:10:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725940AbgKCEKB (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 2 Nov 2020 23:10:01 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB67CC0617A6
        for <linux-api@vger.kernel.org>; Mon,  2 Nov 2020 20:10:01 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id h64so16572708ybc.1
        for <linux-api@vger.kernel.org>; Mon, 02 Nov 2020 20:10:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=uAiEpKASH8iqjNYFoK75cypB8AjyRgyBk1UTuJ1P6NU=;
        b=lTZkTDm48P26bPagiw7Bh20cBiBBcMZdiGUt8bmrieDh0q2iy0jeonQ004QEzd+HJ4
         YhznNIbSrIgYY+9cY+NDyY1RWKA0ZR//afqRyoiax/ddnL9uYImrpAObrb6Uz8dCGZnN
         Vy9/pq2JRLrfLv/X/7nWaiZbwDj+l42q5+7Xz2kfTkrHRThp0kD8gnHNtELTWgrgrunZ
         BlhJX2erGQgjO+QdZwj1o3sm4d3vZqcwCf2tL8twpzzwuC3dkJIeuIt4vQiK6AnUlHvg
         LgckQwdghI0ZS69KXKsrAf32SG4LI4tKMnOQDLLFX55Fsf6XzNXrd5dHm+WaGPvUWl6L
         9bJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=uAiEpKASH8iqjNYFoK75cypB8AjyRgyBk1UTuJ1P6NU=;
        b=BcguKu4nMi8emior4mx/k0vSH8WXeXzkINEdnhqnymneBFLNYlspvpeaJoInZ1NAvH
         If5uCovN9AryhrWNgWUPIZm8kxUYENXKlwh73Z1sPsTLjY4EMKhwqvlVn/ow2AnPCyvP
         EzXzqelljZEWpHeF9SC2T95bcOxjoJTSQnjNHbEg0HgvWOxPxuUKhTjbCZvzy3KxWDvW
         supbLigZt/4xM3HuP7u1ctQAY2ERPKAah6j1bgWnXYfFC8cfSxa72neNkTShr9QSx0dM
         5mHdKUk9YUcsoUUuzxt+nW/aocLcG0BJxnE9RnZiiiuWJzUPXU/Z2/6/eM8Bqp/aOPcf
         CfzQ==
X-Gm-Message-State: AOAM530+TUoOWqEyGNFDF+Kj/Ar1QFmL9nRDermM+TWlaXC1VEfz3tgv
        WQzPUaudlWBo2eMAu4dfI/mil38=
X-Google-Smtp-Source: ABdhPJx+PEslaazxsV3hqP6Bt/sQ97ntHbzGbXce79z6vc/cPjAYvoVABeTDwoz/elgw1lm7aq4BrZs=
Sender: "pcc via sendgmr" <pcc@pcc-desktop.svl.corp.google.com>
X-Received: from pcc-desktop.svl.corp.google.com ([2620:15c:2ce:0:7220:84ff:fe09:385a])
 (user=pcc job=sendgmr) by 2002:a25:3417:: with SMTP id b23mr24817690yba.97.1604376600827;
 Mon, 02 Nov 2020 20:10:00 -0800 (PST)
Date:   Mon,  2 Nov 2020 20:09:36 -0800
Message-Id: <cover.1604376407.git.pcc@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [PATCH v13 0/8] arm64: expose FAR_EL1 tag bits in siginfo
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
  signal: define the field siginfo.si_faultflags
  arm64: expose FAR_EL1 tag bits in siginfo

 Documentation/arm64/tagged-pointers.rst    |  21 +++-
 arch/alpha/include/uapi/asm/signal.h       |  14 ---
 arch/arm/include/asm/signal.h              |   2 +
 arch/arm/include/uapi/asm/signal.h         |  28 +----
 arch/arm64/include/asm/exception.h         |   2 +-
 arch/arm64/include/asm/signal.h            |  19 +++
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
 include/uapi/asm-generic/siginfo.h         |  14 +++
 include/uapi/asm-generic/signal-defs.h     |  58 +++++++++
 include/uapi/asm-generic/signal.h          |  29 -----
 include/uapi/linux/ptrace.h                |  12 ++
 kernel/ptrace.c                            |  33 ++++-
 kernel/signal.c                            | 134 +++++++++++----------
 36 files changed, 346 insertions(+), 429 deletions(-)
 create mode 100644 arch/arm64/include/asm/signal.h

-- 
2.29.1.341.ge80a0c044ae-goog


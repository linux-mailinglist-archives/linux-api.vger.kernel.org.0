Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BADB7290FFB
	for <lists+linux-api@lfdr.de>; Sat, 17 Oct 2020 08:03:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436904AbgJQGDC (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sat, 17 Oct 2020 02:03:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2411569AbgJQGBh (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sat, 17 Oct 2020 02:01:37 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A6CEC0613D3
        for <linux-api@vger.kernel.org>; Fri, 16 Oct 2020 17:12:44 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id q15so2617412qkq.23
        for <linux-api@vger.kernel.org>; Fri, 16 Oct 2020 17:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=0SzVqODEfPVXxLTAWYh1OlMRZX67EtQRCd+LR3qS49c=;
        b=WuhlseqJkkPmSyZw616Hrf+g3JLaplGgcP+WbLNqPy6pbqoUqVy2fZfRmPjkKnlNEF
         a5QjECu3iU010I4z4m5sv9yOYLjtgYQMD/ntbgYb0y7oaqRCzmy2Jhr0dSTYhJP9QDev
         EABizo8Mme8p3TdOVqWL5im2eC+Shw6NDyno9Z+iAkK0YzHTLLQ20+l7sz/2txyxDbtN
         kv8S9RWCC9Rte4uKn/cBRjsG1J8fN5X/JRpTFdBNv79AQ/ntKnI9Gz3mlw1vqxnB9Ixz
         WWMeIe5grQwW+JAz61iF76EpV/juD7Z3uLyAlFgBDg4FPo6mb2jDawciNLJtNzKVYiE1
         UbDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=0SzVqODEfPVXxLTAWYh1OlMRZX67EtQRCd+LR3qS49c=;
        b=DCnomnNc3gWuA3SC8zNIImf2qH0z3ahPbRKKNj19XAGdubr87qNG0X4iari9NrvBSh
         f8CKVZ1xw4bg0nUib8UvkKiX91Q+WcLSBFi2UBbsgrAbe1Si1WTQXcueGg9lSogdGv87
         mum0hbqT072WldKL6r0VCTHouiqQMncUnBMmaNYCIBUi8NGNtnetYIiPWED0RYiPJEAW
         /IY7zpg1MiX4jYKqD3vANEJepo7ZGzAC4QUWu80RNxDUyn3ejgcvqqdeqO0HWzEhLb0h
         MmJ+lJvgw65YMCOWdipNtREkdwYwFV6fHIzVagKNAqq4QHVlcyjkxhWwEWKvtQZRgWoI
         rB+g==
X-Gm-Message-State: AOAM532T/0ZRznHN/qrcgZWiCZlV62//XFht3gFcUfatAHKeZx4tuJdq
        73kL/mq8of0TlTLmB/RPOONZqXY=
X-Google-Smtp-Source: ABdhPJwrcG+HjhDPcsvVqMBOCzJnFkmyrsDDTznxLj+oymEZ6nBA7SBVRkAeE4Jure8saQqIjl/72hc=
Sender: "pcc via sendgmr" <pcc@pcc-desktop.svl.corp.google.com>
X-Received: from pcc-desktop.svl.corp.google.com ([2620:15c:2ce:0:7220:84ff:fe09:385a])
 (user=pcc job=sendgmr) by 2002:a05:6214:943:: with SMTP id
 dn3mr6291415qvb.45.1602893563003; Fri, 16 Oct 2020 17:12:43 -0700 (PDT)
Date:   Fri, 16 Oct 2020 17:12:25 -0700
Message-Id: <cover.1602892799.git.pcc@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.0.rc1.297.gfa9743e501-goog
Subject: [PATCH v12 0/8] arm64: expose FAR_EL1 tag bits in siginfo
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
 kernel/ptrace.c                            |  32 ++++-
 kernel/signal.c                            | 134 +++++++++++----------
 36 files changed, 345 insertions(+), 429 deletions(-)
 create mode 100644 arch/arm64/include/asm/signal.h

-- 
2.29.0.rc1.297.gfa9743e501-goog


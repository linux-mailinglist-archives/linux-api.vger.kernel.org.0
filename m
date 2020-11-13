Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFF5E2B1462
	for <lists+linux-api@lfdr.de>; Fri, 13 Nov 2020 03:46:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726207AbgKMCqQ (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 12 Nov 2020 21:46:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726017AbgKMCqQ (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 12 Nov 2020 21:46:16 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C063C0613D1
        for <linux-api@vger.kernel.org>; Thu, 12 Nov 2020 18:46:12 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id i184so8734607ybg.7
        for <linux-api@vger.kernel.org>; Thu, 12 Nov 2020 18:46:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=R2dLikK0miSF2piCujYuF2GxbSBu9CF0mVULowheiBM=;
        b=EPWUACcZO1Y6Dn+hwNxGqI0h6LknqnPDN7hjoOa769gguIek0oYO184K+IrMh0rG1t
         hZyYLzaN8ugGXTVkF5BjzJbhmCqnimxoM6kWuJLvNSPH5RZO7xyAHr0pPSm0Wahw3jVN
         WjIYifzW4F6Q8PuY0ETDxUIGjlweEoW+5Qmf9DBSXA2qR4qQsI82xBC611T/PTAgxvrX
         Um0Ypo9aPIADfY2ydEbhiWBgrFxKOEty0ovfBW+WuFS61cYn/AcBKo6+gmCpymq2outh
         HWtCGaGW3fbga7SiBvbaxRiZy3dLB/BcgiDs/b8FlPqfyHGx0ZjdAK5vlcOLXwhYnncz
         j8Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=R2dLikK0miSF2piCujYuF2GxbSBu9CF0mVULowheiBM=;
        b=Db1rBJ954yBNBFi5qO22hEmqxp+cY2yd8SyofFl6vqIw9MgsYeU2XmVkDhWfuR1/gJ
         j4HWmBKwYXzlRZgYewF+m5d5m61DQHW9RYev6Wh7Ug/d7QstcbgVF0f9z/HPyNiVDUp9
         aa9XG2pX+KLsTxdB6HoG4QptpIfXgc//AEX2y6xP7rx+02M1WFDFeR/gwLOBt+pwRPdp
         qvqxGaLOhYw57I3zjVrfJ/9P/BODRAcrq/78Py6jVA+Io+p77bo/+NsNcp/e8h9h5EQx
         uwnjjsWo62FcFhix0lBdjf+Tt0Oy3ldk2kYZFUOU08p+A+T/pYWGPIwo1XiNnqUI9ZcP
         yp2w==
X-Gm-Message-State: AOAM530VUYTK0q8R0BtHLF+M1fEqdTA2t86KBqmArmLxo1nEvWd9z7Uh
        1v9Wm2yuLJEbOCrW3KuBfjk/xkw=
X-Google-Smtp-Source: ABdhPJyZEt8b8S6tPmyTn16pMShMKU9qmbkzf5sGmNHab2QHeV+kpcgMZkGVg1ARZOSu68pDx4Pbfmk=
Sender: "pcc via sendgmr" <pcc@pcc-desktop.svl.corp.google.com>
X-Received: from pcc-desktop.svl.corp.google.com ([2620:15c:2ce:0:7220:84ff:fe09:385a])
 (user=pcc job=sendgmr) by 2002:a25:6f55:: with SMTP id k82mr48633ybc.345.1605235571509;
 Thu, 12 Nov 2020 18:46:11 -0800 (PST)
Date:   Thu, 12 Nov 2020 18:46:01 -0800
Message-Id: <cover.1605235488.git.pcc@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
Subject: [PATCH v15 0/6] arm64: expose FAR_EL1 tag bits in siginfo
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
        linux-api@vger.kernel.org, Helge Deller <deller@gmx.de>,
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
expecting the tag bits to be cleared. Instead, introduce a flag in
sigaction.sa_flags, SA_EXPOSE_TAGBITS, and only expose the tag bits
there if the signal handler has this flag set.

In order to allow userspace to determine whether SA_EXPOSE_TAGBITS
is supported, we first introduce a mechanism for userspace to detect
kernel support for SA_* flags.

The series can be viewed on Gerrit here:
https://linux-review.googlesource.com/id/Ia8876bad8c798e0a32df7c2ce1256c4771c81446

[1] http://clang.llvm.org/docs/HardwareAssistedAddressSanitizerDesign.html

Helge Deller (1):
  parisc: Drop parisc special case for __sighandler_t

Peter Collingbourne (5):
  parisc: start using signal-defs.h
  arch: move SA_* definitions to generic headers
  signal: clear non-uapi flag bits when passing/returning sa_flags
  signal: define the SA_UNSUPPORTED bit in sa_flags
  arm64: expose FAR_EL1 tag bits in siginfo

 Documentation/arm64/tagged-pointers.rst | 25 ++++++---
 arch/alpha/include/uapi/asm/signal.h    | 14 -----
 arch/arm/include/asm/signal.h           |  2 +
 arch/arm/include/uapi/asm/signal.h      | 27 ++--------
 arch/arm64/include/asm/exception.h      |  2 +-
 arch/arm64/include/asm/system_misc.h    |  2 +-
 arch/arm64/include/asm/traps.h          |  6 +--
 arch/arm64/kernel/debug-monitors.c      |  5 +-
 arch/arm64/kernel/entry-common.c        |  2 -
 arch/arm64/kernel/ptrace.c              |  7 +--
 arch/arm64/kernel/sys_compat.c          |  5 +-
 arch/arm64/kernel/traps.c               | 29 ++++++-----
 arch/arm64/mm/fault.c                   | 68 ++++++++++++++-----------
 arch/h8300/include/uapi/asm/signal.h    | 24 ---------
 arch/ia64/include/uapi/asm/signal.h     | 24 ---------
 arch/m68k/include/uapi/asm/signal.h     | 24 ---------
 arch/mips/include/uapi/asm/signal.h     | 12 -----
 arch/parisc/include/asm/signal.h        |  2 +
 arch/parisc/include/uapi/asm/signal.h   | 34 +------------
 arch/powerpc/include/uapi/asm/signal.h  | 24 ---------
 arch/s390/include/uapi/asm/signal.h     | 24 ---------
 arch/sparc/include/uapi/asm/signal.h    |  4 +-
 arch/x86/include/uapi/asm/signal.h      | 24 ---------
 arch/x86/kernel/signal_compat.c         |  7 ---
 arch/xtensa/include/uapi/asm/signal.h   | 24 ---------
 include/linux/signal.h                  | 14 +++++
 include/linux/signal_types.h            | 12 +++++
 include/uapi/asm-generic/signal-defs.h  | 57 +++++++++++++++++++++
 include/uapi/asm-generic/signal.h       | 29 -----------
 kernel/signal.c                         | 39 +++++++++++---
 30 files changed, 206 insertions(+), 366 deletions(-)

-- 
2.29.2.299.gdc1121823c-goog


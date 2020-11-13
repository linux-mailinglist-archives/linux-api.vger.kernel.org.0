Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 989972B1473
	for <lists+linux-api@lfdr.de>; Fri, 13 Nov 2020 03:53:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726017AbgKMCxo (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 12 Nov 2020 21:53:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725965AbgKMCxo (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 12 Nov 2020 21:53:44 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B71DC0613D1
        for <linux-api@vger.kernel.org>; Thu, 12 Nov 2020 18:53:43 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id i184so8748349ybg.7
        for <linux-api@vger.kernel.org>; Thu, 12 Nov 2020 18:53:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=erXXDcbayGEP6l3q1rjaaVqG+nxU5UCcirwUU6AcyVs=;
        b=ACgIwHhaeb4gKRTR+rvkOpHYxjldtZb+m1dRSoikUXYTSr2lHm+S8fJjesFAdjME2R
         3dz8WCRhRXSwHvqdhsX2wcKzyTGxP1kiWciBd/P1TTFfl1vzuzp2jHYWf9P0tR5fn0/g
         TRJjPbNIud63kcj+P9vRzZ98zja+eCgZ4xQkuG2NJbNVSVXfCdrida+tTN0U5O8ZNjXR
         8PRF4YF7wMV/nlFKSRB5nhHFwZ8GiO+rXY+fKnYQvn8Mf4RQmHI73wXGo5/H1kRx6AnA
         ps2TaNhVmN8kOybEErF3CYsMMTk1B/vNzvJkBvx4YWSbGCUJ0Fj8OlxvHlLD1XwN73uG
         ELYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=erXXDcbayGEP6l3q1rjaaVqG+nxU5UCcirwUU6AcyVs=;
        b=kX3/Ah0LtIHNsgNFR3IYEK0GV+VtbD7hmDmXzNvyM14WXqE+jG0KbABkaXafi3kos+
         vdV3dO/fyIC+QmUdvVZRK3R72cD2KjfdzFPr5tIl4memG3q2GpMghF9xKrAwqcb4XFMS
         7DKZa2pphfrTrG9RtMrcP8xLqphxiO52DH/3u5syPTkZwrhSxLxeLVXwztDK+L9+OMuC
         ir7Ru1oEnyfnJ3TOCU+4SJLT5MDhHnU/7K7nCpNtlfDdeLH7MPhmRDzIYptr9qjGxEqD
         5uFZOvJr2yaoYlXk1vR/Hz4Zrf7MjfqsHFKsZN1P9iy+52T4o4i3ATJ8n4cwisYpXRUT
         MeHQ==
X-Gm-Message-State: AOAM531n+baXmn816fglT4UWIVB5ady2WoaxHy/S3bJyh93hLmyVIXix
        /X+td4/K7iXokYk3H6NoWcrK0vk=
X-Google-Smtp-Source: ABdhPJwRsp0X6ALthImiGQCTbOl4aQCGE5kZE10LOd3a3UbTSdokZxVtbPQLQw2tQeUXoyIgHOaQiFs=
Sender: "pcc via sendgmr" <pcc@pcc-desktop.svl.corp.google.com>
X-Received: from pcc-desktop.svl.corp.google.com ([2620:15c:2ce:0:7220:84ff:fe09:385a])
 (user=pcc job=sendgmr) by 2002:a05:6902:72d:: with SMTP id
 l13mr117991ybt.374.1605236022340; Thu, 12 Nov 2020 18:53:42 -0800 (PST)
Date:   Thu, 12 Nov 2020 18:53:30 -0800
Message-Id: <cover.1605235762.git.pcc@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
Subject: [PATCH v16 0/6] arm64: expose FAR_EL1 tag bits in siginfo
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
 arch/arm64/include/asm/signal.h         | 25 +++++++++
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
 31 files changed, 231 insertions(+), 366 deletions(-)
 create mode 100644 arch/arm64/include/asm/signal.h

-- 
2.29.2.299.gdc1121823c-goog


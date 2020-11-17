Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13E9D2B57BB
	for <lists+linux-api@lfdr.de>; Tue, 17 Nov 2020 04:17:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726215AbgKQDRe (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 16 Nov 2020 22:17:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726202AbgKQDRd (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 16 Nov 2020 22:17:33 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE78DC0613CF
        for <linux-api@vger.kernel.org>; Mon, 16 Nov 2020 19:17:33 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id p15so10651188plr.2
        for <linux-api@vger.kernel.org>; Mon, 16 Nov 2020 19:17:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=Tec8Lof2v7sCzgTi+uz64P+bwXpg3L4Na0+h8yPWlGE=;
        b=eeQ/GIEGHcztECgqZcrMx1iH24LR1SUqZXwTV8OLBa7Dx6PoIVOjWsBpxnLeJMbTzd
         IMe+nTSb0aZi6Iymbz5L5+u4muChUb7hLVvAtsI9BuDpw/1MciYAiqcs+utnai+Hxa7W
         j/zeuiP/8APTSXVFM77BykQLf63h7O3YlpU79CxxwskNXwUDg/tsN9ab32SKQDMY8eoz
         uLLK+j68ft1h6wWRXGA7dD7MXrUPcoTGBW+2RiR/TBOzbsYWSQ8BoQk+IhEWatOnm/gg
         UVGGXD5htwd8TX9LF1PkGjOnlr6KiyKvzs4QlCrTL2FLRaML230KvwGG3BOXxvtalxx6
         J2Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=Tec8Lof2v7sCzgTi+uz64P+bwXpg3L4Na0+h8yPWlGE=;
        b=lDXzwgzwNGJq5kdVHV+sk/zmmUuwrpG0P1M2LhuQD2X7G4ruiYHlwAjM/qAeSQbHiJ
         c6uluLtLbkyeyshOhNu+EcaADKiCEn1isfo6TLqyuEKDKIdhtgWUgnhGJoO2KRFg6yJm
         igaYmds5w/Ggu5Do8E5cMAnq/Djpcm4lRy3uqoOK1ciHOcprxtTbEYeMYUQSBTWnz02F
         jfaBQPC3Z3/e3HhOINcjQcQOeQpFtz6TUSC9oRbpPA/RdothTJjQ7reAbgCLDTEZWyWC
         z30kioEa2XoUcoWT7P52IbjFSCRvJNThONVcWaKIBjj36ZIXLbxM0Lwovk7zV//rZE+4
         Cm8w==
X-Gm-Message-State: AOAM532W4iGvUxqm2SKqS66bZeMa7i/Bl9hXomk4Kg13GFi1B7UYWFJZ
        QJnvNeKX6SNZ5pEjrA4QtmYtKYk=
X-Google-Smtp-Source: ABdhPJxR8h1isZVelOQvnng0IcYVwRvytNDUNLT9OX9mEylOn78LUPwnMgtesoqYVjElf1g6zdRmF8A=
Sender: "pcc via sendgmr" <pcc@pcc-desktop.svl.corp.google.com>
X-Received: from pcc-desktop.svl.corp.google.com ([2620:15c:2ce:0:7220:84ff:fe09:385a])
 (user=pcc job=sendgmr) by 2002:a17:902:c20a:b029:d6:b2d6:8006 with SMTP id
 10-20020a170902c20ab02900d6b2d68006mr15677426pll.31.1605583053317; Mon, 16
 Nov 2020 19:17:33 -0800 (PST)
Date:   Mon, 16 Nov 2020 19:17:23 -0800
Message-Id: <cover.1605582887.git.pcc@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
Subject: [PATCH v17 0/3] arm64: expose FAR_EL1 tag bits in siginfo
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

These patches need to be applied on top of:
https://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git signal-for-v5.11

The series can be viewed on Gerrit here:
https://linux-review.googlesource.com/id/Ia8876bad8c798e0a32df7c2ce1256c4771c81446

[1] http://clang.llvm.org/docs/HardwareAssistedAddressSanitizerDesign.html

Peter Collingbourne (3):
  arch: provide better documentation for the arch-specific SA_* flags
  signal: define the SA_UNSUPPORTED bit in sa_flags
  arm64: expose FAR_EL1 tag bits in siginfo

 Documentation/arm64/tagged-pointers.rst | 25 ++++++---
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
 include/linux/signal.h                  | 14 +++++
 include/linux/signal_types.h            |  2 +-
 include/uapi/asm-generic/signal-defs.h  | 32 +++++++++---
 kernel/signal.c                         | 29 ++++++++---
 15 files changed, 168 insertions(+), 85 deletions(-)
 create mode 100644 arch/arm64/include/asm/signal.h

-- 
2.29.2.299.gdc1121823c-goog


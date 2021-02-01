Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AA2630B08F
	for <lists+linux-api@lfdr.de>; Mon,  1 Feb 2021 20:43:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231864AbhBATmq (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 1 Feb 2021 14:42:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbhBATml (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 1 Feb 2021 14:42:41 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D405C061786;
        Mon,  1 Feb 2021 11:41:59 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id g3so10619862plp.2;
        Mon, 01 Feb 2021 11:41:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QRjxCLuQN8hNECynzl8zP9q2hHvFmhTmWrT/R1ujkw0=;
        b=DAmX4uuqp1MGWh6Kb/kOqIB5x90h3PvRPjAxLzGCXNnGHYw/BQmvnejozeZFma4uj1
         TB0zKpmuqmlPmpCftGdjuu7Dv+ky3AR/bYD8gDONkMWln7Y3j2TMxFurHmaQl8XfWcam
         lUnqFRVJ/2CU19t6q7Te0DjAzeDuFvoQz8EL5k4KJoEq/tFY1sEw//iBGEHfdEi3vMTR
         vvCnM7kUmbtKWAdP/6qD6YKyh2mYxB26q07K+tnsa+huOc2hJRV8NT2HMFLYqzLm9slK
         jrZCLJAtp8zs5IyHURJtZSkTZGBEj5ipfaHGX8dNxpFs3+AlzhV5HZGMFL5iHZFUTyOU
         LLFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QRjxCLuQN8hNECynzl8zP9q2hHvFmhTmWrT/R1ujkw0=;
        b=T73PLTTwVnjw9UOfI3K8tKMm67SDcfE2+17+LWUZBaiAoUkaBfvZlasSwtrRIXvTQa
         6xFfbutQacTdlwyWaUeQA0DUW5OW9yoBSy83aRySc8NBUGaUDqrQ4f1JdDMuJtZvHo8y
         qBuQWbjvtGznxc9jfaw05kPWObPDCWE+IZ/2SKaycXhMm1G4LFK0it1ux1v69B2ckuN0
         wEjco0Cod5ZdvUbe6fr52HbmkuaRqVh0q/yCbpUdEXNRHwcZulKS5ynp4lsDzZr/vZ+C
         4WEFUAGhZdybFeRNLyGkWgS1t8eoiFRt21AIPFMp3He9bBwf7HtaJmboKkwYB90ylUby
         gw0w==
X-Gm-Message-State: AOAM530OW1VpCRUcjwTmKKlNUE0B+h7i8ONodkgzFVrUSnunGmcC+WMI
        9z7NpBDQIQ3KSbg6TmCK/Uo=
X-Google-Smtp-Source: ABdhPJzl5HcS9kWOeBJCi5Lj4X/pLo35ipBIsZnFekB21lSY9Z0GG9tQePWu2rECauPs9WVQU0EAHw==
X-Received: by 2002:a17:90a:5417:: with SMTP id z23mr441677pjh.111.1612208518510;
        Mon, 01 Feb 2021 11:41:58 -0800 (PST)
Received: from laptop.hsd1.wa.comcast.net ([2601:600:9b7f:872e:a655:30fb:7373:c762])
        by smtp.gmail.com with ESMTPSA id i4sm18213155pfo.40.2021.02.01.11.41.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 11:41:57 -0800 (PST)
From:   Andrei Vagin <avagin@gmail.com>
To:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org,
        Anthony Steinhauser <asteinhauser@google.com>,
        Andrei Vagin <avagin@gmail.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Keno Fischer <keno@juliacomputing.com>
Subject: [PATCH 0/3 v2] arm64/ptrace: allow to get all registers on syscall traps
Date:   Mon,  1 Feb 2021 11:40:09 -0800
Message-Id: <20210201194012.524831-1-avagin@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Right now, ip/r12 for AArch32 and x7 for AArch64 is used to indicate
whether or not the stop has been signalled from syscall entry or syscall
exit. This means that:

- Any writes by the tracer to this register during the stop are
  ignored/discarded.

- The actual value of the register is not available during the stop,
  so the tracer cannot save it and restore it later.

For applications like the user-mode Linux or gVisor, it is critical to
have access to the full set of registers in any moment. For example,
they need to change values of all registers to emulate rt_sigreturn or
execve and they need to have the full set of registers to build a signal
frame.

This series introduces the PTRACE_O_ARM64_RAW_REGS option. If it is set,
PTRACE_GETREGSET returns values of all registers, and PTRACE_SETREGSET
allows to change any of them.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Dave Martin <Dave.Martin@arm.com>
Cc: Keno Fischer <keno@juliacomputing.com> 
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Will Deacon <will@kernel.org>

Andrei Vagin (3):
  arm64/ptrace: don't clobber task registers on syscall entry/exit traps
  arm64/ptrace: introduce PTRACE_O_ARM64_RAW_REGS
  selftest/arm64/ptrace: add tests for PTRACE_O_ARM64_RAW_REGS

v2: use the ptrace option instead of adding a new regset.

 arch/arm64/include/asm/ptrace.h               |   5 +
 arch/arm64/kernel/ptrace.c                    | 130 +++++++++++-----
 include/uapi/linux/elf.h                      |   1 +
 tools/testing/selftests/arm64/Makefile        |   2 +-
 tools/testing/selftests/arm64/ptrace/Makefile |   6 +
 .../arm64/ptrace/ptrace_syscall_regs_test.c   | 142 ++++++++++++++++++
 6 files changed, 246 insertions(+), 40 deletions(-)
 create mode 100644 tools/testing/selftests/arm64/ptrace/Makefile
 create mode 100644 tools/testing/selftests/arm64/ptrace/ptrace_syscall_regs_test.c

-- 
2.29.2


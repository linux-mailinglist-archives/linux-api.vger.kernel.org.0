Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAAB630F6B0
	for <lists+linux-api@lfdr.de>; Thu,  4 Feb 2021 16:48:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237404AbhBDPp4 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 4 Feb 2021 10:45:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:60780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237388AbhBDPlY (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 4 Feb 2021 10:41:24 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3AE3F64F47;
        Thu,  4 Feb 2021 15:40:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612453243;
        bh=94cY1u+hNd+/OdEI6Ip/ZV8/7uanpQEYhbCY1QFgwsQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SYOlSKMDU3k85Bue6/Kvbv8YYlR208G4wR+IqGqoxGeeBEl5q7f7hDS75PAk08Vay
         0XfgTWIDrneQbfWOBqCMx/JOzMNaodgiE4PMwkXYG2b4/Am53ph/Q4LleNVwdt2kq4
         lIUxJ7Qwfvlc3487jtpk9nS502ZxurDAG8f5h6DxREEcatMAfTg0h58i1xpgz2hrQv
         bQhiaVpSx9zLEpXcHtORU+KIU1zA+4B3WQWbcGR8f1oXm8d2AzfS3viZVrHU562E2N
         I16MbaV8JSF7ayzoil5coP0I94DuC1YjXJT/tI4jXWRO6hZE0w0kD73MRcBtIr5PAK
         SNu6WIVqxBdMQ==
Date:   Thu, 4 Feb 2021 15:40:39 +0000
From:   Will Deacon <will@kernel.org>
To:     Andrei Vagin <avagin@gmail.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Oleg Nesterov <oleg@redhat.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org,
        Anthony Steinhauser <asteinhauser@google.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Keno Fischer <keno@juliacomputing.com>, keescook@chromium.org
Subject: Re: [PATCH 3/3] selftest/arm64/ptrace: add tests for
 PTRACE_O_ARM64_RAW_REGS
Message-ID: <20210204154038.GC21058@willie-the-truck>
References: <20210201194012.524831-1-avagin@gmail.com>
 <20210201194012.524831-4-avagin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210201194012.524831-4-avagin@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

[+Kees]

On Mon, Feb 01, 2021 at 11:40:12AM -0800, Andrei Vagin wrote:
> Test output:
>  TAP version 13
>  1..2
>  # selftests: arm64/ptrace: ptrace_syscall_raw_regs_test
>  # 1..2
>  # ok 1 x7: 686920776f726c64
>  # ok 2 The child exited with code 0.
>  # # Totals: pass:2 fail:0 xfail:0 xpass:0 skip:0 error:0
>  ok 1 selftests: arm64/ptrace: ptrace_syscall_raw_regs_test
>  # selftests: arm64/ptrace: ptrace_syscall_regs_test
>  # 1..3
>  # ok 1 x7: 0
>  # ok 2 x7: 1
>  # ok 3 The child exited with code 0.
>  # # Totals: pass:3 fail:0 xfail:0 xpass:0 skip:0 error:0
>  ok 2 selftests: arm64/ptrace: ptrace_syscall_regs_test
> 
> Signed-off-by: Andrei Vagin <avagin@gmail.com>
> ---
>  tools/testing/selftests/arm64/Makefile        |   2 +-
>  tools/testing/selftests/arm64/ptrace/Makefile |   6 +
>  .../ptrace/ptrace_syscall_raw_regs_test.c     | 142 +++++++++++++++++
>  .../arm64/ptrace/ptrace_syscall_regs_test.c   | 150 ++++++++++++++++++
>  4 files changed, 299 insertions(+), 1 deletion(-)
>  create mode 100644 tools/testing/selftests/arm64/ptrace/Makefile
>  create mode 100644 tools/testing/selftests/arm64/ptrace/ptrace_syscall_raw_regs_test.c
>  create mode 100644 tools/testing/selftests/arm64/ptrace/ptrace_syscall_regs_test.c

Thanks for the tests!

We already have a pretty extensive set of syscall entry tests in
tools/testing/selftests/seccomp, so perhaps this would be better off as part
of that? Maybe worth a look.

Will

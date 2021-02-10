Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C8943171C2
	for <lists+linux-api@lfdr.de>; Wed, 10 Feb 2021 21:56:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232477AbhBJUzu (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 10 Feb 2021 15:55:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233224AbhBJUzj (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 10 Feb 2021 15:55:39 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEF81C06174A
        for <linux-api@vger.kernel.org>; Wed, 10 Feb 2021 12:54:58 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id o38so2029141pgm.9
        for <linux-api@vger.kernel.org>; Wed, 10 Feb 2021 12:54:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XK6hpz+PCOsL7W55wJU4s9nIbpn+lmg5rsc0pPcV4bs=;
        b=DlkD+c2Ccf9no7hwfEx3lqTSksvhp1VVOdzKfCVsqGzVhqLgaFygvQUy7o3VV04mnL
         fZkDQKqcNswW6+OtqTryQA4lo2GKWgMzeURDgKOBtt4mxHoClQUWVzGw20KEzWg4uiyf
         XCNzAHV31atpRmRYe10BxajqVS3cJOa3Ep8TI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XK6hpz+PCOsL7W55wJU4s9nIbpn+lmg5rsc0pPcV4bs=;
        b=YDEoA/3PQ7oYN5c28o4Toi3fuYtjMLET4YUYtrmDnlf/lmFfFPah5pMizcSDkDAA9A
         ylq2HPzFW+sCUJBVMAM29jAx8VHhANM7OmRFdb8M+GYP6EyjrtYMwwpd6yVPRdZIR7a9
         06nFz15wdCCDPYYj7frh3EqTn+NYwN/RJTYK/Tnk6g0bcqs5+66b8C20WRPoOHyVEFrF
         Uy5VB+BRKVmq1QHom1vfytb8bKQVCGAl40bwVBANtCzcQLotw0tDB6rIJ9kvyLRG13xZ
         Y1t4fH1Z8kQLjdBxh4I+b97QdS3BQ0tFc6ehp2BeDBPu8i16+0fmCknzOEWJW8ffQeaZ
         ZZzg==
X-Gm-Message-State: AOAM531bnyGQWBwVj2o1sHEGGgG3yKmj/wznmc39+0LNLFe4jmQnetPP
        m3zoTC6iGpTM3gE/DuAv7vTW+Q==
X-Google-Smtp-Source: ABdhPJzaxDgY6uHenP6VKy3Z+OUoo1YD/3D6dOTKAoKYExeojilYLpdTH5T0TraQLPoS4LEtG0K5xQ==
X-Received: by 2002:a63:a312:: with SMTP id s18mr4698497pge.229.1612990498607;
        Wed, 10 Feb 2021 12:54:58 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 17sm3167706pgy.53.2021.02.10.12.54.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 12:54:58 -0800 (PST)
Date:   Wed, 10 Feb 2021 12:54:57 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Will Deacon <will@kernel.org>
Cc:     Andrei Vagin <avagin@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Oleg Nesterov <oleg@redhat.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org,
        Anthony Steinhauser <asteinhauser@google.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Keno Fischer <keno@juliacomputing.com>
Subject: Re: [PATCH 3/3] selftest/arm64/ptrace: add tests for
 PTRACE_O_ARM64_RAW_REGS
Message-ID: <202102101253.300A11108@keescook>
References: <20210201194012.524831-1-avagin@gmail.com>
 <20210201194012.524831-4-avagin@gmail.com>
 <20210204154038.GC21058@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210204154038.GC21058@willie-the-truck>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, Feb 04, 2021 at 03:40:39PM +0000, Will Deacon wrote:
> [+Kees]
> 
> On Mon, Feb 01, 2021 at 11:40:12AM -0800, Andrei Vagin wrote:
> > Test output:
> >  TAP version 13
> >  1..2
> >  # selftests: arm64/ptrace: ptrace_syscall_raw_regs_test
> >  # 1..2
> >  # ok 1 x7: 686920776f726c64
> >  # ok 2 The child exited with code 0.
> >  # # Totals: pass:2 fail:0 xfail:0 xpass:0 skip:0 error:0
> >  ok 1 selftests: arm64/ptrace: ptrace_syscall_raw_regs_test
> >  # selftests: arm64/ptrace: ptrace_syscall_regs_test
> >  # 1..3
> >  # ok 1 x7: 0
> >  # ok 2 x7: 1
> >  # ok 3 The child exited with code 0.
> >  # # Totals: pass:3 fail:0 xfail:0 xpass:0 skip:0 error:0
> >  ok 2 selftests: arm64/ptrace: ptrace_syscall_regs_test
> > 
> > Signed-off-by: Andrei Vagin <avagin@gmail.com>
> > ---
> >  tools/testing/selftests/arm64/Makefile        |   2 +-
> >  tools/testing/selftests/arm64/ptrace/Makefile |   6 +
> >  .../ptrace/ptrace_syscall_raw_regs_test.c     | 142 +++++++++++++++++
> >  .../arm64/ptrace/ptrace_syscall_regs_test.c   | 150 ++++++++++++++++++
> >  4 files changed, 299 insertions(+), 1 deletion(-)
> >  create mode 100644 tools/testing/selftests/arm64/ptrace/Makefile
> >  create mode 100644 tools/testing/selftests/arm64/ptrace/ptrace_syscall_raw_regs_test.c
> >  create mode 100644 tools/testing/selftests/arm64/ptrace/ptrace_syscall_regs_test.c
> 
> Thanks for the tests!
> 
> We already have a pretty extensive set of syscall entry tests in
> tools/testing/selftests/seccomp, so perhaps this would be better off as part
> of that? Maybe worth a look.

I'm happy with this living in either place -- I can make an argument
either way. If it's arm64-specific, maybe better to live outside of
seccomp?

-- 
Kees Cook

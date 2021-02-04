Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC72030F57B
	for <lists+linux-api@lfdr.de>; Thu,  4 Feb 2021 15:57:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236803AbhBDOzX (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 4 Feb 2021 09:55:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:45354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236891AbhBDOyc (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 4 Feb 2021 09:54:32 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4BCBD64E42;
        Thu,  4 Feb 2021 14:53:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612450430;
        bh=scY1EUctLlHyJdhffM1YO119Qq4RStdexWZRn3yOoC8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Cl6/II/pP7hXlx/qGhE2nU/ur3bHmP4FoN8FWznMJEbivL2vDzrR/1+dJbe9yPtjy
         JoaJKEVaeldLKq340MjgGU1Qn7wkPMsCEgSy+zTTfF+xuiU3VqOUZlJtxWTZhjoll9
         s4A6p807Ze/iZ/SyyXwJatQaokMvwhZFyYEOqO420FWUqI8jr+AZIwIvy2hShuSXjk
         e5FgjFedltdirbM4T0Y5ZChNuKMCijX/zdks/7zHls3ALivZV8t1EVU2cvfDY1co38
         ygLm14xZi/neW7Wd++s/HJPWuXtPWYgMqbBc7cGKpELEPHp5GrILOk5YOmssdEdYYn
         JH1+37gXVp/1Q==
Date:   Thu, 4 Feb 2021 14:53:46 +0000
From:   Will Deacon <will@kernel.org>
To:     Andrei Vagin <avagin@gmail.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Oleg Nesterov <oleg@redhat.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org,
        Anthony Steinhauser <asteinhauser@google.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Keno Fischer <keno@juliacomputing.com>
Subject: Re: [PATCH 0/3 v2] arm64/ptrace: allow to get all registers on
 syscall traps
Message-ID: <20210204145345.GC20815@willie-the-truck>
References: <20210201194012.524831-1-avagin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210201194012.524831-1-avagin@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hi Andrei,

On Mon, Feb 01, 2021 at 11:40:09AM -0800, Andrei Vagin wrote:
> Right now, ip/r12 for AArch32 and x7 for AArch64 is used to indicate
> whether or not the stop has been signalled from syscall entry or syscall
> exit. This means that:
> 
> - Any writes by the tracer to this register during the stop are
>   ignored/discarded.
> 
> - The actual value of the register is not available during the stop,
>   so the tracer cannot save it and restore it later.
> 
> For applications like the user-mode Linux or gVisor, it is critical to
> have access to the full set of registers in any moment. For example,
> they need to change values of all registers to emulate rt_sigreturn or
> execve and they need to have the full set of registers to build a signal
> frame.
> 
> This series introduces the PTRACE_O_ARM64_RAW_REGS option. If it is set,
> PTRACE_GETREGSET returns values of all registers, and PTRACE_SETREGSET
> allows to change any of them.

I haven't had a chance to go through this properly yet, but I spotted a
couple of things worth mentioning off the bat:

  - Please drop all of the compat changes here. The compat layer is intended
    to be compatible with arch/arm/, so if you want to introduce new ptrace
    behaviours for 32-bit applications, you need to make the changes there
    and then update our compat layer accordingly.

  - When Keno mentioned this before [1,2], he also talked about making
    orig_x0 available. Since extending the ABI is a giant pain, I think
    this should be seriously considered.

[1] https://lore.kernel.org/r/CABV8kRzkLiVuqxT3+8c1o8m_OuROtXgfowQcrMVnrxu=CiGB=w@mail.gmail.com
[2] https://lore.kernel.org/r/CABV8kRzg1BaKdAhqXU3hONhfPAHj6Nbw0wLBC1Lo7PN1UA0CoA@mail.gmail.com

Will

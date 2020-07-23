Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAB1D22A91A
	for <lists+linux-api@lfdr.de>; Thu, 23 Jul 2020 08:47:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726304AbgGWGrz (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 23 Jul 2020 02:47:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbgGWGrz (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 23 Jul 2020 02:47:55 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D027C0619DC
        for <linux-api@vger.kernel.org>; Wed, 22 Jul 2020 23:47:55 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4BC2vr4Zfxz9sQt;
        Thu, 23 Jul 2020 16:47:52 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1595486873;
        bh=OeNPhpHvBcuXZex2aPYrGLTVDAkNiyf0rppWSgiCxS8=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=HohM+0bPBvgVW9/HLN4IMf5yi02AnIfVZnPyIdTtAqHC444cFOH1CKBqWpDM7Lwon
         NsM2R52CvAiwEd0oX+42uRFpfb/YABuNwOZBc3DeK4/+VbhCdDG6tHlBPeBneiYZuW
         x/sjp2Pc9GDKywfRjjOwgwst4SPVzzgNXME3MASoNfD6aqfhLT8wAtukHrEuE6y5h5
         0AOqS5iR7BzgP5uZOc2BfOKaLT4d9hdVadOEuqIlPGilDO/5G5Z+CFWTi+jic2wAc3
         oZ6pwqxKCRUOOvrVii1xzFbG1V85GZ0g85dphJPcJZYxt2e93/P/e/b5BBlJGk5abE
         SUl2R+mpqXtVQ==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
Cc:     libc-dev@lists.llvm.org, musl@lists.openwall.com,
        Nicholas Piggin <npiggin@gmail.com>, linux-api@vger.kernel.org
Subject: Re: [PATCH 2/2] powerpc/64s: system call support for scv/rfscv instructions
In-Reply-To: <20200611081203.995112-3-npiggin@gmail.com>
References: <20200611081203.995112-1-npiggin@gmail.com> <20200611081203.995112-3-npiggin@gmail.com>
Date:   Thu, 23 Jul 2020 16:47:51 +1000
Message-ID: <871rl2ralk.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Nicholas Piggin <npiggin@gmail.com> writes:
> diff --git a/arch/powerpc/include/asm/ppc-opcode.h b/arch/powerpc/include/asm/ppc-opcode.h
> index 2a39c716c343..b2bdc4de1292 100644
> --- a/arch/powerpc/include/asm/ppc-opcode.h
> +++ b/arch/powerpc/include/asm/ppc-opcode.h
> @@ -257,6 +257,7 @@
>  #define PPC_INST_MFVSRD			0x7c000066
>  #define PPC_INST_MTVSRD			0x7c000166
>  #define PPC_INST_SC			0x44000002
> +#define PPC_INST_SCV			0x44000001
...
> @@ -411,6 +412,7 @@
...
> +#define __PPC_LEV(l)	(((l) & 0x7f) << 5)

These conflicted and didn't seem to be used so I dropped them.

> diff --git a/arch/powerpc/lib/sstep.c b/arch/powerpc/lib/sstep.c
> index 5abe98216dc2..161bfccbc309 100644
> --- a/arch/powerpc/lib/sstep.c
> +++ b/arch/powerpc/lib/sstep.c
> @@ -3378,6 +3382,16 @@ int emulate_step(struct pt_regs *regs, struct ppc_inst instr)
>  		regs->msr = MSR_KERNEL;
>  		return 1;
>  
> +	case SYSCALL_VECTORED_0:	/* scv 0 */
> +		regs->gpr[9] = regs->gpr[13];
> +		regs->gpr[10] = MSR_KERNEL;
> +		regs->gpr[11] = regs->nip + 4;
> +		regs->gpr[12] = regs->msr & MSR_MASK;
> +		regs->gpr[13] = (unsigned long) get_paca();
> +		regs->nip = (unsigned long) &system_call_vectored_emulate;
> +		regs->msr = MSR_KERNEL;
> +		return 1;
> +

This broke the ppc64e build:

  ld: arch/powerpc/lib/sstep.o:(.toc+0x0): undefined reference to `system_call_vectored_emulate'
  make[1]: *** [/home/michael/linux/Makefile:1139: vmlinux] Error 1

I wrapped it in #ifdef CONFIG_PPC64_BOOK3S.

cheers

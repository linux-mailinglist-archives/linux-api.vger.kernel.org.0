Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C175B22C389
	for <lists+linux-api@lfdr.de>; Fri, 24 Jul 2020 12:45:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726994AbgGXKpp (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 24 Jul 2020 06:45:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725889AbgGXKpp (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 24 Jul 2020 06:45:45 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5DE1C0619D3
        for <linux-api@vger.kernel.org>; Fri, 24 Jul 2020 03:45:44 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4BCm7n16n3z9sTC;
        Fri, 24 Jul 2020 20:45:39 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1595587542;
        bh=cSDDxsKk+jO/k2dwm07zEZ08Z7nlQ2PpJurgiwDzTaM=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=fP1j0ehPwKKTZ5HN/V0OdYjpbK4V2kPCZefecMyzQANJTB+hA79mDYk5par/rDHUq
         Uo8NyAmqgFc99Y5JkaTKoiZ4on8iQgaDptXG4ojX681JnFFx5ClWMsBZ4vupz40B69
         +8/tKqAELW35pogsBvMORx7uUofX7MO6iq8YxIoa8iwdp1wA9kNZzLO0qXPnNOmpMq
         zrcbClSoYBFPUsnLy9w5Tl/R+A9Ftqp96MzWgWuuZZze/t2duS8KRSA3Trf9pFud7E
         ALyi6wNdEHqBgLKfonJnWr1RXCiadKIw3ArysUsWlxIX4OqrM8IGusO2A+vV8uo5p9
         JjpH7lGkuD+Ow==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     linux-api@vger.kernel.org, musl@lists.openwall.com,
        libc-dev@lists.llvm.org, linuxppc-dev@lists.ozlabs.org,
        Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 2/2] powerpc/64s: system call support for scv/rfscv instructions
In-Reply-To: <20200723184814.Horde.pk5BO9iFqyGX5D4TW5wqmg1@messagerie.si.c-s.fr>
References: <20200611081203.995112-1-npiggin@gmail.com> <20200611081203.995112-3-npiggin@gmail.com> <871rl2ralk.fsf@mpe.ellerman.id.au> <20200723184814.Horde.pk5BO9iFqyGX5D4TW5wqmg1@messagerie.si.c-s.fr>
Date:   Fri, 24 Jul 2020 20:45:36 +1000
Message-ID: <87v9idp4xb.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Christophe Leroy <christophe.leroy@csgroup.eu> writes:
> Michael Ellerman <mpe@ellerman.id.au> a =C3=A9crit=C2=A0:
>
>> Nicholas Piggin <npiggin@gmail.com> writes:
>>> diff --git a/arch/powerpc/include/asm/ppc-opcode.h=20=20
>>> b/arch/powerpc/include/asm/ppc-opcode.h
>>> index 2a39c716c343..b2bdc4de1292 100644
>>> --- a/arch/powerpc/include/asm/ppc-opcode.h
>>> +++ b/arch/powerpc/include/asm/ppc-opcode.h
>>> @@ -257,6 +257,7 @@
>>>  #define PPC_INST_MFVSRD			0x7c000066
>>>  #define PPC_INST_MTVSRD			0x7c000166
>>>  #define PPC_INST_SC			0x44000002
>>> +#define PPC_INST_SCV			0x44000001
>> ...
>>> @@ -411,6 +412,7 @@
>> ...
>>> +#define __PPC_LEV(l)	(((l) & 0x7f) << 5)
>>
>> These conflicted and didn't seem to be used so I dropped them.
>>
>>> diff --git a/arch/powerpc/lib/sstep.c b/arch/powerpc/lib/sstep.c
>>> index 5abe98216dc2..161bfccbc309 100644
>>> --- a/arch/powerpc/lib/sstep.c
>>> +++ b/arch/powerpc/lib/sstep.c
>>> @@ -3378,6 +3382,16 @@ int emulate_step(struct pt_regs *regs,=20=20
>>> struct ppc_inst instr)
>>>  		regs->msr =3D MSR_KERNEL;
>>>  		return 1;
>>>
>>> +	case SYSCALL_VECTORED_0:	/* scv 0 */
>>> +		regs->gpr[9] =3D regs->gpr[13];
>>> +		regs->gpr[10] =3D MSR_KERNEL;
>>> +		regs->gpr[11] =3D regs->nip + 4;
>>> +		regs->gpr[12] =3D regs->msr & MSR_MASK;
>>> +		regs->gpr[13] =3D (unsigned long) get_paca();
>>> +		regs->nip =3D (unsigned long) &system_call_vectored_emulate;
>>> +		regs->msr =3D MSR_KERNEL;
>>> +		return 1;
>>> +
>>
>> This broke the ppc64e build:
>>
>>   ld: arch/powerpc/lib/sstep.o:(.toc+0x0): undefined reference to=20=20
>> `system_call_vectored_emulate'
>>   make[1]: *** [/home/michael/linux/Makefile:1139: vmlinux] Error 1
>>
>> I wrapped it in #ifdef CONFIG_PPC64_BOOK3S.
>
> You mean CONFIG_PPC_BOOK3S_64 ?

I hope so ...

#### ## ####.

Will send a fixup. Thanks for noticing.

cheers

Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDCA322B3E4
	for <lists+linux-api@lfdr.de>; Thu, 23 Jul 2020 18:47:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbgGWQrC convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-api@lfdr.de>); Thu, 23 Jul 2020 12:47:02 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:57399 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726621AbgGWQrB (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 23 Jul 2020 12:47:01 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4BCJC36yTGzB09bR;
        Thu, 23 Jul 2020 18:46:55 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id Jaygyj04Nb8u; Thu, 23 Jul 2020 18:46:55 +0200 (CEST)
Received: from vm-hermes.si.c-s.fr (vm-hermes.si.c-s.fr [192.168.25.253])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4BCJC33NBqzB09bN;
        Thu, 23 Jul 2020 18:46:55 +0200 (CEST)
Received: by vm-hermes.si.c-s.fr (Postfix, from userid 33)
        id 3746D72B; Thu, 23 Jul 2020 18:48:14 +0200 (CEST)
Received: from 37-172-34-2.coucou-networks.fr
 (37-172-34-2.coucou-networks.fr [37.172.34.2]) by messagerie.si.c-s.fr
 (Horde Framework) with HTTP; Thu, 23 Jul 2020 18:48:14 +0200
Date:   Thu, 23 Jul 2020 18:48:14 +0200
Message-ID: <20200723184814.Horde.pk5BO9iFqyGX5D4TW5wqmg1@messagerie.si.c-s.fr>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-api@vger.kernel.org, musl@lists.openwall.com,
        libc-dev@lists.llvm.org, linuxppc-dev@lists.ozlabs.org,
        Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 2/2] powerpc/64s: system call support for scv/rfscv
 instructions
References: <20200611081203.995112-1-npiggin@gmail.com>
 <20200611081203.995112-3-npiggin@gmail.com>
 <871rl2ralk.fsf@mpe.ellerman.id.au>
In-Reply-To: <871rl2ralk.fsf@mpe.ellerman.id.au>
User-Agent: Internet Messaging Program (IMP) H5 (6.2.3)
Content-Type: text/plain; charset=UTF-8; format=flowed; DelSp=Yes
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Michael Ellerman <mpe@ellerman.id.au> a écrit :

> Nicholas Piggin <npiggin@gmail.com> writes:
>> diff --git a/arch/powerpc/include/asm/ppc-opcode.h  
>> b/arch/powerpc/include/asm/ppc-opcode.h
>> index 2a39c716c343..b2bdc4de1292 100644
>> --- a/arch/powerpc/include/asm/ppc-opcode.h
>> +++ b/arch/powerpc/include/asm/ppc-opcode.h
>> @@ -257,6 +257,7 @@
>>  #define PPC_INST_MFVSRD			0x7c000066
>>  #define PPC_INST_MTVSRD			0x7c000166
>>  #define PPC_INST_SC			0x44000002
>> +#define PPC_INST_SCV			0x44000001
> ...
>> @@ -411,6 +412,7 @@
> ...
>> +#define __PPC_LEV(l)	(((l) & 0x7f) << 5)
>
> These conflicted and didn't seem to be used so I dropped them.
>
>> diff --git a/arch/powerpc/lib/sstep.c b/arch/powerpc/lib/sstep.c
>> index 5abe98216dc2..161bfccbc309 100644
>> --- a/arch/powerpc/lib/sstep.c
>> +++ b/arch/powerpc/lib/sstep.c
>> @@ -3378,6 +3382,16 @@ int emulate_step(struct pt_regs *regs,  
>> struct ppc_inst instr)
>>  		regs->msr = MSR_KERNEL;
>>  		return 1;
>>
>> +	case SYSCALL_VECTORED_0:	/* scv 0 */
>> +		regs->gpr[9] = regs->gpr[13];
>> +		regs->gpr[10] = MSR_KERNEL;
>> +		regs->gpr[11] = regs->nip + 4;
>> +		regs->gpr[12] = regs->msr & MSR_MASK;
>> +		regs->gpr[13] = (unsigned long) get_paca();
>> +		regs->nip = (unsigned long) &system_call_vectored_emulate;
>> +		regs->msr = MSR_KERNEL;
>> +		return 1;
>> +
>
> This broke the ppc64e build:
>
>   ld: arch/powerpc/lib/sstep.o:(.toc+0x0): undefined reference to  
> `system_call_vectored_emulate'
>   make[1]: *** [/home/michael/linux/Makefile:1139: vmlinux] Error 1
>
> I wrapped it in #ifdef CONFIG_PPC64_BOOK3S.

You mean CONFIG_PPC_BOOK3S_64 ?

Christophe
>
> cheers



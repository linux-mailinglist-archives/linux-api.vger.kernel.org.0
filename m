Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A0B03AE3E9
	for <lists+linux-api@lfdr.de>; Mon, 21 Jun 2021 09:11:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbhFUHNz (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 21 Jun 2021 03:13:55 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:13573 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbhFUHNy (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 21 Jun 2021 03:13:54 -0400
Received: (Authenticated sender: alex@ghiti.fr)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 437B6240008;
        Mon, 21 Jun 2021 07:11:38 +0000 (UTC)
Subject: Re: [PATCH] riscv: Bump COMMAND_LINE_SIZE value to 1024
To:     Palmer Dabbelt <palmer@dabbelt.com>, macro@orcam.me.uk
Cc:     david.abdurachmanov@gmail.com, dvyukov@google.com,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-api@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <mhng-9e6b4607-6bea-411c-b843-916c1e0798ee@palmerdabbelt-glaptop>
From:   Alex Ghiti <alex@ghiti.fr>
Message-ID: <182c1d4e-a117-79d6-4dd1-8e3c8a447b4a@ghiti.fr>
Date:   Mon, 21 Jun 2021 09:11:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <mhng-9e6b4607-6bea-411c-b843-916c1e0798ee@palmerdabbelt-glaptop>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hi Palmer,

Le 23/04/2021 à 04:57, Palmer Dabbelt a écrit :
> On Fri, 02 Apr 2021 11:33:30 PDT (-0700), macro@orcam.me.uk wrote:
>> On Fri, 2 Apr 2021, David Abdurachmanov wrote:
>>
>>> > > >  This macro is exported as a part of the user API so it must 
>>> not depend on
>>> > > > Kconfig.  Also changing it (rather than say adding 
>>> COMMAND_LINE_SIZE_V2 or
>>> > > > switching to an entirely new data object that has its dimension 
>>> set in a
>>> > > > different way) requires careful evaluation as external binaries 
>>> have and
>>> > > > will have the value it expands to compiled in, so it's a part 
>>> of the ABI
>>> > > > too.
>>> > >
>>> > > Thanks, I didn't realize this was part of the user BI.  In that 
>>> case we
>>> > > really can't chage it, so we'll have to sort out some other way 
>>> do fix
>>> > > whatever is going on.
>>> > >
>>> > > I've dropped this from fixes.
>>> >
>>> > Does increasing COMMAND_LINE_SIZE break user-space binaries? I would
>>> > expect it to work the same way as adding new enum values, or adding
>>> > fields at the end of versioned structs, etc.
>>> > I would assume the old bootloaders/etc will only support up to the
>>> > old, smaller max command line size, while the kernel will support
>>> > larger command line size, which is fine.
>>> > However, if something copies /proc/cmdline into a fixed-size buffer
>>> > and expects that to work, that will break... that's quite unfortunate
>>> > user-space code... is it what we afraid of?
>>> >
>>> > Alternatively, could expose the same COMMAND_LINE_SIZE, but internally
>>> > support a larger command line?
>>>
>>> Looking at kernel commit history I see PowerPC switched from 512 to
>>> 2048, and I don't see complaints about the ABI on the mailing list.
>>>
>>> If COMMAND_LINE_SIZE is used by user space applications and we
>>> increase it there shouldn't be problems. I would expect things to
>>> work, but just get truncated boot args? That is the application will
>>> continue only to look at the initial 512 chars.
>>
>>  The macro is in an include/uapi header, so it's exported to the userland
>> and a part of the user API.  I don't know what the consequences are for
>> the RISC-V port specifically, but it has raised my attention, and I think
>> it has to be investigated.
>>
>>  Perhaps it's OK to change it after all, but you'd have to go through
>> known/potential users of this macro.  I guess there shouldn't be that 
>> many
>> of them.
>>
>>  In any case it cannot depend on Kconfig, because the userland won't have
>> access to the configuration, and then presumably wants to handle any and
>> all.
> 
> It kind of feels to me like COMMAND_LINE_SIZE shouldn't have been part 
> of the UABI to begin with.  I sent a patch to remove it from the 
> asm-generic UABI, let's see if anyone knows of a reason it should be UABI:
> 
> https://lore.kernel.org/linux-arch/20210423025545.313965-1-palmer@dabbelt.com/T/#u 

Arnd seemed to agree with you about removing COMMAND_LINE_SIZE from the 
UABI, any progress on your side?

Thanks,

Alex

> 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

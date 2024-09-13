Return-Path: <linux-api+bounces-2315-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3263D977881
	for <lists+linux-api@lfdr.de>; Fri, 13 Sep 2024 07:47:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C2E21C20FA1
	for <lists+linux-api@lfdr.de>; Fri, 13 Sep 2024 05:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3406185E7A;
	Fri, 13 Sep 2024 05:47:23 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 163FE323D;
	Fri, 13 Sep 2024 05:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726206443; cv=none; b=NSHeLNOR6L05yTVs/RpkLEn+iHyHkdxD5qlZ8ZEtbHZTgvnpjW/fJGYkKdzcepEz/0/LTgxVlqZEFY+cT6PjPOPCekf40YoBIIYUM0Z0VbnteIeFFqD0ZSwLUG6Fi3niyAnE3ym9gxBUIDzs7IaZAEn64LCOgKk4i2hNarLm7cA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726206443; c=relaxed/simple;
	bh=cUOwFu2UtxM3l2pffSqHt82mFslpz2gxEF54trMn0P8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YMT8MG6U8A7tjQGwv1K8hblmDa8HU9t9dQ5rF47/e+NhVNiqHM4BgXdz2k45MMa4ZnZ2JAxF1sf76l5IVSb0rTmQEBeV+dwPqkOeIttv31OZAN09IBrHurIHoCYCLMBpCU+QNH/uw4QwG0Oh0zHtg61wif0qsP+L8IkAf1y+7dM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4X4jxg6vMMz9sxD;
	Fri, 13 Sep 2024 07:47:19 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rcETtnnNavE7; Fri, 13 Sep 2024 07:47:19 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4X4jxg5s39z9sjv;
	Fri, 13 Sep 2024 07:47:19 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id B48CF8B77A;
	Fri, 13 Sep 2024 07:47:19 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id BrEQGrKMhBAg; Fri, 13 Sep 2024 07:47:19 +0200 (CEST)
Received: from [192.168.233.70] (unknown [192.168.233.70])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 458908B766;
	Fri, 13 Sep 2024 07:47:18 +0200 (CEST)
Message-ID: <fe46ee6f-24c2-42be-942c-e03bc2b6e0aa@csgroup.eu>
Date: Fri, 13 Sep 2024 07:47:17 +0200
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [linus:master] [mseal] 8be7258aad:
 stress-ng.pagemove.page_remaps_per_sec -4.4% regression
To: Michael Ellerman <mpe@ellerman.id.au>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Nicholas Piggin <npiggin@gmail.com>
Cc: Jeff Xu <jeffxu@google.com>, Pedro Falcato <pedro.falcato@gmail.com>,
 kernel test robot <oliver.sang@intel.com>, Jeff Xu <jeffxu@chromium.org>,
 oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, Kees Cook
 <keescook@chromium.org>, "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Dave Hansen <dave.hansen@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Guenter Roeck <groeck@chromium.org>, Jann Horn <jannh@google.com>,
 Jonathan Corbet <corbet@lwn.net>, Jorge Lucangeli Obes
 <jorgelo@chromium.org>, Matthew Wilcox <willy@infradead.org>,
 Muhammad Usama Anjum <usama.anjum@collabora.com>,
 =?UTF-8?Q?Stephen_R=C3=B6ttger?= <sroettger@google.com>,
 Suren Baghdasaryan <surenb@google.com>,
 Amer Al Shanawany <amer.shanawany@gmail.com>,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Shuah Khan <shuah@kernel.org>, linux-api@vger.kernel.org,
 linux-mm@kvack.org, ying.huang@intel.com, feng.tang@intel.com,
 fengwei.yin@intel.com
References: <202408041602.caa0372-oliver.sang@intel.com>
 <CAHk-=whbxLj0thXPzN9aW4CcX1D2_dntNu+x9-8uBakamBggLA@mail.gmail.com>
 <CAKbZUD3B03Zjex4STW8J_1VJhpsYb=1mnZL2-vSaW-CaZdzLiA@mail.gmail.com>
 <CALmYWFuXVCvAfrcDOCAR72z2_rmnm09QeVVqdhzqjF-fZ9ndUA@mail.gmail.com>
 <CAHk-=wgPHCJ0vZMfEP50VPjSVi-CzL0fhTGXgNLQn=Pp9W0DVA@mail.gmail.com>
 <CALmYWFuCvphvLQOuQHBbFq0G8Ekyze=q45Tt4dATOt-GhO2RGg@mail.gmail.com>
 <CAHk-=wgySgXXkZtx49Xq70X2CmSizM8siacYKncMmFWRzKjs5Q@mail.gmail.com>
 <D38D6LJZOIQK.2GV58PGVL5K85@gmail.com>
 <CAHk-=wjeWqr+0Ktzbwqrw17aESe5dZm5Kt6nwqtKJX00VsDqWg@mail.gmail.com>
 <87r0b2if4t.fsf@mail.lhotse>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <87r0b2if4t.fsf@mail.lhotse>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 06/08/2024 à 04:01, Michael Ellerman a écrit :
> Linus Torvalds <torvalds@linux-foundation.org> writes:
>> On Mon, 5 Aug 2024 at 16:25, Nicholas Piggin <npiggin@gmail.com> wrote:
>>>
>>> Can userspace on other archs not unmap their vdsos?
>>
>> I think they can, and nobody cares. The "context.vdso" value stays at
>> some stale value, and anybody who tries to use it will just fail.
>>
>> So what makes powerpc special is not "you can unmap the vdso", but
>> "powerpc cares".
>>
>> I just don't quite know _why_ powerpc cares.
> 
> AFAIK for CRIU the problem is signal delivery:
> 
> arch/powerpc/kernel/signal_64.c:
> 
> int handle_rt_signal64(struct ksignal *ksig, sigset_t *set,
> 		struct task_struct *tsk)
> {
>          ...
> 	/* Set up to return from userspace. */
> 	if (tsk->mm->context.vdso) {
> 		regs_set_return_ip(regs, VDSO64_SYMBOL(tsk->mm->context.vdso, sigtramp_rt64));
> 
> 
> ie. if the VDSO is moved but mm->context.vdso is not updated, signal
> delivery will crash in userspace.
> 
> x86-64 always uses SA_RESTORER, and arm64 & s390 can use SA_RESTORER, so
> I think CRIU uses that to avoid problems with signal delivery when the
> VDSO is moved.
> 
> riscv doesn't support SA_RESTORER but I guess CRIU doesn't support riscv
> yet so it's not become a problem.
> 
> There was a patch to support SA_RESTORER on powerpc, but I balked at
> merging it because I couldn't find anyone on the glibc side to say
> whether they wanted it or not. I guess I should have just merged it.

The patch is at 
https://patchwork.ozlabs.org/project/linuxppc-dev/patch/afe50d1db63a10fde9547ea08fe1fa68b0638aba.1624618157.git.christophe.leroy@csgroup.eu/

It still applies cleanly.

Christophe


> 
> There was an attempt to unify all the vdso stuff and handle the
> VDSO mremap case in generic code:
> 
>    https://lore.kernel.org/lkml/20210611180242.711399-17-dima@arista.com/
> 
> But I think that series got a bit big and complicated and Dmitry had to
> move on to other things.
> 
> cheers


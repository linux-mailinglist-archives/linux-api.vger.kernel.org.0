Return-Path: <linux-api+bounces-2314-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 139DF975F8F
	for <lists+linux-api@lfdr.de>; Thu, 12 Sep 2024 05:11:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF673286071
	for <lists+linux-api@lfdr.de>; Thu, 12 Sep 2024 03:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD1CE78C60;
	Thu, 12 Sep 2024 03:11:20 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A346744C6C;
	Thu, 12 Sep 2024 03:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726110680; cv=none; b=Rf8zf4FEvy4xLznBhRpXr8HQQaqqdaxsuoZurZ65C4E93khjSznWSOpU+amKcvigJI0IU3haj1ABT9Mhdg8xzSkzqDFsnb8NBD+OiNFAODrjN7b+d7mvOeDX7pb7Mpk2Td8nghL1tNXMCwqw0I2ycF2rvOjpo3L0PhxPj048nnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726110680; c=relaxed/simple;
	bh=OArDEyqgWVPGjdCXCoJCy+3m3bqqS/ssLLVmDdflos8=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=BBm19+HfG/MU/x5HURwiHGuUfZ7FbX0l5ZkyNzSj4ZaJoQEkWxd+jIQxIM8TmqGb51WYzBfDvaNe830Pam0rmxTd5vRugmI8miHNTfO7miAneJ1kN1cP2imh1q8oY6ujSTq8EX6ylgSK9k+592GJ9yJh0Fg0nD3qNnJAwXxLtss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4X42Wx13Pxz69NK;
	Thu, 12 Sep 2024 11:11:09 +0800 (CST)
Received: from kwepemd200019.china.huawei.com (unknown [7.221.188.193])
	by mail.maildlp.com (Postfix) with ESMTPS id 122AA140453;
	Thu, 12 Sep 2024 11:11:16 +0800 (CST)
Received: from [10.173.127.72] (10.173.127.72) by
 kwepemd200019.china.huawei.com (7.221.188.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 12 Sep 2024 11:11:12 +0800
Subject: Re: [PATCH v23 1/4] mm: add MAP_DROPPABLE for designating always
 lazily freeable mappings
To: "Jason A. Donenfeld" <Jason@zx2c4.com>, <linux-kernel@vger.kernel.org>,
	<patches@lists.linux.dev>, <tglx@linutronix.de>
CC: <linux-crypto@vger.kernel.org>, <linux-api@vger.kernel.org>,
	<x86@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Adhemerval Zanella Netto
	<adhemerval.zanella@linaro.org>, Carlos O'Donell <carlos@redhat.com>, Florian
 Weimer <fweimer@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Jann Horn
	<jannh@google.com>, Christian Brauner <brauner@kernel.org>, David Hildenbrand
	<dhildenb@redhat.com>, <linux-mm@kvack.org>, David Hildenbrand
	<david@redhat.com>
References: <20240712014009.281406-1-Jason@zx2c4.com>
 <20240712014009.281406-2-Jason@zx2c4.com>
From: Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <ee5d3e39-572c-7ec6-f329-1275d7138220@huawei.com>
Date: Thu, 12 Sep 2024 11:11:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240712014009.281406-2-Jason@zx2c4.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemd200019.china.huawei.com (7.221.188.193)

On 2024/7/12 9:40, Jason A. Donenfeld wrote:
> The vDSO getrandom() implementation works with a buffer allocated with a
> new system call that has certain requirements:
> 
> - It shouldn't be written to core dumps.
>   * Easy: VM_DONTDUMP.
> - It should be zeroed on fork.
>   * Easy: VM_WIPEONFORK.
> 
> - It shouldn't be written to swap.
>   * Uh-oh: mlock is rlimited.
>   * Uh-oh: mlock isn't inherited by forks.
> 
> - It shouldn't reserve actual memory, but it also shouldn't crash when
>   page faulting in memory if none is available
>   * Uh-oh: VM_NORESERVE means segfaults.
> 
> It turns out that the vDSO getrandom() function has three really nice
> characteristics that we can exploit to solve this problem:
> 
> 1) Due to being wiped during fork(), the vDSO code is already robust to
>    having the contents of the pages it reads zeroed out midway through
>    the function's execution.
> 
> 2) In the absolute worst case of whatever contingency we're coding for,
>    we have the option to fallback to the getrandom() syscall, and
>    everything is fine.
> 
> 3) The buffers the function uses are only ever useful for a maximum of
>    60 seconds -- a sort of cache, rather than a long term allocation.
> 
> These characteristics mean that we can introduce VM_DROPPABLE, which
> has the following semantics:
> 
> a) It never is written out to swap.
> b) Under memory pressure, mm can just drop the pages (so that they're
>    zero when read back again).
> c) It is inherited by fork.
> d) It doesn't count against the mlock budget, since nothing is locked.
> e) If there's not enough memory to service a page fault, it's not fatal,
>    and no signal is sent.
> 
> This way, allocations used by vDSO getrandom() can use:
> 
>     VM_DROPPABLE | VM_DONTDUMP | VM_WIPEONFORK | VM_NORESERVE
> 
> And there will be no problem with OOMing, crashing on overcommitment,
> using memory when not in use, not wiping on fork(), coredumps, or
> writing out to swap.
> 
> In order to let vDSO getrandom() use this, expose these via mmap(2) as
> MAP_DROPPABLE.
> 
> Note that this involves removing the MADV_FREE special case from
> sort_folio(), which according to Yu Zhao is unnecessary and will simply
> result in an extra call to shrink_folio_list() in the worst case. The
> chunk removed reenables the swapbacked flag, which we don't want for
> VM_DROPPABLE, and we can't conditionalize it here because there isn't a
> vma reference available.
> 
> Finally, the provided self test ensures that this is working as desired.
> 
> Cc: linux-mm@kvack.org
> Acked-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> ---
...

> diff --git a/mm/memory.c b/mm/memory.c
> index d10e616d7389..18fe893ce96d 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -5690,6 +5690,10 @@ vm_fault_t handle_mm_fault(struct vm_area_struct *vma, unsigned long address,
>  
>  	lru_gen_exit_fault();
>  
> +	/* If the mapping is droppable, then errors due to OOM aren't fatal. */
> +	if (vma->vm_flags & VM_DROPPABLE)
> +		ret &= ~VM_FAULT_OOM;
> +
I'm sorry for jumping in here. I am confused about the code in handle_mm_fault(). Since VM_FAULT_OOM is simply
dropped, page fault will be re-triggered soon? If so, when oom is disabled or fails to move forward, page fault
will re-trigger again and again as no memory is available? I might be miss something.

Thanks.
.



Return-Path: <linux-api+bounces-1861-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE9BE9296FC
	for <lists+linux-api@lfdr.de>; Sun,  7 Jul 2024 09:42:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BC751F2164E
	for <lists+linux-api@lfdr.de>; Sun,  7 Jul 2024 07:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B332EF511;
	Sun,  7 Jul 2024 07:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QpgboM9b"
X-Original-To: linux-api@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC78F4EB
	for <linux-api@vger.kernel.org>; Sun,  7 Jul 2024 07:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720338168; cv=none; b=RnsG6PMrkFsLJT7gjo1ZsJZQH6VE2tgxMWWVAsaqTwStf0uaVTCwLwa9VC1BdNC8VB3haGD0tgn6ShHlOA3kXPlpB2Au7mmJmV/JyUBAnvQzvtZsIZA8k/QU5F/fdAE2AWUuFMRvkAePKk6ki9zuQEeGj+2+AfQEtaCMhoe0JUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720338168; c=relaxed/simple;
	bh=Sv+6qZ4MNyt9/6rZwo6Evmz0uv3eMfEBiZfsAHo+q7I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=levpfo4lGg8E54NhOPIjWjQm9bKcA0HnwLkqlU2zad8hcg9mkICmqlJGVpfPI6XheygkWaL7UyNSiQ9+fhgabD5rx/S8B0wPB5+ktvkxwX8cr88pD0LhySBJ7E8M6JWIL5e/M67IiUliCbQmQkbtA4QxMNbJ8DRJ+lHzTB9iY7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QpgboM9b; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720338164;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=t3RKNkkrdFkLgQjs+IVFjp0LP5x1dcd1kPadp8bz1kc=;
	b=QpgboM9bY3/kvxYiqj6825gBBchFCHFy/Eq0tt7RFpMTNn/pHXnlCjzk54GYqsPE89YRY7
	QXyLgXcWcbir68bN1FEJXa+l5HbuUv139bWDBjS6gyOBquclxjpKOMx0h64oYRYWnt24js
	T8fxLR5NWjOO75NklXbJ3lm0+cEiwWA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-421-G5JRhx_1OL-nmZIemmr61g-1; Sun, 07 Jul 2024 03:42:42 -0400
X-MC-Unique: G5JRhx_1OL-nmZIemmr61g-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4265cf3085aso10301775e9.2
        for <linux-api@vger.kernel.org>; Sun, 07 Jul 2024 00:42:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720338161; x=1720942961;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=t3RKNkkrdFkLgQjs+IVFjp0LP5x1dcd1kPadp8bz1kc=;
        b=FeuZh6MMhf1KgCOvli8BStwgIWEXYYps/malbU1ddp9fp2Tq6stAHkJ12hxl40/1FD
         FTz2jg+DCF4zjT7C50+TBgw4WPi6AGDJgdGdgU0QsAlfhGozpThK2eHRdeV4fnhgnISf
         To0+SHbJZpIRu5zLdInaMeNgfXmEjT2ih7T46nN3UoXmPKcYXBSd7ops16DKfwPjD0pq
         tqrWqQ20LoFzMAq7ZccT3hR8YvCMtUEc1Q/evlj43Ey3Oo/DMmbI3AIA1WrnfdhrD6nd
         TQWGPNoWAx0YpDCQJt2hGHkxw8RqoNeq7LrI6VTMMYCnMTKJbOH0a2ruPYpNk57wf7dN
         gKPg==
X-Forwarded-Encrypted: i=1; AJvYcCUB1SbVe6jJoczL5SYowhnTsHAqFFwNQ+NNs0jy1lc7j72yGR9G8/oc2xuCWjgqQ6YO82W5mV+Td7p8KVRtfGFHgNBUKC8LM+0R
X-Gm-Message-State: AOJu0YyQMLPhgWLzW6Ccx+Q9kaJyyyhX+DwIvMtY1rBwNP9Nps6tOkAF
	lmljOWKKtL3NMFrZQjBvxgmZzr5ju+Yd1qUGywpvO3qXQV6tGVzK0i5R2l89yYecryqPq3jo0kJ
	fQO/gqfJ4oYgbkgnr2pFkZl7aL6nAIdeblIlYe1Pc7MhFrFnpjJBy/PcT++wWBg+fjQ==
X-Received: by 2002:a05:600c:5128:b0:426:6861:a1ab with SMTP id 5b1f17b1804b1-4266861a3cemr1399315e9.39.1720338161388;
        Sun, 07 Jul 2024 00:42:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGPdLqH2Vbsk5rcWJKxb4mM7C511LBkpl/vWHl3XqkRvS1lIuRjmD6yUygaTWAcwdjEYySUDg==
X-Received: by 2002:a05:600c:5128:b0:426:6861:a1ab with SMTP id 5b1f17b1804b1-4266861a3cemr1399245e9.39.1720338160833;
        Sun, 07 Jul 2024 00:42:40 -0700 (PDT)
Received: from ?IPV6:2003:cb:c72f:c00:10f0:d1a8:c206:17ac? (p200300cbc72f0c0010f0d1a8c20617ac.dip0.t-ipconnect.de. [2003:cb:c72f:c00:10f0:d1a8:c206:17ac])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4264a21cc59sm119763395e9.25.2024.07.07.00.42.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Jul 2024 00:42:40 -0700 (PDT)
Message-ID: <1583c837-a4d5-4a8a-9c1d-2c64548cd199@redhat.com>
Date: Sun, 7 Jul 2024 09:42:38 +0200
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v21 1/4] mm: add VM_DROPPABLE for designating always
 lazily freeable mappings
To: "Jason A. Donenfeld" <Jason@zx2c4.com>, linux-kernel@vger.kernel.org,
 patches@lists.linux.dev, tglx@linutronix.de
Cc: linux-crypto@vger.kernel.org, linux-api@vger.kernel.org, x86@kernel.org,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
 Carlos O'Donell <carlos@redhat.com>, Florian Weimer <fweimer@redhat.com>,
 Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>,
 Christian Brauner <brauner@kernel.org>,
 David Hildenbrand <dhildenb@redhat.com>, linux-mm@kvack.org
References: <20240707002658.1917440-1-Jason@zx2c4.com>
 <20240707002658.1917440-2-Jason@zx2c4.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240707002658.1917440-2-Jason@zx2c4.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 07.07.24 02:26, Jason A. Donenfeld wrote:

Hi,

having more generic support for VM_DROPPABLE sounds great, I was myself 
at some point looking for something like that.

> The vDSO getrandom() implementation works with a buffer allocated with a
> new system call that has certain requirements:
> 
> - It shouldn't be written to core dumps.
>    * Easy: VM_DONTDUMP.
> - It should be zeroed on fork.
>    * Easy: VM_WIPEONFORK.
> 
> - It shouldn't be written to swap.
>    * Uh-oh: mlock is rlimited.
>    * Uh-oh: mlock isn't inherited by forks.
> 
> It turns out that the vDSO getrandom() function has three really nice
> characteristics that we can exploit to solve this problem:
> 
> 1) Due to being wiped during fork(), the vDSO code is already robust to
>     having the contents of the pages it reads zeroed out midway through
>     the function's execution.
> 
> 2) In the absolute worst case of whatever contingency we're coding for,
>     we have the option to fallback to the getrandom() syscall, and
>     everything is fine.
> 
> 3) The buffers the function uses are only ever useful for a maximum of
>     60 seconds -- a sort of cache, rather than a long term allocation.
> 
> These characteristics mean that we can introduce VM_DROPPABLE, which
> has the following semantics:
> 
> a) It never is written out to swap.
> b) Under memory pressure, mm can just drop the pages (so that they're
>     zero when read back again).
> c) It is inherited by fork.
> d) It doesn't count against the mlock budget, since nothing is locked.
> 
> This is fairly simple to implement, with the one snag that we have to
> use 64-bit VM_* flags, but this shouldn't be a problem, since the only
> consumers will probably be 64-bit anyway.
> 
> This way, allocations used by vDSO getrandom() can use:
> 
>      VM_DROPPABLE | VM_DONTDUMP | VM_WIPEONFORK | VM_NORESERVE
> 
> And there will be no problem with using memory when not in use, not
> wiping on fork(), coredumps, or writing out to swap.
> 
> In order to let vDSO getrandom() use this, expose these via mmap(2) as
> well, giving MAP_WIPEONFORK, MAP_DONTDUMP, and MAP_DROPPABLE.


Patch subject would be better to talk about MAP_DROPPABLE now.

But I don't immediately see why MAP_WIPEONFORK and MAP_DONTDUMP have to 
be mmap() flags. Using mmap(MAP_NORESERVE|MAP_DROPPABLE) with madvise() 
to configure these (for users that require that) should be good enough, 
just like they are for existing users.

Thinking out loud, also MAP_DROPPABLE only sets a VMA flag (and does 
snot affect memory commitiing like MAP_NORESERVE), right? So 
MAP_DROPPABLE could easily become a madvise() option as well?

(as you know, we only have limited mmap bits but plenty of madvise 
numbers available)


Interestingly, when looking into something comparable in the past I 
stumbled over "vrange" [1], which would have had a slightly different 
semantic (signal on reaccess). And that did turn out to be more sutibale 
for madvise() flags [2], whereby vrange evolved into 
MADV_VOLATILE/MADV_NONVOLATILE

A sticky MADV_VOLATILE vs. MADV_NONVOLATILE would actually sound pretty 
handy. (again, with your semantics, not the signal-on-reaccess kind of 
thing)

([2] is in general a good read; hey, it's been 10 years since that was 
brought up the last time!)


There needs to be better reasoning why we have to consume three mmap 
bits for something that can likely be achieved without any.

Maybe that was discussed with Linus and there is a pretty good reason 
for that.

I'll also mention that I am unsure how MAP_DROPPABLE is supposed to 
interact with mlock. Maybe just like MADV_FREE currently does (no idea 
if that will work as intended ;) ).


[1] https://lwn.net/Articles/590991/
[2] https://lwn.net/Articles/602650/

> 
> Finally, the provided self test ensures that this is working as desired.
> 
> Cc: linux-mm@kvack.org
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> ---


[...]

> diff --git a/mm/mprotect.c b/mm/mprotect.c
> index 8c6cd8825273..57b8dad9adcc 100644
> --- a/mm/mprotect.c
> +++ b/mm/mprotect.c
> @@ -623,7 +623,7 @@ mprotect_fixup(struct vma_iterator *vmi, struct mmu_gather *tlb,
>   				may_expand_vm(mm, oldflags, nrpages))
>   			return -ENOMEM;
>   		if (!(oldflags & (VM_ACCOUNT|VM_WRITE|VM_HUGETLB|
> -						VM_SHARED|VM_NORESERVE))) {
> +				  VM_SHARED|VM_NORESERVE|VM_DROPPABLE))) {
>   			charged = nrpages;
>   			if (security_vm_enough_memory_mm(mm, charged))
>   				return -ENOMEM;

I don't quite understand this change here. If MAP_DROPPABLE does not 
affect memory accounting during mmap(), it should not affect the same 
during mprotect(). VM_NORESERVE / MAP_NORESERVE is responsible for that.

Did I missing something where MAP_DROPPABLE changes the memory 
accounting during mmap()?

> diff --git a/mm/rmap.c b/mm/rmap.c
> index e8fc5ecb59b2..56d7535d5cf6 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -1397,7 +1397,10 @@ void folio_add_new_anon_rmap(struct folio *folio, struct vm_area_struct *vma,
>   	VM_WARN_ON_FOLIO(folio_test_hugetlb(folio), folio);
>   	VM_BUG_ON_VMA(address < vma->vm_start ||
>   			address + (nr << PAGE_SHIFT) > vma->vm_end, vma);
> -	__folio_set_swapbacked(folio);
> +	/* VM_DROPPABLE mappings don't swap; instead they're just dropped when
> +	 * under memory pressure. */
> +	if (!(vma->vm_flags & VM_DROPPABLE))
> +		__folio_set_swapbacked(folio);
>   	__folio_set_anon(folio, vma, address, true);
>   
>   	if (likely(!folio_test_large(folio))) {
> @@ -1841,7 +1844,11 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
>   				 * plus the rmap(s) (dropped by discard:).
>   				 */
>   				if (ref_count == 1 + map_count &&
> -				    !folio_test_dirty(folio)) {
> +				    (!folio_test_dirty(folio) ||
> +				     /* Unlike MADV_FREE mappings, VM_DROPPABLE
> +				      * ones can be dropped even if they've
> +				      * been dirtied. */

We use

/*
  * Comment start
  * Comment end
  */

styled comments in MM.

> +				     (vma->vm_flags & VM_DROPPABLE))) {
>   					dec_mm_counter(mm, MM_ANONPAGES);
>   					goto discard;
>   				}
> @@ -1851,7 +1858,10 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
>   				 * discarded. Remap the page to page table.
>   				 */
>   				set_pte_at(mm, address, pvmw.pte, pteval);
> -				folio_set_swapbacked(folio);
> +				/* Unlike MADV_FREE mappings, VM_DROPPABLE ones
> +				 * never get swap backed on failure to drop. */
> +				if (!(vma->vm_flags & VM_DROPPABLE))
> +					folio_set_swapbacked(folio);
>   				ret = false;
>   				page_vma_mapped_walk_done(&pvmw);
>   				break;

A note that in mm/mm-stable, "madvise_free_huge_pmd" exists to optimize 
MADV_FREE on PMDs. I suspect we'd want to extend that one as well for 
dropping support, but likely it would also only be a performance 
improvmeent and not affect functonality if not handled.

-- 
Cheers,

David / dhildenb



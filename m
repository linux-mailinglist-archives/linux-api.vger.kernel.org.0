Return-Path: <linux-api+bounces-1868-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 696FD929A95
	for <lists+linux-api@lfdr.de>; Mon,  8 Jul 2024 03:46:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 864701C2090C
	for <lists+linux-api@lfdr.de>; Mon,  8 Jul 2024 01:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72E1AEDB;
	Mon,  8 Jul 2024 01:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="ATv78rgt"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ABDBA2A;
	Mon,  8 Jul 2024 01:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720403176; cv=none; b=ptCpkoGBa4DctmPK/PJt9DwxVnleT8yrSnLrIfmcwq7BbrQcLWQ90taaaoWxSCDr5OIwo60ZxPYmjlEsnVWwFHLjRJUp1dogyN6XpNLGklxLM4zR/sRsso9aBYg5/4zDV4jAofwPJut9nzO2dsFOeOejObFbf3W/mypn5RfZ7Jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720403176; c=relaxed/simple;
	bh=JeCMPLxGqOjRC/YZuG7IeDSGQBJtMx9DKm8J8FVyUls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZQTNIVVbUr0jm+KV6i+LJ9Fwzi/h6xgNss7Rcg+d9/WazEA6qWg/qJG7J/j74a2RUSXaHB7toGm1VVUlm+Mfh/W1h65wmSuyFNr28+8G58uxg9i/jKksWy2KQb5QMa0wNiXLpCNtYnChPzYh8zBOr0O0QPDbWNYTYJm0ovvzzFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=ATv78rgt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21C9CC3277B;
	Mon,  8 Jul 2024 01:46:14 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="ATv78rgt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1720403171;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wNm2R1n+MIEThUcyIX2REGbOX7o31ZK6mTAc1tqY4Ec=;
	b=ATv78rgtmz5EROWymcyF0jsKj4PQq8A5vhpa/bgzqkPjwOB73zr8dHZFY5p4T+o6ZQlnwR
	WuQ3N6Av5WPkQcXiUpeUqBmncDWFxQRetmsNY8og2J7Pxsfq48KswCB9NeoCx3NPN0r4fb
	nEUmg3vf01hoKcKxOwFSom7FscFR/x8=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 2900d469 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 8 Jul 2024 01:46:11 +0000 (UTC)
Date: Mon, 8 Jul 2024 03:46:07 +0200
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, patches@lists.linux.dev,
	tglx@linutronix.de, linux-crypto@vger.kernel.org,
	linux-api@vger.kernel.org, x86@kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
	Carlos O'Donell <carlos@redhat.com>,
	Florian Weimer <fweimer@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
	Jann Horn <jannh@google.com>,
	Christian Brauner <brauner@kernel.org>,
	David Hildenbrand <dhildenb@redhat.com>, linux-mm@kvack.org
Subject: Re: [PATCH v21 1/4] mm: add VM_DROPPABLE for designating always
 lazily freeable mappings
Message-ID: <ZotE3-VwI0SJlM6w@zx2c4.com>
References: <20240707002658.1917440-1-Jason@zx2c4.com>
 <20240707002658.1917440-2-Jason@zx2c4.com>
 <1583c837-a4d5-4a8a-9c1d-2c64548cd199@redhat.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1583c837-a4d5-4a8a-9c1d-2c64548cd199@redhat.com>

Hi David,

Thanks a lot for the review of the code. Am very glad to have somebody
who knows this code take a careful look at it.

On Sun, Jul 07, 2024 at 09:42:38AM +0200, David Hildenbrand wrote:
> Patch subject would be better to talk about MAP_DROPPABLE now.

Will do. Or, well, in light of the conversation downthread, MAP_DROPPABLE.

> But I don't immediately see why MAP_WIPEONFORK and MAP_DONTDUMP have to 
> be mmap() flags. Using mmap(MAP_NORESERVE|MAP_DROPPABLE) with madvise() 
> to configure these (for users that require that) should be good enough, 
> just like they are for existing users.

I looked into that too, and coming up with some clunky mechanism for
automating several calls to madvise() for each thing. I could make it
work need be, but it's really not nice. And it sort of then leads in the
direction, "this interface isn't great; why don't you just make a
dedicated syscall that does everything you need in one fell swoop,"
which is explicitly what Linus doesn't want. Making it accessible to
mmap() instead makes it more of a direct thing that isn't a whole new
syscall.

Anyway, it indeed looks like there are more PROT_ bits available, and
also that PROT_ has been used this way before. In addition to PROT_SEM,
there are a few arch-specific PROT_ bits that seem similar enough. The
distinction is pretty blurry between MAP_ and PROT_.

So I'll just move this to PROT_ for v+1.

> > diff --git a/mm/mprotect.c b/mm/mprotect.c
> > index 8c6cd8825273..57b8dad9adcc 100644
> > --- a/mm/mprotect.c
> > +++ b/mm/mprotect.c
> > @@ -623,7 +623,7 @@ mprotect_fixup(struct vma_iterator *vmi, struct mmu_gather *tlb,
> >   				may_expand_vm(mm, oldflags, nrpages))
> >   			return -ENOMEM;
> >   		if (!(oldflags & (VM_ACCOUNT|VM_WRITE|VM_HUGETLB|
> > -						VM_SHARED|VM_NORESERVE))) {
> > +				  VM_SHARED|VM_NORESERVE|VM_DROPPABLE))) {
> >   			charged = nrpages;
> >   			if (security_vm_enough_memory_mm(mm, charged))
> >   				return -ENOMEM;
> 
> I don't quite understand this change here. If MAP_DROPPABLE does not 
> affect memory accounting during mmap(), it should not affect the same 
> during mprotect(). VM_NORESERVE / MAP_NORESERVE is responsible for that.
> 
> Did I missing something where MAP_DROPPABLE changes the memory 
> accounting during mmap()?

Actually, I think I errored by not adding it to mmap() (via the check in
accountable_mapping(), I believe), and I should add it there.  That also
might be another reason why this is better as a MAP_ (or, rather PROT_)
bit, rather than an madvise call.

Tell me if you disagree, as I might be way off here. But I was thinking
that because the system can just "drop" this memory, it's not sensible
to account for it, because it can be taken right back.

> > diff --git a/mm/rmap.c b/mm/rmap.c
> We use
> 
> /*
>   * Comment start
>   * Comment end
>   */
> 
> styled comments in MM.

Fixed.

> 
> > +				     (vma->vm_flags & VM_DROPPABLE))) {
> >   					dec_mm_counter(mm, MM_ANONPAGES);
> >   					goto discard;
> >   				}
> > @@ -1851,7 +1858,10 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
> >   				 * discarded. Remap the page to page table.
> >   				 */
> >   				set_pte_at(mm, address, pvmw.pte, pteval);
> > -				folio_set_swapbacked(folio);
> > +				/* Unlike MADV_FREE mappings, VM_DROPPABLE ones
> > +				 * never get swap backed on failure to drop. */
> > +				if (!(vma->vm_flags & VM_DROPPABLE))
> > +					folio_set_swapbacked(folio);
> >   				ret = false;
> >   				page_vma_mapped_walk_done(&pvmw);
> >   				break;
> 
> A note that in mm/mm-stable, "madvise_free_huge_pmd" exists to optimize 
> MADV_FREE on PMDs. I suspect we'd want to extend that one as well for 
> dropping support, but likely it would also only be a performance 
> improvmeent and not affect functonality if not handled.

That's for doing the freeing of PTEs after the fact, right? If the
mapping was created, got filled with some data, and then sometime later
it got MADV_FREE'd, which is the pattern people follow typically with
MADV_FREE. If we do this as PROT_/MAP_, then that's not a case we need
to worry about, if I understand this code correctly.

Jason


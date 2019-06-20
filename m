Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 66EC94C667
	for <lists+linux-api@lfdr.de>; Thu, 20 Jun 2019 07:01:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726634AbfFTFBl (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 20 Jun 2019 01:01:41 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45170 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725875AbfFTFBl (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 20 Jun 2019 01:01:41 -0400
Received: by mail-pf1-f196.google.com with SMTP id r1so931042pfq.12;
        Wed, 19 Jun 2019 22:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZnHKcO/AdXB5nY2IUk+trHT+q+fznBBu7HQwtNrjGAk=;
        b=Qa3bydsIHKJBhOMk7gYmp0o3qMDC3J5LhBP9lfxk1676C6RCjuIJ5yk6OTwQ6tk3U5
         oMR25pVuLTNI2CE3iStstuYkCoNFtMKo0RfCFvn1mRHdhyuZlRHr+fZ9qKMPB1HXrqFm
         rxae4Q9Gl+ojjqDc9sFeZQkOAqjopHSk8cg2D0l1ofFZdRiZj9+RY2v2VBg+dUg8RidI
         EMwcuUroZ7RX2BXI/CDHOIzDL7Y7DLfYKmgEW9Sd7wHIkXmbF1TV2gngnAsA8khnIOTa
         z5iMFTWNKEWSocl9UZE5KYPIlUv1g1jzGqkoks6uZPD3vyVWIJswB/SiMY5OLv9XKJan
         JjEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZnHKcO/AdXB5nY2IUk+trHT+q+fznBBu7HQwtNrjGAk=;
        b=E+hw4NLdX3x96+hqr8Uh6GN9TE8Zj85oD4WoZekDRW67uyLgtgZCzjsg468g+1ZxsO
         NiJJi2VjgpzkoyUc+Jc8UNWsodiKhwMPwRXEP48cyozU2gx588UQE+0T/DNQrjLjKB05
         /PubUBNLhJOu3YuoI6k8WTc+8t3C65TpqGGRN3zY0ae29ovIYmwlimBWWHg6Q4U/oUhH
         tr07jRAxUr5/dZPu+Gffbo4xUQbHjeqahhgfDiaKlTyXY9b8OEe7YIui8YcKkR/4Rrzj
         fupB8d+Liwj0c8ZF1VMNa69oNSwws9Hk1jWRnK6E1W4n/FqNxhN97fjBY8UP63n5Om7H
         wLJA==
X-Gm-Message-State: APjAAAUStmjwvDBghXRBlgZjxAOgTOKupoZ1SVBDxYx73gsXc9/FjuWd
        H6mxfWTYIhqqOU92w9N5w1WW99Oz
X-Google-Smtp-Source: APXvYqzsxnJB6epMwEqEkgB+WpWeMOmsTBRAbdAEBhcnSeNO6RQO5pNjIrNiARsQTnyP7EpksTPfUA==
X-Received: by 2002:a65:510c:: with SMTP id f12mr10859898pgq.92.1561006900098;
        Wed, 19 Jun 2019 22:01:40 -0700 (PDT)
Received: from google.com ([2401:fa00:d:0:98f1:8b3d:1f37:3e8])
        by smtp.gmail.com with ESMTPSA id j8sm19364153pfi.148.2019.06.19.22.01.34
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 19 Jun 2019 22:01:38 -0700 (PDT)
Date:   Thu, 20 Jun 2019 14:01:32 +0900
From:   Minchan Kim <minchan@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-api@vger.kernel.org,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tim Murray <timmurray@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Daniel Colascione <dancol@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Sonny Rao <sonnyrao@google.com>,
        Brian Geffon <bgeffon@google.com>, jannh@google.com,
        oleg@redhat.com, christian@brauner.io, oleksandr@redhat.com,
        hdanton@sina.com, vdavydov.dev@gmail.com
Subject: Re: [PATCH v1 1/4] mm: introduce MADV_COLD
Message-ID: <20190620050132.GC105727@google.com>
References: <20190603053655.127730-1-minchan@kernel.org>
 <20190603053655.127730-2-minchan@kernel.org>
 <20190604203841.GC228607@google.com>
 <20190610100904.GC55602@google.com>
 <20190612172104.GA125771@google.com>
 <20190613044824.GF55602@google.com>
 <20190619171340.GA83620@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190619171340.GA83620@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, Jun 19, 2019 at 01:13:40PM -0400, Joel Fernandes wrote:
< snip >

Ccing Vladimir

> > > > > > +static int madvise_cold_pte_range(pmd_t *pmd, unsigned long addr,
> > > > > > +				unsigned long end, struct mm_walk *walk)
> > > > > > +{
> > > > > > +	pte_t *orig_pte, *pte, ptent;
> > > > > > +	spinlock_t *ptl;
> > > > > > +	struct page *page;
> > > > > > +	struct vm_area_struct *vma = walk->vma;
> > > > > > +	unsigned long next;
> > > > > > +
> > > > > > +	next = pmd_addr_end(addr, end);
> > > > > > +	if (pmd_trans_huge(*pmd)) {
> > > > > > +		ptl = pmd_trans_huge_lock(pmd, vma);
> > > > > > +		if (!ptl)
> > > > > > +			return 0;
> > > > > > +
> > > > > > +		if (is_huge_zero_pmd(*pmd))
> > > > > > +			goto huge_unlock;
> > > > > > +
> > > > > > +		page = pmd_page(*pmd);
> > > > > > +		if (page_mapcount(page) > 1)
> > > > > > +			goto huge_unlock;
> > > > > > +
> > > > > > +		if (next - addr != HPAGE_PMD_SIZE) {
> > > > > > +			int err;
> > > > > > +
> > > > > > +			get_page(page);
> > > > > > +			spin_unlock(ptl);
> > > > > > +			lock_page(page);
> > > > > > +			err = split_huge_page(page);
> > > > > > +			unlock_page(page);
> > > > > > +			put_page(page);
> > > > > > +			if (!err)
> > > > > > +				goto regular_page;
> > > > > > +			return 0;
> > > > > > +		}
> > > > > > +
> > > > > > +		pmdp_test_and_clear_young(vma, addr, pmd);
> > > > > > +		deactivate_page(page);
> > > > > > +huge_unlock:
> > > > > > +		spin_unlock(ptl);
> > > > > > +		return 0;
> > > > > > +	}
> > > > > > +
> > > > > > +	if (pmd_trans_unstable(pmd))
> > > > > > +		return 0;
> > > > > > +
> > > > > > +regular_page:
> > > > > > +	orig_pte = pte_offset_map_lock(vma->vm_mm, pmd, addr, &ptl);
> > > > > > +	for (pte = orig_pte; addr < end; pte++, addr += PAGE_SIZE) {
> > > > > > +		ptent = *pte;
> > > > > > +
> > > > > > +		if (pte_none(ptent))
> > > > > > +			continue;
> > > > > > +
> > > > > > +		if (!pte_present(ptent))
> > > > > > +			continue;
> > > > > > +
> > > > > > +		page = vm_normal_page(vma, addr, ptent);
> > > > > > +		if (!page)
> > > > > > +			continue;
> > > > > > +
> > > > > > +		if (page_mapcount(page) > 1)
> > > > > > +			continue;
> > > > > > +
> > > > > > +		ptep_test_and_clear_young(vma, addr, pte);
> > > > > 
> > > > > Wondering here how it interacts with idle page tracking. Here since young
> > > > > flag is cleared by the cold hint, page_referenced_one() or
> > > > > page_idle_clear_pte_refs_one() will not be able to clear the page-idle flag
> > > > > if it was previously set since it does not know any more that a page was
> > > > > actively referenced.
> > > > 
> > > > ptep_test_and_clear_young doesn't change PG_idle/young so idle page tracking
> > > > doesn't affect.
> > 
> > You said *young flag* in the comment, which made me confused. I thought you meant
> > PG_young flag but you mean PTE access bit.
> > 
> > > 
> > > Clearing of the young bit in the PTE does affect idle tracking.
> > > 
> > > Both page_referenced_one() and page_idle_clear_pte_refs_one() check this bit.
> > > 
> > > > > bit was previously set, just so that page-idle tracking works smoothly when
> > > > > this hint is concurrently applied?
> > > > 
> > > > deactivate_page will remove PG_young bit so that the page will be reclaimed.
> > > > Do I miss your point?
> > > 
> > > Say a process had accessed PTE bit not set, then idle tracking is run and PG_Idle
> > > is set. Now the page is accessed from userspace thus setting the accessed PTE
> > > bit.  Now a remote process passes this process_madvise cold hint (I know your
> > > current series does not support remote process, but I am saying for future
> > > when you post this). Because you cleared the PTE accessed bit through the
> > > hint, idle tracking no longer will know that the page is referenced and the
> > > user gets confused because accessed page appears to be idle.
> > 
> > Right.
> > 
> > > 
> > > I think to fix this, what you should do is clear the PG_Idle flag if the
> > > young/accessed PTE bits are set. If PG_Idle is already cleared, then you
> > > don't need to do anything.
> > 
> > I'm not sure. What does it make MADV_COLD special?
> > How about MADV_FREE|MADV_DONTNEED?
> > Why don't they clear PG_Idle if pte was young at tearing down pte? 
> 
> Good point, so it sounds like those (MADV_FREE|MADV_DONTNEED) also need to be fixed then?

Not sure. If you want it, maybe you need to fix every pte clearing and pte_mkold
part, which is more general to cover every sites like munmap, get_user_pages and
so on. Anyway, I don't think it's related to this patchset.

> 
> > The page could be shared by other processes so if we miss to clear out
> > PG_idle in there, page idle tracking could miss the access history forever.
> 
> I did not understand this. So say a page X is shared process P and Q and
> assume the PG_idle flag is set on the page.
> 
> P accesses memory and has the pte accessed bit set. P now gets the MADV_COLD
> hint and forgets to clear the idle flag while clearing the pte accessed bit.
> 
> Now the page appears to be idle, even though it was not. This has nothing to
> do with Q and whether the page is shared or not.

What I meant was MADV_FREE|MADV_DONTNEED.

> 
> > If it's not what you want, maybe we need to fix all places all at once.
> > However, I'm not sure. Rather than, I want to keep PG_idle in those hints
> > even though pte was accesssed because the process now gives strong hint
> > "The page is idle from now on". It's valid because he knows himself better than
> > others, even admin. IOW, he declare the page is not workingset any more.
> 
> Even if the PG_idle flag is not cleared - it is not a strong hint for working
> set size IMHO, because the page *was* accessed so the process definitely needed the
> page at some point even though now it says it is MADV_COLD. So that is part
> of working set. I don't think we should implicitly provide such hints and we
> should fix it.
> 
> Also I was saying in previous email, if process_madvise (future extension) is
> called from say activity manager, then the process and the user running the
> idle tracking feature has no idea that the page was accessed because the idle
> flag is still set. That is a bit weird and is loss of information.
> 
> It may not be a big deal in the long run if the page is accessed a lot, since
> the PTE accessed bit will be set again and idle-tracking feature may not miss
> it, but why leave it to chance if it is a simple fix?

Consistency with other madvise hints.

There are many places you could lose the information as I mentioned and I'm
really not conviced we need fixing because currently page-idle tracking
feature is biased to work with . If you believe we need to fix it,
it would be better to have a separate discussion, not here.

> 
> > What's the problem if page idle tracking feature miss it?
> 
> What's the problem if PG_idle flag is cleared here? It is just a software
> flag.

Again consistency. I don't think it's a MADV_PAGEOUT specific issue.
Since I pointed out other places idle tracking is missing(? not sure),
Let's discuss it separately if you feel we need fix.

Furthermore, once the page is reclaimed, that means the page could be
deallocated so you automatically don't see any PG_idle from the page.

> 
> > If other processs still have access bit of their pte for the page, page idle
> > tracking could find the page as non-idle so it's no problem, either.
> 
> Yes, but if the other process also does not access the page, then the access
> information is lost.
> 
> thanks!
> 
>  - Joel
> 

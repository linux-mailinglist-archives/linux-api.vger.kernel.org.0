Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D28D21DA18
	for <lists+linux-api@lfdr.de>; Mon, 13 Jul 2020 17:32:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729308AbgGMPcp (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 13 Jul 2020 11:32:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:32894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729027AbgGMPcp (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Mon, 13 Jul 2020 11:32:45 -0400
Received: from kernel.org (unknown [87.71.40.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4DDF7206F0;
        Mon, 13 Jul 2020 15:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594654364;
        bh=BA45Q6AEXkFERQL4GWwTgvIF0IN9KuWDZxv/KQt11c8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gVM/ydYDODojWV7K+3vNvNLN+EKvGQkS3Wv873nQ3Y8rb7pos3CJPwsM5S5AzA+Ly
         +r5f0oRFGnA6lPVLS7c0V5NxoIKpRC5qad/DicL/4kl2Rwmze9mgeFjr6B8bwEbwJ2
         kzS1ewxoSnmTO/0xk1ne6SJpwagrdfTaxmlkA1rA=
Date:   Mon, 13 Jul 2020 18:32:34 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     linux-kernel@vger.kernel.org, Alan Cox <alan@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Christopher Lameter <cl@linux.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Idan Yaniv <idan.yaniv@ibm.com>,
        James Bottomley <jejb@linux.ibm.com>,
        Matthew Wilcox <willy@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Reshetova, Elena" <elena.reshetova@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tycho Andersen <tycho@tycho.ws>, linux-api@vger.kernel.org,
        linux-mm@kvack.org, Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: [RFC PATCH v2 4/5] mm: secretmem: use PMD-size pages to amortize
 direct map fragmentation
Message-ID: <20200713153234.GC707159@kernel.org>
References: <20200706172051.19465-1-rppt@kernel.org>
 <20200706172051.19465-5-rppt@kernel.org>
 <20200713110505.mesvinqjbj7imsdz@box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200713110505.mesvinqjbj7imsdz@box>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Jul 13, 2020 at 02:05:05PM +0300, Kirill A. Shutemov wrote:
> On Mon, Jul 06, 2020 at 08:20:50PM +0300, Mike Rapoport wrote:
> > From: Mike Rapoport <rppt@linux.ibm.com>
> > 
> > Removing a PAGE_SIZE page from the direct map every time such page is
> > allocated for a secret memory mapping will cause severe fragmentation of
> > the direct map. This fragmentation can be reduced by using PMD-size pages
> > as a pool for small pages for secret memory mappings.
> > 
> > Add a gen_pool per secretmem inode and lazily populate this pool with
> > PMD-size pages.
> > 
> > Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> > ---
> >  mm/secretmem.c | 107 ++++++++++++++++++++++++++++++++++++++++---------
> >  1 file changed, 88 insertions(+), 19 deletions(-)
> > 
> > diff --git a/mm/secretmem.c b/mm/secretmem.c
> > index df8f8c958cc2..c6fcf6d76951 100644
> > --- a/mm/secretmem.c
> > +++ b/mm/secretmem.c
> > @@ -5,6 +5,7 @@
> >  #include <linux/memfd.h>
> >  #include <linux/printk.h>
> >  #include <linux/pagemap.h>
> > +#include <linux/genalloc.h>
> >  #include <linux/pseudo_fs.h>
> >  #include <linux/set_memory.h>
> >  #include <linux/sched/signal.h>
> > @@ -23,24 +24,66 @@
> >  #define SECRETMEM_UNCACHED	0x2
> >  
> >  struct secretmem_ctx {
> > +	struct gen_pool *pool;
> >  	unsigned int mode;
> >  };
> >  
> > -static struct page *secretmem_alloc_page(gfp_t gfp)
> > +static int secretmem_pool_increase(struct secretmem_ctx *ctx, gfp_t gfp)
> >  {
> > -	/*
> > -	 * FIXME: use a cache of large pages to reduce the direct map
> > -	 * fragmentation
> > -	 */
> > -	return alloc_page(gfp);
> > +	unsigned long nr_pages = (1 << HPAGE_PMD_ORDER);
> > +	struct gen_pool *pool = ctx->pool;
> > +	unsigned long addr;
> > +	struct page *page;
> > +	int err;
> > +
> > +	page = alloc_pages(gfp, HPAGE_PMD_ORDER);
> > +	if (!page)
> > +		return -ENOMEM;
> > +
> > +	addr = (unsigned long)page_address(page);
> > +	split_page(page, HPAGE_PMD_ORDER);
> > +
> > +	err = gen_pool_add(pool, addr, HPAGE_PMD_SIZE, NUMA_NO_NODE);
> > +	if (err) {
> > +		__free_pages(page, HPAGE_PMD_ORDER);
> > +		return err;
> > +	}
> > +
> > +	__kernel_map_pages(page, nr_pages, 0);
> 
> It's worth nothing that unlike flush_tlb_kernel_range(),
> __kernel_map_pages() only flushed local TLB, so other CPU may still have
> access to the page. It's shouldn't be a blocker, but deserve a comment.

Sure.
 
> > +
> > +	return 0;
> > +}
> > +

-- 
Sincerely yours,
Mike.

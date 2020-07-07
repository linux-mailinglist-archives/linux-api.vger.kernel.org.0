Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB4742166AD
	for <lists+linux-api@lfdr.de>; Tue,  7 Jul 2020 08:47:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728211AbgGGGrt (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 7 Jul 2020 02:47:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:38912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725825AbgGGGrt (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Tue, 7 Jul 2020 02:47:49 -0400
Received: from kernel.org (unknown [87.71.40.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B227C20674;
        Tue,  7 Jul 2020 06:47:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594104468;
        bh=BrZtIR1hwOkOoHdXGn9wxjTp5t53vI5UcpP82sif2/Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=n9oqhgML7NeINidunbCuNzMC4nkPUFJTK+zTWLS4wKjrDLNngJj5Zx28lF0Flbc+q
         ks4LMOClE15odkf0Yuu4L7wEahLWdJszHc0CGFCxSW40KRm8MNlSoXu/ZMbJnqNRAW
         BMlisLXXtBM6PEjn9TlP8BagxeYgv0XOOTgqP7/4=
Date:   Tue, 7 Jul 2020 09:47:37 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        linux-kernel@vger.kernel.org, Alan Cox <alan@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Christopher Lameter <cl@linux.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Idan Yaniv <idan.yaniv@ibm.com>,
        James Bottomley <jejb@linux.ibm.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Reshetova, Elena" <elena.reshetova@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tycho Andersen <tycho@tycho.ws>, linux-api@vger.kernel.org,
        linux-mm@kvack.org, Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: [RFC PATCH v2 1/5] mm: make HPAGE_PxD_{SHIFT,MASK,SIZE} always
 available
Message-ID: <20200707064737.GA9449@kernel.org>
References: <20200706172051.19465-1-rppt@kernel.org>
 <20200706172051.19465-2-rppt@kernel.org>
 <alpine.LSU.2.11.2007062153000.2793@eggly.anvils>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.11.2007062153000.2793@eggly.anvils>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hi Hugh,

On Mon, Jul 06, 2020 at 10:07:34PM -0700, Hugh Dickins wrote:
> On Mon, 6 Jul 2020, Mike Rapoport wrote:
> > From: Mike Rapoport <rppt@linux.ibm.com>
> > 
> > The definitions of shift, mask and size for the second and the third level
> > of the leaf pages are available only when CONFIG_TRANSPARENT_HUGEPAGE is
> > set. Otherwise they evaluate to BUILD_BUG().
> > 
> > There is no explanation neither in the code nor in the changelog why the
> > usage of, e.g. HPAGE_PMD_SIZE should be only allowed with THP and forbidden
> > otherwise while the definitions of HPAGE_PMD_SIZE and HPAGE_PUD_SIZE
> > express the sizes better than ambiguous HPAGE_SIZE.
> > 
> > Make HPAGE_PxD_{SHIFT,MASK,SIZE} definitions available unconditionally.
> 
> Adding Andrea to Cc, he's the one who structured it that way,
> and should be consulted.
> 
> I'm ambivalent myself.  Many's the time I've been irritated by the
> BUILD_BUG() in HPAGE_etc, and it's responsible for very many #ifdef
> CONFIG_TRANSPARENT_HUGEPAGEs or IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE)s
> that you find uglily scattered around the source.
> 
> But that's the point of it: it's warning when you write code peculiar
> to THP, that is going to bloat the build of kernels without any THP.
> 
> So although I've often been tempted to do as you suggest, I've always
> ended up respecting Andrea's intention, and worked around it instead
> (sometimes with #ifdef or IS_ENABLED(), sometimes with
> PMD_{SHIFT,MASK_SIZE}, sometimes with a local definition).

I could do with a local definition as well, but I think HPAGE_PxD_SHIFT
is better and more descriptive than ambiguous HPAGE_SHIFT and I was
thinking about wider change to use "THP" defines rather than "hugetlb"
defines wherever possible. 

In the end, HPAGE_PMD_SIZE does not have to be associated with THP and
limited to it, it just says what is the size of a leaf page at PMD
level.

> Hugh
> 
> > 
> > Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> > ---
> >  include/linux/huge_mm.h | 10 ++--------
> >  1 file changed, 2 insertions(+), 8 deletions(-)
> > 
> > diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> > index 71f20776b06c..1f4b44a76e31 100644
> > --- a/include/linux/huge_mm.h
> > +++ b/include/linux/huge_mm.h
> > @@ -115,7 +115,6 @@ extern struct kobj_attribute shmem_enabled_attr;
> >  #define HPAGE_PMD_ORDER (HPAGE_PMD_SHIFT-PAGE_SHIFT)
> >  #define HPAGE_PMD_NR (1<<HPAGE_PMD_ORDER)
> >  
> > -#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> >  #define HPAGE_PMD_SHIFT PMD_SHIFT
> >  #define HPAGE_PMD_SIZE	((1UL) << HPAGE_PMD_SHIFT)
> >  #define HPAGE_PMD_MASK	(~(HPAGE_PMD_SIZE - 1))
> > @@ -124,6 +123,8 @@ extern struct kobj_attribute shmem_enabled_attr;
> >  #define HPAGE_PUD_SIZE	((1UL) << HPAGE_PUD_SHIFT)
> >  #define HPAGE_PUD_MASK	(~(HPAGE_PUD_SIZE - 1))
> >  
> > +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> > +
> >  extern unsigned long transparent_hugepage_flags;
> >  
> >  /*
> > @@ -316,13 +317,6 @@ static inline struct list_head *page_deferred_list(struct page *page)
> >  }
> >  
> >  #else /* CONFIG_TRANSPARENT_HUGEPAGE */
> > -#define HPAGE_PMD_SHIFT ({ BUILD_BUG(); 0; })
> > -#define HPAGE_PMD_MASK ({ BUILD_BUG(); 0; })
> > -#define HPAGE_PMD_SIZE ({ BUILD_BUG(); 0; })
> > -
> > -#define HPAGE_PUD_SHIFT ({ BUILD_BUG(); 0; })
> > -#define HPAGE_PUD_MASK ({ BUILD_BUG(); 0; })
> > -#define HPAGE_PUD_SIZE ({ BUILD_BUG(); 0; })
> >  
> >  static inline int hpage_nr_pages(struct page *page)
> >  {
> > -- 
> > 2.26.2

-- 
Sincerely yours,
Mike.

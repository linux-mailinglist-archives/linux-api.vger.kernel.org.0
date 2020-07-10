Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EB9C21BBAE
	for <lists+linux-api@lfdr.de>; Fri, 10 Jul 2020 18:58:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727978AbgGJQ5x (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 10 Jul 2020 12:57:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727097AbgGJQ5x (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 10 Jul 2020 12:57:53 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 305A2C08C5DC;
        Fri, 10 Jul 2020 09:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=REVCDakwgDG+DYRws7LZzQi4QLzZc//D1GvkmuJe/WI=; b=dgVJrxlUyxMQ21th+aRn2MrSte
        FdbzjRbZu8cLN84tlxqHdpFUtzI8O95wTMXQ/rcd+AaWG72Fv2A7dITBe7ZOMYqOkJkP5Wl2RDVQI
        PrmqKB+qfPCs2PhwcxeQZndW25BDLWlRghD4B9Re6xZnguBBMY+GfbMomE2r+5y9IDCsfAeIH/DmH
        C9EnZqB7WqxgWix+ggL/mp49WUS29EzpgQePI53Ku3ta6GNOlTwRLtiwQ46aA8MwI0KaYXr5V8FDZ
        QO3Rc9Rco4kbnB4D8KC0p+ua5rvu7TpfJ+SFN8HchKD8BAzsrCCyjPu/Ro1bimWM5UAQlpTmOh6dY
        AZQhWk4A==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jtwLK-0005Nl-8U; Fri, 10 Jul 2020 16:57:46 +0000
Date:   Fri, 10 Jul 2020 17:57:46 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Andrea Arcangeli <aarcange@redhat.com>
Cc:     Hugh Dickins <hughd@google.com>, Mike Rapoport <rppt@kernel.org>,
        linux-kernel@vger.kernel.org, Alan Cox <alan@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Christopher Lameter <cl@linux.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Idan Yaniv <idan.yaniv@ibm.com>,
        James Bottomley <jejb@linux.ibm.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Peter Zijlstra <peterz@infradead.org>,
        "Reshetova, Elena" <elena.reshetova@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tycho Andersen <tycho@tycho.ws>, linux-api@vger.kernel.org,
        linux-mm@kvack.org, Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: [RFC PATCH v2 1/5] mm: make HPAGE_PxD_{SHIFT,MASK,SIZE} always
 available
Message-ID: <20200710165746.GO12769@casper.infradead.org>
References: <20200706172051.19465-1-rppt@kernel.org>
 <20200706172051.19465-2-rppt@kernel.org>
 <alpine.LSU.2.11.2007062153000.2793@eggly.anvils>
 <20200710164037.GA11749@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200710164037.GA11749@redhat.com>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, Jul 10, 2020 at 12:40:37PM -0400, Andrea Arcangeli wrote:
> Hello Hugh and Mike,
> 
> On Mon, Jul 06, 2020 at 10:07:34PM -0700, Hugh Dickins wrote:
> > Adding Andrea to Cc, he's the one who structured it that way,
> > and should be consulted.
> >
> > I'm ambivalent myself.  Many's the time I've been irritated by the
> > BUILD_BUG() in HPAGE_etc, and it's responsible for very many #ifdef
> > CONFIG_TRANSPARENT_HUGEPAGEs or IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE)s
> > that you find uglily scattered around the source.
> > 
> > But that's the point of it: it's warning when you write code peculiar
> > to THP, that is going to bloat the build of kernels without any THP.
> > 
> > So although I've often been tempted to do as you suggest, I've always
> > ended up respecting Andrea's intention, and worked around it instead
> > (sometimes with #ifdef or IS_ENABLED(), sometimes with
> > PMD_{SHIFT,MASK_SIZE}, sometimes with a local definition).
> 
> The only other reasons that comes to mind in addition of optimizing
> the bloat away at build time is to make it easier to identify the THP
> code and to make it explicit that hugetlbfs shouldn't us it or it
> could be wrong on some arches.
> 
> However for this case the BUILD_BUG() looks right and this doesn't
> look like a false positive.
> 
> This patchset has nothing to do THP, so it'd be more correct to use
> MAX_ORDER whenever the fragmentation is about the buddy (doesn't look
> the case here) or PUD_SIZE/ORDER/PMD_SIZE/ORDER if the objective is
> not to unnecessarily split extra and unrelated hugepud/hugepmds in the
> direct mapping (as in this case).
> 
> The real issue exposed by the BUILD_BUG is the lack of PMD_ORDER
> definition and fs/dax.c already run into and it solved it locally in the
> dax.c file:
> 
> /* The order of a PMD entry */
> #define PMD_ORDER	(PMD_SHIFT - PAGE_SHIFT)
> 
> The fact it's not just this patch but also dax.c that run into the
> same issue, makes me think PMD_ORDER should be defined and then you
> can use PMD_* and PUD_* for this non-THP purpose.

We'll run into some namespace issues.

arch/arm/kernel/head.S:#define PMD_ORDER        3
arch/arm/kernel/head.S:#define PMD_ORDER        2
arch/mips/include/asm/pgtable-32.h:#define PMD_ORDER    aieeee_attempt_to_allocate_pmd
arch/mips/include/asm/pgtable-64.h:#define PMD_ORDER            0
arch/parisc/include/asm/pgtable.h:#define PMD_ORDER     1 /* Number of pages per pmd */

> Then the question if to remove the BUILD_BUG becomes orthogonal to
> this patchset, but I don't see much value in retaining HPAGE_PMD/PUD_*
> unless the BUILD_BUG is retained too, because this patchset already
> hints that without the BUILD_BUG() the HPAGE_PMD_* definitions would
> likely spill into non THP paths and they would lose also the only
> value left (the ability to localize the THP code paths). So I wouldn't
> be against removing the BUILD_BUG if it's causing maintenance
> overhead, but then I would drop HPAGE_PMD_* too along with it or it
> may just cause confusion.

btw, using the hpage_ prefix already caused one problem in the hugetlb
code:

https://lore.kernel.org/linux-mm/20200629185003.97202-1-mike.kravetz@oracle.com/

I'd suggest we rename these to THP_PMD_* and THP_PUD_* to make it clear
they're only for the THP case.

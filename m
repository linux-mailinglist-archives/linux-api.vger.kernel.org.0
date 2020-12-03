Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3367A2CDCEC
	for <lists+linux-api@lfdr.de>; Thu,  3 Dec 2020 19:01:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728062AbgLCSA5 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 3 Dec 2020 13:00:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727114AbgLCSA5 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 3 Dec 2020 13:00:57 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDC0BC061A4E;
        Thu,  3 Dec 2020 10:00:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=v0fH8XZPcBILHBvdRGB4xJ6ySGXdUUUfSXTYA6BIYHw=; b=k0eFW5peSYZQ+XNv/IBrFFIAE/
        Z9NeOHb1oP3UjOgoP7cv/xLz8ZEAuFxQUGHhWHU2fLVFrY8WXO36eX3sgloBPmUCay5x2+N2jk3lM
        mVaFu8t1AQRymvOtoPxSaimEJjJEk0V07XfjDbveoWenkVeoYeNowDoOZemFoiazroyTJWqH2+GIn
        rDLuQvt+xoYbywyauXqx61nReQJvLQSHqItfpx2IpykqemvMOhfZRjg50AlW0GnLG6+QrxpOX4e2z
        dTbPUEmjCIO8OsKRN44RKRWoBOcqdJ/536YitsM7xqniXabqivyTUYezUrGKIFN13/mqew2v4E03F
        L4jem1VA==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kkstl-0003N8-To; Thu, 03 Dec 2020 18:00:10 +0000
Date:   Thu, 3 Dec 2020 18:00:09 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Florian Weimer <fweimer@redhat.com>,
        Topi Miettinen <toiwoton@gmail.com>,
        linux-hardening@vger.kernel.org, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Mike Rapoport <rppt@kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: [PATCH v5] mm: Optional full ASLR for mmap(), mremap(), vdso and
 stack
Message-ID: <20201203180009.GJ11935@casper.infradead.org>
References: <871rg6yf1i.fsf@oldenburg2.str.redhat.com>
 <1CB9B4D1-1E32-42DC-A4E9-6E53C85365BF@amacapital.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1CB9B4D1-1E32-42DC-A4E9-6E53C85365BF@amacapital.net>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, Dec 03, 2020 at 09:42:54AM -0800, Andy Lutomirski wrote:
> I suspect that something much more clever could be done in which the heap is divided up into a few independently randomized sections and heap pages are randomized within the sections might do much better. There should certainly be a lot of room for something between what we have now and a fully randomized scheme.
> 
> It might also be worth looking at what other OSes do.

How about dividing the address space up into 1GB sections (or, rather,
PUD_SIZE sections), allocating from each one until it's 50% full, then
choose another one?  Sufficiently large allocations would ignore this
division and just look for any space.  I'm thinking something like the
slab allocator (so the 1GB chunk would go back into the allocatable list
when >50% of it was empty).

That might strike a happy medium between full randomisation and efficient
use of page tables / leaving large chunks of address space free for
large mmaps.

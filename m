Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A64563B6961
	for <lists+linux-api@lfdr.de>; Mon, 28 Jun 2021 21:58:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237174AbhF1UAy (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 28 Jun 2021 16:00:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235853AbhF1UAx (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 28 Jun 2021 16:00:53 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9045CC061760;
        Mon, 28 Jun 2021 12:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5mZU8eaHkGitYCk/uZMPD+d5aeydTQi9vAR1U5mhi2k=; b=JrcRDsZNk4S8DYa8U89O3uL3ow
        Q88duty2KLVv6mkMEFl9D1zPR80VMuiQ76pZ8TP+slMia26pg35s4DQfpEfCfncCEYRp0x4maO2R5
        KPrkT75um9OgbJVCseuy3veg4wpnacFOfBKuZhL3rjEIP05lsywUgFRxAqED+2PXTYsodmdsa/RMw
        jWAOT+W+bC8t5eyHO0QAKKf5y5jAcmNK0lJSSu1g6lAlf+RGUTi2dQaBH3iQmEmlApFlK86s3jrww
        XCv5HEvse8L1tw8UiCoUrJpeknbwVD6sJ0qnkyIRG9U7feuuY/duFoijNSNWZH+ThmBTSPaowFqGs
        5BgVeHbQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lxxMh-003OEh-S6; Mon, 28 Jun 2021 19:56:50 +0000
Date:   Mon, 28 Jun 2021 20:56:19 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Peter Collingbourne <pcc@google.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Jann Horn <jannh@google.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-mm@kvack.org, kernel test robot <lkp@intel.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH v4] mm: introduce reference pages
Message-ID: <YNopY7n+DcEnLxn7@casper.infradead.org>
References: <20210619092002.1791322-1-pcc@google.com>
 <YNokDwjyysHGwTy/@casper.infradead.org>
 <6c03ae36-9a4b-6646-66c3-04d4a3de9c1e@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6c03ae36-9a4b-6646-66c3-04d4a3de9c1e@nvidia.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Jun 28, 2021 at 12:44:22PM -0700, John Hubbard wrote:
> On 6/28/21 12:33 PM, Matthew Wilcox wrote:
> ...
> > 
> > I wonder if single-byte captures enough of the useful possibilities.
> > In the kernel we have memset32() and memset64() [1] so we could support
> > a larger pattern than just an 8-bit byte.  It all depends what userspace
> > would find useful.
> > 
> > [1] Along with memset_p(), memset_l() and memset16() that aren't terribly
> > relevant to this use case.  Although maybe memset_l() would be the right
> > one to use since there probably aren't too many 32-bit apps that want
> > a 64-bit pattern and memset64() might not be the fastest on a 32-bit
> > kernel).
> > 
> 
> And in fact, I'm also rather intrigued by doing something like 256 copies
> of a 16-byte UUID, per 4KB page. In other words, there are *definitely*
> useful patterns that are longer than a single byte, and it seems interesting
> to support them here.
> 
> Kirill's idea of an API that somehow allows various power of 2 patterns seems
> like it would be nice, because then we don't have to pick a value that seems
> good in 2021, but less good as time goes by, perhaps.
> 
> Another thought is to use an entire 4KB page as the smallest pattern unit.
> That would allow the maximum API flexibility, because the caller could
> explicitly set every single byte in the page.

That's what this patch does.  If it can be reduced to a pattern (in
Peter's patch of a single byte; i'm proposing expanding that), then
the page is filled with the pattern; otherwise we copy the reference
page.

Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EF082E0B08
	for <lists+linux-api@lfdr.de>; Tue, 22 Dec 2020 14:45:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727091AbgLVNph (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 22 Dec 2020 08:45:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727062AbgLVNph (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 22 Dec 2020 08:45:37 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 423A5C0613D3;
        Tue, 22 Dec 2020 05:44:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=eXSyGreQyqo1MSmMoq/qMuV3OWCVLUj1olxIkYhTkl0=; b=Ix8mJC38mYvh+lNbE2zOg73S2V
        aW8+bJnapCtY5yvKkPflK2jIdDa2nZaR3ghWYIzq0sfRZ02qOCAZfEHG/mQxOfcyk+/5GLm05CZQ9
        1//PIsYFfsPOM9YnsFc0MK/+cW401LKBSC2npcgsbbVx1H8rIZUUCGQvsW/j3gF48T2Ea/CWgFu1O
        I9Naeba9H0I76TnpqQ+UlimvfzMahfalNYx17Dgwpb1XFwQw7Ul9big6pvyPf8LViAJOc/g7sy+8P
        nJ0DkW1OpNbL/pl3rC86J8zT2uhv7RCpK+zUzX7Ig0Fjcsl47jE82uuldUA8ToZjHCcGMET5UW5we
        NmGAkx3g==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1krhxu-0002DJ-GS; Tue, 22 Dec 2020 13:44:38 +0000
Date:   Tue, 22 Dec 2020 13:44:38 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Jann Horn <jannh@google.com>
Cc:     Minchan Kim <minchan@kernel.org>, Christoph Hellwig <hch@lst.de>,
        Suren Baghdasaryan <surenb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, Rik van Riel <riel@surriel.com>,
        Christian Brauner <christian@brauner.io>,
        Oleg Nesterov <oleg@redhat.com>,
        Tim Murray <timmurray@google.com>,
        Linux API <linux-api@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@android.com>
Subject: Re: [PATCH 1/2] mm/madvise: allow process_madvise operations on
 entire memory range
Message-ID: <20201222134438.GA7170@infradead.org>
References: <20201124053943.1684874-1-surenb@google.com>
 <20201124053943.1684874-2-surenb@google.com>
 <20201125231322.GF1484898@google.com>
 <CAG48ez0UKYCdgyW91SmOcT52vbLFz9RjLpaucWpj6bTrgQCwnA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez0UKYCdgyW91SmOcT52vbLFz9RjLpaucWpj6bTrgQCwnA@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, Dec 11, 2020 at 09:27:46PM +0100, Jann Horn wrote:
> > Can we just use one element in iovec to indicate entire address rather
> > than using up the reserved flags?
> >
> >         struct iovec {
> >                 .iov_base = NULL,
> >                 .iov_len = (~(size_t)0),
> >         };
> 
> In addition to Suren's objections, I think it's also worth considering
> how this looks in terms of compat API. If a compat process does
> process_madvise() on another compat process, it would be specifying
> the maximum 32-bit number, rather than the maximum 64-bit number, so
> you'd need special code to catch that case, which would be ugly.
> 
> And when a compat process uses this API on a non-compat process, it
> semantically gets really weird: The actual address range covered would
> be larger than the address range specified.
> 
> And if we want different access checks for the two flavors in the
> future, gating that different behavior on special values in the iovec
> would feel too magical to me.
> 
> And the length value SIZE_MAX doesn't really make sense anyway because
> the length of the whole address space would be SIZE_MAX+1, which you
> can't express.
> 
> So I'm in favor of a new flag, and strongly against using SIZE_MAX as
> a magic number here.

Yes, using SIZE_MAX is a horrible interface in this case.  I'm not
a huge fan of a flag either.  What is the use case for the madvise
to all of a processes address space anyway?

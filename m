Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C97C14D8B5
	for <lists+linux-api@lfdr.de>; Thu, 30 Jan 2020 11:12:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726932AbgA3KMO (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 30 Jan 2020 05:12:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:52546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726873AbgA3KMO (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 30 Jan 2020 05:12:14 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B091B206D5;
        Thu, 30 Jan 2020 10:12:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580379133;
        bh=P9h3/Bn/eSdl3ZWgp0VveGQkiQrefKB9XBTyKjeDoOU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UGpunH0fs3194+uliHqPn4YZ2qcxfggN5Fnih63Cr4LzINmDuXU5FKyXBHbI2h58v
         XKQqlp5J9a2fMtK23kis7NWl7LHYOrVRsZG8MDuDaQAxM1CdiUR7H2sVdsEK2VtnYM
         jTIWHwaFeUXyLoM2qZHNgBruUVDtYHwedNjFfpSo=
Date:   Thu, 30 Jan 2020 10:12:07 +0000
From:   Will Deacon <will@kernel.org>
To:     Brian Geffon <bgeffon@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-api@vger.kernel.org,
        Andy Lutomirski <luto@amacapital.net>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Sonny Rao <sonnyrao@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Yu Zhao <yuzhao@google.com>,
        Jesse Barnes <jsbarnes@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: Re: [PATCH v3] mm: Add MREMAP_DONTUNMAP to mremap().
Message-ID: <20200130101207.GB1532@willie-the-truck>
References: <20200123014627.71720-1-bgeffon@google.com>
 <20200127053056.213679-1-bgeffon@google.com>
 <20200128152641.GA29776@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200128152641.GA29776@willie-the-truck>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, Jan 28, 2020 at 03:26:41PM +0000, Will Deacon wrote:
> On Sun, Jan 26, 2020 at 09:30:56PM -0800, Brian Geffon wrote:
> > When remapping an anonymous, private mapping, if MREMAP_DONTUNMAP is
> > set, the source mapping will not be removed. Instead it will be
> > cleared as if a brand new anonymous, private mapping had been created
> > atomically as part of the mremap() call.  If a userfaultfd was watching
> > the source, it will continue to watch the new mapping.  For a mapping
> > that is shared or not anonymous, MREMAP_DONTUNMAP will cause the
> > mremap() call to fail. MREMAP_DONTUNMAP requires that MREMAP_FIXED is
> > also used. The final result is two equally sized VMAs where the
> > destination contains the PTEs of the source.
> >    
> > We hope to use this in Chrome OS where with userfaultfd we could write
> > an anonymous mapping to disk without having to STOP the process or worry
> > about VMA permission changes.
> >    
> > This feature also has a use case in Android, Lokesh Gidra has said
> > that "As part of using userfaultfd for GC, We'll have to move the physical
> > pages of the java heap to a separate location. For this purpose mremap
> > will be used. Without the MREMAP_DONTUNMAP flag, when I mremap the java
> > heap, its virtual mapping will be removed as well. Therefore, we'll
> > require performing mmap immediately after. This is not only time consuming
> > but also opens a time window where a native thread may call mmap and
> > reserve the java heap's address range for its own usage. This flag
> > solves the problem."
> 
> Hmm, this sounds like you're dealing with a multi-threaded environment,
> yet your change only supports private mappings. How does that work?

Sorry, this was badly worded. I was trying to understand how the GC is
implememented, and whether everything was part of the same process or if
things like memfds or something else were being used to share memory. Having
spoken to Brian off-list, it's all one process...

> It's also worrying because, with two private mappings of the same anonymous
> memory live simultaneously, you run the risk of hitting D-cache aliasing
> issues on some architectures and losing coherency between them as a result
> (even in a single-threaded scenario). Is userspace just supposed to deal
> with this, or should we be enforcing SHMLBA alignment?

... and this was me completely misreading the patch. The old mapping is
still torn down, but then replaced with a new private mapping rather than
being unmapped.

However, looks like there are some issues handling shared mappings with
this patch (and possibly mlock()?), so I'll wait for a new spin.

Will

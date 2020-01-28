Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B83C14BCC9
	for <lists+linux-api@lfdr.de>; Tue, 28 Jan 2020 16:26:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726318AbgA1P0t (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 28 Jan 2020 10:26:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:34362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726141AbgA1P0t (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Tue, 28 Jan 2020 10:26:49 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B4087207FD;
        Tue, 28 Jan 2020 15:26:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580225208;
        bh=dj+J/+PtbTGjVK/oHj202CDxS9GCGCuwxkfK9zJalX8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OHv6vMz+yD5U8x6jcim8pbmwQnkrN4uZpX7DzpHQsMWV60vUZW+5b6hLCopr+YzlV
         m58G8lzyFU8S/neJVArtj7ee0qKQp3rxEnBv8B767ntyNTp9k+KoplSvW6qGdVbECq
         lE7l0SpLW/1wIyvzaUMpqwNlQSy8Oc2/OTqCeXKc=
Date:   Tue, 28 Jan 2020 15:26:42 +0000
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
Message-ID: <20200128152641.GA29776@willie-the-truck>
References: <20200123014627.71720-1-bgeffon@google.com>
 <20200127053056.213679-1-bgeffon@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200127053056.213679-1-bgeffon@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hi Brian,

On Sun, Jan 26, 2020 at 09:30:56PM -0800, Brian Geffon wrote:
> When remapping an anonymous, private mapping, if MREMAP_DONTUNMAP is
> set, the source mapping will not be removed. Instead it will be
> cleared as if a brand new anonymous, private mapping had been created
> atomically as part of the mremap() call.  If a userfaultfd was watching
> the source, it will continue to watch the new mapping.  For a mapping
> that is shared or not anonymous, MREMAP_DONTUNMAP will cause the
> mremap() call to fail. MREMAP_DONTUNMAP requires that MREMAP_FIXED is
> also used. The final result is two equally sized VMAs where the
> destination contains the PTEs of the source.
>    
> We hope to use this in Chrome OS where with userfaultfd we could write
> an anonymous mapping to disk without having to STOP the process or worry
> about VMA permission changes.
>    
> This feature also has a use case in Android, Lokesh Gidra has said
> that "As part of using userfaultfd for GC, We'll have to move the physical
> pages of the java heap to a separate location. For this purpose mremap
> will be used. Without the MREMAP_DONTUNMAP flag, when I mremap the java
> heap, its virtual mapping will be removed as well. Therefore, we'll
> require performing mmap immediately after. This is not only time consuming
> but also opens a time window where a native thread may call mmap and
> reserve the java heap's address range for its own usage. This flag
> solves the problem."

Hmm, this sounds like you're dealing with a multi-threaded environment,
yet your change only supports private mappings. How does that work?

It's also worrying because, with two private mappings of the same anonymous
memory live simultaneously, you run the risk of hitting D-cache aliasing
issues on some architectures and losing coherency between them as a result
(even in a single-threaded scenario). Is userspace just supposed to deal
with this, or should we be enforcing SHMLBA alignment?
 
> Signed-off-by: Brian Geffon <bgeffon@google.com>
> ---
>  include/uapi/linux/mman.h |  5 +++--
>  mm/mremap.c               | 38 +++++++++++++++++++++++++++++++-------
>  2 files changed, 34 insertions(+), 9 deletions(-)

Could you also a include a patch to update the mremap man page, please?

https://www.kernel.org/doc/man-pages/patches.html

Cheers,

Will

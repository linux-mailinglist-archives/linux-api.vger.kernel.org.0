Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D01834F82A
	for <lists+linux-api@lfdr.de>; Wed, 31 Mar 2021 06:58:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232805AbhCaE6Z (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 31 Mar 2021 00:58:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:36854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233629AbhCaE6O (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 31 Mar 2021 00:58:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3DDA9619A7;
        Wed, 31 Mar 2021 04:58:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1617166694;
        bh=VhCpg0xlH18pm/noVi2wXAxhaSDrNM3aiNwLKbXRn+A=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Qyrk4NMX/7nDvQunY6zl8jh+ldeIm7BbDUrydK7jaAEyAPu78pi/z8ucykMlsskIL
         2s22nIYASSEr4vVyrFNnYE6hoBbU7a6xa30e7b+3y4dWa1x3jgUHy4ZBXLBbk8tyiV
         1LRUNvB7VwVwtq5fPl8KYdMOv9qPvfYFfEGBqPBo=
Date:   Tue, 30 Mar 2021 21:58:12 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, Chris Zankel <chris@zankel.net>,
        Dave Hansen <dave.hansen@intel.com>,
        Helge Deller <deller@gmx.de>, Hugh Dickins <hughd@google.com>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Jann Horn <jannh@google.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Linux API <linux-api@vger.kernel.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Matt Turner <mattst88@gmail.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Minchan Kim <minchan@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        Peter Xu <peterx@redhat.com>, Ram Pai <linuxram@us.ibm.com>,
        Richard Henderson <rth@twiddle.net>,
        Rik van Riel <riel@surriel.com>,
        Rolf Eike Beer <eike-kernel@sf-tec.de>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v1 0/5] mm/madvise: introduce MADV_POPULATE_(READ|WRITE)
 to prefault/prealloc memory
Message-Id: <20210330215812.5279462ba693833680384b1b@linux-foundation.org>
In-Reply-To: <af5555cf-d112-44fd-e030-bfe8f89c8ddc@redhat.com>
References: <20210317110644.25343-1-david@redhat.com>
        <af5555cf-d112-44fd-e030-bfe8f89c8ddc@redhat.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, 30 Mar 2021 10:58:43 +0200 David Hildenbrand <david@redhat.com> wrote:

> > 
> >   MAINTAINERS                                |   1 +
> >   arch/alpha/include/uapi/asm/mman.h         |   3 +
> >   arch/mips/include/uapi/asm/mman.h          |   3 +
> >   arch/parisc/include/uapi/asm/mman.h        |   3 +
> >   arch/xtensa/include/uapi/asm/mman.h        |   3 +
> >   include/uapi/asm-generic/mman-common.h     |   3 +
> >   mm/gup.c                                   |  54 ++++
> >   mm/internal.h                              |   5 +-
> >   mm/madvise.c                               |  69 +++++
> >   tools/testing/selftests/vm/.gitignore      |   3 +
> >   tools/testing/selftests/vm/Makefile        |   1 +
> >   tools/testing/selftests/vm/madv_populate.c | 342 +++++++++++++++++++++
> >   tools/testing/selftests/vm/run_vmtests.sh  |  16 +
> >   13 files changed, 505 insertions(+), 1 deletion(-)
> >   create mode 100644 tools/testing/selftests/vm/madv_populate.c
> > 
> 
> Gentle ping.

Ping who ;)

I was hoping for more review activity.  Were no changes expected from
the [2/5] discussion with Jann?


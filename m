Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 109D9379BCA
	for <lists+linux-api@lfdr.de>; Tue, 11 May 2021 02:59:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbhEKBAU (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 10 May 2021 21:00:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:33888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229628AbhEKBAT (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Mon, 10 May 2021 21:00:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3894661606;
        Tue, 11 May 2021 00:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1620694754;
        bh=jdOdclzw/y2dZw68vYzUkSZPl8203GmwimxVt6tXmag=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=iAjiIyLpw1ECQkl+9LO3Qp7jqwgTPs14hv5T+Yv9DdTE+g6yBMA9jodqkIeGTD5Fu
         ow/BF9JkAg2ZKAT1VoR+WRMcxZVgzjnRfBFlrHPckFREdnqVnTLNlIuEXrbFclf3W7
         iSCwpkQEFGfw772uTfeeVHSe7CB2Z90qLlQXF5T8=
Date:   Mon, 10 May 2021 17:59:12 -0700
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
Subject: Re: [PATCH v2 0/5] mm/madvise: introduce MADV_POPULATE_(READ|WRITE)
 to prefault page tables
Message-Id: <20210510175912.50a1c27b281982cc3d5b6c8c@linux-foundation.org>
In-Reply-To: <79bb75e1-4ee9-5fe2-e495-577518956e1f@redhat.com>
References: <20210419135443.12822-1-david@redhat.com>
        <20210509212105.d741b7026ca6dca86bdb56d2@linux-foundation.org>
        <79bb75e1-4ee9-5fe2-e495-577518956e1f@redhat.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, 10 May 2021 16:52:33 +0200 David Hildenbrand <david@redhat.com> wrote:

> I can just resend the series, thoughts?

Sure, that makes it easier on folks.

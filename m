Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 679733E879C
	for <lists+linux-api@lfdr.de>; Wed, 11 Aug 2021 03:21:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbhHKBWT (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 10 Aug 2021 21:22:19 -0400
Received: from mga03.intel.com ([134.134.136.65]:57421 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229458AbhHKBWT (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Tue, 10 Aug 2021 21:22:19 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10072"; a="215055623"
X-IronPort-AV: E=Sophos;i="5.84,311,1620716400"; 
   d="scan'208";a="215055623"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2021 18:21:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,311,1620716400"; 
   d="scan'208";a="516260061"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.146.151])
  by FMSMGA003.fm.intel.com with ESMTP; 10 Aug 2021 18:21:50 -0700
Date:   Wed, 11 Aug 2021 09:21:49 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     aarcange@redhat.com, ak@linux.intel.com, akpm@linux-foundation.org,
        ben.widawsky@intel.com, dan.j.williams@intel.com,
        dave.hansen@intel.com, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        mgorman@techsingularity.net, mhocko@suse.com,
        mike.kravetz@oracle.com, rdunlap@infradead.org,
        rientjes@google.com, vbabka@suse.cz, ying.huang@intel.com
Subject: Re: [PATCH] mm/hugetlb: Initialize page to NULL in
 alloc_buddy_huge_page_with_mpol()
Message-ID: <20210811012149.GA2474@shbuild999.sh.intel.com>
References: <20210809024430.GA46432@shbuild999.sh.intel.com>
 <20210810200632.3812797-1-nathan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210810200632.3812797-1-nathan@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, Aug 10, 2021 at 01:06:32PM -0700, Nathan Chancellor wrote:
> Clang warns:
> 
> mm/hugetlb.c:2162:6: warning: variable 'page' is used uninitialized
> whenever 'if' condition is false [-Wsometimes-uninitialized]
>         if (mpol_is_preferred_many(mpol)) {
>             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
> mm/hugetlb.c:2172:7: note: uninitialized use occurs here
>         if (!page)
>              ^~~~
> mm/hugetlb.c:2162:2: note: remove the 'if' if its condition is always
> true
>         if (mpol_is_preferred_many(mpol)) {
>         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> mm/hugetlb.c:2155:19: note: initialize the variable 'page' to silence
> this warning
>         struct page *page;
>                          ^
>                           = NULL
> 1 warning generated.
> 
> Initialize page to NULL like in dequeue_huge_page_vma() so that page is
> not used uninitialized.
> 
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

Thanks for the catch!

In my original patch, I initialized it in one function, but overlooked
this one.

Thanks,
Feng

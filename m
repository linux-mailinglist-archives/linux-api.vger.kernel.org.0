Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C6813C95D1
	for <lists+linux-api@lfdr.de>; Thu, 15 Jul 2021 04:13:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231196AbhGOCQD (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 14 Jul 2021 22:16:03 -0400
Received: from mga12.intel.com ([192.55.52.136]:33170 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231165AbhGOCQD (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 14 Jul 2021 22:16:03 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10045"; a="190141585"
X-IronPort-AV: E=Sophos;i="5.84,240,1620716400"; 
   d="scan'208";a="190141585"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2021 19:13:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,240,1620716400"; 
   d="scan'208";a="460200285"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.146.151])
  by orsmga008.jf.intel.com with ESMTP; 14 Jul 2021 19:13:04 -0700
Date:   Thu, 15 Jul 2021 10:13:03 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, Michal Hocko <mhocko@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andi Kleen <ak@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>, ying.huang@intel.com
Subject: Re: [PATCH v6 0/6] Introduce multi-preference mempolicy
Message-ID: <20210715021303.GA66164@shbuild999.sh.intel.com>
References: <1626077374-81682-1-git-send-email-feng.tang@intel.com>
 <20210714171540.7cb9e221d683b531928b71f5@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210714171540.7cb9e221d683b531928b71f5@linux-foundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hi Andrew,

Thanks for reviewing!

On Wed, Jul 14, 2021 at 05:15:40PM -0700, Andrew Morton wrote:
> On Mon, 12 Jul 2021 16:09:28 +0800 Feng Tang <feng.tang@intel.com> wrote:
> 
> > This patch series introduces the concept of the MPOL_PREFERRED_MANY mempolicy.
> > This mempolicy mode can be used with either the set_mempolicy(2) or mbind(2)
> > interfaces. Like the MPOL_PREFERRED interface, it allows an application to set a
> > preference for nodes which will fulfil memory allocation requests. Unlike the
> > MPOL_PREFERRED mode, it takes a set of nodes. Like the MPOL_BIND interface, it
> > works over a set of nodes. Unlike MPOL_BIND, it will not cause a SIGSEGV or
> > invoke the OOM killer if those preferred nodes are not available.
> 
> Do we have any real-world testing which demonstrates the benefits of
> all of this?

We have done some internal tests, and are actively working with some external
customer on using this new 'prefer-many' policy, as they have different
types of memory (fast DRAM and slower Persistent memory) in system, and their
program wants to set clear preference for several NUMA nodes, to better deploy
the huge application data before running the application. 

We have met another issue that customer wanted to run a docker container
while binding it to 2 persistent memory nodes, which always failed. At that
time we tried 2 hack pachtes to solve it.
https://lore.kernel.org/lkml/1604470210-124827-2-git-send-email-feng.tang@intel.com/
https://lore.kernel.org/lkml/1604470210-124827-3-git-send-email-feng.tang@intel.com/
And that use case can be easily achieved with this new policy.

Thanks,
Feng

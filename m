Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27EAC3DD4E6
	for <lists+linux-api@lfdr.de>; Mon,  2 Aug 2021 13:47:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233417AbhHBLr4 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 2 Aug 2021 07:47:56 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:39764 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233341AbhHBLrz (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 2 Aug 2021 07:47:55 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 8762421F7F;
        Mon,  2 Aug 2021 11:47:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1627904865; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QWopW0m9K8AWj/OiL96azoTpX66uDgwhw6iV3G8pRMI=;
        b=r+CfTwu9CFts6SMMQ1munull3pg2dYUu7aNtRA3C9vQy/xWMvgj+YKoCzD+ZYQbRUSeqDk
        s6o/vWtfO7UBdrAiyyUI/sty55tTEEqHj7s0gxQvCqF7HAYBTsU/Eu//J2wAKLaS68JJCd
        SqcOiKXHXsYrlaQLKvQ+fajOkbCy4dU=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id BBC78A3BAE;
        Mon,  2 Aug 2021 11:47:44 +0000 (UTC)
Date:   Mon, 2 Aug 2021 13:47:42 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Feng Tang <feng.tang@intel.com>,
        Mel Gorman <mgorman@techsingularity.net>
Cc:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Widawsky, Ben" <ben.widawsky@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andi Kleen <ak@linux.intel.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH v6 1/6] mm/mempolicy: Add MPOL_PREFERRED_MANY for
 multiple preferred nodes
Message-ID: <YQfbXi3foZjOyHm4@dhcp22.suse.cz>
References: <20210729070918.GA96680@shbuild999.sh.intel.com>
 <YQKvZDXmRSVVRvfi@dhcp22.suse.cz>
 <20210729151242.GA42865@shbuild999.sh.intel.com>
 <YQLVf3pkQTHLemAZ@dhcp22.suse.cz>
 <20210730030502.GA87066@shbuild999.sh.intel.com>
 <YQOeAgPS9+FUseIx@dhcp22.suse.cz>
 <20210730071840.GA87305@shbuild999.sh.intel.com>
 <20210802081130.GA42490@shbuild999.sh.intel.com>
 <YQfTlSy/vmI3ELgR@dhcp22.suse.cz>
 <20210802113326.GA78980@shbuild999.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210802113326.GA78980@shbuild999.sh.intel.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon 02-08-21 19:33:26, Feng Tang wrote:
[...]
> And to be honest, I don't fully understand the current handling for
> 'bind' policy, will the returning NULL for 'bind' policy open a
> sideway for the strict 'bind' limit. 

I do not remember all the details but this is an old behavior that MBIND
policy doesn't apply to kernel allocations in presnce of the movable
zone. Detailed reasoning is not clear to me at the moment, maybe Mel
remembers?
-- 
Michal Hocko
SUSE Labs

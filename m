Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 567623DB492
	for <lists+linux-api@lfdr.de>; Fri, 30 Jul 2021 09:38:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237472AbhG3Hif (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 30 Jul 2021 03:38:35 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:38340 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237403AbhG3Hie (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 30 Jul 2021 03:38:34 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 7B8BA2233D;
        Fri, 30 Jul 2021 07:38:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1627630709; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jGHXXndIRPcNqfp9ZjfxjjaXEDBdfQyrjmCIAb6m5dA=;
        b=AfLpBOqzqAYHEFisYuBRqPn1V3uIqFKJCjTiZtHe/G8HUvy0jXX6aASbxKZhvRuOf3s1J1
        LXBOUQlLTvqpf9Nh/6T5XAbWL9PWFYnPZAyIEFRrr1wzwFt/u6x/awtp7u+uJv97BkBtNG
        +/cbnJYCRX6ZUXRRgyM8VSMyRHuETPA=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 1FE13A3B8E;
        Fri, 30 Jul 2021 07:38:29 +0000 (UTC)
Date:   Fri, 30 Jul 2021 09:38:28 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Feng Tang <feng.tang@intel.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
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
        Dan Williams <dan.j.williams@intel.com>, ying.huang@intel.com,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH v6 1/6] mm/mempolicy: Add MPOL_PREFERRED_MANY for
 multiple preferred nodes
Message-ID: <YQOsdO+qfeRkoucZ@dhcp22.suse.cz>
References: <YQFOB4UDK+dNZeOV@dhcp22.suse.cz>
 <20210728141156.GC43486@shbuild999.sh.intel.com>
 <YQGB5cB5NlgOuNIN@dhcp22.suse.cz>
 <20210729070918.GA96680@shbuild999.sh.intel.com>
 <YQKvZDXmRSVVRvfi@dhcp22.suse.cz>
 <20210729151242.GA42865@shbuild999.sh.intel.com>
 <YQLVf3pkQTHLemAZ@dhcp22.suse.cz>
 <20210730030502.GA87066@shbuild999.sh.intel.com>
 <YQOeAgPS9+FUseIx@dhcp22.suse.cz>
 <20210730071840.GA87305@shbuild999.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210730071840.GA87305@shbuild999.sh.intel.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri 30-07-21 15:18:40, Feng Tang wrote:
[...]
> And for the mempolicy_slab_node(), it seems to be a little different,
> and we may need to reuse its logic for 'bind' policy, which is similar
> to what we've discussed, pick a nearest node to the local node. And
> similar for mpol_misplaced(). Thoughts?

I have to admit, I haven't looked closer to what slab does. I am not
familiar with internals and would have to study it some more. Maybe slab
maintainers have an idea.
-- 
Michal Hocko
SUSE Labs

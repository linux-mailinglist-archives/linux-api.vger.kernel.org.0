Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF367463064
	for <lists+linux-api@lfdr.de>; Tue, 30 Nov 2021 10:59:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235746AbhK3KCw (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 30 Nov 2021 05:02:52 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:55976 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235542AbhK3KCv (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 30 Nov 2021 05:02:51 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id ECFB61FD2F;
        Tue, 30 Nov 2021 09:59:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1638266371; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Rj7fBCObUGndfuoqoh5LD826+ZYVlyOX8gZEmJe+54U=;
        b=PFQJFC4/jGB+dm1csFOe7y7a9AMfb+Mn2l95iWfB2hUv3y8x65RLusAvfXbQ1Oo1FwZfLf
        XgVIX3BfPxO3EuA84iiGQXCLpFzQ+ItC4VGTX2K4rKCR9rtPgqMY/CajOAsEVkdDcHcuk4
        dfj4DqSBe65/95YO5RjPjsmoS+LTnkA=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id A2CF1A3B83;
        Tue, 30 Nov 2021 09:59:31 +0000 (UTC)
Date:   Tue, 30 Nov 2021 10:59:28 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Ben Widawsky <ben.widawsky@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Feng Tang <feng.tang@intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andi Kleen <ak@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Huang Ying <ying.huang@intel.com>, linux-api@vger.kernel.org
Subject: Re: [PATCH v5 2/3] mm/mempolicy: add set_mempolicy_home_node syscall
Message-ID: <YaX2ACKeR7rtC3Cu@dhcp22.suse.cz>
References: <20211116064238.727454-1-aneesh.kumar@linux.ibm.com>
 <20211116064238.727454-3-aneesh.kumar@linux.ibm.com>
 <20211129140215.11b7cf9f1034a7fe7017768c@linux-foundation.org>
 <87wnkqaujt.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87wnkqaujt.fsf@linux.ibm.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue 30-11-21 14:29:02, Aneesh Kumar K.V wrote:
[...]
> Now IIUC, even after a node is marked offline via try_offline_node() we
> still be able to access the zonelist details using the pgdata struct. 

Yes, pgdat stays in place along with its zonelists when the node is
completely hotremoved. This is unlikely to ever change because way too
many operations would have to be hotplug aware. Leaving home node behind
is not really much different from the preferred node policy or any other
policy mask.
-- 
Michal Hocko
SUSE Labs

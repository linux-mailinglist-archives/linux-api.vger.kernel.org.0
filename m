Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DAA242C0FA
	for <lists+linux-api@lfdr.de>; Wed, 13 Oct 2021 15:07:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233226AbhJMNJX (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 13 Oct 2021 09:09:23 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:55268 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231145AbhJMNJW (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 13 Oct 2021 09:09:22 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 997CF20132;
        Wed, 13 Oct 2021 13:07:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1634130438; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WCrahj8cuS/aJb+J0M9GsQa08xO2egYG4Rp04diKk0Y=;
        b=NK1XmXN5LHabo8R7H+KI2oAewGoWuvw76tFvtM4Bcwi685CIDzJA9LJkrS/hlTOQzvXJ+x
        e3iXCrPpvEAO5nIOHQLYBMc5TYVI4CAm8tDvBJ07BbDRt3rxvymnYbwwyQs4hGk9vAIwxW
        k9UF5M/uKBw4vwww2vmKh3N6fQ0Lqps=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 294BCA3B83;
        Wed, 13 Oct 2021 13:07:13 +0000 (UTC)
Date:   Wed, 13 Oct 2021 15:07:14 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
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
Subject: Re: [RFC PATCH] mm/mempolicy: add MPOL_PREFERRED_STRICT memory policy
Message-ID: <YWbaAv/RGt+SCnql@dhcp22.suse.cz>
References: <20211013094539.962357-1-aneesh.kumar@linux.ibm.com>
 <YWa4FoicH0VztGTl@dhcp22.suse.cz>
 <YWa5geHLIPe2aUxB@dhcp22.suse.cz>
 <4399a215-296f-e880-c5f4-8065ab13d210@linux.ibm.com>
 <YWbWDlpQzQ9GC+B6@dhcp22.suse.cz>
 <9a0baa59-f316-103f-3030-990cd91d1813@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a0baa59-f316-103f-3030-990cd91d1813@linux.ibm.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed 13-10-21 18:28:40, Aneesh Kumar K.V wrote:
> On 10/13/21 18:20, Michal Hocko wrote:
[...]
> > I am still not sure the semantic makes sense though. Why should
> > the lowest node in the nodemask have any special meaning? What if it is
> > a node with a higher number that somebody preferes to start with?
> > 
> 
> That is true. I haven't been able to find an easy way to specify the
> preferred node other than expressing it as first node in the node mask. Yes,
> it limits the usage of the policy. Any alternate suggestion?

set_mempolicy is indeed not very suitable for something you are looking
for. Could you be more specific why the initial node is so important?
Is this because you want to allocate from a cpu less node first before
falling back to others?
-- 
Michal Hocko
SUSE Labs

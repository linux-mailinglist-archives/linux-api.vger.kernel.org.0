Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7402E4611E2
	for <lists+linux-api@lfdr.de>; Mon, 29 Nov 2021 11:13:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232995AbhK2KQm (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 29 Nov 2021 05:16:42 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:45224 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbhK2KOl (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 29 Nov 2021 05:14:41 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 07845212C9;
        Mon, 29 Nov 2021 10:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1638180683; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wzFhqGXMFfQkBFsb10LJfqyYR4B7HCna+pwx/ub7xDY=;
        b=LyECdSBpb/6jkjpXhvEC4Ms671DGuKxJLhLNtHwnjvENQ6uG7E28WpYaJ5mvDfU0nd/hNb
        AhhQ9Ds0vfC7LxFY1ZB7i8XZGs0tDqAHno2x55k9GOeP50Z8Q4g8UxNjHAOsIKq0nBXoP2
        kOEzifieD63zqadjyIhP702dj/mF+VU=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 4845EA3B81;
        Mon, 29 Nov 2021 10:11:22 +0000 (UTC)
Date:   Mon, 29 Nov 2021 11:11:21 +0100
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
Subject: Re: [PATCH v5 1/3] mm/mempolicy: use policy_node helper with
 MPOL_PREFERRED_MANY
Message-ID: <YaSnSZFI8oTOaj/Q@dhcp22.suse.cz>
References: <20211116064238.727454-1-aneesh.kumar@linux.ibm.com>
 <20211116064238.727454-2-aneesh.kumar@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211116064238.727454-2-aneesh.kumar@linux.ibm.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue 16-11-21 12:12:36, Aneesh Kumar K.V wrote:
> A followup patch will enable setting a home node with MPOL_PREFERRED_MANY
> memory policy. To facilitate that switch to using policy_node helper.
> There is no functional change in this patch.
> 
> Cc: Ben Widawsky <ben.widawsky@intel.com>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Feng Tang <feng.tang@intel.com>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Andrea Arcangeli <aarcange@redhat.com>
> Cc: Mel Gorman <mgorman@techsingularity.net>
> Cc: Mike Kravetz <mike.kravetz@oracle.com>
> Cc: Randy Dunlap <rdunlap@infradead.org>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Andi Kleen <ak@linux.intel.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Huang Ying <ying.huang@intel.com>
> Cc: linux-api@vger.kernel.org
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>

Acked-by: Michal Hocko <mhocko@suse.com>

alloc_pages_vma doesn't really need a node parameter. I will send a
follow up patch based on this series as a reply.
-- 
Michal Hocko
SUSE Labs

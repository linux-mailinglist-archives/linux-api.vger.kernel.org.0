Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51384464536
	for <lists+linux-api@lfdr.de>; Wed,  1 Dec 2021 04:00:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241503AbhLADDx (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 30 Nov 2021 22:03:53 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:58844 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbhLADDx (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 30 Nov 2021 22:03:53 -0500
Received: from mail.kernel.org (unknown [198.145.29.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 3E53FCE1D63
        for <linux-api@vger.kernel.org>; Wed,  1 Dec 2021 03:00:32 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2082B604DC;
        Wed,  1 Dec 2021 03:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1638327630;
        bh=rE92ZsrRFGUJPqC5lq6LvJdf/WnYGPPYf8ZNjb8IlQE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hUVlO+IJ/5gv/YvH3nJknIPO20GcfN5Lyn7puPrkGgiCIFhvxLc1HyRaKCboxicCG
         oewbh1UifO7DWe1+HMRR49iZX2GheYjDxGlRiHhxAEuylG8/5hRP3NxhFTt9LmLReD
         Hyyxdp5tcC7Ko647SQoe5/ZCJ4FohwM3Ksy9FyPc=
Date:   Tue, 30 Nov 2021 19:00:28 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc:     linux-mm@kvack.org, Ben Widawsky <ben.widawsky@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Feng Tang <feng.tang@intel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andi Kleen <ak@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Huang Ying <ying.huang@intel.com>, linux-api@vger.kernel.org
Subject: Re: [PATCH v5 2/3] mm/mempolicy: add set_mempolicy_home_node
 syscall
Message-Id: <20211130190028.6644054bc7142af36ef5c648@linux-foundation.org>
In-Reply-To: <87wnkqaujt.fsf@linux.ibm.com>
References: <20211116064238.727454-1-aneesh.kumar@linux.ibm.com>
        <20211116064238.727454-3-aneesh.kumar@linux.ibm.com>
        <20211129140215.11b7cf9f1034a7fe7017768c@linux-foundation.org>
        <87wnkqaujt.fsf@linux.ibm.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, 30 Nov 2021 14:29:02 +0530 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> wrote:

> > What's the thinking here?  The node can later be offlined and the
> > kernel takes no action to reset home nodes, so why not permit setting a
> > presently-offline node as the home node?  Checking here seems rather
> > arbitrary?
> 
> The node online check was needed to avoid accessing 
> uninitialised pgdat structure. Such an access can result in
> below crash

Oh.  This is unobvious from reading the code.  Which calls for a
comment, no?

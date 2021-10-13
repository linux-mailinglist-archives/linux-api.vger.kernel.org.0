Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64D5E42C313
	for <lists+linux-api@lfdr.de>; Wed, 13 Oct 2021 16:26:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235232AbhJMO2d (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 13 Oct 2021 10:28:33 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:45606 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230348AbhJMO2d (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 13 Oct 2021 10:28:33 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 714062195C;
        Wed, 13 Oct 2021 14:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1634135189; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1A37pVasNYvqmdWZyYR4EfMHZ9CZ5Wa9qMX6GgtqTNo=;
        b=K1oCyba59Wg7aWWCyLMF3fcKqETHd+3JKg0OFCyRqZfLKr2J1cWATnW82hLBVFh7J59dBo
        iFBU5yZWIGS58HHqb/iKfMckCQRtkVPaC4g2xTSSjHtxcHvtscTdga94D0bIMtSOFbA91k
        r3A3YAJRPjOLFecT+8Ws8V8+TyzI/6U=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 9E6AEA3B81;
        Wed, 13 Oct 2021 14:26:24 +0000 (UTC)
Date:   Wed, 13 Oct 2021 16:26:28 +0200
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
Message-ID: <YWbslIALFQIYNM/g@dhcp22.suse.cz>
References: <20211013094539.962357-1-aneesh.kumar@linux.ibm.com>
 <YWa4FoicH0VztGTl@dhcp22.suse.cz>
 <YWa5geHLIPe2aUxB@dhcp22.suse.cz>
 <4399a215-296f-e880-c5f4-8065ab13d210@linux.ibm.com>
 <YWbWDlpQzQ9GC+B6@dhcp22.suse.cz>
 <9a0baa59-f316-103f-3030-990cd91d1813@linux.ibm.com>
 <291424a2-c962-533e-c755-e4239fd55f5d@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <291424a2-c962-533e-c755-e4239fd55f5d@linux.ibm.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed 13-10-21 19:27:03, Aneesh Kumar K.V wrote:
[...]
> Another option is to keep this mbind(2) specific and overload flags to be
> the preferred nodeid.
> 
> mbind(va, len, MPOL_PREFERRED_STRICT, nodemask, max_node, preferred_node);

First of all I do not think you really want to create a new memory
policy for this. Not to mention that PREFERRED_STRICT is kinda weird in
the first place but one could argue that a preference of the first node
to try is not really specific to BIND/PREFERRED_MANY. Overloading flags
is a nogo.

-- 
Michal Hocko
SUSE Labs

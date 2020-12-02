Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE0862CBBCB
	for <lists+linux-api@lfdr.de>; Wed,  2 Dec 2020 12:47:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbgLBLqS (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 2 Dec 2020 06:46:18 -0500
Received: from mx2.suse.de ([195.135.220.15]:34468 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726254AbgLBLqR (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 2 Dec 2020 06:46:17 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id F3757ACB5;
        Wed,  2 Dec 2020 11:45:35 +0000 (UTC)
Date:   Wed, 2 Dec 2020 11:45:33 +0000
From:   Mel Gorman <mgorman@suse.de>
To:     Huang Ying <ying.huang@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Rafael Aquini <aquini@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>,
        David Rientjes <rientjes@google.com>, linux-api@vger.kernel.org
Subject: Re: [PATCH -V6 RESEND 3/3] NOT kernel/numactl: Support to enable
 Linux kernel NUMA balancing
Message-ID: <20201202114533.GX3306@suse.de>
References: <20201202084234.15797-1-ying.huang@intel.com>
 <20201202084234.15797-4-ying.huang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20201202084234.15797-4-ying.huang@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, Dec 02, 2020 at 04:42:34PM +0800, Huang Ying wrote:
> A new API: numa_set_membind_balancing() is added to libnuma.  It is
> same as numa_set_membind() except that the Linux kernel NUMA balancing
> will be enabled for the task if the feature is supported by the
> kernel.
> 
> At the same time, a new option: --balancing (-b) is added to numactl.
> Which can be used before the memory policy options in the command
> line.  With it, the Linux kernel NUMA balancing will be enabled for
> the process if the feature is supported by the kernel.
> 
> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> index f3bb22b..109dd8f 100644
> --- a/numactl.8
> +++ b/numactl.8
> @@ -25,6 +25,8 @@ numactl \- Control NUMA policy for processes or shared memory
>  [
>  .B \-\-all
>  ] [
> +.B \-\-balancing
> +] [

--balancing is a bit vague, maybe --balance-bind? The intent is to hint
that it's specific to MPOL_BIND at this time.

-- 
Mel Gorman
SUSE Labs

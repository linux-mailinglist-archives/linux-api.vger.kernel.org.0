Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A98FF2D08A6
	for <lists+linux-api@lfdr.de>; Mon,  7 Dec 2020 01:49:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727370AbgLGAtn (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sun, 6 Dec 2020 19:49:43 -0500
Received: from mga06.intel.com ([134.134.136.31]:49683 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726046AbgLGAtn (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Sun, 6 Dec 2020 19:49:43 -0500
IronPort-SDR: xq7asSfL7k3IHHI1vm/MvOaLy1iV7yNc4ccVDsrL9seJkDdINKMhcyesunt214gyzDaJRIwTu7
 WOl3xSTl57Tg==
X-IronPort-AV: E=McAfee;i="6000,8403,9827"; a="235227977"
X-IronPort-AV: E=Sophos;i="5.78,398,1599548400"; 
   d="scan'208";a="235227977"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2020 16:49:01 -0800
IronPort-SDR: wudM+445YgVBNXcynP9r8T3fkm/l7Ss98AgAcC3hOGTyxHg2S5T5y9j0L3LSLoDhhTjWWzNfrB
 fOjZrL3gg0ig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,398,1599548400"; 
   d="scan'208";a="316887170"
Received: from yhuang-dev.sh.intel.com (HELO yhuang-dev) ([10.239.159.50])
  by fmsmga008.fm.intel.com with ESMTP; 06 Dec 2020 16:48:58 -0800
From:   "Huang\, Ying" <ying.huang@intel.com>
To:     "Alejandro Colomar \(man-pages\)" <alx.manpages@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Matthew Wilcox \(Oracle\)" <willy@infradead.org>,
        Rafael Aquini <aquini@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>,
        David Rientjes <rientjes@google.com>,
        linux-api@vger.kernel.org, Mel Gorman <mgorman@suse.de>
Subject: Re: [PATCH -V7 2/3] NOT kernel/man2/set_mempolicy.2: Add mode flag MPOL_F_NUMA_BALANCING
References: <20201204091534.72239-1-ying.huang@intel.com>
        <20201204091534.72239-3-ying.huang@intel.com>
        <4c10125a-cbe6-7dff-3b57-c3480e913c5f@gmail.com>
Date:   Mon, 07 Dec 2020 08:48:57 +0800
In-Reply-To: <4c10125a-cbe6-7dff-3b57-c3480e913c5f@gmail.com> (Alejandro
        Colomar's message of "Fri, 4 Dec 2020 14:25:20 +0100")
Message-ID: <87v9demoee.fsf@yhuang-dev.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hi, Alex,

"Alejandro Colomar (man-pages)" <alx.manpages@gmail.com> writes:

> Hi Huang Ying,
>
> Please, see a few fixes below.
>
> Thanks,
>
> Alex
>
> On 12/4/20 10:15 AM, Huang Ying wrote:
>> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
>> ---
>>  man2/set_mempolicy.2 | 14 ++++++++++++++
>>  1 file changed, 14 insertions(+)
>> 
>> diff --git a/man2/set_mempolicy.2 b/man2/set_mempolicy.2
>> index 68011eecb..fb2e6fd96 100644
>> --- a/man2/set_mempolicy.2
>> +++ b/man2/set_mempolicy.2
>> @@ -113,6 +113,15 @@ A nonempty
>>  .I nodemask
>>  specifies node IDs that are relative to the set of
>>  node IDs allowed by the process's current cpuset.
>> +.TP
>> +.BR MPOL_F_NUMA_BALANCING " (since Linux 5.11)"
>> +When
>> +.I mode
>> +is MPOL_BIND, enable the Linux kernel NUMA balancing for the task if
>
> .B MPOL_BIND
>
>> +it is supported by kernel.
>> +If the flag isn't supported by Linux kernel, or is used with
>> +.I mode> +other than MPOL_BIND, return -1 and errno is set to EINVAL.
>
> .BR MPOL_BIND ,
>
> A minus sign should be escaped:
> \-1
> See man-pages(7)::STYLE GUIDE::Generating optimal glyphs)
>
> .I errno
> .BR EINVAL .
>
>>  .PP
>>  .I nodemask
>>  points to a bit mask of node IDs that contains up to
>> @@ -293,6 +302,11 @@ argument specified both
>>  .B MPOL_F_STATIC_NODES
>>  and
>>  .BR MPOL_F_RELATIVE_NODES .
>> +Or, the
>> +.B MPOL_F_NUMA_BALANCING
>> +isn't supported by the Linux kernel, or is used with
>> +.I mode
>> +other than MPOL_BIND.
>
> .BR MPOL_BIND .
>
>>  .TP
>>  .B ENOMEM
>>  Insufficient kernel memory was available.
>> 

Thanks a lot for your comments!  Will change them in the next version.

Best Regards,
Huang, Ying

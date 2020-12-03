Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 962012CCBD3
	for <lists+linux-api@lfdr.de>; Thu,  3 Dec 2020 02:49:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727234AbgLCBtt (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 2 Dec 2020 20:49:49 -0500
Received: from mga09.intel.com ([134.134.136.24]:38060 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726597AbgLCBtt (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 2 Dec 2020 20:49:49 -0500
IronPort-SDR: JHzJMzBSYKitCcum+CpIzw+BLIiRmV3ZzsZ3wRmeC1t8nAB5KK/R5phMYSOS2Ox2n7ytm1jOi+
 nNlSW3r0aNCg==
X-IronPort-AV: E=McAfee;i="6000,8403,9823"; a="173278405"
X-IronPort-AV: E=Sophos;i="5.78,388,1599548400"; 
   d="scan'208";a="173278405"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2020 17:49:08 -0800
IronPort-SDR: TclsFD5v6L3iYlOeNDxihWRsbzh4AMtDKM+m8UQNrh6DM7MwonI19dtl4qcqXPijZEN62JNTL3
 RvqAqC+phb+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,388,1599548400"; 
   d="scan'208";a="550294491"
Received: from yhuang-dev.sh.intel.com (HELO yhuang-dev) ([10.239.159.50])
  by orsmga005.jf.intel.com with ESMTP; 02 Dec 2020 17:49:03 -0800
From:   "Huang\, Ying" <ying.huang@intel.com>
To:     Mel Gorman <mgorman@suse.de>
Cc:     Peter Zijlstra <peterz@infradead.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        "Matthew Wilcox \(Oracle\)" <willy@infradead.org>,
        Rafael Aquini <aquini@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>,
        David Rientjes <rientjes@google.com>,
        <linux-api@vger.kernel.org>
Subject: Re: [PATCH -V6 RESEND 2/3] NOT kernel/man-pages: man2/set_mempolicy.2: Add mode flag MPOL_F_NUMA_BALANCING
References: <20201202084234.15797-1-ying.huang@intel.com>
        <20201202084234.15797-3-ying.huang@intel.com>
        <20201202114357.GW3306@suse.de>
Date:   Thu, 03 Dec 2020 09:49:02 +0800
In-Reply-To: <20201202114357.GW3306@suse.de> (Mel Gorman's message of "Wed, 2
        Dec 2020 11:43:57 +0000")
Message-ID: <87ft4npskx.fsf@yhuang-dev.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Mel Gorman <mgorman@suse.de> writes:

> On Wed, Dec 02, 2020 at 04:42:33PM +0800, Huang Ying wrote:
>> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
>> ---
>>  man2/set_mempolicy.2 | 9 +++++++++
>>  1 file changed, 9 insertions(+)
>> 
>> diff --git a/man2/set_mempolicy.2 b/man2/set_mempolicy.2
>> index 68011eecb..3754b3e12 100644
>> --- a/man2/set_mempolicy.2
>> +++ b/man2/set_mempolicy.2
>> @@ -113,6 +113,12 @@ A nonempty
>>  .I nodemask
>>  specifies node IDs that are relative to the set of
>>  node IDs allowed by the process's current cpuset.
>> +.TP
>> +.BR MPOL_F_NUMA_BALANCING " (since Linux 5.11)"
>> +Enable the Linux kernel NUMA balancing for the task if it is supported
>> +by kernel.
>> +If the flag isn't supported by Linux kernel, return -1 and errno is
>> +set to EINVAL.
>>  .PP
>>  .I nodemask
>>  points to a bit mask of node IDs that contains up to
>> @@ -293,6 +299,9 @@ argument specified both
>
> Should this be expanded more to clarify it applies to MPOL_BIND
> specifically?
>
> Maybe the first patch should be expanded more and explictly fail if
> MPOL_F_NUMA_BALANCING is used with anything other than MPOL_BIND?

For MPOL_PREFERRED, why could we not use NUMA balancing to migrate pages
to the accessing local node if it is same as the preferred node?  We
have a way to turn off NUMA balancing already, why could we not provide
a way to enable it if that's intended?

Even for MPOL_INTERLEAVE, if the target node is the same as the
accessing local node, can we use NUMA balancing to migrate pages?

So, I prefer to make MPOL_F_NUMA_BALANCING to be

  Optimizing with NUMA balancing if possible, and we may add more
  optimization in the future.

Do you agree?

Best Regards,
Huang, Ying

>>  .B MPOL_F_STATIC_NODES
>>  and
>>  .BR MPOL_F_RELATIVE_NODES .
>> +Or, the
>> +.B MPOL_F_NUMA_BALANCING
>> +isn't supported by the Linux kernel.
>
> This will be difficult for an app to distinguish but we can't go back in
> time and make this ENOSYS :(
>
> The linux-api people might have more guidance but it may go to the
> extent of including a small test program in the manual page for a
> sequence that tests whether MPOL_F_NUMA_BALANCING works. They might have
> a better recommendation on how it should be handled.

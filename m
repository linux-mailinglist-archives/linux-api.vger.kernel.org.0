Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB2B42DF77D
	for <lists+linux-api@lfdr.de>; Mon, 21 Dec 2020 02:35:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727431AbgLUBcO (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sun, 20 Dec 2020 20:32:14 -0500
Received: from mga06.intel.com ([134.134.136.31]:1557 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726883AbgLUBcO (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Sun, 20 Dec 2020 20:32:14 -0500
IronPort-SDR: nX6mS4T1G/LznfhQvIxpS9fbrqnHyP7XuF8hEOItrvKzjbeAJULOEte1pPlvh7oYpkCMmfb/Fj
 2VUw0bi4wVvg==
X-IronPort-AV: E=McAfee;i="6000,8403,9841"; a="237231506"
X-IronPort-AV: E=Sophos;i="5.78,436,1599548400"; 
   d="scan'208";a="237231506"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2020 17:31:32 -0800
IronPort-SDR: 7sm+cUtt3GRnu2XJYnWTYquYvO0Ky3lxtvZKKaXEePHbmxoTZ7IgU5P3FZ/3q9zCWlKfrovXQC
 +anCZ0ttaEWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,436,1599548400"; 
   d="scan'208";a="342229855"
Received: from yhuang-dev.sh.intel.com (HELO yhuang-dev) ([10.239.159.50])
  by fmsmga008.fm.intel.com with ESMTP; 20 Dec 2020 17:31:29 -0800
From:   "Huang\, Ying" <ying.huang@intel.com>
To:     "Alejandro Colomar \(mailing lists\; readonly\)" 
        <alx.mailinglists@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Matthew Wilcox \(Oracle\)" <willy@infradead.org>,
        Rafael Aquini <aquini@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>,
        David Rientjes <rientjes@google.com>, linux-api@vger.kernel.org
Subject: Re: [PATCH -V6 RESEND 2/3] NOT kernel/man-pages: man2/set_mempolicy.2: Add mode flag MPOL_F_NUMA_BALANCING
References: <20201202084234.15797-1-ying.huang@intel.com>
        <20201202084234.15797-3-ying.huang@intel.com>
        <48e758d7-9961-e28e-26f5-3bb381d36309@gmail.com>
        <87pn3klnq6.fsf@yhuang-dev.intel.com>
        <60283b9f-7616-15f6-b521-c15995907fb6@gmail.com>
Date:   Mon, 21 Dec 2020 09:31:28 +0800
In-Reply-To: <60283b9f-7616-15f6-b521-c15995907fb6@gmail.com> (Alejandro
        Colomar's message of "Fri, 18 Dec 2020 11:21:05 +0100")
Message-ID: <874kkggd1r.fsf@yhuang-dev.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

"Alejandro Colomar (mailing lists; readonly)"
<alx.mailinglists@gmail.com> writes:

> Hi Huang, Ying,
>
> Sorry I forgot to answer.
> See below.
>
> BTW, Linux 5.10 has been released recently;
> is this series already merged for 5.11?
> If not yet, could you just write '5.??' and we'll fix it (and add a
> commit number in a comment) when we know the definitive version?

Sure.  Will replace it with 5.12.  Thanks for reminding!

Best Regards,
Huang, Ying

> Thanks,
>
> Alex
>
> On 12/8/20 9:13 AM, Huang, Ying wrote:
>> Hi, Alex,
>> 
>> Sorry for late, I just notice this email today.
>> 
>> "Alejandro Colomar (mailing lists; readonly)"
>> <alx.mailinglists@gmail.com> writes:
>> 
>>> Hi Huang Ying,
>>>
>>> Please see a few fixes below.
>>>
>>> Michael, as always, some question for you too ;)
>>>
>>> Thanks,
>>>
>>> Alex
>>>
>>> On 12/2/20 9:42 AM, Huang Ying wrote:
>>>> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
>>>> ---
>>>>  man2/set_mempolicy.2 | 9 +++++++++
>>>>  1 file changed, 9 insertions(+)
>>>>
>>>> diff --git a/man2/set_mempolicy.2 b/man2/set_mempolicy.2
>>>> index 68011eecb..3754b3e12 100644
>>>> --- a/man2/set_mempolicy.2
>>>> +++ b/man2/set_mempolicy.2
>>>> @@ -113,6 +113,12 @@ A nonempty
>>>>  .I nodemask
>>>>  specifies node IDs that are relative to the set of
>>>>  node IDs allowed by the process's current cpuset.
>>>> +.TP
>>>> +.BR MPOL_F_NUMA_BALANCING " (since Linux 5.11)"
>>>
>>> I'd prefer it to be in alphabetical order (rather than just adding at
>>> the bottom).
>> 
>> That's OK for me.  But it's better to be done in another patch to
>> distinguish contents from pure order change?
>
> Yes, if you could do a series of 2 patches with a reordering first, it
> would be great.
>
>> 
>>> That way, when lists grow, it's easier to find things.
>>>
>>>> +Enable the Linux kernel NUMA balancing for the task if it is supported
>>>> +by kernel.
>>>
>>> I'd s/Linux kernel/kernel/ when it doesn't specifically refer to the
>>> Linux kernel to differentiate it from other kernels.  It only adds noise
>>> (IMHO).  mtk?
>> 
>> Sure.  Will fix this and all following comments below.  Thanks a lot for
>> your help!  I am new to man pages.
>
> Thank you!
>
>> 
>> Best Regards,
>> Huang, Ying
>> 

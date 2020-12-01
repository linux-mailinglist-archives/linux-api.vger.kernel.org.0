Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 735D42C93EB
	for <lists+linux-api@lfdr.de>; Tue,  1 Dec 2020 01:29:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389126AbgLAA22 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 30 Nov 2020 19:28:28 -0500
Received: from mga03.intel.com ([134.134.136.65]:20861 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388133AbgLAA22 (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Mon, 30 Nov 2020 19:28:28 -0500
IronPort-SDR: EGok0JIPBGoXxKI+Qyvggij90dKB/fec+NGHabY8Z6cq1HbDNFlAMvq5sGaT968u7qNzP37ci0
 CzecyGDtxFtA==
X-IronPort-AV: E=McAfee;i="6000,8403,9821"; a="172835294"
X-IronPort-AV: E=Sophos;i="5.78,382,1599548400"; 
   d="scan'208";a="172835294"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2020 16:27:47 -0800
IronPort-SDR: yj4LV58XLzO268tAWATMfYPQ0jKvINmzRsB/h2Q/p5ZAfNM73gOp5tYLgWAKrXlg8LkmukzX/8
 Q4mrBZKEgV9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,382,1599548400"; 
   d="scan'208";a="364459780"
Received: from yhuang-dev.sh.intel.com (HELO yhuang-dev) ([10.239.159.50])
  by fmsmga004.fm.intel.com with ESMTP; 30 Nov 2020 16:27:44 -0800
From:   "Huang\, Ying" <ying.huang@intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        "Matthew Wilcox \(Oracle\)" <willy@infradead.org>,
        Rafael Aquini <aquini@redhat.com>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>, "Mel Gorman" <mgorman@suse.de>,
        Rik van Riel <riel@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andi Kleen <ak@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>,
        David Rientjes <rientjes@google.com>,
        <linux-api@vger.kernel.org>
Subject: Re: [PATCH -v6 2/3] NOT kernel/man-pages man2/set_mempolicy.2: Add mode flag MPOL_F_NUMA_BALANCING
References: <20201126053219.234793-1-ying.huang@intel.com>
        <20201126053219.234793-3-ying.huang@intel.com>
        <a5d4c16b-74d7-403f-5f1c-8a1e8cbe4efb@intel.com>
Date:   Tue, 01 Dec 2020 08:27:43 +0800
In-Reply-To: <a5d4c16b-74d7-403f-5f1c-8a1e8cbe4efb@intel.com> (Dave Hansen's
        message of "Mon, 30 Nov 2020 09:48:56 -0800")
Message-ID: <87a6uyqsjk.fsf@yhuang-dev.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Dave Hansen <dave.hansen@intel.com> writes:

> On 11/25/20 9:32 PM, Huang Ying wrote:
>> --- a/man2/set_mempolicy.2
>> +++ b/man2/set_mempolicy.2
>> @@ -113,6 +113,11 @@ A nonempty
>>  .I nodemask
>>  specifies node IDs that are relative to the set of
>>  node IDs allowed by the process's current cpuset.
>> +.TP
>> +.BR MPOL_F_NUMA_BALANCING " (since Linux 5.11)"
>> +Enable the Linux kernel NUMA balancing for the task if it is supported
>> +by kernel.  If the flag isn't supported by Linux kernel, return -1 and
>> +errno is set to EINVAL.
>
> The one thing I learned about manpage CodingStyle is that new sentences
> go on new lines.  I think this needs to be:
>
> .TP
> .BR MPOL_F_NUMA_BALANCING " (since Linux 5.11)"
> Enable the Linux kernel NUMA balancing for the task if it is supported
> by kernel.
> If the flag isn't supported by Linux kernel, return -1 and errno is set
> to EINVAL.

Thanks a lot for your information!  I will revise this in the next version.

Best Regards,
Huang, Ying

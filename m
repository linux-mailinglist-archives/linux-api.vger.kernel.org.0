Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0E1A2DE0E4
	for <lists+linux-api@lfdr.de>; Fri, 18 Dec 2020 11:22:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388955AbgLRKVt (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 18 Dec 2020 05:21:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732938AbgLRKVt (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 18 Dec 2020 05:21:49 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0F72C0617A7;
        Fri, 18 Dec 2020 02:21:08 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id c133so1808939wme.4;
        Fri, 18 Dec 2020 02:21:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=t++cdbMmD+rlMQoSOM011lRfbvo658HBQtNF3MOsvfw=;
        b=Fv+Vz9wt6lrMy8+uCq2aqmOrOlMNDdl/6sD3QH2UtBypu8LBZWFv5C/kJNsr2tbyEB
         l4em2fi9NeNDXck09JLQmWHRtjm4JtT6dpLGQHRYsq9FjGBpRvmKvlzzMYgSMngqL0CD
         y8NHd0ExNxri5cesSJSMwLCFEjrzNJkIwclyn133R2Wda78KiOBlCFsHbD+yYSA3Vjrh
         uMsfRSvN3DAAcAhv52FAP6nn0YTcpxyIyYsA16xRlYtSwwRcBsYDwONfFOR4BGaMontx
         5L8anOsi1ZKCxe7QPhe9ZYFvQXVBM7Ny3jq17u9cv2/icYNw1pwQM1wbHWcJw+o/uvpi
         hg6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=t++cdbMmD+rlMQoSOM011lRfbvo658HBQtNF3MOsvfw=;
        b=PK7MjjpZ7ZNKCLnJdiE50VrZ+zUmMhzmuYh/5X37eDsVH/GSznhZx8Ir+HQtqL1Crs
         jBOgsPdwAl06wRhhkUU/Yb4uXHsdnsyjBpSKVPOT9rR6Vpuq8pXzeV4yWxDjQ/Lm2FyJ
         wjysYXoQaOrSL0xJ0jlcewQioiVp2gEv1g43rGusPCZ2Eccspivgs3wskCs/XX7Co0wQ
         MXKBH5GuuwTt3C/Xmebv/YGXd2BBUcH7oqS/0JQQ4KmP7i2Qye+m+vyxzH2F83xCdRSR
         7OiUekYi5y3FiJKaTxNLUw3HK8wQr5MRhyeiIRGdmK3n5O+eO2FDr6pTFnzFYfZlFXSu
         vTKA==
X-Gm-Message-State: AOAM532nBgrFCyWSigyn562vIRPZW96eip0behJ4+SH+MTNjapo3ovBO
        gRx5yoUlOW3gWHm7E0MAVwDYOx9SQfHNUg==
X-Google-Smtp-Source: ABdhPJxij2LUPwGMyIHY5GB2IQfsCwQ6/XHJ81aWqtiS/E0vT9kB0CHB72WCzB3a8ptvq3xvLH9o5Q==
X-Received: by 2002:a1c:9dd8:: with SMTP id g207mr3482486wme.15.1608286867533;
        Fri, 18 Dec 2020 02:21:07 -0800 (PST)
Received: from [192.168.1.143] ([170.253.51.130])
        by smtp.gmail.com with ESMTPSA id z8sm11259259wmg.17.2020.12.18.02.21.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Dec 2020 02:21:06 -0800 (PST)
Subject: Re: [PATCH -V6 RESEND 2/3] NOT kernel/man-pages:
 man2/set_mempolicy.2: Add mode flag MPOL_F_NUMA_BALANCING
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>, linux-mm@kvack.org,
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
References: <20201202084234.15797-1-ying.huang@intel.com>
 <20201202084234.15797-3-ying.huang@intel.com>
 <48e758d7-9961-e28e-26f5-3bb381d36309@gmail.com>
 <87pn3klnq6.fsf@yhuang-dev.intel.com>
From:   "Alejandro Colomar (mailing lists; readonly)" 
        <alx.mailinglists@gmail.com>
Message-ID: <60283b9f-7616-15f6-b521-c15995907fb6@gmail.com>
Date:   Fri, 18 Dec 2020 11:21:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <87pn3klnq6.fsf@yhuang-dev.intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hi Huang, Ying,

Sorry I forgot to answer.
See below.

BTW, Linux 5.10 has been released recently;
is this series already merged for 5.11?
If not yet, could you just write '5.??' and we'll fix it (and add a
commit number in a comment) when we know the definitive version?

Thanks,

Alex

On 12/8/20 9:13 AM, Huang, Ying wrote:
> Hi, Alex,
> 
> Sorry for late, I just notice this email today.
> 
> "Alejandro Colomar (mailing lists; readonly)"
> <alx.mailinglists@gmail.com> writes:
> 
>> Hi Huang Ying,
>>
>> Please see a few fixes below.
>>
>> Michael, as always, some question for you too ;)
>>
>> Thanks,
>>
>> Alex
>>
>> On 12/2/20 9:42 AM, Huang Ying wrote:
>>> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
>>> ---
>>>  man2/set_mempolicy.2 | 9 +++++++++
>>>  1 file changed, 9 insertions(+)
>>>
>>> diff --git a/man2/set_mempolicy.2 b/man2/set_mempolicy.2
>>> index 68011eecb..3754b3e12 100644
>>> --- a/man2/set_mempolicy.2
>>> +++ b/man2/set_mempolicy.2
>>> @@ -113,6 +113,12 @@ A nonempty
>>>  .I nodemask
>>>  specifies node IDs that are relative to the set of
>>>  node IDs allowed by the process's current cpuset.
>>> +.TP
>>> +.BR MPOL_F_NUMA_BALANCING " (since Linux 5.11)"
>>
>> I'd prefer it to be in alphabetical order (rather than just adding at
>> the bottom).
> 
> That's OK for me.  But it's better to be done in another patch to
> distinguish contents from pure order change?

Yes, if you could do a series of 2 patches with a reordering first, it
would be great.

> 
>> That way, when lists grow, it's easier to find things.
>>
>>> +Enable the Linux kernel NUMA balancing for the task if it is supported
>>> +by kernel.
>>
>> I'd s/Linux kernel/kernel/ when it doesn't specifically refer to the
>> Linux kernel to differentiate it from other kernels.  It only adds noise
>> (IMHO).  mtk?
> 
> Sure.  Will fix this and all following comments below.  Thanks a lot for
> your help!  I am new to man pages.

Thank you!

> 
> Best Regards,
> Huang, Ying
> 

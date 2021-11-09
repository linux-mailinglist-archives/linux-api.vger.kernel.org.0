Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0EF844AE51
	for <lists+linux-api@lfdr.de>; Tue,  9 Nov 2021 14:01:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232970AbhKINDw (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 9 Nov 2021 08:03:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230114AbhKINDv (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 9 Nov 2021 08:03:51 -0500
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BE21C061766
        for <linux-api@vger.kernel.org>; Tue,  9 Nov 2021 05:01:05 -0800 (PST)
Received: by mail-ot1-x335.google.com with SMTP id h12-20020a056830034c00b0055c8458126fso11765476ote.0
        for <linux-api@vger.kernel.org>; Tue, 09 Nov 2021 05:01:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=AVhXRNXWoG4nz7o/lke7pJRtR8Em/wWLZScBAGeMu9g=;
        b=DHB7jYMFAcf8uxuqEmaiXy/5GRLxtMMekfIqso1iCTmp49IW45L24FBjFGGyKSePCZ
         qY6TQM+giMtQYL0ICAQKCYzLN4kuPSiXtj1WSea1exnmC90E++Md7V0pTVfE0DSR30Fe
         8fKImM9RXY0OtuOzlSR/p3uS1EPkkQbduaj1mm5X49vUJZ6X/ONFsD2PAjwtTSt6FdwD
         RhoXS+mKWoSldUI1y+1oGRVnSuEyMBjfuI0vEy5jXkMyF9H6n9Ckm4GIq2DHgmXdalCU
         kElObxXXD2ZibSav2qWgG2MVwoQ1v0ddtNFrhBJSrSua+HFjdIX98ozfHy96fMopSvCT
         1i4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=AVhXRNXWoG4nz7o/lke7pJRtR8Em/wWLZScBAGeMu9g=;
        b=lFWbTowE8oLqeW3I6xgCvQRLZ+rmunY4xazD94GHOe18KcuFJgl9pgW3rEXAgeQ/YS
         b7cx1EVp8hvd5pUHE/5hV5bQNb2ATavBUtLlQlc0lQvkD90RyHctrtGD7bu10nN6B7au
         Y4lisgvvDh4DPQguabTgWhXX5gBXVRUuLOG9WpX+DQ+0VF6XL72WivaToD8tvoWInYhW
         I6SrgBV6Wl+ZfZ8t2UhIYa+/BNVR+6bfBeivgsmoW6nj89SObVOPPbjGNi8I0iSGcHwM
         6WP8KB3pVVCxdzQ+H9cpSPGGuBZfWh6NGPEu5YGKQKz2L+qo7piLjLBhvivFCct9n8cu
         HnMw==
X-Gm-Message-State: AOAM530NSenS6sz/ktdf4y0DDkXT8OQEwTGwHvcJF37teNv/iWBW7Me/
        IBIvokjMUg5DkneGuamQgZv00w==
X-Google-Smtp-Source: ABdhPJzjmloI4njSsXKqibqtacip31c9IiXov8uX5GuzDD0N97lf9hVYIhmu6EH7+gsKEYFgDSL7Rw==
X-Received: by 2002:a9d:f4a:: with SMTP id 68mr215156ott.327.1636462864405;
        Tue, 09 Nov 2021 05:01:04 -0800 (PST)
Received: from ?IPV6:2804:431:c7cb:55a:94d0:2630:9b29:e621? ([2804:431:c7cb:55a:94d0:2630:9b29:e621])
        by smtp.gmail.com with ESMTPSA id k4sm7088764oic.48.2021.11.09.05.01.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Nov 2021 05:01:04 -0800 (PST)
Message-ID: <e73b9309-b575-37b4-519c-d326b764cf38@linaro.org>
Date:   Tue, 9 Nov 2021 10:00:59 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH v2 20/22] selftests: futex: Test sys_futex_waitv() timeout
Content-Language: en-US
To:     =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@collabora.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Cc:     Davidlohr Bueso <dave@stgolabs.net>, libc-alpha@sourceware.org,
        Peter Zijlstra <peterz@infradead.org>,
        linux-api@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, mtk.manpages@gmail.com,
        Darren Hart <dvhart@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, kernel@collabora.com,
        krisman@collabora.com
References: <20210923171111.300673-1-andrealmeid@collabora.com>
 <20210923171111.300673-21-andrealmeid@collabora.com>
 <your-ad-here.call-01636456701-ext-5362@work.hours>
 <51bbfe74-33f6-bb92-3ce8-a22e4185820b@collabora.com>
From:   Adhemerval Zanella <adhemerval.zanella@linaro.org>
In-Reply-To: <51bbfe74-33f6-bb92-3ce8-a22e4185820b@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org



On 09/11/2021 09:52, André Almeida via Libc-alpha wrote:
> Hi Vasily,
> 
> Às 08:18 de 09/11/21, Vasily Gorbik escreveu:
>> On Thu, Sep 23, 2021 at 02:11:09PM -0300, André Almeida wrote:
>>> Test if the futex_waitv timeout is working as expected, using the
>>> supported clockid options.
>>
>>> +	/* futex_waitv with CLOCK_MONOTONIC */
>>> +	if (futex_get_abs_timeout(CLOCK_MONOTONIC, &to, timeout_ns))
>>> +		return RET_FAIL;
>>> +	res = futex_waitv(&waitv, 1, 0, &to, CLOCK_MONOTONIC);
>>> +	test_timeout(res, &ret, "futex_waitv monotonic", ETIMEDOUT);
>>> +
>>> +	/* futex_waitv with CLOCK_REALTIME */
>>> +	if (futex_get_abs_timeout(CLOCK_REALTIME, &to, timeout_ns))
>>> +		return RET_FAIL;
>>> +	res = futex_waitv(&waitv, 1, 0, &to, CLOCK_REALTIME);
>>> +	test_timeout(res, &ret, "futex_waitv realtime", ETIMEDOUT);
>>
>> Hi André,
>>
>> when built with -m32 and run as compat this two futex_waitv calls hang
>> on x86 and s390 (noticed while wiring up futex_waitv). The rest of the
>> futex selftests pass. This suggests some common compat issue? Any ideas?
> 
> The issue is that futex_waitv() only accepts struct timespec that uses
> 64bit members. When using -m32, glibc will give you a 32bit timespec,
> thus the timeout won't wort. Someday glibc will provide 64bit timespec
> to 32bit userspace, given that this is affected by y2038 bug.

We do since glibc 2.34, but you need to opt-in by defining -D_TIME_SIZE=64.
The default might change in a future release, so hopefully we will have
both LFS and 64-bit as the default ABI.

> 
> In previous submissions I added a workaround for that in the
> selftest[0]. Search for "Y2038 section for 32-bit applications" in that
> link. I'll submit something like that for futex_waitv() timeout test.
> 
> [0]
> https://lore.kernel.org/lkml/20210709001328.329716-6-andrealmeid@collabora.com/
> 

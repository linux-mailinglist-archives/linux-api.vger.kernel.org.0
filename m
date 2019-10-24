Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4A7CE2D4C
	for <lists+linux-api@lfdr.de>; Thu, 24 Oct 2019 11:28:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389329AbfJXJ2h (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 24 Oct 2019 05:28:37 -0400
Received: from foss.arm.com ([217.140.110.172]:44064 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732234AbfJXJ2h (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 24 Oct 2019 05:28:37 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4E10B31F;
        Thu, 24 Oct 2019 02:28:23 -0700 (PDT)
Received: from [10.37.9.200] (unknown [10.37.9.200])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EC5843F718;
        Thu, 24 Oct 2019 02:28:15 -0700 (PDT)
Subject: Re: [PATCHv7 18/33] lib/vdso: Add unlikely() hint into
 vdso_read_begin()
To:     Andrei Vagin <avagin@gmail.com>
Cc:     Dmitry Safonov <dima@arista.com>, linux-kernel@vger.kernel.org,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Adrian Reber <adrian@lisas.de>,
        Andrei Vagin <avagin@openvz.org>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jann Horn <jannh@google.com>, Jeff Dike <jdike@addtoit.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        containers@lists.linux-foundation.org, criu@openvz.org,
        linux-api@vger.kernel.org, x86@kernel.org
References: <20191011012341.846266-1-dima@arista.com>
 <20191011012341.846266-19-dima@arista.com>
 <100f6921-9081-7eb0-7acc-f10cfb647c21@arm.com>
 <20191024061311.GA4541@gmail.com>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <9aa9857e-ee1c-0117-bfcb-45fc6bcab866@arm.com>
Date:   Thu, 24 Oct 2019 10:30:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191024061311.GA4541@gmail.com>
Content-Type: text/plain; charset=koi8-r
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hi Andrei,

On 10/24/19 7:13 AM, Andrei Vagin wrote:
> On Wed, Oct 16, 2019 at 12:24:14PM +0100, Vincenzo Frascino wrote:
>> On 10/11/19 2:23 AM, Dmitry Safonov wrote:
>>> From: Andrei Vagin <avagin@gmail.com>
>>>
>>> Place the branch with no concurrent write before contended case.
>>>
>>> Performance numbers for Intel(R) Core(TM) i5-6300U CPU @ 2.40GHz
>>> (more clock_gettime() cycles - the better):
>>>         | before    | after
>>> -----------------------------------
>>>         | 150252214 | 153242367
>>>         | 150301112 | 153324800
>>>         | 150392773 | 153125401
>>>         | 150373957 | 153399355
>>>         | 150303157 | 153489417
>>>         | 150365237 | 153494270
>>> -----------------------------------
>>> avg     | 150331408 | 153345935
>>> diff %  | 2	    | 0
>>> -----------------------------------
>>> stdev % | 0.3	    | 0.1
>>>
>>> Signed-off-by: Andrei Vagin <avagin@gmail.com>
>>> Co-developed-by: Dmitry Safonov <dima@arista.com>
>>> Signed-off-by: Dmitry Safonov <dima@arista.com>
>>
>> Reviewed-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
>> Tested-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> 
> Hello Vincenzo,
> 
> Could you test the attached patch on aarch64? On x86, it gives about 9%
> performance improvement for CLOCK_MONOTONIC and CLOCK_BOOTTIME.
> 

I did run similar tests in past with a previous version of the unified vDSO
library and what I can tell based on the results of those is that the impact of
"__always_inline" alone was around 7% on arm64, in fact I had a comment stating
"To improve performances, in this file, __always_inline it is used for the
functions called multiple times." in my implementation [1].

[1] https://bit.ly/2W9zMxB

I spent some time yesterday trying to dig out why the approach did not make the
cut but I could not infer it from the review process.

> Here is my test:
> https://github.com/avagin/vdso-perf
> 
> It is calling clock_gettime() in a loop for three seconds and then
> reports a number of iterations.
> 

I am happy to run the test on arm64 and provide some results.

> Thanks,
> Andrei
> 

-- 
Regards,
Vincenzo

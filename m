Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2FD6DE339A
	for <lists+linux-api@lfdr.de>; Thu, 24 Oct 2019 15:12:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390392AbfJXNMh (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 24 Oct 2019 09:12:37 -0400
Received: from foss.arm.com ([217.140.110.172]:50898 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390361AbfJXNMh (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 24 Oct 2019 09:12:37 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 90865C8F;
        Thu, 24 Oct 2019 06:12:21 -0700 (PDT)
Received: from [10.37.9.200] (unknown [10.37.9.200])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 103823F71A;
        Thu, 24 Oct 2019 06:12:14 -0700 (PDT)
Subject: Re: [PATCHv7 18/33] lib/vdso: Add unlikely() hint into
 vdso_read_begin()
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
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
 <9aa9857e-ee1c-0117-bfcb-45fc6bcab866@arm.com>
Message-ID: <c749983f-24a8-a159-5e29-6fdd741f6023@arm.com>
Date:   Thu, 24 Oct 2019 14:14:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <9aa9857e-ee1c-0117-bfcb-45fc6bcab866@arm.com>
Content-Type: text/plain; charset=koi8-r
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hi Andrei,

On 10/24/19 10:30 AM, Vincenzo Frascino wrote:
[...]
>> Here is my test:
>> https://github.com/avagin/vdso-perf
>>
>> It is calling clock_gettime() in a loop for three seconds and then
>> reports a number of iterations.
>>
> 
> I am happy to run the test on arm64 and provide some results.
>

Please find below the results:

clock            | before     | after      | diff
==================================================
monotonic          17326692     17951770     3.6%
monotonic-coarse   43624027     44215292     1.3%
monotonic-raw      17541809     17554932     0.1%
boottime           17334982     17954361     3.5%

The improvement for arm64 for monotonic and boottime is around 3.5%.

I created a pull request on github to send to you back the changes I had
to do to vdso-perf to cross-compile it on arm64 [1].

[1] https://github.com/avagin/vdso-perf/pull/1


>> Thanks,
>> Andrei
>>
> 

-- 
Regards,
Vincenzo

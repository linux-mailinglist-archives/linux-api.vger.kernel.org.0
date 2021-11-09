Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E96B844AE14
	for <lists+linux-api@lfdr.de>; Tue,  9 Nov 2021 13:53:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237864AbhKIM4Q (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 9 Nov 2021 07:56:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242507AbhKIM4K (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 9 Nov 2021 07:56:10 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD202C06120A;
        Tue,  9 Nov 2021 04:53:08 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: tonyk)
        with ESMTPSA id C89B91F44B34
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=collabora.com; s=mail;
        t=1636462386; bh=6rhxitMRcNQgVh8jUZVAIrl39DOviTw78B3pgynzI/8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=J01tLFphErXVbo2Cz13hk0mouVzkea+XCNVKE14+gbDip1IiSyUUsitbUqq+SCcuE
         zw1jFtiTSzzO7AblKSF4eE+rks43ubJziZWgQpGANOR+VXZ/BtEwCp7cLJsMHkGvsB
         wsz8u4VZbs8JCbmxBcHpMUkah6xwEV7iOn8d9Xx58jrYZvwp0Syj8DM+Z2Gh+lyncu
         w+lbefh5remRkJnEFRZJbIXEaSf4oh1F7h/qdQLKN5MZgvS2bTK8l5BvK3XbW/LIbf
         9x2cUpMufMZuVTMuL+GtkOJPH/1mI/0Ozvk9vvedn33C3pLkT4ZXrkRQvDTuAvYWlO
         L6GDS7m2WhC+g==
Message-ID: <51bbfe74-33f6-bb92-3ce8-a22e4185820b@collabora.com>
Date:   Tue, 9 Nov 2021 09:52:58 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v2 20/22] selftests: futex: Test sys_futex_waitv() timeout
Content-Language: en-US
To:     Vasily Gorbik <gor@linux.ibm.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        kernel@collabora.com, krisman@collabora.com,
        linux-api@vger.kernel.org, libc-alpha@sourceware.org,
        mtk.manpages@gmail.com, Davidlohr Bueso <dave@stgolabs.net>,
        Arnd Bergmann <arnd@arndb.de>
References: <20210923171111.300673-1-andrealmeid@collabora.com>
 <20210923171111.300673-21-andrealmeid@collabora.com>
 <your-ad-here.call-01636456701-ext-5362@work.hours>
From:   =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@collabora.com>
In-Reply-To: <your-ad-here.call-01636456701-ext-5362@work.hours>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hi Vasily,

Às 08:18 de 09/11/21, Vasily Gorbik escreveu:
> On Thu, Sep 23, 2021 at 02:11:09PM -0300, André Almeida wrote:
>> Test if the futex_waitv timeout is working as expected, using the
>> supported clockid options.
> 
>> +	/* futex_waitv with CLOCK_MONOTONIC */
>> +	if (futex_get_abs_timeout(CLOCK_MONOTONIC, &to, timeout_ns))
>> +		return RET_FAIL;
>> +	res = futex_waitv(&waitv, 1, 0, &to, CLOCK_MONOTONIC);
>> +	test_timeout(res, &ret, "futex_waitv monotonic", ETIMEDOUT);
>> +
>> +	/* futex_waitv with CLOCK_REALTIME */
>> +	if (futex_get_abs_timeout(CLOCK_REALTIME, &to, timeout_ns))
>> +		return RET_FAIL;
>> +	res = futex_waitv(&waitv, 1, 0, &to, CLOCK_REALTIME);
>> +	test_timeout(res, &ret, "futex_waitv realtime", ETIMEDOUT);
> 
> Hi André,
> 
> when built with -m32 and run as compat this two futex_waitv calls hang
> on x86 and s390 (noticed while wiring up futex_waitv). The rest of the
> futex selftests pass. This suggests some common compat issue? Any ideas?

The issue is that futex_waitv() only accepts struct timespec that uses
64bit members. When using -m32, glibc will give you a 32bit timespec,
thus the timeout won't wort. Someday glibc will provide 64bit timespec
to 32bit userspace, given that this is affected by y2038 bug.

In previous submissions I added a workaround for that in the
selftest[0]. Search for "Y2038 section for 32-bit applications" in that
link. I'll submit something like that for futex_waitv() timeout test.

[0]
https://lore.kernel.org/lkml/20210709001328.329716-6-andrealmeid@collabora.com/

Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F4C820A0EF
	for <lists+linux-api@lfdr.de>; Thu, 25 Jun 2020 16:38:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405367AbgFYOil (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 25 Jun 2020 10:38:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405340AbgFYOik (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 25 Jun 2020 10:38:40 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7750C08C5C1;
        Thu, 25 Jun 2020 07:38:39 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: tonyk)
        with ESMTPSA id 8A9472A557F
Subject: Re: [RFC 0/4] futex2: Add new futex interface
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>, krisman@collabora.com,
        Collabora kernel ML <kernel@collabora.com>,
        Darren Hart <dvhart@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, pgriffais@valvesoftware.com,
        Florian Weimer <fweimer@redhat.com>,
        GNU C Library <libc-alpha@sourceware.org>,
        malteskarupke@web.de, Linux API <linux-api@vger.kernel.org>
References: <20200612185122.327860-1-andrealmeid@collabora.com>
 <CAK8P3a1fwYX-S84ukxEWBt_DZ09MdBLbQyf4Jgrr-AeqG89jeA@mail.gmail.com>
From:   =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@collabora.com>
Message-ID: <475e8c39-7d11-f80b-3b4a-e51be5d0963d@collabora.com>
Date:   Thu, 25 Jun 2020 11:38:29 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a1fwYX-S84ukxEWBt_DZ09MdBLbQyf4Jgrr-AeqG89jeA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hello Arnd,

On 6/25/20 3:48 AM, Arnd Bergmann wrote:
> On Fri, Jun 12, 2020 at 8:51 PM André Almeida <andrealmeid@collabora.com> wrote:
> 
>> - The proposed interface uses ktime_t type for absolute timeout, and I
>>   assumed that it should use values in a nsec resolution. If this is true,
>>   we have some problems with i386 ABI, please check out the
>>   COMPAT_32BIT_TIME implementation in patch 1 for more details. I
>>   haven't added a time64 implementation yet, until this is clarified.
> 
> ktime_t is not part of the uapi headers, and has always been considered
> an implementation detail of the kernel so far. I would argue it should
> stay that way. The most sensible alternatives would be to either use
> a "__u64 *timeout" argument for a relative timeout, or a
> "struct __kernel_timespec *timeout" for an absolute timeout.
> 
> old_time32_t also makes no sense for multiple reasons:
> 
> - It's another kernel internal type and not part of the uapi headers
> - your time32 call has different calling conventions from your time64
>   version, not just a different type.
> - there should be no need to add syscalls that are known to be buggy
>   when there is a replacement type that does not have that bug.
> 

Thanks for the input. As stated by tglx at [1], "supporting relative
timeouts is wrong to begin with", my next patch will use "struct
__kernel_timespec *timeout" for an absolute timeout.

>> - Is expected to have a x32 ABI implementation as well? In the case of
>>   wait and wake, we could use the same as x86_64 ABI. However, for the
>>   waitv (aka wait on multiple futexes) we would need a proper x32 entry
>>   since we are dealing with 32bit pointers.
> 
> For new syscalls, I'd actually recommend not having a separate
> entry point, but just checking 'if (in_compat_syscall())' inside of the
> implementation to pick one behavior vs the other when accessing
> the user pointers. This keeps the implementation simpler and
> avoids assigning a new x32 syscall number that would be different
> from all the other architectures.
> 

Cool, this will make the code cleaner.

>       Arnd
> 


Thanks,
	André

[1] https://lkml.org/lkml/2019/7/31/1499

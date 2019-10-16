Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1FCF7D8E31
	for <lists+linux-api@lfdr.de>; Wed, 16 Oct 2019 12:42:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392491AbfJPKmr (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 16 Oct 2019 06:42:47 -0400
Received: from foss.arm.com ([217.140.110.172]:35746 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389345AbfJPKmr (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 16 Oct 2019 06:42:47 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 930B328;
        Wed, 16 Oct 2019 03:42:46 -0700 (PDT)
Received: from [10.37.9.204] (unknown [10.37.9.204])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B02813F6C4;
        Wed, 16 Oct 2019 03:42:39 -0700 (PDT)
Subject: Re: [PATCHv7 01/33] ns: Introduce Time Namespace
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Dmitry Safonov <dima@arista.com>, linux-kernel@vger.kernel.org,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Andrei Vagin <avagin@openvz.org>,
        Adrian Reber <adrian@lisas.de>,
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
        containers@lists.linux-foundation.org, criu@openvz.org,
        linux-api@vger.kernel.org, x86@kernel.org,
        Andrei Vagin <avagin@gmail.com>
References: <20191011012341.846266-1-dima@arista.com>
 <20191011012341.846266-2-dima@arista.com>
 <80af93da-d497-81de-2a2a-179bb3bc852d@arm.com>
 <alpine.DEB.2.21.1910161230070.2046@nanos.tec.linutronix.de>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <5f4c2f29-ca68-b19c-017f-d23730f6e871@arm.com>
Date:   Wed, 16 Oct 2019 11:44:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1910161230070.2046@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org


On 10/16/19 11:39 AM, Thomas Gleixner wrote:
> On Wed, 16 Oct 2019, Vincenzo Frascino wrote:
> 
> < Trim 250+ lines ( 3+ pages) of pointlessly wasted electrons >
> 
>>> --- a/init/Kconfig
>>> +++ b/init/Kconfig
>>> @@ -1096,6 +1096,13 @@ config UTS_NS
>>>  	  In this namespace tasks see different info provided with the
>>>  	  uname() system call
>>>  
>>> +config TIME_NS
>>> +	bool "TIME namespace"
>>> +	default y
>>
>> Having CONFIG_TIME_NS "default y" makes so that the option is selected even on
>> the architectures that have no support for time namespaces.
>> The direct consequence is that the fallbacks defined in this patch are never
>> selected and this ends up in kernel compilation errors due to missing symbols.
>>
>> The error below shows what happens on arm64 (similar behavior on other
>> architectures):
>>
>> aarch64-linux-gnu-ld: kernel/time/namespace.o: in function `timens_on_fork':
>> kernel/time/namespace.c:321: undefined reference to `vdso_join_timens'
>>
>> My proposal is to keep TIME_NS "default n" (just remove "default y"), let the
>> architectures that enable time namespaces select it and make CONFIG_TIME_NS
>> select GENERIC_VDSO_TIME_NS if arch has HAVE_GENERIC_VDSO.
> 
> Nah.
> 
> config TIME_NS
> 	bool "TIME namespace"
> 	depends on GENERIC_VDSO_TIME_NS
> 	default y
> 
> and in lib/vdso/Kconfig
> 
> config GENERIC_VDSO_TIME_NS
> 	bool
> 
> and let architectures which have support for the VDSO bits select it.
>

Agreed, this is even better.

> < Trim another gazillion of useless lines >
> 
> See: https://people.kernel.org/tglx/notes-about-netiquette
> 
> Thanks,
> 
> 	tglx
> 

-- 
Regards,
Vincenzo

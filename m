Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E134E9096C
	for <lists+linux-api@lfdr.de>; Fri, 16 Aug 2019 22:21:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727628AbfHPUVF (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 16 Aug 2019 16:21:05 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34269 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727608AbfHPUVE (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 16 Aug 2019 16:21:04 -0400
Received: by mail-wr1-f66.google.com with SMTP id s18so2676298wrn.1;
        Fri, 16 Aug 2019 13:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HSbCBY4QdI505ZahQQ32YYrjA5TNW/1raAfMSboMpfA=;
        b=CI0xUsIQ+H/XNaqKp3RkPVOR9R9uyWBLkicvYSW9uT1pLt+1y8VwcO2h+egsrsWBZY
         O8T7+5HI4yJmsIiLfJYgvEqsP1XzDNpe3Y8dRLYSdwGZd3X6HLP/7+mHExlNw7ySPV90
         9JU4LptAPe9/Jdzln5g9MEO9XSlYR3XbrUN8dPul1MQBiT/Rz8ogzXfhNeXeO5E2/FHm
         uZa4H5l0XXrD16GsRhAQEgFuFwo89C/doTRFJ+jOOcYmk2iJ9T/3A9wOKJVHyUS3knBF
         LGI4yitDYHglnB5AbPdiQJXvmls4MPHAL4KQ/vj8o8KwI2CHjfxkCQg7dWszE4U5X+ex
         M/GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HSbCBY4QdI505ZahQQ32YYrjA5TNW/1raAfMSboMpfA=;
        b=Xeckq8QUHZcFG4XrSiGq0R1qOKb2rjdYMrIZUPLhTQigscSEj43iR1pLtRF/5G5e/F
         wAMMK+O7FZahAA9R1osYAmgJ+D4OaGMLvvCfpKcUWCKkiXuvpqC4IgKiac/p1l+n1TRu
         uuOm3boXR4at16q1X4LuMmLmYFkBLNIpxt4LIRKU4dUbs1AjxydUkyNMCM+UDeDR1q3T
         fJda10P1rFBgChjCbFkoK8KZ6cOtfuOOKJNbSS7/t9zgZ57rgqXGbWnlRfpPlFdqPDaP
         kWyDcBFg8E6v70VkskVGxdLmRN1EDPx8NsVlk/tTeDOX5gqiWzeS51ecDhn7UgPGi6kF
         XqrQ==
X-Gm-Message-State: APjAAAWUo1MfTy5ASpgmwqCFrehYul02Ee+ZJBqftbMuwjn6PIZ0D2Qt
        /wdRsW4+v0wgWZKqGGQgVPo=
X-Google-Smtp-Source: APXvYqwta2RmL2q4PYnVIins/WNeDrwRp2ETTjsH9PlTQpGfqqqFgzJUl7YEmvT7Dqsn0v7lynqb0g==
X-Received: by 2002:adf:e887:: with SMTP id d7mr12690432wrm.282.1565986862226;
        Fri, 16 Aug 2019 13:21:02 -0700 (PDT)
Received: from [10.83.36.153] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id f23sm4247882wmj.37.2019.08.16.13.21.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Aug 2019 13:21:01 -0700 (PDT)
Subject: Re: [PATCHv6 22/36] x86/vdso: Add offsets page in vvar
To:     Thomas Gleixner <tglx@linutronix.de>,
        Dmitry Safonov <dima@arista.com>
Cc:     linux-kernel@vger.kernel.org, Andrei Vagin <avagin@openvz.org>,
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
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        containers@lists.linux-foundation.org, criu@openvz.org,
        linux-api@vger.kernel.org, x86@kernel.org,
        Andrei Vagin <avagin@gmail.com>
References: <20190815163836.2927-1-dima@arista.com>
 <20190815163836.2927-23-dima@arista.com>
 <alpine.DEB.2.21.1908152117231.1908@nanos.tec.linutronix.de>
From:   Dmitry Safonov <0x7f454c46@gmail.com>
Message-ID: <1a97f7a5-9380-fdb1-6b00-070950347355@gmail.com>
Date:   Fri, 16 Aug 2019 21:20:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1908152117231.1908@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hi Thomas,

On 8/15/19 8:21 PM, Thomas Gleixner wrote:
> On Thu, 15 Aug 2019, Dmitry Safonov wrote:
>> ---
>>  arch/Kconfig                          |  5 +++
>>  arch/x86/Kconfig                      |  1 +
>>  arch/x86/entry/vdso/vdso-layout.lds.S |  9 ++++-
>>  arch/x86/entry/vdso/vdso2c.c          |  3 ++
>>  arch/x86/entry/vdso/vma.c             | 12 +++++++
>>  arch/x86/include/asm/vdso.h           |  1 +
>>  init/Kconfig                          |  1 +
>>  lib/vdso/gettimeofday.c               | 47 +++++++++++++++++++++++++++
> 
> This needs to be split into the generic lib/vdso part and then x86 making
> use of it.

Ok

>> +#ifdef CONFIG_TIME_NS
> 
> This should be COMPILE_WITH_TIME_NS and not CONFIG_TIME_NS
> 
>> +extern u8 timens_page
>> +	__attribute__((visibility("hidden")));
>> +
>> +notrace static __always_inline void clk_to_ns(clockid_t clk, struct __kernel_timespec *ts)
> 
> This needs notrace because?

Heh, well it's alive from the time it was in arch/x86.
I believe, functions there had it since commit 23adec554a76 ("x86: add
notrace annotations to vsyscall"). Probably, lib/vdso is compiled
without mcount in the Makefile somewhere.
Will drop.

[..]
>> +	/*
>> +	 * The kernel allows to set a negative offset only if the current clock
>> +	 * value in a namespace is positive, so the result tv_sec can't be
>> +	 * negative here.
>> +	 */
>> +	ts->tv_nsec += offset64->tv_nsec;
>> +	ts->tv_sec += offset64->tv_sec;
>> +	if (ts->tv_nsec >= NSEC_PER_SEC) {
>> +		ts->tv_nsec -= NSEC_PER_SEC;
>> +		ts->tv_sec++;
>> +	}
>> +	if (ts->tv_nsec < 0) {
>> +		ts->tv_nsec += NSEC_PER_SEC;
>> +		ts->tv_sec--;
>> +	}
> 
> That's broken for 32bit user space on 64bit hosts. On LE due to
> misalignment and on BE because 32bit will read always 0.

Ugh, will look into that.

Thanks,
          Dmitry

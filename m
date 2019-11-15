Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 25C8BFDB57
	for <lists+linux-api@lfdr.de>; Fri, 15 Nov 2019 11:27:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725829AbfKOK1r (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 15 Nov 2019 05:27:47 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:46328 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727510AbfKOK1r (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 15 Nov 2019 05:27:47 -0500
Received: by mail-lj1-f195.google.com with SMTP id e9so10097813ljp.13
        for <linux-api@vger.kernel.org>; Fri, 15 Nov 2019 02:27:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=s4HMcsPs8cjZ6BAAS4T6v8josVfK505Km0iWyRPGXIo=;
        b=WxsOerESuXKK3YeifFDCXB72E5FRI1ynKWqNQ1i+YgEoRvsiBI5fcx1tVVElOymGyM
         5ZNggZXK1DvE59Or5JkwwVbCLVe2X2GgngiGaPxMmfeOZ5k90kBYNE1yifKK58X+u8d2
         DzdEULL2R/aE1TfEt53OnUgVZaCApLrpF7zYY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=s4HMcsPs8cjZ6BAAS4T6v8josVfK505Km0iWyRPGXIo=;
        b=b8mIESq6ZdVzPHFd3EdaCWY1++l/76zS7Q+esHRqlZyekWjwMiB2u9JjVOEEYnumy/
         86iUb3H3aHSRFZil4Ffri2xOO++NIuLYuFG7b0afbd/lti1IhytH0dDTdEkDIXaiZJ1u
         1oMC5uStPB1S85jfpgi2lAnPMa57ttmEaopHwisyS/dcOC4HWM2RpyFHa/UWQJN3UpQi
         Q8kmSSDYiC5RzXgji+kvgaTIjE5J5RumcuPA/Kr7Lakmm7p/Bx68kSMNe0vv9kARs3HI
         1YsQFaiR9LAo/foKKpFrJJkv9eajwlFRwM6yJfdTsAfTDmO3rfUx2qapsdSfyHttaXaR
         d4MQ==
X-Gm-Message-State: APjAAAVdgmQHfG3hYGgW7d8nPQHPJQvnD1OBWSirQ7HMHrFoA467wr8J
        2BzEa0JV/aAa9abvNoQunKT/q8NHn8hwBhZll3U=
X-Google-Smtp-Source: APXvYqycJQWJcX7oryo4kxovzNzZzRKngUCqSR34tt6HBVqlZROmp7cx+h4vlIJdhrF+Aeqbx+g93Q==
X-Received: by 2002:a2e:9712:: with SMTP id r18mr10860051lji.12.1573813664844;
        Fri, 15 Nov 2019 02:27:44 -0800 (PST)
Received: from [172.16.11.28] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id f5sm3576761ljn.24.2019.11.15.02.27.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Nov 2019 02:27:43 -0800 (PST)
Subject: Re: [PATCH 17/23] y2038: time: avoid timespec usage in settimeofday()
To:     Arnd Bergmann <arnd@arndb.de>, Abel Vesa <abelvesa@linux.com>
Cc:     y2038 Mailman List <y2038@lists.linaro.org>,
        John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Christian Brauner <christian@brauner.io>,
        Jens Axboe <axboe@kernel.dk>, Ingo Molnar <mingo@kernel.org>,
        Corey Minyard <cminyard@mvista.com>,
        zhengbin <zhengbin13@huawei.com>,
        Li RongQing <lirongqing@baidu.com>,
        Linux API <linux-api@vger.kernel.org>
References: <20191108210236.1296047-1-arnd@arndb.de>
 <20191108211323.1806194-8-arnd@arndb.de> <20191114230127.GA3580@ryzen.lan>
 <CAK8P3a3jn8GcedX=HaTFiPY+fyHPoyVUnpcX19nMZqmuUA1RzA@mail.gmail.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <73a56955-552a-3a95-a410-3064401913f7@rasmusvillemoes.dk>
Date:   Fri, 15 Nov 2019 11:27:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a3jn8GcedX=HaTFiPY+fyHPoyVUnpcX19nMZqmuUA1RzA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 15/11/2019 08.58, Arnd Bergmann wrote:
> On Fri, Nov 15, 2019 at 12:01 AM Abel Vesa <abelvesa@linux.com> wrote:
>>
>> On 19-11-08 22:12:16, Arnd Bergmann wrote:
>>> The compat_get_timeval() and timeval_valid() interfaces
>>> are deprecated and getting removed along with the definition
>>> of struct timeval itself.
>>>
>>> Change the two implementations of the settimeofday()
>>> system call to open-code these helpers and completely
>>> avoid references to timeval.
>>>
> 
> I'm not sure how we get to the RCU stall, but this is almost certainly another
> symptom of a typo I had introduced in the patch, which others have also
> reported. This is the the fix in today's linux-next:
> 
> --- a/kernel/time/time.c
> +++ b/kernel/time/time.c
> @@ -207,7 +207,7 @@ SYSCALL_DEFINE2(settimeofday, struct
> __kernel_old_timeval __user *, tv,
>                     get_user(new_ts.tv_nsec, &tv->tv_usec))
>                         return -EFAULT;
> 
> -               if (tv->tv_usec > USEC_PER_SEC)
> +               if (new_ts->tv_usec > USEC_PER_SEC)
>                         return -EINVAL;

Hopefully not :)

>                 new_ts.tv_nsec *= NSEC_PER_USEC;

So the actual patch in next-20191115 does

-               if (copy_from_user(&user_tv, tv, sizeof(*tv)))
+               if (get_user(new_ts.tv_sec, &tv->tv_sec) ||
+                   get_user(new_ts.tv_nsec, &tv->tv_usec))
                        return -EFAULT;

-               if (!timeval_valid(&user_tv))
+               if (new_ts.tv_nsec > USEC_PER_SEC)
                        return -EINVAL;

-               new_ts.tv_sec = user_tv.tv_sec;
-               new_ts.tv_nsec = user_tv.tv_usec * NSEC_PER_USEC;
+               new_ts.tv_nsec *= NSEC_PER_USEC;

But removing the "user value is < 0" check, relying on the timespec
value being rejected later, is wrong: 1000=8*125. Multiplying by 8
always gives a value with the low three bits clear, multiplying by 125
is reversible. So you can take any target value with the three low bits
clear, logic shift right by 3, multiply by 0x1cac083126e978d5 , and flip
the top three bits as you wish to generate 8 pre-images of that target
value. Four of those will be negative. A trivial example is 0x80..000
(aka LONG_MIN) and its cousins 0xa0..000, 0xc0..000, 0xe0..000 which all
become 0 and thus accepted after multiplying by NSEC_PER_USEC. But also
-858989233 (or -3689348814741906097 if long is 64 bit) become 4226200
which isn't even a multiple of 1000 - there's 500M examples to choose
from :)

I'm pretty sure it doesn't generate worse code, gcc is smart enough to
compile "foo > BAR || foo < 0" as if it was written "(unsigned version
of foo)foo > BAR". And while a value of USEC_PER_SEC itself will not
overflow and then be rejeted because the real comparison done later is
">= NSEC_PER_SEC", I think it's clearer to say "foo >= USEC_PER_SEC ||
foo < 0) just so the same pattern is used.

Rasmus

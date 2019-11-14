Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD794FC628
	for <lists+linux-api@lfdr.de>; Thu, 14 Nov 2019 13:17:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726202AbfKNMQF (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 14 Nov 2019 07:16:05 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39731 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbfKNMQF (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 14 Nov 2019 07:16:05 -0500
Received: by mail-wm1-f68.google.com with SMTP id t26so5653041wmi.4;
        Thu, 14 Nov 2019 04:16:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dd2LMjkOCL1oEnaMTzuojh9Lp/QB0THdadlfAp8Xo48=;
        b=Zik1Jdo6tszdJr/8yIUjKVeIe/kF9y17Mn7bEUlHl6qFWuvvqCJdFpQap+Ydxly7GC
         lh1NRY8pjILBBfXrQTY3OzA4Vgss/SsnlilvpJmQI7iPOEQ1lSNevfUSADfj53a3I05j
         +OPkYkcF7nAfRvGP8LaF2XfqbKalFyPPZ68sl6pntP4wnMUqt0CFv6UkyvDfprW7lXkM
         GT8peowMV8OB/L0zgcMncUMyoF/DOkWOw6EkYK9j33cEBXOWyf09GwduGmur3gBy+7Va
         nFSYxqdusVA3RaQ7E78D0EnCc4bZh58eKwGsv3l8uUEUszJgWyA/DB+HVs1TRGNHXDtz
         82sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dd2LMjkOCL1oEnaMTzuojh9Lp/QB0THdadlfAp8Xo48=;
        b=npJydSnFjKR8X+qvRUB0wmYn8GOF+EQlwIF8/ugn9yvH3Y34ebiiNiExHqdCkz8zwP
         9SXAQjrINECOJNDM1sW5sj/vdJoqrcTdoMpkHBSg0/KeOjPZayLG6B2tN1g6ZIq/HlvN
         pnPSnnFbxOLNfI19E4rCeUWFN9s57XjS+TLsDjF1o6pIv/vddUlsFxW1O0ajctiCy5yZ
         VRXCN3RyYogOEyFIXzorcYG5W02Asol6fBQzKEsgUqeh53a0F0TZLAtmU95+jfvUuYYH
         AmGduEAW1TnR1KlcUa35ybUwdufqYEluu2Uxlug/WVvGZZLfKBJ3G/n0ErjlD5DaqEIR
         7dUA==
X-Gm-Message-State: APjAAAWVo3Ha1Hg+HnP+/4BVT9uv8tNTCj2ipk7kyGuvTtvt0lXYfAs6
        nTRmvdIF3yti5K+X1KzZliG8crJG
X-Google-Smtp-Source: APXvYqxQqWReYenULLly18r0KGVfGmbc8GdN8r1MF2W0xB0Ax9dIwLu/7bpVeibzRiUPBztogpLYiQ==
X-Received: by 2002:a7b:c762:: with SMTP id x2mr7564127wmk.128.1573733761918;
        Thu, 14 Nov 2019 04:16:01 -0800 (PST)
Received: from ?IPv6:2001:a61:3a4e:101:8d4d:f454:a7e5:543d? ([2001:a61:3a4e:101:8d4d:f454:a7e5:543d])
        by smtp.gmail.com with ESMTPSA id g133sm5859240wme.42.2019.11.14.04.16.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Nov 2019 04:16:01 -0800 (PST)
Cc:     mtk.manpages@gmail.com,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Florian Weimer <fweimer@redhat.com>,
        Christian Brauner <christian@brauner.io>,
        lkml <linux-kernel@vger.kernel.org>,
        linux-man <linux-man@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Oleg Nesterov <oleg@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        David Howells <dhowells@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Adrian Reber <adrian@lisas.de>,
        Andrei Vagin <avagin@gmail.com>,
        Linux API <linux-api@vger.kernel.org>,
        Ingo Molnar <mingo@elte.hu>
Subject: Re: For review: documentation of clone3() system call
To:     Jann Horn <jannh@google.com>
References: <CAKgNAkjo2WHq+zESU1iuCHJJ0x-fTNrakS9-d1+BjzUuV2uf2Q@mail.gmail.com>
 <20191107151941.dw4gtul5lrtax4se@wittgenstein>
 <2eb2ab4c-b177-29aa-cdc4-420b24cfd7b3@gmail.com>
 <CAG48ez2of684J6suPZpko7JFV6hg5KQsrP0KAn8B8-C3PM9OfQ@mail.gmail.com>
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Message-ID: <090860a8-e57f-d4ea-88d4-086ea32e37d9@gmail.com>
Date:   Thu, 14 Nov 2019 13:15:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAG48ez2of684J6suPZpko7JFV6hg5KQsrP0KAn8B8-C3PM9OfQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hello Jann, Christian,

On 11/11/19 3:55 PM, Jann Horn wrote:
> On Sat, Nov 9, 2019 at 9:10 AM Michael Kerrisk (man-pages)
> <mtk.manpages@gmail.com> wrote:
> [...]
>> On 11/7/19 4:19 PM, Christian Brauner wrote:
>>> On Fri, Oct 25, 2019 at 06:59:31PM +0200, Michael Kerrisk (man-pages) wrote:
> [...]
>>>>        The stack argument specifies the location of the stack used by the
>>>>        child process.  Since the child and calling process may share mem‐
>>>>        ory,  it  is  not possible for the child process to execute in the
>>>>        same stack as the  calling  process.   The  calling  process  must
>>>>        therefore  set  up  memory  space  for  the child stack and pass a
>>>>        pointer to this space to clone().  Stacks  grow  downward  on  all
>>>
>>> It might be a good idea to advise people to use mmap() to create a
>>> stack. The "canonical" way of doing this would usually be something like
>>>
>>> #define DEFAULT_STACK_SIZE (4 * 1024 * 1024) /* 8 MB usually on Linux */
>>> void *stack = mmap(NULL, DEFAULT_STACK_SIZE, PROT_READ | PROT_WRITE, MAP_PRIVATE | MAP_ANONYMOUS | MAP_STACK, -1, 0);
>>>
>>> (Yes, the MAP_STACK is usally a noop but people should always include it
>>>  in case some arch will have weird alignment requirement in which case
>>>  this flag can be changed to actually do something...)
>>
>> So, I'm getting a little bit of an education here, and maybe you are
>> going to further educate me. Long ago, I added the documentation of
>> MAP_STACK to mmap(2), but I never quite connected the dots.
>>
>> However, you say MAP_STACK is *usually* a noop. As far as I can see,
>> in current kernels it is *always* a noop. And AFAICS, since it was first
>> added in 2.6.27 (2008), it has always been a noop.
>>
>> I wonder if it will always be a noop.
> [...]
>> So, my understanding from the above is that MAP_STACK was added to
>> allow a possible fix on some old architectures, should anyone decide it
>> was worth doing the work of implementing it. But so far, after 12 years,
>> no one did. It kind of looks like no one ever will (since those old
>> architectures become less and less relevant).
>>
>> So, AFAICT, while it's not wrong to tell people to use mmap(MAP_STACKED),
>> it doesn't provide any benefit (and perhaps never will), and it is a
>> more clumsy than plain old malloc().
>>
>> But, it could well be that there's something I still don't know here,
>> and I'd be interested to get further education.
> 
> Not on Linux, but on OpenBSD, they do use MAP_STACK now AFAIK; this
> was announced here:
> <http://openbsd-archive.7691.n7.nabble.com/stack-register-checking-td338238.html>.

Indeed, thank you for that pointer. The OpenBSD mmap(2) manual
page also says:

    MAP_STACK
        Indicate that the mapping is used as a stack. This
        flag must be used in combination with MAP_ANON and
        MAP_PRIVATE.

> Basically they periodically check whether the userspace stack pointer
> points into a MAP_STACK region, and if not, they kill the process.

And I now see that FreeBSD also has MAP_STACK (already since FreeBSD 3.1,
by the look of things!):

     MAP_STACK       
         MAP_STACK implies MAP_ANON, ando ffset of 0.  The fd
         argument must be -1 and prot must include at least
         PROT_READ and PROT_WRITE.

         This option creates a memory region that grows to at
         most len bytes in size, starting from the stack top
         and growing down.  The stack top is the starting ad-
         dress returned by the call, plus len bytes.  The bot-
         tom of the stack at maximum growth is the starting ad-
         dress returned by the call.

         Stacks created with MAP_STACK automatically grow.
         Guards prevent inadvertent use of the regions into
         which those stacks can grow without requiring mapping
         the whole stack in advance.

And on DragonflyBSD:

    MAP_STACK
        Map the area as a stack.  MAP_ANON is implied.
        Offset should be 0, fd must be -1, and prot should
        include at least PROT_READ and PROT_WRITE.  This
        option creates a memory region that grows to at
        most len bytes in size, starting from the stack 
        top and growing down.  The stack top is the start‐
        ing address returned by the call, plus len bytes.
        The bottom of the stack at maximum growth is the
        starting address returned by the call.

        The entire area is reserved from the point of view
        of other mmap() calls, even if not faulted in yet.

        WARNING!  We currently allow MAP_STACK mappings to
        provide a hint that points within an existing
        MAP_STACK mapping's space, and this will succeed
        as long as no page have been faulted in the area
        specified, but this behavior is no longer sup‐ 
        ported unless you also specify the MAP_TRYFIXED
        flag.

        Note that unless MAP_FIXED or MAP_TRYFIXED is
        used, you cannot count on the returned address
        matching the hint you have provided. 

> So
> even if it's a no-op on Linux, it might make sense to advise people to
> use the flag to improve portability? I'm not sure if that's something
> that belongs in Linux manpages.

Actually, the Linux manual pages frequently carry such hints, so
this is a good point.

> Another reason against malloc() is that when setting up thread stacks
> in proper, reliable software, you'll probably want to place a guard
> page (in other words, a 4K PROT_NONE VMA) at the bottom of the stack
> to reliably catch stack overflows; and you probably don't want to do
> that with malloc, in particular with non-page-aligned allocations.

Ahh yes, another good point.

I've fixed the example code in the manual page to use
mmap(MAP_STACK), rather than malloc(), to allocate the stack.

Thanks,

Michael


-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/

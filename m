Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27C27F7009
	for <lists+linux-api@lfdr.de>; Mon, 11 Nov 2019 10:02:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726808AbfKKJCh (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 11 Nov 2019 04:02:37 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44980 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726768AbfKKJCh (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 11 Nov 2019 04:02:37 -0500
Received: by mail-wr1-f67.google.com with SMTP id f2so13631973wrs.11;
        Mon, 11 Nov 2019 01:02:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8PrdLC+syL1cJZKq93VLTvVkA7QF+5oWUPd2Cy/mY9E=;
        b=Mzv6QBiWYw2ZIYUxMWVwAisCx08jtoZL+Jfc2dY3yTFcB5ZUT2x5mXPNuRLOXCvK/q
         QVU1b9yZoqBhoI8wdK9D8EZMcZKGYPodETvOaj9iNq7+B/amOd44C6wXKujzYM/tVobO
         QSffFlyKZ50dDuNzFfZTufIU+gsKZOh/pbmnADogSdl5ZJbn/PIvq6pT2qJpUrOSECFZ
         XMy2lAntv5rjeW+vPeN1Tdj0x9abRFmeh9lBYlD2urYuhdAxcyXXW4Wz+Cb9zp9/mAn1
         bgMVv74zLw/BFoPdSFNvVVwfO4UUq6FEkymWq5EgMWQn0msqziy7f5zUs7qArSCdBkpC
         YKtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8PrdLC+syL1cJZKq93VLTvVkA7QF+5oWUPd2Cy/mY9E=;
        b=N2VGRsKKT5MmgLXNV0SDHamsTgGuDyesxUUVXn+UeHseo9L/0H5LxAvXRFTut1HLUh
         OsSpP1204U0blZQqn3ViTTVZhy2pyTH/b1p2g13SkJRQAOPOw2ynjboRuqgrT+WdIRiK
         bSmzwXXhHTLgDJpG03KkdLHQBqNtW7RuhRR/Oajc7/Tbpz4KmFpQm37pIh6juMd5GLvy
         L1HW0Prb7ccDqK1ApyGax5YuYGIUwRmFMnCrYqW1Pw/L+XMub0iHA/aoNBKPVKnOiv3f
         8SSSK8tFvsIMfxljEKLT65N/+KGDNvZr3lfAqpNnkeRvGPa6/Au0CvfVEwWOMBixg9yz
         fy8Q==
X-Gm-Message-State: APjAAAVthsyuDutqFtxBB8fYFR73KVqA+QDUEj9aBrXcewHQbvvFVe99
        gAqouftzVyJoiTvdwsGlC8Y=
X-Google-Smtp-Source: APXvYqwmmxtTrTRImEhs5UDeMr3ITcDK7WQFBL6wDie13ViDdoHXC0E8kjhz9g5mAfd6tAagTViS8w==
X-Received: by 2002:adf:f9c4:: with SMTP id w4mr10919709wrr.88.1573462953929;
        Mon, 11 Nov 2019 01:02:33 -0800 (PST)
Received: from [10.30.242.25] ([212.118.206.70])
        by smtp.gmail.com with ESMTPSA id w132sm25160961wma.6.2019.11.11.01.02.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Nov 2019 01:02:33 -0800 (PST)
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Subject: Re: For review: documentation of clone3() system call
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     mtk.manpages@gmail.com, Florian Weimer <fweimer@redhat.com>,
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
        Jann Horn <jannh@google.com>, Ingo Molnar <mingo@elte.hu>
References: <CAKgNAkjo2WHq+zESU1iuCHJJ0x-fTNrakS9-d1+BjzUuV2uf2Q@mail.gmail.com>
 <20191107151941.dw4gtul5lrtax4se@wittgenstein>
 <2eb2ab4c-b177-29aa-cdc4-420b24cfd7b3@gmail.com>
 <20191109165349.ec5jkuqt7gtm2iy2@wittgenstein>
Message-ID: <52e0103b-2bc4-b0c6-274f-ce7effb1799f@gmail.com>
Date:   Mon, 11 Nov 2019 10:02:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20191109165349.ec5jkuqt7gtm2iy2@wittgenstein>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hello Christian,

[...]

>>>>        These  system  calls  create a new process, in a manner similar to
>>>>        fork(2).
>>>>
>>>>        Unlike fork(2), these system calls  allow  the  child  process  to
>>>>        share  parts  of  its  execution context with the calling process,
>>>
>>> Hm, sharing part of the execution context is not the only thing that
>>> clone{3}() does. 
>>
>> True. That text has been in the page for 21 years. It probably needs
>> a new coat of paint...
>>
>>> Maybe something like:
>>>
>>> 	Unlike fork(2), these system calls allow to create a child process with
>>> 	different properties than its parent. For example, these syscalls allow
>>> 	the child to share various parts of the execution context with the
>>> 	calling process such as [...]. They also allow placing the process in a
>>> 	new set of namespaces.
>>>
>>> Just a thought.
>>
>> A good thought...
>>
>> I changed the text to read:
>>
>>        Unlike fork(2), these system calls allow the child to  be  created
>>        with various properties that differ from the parent.  For example,
>>        these system calls provide more precise control over  what  pieces
>>        of  execution  context  are shared between the calling process and
>>        the child process.  For example, using  these  system  calls,  the
>>        caller can control whether or not the two processes share the vir‐
>>        tual address space, the table of file descriptors, and  the  table
>>        of  signal handlers.  These system system calls also allow the new
>>        child process to placed in separate namespaces(7).
>>
>> Okay?
> 
> Nit: The second and thirs sentence both start with "For example".
> Otherwise sounds great.

You gotta love it when the nonnative speaker points out the style errors
of the native speaker :-).

I fixed this.

[...]

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
>>
>> If we go back and look at the commit:
>>
>> [[
>> commit 2fdc86901d2ab30a12402b46238951d2a7891590
>> Author: Ingo Molnar <mingo@elte.hu>
>> Date:   Wed Aug 13 18:02:18 2008 +0200
>>
>>     x86: add MAP_STACK mmap flag
>>     
>>     as per this discussion:
>>     
>>        http://lkml.org/lkml/2008/8/12/423
>>     
>>     Pardo reported that 64-bit threaded apps, if their stacks exceed the
>>     combined size of ~4GB, slow down drastically in pthread_create() - because
>>     glibc uses MAP_32BIT to allocate the stacks. The use of MAP_32BIT is
>>     a legacy hack - to speed up context switching on certain early model
>>     64-bit P4 CPUs.
>>     
>>     So introduce a new flag to be used by glibc instead, to not constrain
>>     64-bit apps like this.
>>     
>>     glibc can switch to this new flag straight away - it will be ignored
>>     by the kernel. If those old CPUs ever matter to anyone, support for
>>     it can be implemented.
>> ]]
>>
>> And see also https://lwn.net/Articles/294642/
>>
>> So, my understanding from the above is that MAP_STACK was added to 
>> allow a possible fix on some old architectures, should anyone decide it
>> was worth doing the work of implementing it. But so far, after 12 years,
>> no one did. It kind of looks like no one ever will (since those old
>> architectures become less and less relevant).
>>
>> So, AFAICT, while it's not wrong to tell people to use mmap(MAP_STACKED),
>> it doesn't provide any benefit (and perhaps never will), and it is a
>> more clumsy than plain old malloc().
> 
> Apart from MAP_STACK at some point (however unlikely) becoming relevant
> I also like that mmap() makes it explicit that the page needs to be
> readable (PROT_READ) and writeable (PROT_WRITE) and also every
> (relevant) libc I know uses the explicit mmap() in their pthread
> implementation. If you prefer the malloc() as an example that's
> obviously fine.

I think the benefits you point out are not so significant.
The default assumption is that a given piece of memory is
readable and writable.

Does musl use MAP_STACKED? AFAICT, it doesn't.

I suppose it's not that I prefer malloc(), but rather that (first I
was ignorant, and second that) I prefer simplicity. In fact I even
set up a branch to change various pieces of code I had to use
MAP_STACKED, and then had an "if I had thought about this for
30 minutes, I might have saved myself a couple of hours of work" 
moment after I researched the history of MAP_STACKED a little.

I still don't know the answer for sure. I'm inclined to
leave things as they are until I hear a compelling
argument to change things.

>> Yeah, but I didn't get mentioned in the commit ;-)
> 
> You provided your Ack after I had taken the patch into my tree and I've
> already changed it once for Arnd's ack so I didn't want to change it
> again.

Yes. But I *motivated* the commit :-). Just saying. I'm not
too concerned!

[...]

>> I changed the text here to read:
>>
>>        CLONE_PID (Linux 2.0 to 2.5.15)
>>               If  CLONE_PID is set, the child process is created with the
>>               same process ID as the calling process.  This is  good  for
>>               hacking  the  system,  but otherwise of not much use.  From
>>               Linux 2.3.21 onward, this flag could be specified  only  by
>>               the system boot process (PID 0).  The flag disappeared com‐
>>               pletely from the kernel sources in  Linux  2.5.16.   Subse‐
>>               quently,  the  kernel  silently  ignored this bit if it was
>>               specified in the flags mask.  Much later, the same bit  was
>>               recycled for use as the CLONE_PIDFD flag.
> 
> Yip, sounds good.

Are you making fun of my accent? ;-)

Thanks again for your feedback, Christian.

Cheers,

Michael


-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/

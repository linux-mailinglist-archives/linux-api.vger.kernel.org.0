Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2891D19AB71
	for <lists+linux-api@lfdr.de>; Wed,  1 Apr 2020 14:15:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727661AbgDAMPR (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 1 Apr 2020 08:15:17 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:56242 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727439AbgDAMPR (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 1 Apr 2020 08:15:17 -0400
Received: by mail-wm1-f68.google.com with SMTP id r16so6317170wmg.5;
        Wed, 01 Apr 2020 05:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=preiv/lahCApGCdyoFXEO2ZyWJjwn6w9vkb6ab8bsKA=;
        b=Zw/Yr8ozkJU+iwarnyhQyd/SaK5vHylTzqz+Nqz+OQTb1Q9tlP4gH7YN0UvxKvItIo
         N9l0VvhhHufBcW5331XHoSdZoj5QOZ9V66zE7nvJDdmeqJMEX7j8L9AzGgAy9xfyk8W4
         ZiSaWafw9hKFbqDlIQ0mLvlFd7DsnikDx5xkjIOiTENTlISrcKGzd1orG+rV3+6Mru7m
         Jl4CqK128WRrGa+EZjP/n1fThyd2ycwa82k/CXr5chxveMNkIiwTeHhv0RufNGfl7yPM
         /nFPX462Fixo017a2p8xyt6U/qhgm6/ARjEtiDVEUWkSC8Ki4AY9dbhszd06jb2C4w8M
         ACiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=preiv/lahCApGCdyoFXEO2ZyWJjwn6w9vkb6ab8bsKA=;
        b=Vu4W1pod07LwenJtd8alusxlIgulBFVCjeOaLZt/HRtu/CirYbB2Y3mR2fdhV/utsn
         1q53kSDpq6YWkK9H8CA6zH4DWieavAmBuaRl449EcRl4glTO+Y9a5EJZXU4rJb/1FaVC
         EkHEJ14x0P4jUAZk0ZtMCyaQxS8VIKB8cDEzgl3WtzseS/yjiZzraifIjz42NNSq23QA
         BDG9PmqGu0KT+V1snm4kxd5XZ2uOSN09hD/U1fv8fJOumJ1/RsM8MM//KzVhJKVUB/I5
         z87zjJfdkWUzUG2WTRDBOnAOVEeI3eqXhDvCr6xGQH67JgTSRUHOyuCPH/1rOdDZF7Hy
         D3xQ==
X-Gm-Message-State: AGi0Pub8cES6CDCwrMPS5Pc1dV82Ey5w6i3zJSxzl12zWlRDxaEU55Gi
        oGYjmiD92ipP2atgqGrc5KFqeGGi
X-Google-Smtp-Source: APiQypJTGqqVaLxFsHL2RwgYI1A9DrxeICLq5ou33KNEMrGsd+Gfs7Uk/W+eJYDUS9N2uce4OyOPUQ==
X-Received: by 2002:a7b:ce12:: with SMTP id m18mr4190189wmc.135.1585743313513;
        Wed, 01 Apr 2020 05:15:13 -0700 (PDT)
Received: from ?IPv6:2001:a61:2482:101:3351:6160:8173:cc31? ([2001:a61:2482:101:3351:6160:8173:cc31])
        by smtp.gmail.com with ESMTPSA id b127sm200102wmd.2.2020.04.01.05.15.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Apr 2020 05:15:12 -0700 (PDT)
Cc:     mtk.manpages@gmail.com, Adrian Reber <areber@redhat.com>,
        Andrei Vagin <avagin@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
        Eric Biederman <ebiederm@xmission.com>,
        Pavel Emelyanov <ovzxemul@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Radostin Stoyanov <rstoyanov1@gmail.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: clone3: allow creation of time namespace with offset
To:     Christian Brauner <christian.brauner@ubuntu.com>
References: <20200319081137.GC223854@dcbz.redhat.com>
 <CAK8P3a18YySozk6P77JpS58Hbtz=QQmLKw+PrzXbdOwtOQQuJA@mail.gmail.com>
 <20200319102955.i7slokibkkysz6g6@wittgenstein>
 <20200320183355.GA118769@gmail.com>
 <20200324160945.orcm75avj2ol3eop@wittgenstein>
 <20200324162546.GG358599@dcbz.redhat.com>
 <20200324175649.fqkwiuvs2drk26ln@wittgenstein>
 <20200325075836.GK358599@dcbz.redhat.com>
 <20200325112652.sx66bhad7cqdsatm@wittgenstein>
 <78979e3f-293e-998a-0d7b-40da2616afcf@gmail.com>
 <20200401114620.465d3zw7nymqgqww@wittgenstein>
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Message-ID: <39fe60b6-6e4a-eb22-c205-b11e869653bf@gmail.com>
Date:   Wed, 1 Apr 2020 14:15:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200401114620.465d3zw7nymqgqww@wittgenstein>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 4/1/20 1:46 PM, Christian Brauner wrote:
> On Wed, Apr 01, 2020 at 01:40:25PM +0200, Michael Kerrisk (man-pages) wrote:
>> On 3/25/20 12:26 PM, Christian Brauner wrote:
>>> On Wed, Mar 25, 2020 at 08:58:36AM +0100, Adrian Reber wrote:
>>>> On Tue, Mar 24, 2020 at 06:56:49PM +0100, Christian Brauner wrote:
>>>>> On Tue, Mar 24, 2020 at 05:25:46PM +0100, Adrian Reber wrote:
>>>>>> On Tue, Mar 24, 2020 at 05:09:45PM +0100, Christian Brauner wrote:
>>>>>>> On Fri, Mar 20, 2020 at 11:33:55AM -0700, Andrei Vagin wrote:
>>>>>>>> On Thu, Mar 19, 2020 at 11:29:55AM +0100, Christian Brauner wrote:
>>>>>>>>> On Thu, Mar 19, 2020 at 09:16:43AM +0100, Arnd Bergmann wrote:
>>>>>>>>>> On Thu, Mar 19, 2020 at 9:11 AM Adrian Reber <areber@redhat.com> wrote:
>>>>>>>>>>
>>>>>>>>>>> With Arnd's idea of only using nanoseconds, timens_offset would then
>>>>>>>>>>> contain something like this:
>>>>>>>>>>>
>>>>>>>>>>> struct timens_offset {
>>>>>>>>>>>         __aligned_s64 monotonic_offset_ns;
>>>>>>>>>>>         __aligned_s64 boottime_offset_ns;
>>>>>>>>>>> };
>>>>>>>>>>>
>>>>>>>>>>> I kind of prefer adding boottime and monotonic directly to struct clone_args
>>>>>>>>>>>
>>>>>>>>>>>         __aligned_u64 tls;
>>>>>>>>>>>         __aligned_u64 set_tid;
>>>>>>>>>>>         __aligned_u64 set_tid_size;
>>>>>>>>>>> +       __aligned_s64 monotonic_offset_ns;
>>>>>>>>>>> +       __aligned_s64 boottime_offset_ns;
>>>>>>>>>>>  };
>>>>>>>>>>
>>>>>>>>>> I would also prefer the second approach using two 64-bit integers
>>>>>>>>>> instead of a pointer, as it keeps the interface simpler to implement
>>>>>>>>>> and simpler to interpret by other tools.
>>>>>>>>>
>>>>>>>>> Why I don't like has two reasons. There's the scenario where we have
>>>>>>>>> added new extensions after the new boottime member and then we introduce
>>>>>>>>> another offset. Then you'd be looking at:
>>>>>>>>>
>>>>>>>>> __aligned_u64 tls;
>>>>>>>>> __aligned_u64 set_tid;
>>>>>>>>> __aligned_u64 set_tid_size;
>>>>>>>>> + __aligned_s64 monotonic_offset_ns;
>>>>>>>>> + __aligned_s64 boottime_offset_ns;
>>>>>>>>> __aligned_s64 something_1
>>>>>>>>> __aligned_s64 anything_2
>>>>>>>>> + __aligned_s64 sometime_offset_ns
>>>>>>>>>
>>>>>>>>> which bothers me just by looking at it. That's in addition to adding two
>>>>>>>>> new members to the struct when most people will never set CLONE_NEWTIME.
>>>>>>>>> We'll also likely have more features in the future that will want to
>>>>>>>>> pass down more info than we want to directly expose in struct
>>>>>>>>> clone_args, e.g. for a long time I have been thinking about adding a
>>>>>>>>> struct for CLONE_NEWUSER that allows you to specify the id mappings you
>>>>>>>>> want the new user namespace to get. We surely don't want to force all
>>>>>>>>> new info into the uppermost struct. So I'm not convinced we should here.
>>>>>>>>
>>>>>>>> I think here we can start thinking about a netlink-like interface.
>>>>>>>
>>>>>>> I think netlink is just not a great model for an API and I would not
>>>>>>> want us to go down that route.
>>>>>>>
>>>>>>> I kept thinking about this for a bit and I think that we will end up
>>>>>>> growing more namespace-related functionality. So one thing that came to
>>>>>>> my mind is the following layout:
>>>>>>>
>>>>>>> struct {
>>>>>>> 	struct {
>>>>>>> 		__s64 monotonic;
>>>>>>> 		__s64 boot;
>>>>>>> 	} time;
>>>>>>> } namespaces;
>>>>>>>
>>>>>>> struct _clone_args {
>>>>>>> 	__aligned_u64 flags;
>>>>>>> 	__aligned_u64 pidfd;
>>>>>>> 	__aligned_u64 child_tid;
>>>>>>> 	__aligned_u64 parent_tid;
>>>>>>> 	__aligned_u64 exit_signal;
>>>>>>> 	__aligned_u64 stack;
>>>>>>> 	__aligned_u64 stack_size;
>>>>>>> 	__aligned_u64 tls;
>>>>>>> 	__aligned_u64 set_tid;
>>>>>>> 	__aligned_u64 set_tid_size;
>>>>>>> 	__aligned_u64 namespaces;
>>>>>>> 	__aligned_u64 namespaces_size;
>>>>>>> };
>>>>>>>
>>>>>>> Then when we end up adding id mapping support for CLONE_NEWUSER we can
>>>>>>> extend this with:
>>>>>>>
>>>>>>> struct {
>>>>>>> 	struct {
>>>>>>> 		__aligned_u64 monotonic;
>>>>>>> 		__aligned_u64 boot;
>>>>>
>>>>> s/__aligned_u64/__s64/g
>>>>>
>>>>> Sorry, leftover from my first draft.
>>>>>
>>>>>>> 	} time;
>>>>>>>
>>>>>>> 	struct {
>>>>>>> 		/* id mapping members */
>>>>>>> 	} user;
>>>>>>> } namespaces;
>>>>>>>
>>>>>>> Thoughts? Other ideas?
>>>>>>
>>>>>> Works for me.
>>>>>>
>>>>>> If we add the user namespace id mappings and then at some point a third
>>>>>> element for the time namespace appears it would also start to be mixed.
>>>>>> Just as you mentioned that a few mails ago.
>>>>>
>>>>> I think you misunderstand me or I'm misunderstanding you. That new time
>>>>> namespace member would go into struct time {} so
>>>>>
>>>>> struct {
>>>>> 	struct {
>>>>> 		__s64 monotonic;
>>>>> 		__s64 boot;
>>>>> 		__s64 someothertime;
>>>>> 	} time;
>>>>>
>>>>> 	struct {
>>>>> 		/* id mapping members */
>>>>> 	} user;
>>>>> } namespaces;
>>
>> So far, this seems like the least worst approach to me :-).
>>
>> I think it's reasonable to assume that there will be another
>> time NS offset to add one day. I don't think anyone expected
>> CLOCK_BOOTIME (added in 2011) at the time that CLOCK_MONOTONIC
>> appeared (as part of the POSIX timers API in Linux 2.6.0 2003);
>> similarly, we probably can't conceive now what clock might be
>> added in the future that should also be governed by time
>> namespaces.
>>
>>
>> But...
>>
>>>> My question was about how does the kernel know how 'struct namespaces'
>>>> is structured. How can an older kernel (which only is aware of two
>>>> clocks) deal with a, like in this example, third clock. Will the size
>>>> '__aligned_u64 namespaces_size' be used for versioning?
>>>
>>> Yes, that would be the idea.
>>
>> The idea implied here (if I understand correctly) of "binary chop
>> on the structure size to see what your kernel supports" is pretty
>> clunky, IMO. It's worth at least considering alternatives. 
>> For example, seccomp has a number of interesting interfaces to
>> discover what the running kernel supports [1]. Maybe it is worth
>> considering something similar for clone3()?
> 
> Yes, that's definitely something I've been thinking about and I've also
> discussed this publicly on the libc-alpha mailing list since Florian
> (Weimer) wants this for glibc. _But_ I didn't want to simply go my own
> way and so Aleksa and I stuck our heads together and tried to come up
> with a generic way that e.g. would work for both openat2() and for
> clone3(), in fact we tried to come up with a generic way that could
> potentially be used by any syscall that makes use of the new
> copy_struct_from_user() helper that Aleksa and I pushed upstream. We
> haven't yet gotten around to actually try and implementing our ideas.
> I'll try to get around to this during this cycle (/me makes note to "sit
> down" with Aleksa). We'll definitely take a look at seccomp and cgroups
> too.

Great! Thanks for thinking about this. Just by the way, on 
discussions such as the one you had with Florian, it would
be great if you CCed linux-api@ (and also for the patch series
that implements this idea).

Cheers,

Michael

-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/

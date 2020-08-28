Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFAD525613B
	for <lists+linux-api@lfdr.de>; Fri, 28 Aug 2020 21:27:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726197AbgH1T1G (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 28 Aug 2020 15:27:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725969AbgH1T1D (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 28 Aug 2020 15:27:03 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C5C4C06121B
        for <linux-api@vger.kernel.org>; Fri, 28 Aug 2020 12:27:02 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id h2so147694plr.0
        for <linux-api@vger.kernel.org>; Fri, 28 Aug 2020 12:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8vIVYyejCvH3/8OP761KZEsC4sBaI8JTbXZbD1JlWpo=;
        b=GlJS/QRqiByLAShtMbzuUct2M9gay1V0uz4R9A09slQFWVVYwSZJ6zlabHI0KWVx9e
         nqbcfnP6qUg4jvkfHc/xC3YATRYUsG50g4OWlP1cBvyoSMNaaIIBnGuCv+GBVdlnobxI
         Y87KhbGz6ZrcKMnsdCSJfVaFb5jGkoIDfg1KSFPkiY9lUx9sEkDmlT8Mc/Eekov+TVdj
         TWE+tjcipWNf+82AgW23Wzbm40QgmK5R3iuqWXnLz3sHzSJQAPvN92Xf0nPodwiP6OPO
         /MMw8od2kyGk3FeiWkxNioZ+IsA3bb+1h/1cA2tBt6wM0UYsT8fYrPomV4/bu90h2fFt
         pxbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8vIVYyejCvH3/8OP761KZEsC4sBaI8JTbXZbD1JlWpo=;
        b=skTERfm3G4Jp7Ww3lb0QN/HrfnHcPFh7iL4+8JeLo99Q7GXmaszmNk9EKI3wIavPpH
         fpVO0B46rccI9S8z6blo+53bgM5B6VQ76C4h4vHCrYxPLdV1V3ECpBiGsel822bD89RB
         IMrHyCIKpuy0Lu8Ih1sNzru4LlJshosacPO5YXC7kAix0iiO+C7jwYrIGaYUD9BU3jur
         cTZ3qCQvjVsE/F0Ks62yz2Xno5CjtRQzBV+0BcP2XvApVo27GrHiRPwFONU5cFa0CG8q
         /gS8E+8OvTCzibVJjZbSpp9ndg4A0KQXwcigDczltF8lo2J/gxQPHY/nyjPNp1tNzT+w
         zkAA==
X-Gm-Message-State: AOAM532YCaTQEwYoR4TikBGo0SVb8K+yibvLixHNVmFc443BfyDHlvUQ
        WKfsm2RgZZtiid+Z8YANTpEnnQ==
X-Google-Smtp-Source: ABdhPJw6mZFQTyi9pnaI+cDWyDa0+6Uj81NRhZZ9JJWrD1rA541KiRJbm6Xz/kzNaXTGrVZZd+4Grg==
X-Received: by 2002:a17:90a:4f0e:: with SMTP id p14mr460692pjh.31.1598642822331;
        Fri, 28 Aug 2020 12:27:02 -0700 (PDT)
Received: from [192.168.1.182] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id x5sm211319pfj.1.2020.08.28.12.26.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Aug 2020 12:27:01 -0700 (PDT)
Subject: Re: [PATCH v8 3/4] mm/madvise: introduce process_madvise() syscall:
 an external memory hinting API
From:   Jens Axboe <axboe@kernel.dk>
To:     Arnd Bergmann <arnd@arndb.de>, Minchan Kim <minchan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        linux-mm <linux-mm@kvack.org>,
        Linux API <linux-api@vger.kernel.org>,
        Oleksandr Natalenko <oleksandr@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Tim Murray <timmurray@google.com>,
        Sandeep Patil <sspatil@google.com>,
        Sonny Rao <sonnyrao@google.com>,
        Brian Geffon <bgeffon@google.com>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        John Dias <joaodias@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Jann Horn <jannh@google.com>,
        alexander.h.duyck@linux.intel.com,
        SeongJae Park <sj38.park@gmail.com>,
        David Rientjes <rientjes@google.com>,
        Arjun Roy <arjunroy@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Christian Brauner <christian@brauner.io>,
        Daniel Colascione <dancol@google.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        SeongJae Park <sjpark@amazon.de>,
        linux-man <linux-man@vger.kernel.org>
References: <20200622192900.22757-1-minchan@kernel.org>
 <20200622192900.22757-4-minchan@kernel.org>
 <CAK8P3a0Mnp2ekmX-BX9yr+N8fy2=gBtASELLXoa9uGSpSS9aOA@mail.gmail.com>
 <9c339413-68c7-344e-dd01-327cb988d385@kernel.dk>
Message-ID: <ffe549f6-bed5-07f9-43a7-ec8cc12ab59d@kernel.dk>
Date:   Fri, 28 Aug 2020 13:26:58 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <9c339413-68c7-344e-dd01-327cb988d385@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 8/28/20 12:24 PM, Jens Axboe wrote:
> On 8/28/20 11:40 AM, Arnd Bergmann wrote:
>> On Mon, Jun 22, 2020 at 9:29 PM Minchan Kim <minchan@kernel.org> wrote:
>>> So finally, the API is as follows,
>>>
>>>      ssize_t process_madvise(int pidfd, const struct iovec *iovec,
>>>                unsigned long vlen, int advice, unsigned int flags);
>>
>> I had not followed the discussion earlier and only now came across
>> the syscall in linux-next, sorry for stirring things up this late.
>>
>>> diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
>>> index 94bf4958d114..8f959d90338a 100644
>>> --- a/arch/x86/entry/syscalls/syscall_64.tbl
>>> +++ b/arch/x86/entry/syscalls/syscall_64.tbl
>>> @@ -364,6 +364,7 @@
>>>  440    common  watch_mount             sys_watch_mount
>>>  441    common  watch_sb                sys_watch_sb
>>>  442    common  fsinfo                  sys_fsinfo
>>> +443    64      process_madvise         sys_process_madvise
>>>
>>>  #
>>>  # x32-specific system call numbers start at 512 to avoid cache impact
>>> @@ -407,3 +408,4 @@
>>>  545    x32     execveat                compat_sys_execveat
>>>  546    x32     preadv2                 compat_sys_preadv64v2
>>>  547    x32     pwritev2                compat_sys_pwritev64v2
>>> +548    x32     process_madvise         compat_sys_process_madvise
>>
>> I think we should not add any new x32-specific syscalls. Instead I think
>> the compat_sys_process_madvise/sys_process_madvise can be
>> merged into one.
>>
>>> +       mm = mm_access(task, PTRACE_MODE_ATTACH_FSCREDS);
>>> +       if (IS_ERR_OR_NULL(mm)) {
>>> +               ret = IS_ERR(mm) ? PTR_ERR(mm) : -ESRCH;
>>> +               goto release_task;
>>> +       }
>>
>> Minor point: Having to use IS_ERR_OR_NULL() tends to be fragile,
>> and I would try to avoid that. Can mm_access() be changed to
>> itself return PTR_ERR(-ESRCH) instead of NULL to improve its
>> calling conventions? I see there are only three other callers.
>>
>>
>>> +       ret = import_iovec(READ, vec, vlen, ARRAY_SIZE(iovstack), &iov, &iter);
>>> +       if (ret >= 0) {
>>> +               ret = do_process_madvise(pidfd, &iter, behavior, flags);
>>> +               kfree(iov);
>>> +       }
>>> +       return ret;
>>> +}
>>> +
>>> +#ifdef CONFIG_COMPAT
>> ...
>>> +
>>> +       ret = compat_import_iovec(READ, vec, vlen, ARRAY_SIZE(iovstack),
>>> +                               &iov, &iter);
>>> +       if (ret >= 0) {
>>> +               ret = do_process_madvise(pidfd, &iter, behavior, flags);
>>> +               kfree(iov);
>>> +       }
>>
>> Every syscall that passes an iovec seems to do this. If we make import_iovec()
>> handle both cases directly, this syscall and a number of others can
>> be simplified, and you avoid the x32 entry point I mentioned above
>>
>> Something like (untested)
>>
>> index dad8d0cfaaf7..0de4ddff24c1 100644
>> --- a/lib/iov_iter.c
>> +++ b/lib/iov_iter.c
>> @@ -1683,8 +1683,13 @@ ssize_t import_iovec(int type, const struct
>> iovec __user * uvector,
>>  {
>>         ssize_t n;
>>         struct iovec *p;
>> -       n = rw_copy_check_uvector(type, uvector, nr_segs, fast_segs,
>> -                                 *iov, &p);
>> +
>> +       if (in_compat_syscall())
>> +               n = compat_rw_copy_check_uvector(type, uvector, nr_segs,
>> +                                                fast_segs, *iov, &p);
>> +       else
>> +               n = rw_copy_check_uvector(type, uvector, nr_segs,
>> +                                         fast_segs, *iov, &p);
>>         if (n < 0) {
>>                 if (p != *iov)
>>                         kfree(p);
> 
> Doesn't work for the async case, where you want to be holding on to the
> allocated iovec. But in general I think it's a good helper for the sync
> case, which is by far the majority.

Nevermind, I'm an idiot for reading this totally wrong.

-- 
Jens Axboe


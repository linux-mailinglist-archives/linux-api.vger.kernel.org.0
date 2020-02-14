Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90AD715F49F
	for <lists+linux-api@lfdr.de>; Fri, 14 Feb 2020 19:24:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394902AbgBNSWM (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 14 Feb 2020 13:22:12 -0500
Received: from mail-il1-f195.google.com ([209.85.166.195]:42814 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394897AbgBNSWL (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 14 Feb 2020 13:22:11 -0500
Received: by mail-il1-f195.google.com with SMTP id x2so26930ila.9
        for <linux-api@vger.kernel.org>; Fri, 14 Feb 2020 10:22:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8qwb+lRTuOpes8xtaV7AKCv3PBGORM2BmFGpjI+nmpE=;
        b=t2X1vD6b4vzcyYKeWXV148o4eFIVd6WZxhJItit3wq0vnRe4HvYJfLkKUtMgcWQ31G
         VRLaorGbSK79Vevj9soE5iVXOq4dndvM/jy6LXriqeIR7wVc/V5sh+kCLYL1dMz/FMhh
         0ByPRUiwxDqlk832uRr5+d8IQC4TmpXV+IZFWMs4hE01jDeDKdDVdeQK/w7TuEU1idTX
         iNNKPQ1lBKOnsHbI5uk29dUPX5LUlBNqubasFicW8i16gcKFyEAoLmyVtUsr428vyzqF
         /RMsqtg+N7J7QD6XXBHChqF8QBdXyN+kV/9a+dLg2xoDdjk8SOqUqj1rZ8GAkQtUoar1
         7MbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8qwb+lRTuOpes8xtaV7AKCv3PBGORM2BmFGpjI+nmpE=;
        b=DdQ8FNkV3bephIVbNvdMkj0ap/jhwa2CG2n//Zlb4lRQk+2kn1Ez+Gk05kPqQGI59Y
         r1cieRs2J4bL0qHvWH+e38WbJHh7A+a7XjORevOR8ZCN4+EzeOLxWx7FkjA4x8/DqoC8
         Qrk4yh4iWeryvbCxi5GIL7xXck39FHSXCYOSc/KkU22mDH5Fpln3ris/XxmGmcaU89Nw
         sEq70GJfDRNbxB3D9jFXdWjnajkuDqLVcTq0bopMWeZqAztsqnTpc3FNHwyrx3gTLTx9
         VFfgJ40+7RhNt8qDpzRT+gvZ+Ckb+Lvw/8MFcIWW5t5VRHmnAD0Ho31zatRA25FhwgRR
         Tsyw==
X-Gm-Message-State: APjAAAXzLdawW5CIv9J4soHK1tE9q+FcBo0NNBHChasLBiYy1gSEW5vZ
        LTJ8aLHhcgFNxW05Ml8ZVcX4MVxIKvI=
X-Google-Smtp-Source: APXvYqzvncynTCDmYylq3A4KCMdXhy5MVQ9TmDi4HIhCpbFZz8Z/rnYpRK1Wy38BVNpmc/kvq8GaTg==
X-Received: by 2002:a92:b68a:: with SMTP id m10mr4384218ill.255.1581704530319;
        Fri, 14 Feb 2020 10:22:10 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id j17sm2230109ild.45.2020.02.14.10.22.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Feb 2020 10:22:09 -0800 (PST)
Subject: Re: [PATCH v5 1/7] mm: pass task and mm to do_madvise
To:     Jann Horn <jannh@google.com>, Minchan Kim <minchan@kernel.org>,
        io-uring <io-uring@vger.kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Linux API <linux-api@vger.kernel.org>,
        Oleksandr Natalenko <oleksandr@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Tim Murray <timmurray@google.com>,
        Daniel Colascione <dancol@google.com>,
        Sandeep Patil <sspatil@google.com>,
        Sonny Rao <sonnyrao@google.com>,
        Brian Geffon <bgeffon@google.com>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        John Dias <joaodias@google.com>,
        Joel Fernandes <joel@joelfernandes.org>, sj38.park@gmail.com,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>
References: <20200214170520.160271-1-minchan@kernel.org>
 <20200214170520.160271-2-minchan@kernel.org>
 <CAG48ez3S5+EasZ1ZWcMQYZQQ5zJOBtY-_C7oz6DMfG4Gcyig1g@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <68044a15-6a31-e432-3105-f2f1af9f4b74@kernel.dk>
Date:   Fri, 14 Feb 2020 11:22:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAG48ez3S5+EasZ1ZWcMQYZQQ5zJOBtY-_C7oz6DMfG4Gcyig1g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 2/14/20 10:25 AM, Jann Horn wrote:
> +Jens and io-uring list
> 
> On Fri, Feb 14, 2020 at 6:06 PM Minchan Kim <minchan@kernel.org> wrote:
>> In upcoming patches, do_madvise will be called from external process
>> context so we shouldn't asssume "current" is always hinted process's
>> task_struct.
> [...]
>> [1] http://lore.kernel.org/r/CAG48ez27=pwm5m_N_988xT1huO7g7h6arTQL44zev6TD-h-7Tg@mail.gmail.com
> [...]
>> diff --git a/fs/io_uring.c b/fs/io_uring.c
> [...]
>> @@ -2736,7 +2736,7 @@ static int io_madvise(struct io_kiocb *req, struct io_kiocb **nxt,
>>         if (force_nonblock)
>>                 return -EAGAIN;
>>
>> -       ret = do_madvise(ma->addr, ma->len, ma->advice);
>> +       ret = do_madvise(current, current->mm, ma->addr, ma->len, ma->advice);
>>         if (ret < 0)
>>                 req_set_fail_links(req);
>>         io_cqring_add_event(req, ret);
> 
> Jens, can you have a look at this change and the following patch
> <https://lore.kernel.org/linux-mm/20200214170520.160271-4-minchan@kernel.org/>
> ("[PATCH v5 3/7] mm: check fatal signal pending of target process")?
> Basically Minchan's patch tries to plumb through the identity of the
> target task so that if that task gets killed in the middle of the
> operation, the (potentially long-running and costly) madvise operation
> can be cancelled. Just passing in "current" instead (which in this
> case is the uring worker thread AFAIK) doesn't really break anything,
> other than making the optimization not work, but I wonder whether this
> couldn't be done more cleanly - maybe by passing in NULL to mean "we
> don't know who the target task is", since I think we don't know that
> here?

Thanks for bringing this to my attention, patches that touch io_uring
(or anything else) really should be CC'ed to the maintainer(s) of those
areas...

Yeah, the change above won't do the right thing for io_uring, in fact
it'll always be the wrong task. So I'd second Jann's question, and ask
if we really need the actual task, or if NULL could be used? For
cancelation purposes, I'm guessing you want the task that's actually
doing the operation, even if it's on behalf of someone else. That makes
the interface a bit weird, as you'd assume the task/mm passed in would
be related to the madvise itself, not just for cancelation.

Would be nice with some clarification, so we can figure out an approach
that would actually work.

-- 
Jens Axboe


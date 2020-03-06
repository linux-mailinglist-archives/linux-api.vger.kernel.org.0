Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE38117C265
	for <lists+linux-api@lfdr.de>; Fri,  6 Mar 2020 17:03:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726368AbgCFQDy (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 6 Mar 2020 11:03:54 -0500
Received: from mx2.suse.de ([195.135.220.15]:40886 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725935AbgCFQDy (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Fri, 6 Mar 2020 11:03:54 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id CF114B1F3;
        Fri,  6 Mar 2020 16:03:51 +0000 (UTC)
Subject: Re: [PATCH v7 6/7] mm/madvise: employ mmget_still_valid for write
 lock
To:     Oleksandr Natalenko <oleksandr@redhat.com>
Cc:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, linux-api@vger.kernel.org,
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
        Joel Fernandes <joel@joelfernandes.org>,
        Jann Horn <jannh@google.com>,
        alexander.h.duyck@linux.intel.com, sj38.park@gmail.com
References: <20200302193630.68771-1-minchan@kernel.org>
 <20200302193630.68771-7-minchan@kernel.org>
 <d21c85b2-2493-e538-5419-79cf049a469e@suse.cz>
 <20200306130303.kztv64f52qknxb6k@butterfly.localdomain>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <86fc8d7b-ad6b-1691-b022-025d01e9e8e3@suse.cz>
Date:   Fri, 6 Mar 2020 17:03:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200306130303.kztv64f52qknxb6k@butterfly.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 3/6/20 2:03 PM, Oleksandr Natalenko wrote:
> Hello.
> 
> On Fri, Mar 06, 2020 at 01:52:07PM +0100, Vlastimil Babka wrote:
>> > diff --git a/mm/madvise.c b/mm/madvise.c
>> > index e794367f681e..e77c6c1fad34 100644
>> > --- a/mm/madvise.c
>> > +++ b/mm/madvise.c
>> > @@ -1118,6 +1118,8 @@ int do_madvise(struct task_struct *target_task, struct mm_struct *mm,
>> >  	if (write) {
>> >  		if (down_write_killable(&mm->mmap_sem))
>> >  			return -EINTR;
>> > +		if (current->mm != mm && !mmget_still_valid(mm))
>> > +			goto skip_mm;
>> 
>> This will return 0, is that correct? Shoudln't there be a similar error e.g. as
>> when finding the task by pid fails (-ESRCH ?), because IIUC the task here is
>> going away and dumping the core?
> 
> Yeah.
> 
> Something like this then:
> 
> ===
> diff --git a/mm/madvise.c b/mm/madvise.c
> index 48d1da08c160..7ed2f4d13924 100644
> --- a/mm/madvise.c
> +++ b/mm/madvise.c
> @@ -1122,6 +1122,10 @@ int do_madvise(struct task_struct *target_task, struct mm_struct *mm,
>  	if (write) {
>  		if (down_write_killable(&mm->mmap_sem))
>  			return -EINTR;
> +		if (current->mm != mm && !mmget_still_valid(mm)) {
> +			error = -ESRCH;
> +			goto skip_mm;
> +		}
>  	} else {
>  		down_read(&mm->mmap_sem);
>  	}
> @@ -1173,6 +1177,7 @@ int do_madvise(struct task_struct *target_task, struct mm_struct *mm,
>  	}
>  out:
>  	blk_finish_plug(&plug);
> +skip_mm:
>  	if (write)
>  		up_write(&mm->mmap_sem);
>  	else
> 
> ===
> 
> ?

Yep, thanks.

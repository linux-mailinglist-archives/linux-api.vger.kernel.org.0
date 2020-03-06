Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 32BAF17BD46
	for <lists+linux-api@lfdr.de>; Fri,  6 Mar 2020 13:52:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726194AbgCFMwN (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 6 Mar 2020 07:52:13 -0500
Received: from mx2.suse.de ([195.135.220.15]:59298 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726171AbgCFMwN (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Fri, 6 Mar 2020 07:52:13 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 5C2F3B138;
        Fri,  6 Mar 2020 12:52:10 +0000 (UTC)
Subject: Re: [PATCH v7 6/7] mm/madvise: employ mmget_still_valid for write
 lock
To:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
        linux-api@vger.kernel.org, oleksandr@redhat.com,
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
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <d21c85b2-2493-e538-5419-79cf049a469e@suse.cz>
Date:   Fri, 6 Mar 2020 13:52:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200302193630.68771-7-minchan@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 3/2/20 8:36 PM, Minchan Kim wrote:
> From: Oleksandr Natalenko <oleksandr@redhat.com>
> 
> Do the very same trick as we already do since 04f5866e41fb. KSM hints
> will require locking mmap_sem for write since they modify vm_flags, so
> for remote KSM hinting this additional check is needed.
> 
> Reviewed-by: Suren Baghdasaryan <surenb@google.com>
> Signed-off-by: Oleksandr Natalenko <oleksandr@redhat.com>
> Signed-off-by: Minchan Kim <minchan@kernel.org>
> ---
>  mm/madvise.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/mm/madvise.c b/mm/madvise.c
> index e794367f681e..e77c6c1fad34 100644
> --- a/mm/madvise.c
> +++ b/mm/madvise.c
> @@ -1118,6 +1118,8 @@ int do_madvise(struct task_struct *target_task, struct mm_struct *mm,
>  	if (write) {
>  		if (down_write_killable(&mm->mmap_sem))
>  			return -EINTR;
> +		if (current->mm != mm && !mmget_still_valid(mm))
> +			goto skip_mm;

This will return 0, is that correct? Shoudln't there be a similar error e.g. as
when finding the task by pid fails (-ESRCH ?), because IIUC the task here is
going away and dumping the core?

>  	} else {
>  		down_read(&mm->mmap_sem);
>  	}
> @@ -1169,6 +1171,7 @@ int do_madvise(struct task_struct *target_task, struct mm_struct *mm,
>  	}
>  out:
>  	blk_finish_plug(&plug);
> +skip_mm:
>  	if (write)
>  		up_write(&mm->mmap_sem);
>  	else
> 


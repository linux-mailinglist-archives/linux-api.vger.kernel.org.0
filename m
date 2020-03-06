Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D1EF417C292
	for <lists+linux-api@lfdr.de>; Fri,  6 Mar 2020 17:08:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbgCFQIW (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 6 Mar 2020 11:08:22 -0500
Received: from mx2.suse.de ([195.135.220.15]:43728 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726738AbgCFQIV (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Fri, 6 Mar 2020 11:08:21 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 10064ADC8;
        Fri,  6 Mar 2020 16:08:19 +0000 (UTC)
Subject: Re: [PATCH v7 7/7] mm/madvise: allow KSM hints for remote API
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
        alexander.h.duyck@linux.intel.com, sj38.park@gmail.com,
        SeongJae Park <sjpark@amazon.de>
References: <20200302193630.68771-1-minchan@kernel.org>
 <20200302193630.68771-8-minchan@kernel.org>
 <2a66abd8-4103-f11b-06d1-07762667eee6@suse.cz>
 <20200306134146.mqiyvsdnqty7so53@butterfly.localdomain>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <a63768c1-3959-563b-376b-1d8d90d79b41@suse.cz>
Date:   Fri, 6 Mar 2020 17:08:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200306134146.mqiyvsdnqty7so53@butterfly.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 3/6/20 2:41 PM, Oleksandr Natalenko wrote:
> On Fri, Mar 06, 2020 at 02:13:49PM +0100, Vlastimil Babka wrote:
>> On 3/2/20 8:36 PM, Minchan Kim wrote:
>> > From: Oleksandr Natalenko <oleksandr@redhat.com>
>> > 
>> > It all began with the fact that KSM works only on memory that is marked
>> > by madvise(). And the only way to get around that is to either:
>> > 
>> >   * use LD_PRELOAD; or
>> >   * patch the kernel with something like UKSM or PKSM.
>> > 
>> > (i skip ptrace can of worms here intentionally)
>> > 
>> > To overcome this restriction, lets employ a new remote madvise API. This
>> > can be used by some small userspace helper daemon that will do auto-KSM
>> > job for us.
>> > 
>> > I think of two major consumers of remote KSM hints:
>> > 
>> >   * hosts, that run containers, especially similar ones and especially in
>> >     a trusted environment, sharing the same runtime like Node.js;

Ah, I forgot to ask, given the discussion of races in patch 2 (Question 2),
where android can stop the tasks to apply the madvise hints in a race-free
manner, how does that work for remote KSM hints in your scenarios, especially
the one above?

>> > 
>> >   * heavy applications, that can be run in multiple instances, not
>> >     limited to opensource ones like Firefox, but also those that cannot be
>> >     modified since they are binary-only and, maybe, statically linked.
>> > 
>> > Speaking of statistics, more numbers can be found in the very first
>> > submission, that is related to this one [1]. For my current setup with
>> > two Firefox instances I get 100 to 200 MiB saved for the second instance
>> > depending on the amount of tabs.
>> > 
>> > 1 FF instance with 15 tabs:
>> > 
>> >    $ echo "$(cat /sys/kernel/mm/ksm/pages_sharing) * 4 / 1024" | bc
>> >    410
>> > 
>> > 2 FF instances, second one has 12 tabs (all the tabs are different):
>> > 
>> >    $ echo "$(cat /sys/kernel/mm/ksm/pages_sharing) * 4 / 1024" | bc
>> >    592
>> > 
>> > At the very moment I do not have specific numbers for containerised
>> > workload, but those should be comparable in case the containers share
>> > similar/same runtime.
>> > 
>> > [1] https://lore.kernel.org/patchwork/patch/1012142/
>> > 
>> > Reviewed-by: SeongJae Park <sjpark@amazon.de>
>> > Signed-off-by: Oleksandr Natalenko <oleksandr@redhat.com>
>> > Signed-off-by: Minchan Kim <minchan@kernel.org>
>> 
>> This will lead to one process calling unmerge_ksm_pages() of another. There's a
>> (signal_pending(current)) test there, should it check also the other task,
>> analogically to task 3?
> 
> Do we care about current there then? Shall we just pass mm into unmerge_ksm_pages and check the signals of the target task only, be it current or something else?

Dunno, it's nice to react to signals quickly, for any proces that gets them, no?

>> Then break_ksm() is fine as it is, as ksmd also calls it, right?
> 
> I think break_ksm() cares only about mmap_sem protection, so we should
> be fine here.
> 
>> 
>> > ---
>> >  mm/madvise.c | 4 ++++
>> >  1 file changed, 4 insertions(+)
>> > 
>> > diff --git a/mm/madvise.c b/mm/madvise.c
>> > index e77c6c1fad34..f4fa962ee74d 100644
>> > --- a/mm/madvise.c
>> > +++ b/mm/madvise.c
>> > @@ -1005,6 +1005,10 @@ process_madvise_behavior_valid(int behavior)
>> >  	switch (behavior) {
>> >  	case MADV_COLD:
>> >  	case MADV_PAGEOUT:
>> > +#ifdef CONFIG_KSM
>> > +	case MADV_MERGEABLE:
>> > +	case MADV_UNMERGEABLE:
>> > +#endif
>> >  		return true;
>> >  	default:
>> >  		return false;
>> > 
>> 
> 


Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E30D117E3D8
	for <lists+linux-api@lfdr.de>; Mon,  9 Mar 2020 16:42:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726866AbgCIPmy (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 9 Mar 2020 11:42:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:39340 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726804AbgCIPmx (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Mon, 9 Mar 2020 11:42:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id C77DDAD07;
        Mon,  9 Mar 2020 15:42:51 +0000 (UTC)
Subject: Re: [PATCH v7 7/7] mm/madvise: allow KSM hints for remote API
To:     Oleksandr Natalenko <oleksandr@redhat.com>,
        Michal Hocko <mhocko@kernel.org>
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
 <a63768c1-3959-563b-376b-1d8d90d79b41@suse.cz>
 <20200309131117.anvyjszaigpoz2kp@butterfly.localdomain>
 <20200309150815.GR8447@dhcp22.suse.cz>
 <20200309151932.6sjwq6bucbu6zsea@butterfly.localdomain>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <34f812b8-df54-eaad-5cf0-335f07da55c6@suse.cz>
Date:   Mon, 9 Mar 2020 16:42:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200309151932.6sjwq6bucbu6zsea@butterfly.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 3/9/20 4:19 PM, Oleksandr Natalenko wrote:
> On Mon, Mar 09, 2020 at 04:08:15PM +0100, Michal Hocko wrote:
>> On Mon 09-03-20 14:11:17, Oleksandr Natalenko wrote:
>> > On Fri, Mar 06, 2020 at 05:08:18PM +0100, Vlastimil Babka wrote:
>> [...]
>> > > Dunno, it's nice to react to signals quickly, for any proces that gets them, no?
>> > 
>> > So, do you mean something like this?
>> > 
>> > ===
>> > diff --git a/mm/ksm.c b/mm/ksm.c
>> > index 363ec8189561..b39c237cfcf4 100644
>> > --- a/mm/ksm.c
>> > +++ b/mm/ksm.c
>> > @@ -849,7 +849,8 @@ static int unmerge_ksm_pages(struct vm_area_struct *vma,
>> >  	for (addr = start; addr < end && !err; addr += PAGE_SIZE) {
>> >  		if (ksm_test_exit(vma->vm_mm))
>> >  			break;
>> > -		if (signal_pending(current))
>> > +		if (signal_pending(current) ||
>> > +		    signal_pending(rcu_dereference(vma->vm_mm->owner)))
>> >  			err = -ERESTARTSYS;
>> >  		else
>> >  			err = break_ksm(vma, addr);
>> > ===
>> 
>> This is broken because mm might be attached to different tasks.
>> AFAIU this check is meant to allow quick backoff of the _calling_
>> process so that it doesn't waste time when the context is killed
>> already. I do not understand why should we care about any other context
>> here? What is the actual problem this would solve?
> 
> I agree with you, but still trying to understand what does Vlastimil mean
> :).

Well you wondered if we should stop caring about current, and I said that
probably wouldn't be nice.
As for caring about the other task, patch 3/7 does that for
(MADV_COLD|MADV_PAGEOUT) so I just pointed out that the KSM case doesn't. AFAIU
if we don't check the signals, we might be blocking the killed task from exiting?

>> 
>> -- 
>> Michal Hocko
>> SUSE Labs
>> 
> 


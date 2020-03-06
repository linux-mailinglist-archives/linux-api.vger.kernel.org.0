Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD73F17BF58
	for <lists+linux-api@lfdr.de>; Fri,  6 Mar 2020 14:41:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbgCFNlx (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 6 Mar 2020 08:41:53 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:28592 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726498AbgCFNlx (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 6 Mar 2020 08:41:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583502112;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IEMTcz44qXHTvt90A4c5VFOdWnApL2YdhivNGIEppTM=;
        b=G2t9qaDew01uHLoN99L/nWH/WmfEG/Tu20WnyLldLeacxskqR6P/x0NkxCM2aV3NDl/Cuq
        7GNGlhV5L9HvGDTJYbrHmaxDAxjSZ34sfMgLk7cxgKO9/YZDRUTlIc273WqpNR812mz7q9
        OKuf+GEjGvOcUJRv4UFSXf52KVS7tv0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-177-YW4QQKfaNUi5NlQD1Ph-CA-1; Fri, 06 Mar 2020 08:41:49 -0500
X-MC-Unique: YW4QQKfaNUi5NlQD1Ph-CA-1
Received: by mail-wm1-f72.google.com with SMTP id w3so648399wmg.4
        for <linux-api@vger.kernel.org>; Fri, 06 Mar 2020 05:41:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IEMTcz44qXHTvt90A4c5VFOdWnApL2YdhivNGIEppTM=;
        b=TMJ8L42JM3CH7CeLd/TyHP19IDCSF92rIfjDdwevI8GC4OH8HbUWN6BHfRsHm+OkII
         WGsXAnYVNps6MYMCLPlvOGPutw9S6XNcY3BVg3dx4z36ycttjtrTu3ee80A1oKmlgDIy
         3RXu3Zia+WYoWVIYyYe6+1XtURkyDbo8VYiatBJX3buTvFw8NLmQpfS+Pj/5Df0tzjw5
         uXq7v4O2nBB1Rf8lVL+3HG8sVny4Lk8jAqWQMTMrNHgvZS+AztDVdjyWyJcMQ1aBVZXs
         hR4SwVGwSH+5VK/tHxKakya0jC3Y//0yLTIRea2kPvAPMeg8Djq7UOmJLmxW3kULar0R
         v0Pw==
X-Gm-Message-State: ANhLgQ14eiPs5Qg+AkWnoTYRkzwtyP2An1nqB5QmgoDbFJwA97U7nxyF
        35mmgZWOlD1zj0MrTgqEcb310iBYMYNdV7UcMRY3+CiNZKq8lYpfLuk6ry1cGEJJntqlaLJ/sMZ
        e8LWQ/5WMBKj5RvGeMUD9
X-Received: by 2002:a05:6000:8f:: with SMTP id m15mr3969853wrx.378.1583502107829;
        Fri, 06 Mar 2020 05:41:47 -0800 (PST)
X-Google-Smtp-Source: ADFU+vudibnT4plTiR2nZQMFqrEAK+dvcF740xf/jWy6W7N3p01s46FIR4Rp6M3hJC+gN4drevJpkA==
X-Received: by 2002:a05:6000:8f:: with SMTP id m15mr3969818wrx.378.1583502107595;
        Fri, 06 Mar 2020 05:41:47 -0800 (PST)
Received: from localhost ([2001:470:5b39:28:1273:be38:bc73:5c36])
        by smtp.gmail.com with ESMTPSA id w9sm10573301wrn.35.2020.03.06.05.41.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2020 05:41:46 -0800 (PST)
Date:   Fri, 6 Mar 2020 14:41:46 +0100
From:   Oleksandr Natalenko <oleksandr@redhat.com>
To:     Vlastimil Babka <vbabka@suse.cz>
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
Subject: Re: [PATCH v7 7/7] mm/madvise: allow KSM hints for remote API
Message-ID: <20200306134146.mqiyvsdnqty7so53@butterfly.localdomain>
References: <20200302193630.68771-1-minchan@kernel.org>
 <20200302193630.68771-8-minchan@kernel.org>
 <2a66abd8-4103-f11b-06d1-07762667eee6@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2a66abd8-4103-f11b-06d1-07762667eee6@suse.cz>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, Mar 06, 2020 at 02:13:49PM +0100, Vlastimil Babka wrote:
> On 3/2/20 8:36 PM, Minchan Kim wrote:
> > From: Oleksandr Natalenko <oleksandr@redhat.com>
> > 
> > It all began with the fact that KSM works only on memory that is marked
> > by madvise(). And the only way to get around that is to either:
> > 
> >   * use LD_PRELOAD; or
> >   * patch the kernel with something like UKSM or PKSM.
> > 
> > (i skip ptrace can of worms here intentionally)
> > 
> > To overcome this restriction, lets employ a new remote madvise API. This
> > can be used by some small userspace helper daemon that will do auto-KSM
> > job for us.
> > 
> > I think of two major consumers of remote KSM hints:
> > 
> >   * hosts, that run containers, especially similar ones and especially in
> >     a trusted environment, sharing the same runtime like Node.js;
> > 
> >   * heavy applications, that can be run in multiple instances, not
> >     limited to opensource ones like Firefox, but also those that cannot be
> >     modified since they are binary-only and, maybe, statically linked.
> > 
> > Speaking of statistics, more numbers can be found in the very first
> > submission, that is related to this one [1]. For my current setup with
> > two Firefox instances I get 100 to 200 MiB saved for the second instance
> > depending on the amount of tabs.
> > 
> > 1 FF instance with 15 tabs:
> > 
> >    $ echo "$(cat /sys/kernel/mm/ksm/pages_sharing) * 4 / 1024" | bc
> >    410
> > 
> > 2 FF instances, second one has 12 tabs (all the tabs are different):
> > 
> >    $ echo "$(cat /sys/kernel/mm/ksm/pages_sharing) * 4 / 1024" | bc
> >    592
> > 
> > At the very moment I do not have specific numbers for containerised
> > workload, but those should be comparable in case the containers share
> > similar/same runtime.
> > 
> > [1] https://lore.kernel.org/patchwork/patch/1012142/
> > 
> > Reviewed-by: SeongJae Park <sjpark@amazon.de>
> > Signed-off-by: Oleksandr Natalenko <oleksandr@redhat.com>
> > Signed-off-by: Minchan Kim <minchan@kernel.org>
> 
> This will lead to one process calling unmerge_ksm_pages() of another. There's a
> (signal_pending(current)) test there, should it check also the other task,
> analogically to task 3?

Do we care about current there then? Shall we just pass mm into unmerge_ksm_pages and check the signals of the target task only, be it current or something else?

> Then break_ksm() is fine as it is, as ksmd also calls it, right?

I think break_ksm() cares only about mmap_sem protection, so we should
be fine here.

> 
> > ---
> >  mm/madvise.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/mm/madvise.c b/mm/madvise.c
> > index e77c6c1fad34..f4fa962ee74d 100644
> > --- a/mm/madvise.c
> > +++ b/mm/madvise.c
> > @@ -1005,6 +1005,10 @@ process_madvise_behavior_valid(int behavior)
> >  	switch (behavior) {
> >  	case MADV_COLD:
> >  	case MADV_PAGEOUT:
> > +#ifdef CONFIG_KSM
> > +	case MADV_MERGEABLE:
> > +	case MADV_UNMERGEABLE:
> > +#endif
> >  		return true;
> >  	default:
> >  		return false;
> > 
> 

-- 
  Best regards,
    Oleksandr Natalenko (post-factum)
    Principal Software Maintenance Engineer


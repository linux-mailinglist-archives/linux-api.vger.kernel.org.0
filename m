Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7B0217E43A
	for <lists+linux-api@lfdr.de>; Mon,  9 Mar 2020 17:03:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727101AbgCIQDi (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 9 Mar 2020 12:03:38 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35523 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727026AbgCIQDh (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 9 Mar 2020 12:03:37 -0400
Received: by mail-wm1-f66.google.com with SMTP id m3so87002wmi.0;
        Mon, 09 Mar 2020 09:03:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4Vb8vw+xlPzxP4hGQgzGpAoq0a99lvU78mWwnn4o6e4=;
        b=RsUc0jePyBz4QStJstqt2Wvt+bRn+ldjjaGD1uoWhKggPE42qel38e9BvP4UmMY/GB
         e+XE18rnkZ9YeGE6w39XKV9ozawTRetQy1hTOq618gYvvAdRvUSRdrQJ7hRQKJwupJFw
         5GLEbXDV3YCh/tidMOlb44fqdLPZ/38k+oyidRaoQEqzTJHTV7Rfdnf6UQheNn7XuX8F
         MuTjeZbngVY9OYJklhOAovR4wTwSm6mNeGDqW8ISX6+Ef/b+ki6QrTT6rbAnm2hN+5NA
         5nBSNJQCesgWmqzgZyTIFd7DAWcbFwp45W7M4/Q9mw1kZ/QSGTV3bycxKPcx7BNj5bSE
         Lkpg==
X-Gm-Message-State: ANhLgQ3H1eCQ1g0IGy3kNc9rIgurIyHaa+4bzDkT9BDo80DJZCMC2Hb2
        etzFfpOOfVsCqilDDgj3WVg=
X-Google-Smtp-Source: ADFU+vs/vVARoowvzHwEBELNyzAhXmxMxbsk+sHC8tw965L4Ewe24G/EJ0vjZZKrFGdJ/VZOLA4eKQ==
X-Received: by 2002:a05:600c:215:: with SMTP id 21mr20616319wmi.119.1583769813931;
        Mon, 09 Mar 2020 09:03:33 -0700 (PDT)
Received: from localhost (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id 61sm12198177wrd.58.2020.03.09.09.03.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2020 09:03:33 -0700 (PDT)
Date:   Mon, 9 Mar 2020 17:03:32 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Oleksandr Natalenko <oleksandr@redhat.com>,
        Minchan Kim <minchan@kernel.org>,
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
Subject: Re: [PATCH v7 7/7] mm/madvise: allow KSM hints for remote API
Message-ID: <20200309160332.GS8447@dhcp22.suse.cz>
References: <20200302193630.68771-1-minchan@kernel.org>
 <20200302193630.68771-8-minchan@kernel.org>
 <2a66abd8-4103-f11b-06d1-07762667eee6@suse.cz>
 <20200306134146.mqiyvsdnqty7so53@butterfly.localdomain>
 <a63768c1-3959-563b-376b-1d8d90d79b41@suse.cz>
 <20200309131117.anvyjszaigpoz2kp@butterfly.localdomain>
 <20200309150815.GR8447@dhcp22.suse.cz>
 <20200309151932.6sjwq6bucbu6zsea@butterfly.localdomain>
 <34f812b8-df54-eaad-5cf0-335f07da55c6@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <34f812b8-df54-eaad-5cf0-335f07da55c6@suse.cz>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon 09-03-20 16:42:43, Vlastimil Babka wrote:
> On 3/9/20 4:19 PM, Oleksandr Natalenko wrote:
> > On Mon, Mar 09, 2020 at 04:08:15PM +0100, Michal Hocko wrote:
> >> On Mon 09-03-20 14:11:17, Oleksandr Natalenko wrote:
> >> > On Fri, Mar 06, 2020 at 05:08:18PM +0100, Vlastimil Babka wrote:
> >> [...]
> >> > > Dunno, it's nice to react to signals quickly, for any proces that gets them, no?
> >> > 
> >> > So, do you mean something like this?
> >> > 
> >> > ===
> >> > diff --git a/mm/ksm.c b/mm/ksm.c
> >> > index 363ec8189561..b39c237cfcf4 100644
> >> > --- a/mm/ksm.c
> >> > +++ b/mm/ksm.c
> >> > @@ -849,7 +849,8 @@ static int unmerge_ksm_pages(struct vm_area_struct *vma,
> >> >  	for (addr = start; addr < end && !err; addr += PAGE_SIZE) {
> >> >  		if (ksm_test_exit(vma->vm_mm))
> >> >  			break;
> >> > -		if (signal_pending(current))
> >> > +		if (signal_pending(current) ||
> >> > +		    signal_pending(rcu_dereference(vma->vm_mm->owner)))
> >> >  			err = -ERESTARTSYS;
> >> >  		else
> >> >  			err = break_ksm(vma, addr);
> >> > ===
> >> 
> >> This is broken because mm might be attached to different tasks.
> >> AFAIU this check is meant to allow quick backoff of the _calling_
> >> process so that it doesn't waste time when the context is killed
> >> already. I do not understand why should we care about any other context
> >> here? What is the actual problem this would solve?
> > 
> > I agree with you, but still trying to understand what does Vlastimil mean
> > :).
> 
> Well you wondered if we should stop caring about current, and I said that
> probably wouldn't be nice.
> As for caring about the other task, patch 3/7 does that for
> (MADV_COLD|MADV_PAGEOUT) so I just pointed out that the KSM case doesn't. AFAIU
> if we don't check the signals, we might be blocking the killed task from exiting?

I would have to double check but I do not think this would be a problem
because the remote task should take mmget to prevent address space to
vanish under its feet. That should also rule out the exclusive mmap_sem
usage from the exit path.
-- 
Michal Hocko
SUSE Labs

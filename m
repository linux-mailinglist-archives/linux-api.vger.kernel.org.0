Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D92D17E31A
	for <lists+linux-api@lfdr.de>; Mon,  9 Mar 2020 16:08:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726715AbgCIPIT (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 9 Mar 2020 11:08:19 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:34807 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726676AbgCIPIT (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 9 Mar 2020 11:08:19 -0400
Received: by mail-wm1-f67.google.com with SMTP id x3so110852wmj.1;
        Mon, 09 Mar 2020 08:08:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CShDAEQjTdt9JIyUO7h956L1WdGExQd9LWldz9MJ2Cc=;
        b=SuHErUd4hR54E0HKVLUY0MJqY/fPYTDEbVTlARgsm7ZfJqCPO8Fr0kHKxtKHriMOPK
         2kX+ydjK6qTlAMPRKTDHc4qcvJuZy6TRqocNbt4XmmEcCbgaQeOxgefnygvx+FyTqEzl
         KLPYs1X8zLCUyuMLbtueY8jIgzDAKW98CDMRcy5aV0QWCO9/Tdy/D0E7LNtkSMyjhj0v
         Z4qecc5v2h3Xo6YNmJwecPSjdZFdVwp1zl4T7Ce4YIkE9BMIW7NgxBPTww6HScPXOXd0
         FcYmltZMpSZZ1Jj4EF4hG4OPZ02p8kD9jHHRgZz3ufUYAgERtR1wKmlNuX8MjC3ru1qh
         dnNg==
X-Gm-Message-State: ANhLgQ1yexdspLM0Ht9//K1H0EJxt15+cpprGL7UH9bSoHYcFZ94m/nI
        IQrvLMeQq9R5u4hyphsUygM=
X-Google-Smtp-Source: ADFU+vsBff7aAfjr2pMkzUFLxVWiTLhnJal1XORsmcLHXYxZqGIQplNi2T24y04DsAq8kcJJvwWvfA==
X-Received: by 2002:a7b:c082:: with SMTP id r2mr11039389wmh.177.1583766497622;
        Mon, 09 Mar 2020 08:08:17 -0700 (PDT)
Received: from localhost (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id s13sm10369659wrw.29.2020.03.09.08.08.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2020 08:08:16 -0700 (PDT)
Date:   Mon, 9 Mar 2020 16:08:15 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Oleksandr Natalenko <oleksandr@redhat.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>, Minchan Kim <minchan@kernel.org>,
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
Message-ID: <20200309150815.GR8447@dhcp22.suse.cz>
References: <20200302193630.68771-1-minchan@kernel.org>
 <20200302193630.68771-8-minchan@kernel.org>
 <2a66abd8-4103-f11b-06d1-07762667eee6@suse.cz>
 <20200306134146.mqiyvsdnqty7so53@butterfly.localdomain>
 <a63768c1-3959-563b-376b-1d8d90d79b41@suse.cz>
 <20200309131117.anvyjszaigpoz2kp@butterfly.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200309131117.anvyjszaigpoz2kp@butterfly.localdomain>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon 09-03-20 14:11:17, Oleksandr Natalenko wrote:
> On Fri, Mar 06, 2020 at 05:08:18PM +0100, Vlastimil Babka wrote:
[...]
> > Dunno, it's nice to react to signals quickly, for any proces that gets them, no?
> 
> So, do you mean something like this?
> 
> ===
> diff --git a/mm/ksm.c b/mm/ksm.c
> index 363ec8189561..b39c237cfcf4 100644
> --- a/mm/ksm.c
> +++ b/mm/ksm.c
> @@ -849,7 +849,8 @@ static int unmerge_ksm_pages(struct vm_area_struct *vma,
>  	for (addr = start; addr < end && !err; addr += PAGE_SIZE) {
>  		if (ksm_test_exit(vma->vm_mm))
>  			break;
> -		if (signal_pending(current))
> +		if (signal_pending(current) ||
> +		    signal_pending(rcu_dereference(vma->vm_mm->owner)))
>  			err = -ERESTARTSYS;
>  		else
>  			err = break_ksm(vma, addr);
> ===

This is broken because mm might be attached to different tasks.
AFAIU this check is meant to allow quick backoff of the _calling_
process so that it doesn't waste time when the context is killed
already. I do not understand why should we care about any other context
here? What is the actual problem this would solve?

-- 
Michal Hocko
SUSE Labs

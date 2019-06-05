Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8511635DE7
	for <lists+linux-api@lfdr.de>; Wed,  5 Jun 2019 15:27:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbfFEN1h (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 5 Jun 2019 09:27:37 -0400
Received: from mail-wr1-f53.google.com ([209.85.221.53]:46861 "EHLO
        mail-wr1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727889AbfFEN1c (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 5 Jun 2019 09:27:32 -0400
Received: by mail-wr1-f53.google.com with SMTP id n4so14218169wrw.13
        for <linux-api@vger.kernel.org>; Wed, 05 Jun 2019 06:27:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8UF6IKh1oi+AJKntkp2Avzsj99+2nJ602b//xWwwYMo=;
        b=Ee+OJeK7o6PS5jSRZLm0bcyBw9eJGplMvg6AzB7/+GihQa9c89dAc8gL15Xdastbkr
         nORdgQpfFYw7EUT7XDzOxIaD5eZIPjsmaVfJ4qv1j/i4w1qYf/PpYeQHz2UAzN+Giyxj
         pRys9t9PbxRtwsje8rkT28XiWwPXg606nnZirvoRQuy5WS77Az+td4KoqB1waabUUlZa
         ZbVIg/zJhWEICCSZzt11BMatEVlR3hJo9f2FIOGF4BFpeacW2SXr3nU5EoIRSf7YegFi
         BhPr3AMdYlYkvMwbhd78g14W8aGLshaRidEaoSLmz4qYWpt30GQPOocwZqULEnvlA2FO
         BIow==
X-Gm-Message-State: APjAAAV73wscDBoAM/+EMbJ3u7X7j3FBIH0mA1DQfyn5Bi7VXs8jsTZe
        NER7SrB+MM5xZYTjRNkDDSvgtg==
X-Google-Smtp-Source: APXvYqzO7CgrYTcvyVtelP3nLeZ+Ekw3IsfgEuQ6as9WNjO7Znl9iRR9QfVOYT+MaOhBlZ3QYIBaSg==
X-Received: by 2002:adf:e4d2:: with SMTP id v18mr10605225wrm.189.1559741250343;
        Wed, 05 Jun 2019 06:27:30 -0700 (PDT)
Received: from localhost (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id u205sm24193031wmu.47.2019.06.05.06.27.29
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 05 Jun 2019 06:27:29 -0700 (PDT)
Date:   Wed, 5 Jun 2019 15:27:28 +0200
From:   Oleksandr Natalenko <oleksandr@redhat.com>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-api@vger.kernel.org,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tim Murray <timmurray@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Daniel Colascione <dancol@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Sonny Rao <sonnyrao@google.com>,
        Brian Geffon <bgeffon@google.com>, jannh@google.com,
        oleg@redhat.com, christian@brauner.io, hdanton@sina.com
Subject: Re: [RFCv2 4/6] mm: factor out madvise's core functionality
Message-ID: <20190605132728.mihzzw7galqjf5uz@butterfly.localdomain>
References: <20190531064313.193437-1-minchan@kernel.org>
 <20190531064313.193437-5-minchan@kernel.org>
 <20190531070420.m7sxybbzzayig44o@butterfly.localdomain>
 <20190531131226.GA195463@google.com>
 <20190531143545.jwmgzaigd4rbw2wy@butterfly.localdomain>
 <20190531232959.GC248371@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190531232959.GC248371@google.com>
User-Agent: NeoMutt/20180716
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hi.

On Sat, Jun 01, 2019 at 08:29:59AM +0900, Minchan Kim wrote:
> > > > > /* snip a lot */
> > > > >
> > > > >  #ifdef CONFIG_MEMORY_FAILURE
> > > > >  	if (behavior == MADV_HWPOISON || behavior == MADV_SOFT_OFFLINE)
> > > > > -		return madvise_inject_error(behavior, start, start + len_in);
> > > > > +		return madvise_inject_error(behavior,
> > > > > +					start, start + len_in);
> > > > 
> > > > Not sure what this change is about except changing the line length.
> > > > Note, madvise_inject_error() still operates on "current" through
> > > > get_user_pages_fast() and gup_pgd_range(), but that was not changed
> > > > here. I Know you've filtered out this hint later, so technically this
> > > > is not an issue, but, maybe, this needs some attention too since we've
> > > > already spotted it?
> > > 
> > > It is leftover I had done. I actually modified it to handle remote
> > > task but changed my mind not to fix it because process_madvise
> > > will not support it at this moment. I'm not sure it's a good idea
> > > to change it for *might-be-done-in-future* at this moment even though
> > > we have spotted.
> > 
> > I'd expect to have at least some comments in code on why other hints
> > are disabled, so if we already know some shortcomings, this information
> > would not be lost.
> 
> Okay, I will add some comment but do not want to fix code piece until
> someone want to expose the poisoning to external process.

Fair enough.

> > > > >  	write = madvise_need_mmap_write(behavior);
> > > > >  	if (write) {
> > > > > -		if (down_write_killable(&current->mm->mmap_sem))
> > > > > +		if (down_write_killable(&mm->mmap_sem))
> > > > >  			return -EINTR;
> > > > 
> > > > Do you still need that trick with mmget_still_valid() here?
> > > > Something like:
> > > 
> > > Since MADV_COLD|PAGEOUT doesn't change address space layout or
> > > vma->vm_flags, technically, we don't need it if I understand
> > > correctly. Right?
> > 
> > I'd expect so, yes. But.
> > 
> > Since we want this interface to be universal and to be able to cover
> > various needs, and since my initial intention with working in this
> > direction involved KSM, I'd ask you to enable KSM hints too, and once
> > (and if) that happens, the work there is done under write lock, and
> > you'll need this trick to be applied.
> > 
> > Of course, I can do that myself later in a subsequent patch series once
> > (and, again, if) your series is merged, but, maybe, we can cover this
> > already especially given the fact that KSM hinting is a relatively easy
> > task in this pile. I did some preliminary tests with it, and so far no
> > dragons have started to roar.
> 
> Then, do you mind sending a patch based upon this series to expose
> MADV_MERGEABLE to process_madvise? It will have the right description
> why you want to have such feature which I couldn't provide since I don't
> have enough material to write the motivation. And the patch also could
> include the logic to prevent coredump race, which is more proper since
> finally we need to hold mmap_sem write-side lock, finally.
> I will pick it up and will rebase since then.

Sure, I can. Would you really like to have it being based on this exact
revision, or I should wait till you deal with MADV_COLD & Co and re-iterate
this part again?

Thanks.

-- 
  Best regards,
    Oleksandr Natalenko (post-factum)
    Senior Software Maintenance Engineer

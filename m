Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 64BAE3B2C7
	for <lists+linux-api@lfdr.de>; Mon, 10 Jun 2019 12:13:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388703AbfFJKM5 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 10 Jun 2019 06:12:57 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36205 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388489AbfFJKM5 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 10 Jun 2019 06:12:57 -0400
Received: by mail-pg1-f196.google.com with SMTP id a3so4794530pgb.3;
        Mon, 10 Jun 2019 03:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UpQZyxDAIZssxN7CCNuXeFikhiebMI4lHnTfzcrIiyQ=;
        b=oT3Tgck9UOkWtTtrfEsTEc4PpMFYNC/1A+9ozR6V61Qzvmi8PU2PjmGz4nMCuGml3v
         H+nRmhJEBftdYa/jqjOOUDmFd3EIVk3K904sggw8sHSKT+izqm8D6xXryQtEqRIQwnYd
         kU6ue4gFnzw7c/7zfEq/nYUufkOUwE5mNFwKPN0SwyZ0Bbo4EwOKD09zGiKkw9lzRU0r
         8oiPkxnTLIkCVg18tdGUfuEWKg8MvK4yGM9BSlB9tZo15gQMiOojbos6lEuAFQ2aqnVh
         0TER9J8ovskikTwRLLABwQfJ8LIMQIbDXfzkiMaWGpOOhtsIYly64d/JTpyUpvwp9twe
         /YWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=UpQZyxDAIZssxN7CCNuXeFikhiebMI4lHnTfzcrIiyQ=;
        b=BB4nb2lS3T8WBIyotovYNh6IQSZSyekD63yC/MsYPovDEM/DsgAmlsn6KX0nRyJmEc
         rXFe8S8orQxNLzqTH5X5RHTfTHslTna6yREnJb6/vk2hZb7Ad3WC6JSCF+U4+Amtlcna
         MI+rYqbamCqMNAAqcuUTXpuuBX0l3JO57Yo24ikl/LuGFBTxVZi7MaaxmVou32B9egzj
         Fe+eT1XY7FDbypS86lv/N0bWrvvB42wZ7VaauZlDSe8SdOn9HuXcwfY791GN6E1lbC3f
         3FNaigwglhJk1faJ6SayrmxG2MoSrL7J28u2VFzsEAgPmiD7QWxLrSVGJgISxVxyAmqO
         NCPQ==
X-Gm-Message-State: APjAAAWYN+Ri+MNlz7V/qttOt5/9Q3uXbLvQcvibwP26CD/pBICKiGlx
        hM3I3ICf4qBj2ModOzEWiKs=
X-Google-Smtp-Source: APXvYqzJUiyDWi8zaR4iqoYas4PnR+FTZYDwdV0l9Fr4aNPkQh14eZq3enRj6HzBCVUi/S2a/0C2XQ==
X-Received: by 2002:a17:90a:3787:: with SMTP id v7mr10962360pjb.33.1560161576370;
        Mon, 10 Jun 2019 03:12:56 -0700 (PDT)
Received: from google.com ([2401:fa00:d:0:98f1:8b3d:1f37:3e8])
        by smtp.gmail.com with ESMTPSA id l38sm9533673pje.12.2019.06.10.03.12.50
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 10 Jun 2019 03:12:54 -0700 (PDT)
Date:   Mon, 10 Jun 2019 19:12:48 +0900
From:   Minchan Kim <minchan@kernel.org>
To:     Oleksandr Natalenko <oleksandr@redhat.com>
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
Message-ID: <20190610101248.GD55602@google.com>
References: <20190531064313.193437-1-minchan@kernel.org>
 <20190531064313.193437-5-minchan@kernel.org>
 <20190531070420.m7sxybbzzayig44o@butterfly.localdomain>
 <20190531131226.GA195463@google.com>
 <20190531143545.jwmgzaigd4rbw2wy@butterfly.localdomain>
 <20190531232959.GC248371@google.com>
 <20190605132728.mihzzw7galqjf5uz@butterfly.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190605132728.mihzzw7galqjf5uz@butterfly.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hi Oleksandr,

On Wed, Jun 05, 2019 at 03:27:28PM +0200, Oleksandr Natalenko wrote:
< snip >
> > > > > >  	write = madvise_need_mmap_write(behavior);
> > > > > >  	if (write) {
> > > > > > -		if (down_write_killable(&current->mm->mmap_sem))
> > > > > > +		if (down_write_killable(&mm->mmap_sem))
> > > > > >  			return -EINTR;
> > > > > 
> > > > > Do you still need that trick with mmget_still_valid() here?
> > > > > Something like:
> > > > 
> > > > Since MADV_COLD|PAGEOUT doesn't change address space layout or
> > > > vma->vm_flags, technically, we don't need it if I understand
> > > > correctly. Right?
> > > 
> > > I'd expect so, yes. But.
> > > 
> > > Since we want this interface to be universal and to be able to cover
> > > various needs, and since my initial intention with working in this
> > > direction involved KSM, I'd ask you to enable KSM hints too, and once
> > > (and if) that happens, the work there is done under write lock, and
> > > you'll need this trick to be applied.
> > > 
> > > Of course, I can do that myself later in a subsequent patch series once
> > > (and, again, if) your series is merged, but, maybe, we can cover this
> > > already especially given the fact that KSM hinting is a relatively easy
> > > task in this pile. I did some preliminary tests with it, and so far no
> > > dragons have started to roar.
> > 
> > Then, do you mind sending a patch based upon this series to expose
> > MADV_MERGEABLE to process_madvise? It will have the right description
> > why you want to have such feature which I couldn't provide since I don't
> > have enough material to write the motivation. And the patch also could
> > include the logic to prevent coredump race, which is more proper since
> > finally we need to hold mmap_sem write-side lock, finally.
> > I will pick it up and will rebase since then.
> 
> Sure, I can. Would you really like to have it being based on this exact
> revision, or I should wait till you deal with MADV_COLD & Co and re-iterate
> this part again?

I'm okay you to send your patch against this revision. I'm happy to
include it when I start a new thread for process_madvise discussion
after resolving MADV_COLD|PAGEOUT.

Thanks.

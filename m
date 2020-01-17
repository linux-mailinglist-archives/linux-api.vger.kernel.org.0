Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C23E01409CF
	for <lists+linux-api@lfdr.de>; Fri, 17 Jan 2020 13:34:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbgAQMeG (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 17 Jan 2020 07:34:06 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:24194 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726917AbgAQMeF (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 17 Jan 2020 07:34:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579264445;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=n6noiswpldg3fHomtpJXeotHAxwJmLIHoQgf83pfhEE=;
        b=BbEl2ga7E79fTmOKwavNOOnQphc30p+5fxW4HSC2AYJex16MuQASo7MqJ0WlvVGWHPpZ1H
        DFqp5OcLxV2Qga5SnmwjAzV8sCnOuEVB2UbrHJfLhTrT/5vjv4y1N/O0SeIdLURn7ZN02/
        c+SJi+d6iBykgJHBSXuowKt1OKEhifc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-181-LogG1hKSOCW4Vcbqzimymw-1; Fri, 17 Jan 2020 07:34:03 -0500
X-MC-Unique: LogG1hKSOCW4Vcbqzimymw-1
Received: by mail-wr1-f71.google.com with SMTP id r2so10463137wrp.7
        for <linux-api@vger.kernel.org>; Fri, 17 Jan 2020 04:34:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=n6noiswpldg3fHomtpJXeotHAxwJmLIHoQgf83pfhEE=;
        b=M0nGjRagLpFIIzUqia+p59rMd7MsL++ePAIw/af7wKArTp5ru4mSRJBIeuWOXwOc4Y
         pcGgkhYDkZrFKITSvcFGro4e8umlZDjUIYGFcFVxvCufucUcZCnubuAB1NTImlqFjbMw
         N1uQozNLJs9RCC617eP6yO0QChywzgseCSysrPlXDuvnE2mi/Obm8YrsQNuIZJS4tPOr
         VvonuP320GkqgjvBRjWCaWfs7rhSJTioqITGlWEXQmc+HcmGD9sCz/4I47XCzR75WeYW
         5B8HpgBoLUI0p7yKKdUfi71mOakU5HkNaPB1yhRbAqGLmnO7g0+uj0nJByC3FRM6zzED
         fgcw==
X-Gm-Message-State: APjAAAVJo2rt7nbYWAWUHkO3Nga/ds7LbdfTM5E2rBA+zqHxLLVVZyEn
        hA/9lTQoUA/gG4EjRztkx39jdRykrEcy9kVt66JxrOxA9LkV5qgXdeU8FeotDpSQrwBF8S0i/1x
        Rx96p3/cb6dZGysoVGl3O
X-Received: by 2002:adf:df83:: with SMTP id z3mr2783928wrl.389.1579264442700;
        Fri, 17 Jan 2020 04:34:02 -0800 (PST)
X-Google-Smtp-Source: APXvYqyXrFbb1XX82iYVpnh0BdWbZbvio6PUNm045gC9KyuT7ceLT/vO7ufARgEZP9im72FHYd9BGQ==
X-Received: by 2002:adf:df83:: with SMTP id z3mr2783892wrl.389.1579264442359;
        Fri, 17 Jan 2020 04:34:02 -0800 (PST)
Received: from localhost (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id n3sm4655448wmc.27.2020.01.17.04.34.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 04:34:01 -0800 (PST)
Date:   Fri, 17 Jan 2020 13:34:00 +0100
From:   Oleksandr Natalenko <oleksandr@redhat.com>
To:     Kirill Tkhai <ktkhai@virtuozzo.com>
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
        John Dias <joaodias@google.com>, christian.brauner@ubuntu.com,
        sjpark@amazon.de, Minchan Kim <minchan@google.com>
Subject: Re: [PATCH v2 4/5] mm/madvise: allow KSM hints for remote API
Message-ID: <20200117123400.o3ne6kazkovq4okd@butterfly.localdomain>
References: <20200116235953.163318-1-minchan@kernel.org>
 <20200116235953.163318-5-minchan@kernel.org>
 <37338e14-5a55-1926-b6c1-5f98b6a6fdb5@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <37338e14-5a55-1926-b6c1-5f98b6a6fdb5@virtuozzo.com>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hi.

On Fri, Jan 17, 2020 at 01:13:14PM +0300, Kirill Tkhai wrote:
> On 17.01.2020 02:59, Minchan Kim wrote:
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
> > Signed-off-by: Oleksandr Natalenko <oleksandr@redhat.com>
> > Signed-off-by: Minchan Kim <minchan@google.com>
> > ---
> >  mm/madvise.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/mm/madvise.c b/mm/madvise.c
> > index 84cffd0900f1..89557998d287 100644
> > --- a/mm/madvise.c
> > +++ b/mm/madvise.c
> > @@ -1000,6 +1000,8 @@ process_madvise_behavior_valid(int behavior)
> >  	switch (behavior) {
> >  	case MADV_COLD:
> >  	case MADV_PAGEOUT:
> > +	case MADV_MERGEABLE:
> > +	case MADV_UNMERGEABLE:
> >  		return true;
> >  	default:
> >  		return false;
> 
> Remote madvise on KSM parameters should be OK.
> 
> One thing is madvise_behavior_valid() places MADV_MERGEABLE/UNMERGEABLE
> in #ifdef brackes, so -EINVAL is returned by madvise() syscall if KSM
> is not enabled. Here we should follow the same way for symmetry.
> 

Thanks for the suggestion.

Minchan, shall you adopt it directly, or I should send a separate patch?

-- 
  Best regards,
    Oleksandr Natalenko (post-factum)
    Senior Software Maintenance Engineer


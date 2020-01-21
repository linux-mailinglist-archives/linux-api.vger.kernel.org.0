Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC15A144386
	for <lists+linux-api@lfdr.de>; Tue, 21 Jan 2020 18:45:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729080AbgAURpG (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 21 Jan 2020 12:45:06 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36091 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728186AbgAURpG (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 21 Jan 2020 12:45:06 -0500
Received: by mail-pg1-f194.google.com with SMTP id k3so1886318pgc.3;
        Tue, 21 Jan 2020 09:45:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XmgSXNlNou2mcO6i9Iver2Yc4nxRNH3v9tX/ZnyaZOk=;
        b=Tw9BVG59m7XRkj63k6tlOCW0qP+at6a5ic3pu4R0m4DjOa6KBMwR4LDOVUIr17qMi7
         eZL8QopcH/vPhj6IZiKZ5qsnU3jFo0JDWrkggQQOSuXJnjOaGIf4aXc0YmZUkpctazPN
         AOCSIsnCatnxUCNKDaq58Gh6DklDJqjzwNlSSpvMGYFZDWteyEUdRTJ4XDBDGvTpe2xb
         7eAzPAkudjN7AZQQS5O98XP8SiDA3efHgGVW/RzL17Y6pMcxzPTSrH+RdgHflqmhYNcd
         PtknM3OtGiiUMA2YK+Ciu2EuOFhHq8A5tFunzJxJW6C1ij5mjE5oL4dL4uyVU8bNqoA/
         2HFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=XmgSXNlNou2mcO6i9Iver2Yc4nxRNH3v9tX/ZnyaZOk=;
        b=o7bSdYd+T91VyeUWRYynHuRCvTHxrl1cWAH98juhZA6TBV/9M0AWiEKUl1MIKGF3pH
         dbBL/N7KLa4vDrn0/9SQjgylfySGCEkyB3z2zoBxoIowc4rUON/AfRSjCD8PckQSB1QN
         /T9+Zu1Q7QTrAJfpoJ7Y/1Oiz6wBPOzP1sLRGSojNwpYxxF2E62lQ8lEf7uGcqrCBlPq
         4rcYfTkK1Zm2zpt+srHAyx1stOBt7S0Z3aSU2rv4wFLxVtOTBCMITB9BZkuaQIDetT6y
         on5O3+fBgQ+zlEzv52ejG7v1s4iGJrmd6MKCK2IQZo1ZVfyzXT7iVWyXu/GlAIsUu3tK
         kQkg==
X-Gm-Message-State: APjAAAU6LFdkpO8iYZIBRDA/F46Dk6GHbOybpLll6VrXrKskVzswSFtB
        k7M+2vQBhZtoHuf29kr3uMk=
X-Google-Smtp-Source: APXvYqxvIbtuBdiKMYwNvonK3LsNjuapeOvdevIDzx640w6i8heAVOmNGOckz0V4Kdo46w6neV1XfA==
X-Received: by 2002:aa7:9808:: with SMTP id e8mr5707265pfl.32.1579628705390;
        Tue, 21 Jan 2020 09:45:05 -0800 (PST)
Received: from google.com ([2620:15c:211:1:3e01:2939:5992:52da])
        by smtp.gmail.com with ESMTPSA id 64sm44470694pfd.48.2020.01.21.09.45.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2020 09:45:03 -0800 (PST)
Date:   Tue, 21 Jan 2020 09:45:01 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Oleksandr Natalenko <oleksandr@redhat.com>
Cc:     Kirill Tkhai <ktkhai@virtuozzo.com>,
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
        sjpark@amazon.de
Subject: Re: [PATCH v2 4/5] mm/madvise: allow KSM hints for remote API
Message-ID: <20200121174501.GD140922@google.com>
References: <20200116235953.163318-1-minchan@kernel.org>
 <20200116235953.163318-5-minchan@kernel.org>
 <37338e14-5a55-1926-b6c1-5f98b6a6fdb5@virtuozzo.com>
 <20200117123400.o3ne6kazkovq4okd@butterfly.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200117123400.o3ne6kazkovq4okd@butterfly.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, Jan 17, 2020 at 01:34:00PM +0100, Oleksandr Natalenko wrote:
> Hi.
> 
> On Fri, Jan 17, 2020 at 01:13:14PM +0300, Kirill Tkhai wrote:
> > On 17.01.2020 02:59, Minchan Kim wrote:
> > > From: Oleksandr Natalenko <oleksandr@redhat.com>
> > > 
> > > It all began with the fact that KSM works only on memory that is marked
> > > by madvise(). And the only way to get around that is to either:
> > > 
> > >   * use LD_PRELOAD; or
> > >   * patch the kernel with something like UKSM or PKSM.
> > > 
> > > (i skip ptrace can of worms here intentionally)
> > > 
> > > To overcome this restriction, lets employ a new remote madvise API. This
> > > can be used by some small userspace helper daemon that will do auto-KSM
> > > job for us.
> > > 
> > > I think of two major consumers of remote KSM hints:
> > > 
> > >   * hosts, that run containers, especially similar ones and especially in
> > >     a trusted environment, sharing the same runtime like Node.js;
> > > 
> > >   * heavy applications, that can be run in multiple instances, not
> > >     limited to opensource ones like Firefox, but also those that cannot be
> > >     modified since they are binary-only and, maybe, statically linked.
> > > 
> > > Speaking of statistics, more numbers can be found in the very first
> > > submission, that is related to this one [1]. For my current setup with
> > > two Firefox instances I get 100 to 200 MiB saved for the second instance
> > > depending on the amount of tabs.
> > > 
> > > 1 FF instance with 15 tabs:
> > > 
> > >    $ echo "$(cat /sys/kernel/mm/ksm/pages_sharing) * 4 / 1024" | bc
> > >    410
> > > 
> > > 2 FF instances, second one has 12 tabs (all the tabs are different):
> > > 
> > >    $ echo "$(cat /sys/kernel/mm/ksm/pages_sharing) * 4 / 1024" | bc
> > >    592
> > > 
> > > At the very moment I do not have specific numbers for containerised
> > > workload, but those should be comparable in case the containers share
> > > similar/same runtime.
> > > 
> > > [1] https://lore.kernel.org/patchwork/patch/1012142/
> > > 
> > > Signed-off-by: Oleksandr Natalenko <oleksandr@redhat.com>
> > > Signed-off-by: Minchan Kim <minchan@google.com>
> > > ---
> > >  mm/madvise.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> > > 
> > > diff --git a/mm/madvise.c b/mm/madvise.c
> > > index 84cffd0900f1..89557998d287 100644
> > > --- a/mm/madvise.c
> > > +++ b/mm/madvise.c
> > > @@ -1000,6 +1000,8 @@ process_madvise_behavior_valid(int behavior)
> > >  	switch (behavior) {
> > >  	case MADV_COLD:
> > >  	case MADV_PAGEOUT:
> > > +	case MADV_MERGEABLE:
> > > +	case MADV_UNMERGEABLE:
> > >  		return true;
> > >  	default:
> > >  		return false;
> > 
> > Remote madvise on KSM parameters should be OK.
> > 
> > One thing is madvise_behavior_valid() places MADV_MERGEABLE/UNMERGEABLE
> > in #ifdef brackes, so -EINVAL is returned by madvise() syscall if KSM
> > is not enabled. Here we should follow the same way for symmetry.
> > 
> 
> Thanks for the suggestion.
> 
> Minchan, shall you adopt it directly, or I should send a separate patch?

I will handle it in next spin.

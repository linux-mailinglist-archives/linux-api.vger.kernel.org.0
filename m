Return-Path: <linux-api+bounces-2292-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD09296C33E
	for <lists+linux-api@lfdr.de>; Wed,  4 Sep 2024 18:00:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 277E6B24C99
	for <lists+linux-api@lfdr.de>; Wed,  4 Sep 2024 16:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAE981E00A3;
	Wed,  4 Sep 2024 15:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="v0wZXFwf"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-ej1-f66.google.com (mail-ej1-f66.google.com [209.85.218.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EDA11DEFF6
	for <linux-api@vger.kernel.org>; Wed,  4 Sep 2024 15:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725465513; cv=none; b=PLsMaUbwZTbA57RxtBmGxyN9NB4eWP3XWUhiK1ykULX77m6bMYppDvZOV1GFfuvZUDhbebSEhEjIm1yI9Pwtf94kknbBKFDk7RD8Z1ZIGs6iUmxnmvLiKhNTgmEBj6dNx7DCPSV9oeaSqrUJ/Np3bxZQNSZbwx/JrC+CvuwXJtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725465513; c=relaxed/simple;
	bh=RL4zYJQfW7GWFseyiRAQnO+tA0nGJyMzdL12QrO6Kxw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kJUfaOrIt3dAfReek/uM1C4nqes0xNc7rwN0ALG46MqEhBR5WAlnwTaCmp3syXSWKpPJEjHS0CAz+DGYB+nsLznozvuO6YmeFIhQUpwA9hhASqy9HNHuSejhXGDo8KwQg9VF8EX3pZcBHQYsiQsRLNALZUjRUC5K6gUuIDO9dU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=v0wZXFwf; arc=none smtp.client-ip=209.85.218.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-ej1-f66.google.com with SMTP id a640c23a62f3a-a8695cc91c8so703393166b.3
        for <linux-api@vger.kernel.org>; Wed, 04 Sep 2024 08:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1725465510; x=1726070310; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/8fV+DrlmrRBUWUP6G7Q4K9KSLGpKoXOH1+H22wkJsE=;
        b=v0wZXFwfl2aPMCLo1vjaRMAUVtgkUoSuWjdboMmXbH8km7++QzPR0OOa7UCUDEtFYm
         n9ap1QZEZEzCsE7Bw5FdIi5UZtsuxU6W1SEIx2DUUJUD8zPT299bozPESYDmNRaZe9t9
         wgR0r7+uEQVl5w8XgzLYVSjWb712pJ8dU2WFs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725465510; x=1726070310;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/8fV+DrlmrRBUWUP6G7Q4K9KSLGpKoXOH1+H22wkJsE=;
        b=l3m+ughcX9iHEQ4mLYbYzKd18hlhmO3bin1eJw5MXfxLNpgCtij6cwY9dPQaw3wK88
         FGlBX+wdjksUJJuA0QX5PwKZL9Rv/rEQjZeTOGkBLTNPRXTIxhin4ZlVRkCv3tc5CMiA
         W+j5U383FQEBAEbQBOPiPDGuOm8YJFb+qDcsaKNzilewfu9zbpc9FCXRZD06WLYsSFqa
         ZWcHn4wjN1DrXBcwcj1Clsqg+sOduPFNXPwr8ZiuXPBtGfEBqOg5D5DcICaZbB26oYxa
         bLmvOP8Z0/BOI54Kbu/8g+9EeKLZHsEKyBT2D1L3ThQv7mt4JKYaWC2k7xnv1lRgccNU
         +PFQ==
X-Forwarded-Encrypted: i=1; AJvYcCVmXODL7Eic2bS2tGsMaCgUfceCiTZQNM7NN0gePfcZnQGMXDHyie6TkF6PF6eaJ6lJbLSxOYiRVH0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBXq2QR1/vooLyzPIp5ddhWgm7eioS0YpG/S0Q3AZ7vvedAFqK
	BkFpNoccGWgrdJGXwW4mZFfmtd9HJpWL817Lg9iVfNGTRcS0UNbgZbXM4gZ0Lx4=
X-Google-Smtp-Source: AGHT+IHslunfGggkxKq7YB/+m8L+vowl0VqAIwm57K7mv2PzgJUaSRRhjtljjdOR9curedPmIaEI0g==
X-Received: by 2002:a17:907:3f24:b0:a7a:a892:8e05 with SMTP id a640c23a62f3a-a897f92022amr1493824866b.33.1725465509488;
        Wed, 04 Sep 2024 08:58:29 -0700 (PDT)
Received: from LQ3V64L9R2.station (net-2-42-195-208.cust.vodafonedsl.it. [2.42.195.208])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8a6236d14dsm7819266b.112.2024.09.04.08.58.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 08:58:29 -0700 (PDT)
Date: Wed, 4 Sep 2024 17:58:26 +0200
From: Joe Damato <jdamato@fastly.com>
To: Naman Gulati <namangulati@google.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
	Stanislav Fomichev <sdf@fomichev.me>, linux-kernel@vger.kernel.org,
	skhawaja@google.com,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	mkarsten@uwaterloo.ca, linux-api@vger.kernel.org
Subject: Re: [PATCH] Add provision to busyloop for events in ep_poll.
Message-ID: <ZtiDoi1l-TbsrYjO@LQ3V64L9R2.station>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Naman Gulati <namangulati@google.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
	Stanislav Fomichev <sdf@fomichev.me>, linux-kernel@vger.kernel.org,
	skhawaja@google.com,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	mkarsten@uwaterloo.ca, linux-api@vger.kernel.org
References: <20240828181011.1591242-1-namangulati@google.com>
 <ZtBQLqqMrpCLBMw1@LQ3V64L9R2>
 <CAMP57yUuvvE-n-Xx--GRUsHLC2n4LgaNF=uViDhggvbG=5r9zQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMP57yUuvvE-n-Xx--GRUsHLC2n4LgaNF=uViDhggvbG=5r9zQ@mail.gmail.com>

On Tue, Sep 03, 2024 at 07:18:14PM -0700, Naman Gulati wrote:
> Thanks all for the comments and apologies for the delay in replying.
> Stanislav and Joe I’ve addressed some of the common concerns below.
> 
> On Thu, Aug 29, 2024 at 3:40 AM Joe Damato <jdamato@fastly.com> wrote:
> >
> > On Wed, Aug 28, 2024 at 06:10:11PM +0000, Naman Gulati wrote:
> > > NAPI busypolling in ep_busy_loop loops on napi_poll and checks for new
> > > epoll events after every napi poll. Checking just for epoll events in a
> > > tight loop in the kernel context delivers latency gains to applications
> > > that are not interested in napi busypolling with epoll.
> > >
> > > This patch adds an option to loop just for new events inside
> > > ep_busy_loop, guarded by the EPIOCSPARAMS ioctl that controls epoll napi
> > > busypolling.
> >
> > This makes an API change, so I think that linux-api@vger.kernel.org
> > needs to be CC'd ?
> >
> > > A comparison with neper tcp_rr shows that busylooping for events in
> > > epoll_wait boosted throughput by ~3-7% and reduced median latency by
> > > ~10%.
> > >
> > > To demonstrate the latency and throughput improvements, a comparison was
> > > made of neper tcp_rr running with:
> > >     1. (baseline) No busylooping
> >
> > Is there NAPI-based steering to threads via SO_INCOMING_NAPI_ID in
> > this case? More details, please, on locality. If there is no
> > NAPI-based flow steering in this case, perhaps the improvements you
> > are seeing are a result of both syscall overhead avoidance and data
> > locality?
> 
> The benchmarks were run with no NAPI steering.
> 
> Regarding syscall overhead, I reproduced the above experiment with
> mitigations=off
> and found similar results as above. Pointing to the fact that the above
> gains are
> materialized from more than just avoiding syscall overhead.

I think the cover letter needs more benchmark cases, data points,
and documentation about precisely how the benchmark is being run and
configured. The data feels quite sparse, the explanation of the
experiment leaves too much out, and - with respect - I am not
convinced by the results posted.

> By locality are you referring to Numa locality?

CPU cache locality.

> >
> > >     2. (epoll busylooping) enabling the epoll busy looping on all epoll
> > >     fd's
> >
> > This is the case you've added, event_poll_only ? It seems like in
> > this case you aren't busy looping exactly, you are essentially
> > allowing IRQ/softIRQ to drive processing and checking on wakeup that
> > events are available.
> >
> > IMHO, I'm not sure if "epoll busylooping" is an appropriate
> > description.
> 
> I see your point, perhaps "spinning" or just “looping” could be a closer
> word?

I don't know how to describe the patch, to be totally honest. I
think the basis of the mechanism needs to be more thoroughly
understood. See below.

> >
> > >     3. (userspace busylooping) looping on epoll_wait in userspace
> > >     with timeout=0
> >
> > Same question as Stanislav; timeout=0 should get ep_loop to transfer
> > events immediately (if there are any) and return without actually
> > invoking busy poll. So, it would seem that your ioctl change
> > shouldn't be necessary since the equivalent behavior is already
> > possible with timeout=0.
> >
> > I'd probably investigate both syscall overhead and data locality
> > before approving this patch because it seems a bit suspicious to me.
> >
> > >
> > > Stats for two machines with 100Gbps NICs running tcp_rr with 5 threads
> > > and varying flows:
> > >
> > > Type                Flows   Throughput             Latency (μs)
> > >                              (B/s)      P50   P90    P99   P99.9
>  P99.99
> > > baseline            15            272145      57.2  71.9   91.4  100.6
>  111.6
> > > baseline            30            464952      66.8  78.8   98.1  113.4
>  122.4
> > > baseline            60            695920      80.9  118.5  143.4 161.8
>  174.6
> > > epoll busyloop      15            301751      44.7  70.6   84.3  95.4
>   106.5
> > > epoll busyloop      30            508392      58.9  76.9   96.2  109.3
>  118.5
> > > epoll busyloop      60            745731      77.4  106.2  127.5 143.1
>  155.9
> > > userspace busyloop  15            279202      55.4  73.1   85.2  98.3
>   109.6
> > > userspace busyloop  30            472440      63.7  78.2   96.5  112.2
>  120.1
> > > userspace busyloop  60            720779      77.9  113.5  134.9 152.6
>  165.7
> > >
> > > Per the above data epoll busyloop outperforms baseline and userspace
> > > busylooping in both throughput and latency. As the density of flows per
> > > thread increased, the median latency of all three epoll mechanisms
> > > converges. However epoll busylooping is better at capturing the tail
> > > latencies at high flow counts.
> > >
> > > Signed-off-by: Naman Gulati <namangulati@google.com>
> > > ---
> > >  fs/eventpoll.c                 | 53 ++++++++++++++++++++++++++--------
> > >  include/uapi/linux/eventpoll.h |  3 +-
> > >  2 files changed, 43 insertions(+), 13 deletions(-)
> > >
> > > diff --git a/fs/eventpoll.c b/fs/eventpoll.c
> > > index f53ca4f7fcedd..6cba79261817a 100644
> > > --- a/fs/eventpoll.c
> > > +++ b/fs/eventpoll.c
> > > @@ -232,7 +232,10 @@ struct eventpoll {
> > >       u32 busy_poll_usecs;
> > >       /* busy poll packet budget */
> > >       u16 busy_poll_budget;
> > > -     bool prefer_busy_poll;
> > > +     /* prefer to busypoll in napi poll */
> > > +     bool napi_prefer_busy_poll;
> >
> > Adding napi seems slightly redundant to me but I could be convinced either
> > way, I suppose.
> 
> With the two different polling booleans in the struct, I felt it's better
> to be explicit
> about the scope of each.
> 
> >
> > > +     /* avoid napi poll when busy looping and poll only for events */
> > > +     bool event_poll_only;
> >
> > I'm not sure about this overall; this isn't exactly what I think of
> > when I think about the word "polling" but maybe I'm being too
> > nit-picky.
> 
> I'm not sure how else to categorize the operation, is there some other
> phrasing
> you'd recommend?
> 
> >
> > >  #endif
> > >
> > >  #ifdef CONFIG_DEBUG_LOCK_ALLOC
> > > @@ -430,6 +433,24 @@ static bool ep_busy_loop_end(void *p, unsigned
> long start_time)
> > >       return ep_events_available(ep) ||
> busy_loop_ep_timeout(start_time, ep);
> > >  }
> > >
> > > +/**
> > > + * ep_event_busy_loop - loop until events available or busy poll
> > > + * times out.
> > > + *
> > > + * @ep: Pointer to the eventpoll context.
> > > + *
> > > + * Return: true if events available, false otherwise.
> > > + */
> > > +static bool ep_event_busy_loop(struct eventpoll *ep)
> > > +{
> > > +     unsigned long start_time = busy_loop_current_time();
> > > +
> > > +     while (!ep_busy_loop_end(ep, start_time))
> > > +             cond_resched();
> > > +
> > > +     return ep_events_available(ep);
> > > +}
> > > +
> > >  /*
> > >   * Busy poll if globally on and supporting sockets found && no events,
> > >   * busy loop will return if need_resched or ep_events_available.
> > > @@ -440,23 +461,29 @@ static bool ep_busy_loop(struct eventpoll *ep,
> int nonblock)
> > >  {
> > >       unsigned int napi_id = READ_ONCE(ep->napi_id);
> > >       u16 budget = READ_ONCE(ep->busy_poll_budget);
> > > -     bool prefer_busy_poll = READ_ONCE(ep->prefer_busy_poll);
> > > +     bool event_poll_only = READ_ONCE(ep->event_poll_only);
> > >
> > >       if (!budget)
> > >               budget = BUSY_POLL_BUDGET;
> > >
> > > -     if (napi_id >= MIN_NAPI_ID && ep_busy_loop_on(ep)) {
> > > +     if (!ep_busy_loop_on(ep))
> > > +             return false;
> > > +
> > > +     if (event_poll_only) {
> > > +             return ep_event_busy_loop(ep);
> > > +     } else if (napi_id >= MIN_NAPI_ID) {
> > > +             bool napi_prefer_busy_poll =
> READ_ONCE(ep->napi_prefer_busy_poll);
> > > +
> > >               napi_busy_loop(napi_id, nonblock ? NULL :
> ep_busy_loop_end,
> > > -                            ep, prefer_busy_poll, budget);
> > > +                             ep, napi_prefer_busy_poll, budget);
> > >               if (ep_events_available(ep))
> > >                       return true;
> > >               /*
> > > -              * Busy poll timed out.  Drop NAPI ID for now, we can add
> > > -              * it back in when we have moved a socket with a valid
> NAPI
> > > -              * ID onto the ready list.
> > > -              */
> > > +             * Busy poll timed out.  Drop NAPI ID for now, we can add
> > > +             * it back in when we have moved a socket with a valid NAPI
> > > +             * ID onto the ready list.
> > > +             */
> > >               ep->napi_id = 0;
> > > -             return false;
> > >       }
> > >       return false;
> > >  }
> > > @@ -523,13 +550,15 @@ static long ep_eventpoll_bp_ioctl(struct file
> *file, unsigned int cmd,
> > >
> > >               WRITE_ONCE(ep->busy_poll_usecs,
> epoll_params.busy_poll_usecs);
> > >               WRITE_ONCE(ep->busy_poll_budget,
> epoll_params.busy_poll_budget);
> > > -             WRITE_ONCE(ep->prefer_busy_poll,
> epoll_params.prefer_busy_poll);
> > > +             WRITE_ONCE(ep->napi_prefer_busy_poll,
> epoll_params.prefer_busy_poll);
> > > +             WRITE_ONCE(ep->event_poll_only,
> epoll_params.event_poll_only);
> > >               return 0;
> > >       case EPIOCGPARAMS:
> > >               memset(&epoll_params, 0, sizeof(epoll_params));
> > >               epoll_params.busy_poll_usecs =
> READ_ONCE(ep->busy_poll_usecs);
> > >               epoll_params.busy_poll_budget =
> READ_ONCE(ep->busy_poll_budget);
> > > -             epoll_params.prefer_busy_poll =
> READ_ONCE(ep->prefer_busy_poll);
> > > +             epoll_params.prefer_busy_poll =
> READ_ONCE(ep->napi_prefer_busy_poll);
> > > +             epoll_params.event_poll_only =
> READ_ONCE(ep->event_poll_only);
> > >               if (copy_to_user(uarg, &epoll_params,
> sizeof(epoll_params)))
> > >                       return -EFAULT;
> > >               return 0;
> > > @@ -2203,7 +2232,7 @@ static int do_epoll_create(int flags)
> > >  #ifdef CONFIG_NET_RX_BUSY_POLL
> > >       ep->busy_poll_usecs = 0;
> > >       ep->busy_poll_budget = 0;
> > > -     ep->prefer_busy_poll = false;
> > > +     ep->napi_prefer_busy_poll = false;
> > >  #endif
> >
> > Just FYI: This is going to conflict with a patch I've sent to VFS
> > that hasn't quite made its way back to net-next just yet.
> >
> >
> https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git/commit/?h=vfs.misc&id=4eb76c5d9a8851735fd3ec5833ecf412e8921655
> >
> Acknowledged.
> 
> > >       ep->file = file;
> > >       fd_install(fd, file);
> > > diff --git a/include/uapi/linux/eventpoll.h
> b/include/uapi/linux/eventpoll.h
> > > index 4f4b948ef3811..3bc0f4eed976c 100644
> > > --- a/include/uapi/linux/eventpoll.h
> > > +++ b/include/uapi/linux/eventpoll.h
> > > @@ -89,9 +89,10 @@ struct epoll_params {
> > >       __u32 busy_poll_usecs;
> > >       __u16 busy_poll_budget;
> > >       __u8 prefer_busy_poll;
> > > +     __u8 event_poll_only:1;
> > >
> > >       /* pad the struct to a multiple of 64bits */
> > > -     __u8 __pad;
> > > +     __u8 __pad:7;
> > >  };
> >
> > If the above is accepted then a similar change should make its way
> > into glibc, uclibc-ng, and musl. It might be easier to add an
> > entirely new ioctl.
> 
> Adding a new ioctl seems preferable, I can look into reworking the code
> accordingly.

My advice is prior to reworking the code: figure out why the results
show an improvement because I can't really see a clear explanation.

If I understand the patch correctly (and perhaps I've gotten it
wrong) it is proposing to add a new mechanism for packet processing
that is quite strange:

  Let softIRQ do the work (so there's no 'polling'), but avoid
  returning to userland and call cond_resched() to defer execution
  to other things until there's events to be returned.

Couldn't this be approximated with a smaller batch size (maxevents)
and a timeout of 0?

Perhaps consider comparing performance with a more real world
example (i.e. not tcp_rr) and use NAPI-steering in the base case to
eliminate cache locality as a variable? Maybe even compare against
the suspend mechanism Martin and I proposed?

- Joe


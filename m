Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82EBE365065
	for <lists+linux-api@lfdr.de>; Tue, 20 Apr 2021 04:37:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233308AbhDTChp (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 19 Apr 2021 22:37:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbhDTCho (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 19 Apr 2021 22:37:44 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E81A5C061763
        for <linux-api@vger.kernel.org>; Mon, 19 Apr 2021 19:37:12 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d124so24482119pfa.13
        for <linux-api@vger.kernel.org>; Mon, 19 Apr 2021 19:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=p2pDsDrI07/6DSniXPmTnlUTKqI71qMruobZPxfO5us=;
        b=GhW/Rx2g1I4Np+/nH2cLKV6wptzQWkkMD1P6JSeabGsqYWuMnkfM7Ep9KopSfTFjbQ
         r8F44rAS7kfV7GEuMJ4e9nKQUCEYdZ6x6Gxbmkvqv9qCCvIV6Q/5ObsM0Slj7DiHLajk
         zQQglL7cMdq34FAdQB69C/qoIQz4jdlpQWEwkY/bbpZ5hVaq7nuBKX+y1YPnepw8qTmc
         hmbHBqwarWXBjDDoTrn4Sqx9PrcEsO/khc8avYuz6SQkpYldjs+5EfKcPT9wU5b7gpKk
         d6sbP3Yd9O9dWyGbt6lX6Jmd3kEBjBeIPoIJYTP6UI8Jd4+DgAiWpfS3XvNX1q7WaM8v
         YuOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=p2pDsDrI07/6DSniXPmTnlUTKqI71qMruobZPxfO5us=;
        b=aqpaXoWAeHvBqDQYxGk5+UgWYSL/nCOfI4PoITw+kBBkuJHiJknQJFkCsQYJgOU0MN
         oo6DKley9edNjQnrOMVVtmPtWzn/2uuJ0waA/L2sLtRIPGxzyxgJwGQ/Bfxf5cmRzM6x
         e7sZZEKgkqxd0IeZdgVq2XVjFXIx0DJuQB8POLY0vhet5pR2wWJ53IvQFgb/2LmrdYTb
         FsVDfLV4Vc8JxnUTFVR9Q1NvQZduRtwxfBBvHdNDi13DDp2LKajAH+QjNgxn2gadeo5E
         9UJzv2iQus8WazwQvSzDBOQmEBVCHiJRyhulcQM1Q9agEcpHTtxlNrHKgTHRiNdSmKEE
         BMCQ==
X-Gm-Message-State: AOAM532wByH64pa2JeynOLPcA8EU9M2cm7eyxwsqQ+fWNftAp1Yq/3eF
        UuoL4Mf//ulGYBEn4BSLDvI55ToBc8F7DjLy
X-Google-Smtp-Source: ABdhPJzZd2ZU81MTjX8beuK104FQRSIn4kSmoKRuojYu1PTIlxqtsULYEOzB1w3qzmwTdXsqJ/r1hg==
X-Received: by 2002:a63:360d:: with SMTP id d13mr15012612pga.295.1618886232278;
        Mon, 19 Apr 2021 19:37:12 -0700 (PDT)
Received: from google.com ([2401:fa00:9:211:3810:ca7:eb2a:d336])
        by smtp.gmail.com with ESMTPSA id k13sm682121pji.14.2021.04.19.19.37.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 19:37:11 -0700 (PDT)
Date:   Tue, 20 Apr 2021 12:36:59 +1000
From:   Matthew Bobrowski <repnop@google.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Jan Kara <jack@suse.cz>, amir73il@gmail.com,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/2] fanotify: Add pidfd support to the fanotify API
Message-ID: <YH4+Swki++PHIwpY@google.com>
References: <cover.1618527437.git.repnop@google.com>
 <e6cd967f45381d20d67c9d5a3e49e3cb9808f65b.1618527437.git.repnop@google.com>
 <20210419132020.ydyb2ly6e3clhe2j@wittgenstein>
 <20210419135550.GH8706@quack2.suse.cz>
 <20210419150233.rgozm4cdbasskatk@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210419150233.rgozm4cdbasskatk@wittgenstein>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Apr 19, 2021 at 05:02:33PM +0200, Christian Brauner wrote:
> On Mon, Apr 19, 2021 at 03:55:50PM +0200, Jan Kara wrote:
> > On Mon 19-04-21 15:20:20, Christian Brauner wrote:
> > > On Fri, Apr 16, 2021 at 09:22:25AM +1000, Matthew Bobrowski wrote:
> > > > Introduce a new flag FAN_REPORT_PIDFD for fanotify_init(2) which
> > > > allows userspace applications to control whether a pidfd is to be
> > > > returned instead of a pid for `struct fanotify_event_metadata.pid`.
> > > > 
> > > > FAN_REPORT_PIDFD is mutually exclusive with FAN_REPORT_TID as the
> > > > pidfd API is currently restricted to only support pidfd generation for
> > > > thread-group leaders. Attempting to set them both when calling
> > > > fanotify_init(2) will result in -EINVAL being returned to the
> > > > caller. As the pidfd API evolves and support is added for tids, this
> > > > is something that could be relaxed in the future.
> > > > 
> > > > If pidfd creation fails, the pid in struct fanotify_event_metadata is
> > > > set to FAN_NOPIDFD(-1). Falling back and providing a pid instead of a
> > > > pidfd on pidfd creation failures was considered, although this could
> > > > possibly lead to confusion and unpredictability within userspace
> > > > applications as distinguishing between whether an actual pidfd or pid
> > > > was returned could be difficult, so it's best to be explicit.
> > > > 
> > > > Signed-off-by: Matthew Bobrowski <repnop@google.com>
> > > > ---
> > > >  fs/notify/fanotify/fanotify_user.c | 33 +++++++++++++++++++++++++++---
> > > >  include/linux/fanotify.h           |  2 +-
> > > >  include/uapi/linux/fanotify.h      |  2 ++
> > > >  3 files changed, 33 insertions(+), 4 deletions(-)
> > > > 
> > > > diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
> > > > index 9e0c1afac8bd..fd8ae88796a8 100644
> > > > --- a/fs/notify/fanotify/fanotify_user.c
> > > > +++ b/fs/notify/fanotify/fanotify_user.c
> > > > @@ -329,7 +329,7 @@ static ssize_t copy_event_to_user(struct fsnotify_group *group,
> > > >  	struct fanotify_info *info = fanotify_event_info(event);
> > > >  	unsigned int fid_mode = FAN_GROUP_FLAG(group, FANOTIFY_FID_BITS);
> > > >  	struct file *f = NULL;
> > > > -	int ret, fd = FAN_NOFD;
> > > > +	int ret, pidfd, fd = FAN_NOFD;
> > > >  	int info_type = 0;
> > > >  
> > > >  	pr_debug("%s: group=%p event=%p\n", __func__, group, event);
> > > > @@ -340,7 +340,25 @@ static ssize_t copy_event_to_user(struct fsnotify_group *group,
> > > >  	metadata.vers = FANOTIFY_METADATA_VERSION;
> > > >  	metadata.reserved = 0;
> > > >  	metadata.mask = event->mask & FANOTIFY_OUTGOING_EVENTS;
> > > > -	metadata.pid = pid_vnr(event->pid);
> > > > +
> > > > +	if (FAN_GROUP_FLAG(group, FAN_REPORT_PIDFD) &&
> > > > +		pid_has_task(event->pid, PIDTYPE_TGID)) {
> > > > +		/*
> > > > +		 * Given FAN_REPORT_PIDFD is to be mutually exclusive with
> > > > +		 * FAN_REPORT_TID, panic here if the mutual exclusion is ever
> > > > +		 * blindly lifted without pidfds for threads actually being
> > > > +		 * supported.
> > > > +		 */
> > > > +		WARN_ON(FAN_GROUP_FLAG(group, FAN_REPORT_TID));
> > > > +
> > > > +		pidfd = pidfd_create(event->pid, 0);
> > > > +		if (unlikely(pidfd < 0))
> > > > +			metadata.pid = FAN_NOPIDFD;
> > > > +		else
> > > > +			metadata.pid = pidfd;
> > > 
> > > I'm not a fan of overloading fields (Yes, we did this for the _legacy_
> > > clone() syscall for CLONE_PIDFD/CLONE_PARENT_SETTID but in general it's
> > > never a good idea if there are other options, imho.).
> > > Could/should we consider the possibility of adding a new pidfd field to
> > > struct fanotify_event_metadata?
> > 
> > I'm not a huge fan of overloading fields either but in this particular case
> > I'm fine with that because:
> > 
> > a) storage size & type matches
> > b) it describes exactly the same information, just in a different way
> > 
> > It is not possible to store the pidfd elsewhere in fanotify_event_metadata.
> > But it is certainly possible to use extended event info to return pidfd
> > instead - similarly to how we return e.g. handle + fsid for some
> > notification groups. It just means somewhat longer events and more
> > complicated parsing of structured events in userspace. But as I write
> > above, in this case I don't think it is worth it - only if we think that
> > returning both pid and pidfd could ever be useful.
> 
> Yeah, I don't hink users need to do that. After all they can parse the
> PID out of the /proc/self/fdinfo/<pidfd> file.

I agree. We can do this little PID extraction dance in userspace, it's
not a big deal at this point IMO.

> A general question about struct fanotify_event_metadata and its
> extensibility model:
> looking through the code it seems that this struct is read via
> fanotify_rad(). So the user is expected to supply a buffer with at least
> 
> #define FAN_EVENT_METADATA_LEN (sizeof(struct fanotify_event_metadata))
> 
> bytes. In addition you can return the info to the user about how many
> bytes the kernel has written from fanotify_read().
> 
> So afaict extending fanotify_event_metadata should be _fairly_
> straightforward, right? It would essentially the complement to
> copy_struct_from_user() which Aleksa and I added (1 or 2 years ago)
> which deals with user->kernel and you're dealing with kernel->user:
> - If the user supplied a buffer smaller than the minimum known struct
>   size -> reject.
> - If the user supplied a buffer < smaller than what the current kernel
>   supports -> copy only what userspace knows about, and return the size
>   userspace knows about.
> - If the user supplied a buffer that is larger than what the current
>   kernel knows about -> copy only what the kernel knows about, zero the
>   rest, and return the kernel size.
> 
> Extension should then be fairly straightforward (64bit aligned
> increments)?

You'd think that it's fairly straightforward, but I have a feeling
that the whole fanotify_event_metadata extensibility discussion and
the current limitation to do so revolves around whether it can be
achieved in a way which can guarantee that no userspace applications
would break. I think the answer to this is that there's no guarantee
because of <<reasons>>, so the decision to extend fanotify's feature
set was done via other means i.e. introduction of additional
structures.

/M

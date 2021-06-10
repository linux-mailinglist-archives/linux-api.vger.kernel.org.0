Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D26D73A256E
	for <lists+linux-api@lfdr.de>; Thu, 10 Jun 2021 09:25:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230470AbhFJH1p (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 10 Jun 2021 03:27:45 -0400
Received: from mail-pj1-f44.google.com ([209.85.216.44]:56221 "EHLO
        mail-pj1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230136AbhFJH1e (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 10 Jun 2021 03:27:34 -0400
Received: by mail-pj1-f44.google.com with SMTP id k7so3109131pjf.5
        for <linux-api@vger.kernel.org>; Thu, 10 Jun 2021 00:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XcUEI16ALb5GgW+UVrUnX4fue34D+7ULda2k5ZCrDto=;
        b=D0HcA7G8j989gqeD2tAswToqZ3OjIVq76zLvL7qijhhQg39/8RZlnUBb73esda5GjC
         yj4dR+k3LBXcKPPbF/eD3aBkQX5l/2zOlqLu3RyGz/emk65OiYo/0aRK1SnULbDAUruy
         EPYelmmxCPOXSKngrCAyb1NuaKDucRGmkaMYfgC/ACXdRCcrQvBycDPto2g3xsrUxdwQ
         Cfj673pNZZRpN8BsC0NK4NzmZ4y2NMwOmaQVkzcp64+XSG7RrgclmJ51IkHO3p5aI8x1
         Nn/gBqJgJSz33b8vLkEigPx7GM5L+zZD3+l1iW8BjFOYaPu9x5wbXFwwPB/XQ68tfE+G
         pynw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XcUEI16ALb5GgW+UVrUnX4fue34D+7ULda2k5ZCrDto=;
        b=BjQd6gVwBJIcywcrwnRWnrJTG+KBBLPrPbqQLA9A2/8WV7cWykJ7RZkf9bp4nn1Kn3
         3AMZWmYCvaOaavS9B7cj93ksAlh29sd9DmML8mzO9bzGu2/smNgw9mdK4ol5TPU2nVqV
         JxwmmwJ7ohUb2aF88U++CNZjie3bKHEJlNRc+MKEH3eQfhKkyKoHoryLCl5VS3B1ERp5
         ss89EU9mXrQX3LNhWZ0nGZrJGncLL5Lm31ncBu/hK6a/TV9hGjv3WAfxpJ0mH7a9fjfA
         dUql76gPz4B2o+o7hQetaePHzYvqwDRLD5swvUfKU61iDx7PEDID4W4aeY0Ihn1S1AMQ
         xIMw==
X-Gm-Message-State: AOAM532n1qKkMf9hV+HrGuHw5Hfo0R7SqpZBENgDLKo+tSkCnuOYf1Fe
        170P3/ib42M0apu6JLdFi1WVDA==
X-Google-Smtp-Source: ABdhPJz+0izmsJQXZBosjTNVF6J95vSTI79mUoQ7YZWjPYsGyarATv8FQKlIhN/+px2k60pIRKoeyQ==
X-Received: by 2002:a17:90b:901:: with SMTP id bo1mr1991970pjb.0.1623309878331;
        Thu, 10 Jun 2021 00:24:38 -0700 (PDT)
Received: from google.com ([2401:fa00:9:211:6512:d64a:3615:dcbf])
        by smtp.gmail.com with ESMTPSA id g29sm1728468pgm.11.2021.06.10.00.24.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 00:24:37 -0700 (PDT)
Date:   Thu, 10 Jun 2021 17:24:25 +1000
From:   Matthew Bobrowski <repnop@google.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: [PATCH v2 5/5] fanotify: add pidfd support to the fanotify API
Message-ID: <YMG+KQ6Cl+Vfk1rF@google.com>
References: <cover.1623282854.git.repnop@google.com>
 <7f9d3b7815e72bfee92945cab51992f9db6533dd.1623282854.git.repnop@google.com>
 <CAOQ4uxj2t+z1BWimWKKTae3saDbZQ=-h+6JSnr=Vyv1=rGT0Jw@mail.gmail.com>
 <YMGyrJMwpvqU2kcr@google.com>
 <CAOQ4uxhV32Qbk=uyxNEhUkdqzqspib=5FY_J6N-0HdLizDEAXA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxhV32Qbk=uyxNEhUkdqzqspib=5FY_J6N-0HdLizDEAXA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, Jun 10, 2021 at 10:11:51AM +0300, Amir Goldstein wrote:
> > > > +               ret = copy_info_records_to_user(event, info, info_mode, pidfd,
> > > > +                                               buf, count);
> > > >                 if (ret < 0)
> > > > -                       return ret;
> > > > +                       goto out_close_fd;
> > >
> > > This looks like a bug in upstream.
> >
> > Yes, I'm glad this was picked up and I was actually wondering why it was
> > acceptable to directly return without jumping to the out_close_fd label in
> > the case of an error. I felt like it may have been a burden to raise the
> > question in the first place because I thought that this got picked up in
> > the review already and there was a good reason for having it, despite not
> > really making much sense.
> >
> > > It should have been goto out_close_fd to begin with.
> > > We did already copy metadata.fd to user, but the read() call
> > > returns an error.
> > > You should probably fix it before the refactoring patch, so it
> > > can be applied to stable kernels.
> >
> > Sure, I will send through a patch fixing this before submitting the next
> > version of this series though. How do I tag the patch so that it's picked
> > up an back ported accordingly?
> >
> 
> The best option, in case this is a regression (it probably is)
> is the Fixes: tag which is both a clear indication for stale
> candidate patch tells the bots exactly which stable kernel the
> patch should be applied to.
> 
> Otherwise, you can Cc: stable (see examples in git)
> and generally any commit title with the right keywords
> 'fix' 'regression' 'bug' should be caught but the stable AI bots.

Ah, OK, noted.

> > > >         }
> > > >
> > > >         return metadata.event_len;
> > > > @@ -558,6 +632,10 @@ static ssize_t copy_event_to_user(struct fsnotify_group *group,
> > > >                 put_unused_fd(fd);
> > > >                 fput(f);
> > > >         }
> > > > +
> > > > +       if (pidfd < 0)
> > >
> > > That condition is reversed.
> > > We do not seem to have any test coverage for this error handling
> > > Not so surprising that upstream had a bug...
> >
> > Sorry Amir, I don't quite understand what you mean by "That condition is
> > reversed". Presumably you're referring to the fd != FAN_NOFD check and not
> > pidfd < 0 here.
> >
> 
> IDGI, why is the init/cleanup code not as simple as
> 
>     int pidfd = FAN_NOPIDFD;
> ...
> out_close_fd:
> ...
>        if (pidfd >= 0)
>                  put_unused_fd(fd);

You're missing nothing, it's me that's missing a few brain cells. Sorry,
the context switching on my end is real and I had overlooked what you
meant. But yes, this will most definitely work.

/M

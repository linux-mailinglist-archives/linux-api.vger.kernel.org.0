Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 010943A2490
	for <lists+linux-api@lfdr.de>; Thu, 10 Jun 2021 08:35:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbhFJGhi (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 10 Jun 2021 02:37:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbhFJGhi (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 10 Jun 2021 02:37:38 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5038EC061574
        for <linux-api@vger.kernel.org>; Wed,  9 Jun 2021 23:35:37 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id k22-20020a17090aef16b0290163512accedso4953879pjz.0
        for <linux-api@vger.kernel.org>; Wed, 09 Jun 2021 23:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VQzSUIz6Nm/SC/dxfPmHIbJyhC+zja5e9VO1OcbRecw=;
        b=DFgMRTZqVC3P+H2Ec5Qleobh1q9ioIRp9ogL8Xo48/O6yYDBeRX4ce/ffnRHsdMxn1
         qCglaPo1mmQ/zUq8RR6GZ1e2eU5/XD4xNJZDqf0nIJysNLEiowXZJCdERpEZOyaaABN3
         o2qZaZVegIiFHeKEZ1KLpNiFF9v52NfX3/ChlF6+CrO9HVGeeEylDedO9dpZXpR91PJC
         fzNDyL6XljNw+YE/4XMhLURcxC7mFpKlX++AvZHOMJGe/BlVT6HHkNH4i5NpAA1zq9XW
         MdcnBhc1oppkG9szMUTEmfCF0bMjySrh9N4r1Ronqc3qgIHvp5wT27qnjAm7fEylD+7o
         9oag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VQzSUIz6Nm/SC/dxfPmHIbJyhC+zja5e9VO1OcbRecw=;
        b=SkvsxfwtwiKJFOnJ6jq0ddARoWw+HsYjuUj7Fk2PM8kTVli+qI1BBD1CISG3+7d/0N
         LkwkN1O3/nT29GZhO9X9EhAUEbCTwF42r127WmRNXkfsmWQCoqRnR+hbwlUq7XBGWTyC
         9HYz6Ob68otHp6nGqCXh0ErnzF/po3OTLv7W3sfGG9mMb7ixtM1JzwYN2iZKTIN9OGs+
         PfLOD/aVJRN2Tx0F7K+p2O+wB77Av1RRjTczhIHtCUi0CGCNm4wRbfjG92mrNa+OYgyS
         OtTAdWkVwO4hYa0kUPhsznTQ6UIAORvzYJ+Xja7cGYkk3Lh481zuQRKbvcGttI7tNsnO
         g4DQ==
X-Gm-Message-State: AOAM532/VFZu3wIFjacpSnp74C2fges82wEqvDvpgNBxS3cCL3th/yRB
        8Z1KZePcMhL4mcKLS1iT4BwJQA==
X-Google-Smtp-Source: ABdhPJwBRkR4zoUbkiwvtAJstFwS6S6U3eq7LhEbB9SiPmVs5aJB67dL99Fmjf+3aeK7GpSHxb3wKQ==
X-Received: by 2002:a17:90a:a40a:: with SMTP id y10mr1717862pjp.151.1623306936648;
        Wed, 09 Jun 2021 23:35:36 -0700 (PDT)
Received: from google.com ([2401:fa00:9:211:6512:d64a:3615:dcbf])
        by smtp.gmail.com with ESMTPSA id o9sm1452471pfh.217.2021.06.09.23.35.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jun 2021 23:35:36 -0700 (PDT)
Date:   Thu, 10 Jun 2021 16:35:24 +1000
From:   Matthew Bobrowski <repnop@google.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: [PATCH v2 5/5] fanotify: add pidfd support to the fanotify API
Message-ID: <YMGyrJMwpvqU2kcr@google.com>
References: <cover.1623282854.git.repnop@google.com>
 <7f9d3b7815e72bfee92945cab51992f9db6533dd.1623282854.git.repnop@google.com>
 <CAOQ4uxj2t+z1BWimWKKTae3saDbZQ=-h+6JSnr=Vyv1=rGT0Jw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxj2t+z1BWimWKKTae3saDbZQ=-h+6JSnr=Vyv1=rGT0Jw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, Jun 10, 2021 at 08:18:01AM +0300, Amir Goldstein wrote:
> On Thu, Jun 10, 2021 at 3:22 AM Matthew Bobrowski <repnop@google.com> wrote:
> > @@ -489,8 +525,9 @@ static ssize_t copy_event_to_user(struct fsnotify_group *group,
> >         struct path *path = fanotify_event_path(event);
> >         struct fanotify_info *info = fanotify_event_info(event);
> >         unsigned int info_mode = FAN_GROUP_FLAG(group, FANOTIFY_INFO_MODES);
> > +       unsigned int pidfd_mode = info_mode & FAN_REPORT_PIDFD;
> >         struct file *f = NULL;
> > -       int ret, fd = FAN_NOFD;
> > +       int ret, pidfd = 0, fd = FAN_NOFD;
> 
> It feels like this should be pidfd = FAN_NOPIDFD?

I had considered this, but in all honesty I wasn't sure what the behavior
is when put_unused_fd() is provided a negative value, nor whether it is
accepted. The way I saw it was that if fid info record copying had errored
out for whatever reason and we jumped to the out_close_fd label we'd also,
perhaps unnecessarily, take the pidfd clean up route, which IMO wouldn't be
required.

> >
> >         pr_debug("%s: group=%p event=%p\n", __func__, group, event);
> >
> > @@ -524,6 +561,34 @@ static ssize_t copy_event_to_user(struct fsnotify_group *group,
> >         }
> >         metadata.fd = fd;
> >
> > +       /*
> > +        * Currently, reporting a pidfd to an unprivileged listener is not
> > +        * supported. The FANOTIFY_UNPRIV flag is to be kept here so that a
> > +        * pidfd is not accidentally leaked to an unprivileged listener.
> > +        */
> > +       if (pidfd_mode && !FAN_GROUP_FLAG(group, FANOTIFY_UNPRIV)) {
> > +               /*
> > +                * The PIDTYPE_TGID check for an event->pid is performed
> > +                * preemptively in attempt to catch those rare instances
> > +                * where the process responsible for generating the event has
> > +                * terminated prior to calling into pidfd_create() and
> > +                * acquiring a valid pidfd. Report FAN_NOPIDFD to the listener
> > +                * in those cases.
> > +                */
> > +               if (metadata.pid == 0 ||
> > +                   !pid_has_task(event->pid, PIDTYPE_TGID)) {
> > +                       pidfd = FAN_NOPIDFD;
> > +               } else {
> > +                       pidfd = pidfd_create(event->pid, 0);
> > +                       if (pidfd < 0)
> > +                               /*
> > +                                * All other pidfd creation errors are reported
> > +                                * as FAN_EPIDFD to the listener.
> > +                                */
> > +                               pidfd = FAN_EPIDFD;
> 
> That's an anti pattern. a multi-line statement, even due to comment should
> be inside {}, but in this case, I think it is better to put this
> comment as another
> line in the big comment above which explains both the if and the else, because
> it is in fact a continuation of the comment above.

Ah, right, I didn't know that this was considered as an anti-pattern. But
then again, I can totally understand why it would be. No objections with
merging this comment with the one that precedes the parent if statement.

> > +               }
> > +       }
> > +
> >         ret = -EFAULT;
> >         /*
> >          * Sanity check copy size in case get_one_event() and
> > @@ -545,10 +610,19 @@ static ssize_t copy_event_to_user(struct fsnotify_group *group,
> >                 fd_install(fd, f);
> >
> >         if (info_mode) {
> > -               ret = copy_info_records_to_user(event, info, info_mode,
> > -                                               buf, count);
> > +               /*
> > +                * Complain if the FAN_REPORT_PIDFD and FAN_REPORT_TID mutual
> > +                * exclusion is ever lifted. At the time of incorporating pidfd
> > +                * support within fanotify, the pidfd API only supported the
> > +                * creation of pidfds for thread-group leaders.
> > +                */
> > +               WARN_ON_ONCE(pidfd_mode &&
> > +                            FAN_GROUP_FLAG(group, FAN_REPORT_TID));
> > +
> 
> This WARN_ON, if needed at all, would be better places inside if (pidfd_mode &&
> code block above where you would only need to
>      WARN_ON_ONCE(FAN_GROUP_FLAG(group, FAN_REPORT_TID));
> as close as possible to PIDTYPE_TGID line.

Agree, there's no reason why it can't be moved to the above pidfd_mode
check.

> > +               ret = copy_info_records_to_user(event, info, info_mode, pidfd,
> > +                                               buf, count);
> >                 if (ret < 0)
> > -                       return ret;
> > +                       goto out_close_fd;
> 
> This looks like a bug in upstream.

Yes, I'm glad this was picked up and I was actually wondering why it was
acceptable to directly return without jumping to the out_close_fd label in
the case of an error. I felt like it may have been a burden to raise the
question in the first place because I thought that this got picked up in
the review already and there was a good reason for having it, despite not
really making much sense.

> It should have been goto out_close_fd to begin with.
> We did already copy metadata.fd to user, but the read() call
> returns an error.
> You should probably fix it before the refactoring patch, so it
> can be applied to stable kernels.

Sure, I will send through a patch fixing this before submitting the next
version of this series though. How do I tag the patch so that it's picked
up an back ported accordingly?

> >         }
> >
> >         return metadata.event_len;
> > @@ -558,6 +632,10 @@ static ssize_t copy_event_to_user(struct fsnotify_group *group,
> >                 put_unused_fd(fd);
> >                 fput(f);
> >         }
> > +
> > +       if (pidfd < 0)
> 
> That condition is reversed.
> We do not seem to have any test coverage for this error handling
> Not so surprising that upstream had a bug...

Sorry Amir, I don't quite understand what you mean by "That condition is
reversed". Presumably you're referring to the fd != FAN_NOFD check and not
pidfd < 0 here.

/M

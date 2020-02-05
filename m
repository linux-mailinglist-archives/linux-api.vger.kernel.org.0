Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44B1C153B7F
	for <lists+linux-api@lfdr.de>; Wed,  5 Feb 2020 23:57:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727782AbgBEW5C (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 5 Feb 2020 17:57:02 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:40307 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727486AbgBEW5C (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 5 Feb 2020 17:57:02 -0500
Received: by mail-ed1-f68.google.com with SMTP id p3so3858818edx.7
        for <linux-api@vger.kernel.org>; Wed, 05 Feb 2020 14:56:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Amzhmy9xv9aiOonSPr+eThtNwsfLtl5zGLSppwlbgNs=;
        b=Rr3ZuwxjBG88ry1cXtNHdnsHK7RNLh2i2hW7ZcjXrXXVz1dH4kyMtKdSaBC1CgHQur
         rCvuy3O+y+wkmSkopUyOF1OMDhD5Hx2sYMQ0meeghuuW5a+Zn08zQjCRISQh9rPkNdLI
         59Z8ME76zI91V5UP7hugC1xMeu73AOuDGvfa7wKGNTbTsSdGgEMMiHozgfut4YcVzURe
         G2c9J84y+lzCAe08WlYOCgBuodxP7gxMj+eT09LfB5r+cyv9tJ1KYWxRm+MN59LjZBco
         Q6x5NKczijf5H13m8eUXysrheth2N8SEecoHY/HTzEDU+eOsPj0dHABPnKvVDueKZ0ND
         s2Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Amzhmy9xv9aiOonSPr+eThtNwsfLtl5zGLSppwlbgNs=;
        b=oDe+Fq43EGLXU87+/LvsYATQckGaSq6c1ZTrM+bMGlqiiXdIMgKcGMeMOVajrpBall
         /cX+tNpqMa9yVYK7KIZZZz3HIsxscL9qDTj9b7bENJPW8awPo9fVvqTUkXGJD+6A/O02
         81auD47BLi8YfjrFdPmEKN6FH0ObHsOijzJNFmqW4GBuhVJLF6MhyTMKK5qMLtKvMdAH
         qzcuexWw604Cjeqzoqa52VWkTOjz6yPzXmICn+fNLojVaipsnTAXTheNAPPRE6s4u9mp
         DF+xFnaAZGdGhWHtJiLjZLEg7u+OWHzqBMz8YMBdUqKhWELtqHoJCvrGOGyFmDiiCmFU
         kOCA==
X-Gm-Message-State: APjAAAWdE4LayIDFSWYOllK2O4jc5MDwA/y6jx6WEgv5q5T/Idm5n8u+
        szsF9QPbOAI3sMMmsjt/q+h4FjXPFvkHgoP4EfIA
X-Google-Smtp-Source: APXvYqyinVfnH51DI0L2SrSFONQ5jPWbqu4SEEJkGSvze4nkV8Nj8TjI5cDCggcgijMU0lqRKjn1C1Mv8js0mEJYleE=
X-Received: by 2002:a17:906:19d0:: with SMTP id h16mr350075ejd.70.1580943419104;
 Wed, 05 Feb 2020 14:56:59 -0800 (PST)
MIME-Version: 1.0
References: <cover.1577736799.git.rgb@redhat.com> <5941671b6b6b5de28ab2cc80e72f288cf83291d5.1577736799.git.rgb@redhat.com>
 <CAHC9VhQYXQp+C0EHwLuW50yUenfH4KF1xKQdS=bn_OzHfnFmmg@mail.gmail.com> <20200205003930.2efpm4tvrisgmj4t@madcap2.tricolour.ca>
In-Reply-To: <20200205003930.2efpm4tvrisgmj4t@madcap2.tricolour.ca>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 5 Feb 2020 17:56:48 -0500
Message-ID: <CAHC9VhSsfBbfYmqLoR=QBgF5_VwbA8Dqqz97MjqwwJ6Jq6fHwA@mail.gmail.com>
Subject: Re: [PATCH ghak90 V8 16/16] audit: add capcontid to set contid
 outside init_user_ns
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     containers@lists.linux-foundation.org, linux-api@vger.kernel.org,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        netdev@vger.kernel.org, netfilter-devel@vger.kernel.org,
        sgrubb@redhat.com, omosnace@redhat.com, dhowells@redhat.com,
        simo@redhat.com, Eric Paris <eparis@parisplace.org>,
        Serge Hallyn <serge@hallyn.com>, ebiederm@xmission.com,
        nhorman@tuxdriver.com, Dan Walsh <dwalsh@redhat.com>,
        mpatel@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, Feb 4, 2020 at 7:39 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> On 2020-01-22 16:29, Paul Moore wrote:
> > On Tue, Dec 31, 2019 at 2:51 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> > >
> > > Provide a mechanism similar to CAP_AUDIT_CONTROL to explicitly give a
> > > process in a non-init user namespace the capability to set audit
> > > container identifiers.
> > >
> > > Provide /proc/$PID/audit_capcontid interface to capcontid.
> > > Valid values are: 1==enabled, 0==disabled
> >
> > It would be good to be more explicit about "enabled" and "disabled" in
> > the commit description.  For example, which setting allows the target
> > task to set audit container IDs of it's children processes?
>
> Ok...
>
> > > Report this action in message type AUDIT_SET_CAPCONTID 1022 with fields
> > > opid= capcontid= old-capcontid=
> > >
> > > Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> > > ---
> > >  fs/proc/base.c             | 55 ++++++++++++++++++++++++++++++++++++++++++++++
> > >  include/linux/audit.h      | 14 ++++++++++++
> > >  include/uapi/linux/audit.h |  1 +
> > >  kernel/audit.c             | 35 +++++++++++++++++++++++++++++
> > >  4 files changed, 105 insertions(+)

...

> > > diff --git a/kernel/audit.c b/kernel/audit.c
> > > index 1287f0b63757..1c22dd084ae8 100644
> > > --- a/kernel/audit.c
> > > +++ b/kernel/audit.c
> > > @@ -2698,6 +2698,41 @@ static bool audit_contid_isowner(struct task_struct *tsk)
> > >         return false;
> > >  }
> > >
> > > +int audit_set_capcontid(struct task_struct *task, u32 enable)
> > > +{
> > > +       u32 oldcapcontid;
> > > +       int rc = 0;
> > > +       struct audit_buffer *ab;
> > > +
> > > +       if (!task->audit)
> > > +               return -ENOPROTOOPT;
> > > +       oldcapcontid = audit_get_capcontid(task);
> > > +       /* if task is not descendant, block */
> > > +       if (task == current)
> > > +               rc = -EBADSLT;
> > > +       else if (!task_is_descendant(current, task))
> > > +               rc = -EXDEV;
> >
> > See my previous comments about error code sanity.
>
> I'll go with EXDEV.
>
> > > +       else if (current_user_ns() == &init_user_ns) {
> > > +               if (!capable(CAP_AUDIT_CONTROL) && !audit_get_capcontid(current))
> > > +                       rc = -EPERM;
> >
> > I think we just want to use ns_capable() in the context of the current
> > userns to check CAP_AUDIT_CONTROL, yes?  Something like this ...
>
> I thought we had firmly established in previous discussion that
> CAP_AUDIT_CONTROL in anything other than init_user_ns was completely irrelevant
> and untrustable.

In the case of a container with multiple users, and multiple
applications, one being a nested orchestrator, it seems relevant to
allow that container to control which of it's processes are able to
exercise CAP_AUDIT_CONTROL.  Granted, we still want to control it
within the overall host, e.g. the container in question must be
allowed to run a nested orchestrator, but allowing the container
itself to provide it's own granularity seems like the right thing to
do.

> >   if (current_user_ns() != &init_user_ns) {
> >     if (!ns_capable(CAP_AUDIT_CONTROL) || !audit_get_capcontid())
> >       rc = -EPERM;
> >   } else if (!capable(CAP_AUDIT_CONTROL))
> >     rc = -EPERM;
> >

-- 
paul moore
www.paul-moore.com

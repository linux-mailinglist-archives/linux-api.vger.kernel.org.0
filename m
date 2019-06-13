Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3EF3544D5E
	for <lists+linux-api@lfdr.de>; Thu, 13 Jun 2019 22:26:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728857AbfFMUZ4 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 13 Jun 2019 16:25:56 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:46537 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726530AbfFMUZ4 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 13 Jun 2019 16:25:56 -0400
Received: by mail-io1-f68.google.com with SMTP id i10so710490iol.13
        for <linux-api@vger.kernel.org>; Thu, 13 Jun 2019 13:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wxJBMcBvwVkpAf1cgG4dPli24Ww6q68XEHKC5A8aObk=;
        b=bj2NYJPmryyGgICLn1E4HRmF1agezEr1mo/1DGIrMGTjMFw2iRKv0i5eOhE8Zta66r
         U6KFwJt4gOWZi92tahMKfmQ8UY8j/pm+wRNG67dGzNobX9JOaEDJGZJVbFDwUGqEwzg2
         cnnWpEBl0bH0iH50UGlUHlLISbl3cSfjL8rEU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wxJBMcBvwVkpAf1cgG4dPli24Ww6q68XEHKC5A8aObk=;
        b=WLj1FXaBlwhFZmjcBeU7CYkqHlWO3lAdKrVNAFWiEI7QgzOCD4IvCpOS3xGwgawkrQ
         Sei14+2CYT1neL6mxBx1qjDzENzaI20gj5Dk9upnn9RXv9BvX9d62DenP/CsHaSXcPT6
         iHktDGwfQ5ljTiPG9Hc1MKRYmbHzChQLLnxNvAya2at0rZ2LDE/6PgEBb8Kn4w4neT1J
         az5ZJgyJELzWlYqbshovTrSTdhJLdEtsNtL2oRizF9UTTKCr1bgiQeGLXbdha/1WzxI5
         XZl26A50av6J0mRqgFEdHhSF9rWsoV+HtDAQB9I9xARdQAO7rBGQq/dMYWtAWk+ZxvCm
         4Ufw==
X-Gm-Message-State: APjAAAXf+cMzxpa9sf7y8YA+h6Sr7mX2eaWvX2uxuda33OQHlg+Q/ZVN
        QfB2iUoT8u6B3Zd7hIpqTFJgf21VB95SXZL1XQbISw==
X-Google-Smtp-Source: APXvYqz+u/akT0s3tkUOtvxwHIrlqT8vSdlw0YMYd4SB0cK2+55b9TPncxxRXStL5TgLhYKlUMfXiQLo1cX/FwEAB+w=
X-Received: by 2002:a6b:7e41:: with SMTP id k1mr14643948ioq.285.1560457555275;
 Thu, 13 Jun 2019 13:25:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190612225431.p753mzqynxpsazb7@brauner.io> <CAHk-=wh2Khe1Lj-Pdu3o2cXxumL1hegg_1JZGJXki6cchg_Q2Q@mail.gmail.com>
 <20190613132250.u65yawzvf4voifea@brauner.io> <871rzxwcz7.fsf@xmission.com>
In-Reply-To: <871rzxwcz7.fsf@xmission.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 13 Jun 2019 22:25:44 +0200
Message-ID: <CAJfpegvZwDY+zoWjDTrPpMCS01rzQgeE-_z-QtGfvcRnoamzgg@mail.gmail.com>
Subject: Re: Regression for MS_MOVE on kernel v5.1
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Christian Brauner <christian@brauner.io>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        David Howells <dhowells@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, Jun 13, 2019 at 8:35 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> Christian Brauner <christian@brauner.io> writes:
>
> > On Wed, Jun 12, 2019 at 06:00:39PM -1000, Linus Torvalds wrote:
> >> On Wed, Jun 12, 2019 at 12:54 PM Christian Brauner <christian@brauner.io> wrote:
> >> >
> >> > The commit changes the internal logic to lock mounts when propagating
> >> > mounts (user+)mount namespaces and - I believe - causes do_mount_move()
> >> > to fail at:
> >>
> >> You mean 'do_move_mount()'.
> >>
> >> > if (old->mnt.mnt_flags & MNT_LOCKED)
> >> >         goto out;
> >> >
> >> > If that's indeed the case we should either revert this commit (reverts
> >> > cleanly, just tested it) or find a fix.
> >>
> >> Hmm.. I'm not entirely sure of the logic here, and just looking at
> >> that commit 3bd045cc9c4b ("separate copying and locking mount tree on
> >> cross-userns copies") doesn't make me go "Ahh" either.
> >>
> >> Al? My gut feel is that we need to just revert, since this was in 5.1
> >> and it's getting reasonably late in 5.2 too. But maybe you go "guys,
> >> don't be silly, this is easily fixed with this one-liner".
> >
> > David and I have been staring at that code today for a while together.
> > I think I made some sense of it.
> > One thing we weren't absolutely sure is if the old MS_MOVE behavior was
> > intentional or a bug. If it is a bug we have a problem since we quite
> > heavily rely on this...
>
> It was intentional.
>
> The only mounts that are locked in propagation are the mounts that
> propagate together.  If you see the mounts come in as individuals you
> can always see/manipulate/work with the underlying mount.
>
> I can think of only a few ways for MNT_LOCKED to become set:
> a) unshare(CLONE_NEWNS)
> b) mount --rclone /path/to/mnt/tree /path/to/propagation/point
> c) mount --move /path/to/mnt/tree /path/to/propgation/point
>
> Nothing in the target namespace should be locked on the propgation point
> but all of the new mounts that came across as a unit should be locked
> together.

Locked together means the root of the new mount tree doesn't have
MNT_LOCKED set, but all mounts below do have MNT_LOCKED, right?

Isn't the bug here that the root mount gets MNT_LOCKED as well?

>
> Then it breaking is definitely a regression that needs to be fixed.
>
> I believe the problematic change as made because the new mount
> api allows attaching floating mounts.  Or that was the plan last I
> looked.   Those floating mounts don't have a mnt_ns so will result
> in a NULL pointer dereference when they are attached.

Well, it's called anonymous namespace.  So there *is* an mnt_ns, and
its lifetime is bound to the file returned by fsmount().

Thanks,
Miklos

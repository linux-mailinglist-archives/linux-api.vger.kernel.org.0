Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B534917D00F
	for <lists+linux-api@lfdr.de>; Sat,  7 Mar 2020 21:48:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726174AbgCGUsr (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sat, 7 Mar 2020 15:48:47 -0500
Received: from mail-il1-f195.google.com ([209.85.166.195]:33327 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbgCGUsr (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sat, 7 Mar 2020 15:48:47 -0500
Received: by mail-il1-f195.google.com with SMTP id k29so73898ilg.0
        for <linux-api@vger.kernel.org>; Sat, 07 Mar 2020 12:48:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZlaiWBNqvrdyvkEefn9yJWjZp7C2bAb1YLICnuJhP8I=;
        b=PV3bf2R9X3sQruGbBjzJvFY4AOshOxYvj+SiyibH20IZIQwjIExrhsqLUFM6P6R+lL
         LrAJRQjI/qJXCe04P0VvuJgkt9vJeW2qTNk71iIlLi/SHzLO0MvLutNTnfsD4TjmaXrj
         pun1BhXPZ65cZKYbR1qBfSXAyqWEqWfjqbGtM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZlaiWBNqvrdyvkEefn9yJWjZp7C2bAb1YLICnuJhP8I=;
        b=qvj+BquNn7uKqv7flQnLEuqqxSXW8ISxjUB9EH87eK7XJT1wXADBmrFd02p6p/0t4d
         I2Jrk4Bh3T59F9HMriNAp5i/09rACoovtGdvhm+UwOwpdMuwGy5XYxJsSXMkVZEQXAPv
         nJEinOtqvwaD7FyEBLBZVkcUeXRsh+OvMAdroZ1yzGBmofiltf11SwRn7PCx73Y3oZFN
         9EC31XS/2gTLobEZYHQm6E2HOMaYOuGavoOIYWoBrtRjN6Rsyds3sacxdG8b+F92ncPN
         sh8ljwzSXy919mU61ibuabGqT5TJGyVVrZk6cc9OatY7xeqU5fa2kam23jLonDiBrKLr
         u+LQ==
X-Gm-Message-State: ANhLgQ1C29dNxmUIodOUG/iQY8w/piXywJr+KJvifVnQCCDnsVKMXCfq
        7TaLVR/aB68Ot88gHpeXPESHYZaoz/cRNMhjw0ZMFA==
X-Google-Smtp-Source: ADFU+vskwVXCTzkhh+ZXd7Wbqe2WHoM17S7U48HvUGcGrtwnAQOiiNlg5R1xofLf5jp6bJ1vVeTIGj3wJCAenoDZ5x8=
X-Received: by 2002:a92:d745:: with SMTP id e5mr8793655ilq.285.1583614126795;
 Sat, 07 Mar 2020 12:48:46 -0800 (PST)
MIME-Version: 1.0
References: <1582556135.3384.4.camel@HansenPartnership.com>
 <CAJfpegsk6BsVhUgHNwJgZrqcNP66wS0fhCXo_2sLt__goYGPWg@mail.gmail.com>
 <a657a80e-8913-d1f3-0ffe-d582f5cb9aa2@redhat.com> <1582644535.3361.8.camel@HansenPartnership.com>
 <20200228155244.k4h4hz3dqhl7q7ks@wittgenstein> <107666.1582907766@warthog.procyon.org.uk>
 <CAJfpegu0qHBZ7iK=R4ajmmHC4g=Yz56otpKMy5w-y0UxJ1zO+Q@mail.gmail.com>
 <0403cda7345e34c800eec8e2870a1917a8c07e5c.camel@themaw.net>
 <CAJfpegtu6VqhPdcudu79TX3e=_NZaJ+Md3harBGV7Bg_-+fR8Q@mail.gmail.com>
 <20200306162549.GA28467@miu.piliscsaba.redhat.com> <20200307094834.GA3888906@kroah.com>
In-Reply-To: <20200307094834.GA3888906@kroah.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Sat, 7 Mar 2020 21:48:35 +0100
Message-ID: <CAJfpegvOi0ZPEW4Aq8N8SPDwiEw8Tgzo-ngf30WNmHXBdfHnqA@mail.gmail.com>
Subject: Re: [PATCH 00/17] VFS: Filesystem information and notifications [ver #17]
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Ian Kent <raven@themaw.net>, David Howells <dhowells@redhat.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Steven Whitehouse <swhiteho@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Jann Horn <jannh@google.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Sat, Mar 7, 2020 at 10:48 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Fri, Mar 06, 2020 at 05:25:49PM +0100, Miklos Szeredi wrote:
> > On Tue, Mar 03, 2020 at 08:46:09AM +0100, Miklos Szeredi wrote:
> > >
> > > I'm doing a patch.   Let's see how it fares in the face of all these
> > > preconceptions.
> >
> > Here's a first cut.  Doesn't yet have superblock info, just mount info.
> > Probably has rough edges, but appears to work.
> >
> > I started with sysfs, then kernfs, then went with a custom filesystem, because
> > neither could do what I wanted.
>
> Hm, what is wrong with kernfs that prevented you from using it here?
> Just complexity or something else?

I wanted to have a single instance covering all the namespaces, with
just a filtered view depending on which namespace the task is looking
at it.

Having a kernfs_node for each attribute is also rather heavy compared
to the size of struct mount.

Thanks,
Miklos

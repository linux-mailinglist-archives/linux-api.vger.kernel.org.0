Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5EE4017C691
	for <lists+linux-api@lfdr.de>; Fri,  6 Mar 2020 20:54:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbgCFTyZ (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 6 Mar 2020 14:54:25 -0500
Received: from mail-il1-f193.google.com ([209.85.166.193]:44071 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725873AbgCFTyY (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 6 Mar 2020 14:54:24 -0500
Received: by mail-il1-f193.google.com with SMTP id j69so3116979ila.11
        for <linux-api@vger.kernel.org>; Fri, 06 Mar 2020 11:54:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l7Yr6iThBvFiVFuCMIOneOYkdq7rfICUbWrdUVOauj8=;
        b=a/IuF7wJJcvi7R3raqpSjmvjHoyW1rzHNoNPJ0cJfivQZWXrYKMcvZM30/HL9FrbcH
         pMF1QkRGD4uJZxewNiWfwBxXriuNcwx61quGyA/Rro1MDFlI11ET8p2IalfTci7JStaH
         fJaiUxC+ZIwj0qt1rArbYbZBCTn2dwh4ihQ08=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l7Yr6iThBvFiVFuCMIOneOYkdq7rfICUbWrdUVOauj8=;
        b=cizMU7ldAv8XLuPM3KD8bXj+Ev+gO5z3Jwsoj1vRs3rl7xYKId0bXUYvj2+OH/Tben
         Dl/y7Mrikdtz567KFvaWI1yR3IX3L1Tv923SzBlPaswnzWq3Uwj5nhOqM0OxUa2l6c3X
         5M1WydObuMkczUh5oLh8LjGo/ej0AMa8qmbo40INs0Eyqab9o33xzuegXwYb03ptSFwG
         HwuOV6663WmojDPkgevY5RQjlm3Zgm+T2SAKXuLo0eFwWzjBQiKWm085YGV+TSmSMkzI
         GI8cFId94ggOECW1Vem9wHc1PTxp2XxRg0mgpTdNX3+GWlyyCLGED+vG9dd8puTFtjpI
         NsGw==
X-Gm-Message-State: ANhLgQ1No3O8YvG7pMk+geA7B0bc0XUpF5DZWtJ4W1s+1oso7IwJ34G7
        65FNz/CYE+4fPXSCvkkqF1mbH95zyydb/ktlR9r/+A==
X-Google-Smtp-Source: ADFU+vtbpbl0w2HqWSs8biDjZfjr/C5cekqgPQWRzbyVdoi71n4jrNADZpiqZ9BIxofq9rqM9Tu5nWBqs8hbde/f8Dw=
X-Received: by 2002:a05:6e02:f43:: with SMTP id y3mr4766895ilj.174.1583524462599;
 Fri, 06 Mar 2020 11:54:22 -0800 (PST)
MIME-Version: 1.0
References: <1582556135.3384.4.camel@HansenPartnership.com>
 <CAJfpegsk6BsVhUgHNwJgZrqcNP66wS0fhCXo_2sLt__goYGPWg@mail.gmail.com>
 <a657a80e-8913-d1f3-0ffe-d582f5cb9aa2@redhat.com> <1582644535.3361.8.camel@HansenPartnership.com>
 <20200228155244.k4h4hz3dqhl7q7ks@wittgenstein> <107666.1582907766@warthog.procyon.org.uk>
 <CAJfpegu0qHBZ7iK=R4ajmmHC4g=Yz56otpKMy5w-y0UxJ1zO+Q@mail.gmail.com>
 <0403cda7345e34c800eec8e2870a1917a8c07e5c.camel@themaw.net>
 <CAJfpegtu6VqhPdcudu79TX3e=_NZaJ+Md3harBGV7Bg_-+fR8Q@mail.gmail.com>
 <20200306162549.GA28467@miu.piliscsaba.redhat.com> <20200306194322.GY23230@ZenIV.linux.org.uk>
In-Reply-To: <20200306194322.GY23230@ZenIV.linux.org.uk>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Fri, 6 Mar 2020 20:54:10 +0100
Message-ID: <CAJfpegtCsLmJF-DZH7P8=sVNdg86ZKa1Wgu-FN=YL1N5LdZh6w@mail.gmail.com>
Subject: Re: [PATCH 00/17] VFS: Filesystem information and notifications [ver #17]
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Ian Kent <raven@themaw.net>, David Howells <dhowells@redhat.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Steven Whitehouse <swhiteho@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Christian Brauner <christian@brauner.io>,
        Jann Horn <jannh@google.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, Mar 6, 2020 at 8:43 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Fri, Mar 06, 2020 at 05:25:49PM +0100, Miklos Szeredi wrote:
> > On Tue, Mar 03, 2020 at 08:46:09AM +0100, Miklos Szeredi wrote:
> > >
> > > I'm doing a patch.   Let's see how it fares in the face of all these
> > > preconceptions.
> >
> > Here's a first cut.  Doesn't yet have superblock info, just mount info.
> > Probably has rough edges, but appears to work.
>
> For starters, you have just made namespace_sem held over copy_to_user().
> This is not going to fly.

Where?

Thanks,
Miklos

Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 40B13177733
	for <lists+linux-api@lfdr.de>; Tue,  3 Mar 2020 14:35:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729449AbgCCNey (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 3 Mar 2020 08:34:54 -0500
Received: from mail-il1-f195.google.com ([209.85.166.195]:35387 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726465AbgCCNey (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 3 Mar 2020 08:34:54 -0500
Received: by mail-il1-f195.google.com with SMTP id g126so2770941ilh.2
        for <linux-api@vger.kernel.org>; Tue, 03 Mar 2020 05:34:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d8UZDr3lZGFyJivNM6em5ybzB9qz5QGiZZazZdznXqk=;
        b=eEQq5fiMKdVd42vqfExJKz3i8PtBQaz26xc++cNx+VS/zkeI5e09ipMisnSMiHdrf5
         u+xmYZFz/xI0z/5+EySdWurVl96IIsUyghbPc5Vppji0ZZ9iQNhE7e1tgdNfKcxWAAes
         y80ESNGhn+KNkkn+eLigS588MUERmZAN3AgMs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d8UZDr3lZGFyJivNM6em5ybzB9qz5QGiZZazZdznXqk=;
        b=VOFW+iQAtqUSw9E3dA8T/LgknPNcaO+Lim4XzMxebqJ4ncPzD76EAU5BB/YVcSps/g
         f5+xJRb/KQQWKJS648DImY78UIdpqS8ETUGCruSCh9QzqpYkmolhH60C1lahqZS3USpi
         gr3zJvSy6UXdI+unM8t1IYwEIgVQkkMmhqBU1yuX3hNUOr/DfQlBreXANaWjUYvEGecV
         mEKfbeW/4fz2kE+/VrQWVoPE54l1boL0J576KmmENAlydPOgaveuREbY4cZjRFhJjZxR
         6bHymRDXt+Y0trwxGGmuDl2vgw5Y6SZol1NnBTAmLxPNi6T/7z58JfofbS59Ng4q6g5M
         fsiA==
X-Gm-Message-State: ANhLgQ18a2WuZzkNVsKBqwfJHe3q89zoK9jjt/OgkFL1ocimtIKwFK6i
        zuLy4IlB7wl3pfdPjOzHDQES6sFl7i2jOhyk/+ekWw==
X-Google-Smtp-Source: ADFU+vse5bB7gLvCvFy8XryGmsALFqGE4Oyf3LKEtJstP+x5Mc4KlKOxwSw8ylASXSSbsPp5ZHBKAyS4fw1aRsVzAO8=
X-Received: by 2002:a92:8847:: with SMTP id h68mr4667878ild.212.1583242493712;
 Tue, 03 Mar 2020 05:34:53 -0800 (PST)
MIME-Version: 1.0
References: <1582644535.3361.8.camel@HansenPartnership.com>
 <20200228155244.k4h4hz3dqhl7q7ks@wittgenstein> <107666.1582907766@warthog.procyon.org.uk>
 <CAJfpegu0qHBZ7iK=R4ajmmHC4g=Yz56otpKMy5w-y0UxJ1zO+Q@mail.gmail.com>
 <0403cda7345e34c800eec8e2870a1917a8c07e5c.camel@themaw.net>
 <CAJfpegtu6VqhPdcudu79TX3e=_NZaJ+Md3harBGV7Bg_-+fR8Q@mail.gmail.com>
 <1509948.1583226773@warthog.procyon.org.uk> <CAJfpegtOwyaWpNfjomRVOt8NKqT94O5n4-LOHTR7YZT9fadVHA@mail.gmail.com>
 <20200303113814.rsqhljkch6tgorpu@ws.net.home> <20200303130347.GA2302029@kroah.com>
 <20200303131434.GA2373427@kroah.com>
In-Reply-To: <20200303131434.GA2373427@kroah.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 3 Mar 2020 14:34:42 +0100
Message-ID: <CAJfpegt0aQVvoDeBXOu2xZh+atZQ+q5uQ_JRxe46E8cZ7sHRwg@mail.gmail.com>
Subject: Re: [PATCH 00/17] VFS: Filesystem information and notifications [ver #17]
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Karel Zak <kzak@redhat.com>, David Howells <dhowells@redhat.com>,
        Ian Kent <raven@themaw.net>,
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

On Tue, Mar 3, 2020 at 2:14 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:

> > Unlimited beers for a 21-line kernel patch?  Sign me up!
> >
> > Totally untested, barely compiled patch below.
>
> Ok, that didn't even build, let me try this for real now...

Some comments on the interface:

O_LARGEFILE can be unconditional, since offsets are not exposed to the caller.

Use the openat2 style arguments; limit the accepted flags to sane ones
(e.g. don't let this syscall create a file).

If buffer is too small to fit the whole file, return error.

Verify that the number of bytes read matches the file size, otherwise
return error (may need to loop?).

Thanks,
Miklos

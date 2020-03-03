Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7ADDB177873
	for <lists+linux-api@lfdr.de>; Tue,  3 Mar 2020 15:12:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726890AbgCCOLD (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 3 Mar 2020 09:11:03 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:46975 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726079AbgCCOLD (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 3 Mar 2020 09:11:03 -0500
Received: by mail-io1-f67.google.com with SMTP id x21so3631380iox.13
        for <linux-api@vger.kernel.org>; Tue, 03 Mar 2020 06:11:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mTx2plxg9Df6IflSHbJKT5bYL5iIl+THZm0QXJzfcTo=;
        b=OtwE4L35EOBWYLiqou7S0JQAG1/jjvkjvAnIQCw4HxRHQWuqRBJNy7eTtdd1KFu4gY
         ynNB7Dm+GKQK5xP0ltYldY9reVYrX99cEQjv5EP8Q77AlruXFxhAM01FlqxVUJHbNfpj
         57B4N00jJ4X+t4XZ8dFG62Jfh9BDAa3By5KO0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mTx2plxg9Df6IflSHbJKT5bYL5iIl+THZm0QXJzfcTo=;
        b=d7x/+aHazTfply70I4XAroQEgs1iEZfn2LGJh+szOR3SGa17DAOIEd16qGXMVmK8Eq
         CeWIik2WEEZ314t58JvIAS2Tjt8RVQPeieygNx7Q+fXGStNsyiVIGJaB5SoAdTeuzG/z
         OnEeZ+gmH+y/GhfisutHKcuSyfNriRojKssBabHz2V0x06fnG5Fk40t43VwKyg0H86+P
         z+rhugmQ8VrB14xRqpeOPrJl1SC7F0EaG58RqR7Mq/skcGDjXMlOBC81A37OxeiAaOFe
         EQeMhqhm1wFCizYW9CZJ/kL7i+h5QUfPnQXjA/ukWnj3RknI8Y4MR7yyAPIIO/AwdCuP
         cSGA==
X-Gm-Message-State: ANhLgQ0qSs4tqTyjVF2jP6jWwxAkpCNOgIiO8evtPZtG1BV6dZx+m7hy
        9Gcl8Nb9CHiCHt2NcieosljHp5yJJng6RF4phko7yw==
X-Google-Smtp-Source: ADFU+vtLRyHBggE8dM0IQenq5myGtycP6n4bf/pwe+192e1gRcnjD3MAj+3seh4Y8IVdPCMKjFwHFg+xWSJq2cSKwCY=
X-Received: by 2002:a02:9f04:: with SMTP id z4mr1393539jal.35.1583244662034;
 Tue, 03 Mar 2020 06:11:02 -0800 (PST)
MIME-Version: 1.0
References: <107666.1582907766@warthog.procyon.org.uk> <CAJfpegu0qHBZ7iK=R4ajmmHC4g=Yz56otpKMy5w-y0UxJ1zO+Q@mail.gmail.com>
 <0403cda7345e34c800eec8e2870a1917a8c07e5c.camel@themaw.net>
 <CAJfpegtu6VqhPdcudu79TX3e=_NZaJ+Md3harBGV7Bg_-+fR8Q@mail.gmail.com>
 <1509948.1583226773@warthog.procyon.org.uk> <CAJfpegtOwyaWpNfjomRVOt8NKqT94O5n4-LOHTR7YZT9fadVHA@mail.gmail.com>
 <20200303113814.rsqhljkch6tgorpu@ws.net.home> <20200303130347.GA2302029@kroah.com>
 <20200303131434.GA2373427@kroah.com> <CAJfpegt0aQVvoDeBXOu2xZh+atZQ+q5uQ_JRxe46E8cZ7sHRwg@mail.gmail.com>
 <20200303134316.GA2509660@kroah.com>
In-Reply-To: <20200303134316.GA2509660@kroah.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 3 Mar 2020 15:10:50 +0100
Message-ID: <CAJfpegtFyZqSRzo3uuXp1S2_jJJ29DL=xAwKjpEGvyG7=AzabA@mail.gmail.com>
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

On Tue, Mar 3, 2020 at 2:43 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Tue, Mar 03, 2020 at 02:34:42PM +0100, Miklos Szeredi wrote:

> > If buffer is too small to fit the whole file, return error.
>
> Why?  What's wrong with just returning the bytes asked for?  If someone
> only wants 5 bytes from the front of a file, it should be fine to give
> that to them, right?

I think we need to signal in some way to the caller that the result
was truncated (see readlink(2), getxattr(2), getcwd(2)), otherwise the
caller might be surprised.

>
> > Verify that the number of bytes read matches the file size, otherwise
> > return error (may need to loop?).
>
> No, we can't "match file size" as sysfs files do not really have a sane
> "size".  So I don't want to loop at all here, one-shot, that's all you
> get :)

Hmm.  I understand the no-size thing.  But looping until EOF (i.e.
until read return zero) might be a good idea regardless, because short
reads are allowed.

Thanks,
Miklos

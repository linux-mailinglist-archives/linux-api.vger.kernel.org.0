Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 092C717847F
	for <lists+linux-api@lfdr.de>; Tue,  3 Mar 2020 22:03:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731240AbgCCVDq (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 3 Mar 2020 16:03:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:45324 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729880AbgCCVDq (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Tue, 3 Mar 2020 16:03:46 -0500
Received: from tleilax.poochiereds.net (68-20-15-154.lightspeed.rlghnc.sbcglobal.net [68.20.15.154])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F091E20728;
        Tue,  3 Mar 2020 21:03:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583269424;
        bh=P324o9tus2K6UdEaIBu5qm77rhmlVisGvzD3wMHwH3Y=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=MuW4/BP1yEisJGZudxNcoiXAXhxEjxUT9z3yGd4XGdLtHSCe9XdlIumZCiRa/zbTN
         6ZQY3B+MV2M6uGG7MKxJJuldYoy7d8+dboTMc9wfN25UbMLAmuBuCe2njdiZ6e56Om
         Jbp6l8+s9pltZwwbA/+jXwo5rO9z6ZdlIfyqKTA0=
Message-ID: <8b42bcc526a890395e8f25c2f209475101861257.camel@kernel.org>
Subject: Re: [PATCH 00/17] VFS: Filesystem information and notifications
 [ver #17]
From:   Jeff Layton <jlayton@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jann Horn <jannh@google.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>, Karel Zak <kzak@redhat.com>,
        David Howells <dhowells@redhat.com>,
        Ian Kent <raven@themaw.net>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Steven Whitehouse <swhiteho@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Date:   Tue, 03 Mar 2020 16:03:41 -0500
In-Reply-To: <f3e36d79-a324-678d-ae19-eaee14eaefbd@kernel.dk>
References: <CAJfpegtu6VqhPdcudu79TX3e=_NZaJ+Md3harBGV7Bg_-+fR8Q@mail.gmail.com>
         <1509948.1583226773@warthog.procyon.org.uk>
         <CAJfpegtOwyaWpNfjomRVOt8NKqT94O5n4-LOHTR7YZT9fadVHA@mail.gmail.com>
         <20200303113814.rsqhljkch6tgorpu@ws.net.home>
         <20200303130347.GA2302029@kroah.com> <20200303131434.GA2373427@kroah.com>
         <CAJfpegt0aQVvoDeBXOu2xZh+atZQ+q5uQ_JRxe46E8cZ7sHRwg@mail.gmail.com>
         <20200303134316.GA2509660@kroah.com> <20200303141030.GA2811@kroah.com>
         <CAG48ez3Z2V8J7dpO6t8nw7O2cMJ6z8vwLZXLAoKGH3OnCb-7JQ@mail.gmail.com>
         <20200303142407.GA47158@kroah.com>
         <030888a2-db3e-919d-d8ef-79dcc10779f9@kernel.dk>
         <acb1753c78a019fb0d54ba29077cef144047f70f.camel@kernel.org>
         <7a05adc8-1ca9-c900-7b24-305f1b3a9b86@kernel.dk>
         <dbb06c63c17c23fcacdd99e8b2266804ee39ffe5.camel@kernel.org>
         <dc84aa00-e570-8833-cf9f-d1001c52dd7a@kernel.dk>
         <cb2a7273a4cac7bac5f5b323e1958242b98e605e.camel@kernel.org>
         <f3e36d79-a324-678d-ae19-eaee14eaefbd@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, 2020-03-03 at 13:33 -0700, Jens Axboe wrote:
> On 3/3/20 12:43 PM, Jeff Layton wrote:
> > On Tue, 2020-03-03 at 12:23 -0700, Jens Axboe wrote:
> > > On 3/3/20 12:02 PM, Jeff Layton wrote:
> > > > Basically, all you'd need to do is keep a pointer to struct file in the
> > > > internal state for the chain. Then, allow userland to specify some magic
> > > > fd value for subsequent chained operations that says to use that instead
> > > > of consulting the fdtable. Maybe use -4096 (-MAX_ERRNO - 1)?
> > > 
> > > BTW, I think we need two magics here. One that says "result from
> > > previous is fd for next", and one that says "fd from previous is fd for
> > > next". The former allows inheritance from open -> read, the latter from
> > > read -> write.
> > > 
> > 
> > Do we? I suspect that in almost all of the cases, all we'd care about is
> > the last open. Also if you have unrelated operations in there you still
> > have to chain the fd through somehow to the next op which is a bit hard
> > to do with that scheme.
> > 
> > I'd just have a single magic carveout that means "use the result of last
> > open call done in this chain". If you do a second open (or pipe, or...),
> > then that would put the old struct file pointer and drop a new one in
> > there.
> > 
> > If we really do want to enable multiple opens in a single chain though,
> > then we might want to rethink this and consider some sort of slot table
> > for storing open fds.
> 
> I think the one magic can work, you just have to define your chain
> appropriately for the case where you have multiple opens. That's true
> for the two magic approach as well, of course, I don't want a stack of
> open fds, just "last open" should suffice.
> 

Yep.

> I don't like the implicit close, if your op opens an fd, something
> should close it again. You pass it back to the application in any case
> for io_uring, so the app can just close it. Which means that your chain
> should just include a close for whatever fd you open, unless you plan on
> using it in the application aftwards.
> 

Yeah sorry, I didn't word that correctly. Let me try again:

My thinking was that you would still return the result of the open to
userland, but also stash a struct file pointer in the internal chain
representation. Then you just refer to that when you get the "magic" fd.

You'd still need to explicitly close the file though if you didn't want
to use it past the end of the current chain. So, I guess you _do_ need
the actual fd to properly close the file in that case.

On another note, what happens if you do open+write+close and the write
fails? Does the close still happen, or would you have to issue one
separately after getting the result?

-- 
Jeff Layton <jlayton@kernel.org>


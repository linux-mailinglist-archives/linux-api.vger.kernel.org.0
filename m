Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E66A1D49AD
	for <lists+linux-api@lfdr.de>; Fri, 11 Oct 2019 23:08:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727654AbfJKVIh (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 11 Oct 2019 17:08:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:54282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726642AbfJKVIh (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Fri, 11 Oct 2019 17:08:37 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A32092084C;
        Fri, 11 Oct 2019 21:08:35 +0000 (UTC)
Date:   Fri, 11 Oct 2019 17:08:33 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Matthew Garrett <matthewgarrett@google.com>,
        James Morris James Morris <jmorris@namei.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Ben Hutchings <ben@decadent.org.uk>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] tracefs: Do not allocate and free proxy_ops for
 lockdown
Message-ID: <20191011170833.2312857c@gandalf.local.home>
In-Reply-To: <CAHk-=whC6Ji=fWnjh2+eS4b15TnbsS4VPVtvBOwCy1jjEG_JHQ@mail.gmail.com>
References: <20191011135458.7399da44@gandalf.local.home>
        <CAHk-=wj7fGPKUspr579Cii-w_y60PtRaiDgKuxVtBAMK0VNNkA@mail.gmail.com>
        <20191011162518.2f8c99ca@gandalf.local.home>
        <CAHk-=whC6Ji=fWnjh2+eS4b15TnbsS4VPVtvBOwCy1jjEG_JHQ@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, 11 Oct 2019 13:46:11 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Fri, Oct 11, 2019 at 1:25 PM Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > OK, so I tried this approach, and there's a bit more than just a "few"
> > extra cases that use tracing_open_generic().  
> 
> Yeah, that's more than I would have expected.
> 
> That said, you also did what I consider a somewhat over-done conversion.
> 
> Just do
> 
>    static inline bool tracefs_lockdown_or_disabled(void)
>    { return tracing_disabled || security_locked_down(LOCKDOWN_TRACEFS); }
> 
> and ignore the pointless return value (we know it's EPERM, and we
> really don't care).
> 
> And then several of those conversions just turn into oneliner
> 
> -       if (tracing_disabled)
> +       if (tracefs_lockdown_or_disabled())
>                  return -ENODEV;

OK, so this is similar to what I just sent. But instead I made it into
a function that combines tracing_disabled and the locked_down, plus, it
did the reference update for the trace_array if needed (which in doing
this exercise, I think I found a couple of places that need the ref
count update).

> 
> patches instead.
> 
> I'm also not sure why you bothered with a lot of the files that don't
> currently even have that "tracing_disabled" logic at all. Yeah, they
> show pre-existing tracing info, but even if you locked down _after_
> starting some tracing, that's probably what you want. You just don't
> want people to be able to add new trace events.

I guess just preventing new traces would be good enough (or anything
that records data), as well as seeing that recorded data.

Note, the tracing_disabled was added in case the ring buffer got
corrupted, and we wanted to prevent the system from crashing if someone
read the corrupted ring buffer. In the over 10 years of having that
check, I don't recall a single instance of someone triggering it :-/


> 
> For example, maybe you want to have lockdown after you've booted, but
> still show boot time traces?
> 
> I dunno. I feel like you re-did the original patch, and the original
> patch was designed for "least line impact" rather than for anything
> else.
> 
> I also suspect that if you *actually* do lockdown at early boot (which
> is presumably one common case), then all you need is to do
> 
>     --- a/fs/tracefs/inode.c
>     +++ b/fs/tracefs/inode.c
>     @@ -418,6 +418,9 @@ struct dentry *tracefs_create_file(
>         struct dentry *dentry;
>         struct inode *inode;
> 
>     +   if (security_locked_down(LOCKDOWN_TRACEFS))
>     +           return NULL;
>     +

Sounds reasonable.

>         if (!(mode & S_IFMT))
>                 mode |= S_IFREG;
>         BUG_ON(!S_ISREG(mode));
> 
> and the "open-time check" is purely for "we did lockdown _after_ boot,
> but then you might well want to be able to read the existing trace
> information that you did before you locked down.
> 
> Again - I think trying to emulate exactly what that broken lockdown
> patch did is not really what you should aim for.
> 
> That patch was not only buggy, it really wasn't about what people
> really necessarily _want_, as about "we don't want to deal with
> tracing, so here's a minimal patch that doesn't even work".

OK. My new approach is to:

1) revert the tracefs lockdown patch
2) Add my tracing_check_open_get_tr() patch (and consolidate the calls)
 (fix up anything that should have this too)
3) Add the lockdown to the tracing_check_open_get_tr() routine, and be
   done with it.

-- Steve

Return-Path: <linux-api+bounces-5097-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B4B84BCEFA6
	for <lists+linux-api@lfdr.de>; Sat, 11 Oct 2025 06:04:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDD4819A41CE
	for <lists+linux-api@lfdr.de>; Sat, 11 Oct 2025 04:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E3551D516C;
	Sat, 11 Oct 2025 04:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20230601.gappssmtp.com header.i=@amacapital-net.20230601.gappssmtp.com header.b="VqF+MD+x"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE0EE55A
	for <linux-api@vger.kernel.org>; Sat, 11 Oct 2025 04:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760155470; cv=none; b=hqWB9g27EaVlP9nL1uqAAZ8h3/ONAcps2Q39jYxnSnPy8rLcHqto+PJDY/1ra6Jacky9Bqxf7oxMGk7D5g5waKv4QITxbZIez7BGdYYy4Xq2iyINYUX6xLlY6M/XsMhTrSQGKak02XYyI3YodQ7JAKd37XX2EOWH/+Q1NC9of8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760155470; c=relaxed/simple;
	bh=aWOHv5sIMa96Q5/sU0zDoEGYdX0W0fCCXNPW/LilCIY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ohLpO9V22IuIuxpt5Zno8AHCJclnPod7riBuxtFVUXQ6ZQelzMQQIpqLHk2NdCDiGch/S/SsDDwBcamOTsTM7NL9EmCLT/PgAts6nbaO373H75GCEoxlkQwtPIqWJRwQoC1SnqtP0zHHJ4asvQTP8IVH0aRfTVZbv4lIa0rlTsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net; spf=pass smtp.mailfrom=amacapital.net; dkim=pass (2048-bit key) header.d=amacapital-net.20230601.gappssmtp.com header.i=@amacapital-net.20230601.gappssmtp.com header.b=VqF+MD+x; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amacapital.net
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-59054fc6a45so3399022e87.3
        for <linux-api@vger.kernel.org>; Fri, 10 Oct 2025 21:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20230601.gappssmtp.com; s=20230601; t=1760155465; x=1760760265; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wxrYhYASPW7hNkv0I+/dkIwogDxR5uy/leBbcueqFmk=;
        b=VqF+MD+xgMTgr7lXkfXMbbXY7wkhB30iVLMvIIxxCfW82nr18QYeo3OaxUBzW2Qlto
         CVm6S0OrCWMCLingwuP6EdHIbUC0nWIg7kl5GzT7WNDytoA+WQptmaD7xk9LLAEXQhs2
         jQzyMBUOtNl6r5PBU+G2aYwmvquNTCxhlSzL4oljzSpopuQZHPZ+9jM5hgcLcwYTfHng
         HBU0Vwu63l2ockEh643GDSBPdsoPx9YTHA05cQllOSsMq5Ixev2LbQQgZUDHVWhqKKcl
         GUxR3FDnYn9nowwKVrkUFPDFoV0wF7jaIIPW03kAPLk6Cf49m3xUVCMaV5T+SWISjs9L
         lcJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760155465; x=1760760265;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wxrYhYASPW7hNkv0I+/dkIwogDxR5uy/leBbcueqFmk=;
        b=aKhetl/t1ngUspjHSoYMs1UI9uNP0cbcZMQT49TQHQVwq0j3q/UkHI7aD8h1vAvXq9
         snF5NzI5OUgxYUNqiM8virobMQyTu7CPt5CvW2Kkdy9ecAfuZX1zRyax0ib+AKcqFk+r
         X6IFrvwzRRVISn10ykiAaXMlZiQyc4vp0aH5kK6Liaukh/hi7dEn7tYMx/eVtQee3GwF
         tpnckI6MDi7tFz+ooLb1z5k0wndGX7xVIaDaFaLE0EoQBrWaT1+Q46B+3/DOMVax2hvj
         AdDTd3YfyNHAHwUkwdLED9OkV/cCLh8kHvPmUuo28w39F22e1Tp7HibHTjuWJtgFaT11
         Cj4A==
X-Forwarded-Encrypted: i=1; AJvYcCWCDnvls08quUT8RK3dsSrFIztNV9ypthrsXxvqzbeaDhFtcpZjDKPF1X5rnjlIba8EJsvBn9WLBTY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9iMiReTT5A9aoQsAeIbpjrBub7HKfRgwwPdGZJW8/L4q0MIMb
	5DagM6WueHC9XgEbGs6Nv//X99fv2iIDEe6Q9szVG4M1yNmrB0akutJJjnYBgS7rVCbMBmEQS/u
	sSUGOI+AddVPnJ6NuDmmvu43lKKRuHGkxMDXJs0wt
X-Gm-Gg: ASbGncsJgZWmFU/5Uvm8o/wjqyr+8plWgElT1gGW6c3E+eXral7n5BJC060tXeQaLfP
	KOSUKarl9AyshV46hhJ+NDnbWJ6NmuYrv6ZO/4ABwVil7sZOE4H5G0VEMEy5abPbRh8zeKAIxHA
	Tbi83PyNrJLeprrXNXjcJ218B/xDmeVTWcBozeBKWSKSfWOCIT+abZIgEDB2h9O2pALAeFtUqjR
	svRBOUIG1f+9TiIe5AehNFt
X-Google-Smtp-Source: AGHT+IERWkZjkwJeaANefd5QQVPUh0Tn17+zj0nbldzP+dMe/pRxkwxO+dBwZOKYhTBehxYzcRf98nJx4rDx7SgsRAM=
X-Received: by 2002:a05:6512:3c9c:b0:577:494e:ca61 with SMTP id
 2adb3069b0e04-5906dd53f00mr4476671e87.31.1760155465047; Fri, 10 Oct 2025
 21:04:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251003093213.52624-1-xemul@scylladb.com> <aOCiCkFUOBWV_1yY@infradead.org>
 <CALCETrVsD6Z42gO7S-oAbweN5OwV1OLqxztBkB58goSzccSZKw@mail.gmail.com>
 <aOSgXXzvuq5YDj7q@infradead.org> <CALCETrW3iQWQTdMbB52R4=GztfuFYvN_8p52H1fopdS8uExQWg@mail.gmail.com>
 <aObXUBCtp4p83QzS@dread.disaster.area> <CALCETrX-cs5MH3k369q2Fk5Q-pYQfEV6CW3va-4E9vD1CoCaGA@mail.gmail.com>
 <aOm0WCB_woFgnv0v@dread.disaster.area>
In-Reply-To: <aOm0WCB_woFgnv0v@dread.disaster.area>
From: Andy Lutomirski <luto@amacapital.net>
Date: Fri, 10 Oct 2025 21:04:13 -0700
X-Gm-Features: AS18NWApra4q9AvFnZo6mqAkIEnBar0j0AX5L00uLKlUP_lGMQeMi0q_KHg1Mfg
Message-ID: <CALCETrWoXb40d=CJLkPy+NaAGOmdULPw6xcrXgQVhcwv49hBiA@mail.gmail.com>
Subject: Re: [PATCH] fs: Propagate FMODE_NOCMTIME flag to user-facing O_NOCMTIME
To: Dave Chinner <david@fromorbit.com>
Cc: Christoph Hellwig <hch@infradead.org>, Pavel Emelyanov <xemul@scylladb.com>, linux-fsdevel@vger.kernel.org, 
	"Raphael S . Carvalho" <raphaelsc@scylladb.com>, linux-api@vger.kernel.org, 
	linux-xfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 10, 2025 at 6:35=E2=80=AFPM Dave Chinner <david@fromorbit.com> =
wrote:
>
> On Wed, Oct 08, 2025 at 02:51:14PM -0700, Andy Lutomirski wrote:
> > On Wed, Oct 8, 2025 at 2:27=E2=80=AFPM Dave Chinner <david@fromorbit.co=
m> wrote:
> > >
> > > On Wed, Oct 08, 2025 at 08:22:35AM -0700, Andy Lutomirski wrote:
> > > > On Mon, Oct 6, 2025 at 10:08=E2=80=AFPM Christoph Hellwig <hch@infr=
adead.org> wrote:
> > > > >
> > > > > On Sat, Oct 04, 2025 at 09:08:05AM -0700, Andy Lutomirski wrote:
> >
> > >
> > > You are conflating "synchronous update" with "blocking".
> > >
> > > Avoiding the need for synchronous timestamp updates is exactly what
> > > the lazytime mount option provides. i.e. lazytime degrades immediate
> > > consistency requirements to eventual consistency similar to how the
> > > default relatime behaviour defers atime updates for eventual
> > > writeback.
> > >
> > > IOWs, we've already largely addressed the synchronous c/mtime update
> > > problem but what we haven't done is made timestamp updates
> > > fully support non-blocking caller semantics. That's a separate
> > > problem...
> >
> > I'm probably missing something, but is this really different?
>
> Yes, and yes.
>
> > Either the mtime update can block or it can't block.
>
> Sure, but that's not the issue we have to deal with.
>
> In many filesystems and fs operations, we have to know if an
> operation is going to block -before- we start the operation. e.g.
> transactional changes cannot be rolled back once we've started the
> modification if they need to block to make progress (e.g. read in
> on-disk metadata).
>
> This foresight, in many cases, is -unknowable-. Even though the
> operation /likely/ won't block, we cannot *guarantee* ahead of time
> that any given instance of the operation will /not/ block.  Hence
> the reliable non-blocking operation that users are asking for is not
> possible with unknowable implementation characteristics like this.
>
> IOWs, a timestamp update implementation can be synchronous and
> reliably non-blocking if it always knows when blocking will occur
> and can return -EAGAIN instead of blocking to complete the
> operation.
>
> If it can't know when/if blocking will occur, then lazytime allows
> us to defer the (potentially) blocking update operation to another
> context that can block. Queuing for async processing can easily be
> made non-blocking, and __mark_inode_dirty(I_DIRTY_TIME) does this
> for us.
>
> So, yeah, it should be pretty obvious at this point that non-blocking
> implementation is completely independent of whether the operation is
> performed synchronously or asynchronously. It's easier to make async
> operations non-blocking, but that doesn't mean "non_blocking" and
> "asynchronous execution" are interchangable terms or behaviours.
>
> > I haven't dug all the
> > way into exactly what happens in __mark_inode_dirty(), but there is a
> > lot going on in there even in the I_DIRTY_TIME path.
>
> It's pretty simple, really.  __mark_inode_dirty(I_DIRTY_TIME) is
> non-blocking and queues the inode on the wb->i_dirty_time queue
> for later processing.
>

First, I apologize if I'm off base here.

Second, I don't think I'm entirely nuts, and I'm moderately confident
that, ten-ish years ago, I tested lazytime in the hopes that it would
solve my old problem, and IIRC it didn't help.  I was running a
production workload on ext4 on regrettably slow spinning rust backed
by a truly atrocious HPE controller.  And I was running latencytop to
generate little traces when my task got blocked, and there was no form
of AIO involved.  (And I don't really understand how AIO is wired up
internally...  And yes, in retrospect I should not have been using
shared-writable mmaps or even file-backed things at all for what I was
doing, but I had unrealistic expectations of how mmap worked when I
wrote that code more like 20 years ago, and I wasn't even using Linux
at the time I wrote it.)

I'm looking at the code now, and I see what you're talking about, and
__mark_inode_dirty(inode, I_DIRTY_TIME) looks fairly polite and like
it won't block.  But the relevant code seems to be:

int generic_update_time(struct inode *inode, int flags)
{
        int updated =3D inode_update_timestamps(inode, flags);
        int dirty_flags =3D 0;

        if (updated & (S_ATIME|S_MTIME|S_CTIME))
                dirty_flags =3D inode->i_sb->s_flags & SB_LAZYTIME ?
I_DIRTY_TIME : I_DIRTY_SYNC;
        if (updated & S_VERSION)
                dirty_flags |=3D I_DIRTY_SYNC;
        __mark_inode_dirty(inode, dirty_flags);
        ...

inode_update_timestamps does this, where updated !=3D 0 if the timestamp
actually changed (which is subject to some complex coarse-graining
logic so it may only happen some of the time):

                if (IS_I_VERSION(inode) &&
inode_maybe_inc_iversion(inode, updated))
                        updated |=3D S_VERSION;

IS_I_VERSION seems to be unconditionally true on ext4.
inode_maybe_inc_iversion always returns true if updated is set, so
generic_update_time has a decent chance of doing
__mark_inode_dirty(inode, I_DIRTY_SYNC), which calls
s_op->dirty_inode, which calls ext4_journal_start, which, from my
recollection a decade ago, could easily block for a good second or so
on my delightful, now retired, HP/HPE system.

In my case, I think this is the path that was blocking for me in lots
of do_wp_page calls that would otherwise not have blocked.  I also
don't see any kiocb passed around or any mechanism by which this code
could know that it's supposed to be nonblocking, although I have
approximately no understanding of Linux AIO and I don't really know
what I should be looking for.

I could try to instrument the code a bit and test to see if I've
analyzed it right in a few days.

--Andy
Andy Lutomirski
AMA Capital Management, LLC


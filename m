Return-Path: <linux-api+bounces-785-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2172A844843
	for <lists+linux-api@lfdr.de>; Wed, 31 Jan 2024 20:50:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FD8B1F26B79
	for <lists+linux-api@lfdr.de>; Wed, 31 Jan 2024 19:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE73E3E494;
	Wed, 31 Jan 2024 19:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20230601.gappssmtp.com header.i=@amacapital-net.20230601.gappssmtp.com header.b="RetMiQ0v"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 063B73EA90
	for <linux-api@vger.kernel.org>; Wed, 31 Jan 2024 19:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706730637; cv=none; b=LeejP5bjTBI5c0MNpBdl928zxgfy8z17+Ujidbn132ichAduYszehqjORQO+o2/9ogCZTIg2DKYczGWvsPpacqFgp0B1tr6uH1hL4njlS6yglxA92s7lIY17r+xCpdOUO+XSEfCL+/IZ90IOFDnfq5HdgeVHjQ0dQN0JBL+m7II=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706730637; c=relaxed/simple;
	bh=+zohiKIgwl9dxWkxdZnhuY0aT3sH+hMD+jSppCdCXEY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QlnR/JLmHTkaoJOsrAWU9z0lUcVLat8XSzpgvYbnDhlInlcu81VMoj6hwFjX1yIZvlmAPec88XuM95rJCNbCid/Ku8yKqM8zLXuvkmpgTm08iY5QZU86KOD4Cy28zDr+3wKyoORckgS06zRSM9x0KmHWqbsKUJln1fgpDfjzHWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net; spf=pass smtp.mailfrom=amacapital.net; dkim=pass (2048-bit key) header.d=amacapital-net.20230601.gappssmtp.com header.i=@amacapital-net.20230601.gappssmtp.com header.b=RetMiQ0v; arc=none smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amacapital.net
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-7d6024b181bso93969241.2
        for <linux-api@vger.kernel.org>; Wed, 31 Jan 2024 11:50:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20230601.gappssmtp.com; s=20230601; t=1706730635; x=1707335435; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2pLB/2pboKxiSIZa2DHw5Q8ZZntCJK4+9g4jrk7c8lk=;
        b=RetMiQ0v/MxhH37N5Wf+AWVQh3hjMcxomQH4UqzEsghZP17BdAbbuRB6yiNvQiDzTh
         hvRIYLPqltJ8vWJ7H4tk2v5u1+SYD+xopry1jly+ewv9dDJRSseq5LZ88dm9inrS24va
         gK123hKilP0xuqztNTrAt6lY/GVJ8wqvLyBpqTCOoBiSPveJJMa9yOW9OjPcGcuG7QKk
         /t2Vysobx9bnOXf+bNY0ucjm/sLzF+iYQ18cznLTj0ovbHE86Zs7cs4t12MsLGoOwE+c
         PXdymFOJ2+uJh+CMfHnvBzvGmdLceR41tYORs4bSMxEAV7aoDqYBVk8GHyAjjklH+l19
         w0Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706730635; x=1707335435;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2pLB/2pboKxiSIZa2DHw5Q8ZZntCJK4+9g4jrk7c8lk=;
        b=W3uFyq9mUo0+04dOrzhAaYhCuzVJ0/M8l2p1yb4qpia5mDjzr2voCj86EH4hz00LUH
         JdqaDJtGahbUCP850D1sk5gl2JRZFvjZK/tWITrOD7/YedXFZDjobYJahR7jRgZkW9Hc
         hvD6mMZ4kf8C3WEhONFRJ24PEku82Y+x5cFC2afDV3a421NFrgPeMLYAejXIYuwW8CoM
         jwa5u/jGQ4X+iWsZYX7o825j1nVA40JuDS5sArCqieKIv4/KwHnKbWyHXzRAa58AKBBs
         44JT0/BUNT/yOnOTnrRq6ogwPDrxKI0RW8eswHd0HXNv/qiVtUKtIxchHEn5PcA0qnso
         IBpw==
X-Gm-Message-State: AOJu0YxuJbWtCjBwmRE3I38XYGfYDqp79E2A/vSzvxt51DOOUFGCnIg5
	wduKdUJslEAZXyeSXpdDb0WA+VHBe2bNv3o20x40NqoiBswC9yhs6//ZD1m9nWBoRCgH2IFcNuE
	d/PySp3ON/trRPbn5c8AZv3u44GWgM9nN82eJZH/59mqtdqNYWA==
X-Google-Smtp-Source: AGHT+IExACEGc21LHYihpXlPp/PPd0NykL+eNAbUK298HrE8lKNfO83YnKUXkj6nIl+laK+nSvd1jYYfKu/CWF5VR38=
X-Received: by 2002:a05:6122:1987:b0:4b6:f18d:c192 with SMTP id
 bv7-20020a056122198700b004b6f18dc192mr2536919vkb.7.1706730634832; Wed, 31 Jan
 2024 11:50:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240127163117.GB13787@redhat.com> <ZbU7d0dpTY08JgIl@tycho.pizza>
 <20240127193127.GC13787@redhat.com> <ZbVrRgIvudX242ZU@tycho.pizza>
 <20240127210634.GE13787@redhat.com> <20240129112313.GA11635@redhat.com>
 <CALCETrUFDkt+K9zG8mczxzAFy9t-6Mx5Cz-Sx+it6a4nt+O0pg@mail.gmail.com>
 <20240131184829.GE2609@redhat.com> <20240131191405.GF2609@redhat.com>
 <CALCETrXTHsyiR6Bav7bXCCHny0Z2Bn90fTUL9__KTftESQ9=7w@mail.gmail.com> <20240131-kerngesund-baumhaus-17a428b4aacb@brauner>
In-Reply-To: <20240131-kerngesund-baumhaus-17a428b4aacb@brauner>
From: Andy Lutomirski <luto@amacapital.net>
Date: Wed, 31 Jan 2024 11:50:23 -0800
Message-ID: <CALCETrUh-DJ28W-LYZd3mACb4z-rmi4kmeUCitHjyufiN7U0sQ@mail.gmail.com>
Subject: Re: [RFC PATCH] pidfd: implement PIDFD_THREAD flag for pidfd_open()
To: Christian Brauner <brauner@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Tycho Andersen <tycho@tycho.pizza>, linux-kernel@vger.kernel.org, 
	linux-api@vger.kernel.org, Tycho Andersen <tandersen@netflix.com>, 
	"Eric W. Biederman" <ebiederm@xmission.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 31, 2024 at 11:46=E2=80=AFAM Christian Brauner <brauner@kernel.=
org> wrote:
>
> On Wed, Jan 31, 2024 at 11:24:48AM -0800, Andy Lutomirski wrote:
> > > On 01/31, Oleg Nesterov wrote:
> > > >
> > > > On 01/31, Andy Lutomirski wrote:
> > > > Please note
> > > >
> > > >       /* TODO: respect PIDFD_THREAD */
> > > >
> > > > this patch adds into pidfd_send_signal().
> > > >
> > > > See also this part of discussion
> > > >
> > > >       > > +   /* TODO: respect PIDFD_THREAD */
> > > >       >
> > > >       > So I've been thinking about this at the end of last week. D=
o we need to
> > > >       > give userspace a way to send a thread-group wide signal eve=
n when a
> > > >       > PIDFD_THREAD pidfd is passed? Or should we just not worry a=
bout this
> > > >       > right now and wait until someone needs this?
> > > >
> > > >       I don't know. I am fine either way, but I think this needs a =
separate
> > > >       patch and another discussion in any case. Anyway should be tr=
ivial,
> > > >       pidfd_send_signal() has the "flags" argument.
> > > >
> > > > with Christian in https://lore.kernel.org/all/20240130112126.GA2610=
8@redhat.com/
> >
> > I missed that.  Whoops.
> >
> > On Wed, Jan 31, 2024 at 11:15=E2=80=AFAM Oleg Nesterov <oleg@redhat.com=
> wrote:
> > >
> > > Forgot to mention...
> > >
> > > And I agree that pidfd_send_signal(flags =3D> PGID/SID) can make
> > > some sense too.
> > >
> > > But this a) doesn't depend on PIDFD_THREAD, and b) needs another
> > > patch/discussion.
> > >
> > > But again, I am not sure I understood you correctly.
> > >
> >
> > Hmm.
> >
> > When one works with regular (non-fd) pids / pgids etc, one specifies
> > the signal domain at the time that one sends the signal.  I don't know
> > what pidfds should do.  It seems a bit inefficient for anything that
> > wants a pidfd and might send a signal in a different mode in the
> > future to have to hold on to multiple pidfds, so it probably should be
> > a pidfd_send_signal flag.
> >
> > Which leaves the question of what the default should be.  Should
> > pidfd_send_signal with flags =3D 0 on a PIDFD_THREAD signal the process
> > or the thread?  I guess there are two reasonable solutions:
> >
> > 1. flags =3D 0 always means process.  And maybe there's a special flag
> > to send a signal that matches the pidfd type, or maybe not.
> >
> > 2. flags =3D 0 does what the pidfd seems to imply, and a new
> > PIDFD_SIGNAL_PID flag overrides it to signal the whole PID even if the
> > pidfd is PIDFD_THREAD.
> >
> > Do any of you have actual use cases in mind where one choice is
> > clearly better than the other choice?
>
> So conceptually I think having the type of pidfd dictate the default
> scope of the signal is the most elegant approach. And then very likely
> we should just have:
>
> PIDFD_SIGNAL_THREAD
> PIDFD_SIGNAL_THREAD_GROUP
> PIDFD_SIGNAL_PROCESS_GROUP
>
> I think for userspace it doesn't really matter as long as we clearly
> document what's going on.
>

This seems reasonable unless we're likely to end up with a pidfd mode
that doesn't actually make sense in a send_signal context.  But I'm
not immediately seeing any reason that that would happen.

--Andy


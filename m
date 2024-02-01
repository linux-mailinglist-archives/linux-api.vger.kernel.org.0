Return-Path: <linux-api+bounces-793-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A36E4846102
	for <lists+linux-api@lfdr.de>; Thu,  1 Feb 2024 20:33:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C83991C20A06
	for <lists+linux-api@lfdr.de>; Thu,  1 Feb 2024 19:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0779285283;
	Thu,  1 Feb 2024 19:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20230601.gappssmtp.com header.i=@amacapital-net.20230601.gappssmtp.com header.b="cBkL6P8H"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4783E84FCF
	for <linux-api@vger.kernel.org>; Thu,  1 Feb 2024 19:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706816026; cv=none; b=dUstXlY91Jbwnghd2Df+Mb9QZACD7KyROw4BSdb37PWhzXa+vhqGqyzXzLaV0Zhv1yeJ1ilqE4d0bmHFoNormrgihnf3KuBwnBt949NjQa7wlw1GjMP8s70OwYfJrytzOnfOBS1ThEDt07hJ9MdXHBQ5jEl1daj4s9RJ2YC5574=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706816026; c=relaxed/simple;
	bh=znNSk/omDjXJFiH6ViXr1vF8LWsH/+XjvQJqVZRMuKA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kXlUKJMzmmjgP4nTuxM5vMfn+ZVjFt7Ug7Xrmf8sRoLC/Wo3POACC8+HAJHWuwxHcnC4NrWm8Of/7O4wHxJgDB6yvBLFrA1B+A/9zngNnI4VMF3nNFlMVqjQm+M57HqeO1tI1bzQzDB0sGCPqKq9AWGxPSxM8fDKcKiTfuwsNow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net; spf=pass smtp.mailfrom=amacapital.net; dkim=pass (2048-bit key) header.d=amacapital-net.20230601.gappssmtp.com header.i=@amacapital-net.20230601.gappssmtp.com header.b=cBkL6P8H; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amacapital.net
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-4affeacaff9so551612e0c.3
        for <linux-api@vger.kernel.org>; Thu, 01 Feb 2024 11:33:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20230601.gappssmtp.com; s=20230601; t=1706816024; x=1707420824; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H8TDXyB/dLQfx4pJhHT/t6+HjwGIKR+BaTPtjymAN14=;
        b=cBkL6P8H+ZTAAoopEZ+YtL8AYKsKkMq9L3AWFaRxVEBxy9oeqLCBA04Av8Cby5w4uw
         aR5hm9gNOJNtCE4Y5OWgJqG5kMnGPcZUre92J/gdSQHSSA6+KfyjP/0DlnGg8+1+cOA3
         FEo589imYpIBC73M/u+MZXgUs3prXlloByf2t+apQgfEWcKRJBauOknh+iD+DgXpLUyu
         ugFtL/vCZ/pCQjn6MdbRQwCJ1RifFIiJD0MXg51qQH5o4cIuseYoHiheDEKQpIVhDaUe
         dmWUBaadKxhn+E/yd7k1Q2Jga8MU9kOleQMpHRbU6ZMk1ASY3P1IEWuaZft7hM0dDgKF
         +adA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706816024; x=1707420824;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H8TDXyB/dLQfx4pJhHT/t6+HjwGIKR+BaTPtjymAN14=;
        b=RCG57KqM1BlBwq4SYKJFBnH9D/gMwyJn0nB9Hm2iM0RKJYIq9d7K9xuda96HbSy5/8
         sgSkgubZd+fv0R91JVyYBX/TpTZc4edExY0Rk9NgHUAaJZkpfg9hhxs8amqZoMp3inaA
         S43To8rDCaGYgS6dpwfpyRUXRqaNvhoTqV3mb8pj7oC6SPxkuyR3wt7Ng+Zwk0p8V8a5
         OaF6mVGzWOaQSb5eMiEa/PaP4cQXL3SUDql0B39tldn8nh5mXseAtk+Ey/1k5b5jcJI+
         S7+iK/Z6TuIh2bJUx88lUnvQMbnodZLGERgTLsnayS7aW60JQoTcNOdoLqtczidJplBw
         xr1w==
X-Gm-Message-State: AOJu0YzjyULHrp4RrBE9mKo/eUNAmqWF77X6hhA2qEXK1eiN0zyczKF7
	6upOVe8f5DWeQVLh1TIsOcIbDhAFVQLJ/TESGIqaF3U6QwHfsNBy94bgf/14qFU+gRD3VrxGFkM
	rLsdNbAGyBzKSacDb6Kkn3kIf11C8vlkxb48V
X-Google-Smtp-Source: AGHT+IEGC9yHQvpZUgXv3pIXD2ajqe6DPydtm9MYIyvWPRi9Kvd72k3uKMGdDWPKgY8wALIDzg+hfttxJjz4eUly9q4=
X-Received: by 2002:a05:6122:4683:b0:4b7:4932:203d with SMTP id
 di3-20020a056122468300b004b74932203dmr6579952vkb.14.1706816024094; Thu, 01
 Feb 2024 11:33:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZbVrRgIvudX242ZU@tycho.pizza> <20240127210634.GE13787@redhat.com>
 <20240129112313.GA11635@redhat.com> <CALCETrUFDkt+K9zG8mczxzAFy9t-6Mx5Cz-Sx+it6a4nt+O0pg@mail.gmail.com>
 <20240131184829.GE2609@redhat.com> <20240131191405.GF2609@redhat.com>
 <CALCETrXTHsyiR6Bav7bXCCHny0Z2Bn90fTUL9__KTftESQ9=7w@mail.gmail.com>
 <20240131-kerngesund-baumhaus-17a428b4aacb@brauner> <CALCETrUh-DJ28W-LYZd3mACb4z-rmi4kmeUCitHjyufiN7U0sQ@mail.gmail.com>
 <20240201-laufleistung-gesessen-068ff127834d@brauner> <20240201-flugzeit-modeschau-dab703fc8b6d@brauner>
In-Reply-To: <20240201-flugzeit-modeschau-dab703fc8b6d@brauner>
From: Andy Lutomirski <luto@amacapital.net>
Date: Thu, 1 Feb 2024 11:33:32 -0800
Message-ID: <CALCETrUm3YWJCXeDufHKHj9-QU9A1sxZW2HW5a7OHEdTtB1UqQ@mail.gmail.com>
Subject: Re: [RFC PATCH] pidfd: implement PIDFD_THREAD flag for pidfd_open()
To: Christian Brauner <brauner@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Tycho Andersen <tycho@tycho.pizza>, linux-kernel@vger.kernel.org, 
	linux-api@vger.kernel.org, Tycho Andersen <tandersen@netflix.com>, 
	"Eric W. Biederman" <ebiederm@xmission.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 1, 2024 at 5:39=E2=80=AFAM Christian Brauner <brauner@kernel.or=
g> wrote:
>
> On Thu, Feb 01, 2024 at 02:30:46PM +0100, Christian Brauner wrote:
> > On Wed, Jan 31, 2024 at 11:50:23AM -0800, Andy Lutomirski wrote:
> > > On Wed, Jan 31, 2024 at 11:46=E2=80=AFAM Christian Brauner <brauner@k=
ernel.org> wrote:
> > > >
> > > > On Wed, Jan 31, 2024 at 11:24:48AM -0800, Andy Lutomirski wrote:
> > > > > > On 01/31, Oleg Nesterov wrote:
> > > > > > >
> > > > > > > On 01/31, Andy Lutomirski wrote:
> > > > > > > Please note
> > > > > > >
> > > > > > >       /* TODO: respect PIDFD_THREAD */
> > > > > > >
> > > > > > > this patch adds into pidfd_send_signal().
> > > > > > >
> > > > > > > See also this part of discussion
> > > > > > >
> > > > > > >       > > +   /* TODO: respect PIDFD_THREAD */
> > > > > > >       >
> > > > > > >       > So I've been thinking about this at the end of last w=
eek. Do we need to
> > > > > > >       > give userspace a way to send a thread-group wide sign=
al even when a
> > > > > > >       > PIDFD_THREAD pidfd is passed? Or should we just not w=
orry about this
> > > > > > >       > right now and wait until someone needs this?
> > > > > > >
> > > > > > >       I don't know. I am fine either way, but I think this ne=
eds a separate
> > > > > > >       patch and another discussion in any case. Anyway should=
 be trivial,
> > > > > > >       pidfd_send_signal() has the "flags" argument.
> > > > > > >
> > > > > > > with Christian in https://lore.kernel.org/all/20240130112126.=
GA26108@redhat.com/
> > > > >
> > > > > I missed that.  Whoops.
> > > > >
> > > > > On Wed, Jan 31, 2024 at 11:15=E2=80=AFAM Oleg Nesterov <oleg@redh=
at.com> wrote:
> > > > > >
> > > > > > Forgot to mention...
> > > > > >
> > > > > > And I agree that pidfd_send_signal(flags =3D> PGID/SID) can mak=
e
> > > > > > some sense too.
> > > > > >
> > > > > > But this a) doesn't depend on PIDFD_THREAD, and b) needs anothe=
r
> > > > > > patch/discussion.
> > > > > >
> > > > > > But again, I am not sure I understood you correctly.
> > > > > >
> > > > >
> > > > > Hmm.
> > > > >
> > > > > When one works with regular (non-fd) pids / pgids etc, one specif=
ies
> > > > > the signal domain at the time that one sends the signal.  I don't=
 know
> > > > > what pidfds should do.  It seems a bit inefficient for anything t=
hat
> > > > > wants a pidfd and might send a signal in a different mode in the
> > > > > future to have to hold on to multiple pidfds, so it probably shou=
ld be
> > > > > a pidfd_send_signal flag.
> > > > >
> > > > > Which leaves the question of what the default should be.  Should
> > > > > pidfd_send_signal with flags =3D 0 on a PIDFD_THREAD signal the p=
rocess
> > > > > or the thread?  I guess there are two reasonable solutions:
> > > > >
> > > > > 1. flags =3D 0 always means process.  And maybe there's a special=
 flag
> > > > > to send a signal that matches the pidfd type, or maybe not.
> > > > >
> > > > > 2. flags =3D 0 does what the pidfd seems to imply, and a new
> > > > > PIDFD_SIGNAL_PID flag overrides it to signal the whole PID even i=
f the
> > > > > pidfd is PIDFD_THREAD.
> > > > >
> > > > > Do any of you have actual use cases in mind where one choice is
> > > > > clearly better than the other choice?
> > > >
> > > > So conceptually I think having the type of pidfd dictate the defaul=
t
> > > > scope of the signal is the most elegant approach. And then very lik=
ely
> > > > we should just have:
> > > >
> > > > PIDFD_SIGNAL_THREAD
> > > > PIDFD_SIGNAL_THREAD_GROUP
> > > > PIDFD_SIGNAL_PROCESS_GROUP
> > > >
> > > > I think for userspace it doesn't really matter as long as we clearl=
y
> > > > document what's going on.
> > > >
> > >
> > > This seems reasonable unless we're likely to end up with a pidfd mode
> > > that doesn't actually make sense in a send_signal context.  But I'm
> > > not immediately seeing any reason that that would happen.
> >
> > Yeah, I think that's very unlikely and we could reject it obased on api
> > design considerations.
>
> Ah, forgot to ask. Did you intend to send a patch for this?

I can try to get to it tomorrow.  Currently trying to madly line up a
whole bunch of stuff in time for a maintenance window.


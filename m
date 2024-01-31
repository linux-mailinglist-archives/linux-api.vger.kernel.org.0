Return-Path: <linux-api+bounces-783-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FCE38447F2
	for <lists+linux-api@lfdr.de>; Wed, 31 Jan 2024 20:25:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C82328CAA0
	for <lists+linux-api@lfdr.de>; Wed, 31 Jan 2024 19:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D02439AE9;
	Wed, 31 Jan 2024 19:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20230601.gappssmtp.com header.i=@amacapital-net.20230601.gappssmtp.com header.b="f5ZG4o+n"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E06D93610A
	for <linux-api@vger.kernel.org>; Wed, 31 Jan 2024 19:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706729102; cv=none; b=j+1XKosmXodQSAGhvb9EHxOUaNEG5nD58TEsZ1MV5PMyn7MNfJLYevJKajSYjQFHCZbJRoUKb4I6ykqtqTkHlGFnaTRxdfzxBDOW+umGGfNCrPtINBLO0EsvfcH2unhMziUyfmbU8LOuqElPPWNutmWI3v7SJOsf2MR08wUOSUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706729102; c=relaxed/simple;
	bh=fgjO+ZKPSjohHXcq26Lv87wcORUzsg9ZFuQOiM8cecY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IwXYxPcJQk3bQkX6UBK9APIuFW5isNZLhRPnn1MA0pF4oB5ZaWnaRfopHPlGaou1bKbPVeMLqupmLNC2m07f6xaoWgitr2srLoLw8TFq4xchjsBhph0+tiFfvyGWXwhnPo37yiifYeFbYm9/4muD6q3yClKJQuDzNDKzWDOPJZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net; spf=pass smtp.mailfrom=amacapital.net; dkim=pass (2048-bit key) header.d=amacapital-net.20230601.gappssmtp.com header.i=@amacapital-net.20230601.gappssmtp.com header.b=f5ZG4o+n; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amacapital.net
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-4bfe6642220so66729e0c.2
        for <linux-api@vger.kernel.org>; Wed, 31 Jan 2024 11:25:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20230601.gappssmtp.com; s=20230601; t=1706729099; x=1707333899; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4I3eBOyzNlkmUL9oB23DTt0cGT4r7iaUTvk9/UqUMsU=;
        b=f5ZG4o+nTiQvQFxgHUSyV2KA4wEtFGxmsKM4W4P09gBZokXcyIPj27HFlEdudUQrm+
         4zjBF1K8HvEVHbZjakxvToGEGoqfy57dUktuqSfFgS+bXJ1Hyq5WzmzsR3f+d3er7+9X
         SitKPcYm2Np85wmqYOm7lkJQUw7dt3KRZleNciINvaUGO8EeGnbetjagy+mqJyJ27U3k
         QgRvbAxAhYFElOQ5QEviIq6hMag+p6TUHbEgGmwqIh/QXbPuvZo8h7tGjkn4VtMoqVdb
         /El+Tfo474mAxa7iL6ybX6lOBOTKRk7nnZ6yGv3S+F7DwzLMi7duXUdbIy3m+6InxuZi
         BRjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706729099; x=1707333899;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4I3eBOyzNlkmUL9oB23DTt0cGT4r7iaUTvk9/UqUMsU=;
        b=TtXCladdLreh8b/2wEt3nw4Mx74PJScBQIngUiv+dkw3jFU6ptEvWigCGikLTPkGdG
         e5mDT2nGMJCe4knoonTrgYVWa033LxH5OQsGeQZjGSw7g66h4tn9XmMznsReoTlCpBBo
         /8OlONGKsraEzKVccW2yaUHUAKbJVxakrirjpoOY1P1FEignV8Vw5F1mU/dffYCgkfrz
         kahPWNUYJTQaorPwdQvC2e6ptxsOpdLxnCChdxz0+du7k7k25oBz2vfu2hfarBJ3XWSc
         rJmTdir/ujsD3QQAciwUGMoVW3JR1f5uLdhl+vf9fgTD90LN/u5mzUmbnSBoGIgwLSYU
         OREQ==
X-Gm-Message-State: AOJu0Yzq598ym5PVDGp/kl8b/ZnO9RSnl9Kdxqc92eog61bJcMGomT/G
	9m52fmld8Ex4eaGzDdeGDpg+Cgs/5Td2MQcW3ynufgkU7OdQHca1RPn4BwImPeZEzxAmku0XTim
	10eKAfdOAxwm6+VA8fiKrYthN6VzWsS7nXOq6
X-Google-Smtp-Source: AGHT+IEVhi6ebAkmJ9Cn1RS6VHS6zer5DzSjHlqlbl4RLPCAcXnZnGdP0Y3tq8suiuJKnGPDAf5yLU0Epv/bzhB21ig=
X-Received: by 2002:a05:6122:3981:b0:4b6:d4a0:5841 with SMTP id
 eq1-20020a056122398100b004b6d4a05841mr2760413vkb.6.1706729099713; Wed, 31 Jan
 2024 11:24:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240127105410.GA13787@redhat.com> <ZbUngjQMg+YUBAME@tycho.pizza>
 <20240127163117.GB13787@redhat.com> <ZbU7d0dpTY08JgIl@tycho.pizza>
 <20240127193127.GC13787@redhat.com> <ZbVrRgIvudX242ZU@tycho.pizza>
 <20240127210634.GE13787@redhat.com> <20240129112313.GA11635@redhat.com>
 <CALCETrUFDkt+K9zG8mczxzAFy9t-6Mx5Cz-Sx+it6a4nt+O0pg@mail.gmail.com>
 <20240131184829.GE2609@redhat.com> <20240131191405.GF2609@redhat.com>
In-Reply-To: <20240131191405.GF2609@redhat.com>
From: Andy Lutomirski <luto@amacapital.net>
Date: Wed, 31 Jan 2024 11:24:48 -0800
Message-ID: <CALCETrXTHsyiR6Bav7bXCCHny0Z2Bn90fTUL9__KTftESQ9=7w@mail.gmail.com>
Subject: Re: [RFC PATCH] pidfd: implement PIDFD_THREAD flag for pidfd_open()
To: Oleg Nesterov <oleg@redhat.com>
Cc: Tycho Andersen <tycho@tycho.pizza>, Christian Brauner <brauner@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-api@vger.kernel.org, Tycho Andersen <tandersen@netflix.com>, 
	"Eric W. Biederman" <ebiederm@xmission.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> On 01/31, Oleg Nesterov wrote:
> >
> > On 01/31, Andy Lutomirski wrote:
> > Please note
> >
> >       /* TODO: respect PIDFD_THREAD */
> >
> > this patch adds into pidfd_send_signal().
> >
> > See also this part of discussion
> >
> >       > > +   /* TODO: respect PIDFD_THREAD */
> >       >
> >       > So I've been thinking about this at the end of last week. Do we=
 need to
> >       > give userspace a way to send a thread-group wide signal even wh=
en a
> >       > PIDFD_THREAD pidfd is passed? Or should we just not worry about=
 this
> >       > right now and wait until someone needs this?
> >
> >       I don't know. I am fine either way, but I think this needs a sepa=
rate
> >       patch and another discussion in any case. Anyway should be trivia=
l,
> >       pidfd_send_signal() has the "flags" argument.
> >
> > with Christian in https://lore.kernel.org/all/20240130112126.GA26108@re=
dhat.com/

I missed that.  Whoops.

On Wed, Jan 31, 2024 at 11:15=E2=80=AFAM Oleg Nesterov <oleg@redhat.com> wr=
ote:
>
> Forgot to mention...
>
> And I agree that pidfd_send_signal(flags =3D> PGID/SID) can make
> some sense too.
>
> But this a) doesn't depend on PIDFD_THREAD, and b) needs another
> patch/discussion.
>
> But again, I am not sure I understood you correctly.
>

Hmm.

When one works with regular (non-fd) pids / pgids etc, one specifies
the signal domain at the time that one sends the signal.  I don't know
what pidfds should do.  It seems a bit inefficient for anything that
wants a pidfd and might send a signal in a different mode in the
future to have to hold on to multiple pidfds, so it probably should be
a pidfd_send_signal flag.

Which leaves the question of what the default should be.  Should
pidfd_send_signal with flags =3D 0 on a PIDFD_THREAD signal the process
or the thread?  I guess there are two reasonable solutions:

1. flags =3D 0 always means process.  And maybe there's a special flag
to send a signal that matches the pidfd type, or maybe not.

2. flags =3D 0 does what the pidfd seems to imply, and a new
PIDFD_SIGNAL_PID flag overrides it to signal the whole PID even if the
pidfd is PIDFD_THREAD.

Do any of you have actual use cases in mind where one choice is
clearly better than the other choice?

--Andy


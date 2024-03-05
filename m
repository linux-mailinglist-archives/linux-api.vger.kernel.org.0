Return-Path: <linux-api+bounces-1097-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F156F87122A
	for <lists+linux-api@lfdr.de>; Tue,  5 Mar 2024 01:56:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A75A4281E2C
	for <lists+linux-api@lfdr.de>; Tue,  5 Mar 2024 00:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AE7BDF78;
	Tue,  5 Mar 2024 00:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mJ+AzAOA"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5668DDC5
	for <linux-api@vger.kernel.org>; Tue,  5 Mar 2024 00:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709600187; cv=none; b=pxZYgwKanSTOdRHmNgn8W4u2kJBqJ97n7xuHasb+PeolOYWSxaN/Gxf0rkrWHojsqTdxV8gHk5e7cbtGE50mticBxbff+BqXT0QoX79oyipl/g224cf8jZaHFjRafgW+AZPzlZzvJD0NRnD3MK7KwV7/HPKEO6ekGPyNAZ7p1mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709600187; c=relaxed/simple;
	bh=ylFbF96zeiE9MF3oNTTqi8RMPQ+c93clIuQ+EOBRCLw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EAIu3CD5VI9Cyd7Nz3+PDdUyE3o6HUIlp/AtegowynC0o/xvENmOSCHOFKVyQow/HjsmjCikAhd+IKR70pgp9i0yskxzPX/39RRU/6v3cnXRxS1d0FnJa1YdSlJC0JHNC63MsS34CtFUsxmyz3qwDfX46la8B1cLJ6cwmZ5TWI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mJ+AzAOA; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-429f53f0b0bso36826681cf.2
        for <linux-api@vger.kernel.org>; Mon, 04 Mar 2024 16:56:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709600185; x=1710204985; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RNnTGp94QR+qk9tYRNXAsfesB+HdWK+VCMK9wenPUaE=;
        b=mJ+AzAOADydRH2YoMD/go2xZN7qkzr+/aspVATD+/wpBSXpEEGaZ922qwcRTX+nPN3
         OEIyCsBFhwrV5zV+JMIb1qDtlJFh+TeAXn6mtjbn75jgxf3AZDD2Jeh+PxAYZOyjgeCh
         6IAlmiQLvvrXhBcOGyEINPO4h0C3jeIoYiUMwwBw8nBZHkwh0BcWTy/1GidpJfLyasXo
         /XMoG/YqAj/8nXhmdJiOjyCsL7RzYnvoDf4eOkDHW2SpViMbypKkEscEpZj5SqfziJ24
         SPxjoH1JtXiAK0bO6hDPxVLjeNGdzsZmKgS9gxffiFCd7uI1x2jJRPYrKRCWyNjL4h3k
         VCTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709600185; x=1710204985;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RNnTGp94QR+qk9tYRNXAsfesB+HdWK+VCMK9wenPUaE=;
        b=PaMp4XgU3nR7by1LTEXzqhFAq3hqIJCm9uxMQmvoUx7FIEVgxEr5CDQc5YDvOdogxB
         +ab1yWB8SJ4BEPdVONW6xbvsh8X1fzcYNk6ta1v8EQ1Fw6HviMg/oc/bM9tCt7EmiIUP
         DQerqhPUa10/51zg+FhoZ+WwpVCJAnRrM/BAzePgPBUs9w6rkuKxAUU4lpn8eJesw6dx
         jY4bBd08TmctUopIwzwtEp5dbHAk5R03FagzaZOmcgQt9iW+4BwGSqVhHC67LICS1XcR
         TQnj4HboRM8fqbAzgzajLQKTM7RgWEB86POeDk37FsMrdIkhZnGq5s3m3nks3CNV6iV2
         j5cA==
X-Forwarded-Encrypted: i=1; AJvYcCWrm9ofNTpMK/JH+8HmzCSA5Rku3ckoV4zhH4TvOuWsBo4q8PYTAtn8WP7JGK6Zf9UB7ylB+NSonnGXeyxgApJPbnoXFAYOP5wh
X-Gm-Message-State: AOJu0Yys+kllrqJyIIaJkneFAUP3/F53w0b/bwfiBWzwLJq98a9hMuf4
	uoN7OteC6PZcen3K0okMOlH/UjZ6QtRPLtCUOc66HGjGV1cz4TT6NF6JFGMC1vgklwxfF1SKOGW
	LoO8hNpGNH5P8ZGtcIbz9lsRz83h/YED9dl8A
X-Google-Smtp-Source: AGHT+IHcjwfDkL1HEvaUhhZkWgvTqm3F5QwUambkU8G/rGv9S7NB9INbD6UErDycnwQiTEsjy13CZ4aLlFiyLXQBoA0=
X-Received: by 2002:ac8:7dc5:0:b0:42e:74bc:2177 with SMTP id
 c5-20020ac87dc5000000b0042e74bc2177mr571924qte.61.1709600184635; Mon, 04 Mar
 2024 16:56:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZUIlirG-ypudgpbK@debian> <20240303121454.16994-3-alx@kernel.org>
 <5882437.otsE0voPBg@nimes> <ZeRzS6mENO8kOh1W@debian> <CAJgzZor8TTSysM=TiTXQdVtHMZPQWu5YOhPmb8PAevdVd-c31Q@mail.gmail.com>
 <ZeZohz1sLcIN6kxA@debian>
In-Reply-To: <ZeZohz1sLcIN6kxA@debian>
From: enh <enh@google.com>
Date: Mon, 4 Mar 2024 16:56:13 -0800
Message-ID: <CAJgzZoog1qS4BOYaKDnLsA3RzL-61r=33tP-XK2xvOwa008jJw@mail.gmail.com>
Subject: Re: [PATCH 2/2] clock_nanosleep.2, nanosleep.2: Use 'duration' rather
 than 'request'
To: Alejandro Colomar <alx@kernel.org>
Cc: Bruno Haible <bruno@clisp.org>, Stefan Puiu <stefan.puiu@gmail.com>, linux-man@vger.kernel.org, 
	GNU C Library <libc-alpha@sourceware.org>, linux-api@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 4, 2024 at 4:34=E2=80=AFPM Alejandro Colomar <alx@kernel.org> w=
rote:
>
> Hi Elliott,
>
> On Mon, Mar 04, 2024 at 04:18:28PM -0800, enh wrote:
> > thanks! https://android-review.googlesource.com/c/platform/bionic/+/298=
7070
> > changes to
> >
> > /**
> >  * [clock_nanosleep(2)](http://man7.org/linux/man-pages/man2/clock_nano=
sleep.2.html)
> >  * sleeps for the given time (or until the given time if the TIMER_ABST=
IME flag
> >  * is used), as measured by the given clock.
> >  *
> >  * Returns 0 on success, and returns -1 and returns an error number on =
failure.
> >  * If the sleep was interrupted by a signal, the return value will be `=
EINTR`
> >  * and `remainder` will be the amount of time remaining.
> >  */
> > int clock_nanosleep(clockid_t __clock, int __flags, const struct
> > timespec* _Nonnull __time, struct timespec* _Nullable __remainder);
>
> Hmmmm, that's the best name, meaningfully, I think.  But I've been
> trying to avoid it.  I don't like using names of standard functions in
> identifiers; it might confuse.  As an alternative, I thought of 't'.
> What do you think?

as you can see, i've taken the "the leading `__` means we get to
trample whatever we like" approach :-)

(we build bionic with hidden visibility and an explicit list of
symbols for the linker to export, so we'd have to be trying quite hard
to trip over ourselves.)

> Have a lovely night!
>
> Alex
>
> --
> <https://www.alejandro-colomar.es/>
> Looking for a remote C programming job at the moment.


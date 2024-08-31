Return-Path: <linux-api+bounces-2262-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F085967251
	for <lists+linux-api@lfdr.de>; Sat, 31 Aug 2024 17:10:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C278B1F224EE
	for <lists+linux-api@lfdr.de>; Sat, 31 Aug 2024 15:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24C351EB5B;
	Sat, 31 Aug 2024 15:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cppYvdiN"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F988468;
	Sat, 31 Aug 2024 15:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725117028; cv=none; b=oV2ttNW5sQ1cp7i902godBw6N1bL4Ux7uq7S3op1ijEzUeCizZ2HFVWBwGCR2ZoCpYqruFuV43nHaQ1bTLlH526WABUy5dWfiRSJIbWL545Eu+cN43dYZVH6ExHQjoEuhS1u+9eMSETnlYVMaFtdomvLBhTnYXmYsIM595hACkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725117028; c=relaxed/simple;
	bh=61R99Wi3es6kIiedN/jyLnosGCCGWj5Sck4l4OPpFh8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZDAZM7tqpQjHx+I6k/UZViQ+VNWTx28VNontu9KG6LdLk4XJkmmbwHU0OXdlwTTAw5jmN2QkwnLI7K2Reb+AC8vQDzHLdBzN/MEIuUfHi5kv8iRDBmHkWOGzi98BPHPUgIWkinaFF02befsNKd0LFX3DJP4jRjAsdeHlwYvBA48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cppYvdiN; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6d3f4218081so17734777b3.1;
        Sat, 31 Aug 2024 08:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725117025; x=1725721825; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V2d3mA2+uVAqPemFiOJXwGzLufJDht758g4ucyWTe6M=;
        b=cppYvdiNfJyYfb6yc9lfPQQqCU67TMKHAFTzMxB7WyEPbsAzwERVxPTUkmu9lzpqNa
         S+vgsxO4w31/em2cEcJD2chetR+MBen7WMmUAD9gqwFGWiBauZcsF//WQgt83lLYZrNk
         F+Gyxaqm5FJ3TJlGeQPrHO4BE9OAuxvhxJvgSTY+ChwY4wRvhZk+fnEdLR876k+9hhv5
         D0AbMr1rWEeKJgsU5TSSkJPHrdfaZkbDNFSX7e2jpOnulGK7EttgdplPQyOwas4KO/x7
         x53UkHzdl+DgPgeyzGj5E+1Kcb4ppWjRb14cNXrpxgZL5AgHRSANx+17c+Ge56W9ysc0
         0FEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725117025; x=1725721825;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V2d3mA2+uVAqPemFiOJXwGzLufJDht758g4ucyWTe6M=;
        b=HtGkEEM51Rlqfutn0ZptyItd8dtSrwY2Tbjjd/cHgCK1aYn/2FncaL2UoJcDeQPlIE
         1JNWcz4x0Ecpzev4LdR6jOjbK5aI7YTJi5oBdf7b2CMppind4ucEYb4Bl3du0LE6nvYP
         7nvJCBD/LikB1SYCvGfhuULMmNXgfBGvYGEpL9N8x3Dbw2R45jD1P5I3aQPJyGyzaIjz
         DGkgTH2zhNnLJ57w2Dm/8CO9zn4GFQ1aAQD4RVFqwDb+0PgTyE3B1yC6/K95JK0Wru/t
         KVLoRPJxBITKA/VrG0noy/CeWgcCcQgTTL3e/b1IZHMmLgESodNUaB9zWk94cqtV0mc7
         8PgA==
X-Forwarded-Encrypted: i=1; AJvYcCUUYdUZPx+ApcrQfekRXH2lfxWEqjxUEzBaxqLc4h2tuid/nJuuKEkqBOnw7LkCyVoLhEoPmbqjpv0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKHL4IL1hcIoCXVNlrO2gG7birwxt3z9q87kZXx3+F1s44jOpG
	E4cYsWUhtpvUUC5R4uJGyA7aZQwOKZ+MQH3vxMATC4zDYXC/GtD5uaje7euCqow71gyjUVgbCw8
	ycEc6UZl13mF5yPqx1SLMuLlff80ZidIC1kFgPjL9
X-Google-Smtp-Source: AGHT+IGQlv+0vjwX+PYoG1jtD9Jt03NaGommlMhRMYySvt0ALK33izI0Urab5jUPxMcGsBt4+YKYtgebhxqm/ibIJxY=
X-Received: by 2002:a05:690c:ec1:b0:697:7cc0:ce1 with SMTP id
 00721157ae682-6d40d78d826mr70278427b3.7.1725117025416; Sat, 31 Aug 2024
 08:10:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240829205436.GA14562@brightrain.aerifal.cx> <20240831092902.GA2724612@port70.net>
 <20240831150241.GP10433@brightrain.aerifal.cx>
In-Reply-To: <20240831150241.GP10433@brightrain.aerifal.cx>
From: "H.J. Lu" <hjl.tools@gmail.com>
Date: Sat, 31 Aug 2024 08:09:49 -0700
Message-ID: <CAMe9rOqSSX_YP7dq5WK7vDyrQ5RP6nUNrim-8FjJi1X_8NfAvg@mail.gmail.com>
Subject: Re: [musl] AT_MINSIGSTKSZ mismatched interpretation kernel vs libc
To: Rich Felker <dalias@libc.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-api@vger.kernel.org, 
	libc-alpha@sourceware.org, musl@lists.openwall.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 31, 2024 at 8:03=E2=80=AFAM Rich Felker <dalias@libc.org> wrote=
:
>
> On Sat, Aug 31, 2024 at 11:29:02AM +0200, Szabolcs Nagy wrote:
> > * Rich Felker <dalias@libc.org> [2024-08-29 16:54:38 -0400]:
> > > As I understand it, the AT_MINSIGSTKSZ auxv value is supposed to be a
> > > suitable runtime value for MINSIGSTKSZ (sysconf(_SC_MINSIGSTKSZ)),
> > > such that it's safe to pass as a size to sigaltstack. However, this i=
s
> > > not how the kernel actually implements it. At least on x86 and
> > > powerpc, the kernel fills it via get_sigframe_size, which computes th=
e
> > > size of the sigcontext/siginfo/etc to be pushed and uses that
> > > directly, without allowing any space for actual execution, and withou=
t
> > > ensuring the value is at least as large as the legacy constant
> > > MINSIGSTKSZ. This leads to two problems:
> > >
> > > 1. If userspace uses the value without clamping it not-below
> > >    MINSIGSTKSZ, sigaltstack will fail with ENOMEM.
> > >
> > > 2. If the kernel needs more space than MINSIGSTKSZ just for the signa=
l
> > >    frame structures, userspace that trusts AT_MINSIGSTKSZ will only
> > >    allocate enough for the frame, and the program will immediately
> > >    crash/stack-overflow once execution passes to userspace.
> > >
> > > Since existing kernels in the wild can't be fixed, and since it looks
> > > like the problem is just that the kernel chose a poor definition of
> > > AT_MINSIGSTKSZ, I think userspace (glibc, musl, etc.) need to work
> > > around the problem, adding a per-arch correction term to
> > > AT_MINSIGSTKSZ that's basically equal to:
> > >
> > >     legacy_MINSIGSTKSZ - AT_MINSIGSTKSZ as returned on legacy hw
> > >
> > > such that adding the correction term would reproduce the expected
> > > value MINSIGSTKSZ.
> > >
> > > The only question is whether the kernel will commit to keeping this
> > > behavior, or whether it would be "fixed" to include all the needed
> > > working space when they eventually decide they want bigger stacks for
> > > some new register file bloat. I think keeping the current behavior, s=
o
> > > we can just add a fixed offset, is probably the best thing to do.
> >
> > i think it makes sense that the kernel sets AT_MINSIGSTKSZ
> > according to what the kernel needs (signal frame size)
> > anything beyond that is up to userspace requirements (e.g.
> > the kernel cannot know if the libc wraps signal handlers)
> >
> > it's up to the libc to adjust sysconf(_SC_MINSIGSTKSZ)
> > according to posix or backward compat requirements.
>
> I think this is a reasonable viea and means the aux key was just very
> poorly named. It should have been called something like
> AT_SIGFRAMESIZE to indicate to the userspace-side consumer that it's
> not a suitable value for MINSIGSTKSZ, only a contributing term for it.
>
> Rich

glibc manual has

=E2=80=98_SC_MINSIGSTKSZ=E2=80=99

     Inquire about the minimum number of bytes of free stack space
     required in order to guarantee successful, non-nested handling of a
     single signal whose handler is an empty function.

          =E2=80=98MINSIGSTKSZ=E2=80=99
               This is the amount of signal stack space the operating
               system needs just to implement signal delivery.  The size
               of a signal stack *must* be greater than this.

               For most cases, just using =E2=80=98SIGSTKSZ=E2=80=99 for =
=E2=80=98ss_size=E2=80=99 is
               sufficient.  But if you know how much stack space your
               program's signal handlers will need, you may want to use
               a different size.  In this case, you should allocate
               =E2=80=98MINSIGSTKSZ=E2=80=99 additional bytes for the signa=
l stack and
               increase =E2=80=98ss_size=E2=80=99 accordingly.


--=20
H.J.


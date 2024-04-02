Return-Path: <linux-api+bounces-1211-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 334BD894AEA
	for <lists+linux-api@lfdr.de>; Tue,  2 Apr 2024 07:43:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56B3A1C222E5
	for <lists+linux-api@lfdr.de>; Tue,  2 Apr 2024 05:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FABD18624;
	Tue,  2 Apr 2024 05:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nQ9eMqNF"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51F2518050
	for <linux-api@vger.kernel.org>; Tue,  2 Apr 2024 05:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712036597; cv=none; b=uOEDZG8hTOZJ+QVqU2OjGzhzxitCDMnXFbJ3FTzGBqKtTqGZhDBwOXKx5O9Tve8Vz3JRlmuT/JuqXUGIDgFUhtCqWWE8PHMQhNQhLriL3DeIDyQDHKgKyafuAwveJ4umht5C1cFwmzgXcUrOqwRvTcVWr+T1+4zezJghiOH2HNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712036597; c=relaxed/simple;
	bh=TUTob1DnNgGtqXSzjC4an0vYfwqKWZaOUgtv0d79Qg8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mX5VGvdcpHsYy0XuqupP71LzwOR9I4TVG4J4amT+tl9V8qheyaoK9yAoaqg0o/46aLz9LNbBQq7nivSPPprfon7d9Q66MGQVm68YorQ19un+BaewvyQ6/z1zigdc21jLDFmpQyf/s5myZoP+o8BlAhyJAEotIwHmIYXU48D3StQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nQ9eMqNF; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-41551500a7eso21793745e9.2
        for <linux-api@vger.kernel.org>; Mon, 01 Apr 2024 22:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712036594; x=1712641394; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ElrucjJAh1FRwBd0ssTMvr49phQYXRtbH2c4ZoKFETc=;
        b=nQ9eMqNFyJImIS8Gyw9frHNQ2FKKcjsm81Nh/Pb9dGKst3j86Xw4cOJnQvFDj+7PG/
         U59aoqLYP7a8q+PF2j3vbFOJ3hUJrOIllCt6Dm0YchHNKUUNw9+VtyMH/n6/ax/3ngeq
         99KhaxFsXG3eD/IobKgLON6JSEsk2fGJd9ot946L/LjY8CkAz+wJXH0ADOIdHNq7bp3V
         ymaQ2wEi+9trLpr/9x6KLIrk22JhAeeE5DtxCANeKqpVPRR064ab8H/FLOFPN/pB5NhO
         f/QKIygl9Eo6hmVvdwAXY7dYQWG15/3dON4hx7rDGEsmj7wXpsgc0BlDrtZBsLmB/GGa
         mUsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712036594; x=1712641394;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ElrucjJAh1FRwBd0ssTMvr49phQYXRtbH2c4ZoKFETc=;
        b=MQ3c379uGQHISINLfa+PwishCZ/UhGICUKho6/qwYP+kUvk1XHMmZF4Z49vwjqQBay
         cMCNpNGnDjAzVqOlEPP2d3oUUoa7WXqxOctg9RqcNTJXsmADAV/oE/p6e+GApcyu6ENi
         56Da+P13BhEnLG9kqpBUZpLz95IlqMoEUuh9sHl43glp07HIf4a9wRjuwYT3Ind50q7R
         G1aEK0U9OvaQXdUIB4JAgCIOv2Y2zqTqxLdwtZAKGSm/QBXVwGmTM2tsBWfdMUx8Yakt
         3CzGzAdHnflDceIGjhuBhGDAqgN76qY44rBHodKGoNzH07Ji40W9apKRROTibBp9eU2I
         iziA==
X-Forwarded-Encrypted: i=1; AJvYcCXDStMrsPyy497TqkEtm/m26ofZsNU2vpuGTB17oRrIK4hW+KLnzc2HNgSFlHDkti/an4/0gF2Y/theQ0xshMpM7umYG+rSjU1B
X-Gm-Message-State: AOJu0YzEQ7jb68iRXKgMYW+Jb6qnGArk6NgeucMYNgfOhlxT2Ow1B4u7
	gnHBOgFXL7RQB9JtkpkkJ/zGn9RXZmyB7Hs/fNdIo0iD47lUZ4rLsfJi9ybZ1hAYza55SHsGlMS
	931N+zhGCkE3xfMjqBItZlcsMUf3iGvx6O224
X-Google-Smtp-Source: AGHT+IFiBqJRjrw72zSUpiTWSfBG18M5uU9g2uQeWa4ZYJfGErQRY1gN3b2iLLy53yu4DnLzCKNFKFKedUna4nqcdtw=
X-Received: by 2002:adf:eb82:0:b0:341:a13d:4f73 with SMTP id
 t2-20020adfeb82000000b00341a13d4f73mr8208252wrn.0.1712036593542; Mon, 01 Apr
 2024 22:43:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMuE1bHBky9NGP22PVHKdi2+WniwxiLSmMnwRM6wm36sU8W4jA@mail.gmail.com>
 <878r29hjds.ffs@tglx> <CAMuE1bF9ioo39_08Eh26X4WOtnvJ1geJ=WRVt5DhU8gEbYJNdA@mail.gmail.com>
 <87o7asdd65.ffs@tglx>
In-Reply-To: <87o7asdd65.ffs@tglx>
From: =?UTF-8?B?TWFoZXNoIEJhbmRld2FyICjgpK7gpLngpYfgpLYg4KSs4KSC4KSh4KWH4KS14KS+4KSwKQ==?= <maheshb@google.com>
Date: Mon, 1 Apr 2024 22:42:47 -0700
Message-ID: <CAF2d9jjA8iM1AoPUhQPK62tdd7gPnCnt51f_NMhOAs546rU3dA@mail.gmail.com>
Subject: Re: [PATCH v7] posix-timers: add clock_compare system call
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Sagi Maimon <maimon.sagi@gmail.com>, richardcochran@gmail.com, luto@kernel.org, 
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, 
	hpa@zytor.com, arnd@arndb.de, geert@linux-m68k.org, peterz@infradead.org, 
	hannes@cmpxchg.org, sohil.mehta@intel.com, rick.p.edgecombe@intel.com, 
	nphamcs@gmail.com, palmer@sifive.com, keescook@chromium.org, 
	legion@kernel.org, mark.rutland@arm.com, mszeredi@redhat.com, 
	casey@schaufler-ca.com, reibax@gmail.com, davem@davemloft.net, 
	brauner@kernel.org, linux-kernel@vger.kernel.org, linux-api@vger.kernel.org, 
	linux-arch@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 1, 2024 at 1:46=E2=80=AFPM Thomas Gleixner <tglx@linutronix.de>=
 wrote:
>
> Sagi!
>
> On Thu, Mar 28 2024 at 17:40, Sagi Maimon wrote:
> > On Sat, Mar 23, 2024 at 2:38=E2=80=AFAM Thomas Gleixner <tglx@linutroni=
x.de> wrote:
> >> On top this needs an analyis whether any of the gettimex64()
> >> implementations does something special instead of invoking the
> >> ptp_read_system_prets() and ptp_read_system_postts() helpers as close =
as
> >> possible to the PCH readout, but that's not rocket science either. It'=
s
> >> just 21 callbacks to look at.
> >>
> > I like your suggestion, thanks!
> > it is what our user space needs from the kernel and with minimum kernel=
 changes.
> > I will write it, test it and upload it with your permission (it is you
> > idea after all).
>
> You don't need permission. I made a suggestion and when you are doing the
> work I'm not in a position to veto posting it. We have an explicit tag
> for that 'Suggested-by:', which only says that someone suggested it to
> you, but then you went and implemented it, made sure it works etc.
>
> >> It might also require a new set of variant '3' IOTCLS to make that fla=
g
> >> field work, but that's not going to make the change more complex and
> >> it's an exercise left to the experts of that IOCTL interface.
> >>
> > I think that I understand your meaning.
> > There is a backward compatibility problem here.
> >
> > Existing user space application using PTP_SYS_OFFSET_EXTENDED ioctl
> > won't have any problems because of the "extoff->rsv[0] ||
> > extoff->rsv[1] || extoff->rsv[2]" test, but what about all old user
> > space applications using: PTP_SYS_OFFSET ?
>
> So if there is a backwards compability issue with PTP_SYS_OFFSET2, then
> you need to introduce PTP_SYS_OFFSET3. The PTP_SYS_*2 variants were
> introduced to avoid backwards compatibility issues as well, but
> unfortunately that did not address the reserved fields problem for
> PTP_SYS_OFFSET2. PTP_SYS_OFFSET_EXTENDED2 should just work, but maybe
> the PTP maintainers want a full extension to '3'. Either way is fine.
>
https://patchwork.kernel.org/project/netdevbpf/patch/20240104212436.3276057=
-1-maheshb@google.com/

This was my attempt to solve a similar issue with the new ioctl op to
avoid backward compatibility issues.  Instead of flags I used the
clockid_t in a similar fashion.

Thanks,

> Thanks,
>
>         tglx
>
>


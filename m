Return-Path: <linux-api+bounces-1084-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9939886B8B5
	for <lists+linux-api@lfdr.de>; Wed, 28 Feb 2024 21:01:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 316A11F2367C
	for <lists+linux-api@lfdr.de>; Wed, 28 Feb 2024 20:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8983F5E082;
	Wed, 28 Feb 2024 20:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20230601.gappssmtp.com header.i=@amacapital-net.20230601.gappssmtp.com header.b="1jRHfke3"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 404E05E069
	for <linux-api@vger.kernel.org>; Wed, 28 Feb 2024 20:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709150463; cv=none; b=Y0XzcmQ/thTiZr6p9TkUjIN61MB8tZaH9JOJszkPikTugZj+M2m0mk6z/qr6RQ4wrepQ1DI7XbthdL6FVGWE+qFzjV9NWBN89AEcN0AP0kD0fZ8J0Zmu4jA/pkjhdiokPw8RUkWzBz1vIJTxgcSVngVD0M2MOaWHXvt+VLeBAJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709150463; c=relaxed/simple;
	bh=OoLOaFtjiu5mHAEpVsVyKx/jaXG/BTwjD3qUzA1ql+0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mYWzviUASJ2kIZ5PYHYYWmVcURZF5rer8ZFszD/lyEJIK/Lc2XLypHbc7QrbTR8F26OoDzmMDIZvxMeNvjaNz/fJbXvVQOa0Ggi/zG28NorWm8dleSuKuD0m0fJlYDlJn5lU7XeZyum1SY9+2JLgSkZMFVYBMjSZgvuWXB7y6mY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net; spf=pass smtp.mailfrom=amacapital.net; dkim=pass (2048-bit key) header.d=amacapital-net.20230601.gappssmtp.com header.i=@amacapital-net.20230601.gappssmtp.com header.b=1jRHfke3; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amacapital.net
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-4cea831ed57so9161e0c.1
        for <linux-api@vger.kernel.org>; Wed, 28 Feb 2024 12:01:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20230601.gappssmtp.com; s=20230601; t=1709150460; x=1709755260; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wNIoc5z9e1UL1YdttUpqhucICMbrEHRvuLe/Sh1Z598=;
        b=1jRHfke36baS7LtteMU/AHdJM1PhWvMzIb9G5CjU3Wc4d71nBZ/gVvyoeE3O3Bakdj
         zOFUhy0m+UH6C7ZClbBhFkbk+eB0SeeQvWQDnaOw/0C5y0woXx3CGyOmsvFv4Aympe7h
         aTEpj1VrAlBU2wM/WV5UN0ALQqDVLyeaGs8UtCkGyYtZ+vJY9NWXawgkxwyKhI9W/EcN
         4blQcKsVapDhMNKDguOjKAGM8ckdUzuNRJgsAVBS4T3y3P3E5rJ0+2Jg1jIuGkrUrXnw
         0NfRugMSicD9yahdVaihtqSug5eRMmKjlX1MUIGVhoSE4UrCanL810G0SzHlOTzahwdJ
         R+tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709150460; x=1709755260;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wNIoc5z9e1UL1YdttUpqhucICMbrEHRvuLe/Sh1Z598=;
        b=CIvZCBOU4TqtTOqNE0SLpLITioX27Cg3iSnkovlJty8o3W/HDx7dOaUyg6bpvK/orP
         Jsjb+0dtx9CM9vuwUbtoI5lU/Fpez7fepOja5dgUUkXcCRyefXNC30CdDdoz1DKgK/DM
         jOBsFWu8/VnYv2ETmOmf37+zVMbftbBS0YBO2hv0dfQjBCBO1AORU2GFAR/k1Y55+OGC
         RC2cQjdhqZ59UPSObkSa8l2JgDVzQtjmP3yiIvs9j/K1dtWB2s2ZXyg+4F3X/Qu6R7k0
         zX3sn6McgU/pSruZmZIm2OmXZkTlRmr62WcXXu47qmJX8xAGA+fM57nYqUZtKyX4nUDA
         e9Lg==
X-Forwarded-Encrypted: i=1; AJvYcCU+UkyRhfRSEGbokq+d7TjKXtfhJK2L5oWhT8qjbZdrTGMphwuyUVuGCyAyNN0sWxzO0Vww+HnnLZQyVaNymdXgceDj/LNE9dzK
X-Gm-Message-State: AOJu0YwG70dpfMJUTFZt2ei5O59WlWDvfnNBKpTrWRliuS5EpbvQcuWq
	le3BoFsNJhsCu8DVv2++0XOi2wV6zor+d38Y3uu9HQf7Ijsz+Pu+FqEFZLRwkzxBxymID+yLZMn
	2XSKmLbZH9SsS02ISxxnCMXN1hFPlpqG3sJyV
X-Google-Smtp-Source: AGHT+IHTBM+WR/AKVjuDKYcFjCDqCl2g6BPsVgzaaT0GitljWXCEQLn8iMCiISvoFBuY/pp5LEQPBVHtK28UNPL4pIA=
X-Received: by 2002:a1f:cb84:0:b0:4d1:3f5d:50d4 with SMTP id
 b126-20020a1fcb84000000b004d13f5d50d4mr725653vkg.8.1709150460121; Wed, 28 Feb
 2024 12:01:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALCETrUe23P_3YAUMT2dmqq62xAc7zN0PVYrcChm4cHGJMDmbg@mail.gmail.com>
 <852606cd9cbc8da9c6735b4ad6216ba55408b767.camel@redhat.com> <CALCETrUZuhvR3GygBfyfLxeas+igNe51Tnx=HEnh9LoFutN-dQ@mail.gmail.com>
In-Reply-To: <CALCETrUZuhvR3GygBfyfLxeas+igNe51Tnx=HEnh9LoFutN-dQ@mail.gmail.com>
From: Andy Lutomirski <luto@amacapital.net>
Date: Wed, 28 Feb 2024 12:00:48 -0800
Message-ID: <CALCETrXTOQRaGf650+fdyH1yKJLFY-WTpXWkThakacV0GKA=eg@mail.gmail.com>
Subject: Re: The sk_err mechanism is infuriating in userspace
To: Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>
Cc: Network Development <netdev@vger.kernel.org>, Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 6, 2024 at 9:24=E2=80=AFAM Andy Lutomirski <luto@amacapital.net=
> wrote:
>
> On Tue, Feb 6, 2024 at 12:43=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> w=
rote:
> >
> > What about 'destination/port unreachable' and many other similar errors
> > reported by sk_err? Which specific errors reported by sk_err does not
> > indicate that anything is wrong with the socket ?

I started writing a series to improve this in a backwards-compatible
way, but now I'm wondering whether the current behavior may be
partially a regression and not actually something well-enshrined in
history.

The nasty behavior in question is that, if a UDP or ping (or
presumably TCP, but that case is not necessarily a problem) socket
enables IP_RECVERR, then an ICMP error will asynchronously cause the
next sendmsg() to fail.  The code that causes this seems to be ancient
(I think it's sock_wait_for_wmem, which predates git, but I won't
swear to that)

Looking at my own logs, though, a Linux 4.5.2 did not seem to
regularly trigger this, and I'm getting it on a regular basis on 6.2
and some newer kernels.  And, somewhat damningly (with IP addresses
redacted):

$ traceroute -I 10.1.2.3
traceroute to 10.1.2.3 (10.1.2.3), 30 hops max, 60 byte packets
 1  * * *
 2  10.5.6.7 (10.5.6.7)  0.593 ms  0.793 ms  0.988 ms
 3  10.8.9.10 (10.8.9.10)  1.247 ms  1.547 ms  1.881 ms
 4  10.11.12.13 (10.11.12.13)  1.032 ms  1.333 ms  1.679 ms
send: No route to host

Whoops, traceroute is getting a bogus return when it sends a packet,
causing it to give up.  The real trace should be longer.

So I'm wondering if maybe this behavior should be seen as a bug to be
fixed and not a weird old API that needs to be preserved.

--Andy


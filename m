Return-Path: <linux-api+bounces-1756-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E82B790DB25
	for <lists+linux-api@lfdr.de>; Tue, 18 Jun 2024 19:55:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C89F1C20E4D
	for <lists+linux-api@lfdr.de>; Tue, 18 Jun 2024 17:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF3991494DA;
	Tue, 18 Jun 2024 17:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20230601.gappssmtp.com header.i=@amacapital-net.20230601.gappssmtp.com header.b="kB2rkWWt"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F39DA146A88
	for <linux-api@vger.kernel.org>; Tue, 18 Jun 2024 17:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718733334; cv=none; b=D0Unpjab9Z0IbBKb8JPPoIkMKotwJ4BNDiPV68qfAt1S8FUDwfKaqgP5w7mG7yeXEZr1hTyxofUBnHgS5POMWRT8xpk/GpRSrP6WzNMw1KXffiaSKxgLe+i72SIR+dfnoFPOwO1SFlPPCnJ71IftIfV/kEL+TMDdbcIzBDlzTgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718733334; c=relaxed/simple;
	bh=DTLUZ676QRfLifqNmaQ9PMFqLKool7WG4v5zx1rImQY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WZX8+rDg0qXAbSxIoEj6bouF8Robjz9pgDQ3WcV1As+xCj6pjVsr+zQuZYyELAbIBhKWvLDnhpvW39hHFpSRC363gR4Aig2zgYHaeIQLSUemXr+A+IfUawp4sV4tH+Bj0SUdt+1p6SytFS2ADJqkeCMljH4kA5RDvW5RxwQRvig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net; spf=pass smtp.mailfrom=amacapital.net; dkim=pass (2048-bit key) header.d=amacapital-net.20230601.gappssmtp.com header.i=@amacapital-net.20230601.gappssmtp.com header.b=kB2rkWWt; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amacapital.net
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a689ad8d1f6so696323066b.2
        for <linux-api@vger.kernel.org>; Tue, 18 Jun 2024 10:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20230601.gappssmtp.com; s=20230601; t=1718733331; x=1719338131; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zTmVnnzmQsdyJIvy7P5jLUWUPiZqPVgC2Gi3EXBWni0=;
        b=kB2rkWWtppZXitxZLFcDtx+kpT/Qndcko9E0yU6rFWKm0pqGFZkM2b5IbuU8JRKOe7
         55XWcF1ZAqkciDUsfBtgdElcekhUL8G9arNvwgE+wC1Plt50vLW6uz2n4Mc7cZyU3haY
         x/yw7tTvwOEwCpXq+vW8Y1NmlMZac/mHcEla66myzgXn8FVuPsUFPX1fT83YGdY9DweS
         TFneWPMK3g6Kob0idDmuAQs+L9o4Rv8SKoW/OY0YPLt4lWCvRgqI9FQOIGKyOm5YYmxj
         yqiuXK9ljx4+Qyxa4Uj80//xwuWtlzBDsQhk2SHodrUqilTla3eOibexHNV9yds/F9J6
         il/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718733331; x=1719338131;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zTmVnnzmQsdyJIvy7P5jLUWUPiZqPVgC2Gi3EXBWni0=;
        b=qK9eKxdkAJHt8zhRCazMXBL9KDmvJJJ6RkB170/S8hNTOYh/ravYQ1WaeeUJyErbc+
         fs3nQpfL8HVlaoCNPPyvD1dPQXayJK+HYK9AptrD6Vi/QR5OCqniQ0st3WBRCeQan+gg
         Fxb0ohZDMBWZY30IeE4G132wgWI2r+oWgIze+12bBaVl+/6CWGO3ZTs7fswyE7FHuscB
         v7tgIvH82bW1i9jWuN8S6c49mV439BOEgvMwRQbuEeeZDteyaVAvSF+uZdb+HZ+iUZcU
         UDjyqlyaPyvpZMQgYAYuHsb1uV22A45VWB2YlcF6g8Bun1c7xLNxD0EfIoXEwtpgqFVB
         iCBw==
X-Forwarded-Encrypted: i=1; AJvYcCUFKLTH9rsW9tbQJJtT1UQtyku4Ol2GT9+gkTwTtg/ZcWGg4rrDInvswf51roc+CUbRW6L7Ll3uOCznf+PDRnSAfehEmBbyffQx
X-Gm-Message-State: AOJu0YzTDVGbvOjJV+OfK2B2YkfCp1pv9e1dYYHQa4gkIfz4zrIqUumv
	At6xkVjmmy8DLh3W4J4bQsWrKCgCXGp6C3YfuIItlX5NuOyq8DLaLAH1t3Uf57enlNTsfPXWluo
	j2GepfpjEA+9zBnJn9hnKCrdhWAjbpWheRF0A
X-Google-Smtp-Source: AGHT+IGDO9MunPaTLk2H5XQt/NMq7+U7oPvCv8jQC1cNGWo0/s+agXuJNN4zhVSHAUJqe1AspkjtzsT7TrN2MZj0MyE=
X-Received: by 2002:a17:906:c10d:b0:a6f:cce:4457 with SMTP id
 a640c23a62f3a-a6fab7dc751mr15171166b.71.1718733331107; Tue, 18 Jun 2024
 10:55:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240614190646.2081057-1-Jason@zx2c4.com> <20240614190646.2081057-5-Jason@zx2c4.com>
 <CALCETrVQtQO87U3SEgQyHfkNKsrcS8PjeZrsy2MPAU7gQY70XA@mail.gmail.com> <ZnDQ-HQH8NlmCcIr@zx2c4.com>
In-Reply-To: <ZnDQ-HQH8NlmCcIr@zx2c4.com>
From: Andy Lutomirski <luto@amacapital.net>
Date: Tue, 18 Jun 2024 10:55:17 -0700
Message-ID: <CALCETrWzXQMXjvL+nGq-+aLVUeiABJ46DACtLnrLXxmwh9s_dg@mail.gmail.com>
Subject: Re: [PATCH v17 4/5] random: introduce generic vDSO getrandom() implementation
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: linux-kernel@vger.kernel.org, patches@lists.linux.dev, tglx@linutronix.de, 
	linux-crypto@vger.kernel.org, linux-api@vger.kernel.org, x86@kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>, "Carlos O'Donell" <carlos@redhat.com>, 
	Florian Weimer <fweimer@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>, 
	Christian Brauner <brauner@kernel.org>, David Hildenbrand <dhildenb@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 17, 2024 at 5:12=E2=80=AFPM Jason A. Donenfeld <Jason@zx2c4.com=
> wrote:
>
> Hi Andy,
>
> On Mon, Jun 17, 2024 at 05:06:22PM -0700, Andy Lutomirski wrote:
> > On Fri, Jun 14, 2024 at 12:08=E2=80=AFPM Jason A. Donenfeld <Jason@zx2c=
4.com> wrote:
> > >
> > > Provide a generic C vDSO getrandom() implementation, which operates o=
n
> > > an opaque state returned by vgetrandom_alloc() and produces random by=
tes
> > > the same way as getrandom(). This has a the API signature:
> > >
> > >   ssize_t vgetrandom(void *buffer, size_t len, unsigned int flags, vo=
id *opaque_state);
> >
> > Last time around, I mentioned some potential issues with this function
> > signature, and I didn't see any answer.  My specific objection was to
> > the fact that the caller passes in a pointer but not a length, and
> > this potentially makes reasoning about memory safety awkward,
> > especially if anything like CRIU is involved.
>
> Oh, I understood this backwards last time - I thought you were
> criticizing the size_t len argument, which didn't make any sense.
>
> Re-reading now, what you're suggesting is that I add an additional
> argument called `size_t opaque_len`, and then the implementation does
> something like:
>
>     if (opaque_len !=3D sizeof(struct vgetrandom_state))
>         goto fallback_syscall;
>
> With the reasoning that falling back to syscall is better than returning
> -EINVAL, because that could happen in a natural way due to CRIU. In
> contrast, your objection to opaque_state not being aligned falling back
> to the syscall was that it should never happen ever, so -EFAULT is more
> fitting.
>
> Is that correct?

Yes, exactly.

My alternative suggestion, which is far less well formed, would be to
make the opaque argument be somehow not pointer-like and be more of an
opaque handle.  So it would be uintptr_t instead of void *, and the
user API would be built around the user getting a list of handles
instead of a block of memory.

The benefit would be a tiny bit less overhead (potentially), but the
API would need substantially more rework.  I'm not convinced that this
would be worthwhile.

--Andy


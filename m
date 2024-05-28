Return-Path: <linux-api+bounces-1640-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7B728D1CF9
	for <lists+linux-api@lfdr.de>; Tue, 28 May 2024 15:29:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D96281C20966
	for <lists+linux-api@lfdr.de>; Tue, 28 May 2024 13:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 020F816F0EA;
	Tue, 28 May 2024 13:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="MrQRKMFJ"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC0AC1DFDE;
	Tue, 28 May 2024 13:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716902955; cv=none; b=nWYDf1wMvbzqg1dt6QvwM0ywhv2jVWijEEPBPqvTuBzwQE3KORyvUzGImOLAunCDGw8E7rObIamHlSdT8Ypqe8Mig6REGpSTXwSVERVjDrTpro3/6nIrPiCABdswLftdSEPGOng9Z0S1mcWOKnSPzFf2BXI59aKcK9ChKGIe24E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716902955; c=relaxed/simple;
	bh=qF8RnWFXhFZYrpN4r/EMJVCuG3JWWMLwa2UIkxtk+Iw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FrC7NcgTfSuCqXZvYRplbeLiFeoTnUzUjI/5t9zie4PtqvdO/X1ws6VyJy6gJd8M/tdvZaZLnO7jzohzQEM3Jgnll3l2S+Yde2N7e3xWVpIniszTqWBv3AgqNtgs/lj3ATWeoYREIieklwxahxaRjUchm/sH0iBieUtD/+OWjOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=MrQRKMFJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0773DC3277B;
	Tue, 28 May 2024 13:29:14 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="MrQRKMFJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1716902952;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qF8RnWFXhFZYrpN4r/EMJVCuG3JWWMLwa2UIkxtk+Iw=;
	b=MrQRKMFJRoPe7FaF1hwpXUpz8Wl1U3UURMQYo9raXoTDEElrhOjCuYlsvf1U2GniA03dS1
	cxcV19Chtvf0JItex26FD2frelCtorK8yBvMCtlbr9wfohVeJGkuUVLtAuA9TTJliGEN8Z
	ZwPsd6EdBc302g0GdUfeEPxhuK/pZrI=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id b73c4cbe (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 28 May 2024 13:29:12 +0000 (UTC)
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-62a0894f1d3so27116817b3.1;
        Tue, 28 May 2024 06:29:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWFl3woW2c7Ih1TEJCC9c4F1uDRz66L2L17KvgrHYjOXLwL67rqXs2OzINYXlUyfbn17BXS8bHlGpCwotiKW7CX7alZ3x+oL46WZR2Vu8j5gpmfhVRZZFn9VrkZcUFfP4DXnljhJjCY
X-Gm-Message-State: AOJu0YzhGnp9/shXDKknJ6kabHpl71svZCyvV3K6SNLkdSQFg8hxfV1B
	br6VIQuXUy1k9+vcPpWCFBm1cCo+A9H/fj1ZFXGzmbFOrFc+SiKMZo39yg4NkX5fJ/NhTu+iKDR
	gji0DWOO1/imZzD+gdlG+lIUD/XU=
X-Google-Smtp-Source: AGHT+IHs6YBGoJ22NizKEKgOAKHK5/PNDLyO/dJ25AG6/sBkCYeWtGE+E0FHaHhy2teOdk1tDqQwANej6Z1AgU51ejE=
X-Received: by 2002:a05:690c:6e07:b0:622:f7df:aa0a with SMTP id
 00721157ae682-6283496bccemr108435947b3.22.1716902950948; Tue, 28 May 2024
 06:29:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240528122352.2485958-1-Jason@zx2c4.com> <20240528122352.2485958-4-Jason@zx2c4.com>
 <CAMuHMdVJ8KpaqnWeHCMbJdf-Am6uY0N+uFM+OVxWTZH37TQvxw@mail.gmail.com> <ZlXX0cFl5RANHNOQ@zx2c4.com>
In-Reply-To: <ZlXX0cFl5RANHNOQ@zx2c4.com>
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Date: Tue, 28 May 2024 15:28:58 +0200
X-Gmail-Original-Message-ID: <CAHmME9qZ2Xm68HQqfOmasWRoaW4xfAFAiLfw-pFbhq2i0rHz=w@mail.gmail.com>
Message-ID: <CAHmME9qZ2Xm68HQqfOmasWRoaW4xfAFAiLfw-pFbhq2i0rHz=w@mail.gmail.com>
Subject: Re: [PATCH v16 3/5] arch: allocate vgetrandom_alloc() syscall number
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org, patches@lists.linux.dev, tglx@linutronix.de, 
	linux-crypto@vger.kernel.org, linux-api@vger.kernel.org, x86@kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>, "Carlos O'Donell" <carlos@redhat.com>, 
	Florian Weimer <fweimer@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>, 
	Christian Brauner <brauner@kernel.org>, David Hildenbrand <dhildenb@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 28, 2024 at 3:10=E2=80=AFPM Jason A. Donenfeld <Jason@zx2c4.com=
> wrote:
>
> On Tue, May 28, 2024 at 03:08:00PM +0200, Geert Uytterhoeven wrote:
> > Hi Jason,
> >
> > On Tue, May 28, 2024 at 2:24=E2=80=AFPM Jason A. Donenfeld <Jason@zx2c4=
.com> wrote:
> > > Add vgetrandom_alloc() as syscall 462 (or 572 on alpha) by adding it =
to
> > > all of the various syscall.tbl and unistd.h files.
> > >
> > > Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
> > > Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> >
> > As of commit ff388fe5c481d39c ("mseal: wire up mseal syscall") in
> > v6.10-rc1, 462 is already taken.
> >
> > v17 ++ ;-)
>
> Oy! Thanks. I should have thought to rebase on rc1 anyway before posting
> this.

Sorted in https://git.kernel.org/pub/scm/linux/kernel/git/crng/random.git/l=
og/?h=3Dvdso
for the time being.


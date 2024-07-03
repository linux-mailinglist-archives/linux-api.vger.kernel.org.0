Return-Path: <linux-api+bounces-1834-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BEDE29268CC
	for <lists+linux-api@lfdr.de>; Wed,  3 Jul 2024 21:04:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24E89B24C5B
	for <lists+linux-api@lfdr.de>; Wed,  3 Jul 2024 19:04:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC6031862A8;
	Wed,  3 Jul 2024 19:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="jkxC1dbc"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD95F178367;
	Wed,  3 Jul 2024 19:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720033486; cv=none; b=APRS/9AOikMnTF5L8p/DZ9RBPu7C0MlFeHQMFCjlg2X9YNKINBKIkI07NqBR0pb1T36Zgdis4gcwBfgTXSdOvTxkRj7cElHi8F9//VJxQeW0bFxOnPbF0c/HsuK1jlcMHFm6JF7nNdynux/B0alq/+RQ18EvEmH1a1nUiq3cZGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720033486; c=relaxed/simple;
	bh=Oc81FuqP3fYxQZO2NIeym9OJaFkN9S77RiMCzQDI9Yw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ffb85zmI+BWAU1guRNGkk2q5vSQZYUF8ALtl0ea7HcJgLJc7Fsx28/HUEhhEssybwx4N5iVEte+Ncllb0nZQaOhA9Gtpbtc64ElxCtJOXAoCWxBkSwawRy6PuAi4JXiimRNv6FEsg3+lgH/BP/DMk6XO8J7UECnLG1b+6XEoS/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=jkxC1dbc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A08C8C4AF07;
	Wed,  3 Jul 2024 19:04:45 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="jkxC1dbc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1720033483;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Oc81FuqP3fYxQZO2NIeym9OJaFkN9S77RiMCzQDI9Yw=;
	b=jkxC1dbceZx7Be7QJL7a7Ic39wHGYwkBltLiS8mY+H1iZtPBT9TDTthP2QeMMSw9n3UhZu
	ayr2cBoMf01X1+Uudntkvb8Bup8CzkZYMoIzQHr1tw3p2t5H7pSU3x8O9e5e+2pdsfOywC
	GRP6njc2YYiqHQ8+J+a6V9ddjs5ivcY=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id e9f2ad1b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 3 Jul 2024 19:04:43 +0000 (UTC)
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5c46c8b0defso999751eaf.1;
        Wed, 03 Jul 2024 12:04:42 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWNs+ymo17PqtjizDZU9F25M6bnOOGhzawprrVJBN5LHej/HgBOK25UHMKebg6bnMNlQTR/oR3JPye9lyAP6MQGIAXfz3upVqlZQhAd4Ap2ByQ6gAvy0UIZdhgQOwe5lh6Jg24kkjeS
X-Gm-Message-State: AOJu0YztoHExiL6NdjrEF51aEEiL6GnYFbjV4CtBBpzCo+5vE2RYyKre
	GN8uVJ2clpTnj5EEQX9x9ioaFeQc5cRM0CFK2nRU1ZrmeYjphPy5oLCYiwIcbo/Frj0FCkLdaPs
	p6ZzEHrOarpFJmKhnme91EMZ3q5k=
X-Google-Smtp-Source: AGHT+IF/1JsRrNHrx673Yy+3KzYSc//OID5zS/adculNKhtga+UJFUlkNMK+w1t4qZ56KmzV+zu/1jP+s2nmIVvVD0s=
X-Received: by 2002:a05:6870:6590:b0:25e:1976:37c0 with SMTP id
 586e51a60fabf-25e19763d7fmr1558743fac.6.1720033481764; Wed, 03 Jul 2024
 12:04:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240703183115.1075219-1-Jason@zx2c4.com> <20240703183115.1075219-4-Jason@zx2c4.com>
 <fa6eb1f8-b681-4c3f-bf5f-4ca19da78b17@app.fastmail.com>
In-Reply-To: <fa6eb1f8-b681-4c3f-bf5f-4ca19da78b17@app.fastmail.com>
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Date: Wed, 3 Jul 2024 21:04:30 +0200
X-Gmail-Original-Message-ID: <CAHmME9ouVcCt6C6XdvvKACbCBLV1DaAuv_NP8=fXFN1UMeUu_Q@mail.gmail.com>
Message-ID: <CAHmME9ouVcCt6C6XdvvKACbCBLV1DaAuv_NP8=fXFN1UMeUu_Q@mail.gmail.com>
Subject: Re: [PATCH v20 3/5] arch: allocate vgetrandom_alloc() syscall number
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, patches@lists.linux.dev, 
	Thomas Gleixner <tglx@linutronix.de>, linux-crypto@vger.kernel.org, 
	linux-api@vger.kernel.org, x86@kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>, "Carlos O'Donell" <carlos@redhat.com>, 
	Florian Weimer <fweimer@redhat.com>, Jann Horn <jannh@google.com>, 
	Christian Brauner <brauner@kernel.org>, David Hildenbrand <dhildenb@redhat.com>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>, 
	Jiri Olsa <jolsa@kernel.org>, Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Arnd,

On Wed, Jul 3, 2024 at 8:59=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Wed, Jul 3, 2024, at 20:31, Jason A. Donenfeld wrote:
> > Add vgetrandom_alloc() as syscall 463 (or 573 on alpha) by adding it to
> > all of the various syscall.tbl and unistd.h files.
> >
> > Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
> > Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
>
> I checked that the system calls are all hooked up correctly
> across all architectures:
>
> Acked-by: Arnd Bergmann <arnd@arndb.de>

Thanks.

> Unfortunately we now have three syscalls scheduled for
> the number 463, the other ones being uretprobe (only
> for arc, arm64, csky, hexagon, loongarch, nios2, openrisc,
> riscv and x86 for some reason) and setxattrat (on
> all architectures).
>
> It would be nice if you could all coordinate on this to
> pick unique numbers.

Stephen and I were just talking about this when looking at the linux-next m=
erge.

Dibs on 463! Just kidding.

There's going to be merge conflicts anyway, due to the __NR_syscalls
counter changing. So I figured this is something Linus typically just
handles based on what order he merges things in. But I actually don't
know. What's the best way to handle this?

Jason


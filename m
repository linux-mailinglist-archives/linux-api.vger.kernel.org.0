Return-Path: <linux-api+bounces-5274-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B1A6C5D7DB
	for <lists+linux-api@lfdr.de>; Fri, 14 Nov 2025 15:10:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 721B13BA562
	for <lists+linux-api@lfdr.de>; Fri, 14 Nov 2025 14:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22C5832145A;
	Fri, 14 Nov 2025 14:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="Lesn+N1+"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D34F2FB08F
	for <linux-api@vger.kernel.org>; Fri, 14 Nov 2025 14:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763129429; cv=none; b=QlucPGOvMXLk4BI9MYwh75aaBAj78gZUttww+ER+zanqCh6iDwMx/gN+W3wwe2SS71ZBf3eIA58fiYBH2yZva4YRONCIdhPMVph5zDhMddf8vUrd736cDz19tllM/4u3J0MwN5XfnKK3nK+B5/HO3CaS694YJACnMfKgvwHV+k0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763129429; c=relaxed/simple;
	bh=KE+QPebTvEqbnMKEXMooGer5jwtRyU8fzyKcLQ4mw/g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f9BkXM1pz3m+fPvkTR8I68ESHN210wXkjYFSLMmx4+ju6meusJiKzlTTxqn3rMJazMIs+vQtAKx2W1vlw54g6pmQcAfZekeufHiuBjWE7f7nGn42j6w7h3By5Dm9MchkpxNa8ZkCQI3Ilo8+pkNMWwqi9Yzz66832MIi65Axrb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=Lesn+N1+; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b736d883ac4so115403966b.2
        for <linux-api@vger.kernel.org>; Fri, 14 Nov 2025 06:10:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1763129424; x=1763734224; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wUyLyvVVKlFsH483G8ekZl8QKBp07gDZblbUWMC1jGk=;
        b=Lesn+N1+up0vOeI4VPrJ65CHM+HZS4l9BYFpy+ZAGPoMWIoEfa6AplEKNUMCfh3Y37
         WmFW/0RoPrO3YvGhKscMCFM2KozG+YG7ahcyjRq6gmfBazKAab0s1k+UwTubXS0Qqszm
         j42DCKbj75VSzhxFQGSY7KgO6sbnhjggb2eHqbgQ4oMQu4SrtK+qMRgqSWroQVYN6ulQ
         Vk2CqF6Z30kY9x+9KFwmhCo2yyDlV1+p/SmFy8PeQ7Je6AqaF2B/cJvPBsDK+46u25W4
         BpgwKUeZoUNilxvaR+miAbWjM4PVemAFtVhk31u1W4/aI6gw1890X4xbh9vyCYA6J+9V
         SEfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763129424; x=1763734224;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wUyLyvVVKlFsH483G8ekZl8QKBp07gDZblbUWMC1jGk=;
        b=NeWj+twhgVdlXOpwx/RpYJwRUMKXoCuVnLjbmRDtyRTawxK+6VZJd5U+OEgo+oXpZb
         R23ROPzQDALo/51nDKnAaPfXlrbsDemUq4sc4m6rw4yIpxazpaWNJ87oRPdcYSW6vyv3
         s/GDIJerTYjkl3M2vgjKnBh3HFu962+z7fuwpw6babSet4AmxHnshwbrAp8EJr3gyFdG
         8YbK4g2pEqejA7Kkcp6OSHBl81DYCdMoH4H9om2Mh9BkuQOJ5DwyNTB9IAv1dZ028xJ9
         X7kA6/CYym4Jm8iIDujTrkTAJKlTYHkD0vSgYU7bHNNQUE73Mnj2kQk6wDNy61eRMdxP
         qWmQ==
X-Forwarded-Encrypted: i=1; AJvYcCUfxHswR8bPbyOeDkz/afOrEkI/Fe2TyFSBk8wpCauVqNIKprHti5O1PRThhRL0BBTUtn5cxtblVYs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrXNQPmoJmX2PD+RB3cBxNYCLZyqQS4qr1WcuqGvWnNc/ZZgto
	66Sh8yN1ehvcQfTj/TslAX6yLcc8VfGN2y9yE4gEHKhqpZdbA3qH6BUfNu8uTM4DTtug8mV7r/O
	XiId2uRgdhg1HrJILcPSCfQP0U/9q1OlRzYE5spzu9A==
X-Gm-Gg: ASbGncs9+HlLLNTqsfsIUwpPEO8bnB3l+DFIFaVhAZ85MDl0+blXKYVS5BECoVWCgci
	LEIv/kFKTONot6C/9+MxJLMT/ab7UIBDVLAkxDByR3/ZpnfUC3lMKJJzUg0xAjLaBo32cWhvwOU
	cap3tRby2dU4rxshbXr7BM+PrybGlQKjTsuAfkhEDDPr9B0Dmm0NmSJ9cRATay8l/B85nVmHAus
	hfTRPRCK/FHOkMwX3pLMboCecqb4E/gVAm01uP05pd4F2fjSnCsD1spJiRxFNGg0oME
X-Google-Smtp-Source: AGHT+IHfDqjVq2HQlgOvTYSXDolFUyeHkC2njHwkXXlWNiYY2vI3dgM9DBu5caW7N/gKzWP7vOw7EXXGJJQDhW4sn3w=
X-Received: by 2002:a17:906:6601:b0:b73:6998:7bcd with SMTP id
 a640c23a62f3a-b7369987d82mr195682366b.23.1763129424454; Fri, 14 Nov 2025
 06:10:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251107210526.257742-1-pasha.tatashin@soleen.com>
 <20251107210526.257742-8-pasha.tatashin@soleen.com> <aRcnRFnqhm3jkqd3@kernel.org>
In-Reply-To: <aRcnRFnqhm3jkqd3@kernel.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Fri, 14 Nov 2025 09:09:48 -0500
X-Gm-Features: AWmQ_bkHcsPKYBwcaJBkDElGfbsE2VmqDOwwNe9Hzx_22lS14GpcHvhkYld0Zm8
Message-ID: <CA+CK2bCO=Hu0a4P5-_a4QrOSdKLR7OXEk=Nsz-p6TvjEHV9rwQ@mail.gmail.com>
Subject: Re: [PATCH v5 07/22] liveupdate: luo_ioctl: add user interface
To: Mike Rapoport <rppt@kernel.org>
Cc: pratyush@kernel.org, jasonmiu@google.com, graf@amazon.com, 
	dmatlack@google.com, rientjes@google.com, corbet@lwn.net, 
	rdunlap@infradead.org, ilpo.jarvinen@linux.intel.com, kanie@linux.alibaba.com, 
	ojeda@kernel.org, aliceryhl@google.com, masahiroy@kernel.org, 
	akpm@linux-foundation.org, tj@kernel.org, yoann.congal@smile.fr, 
	mmaurer@google.com, roman.gushchin@linux.dev, chenridong@huawei.com, 
	axboe@kernel.dk, mark.rutland@arm.com, jannh@google.com, 
	vincent.guittot@linaro.org, hannes@cmpxchg.org, dan.j.williams@intel.com, 
	david@redhat.com, joel.granados@kernel.org, rostedt@goodmis.org, 
	anna.schumaker@oracle.com, song@kernel.org, zhangguopeng@kylinos.cn, 
	linux@weissschuh.net, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-mm@kvack.org, gregkh@linuxfoundation.org, tglx@linutronix.de, 
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, 
	hpa@zytor.com, rafael@kernel.org, dakr@kernel.org, 
	bartosz.golaszewski@linaro.org, cw00.choi@samsung.com, 
	myungjoo.ham@samsung.com, yesanishhere@gmail.com, Jonathan.Cameron@huawei.com, 
	quic_zijuhu@quicinc.com, aleksander.lobakin@intel.com, ira.weiny@intel.com, 
	andriy.shevchenko@linux.intel.com, leon@kernel.org, lukas@wunner.de, 
	bhelgaas@google.com, wagi@kernel.org, djeffery@redhat.com, 
	stuart.w.hayes@gmail.com, ptyadav@amazon.de, lennart@poettering.net, 
	brauner@kernel.org, linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	saeedm@nvidia.com, ajayachandra@nvidia.com, jgg@nvidia.com, parav@nvidia.com, 
	leonro@nvidia.com, witu@nvidia.com, hughd@google.com, skhawaja@google.com, 
	chrisl@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 14, 2025 at 7:58=E2=80=AFAM Mike Rapoport <rppt@kernel.org> wro=
te:
>
> On Fri, Nov 07, 2025 at 04:03:05PM -0500, Pasha Tatashin wrote:
> > Introduce the user-space interface for the Live Update Orchestrator
> > via ioctl commands, enabling external control over the live update
> > process and management of preserved resources.
> >
> > The idea is that there is going to be a single userspace agent driving
> > the live update, therefore, only a single process can ever hold this
> > device opened at a time.
> >
> > The following ioctl commands are introduced:
> >
> > LIVEUPDATE_IOCTL_CREATE_SESSION
> > Provides a way for userspace to create a named session for grouping fil=
e
> > descriptors that need to be preserved. It returns a new file descriptor
> > representing the session.
> >
> > LIVEUPDATE_IOCTL_RETRIEVE_SESSION
> > Allows the userspace agent in the new kernel to reclaim a preserved
> > session by its name, receiving a new file descriptor to manage the
> > restored resources.
> >
> > Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> > ---
> >  include/uapi/linux/liveupdate.h  |  64 ++++++++++++
> >  kernel/liveupdate/luo_internal.h |  21 ++++
> >  kernel/liveupdate/luo_ioctl.c    | 173 +++++++++++++++++++++++++++++++
> >  3 files changed, 258 insertions(+)
>
> ...
>
> > +static int luo_ioctl_create_session(struct luo_ucmd *ucmd)
> > +{
> > +     struct liveupdate_ioctl_create_session *argp =3D ucmd->cmd;
> > +     struct file *file;
> > +     int ret;
> > +
> > +     argp->fd =3D get_unused_fd_flags(O_CLOEXEC);
> > +     if (argp->fd < 0)
> > +             return argp->fd;
> > +
> > +     ret =3D luo_session_create(argp->name, &file);
> > +     if (ret)
>
>                 put_unused_fd(fd) ?

Yes, thank you.

>
> > +             return ret;
> > +
> > +     ret =3D luo_ucmd_respond(ucmd, sizeof(*argp));
> > +     if (ret) {
> > +             fput(file);
> > +             put_unused_fd(argp->fd);
> > +             return ret;
> > +     }
>
> I think that using gotos for error handling is more appropriate here.

Sure, I will do that

>
> > +
> > +     fd_install(argp->fd, file);
> > +
> > +     return 0;
> > +}
> > +
> > +static int luo_ioctl_retrieve_session(struct luo_ucmd *ucmd)
> > +{
> > +     struct liveupdate_ioctl_retrieve_session *argp =3D ucmd->cmd;
> > +     struct file *file;
> > +     int ret;
> > +
> > +     argp->fd =3D get_unused_fd_flags(O_CLOEXEC);
> > +     if (argp->fd < 0)
> > +             return argp->fd;
> > +
> > +     ret =3D luo_session_retrieve(argp->name, &file);
> > +     if (ret < 0) {
> > +             put_unused_fd(argp->fd);
> > +
> > +             return ret;
> > +     }
> > +
> > +     ret =3D luo_ucmd_respond(ucmd, sizeof(*argp));
> > +     if (ret) {
> > +             fput(file);
> > +             put_unused_fd(argp->fd);
> > +             return ret;
> > +     }
>
> and here.

Sure

>
> > +
> > +     fd_install(argp->fd, file);
> > +
> > +     return 0;
> > +}
> > +
>
> --
> Sincerely yours,
> Mike.


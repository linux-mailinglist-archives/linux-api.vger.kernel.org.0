Return-Path: <linux-api+bounces-5400-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1993AC76273
	for <lists+linux-api@lfdr.de>; Thu, 20 Nov 2025 21:14:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 03CBC4E1D72
	for <lists+linux-api@lfdr.de>; Thu, 20 Nov 2025 20:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98CA23242D6;
	Thu, 20 Nov 2025 20:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="N6C4dx8h"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F56B3074B2
	for <linux-api@vger.kernel.org>; Thu, 20 Nov 2025 20:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763669668; cv=none; b=Pgav+CPGrxCswH7AntPMthUcb1BCtPcum5eGcnATVhHiekZlg6/iMes8C1XtKQ3SJU+tIgDDaLGHYzdrvmrAmQ1mjJZwshRxED6EaBPLLYpalmdqgyd3MmOQqizvdQTJyVbhqqcyS74m2vxSmtXCAkJ3pXhlieEHYqwpTyux14Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763669668; c=relaxed/simple;
	bh=gzkusrkUUVCrue7G+l4PyU3h6kKfsf3FE/H2MZ82Mvo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rwQ5zY4s3lPM3TTdlYdS6ch/l5+u6wv0riGJWVOgldoilp3JqB4NVVKtEt9Ex3tJ1bl/qMqpsKxuDPmWkXTm7gnPJ6QQ/FIzlYS4kGxnt5d8QHPS7yTAJE3eg0Qf46N9Re+P6JJy5jRNygQC9lgrWii0kukV7yOd74TIP12douo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=N6C4dx8h; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-63c489f1e6cso1374634a12.1
        for <linux-api@vger.kernel.org>; Thu, 20 Nov 2025 12:14:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1763669665; x=1764274465; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+omO3PV5a0YpXXLvwNkeXHR5K1gWkBI2kB4nQSAWDK8=;
        b=N6C4dx8hAGLTzPGFR0LcXliWZ3VC++SW1YYairp8nnR/ahbdxre1RafMy6Kkdgc0cY
         VQy1jf3Hw8VaLRoZbjnv96/iBzoxf7qVeVFGMmXX0BBRjkV4rx94LE4K9OToEp0bFdnA
         WbqNQeCtqzFxO7W7wrqrp4pRsJbUvUPS919G5X+MA3cdClPTz2tXW7+8Rvj9iIPsaZOu
         tkTr52sHuNQHwPhTM2DeSYzDN4tZvi1D2jWmgHfDijqtDouaCVfLF5Digxletz7VC4wl
         JM6bxnamL/U8jVHCn/pbvjIc47CgQ22akDIkfXnYXy2lyuXFo+cPp8xcyrHwLTZiOKPV
         2r4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763669665; x=1764274465;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+omO3PV5a0YpXXLvwNkeXHR5K1gWkBI2kB4nQSAWDK8=;
        b=lSFmjxiL4f/g+JUkQtUq9Pw1MeEuO5Au6dy0QcXizkn8BIcHhdYdxyFe/4ACzaAgwg
         VMpJ4YcNu9ZbJoMZQZQ8MSuyoQ40e6zTEgRFqP1h+ALGJUAFLCIQwYzQc0B+jgt3RT4z
         6GXm38pzx9NKNeZjUIJPNkgneRtodSnTPCawxDCG1SRAJ6e6HRjJkgr3vJk7XaM7GKTe
         S2gkikvIqL8oVICJUBvVvGAJy6Qc5+QtyJ3PdbcNyYi7lksMKBc9ODu1YlMmx8X+FsNw
         kbn/EwqGTnRYG7HemV3aw95Z8vgyiCTNW5CYv2nlxHFoEZkqIX7Vb7Lv9EL8J1Ebr1uG
         4dHQ==
X-Forwarded-Encrypted: i=1; AJvYcCW5f1rFejp+3HpUDC5T0qCWUNVK7ypGzY83UrBU+6j4rHPCXwEluV6aBakqNyIR0CXVAxFo9Jzgj9c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyonkFDjMnAraC0jRkRkZGBSVmzrg75AWDxT7A4DLFh0rWEtfrL
	V3qRzeNTAAvopSageDLIhNCKqr898km2WmtQxmEaKx+ndZ2QniyXBKQmY4z9OP/1nkq9CeXvRl5
	vBJPbOCZF+h2q9N7q+TRDZm+zEprKGolHZ/5JnAIDlA==
X-Gm-Gg: ASbGncuIoN6p7KdrIPlLplcOqi1yc4vrwNUqh4/Y0gAbla9ucxr+djKCn9JHkG/TItm
	WigFpOW4Mg28SZh35J0UbsTfdRMgHDGWUfn1Hz3BXhzSscFtd8AIwGumpO9huIhXFU5IP1g28ui
	fnCEkqLALnES1jzt45OwCZQBXM5GxVEtcz2QJRiLambZj0Ah20D5iXvBV/zPozjU9dz3f050z5h
	mazOUUZmE6Kho0Ea6SKXG2ynVP7SWixou3nDtO1zVKCmw4W65cVelxI9GCTC7BilqQCUWqlUcgG
	BKg=
X-Google-Smtp-Source: AGHT+IETa8hWOUfKCvI3S7y7dFesOn/0oRFaIqYivthoGyP3sfDzcaEBdtnkETAlUGKTRLP1/+X3Uvd7Kky/elnwLAk=
X-Received: by 2002:a05:6402:3509:b0:63b:ee76:3f63 with SMTP id
 4fb4d7f45d1cf-64539667b0amr3359932a12.7.1763669664757; Thu, 20 Nov 2025
 12:14:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251115233409.768044-1-pasha.tatashin@soleen.com>
 <20251115233409.768044-6-pasha.tatashin@soleen.com> <CALzav=c-KJg8q8-4EaDC1M+GErTCiRKtn5qRbh1wa08zJ0N4ng@mail.gmail.com>
 <CA+CK2bD4Y3CMHcTGKradmv-hAbdtA7zsw2CYeh7-8LNianYMZw@mail.gmail.com> <CALzav=dmFQr+BrqzRDgio0q68MPRVnZPK4-wUXVj47o1FObgNg@mail.gmail.com>
In-Reply-To: <CALzav=dmFQr+BrqzRDgio0q68MPRVnZPK4-wUXVj47o1FObgNg@mail.gmail.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Thu, 20 Nov 2025 15:13:47 -0500
X-Gm-Features: AWmQ_bkiZMs_ib46GqJJAyFDjxnjrkzfc-NJQCiTAHteg5hCk1-ag1G4ow0v2YA
Message-ID: <CA+CK2bAXaMdp7rw8RVWNpfunu-XW59RjmdhwmEwZtCZohrdrGA@mail.gmail.com>
Subject: Re: [PATCH v6 05/20] liveupdate: luo_ioctl: add user interface
To: David Matlack <dmatlack@google.com>
Cc: pratyush@kernel.org, jasonmiu@google.com, graf@amazon.com, rppt@kernel.org, 
	rientjes@google.com, corbet@lwn.net, rdunlap@infradead.org, 
	ilpo.jarvinen@linux.intel.com, kanie@linux.alibaba.com, ojeda@kernel.org, 
	aliceryhl@google.com, masahiroy@kernel.org, akpm@linux-foundation.org, 
	tj@kernel.org, yoann.congal@smile.fr, mmaurer@google.com, 
	roman.gushchin@linux.dev, chenridong@huawei.com, axboe@kernel.dk, 
	mark.rutland@arm.com, jannh@google.com, vincent.guittot@linaro.org, 
	hannes@cmpxchg.org, dan.j.williams@intel.com, david@redhat.com, 
	joel.granados@kernel.org, rostedt@goodmis.org, anna.schumaker@oracle.com, 
	song@kernel.org, linux@weissschuh.net, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-mm@kvack.org, gregkh@linuxfoundation.org, 
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, rafael@kernel.org, 
	dakr@kernel.org, bartosz.golaszewski@linaro.org, cw00.choi@samsung.com, 
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

On Thu, Nov 20, 2025 at 2:43=E2=80=AFPM David Matlack <dmatlack@google.com>=
 wrote:
>
> On Thu, Nov 20, 2025 at 11:23=E2=80=AFAM Pasha Tatashin
> <pasha.tatashin@soleen.com> wrote:
> >
> > On Thu, Nov 20, 2025 at 1:38=E2=80=AFPM David Matlack <dmatlack@google.=
com> wrote:
> > >
> > > On Sat, Nov 15, 2025 at 3:34=E2=80=AFPM Pasha Tatashin
> > > <pasha.tatashin@soleen.com> wrote:
> > > > The idea is that there is going to be a single userspace agent driv=
ing
> > > > the live update, therefore, only a single process can ever hold thi=
s
> > > > device opened at a time.
> > > ...
> > > > +static int luo_open(struct inode *inodep, struct file *filep)
> > > > +{
> > > > +       struct luo_device_state *ldev =3D container_of(filep->priva=
te_data,
> > > > +                                                    struct luo_dev=
ice_state,
> > > > +                                                    miscdev);
> > > > +
> > > > +       if (atomic_cmpxchg(&ldev->in_use, 0, 1))
> > > > +               return -EBUSY;
> > >
> > > Can you remind me why the kernel needs to enforce this? What would be
> > > wrong or unsafe from the kernel perspective if there were multiple
> > > userspace agents holding open files for /dev/liveupdate, each with
> > > their own sessions?
> >
> > By enforcing a singleton, we will ensure a consistent view for tooling
> > like luoadm (which will track incoming/outgoing sessions, UUIDs, etc.)
> > and prevent conflicting commands regarding the transition state.
> >
> > This is not a bottleneck because the vast majority of the work
> > (preserving devicse/memory) is handled via the individual Session FDs.
> > Also, since sessions persist even if /dev/liveupdate is closed, we
> > allow the agent upgrade, or crashing without requiring concurrent
> > access.
>
> Yeah, I'm not concerned about bottlenecking. It just seems like an
> artificial constraint to impose on userspace at this point. The only
> ioctls on /dev/liveupdate are to create a session and retreive a
> session. Neither of those will conflict with having multiple open
> files for /dev/liveupdate.

Enforcing tooling consistency, and improving security for global
state. Otherwise, it can be relaxed.

Pasha


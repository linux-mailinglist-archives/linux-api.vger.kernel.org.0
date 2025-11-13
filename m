Return-Path: <linux-api+bounces-5266-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id A199BC59849
	for <lists+linux-api@lfdr.de>; Thu, 13 Nov 2025 19:39:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EBB90341ACB
	for <lists+linux-api@lfdr.de>; Thu, 13 Nov 2025 18:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 632743126AB;
	Thu, 13 Nov 2025 18:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="LmR/r5P9"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BAE13126D8
	for <linux-api@vger.kernel.org>; Thu, 13 Nov 2025 18:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763059122; cv=none; b=JMOdY5AxTZdsxy2ljhzuNIa2fmPPLk72tV1InppGUlsi3Ke1Rz8wXqvGII6z0l6YfJwc/dG8OROA4QRqUGaFne2Y+CicQAy9iQGxmhL42K+Td/GAg+Cb0uBPP5GmmsQevX9j61bDVnffTogCAcZYSaZwZZLSdn7w/YB7wSuM7VY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763059122; c=relaxed/simple;
	bh=Cv/QbwolssPfl2k/AIydYpdcMQzVyb3+RLFiXzqCKjI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P4uhaFdOP+9W/fHblkNBeHC0/QAK6DTadp4lbHwQ9K2CDsbn5cAHZqRD64+5ONMh92s08YrsHtxkX7ImND02JI3ofxr5VUDBjSx3zr63vkjzCuudHQvRvPzs28QRREEZMQon2njGAvYC9BPZwhp/dUB0r8Jbj18mJnFRXzDi5rY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=LmR/r5P9; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-64088c6b309so2000891a12.0
        for <linux-api@vger.kernel.org>; Thu, 13 Nov 2025 10:38:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1763059118; x=1763663918; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5QzIZolLw0TWeicvPUi5XAG3YGoC32FLVnv2N+ZATiw=;
        b=LmR/r5P9nSv0fnAvDZE6SNaqXVbp8Ckb0bd82wvAwKZ7cMo0vtgk7RUYeOpQi5MJ4N
         1igvmfh0EgPGx2/lukRolXS0FXDrwLW6cK1fASpWHTu6bbRjAE2ffo1/tAm40XqZiDqr
         ES3IOmiz6sRq1a3MmSgGtKmOzB/aLd+AOmjN+IYsRwlN1XzPP4YF2xMf9aROQuVfJjld
         PVDYOhH+WDleBXykhoFUgkXUor5ojw7QQ1pRDHt5iP73U+1t8DOoO+DzFqJxgnARCLqE
         4U1zAz03FC2q0kHp8C8I269NlzUy3hnIxFlgLmN+V0jcYDWmeTiaiWbMSszPs5R6A96j
         ghkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763059118; x=1763663918;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5QzIZolLw0TWeicvPUi5XAG3YGoC32FLVnv2N+ZATiw=;
        b=XpYauSrfCCGy+IbDRoA3oQFxpkdQqUQZCAbmiUOC3DiVpnPT+98PF67/6gsLKQVna2
         ISUQaQ4AkV5Aug07QYIsprsbNbMgg5+YbDLBCvZVntvdYOC+lbfVsFBuFqwqR6i8wFNW
         gCpSja/FIjToYumN/CLZcqDlz5GR+UuW0MA1jA+/9aRbPfBC1qf2o06C/+ynJ/dWW30W
         NqhP4wGg3G11XPlm5Qlu+6tX4osB19D9GDQ8XUl1l5HDAws8/CuZX3UBZ6y9khDyhrIV
         kQjcgMiJZmcSeCIhu/McWkU5hI2RFzPuQ5BgVw+oyrGnfn/nL3wDbOPFF8sFO75jBM26
         OMqA==
X-Forwarded-Encrypted: i=1; AJvYcCWpiF2FTkRIZJ/eMjTfuOxmsoZGFyPQguNSmvsqgMqMnpsm0VPB3MbqYRApDRxcrUOAW0+57OmH5ew=@vger.kernel.org
X-Gm-Message-State: AOJu0YywNYYJLIjOmYILH+OfHQJSnxMOp0knGx4bZ/70h6dnFpDnwqLr
	fhhEkOD30gEv1piLw+FTKeB1aDrMF9hUolK7i2fQSaMoNUXQ5AiqjCIt5mpE1Gr0yTgtoO1Rx32
	grtH+uz4mwW1WGlhOlBbrWo9xnROyUNjcLYMVqoyyRA==
X-Gm-Gg: ASbGncvaWgYxX0+GASxZU0+CKi/U+05opJ+3yxJERQrOWF/nORdzinMzxU5MkL009u0
	y6a5JkFjG68qb7QQ1NQR7XCoA1Y3gsN9HKiyBy9rWh0ZQTRiSayOmwX5s9CuXPD/CeOszbmF/iH
	51QZlJVXpVEYtzWvW68KzaBncGVILqjMqPj8NX091jwDkr8mKzcqwld2HHTKV/XTSrycDfnvfl7
	qjyljwlaGVGyx+4pe0KoFLeIOj3b18qIdquzTQ6b4Ljdy+ACLAJe8nQ0w==
X-Google-Smtp-Source: AGHT+IEDdgrLTNweUjb0jeGLJZI3hwXTN5B+vwJRTiRZj6uuz96RHszyffXikSiDLB6+TEf6KwvdNmtJbHmHq1QzP+8=
X-Received: by 2002:a05:6402:3056:10b0:640:b1cf:f7f7 with SMTP id
 4fb4d7f45d1cf-64350ebf795mr201526a12.35.1763059118370; Thu, 13 Nov 2025
 10:38:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251107210526.257742-1-pasha.tatashin@soleen.com>
 <20251107210526.257742-3-pasha.tatashin@soleen.com> <aRHiCxoJnEGmj17q@kernel.org>
 <CA+CK2bCHhbBtSJCx38gxjfR6DM1PjcfsOTD-Pqzqyez1_hXJ7Q@mail.gmail.com>
 <aROZi043lxtegqWE@kernel.org> <CA+CK2bAsrEqpt9d3s0KXpjcO9WPTJjymdwtiiyWVS6uq5KKNgA@mail.gmail.com>
 <aRSKrxfAb_GG_2Mw@kernel.org> <CA+CK2bAq-0Vz4jSRWnb_ut9AqG3RcH67JQj76GhoH0BaspWs2A@mail.gmail.com>
 <aRYH_Ugp1IiUQdlM@kernel.org>
In-Reply-To: <aRYH_Ugp1IiUQdlM@kernel.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Thu, 13 Nov 2025 13:38:01 -0500
X-Gm-Features: AWmQ_bneOtiUV_-OT7VkHtp8xKlM72B3fH-AsO6J1uV7zz_LDIJjB88yI7q7RiE
Message-ID: <CA+CK2bC_m=pUHt1uOoW9UMssDATqabHKHRyq7QNbzrb9Vm13Cw@mail.gmail.com>
Subject: Re: [PATCH v5 02/22] liveupdate: luo_core: integrate with KHO
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

On Thu, Nov 13, 2025 at 11:32=E2=80=AFAM Mike Rapoport <rppt@kernel.org> wr=
ote:
>
> On Wed, Nov 12, 2025 at 09:58:27AM -0500, Pasha Tatashin wrote:
> > On Wed, Nov 12, 2025 at 8:25=E2=80=AFAM Mike Rapoport <rppt@kernel.org>=
 wrote:
> > >
> > > Hi Pasha,
> > >
> > > On Tue, Nov 11, 2025 at 03:57:39PM -0500, Pasha Tatashin wrote:
> > > > Hi Mike,
> > > >
> > > > Thank you for review, my comments below:
> > > >
> > > > > > This is why this call is placed first in reboot(), before any
> > > > > > irreversible reboot notifiers or shutdown callbacks are perform=
ed. If
> > > > > > an allocation problem occurs in KHO, the error is simply report=
ed back
> > > > > > to userspace, and the live update update is safely aborted.
> > >
> > > The call to liveupdate_reboot() is just before kernel_kexec(). Why we=
 don't
> > > move it there?
> >
> > Yes, I can move that call into kernel_kexec().
> >
> > > And all the liveupdate_reboot() does if kho_finalize() fails it's mas=
saging
> > > the error value before returning it to userspace. Why kernel_kexec() =
can't
> > > do the same?
> >
> > We could do that. It would look something like this:
> >
> > if (liveupdate_enabled())
> >    kho_finalize();
> >
> > Because we want to do kho_finalize() from kernel_kexec only when we do
> > live update.
> >
> > > > > This is fine. But what I don't like is that we can't use kho with=
out
> > > > > liveupdate. We are making debugfs optional, we have a way to call
> >
> > This is exactly the fix I proposed:
> >
> > 1. When live-update is enabled, always disable "finalize" debugfs API.
> > 2. When live-update is disabled, always enable "finalize" debugfs API.
>
> I don't mind the concept, what I do mind is sprinkling liveupdate_enabled=
()
> in KHO.

Sure, let's just unconditionally do kho_fill_kimage().

> How about we kill debugfs/kho/out/abort and make kho_finalize() overwrite
> an existing FDT if there was any?
>
> Abort was required to allow rollback for subsystems that had kho notifier=
s,
> but now notifiers are gone and kho_abort() only frees the memory
> serialization data. I don't see an issue with kho_finalize() from debugfs
> being a tad slower because of a call to kho_abort() and the liveupdate pa=
th
> anyway won't incur that penalty.

Sounds good to me.

> > > KHO should not call into liveupdate. That's layering violation.
> > > And "stateless KHO" does not really make it stateless, it only remove=
s the
> > > memory serialization from kho_finalize(), but it's still required to =
pack
> > > the FDT.
> >
> > This touches on a point I've raised in the KHO sync meetings: to be
> > effective, the "stateless KHO" work must also make subtree add/remove
> > stateless. There should not be a separate "finalize" state just to
> > finish the FDT. The KHO FDT is tiny (only one page), and there are
> > only a handful of subtrees. Adding and removing subtrees is cheap; we
> > should be able to open FDT, modify it, and finish FDT on every
> > operation. There's no need for a special finalization state at kexec
> > time. KHO should be totally stateless.
>
> And as the first step we can drop 'if (!kho_out.finalized)' from
> kho_fill_kimage(). We might need to massage the check for valid FDT in
> kho_populate() to avoid unnecessary noise, but largely there's no issue
> with always passing KHO data in kimage.

Sounds good, let me work on this patch.

Pasha


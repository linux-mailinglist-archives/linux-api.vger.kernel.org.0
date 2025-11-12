Return-Path: <linux-api+bounces-5240-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D675C524F2
	for <lists+linux-api@lfdr.de>; Wed, 12 Nov 2025 13:47:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id F29AB341C01
	for <lists+linux-api@lfdr.de>; Wed, 12 Nov 2025 12:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92153335575;
	Wed, 12 Nov 2025 12:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="jUvqWmJa"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82361335563
	for <linux-api@vger.kernel.org>; Wed, 12 Nov 2025 12:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762951624; cv=none; b=XJtK9fvpHEgNabGwVFLIZ24AcFG5mOXdYgpqpcu+Haqv27lj3CRyaiEM1PE5qvqfiSe3GyXcdkvoc5UPjnVs/al2aZO6UAHCz4Tp/0nqSAIth/Wv2tP0VKbKtAXB3WTipc9WppFn0uBD9pnUuKK4Tkn7XyfLNyJlB4PYCYA+m7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762951624; c=relaxed/simple;
	bh=znZuQwa1aOziNsVVDXXpqJjJ+lN7ig6byCFqqLdTusA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rt0MbsVXmszA9j4eAm5rW5Iuwkc6dw/SxaXqVf5O715j0cW7BBXpGD45w8ePdMhoEvPsYj0orQXkPgCvzg9WIlIXpC8ZjM1XmrRnD6A7mtJk4GrCj5QZw+Iqmpdq+j8hteyAdGls2CsD/2l90134wPD+UXIyq+OqashtwZ5CiOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=jUvqWmJa; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-64088c6b309so1235685a12.0
        for <linux-api@vger.kernel.org>; Wed, 12 Nov 2025 04:47:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1762951621; x=1763556421; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NlYd6Xq+AnhKekfFM+8+8cT83BwyMkqy6p8G3DXg5+E=;
        b=jUvqWmJaXXN0cLEFVgCu1IoCmnJo4k8vi984y/p5n95rUUkqfnAAuIfq7cVevvIql+
         /XzUQpvtZujaqXLy9a7qyr9HqBncxaSBiP9TMtKSmtsRZvg4VyAytzD1QqrmvEnwzaqa
         0/hGsRWJ7fWOtg97EaV3/FG3Lf7PwYnhAPEhJiOry93QV7b1929GxqqRFtdmDHL4VbkU
         83pQT9I/AKnQ9BEvYiHaKl5lncv6/47ge4iv6d/KUsYfMbNm62XodQPUPPq/Nkdo11b7
         8n4HyHw7fRDxG8XpgnzpOHwtj75vn2lgHDvzrdARfG+mJZ6UYldPnwuV2U7D7v41ZNRz
         cRlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762951621; x=1763556421;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NlYd6Xq+AnhKekfFM+8+8cT83BwyMkqy6p8G3DXg5+E=;
        b=oahsKtbAy75+xizRAEAAcwuin9tYc1pvjGLJjrOr9CaAr4etC9SyoeczT9Tp8d5Fw0
         70j0LEAqCzqthSoyKIaBgnfpqpFwO9kUq6lX2wN/HMbk6ZCh9wmy6Fpsxd3b5YTCOZnM
         ZeIjsibIrZ+203Fs7lXVISg4o8DGj0UTwftz4NE9t4SrP7UEpGvF9FijdDiCt8U6bMqE
         bIS1H5Aq38N1lyfQ6QzygfLbRRM+C8Tk0IDYUv+DMZEXWNIUwaSz6DYkue7H10pnpwxT
         sj4Mf1Eq8wD12g3iaTDBZMNaokMWHiy2KDIK5WHbLOdsXIgGU9YEkiX7ukfm5OQLX4GO
         iMMw==
X-Forwarded-Encrypted: i=1; AJvYcCXRTqPQOBYYVZHQe9a9eK7efPyEkyMY6QSD7X6O6faRqvNweXsDWWUn74CzLIEz3ORBI6kNwZKAf5U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6T7QCf8EX6L8/zdbFte5YEo4/BrNZGIx8s25Q6llNZs/KNhmF
	MreCztCR/VSntXvCPMIKMvUYhuDpK1FcXyoQjXnTVOhyGa4iEJKdbicNjavUUWIa1Wpx4PCKOEI
	bxnU7Wfjg7NbIDxOETiVES3LnuxEFOU2j6lPb8OPA4w==
X-Gm-Gg: ASbGncsyYmZJBGhNZHhQlB94f9+hcWBZhE+FQwaAsnTmFO4NG0MCKoTfmDO+TVEr6Du
	PEkV6HR/5OBdliBu44gNIxIZokaA7tl0FqXyhdJBTD5Rq1MIv01U45TvdlZlTLX8BOpGe3JHQrV
	hXjG6g3uTqJ0Rx75VQZXUW5012lOjQb00knhQeyVDlIjeS15L8cDGigglRuOeBgsyzsKb5IDMTB
	Sp7MY7CVBHSCnnhLWwaYXYoHibHjy3I8q1bkLH4RhRPLY+hMV+y5bQpZQ==
X-Google-Smtp-Source: AGHT+IHPQjz/pJ437pH7YFtSiDGAQ3VcFvPXvPvzuQHBM0+kWPerbB0r4L6RkLw74giNqTUgcHTcvt5mHbrdxH4Haek=
X-Received: by 2002:a05:6402:5186:b0:640:9c99:bfac with SMTP id
 4fb4d7f45d1cf-6431a4d609bmr2586786a12.13.1762951620623; Wed, 12 Nov 2025
 04:47:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251107210526.257742-1-pasha.tatashin@soleen.com>
 <20251107210526.257742-3-pasha.tatashin@soleen.com> <aRObz4bQzRHH5hJb@kernel.org>
 <CA+CK2bDnaLJS9GdO_7Anhwah2uQrYYk_RhQMSiRL-YB=8ZZZWQ@mail.gmail.com>
 <CA+CK2bD3hps+atqUZ2LKyuoOSRRUWpTPE+frd5g13js4EAFK8g@mail.gmail.com> <aRRflLTejNQXWa1Z@kernel.org>
In-Reply-To: <aRRflLTejNQXWa1Z@kernel.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Wed, 12 Nov 2025 07:46:23 -0500
X-Gm-Features: AWmQ_bl87XR7836bCxIna383p3224VYBM84reJOLcIDxOxFdtSf2hXG1yTbnSeY
Message-ID: <CA+CK2bB8731z-EKv2K8-x5SH8rjOTTuWkfkrc4Qj6skW+Kr7-g@mail.gmail.com>
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

On Wed, Nov 12, 2025 at 5:21=E2=80=AFAM Mike Rapoport <rppt@kernel.org> wro=
te:
>
> On Tue, Nov 11, 2025 at 03:42:24PM -0500, Pasha Tatashin wrote:
> > On Tue, Nov 11, 2025 at 3:39=E2=80=AFPM Pasha Tatashin
> > <pasha.tatashin@soleen.com> wrote:
> > >
> > > > >       kho_memory_init();
> > > > >
> > > > > +     /* Live Update should follow right after KHO is initialized=
 */
> > > > > +     liveupdate_init();
> > > > > +
> > > >
> > > > Why do you think it should be immediately after kho_memory_init()?
> > > > Any reason this can't be called from start_kernel() or even later a=
s an
> > > > early_initcall() or core_initall()?
> > >
> > > Unfortunately, no, even here it is too late, and we might need to fin=
d
> > > a way to move the kho_init/liveupdate_init earlier. We must be able t=
o
> > > preserve HugeTLB pages, and those are reserved earlier in boot.
> >
> > Just to clarify: liveupdate_init() is needed to start using:
> > liveupdate_flb_incoming_* API, and FLB data is needed during HugeTLB
> > reservation.
>
> Since flb is "file-lifecycle-bound", it implies *file*. Early memory
> reservations in hugetlb are not bound to files, they end up in file objec=
ts
> way later.

FLB global objects act similarly to subsystem-wide data, except their
data has a clear creation and destruction time tied to preserved
files. When the first file of a particular type is added to LUO, this
global data is created; when the last file of that type is removed
(unpreserved or finished), this global data is destroyed, this is why
its life is bound to file lifecycle. Crucially, this global data is
accessible at any time while LUO owns the associated files spanning
the early boot update boundary.

> So I think for now we can move liveupdate_init() later in boot and we wil=
l
> solve the problem of hugetlb reservations when we add support for hugetlb=
.

HugeTLB reserves memory early in boot. If we already have preserved
HugeTLB pages via LUO/KHO, we must ensure they are counted against the
boot-time reservation. For example, if hugetlb_cma_reserve() needs to
reserve ten 1G pages, but LUO has already preserved seven, we only
need to reserve three new pages and the rest are going to be restored
with the files.

Since this count is contained in the FLB global object, that data
needs to be available during the early reservation phase. (Pratyush is
working on HugeTLB preservation and can explain further).

Pasha


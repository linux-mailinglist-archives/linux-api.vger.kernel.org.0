Return-Path: <linux-api+bounces-5257-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5023BC54802
	for <lists+linux-api@lfdr.de>; Wed, 12 Nov 2025 21:46:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A41A24E3DC7
	for <lists+linux-api@lfdr.de>; Wed, 12 Nov 2025 20:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96E4D2D6E74;
	Wed, 12 Nov 2025 20:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="DMVQbG/g"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C77A32D5924
	for <linux-api@vger.kernel.org>; Wed, 12 Nov 2025 20:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762980093; cv=none; b=bHoIy0mNViMmkHKLEAythjx0RnP+kOYGkwMNS5PS+r/1TIiaTwq1VPqIwF4rT1rt8yyjUJUxXl3q/ZkDEw43TzMBCsymgP8zGyuelUkLMKQDqB9OQ2FM7kGOFqhiQXgi2TCTzYjL8b2fVLpPrGoegaq/xvB6hpohaCySCyxLtdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762980093; c=relaxed/simple;
	bh=zM4D/2QGSpTpyQNyqeW+YoTyGqfn0xHUyC7FfAc2/YA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PVyhfpbxVEGo9QLnFpAuAYckER5dsqcSc5TXHz4Ao0DEGJFVfH1OcZO/z+bXIMf2IW5EmjE44Vs4qCcvCIAbbkHJNFtLpEin/rprTYyeXdwX1KQeLI8O48vXhAR2dC4cEorQQo0mWnnRyZZcx3F1kQT0+HKJGSofYsJN92Dgp7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=DMVQbG/g; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-63c489f1e6cso169258a12.1
        for <linux-api@vger.kernel.org>; Wed, 12 Nov 2025 12:41:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1762980090; x=1763584890; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dhyXtoYIzmR1qHGhz6TVmqBXuiqas52bqmxrLwkY3s0=;
        b=DMVQbG/gd5oI5/dpbDk9nsCzwzUQ6CrCixF1dKx7BI3nzrKsKlou8SfhttpSHGU8dh
         vh+BrYUl4Y6Ts3Dl08lbK0yzMf/DxDvehzoLqKgUK4v1mgmclh6mAfIbTdfSIdHwhrZG
         dQVYB5UbFk0OPI5pNm7fu0uI/mrWlZ351XAp0ErjaCaH8BGG7LgwykeqXm4wpRwD+QpU
         ibIUpd8s68gZvKxLCdXOxiGCsTtxpeRCDyZtyh8Rf0FjtbWWWd0HxtqgiMdx2GK1EldX
         uc8mrqNaXqKrE9kF53jswoo7YtCle+XI4bKuvth21Wli89xJsNAcQmpwam3QG/P3w14I
         7LVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762980090; x=1763584890;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dhyXtoYIzmR1qHGhz6TVmqBXuiqas52bqmxrLwkY3s0=;
        b=BLr5Gkqq8u7DPGfHqT3FNmGTjXKS4UgCxRoS1gqvOLpd5qAjAoXOpDIi6b4/jmPucz
         w9fBFcyStZc0DqPJQbgKhbqIT52CosZKaKlthIIqTGLt9pXJ81ahWnZJUg7jBp+JzVN9
         ds97KCyMMvsfyaBtA1sxCASmY/vK08dVElp9/XpHtWzmjY44RKTOtxLN927a1mPBcAjo
         HU64WpSyHfWS4RyoEa1OXxtL5XUZ11CQFDbKKxAzChswVcpQSLpkuOfvVK7Bw1vbWBX3
         gt4o0FlU+oOlNwAHBJ5F6D7azvSOp7WE/eP18GM/fjw2JTxS7WFZoUeXDUWadNPBCfQu
         4jGA==
X-Forwarded-Encrypted: i=1; AJvYcCXlPjwJo/Wbwf+RKlofE0KDej+6+2nLPuAmOIYEUI+iypPhasOFnRD2XqM5ZaVURgYat4RlVieIV90=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6bLWeqKNJ5yTRXDRSr13iMaockdOjtZ8aPta2VNVoskismqtl
	IKoJrgAkdhlJWOC8Bz4zv8YAgYSVG0BiRaai9Svt4yytTCsZZSflNw0V7etJz/2lzwR98KXHCn5
	ATymi5nte7/06WGAa9sfWYW7yihC5jzvHKJojDTauhg==
X-Gm-Gg: ASbGncsGEINrk6igau9GMkQ31UbhowvodP7hDXrdgbn59DDuJ0GEsj0OP3Tjrodop2t
	homTh3apmlHYmZtdOnAgMXgR38ZQ7jsyiax/NjVbslWSj/J0fyYrcuHc+dACtkI2Y8dlDSm34VT
	UreJst2j7IwddvCBEF4jKVAGk4HGHuYOsd6umoLwsTVO4fa5Qosfzcqj3OOZEKal8bg4SVHLbjI
	7HYi7rJsf2l9BBZ7Wa3ffgmssN4HVfz6ixzJqhfsEgDPoK1zOU2rmXWhA==
X-Google-Smtp-Source: AGHT+IHqo0cWs4d/0+ME7Pp4LbR8c7We/VnufInTVc25I/poQ6OzmFZFO8BkwH4hrLb9dn8NI1Qgpj2DiapmSAwzhV0=
X-Received: by 2002:aa7:c9c4:0:b0:640:e7bc:d3ce with SMTP id
 4fb4d7f45d1cf-64334cf0fa3mr536431a12.11.1762980090000; Wed, 12 Nov 2025
 12:41:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251107210526.257742-1-pasha.tatashin@soleen.com>
 <20251107210526.257742-23-pasha.tatashin@soleen.com> <aRTs3ZouoL1CGHst@kernel.org>
In-Reply-To: <aRTs3ZouoL1CGHst@kernel.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Wed, 12 Nov 2025 15:40:53 -0500
X-Gm-Features: AWmQ_bn7hzYlz1CnwhflDe9tj18uCKgXHbii3rFfCz-B6efDQe-vtqY1VtpWQlg
Message-ID: <CA+CK2bBVRHwBu6a77gkvsbmWkQFDcTvNo+5aOT586mie13zqqA@mail.gmail.com>
Subject: Re: [PATCH v5 22/22] tests/liveupdate: Add in-kernel liveupdate test
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

On Wed, Nov 12, 2025 at 3:24=E2=80=AFPM Mike Rapoport <rppt@kernel.org> wro=
te:
>
> On Fri, Nov 07, 2025 at 04:03:20PM -0500, Pasha Tatashin wrote:
> > Introduce an in-kernel test module to validate the core logic of the
> > Live Update Orchestrator's File-Lifecycle-Bound feature. This
> > provides a low-level, controlled environment to test FLB registration
> > and callback invocation without requiring userspace interaction or
> > actual kexec reboots.
> >
> > The test is enabled by the CONFIG_LIVEUPDATE_TEST Kconfig option.
> >
> > Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> > ---
> >  kernel/liveupdate/luo_file.c     |   2 +
> >  kernel/liveupdate/luo_internal.h |   8 ++
> >  lib/Kconfig.debug                |  23 ++++++
> >  lib/tests/Makefile               |   1 +
> >  lib/tests/liveupdate.c           | 130 +++++++++++++++++++++++++++++++
> >  5 files changed, 164 insertions(+)
> >  create mode 100644 lib/tests/liveupdate.c
> >
> > diff --git a/kernel/liveupdate/luo_file.c b/kernel/liveupdate/luo_file.=
c
> > index 713069b96278..4c0a75918f3d 100644
> > --- a/kernel/liveupdate/luo_file.c
> > +++ b/kernel/liveupdate/luo_file.c
> > @@ -829,6 +829,8 @@ int liveupdate_register_file_handler(struct liveupd=
ate_file_handler *fh)
> >       INIT_LIST_HEAD(&fh->flb_list);
> >       list_add_tail(&fh->list, &luo_file_handler_list);
> >
> > +     liveupdate_test_register(fh);
> > +
>
> Do it mean that every flb user will be added here?

No, FLB users will use:

liveupdate_register_flb() from various subsystems. This
liveupdate_test_register() is only to allow kernel test to register
test-FLBs to every single file-handler for in-kernel testing purpose
only.

Pasha


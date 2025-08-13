Return-Path: <linux-api+bounces-4462-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BD2DB24B2C
	for <lists+linux-api@lfdr.de>; Wed, 13 Aug 2025 15:53:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16141165272
	for <lists+linux-api@lfdr.de>; Wed, 13 Aug 2025 13:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CC5E2EAB93;
	Wed, 13 Aug 2025 13:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="fRMC+a3C"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF7D12EA167
	for <linux-api@vger.kernel.org>; Wed, 13 Aug 2025 13:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755092988; cv=none; b=Zs9QIQk8pqe6VVEnMQWJaQwCGOHxKm5+dPFUdrD+GFWhYWdYL3jnsDAFTWg50/KcX0ALVOzzVKzYHsm3Lhw1Uug6tE3ajAavTgKMZQW4oLx8R6sWnz2vSC0qgPvPhTeOKSBQtT+A99q2Spz18UCqJdtBsUns8YIeyM3oBIv5Qsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755092988; c=relaxed/simple;
	bh=tjiy6lq7zUfoy7QhTySB92H1/vQWjMoW9kYs9mRlj60=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oKrG2eSMrENi7B9eKfNGLh7ZadTGNdVHhKHXspsFJKcGIUI7H7t11lo5Mc2O2u8al8gBFvJ17Uj9V9Rv5wFyUTv7/FERNuYyCfoU9h+0JeNdrIQeWMr+40nXfI0AVEfhoQiQ/7gdyKlv8WSiQIBa16axJuqfZJ/8VsqVPQru/s8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=fRMC+a3C; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4b1008221dcso3369661cf.1
        for <linux-api@vger.kernel.org>; Wed, 13 Aug 2025 06:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1755092986; x=1755697786; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5COPJ1bhIrlUBdoMgcmCT1dlQIxGjY3lpdJsY0vxHvo=;
        b=fRMC+a3CCJvj24Ef6rwrbx5tK0dANyBQ9llNevrOsnImc7l/sacCIoI4zYo97LUuCg
         9ayHBM9lpNgzRMPzBGD7vH3P9s8pgo0UN6XJ+l3b6xhNk/ySsR8T41OVP+cTSXp8tlZd
         VQSE7OakvCZeO9tM5eXDwyN2DneVT6430P63dMJXzw/gkelrLAaEGNxJ0Sl0d1vJRiUC
         3fYrm1ATCUy7XPF6eHKIiIQkNh8Rw16UzH/Grgb9yN1gm50pxUSPq1wj4PpciLOa6Gmz
         NSIF/R/bXZQARJ19e1+hvVPrr6Myt+BxdJqbhRCNPArDZqvUK/1/pgOOggRIsS3dB5mY
         +hbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755092986; x=1755697786;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5COPJ1bhIrlUBdoMgcmCT1dlQIxGjY3lpdJsY0vxHvo=;
        b=s2fhmk86Tyck935PDTDphw5H1PLZQc10ajZLbXGXs1XLuj4ycv7reyr7k2zAD3eVaQ
         ZZk6IahAACP77cMt1O+y9ysZzF9UYV+Zkf9LvxzoO43ifK+ZpdYVf8jhKhTnur8bWAiS
         mCKjcaZbIfjM2ZC9Tgq8BPKuUe7ADbNi7ZPsKLsRdyjC4ruLF7+6bPEYq7+Zp1R2HZ1/
         pTyUVm709IcxfUdtpfAfQRhKUxrhYHU2f+hM5wYISwUKtXzn7gg1PTdAJ1kc0ayzvi9w
         OwIvGN0HvbjK17TPLRtspLs/fWfiu2csBzwffvMoqDUUNJfuepDxqFdLiQhM4prnMN/p
         Pb/Q==
X-Forwarded-Encrypted: i=1; AJvYcCXQPXJanCG3nSIA7K+X5Xr1eSQJ/a7IEJ08ETL2z/JjmKlP8mSRrgVdwFiWssmNoDCzyKMfmu72rnI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqdOTrr0yJ9x5hf0LAMQXlIM1haUrmQa7kPPjovGWRakqnhB+P
	nz6Upz9pjDoL9vjuUZwOy9bfk+55UPk+O+a9a4PlcVGi5DsxiZfxU0rZa97NXGvpw4KxDVNIemP
	zsOEAnCFIhuq6MCf6zh6nk7YuG73jPETowilAxXxUKQ==
X-Gm-Gg: ASbGncuwUeks1T4gBI29/a1D7V4B75OABEreJXl8JcfAj//6ibJakzeqDA8qXoIkQGS
	kLhruoc1h1QaLNRZyp8h8Ltydw8oib9ThU2zj7DKta3t5ZaSla3RTMxJrTXVnCGT1M+zV7bvbgA
	L7G4PM9AC9BjBm4SCzU8WdgR0brgXGHQGBBlntfzLcsbs+BwNkOhQLociSko93mtO9zCB0+hkrM
	zL6
X-Google-Smtp-Source: AGHT+IGct8ZeidsnGi/YbFJu4oMvwbFYwPG2diux+p27hnjphdKkPPw2dpGSZ3mXdM1D29x0JXCw0Y4/KsFGm7KlPlM=
X-Received: by 2002:ac8:5d55:0:b0:4af:4bac:e539 with SMTP id
 d75a77b69052e-4b0fdfdb678mr31989691cf.3.1755092985396; Wed, 13 Aug 2025
 06:49:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250807014442.3829950-1-pasha.tatashin@soleen.com>
 <20250807014442.3829950-30-pasha.tatashin@soleen.com> <20250813063407.GA3182745.vipinsh@google.com>
 <mafs0wm77wgjx.fsf@kernel.org>
In-Reply-To: <mafs0wm77wgjx.fsf@kernel.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Wed, 13 Aug 2025 13:49:09 +0000
X-Gm-Features: Ac12FXyj1CElzNmOfajT8FxAkTu6tjsBaL5e4YwqAjZVvEs1xx2b7a4U9Pkl3Fk
Message-ID: <CA+CK2bCmQ3hY+ACnLrVZ1qwiTiVvxEBCDNFmAHn_uVRagvshhw@mail.gmail.com>
Subject: Re: [PATCH v3 29/30] luo: allow preserving memfd
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Vipin Sharma <vipinsh@google.com>, jasonmiu@google.com, graf@amazon.com, 
	changyuanl@google.com, rppt@kernel.org, dmatlack@google.com, 
	rientjes@google.com, corbet@lwn.net, rdunlap@infradead.org, 
	ilpo.jarvinen@linux.intel.com, kanie@linux.alibaba.com, ojeda@kernel.org, 
	aliceryhl@google.com, masahiroy@kernel.org, akpm@linux-foundation.org, 
	tj@kernel.org, yoann.congal@smile.fr, mmaurer@google.com, 
	roman.gushchin@linux.dev, chenridong@huawei.com, axboe@kernel.dk, 
	mark.rutland@arm.com, jannh@google.com, vincent.guittot@linaro.org, 
	hannes@cmpxchg.org, dan.j.williams@intel.com, david@redhat.com, 
	joel.granados@kernel.org, rostedt@goodmis.org, anna.schumaker@oracle.com, 
	song@kernel.org, zhangguopeng@kylinos.cn, linux@weissschuh.net, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, 
	gregkh@linuxfoundation.org, tglx@linutronix.de, mingo@redhat.com, 
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	rafael@kernel.org, dakr@kernel.org, bartosz.golaszewski@linaro.org, 
	cw00.choi@samsung.com, myungjoo.ham@samsung.com, yesanishhere@gmail.com, 
	Jonathan.Cameron@huawei.com, quic_zijuhu@quicinc.com, 
	aleksander.lobakin@intel.com, ira.weiny@intel.com, 
	andriy.shevchenko@linux.intel.com, leon@kernel.org, lukas@wunner.de, 
	bhelgaas@google.com, wagi@kernel.org, djeffery@redhat.com, 
	stuart.w.hayes@gmail.com, lennart@poettering.net, brauner@kernel.org, 
	linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, saeedm@nvidia.com, 
	ajayachandra@nvidia.com, jgg@nvidia.com, parav@nvidia.com, leonro@nvidia.com, 
	witu@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 13, 2025 at 12:29=E2=80=AFPM Pratyush Yadav <pratyush@kernel.or=
g> wrote:
>
> Hi Vipin,
>
> Thanks for the review.
>
> On Tue, Aug 12 2025, Vipin Sharma wrote:
>
> > On 2025-08-07 01:44:35, Pasha Tatashin wrote:
> >> From: Pratyush Yadav <ptyadav@amazon.de>
> >> +static void memfd_luo_unpreserve_folios(const struct memfd_luo_preser=
ved_folio *pfolios,
> >> +                                    unsigned int nr_folios)
> >> +{
> >> +    unsigned int i;
> >> +
> >> +    for (i =3D 0; i < nr_folios; i++) {
> >> +            const struct memfd_luo_preserved_folio *pfolio =3D &pfoli=
os[i];
> >> +            struct folio *folio;
> >> +
> >> +            if (!pfolio->foliodesc)
> >> +                    continue;
> >> +
> >> +            folio =3D pfn_folio(PRESERVED_FOLIO_PFN(pfolio->foliodesc=
));
> >> +
> >> +            kho_unpreserve_folio(folio);
> >
> > This one is missing WARN_ON_ONCE() similar to the one in
> > memfd_luo_preserve_folios().
>
> Right, will add.
>
> >
> >> +            unpin_folio(folio);
>
> Looking at this code caught my eye. This can also be called from LUO's
> finish callback if no one claimed the memfd after live update. In that
> case, unpin_folio() is going to underflow the pincount or refcount on
> the folio since after the kexec, the folio is no longer pinned. We
> should only be doing folio_put().
>
> I think this function should take a argument to specify which of these
> cases it is dealing with.
>
> >> +    }
> >> +}
> >> +
> >> +static void *memfd_luo_create_fdt(unsigned long size)
> >> +{
> >> +    unsigned int order =3D get_order(size);
> >> +    struct folio *fdt_folio;
> >> +    int err =3D 0;
> >> +    void *fdt;
> >> +
> >> +    if (order > MAX_PAGE_ORDER)
> >> +            return NULL;
> >> +
> >> +    fdt_folio =3D folio_alloc(GFP_KERNEL, order);
> >
> > __GFP_ZERO should also be used here. Otherwise this can lead to
> > unintentional passing of old kernel memory.
>
> fdt_create() zeroes out the buffer so this should not be a problem.

You are right, fdt_create() zeroes the whole buffer, however, I wonder
if it could be `optimized` to only clear only the header part of FDT,
not the rest and this could potentially lead us to send an FDT buffer
that contains both a valid FDT and the trailing bits contain data from
old kernel.

Pasha


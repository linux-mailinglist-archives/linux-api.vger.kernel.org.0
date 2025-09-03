Return-Path: <linux-api+bounces-4703-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D0DE0B4261C
	for <lists+linux-api@lfdr.de>; Wed,  3 Sep 2025 18:00:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C8DC1B256C5
	for <lists+linux-api@lfdr.de>; Wed,  3 Sep 2025 16:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55D4C29B793;
	Wed,  3 Sep 2025 16:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="A/ARcP6s"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E8D29B76F
	for <linux-api@vger.kernel.org>; Wed,  3 Sep 2025 16:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756915222; cv=none; b=dVVSRHRB7RxqRsvsYIP6QkdWL0bDbfeiQAMV2I9S5BmGx1eTnagQawpxWuN4kOu7FDQraS8egDD3IGKbLY/KDuLu1SCgU/8LgkJtv6RwQGDgSPKhjinwXdq5k5mIoDZGHOl+f+R3PUB4Wk2G/ClXTd76wRpw37tNcv9pc8QiTHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756915222; c=relaxed/simple;
	bh=VzTEB4bQWY8fWAQTgqOF+HS9WXqmiqpiTrodHwtJGNM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nb4+1xYkZy9I7I42s5tRkjFYq50APAKP7glJBiuDjeebI4y1F85tUnzCy+wd1TyKaSLPMPeZMbkLSm+pWxrHKqY+IrXsL/xYfn6JmSOp8kaCG6xwjz6OVru35vNZbY62KsiaclIRtOaIxLWBsDbGuB0V+sBbFHx+4uJYKguGJB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=A/ARcP6s; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4b3319c3a27so240201cf.0
        for <linux-api@vger.kernel.org>; Wed, 03 Sep 2025 09:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1756915219; x=1757520019; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VzTEB4bQWY8fWAQTgqOF+HS9WXqmiqpiTrodHwtJGNM=;
        b=A/ARcP6sfrpy7CHp8keZw+/WTMMqeXLYRA6dj2gBMPovsEkXi2Jbt6IkDh8gdtzhJF
         ZDOkmfVTK1B4cnDiQCc9hJWrsWQ3Gr/Cu0AHk6kPrKsP/VaKm/vpWCGZAsfdpDoMxWZZ
         fHvCu6KjaRAQDLJqLwl+ekdc2pvJTngvXlhOk0obJlOu7OVtk2BgjjjsppVatR6vxq6/
         MC8wV2bM42270aakESITxN7g539CMri0MALnetN073CGAbVDoB68/AWFRekDCfSnyLZJ
         6F9i/GbQrLjJiGEtbhkvDpVupAmfzKJGaslvuCnqgA6fFl2sqig0cus7u77Cv9Fts6ra
         Beiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756915219; x=1757520019;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VzTEB4bQWY8fWAQTgqOF+HS9WXqmiqpiTrodHwtJGNM=;
        b=GOJkeQ0jik+lVVddIHzNasVLtJG+OvYToxGA2KISnTVwNOgHXdM9AnRvZJPwd66hQo
         1muKuZyXz4qgjp/fUPC5bh2CXc7B5SUEBUL6rY3Ud62frlL1W3tnkrhQVE8fxugUSghX
         gbffXCo9FMHNEJSnfr+XMv59ZFfwFVjycet9cZAIHCk15k5HDgsfRJ3cuHYj7sOmn+Dt
         brcYRB2i6a/SACBE7FzrglFTX9Vu52rFx/nPDnlUQ+6iVSsPOdXj1OUpojL4tDMCgfGQ
         7QW6QFIS0fjIkEyyKb24Wo0trNPJEzJ43FUb9CEx1p236gCNk8IAhYKjNxbLZA4n4Rxv
         Miqg==
X-Forwarded-Encrypted: i=1; AJvYcCWrLh/7zyo4J3uxgGn0JxzXjhYdI2oASJ7XyIYn8erKMAM8Lrmgf/Ru4nx+O0bdCyOCC7OhaaX3RHU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0625NI8EG5c73zHTVZ2MYFnTeXbN61fTy0Pr/+I+UJg42GzJi
	L8KBuUpxgGzruGYSNfdqFPtIfvGoOzxg5gCQQX1ZWFfwfGqGy8Yg31B09aoG9mARTc6yhgK5nG6
	OQGsxTHUMooZDs2AYVy0xH241Iq+6jT3gdjfzRa2w5Q==
X-Gm-Gg: ASbGnctzWgMZRLPV0sDHmAzyZ4QSRD+D7FbBLLLJzMeSRhQp9AnJsDd2UAKxY0gqWTd
	rpK56JJLKeRh548KNq6HUhsPdA+3heBXhqbsDs1VjbqmIP8zB+YsThPFEdJ01BCHT5h2ks04dOm
	olYIDC00C5axvlX5DwCmTcsewds08NNRBKUck/rB3193SXWDxmOFgIPAcQga/dUlWzI0d00c44j
	FcmmB+5fIikmJw=
X-Google-Smtp-Source: AGHT+IEwx1LONda4kuiaJ848y4hM0OUKd0p1JeEharACFnO+JnUd0aS8iQNuarNBHObxQXAJhaTUSynWXDSmvzGvt7Q=
X-Received: by 2002:a05:622a:1ba4:b0:4b3:1197:b93a with SMTP id
 d75a77b69052e-4b31dc8f67fmr234759261cf.34.1756915218859; Wed, 03 Sep 2025
 09:00:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250807014442.3829950-1-pasha.tatashin@soleen.com>
 <20250807014442.3829950-30-pasha.tatashin@soleen.com> <20250826162019.GD2130239@nvidia.com>
 <aLXIcUwt0HVzRpYW@kernel.org> <CA+CK2bC96fxHBb78DvNhyfdjsDfPCLY5J5cN8W0hUDt9KAPBJQ@mail.gmail.com>
 <mafs03496w0kk.fsf@kernel.org> <CA+CK2bAb6s=gUTCNjMrOqptZ3a_nj3teuVSZs86AvVymvaURQA@mail.gmail.com>
 <20250902113857.GB186519@nvidia.com>
In-Reply-To: <20250902113857.GB186519@nvidia.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Wed, 3 Sep 2025 15:59:40 +0000
X-Gm-Features: Ac12FXzyfAMIU2bzOrGlEX9a8opKhAuJo6gq5GdnRJV0XcXKQKHlYu1Dn3mOunw
Message-ID: <CA+CK2bB-CaEdvzxt9=c1SZwXBfy-nE202Q2mfHL_2K7spjf8rw@mail.gmail.com>
Subject: Re: [PATCH v3 29/30] luo: allow preserving memfd
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Pratyush Yadav <pratyush@kernel.org>, Mike Rapoport <rppt@kernel.org>, jasonmiu@google.com, 
	graf@amazon.com, changyuanl@google.com, dmatlack@google.com, 
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
	ajayachandra@nvidia.com, parav@nvidia.com, leonro@nvidia.com, witu@nvidia.com
Content-Type: text/plain; charset="UTF-8"

> > > > The patch looks okay to me, but it doesn't support holes in vmap
> > > > areas. While that is likely acceptable for vmalloc, it could be a
> > > > problem if we want to preserve memfd with holes and using vmap
> > > > preservation as a method, which would require a different approach.
> > > > Still, this would help with preserving memfd.
> > >
> > > I agree. I think we should do it the other way round. Build a sparse
> > > array first, and then use that to build vmap preservation. Our emails
> >
> > Yes, sparse array support would help both: vmalloc and memfd preservation.
>
> Why? vmalloc is always full popoulated, no sparseness..

vmalloc is always fully populated, but if we add support for
preserving an area with holes, it can also be used for preserving
vmalloc. By the way, I don't like calling it *vmalloc* preservation
because we aren't preserving the original virtual addresses; we are
preserving a list of pages that are reassembled into a virtually
contiguous area. Maybe kho map, or kho page map, not sure, but vmalloc
does not sound right to me.

> And again in real systems we expect memfd to be fully populated too.

I thought so too, but we already have a use case for slightly sparse
memfd, unfortunately, that becomes *very* inefficient when fully
populated.


Return-Path: <linux-api+bounces-4648-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D2E83B3ADEB
	for <lists+linux-api@lfdr.de>; Fri, 29 Aug 2025 01:00:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CB851C84B15
	for <lists+linux-api@lfdr.de>; Thu, 28 Aug 2025 23:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED66926F297;
	Thu, 28 Aug 2025 23:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U3ssYPyI"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C942925C6EE
	for <linux-api@vger.kernel.org>; Thu, 28 Aug 2025 23:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756422031; cv=none; b=qiYG+lxONmODHoddWqcuNheMxpgP0euGAAqFfJF+qo+3AepUb3P5gzSDnKNnHBdEIGeGLy0cOwxjGOm+LvI7WltggcIY5LXplPow2d4pEwWbn1r/4KAX4Id3P96xPTjlRKwhKtkmKCVakBDVImZX+If44nQB7Bi++pAsc9S/5DE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756422031; c=relaxed/simple;
	bh=30fk9NHjTb+YHallX3yV7R6e7ygOcFwvrpZnNLQLRbU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qByJ48Nhg4u2VP9e2GSNDeWu9e63NDfMpKC0EujNxL7xJnxXdb4TuYl08K4rBcK7ptzeBjQHc/8YPmDS+Wpyho+iWRg/nLgO0V9XcDzDxeI+OYxF7tY7gzg7ogpolaUDj+5biNeOLwBibtVazM2RCqFY94xD4t4JFgl39qzuihc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U3ssYPyI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8325C4CEFD
	for <linux-api@vger.kernel.org>; Thu, 28 Aug 2025 23:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756422031;
	bh=30fk9NHjTb+YHallX3yV7R6e7ygOcFwvrpZnNLQLRbU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=U3ssYPyIZf4bYjFozVRTageNbBGWYnc0BLQHgtQCltO6D/wkhm6Ma8Pow5iTRUxn1
	 Ooi3zc5WYwmOGr5knJMQgsVpkf9TqEm8MilGpoORDWF1EDpalWL/2t3chxjK+JGmx0
	 Hwt9jdTB75A2Kxcc2WQ3H6YwutEKx6pEhLq4iU/tHRD3XzlAfIjPcbCMy3TSCFzFaK
	 9uu/dluZEdUB27iqtAyb+n6OwAocbz1SbqbQiLL1TRxyTDXUGW+JyWaK5+4ooS5oCp
	 NN2KfHo55A/69tSBlFlcka6JRfMKJI46BYY6ILyQ3eMXfisYnEkNEggK2P4onyoLtR
	 d/B7R6bcnFhhw==
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-45b7cadd676so25825e9.0
        for <linux-api@vger.kernel.org>; Thu, 28 Aug 2025 16:00:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVr/RjHIIeKn1fPBor8TSr0jFuXglGX6Tm3odfimEt8nCJdpXCwcO/9wf3oB114TGfGWuEHld0tTB0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzT708GNPMXbrnT5FJbpsXSCibSlQ8IWwqcEO/EjRzXb3Qs4qxF
	4K2EcXt+w4VrAB87MIqEWhE8G7wnnwazBl8y5KubUso6ZJ6QLRv09cHaKA/+VGY07z/EGpPUK3d
	0etSIgBE997JCQPwMb41qTvLP/ucPTkSlmXXxuBKI
X-Google-Smtp-Source: AGHT+IF37cR06H6qWz1gtR2Q33GyRHew0V5B6RhMXUxYEwLPyE0Qes9gQWNNur2aLf3Td0YQjtjqefGyXYAmbB98VJw=
X-Received: by 2002:a05:600c:a408:b0:453:672b:5b64 with SMTP id
 5b1f17b1804b1-45b66a2b6b4mr5476195e9.2.1756422029193; Thu, 28 Aug 2025
 16:00:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250807014442.3829950-1-pasha.tatashin@soleen.com>
 <20250807014442.3829950-30-pasha.tatashin@soleen.com> <20250826162019.GD2130239@nvidia.com>
 <mafs0bjo0yffo.fsf@kernel.org> <20250828124320.GB7333@nvidia.com>
In-Reply-To: <20250828124320.GB7333@nvidia.com>
From: Chris Li <chrisl@kernel.org>
Date: Thu, 28 Aug 2025 16:00:18 -0700
X-Gmail-Original-Message-ID: <CAF8kJuMcD4HA_CjK7iZ_47jgnu63pF-0WRrhdREvUmMVOgWBEg@mail.gmail.com>
X-Gm-Features: Ac12FXwgAj48kKV8-NSqN51LxVJutv6tGbA-WA_eygERRbP7T7KY6y3bnmWLRPM
Message-ID: <CAF8kJuMcD4HA_CjK7iZ_47jgnu63pF-0WRrhdREvUmMVOgWBEg@mail.gmail.com>
Subject: Re: [PATCH v3 29/30] luo: allow preserving memfd
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Pratyush Yadav <pratyush@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, jasonmiu@google.com, 
	graf@amazon.com, changyuanl@google.com, rppt@kernel.org, dmatlack@google.com, 
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
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 28, 2025 at 5:43=E2=80=AFAM Jason Gunthorpe <jgg@nvidia.com> wr=
ote:
>
> On Wed, Aug 27, 2025 at 05:03:55PM +0200, Pratyush Yadav wrote:
>
> > I think we need something a luo_xarray data structure that users like
> > memfd (and later hugetlb and guest_memfd and maybe others) can build to
> > make serialization easier. It will cover both contiguous arrays and
> > arrays with some holes in them.
>
> I'm not sure xarray is the right way to go, it is very complex data
> structure and building a kho variation of it seems like it is a huge
> amount of work.
>
> I'd stick with simple kvalloc type approaches until we really run into
> trouble.
>
> You can always map a sparse xarray into a kvalloc linear list by
> including the xarray index in each entry.

Each entry will be 16 byte, 8 for index and 8 for XAvalue, right?

> Especially for memfd where we don't actually expect any sparsity in
> real uses cases there is no reason to invest a huge effort to optimize
> for it..

Ack.

>
> > As I explained above, the versioning is already there. Beyond that, why
> > do you think a raw C struct is better than FDT? It is just another way
> > of expressing the same information. FDT is a bit more cumbersome to
> > write and read, but comes at the benefit of more introspect-ability.
>
> Doesn't have the size limitations, is easier to work list, runs
> faster.

Yes, especially when you have a large array.

Chris


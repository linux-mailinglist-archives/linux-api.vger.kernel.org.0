Return-Path: <linux-api+bounces-5397-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8718CC7601A
	for <lists+linux-api@lfdr.de>; Thu, 20 Nov 2025 20:11:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 462D828A84
	for <lists+linux-api@lfdr.de>; Thu, 20 Nov 2025 19:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03F8534DB40;
	Thu, 20 Nov 2025 19:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="jjcRYWa9"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A95F2DC332
	for <linux-api@vger.kernel.org>; Thu, 20 Nov 2025 19:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763665873; cv=none; b=CnRhLfK40MHJYIPwq2QlKLdOsbTr0nt/JnuTosI2+GBjzHTvPwuPlgDgd9WcBBH+cz/U6hkUbegmA7NqRaLTtyF3ca7X8AkZbtGhU5A1U0lkKip4jmQ69dik/HQ0nYAhGWEysrNi5fW4gMFIcueu2N/rc9TGtluE0v6CoVEz3/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763665873; c=relaxed/simple;
	bh=Ah4PI5Tf13M72+zbrnNAV69UwNAi5YkBZFZHyMln8zc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J5LWmNOeN0yVso8l7pMLacUWNttN0Mx/feQG2ozbiAxO34Ov3/IYfaiCNZEJCApcahr0BtEOBjWhaFhCUBjRAqU/MIC24WSA3VXH++T4JKWvlXxKDwUGqUy5H7JsVyLe/MkuxIRW1Tg9dLkRkf8tpNEXRcPgfV1+I57xcRVScvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=jjcRYWa9; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-640c1fda178so2023485a12.1
        for <linux-api@vger.kernel.org>; Thu, 20 Nov 2025 11:11:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1763665870; x=1764270670; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ah4PI5Tf13M72+zbrnNAV69UwNAi5YkBZFZHyMln8zc=;
        b=jjcRYWa9GoyyyoYkYi3Qdx2fkYbHn568z/0Dp2mwdEmsmrHVcbyjtCtSatyi36DjhF
         NyxkESaYTfZNsECpE+7tveKS6hPqPXlW2d4dFsKMc8q1Dx5IP8a1F9Xq0y3mcoS0MqQZ
         U3jXjIJ+aZ4RRw0O7wv3fx2g1B49nQZEjBrX1s0S/eSVRMt062OSpJ9mlW5sS8AJ9ZdK
         +R5Ov66mwQ26+adMjxPWUw9jp8M6BjIRr1u81PUPlfaOJVmdAQYLdoSEiQyO6PJJsei9
         73NlanUyDwJF4cAtUfVBvJRyBuXhETA/Y6sSuYJWH+w35789XalXlEcYqUgKi7RINFru
         CJcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763665870; x=1764270670;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ah4PI5Tf13M72+zbrnNAV69UwNAi5YkBZFZHyMln8zc=;
        b=jZNChgWKbwT3v4cCh8b6f6JknxXOn0kV5zlra5KGWViY8T4Wi6rnDTdjUzYgZllbxr
         bQkTRdpCs86GOpGKz22i0d+l5xWWDEyjhwZwaM41MXHkoj6dVQNeR4+S7ejaEt0P3go6
         2f/wCcKUa2Ii3tkeryYA5a46SFOB6MrNvc92WDkJ8lAsQHf0wWUuwE7WN9G1ZNZqGgYg
         +l9yxb/7AbmagZok13LyUyO+TS7I/Hg1yUA6PVoRqjkUDcIQ5Big62qJh9+AO1ORnSOj
         Vx9V0ctO30mCxj06G9BvYU77bCfSPgyqVEpxmaLY5ol6XX9koaCxemOCPOsR5yK7W78K
         rUOg==
X-Forwarded-Encrypted: i=1; AJvYcCVm4lVr5oXwGtscxRU6nyBgKJTyg3QyFYii/IzIa39wO4tyuEW73kT16V5rhjGWB8ZiJhBqTAiRXEw=@vger.kernel.org
X-Gm-Message-State: AOJu0YynxYcpovOUcczqdfqVXeO01SO5ylUH7nE9ZfA4ZR1AfJcUWP7g
	5RLnYg0k/em+frsiiwLfc/5RcDi8V3LA8TGTJFzizjp5tbEyPg0sUs7DDgEoO3HWhxb1o1qwsHY
	3KePe4xC4fxlFGWRLLpIiwz8TLVFJHPi0pl9+9B2O8w==
X-Gm-Gg: ASbGncvOyIQ+18ui+p+/lGvKiBioxjOS2DtobUehG63dEuCPtnfYfty8Ip9RLDUt2mB
	wsJxpvsNtYFwq6oa1nSv9nh+AKnDsVfTknoMI8lPpO2VIMfwglKBtBbFOKqlIye7mp3swxodN3w
	l/JfFDWps2ZJSk0tFRfxW3vSxveVlfpxviUpUwZnzM3Vp099sL/SHd7pkMBr72TjguBjYw7jmQZ
	qtBE/15JgmZxZtYtPIzvj7snM8yf0JCdDh2b/tkx5L2N6WwzvsbqU9N3/VeLIryLE24
X-Google-Smtp-Source: AGHT+IH4WA4XmxDMHnQGvwWRqcCYMoQ95h8Cnb/tecHWkSne98BYp1s+lgZXYiOL0q0CCu+HgOArmo/0lwNHfSz4VVo=
X-Received: by 2002:a05:6402:3586:b0:640:a7a9:289f with SMTP id
 4fb4d7f45d1cf-645363c6b54mr3839432a12.2.1763665869906; Thu, 20 Nov 2025
 11:11:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251115233409.768044-1-pasha.tatashin@soleen.com>
 <20251115233409.768044-9-pasha.tatashin@soleen.com> <aRrtRfJaaIHw5DZN@kernel.org>
 <CA+CK2bBxVNRkJ-8Qv1AzfHEwpxnc4fSxdzKCL_7ku0TMd6Rjow@mail.gmail.com>
 <aRxYQKrQeP8BzR_2@kernel.org> <CA+CK2bASYtBndN24HZhkndDpsrU1rwjCokE=9eLZUq2Jhj6bag@mail.gmail.com>
 <aR9i9SXGDQ6bi1mi@kernel.org>
In-Reply-To: <aR9i9SXGDQ6bi1mi@kernel.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Thu, 20 Nov 2025 14:10:33 -0500
X-Gm-Features: AWmQ_bkna6LLJHL393cMjX0oZb4owkA8mCeUNJHS4sJFmwNTru1Npow-9jQRfrE
Message-ID: <CA+CK2bAA4qifTLpk27FtJX476Jr+VB9sa-NTUyo9nqmeWfkPPg@mail.gmail.com>
Subject: Re: [PATCH v6 08/20] liveupdate: luo_flb: Introduce
 File-Lifecycle-Bound global state
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
	anna.schumaker@oracle.com, song@kernel.org, linux@weissschuh.net, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, 
	gregkh@linuxfoundation.org, tglx@linutronix.de, mingo@redhat.com, 
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	rafael@kernel.org, dakr@kernel.org, bartosz.golaszewski@linaro.org, 
	cw00.choi@samsung.com, myungjoo.ham@samsung.com, yesanishhere@gmail.com, 
	Jonathan.Cameron@huawei.com, quic_zijuhu@quicinc.com, 
	aleksander.lobakin@intel.com, ira.weiny@intel.com, 
	andriy.shevchenko@linux.intel.com, leon@kernel.org, lukas@wunner.de, 
	bhelgaas@google.com, wagi@kernel.org, djeffery@redhat.com, 
	stuart.w.hayes@gmail.com, ptyadav@amazon.de, lennart@poettering.net, 
	brauner@kernel.org, linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	saeedm@nvidia.com, ajayachandra@nvidia.com, jgg@nvidia.com, parav@nvidia.com, 
	leonro@nvidia.com, witu@nvidia.com, hughd@google.com, skhawaja@google.com, 
	chrisl@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 20, 2025 at 1:50=E2=80=AFPM Mike Rapoport <rppt@kernel.org> wro=
te:
>
> On Tue, Nov 18, 2025 at 10:37:30AM -0500, Pasha Tatashin wrote:
> > On Tue, Nov 18, 2025 at 6:28=E2=80=AFAM Mike Rapoport <rppt@kernel.org>=
 wrote:
> > >
> > > On Mon, Nov 17, 2025 at 10:54:29PM -0500, Pasha Tatashin wrote:
> > > > >
> > > > > The concept makes sense to me, but it's hard to review the implem=
entation
> > > > > without an actual user.
> > > >
> > > > There are three users: we will have HugeTLB support that is going t=
o
> > > > be posted as RFC in a few weeks. Also, in two weeks we are going to
> > > > have an updated VFIO and IOMMU series posted both using FLBs. In th=
e
> > > > mean time, this series provides an FLB in-kernel test that verifies
> > > > that multiple FLBs can be attached to File-Handlers, and the basic
> > > > interfaces are working.
> > >
> > > Which means that essentially there won't be a real kernel user for FL=
B for
> > > a while.
> > > We usually don't merge dead code because some future patchset depends=
 on
> > > it.
> >
> > I understand the concern. I would prefer to merge FLB with the rest of
> > the LUO series; I don't view it as completely dead code since I have
> > added the in-kernel test that specifically exercises and validates
> > this API.
>
> The test exercises a simple happy flow, but it still does not validate th=
at
> this API is what we'll be using in the end.
> It's quite probable that the first upstream user of FLB will use this exa=
ct
> API, but chances are that it will require adjustments to "the real life".
>
> It does look sane, but without an actual user (sorry, but the test does n=
ot
> count) it's hard to anticipate the potential required changes and potenti=
al
> corner cases.
>
> Let's hold FLB until it can be actually consumed by HugeTLB or VFIO or
> IOMMU.

Ok

> > > I think it should stay in mm-nonmm-unstable if Andrew does not mind k=
eeping
> > > it there until the first user is going to land and then FLB will move
> > > upstream along with that user.
> >
> > My reasoning for pushing for inclusion now is that there are many
> > developers who currently depend on the FLB functionality. Having it in
> > a public tree, preferably upstream, or at least linux-next, would be
> > highly beneficial for their development and testing.
> >
> > However, to avoid blocking the entire series, I am going to move the
> > FLB patch and the in-kernel test patch to be the last two patches in
> > LUOv7.
> >
> > This way, the rest of the LUO series can be merged without them if
> > they are blocked, however, in this case it would be best if the two
> > FLB patches stayed in mm tree to allow VFIO/IOMMU/PCI/HugeTLB
> > preservation developers to use them, as they all depend on functional
> > FLB.
>
> That's pretty much what I'm suggesting just without "if they are blocked"=
 :)

SGTM

>
> > Pasha
>
> --
> Sincerely yours,
> Mike.
>


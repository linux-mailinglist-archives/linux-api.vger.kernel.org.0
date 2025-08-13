Return-Path: <linux-api+bounces-4461-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D781B24AEE
	for <lists+linux-api@lfdr.de>; Wed, 13 Aug 2025 15:46:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6A6E5A0A70
	for <lists+linux-api@lfdr.de>; Wed, 13 Aug 2025 13:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C849A2EAD18;
	Wed, 13 Aug 2025 13:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="b2lqj+QS"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63C112EACE1
	for <linux-api@vger.kernel.org>; Wed, 13 Aug 2025 13:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755092551; cv=none; b=F4jZiDcYehpRv1ckHvtJdelhLIRZaEkssb6dULgQOoI20MGnohv3tk9PqcNsaXOGIwJeXjKKDNNQNQ/apmdXT1rxyuO0zQABp92HfMJ33/KLyY3C/bZIF/BzENzMzcAX6lydl4ItfOYMTxBTQ0m+bAL11gpGR4agM3ER8GaVOJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755092551; c=relaxed/simple;
	bh=79L6nL2lVlR1vgW7gSeFO1OcMuOBtdLGT/Ddk5toK1k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dQIpVqrDcGXPRHFVn8cEoi6U7LN4fTd0RapqWdubB2cd+VIQwyEB8zKrwNrDkN6pp/xy4eQshK4YL+siNJNTJhkB/Ilu9kW+SRcPtFrBpE0CQZNcEQxQW40zD+qb5uH1Dl4XYvWu4mWLl0PRcEoy/OMzUA3qnP5kCeH+TqAbGWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=b2lqj+QS; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4aeb5eb611bso65236891cf.1
        for <linux-api@vger.kernel.org>; Wed, 13 Aug 2025 06:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1755092548; x=1755697348; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NX7QgU4RYkpyaIY+9NdW+KbcJXzTDUdRfjFR9v7XueI=;
        b=b2lqj+QS4h1kd0qlevn3j1+XnXmsh9SieGN33Ia8fu0zm3Gs0St7ghhxNTyh7wT0HL
         2ECcVY1r8tPzLot215SnRzvwxu/Fr9i8oubGC3OMsnfJI6Xva1WRln0vxcmvK9CgIJ4F
         dDnsm7lG6300bCs+1xYTr5OKpkCVg0uPtAfhHGBFvQsbIkDl03mQ6Gxv8ehjtFQ7pQ90
         Of33C8zSKqyYQnKF9OgBC1hav2VXJKmdjEKAgny4j+QzpeLoyFlnJxc6Xw7EYWyZtUJm
         hbYSQJ1kDrmMGfsiXzAmsMRiS8B0SS7GrgF5xC/eoPDu7ROHmJSXroFXCgwsidGSejCn
         BSmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755092548; x=1755697348;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NX7QgU4RYkpyaIY+9NdW+KbcJXzTDUdRfjFR9v7XueI=;
        b=TeioaS9xwQdXbJSm+B9+8YeYvyKIa2pqdrYd6b9n70We1knJmH9ci+u3dXdBZ0vc2r
         u0mU1arh0bnv8YK1VAx0XhhHoyT248piNCWDbms0EiI9M3blcvzgkGuKe83fh3t6yUr9
         kJTsWMQm8ciUzamL8fKtHQek8irTvbvVY8MXE3tNcoyqFxnvYqLk6YX3AZWSabe4GcDe
         u0IYN2z7dr5Yt5jSEFIukC1tTm8GgLXmld28sbKlBV9WbSb11WB92l+ukW8GZlhxFvnO
         UVL46OcPIQP4NsmyKPUj1C3ww23AYY0sl03ByAMf8vhkDPYo/B+3ZthTmo6/8FGRp7X6
         Yg0A==
X-Forwarded-Encrypted: i=1; AJvYcCV/PhL2eoe69i9VT39FhJSK8OGZcIhmO1dQbNInOVusZTQqbBlwh6WgVX5LIXnwKHqCluZ8EgHLvaM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTFVntth6ldcuqS/lm87uOsdUZKoDwoXX/dEuVUJ+NkbnPmj3c
	AsPaclfy8V5+shVNjHinuqGaBkrHywPz4FcSYpGsrCkKg7J4GkyTMxamCSgxb/YWiJqPO6YhGiu
	+Sz8PcISkkZdCTLPRkypHrC1XlBxof71UVFcg+3YeFg==
X-Gm-Gg: ASbGncuUC3nAyDRd9FmxjMpK7WoIE5lxDCWc0vA46UpKpoq5QoSEcFGt7OTAWGO9jJk
	3cMrqdtn1VJ2Q5epTezloAw1Vg910Iz7EkDiYEEacEMhjlzrKeZ6Nsa3v3yGtOgnVm/hhzV96jZ
	DyXTepOKwc2lkOs54QgV23mj2tR3Vaas61yNFAo1rjKcevhoCCfQn8qLTx5RkVxCHA+PDLdf3d1
	eab
X-Google-Smtp-Source: AGHT+IGLfaaQwFEY+EAD7Oyb3ssHwz9Mxecc5gc1KtJUOKANujOZKp0yfy7BpGqxCbIGhcOB/MMwQSa7HBfsw+eWd5U=
X-Received: by 2002:a05:622a:1f09:b0:4b0:86b4:2513 with SMTP id
 d75a77b69052e-4b0fc70ed8fmr45524721cf.26.1755092547727; Wed, 13 Aug 2025
 06:42:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250807014442.3829950-1-pasha.tatashin@soleen.com>
 <20250807014442.3829950-30-pasha.tatashin@soleen.com> <20250813063407.GA3182745.vipinsh@google.com>
 <2025081310-custodian-ashamed-3104@gregkh> <mafs01ppfxwe8.fsf@kernel.org>
 <2025081351-tinsel-sprinkler-af77@gregkh> <20250813124140.GA699432@nvidia.com>
 <2025081334-rotten-visible-517a@gregkh> <mafs07bz7wdfk.fsf@kernel.org>
In-Reply-To: <mafs07bz7wdfk.fsf@kernel.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Wed, 13 Aug 2025 13:41:51 +0000
X-Gm-Features: Ac12FXxwYgoxAEMomw-_iEhgQJ-Al-xyM3lcJTz2IeukxaEHZZmWI0qPQ6BAJJ8
Message-ID: <CA+CK2bDs9prKNSo=Ris-L7T43ZFU7ji3cBH3KD1=FxXg7hFbFA@mail.gmail.com>
Subject: Re: [PATCH v3 29/30] luo: allow preserving memfd
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Greg KH <gregkh@linuxfoundation.org>, Jason Gunthorpe <jgg@nvidia.com>, 
	Vipin Sharma <vipinsh@google.com>, jasonmiu@google.com, graf@amazon.com, 
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
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, rafael@kernel.org, 
	dakr@kernel.org, bartosz.golaszewski@linaro.org, cw00.choi@samsung.com, 
	myungjoo.ham@samsung.com, yesanishhere@gmail.com, Jonathan.Cameron@huawei.com, 
	quic_zijuhu@quicinc.com, aleksander.lobakin@intel.com, ira.weiny@intel.com, 
	andriy.shevchenko@linux.intel.com, leon@kernel.org, lukas@wunner.de, 
	bhelgaas@google.com, wagi@kernel.org, djeffery@redhat.com, 
	stuart.w.hayes@gmail.com, lennart@poettering.net, brauner@kernel.org, 
	linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, saeedm@nvidia.com, 
	ajayachandra@nvidia.com, parav@nvidia.com, leonro@nvidia.com, witu@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 13, 2025 at 1:37=E2=80=AFPM Pratyush Yadav <pratyush@kernel.org=
> wrote:
>
> On Wed, Aug 13 2025, Greg KH wrote:
>
> > On Wed, Aug 13, 2025 at 09:41:40AM -0300, Jason Gunthorpe wrote:
> [...]
> >> Use the warn ons. Make sure they can't be triggered by userspace. Use
> >> them to detect corruption/malfunction in the kernel.
> >>
> >> In this case if kho_unpreserve_folio() fails in this call chain it
> >> means some error unwind is wrongly happening out of sequence, and we
> >> are now forced to leak memory. Unwind is not something that userspace
> >> should be controlling, so of course we want a WARN_ON here.
> >
> > "should be" is the key here.  And it's not obvious from this patch if
> > that's true or not, which is why I mentioned it.
> >
> > I will keep bringing this up, given the HUGE number of CVEs I keep
> > assigning each week for when userspace hits WARN_ON() calls until that
> > flow starts to die out either because we don't keep adding new calls, O=
R
> > we finally fix them all.  Both would be good...
>
> Out of curiosity, why is hitting a WARN_ON() considered a vulnerability?
> I'd guess one reason is overwhelming system console which can cause a
> denial of service, but what about WARN_ON_ONCE() or WARN_RATELIMIT()?

My understanding that it is vulnerability only if it can be triggered
from userspace, otherwise it is a preferred method to give a notice
that something is very wrong.

Given the large number of machines that have panic_on_warn, a reliable
kernel crash that is triggered from userspace is a vulnerability(?).

Pasha

>
> --
> Regards,
> Pratyush Yadav


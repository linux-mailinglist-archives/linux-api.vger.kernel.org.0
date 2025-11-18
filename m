Return-Path: <linux-api+bounces-5362-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id CA38BC6A6A0
	for <lists+linux-api@lfdr.de>; Tue, 18 Nov 2025 16:52:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BD2133455DC
	for <lists+linux-api@lfdr.de>; Tue, 18 Nov 2025 15:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE74F368271;
	Tue, 18 Nov 2025 15:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="eun+AmGv"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A615368264
	for <linux-api@vger.kernel.org>; Tue, 18 Nov 2025 15:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763480837; cv=none; b=hFXijgDH4CLRu73Wun1gw1jl+QGuFpNXrbsxqLLZ3n2zmokM2hZbJ9AhB/RQ19WDwHDjdcirEMZFXCb6J554nOHKc8eTVriSxlb0lQIsXduZ8Cj81GywE3QRE4kGwPm4aJij6txNUw7JhxDpcGjAj2Ugmcvf7xl/0bjQ2pCsYXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763480837; c=relaxed/simple;
	bh=ZSit9q9L9b/5E+Zs8jJoiIuLjTbwdZ6FtiEGsvw8Sos=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J+PLorr+xASDrsnVPsOV1MipU72mlsMSzZR7rbJCsfDuHCTFAlnTMFh6KP+OImzFTguvwnQETrX+zOaNfuIu02ebXNfYYetVxEWpF6SYbSeDNPhc73YEfJV87HtHWFHSY+qR7482KXtFlvwY+ZM1eTh97bK3q33yBXU0rYRas60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=eun+AmGv; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-64162c04f90so9022809a12.0
        for <linux-api@vger.kernel.org>; Tue, 18 Nov 2025 07:47:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1763480834; x=1764085634; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZSit9q9L9b/5E+Zs8jJoiIuLjTbwdZ6FtiEGsvw8Sos=;
        b=eun+AmGvOpw0aPHJ92dR3mvU7aBmEP1wL43TgLu/vJ1c91YXgrGUwQNhAbTxMGYrIU
         BQfDaJ6Qfgiku7q2IvVqY1SzzcDfxX/ctIJxQCh5bCpM3PSTS29VUH1g3FxBbY6XHY5L
         vp4IaLmVXMcY6l21VxJAElhStIM6L7BDdn3AeKOHODp7BqIsmsXalgNr5NK9A+gt0HKa
         33PdHuCoje+K7nEd+z6SVFQp6uAWdLPsD2Ev713tUZ0SxWVYRRjNufOFW/IlgvvYfWZe
         Dre3ljKZ4RlxizZRkxjDoeYPeO/IgVwLGHqcpFBnbOzNWO325A0GC/x9z701cr+O9RGT
         ULgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763480834; x=1764085634;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZSit9q9L9b/5E+Zs8jJoiIuLjTbwdZ6FtiEGsvw8Sos=;
        b=NT6OwhpP+UMXLIzDmRdXLb9q5+lYkNFXjm2UBh+cYz1cLhPdZOCkSAqC/HZRX37sWd
         9uuDEocfITk3zxgdFke1oJ9sU5Aa8pURC1yv88L/+q8Xl/BzvP0HNknVt1OZYH8JPfLt
         eC2vkuLBEtcGDiBTkNf/AU9mTdpyE5z1A8e5By9CYYHtDpURFsbO6CqZ17cRwgCFMx2u
         cwomkNDRGXyepVSsu0L/b6hh+1eyQrf4d+YXqRnnZLb2mZPAoiXKA1RHVZAKl+Y/LM5g
         Kx5ejT7/meqNPhZBsFBg1IgEdppXn7huMrrGk8BSaS0ocVV0EUYL7SsSsahSXpBlmok4
         orng==
X-Forwarded-Encrypted: i=1; AJvYcCVYX7hNhywz2CDmHzSxxtwBJc9vnq5a4ljewwqUS3zbrXCb3GB/8xTr8IyfM6gcHclpelbefhWdqHI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9u0C/Jn3oQ9HowXSFGHHF9god6SNRb8NtALx66CAjLohRn41F
	t0hGo81ET5S+1qZ4ZZJ26F4yxMAc70Zwf21sV8sXdcmPbIGBSPcrymmP5dFmLd8ygmJmX5Gkf18
	Kwl7bUKeJceR+V2fobeGivbDQYVz0lmStqe4IVwoBsQ==
X-Gm-Gg: ASbGncssdwlHKZPRHaPIINelc9fBqhfZI6vw5g64LyAWR7mV2mlm7jGCHZ7FVCVOidF
	amNmDg5rFAv2wr+23LWYyWqAgbMPsm5YFq3vJgV1rQp/5cgvcXjmDHz08cxFR5f0vclbQvVpe42
	hqIOaEjPnV0u3tLrmHktpOlwwEbCmIhK6tujDebq7JbTzUMZFdidWS3V96k5qhokHRD4CQ9GdVy
	YmIwUEGv6k9vAeCsZ96dqFRRnxqbOxWEAffXaIG9GDf5FL857O9LHVfSbn55m2K220Qtv3R2e9i
	YzY=
X-Google-Smtp-Source: AGHT+IFl4FaDFqzlx6bWBXZq0K6NpC2OdnYDHICZqNqSZXVeIXY6NixyhYod+1/BeWpybcUus0n1F+KTrSDNCoyB1KE=
X-Received: by 2002:a05:6402:5c8:b0:641:5bb9:fdfb with SMTP id
 4fb4d7f45d1cf-64350e9d8acmr13722597a12.33.1763480833517; Tue, 18 Nov 2025
 07:47:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aRnG8wDSSAtkEI_z@kernel.org> <CA+CK2bDu2FdzyotSwBpGwQtiisv=3f6gC7DzOpebPCxmmpwMYw@mail.gmail.com>
 <aRoi-Pb8jnjaZp0X@kernel.org> <CA+CK2bBEs2nr0TmsaV18S-xJTULkobYgv0sU9=RCdReiS0CbPQ@mail.gmail.com>
 <aRuODFfqP-qsxa-j@kernel.org> <CA+CK2bAEdNE0Rs1i7GdHz8Q3DK9Npozm8sRL8Epa+o50NOMY7A@mail.gmail.com>
 <aRxWvsdv1dQz8oZ4@kernel.org> <20251118140300.GK10864@nvidia.com>
 <aRyLbB8yoQwUJ3dh@kernel.org> <CA+CK2bBFtG3LWmCtLs-5vfS8FYm_r24v=jJra9gOGPKKcs=55g@mail.gmail.com>
 <20251118153631.GB90703@nvidia.com>
In-Reply-To: <20251118153631.GB90703@nvidia.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Tue, 18 Nov 2025 10:46:35 -0500
X-Gm-Features: AWmQ_blpsIaa7po7XSkrfRCPIMZ4WBj-h08xugNazGwsDJ_E9pCQg-N3cDPVz28
Message-ID: <CA+CK2bC6sZe1qYd4=KjqDY-eUb95RBPK-Us+-PZbvkrVsvS5Cw@mail.gmail.com>
Subject: Re: [PATCH v6 02/20] liveupdate: luo_core: integrate with KHO
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Mike Rapoport <rppt@kernel.org>, pratyush@kernel.org, jasonmiu@google.com, 
	graf@amazon.com, dmatlack@google.com, rientjes@google.com, corbet@lwn.net, 
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
	saeedm@nvidia.com, ajayachandra@nvidia.com, parav@nvidia.com, 
	leonro@nvidia.com, witu@nvidia.com, hughd@google.com, skhawaja@google.com, 
	chrisl@kernel.org
Content-Type: text/plain; charset="UTF-8"

> > This won't leak data, as /dev/liveupdate is completely disabled, so
> > nothing preserved in memory will be recoverable.
>
> This seems reasonable, but it is still dangerous.
>
> At the minimum the KHO startup either needs to succeed, panic, or fail
> to online most of the memory (ie run from the safe region only)

Allowing degrade booting using only scratch memory sounds like a very
good compromise. This allows the live-update boot to stay alive as a
sort of "crash kernel," particularly since kdump functionality is not
available here. However, it would require some work in KHO to enable
such a feature.

> The above approach works better for things like VFIO or memfd where
> you can boot significantly safely. Not sure about iommu though, if
> iommu doesn't deserialize properly then it probably corrupts all
> memory too.

Yes, DMA may corrupt memory if KHO is broken, *but* we are discussing
broken LUO recovering, the KHO preserved memory should still stay as
preserved but unretriable, so DMA activity should only happen to those
regions...

Pasha

>
> Jason


Return-Path: <linux-api+bounces-5349-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3181FC673E5
	for <lists+linux-api@lfdr.de>; Tue, 18 Nov 2025 05:23:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B6B8B4E2CFE
	for <lists+linux-api@lfdr.de>; Tue, 18 Nov 2025 04:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 557FA285C80;
	Tue, 18 Nov 2025 04:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="Ncs1zvpk"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 847891D88AC
	for <linux-api@vger.kernel.org>; Tue, 18 Nov 2025 04:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763439814; cv=none; b=LIMd5F0xu7kLiJrn6b/W6Aplez419SEFBZRNOYAdCX9iEAA3t0+S3IYjetStz0HanVXBJ9gEZItAKNxlU1FVAjhpM95whTA4bYr3mAkPbvIZAmf6YLTnnFS7TUjrEmiIn2FdBqZAYHidZhzE+1q/m1s/phg1xHxsxJyXXtCYHZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763439814; c=relaxed/simple;
	bh=yHOZfK0pWU/GvMRSsb/xaHbV4r5va663wkrxdVP9VvY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jLbvE/Bq77k2/Fs46/jtzXE29fitaIDudTHqe3ydjqh5nSrnweGmuaLSjjnC2QwhrU4wLGpTTd+qVW++/7aAFUQTCb1bY2FvPudC/7QzJ2a+ZMbe1DMab8foMYojrc71xHZ1CXSotcf0rMtzh64wfPr3HBXCFlJfrGo5UkSyTWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=Ncs1zvpk; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6419aaced59so6853907a12.0
        for <linux-api@vger.kernel.org>; Mon, 17 Nov 2025 20:23:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1763439811; x=1764044611; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yHOZfK0pWU/GvMRSsb/xaHbV4r5va663wkrxdVP9VvY=;
        b=Ncs1zvpkoQyBjEEPlcBVK7x6tqaMkk+Tyr2e8gKH4v79eq7IPiONZeN/xGnVASF3qc
         1Sa2ixZ+vSkBv8Zp9f1E0ZEgD7N5J5+SIHBlk0ojCPyD6aoK5O3wrZt6DMDYG3/YqLgd
         uR+WmibXr15R6jiuP1FrFxX2t98ISFIKGoD7WNInMXqAkl2V23Fq9ss1AZ993EPtGSlk
         VO8l2xJr1RdopwMRlYkDIKRxpJGY9LHBmkWDOzkJgDZ1uV7C2iSYpzGY+fkMUPcVko4j
         y8PBk77GfKeswNnW4vcUtLk4vvCsaUcm8OD24/bhIxBqSBBU4muX3Ys3bwhT3VjQZxp7
         GQ2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763439811; x=1764044611;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yHOZfK0pWU/GvMRSsb/xaHbV4r5va663wkrxdVP9VvY=;
        b=fwdPHu2ekWNNLysJ9AXtVGsFABITsTuDZl9pAxQii6Gdr3p6UFuxHqdegVSFJfSg7Z
         99hLwm93rKB4WSm89RhijWzlOTu6a/uTsam4u8aZMs85DavfpZueYwaN6greVV1fpBGt
         mMxEC/9pNIfm/kVrp6FoY+anvRTvCuVoetaRaBxK1Ncz6XM60parxfIEbblw8JN+r/a2
         DV2sAotVapGzubSRXZZZAk8LUDfwz7KOZYIUhLbaTSb0lnPrzMnp1eokGUdQl9dPuxUZ
         SE+ibuKFwJdyf877SKe32YhvcHiBsCdFWpO6WANK3KpRo4zAbdNx8A842vjUI/bRdqVh
         QqPQ==
X-Forwarded-Encrypted: i=1; AJvYcCW/jwBBN5IpkNSi3HHE5RRCfrCPUp/1iil1oRM3v1TzJsOC5+XdSoSpWLx+W8e4S3mWjCGphxlUT7g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOsvBvtu5Cm/ijLHuI+szwP/OHCzD+yPx/gW6AaGswWSIyzbKE
	8An27xSsEj9mNXx4DYMJ2TXbfxK0XE2+nGPgzxnKdxEcDKzZeazlnJFKraRrbeeYwibgvr/KCdR
	j3fmm5gSxkoqThwPZXBq/jUSHoJBhu7pu6TLAWNQHig==
X-Gm-Gg: ASbGncv3eLNPPSpjh/zDqfsycxhYCHLalIlKwRNJcWO2Uop/Qz6JVO/0/ZML1k9627p
	Fb1uNpKy7mn1OI/9+jl/m/QETdhCpQP8TwEIHlOjcuIIicJLhqWOTd+m67xO0sC183wMM+/pXgW
	dra+0A6Cn9y7WCZYJzgAP7dfFONe/dKeWbHChR1LvTNdtQ+jcLp+HDXV2DlXBdMazQd0QJ8Kffe
	Q8um4EIfeWayP5lGEU6xKe9HIYXJDN/xZtdtYhfi0Wh9RwfhGU5auNy5tB62SrQnjrjPCT6L8r/
	OqI=
X-Google-Smtp-Source: AGHT+IHcXQAOPbW77p032BCA1yf03kdrt9TXEreALO4fe3G9Md4L5c16ZrMCE1/XunuQOVa5pqVrU/kpO2uPmj8xqWM=
X-Received: by 2002:a05:6402:3508:b0:640:c849:cee3 with SMTP id
 4fb4d7f45d1cf-64350ec18a5mr12648190a12.34.1763439810816; Mon, 17 Nov 2025
 20:23:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251115233409.768044-1-pasha.tatashin@soleen.com>
 <20251115233409.768044-3-pasha.tatashin@soleen.com> <aRnG8wDSSAtkEI_z@kernel.org>
 <CA+CK2bDu2FdzyotSwBpGwQtiisv=3f6gC7DzOpebPCxmmpwMYw@mail.gmail.com>
 <aRoi-Pb8jnjaZp0X@kernel.org> <CA+CK2bBEs2nr0TmsaV18S-xJTULkobYgv0sU9=RCdReiS0CbPQ@mail.gmail.com>
 <aRuODFfqP-qsxa-j@kernel.org>
In-Reply-To: <aRuODFfqP-qsxa-j@kernel.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Mon, 17 Nov 2025 23:22:54 -0500
X-Gm-Features: AWmQ_bmu9XJ4F2q03zVpJ7QCWl2e5iEfuoUmDpvTnYNqaWiEdVtcHIOkeQ1NtZs
Message-ID: <CA+CK2bAEdNE0Rs1i7GdHz8Q3DK9Npozm8sRL8Epa+o50NOMY7A@mail.gmail.com>
Subject: Re: [PATCH v6 02/20] liveupdate: luo_core: integrate with KHO
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

> You can avoid that complexity if you register the device with a different
> fops, but that's technicality.
>
> Your point about treating the incoming FDT as an underlying resource that
> failed to initialize makes sense, but nevertheless userspace needs a
> reliable way to detect it and parsing dmesg is not something we should rely
> on.

I see two solutions:

1. LUO fails to retrieve the preserved data, the user gets informed by
not finding /dev/liveupdate, and studying the dmesg for what has
happened (in reality in fleets version mismatches should not be
happening, those should be detected in quals).
2. Create a zombie device to return some errno on open, and still
study dmesg to understand what really happened.

I think that 1 is better

Pasha


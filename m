Return-Path: <linux-api+bounces-5275-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A8B22C5DBAF
	for <lists+linux-api@lfdr.de>; Fri, 14 Nov 2025 16:04:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A7E0F4FA167
	for <lists+linux-api@lfdr.de>; Fri, 14 Nov 2025 14:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93A153271E1;
	Fri, 14 Nov 2025 14:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="Y5Z6+vjF"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A63E2116F4
	for <linux-api@vger.kernel.org>; Fri, 14 Nov 2025 14:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763131753; cv=none; b=dPXjGnzVrUVFDq+QH2jEn8V/2jrE5mnfUvoAP/LTBu46p2PzzQ5iEFMmJf2YkiGOcacLSCebOR1CzYl5Zi5MU7ywqQrUbUBbuDZwZAEYUdNb88e/IARS30H6o5WevLIVpM3QuOvvwhjiCGI4OpOUMmsoyddGjVrPo+8ne3H3EUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763131753; c=relaxed/simple;
	bh=yKj8YKn4bG73S711v2EqDY1AhzbG3apkJ7Pfze5Fg6A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oXjM3uS1PJNZ38P1NlUVyT2QOkYP6i7uy9siJNYOmCqYOOcJ2gD8aZBEC1XWUgryxK0TTwrpCGSeU7pjwHrXrNjeqQm1JI+d0ar5osMv2ZshYv8ndX9xoAaQKXWvXb1PcEgbJagTxNtX/Aci6rDHAUuCxk0GxWG9ZVR9c3p28hQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=Y5Z6+vjF; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-640b0639dabso3624520a12.3
        for <linux-api@vger.kernel.org>; Fri, 14 Nov 2025 06:49:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1763131750; x=1763736550; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QYEAXpQ4a552Nj/Tapn49whjWroq5jBGQBSgz6ETKNI=;
        b=Y5Z6+vjFPv1/p/nR+ohTtWyzvDWIPRs/B7urW8j5uI+JhJ2ps7AbJ8yuGdbudg2htE
         3sxWPSjwRbXc4wer797ugPtVpC7eKHFqUGZD99vh988xBpKXDWNh+4KueVk0kY2C8NDa
         ZCB+00FIG/VHRfFG8FQgayvQroGybNbmwiILrBEaNEcW7Bt6TONMvDPGXk93tF1awlSJ
         frtKq1f5uOrmvyYEROA/m7Q4ULP/XQhmKwWQ07gnbT5o/fgBfUtspWXxuJ7ZIJ6DNSOF
         Ge4CO+6YP0m3n+n4+yxlu4d/G2c2gzPA/uagVgl+DLFp1csYffujlUoHfoAzbRHdl/46
         xCIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763131750; x=1763736550;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QYEAXpQ4a552Nj/Tapn49whjWroq5jBGQBSgz6ETKNI=;
        b=JvHdWxK10O9qGcGhu9sGR/Nq7mKG5gAHfz9nfHPHWp0gLF5UvBkKo3ADpQalgLhSnS
         HMPBn8ETTKl1bV4lGCU/wzR4tWGbk6i6g7GKWBoRtbDubHGyYj8PU6ISpBV4NRaxsqxr
         TuhvsI43jHGOIGU3MyejJZM6CmiV6Ubwo8+6AOmrtzRhP3V0CLVu1gjBCItMV3ilJN45
         a6XR5V4IoC+RUkKAcP9XCZrCW620Q6kohHeOmG7doWQMN20SFIgTb/jxGXo98mq/euM7
         mhFLHGxfkmyVTbjc9KPfnXOykNLX4ejXMM7iPMFiKpiEe5UfD3eFDqaiLjTX/WHCnTLT
         Om6g==
X-Forwarded-Encrypted: i=1; AJvYcCWaT1Z4NBdreVTSWnDLpOjVjM8hpSfqp1vuU2ddWLUCa1/2uOC2FEx7vFeoiNBDcL4pcaqTK0Nhsws=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxqpn/nwDGMQG9hhNqU1cehTX+KPFOX7mCp7/BjPD3n4yL01XdD
	/jRWyGt5MVBT9xMrJTyeXml249+DSzzJCs373eyX/i8281Sv2Hn3ABocsiBs8gidssMQRXOY7E+
	ihBduEkPuPcaJrkR7OscINnBN3tA5J4wyZab75B6Jzg==
X-Gm-Gg: ASbGnct1WkhwZ1oHIYkAoAY6MjNssjqxBDh4NJwwdEIyRCIRA4KuErdKctVzV0CHX7V
	SBlkNkqCcUwiXEk1EoYYeYhhL8xSABOo3amGIceVBBfREq6MRNamaVpD7g+YBnZtCdjwIDKl31D
	+2ylw85NwL9qD7zTY/4yZ8dVW3p09BehtkIq4UaelBUf9aWlYnOnFpZRGLzPEkcLvbw4vx43vJx
	HtzARDEDqsapeYsoGhqq2TaKSKf0E5KJu/8jzet+kIcMDnDK9Todb6ItYkzXvj0vDuT
X-Google-Smtp-Source: AGHT+IHF8MqvIeu6twye/eYx/FuUCbRP62c2HbXTtkjoVGfiBHyEq0ZpwisfIJrVT6Hu103fGvqOuZ0WbhmUHmm+4tw=
X-Received: by 2002:a05:6402:5341:20b0:640:ccb0:f4da with SMTP id
 4fb4d7f45d1cf-64350e9ff6dmr2279684a12.29.1763131749850; Fri, 14 Nov 2025
 06:49:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251107210526.257742-1-pasha.tatashin@soleen.com>
 <20251107210526.257742-3-pasha.tatashin@soleen.com> <aRcSpbwBabFjeYe3@kernel.org>
In-Reply-To: <aRcSpbwBabFjeYe3@kernel.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Fri, 14 Nov 2025 09:48:33 -0500
X-Gm-Features: AWmQ_bm03KKG3xgTX39tlkUT5awfMY0ljNHpMhWuof0QVJ12PZgKUmkaxYYGwgY
Message-ID: <CA+CK2bDzExcm-1LMFFQ4FgyfX5yuaPBd2fXdbNsd2yTbrSNKog@mail.gmail.com>
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

On Fri, Nov 14, 2025 at 6:30=E2=80=AFAM Mike Rapoport <rppt@kernel.org> wro=
te:
>
> On Fri, Nov 07, 2025 at 04:03:00PM -0500, Pasha Tatashin wrote:
> > Integrate the LUO with the KHO framework to enable passing LUO state
> > across a kexec reboot.
> >
> > When LUO is transitioned to a "prepared" state, it tells KHO to
> > finalize, so all memory segments that were added to KHO preservation
> > list are getting preserved. After "Prepared" state no new segments
> > can be preserved. If LUO is canceled, it also tells KHO to cancel the
> > serialization, and therefore, later LUO can go back into the prepared
> > state.
> >
> > This patch introduces the following changes:
> > - During the KHO finalization phase allocate FDT blob.
> > - Populate this FDT with a LUO compatibility string ("luo-v1").
> >
> > LUO now depends on `CONFIG_KEXEC_HANDOVER`. The core state transition
> > logic (`luo_do_*_calls`) remains unimplemented in this patch.
> >
> > Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> > ---
> >  include/linux/liveupdate.h         |   6 +
> >  include/linux/liveupdate/abi/luo.h |  54 +++++++
> >  kernel/liveupdate/luo_core.c       | 243 ++++++++++++++++++++++++++++-
> >  kernel/liveupdate/luo_internal.h   |  17 ++
> >  mm/mm_init.c                       |   4 +
> >  5 files changed, 323 insertions(+), 1 deletion(-)
> >  create mode 100644 include/linux/liveupdate/abi/luo.h
> >  create mode 100644 kernel/liveupdate/luo_internal.h
> >
> > diff --git a/include/linux/liveupdate.h b/include/linux/liveupdate.h
> > index 730b76625fec..0be8804fc42a 100644
> > --- a/include/linux/liveupdate.h
> > +++ b/include/linux/liveupdate.h
> > @@ -13,6 +13,8 @@
> >
> >  #ifdef CONFIG_LIVEUPDATE
> >
> > +void __init liveupdate_init(void);
> > +
> >  /* Return true if live update orchestrator is enabled */
> >  bool liveupdate_enabled(void);
> >
> > @@ -21,6 +23,10 @@ int liveupdate_reboot(void);
> >
> >  #else /* CONFIG_LIVEUPDATE */
> >
> > +static inline void liveupdate_init(void)
> > +{
> > +}
>
> The common practice is to place brackets at the same line with function
> declaration.

Sure.

>
> ...
>
> > +static int __init luo_early_startup(void)
> > +{
> > +     phys_addr_t fdt_phys;
> > +     int err, ln_size;
> > +     const void *ptr;
> > +
> > +     if (!kho_is_enabled()) {
> > +             if (liveupdate_enabled())
> > +                     pr_warn("Disabling liveupdate because KHO is disa=
bled\n");
> > +             luo_global.enabled =3D false;
> > +             return 0;
> > +     }
> > +
> > +     /* Retrieve LUO subtree, and verify its format. */
> > +     err =3D kho_retrieve_subtree(LUO_FDT_KHO_ENTRY_NAME, &fdt_phys);
> > +     if (err) {
> > +             if (err !=3D -ENOENT) {
> > +                     pr_err("failed to retrieve FDT '%s' from KHO: %pe=
\n",
> > +                            LUO_FDT_KHO_ENTRY_NAME, ERR_PTR(err));
> > +                     return err;
> > +             }
> > +
> > +             return 0;
> > +     }
> > +
> > +     luo_global.fdt_in =3D __va(fdt_phys);
>
> phys_to_virt is clearer, isn't it?

Sure

>
> > +     err =3D fdt_node_check_compatible(luo_global.fdt_in, 0,
> > +                                     LUO_FDT_COMPATIBLE);
>
> ...
>
> > +void __init liveupdate_init(void)
> > +{
> > +     int err;
> > +
> > +     err =3D luo_early_startup();
> > +     if (err) {
> > +             pr_err("The incoming tree failed to initialize properly [=
%pe], disabling live update\n",
> > +                    ERR_PTR(err));
> > +             luo_global.enabled =3D false;
> > +     }
> > +}
> > +
> > +/* Called during boot to create LUO fdt tree */
>
>                          ^ create outgoing

OK

>
> > +static int __init luo_late_startup(void)
> > +{
> > +     int err;
> > +
> > +     if (!liveupdate_enabled())
> > +             return 0;
> > +
> > +     err =3D luo_fdt_setup();
> > +     if (err)
> > +             luo_global.enabled =3D false;
> > +
> > +     return err;
> > +}
> > +late_initcall(luo_late_startup);
>
> It would be nice to have a comment explaining why late_initcall() is fine
> and why there's no need to initialize the outgoing fdt earlier.

I will add a comment; basically it is fine because the outgoing data
structures are only used after we enter userspace.

>
> > +/**
> > + * luo_alloc_preserve - Allocate, zero, and preserve memory.
>
> I think this and the "free" counterparts would be useful for any KHO user=
s,
> even those that don't need LUO.

I will move them to KHO.

>
> > + * @size: The number of bytes to allocate.
> > + *
> > + * Allocates a physically contiguous block of zeroed pages that is lar=
ge
> > + * enough to hold @size bytes. The allocated memory is then registered=
 with
> > + * KHO for preservation across a kexec.
> > + *
> > + * Note: The actual allocated size will be rounded up to the nearest
> > + * power-of-two page boundary.
> > + *
> > + * @return A virtual pointer to the allocated and preserved memory on =
success,
> > + * or an ERR_PTR() encoded error on failure.
> > + */
> > +void *luo_alloc_preserve(size_t size)
> > +{
> > +     struct folio *folio;
> > +     int order, ret;
> > +
> > +     if (!size)
> > +             return ERR_PTR(-EINVAL);
> > +
> > +     order =3D get_order(size);
> > +     if (order > MAX_PAGE_ORDER)
> > +             return ERR_PTR(-E2BIG);
>
> High order allocations would likely fail or at least cause a heavy reclai=
m.
> For now it seems that we won't be needing really large contiguous chunks =
so
> maybe limiting this to PAGE_ALLOC_COSTLY_ORDER?

Let's use MAX_PAGE_ORDER for now, my concern is that
PAGE_ALLOC_COSTLY_ORDER too fragile to make it part of ABI. If
allocation fails, the user will have to deal with it, as we return a
proper error code.

> Later if we'd need higher order allocations we can try to allocate with
> __GFP_NORETRY or __GFP_RETRY_MAYFAIL with a fallback to vmalloc.
>
> > +
> > +     folio =3D folio_alloc(GFP_KERNEL | __GFP_ZERO, order);
> > +     if (!folio)
> > +             return ERR_PTR(-ENOMEM);
> > +
> > +     ret =3D kho_preserve_folio(folio);
> > +     if (ret) {
> > +             folio_put(folio);
> > +             return ERR_PTR(ret);
> > +     }
> > +
> > +     return folio_address(folio);
> > +}
> > +
>
> --
> Sincerely yours,
> Mike.


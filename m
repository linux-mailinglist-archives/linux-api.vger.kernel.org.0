Return-Path: <linux-api+bounces-5008-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CBFA9BBECBD
	for <lists+linux-api@lfdr.de>; Mon, 06 Oct 2025 19:22:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 98F514EC550
	for <lists+linux-api@lfdr.de>; Mon,  6 Oct 2025 17:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5794F241690;
	Mon,  6 Oct 2025 17:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="Xt9CEQCE"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E73A23FC49
	for <linux-api@vger.kernel.org>; Mon,  6 Oct 2025 17:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759771322; cv=none; b=kGFkDRXYFjRjC2f17Kqctx2Vq48m0jPRn4R7UQo0PMZI2/1NQaUNb4DKFkVVzN7PG0ORkhnV5bueAgffEQfgjER5oHsmdHIFbeSJEMKUaCXrTNud8Wmdyvzmt0ArMW1zTIX21ejRku429dg4/+qomAEvyfXI6cQ6NaCcpeiMt48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759771322; c=relaxed/simple;
	bh=74DlWy/wZvAW0vbF4XE00zl9RPY5mmo68zzZTKTBqRg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=csaghEEPwNDrxGBmYIVRZFOf/fQ1A/uiZvXYcrHLe5mm3Y4UMFGY5UT6IdwMke3Vwmz0wdeA3ANCe/0iGstUH5+SVlMVwk78hK1D2GiinKdGmNrQuuP6qlzu5zAsHZAGYgoA8lhTQB9td4AjRzHTLu1pPdTZpTaQVhfAGD9T+6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=Xt9CEQCE; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4db0b56f6e7so56250361cf.1
        for <linux-api@vger.kernel.org>; Mon, 06 Oct 2025 10:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1759771319; x=1760376119; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u3CFdIAZSOG3RFljBavldVx+w/X0FNVvOnGYJcNKBpQ=;
        b=Xt9CEQCE3irO+7S8grd2U3oZ3qtW5ufHe3gACzEf2+rosm2fy+Qw9vftIU+I1xDJib
         nwKnv+Z6DP60c/jvkkXpyv5OG+yj2RjzMUHSjVly34SMl8fJaopGrySxoBZ+gCJN4hL0
         3ZRu47tgoqHzLvYVaA8sYr3/Oz/1xtEkRhVqvdC53iOMtpxPIOfVsZcK7iKs65Jn+7BT
         bZi6hmsoZ0f/hWkeno9PVJsN6uhN2f4kQc6XkhJfUgnhSaGltKjiwtcua7wT0ZiGYo5u
         DeLpst1wAvRuMi58k2BcLuKSLgrN9Mm5GVlWvGV0tcIMZnQmAKuxFIL/QGmQV9Yfz8NA
         TK2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759771319; x=1760376119;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u3CFdIAZSOG3RFljBavldVx+w/X0FNVvOnGYJcNKBpQ=;
        b=OQx0C6QJlaa9eV8V6Wki6hB+FQsDflDp5DP8HSfBklDIl/vEd1iaJU2HfXw36SiiLE
         GWiBkaDDxR2H9LFTxUKMFvEoQFnJ90ifX6fxrmdefwkX2mrh0KSGgxrpOPnf0AhKAvhH
         1xShJt+v9BJVwqU95phqYdfelMiZgJHYCxVMZfp8iGKx/GxnNxzLVWnGltDUuebD3IBB
         LqRXOgji3opYyYrabby30LwUO/VOCmxlebjgGNwewjDxra8VxCAdA1Thht6l5bZY2Jed
         Kn0Yb82+kjRFxT/VZ2esESESPeWiTU9llSvzXkcMte/u3vfICvWfIzAgegCL8597YPBI
         vuKw==
X-Forwarded-Encrypted: i=1; AJvYcCUPJXdYD4Ai4Y+3dPDBislFwvRE+/hJlY60xwlP5mdNMRvFMkOZQVFnBsRbgQTdDm2DLIsPWZDxAJI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwS+FhVcvOlrMP32wkgAbennI/x/Htk8tMqY1cIegoIRSUbeut5
	g/2eIPxKFtuFPgpM8qyP1d/Aztmh/ciMdiSwXMdkG7qpmRILthGxJNCsD4K7OCRVGwlJgAWE2sm
	1jQl6ScAy0/Guz15LQjfYyhXpE2fXKLnhdz3GbAC81w==
X-Gm-Gg: ASbGncv5ETdUnFxIIl2BC1JvnC1e0VlL4nat60FNoyaZjAzYVeCVzFxAT2RbNwSdoEH
	twUsgduAOvzRiFO4rDWsZiIj+zKL6w1ikO3VmIJKNH6m8xQIpBkRkop+1kaJO3HNrBhW1xj270r
	rFZ1f/2ghD8iF0zTm5UliFa7imYmVfIrDkMoAepgI3FOO0K3AE5EaxQiX5QE8vMI7SgFnJy1mWu
	85QOjwpSSfAjzVvwc68foHllrfWRWuf/8fLbMo=
X-Google-Smtp-Source: AGHT+IFM2iasjSwevS/Ww6pNuFkpEMTxLK7Q2uZtw02+A+PsxcuVSjzuu+26bSPV3eDsAJn6N8sfkeveM0JOQLoCA2k=
X-Received: by 2002:a05:622a:5815:b0:4df:3139:d204 with SMTP id
 d75a77b69052e-4e6de8027ebmr6622011cf.10.1759771319077; Mon, 06 Oct 2025
 10:21:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250929010321.3462457-1-pasha.tatashin@soleen.com>
 <20250929010321.3462457-4-pasha.tatashin@soleen.com> <mafs0tt0cnevi.fsf@kernel.org>
In-Reply-To: <mafs0tt0cnevi.fsf@kernel.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Mon, 6 Oct 2025 13:21:20 -0400
X-Gm-Features: AS18NWCA17JFqGpyH74v5IB7rQGOnAZUihEDBZQPUG896U4mqGpoALvEdvNdCBg
Message-ID: <CA+CK2bA2qfLF1Mbyvnat+L9+5KAw6LnhYETXVoYcMGJxwTGahg@mail.gmail.com>
Subject: Re: [PATCH v4 03/30] kho: drop notifiers
To: Pratyush Yadav <pratyush@kernel.org>
Cc: jasonmiu@google.com, graf@amazon.com, changyuanl@google.com, 
	rppt@kernel.org, dmatlack@google.com, rientjes@google.com, corbet@lwn.net, 
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
	stuart.w.hayes@gmail.com, lennart@poettering.net, brauner@kernel.org, 
	linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, saeedm@nvidia.com, 
	ajayachandra@nvidia.com, jgg@nvidia.com, parav@nvidia.com, leonro@nvidia.com, 
	witu@nvidia.com, hughd@google.com, skhawaja@google.com, chrisl@kernel.org, 
	steven.sistare@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 6, 2025 at 1:01=E2=80=AFPM Pratyush Yadav <pratyush@kernel.org>=
 wrote:
>
> On Mon, Sep 29 2025, Pasha Tatashin wrote:
>
> > From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> >
> > The KHO framework uses a notifier chain as the mechanism for clients to
> > participate in the finalization process. While this works for a single,
> > central state machine, it is too restrictive for kernel-internal
> > components like pstore/reserve_mem or IMA. These components need a
> > simpler, direct way to register their state for preservation (e.g.,
> > during their initcall) without being part of a complex,
> > shutdown-time notifier sequence. The notifier model forces all
> > participants into a single finalization flow and makes direct
> > preservation from an arbitrary context difficult.
> > This patch refactors the client participation model by removing the
> > notifier chain and introducing a direct API for managing FDT subtrees.
> >
> > The core kho_finalize() and kho_abort() state machine remains, but
> > clients now register their data with KHO beforehand.
> >
> > Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> > Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> [...]
> > diff --git a/mm/memblock.c b/mm/memblock.c
> > index e23e16618e9b..c4b2d4e4c715 100644
> > --- a/mm/memblock.c
> > +++ b/mm/memblock.c
> > @@ -2444,53 +2444,18 @@ int reserve_mem_release_by_name(const char *nam=
e)
> >  #define MEMBLOCK_KHO_FDT "memblock"
> >  #define MEMBLOCK_KHO_NODE_COMPATIBLE "memblock-v1"
> >  #define RESERVE_MEM_KHO_NODE_COMPATIBLE "reserve-mem-v1"
> > -static struct page *kho_fdt;
> > -
> > -static int reserve_mem_kho_finalize(struct kho_serialization *ser)
> > -{
> > -     int err =3D 0, i;
> > -
> > -     for (i =3D 0; i < reserved_mem_count; i++) {
> > -             struct reserve_mem_table *map =3D &reserved_mem_table[i];
> > -             struct page *page =3D phys_to_page(map->start);
> > -             unsigned int nr_pages =3D map->size >> PAGE_SHIFT;
> > -
> > -             err |=3D kho_preserve_pages(page, nr_pages);
> > -     }
> > -
> > -     err |=3D kho_preserve_folio(page_folio(kho_fdt));
> > -     err |=3D kho_add_subtree(ser, MEMBLOCK_KHO_FDT, page_to_virt(kho_=
fdt));
> > -
> > -     return notifier_from_errno(err);
> > -}
> > -
> > -static int reserve_mem_kho_notifier(struct notifier_block *self,
> > -                                 unsigned long cmd, void *v)
> > -{
> > -     switch (cmd) {
> > -     case KEXEC_KHO_FINALIZE:
> > -             return reserve_mem_kho_finalize((struct kho_serialization=
 *)v);
> > -     case KEXEC_KHO_ABORT:
> > -             return NOTIFY_DONE;
> > -     default:
> > -             return NOTIFY_BAD;
> > -     }
> > -}
> > -
> > -static struct notifier_block reserve_mem_kho_nb =3D {
> > -     .notifier_call =3D reserve_mem_kho_notifier,
> > -};
> >
> >  static int __init prepare_kho_fdt(void)
> >  {
> >       int err =3D 0, i;
> > +     struct page *fdt_page;
> >       void *fdt;
> >
> > -     kho_fdt =3D alloc_page(GFP_KERNEL);
> > -     if (!kho_fdt)
> > +     fdt_page =3D alloc_page(GFP_KERNEL);
> > +     if (!fdt_page)
> >               return -ENOMEM;
> >
> > -     fdt =3D page_to_virt(kho_fdt);
> > +     fdt =3D page_to_virt(fdt_page);
> >
> >       err |=3D fdt_create(fdt, PAGE_SIZE);
> >       err |=3D fdt_finish_reservemap(fdt);
> > @@ -2499,7 +2464,10 @@ static int __init prepare_kho_fdt(void)
> >       err |=3D fdt_property_string(fdt, "compatible", MEMBLOCK_KHO_NODE=
_COMPATIBLE);
> >       for (i =3D 0; i < reserved_mem_count; i++) {
> >               struct reserve_mem_table *map =3D &reserved_mem_table[i];
> > +             struct page *page =3D phys_to_page(map->start);
> > +             unsigned int nr_pages =3D map->size >> PAGE_SHIFT;
> >
> > +             err |=3D kho_preserve_pages(page, nr_pages);
> >               err |=3D fdt_begin_node(fdt, map->name);
> >               err |=3D fdt_property_string(fdt, "compatible", RESERVE_M=
EM_KHO_NODE_COMPATIBLE);
> >               err |=3D fdt_property(fdt, "start", &map->start, sizeof(m=
ap->start));
> > @@ -2507,13 +2475,14 @@ static int __init prepare_kho_fdt(void)
> >               err |=3D fdt_end_node(fdt);
> >       }
> >       err |=3D fdt_end_node(fdt);
> > -
> >       err |=3D fdt_finish(fdt);
> >
> > +     err |=3D kho_preserve_folio(page_folio(fdt_page));
> > +     err |=3D kho_add_subtree(MEMBLOCK_KHO_FDT, fdt);
> > +
> >       if (err) {
> >               pr_err("failed to prepare memblock FDT for KHO: %d\n", er=
r);
> > -             put_page(kho_fdt);
> > -             kho_fdt =3D NULL;
> > +             put_page(fdt_page);
>
> This adds subtree to KHO even if the FDT might be invalid. And then
> leaves a dangling reference in KHO to the FDT in case of an error. I
> think you should either do this check after
> kho_preserve_folio(page_folio(fdt_page)) and do a clean error check for
> kho_add_subtree(), or call kho_remove_subtree() in the error block.

I agree, I do not like these err |=3D stuff, we should be checking
errors cleanly, and do proper clean-ups.

> I prefer the former since if kho_add_subtree() is the one that fails,
> there is little sense in removing a subtree that was never added.
>
> >       }
> >
> >       return err;
> > @@ -2529,13 +2498,6 @@ static int __init reserve_mem_init(void)
> >       err =3D prepare_kho_fdt();
> >       if (err)
> >               return err;
> > -
> > -     err =3D register_kho_notifier(&reserve_mem_kho_nb);
> > -     if (err) {
> > -             put_page(kho_fdt);
> > -             kho_fdt =3D NULL;
> > -     }
> > -
> >       return err;
> >  }
> >  late_initcall(reserve_mem_init);
>
> --
> Regards,
> Pratyush Yadav


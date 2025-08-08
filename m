Return-Path: <linux-api+bounces-4398-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18339B1E9C4
	for <lists+linux-api@lfdr.de>; Fri,  8 Aug 2025 16:01:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9156161810
	for <lists+linux-api@lfdr.de>; Fri,  8 Aug 2025 14:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EA3727E7F9;
	Fri,  8 Aug 2025 14:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="fYzyli9L"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAEAD26AC3
	for <linux-api@vger.kernel.org>; Fri,  8 Aug 2025 14:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754661649; cv=none; b=iomgeelcphy66yQQib4mRkNm9PVeIoVZHr6OdB38rS+nrlm+yvspJoQVuXi2FbPZHZ6Y1p65NLKkSByj4Z5CDMxgQKh+3N4l8Bh2y57SpPFVgm/rAEF4Dr7KLhYL1oPGGMvkyJNgGmWuViYhjIbpsklipwG+rNwvwqyWz8DppVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754661649; c=relaxed/simple;
	bh=x4ha9INZKS3qtde5fpadJaWJod/g+Zi1d0xN7YAlf3E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r3SkSaI76oL/muL3b+6e3YKFleAkxadohzZxsKSnYYz4AzaQsRVEO76G4ruFd8TBjZhEA01CV2KCtLFH4aBalsn7U1q9E+Mjfd8I61HUz+ycH8QGt+Ln7sjclT7zF06xkuxUkt7YC7rfNfn7XhQ5mFPDn3S7hnqMKqWBY1spMtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=fYzyli9L; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4b062b6d51aso25834901cf.2
        for <linux-api@vger.kernel.org>; Fri, 08 Aug 2025 07:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1754661645; x=1755266445; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qqINGqOAKkihtWhqv8aP2ZlDWCyF3eZIl3dlPcJlrEs=;
        b=fYzyli9LeJhZI3OL2lOmQmUB/2hupW00LWygDlRVwGMxBR6yau6SZv2gOz0tzUT4ea
         snHxd+H9EFl1H+/X1Kuw/Ay6esXEphiIW0Wea0tYgDRhnyH80AU1JlRrdlnyQFGH5nHQ
         qBXOAOTE7nE66vqCtARk4xwfHgLypH8vftFTfMPNHT+4rD0HNyW2CCJB7skOr4/pZtNV
         r5h6moz4C1iZV/8WF/H2qJoMGWJHm10+N2EdNBQ2C5BLDovti2qlpQwWWf4LSWkFatbg
         CktxOs8XWJC4y8m4FEB8cFeqpPOvpFk4O7UwXT6V0ihyQxWLHFJ25SXcpb9rfinl3Gs7
         AMGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754661645; x=1755266445;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qqINGqOAKkihtWhqv8aP2ZlDWCyF3eZIl3dlPcJlrEs=;
        b=AibwfHZNWohosurQErZ/o2AxxG50A67Jt0FmQ5VmFHCACg4gA8IDA/JdqlIy8Rv2B0
         E03V8X8VTf31QRFoOfnUgvp2y3HpJRD8iUIpQL1h/JKBjesTRfGlHGM587slYSoltVVs
         V2QmP5sSrIl2cdhpU2wuAxK3IBlzTcBgDi/vJ8JXF2Ea35vIH+qvD0yHpqtX69VeExw9
         oE81XRUBqc2AqpgSpNXxQaHx0igrXJ7txZ+l86sS4GSTgXg6ov5XN7WPPFJ/NzQB1qHN
         SGobQ0ZKglqWNKZT7tE0yCieC/82DiMp9tSrqevUNZu3WVn9N6bvHwCq/dMDXdq8jZ7g
         akMQ==
X-Forwarded-Encrypted: i=1; AJvYcCUr1O8J03DuYqihAxPvkOO/268SpjNaiEbHBDTveItUia8UJKYMl1iI6040nXWWXeIs8ojn0TPpVnE=@vger.kernel.org
X-Gm-Message-State: AOJu0YztjRojihKINdDh0ANYBj2biTKiEaKHEGe6tDJIMjsMKzY1rinp
	oA023UXo7t5nFvl9vPym4IxzLYf4EhKDVU+rHUetPoHWbPsazOf86TLjW0ZucVA0aoPisxJDr3Y
	sk84BRo3Lrwnc7DWPgmB6UlkfVUWJHwBt4HBAIJ9Ubw==
X-Gm-Gg: ASbGnctuKZbC1Rgtqx7RjrRkSBTleOo2xGGCA/IesujQqSfXGCRUNb8E7LlGN+zQvEL
	GeuQ8+osT18ONuU+9IbHq9vF7GBbw8mrAOC1jOjTU61tUF6ay69SdynGTcZadOuuks+/ACZIxne
	poNSrEO9yETgZD1mj3HNUMiu/sJInhDsMIBdC7utR+MEQuYEiVovjeBAdUmupdO1N2mXGFQUEE5
	PPT
X-Google-Smtp-Source: AGHT+IGU7X5qeX8OS2DQuYKdpYSGfIFno/a95GYTX1d6NB06BqBHy2416czan27fZPJSukzaA24gTw9e0PS+96Ajhto=
X-Received: by 2002:a05:622a:5a0f:b0:4af:4bac:e523 with SMTP id
 d75a77b69052e-4b0aed0f0e9mr39963141cf.8.1754661645094; Fri, 08 Aug 2025
 07:00:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250807014442.3829950-1-pasha.tatashin@soleen.com>
 <20250807014442.3829950-2-pasha.tatashin@soleen.com> <mafs0o6sqavkx.fsf@kernel.org>
 <mafs0bjoqav4j.fsf@kernel.org>
In-Reply-To: <mafs0bjoqav4j.fsf@kernel.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Fri, 8 Aug 2025 14:00:08 +0000
X-Gm-Features: Ac12FXyA0-d-njVDnQIR5bUTLVyM1KEOMfZexHnLlS_vPOyE1wA5_qbuL5SMqTM
Message-ID: <CA+CK2bBoMNEfyFKgvKR0JvECpZrGKP1mEbC_fo8SqystEBAQUA@mail.gmail.com>
Subject: Re: [PATCH v3 01/30] kho: init new_physxa->phys_bits to fix lockdep
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
	witu@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 8, 2025 at 11:52=E2=80=AFAM Pratyush Yadav <pratyush@kernel.org=
> wrote:
>
> On Fri, Aug 08 2025, Pratyush Yadav wrote:
> [...]
> >> @@ -144,14 +144,35 @@ static int __kho_preserve_order(struct kho_mem_t=
rack *track, unsigned long pfn,
> >>                              unsigned int order)
> >>  {
> >>      struct kho_mem_phys_bits *bits;
> >> -    struct kho_mem_phys *physxa;
> >> +    struct kho_mem_phys *physxa, *new_physxa;
> >>      const unsigned long pfn_high =3D pfn >> order;
> >>
> >>      might_sleep();
> >>
> >> -    physxa =3D xa_load_or_alloc(&track->orders, order, sizeof(*physxa=
));
> >> -    if (IS_ERR(physxa))
> >> -            return PTR_ERR(physxa);
> >> +    physxa =3D xa_load(&track->orders, order);
> >> +    if (!physxa) {
> >> +            new_physxa =3D kzalloc(sizeof(*physxa), GFP_KERNEL);
> >> +            if (!new_physxa)
> >> +                    return -ENOMEM;
> >> +
> >> +            xa_init(&new_physxa->phys_bits);
> >> +            physxa =3D xa_cmpxchg(&track->orders, order, NULL, new_ph=
ysxa,
> >> +                                GFP_KERNEL);
> >> +            if (xa_is_err(physxa)) {
> >> +                    int err =3D xa_err(physxa);
> >> +
> >> +                    xa_destroy(&new_physxa->phys_bits);
> >> +                    kfree(new_physxa);
> >> +
> >> +                    return err;
> >> +            }
> >> +            if (physxa) {
> >> +                    xa_destroy(&new_physxa->phys_bits);
> >> +                    kfree(new_physxa);
> >> +            } else {
> >> +                    physxa =3D new_physxa;
> >> +            }
> >
> > I suppose this could be simplified a bit to:
> >
> >       err =3D xa_err(physxa);
> >         if (err || physxa) {
> >               xa_destroy(&new_physxa->phys_bits);
> >                 kfree(new_physxa);
> >
> >               if (err)
> >                       return err;
> >       } else {
> >               physxa =3D new_physxa;
> >       }
>
> My email client completely messed the whitespace up so this is a bit
> unreadable. Here is what I meant:
>
>         err =3D xa_err(physxa);
>         if (err || physxa) {
>                 xa_destroy(&new_physxa->phys_bits);
>                 kfree(new_physxa);
>
>                 if (err)
>                         return err;
>         } else {
>                 physxa =3D new_physxa;
>         }
>
> [...]

Thanks Pratyush, I will make this simplification change if Andrew does
not take this patch in before the next revision.

Pasha


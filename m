Return-Path: <linux-api+bounces-4660-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 34FF3B3ECC0
	for <lists+linux-api@lfdr.de>; Mon,  1 Sep 2025 18:55:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF1E5208369
	for <lists+linux-api@lfdr.de>; Mon,  1 Sep 2025 16:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD1E7306488;
	Mon,  1 Sep 2025 16:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="PjBpvKIt"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D76306495
	for <linux-api@vger.kernel.org>; Mon,  1 Sep 2025 16:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756745695; cv=none; b=IHSqUANtzOz+EkArpBKhtNUdMsjUjLhSFFnNUTDb/2phbT8DzH5mKhos959JcGUkWo5clJBQdYn5A/oR43pNNezEto1RmtvRn8YQR9yT7MVVEQTHJZKkhm44D9ZXjwL59PY9SNpDZOQIaoYk0XBb8aHQcSoRgMkDtxmw3LwpEJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756745695; c=relaxed/simple;
	bh=HijY4XYukusWiwshNGfbl7p3/o1oGR3hpG6hQS1YUNU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qkuRaSnFgYllk3gulYxo1ZbyAyPgHgnSQLvweaASoi7LsYrXNWf6RulvsN1rfuSfjB56yYGgIvGIHk18MPATlmaHOjDxlP2NYIvTVB9FEtd20a7WwE3COmRnZQt+RPm4GWkmENzj6WefsautpHApSIpdRwp555hYtt9B9pXcwWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=PjBpvKIt; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4b320c1353dso25835611cf.1
        for <linux-api@vger.kernel.org>; Mon, 01 Sep 2025 09:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1756745693; x=1757350493; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o279Shh53JnSEmHzGwRb/h+6P8VUc/oKT/oRF8TU58I=;
        b=PjBpvKItShNTKB927NfUKJGdz8/+g2qO/c9GIqkW5IgOCfgBL9HIR1ehJtyYdefu5l
         ld6j7QR6clFfMQ1tPnCMl8keylvmdaZ6E+N4pmDqP7YNI/TfM6D1+nbrJuPqyjSdMV4y
         90uk6MBrs85u/hQ7XX+oflxvpHyYgZy5wcIOXX3ZiQCPY4sLSTP2DTPsgnFkhVypnz+p
         e6d8KfYBZVvgGgfzzdv08YseeLWWJ5PZQQ5vskJcmGoWphg5qI5Bz4rVBMKWk+kFC0e1
         HxfCAERVb/q58eeXoc23nuH8sdiBwGD8aFUnDB+h/rE9tIEwLYqAld65Is7x2DL6fw2s
         Fy9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756745693; x=1757350493;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o279Shh53JnSEmHzGwRb/h+6P8VUc/oKT/oRF8TU58I=;
        b=iM6ic02JkWiYSxC791e/5ntAfinwvs16F3knn/CmKOkjSnSDKEBe40yU1H4gWfPox2
         CFIW8Asl8EY2jATAFij1k2GZt58fn+lWQ2ZW7zemuwP3RTmg/Wcj2FCr+O6U1et9a1LW
         nR0DfQK63Z20LA8BcpT3dmYK1Ah+e2RyqoXFCfs6wbDiacdw8pjUw7nXjneIqh4ly3Yh
         8jMba5yIjLKC0AaZOvBZ6QKIKGyHUJwqw6S4G9JyOqgPOdYoO5mUt9g3wpKxqhmiVRVA
         iyl1hPhukOZE0ZOULxFDrrZirgeW/W/oXlAW2TF44sGhDPU1Woe6k7NALFK/eZ1Yr9F2
         g0ZA==
X-Forwarded-Encrypted: i=1; AJvYcCWOtVLkKs8eLDuul6QTLR2YQAOodKCU/ppFL/tm6F1QSFnficc3PTol/bzPoCPFxy7cSiytb5k9f0Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRuz5njWnWFx6PUGLfCa6i5awTRgvio270ZDmLnucIZVC775j5
	AiXWTctkTBZkCS1kcuVO6489d/d1mdZ2uGPa85ioUNBsoF4Zoh16U3sYrDN8VYLM+6Pb+ePXg9Q
	ou34kNkNViwGwvgDXXF3Eb3Rq+WAsjZlHlHnKuyBLsg==
X-Gm-Gg: ASbGncsNWPUaF6caCMq8oqFkI6f9eL3CMR9iwhXFzfDTKFKe9S0vZbF/ckM8imtZFXi
	/5K12n6ASRQFT/lDl3GSyLj9PASki4fEpTjtMU1M9pusQm8K8+b8+Ewbs77815rdTOIHHN5OihF
	qVTNyWl7wF1mxj89GPwcHIF8Qnfz4jnCYVIZns1+0PjSh8+17qC8O3uoh2eaiaWYipoumFyc4j9
	4r2
X-Google-Smtp-Source: AGHT+IHY/eg6lEzMqM6Ga55zC7XFq05s8YP913RvP8Vq9OFKOx955V1owXgBZfCIMqTYLUmetiFwFefB0L5EXnJijhY=
X-Received: by 2002:a05:622a:99a:b0:4b2:9620:33b3 with SMTP id
 d75a77b69052e-4b31da1d546mr115573791cf.34.1756745692646; Mon, 01 Sep 2025
 09:54:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250807014442.3829950-1-pasha.tatashin@soleen.com>
 <20250807014442.3829950-30-pasha.tatashin@soleen.com> <20250826162019.GD2130239@nvidia.com>
 <aLXIcUwt0HVzRpYW@kernel.org>
In-Reply-To: <aLXIcUwt0HVzRpYW@kernel.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Mon, 1 Sep 2025 16:54:15 +0000
X-Gm-Features: Ac12FXwjvuuXLl4TYrvSYicUEdLVOyp0TZPBIDlFXyKegWX4ZiFbjlDKbUPVZr0
Message-ID: <CA+CK2bC96fxHBb78DvNhyfdjsDfPCLY5J5cN8W0hUDt9KAPBJQ@mail.gmail.com>
Subject: Re: [PATCH v3 29/30] luo: allow preserving memfd
To: Mike Rapoport <rppt@kernel.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>, pratyush@kernel.org, jasonmiu@google.com, 
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
	stuart.w.hayes@gmail.com, ptyadav@amazon.de, lennart@poettering.net, 
	brauner@kernel.org, linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	saeedm@nvidia.com, ajayachandra@nvidia.com, parav@nvidia.com, 
	leonro@nvidia.com, witu@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 1, 2025 at 4:23=E2=80=AFPM Mike Rapoport <rppt@kernel.org> wrot=
e:
>
> On Tue, Aug 26, 2025 at 01:20:19PM -0300, Jason Gunthorpe wrote:
> > On Thu, Aug 07, 2025 at 01:44:35AM +0000, Pasha Tatashin wrote:
> >
> > > +   /*
> > > +    * Most of the space should be taken by preserved folios. So take=
 its
> > > +    * size, plus a page for other properties.
> > > +    */
> > > +   fdt =3D memfd_luo_create_fdt(PAGE_ALIGN(preserved_size) + PAGE_SI=
ZE);
> > > +   if (!fdt) {
> > > +           err =3D -ENOMEM;
> > > +           goto err_unpin;
> > > +   }
> >
> > This doesn't seem to have any versioning scheme, it really should..
> >
> > > +   err =3D fdt_property_placeholder(fdt, "folios", preserved_size,
> > > +                                  (void **)&preserved_folios);
> > > +   if (err) {
> > > +           pr_err("Failed to reserve folios property in FDT: %s\n",
> > > +                  fdt_strerror(err));
> > > +           err =3D -ENOMEM;
> > > +           goto err_free_fdt;
> > > +   }
> >
> > Yuk.
> >
> > This really wants some luo helper
> >
> > 'luo alloc array'
> > 'luo restore array'
> > 'luo free array'
>
> We can just add kho_{preserve,restore}_vmalloc(). I've drafted it here:
> https://git.kernel.org/pub/scm/linux/kernel/git/rppt/linux.git/log/?h=3Dk=
ho/vmalloc/v1

The patch looks okay to me, but it doesn't support holes in vmap
areas. While that is likely acceptable for vmalloc, it could be a
problem if we want to preserve memfd with holes and using vmap
preservation as a method, which would require a different approach.
Still, this would help with preserving memfd.

However, I wonder if we should add a separate preservation library on
top of the kho and not as part of kho (or at least keep them in a
separate file from core logic). This would allow us to preserve more
advanced data structures such as this and define preservation version
control, similar to Jason's store_object/restore_object proposal.

>
> Will wait for kbuild and then send proper patches.
>
>
> --
> Sincerely yours,
> Mike.


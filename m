Return-Path: <linux-api+bounces-5333-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 676A4C65C37
	for <lists+linux-api@lfdr.de>; Mon, 17 Nov 2025 19:44:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1F3EE354EA4
	for <lists+linux-api@lfdr.de>; Mon, 17 Nov 2025 18:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F8A7326927;
	Mon, 17 Nov 2025 18:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="U1wXuAMv"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89574325731
	for <linux-api@vger.kernel.org>; Mon, 17 Nov 2025 18:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763405069; cv=none; b=FHyrNAUOnvrDoXcNqFF6zifAbG91PTpLzXp7OTgtxJANt9M5NmAU6XrA9NgJ9oypB7B2cy0AuNeMPwAjEEUpgH0LgeGMeTCqGfBzwZKkZLWgOPJzao4vKTzF9D6vpVQZsbkxL7Pwt9BFJDgRZqb3W37LZNWaQbKisQFWQgb1VKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763405069; c=relaxed/simple;
	bh=jMrH/ZmNqpYeJLFgobm11jMJ7I0km6rEckJ6Z9B2Uqg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nFBLW5uty9zz7fCOe+lvJoVfs6Djy706HwHFYRUu7P0wVLerBviZhaQYtpA/EDDL/kMrz31B16mHJP6OMhoGu9GNp8aFvVcwUji1pze8Hx5kuwfLyrsKiXot8PzkCp5Bc6+fa16yk81vL5XifOzMoUvM9a/kODAM6vTI07NMKxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=U1wXuAMv; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-640bd9039fbso7928728a12.2
        for <linux-api@vger.kernel.org>; Mon, 17 Nov 2025 10:44:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1763405066; x=1764009866; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jMrH/ZmNqpYeJLFgobm11jMJ7I0km6rEckJ6Z9B2Uqg=;
        b=U1wXuAMvZU7H0GNii+4j0rqaGkT1q8fPJ2VYzWzk5BBRfi3AZb+E75Hh+E3Y7ceJt/
         VWYw53hkjadxriHVmIMTZXBsuOHjieT6j8+rECYPtom1WXUeReurtU+002gtohdNlwbd
         eagID9PSa/ZpAlLJ7QVTUIw+VypfLC4Qwu1yIFv5uJPxi5l9wIzHKDzl3uvVKgzcbwT+
         HW4AQYTBtXFoD6XrXlC/dfzGrc+hjtrOplon40hxVux7N4sE9BXPuMQa2mN8Hb9fSwR+
         qRIF5F3VKifEy3y5SCRyekc7ggqn+lA23DuDEHZ4+XB/YtE/KHeeWh0/O0kDSCVLgSUq
         FIfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763405066; x=1764009866;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jMrH/ZmNqpYeJLFgobm11jMJ7I0km6rEckJ6Z9B2Uqg=;
        b=JsFAl/Ekl9t4vKlxI4NAo2CZeeVqq/kZHSH/gkwh0fqKbsUI1qUC3O4JC6eu22J7Z3
         ZZhsaZvYZmeONtPCYsrhOTI8KQQeqyeRiDb5amC4/AjK9xkjggqGxQVvvKLfVTFD8mOo
         peMqv5s7HfW+7pXkyD6e38pL+hWsonl1m8PKJ9o79e8fGdAG6TX9n35xH77Po/q8cwEa
         Ng9pUl61tEKTSbDyFRkSYZrv2yQfaNIdPKtGgbmeFXxdPwGz8AjpUL2FLfbsnRa3mEKD
         Ujtv1mk+wlNtfnYIH8fqKOes3oYKphPMMaurKq/DqtYK4CeulQS3oepgklulms5zsbp8
         f4Hg==
X-Forwarded-Encrypted: i=1; AJvYcCUomzTIYe5J9PhJ1gn4hXsEFaAQ1tzclsTXrFqRk/5gmbesxLA1MaiOSUuCLXoA25pb7RyNf7oKjCg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBAVa4FCKRxLW8AWQOqKqgmWDx4iW3QE63t7r359SqxEY3gXac
	kVaxOLT/MWnGgSvlXwMOv3faGqjnnkTWZiPNSJki657uk0wucZKex+2hmgfGLNxAHgoMKlmu1Nt
	P3lt0TXsf/0mk0QXZdsqUoe1jPvnoo1LNuUGJu9YZqA==
X-Gm-Gg: ASbGncsXW+X71lbxxPMFk4ZK+aN64DTZGvrEcDza9HhVR5ZpD0ZuWaJTKJvIymxkI7A
	m9njMBUddJQFttzzcQdhv9sPI/IrCHWRpOMV/sOThfwD9q3fXqNXpzZRxH5pRBBCZ1eIY2282s6
	oLRHEmpqRHbkyYqyD6xi/TWk4JjbxXa6h6OEW+HKIDYx9pSXhRsJa0VpBaK6roDJyky2w/MjVt3
	0T8qtd3fhzBfQsRdZaXcCF8wzIQ25m9xpyiFMjWVyPQhlX8aAJNCdDuHQjichGs5eWbTHKjeCjB
	+Mg=
X-Google-Smtp-Source: AGHT+IGuvNw77dXDtTPV0AYardMXM6grq7vkCAHZp53MffW9vtH9Ev6zRMSce2XWGa9IMF6cKfb7xBeYsNCCNwLKBNY=
X-Received: by 2002:a05:6402:5213:b0:641:72a8:c91c with SMTP id
 4fb4d7f45d1cf-64350e9b333mr11717643a12.27.1763405065655; Mon, 17 Nov 2025
 10:44:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251115233409.768044-1-pasha.tatashin@soleen.com>
 <20251115233409.768044-14-pasha.tatashin@soleen.com> <aRr1aw45EYSFTCw9@kernel.org>
In-Reply-To: <aRr1aw45EYSFTCw9@kernel.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Mon, 17 Nov 2025 13:43:47 -0500
X-Gm-Features: AWmQ_bny7bEklZsVXOjnwEc2I8Kpi65plOcoXCf1e7YrheuK91-BqnEf_WUIt4k
Message-ID: <CA+CK2bDpLfxLZMwNZLmg+K+uU4YaUefJx+xfD+kQchKpkHping@mail.gmail.com>
Subject: Re: [PATCH v6 13/20] mm: shmem: export some functions to internal.h
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

On Mon, Nov 17, 2025 at 5:14=E2=80=AFAM Mike Rapoport <rppt@kernel.org> wro=
te:
>
> On Sat, Nov 15, 2025 at 06:33:59PM -0500, Pasha Tatashin wrote:
> > From: Pratyush Yadav <ptyadav@amazon.de>
> >
> > shmem_inode_acct_blocks(), shmem_recalc_inode(), and
> > shmem_add_to_page_cache() are used by shmem_alloc_and_add_folio(). This
> > functionality will also be used in the future by Live Update
> > Orchestrator (LUO) to recreate memfd files after a live update.
>
> I'd rephrase this a bit to say that it will be used by memfd integration
> into LUO to emphasize this stays inside mm.

Done

>
> Other than that


>
> Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

Thank you.


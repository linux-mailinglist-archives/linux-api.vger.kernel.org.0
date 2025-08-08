Return-Path: <linux-api+bounces-4409-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48F17B1EF64
	for <lists+linux-api@lfdr.de>; Fri,  8 Aug 2025 22:23:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 219831C2840C
	for <lists+linux-api@lfdr.de>; Fri,  8 Aug 2025 20:23:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DD78232369;
	Fri,  8 Aug 2025 20:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="Bf8vaC6J"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8296922C339
	for <linux-api@vger.kernel.org>; Fri,  8 Aug 2025 20:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754684595; cv=none; b=ad3q+ASpMmUQJGlL0Lk4sPRAh/ZPCJf6KP26ln8sRXrpOMS8j9sf4ZIuTMHyKnIPlCIhgYgVfxA6t9GznCIv73Yv/XNB05ey9Qzy2xyAZGJBbjLymQ0QQ+94QemroALMeBYvK5ZC66QV6mLHLqOPMQ/D+6y5ZWfk4ReDR0u7ldg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754684595; c=relaxed/simple;
	bh=NhHbfYOgDkzOK4h3wiDpp3jR6kbXu2EDTW8+sgV6Bvo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=cS+REKkNcOFE9pNb54YCEXZydc0tfmLsp+6nrbAEtSWRpZNJBnaBQRDjOZZ0Tp/EHjqL9/XUnUO9i4w8QOUcssS1ViRd+OXdF7Mxn2Gw12ECXn4JVcrhAvs5Ws39bTr1ndsqnRh92BdkcCEFNB6GDeeGIbzuZe9h8c/vGo0aBx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=Bf8vaC6J; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4b0739c6557so37524871cf.3
        for <linux-api@vger.kernel.org>; Fri, 08 Aug 2025 13:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1754684593; x=1755289393; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qffYeRv+DqqEfz28gtOh91dhHjRzZPBAshXCIYuUUzk=;
        b=Bf8vaC6JRDjL/6lZEnt++a3LTNTzo3fO4g7wLtbQNqcxGBSVhEDFENn2J+t6vSpaRx
         P7KpwdDj3JGkg3Y+F+0vZNuGO0/vvMT5m9Y7I2ut5rRmWHXhPUIV+co8ZfPqwN/nqXEA
         4UpS8cJ89kQIei7FEsg8sxvPCbS9+F3GVf7bOnqJzSKx5Zk/rE87bYCKVxY8Lo/X01DW
         jFhPz4qE9xv5lsjr6BmfLC7c7fKvXDLr1Lik6d3d+i8jSRGLHbWZrwGTYUNxHEM07tJG
         /BK1c+0kIfU02YprO0LzhJHMuNuwqeNIArJjz+mo/zBbQedcXsRhq2zf2ZiaccMqD+0k
         RjZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754684593; x=1755289393;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qffYeRv+DqqEfz28gtOh91dhHjRzZPBAshXCIYuUUzk=;
        b=QmCHrlXlBNhLI14t6+zh+vqQYUbvy5iQh/hC14b/hf1DULy8jNCW8sonOT9+sAd849
         j7q70+iw9AUW7OFioPi4ii1gmL4mWsp+nmSg2pCsb6oQ5EZyowKDO1ASGf+ccMmnY+72
         g86YHdb+op/oYDnMNE5SxrA0tIEdp2UIq9XVJJpxTHHH/awVDZGPwJiRoBhJ08jnM/kI
         erk8cqQB2B6vKs5OwxiAh+eFZ/6sWbRRmh6EjDfNASBPTs675SUAS1rgD2K5RJEphZtI
         ByyPy9a0z123oCcnW+x65dXUw6QfeIYQhCZuQtmPw9fjxfriI94P8WOKZsCfjLlk+RdZ
         HL3w==
X-Forwarded-Encrypted: i=1; AJvYcCVF4847SjIXkNVUzNvPdjWQrzBbw2RQAbJJ/c4w1nwao0mSdzTGhpOxcgck859piQYgSlvSVAYZifw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzG+KTe9Jb33TX+R+I+9mf+RQ3SzZBiTxZ8z07NzyJOVdcTDT8r
	0o4s75pUxgtDCUSgpTtg6LWuWZ3qMdJ50IUFb/m8Wm0jJc7R8MhmcB58A9LMG4CJigDM2W7zM6h
	rVuW2RoLafRqS/Sk1YyIOAd3R3L/7meRprwYdmlIGDA==
X-Gm-Gg: ASbGncv1juZz5sOKDD3NnTMMcP9hEQZUGcxm6SZp9LdUWsdqOB2fCot+dJOKyYP6zrQ
	RJT6t9pKubUjavVcSi03bxF4RpQpehlwT8l8WViFxqPIA6UzSdQ6aLrrwFxYTqgkIrSOLsmB01w
	pUmETKaYNbUUs4Hin9MXUbkCJRZNEVOtS3FNPA/cMT9ILudjaq4ALWhxgE92H1APTgJZ2n7iqfh
	P3a
X-Google-Smtp-Source: AGHT+IEAzSN3MsXLZMJqt6wu2Cu/Z9Yks4q60j6ZTc58+gOys6Rgr8NdSPHkKqE9760XDbit4QV9DAY9VZSc1qgDJcs=
X-Received: by 2002:a05:622a:4016:b0:4ab:536a:ad35 with SMTP id
 d75a77b69052e-4b0aedd7c07mr68881521cf.34.1754684593193; Fri, 08 Aug 2025
 13:23:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250807014442.3829950-1-pasha.tatashin@soleen.com> <20250807014442.3829950-30-pasha.tatashin@soleen.com>
In-Reply-To: <20250807014442.3829950-30-pasha.tatashin@soleen.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Fri, 8 Aug 2025 20:22:36 +0000
X-Gm-Features: Ac12FXwZELMUp6FmK0bakKcUqFiUYIIUNXgn4oPjuRKBZW9iuH-cHyWFuj5z7U0
Message-ID: <CA+CK2bAP-PWkYtZbw8ofhTgDaW3qoQkNob30wWSjidxEUTV4pg@mail.gmail.com>
Subject: Re: [PATCH v3 29/30] luo: allow preserving memfd
To: pratyush@kernel.org, jasonmiu@google.com, graf@amazon.com, 
	changyuanl@google.com, pasha.tatashin@soleen.com, rppt@kernel.org, 
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
	leonro@nvidia.com, witu@nvidia.com, jrhilke@google.com
Content-Type: text/plain; charset="UTF-8"

> +static int memfd_luo_preserve_folios(struct memfd_luo_preserved_folio *pfolios,
> +                                    struct folio **folios,
> +                                    unsigned int nr_folios)
> +{
> +       unsigned int i;

Should be 'long i'

Otherwise in err_unpreserve we get into an infinite loop. Thank you
Josh Hilke for noticing this.

Pasha

> +       int err;
> +
> +       for (i = 0; i < nr_folios; i++) {
> +               struct memfd_luo_preserved_folio *pfolio = &pfolios[i];
> +               struct folio *folio = folios[i];
> +               unsigned int flags = 0;
> +               unsigned long pfn;
> +
> +               err = kho_preserve_folio(folio);
> +               if (err)
> +                       goto err_unpreserve;
> +
> +               pfn = folio_pfn(folio);
> +               if (folio_test_dirty(folio))
> +                       flags |= PRESERVED_FLAG_DIRTY;
> +               if (folio_test_uptodate(folio))
> +                       flags |= PRESERVED_FLAG_UPTODATE;
> +
> +               pfolio->foliodesc = PRESERVED_FOLIO_MKDESC(pfn, flags);
> +               pfolio->index = folio->index;
> +       }
> +
> +       return 0;
> +
> +err_unpreserve:
> +       i--;
> +       for (; i >= 0; i--)
> +               WARN_ON_ONCE(kho_unpreserve_folio(folios[i]));
> +       return err;
> +}
> +


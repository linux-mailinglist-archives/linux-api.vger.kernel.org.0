Return-Path: <linux-api+bounces-5465-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C825C7E687
	for <lists+linux-api@lfdr.de>; Sun, 23 Nov 2025 20:30:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1DF154E1A9D
	for <lists+linux-api@lfdr.de>; Sun, 23 Nov 2025 19:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 707D92566F5;
	Sun, 23 Nov 2025 19:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="eKzuao9r"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC581EDA2B
	for <linux-api@vger.kernel.org>; Sun, 23 Nov 2025 19:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763926227; cv=none; b=XWOpvQPCEEI8Jsi9Hi71AX+H+Eo1W7DeZ9yacDYHoovX5xc1sZYgAZKvDHxmkkxsYFhuB370dP4koMBqcXW7qsKsbduImTNKbE7WQMSRy0SvwLS3oDgUYV9J9bUEV9lYx4EehhbyzrERYjcyvgrjuUQjBXG6uvXbg0JABeS7BNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763926227; c=relaxed/simple;
	bh=0DI7DlauJNt32lri3m7Vr6BUkI5ZqR7Pk3QrFXxr4Ds=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BfCttC3D8Us784QYOM1I/b/WhOdj22sGjQlbmuE8uPVXS7uxbs11tkfin4g4WacJi6YUtNgdwBUPRmaqH/fTse46a9ZEt7sf7gG4rcYN7tv8AmSc9XMvX6UjS3CnaKUkzsR4SGMh95enWX6F3oAfv2W6B9XagprZwNIUSNPLsFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=eKzuao9r; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-640b06fa959so6093045a12.3
        for <linux-api@vger.kernel.org>; Sun, 23 Nov 2025 11:30:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1763926224; x=1764531024; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XzqHK/TIOOgnA9zIhGUtOJHBTL40HX8egZzA4W6eWFI=;
        b=eKzuao9rSqLDtF/ggrq12zSjkuQNSDd9g5YpTwb6PoWZvQNRo+g7bEQUUhPYemNJu3
         nMw55A2x/DSoY8zVeOH0PDL+uYcJ5YBvH8nEJPSMc9vqYuYti3PezHtYog9ZbOWLy9fs
         oAXYhm+Fz55lQg76EKAMIa/8LVAxHyrngbmhBsUExs1fYWGDTGMEKCzTpCmu/k1peqpY
         SkrhaLr8ovUi5GoQuYQfrwChqJBahBLjsGltC8Lzg1InFja5jJfzxiQ/lVkIJJTUgXrf
         RQGkALdiJvOvzXuxajCFG5ZAn0SR0ukS12ErRx+9ZHeQvw/QSRG/N94JJCDnrkUCk/kw
         qUDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763926224; x=1764531024;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XzqHK/TIOOgnA9zIhGUtOJHBTL40HX8egZzA4W6eWFI=;
        b=d9NHD7Oyh6yg6DN6ebrxkO6AnvjpHVePL1SpUE3Ll4u76OJZY36dsBhj7nT7zYRD7u
         rOwR3tt5h9rj7RbS9fTJr3jxgGLKm3EG+o10IerZ00O0pF9qAxeTCQXqJd5eGP+B4g5O
         q26f6SLvfVuYXPVgw2W1Rj7zLqYUh4qakFcj/xkKNXSGg4te7zgQukjjTDyjXshdMm1B
         ijQKSp6iHjcL2bKvQJ3lWMyIUg7LQmALIo/7GXrcZbCAtvIFvF0ulgpU6qm6MbGiqKF4
         4rRz4IDU/U7Fn+2bvR0EKGLS8RfKVOIY1BnlxsvEOu5IFlWSxhst3PpiykqtgxgyM0fh
         qstg==
X-Forwarded-Encrypted: i=1; AJvYcCXG/Jn9EeScFZ2xYz7fRYOKhuhbyhjQ4PeXB4dhlDqX65fY57QlsRomPQXedo7j5OUYE8Cr1b9YptA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yza7SmAN8TI0p4H6IVeSzhyjZ2BT4SMkmxyVgb1YMPJ4JjxNFKI
	x0/YzgTreSL+9oO19BojLor55ruWp05pWQ1YQ8opDE2o/x+0O66kUUU8p5WpdKarjv2wXTS+ZVb
	7pG8HWqdusON5FOo4VewD5E+iKF7WxPHreDZO3U3uYg==
X-Gm-Gg: ASbGnctLn19wp8ZGIejbYhHkd/olQGhF2NxNCXrVYBd2rmISoArbgrT76+193FhCaZm
	97sPmVQZUf2sCEcDmZ5pdl6l3l0UCNLv3lTz2/Ov0ReT/UBKUHHEd5ebVZUbytwrhZK9595kJhd
	X9km77MH/rmx4jX6ibQ6aSxMX89Ky7HwAehpsD59h/KfqJYGMD+j3RdvFd4Iiq/7dbYnqGnIrzE
	ZLfrqT8j+zROcWio/BqAKjwcbAtfCd7G/IMvb6pKF8Wm+ksrBKb0tzNOwAnf3nXUhzn
X-Google-Smtp-Source: AGHT+IE05jz80rZyj75VVfkojSuXeLlQ8FesBIh1qUPzdQMfW1RSq+XVJJpyUf5jF0hPWhI5fJ55dpas+SZJguxrA/U=
X-Received: by 2002:a05:6402:27c8:b0:634:b7a2:3eaf with SMTP id
 4fb4d7f45d1cf-64554664dd9mr9384496a12.18.1763926223214; Sun, 23 Nov 2025
 11:30:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251122222351.1059049-1-pasha.tatashin@soleen.com>
 <20251122222351.1059049-9-pasha.tatashin@soleen.com> <aSMwsLstAutayHbC@kernel.org>
In-Reply-To: <aSMwsLstAutayHbC@kernel.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Sun, 23 Nov 2025 14:29:47 -0500
X-Gm-Features: AWmQ_bk8jtjaq-w2yB5rB_UsOYzOhWiPvf-U2Ch5k2I-jXXb8CYrf-XuoPC_iX0
Message-ID: <CA+CK2bC6_Ls0AthtWHmFH7hc-ER1uaG11Ques0=zVyozP-gyOA@mail.gmail.com>
Subject: Re: [PATCH v7 08/22] docs: add luo documentation
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

On Sun, Nov 23, 2025 at 11:05=E2=80=AFAM Mike Rapoport <rppt@kernel.org> wr=
ote:
>
> On Sat, Nov 22, 2025 at 05:23:35PM -0500, Pasha Tatashin wrote:
> > Add the documentation files for the Live Update Orchestrator
> >
> > Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> > ---
>
> > +Public API
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +.. kernel-doc:: include/linux/liveupdate.h
> > +
> > +.. kernel-doc:: include/linux/kho/abi/luo.h
>
> Please add
>
>    :functions:
>
> here, otherwise "DOC: Live Update Orchestrator ABI" is repeated here as
> well in the generated html.

Done, thanks!

>
> Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
>
> --
> Sincerely yours,
> Mike.


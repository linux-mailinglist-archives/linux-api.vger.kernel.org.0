Return-Path: <linux-api+bounces-5450-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A990C7E0CE
	for <lists+linux-api@lfdr.de>; Sun, 23 Nov 2025 13:04:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D15A3347B9D
	for <lists+linux-api@lfdr.de>; Sun, 23 Nov 2025 12:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CC032D6E61;
	Sun, 23 Nov 2025 12:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="fe7vA7jG"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 121F825D527
	for <linux-api@vger.kernel.org>; Sun, 23 Nov 2025 12:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763899442; cv=none; b=AVZ6pN1famzNiAHzKwVkZ1dmLVkE+i6DrsAp0oI59BO8CqZSGl/qkzSzDYLDVOwoUP4YI7EyUz5YPevwEciUNuTIzqx29o3SwX44TnQIh5s31V86yefrJPeGvvSnI+Gs/ZoOVlgdpqF5hoLz2Wx6I28qgRxlTbwK5avgficiRVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763899442; c=relaxed/simple;
	bh=oYtIosH0dW5hqrHgNrJe5OOHl1tev8dHqkLMKGUb38c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FKjl16K1OIhQBkMD5v0oc3n2qgS+OzOEO7cKJkO6geHzzHQagmZZKuYUz+7054OV16n7DIVEmNyz7qQFSwK7ECarDWIs90XGErOwoXkngib+ZNdIereTuj7XKF5UdT7WMsPKGJ8DeWkW+X8cNErVdOOuuNqLkMEB7t7dQ284NQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=fe7vA7jG; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6417313bddaso5170333a12.3
        for <linux-api@vger.kernel.org>; Sun, 23 Nov 2025 04:03:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1763899437; x=1764504237; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yZ6437ATus0ug/QEfcQ75ODju9BI6cshDa1KKSODRwE=;
        b=fe7vA7jGu1Bc25+wXVAyjp5nzeAv/sLq4ifVUJ2FJ3nR1E57vusPwUPHFnys2WxIum
         EtfIpcZOqvC31IlDfmRqkdJ2dIXwvZne+tWUVKdfM7j4JQ+UxpsAjDp7X9aGfI9Qbvc+
         Yj1sX8yQEKmcII0jLOlMDgHiUUSGwlqzyTRSq7y/akS7dl5+ktR7O4FhHadXAspQDNCk
         uCRYBtl2ygcc7LiApA/whb5Ms2aS0UKSoVOzpzyVK7Z8Bltojw0Dkl1+Au2LZ4A8ft+b
         /RvwzKZJkqXQQXyGX3Y+yO1ukLU1KBD5qvRW1jJSmHAgmLzelsGWrRVVQi/PxbYLiwKo
         TbTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763899437; x=1764504237;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yZ6437ATus0ug/QEfcQ75ODju9BI6cshDa1KKSODRwE=;
        b=Jig7zcmgVQ6ju86jur/LG7Xoh+0nNZHy1n6NDw3uivyEvYW1Zuwnb2WYaj5F0A1JhI
         qgwugNUoGQ9liRVrm9+WT2YhLyESJBEsXdOmApej04oniieD7usRl2pk5+pDOGeqtTuc
         2w3kZGxsSyzLd0ecy80mbl9p2Ruhu7NKSXML/5L+Dv3q0MvZPB/z2p6fxkijynughSfe
         vjV5Tw8QbvF6uQEdORKGM3oVZqHH+2RUN516XJakZGGsD0g5cCz3NKsv/+rV3gXCUKzv
         7bWeoCK+3F6vBONK8VblVkc4wSqPlGZGo9al31ei1mUVNlt0rkDupC81cphZnKnki33f
         JktA==
X-Forwarded-Encrypted: i=1; AJvYcCUT7eqdy8bAzGLJn9gbLn0MICd2mzulgFuyE4S/9cflAbVvt7t0UBx7qtKSiYxC37h/h4aRqwX4UUM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgsEMCfwuIKlCQYEsOW5i2rlwxO4OHo/20qe5fnP+mY0iRbwyD
	bG/WM3r+JVor9dt678jfb5jRwA/jh4FP36yBcfW8r5UCV/khCmDBDoQd6BUaq9w2JDYA/rnuipK
	jpiavYteOr8syuEoO0dNU7pMxl6csMtw70VpPfVDsbg==
X-Gm-Gg: ASbGncuCaUInLXN27EHeVfQbVJrRES+g0aPLJV+lnWtFKZwi/EM1a1oIipFkQuwUGX3
	QRtVQy8VppnJacdf+idH/qfA/tatoyqZCAhrLDuJ3iza8BaF6wGCC9USp44po0FSeXF+4vcbGu4
	yz6pke1qPIt1RosNDx40o4fYhN5rHn3Xx9749n6dFcN76KtXJ9AF7tWoj+JB/IyEuFJK6qMGtHs
	byNQFHgIMlw2aaEkZ75TNsjl+jGq4SRS7SuD818ftqrYzx9Wd24og2bYMWnLuG44xMo
X-Google-Smtp-Source: AGHT+IHY4DpDIVQj3DszXOkjPRhgk1igiuds0AT/lVzEITdo2CXMJTFn5D87cQjW3K+5NSqSzXFewu7L010slYHUxPQ=
X-Received: by 2002:a05:6402:1ed2:b0:640:80cc:f08e with SMTP id
 4fb4d7f45d1cf-645546926damr7284637a12.26.1763899435959; Sun, 23 Nov 2025
 04:03:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251122222351.1059049-1-pasha.tatashin@soleen.com>
 <20251122222351.1059049-3-pasha.tatashin@soleen.com> <aSLvo0uXLOaE2JW6@kernel.org>
In-Reply-To: <aSLvo0uXLOaE2JW6@kernel.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Sun, 23 Nov 2025 07:03:19 -0500
X-Gm-Features: AWmQ_blpSM5U1pU28FozBhcwrN7bmkenjnD3bgD84GHtMLQK1GWO_h-EYfP_LEg
Message-ID: <CA+CK2bCj2OAQjM-0rD+DP0t4v71j70A=HHdQ212ASxX=xoREXw@mail.gmail.com>
Subject: Re: [PATCH v7 02/22] liveupdate: luo_core: integrate with KHO
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

On Sun, Nov 23, 2025 at 6:27=E2=80=AFAM Mike Rapoport <rppt@kernel.org> wro=
te:
>
> On Sat, Nov 22, 2025 at 05:23:29PM -0500, Pasha Tatashin wrote:
> > Integrate the LUO with the KHO framework to enable passing LUO state
> > across a kexec reboot.
> >
> > This patch implements the lifecycle integration with KHO:
> >
> > 1. Incoming State: During early boot (`early_initcall`), LUO checks if
> >    KHO is active. If so, it retrieves the "LUO" subtree, verifies the
> >    "luo-v1" compatibility string, and reads the `liveupdate-number` to
> >    track the update count.
> >
> > 2. Outgoing State: During late initialization (`late_initcall`), LUO
> >    allocates a new FDT for the next kernel, populates it with the basic
> >    header (compatible string and incremented update number), and
> >    registers it with KHO (`kho_add_subtree`).
> >
> > 3. Finalization: The `liveupdate_reboot()` notifier is updated to invok=
e
> >    `kho_finalize()`. This ensures that all memory segments marked for
> >    preservation are properly serialized before the kexec jump.
> >
> > LUO now depends on `CONFIG_KEXEC_HANDOVER`.
> >
> > Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> > ---
> >  include/linux/kho/abi/luo.h      |  54 +++++++++++
> >  kernel/liveupdate/luo_core.c     | 154 ++++++++++++++++++++++++++++++-
> >  kernel/liveupdate/luo_internal.h |  22 +++++
> >  3 files changed, 229 insertions(+), 1 deletion(-)
> >  create mode 100644 include/linux/kho/abi/luo.h
> >  create mode 100644 kernel/liveupdate/luo_internal.h
> >
> > diff --git a/include/linux/kho/abi/luo.h b/include/linux/kho/abi/luo.h
> > new file mode 100644
> > index 000000000000..8523b3ff82d1
> > --- /dev/null
> > +++ b/include/linux/kho/abi/luo.h
> > @@ -0,0 +1,54 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +
> > +/*
> > + * Copyright (c) 2025, Google LLC.
> > + * Pasha Tatashin <pasha.tatashin@soleen.com>
> > + */
> > +
> > +/**
> > + * DOC: Live Update Orchestrator ABI
> > + *
> > + * This header defines the stable Application Binary Interface used by=
 the
> > + * Live Update Orchestrator to pass state from a pre-update kernel to =
a
> > + * post-update kernel. The ABI is built upon the Kexec HandOver framew=
ork
> > + * and uses a Flattened Device Tree to describe the preserved data.
> > + *
> > + * This interface is a contract. Any modification to the FDT structure=
, node
> > + * properties, compatible strings, or the layout of the `__packed` ser=
ialization
> > + * structures defined here constitutes a breaking change. Such changes=
 require
> > + * incrementing the version number in the relevant `_COMPATIBLE` strin=
g to
> > + * prevent a new kernel from misinterpreting data from an old kernel.
>
> From v6 thread:
>
> > > I'd add a sentence that stresses that ABI changes are possible as lon=
g they
> > > include changes to the FDT version.
> > > This is indeed implied by the last paragraph, but I think it's worth
> > > spelling it explicitly.
> > >
> > > Another thing that I think this should mention is that compatibility =
is
> > > only guaranteed for the kernels that use the same ABI version.
> >
> > Sure, I will add both.
>
> Looks like it fell between the cracks :/

Hm, when I was updating the patches, I included the first part, and
then re-read the content, and I think it covers all points:

1. Changes are possible
This interface is a contract. Any modification to the FDT structure, node
 * properties, compatible strings, or the layout of the `__packed` serializ=
ation
 * structures defined here constitutes a breaking change. Such changes requ=
ire
 * incrementing the version number in the relevant `_COMPATIBLE` string

So, change as long as you update versioning number

2. Breaking if version is different:
to prevent a new kernel from misinterpreting data from an old kernel.

So, the next kernel can interpret only if the version is the same.

Which point do you think is not covered?

>
> > +static int __init liveupdate_early_init(void)
> > +{
> > +     int err;
> > +
> > +     err =3D luo_early_startup();
> > +     if (err) {
> > +             luo_global.enabled =3D false;
> > +             luo_restore_fail("The incoming tree failed to initialize =
properly [%pe], disabling live update\n",
> > +                              ERR_PTR(err));
>
> What's wrong with a plain panic()?

Jason suggested using the luo_restore_fail() function instead of
inserting panic() right in code somewhere in LUOv3 or earlier. It
helps avoid sprinkling panics in different places, and also in case if
we add the maintenance mode that we have discussed in LUOv6, we could
update this function as a place where that mode would be switched on.

> > +     }
> > +
> > +     return err;
> > +}
> > +early_initcall(liveupdate_early_init);
> > +
>
> ...
>
> >  int liveupdate_reboot(void)
> >  {
> > -     return 0;
> > +     int err;
> > +
> > +     if (!liveupdate_enabled())
> > +             return 0;
> > +
> > +     err =3D kho_finalize();
> > +     if (err) {
> > +             pr_err("kho_finalize failed %d\n", err);
>
> Nit: why not %pe?

I believe, before my last clean-up of KHO it could return FDT error in
addition to standard errno; but anyways, this code is going to be
removed soon with stateless KHO, keeping err instead of %pe is fine (I
can change this if I update this patch).

> > +             /*
> > +              * kho_finalize() may return libfdt errors, to aboid pass=
ing to
> > +              * userspace unknown errors, change this to EAGAIN.
> > +              */
> > +             err =3D -EAGAIN;
> > +     }
> > +
> > +     return err;
> >  }
> >
> >  /**
> > diff --git a/kernel/liveupdate/luo_internal.h b/kernel/liveupdate/luo_i=
nternal.h
> > new file mode 100644
> > index 000000000000..8612687b2000
> > --- /dev/null
> > +++ b/kernel/liveupdate/luo_internal.h
> > @@ -0,0 +1,22 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +
> > +/*
> > + * Copyright (c) 2025, Google LLC.
> > + * Pasha Tatashin <pasha.tatashin@soleen.com>
> > + */
> > +
> > +#ifndef _LINUX_LUO_INTERNAL_H
> > +#define _LINUX_LUO_INTERNAL_H
> > +
> > +#include <linux/liveupdate.h>
> > +
> > +/*
> > + * Handles a deserialization failure: devices and memory is in unpredi=
ctable
> > + * state.
> > + *
> > + * Continuing the boot process after a failure is dangerous because it=
 could
> > + * lead to leaks of private data.
> > + */
> > +#define luo_restore_fail(__fmt, ...) panic(__fmt, ##__VA_ARGS__)
>
> Let's add this when we have more than a single callsite.
> Just use panic() in liveupdate_early_init() and add the comment there.

https://lore.kernel.org/all/CA+CK2bBEX6C6v63DrK-Fx2sE7fvLTZM=3DHX0y_j4aVDYc=
frCXOg@mail.gmail.com/

This is the reason I added this function. I like the current approach.

Pasha


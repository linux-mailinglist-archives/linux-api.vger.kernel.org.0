Return-Path: <linux-api+bounces-5193-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A0D8C4791A
	for <lists+linux-api@lfdr.de>; Mon, 10 Nov 2025 16:35:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 22E834EE125
	for <lists+linux-api@lfdr.de>; Mon, 10 Nov 2025 15:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F790257859;
	Mon, 10 Nov 2025 15:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="EU27gWJm"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92FFE1D416C
	for <linux-api@vger.kernel.org>; Mon, 10 Nov 2025 15:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762788724; cv=none; b=eciDVIAl8+jJtdo0JxTl2Vw/hbqmfhrSyUi+TeGvY92TCVUCBaOGQU8JbA+JxGDrYp4MnZPOWMpib771iDhIj3HV9JipeMyH3ZUprRpLRCBaJBGl7SApPV9JnlFpPFDN39flar/X8j4O1ijbJZ5zzpGihR5m5QRIrODvNV4JBQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762788724; c=relaxed/simple;
	bh=9h+ZKAhSsqgldYZEpyKXHMieyzaB7ycGyDH+cOcDlpc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=usBQp6X2iuaeDZ1EbQho+4Lt0YDsRg4mCFmX70VwN3ngmdHguZGG+NLGhSrJQqEizhQH+k9nZ6MKSMQU3NCxo+ocqhY9GdUWzFtKBb6m8NWItjujQRM5IetdM1Z/b9XZCr/szPgpwT29i5/Ya6Fzfgv7KAQdvPdyGFcuxppRhRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=EU27gWJm; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-64166a57f3bso2498345a12.1
        for <linux-api@vger.kernel.org>; Mon, 10 Nov 2025 07:32:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1762788720; x=1763393520; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yvyB1b8oEOYU6YUvXYl67lC2NdpCRz0gUoF3IKmaXbs=;
        b=EU27gWJmq9JMelxQDi91PUccxgQEgBJt2PC/4+W9A4/gHw0peAFW15LiEK4TPsKvBo
         pVQeWBusfBajc+LtnW3SssKIsXnO2vYY3l3HG0t4HZUns37MbBaAr23rMcPlzyizQoit
         RXXgr+RsqtarA6PWSrsktGuX89tEJgR/XBUab5cSnWl0FYBk804f3DTAANJbMbeEEH+a
         VXOJIiMC2GskgXImXbKqPAs7v4Iz895nfsBByO0xuHQ1SWYaoUm/IYbMSKSjjTXBoD0y
         nBoO7Jfyh+yFLCY7Cx7/o4NUzgN4ReN7mSDzzMAYikRWoUL58o2kxL7Pk+Irpwvm0zMf
         bGJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762788720; x=1763393520;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yvyB1b8oEOYU6YUvXYl67lC2NdpCRz0gUoF3IKmaXbs=;
        b=uy3iB0WGevLmhHzC1C8oNKONvk2806lldDPvbLEkNhQq6sl1iw9Kyzsr6Ste1I8Ouv
         bXTgv+Gu6DuDRZlostWttjOgiaCIAw9RcZT5j/33VLpxmH3XpuviO5m/F0jL3NPxDlrg
         Ay6BUEOR51pbco2JVmm0j/RRTqQNQ6N9kSKIgpaXAevaw2IZDJJusmOIruS79COYfI7E
         5Iq1I1DFBfqX83nf8GqnL52wk6hfbk96rEJOBVKOiRDnKPlsekNgpofJECqtcJI9j2yB
         nA3F2Y/W7Ilp/A8KoTuq9NX6zhYw3Rjuj9+xVuV7y2SCgrkKbkxd5hSh56RPrcmfMJ0G
         bsDA==
X-Forwarded-Encrypted: i=1; AJvYcCWWjUrNuIFcC8ZNBod8HXHT94gVe3eFO/kGHQxigoPJGxRjBMHh0/3gJlNUbnnCOThAPx02x6UF3jk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAEbm+IWukfoCnspzsrmoGCFsAbJ2RXthXmfUqFtUhcmQJzoNT
	b1/qFRM7o6N/+UczWeOVbMjif69ey7KFlZAwEuvgzvemHxOeQqu7+XjXhLnKLRlkVYy7RI3pR73
	NaB5UIKzJHxQ/G1kTBuuWHABIMrJiylqG+0eJNbj3rA==
X-Gm-Gg: ASbGncsVRpzyKHtbOmG9ZKA/ct9b/MgDRaN1AfLq3CoyOEuIqSLg5GgRL75jpeZgN6u
	wSQP4NpFJFfPiwBk+JkVFiabWfZwjYG7OHQk6Oq2ZrLbxKybhecXLKknBLwiA8WeSiy1LBCzSBf
	8zTokanOzNFehV38HaWrBCrxqZ4lCdmAimMhEEVgFSmjND1BWqdO9HpujKZ3nOGbblX8oAOxQsK
	OP27zMdkX0utDhdguvsE5xNN4/L9czrdTRe3/wei/zdSpcrW45WgD+/ew==
X-Google-Smtp-Source: AGHT+IEWEmCpMEiE/sigVWI2wEcl1lVXHLXnEbH4KM274tOZXUBy76PsgNh+OSo+pFw8/8SS+R3xNlWxCqdsS2OcqhQ=
X-Received: by 2002:a05:6402:51cd:b0:63c:4d42:992b with SMTP id
 4fb4d7f45d1cf-6415dc1304emr7523926a12.13.1762788719813; Mon, 10 Nov 2025
 07:31:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251107210526.257742-1-pasha.tatashin@soleen.com>
 <20251107210526.257742-6-pasha.tatashin@soleen.com> <aRHe3syRvOrCYC9u@kernel.org>
In-Reply-To: <aRHe3syRvOrCYC9u@kernel.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Mon, 10 Nov 2025 10:31:23 -0500
X-Gm-Features: AWmQ_bnDFpVyCmvtk4rzMsE7lIBuj-Os5t1X5u5kjgkokRKpm2UiGZaOTcTCYY0
Message-ID: <CA+CK2bA=cQkibx4dSxJQTVxVxqkAsZPfFoPJip6rx8DqX62aEA@mail.gmail.com>
Subject: Re: [PATCH v5 05/22] liveupdate: kho: when live update add KHO image
 during kexec load
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

On Mon, Nov 10, 2025 at 7:47=E2=80=AFAM Mike Rapoport <rppt@kernel.org> wro=
te:
>
> On Fri, Nov 07, 2025 at 04:03:03PM -0500, Pasha Tatashin wrote:
> > In case KHO is driven from within kernel via live update, finalize will
> > always happen during reboot, so add the KHO image unconditionally.
> >
> > Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> > ---
> >  kernel/liveupdate/kexec_handover.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kex=
ec_handover.c
> > index 9f0913e101be..b54ca665e005 100644
> > --- a/kernel/liveupdate/kexec_handover.c
> > +++ b/kernel/liveupdate/kexec_handover.c
> > @@ -15,6 +15,7 @@
> >  #include <linux/kexec_handover.h>
> >  #include <linux/libfdt.h>
> >  #include <linux/list.h>
> > +#include <linux/liveupdate.h>
> >  #include <linux/memblock.h>
> >  #include <linux/page-isolation.h>
> >  #include <linux/vmalloc.h>
> > @@ -1489,7 +1490,7 @@ int kho_fill_kimage(struct kimage *image)
> >       int err =3D 0;
> >       struct kexec_buf scratch;
> >
> > -     if (!kho_out.finalized)
> > +     if (!kho_out.finalized && !liveupdate_enabled())
> >               return 0;
>
> This feels backwards, I don't think KHO should call liveupdate methods.

It is backward, but it is a requirement until KHO becomes stateless.
LUO does not have dependencies on userspace state of when kexec is
loaded. In fact the next kernel must be loaded before the brownout as
it is an expensive operation. The sequence of events should:

1. Load the next kernel in memory
2. Preserve resources via LUO
3. Do Kexec reboot

Pasha


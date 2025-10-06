Return-Path: <linux-api+bounces-5003-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 855A1BBE9CC
	for <lists+linux-api@lfdr.de>; Mon, 06 Oct 2025 18:18:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D26151899DFF
	for <lists+linux-api@lfdr.de>; Mon,  6 Oct 2025 16:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC0DF1F8ADD;
	Mon,  6 Oct 2025 16:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="VKxnlQon"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E71FF1E51F6
	for <linux-api@vger.kernel.org>; Mon,  6 Oct 2025 16:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759767516; cv=none; b=rrtGZrev2yQQAce1Da08wpI2YO1CDfxNiDQHb6npHp5g1svaPl7K6n+1fIF+X5rmVQWhwn/04Te6bR5CVhzeZk994NAGBUcjqEswDqlLaa3iIDWCFLM24vCNqLoIPmP/HfzQ3XKoQeh7CkBKcwrBSiS5gBs4YawyKmLVan+6bdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759767516; c=relaxed/simple;
	bh=Qz9D6w3G/yjpN7oFudrZ5DCv7qahcZFISREkkOiWrf8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BFCroMDbb5vIQAPskk2d0ajGLYsNRFlwcEh0mBTm8APozckPbwfWtUSK0UKcx9UM4MgRdld1EC2VCbOK3UTjx3RrxQhZhspWmxpTDXfiQr9X005S0OogtS+Lv40kvdHucyIUv7hXeiuzpsMt2cxIdPv75ZE/4wLaqMylsr8IMq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=VKxnlQon; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4de584653cfso81154971cf.0
        for <linux-api@vger.kernel.org>; Mon, 06 Oct 2025 09:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1759767514; x=1760372314; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XrjZ2N3nijkKvhfmQO1vA7QLR5P8LLIRs7v5R7YmxE0=;
        b=VKxnlQonDU17q6xDTEbfLgRYJ+JTaCw5HtH8g+bESBjpYEk2C9DC3hHwnntK3WJk/S
         2cp2hYKdkul/t9YZsAH7knaUSNCfjIu9aahu6mtuB0LfLfc5jlD3QS2E/c/oJTRH9X5/
         W/tougYGwUK6/pLT0sX0zvBkKVYRJFJzrX0xKDHX9H/ch2fPrDSwTvs3HHnuvK1Y7yQM
         M4RGvtAWl3DwYiPBesEhuN97tpbhLOUqYxVdlbiBeljlK1en4sSOZ9Iq+qtcDEY1p74U
         kQbnNPVWRxMSAhooqBAru8reNiFSoQlPZghLznA59oQkzSIQ2W5DDBo+TtDBhQWkuZD3
         b28w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759767514; x=1760372314;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XrjZ2N3nijkKvhfmQO1vA7QLR5P8LLIRs7v5R7YmxE0=;
        b=imFJpX8cEE9VrR7QRYlOVvhEWpfTI+/dR6fj0yREsbQcIVs/ypZ0194Xj8pgdS5tAj
         6aFhHcmo1LZwAAs9wLkxR8EnNNRXMvwQcSoJwxgph/jzN1711zl+OHJc/j6+BxV8DDNQ
         LDbzXxC+GgPzSQR9OotM5kqtwdPVlpa1h9uDIKlQGwGqwy3rEIBfZLsJG/ei6dPVtBpb
         CVFQu5Hwq68o9sx0FYkAa3mlB6YOasjP8Msaim0KeogkGjpbFHkw/oPBoYMiUsCxTGER
         IacTXGdMqmpFTxHEA5A6sCwWl2AR+aUE138rAg6uYg0P+t2nHwc6OuGyms0RyC5euJ1g
         0+1w==
X-Forwarded-Encrypted: i=1; AJvYcCWEimQpkNxGgX9ZUw0X2riupmW5PvuXA7kZf7YdPZ1L2+e6jTN7qX/Okkrt/QvLATrdgalgzlkOcY4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZpGNzDQ7CS6iZVKCVJ1P5GOggHdLXOB/X+i2issBZJ7i+dxW4
	wA6LSfiw4Yd95LppyBpZzYtPZcCr1Cj2la7bypP+XAI8QxNhgseJWCDCDyXIKRJF10VJ1eowMkY
	gRtVLn3aNjBsbQJ5ZqYCHoYDcg46Coccu03QJBtc1Ug==
X-Gm-Gg: ASbGncu63LSnv2YPA0+KPBEfbS4guA5ApwMYdSLIjeEO2rTnoTN5nZheido3OOVUv6d
	n/27VmmvmbBoKW1VHE/QmoBi3jgCmdRs45n2NYkWjJ1++7U46OgTfxHz2LT5QK44lWlB/XxRvdG
	vjj8mn1axw4/DarwFO25uO7uAgcamgskrxiMuiYg5MJchcfluLNTZr68Zfw3hsIAzXNXjjS+wtE
	uWojY/VkkV3Eh6wx3kjO1vgpI/lmaDus7T7a64=
X-Google-Smtp-Source: AGHT+IFwm4V/zCKBkbgm7pfKIp77PJD1NOmB2z+7xVCEcG6LKB3NFoKIKgya5mufGjYCV3AhGt61yn25CRIzX8BM9QU=
X-Received: by 2002:ac8:5fc5:0:b0:4b7:a7b6:eafc with SMTP id
 d75a77b69052e-4e576a5c404mr198174771cf.13.1759767511840; Mon, 06 Oct 2025
 09:18:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250929010321.3462457-1-pasha.tatashin@soleen.com>
 <20250929010321.3462457-4-pasha.tatashin@soleen.com> <mafs0bjmkp0gb.fsf@kernel.org>
In-Reply-To: <mafs0bjmkp0gb.fsf@kernel.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Mon, 6 Oct 2025 12:17:53 -0400
X-Gm-Features: AS18NWC8dVdnh9WrIeR8a0qx05q3jEVozl0VBzvOu40iLLzMHk8IAd4vKASusLs
Message-ID: <CA+CK2bBS-v_djpvw3v-xumPizzmOaiPsuPpoxnSUub-LocghjQ@mail.gmail.com>
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

On Mon, Oct 6, 2025 at 10:30=E2=80=AFAM Pratyush Yadav <pratyush@kernel.org=
> wrote:
>
> Hi Pasha,
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
>
> This patch breaks build of test_kho.c (under CONFIG_TEST_KEXEC_HANDOVER):
>
>         lib/test_kho.c:49:14: error: =E2=80=98KEXEC_KHO_ABORT=E2=80=99 un=
declared (first use in this function)
>            49 |         case KEXEC_KHO_ABORT:
>               |              ^~~~~~~~~~~~~~~
>         [...]
>         lib/test_kho.c:51:14: error: =E2=80=98KEXEC_KHO_FINALIZE=E2=80=99=
 undeclared (first use in this function)
>            51 |         case KEXEC_KHO_FINALIZE:
>               |              ^~~~~~~~~~~~~~~~~~
>         [...]
>
> I think you need to update it as well to drop notifier usage.

Yes, thank you Pratyush. I missed this change in my patch.

Pasha


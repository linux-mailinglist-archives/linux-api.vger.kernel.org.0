Return-Path: <linux-api+bounces-4193-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 407B1B0F4A6
	for <lists+linux-api@lfdr.de>; Wed, 23 Jul 2025 15:56:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EA533A1A84
	for <lists+linux-api@lfdr.de>; Wed, 23 Jul 2025 13:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A63872EF2AA;
	Wed, 23 Jul 2025 13:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="0GRqWnHh"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92EE72EE965
	for <linux-api@vger.kernel.org>; Wed, 23 Jul 2025 13:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753278997; cv=none; b=NCWzXZnIYIG+GD8qhlx/+LXZjJSoiTL1uRaK0PkpZxchBuATedRDq7HliePSsQ1cwXj5Gk1TAOe+cfbJ7uRLD07rtgLO2p1LncBYQx8z7/zRe0cBvPsAR6pmn3ESO5NYJjLBywQX0Yyn8wJSDQ2hN7WQuY/Ss8XMSx+rgaKcTQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753278997; c=relaxed/simple;
	bh=fU/APBcfC/XfQLmB1N+H1jx5bb6LCvVVTvhPnEoXAWU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HFlrF/DAnHwLNq6s4xVw/UjFdIxNnVhWUSUNCAXCkm/1bg5O41CgRLR2ygklKooadb93WkzjpTNv4YAZGS3bkMIUEab01S+kE2aHuUVXTBNoQWRDksYUi5EfHC7zDI+yRJQVDbRVlJryj3KNPYyMbelYIeO7GlOkEFrqSq0XIvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=0GRqWnHh; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4ab5e2ae630so79935001cf.3
        for <linux-api@vger.kernel.org>; Wed, 23 Jul 2025 06:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1753278993; x=1753883793; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Neb4DMdHL9YN2qZdu5HnMhnwFlw4q4ExiBgUXTApsC8=;
        b=0GRqWnHhO3ay88oPAUoxJl8XZDjHPi8BzJvlkjTgq5HQJ3x4LiqP8ACuWAYQ9UpwTn
         +AitDW5EJImW5H5KsQVufvpuj8nzfKLDbUR+2fGbUrRHGclFYKue/+fC6PXYf5q5yWh9
         DlKcUZGBbmVknvLBUqpqVM7/8qMvDMWhIXT5CNBY1D4WvR8HvbG45OApWOKJSgOzGW4f
         BAw5tmCRNzoWfb0ulY/HqwOZahDbLR++1wTFu/gaSLOYG9xeRlUNTiB/30igi/HjyIbp
         Ewmx/T7k/kW90uCv5RXoTVOvD4jZLr2XqszPZ6XxaUzfseyeeQGrJ1kynh8E+rI5S7tr
         iZwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753278993; x=1753883793;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Neb4DMdHL9YN2qZdu5HnMhnwFlw4q4ExiBgUXTApsC8=;
        b=ekpcBB2E+gxPgs9DF2tDVhAwwZsp66kHagJQYV25OgFT3d5rpP0jLvRv8rttHT5Oc0
         gd0KDsF0rxHgPzuocMdJ/JBvArA4kPM2cy23XDZAEoF+15C8pY4uwYTGqzwCjUlqv+K1
         ngMzRaiDMATTWllVDdo1oPj44pUwdqK5DGpL209swu5ONPGp70OxecGz9zdCpLTnmmT3
         1yVeKgyjvNXrt9chLhi55/DtQgR2znuwc/+766/Tp9k1+Xm+iWHA42dFx5jcDBu115vO
         7Wf8Rn5XCnU7Bf4FuH5ZQNkSY9MKKTpzRsx04VoIxqW9JvybSVBbsLxqfr3Ds8MGD1LI
         vDug==
X-Forwarded-Encrypted: i=1; AJvYcCWYkR+HhrCtf4OKLGWDF++2HgTNxwx5OnIBoX7YyHt4HGxTjHdxTnKeURqcgCXHMKSEaaFB3CQizNA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXBT5zu0RUWX9JokiEtt5ZP7oR1wbejAofVr5Xt+wjUcwOm6Gr
	kq9XnsDkQd9tM8GBuoy6JB9/fYiqSHV4WiAVkKGqW2a3ghnSKe9AY3SBF4U7F5hMCGOGfRelUyo
	DKEUQTAqOmvFNocmIL01xgSmeyoErz395iPzJxeGN8w==
X-Gm-Gg: ASbGnctRq+8CHNofT4IwdVQ5yIOCX6z5vgUIIOsPNuysN2D6+b4NFEKQ33WzHWf1k9E
	Ope0erTXW14KLOyxET9/avbd19ddJxl+9u29n8hi1vlpWqLIH4TVRp7/Fm6vi6KSr8/BJ5HEfxG
	p4bLP0DBeFbcRSjfacTb+F0oOpsFn6UEr4zN6V+Z6wQOmuEc+4PJnjma7HFNDoYgH82itxWA6nC
	IXV
X-Google-Smtp-Source: AGHT+IGrYMZ5lZ4waeYztYzZWeus2W5lvUIGBJomoilBWhgY/xZwdg1u51Z0y6Byizn2RRUk43nSuTfOAFLec5SGqvE=
X-Received: by 2002:ac8:7fd3:0:b0:4ab:6c5a:1fe7 with SMTP id
 d75a77b69052e-4ae6dfc4f62mr48555621cf.52.1753278993220; Wed, 23 Jul 2025
 06:56:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250625231838.1897085-1-pasha.tatashin@soleen.com>
 <20250625231838.1897085-22-pasha.tatashin@soleen.com> <829fa3b2-58be-493f-b26c-8d68063b96ed@infradead.org>
In-Reply-To: <829fa3b2-58be-493f-b26c-8d68063b96ed@infradead.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Wed, 23 Jul 2025 13:55:56 +0000
X-Gm-Features: Ac12FXwxkGX-ZyVenfoKJwxXGBSrng0apcRfW2jRFbfKFQccJBpZH-g5RuQibpg
Message-ID: <CA+CK2bDi+urd9FRftrDn3bwp2VCvb1f3rFsD+dhegLrMRPC4Zw@mail.gmail.com>
Subject: Re: [PATCH v1 21/32] liveupdate: add selftests for subsystems un/registration
To: Randy Dunlap <rdunlap@infradead.org>
Cc: pratyush@kernel.org, jasonmiu@google.com, graf@amazon.com, 
	changyuanl@google.com, rppt@kernel.org, dmatlack@google.com, 
	rientjes@google.com, corbet@lwn.net, ilpo.jarvinen@linux.intel.com, 
	kanie@linux.alibaba.com, ojeda@kernel.org, aliceryhl@google.com, 
	masahiroy@kernel.org, akpm@linux-foundation.org, tj@kernel.org, 
	yoann.congal@smile.fr, mmaurer@google.com, roman.gushchin@linux.dev, 
	chenridong@huawei.com, axboe@kernel.dk, mark.rutland@arm.com, 
	jannh@google.com, vincent.guittot@linaro.org, hannes@cmpxchg.org, 
	dan.j.williams@intel.com, david@redhat.com, joel.granados@kernel.org, 
	rostedt@goodmis.org, anna.schumaker@oracle.com, song@kernel.org, 
	zhangguopeng@kylinos.cn, linux@weissschuh.net, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-mm@kvack.org, gregkh@linuxfoundation.org, 
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, rafael@kernel.org, 
	dakr@kernel.org, bartosz.golaszewski@linaro.org, cw00.choi@samsung.com, 
	myungjoo.ham@samsung.com, yesanishhere@gmail.com, Jonathan.Cameron@huawei.com, 
	quic_zijuhu@quicinc.com, aleksander.lobakin@intel.com, ira.weiny@intel.com, 
	andriy.shevchenko@linux.intel.com, leon@kernel.org, lukas@wunner.de, 
	bhelgaas@google.com, wagi@kernel.org, djeffery@redhat.com, 
	stuart.w.hayes@gmail.com, ptyadav@amazon.de, lennart@poettering.net, 
	brauner@kernel.org, linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 26, 2025 at 12:06=E2=80=AFAM Randy Dunlap <rdunlap@infradead.or=
g> wrote:
>
>
>
> On 6/25/25 4:18 PM, Pasha Tatashin wrote:
> > diff --git a/kernel/liveupdate/Kconfig b/kernel/liveupdate/Kconfig
> > index 75a17ca8a592..db7bbff3edec 100644
> > --- a/kernel/liveupdate/Kconfig
> > +++ b/kernel/liveupdate/Kconfig
> > @@ -47,6 +47,21 @@ config LIVEUPDATE_SYSFS_API
> >
> >         If unsure, say N.
> >
> > +config LIVEUPDATE_SELFTESTS
> > +     bool "Live Update Orchestrator - self tests"
>
>                                          self-tests"
>
> as below...

Done.


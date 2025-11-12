Return-Path: <linux-api+bounces-5258-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 407E5C54832
	for <lists+linux-api@lfdr.de>; Wed, 12 Nov 2025 21:51:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9E6294E25BE
	for <lists+linux-api@lfdr.de>; Wed, 12 Nov 2025 20:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F6082D7386;
	Wed, 12 Nov 2025 20:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="UlYBa8ac"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 572F92D7D30
	for <linux-api@vger.kernel.org>; Wed, 12 Nov 2025 20:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762980466; cv=none; b=MhM0JMR+ErXkuUxzhMo0Jviw0cLTPof3A9HE3cYRLLVYSdI8lmZLXFo1XbzpWZDrvMV28YFplEA21bHt7AdKDjuhV67x1tDK+9JN3nvPWl1FQmmJ1Q6u9Hwle1y5vqSx25NAIXutHqdOPiKfmlE0SQ7RZULNavNsTRpXbFUC2zM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762980466; c=relaxed/simple;
	bh=usPtXPTZX6TXkeQ1v1bYEhzjiCuAM3VVnx8IxUxXsXw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j1f57k2h924zl9ZZmHqjvvfjSAkXVzzvpWBniPSAilBZ1uDjfgcXzv2/ACZ0aIEI8dQIDm2ZMhNrvQiDR/lHFK8Yav4j1r83dEjeZyU3Tf19CDF4tLbLDAyXU4Of7DWz59G0r0qzyqdAsiCr++qFJE6LggS6yBN6R31CJNo0LQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=UlYBa8ac; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-64320b9bb4bso279490a12.0
        for <linux-api@vger.kernel.org>; Wed, 12 Nov 2025 12:47:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1762980462; x=1763585262; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dB48jiAJQmCTSUKKfFbF2w4Wvbq8+BICA0uZNvppCf0=;
        b=UlYBa8acZxIXxOCsd+IeAlRvOszYm0rcdeqrR+hs41Y9TNEpKoIvzNBg1HXwZ9JQNn
         4pEKzyUeVBEcpJxDJ4/FdgGpPeVChVeV+HStsILsNJuIBnz0OOxtSA6tnKbOZuByreGX
         V/H3+gRzxUL1vhOF745KA1vBK6SMRDvWaeiyXbsK6cmCdFhuehs860a88UtqaNOGCQK8
         w3EZmyLKw7sZpgDvd5rLKTlqO7Zv7ROfXuwzXl3+q2s0vIU+oUwuBi1TluI4kCD+Hcls
         16CYAofa4hItWp3/2SmeHyHOdxzMQx6fIZgBddgGI6m55D61j/ymcE58PUlg0AFEqwgn
         THKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762980462; x=1763585262;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dB48jiAJQmCTSUKKfFbF2w4Wvbq8+BICA0uZNvppCf0=;
        b=FBvGJgeHICrcTDaRIJpuRD2w3IYOWlvYki52mqwKeQm/dgje0KlB+1rV7RGF3jrkjK
         f9q6Pit1u5NmOSq218fehu4rOX8201QGsaljIdO/EEuFpQiR0cj6QfGBjH1O3w4zwOQC
         N4ai1w+IRCLoZTRTGjtAsqISGJkHujtYTLZiOPw2dTRs+obDB16SCenAfQ15XcUsy6c4
         oqGhZ87utfCMJOG1We4DhWoPtbmJxh2tb2sKOXQPpLCCvjBS9hD7ebiMKqFzDPyX3oiR
         p7cV2ASMsS78ztUqhE67su2T/Rg+5pgZdlC+SPfv2Nl6gObpoNtqm9tNO3rkg2egNNtn
         sSaw==
X-Forwarded-Encrypted: i=1; AJvYcCUH7T71ykjowhrzzeNeTZWMZbzY7p7KWsi2/RzsXHqq1Aa113eP5VFXZTDyqnnJezc99n5dE/kGRRg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIGs0L0VHXCf5OQUk0o+IPvUdBd8P8yXd3CaAuZHgK1TNO/ZbT
	CZ8Q7Ih1AYW9gcFalpFB6BOp5trpoIcPoOr2f+OQND41l0xZ7VnA2J5mGbKcQ2ReuclTJVCUfzJ
	og9Jy0CJUJzhPC4kl5l2khW24S/wAlF51dIYO/ZNBkg==
X-Gm-Gg: ASbGncuQTWH1PgIEVUFUxUMHp/bKghOb841CEvU7me1tDXlsOGi8pKVpGB5wRHF0qQj
	7qsODiXONXFkVA63ebLB9UJpxBjXeD6N6J5VmUIQCgDoYwld0BYsiRZgudUfaWn6yi6+pZZoqPr
	J0sLJdyiKjJc5FD5rpIAaBLmKlclqFUsM18OPkHpqTR0zBw7Mscsifd1ykgz/HdCyqe3DbFnwXs
	aYsNLPWCNwM9AWgWpR/udHw4NuLQXktcM8wX/d6i9KiT1RQsQ0GhsRF2w==
X-Google-Smtp-Source: AGHT+IHnCxJ5sXULWNZ4xyt6eOXGzcL5bRRpxTbpBkagcIsWqapM9iv+G712dgCOMjYDLl8hNWljgh4gZ1/4nXWnvWg=
X-Received: by 2002:a05:6402:280d:b0:641:270:2c8a with SMTP id
 4fb4d7f45d1cf-64334ce2bf2mr656038a12.14.1762980462571; Wed, 12 Nov 2025
 12:47:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251107210526.257742-1-pasha.tatashin@soleen.com>
 <20251107210526.257742-7-pasha.tatashin@soleen.com> <aRTwZNKFvDqb1NG5@kernel.org>
In-Reply-To: <aRTwZNKFvDqb1NG5@kernel.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Wed, 12 Nov 2025 15:47:05 -0500
X-Gm-Features: AWmQ_bkVh8Sk3xM0csiNTGOKzpW_RilqarlOG4vqEffeEKya7lO37kZmCW2_pO8
Message-ID: <CA+CK2bAhJ+Lbm6v375RuZKs40q34gsKHE-N+dD8gKqgzsHCqww@mail.gmail.com>
Subject: Re: [PATCH v5 06/22] liveupdate: luo_session: add sessions support
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

On Wed, Nov 12, 2025 at 3:39=E2=80=AFPM Mike Rapoport <rppt@kernel.org> wro=
te:
>
> On Fri, Nov 07, 2025 at 04:03:04PM -0500, Pasha Tatashin wrote:
> > Introduce concept of "Live Update Sessions" within the LUO framework.
> > LUO sessions provide a mechanism to group and manage `struct file *`
> > instances (representing file descriptors) that need to be preserved
> > across a kexec-based live update.
> >
> > Each session is identified by a unique name and acts as a container
> > for file objects whose state is critical to a userspace workload, such
> > as a virtual machine or a high-performance database, aiming to maintain
> > their functionality across a kernel transition.
> >
> > This groundwork establishes the framework for preserving file-backed
> > state across kernel updates, with the actual file data preservation
> > mechanisms to be implemented in subsequent patches.
> >
> > Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> > ---
> >  include/linux/liveupdate/abi/luo.h |  81 ++++++
> >  include/uapi/linux/liveupdate.h    |   3 +
> >  kernel/liveupdate/Makefile         |   3 +-
> >  kernel/liveupdate/luo_core.c       |   9 +
> >  kernel/liveupdate/luo_internal.h   |  39 +++
> >  kernel/liveupdate/luo_session.c    | 405 +++++++++++++++++++++++++++++
> >  6 files changed, 539 insertions(+), 1 deletion(-)
> >  create mode 100644 kernel/liveupdate/luo_session.c
> >
> > diff --git a/include/linux/liveupdate/abi/luo.h b/include/linux/liveupd=
ate/abi/luo.h
> > index 9483a294287f..37b9fecef3f7 100644
> > --- a/include/linux/liveupdate/abi/luo.h
> > +++ b/include/linux/liveupdate/abi/luo.h
> > @@ -28,6 +28,11 @@
> >   *     / {
> >   *         compatible =3D "luo-v1";
> >   *         liveupdate-number =3D <...>;
> > + *
> > + *         luo-session {
> > + *             compatible =3D "luo-session-v1";
> > + *             luo-session-head =3D <phys_addr_of_session_head_ser>;
>
> 'head' reads to me as list head rather than a header. I'd use 'hdr' for t=
he
> latter.

Or just use the full name: "header" ? It is not too long as well.

Pasha

>
> --
> Sincerely yours,
> Mike.


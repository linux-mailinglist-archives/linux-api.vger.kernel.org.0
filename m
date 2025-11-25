Return-Path: <linux-api+bounces-5526-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E01B2C86B62
	for <lists+linux-api@lfdr.de>; Tue, 25 Nov 2025 19:55:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95F493A3F69
	for <lists+linux-api@lfdr.de>; Tue, 25 Nov 2025 18:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FAE0332ED6;
	Tue, 25 Nov 2025 18:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="XtG8w+eB"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C89042F692F
	for <linux-api@vger.kernel.org>; Tue, 25 Nov 2025 18:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764096908; cv=none; b=YsZdCNFI/FPlSPnhGSD3EOE8M4T4Juf+PLmAOcQ+S60h0ZjiDT/Npr0ItYtHSjeHkvln00bxTZCaCxCI5LA3gFYkUs31UCHgFEoPLGUF9t6vD7BtB9FuLqZ0UzHT0VbAYBB+oo4Hi5XbbE+KapKaLnh+vgYb9RJKynfwXVUjmbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764096908; c=relaxed/simple;
	bh=HRq0fEmSLdbqSqBDU+IM/YitmlyC+uQDyXNbdhOeZwA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xk3anoDcIvEBG1JHjh4d4I/ukzpHK0k07XOQrfhFJk+M7BgvY22Wn8KL8qVFynCOdf0JDEG77i+9TXw4BE/bDIPfQNavg0GDW8fhXz0M3rHW/IkmGYFe/F8E5kZgqz45T/xIeof4l0LkwJctlrfaaqixlFeOTvxoCt/138YLrcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=XtG8w+eB; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-64320b9bb4bso250333a12.0
        for <linux-api@vger.kernel.org>; Tue, 25 Nov 2025 10:55:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1764096904; x=1764701704; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TTCNx8vWQBYhmY++zaqhyqyyYNnaJr9KGGVzzHKQdqA=;
        b=XtG8w+eB5qRXzPUgChF/yWMI90bL9wBGTJZonr71PdWsilhnchYUYbU8ktoM5jSBjG
         M48R7ZzKCgh5y4SjsO8xwDPTrzzzfLM/eMyLLWsVgSdHrBbvdkT1027JBw/vxgqmBiCx
         pt4rd7Bg0seNjlTrb6bCA7ywnjVXyQMQ8LJohNPtuR3iyKAZEEP/dELLoHF8QMZfiSqf
         T1ZIOB1S+xfMkkLG9y8rqkg50JGiVoGsp5mU2KwLihpP4ibpgSY+csFoUd79VP1zp5mN
         PZVSpHod3QkgieyEgI7E9UlhW5hLg95ghwgVOi46fvxxo4b2TLQvJl4E0nChDfhOPxyd
         r1rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764096904; x=1764701704;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TTCNx8vWQBYhmY++zaqhyqyyYNnaJr9KGGVzzHKQdqA=;
        b=oqnQz55YsZjeaZ0z2XZfVPvRb4jjmmg1T/tmLt2exKenjdkV3TTOyWoMMFc5P/GdEJ
         kSTh9xN5NX1li+YoXDwiul9GINhwuuFP3QIWc+0LXjY7zPLy2ixq1TOYk7beYVF5qi8s
         LA/7E787ksNDvDl8rLcS550Gwl402/5XxTbIGrBU1nxIRa96UGQ14/dyG5j9T3vI+Ky6
         HQbFGS2hez/L+mYaHTg5BPKyPr03UUFkNFJa+L2osQ2qBmoxUlDmOXb5V+2Q9vRwwpSP
         BIKoEhQun0l/L7KhuRfVHq3jpP1o9nkZyLy/3ICuNRK/mfeCVqwZY/bPSgoJmsEzFe78
         6bLQ==
X-Forwarded-Encrypted: i=1; AJvYcCXLzDk5PB8Im6A3fpCaM7CpwMyJrXJkRdhd/JtEOH09w9QnnKb2nlblZLojdTZ4D2B4uzkPaAnmM74=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJSv/a0Muae7RaLhLGx1qh64cIydr6WSd7fFKwG2bPcfF3O8k5
	FVhMkGH6SEZNzNiyWsdW7mN/7WmzTXduu0rApVJhWs+pIVAwT+zO8orrRBAK2uwp8DmgniJthGA
	ZWDWeRLAOp+268egc8pcU+vWwhMoRXR83OS9qIb5K9A==
X-Gm-Gg: ASbGncsM97R3CcTHVr2OiDh/vM0yaenx3Jnk7axr12tA/br118rEh92QlpCugpaJ6tF
	XwZEcLlaPRtmTuXmyLPNFj7XAx1ZdIShS+u2erbL+Re2mBMBfO1Zq6iCu87nKmuiYOpjnDnYU1o
	Z7yiXEafZvphLbAOUPqrjRixszAQtqHv57YYneed1ZwBMZPfrQfk1ZT65+VraLOiRZOwpGWIMov
	Td/Z0gIiVLF0qirHiyykJf4g+T9qUerZ0lifxJAhS3PDR5oW2YI/kLEg8ebPYMAgaSa
X-Google-Smtp-Source: AGHT+IEfzHlIPEiuolnmC+PUY7Qx4g6VZmzqaCh+kJH+E2RdrqezJkmRTURyahiQenFGIYx+F1u+CuUpBK9+z1Di0cU=
X-Received: by 2002:a05:6402:4499:b0:643:130b:c615 with SMTP id
 4fb4d7f45d1cf-64539639594mr16646192a12.6.1764096904062; Tue, 25 Nov 2025
 10:55:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251125165850.3389713-1-pasha.tatashin@soleen.com>
 <20251125165850.3389713-2-pasha.tatashin@soleen.com> <aSX6sQqwwA6I2mxW@kernel.org>
In-Reply-To: <aSX6sQqwwA6I2mxW@kernel.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Tue, 25 Nov 2025 13:54:27 -0500
X-Gm-Features: AWmQ_bn51TAVMNgVIbPP9PoxfS_5IRPJ8eZ2jrzKpsVEpovGvgRKZept8XkPO9Q
Message-ID: <CA+CK2bDUgU8iBOL6eUeK96fZ3-XfokCma43cTore20c1L6GE0g@mail.gmail.com>
Subject: Re: [PATCH v8 01/18] liveupdate: luo_core: Live Update Orchestrato,
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

On Tue, Nov 25, 2025 at 1:51=E2=80=AFPM Mike Rapoport <rppt@kernel.org> wro=
te:
>
> On Tue, Nov 25, 2025 at 11:58:31AM -0500, Pasha Tatashin wrote:
> > Subject: [PATCH v8 01/18] liveupdate: luo_core: Live Update Orchestrato=
,
>
>                                                               ^ Orchestra=
tor

I like the sound of 'Orchestrato' :-)))))

Thanks,
Pasha

>
> > Introduce LUO, a mechanism intended to facilitate kernel updates while
> > keeping designated devices operational across the transition (e.g., via
> > kexec). The primary use case is updating hypervisors with minimal
> > disruption to running virtual machines. For userspace side of hyperviso=
r
> > update we have copyless migration. LUO is for updating the kernel.
>
> --
> Sincerely yours,
> Mike.


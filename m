Return-Path: <linux-api+bounces-5149-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDEB6C1D652
	for <lists+linux-api@lfdr.de>; Wed, 29 Oct 2025 22:14:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52E3A189C1AE
	for <lists+linux-api@lfdr.de>; Wed, 29 Oct 2025 21:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2F8131691D;
	Wed, 29 Oct 2025 21:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nCYmfsCb"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA88A3161AD
	for <linux-api@vger.kernel.org>; Wed, 29 Oct 2025 21:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761772432; cv=none; b=HZ9KjC7rPU28zdGcODvXQcSL5LnmU4C3/qkodRrRZfPbYl8YAQTC7vr4wFVyTw9Uzpvc5isfiOCMu+Ges+gKDvEbpR4I5JXWWHQo7fnOpjzTthm4c/94Vv+tAdauveyYAsGcIi0eHVYsGxKMZZU1Uq6K6SSBvFM0LUzrV6crOdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761772432; c=relaxed/simple;
	bh=JEkVL2yw/xHlwVM5DiMfV/wkuCa8mgAwcpgYx81B7GM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WxuKgU2zhFHdDGrmDPZnULaM4Jsk6/D0+O1NPc7uloXK5ptep3NGDq1Ri62T9HGdsgHEN2AxThGq/AhCX7gj8o4wV9dJCbo/1fVuhWOMyGGmZbVmXLfOEYeJGT53k/71g6xfMbVYjAw0TjKlP94UUR4RR1bfsNx3gRMkO+dN1LE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nCYmfsCb; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-57e8e67aa3eso2201420e87.1
        for <linux-api@vger.kernel.org>; Wed, 29 Oct 2025 14:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761772429; x=1762377229; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JEkVL2yw/xHlwVM5DiMfV/wkuCa8mgAwcpgYx81B7GM=;
        b=nCYmfsCbMA9NzQaa64kEC4baExLRtapT8fdvk0MH1d4zIRtbMvV0rLZ/ptvT0vq5CH
         +HkkqrBp5hoG9mo4GWeyy0x7qGtAdVpMS8K3dMJpsG8R4Gt+JjDASlsjGYQqmymIoVyT
         A6Sryrmiwb5pfkfJp9gETz5OEwTM4FvK/RviWFqKH+bjnkpz5JWpDmMTDjF4RehWZFUL
         PWQrbsWOFTWFRGCylRTz4MVqnJZ/baSDn+D5saaFFFU3XmtfX799iUDrSmrCGfm9+ds4
         P9T3r0jAjxlhY13vVHr/97QV9jAZlnFLnIVoGydDVThAbYOXAg19krfWu3pizUwtsxj8
         vr8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761772429; x=1762377229;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JEkVL2yw/xHlwVM5DiMfV/wkuCa8mgAwcpgYx81B7GM=;
        b=Z2UJFfvFT1dteNtVpNodbqYcFbmaqY1xVih3c1mwRoghlRqkTLyYux11WB/w8m6sn3
         Pusa0sp/jrU0k+PwfdUg3HGdxlum0xKVg/z2COYp/os9z1uV4SEE2cgF8g/WGjhgcRVT
         7+9eLd0IZQTkwrN/SYtz/+M1aatu7elXkh+zk2tHLCUTMtSsGW6tBBTyVyy0fUPJhzKm
         PeT+WUFDBSOv1TjDrsclLY7Bs895yZgami4kN8EuxFWJmWLSF3eprEuoSB/VJBQ9V0AE
         zO00b9RxjRziCUhDkq6NeaHdhCRgbX4vbNXZpukzZpmt/ijutulq0G+zadWD9gUxP+Sw
         Pcvg==
X-Forwarded-Encrypted: i=1; AJvYcCVqqeyPrjP9pUXZAr7YZ+aTVqxneBUzGJCaN9moZ6vQ2/fd8AUf+759+po7ILtH+XtYU+k1//Y7Ke4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRVfPPDO2fFxI5xS0hCdFeuDhbaJsNcs2GoptktoHZ3NKwQl7M
	cB3R3NvOXYylSJuPAy1UD5hBGikASJOn+FJLd7gO+nWeModygmAVER+NCLVuCQvbyDO4OKmr79E
	swd1CDpXf5DFCC6Au97GZrSzZSBCrsS0QVD2f7SE3
X-Gm-Gg: ASbGncsaGyZ9oX5/3PRXyHJBZhJZ/F74+Bpub6FwOEJcpQKv9ouC4x7//OrNG+1iioL
	9Ezv62e5uEVFmBAPlPTNRgw5td3sjYN+tOKvmTVojM7eEM3OLU/68k1DFKchP3YZ4yWpW0ixzKh
	Eo4HuW2ilxMgAO8mYIdZInu5ZLWFsRUiTbRgImI2jrAoZ4HcFMrimh2hW7Hdvi5KcWTnoBrkh72
	Z510OafLC/NsmphTVrzbmbcAqi/bxi00mg+U5R83yu78VxBy7l7rqjPCvLt4DKm4m1XXrXePV7q
	xXyAXQ==
X-Google-Smtp-Source: AGHT+IHZQoB9yL+ldFaXMM1bMXJiwccZfdn7OWdIICrdEFPtCJ4NB2qUJ+qk4p2BEZhWEpH+XIXLyp9M3uzoemzEy4A=
X-Received: by 2002:a05:6512:3ca2:b0:58b:75:8fc6 with SMTP id
 2adb3069b0e04-59416d8ce02mr294670e87.19.1761772428439; Wed, 29 Oct 2025
 14:13:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250929010321.3462457-1-pasha.tatashin@soleen.com>
 <20250929010321.3462457-15-pasha.tatashin@soleen.com> <mafs0tszhcyrw.fsf@kernel.org>
 <CA+CK2bBVSX26TKwgLkXCDop5u3e9McH3sQMascT47ZwwrwraOw@mail.gmail.com>
In-Reply-To: <CA+CK2bBVSX26TKwgLkXCDop5u3e9McH3sQMascT47ZwwrwraOw@mail.gmail.com>
From: David Matlack <dmatlack@google.com>
Date: Wed, 29 Oct 2025 14:13:20 -0700
X-Gm-Features: AWmQ_bnOObc6BWBaYvrzlZGN0Gzs0AQqmxe0DWfFCoP14pNjDRBJcsWZpskW2fo
Message-ID: <CALzav=frK48c1=nsbVJ4EvqqOqr33pUArP4G17su0hxOYveALw@mail.gmail.com>
Subject: Re: [PATCH v4 14/30] liveupdate: luo_session: Add ioctls for file
 preservation and state management
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Pratyush Yadav <pratyush@kernel.org>, jasonmiu@google.com, graf@amazon.com, 
	changyuanl@google.com, rppt@kernel.org, rientjes@google.com, corbet@lwn.net, 
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

On Wed, Oct 29, 2025 at 1:13=E2=80=AFPM Pasha Tatashin
<pasha.tatashin@soleen.com> wrote:

> Simplified uAPI Proposal
> The simplest uAPI would look like this:
> IOCTLs on /dev/liveupdate (to create and retrieve session FDs):
> LIVEUPDATE_IOCTL_CREATE_SESSION
> LIVEUPDATE_IOCTL_RETRIEVE_SESSION

> - If everything succeeds, the session becomes an empty "outgoing"
> session. It can then be closed and discarded or reused for the next
> live update by preserving new FDs into it.

I think it would be useful to cleanly separate incoming and outgoing
sessions. The only way to get an outgoing session is with
LIVEUPDATE_IOCTL_CREATE_SESSION. Incoming sessions can be retrieved
with LIVEUPDATE_IOCTL_RETRIEVE_SESSION.

It is fine and expected for incoming and outgoing sessions to have the
same name. But they are different sessions. This way, the kernel can
easily keep track of incoming and outgoing sessions separately, and
there is not need to "transition" and session from incoming to
outgoing.


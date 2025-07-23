Return-Path: <linux-api+bounces-4195-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 077C0B0F58D
	for <lists+linux-api@lfdr.de>; Wed, 23 Jul 2025 16:40:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 222B518988B2
	for <lists+linux-api@lfdr.de>; Wed, 23 Jul 2025 14:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 506192F4305;
	Wed, 23 Jul 2025 14:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="EzZ3d4Sz"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB9F2DCBF5
	for <linux-api@vger.kernel.org>; Wed, 23 Jul 2025 14:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753281605; cv=none; b=CVbUPt3cN/hov7/dADv69+BjcgOVEm3LvYAbHBaA6cs/0QpIaYq6/cA03cwAkRL+G9deMOCDDTSi6ck7rhrIO2aYxFTLT8gNVq6qFGYfoGqKHaD5JXVp2RhQafRVO4Y1b0rBcqY8gWFrz0BaGggqewwjKncw2gmq+4ITtmfn7Zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753281605; c=relaxed/simple;
	bh=0z+SXJ5yfQB6L25otv7+RIp45kETMhhVSzDBfbQ+6f0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XzhZYAItHwRfLDyXzoGZBweVAmj4zANVv7J+9AcAg0iclsoEVeDX2G1AMvtyTE29MRQFmRHSd8PwkuoiLA7nybxQWzfbHY2BM31QPqAS4dw39vxggp+5hK4p1oHYgj9wx+98lz6JJpDrdtDJ2nCd7OstD9Fbbwjy6vqqxzusACU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=EzZ3d4Sz; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4ab82eb3417so69238481cf.2
        for <linux-api@vger.kernel.org>; Wed, 23 Jul 2025 07:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1753281602; x=1753886402; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E4VW1A7ZGjSXpn0g5zEan91Zyknv45cf516fxn6sXo4=;
        b=EzZ3d4Sz/vwV3U5tX+CTieQkSi4yK/S1vksOJZ+mVHaWM45wXvxcHhJ8IMPPAZPR6M
         6BvdvOaOkbhd9PH36BRwNNA02wAkGgOAFdxuGL/rVlIUER1uOLkvjY/Pewe2+V0I/ikx
         5cmo4BgNBBw8c1K1n4eqlmsqlUOCgDz9di8rCDD01pAleJC3EFFTtcHDvqJJBlNLF7vw
         a+f3jKod1vnGB+d7iVGoiEUZhvdUbAzIZBwiqvna5n7P64TJc9ql2jNyQgVpGEjx9uKH
         3fo5S8WE/1N9bQQYYx+lCReYZ1UKsT4WB3iRNuk/PXXPz4AOatJY+Nf9tI/f00hza+uW
         5znw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753281602; x=1753886402;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E4VW1A7ZGjSXpn0g5zEan91Zyknv45cf516fxn6sXo4=;
        b=whcVZ6TK0FzFSq1UpzOmmMF2EXw5+5fAn6P18KfPvVcHBlozCTbqRWiakGAmZ1dXve
         0DyN0DNRb2MRkjlZmCe+vU1yCOKopsQ8OPWtec09Kak9LKq8v/1qEQC2T/CPddq8Us/c
         k4D8+wlbaH9flVOuXoXP9URVnFHN7dz8NByPgx/3JPt7qPFZZ6rAKB+NuM0RTECEe95Q
         KduMC/22lK47A5+CyUJu+vVRAW1fdjOeePXmwE6+e2fYuekyRfIAWln3AjUHHoAH0aqa
         sC6lUs7fgy5DCOw8jpbA6ERuo9xqTI9SH6FS/59qwi86+nbSIeg5pQUefFMbCci0bb/O
         IC+w==
X-Forwarded-Encrypted: i=1; AJvYcCXHTYBinGEpfDrfTjXgM/OvNits+GNte9a6/hb3oGd0ddTq/NeWhNa4TdI8Xo+dp7dHSuDUhfqbNcs=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywplxz+2ja/zJBoB+TXMuIechQ6wxPE25yIk6Sj7PB0B/JVeH+M
	gabrBiZOC2f4pNc6UoCkPydxGCso6TCDSv5G/FG63GDSoeyDXTma5aRa8IWgugX4hVaGhXSEuiQ
	L3J6FIem9oS6SttcddZaSbQmG5icomTZDRj6jBAZa4w==
X-Gm-Gg: ASbGncvAGsrR9XIoX7SsMAcOrWbzNvgoWzCOXtoPyIZTnwLzpXQcbm3afezLGofnjCk
	+PN0hkpPcnmi7+CTIHptE+9Sq+kqPJRIa6MG3ahRiTY1Fz+bj21nm8bglreCnFb3fmOYsg7lSVG
	UODqN/P65IJR8jdtIZNrA9CAWfmsfv8wzB7aitMzNg7Lm/sFMwM3tEKv3C8uyPm87Vpl4pA0kKN
	jQx
X-Google-Smtp-Source: AGHT+IHFS+sl5UqmRZOH4YC8rrY1lTn2lhJNlt9MYCWZB3088lrRvjxl69LEe5to8g07iNSRAqNDE0qYJCcj4SAzgKY=
X-Received: by 2002:ac8:5d14:0:b0:4ab:41a7:852 with SMTP id
 d75a77b69052e-4ae6df7e0f7mr46630481cf.26.1753281602021; Wed, 23 Jul 2025
 07:40:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250625231838.1897085-1-pasha.tatashin@soleen.com>
 <20250625231838.1897085-4-pasha.tatashin@soleen.com> <ac8efa08-3f85-4532-8762-573ebd258ca7@infradead.org>
In-Reply-To: <ac8efa08-3f85-4532-8762-573ebd258ca7@infradead.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Wed, 23 Jul 2025 14:39:25 +0000
X-Gm-Features: Ac12FXw5a0SPc2DZ1qffEKM0_QNNJkpaMIdscCC70ESios9nqZeZ3FVsbikeuDw
Message-ID: <CA+CK2bCChNVmGXPN52La1zECBBSRf5SffHFEHwMcJCDaqA+YUQ@mail.gmail.com>
Subject: Re: [PATCH v1 03/32] kho: warn if KHO is disabled due to an error
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

On Wed, Jun 25, 2025 at 11:57=E2=80=AFPM Randy Dunlap <rdunlap@infradead.or=
g> wrote:
>
>
>
> On 6/25/25 4:17 PM, Pasha Tatashin wrote:
> > During boot scratch area is allocated based on command line
> > parameters or auto calculated. However, scratch area may fail
> > to allocate, and in that case KHO is disabled. Currently,
> > no warning is printed that KHO is disabled, which makes it
> > confusing for the end user to figure out why KHO is not
> > available. Add the missing warning message.
>
> Are users even going to know what "KHO" means in the warning message?

Changed warning to: Failed to reserve scratch area, disabling kexec handove=
r

>
> >
> > Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> > ---
> >  kernel/kexec_handover.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/kernel/kexec_handover.c b/kernel/kexec_handover.c
> > index 1ff6b242f98c..069d5890841c 100644
> > --- a/kernel/kexec_handover.c
> > +++ b/kernel/kexec_handover.c
> > @@ -565,6 +565,7 @@ static void __init kho_reserve_scratch(void)
> >  err_free_scratch_desc:
> >       memblock_free(kho_scratch, kho_scratch_cnt * sizeof(*kho_scratch)=
);
> >  err_disable_kho:
> > +     pr_warn("Failed to reserve scratch area, disabling KHO\n");
> >       kho_enable =3D false;
> >  }
> >
>
> --
> ~Randy
>


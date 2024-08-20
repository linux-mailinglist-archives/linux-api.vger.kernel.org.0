Return-Path: <linux-api+bounces-2211-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7848A958845
	for <lists+linux-api@lfdr.de>; Tue, 20 Aug 2024 15:50:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 220EE1F23294
	for <lists+linux-api@lfdr.de>; Tue, 20 Aug 2024 13:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50B1C19066E;
	Tue, 20 Aug 2024 13:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bTmr8409"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE9F18FC93;
	Tue, 20 Aug 2024 13:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724161818; cv=none; b=LMk11dxYGivbZMwrnnvYGT9Rg/uJjYTEYCgtgh9qYQ8rATlL+wqXhDyun9JgVsMVkf5xMsZKQn50OC7V8KbB0H59M5KDE8YIchKlG+PcA36pU09I/LuFa1vZnRFVmY0zUpxE01+7SdJjzOqOvvqIXqfCZMpKrxwAiWmzyAQ3aMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724161818; c=relaxed/simple;
	bh=D/X4XfUDRu4pM97jVQKqcprGLaf/V7OIPiK0II4YXMI=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=DHB4cDYpvUdW2Op7onEYPxolHLf4vtScUVp0yNR8Y2Y16wWL2F72d1X2O7UMYUVam7ke0IP9H74SQSLRub8XWrgTAVf5CVR95192An084rKvmUj/tkv7dn9bM2Atg8oddx1xIl1++Zo+8Pd+atBUn/lHNv7247xV+ux6ELnLR/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bTmr8409; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2d3ba4e6ad9so1043237a91.2;
        Tue, 20 Aug 2024 06:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724161816; x=1724766616; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gDFUnkSGjaQxypInF07Poa3P+t0Ku2ZifidG1G95HSs=;
        b=bTmr8409Utm0te5iblSNrgF5qrhxY9ToVvsExjd2kAhMNXk9kBC1X+QXzzLHGhQhFa
         bTk97F9gc68Ss8WomikNnDTdoYJ+kgSOo0lWWE1YHGx+0fqXYWdGg5P190EgIaKME5Vx
         mT8hpFWDhVtsIf6um0ypPFoVpXhW46jXu96Cl5XPR7P5B6vxYfCw8hOVmUD94MeJrqwv
         JKScq1MCR83yxucHO5EkGf07LNovLYJCuJuTtIrxJRyco7V4CHO637wnFduGbvuP/4sp
         hUz8vEltHAYsJ6STalb28Hyi/JDNcMoRexWalARGk/iqfVqDO+A8uph82vnjamHqe3at
         8dwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724161816; x=1724766616;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gDFUnkSGjaQxypInF07Poa3P+t0Ku2ZifidG1G95HSs=;
        b=W4xZLQ2kipKMQJRrrZSP8/xqJXSD8OChqpbCmNnkzeh2hq4RVU/HLlzdb4v8/BpaKf
         loYkOWYHxqLpdD1KWygqons4MdHoHPMOCWV4PVxtzYfuoYIpzXbQ4iMqekuN1hfeTHIy
         Q+J9mDGyZqOzsz8RpvUc0bto5OLgEHPjzbGyxS71PSMyuUkbTWfRhoqt7s/6PEvebzM6
         y6jeUVjBTOfK1ASRkJuOAqB61Q8oz9PhJA4P4VzjndYkCOPfDHc0pQMtygcn7323ZeJ5
         qpK+gk6c6NzZD/6SdlRwRNYUSTvZxPsX/JEXON+z/rjR2MdCbCCwCZ2hnERJrruZ783R
         bzYw==
X-Forwarded-Encrypted: i=1; AJvYcCXE/S5FntKnMWUIjoXPqLEaMe9VcfYVL32bMHVVph88nL02QaBViSje68ovW4nJhlMOv3rfrgpDgMg=@vger.kernel.org, AJvYcCXwW0EZLnKWch79dko9wDgvf1F9GmFHZvPzTBfC9yXJmsG2lYypBmz8CzVKJiyEKxobaJ7jw/N1@vger.kernel.org
X-Gm-Message-State: AOJu0YxXoIrUFE45dEfcP7bOUB3sBsaX+Vxn6qnmkxqWXl2ewrcXRXCE
	J37Vu27iaHJaepytuMbE2B1687bi73io8ifD7h1Gr2680fEIYXKrbme95dDOX7lZfw==
X-Google-Smtp-Source: AGHT+IFLzq41ciIqlNHU7CfX0QhrF4T6k5OQj11ipYz8epgs5XTfHhFbR5O91RrTCe/bSDwsUUgQ0g==
X-Received: by 2002:a05:6a21:998d:b0:1c4:a742:ab20 with SMTP id adf61e73a8af0-1c904db932fmr8719157637.0.1724161816075;
        Tue, 20 Aug 2024 06:50:16 -0700 (PDT)
Received: from smtpclient.apple (va133-130-115-230-f.a04e.g.tyo1.static.cnode.io. [2400:8500:1301:747:a133:130:115:230f])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7127ae06bb7sm8242227b3a.58.2024.08.20.06.50.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Aug 2024 06:50:15 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51\))
Subject: Re: It is correct to introduce new sys calls to stable versions?
From: Miao Wang <shankerwangmiao@gmail.com>
In-Reply-To: <2024082057-coherence-lethargy-3513@gregkh>
Date: Tue, 20 Aug 2024 21:49:59 +0800
Cc: Xi Ruoyao <xry111@xry111.site>,
 Huacai Chen <chenhuacai@kernel.org>,
 loongarch@lists.linux.dev,
 Sasha Levin <sashal@kernel.org>,
 stable@vger.kernel.org,
 WANG Xuerui <kernel@xen0n.name>,
 linux-api@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <D19DB99F-B5D9-49A6-BCF8-A5980A9BC1A0@gmail.com>
References: <DF762B6F-360A-4C0C-8C85-55686417209B@gmail.com>
 <2024082057-coherence-lethargy-3513@gregkh>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
X-Mailer: Apple Mail (2.3776.700.51)

Hi,

> 2024=E5=B9=B48=E6=9C=8820=E6=97=A5 21:36=EF=BC=8CGreg Kroah-Hartman =
<gregkh@linuxfoundation.org> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> On Tue, Aug 20, 2024 at 09:19:04PM +0800, Miao Wang wrote:
>> Hi, Greg
>>=20
>> I saw you have included commit 7697a0fe0154 ("LoongArch: Define
>> __ARCH_WANT_NEW_STAT in unistd.h") in your stable trees, which
>> actually introduced new sys calls newfstatat and fstat to Loongarch.
>=20
> See the documentation in that commit for why it was done.

Thanks for your explanation. I totally understand the necessity of
re-introducing thees two syscalls. I just wonder whether there is any
limitation on what can be included in to the stable trees. If there
was no limitation, theoretically, I could also maintain a so-called
stable tree by applying all the patches from torvalds' tree, except
those that bumps the version number. Apparently such a "stable" tree
is far from stable.

>=20
>> I wonder if it is correct to add new syscalls, which actually changes
>> the kernel features, in stable releases, as it might confuse =
downstream
>> developers because they may assume the existence of a certain feature
>> after a certain version.
>=20
> Version numbers should never be used to be checked for anything as =
they
> are only a "moment in time" stamp.  They do not reflect features or
> capabilities or anything else.

I agree with you and Cyril on the version numbers, recalling that =
kernels
on RHEL numbered on 3.10 contains various new features.

> Test for functionality if you want to check for something, that's the
> only way it will ever work on all of the variants of different
> "enterprise" kernels.

Thanks again for your quick reply.

>=20
> thanks,
>=20
> greg k-h



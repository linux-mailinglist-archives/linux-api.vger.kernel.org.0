Return-Path: <linux-api+bounces-5243-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C867C52B43
	for <lists+linux-api@lfdr.de>; Wed, 12 Nov 2025 15:27:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 252004E4A29
	for <lists+linux-api@lfdr.de>; Wed, 12 Nov 2025 14:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BBCD23D7DD;
	Wed, 12 Nov 2025 14:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zt3v8JFJ"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DDBF222587
	for <linux-api@vger.kernel.org>; Wed, 12 Nov 2025 14:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762956123; cv=none; b=efm/NYvxiYImyDKB31H8eHPriaP9Gv9R9hte/PyRWjCsPSbW0PW+8IwljN2nsMIV03ox2kdFKXIWmTdj6CklWJ6JH6nLG5gQg8RY0giWm+6UvqT2M05VirWe8bWMFNL+ri0gsFw81SPCCeeYyzHY9Gc4Ui7RU3KKl+DcZoT5xe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762956123; c=relaxed/simple;
	bh=6flJNLXgwwe1bxyVIrBjw3X8D6FAWRej7avnnwS5w8w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W+Fdk+Zb7Ltvl64fyReqmUEyoDjPpyhCjH5r9rOi7yczhEG2flWjMbAq16RW79jPdzzHODNrf6yX8h7gNs/6Qwm41crohvhtMAzws7yXFFw8MWtnbWTt61SVqHdzphIuEefL5SqWXPSJO8C8KOvYgd3aTyVPPe+rwoGevV/zEso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zt3v8JFJ; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4775e891b5eso4378505e9.2
        for <linux-api@vger.kernel.org>; Wed, 12 Nov 2025 06:02:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762956120; x=1763560920; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cFiNysBG6OvNw9jo5O2oUZrLaPvoxn/0er906rz18Og=;
        b=Zt3v8JFJyvZPmu3dSusMRTFJynteQLGAn/pjB7u/p8kyajCPsicxRsW4rac28gqUTu
         jzBMdgS3Pr+1fLkH9tPQZIAM8nbRszr/QbQt0jkK3wX+Z00Z14q1oqxl2TO/XBYZora4
         /U0KC8qbU4/ez5eBRh/z1GvQLxugJS0ba3mwJdMuP7VEOdXHEBwStYM5lgrnsN27IBZa
         WWjDGGXt/gVuo2KyWTLsJ/8tM30LycKBm6DdZZpVYCyoaujjWI8HeDnuFaMWQs9YIC0F
         CqYm/rFwJ3LNiNOCoLuQPcoXv5z7QOE1I08+WzNQDqfs//fw4gjqDQTHqnmv9T6O7KTu
         l/3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762956120; x=1763560920;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cFiNysBG6OvNw9jo5O2oUZrLaPvoxn/0er906rz18Og=;
        b=pc9nJmtan4VMTiw4pG0JOFsMyx9oI46ohEUr/Binj3OYmy9J9c/n+dvygHfoNyvk/G
         cOxroBs47LEuLfjZV6gq9xw7yHXQ+uIcVcDgNvmqBik9yvegMzgxCHYnTdXBWUBTsGEX
         LkKoZDniaJiaOJykakn3PPmyd8VJj6kfwTvQV7AQyjpH7N5CdD/KWGlF8n9a0q5SsspK
         f/k71wgxF4bvh2eK7m/jfHreJ1qOLda7OwKXaL1gVwj30B9td+YKze2uZOGwzo5oh9u2
         +z1wvs1wukRu+5JJXa/jTiJeklkC9f/Rd3GAse/jzfmmtAEwnGOQZuizdog+z5bx5tRt
         HUmw==
X-Forwarded-Encrypted: i=1; AJvYcCUX1UtA/iUFo2/jwiCMNGkMXaB78HeXIiHe7jxDtritk955OimLqI33S84o0NQrVz9BVZIWCTxtTas=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywg6DO0dhbQ8+0HFNskStsox9sMmq902B3brhwZLANl9oquSoSg
	BrIqvVVtv0iS50v3W/filq+LuLjgNQJRK6XS5eUyhBfvPhSXcNEwgBBC
X-Gm-Gg: ASbGncuRag8SBmVUlxenqxyAUMV/u5/64RrQMEzGt4qcLAAAOW/b6hY68G6NLCZLvOO
	u/HkEGhtp+VjycSnUWM89UyLX3Yfxb4S/WTVA4aiSVSySkywDWLFm0wY+1CxjozpoD48dff254o
	J97xRpPqkyQgD5voxofKtHxTA6G19zqhiYLNbRg3ZVA9QLs6y9rR4VU68NOOIs1jwr1VHuRn/on
	JxbRk49tnE2vaIBskrq5SCOC5PvsKuUnazbDAi+k/v7r9jdj8Pzvje4OsVmqSc8ctE17h2HK3B6
	0DRJj5WSS27pj3dr5sPzEzXEFkVFgYjNdmuNE+MnUHS5oqG+VVNeL2khFttOg8DVoofndFt3KPd
	y4RCD44PpcAr+JCUgRAwyuctfaCXqFKnrQKLIBZuUx6n1LtOzSfmO88ZuWAC2nM9bHMDCY59whe
	MmOGAlmdgtumtQfcXr7fXEABLun0Cg48NTohCCDoGq5g==
X-Google-Smtp-Source: AGHT+IEPEHr94PrGNc5EHN4MH5qDhAUHAyxSl1e3kw9Nt1S+if+1dRlR+YYzG83HBOq1lnqrURitPg==
X-Received: by 2002:a05:600c:3b17:b0:475:de12:d3b2 with SMTP id 5b1f17b1804b1-477870cdce6mr27931775e9.36.1762956119466;
        Wed, 12 Nov 2025 06:01:59 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47789ffea1esm16272835e9.13.2025.11.12.06.01.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 06:01:59 -0800 (PST)
Date: Wed, 12 Nov 2025 14:01:57 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Mark Rutland <mark.rutland@arm.com>
Cc: Chenghai Huang <huangchenghai2@huawei.com>, arnd@arndb.de,
 catalin.marinas@arm.com, will@kernel.org, akpm@linux-foundation.org,
 anshuman.khandual@arm.com, ryan.roberts@arm.com,
 andriy.shevchenko@linux.intel.com, herbert@gondor.apana.org.au,
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
 linux-api@vger.kernel.org, fanghao11@huawei.com, shenyang39@huawei.com,
 liulongfang@huawei.com, qianweili@huawei.com
Subject: Re: [PATCH RFC 4/4] arm64/io: Add {__raw_read|__raw_write}128
 support
Message-ID: <20251112140157.24ff4f2e@pumpkin>
In-Reply-To: <aRR9UesvUCFLdVoW@J2N7QTR9R3>
References: <20251112015846.1842207-1-huangchenghai2@huawei.com>
	<20251112015846.1842207-5-huangchenghai2@huawei.com>
	<aRR9UesvUCFLdVoW@J2N7QTR9R3>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 12 Nov 2025 12:28:01 +0000
Mark Rutland <mark.rutland@arm.com> wrote:

> On Wed, Nov 12, 2025 at 09:58:46AM +0800, Chenghai Huang wrote:
> > From: Weili Qian <qianweili@huawei.com>
> >=20
> > Starting from ARMv8.4, stp and ldp instructions become atomic. =20
>=20
> That's not true for accesses to Device memory types.
>=20
> Per ARM DDI 0487, L.b, section B2.2.1.1 ("Changes to single-copy atomicit=
y in
> Armv8.4"):
>=20
>   If FEAT_LSE2 is implemented, LDP, LDNP, and STP instructions that load
>   or store two 64-bit registers are single-copy atomic when all of the
>   following conditions are true:
>   =E2=80=A2 The overall memory access is aligned to 16 bytes.
>   =E2=80=A2 Accesses are to Inner Write-Back, Outer Write-Back Normal cac=
heable memory.
>=20
> IIUC when used for Device memory types, those can be split, and a part
> of the access could be replayed multiple times (e.g. due to an
> intetrupt).

That can't be right.
IO accesses can reference hardware FIFO so must only happen once.
(Or is 'Device memory' something different from 'Device register'?
I'm also not sure that the bus cycles could get split by an interrupt,
that would require a mid-instruction interrupt - very unlikely.
Interleaving is most likely to come from another cpu.

More interesting would be whether the instructions generate a single
PCIe TLP? (perhaps even only most of the time.)
PCIe reads are high latency, anything that can be done to increase the
size of the TLP improves PIO throughput massively.

	David

>=20
> I don't think we can add this generally. It is not atomic, and not
> generally safe.
>=20
> Mark.
...


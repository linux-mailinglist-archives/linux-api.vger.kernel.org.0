Return-Path: <linux-api+bounces-5106-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 34B0BBD5750
	for <lists+linux-api@lfdr.de>; Mon, 13 Oct 2025 19:21:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D32194EA806
	for <lists+linux-api@lfdr.de>; Mon, 13 Oct 2025 17:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B4F42C11D6;
	Mon, 13 Oct 2025 17:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nInNi8ld"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4513B273D77
	for <linux-api@vger.kernel.org>; Mon, 13 Oct 2025 17:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760375712; cv=none; b=e0yAV3v4TLwlFEJVvzymDAbWtVUuMEgg9n+SbQy7J+F+GyWADtghO2k4dk/iTqZ65EwkFuifl2G11wgjcCJQ6yxW4lY8ZP6GsF0mfpesnDMkbW1HEURqPCc45Z1TnwL4WKTUb9YXcNJQaO11c3Tfn5pB48+nNOfJrmXCYrLR1No=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760375712; c=relaxed/simple;
	bh=qg3NRHdeNA4Fg5h3g9E13z1ZmJaUuUt4rsIs+bfAZf0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gg7AwL5XV1CTlvy1t5ucoBiDG/3zpw/NxGRewtKu3yP7tnH3VUks5roV5H6qLILpF3dFKqOL7uDp8805AtVJMHpH4hVoJ9Y30syA884QHAHoAgZwz1Kq0Nz9vdmPq7O6PoiNc+NXEOA8d7OBLDW06F9/D6OXU76MACOqZHg3HBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nInNi8ld; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17F7EC2BC86
	for <linux-api@vger.kernel.org>; Mon, 13 Oct 2025 17:15:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760375712;
	bh=qg3NRHdeNA4Fg5h3g9E13z1ZmJaUuUt4rsIs+bfAZf0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=nInNi8ldgd1mbqOSNYEn0pvWDU/WshfNHypWq71z7uedvu9QnRfeqGNexbgxkQWls
	 f2uSbfqG61R0A7mseEzZHj5XzQdF4CKWpU8WYjlz7LGv0ZD7jEV1HjvOJDz4QmW1nv
	 7xejInsLO+AwE5lGA5DuIDUXa905yRbcZf8QTe1rCeC1iR7E3MOR2rj1iOyyl3h8E6
	 q56Yj6mpnz4vm1ikUfWkH3B45H06p59zFUjdS/IoBGKAA45YFyC3iXzYEXNxkboYJQ
	 /XsOeh2UIs5o+N21V8eMOivhe2kaee1fG903o6NTrx/vhqLEntGtDyLt+O6Iy1bxTH
	 r5nBrhzJ5zA4w==
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-57b8fc6097fso1391373e87.1
        for <linux-api@vger.kernel.org>; Mon, 13 Oct 2025 10:15:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWBeOx2wIk6ne6DIXdZkCLq7uEWSfv4j7JpsWzIDLNahnQntXWL81GtpWR/ogu8uzeZMbsXOnTpqB8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy49isvymohBYkr3DfDYSHkGlTn5naoVIsNM3343oXGEV6f3aKu
	xzB3IamY2GccyIuijR2/G4IwBYYsIaj2kWJoYCbLrx8NyGnqGTXFg9XGU7r8Ijx0k6Tliw1mcT9
	KL1kSj7eI/GJAVyb8M2/B3/gSTqAFxF6qsF5sBiTX
X-Google-Smtp-Source: AGHT+IFe+SzxnNHmLcFlvnfkJvIZjwnZkm1Ok6JvoMYuj8nhVWXCmwvh0KaZdzeEUyoNuxcssWgKIbqhAnjyljsSJMw=
X-Received: by 2002:a05:6512:230c:b0:573:68fd:7ad2 with SMTP id
 2adb3069b0e04-5906dd53da9mr5881107e87.35.1760375710222; Mon, 13 Oct 2025
 10:15:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251013-getcpu_cache-v2-1-880fbfa3b7cc@linutronix.de> <e95dc212-6fd3-43e3-aeb7-bf55917e0cd4@intel.com>
In-Reply-To: <e95dc212-6fd3-43e3-aeb7-bf55917e0cd4@intel.com>
From: Andy Lutomirski <luto@kernel.org>
Date: Mon, 13 Oct 2025 10:14:58 -0700
X-Gmail-Original-Message-ID: <CALCETrV2W3cZEJ2yy7F-F9=e_8HLP84ZWrOJCzUYn_ASb0+M6A@mail.gmail.com>
X-Gm-Features: AS18NWDGlHiZ6TxV2AYIYIygvwnW3vlieR2fC4dbq7adbnnZ1RUCMMYySi05JAY
Message-ID: <CALCETrV2W3cZEJ2yy7F-F9=e_8HLP84ZWrOJCzUYn_ASb0+M6A@mail.gmail.com>
Subject: Re: [PATCH v2] vdso: Remove struct getcpu_cache
To: Dave Hansen <dave.hansen@intel.com>
Cc: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
	Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Andy Lutomirski <luto@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Richard Weinberger <richard@nod.at>, 
	Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, 
	Vincenzo Frascino <vincenzo.frascino@arm.com>, Shuah Khan <shuah@kernel.org>, loongarch@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, 
	linux-um@lists.infradead.org, linux-api@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 13, 2025 at 7:07=E2=80=AFAM Dave Hansen <dave.hansen@intel.com>=
 wrote:
>
> On 10/13/25 02:20, Thomas Wei=C3=9Fschuh wrote:
> > -int __vdso_getcpu(unsigned int *cpu, unsigned int *node, struct getcpu=
_cache *unused);
> > -int __vdso_getcpu(unsigned int *cpu, unsigned int *node, struct getcpu=
_cache *unused)
> > +int __vdso_getcpu(unsigned int *cpu, unsigned int *node, void *unused)=
;
> > +int __vdso_getcpu(unsigned int *cpu, unsigned int *node, void *unused)
> >  {
> >       int cpu_id;
>
> It would ideally be nice to have a _bit_ more history on this about
> how it became unused any why there is such high confidence that
> userspace never tries to use it.

The theory is that people thought that getcpu was going to be kind of
slow, so userspace would allocate a little cache (IIRC per-thread) and
pass it in, and the vDSO would do, well, something clever to return
the right value.  The something clever was probably based on the idea
that you can't actually tell (in general) if the return value from
getcpu is stale, since you might well get migrated right as the
function returns anyway, so the cache could be something silly like
(jiffies, cpu).

I don't actually remember whether the kernel ever used this.  It's
possible that there are ancient kernels where passing a wild, non-null
pointer would blow up.  But it's certainly safe to pass null, and it's
certainly safe for the kernel to ignore the parameter.

--Andy

>
> Let's say someone comes along in a few years and wants to use this
> 'unused' parameter. Could they?
>


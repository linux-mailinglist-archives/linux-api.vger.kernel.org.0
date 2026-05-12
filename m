Return-Path: <linux-api+bounces-6328-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OJSTHUSZA2p27wEAu9opvQ
	(envelope-from <linux-api+bounces-6328-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Tue, 12 May 2026 23:19:00 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E388A52A2B2
	for <lists+linux-api@lfdr.de>; Tue, 12 May 2026 23:18:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D719F302429B
	for <lists+linux-api@lfdr.de>; Tue, 12 May 2026 21:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1667A3750BE;
	Tue, 12 May 2026 21:18:58 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7979C2857EE
	for <linux-api@vger.kernel.org>; Tue, 12 May 2026 21:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778620737; cv=none; b=eQ7ReBjvrQo7Fd0vjSoPO/hMy3sQD2zfCFVWAFFjMMtb0+2gSdtHdKJejRiod7x3G1VbWVzqo43/JohtD0VFuSWlYQMOqAf4uUhhlzQrm6riu4x925OaukN79ieA0pORINe8fP0e7IJh0MyCYhv9yViYR8SEKVydtx4vs5zYuLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778620737; c=relaxed/simple;
	bh=ZF+m+ZjVtnGgRZxs8fykE/7UK37XkDux4yfRZUGOw5Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EoQR3iJ+3T8gg+6Fiz0Qow22mn/bKi593aeem1/Ph29SC/5IWY6dKQKSJuiGNnbtZqOzEGro6HfDo43QFT63CVoEjuVwCqjFPTDRqE+z+atPI0qZPthYr5mdnp3IyjcOeU8DPC3vdou57QMMJ8Uqqv5+tU0smRw1f1txfw4jbPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.win; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.win
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-bd373f83042so92687366b.1
        for <linux-api@vger.kernel.org>; Tue, 12 May 2026 14:18:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778620735; x=1779225535;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ULDGSLAty8SEh/aPzQ3wMjjybANkPqfntQTcejrtbks=;
        b=sQDsvOnvdRSFq6pUL6ev7skWZUu1eUBiRgfSPDWZGOL7urZtV1Nk0QLs2cXSK3Tw6w
         y9H0P3N6L094rLwS+rQq/RCeXm6WmPi9GDjJrtILImvC0ujWYHKUyGKd/cT5bavzmubs
         rwY3K6aQkpzJK1v17uidC9bP7Mu9ECOZSvtvflmSQYgEdre4FaDUuJ7XVG9p/3WPvKto
         3nGpN5djsv389Nnv1Ur2Lto/Eo14EEB9C62aOP0ueKpvEhctgJ7Jb+6yHt5DAXHD1Zf7
         XzNw6mVMORBk4el5CRp7LefBIOcjY8cLe4FuyKq5L7RwUJKJorlDQ5hNFmiOcT6jcgfp
         X2tA==
X-Forwarded-Encrypted: i=1; AFNElJ8VgGltd8/ygjx8LdnKGX+K3WiNIoq2Zf9jBfBYNQoOvcFx7x0Rwp9XBAjQLyyQr4FNrmKL9P90QTQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyieqUF094N6ajtXvdSKGabAuiW4GoMOXnrnn+AgAD4A1VSLi6R
	x0UoHiTgDMfvUZAcu+8QUnIfQBlwP9UGznw+Oy5N4mThW6X+xRiJ/5yblkhdxA+mH3M=
X-Gm-Gg: Acq92OGxuei4cM2X3rZHNlVNuw23nxkgxQVsCxOREwJWTJV8KIFgx9alGA6XgeBSq29
	7oOmGOEhSo9hMQsTtGEoTZfUFFJ/hQ13PThRyPGlEewATTiAjGz607qgUfcboUnTCgvMPOxcTD+
	iY6l7blzwmiCfu68iXoJDKwtW2YCsovhNglry8woy6Aricex5PvR8V8PVHwhswBCvGrTvvUFFn9
	ONJfWdXCCLLOYGhgOSUftRiqzPQGlAox9iBen+aJFftV1sRTmYXwCMQ3Rs/UoV6pjfuToP5/XEA
	sk8RPhgL76ZKcllBDWxj/Ubjobbj5n96Ff+hpKt52XLoKlnLe2ixrfB6p4s3nfZEmdBnxAVTJxI
	NUYzD42Tk95eXgcuutKLE+dzfGKmThufYIF6oxvrxw4NeyKQXgLWU29WovLEEOOjdO7DOJ8cApn
	krZXL0z+d+Dc6puGog/dCCYNc5vQxLGv9jQemFx6fhuWCfuCU3aS4kQw==
X-Received: by 2002:a17:907:3ccb:b0:bbd:ceba:97b6 with SMTP id a640c23a62f3a-bd3bc7df480mr27373166b.0.1778620734365;
        Tue, 12 May 2026 14:18:54 -0700 (PDT)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com. [209.85.218.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bcfc09a8e07sm376496766b.49.2026.05.12.14.18.53
        for <linux-api@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 May 2026 14:18:53 -0700 (PDT)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ba545100a13so1031385466b.2
        for <linux-api@vger.kernel.org>; Tue, 12 May 2026 14:18:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8GbhB7AM7PTx1QRnt11/ZxOiYsqbfCxOgSRH6VKmU42mWX6RGgmM+kGrddWPVNh4Cf82HqEFRmM+w=@vger.kernel.org
X-Received: by 2002:a17:907:80a:b0:bd1:e36f:1ad7 with SMTP id
 a640c23a62f3a-bd3bf484689mr27989066b.9.1778620733204; Tue, 12 May 2026
 14:18:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALCETrVqG+1yErRJjkxvJrf=A+Vu84HTR4Bx1Pcd8G1C0PJcMA@mail.gmail.com>
 <14A441D8-5370-44BE-8732-99BF8107C3FD@getmailspring.com> <0b8bba44-f6bb-4d69-b9d4-5787c276d41a@inspirated.com>
 <20260510163204.GA2279@sol> <3bfcf406-fdde-4303-9bd6-0d8d21ddba37@linux.win> <20260511213829.GA316710@google.com>
In-Reply-To: <20260511213829.GA316710@google.com>
From: Ignat Korchagin <ignat@linux.win>
Date: Tue, 12 May 2026 22:18:42 +0100
X-Gmail-Original-Message-ID: <CAOs+rJUA+bz6Y2GKioHnFGFKX_uAP+4LaPRs=ZDgRQoUi4mWkg@mail.gmail.com>
X-Gm-Features: AVHnY4IXFsTsREC72LukcHqvk6gC-iS5eeOIEbsMsX37ajVDHN0xSqZ-iDLXxGU
Message-ID: <CAOs+rJUA+bz6Y2GKioHnFGFKX_uAP+4LaPRs=ZDgRQoUi4mWkg@mail.gmail.com>
Subject: Re: [PATCH] crypto: af_alg - Document the deprecation of AF_ALG
To: Eric Biggers <ebiggers@kernel.org>
Cc: Kamran Khan <kz@inspirated.com>, Jeff Barnes <jeffbarnes@linux.microsoft.com>, 
	Andy Lutomirski <luto@amacapital.net>, 
	"linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>, Herbert Xu <herbert@gondor.apana.org.au>, 
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, 
	"linux-api@vger.kernel.org" <linux-api@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: E388A52A2B2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6328-lists,linux-api=lfdr.de];
	DMARC_NA(0.00)[linux.win];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-api];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ignat@linux.win,linux-api@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	RCPT_COUNT_SEVEN(0.00)[11];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Mon, May 11, 2026 at 10:38=E2=80=AFPM Eric Biggers <ebiggers@kernel.org>=
 wrote:
>
> On Mon, May 11, 2026 at 10:03:21PM +0100, Ignat Korchagin wrote:
> > I don't think fully discounting hardware offloading is beneficial here.=
 HW
> > accelerators will be produced and without a common interface vendors wo=
uld
> > start implementing their own "bespoke" drivers with bespoke userspace
> > interfaces (we already had such proposals), which in turn may introduce=
 more
> > attack surface. Yes, AF_ALG needs substantial improvement, but at least=
 it
> > can be a standardisation point.
>
> That isn't the best way to accelerate symmetric crypto anymore though,
> if it ever was.  This has been known for a long time.
>
> > > In any case, any hypothetical security benefit provided by AF_ALG wou=
ld
> > > have to be *very high* to outweigh the continuous stream of
> > > vulnerabilities in it.  I understand that people using AF_ALG might n=
ot
> > > be familiar with that continuous stream of vulnerabilities, but it wo=
uld
> >
> >
> > Is it actually that much compared to other features/subsystems, like eB=
PF or
> > user namespaces? But we don't rush to deprecate those - instead trying =
to
> > harden them and come up with better design.
>
> There are plenty of other kernel features with a large attack surface,
> of course.  But they tend to be much more useful than AF_ALG.  It's all
> about weighing benefits vs. risks.

If divide number of CVEs in such systems on imaginary units of
usefulness, I think the ratio is similar.

> When we get the point where a large number of Linux users *had* to
> disable AF_ALG as an emergency vulnerability response, and at the same
> time their systems weren't even using AF_ALG so nothing even broke and
> they could have just done that to begin with, I think we get a very

Well, there were: cryptsetup, RHEL fips check, so there are some...

> clear idea of which side is heavier for AF_ALG in the real world.

Same thing could be said for unprivileged user namespaces - distros
even put a custom sysctl to restrict it and no-one noticed.

> The main relevance of AF_ALG to the Linux community is that it allows
> their systems to be exploited.

To be clear I'm not arguing for the current AF_ALG implementation. I
agree, the splice zero-copy is... suboptimal (to be soft) and is
actually not-so-zero copy. But I think it was just added before we had
more modern approaches like io_uring (have their own can of worms, but
hey - people adopt it fast).

But I advocate for the usefulness of the concept itself - kernel/OS
providing crypto services to userspace. As mentioned in other threads,
other operating systems have it and Linux lags behind. There are use
cases: common interface for HW accelerators, embedded systems, which
don't have the space to bring a userspace lib etc. Even non-technical:
there are environments that just don't want to rely on third-party
userspace libraries like OpenSSL purely for licensing reasons. And I
agree, that it is hard to do it right, but we can piggy-back on other
subsystems (such as io_uring mentioned or other ideas).

> - Eric
>

Ignat


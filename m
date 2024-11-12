Return-Path: <linux-api+bounces-2710-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF6E29C4A78
	for <lists+linux-api@lfdr.de>; Tue, 12 Nov 2024 01:12:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F98F1F224D9
	for <lists+linux-api@lfdr.de>; Tue, 12 Nov 2024 00:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18CFA4C91;
	Tue, 12 Nov 2024 00:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b="H5CZj9C4"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp1.cs.Stanford.EDU (smtp1.cs.stanford.edu [171.64.64.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D7316AAD
	for <linux-api@vger.kernel.org>; Tue, 12 Nov 2024 00:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=171.64.64.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731370350; cv=none; b=kD5t2gnyHExntTlIdbGA10pTizgXDW7735Qazkmuv2dnpNo8D21rcSUmWC5R53iDfAb0yy2EBCYVwhJ1bnjiy8R2m21633spg4sglC9w6hET5FOu7NlbluiOMKlawGkjFCLH6utycOFHD7S/TalAwrcxHai7PitIB1jLbCe8Koc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731370350; c=relaxed/simple;
	bh=u9qjbnCJUhd7NofwqjQ5VFlDqjAEHdfp68DblOfXihQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WK1u/SlAtYCySovi0VIUMqWHQpSLSlK2Bnt35ySABp+ajp9wJAQz0u2mTlQPZRgvtJ/GU2MFv+LxAEfXVHhcCENqhSlGXliH8q3LOKQPF+ihV4ckJ8TZZpyLoHxieLxaL8ySz62GBLC0FerIO50KRCVrGxU3CczxWsVlOoDNGNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu; spf=pass smtp.mailfrom=cs.stanford.edu; dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b=H5CZj9C4; arc=none smtp.client-ip=171.64.64.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.stanford.edu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=cs.stanford.edu; s=cs2308; h=Content-Transfer-Encoding:Content-Type:Cc:To:
	Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=P+HBQpTcMjEKKa1v4uksmRdDJodv4lT59nkExfFyIGc=; t=1731370348; x=1732234348; 
	b=H5CZj9C4rWqxfKoeJGAnle6NTDxZ4qJ6gjQ/tICeQCwLBvM385tDuPgB5AwzK+f5hujFdkLP86g
	L6f+RCWObn7ktBQzzsfXe4nGz7DbZVdPgMm6NFDHuzdIkkJVuqg1CeF5rPrJ+L3W+PWhOUgjIvZgz
	Hwh0NPWdewmJa34qwjDMUgk1T1GyuYA6orQ6kXm+0eln/MMxdRBqz3iQ67t2MY2HBsraZJBrCrz9W
	2jtAVQL/Bx2rOOe4PapTBysnUAFB15twaSG0rK3xL3sRPcWpkExsRuo+sFLnvnJXDTRo6ooZxLPXF
	vKgKPK2Co1mSIO2gNnmLSjshyz/2t7tp3LmQ==;
Received: from mail-ed1-f44.google.com ([209.85.208.44]:58636)
	by smtp1.cs.Stanford.EDU with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.94.2)
	(envelope-from <ouster@cs.stanford.edu>)
	id 1tAeWA-0004eG-Ux; Mon, 11 Nov 2024 16:12:27 -0800
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5cecbddb574so6646454a12.1;
        Mon, 11 Nov 2024 16:12:26 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV1whnjjkYq+ktPxOhJwIKLaO3ojb2l6MyM4Eeb149qsixGjFgjee1k6LP0qqM5vc1INliLVtNh8WM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/1WlItfLraRWiD8LcEpVJORu2ZnNwmj+G8xpgTNRbSHxUoTcI
	D0Ik6Yt2H/8duYSDiHKRWoNCR1aXzFhsd31SBhAy0ekZV2ou1M6FMdySuqvKJymrYkVIYEzvr5p
	2OMB8dTJeQDN3X2qdqlXf8IPe1iI=
X-Google-Smtp-Source: AGHT+IEhoJjFOuksZxZJgi3/PyXihHcpXWc66txBt0Ma9K/xqmQs7ZleYWP4yPQVTEN7qwEKtCEz1UgLXG43FydD6qs=
X-Received: by 2002:aa7:cb07:0:b0:5ce:dfe7:97c8 with SMTP id
 4fb4d7f45d1cf-5cf0a4465f8mr9164752a12.31.1731370345549; Mon, 11 Nov 2024
 16:12:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241111234006.5942-1-ouster@cs.stanford.edu> <20241111234006.5942-13-ouster@cs.stanford.edu>
 <a405a8e6-7420-468d-be16-2bf1d73b7cbd@infradead.org>
In-Reply-To: <a405a8e6-7420-468d-be16-2bf1d73b7cbd@infradead.org>
From: John Ousterhout <ouster@cs.stanford.edu>
Date: Mon, 11 Nov 2024 16:11:48 -0800
X-Gmail-Original-Message-ID: <CAGXJAmxUSL2HayCDq7n7eJfVC+A+V3zR-V0Dc90AB_tV2UTD+w@mail.gmail.com>
Message-ID: <CAGXJAmxUSL2HayCDq7n7eJfVC+A+V3zR-V0Dc90AB_tV2UTD+w@mail.gmail.com>
Subject: Re: [PATCH net-next v2 12/12] net: homa: create Makefile and Kconfig
To: Randy Dunlap <rdunlap@infradead.org>
Cc: netdev@vger.kernel.org, linux-api@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Score: -1.0
X-Spam-Level: 
X-Scan-Signature: f69c4e6b4bf914f22ae37cd490358bf0

Oops, sorry, didn't know that. I'll fix.

-John-


On Mon, Nov 11, 2024 at 3:52=E2=80=AFPM Randy Dunlap <rdunlap@infradead.org=
> wrote:
>
> Hi John,
>
> On 11/11/24 3:40 PM, John Ousterhout wrote:
> > diff --git a/net/homa/Kconfig b/net/homa/Kconfig
> > new file mode 100644
> > index 000000000000..8ba81b00d35f
> > --- /dev/null
> > +++ b/net/homa/Kconfig
> > @@ -0,0 +1,19 @@
> > +# SPDX-License-Identifier: BSD-2-Clause
> > +#
> > +# Homa transport protocol
> > +#
> > +
> > +menuconfig HOMA
> > +     tristate "The Homa transport protocol"
> > +     depends on INET
> > +     depends on IPV6
> > +
> > +     help
> > +     Homa is a network transport protocol for communication within
> > +     a datacenter. It provides significantly lower latency than TCP,
> > +     particularly for workloads containing a mixture of large and smal=
l
> > +     messages operating at high network utilization. For more informat=
ion
> > +     see the homa(7) man page or checkout the Homa Wiki at
> > +     https://homa-transport.atlassian.net/wiki/spaces/HOMA/overview.
> > +
> > +     If unsure, say N.
>
> Kconfig help text should be indented with one tab + 2 spaces, please. (Ev=
erything
> below the "help" line.) This is in Documentation/process/coding-style.rst=
.
>
> --
> ~Randy
>


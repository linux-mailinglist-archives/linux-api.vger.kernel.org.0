Return-Path: <linux-api+bounces-6547-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id CvYeAkiIImovZwEAu9opvQ
	(envelope-from <linux-api+bounces-6547-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Fri, 05 Jun 2026 10:26:48 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 95C34646613
	for <lists+linux-api@lfdr.de>; Fri, 05 Jun 2026 10:26:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=Sr2t+Rg+;
	spf=pass (mail.lfdr.de: domain of "linux-api+bounces-6547-lists+linux-api=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-api+bounces-6547-lists+linux-api=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B4B3B304979D
	for <lists+linux-api@lfdr.de>; Fri,  5 Jun 2026 08:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E7DB3CAE6B;
	Fri,  5 Jun 2026 08:23:24 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EECB3C988B
	for <linux-api@vger.kernel.org>; Fri,  5 Jun 2026 08:23:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780647804; cv=none; b=m7Q0h5k4XjqFm3NqJWNG/ZnGmUFXCluP5XqKQ9fLt+p9KqcxuZeQE4PMeyH4DlWEkOPqY852oOrgZmtF6Wc4FzKzfgfsk2LBximr6LsbcSLlt1nx8UDLc9QKMMZ4moCzKJgQC5lGVMvQPCDGfdtlIlWop4b4tKhMWBPFNSCIHUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780647804; c=relaxed/simple;
	bh=eAlKvP2gsEfRQmVOZv1allmZysrFKO1fn5IMvtPZQiI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z6HrV1l8KEsHa/higSKq1/YxJiBpNBQVXa4CWhMhBu2hXBj8SPAz5KyGlfCM3RZMIpzuUzTaNQo2HZ1J35GvzbNw16KrDZnVq1x5ZXgsOLmeTN8aCEwo1cLruoM0wfJomSaHbk+Dc8MA8nznWP+yaB2Q1V5Kg4qEA6u4HyrFFQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sr2t+Rg+; arc=none smtp.client-ip=209.85.128.51
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-490ae94a89eso13867475e9.1
        for <linux-api@vger.kernel.org>; Fri, 05 Jun 2026 01:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780647801; x=1781252601; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/ncylH/iADc8ME04RgleGvGv2QOfG/3EuEqLEAZ+XWA=;
        b=Sr2t+Rg+htecQ7mMDjt3jafvQkDhGt20df/P3Cs/4kP9/frGVSzMbw4gnwBzd7/Glb
         LQbaGgyEOKmp0NA0I7tpfquCUZnW5dx7ofSQTISET7S9/TSCx/edEE44cAlsU8t/C1A7
         QxxeGoSuXd/6QdVNsPk5sz9NtojZ2YzWl4Py5FhloNRfW4Y56av/HK5gGGjDf9vUPM0E
         jvDA2EXN6mQYtlbAwAa9ZI8nojXgk5RPdnMQl2lQdGDHELa2SpxkDw48WGMtqqgTyYlY
         aahI9vhG463Zn0IB/786cAmx0P9o+uy1XxsGb0uTPK7rSpGsf1H74Q1M1BWfiZDNXwaL
         SiKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780647801; x=1781252601;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/ncylH/iADc8ME04RgleGvGv2QOfG/3EuEqLEAZ+XWA=;
        b=SydQ2XiwQqRgmbkDRtsBIhcu++6/6eQ/Qg2wousnI/MIqofTv1B1mQIxNt7n/4mryb
         NK3yvlSRXrH8mGqW2Tt1yuG14dGSZVKghXZJ893ia8gY0oELrt5JoF7xfUYD8cb0jOvX
         26153DkMUTHcZIYYKlu+ltk4rH5RI3LHVTRXFlJNpY5GJTWxLCii1QqgovQ2TCC7RPxu
         YQxFHDitxYUaC2rgVkhx377UZIulWwCQdNm3yzM+9rkU86Y4YIaDvEAdc5DUbWZrOxSA
         VSddEOABktUwlnk7lsxpCvNFowtQmBTsXHSVeFTJ8Iyr1P24F7dm+lB0GQuOp9ggcOUv
         f2Jg==
X-Forwarded-Encrypted: i=1; AFNElJ9ZKQu0s/kF//nqGRTNzVEeRvxiZMZAvvYEQMDfMI9ATsyGlrYpJ/X4NrtLRrItwLeRiPff8vX3MCk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzfq6dqScnwcyPhzKe/aTyli+1clLLNuZimhxn644WdBuarMENg
	M+9YOnXE4FN+lgD1gg8AfF1FMYVQndlPQih0RUzSF/hAk6IXfPP1lRGI
X-Gm-Gg: Acq92OE9KrLjK8e2Fsu6DoEA4YgWFmaR+CumZXpY1rTaMENSk5iQYQHbamNdRoGfG7d
	Vg+wXNh5YTJ4zGrG8+FX0/PhzbK0krYhaVgi95CkccXku/CznF4B4MWslUT9sqcJ0iWChQFzEiF
	jSU/bekx4juoRIY0IDO/vt01KGoIME/RfiF5T9+HzDrL1sO/plWBq1Y3grsA7QKiekibdWzwMTe
	O9Dt/pPbY+Z+RHnWYMl+M7NrlmnneczzrIrPTgeu0Td2yYlzzARTjGVEgM161issSYwNAksZGi5
	Ar7O5OvAEEOOTOXu7bjYQTrL9gA7JGpOL5Yfw6cCyFt7MHv35PdhGx1w1hIPDZBeiBHp6SRvfS5
	ZEMd8BJpNXB5SJko+gXyXexetY0os6nYaC+TbJkveOlwlptHH0qQ6lujKVsYOvJ1mR5QUoed5pd
	fu/RD/irqujbLK6Ma0rVJ4EsNobumQbjCqeM158/Dt7t434+BBlTqQ2ZjSYz8TqhG1/UEwcgdG0
	MTNQuGybA==
X-Received: by 2002:a05:600c:4fc6:b0:490:51e9:deba with SMTP id 5b1f17b1804b1-490c2615a5cmr34498005e9.27.1780647801274;
        Fri, 05 Jun 2026 01:23:21 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2f67c6sm23925419f8f.16.2026.06.05.01.23.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 01:23:20 -0700 (PDT)
Date: Fri, 5 Jun 2026 09:23:19 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Askar Safin
 <safinaskar@gmail.com>, metze@samba.org, akpm@linux-foundation.org,
 axboe@kernel.dk, brauner@kernel.org, david@kernel.org, dhowells@redhat.com,
 hch@infradead.org, jack@suse.cz, linux-api@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, miklos@szeredi.hu, netdev@vger.kernel.org,
 patches@lists.linux.dev, pfalcato@suse.de, viro@zeniv.linux.org.uk,
 willy@infradead.org
Subject: Re: [PATCH 2/3] vmsplice: make vmsplice a trivial wrapper for
 preadv2/pwritev2
Message-ID: <20260605092319.5a1bba74@pumpkin>
In-Reply-To: <20260605015724.GA520134@ax162>
References: <f919874c-065e-48be-ac5b-300c4ab86d4e@samba.org>
	<20260603211736.755139-1-safinaskar@gmail.com>
	<20260604100609.6b37f500@pumpkin>
	<CAHk-=wjvb56qo27-axALOKCY-CjLsj9_294zeBovPVJaYm14dA@mail.gmail.com>
	<20260604183829.63c35fd9@pumpkin>
	<CAHk-=wip3mwLOHOYJ9TtjDxOaq9YUXmuCg2AycyASGgeY6qqUw@mail.gmail.com>
	<20260604223216.73468830@pumpkin>
	<20260605015724.GA520134@ax162>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6547-lists,linux-api=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[davidlaightlinux@gmail.com,linux-api@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_RECIPIENTS(0.00)[m:nathan@kernel.org,m:torvalds@linux-foundation.org,m:safinaskar@gmail.com,m:metze@samba.org,m:akpm@linux-foundation.org,m:axboe@kernel.dk,m:brauner@kernel.org,m:david@kernel.org,m:dhowells@redhat.com,m:hch@infradead.org,m:jack@suse.cz,m:linux-api@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,m:miklos@szeredi.hu,m:netdev@vger.kernel.org,m:patches@lists.linux.dev,m:pfalcato@suse.de,m:viro@zeniv.linux.org.uk,m:willy@infradead.org,s:lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[21];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linux-foundation.org,gmail.com,samba.org,kernel.dk,kernel.org,redhat.com,infradead.org,suse.cz,vger.kernel.org,kvack.org,szeredi.hu,lists.linux.dev,suse.de,zeniv.linux.org.uk];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,linux-api@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-api];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 95C34646613

On Thu, 4 Jun 2026 18:57:24 -0700
Nathan Chancellor <nathan@kernel.org> wrote:

> On Thu, Jun 04, 2026 at 10:32:16PM +0100, David Laight wrote:
> > Talking of broken compilers, had you noticed that:
> > struct foo {
> >     int a;
> >     char c[32];
> > };
> > 
> > int b(struct foo *f)
> > {
> >     return __builtin_object_size(f->c, 1);
> > }
> > returns -1 (size unknown/indefinite).
> > You can't use __builtin_object_size() to stop code running off the end
> > of anything referenced by address - even when the size is constant.  
> 
> That is the entire point of using '-fstrict-flex-arrays=3' in the
> kernel:
> 
>   df8fc4e934c1 ("kbuild: Enable -fstrict-flex-arrays=3")
>   https://godbolt.org/z/bvfrh7W58
> 
> Without it, all trailing arrays in structures are treated as flexible
> arrays, even those with fixed sizes.
> 

strict-flex-arrays got added in gcc 13.1 and clang 15.0; it isn't supported
by the gcc 12.2 on the debian 12 system I'm building kernels on.
__buitin_object_size() itself is in gcc 4.1.2 and clang 3.0.

Neither are flex arrays mentioned in the gcc docs for __builtin_object_size().

Someone might have used (eg) 'char x[4]' as a flex array to include the
padding, but no one would have used anything that extended the structure.
And the chance of those hitting __builtin_object_size() is even smaller.

-- David



Return-Path: <linux-api+bounces-5781-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kPDlEamQfGkQNwIAu9opvQ
	(envelope-from <linux-api+bounces-5781-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Fri, 30 Jan 2026 12:06:17 +0100
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BD8CB9C4B
	for <lists+linux-api@lfdr.de>; Fri, 30 Jan 2026 12:06:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3EDFE3064012
	for <lists+linux-api@lfdr.de>; Fri, 30 Jan 2026 11:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0938C378837;
	Fri, 30 Jan 2026 11:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QNS095FJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hho8lmdC"
X-Original-To: linux-api@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C5C378829;
	Fri, 30 Jan 2026 11:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769770955; cv=none; b=oxnNlMnqVBQpwactnWWo2tqhDyG70snaHq2vUFAyeJiJ337CrfGH/Jh0Rlc27jQUC/fYqkJwbw3bJw6tEa60uqgjVNGhR5l1VzFBPZermZTB/GhGhCP3drf5OOg01Dxlt5ERc7yVf3Tp6yRSxY9hY8BKcAsHeBwLdWcR9DAtJR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769770955; c=relaxed/simple;
	bh=PD1NyunvwPhHThCv9EYctRyLMEFxSdyzAf+tt6pxd9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q85LduXrIrh0/oXDB3Bz+w6Zg+K6D+RozmzT+IdXM+Ukj4LT7Usw1HjEBri1V0CoGzggpRLs/N9bHOMPiAl5jeN7NEA3rfkdnQfmPWlsAi140dPAJSytGcGKjUg49VqIWG30o9HA3jqTFt3E2y8jNh3wvtpnS9IozEikYu07ZKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QNS095FJ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hho8lmdC; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 30 Jan 2026 12:02:32 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1769770953;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=O3rWeggyKHIdYr1HSLSfoFm5KQ84IafzY02+OHo3Dus=;
	b=QNS095FJ8C29mE29P8FUxmUpoJee/JL9s0dqd5Ulc/6ZQhUHUc/9OmnO8ljjA0QNfSxwi8
	O6VKy8YiLwWvfoRxzH4pDBSeLtmZMlOAWjQ38hNlfMDChxWXIoDXligwardDfN5k4QzZZh
	FY3qWlD9qcCHU+NyJ5H/qawpspidfjLHKNt4Feu7BMOOlsgQVC/0gsLCgVSwcli9ndwf5S
	0jnYmOyKOlHK7gYpFSWzIaWuSnOMm4gAbQ0x2yk9W4vpZEDl8Lxm5zXOE0lU7qRxr3ka3E
	FkjTlodGFTfEuzkkMYT/zq50AlM1Q8A0vdwT5WcDBj3uThSqB1O38Y99pJdWEQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1769770953;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=O3rWeggyKHIdYr1HSLSfoFm5KQ84IafzY02+OHo3Dus=;
	b=hho8lmdCZM17n1KK9Si8r3pZxvRh9cXf5lyzpu2wwOYBAW9i2MfbTf37FIivoHLQNTjJV0
	WlZJxwaQgPQmBpDw==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Eric Dumazet <edumazet@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, Xi Ruoyao <libc-alpha@sourceware.org>, 
	Carlos O'Donell <carlos@redhat.com>, Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>, 
	Rich Felker <dalias@libc.org>, Netdev <netdev@vger.kernel.org>, linux-kernel@vger.kernel.org, 
	linux-api@vger.kernel.org, klibc@zytor.com
Subject: Re: [klibc] [PATCH net-next] net: uapi: Provide an UAPI definition
 of 'struct sockaddr'
Message-ID: <20260130115438-465fb6a1-f414-4d69-b560-2304941464fc@linutronix.de>
References: <20260105-uapi-sockaddr-v1-1-b7653aba12a5@linutronix.de>
 <934ca004-0aef-49a4-a4f1-3d39a2e71864@app.fastmail.com>
 <0fc5b4ef-c468-416f-a065-f64989d75378@zytor.com>
 <212d2e51-abc1-47bb-8666-755917cad889@app.fastmail.com>
 <0f257cd0-27cf-4c11-b79c-724f4e22c4bf@zytor.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0f257cd0-27cf-4c11-b79c-724f4e22c4bf@zytor.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-5781-lists,linux-api=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	DKIM_TRACE(0.00)[linutronix.de:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thomas.weissschuh@linutronix.de,linux-api@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-api];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linutronix.de:mid,linutronix.de:dkim]
X-Rspamd-Queue-Id: 9BD8CB9C4B
X-Rspamd-Action: no action

On Tue, Jan 20, 2026 at 03:20:18PM -0800, H. Peter Anvin wrote:
> On 2026-01-20 14:31, Arnd Bergmann wrote:
> >> 
> > I must have accidentally cut that from my reply, sorry.
> > Looking at it again now, I think I ran into problems with the
> > flexible array that was removed from the in-kernel sockaddr
> > structure in commit 2b5e9f9b7e41 ("net: Convert struct sockaddr
> > to fixed-size "sa_data[14]""), so there is a good chance it works
> > now with the (once more) fixed-size version.
> > 
> > The other problem is that the structures that embed 'sockaddr'
> > are used a lot inside of the kernel, in particular in 'ifreq',
> > so changing the uapi sockaddr to __kernel_sockaddr requires
> > additional changes wherever the struct members are passed
> > by reference.
> >
> 
> Well, the kernel should do what opting-in libcs do:
> 
> #define sockaddr __kernel_sockaddr

This looks reasonable, but would only apply to future libc releases, no?

Adopting a new scheme for all types will be a larger undertaking. Today
'struct sockaddr' is the only type not using the current compatibility
mechanism. Could we first align 'struct sockaddr' as shown by the patch?
Whatever comes next can then build on a uniform base.

> or
> 
> struct sockaddr { struct __kernel_sockaddr; };
> 
> ... now when we have ms extensions turned on. Unfortunately gcc/clang don't
> support them without the option even with __extension__, so user space is
> limited to using macros.


Thomas


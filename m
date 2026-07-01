Return-Path: <linux-api+bounces-6755-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id xDcCMSbTRGrm1QoAu9opvQ
	(envelope-from <linux-api+bounces-6755-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Wed, 01 Jul 2026 10:43:18 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 07A496EB38A
	for <lists+linux-api@lfdr.de>; Wed, 01 Jul 2026 10:43:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linutronix.de header.s=2020 header.b=shJRu5vD;
	dkim=pass header.d=linutronix.de header.s=2020e header.b=g0vhUs9W;
	spf=pass (mail.lfdr.de: domain of "linux-api+bounces-6755-lists+linux-api=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-api+bounces-6755-lists+linux-api=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linutronix.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9DDBC300DDFC
	for <lists+linux-api@lfdr.de>; Wed,  1 Jul 2026 08:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8283539FCCC;
	Wed,  1 Jul 2026 08:40:41 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E693B9929;
	Wed,  1 Jul 2026 08:40:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782895241; cv=none; b=K+oGLwADb2XJ8tVyJImnTgccFOy3Ibq7aM9bc4PSg0JtoCxmcDltjRuB6uNSbAYzbSdh6bJQL/IeqjecnI8XkuUv7uhbYlFMJuiXuRMCuv/pT5FCh39gttowWg8P9vyUjbaIjh9e0DlW5Qa+TrnHhqm8KslmBxxTcHt7F4sBFnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782895241; c=relaxed/simple;
	bh=N5gW74owmvvVkscIHB7+zHUMJCcLLGEn0Qp9Nh06thk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E5p/MDgsIzxqUUmEJoeftAKgTOpzUXwKP3nGS5bCagiAsBzMw8f8sOeeRkdK7Mf5skc3+52Tgq4kUXkgoV7TQi+s5sNVGiaOJXoVAZdzYpLPl3I/ZCtywcxtLXvMC49nGaZW9mEk1thOJODXOhIIXFAeeNTpl1q0OGqF9V258XU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=shJRu5vD; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=g0vhUs9W; arc=none smtp.client-ip=193.142.43.55
Date: Wed, 1 Jul 2026 10:40:30 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1782895232;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dzaTPoH0/Jbz15YM7OdwlqoyPsJkrqrtqSoCOmHvtKA=;
	b=shJRu5vDUP7ZDKQSHsK+hm5YzMgosdS81oqGJoO7WyU/KYkL+sjeEnqx02Vf7vGu0x43Ry
	uv6fAueFoRpJ4Xm9fSuHL9YZ7rkYM4cHiFQyvecXnQY0kyodiLeLDYy0hJhNzEafujjp1V
	4VPvIVU8ENW3zH8WQmLPMJWXGjv3azZz4S7EcH9XIzvV8SgR9veRJvvUkBalD1CoSrGzoV
	LUCKXOnXTb6ujHmRmax4+2WJA6Xfad6AmRnq70bALY+fNfyXQpi6N0l1bc4wGICwqzsR7f
	4PF/coqct+vO1K0YDcsduOPh91BO43A+uz4vYcgsqDb3FgEpWf9orTC78wUw0g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1782895232;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dzaTPoH0/Jbz15YM7OdwlqoyPsJkrqrtqSoCOmHvtKA=;
	b=g0vhUs9WNGqHZUgF7RfmzHiuDSnx9FCObdSlzDF54pp2Ic5gy6Dobr2Cf6z2yhnU/uvjVU
	UB1UH3naQir8cmAA==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
	Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Christophe Leroy <chleroy@kernel.org>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	Vincenzo Frascino <vincenzo.frascino@arm.com>, John Stultz <jstultz@google.com>, 
	Stephen Boyd <sboyd@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Andreas Larsson <andreas@gaisler.com>, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, linux-mips@vger.kernel.org, 
	linux-api@vger.kernel.org, sparclinux@vger.kernel.org
Subject: Re: [PATCH v2 1/9] time: Respect COMPAT_32BIT_TIME for old time type
 functions
Message-ID: <20260701102912-ea8f3291-7bba-407b-9a7d-7c367a4c9398@linutronix.de>
References: <20260630-vdso-compat_32bit_time-v2-0-520d194640dd@linutronix.de>
 <20260630-vdso-compat_32bit_time-v2-1-520d194640dd@linutronix.de>
 <0cda7366-2eb9-4ecb-b76a-b3b68ee10043@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0cda7366-2eb9-4ecb-b76a-b3b68ee10043@app.fastmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6755-lists,linux-api=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:arnd@arndb.de,m:luto@kernel.org,m:tglx@kernel.org,m:mingo@redhat.com,m:bp@alien8.de,m:dave.hansen@linux.intel.com,m:x86@kernel.org,m:hpa@zytor.com,m:linux@armlinux.org.uk,m:catalin.marinas@arm.com,m:will@kernel.org,m:maddy@linux.ibm.com,m:mpe@ellerman.id.au,m:npiggin@gmail.com,m:chleroy@kernel.org,m:tsbogend@alpha.franken.de,m:vincenzo.frascino@arm.com,m:jstultz@google.com,m:sboyd@kernel.org,m:davem@davemloft.net,m:andreas@gaisler.com,m:linux-kernel@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linuxppc-dev@lists.ozlabs.org,m:linux-mips@vger.kernel.org,m:linux-api@vger.kernel.org,m:sparclinux@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[thomas.weissschuh@linutronix.de,linux-api@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,redhat.com,alien8.de,linux.intel.com,zytor.com,armlinux.org.uk,arm.com,linux.ibm.com,ellerman.id.au,gmail.com,alpha.franken.de,google.com,davemloft.net,gaisler.com,vger.kernel.org,lists.infradead.org,lists.ozlabs.org];
	RCPT_COUNT_TWELVE(0.00)[27];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thomas.weissschuh@linutronix.de,linux-api@vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-api];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,sashiko.dev:url,linutronix.de:dkim,linutronix.de:mid,linutronix.de:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 07A496EB38A

On Tue, Jun 30, 2026 at 03:00:37PM +0200, Arnd Bergmann wrote:
> On Tue, Jun 30, 2026, at 09:38, Thomas Weißschuh wrote:
> > The "old" time types use 32-bit seconds which are not y2038-safe.
> > Respect COMPAT_32BIT_TIME for functions using those types.
> > time(), stime() and gettimeofday() are disabled completely.
> 
> Looks good, yes

Sashiko found an issue [0], which I think is valid. I'll change that for v3.

> > settimeofday() is kept as it is required to do the initial timewarping
> > after boot. However the 'tv' argument will be rejected.
> 
> Not sure about this part, did we already discuss this last time?

This is my interpretation of [1].

> I can see how keeping the timewarping functionality is the easy way
> out, but completely disabling the settimeofday syscall the same
> way we do on new architectures seems so much more consistent.

Shouldn't we then do this completely? Irrespective of COMPAT_32BIT_TIME?
And then remove all of the timewarping and kernel timezone bits.

It would be nice however if this series, and my other ones blocked behind it,
are not blocked on that larger rework.

(...)

[0] https://sashiko.dev/#/patchset/20260630-vdso-compat_32bit_time-v2-0-520d194640dd%40linutronix.de?part=1
[1] https://lore.kernel.org/all/e9487ebe-3730-438a-9c23-e45f75986ecc@app.fastmail.com/


Thomas


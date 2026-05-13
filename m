Return-Path: <linux-api+bounces-6330-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YM4COGyYBGpiLwIAu9opvQ
	(envelope-from <linux-api+bounces-6330-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Wed, 13 May 2026 17:27:40 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 32F3B536119
	for <lists+linux-api@lfdr.de>; Wed, 13 May 2026 17:27:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CCBAE32C9F03
	for <lists+linux-api@lfdr.de>; Wed, 13 May 2026 14:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15F56421899;
	Wed, 13 May 2026 14:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="NuHA1dvN"
X-Original-To: linux-api@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA66B27FB2E;
	Wed, 13 May 2026 14:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778682592; cv=none; b=pUgNH4SkAng8gE6j0ojlpxQ3Y0adGXMV226D1OYmDs10pT4KM22B0/yBozYohnTNpv24a5OzV0VWr3f4FnfaWbbAjSdmY7xSnPmgfB1fQKvwIX+kaMPn37aiF30JUUD5dTKgctCy7D/9VDbof4+NXQ++ngzTGPkUuhKcG+xYYUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778682592; c=relaxed/simple;
	bh=Q2HJgZxARD1A17cdhd0ukskQlCZlw3cCWkjA/E7sjHs=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Disposition; b=HW9nrBqRY1aJuq6R6CQ2Uv6LXfZrF/Oq12evddRj5/jHX9VKnrrpXH/LXaTUSs+KWRij1GPXDZBq8/QPV3i+xj7DPLMmjBmqBYGvREE018IkHCoJosMlFwJJVPqhCwXHSatwyn+N/3lgweM6maAEdFaCU9JvUzJC7HKsU/ME0IM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=NuHA1dvN; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from jeffbarnes-ThinkPad-P14s-Gen-2i (unknown [52.177.6.131])
	by linux.microsoft.com (Postfix) with ESMTPSA id CA1E220B7167;
	Wed, 13 May 2026 07:29:45 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com CA1E220B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1778682587;
	bh=eZUWYylCZ6/qLuaWw0TNaPlDo9Vps8c+zZrYEZIahBI=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=NuHA1dvNsJW6xH4Usgxh7/uhFA6MBaY2RPcQJKvrC11Vr2cEKeAWOaRfxbnUR6UFB
	 oiBmXSLXNdiNcWXGKcvbHKFQpA1okMHlruWzycMXJMU40BncG0GrjZSQjwF1Yq9/bf
	 piOc9Fnm3JSaKCImUERP723aMBRnMkarncJ+c4lM=
Date: Wed, 13 May 2026 10:29:46 -0400
From: Jeff Barnes <jeffbarnes@linux.microsoft.com>
To: Ignat Korchagin <ignat@linux.win>
Cc: Eric Biggers <ebiggers@kernel.org>, Kamran Khan <kz@inspirated.com>, 
 Andy Lutomirski <luto@amacapital.net>, 
 "=?utf-8?Q?linux-crypto=40vger.kernel.org?="
 <linux-crypto@vger.kernel.org>, Herbert Xu
 <herbert@gondor.apana.org.au>, "=?utf-8?Q?linux-doc=40vger.kernel.org?="
 <linux-doc@vger.kernel.org>, "=?utf-8?Q?linux-api=40vger.kernel.org?="
 <linux-api@vger.kernel.org>, 
 "=?utf-8?Q?linux-kernel=40vger.kernel.org?="
 <linux-kernel@vger.kernel.org>, "=?utf-8?Q?netdev=40vger.kernel.org?="
 <netdev@vger.kernel.org>, Linus Torvalds
 <torvalds@linux-foundation.org>
Message-ID: <C4F28324-E357-483B-B5BF-DA2D00A4D272@getmailspring.com>
In-Reply-To: <CAOs+rJUA+bz6Y2GKioHnFGFKX_uAP+4LaPRs=ZDgRQoUi4mWkg@mail.gmail.com>
References: <CAOs+rJUA+bz6Y2GKioHnFGFKX_uAP+4LaPRs=ZDgRQoUi4mWkg@mail.gmail.com>
Subject: Re: [PATCH] crypto: af_alg - Document the deprecation of AF_ALG
X-Mailer: Mailspring
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-Rspamd-Queue-Id: 32F3B536119
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.95 / 15.00];
	CC_EXCESS_QP(1.20)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-6330-lists,linux-api=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeffbarnes@linux.microsoft.com,linux-api@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-api];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.microsoft.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,getmailspring.com:mid,linux.win:email]
X-Rspamd-Action: no action



On May 12 2026, at 5:18 pm, Ignat Korchagin <ignat=40linux.win> wrote:

> On Mon, May 11, 2026 at 10:38=E2=80=AFPM Eric Biggers <ebiggers=40kerne=
l.org> wrote:
>> =20
>> On Mon, May 11, 2026 at 10:03:21PM +0100, Ignat Korchagin wrote:
>> > I don't think fully discounting hardware offloading is beneficial
>> here. HW
>> > accelerators will be produced and without a common interface
>> vendors would
>> > start implementing their own =22bespoke=22 drivers with bespoke user=
space
>> > interfaces (we already had such proposals), which in turn may
>> introduce more
>> > attack surface. Yes, A=46=5FALG needs substantial improvement, but a=
t
>> least it
>> > can be a standardisation point.
>> =20
>> That isn't the best way to accelerate symmetric crypto anymore though,=

>> if it ever was.  This has been known for a long time.
>> =20
>> > > In any case, any hypothetical security benefit provided by A=46=5F=
ALG would
>> > > have to be *very high* to outweigh the continuous stream of
>> > > vulnerabilities in it.  I understand that people using A=46=5FALG
>> might not
>> > > be familiar with that continuous stream of vulnerabilities, but
>> it would
>> >
>> >
>> > Is it actually that much compared to other features/subsystems,
>> like eBP=46 or
>> > user namespaces=3F But we don't rush to deprecate those - instead
>> trying to
>> > harden them and come up with better design.
>> =20
>> There are plenty of other kernel features with a large attack surface,=

>> of course.  But they tend to be much more useful than A=46=5FALG.  It'=
s all
>> about weighing benefits vs. risks.
> =20
> If divide number of CVEs in such systems on imaginary units of
> usefulness, I think the ratio is similar.
> =20
>> When we get the point where a large number of Linux users *had* to
>> disable A=46=5FALG as an emergency vulnerability response, and at the =
same
>> time their systems weren't even using A=46=5FALG so nothing even broke=
 and
>> they could have just done that to begin with, I think we get a very
> =20
> Well, there were: cryptsetup, RHEL fips check, so there are some...

cryptsetup does not have a hard dependency on A=46=5FALG.
It is a potential consumer via A=46=5FALG.

A=46=5FALG provides a broad, hard-to-control interface
cryptsetup (and similar tools) are not blockers

A=46=5FALG removal does not necessarily break cryptsetup usage. Removal d=
oes
improve =46IPS boundary clarity.


> =20
>> clear idea of which side is heavier for A=46=5FALG in the real world.
> =20
> Same thing could be said for unprivileged user namespaces - distros
> even put a custom sysctl to restrict it and no-one noticed.
> =20
>> The main relevance of A=46=5FALG to the Linux community is that it all=
ows
>> their systems to be exploited.
> =20
> To be clear I'm not arguing for the current A=46=5FALG implementation. =
I
> agree, the splice zero-copy is... suboptimal (to be soft) and is
> actually not-so-zero copy. But I think it was just added before we had
> more modern approaches like io=5Furing (have their own can of worms, bu=
t
> hey - people adopt it fast).
> =20
> But I advocate for the usefulness of the concept itself - kernel/OS
> providing crypto services to userspace. As mentioned in other threads,
> other operating systems have it and Linux lags behind. There are use
> cases: common interface for HW accelerators, embedded systems, which
> don't have the space to bring a userspace lib etc. Even non-technical:
> there are environments that just don't want to rely on third-party
> userspace libraries like OpenSSL purely for licensing reasons. And I
> agree, that it is hard to do it right, but we can piggy-back on other
> subsystems (such as io=5Furing mentioned or other ideas).
> =20
>> - Eric
>> =20
> =20
> Ignat
> =20
Jeff


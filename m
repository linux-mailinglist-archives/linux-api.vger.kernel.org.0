Return-Path: <linux-api+bounces-6263-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gJUEMQXi+GnM2gIAu9opvQ
	(envelope-from <linux-api+bounces-6263-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Mon, 04 May 2026 20:14:29 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B3D14C25B4
	for <lists+linux-api@lfdr.de>; Mon, 04 May 2026 20:14:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C4DD63078351
	for <lists+linux-api@lfdr.de>; Mon,  4 May 2026 18:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0D4F3E557C;
	Mon,  4 May 2026 18:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="A5ZD7In8"
X-Original-To: linux-api@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6701412E1E9;
	Mon,  4 May 2026 18:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777918336; cv=none; b=TdSBHpQoXTangR1yVSnnWFpd8nTiIRkPn7r5wcF14FnIRerlNAVU6JyMxBS6kYLreOg13F4vOkaTut5Ve1fm2AKxZAQTQkfbfELwKSiSutqKknL+gX3TIwjAG/iRkheIGesn1+rM03cT9+1exAVG4/tnixEcxqzgkJ50ffbUbeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777918336; c=relaxed/simple;
	bh=+sk3GTBgJ0OpZC2sOvfB7jA5ioLT4Ah6k/GnB7L9h1g=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Disposition; b=t1GEY3+uFgDk/m7O049AR4dQc5GGYrEwQBKIGffW7bdNpIsqFvZfLxc0VgWEhUQAGXVXiGW1h+nI4shtr2jJZhb7aa5XdlT2jqHlF7hOE22qvgjBfZtjcNMEJSm+PDkIW4JvutLkIEYm0Ze0K5OmImsR4eJBGABXAOUGwQAN1kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=A5ZD7In8; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from jeffbarnes-ThinkPad-P14s-Gen-2i (unknown [52.167.115.14])
	by linux.microsoft.com (Postfix) with ESMTPSA id F3B4720B7168;
	Mon,  4 May 2026 11:12:11 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com F3B4720B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1777918333;
	bh=n7bmLzV45MCFR32DECncWc88xFMFDAuCejDyl9htYrM=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=A5ZD7In81slYhgBMBZnHjbosHvK2nRllucKahLg4ReJUn+f2oS5lQriTrQhEWAbwq
	 14JxWEIVUDVJdL3eeWRkaYeTBZ83YSuSYM7l8dqHVHXGEE0zgbAkCaY3HzCIFYbFaq
	 R/wTmAS0vy4XInjcJEwOfyfJ2YOKiNNhrKwkM1rk=
Date: Mon, 4 May 2026 14:12:11 -0400
From: Jeff Barnes <jeffbarnes@linux.microsoft.com>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Jon Kohler <jon@nutanix.com>, 
 "=?utf-8?Q?linux-crypto=40vger.kernel.org?="
 <linux-crypto@vger.kernel.org>, Herbert Xu
 <herbert@gondor.apana.org.au>, "=?utf-8?Q?linux-doc=40vger.kernel.org?="
 <linux-doc@vger.kernel.org>, "=?utf-8?Q?linux-api=40vger.kernel.org?="
 <linux-api@vger.kernel.org>, 
 "=?utf-8?Q?linux-kernel=40vger.kernel.org?="
 <linux-kernel@vger.kernel.org>, "=?utf-8?Q?netdev=40vger.kernel.org?="
 <netdev@vger.kernel.org>, Linus Torvalds
 <torvalds@linux-foundation.org>
Message-ID: <F100C726-F841-461B-BE2F-C2018C122426@getmailspring.com>
In-Reply-To: <20260504173952.GA2291@sol>
References: <20260504173952.GA2291@sol>
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
X-Rspamd-Queue-Id: 2B3D14C25B4
X-Rspamd-Action: no action
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
	TAGGED_FROM(0.00)[bounces-6263-lists,linux-api=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeffbarnes@linux.microsoft.com,linux-api@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-api];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,getmailspring.com:mid,libcrypto.so:url,linux.microsoft.com:dkim]



On May 4 2026, at 1:39 pm, Eric Biggers <ebiggers=40kernel.org> wrote:
> =20
> That seems to be an implementation of =46IPS 140-3's integrity self-che=
ck.
> A few observations:
> =20
> - It could easily use userspace SHA-512 code instead.  If including
>  libcrypto.so in the =22=46IPS cryptographic boundary=22 would cause
>  certification difficulties, then a sha512.c file could simply be added=

>  to 'libkcapi-hmaccalc' which is already in it.

Indeed expanding the crypto boundary to include libcrypto.so would cause
certification difficulties, it would mean certifying all of libcrypto.so
with the kernel. There *may* be a case for saying that it is outside the
module boundary but only if:

    * The integrity mechanism is clearly external
    * The cryptographic module refuses to operate unless integrity is con=
firmed
    * The trust relationship is clearly documented

I don't see how this could be justified cleanly without significant pushb=
ack.

> =20
> - It's compatible with all of the proposed hardening.  It doesn't
>  require zero-copy performance.  It runs as root, so it would be
>  compatible with a capability check.  =22hmac(sha512)=22 will need to b=
e on
>  the algorithm allowlist anyway for iwd.
> =20
> - =46IPS 140-3 might also allow it to be simplified to use a plain hash=

>  instead of pointlessly using HMAC with a fixed key.

=46IPS 140=E2=80=913 (via ISO/IEC 19790) draws a hard distinction between=
:
    * Integrity checking (cryptographic protection)
    * Integrity measurement (detection only)

A plain hash provides no protection against an attacker who can modify
both the object and its reference hash.

> =20
> By the way, also on the topic of =46IPS 140-3, some people do use A=46=5F=
ALG
> for ACVP (even though it's not all that great for that purpose, either)=
.
> But ACVP is a testing thing, not something that is needed on production=

> systems.  ACVP can just be run as root on a testing build; there's no
> need to enable support for it in the actual production build.

Agreed it's not a good use case. Unless/until pkcs1 is supported, I
don't see how you can use it for all of the test cases. Plus as
evidenced by Ubuntu's new cert, it requires validating the library.

> =20
> - Eric
> 


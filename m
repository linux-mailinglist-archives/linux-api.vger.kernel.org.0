Return-Path: <linux-api+bounces-6262-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uCh5LfTa+Gn02QIAu9opvQ
	(envelope-from <linux-api+bounces-6262-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Mon, 04 May 2026 19:44:20 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C3734C214B
	for <lists+linux-api@lfdr.de>; Mon, 04 May 2026 19:44:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8F5943054FE0
	for <lists+linux-api@lfdr.de>; Mon,  4 May 2026 17:41:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C3103E4C7A;
	Mon,  4 May 2026 17:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="ja8k4e+h"
X-Original-To: linux-api@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0FD11862;
	Mon,  4 May 2026 17:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777916501; cv=none; b=WqeiqAFw/M16lS+ACZBYIqsLNP7ef0F2G6CFDQjDcEBrTEalmhLOzOPtZeAzWTd00PXV6pK793hn0kRnOESGSctRtDnevRHpzrIEHlA5TK/VM/tpkcUMyDeOfJ/5sF54jUHwL1w4FQbxVCJ6kppl4RllT2gnQe2dVIKGJl857m4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777916501; c=relaxed/simple;
	bh=Dju5V9WI247b+gw5Gxnh3v0/NH6IZ1jQn/OQVxY+c9I=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Disposition; b=hb2xIhb1fQQCtnFZadeSUKeBFClwN+rsRtW6hqcPHbqFJ9n5fYsRODrwLpYcYBYmy+R+opK2oY3H+PO+Om7YJAGjQvDnxgboYJnMnB+dSgO5HReg7D4Gbaxc3Qj/HXhcou5GHSXkt1wsS8x7xhju9uCJOygPK7lfQok2e7O4TBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=ja8k4e+h; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from jeffbarnes-ThinkPad-P14s-Gen-2i (unknown [52.177.6.131])
	by linux.microsoft.com (Postfix) with ESMTPSA id C871A20B7169;
	Mon,  4 May 2026 10:41:36 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C871A20B7169
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1777916497;
	bh=f+1Y5EUYXPSxAF/znLYyDNUbOTcdHMnI7MLeAMmAaPE=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=ja8k4e+hHrAMRcxYCgXNUexidzSdZliw2fZEgTBHaD77ph7Q84MPBiJJSYnlZLhsM
	 NilPwYVgfkoU+81wpXZsJPiTNAD6mDZv3RDJ2F3/gHwk1wUSS5kkdR7BZAwHaPOx6T
	 u/WHCHHu4a+cU/x2an1SFDUm5fq6j0ldEjijM5xM=
Date: Mon, 4 May 2026 13:41:37 -0400
From: Jeff Barnes <jeffbarnes@linux.microsoft.com>
To: Jon Kohler <jon@nutanix.com>
Cc: Eric Biggers <ebiggers@kernel.org>, 
 "=?utf-8?Q?linux-crypto=40vger.kernel.org?="
 <linux-crypto@vger.kernel.org>, Herbert Xu
 <herbert@gondor.apana.org.au>, "=?utf-8?Q?linux-doc=40vger.kernel.org?="
 <linux-doc@vger.kernel.org>, "=?utf-8?Q?linux-api=40vger.kernel.org?="
 <linux-api@vger.kernel.org>, 
 "=?utf-8?Q?linux-kernel=40vger.kernel.org?="
 <linux-kernel@vger.kernel.org>, "=?utf-8?Q?netdev=40vger.kernel.org?="
 <netdev@vger.kernel.org>, Linus Torvalds
 <torvalds@linux-foundation.org>
Message-ID: <0D4B157F-AEDE-4470-BDBE-E6467CA19089@getmailspring.com>
In-Reply-To: <4D424F50-7E9F-4B1F-AE9C-86D8526284E6@nutanix.com>
References: <4D424F50-7E9F-4B1F-AE9C-86D8526284E6@nutanix.com>
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
X-Rspamd-Queue-Id: 2C3734C214B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.95 / 15.00];
	CC_EXCESS_QP(1.20)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-6262-lists,linux-api=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeffbarnes@linux.microsoft.com,linux-api@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-api];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nutanix.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,getmailspring.com:mid,linux.microsoft.com:dkim]



On May 4 2026, at 10:39 am, Jon Kohler <jon=40nutanix.com> wrote:

> =20
> Quick passing observation
> I noticed that when attempting to completely disable these Crypto APIs,=

> I was experiencing boot failures with fips=3D1 enabled systems.
> =20
> Using 6.18-based kernel with an el9-based user space, I see the
> following hang in the early boot console from dracut-pre-pivot:
>  Check integrity of kernel
>  libkcapi - Error: A=46=5FALG: socket syscall failed (errno: -97)
>  Allocation of hmac(sha512) cipher failed (-97)

One thing that for certain that would cause this panic is the sha512hmac
binary that does the fips integrity check. On many distros this check is
called, for example by dracut among others, during initramfs to check
the integrity of the kernel before any crypto is used. On failure, the
kernel won't finish boot.

sha512hmac is a binary shipped with kcapitools. It uses libkcapi.

sha512hmac -> libkcapi -> A=46=5FALG.

Is there a planned replacement for this integrity check=3F I don't know o=
f
anybody doing this for =46IPS yet, but is there a case where IMA / EVM
could be a workaround=3F

Regards,
Jeff

> =20
> I haven't looked at every elX version, but at least in el9 and el10,
> they use libkcapi-hmaccalc to provide sha512hmac, which dracut =5B1=5D
> uses to calculate the HMAC value in do=5Ffips().
> =20
> Digging further, I was only able to disable RNG and AEAD APIs, but
> not HASH and SKCIPHER APIs when =46IPS was in the picture with el9++.
> =20
> I=E2=80=99m not sure how other distros do the same, but this could be p=
roblematic
> elsehwere if other distros went down the libkcapi route.
> =20
> =5B1=5D https://github.com/dracutdevs/dracut/blob/059/modules.d/01fips/=
fips.sh=23L167
> =20
> 


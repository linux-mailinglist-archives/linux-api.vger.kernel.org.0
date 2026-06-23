Return-Path: <linux-api+bounces-6644-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id EhslGByAOmqM+QcAu9opvQ
	(envelope-from <linux-api+bounces-6644-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Tue, 23 Jun 2026 14:46:20 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A8E4D6B72B7
	for <lists+linux-api@lfdr.de>; Tue, 23 Jun 2026 14:46:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "linux-api+bounces-6644-lists+linux-api=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-api+bounces-6644-lists+linux-api=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C582230956B7
	for <lists+linux-api@lfdr.de>; Tue, 23 Jun 2026 12:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C27763D566E;
	Tue, 23 Jun 2026 12:44:40 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B57453D413C;
	Tue, 23 Jun 2026 12:44:38 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782218680; cv=none; b=UvozculmCazwj+/GFQxi4DOE7geza0N4xcNX/KXNz28fHAMIoB78jwB4E7Lt5nFg9js1kvWc6SgHQkrZI+9u5N459FZRCOAdS5qZDaZnCDt6jCTxUpIDHgCNRo9uvIyF0UBF+rscnCiIeHJFFf4msbH7tQzIrlKOORs9YO8PkHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782218680; c=relaxed/simple;
	bh=Os+Dq9xu4+1uB0pLfKgdOOhC4ysk0rTzQttxlAmQB2Q=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ia5P6IdzsmEtIyUeanNjrJHqgw3xWa3m5jAglRrdgzzv4WUWG4gAi+WCd3NfPVhX2+TLDpNAvrfJwNiSNMsHMoZ5tzUqe6ymBKwhiubN8UzhQOhFzBjCQCuhDzJxLPYxKmPgWp0nPlnv3Su4fPSvczXC22geSp3jU9VNQ8csW+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.196
Received: by mail.gandi.net (Postfix) with ESMTPSA id 242DA3F62F;
	Tue, 23 Jun 2026 12:44:29 +0000 (UTC)
Message-ID: <7d08a6df54279e9915f5df6bd4e5e5dde52b4fe1.camel@hadess.net>
Subject: Re: [PATCH] crypto: af_alg - Document the deprecation of AF_ALG
From: Bastien Nocera <hadess@hadess.net>
To: Eric Biggers <ebiggers@kernel.org>, linux-crypto@vger.kernel.org, 
 Herbert Xu <herbert@gondor.apana.org.au>, Marcel Holtmann
 <marcel@holtmann.org>, Luiz Augusto von Dentz	 <luiz.dentz@gmail.com>
Cc: linux-doc@vger.kernel.org, linux-api@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, Linus Torvalds
	 <torvalds@linux-foundation.org>, linux-bluetooth@vger.kernel.org, 
	ell@lists.linux.dev
Date: Tue, 23 Jun 2026 14:44:28 +0200
In-Reply-To: <20260430011544.31823-1-ebiggers@kernel.org>
References: <20260430011544.31823-1-ebiggers@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-GND-Sasl: hadess@hadess.net
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: dmFkZTFSdMa/vorSWAPy5DzVBQOrA5W2CderI2r8bhYQ2EoH5VrunMUW4F+lob0aw2PDQT52P9oKJQ7Bc+ZmGg5FLS47m3kHsnL0/eV+3XWE+F4diLFd8e9nu3o4i32idkosmDFchhVJC3nly1ComxK8P/aL7NCh427bMVxArtJi1+8zJU4qnakVtn4pXwS7gUXQQSGFPcaGkbHlc52LfmJWg5Xlm6xwGFN1wb+UetO4FCFwrmL/QezjIkqk8BlkUF15JvJlOtt2gFYzNZmEYZ+TOeu/SqzT814a85hCNogSS4A43b3ro+RlPF01qEkspz+C4G6uVBR7jPZ+DmeQGzPLSmwjWQvgzyK7ED+22J3K815RYB90/WyR2jJ9E+TpSEIuCjN8yCT9Yy7Q6O1DSR0bardG347BFh/ZgxCO/vzJnJPBcWOy3l8rUtv2mcI9/7igbu5SToeLaMIlxZXaEWrDNH82KK7lW9VqNWH0lbp84/CzQdtjlUtmcTkGrOxNzhyj13LOnkQCuPheAYpdX9EuSX/votNGV+SVkYYkw5gNS6im/7I+GjfubVIzPQCTNDnUyH59CZ7d70rqNUuEI/Pyzh8pIUgMSpNmHKmxW3UxhDAiHIYYZR7VC+ql1VKY0cF1nKpy2Tm6hdy+emcJtd/OYrPa/UUCSRd+hTMdJRbN/GPThg
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[hadess.net];
	FORGED_RECIPIENTS(0.00)[m:ebiggers@kernel.org,m:linux-crypto@vger.kernel.org,m:herbert@gondor.apana.org.au,m:marcel@holtmann.org,m:luiz.dentz@gmail.com,m:linux-doc@vger.kernel.org,m:linux-api@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:torvalds@linux-foundation.org,m:linux-bluetooth@vger.kernel.org,m:ell@lists.linux.dev,m:luizdentz@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,vger.kernel.org,gondor.apana.org.au,holtmann.org,gmail.com];
	FORGED_SENDER(0.00)[hadess@hadess.net,linux-api@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-6644-lists,linux-api=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hadess@hadess.net,linux-api@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-api];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A8E4D6B72B7

Hey,

Replying to this older patch.

On Wed, 2026-04-29 at 18:15 -0700, Eric Biggers wrote:
<snip>
> This isn't intended to change anything overnight.=C2=A0 After all, most L=
inux
> distros won't be able to disable the kconfig options quite yet, mainly
> because of iwd.=C2=A0 But this should create a bit more impetus for these
> userspace programs to be fixed, and the documentation update should also
> help prevent more users from appearing.

There are 2 other users that I know of: bluez, and the ell library
(used by iwd and bluez).

From what I could tell, bluetoothd uses AF_ALG for cryptography:
https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/src/shared/crypto.c
https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/tools/mesh-gatt/cry=
pto.c

It uses "ecb(aes)" and "cmac(aes)" as algorithms.

Finally, it also uses them both again:
https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/mesh/crypto.c
through ell:
https://git.kernel.org/pub/scm/libs/ell/ell.git/tree/ell/cipher.c

Because that's a question that also came up, bluetoothd also uses the
CAP_NET_ADMIN capability.

I'll let Luiz and Marcel take it over from here.

Cheers


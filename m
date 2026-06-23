Return-Path: <linux-api+bounces-6648-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Yf+TK+DcOmpLJAgAu9opvQ
	(envelope-from <linux-api+bounces-6648-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Tue, 23 Jun 2026 21:22:08 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 001AA6B9AB0
	for <lists+linux-api@lfdr.de>; Tue, 23 Jun 2026 21:22:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="c0g3Ipr/";
	spf=pass (mail.lfdr.de: domain of "linux-api+bounces-6648-lists+linux-api=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-api+bounces-6648-lists+linux-api=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F26AC304C040
	for <lists+linux-api@lfdr.de>; Tue, 23 Jun 2026 19:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B236938B142;
	Tue, 23 Jun 2026 19:19:51 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8745217723;
	Tue, 23 Jun 2026 19:19:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782242391; cv=none; b=oSz204pgNYdtsglBuZcKP9s7/NntSfgWORSwWCO7xJuXdY/LusSmjKyD6tkqneTnxnOO8Ix729HDVrsVl9TW79QP22scRUMDUi4yZAtM/F/JtLuoLqVqiDsmoAw1WJZumj0p72y6y60s1BgNDazq8+a4CFVLOU8HgmdDGOpnmmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782242391; c=relaxed/simple;
	bh=IP1C75csOqxm9rutyLOdY/Y1l5DuXUNjY9pJyU0uJEc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D8DZZrO5SEt756hU6lNjGAYX7xmejaYnAWg2f1HqqHFmshsdLlDRGRAXhO8ukICj9DyMD6LvCjtqCiglulggdBVBw6OxSm353XQYCzCAid/Fjz4Wd9aovPDR6fO/qi6qQIm1vIXWUm794VfxcjevVq+12yRVdQwJxhx8l6HrYE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c0g3Ipr/; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C95AB1F000E9;
	Tue, 23 Jun 2026 19:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782242390;
	bh=RbRcMq45lJL75Wy8wrzm8CIwVwH9qDYXAES++CJmSQU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=c0g3Ipr/jnG4piITeIEBSOZd4N9x40N5t4MWHm/ywG1uUiqB1E71RWdo/HFjXYnxt
	 HGrI8PBxBn1qARMQA1/AZZIrudVLzHNI7OO+zogsuQ65sP6lGsNZCXrQTGCUEttASD
	 ngVdGTMIWMgwddbgAOJ4WnyC3Cl9gjHogvKBzaZ21A3d/Mbb/nUrhI8qtqUdtfMWHy
	 4L9qgOc68MA5CmWpwSMX6TV4BqUX4fahq27AXT0Xkbqk48do563/4MEYjjHU6sy+zz
	 t4YxUF7kfgUdd8lpiQKNUTyNb1fxejLezz5+FMRzVdBOR+XXKXfixejT/7jozdOM9k
	 uthHgc40SZnOQ==
Date: Tue, 23 Jun 2026 19:19:48 +0000
From: Eric Biggers <ebiggers@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Bastien Nocera <hadess@hadess.net>, linux-crypto@vger.kernel.org,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-doc@vger.kernel.org, linux-api@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-bluetooth@vger.kernel.org, ell@lists.linux.dev
Subject: Re: [PATCH] crypto: af_alg - Document the deprecation of AF_ALG
Message-ID: <20260623191948.GD1850517@google.com>
References: <20260430011544.31823-1-ebiggers@kernel.org>
 <7d08a6df54279e9915f5df6bd4e5e5dde52b4fe1.camel@hadess.net>
 <20260623164932.GA1793@sol>
 <CAHk-=wgNG=F3xO9PjL0RcKy3UWvq0Np9uZu+nFUQBAA8So9xdA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgNG=F3xO9PjL0RcKy3UWvq0Np9uZu+nFUQBAA8So9xdA@mail.gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6648-lists,linux-api=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:torvalds@linux-foundation.org,m:hadess@hadess.net,m:linux-crypto@vger.kernel.org,m:herbert@gondor.apana.org.au,m:marcel@holtmann.org,m:luiz.dentz@gmail.com,m:linux-doc@vger.kernel.org,m:linux-api@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-bluetooth@vger.kernel.org,m:ell@lists.linux.dev,m:luizdentz@gmail.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[ebiggers@kernel.org,linux-api@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,linux-api@vger.kernel.org];
	FREEMAIL_CC(0.00)[hadess.net,vger.kernel.org,gondor.apana.org.au,holtmann.org,gmail.com,lists.linux.dev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-api];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 001AA6B9AB0

On Tue, Jun 23, 2026 at 11:56:10AM -0700, Linus Torvalds wrote:
> On Tue, 23 Jun 2026 at 09:51, Eric Biggers <ebiggers@kernel.org> wrote:
> >
> > We're aware of that and are taking it into account in the allowlist:
> 
> Note that if we can  just unconditionally make it depend on
> CAP_NET_ADMIN, that would be good - independently of any allowlist.
> 
> Because if iwd and abluetoothd are the main two users, and both of
> those already require CAP_NET_ADMIN anyway...

There's also cryptsetup, including unprivileged benchmarking and also
(in theory) formatting support, and pre-7.0 versions of iproute2 which
used it for computing SHA-1 hashes of BPF programs.

If we broke unprivileged 'cryptsetup benchmark', some people would
definitely notice.  However, since it's just a manually-run benchmark
anyway, users could just run it with sudo.

I don't know about the iproute2 case.

It depends how aggressive we want to be.  My current proposal
(https://lore.kernel.org/linux-crypto/20260622234803.6982-1-ebiggers@kernel.org/)
has the entries in the allowlist marked as either privileged or
unprivileged.  There are just a few unprivileged ones, for cryptsetup
and iproute2 as mentioned.  But we could try doing away with the
unprivileged ones entirely and see who complains.

- Eric


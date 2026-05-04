Return-Path: <linux-api+bounces-6260-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iMItBZna+GnG2QIAu9opvQ
	(envelope-from <linux-api+bounces-6260-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Mon, 04 May 2026 19:42:49 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C8CFC4C20AC
	for <lists+linux-api@lfdr.de>; Mon, 04 May 2026 19:42:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5ACBB3036E8E
	for <lists+linux-api@lfdr.de>; Mon,  4 May 2026 17:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CF553E5ECF;
	Mon,  4 May 2026 17:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hf6SWaca"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 540873E5EC1;
	Mon,  4 May 2026 17:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777916472; cv=none; b=cyjTDqv/ZixkWVDRM045tFFDg1zF9H6fMpXFK8sczxHvojGzqVV08KFirMNuknIOx08xFwprDkSAeuRncSE5NvIzCqGTOkF+mr4/mK6AZ5AyHVG89QiJ4Tp4LS1zXB+sUe2pNkQGvm6tJQL+r33SkchKWQRjS9iw2/TG23+OTCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777916472; c=relaxed/simple;
	bh=gXCIxglj6nEmYjf0Vl9jKj/cd7xazV9XVYCGS2F8+kA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QTQnzSSlYFgLF2Esa9jqu94jubR4H9NJLlDfvk8x9F+qXhVG6yEeIfCvLvS7fe4srDXpRCBEB2j6nx8rYTVPWkt1c95VEdmrqoOLwdrC4DCm8Vc8h4tg4eoMesTWltETccH1DybP1i75XY1zw5WfL74eGIFtJAMQr0Ai9F1rlt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hf6SWaca; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF928C2BCB8;
	Mon,  4 May 2026 17:41:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777916472;
	bh=gXCIxglj6nEmYjf0Vl9jKj/cd7xazV9XVYCGS2F8+kA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hf6SWaca7SqxrkrXkC7kijSGnxlJ6IYOITp4mg4SlDVSk6WB76juKkXB9eXxGVVP6
	 51OuFI7tAv+j1NpcB1ag6Hpra2YCUWwqVrS8ktRkOMNn19p+rxYDYOT+vexdVqa1iL
	 weSTW0LQR0xmiQdVVaNyceaYslwrMNz4Fw4KAp6ryTGtdbsk2CRod4s11pkAnGVSW+
	 9p0Fbw4+hl+PYYLsB91RO1PJuy1/AIt9iU8yBpFkwTKQQTz6lYKuHcqn8cgEGOSxQG
	 +yPdwW/XUhb5f7g3l8FLe+Jk7YFfK7PC99SiU8057/Hsit7pVmrGlHiOGjS1S9XZvw
	 kUG+syil/wG/g==
Date: Mon, 4 May 2026 10:39:52 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Jon Kohler <jon@nutanix.com>
Cc: "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] crypto: af_alg - Document the deprecation of AF_ALG
Message-ID: <20260504173952.GA2291@sol>
References: <20260430011544.31823-1-ebiggers@kernel.org>
 <4D424F50-7E9F-4B1F-AE9C-86D8526284E6@nutanix.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4D424F50-7E9F-4B1F-AE9C-86D8526284E6@nutanix.com>
X-Rspamd-Queue-Id: C8CFC4C20AC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6260-lists,linux-api=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,linux-api@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-api];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[copy.fail:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

On Mon, May 04, 2026 at 02:39:12PM +0000, Jon Kohler wrote:
> > On Apr 29, 2026, at 9:15 PM, Eric Biggers <ebiggers@kernel.org> wrote:
> > 
> > AF_ALG is almost completely unnecessary, and it exposes a massive attack
> > surface that hasn't been standing up to modern vulnerability discovery
> > tools.  The latest one even has its own website, providing a small
> > Python script that reliably roots most Linux distros: https://copy.fail/
> > 
> > This isn't sustainable, especially as LLMs have accelerated the rate the
> > vulnerabilities are coming in.  The effort that is being put into this
> > thing is vastly disproportional to the few programs that actually use
> > it, and those programs would be better served by userspace code anyway.
> > 
> > These issues have been noted in many mailing list discussions already.
> > But until now they haven't been reflected in the documentation or
> > kconfig menu itself, and the vulnerabilities are still coming in.
> > 
> > Let's go ahead and document the deprecation.
> > 
> > This isn't intended to change anything overnight.  After all, most Linux
> > distros won't be able to disable the kconfig options quite yet, mainly
> > because of iwd.  But this should create a bit more impetus for these
> > userspace programs to be fixed, and the documentation update should also
> > help prevent more users from appearing.
> > 
> > Signed-off-by: Eric Biggers <ebiggers@kernel.org>
> > ---
> 
> Quick passing observation
> I noticed that when attempting to completely disable these Crypto APIs,
> I was experiencing boot failures with fips=1 enabled systems.
> 
> Using 6.18-based kernel with an el9-based user space, I see the
> following hang in the early boot console from dracut-pre-pivot:
>   Check integrity of kernel
>   libkcapi - Error: AF_ALG: socket syscall failed (errno: -97)
>   Allocation of hmac(sha512) cipher failed (-97)
> 
> I haven't looked at every elX version, but at least in el9 and el10,
> they use libkcapi-hmaccalc to provide sha512hmac, which dracut [1]
> uses to calculate the HMAC value in do_fips().
> 
> Digging further, I was only able to disable RNG and AEAD APIs, but
> not HASH and SKCIPHER APIs when FIPS was in the picture with el9++.
> 
> I’m not sure how other distros do the same, but this could be problematic
> elsehwere if other distros went down the libkcapi route.
> 
> [1] https://github.com/dracutdevs/dracut/blob/059/modules.d/01fips/fips.sh#L167

That seems to be an implementation of FIPS 140-3's integrity self-check.
A few observations:

- It could easily use userspace SHA-512 code instead.  If including
  libcrypto.so in the "FIPS cryptographic boundary" would cause
  certification difficulties, then a sha512.c file could simply be added
  to 'libkcapi-hmaccalc' which is already in it.

- It's compatible with all of the proposed hardening.  It doesn't
  require zero-copy performance.  It runs as root, so it would be
  compatible with a capability check.  "hmac(sha512)" will need to be on
  the algorithm allowlist anyway for iwd.

- FIPS 140-3 might also allow it to be simplified to use a plain hash
  instead of pointlessly using HMAC with a fixed key.

Anyway, just another one of the long tail of odd users that could have
solved their problem in a better way.  This one is at least compatible
with the hardening that's being considered.

By the way, also on the topic of FIPS 140-3, some people do use AF_ALG
for ACVP (even though it's not all that great for that purpose, either).
But ACVP is a testing thing, not something that is needed on production
systems.  ACVP can just be run as root on a testing build; there's no
need to enable support for it in the actual production build.

- Eric


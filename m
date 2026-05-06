Return-Path: <linux-api+bounces-6272-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AD91Cq2I+mmYPgMAu9opvQ
	(envelope-from <linux-api+bounces-6272-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Wed, 06 May 2026 02:17:49 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B164A4D4F18
	for <lists+linux-api@lfdr.de>; Wed, 06 May 2026 02:17:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7A9B130208E4
	for <lists+linux-api@lfdr.de>; Wed,  6 May 2026 00:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3779A19DF6A;
	Wed,  6 May 2026 00:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cc5LrKpR"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F18E555;
	Wed,  6 May 2026 00:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778026664; cv=none; b=jT97GM1EJZvKXpdyAvUxBaYGxiRhzUvjFzK+tgr6XJ+UygjEJH+C4ZR8PTkcOfDxJ0JRRdBU29kwMWR5MCyEY84+mwkSa001A6ybrysKLxcnFxKcabOYt8j9lSI4biCMPB87dtYhZLKcnVxVPKMJ/jAQms/4tFdEqyZSZx5EN0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778026664; c=relaxed/simple;
	bh=6foGj3Qcoh1WnIWLVeql78W0P57rxlrScla5/6G7PdY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aXRVrP8RFRski/Q74f0u6PInFjWo8PeZO3BaMtjacP8kl4D6jwqoGakkQPjhbETgv72awrJIgG0O67wEp5i2+b6zv7A5DdO7A5t1VBGAlPQ1xtZkE08twT3CKtmv2JAzlUV95Br1qvnFLnFhU//pEhUBa/SaJR0IYYs+hBz7OSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cc5LrKpR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BA02C2BCB4;
	Wed,  6 May 2026 00:17:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778026663;
	bh=6foGj3Qcoh1WnIWLVeql78W0P57rxlrScla5/6G7PdY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cc5LrKpRw18DZUcURk0QrCcMgCDOrkNDvobCxAp0hYVyGq141EoLh+eZB5eXVrPU/
	 jfv0Ft1jPNwlAjbNjnqmffQ0SCqggFEqVLionwzMswFPt0K2SoV5U0/IiofaaYSL1h
	 YWyWVoh1mU10mUhxdtP8umxEogs9K52o8DoHbhh2qSgISDLDL7k5zGtUQoSGUvxzKe
	 TOlm67Ggls4xcy8m5S4LRGipMT5+LJfI8B/zMm3j9YKWyulHBfPt5pjdwF2h0AIP76
	 hYavL7WOJoxGX0lVaxLbp8jRFYhgEzTSQTYn0Tx5F66KgYPPqPeLhucE15kEX9mN5F
	 BtOKAlHx5H6ew==
Date: Tue, 5 May 2026 17:17:40 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Andy Lutomirski <luto@amacapital.net>
Cc: linux-crypto@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>,
	linux-doc@vger.kernel.org, linux-api@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] crypto: af_alg - Document the deprecation of AF_ALG
Message-ID: <20260506001740.GA67098@quark>
References: <20260430011544.31823-1-ebiggers@kernel.org>
 <CALCETrVqG+1yErRJjkxvJrf=A+Vu84HTR4Bx1Pcd8G1C0PJcMA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALCETrVqG+1yErRJjkxvJrf=A+Vu84HTR4Bx1Pcd8G1C0PJcMA@mail.gmail.com>
X-Rspamd-Queue-Id: B164A4D4F18
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6272-lists,linux-api=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,linux-api@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-api];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,copy.fail:url]

On Tue, May 05, 2026 at 04:17:18PM -0700, Andy Lutomirski wrote:
> > On Apr 29, 2026, at 6:19 PM, Eric Biggers <ebiggers@kernel.org> wrote:
> >
> > ﻿AF_ALG is almost completely unnecessary, and it exposes a massive attack
> > surface that hasn't been standing up to modern vulnerability discovery
> > tools.  The latest one even has its own website, providing a small
> > Python script that reliably roots most Linux distros: https://copy.fail/
> 
> How about adding a configuration option, defaulted on, that requires
> capable(CAP_SYS_ADMIN) to create the socket (and maybe also to bind /
> connect it).  And a sysctl to allow the administrator to override this
> in the unlikely event that it’s needed.
> 
> IIRC cryptsetup used to and maybe even still does require these
> sockets sometimes and this would let it keep working.  And there's all
> the FIPS stuff downthread.

Yes, I'd like to add a default-on requirement to hold a capability in
the initial user namespace.  We're trying to figure out the details.

It sounds like iwd runs with CAP_NET_ADMIN, not necessarily
CAP_SYS_ADMIN.  So it may need to be:

    has_capability_noaudit(current, CAP_NET_ADMIN) || capable(CAP_SYS_ADMIN)

iwd is being discussed in the thread
https://lore.kernel.org/linux-crypto/bcbbef00-5881-421b-8892-7be6c04b832d@gmail.com/

cryptsetup is normally run with CAP_SYS_ADMIN, but not always (e.g.,
'cryptsetup benchmark').  It might be acceptable for users to add sudo
in the exceptional cases.  cryptsetup is being discussed in the thread
https://lore.kernel.org/linux-crypto/5dd3be22-13fb-41fb-b469-1ae6472200b1@gmail.com/

bluez needs investigation.

- Eric


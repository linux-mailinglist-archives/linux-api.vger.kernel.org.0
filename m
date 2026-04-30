Return-Path: <linux-api+bounces-6238-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ONQFJXe68mkYtwEAu9opvQ
	(envelope-from <linux-api+bounces-6238-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Thu, 30 Apr 2026 04:12:07 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C65349C381
	for <lists+linux-api@lfdr.de>; Thu, 30 Apr 2026 04:12:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2FF973029258
	for <lists+linux-api@lfdr.de>; Thu, 30 Apr 2026 02:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 940CF28466C;
	Thu, 30 Apr 2026 02:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k5kPcn1Q"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F09927281E;
	Thu, 30 Apr 2026 02:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777515121; cv=none; b=LPCIQeHyAov4mOEdRAh9AiW68G+tBHJNpaFxxcHniPDMejdiYPsxf4i/i+VAbbtQ8udBzdEutQ6uLh8/IumRsQGyk4jlE3/5SDzq22+Ecf7nPpF046Gow68qH81ZfeAguF4sTNdAOQkzNbSoLaQmgflRIh9MNLZtGRdnCku9Y+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777515121; c=relaxed/simple;
	bh=Iynk1THCP/qxdLQKKSMR/8OAJf7uHsox6KYhOKpSMU0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CinLlP1p6KdqF0nBTrYiloh2E+KZ1q98ZFUWRZgIddFDCz8L2xGip2+rHfyepSVGjzyprYBUFotq1wKPhu+feGujq94O32P5YRdYjrLI5Cf/RNrVGVqwKat0CthrbMIOpG/n67OxRvmmgN7qklgBdJvc44rpJvS9oZ0wTPJ7Lh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k5kPcn1Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73F8FC19425;
	Thu, 30 Apr 2026 02:12:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777515120;
	bh=Iynk1THCP/qxdLQKKSMR/8OAJf7uHsox6KYhOKpSMU0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k5kPcn1Q1fUhwjrw0jUQbfbBGvNFQcLWfY70N66e6NxJsAlJ72hGJFLJdO/PzWgpo
	 MLxCvYfGQpDkBNr3pnw/MT9mkIJiDXWGypfO85vxMM3hJOreGIN7mRc9e8N4nezFk3
	 UnF1NLTth1FY0KExLwJkQdwIojJO9kunMAGn/+w7p3neh1GrcKY3asz+9VnOgCajqI
	 8dyfrmHbUbPnvzcBdriDV3bJR7qoNLLsGLSfZGF6nRQrOwfelo6PUH9PVx8LEH4is4
	 tHc4jTR5t8aPrg4fvnYgWHkL2YMnM48nyrNzslD6/WfgwL8/AWpdwqREf2/k4JQIJn
	 3HN/JRZClm+lA==
Date: Wed, 29 Apr 2026 19:10:42 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: linux-crypto@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	David Howells <dhowells@redhat.com>
Subject: Re: [PATCH] crypto: af_alg - Document the deprecation of AF_ALG
Message-ID: <20260430021042.GA51782@sol>
References: <20260430011544.31823-1-ebiggers@kernel.org>
 <afK4zC-Mgo6LBfUh@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afK4zC-Mgo6LBfUh@gondor.apana.org.au>
X-Rspamd-Queue-Id: 5C65349C381
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6238-lists,linux-api=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,linux-api@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-api];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[copy.fail:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Thu, Apr 30, 2026 at 10:05:00AM +0800, Herbert Xu wrote:
> On Wed, Apr 29, 2026 at 06:15:44PM -0700, Eric Biggers wrote:
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
> 
> What about the exposure of akcipher through security/keys/keyctl_pkey.c?
> 
> There isn't even a Kconfig option to disable that user-space API.
> If module signatures are enabled then this automatically gets added
> to the kernel:
> 
> MODULE_SIG -> MODULE_SIG_FORMAT -> SYSTEM_DATA_VERIFICATION ->
> KEYS + ASYMMETRIC_KEY_TYPE

Yes, that would be a different patch, but KEYCTL_PKEY_* have a very
similar issue.  That should have a kconfig option added too.

I believe iwd is the main (or even only?) user there, as well.

- Eric


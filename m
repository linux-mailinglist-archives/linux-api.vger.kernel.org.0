Return-Path: <linux-api+bounces-6293-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6Gm+HBnGAWqSjgEAu9opvQ
	(envelope-from <linux-api+bounces-6293-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Mon, 11 May 2026 14:05:45 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C876950D4E1
	for <lists+linux-api@lfdr.de>; Mon, 11 May 2026 14:05:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D923830053EB
	for <lists+linux-api@lfdr.de>; Mon, 11 May 2026 12:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F15A1378839;
	Mon, 11 May 2026 12:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tyouepRy"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC372244665;
	Mon, 11 May 2026 12:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778500853; cv=none; b=aYffw8ZR4uL1AvJKduzC7bHD4N6qC9MicxwqQnGlkTCdifq93XtwwjiT986Tk97EsU5XB48vvojPJZySXk0rmkDYkftMr7KeNeQtarbUUMPRbq+VJWolSIh02/yJgyKZlGMGH0cjQuCAsDHCCC4SPp1W+RAK1kFbbKHk+h7LlFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778500853; c=relaxed/simple;
	bh=3ltXO6+gbYKtV0Usdp0V0TIVDklrgiK3bsK9XntO6Zc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R+3I+apUGLbOFFOvdhW48527xKMJNDAYALR//alEPB/CLOxY2qVcbFq4/fPDNobt5gSfcjqq3yysfHTabLDc8uNN/LWBNuQzgnnDODAA+GOhAoey4QweMW6Hbh1Jy6CZeZQlT610j/TXh+NUy2fEgBVjC3RCvzN8VrBGHeBoupg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tyouepRy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3437FC2BCB0;
	Mon, 11 May 2026 12:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778500853;
	bh=3ltXO6+gbYKtV0Usdp0V0TIVDklrgiK3bsK9XntO6Zc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tyouepRyY8HBIVvAd0PpMtwm1T95c3wn+3rDWYuYhAlgKdCfyK/YT6SOSrppIcQyi
	 l/1Oas2xv9LIlPZvZk6tzj6g6Und3idvH7qruSMQwBtZWke9K+EiRr5wC7glA95u39
	 PEdgC06gDcljZaHoUK5yz7KHcAUsknmndSKBgLT6iuYx6KjoLKkO70/JT1wrejnNW7
	 OQ/596rNlKiPsLm3RF0emnpAquDRoPNXlWd6NQS+LvzeE4oEHoRFbpUU+vMGId+ScS
	 wO33z9MZn13e2xqhfsiGmV4Tj1gg2oyyQ2UqO/CwHzHrEJjGSgCnvOe93dNEnjVD2b
	 IzN8YZgJb6gCg==
Date: Mon, 11 May 2026 14:00:35 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jori Koolstra <jkoolstra@xs4all.nl>
Cc: Aleksa Sarai <cyphar@cyphar.com>, Andy Lutomirski <luto@kernel.org>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Arnd Bergmann <arnd@arndb.de>, "H . Peter Anvin" <hpa@zytor.com>, Jan Kara <jack@suse.cz>, 
	Peter Zijlstra <peterz@infradead.org>, Andrey Albershteyn <aalbersh@redhat.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	cmirabil@redhat.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-api@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [RFC PATCH v2 1/2] vfs: syscalls: add mkdirat2() that returns an
 O_DIRECTORY fd
Message-ID: <20260511-hochdekoriert-neoliberale-f7a2922bc57c@brauner>
References: <20260412135434.3095416-1-jkoolstra@xs4all.nl>
 <20260412135434.3095416-2-jkoolstra@xs4all.nl>
 <20260427-umlegen-aufbau-ee3a97f1528a@brauner>
 <1600596489.77018.1777916475931@kpc.webmail.kpnmail.nl>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1600596489.77018.1777916475931@kpc.webmail.kpnmail.nl>
X-Rspamd-Queue-Id: C876950D4E1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[xs4all.nl];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6293-lists,linux-api=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-api@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-api];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Mon, May 04, 2026 at 07:41:15PM +0200, Jori Koolstra wrote:
> 
> > Op 27-04-2026 17:48 CEST schreef Christian Brauner <brauner@kernel.org>:
> > 
> > So definitely a patchset worthing doing but this will be hairy. And
> > Mateusz is right. As written this doesn't work. The canonical pattern
> > how e.g., dentry_open() does it is to preallocate the file.
> > 
> 
> Is this because of Mateusz point that we should fail as soon as possible
> to prevent any fs changes from taking effect?
> 
> But like Mateusz points out, this is not really happening for open() with
> O_CREAT either. So is there any policy for what we do and do not tolerate?
> (although I agree we should definitely preallocate the file; thanks for
> pointing that pattern out).

Your version can fail in a lot more cases than O_CREAT because the file
is allocated last which is just not acceptable.

And a misbehaving LSM that ends up preventing opening a created file is
really not our concern. The system can behave in all non-standard ways
with mandatory access control.

The other concern that was brought up in some version is truncate but I
really don't understand what that is supposed to be about. O_TRUNC and
O_CREAT raally don't get in the way of each other in the way people
think they would.

Just look at the FMODE_CREATED case. If that's raised on do_open() then
O_TRUNC is ignored for very obvious reasons.

The only reason where O_TRUNC with O_CREAT matters is if the file did
already exist which also implies O_EXCL isn't raised. In that case this
ends up as a regular truncate request and then it is possible to hit the
handle_truncate() codepath. And there it really doesn't matter. A
concurrent exec or truncate that prevents you from O_CREAT | O_TRUNC
seems perfectly benign if you didn't actually create the file in the
first place. The O_TRUNC would only be honored if we did end up creating
the file. If someone else raised us in doing their own truncate or is
attempting an exe then we should most certainly not get to truncate over
them. Failing is the right thing to do here.

> 
> > I do wonder though whether we shouldn't just make O_CREAT | O_DIRECTORY
> > work. I remember that I had a vague comment about this in [1] a few
> > years ago (cf. [1]). It might even be less hairy to get that one right
> > as all the thinking for O_CREAT is already there.
> > 
> > What was the rationale for mkdirat2() instead of threading this through
> > openat()/openat2() with O_CREAT?
> > 
> 
> Because of Mateusz' objection, but I agree with Aleksa (and you in 2023)
> that this is intuitive and you mentioned POSIX allows for it.
> 
> But a more general issue, that also applies to this mkdirat2 patch,
> is Linus' objection in that same thread.[1] However, the use-case of

mkdirat2() is objectively the worse api. It forces userspace to use a
separate system call without any reason whatsoever. If you can to
O_CREAT you should also be able to to O_DIRECTORY in the same system
call. If we support O_DIRECTORY | O_CREAT we get all the lookup
restriction niceties RESOLVE_* for free. Plus, it is supportable both in
openat() and openat2() because I made that combo return an errno.

UAPI design often is a nasty mix of performance (context switches),
separation of concerns and privileges, tastefulness, and compromises you
never thought or wanted to make.

I think here it is pretty clear that O_DIRECTORY | O_CREAT is the right
thing to do. Instead of restructuring a bunch of codepaths so it can be
plumbed through to the filesystems we just reuse the existing codepaths
that give us the right context for free.

And during LSFMM the VFS maintains all agreed to proceed with
O_DIRECTORY | O_CREAT.


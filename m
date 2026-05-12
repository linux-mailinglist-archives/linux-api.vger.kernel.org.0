Return-Path: <linux-api+bounces-6326-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4CxjNdhgA2r65QEAu9opvQ
	(envelope-from <linux-api+bounces-6326-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Tue, 12 May 2026 19:18:16 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 57371525AA7
	for <lists+linux-api@lfdr.de>; Tue, 12 May 2026 19:18:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 729083084785
	for <lists+linux-api@lfdr.de>; Tue, 12 May 2026 17:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE4EA385D96;
	Tue, 12 May 2026 17:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="OG/o9MQw"
X-Original-To: linux-api@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F84385D95;
	Tue, 12 May 2026 17:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778605950; cv=none; b=klZIxsguQyR369Q1UPpWqPAfeww/89ahNJN2YExQwK5wtjGlh1y4jSk6o5YlNPveJGxHUMKxXrYg/T3Er7vISnMPagj+sOkgdpP9Nld7Ua4NA1vjx7k7cxdGTPx0Kgo996wb+94GqxaivrZprWA6b8DZZTIzIFVl4oNFmVeNFuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778605950; c=relaxed/simple;
	bh=DrzCVQdjnTp2ELH1Ym1g9HHLyYYLanMMjaFUKRSNOYs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z0U2+lG7iKdoMWG59Y2gpg/ziXTp7U+RspA+4PEsqhsxBcALf48+YuB/i6OA4WVpYdg92nh95xkFlfiHSvymE7oKlCbW2ozorE4ta3W2ePOSg6HMkBsIqCx/BplUeAxjq5Ax9v8EbF0unQ2ZmRiZ6qT6RNK+wSlQNgD8q6nfxdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=OG/o9MQw; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4gFNSR3zM0z9v0b;
	Tue, 12 May 2026 19:12:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1778605943;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DrzCVQdjnTp2ELH1Ym1g9HHLyYYLanMMjaFUKRSNOYs=;
	b=OG/o9MQwFjX3mpiEce6/I1jZy1bDNA47aKOVmnxHiprbDM6lxXd4mcf1nwn8zp1tJ65+ik
	8CGsc58KWB3o8Mkbm3qUauadCKK8CeQZEie1mPI8NPBhdP8HVz/Zh6ZhlYRyMuz6hi+IDM
	8U1ZMOpS/tGaEFu8aa2kIw7vE9QDOAkD3QFxVSBE83Eb2PvJuOLooCHqIxWM4OfhTg11d5
	x6T0QijQjfQiQhsoMR5ldlAH2bsjfmEHMgrEFO7757bnfUlexYOz32IZzykkgtQ+7ZGC87
	mHZw2/U3sMcGiMhl9k+zAZ7Wc1p5MzmZnzhCuhRkzQh7pE8iN3PKJiBPfpedaQ==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of cyphar@cyphar.com designates 2001:67c:2050:b231:465::202 as permitted sender) smtp.mailfrom=cyphar@cyphar.com
Date: Wed, 13 May 2026 03:11:57 +1000
From: Aleksa Sarai <cyphar@cyphar.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Jori Koolstra <jkoolstra@xs4all.nl>, Andy Lutomirski <luto@kernel.org>, 
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
Message-ID: <2026-05-12-aging-demur-content-penalty-txHKga@cyphar.com>
References: <20260412135434.3095416-1-jkoolstra@xs4all.nl>
 <20260412135434.3095416-2-jkoolstra@xs4all.nl>
 <20260427-umlegen-aufbau-ee3a97f1528a@brauner>
 <1600596489.77018.1777916475931@kpc.webmail.kpnmail.nl>
 <20260511-hochdekoriert-neoliberale-f7a2922bc57c@brauner>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lpi4vqgqbrhtuenl"
Content-Disposition: inline
In-Reply-To: <20260511-hochdekoriert-neoliberale-f7a2922bc57c@brauner>
X-Rspamd-Queue-Id: 57371525AA7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-4.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[cyphar.com,reject];
	R_DKIM_ALLOW(-0.20)[cyphar.com:s=MBO0001];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6326-lists,linux-api=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[xs4all.nl,kernel.org,redhat.com,alien8.de,linux.intel.com,zeniv.linux.org.uk,arndb.de,zytor.com,suse.cz,infradead.org,linutronix.de,efficios.com,linuxfoundation.org,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cyphar@cyphar.com,linux-api@vger.kernel.org];
	DKIM_TRACE(0.00)[cyphar.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-api];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action


--lpi4vqgqbrhtuenl
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [RFC PATCH v2 1/2] vfs: syscalls: add mkdirat2() that returns an
 O_DIRECTORY fd
MIME-Version: 1.0

On 2026-05-11, Christian Brauner <brauner@kernel.org> wrote:
> On Mon, May 04, 2026 at 07:41:15PM +0200, Jori Koolstra wrote:
> > Because of Mateusz' objection, but I agree with Aleksa (and you in 2023)
> > that this is intuitive and you mentioned POSIX allows for it.
> >=20
> > But a more general issue, that also applies to this mkdirat2 patch,
> > is Linus' objection in that same thread.[1] However, the use-case of
>=20
> mkdirat2() is objectively the worse api. It forces userspace to use a
> separate system call without any reason whatsoever. If you can to
> O_CREAT you should also be able to to O_DIRECTORY in the same system
> call. If we support O_DIRECTORY | O_CREAT we get all the lookup
> restriction niceties RESOLVE_* for free. Plus, it is supportable both in
> openat() and openat2() because I made that combo return an errno.
>=20
> UAPI design often is a nasty mix of performance (context switches),
> separation of concerns and privileges, tastefulness, and compromises you
> never thought or wanted to make.
>=20
> I think here it is pretty clear that O_DIRECTORY | O_CREAT is the right
> thing to do. Instead of restructuring a bunch of codepaths so it can be
> plumbed through to the filesystems we just reuse the existing codepaths
> that give us the right context for free.

FWIW, I completely agree.

> And during LSFMM the VFS maintains all agreed to proceed with
> O_DIRECTORY | O_CREAT.

(With the caveat that we do not copy the dangling symlink behaviour from
O_CREAT, as there be dragons.)

--=20
Aleksa Sarai
https://www.cyphar.com/

--lpi4vqgqbrhtuenl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQS2TklVsp+j1GPyqQYol/rSt+lEbwUCagNfWhsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMiwyLDIACgkQKJf60rfpRG8+UgEAxjjQD2Cr4f6EpoRHlCn/
IfOXynIecmU2oJ10LBBHJhoBAN/e/n6yx3Ixzy/TA7i38m/5jyxjW+zUOLPKm21j
+9QC
=rmyJ
-----END PGP SIGNATURE-----

--lpi4vqgqbrhtuenl--


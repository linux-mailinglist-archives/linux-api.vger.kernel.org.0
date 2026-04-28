Return-Path: <linux-api+bounces-6210-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ALasASkK8GkiNgEAu9opvQ
	(envelope-from <linux-api+bounces-6210-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Tue, 28 Apr 2026 03:15:21 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A1E2947C58E
	for <lists+linux-api@lfdr.de>; Tue, 28 Apr 2026 03:15:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 288E6303663E
	for <lists+linux-api@lfdr.de>; Tue, 28 Apr 2026 01:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A78F72D0625;
	Tue, 28 Apr 2026 01:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="oO6Zaq8U"
X-Original-To: linux-api@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B72F12BEFED;
	Tue, 28 Apr 2026 01:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777338910; cv=none; b=VKDxaHLKe9AV0i2ZrbwcSV5a5XNKnYaT1NvBhicsIyyiBMM7zm5TAzEAoMPKMkztVSvo2VPESQRxYCRRKqPdheqACXDOjwWL19V/jsYq8WhbYiT2jHn5WREnohCemjFDMPaVDgJjaEwXr7/GOHGTZwvIr9n3cgVrvefYlJtKGng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777338910; c=relaxed/simple;
	bh=LzUB/ZD604itqaxy/8+N5zkZTGwBL7cXXLe2cPQxQFI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e2mxJM8ux73u2MzhpH+evoF686LJH9G8CMYbrsw9Ph449fmPeR6XP+HTjPi1egJInJDZolNuYTytV+fv+cAyw8fy/RZzQwFDHFttZxxyzN9uUUkcxkUJnPg81gWrMrYN1/oJMrfs5+yuX1jYYCfi0QVwPQ76+w/eW8sri8pm7/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=oO6Zaq8U; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4g4MtH5QbTz9t5q;
	Tue, 28 Apr 2026 03:15:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1777338903;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WGPMR8dNcHE5pPzgJKMfmwy/Nz6ESEu5+NAcbwXAYZ4=;
	b=oO6Zaq8UGDP1hgu8xebfat/qL3xZPidqWDxAE70HKf54Kfe4sIqnrvr8odQHGH5FNayP4f
	QwMW7v472RogSNwjwVdWTbIXJ/knsHvOT4OLLfZhW0ogs9thnWU2tbGWo8vDHl6We69y7l
	bH6vRiK1y/s+flwXTUaq266iCS7gthRToROEpu65INbDjqNWP+F2ZKJ/vco9hKMjIEJqJx
	MoJrYF7HXFG+sI+51+OAFpW1S54cd2seTLg4wNLqBrCfe/5osEYi7U93CRCIX/oKOhE/Rz
	Dw9sozIhurcnmk5jhXfU068F/t546MGKstbweL/feIcIguixv2GIpvhObeXc4w==
Date: Tue, 28 Apr 2026 11:14:47 +1000
From: Aleksa Sarai <cyphar@cyphar.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Jori Koolstra <jkoolstra@xs4all.nl>, Jeff Layton <jlayton@kernel.org>, 
	Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Arnd Bergmann <arnd@arndb.de>, "H . Peter Anvin" <hpa@zytor.com>, Jan Kara <jack@suse.cz>, 
	Peter Zijlstra <peterz@infradead.org>, Andrey Albershteyn <aalbersh@redhat.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	cmirabil@redhat.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org, 
	linux-arch@vger.kernel.org
Subject: Re: [RFC PATCH v2 1/2] vfs: syscalls: add mkdirat2() that returns an
 O_DIRECTORY fd
Message-ID: <2026-04-28-demur-blocky-boon-prizes-kUj5bz@cyphar.com>
References: <20260412135434.3095416-1-jkoolstra@xs4all.nl>
 <20260412135434.3095416-2-jkoolstra@xs4all.nl>
 <20260427-umlegen-aufbau-ee3a97f1528a@brauner>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="owgh52ziss34ktt4"
Content-Disposition: inline
In-Reply-To: <20260427-umlegen-aufbau-ee3a97f1528a@brauner>
X-Rspamd-Queue-Id: A1E2947C58E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-4.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[cyphar.com,reject];
	R_DKIM_ALLOW(-0.20)[cyphar.com:s=MBO0001];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6210-lists,linux-api=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[xs4all.nl,kernel.org,redhat.com,alien8.de,linux.intel.com,zeniv.linux.org.uk,arndb.de,zytor.com,suse.cz,infradead.org,linutronix.de,efficios.com,linuxfoundation.org,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cyphar@cyphar.com,linux-api@vger.kernel.org];
	DKIM_TRACE(0.00)[cyphar.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-api];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[cyphar.com:url,cyphar.com:dkim,cyphar.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]


--owgh52ziss34ktt4
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [RFC PATCH v2 1/2] vfs: syscalls: add mkdirat2() that returns an
 O_DIRECTORY fd
MIME-Version: 1.0

On 2026-04-27, Christian Brauner <brauner@kernel.org> wrote:
> On Sun, Apr 12, 2026 at 03:54:33PM +0200, Jori Koolstra wrote:
> > +	if (open && !error && !is_delegated(&delegated_inode)) {
> > +		const struct path new_path =3D { .mnt =3D path.mnt, .dentry =3D dent=
ry };
> > +		filp =3D dentry_open(&new_path, O_DIRECTORY, current_cred());
> > +	}
>=20
> So definitely a patchset worthing doing but this will be hairy. And
> Mateusz is right. As written this doesn't work. The canonical pattern
> how e.g., dentry_open() does it is to preallocate the file.
>=20
> I do wonder though whether we shouldn't just make O_CREAT | O_DIRECTORY
> work. I remember that I had a vague comment about this in [1] a few
> years ago (cf. [1]). It might even be less hairy to get that one right
> as all the thinking for O_CREAT is already there.

That would be my preference, as it would also allow us to use RESOLVE_*
flags nicely.

> What was the rationale for mkdirat2() instead of threading this through
> openat()/openat2() with O_CREAT?

Mateusz said that he didn't like the idea of having more branches in
the open() paths, I think that ship has long since sailed tbh.

> And side-question: @Jeff, can nfs atomic open deal with O_CREAT |
> O_DIRECTORY?
>=20
> [1]: 43b450632676 ("open: return EINVAL for O_DIRECTORY | O_CREAT")

--=20
Aleksa Sarai
https://www.cyphar.com/

--owgh52ziss34ktt4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQS2TklVsp+j1GPyqQYol/rSt+lEbwUCafAKBxsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMiwyLDIACgkQKJf60rfpRG+g4wEAmkPRdHEqyElIHqgSA6IY
SJNzwTqfXfzPput10NF0VZ4BAJYj8f4QruB+vzgL8MYcgJH1Ah+uJB1qlpY8CdWw
vFAM
=X9pH
-----END PGP SIGNATURE-----

--owgh52ziss34ktt4--


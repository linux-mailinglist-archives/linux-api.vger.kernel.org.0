Return-Path: <linux-api+bounces-6075-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YAf+F3Fc12kCNAgAu9opvQ
	(envelope-from <linux-api+bounces-6075-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Thu, 09 Apr 2026 09:59:45 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A948F3C760D
	for <lists+linux-api@lfdr.de>; Thu, 09 Apr 2026 09:59:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 50405300C00B
	for <lists+linux-api@lfdr.de>; Thu,  9 Apr 2026 07:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 327813876B3;
	Thu,  9 Apr 2026 07:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="Y/OCmmj8"
X-Original-To: linux-api@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49DA2387570;
	Thu,  9 Apr 2026 07:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775721537; cv=none; b=O8PhCgLNqPW/1hGOGo8YiiYpnLQGw71A3g8vYwz1SYMhFyIQ8u52jn+ZSfe48l32YowaYeNIhJjj0p941ilaUscQL/ovbpt+WS6Ds+v3l5DsihRwUDDxauqGfPkXM86x9ZFT4rUXnnNrgvUdR5QgiLGm2PWZ/xFY5I1cUG2lnSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775721537; c=relaxed/simple;
	bh=uGHjWOVWbXx3D0UdHIEoCnTuSer89svIFp1G0mY5U2E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cg62BKPjS6Y3b4hprC1jHIzXPb0PZ9AqH0kbScfPgYVaqygYOUvzpWLyfU3rlWx20lewQ5LjYI/FS4AGhYIYN7+qwxWkuD9YwD/OfI+jltushVzMgDuv9L8ZaIj1CvN7EivqWY6l6JJJkVsP0f5Aj5l1JSyiGY9IsYqu7LikaAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=Y/OCmmj8; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4frsky0nnkz9tcN;
	Thu,  9 Apr 2026 09:58:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1775721530;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uGHjWOVWbXx3D0UdHIEoCnTuSer89svIFp1G0mY5U2E=;
	b=Y/OCmmj84uO6UTKKkqhY4xBDKhY2FimlOsu2fJKwXU3+ZJ6KZnWKQxDZFKgd3wxkkMeHzN
	UfQqbNrjI4Be91At2EbABl8Z9D1gftb/6IuZCeYjiZ+RYY6waYUH88s09l4EIseIUjjU/a
	HvChXSdUJHpf7cAZFAqCrkEVMLUs//edNyU01Njj6j8HJ6mLieZp184SACcq3Eb3yQJy2c
	klt6wn+acJB4mnHRtRa87u/lmcLyGPvaSV7bTRGxya1hprDH0bib62wb6gNfwdKWiy3ysn
	/vovZYnKWvldTm8rGxa5SuaTw38vHoHtPH0jvFHuilgu68IE6kVb7lODjqJwug==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of cyphar@cyphar.com designates 2001:67c:2050:b231:465::2 as permitted sender) smtp.mailfrom=cyphar@cyphar.com
Date: Thu, 9 Apr 2026 17:58:31 +1000
From: Aleksa Sarai <cyphar@cyphar.com>
To: Jori Koolstra <jkoolstra@xs4all.nl>
Cc: Mateusz Guzik <mjguzik@gmail.com>, Andy Lutomirski <luto@kernel.org>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jeff Layton <jlayton@kernel.org>, 
	Chuck Lever <chuck.lever@oracle.com>, Arnd Bergmann <arnd@arndb.de>, Shuah Khan <shuah@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "H. Peter Anvin" <hpa@zytor.com>, Jan Kara <jack@suse.cz>, 
	Alexander Aring <alex.aring@gmail.com>, Peter Zijlstra <peterz@infradead.org>, 
	Oleg Nesterov <oleg@redhat.com>, Andrey Albershteyn <aalbersh@redhat.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, Namhyung Kim <namhyung@kernel.org>, 
	Arnaldo Carvalho de Melo <acme@redhat.com>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-api@vger.kernel.org, linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	cmirabil@redhat.com, "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Subject: Re: [RFC PATCH 1/2] vfs: syscalls: add mkdirat_fd()
Message-ID: <2026-04-09-blank-hunky-inactivity-flowers-18Sd4K@cyphar.com>
References: <20260331172011.3512876-1-jkoolstra@xs4all.nl>
 <20260331172011.3512876-2-jkoolstra@xs4all.nl>
 <pbobkjhtuli53o3z34ajyxztaosmztwlygxfxhhjq5ajt47inc@ngtoge3ucdm5>
 <2026-04-02-aged-convex-snowbird-foxes-Ym20JZ@cyphar.com>
 <52244194.1650546.1775684643065@kpc.webmail.kpnmail.nl>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="k2hfwjyntbi772ln"
Content-Disposition: inline
In-Reply-To: <52244194.1650546.1775684643065@kpc.webmail.kpnmail.nl>
X-Spamd-Result: default: False [-2.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[cyphar.com,reject];
	R_DKIM_ALLOW(-0.20)[cyphar.com:s=MBO0001];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6075-lists,linux-api=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[xs4all.nl];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[33];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,redhat.com,alien8.de,linux.intel.com,zeniv.linux.org.uk,oracle.com,arndb.de,linuxfoundation.org,zytor.com,suse.cz,infradead.org,efficios.com,linutronix.de,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cyphar@cyphar.com,linux-api@vger.kernel.org];
	DKIM_TRACE(0.00)[cyphar.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-api];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[cyphar.com:dkim,cyphar.com:mid,cyphar.com:email,cyphar.com:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,xs4all.nl:email]
X-Rspamd-Queue-Id: A948F3C760D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--k2hfwjyntbi772ln
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [RFC PATCH 1/2] vfs: syscalls: add mkdirat_fd()
MIME-Version: 1.0

On 2026-04-08, Jori Koolstra <jkoolstra@xs4all.nl> wrote:
>=20
> > Op 02-04-2026 04:52 CEST schreef Aleksa Sarai <cyphar@cyphar.com>:
> >=20
> > Please do not use O_* flags! O_CLOEXEC takes up 3 flag bits on different
> > architectures which makes adding new flags a nightmare.
> >=20
> > I think this should take AT_* flags and (like most newer syscalls)
> > O_CLOEXEC should be automatically set. Userspace can unset it with
> > fnctl(F_SETFD) in the relatively rare case where they don't want
> > O_CLOEXEC.
>=20
> And then do something like statx_lookup_flags() does to build the lookup
> flags from those AT flags?

Yeah, that is the usual pattern for *at(2) syscalls.

> But there is also no AT_ROOT_CONTAINED (or whatever you would want to
> call the RESOLVE_IN_ROOT AT-equivalent) right now.

This point about AT_* flags was a separate point to my hopes that we
could get this into openat2(2). We don't have AT_* equivalents to
RESOLVE_* flags because it would burn too many bits (at least 5,
likely more when we add RESOLVE_NO_DOTDOT and other such extensions) and
openat2(2) is actually sufficient for almost all operations in practice.

> > Alternatively, we could just bite the bullet and make
> > AT_NO_CLOEXEC a thing...
>=20
> What's the bullet to bite there?

It's not a big deal but it just burns another generic AT_* flag bit for
something that userspace can do themselves with fnctl(2).

Maybe having it will encourage future syscall authors to default to
O_CLOEXEC, but we could end up with the slightly silly AT_SYMLINK_FOLLOW
/ AT_SYMLINK_NOFOLLOW situation too. Documenting it in
seemingly-rarely-read Documentation/process/adding-syscalls.rst might
end up being equally (in)effective without burning a flag bit... :/

--=20
Aleksa Sarai
https://www.cyphar.com/

--k2hfwjyntbi772ln
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQS2TklVsp+j1GPyqQYol/rSt+lEbwUCaddcJhsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMiwyLDIACgkQKJf60rfpRG/mcgEA9HmAsJvMhlTmxWLJnRhT
N6H+k7b6Nyum8hYopahQGrQA/3s9M0dm2wGkVJdmVn0sUDH5Xs6JMfuVRNz0n8hV
Fk0N
=uAhk
-----END PGP SIGNATURE-----

--k2hfwjyntbi772ln--


Return-Path: <linux-api+bounces-6056-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6L+dLUzazWmliQYAu9opvQ
	(envelope-from <linux-api+bounces-6056-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Thu, 02 Apr 2026 04:54:04 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E257382DD1
	for <lists+linux-api@lfdr.de>; Thu, 02 Apr 2026 04:54:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 16AFB301AF51
	for <lists+linux-api@lfdr.de>; Thu,  2 Apr 2026 02:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F9D034B66F;
	Thu,  2 Apr 2026 02:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="e87DXpVA"
X-Original-To: linux-api@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 877FF213E7A;
	Thu,  2 Apr 2026 02:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775098367; cv=none; b=TtIDZSHo6oI6+UL9/VJT1XHwAf06kYYuSsZ6SKP6X0H9oMOT7PlXiIVCpeT91ojawMFnSlRVMK4Ac6FjjsOEheshlwuMMjJKpwX+9T1i9CSdSzzE1tj+NC9JAMS72EE1Q7FZVrRMFroxrvbuk5RAalHgIzpL8xde4Ftp91RlIwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775098367; c=relaxed/simple;
	bh=0s3Ltdb3st4RBI8X7GzRMeGijr+TMGvhGRqHHFtYADY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rDhxgyKv5bIwp9XZlOABIRwZBcfdjccmnFJ3NbWTUBVi5QjPqU0daKosz2qsnlv+w5Eo5IOMw95y/0CQkfPwL4YsAM3VBWGvCc2unWNMHFhBYgOxgl6nl39xwI1OWJLd0SxaMNBBcno5gXpRCRTl2u/cpJ4VrLmbYTTysoQCP08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=e87DXpVA; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4fmRGw2qrYz9vVy;
	Thu,  2 Apr 2026 04:52:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1775098360;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PI01UIN30SAwEOjcWCs+qKe0QnW9aOaFpOr0QZg4IbQ=;
	b=e87DXpVA8fumafTy2ZJ4E9FwM6UVRu2C4sFnzIlhrIaWfjkqBUFxVQ552e3H+1apr2Hh1b
	1+GeY8BaAQToBwK8+aFRYuzXIB0NzFFynuHuG5rfKhwy0xwciIRkKFKHtcM/ATFdVFsXGi
	e/D+thWbkBZ5YSejLIiWl3CJyb+fWEHKZhYk/iANTu/LoLDaWqdJd6EVfuqNon87UrvPHI
	HAZVaCgUkhqoDbwqOB+yDsuRvpThDpZX+IJY/sHnNWCcWHOgKcI0+nFN8Sd/rlZ0qsfprc
	gAbrBmrW9Vputu5fQOImbhR1zEadhHNAkicDb5XW/DvHVbdgwI4yv441hSyM4A==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of cyphar@cyphar.com designates 2001:67c:2050:b231:465::102 as permitted sender) smtp.mailfrom=cyphar@cyphar.com
Date: Thu, 2 Apr 2026 13:52:15 +1100
From: Aleksa Sarai <cyphar@cyphar.com>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Jori Koolstra <jkoolstra@xs4all.nl>, Andy Lutomirski <luto@kernel.org>, 
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
Message-ID: <2026-04-02-aged-convex-snowbird-foxes-Ym20JZ@cyphar.com>
References: <20260331172011.3512876-1-jkoolstra@xs4all.nl>
 <20260331172011.3512876-2-jkoolstra@xs4all.nl>
 <pbobkjhtuli53o3z34ajyxztaosmztwlygxfxhhjq5ajt47inc@ngtoge3ucdm5>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="o3fvuy4phjbklnx7"
Content-Disposition: inline
In-Reply-To: <pbobkjhtuli53o3z34ajyxztaosmztwlygxfxhhjq5ajt47inc@ngtoge3ucdm5>
X-Spamd-Result: default: False [-2.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[cyphar.com,reject];
	R_DKIM_ALLOW(-0.20)[cyphar.com:s=MBO0001];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6056-lists,linux-api=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[33];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FREEMAIL_CC(0.00)[xs4all.nl,kernel.org,redhat.com,alien8.de,linux.intel.com,zeniv.linux.org.uk,oracle.com,arndb.de,linuxfoundation.org,zytor.com,suse.cz,gmail.com,infradead.org,efficios.com,linutronix.de,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.959];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cyphar@cyphar.com,linux-api@vger.kernel.org];
	DKIM_TRACE(0.00)[cyphar.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-api];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3E257382DD1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--o3fvuy4phjbklnx7
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [RFC PATCH 1/2] vfs: syscalls: add mkdirat_fd()
MIME-Version: 1.0

On 2026-04-01, Mateusz Guzik <mjguzik@gmail.com> wrote:
> On Tue, Mar 31, 2026 at 07:19:58PM +0200, Jori Koolstra wrote:
> > @@ -5286,7 +5290,25 @@ int filename_mkdirat(int dfd, struct filename *n=
ame, umode_t mode)
> >  		lookup_flags |=3D LOOKUP_REVAL;
> >  		goto retry;
> >  	}
> > +
> > +	if (!error && (flags & MKDIRAT_FD_NEED_FD)) {
> > +		struct path new_path =3D { .mnt =3D path.mnt, .dentry =3D dentry };
> > +		error =3D FD_ADD(0, dentry_open(&new_path, O_DIRECTORY, current_cred=
()));
> > +	}
> > +	end_creating_path(&path, dentry);
> >  	return error;
>=20
>=20
> You can't do it like this. Should it turn out no fd can be allocated,
> the entire thing is going to error out while keeping the newly created
> directory behind. You need to allocate the fd first, then do the hard
> work, and only then fd_install and or free the fd. The FD_ADD machinery
> can probably still be used provided proper wrapping of the real new
> mkdir.
>=20
> It should be perfectly feasible to de facto wrap existing mkdir
> functionality by this syscall.
>=20
> On top of that similarly to what other people mentioned the new syscall
> will definitely want to support O_CLOEXEC and probably other flags down
> the line.
>=20
> Trying to handle this in open() is a no-go. openat2 is rather
> problematic.

I'm interested in what makes you say that. It would be very nice to be able
to do mkdir + RESOLVE_IN_ROOT and get an fd back all in one syscall. :D

To be fair, build_open_how() will need some more magic to keep openat()
working, and that won't be particularly pretty. If we went with
O_CREAT|O_DIRECTORY we would need to be quite careful to make sure
O_TMPFILE continues to work for both openat() and openat2()...

> I tend to agree mkdirat_fd is not a good name for the syscall either,
> but I don't have a suggestion I'm happy with. I think least bad name
> would follow the existing stuff and be mkdirat2 or similar.
>=20
> The routine would have to start with validating the passed O_ flags, for
> now only allowing O_CLOEXEC and EINVAL-ing otherwise.

Please do not use O_* flags! O_CLOEXEC takes up 3 flag bits on different
architectures which makes adding new flags a nightmare.

I think this should take AT_* flags and (like most newer syscalls)
O_CLOEXEC should be automatically set. Userspace can unset it with
fnctl(F_SETFD) in the relatively rare case where they don't want
O_CLOEXEC. Alternatively, we could just bite the bullet and make
AT_NO_CLOEXEC a thing...

But yes, new syscalls *absolutely* need to take some kind of flag
argument. I'd hoped we finally learned our lesson on that one...

--=20
Aleksa Sarai
https://www.cyphar.com/

--o3fvuy4phjbklnx7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQS2TklVsp+j1GPyqQYol/rSt+lEbwUCac3Z3xsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMiwyLDIACgkQKJf60rfpRG8N0gD/WJsvCCKORuiEQhk4zFP7
tBYNwHeV6BT/7bD+Jb52nxkA+wSQXbre6aJO6Pc2aZ8UZ63KKnV5jrW7ZCjzd1rW
q5wG
=Sn0T
-----END PGP SIGNATURE-----

--o3fvuy4phjbklnx7--


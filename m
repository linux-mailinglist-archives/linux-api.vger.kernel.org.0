Return-Path: <linux-api+bounces-6074-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QExyC+BZ12lqMwgAu9opvQ
	(envelope-from <linux-api+bounces-6074-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Thu, 09 Apr 2026 09:48:48 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 870F83C73EE
	for <lists+linux-api@lfdr.de>; Thu, 09 Apr 2026 09:48:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 289B2300DE06
	for <lists+linux-api@lfdr.de>; Thu,  9 Apr 2026 07:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBCB93815D4;
	Thu,  9 Apr 2026 07:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="MF+cdMgq"
X-Original-To: linux-api@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB1D35E949;
	Thu,  9 Apr 2026 07:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775720765; cv=none; b=VCGsUl8SsgAPsEqm1MwqrqTYQb7g0hoh3yBcFdoQLwnXj7+DW2LgQxL/GRyu6nDmPJmZnQ3YIZ+08+JZYx5vct2OYwSCPuNusZ9kO4IRBrIJhLBTeFxhIlI9l0FdVTjF+0ODrKhnmT0mhDYcHDOdbjK7pG0Xclg67Z8ezoI5GU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775720765; c=relaxed/simple;
	bh=oLAsdPlPpEfpJ80R8qSFEbRgF25HbvAv4mAxIfdsv8E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cbnzyDnkHgw/08IQuGSFBz5U7+GOUw0hXsTXK4AeBvunfxItQE5jS9jGgl/ptN/IiBOYdUPef6Vbkt/BeJB7zc409E3jod50tqmsAs02jjO8Z5dT6W3QOG9IPnuELw44WLaAy6v/NsEkyBvIUpzg8Hn2BjuHHPR4dn39RUi7clk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=MF+cdMgq; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4frsS63RH3z9sWq;
	Thu,  9 Apr 2026 09:45:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1775720758;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oLAsdPlPpEfpJ80R8qSFEbRgF25HbvAv4mAxIfdsv8E=;
	b=MF+cdMgqxrR1PK8iEAN5cRZgXkF6AQ9KbgM3U24NDbeYOHTf7ddArdVqsyr7S7ubd9Y7q6
	aXVqrNhnlnGpbgNZ27+hdanFg9PUvqp9i8m2wMm9n5cf8oAiVx8/ycG5gLU2Cwgd5honDh
	jWcubSsiDDUwOzYPQi4gNj74VeSx2j6gh9DVndirTpdDv8vxnQZKnqAUAjPoMEheSp/Zxu
	tzESsJzV9rtghd57uzoUHMnTJNoLX2it6E2jBOVD/gfcGgLV/m3mVEzEFYa6tByYGHgq+l
	DrBjRf6bqc5stNpy9eTfdzxWnA2GWR2iFVX67XNlyF2ckbYfjwCBLnb2E2KHDA==
Date: Thu, 9 Apr 2026 17:45:26 +1000
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
Message-ID: <2026-04-09-chic-creative-coworker-wharf-TUf4Z1@cyphar.com>
References: <20260331172011.3512876-1-jkoolstra@xs4all.nl>
 <20260331172011.3512876-2-jkoolstra@xs4all.nl>
 <pbobkjhtuli53o3z34ajyxztaosmztwlygxfxhhjq5ajt47inc@ngtoge3ucdm5>
 <2026-04-02-aged-convex-snowbird-foxes-Ym20JZ@cyphar.com>
 <CAGudoHH7z8CwAXMxAxTbjfovRBpne5f19Tz0okMh7_6G9NfQ-Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ysmvgwg663dlrjno"
Content-Disposition: inline
In-Reply-To: <CAGudoHH7z8CwAXMxAxTbjfovRBpne5f19Tz0okMh7_6G9NfQ-Q@mail.gmail.com>
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
	TAGGED_FROM(0.00)[bounces-6074-lists,linux-api=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[33];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FREEMAIL_CC(0.00)[xs4all.nl,kernel.org,redhat.com,alien8.de,linux.intel.com,zeniv.linux.org.uk,oracle.com,arndb.de,linuxfoundation.org,zytor.com,suse.cz,gmail.com,infradead.org,efficios.com,linutronix.de,vger.kernel.org];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,cyphar.com:dkim,cyphar.com:mid,cyphar.com:email,cyphar.com:url]
X-Rspamd-Queue-Id: 870F83C73EE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--ysmvgwg663dlrjno
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [RFC PATCH 1/2] vfs: syscalls: add mkdirat_fd()
MIME-Version: 1.0

On 2026-04-07, Mateusz Guzik <mjguzik@gmail.com> wrote:
> On Thu, Apr 2, 2026 at 4:52=E2=80=AFAM Aleksa Sarai <cyphar@cyphar.com> w=
rote:
> >
> > On 2026-04-01, Mateusz Guzik <mjguzik@gmail.com> wrote:
> > > Trying to handle this in open() is a no-go. openat2 is rather
> > > problematic.
> >
> > I'm interested in what makes you say that. It would be very nice to be =
able
> > to do mkdir + RESOLVE_IN_ROOT and get an fd back all in one syscall. :D
> >
>=20
> Not handling this in either of open or openat2 does not preclude mkdir
> + RESOLVE_IN_ROOT + getting a fd in one go from existing.

Well, that would also require passing RESOLVE_* flags to mkdirat2(2)
which kind of begs the question why not just integrate it into
openat2(2) -- otherwise there will always be more features available to
O_CREAT than mkdirat2(2) which seems unfortunate.

> Creating a directory was always a different syscall than creating a
> file. I don't see any benefit to squeezing it into open. I do see a
> downside because of an extra branchfest to differentiate the cases.

Ah, so it's just an issue of taste, not a technical problem (as the mail
I replied to made it sound)?

> > > The routine would have to start with validating the passed O_ flags, =
for
> > > now only allowing O_CLOEXEC and EINVAL-ing otherwise.
> >
> > Please do not use O_* flags! O_CLOEXEC takes up 3 flag bits on different
> > architectures which makes adding new flags a nightmare.
> >
>=20
> With my proposal there are no new flags added so I don't think that's rel=
evant.

I'm confused, was "the new routine would have to start with validating
the passed O_ flags" talking about a hypothetical API you oppose? It
read like a suggestion on my first pass-through, hence the reply.

If you're saying that your proposal doesn't add any new O_* (or
MKDIRAT_*) flags that really isn't the issue -- any syscall that takes a
flag argument will grow new flags eventually and using the literal value
of O_CLOEXEC for some other syscall's flags just leads to burning three
flag bits needlessly.

This is arguably the most painful thing about open_tree(2)'s flags --
most other syscalls define their own flag that is equivalent to
O_CLOEXEC but not literally equal to it (this is even recommended in
Documentation/process/adding-syscalls.rst!).

> > I think this should take AT_* flags and (like most newer syscalls)
> > O_CLOEXEC should be automatically set. Userspace can unset it with
> > fnctl(F_SETFD) in the relatively rare case where they don't want
> > O_CLOEXEC. Alternatively, we could just bite the bullet and make
> > AT_NO_CLOEXEC a thing...
> >
>=20
> I would say that's a pretty weird discrepancy vs what normally happens
> with other syscalls, but perhaps it would be fine.

Quite a few of the newer uAPIs do this -- all of the pidfd APIs do it,
as well as newer ioctls that return fds (like the NS_GET_* ioctls for
nsfs).

Clearing O_CLOEXEC safely is trivial but safely setting it is not really
possible in multi-threaded programs (see "man 2 openat"), so it makes
more sense for newer APIs to just default to O_CLOEXEC and userspace can
unset it (and that is what newer APIs already do).

We should probably update Documentation/process/adding-syscalls.rst to
mention this...

--=20
Aleksa Sarai
https://www.cyphar.com/

--ysmvgwg663dlrjno
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQS2TklVsp+j1GPyqQYol/rSt+lEbwUCaddZFhsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMiwyLDIACgkQKJf60rfpRG+2igD/QwWbRDT79+zw0U60bypI
YXwNBLVfChskScmAh2h29KoA/0pakhamlU7+JdqG90l2cHnQXZllKMVFS64unuHR
y7wB
=/i4S
-----END PGP SIGNATURE-----

--ysmvgwg663dlrjno--


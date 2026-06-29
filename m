Return-Path: <linux-api+bounces-6729-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id H4GfMGHdQmqtFgoAu9opvQ
	(envelope-from <linux-api+bounces-6729-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Mon, 29 Jun 2026 23:02:25 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BF1206DEC46
	for <lists+linux-api@lfdr.de>; Mon, 29 Jun 2026 23:02:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=hb6e5lSg;
	spf=pass (mail.lfdr.de: domain of "linux-api+bounces-6729-lists+linux-api=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-api+bounces-6729-lists+linux-api=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E43323001FAF
	for <lists+linux-api@lfdr.de>; Mon, 29 Jun 2026 21:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CABF28314C;
	Mon, 29 Jun 2026 21:02:19 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71D3017A30A;
	Mon, 29 Jun 2026 21:02:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782766939; cv=none; b=qPxtoG5qmZzwqI3VoZiEiG2xoz1dDxFluwp0EjRQglm6WThS2iKSWic7wnYkEkgzFCFJEN7V3zc7+xtUltZiguYEiknx+RFMf8mwasGfzG02fRGNFLCasF8EHkpSH9W114v2gzeyzh+VB2yPnVSlelcgHkv882r72NlpIbIcPiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782766939; c=relaxed/simple;
	bh=5SS4tnsa4eUhnVbPLRY6K/9gXqlp6rmoe0u7RabBj60=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TkmLeh2kBB02tyU+7F+FQplKUai6h4Gs92FGz/feMQyB5YhXhpTFKvCIjnoIdLuoQ4mgm7goj7qT7K6SN/Pg9+MPesutsAfSv6rtQxSXQO9eJzYAerMQIxc0fPXBYF1a9QjKfTbLLHKr/eCkgt9z1Hi/9TqHje+W6M5qsAWkEPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hb6e5lSg; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84B8B1F000E9;
	Mon, 29 Jun 2026 21:02:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782766938;
	bh=6W+jXHIwiP8nkHo2RHnpI8C4eDiEaXDtp69grtYWwTs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hb6e5lSgj2Gqz8i1+ElNL1AyRJ4TMHQfbHjtEKiTyScwsAtKfukexH4NaQQH1IUjk
	 8yWpNdVQ9rOALSBxl/fGKCnaN3UgbqPapkBXCmqk6cDZZFmgI512Dw7gwqYoC3YrqD
	 QkQCa8BJeSAW2JQSoFV14uNmizuxKadXKrow35A4f2+AO2U/C1gTyKroMc/rEtIjFC
	 bfzfh8rgqZBiGSWd/h0j/NZAVQYXl0G/y4v0vo/JdxlewzwMbVob3n3RZbdsI1dZtC
	 atYAsfvtQACr1rle9CP3If54vjeL0MmDwTJNgd3+/UWbcZD2IZ4+jcEQWjGX48IcD8
	 TrvMlEVw3lnzQ==
Date: Mon, 29 Jun 2026 23:02:13 +0200
From: Alejandro Colomar <alx@kernel.org>
To: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Cc: Florian Weimer <fweimer@redhat.com>, linux-man@vger.kernel.org, 
	brauner@kernel.org, jlayton@kernel.org, libc-alpha@sourceware.org, 
	linux-api@vger.kernel.org
Subject: Re: [PATCH v2 1/2] man/man3/errno.3: Document EFTYPE error code
Message-ID: <akLcqAykbOXmDJrg@devuan>
References: <20260426111707.36541-1-dorjoychy111@gmail.com>
 <20260426111707.36541-2-dorjoychy111@gmail.com>
 <ae4K_5f1g3zgSNkC@devuan>
 <lhu5x5c4rpl.fsf@oldenburg.str.redhat.com>
 <ae9gDtEo6OxHTYBt@devuan>
 <lhuv7dcy1j9.fsf@oldenburg.str.redhat.com>
 <ae9lMz0SRR-sn1Uz@devuan>
 <CAFfO_h7V4gX6NbQvPtTF=XeH44j4O1oxWcArE+fzKM9FTmDKRg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pjhiwfohnkdb7ogf"
Content-Disposition: inline
In-Reply-To: <CAFfO_h7V4gX6NbQvPtTF=XeH44j4O1oxWcArE+fzKM9FTmDKRg@mail.gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.76 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS(0.00)[m:dorjoychy111@gmail.com,m:fweimer@redhat.com,m:linux-man@vger.kernel.org,m:brauner@kernel.org,m:jlayton@kernel.org,m:libc-alpha@sourceware.org,m:linux-api@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[alx@kernel.org,linux-api@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-6729-lists,linux-api=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alx@kernel.org,linux-api@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[linux-api];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,alejandro-colomar.es:url,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BF1206DEC46


--pjhiwfohnkdb7ogf
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Cc: Florian Weimer <fweimer@redhat.com>, linux-man@vger.kernel.org, 
	brauner@kernel.org, jlayton@kernel.org, libc-alpha@sourceware.org, 
	linux-api@vger.kernel.org
Subject: Re: [PATCH v2 1/2] man/man3/errno.3: Document EFTYPE error code
Message-ID: <akLcqAykbOXmDJrg@devuan>
References: <20260426111707.36541-1-dorjoychy111@gmail.com>
 <20260426111707.36541-2-dorjoychy111@gmail.com>
 <ae4K_5f1g3zgSNkC@devuan>
 <lhu5x5c4rpl.fsf@oldenburg.str.redhat.com>
 <ae9gDtEo6OxHTYBt@devuan>
 <lhuv7dcy1j9.fsf@oldenburg.str.redhat.com>
 <ae9lMz0SRR-sn1Uz@devuan>
 <CAFfO_h7V4gX6NbQvPtTF=XeH44j4O1oxWcArE+fzKM9FTmDKRg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFfO_h7V4gX6NbQvPtTF=XeH44j4O1oxWcArE+fzKM9FTmDKRg@mail.gmail.com>

Hi Dorjoy,

On 2026-06-29T22:15:45+0600, Dorjoy Chowdhury wrote:
> Hi,
>=20
> The OPENAT2_REGULAR and EFTYPE changes are in the 7.2-rc1 now I
> believe. I am not sure if it's the right time to merge the man-page
> changes now.

Yes, it is.

> I also don't know the whole flow so I'm asking.

If it's in an -rc, and you believe there won't be significant changes
before release, we can merge the documentation already.  If there's any
last-minute change before the actual 7.2 release, just send some patch
fixing the documentation.

Please keep all the CCs when sending the patches, and send in reply to
the first message in this thread, so that it's easier to correlate them.
Please also include CC tags in the trailer of the commit message.

> Do both
> of these need to be added to glibc manually or do these get pulled in
> from the uapi headers of linux into glibc automatically?

I don't know about this; someone from glibc will have to comment.


Have a lovely night!
Alex

>=20
> Regards,
> Dorjoy
>=20
> On Mon, Apr 27, 2026 at 7:33=E2=80=AFPM Alejandro Colomar <alx@kernel.org=
> wrote:
> >
> > Hi Florian,
> >
> > On 2026-04-27T15:29:30+0200, Florian Weimer wrote:
> > > * Alejandro Colomar:
> > >
> > > > Hi Florian,
> > > >
> > > > On 2026-04-27T12:34:30+0200, Florian Weimer wrote:
> > > >> * Alejandro Colomar:
> > > >>
> > > >> > [CC +=3D libc-alpha]
> > > >> >
> > > >> > Hi Dorjoy,
> > > >> >
> > > >> > On 2026-04-26T17:14:25+0600, Dorjoy Chowdhury wrote:
> > > >> >> Signed-off-by: Dorjoy Chowdhury <dorjoychy111@gmail.com>
> > > >> >
> > > >> > Thanks!
> > > >> >
> > > >> >  Reviewed-by: Alejandro Colomar <alx@kernel.org>
> > > >> >
> > > >> > I will wait until glibc adds this error code to their <errno.h> =
before
> > > >> > applying the patch.  This means either you should write and send=
 a patch
> > > >> > to glibc (if so, please CC me), or you should ask them to add it
> > > >> > themselves (if you're not comfortable writing glibc code).
> > > >>
> > > >> I'm not sure where this is coming from.
> > > >
> > > > Here's a link to the thread:
> > > > <https://lore.kernel.org/linux-man/20260426111707.36541-1-dorjoychy=
111@gmail.com/T/>
> > > >
> > > >> POSIX says EFTYPE was rejected
> > > >> in favor of ENOTTY.
> > > >
> > > > Could you please share a link to that?
> > > >
> > > > Anyway, I guess ENOTTY would be inappropriate in this case.  Althou=
gh
> > > > maybe a better error code could be devised; I don't know.  This is =
why
> > > > I wanted glibc involved in this discussion before this arrives to a
> > > > Linux release.  Thanks for the quick feedback!
> > >
> > > It's in the Rationale for System Interfaces:
> > >
> > > =E2=80=9C
> > > [EFTYPE]
> > >     This error code was proposed in earlier proposals as "Inappropria=
te
> > >     operation for file type", meaning that the operation requested is
> > >     not appropriate for the file specified in the function call. This
> > >     code was proposed, although the same idea was covered by [ENOTTY],
> > >     because the connotations of the name would be misleading. It was
> > >     pointed out that the fcntl() function uses the error code [EINVAL]
> > >     for this notion, and hence all instances of [EFTYPE] were changed=
 to
> > >     this code.
> > > =E2=80=9D
> > >
> > > I replied on linux-fsdevel, too.
> >
> > Thanks!
> >
> > >
> > > (It would be nice to submit patches introducing new error codes to
> > > linux-api with a subject mentioning the error code.)
> >
> > Thanks!  I'll remember this advice for when receiving patches that add
> > error codes.
> >
> > >
> > > Thanks,
> > > Florian
> >
> > Cheers,
> > Alex
> >
> > --
> > <https://www.alejandro-colomar.es>
>=20

--=20
<https://www.alejandro-colomar.es>

--pjhiwfohnkdb7ogf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmpC3VUACgkQ64mZXMKQ
wqnWfRAAuoniZIX9zqORr7vzlcwVIBl4e/8eJXU7WXV3JKgO5Bh58ZJWwKa+gdvj
5+5IJnr2jJk1vmi8P1WrOFGJCOBWExk2KOCk1M/iF2FA0X2Hqm51Bu7ImgGAcl0K
ilwDPDXpazIk7hcwXaJiDOAgFwpTPJfRSS/e+LcnOoSr9CU7eKbhRoSHeD2KujJf
2fFvWPGJEmgWmkUKraT58PADMhZJdKOyysrKm5fYDWwJqECzu0qFOOeBuZTyD5e8
WucAOht1lZ0RMTupcKUWvNg7LkAIq+WMKuLvJrh5FW4uHXPl9pI9iuZ5zJWzawSX
CoxXEWH6lN+5r8auX44kPRa8VsJDaif1zd0KQcEqF+PE/yHq3ye990IAOBdtSWQX
/RpWqB7+V1vVEjByRBlRGoTm3rAkDdUx9QDIVtzMblxd2ykBnr4a3UnfFGwqfHbn
DFOzWsStsZ9RAcAoRq8WW3Pua+fQvwA3xlJXGWD+9Vtbfva6C2hYfySD+ssiu/Bh
E65A3gU3M61JT3UGKIgRTr6mgRN5mRUj8zToJxp3q1GFiVafh43H6n4T5ZWeUWrZ
q/0qVWoDSqkiij0tLY6RgmdyplraiPycDp9u9phxXdDKJ/moesREYTLRveihUpuq
J8v8oHliL4J+9TJVToQselv5TQqfK432hIxAMsKUfSvMCTRja7o=
=1ehd
-----END PGP SIGNATURE-----

--pjhiwfohnkdb7ogf--


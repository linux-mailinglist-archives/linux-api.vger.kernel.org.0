Return-Path: <linux-api+bounces-6197-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6NFlIe5g72mHAwEAu9opvQ
	(envelope-from <linux-api+bounces-6197-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Mon, 27 Apr 2026 15:13:18 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8267947335C
	for <lists+linux-api@lfdr.de>; Mon, 27 Apr 2026 15:13:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3B1333000BB6
	for <lists+linux-api@lfdr.de>; Mon, 27 Apr 2026 13:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B8803B9D8D;
	Mon, 27 Apr 2026 13:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E0RC/iat"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB807309DDF;
	Mon, 27 Apr 2026 13:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777295591; cv=none; b=m3050tcuzket73G3xyFb01I6fl5pSRGown11Du8e4ubnq4aJwrxqKD7b6v65AGYqXIJRf/dG7oWY8xWjf5ZmKXWsmixk1gpYHTidO4MNpXlknWPfyIJVgtuBZPL28srR5AGGM4++RAN2nRyWM+C9ZaMSNaRUM3qrREcfrqXENdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777295591; c=relaxed/simple;
	bh=VnZbf756xo77VmTDIzS+6z5zrDMk4LG/4G3VT9SmYKM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NbBxeELlTR9dAGIRMOZhzyzMmfHTNJqfvCc1y67rjOhlPMKZwlo4bwLkI7D+pTuD+jKXwTQWhzausnX+gVoxQjghGXvRxVJkd575aAldzooLwYUS3ayAghRd/0OD4eKuM+ukKAKySGByADC2fKBPMp+9ZPZ9jo57Bf6KxUOgZk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E0RC/iat; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16745C19425;
	Mon, 27 Apr 2026 13:13:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777295591;
	bh=VnZbf756xo77VmTDIzS+6z5zrDMk4LG/4G3VT9SmYKM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E0RC/iatnDU1l4+4woh6Loca0jmYrsQBcag+AaVgDtW0sHI/3mmDmppNqA8OwZjuo
	 ji3kSY8VmFqmPe+xTBtKg1ugaMPucJUI2OUAmvH4dKe6YJJMTQKCdP5rAL76QRvHPT
	 vGhMtQXkcOJxc2WWEYuXtfwpEtf9K9fJe7SRLQXIqyatFDaos9JLXc5lJoDH+XyVmf
	 RTvOrtvALRHuyKGFdWcEGJWxslNi1kwbUWlGxxX4QXj/vhFPC09Za18fReqA+oZuWF
	 148vRWongz0YrZj2zbYzmwdCbEhTHv2Rg8xP7Ae2TMlRvFfZHzTtTXL00TSNSdtkFG
	 t3GDpqEzpcL+g==
Date: Mon, 27 Apr 2026 15:13:07 +0200
From: Alejandro Colomar <alx@kernel.org>
To: Florian Weimer <fweimer@redhat.com>
Cc: Dorjoy Chowdhury <dorjoychy111@gmail.com>, linux-man@vger.kernel.org, 
	brauner@kernel.org, jlayton@kernel.org, libc-alpha@sourceware.org, 
	linux-api@vger.kernel.org
Subject: Re: [PATCH v2 1/2] man/man3/errno.3: Document EFTYPE error code
Message-ID: <ae9gDtEo6OxHTYBt@devuan>
References: <20260426111707.36541-1-dorjoychy111@gmail.com>
 <20260426111707.36541-2-dorjoychy111@gmail.com>
 <ae4K_5f1g3zgSNkC@devuan>
 <lhu5x5c4rpl.fsf@oldenburg.str.redhat.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ccuudzirrgdyc5ml"
Content-Disposition: inline
In-Reply-To: <lhu5x5c4rpl.fsf@oldenburg.str.redhat.com>
X-Rspamd-Queue-Id: 8267947335C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-3.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,kernel.org,sourceware.org];
	TAGGED_FROM(0.00)[bounces-6197-lists,linux-api=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alx@kernel.org,linux-api@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-api];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,alejandro-colomar.es:url]


--ccuudzirrgdyc5ml
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: Florian Weimer <fweimer@redhat.com>
Cc: Dorjoy Chowdhury <dorjoychy111@gmail.com>, linux-man@vger.kernel.org, 
	brauner@kernel.org, jlayton@kernel.org, libc-alpha@sourceware.org, 
	linux-api@vger.kernel.org
Subject: Re: [PATCH v2 1/2] man/man3/errno.3: Document EFTYPE error code
Message-ID: <ae9gDtEo6OxHTYBt@devuan>
References: <20260426111707.36541-1-dorjoychy111@gmail.com>
 <20260426111707.36541-2-dorjoychy111@gmail.com>
 <ae4K_5f1g3zgSNkC@devuan>
 <lhu5x5c4rpl.fsf@oldenburg.str.redhat.com>
MIME-Version: 1.0
In-Reply-To: <lhu5x5c4rpl.fsf@oldenburg.str.redhat.com>

Hi Florian,

On 2026-04-27T12:34:30+0200, Florian Weimer wrote:
> * Alejandro Colomar:
>=20
> > [CC +=3D libc-alpha]
> >
> > Hi Dorjoy,
> >
> > On 2026-04-26T17:14:25+0600, Dorjoy Chowdhury wrote:
> >> Signed-off-by: Dorjoy Chowdhury <dorjoychy111@gmail.com>
> >
> > Thanks!
> >
> > 	Reviewed-by: Alejandro Colomar <alx@kernel.org>
> >
> > I will wait until glibc adds this error code to their <errno.h> before
> > applying the patch.  This means either you should write and send a patch
> > to glibc (if so, please CC me), or you should ask them to add it
> > themselves (if you're not comfortable writing glibc code).
>=20
> I'm not sure where this is coming from.

Here's a link to the thread:
<https://lore.kernel.org/linux-man/20260426111707.36541-1-dorjoychy111@gmai=
l.com/T/>

> POSIX says EFTYPE was rejected
> in favor of ENOTTY.

Could you please share a link to that?

Anyway, I guess ENOTTY would be inappropriate in this case.  Although
maybe a better error code could be devised; I don't know.  This is why
I wanted glibc involved in this discussion before this arrives to a
Linux release.  Thanks for the quick feedback!


> Thanks,
> Florian

Have a lovely day!
Alex

--=20
<https://www.alejandro-colomar.es>

--ccuudzirrgdyc5ml
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmnvYN0ACgkQ64mZXMKQ
wqmV+Q/7BHG+y+N8jaT/JToq7/TIvUc3oQ10BZjVf+7Fe6TExLKUHMEocQQgXIVx
r4ySoeIAty+ebWD1oJaYjiIEpGk2pJqvoweSWdZ9vD/bZTtnSc/LvjV8v/RGlmhL
dRpPMKGEoacD9AG73bOU7JRI4MOZKdbPDMUCHQKnijij9IkA3hsMpKbZizHmBa0P
EvUPLBZH/l0QHcpJxXZOHzujtah9BSQ0EiLXEqt8umwi2rgqllPh8ob/taeC0j8+
uNrY2c1pEigLlodB73x/6zFvrwmnTDthtfsWPKdLwceXkXRVBltiUlfqwwjIrSUN
3soKL/x1ar/Caxr2vHfWyjGsTjuoUw4S2sCgbsRNVTfhXP+jlOTLRN2PLa5NsMGr
sK2bi8DuPIrxLh/b1ORay55mHrI2uHi6w/uUHM464lXM2qO+gww3Kk04GNLGICVS
ukBa78n5z85PnrK5+UdunHmn4r7GWyPmN2q+e6aqPhsso9rBxFqRXeBpGkyTCTFZ
tD8UI92FlEx3KRcVlV2j85/pRJeQ9dOeb3MLsQoPg2Lj14Om2sFFrBiMr/gKQ44f
+A6j96yLaRb+PgXIB1Btw3KU1u9FrzMocN8gUlh5Mn4bcXLr2M4uOPHuv4oHuken
imragSbSbz/RuB1T2hOjuucxOyEIbhPET4zKYizsvuNtE/rVNTM=
=/gEE
-----END PGP SIGNATURE-----

--ccuudzirrgdyc5ml--


Return-Path: <linux-api+bounces-1098-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 059DB87123D
	for <lists+linux-api@lfdr.de>; Tue,  5 Mar 2024 02:11:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9C1DB21D88
	for <lists+linux-api@lfdr.de>; Tue,  5 Mar 2024 01:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EB1C111A2;
	Tue,  5 Mar 2024 01:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dYPaASFa"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627451079D;
	Tue,  5 Mar 2024 01:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709601103; cv=none; b=oixFEWTF2qOhdnt8sNPMQcwC/okxKnM6Ywy0aesx52gxiMci0lgA9WUVb9YtTHmMcQCURB/pf4DYYjAWAoxwcCFz9IlKcUr3am0H3xtKuHtV8ebM6PPIlhlBMkYpfH5+rjfI3eag92eQFaHR/9q8pwHFdy6AESb9sSr/zO5zk30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709601103; c=relaxed/simple;
	bh=h1F3RUzz6Q+R/eVw4l/BbIrKbCiiZYUrrfVbQx8n4Ho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tECzMyWxnXE3VwAcSufFrsbiq5b6ymNkZ75BoD+Vt+YwiqUXJTHvpCKupqAV8BMnsjwa/vbn+Rg9KKumMRlL5m9qzuWmObkIldemyFijOAAaIp6iwvmD7woX8Scq0RPP+1VU5Pix5xu1x+N27R+RNHTYlfD/L8lYONh/o1WUo4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dYPaASFa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E3D3C433C7;
	Tue,  5 Mar 2024 01:11:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709601103;
	bh=h1F3RUzz6Q+R/eVw4l/BbIrKbCiiZYUrrfVbQx8n4Ho=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dYPaASFaEuR/utdCTUeRciHOalgT6P3f9mapgtbEAvH870csBKR6jIq8DPYt2aPi1
	 6MOzikL2MYCQYhfpTgOCwMnZPdtjLv/e0MfpDBv0+GC3FKbsF5Zuo+qowbJt6ku5UP
	 6CXdW55oUT1Vwy7lLnJBmdISlORn3gmEhO4YKi6glETGTkjE1JZ3rVsiXCQ45wu9Ev
	 ZqPkwiLY/NTlPfSeqPD8zGR7neXlNj2LQ93T3wHPoiim8uEZ9NVT8aNnrLo2mEVJZ7
	 +WdBTVOglkFkTA9XnHSbbzxXykZyUvUWnEMpkpzqVuO/mAprXnQG8/6aqmVBD7TIm8
	 w/0bK81/9KaQA==
Date: Tue, 5 Mar 2024 02:11:39 +0100
From: Alejandro Colomar <alx@kernel.org>
To: enh <enh@google.com>
Cc: Bruno Haible <bruno@clisp.org>, Stefan Puiu <stefan.puiu@gmail.com>,
	linux-man@vger.kernel.org,
	GNU C Library <libc-alpha@sourceware.org>,
	linux-api@vger.kernel.org
Subject: Re: [PATCH 2/2] clock_nanosleep.2, nanosleep.2: Use 'duration'
 rather than 'request'
Message-ID: <ZeZxSydsfskaQ5Vw@debian>
References: <ZUIlirG-ypudgpbK@debian>
 <20240303121454.16994-3-alx@kernel.org>
 <5882437.otsE0voPBg@nimes>
 <ZeRzS6mENO8kOh1W@debian>
 <CAJgzZor8TTSysM=TiTXQdVtHMZPQWu5YOhPmb8PAevdVd-c31Q@mail.gmail.com>
 <ZeZohz1sLcIN6kxA@debian>
 <CAJgzZoog1qS4BOYaKDnLsA3RzL-61r=33tP-XK2xvOwa008jJw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="btDaYgjJzw+ZexaW"
Content-Disposition: inline
In-Reply-To: <CAJgzZoog1qS4BOYaKDnLsA3RzL-61r=33tP-XK2xvOwa008jJw@mail.gmail.com>


--btDaYgjJzw+ZexaW
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Tue, 5 Mar 2024 02:11:39 +0100
From: Alejandro Colomar <alx@kernel.org>
To: enh <enh@google.com>
Cc: Bruno Haible <bruno@clisp.org>, Stefan Puiu <stefan.puiu@gmail.com>,
	linux-man@vger.kernel.org,
	GNU C Library <libc-alpha@sourceware.org>,
	linux-api@vger.kernel.org
Subject: Re: [PATCH 2/2] clock_nanosleep.2, nanosleep.2: Use 'duration'
 rather than 'request'

On Mon, Mar 04, 2024 at 04:56:13PM -0800, enh wrote:
> > > int clock_nanosleep(clockid_t __clock, int __flags, const struct
> > > timespec* _Nonnull __time, struct timespec* _Nullable __remainder);
> >
> > Hmmmm, that's the best name, meaningfully, I think.  But I've been
> > trying to avoid it.  I don't like using names of standard functions in
> > identifiers; it might confuse.  As an alternative, I thought of 't'.
> > What do you think?
>=20
> as you can see, i've taken the "the leading `__` means we get to
> trample whatever we like" approach :-)
>=20
> (we build bionic with hidden visibility and an explicit list of
> symbols for the linker to export, so we'd have to be trying quite hard
> to trip over ourselves.)

Yeah, I was worried about the manual page  :)


--=20
<https://www.alejandro-colomar.es/>
Looking for a remote C programming job at the moment.

--btDaYgjJzw+ZexaW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmXmcUsACgkQnowa+77/
2zILahAAnzBcE9HjnQx/fSnQhjQHn4GylTV9rWtlyEQsIevZOLM0zFUZ7ljsRG7e
+r4SA03hkhr9nYDhV7Dc4dasziDd211J0lsrGCiUb3NUaafie/pcxVCM7+fp1Fs6
iC+SoFNHdfMSj3DqLESLecjL0PcTfViOFm0/f1042Vsuv0my5kjBiEbx6boxJ3e2
xvFndeNH9hh5XAi5WB70WtpY0PEAFc5HuHu6wfxU8uuoFDTsh0gVqGSdkPFqRIRA
Hzn5XBohLRkI/wAAMgZhQQ79vPNj4zhsgPqE2kosNMcJvLg4Qvf+5uWIn/Ic+JWa
sIO7JQ89v44FwBFXdBy5FmpkmmJsL8qPVbBjwGbXRqmE2wmcturdSP7ThmLY+E1j
gZV2HvNMfAMa/yPc77C5PpBY2vQsy7AdA6ZFaO2vDl/ezkn9U/V2IIfctrNQar8X
NQFvpSN9tMtcg984AWnRqBawoYgptPJTg1AHQVCg7xK8lh54RzwL1QFbUnoS7pCj
XxXaFIY6xSJbs0zyFPQWrUZ4Ct1RWQWpGq/LtzPT8Wf+BO4gutnf8Rg2OBnM4bNS
v+ge6WbfnSxy5Y+TkwUh6lYW1v61KX1Y4Ik9K1yjZmF1rYyPTdh2EHY5cP/4L7tb
d5GMgRzqCjmlstFeYQ/1a6XOa59SvMpq995a1FrEzzaZelBASkU=
=Xw5p
-----END PGP SIGNATURE-----

--btDaYgjJzw+ZexaW--


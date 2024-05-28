Return-Path: <linux-api+bounces-1622-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E66488D176B
	for <lists+linux-api@lfdr.de>; Tue, 28 May 2024 11:42:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2312E1C213B9
	for <lists+linux-api@lfdr.de>; Tue, 28 May 2024 09:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E648216A395;
	Tue, 28 May 2024 09:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TuyDgbQ/"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE23B169AC9;
	Tue, 28 May 2024 09:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716889361; cv=none; b=QznN6X6rKdilw0g0aEer+Z7arsL5wOUcQkH6kA7WgyhF3Q5TsKkMdMuu4zKn6Go+jtgB2rkxORWQ5ShK3MgqERNAc30lFOXHuRn1vMPoiM4VsseAczd/teEyJRcVfMpBsd3w42x6P8PLYKhA0m8qraZxOykux3fABGXTpOQq+S8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716889361; c=relaxed/simple;
	bh=JA1l9l3ejZxlBcL62S96sR5g2IC/Bf1Ml51oLxgh9O0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T4OAd47BhsFT+/vgBs2gKL6yap6Yf0xmPqS2Qdty0Xqr3paK026YiRF/XPsPdjB1PFrQDyvltAtZQPJaRYfcknttREY3wQbv4Hyqz3qfveW5lG0jH5XNNiYNWDyYFbx6iXDLZoS7kKChJ8fWE7E+V8jds4Mo1S6gzvKdY6yPn7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TuyDgbQ/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C030AC3277B;
	Tue, 28 May 2024 09:42:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716889361;
	bh=JA1l9l3ejZxlBcL62S96sR5g2IC/Bf1Ml51oLxgh9O0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TuyDgbQ/NGet43bNq4lHu+R5I0Rk3dXqVaSMfq1G1tMaovjryXVIlTNhFUi+aysy3
	 d+5g/N2mf2XGiKrdnBHbmBXAERxm6bQCC9+usy40l20tzao/WsygFep6C7EAXR2VnM
	 OTC70h5wgamlQJpCb5IJ43G0i/PpgD/vmLBf4esarTP2MMMtWQI6kbK+psW4l2z4Lg
	 L2IcbGHMPy83eiWBZfGyG/lbw49BVppuN6TnysZlrZQprjgqHvDI1xHRkxmbCaMYP9
	 Nyftx9ZDcVfLv44nI8SEw9WxxqS7cmOkKGH6Axo6Hji+CUf1NV7lnU8gWE/aRDcsAr
	 Fs//sf1Yzg4Ew==
Date: Tue, 28 May 2024 11:42:38 +0200
From: Alejandro Colomar <alx@kernel.org>
To: libc-alpha@sourceware.org, linux-api@vger.kernel.org
Cc: linux-man@vger.kernel.org
Subject: Re: Correct way of calling prctl(2) (was: Sashimi of prctl(2))
Message-ID: <x6r3yc6l34g4k5g3tm6ywecdqux54xlpid7bp2fa7hvm43luc7@6fjgaxgm5uyj>
References: <eofw4itya3kwaznneoizgt3dspfa4h7ttrw6ehshfrksj3wmst@xwjxpi3iro6d>
 <ddbdyaiptesjalgfmztxideej67e3yaob7ucsmbf6qvriwxiif@dohhxrqgwhrf>
 <vuuanrtyoq7abctrlmfggqqc7vjw6v64ubbyeijvyngnw7xead@yehc5po76nzf>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="534pufxyep7x5oau"
Content-Disposition: inline
In-Reply-To: <vuuanrtyoq7abctrlmfggqqc7vjw6v64ubbyeijvyngnw7xead@yehc5po76nzf>


--534pufxyep7x5oau
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: libc-alpha@sourceware.org, linux-api@vger.kernel.org
Cc: linux-man@vger.kernel.org
Subject: Re: Correct way of calling prctl(2) (was: Sashimi of prctl(2))
References: <eofw4itya3kwaznneoizgt3dspfa4h7ttrw6ehshfrksj3wmst@xwjxpi3iro6d>
 <ddbdyaiptesjalgfmztxideej67e3yaob7ucsmbf6qvriwxiif@dohhxrqgwhrf>
 <vuuanrtyoq7abctrlmfggqqc7vjw6v64ubbyeijvyngnw7xead@yehc5po76nzf>
MIME-Version: 1.0
In-Reply-To: <vuuanrtyoq7abctrlmfggqqc7vjw6v64ubbyeijvyngnw7xead@yehc5po76nzf>

[Adding linux-api@]

On Tue, May 28, 2024 at 11:24:13AM GMT, Alejandro Colomar wrote:
> [Adding libc-alpha@ for some doubts]
>=20
> Hi!
>=20
> On Sun, May 26, 2024 at 01:27:43PM GMT, Alejandro Colomar wrote:
> > On Sun, May 26, 2024 at 01:07:24PM GMT, Alejandro Colomar wrote:
> > > I'm considering making sashimi of prctl(2), similar to what I did
> > > recently to proc(5).  Another precedent is in ioctl(2).
>=20
> I'll call the pages with names such as PR_CAP_AMBIENT(2const) and
> PR_CAP_AMBIENT_RAISE(2const).
>=20
> While doing that, I changed the prototypes in the SYNOPSIS to things
> like
>=20
>      int prctl(PR_CAP_AMBIENT, unsigned long op, ...);
>=20
> and
>=20
>      int prctl(PR_CAP_AMBIENT, PR_CAP_AMBIENT_RAISE, unsigned long cap, 0=
, 0);
>=20
> Which makes me wonder.  glibc implements prctl(2) as a variadic
> function, so those 0s are actually of type (and more importantly of
> width) 'int'.  This means a user passing 0 is leaving some parameters
> uninitialized.
>=20
> From what I can see, glibc does no magic to set unspecified parameters
> to 0, so this means passing '0' results in Undefined Behavior.
>=20
> I guess I should document these as 0L in the SYNOPSIS.
>=20
>      int prctl(PR_CAP_AMBIENT, PR_CAP_AMBIENT_RAISE, unsigned long cap, 0=
L, 0L);
>=20
> All of the software I've seen out there using prctl(2) either pass 0 (as
> the manual page had been suggesting), such as in shadow:
> <https://github.com/shadow-maint/shadow/blob/71e28359d12491727b2e94c71d2e=
1e1682d45a02/lib/idmapping.c#L161>
>=20
> 	if (prctl(PR_SET_KEEPCAPS, 1, 0, 0, 0) < 0) {
>=20
> or don't pass anything at all (coreutils does this):
> <https://git.savannah.gnu.org/cgit/coreutils.git/tree/src/timeout.c#n449>
>=20
> 	if (prctl (PR_SET_DUMPABLE, 0) =3D=3D 0)
>=20
> Am I missing something or are all of those calls buggy?
>=20
> Some prctl(2) calls report EINVAL when the unused arguments are nonzero,
> while others simply ignore it, so maybe I can document the ones ignoring
> the unused arguments as shorter calls:
>=20
>      int prctl(PR_SET_DUMPABLE, unsigned long dumpable);
>=20
> And document the ones that report errors as using 0L:
>=20
>      int prctl(PR_CAP_AMBIENT, PR_CAP_AMBIENT_RAISE, unsigned long cap, 0=
, 0);
>=20
> (BTW, util-linux seems to have this one wrong:)
>=20
> <https://sources.debian.org/src/util-linux/2.40.1-2/lib/caputils.c/?hl=3D=
123#L123>
>=20
> 	&& prctl(PR_CAP_AMBIENT, PR_CAP_AMBIENT_RAISE, cap, 0, 0) < 0)

And another problem is the definition of PR_CAP_AMBIENT_RAISE (and
similar macros), which are defined as ints:

$ grepc PR_CAP_AMBIENT_RAISE /usr/include/
/usr/include/linux/prctl.h:# define PR_CAP_AMBIENT_RAISE		2

but they should be defined as unsigned longs.  (This is a Linux UAPI
problem.)

>=20
> What do you think about this?
>=20
> Have a lovely day!
> Alex

--=20
<https://www.alejandro-colomar.es/>

--534pufxyep7x5oau
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmZVpw4ACgkQnowa+77/
2zI1zw/+PFqF2Ylqvj8iYAOHdTjTc3e/0YC2ICGrtekf5odI+IQburZIUiPp5Z9z
kb37Oys+6cHbN3bbtlu+rI923OoGDJAEFEFmSzNqjNSmrO/OIhDAph2gs0OAMDBa
/oJ2LYmQtkB1iEboMRbS96Jd94B1vv4RWlRUZPOm0koENZ36Em/sk9BNM1iWDhvd
GqbYWycWbDL7a1F5isfy55uO7LNpHmnDTTTgD+7mQ/fNH5SHmsC/Cqb7rknBfefj
LMVBEyOAzcPI0hhMhZGog2nWsNzra3i+SBeDUSztXkjEeUfzWRwpzBwIvBhXppV6
fepN+bLv+u5Fnw9on2J7iVY4NJ4os3zpUU45e5lfiFPsR87sh8HCefL9Z77/XLK8
Z9hbZRv8d4f4iE8JVpDD92rauE3XJ1LhJQ+juaLldkAp6By9tp73OWamS6SQCYwc
hTITnkxv3Hob3mKOhwL27Hp7i3mABndE8wKX+p168WrCERfuZMlmfksBY93/6xwK
3bSvFMoSTz/hjeOhXVHK3S708ZqkMQ4MQPmD2P2KM0a+H6x5NqVCGdHT9IS7rnJO
8JnNUnT6rG8vb3gKJlMeYhJIPE4sLrdsklyb/jMTNjn12sKIhzrbnRFR5PFxGudZ
fKVSy4LVOyvHz6+WjVzDDuxQYlUcJPErYsvAV9GFJdWHGalGMjw=
=oFXL
-----END PGP SIGNATURE-----

--534pufxyep7x5oau--


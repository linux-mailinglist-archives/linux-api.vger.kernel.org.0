Return-Path: <linux-api+bounces-3208-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 19B2EA367C3
	for <lists+linux-api@lfdr.de>; Fri, 14 Feb 2025 22:49:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90EB17A5A51
	for <lists+linux-api@lfdr.de>; Fri, 14 Feb 2025 21:48:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A723B1C861E;
	Fri, 14 Feb 2025 21:49:24 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from rdmp.org (unknown [195.15.247.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 109DD6AAD;
	Fri, 14 Feb 2025 21:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.15.247.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739569764; cv=none; b=beb6XjA+KxbzD6U1OdK8LUssDYkPFXDMcT8tiJ/9p31z6E6S36/nflYqZr8i+CIcLf4hBsY1pGJDP+fy7PENqe2wlkmOm1J5LBBU6EsUtUVwRB7W211Zu36AvNyXKynMtgUyXVWFnajFO5kxc1VV3LxO4zUa05ZFkk9CrPfNK54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739569764; c=relaxed/simple;
	bh=QHGUexdWXPXSWTRIMc28+OFVuolzP0IFbBjSewYI37A=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=FD0hjKB/rZzpvc65l0rVp8NW/2ewP+0u7uwMNZNwgBhlOICLKv753kxZc6xhUVQ63dSBZ3Yjl6ub+58Xezu7wHTHO7GVsN6S/+7YB4cgfJUwJ8wr4Z4HStkBpNOPdT0FUs1vfQSr7fAe5mhYZ2J9mHzmviRNch2Bz4ICRDlqt9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rdmp.org; spf=pass smtp.mailfrom=rdmp.org; arc=none smtp.client-ip=195.15.247.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rdmp.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rdmp.org
Received: from [127.0.0.1] (helo=[IPv6:::1])
	by rdmp.org with esmtp (Exim 4.96.1)
	(envelope-from <no-reply@rdmp.org>)
	id 1tj3Yn-0000eq-0W;
	Fri, 14 Feb 2025 21:49:21 +0000
Message-ID: <d246034e111fa28a091dabb9ff34a8b322e03119.camel@rdmp.org>
Subject: How should userland app be notified when kernel comes out of
 suspend or hibernation?
From: Dale Mellor <no-reply@rdmp.org>
Reply-To: mcron-lsfnyl@rdmp.org
To: linux-kernel@vger.kernel.org
Cc: linux-api@vger.kernel.org
Date: Fri, 14 Feb 2025 21:49:16 +0000
Organization: DM Bespoke Computer Solutions Ltd
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-IV0km+MFPRDdnVzqMfVl"
User-Agent: Evolution 3.48.4 
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-IV0km+MFPRDdnVzqMfVl
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I am the originator of the GNU mcron app, which waits (using select)
for set amounts of time before executing some function on behalf of the
user.  But when the system comes out of sleep the timings are all wrong
and need to be re-evaluated.  But how does my application know when
this needs to happen?

I'm currently trying to use the ACPI netlink interface, which
conveniently gives me a socket I can add to the select call and wakes
me up when some power-changing event occurs.  However, there is not an
event specifically for notifying the coming out of sleep, and different
systems will have different hardware which reacts in this situation
(the netlink interface has a soft specification and requires
introspection to understand the data it delivers).

What is the 'official' way to do this?


--=-IV0km+MFPRDdnVzqMfVl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iF0EABEKAB0WIQTiPCHthk/086cRTN/KRx/VAWGKSQUCZ6+6XAAKCRDKRx/VAWGK
SXS6AJwNAmeL61cJ3jjNyLldGOzqZVpuVwCgglSPhK8sz5k5wASu7A29CcjHZFw=
=Iqs4
-----END PGP SIGNATURE-----

--=-IV0km+MFPRDdnVzqMfVl--


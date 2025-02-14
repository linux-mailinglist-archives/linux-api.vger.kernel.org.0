Return-Path: <linux-api+bounces-3207-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 05F6BA366F5
	for <lists+linux-api@lfdr.de>; Fri, 14 Feb 2025 21:36:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 805857A4615
	for <lists+linux-api@lfdr.de>; Fri, 14 Feb 2025 20:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C735E19F495;
	Fri, 14 Feb 2025 20:36:06 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from rdmp.org (unknown [195.15.247.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1725C1991B6
	for <linux-api@vger.kernel.org>; Fri, 14 Feb 2025 20:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.15.247.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739565366; cv=none; b=sUlh0VyJtY8CObm1VR03aaR0yvui6/BDNrI7b1lhRbneNH0NmCJH+YbpRJN4ZAj3UgOp+Y3w8cY5Qsi3xDIRcjEnI7Drh0cN8GX66orTKH5jltPgzL4ws7fbKG+MPAsXog6kGH/6xdvfIaHAhGoX2AyYe86Lpevl3ru50PAxw/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739565366; c=relaxed/simple;
	bh=XmQeO0tz1ROurhuN/TBixgDmjS650MGDLw5Wu98NkTo=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=uWw+t72xPnwkT/KafRNSXc1uJMVhlTzAyq188rqPiv3VU45vyAxfKhzr2Svw5QWxDEuC0xsMI2gRDpLhTLPpjkX3fq/FdG+gghqUFP0c6ng6bfmU0ByPeVSO5FUDuNQv52wpDiPvtnVizDRi3z1yii6pgStb1+adV4X2DIIAVgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rdmp.org; spf=pass smtp.mailfrom=rdmp.org; arc=none smtp.client-ip=195.15.247.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rdmp.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rdmp.org
Received: from [127.0.0.1] (helo=[IPv6:::1])
	by rdmp.org with esmtp (Exim 4.96.1)
	(envelope-from <no-reply@rdmp.org>)
	id 1tj24f-00012M-0c;
	Fri, 14 Feb 2025 20:14:09 +0000
Message-ID: <47978bcd9047bc39e6697f96e30a8424839157e8.camel@rdmp.org>
Subject: How should userland app be notified when kernel comes out of
 suspend or hibernation?
From: Dale Mellor <no-reply@rdmp.org>
Reply-To: mcron-lsfnyl@rdmp.org
To: lkml@vger.kernel.org
Cc: linux-api@vger.kernel.org
Date: Fri, 14 Feb 2025 20:14:04 +0000
Organization: DM Bespoke Computer Solutions Ltd
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-12L/OlblRp0vqeO/mL8K"
User-Agent: Evolution 3.48.4 
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-12L/OlblRp0vqeO/mL8K
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


--=-12L/OlblRp0vqeO/mL8K
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iF0EABEKAB0WIQTiPCHthk/086cRTN/KRx/VAWGKSQUCZ6+kDAAKCRDKRx/VAWGK
SeEpAJ9Xbj++nYhccZNkcKbXoKeWY4L3zgCaA70Zgo4lsrX2l4D0fJ5SVi/T4F0=
=DkoJ
-----END PGP SIGNATURE-----

--=-12L/OlblRp0vqeO/mL8K--


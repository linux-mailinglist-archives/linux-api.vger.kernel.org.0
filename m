Return-Path: <linux-api+bounces-1093-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E6CA86F4EF
	for <lists+linux-api@lfdr.de>; Sun,  3 Mar 2024 14:02:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE3A51F214F2
	for <lists+linux-api@lfdr.de>; Sun,  3 Mar 2024 13:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E507BE62;
	Sun,  3 Mar 2024 13:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bdNFqbmH"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36B89F9CD;
	Sun,  3 Mar 2024 13:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709470959; cv=none; b=q2dUjaY9IguiWVYTIckETTQjkv3qL1UVf6PcERHY4fB1Lp8p45pM5mG2Xvii9l1zSt8kQ+cKNKL/ot4vHqkCYcUKSDQqd/Z9lIOwiuGsTxjIxdbpgxPBQ5mPIlv2Y8I7GMOxIA+O2lCiVSFOG55UFhDPz2o/5sbs7TwxAwiwlMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709470959; c=relaxed/simple;
	bh=ygoEEpZ6azYEb5HHiu98itSFP/0JLF70trcyRvJrE5s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g+TNlU9eVlFV5mAGRBj/CBeKv33lzIW6dxtGR+hRPml9akY42qO7LVBwq1xug+YByW0fP4JNGhUan0ArBREvX6FYqKB4fZZS++Znn8RHV2FBMQsxWZz8jBY7TFUiwbIxlE7LiBJqVVuegXOrcS2ziJjVEk2HVJ2EUyxIGukoczY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bdNFqbmH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D011C433C7;
	Sun,  3 Mar 2024 13:02:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709470959;
	bh=ygoEEpZ6azYEb5HHiu98itSFP/0JLF70trcyRvJrE5s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bdNFqbmH6qG5aPJ4Fp+3oNehXVf66FYFfiv91aFOvJXqdDNcD6V2Ok/13kiu2Yskd
	 oMQlfn7rTunBGVJH8RUEaFnCPtMyBHDLbSIBAYy0eJ3tjDNcrOmhlHo8AObkZAkIve
	 U81B6rNpXTp5zjkIb1X7HpsWq+szVMU1rJKA1dQJCQwCVGeYQqHlXCjxctfjIihStH
	 uY2pA9qyA8XhGpj2ir7qBH1k6+yVXa6foSlqOQaJ0XUMoNSTQl0/h5xvzNScRSYTwo
	 q5tHlASr93dDdt7nCLC94LqCcmMALvQm5P1WtbFiFeXYZ7+heqK8JDHzv5wIkkqt1W
	 00r5tPXyvKGxQ==
Date: Sun, 3 Mar 2024 14:02:35 +0100
From: Alejandro Colomar <alx@kernel.org>
To: Bruno Haible <bruno@clisp.org>, linux-man@vger.kernel.org, 
	Elliott Hughes <enh@google.com>
Cc: Alejandro Colomar <alx@kernel.org>, 
	Stefan Puiu <stefan.puiu@gmail.com>, GNU C Library <libc-alpha@sourceware.org>, 
	linux-api@vger.kernel.org
Subject: [PATCH v2 2/2] nanosleep.2: Use 'duration' rather than 'request'
Message-ID: <20240303130233.18238-1-alx@kernel.org>
X-Mailer: git-send-email 2.43.0
References: <ZeRzS6mENO8kOh1W@debian>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="u3nmbnhrztjh4a3z"
Content-Disposition: inline
In-Reply-To: <ZeRzS6mENO8kOh1W@debian>


--u3nmbnhrztjh4a3z
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: [PATCH v2 2/2] nanosleep.2: Use 'duration' rather than 'request'
MIME-Version: 1.0

It seems much more clear.

Suggested-by: Elliott Hughes <enh@google.com>
Cc: Stefan Puiu <stefan.puiu@gmail.com>
Cc: Bruno Haible <bruno@clisp.org>
Signed-off-by: Alejandro Colomar <alx@kernel.org>
---

v2:

-  2/2:
   -  Drop changes to clock_nanosleep(2).  [Bruno]
   -  Don't say "relative duration".  [Bruno]

-  1/2:  unchanged, so not resent.

 man2/nanosleep.2 | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/man2/nanosleep.2 b/man2/nanosleep.2
index a8d9f5a8a..e7132ee32 100644
--- a/man2/nanosleep.2
+++ b/man2/nanosleep.2
@@ -22,7 +22,7 @@ .SH SYNOPSIS
 .nf
 .B #include <time.h>
 .P
-.BI "int nanosleep(const struct timespec *" req ,
+.BI "int nanosleep(const struct timespec *" duration ,
 .BI "              struct timespec *_Nullable " rem );
 .fi
 .P
@@ -39,7 +39,7 @@ .SH DESCRIPTION
 .BR nanosleep ()
 suspends the execution of the calling thread
 until either at least the time specified in
-.I *req
+.I *duration
 has elapsed, or the delivery of a signal
 that triggers the invocation of a handler in the calling thread or
 that terminates the process.
@@ -80,7 +80,7 @@ .SH DESCRIPTION
 and it makes the task of resuming a sleep that has been
 interrupted by a signal handler easier.
 .SH RETURN VALUE
-On successfully sleeping for the requested interval,
+On successfully sleeping for the requested duration,
 .BR nanosleep ()
 returns 0.
 If the call is interrupted by a signal handler or encounters an error,
@@ -138,8 +138,9 @@ .SH VERSIONS
 service based upon this clock, including the
 .BR nanosleep ()
 function; ...
-Consequently, these time services shall expire when the requested relative
-interval elapses, independently of the new or old value of the clock.
+Consequently,
+these time services shall expire when the requested duration elapses,
+independently of the new or old value of the clock.
 .RE
 .SH STANDARDS
 POSIX.1-2008.
@@ -158,8 +159,8 @@ .SH HISTORY
 This special extension was removed in Linux 2.5.39,
 and is thus not available in Linux 2.6.0 and later kernels.
 .SH NOTES
-If the interval specified in
-.I req
+If the
+.I duration
 is not an exact multiple of the granularity underlying clock (see
 .BR time (7)),
 then the interval will be rounded up to the next multiple.
--=20
2.43.0


--u3nmbnhrztjh4a3z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmXkdOsACgkQnowa+77/
2zJ5bhAAl1SllnYTog3qOc5Cg0A7Hor6a6ifZDNNc8kuYqxkxDO2XJL7+O7R84L0
0EkA3C5Xbw1YkFu0xnZKBWY9pJEQu4sGorO2UaRP9WX24oYhk7zb9gLPktYrP2bH
emrUgI2dMwMY2uyrVEHfDSgfjtjY0UFavt4S9a/esxqllQ4ZVf+u7VcHgtIoGopi
/Sn0TB4IJ3/vT9A48ywBgmu29ddjxlwxfQf1Dlcni2sxKE8eU6gVNJCcduxmfYpD
Uq9HE847jr4FwwaxmBGOM0IPUXGr5lJsYVBnUsW4GY96xPrJwOAYKBFZ2PXUgJ9k
V3yFiRVMtFgLGhGMlVO6TEtAozY6v767erdJPpqzMZCNtFxzjK2qFrtd10iicJ7l
gIs2Il5y93ZVpy1OfY2h8/F5Jb0UuYY3KyKvjjRQa5FsQWRsI26elB7ABXO1WYr3
5l749x9GZMtTDT1zB9/KxD/VEPOJ93dxYJFYRqWL2G3DolIXUbz1mo/VGx6MePD7
YvcMpAi8YuXV665zbuP4dra6WXX7h9qDnsgZwYIXRUe7DuP0LXWz67jU5TvWn/Pp
pmZTEP+fDbSkKrR+RPz7zFEyTCcjpHAv3/1eF5P3+Wsx/v980YKbzUPVwkTXjYMK
g0SzSxkkJk9o0j2c+yIUuU8b/rTrugv1IvGgKnX7W4c9JsO4TTY=
=h3KE
-----END PGP SIGNATURE-----

--u3nmbnhrztjh4a3z--


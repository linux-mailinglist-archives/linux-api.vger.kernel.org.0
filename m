Return-Path: <linux-api+bounces-1091-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 13C3E86F4C3
	for <lists+linux-api@lfdr.de>; Sun,  3 Mar 2024 13:15:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1540B222E3
	for <lists+linux-api@lfdr.de>; Sun,  3 Mar 2024 12:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 475AABE5A;
	Sun,  3 Mar 2024 12:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VpyWwh7p"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C0CEBE4A;
	Sun,  3 Mar 2024 12:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709468117; cv=none; b=aEF61HKi7wA0Bb1PyzK8NUYNr6KP+ugUrpR7RNmUzfCNad6nEzJoKkho8rmswD7qe/JNq+mlp85aAkDO3nZ6lSauAk7HLdgcjI1AqBWxJbaPy73GKluZqZrLpmM00bjpWbncFypljLsPKz5Yu8lt5CGFhbFBESm8q3p1rk07vbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709468117; c=relaxed/simple;
	bh=znTswpelGMVCKaIREHMS0Oy2uhrl8uFK8hZ8/tbG2G0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QpNv4MwDGyvgluY/WyJ+GoGi4Z/4u7PXRssNYZAwZsqLjKFLEvjrgHbFcCzojymq18sZQQaxq61cJ4mj+2owDz++xAgdjHjrkdjZaplcyeyAfcGq483KqT2VcXlDIsT7dbxpb53k4OD1IhN7JTvIyMQQENM1CJwh21l6pvp5tfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VpyWwh7p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13E83C433C7;
	Sun,  3 Mar 2024 12:15:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709468116;
	bh=znTswpelGMVCKaIREHMS0Oy2uhrl8uFK8hZ8/tbG2G0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VpyWwh7p7z31Bs02k5AvPhKpyT/KMwOiF6wGTuSd1hw0CDKpolT5juzjgk/b/VXN0
	 Kol+stM2tmmfIOSfjKZDMAU8eOkBPWqpTlRXxKbDe5da3EUEq0MDTie3fpB1w543Zz
	 eOKEx4W+zYsQkk5JQJsqYm2Mnwxo1ZwdASlc0WYxjxG5gqgwTJR0Vmhy3w/NEvZeBB
	 a8YPPa2Bl6oCNYB2WMTE1I2kYsgUb4YTZNNKaFc6BYUTyOusiF+51693zmYw/X+0ho
	 3infNrkcTpsJuEMHB5CI7Xo+t1S2kwXdYScdcPSQswCsxTCkuyO2f+QZBLZD+zlHE9
	 CUsVL6ZORUDrw==
Date: Sun, 3 Mar 2024 13:15:13 +0100
From: Alejandro Colomar <alx@kernel.org>
To: Elliott Hughes <enh@google.com>, Stefan Puiu <stefan.puiu@gmail.com>, 
	Bruno Haible <bruno@clisp.org>, linux-man@vger.kernel.org
Cc: Alejandro Colomar <alx@kernel.org>, 
	GNU C Library <libc-alpha@sourceware.org>, linux-api@vger.kernel.org
Subject: [PATCH 2/2] clock_nanosleep.2, nanosleep.2: Use 'duration' rather
 than 'request'
Message-ID: <20240303121454.16994-3-alx@kernel.org>
X-Mailer: git-send-email 2.43.0
References: <ZUIlirG-ypudgpbK@debian>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ojxz2fgf2brtxeie"
Content-Disposition: inline
In-Reply-To: <ZUIlirG-ypudgpbK@debian>


--ojxz2fgf2brtxeie
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: [PATCH 2/2] clock_nanosleep.2, nanosleep.2: Use 'duration' rather
 than 'request'
MIME-Version: 1.0

It seems much more clear.

Suggested-by: Elliott Hughes <enh@google.com>
Cc: Stefan Puiu <stefan.puiu@gmail.com>
Cc: Bruno Haible <bruno@clisp.org>
Signed-off-by: Alejandro Colomar <alx@kernel.org>
---
 man2/clock_nanosleep.2 | 20 ++++++++++----------
 man2/nanosleep.2       | 12 ++++++------
 2 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/man2/clock_nanosleep.2 b/man2/clock_nanosleep.2
index 5bda50e18..0eedc1277 100644
--- a/man2/clock_nanosleep.2
+++ b/man2/clock_nanosleep.2
@@ -19,7 +19,7 @@ .SH SYNOPSIS
 .nf
 .P
 .BI "int clock_nanosleep(clockid_t " clockid ", int " flags ,
-.BI "                    const struct timespec *" request ,
+.BI "                    const struct timespec *" duration ,
 .BI "                    struct timespec *_Nullable " remain );
 .fi
 .P
@@ -94,7 +94,7 @@ .SH DESCRIPTION
 If
 .I flags
 is 0, then the value specified in
-.I request
+.I duration
 is interpreted as an interval relative to the current
 value of the clock specified by
 .IR clockid .
@@ -104,11 +104,11 @@ .SH DESCRIPTION
 is
 .BR TIMER_ABSTIME ,
 then
-.I request
+.I duration
 is interpreted as an absolute time as measured by the clock,
 .IR clockid .
 If
-.I request
+.I duration
 is less than or equal to the current value of the clock,
 then
 .BR clock_nanosleep ()
@@ -117,7 +117,7 @@ .SH DESCRIPTION
 .BR clock_nanosleep ()
 suspends the execution of the calling thread
 until either at least the time specified by
-.I request
+.I duration
 has elapsed,
 or a signal is delivered that causes a signal handler to be called or
 that terminates the process.
@@ -138,7 +138,7 @@ .SH DESCRIPTION
 .BR clock_nanosleep ()
 again and complete a (relative) sleep.
 .SH RETURN VALUE
-On successfully sleeping for the requested interval,
+On successfully sleeping for the requested duration,
 .BR clock_nanosleep ()
 returns 0.
 If the call is interrupted by a signal handler or encounters an error,
@@ -146,7 +146,7 @@ .SH RETURN VALUE
 .SH ERRORS
 .TP
 .B EFAULT
-.I request
+.I duration
 or
 .I remain
 specified an invalid address.
@@ -179,8 +179,8 @@ .SH HISTORY
 Linux 2.6,
 glibc 2.1.
 .SH NOTES
-If the interval specified in
-.I request
+If the
+.I duration
 is not an exact multiple of the granularity underlying clock (see
 .BR time (7)),
 then the interval will be rounded up to the next multiple.
@@ -216,7 +216,7 @@ .SH NOTES
 is
 .BR TIMER_ABSTIME .
 (An absolute sleep can be restarted using the same
-.I request
+.I duration
 argument.)
 .P
 POSIX.1 specifies that
diff --git a/man2/nanosleep.2 b/man2/nanosleep.2
index a8d9f5a8a..6272c21e6 100644
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
@@ -139,7 +139,7 @@ .SH VERSIONS
 .BR nanosleep ()
 function; ...
 Consequently, these time services shall expire when the requested relative
-interval elapses, independently of the new or old value of the clock.
+duration elapses, independently of the new or old value of the clock.
 .RE
 .SH STANDARDS
 POSIX.1-2008.
@@ -158,8 +158,8 @@ .SH HISTORY
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


--ojxz2fgf2brtxeie
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIyBAABCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmXkadEACgkQnowa+77/
2zIlug/2Jg5xoK19JC/xBvi1Li+s0dz4DgkE5Nlhon682bQq8J9uK129vJJ5zkj0
BDnKKL7iZqkvttaGAcoqOrlli7BT9hjSDmSBLuvD7uYeLFlsV/xkpVKLryG2N9br
sLCg8+9UtgPvTSVVIp5aSjsIathWiwbzMOg7avAIoxLalVG/RS+OwfZgCPbK2rHS
qU2M/a8F+byKahDDE82gL3rrc4wT3IszYw2/y69QUzSwk6zuThQxa+Op0tWViU5a
5UYpiyyUJMDXJ/tSlKlyJXMqlg2/AMFNs4/d9gF0/PVkTVk3WMbGJNxM1hG7C58p
hnr5vPL3myWoOK0CFHMf/d2bIUnCFh2yWEKYHQ/3SO6q8d2gj+DyB7WBKziRLX/j
IjTluWgLuL/oSLYfc8y9891nzgKxPa+FQNNfBDyVol+MOVDmv1oNSjvvu8TfkAuE
Pkvj2JoVndy48CPlHOtZJEONOkg5Dqo5DJYsnYphsB5G6cJ+QYTxZoaXkDp1Nqjx
2jHgsRJtUjsfsIDm5s5CLZFB1KEVZ+nOrHQqW3yVHmdlGIo3LbXAmJ6Qpu0Ov2/Q
2yWTdCLUo3xEjta4SXRzkj5mGFSNttenatShjKXO9tly0n64s+A9WP8S9BumZhIo
EyYWF9Jko/1Tx+6aoZMBUz2vWEUxZKQ1GTQ6/2jvBPtDmuR9ng==
=rLzG
-----END PGP SIGNATURE-----

--ojxz2fgf2brtxeie--


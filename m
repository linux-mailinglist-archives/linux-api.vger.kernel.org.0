Return-Path: <linux-api+bounces-1089-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E6FF886F4BE
	for <lists+linux-api@lfdr.de>; Sun,  3 Mar 2024 13:15:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C63C92828E3
	for <lists+linux-api@lfdr.de>; Sun,  3 Mar 2024 12:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F47CB664;
	Sun,  3 Mar 2024 12:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nOw0mxvr"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06794BE68;
	Sun,  3 Mar 2024 12:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709468109; cv=none; b=Dp1llV4bYGAedaTz+Jq+aSraEjF4mSaNQBoMm0mFFAwaMX1rtjV9agiLqFj5ZIwAFKlgRZcRODzA3ETWmpl3d1jetjssQQDIs8T6kQqv/3fI3AyBDcwT5Bhj0zZ4D64Vi9c0g/EAQckU96QMi32Vl1OaRkwTodyOB0Q9ptipSOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709468109; c=relaxed/simple;
	bh=qREyyhvgSeHvXyhWgxFSWmj8iefZsN67LoZLcBk5n0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FF8yDmDCAF4LzvZxmGoFxdmz14NolLJ9A13PQLCRNwo8zNwQPciQ7PaMIszZw8aj4pk3nc/hWO6xroP7kRpdxs4P+kix+ZznT93KRmeQxeFN5FLK3oLn8re87oYNagcskAdCnKJPPs+kG5eV5gWF1+iHLhGPHiLVzwIoeHuEkRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nOw0mxvr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0810EC433F1;
	Sun,  3 Mar 2024 12:15:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709468108;
	bh=qREyyhvgSeHvXyhWgxFSWmj8iefZsN67LoZLcBk5n0Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nOw0mxvrUyYIyzSanOwyNGEDZQHgPSZwnZL6rdMKfmt0REdJxbJsVw4jxqF6BTOLE
	 JWO2sLGSP28/9mXQL5//XPl1gH/+hIdwmJqVnhoX2nHtR8/PtNAk9VcBKD6lNTBLAB
	 k6M1wGkBy06uYXRAbYmpuCahGbKzwQuI3r9YG8oRGQRdNVq30Ucy+0RnEznmY1OCCI
	 gUvCbm85ChK/tQtIdYZKZFV0g6oTwAmtsqQJO8qeKrGIZHuJBeECU+dHErOwo3w4Az
	 yLyhBzv5256Nf7/RxMnmN4TihHjvxR1yJSP7PzDj3JjccHF56ylSYbUOoO3wni9aBR
	 jAFnS7HePUrBQ==
Date: Sun, 3 Mar 2024 13:15:05 +0100
From: Alejandro Colomar <alx@kernel.org>
To: Elliott Hughes <enh@google.com>, Stefan Puiu <stefan.puiu@gmail.com>, 
	Bruno Haible <bruno@clisp.org>, linux-man@vger.kernel.org
Cc: Alejandro Colomar <alx@kernel.org>, 
	GNU C Library <libc-alpha@sourceware.org>, linux-api@vger.kernel.org
Subject: [PATCH 0/2] Use terms consistently in function parameter names.
Message-ID: <20240303121454.16994-1-alx@kernel.org>
X-Mailer: git-send-email 2.43.0
References: <ZUIlirG-ypudgpbK@debian>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wfsmp4pwh5henpd6"
Content-Disposition: inline
In-Reply-To: <ZUIlirG-ypudgpbK@debian>


--wfsmp4pwh5henpd6
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: [PATCH 0/2] Use terms consistently in function parameter names.
MIME-Version: 1.0

Hi!

I finally wrote this patch.  I had it in my todo for too long.

In <time.h> functions, use duration, instead of request, as suggested by
Elliott.

In ctl functions and similar, there was a lot of variation:

-  command
-  cmd
-  request
-  req
-  option
-  operation
-  op

And they all meant the same thing.  We have similar problems in the
names of the constants, which have similar variability.

In the case of the function parameters, we can easily rename them.  I
chose 'op', as it seems a reasonable (and short) name, and most of the
documentation already used the term 'operation' to refer to the
parameter, even in cases where the parameter was names differently.

I would like to ask to kernel maintainers and libc implementations to
add some consistency here too, and rename the parameters accordingly,
for consistency, or at least use your own consistency, if you don't like
this one, but stick to some rules.

In the case of constants, we can't rename them.  Too bad.  But I'd like
to ask programmers to have this in mind for when new constants are
added, so that some consistency is followed.  (This was something that
made me doubt about using 'op', because most constants seem to use
'_CMD_' in their names.  If you prefer 'cmd' for the parameter names for
that reason, let's discuss it.)

Have a lovely day!
Alex


Alejandro Colomar (2):
  man*/: epoll_*(), fcntl(), flock(), ioctl(), msgctl(), *prctl(),
    ptrace(), quotactl(), reboot(), semctl(), shmctl(), lockf():
    Consistently use 'op' and 'operation'
  clock_nanosleep.2, nanosleep.2: Use 'duration' rather than 'request'

 man2/arch_prctl.2          | 12 +++---
 man2/clock_nanosleep.2     | 20 ++++-----
 man2/epoll_wait.2          |  4 +-
 man2/fcntl.2               | 70 +++++++++++++++----------------
 man2/flock.2               |  6 +--
 man2/ioctl.2               | 30 +++++++-------
 man2/ioctl_console.2       |  8 ++--
 man2/ioctl_fideduperange.2 |  2 +-
 man2/ioctl_getfsmap.2      |  6 +--
 man2/ioctl_ns.2            |  2 +-
 man2/ioctl_tty.2           | 10 ++---
 man2/ioctl_userfaultfd.2   | 10 ++---
 man2/msgctl.2              | 16 ++++----
 man2/nanosleep.2           | 12 +++---
 man2/prctl.2               | 84 +++++++++++++++++++-------------------
 man2/ptrace.2              | 60 +++++++++++++--------------
 man2/quotactl.2            | 34 +++++++--------
 man2/reboot.2              | 19 +++++----
 man2/semctl.2              | 22 +++++-----
 man2/shmctl.2              | 20 +++++----
 man3/lockf.3               | 11 ++---
 21 files changed, 233 insertions(+), 225 deletions(-)

--=20
2.43.0


--wfsmp4pwh5henpd6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmXkackACgkQnowa+77/
2zLx6A/+JurxBBdZMKFu/0xWH0u/ByoKTj86x8rQFsh0MB6NLid4Mhm9u/t8t5vF
X2MpVSLA6N2PEQbSdAOpoExE+RnJmyOOYvlnjba6WHjaMRPOWyi7SXZggctUreV5
Pjq7VBKdTmLUmMqvV8ydsRPFqNawA8FQcnMQN7C5XGK3sdyC4mY+qpRBSvGym/zS
0thYAtfzmPPmHqi8zRd5nvZDIwCgh2sN2x2JlbgTgw/FYL5xmRpjwR3+S7jDXbcp
DkLd+B/w3aDa1JkQMCK2j5fk8AsNfbNzF9yn5ol+Gf7b/Lfdfdgn6UQ/L6L8tNUc
4szK/7g8WW1mHJpJo2ely8WrRuH/hx58n1sFBcA4gOziEBUC66lWut7sy5Wbi08K
IVxD1x0PcvBrKm3e2TKHwHkw8nR2HaHupyPg3KaahlBQ8A68eCyCK4oXcVbMgeqn
oP18NtiuuMcPINBdG31V7TkO/tvVYNhYqVhOA0n1Ui+VUj3n4NFJItR33G5caXYR
AnPrJoEBHHYJ6ELM0t2VvWGz/tWvFKBlWHfBm7Wlx6sYpqLgTlV3zGCVb+ljtj3I
+m/w8p3/+B7d3IOiy6GDKM0kFDY4yPS7Qrcx+2wkORe/GjB/yKZSULhGMSPp2C1y
HGuqk53trRwEl3+F5vFRzS502srTZXK/7DrNuUbWEPVUt5vM/9M=
=ZcOj
-----END PGP SIGNATURE-----

--wfsmp4pwh5henpd6--


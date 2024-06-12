Return-Path: <linux-api+bounces-1716-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDC52905234
	for <lists+linux-api@lfdr.de>; Wed, 12 Jun 2024 14:16:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 003841C22F97
	for <lists+linux-api@lfdr.de>; Wed, 12 Jun 2024 12:16:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E75A16E896;
	Wed, 12 Jun 2024 12:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SD5yBUUI"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C4216D32E;
	Wed, 12 Jun 2024 12:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718194576; cv=none; b=rAuQItyqvDwjQ13WUwAdsKMjgPyiSrF+wKXD/JXaq28RlbKer8EkSzQtN9VROVRxmlON798WFtcWJGj312u9X1SKo4JYUVGUKlQI1JgLu0szrREEEolcEZZupL6D3+nC/T9hYgqAWpW23mihO2uyuHma0z5pQYnVC8kkSlQlZ24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718194576; c=relaxed/simple;
	bh=e1AmckxhlAtXfeod5EEKxj0kdCN7+NAHL6ivtSfGRLA=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=pqMe0j0lS8hjS6X7uHu8RHUGwWyq0SuozszOlM/Lw6zRjtN6Ah8DUdiJelU08NXhqSHvT6+8EQ+8S16rFSOd614MGsYMgHhVZa6bLHC/dqk0QVMUytVb2+9+Ooex8tvKjbl+PvUAvIej3uvJkZxD0bkJfPJ5jrBvyP3baWYgC5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SD5yBUUI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1B3EC3277B;
	Wed, 12 Jun 2024 12:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718194575;
	bh=e1AmckxhlAtXfeod5EEKxj0kdCN7+NAHL6ivtSfGRLA=;
	h=Date:From:To:Subject:From;
	b=SD5yBUUIuG/EZJ071ADeIsO3iwS00fLg9zxtMxYMUnNnXSpjDfJthuVgQzPtIwbYh
	 WGs90NgkIXDvFdYPpKeNfs0YMo5RVvoWnxeKYnW7QvZihOf18VjFYOfwgqiNybGe6w
	 YAmDLUSgI8lESfZrFH+Xao0OIEa+IPx6DlK2QigIJ1YO4VLBC4Bfp7iw1AwpxXLLNZ
	 44nzPFGPm0GII6x1zsSoQ6EeWeXMXeJMvAB5Orp2tU9F9j1wQcHxtAgKuTqypE0hDL
	 YCW6COeZY8RM1e88+wnzxmdPND82+e5YSyrltGBxojUsa9djEKUEiU5lxOGiQiuYg9
	 m3o99dTMf26uA==
Date: Wed, 12 Jun 2024 14:16:12 +0200
From: Alejandro Colomar <alx@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, 
	Palmer Dabbelt <palmer@rivosinc.com>, linux-api@vger.kernel.org, libc-alpha@sourceware.org, 
	linux-man@vger.kernel.org
Subject: termios constants should be unsigned
Message-ID: <a7kfppfptkzvqys6cblwjudlpoghsycjglw57hxe2ywvruzkbd@e6nqpnxgwfnq>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="t45r3ld3ox6bd7jy"
Content-Disposition: inline


--t45r3ld3ox6bd7jy
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, 
	Palmer Dabbelt <palmer@rivosinc.com>, linux-api@vger.kernel.org, libc-alpha@sourceware.org, 
	linux-man@vger.kernel.org
Subject: termios constants should be unsigned
MIME-Version: 1.0

Hi!

While compiling an example program in ioctl_tty(2) examples (now moving
to TCSETS(2const)), I saw several warnings:

tcgets.c:53:24: error: implicit conversion changes signedness: 'int' to 'tc=
flag_t' (aka 'unsigned int') [clang-diagnostic-sign-conversion,-warnings-as=
-errors]
        tio.c_cflag &=3D ~CBAUD;
                    ~~ ^~~~~~
tcgets.c:53:24: warning: use of a signed integer operand with a binary bitw=
ise operator [hicpp-signed-bitwise]
        tio.c_cflag &=3D ~CBAUD;
                    ~~ ^~~~~~
tcgets.c:58:24: error: implicit conversion changes signedness: 'int' to 'tc=
flag_t' (aka 'unsigned int') [clang-diagnostic-sign-conversion,-warnings-as=
-errors]
        tio.c_cflag &=3D ~(CBAUD << IBSHIFT);
                    ~~ ^~~~~~~~~~~~~~~~~~~
tcgets.c:58:24: warning: use of a signed integer operand with a binary bitw=
ise operator [hicpp-signed-bitwise]
        tio.c_cflag &=3D ~(CBAUD << IBSHIFT);
                    ~~ ^~~~~~~~~~~~~~~~~~~
tcgets.c:58:25: warning: use of a signed integer operand with a unary bitwi=
se operator [hicpp-signed-bitwise]
        tio.c_cflag &=3D ~(CBAUD << IBSHIFT);
                       ~^~~~~~~~~~~~~~~~~~

Which seem reasonable warnings.  Bitwise operations on signed integers
is bad for ye health.  Let's see the definitions of struct termios:

	alx@debian:/usr/include$ grepc termios x86_64-linux-gnu/ asm-generic/
	x86_64-linux-gnu/bits/termios-struct.h:struct termios
	  {
	    tcflag_t c_iflag;		/* input mode flags */
	    tcflag_t c_oflag;		/* output mode flags */
	    tcflag_t c_cflag;		/* control mode flags */
	    tcflag_t c_lflag;		/* local mode flags */
	    cc_t c_line;			/* line discipline */
	    cc_t c_cc[NCCS];		/* control characters */
	    speed_t c_ispeed;		/* input speed */
	    speed_t c_ospeed;		/* output speed */
	#define _HAVE_STRUCT_TERMIOS_C_ISPEED 1
	#define _HAVE_STRUCT_TERMIOS_C_OSPEED 1
	  };
	asm-generic/termbits.h:struct termios {
		tcflag_t c_iflag;		/* input mode flags */
		tcflag_t c_oflag;		/* output mode flags */
		tcflag_t c_cflag;		/* control mode flags */
		tcflag_t c_lflag;		/* local mode flags */
		cc_t c_line;			/* line discipline */
		cc_t c_cc[NCCS];		/* control characters */
	};

Except for the speed members, they seem the same.  The types of the
members are correctly unsigned:

	alx@debian:/usr/include$ grepc tcflag_t x86_64-linux-gnu/ asm-generic/
	x86_64-linux-gnu/bits/termios.h:typedef unsigned int	tcflag_t;
	asm-generic/termbits.h:typedef unsigned int	tcflag_t;

So, all of the constants that are to be used in these members, which
will undergo bitwise operations, should use the U suffix.  Here's the
list for the UAPI:

	$ sed -n '/flag bits/,/^$/p' asm-generic/termbits.h
	/* c_iflag bits */
	#define IUCLC	0x0200
	#define IXON	0x0400
	#define IXOFF	0x1000
	#define IMAXBEL	0x2000
	#define IUTF8	0x4000

	/* c_oflag bits */
	#define OLCUC	0x00002
	#define ONLCR	0x00004
	#define NLDLY	0x00100
	#define   NL0	0x00000
	#define   NL1	0x00100
	#define CRDLY	0x00600
	#define   CR0	0x00000
	#define   CR1	0x00200
	#define   CR2	0x00400
	#define   CR3	0x00600
	#define TABDLY	0x01800
	#define   TAB0	0x00000
	#define   TAB1	0x00800
	#define   TAB2	0x01000
	#define   TAB3	0x01800
	#define   XTABS	0x01800
	#define BSDLY	0x02000
	#define   BS0	0x00000
	#define   BS1	0x02000
	#define VTDLY	0x04000
	#define   VT0	0x00000
	#define   VT1	0x04000
	#define FFDLY	0x08000
	#define   FF0	0x00000
	#define   FF1	0x08000

	/* c_lflag bits */
	#define ISIG	0x00001
	#define ICANON	0x00002
	#define XCASE	0x00004
	#define ECHO	0x00008
	#define ECHOE	0x00010
	#define ECHOK	0x00020
	#define ECHONL	0x00040
	#define NOFLSH	0x00080
	#define TOSTOP	0x00100
	#define ECHOCTL	0x00200
	#define ECHOPRT	0x00400
	#define ECHOKE	0x00800
	#define FLUSHO	0x01000
	#define PENDIN	0x04000
	#define IEXTEN	0x08000
	#define EXTPROC	0x10000

And glibc also (re)defines some of them, so those should also have the
U suffix.

Any opinions?

Have a lovely day!
Alex

--=20
<https://www.alejandro-colomar.es/>

--t45r3ld3ox6bd7jy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmZpkYwACgkQnowa+77/
2zLCjQ//dKL+Y6ugfviQ8YOvXw5T9/jjzmgD13R4QxyXmuZZiAz5PFMt03AqDpq1
rwBfMlsauh5nYYIVsvYVhKF7dolMos3AN+hBlBbbKMuqhwPM+KqlqmyQc349vkNJ
X/I9FSyTWqEQNOcW5NlYsuT5mmpy1KbNjimeabntPMV44jmj9CT32ZYUw6kNCFhz
a+XpP+V/MiWF3QfLQUms2cnfgDi48MqvbmvBWRAtnV7aU35bzk48UpsHNsF9W2Rp
KPnFM7vd1Ep6qDwvCZiAGKpYp7eh2K3ewLeyOeJYcWZlRBF5rKJ+hR37JN0fYN/d
DdWHu8AdwCIS4MXUDaLc9conrC31McpgLvCTXHYBKTKcEPcJVGRUlCnmLI5IKTt7
fpyUISmHlR1i8Cy8mA2se0LuK95iwgsa4NXWQ+NX5BU3HipPaPdt7gVN2asyv/2s
iE8jAPbCqiGPCgfde7bOYZw1pIujQZrNXhKI8epHh60s6xnW76REL1DgErxSSDBX
N9WpGrZqXXeppgXBn6ltvhMM0xv9qLiV+7hMVZkiHawlq/JU3/b+kVMpklSFIDR9
ZBnlspr6dRQL+kMqmwcSvT53JM2nCe+IzMY8JmKZXFKC233pW2yLseD6hePgP9AT
9+k787wK55JoQPo4nlR9xdBLuMpUZk2xBxf2zwUPeynjoG4doik=
=xhlV
-----END PGP SIGNATURE-----

--t45r3ld3ox6bd7jy--


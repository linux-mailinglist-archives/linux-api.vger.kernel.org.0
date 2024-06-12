Return-Path: <linux-api+bounces-1718-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14283905377
	for <lists+linux-api@lfdr.de>; Wed, 12 Jun 2024 15:17:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 907C92870E4
	for <lists+linux-api@lfdr.de>; Wed, 12 Jun 2024 13:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A260176ACD;
	Wed, 12 Jun 2024 13:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hiMsGR1+"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 142E616EBF7;
	Wed, 12 Jun 2024 13:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718198222; cv=none; b=q33bXQIaGtQnp9vgpebBExBoIGKCi5kqV4MLtoTPFSMjpiiLu3z62H6acs1VoHykPJ8P0eXMykK1/H5ZYWGfVvACvi9VHu8Y9pX9EdOYNZaDxZh7TMrpckQ5y/zfUqXJ9j3vgSOmVQiSCRY3ZWeefbf0O50woq9GWbJCJLREM94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718198222; c=relaxed/simple;
	bh=aur5e4qsY/e7Plex5Aud9WuBWRklc39KURuTFakmliQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NMytdNcKFLBewrqo8SRyGbMyuJF28BcIQ3QBrHQu+S2z7HYR3lWR7Jbg++DPQlAuY4jnJm7NQDiJyZCmSyM2AyPXS3jotSHjvB2dVxBsPybiMKjWW4RyM+195ErSpms8ugc8lB89Nttr/4dq8UTjW2sc62UuH5ChD+gEn2xTsYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hiMsGR1+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5288C3277B;
	Wed, 12 Jun 2024 13:16:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718198221;
	bh=aur5e4qsY/e7Plex5Aud9WuBWRklc39KURuTFakmliQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hiMsGR1+wbiTL0FZqwZanfz66Da7Yk22qENgD2FnaiPyQJgYfjJaWitBAxI8en6l2
	 EdCdv1BI1oGtI2Rq2aEkp8pTY48I8S1x9eM4NnUuYOs0y6yxucFBuYKdA0t2WUcN9f
	 Rj9/ZznYkjPNMVXQJeZO5NwQkeo/B9zAIlB8oejzAAFt54nm+J5fQzXVU+0AZT7Ow/
	 wd7ot27tBaxVsKO0lmMMUbSUGrMuhAwsZyGvW/Ykns9ddK1Tg4wWz5OLGPLVNZ6C+G
	 DaiJ8vSWwPsYUNRJL+3oU6ATgOwWFDtdlO8DBOGnbxUSI/fZe+snidF13NbJ8CGLiy
	 a5usaDjvsZD0w==
Date: Wed, 12 Jun 2024 15:16:58 +0200
From: Alejandro Colomar <alx@kernel.org>
To: linux-api@vger.kernel.org
Cc: Alejandro Colomar <alx@kernel.org>, linux-man@vger.kernel.org, 
	Greg KH <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Palmer Dabbelt <palmer@rivosinc.com>, libc-alpha@sourceware.org
Subject: [PATCH] uapi/asm/termbits: Use the U integer suffix for bit fields
Message-ID: <20240612131633.449937-2-alx@kernel.org>
X-Mailer: git-send-email 2.45.1
References: <2024061222-scuttle-expanse-6438@gregkh>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="e6ms7eawb5vx6rd2"
Content-Disposition: inline
In-Reply-To: <2024061222-scuttle-expanse-6438@gregkh>


--e6ms7eawb5vx6rd2
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: linux-api@vger.kernel.org
Cc: Alejandro Colomar <alx@kernel.org>, linux-man@vger.kernel.org, 
	Greg KH <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Palmer Dabbelt <palmer@rivosinc.com>, libc-alpha@sourceware.org
Subject: [PATCH] uapi/asm/termbits: Use the U integer suffix for bit fields
References: <2024061222-scuttle-expanse-6438@gregkh>
MIME-Version: 1.0
In-Reply-To: <2024061222-scuttle-expanse-6438@gregkh>

Constants that are to be used in bitwise operations should be unsigned,
or a user could easily trigger Undefined Behavior.
Also, the types where these constants are to be assigned are unsigned,
so this makes it more consistent.

alx@debian:/usr/include$ grepc -tt termios asm-generic/
asm-generic/termbits.h:struct termios {
	tcflag_t c_iflag;		/* input mode flags */
	tcflag_t c_oflag;		/* output mode flags */
	tcflag_t c_cflag;		/* control mode flags */
	tcflag_t c_lflag;		/* local mode flags */
	cc_t c_line;			/* line discipline */
	cc_t c_cc[NCCS];		/* control characters */
};
alx@debian:/usr/include$ grepc -tt tcflag_t asm-generic/
asm-generic/termbits.h:typedef unsigned int	tcflag_t;
alx@debian:/usr/include$ grepc -tt cc_t asm-generic/
asm-generic/termbits-common.h:typedef unsigned char	cc_t;
alx@debian:/usr/include$ grepc -tt speed_t asm-generic/
asm-generic/termbits-common.h:typedef unsigned int	speed_t;

Link: <https://lore.kernel.org/linux-api/2024061222-scuttle-expanse-6438@gr=
egkh/T/>
Cc: Greg KH <gregkh@linuxfoundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Palmer Dabbelt <palmer@rivosinc.com>
Cc: <linux-api@vger.kernel.org>
Cc: <libc-alpha@sourceware.org>
Signed-off-by: Alejandro Colomar <alx@kernel.org>
---

Hi Greg,

On Wed, Jun 12, 2024 at 02:22:37PM GMT, Greg KH wrote:
> Have a proposed patch that you feel would resolve this?
>
> thanks,
>
> greg k-h

Here it is.  :)

For reviewing it, I suggest using '--word-diff-regex=3D.'.

I compiled the kernel, and it seems ok; didn't test more than that.

Have a lovely day!
Alex

Range-diff:
-:  ------------ > 1:  588eb01ac153 uapi/asm/termbits: Use the U integer su=
ffix for bit fields

 arch/alpha/include/uapi/asm/termbits.h   | 154 +++++++++---------
 arch/mips/include/uapi/asm/termbits.h    | 154 +++++++++---------
 arch/parisc/include/uapi/asm/termbits.h  | 152 +++++++++---------
 arch/powerpc/include/uapi/asm/termbits.h | 156 +++++++++---------
 arch/sparc/include/uapi/asm/termbits.h   | 192 +++++++++++------------
 include/uapi/asm-generic/termbits.h      | 152 +++++++++---------
 6 files changed, 480 insertions(+), 480 deletions(-)

diff --git a/arch/alpha/include/uapi/asm/termbits.h b/arch/alpha/include/ua=
pi/asm/termbits.h
index f1290b22072b..965a8c93523d 100644
--- a/arch/alpha/include/uapi/asm/termbits.h
+++ b/arch/alpha/include/uapi/asm/termbits.h
@@ -70,39 +70,39 @@ struct ktermios {
 #define VTIME		17
=20
 /* c_iflag bits */
-#define IXON	0x0200
-#define IXOFF	0x0400
-#define IUCLC	0x1000
-#define IMAXBEL	0x2000
-#define IUTF8	0x4000
+#define IXON	0x0200U
+#define IXOFF	0x0400U
+#define IUCLC	0x1000U
+#define IMAXBEL	0x2000U
+#define IUTF8	0x4000U
=20
 /* c_oflag bits */
-#define ONLCR	0x00002
-#define OLCUC	0x00004
-#define NLDLY	0x00300
-#define   NL0	0x00000
-#define   NL1	0x00100
-#define   NL2	0x00200
-#define   NL3	0x00300
-#define TABDLY	0x00c00
-#define   TAB0	0x00000
-#define   TAB1	0x00400
-#define   TAB2	0x00800
-#define   TAB3	0x00c00
-#define CRDLY	0x03000
-#define   CR0	0x00000
-#define   CR1	0x01000
-#define   CR2	0x02000
-#define   CR3	0x03000
-#define FFDLY	0x04000
-#define   FF0	0x00000
-#define   FF1	0x04000
-#define BSDLY	0x08000
-#define   BS0	0x00000
-#define   BS1	0x08000
-#define VTDLY	0x10000
-#define   VT0	0x00000
-#define   VT1	0x10000
+#define ONLCR	0x00002U
+#define OLCUC	0x00004U
+#define NLDLY	0x00300U
+#define   NL0	0x00000U
+#define   NL1	0x00100U
+#define   NL2	0x00200U
+#define   NL3	0x00300U
+#define TABDLY	0x00c00U
+#define   TAB0	0x00000U
+#define   TAB1	0x00400U
+#define   TAB2	0x00800U
+#define   TAB3	0x00c00U
+#define CRDLY	0x03000U
+#define   CR0	0x00000U
+#define   CR1	0x01000U
+#define   CR2	0x02000U
+#define   CR3	0x03000U
+#define FFDLY	0x04000U
+#define   FF0	0x00000U
+#define   FF1	0x04000U
+#define BSDLY	0x08000U
+#define   BS0	0x00000U
+#define   BS1	0x08000U
+#define VTDLY	0x10000U
+#define   VT0	0x00000U
+#define   VT1	0x10000U
 /*
  * Should be equivalent to TAB3, see description of TAB3 in
  * POSIX.1-2008, Ch. 11.2.3 "Output Modes"
@@ -110,54 +110,54 @@ struct ktermios {
 #define XTABS	TAB3
=20
 /* c_cflag bit meaning */
-#define CBAUD		0x0000001f
-#define CBAUDEX		0x00000000
-#define BOTHER		0x0000001f
-#define     B57600	0x00000010
-#define    B115200	0x00000011
-#define    B230400	0x00000012
-#define    B460800	0x00000013
-#define    B500000	0x00000014
-#define    B576000	0x00000015
-#define    B921600	0x00000016
-#define   B1000000	0x00000017
-#define   B1152000	0x00000018
-#define   B1500000	0x00000019
-#define   B2000000	0x0000001a
-#define   B2500000	0x0000001b
-#define   B3000000	0x0000001c
-#define   B3500000	0x0000001d
-#define   B4000000	0x0000001e
-#define CSIZE		0x00000300
-#define   CS5		0x00000000
-#define   CS6		0x00000100
-#define   CS7		0x00000200
-#define   CS8		0x00000300
-#define CSTOPB		0x00000400
-#define CREAD		0x00000800
-#define PARENB		0x00001000
-#define PARODD		0x00002000
-#define HUPCL		0x00004000
-#define CLOCAL		0x00008000
-#define CIBAUD		0x001f0000
+#define CBAUD		0x0000001fU
+#define CBAUDEX		0x00000000U
+#define BOTHER		0x0000001fU
+#define     B57600	0x00000010U
+#define    B115200	0x00000011U
+#define    B230400	0x00000012U
+#define    B460800	0x00000013U
+#define    B500000	0x00000014U
+#define    B576000	0x00000015U
+#define    B921600	0x00000016U
+#define   B1000000	0x00000017U
+#define   B1152000	0x00000018U
+#define   B1500000	0x00000019U
+#define   B2000000	0x0000001aU
+#define   B2500000	0x0000001bU
+#define   B3000000	0x0000001cU
+#define   B3500000	0x0000001dU
+#define   B4000000	0x0000001eU
+#define CSIZE		0x00000300U
+#define   CS5		0x00000000U
+#define   CS6		0x00000100U
+#define   CS7		0x00000200U
+#define   CS8		0x00000300U
+#define CSTOPB		0x00000400U
+#define CREAD		0x00000800U
+#define PARENB		0x00001000U
+#define PARODD		0x00002000U
+#define HUPCL		0x00004000U
+#define CLOCAL		0x00008000U
+#define CIBAUD		0x001f0000U
=20
 /* c_lflag bits */
-#define ISIG	0x00000080
-#define ICANON	0x00000100
-#define XCASE	0x00004000
-#define ECHO	0x00000008
-#define ECHOE	0x00000002
-#define ECHOK	0x00000004
-#define ECHONL	0x00000010
-#define NOFLSH	0x80000000
-#define TOSTOP	0x00400000
-#define ECHOCTL	0x00000040
-#define ECHOPRT	0x00000020
-#define ECHOKE	0x00000001
-#define FLUSHO	0x00800000
-#define PENDIN	0x20000000
-#define IEXTEN	0x00000400
-#define EXTPROC	0x10000000
+#define ISIG	0x00000080U
+#define ICANON	0x00000100U
+#define XCASE	0x00004000U
+#define ECHO	0x00000008U
+#define ECHOE	0x00000002U
+#define ECHOK	0x00000004U
+#define ECHONL	0x00000010U
+#define NOFLSH	0x80000000U
+#define TOSTOP	0x00400000U
+#define ECHOCTL	0x00000040U
+#define ECHOPRT	0x00000020U
+#define ECHOKE	0x00000001U
+#define FLUSHO	0x00800000U
+#define PENDIN	0x20000000U
+#define IEXTEN	0x00000400U
+#define EXTPROC	0x10000000U
=20
 /* Values for the OPTIONAL_ACTIONS argument to `tcsetattr'.  */
 #define	TCSANOW		0
diff --git a/arch/mips/include/uapi/asm/termbits.h b/arch/mips/include/uapi=
/asm/termbits.h
index 1eb60903d6f0..35eb388a176e 100644
--- a/arch/mips/include/uapi/asm/termbits.h
+++ b/arch/mips/include/uapi/asm/termbits.h
@@ -78,96 +78,96 @@ struct ktermios {
 #define VEOL		17		/* End-of-line character [ICANON] */
=20
 /* c_iflag bits */
-#define IUCLC	0x0200		/* Map upper case to lower case on input */
-#define IXON	0x0400		/* Enable start/stop output control */
-#define IXOFF	0x1000		/* Enable start/stop input control */
-#define IMAXBEL	0x2000		/* Ring bell when input queue is full */
-#define IUTF8	0x4000		/* Input is UTF-8 */
+#define IUCLC	0x0200U		/* Map upper case to lower case on input */
+#define IXON	0x0400U		/* Enable start/stop output control */
+#define IXOFF	0x1000U		/* Enable start/stop input control */
+#define IMAXBEL	0x2000U		/* Ring bell when input queue is full */
+#define IUTF8	0x4000U		/* Input is UTF-8 */
=20
 /* c_oflag bits */
-#define OLCUC	0x00002		/* Map lower case to upper case on output */
-#define ONLCR	0x00004		/* Map NL to CR-NL on output */
-#define NLDLY	0x00100
-#define   NL0	0x00000
-#define   NL1	0x00100
-#define CRDLY	0x00600
-#define   CR0	0x00000
-#define   CR1	0x00200
-#define   CR2	0x00400
-#define   CR3	0x00600
-#define TABDLY	0x01800
-#define   TAB0	0x00000
-#define   TAB1	0x00800
-#define   TAB2	0x01000
-#define   TAB3	0x01800
-#define   XTABS	0x01800
-#define BSDLY	0x02000
-#define   BS0	0x00000
-#define   BS1	0x02000
-#define VTDLY	0x04000
-#define   VT0	0x00000
-#define   VT1	0x04000
-#define FFDLY	0x08000
-#define   FF0	0x00000
-#define   FF1	0x08000
+#define OLCUC	0x00002U	/* Map lower case to upper case on output */
+#define ONLCR	0x00004U	/* Map NL to CR-NL on output */
+#define NLDLY	0x00100U
+#define   NL0	0x00000U
+#define   NL1	0x00100U
+#define CRDLY	0x00600U
+#define   CR0	0x00000U
+#define   CR1	0x00200U
+#define   CR2	0x00400U
+#define   CR3	0x00600U
+#define TABDLY	0x01800U
+#define   TAB0	0x00000U
+#define   TAB1	0x00800U
+#define   TAB2	0x01000U
+#define   TAB3	0x01800U
+#define   XTABS	0x01800U
+#define BSDLY	0x02000U
+#define   BS0	0x00000U
+#define   BS1	0x02000U
+#define VTDLY	0x04000U
+#define   VT0	0x00000U
+#define   VT1	0x04000U
+#define FFDLY	0x08000U
+#define   FF0	0x00000U
+#define   FF1	0x08000U
 /*
 #define PAGEOUT ???
 #define WRAP	???
  */
=20
 /* c_cflag bit meaning */
-#define CBAUD		0x0000100f
-#define CSIZE		0x00000030	/* Number of bits per byte (mask) */
-#define   CS5		0x00000000	/* 5 bits per byte */
-#define   CS6		0x00000010	/* 6 bits per byte */
-#define   CS7		0x00000020	/* 7 bits per byte */
-#define   CS8		0x00000030	/* 8 bits per byte */
-#define CSTOPB		0x00000040	/* Two stop bits instead of one */
-#define CREAD		0x00000080	/* Enable receiver */
-#define PARENB		0x00000100	/* Parity enable */
-#define PARODD		0x00000200	/* Odd parity instead of even */
-#define HUPCL		0x00000400	/* Hang up on last close */
-#define CLOCAL		0x00000800	/* Ignore modem status lines */
-#define CBAUDEX		0x00001000
-#define BOTHER		0x00001000
-#define     B57600	0x00001001
-#define    B115200	0x00001002
-#define    B230400	0x00001003
-#define    B460800	0x00001004
-#define    B500000	0x00001005
-#define    B576000	0x00001006
-#define    B921600	0x00001007
-#define   B1000000	0x00001008
-#define   B1152000	0x00001009
-#define   B1500000	0x0000100a
-#define   B2000000	0x0000100b
-#define   B2500000	0x0000100c
-#define   B3000000	0x0000100d
-#define   B3500000	0x0000100e
-#define   B4000000	0x0000100f
-#define CIBAUD		0x100f0000	/* input baud rate */
+#define CBAUD		0x0000100fU
+#define CSIZE		0x00000030U	/* Number of bits per byte (mask) */
+#define   CS5		0x00000000U	/* 5 bits per byte */
+#define   CS6		0x00000010U	/* 6 bits per byte */
+#define   CS7		0x00000020U	/* 7 bits per byte */
+#define   CS8		0x00000030U	/* 8 bits per byte */
+#define CSTOPB		0x00000040U	/* Two stop bits instead of one */
+#define CREAD		0x00000080U	/* Enable receiver */
+#define PARENB		0x00000100U	/* Parity enable */
+#define PARODD		0x00000200U	/* Odd parity instead of even */
+#define HUPCL		0x00000400U	/* Hang up on last close */
+#define CLOCAL		0x00000800U	/* Ignore modem status lines */
+#define CBAUDEX		0x00001000U
+#define BOTHER		0x00001000U
+#define     B57600	0x00001001U
+#define    B115200	0x00001002U
+#define    B230400	0x00001003U
+#define    B460800	0x00001004U
+#define    B500000	0x00001005U
+#define    B576000	0x00001006U
+#define    B921600	0x00001007U
+#define   B1000000	0x00001008U
+#define   B1152000	0x00001009U
+#define   B1500000	0x0000100aU
+#define   B2000000	0x0000100bU
+#define   B2500000	0x0000100cU
+#define   B3000000	0x0000100dU
+#define   B3500000	0x0000100eU
+#define   B4000000	0x0000100fU
+#define CIBAUD		0x100f0000U	/* input baud rate */
=20
 /* c_lflag bits */
-#define ISIG	0x00001		/* Enable signals */
-#define ICANON	0x00002		/* Do erase and kill processing */
-#define XCASE	0x00004
-#define ECHO	0x00008		/* Enable echo */
-#define ECHOE	0x00010		/* Visual erase for ERASE */
-#define ECHOK	0x00020		/* Echo NL after KILL */
-#define ECHONL	0x00040		/* Echo NL even if ECHO is off */
-#define NOFLSH	0x00080		/* Disable flush after interrupt */
-#define IEXTEN	0x00100		/* Enable DISCARD and LNEXT */
-#define ECHOCTL	0x00200		/* Echo control characters as ^X */
-#define ECHOPRT	0x00400		/* Hardcopy visual erase */
-#define ECHOKE	0x00800		/* Visual erase for KILL */
-#define FLUSHO	0x02000
-#define PENDIN	0x04000		/* Retype pending input (state) */
-#define TOSTOP	0x08000		/* Send SIGTTOU for background output */
+#define ISIG	0x00001U	/* Enable signals */
+#define ICANON	0x00002U	/* Do erase and kill processing */
+#define XCASE	0x00004U
+#define ECHO	0x00008U	/* Enable echo */
+#define ECHOE	0x00010U	/* Visual erase for ERASE */
+#define ECHOK	0x00020U	/* Echo NL after KILL */
+#define ECHONL	0x00040U	/* Echo NL even if ECHO is off */
+#define NOFLSH	0x00080U	/* Disable flush after interrupt */
+#define IEXTEN	0x00100U	/* Enable DISCARD and LNEXT */
+#define ECHOCTL	0x00200U	/* Echo control characters as ^X */
+#define ECHOPRT	0x00400U	/* Hardcopy visual erase */
+#define ECHOKE	0x00800U	/* Visual erase for KILL */
+#define FLUSHO	0x02000U
+#define PENDIN	0x04000U	/* Retype pending input (state) */
+#define TOSTOP	0x08000U	/* Send SIGTTOU for background output */
 #define ITOSTOP	TOSTOP
-#define EXTPROC	0x10000		/* External processing on pty */
+#define EXTPROC	0x10000U	/* External processing on pty */
=20
 /* ioctl (fd, TIOCSERGETLSR, &result) where result may be as below */
-#define TIOCSER_TEMT	0x01	/* Transmitter physically empty */
+#define TIOCSER_TEMT	0x01U	/* Transmitter physically empty */
=20
 /* tcsetattr uses these */
 #define TCSANOW		TCSETS	/* Change immediately */
diff --git a/arch/parisc/include/uapi/asm/termbits.h b/arch/parisc/include/=
uapi/asm/termbits.h
index 3a8938d26fb4..d9090878c129 100644
--- a/arch/parisc/include/uapi/asm/termbits.h
+++ b/arch/parisc/include/uapi/asm/termbits.h
@@ -58,88 +58,88 @@ struct ktermios {
 #define VEOL2		16
=20
 /* c_iflag bits */
-#define IUCLC	0x0200
-#define IXON	0x0400
-#define IXOFF	0x1000
-#define IMAXBEL	0x4000
-#define IUTF8	0x8000
+#define IUCLC	0x0200U
+#define IXON	0x0400U
+#define IXOFF	0x1000U
+#define IMAXBEL	0x4000U
+#define IUTF8	0x8000U
=20
 /* c_oflag bits */
-#define OLCUC	0x00002
-#define ONLCR	0x00004
-#define NLDLY	0x00100
-#define   NL0	0x00000
-#define   NL1	0x00100
-#define CRDLY	0x00600
-#define   CR0	0x00000
-#define   CR1	0x00200
-#define   CR2	0x00400
-#define   CR3	0x00600
-#define TABDLY	0x01800
-#define   TAB0	0x00000
-#define   TAB1	0x00800
-#define   TAB2	0x01000
-#define   TAB3	0x01800
-#define   XTABS	0x01800
-#define BSDLY	0x02000
-#define   BS0	0x00000
-#define   BS1	0x02000
-#define VTDLY	0x04000
-#define   VT0	0x00000
-#define   VT1	0x04000
-#define FFDLY	0x08000
-#define   FF0	0x00000
-#define   FF1	0x08000
+#define OLCUC	0x00002U
+#define ONLCR	0x00004U
+#define NLDLY	0x00100U
+#define   NL0	0x00000U
+#define   NL1	0x00100U
+#define CRDLY	0x00600U
+#define   CR0	0x00000U
+#define   CR1	0x00200U
+#define   CR2	0x00400U
+#define   CR3	0x00600U
+#define TABDLY	0x01800U
+#define   TAB0	0x00000U
+#define   TAB1	0x00800U
+#define   TAB2	0x01000U
+#define   TAB3	0x01800U
+#define   XTABS	0x01800U
+#define BSDLY	0x02000U
+#define   BS0	0x00000U
+#define   BS1	0x02000U
+#define VTDLY	0x04000U
+#define   VT0	0x00000U
+#define   VT1	0x04000U
+#define FFDLY	0x08000U
+#define   FF0	0x00000U
+#define   FF1	0x08000U
=20
 /* c_cflag bit meaning */
-#define CBAUD		0x0000100f
-#define CSIZE		0x00000030
-#define   CS5		0x00000000
-#define   CS6		0x00000010
-#define   CS7		0x00000020
-#define   CS8		0x00000030
-#define CSTOPB		0x00000040
-#define CREAD		0x00000080
-#define PARENB		0x00000100
-#define PARODD		0x00000200
-#define HUPCL		0x00000400
-#define CLOCAL		0x00000800
-#define CBAUDEX		0x00001000
-#define BOTHER		0x00001000
-#define     B57600	0x00001001
-#define    B115200	0x00001002
-#define    B230400	0x00001003
-#define    B460800	0x00001004
-#define    B500000	0x00001005
-#define    B576000	0x00001006
-#define    B921600	0x00001007
-#define   B1000000	0x00001008
-#define   B1152000	0x00001009
-#define   B1500000	0x0000100a
-#define   B2000000	0x0000100b
-#define   B2500000	0x0000100c
-#define   B3000000	0x0000100d
-#define   B3500000	0x0000100e
-#define   B4000000	0x0000100f
-#define CIBAUD		0x100f0000		/* input baud rate */
+#define CBAUD		0x0000100fU
+#define CSIZE		0x00000030U
+#define   CS5		0x00000000U
+#define   CS6		0x00000010U
+#define   CS7		0x00000020U
+#define   CS8		0x00000030U
+#define CSTOPB		0x00000040U
+#define CREAD		0x00000080U
+#define PARENB		0x00000100U
+#define PARODD		0x00000200U
+#define HUPCL		0x00000400U
+#define CLOCAL		0x00000800U
+#define CBAUDEX		0x00001000U
+#define BOTHER		0x00001000U
+#define     B57600	0x00001001U
+#define    B115200	0x00001002U
+#define    B230400	0x00001003U
+#define    B460800	0x00001004U
+#define    B500000	0x00001005U
+#define    B576000	0x00001006U
+#define    B921600	0x00001007U
+#define   B1000000	0x00001008U
+#define   B1152000	0x00001009U
+#define   B1500000	0x0000100aU
+#define   B2000000	0x0000100bU
+#define   B2500000	0x0000100cU
+#define   B3000000	0x0000100dU
+#define   B3500000	0x0000100eU
+#define   B4000000	0x0000100fU
+#define CIBAUD		0x100f0000U		/* input baud rate */
=20
 /* c_lflag bits */
-#define ISIG	0x00001
-#define ICANON	0x00002
-#define XCASE	0x00004
-#define ECHO	0x00008
-#define ECHOE	0x00010
-#define ECHOK	0x00020
-#define ECHONL	0x00040
-#define NOFLSH	0x00080
-#define TOSTOP	0x00100
-#define ECHOCTL	0x00200
-#define ECHOPRT	0x00400
-#define ECHOKE	0x00800
-#define FLUSHO	0x01000
-#define PENDIN	0x04000
-#define IEXTEN	0x08000
-#define EXTPROC	0x10000
+#define ISIG	0x00001U
+#define ICANON	0x00002U
+#define XCASE	0x00004U
+#define ECHO	0x00008U
+#define ECHOE	0x00010U
+#define ECHOK	0x00020U
+#define ECHONL	0x00040U
+#define NOFLSH	0x00080U
+#define TOSTOP	0x00100U
+#define ECHOCTL	0x00200U
+#define ECHOPRT	0x00400U
+#define ECHOKE	0x00800U
+#define FLUSHO	0x01000U
+#define PENDIN	0x04000U
+#define IEXTEN	0x08000U
+#define EXTPROC	0x10000U
=20
 /* tcsetattr uses these */
 #define	TCSANOW		0
diff --git a/arch/powerpc/include/uapi/asm/termbits.h b/arch/powerpc/includ=
e/uapi/asm/termbits.h
index 21dc86dcb2f1..ae3c2ed3dae8 100644
--- a/arch/powerpc/include/uapi/asm/termbits.h
+++ b/arch/powerpc/include/uapi/asm/termbits.h
@@ -64,90 +64,90 @@ struct ktermios {
 #define VDISCARD	16
=20
 /* c_iflag bits */
-#define IXON	0x0200
-#define IXOFF	0x0400
-#define IUCLC	0x1000
-#define IMAXBEL	0x2000
-#define IUTF8	0x4000
+#define IXON	0x0200U
+#define IXOFF	0x0400U
+#define IUCLC	0x1000U
+#define IMAXBEL	0x2000U
+#define IUTF8	0x4000U
=20
 /* c_oflag bits */
-#define ONLCR	0x00002
-#define OLCUC	0x00004
-#define NLDLY	0x00300
-#define   NL0	0x00000
-#define   NL1	0x00100
-#define   NL2	0x00200
-#define   NL3	0x00300
-#define TABDLY	0x00c00
-#define   TAB0	0x00000
-#define   TAB1	0x00400
-#define   TAB2	0x00800
-#define   TAB3	0x00c00
-#define   XTABS	0x00c00		/* required by POSIX to =3D=3D TAB3 */
-#define CRDLY	0x03000
-#define   CR0	0x00000
-#define   CR1	0x01000
-#define   CR2	0x02000
-#define   CR3	0x03000
-#define FFDLY	0x04000
-#define   FF0	0x00000
-#define   FF1	0x04000
-#define BSDLY	0x08000
-#define   BS0	0x00000
-#define   BS1	0x08000
-#define VTDLY	0x10000
-#define   VT0	0x00000
-#define   VT1	0x10000
+#define ONLCR	0x00002U
+#define OLCUC	0x00004U
+#define NLDLY	0x00300U
+#define   NL0	0x00000U
+#define   NL1	0x00100U
+#define   NL2	0x00200U
+#define   NL3	0x00300U
+#define TABDLY	0x00c00U
+#define   TAB0	0x00000U
+#define   TAB1	0x00400U
+#define   TAB2	0x00800U
+#define   TAB3	0x00c00U
+#define   XTABS	0x00c00U	/* required by POSIX to =3D=3D TAB3 */
+#define CRDLY	0x03000U
+#define   CR0	0x00000U
+#define   CR1	0x01000U
+#define   CR2	0x02000U
+#define   CR3	0x03000U
+#define FFDLY	0x04000U
+#define   FF0	0x00000U
+#define   FF1	0x04000U
+#define BSDLY	0x08000U
+#define   BS0	0x00000U
+#define   BS1	0x08000U
+#define VTDLY	0x10000U
+#define   VT0	0x00000U
+#define   VT1	0x10000U
=20
 /* c_cflag bit meaning */
-#define CBAUD		0x000000ff
-#define CBAUDEX		0x00000000
-#define BOTHER		0x0000001f
-#define    B57600	0x00000010
-#define   B115200	0x00000011
-#define   B230400	0x00000012
-#define   B460800	0x00000013
-#define   B500000	0x00000014
-#define   B576000	0x00000015
-#define   B921600	0x00000016
-#define  B1000000	0x00000017
-#define  B1152000	0x00000018
-#define  B1500000	0x00000019
-#define  B2000000	0x0000001a
-#define  B2500000	0x0000001b
-#define  B3000000	0x0000001c
-#define  B3500000	0x0000001d
-#define  B4000000	0x0000001e
-#define CSIZE		0x00000300
-#define   CS5		0x00000000
-#define   CS6		0x00000100
-#define   CS7		0x00000200
-#define   CS8		0x00000300
-#define CSTOPB		0x00000400
-#define CREAD		0x00000800
-#define PARENB		0x00001000
-#define PARODD		0x00002000
-#define HUPCL		0x00004000
-#define CLOCAL		0x00008000
-#define CIBAUD		0x00ff0000
+#define CBAUD		0x000000ffU
+#define CBAUDEX		0x00000000U
+#define BOTHER		0x0000001fU
+#define    B57600	0x00000010U
+#define   B115200	0x00000011U
+#define   B230400	0x00000012U
+#define   B460800	0x00000013U
+#define   B500000	0x00000014U
+#define   B576000	0x00000015U
+#define   B921600	0x00000016U
+#define  B1000000	0x00000017U
+#define  B1152000	0x00000018U
+#define  B1500000	0x00000019U
+#define  B2000000	0x0000001aU
+#define  B2500000	0x0000001bU
+#define  B3000000	0x0000001cU
+#define  B3500000	0x0000001dU
+#define  B4000000	0x0000001eU
+#define CSIZE		0x00000300U
+#define   CS5		0x00000000U
+#define   CS6		0x00000100U
+#define   CS7		0x00000200U
+#define   CS8		0x00000300U
+#define CSTOPB		0x00000400U
+#define CREAD		0x00000800U
+#define PARENB		0x00001000U
+#define PARODD		0x00002000U
+#define HUPCL		0x00004000U
+#define CLOCAL		0x00008000U
+#define CIBAUD		0x00ff0000U
=20
 /* c_lflag bits */
-#define ISIG	0x00000080
-#define ICANON	0x00000100
-#define XCASE	0x00004000
-#define ECHO	0x00000008
-#define ECHOE	0x00000002
-#define ECHOK	0x00000004
-#define ECHONL	0x00000010
-#define NOFLSH	0x80000000
-#define TOSTOP	0x00400000
-#define ECHOCTL	0x00000040
-#define ECHOPRT	0x00000020
-#define ECHOKE	0x00000001
-#define FLUSHO	0x00800000
-#define PENDIN	0x20000000
-#define IEXTEN	0x00000400
-#define EXTPROC	0x10000000
+#define ISIG	0x00000080U
+#define ICANON	0x00000100U
+#define XCASE	0x00004000U
+#define ECHO	0x00000008U
+#define ECHOE	0x00000002U
+#define ECHOK	0x00000004U
+#define ECHONL	0x00000010U
+#define NOFLSH	0x80000000U
+#define TOSTOP	0x00400000U
+#define ECHOCTL	0x00000040U
+#define ECHOPRT	0x00000020U
+#define ECHOKE	0x00000001U
+#define FLUSHO	0x00800000U
+#define PENDIN	0x20000000U
+#define IEXTEN	0x00000400U
+#define EXTPROC	0x10000000U
=20
 /* Values for the OPTIONAL_ACTIONS argument to `tcsetattr'.  */
 #define	TCSANOW		0
diff --git a/arch/sparc/include/uapi/asm/termbits.h b/arch/sparc/include/ua=
pi/asm/termbits.h
index 0da2b1adc0f5..5cd0b28b16dc 100644
--- a/arch/sparc/include/uapi/asm/termbits.h
+++ b/arch/sparc/include/uapi/asm/termbits.h
@@ -75,121 +75,121 @@ struct ktermios {
 #endif
=20
 /* c_iflag bits */
-#define IUCLC	0x0200
-#define IXON	0x0400
-#define IXOFF	0x1000
-#define IMAXBEL	0x2000
-#define IUTF8   0x4000
+#define IUCLC	0x0200U
+#define IXON	0x0400U
+#define IXOFF	0x1000U
+#define IMAXBEL	0x2000U
+#define IUTF8   0x4000U
=20
 /* c_oflag bits */
-#define OLCUC	0x00002
-#define ONLCR	0x00004
-#define NLDLY	0x00100
-#define   NL0	0x00000
-#define   NL1	0x00100
-#define CRDLY	0x00600
-#define   CR0	0x00000
-#define   CR1	0x00200
-#define   CR2	0x00400
-#define   CR3	0x00600
-#define TABDLY	0x01800
-#define   TAB0	0x00000
-#define   TAB1	0x00800
-#define   TAB2	0x01000
-#define   TAB3	0x01800
-#define   XTABS	0x01800
-#define BSDLY	0x02000
-#define   BS0	0x00000
-#define   BS1	0x02000
-#define VTDLY	0x04000
-#define   VT0	0x00000
-#define   VT1	0x04000
-#define FFDLY	0x08000
-#define   FF0	0x00000
-#define   FF1	0x08000
-#define PAGEOUT 0x10000			/* SUNOS specific */
-#define WRAP    0x20000			/* SUNOS specific */
+#define OLCUC	0x00002U
+#define ONLCR	0x00004U
+#define NLDLY	0x00100U
+#define   NL0	0x00000U
+#define   NL1	0x00100U
+#define CRDLY	0x00600U
+#define   CR0	0x00000U
+#define   CR1	0x00200U
+#define   CR2	0x00400U
+#define   CR3	0x00600U
+#define TABDLY	0x01800U
+#define   TAB0	0x00000U
+#define   TAB1	0x00800U
+#define   TAB2	0x01000U
+#define   TAB3	0x01800U
+#define   XTABS	0x01800U
+#define BSDLY	0x02000U
+#define   BS0	0x00000U
+#define   BS1	0x02000U
+#define VTDLY	0x04000U
+#define   VT0	0x00000U
+#define   VT1	0x04000U
+#define FFDLY	0x08000U
+#define   FF0	0x00000U
+#define   FF1	0x08000U
+#define PAGEOUT 0x10000U		/* SUNOS specific */
+#define WRAP    0x20000U		/* SUNOS specific */
=20
 /* c_cflag bit meaning */
-#define CBAUD		0x0000100f
-#define CSIZE		0x00000030
-#define   CS5		0x00000000
-#define   CS6		0x00000010
-#define   CS7		0x00000020
-#define   CS8		0x00000030
-#define CSTOPB		0x00000040
-#define CREAD		0x00000080
-#define PARENB		0x00000100
-#define PARODD		0x00000200
-#define HUPCL		0x00000400
-#define CLOCAL		0x00000800
-#define CBAUDEX		0x00001000
+#define CBAUD		0x0000100fU
+#define CSIZE		0x00000030U
+#define   CS5		0x00000000U
+#define   CS6		0x00000010U
+#define   CS7		0x00000020U
+#define   CS8		0x00000030U
+#define CSTOPB		0x00000040U
+#define CREAD		0x00000080U
+#define PARENB		0x00000100U
+#define PARODD		0x00000200U
+#define HUPCL		0x00000400U
+#define CLOCAL		0x00000800U
+#define CBAUDEX		0x00001000U
 /* We'll never see these speeds with the Zilogs, but for completeness... */
-#define BOTHER		0x00001000
-#define     B57600	0x00001001
-#define    B115200	0x00001002
-#define    B230400	0x00001003
-#define    B460800	0x00001004
+#define BOTHER		0x00001000U
+#define     B57600	0x00001001U
+#define    B115200	0x00001002U
+#define    B230400	0x00001003U
+#define    B460800	0x00001004U
 /* This is what we can do with the Zilogs. */
-#define     B76800	0x00001005
+#define     B76800	0x00001005U
 /* This is what we can do with the SAB82532. */
-#define    B153600	0x00001006
-#define    B307200	0x00001007
-#define    B614400	0x00001008
-#define    B921600	0x00001009
+#define    B153600	0x00001006U
+#define    B307200	0x00001007U
+#define    B614400	0x00001008U
+#define    B921600	0x00001009U
 /* And these are the rest... */
-#define    B500000	0x0000100a
-#define    B576000	0x0000100b
-#define   B1000000	0x0000100c
-#define   B1152000	0x0000100d
-#define   B1500000	0x0000100e
-#define   B2000000	0x0000100f
+#define    B500000	0x0000100aU
+#define    B576000	0x0000100bU
+#define   B1000000	0x0000100cU
+#define   B1152000	0x0000100dU
+#define   B1500000	0x0000100eU
+#define   B2000000	0x0000100fU
 /* These have totally bogus values and nobody uses them
    so far. Later on we'd have to use say 0x10000x and
    adjust CBAUD constant and drivers accordingly.
-#define   B2500000	0x00001010
-#define   B3000000	0x00001011
-#define   B3500000	0x00001012
-#define   B4000000	0x00001013 */
-#define CIBAUD		0x100f0000	/* input baud rate (not used) */
+#define   B2500000	0x00001010U
+#define   B3000000	0x00001011U
+#define   B3500000	0x00001012U
+#define   B4000000	0x00001013U */
+#define CIBAUD		0x100f0000U	/* input baud rate (not used) */
=20
 /* c_lflag bits */
-#define ISIG	0x00000001
-#define ICANON	0x00000002
-#define XCASE	0x00000004
-#define ECHO	0x00000008
-#define ECHOE	0x00000010
-#define ECHOK	0x00000020
-#define ECHONL	0x00000040
-#define NOFLSH	0x00000080
-#define TOSTOP	0x00000100
-#define ECHOCTL	0x00000200
-#define ECHOPRT	0x00000400
-#define ECHOKE	0x00000800
-#define DEFECHO 0x00001000		/* SUNOS thing, what is it? */
-#define FLUSHO	0x00002000
-#define PENDIN	0x00004000
-#define IEXTEN	0x00008000
-#define EXTPROC	0x00010000
+#define ISIG	0x00000001U
+#define ICANON	0x00000002U
+#define XCASE	0x00000004U
+#define ECHO	0x00000008U
+#define ECHOE	0x00000010U
+#define ECHOK	0x00000020U
+#define ECHONL	0x00000040U
+#define NOFLSH	0x00000080U
+#define TOSTOP	0x00000100U
+#define ECHOCTL	0x00000200U
+#define ECHOPRT	0x00000400U
+#define ECHOKE	0x00000800U
+#define DEFECHO 0x00001000U		/* SUNOS thing, what is it? */
+#define FLUSHO	0x00002000U
+#define PENDIN	0x00004000U
+#define IEXTEN	0x00008000U
+#define EXTPROC	0x00010000U
=20
 /* modem lines */
-#define TIOCM_LE	0x001
-#define TIOCM_DTR	0x002
-#define TIOCM_RTS	0x004
-#define TIOCM_ST	0x008
-#define TIOCM_SR	0x010
-#define TIOCM_CTS	0x020
-#define TIOCM_CAR	0x040
-#define TIOCM_RNG	0x080
-#define TIOCM_DSR	0x100
+#define TIOCM_LE	0x001U
+#define TIOCM_DTR	0x002U
+#define TIOCM_RTS	0x004U
+#define TIOCM_ST	0x008U
+#define TIOCM_SR	0x010U
+#define TIOCM_CTS	0x020U
+#define TIOCM_CAR	0x040U
+#define TIOCM_RNG	0x080U
+#define TIOCM_DSR	0x100U
 #define TIOCM_CD	TIOCM_CAR
 #define TIOCM_RI	TIOCM_RNG
-#define TIOCM_OUT1	0x2000
-#define TIOCM_OUT2	0x4000
-#define TIOCM_LOOP	0x8000
+#define TIOCM_OUT1	0x2000U
+#define TIOCM_OUT2	0x4000U
+#define TIOCM_LOOP	0x8000U
=20
 /* ioctl (fd, TIOCSERGETLSR, &result) where result may be as below */
-#define TIOCSER_TEMT    0x01	/* Transmitter physically empty */
+#define TIOCSER_TEMT    0x01U	/* Transmitter physically empty */
=20
 /* tcsetattr uses these */
 #define TCSANOW		0
diff --git a/include/uapi/asm-generic/termbits.h b/include/uapi/asm-generic=
/termbits.h
index 890ef29053e2..10e01c77d2a6 100644
--- a/include/uapi/asm-generic/termbits.h
+++ b/include/uapi/asm-generic/termbits.h
@@ -58,88 +58,88 @@ struct ktermios {
 #define VEOL2		16
=20
 /* c_iflag bits */
-#define IUCLC	0x0200
-#define IXON	0x0400
-#define IXOFF	0x1000
-#define IMAXBEL	0x2000
-#define IUTF8	0x4000
+#define IUCLC	0x0200U
+#define IXON	0x0400U
+#define IXOFF	0x1000U
+#define IMAXBEL	0x2000U
+#define IUTF8	0x4000U
=20
 /* c_oflag bits */
-#define OLCUC	0x00002
-#define ONLCR	0x00004
-#define NLDLY	0x00100
-#define   NL0	0x00000
-#define   NL1	0x00100
-#define CRDLY	0x00600
-#define   CR0	0x00000
-#define   CR1	0x00200
-#define   CR2	0x00400
-#define   CR3	0x00600
-#define TABDLY	0x01800
-#define   TAB0	0x00000
-#define   TAB1	0x00800
-#define   TAB2	0x01000
-#define   TAB3	0x01800
-#define   XTABS	0x01800
-#define BSDLY	0x02000
-#define   BS0	0x00000
-#define   BS1	0x02000
-#define VTDLY	0x04000
-#define   VT0	0x00000
-#define   VT1	0x04000
-#define FFDLY	0x08000
-#define   FF0	0x00000
-#define   FF1	0x08000
+#define OLCUC	0x00002U
+#define ONLCR	0x00004U
+#define NLDLY	0x00100U
+#define   NL0	0x00000U
+#define   NL1	0x00100U
+#define CRDLY	0x00600U
+#define   CR0	0x00000U
+#define   CR1	0x00200U
+#define   CR2	0x00400U
+#define   CR3	0x00600U
+#define TABDLY	0x01800U
+#define   TAB0	0x00000U
+#define   TAB1	0x00800U
+#define   TAB2	0x01000U
+#define   TAB3	0x01800U
+#define   XTABS	0x01800U
+#define BSDLY	0x02000U
+#define   BS0	0x00000U
+#define   BS1	0x02000U
+#define VTDLY	0x04000U
+#define   VT0	0x00000U
+#define   VT1	0x04000U
+#define FFDLY	0x08000U
+#define   FF0	0x00000U
+#define   FF1	0x08000U
=20
 /* c_cflag bit meaning */
-#define CBAUD		0x0000100f
-#define CSIZE		0x00000030
-#define   CS5		0x00000000
-#define   CS6		0x00000010
-#define   CS7		0x00000020
-#define   CS8		0x00000030
-#define CSTOPB		0x00000040
-#define CREAD		0x00000080
-#define PARENB		0x00000100
-#define PARODD		0x00000200
-#define HUPCL		0x00000400
-#define CLOCAL		0x00000800
-#define CBAUDEX		0x00001000
-#define BOTHER		0x00001000
-#define     B57600	0x00001001
-#define    B115200	0x00001002
-#define    B230400	0x00001003
-#define    B460800	0x00001004
-#define    B500000	0x00001005
-#define    B576000	0x00001006
-#define    B921600	0x00001007
-#define   B1000000	0x00001008
-#define   B1152000	0x00001009
-#define   B1500000	0x0000100a
-#define   B2000000	0x0000100b
-#define   B2500000	0x0000100c
-#define   B3000000	0x0000100d
-#define   B3500000	0x0000100e
-#define   B4000000	0x0000100f
-#define CIBAUD		0x100f0000	/* input baud rate */
+#define CBAUD		0x0000100fU
+#define CSIZE		0x00000030U
+#define   CS5		0x00000000U
+#define   CS6		0x00000010U
+#define   CS7		0x00000020U
+#define   CS8		0x00000030U
+#define CSTOPB		0x00000040U
+#define CREAD		0x00000080U
+#define PARENB		0x00000100U
+#define PARODD		0x00000200U
+#define HUPCL		0x00000400U
+#define CLOCAL		0x00000800U
+#define CBAUDEX		0x00001000U
+#define BOTHER		0x00001000U
+#define     B57600	0x00001001U
+#define    B115200	0x00001002U
+#define    B230400	0x00001003U
+#define    B460800	0x00001004U
+#define    B500000	0x00001005U
+#define    B576000	0x00001006U
+#define    B921600	0x00001007U
+#define   B1000000	0x00001008U
+#define   B1152000	0x00001009U
+#define   B1500000	0x0000100aU
+#define   B2000000	0x0000100bU
+#define   B2500000	0x0000100cU
+#define   B3000000	0x0000100dU
+#define   B3500000	0x0000100eU
+#define   B4000000	0x0000100fU
+#define CIBAUD		0x100f0000U	/* input baud rate */
=20
 /* c_lflag bits */
-#define ISIG	0x00001
-#define ICANON	0x00002
-#define XCASE	0x00004
-#define ECHO	0x00008
-#define ECHOE	0x00010
-#define ECHOK	0x00020
-#define ECHONL	0x00040
-#define NOFLSH	0x00080
-#define TOSTOP	0x00100
-#define ECHOCTL	0x00200
-#define ECHOPRT	0x00400
-#define ECHOKE	0x00800
-#define FLUSHO	0x01000
-#define PENDIN	0x04000
-#define IEXTEN	0x08000
-#define EXTPROC	0x10000
+#define ISIG	0x00001U
+#define ICANON	0x00002U
+#define XCASE	0x00004U
+#define ECHO	0x00008U
+#define ECHOE	0x00010U
+#define ECHOK	0x00020U
+#define ECHONL	0x00040U
+#define NOFLSH	0x00080U
+#define TOSTOP	0x00100U
+#define ECHOCTL	0x00200U
+#define ECHOPRT	0x00400U
+#define ECHOKE	0x00800U
+#define FLUSHO	0x01000U
+#define PENDIN	0x04000U
+#define IEXTEN	0x08000U
+#define EXTPROC	0x10000U
=20
 /* tcsetattr uses these */
 #define	TCSANOW		0

base-commit: 83a7eefedc9b56fe7bfeff13b6c7356688ffa670
--=20
2.45.1


--e6ms7eawb5vx6rd2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmZpn8kACgkQnowa+77/
2zIB6Q//dm4CAgj/fmsra3YvXM3xqeLVhmFkH81GUnWxzD21jBBAeuvSWq1nipCu
p7OP431Y67yfXxru+pD7ntCluifVjhYVcJMjeYN2Wqyw2mS2iLdz38C9mLVfO5Hn
CM6NuQda/0qE3t+jt/TnW1PI50L1q31zT+CwC0rBNsmQGQfQgB4AgyfMnQjP4Rre
zyWJDOUUyzrhLBtwIn6YhmaBPgN7yaUn66KECNgaspXiO0D2aOilXFiiMwauH4iq
Pc9nO1HQyGeDLK2P8B2dJuhJqYSvRJ0AYrhLc8WvZKxYQ78L6IT2IDIr/eUIwt5K
ZxRI1AugFXoAlBUDJ0p58muLfZ2Pei+oG8iXqCgD3h5LTXSWdamfF5NKbSOcZGXC
NDLZusJARsrcwNIS5SYutfMGRwojZNMKX6F9gUgeWsLvcIszbiOkDPi+m23ljFbd
VB8cUdsywSBWj+1RVpkd7UFKr3a0KW5EDic7QRiRiPmeTK1cTYb3gVv2XDWVrB4J
U5IqpfFTY64uf8eZH39mGpkpsM90bedtzjbePMXeigf2NZsOjGNETPRAfFdV289W
kufUH5CBC7jmcGI6ij54+lsQZUIxVbjyGsErLbuXypy/YW8EOLVXrrJLQ+4CJOpH
jcjJeRUBosm1TAe+G8DaCOI6XOj+aEY9JOku19KBZigHwpUU924=
=xRTQ
-----END PGP SIGNATURE-----

--e6ms7eawb5vx6rd2--


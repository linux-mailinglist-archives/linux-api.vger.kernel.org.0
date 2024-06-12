Return-Path: <linux-api+bounces-1717-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C8D3F905252
	for <lists+linux-api@lfdr.de>; Wed, 12 Jun 2024 14:22:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCD4E1C20EA9
	for <lists+linux-api@lfdr.de>; Wed, 12 Jun 2024 12:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66C0F16F0E8;
	Wed, 12 Jun 2024 12:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sFY6pjyn"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E5D8374D3;
	Wed, 12 Jun 2024 12:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718194960; cv=none; b=BDIPKhZxppEssB417vkI2ZmEVbv1mZDC4SCfnYPmMLPqvU22YjqZ4+yeciEU2GR6aZYUPVgRGNwUv1edKvuuYQdi7lqUgQ8uNhprBc/CIVVktZoU/NIV5KG5D3MLnyTyZfnvaXkijImO/cFhss0gpIp/bVBXiN86gXnHuMVc/Bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718194960; c=relaxed/simple;
	bh=qbFND/Ro01eQtK5LORne0ghx/WmI7xLwoEUn4sphFYY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aWyrLI+TOUBxsZ+R3FcOAf0Go1kiwWVH5YkQ9tZx31bniRa9tIMU84RhSLi8/ABRbG0IQf0zzlSlt3CRcu5dfvs0HSsTZ4F7ud8AETBrFPVemES5UZP6HDXAKwS5jNGhSmeTgIFEiUto9n5/VxDhl/Dsp8EPOzroQor3b6UWSns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sFY6pjyn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 596C0C3277B;
	Wed, 12 Jun 2024 12:22:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718194959;
	bh=qbFND/Ro01eQtK5LORne0ghx/WmI7xLwoEUn4sphFYY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sFY6pjynWWKoMvBRwcC8rubwiX2lUJ7gxL14hNcnZ3D1dY4g1DEN6+SZmFe8IMmom
	 aHrymqkeMuRM9BfZsz8T76QoSzxnDzoQekfYW+VssgxIOPEhH92f18ONZ3s0cFURTW
	 ki3xmi6vqFACUl95nTWG9pFpXkMqJn3tQKBQd9so=
Date: Wed, 12 Jun 2024 14:22:37 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Alejandro Colomar <alx@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Palmer Dabbelt <palmer@rivosinc.com>, linux-api@vger.kernel.org,
	libc-alpha@sourceware.org, linux-man@vger.kernel.org
Subject: Re: termios constants should be unsigned
Message-ID: <2024061222-scuttle-expanse-6438@gregkh>
References: <a7kfppfptkzvqys6cblwjudlpoghsycjglw57hxe2ywvruzkbd@e6nqpnxgwfnq>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a7kfppfptkzvqys6cblwjudlpoghsycjglw57hxe2ywvruzkbd@e6nqpnxgwfnq>

On Wed, Jun 12, 2024 at 02:16:12PM +0200, Alejandro Colomar wrote:
> Hi!
> 
> While compiling an example program in ioctl_tty(2) examples (now moving
> to TCSETS(2const)), I saw several warnings:
> 
> tcgets.c:53:24: error: implicit conversion changes signedness: 'int' to 'tcflag_t' (aka 'unsigned int') [clang-diagnostic-sign-conversion,-warnings-as-errors]
>         tio.c_cflag &= ~CBAUD;
>                     ~~ ^~~~~~
> tcgets.c:53:24: warning: use of a signed integer operand with a binary bitwise operator [hicpp-signed-bitwise]
>         tio.c_cflag &= ~CBAUD;
>                     ~~ ^~~~~~
> tcgets.c:58:24: error: implicit conversion changes signedness: 'int' to 'tcflag_t' (aka 'unsigned int') [clang-diagnostic-sign-conversion,-warnings-as-errors]
>         tio.c_cflag &= ~(CBAUD << IBSHIFT);
>                     ~~ ^~~~~~~~~~~~~~~~~~~
> tcgets.c:58:24: warning: use of a signed integer operand with a binary bitwise operator [hicpp-signed-bitwise]
>         tio.c_cflag &= ~(CBAUD << IBSHIFT);
>                     ~~ ^~~~~~~~~~~~~~~~~~~
> tcgets.c:58:25: warning: use of a signed integer operand with a unary bitwise operator [hicpp-signed-bitwise]
>         tio.c_cflag &= ~(CBAUD << IBSHIFT);
>                        ~^~~~~~~~~~~~~~~~~~
> 
> Which seem reasonable warnings.  Bitwise operations on signed integers
> is bad for ye health.  Let's see the definitions of struct termios:
> 
> 	alx@debian:/usr/include$ grepc termios x86_64-linux-gnu/ asm-generic/
> 	x86_64-linux-gnu/bits/termios-struct.h:struct termios
> 	  {
> 	    tcflag_t c_iflag;		/* input mode flags */
> 	    tcflag_t c_oflag;		/* output mode flags */
> 	    tcflag_t c_cflag;		/* control mode flags */
> 	    tcflag_t c_lflag;		/* local mode flags */
> 	    cc_t c_line;			/* line discipline */
> 	    cc_t c_cc[NCCS];		/* control characters */
> 	    speed_t c_ispeed;		/* input speed */
> 	    speed_t c_ospeed;		/* output speed */
> 	#define _HAVE_STRUCT_TERMIOS_C_ISPEED 1
> 	#define _HAVE_STRUCT_TERMIOS_C_OSPEED 1
> 	  };
> 	asm-generic/termbits.h:struct termios {
> 		tcflag_t c_iflag;		/* input mode flags */
> 		tcflag_t c_oflag;		/* output mode flags */
> 		tcflag_t c_cflag;		/* control mode flags */
> 		tcflag_t c_lflag;		/* local mode flags */
> 		cc_t c_line;			/* line discipline */
> 		cc_t c_cc[NCCS];		/* control characters */
> 	};
> 
> Except for the speed members, they seem the same.  The types of the
> members are correctly unsigned:
> 
> 	alx@debian:/usr/include$ grepc tcflag_t x86_64-linux-gnu/ asm-generic/
> 	x86_64-linux-gnu/bits/termios.h:typedef unsigned int	tcflag_t;
> 	asm-generic/termbits.h:typedef unsigned int	tcflag_t;
> 
> So, all of the constants that are to be used in these members, which
> will undergo bitwise operations, should use the U suffix.  Here's the
> list for the UAPI:
> 
> 	$ sed -n '/flag bits/,/^$/p' asm-generic/termbits.h
> 	/* c_iflag bits */
> 	#define IUCLC	0x0200
> 	#define IXON	0x0400
> 	#define IXOFF	0x1000
> 	#define IMAXBEL	0x2000
> 	#define IUTF8	0x4000
> 
> 	/* c_oflag bits */
> 	#define OLCUC	0x00002
> 	#define ONLCR	0x00004
> 	#define NLDLY	0x00100
> 	#define   NL0	0x00000
> 	#define   NL1	0x00100
> 	#define CRDLY	0x00600
> 	#define   CR0	0x00000
> 	#define   CR1	0x00200
> 	#define   CR2	0x00400
> 	#define   CR3	0x00600
> 	#define TABDLY	0x01800
> 	#define   TAB0	0x00000
> 	#define   TAB1	0x00800
> 	#define   TAB2	0x01000
> 	#define   TAB3	0x01800
> 	#define   XTABS	0x01800
> 	#define BSDLY	0x02000
> 	#define   BS0	0x00000
> 	#define   BS1	0x02000
> 	#define VTDLY	0x04000
> 	#define   VT0	0x00000
> 	#define   VT1	0x04000
> 	#define FFDLY	0x08000
> 	#define   FF0	0x00000
> 	#define   FF1	0x08000
> 
> 	/* c_lflag bits */
> 	#define ISIG	0x00001
> 	#define ICANON	0x00002
> 	#define XCASE	0x00004
> 	#define ECHO	0x00008
> 	#define ECHOE	0x00010
> 	#define ECHOK	0x00020
> 	#define ECHONL	0x00040
> 	#define NOFLSH	0x00080
> 	#define TOSTOP	0x00100
> 	#define ECHOCTL	0x00200
> 	#define ECHOPRT	0x00400
> 	#define ECHOKE	0x00800
> 	#define FLUSHO	0x01000
> 	#define PENDIN	0x04000
> 	#define IEXTEN	0x08000
> 	#define EXTPROC	0x10000
> 
> And glibc also (re)defines some of them, so those should also have the
> U suffix.
> 
> Any opinions?

Have a proposed patch that you feel would resolve this?

thanks,

greg k-h


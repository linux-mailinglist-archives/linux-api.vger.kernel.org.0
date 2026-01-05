Return-Path: <linux-api+bounces-5582-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 800FACF402E
	for <lists+linux-api@lfdr.de>; Mon, 05 Jan 2026 15:03:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2801D309B90D
	for <lists+linux-api@lfdr.de>; Mon,  5 Jan 2026 13:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0E7928A3EF;
	Mon,  5 Jan 2026 13:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="awVo1mAf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="zlLc/Y/m"
X-Original-To: linux-api@vger.kernel.org
Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA6A18DF9D;
	Mon,  5 Jan 2026 13:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767621086; cv=none; b=t9gZmfSLPR++kS5HguROuMZFkxzmJ5WWKaXg3PbE6O3UcuzWehlm9N//pVlDet3PeF6rPW340tC4U83iwuvoEzfW+azz7AOTvbwL3/KgZFqCoVrU7yRlS3sh8bEsIFM7jAEhNfos8il5MKJg/jZMDiNNbhUMZDuAmjPzVdM8THU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767621086; c=relaxed/simple;
	bh=IKErK3v3+OJFUgMlbsdsoqJuzcwJNmTotQ9kPOCMZCU=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=O7ilmk3dYzAwEISv4V8H8SEoxtkXMcJHF1w4nnqGT2rpaDMuNB3u9lH5px2ni9g1Kncv6VQucnmIMA1DXLnHGQ9Op7AYZNXiAPb5AIUcOAHZ9+WXtEnZqOoT9FuB7PZM2rJQOSytfIPzvZQ2YRmZBcCXhGTviNEAYdAeai5SsV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=awVo1mAf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=zlLc/Y/m; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id BF60E1D00060;
	Mon,  5 Jan 2026 08:51:22 -0500 (EST)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-04.internal (MEProxy); Mon, 05 Jan 2026 08:51:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1767621082;
	 x=1767707482; bh=fHLm8E0DD8DK2Ui3Iadzy1j2olr1Mcb99KVTQsepQjE=; b=
	awVo1mAfN73HO27QvZiXTmGm+mL3IM7qvca5FL+UOrWjk5O3Bj79z0XzJvcY0ZDw
	Rgz+o1ZbAFVr0Vu4t3gwIL8vThRkpaFepaDBHFc4mhFUh3xGbgV2P/7zJMblWy1T
	aa0kPYhuZQa2bVJq7m7eUeV39Fl35MlMhdhqZ25yqk6bM/9GIQ849/3HzHUtV0e3
	UI6l2bnTU/2IlsvTepuy7vKYNBA8jkkZFm5gbqIBNPyL3wd+z/IxfsmkblIVoygv
	XIItUilx+JcCeeIXyCu9VbD3r5L29qtE/LSrUJW2mIEyhhQHJ4avNdEphMbXuXtE
	+iQwl8BVcg5esgVnuMjl6A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1767621082; x=
	1767707482; bh=fHLm8E0DD8DK2Ui3Iadzy1j2olr1Mcb99KVTQsepQjE=; b=z
	lLc/Y/m9c/S8OrCANM6zX22UMaBocXwOOFXRo3XAsHrV1nrQjYYqCPj9OliwIMEd
	xC/H+x3cvtCDuFTMqv+TvVvE7Qq+Z05PrbSAUomsJcEQfawKcRpLLAkgiTUxFyK3
	r5zcsrDZ8bXuH8kuEdDmUHO/6pPSEBCmKv54d/8UxfkE5G20aeqKtbHEB52gNOpD
	NSAkyOyENt8i5JVoIJCYsJyD7gpreuBjo/tijgZiY0VMZRWgtb6vf52fc890v11K
	mjhEehcRn3bHp5slGIVU1U0ZZ2lJv3iCrvoJUCuM/IdbjmzHOTpGyui1K0YkEyVw
	Hq7Asj8qbp0ZF4kO+Uatg==
X-ME-Sender: <xms:2sFbabQJe4UFNW61mcGf8h1fCB6LJGzEiZFB24vJzmf9vyLEDvsaig>
    <xme:2sFbaXmtmUX-vGZhdJRWhNV2u_I8iX4Tl1xElnXfhqzmI7LCCJdXG5A4JnL7uFhDp
    MPHpp49D0JIJoM22v_reP-rKp3AFoPdU4ARg8Z12aj9NIbxoACe8ORo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeljeegjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdetrhhnugcu
    uegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtthgvrh
    hnpedvhfdvkeeuudevfffftefgvdevfedvleehvddvgeejvdefhedtgeegveehfeeljeen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnug
    esrghrnhgusgdruggvpdhnsggprhgtphhtthhopedufedpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhope
    hkuhhnihihuhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepfihilhhlvghmsgesghho
    ohhglhgvrdgtohhmpdhrtghpthhtohepuggrlhhirghssehlihgstgdrohhrghdprhgtph
    htthhopegrughhvghmvghrvhgrlhdriigrnhgvlhhlrgeslhhinhgrrhhordhorhhgpdhr
    tghpthhtohepthhhohhmrghsrdifvghishhsshgthhhuhheslhhinhhuthhrohhnihigrd
    guvgdprhgtphhtthhopegtrghrlhhoshesrhgvughhrghtrdgtohhmpdhrtghpthhtohep
    phgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopehlihgstgdqrghlphhhrg
    esshhouhhrtggvfigrrhgvrdhorhhg
X-ME-Proxy: <xmx:2sFbaeDZLOD4mOW7tlVVNEqSVoqkS6uDNjdtAA4h6BgsUhVJkl05Pg>
    <xmx:2sFbacP3HXfTUCE9Ym1_TvOJ81ukFo8Y9TyQsQymLtxsEzTQcKU1cA>
    <xmx:2sFbaaP9lu0Nq7-aUUx4FLK5JRU7xctGqMp-S9vuaRNQkx0bSZscfA>
    <xmx:2sFbaeK37i3RkfHgFW5CKHK3AdzNtJgBRhBxQxDa225eQWm94KfzWw>
    <xmx:2sFbadWpuKdpFVM8LYIdAU2ElK98MJ15N-9Df-lRItspeLd2XSJGxf8E>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 1959A700065; Mon,  5 Jan 2026 08:51:22 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AWxaZBYfOtsV
Date: Mon, 05 Jan 2026 14:50:36 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 "Eric Dumazet" <edumazet@google.com>,
 "Kuniyuki Iwashima" <kuniyu@google.com>, "Paolo Abeni" <pabeni@redhat.com>,
 "Willem de Bruijn" <willemb@google.com>, libc-alpha@sourceware.org,
 "Carlos O'Donell" <carlos@redhat.com>,
 "Adhemerval Zanella" <adhemerval.zanella@linaro.org>,
 "Rich Felker" <dalias@libc.org>
Cc: Netdev <netdev@vger.kernel.org>, linux-kernel@vger.kernel.org,
 linux-api@vger.kernel.org, klibc@zytor.com
Message-Id: <934ca004-0aef-49a4-a4f1-3d39a2e71864@app.fastmail.com>
In-Reply-To: <20260105-uapi-sockaddr-v1-1-b7653aba12a5@linutronix.de>
References: <20260105-uapi-sockaddr-v1-1-b7653aba12a5@linutronix.de>
Subject: Re: [PATCH net-next] net: uapi: Provide an UAPI definition of 'struct
 sockaddr'
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 5, 2026, at 09:25, Thomas Wei=C3=9Fschuh wrote:
> Various UAPI headers reference 'struct sockaddr'. Currently the
> definition of this struct is pulled in from the libc header
> sys/socket.h. This is problematic as it introduces a dependency
> on a full userspace toolchain.
>
> Instead expose a custom but compatible definition of 'struct sockaddr'
> in the UAPI headers. It is guarded by the libc compatibility
> infrastructure to avoid potential conflicts.
>
> The compatibility symbol won't be supported by glibc right away,
> but right now __UAPI_DEF_IF_IFNAMSIZ is not supported either,
> so including the libc headers before the UAPI headers is broken anyway=
s.
>
> Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>

This looks like the right approach to me. I have previously
tried to introduce a 'struct __kernel_sockaddr' structure and
use that in uapi headers in place of the libc sockaddr, but
that seemed worse in the end, and introduce the same problems
as using the existing __kernel_sockaddr_storage.

The version that worked for my own testing used a nolibc specific
definition, which was enough for me to build-test the kernel headers
across all architectures, but it does not resolve the dependency.

What I'm not sure about is whether the added definition will
cause problems for users that include linux/socket.h (or one
of the headers using it) before including sys/socket.h.
I would expect that this causes build failures on some application
source code, but hopefully in a way that is easily fixable by
changing the include order.
I've added the libc-alpha list to Cc, along with a few
developers that care about this.

I also found a few older commits in which we've tried to work
this out in the past, but each time created a new (or old) problem:

57a87bb0720a ("[PATCH] scrub non-__GLIBC__ checks in linux/socket.h and =
linux/stat.h")
304c209c9b02 ("[NET]: Revert socket.h/stat.h ifdef hacks.")
9c501935a3cd ("net: Support inclusion of <linux/socket.h> before <sys/so=
cket.h>")
2618be7dccf8 ("uapi: fix linux/if.h userspace compilation errors")
22bbc1dcd0d6 ("vsock/uapi: fix linux/vm_sockets.h userspace compilation =
errors")
06e445f740c1 ("mptcp: fix conflict with <netinet/in.h>")
c11c5906bc0a ("mptcp: add MPTCP_SUBFLOW_ADDRS getsockopt support")

      Arnd

> ---
>  include/linux/socket.h           | 10 ----------
>  include/uapi/linux/if.h          |  4 ----
>  include/uapi/linux/libc-compat.h | 12 ++++++++++++
>  include/uapi/linux/socket.h      | 14 ++++++++++++++
>  4 files changed, 26 insertions(+), 14 deletions(-)
>
> diff --git a/include/linux/socket.h b/include/linux/socket.h
> index ec715ad4bf25..8363d4e0a044 100644
> --- a/include/linux/socket.h
> +++ b/include/linux/socket.h
> @@ -28,16 +28,6 @@ extern void socket_seq_show(struct seq_file *seq);
>=20
>  typedef __kernel_sa_family_t	sa_family_t;
>=20
> -/*
> - *	1003.1g requires sa_family_t and that sa_data is char.
> - */
> -
> -/* Deprecated for in-kernel use. Use struct sockaddr_unsized instead.=
 */
> -struct sockaddr {
> -	sa_family_t	sa_family;	/* address family, AF_xxx	*/
> -	char		sa_data[14];	/* 14 bytes of protocol address	*/
> -};
> -
>  /**
>   * struct sockaddr_unsized - Unspecified size sockaddr for callbacks
>   * @sa_family: Address family (AF_UNIX, AF_INET, AF_INET6, etc.)
> diff --git a/include/uapi/linux/if.h b/include/uapi/linux/if.h
> index 797ba2c1562a..a4bc54196a07 100644
> --- a/include/uapi/linux/if.h
> +++ b/include/uapi/linux/if.h
> @@ -25,10 +25,6 @@
>  #include <linux/socket.h>		/* for "struct sockaddr" et al	*/
>  #include <linux/compiler.h>		/* for "__user" et al           */
>=20
> -#ifndef __KERNEL__
> -#include <sys/socket.h>			/* for struct sockaddr.		*/
> -#endif
> -
>  #if __UAPI_DEF_IF_IFNAMSIZ
>  #define	IFNAMSIZ	16
>  #endif /* __UAPI_DEF_IF_IFNAMSIZ */
> diff --git a/include/uapi/linux/libc-compat.h b/include/uapi/linux/lib=
c-compat.h
> index 0eca95ccb41e..13a06ce4e825 100644
> --- a/include/uapi/linux/libc-compat.h
> +++ b/include/uapi/linux/libc-compat.h
> @@ -140,6 +140,13 @@
>=20
>  #endif /* _NETINET_IN_H */
>=20
> +/* Definitions for socket.h */
> +#if defined(_SYS_SOCKET_H)
> +#define __UAPI_DEF_SOCKADDR		0
> +#else
> +#define __UAPI_DEF_SOCKADDR		1
> +#endif
> +
>  /* Definitions for xattr.h */
>  #if defined(_SYS_XATTR_H)
>  #define __UAPI_DEF_XATTR		0
> @@ -221,6 +228,11 @@
>  #define __UAPI_DEF_IP6_MTUINFO		1
>  #endif
>=20
> +/* Definitions for socket.h */
> +#ifndef __UAPI_DEF_SOCKADDR
> +#define __UAPI_DEF_SOCKADDR		1
> +#endif
> +
>  /* Definitions for xattr.h */
>  #ifndef __UAPI_DEF_XATTR
>  #define __UAPI_DEF_XATTR		1
> diff --git a/include/uapi/linux/socket.h b/include/uapi/linux/socket.h
> index d3fcd3b5ec53..35d7d5f4b1a8 100644
> --- a/include/uapi/linux/socket.h
> +++ b/include/uapi/linux/socket.h
> @@ -2,6 +2,8 @@
>  #ifndef _UAPI_LINUX_SOCKET_H
>  #define _UAPI_LINUX_SOCKET_H
>=20
> +#include <linux/libc-compat.h>          /* for compatibility with gli=
bc */
> +
>  /*
>   * Desired design of maximum size and alignment (see RFC2553)
>   */
> @@ -26,6 +28,18 @@ struct __kernel_sockaddr_storage {
>  	};
>  };
>=20
> +/*
> + *	1003.1g requires sa_family_t and that sa_data is char.
> + */
> +
> +/* Deprecated for in-kernel use. Use struct sockaddr_unsized instead.=
 */
> +#if __UAPI_DEF_SOCKADDR
> +struct sockaddr {
> +	__kernel_sa_family_t	sa_family;	/* address family, AF_xxx	*/
> +	char			sa_data[14];	/* 14 bytes of protocol address	*/
> +};
> +#endif /* __UAPI_DEF_SOCKADDR */
> +
>  #define SOCK_SNDBUF_LOCK	1
>  #define SOCK_RCVBUF_LOCK	2
>=20
>
> ---
> base-commit: dbf8fe85a16a33d6b6bd01f2bc606fc017771465
> change-id: 20251222-uapi-sockaddr-cf10e7624729
>
> Best regards,
> --=20
> Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>


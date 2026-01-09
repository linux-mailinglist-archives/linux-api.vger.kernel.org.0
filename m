Return-Path: <linux-api+bounces-5615-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E641AD0A14A
	for <lists+linux-api@lfdr.de>; Fri, 09 Jan 2026 13:57:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B71A03023846
	for <lists+linux-api@lfdr.de>; Fri,  9 Jan 2026 12:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD32135BDC2;
	Fri,  9 Jan 2026 12:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="XKTohk/s";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ioWgNqoa"
X-Original-To: linux-api@vger.kernel.org
Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD64435B12D;
	Fri,  9 Jan 2026 12:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767963422; cv=none; b=MxTiyEHOISJWfvWdu1o57Kt5BniFJ50IpCrUUKjsPYtEtW+mUUf9YduKSlHgNuFhjxWo3F4gfYTN/ksfKaW+QDu2uwPvYoc3QtJI7nUm4Ic7m9KA7fBaWj8/3MyaIcOzBYbl91Kv3pdpQO2V18Fi/TR4v+7H6yCrvIntjFvfTaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767963422; c=relaxed/simple;
	bh=Kp0RwFdCBdnuB46/flEv9Dh9JhHksIqh82e/4llgg7c=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=lgDH9FvcUtGnH+QHANGeDt+qtQGPCu/dWLIeGJuPq5NJy4xeZas+8cWxCtP1gG6WPCAl6und5naR4QA7+2ZnDDAQLFTgV6glAlQfx1Zf8WHmBBFMW9meeGjTGCja6HpEiQrmWLwnMv7a17v+Vbf7ZHcJkPEAkOzalf7l4jMnQqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=XKTohk/s; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ioWgNqoa; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id BE8301D00188;
	Fri,  9 Jan 2026 07:56:59 -0500 (EST)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-04.internal (MEProxy); Fri, 09 Jan 2026 07:57:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1767963419;
	 x=1768049819; bh=psBZL7blWQ9lVNHmasEs5k+vU16IFZJJ9djtnqGuCbo=; b=
	XKTohk/sKw+Ww6lg47Vd8HxIzniEKmegYgTR5ShfqR5RJd1O+XYas674b3HurvNc
	hXZItOzX3XFlnJj/KL86+wSsDdTepyXZqUSZ6H+n81+qPsziu9DQ2+ftaAZ/j7hx
	qFAf8jSHvMiOBMhysTbqhcHEufKHoHzPpTJJjHEPhhiRrPgsVsJItWI4SuDBG5uR
	Js+bH+mNdT90ouzvdKfeIiO55iPj6FRzdgpoolK0BTUHEja4K3zl1Er25wvbqrGs
	VZwh1NybeW4WwzfQCon2Kd3uSRsrJxfMUNcR3SdLZBRNfnHqwECnCRrP4BtiQZ+D
	2RnZeNGmEWpNn0K+HqApgA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1767963419; x=
	1768049819; bh=psBZL7blWQ9lVNHmasEs5k+vU16IFZJJ9djtnqGuCbo=; b=i
	oWgNqoauWIpdApCVfCXbeYUFTgpEpSglsq56JEJRDyxH+vUAFIVtgwhv+6bb9oTz
	botZ7XToAyZsfoqProNIbNN5RbDCOBOD2YZBQbGWVS/GdIQ4/d19XqsZLhNWnbQC
	bKaPp8TltviDCtrv6G000CmW/rLphvYJAQ0b2DB61XWD1RuSvBo2mpoyL7UjXVJj
	UYVirEtAccRquV0VCSfv0KbZN1AT9Mte6aQ52Q6EBkf9F3D8LXITWjU7YjSC2Zdj
	jrt31QijcDZWuqILFFpywEpHtBpXJWDKivpVbq7rMNWIyR7US/3zEbiTEshOfJSC
	oC30/liz4j62Dc4GBYQ5Q==
X-ME-Sender: <xms:G_tgaVqOmnesEfaHAJm6T3dMYQqTlQbBrKaf4yKdzX1Ctu5r8tPsYg>
    <xme:G_tgaSdMOuvlZb-FIJ_dmrTHSdf-iIoCepW3NUdnT4eQ2ZlHrnvpaR8LRwYOxkycC
    AtZ3fVGiu63V0ldvcgpV9-6jS0lPHQqfWQhN6bOCv8Bv_096AM1pjo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutdekkeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedftehrnhgu
    uceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvg
    hrnhepledufeevudfgueejtdfhteelteekveffffehudeftedvgeeukedvleeukeeuieef
    necuffhomhgrihhnpehlihhnuhigrdguvghvpdguvggsihgrnhdrnhgvthenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgu
    sgdruggvpdhnsggprhgtphhtthhopeelpdhmohguvgepshhmthhpohhuthdprhgtphhtth
    hopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepkhhunhhihihu
    sehgohhoghhlvgdrtghomhdprhgtphhtthhopeifihhllhgvmhgssehgohhoghhlvgdrtg
    homhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthhh
    ohhmrghsrdifvghishhsshgthhhuhheslhhinhhuthhrohhnihigrdguvgdprhgtphhtth
    hopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtoheplhhinhhugidqrghp
    ihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnh
    gvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehnvghtuggvvhesvhhg
    vghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:G_tgacLdE4eNfvvsENn6rWpR7BM3WBoBBQELU5McBmAJOZBZhP_pZA>
    <xmx:G_tgaYueVX8bKJIPkvJD4F4q1WYprbSohPScCFqt_2R2rTEpoIyPMw>
    <xmx:G_tgaRKcr0nUfVxaVmsCIbo3JK5sskbWSpqarI2tcsuhTM7kSdHdCw>
    <xmx:G_tgaQOhCtMmMSWXSkUxxuzpNi_j3C0-mCDvKCV2T1aAKkmkAkUqYQ>
    <xmx:G_tgaXI1iC5jtaE1KMf1zUUNCI_KX9B69xb5jc1okxU0HDUoU2KjDf6E>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 5B499700065; Fri,  9 Jan 2026 07:56:59 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AWxaZBYfOtsV
Date: Fri, 09 Jan 2026 13:56:38 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Jakub Kicinski" <kuba@kernel.org>,
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: "Eric Dumazet" <edumazet@google.com>,
 "Kuniyuki Iwashima" <kuniyu@google.com>, "Paolo Abeni" <pabeni@redhat.com>,
 "Willem de Bruijn" <willemb@google.com>, Netdev <netdev@vger.kernel.org>,
 linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Message-Id: <06cf1396-c100-45ba-8b46-edb4ed4feb62@app.fastmail.com>
In-Reply-To: <20260106151313.1f8bd508@kernel.org>
References: <20260105-uapi-sockaddr-v1-1-b7653aba12a5@linutronix.de>
 <20260105095713.0b312b26@kernel.org>
 <20260106112714-d47c16e0-0020-4851-9c2a-f8849c9a0677@linutronix.de>
 <20260106151313.1f8bd508@kernel.org>
Subject: Re: [PATCH net-next] net: uapi: Provide an UAPI definition of 'struct
 sockaddr'
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 7, 2026, at 00:13, Jakub Kicinski wrote:
> On Tue, 6 Jan 2026 11:32:52 +0100 Thomas Wei=C3=9Fschuh wrote:
>> As for the failure in netdev CI however I am not so sure.
>> Looking at net-next-2026-01-05--12-00, the only failures triggered by=
 my
>> change are also the ones from the bpf-ci. Are these the ones you mean=
t,
>> or am I missing some others?
>
> Multiple things broke at once so slightly hard to fish the relevant
> stuff out from here:
>
> https://netdev.bots.linux.dev/contest.html?branch=3Dnet-next-2026-01-0=
5--15-00&pass=3D0&pw-n=3D0
>
> Here's one:
>
> make[1]: Entering directory=20
> '/home/virtme/testing/wt-3/tools/testing/selftests/net'
>   CC       busy_poller
> In file included from [01m[K/usr/include/sys/socket.h:33[m[K,
>                  from [01m[K/usr/include/netinet/in.h:23[m[K,
>                  from [01m[K/usr/include/arpa/inet.h:22[m[K,
>                  from [01m[Kbusy_poller.c:14[m[K:
> [01m[K/usr/include/bits/socket.h:182:8:[m[K [01;31m[Kerror:=20
> [m[Kredefinition of '[01m[Kstruct sockaddr[m[K'

>                  from [01m[Kbusy_poller.c:12[m[K:
> [01m[K/home/virtme/testing/wt-3/usr/include/linux/socket.h:37:8:[m[K=20
> [01;36m[Knote: [m[Koriginally defined here

Maybe we can change all the instances of 'struct sockaddr' in
include/uapi/ to reference a new 'struct __kernel_sockaddr',
and then redirect that one if the libc header got included
first?

struct __kernel_sockaddr {
       __kernel_sa_family_t    sa_family;      /* address family, AF_xxx=
       */
       char sa_data_min[14];           /* Minimum 14 bytes of protocol a=
ddress */
};
#ifdef _SYS_SOCKET_H
#define __kernel_sockaddr sockaddr
#endif

This will still fail when a user application includes linux/if.h
before sys/socket.h and then expects the structures in linux/if.h
to contain the libc version of sockaddr, but hopefully that is
much rarer. A survey of codesearch.debian.net shows almost all
users of linux/if.h first including sys/socket.h, and most of
them not caring about struct sockaddr either.

      Arnd


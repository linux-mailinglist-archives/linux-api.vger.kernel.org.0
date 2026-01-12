Return-Path: <linux-api+bounces-5618-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DB24D1268B
	for <lists+linux-api@lfdr.de>; Mon, 12 Jan 2026 12:55:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8279A301F7D1
	for <lists+linux-api@lfdr.de>; Mon, 12 Jan 2026 11:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9EB33557FF;
	Mon, 12 Jan 2026 11:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mhQZ4rMh";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7oLTu7n8"
X-Original-To: linux-api@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF592192FA;
	Mon, 12 Jan 2026 11:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768218911; cv=none; b=hFizttOT08jaq3h3wfG0OjSwYmswgqiqRk8G72ldo3fe1K2NLpezLO/oF1mOAp82P4xQ7Z/AF0A236WT4g5m9BHYFNrXF65ItOQADy2SPd52UG6z4kxGLz3JomgYatwORAFjq6HwSHYQPLHCJ75lZkGE4YyjHhjUD+84Umr31Sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768218911; c=relaxed/simple;
	bh=ff2c4seFNqqSOZeD0/V10ockhEDIzrtnKxYNVpTZrjM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SCnEsXYnCXAeFtx7QiO2C3V+k8HOEDkOePwSiL6T6mWCt42iPu7n4ss8xKRnVqkrrA2tiqZH5/QFoJlDn+DYq5q07tp4R8X3VijRVIlsgL5B8yxRbRaVAkjxTbZoOy0RWRTj8UYS4VUH152nT7JxYDYcspyKgKhDxeIm9wO1Ryc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mhQZ4rMh; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=7oLTu7n8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 12 Jan 2026 12:55:07 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768218908;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8QxeZleMm6bdYwjHvvy5EQwjVfPCU4KLMEiBD0CSJnY=;
	b=mhQZ4rMhu0irZLfRFnkGTQWLOoKabgfGOUalQFFCxDQPk7KpWWrFWJtXf4oTBSoQlfWqtw
	lqBtEiQTAL66/Ec5vSDAND37A313U8TT7WVyvycs04Lj0bBjc4v+S4ntuAsc19qL/g3czA
	iQD8oJsa7YhRVd2+I2Q9Gg3Jy9ksFUhWWi/vL2nTJh0Ox9yaZHLGLVz51JQGlTvbUWGWNm
	/6wwfuX2IWP9ry5W5liTM+UFWr//E1OwgNnAava99akhkturv+12f2+4f6UI87RhQ8TgoF
	2OKGQMxTh024vUBcYh9txYxCy79/RKa9OLzF+H4INALcJPEQtBs4SFaXHyynRQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768218908;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8QxeZleMm6bdYwjHvvy5EQwjVfPCU4KLMEiBD0CSJnY=;
	b=7oLTu7n8p6O6EfEsXumqSnq7WHO96nNCVqV9vawG8kzRwvfNmf22N6zvLtRnbamXxTo7wj
	ki35VpGmzf2prYCg==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Florian Weimer <fweimer@redhat.com>, Arnd Bergmann <arnd@arndb.de>
Cc: Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, Netdev <netdev@vger.kernel.org>, linux-kernel@vger.kernel.org, 
	linux-api@vger.kernel.org
Subject: Re: [PATCH net-next] net: uapi: Provide an UAPI definition of
 'struct sockaddr'
Message-ID: <20260112124604-dbf7f68d-2182-438f-9495-2931cac02a81@linutronix.de>
References: <20260105-uapi-sockaddr-v1-1-b7653aba12a5@linutronix.de>
 <20260105095713.0b312b26@kernel.org>
 <20260106112714-d47c16e0-0020-4851-9c2a-f8849c9a0677@linutronix.de>
 <20260106151313.1f8bd508@kernel.org>
 <06cf1396-c100-45ba-8b46-edb4ed4feb62@app.fastmail.com>
 <lhu7btnkqg6.fsf@oldenburg.str.redhat.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <lhu7btnkqg6.fsf@oldenburg.str.redhat.com>

On Mon, Jan 12, 2026 at 12:42:17PM +0100, Florian Weimer wrote:
> * Arnd Bergmann:
> 
> > On Wed, Jan 7, 2026, at 00:13, Jakub Kicinski wrote:
> >> On Tue, 6 Jan 2026 11:32:52 +0100 Thomas Weißschuh wrote:
> >>> As for the failure in netdev CI however I am not so sure.
> >>> Looking at net-next-2026-01-05--12-00, the only failures triggered by my
> >>> change are also the ones from the bpf-ci. Are these the ones you meant,
> >>> or am I missing some others?
> >>
> >> Multiple things broke at once so slightly hard to fish the relevant
> >> stuff out from here:
> >>
> >> https://netdev.bots.linux.dev/contest.html?branch=net-next-2026-01-05--15-00&pass=0&pw-n=0
> >>
> >> Here's one:
> >>
> >> make[1]: Entering directory 
> >> '/home/virtme/testing/wt-3/tools/testing/selftests/net'
> >>   CC       busy_poller
> >> In file included from [01m[K/usr/include/sys/socket.h:33[m[K,
> >>                  from [01m[K/usr/include/netinet/in.h:23[m[K,
> >>                  from [01m[K/usr/include/arpa/inet.h:22[m[K,
> >>                  from [01m[Kbusy_poller.c:14[m[K:
> >> [01m[K/usr/include/bits/socket.h:182:8:[m[K [01;31m[Kerror: 
> >> [m[Kredefinition of '[01m[Kstruct sockaddr[m[K'
> >
> >>                  from [01m[Kbusy_poller.c:12[m[K:
> >> [01m[K/home/virtme/testing/wt-3/usr/include/linux/socket.h:37:8:[m[K 
> >> [01;36m[Knote: [m[Koriginally defined here
> >
> > Maybe we can change all the instances of 'struct sockaddr' in
> > include/uapi/ to reference a new 'struct __kernel_sockaddr',
> > and then redirect that one if the libc header got included
> > first?
> >
> > struct __kernel_sockaddr {
> >        __kernel_sa_family_t    sa_family;      /* address family, AF_xxx       */
> >        char sa_data_min[14];           /* Minimum 14 bytes of protocol address */
> > };
> > #ifdef _SYS_SOCKET_H
> > #define __kernel_sockaddr sockaddr
> > #endif

I'm not a big fan of such a define in a generic header.

I do have a v2 of this patch currently in 0day. It reorders the inclusions
in the affected selftests. While it feels like a hack, interspersing the
different types of headers may already break randomly due to issues in
libc-compat.h (see below)

> > This will still fail when a user application includes linux/if.h
> > before sys/socket.h and then expects the structures in linux/if.h
> > to contain the libc version of sockaddr, but hopefully that is
> > much rarer. A survey of codesearch.debian.net shows almost all
> > users of linux/if.h first including sys/socket.h, and most of
> > them not caring about struct sockaddr either.

The whole linux/libc-compat.h machinery is brittle when UAPI headers are
included before libc headers. It will only detect the included libc headers
on its first inclusion. If overlapping libc and UAPI after that, they will
run into symbol clashes.

> If you call the data member sa_data just like glibc, it will only fail
> in C++, not C.  GCC considers the two definitions sufficiently
> equivalent (even though glibc adds a may_alias attribute to meet POSIX
> requirements), and duplicate definitions are permitted in C.

clang is not so lenient and will error out.

> C++ with modules will probably support duplicate definitions, too, but I
> haven't checked if it's possible to get this work with GCC 16.


Thomas


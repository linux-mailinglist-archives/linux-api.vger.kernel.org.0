Return-Path: <linux-api+bounces-5797-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gPj2OoLegmnfdgMAu9opvQ
	(envelope-from <linux-api+bounces-5797-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Wed, 04 Feb 2026 06:52:02 +0100
X-Original-To: lists+linux-api@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C2E3E21A9
	for <lists+linux-api@lfdr.de>; Wed, 04 Feb 2026 06:52:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D1712303EFD4
	for <lists+linux-api@lfdr.de>; Wed,  4 Feb 2026 05:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35F24350D4C;
	Wed,  4 Feb 2026 05:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mH1c+uNa";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="d6ZMtz0u"
X-Original-To: linux-api@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D405A350A00;
	Wed,  4 Feb 2026 05:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770184311; cv=none; b=DfNGdCpErIqkxD8AnfDMSyt21id1UwKZc8+eCC3Y4kryu6MJdy5EqW7RYstnG1sfz/T4SCztuGaNWJbVQ0gKBsWkZcJ5MWczTTJRmLRxhw9RU6Jud0ebcK3Tq74DOIZw3cGk6aOw3/n8Bt3L3HhLZWrbuRkOHA1o9qL5i5/A5Rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770184311; c=relaxed/simple;
	bh=WyeMu1AkwqKC5I7WTqh9UrxM26rqyj+dwIwTtP2n/uA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OyTpPnMVPJmVRzfW4eAZ1gmzg1ckR0JF4Z8Iia4QBQu/5JdxmUmwamOFdsfBH8xpaQE2OTh1234tVWiIhTB2ETgIpCb3aH2nX8uV7hjL++DtAj1cyzumAqUlugu72FNInSFquMTtomJT5A/WJqDyKr+g9blfFIFiZCXDPp71vlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mH1c+uNa; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=d6ZMtz0u; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 4 Feb 2026 06:51:46 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1770184308;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sZHCk7fKGvf7QzEKyi64QeW2Liq4IP/rnnD/aBkMl5c=;
	b=mH1c+uNacxWRUNxmS4+KhnW02S+ScCNg0PSMrRBV3jl5Y9gLNvMzn2wKTFE119EqwrHZVK
	0Xs2BQCwy0xLs2a7+gdd8+UIN1NJkFxmfKrvCWu8BRowAICffN4IDMn7nvd5n8pRhGlOTI
	/lcoeDTVwx4C/5arPqxl4Pr1DwVM/XXISPy+Ud/+o5dE+3KjyDGBJawYLfFhBLuzKlHeEe
	Jjaaa07nXgXxFL74kUd+x+t5iZVGeWcu8qhM/QlOyI3o3mdtjH2S9THZPgLNdLZakBJJlE
	ZR3GP0J25NhG4p4mppsRJ+sb9ftJwtMZWzQmpngxhxJY0va5sW06twgDzT0yog==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1770184308;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sZHCk7fKGvf7QzEKyi64QeW2Liq4IP/rnnD/aBkMl5c=;
	b=d6ZMtz0uUl3VOFryIOVmf39EYhSjv1iRpyzj0W6e5d3GCAZeC1TF0aBjXeboj7tm1lJ6gw
	gmXb8/M6hAEDp/DQ==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	Matthieu Baerts <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>, 
	Geliang Tang <geliang@kernel.org>, =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>, 
	=?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-api@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, linux-kselftest@vger.kernel.org, 
	mptcp@lists.linux.dev, linux-security-module@vger.kernel.org, bpf@vger.kernel.org, 
	libc-alpha@sourceware.org, Carlos O'Donell <carlos@redhat.com>, 
	Adhemerval Zanella <adhemerval.zanella@linaro.org>, Rich Felker <dalias@libc.org>, klibc@zytor.com, 
	Florian Weimer <fweimer@redhat.com>
Subject: Re: [PATCH net-next v2 0/4] net: uapi: Provide an UAPI definition of
 'struct sockaddr'
Message-ID: <20260204064248-d9c4ab78-f6d4-4ac6-8d55-e939bc1df6d2@linutronix.de>
References: <20260120-uapi-sockaddr-v2-0-63c319111cf6@linutronix.de>
 <20260121192729.2095aa25@kernel.org>
 <20260130112309-28f2645b-e756-4173-96da-cf5c59191520@linutronix.de>
 <20260130081741.425a92e0@kernel.org>
 <3c46fc49-b41b-44a2-b42a-669cc7e6bb02@linutronix.de>
 <20260131092517.6639d84c@kernel.org>
 <20260203122715-eeb304f9-4b42-4fc6-a527-658182a92ba5@linutronix.de>
 <20260203144011.32d5b223@kernel.org>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260203144011.32d5b223@kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-5797-lists,linux-api=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[google.com,redhat.com,davemloft.net,kernel.org,digikod.net,iogearbox.net,gmail.com,fomichev.me,linux.dev,vger.kernel.org,arndb.de,lists.linux.dev,sourceware.org,linaro.org,libc.org,zytor.com];
	RCPT_COUNT_TWELVE(0.00)[40];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thomas.weissschuh@linutronix.de,linux-api@vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-api];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8C2E3E21A9
X-Rspamd-Action: no action

On Tue, Feb 03, 2026 at 02:40:11PM -0800, Jakub Kicinski wrote:
> On Tue, 3 Feb 2026 12:42:22 +0100 Thomas Weißschuh wrote:
> > > FWIW the typelimits change broke compilation of ethtool, we'll see if
> > > anyone "outside kernel community itself" complains.  
> > 
> > Can you point me to that breakage? I was unable to find it.
> 
> Not reported on the ML, and it's kinda annoying to repro because 
> the uAPI header sync script isn't committed :/ You have to check 
> this out
> 
>  https://git.kernel.org/pub/scm/network/ethtool/ethtool.git/
> 
> and run a script like this to sync headers from the kernel (then build):
> 
> #!/bin/bash -e
> 
> sn="${0##*/}"
> export ARCH="x86_64"
> 
> if [ ! -d "$LINUX_GIT" ]; then
>     echo "${sn}: LINUX_GIT not set" >&2
>     exit 1
> fi
> 
> pushd "$LINUX_GIT"
> if [ -n "$1" ]; then
>     git checkout "$1"
> fi
> desc=$(git describe --exact-match 2>/dev/null \
>        || git show -s --abbrev=12 --pretty='commit %h')
> kobj=$(mktemp -d)

> make -j16 O="$kobj" allmodconfig
> make -j16 O="$kobj" prepare

These are not necessary.
The UAPI generation does not need a kernel configuration.

> make -j16 O="$kobj" INSTALL_HDR_PATH="${kobj}/hdr" headers_install
> popd
> 
> pushd uapi
> find . -type f -name '*.h' -exec cp -v "${kobj}/hdr/include/{}" {} \;

Here only those headers which already exist in ethtool's uapi/ directory
are copied. As linux/typelimits.h is new, it is now missing.
Honestly, if a user fiddles with the internals of the UAPI headers like
this, it is on them to update their code if the internal structure
changes. In your case a simple 'touch uapi/linux/typelimits.h'
before running the script will be enough. Also internal.h now requires
an explicit inclusion of <limits.h>, as that is not satisfied by the
UAPI anymore.

> popd
> rm -rf "$kobj"
> 
> git add uapi
> git commit -s -F - <<EOT
> update UAPI header copies
> 
> Update to kernel ${desc}.
> 
> EOT


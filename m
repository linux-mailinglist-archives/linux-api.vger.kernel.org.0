Return-Path: <linux-api+bounces-5818-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uAaoNFviiWnGCwAAu9opvQ
	(envelope-from <linux-api+bounces-5818-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Mon, 09 Feb 2026 14:34:19 +0100
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3000B10FC20
	for <lists+linux-api@lfdr.de>; Mon, 09 Feb 2026 14:34:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 50F8C3004F66
	for <lists+linux-api@lfdr.de>; Mon,  9 Feb 2026 13:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ED57377556;
	Mon,  9 Feb 2026 13:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YlR9bj5Z";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1J7rxPcV"
X-Original-To: linux-api@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3276244665;
	Mon,  9 Feb 2026 13:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770644054; cv=none; b=fDKucmtPTsnP0aTXnIVn5aSNofGt8UocUDWSWGb+XWZ0ifxbq3wRkaJuxmimou0ek17NLq3TjUbYjA00N+P6/Qh/EqB5es/ecX7sdM+tRDP+qWtsGaZ+GMIr1F8IZz2npDky3C78k0WgS6zWA2cuISLdjThJRjmhH3hRtq86ufo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770644054; c=relaxed/simple;
	bh=IOCckDQmO3bCx6vIbKsdQfr+uc3RnkYrCh6Yh98UfAA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HXQoA2Dzz1AmrArXrWzIEOb5EUX+t9h/5Y866oJGh5pyAHEp2N4I8GCIVM5hV3HJFNqboc+Y9qqENpTG9bzCuLhACh6cI3pFPKvMbjkE+n5rzsPJvSO0h8ND6F4T954HXATHNoT1Ea0VMeJd8X9bhdfPzW22COSE7wMtHdY+8H8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YlR9bj5Z; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1J7rxPcV; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 9 Feb 2026 14:34:09 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1770644051;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=60PQiy2iBpgFewxiruovzAslbmJSAAtPFOFOOiKjjPA=;
	b=YlR9bj5ZIrN5Hl5gkUFTHUhbBNirduv8CgJZeENp11uU3U6thi6j/OtC/KQPAKc9QoY16b
	iqhuyzi/b0ZQ7M7VUfUOm6xDjdKBiVAcL0NDslJlAhb3BeoAwDRRtJnPjGMbf1mFXVv7bt
	NMrFeatDijOgXhtd0UkwblQQRQ31qH8+8sJoew6J5Wkmb20RAzlLTsuX1HheIftYOGQ2/H
	DD0vYw+2DrYDfmR/vW+TfUOUQruDrKryktRtVAgS4glEN42/iCi7e94OG0AE7SlxspDuCq
	Or+Gco28APE0lsa0wk71wKJNamcmGRe8DaKywyoaJhATqU9E7ZWe6UypX84Xbg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1770644051;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=60PQiy2iBpgFewxiruovzAslbmJSAAtPFOFOOiKjjPA=;
	b=1J7rxPcVC/2n9mif2u5PsOumsh3UqugEaRYJHku7wMkXPEW7VFN4X8Fwwg9s/kVlJ7j0qj
	wEPG5ci9hZIbMODg==
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
Message-ID: <20260209143003-80d3cb63-38c6-4280-a319-ee6879eeab11@linutronix.de>
References: <20260120-uapi-sockaddr-v2-0-63c319111cf6@linutronix.de>
 <20260121192729.2095aa25@kernel.org>
 <20260130112309-28f2645b-e756-4173-96da-cf5c59191520@linutronix.de>
 <20260130081741.425a92e0@kernel.org>
 <3c46fc49-b41b-44a2-b42a-669cc7e6bb02@linutronix.de>
 <20260131092517.6639d84c@kernel.org>
 <20260203122715-eeb304f9-4b42-4fc6-a527-658182a92ba5@linutronix.de>
 <20260203144011.32d5b223@kernel.org>
 <20260204064248-d9c4ab78-f6d4-4ac6-8d55-e939bc1df6d2@linutronix.de>
 <20260204175516.4fb11966@kernel.org>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260204175516.4fb11966@kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-5818-lists,linux-api=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[40];
	FREEMAIL_CC(0.00)[google.com,redhat.com,davemloft.net,kernel.org,digikod.net,iogearbox.net,gmail.com,fomichev.me,linux.dev,vger.kernel.org,arndb.de,lists.linux.dev,sourceware.org,linaro.org,libc.org,zytor.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thomas.weissschuh@linutronix.de,linux-api@vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-api];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linutronix.de:mid,linutronix.de:dkim]
X-Rspamd-Queue-Id: 3000B10FC20
X-Rspamd-Action: no action

On Wed, Feb 04, 2026 at 05:55:16PM -0800, Jakub Kicinski wrote:
> On Wed, 4 Feb 2026 06:51:46 +0100 Thomas Weißschuh wrote:
> > > make -j16 O="$kobj" INSTALL_HDR_PATH="${kobj}/hdr" headers_install
> > > popd
> > > 
> > > pushd uapi
> > > find . -type f -name '*.h' -exec cp -v "${kobj}/hdr/include/{}" {} \;  
> > 
> > Here only those headers which already exist in ethtool's uapi/ directory
> > are copied. As linux/typelimits.h is new, it is now missing.
> > Honestly, if a user fiddles with the internals of the UAPI headers like
> > this, it is on them to update their code if the internal structure
> > changes. In your case a simple 'touch uapi/linux/typelimits.h'
> > before running the script will be enough. Also internal.h now requires
> > an explicit inclusion of <limits.h>, as that is not satisfied by the
> > UAPI anymore.
> 
> Hopefully you understand that while due to uapi header copy this is not
> a huge issue for ethtool itself, but it is a proof that your changes
> can break normal user space applications which do not vendor in uapi.

A regular application which uses a full UAPI headers tree will get
access to the new header automatically.
If the application uses symbols from <limits.h> without including <limits.h>
on its own, it is broken.


Thomas


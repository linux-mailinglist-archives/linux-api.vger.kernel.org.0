Return-Path: <linux-api+bounces-5795-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6GKpOEPfgWmDLQMAu9opvQ
	(envelope-from <linux-api+bounces-5795-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Tue, 03 Feb 2026 12:42:59 +0100
X-Original-To: lists+linux-api@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DBBBD88D0
	for <lists+linux-api@lfdr.de>; Tue, 03 Feb 2026 12:42:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2F85B3007AF0
	for <lists+linux-api@lfdr.de>; Tue,  3 Feb 2026 11:42:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F3BC3382C8;
	Tue,  3 Feb 2026 11:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Is5q8smq";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kzcip55z"
X-Original-To: linux-api@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CDC232F75B;
	Tue,  3 Feb 2026 11:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770118947; cv=none; b=u+3w7mj0eD+/qD9qvco0Nb3t5c/Hing72O/vImV8t0TjCWohVtzkjLwhujsyJV0YxvPAIY4gkrEHPZ9iTbSBtntuxyFrCE3DMZRI20Io+GmOlN6sblznsB12Ei4tGha4sVobEod5NG2O83qx+TXWLMJRQLflkJD3ntpUgPNp/IU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770118947; c=relaxed/simple;
	bh=f/4jPZjlH43hVd7djQf+N42+eV6nxJtc05EPg7iYKfI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d9xh8asrCGIzfjpQdYFzhSMPSOYu0DGaaGqMMSxIg3m36oZcpL8CghP0gj0QhmQogS3/8Qy3XlCwHDWTl+rx93hoBxZwAHAEKATgdlEtAq3JaUT7rEIX3OrgW5XsFkaUXh2ehhXzkn7Ybr3TWfS32NyUvrbelTFjToxcKlVOsqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Is5q8smq; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kzcip55z; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 3 Feb 2026 12:42:22 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1770118943;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Okjru8snA57GtyYjXxOgEFvqQ11nIpWc1KWAif9Vb94=;
	b=Is5q8smq+1zCbNi8BcIT2F9JYkNoW4I2f6h3IsAC9+TAHZAJA+ptGoNxcksmNb9TJO7ASM
	GrBNDpYopQXBfgTY5M6dWw4bCJMOtSruU2w8tp2eZKjimAA7Ubd1/OALNQQKUG+MLkwnUd
	QRxbn1zb/g1zvxcC0GPrJcXHA9tPI/baTjQBdtonqWrDpkipE2wNvACjNoyebH1Ydp8s50
	A946N23gdg226yVCStxech6jmC/7kbE9izKiwBmJX4vSz09YNs35yZeWZTuvY25R9TIzTe
	p6tIfDELXJ+D1UMNJYD9v/kqx9EK1ZaQ5UlQiuNoexqlLkUa4DGFCiYIuHFNLQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1770118943;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Okjru8snA57GtyYjXxOgEFvqQ11nIpWc1KWAif9Vb94=;
	b=kzcip55zJZvPYHswIjpDmmP5Hv1N0sjB+RQRB7cIM929AaKZ+VGOUSayo7E5Sl+KS/jTXA
	BYV4WQ5EQ7zRpvCA==
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
Message-ID: <20260203122715-eeb304f9-4b42-4fc6-a527-658182a92ba5@linutronix.de>
References: <20260120-uapi-sockaddr-v2-0-63c319111cf6@linutronix.de>
 <20260121192729.2095aa25@kernel.org>
 <20260130112309-28f2645b-e756-4173-96da-cf5c59191520@linutronix.de>
 <20260130081741.425a92e0@kernel.org>
 <3c46fc49-b41b-44a2-b42a-669cc7e6bb02@linutronix.de>
 <20260131092517.6639d84c@kernel.org>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260131092517.6639d84c@kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-5795-lists,linux-api=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-api];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0DBBBD88D0
X-Rspamd-Action: no action

On Sat, Jan 31, 2026 at 09:25:17AM -0800, Jakub Kicinski wrote:
> On Sat, 31 Jan 2026 11:26:32 +0100 Thomas Weißschuh wrote:
> > Jan 30, 2026 17:17:46 Jakub Kicinski <kuba@kernel.org>:
> > 
> > > On Fri, 30 Jan 2026 11:34:15 +0100 Thomas Weißschuh wrote:  
> > >> Some of them get broken by the new 'struct sockaddr', but some others are
> > >> already broken just by the new transitive inclusion of libc-compat.h.
> > >> So any header starting to use the compatibility machinery may trigger breakage
> > >> in code including UAPI headers before libc header, even for completely new type
> > >> definitions which themselves would not conflict with libc.  
> > >
> > > Let's split the uAPI header changes from any selftest changes.
> > > If you're saying the the selftests no longer build after the uAPI
> > > header changes then of course we can't apply the patches.  
> > 
> > Yes, the selftests don't build anymore after the uAPI changes.
> > 
> > "can't apply" as in
> > * "can't apply separately"
> > * "are unacceptable in general"
> 
> this one
> 
> > * "are too late for this cycle"
> > ?
> > 
> > None of this is urgent.
> > We can do the selftests in one cycle and the uAPI in another one.
> > Feel free to pick up the patches as you see fit.
> > (The mptcp changes already go through their tree, so need to be dropped here)
> > I can also resubmit the patches differently if preferred.
> 
> The selftests are just a canary in the coalmine. If we break a bunch of
> selftests chances are we'll also break compilation of real applications
> for people. Subjective, but I don't see a sufficient upside here to do
> that.

Okay. We'll have around this inconsistency then.

> FWIW the typelimits change broke compilation of ethtool, we'll see if
> anyone "outside kernel community itself" complains.

Can you point me to that breakage? I was unable to find it.


Thomas


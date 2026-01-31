Return-Path: <linux-api+bounces-5783-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QOKNLOnYfWlCUAIAu9opvQ
	(envelope-from <linux-api+bounces-5783-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Sat, 31 Jan 2026 11:26:49 +0100
X-Original-To: lists+linux-api@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 50CFCC1907
	for <lists+linux-api@lfdr.de>; Sat, 31 Jan 2026 11:26:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2FAFA300CFEE
	for <lists+linux-api@lfdr.de>; Sat, 31 Jan 2026 10:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1513933F392;
	Sat, 31 Jan 2026 10:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ujFcBGUs";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="o3Mf3maH"
X-Original-To: linux-api@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C44932B99F;
	Sat, 31 Jan 2026 10:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769855204; cv=none; b=rAGGL4irw/u/c2xh9s3ZLkq7bcQQZD3n8bXccw1Sdbhek89M0Tb5k2Dn+6RNvV1gNsLLMIGiCDjCLpCB4W7JhIOi3QICMn8ejQ5A8DsUlwPjApM3HiCerUtuGePn8gIrHeoypSBFg/9uWrjE300KyX5cziwqpPim0zSx2ugzCkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769855204; c=relaxed/simple;
	bh=fSYUV7IS3o69dTdqJYCTCDDpkpgEmF9ZMQCatBCrxIY=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=PstHHjJ1DIEtlA3xO7/oN6p3z6qcnGUPwjmqzP4gy0f27NypuIJ2JkTgdf+Tpv1wa6PL6b2bxhc0eJJvosS/AKI/lF97t2e3ChXdhuEzgszN/zU66tmVLAojrERySmF7pmijecH9AiCR+16r09uqbSFEqyEO74MA1A2MSGgXGHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ujFcBGUs; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=o3Mf3maH; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 31 Jan 2026 11:26:32 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1769855200;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fSYUV7IS3o69dTdqJYCTCDDpkpgEmF9ZMQCatBCrxIY=;
	b=ujFcBGUsImqUv9Waw+ZtvA+p6fZ4LIbAmiS6QztDYuHyPXm/6tntcMoEMIYEjU8lOqcO84
	JUUDN/6Kukil9yK//36hXfaWpntbhqwS7rpoYqgNp8J7vH2rEgPLSWBSOJCFhT370lMrz/
	7gRztUGxucgA8FZM7aBr49ieKm/ipXKorVgUa2YcofyppS0h5L2o6S+vxx6wdHHiyZuQP7
	4tDa97C40tHmopdF7sfKWCecB4iWhSWR6wxuCMHjQF5PnvXeR7OeAHevgmM2vMyuDCG3al
	xfxPZ+QZ+kVu3G/6B75qY9SyFT5dp8UfXmQfVcVLA1dNhzZVtJfmKcKv2Y6xrg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1769855200;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fSYUV7IS3o69dTdqJYCTCDDpkpgEmF9ZMQCatBCrxIY=;
	b=o3Mf3maHGlMurUXPFEwRlLNYIUYFFIj6zqdetL38/IGpMYAIMViNT6qayDv5qUM3kMIQ3B
	XwdioEIZ+jxY1TDQ==
From: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemb@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
	Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	=?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>, linux-kselftest@vger.kernel.org,
	mptcp@lists.linux.dev, linux-security-module@vger.kernel.org,
	bpf@vger.kernel.org, libc-alpha@sourceware.org,
	Carlos O'Donell <carlos@redhat.com>,
	Adhemerval Zanella <adhemerval.zanella@linaro.org>,
	Rich Felker <dalias@libc.org>, klibc@zytor.com,
	Florian Weimer <fweimer@redhat.com>
Message-ID: <3c46fc49-b41b-44a2-b42a-669cc7e6bb02@linutronix.de>
In-Reply-To: <20260130081741.425a92e0@kernel.org>
References: <20260120-uapi-sockaddr-v2-0-63c319111cf6@linutronix.de> <20260121192729.2095aa25@kernel.org> <20260130112309-28f2645b-e756-4173-96da-cf5c59191520@linutronix.de> <20260130081741.425a92e0@kernel.org>
Subject: Re: [PATCH net-next v2 0/4] net: uapi: Provide an UAPI definition
 of 'struct sockaddr'
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Correlation-ID: <3c46fc49-b41b-44a2-b42a-669cc7e6bb02@linutronix.de>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-5783-lists,linux-api=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-api];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linutronix.de:mid,linutronix.de:dkim]
X-Rspamd-Queue-Id: 50CFCC1907
X-Rspamd-Action: no action

Jan 30, 2026 17:17:46 Jakub Kicinski <kuba@kernel.org>:

> On Fri, 30 Jan 2026 11:34:15 +0100 Thomas Wei=C3=9Fschuh wrote:
>>> Are all those selftests / samples getting broken by this patch set?=C2=
=A0
>>
>> Yes.
>>
>> Some of them get broken by the new 'struct sockaddr', but some others ar=
e
>> already broken just by the new transitive inclusion of libc-compat.h.
>> So any header starting to use the compatibility machinery may trigger br=
eakage
>> in code including UAPI headers before libc header, even for completely n=
ew type
>> definitions which themselves would not conflict with libc.
>
> Let's split the uAPI header changes from any selftest changes.
> If you're saying the the selftests no longer build after the uAPI
> header changes then of course we can't apply the patches.

Yes, the selftests don't build anymore after the uAPI changes.

"can't apply" as in
* "can't apply separately"
* "are unacceptable in general"
* "are too late for this cycle"
?

None of this is urgent.
We can do the selftests in one cycle and the uAPI in another one.
Feel free to pick up the patches as you see fit.
(The mptcp changes already go through their tree, so need to be dropped her=
e)
I can also resubmit the patches differently if preferred.


Thomas


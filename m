Return-Path: <linux-api+bounces-5784-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sCRWBwU7fmkOWgIAu9opvQ
	(envelope-from <linux-api+bounces-5784-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Sat, 31 Jan 2026 18:25:25 +0100
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5175AC32EF
	for <lists+linux-api@lfdr.de>; Sat, 31 Jan 2026 18:25:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 477513019936
	for <lists+linux-api@lfdr.de>; Sat, 31 Jan 2026 17:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDE1E34CFB8;
	Sat, 31 Jan 2026 17:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lyOpOqHt"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A68842E54D1;
	Sat, 31 Jan 2026 17:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769880320; cv=none; b=sJOCOtxy7Fbts6voOSu6ckPujJMpdgqF0WfLykqmrYJXSNUj/MvxuRrPVbEcT/FCMmOryUrfz7nENiLKmH9PAHRqiLuCwvt6aqug0dun5jAXRj0bEGyerbr/AVAZYTAptVtKC6w30JxIFQ0uf7/uq+ESbqOwlV7ps73QGqf3OV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769880320; c=relaxed/simple;
	bh=VdrhpYX/xqvIWPFWCfZ0baQLFsfzzI9f0fA4hBvpNCU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O3+W8ZWliBSrEUXOZpR89v6xUst4VY2A1ITCEEqDnpOCE2Nmmk4C7sSdpwSCoKwPDW1hPAQxzIrrY8L1YT46TtH9bi4xnvcFBJ9ZvuoqtL/nGdpls5UGzyhwB7kTS+PjzqBlzAF1Iq6TOgbWjW68lJgscsN9H2w3o79A+3ySkzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lyOpOqHt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D040DC4CEF1;
	Sat, 31 Jan 2026 17:25:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769880320;
	bh=VdrhpYX/xqvIWPFWCfZ0baQLFsfzzI9f0fA4hBvpNCU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lyOpOqHtctSBTT3RWfweLWjBSm8lFZdjvHAYZ8acBPsXKdsjhFaUI1HvBiJ+8esQx
	 iZs9nM9nCkE7C41cwpNx07jcYh/Px++kGNvfXvuhwX+wcMLQRj3Vei2r7mL3A7gRAP
	 7sPp2rRkruTZ74GGD8uXtl4d+ahRcbGFQ3JQro/P40AzkNF4VJ+T3MekVszUbRbz/N
	 9XI2GGu2IoULhGPWnwnHmv6sxDJ79guFXCEv4zSwUe1AySyAk8Hu6XAtx17nkNtu9E
	 3KTO/1xg6dk0qlgHyjCXxlSWgJg9zXp0c8PygCMTcs2k7jy8vycYji3w1BL7uj3OQQ
	 vxGVswCFi595w==
Date: Sat, 31 Jan 2026 09:25:17 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Thomas =?UTF-8?B?V2Vpw59zY2h1aA==?= <thomas.weissschuh@linutronix.de>
Cc: Eric Dumazet <edumazet@google.com>, Kuniyuki Iwashima
 <kuniyu@google.com>, Paolo Abeni <pabeni@redhat.com>, Willem de Bruijn
 <willemb@google.com>, "David S. Miller" <davem@davemloft.net>, Simon Horman
 <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, Matthieu Baerts
 <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>, Geliang Tang
 <geliang@kernel.org>, =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?=
 <mic@digikod.net>, =?UTF-8?B?R8O8bnRoZXI=?= Noack <gnoack@google.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, John
 Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu
 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, KP Singh
 <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-api@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
 linux-kselftest@vger.kernel.org, mptcp@lists.linux.dev,
 linux-security-module@vger.kernel.org, bpf@vger.kernel.org,
 libc-alpha@sourceware.org, Carlos O'Donell <carlos@redhat.com>, Adhemerval
 Zanella <adhemerval.zanella@linaro.org>, Rich Felker <dalias@libc.org>,
 klibc@zytor.com, Florian Weimer <fweimer@redhat.com>
Subject: Re: [PATCH net-next v2 0/4] net: uapi: Provide an UAPI definition
 of 'struct sockaddr'
Message-ID: <20260131092517.6639d84c@kernel.org>
In-Reply-To: <3c46fc49-b41b-44a2-b42a-669cc7e6bb02@linutronix.de>
References: <20260120-uapi-sockaddr-v2-0-63c319111cf6@linutronix.de>
	<20260121192729.2095aa25@kernel.org>
	<20260130112309-28f2645b-e756-4173-96da-cf5c59191520@linutronix.de>
	<20260130081741.425a92e0@kernel.org>
	<3c46fc49-b41b-44a2-b42a-669cc7e6bb02@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-5784-lists,linux-api=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[google.com,redhat.com,davemloft.net,kernel.org,digikod.net,iogearbox.net,gmail.com,fomichev.me,linux.dev,vger.kernel.org,arndb.de,lists.linux.dev,sourceware.org,linaro.org,libc.org,zytor.com];
	RCPT_COUNT_TWELVE(0.00)[40];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,linux-api@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-api];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5175AC32EF
X-Rspamd-Action: no action

On Sat, 31 Jan 2026 11:26:32 +0100 Thomas Wei=C3=9Fschuh wrote:
> Jan 30, 2026 17:17:46 Jakub Kicinski <kuba@kernel.org>:
>=20
> > On Fri, 30 Jan 2026 11:34:15 +0100 Thomas Wei=C3=9Fschuh wrote: =20
> >> Some of them get broken by the new 'struct sockaddr', but some others =
are
> >> already broken just by the new transitive inclusion of libc-compat.h.
> >> So any header starting to use the compatibility machinery may trigger =
breakage
> >> in code including UAPI headers before libc header, even for completely=
 new type
> >> definitions which themselves would not conflict with libc. =20
> >
> > Let's split the uAPI header changes from any selftest changes.
> > If you're saying the the selftests no longer build after the uAPI
> > header changes then of course we can't apply the patches. =20
>=20
> Yes, the selftests don't build anymore after the uAPI changes.
>=20
> "can't apply" as in
> * "can't apply separately"
> * "are unacceptable in general"

this one

> * "are too late for this cycle"
> ?
>=20
> None of this is urgent.
> We can do the selftests in one cycle and the uAPI in another one.
> Feel free to pick up the patches as you see fit.
> (The mptcp changes already go through their tree, so need to be dropped h=
ere)
> I can also resubmit the patches differently if preferred.

The selftests are just a canary in the coalmine. If we break a bunch of
selftests chances are we'll also break compilation of real applications
for people. Subjective, but I don't see a sufficient upside here to do
that.

FWIW the typelimits change broke compilation of ethtool, we'll see if
anyone "outside kernel community itself" complains.


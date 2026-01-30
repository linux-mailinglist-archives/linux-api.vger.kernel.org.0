Return-Path: <linux-api+bounces-5782-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8LVnAavZfGlbOwIAu9opvQ
	(envelope-from <linux-api+bounces-5782-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Fri, 30 Jan 2026 17:17:47 +0100
X-Original-To: lists+linux-api@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 717CEBC746
	for <lists+linux-api@lfdr.de>; Fri, 30 Jan 2026 17:17:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 156E03013880
	for <lists+linux-api@lfdr.de>; Fri, 30 Jan 2026 16:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3473534A794;
	Fri, 30 Jan 2026 16:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k1yBHxLL"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF4F2561AB;
	Fri, 30 Jan 2026 16:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769789864; cv=none; b=rac8xrn0XpfEweDmrmnf4sidS/gLANslOsedJQfOwTygGvGPs3QRzsdIvow+8YiuZzhRqKtIQ5QHZ+H/1OaTnwEy/xgjBR26so1VAx0DuLjYMfOBAySIJkdCPmxvv33gUuH42dM5p/biJBEXAS/6fn57QWsH79xLanmDkQZvKX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769789864; c=relaxed/simple;
	bh=z+/dvHCuSRC8GadGxDVKBz0qCgDafXTsylWSvFzuU2c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xn8pvGNO315pOreCTqjnRcqJiaisqxChqlLYJSMoT4rOn02o6uklW3Rn3GHK5Qc2sBzLJPUa0kdzSW2S0kAuG/EwITGaMxmfwF/vOHBormSdN7mawVn7k/iU26bETFl+tnYnyy9TDTWccUmLkbZa008PHUq2vkegJ7Y0Jw7llg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k1yBHxLL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E553C4CEF7;
	Fri, 30 Jan 2026 16:17:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769789863;
	bh=z+/dvHCuSRC8GadGxDVKBz0qCgDafXTsylWSvFzuU2c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=k1yBHxLLaz7qxhw10LYJ/PtJZNuBRNWPbQu2fs4+Hr9Gl2ZeYV9zlK0cWuc8wcaJZ
	 N7ocR6YBkkcnsiPwmxzWHPPx2rdjpiq+DgU7zyPAoiuhVpzoSOxLlkBOcs/uEH7eHj
	 GwRvr1f0PQ5cNbr1qFx9r25PVqyYESybsJiifdgTf3ijpbEl8o6XP0A+GZEr9qkhNF
	 dqGtK4AQ6fGklQugqY09NPgw3je0/YO+l9AkOZeXK/j/zLlo9ooctuE61JI287Oequ
	 5jggHSC90FTvmIFUt1JFgewVOKnZ8k6aDXcM0tUS/fT2+99KhwaDGPK+EE2rYBA1dt
	 rubZgn6PJby1A==
Date: Fri, 30 Jan 2026 08:17:41 -0800
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
Message-ID: <20260130081741.425a92e0@kernel.org>
In-Reply-To: <20260130112309-28f2645b-e756-4173-96da-cf5c59191520@linutronix.de>
References: <20260120-uapi-sockaddr-v2-0-63c319111cf6@linutronix.de>
	<20260121192729.2095aa25@kernel.org>
	<20260130112309-28f2645b-e756-4173-96da-cf5c59191520@linutronix.de>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-5782-lists,linux-api=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 717CEBC746
X-Rspamd-Action: no action

On Fri, 30 Jan 2026 11:34:15 +0100 Thomas Wei=C3=9Fschuh wrote:
> > Are all those selftests / samples getting broken by this patch set? =20
>=20
> Yes.
>=20
> Some of them get broken by the new 'struct sockaddr', but some others are
> already broken just by the new transitive inclusion of libc-compat.h.
> So any header starting to use the compatibility machinery may trigger bre=
akage
> in code including UAPI headers before libc header, even for completely ne=
w type
> definitions which themselves would not conflict with libc.

Let's split the uAPI header changes from any selftest changes.
If you're saying the the selftests no longer build after the uAPI
header changes then of course we can't apply the patches.


Return-Path: <linux-api+bounces-5699-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AK4LI1CZcWngJgAAu9opvQ
	(envelope-from <linux-api+bounces-5699-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Thu, 22 Jan 2026 04:28:16 +0100
X-Original-To: lists+linux-api@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EFE5961538
	for <lists+linux-api@lfdr.de>; Thu, 22 Jan 2026 04:28:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EF21C4F2D28
	for <lists+linux-api@lfdr.de>; Thu, 22 Jan 2026 03:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 225153B8D54;
	Thu, 22 Jan 2026 03:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k6lhlPVb"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D51163904D2;
	Thu, 22 Jan 2026 03:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769052453; cv=none; b=mnL0qOIlpx2X3gyPmta/jOqwZCKpUINhWzV+IhsXWAhDDzGftcVs31YURAXdcct6lhgROJq8AW/JPu1RGnjd24jm+8uhjDW5uyu+c2jAIi969f0lIVLLwJTjQYR+/C651zwBfu9wCT0V36CGb2j/bRZzOlVos1KyEg62TKzV5Ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769052453; c=relaxed/simple;
	bh=Y/3pPodyEl+yDTvYSlwrBE6jK/FnjEX2M2Klb6SJ7/A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kPayxFXDIwu7ngxQD+5loHRGrzwHDw+r4feC9wQt0wb3yvQ85HfvcDfo3kieou4rA/M15rSpivCBNlI/mgmVuWpgyy49sNzRqXsT/4M20KvAqB0HzWU6BdXy8hkkFdRbVHzJbF7N+MDnYg3kRB6ai0oVdEecWH6PNL119mFbaGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k6lhlPVb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADB3AC116C6;
	Thu, 22 Jan 2026 03:27:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769052452;
	bh=Y/3pPodyEl+yDTvYSlwrBE6jK/FnjEX2M2Klb6SJ7/A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=k6lhlPVbyUsyNOMIwjCknuIW8kj1Pmz66UKqWq4lPQkf6n1iL5Sa1lyjONH4kYQ5x
	 vI9f5ziiGEdMOFGZRURsyf1Gx9CkXdxO8vlru7U3mPwRcyR03gHDzQV3j/ehjqfBu0
	 EkTeZv+BMgfjEB7fUbbB9xWwv7OugxKgmuHfdLZNBrBNLUYsbcBOpcivHfBU35oFcu
	 yNBxNgU3syqMy8LVE7lbftDHjKGLWW+pGMO5G6yYY5NCJG23wR5a3n6Yc5TAIE51Qv
	 uh1IgFMsOMRZiqTfyS/61wlSA5PzpTozDMPcYNTOwJdGQozn5Qmb/T03Q7cujbufJJ
	 TEcHVgdxGdSxQ==
Date: Wed, 21 Jan 2026 19:27:29 -0800
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
Message-ID: <20260121192729.2095aa25@kernel.org>
In-Reply-To: <20260120-uapi-sockaddr-v2-0-63c319111cf6@linutronix.de>
References: <20260120-uapi-sockaddr-v2-0-63c319111cf6@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[google.com,redhat.com,davemloft.net,kernel.org,digikod.net,iogearbox.net,gmail.com,fomichev.me,linux.dev,vger.kernel.org,arndb.de,lists.linux.dev,sourceware.org,linaro.org,libc.org,zytor.com];
	TAGGED_FROM(0.00)[bounces-5699-lists,linux-api=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	RCPT_COUNT_TWELVE(0.00)[40];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,linux-api@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-api];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns]
X-Rspamd-Queue-Id: EFE5961538
X-Rspamd-Action: no action

On Tue, 20 Jan 2026 15:10:30 +0100 Thomas Wei=C3=9Fschuh wrote:
> Various UAPI headers reference 'struct sockaddr'. Currently the
> definition of this struct is pulled in from the libc header
> sys/socket.h. This is problematic as it introduces a dependency
> on a full userspace toolchain.
>=20
> Add a definition of 'struct sockaddr' to the UAPI headers.
> Before that, reorder some problematic header inclusions in the selftests.

>  include/linux/socket.h                             | 10 ----------
>  include/uapi/linux/if.h                            |  4 ----
>  include/uapi/linux/libc-compat.h                   | 12 ++++++++++++
>  include/uapi/linux/socket.h                        | 14 ++++++++++++++
>  samples/bpf/xdp_adjust_tail_user.c                 |  6 ++++--
>  samples/bpf/xdp_fwd_user.c                         |  7 ++++---
>  samples/bpf/xdp_router_ipv4_user.c                 |  6 +++---
>  samples/bpf/xdp_sample_user.c                      | 15 ++++++++-------
>  samples/bpf/xdp_tx_iptunnel_user.c                 |  4 ++--
>  tools/testing/selftests/landlock/audit.h           |  7 ++++---
>  tools/testing/selftests/net/af_unix/diag_uid.c     |  9 +++++----
>  tools/testing/selftests/net/busy_poller.c          |  3 ++-
>  tools/testing/selftests/net/mptcp/mptcp_diag.c     | 11 ++++++-----
>  tools/testing/selftests/net/nettest.c              |  4 ++--
>  tools/testing/selftests/net/tcp_ao/icmps-discard.c |  6 +++---
>  tools/testing/selftests/net/tcp_ao/lib/netlink.c   |  9 +++++----
>  tools/testing/selftests/net/tun.c                  |  5 +++--
>  17 files changed, 77 insertions(+), 55 deletions(-)

Are all those selftests / samples getting broken by this patch set?

I understand that we should avoid libc dependencies in uAPI but at
least speaking for networking - building selftests without libc is..
not a practical proposition?


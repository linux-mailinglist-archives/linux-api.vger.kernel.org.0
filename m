Return-Path: <linux-api+bounces-5779-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yDfSCi6JfGmbNgIAu9opvQ
	(envelope-from <linux-api+bounces-5779-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Fri, 30 Jan 2026 11:34:22 +0100
X-Original-To: lists+linux-api@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B61A6B9657
	for <lists+linux-api@lfdr.de>; Fri, 30 Jan 2026 11:34:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A5945301724D
	for <lists+linux-api@lfdr.de>; Fri, 30 Jan 2026 10:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65DC4369973;
	Fri, 30 Jan 2026 10:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sOicpeZy";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="C7irYTkR"
X-Original-To: linux-api@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA78309EF9;
	Fri, 30 Jan 2026 10:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769769259; cv=none; b=tkOEbLy3zcmMHSFQbWxI4it2/5pPHeqMo+3inxENMidciSXQillKOlMK+NrWMLdTeabNjMO7aXzKswuYESAkzOOY+Enyk3lF7aHhnn97IUUux5hkCibOPIw5PJnepacshEHlG94el0jXVJXWoa+Jvi/AWNC3ovBINdTrMCNRHXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769769259; c=relaxed/simple;
	bh=zO/BeVFYXfCNJ6HxSyIH3vm/jykiVQkpDNRIphsnCq4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wx+MP4gf/VFXR3FZgFfqym9CFNIxQyzBQAmSU+qO7m+jN7WJwi9tOLJx1SHLs22x+bD3DynCepvUXk5mAoJWlTdRAuTYnSlQ5X9g5f4MqUJa5l6W0fC+biiugkUwZF/TnRjaXZe2JGtzMQSMKectY7lXBYLkjHharQLNVasjerA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sOicpeZy; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=C7irYTkR; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 30 Jan 2026 11:34:15 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1769769256;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fqjzclOpE5Z0JqU8Ln9zaCqECU+eQmtcA8Y0G/H7Kqw=;
	b=sOicpeZyVu6DjKBMznBPOyrkXHynpfqzSjLra94cmo69t730MJGq/vVRHd2CBoSw0RAvOj
	mri5kGbFMa2UzoWXipXc1Y+B68PHAeHOnd4rAAOYI/GCoNDahSj2wh0Oe9FnhadS4jHuE/
	GoIN73jNlmec7S+5eTtQpnW3FpClUPplRJI5JQFSbKSKokF8o69Y+I7Ep+jaa+bseMV4ww
	m5vhepbB58EHtkttATK4n5R07UKx+2i8ZPQjjdsvFswoRctYknbW1mqbwgvXoPFF1bKGTO
	mwCT4w1Gx6rYiY0LDJilx5Ui9/OPEqlp1xh9DyMl2pLRc2EJo2DfsMkYglGkoA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1769769256;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fqjzclOpE5Z0JqU8Ln9zaCqECU+eQmtcA8Y0G/H7Kqw=;
	b=C7irYTkRY2dmkaIIJt8bgtlla46RmYfRlQi6yK6ytIcAGH9BmOrmndC3rRju7QIg66S5Ea
	4VVpL5aU+QYKvgAg==
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
Message-ID: <20260130112309-28f2645b-e756-4173-96da-cf5c59191520@linutronix.de>
References: <20260120-uapi-sockaddr-v2-0-63c319111cf6@linutronix.de>
 <20260121192729.2095aa25@kernel.org>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260121192729.2095aa25@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-5779-lists,linux-api=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[linutronix.de:mid,linutronix.de:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B61A6B9657
X-Rspamd-Action: no action

On Wed, Jan 21, 2026 at 07:27:29PM -0800, Jakub Kicinski wrote:
> On Tue, 20 Jan 2026 15:10:30 +0100 Thomas Weißschuh wrote:
> > Various UAPI headers reference 'struct sockaddr'. Currently the
> > definition of this struct is pulled in from the libc header
> > sys/socket.h. This is problematic as it introduces a dependency
> > on a full userspace toolchain.
> > 
> > Add a definition of 'struct sockaddr' to the UAPI headers.
> > Before that, reorder some problematic header inclusions in the selftests.
> 
> >  include/linux/socket.h                             | 10 ----------
> >  include/uapi/linux/if.h                            |  4 ----
> >  include/uapi/linux/libc-compat.h                   | 12 ++++++++++++
> >  include/uapi/linux/socket.h                        | 14 ++++++++++++++
> >  samples/bpf/xdp_adjust_tail_user.c                 |  6 ++++--
> >  samples/bpf/xdp_fwd_user.c                         |  7 ++++---
> >  samples/bpf/xdp_router_ipv4_user.c                 |  6 +++---
> >  samples/bpf/xdp_sample_user.c                      | 15 ++++++++-------
> >  samples/bpf/xdp_tx_iptunnel_user.c                 |  4 ++--
> >  tools/testing/selftests/landlock/audit.h           |  7 ++++---
> >  tools/testing/selftests/net/af_unix/diag_uid.c     |  9 +++++----
> >  tools/testing/selftests/net/busy_poller.c          |  3 ++-
> >  tools/testing/selftests/net/mptcp/mptcp_diag.c     | 11 ++++++-----
> >  tools/testing/selftests/net/nettest.c              |  4 ++--
> >  tools/testing/selftests/net/tcp_ao/icmps-discard.c |  6 +++---
> >  tools/testing/selftests/net/tcp_ao/lib/netlink.c   |  9 +++++----
> >  tools/testing/selftests/net/tun.c                  |  5 +++--
> >  17 files changed, 77 insertions(+), 55 deletions(-)
> 
> Are all those selftests / samples getting broken by this patch set?

Yes.

Some of them get broken by the new 'struct sockaddr', but some others are
already broken just by the new transitive inclusion of libc-compat.h.
So any header starting to use the compatibility machinery may trigger breakage
in code including UAPI headers before libc header, even for completely new type
definitions which themselves would not conflict with libc.

> I understand that we should avoid libc dependencies in uAPI but at
> least speaking for networking - building selftests without libc is..
> not a practical proposition?

I am not sure I understand. Some sort of libc will always be necessary.
And as the selftests are intended to exercise the low-level kernel APIs,
even those not supported by libc, the UAPI headers will also be necessary.

There is nolibc (tools/include/nolibc/) which is using the UAPI headers in
most cases, and aims to be compatible. And can be and already is used for
selftests, but it will be too limited for all of the networking selftests.
(Disclaimer: I am maintaining nolibc)

My goal is *not* to make the different headers less compatible on purpose.
But by removing the existing dependencies we can now enforce the checks in
CONFIG_UAPI_HEADER_TEST to prevent any new ones from creeping in. Therefore
preventing compatiblity issues in any new UAPI.


Thomas


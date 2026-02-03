Return-Path: <linux-api+bounces-5796-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GJ0dD1R5gmlmVQMAu9opvQ
	(envelope-from <linux-api+bounces-5796-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Tue, 03 Feb 2026 23:40:20 +0100
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 96923DF4F7
	for <lists+linux-api@lfdr.de>; Tue, 03 Feb 2026 23:40:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 58F15303A10D
	for <lists+linux-api@lfdr.de>; Tue,  3 Feb 2026 22:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C79BB31B83B;
	Tue,  3 Feb 2026 22:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HlEnh9Gd"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E25C30CDBD;
	Tue,  3 Feb 2026 22:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770158414; cv=none; b=Alq9RsUvTRst9viktS6z3pg7EZLLeBKRF3uMe+EgZhh3XuUGVU8ZAxcS9AkcwsNsX5S5VwwzRS/g6yZk4swXw9iE7m9xT77oObKBO/RTODdhqBLLB+IbHa47/8RUgOYHo6yi6JAt4lJYJueo0y4e81RQ6jsk565Q6OEyAf9drXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770158414; c=relaxed/simple;
	bh=ZKt32DmVQN5n0rHwckCvF6Q/gd1U4TEdtu6Ncmef1x8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h4csp1Cdqn0xAaVtPqgZpooYNxrduMeXnClZSBnZYjZR+ydozD9hgUcAZEUACt82hEUYCufk7nwnTWkiw5WlewrmuVsa0zQ+nw7G/M3YvzuF7bCAP33L17ltOuJEAPl+BbKxrElBDDE1IfZjIaldU2hL75Jg8sUwrkXscScxnaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HlEnh9Gd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51A1DC116D0;
	Tue,  3 Feb 2026 22:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770158414;
	bh=ZKt32DmVQN5n0rHwckCvF6Q/gd1U4TEdtu6Ncmef1x8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HlEnh9GdbCfUV64zm5s1iTYMt5kWY5Cbsp0jDPCRAruj1k4qZUpn9sGiZhFGTI5Cv
	 uWHsW2dajLBmpwqtb9YOYu356a5JisCfqsqFILJaUxlcMWPNEiIqnbo4BUDXj379vo
	 IO3QrQun9eJgR3bRBMYaeAOr5ApZttFzFLugtWiDQJ8aK+5h9FmAaBa5qhlFYHiVgn
	 25tcp8DtwgSebQNNa446NuXp0Cea3hXTQy68gCd0WQ2++wWoSXSHdG+BgMCAziDd7I
	 vEO2lSp4PhsWrr+XvH3ZajK9EZ+HSSaYS9eXDjdJV2RR5MyECdZFb9dkpAq7jdKwx2
	 LpMjow9qJmRTA==
Date: Tue, 3 Feb 2026 14:40:11 -0800
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
Message-ID: <20260203144011.32d5b223@kernel.org>
In-Reply-To: <20260203122715-eeb304f9-4b42-4fc6-a527-658182a92ba5@linutronix.de>
References: <20260120-uapi-sockaddr-v2-0-63c319111cf6@linutronix.de>
	<20260121192729.2095aa25@kernel.org>
	<20260130112309-28f2645b-e756-4173-96da-cf5c59191520@linutronix.de>
	<20260130081741.425a92e0@kernel.org>
	<3c46fc49-b41b-44a2-b42a-669cc7e6bb02@linutronix.de>
	<20260131092517.6639d84c@kernel.org>
	<20260203122715-eeb304f9-4b42-4fc6-a527-658182a92ba5@linutronix.de>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-5796-lists,linux-api=lfdr.de];
	FREEMAIL_CC(0.00)[google.com,redhat.com,davemloft.net,kernel.org,digikod.net,iogearbox.net,gmail.com,fomichev.me,linux.dev,vger.kernel.org,arndb.de,lists.linux.dev,sourceware.org,linaro.org,libc.org,zytor.com];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[40];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,linux-api@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-api];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 96923DF4F7
X-Rspamd-Action: no action

On Tue, 3 Feb 2026 12:42:22 +0100 Thomas Wei=C3=9Fschuh wrote:
> > FWIW the typelimits change broke compilation of ethtool, we'll see if
> > anyone "outside kernel community itself" complains. =20
>=20
> Can you point me to that breakage? I was unable to find it.

Not reported on the ML, and it's kinda annoying to repro because=20
the uAPI header sync script isn't committed :/ You have to check=20
this out

 https://git.kernel.org/pub/scm/network/ethtool/ethtool.git/

and run a script like this to sync headers from the kernel (then build):

#!/bin/bash -e

sn=3D"${0##*/}"
export ARCH=3D"x86_64"

if [ ! -d "$LINUX_GIT" ]; then
    echo "${sn}: LINUX_GIT not set" >&2
    exit 1
fi

pushd "$LINUX_GIT"
if [ -n "$1" ]; then
    git checkout "$1"
fi
desc=3D$(git describe --exact-match 2>/dev/null \
       || git show -s --abbrev=3D12 --pretty=3D'commit %h')
kobj=3D$(mktemp -d)
make -j16 O=3D"$kobj" allmodconfig
make -j16 O=3D"$kobj" prepare
make -j16 O=3D"$kobj" INSTALL_HDR_PATH=3D"${kobj}/hdr" headers_install
popd

pushd uapi
find . -type f -name '*.h' -exec cp -v "${kobj}/hdr/include/{}" {} \;
popd
rm -rf "$kobj"

git add uapi
git commit -s -F - <<EOT
update UAPI header copies

Update to kernel ${desc}.

EOT


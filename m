Return-Path: <linux-api+bounces-5803-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iC1mEYz4g2m0wQMAu9opvQ
	(envelope-from <linux-api+bounces-5803-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Thu, 05 Feb 2026 02:55:24 +0100
X-Original-To: lists+linux-api@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D9DECEDCAC
	for <lists+linux-api@lfdr.de>; Thu, 05 Feb 2026 02:55:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 09C3430074A8
	for <lists+linux-api@lfdr.de>; Thu,  5 Feb 2026 01:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D5EB299922;
	Thu,  5 Feb 2026 01:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u4MTjYBz"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 058EA1A23B1;
	Thu,  5 Feb 2026 01:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770256519; cv=none; b=tSO5MsOha7JXKG5RdDCkQ0/xFNsyt3DV8Ta3z74K94zkz0ystYrzXAiMKhespL1KjFwbrvht9scOO/Bs62Mb3Wgh0+jvBwBZ8CddXzHEwJO2NyjfPVFxh2qRR6Cl2aBH+Z7ivpnsG1342zdmMyhXHaohUzXuNXj0SHjNausgO6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770256519; c=relaxed/simple;
	bh=DqFzxfYKPrIKrr839txO83upVWq6NyZCqghWeivv+sM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jm90W8NQMcsFR/Vk2jwF1k/DHh2WDma+pE7GhtZoUfll6FJP/bpEjvIaLI82jlayqKyw2TOS9+tTDFZWPtnonasVl8R+9qLEpdvadjqA2t7UwOXQxJwN2fdrjhP731MoNyloojvA52it+brw2mqaIJopq0VP68KnLjXgRws3/28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u4MTjYBz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFC52C4CEF7;
	Thu,  5 Feb 2026 01:55:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770256518;
	bh=DqFzxfYKPrIKrr839txO83upVWq6NyZCqghWeivv+sM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=u4MTjYBzUC00Jp6Rz0XqqegSaclwupRA1DEMrwtQ8N9rHkJRVDInSW3JHT9UX1xMo
	 XxUiteY99zUGZ0zTEf39+is5Wg8dyRyqTNGS238N7RoGf5Jdup1jsgdY8I0Ehg9FFH
	 MLSys+JKlvQpuUIXImWIDq49UH+JCB0BZmr0vZMCt61jtrMcwCvnXLhrOKdE+yrauu
	 YPnRXW2gnG0n16PqCFnx/jNdV/IzB9kKyuNjAo+SCKVt+LUwoe+xQXdqrk+Eylimt5
	 oIRggQV7kkEatTNb9LArL2uuxwGFpla+txIj6KCQ7vPCwmlYOxVMIDrEIM+G0ASFON
	 iVZ8s7AXcPCZg==
Date: Wed, 4 Feb 2026 17:55:16 -0800
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
Message-ID: <20260204175516.4fb11966@kernel.org>
In-Reply-To: <20260204064248-d9c4ab78-f6d4-4ac6-8d55-e939bc1df6d2@linutronix.de>
References: <20260120-uapi-sockaddr-v2-0-63c319111cf6@linutronix.de>
	<20260121192729.2095aa25@kernel.org>
	<20260130112309-28f2645b-e756-4173-96da-cf5c59191520@linutronix.de>
	<20260130081741.425a92e0@kernel.org>
	<3c46fc49-b41b-44a2-b42a-669cc7e6bb02@linutronix.de>
	<20260131092517.6639d84c@kernel.org>
	<20260203122715-eeb304f9-4b42-4fc6-a527-658182a92ba5@linutronix.de>
	<20260203144011.32d5b223@kernel.org>
	<20260204064248-d9c4ab78-f6d4-4ac6-8d55-e939bc1df6d2@linutronix.de>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-5803-lists,linux-api=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: D9DECEDCAC
X-Rspamd-Action: no action

On Wed, 4 Feb 2026 06:51:46 +0100 Thomas Wei=C3=9Fschuh wrote:
> > make -j16 O=3D"$kobj" INSTALL_HDR_PATH=3D"${kobj}/hdr" headers_install
> > popd
> >=20
> > pushd uapi
> > find . -type f -name '*.h' -exec cp -v "${kobj}/hdr/include/{}" {} \; =
=20
>=20
> Here only those headers which already exist in ethtool's uapi/ directory
> are copied. As linux/typelimits.h is new, it is now missing.
> Honestly, if a user fiddles with the internals of the UAPI headers like
> this, it is on them to update their code if the internal structure
> changes. In your case a simple 'touch uapi/linux/typelimits.h'
> before running the script will be enough. Also internal.h now requires
> an explicit inclusion of <limits.h>, as that is not satisfied by the
> UAPI anymore.

Hopefully you understand that while due to uapi header copy this is not
a huge issue for ethtool itself, but it is a proof that your changes
can break normal user space applications which do not vendor in uapi.


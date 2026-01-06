Return-Path: <linux-api+bounces-5604-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CDCBCFB559
	for <lists+linux-api@lfdr.de>; Wed, 07 Jan 2026 00:13:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AEBFF302F6B0
	for <lists+linux-api@lfdr.de>; Tue,  6 Jan 2026 23:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDB2C2FD685;
	Tue,  6 Jan 2026 23:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bD4TTabC"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B17E62E542C;
	Tue,  6 Jan 2026 23:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767741194; cv=none; b=HCAWkWJ9+rTzSmDxSkjQlSpWhHbSxujZm3UlJ2ZECe/x/19Flt/7llEOXKnMwUHPl8W4SlrYZTytPaCrqw5R8PTpsJHTjW/diyRME5Xmy+2GIzEqe7u/GyXtlTXM3P9Xa2hxzfsgvoiW1uc70nu0JuogxTkUTdDGxsndFO14PpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767741194; c=relaxed/simple;
	bh=/ytDw2AdQR7uZ21ZJAztZBzoug6vYgK3l5h0rxyFnnQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NQDTMyVtW5UbtFbFZhUiwvbnb2DVBj+2GwDTmt6XDgB4p9pUJ97p62fDjJhHGzfkQ7L1KM4bbqVHB/IQYtnMWO5+igelCtJnQsNcB813KCxIkq9Mbxe6JtuF4OTy/wIHKvFTYAIuA8ZYFigVUTTVpGq2ggf9/WCvs939zcKdoj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bD4TTabC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A5F1C116C6;
	Tue,  6 Jan 2026 23:13:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767741194;
	bh=/ytDw2AdQR7uZ21ZJAztZBzoug6vYgK3l5h0rxyFnnQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bD4TTabCnqpOvjlPxal3FABWEJidSlDMLjfyCRwToqf8m7hgqGdU93Qvgqf22owUs
	 +rVFeyA/D2wz9NWsOwNFRG/VYRdhtyMQ4ARGWJvGn1ZiWOX7W3PssEkna8Kyw24Zs9
	 +pvJSTHE3Z5vzM05xtRR1L1lmXHD/wuXZGJe0EnCycRGDLHfGhd5hb8Va0iKzueAbA
	 ZAYrRfjIZQdpcrI3LBuUuMisg8/NAaIuKBubDNPRYjfxupfGg2b66UfqVKCBDVQl8a
	 D43/PFKptnxUxDn3RLNxbhQQNgGGq7fFvM9GZ0T1hv294UhdVe6+BjV1Owrmfrzf/3
	 fMIfCHIk1/ofg==
Date: Tue, 6 Jan 2026 15:13:13 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Thomas =?UTF-8?B?V2Vpw59zY2h1aA==?= <thomas.weissschuh@linutronix.de>
Cc: Eric Dumazet <edumazet@google.com>, Kuniyuki Iwashima
 <kuniyu@google.com>, Paolo Abeni <pabeni@redhat.com>, Willem de Bruijn
 <willemb@google.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-api@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH net-next] net: uapi: Provide an UAPI definition of
 'struct sockaddr'
Message-ID: <20260106151313.1f8bd508@kernel.org>
In-Reply-To: <20260106112714-d47c16e0-0020-4851-9c2a-f8849c9a0677@linutronix.de>
References: <20260105-uapi-sockaddr-v1-1-b7653aba12a5@linutronix.de>
	<20260105095713.0b312b26@kernel.org>
	<20260106112714-d47c16e0-0020-4851-9c2a-f8849c9a0677@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 6 Jan 2026 11:32:52 +0100 Thomas Wei=C3=9Fschuh wrote:
> As for the failure in netdev CI however I am not so sure.
> Looking at net-next-2026-01-05--12-00, the only failures triggered by my
> change are also the ones from the bpf-ci. Are these the ones you meant,
> or am I missing some others?

Multiple things broke at once so slightly hard to fish the relevant
stuff out from here:

https://netdev.bots.linux.dev/contest.html?branch=3Dnet-next-2026-01-05--15=
-00&pass=3D0&pw-n=3D0

Here's one:

make[1]: Entering directory '/home/virtme/testing/wt-3/tools/testing/selfte=
sts/net'
  CC       busy_poller
In file included from [01m[K/usr/include/sys/socket.h:33[m[K,
                 from [01m[K/usr/include/netinet/in.h:23[m[K,
                 from [01m[K/usr/include/arpa/inet.h:22[m[K,
                 from [01m[Kbusy_poller.c:14[m[K:
[01m[K/usr/include/bits/socket.h:182:8:[m[K [01;31m[Kerror: [m[Kredefinitio=
n of '[01m[Kstruct sockaddr[m[K'
  182 | struct [01;31m[Ksockaddr[m[K
      |        [01;31m[K^~~~~~~~[m[K
In file included from [01m[K/home/virtme/testing/wt-3/usr/include/linux/net=
link.h:6[m[K,
                 from [01m[K/home/virtme/testing/wt-3/usr/include/linux/gen=
etlink.h:6[m[K,
                 from [01m[K/home/virtme/testing/wt-3/tools/testing/selftes=
ts/../../../tools/net/ynl/lib/ynl.h:7[m[K,
                 from [01m[Kbusy_poller.c:12[m[K:
[01m[K/home/virtme/testing/wt-3/usr/include/linux/socket.h:37:8:[m[K [01;36=
m[Knote: [m[Koriginally defined here
   37 | struct [01;36m[Ksockaddr[m[K {
      |        [01;36m[K^~~~~~~~[m[K
make[1]: *** [../lib.mk:225: /home/virtme/testing/wt-3/tools/testing/selfte=
sts/net/busy_poller] Error 1

https://netdev-3.bots.linux.dev/vmksft-net-dbg/results/460421/7-xfrm-policy=
-sh/stdout



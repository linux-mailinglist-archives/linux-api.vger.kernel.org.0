Return-Path: <linux-api+bounces-5583-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 45472CF51C0
	for <lists+linux-api@lfdr.de>; Mon, 05 Jan 2026 18:57:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2A321302759D
	for <lists+linux-api@lfdr.de>; Mon,  5 Jan 2026 17:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF084340DAB;
	Mon,  5 Jan 2026 17:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g1fBSkCB"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F2F309EE3;
	Mon,  5 Jan 2026 17:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767635835; cv=none; b=O/HyXngCqZgvEJt+S7RWO1/5ZdtFq21EQAOrAjTgoYOb1+ln8sPYBwhHelT756MIcgxj9bxjjktI7Pftp71x0MlsxQHkpFnKEIjSlb1pK2RdZjGGYR6o74Nusa2qTRtbUYEPlFFMoE+qviETlGNfPtGmBWXSIC75hJVyDIueifk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767635835; c=relaxed/simple;
	bh=NtaZSCO9KW7l0uSIMpVyOuqz7irkENCI8cHbxZqeqlw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W6Ia7360O7I8pzF8qR84cOcnLn7J9OMRVc7OnIQT9LOTrPMrOIYglrdeqVze1cLwVYy7nt9c1YN8wDYg//5Ou0AhOH99coIdkd/DBcsOU2/yYe4EbM16+cSow+iFCdvCKdMS+8setfyZ0H1YKkNh55RBZZg3urWKcrHXtVpsNbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g1fBSkCB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE80FC19421;
	Mon,  5 Jan 2026 17:57:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767635834;
	bh=NtaZSCO9KW7l0uSIMpVyOuqz7irkENCI8cHbxZqeqlw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=g1fBSkCB0m5oWpWCIDFDtIHlZL8+f9s+tR5NOqDtOC5o1q/RdNFbwXfc1BjzqB7bt
	 MuzEpQ26x5aXXr1MHTQPZce5Jbr9Ko+jQRQuVz8p7OUlhw71VajZpkXchRsrOFMUIc
	 gadX5l186ubWDpH7hqZM8eqnDb95/SytLt/GI2y4HaXxveZeZXdxtTAPNm9eKvScb4
	 EyENqNv8mAQ2dmLWaFMEiG6OVdu/BucBnzLqKenhBv8VAm3NLP5dGNFVI8ckl6zpad
	 9DFdZi6t+Tx4vZBLa32tc4A7/qALq7/MrkM18DBhrUWrojFmA5/DLnwmEPWT8OmE8g
	 2g4Qe/L5I3K/Q==
Date: Mon, 5 Jan 2026 09:57:13 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Thomas =?UTF-8?B?V2Vpw59zY2h1aA==?= <thomas.weissschuh@linutronix.de>
Cc: Eric Dumazet <edumazet@google.com>, Kuniyuki Iwashima
 <kuniyu@google.com>, Paolo Abeni <pabeni@redhat.com>, Willem de Bruijn
 <willemb@google.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-api@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH net-next] net: uapi: Provide an UAPI definition of
 'struct sockaddr'
Message-ID: <20260105095713.0b312b26@kernel.org>
In-Reply-To: <20260105-uapi-sockaddr-v1-1-b7653aba12a5@linutronix.de>
References: <20260105-uapi-sockaddr-v1-1-b7653aba12a5@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 05 Jan 2026 09:25:55 +0100 Thomas Wei=C3=9Fschuh wrote:
> Various UAPI headers reference 'struct sockaddr'. Currently the
> definition of this struct is pulled in from the libc header
> sys/socket.h. This is problematic as it introduces a dependency
> on a full userspace toolchain.
>=20
> Instead expose a custom but compatible definition of 'struct sockaddr'
> in the UAPI headers. It is guarded by the libc compatibility
> infrastructure to avoid potential conflicts.
>=20
> The compatibility symbol won't be supported by glibc right away,
> but right now __UAPI_DEF_IF_IFNAMSIZ is not supported either,
> so including the libc headers before the UAPI headers is broken anyways.

I did not look too closely but this seems to break build of selftests
in netdev and BPF CI (netdev on AWS Linux, not sure what base BPF uses)


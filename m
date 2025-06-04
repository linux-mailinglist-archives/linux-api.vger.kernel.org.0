Return-Path: <linux-api+bounces-3867-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E0C3ACD9C0
	for <lists+linux-api@lfdr.de>; Wed,  4 Jun 2025 10:30:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7BC9189296D
	for <lists+linux-api@lfdr.de>; Wed,  4 Jun 2025 08:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD48E248868;
	Wed,  4 Jun 2025 08:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="3kNO32/T";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="B0dCDgh2"
X-Original-To: linux-api@vger.kernel.org
Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291241E5B9A;
	Wed,  4 Jun 2025 08:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749025813; cv=none; b=ihlwMCzzUhem96YpL2zwAGecUthaswZ8QPpyJnWMiVD3F0biQYmVb6HnzqfkG/HPiAHVT7mySwePbAw30oHrdTFfLMRHU9UwfGjGvrlOEgOfyjZ6YFWOpJpDs7WDanrPFFHQR01dJ8X8cMIF93cARGflcY3qHcLwK4HTY9EVI/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749025813; c=relaxed/simple;
	bh=ohZZM1a6GvrHLJsy9rYguqwft3kwfIMUGK9qwr9AwcM=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=GwHmiPxLZVa2fOYG8z8qxbarWTGW8AOvADmIAYFY1EnGgXRyeu51ION489OVng7d8FgXtqsbMNu1xHNwGPYrGfLkR3hNDLPS6WPQ53H3KmLBoC9n8DphQB5+xmSkj6Uv6b8QB6GI2oPgPnIZcS+jjsvb2i7mDfbkwRBdTlFhkz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=3kNO32/T; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=B0dCDgh2; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 4486C2540157;
	Wed,  4 Jun 2025 04:30:09 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-05.internal (MEProxy); Wed, 04 Jun 2025 04:30:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1749025809;
	 x=1749112209; bh=MHdehtHnGKHci8D3hzf9Adc0daDGyBQ3ajk9ljXsHgE=; b=
	3kNO32/TcODFKI1v6gjUoiKkIELbDMeGR9ZLiIQgoDlEOH1St5wDItMNjXVK8LDw
	RxJvS+cULZTADz5G1PPbfUmEtoTfUa6pd0J1LuXY7WIuxfKuIF5bq7NiBSs3XuaA
	Eb9qM10vfjCgRampbhVbbjzvmvuN6GWGnZ6lxmaxtl8gf0gn26Skh/9NYcT1BaRA
	Ex7CTOY0eDOcw6CfEqtebgel11PYoNj7a0JK+ogE77aLaec/GPUaZyXjU85l2J/j
	oRP4dpwwvzJ14MPQ7vDl3pFBMCY0pDzdCQV5Ab8XOHkFyepQsYFNVrJcmdnc+qkZ
	pz+4ZlBcfYJaWqITpugpjg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1749025809; x=
	1749112209; bh=MHdehtHnGKHci8D3hzf9Adc0daDGyBQ3ajk9ljXsHgE=; b=B
	0dCDgh2OtvY4Aclx8250zOMOYLF0UeyXxPM6Mlll1yRGzf0+heHX871Rf0xRNSQX
	XD3UkQ1+3B2VhdzC+EfByMjcofSpq/y6nvFZVo6aoGGQUb+5d4yZXhpm9dXhEMMq
	VVdUKFG8yAJaVhtkbiTGehvenJO35jlKgOaesahW+oyPfOlQ35FFu1fkTpv6RzB4
	bo0jLmxRIxrPnnTNtv9fBVDDW+/h8IOhEHZfdNoZ+6lm/sWVbfJG5hj7DHRvU1Px
	UMgDbDFllZqPEbfkLXoEli2m4ahzZ8jHZm8IuBcDs9YHu8w5fVRnK8v/WjOKbDQ9
	KW+b6qbkeX/6WLNZUiPqw==
X-ME-Sender: <xms:EARAaMCZtHCy87h6hlVNQ8B_ycPZmlgjsmE-hfBRkGGtUUZFzoUdHA>
    <xme:EARAaOgS_sNB8FIDAR_afIVMw_GjehpZEYs42WqO-V4wtBwvVp21apyyG7ptROAZv
    GOoXIGyjoydahQeDmU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugddukeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddt
    necuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrd
    guvgeqnecuggftrfgrthhtvghrnhephfdthfdvtdefhedukeetgefggffhjeeggeetfefg
    gfevudegudevledvkefhvdeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepiedp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmhgrrhhkrdhruhhtlhgrnhgusegrrh
    hmrdgtohhmpdhrtghpthhtohephihurhihrdhkhhhruhhsthgrlhgvvhesrghrmhdrtgho
    mhdprhgtphhtthhopegsrhgruhhnvghrsehkvghrnhgvlhdrohhrghdprhgtphhtthhope
    gsrhhoohhnihgvsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdgrphhi
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvg
    hlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:EARAaPnUak2Os3Qh_HjnaGbKIoYCWKk7aUo1TjfJGDUkTFP9XDVXfg>
    <xmx:EARAaCzQQ3ogJyrrOPNzq9354x8vRdAIa2Ocq0StLAWD4Iq3BN9dNg>
    <xmx:EARAaBTvukgQQFp3xYMki_rzZ3BgPmNhuRk6swSP3u7s8yp1MaHblA>
    <xmx:EARAaNZfuimUtp_XJmOS14RlhasuhMizFSZGG8ANRUETcn0woU2uyg>
    <xmx:EQRAaIxkVikd7fmK_pBX6AwTSZuzyTebm69kimRXGC9u4Fk3xSgcS-Wi>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id C756D700061; Wed,  4 Jun 2025 04:30:08 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Tda9afeb4aa183f99
Date: Wed, 04 Jun 2025 10:29:48 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Yury Khrustalev" <yury.khrustalev@arm.com>, linux-kernel@vger.kernel.org
Cc: "Christian Brauner" <brauner@kernel.org>,
 "Mark Brown" <broonie@kernel.org>, "Mark Rutland" <mark.rutland@arm.com>,
 linux-api@vger.kernel.org
Message-Id: <71c9bd77-85fd-4f00-a36a-8621640ebbb5@app.fastmail.com>
In-Reply-To: <aCs65ccRQtJBnZ_5@arm.com>
References: <aCs65ccRQtJBnZ_5@arm.com>
Subject: Re: Extending clone_args for clone3()
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, May 19, 2025, at 16:06, Yury Khrustalev wrote:
>
> This seems fragile and may call for writing cumbersome code. In essence,
> we will have to have clone30(), clone31(), clone32()... wrappers which
> probably defeats the point of why clone3 was added:
>
>
>   if (clone32_supported && clone32(...) == -1 && errno == E2BIG)
>     {
>       clone32_supported = false;
>       /* ... */
>     }
>   else if (clone31_supported && clone31(...) == -1 && errno == E2BIG)
>     {
>       clone12_supported = false;
>       /* ... */
>     }
>  ...
>
> Is there a neat way to work around this? What was the idea for extending
> clone_args in practice?
>
> I suppose we can't rely on kernel version because support for extended
> clone_args can be backported. In any case, we'd have to do a syscall
> for this (it would probably be great to have kernel version in auxv).

I don't think there is a generic way to handle extended syscalls
from libc, it really depends on the specific feature it's trying
to use that requires the additional fields to be nonzero: some features
may have a reasonable fallback implementation in libc, other features
still require an error to be passed back to the caller.

As I understand the shadow stack feature, we want this to be enabled
whenever the kernel and hardware supports it, completely transparent
to an application, right?

I think ideally we'd check for HWCAP_GCS on arm64 or the equivalent
feature on other architectures and expect clone3 to support the
longer argument whenever that is set, but it looks like that would
break on current kernels that already support HWCAP_GCS but not
the clone3 argument.

Adding one more hwcap flag would be ugly, but that seems to be
the easiest way. That way, glibc can just test for the new hwcap
flag only use the extra clone3 word if all prerequisites (hardware
support, kernel gcs support, clone3 argument support) are there.

     Arnd


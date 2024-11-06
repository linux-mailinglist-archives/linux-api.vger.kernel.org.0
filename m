Return-Path: <linux-api+bounces-2685-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 156E39BF5E9
	for <lists+linux-api@lfdr.de>; Wed,  6 Nov 2024 20:00:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC9811F222AC
	for <lists+linux-api@lfdr.de>; Wed,  6 Nov 2024 19:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 976EC209F4B;
	Wed,  6 Nov 2024 18:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bjIbhhfp"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6121D209669;
	Wed,  6 Nov 2024 18:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730919571; cv=none; b=tNR7KC+KB8mjF7RAPljTrbnN90m6GmW4HPX8GE4h1DeEXwJ7Od7Af1pFdK0pLrewWNp6BmwYQ7s7LoRtWYmcK+x+IB7mx7QdU3JjXmfDVNHZmleg85ZaGhGSrTR7hVjl2AUZ4wwhCsavKSndVsd/AspQkHIuLN5gdFO/HbAXIgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730919571; c=relaxed/simple;
	bh=uzE+jHM6reFxlcBS++xtK+Yy5TjZvLLnc84LFq6fMrA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AbkthFdw/aCv9730n15My8g7L8V3OQdXQgGAajaMU1kJAy6MqI5mQ2+WVrJ4wAebUPvSe2j3pI0jQ04oFT9tE0XvGg0YdS9cg6i0lXd+bV4MKDii3NIPozsU69/w6q0cMLrdy3B8IxjZQqixprd7t4V9OPw0sWz0832n+Tzrn0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bjIbhhfp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8997C4CEC6;
	Wed,  6 Nov 2024 18:59:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730919571;
	bh=uzE+jHM6reFxlcBS++xtK+Yy5TjZvLLnc84LFq6fMrA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=bjIbhhfpzQiKB7cLvzrZ+laG3jM3z3tIPBRyI4YA9cFztYK1IGKnaR8frkqUw0/hO
	 DlPJA9Hmj5wtkNAXApmxSFnh1cnALWcXQQkF7HNHLuDSe7TIu6Dv8DTBAPiMwfawIN
	 PJ5YDuTCL9eHx4SYNGDCpZXn3YoXT8tzMEgIpbJ7kbrX3RS6yyTy8xmvPkF1gTnRMH
	 VuVFbTwxMVyfEhgmrH1kom0PjQvbvMaJbTy5pYGKgirWHQgzXDCeOG8l8Y17gDnZJl
	 UgcZnJ9rx0HeD2nm6gSRbkCnWgCi/0FFXWX82WH6t6DA/6KoWtOh/uniZKhN2JxxdE
	 i1DX0usXBaYcw==
Message-ID: <f4d16944-1b60-4824-8d63-fc2d5de1722c@kernel.org>
Date: Wed, 6 Nov 2024 11:59:30 -0700
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/1] net/ipv6: Netlink flag for new IPv6 Default
 Routes
Content-Language: en-US
To: Matt Muggeridge <Matt.Muggeridge@hpe.com>, idosch@idosch.org
Cc: davem@davemloft.net, edumazet@google.com, horms@kernel.org,
 kuba@kernel.org, linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, pabeni@redhat.com, stable@vger.kernel.org
References: <Zypgu5l7F1FpIpqo@shredder>
 <20241106025056.11241-1-Matt.Muggeridge@hpe.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20241106025056.11241-1-Matt.Muggeridge@hpe.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/5/24 7:50 PM, Matt Muggeridge wrote:
> I'm a little surprised by this consideration. If we account for poorly
> written buggy user-programs, doesn't this open any API to an explosion
> of new attributes or other odd extensions? I'd imagine the same argument

yes, it does and there are many examples. UAPIs are hard to get right
yet persistent forever, so I do agree with Ido's push back on making
sure it is needed.



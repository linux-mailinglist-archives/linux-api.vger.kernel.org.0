Return-Path: <linux-api+bounces-2684-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC0E19BEA38
	for <lists+linux-api@lfdr.de>; Wed,  6 Nov 2024 13:42:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB93A280E78
	for <lists+linux-api@lfdr.de>; Wed,  6 Nov 2024 12:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 574EE1F76CA;
	Wed,  6 Nov 2024 12:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FFeZj506"
X-Original-To: linux-api@vger.kernel.org
Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC9C01F76B7;
	Wed,  6 Nov 2024 12:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730896665; cv=none; b=ta4Rq4TBhzMV0mXglgxBTsL+UKqoyAN0LUnWVzL4GxBl8QAlcI2kxrHBlrnqeSwgyyR/TIbYmxyYJADok7PRGuxEIgerihEbQ4baVzF19jLrspoJ4YKbZN1oEhu23qAyQgVRbEv8hjBJW2wugrhjyMS8omXvZvC9GI1V/5zCgoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730896665; c=relaxed/simple;
	bh=PK6WGWIzzUxygDZyxgAl8NGzW2USJnn+khK0DoMIIho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RoqiggxhkuBt4qJmebiAUQyEshrOtNJTpUauZoTHNZi01FjwOUQzIcmu0Y5mCZcMOGSaKIOy+QtVuSJuFdEfsiWEXZDK2L6axquiYyx0CDpxv+mVaLmoBrgMD8wfLfI60WPwKOFcnXfUxDeY2cK6Hns5g3nBA8ijmHIMEw1FRlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org; spf=none smtp.mailfrom=idosch.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FFeZj506; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 6B470114018D;
	Wed,  6 Nov 2024 07:37:41 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Wed, 06 Nov 2024 07:37:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1730896661; x=1730983061; bh=/jLOtRJkzelCEg/A2YxeNiDuCCzg/r1GPN8
	Ngxasi5k=; b=FFeZj5063QyYvANJ4SJWcaaccy8A0bFk2OeCPZAtb39xWa5aOns
	+cEa6SbJsOxnEPskn5onyWCbYpH5W7IVjtV66Uh02dq35Zc4Uwzwp+a6LaChdaNa
	vjEq45pwoMreBFAU2kyLSt4vX0WWBxZ98mjqisGdnZGkETAAk4C0lQGNC6DhS4dQ
	tByZ7oRPA+CVwzZwAB8oajs6SFQxYuXSUJVMe2X6ctCzrZPZ92Zwr0Qc2pwf5SYY
	kPaEBW9a6u7dsBfqDee0IFgMGvYJ2tTc5NSR0Wru7AKp02/W+CMp+ww5xHeEk6Gd
	WtT5sT/ky8hJgCEk9uIjDqinTLlqqeN+/PA==
X-ME-Sender: <xms:FGMrZ4NFfZ6crfnV-B9ekqcuwkjQ8yrVSIlhRcpGRH5itQgw2y9JRA>
    <xme:FGMrZ-9mhP4QXLq1v2NQt5KI2MqVNfIbdVmPuB03qMWw8Fs1tk88HfaEpcRFGfzCB
    KonPhaJF_bGW6U>
X-ME-Received: <xmr:FGMrZ_TljnC-Qc0vrGjE6VE5WDIW-QWDw2ixI0aQHpvU5DIlTR_Gs36tYqOedxhFVXEpDGBv4kCv5dsUtLut5R0wdMo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrtddvgdegudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecu
    hfhrohhmpefkughoucfutghhihhmmhgvlhcuoehiughoshgthhesihguohhstghhrdhorh
    hgqeenucggtffrrghtthgvrhhnpedvudefveekheeugeeftddvveefgfduieefudeifefg
    leekheegleegjeejgeeghfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehiughoshgthhesihguohhstghhrdhorhhgpdhnsggprhgtphhtthho
    peduuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmhgrthhtrdhmuhhgghgvrh
    hiughgvgeshhhpvgdrtghomhdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhht
    rdhnvghtpdhrtghpthhtohepughsrghhvghrnheskhgvrhhnvghlrdhorhhgpdhrtghpth
    htohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehhohhrmhhs
    sehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpd
    hrtghpthhtoheplhhinhhugidqrghpihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:FGMrZwuNRCmqAIpboIuYM4JVhlJRXvM4DPmvtZcQeDjorxdF-ZT9RQ>
    <xmx:FGMrZwe0T_WEWhy6cmI1Btx4gLkFG5pU7E29HW0dQJfJ9TpRfXs9lQ>
    <xmx:FGMrZ02NCJhF4HGMFPPIbKN3sQcQzQW263kKfXeUoadTa--BxnVxqw>
    <xmx:FGMrZ0_pMOapVd5zf7lFE_QlIN6UmH_1-Ztbqy-a7gRdWpeLa1ilzw>
    <xmx:FWMrZxVWN6yUr9Fvec4ds_qFDMWUZ40di6V-w1thbEHbzxS8kXh8TcyX>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 6 Nov 2024 07:37:39 -0500 (EST)
Date: Wed, 6 Nov 2024 14:37:36 +0200
From: Ido Schimmel <idosch@idosch.org>
To: Matt Muggeridge <Matt.Muggeridge@hpe.com>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
	horms@kernel.org, kuba@kernel.org, linux-api@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	pabeni@redhat.com, stable@vger.kernel.org
Subject: Re: [PATCH net 1/1] net/ipv6: Netlink flag for new IPv6 Default
 Routes
Message-ID: <ZytjEINNRmtpadr_@shredder>
References: <Zypgu5l7F1FpIpqo@shredder>
 <20241106025056.11241-1-Matt.Muggeridge@hpe.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241106025056.11241-1-Matt.Muggeridge@hpe.com>

On Tue, Nov 05, 2024 at 09:50:56PM -0500, Matt Muggeridge wrote:
> Thank you for your review and feedback, Ido.
> 
> >> Without this flag, when there are mutliple default routers, the kernel
> >> coalesces multiple default routes into an ECMP route. The ECMP route
> >> ignores per-route REACHABILITY information. If one of the default
> >> routers is unresponsive, with a Neighbor Cache entry of INCOMPLETE, then
> >> it can still be selected as the nexthop for outgoing packets. This
> >> results in an inability to communicate with remote hosts, even though
> >> one of the default routers remains REACHABLE. This violates RFC4861
> >> section 6.3.6, bullet 1.
> >
> >Do you have forwarding disabled (it causes RT6_LOOKUP_F_REACHABLE to be
> >set)?
> 
> Yes, forwarding is disabled on our embedded system. Though, this needs to
> work on systems regardless of the state of forwarding.
> 
> >  Is the problem that fib6_table_lookup() chooses a reachable
> >nexthop and then fib6_select_path() overrides it with an unreachable
> >one?
> 
> I'm afraid I don't know.

We need to understand the current behavior before adding a new interface
that we will never be able to remove. It is possible we can improve /
fix the current code. I won't have time to look into it myself until
next week.

> 
> The objective is to allow IPv6 Netlink clients to be able to create default
> routes from RAs in the same way the kernel creates default routes from RAs.
> Essentially, I'm trying to have Netlink and Kernel behaviors match.

I understand, but it's essentially an extension for the legacy IPv6
multipath API which we are trying to move away from towards the nexthop
API (see more below).

> 
> My analysis led me to the need for Netlink clients to set the kernel's
> fib6_config flags RTF_RA_ROUTER, where:
> 
>     #define RTF_RA_ROUTER		(RTF_ADDRCONF | RTF_DEFAULT)
> 
> >> +	if (rtm->rtm_flags & RTM_F_RA_ROUTER)
> >> +		cfg->fc_flags |= RTF_RA_ROUTER;
> >> +
> > 
> > It is possible there are user space programs out there that set this bit
> > (knowingly or not) when sending requests to the kernel and this change
> > will result in a behavior change for them. So, if we were to continue in
> > this path, this would need to be converted to a new netlink attribute to
> > avoid such potential problems.
> > 
> 
> Is this a mandated approach to implementing unspecified bits in a flag?
> 
> I'm a little surprised by this consideration. If we account for poorly
> written buggy user-programs, doesn't this open any API to an explosion
> of new attributes or other odd extensions? I'd imagine the same argument
> would be applicable to ioctl flags, socket flags, and so on. Why would we
> treat implementing unspecified Netlink bits differently to implementing
> unspecified ioctl bits, etc.
> 
> Naturally, if this is the mandated approach, then I'll reimplement it with
> a new Netlink attribute. I'm just trying to understand what is the
> Linux-lore, here?

Using this bit could have been valid if previously the kernel rejected
requests with this bit set, but as evident by your patch the kernel does
not do it. It is therefore possible that there are user space programs
out there that are working perfectly fine right now and they will break
/ misbehave after this change.

> 
> > BTW, you can avoid the coalescing problem by using the nexthop API (man
> > ip-nexthop).
> 
> I'm not sure how that would help in this case. We need the nexthop to be
> determined according to its REACHABILITY and other considerations described
> in RFC4861.

Using your example:

# ip nexthop add id 1 via fe80::200:10ff:fe10:1060 dev enp0s9
# ip -6 route add default nhid 1 expires 600 proto ra
# ip nexthop add id 2 via fe80::200:10ff:fe10:1061 dev enp0s9
# ip -6 route append default nhid 2 expires 600 proto ra
# ip -6 route
fe80::/64 dev enp0s9 proto kernel metric 256 pref medium
default nhid 1 via fe80::200:10ff:fe10:1060 dev enp0s9 proto ra metric 1024 expires 563sec pref medium
default nhid 2 via fe80::200:10ff:fe10:1061 dev enp0s9 proto ra metric 1024 expires 594sec pref medium


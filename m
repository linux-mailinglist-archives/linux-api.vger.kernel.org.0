Return-Path: <linux-api+bounces-2688-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47F4E9C018E
	for <lists+linux-api@lfdr.de>; Thu,  7 Nov 2024 10:54:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECFDC1F23BC0
	for <lists+linux-api@lfdr.de>; Thu,  7 Nov 2024 09:54:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 639581EF080;
	Thu,  7 Nov 2024 09:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IfmGvCzR"
X-Original-To: linux-api@vger.kernel.org
Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A3EB1DB54B;
	Thu,  7 Nov 2024 09:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730973152; cv=none; b=KDakeALobYGigG0tVc3J7FGZluccgtSMxpKV7FwnDB88vfrL00vejcywV4EyPgscb6nYG7Gz0aXGARjiJCROPgntV12Qy9FDPsGV3S0/Jh+EOtOEzntoplpiOR3hQ/CV2uw7NiKkA4WeX8q5DZ69gUoaEKXSl7JlwR5IPm008es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730973152; c=relaxed/simple;
	bh=VztDLWxUXtgG25+i0M5xW2ZyIXyhdWw+s6kVl5FgXyU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wys5HwTgQxDjiR/Eq15BbREIW5eLXJg9nhpOnmGN3NFzMxp64FZW8Uo8KEUNsdffPDaucODwZNpj9rNOXPNLjdglYvNv7BLg1fQ4OFu1v5ReI4tzyxQWKws5E9yap04KeUXKL3Iq9wGlK74mg+P2rb6bNbq0AepDvRS6MejeCv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org; spf=none smtp.mailfrom=idosch.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IfmGvCzR; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 1E70513806A8;
	Thu,  7 Nov 2024 04:52:29 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Thu, 07 Nov 2024 04:52:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1730973149; x=1731059549; bh=03kWA3JRtu4T5mhalhuq/QQtAHUUB9dIoXw
	69Q0F+bw=; b=IfmGvCzRvu8A8fkvtA6BDh5T4X44JDv6lSUc61gfeKwAJ5+GBJG
	f3UBAEYhCuIx++qFsRnsWGnhCUudBE5l6i0YCERtA9llieSl/Q+R/TlqMZSX53fJ
	LbFFW7qRaZhtlPnTiEPKFydl7B1NZwiBTBAYmG9IEj5ZM6EaevLhlyBby8clzlE2
	SfrKcgbD4XvXGBMv0/d658kXpe8lH9A/os7T4k1/H9twaqt8UanssSEhBPy042qy
	zrODgSHNf6vjb/cCrMIWx1T0OV61BRNBYxPbHz4KxWfZ5+MdLFLoKhR/+OPrlZQB
	Lms32NjnS+qRrf8bm8zziD0+DlFUoHOGZXg==
X-ME-Sender: <xms:3I0sZ64PywGHYmqOoHxShgKMMQJLHQsMyYdqS90td-6Hy4NPAdhpCg>
    <xme:3I0sZz4d6tNJmeYXblPyDoFWypaGfdkp9jNsabq52gL2fuKc3x16SlVhNcLLymDkW
    zRK4FiThbdfjIY>
X-ME-Received: <xmr:3I0sZ5d_fEEM2YDXtK2fkVqL-v5kFY_EAAq3O8GHHESVSrfbMgyRXBIQcDnslYiwMFitAE3XAXiveQS1JC4jxvJvhZI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrtdeggddtlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecu
    hfhrohhmpefkughoucfutghhihhmmhgvlhcuoehiughoshgthhesihguohhstghhrdhorh
    hgqeenucggtffrrghtthgvrhhnpefhffejgefhjeehjeevheevhfetveevfefgueduueei
    vdeijeeihfegheeljefgueenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepihguohhstghhsehi
    ughoshgthhdrohhrghdpnhgspghrtghpthhtohepuddupdhmohguvgepshhmthhpohhuth
    dprhgtphhtthhopehmrghtthdrmhhughhgvghrihgughgvsehhphgvrdgtohhmpdhrtghp
    thhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegushgrhh
    gvrhhnsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegvughumhgriigvthesghhoohhg
    lhgvrdgtohhmpdhrtghpthhtohephhhorhhmsheskhgvrhhnvghlrdhorhhgpdhrtghpth
    htohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdgrphhi
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvg
    hlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnhgvthguvghvsehvghgv
    rhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:3I0sZ3Jpu5K849KnOSdz-22lJUFsubxt_CBXYObVco061E4PNr6p5g>
    <xmx:3I0sZ-IV5CcIPlOW8MbrsExHySQNSF822SI_XZYqxTaolhjlRbXHlw>
    <xmx:3I0sZ4z5BJFcQKdreAno6VmFyBoouSvuqwQkhq1cv76U7tINEljAdQ>
    <xmx:3I0sZyKa_x4-qNHAYfc73sLegu2rPIIn0Ddm5QpsL90eHPPTmPRm9A>
    <xmx:3Y0sZ7Dk4yNdFj49Sq0YA3BAQmpvlcKcdmqMMTz6xD77Gb6Zzdl26s7r>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 7 Nov 2024 04:52:28 -0500 (EST)
Date: Thu, 7 Nov 2024 11:52:25 +0200
From: Ido Schimmel <idosch@idosch.org>
To: Matt Muggeridge <Matt.Muggeridge@hpe.com>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
	horms@kernel.org, kuba@kernel.org, linux-api@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	pabeni@redhat.com, stable@vger.kernel.org
Subject: Re: [PATCH net 1/1] net/ipv6: Netlink flag for new IPv6 Default
 Routes
Message-ID: <ZyyN2bSgrpbhbkpp@shredder>
References: <ZytjEINNRmtpadr_@shredder>
 <20241107035303.24057-1-Matt.Muggeridge@hpe.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241107035303.24057-1-Matt.Muggeridge@hpe.com>

On Wed, Nov 06, 2024 at 10:53:03PM -0500, Matt Muggeridge wrote:
> Hi Ido,
> 
> > >>> Is the problem that fib6_table_lookup() chooses a reachable
> > >>> nexthop and then fib6_select_path() overrides it with an unreachable
> > >>> one?
> > 
> > >> I'm afraid I don't know.
> > >>
> > > We need to understand the current behavior before adding a new interface
> > > that we will never be able to remove. It is possible we can improve /
> > > fix the current code. I won't have time to look into it myself until
> > > next week.
> 
> I am grateful that you want to look into it. Thank you! And I look forward to
> learning what you discover.
> 
> You probably already know how to reproduce it, but in case it helps, I still
> have the packet captures and can share them with you. Let me know if you'd
> like me to share them (and how to share them).

It would be best if you could provide a reproducer using iproute2:
Configure a dummy device using ip-link, install the multipath route
using ip-route, configure the neighbour table using ip-neigh and then
perform route queries using "ip route get ..." showing the problem. We
can then use it as the basis for a new test case in
tools/testing/selftests/net/fib_tests.sh 

BTW, do you have CONFIG_IPV6_ROUTER_PREF=y in your config?

> 
> > > 
> > > The objective is to allow IPv6 Netlink clients to be able to create default
> > > routes from RAs in the same way the kernel creates default routes from RAs.
> > > Essentially, I'm trying to have Netlink and Kernel behaviors match.
> > 
> > I understand, but it's essentially an extension for the legacy IPv6
> > multipath API which we are trying to move away from towards the nexthop
> > API (see more below).
> 
> Very interesting, I wasn't aware of this movement.
> 
> While this change is an extension of the legacy IPv6 multipath API, won't it
> still need to support Netlink clients that have been designed around it? I
> imagine that transitioning Netlink clients to the NH API will take many years?

FRR already supports it and I saw that there is some support for nexthop
objects in systemd:

https://github.com/systemd/systemd/pull/13735

> 
> As such, it still seems appropriate (to me) that this be implemented in the
> legacy API as well as ensuring it works with the NH API.

As I understand it you currently get different results because the
kernel installs two default routes whereas user space can only create
one default multipath route. Before adding a new uAPI I want to
understand the source of the difference and see if we can improve / fix
the current multipath code so that the two behave the same. If we can
get them to behave the same then I don't think user space will care
about two default routes versus one default multipath route.

> 
> Another consideration...
> 
> Will the kernel RA processing go through the same nh pathway? The reason I
> ask is because I faced several challenges with IPv6 Logo certification due to
> Netlink clients being unable to achieve the same as the kernel's behavior.

If you are asking if the kernel can install RA routes using nexthop
objects, then the answer is no. Only user space can create nexthop
objects and I don't think we want to allow the kernel to do that.

> 
> As long as the kernel is creating RA routes in a way that meets RFC4861, then
> I'd hope that  Netlink clients would be able to leverage that for 'free'.
> 
> > > 
> > > My analysis led me to the need for Netlink clients to set the kernel's
> > > fib6_config flags RTF_RA_ROUTER, where:
> > > 
> > >     #define RTF_RA_ROUTER		(RTF_ADDRCONF | RTF_DEFAULT)
> > > 
> > >>> +	if (rtm->rtm_flags & RTM_F_RA_ROUTER)
> > >>> +		cfg->fc_flags |= RTF_RA_ROUTER;
> > >>> +
> > >> 
> > >> It is possible there are user space programs out there that set this bit
> > >> (knowingly or not) when sending requests to the kernel and this change
> > >> will result in a behavior change for them. So, if we were to continue in
> > >> this path, this would need to be converted to a new netlink attribute to
> > >> avoid such potential problems.
> > >> 
> > > 
> > > Is this a mandated approach to implementing unspecified bits in a flag?
> > > 
> > > I'm a little surprised by this consideration. If we account for poorly
> > > written buggy user-programs, doesn't this open any API to an explosion
> > > of new attributes or other odd extensions? I'd imagine the same argument
> > > would be applicable to ioctl flags, socket flags, and so on. Why would we
> > > treat implementing unspecified Netlink bits differently to implementing
> > > unspecified ioctl bits, etc.
> > > 
> > > Naturally, if this is the mandated approach, then I'll reimplement it with
> > > a new Netlink attribute. I'm just trying to understand what is the
> > > Linux-lore, here?
> > 
> > Using this bit could have been valid if previously the kernel rejected
> > requests with this bit set, but as evident by your patch the kernel does
> > not do it. It is therefore possible that there are user space programs
> > out there that are working perfectly fine right now and they will break
> > / misbehave after this change.
> > 
> 
> Understood and I agree.
> 
> > > 
> > >> BTW, you can avoid the coalescing problem by using the nexthop API (man
> > >> ip-nexthop).
> > > 
> > > I'm not sure how that would help in this case. We need the nexthop to be
> > > determined according to its REACHABILITY and other considerations described
> > > in RFC4861.
> > 
> > Using your example:
> > 
> > # ip nexthop add id 1 via fe80::200:10ff:fe10:1060 dev enp0s9
> > # ip -6 route add default nhid 1 expires 600 proto ra
> > # ip nexthop add id 2 via fe80::200:10ff:fe10:1061 dev enp0s9
> > # ip -6 route append default nhid 2 expires 600 proto ra
> > # ip -6 route
> > fe80::/64 dev enp0s9 proto kernel metric 256 pref medium
> > default nhid 1 via fe80::200:10ff:fe10:1060 dev enp0s9 proto ra metric 1024 expires 563sec pref medium
> > default nhid 2 via fe80::200:10ff:fe10:1061 dev enp0s9 proto ra metric 1024 expires 594sec pref medium
> 
> Thanks! That looks like it should work. I'll raise this with the the developers
> of systemd-networkd.
> 
> Just to confirm; are these two nhid routes equivalent to having two separate
> default routes that are created when the kernel processes IPv6 RAs?
> 
> Specifically, if one of these nhid routes becomes UNREACHABLE, will that be
> taken into consideration during the routing decision? (I'm guessing so?)

I didn't test it, but I don't see a reason for these two routes to
behave differently than two default routes installed with legacy
nexthops.


Return-Path: <linux-api+bounces-2680-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BAF9B9BD45B
	for <lists+linux-api@lfdr.de>; Tue,  5 Nov 2024 19:15:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF24F1C2351D
	for <lists+linux-api@lfdr.de>; Tue,  5 Nov 2024 18:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA56C1E7653;
	Tue,  5 Nov 2024 18:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OC2e4KHH"
X-Original-To: linux-api@vger.kernel.org
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0904F1E8822;
	Tue,  5 Nov 2024 18:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730830533; cv=none; b=EZf/BnEdPxWFg0w50jq1aZ0eqok9eDWRBaF9wJ8WrcZS4LH5/QbOApSl4zTsBU1TsFZHlGkQbmfyKXcr7Qtj4bCUMNWLOi3iWP3Su7zKb6IiMidpIX6zagz2cJv/MIJM4fdUugzM5VWwwLSa0FdWJz5gc/Kouo/OxAGk0cb94hI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730830533; c=relaxed/simple;
	bh=KHMhcd2dX5AteDzPwC6Lkg81FQ7PC5bpgO4ziiWOBGw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DqRAJ9gK+lTt5Fiq5PA77T6l9c9lFmbT18AO7/VtGnLeox79INvYK+Yrl6maoJHz4fl3VCt7J5iAbn/E1oErUuJl9yBqGRvyO+6K2v/TjfgKxv6iYM7tBiQiUHU4uhduFzNWpi3N7RKFUPe1+9y5cEUPgCIgSMy7jeAazMrnsGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org; spf=none smtp.mailfrom=idosch.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OC2e4KHH; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id B00231140135;
	Tue,  5 Nov 2024 13:15:28 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Tue, 05 Nov 2024 13:15:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1730830528; x=1730916928; bh=Q4lj4SJxdAtlvZHmgz3KaxbpnlDwPPKWs6D
	0Kdlb+00=; b=OC2e4KHHhH9LrshS8cnnVTFU2hhJu/hN/6lGjqqt+Fi4XHZpbhY
	TVP+EM9CXdHlZD4mI3dS3gldaSiKYKZBiFEpB1zL1P0T/fYu7CGOnWiwcbfxrq/M
	qNnuA95YPvw7qWo8t3WgIUT4oiXoAGQrte0itQPTKJvDBNDb46Da8U/IKbSR1FjS
	uyXRqv18mEVBYGGB//sIhAfBDuZz4K8gBTVhXDGYJf79kbPBVPECwxl2PZ3ts4Vi
	eA7pEp9I/IK6P5ap10LLjtr2JQyV+0mbRTRQH5YmGmUblssYbFcf0vmoLZxZhDth
	1UOLRanxQHpXgdYSJq1r2abFggqEsZFEVWA==
X-ME-Sender: <xms:v2AqZyVKpYmGkVXoqKlHChfK3-4NZGVyJTdbTHRZyPNB2V5YQkdQVw>
    <xme:v2AqZ-nrD9SGZrPKK66uV2WyjKCqmnhjyjiWsJY_afkW_c_mxfYmcVeQbBQFKD1lD
    SIwiA8FnYQ_7kc>
X-ME-Received: <xmr:v2AqZ2Yg5xgBQLYYeL_jO-kWrjyXAX7TFgVNXX20DUyfR2cg_OUgeAjgBsrj>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrtddtgdekudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecu
    hfhrohhmpefkughoucfutghhihhmmhgvlhcuoehiughoshgthhesihguohhstghhrdhorh
    hgqeenucggtffrrghtthgvrhhnpefhffejgefhjeehjeevheevhfetveevfefgueduueei
    vdeijeeihfegheeljefgueenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepihguohhstghhsehi
    ughoshgthhdrohhrghdpnhgspghrtghpthhtohepuddupdhmohguvgepshhmthhpohhuth
    dprhgtphhtthhopehmrghtthdrmhhughhgvghrihgughgvsehhphgvrdgtohhmpdhrtghp
    thhtohepughsrghhvghrnheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrvhgvmh
    esuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopehlihhnuhigqdgrphhisehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhtrggslhgvsehvghgvrhdrkhgvrh
    hnvghlrdhorhhgpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdp
    rhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgrsggvnh
    hisehrvgguhhgrthdrtghomhdprhgtphhtthhopehhohhrmhhssehkvghrnhgvlhdrohhr
    gh
X-ME-Proxy: <xmx:v2AqZ5Xbb9g-qq561eNL0d5iyYB3Ts6BgErQ9CeZdXvZTwjAq2LafQ>
    <xmx:wGAqZ8kgiIaPKRz0K0jDj6MR2U03uge1X_bO3iWMhGdQhhJ-LWwv_w>
    <xmx:wGAqZ-cnnZ0yyqIbUN1YR6-Uzhrqc6ZoPBUZgWGgS_ciWnvfk7AvjA>
    <xmx:wGAqZ-EYVdu2-omPjewQtjBZsEINOloTN-XnRrtwf6iDRzR679dnEw>
    <xmx:wGAqZ1d3TASVssfV-p41QwxZbbTpMRfzKtPvce7UYmj45iP8u5IoRnSB>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 5 Nov 2024 13:15:26 -0500 (EST)
Date: Tue, 5 Nov 2024 20:15:23 +0200
From: Ido Schimmel <idosch@idosch.org>
To: Matt Muggeridge <Matt.Muggeridge@hpe.com>
Cc: David Ahern <dsahern@kernel.org>,
	"David S . Miller" <davem@davemloft.net>, linux-api@vger.kernel.org,
	stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 1/1] net/ipv6: Netlink flag for new IPv6 Default
 Routes
Message-ID: <Zypgu5l7F1FpIpqo@shredder>
References: <20241105031841.10730-1-Matt.Muggeridge@hpe.com>
 <20241105031841.10730-2-Matt.Muggeridge@hpe.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241105031841.10730-2-Matt.Muggeridge@hpe.com>

On Mon, Nov 04, 2024 at 10:18:39PM -0500, Matt Muggeridge wrote:
> Add a Netlink rtm_flag, RTM_F_RA_ROUTER for the RTM_NEWROUTE message.
> This allows an IPv6 Netlink client to indicate the default route came
> from an RA. This results in the kernel creating individual default
> routes, rather than coalescing multiple default routes into a single
> ECMP route.
> 
> Details:
> 
> For IPv6, a Netlink client is unable to create default routes in the
> same manner as the kernel. This leads to failures when there are
> multiple default routers, as they were being coalesced into a single
> ECMP route. When one of the ECMP default routers becomes UNREACHABLE, it
> was still being selected as the nexthop.
> 
> Meanwhile, when the kernel processes RAs from multiple default routers,
> it sets the fib6_flags: RTF_ADDRCONF | RTF_DEFAULT. The RTF_ADDRCONF
> flag is checked by rt6_qualify_for_ecmp(), which returns false when
> ADDRCONF is set. As such, the kernel creates separate default routes.
> 
> E.g. compare the routing tables when RAs are processed by the kernel
> versus a Netlink client (systemd-networkd, in my case).
> 
> 1) RA Processed by kernel (accept_ra = 2)
> $ ip -6 route
> 2001:2:0:1000::/64 dev enp0s9 proto kernel metric 256 expires ...
> fe80::/64 dev enp0s9 proto kernel metric 256 pref medium
> default via fe80::200:10ff:fe10:1060 dev enp0s9 proto ra ...
> default via fe80::200:10ff:fe10:1061 dev enp0s9 proto ra ...
> 
> 2) RA Processed by Netlink client (accept_ra = 0)
> $ ip -6 route
> 2001:2:0:1000::/64 dev enp0s9 proto ra metric 1024 expires ...
> fe80::/64 dev enp0s3 proto kernel metric 256 pref medium
> fe80::/64 dev enp0s9 proto kernel metric 256 pref medium
> default proto ra metric 1024 expires 595sec pref medium
> 	nexthop via fe80::200:10ff:fe10:1060 dev enp0s9 weight 1
> 	nexthop via fe80::200:10ff:fe10:1061 dev enp0s9 weight 1
> 
> IPv6 Netlink clients need a mechanism to identify a route as coming from
> an RA. i.e. a Netlink client needs a method to set the kernel flags:
> 
>     RTF_ADDRCONF | RTF_DEFAULT
> 
> This is needed when there are multiple default routers that each send
> an RA. Setting the RTF_ADDRCONF flag ensures their fib entries do not
> qualify for ECMP routes, see rt6_qualify_for_ecmp().
> 
> To achieve this, introduce a user-level flag RTM_F_RA_ROUTER that a
> Netlink client can pass to the kernel.
> 
> A Netlink user-level network manager, such as systemd-networkd, may set
> the RTM_F_RA_ROUTER flag in the Netlink RTM_NEWROUTE rtmsg. When set,
> the kernel sets RTF_RA_ROUTER in the fib6_config fc_flags. This causes a
> default route to be created in the same way as if the kernel processed
> the RA, via rt6add_dflt_router().
> 
> This is needed by user-level network managers, like systemd-networkd,
> that prefer to do the RA processing themselves. ie. they disable the
> kernel's RA processing by setting net.ipv6.conf.<intf>.accept_ra=0.
> 
> Without this flag, when there are mutliple default routers, the kernel
> coalesces multiple default routes into an ECMP route. The ECMP route
> ignores per-route REACHABILITY information. If one of the default
> routers is unresponsive, with a Neighbor Cache entry of INCOMPLETE, then
> it can still be selected as the nexthop for outgoing packets. This
> results in an inability to communicate with remote hosts, even though
> one of the default routers remains REACHABLE. This violates RFC4861
> section 6.3.6, bullet 1.

Do you have forwarding disabled (it causes RT6_LOOKUP_F_REACHABLE to be
set)? Is the problem that fib6_table_lookup() chooses a reachable
nexthop and then fib6_select_path() overrides it with an unreachable
one?

> 
> Extract from RFC4861 6.3.6 bullet 1:
>      1) Routers that are reachable or probably reachable (i.e., in any
>         state other than INCOMPLETE) SHOULD be preferred over routers
>         whose reachability is unknown or suspect (i.e., in the
>         INCOMPLETE state, or for which no Neighbor Cache entry exists).
> 
> This fixes the IPv6 Logo conformance test v6LC_2_2_11, and others that
> test with multiple default routers. Also see systemd issue #33470:
> https://github.com/systemd/systemd/issues/33470.
> 
> Signed-off-by: Matt Muggeridge <Matt.Muggeridge@hpe.com>
> Cc: David Ahern <dsahern@kernel.org>
> Cc: David S. Miller <davem@davemloft.net>
> Cc: linux-api@vger.kernel.org
> Cc: stable@vger.kernel.org
> ---
>  include/uapi/linux/rtnetlink.h | 9 +++++----
>  net/ipv6/route.c               | 3 +++
>  2 files changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/include/uapi/linux/rtnetlink.h b/include/uapi/linux/rtnetlink.h
> index 3b687d20c9ed..9f0259f6e4ed 100644
> --- a/include/uapi/linux/rtnetlink.h
> +++ b/include/uapi/linux/rtnetlink.h
> @@ -202,7 +202,7 @@ enum {
>  #define RTM_NR_FAMILIES	(RTM_NR_MSGTYPES >> 2)
>  #define RTM_FAM(cmd)	(((cmd) - RTM_BASE) >> 2)
>  
> -/* 
> +/*
>     Generic structure for encapsulation of optional route information.
>     It is reminiscent of sockaddr, but with sa_family replaced
>     with attribute type.
> @@ -242,7 +242,7 @@ struct rtmsg {
>  
>  	unsigned char		rtm_table;	/* Routing table id */
>  	unsigned char		rtm_protocol;	/* Routing protocol; see below	*/
> -	unsigned char		rtm_scope;	/* See below */	
> +	unsigned char		rtm_scope;	/* See below */
>  	unsigned char		rtm_type;	/* See below	*/
>  
>  	unsigned		rtm_flags;
> @@ -336,6 +336,7 @@ enum rt_scope_t {
>  #define RTM_F_FIB_MATCH	        0x2000	/* return full fib lookup match */
>  #define RTM_F_OFFLOAD		0x4000	/* route is offloaded */
>  #define RTM_F_TRAP		0x8000	/* route is trapping packets */
> +#define RTM_F_RA_ROUTER		0x10000	/* route is a default route from RA */
>  #define RTM_F_OFFLOAD_FAILED	0x20000000 /* route offload failed, this value
>  					    * is chosen to avoid conflicts with
>  					    * other flags defined in
> @@ -568,7 +569,7 @@ struct ifinfomsg {
>  };
>  
>  /********************************************************************
> - *		prefix information 
> + *		prefix information
>   ****/
>  
>  struct prefixmsg {
> @@ -582,7 +583,7 @@ struct prefixmsg {
>  	unsigned char	prefix_pad3;
>  };
>  
> -enum 
> +enum
>  {
>  	PREFIX_UNSPEC,
>  	PREFIX_ADDRESS,
> diff --git a/net/ipv6/route.c b/net/ipv6/route.c
> index b4251915585f..5b0c16422720 100644
> --- a/net/ipv6/route.c
> +++ b/net/ipv6/route.c
> @@ -5055,6 +5055,9 @@ static int rtm_to_fib6_config(struct sk_buff *skb, struct nlmsghdr *nlh,
>  	if (rtm->rtm_flags & RTM_F_CLONED)
>  		cfg->fc_flags |= RTF_CACHE;
>  
> +	if (rtm->rtm_flags & RTM_F_RA_ROUTER)
> +		cfg->fc_flags |= RTF_RA_ROUTER;
> +

It is possible there are user space programs out there that set this bit
(knowingly or not) when sending requests to the kernel and this change
will result in a behavior change for them. So, if we were to continue in
this path, this would need to be converted to a new netlink attribute to
avoid such potential problems.

BTW, you can avoid the coalescing problem by using the nexthop API (man
ip-nexthop).

>  	cfg->fc_flags |= (rtm->rtm_flags & RTNH_F_ONLINK);
>  
>  	if (tb[RTA_NH_ID]) {
> -- 
> 2.35.3
> 
> 


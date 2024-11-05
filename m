Return-Path: <linux-api+bounces-2674-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E0059BCF93
	for <lists+linux-api@lfdr.de>; Tue,  5 Nov 2024 15:37:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCFC1286C2E
	for <lists+linux-api@lfdr.de>; Tue,  5 Nov 2024 14:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DAF41D967F;
	Tue,  5 Nov 2024 14:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="ceTtK023"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7351F33080
	for <linux-api@vger.kernel.org>; Tue,  5 Nov 2024 14:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730817458; cv=none; b=XnqZtpSZ2yYRFV658HvUZHAqPtq9x7hGSF7BBRjmX+jik72PH+7iCYERsZ/Nb0oApvVnqUXObo0CCUC/qecMjcdG43LGrl8Uk71+h8Mw7z14WopcENJLT72Wg/mONB98cR6dHyww8LbS3ATpM4Mg38Qrm+Rd6XXqVl9uVOdPJzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730817458; c=relaxed/simple;
	bh=UI80saSNGQyeENZwHXQ20TbdoevVCEFmRy69WMBcnh8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i1Bn83BzQoY/LhKy+kebHSBRH4u71tfkkfqKSHb/XGz7I4JaIuMQzhPLVLnkdiWlfASfmvmssfjOcRZIFMtldbM7vk2vdLxEXjwuNXGrbHM1izIpI708GkPrnG/51LWNL7eaDXv4d/WowrFqUczh+GPOlf1iDQFGyoyEhZHG4MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=ceTtK023; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5cec9acefb8so310168a12.3
        for <linux-api@vger.kernel.org>; Tue, 05 Nov 2024 06:37:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1730817455; x=1731422255; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=QPuUXaKIVWgxMoZDzRHV+Ij4osZDivWBSJCKiW/uKdM=;
        b=ceTtK0234IYVNp/EIGkh++V05nPwxZ2IpTDcEx37waKxh6Wrz9KH1czC8g/KyJQueT
         fAh3eLysjhKwQtZhCArJW0Mxcx903RqK6LyTDFKrIg+1weiVJxzyZLIqT8gcMjtyzcWz
         IS9lDdBNcVZJzTo1BrrkXT0B4RjTlGEbQnLYIr32imjY1mV+QzjgA7miu4srhHTVWAGt
         Q67uMOqnpGJfLXYV/Y47A0ni99CVEfqiuiuZDi4OW74zf6TsY52AbRzUNap+I6GJEeaF
         5vgToOhS9ku0VjNcK4eTDx/9wBiWYcV7X1LPgps39BqQfhecFt1Fa/qTaXlVVOenfZ5e
         Kytw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730817455; x=1731422255;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QPuUXaKIVWgxMoZDzRHV+Ij4osZDivWBSJCKiW/uKdM=;
        b=YOgg31IyCY+SsqkyaKqWtukYm3UoF1LuRcNlSZZyNyAGf56Zy3aROYTh81WXTE3b4k
         ME1px96S4KSObvY8O0YCRZgsegYBHchrQ1zVtIt0t9uus7Mu9GvCLqTiIqtcrqEOP6bU
         s/uXdNuNoAwDelb8Aei7CAIzwzJ8iH7H0odL/D3LzeycNUFPDEIA4MyHK/qMahR/mXGe
         ldyuDPspjg1oEnxGve0XrYUnpN27MLuPK8f7GQB3wEW3JWe2H6OAIYIYZtJLLyYj9KyG
         FE7X6yf5Wvf9WbhLNyXxcZwKDeS7a2f40ckPIoAEf9rpL9YEmk3OmMA+DFDckivNkY2V
         E4BQ==
X-Forwarded-Encrypted: i=1; AJvYcCWks0JZ95VrPydt54pqSvkUHIQr8zw80WYPje1DcYM1Ae6tdkqw3SVGolO1Ec9bNHWQnr2OfUpsX1w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2TKCfIKwXYVq8YkRyqm4HqKbznaPpS60/kzaZOOqo1w1kgPXS
	lOm/XuRBPZbC4QQ5n7zoZODbsjgWWG/ja6fyi7aghoJ2Re00Is0BjpGJ6QCyvvQ8dD6Mr2+h97r
	U
X-Google-Smtp-Source: AGHT+IG+eEaOxwwxnqnBi7IH4m8CimowCnFKODJk37Vb46MQue71WVSIC0ndfLwQiCJS/6/D5SZ7ig==
X-Received: by 2002:a17:906:dc8f:b0:a99:f388:6f49 with SMTP id a640c23a62f3a-a9de61a0fc0mr1328330766b.9.1730817454689;
        Tue, 05 Nov 2024 06:37:34 -0800 (PST)
Received: from ?IPV6:2a01:e0a:b41:c160:5127:810a:3f6b:b00f? ([2a01:e0a:b41:c160:5127:810a:3f6b:b00f])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9eb17cf842sm142063366b.121.2024.11.05.06.37.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Nov 2024 06:37:34 -0800 (PST)
Message-ID: <0a8d6565-fdc0-452f-b132-5d237a1b7dec@6wind.com>
Date: Tue, 5 Nov 2024 15:37:32 +0100
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH net 1/1] net/ipv6: Netlink flag for new IPv6 Default
 Routes
To: Matt Muggeridge <Matt.Muggeridge@hpe.com>
Cc: David Ahern <dsahern@kernel.org>, "David S . Miller"
 <davem@davemloft.net>, linux-api@vger.kernel.org, stable@vger.kernel.org,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241105031841.10730-1-Matt.Muggeridge@hpe.com>
 <20241105031841.10730-2-Matt.Muggeridge@hpe.com>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Content-Language: en-US
Organization: 6WIND
In-Reply-To: <20241105031841.10730-2-Matt.Muggeridge@hpe.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 05/11/2024 à 04:18, Matt Muggeridge a écrit :
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
Please, don't mix whitespace changes with the changes related to the new flag.

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst#n166


Regards,
Nicolas


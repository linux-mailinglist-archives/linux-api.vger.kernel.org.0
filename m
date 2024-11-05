Return-Path: <linux-api+bounces-2670-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 117019BC3B8
	for <lists+linux-api@lfdr.de>; Tue,  5 Nov 2024 04:19:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49CAC1F22A82
	for <lists+linux-api@lfdr.de>; Tue,  5 Nov 2024 03:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DF5C181D00;
	Tue,  5 Nov 2024 03:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="Ybc0n578"
X-Original-To: linux-api@vger.kernel.org
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C454D9FE;
	Tue,  5 Nov 2024 03:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.147.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730776781; cv=none; b=XDoYS3w1caTd+gLx3AWn9S9pqz1hV1VWj8R+J54HVMHUcvMAIWCFU7tM5K6DzTw2tDITjmvIdUg5XzNi7vI2DyE5+Gl7+/vqhMc7TYIn9iVWQd2Qyn2Sp31nCwGpLMu5f3mWzqV6pSeLybDV0QxKWN5pYsjLHmBjMSMIQiRMeFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730776781; c=relaxed/simple;
	bh=fkXSO+yMdEY1/ThTfQS7LTVJg1/HOBfDSEDz1M8lAlQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=prhlIToanP1/a/oKVpyyyojLG5pWTcBu/Cv3F48j2S4wSpjJPhnhUhRaXY9UjLGR+jGwdfcduLoYMejL4X1CoaoXCGKzgRFIIdHYNTKDgUs64rkR9eNDBfaxEdo3XdZdFuzA6RP/tIoD86nCEmyoHM7bD72D8Ymvzcg5A8dVupI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=Ybc0n578; arc=none smtp.client-ip=148.163.147.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0148663.ppops.net [127.0.0.1])
	by mx0a-002e3701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A505mm3003141;
	Tue, 5 Nov 2024 03:19:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pps0720; bh=HaEvCercaOt3S
	bsThCQ12eMreB7isjJF+O49qKyZuVQ=; b=Ybc0n578jGmCwYYXHbTsf+nDIaJ8w
	3iPOAr6ywzIcS4LaL8Dq00mUY7UdJOGx66+5fyRMv536MuV2dCVGMRLsiYiVaqhw
	e9MZBP7QX4FxCNpK1abTuxNAALQNuC0XdlUKC+OIljjhvvQ6JT0MIdjHGcrjfYRN
	bj/S+gs5/C2uw+GK1FFFVvII6wx6ec6arLqm/g9DyrRhibYHz6LGFEwIW9fmxxqT
	x2AeY+1Pi3uljXV5m1rLgBXtD1YynTqqsIUQTKccWv/Adr/dfTSB86Lif2RztzYQ
	j57Bi8JXNE/I6X6M51Gzabr3ggACXZBhMoZAy/0TRuQ0nuW8UB476fXhg==
Received: from p1lg14878.it.hpe.com ([16.230.97.204])
	by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 42pw6s6sff-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 Nov 2024 03:19:19 +0000 (GMT)
Received: from localhost (unknown [192.58.206.35])
	by p1lg14878.it.hpe.com (Postfix) with ESMTP id 622CDD27D;
	Tue,  5 Nov 2024 03:19:18 +0000 (UTC)
From: Matt Muggeridge <Matt.Muggeridge@hpe.com>
To: 
Cc: Matt Muggeridge <Matt.Muggeridge@hpe.com>,
        David Ahern <dsahern@kernel.org>,
        "David S . Miller" <davem@davemloft.net>, linux-api@vger.kernel.org,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net 1/1] net/ipv6: Netlink flag for new IPv6 Default Routes
Date: Mon,  4 Nov 2024 22:18:39 -0500
Message-Id: <20241105031841.10730-2-Matt.Muggeridge@hpe.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20241105031841.10730-1-Matt.Muggeridge@hpe.com>
References: <20241105031841.10730-1-Matt.Muggeridge@hpe.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: misPHylo-sXRlFf3qYjkp9aTR4kRcH6x
X-Proofpoint-ORIG-GUID: misPHylo-sXRlFf3qYjkp9aTR4kRcH6x
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 impostorscore=0 spamscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 phishscore=0 adultscore=0 suspectscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411050023

Add a Netlink rtm_flag, RTM_F_RA_ROUTER for the RTM_NEWROUTE message.
This allows an IPv6 Netlink client to indicate the default route came
from an RA. This results in the kernel creating individual default
routes, rather than coalescing multiple default routes into a single
ECMP route.

Details:

For IPv6, a Netlink client is unable to create default routes in the
same manner as the kernel. This leads to failures when there are
multiple default routers, as they were being coalesced into a single
ECMP route. When one of the ECMP default routers becomes UNREACHABLE, it
was still being selected as the nexthop.

Meanwhile, when the kernel processes RAs from multiple default routers,
it sets the fib6_flags: RTF_ADDRCONF | RTF_DEFAULT. The RTF_ADDRCONF
flag is checked by rt6_qualify_for_ecmp(), which returns false when
ADDRCONF is set. As such, the kernel creates separate default routes.

E.g. compare the routing tables when RAs are processed by the kernel
versus a Netlink client (systemd-networkd, in my case).

1) RA Processed by kernel (accept_ra = 2)
$ ip -6 route
2001:2:0:1000::/64 dev enp0s9 proto kernel metric 256 expires ...
fe80::/64 dev enp0s9 proto kernel metric 256 pref medium
default via fe80::200:10ff:fe10:1060 dev enp0s9 proto ra ...
default via fe80::200:10ff:fe10:1061 dev enp0s9 proto ra ...

2) RA Processed by Netlink client (accept_ra = 0)
$ ip -6 route
2001:2:0:1000::/64 dev enp0s9 proto ra metric 1024 expires ...
fe80::/64 dev enp0s3 proto kernel metric 256 pref medium
fe80::/64 dev enp0s9 proto kernel metric 256 pref medium
default proto ra metric 1024 expires 595sec pref medium
	nexthop via fe80::200:10ff:fe10:1060 dev enp0s9 weight 1
	nexthop via fe80::200:10ff:fe10:1061 dev enp0s9 weight 1

IPv6 Netlink clients need a mechanism to identify a route as coming from
an RA. i.e. a Netlink client needs a method to set the kernel flags:

    RTF_ADDRCONF | RTF_DEFAULT

This is needed when there are multiple default routers that each send
an RA. Setting the RTF_ADDRCONF flag ensures their fib entries do not
qualify for ECMP routes, see rt6_qualify_for_ecmp().

To achieve this, introduce a user-level flag RTM_F_RA_ROUTER that a
Netlink client can pass to the kernel.

A Netlink user-level network manager, such as systemd-networkd, may set
the RTM_F_RA_ROUTER flag in the Netlink RTM_NEWROUTE rtmsg. When set,
the kernel sets RTF_RA_ROUTER in the fib6_config fc_flags. This causes a
default route to be created in the same way as if the kernel processed
the RA, via rt6add_dflt_router().

This is needed by user-level network managers, like systemd-networkd,
that prefer to do the RA processing themselves. ie. they disable the
kernel's RA processing by setting net.ipv6.conf.<intf>.accept_ra=0.

Without this flag, when there are mutliple default routers, the kernel
coalesces multiple default routes into an ECMP route. The ECMP route
ignores per-route REACHABILITY information. If one of the default
routers is unresponsive, with a Neighbor Cache entry of INCOMPLETE, then
it can still be selected as the nexthop for outgoing packets. This
results in an inability to communicate with remote hosts, even though
one of the default routers remains REACHABLE. This violates RFC4861
section 6.3.6, bullet 1.

Extract from RFC4861 6.3.6 bullet 1:
     1) Routers that are reachable or probably reachable (i.e., in any
        state other than INCOMPLETE) SHOULD be preferred over routers
        whose reachability is unknown or suspect (i.e., in the
        INCOMPLETE state, or for which no Neighbor Cache entry exists).

This fixes the IPv6 Logo conformance test v6LC_2_2_11, and others that
test with multiple default routers. Also see systemd issue #33470:
https://github.com/systemd/systemd/issues/33470.

Signed-off-by: Matt Muggeridge <Matt.Muggeridge@hpe.com>
Cc: David Ahern <dsahern@kernel.org>
Cc: David S. Miller <davem@davemloft.net>
Cc: linux-api@vger.kernel.org
Cc: stable@vger.kernel.org
---
 include/uapi/linux/rtnetlink.h | 9 +++++----
 net/ipv6/route.c               | 3 +++
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/include/uapi/linux/rtnetlink.h b/include/uapi/linux/rtnetlink.h
index 3b687d20c9ed..9f0259f6e4ed 100644
--- a/include/uapi/linux/rtnetlink.h
+++ b/include/uapi/linux/rtnetlink.h
@@ -202,7 +202,7 @@ enum {
 #define RTM_NR_FAMILIES	(RTM_NR_MSGTYPES >> 2)
 #define RTM_FAM(cmd)	(((cmd) - RTM_BASE) >> 2)
 
-/* 
+/*
    Generic structure for encapsulation of optional route information.
    It is reminiscent of sockaddr, but with sa_family replaced
    with attribute type.
@@ -242,7 +242,7 @@ struct rtmsg {
 
 	unsigned char		rtm_table;	/* Routing table id */
 	unsigned char		rtm_protocol;	/* Routing protocol; see below	*/
-	unsigned char		rtm_scope;	/* See below */	
+	unsigned char		rtm_scope;	/* See below */
 	unsigned char		rtm_type;	/* See below	*/
 
 	unsigned		rtm_flags;
@@ -336,6 +336,7 @@ enum rt_scope_t {
 #define RTM_F_FIB_MATCH	        0x2000	/* return full fib lookup match */
 #define RTM_F_OFFLOAD		0x4000	/* route is offloaded */
 #define RTM_F_TRAP		0x8000	/* route is trapping packets */
+#define RTM_F_RA_ROUTER		0x10000	/* route is a default route from RA */
 #define RTM_F_OFFLOAD_FAILED	0x20000000 /* route offload failed, this value
 					    * is chosen to avoid conflicts with
 					    * other flags defined in
@@ -568,7 +569,7 @@ struct ifinfomsg {
 };
 
 /********************************************************************
- *		prefix information 
+ *		prefix information
  ****/
 
 struct prefixmsg {
@@ -582,7 +583,7 @@ struct prefixmsg {
 	unsigned char	prefix_pad3;
 };
 
-enum 
+enum
 {
 	PREFIX_UNSPEC,
 	PREFIX_ADDRESS,
diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index b4251915585f..5b0c16422720 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -5055,6 +5055,9 @@ static int rtm_to_fib6_config(struct sk_buff *skb, struct nlmsghdr *nlh,
 	if (rtm->rtm_flags & RTM_F_CLONED)
 		cfg->fc_flags |= RTF_CACHE;
 
+	if (rtm->rtm_flags & RTM_F_RA_ROUTER)
+		cfg->fc_flags |= RTF_RA_ROUTER;
+
 	cfg->fc_flags |= (rtm->rtm_flags & RTNH_F_ONLINK);
 
 	if (tb[RTA_NH_ID]) {
-- 
2.35.3



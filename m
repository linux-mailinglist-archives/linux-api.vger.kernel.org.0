Return-Path: <linux-api+bounces-2686-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7145F9BFD11
	for <lists+linux-api@lfdr.de>; Thu,  7 Nov 2024 04:53:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D0EC283CA8
	for <lists+linux-api@lfdr.de>; Thu,  7 Nov 2024 03:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ED7A14900E;
	Thu,  7 Nov 2024 03:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="WntTDZwM"
X-Original-To: linux-api@vger.kernel.org
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D218BEC;
	Thu,  7 Nov 2024 03:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.147.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730951617; cv=none; b=pFccPe6/EW72b/u7cb1EHiEAwcelQITmAfMppqUKb3Vl7F7RRVaTCMQ0EPXSpHn/vX37dvjOka0DfbFVg4FR0YFgzbkxEykMb8/Q9ihXOsAy5c4USYjo6CcHjuRKkUShLKUyZnzfufVMvrCD052nSjkWJQ5YEnBa2QAPALgHRFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730951617; c=relaxed/simple;
	bh=fNBzH+ehpVvC6j0AIj+7ga742STXZolR0UGIQ3BzUDs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QUof481vzKtK8M/LDTxF4P2MzlbHB7Gb+GE2d5mbnmompW36pBKe0mJFgpH21ZHq+ml3LqIrHP9hBVaav9TQALnIsYTUhdd1e0jZZSN8v7dPM+AZClp3TMlcoNImN2RNB+GkM4DwOOEGTITyOj+LzkwFLTutl8o5tPfzr0y/WOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=WntTDZwM; arc=none smtp.client-ip=148.163.147.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0148663.ppops.net [127.0.0.1])
	by mx0a-002e3701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A722ojG007809;
	Thu, 7 Nov 2024 03:53:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pps0720; bh=y3AScQJQ1dUFE
	BaGOnwifpUCr3+cWWYTvmur2UwtFUY=; b=WntTDZwMmwsd8qA+CmmNpRZChWay3
	A6ehFzmxV1L9sgcyL9Stemzc/83mDxWwYgXn2hEA01sRhYONrLd8zKG9i7o8A31+
	fA7wgZqQOCPT5qZ/ku2uOzHWsrezpJyTnDvRlesCEMskFAGFgSGX4mDaIe4rteRn
	gZIrcKiPB+ufxXZFXxIe+V6uLITz8m06xAiCtUAWihiuFVbJT04luP2QTnZxRnXR
	BzpUvXLfRDVUcOgAQFvrKNdTRvtnJae+MCD+mVsZ5Y9IeGW5vh1TtgZuWg7C+yNs
	kyrllqddJOBMzlWkiWTsMNvHcmpMrie4lrhnweGwE8NhfBPRoxjQ9zlyQ==
Received: from p1lg14878.it.hpe.com ([16.230.97.204])
	by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 42rg8j2h3w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Nov 2024 03:53:10 +0000 (GMT)
Received: from localhost (unknown [192.58.206.35])
	by p1lg14878.it.hpe.com (Postfix) with ESMTP id 57BBFD27E;
	Thu,  7 Nov 2024 03:53:07 +0000 (UTC)
From: Matt Muggeridge <Matt.Muggeridge@hpe.com>
To: idosch@idosch.org
Cc: Matt.Muggeridge@hpe.com, davem@davemloft.net, dsahern@kernel.org,
        edumazet@google.com, horms@kernel.org, kuba@kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, pabeni@redhat.com, stable@vger.kernel.org
Subject: Re: [PATCH net 1/1] net/ipv6: Netlink flag for new IPv6 Default Routes
Date: Wed,  6 Nov 2024 22:53:03 -0500
Message-Id: <20241107035303.24057-1-Matt.Muggeridge@hpe.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <ZytjEINNRmtpadr_@shredder>
References: <ZytjEINNRmtpadr_@shredder>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: h7OfoSKdb63qSwJqsyYUmVJOHxsJJbif
X-Proofpoint-ORIG-GUID: h7OfoSKdb63qSwJqsyYUmVJOHxsJJbif
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 mlxscore=0
 spamscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0 phishscore=0
 mlxlogscore=999 impostorscore=0 adultscore=0 malwarescore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2411070028

Hi Ido,

> >>> Is the problem that fib6_table_lookup() chooses a reachable
> >>> nexthop and then fib6_select_path() overrides it with an unreachable
> >>> one?
> 
> >> I'm afraid I don't know.
> >>
> > We need to understand the current behavior before adding a new interface
> > that we will never be able to remove. It is possible we can improve /
> > fix the current code. I won't have time to look into it myself until
> > next week.

I am grateful that you want to look into it. Thank you! And I look forward to
learning what you discover.

You probably already know how to reproduce it, but in case it helps, I still
have the packet captures and can share them with you. Let me know if you'd
like me to share them (and how to share them).

> > 
> > The objective is to allow IPv6 Netlink clients to be able to create default
> > routes from RAs in the same way the kernel creates default routes from RAs.
> > Essentially, I'm trying to have Netlink and Kernel behaviors match.
> 
> I understand, but it's essentially an extension for the legacy IPv6
> multipath API which we are trying to move away from towards the nexthop
> API (see more below).

Very interesting, I wasn't aware of this movement.

While this change is an extension of the legacy IPv6 multipath API, won't it
still need to support Netlink clients that have been designed around it? I
imagine that transitioning Netlink clients to the NH API will take many years?

As such, it still seems appropriate (to me) that this be implemented in the
legacy API as well as ensuring it works with the NH API.

Another consideration...

Will the kernel RA processing go through the same nh pathway? The reason I
ask is because I faced several challenges with IPv6 Logo certification due to
Netlink clients being unable to achieve the same as the kernel's behavior.

As long as the kernel is creating RA routes in a way that meets RFC4861, then
I'd hope that  Netlink clients would be able to leverage that for 'free'.

> > 
> > My analysis led me to the need for Netlink clients to set the kernel's
> > fib6_config flags RTF_RA_ROUTER, where:
> > 
> >     #define RTF_RA_ROUTER		(RTF_ADDRCONF | RTF_DEFAULT)
> > 
> >>> +	if (rtm->rtm_flags & RTM_F_RA_ROUTER)
> >>> +		cfg->fc_flags |= RTF_RA_ROUTER;
> >>> +
> >> 
> >> It is possible there are user space programs out there that set this bit
> >> (knowingly or not) when sending requests to the kernel and this change
> >> will result in a behavior change for them. So, if we were to continue in
> >> this path, this would need to be converted to a new netlink attribute to
> >> avoid such potential problems.
> >> 
> > 
> > Is this a mandated approach to implementing unspecified bits in a flag?
> > 
> > I'm a little surprised by this consideration. If we account for poorly
> > written buggy user-programs, doesn't this open any API to an explosion
> > of new attributes or other odd extensions? I'd imagine the same argument
> > would be applicable to ioctl flags, socket flags, and so on. Why would we
> > treat implementing unspecified Netlink bits differently to implementing
> > unspecified ioctl bits, etc.
> > 
> > Naturally, if this is the mandated approach, then I'll reimplement it with
> > a new Netlink attribute. I'm just trying to understand what is the
> > Linux-lore, here?
> 
> Using this bit could have been valid if previously the kernel rejected
> requests with this bit set, but as evident by your patch the kernel does
> not do it. It is therefore possible that there are user space programs
> out there that are working perfectly fine right now and they will break
> / misbehave after this change.
> 

Understood and I agree.

> > 
> >> BTW, you can avoid the coalescing problem by using the nexthop API (man
> >> ip-nexthop).
> > 
> > I'm not sure how that would help in this case. We need the nexthop to be
> > determined according to its REACHABILITY and other considerations described
> > in RFC4861.
> 
> Using your example:
> 
> # ip nexthop add id 1 via fe80::200:10ff:fe10:1060 dev enp0s9
> # ip -6 route add default nhid 1 expires 600 proto ra
> # ip nexthop add id 2 via fe80::200:10ff:fe10:1061 dev enp0s9
> # ip -6 route append default nhid 2 expires 600 proto ra
> # ip -6 route
> fe80::/64 dev enp0s9 proto kernel metric 256 pref medium
> default nhid 1 via fe80::200:10ff:fe10:1060 dev enp0s9 proto ra metric 1024 expires 563sec pref medium
> default nhid 2 via fe80::200:10ff:fe10:1061 dev enp0s9 proto ra metric 1024 expires 594sec pref medium

Thanks! That looks like it should work. I'll raise this with the the developers
of systemd-networkd.

Just to confirm; are these two nhid routes equivalent to having two separate
default routes that are created when the kernel processes IPv6 RAs?

Specifically, if one of these nhid routes becomes UNREACHABLE, will that be
taken into consideration during the routing decision? (I'm guessing so?)

Thank you for your interest in this.

Regards,
Matt.


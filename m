Return-Path: <linux-api+bounces-2690-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CD109C13FC
	for <lists+linux-api@lfdr.de>; Fri,  8 Nov 2024 03:21:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 803551C22842
	for <lists+linux-api@lfdr.de>; Fri,  8 Nov 2024 02:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99BB31BD9E5;
	Fri,  8 Nov 2024 02:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="EdMY6z8d"
X-Original-To: linux-api@vger.kernel.org
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB75FA41;
	Fri,  8 Nov 2024 02:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.147.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731032458; cv=none; b=BUGkOeCBrwU8H2iTyQP3AZdQI8Ze3SbDEK+hMOF7Pa6KpXuqHeS3eQ4kUZy2AKXjyAyZyAfDvdg1amT3HsOf99nac+4PPqT/gVUN76sJ20DMU3ezQHNIxdR1K+SuyteYA0xhb1nLMHjgH0BeEAzCYvLJ8XxuR7SjGpQty0WUdus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731032458; c=relaxed/simple;
	bh=CwnYD3eGDcHqYbgF65Xbn0OHrKz2s4QD6/hWNWb3Ch0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jiNShNOVb/BuOxEG/TDWGxnuhBNwl5QcoIikNWRxIne4Q+rV5Q6mhANFv132koWmeUARFdy9G3higdbPJZFHlUon0yjVbBUuyuCk0lDfnVqmU9BmS2p0cMNtwhXqnAzX3JWuRVA6LK6QWegM2lCzQIYeGE+NkYbxdiSof+/NCKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=EdMY6z8d; arc=none smtp.client-ip=148.163.147.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0150241.ppops.net [127.0.0.1])
	by mx0a-002e3701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A7MdPY8025702;
	Fri, 8 Nov 2024 02:20:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pps0720; bh=Al+1eFcwD1Jl3
	Gag56B47fYEjUBMMgK+F9iQqJ74Q5w=; b=EdMY6z8dVXWgQtkZjhk0eRRX/jLCq
	Y+baaYel0c0ILdnDFuKUDK2dmGDNleSP5EUh7AImOKSSZon48chSXxLwHzz4De/8
	hkx6faYmYsiJwrPebqrIchc+ah+HjR3fYYuvd8BrosVnGeFP5WgL88ZpwLMB8kdR
	aOgj9g7juCan82A2UlG5Uja+fC3C8Vzen5Mcqw2zMEEHEKjs/7jr0uHkphPwIB+t
	pctPo5zn8cV1nkkQyt2rdLMP+LHW9BA56ZQoFZo+z1+ktFc8uQD1b18MSEXs5TGN
	LhL/maUZntlYJ+fgVfhtAATboKVX4ktcCMlLJGjGvAFLObP66HKmjqVOw==
Received: from p1lg14878.it.hpe.com ([16.230.97.204])
	by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 42s6h9sd36-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 Nov 2024 02:20:38 +0000 (GMT)
Received: from localhost (unknown [192.58.206.38])
	by p1lg14878.it.hpe.com (Postfix) with ESMTP id 3B4D2295E7;
	Fri,  8 Nov 2024 02:20:36 +0000 (UTC)
From: Matt Muggeridge <Matt.Muggeridge@hpe.com>
To: idosch@idosch.org
Cc: Matt.Muggeridge@hpe.com, davem@davemloft.net, dsahern@kernel.org,
        edumazet@google.com, horms@kernel.org, kuba@kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, pabeni@redhat.com, stable@vger.kernel.org
Subject: Re: [PATCH net 1/1] net/ipv6: Netlink flag for new IPv6 Default Routes
Date: Thu,  7 Nov 2024 21:20:26 -0500
Message-Id: <20241108022026.58907-1-Matt.Muggeridge@hpe.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <ZyyN2bSgrpbhbkpp@shredder>
References: <ZyyN2bSgrpbhbkpp@shredder>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: wL657nGIBtMxv2dhOrIYI__izIcFG8c7
X-Proofpoint-ORIG-GUID: wL657nGIBtMxv2dhOrIYI__izIcFG8c7
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_02,2024-10-04_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=0
 mlxlogscore=999 lowpriorityscore=0 mlxscore=0 phishscore=0
 priorityscore=1501 spamscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411080018

> > You probably already know how to reproduce it, but in case it helps, I still
> > have the packet captures and can share them with you. Let me know if you'd
> > like me to share them (and how to share them).
> 
> It would be best if you could provide a reproducer using iproute2:
> Configure a dummy device using ip-link, install the multipath route
> using ip-route, configure the neighbour table using ip-neigh and then
> perform route queries using "ip route get ..." showing the problem. We
> can then use it as the basis for a new test case in
> tools/testing/selftests/net/fib_tests.sh 

I'll try to do that next week.

> BTW, do you have CONFIG_IPV6_ROUTER_PREF=y in your config?

Yes.

$ gunzip -c /proc/config.gz | grep ROUTER_PREF
CONFIG_IPV6_ROUTER_PREF=y

> > 
> > As such, it still seems appropriate (to me) that this be implemented in the
> > legacy API as well as ensuring it works with the NH API.
> 
> As I understand it you currently get different results because the
> kernel installs two default routes whereas user space can only create
> one default multipath route.

Yes, that's the end result of an underlying problem.

Perhaps more to the point, the fact that a coalesced, INCOMPLETE, multipath
route is selected when a REACHABLE alternative exists, is what prevents us
from using coalesced multipath routes. This seems like a bug, since it violates
RFC4861 6.3.6, bullet 1.

Imagine adding a 2nd router to an IPv6 network for added resiliency, but when
one becomes unreachable, some network flows keep choosing the unreachable
router. This is what is happening with ECMP routes. It doesn't happen with
multiple default routes.

I'll just reiterate earlier comments, this doesn't happen all of the time.
It seems I have a 50/50 chance of the INCOMPLETE route being selected.

> Before adding a new uAPI I want to
> understand the source of the difference and see if we can improve / fix
> the current multipath code so that the two behave the same. If we can
> get them to behave the same then I don't think user space will care
> about two default routes versus one default multipath route.

Exactly, I totally support that approach.

Regards,
Matt.


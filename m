Return-Path: <linux-api+bounces-2683-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AA629BDD48
	for <lists+linux-api@lfdr.de>; Wed,  6 Nov 2024 03:51:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C48871F21CE8
	for <lists+linux-api@lfdr.de>; Wed,  6 Nov 2024 02:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D296818F2FB;
	Wed,  6 Nov 2024 02:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="CPSIO1oh"
X-Original-To: linux-api@vger.kernel.org
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F1CA18B47E;
	Wed,  6 Nov 2024 02:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.143.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730861497; cv=none; b=ROVQ/qtfrvNphFKiEHad7q6J+5sdrG+BTKSIcNg/kkmla7WuR1LVveTLnaodGRYhTornxW6gwxDpLZB0Fy/T2iFPi7U5fRfy/lZ0coWHtZfUBMR72jm4VuQT0sD/QSBoR0gDNVymAsmLUcdeNc+IkxCQrCUQhpqA2oAD9NO5OGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730861497; c=relaxed/simple;
	bh=zGklckDW0yAzRpIHB36p0nroZKUlM400pZk1ZhfMExw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AbytIZeBm+umqHYNtfIA6gDoRzFsJt+lXzKrSvvLn55T3uKcAzUj0XsOj/9R0ck5mgLIr8t5W/2DDGpxDVkWkDTkabmO7pnj0ocCTJuFRxdJd661xaC7jCs93UwzqyLrMgx0dQpAPAbx1j7/dKiR4iaiivm6Wah2CaKTezUx50s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=CPSIO1oh; arc=none smtp.client-ip=148.163.143.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0150244.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A61igiP017650;
	Wed, 6 Nov 2024 02:51:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pps0720; bh=fIau/TGBK/Y6E
	JZSH4sYAY5qCp0ClLkPwdbVUgJbvDw=; b=CPSIO1oh/jpKfndIGm14Np1CbjWQg
	hyuP8zyjECZjObh4jNnoKW9STq4jgktvUNUridmLgkdl1T1XQUPF9J+pgOTelhtD
	Jw0ceWFgjylRafJJ4RAhdzY+McmPuCf8aktwkiBrZrroObZLp4pH14eIeY9fyFac
	CkNlF8txzjfXhAwGYE5RoWBzs1UFfAMCPlCP3Eiihth1zZk9o8HQ9zoGo9nCtB4g
	F02PPqPE2L4DVX0pj4TpjGK9uPeubyfVLPILUP70O0Lko3B986J2jx382AJnnHOl
	GRrygh/GJiiuPCSeAQSkanOEGcx+ixFNhEcKIMXUFqK+qne0OdYLMpZYg==
Received: from p1lg14881.it.hpe.com ([16.230.97.202])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 42qqxw3nj1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Nov 2024 02:51:04 +0000 (GMT)
Received: from localhost (unknown [192.58.206.35])
	by p1lg14881.it.hpe.com (Postfix) with ESMTP id A0FE0806B3F;
	Wed,  6 Nov 2024 02:51:02 +0000 (UTC)
From: Matt Muggeridge <Matt.Muggeridge@hpe.com>
To: idosch@idosch.org
Cc: Matt.Muggeridge@hpe.com, davem@davemloft.net, dsahern@kernel.org,
        edumazet@google.com, horms@kernel.org, kuba@kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, pabeni@redhat.com, stable@vger.kernel.org
Subject: Re: [PATCH net 1/1] net/ipv6: Netlink flag for new IPv6 Default Routes
Date: Tue,  5 Nov 2024 21:50:56 -0500
Message-Id: <20241106025056.11241-1-Matt.Muggeridge@hpe.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <Zypgu5l7F1FpIpqo@shredder>
References: <Zypgu5l7F1FpIpqo@shredder>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: IQacsdKuxoAHBraaf122jx6QcKWt9S9_
X-Proofpoint-ORIG-GUID: IQacsdKuxoAHBraaf122jx6QcKWt9S9_
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_02,2024-10-04_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 bulkscore=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=866 spamscore=0 priorityscore=1501
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411060020

Thank you for your review and feedback, Ido.

>> Without this flag, when there are mutliple default routers, the kernel
>> coalesces multiple default routes into an ECMP route. The ECMP route
>> ignores per-route REACHABILITY information. If one of the default
>> routers is unresponsive, with a Neighbor Cache entry of INCOMPLETE, then
>> it can still be selected as the nexthop for outgoing packets. This
>> results in an inability to communicate with remote hosts, even though
>> one of the default routers remains REACHABLE. This violates RFC4861
>> section 6.3.6, bullet 1.
>
>Do you have forwarding disabled (it causes RT6_LOOKUP_F_REACHABLE to be
>set)?

Yes, forwarding is disabled on our embedded system. Though, this needs to
work on systems regardless of the state of forwarding.

>  Is the problem that fib6_table_lookup() chooses a reachable
>nexthop and then fib6_select_path() overrides it with an unreachable
>one?

I'm afraid I don't know.

The objective is to allow IPv6 Netlink clients to be able to create default
routes from RAs in the same way the kernel creates default routes from RAs.
Essentially, I'm trying to have Netlink and Kernel behaviors match.

My analysis led me to the need for Netlink clients to set the kernel's
fib6_config flags RTF_RA_ROUTER, where:

    #define RTF_RA_ROUTER		(RTF_ADDRCONF | RTF_DEFAULT)

>> +	if (rtm->rtm_flags & RTM_F_RA_ROUTER)
>> +		cfg->fc_flags |= RTF_RA_ROUTER;
>> +
> 
> It is possible there are user space programs out there that set this bit
> (knowingly or not) when sending requests to the kernel and this change
> will result in a behavior change for them. So, if we were to continue in
> this path, this would need to be converted to a new netlink attribute to
> avoid such potential problems.
> 

Is this a mandated approach to implementing unspecified bits in a flag?

I'm a little surprised by this consideration. If we account for poorly
written buggy user-programs, doesn't this open any API to an explosion
of new attributes or other odd extensions? I'd imagine the same argument
would be applicable to ioctl flags, socket flags, and so on. Why would we
treat implementing unspecified Netlink bits differently to implementing
unspecified ioctl bits, etc.

Naturally, if this is the mandated approach, then I'll reimplement it with
a new Netlink attribute. I'm just trying to understand what is the
Linux-lore, here?

> BTW, you can avoid the coalescing problem by using the nexthop API (man
> ip-nexthop).

I'm not sure how that would help in this case. We need the nexthop to be
determined according to its REACHABILITY and other considerations described
in RFC4861.

Kind regards,
Matt.


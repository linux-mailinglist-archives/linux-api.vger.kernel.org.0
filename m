Return-Path: <linux-api+bounces-2736-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EB9E9C935D
	for <lists+linux-api@lfdr.de>; Thu, 14 Nov 2024 21:43:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36D8928493E
	for <lists+linux-api@lfdr.de>; Thu, 14 Nov 2024 20:43:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A1931A7AF6;
	Thu, 14 Nov 2024 20:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="do6gi6g0"
X-Original-To: linux-api@vger.kernel.org
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A62BE4E;
	Thu, 14 Nov 2024 20:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.147.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731617004; cv=none; b=qOBfnhNXc3UgsZ3h8X8WRE1qfItcnri3r1hLOwMeWpHbsq1U11QbnAywcJCoyWWZySmcEbD28GIYsDGbmCj0BpRHX9TNvn/a1kBAKHmSFlwpONHCmr7/ZOKR3aNg97gyXaDQ98Zm5klb+/FLVs9Ya1qbCUKMA1VtNws51bsTfSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731617004; c=relaxed/simple;
	bh=zGklckDW0yAzRpIHB36p0nroZKUlM400pZk1ZhfMExw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qDWN0zjfZ4uDp/Pp13q9kP70iLO8XSmCurZ1yeomVnQ62gp942o0yTS56L6tiU1L9i5JIL0LN/u/OOEyCkQUhPzlsd/rMRGfIaCnJBm7ZVO5n4OabjG52zFujOQAmeqymKMqN5VmGgz+uMelzSX1htpE24usZ1sM+LdOlKNvE4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=do6gi6g0; arc=none smtp.client-ip=148.163.147.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0134421.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AEHb3JV024625;
	Thu, 14 Nov 2024 20:42:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pps0720; bh=fIau/TGBK/Y6E
	JZSH4sYAY5qCp0ClLkPwdbVUgJbvDw=; b=do6gi6g04etKrEWj5zW3MHyEAj9yN
	dYuxnISDuq8X1YljOBw65ibngxyKXn1FT8NPU8HgMU19v3KkS4m9kto/atT5miH/
	7e/R/b33j2SsVa7eUzwF6LGaujkUZodyBXD/F8FnKro5ouNfvBc1/bEIiYfODYTw
	EbXo5GBKzPuqMljvYarke3DBKdtC2wJ0NKR+VFc5qzdkgaa18xszBWMZMaiZIXYK
	H5UkKlVMRyYu661RviYLjI5n8fxn6RveqK/0LljTDTBkvA70LRyQykNXVY4pRAa2
	KGrPPqM/aPbC9pL7BU59gXkZT7H4TS/zydjTLyyRrfM7JnpsXkDffQJ9w==
Received: from p1lg14878.it.hpe.com ([16.230.97.204])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 42wnrgsayn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Nov 2024 20:42:55 +0000 (GMT)
Received: from localhost (unknown [192.58.206.38])
	by p1lg14878.it.hpe.com (Postfix) with ESMTP id 753C9295E7;
	Thu, 14 Nov 2024 20:42:53 +0000 (UTC)
From: Matt Muggeridge <Matt.Muggeridge@hpe.com>
To: idosch@idosch.org
Cc: Matt.Muggeridge@hpe.com, davem@davemloft.net, dsahern@kernel.org,
        edumazet@google.com, horms@kernel.org, kuba@kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, pabeni@redhat.com, stable@vger.kernel.org
Subject: Re: [PATCH net 1/1] net/ipv6: Netlink flag for new IPv6 Default Routes
Date: Thu, 14 Nov 2024 15:42:47 -0500
Message-Id: <20241114204247.32735-1-Matt.Muggeridge@hpe.com>
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
X-Proofpoint-GUID: Yq_UnSI4u6gDm-JGLpw48Ec7SKMspRQP
X-Proofpoint-ORIG-GUID: Yq_UnSI4u6gDm-JGLpw48Ec7SKMspRQP
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 bulkscore=0
 malwarescore=0 suspectscore=0 adultscore=0 spamscore=0 priorityscore=1501
 mlxlogscore=894 mlxscore=0 lowpriorityscore=0 clxscore=1015
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411140162

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


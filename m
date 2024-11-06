Return-Path: <linux-api+bounces-2682-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C22CB9BDB58
	for <lists+linux-api@lfdr.de>; Wed,  6 Nov 2024 02:44:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 742A61F23EAE
	for <lists+linux-api@lfdr.de>; Wed,  6 Nov 2024 01:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD198188CC6;
	Wed,  6 Nov 2024 01:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="H2wIXAy0"
X-Original-To: linux-api@vger.kernel.org
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED0B017B50E;
	Wed,  6 Nov 2024 01:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.147.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730857467; cv=none; b=iNq8xknbdxkp9Sy+i3JdghIm6Ci/4MR+vmjrhwq22n8JnDrJBe+X0RmJRh3yJ1J+DhWHSJOSmeUoI1NL7DHDxq8eBbD00ddh5cxin2FZ/Hs+YCmfXGwFVKNvumtqMMBqQ04PuUKM5OnF7CE88+0qEL8K//i4VsZIIgQSf0wDz8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730857467; c=relaxed/simple;
	bh=Ceb1e0csOYQPByEC5wuAEwTUQ//6cxjlD9QGkAOefi4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eo+BWjpnm7qoXHR4bpW53b8qSb+ZNKPXnJUqFMd5La2Vv/oOqMCbDRUK2Cbrl/0TSuRb4+ZtQuNx21GbOcQNTBJZ0u/BZtkGeIJIEg1NAMcXcGRcle8QXpRhVd9evwgok+YzZWyxI/pJKRTk6ddC/CK9cliyFkECVt/S/LbzLnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=H2wIXAy0; arc=none smtp.client-ip=148.163.147.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0150241.ppops.net [127.0.0.1])
	by mx0a-002e3701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A5HshOA007640;
	Wed, 6 Nov 2024 01:44:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pps0720; bh=Ceb1e0csOYQPB
	yEC5wuAEwTUQ//6cxjlD9QGkAOefi4=; b=H2wIXAy0xd37lTh33ta4YxZGKIVBB
	tEz9oUZftf9Fhm+92ZpBdedqG24Ge+J+AMiZqTikDBEJs/Y7Uj6Pc1iK3V2eyWpD
	ig4WsXcLn/WTZB0ZnK8dyFEslry9BzT8nJCIaO1zPOWmx+emKFQSkeB1YwwHvJ+u
	19MsX6WxRYWoEKA0+PSQZJelufaCR9zHFj0rg/8K/cc9/P5gWHMTkYlX51eb7t3Q
	UBPe6+SiN9RJhYHHGP7vfqUb6o0N2mioaHE93UNToDIwpB1zBbPOB3PNv+xeLZP/
	k5QoZAYrZRe6onI8dIUYbrzp2J8CsMFFvNEsmovQrhWqbMM2f01LhLLjw==
Received: from p1lg14880.it.hpe.com ([16.230.97.201])
	by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 42qr5xb5js-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Nov 2024 01:44:13 +0000 (GMT)
Received: from localhost (unknown [192.58.206.38])
	by p1lg14880.it.hpe.com (Postfix) with ESMTP id EE59C800192;
	Wed,  6 Nov 2024 01:44:11 +0000 (UTC)
From: Matt Muggeridge <Matt.Muggeridge@hpe.com>
To: nicolas.dichtel@6wind.com
Cc: Matt.Muggeridge@hpe.com, davem@davemloft.net, dsahern@kernel.org,
        edumazet@google.com, horms@kernel.org, kuba@kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, pabeni@redhat.com, stable@vger.kernel.org
Subject: Re: [PATCH net 1/1] net/ipv6: Netlink flag for new IPv6 Default Routes
Date: Tue,  5 Nov 2024 20:44:03 -0500
Message-Id: <20241106014403.7044-1-Matt.Muggeridge@hpe.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <0a8d6565-fdc0-452f-b132-5d237a1b7dec@6wind.com>
References: <0a8d6565-fdc0-452f-b132-5d237a1b7dec@6wind.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: M0lSQV5jiJjQ-LrNG9tV-8raFHcqeyZ4
X-Proofpoint-GUID: M0lSQV5jiJjQ-LrNG9tV-8raFHcqeyZ4
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_02,2024-10-04_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 lowpriorityscore=0 phishscore=0 suspectscore=0 impostorscore=0
 clxscore=1011 priorityscore=1501 bulkscore=0 mlxlogscore=594
 malwarescore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411060012

> Please, don't mix whitespace changes with the changes related to the new flag.

Thanks, Nicolas. I will revert the changes that tidied up trailing whitespace in the next version.


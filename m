Return-Path: <linux-api+bounces-2671-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DCB19BC3BA
	for <lists+linux-api@lfdr.de>; Tue,  5 Nov 2024 04:19:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9717F1C20FBB
	for <lists+linux-api@lfdr.de>; Tue,  5 Nov 2024 03:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1633E183098;
	Tue,  5 Nov 2024 03:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="VIw2w5sk"
X-Original-To: linux-api@vger.kernel.org
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C916717E8E2;
	Tue,  5 Nov 2024 03:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.147.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730776781; cv=none; b=AGIRnx3uFdoYHBcRskKaVVPQ9gvO0JGVfnNQXLbVxh7fjD2vaRIbSdnZqL9W+bzV96rc5HvEzIvpI4Is7Gxj0i5l8qwjN4ij6Roe6sVnaVEZQZ75fFTr7T3b2O8rSJKe4fmIEvbYsFtM/7QGgLhdkW406ivfODSZPaqvroAECac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730776781; c=relaxed/simple;
	bh=ZO4mZ6uDnQ4xgSBdcl2TmLImoFFrdOZgNandE9nq1hM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jjvm0hCdjEAKtD/os8FGY6O2yOyKHAgd1mswiyhs/QsiuH8u368jHBOgywmiMVUa0L5kN/UVrLZ5qR9LVwQ0/wxmvejsGWYyatDl6s0jid/B2jYcUqtW1LtYA+5RUuG4dhOTYE6DZ7F4IGNveGizTil8bfTRVHXMcQ5iNFA/2bQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=VIw2w5sk; arc=none smtp.client-ip=148.163.147.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0134421.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A4KtqhW022119;
	Tue, 5 Nov 2024 03:19:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pps0720; bh=RLvlyd7j+M/HoXWqrm1jIxIlrb8ntzFqxgIsi
	f42wOA=; b=VIw2w5skrOsvgULAD0vSl4XjsjJ5tZ4X57K7WssK3scIWUggHWICM
	rxlkc++Yd4bRGFvEmIiKEaBXEEamWivKBzeCJlzvhcj818zRbgHDtH4CT1W5jgir
	sCuLhYB6IE/FQQt73PaRB3fcs23kB9jdx8EpBQgGkM9JDPbmdkGujdxyeNXDza70
	B9H5mK7TWuX1HnLKgxmcnCF0ZrgjhsoTPUxvXbB8bipBAqS55T7WIfaYXWRpmzHF
	PyGUeL/jpdv+B/2R9s9y4Dhb0eLfXcfWt/LlHqCWgMxo2H/OnJY46HNgqJPtmoNE
	/DH94lqu+x2qSe49C7sozKCwfWuOvL+yg==
Received: from p1lg14878.it.hpe.com ([16.230.97.204])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 42q5qqa95w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 Nov 2024 03:19:15 +0000 (GMT)
Received: from localhost (unknown [192.58.206.35])
	by p1lg14878.it.hpe.com (Postfix) with ESMTP id 9B9F52766C;
	Tue,  5 Nov 2024 03:19:13 +0000 (UTC)
From: Matt Muggeridge <Matt.Muggeridge@hpe.com>
To: 
Cc: Matt Muggeridge <Matt.Muggeridge@hpe.com>,
        David Ahern <dsahern@kernel.org>,
        "David S . Miller" <davem@davemloft.net>, linux-api@vger.kernel.org,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net 0/1] net/ipv6: Netlink flag for new IPv6 Default Routes
Date: Mon,  4 Nov 2024 22:18:38 -0500
Message-Id: <20241105031841.10730-1-Matt.Muggeridge@hpe.com>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 2ZpbU0J99SP4QRAkmWWubxBa3XzyO8KB
X-Proofpoint-ORIG-GUID: 2ZpbU0J99SP4QRAkmWWubxBa3XzyO8KB
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 spamscore=0 impostorscore=0 priorityscore=1501 lowpriorityscore=0
 malwarescore=0 suspectscore=0 clxscore=1011 mlxlogscore=643 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411050024

This is the cover letter and provides a brief overview of the change.

Add a Netlink rtm_flag, RTM_F_RA_ROUTER for the RTM_NEWROUTE message.
This allows an IPv6 Netlink client to indicate the default route came
from an RA. This results in the kernel creating individual default
routes, rather than coalescing multiple default routes into a single
ECMP route.

This change also needs to be reflected in the man7/rtnetlink.7 page. Below is
the one-line addition to the man-pages git repo
(https://git.kernel.org/pub/scm/docs/man-pages/man-pages.git):

diff --git a/man/man7/rtnetlink.7 b/man/man7/rtnetlink.7
index 86ed459bb..07c4ef0a8 100644
--- a/man/man7/rtnetlink.7
+++ b/man/man7/rtnetlink.7
@@ -295,6 +295,7 @@ if the route changes, notify the user via rtnetlink
 T}
 RTM_F_CLONED:route is cloned from another route
 RTM_F_EQUALIZE:a multipath equalizer (not yet implemented)
+RTM_F_RA_ROUTER: the route is a default route from an RA
 .TE
 .IP
 .I rtm_table


Signed-off-by: Matt Muggeridge <Matt.Muggeridge@hpe.com>
Cc: David Ahern <dsahern@kernel.org>
Cc: David S. Miller <davem@davemloft.net>
Cc: linux-api@vger.kernel.org
Cc: stable@vger.kernel.org

Matt Muggeridge (1):
  net/ipv6: Netlink flag for new IPv6 Default Routes

 include/uapi/linux/rtnetlink.h | 9 +++++----
 net/ipv6/route.c               | 3 +++
 2 files changed, 8 insertions(+), 4 deletions(-)


base-commit: 5ccdcdf186aec6b9111845fd37e1757e9b413e2f
-- 
2.35.3



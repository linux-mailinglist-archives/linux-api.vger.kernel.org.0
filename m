Return-Path: <linux-api+bounces-6701-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id DxckF41nPWqh2ggAu9opvQ
	(envelope-from <linux-api+bounces-6701-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Thu, 25 Jun 2026 19:38:21 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 105F76C7E1A
	for <lists+linux-api@lfdr.de>; Thu, 25 Jun 2026 19:38:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=rambus.com header.s=selector1 header.b=s5VJf6uJ;
	spf=pass (mail.lfdr.de: domain of "linux-api+bounces-6701-lists+linux-api=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-api+bounces-6701-lists+linux-api=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=rambus.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 290C83054156
	for <lists+linux-api@lfdr.de>; Thu, 25 Jun 2026 17:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4D213F39DF;
	Thu, 25 Jun 2026 17:34:36 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11021110.outbound.protection.outlook.com [40.107.208.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A7D3ECBDD;
	Thu, 25 Jun 2026 17:34:17 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782408876; cv=fail; b=CqArUKUFjBSWxkqJYE6Jv8vluJ7tlbm1gvvlqiznVzYuPtFFisxlt6pmwSjYSdBLlH7T2nZhEtFLhUB/a5kf0GZA+kK6ck6xJicqXy9Z7eeV9pJKoDhRYyW7d4Ti3aooznekq7qV5ULGkBZwTHadYjnKr+oudYRFx4LXqh3fw+E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782408876; c=relaxed/simple;
	bh=FKIpqgpc4/Jg4RiNsWSxiXAwg8kgXEWGacD74KVmRhI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VYz1QMrdnFVG4MyGiIrU1Gz0V/xWon8FSibWutlI+j1GI9Isg2Jgx7GU6kx5xp1aPWroUPKh2ZN2z44wgTiNIRx8zZB2VnEdL+kEWNt6X25nwE8QGO45Y9fRyiYNZX1nO0ifHLC+SkKj1iydaOXcAPiRhWKsvsSXeaxsFy2fq0Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rambus.com; spf=fail smtp.mailfrom=rambus.com; dkim=pass (2048-bit key) header.d=rambus.com header.i=@rambus.com header.b=s5VJf6uJ; arc=fail smtp.client-ip=40.107.208.110
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XH+2tjj6JgseKSynsiqhwVjYB21uNyM4QlO+11vLQ/YCEY4NcQEb1bml3NRC7Vcim3TEVqsieKMa1upqA1XMwBOBZQ48hAVOvUvF0HoACYj+5eB3rHKyQ04ldbnVMLOYNlcuEeVA+52DLik/93HyHVYJ8l+Awq3vvdJt/imj0Okw8Vll92sGpzfUlHKzvucMIgn86XZH/Cq/cMpOwrTDTJSUm0ms5dUnXwXXXwOh2drr8bzWTBAyEqy2GS7bv0jLvmOf9wiMBEu3lCW9ACdi4unKtUhooQ8zlhnypo2EGgvYp43o032Q8Z0x48Z5XRS+2YwctqsfvwoJDZF8y8n4Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NF0YUTXe3MgbteQCrZNbewqcjsovCgxs1QqW9rdozqY=;
 b=iMq5b5GZgz1jW6yaCMsihyfJwLUw4EQe3YSO245oLe/AeFM4HAmimNYm1QG1PkTSNKn6YgFS+as0LDFHqB4hF1SwPngbKmn/Mom5xtvFsx+EbhFOuoUVPswLM2jTa+QBwNwSYdkUqszqSWXhIrXpcsm6QNDiq30TdEUkl7gv5DOs7kfgazYlRdEuEMXuEf+4XKPxMzOMeNMxz+cVXdnMfmtoOUYTPhFTeBKd/XemV8XNfQ0u00durD4p7FbjYzD65CBXlFHS562O7auk7KhWx6vmXRVhazlxhqX4LTRZpC9ospkFwyz+PqSL95l0yBQuogBM/VdueNqUY9uBv4qZLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.86.86.210) smtp.rcpttodomain=cryptography.com smtp.mailfrom=rambus.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=rambus.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rambus.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NF0YUTXe3MgbteQCrZNbewqcjsovCgxs1QqW9rdozqY=;
 b=s5VJf6uJ9k7/ojr7o2w2BnK/8eI6aNYVlD/yClMPtroLLNNWcQJm704PUk70AsogtTT7w8n6sIiamuYYRgS4xcIERNGkLn7Qf5giQCP3apb86giwdVQwju42iuJBSbbEGCdWcUDdqCm2JcKLmpAMvq1ji8RsEAFYV+hE4kme/mrrFKCr6ZS2FRbqpyRwxkwALFk02TmzuIy79v6kngfmb5OvQW5LVr1rHzd27SaKCmPtAJx1JeODjrymZi8IPQTdoTENpIW9nb03YytxFKQrE0NRTxBUiEC8YPF1r+TWCaRp1v3vm7SkGoVjJ2No7iU/sPXLsNlfivMR38/KZ5WhaA==
Received: from BN9P222CA0030.NAMP222.PROD.OUTLOOK.COM (2603:10b6:408:10c::35)
 by CO6PR04MB7652.namprd04.prod.outlook.com (2603:10b6:303:a8::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.14; Thu, 25 Jun
 2026 17:34:08 +0000
Received: from BN2PEPF000044A1.namprd02.prod.outlook.com
 (2603:10b6:408:10c:cafe::43) by BN9P222CA0030.outlook.office365.com
 (2603:10b6:408:10c::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.15 via Frontend Transport; Thu,
 25 Jun 2026 17:34:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.86.86.210)
 smtp.mailfrom=rambus.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=rambus.com;
Received-SPF: Pass (protection.outlook.com: domain of rambus.com designates
 192.86.86.210 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.86.86.210; helo=hqxsv-psmtppxy02.rambus.com; pr=C
Received: from hqxsv-psmtppxy02.rambus.com (192.86.86.210) by
 BN2PEPF000044A1.mail.protection.outlook.com (10.167.243.152) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.6
 via Frontend Transport; Thu, 25 Jun 2026 17:34:07 +0000
Received: from hqxsv-cmdev3-skrishnamoorthy.rambus.com (hqn-lb-int-float.rambus.com [10.12.20.20])
	by hqxsv-psmtppxy02.rambus.com (Postfix) with ESMTPS id 23CFC1801755;
	Thu, 25 Jun 2026 17:34:06 +0000 (UTC)
From: Saravanakrishnan Krishnamoorthy <skrishnamoorthy@rambus.com>
To: Albert Ou <aou@eecs.berkeley.edu>,
	Alex Ousherovitch <aousherovitch@rambus.com>,
	Conor Dooley <conor+dt@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Jonathan Corbet <corbet@lwn.net>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <pjw@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Saravanakrishnan Krishnamoorthy <skrishnamoorthy@rambus.com>,
	Shuah Khan <shuah@kernel.org>
Cc: Alexandre Ghiti <alex@ghiti.fr>,
	devicetree@vger.kernel.org,
	Joel Wittenauer <Joel.Wittenauer@cryptography.com>,
	linux-api@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Shuah Khan <skhan@linuxfoundation.org>,
	sipsupport@rambus.com,
	Thi Nguyen <thin@rambus.com>
Subject: [PATCH 03/19] crypto: cmh - add key provisioning and management
Date: Thu, 25 Jun 2026 10:33:11 -0700
Message-ID: <20260625173328.1140487-4-skrishnamoorthy@rambus.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260625173328.1140487-1-skrishnamoorthy@rambus.com>
References: <20260625173328.1140487-1-skrishnamoorthy@rambus.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A1:EE_|CO6PR04MB7652:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 5a19e0cb-7595-4ba4-b18f-08ded2dff5a2
X-LD-Processed: bd0ba799-c2b9-413c-9c56-5d1731c4827c,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|23010399003|7416014|376014|1800799024|36860700016|56012099006|5023799004|11063799006|18002099003|22082099003|6133799003|3023799007|921020;
X-Microsoft-Antispam-Message-Info:
	AZgDj98qQDxjvJ2NodhKshjh8cjA4Se0WD/xlWY6W2UNvQV9Ni2Y/VwBtdL63PGuIElTzqyOYhzd/AfNQRVboY7zvWSV0XFHF4Yd7ITyqfdRXQxFNuAJmHpO1Cchg8ctglQP5ewm8txvJHusZDt98szWdJXHplYXoAVlIu/WetRvh3Py3upUR5A048zZQji3R2+3r799l1+7p1b+gQpV8AMVPrWcYWl+r6IxSZH/6evcwDwDASxFhXUMMBi4bysNKUx31SJqmKtorUyubYUjGu4fASU91IASUudj9C0RpArXNWcwz3Xa6USH7MrYVt9bbBEUuaaXSSdAYPAXRL3uyG7N75o6T1VyEVu5l1hubnNkCxWoTuJKvRe4oCvkotHc1iy9FfhLFk4YWmzTLFGz2EjY7mzm/jgbCQZoPON1Gx4q+yHb7OY0MTSjH+/xtHwoX85oEG0ASxjSTBQ2puPDP9GATMnRTziiJVhAqsoG9MaZHeRw7Ei5XRI5JigoxqWe5y4IEnmT8L9Ax0v0wDOfMhOdRC1uMyCA6BIA7C3eM+FdAgxMreqKjrA2QAOTWt9tDUAXG8WtKfDKl39LHiEhk7zQyIvOEvh+WMMEPw4kbaPCBa+tZ2BcvJRK4JxblUPG+GFII+L8Vp57xDie3oNH9jclmUm5lzr0Y8FyRM34tQRXGH4tRpN2pt7ZQZnkd0vZ4HYqnTY7gSpN5NFZqt3DtU57CGD6WI2BbD4lImE0TjnCnjuXPf7QRZGsP65dsk42
X-Forefront-Antispam-Report:
	CIP:192.86.86.210;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hqxsv-psmtppxy02.rambus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(23010399003)(7416014)(376014)(1800799024)(36860700016)(56012099006)(5023799004)(11063799006)(18002099003)(22082099003)(6133799003)(3023799007)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	HTupDn6Q1NlzzmM9dktGYwv8rqM/OasFF5/d8AWgDP+lsr6MsShvruv6tH9+nU6jHwUoa6lyXFSklMa4He9d0ZsxdfS11OwNxuh+xpBMhyJWUSHVu9YzB68fMk6pAl4B835j/+IebWrV/JRVb8bfXFvyYdBHhF5bt+0sryCGh4OK6QTuEtjm2GizMQW29tM/ObahMGx8/TdfdEdLL3vHFrmLiq1XiEE+7y5PlKPRssl9LSsX8x6DyDDZcrUAWFWzlDBUkYTHpOx8Pm8EQCn7ENJNdZJen41ZiX30z90J3wYaL/oqJVrEnPycaexfO7Tq8mDyS+mmfDK5+5gQSz2G5vnGUtveDG7v5vPdlcdhu42N9OKnHdoK+pDGgnV+A9tLL2eQ+E5gu/ZoEvTuZm2oCGq+Jwz6z5RCtNtMPAh/IhLfBIbAGqoh7Ah9f7B44CjU
X-OriginatorOrg: rambus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 17:34:07.1360
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a19e0cb-7595-4ba4-b18f-08ded2dff5a2
X-MS-Exchange-CrossTenant-Id: bd0ba799-c2b9-413c-9c56-5d1731c4827c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bd0ba799-c2b9-413c-9c56-5d1731c4827c;Ip=[192.86.86.210];Helo=[hqxsv-psmtppxy02.rambus.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A1.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB7652
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[rambus.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[rambus.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[skrishnamoorthy@rambus.com,linux-api@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[24];
	TAGGED_FROM(0.00)[bounces-6701-lists,linux-api=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:aou@eecs.berkeley.edu,m:aousherovitch@rambus.com,m:conor+dt@kernel.org,m:davem@davemloft.net,m:herbert@gondor.apana.org.au,m:corbet@lwn.net,m:krzk+dt@kernel.org,m:palmer@dabbelt.com,m:pjw@kernel.org,m:robh@kernel.org,m:skrishnamoorthy@rambus.com,m:shuah@kernel.org,m:alex@ghiti.fr,m:devicetree@vger.kernel.org,m:Joel.Wittenauer@cryptography.com,m:linux-api@vger.kernel.org,m:linux-crypto@vger.kernel.org,m:linux-doc@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:linux-riscv@lists.infradead.org,m:skhan@linuxfoundation.org,m:sipsupport@rambus.com,m:thin@rambus.com,m:conor@kernel.org,m:krzk@kernel.org,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[rambus.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skrishnamoorthy@rambus.com,linux-api@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[req.ss:url,cryptography.com:email,req.dk:url,req.data:url,vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,req.pk:url,rambus.com:url,rambus.com:from_mime,rambus.com:dkim,rambus.com:email,rambus.com:mid];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-api,dt];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 105F76C7E1A

From: Alex Ousherovitch <aousherovitch@rambus.com>

Add the CMH key management subsystem:

- Key provisioning: create, import, derive, and destroy hardware keys
  stored in the CMH datastore
- System object management: allocate and free CMH system objects
- Management ioctl interface (/dev/cmh_mgmt): ioctl commands
  covering key lifecycle, KIC key derivation, PKE operations (RSA,
  ECDSA, ECDH, EdDSA), PQC operations (ML-KEM, ML-DSA, SLH-DSA),
  SM2, EAC, and DRBG reseeding
- SM2 ioctl handlers: SM2 encrypt, decrypt, sign, and key exchange
  -- operations that require multi-step protocol flows not
  expressible through the standard crypto API sig interface
- UAPI header: cmh_mgmt_ioctl.h (ioctl definitions and structures)

The misc device requires CAP_SYS_ADMIN for open().

Co-developed-by: Saravanakrishnan Krishnamoorthy <skrishnamoorthy@rambus.co=
m>
Signed-off-by: Saravanakrishnan Krishnamoorthy <skrishnamoorthy@rambus.com>
Signed-off-by: Alex Ousherovitch <aousherovitch@rambus.com>
Reviewed-by: Joel Wittenauer <Joel.Wittenauer@cryptography.com>
Reviewed-by: Thi Nguyen <thin@rambus.com>
---
 Documentation/ABI/testing/cmh-mgmt       |  136 ++
 drivers/crypto/cmh/Kconfig               |   19 +
 drivers/crypto/cmh/Makefile              |   11 +-
 drivers/crypto/cmh/cmh_key.c             |  164 +++
 drivers/crypto/cmh/cmh_main.c            |    9 +
 drivers/crypto/cmh/cmh_mgmt.c            | 1607 ++++++++++++++++++++++
 drivers/crypto/cmh/cmh_mgmt_pke.c        | 1100 +++++++++++++++
 drivers/crypto/cmh/cmh_mgmt_pqc.c        | 1279 +++++++++++++++++
 drivers/crypto/cmh/cmh_pke_sm2.c         |  827 +++++++++++
 drivers/crypto/cmh/cmh_sys.c             |  376 +++++
 drivers/crypto/cmh/include/cmh_key.h     |   82 ++
 drivers/crypto/cmh/include/cmh_mgmt.h    |   62 +
 drivers/crypto/cmh/include/cmh_pke.h     |  245 ++++
 drivers/crypto/cmh/include/cmh_pke_sm2.h |   30 +
 drivers/crypto/cmh/include/cmh_pqc.h     |   25 +
 drivers/crypto/cmh/include/cmh_sys.h     |  111 ++
 include/uapi/linux/cmh_mgmt_ioctl.h      |  895 ++++++++++++
 17 files changed, 6977 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/ABI/testing/cmh-mgmt
 create mode 100644 drivers/crypto/cmh/cmh_key.c
 create mode 100644 drivers/crypto/cmh/cmh_mgmt.c
 create mode 100644 drivers/crypto/cmh/cmh_mgmt_pke.c
 create mode 100644 drivers/crypto/cmh/cmh_mgmt_pqc.c
 create mode 100644 drivers/crypto/cmh/cmh_pke_sm2.c
 create mode 100644 drivers/crypto/cmh/cmh_sys.c
 create mode 100644 drivers/crypto/cmh/include/cmh_key.h
 create mode 100644 drivers/crypto/cmh/include/cmh_mgmt.h
 create mode 100644 drivers/crypto/cmh/include/cmh_pke.h
 create mode 100644 drivers/crypto/cmh/include/cmh_pke_sm2.h
 create mode 100644 drivers/crypto/cmh/include/cmh_pqc.h
 create mode 100644 drivers/crypto/cmh/include/cmh_sys.h
 create mode 100644 include/uapi/linux/cmh_mgmt_ioctl.h

diff --git a/Documentation/ABI/testing/cmh-mgmt b/Documentation/ABI/testing=
/cmh-mgmt
new file mode 100644
index 000000000000..2c6fce7ae009
--- /dev/null
+++ b/Documentation/ABI/testing/cmh-mgmt
@@ -0,0 +1,136 @@
+What:          /dev/cmh_mgmt
+Date:          June 2026
+KernelVersion: 7.1
+Contact:       linux-crypto@vger.kernel.org
+Description:
+               Character device (misc) providing a management and
+               key-operations ioctl interface to the CRI CryptoManager Hub
+               hardware crypto accelerator.  Used for operations that
+               cannot be represented through the standard in-kernel
+               crypto API: datastore key CRUD, key derivation,
+               asymmetric crypto (EdDSA, SM2), and post-quantum crypto
+               (ML-KEM, ML-DSA, SLH-DSA).
+
+               The ioctl magic is 'J'.  All struct arguments are
+               versioned via a leading __u32 version field set to
+               CMH_MGMT_V1 (1).
+
+               Ioctl commands are grouped by function:
+
+               **Key Management (0x01-0x0E):**
+
+               - CMH_IOCTL_KEY_NEW (0x01): Allocate a new datastore slot.
+                 Accepts ds_type (CMH_DS_* constant), key length, flags,
+                 and caller ID.  Returns a 64-bit key reference.
+
+               - CMH_IOCTL_KEY_WRITE (0x02): Write key material into
+                 a previously allocated datastore slot.  Supports
+                 plaintext or wrapped key import via a wrapping key ref.
+
+               - CMH_IOCTL_KEY_READ (0x03): Read key material from
+                 a datastore slot, optionally wrapped.  Returns data
+                 plus a 16-byte SYS header for wrapped reads.
+
+               - CMH_IOCTL_KEY_FIND (0x04): Look up a key reference
+                 by caller ID (CID).
+
+               - CMH_IOCTL_KEY_GRANT (0x05): Grant access to a key.
+
+               - CMH_IOCTL_KEY_DELETE (0x06): Delete a datastore slot.
+
+               - CMH_IOCTL_DS_EXPORT (0x07): Export the entire datastore
+                 as an encrypted blob.
+
+               - CMH_IOCTL_DS_IMPORT (0x08): Import a previously exported
+                 datastore blob.
+
+               - CMH_IOCTL_KEY_NEW_RANDOM (0x0B): Allocate a datastore
+                 slot and fill it with hardware-generated random data.
+
+               - CMH_IOCTL_KEY_LIST (0x0E): List active datastore entries,
+                 returning CIDs, types, lengths, and flags.
+
+               **Key Derivation -- KIC (0x09-0x0D):**
+
+               - CMH_IOCTL_KIC_HKDF1 (0x09): HKDF-Extract step.
+               - CMH_IOCTL_KIC_HKDF2 (0x0A): HKDF-Expand step.
+               - CMH_IOCTL_KIC_AES_CMAC_KDF (0x0C): AES-CMAC KDF.
+               - CMH_IOCTL_KIC_DKEK_DERIVE (0x0D): DKEK derivation.
+
+               **EAC -- Error and Alarm (0x0F):**
+
+               - CMH_IOCTL_EAC_READ (0x0F): Read and clear hardware
+                 error, alarm, and safety notification registers.
+
+               **PKE -- Public Key Engine (0x10-0x1C):**
+
+               - CMH_IOCTL_PKE_RSA_ENC (0x10): RSA public-key encrypt.
+               - CMH_IOCTL_PKE_RSA_DEC (0x11): RSA private-key decrypt.
+               - CMH_IOCTL_PKE_RSA_CRT_DEC (0x12): RSA-CRT decrypt.
+               - CMH_IOCTL_PKE_RSA_KEYGEN (0x13): RSA key pair generation.
+               - CMH_IOCTL_PKE_ECDSA_SIGN (0x14): ECDSA sign.
+               - CMH_IOCTL_PKE_ECDH (0x16): ECDH shared secret.
+               - CMH_IOCTL_PKE_ECDH_KEYGEN (0x17): ECDH key pair generatio=
n.
+               - CMH_IOCTL_PKE_EDDSA_SIGN (0x18): EdDSA sign (Ed25519/Ed44=
8).
+               - CMH_IOCTL_PKE_EDDSA_VERIFY (0x19): EdDSA verify.
+               - CMH_IOCTL_PKE_EC_KEYGEN (0x1A): EC key pair generation.
+               - CMH_IOCTL_PKE_EC_PUBGEN (0x1B): EC public key derivation.
+               - CMH_IOCTL_PKE_EDDSA_KEYGEN_SCA (0x1C): EdDSA SCA-protecte=
d
+                 key generation.
+
+               **PQC -- Post-Quantum Crypto (0x20-0x2D):**
+
+               - CMH_IOCTL_ML_KEM_KEYGEN (0x20): ML-KEM key pair generatio=
n
+                 (modes 512/768/1024).
+               - CMH_IOCTL_ML_KEM_ENC (0x21): ML-KEM encapsulation.
+               - CMH_IOCTL_ML_KEM_DEC (0x22): ML-KEM decapsulation.
+               - CMH_IOCTL_ML_DSA_KEYGEN (0x23): ML-DSA key pair generatio=
n
+                 (modes 44/65/87).
+               - CMH_IOCTL_ML_DSA_SIGN (0x24): ML-DSA sign.
+               - CMH_IOCTL_SLHDSA_KEYGEN (0x28): SLH-DSA key pair generati=
on
+                 (12 parameter sets).
+               - CMH_IOCTL_SLHDSA_SIGN (0x29): SLH-DSA sign.
+               - CMH_IOCTL_SLHDSA_SIGN_PREHASH (0x2D): SLH-DSA prehash sig=
n.
+
+               **SM2 Operations (0x30-0x37):**
+
+               - CMH_IOCTL_SM2_ECDH_KEYGEN (0x30): SM2 ephemeral key gen.
+               - CMH_IOCTL_SM2_ECDH (0x31): SM2 key exchange.
+               - CMH_IOCTL_SM2_DEC_POINT (0x32): SM2 decrypt (point step).
+               - CMH_IOCTL_SM2_ENC_POINT (0x33): SM2 encrypt (point step).
+               - CMH_IOCTL_SM2_ID_DIGEST (0x34): SM2 ID digest (ZA).
+               - CMH_IOCTL_SM2_ECDH_HASH (0x35): SM2 key exchange hash ste=
p.
+               - CMH_IOCTL_SM2_DEC_HASH (0x36): SM2 decrypt (hash step).
+               - CMH_IOCTL_SM2_ENC_HASH (0x37): SM2 encrypt (hash step).
+
+               The SM2 encrypt/decrypt hash-step ioctls accept payloads
+               of at most 32 bytes.  The underlying hardware KDF emits a
+               single 32-byte SM3 block, so longer messages cannot be
+               processed in a single command and are rejected with
+               -EINVAL.
+
+               **DRBG Management (0x40):**
+
+               - CMH_IOCTL_DRBG_CONFIG (0x40): Configure the hardware
+                 DRBG entropy ratio and security strength.  Normally
+                 called once at system start-up before hwrng reads.
+
+               All structs contain ``__reserved`` fields that must be
+               zero; the driver returns ``-EINVAL`` if any reserved field
+               is non-zero.  This ensures forward compatibility when
+               reserved fields gain meaning in future versions.
+
+               All ioctls return 0 on success or a negative errno on
+               failure.  Common errors:
+
+               - EINVAL:  Invalid version, parameter, key type, or
+                 non-zero reserved field.
+               - ENOENT:  Key reference not found in datastore.
+               - ENOMEM:  DMA allocation failure.
+               - EBUSY:   Hardware mailbox full.
+               - ETIMEDOUT: VCQ operation timed out.
+               - EFAULT:  Bad user-space pointer.
+
+               The ioctl UAPI header is <linux/cmh_mgmt_ioctl.h>.
+               All structures, constants, and type definitions are
+               documented in that header file.
diff --git a/drivers/crypto/cmh/Kconfig b/drivers/crypto/cmh/Kconfig
index fa5adeca2512..c607014f8fbc 100644
--- a/drivers/crypto/cmh/Kconfig
+++ b/drivers/crypto/cmh/Kconfig
@@ -44,3 +44,22 @@ config CRYPTO_DEV_CMH_DEBUG
          Useful for bringup, validation, and performance analysis.
          Not recommended for production.

+
+config CRYPTO_DEV_CMH_MGMT
+       bool "CMH management ioctl device (/dev/cmh_mgmt)"
+       depends on CRYPTO_DEV_CMH
+       default n
+       help
+         Expose /dev/cmh_mgmt, a misc device providing ioctl commands
+         for operations that have no kernel crypto API binding: hardware
+         key lifecycle (create, import, derive, destroy), KIC key
+         derivation, PQC keygen/encaps/decaps (ML-KEM, ML-DSA, SLH-DSA),
+         EdDSA sign/verify, SM2 key exchange, and DRBG
+         configuration.
+
+         The device requires CAP_SYS_ADMIN.  Disabling this option
+         removes the ioctl interface but all kernel crypto API
+         algorithms (consumed by in-kernel users and validated by the
+         crypto test manager) remain fully functional.
+
+         If unsure, say N.
diff --git a/drivers/crypto/cmh/Makefile b/drivers/crypto/cmh/Makefile
index 0a4591c9fd86..1492e575598c 100644
--- a/drivers/crypto/cmh/Makefile
+++ b/drivers/crypto/cmh/Makefile
@@ -12,7 +12,16 @@ cmh-y :=3D \
        cmh_txn.o \
        cmh_rh.o \
        cmh_dma.o \
-       cmh_sysfs.o
+       cmh_sysfs.o \
+       cmh_key.o \
+       cmh_sys.o
+
+# Management ioctl device (/dev/cmh_mgmt): key lifecycle, PKE, PQC ioctls.
+cmh-$(CONFIG_CRYPTO_DEV_CMH_MGMT) +=3D \
+       cmh_mgmt.o \
+       cmh_mgmt_pke.o \
+       cmh_mgmt_pqc.o \
+       cmh_pke_sm2.o

 ccflags-y +=3D -I$(src)/include

diff --git a/drivers/crypto/cmh/cmh_key.c b/drivers/crypto/cmh/cmh_key.c
new file mode 100644
index 000000000000..fde8be50b25c
--- /dev/null
+++ b/drivers/crypto/cmh/cmh_key.c
@@ -0,0 +1,164 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2026 Cryptography Research, Inc. (CRI).
+ * CMH LKM -- Dual Key Path Implementation
+ *
+ * Two key provisioning paths are supported:
+ *
+ * Raw key:  key bytes -> stored in tfm context ->
+ *   SYS_CMD_WRITE(SYS_REF_TEMP) packed into every crypto VCQ.
+ *   The raw key buffer is DMA-mapped once at setkey time and remains
+ *   mapped for the lifetime of the transform (unmapped in destroy).
+ *
+ * Raw key DMA lifetime rationale
+ * ------------------------------
+ * Raw keys are DMA-mapped at setkey time and the mapping persists
+ * until the transform is destroyed (cmh_key_destroy).  This is a
+ * deliberate design choice, consistent with upstream HW crypto
+ * drivers (CAAM, ccree, CCP) that also map keys at setkey for
+ * transform-lifetime reuse:
+ *
+ *   - The Linux crypto framework expects setkey to prepare the
+ *     transform for repeated encrypt/decrypt calls.  Remapping the
+ *     same key on every request would add DMA API overhead per crypto
+ *     operation with no security benefit.
+ *   - On destroy, kfree_sensitive() scrubs the key buffer and the
+ *     DMA mapping is released.  For key-by-ID (persistent), the
+ *     per-MBX ref cache is zeroed with memzero_explicit().
+ *   - No key material is ever logged; dev_dbg() messages only show
+ *     CIDs (content identifiers), not key bytes.
+ *
+ * Hardware-required behaviors (not driver policy)
+ * ------------------------------------------------
+ * - SYS_REF_TEMP lifetime:  the eSW firmware reclaims temporary
+ *   datastore objects when the mailbox slot is reused.  This is a
+ *   hardware constraint; the driver packs SYS_CMD_WRITE into every
+ *   VCQ to re-provision the raw key for each operation.
+ * - Mailbox flush (SYS_CMD_FLUSH):  reclaims temp-stack space on the
+ *   target MBX.  Required by HW to prevent temp-stack exhaustion
+ *   across multi-VCQ operations.
+ */
+
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+
+#include "cmh_key.h"
+#include "cmh_sys.h"
+#include "cmh_txn.h"
+#include "cmh_dma.h"
+#include "cmh_sys_abi.h"
+#include <uapi/linux/cmh_mgmt_ioctl.h>
+
+/**
+ * cmh_ds_type_to_core_id() - Map a datastore type to a logical core ID
+ * @ds_type: Datastore type constant (e.g. CMH_DS_AES_KEY, CMH_DS_SM4_KEY)
+ *
+ * Returns the algorithm-family identity (e.g. CORE_ID_AES =3D 0x03), NOT =
the
+ * VCQ dispatch core_id.  With multi-instance, a second AES engine dispatc=
hes
+ * at CORE_ID_AES2 (0x06) but keys are still tagged with CORE_ID_AES (0x03=
)
+ * -- the eSW validates against the logical identity, not the dispatch ID.
+ *
+ * Return: Logical core ID on success, CORE_ID_NUM for unknown @ds_type.
+ */
+u32 cmh_ds_type_to_core_id(u32 ds_type)
+{
+       switch (ds_type) {
+       case CMH_DS_AES_KEY:
+       case CMH_DS_AES_XTS_KEY:
+               return CORE_ID_AES;
+       case CMH_DS_SM4_KEY:
+               return CORE_ID_SM4;
+       case CMH_DS_HMAC_KEY:
+       case CMH_DS_KMAC_KEY:
+               return CORE_ID_HC;
+       case CMH_DS_CHACHA20_KEY:
+               return CORE_ID_CCP;
+       case CMH_DS_RSA_PRIV_KEY:
+       case CMH_DS_RSA_PUB_KEY:
+       case CMH_DS_RSA_CRT_KEY:
+       case CMH_DS_ECDSA_PRIV_KEY:
+       case CMH_DS_ECDSA_PUB_KEY:
+       case CMH_DS_ECDH_PRIV_KEY:
+       case CMH_DS_EDDSA_PRIV_KEY:
+       case CMH_DS_SHARED_SECRET:
+       case CMH_DS_SM2_PRIV_KEY:
+               return CORE_ID_PKE;
+       case CMH_DS_ML_KEM_DK:
+       case CMH_DS_ML_DSA_SK:
+               return CORE_ID_QSE;
+       case CMH_DS_SLHDSA_SK:
+               return CORE_ID_HCQ;
+       default:
+               return CORE_ID_NUM;
+       }
+}
+
+/**
+ * cmh_key_setkey_raw() - Store a raw key in the key context
+ * @ctx: Key context to populate
+ * @key: Pointer to the raw key bytes
+ * @keylen: Length of @key in bytes
+ * @core_id: Logical core ID for SYS_TYPE tagging
+ *
+ * Duplicates the raw key, DMA-maps the copy for the lifetime of the
+ * transform, and stores the mapping in @ctx.  Any previously held key
+ * is destroyed first.
+ *
+ * The DMA mapping persists until cmh_key_destroy() is called (typically
+ * from the algorithm .exit_tfm callback).  This avoids per-request DMA
+ * mapping overhead and matches the setkey-to-destroy lifetime model used
+ * by other upstream HW crypto drivers (CAAM, ccree, CCP).  The key
+ * buffer is freed via kfree_sensitive() on destroy.
+ *
+ * Return: 0 on success, negative errno on failure.
+ */
+int cmh_key_setkey_raw(struct cmh_key_ctx *ctx, const u8 *key,
+                      u32 keylen, u32 core_id)
+{
+       dma_addr_t dma;
+       u8 *copy;
+
+       if (!keylen || !key)
+               return -EINVAL;
+
+       copy =3D kmemdup(key, keylen, GFP_KERNEL);
+       if (!copy)
+               return -ENOMEM;
+
+       /* Pre-map for the lifetime of the transform */
+       dma =3D cmh_dma_map_single(copy, keylen, DMA_TO_DEVICE);
+       if (cmh_dma_map_error(dma)) {
+               kfree_sensitive(copy);
+               return -ENOMEM;
+       }
+
+       /* Clean up any previous key */
+       cmh_key_destroy(ctx);
+
+       ctx->mode =3D CMH_KEY_RAW;
+       ctx->raw.data =3D copy;
+       ctx->raw.len =3D keylen;
+       ctx->raw.dma =3D dma;
+       ctx->raw.sys_type =3D SYS_TYPE_SET(SYS_TYPE_FLAG_PT, core_id);
+
+       return 0;
+}
+
+/**
+ * cmh_key_destroy() - Destroy and zero-fill a key context
+ * @ctx: Key context to destroy
+ *
+ * For raw keys, unmaps the DMA buffer and securely frees the key material=
.
+ * Resets the key mode to CMH_KEY_NONE.
+ */
+void cmh_key_destroy(struct cmh_key_ctx *ctx)
+{
+       if (ctx->mode =3D=3D CMH_KEY_RAW && ctx->raw.data) {
+               cmh_dma_unmap_single(ctx->raw.dma, ctx->raw.len,
+                                    DMA_TO_DEVICE);
+               kfree_sensitive(ctx->raw.data);
+               memzero_explicit(&ctx->raw, sizeof(ctx->raw));
+       }
+       ctx->mode =3D CMH_KEY_NONE;
+}
diff --git a/drivers/crypto/cmh/cmh_main.c b/drivers/crypto/cmh/cmh_main.c
index 452b8272908f..307bd7dd304b 100644
--- a/drivers/crypto/cmh/cmh_main.c
+++ b/drivers/crypto/cmh/cmh_main.c
@@ -29,6 +29,7 @@
 #include "cmh_mqi.h"
 #include "cmh_txn.h"
 #include "cmh_rh.h"
+#include "cmh_mgmt.h"
 #include "cmh_registers.h"
 #include "cmh_debugfs.h"
 #include "cmh_sysfs.h"
@@ -190,12 +191,19 @@ static int cmh_probe(struct platform_device *pdev)
        if (ret)
                goto err_rh_init;

+       /* Register key management device (/dev/cmh_mgmt) */
+       ret =3D cmh_mgmt_register();
+       if (ret)
+               goto err_mgmt_register;
+
        g_cmh_dev =3D dev;
        platform_set_drvdata(pdev, dev);

        dev_info(cmh_dev(), "initialized successfully\n");
        return 0;

+err_mgmt_register:
+       cmh_rh_cleanup(cfg);
 err_rh_init:
        cmh_tm_cleanup();
 err_tm_init:
@@ -220,6 +228,7 @@ static void cmh_remove(struct platform_device *pdev)

        cfg =3D &dev->config;

+       cmh_mgmt_unregister();
        cmh_rh_cleanup(cfg);
        cmh_tm_cleanup();
        cmh_mqi_cleanup(cfg);
diff --git a/drivers/crypto/cmh/cmh_mgmt.c b/drivers/crypto/cmh/cmh_mgmt.c
new file mode 100644
index 000000000000..d228213f7850
--- /dev/null
+++ b/drivers/crypto/cmh/cmh_mgmt.c
@@ -0,0 +1,1607 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2026 Cryptography Research, Inc. (CRI).
+ * CMH LKM -- Key Management misc_device (/dev/cmh_mgmt)
+ *
+ * Provides ioctl interface for key provisioning (NEW, NEW_RANDOM, WRITE, =
READ,
+ * FIND, GRANT, DELETE) and datastore lifecycle (EXPORT, IMPORT).
+ *
+ * Each ioctl handler: copy_from_user -> validate -> DMA alloc ->
+ * build VCQ -> cmh_tm_submit_sync -> copy_to_user -> DMA free.
+ *
+ * Access requires CAP_SYS_ADMIN (checked in open()).  The device node
+ * is mode 0660; DAC further limits access to owner/group.
+ * CMH eSW enforces per-MBX access control on top of this.
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/miscdevice.h>
+#include <linux/uaccess.h>
+#include <linux/slab.h>
+#include <linux/fs.h>
+#include <linux/capability.h>
+#include <linux/overflow.h>
+
+#include "cmh_mgmt.h"
+#include "cmh_sys.h"
+#include "cmh_txn.h"
+#include "cmh_key.h"
+#include "cmh_dma.h"
+#include "cmh_config.h"
+#include "cmh_sys_abi.h"
+#include "cmh_pke.h"
+#include "cmh_pke_sm2.h"
+#include "cmh_qse_abi.h"
+#include "cmh_hcq_abi.h"
+#include <uapi/linux/cmh_mgmt_ioctl.h>
+
+#include <crypto/utils.h>
+
+/*
+ * Pin all mgmt ioctls to a single management mailbox (MBX 0).
+ *
+ * This is a deliberate, structural choice -- not a performance default.
+ * The /dev/cmh_mgmt path is *stateful* with respect to the eSW datastore,
+ * and that state is per-mailbox, so every step of a key's lifecycle must
+ * land on the same mailbox:
+ *
+ * 1. Datastore access control is per-mailbox AND opaque to the driver.
+ *    SYS_CMD_NEW grants the creating mailbox a (1 << mbx_id) access mask
+ *    (read/write/execute).  Crucially, the returned 64-bit ref encodes a
+ *    randomised offset -- NOT the owning mailbox -- so given only a ref
+ *    (as KEY_GRANT/READ/DELETE/DS_EXPORT receive), the driver cannot
+ *    recover which mailbox owns the object.  A fixed management mailbox
+ *    is therefore the only way to guarantee that NEW, WRITE, GRANT, READ
+ *    and the subsequent hardware-held-key compute ops all share the
+ *    mailbox that holds the access rights, without exposing mailbox
+ *    identity in the UABI.  (User space may still widen access to other
+ *    mailboxes explicitly via KEY_GRANT.)
+ *
+ * 2. The eSW SYS_REF_TEMP scratch store is per-mailbox and persists
+ *    across ioctl calls.  A derivation that writes SYS_REF_TEMP (e.g. a
+ *    KIC_* derive) must be consumed by a later ioctl on the *same*
+ *    mailbox (e.g. DS_EXPORT with wrap_key=3DSYS_REF_TEMP).
+ *
+ * Device-tree per-core ``cri,mbx`` affinity applies to the *stateless*
+ * registered crypto API path (cmh_core_select_instance()), which carries
+ * no datastore state across calls and is free to balance across mailboxes=
.
+ *
+ * Note: MBX 0 is NOT reserved exclusively for mgmt -- registered crypto
+ * operations may also land here via TM round-robin (target_mbx =3D -1).
+ * This is safe because those ops do not allocate from the temp store.
+ */
+
+/* VCQ layout: header + command + flush =3D 3 entries */
+#define MGMT_VCQ_CMDS          3
+
+/*
+ * Tracks whether any operation has left residual state in the device's
+ * per-mailbox temporary key store since the last flush.  The device
+ * reclaims temp storage only on a full mailbox flush (MBX_COMMAND_FLUSH),
+ * which also terminates any executing command queue with -EPIPE.
+ *
+ * To avoid killing concurrent in-flight operations, the flush in
+ * cmh_mgmt_ioctl() is conditional: it fires only when this flag is set.
+ * Operations that allocate temp storage (currently: KIC derivations
+ * targeting SYS_REF_TEMP) set this flag on success.
+ */
+static atomic_t mgmt_temp_dirty =3D ATOMIC_INIT(0);
+
+/* -- KEY_NEW -------------------------- */
+
+static int cmh_mgmt_key_new(void __user *argp)
+{
+       struct cmh_ioctl_key_new req;
+       struct vcq_cmd vcq[MGMT_VCQ_CMDS];
+       u64 *ref_buf;
+       dma_addr_t ref_dma;
+       int ret;
+
+       if (copy_from_user(&req, argp, sizeof(req)))
+               return -EFAULT;
+
+       if (req.version !=3D CMH_MGMT_V1)
+               return -EINVAL;
+       if (!req.len)
+               return -EINVAL;
+
+       /* DMA buffer for CMH eSW to write back the ref */
+       ref_buf =3D kmalloc_obj(*ref_buf, GFP_KERNEL);
+       if (!ref_buf)
+               return -ENOMEM;
+
+       *ref_buf =3D 0;
+       ref_dma =3D cmh_dma_map_single(ref_buf, sizeof(*ref_buf),
+                                    DMA_FROM_DEVICE);
+       if (cmh_dma_map_error(ref_dma)) {
+               kfree(ref_buf);
+               return -ENOMEM;
+       }
+
+       vcq_set_header(&vcq[0], MGMT_VCQ_CMDS);
+       vcq_add_sys_new(&vcq[1], req.cid, ref_dma, req.len);
+       vcq_add_sys_flush(&vcq[2]);
+
+       ret =3D cmh_tm_submit_sync_mbx(vcq, MGMT_VCQ_CMDS, 1, MGMT_MBX);
+
+       /*
+        * Unmap before CPU read: single-phase operation (no re-use of
+        * the DMA mapping), so unmap transfers ownership back to the
+        * CPU.  On SWIOTLB systems the unmap copies the bounce buffer
+        * to the original allocation.  This is the correct pattern for
+        * single-shot sync submits where the buffer is not re-mapped.
+        */
+       cmh_dma_unmap_single(ref_dma, sizeof(*ref_buf), DMA_FROM_DEVICE);
+
+       if (ret) {
+               kfree(ref_buf);
+               return ret;
+       }
+
+       req.ref =3D *ref_buf;
+       kfree(ref_buf);
+
+       if (copy_to_user(argp, &req, sizeof(req)))
+               return -EFAULT;
+
+       dev_dbg(cmh_dev(), "mgmt: KEY_NEW cid=3D0x%llx len=3D%u -> ref=3D0x=
%llx\n",
+               req.cid, req.len, req.ref);
+       return 0;
+}
+
+/* -- KEY_WRITE ------------------------- */
+
+static int cmh_mgmt_key_write(void __user *argp)
+{
+       struct cmh_ioctl_key_write req;
+       struct vcq_cmd vcq[MGMT_VCQ_CMDS];
+       void *dmabuf;
+       dma_addr_t dma_addr;
+       u32 core_id, sys_type;
+       int ret;
+
+       if (copy_from_user(&req, argp, sizeof(req)))
+               return -EFAULT;
+
+       if (req.version !=3D CMH_MGMT_V1)
+               return -EINVAL;
+       if (!req.len || req.len > CMH_MGMT_MAX_DATA_LEN)
+               return -EINVAL;
+
+       core_id =3D cmh_ds_type_to_core_id(req.ds_type);
+       if (core_id =3D=3D CORE_ID_NUM)
+               return -EINVAL;
+       sys_type =3D SYS_TYPE_SET(req.flags, core_id);
+
+       dmabuf =3D kmalloc(req.len, GFP_KERNEL);
+       if (!dmabuf)
+               return -ENOMEM;
+
+       if (copy_from_user(dmabuf, u64_to_user_ptr(req.data),
+                          req.len)) {
+               kfree_sensitive(dmabuf);
+               return -EFAULT;
+       }
+
+       dma_addr =3D cmh_dma_map_single(dmabuf, req.len, DMA_TO_DEVICE);
+       if (cmh_dma_map_error(dma_addr)) {
+               kfree_sensitive(dmabuf);
+               return -ENOMEM;
+       }
+
+       vcq_set_header(&vcq[0], MGMT_VCQ_CMDS);
+       vcq_add_sys_write(&vcq[1], req.ref, dma_addr, req.wrap_key,
+                         req.len, sys_type);
+       /*
+        * PKE keys on Weierstrass curves and RSA keys must be byte-swapped
+        * when stored in the DS so they match the internal big-endian
+        * representation used by the PKE sidecar.  Edwards curve keys
+        * (EdDSA) use native byte order and must NOT be swapped.
+        */
+       switch (req.ds_type) {
+       case CMH_DS_RSA_PRIV_KEY:
+       case CMH_DS_RSA_PUB_KEY:
+       case CMH_DS_RSA_CRT_KEY:
+       case CMH_DS_ECDSA_PRIV_KEY:
+       case CMH_DS_ECDSA_PUB_KEY:
+       case CMH_DS_ECDH_PRIV_KEY:
+       case CMH_DS_SHARED_SECRET:
+       case CMH_DS_SM2_PRIV_KEY:
+               vcq[1].id |=3D PKE_SWAP_FLAGS;
+               break;
+       default:
+               /* EdDSA, symmetric keys -- no swap */
+               break;
+       }
+       vcq_add_sys_flush(&vcq[2]);
+
+       ret =3D cmh_tm_submit_sync_mbx(vcq, MGMT_VCQ_CMDS, 1, MGMT_MBX);
+
+       cmh_dma_unmap_single(dma_addr, req.len, DMA_TO_DEVICE);
+       kfree_sensitive(dmabuf);
+
+       if (ret)
+               return ret;
+
+       dev_dbg(cmh_dev(), "mgmt: KEY_WRITE ref=3D0x%llx len=3D%u type=3D0x=
%x\n",
+               req.ref, req.len, sys_type);
+       return 0;
+}
+
+/* -- KEY_READ -------------------------- */
+
+static int cmh_mgmt_key_read(void __user *argp)
+{
+       struct cmh_ioctl_key_read req;
+       struct vcq_cmd vcq[MGMT_VCQ_CMDS];
+       void *dmabuf;
+       dma_addr_t dma_addr;
+       int ret;
+
+       if (copy_from_user(&req, argp, sizeof(req)))
+               return -EFAULT;
+
+       if (req.version !=3D CMH_MGMT_V1)
+               return -EINVAL;
+       if (req.__reserved)
+               return -EINVAL;
+       if (!req.len || req.len > CMH_MGMT_MAX_DATA_LEN)
+               return -EINVAL;
+
+       dmabuf =3D kzalloc(req.len, GFP_KERNEL);
+       if (!dmabuf)
+               return -ENOMEM;
+
+       dma_addr =3D cmh_dma_map_single(dmabuf, req.len, DMA_FROM_DEVICE);
+       if (cmh_dma_map_error(dma_addr)) {
+               kfree(dmabuf);
+               return -ENOMEM;
+       }
+
+       vcq_set_header(&vcq[0], MGMT_VCQ_CMDS);
+       vcq_add_sys_read(&vcq[1], req.ref, dma_addr, req.wrap_key, req.len)=
;
+       vcq_add_sys_flush(&vcq[2]);
+
+       ret =3D cmh_tm_submit_sync_mbx(vcq, MGMT_VCQ_CMDS, 1, MGMT_MBX);
+
+       cmh_dma_unmap_single(dma_addr, req.len, DMA_FROM_DEVICE);
+
+       if (ret) {
+               kfree_sensitive(dmabuf);
+               return ret;
+       }
+
+       if (copy_to_user(u64_to_user_ptr(req.data),
+                        dmabuf, req.len)) {
+               kfree_sensitive(dmabuf);
+               return -EFAULT;
+       }
+
+       req.out_len =3D req.len;
+       kfree_sensitive(dmabuf);
+
+       if (copy_to_user(argp, &req, sizeof(req)))
+               return -EFAULT;
+
+       dev_dbg(cmh_dev(), "mgmt: KEY_READ ref=3D0x%llx len=3D%u\n",
+               req.ref, req.out_len);
+       return 0;
+}
+
+/* -- KEY_FIND -------------------------- */
+
+static int cmh_mgmt_key_find(void __user *argp)
+{
+       struct cmh_ioctl_key_find req;
+       struct vcq_cmd vcq[MGMT_VCQ_CMDS];
+       struct sys_list_item *item;
+       dma_addr_t item_dma;
+       int ret;
+
+       if (copy_from_user(&req, argp, sizeof(req)))
+               return -EFAULT;
+
+       if (req.version !=3D CMH_MGMT_V1)
+               return -EINVAL;
+       if (req.__reserved)
+               return -EINVAL;
+
+       item =3D kzalloc_obj(*item, GFP_KERNEL);
+       if (!item)
+               return -ENOMEM;
+
+       item_dma =3D cmh_dma_map_single(item, sizeof(*item), DMA_FROM_DEVIC=
E);
+       if (cmh_dma_map_error(item_dma)) {
+               kfree(item);
+               return -ENOMEM;
+       }
+
+       vcq_set_header(&vcq[0], MGMT_VCQ_CMDS);
+       vcq_add_sys_find(&vcq[1], req.cid, item_dma, sizeof(*item));
+       vcq_add_sys_flush(&vcq[2]);
+
+       ret =3D cmh_tm_submit_sync_mbx(vcq, MGMT_VCQ_CMDS, 1, MGMT_MBX);
+
+       cmh_dma_unmap_single(item_dma, sizeof(*item), DMA_FROM_DEVICE);
+
+       if (ret) {
+               kfree(item);
+               return ret;
+       }
+
+       req.ref =3D item->ref;
+       req.len =3D item->len;
+       req.type =3D item->type;
+       kfree(item);
+
+       if (copy_to_user(argp, &req, sizeof(req)))
+               return -EFAULT;
+
+       dev_dbg(cmh_dev(), "mgmt: KEY_FIND cid=3D0x%llx -> ref=3D0x%llx\n",
+               req.cid, req.ref);
+       return 0;
+}
+
+/* -- KEY_LIST ------------------------- */
+
+static int cmh_mgmt_key_list(void __user *argp)
+{
+       struct cmh_ioctl_key_list req;
+       struct vcq_cmd vcq[MGMT_VCQ_CMDS];
+       struct sys_list_item *item;
+       dma_addr_t item_dma;
+       int ret;
+
+       if (copy_from_user(&req, argp, sizeof(req)))
+               return -EFAULT;
+
+       if (req.version !=3D CMH_MGMT_V1)
+               return -EINVAL;
+
+       if (req.__reserved)
+               return -EINVAL;
+
+       item =3D kzalloc_obj(*item, GFP_KERNEL);
+       if (!item)
+               return -ENOMEM;
+
+       item_dma =3D cmh_dma_map_single(item, sizeof(*item), DMA_FROM_DEVIC=
E);
+       if (cmh_dma_map_error(item_dma)) {
+               kfree(item);
+               return -ENOMEM;
+       }
+
+       vcq_set_header(&vcq[0], MGMT_VCQ_CMDS);
+       vcq_add_sys_list(&vcq[1], req.start_ref, item_dma, sizeof(*item));
+       vcq_add_sys_flush(&vcq[2]);
+
+       ret =3D cmh_tm_submit_sync_mbx(vcq, MGMT_VCQ_CMDS, 1, MGMT_MBX);
+
+       cmh_dma_unmap_single(item_dma, sizeof(*item), DMA_FROM_DEVICE);
+
+       if (ret) {
+               kfree(item);
+               return ret;
+       }
+
+       req.ref =3D item->ref;
+       req.cid =3D item->cid;
+       req.len =3D item->len;
+       req.type =3D item->type;
+       kfree(item);
+
+       if (copy_to_user(argp, &req, sizeof(req)))
+               return -EFAULT;
+
+       return 0;
+}
+
+/* -- KEY_GRANT / KEY_DELETE --------------------- */
+
+static int cmh_mgmt_key_grant(void __user *argp, bool is_delete)
+{
+       struct cmh_ioctl_key_grant req;
+       struct vcq_cmd vcq[MGMT_VCQ_CMDS];
+       int ret;
+
+       if (copy_from_user(&req, argp, sizeof(req)))
+               return -EFAULT;
+
+       if (req.version !=3D CMH_MGMT_V1)
+               return -EINVAL;
+       if (req.__reserved)
+               return -EINVAL;
+
+       /* DELETE =3D GRANT with all permissions zeroed */
+       if (is_delete) {
+               req.read =3D 0;
+               req.write =3D 0;
+               req.execute =3D 0;
+       }
+
+       vcq_set_header(&vcq[0], MGMT_VCQ_CMDS);
+       vcq_add_sys_grant(&vcq[1], req.ref, req.read, req.write, req.execut=
e);
+       vcq_add_sys_flush(&vcq[2]);
+
+       ret =3D cmh_tm_submit_sync_mbx(vcq, MGMT_VCQ_CMDS, 1, MGMT_MBX);
+       if (ret)
+               return ret;
+
+       dev_dbg(cmh_dev(), "mgmt: KEY_%s ref=3D0x%llx r=3D0x%llx w=3D0x%llx=
 x=3D0x%llx\n",
+               is_delete ? "DELETE" : "GRANT",
+               req.ref, req.read, req.write, req.execute);
+       return 0;
+}
+
+/* -- DS_EXPORT ------------------------- */
+
+static int cmh_mgmt_ds_export(void __user *argp)
+{
+       struct cmh_ioctl_ds_export req;
+       struct vcq_cmd vcq[MGMT_VCQ_CMDS];
+       void *dmabuf;
+       dma_addr_t dma_addr;
+       int ret;
+
+       if (copy_from_user(&req, argp, sizeof(req)))
+               return -EFAULT;
+
+       if (req.version !=3D CMH_MGMT_V1)
+               return -EINVAL;
+       if (req.__reserved)
+               return -EINVAL;
+       if (!req.len || req.len > CMH_MGMT_MAX_DATA_LEN)
+               return -EINVAL;
+
+       /*
+        * req.len is the exact DMA buffer size given to the eSW.
+        * Userspace must size it to at least the export blob:
+        *
+        *   wrapped:   sizeof(sys_wrap_hdr) + 2*AES_BLOCK_SIZE + obj_len
+        *              =3D 16 + 32 + obj_len  =3D 48 + obj_len
+        *   plaintext: sizeof(sys_wrap_hdr) + obj_len
+        *              =3D 16 + obj_len
+        *
+        * obj_len is known from KEY_NEW or KEY_FIND.  If req.len is
+        * too small, the eSW rejects the command and we return -EIO.
+        */
+       dmabuf =3D kzalloc(req.len, GFP_KERNEL);
+       if (!dmabuf)
+               return -ENOMEM;
+
+       dma_addr =3D cmh_dma_map_single(dmabuf, req.len, DMA_FROM_DEVICE);
+       if (cmh_dma_map_error(dma_addr)) {
+               kfree(dmabuf);
+               return -ENOMEM;
+       }
+
+       vcq_set_header(&vcq[0], MGMT_VCQ_CMDS);
+       vcq_add_sys_export(&vcq[1], req.cid, dma_addr, req.wrap_key, req.le=
n);
+       vcq_add_sys_flush(&vcq[2]);
+
+       ret =3D cmh_tm_submit_sync_mbx(vcq, MGMT_VCQ_CMDS, 1, MGMT_MBX);
+
+       cmh_dma_unmap_single(dma_addr, req.len, DMA_FROM_DEVICE);
+
+       if (ret) {
+               kfree_sensitive(dmabuf);
+               return ret;
+       }
+
+       /* Parse actual blob size from the eSW-written header */
+       {
+               struct sys_wrap_hdr *hdr =3D (struct sys_wrap_hdr *)dmabuf;
+               u64 actual;
+
+               if (check_add_overflow((u64)sizeof(*hdr), (u64)hdr->wrap,
+                                      &actual) ||
+                   check_add_overflow(actual, (u64)hdr->len, &actual) ||
+                   actual > req.len) {
+                       kfree_sensitive(dmabuf);
+                       return -EIO;
+               }
+               req.out_len =3D (u32)actual;
+       }
+
+       if (copy_to_user(u64_to_user_ptr(req.data),
+                        dmabuf, req.out_len)) {
+               kfree_sensitive(dmabuf);
+               return -EFAULT;
+       }
+
+       kfree_sensitive(dmabuf);
+
+       if (copy_to_user(argp, &req, sizeof(req)))
+               return -EFAULT;
+
+       dev_dbg(cmh_dev(), "mgmt: DS_EXPORT wrap_key=3D0x%llx len=3D%u\n",
+               req.wrap_key, req.out_len);
+       return 0;
+}
+
+/* -- DS_IMPORT ------------------------- */
+
+static int cmh_mgmt_ds_import(void __user *argp)
+{
+       struct cmh_ioctl_ds_import req;
+       struct vcq_cmd vcq[MGMT_VCQ_CMDS];
+       void *dmabuf;
+       dma_addr_t dma_addr;
+       int ret;
+
+       if (copy_from_user(&req, argp, sizeof(req)))
+               return -EFAULT;
+
+       if (req.version !=3D CMH_MGMT_V1)
+               return -EINVAL;
+       if (!req.len || req.len > CMH_MGMT_MAX_DATA_LEN)
+               return -EINVAL;
+
+       dmabuf =3D kmalloc(req.len, GFP_KERNEL);
+       if (!dmabuf)
+               return -ENOMEM;
+
+       if (copy_from_user(dmabuf, u64_to_user_ptr(req.data),
+                          req.len)) {
+               kfree_sensitive(dmabuf);
+               return -EFAULT;
+       }
+
+       dma_addr =3D cmh_dma_map_single(dmabuf, req.len, DMA_TO_DEVICE);
+       if (cmh_dma_map_error(dma_addr)) {
+               kfree_sensitive(dmabuf);
+               return -ENOMEM;
+       }
+
+       vcq_set_header(&vcq[0], MGMT_VCQ_CMDS);
+       vcq_add_sys_import(&vcq[1], dma_addr, req.wrap_key, req.len);
+       vcq_add_sys_flush(&vcq[2]);
+
+       ret =3D cmh_tm_submit_sync_mbx(vcq, MGMT_VCQ_CMDS, 1, MGMT_MBX);
+
+       cmh_dma_unmap_single(dma_addr, req.len, DMA_TO_DEVICE);
+       kfree_sensitive(dmabuf);
+
+       if (ret)
+               return ret;
+
+       dev_dbg(cmh_dev(), "mgmt: DS_IMPORT wrap_key=3D0x%llx len=3D%u\n",
+               req.wrap_key, req.len);
+       return 0;
+}
+
+/* -- KIC key derivation ioctls --------
+ *
+ * All four KIC derivation handlers (HKDF1, HKDF2, AES-CMAC-KDF,
+ * DKEK-derive) share the same two-mode structure and temp-flush pattern.
+ *
+ * Temp-storage flush rationale:
+ *
+ *   The device maintains a small per-mailbox temporary key store
+ *   (~960 bytes, LIFO).  A derivation targeting SYS_REF_TEMP allocates
+ *   from this store; the allocation persists across command-queue
+ *   boundaries until either (a) a subsequent command consumes it or
+ *   (b) a mailbox flush resets the store.
+ *
+ *   Our single-derivation ioctls produce a temp key with no consumer
+ *   in the same queue -- the key is consumed by a *later* ioctl
+ *   (e.g. DS_EXPORT with wrap_key=3DSYS_REF_TEMP).  If no consumer
+ *   follows, the allocation persists.  Sequential temp derivations
+ *   accumulate allocations until the store is exhausted (3--8 calls
+ *   depending on key size), after which the device returns ENOMEM.
+ *
+ *   A mailbox flush (cmh_tm_flush_mbx / MBX_COMMAND_FLUSH) resets the
+ *   temp store.  It does NOT destroy persistent keys, datastore
+ *   objects, or DRBG state -- only the command queue and temp store.
+ *
+ *   Safe for cross-ioctl temp flows (e.g. export-to-file:
+ *   HKDF1->TEMP in ioctl 1, then DS_EXPORT with wrap_key=3DTEMP in
+ *   ioctl 2): the flush only happens in derivation handlers and in
+ *   the pre-PKE dispatch path, not in DS_EXPORT/DS_IMPORT, so the
+ *   temp key survives until consumed.
+ *
+ * The ioctl dispatch also flushes before PKE/SM2/PQC ioctls to
+ * protect them from temp residue left by earlier derivations on the
+ * same mailbox.  The per-handler flushes here remain necessary
+ * because sequential temp derivations (without an intervening
+ * PKE/SM2/PQC ioctl) would still exhaust the store.
+ */
+
+/* -- KIC_HKDF1 ------------------------- */
+
+/*
+ * Derive a key from a KIC base key via one-step HKDF.
+ *
+ * Two modes controlled by CMH_KIC_FLAG_TEMP:
+ *
+ *   TEMP (flag set) -- 3-command VCQ:
+ *     [0] SYS header
+ *     [1] KIC_CMD_HKDF1 (dst=3DSYS_REF_TEMP)
+ *     [2] flush
+ *   Returns SYS_REF_TEMP as ref.  No DS entry created.
+ *
+ *   Persistent (flag clear) -- 4-command VCQ:
+ *     [0] SYS header
+ *     [1] SYS_CMD_NEW   (allocate DS slot, CMH eSW writes ref)
+ *     [2] KIC_CMD_HKDF1 (dst=3DSYS_REF_LAST =3D just-allocated slot)
+ *     [3] flush
+ *   Returns the new DS reference.
+ */
+#define KDF_VCQ_MAX            4
+#define KDF_MAX_KEY_LEN                64
+#define KDF_MAX_LABEL_LEN      56
+
+static int cmh_mgmt_kic_hkdf1(void __user *argp)
+{
+       struct cmh_ioctl_kic_hkdf1 req;
+       struct vcq_cmd vcq[KDF_VCQ_MAX];
+       bool temp;
+       u64 *ref_buf =3D NULL;
+       void *label_buf =3D NULL;
+       dma_addr_t ref_dma =3D DMA_MAPPING_ERROR, label_dma =3D DMA_MAPPING=
_ERROR;
+       unsigned int n_cmds;
+       int ret;
+
+       if (copy_from_user(&req, argp, sizeof(req)))
+               return -EFAULT;
+
+       if (req.version !=3D CMH_MGMT_V1)
+               return -EINVAL;
+       if (!req.key_len || req.key_len > KDF_MAX_KEY_LEN)
+               return -EINVAL;
+       if (req.label_len > KDF_MAX_LABEL_LEN)
+               return -EINVAL;
+
+       temp =3D !!(req.flags & CMH_KIC_FLAG_TEMP);
+
+       /*
+        * Persistent path: need DMA buffer for CMH eSW to write the
+        * newly-allocated DS reference.
+        */
+       if (!temp) {
+               ref_buf =3D kmalloc_obj(*ref_buf, GFP_KERNEL);
+               if (!ref_buf)
+                       return -ENOMEM;
+               *ref_buf =3D 0;
+               ref_dma =3D cmh_dma_map_single(ref_buf, sizeof(*ref_buf),
+                                            DMA_FROM_DEVICE);
+               if (cmh_dma_map_error(ref_dma)) {
+                       kfree(ref_buf);
+                       return -ENOMEM;
+               }
+       }
+
+       /* DMA buffer for label data (CMH eSW DMA-reads it) */
+       if (req.label_len > 0) {
+               label_buf =3D kzalloc(req.label_len, GFP_KERNEL);
+               if (!label_buf) {
+                       ret =3D -ENOMEM;
+                       goto out_ref;
+               }
+               if (copy_from_user(label_buf,
+                                  u64_to_user_ptr(req.label),
+                                  req.label_len)) {
+                       ret =3D -EFAULT;
+                       goto out_label;
+               }
+               label_dma =3D cmh_dma_map_single(label_buf, req.label_len,
+                                              DMA_TO_DEVICE);
+               if (cmh_dma_map_error(label_dma)) {
+                       ret =3D -ENOMEM;
+                       goto out_label;
+               }
+       }
+
+       /* Build VCQ */
+       memset(vcq, 0, sizeof(vcq));
+
+       if (temp) {
+               /* Flush MBX to reset temp stack -- see KIC section comment=
 */
+               ret =3D cmh_tm_flush_mbx(MGMT_MBX);
+               if (ret)
+                       goto out_unmap_label;
+
+               n_cmds =3D 3;
+               vcq_set_header(&vcq[0], n_cmds);
+               vcq_add_kic_hkdf1(&vcq[1], SYS_REF_TEMP, req.base_key,
+                                 label_dma, req.key_len, req.label_len,
+                                  SYS_TYPE_SET(0, CORE_ID_AES));
+               vcq_add_sys_flush(&vcq[2]);
+       } else {
+               n_cmds =3D 4;
+               vcq_set_header(&vcq[0], n_cmds);
+               vcq_add_sys_new(&vcq[1], req.cid, ref_dma, req.key_len);
+               vcq_add_kic_hkdf1(&vcq[2], SYS_REF_LAST, req.base_key,
+                                 label_dma, req.key_len, req.label_len,
+                                  SYS_TYPE_SET(0, CORE_ID_AES));
+               vcq_add_sys_flush(&vcq[3]);
+       }
+
+       ret =3D cmh_tm_submit_sync_mbx(vcq, n_cmds, 1, MGMT_MBX);
+
+       /* Cleanup label DMA */
+       if (label_buf) {
+               cmh_dma_unmap_single(label_dma, req.label_len, DMA_TO_DEVIC=
E);
+               kfree(label_buf);
+               label_buf =3D NULL;
+       }
+
+       if (ret)
+               goto out_ref;
+
+       if (temp) {
+               req.ref =3D SYS_REF_TEMP;
+               atomic_set(&mgmt_temp_dirty, 1);
+       } else {
+               cmh_dma_unmap_single(ref_dma, sizeof(*ref_buf),
+                                    DMA_FROM_DEVICE);
+               req.ref =3D *ref_buf;
+               kfree(ref_buf);
+               ref_buf =3D NULL;
+       }
+
+       if (copy_to_user(argp, &req, sizeof(req)))
+               return -EFAULT;
+
+       dev_dbg(cmh_dev(),
+               "mgmt: KIC_HKDF1 base=3D0x%llx len=3D%u flags=3D0x%x -> ref=
=3D0x%llx\n",
+               req.base_key, req.key_len, req.flags, req.ref);
+       return 0;
+
+out_unmap_label:
+       if (label_buf && !cmh_dma_map_error(label_dma) && label_dma)
+               cmh_dma_unmap_single(label_dma, req.label_len, DMA_TO_DEVIC=
E);
+out_label:
+       kfree(label_buf);
+out_ref:
+       if (ref_buf) {
+               cmh_dma_unmap_single(ref_dma, sizeof(*ref_buf),
+                                    DMA_FROM_DEVICE);
+               kfree(ref_buf);
+       }
+       return ret;
+}
+
+/* -- KIC_HKDF2 ------------------------- */
+
+/*
+ * Two-step HKDF key derivation.  Same as HKDF1 but adds a salt key
+ * reference: Step 1: HMAC(salt, base) -> PRK; Step 2: HMAC(PRK, label) ->=
 key.
+ */
+
+static int cmh_mgmt_kic_hkdf2(void __user *argp)
+{
+       struct cmh_ioctl_kic_hkdf2 req;
+       struct vcq_cmd vcq[KDF_VCQ_MAX];
+       bool temp;
+       u64 *ref_buf =3D NULL;
+       void *label_buf =3D NULL;
+       dma_addr_t ref_dma =3D DMA_MAPPING_ERROR, label_dma =3D DMA_MAPPING=
_ERROR;
+       unsigned int n_cmds;
+       int ret;
+
+       if (copy_from_user(&req, argp, sizeof(req)))
+               return -EFAULT;
+
+       if (req.version !=3D CMH_MGMT_V1)
+               return -EINVAL;
+       if (!req.key_len || req.key_len > KDF_MAX_KEY_LEN)
+               return -EINVAL;
+       if (req.label_len > KDF_MAX_LABEL_LEN)
+               return -EINVAL;
+
+       temp =3D !!(req.flags & CMH_KIC_FLAG_TEMP);
+
+       if (!temp) {
+               ref_buf =3D kmalloc_obj(*ref_buf, GFP_KERNEL);
+               if (!ref_buf)
+                       return -ENOMEM;
+               *ref_buf =3D 0;
+               ref_dma =3D cmh_dma_map_single(ref_buf, sizeof(*ref_buf),
+                                            DMA_FROM_DEVICE);
+               if (cmh_dma_map_error(ref_dma)) {
+                       kfree(ref_buf);
+                       return -ENOMEM;
+               }
+       }
+
+       if (req.label_len > 0) {
+               label_buf =3D kzalloc(req.label_len, GFP_KERNEL);
+               if (!label_buf) {
+                       ret =3D -ENOMEM;
+                       goto out_ref2;
+               }
+               if (copy_from_user(label_buf,
+                                  u64_to_user_ptr(req.label),
+                                  req.label_len)) {
+                       ret =3D -EFAULT;
+                       goto out_label2;
+               }
+               label_dma =3D cmh_dma_map_single(label_buf, req.label_len,
+                                              DMA_TO_DEVICE);
+               if (cmh_dma_map_error(label_dma)) {
+                       ret =3D -ENOMEM;
+                       goto out_label2;
+               }
+       }
+
+       memset(vcq, 0, sizeof(vcq));
+
+       if (temp) {
+               /* Flush MBX to reset temp stack -- see KIC section comment=
 */
+               ret =3D cmh_tm_flush_mbx(MGMT_MBX);
+               if (ret)
+                       goto out_unmap_label2;
+
+               n_cmds =3D 3;
+               vcq_set_header(&vcq[0], n_cmds);
+               vcq_add_kic_hkdf2(&vcq[1], SYS_REF_TEMP, req.base_key,
+                                 req.salt_key, label_dma,
+                                  req.key_len, req.label_len,
+                                  SYS_TYPE_SET(0, CORE_ID_AES));
+               vcq_add_sys_flush(&vcq[2]);
+       } else {
+               n_cmds =3D 4;
+               vcq_set_header(&vcq[0], n_cmds);
+               vcq_add_sys_new(&vcq[1], req.cid, ref_dma, req.key_len);
+               vcq_add_kic_hkdf2(&vcq[2], SYS_REF_LAST, req.base_key,
+                                 req.salt_key, label_dma,
+                                  req.key_len, req.label_len,
+                                  SYS_TYPE_SET(0, CORE_ID_AES));
+               vcq_add_sys_flush(&vcq[3]);
+       }
+
+       ret =3D cmh_tm_submit_sync_mbx(vcq, n_cmds, 1, MGMT_MBX);
+
+       if (label_buf) {
+               cmh_dma_unmap_single(label_dma, req.label_len, DMA_TO_DEVIC=
E);
+               kfree(label_buf);
+               label_buf =3D NULL;
+       }
+
+       if (ret)
+               goto out_ref2;
+
+       if (temp) {
+               req.ref =3D SYS_REF_TEMP;
+               atomic_set(&mgmt_temp_dirty, 1);
+       } else {
+               cmh_dma_unmap_single(ref_dma, sizeof(*ref_buf),
+                                    DMA_FROM_DEVICE);
+               req.ref =3D *ref_buf;
+               kfree(ref_buf);
+               ref_buf =3D NULL;
+       }
+
+       if (copy_to_user(argp, &req, sizeof(req)))
+               return -EFAULT;
+
+       dev_dbg(cmh_dev(),
+               "mgmt: KIC_HKDF2 base=3D0x%llx salt=3D0x%llx len=3D%u flags=
=3D0x%x -> ref=3D0x%llx\n",
+               req.base_key, req.salt_key, req.key_len, req.flags, req.ref=
);
+       return 0;
+
+out_unmap_label2:
+       if (label_buf && !cmh_dma_map_error(label_dma) && label_dma)
+               cmh_dma_unmap_single(label_dma, req.label_len, DMA_TO_DEVIC=
E);
+out_label2:
+       kfree(label_buf);
+out_ref2:
+       if (ref_buf) {
+               cmh_dma_unmap_single(ref_dma, sizeof(*ref_buf),
+                                    DMA_FROM_DEVICE);
+               kfree(ref_buf);
+       }
+       return ret;
+}
+
+/* -- KIC_AES_CMAC_KDF ------------------ */
+
+/*
+ * Derive a key using AES-CMAC-based KDF (NIST SP800-108 style).
+ * Base key must be 32 bytes.  Output is always non-PT (the hub driver
+ * rejects SYS_TYPE_FLAG_PT).
+ *
+ * VCQ layout matches HKDF: TEMP mode uses 3 commands, persistent uses 4.
+ */
+#define CMAC_KDF_KEY_LEN       32
+
+static int cmh_mgmt_kic_aes_cmac_kdf(void __user *argp)
+{
+       struct cmh_ioctl_kic_aes_cmac_kdf req;
+       struct vcq_cmd vcq[KDF_VCQ_MAX];
+       bool temp;
+       u64 *ref_buf =3D NULL;
+       void *label_buf =3D NULL;
+       dma_addr_t ref_dma =3D DMA_MAPPING_ERROR, label_dma =3D DMA_MAPPING=
_ERROR;
+       unsigned int n_cmds;
+       int ret;
+
+       if (copy_from_user(&req, argp, sizeof(req)))
+               return -EFAULT;
+
+       if (req.version !=3D CMH_MGMT_V1)
+               return -EINVAL;
+       if (req.key_len !=3D CMAC_KDF_KEY_LEN)
+               return -EINVAL;
+       if (req.label_len > KDF_MAX_LABEL_LEN)
+               return -EINVAL;
+
+       temp =3D !!(req.flags & CMH_KIC_FLAG_TEMP);
+
+       if (!temp) {
+               ref_buf =3D kmalloc_obj(*ref_buf, GFP_KERNEL);
+               if (!ref_buf)
+                       return -ENOMEM;
+               *ref_buf =3D 0;
+               ref_dma =3D cmh_dma_map_single(ref_buf, sizeof(*ref_buf),
+                                            DMA_FROM_DEVICE);
+               if (cmh_dma_map_error(ref_dma)) {
+                       kfree(ref_buf);
+                       return -ENOMEM;
+               }
+       }
+
+       if (req.label_len > 0) {
+               label_buf =3D kzalloc(req.label_len, GFP_KERNEL);
+               if (!label_buf) {
+                       ret =3D -ENOMEM;
+                       goto out_ref_cmac;
+               }
+               if (copy_from_user(label_buf,
+                                  u64_to_user_ptr(req.label),
+                                  req.label_len)) {
+                       ret =3D -EFAULT;
+                       goto out_label_cmac;
+               }
+               label_dma =3D cmh_dma_map_single(label_buf, req.label_len,
+                                              DMA_TO_DEVICE);
+               if (cmh_dma_map_error(label_dma)) {
+                       ret =3D -ENOMEM;
+                       goto out_label_cmac;
+               }
+       }
+
+       memset(vcq, 0, sizeof(vcq));
+
+       if (temp) {
+               /* Flush MBX to reset temp stack -- see KIC section comment=
 */
+               ret =3D cmh_tm_flush_mbx(MGMT_MBX);
+               if (ret)
+                       goto out_unmap_label_cmac;
+
+               n_cmds =3D 3;
+               vcq_set_header(&vcq[0], n_cmds);
+               vcq_add_kic_aes_cmac_kdf(&vcq[1], SYS_REF_TEMP,
+                                        req.base_key, label_dma,
+                                        req.key_len, req.label_len,
+                                        SYS_TYPE_SET(0, CORE_ID_AES));
+               vcq_add_sys_flush(&vcq[2]);
+       } else {
+               n_cmds =3D 4;
+               vcq_set_header(&vcq[0], n_cmds);
+               vcq_add_sys_new(&vcq[1], req.cid, ref_dma, req.key_len);
+               vcq_add_kic_aes_cmac_kdf(&vcq[2], SYS_REF_LAST,
+                                        req.base_key, label_dma,
+                                        req.key_len, req.label_len,
+                                        SYS_TYPE_SET(0, CORE_ID_AES));
+               vcq_add_sys_flush(&vcq[3]);
+       }
+
+       ret =3D cmh_tm_submit_sync_mbx(vcq, n_cmds, 1, MGMT_MBX);
+
+       if (label_buf) {
+               cmh_dma_unmap_single(label_dma, req.label_len, DMA_TO_DEVIC=
E);
+               kfree(label_buf);
+               label_buf =3D NULL;
+       }
+
+       if (ret)
+               goto out_ref_cmac;
+
+       if (temp) {
+               req.ref =3D SYS_REF_TEMP;
+               atomic_set(&mgmt_temp_dirty, 1);
+       } else {
+               cmh_dma_unmap_single(ref_dma, sizeof(*ref_buf),
+                                    DMA_FROM_DEVICE);
+               req.ref =3D *ref_buf;
+               kfree(ref_buf);
+               ref_buf =3D NULL;
+       }
+
+       if (copy_to_user(argp, &req, sizeof(req)))
+               return -EFAULT;
+
+       dev_dbg(cmh_dev(),
+               "mgmt: KIC_AES_CMAC_KDF base=3D0x%llx len=3D%u flags=3D0x%x=
 -> ref=3D0x%llx\n",
+               req.base_key, req.key_len, req.flags, req.ref);
+       return 0;
+
+out_unmap_label_cmac:
+       if (label_buf && !cmh_dma_map_error(label_dma) && label_dma)
+               cmh_dma_unmap_single(label_dma, req.label_len, DMA_TO_DEVIC=
E);
+out_label_cmac:
+       kfree(label_buf);
+out_ref_cmac:
+       if (ref_buf) {
+               cmh_dma_unmap_single(ref_dma, sizeof(*ref_buf),
+                                    DMA_FROM_DEVICE);
+               kfree(ref_buf);
+       }
+       return ret;
+}
+
+/* -- KIC_DKEK_DERIVE ------------------- */
+
+/*
+ * Derive a Key Encryption Key (KEK) from a KIC base key.
+ * Output is tagged CORE_ID_KIC (usable for further derivation only).
+ * host_id=3D0 means the caller's own host; non-zero requires management
+ * host privilege (eSW enforces this).
+ */
+#define DKEK_VCQ_MAX           4
+
+static int cmh_mgmt_kic_dkek_derive(void __user *argp)
+{
+       struct cmh_ioctl_kic_dkek_derive req;
+       struct vcq_cmd vcq[DKEK_VCQ_MAX];
+       bool temp;
+       u64 *ref_buf =3D NULL;
+       void *meta_buf =3D NULL;
+       dma_addr_t ref_dma =3D DMA_MAPPING_ERROR, meta_dma =3D DMA_MAPPING_=
ERROR;
+       unsigned int n_cmds;
+       int ret;
+
+       if (copy_from_user(&req, argp, sizeof(req)))
+               return -EFAULT;
+
+       if (req.version !=3D CMH_MGMT_V1)
+               return -EINVAL;
+       if (req.metadata_len > KIC_DKEK_MAX_METADATA)
+               return -EINVAL;
+
+       temp =3D !!(req.flags & CMH_KIC_FLAG_TEMP);
+
+       if (!temp) {
+               ref_buf =3D kmalloc_obj(*ref_buf, GFP_KERNEL);
+               if (!ref_buf)
+                       return -ENOMEM;
+               *ref_buf =3D 0;
+               ref_dma =3D cmh_dma_map_single(ref_buf, sizeof(*ref_buf),
+                                            DMA_FROM_DEVICE);
+               if (cmh_dma_map_error(ref_dma)) {
+                       kfree(ref_buf);
+                       return -ENOMEM;
+               }
+       }
+
+       if (req.metadata_len > 0) {
+               meta_buf =3D kzalloc(req.metadata_len, GFP_KERNEL);
+               if (!meta_buf) {
+                       ret =3D -ENOMEM;
+                       goto out_ref_dkek;
+               }
+               if (copy_from_user(meta_buf,
+                                  u64_to_user_ptr(req.metadata),
+                                  req.metadata_len)) {
+                       ret =3D -EFAULT;
+                       goto out_meta;
+               }
+               meta_dma =3D cmh_dma_map_single(meta_buf, req.metadata_len,
+                                             DMA_TO_DEVICE);
+               if (cmh_dma_map_error(meta_dma)) {
+                       ret =3D -ENOMEM;
+                       goto out_meta;
+               }
+       }
+
+       memset(vcq, 0, sizeof(vcq));
+
+       if (temp) {
+               /* Flush MBX to reset temp stack -- see KIC section comment=
 */
+               ret =3D cmh_tm_flush_mbx(MGMT_MBX);
+               if (ret)
+                       goto out_unmap_meta;
+
+               n_cmds =3D 3;
+               vcq_set_header(&vcq[0], n_cmds);
+               vcq_add_kic_dkek_derive(&vcq[1], SYS_REF_TEMP,
+                                       req.base_key, req.host_id,
+                                       meta_dma, req.metadata_len);
+               vcq_add_sys_flush(&vcq[2]);
+       } else {
+               n_cmds =3D 4;
+               vcq_set_header(&vcq[0], n_cmds);
+               vcq_add_sys_new(&vcq[1], req.cid, ref_dma, KIC_KEY_SIZE);
+               vcq_add_kic_dkek_derive(&vcq[2], SYS_REF_LAST,
+                                       req.base_key, req.host_id,
+                                       meta_dma, req.metadata_len);
+               vcq_add_sys_flush(&vcq[3]);
+       }
+
+       ret =3D cmh_tm_submit_sync_mbx(vcq, n_cmds, 1, MGMT_MBX);
+
+       if (meta_buf) {
+               cmh_dma_unmap_single(meta_dma, req.metadata_len,
+                                    DMA_TO_DEVICE);
+               kfree(meta_buf);
+               meta_buf =3D NULL;
+       }
+
+       if (ret)
+               goto out_ref_dkek;
+
+       if (temp) {
+               req.ref =3D SYS_REF_TEMP;
+               atomic_set(&mgmt_temp_dirty, 1);
+       } else {
+               cmh_dma_unmap_single(ref_dma, sizeof(*ref_buf),
+                                    DMA_FROM_DEVICE);
+               req.ref =3D *ref_buf;
+               kfree(ref_buf);
+               ref_buf =3D NULL;
+       }
+
+       if (copy_to_user(argp, &req, sizeof(req)))
+               return -EFAULT;
+
+       dev_dbg(cmh_dev(),
+               "mgmt: KIC_DKEK_DERIVE base=3D0x%llx host=3D%u meta_len=3D%=
u flags=3D0x%x -> ref=3D0x%llx\n",
+               req.base_key, req.host_id, req.metadata_len, req.flags,
+               req.ref);
+       return 0;
+
+out_unmap_meta:
+       if (meta_buf && !cmh_dma_map_error(meta_dma) && meta_dma)
+               cmh_dma_unmap_single(meta_dma, req.metadata_len, DMA_TO_DEV=
ICE);
+out_meta:
+       kfree(meta_buf);
+out_ref_dkek:
+       if (ref_buf) {
+               cmh_dma_unmap_single(ref_dma, sizeof(*ref_buf),
+                                    DMA_FROM_DEVICE);
+               kfree(ref_buf);
+       }
+       return ret;
+}
+
+/* -- KEY_NEW_RANDOM -- DRBG-backed key generation --- */
+
+/*
+ * Allocate a new datastore slot and fill it with DRBG-generated
+ * random key material in a single atomic VCQ submission:
+ *
+ *   [0] SYS header(5)
+ *   [1] SYS_CMD_NEW   -- allocate DS slot (CMH eSW writes ref)
+ *   [2] DRBG_CMD_DATASTORE(SYS_REF_LAST) -- fill with random data
+ *   [3] DRBG flush -- release DRBG core ownership
+ *   [4] SYS flush
+ *
+ * The DRBG must be configured before this ioctl is used.
+ * Reuses struct cmh_ioctl_key_new (ds_type, flags, cid, len, ref).
+ */
+#define DRBG_KEYGEN_VCQ_CMDS   5
+
+static int cmh_mgmt_key_new_random(void __user *argp)
+{
+       struct cmh_ioctl_key_new req;
+       struct vcq_cmd vcq[DRBG_KEYGEN_VCQ_CMDS];
+       u64 *ref_buf;
+       dma_addr_t ref_dma;
+       u32 core_id, sys_type;
+       int ret;
+
+       if (copy_from_user(&req, argp, sizeof(req)))
+               return -EFAULT;
+
+       if (req.version !=3D CMH_MGMT_V1)
+               return -EINVAL;
+       if (!req.len)
+               return -EINVAL;
+
+       core_id =3D cmh_ds_type_to_core_id(req.ds_type);
+       if (core_id =3D=3D CORE_ID_NUM)
+               return -EINVAL;
+       sys_type =3D SYS_TYPE_SET(req.flags, core_id);
+
+       ref_buf =3D kmalloc_obj(*ref_buf, GFP_KERNEL);
+       if (!ref_buf)
+               return -ENOMEM;
+
+       *ref_buf =3D 0;
+       ref_dma =3D cmh_dma_map_single(ref_buf, sizeof(*ref_buf),
+                                    DMA_FROM_DEVICE);
+       if (cmh_dma_map_error(ref_dma)) {
+               kfree(ref_buf);
+               return -ENOMEM;
+       }
+
+       vcq_set_header(&vcq[0], DRBG_KEYGEN_VCQ_CMDS);
+       vcq_add_sys_new(&vcq[1], req.cid, ref_dma, req.len);
+       vcq_add_drbg_datastore(&vcq[2], SYS_REF_LAST, req.len, sys_type);
+       vcq_add_flush(&vcq[3], CORE_ID_DRBG);
+       vcq_add_sys_flush(&vcq[4]);
+
+       ret =3D cmh_tm_submit_sync_mbx(vcq, DRBG_KEYGEN_VCQ_CMDS, 1, MGMT_M=
BX);
+
+       cmh_dma_unmap_single(ref_dma, sizeof(*ref_buf), DMA_FROM_DEVICE);
+
+       if (ret) {
+               kfree(ref_buf);
+               return ret;
+       }
+
+       req.ref =3D *ref_buf;
+       kfree(ref_buf);
+
+       if (copy_to_user(argp, &req, sizeof(req)))
+               return -EFAULT;
+
+       dev_dbg(cmh_dev(),
+               "mgmt: KEY_NEW_RANDOM cid=3D0x%llx len=3D%u type=3D0x%x -> =
ref=3D0x%llx\n",
+               req.cid, req.len, sys_type, req.ref);
+       return 0;
+}
+
+#define EAC_VCQ_CMDS           3       /* header + EAC_READ + flush */
+
+static long cmh_mgmt_eac_read(void __user *argp)
+{
+       struct cmh_ioctl_eac_read req;
+       struct eac_read_rsp *rsp;
+       struct vcq_cmd vcq[EAC_VCQ_CMDS];
+       dma_addr_t rsp_dma;
+       int ret;
+
+       if (copy_from_user(&req, argp, sizeof(req)))
+               return -EFAULT;
+       if (req.version !=3D CMH_MGMT_V1)
+               return -EINVAL;
+       if (req.__reserved !=3D 0)
+               return -EINVAL;
+       if (req.__pad !=3D 0)
+               return -EINVAL;
+
+       rsp =3D kmalloc_obj(*rsp, GFP_KERNEL);
+       if (!rsp)
+               return -ENOMEM;
+
+       rsp_dma =3D cmh_dma_map_single(rsp, sizeof(*rsp), DMA_FROM_DEVICE);
+       if (cmh_dma_map_error(rsp_dma)) {
+               kfree(rsp);
+               return -ENOMEM;
+       }
+
+       vcq_set_header(&vcq[0], EAC_VCQ_CMDS);
+       vcq_add_eac_read(&vcq[1], rsp_dma, sizeof(*rsp));
+       vcq_add_flush(&vcq[2], CORE_ID_EAC);
+
+       ret =3D cmh_tm_submit_sync_mbx(vcq, EAC_VCQ_CMDS, 1, MGMT_MBX);
+
+       cmh_dma_unmap_single(rsp_dma, sizeof(*rsp), DMA_FROM_DEVICE);
+
+       if (ret) {
+               kfree(rsp);
+               return ret;
+       }
+
+       /* Copy response fields into ioctl struct */
+       req.mailbox_notification =3D rsp->mailbox_notification;
+       req.hw_error =3D rsp->hw_error;
+       req.hw_nmi =3D rsp->hw_nmi;
+       req.hw_panic =3D rsp->hw_panic;
+       req.safety_fatal =3D rsp->safety_fatal;
+       req.safety_notification =3D rsp->safety_notification;
+       req.sw_info0 =3D rsp->sw_info0;
+       req.sw_info1 =3D rsp->sw_info1;
+       memcpy(req.sram_bank_errors, rsp->sram_bank_errors,
+              sizeof(req.sram_bank_errors));
+       req.__pad =3D 0;
+
+       kfree(rsp);
+
+       if (copy_to_user(argp, &req, sizeof(req)))
+               return -EFAULT;
+
+       return 0;
+}
+
+/* -- DRBG CONFIG (management) ------------ */
+
+#define DRBG_CONFIG_VCQ_CMDS   4       /* header + RESET + CONFIG + flush =
*/
+
+static long cmh_mgmt_drbg_config(void __user *argp)
+{
+       struct cmh_ioctl_drbg_config req;
+       struct vcq_cmd vcq[DRBG_CONFIG_VCQ_CMDS];
+       int ret;
+
+       if (copy_from_user(&req, argp, sizeof(req)))
+               return -EFAULT;
+       if (req.version !=3D CMH_MGMT_V1)
+               return -EINVAL;
+       if (req.__reserved !=3D 0)
+               return -EINVAL;
+       if (req.entropy_ratio > 3)
+               return -EINVAL;
+       if (req.security_strength !=3D CMH_DRBG_STRENGTH_128 &&
+           req.security_strength !=3D CMH_DRBG_STRENGTH_256)
+               return -EINVAL;
+
+       vcq_set_header(&vcq[0], DRBG_CONFIG_VCQ_CMDS);
+       vcq_add_drbg_reset(&vcq[1]);
+       vcq_add_drbg_config(&vcq[2], req.entropy_ratio,
+                           req.security_strength);
+       vcq_add_flush(&vcq[3], CORE_ID_DRBG);
+
+       ret =3D cmh_tm_submit_sync_mbx(vcq, DRBG_CONFIG_VCQ_CMDS, 1, MGMT_M=
BX);
+       if (ret)
+               dev_warn(cmh_dev(), "mgmt: DRBG CONFIG failed (rc=3D%d)\n",=
 ret);
+       else
+               dev_info(cmh_dev(), "mgmt: DRBG configured (ratio=3D%u stre=
ngth=3D0x%x)\n",
+                        req.entropy_ratio, req.security_strength);
+
+       return ret;
+}
+
+/* -- ioctl dispatch ------------------------ */
+
+/*
+ * PKE, SM2, and PQC ioctls use device-internal temporary storage for
+ * intermediate results.  Residual allocations in the per-mailbox temp
+ * store (left by prior operations that targeted SYS_REF_TEMP) reduce
+ * the space available and can cause the device to return ENOMEM.
+ *
+ * Flush the mailbox before these operations to reset the temp store,
+ * but ONLY when the store is actually dirty (mgmt_temp_dirty flag).
+ * Unconditional flushing would kill in-flight command queues from
+ * concurrent callers on the same mailbox -- MBX_COMMAND_FLUSH
+ * terminates any executing queue with -EPIPE and discards all queued
+ * submissions.
+ *
+ * The conditional flush is safe: PKE/SM2/PQC ioctls do not consume
+ * SYS_REF_TEMP from a prior ioctl (unlike DS_EXPORT/DS_IMPORT which
+ * may reference a temp key produced by a preceding derivation), so
+ * clearing the temp store before them loses no needed state.
+ */
+static inline bool cmh_mgmt_needs_temp_flush(unsigned int cmd)
+{
+       unsigned int nr =3D _IOC_NR(cmd);
+
+       /*
+        * Range invariant: all PKE/SM2/PQC ioctls must have consecutive
+        * NR values between PKE_RSA_ENC (0x10) and SM2_ENC_HASH (0x37).
+        * If a new ioctl is added outside this range, update the bounds
+        * and adjust these assertions.
+        */
+       BUILD_BUG_ON(_IOC_NR(CMH_IOCTL_PKE_RSA_ENC) !=3D 0x10);
+       BUILD_BUG_ON(_IOC_NR(CMH_IOCTL_SM2_ENC_HASH) !=3D 0x37);
+
+       return nr >=3D _IOC_NR(CMH_IOCTL_PKE_RSA_ENC) &&
+              nr <=3D _IOC_NR(CMH_IOCTL_SM2_ENC_HASH);
+}
+
+static long cmh_mgmt_ioctl(struct file *file, unsigned int cmd,
+                          unsigned long arg)
+{
+       void __user *argp =3D (void __user *)arg;
+       int ret;
+
+       if (cmh_mgmt_needs_temp_flush(cmd) &&
+           atomic_xchg(&mgmt_temp_dirty, 0)) {
+               ret =3D cmh_tm_flush_mbx(MGMT_MBX);
+               if (ret)
+                       return ret;
+       }
+
+       switch (cmd) {
+       case CMH_IOCTL_KEY_NEW:
+               return cmh_mgmt_key_new(argp);
+       case CMH_IOCTL_KEY_WRITE:
+               return cmh_mgmt_key_write(argp);
+       case CMH_IOCTL_KEY_READ:
+               return cmh_mgmt_key_read(argp);
+       case CMH_IOCTL_KEY_FIND:
+               return cmh_mgmt_key_find(argp);
+       case CMH_IOCTL_KEY_GRANT:
+               return cmh_mgmt_key_grant(argp, false);
+       case CMH_IOCTL_KEY_DELETE:
+               return cmh_mgmt_key_grant(argp, true);
+       case CMH_IOCTL_DS_EXPORT:
+               return cmh_mgmt_ds_export(argp);
+       case CMH_IOCTL_DS_IMPORT:
+               return cmh_mgmt_ds_import(argp);
+       case CMH_IOCTL_KIC_HKDF1:
+               return cmh_mgmt_kic_hkdf1(argp);
+       case CMH_IOCTL_KIC_HKDF2:
+               return cmh_mgmt_kic_hkdf2(argp);
+       case CMH_IOCTL_KEY_NEW_RANDOM:
+               return cmh_mgmt_key_new_random(argp);
+       case CMH_IOCTL_KIC_AES_CMAC_KDF:
+               return cmh_mgmt_kic_aes_cmac_kdf(argp);
+       case CMH_IOCTL_KIC_DKEK_DERIVE:
+               return cmh_mgmt_kic_dkek_derive(argp);
+       case CMH_IOCTL_KEY_LIST:
+               return cmh_mgmt_key_list(argp);
+       case CMH_IOCTL_EAC_READ:
+               return cmh_mgmt_eac_read(argp);
+       /* PKE operations */
+       case CMH_IOCTL_PKE_RSA_ENC:
+               return cmh_mgmt_pke_rsa_enc(argp);
+       case CMH_IOCTL_PKE_RSA_DEC:
+               return cmh_mgmt_pke_rsa_dec(argp);
+       case CMH_IOCTL_PKE_RSA_CRT_DEC:
+               return cmh_mgmt_pke_rsa_crt_dec(argp);
+       case CMH_IOCTL_PKE_RSA_KEYGEN:
+               return cmh_mgmt_pke_rsa_keygen(argp);
+       case CMH_IOCTL_PKE_ECDSA_SIGN:
+               return cmh_mgmt_pke_ecdsa_sign(argp);
+       case CMH_IOCTL_PKE_ECDH:
+               return cmh_mgmt_pke_ecdh(argp);
+       case CMH_IOCTL_PKE_ECDH_KEYGEN:
+               return cmh_mgmt_pke_ecdh_keygen(argp);
+       case CMH_IOCTL_PKE_EDDSA_SIGN:
+               return cmh_mgmt_pke_eddsa_sign(argp);
+       case CMH_IOCTL_PKE_EDDSA_VERIFY:
+               return cmh_mgmt_pke_eddsa_verify(argp);
+       case CMH_IOCTL_PKE_EC_KEYGEN:
+               return cmh_mgmt_pke_ec_keygen(argp);
+       case CMH_IOCTL_PKE_EC_PUBGEN:
+               return cmh_mgmt_pke_ec_pubgen(argp);
+       case CMH_IOCTL_PKE_EDDSA_KEYGEN_SCA:
+               return cmh_mgmt_pke_eddsa_keygen_sca(argp);
+       /* SM2 operations */
+       case CMH_IOCTL_SM2_ECDH_KEYGEN:
+               return cmh_mgmt_sm2_ecdh_keygen(argp);
+       case CMH_IOCTL_SM2_ECDH:
+               return cmh_mgmt_sm2_ecdh(argp);
+       case CMH_IOCTL_SM2_DEC_POINT:
+               return cmh_mgmt_sm2_dec_point(argp);
+       case CMH_IOCTL_SM2_ENC_POINT:
+               return cmh_mgmt_sm2_enc_point(argp);
+       case CMH_IOCTL_SM2_ID_DIGEST:
+               return cmh_mgmt_sm2_id_digest(argp);
+       case CMH_IOCTL_SM2_ECDH_HASH:
+               return cmh_mgmt_sm2_ecdh_hash(argp);
+       case CMH_IOCTL_SM2_DEC_HASH:
+               return cmh_mgmt_sm2_dec_hash(argp);
+       case CMH_IOCTL_SM2_ENC_HASH:
+               return cmh_mgmt_sm2_enc_hash(argp);
+       /* PQC operations */
+       case CMH_IOCTL_ML_KEM_KEYGEN:
+               return cmh_mgmt_ml_kem_keygen(argp);
+       case CMH_IOCTL_ML_KEM_ENC:
+               return cmh_mgmt_ml_kem_enc(argp);
+       case CMH_IOCTL_ML_KEM_DEC:
+               return cmh_mgmt_ml_kem_dec(argp);
+       case CMH_IOCTL_ML_DSA_KEYGEN:
+               return cmh_mgmt_ml_dsa_keygen(argp);
+       case CMH_IOCTL_ML_DSA_SIGN:
+               return cmh_mgmt_ml_dsa_sign(argp);
+       case CMH_IOCTL_SLHDSA_KEYGEN:
+               return cmh_mgmt_slhdsa_keygen(argp);
+       case CMH_IOCTL_SLHDSA_SIGN:
+               return cmh_mgmt_slhdsa_sign(argp);
+       case CMH_IOCTL_SLHDSA_SIGN_PREHASH:
+               return cmh_mgmt_slhdsa_sign_prehash(argp);
+       /* DRBG management */
+       case CMH_IOCTL_DRBG_CONFIG:
+               return cmh_mgmt_drbg_config(argp);
+       default:
+               return -ENOTTY;
+       }
+}
+
+/* -- File operations ----------------------- */
+
+/*
+ * Capability is checked once at open time.  A privileged process may
+ * pass the resulting fd to an unprivileged helper -- this delegation
+ * model is intentional and mirrors /dev/kvm, /dev/loop-control, etc.
+ */
+static int cmh_mgmt_open(struct inode *inode, struct file *file)
+{
+       if (!capable(CAP_SYS_ADMIN))
+               return -EPERM;
+
+       return 0;
+}
+
+static const struct file_operations cmh_mgmt_fops =3D {
+       .owner          =3D THIS_MODULE,
+       .open           =3D cmh_mgmt_open,
+       .unlocked_ioctl =3D cmh_mgmt_ioctl,
+       .compat_ioctl   =3D compat_ptr_ioctl,
+};
+
+static struct miscdevice cmh_mgmt_dev =3D {
+       .minor =3D MISC_DYNAMIC_MINOR,
+       .name  =3D "cmh_mgmt",
+       .fops  =3D &cmh_mgmt_fops,
+       .mode  =3D 0660,
+};
+
+static bool cmh_mgmt_registered;
+
+/**
+ * cmh_mgmt_register() - Register the /dev/cmh_mgmt misc device
+ *
+ * Return: 0 on success, negative errno on failure.
+ */
+int cmh_mgmt_register(void)
+{
+       int ret;
+
+       /*
+        * ABI size guards -- catch silent layout changes at compile time.
+        * All ioctl structs use only __u32 and __u64 with explicit padding=
,
+        * guaranteeing identical layout on 32-bit and 64-bit (compat_ptr_i=
octl).
+        */
+       BUILD_BUG_ON(sizeof(struct cmh_ioctl_key_new) !=3D 32);
+       BUILD_BUG_ON(sizeof(struct cmh_ioctl_key_write) !=3D 40);
+       BUILD_BUG_ON(sizeof(struct cmh_ioctl_key_read) !=3D 40);
+       BUILD_BUG_ON(sizeof(struct cmh_ioctl_key_find) !=3D 32);
+       BUILD_BUG_ON(sizeof(struct cmh_ioctl_key_list) !=3D 40);
+       BUILD_BUG_ON(sizeof(struct cmh_ioctl_key_grant) !=3D 40);
+       BUILD_BUG_ON(sizeof(struct cmh_ioctl_ds_export) !=3D 40);
+       BUILD_BUG_ON(sizeof(struct cmh_ioctl_ds_import) !=3D 24);
+       BUILD_BUG_ON(sizeof(struct cmh_ioctl_kic_hkdf1) !=3D 48);
+       BUILD_BUG_ON(sizeof(struct cmh_ioctl_kic_hkdf2) !=3D 56);
+       BUILD_BUG_ON(sizeof(struct cmh_ioctl_kic_aes_cmac_kdf) !=3D 48);
+       BUILD_BUG_ON(sizeof(struct cmh_ioctl_kic_dkek_derive) !=3D 48);
+       BUILD_BUG_ON(sizeof(struct cmh_ioctl_pke_rsa_enc) !=3D 48);
+       BUILD_BUG_ON(sizeof(struct cmh_ioctl_pke_rsa_dec) !=3D 56);
+       BUILD_BUG_ON(sizeof(struct cmh_ioctl_pke_rsa_crt_dec) !=3D 56);
+       BUILD_BUG_ON(sizeof(struct cmh_ioctl_pke_rsa_keygen) !=3D 64);
+       BUILD_BUG_ON(sizeof(struct cmh_ioctl_pke_ecdsa_sign) !=3D 40);
+       BUILD_BUG_ON(sizeof(struct cmh_ioctl_pke_ecdh) !=3D 48);
+       BUILD_BUG_ON(sizeof(struct cmh_ioctl_pke_ecdh_keygen) !=3D 24);
+       BUILD_BUG_ON(sizeof(struct cmh_ioctl_pke_eddsa_sign) !=3D 40);
+       BUILD_BUG_ON(sizeof(struct cmh_ioctl_pke_eddsa_verify) !=3D 40);
+       BUILD_BUG_ON(sizeof(struct cmh_ioctl_pke_ec_keygen) !=3D 32);
+       BUILD_BUG_ON(sizeof(struct cmh_ioctl_pke_ec_pubgen) !=3D 24);
+       BUILD_BUG_ON(sizeof(struct cmh_ioctl_pke_eddsa_keygen_sca) !=3D 32)=
;
+       BUILD_BUG_ON(sizeof(struct cmh_ioctl_ml_kem_keygen) !=3D 64);
+       BUILD_BUG_ON(sizeof(struct cmh_ioctl_ml_kem_enc) !=3D 64);
+       BUILD_BUG_ON(sizeof(struct cmh_ioctl_ml_kem_dec) !=3D 56);
+       BUILD_BUG_ON(sizeof(struct cmh_ioctl_ml_dsa_keygen) !=3D 56);
+       BUILD_BUG_ON(sizeof(struct cmh_ioctl_ml_dsa_sign) !=3D 48);
+       BUILD_BUG_ON(sizeof(struct cmh_ioctl_slhdsa_keygen) !=3D 56);
+       BUILD_BUG_ON(sizeof(struct cmh_ioctl_slhdsa_sign) !=3D 56);
+       BUILD_BUG_ON(sizeof(struct cmh_ioctl_slhdsa_sign_prehash) !=3D 64);
+       BUILD_BUG_ON(sizeof(struct cmh_ioctl_sm2_ecdh_keygen) !=3D 24);
+       BUILD_BUG_ON(sizeof(struct cmh_ioctl_sm2_ecdh) !=3D 56);
+       BUILD_BUG_ON(sizeof(struct cmh_ioctl_sm2_dec_point) !=3D 32);
+       BUILD_BUG_ON(sizeof(struct cmh_ioctl_sm2_enc_point) !=3D 40);
+       BUILD_BUG_ON(sizeof(struct cmh_ioctl_sm2_id_digest) !=3D 32);
+       BUILD_BUG_ON(sizeof(struct cmh_ioctl_sm2_ecdh_hash) !=3D 40);
+       BUILD_BUG_ON(sizeof(struct cmh_ioctl_sm2_dec_hash) !=3D 32);
+       BUILD_BUG_ON(sizeof(struct cmh_ioctl_sm2_enc_hash) !=3D 32);
+       BUILD_BUG_ON(sizeof(struct cmh_ioctl_eac_read) !=3D 64);
+       BUILD_BUG_ON(sizeof(struct cmh_ioctl_drbg_config) !=3D 16);
+
+       ret =3D misc_register(&cmh_mgmt_dev);
+       if (ret) {
+               dev_err(cmh_dev(), "mgmt: misc_register failed (rc=3D%d)\n"=
, ret);
+               return ret;
+       }
+
+       cmh_mgmt_registered =3D true;
+       dev_info(cmh_dev(), "mgmt: registered /dev/cmh_mgmt\n");
+       return 0;
+}
+
+/**
+ * cmh_mgmt_unregister() - Unregister the /dev/cmh_mgmt misc device
+ */
+void cmh_mgmt_unregister(void)
+{
+       if (!cmh_mgmt_registered)
+               return;
+
+       misc_deregister(&cmh_mgmt_dev);
+       cmh_mgmt_registered =3D false;
+       dev_info(cmh_dev(), "mgmt: unregistered /dev/cmh_mgmt\n");
+}
diff --git a/drivers/crypto/cmh/cmh_mgmt_pke.c b/drivers/crypto/cmh/cmh_mgm=
t_pke.c
new file mode 100644
index 000000000000..6954832fa8ac
--- /dev/null
+++ b/drivers/crypto/cmh/cmh_mgmt_pke.c
@@ -0,0 +1,1100 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2026 Cryptography Research, Inc. (CRI).
+ * CMH -- PKE ioctl handlers for /dev/cmh_mgmt
+ *
+ * RSA encrypt/decrypt/CRT/keygen, ECDSA sign, ECDH/keygen,
+ * EdDSA sign/verify, EC keygen/pubgen.
+ *
+ * Split from cmh_mgmt.c for maintainability.
+ */
+
+#include <linux/kernel.h>
+#include <linux/uaccess.h>
+#include <linux/slab.h>
+#include <linux/overflow.h>
+
+#include "cmh_mgmt.h"
+#include "cmh_sys.h"
+#include "cmh_txn.h"
+#include "cmh_key.h"
+#include "cmh_dma.h"
+#include "cmh_config.h"
+#include "cmh_pke.h"
+#include "cmh_pke_abi.h"
+#include "cmh_sys_abi.h"
+#include <uapi/linux/cmh_mgmt_ioctl.h>
+
+#include <crypto/utils.h>
+
+/* -- PKE ioctl helpers ------------------- */
+
+/*
+ * Maximum PKE operand size: 512 bytes (RSA 4096-bit),
+ * or 2 * 68 =3D 136 bytes (P-521 coordinate pair).
+ */
+#define PKE_MAX_OPERAND        512
+
+/* Validate curve ID and return coordinate length; 0 =3D invalid */
+static u32 cmh_pke_validate_curve(u32 curve)
+{
+       return pke_curve_clen(curve);
+}
+
+/**
+ * cmh_mgmt_pke_rsa_enc() - Handle CMH_MGMT_IOC_PKE_RSA_ENC ioctl
+ * @argp: User-space ioctl argument pointer
+ *
+ * Return: 0 on success, negative errno on failure.
+ */
+int cmh_mgmt_pke_rsa_enc(void __user *argp)
+{
+       u32 pke_cid =3D cmh_core_default_id(CMH_CORE_PKE);
+
+       struct cmh_ioctl_pke_rsa_enc req;
+       struct vcq_cmd vcq[PKE_VCQ_CMDS_MIN];
+       u32 n_len, e_padded;
+       u8 *e_buf, *n_buf, *m_buf, *c_buf;
+       dma_addr_t e_dma, n_dma, m_dma, c_dma;
+       int ret;
+
+       if (copy_from_user(&req, argp, sizeof(req)))
+               return -EFAULT;
+       if (req.version !=3D CMH_MGMT_V1)
+               return -EINVAL;
+       if (req.__reserved)
+               return -EINVAL;
+       if (req.bits < PKE_RSA_MIN_BITS || req.bits > PKE_RSA_MAX_BITS)
+               return -EINVAL;
+       if (!req.e_len || req.e_len > PKE_MAX_OPERAND)
+               return -EINVAL;
+
+       n_len =3D req.bits / 8;
+       e_padded =3D ALIGN(req.e_len, 4);
+
+       e_buf =3D kzalloc(e_padded, GFP_KERNEL);
+       n_buf =3D kmalloc(n_len, GFP_KERNEL);
+       m_buf =3D kmalloc(n_len, GFP_KERNEL);
+       c_buf =3D kzalloc(n_len, GFP_KERNEL);
+       if (!e_buf || !n_buf || !m_buf || !c_buf) {
+               ret =3D -ENOMEM;
+               goto out_free;
+       }
+
+       /* Right-align exponent in zero-padded buffer for DMA alignment */
+       if (copy_from_user(e_buf + e_padded - req.e_len,
+                          u64_to_user_ptr(req.e), req.e_len) ||
+           copy_from_user(n_buf, u64_to_user_ptr(req.n), n_len) ||
+           copy_from_user(m_buf, u64_to_user_ptr(req.input), n_len)) {
+               ret =3D -EFAULT;
+               goto out_free;
+       }
+
+       e_dma =3D cmh_dma_map_single(e_buf, e_padded, DMA_TO_DEVICE);
+       n_dma =3D cmh_dma_map_single(n_buf, n_len, DMA_TO_DEVICE);
+       m_dma =3D cmh_dma_map_single(m_buf, n_len, DMA_TO_DEVICE);
+       c_dma =3D cmh_dma_map_single(c_buf, n_len, DMA_FROM_DEVICE);
+       if (cmh_dma_map_error(e_dma) || cmh_dma_map_error(n_dma) ||
+           cmh_dma_map_error(m_dma) || cmh_dma_map_error(c_dma)) {
+               ret =3D -ENOMEM;
+               goto out_unmap;
+       }
+
+       vcq_set_header(&vcq[0], PKE_VCQ_CMDS_MIN);
+       vcq_add_pke_rsa_enc(&vcq[1], pke_cid, req.bits, e_padded,
+                           e_dma, n_dma, m_dma, c_dma, PKE_SWAP_FLAGS);
+       vcq_add_pke_flush(&vcq[2], pke_cid);
+
+       ret =3D cmh_tm_submit_sync_mbx(vcq, PKE_VCQ_CMDS_MIN, 1, MGMT_MBX);
+
+out_unmap:
+       if (!cmh_dma_map_error(c_dma))
+               cmh_dma_unmap_single(c_dma, n_len, DMA_FROM_DEVICE);
+       if (!cmh_dma_map_error(m_dma))
+               cmh_dma_unmap_single(m_dma, n_len, DMA_TO_DEVICE);
+       if (!cmh_dma_map_error(n_dma))
+               cmh_dma_unmap_single(n_dma, n_len, DMA_TO_DEVICE);
+       if (!cmh_dma_map_error(e_dma))
+               cmh_dma_unmap_single(e_dma, e_padded, DMA_TO_DEVICE);
+
+       if (!ret) {
+               if (copy_to_user(u64_to_user_ptr(req.output), c_buf, n_len)=
)
+                       ret =3D -EFAULT;
+       }
+
+out_free:
+       kfree(c_buf);
+       kfree_sensitive(m_buf);
+       kfree(n_buf);
+       kfree(e_buf);
+       return ret;
+}
+
+/**
+ * cmh_mgmt_pke_rsa_dec() - Handle CMH_MGMT_IOC_PKE_RSA_DEC ioctl
+ * @argp: User-space ioctl argument pointer
+ *
+ * Return: 0 on success, negative errno on failure.
+ */
+int cmh_mgmt_pke_rsa_dec(void __user *argp)
+{
+       u32 pke_cid =3D cmh_core_default_id(CMH_CORE_PKE);
+
+       struct cmh_ioctl_pke_rsa_dec req;
+       struct vcq_cmd vcq[PKE_VCQ_CMDS_MIN];
+       u32 n_len, e_padded;
+       u8 *e_buf, *n_buf, *c_buf, *m_buf;
+       dma_addr_t e_dma, n_dma, c_dma, m_dma;
+       int ret;
+
+       if (copy_from_user(&req, argp, sizeof(req)))
+               return -EFAULT;
+       if (req.version !=3D CMH_MGMT_V1)
+               return -EINVAL;
+       if (req.__reserved)
+               return -EINVAL;
+       if (req.bits < PKE_RSA_MIN_BITS || req.bits > PKE_RSA_MAX_BITS)
+               return -EINVAL;
+       if (!req.e_len || req.e_len > PKE_MAX_OPERAND)
+               return -EINVAL;
+
+       n_len =3D req.bits / 8;
+       e_padded =3D ALIGN(req.e_len, 4);
+
+       e_buf =3D kzalloc(e_padded, GFP_KERNEL);
+       n_buf =3D kmalloc(n_len, GFP_KERNEL);
+       c_buf =3D kmalloc(n_len, GFP_KERNEL);
+       m_buf =3D kzalloc(n_len, GFP_KERNEL);
+       if (!e_buf || !n_buf || !c_buf || !m_buf) {
+               ret =3D -ENOMEM;
+               goto out_free;
+       }
+
+       /* Right-align exponent in zero-padded buffer for DMA alignment */
+       if (copy_from_user(e_buf + e_padded - req.e_len,
+                          u64_to_user_ptr(req.e), req.e_len) ||
+           copy_from_user(n_buf, u64_to_user_ptr(req.n), n_len) ||
+           copy_from_user(c_buf, u64_to_user_ptr(req.input), n_len)) {
+               ret =3D -EFAULT;
+               goto out_free;
+       }
+
+       e_dma =3D cmh_dma_map_single(e_buf, e_padded, DMA_TO_DEVICE);
+       n_dma =3D cmh_dma_map_single(n_buf, n_len, DMA_TO_DEVICE);
+       c_dma =3D cmh_dma_map_single(c_buf, n_len, DMA_TO_DEVICE);
+       m_dma =3D cmh_dma_map_single(m_buf, n_len, DMA_FROM_DEVICE);
+       if (cmh_dma_map_error(e_dma) || cmh_dma_map_error(n_dma) ||
+           cmh_dma_map_error(c_dma) || cmh_dma_map_error(m_dma)) {
+               ret =3D -ENOMEM;
+               goto out_unmap;
+       }
+
+       vcq_set_header(&vcq[0], PKE_VCQ_CMDS_MIN);
+       vcq_add_pke_rsa_dec(&vcq[1], pke_cid, req.bits, e_padded,
+                           e_dma, n_dma, c_dma, m_dma, req.key_ref,
+                           PKE_SWAP_FLAGS);
+       vcq_add_pke_flush(&vcq[2], pke_cid);
+
+       ret =3D cmh_tm_submit_sync_mbx(vcq, PKE_VCQ_CMDS_MIN, 1, MGMT_MBX);
+
+out_unmap:
+       if (!cmh_dma_map_error(m_dma))
+               cmh_dma_unmap_single(m_dma, n_len, DMA_FROM_DEVICE);
+       if (!cmh_dma_map_error(c_dma))
+               cmh_dma_unmap_single(c_dma, n_len, DMA_TO_DEVICE);
+       if (!cmh_dma_map_error(n_dma))
+               cmh_dma_unmap_single(n_dma, n_len, DMA_TO_DEVICE);
+       if (!cmh_dma_map_error(e_dma))
+               cmh_dma_unmap_single(e_dma, e_padded, DMA_TO_DEVICE);
+
+       if (!ret) {
+               if (copy_to_user(u64_to_user_ptr(req.output), m_buf, n_len)=
)
+                       ret =3D -EFAULT;
+       }
+
+out_free:
+       kfree_sensitive(m_buf);
+       kfree(c_buf);
+       kfree(n_buf);
+       kfree(e_buf);
+       return ret;
+}
+
+/**
+ * cmh_mgmt_pke_rsa_crt_dec() - Handle CMH_MGMT_IOC_PKE_RSA_CRT_DEC ioctl
+ * @argp: User-space ioctl argument pointer
+ *
+ * Return: 0 on success, negative errno on failure.
+ */
+int cmh_mgmt_pke_rsa_crt_dec(void __user *argp)
+{
+       u32 pke_cid =3D cmh_core_default_id(CMH_CORE_PKE);
+
+       struct cmh_ioctl_pke_rsa_crt_dec req;
+       struct vcq_cmd vcq[PKE_VCQ_CMDS_MIN];
+       u32 n_len, e_padded;
+       u8 *e_buf, *n_buf, *c_buf, *m_buf;
+       dma_addr_t e_dma, n_dma, c_dma, m_dma;
+       int ret;
+
+       if (copy_from_user(&req, argp, sizeof(req)))
+               return -EFAULT;
+       if (req.version !=3D CMH_MGMT_V1)
+               return -EINVAL;
+       if (req.__reserved)
+               return -EINVAL;
+       if (req.bits < PKE_RSA_MIN_BITS || req.bits > PKE_RSA_MAX_BITS)
+               return -EINVAL;
+       if (!req.e_len || req.e_len > PKE_MAX_OPERAND)
+               return -EINVAL;
+
+       n_len =3D req.bits / 8;
+       e_padded =3D ALIGN(req.e_len, 4);
+
+       e_buf =3D kzalloc(e_padded, GFP_KERNEL);
+       n_buf =3D kmalloc(n_len, GFP_KERNEL);
+       c_buf =3D kmalloc(n_len, GFP_KERNEL);
+       m_buf =3D kzalloc(n_len, GFP_KERNEL);
+       if (!e_buf || !n_buf || !c_buf || !m_buf) {
+               ret =3D -ENOMEM;
+               goto out_free;
+       }
+
+       /* Right-align exponent in zero-padded buffer for DMA alignment */
+       if (copy_from_user(e_buf + e_padded - req.e_len,
+                          u64_to_user_ptr(req.e), req.e_len) ||
+           copy_from_user(n_buf, u64_to_user_ptr(req.n), n_len) ||
+           copy_from_user(c_buf, u64_to_user_ptr(req.input), n_len)) {
+               ret =3D -EFAULT;
+               goto out_free;
+       }
+
+       e_dma =3D cmh_dma_map_single(e_buf, e_padded, DMA_TO_DEVICE);
+       n_dma =3D cmh_dma_map_single(n_buf, n_len, DMA_TO_DEVICE);
+       c_dma =3D cmh_dma_map_single(c_buf, n_len, DMA_TO_DEVICE);
+       m_dma =3D cmh_dma_map_single(m_buf, n_len, DMA_FROM_DEVICE);
+       if (cmh_dma_map_error(e_dma) || cmh_dma_map_error(n_dma) ||
+           cmh_dma_map_error(c_dma) || cmh_dma_map_error(m_dma)) {
+               ret =3D -ENOMEM;
+               goto out_unmap;
+       }
+
+       vcq_set_header(&vcq[0], PKE_VCQ_CMDS_MIN);
+       vcq_add_pke_rsa_crt_dec(&vcq[1], pke_cid, req.bits, e_padded,
+                               e_dma, n_dma, c_dma, m_dma, req.crt_ref,
+                               PKE_SWAP_FLAGS);
+       vcq_add_pke_flush(&vcq[2], pke_cid);
+
+       ret =3D cmh_tm_submit_sync_mbx(vcq, PKE_VCQ_CMDS_MIN, 1, MGMT_MBX);
+
+out_unmap:
+       if (!cmh_dma_map_error(m_dma))
+               cmh_dma_unmap_single(m_dma, n_len, DMA_FROM_DEVICE);
+       if (!cmh_dma_map_error(c_dma))
+               cmh_dma_unmap_single(c_dma, n_len, DMA_TO_DEVICE);
+       if (!cmh_dma_map_error(n_dma))
+               cmh_dma_unmap_single(n_dma, n_len, DMA_TO_DEVICE);
+       if (!cmh_dma_map_error(e_dma))
+               cmh_dma_unmap_single(e_dma, e_padded, DMA_TO_DEVICE);
+
+       if (!ret) {
+               if (copy_to_user(u64_to_user_ptr(req.output), m_buf, n_len)=
)
+                       ret =3D -EFAULT;
+       }
+
+out_free:
+       kfree_sensitive(m_buf);
+       kfree(c_buf);
+       kfree(n_buf);
+       kfree(e_buf);
+       return ret;
+}
+
+/**
+ * cmh_mgmt_pke_rsa_keygen() - Handle CMH_MGMT_IOC_PKE_RSA_KEYGEN ioctl
+ * @argp: User-space ioctl argument pointer
+ *
+ * Return: 0 on success, negative errno on failure.
+ */
+int cmh_mgmt_pke_rsa_keygen(void __user *argp)
+{
+       u32 pke_cid =3D cmh_core_default_id(CMH_CORE_PKE);
+
+       struct cmh_ioctl_pke_rsa_keygen req;
+       /*
+        * When has_crt, we use a two-VCQ approach (CRI pattern):
+        *   VCQ #1: header + SYS_NEW(d) + SYS_NEW(crt) + SYS_FLUSH  (4 slo=
ts)
+        *   VCQ #2: header + RSA_KEYGEN + PKE_FLUSH + SYS_FLUSH       (4 s=
lots)
+        * Without CRT, single VCQ:
+        *   header + SYS_NEW(d) + RSA_KEYGEN + PKE_FLUSH + SYS_FLUSH  (5 s=
lots)
+        */
+       struct vcq_cmd vcq[5];
+       u32 n_len, e_padded, key_flags, d_ds_len, crt_ds_len;
+       u8 *e_buf, *n_buf;
+       u64 *d_ref_buf, *crt_ref_buf;
+       dma_addr_t e_dma, n_dma, d_ref_dma, crt_ref_dma;
+       int idx, ret;
+       bool has_crt, is_sca;
+
+       if (copy_from_user(&req, argp, sizeof(req)))
+               return -EFAULT;
+       if (req.version !=3D CMH_MGMT_V1)
+               return -EINVAL;
+       if (req.bits < PKE_RSA_MIN_BITS || req.bits > PKE_RSA_MAX_BITS)
+               return -EINVAL;
+       if (!req.e_len || req.e_len > PKE_MAX_OPERAND)
+               return -EINVAL;
+       if (req.flags & ~CMH_FLAG_MASK)
+               return -EINVAL;
+
+       n_len =3D req.bits / 8;
+       has_crt =3D (req.crt_cid !=3D 0);
+       e_padded =3D ALIGN(req.e_len, 4);
+       key_flags =3D req.flags & CMH_FLAG_MASK;
+       is_sca =3D !!(req.flags & CMH_FLAG_SCA);
+
+       /*
+        * SCA keys are stored in 2 shares -- DS allocation must be enlarge=
d.
+        * CRI reference formulas: cmh_pke_rsa_private_key_size().
+        */
+       if (is_sca) {
+               d_ds_len =3D n_len * 2;
+               crt_ds_len =3D (7 + n_len / 2) * 4;
+       } else {
+               d_ds_len =3D n_len;
+               crt_ds_len =3D 5 * (n_len / 2);
+       }
+
+       e_buf =3D kzalloc(e_padded, GFP_KERNEL);
+       n_buf =3D kzalloc(n_len, GFP_KERNEL);
+       d_ref_buf =3D kzalloc_obj(u64, GFP_KERNEL);
+       crt_ref_buf =3D kzalloc_obj(u64, GFP_KERNEL);
+       if (!e_buf || !n_buf || !d_ref_buf || !crt_ref_buf) {
+               ret =3D -ENOMEM;
+               goto out_free;
+       }
+
+       if (copy_from_user(e_buf + e_padded - req.e_len,
+                          u64_to_user_ptr(req.e), req.e_len)) {
+               ret =3D -EFAULT;
+               goto out_free;
+       }
+
+       e_dma =3D cmh_dma_map_single(e_buf, e_padded, DMA_TO_DEVICE);
+       n_dma =3D cmh_dma_map_single(n_buf, n_len, DMA_FROM_DEVICE);
+       d_ref_dma =3D cmh_dma_map_single(d_ref_buf, sizeof(u64), DMA_FROM_D=
EVICE);
+       crt_ref_dma =3D cmh_dma_map_single(crt_ref_buf, sizeof(u64),
+                                        DMA_FROM_DEVICE);
+       if (cmh_dma_map_error(e_dma) || cmh_dma_map_error(n_dma) ||
+           cmh_dma_map_error(d_ref_dma) || cmh_dma_map_error(crt_ref_dma))=
 {
+               ret =3D -ENOMEM;
+               goto out_unmap;
+       }
+
+       if (has_crt) {
+               /*
+                * Two-VCQ approach (CRI pattern): SYS_REF_LAST can only
+                * refer to the most recently created DS object.  When we
+                * need both d and crt refs, we must first allocate DS
+                * objects, read back the opaque refs, then pass them by
+                * value in the keygen VCQ.
+                *
+                * VCQ #1: allocate both DS objects.
+                */
+               idx =3D 0;
+               vcq_set_header(&vcq[idx++], 4);
+               vcq_add_sys_new(&vcq[idx++], req.d_cid, d_ref_dma, d_ds_len=
);
+               vcq_add_sys_new(&vcq[idx++], req.crt_cid, crt_ref_dma,
+                               crt_ds_len);
+               vcq_add_sys_flush(&vcq[idx++]);
+
+               ret =3D cmh_tm_submit_sync_mbx(vcq, 4, 1, MGMT_MBX);
+               if (ret)
+                       goto out_unmap;
+
+               /* Sync DMA so we can read back the opaque refs */
+               cmh_dma_unmap_single(d_ref_dma, sizeof(u64), DMA_FROM_DEVIC=
E);
+               cmh_dma_unmap_single(crt_ref_dma, sizeof(u64),
+                                    DMA_FROM_DEVICE);
+               d_ref_dma =3D 0;
+               crt_ref_dma =3D 0;
+
+               /*
+                * VCQ #2: keygen with resolved refs.
+                */
+               idx =3D 0;
+               memset(vcq, 0, sizeof(vcq));
+               vcq_set_header(&vcq[idx++], 4);
+
+               vcq[idx].magic =3D VCQ_CMD_MAGIC;
+               vcq[idx].id =3D VCQ_CMD_ID(pke_cid, PKE_SWAP_FLAGS, 1,
+                                        PKE_CMD_RSA_KEYGEN);
+               vcq[idx].hwc.pke.cmd_rsa_keygen.bits =3D req.bits;
+               vcq[idx].hwc.pke.cmd_rsa_keygen.e =3D e_dma;
+               vcq[idx].hwc.pke.cmd_rsa_keygen.n =3D n_dma;
+               vcq[idx].hwc.pke.cmd_rsa_keygen.d =3D *d_ref_buf;
+               vcq[idx].hwc.pke.cmd_rsa_keygen.d_type =3D
+                       SYS_TYPE_SET(key_flags, CORE_ID_PKE);
+               vcq[idx].hwc.pke.cmd_rsa_keygen.crt =3D *crt_ref_buf;
+               vcq[idx].hwc.pke.cmd_rsa_keygen.crt_type =3D
+                       SYS_TYPE_SET(key_flags, CORE_ID_PKE);
+               idx++;
+
+               vcq_add_pke_flush(&vcq[idx++], pke_cid);
+               vcq_add_sys_flush(&vcq[idx++]);
+
+               ret =3D cmh_tm_submit_sync_tmo(vcq, 4, 1, MGMT_MBX,
+                                            cmh_tm_slow_op_timeout_jiffies=
());
+       } else {
+               /*
+                * Single-VCQ: only d, so SYS_REF_LAST is unambiguous.
+                */
+               idx =3D 0;
+               vcq_set_header(&vcq[idx++], 5);
+               vcq_add_sys_new(&vcq[idx++], req.d_cid, d_ref_dma, d_ds_len=
);
+
+               vcq[idx].magic =3D VCQ_CMD_MAGIC;
+               vcq[idx].id =3D VCQ_CMD_ID(pke_cid, PKE_SWAP_FLAGS, 1,
+                                        PKE_CMD_RSA_KEYGEN);
+               vcq[idx].hwc.pke.cmd_rsa_keygen.bits =3D req.bits;
+               vcq[idx].hwc.pke.cmd_rsa_keygen.e =3D e_dma;
+               vcq[idx].hwc.pke.cmd_rsa_keygen.n =3D n_dma;
+               vcq[idx].hwc.pke.cmd_rsa_keygen.d =3D SYS_REF_LAST;
+               vcq[idx].hwc.pke.cmd_rsa_keygen.d_type =3D
+                       SYS_TYPE_SET(key_flags, CORE_ID_PKE);
+               vcq[idx].hwc.pke.cmd_rsa_keygen.crt =3D SYS_REF_NONE;
+               vcq[idx].hwc.pke.cmd_rsa_keygen.crt_type =3D 0;
+               idx++;
+
+               vcq_add_pke_flush(&vcq[idx++], pke_cid);
+               vcq_add_sys_flush(&vcq[idx++]);
+
+               ret =3D cmh_tm_submit_sync_tmo(vcq, 5, 1, MGMT_MBX,
+                                            cmh_tm_slow_op_timeout_jiffies=
());
+       }
+
+out_unmap:
+       if (crt_ref_dma && !cmh_dma_map_error(crt_ref_dma))
+               cmh_dma_unmap_single(crt_ref_dma, sizeof(u64),
+                                    DMA_FROM_DEVICE);
+       if (d_ref_dma && !cmh_dma_map_error(d_ref_dma))
+               cmh_dma_unmap_single(d_ref_dma, sizeof(u64), DMA_FROM_DEVIC=
E);
+       if (!cmh_dma_map_error(n_dma))
+               cmh_dma_unmap_single(n_dma, n_len, DMA_FROM_DEVICE);
+       if (!cmh_dma_map_error(e_dma))
+               cmh_dma_unmap_single(e_dma, e_padded, DMA_TO_DEVICE);
+
+       if (!ret) {
+               /* Copy generated modulus and refs back */
+               if (copy_to_user(u64_to_user_ptr(req.n), n_buf, n_len)) {
+                       ret =3D -EFAULT;
+                       goto out_free;
+               }
+               req.d_ref =3D *d_ref_buf;
+               req.crt_ref =3D has_crt ? *crt_ref_buf : 0;
+               if (copy_to_user(argp, &req, sizeof(req)))
+                       ret =3D -EFAULT;
+       }
+
+out_free:
+       kfree(crt_ref_buf);
+       kfree(d_ref_buf);
+       kfree(n_buf);
+       kfree(e_buf);
+       return ret;
+}
+
+/**
+ * cmh_mgmt_pke_ecdsa_sign() - Handle CMH_MGMT_IOC_PKE_ECDSA_SIGN ioctl
+ * @argp: User-space ioctl argument pointer
+ *
+ * Return: 0 on success, negative errno on failure.
+ */
+int cmh_mgmt_pke_ecdsa_sign(void __user *argp)
+{
+       u32 pke_cid =3D cmh_core_default_id(CMH_CORE_PKE);
+
+       struct cmh_ioctl_pke_ecdsa_sign req;
+       struct vcq_cmd vcq[PKE_VCQ_CMDS_MIN];
+       u32 clen, sig_len, dig_map_len;
+       u8 *dig_buf, *sig_buf;
+       dma_addr_t dig_dma, sig_dma;
+       int ret;
+
+       if (copy_from_user(&req, argp, sizeof(req)))
+               return -EFAULT;
+       if (req.version !=3D CMH_MGMT_V1)
+               return -EINVAL;
+       if (req.__reserved)
+               return -EINVAL;
+       clen =3D cmh_pke_validate_curve(req.curve);
+       if (!clen || !req.digest_len ||
+           req.digest_len > CMH_MGMT_MAX_DATA_LEN)
+               return -EINVAL;
+
+       sig_len =3D 2 * clen;
+
+       /*
+        * eSW requires digest_len >=3D clen.  Zero-pad shorter hashes.
+        */
+       dig_map_len =3D max_t(u32, req.digest_len, clen);
+
+       dig_buf =3D kzalloc(dig_map_len, GFP_KERNEL);
+       sig_buf =3D kzalloc(sig_len, GFP_KERNEL);
+       if (!dig_buf || !sig_buf) {
+               ret =3D -ENOMEM;
+               goto out_free;
+       }
+
+       if (copy_from_user(dig_buf, u64_to_user_ptr(req.digest),
+                          req.digest_len)) {
+               ret =3D -EFAULT;
+               goto out_free;
+       }
+
+       dig_dma =3D cmh_dma_map_single(dig_buf, dig_map_len, DMA_TO_DEVICE)=
;
+       sig_dma =3D cmh_dma_map_single(sig_buf, sig_len, DMA_FROM_DEVICE);
+       if (cmh_dma_map_error(dig_dma) || cmh_dma_map_error(sig_dma)) {
+               ret =3D -ENOMEM;
+               goto out_unmap;
+       }
+
+       vcq_set_header(&vcq[0], PKE_VCQ_CMDS_MIN);
+       vcq_add_pke_ecdsa_sign(&vcq[1], pke_cid, req.curve, clen,
+                              dig_dma, sig_dma, req.key_ref,
+                              dig_map_len, pke_swap_flags(req.curve));
+       vcq_add_pke_flush(&vcq[2], pke_cid);
+
+       ret =3D cmh_tm_submit_sync_mbx(vcq, PKE_VCQ_CMDS_MIN, 1, MGMT_MBX);
+
+out_unmap:
+       if (!cmh_dma_map_error(sig_dma))
+               cmh_dma_unmap_single(sig_dma, sig_len, DMA_FROM_DEVICE);
+       if (!cmh_dma_map_error(dig_dma))
+               cmh_dma_unmap_single(dig_dma, dig_map_len, DMA_TO_DEVICE);
+
+       if (!ret) {
+               if (copy_to_user(u64_to_user_ptr(req.signature),
+                                sig_buf, sig_len))
+                       ret =3D -EFAULT;
+       }
+
+out_free:
+       kfree(sig_buf);
+       kfree(dig_buf);
+       return ret;
+}
+
+/**
+ * cmh_mgmt_pke_ecdh() - Handle CMH_MGMT_IOC_PKE_ECDH ioctl
+ * @argp: User-space ioctl argument pointer
+ *
+ * Return: 0 on success, negative errno on failure.
+ */
+int cmh_mgmt_pke_ecdh(void __user *argp)
+{
+       u32 pke_cid =3D cmh_core_default_id(CMH_CORE_PKE);
+
+       struct cmh_ioctl_pke_ecdh req;
+       /* Phase 1: hdr + sys_new + pke_ecdh + pke_flush; reused for Phase =
2 */
+       struct vcq_cmd vcq[4];
+       u32 clen, swap, ss_type;
+       u8 *peer_buf, *ss_buf;
+       u64 *ref_buf;
+       dma_addr_t peer_dma, ss_dma, ref_dma;
+       int ret, idx;
+
+       if (copy_from_user(&req, argp, sizeof(req)))
+               return -EFAULT;
+       if (req.version !=3D CMH_MGMT_V1)
+               return -EINVAL;
+       if (req.__reserved)
+               return -EINVAL;
+       clen =3D cmh_pke_validate_curve(req.curve);
+       if (!clen)
+               return -EINVAL;
+
+       swap =3D PKE_SWAP_FLAGS;
+       ss_type =3D SYS_TYPE_SET(SYS_TYPE_FLAG_PT, CORE_ID_PKE);
+
+       peer_buf =3D kmalloc(clen, GFP_KERNEL);
+       ss_buf =3D kzalloc(clen, GFP_KERNEL);
+       ref_buf =3D kzalloc_obj(u64, GFP_KERNEL);
+       if (!peer_buf || !ss_buf || !ref_buf) {
+               ret =3D -ENOMEM;
+               goto out_free;
+       }
+
+       if (copy_from_user(peer_buf, u64_to_user_ptr(req.peer_key_x), clen)=
) {
+               ret =3D -EFAULT;
+               goto out_free;
+       }
+
+       peer_dma =3D cmh_dma_map_single(peer_buf, clen, DMA_TO_DEVICE);
+       ss_dma =3D cmh_dma_map_single(ss_buf, clen, DMA_FROM_DEVICE);
+       ref_dma =3D cmh_dma_map_single(ref_buf, sizeof(u64), DMA_FROM_DEVIC=
E);
+       if (cmh_dma_map_error(peer_dma) || cmh_dma_map_error(ss_dma) ||
+           cmh_dma_map_error(ref_dma)) {
+               ret =3D -ENOMEM;
+               goto out_unmap;
+       }
+
+       idx =3D 0;
+       vcq_set_header(&vcq[idx++], 4);
+       vcq_add_sys_new(&vcq[idx++], 0, ref_dma, clen);
+       vcq_add_pke_ecdh(&vcq[idx++], pke_cid, req.curve, clen, clen,
+                        ss_type, peer_dma, req.key_ref,
+                        SYS_REF_LAST, swap);
+       vcq_add_pke_flush(&vcq[idx++], pke_cid);
+
+       ret =3D cmh_tm_submit_sync_mbx(vcq, 4, 1, MGMT_MBX);
+       if (ret)
+               goto out_unmap;
+
+       /* Sync bounce buffer so CPU sees the DMA-written ref */
+       cmh_dma_sync_for_cpu(ref_dma, sizeof(u64), DMA_FROM_DEVICE);
+
+       /* Phase 2: extract shared secret from DS via actual ref */
+       vcq_set_header(&vcq[0], 3);
+       vcq_add_sys_data(&vcq[1], *ref_buf, ss_dma, clen);
+       vcq[1].id |=3D pke_swap_flags(req.curve);
+       vcq_add_sys_flush(&vcq[2]);
+
+       ret =3D cmh_tm_submit_sync_mbx(vcq, 3, 1, MGMT_MBX);
+
+out_unmap:
+       if (!cmh_dma_map_error(ref_dma))
+               cmh_dma_unmap_single(ref_dma, sizeof(u64), DMA_FROM_DEVICE)=
;
+       if (!cmh_dma_map_error(ss_dma))
+               cmh_dma_unmap_single(ss_dma, clen, DMA_FROM_DEVICE);
+       if (!cmh_dma_map_error(peer_dma))
+               cmh_dma_unmap_single(peer_dma, clen, DMA_TO_DEVICE);
+
+       if (!ret) {
+               if (copy_to_user(u64_to_user_ptr(req.output), ss_buf, clen)=
)
+                       ret =3D -EFAULT;
+       }
+
+out_free:
+       kfree(ref_buf);
+       kfree_sensitive(ss_buf);
+       kfree(peer_buf);
+       return ret;
+}
+
+/**
+ * cmh_mgmt_pke_ecdh_keygen() - Handle CMH_MGMT_IOC_PKE_ECDH_KEYGEN ioctl
+ * @argp: User-space ioctl argument pointer
+ *
+ * Return: 0 on success, negative errno on failure.
+ */
+int cmh_mgmt_pke_ecdh_keygen(void __user *argp)
+{
+       u32 pke_cid =3D cmh_core_default_id(CMH_CORE_PKE);
+
+       struct cmh_ioctl_pke_ecdh_keygen req;
+       struct vcq_cmd vcq[PKE_VCQ_CMDS_MIN];
+       u32 clen, out_len;
+       u8 *pkx_buf;
+       dma_addr_t pkx_dma;
+       int ret;
+
+       if (copy_from_user(&req, argp, sizeof(req)))
+               return -EFAULT;
+       if (req.version !=3D CMH_MGMT_V1)
+               return -EINVAL;
+       clen =3D cmh_pke_validate_curve(req.curve);
+       if (!clen)
+               return -EINVAL;
+
+       /*
+        * ECDH_KEYGEN always outputs both X and Y coordinates
+        * (2 * clen bytes total) even though only X is useful for
+        * the ECDH exchange.  Allocate the full output size to avoid
+        * a DMA buffer overflow, but copy only X back to userspace.
+        */
+       out_len =3D 2 * clen;
+
+       pkx_buf =3D kzalloc(out_len, GFP_KERNEL);
+       if (!pkx_buf)
+               return -ENOMEM;
+
+       pkx_dma =3D cmh_dma_map_single(pkx_buf, out_len, DMA_FROM_DEVICE);
+       if (cmh_dma_map_error(pkx_dma)) {
+               kfree(pkx_buf);
+               return -ENOMEM;
+       }
+
+       vcq_set_header(&vcq[0], PKE_VCQ_CMDS_MIN);
+       vcq_add_pke_ecdh_keygen(&vcq[1], pke_cid, req.curve, clen,
+                               pkx_dma, req.key_ref,
+                               PKE_SWAP_FLAGS);
+       vcq_add_pke_flush(&vcq[2], pke_cid);
+
+       ret =3D cmh_tm_submit_sync_mbx(vcq, PKE_VCQ_CMDS_MIN, 1, MGMT_MBX);
+
+       cmh_dma_unmap_single(pkx_dma, out_len, DMA_FROM_DEVICE);
+
+       if (!ret) {
+               if (copy_to_user(u64_to_user_ptr(req.public_key_x),
+                                pkx_buf, clen))
+                       ret =3D -EFAULT;
+       }
+
+       kfree(pkx_buf);
+       return ret;
+}
+
+/**
+ * cmh_mgmt_pke_eddsa_sign() - Handle CMH_MGMT_IOC_PKE_EDDSA_SIGN ioctl
+ * @argp: User-space ioctl argument pointer
+ *
+ * Return: 0 on success, negative errno on failure.
+ */
+int cmh_mgmt_pke_eddsa_sign(void __user *argp)
+{
+       u32 pke_cid =3D cmh_core_default_id(CMH_CORE_PKE);
+
+       struct cmh_ioctl_pke_eddsa_sign req;
+       struct vcq_cmd vcq[PKE_VCQ_CMDS_MIN];
+       u32 klen, sig_len;
+       u8 *msg_buf, *sig_buf;
+       dma_addr_t msg_dma, sig_dma;
+       int ret;
+
+       if (copy_from_user(&req, argp, sizeof(req)))
+               return -EFAULT;
+       if (req.version !=3D CMH_MGMT_V1)
+               return -EINVAL;
+       if (req.__reserved)
+               return -EINVAL;
+       if (!cmh_pke_validate_curve(req.curve) || !req.digest_len ||
+           req.digest_len > CMH_MGMT_MAX_DATA_LEN)
+               return -EINVAL;
+       if (!pke_curve_is_edwards(req.curve))
+               return -EINVAL;
+
+       klen =3D pke_eddsa_key_len(req.curve);
+       sig_len =3D 2 * klen;
+
+       msg_buf =3D kmalloc(req.digest_len, GFP_KERNEL);
+       sig_buf =3D kzalloc(sig_len, GFP_KERNEL);
+       if (!msg_buf || !sig_buf) {
+               ret =3D -ENOMEM;
+               goto out_free;
+       }
+
+       if (copy_from_user(msg_buf, u64_to_user_ptr(req.digest),
+                          req.digest_len)) {
+               ret =3D -EFAULT;
+               goto out_free;
+       }
+
+       msg_dma =3D cmh_dma_map_single(msg_buf, req.digest_len, DMA_TO_DEVI=
CE);
+       sig_dma =3D cmh_dma_map_single(sig_buf, sig_len, DMA_FROM_DEVICE);
+       if (cmh_dma_map_error(msg_dma) || cmh_dma_map_error(sig_dma)) {
+               ret =3D -ENOMEM;
+               goto out_unmap;
+       }
+
+       vcq_set_header(&vcq[0], PKE_VCQ_CMDS_MIN);
+       vcq_add_pke_eddsa_sign(&vcq[1], pke_cid, req.curve, klen,
+                              msg_dma, sig_dma, req.key_ref,
+                              req.digest_len, pke_swap_flags(req.curve));
+       vcq_add_pke_flush(&vcq[2], pke_cid);
+
+       ret =3D cmh_tm_submit_sync_mbx(vcq, PKE_VCQ_CMDS_MIN, 1, MGMT_MBX);
+
+out_unmap:
+       if (!cmh_dma_map_error(sig_dma))
+               cmh_dma_unmap_single(sig_dma, sig_len, DMA_FROM_DEVICE);
+       if (!cmh_dma_map_error(msg_dma))
+               cmh_dma_unmap_single(msg_dma, req.digest_len, DMA_TO_DEVICE=
);
+
+       if (!ret) {
+               if (copy_to_user(u64_to_user_ptr(req.signature),
+                                sig_buf, sig_len))
+                       ret =3D -EFAULT;
+       }
+
+out_free:
+       kfree(sig_buf);
+       kfree(msg_buf);
+       return ret;
+}
+
+/**
+ * cmh_mgmt_pke_eddsa_verify() - Handle CMH_MGMT_IOC_PKE_EDDSA_VERIFY ioct=
l
+ * @argp: User-space ioctl argument pointer
+ *
+ * Return: 0 on success, negative errno on failure.
+ */
+int cmh_mgmt_pke_eddsa_verify(void __user *argp)
+{
+       u32 pke_cid =3D cmh_core_default_id(CMH_CORE_PKE);
+
+       struct cmh_ioctl_pke_eddsa_verify req;
+       struct vcq_cmd vcq[PKE_VCQ_CMDS_MIN];
+       u32 clen, klen, sig_len;
+       u8 *msg_buf, *sig_buf, *pky_buf, *rp_buf;
+       dma_addr_t msg_dma, sig_dma, pky_dma, rp_dma;
+       int ret;
+
+       if (copy_from_user(&req, argp, sizeof(req)))
+               return -EFAULT;
+       if (req.version !=3D CMH_MGMT_V1)
+               return -EINVAL;
+       if (req.__reserved)
+               return -EINVAL;
+       clen =3D cmh_pke_validate_curve(req.curve);
+       if (!clen || !req.digest_len ||
+           req.digest_len > CMH_MGMT_MAX_DATA_LEN)
+               return -EINVAL;
+       if (!pke_curve_is_edwards(req.curve))
+               return -EINVAL;
+
+       klen =3D pke_eddsa_key_len(req.curve);
+       sig_len =3D 2 * klen;
+
+       msg_buf =3D kmalloc(req.digest_len, GFP_KERNEL);
+       sig_buf =3D kmalloc(sig_len, GFP_KERNEL);
+       pky_buf =3D kmalloc(klen, GFP_KERNEL);
+       rp_buf =3D kzalloc(clen, GFP_KERNEL);
+       if (!msg_buf || !sig_buf || !pky_buf || !rp_buf) {
+               ret =3D -ENOMEM;
+               goto out_free;
+       }
+
+       if (copy_from_user(msg_buf, u64_to_user_ptr(req.digest),
+                          req.digest_len) ||
+           copy_from_user(sig_buf, u64_to_user_ptr(req.signature),
+                          sig_len) ||
+           copy_from_user(pky_buf, u64_to_user_ptr(req.public_key_y),
+                          klen)) {
+               ret =3D -EFAULT;
+               goto out_free;
+       }
+
+       msg_dma =3D cmh_dma_map_single(msg_buf, req.digest_len, DMA_TO_DEVI=
CE);
+       sig_dma =3D cmh_dma_map_single(sig_buf, sig_len, DMA_TO_DEVICE);
+       pky_dma =3D cmh_dma_map_single(pky_buf, klen, DMA_TO_DEVICE);
+       rp_dma =3D cmh_dma_map_single(rp_buf, clen, DMA_FROM_DEVICE);
+       if (cmh_dma_map_error(msg_dma) || cmh_dma_map_error(sig_dma) ||
+           cmh_dma_map_error(pky_dma) || cmh_dma_map_error(rp_dma)) {
+               ret =3D -ENOMEM;
+               goto out_unmap;
+       }
+
+       vcq_set_header(&vcq[0], PKE_VCQ_CMDS_MIN);
+       vcq_add_pke_eddsa_verify(&vcq[1], pke_cid, req.curve, req.digest_le=
n,
+                                pky_dma, msg_dma, sig_dma, rp_dma,
+                                pke_swap_flags(req.curve));
+       vcq_add_pke_flush(&vcq[2], pke_cid);
+
+       ret =3D cmh_tm_submit_sync_mbx(vcq, PKE_VCQ_CMDS_MIN, 1, MGMT_MBX);
+
+out_unmap:
+       if (!cmh_dma_map_error(rp_dma))
+               cmh_dma_unmap_single(rp_dma, clen, DMA_FROM_DEVICE);
+       if (!cmh_dma_map_error(pky_dma))
+               cmh_dma_unmap_single(pky_dma, klen, DMA_TO_DEVICE);
+       if (!cmh_dma_map_error(sig_dma))
+               cmh_dma_unmap_single(sig_dma, sig_len, DMA_TO_DEVICE);
+       if (!cmh_dma_map_error(msg_dma))
+               cmh_dma_unmap_single(msg_dma, req.digest_len, DMA_TO_DEVICE=
);
+
+out_free:
+       kfree(rp_buf);
+       kfree(pky_buf);
+       kfree(sig_buf);
+       kfree(msg_buf);
+       return ret;
+}
+
+/**
+ * cmh_mgmt_pke_ec_keygen() - Handle CMH_MGMT_IOC_PKE_EC_KEYGEN ioctl
+ * @argp: User-space ioctl argument pointer
+ *
+ * Return: 0 on success, negative errno on failure.
+ */
+int cmh_mgmt_pke_ec_keygen(void __user *argp)
+{
+       u32 pke_cid =3D cmh_core_default_id(CMH_CORE_PKE);
+
+       struct cmh_ioctl_pke_ec_keygen req;
+       /* header + SYS_NEW + ECDSA_KEYGEN + flush_pke + flush_sys */
+       struct vcq_cmd vcq[5];
+       u32 clen, key_flags, ds_len;
+       u64 *ref_buf;
+       dma_addr_t ref_dma;
+       int ret;
+
+       if (copy_from_user(&req, argp, sizeof(req)))
+               return -EFAULT;
+       if (req.version !=3D CMH_MGMT_V1)
+               return -EINVAL;
+       if (req.__reserved)
+               return -EINVAL;
+       if (req.flags & ~CMH_FLAG_MASK)
+               return -EINVAL;
+       clen =3D cmh_pke_validate_curve(req.curve);
+       if (!clen)
+               return -EINVAL;
+
+       key_flags =3D req.flags & CMH_FLAG_MASK;
+       /* SCA keys are stored in 2 shares -- allocate double the curve len=
gth */
+       ds_len =3D (req.flags & CMH_FLAG_SCA) ? clen * 2 : clen;
+
+       ref_buf =3D kzalloc_obj(u64, GFP_KERNEL);
+       if (!ref_buf)
+               return -ENOMEM;
+
+       ref_dma =3D cmh_dma_map_single(ref_buf, sizeof(u64), DMA_FROM_DEVIC=
E);
+       if (cmh_dma_map_error(ref_dma)) {
+               kfree(ref_buf);
+               return -ENOMEM;
+       }
+
+       vcq_set_header(&vcq[0], 5);
+       vcq_add_sys_new(&vcq[1], req.cid, ref_dma, ds_len);
+       vcq_add_pke_ecdsa_keygen(&vcq[2], pke_cid, req.curve, clen,
+                                SYS_REF_LAST,
+                                SYS_TYPE_SET(key_flags, CORE_ID_PKE),
+                                pke_swap_flags(req.curve));
+       vcq_add_pke_flush(&vcq[3], pke_cid);
+       vcq_add_sys_flush(&vcq[4]);
+
+       ret =3D cmh_tm_submit_sync_mbx(vcq, 5, 1, MGMT_MBX);
+
+       cmh_dma_unmap_single(ref_dma, sizeof(u64), DMA_FROM_DEVICE);
+
+       if (!ret) {
+               req.ref =3D *ref_buf;
+               if (copy_to_user(argp, &req, sizeof(req)))
+                       ret =3D -EFAULT;
+       }
+
+       kfree(ref_buf);
+       return ret;
+}
+
+/**
+ * cmh_mgmt_pke_ec_pubgen() - Handle CMH_MGMT_IOC_PKE_EC_PUBGEN ioctl
+ * @argp: User-space ioctl argument pointer
+ *
+ * Return: 0 on success, negative errno on failure.
+ */
+int cmh_mgmt_pke_ec_pubgen(void __user *argp)
+{
+       u32 pke_cid =3D cmh_core_default_id(CMH_CORE_PKE);
+
+       struct cmh_ioctl_pke_ec_pubgen req;
+       struct vcq_cmd vcq[PKE_VCQ_CMDS_MIN];
+       u32 clen, pk_len;
+       u8 *pk_buf;
+       dma_addr_t pk_dma;
+       bool is_ed;
+       int ret;
+
+       if (copy_from_user(&req, argp, sizeof(req)))
+               return -EFAULT;
+       if (req.version !=3D CMH_MGMT_V1)
+               return -EINVAL;
+       clen =3D cmh_pke_validate_curve(req.curve);
+       if (!clen)
+               return -EINVAL;
+
+       is_ed =3D pke_curve_is_edwards(req.curve);
+       pk_len =3D is_ed ? pke_eddsa_key_len(req.curve) : 2 * clen;
+
+       pk_buf =3D kzalloc(pk_len, GFP_KERNEL);
+       if (!pk_buf)
+               return -ENOMEM;
+
+       pk_dma =3D cmh_dma_map_single(pk_buf, pk_len, DMA_FROM_DEVICE);
+       if (cmh_dma_map_error(pk_dma)) {
+               kfree(pk_buf);
+               return -ENOMEM;
+       }
+
+       vcq_set_header(&vcq[0], PKE_VCQ_CMDS_MIN);
+       if (is_ed)
+               vcq_add_pke_eddsa_pubgen(&vcq[1], pke_cid, req.curve,
+                                        pke_eddsa_key_len(req.curve),
+                                        pk_dma, req.key_ref,
+                                        pke_swap_flags(req.curve));
+       else
+               vcq_add_pke_ecdsa_pubgen(&vcq[1], pke_cid, req.curve, clen,
+                                        pk_dma, req.key_ref,
+                                        pke_swap_flags(req.curve));
+       vcq_add_pke_flush(&vcq[2], pke_cid);
+
+       ret =3D cmh_tm_submit_sync_mbx(vcq, PKE_VCQ_CMDS_MIN, 1, MGMT_MBX);
+
+       cmh_dma_unmap_single(pk_dma, pk_len, DMA_FROM_DEVICE);
+
+       if (!ret) {
+               if (copy_to_user(u64_to_user_ptr(req.public_key),
+                                pk_buf, pk_len))
+                       ret =3D -EFAULT;
+       }
+
+       kfree(pk_buf);
+       return ret;
+}
+
+/**
+ * cmh_mgmt_pke_eddsa_keygen_sca() - Handle CMH_MGMT_IOC_PKE_EDDSA_KEYGEN_=
SCA ioctl
+ * @argp: User-space ioctl argument pointer
+ *
+ * Return: 0 on success, negative errno on failure.
+ */
+int cmh_mgmt_pke_eddsa_keygen_sca(void __user *argp)
+{
+       u32 pke_cid =3D cmh_core_default_id(CMH_CORE_PKE);
+
+       struct cmh_ioctl_pke_eddsa_keygen_sca req;
+       /* header + SYS_NEW + EDDSA_KEYGEN_SCA + flush_pke + flush_sys */
+       struct vcq_cmd vcq[5];
+       u64 *ref_buf;
+       dma_addr_t ref_dma;
+       int ret;
+
+       if (copy_from_user(&req, argp, sizeof(req)))
+               return -EFAULT;
+       if (req.version !=3D CMH_MGMT_V1)
+               return -EINVAL;
+       /* EdDSA SCA keygen is only supported for Ed448 */
+       if (req.curve !=3D PKE_CURVE_448)
+               return -EINVAL;
+
+       ref_buf =3D kzalloc_obj(u64, GFP_KERNEL);
+       if (!ref_buf)
+               return -ENOMEM;
+
+       ref_dma =3D cmh_dma_map_single(ref_buf, sizeof(u64), DMA_FROM_DEVIC=
E);
+       if (cmh_dma_map_error(ref_dma)) {
+               kfree(ref_buf);
+               return -ENOMEM;
+       }
+
+       vcq_set_header(&vcq[0], 5);
+       vcq_add_sys_new(&vcq[1], req.cid, ref_dma, PKE_ED448_SK_SCA_LEN);
+       vcq_add_pke_eddsa_keygen_sca(&vcq[2], pke_cid, req.curve, req.key_r=
ef,
+                                    SYS_REF_LAST);
+       vcq_add_pke_flush(&vcq[3], pke_cid);
+       vcq_add_sys_flush(&vcq[4]);
+
+       ret =3D cmh_tm_submit_sync_mbx(vcq, 5, 1, MGMT_MBX);
+
+       cmh_dma_unmap_single(ref_dma, sizeof(u64), DMA_FROM_DEVICE);
+
+       if (!ret) {
+               req.sca_ref =3D *ref_buf;
+               if (copy_to_user(argp, &req, sizeof(req)))
+                       ret =3D -EFAULT;
+       }
+
+       kfree(ref_buf);
+       return ret;
+}
diff --git a/drivers/crypto/cmh/cmh_mgmt_pqc.c b/drivers/crypto/cmh/cmh_mgm=
t_pqc.c
new file mode 100644
index 000000000000..db479e80326b
--- /dev/null
+++ b/drivers/crypto/cmh/cmh_mgmt_pqc.c
@@ -0,0 +1,1279 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2026 Cryptography Research, Inc. (CRI).
+ * CMH -- PQC ioctl handlers for /dev/cmh_mgmt
+ *
+ * ML-KEM keygen/encapsulate/decapsulate, ML-DSA keygen/sign,
+ * SLH-DSA keygen/sign (pure + prehash).
+ *
+ * Split from cmh_mgmt.c for maintainability.
+ */
+
+#include <linux/kernel.h>
+#include <linux/uaccess.h>
+#include <linux/slab.h>
+#include <linux/overflow.h>
+
+#include "cmh_mgmt.h"
+#include "cmh_sys.h"
+#include "cmh_txn.h"
+#include "cmh_key.h"
+#include "cmh_dma.h"
+#include "cmh_config.h"
+#include "cmh_pqc.h"
+#include "cmh_qse_abi.h"
+#include "cmh_sys_abi.h"
+#include <uapi/linux/cmh_mgmt_ioctl.h>
+
+#include <crypto/utils.h>
+
+/* -- PQC -- ML-KEM -- */
+
+/**
+ * cmh_mgmt_ml_kem_keygen() - Handle CMH_MGMT_IOC_ML_KEM_KEYGEN ioctl
+ * @argp: User-space ioctl argument pointer
+ *
+ * Return: 0 on success, negative errno on failure.
+ */
+int cmh_mgmt_ml_kem_keygen(void __user *argp)
+{
+       u32 qse_cid =3D cmh_core_default_id(CMH_CORE_QSE);
+
+       struct cmh_ioctl_ml_kem_keygen req;
+       struct vcq_cmd vcq[QSE_VCQ_CMDS_MAX];
+       u32 ek_len, dk_len, seed_len, key_flags;
+       u32 qse_flags =3D 0;
+       bool masked, ds_ref, hw_rng;
+       u8 *seed_buf =3D NULL, *z_buf =3D NULL, *ek_buf, *dk_buf =3D NULL;
+       u64 *ref_buf =3D NULL;
+       dma_addr_t seed_dma =3D DMA_MAPPING_ERROR, z_dma =3D DMA_MAPPING_ER=
ROR;
+       dma_addr_t ek_dma, dk_dma =3D DMA_MAPPING_ERROR, ref_dma =3D DMA_MA=
PPING_ERROR;
+       int ret, idx;
+
+       if (copy_from_user(&req, argp, sizeof(req)))
+               return -EFAULT;
+       if (req.version !=3D CMH_MGMT_V1)
+               return -EINVAL;
+       if (req.__reserved)
+               return -EINVAL;
+       if (ml_kem_k_idx(req.k) < 0)
+               return -EINVAL;
+       if (req.flags & ~(CMH_QSE_FLAG_MASK | CMH_FLAG_MASK))
+               return -EINVAL;
+
+       masked =3D !!(req.flags & CMH_QSE_FLAG_MASKED);
+       ds_ref =3D !!(req.flags & CMH_QSE_FLAG_DS_REF);
+       hw_rng =3D !!(req.flags & CMH_QSE_FLAG_HW_RNG);
+
+       /*
+        * QSE keys only support PT storage -- the eSW dec/sign paths
+        * hardcode SYS_TYPE_FLAG_PT when reading the key back.
+        * QSE SCA protection uses masking (CMH_QSE_FLAG_MASKED),
+        * not the 2-share mechanism (CMH_FLAG_SCA).
+        */
+       key_flags =3D req.flags & CMH_FLAG_MASK;
+       if (key_flags && key_flags !=3D CMH_FLAG_PT)
+               return -EINVAL;
+       key_flags =3D CMH_FLAG_PT;
+
+       /* Masked keygen must store dk in DS -- polynomial unmasking not su=
pported */
+       if (masked && !ds_ref)
+               return -EINVAL;
+
+       ek_len =3D ML_KEM_EK_SIZE(req.k);
+       dk_len =3D masked ? ML_KEM_DK_SIZE_MASKED(req.k)
+                       : ML_KEM_DK_SIZE(req.k);
+       seed_len =3D masked ? QSE_SEED_LEN_MASKED : QSE_SEED_LEN;
+
+       if (hw_rng)
+               qse_flags |=3D QSE_FLAG_USE_RNG;
+       if (ds_ref)
+               qse_flags |=3D QSE_FLAG_USE_REF;
+
+       ek_buf =3D kzalloc(ek_len, GFP_KERNEL);
+       if (!ek_buf)
+               return -ENOMEM;
+
+       if (!hw_rng && req.seed && req.z) {
+               seed_buf =3D kmalloc(seed_len, GFP_KERNEL);
+               z_buf =3D kmalloc(seed_len, GFP_KERNEL);
+               if (!seed_buf || !z_buf) {
+                       ret =3D -ENOMEM;
+                       goto out_free;
+               }
+               if (copy_from_user(seed_buf, u64_to_user_ptr(req.seed),
+                                  seed_len) ||
+                   copy_from_user(z_buf, u64_to_user_ptr(req.z), seed_len)=
) {
+                       ret =3D -EFAULT;
+                       goto out_free;
+               }
+       }
+
+       if (ds_ref) {
+               ref_buf =3D kzalloc_obj(u64, GFP_KERNEL);
+               if (!ref_buf) {
+                       ret =3D -ENOMEM;
+                       goto out_free;
+               }
+       } else {
+               dk_buf =3D kzalloc(dk_len, GFP_KERNEL);
+               if (!dk_buf) {
+                       ret =3D -ENOMEM;
+                       goto out_free;
+               }
+       }
+
+       /* DMA map */
+       ek_dma =3D cmh_dma_map_single(ek_buf, ek_len, DMA_FROM_DEVICE);
+       if (cmh_dma_map_error(ek_dma)) {
+               ret =3D -ENOMEM;
+               goto out_free;
+       }
+
+       if (seed_buf) {
+               seed_dma =3D cmh_dma_map_single(seed_buf, seed_len,
+                                             DMA_TO_DEVICE);
+               z_dma =3D cmh_dma_map_single(z_buf, seed_len, DMA_TO_DEVICE=
);
+               if (cmh_dma_map_error(seed_dma) || cmh_dma_map_error(z_dma)=
) {
+                       ret =3D -ENOMEM;
+                       goto out_unmap;
+               }
+       }
+
+       if (ds_ref) {
+               ref_dma =3D cmh_dma_map_single(ref_buf, sizeof(u64),
+                                            DMA_FROM_DEVICE);
+               if (cmh_dma_map_error(ref_dma)) {
+                       ret =3D -ENOMEM;
+                       goto out_unmap;
+               }
+       } else {
+               dk_dma =3D cmh_dma_map_single(dk_buf, dk_len, DMA_FROM_DEVI=
CE);
+               if (cmh_dma_map_error(dk_dma)) {
+                       ret =3D -ENOMEM;
+                       goto out_unmap;
+               }
+       }
+
+       idx =3D 0;
+       if (ds_ref) {
+               vcq_set_header(&vcq[0], QSE_VCQ_CMDS_MAX);
+               idx++;
+               vcq_add_sys_new(&vcq[idx++], req.dk_cid, ref_dma, dk_len);
+               vcq_add_qse_ml_kem_keygen(&vcq[idx++], qse_cid, req.k, qse_=
flags,
+                                         seed_dma, z_dma,
+                                         ek_dma, SYS_REF_LAST,
+                                         SYS_TYPE_SET(key_flags,
+                                                      CORE_ID_QSE),
+                                         masked);
+               vcq_add_qse_flush(&vcq[idx++], qse_cid);
+               ret =3D cmh_tm_submit_sync_mbx(vcq, QSE_VCQ_CMDS_MAX,
+                                            1, MGMT_MBX);
+       } else {
+               vcq_set_header(&vcq[0], QSE_VCQ_CMDS_MIN);
+               idx++;
+               vcq_add_qse_ml_kem_keygen(&vcq[idx++], qse_cid, req.k, qse_=
flags,
+                                         seed_dma, z_dma,
+                                         ek_dma, dk_dma, 0, masked);
+               vcq_add_qse_flush(&vcq[idx++], qse_cid);
+               ret =3D cmh_tm_submit_sync_mbx(vcq, QSE_VCQ_CMDS_MIN,
+                                            1, MGMT_MBX);
+       }
+
+out_unmap:
+       if (ds_ref && !cmh_dma_map_error(ref_dma))
+               cmh_dma_unmap_single(ref_dma, sizeof(u64), DMA_FROM_DEVICE)=
;
+       if (!ds_ref && dk_buf && !cmh_dma_map_error(dk_dma))
+               cmh_dma_unmap_single(dk_dma, dk_len, DMA_FROM_DEVICE);
+       if (z_buf && !cmh_dma_map_error(z_dma))
+               cmh_dma_unmap_single(z_dma, seed_len, DMA_TO_DEVICE);
+       if (seed_buf && !cmh_dma_map_error(seed_dma))
+               cmh_dma_unmap_single(seed_dma, seed_len, DMA_TO_DEVICE);
+       if (!cmh_dma_map_error(ek_dma))
+               cmh_dma_unmap_single(ek_dma, ek_len, DMA_FROM_DEVICE);
+
+       if (!ret) {
+               if (copy_to_user(u64_to_user_ptr(req.ek), ek_buf, ek_len)) =
{
+                       ret =3D -EFAULT;
+                       goto out_free;
+               }
+               if (ds_ref) {
+                       req.dk_ref =3D *ref_buf;
+               } else {
+                       if (copy_to_user(u64_to_user_ptr(req.dk),
+                                        dk_buf, dk_len)) {
+                               ret =3D -EFAULT;
+                               goto out_free;
+                       }
+               }
+               if (copy_to_user(argp, &req, sizeof(req)))
+                       ret =3D -EFAULT;
+       }
+
+out_free:
+       kfree_sensitive(dk_buf);
+       kfree(ref_buf);
+       kfree_sensitive(z_buf);
+       kfree_sensitive(seed_buf);
+       kfree(ek_buf);
+       return ret;
+}
+
+/**
+ * cmh_mgmt_ml_kem_enc() - Handle CMH_MGMT_IOC_ML_KEM_ENC ioctl
+ * @argp: User-space ioctl argument pointer
+ *
+ * Return: 0 on success, negative errno on failure.
+ */
+int cmh_mgmt_ml_kem_enc(void __user *argp)
+{
+       u32 qse_cid =3D cmh_core_default_id(CMH_CORE_QSE);
+
+       struct cmh_ioctl_ml_kem_enc req;
+       struct vcq_cmd vcq[QSE_VCQ_CMDS_MIN];
+       u32 ek_len, ct_len, ss_out_len;
+       u32 qse_flags =3D 0;
+       bool masked, hw_rng;
+       u8 *ek_buf, *coin_buf =3D NULL, *ct_buf, *ss_buf;
+       dma_addr_t ek_dma, coin_dma =3D DMA_MAPPING_ERROR, ct_dma, ss_dma;
+       int ret;
+
+       if (copy_from_user(&req, argp, sizeof(req)))
+               return -EFAULT;
+       if (req.version !=3D CMH_MGMT_V1)
+               return -EINVAL;
+       if (req.__reserved || req.__reserved2[0] || req.__reserved2[1])
+               return -EINVAL;
+       if (ml_kem_k_idx(req.k) < 0)
+               return -EINVAL;
+
+       masked =3D !!(req.flags & CMH_QSE_FLAG_MASKED);
+       hw_rng =3D !!(req.flags & CMH_QSE_FLAG_HW_RNG);
+
+       ek_len =3D ML_KEM_EK_SIZE(req.k);
+       ct_len =3D ML_KEM_CT_SIZE(req.k);
+       ss_out_len =3D masked ? ML_KEM_SS_LEN_MASKED : ML_KEM_SS_LEN;
+
+       if (hw_rng)
+               qse_flags |=3D QSE_FLAG_USE_RNG;
+
+       ek_buf =3D kmalloc(ek_len, GFP_KERNEL);
+       ct_buf =3D kzalloc(ct_len, GFP_KERNEL);
+       ss_buf =3D kzalloc(ss_out_len, GFP_KERNEL);
+       if (!ek_buf || !ct_buf || !ss_buf) {
+               ret =3D -ENOMEM;
+               goto out_free;
+       }
+
+       if (copy_from_user(ek_buf, u64_to_user_ptr(req.ek), ek_len)) {
+               ret =3D -EFAULT;
+               goto out_free;
+       }
+
+       if (!hw_rng && req.coin) {
+               u32 coin_len =3D masked ? QSE_SEED_LEN_MASKED : QSE_SEED_LE=
N;
+
+               coin_buf =3D kmalloc(coin_len, GFP_KERNEL);
+               if (!coin_buf) {
+                       ret =3D -ENOMEM;
+                       goto out_free;
+               }
+               if (copy_from_user(coin_buf, u64_to_user_ptr(req.coin),
+                                  coin_len)) {
+                       ret =3D -EFAULT;
+                       goto out_free;
+               }
+               coin_dma =3D cmh_dma_map_single(coin_buf, coin_len,
+                                             DMA_TO_DEVICE);
+               if (cmh_dma_map_error(coin_dma)) {
+                       ret =3D -ENOMEM;
+                       goto out_free;
+               }
+       }
+
+       ek_dma =3D cmh_dma_map_single(ek_buf, ek_len, DMA_TO_DEVICE);
+       ct_dma =3D cmh_dma_map_single(ct_buf, ct_len, DMA_FROM_DEVICE);
+       ss_dma =3D cmh_dma_map_single(ss_buf, ss_out_len, DMA_FROM_DEVICE);
+       if (cmh_dma_map_error(ek_dma) || cmh_dma_map_error(ct_dma) ||
+           cmh_dma_map_error(ss_dma)) {
+               ret =3D -ENOMEM;
+               goto out_unmap;
+       }
+
+       vcq_set_header(&vcq[0], QSE_VCQ_CMDS_MIN);
+       vcq_add_qse_ml_kem_enc(&vcq[1], qse_cid, req.k, qse_flags,
+                              coin_dma, ek_dma, ct_dma, ss_dma, 0, masked)=
;
+       vcq_add_qse_flush(&vcq[2], qse_cid);
+
+       ret =3D cmh_tm_submit_sync_mbx(vcq, QSE_VCQ_CMDS_MIN, 1, MGMT_MBX);
+
+out_unmap:
+       if (!cmh_dma_map_error(ss_dma))
+               cmh_dma_unmap_single(ss_dma, ss_out_len, DMA_FROM_DEVICE);
+       if (!cmh_dma_map_error(ct_dma))
+               cmh_dma_unmap_single(ct_dma, ct_len, DMA_FROM_DEVICE);
+       if (!cmh_dma_map_error(ek_dma))
+               cmh_dma_unmap_single(ek_dma, ek_len, DMA_TO_DEVICE);
+       if (coin_buf && !cmh_dma_map_error(coin_dma))
+               cmh_dma_unmap_single(coin_dma,
+                                    masked ? QSE_SEED_LEN_MASKED
+                                           : QSE_SEED_LEN,
+                                    DMA_TO_DEVICE);
+
+       if (!ret) {
+               if (copy_to_user(u64_to_user_ptr(req.ct), ct_buf, ct_len)) =
{
+                       ret =3D -EFAULT;
+                       goto out_free;
+               }
+               /* Unmask ss if masked: ss =3D share0 ^ share1 */
+               if (masked) {
+                       crypto_xor(ss_buf, ss_buf + ML_KEM_SS_LEN,
+                                  ML_KEM_SS_LEN);
+               }
+               if (copy_to_user(u64_to_user_ptr(req.ss), ss_buf,
+                                ML_KEM_SS_LEN)) {
+                       ret =3D -EFAULT;
+                       goto out_free;
+               }
+               if (copy_to_user(argp, &req, sizeof(req)))
+                       ret =3D -EFAULT;
+       }
+
+out_free:
+       kfree_sensitive(ss_buf);
+       kfree(ct_buf);
+       kfree(coin_buf);
+       kfree(ek_buf);
+       return ret;
+}
+
+/**
+ * cmh_mgmt_ml_kem_dec() - Handle CMH_MGMT_IOC_ML_KEM_DEC ioctl
+ * @argp: User-space ioctl argument pointer
+ *
+ * Return: 0 on success, negative errno on failure.
+ */
+int cmh_mgmt_ml_kem_dec(void __user *argp)
+{
+       u32 qse_cid =3D cmh_core_default_id(CMH_CORE_QSE);
+
+       struct cmh_ioctl_ml_kem_dec req;
+       struct vcq_cmd vcq[QSE_VCQ_CMDS_MIN];
+       u32 ct_len, dk_len, ss_out_len;
+       u32 qse_flags =3D 0;
+       bool masked, ds_ref;
+       u8 *ct_buf, *dk_buf =3D NULL, *ss_buf;
+       dma_addr_t ct_dma, dk_dma =3D DMA_MAPPING_ERROR, ss_dma;
+       u64 dk_ref;
+       int ret;
+
+       if (copy_from_user(&req, argp, sizeof(req)))
+               return -EFAULT;
+       if (req.version !=3D CMH_MGMT_V1)
+               return -EINVAL;
+       if (req.__reserved || req.__reserved2[0] || req.__reserved2[1])
+               return -EINVAL;
+       if (ml_kem_k_idx(req.k) < 0)
+               return -EINVAL;
+
+       masked =3D !!(req.flags & CMH_QSE_FLAG_MASKED);
+       ds_ref =3D !!(req.flags & CMH_QSE_FLAG_DS_REF);
+
+       ct_len =3D ML_KEM_CT_SIZE(req.k);
+       dk_len =3D masked ? ML_KEM_DK_SIZE_MASKED(req.k)
+                       : ML_KEM_DK_SIZE(req.k);
+       ss_out_len =3D masked ? ML_KEM_SS_LEN_MASKED : ML_KEM_SS_LEN;
+
+       ct_buf =3D kmalloc(ct_len, GFP_KERNEL);
+       ss_buf =3D kzalloc(ss_out_len, GFP_KERNEL);
+       if (!ct_buf || !ss_buf) {
+               ret =3D -ENOMEM;
+               goto out_free;
+       }
+
+       if (copy_from_user(ct_buf, u64_to_user_ptr(req.ct), ct_len)) {
+               ret =3D -EFAULT;
+               goto out_free;
+       }
+
+       ct_dma =3D cmh_dma_map_single(ct_buf, ct_len, DMA_TO_DEVICE);
+       ss_dma =3D cmh_dma_map_single(ss_buf, ss_out_len, DMA_FROM_DEVICE);
+       if (cmh_dma_map_error(ct_dma) || cmh_dma_map_error(ss_dma)) {
+               ret =3D -ENOMEM;
+               goto out_unmap;
+       }
+
+       /*
+        * dk: if DS_REF flag is set, req.dk is a DS reference.
+        * Otherwise, copy raw dk from user-space and use extmem DMA.
+        * Masked decaps requires DS ref (polynomial unmasking not supporte=
d).
+        */
+       if (ds_ref) {
+               dk_ref =3D req.dk;
+               qse_flags |=3D QSE_FLAG_USE_REF;
+       } else {
+               if (masked) {
+                       ret =3D -EINVAL;
+                       goto out_unmap;
+               }
+               dk_buf =3D kmalloc(dk_len, GFP_KERNEL);
+               if (!dk_buf) {
+                       ret =3D -ENOMEM;
+                       goto out_unmap;
+               }
+               if (copy_from_user(dk_buf, u64_to_user_ptr(req.dk), dk_len)=
) {
+                       ret =3D -EFAULT;
+                       goto out_unmap;
+               }
+               dk_dma =3D cmh_dma_map_single(dk_buf, dk_len, DMA_TO_DEVICE=
);
+               if (cmh_dma_map_error(dk_dma)) {
+                       ret =3D -ENOMEM;
+                       goto out_unmap;
+               }
+               dk_ref =3D dk_dma;
+       }
+
+       if (ds_ref) {
+               /*
+                * DS_REF decaps: CMH eSW resolves both dk and ss from DS.
+                * Phase 1: dec stores ss into SYS_REF_TEMP.
+                * Phase 2: sys_data reads ss from SYS_REF_TEMP to DMA.
+                */
+               vcq_set_header(&vcq[0], QSE_VCQ_CMDS_MIN);
+               vcq_add_qse_ml_kem_dec(&vcq[1], qse_cid, req.k, qse_flags,
+                                      ct_dma, dk_ref, SYS_REF_TEMP,
+                                      SYS_TYPE_SET(SYS_TYPE_FLAG_PT,
+                                                   CORE_ID_QSE),
+                                      masked);
+               vcq_add_qse_flush(&vcq[2], qse_cid);
+
+               ret =3D cmh_tm_submit_sync_mbx(vcq, QSE_VCQ_CMDS_MIN,
+                                            1, MGMT_MBX);
+               if (ret)
+                       goto out_unmap;
+
+               /* Phase 2: extract ss from SYS_REF_TEMP */
+               vcq_set_header(&vcq[0], QSE_VCQ_CMDS_MIN);
+               vcq_add_sys_data(&vcq[1], SYS_REF_TEMP, ss_dma,
+                                ss_out_len);
+               vcq_add_sys_flush(&vcq[2]);
+
+               ret =3D cmh_tm_submit_sync_mbx(vcq, QSE_VCQ_CMDS_MIN,
+                                            1, MGMT_MBX);
+       } else {
+               vcq_set_header(&vcq[0], QSE_VCQ_CMDS_MIN);
+               vcq_add_qse_ml_kem_dec(&vcq[1], qse_cid, req.k, qse_flags,
+                                      ct_dma, dk_ref, ss_dma, 0, masked);
+               vcq_add_qse_flush(&vcq[2], qse_cid);
+
+               ret =3D cmh_tm_submit_sync_mbx(vcq, QSE_VCQ_CMDS_MIN,
+                                            1, MGMT_MBX);
+       }
+
+out_unmap:
+       if (dk_buf && !cmh_dma_map_error(dk_dma))
+               cmh_dma_unmap_single(dk_dma, dk_len, DMA_TO_DEVICE);
+       if (!cmh_dma_map_error(ss_dma))
+               cmh_dma_unmap_single(ss_dma, ss_out_len, DMA_FROM_DEVICE);
+       if (!cmh_dma_map_error(ct_dma))
+               cmh_dma_unmap_single(ct_dma, ct_len, DMA_TO_DEVICE);
+
+       if (!ret) {
+               if (masked) {
+                       crypto_xor(ss_buf, ss_buf + ML_KEM_SS_LEN,
+                                  ML_KEM_SS_LEN);
+               }
+               if (copy_to_user(u64_to_user_ptr(req.ss), ss_buf,
+                                ML_KEM_SS_LEN)) {
+                       ret =3D -EFAULT;
+                       goto out_free;
+               }
+               if (copy_to_user(argp, &req, sizeof(req)))
+                       ret =3D -EFAULT;
+       }
+
+out_free:
+       kfree_sensitive(dk_buf);
+       kfree_sensitive(ss_buf);
+       kfree(ct_buf);
+       return ret;
+}
+
+/* -- PQC -- ML-DSA -- */
+
+/**
+ * cmh_mgmt_ml_dsa_keygen() - Handle CMH_MGMT_IOC_ML_DSA_KEYGEN ioctl
+ * @argp: User-space ioctl argument pointer
+ *
+ * Return: 0 on success, negative errno on failure.
+ */
+int cmh_mgmt_ml_dsa_keygen(void __user *argp)
+{
+       u32 qse_cid =3D cmh_core_default_id(CMH_CORE_QSE);
+
+       struct cmh_ioctl_ml_dsa_keygen req;
+       struct vcq_cmd vcq[QSE_VCQ_CMDS_MAX];
+       u32 pk_size, sk_size, seed_len, key_flags;
+       u32 qse_flags =3D 0;
+       bool masked, ds_ref, hw_rng;
+       u8 *seed_buf =3D NULL, *pk_buf, *sk_buf =3D NULL;
+       u64 *ref_buf =3D NULL;
+       dma_addr_t seed_dma =3D DMA_MAPPING_ERROR, pk_dma;
+       dma_addr_t sk_dma =3D DMA_MAPPING_ERROR, ref_dma =3D DMA_MAPPING_ER=
ROR;
+       int ret, idx, mi;
+
+       if (copy_from_user(&req, argp, sizeof(req)))
+               return -EFAULT;
+       if (req.version !=3D CMH_MGMT_V1)
+               return -EINVAL;
+       if (req.__reserved)
+               return -EINVAL;
+       mi =3D ml_dsa_mode_idx(req.mode);
+       if (mi < 0)
+               return -EINVAL;
+       if (req.flags & ~(CMH_QSE_FLAG_MASK | CMH_FLAG_MASK))
+               return -EINVAL;
+
+       masked =3D !!(req.flags & CMH_QSE_FLAG_MASKED);
+       ds_ref =3D !!(req.flags & CMH_QSE_FLAG_DS_REF);
+       hw_rng =3D !!(req.flags & CMH_QSE_FLAG_HW_RNG);
+
+       /*
+        * QSE keys only support PT storage -- the eSW sign path
+        * hardcodes SYS_TYPE_FLAG_PT when reading the key back.
+        * QSE SCA protection uses masking (CMH_QSE_FLAG_MASKED),
+        * not the 2-share mechanism (CMH_FLAG_SCA).
+        */
+       key_flags =3D req.flags & CMH_FLAG_MASK;
+       if (key_flags && key_flags !=3D CMH_FLAG_PT)
+               return -EINVAL;
+       key_flags =3D CMH_FLAG_PT;
+
+       if (masked && !ds_ref)
+               return -EINVAL;
+
+       pk_size =3D ml_dsa_pk_size[mi];
+       sk_size =3D masked ? ml_dsa_sk_size_masked[mi] : ml_dsa_sk_size[mi]=
;
+       seed_len =3D masked ? QSE_SEED_LEN_MASKED : QSE_SEED_LEN;
+
+       if (hw_rng)
+               qse_flags |=3D QSE_FLAG_USE_RNG;
+       if (ds_ref)
+               qse_flags |=3D QSE_FLAG_USE_REF;
+
+       pk_buf =3D kzalloc(pk_size, GFP_KERNEL);
+       if (!pk_buf)
+               return -ENOMEM;
+
+       if (!hw_rng && req.seed) {
+               seed_buf =3D kmalloc(seed_len, GFP_KERNEL);
+               if (!seed_buf) {
+                       ret =3D -ENOMEM;
+                       goto out_free;
+               }
+               if (copy_from_user(seed_buf, u64_to_user_ptr(req.seed),
+                                  seed_len)) {
+                       ret =3D -EFAULT;
+                       goto out_free;
+               }
+       }
+
+       if (ds_ref) {
+               ref_buf =3D kzalloc_obj(u64, GFP_KERNEL);
+               if (!ref_buf) {
+                       ret =3D -ENOMEM;
+                       goto out_free;
+               }
+       } else {
+               sk_buf =3D kzalloc(sk_size, GFP_KERNEL);
+               if (!sk_buf) {
+                       ret =3D -ENOMEM;
+                       goto out_free;
+               }
+       }
+
+       pk_dma =3D cmh_dma_map_single(pk_buf, pk_size, DMA_FROM_DEVICE);
+       if (cmh_dma_map_error(pk_dma)) {
+               ret =3D -ENOMEM;
+               goto out_free;
+       }
+
+       if (seed_buf) {
+               seed_dma =3D cmh_dma_map_single(seed_buf, seed_len,
+                                             DMA_TO_DEVICE);
+               if (cmh_dma_map_error(seed_dma)) {
+                       ret =3D -ENOMEM;
+                       goto out_unmap;
+               }
+       }
+
+       if (ds_ref) {
+               ref_dma =3D cmh_dma_map_single(ref_buf, sizeof(u64),
+                                            DMA_FROM_DEVICE);
+               if (cmh_dma_map_error(ref_dma)) {
+                       ret =3D -ENOMEM;
+                       goto out_unmap;
+               }
+       } else {
+               sk_dma =3D cmh_dma_map_single(sk_buf, sk_size, DMA_FROM_DEV=
ICE);
+               if (cmh_dma_map_error(sk_dma)) {
+                       ret =3D -ENOMEM;
+                       goto out_unmap;
+               }
+       }
+
+       idx =3D 0;
+       if (ds_ref) {
+               vcq_set_header(&vcq[0], QSE_VCQ_CMDS_MAX);
+               idx++;
+               vcq_add_sys_new(&vcq[idx++], req.sk_cid, ref_dma, sk_size);
+               vcq_add_qse_ml_dsa_keygen(&vcq[idx++], qse_cid, req.mode, q=
se_flags,
+                                         seed_dma, pk_dma,
+                                         SYS_REF_LAST,
+                                         SYS_TYPE_SET(key_flags,
+                                                      CORE_ID_QSE),
+                                         masked);
+               vcq_add_qse_flush(&vcq[idx++], qse_cid);
+               ret =3D cmh_tm_submit_sync_mbx(vcq, QSE_VCQ_CMDS_MAX,
+                                            1, MGMT_MBX);
+       } else {
+               vcq_set_header(&vcq[0], QSE_VCQ_CMDS_MIN);
+               idx++;
+               vcq_add_qse_ml_dsa_keygen(&vcq[idx++], qse_cid, req.mode, q=
se_flags,
+                                         seed_dma, pk_dma,
+                                         sk_dma, 0, masked);
+               vcq_add_qse_flush(&vcq[idx++], qse_cid);
+               ret =3D cmh_tm_submit_sync_mbx(vcq, QSE_VCQ_CMDS_MIN,
+                                            1, MGMT_MBX);
+       }
+
+out_unmap:
+       if (ds_ref && !cmh_dma_map_error(ref_dma))
+               cmh_dma_unmap_single(ref_dma, sizeof(u64), DMA_FROM_DEVICE)=
;
+       if (!ds_ref && sk_buf && !cmh_dma_map_error(sk_dma))
+               cmh_dma_unmap_single(sk_dma, sk_size, DMA_FROM_DEVICE);
+       if (seed_buf && !cmh_dma_map_error(seed_dma))
+               cmh_dma_unmap_single(seed_dma, seed_len, DMA_TO_DEVICE);
+       if (!cmh_dma_map_error(pk_dma))
+               cmh_dma_unmap_single(pk_dma, pk_size, DMA_FROM_DEVICE);
+
+       if (!ret) {
+               if (copy_to_user(u64_to_user_ptr(req.pk), pk_buf, pk_size))=
 {
+                       ret =3D -EFAULT;
+                       goto out_free;
+               }
+               if (ds_ref) {
+                       req.sk_ref =3D *ref_buf;
+               } else {
+                       if (copy_to_user(u64_to_user_ptr(req.sk),
+                                        sk_buf, sk_size)) {
+                               ret =3D -EFAULT;
+                               goto out_free;
+                       }
+               }
+               if (copy_to_user(argp, &req, sizeof(req)))
+                       ret =3D -EFAULT;
+       }
+
+out_free:
+       kfree_sensitive(sk_buf);
+       kfree(ref_buf);
+       kfree_sensitive(seed_buf);
+       kfree(pk_buf);
+       return ret;
+}
+
+/**
+ * cmh_mgmt_ml_dsa_sign() - Handle CMH_MGMT_IOC_ML_DSA_SIGN ioctl
+ * @argp: User-space ioctl argument pointer
+ *
+ * Return: 0 on success, negative errno on failure.
+ */
+int cmh_mgmt_ml_dsa_sign(void __user *argp)
+{
+       u32 qse_cid =3D cmh_core_default_id(CMH_CORE_QSE);
+
+       struct cmh_ioctl_ml_dsa_sign req;
+       struct vcq_cmd vcq[QSE_VCQ_CMDS_MIN];
+       u32 sig_size, copy_len, rnd_len;
+       u32 qse_flags =3D 0;
+       bool masked;
+       u8 *m_buf, *sig_buf, *sk_buf =3D NULL, *rnd_buf =3D NULL;
+       dma_addr_t m_dma =3D DMA_MAPPING_ERROR, sig_dma;
+       dma_addr_t sk_dma =3D DMA_MAPPING_ERROR, rnd_dma =3D DMA_MAPPING_ER=
ROR;
+       u64 sk_ref;
+       int mi, ret;
+
+       if (copy_from_user(&req, argp, sizeof(req)))
+               return -EFAULT;
+       if (req.version !=3D CMH_MGMT_V1)
+               return -EINVAL;
+       mi =3D ml_dsa_mode_idx(req.mode);
+       if (mi < 0)
+               return -EINVAL;
+       if (req.mlen > ML_DSA_MAX_MLEN && req.mlen !=3D ML_DSA_MLEN_EXTERNA=
L_MU)
+               return -EINVAL;
+
+       masked =3D !!(req.flags & CMH_QSE_FLAG_MASKED);
+       rnd_len =3D masked ? QSE_SEED_LEN_MASKED : QSE_SEED_LEN;
+       sig_size =3D ml_dsa_sig_size[mi];
+       copy_len =3D (req.mlen =3D=3D ML_DSA_MLEN_EXTERNAL_MU)
+                       ? ML_DSA_EXTMU_LEN : req.mlen;
+
+       /*
+        * sk: if DS_REF, req.sk is a DS reference (masked sk lives in DS).
+        * Otherwise, copy raw sk from user-space.
+        * Masked sign requires DS ref (polynomial unmasking not supported)=
.
+        */
+       if (req.flags & CMH_QSE_FLAG_DS_REF) {
+               sk_ref =3D req.sk;
+               qse_flags |=3D QSE_FLAG_USE_REF;
+       } else {
+               u32 sk_size;
+
+               if (masked)
+                       return -EINVAL;
+               sk_size =3D ml_dsa_sk_size[mi];
+               sk_buf =3D kmalloc(sk_size, GFP_KERNEL);
+               if (!sk_buf)
+                       return -ENOMEM;
+               if (copy_from_user(sk_buf, u64_to_user_ptr(req.sk), sk_size=
)) {
+                       kfree_sensitive(sk_buf);
+                       return -EFAULT;
+               }
+       }
+
+       m_buf =3D kmalloc(max_t(u32, copy_len, 1), GFP_KERNEL);
+       sig_buf =3D kzalloc(sig_size, GFP_KERNEL);
+       if (!m_buf || !sig_buf) {
+               ret =3D -ENOMEM;
+               goto out_free;
+       }
+
+       if (copy_len > 0 &&
+           copy_from_user(m_buf, u64_to_user_ptr(req.m), copy_len)) {
+               ret =3D -EFAULT;
+               goto out_free;
+       }
+
+       if (req.rnd) {
+               rnd_buf =3D kmalloc(rnd_len, GFP_KERNEL);
+               if (!rnd_buf) {
+                       ret =3D -ENOMEM;
+                       goto out_free;
+               }
+               if (copy_from_user(rnd_buf, u64_to_user_ptr(req.rnd),
+                                  rnd_len)) {
+                       ret =3D -EFAULT;
+                       goto out_free;
+               }
+       }
+
+       if (copy_len > 0) {
+               m_dma =3D cmh_dma_map_single(m_buf, copy_len, DMA_TO_DEVICE=
);
+               if (cmh_dma_map_error(m_dma)) {
+                       ret =3D -ENOMEM;
+                       goto out_unmap;
+               }
+       }
+       sig_dma =3D cmh_dma_map_single(sig_buf, sig_size, DMA_FROM_DEVICE);
+       if (cmh_dma_map_error(sig_dma)) {
+               ret =3D -ENOMEM;
+               goto out_unmap;
+       }
+
+       if (sk_buf) {
+               sk_dma =3D cmh_dma_map_single(sk_buf, ml_dsa_sk_size[mi],
+                                           DMA_TO_DEVICE);
+               if (cmh_dma_map_error(sk_dma)) {
+                       ret =3D -ENOMEM;
+                       goto out_unmap;
+               }
+               sk_ref =3D sk_dma;
+       }
+
+       if (rnd_buf) {
+               rnd_dma =3D cmh_dma_map_single(rnd_buf, rnd_len,
+                                            DMA_TO_DEVICE);
+               if (cmh_dma_map_error(rnd_dma)) {
+                       ret =3D -ENOMEM;
+                       goto out_unmap;
+               }
+       }
+
+       vcq_set_header(&vcq[0], QSE_VCQ_CMDS_MIN);
+       vcq_add_qse_ml_dsa_sign(&vcq[1], qse_cid, req.mode, qse_flags,
+                               rnd_dma, m_dma, sk_ref, sig_dma,
+                               req.mlen, masked);
+       vcq_add_qse_flush(&vcq[2], qse_cid);
+
+       ret =3D cmh_tm_submit_sync_mbx(vcq, QSE_VCQ_CMDS_MIN, 1, MGMT_MBX);
+
+out_unmap:
+       if (rnd_buf && !cmh_dma_map_error(rnd_dma))
+               cmh_dma_unmap_single(rnd_dma, rnd_len, DMA_TO_DEVICE);
+       if (sk_buf && !cmh_dma_map_error(sk_dma))
+               cmh_dma_unmap_single(sk_dma, ml_dsa_sk_size[mi],
+                                    DMA_TO_DEVICE);
+       if (!cmh_dma_map_error(sig_dma))
+               cmh_dma_unmap_single(sig_dma, sig_size, DMA_FROM_DEVICE);
+       if (copy_len > 0 && !cmh_dma_map_error(m_dma))
+               cmh_dma_unmap_single(m_dma, copy_len, DMA_TO_DEVICE);
+
+       if (!ret) {
+               if (copy_to_user(u64_to_user_ptr(req.sig), sig_buf, sig_siz=
e))
+                       ret =3D -EFAULT;
+       }
+
+out_free:
+       kfree(rnd_buf);
+       kfree(sig_buf);
+       kfree(m_buf);
+       kfree_sensitive(sk_buf);
+       return ret;
+}
+
+/* -- PQC -- SLH-DSA -- */
+
+/**
+ * cmh_mgmt_slhdsa_keygen() - Handle CMH_MGMT_IOC_SLHDSA_KEYGEN ioctl
+ * @argp: User-space ioctl argument pointer
+ *
+ * Return: 0 on success, negative errno on failure.
+ */
+int cmh_mgmt_slhdsa_keygen(void __user *argp)
+{
+       u32 hcq_cid =3D cmh_core_default_id(CMH_CORE_HCQ);
+
+       struct cmh_ioctl_slhdsa_keygen req;
+       struct vcq_cmd vcq[HCQ_VCQ_CMDS_MAX];
+       u32 pk_sz, sk_sz, seed_sz, sk_alloc, vcq_cnt, key_flags;
+       bool ds_ref;
+       u8 *seed_buf, *pk_buf, *sk_buf =3D NULL;
+       u64 *ref_buf =3D NULL;
+       dma_addr_t seed_dma, pk_dma, sk_dma =3D DMA_MAPPING_ERROR, ref_dma =
=3D DMA_MAPPING_ERROR;
+       int ret, idx;
+
+       if (copy_from_user(&req, argp, sizeof(req)))
+               return -EFAULT;
+       if (req.version !=3D CMH_MGMT_V1)
+               return -EINVAL;
+       if (req.__reserved)
+               return -EINVAL;
+       if (req.parameter_set < 1 || req.parameter_set > HCQ_SLHDSA_PARAM_M=
AX)
+               return -EINVAL;
+       if (req.flags & ~(CMH_QSE_FLAG_DS_REF | CMH_FLAG_MASK))
+               return -EINVAL;
+
+       ds_ref =3D !!(req.flags & CMH_QSE_FLAG_DS_REF);
+
+       /*
+        * QSE keys only support PT storage -- the eSW sign path
+        * hardcodes SYS_TYPE_FLAG_PT when reading the key back.
+        * HCQ core sets key type internally during keygen.
+        */
+       key_flags =3D req.flags & CMH_FLAG_MASK;
+       if (key_flags && key_flags !=3D CMH_FLAG_PT)
+               return -EINVAL;
+       (void)key_flags;
+
+       pk_sz =3D slhdsa_pk_size(req.parameter_set);
+       sk_sz =3D slhdsa_sk_size(req.parameter_set);
+       seed_sz =3D slhdsa_seed_size(req.parameter_set);
+
+       seed_buf =3D kmalloc(seed_sz, GFP_KERNEL);
+       pk_buf =3D kzalloc(pk_sz, GFP_KERNEL);
+       if (!seed_buf || !pk_buf) {
+               ret =3D -ENOMEM;
+               goto out_free;
+       }
+
+       if (copy_from_user(seed_buf, u64_to_user_ptr(req.seed), seed_sz)) {
+               ret =3D -EFAULT;
+               goto out_free;
+       }
+
+       /*
+        * Both paths need ref_buf for sys_new output.  Non-ds_ref also
+        * needs sk_buf (+16 for SYS header) to read back via sys_read.
+        */
+       ref_buf =3D kzalloc(sizeof(u64), GFP_KERNEL);
+       if (!ref_buf) {
+               ret =3D -ENOMEM;
+               goto out_free;
+       }
+       if (!ds_ref) {
+               sk_alloc =3D sk_sz + SYS_WRAP_HDR_SIZE;
+               sk_buf =3D kzalloc(sk_alloc, GFP_KERNEL);
+               if (!sk_buf) {
+                       ret =3D -ENOMEM;
+                       goto out_free;
+               }
+       }
+
+       seed_dma =3D cmh_dma_map_single(seed_buf, seed_sz, DMA_TO_DEVICE);
+       pk_dma =3D cmh_dma_map_single(pk_buf, pk_sz, DMA_FROM_DEVICE);
+       ref_dma =3D cmh_dma_map_single(ref_buf, sizeof(u64), DMA_FROM_DEVIC=
E);
+       if (cmh_dma_map_error(seed_dma) || cmh_dma_map_error(pk_dma) ||
+           cmh_dma_map_error(ref_dma)) {
+               ret =3D -ENOMEM;
+               goto out_unmap;
+       }
+
+       if (!ds_ref) {
+               sk_dma =3D cmh_dma_map_single(sk_buf, sk_alloc,
+                                           DMA_FROM_DEVICE);
+               if (cmh_dma_map_error(sk_dma)) {
+                       ret =3D -ENOMEM;
+                       goto out_unmap;
+               }
+       }
+
+       /*
+        * SLH-DSA keygen requires seed and sk as DS references.
+        * VCQ: hdr + sys_new(sk) + sys_write(seed->TEMP) + keygen + [sys_r=
ead] + flush
+        */
+       idx =3D 0;
+       if (ds_ref) {
+               vcq_cnt =3D HCQ_VCQ_CMDS_MAX - 1; /* hdr+new+write+keygen+f=
lush */
+               vcq_set_header(&vcq[idx++], vcq_cnt);
+               vcq_add_sys_new(&vcq[idx++], req.sk_cid, ref_dma,
+                               sk_sz);
+       } else {
+               vcq_cnt =3D HCQ_VCQ_CMDS_MAX; /* hdr+new+write+keygen+read+=
flush */
+               vcq_set_header(&vcq[idx++], vcq_cnt);
+               vcq_add_sys_new(&vcq[idx++], SYS_CID_NONE, ref_dma,
+                               sk_sz);
+       }
+       vcq_add_sys_write(&vcq[idx++], SYS_REF_TEMP, seed_dma, 0,
+                         seed_sz,
+                         SYS_TYPE_SET(SYS_TYPE_FLAG_PT, CORE_ID_HCQ));
+       vcq_add_hcq_slhdsa_keygen(&vcq[idx++], hcq_cid, req.parameter_set,
+                                 seed_sz, pk_sz, sk_sz,
+                                 SYS_REF_TEMP, pk_dma, SYS_REF_LAST);
+       if (!ds_ref)
+               vcq_add_sys_read(&vcq[idx++], SYS_REF_LAST, sk_dma,
+                                0, sk_sz + SYS_WRAP_HDR_SIZE);
+       vcq_add_hcq_flush(&vcq[idx++], hcq_cid);
+
+       ret =3D cmh_tm_submit_sync_tmo(vcq, vcq_cnt, 1, MGMT_MBX,
+                                    cmh_tm_slow_op_timeout_jiffies());
+
+out_unmap:
+       if (!ds_ref && sk_buf && !cmh_dma_map_error(sk_dma))
+               cmh_dma_unmap_single(sk_dma, sk_alloc, DMA_FROM_DEVICE);
+       if (!cmh_dma_map_error(ref_dma))
+               cmh_dma_unmap_single(ref_dma, sizeof(u64), DMA_FROM_DEVICE)=
;
+       if (!cmh_dma_map_error(pk_dma))
+               cmh_dma_unmap_single(pk_dma, pk_sz, DMA_FROM_DEVICE);
+       if (!cmh_dma_map_error(seed_dma))
+               cmh_dma_unmap_single(seed_dma, seed_sz, DMA_TO_DEVICE);
+
+       if (!ret) {
+               if (copy_to_user(u64_to_user_ptr(req.pk), pk_buf, pk_sz)) {
+                       ret =3D -EFAULT;
+                       goto out_free;
+               }
+               if (ds_ref) {
+                       req.sk_ref =3D *ref_buf;
+               } else {
+                       if (copy_to_user(u64_to_user_ptr(req.sk),
+                                        sk_buf + SYS_WRAP_HDR_SIZE,
+                                        sk_sz)) {
+                               ret =3D -EFAULT;
+                               goto out_free;
+                       }
+               }
+               if (copy_to_user(argp, &req, sizeof(req)))
+                       ret =3D -EFAULT;
+       }
+
+out_free:
+       kfree_sensitive(sk_buf);
+       kfree(ref_buf);
+       kfree(pk_buf);
+       kfree_sensitive(seed_buf);
+       return ret;
+}
+
+/**
+ * cmh_mgmt_slhdsa_sign() - Handle CMH_MGMT_IOC_SLHDSA_SIGN ioctl
+ * @argp: User-space ioctl argument pointer
+ *
+ * Return: 0 on success, negative errno on failure.
+ */
+int cmh_mgmt_slhdsa_sign(void __user *argp)
+{
+       u32 hcq_cid =3D cmh_core_default_id(CMH_CORE_HCQ);
+
+       struct cmh_ioctl_slhdsa_sign req;
+       struct vcq_cmd vcq[HCQ_VCQ_CMDS_MIN];
+       u32 sig_sz, n_val;
+       u8 *msg_buf, *ctx_buf =3D NULL, *sig_buf, *rnd_buf =3D NULL;
+       dma_addr_t msg_dma =3D DMA_MAPPING_ERROR, ctx_dma =3D DMA_MAPPING_E=
RROR;
+       dma_addr_t sig_dma, rnd_dma =3D DMA_MAPPING_ERROR;
+       int ret;
+
+       if (copy_from_user(&req, argp, sizeof(req)))
+               return -EFAULT;
+       if (req.version !=3D CMH_MGMT_V1)
+               return -EINVAL;
+       if (req.parameter_set < 1 || req.parameter_set > HCQ_SLHDSA_PARAM_M=
AX)
+               return -EINVAL;
+       if (req.msg_len > SLHDSA_MAX_MSG_LEN)
+               return -EINVAL;
+       if (req.ctx_len > SLHDSA_MAX_CTX_LEN)
+               return -EINVAL;
+
+       sig_sz =3D slhdsa_get_sig_size(req.parameter_set);
+       n_val =3D slhdsa_n[req.parameter_set - 1];
+
+       msg_buf =3D kmalloc(max_t(u32, req.msg_len, 1), GFP_KERNEL);
+       sig_buf =3D kzalloc(sig_sz, GFP_KERNEL);
+       if (!msg_buf || !sig_buf) {
+               ret =3D -ENOMEM;
+               goto out_free;
+       }
+
+       if (req.msg_len > 0 &&
+           copy_from_user(msg_buf, u64_to_user_ptr(req.msg), req.msg_len))=
 {
+               ret =3D -EFAULT;
+               goto out_free;
+       }
+
+       if (req.ctx_len > 0 && req.ctx) {
+               ctx_buf =3D kmalloc(req.ctx_len, GFP_KERNEL);
+               if (!ctx_buf) {
+                       ret =3D -ENOMEM;
+                       goto out_free;
+               }
+               if (copy_from_user(ctx_buf, u64_to_user_ptr(req.ctx),
+                                  req.ctx_len)) {
+                       ret =3D -EFAULT;
+                       goto out_free;
+               }
+       }
+
+       if (req.add_random) {
+               rnd_buf =3D kmalloc(n_val, GFP_KERNEL);
+               if (!rnd_buf) {
+                       ret =3D -ENOMEM;
+                       goto out_free;
+               }
+               if (copy_from_user(rnd_buf, u64_to_user_ptr(req.add_random)=
,
+                                  n_val)) {
+                       ret =3D -EFAULT;
+                       goto out_free;
+               }
+       }
+
+       sig_dma =3D cmh_dma_map_single(sig_buf, sig_sz, DMA_FROM_DEVICE);
+       if (cmh_dma_map_error(sig_dma)) {
+               ret =3D -ENOMEM;
+               goto out_unmap;
+       }
+       if (req.msg_len > 0) {
+               msg_dma =3D cmh_dma_map_single(msg_buf, req.msg_len,
+                                            DMA_TO_DEVICE);
+               if (cmh_dma_map_error(msg_dma)) {
+                       ret =3D -ENOMEM;
+                       goto out_unmap;
+               }
+       }
+
+       if (ctx_buf) {
+               ctx_dma =3D cmh_dma_map_single(ctx_buf, req.ctx_len,
+                                            DMA_TO_DEVICE);
+               if (cmh_dma_map_error(ctx_dma)) {
+                       ret =3D -ENOMEM;
+                       goto out_unmap;
+               }
+       }
+
+       if (rnd_buf) {
+               rnd_dma =3D cmh_dma_map_single(rnd_buf, n_val, DMA_TO_DEVIC=
E);
+               if (cmh_dma_map_error(rnd_dma)) {
+                       ret =3D -ENOMEM;
+                       goto out_unmap;
+               }
+       }
+
+       vcq_set_header(&vcq[0], HCQ_VCQ_CMDS_MIN);
+       vcq_add_hcq_slhdsa_sign(&vcq[1], hcq_cid, req.parameter_set,
+                               req.msg_len, req.ctx_len,
+                               rnd_dma, msg_dma, ctx_dma,
+                               req.sk, sig_dma);
+       vcq_add_hcq_flush(&vcq[2], hcq_cid);
+
+       ret =3D cmh_tm_submit_sync_tmo(vcq, HCQ_VCQ_CMDS_MIN, 1, MGMT_MBX,
+                                    cmh_tm_slow_op_timeout_jiffies());
+
+out_unmap:
+       if (rnd_buf && !cmh_dma_map_error(rnd_dma))
+               cmh_dma_unmap_single(rnd_dma, n_val, DMA_TO_DEVICE);
+       if (ctx_buf && !cmh_dma_map_error(ctx_dma))
+               cmh_dma_unmap_single(ctx_dma, req.ctx_len, DMA_TO_DEVICE);
+       if (!cmh_dma_map_error(sig_dma))
+               cmh_dma_unmap_single(sig_dma, sig_sz, DMA_FROM_DEVICE);
+       if (req.msg_len > 0 && !cmh_dma_map_error(msg_dma))
+               cmh_dma_unmap_single(msg_dma, req.msg_len, DMA_TO_DEVICE);
+
+       if (!ret) {
+               if (copy_to_user(u64_to_user_ptr(req.sig), sig_buf, sig_sz)=
)
+                       ret =3D -EFAULT;
+       }
+
+out_free:
+       kfree(rnd_buf);
+       kfree(ctx_buf);
+       kfree(sig_buf);
+       kfree(msg_buf);
+       return ret;
+}
+
+/* -- PQC -- SLH-DSA prehash -- */
+
+/**
+ * cmh_mgmt_slhdsa_sign_prehash() - Handle CMH_MGMT_IOC_SLHDSA_SIGN_PREHAS=
H ioctl
+ * @argp: User-space ioctl argument pointer
+ *
+ * Return: 0 on success, negative errno on failure.
+ */
+int cmh_mgmt_slhdsa_sign_prehash(void __user *argp)
+{
+       u32 hcq_cid =3D cmh_core_default_id(CMH_CORE_HCQ);
+
+       struct cmh_ioctl_slhdsa_sign_prehash req;
+       struct vcq_cmd vcq[HCQ_VCQ_CMDS_MIN];
+       u32 sig_sz, n_val, hcq_cmd;
+       u8 *msg_buf, *ctx_buf =3D NULL, *sig_buf, *rnd_buf =3D NULL;
+       dma_addr_t msg_dma =3D DMA_MAPPING_ERROR, ctx_dma =3D DMA_MAPPING_E=
RROR;
+       dma_addr_t sig_dma, rnd_dma =3D DMA_MAPPING_ERROR;
+       int ret;
+
+       if (copy_from_user(&req, argp, sizeof(req)))
+               return -EFAULT;
+       if (req.version !=3D CMH_MGMT_V1)
+               return -EINVAL;
+       if (req.parameter_set < 1 || req.parameter_set > HCQ_SLHDSA_PARAM_M=
AX)
+               return -EINVAL;
+       if (req.prehash_algo < 1 || req.prehash_algo > HCQ_SLHDSA_PREHASH_S=
HAKE256)
+               return -EINVAL;
+       if (req.msg_len > SLHDSA_MAX_MSG_LEN)
+               return -EINVAL;
+       if (req.ctx_len > SLHDSA_MAX_CTX_LEN)
+               return -EINVAL;
+
+       hcq_cmd =3D req.digest ? HCQ_CMD_SLHDSA_SIGN_PREHASH_DIGEST
+                            : HCQ_CMD_SLHDSA_SIGN_PREHASH;
+
+       sig_sz =3D slhdsa_get_sig_size(req.parameter_set);
+       n_val =3D slhdsa_n[req.parameter_set - 1];
+
+       msg_buf =3D kmalloc(max_t(u32, req.msg_len, 1), GFP_KERNEL);
+       sig_buf =3D kzalloc(sig_sz, GFP_KERNEL);
+       if (!msg_buf || !sig_buf) {
+               ret =3D -ENOMEM;
+               goto out_free;
+       }
+
+       if (req.msg_len > 0 &&
+           copy_from_user(msg_buf, u64_to_user_ptr(req.msg), req.msg_len))=
 {
+               ret =3D -EFAULT;
+               goto out_free;
+       }
+
+       if (req.ctx_len > 0 && req.ctx) {
+               ctx_buf =3D kmalloc(req.ctx_len, GFP_KERNEL);
+               if (!ctx_buf) {
+                       ret =3D -ENOMEM;
+                       goto out_free;
+               }
+               if (copy_from_user(ctx_buf, u64_to_user_ptr(req.ctx),
+                                  req.ctx_len)) {
+                       ret =3D -EFAULT;
+                       goto out_free;
+               }
+       }
+
+       if (req.add_random) {
+               rnd_buf =3D kmalloc(n_val, GFP_KERNEL);
+               if (!rnd_buf) {
+                       ret =3D -ENOMEM;
+                       goto out_free;
+               }
+               if (copy_from_user(rnd_buf, u64_to_user_ptr(req.add_random)=
,
+                                  n_val)) {
+                       ret =3D -EFAULT;
+                       goto out_free;
+               }
+       }
+
+       sig_dma =3D cmh_dma_map_single(sig_buf, sig_sz, DMA_FROM_DEVICE);
+       if (cmh_dma_map_error(sig_dma)) {
+               ret =3D -ENOMEM;
+               goto out_unmap;
+       }
+       if (req.msg_len > 0) {
+               msg_dma =3D cmh_dma_map_single(msg_buf, req.msg_len,
+                                            DMA_TO_DEVICE);
+               if (cmh_dma_map_error(msg_dma)) {
+                       ret =3D -ENOMEM;
+                       goto out_unmap;
+               }
+       }
+
+       if (ctx_buf) {
+               ctx_dma =3D cmh_dma_map_single(ctx_buf, req.ctx_len,
+                                            DMA_TO_DEVICE);
+               if (cmh_dma_map_error(ctx_dma)) {
+                       ret =3D -ENOMEM;
+                       goto out_unmap;
+               }
+       }
+
+       if (rnd_buf) {
+               rnd_dma =3D cmh_dma_map_single(rnd_buf, n_val, DMA_TO_DEVIC=
E);
+               if (cmh_dma_map_error(rnd_dma)) {
+                       ret =3D -ENOMEM;
+                       goto out_unmap;
+               }
+       }
+
+       vcq_set_header(&vcq[0], HCQ_VCQ_CMDS_MIN);
+       vcq_add_hcq_slhdsa_sign_prehash(&vcq[1], hcq_cid,
+                                       hcq_cmd, req.parameter_set,
+                                       req.prehash_algo,
+                                       req.msg_len, req.ctx_len,
+                                       rnd_dma, msg_dma, ctx_dma,
+                                       req.sk, sig_dma);
+       vcq_add_hcq_flush(&vcq[2], hcq_cid);
+
+       ret =3D cmh_tm_submit_sync_tmo(vcq, HCQ_VCQ_CMDS_MIN, 1, MGMT_MBX,
+                                    cmh_tm_slow_op_timeout_jiffies());
+
+out_unmap:
+       if (rnd_buf && !cmh_dma_map_error(rnd_dma))
+               cmh_dma_unmap_single(rnd_dma, n_val, DMA_TO_DEVICE);
+       if (ctx_buf && !cmh_dma_map_error(ctx_dma))
+               cmh_dma_unmap_single(ctx_dma, req.ctx_len, DMA_TO_DEVICE);
+       if (!cmh_dma_map_error(sig_dma))
+               cmh_dma_unmap_single(sig_dma, sig_sz, DMA_FROM_DEVICE);
+       if (req.msg_len > 0 && !cmh_dma_map_error(msg_dma))
+               cmh_dma_unmap_single(msg_dma, req.msg_len, DMA_TO_DEVICE);
+
+       if (!ret) {
+               if (copy_to_user(u64_to_user_ptr(req.sig), sig_buf, sig_sz)=
)
+                       ret =3D -EFAULT;
+       }
+
+out_free:
+       kfree(rnd_buf);
+       kfree(ctx_buf);
+       kfree(sig_buf);
+       kfree(msg_buf);
+       return ret;
+}
+
+/* -- EAC (Error and Alarm Controller) ---- */
+
diff --git a/drivers/crypto/cmh/cmh_pke_sm2.c b/drivers/crypto/cmh/cmh_pke_=
sm2.c
new file mode 100644
index 000000000000..9a6e30c7f5e5
--- /dev/null
+++ b/drivers/crypto/cmh/cmh_pke_sm2.c
@@ -0,0 +1,827 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2026 Cryptography Research, Inc. (CRI).
+ * CMH LKM -- SM2 PKE Ioctl Handlers
+ *
+ * SM2 (GM/T 0003) is the Chinese national public-key standard over the
+ * sm2p256v1 curve (256-bit).  It defines three protocols:
+ *
+ *   - Signature: reuses ECDSA sign/verify with SM2_CURVE (0x18), handled
+ *     by the existing cmh_mgmt_pke_ecdsa_{sign,verify}() paths.
+ *   - Encryption: two-step (ENC_POINT + ENC_HASH / DEC_POINT + DEC_HASH).
+ *   - Key Exchange: four-step (ECDH_KEYGEN + ID_DIGEST + ECDH + ECDH_HASH=
).
+ *
+ * This file implements the 8 SM2-specific ioctl handlers (0x16--0x1D).
+ * Sign/verify/keygen/pubgen use the existing ECDSA/EC paths unchanged.
+ *
+ * VCQ flag convention (from eSW API):
+ *   - Most SM2 commands use flags=3D0 (no swap).
+ *   - SM2_DEC_POINT and SM2_ECDH_HASH use PKE_SWAP_FLAGS on the
+ *     PKE command itself.
+ *   - SM2_ECDH and SM2_ECDH_HASH also apply PKE_SWAP_FLAGS on
+ *     their sys_new/sys_data VCQ phases (Weierstrass DS format).
+ */
+
+#include <linux/uaccess.h>
+#include <linux/slab.h>
+
+#include "cmh_pke.h"
+#include "cmh_pke_sm2.h"
+#include "cmh_sys.h"
+#include "cmh_dma.h"
+#include "cmh_txn.h"
+#include "cmh_mgmt.h"
+#include "cmh_sys_abi.h"
+#include <uapi/linux/cmh_mgmt_ioctl.h>
+
+/* SM2 fixed sizes (sm2p256v1: 256-bit curve) */
+#define SM2_CLEN               32U     /* coordinate length */
+#define SM2_POINT_LEN          64U     /* uncompressed EC point (x||y) */
+#define SM2_SHARED_KEY_LEN     16U     /* ECDH shared key output */
+#define SM2_DIGEST_LEN         32U     /* SM3 ZA digest */
+#define SM2_NONCE_LEN          32U     /* nonce (when caller-provided) */
+/*
+ * SM2 enc_hash/dec_hash payload limit.
+ *
+ * The eSW PKE driver expands the GM/T 0003.4 KDF by issuing a single SM3
+ * invocation per command (one 32-byte block of key stream).  Messages
+ * longer than 32 bytes would require ceil(msg_len / 32) SM3 invocations
+ * with an incremented counter, which the eSW does not perform; longer
+ * inputs would silently produce incorrect ciphertext / plaintext.
+ *
+ * The eSW PKE SRAM can physically hold up to 4000 bytes of payload, but
+ * that capacity is unusable until a future eSW change implements the full
+ * KDF expansion.  Until then we cap the LKM at the 32-byte limit
+ * documented in Documentation/ABI/testing/cmh-mgmt.
+ */
+#define SM2_MAX_MSG_LEN                32U     /* max plaintext for encryp=
t/decrypt */
+#define SM2_MAX_ID_LEN         32U     /* max identity string */
+#define SM2_CT_OVERHEAD                96U     /* C1(64) + C3(32) */
+#define SM2_MAX_CT_LEN         (SM2_CT_OVERHEAD + SM2_MAX_MSG_LEN) /* 128 =
*/
+
+/* -- SM2_ECDH_KEYGEN ------------------- */
+
+/**
+ * cmh_mgmt_sm2_ecdh_keygen() - Handle CMH_MGMT_IOC_SM2_ECDH_KEYGEN ioctl
+ * @argp: User-space ioctl argument pointer
+ *
+ * Return: 0 on success, negative errno on failure.
+ */
+int cmh_mgmt_sm2_ecdh_keygen(void __user *argp)
+{
+       struct cmh_ioctl_sm2_ecdh_keygen req;
+       struct vcq_cmd vcq[PKE_VCQ_CMDS_MIN];
+       u32 core_id =3D cmh_core_default_id(CMH_CORE_PKE);
+       u8 *nonce_buf, *sk_buf;
+       dma_addr_t nonce_dma, sk_dma;
+       int nonce_dir;
+       int ret;
+
+       if (copy_from_user(&req, argp, sizeof(req)))
+               return -EFAULT;
+       if (req.version !=3D CMH_MGMT_V1)
+               return -EINVAL;
+       if (req.nonce_len !=3D 0 && req.nonce_len !=3D SM2_NONCE_LEN)
+               return -EINVAL;
+
+       sk_buf =3D kzalloc(SM2_POINT_LEN, GFP_KERNEL);
+       nonce_buf =3D kzalloc(SM2_NONCE_LEN, GFP_KERNEL);
+       if (!sk_buf || !nonce_buf) {
+               ret =3D -ENOMEM;
+               goto out_free;
+       }
+
+       /*
+        * nonce_len=3D32: caller provides ephemeral scalar r (DMA_TO_DEVIC=
E).
+        * nonce_len=3D0:  HW generates r and writes it back (DMA_FROM_DEVI=
CE).
+        * The caller MUST supply a valid nonce pointer in both cases.
+        */
+       if (req.nonce_len) {
+               if (copy_from_user(nonce_buf, u64_to_user_ptr(req.nonce),
+                                  SM2_NONCE_LEN)) {
+                       ret =3D -EFAULT;
+                       goto out_free;
+               }
+               nonce_dir =3D DMA_TO_DEVICE;
+       } else {
+               nonce_dir =3D DMA_FROM_DEVICE;
+       }
+
+       sk_dma =3D cmh_dma_map_single(sk_buf, SM2_POINT_LEN, DMA_FROM_DEVIC=
E);
+       nonce_dma =3D cmh_dma_map_single(nonce_buf, SM2_NONCE_LEN, nonce_di=
r);
+       if (cmh_dma_map_error(sk_dma) || cmh_dma_map_error(nonce_dma)) {
+               ret =3D -ENOMEM;
+               goto out_unmap;
+       }
+
+       vcq_set_header(&vcq[0], PKE_VCQ_CMDS_MIN);
+       vcq_add_pke_sm2_ecdh_keygen(&vcq[1], core_id, nonce_dma, sk_dma,
+                                   req.nonce_len, 0);
+       vcq_add_pke_flush(&vcq[2], core_id);
+
+       ret =3D cmh_tm_submit_sync_mbx(vcq, PKE_VCQ_CMDS_MIN, 1, MGMT_MBX);
+
+out_unmap:
+       if (!cmh_dma_map_error(nonce_dma))
+               cmh_dma_unmap_single(nonce_dma, SM2_NONCE_LEN, nonce_dir);
+       if (!cmh_dma_map_error(sk_dma))
+               cmh_dma_unmap_single(sk_dma, SM2_POINT_LEN, DMA_FROM_DEVICE=
);
+
+       if (!ret) {
+               if (copy_to_user(u64_to_user_ptr(req.session_key),
+                                sk_buf, SM2_POINT_LEN))
+                       ret =3D -EFAULT;
+               /* Write back HW-generated nonce when nonce_len=3D0 */
+               if (!ret && !req.nonce_len) {
+                       if (copy_to_user(u64_to_user_ptr(req.nonce),
+                                        nonce_buf, SM2_NONCE_LEN))
+                               ret =3D -EFAULT;
+               }
+       }
+
+out_free:
+       kfree_sensitive(nonce_buf);
+       kfree_sensitive(sk_buf);
+       return ret;
+}
+
+/* -- SM2_ECDH -------------------------- */
+
+/**
+ * cmh_mgmt_sm2_ecdh() - Handle CMH_MGMT_IOC_SM2_ECDH ioctl
+ * @argp: User-space ioctl argument pointer
+ *
+ * Return: 0 on success, negative errno on failure.
+ */
+int cmh_mgmt_sm2_ecdh(void __user *argp)
+{
+       struct cmh_ioctl_sm2_ecdh req;
+       /* Phase 1: hdr + sys_new + sm2_ecdh + pke_flush */
+       struct vcq_cmd vcq[4];
+       u32 sp_type, core_id;
+       u8 *nonce_buf, *peer_pk_buf, *peer_sk_buf, *sp_buf;
+       u64 *ref_buf;
+       dma_addr_t nonce_dma, peer_pk_dma, peer_sk_dma, sp_dma, ref_dma;
+       int nonce_dir, ret, idx;
+       bool keep_ds;
+
+       if (copy_from_user(&req, argp, sizeof(req)))
+               return -EFAULT;
+       if (req.version !=3D CMH_MGMT_V1)
+               return -EINVAL;
+       if (req.nonce_len !=3D 0 && req.nonce_len !=3D SM2_NONCE_LEN)
+               return -EINVAL;
+
+       keep_ds =3D (req.shared_point_ref !=3D 0);
+       sp_type =3D SYS_TYPE_SET(SYS_TYPE_FLAG_PT, CORE_ID_PKE);
+       core_id =3D cmh_core_default_id(CMH_CORE_PKE);
+
+       peer_pk_buf =3D kmalloc(SM2_POINT_LEN, GFP_KERNEL);
+       peer_sk_buf =3D kmalloc(SM2_POINT_LEN, GFP_KERNEL);
+       sp_buf =3D kzalloc(SM2_POINT_LEN, GFP_KERNEL);
+       ref_buf =3D kzalloc_obj(u64, GFP_KERNEL);
+       nonce_buf =3D kzalloc(SM2_NONCE_LEN, GFP_KERNEL);
+       if (!peer_pk_buf || !peer_sk_buf || !sp_buf || !ref_buf ||
+           !nonce_buf) {
+               ret =3D -ENOMEM;
+               goto out_free;
+       }
+
+       if (copy_from_user(peer_pk_buf, u64_to_user_ptr(req.peer_public_key=
),
+                          SM2_POINT_LEN) ||
+           copy_from_user(peer_sk_buf, u64_to_user_ptr(req.peer_session_ke=
y),
+                          SM2_POINT_LEN)) {
+               ret =3D -EFAULT;
+               goto out_free;
+       }
+
+       if (req.nonce_len) {
+               if (copy_from_user(nonce_buf, u64_to_user_ptr(req.nonce),
+                                  SM2_NONCE_LEN)) {
+                       ret =3D -EFAULT;
+                       goto out_free;
+               }
+               nonce_dir =3D DMA_TO_DEVICE;
+       } else {
+               nonce_dir =3D DMA_FROM_DEVICE;
+       }
+
+       peer_pk_dma =3D cmh_dma_map_single(peer_pk_buf, SM2_POINT_LEN,
+                                        DMA_TO_DEVICE);
+       peer_sk_dma =3D cmh_dma_map_single(peer_sk_buf, SM2_POINT_LEN,
+                                        DMA_TO_DEVICE);
+       sp_dma =3D cmh_dma_map_single(sp_buf, SM2_POINT_LEN, DMA_FROM_DEVIC=
E);
+       ref_dma =3D cmh_dma_map_single(ref_buf, sizeof(u64), DMA_FROM_DEVIC=
E);
+       nonce_dma =3D cmh_dma_map_single(nonce_buf, SM2_NONCE_LEN, nonce_di=
r);
+
+       if (cmh_dma_map_error(peer_pk_dma) || cmh_dma_map_error(peer_sk_dma=
) ||
+           cmh_dma_map_error(sp_dma) || cmh_dma_map_error(ref_dma) ||
+           cmh_dma_map_error(nonce_dma)) {
+               ret =3D -ENOMEM;
+               goto out_unmap;
+       }
+
+       /* Phase 1: sys_new(shared_point_ref) + SM2_ECDH(->SYS_REF_LAST) */
+       idx =3D 0;
+       vcq_set_header(&vcq[idx++], 4);
+       vcq_add_sys_new(&vcq[idx], 0, ref_dma, SM2_POINT_LEN);
+       vcq[idx++].id |=3D PKE_SWAP_FLAGS;
+       vcq_add_pke_sm2_ecdh(&vcq[idx++], core_id, req.nonce_len, SM2_CLEN,
+                            nonce_dma, peer_pk_dma, peer_sk_dma,
+                            req.key_ref, SYS_REF_LAST, sp_type, 0);
+       vcq_add_pke_flush(&vcq[idx++], core_id);
+
+       ret =3D cmh_tm_submit_sync_mbx(vcq, 4, 1, MGMT_MBX);
+       if (ret)
+               goto out_unmap;
+
+       if (!keep_ds) {
+               /* Sync bounce buffer so CPU sees the DMA-written ref */
+               cmh_dma_sync_for_cpu(ref_dma, sizeof(u64), DMA_FROM_DEVICE)=
;
+
+               /* Phase 2: read shared point from DS -> DMA, consuming the=
 slot */
+               vcq_set_header(&vcq[0], 3);
+               vcq_add_sys_data(&vcq[1], *ref_buf, sp_dma, SM2_POINT_LEN);
+               vcq[1].id |=3D PKE_SWAP_FLAGS;
+               vcq_add_sys_flush(&vcq[2]);
+
+               ret =3D cmh_tm_submit_sync_mbx(vcq, 3, 1, MGMT_MBX);
+       }
+
+out_unmap:
+       if (!cmh_dma_map_error(nonce_dma))
+               cmh_dma_unmap_single(nonce_dma, SM2_NONCE_LEN, nonce_dir);
+       if (!cmh_dma_map_error(ref_dma))
+               cmh_dma_unmap_single(ref_dma, sizeof(u64), DMA_FROM_DEVICE)=
;
+       if (!cmh_dma_map_error(sp_dma))
+               cmh_dma_unmap_single(sp_dma, SM2_POINT_LEN, DMA_FROM_DEVICE=
);
+       if (!cmh_dma_map_error(peer_sk_dma))
+               cmh_dma_unmap_single(peer_sk_dma, SM2_POINT_LEN,
+                                    DMA_TO_DEVICE);
+       if (!cmh_dma_map_error(peer_pk_dma))
+               cmh_dma_unmap_single(peer_pk_dma, SM2_POINT_LEN,
+                                    DMA_TO_DEVICE);
+
+       if (!ret) {
+               if (!keep_ds) {
+                       if (copy_to_user(u64_to_user_ptr(req.shared_point),
+                                        sp_buf, SM2_POINT_LEN))
+                               ret =3D -EFAULT;
+               } else {
+                       /* Return DS ref for ECDH_HASH to consume */
+                       u64 __user *sp_refp =3D (__u64 __user *)
+                               u64_to_user_ptr(req.shared_point_ref);
+
+                       if (put_user(*ref_buf, sp_refp)) {
+                               /*
+                                * Failed to deliver the DS ref to
+                                * userspace.  Logically delete the
+                                * orphaned slot so it does not leak.
+                                */
+                               vcq_set_header(&vcq[0], 3);
+                               vcq_add_sys_grant(&vcq[1], *ref_buf,
+                                                 0, 0, 0);
+                               vcq_add_sys_flush(&vcq[2]);
+                               cmh_tm_submit_sync_mbx(vcq, 3, 1,
+                                                      MGMT_MBX);
+                               dev_warn(cmh_dev(), "SM2 ECDH put_user fail=
ed, DS slot cleaned up\n");
+                               ret =3D -EFAULT;
+                       }
+               }
+               /* Write back HW-generated nonce when nonce_len=3D0 */
+               if (!ret && !req.nonce_len) {
+                       if (copy_to_user(u64_to_user_ptr(req.nonce),
+                                        nonce_buf, SM2_NONCE_LEN))
+                               ret =3D -EFAULT;
+               }
+       }
+
+out_free:
+       kfree_sensitive(nonce_buf);
+       kfree(ref_buf);
+       kfree_sensitive(sp_buf);
+       kfree(peer_sk_buf);
+       kfree(peer_pk_buf);
+       return ret;
+}
+
+/* -- SM2_DEC_POINT --------------------- */
+
+/**
+ * cmh_mgmt_sm2_dec_point() - Handle CMH_MGMT_IOC_SM2_DEC_POINT ioctl
+ * @argp: User-space ioctl argument pointer
+ *
+ * Return: 0 on success, negative errno on failure.
+ */
+int cmh_mgmt_sm2_dec_point(void __user *argp)
+{
+       struct cmh_ioctl_sm2_dec_point req;
+       struct vcq_cmd vcq[PKE_VCQ_CMDS_MIN];
+       u32 core_id =3D cmh_core_default_id(CMH_CORE_PKE);
+       u8 *ct_buf, *dp_buf;
+       dma_addr_t ct_dma, dp_dma;
+       int ret;
+
+       if (copy_from_user(&req, argp, sizeof(req)))
+               return -EFAULT;
+       if (req.version !=3D CMH_MGMT_V1)
+               return -EINVAL;
+       if (req.ciphertext_len <=3D SM2_CT_OVERHEAD ||
+           req.ciphertext_len > SM2_MAX_CT_LEN)
+               return -EINVAL;
+
+       /* Only need C1 (first 64 bytes) for the sidecar */
+       ct_buf =3D kmalloc(SM2_POINT_LEN, GFP_KERNEL);
+       dp_buf =3D kzalloc(SM2_POINT_LEN, GFP_KERNEL);
+       if (!ct_buf || !dp_buf) {
+               ret =3D -ENOMEM;
+               goto out_free;
+       }
+
+       if (copy_from_user(ct_buf, u64_to_user_ptr(req.ciphertext),
+                          SM2_POINT_LEN)) {
+               ret =3D -EFAULT;
+               goto out_free;
+       }
+
+       ct_dma =3D cmh_dma_map_single(ct_buf, SM2_POINT_LEN, DMA_TO_DEVICE)=
;
+       dp_dma =3D cmh_dma_map_single(dp_buf, SM2_POINT_LEN, DMA_FROM_DEVIC=
E);
+       if (cmh_dma_map_error(ct_dma) || cmh_dma_map_error(dp_dma)) {
+               ret =3D -ENOMEM;
+               goto out_unmap;
+       }
+
+       vcq_set_header(&vcq[0], PKE_VCQ_CMDS_MIN);
+       vcq_add_pke_sm2_dec_point(&vcq[1], core_id, req.ciphertext_len, SM2=
_CLEN,
+                                 ct_dma, dp_dma, req.key_ref,
+                                 PKE_SWAP_FLAGS);
+       vcq_add_pke_flush(&vcq[2], core_id);
+
+       ret =3D cmh_tm_submit_sync_mbx(vcq, PKE_VCQ_CMDS_MIN, 1, MGMT_MBX);
+
+out_unmap:
+       if (!cmh_dma_map_error(dp_dma))
+               cmh_dma_unmap_single(dp_dma, SM2_POINT_LEN, DMA_FROM_DEVICE=
);
+       if (!cmh_dma_map_error(ct_dma))
+               cmh_dma_unmap_single(ct_dma, SM2_POINT_LEN, DMA_TO_DEVICE);
+
+       if (!ret) {
+               if (copy_to_user(u64_to_user_ptr(req.dec_point),
+                                dp_buf, SM2_POINT_LEN))
+                       ret =3D -EFAULT;
+       }
+
+out_free:
+       kfree_sensitive(dp_buf);
+       kfree(ct_buf);
+       return ret;
+}
+
+/* -- SM2_ENC_POINT --------------------- */
+
+/**
+ * cmh_mgmt_sm2_enc_point() - Handle CMH_MGMT_IOC_SM2_ENC_POINT ioctl
+ * @argp: User-space ioctl argument pointer
+ *
+ * Return: 0 on success, negative errno on failure.
+ */
+int cmh_mgmt_sm2_enc_point(void __user *argp)
+{
+       struct cmh_ioctl_sm2_enc_point req;
+       struct vcq_cmd vcq[PKE_VCQ_CMDS_MIN];
+       u32 core_id =3D cmh_core_default_id(CMH_CORE_PKE);
+       u8 *nonce_buf =3D NULL, *pk_buf, *ct_buf, *ep_buf;
+       dma_addr_t nonce_dma =3D DMA_MAPPING_ERROR, pk_dma, ct_dma, ep_dma;
+       int ret;
+
+       if (copy_from_user(&req, argp, sizeof(req)))
+               return -EFAULT;
+       if (req.version !=3D CMH_MGMT_V1)
+               return -EINVAL;
+       if (req.nonce_len !=3D 0 && req.nonce_len !=3D SM2_NONCE_LEN)
+               return -EINVAL;
+
+       pk_buf =3D kmalloc(SM2_POINT_LEN, GFP_KERNEL);
+       ct_buf =3D kzalloc(SM2_POINT_LEN, GFP_KERNEL);
+       ep_buf =3D kzalloc(SM2_POINT_LEN, GFP_KERNEL);
+       if (!pk_buf || !ct_buf || !ep_buf) {
+               ret =3D -ENOMEM;
+               goto out_free;
+       }
+
+       if (copy_from_user(pk_buf, u64_to_user_ptr(req.public_key),
+                          SM2_POINT_LEN)) {
+               ret =3D -EFAULT;
+               goto out_free;
+       }
+
+       if (req.nonce_len) {
+               nonce_buf =3D kmalloc(SM2_NONCE_LEN, GFP_KERNEL);
+               if (!nonce_buf) {
+                       ret =3D -ENOMEM;
+                       goto out_free;
+               }
+               if (copy_from_user(nonce_buf, u64_to_user_ptr(req.nonce),
+                                  SM2_NONCE_LEN)) {
+                       ret =3D -EFAULT;
+                       goto out_free;
+               }
+       }
+
+       pk_dma =3D cmh_dma_map_single(pk_buf, SM2_POINT_LEN, DMA_TO_DEVICE)=
;
+       ct_dma =3D cmh_dma_map_single(ct_buf, SM2_POINT_LEN, DMA_FROM_DEVIC=
E);
+       ep_dma =3D cmh_dma_map_single(ep_buf, SM2_POINT_LEN, DMA_FROM_DEVIC=
E);
+       if (nonce_buf)
+               nonce_dma =3D cmh_dma_map_single(nonce_buf, SM2_NONCE_LEN,
+                                              DMA_TO_DEVICE);
+       if (cmh_dma_map_error(pk_dma) || cmh_dma_map_error(ct_dma) ||
+           cmh_dma_map_error(ep_dma) ||
+           (nonce_buf && cmh_dma_map_error(nonce_dma))) {
+               ret =3D -ENOMEM;
+               goto out_unmap;
+       }
+
+       vcq_set_header(&vcq[0], PKE_VCQ_CMDS_MIN);
+       vcq_add_pke_sm2_enc_point(&vcq[1], core_id, nonce_dma, pk_dma, ct_d=
ma,
+                                 ep_dma, req.nonce_len, 0);
+       vcq_add_pke_flush(&vcq[2], core_id);
+
+       ret =3D cmh_tm_submit_sync_mbx(vcq, PKE_VCQ_CMDS_MIN, 1, MGMT_MBX);
+
+out_unmap:
+       if (nonce_buf && !cmh_dma_map_error(nonce_dma))
+               cmh_dma_unmap_single(nonce_dma, SM2_NONCE_LEN, DMA_TO_DEVIC=
E);
+       if (!cmh_dma_map_error(ep_dma))
+               cmh_dma_unmap_single(ep_dma, SM2_POINT_LEN, DMA_FROM_DEVICE=
);
+       if (!cmh_dma_map_error(ct_dma))
+               cmh_dma_unmap_single(ct_dma, SM2_POINT_LEN, DMA_FROM_DEVICE=
);
+       if (!cmh_dma_map_error(pk_dma))
+               cmh_dma_unmap_single(pk_dma, SM2_POINT_LEN, DMA_TO_DEVICE);
+
+       if (!ret) {
+               if (copy_to_user(u64_to_user_ptr(req.ciphertext),
+                                ct_buf, SM2_POINT_LEN) ||
+                   copy_to_user(u64_to_user_ptr(req.enc_point),
+                                ep_buf, SM2_POINT_LEN))
+                       ret =3D -EFAULT;
+       }
+
+out_free:
+       kfree_sensitive(nonce_buf);
+       kfree(ep_buf);
+       kfree(ct_buf);
+       kfree(pk_buf);
+       return ret;
+}
+
+/* -- SM2_ID_DIGEST --------------------- */
+
+/**
+ * cmh_mgmt_sm2_id_digest() - Handle CMH_MGMT_IOC_SM2_ID_DIGEST ioctl
+ * @argp: User-space ioctl argument pointer
+ *
+ * Return: 0 on success, negative errno on failure.
+ */
+int cmh_mgmt_sm2_id_digest(void __user *argp)
+{
+       struct cmh_ioctl_sm2_id_digest req;
+       struct vcq_cmd vcq[PKE_VCQ_CMDS_MIN];
+       u32 core_id =3D cmh_core_default_id(CMH_CORE_PKE);
+       u8 *id_buf, *pk_buf, *dig_buf;
+       dma_addr_t id_dma, pk_dma, dig_dma;
+       int ret;
+
+       if (copy_from_user(&req, argp, sizeof(req)))
+               return -EFAULT;
+       if (req.version !=3D CMH_MGMT_V1)
+               return -EINVAL;
+       if (!req.id_len || req.id_len > SM2_MAX_ID_LEN)
+               return -EINVAL;
+
+       id_buf =3D kmalloc(req.id_len, GFP_KERNEL);
+       pk_buf =3D kmalloc(SM2_POINT_LEN, GFP_KERNEL);
+       dig_buf =3D kzalloc(SM2_DIGEST_LEN, GFP_KERNEL);
+       if (!id_buf || !pk_buf || !dig_buf) {
+               ret =3D -ENOMEM;
+               goto out_free;
+       }
+
+       if (copy_from_user(id_buf, u64_to_user_ptr(req.id), req.id_len) ||
+           copy_from_user(pk_buf, u64_to_user_ptr(req.public_key),
+                          SM2_POINT_LEN)) {
+               ret =3D -EFAULT;
+               goto out_free;
+       }
+
+       id_dma =3D cmh_dma_map_single(id_buf, req.id_len, DMA_TO_DEVICE);
+       pk_dma =3D cmh_dma_map_single(pk_buf, SM2_POINT_LEN, DMA_TO_DEVICE)=
;
+       dig_dma =3D cmh_dma_map_single(dig_buf, SM2_DIGEST_LEN,
+                                    DMA_FROM_DEVICE);
+       if (cmh_dma_map_error(id_dma) || cmh_dma_map_error(pk_dma) ||
+           cmh_dma_map_error(dig_dma)) {
+               ret =3D -ENOMEM;
+               goto out_unmap;
+       }
+
+       vcq_set_header(&vcq[0], PKE_VCQ_CMDS_MIN);
+       vcq_add_pke_sm2_id_digest(&vcq[1], core_id, id_dma, pk_dma, dig_dma=
,
+                                 req.id_len, 0);
+       vcq_add_pke_flush(&vcq[2], core_id);
+
+       ret =3D cmh_tm_submit_sync_mbx(vcq, PKE_VCQ_CMDS_MIN, 1, MGMT_MBX);
+
+out_unmap:
+       if (!cmh_dma_map_error(dig_dma))
+               cmh_dma_unmap_single(dig_dma, SM2_DIGEST_LEN,
+                                    DMA_FROM_DEVICE);
+       if (!cmh_dma_map_error(pk_dma))
+               cmh_dma_unmap_single(pk_dma, SM2_POINT_LEN, DMA_TO_DEVICE);
+       if (!cmh_dma_map_error(id_dma))
+               cmh_dma_unmap_single(id_dma, req.id_len, DMA_TO_DEVICE);
+
+       if (!ret) {
+               if (copy_to_user(u64_to_user_ptr(req.digest),
+                                dig_buf, SM2_DIGEST_LEN))
+                       ret =3D -EFAULT;
+       }
+
+out_free:
+       kfree(dig_buf);
+       kfree(pk_buf);
+       kfree(id_buf);
+       return ret;
+}
+
+/* -- SM2_ECDH_HASH --------------------- */
+
+/**
+ * cmh_mgmt_sm2_ecdh_hash() - Handle CMH_MGMT_IOC_SM2_ECDH_HASH ioctl
+ * @argp: User-space ioctl argument pointer
+ *
+ * Return: 0 on success, negative errno on failure.
+ */
+int cmh_mgmt_sm2_ecdh_hash(void __user *argp)
+{
+       struct cmh_ioctl_sm2_ecdh_hash req;
+       /* Phase 1: hdr + sys_new + sm2_ecdh_hash + pke_flush; reused for P=
hase 2 */
+       struct vcq_cmd vcq[4];
+       u32 sk_type, core_id;
+       u8 *peer_dig_buf, *dig_buf, *sk_buf;
+       u64 *ref_buf;
+       dma_addr_t peer_dig_dma, dig_dma, sk_dma, ref_dma;
+       int ret;
+
+       if (copy_from_user(&req, argp, sizeof(req)))
+               return -EFAULT;
+       if (req.version !=3D CMH_MGMT_V1)
+               return -EINVAL;
+       if (req.__reserved)
+               return -EINVAL;
+
+       sk_type =3D SYS_TYPE_SET(SYS_TYPE_FLAG_PT, CORE_ID_PKE);
+       core_id =3D cmh_core_default_id(CMH_CORE_PKE);
+
+       peer_dig_buf =3D kmalloc(SM2_DIGEST_LEN, GFP_KERNEL);
+       dig_buf =3D kmalloc(SM2_DIGEST_LEN, GFP_KERNEL);
+       sk_buf =3D kzalloc(SM2_SHARED_KEY_LEN, GFP_KERNEL);
+       ref_buf =3D kzalloc_obj(u64, GFP_KERNEL);
+       if (!peer_dig_buf || !dig_buf || !sk_buf || !ref_buf) {
+               ret =3D -ENOMEM;
+               goto out_free;
+       }
+
+       if (copy_from_user(peer_dig_buf, u64_to_user_ptr(req.peer_id_digest=
),
+                          SM2_DIGEST_LEN) ||
+           copy_from_user(dig_buf, u64_to_user_ptr(req.id_digest),
+                          SM2_DIGEST_LEN)) {
+               ret =3D -EFAULT;
+               goto out_free;
+       }
+
+       peer_dig_dma =3D cmh_dma_map_single(peer_dig_buf, SM2_DIGEST_LEN,
+                                         DMA_TO_DEVICE);
+       dig_dma =3D cmh_dma_map_single(dig_buf, SM2_DIGEST_LEN, DMA_TO_DEVI=
CE);
+       sk_dma =3D cmh_dma_map_single(sk_buf, SM2_SHARED_KEY_LEN,
+                                   DMA_FROM_DEVICE);
+       ref_dma =3D cmh_dma_map_single(ref_buf, sizeof(u64), DMA_FROM_DEVIC=
E);
+       if (cmh_dma_map_error(peer_dig_dma) || cmh_dma_map_error(dig_dma) |=
|
+           cmh_dma_map_error(sk_dma) || cmh_dma_map_error(ref_dma)) {
+               ret =3D -ENOMEM;
+               goto out_unmap;
+       }
+
+       /*
+        * Phase 1: sys_new(shared_key_ref) + SM2_ECDH_HASH
+        * The shared_point_ref from the ECDH step is passed directly
+        * as a DS reference -- the eSW hub reads it from DS.
+        */
+       vcq_set_header(&vcq[0], 4);
+       vcq_add_sys_new(&vcq[1], 0, ref_dma, SM2_SHARED_KEY_LEN);
+       vcq[1].id |=3D PKE_SWAP_FLAGS;
+       vcq_add_pke_sm2_ecdh_hash(&vcq[2], core_id, peer_dig_dma, dig_dma,
+                                 req.shared_point_ref, SYS_REF_LAST,
+                                 sk_type, PKE_SWAP_FLAGS);
+       vcq_add_pke_flush(&vcq[3], core_id);
+
+       ret =3D cmh_tm_submit_sync_mbx(vcq, 4, 1, MGMT_MBX);
+       if (ret)
+               goto out_unmap;
+
+       /* Sync bounce buffer so CPU sees the DMA-written ref */
+       cmh_dma_sync_for_cpu(ref_dma, sizeof(u64), DMA_FROM_DEVICE);
+
+       /* Phase 2: read shared key from DS -> DMA */
+       vcq_set_header(&vcq[0], 3);
+       vcq_add_sys_data(&vcq[1], *ref_buf, sk_dma, SM2_SHARED_KEY_LEN);
+       vcq_add_sys_flush(&vcq[2]);
+
+       ret =3D cmh_tm_submit_sync_mbx(vcq, 3, 1, MGMT_MBX);
+
+out_unmap:
+       if (!cmh_dma_map_error(ref_dma))
+               cmh_dma_unmap_single(ref_dma, sizeof(u64), DMA_FROM_DEVICE)=
;
+       if (!cmh_dma_map_error(sk_dma))
+               cmh_dma_unmap_single(sk_dma, SM2_SHARED_KEY_LEN,
+                                    DMA_FROM_DEVICE);
+       if (!cmh_dma_map_error(dig_dma))
+               cmh_dma_unmap_single(dig_dma, SM2_DIGEST_LEN, DMA_TO_DEVICE=
);
+       if (!cmh_dma_map_error(peer_dig_dma))
+               cmh_dma_unmap_single(peer_dig_dma, SM2_DIGEST_LEN,
+                                    DMA_TO_DEVICE);
+
+       if (!ret) {
+               if (copy_to_user(u64_to_user_ptr(req.shared_key),
+                                sk_buf, SM2_SHARED_KEY_LEN))
+                       ret =3D -EFAULT;
+       }
+
+out_free:
+       kfree(ref_buf);
+       kfree_sensitive(sk_buf);
+       kfree(dig_buf);
+       kfree(peer_dig_buf);
+       return ret;
+}
+
+/* -- SM2_DEC_HASH ---------------------- */
+
+/**
+ * cmh_mgmt_sm2_dec_hash() - Handle CMH_MGMT_IOC_SM2_DEC_HASH ioctl
+ * @argp: User-space ioctl argument pointer
+ *
+ * Return: 0 on success, negative errno on failure.
+ */
+int cmh_mgmt_sm2_dec_hash(void __user *argp)
+{
+       struct cmh_ioctl_sm2_dec_hash req;
+       struct vcq_cmd vcq[PKE_VCQ_CMDS_MIN];
+       u32 msg_len, core_id;
+       u8 *ct_buf, *dp_buf, *pt_buf;
+       dma_addr_t ct_dma, dp_dma, pt_dma;
+       int ret;
+
+       if (copy_from_user(&req, argp, sizeof(req)))
+               return -EFAULT;
+       if (req.version !=3D CMH_MGMT_V1)
+               return -EINVAL;
+       if (req.ciphertext_len <=3D SM2_CT_OVERHEAD ||
+           req.ciphertext_len > SM2_MAX_CT_LEN)
+               return -EINVAL;
+
+       msg_len =3D req.ciphertext_len - SM2_CT_OVERHEAD;
+       core_id =3D cmh_core_default_id(CMH_CORE_PKE);
+
+       ct_buf =3D kmalloc(req.ciphertext_len, GFP_KERNEL);
+       dp_buf =3D kmalloc(SM2_POINT_LEN, GFP_KERNEL);
+       pt_buf =3D kzalloc(msg_len, GFP_KERNEL);
+       if (!ct_buf || !dp_buf || !pt_buf) {
+               ret =3D -ENOMEM;
+               goto out_free;
+       }
+
+       if (copy_from_user(ct_buf, u64_to_user_ptr(req.ciphertext),
+                          req.ciphertext_len) ||
+           copy_from_user(dp_buf, u64_to_user_ptr(req.dec_point),
+                          SM2_POINT_LEN)) {
+               ret =3D -EFAULT;
+               goto out_free;
+       }
+
+       ct_dma =3D cmh_dma_map_single(ct_buf, req.ciphertext_len,
+                                   DMA_TO_DEVICE);
+       dp_dma =3D cmh_dma_map_single(dp_buf, SM2_POINT_LEN, DMA_TO_DEVICE)=
;
+       pt_dma =3D cmh_dma_map_single(pt_buf, msg_len, DMA_FROM_DEVICE);
+       if (cmh_dma_map_error(ct_dma) || cmh_dma_map_error(dp_dma) ||
+           cmh_dma_map_error(pt_dma)) {
+               ret =3D -ENOMEM;
+               goto out_unmap;
+       }
+
+       vcq_set_header(&vcq[0], PKE_VCQ_CMDS_MIN);
+       vcq_add_pke_sm2_dec_hash(&vcq[1], core_id, ct_dma, dp_dma, pt_dma,
+                                req.ciphertext_len, 0);
+       vcq_add_pke_flush(&vcq[2], core_id);
+
+       ret =3D cmh_tm_submit_sync_mbx(vcq, PKE_VCQ_CMDS_MIN, 1, MGMT_MBX);
+
+out_unmap:
+       if (!cmh_dma_map_error(pt_dma))
+               cmh_dma_unmap_single(pt_dma, msg_len, DMA_FROM_DEVICE);
+       if (!cmh_dma_map_error(dp_dma))
+               cmh_dma_unmap_single(dp_dma, SM2_POINT_LEN, DMA_TO_DEVICE);
+       if (!cmh_dma_map_error(ct_dma))
+               cmh_dma_unmap_single(ct_dma, req.ciphertext_len,
+                                    DMA_TO_DEVICE);
+
+       if (!ret) {
+               if (copy_to_user(u64_to_user_ptr(req.plaintext),
+                                pt_buf, msg_len))
+                       ret =3D -EFAULT;
+       }
+
+out_free:
+       kfree_sensitive(pt_buf);
+       kfree_sensitive(dp_buf);
+       kfree(ct_buf);
+       return ret;
+}
+
+/* -- SM2_ENC_HASH ---------------------- */
+
+/**
+ * cmh_mgmt_sm2_enc_hash() - Handle CMH_MGMT_IOC_SM2_ENC_HASH ioctl
+ * @argp: User-space ioctl argument pointer
+ *
+ * Return: 0 on success, negative errno on failure.
+ */
+int cmh_mgmt_sm2_enc_hash(void __user *argp)
+{
+       struct cmh_ioctl_sm2_enc_hash req;
+       struct vcq_cmd vcq[PKE_VCQ_CMDS_MIN];
+       u32 ct_len, core_id;
+       u8 *msg_buf, *ep_buf, *ct_buf;
+       dma_addr_t msg_dma, ep_dma, ct_dma;
+       int ret;
+
+       if (copy_from_user(&req, argp, sizeof(req)))
+               return -EFAULT;
+       if (req.version !=3D CMH_MGMT_V1)
+               return -EINVAL;
+       if (!req.message_len || req.message_len > SM2_MAX_MSG_LEN)
+               return -EINVAL;
+
+       ct_len =3D SM2_CT_OVERHEAD + req.message_len;
+       core_id =3D cmh_core_default_id(CMH_CORE_PKE);
+
+       msg_buf =3D kmalloc(req.message_len, GFP_KERNEL);
+       ep_buf =3D kmalloc(SM2_POINT_LEN, GFP_KERNEL);
+       ct_buf =3D kzalloc(ct_len, GFP_KERNEL);
+       if (!msg_buf || !ep_buf || !ct_buf) {
+               ret =3D -ENOMEM;
+               goto out_free;
+       }
+
+       if (copy_from_user(msg_buf, u64_to_user_ptr(req.message),
+                          req.message_len) ||
+           copy_from_user(ep_buf, u64_to_user_ptr(req.enc_point),
+                          SM2_POINT_LEN)) {
+               ret =3D -EFAULT;
+               goto out_free;
+       }
+
+       msg_dma =3D cmh_dma_map_single(msg_buf, req.message_len, DMA_TO_DEV=
ICE);
+       ep_dma =3D cmh_dma_map_single(ep_buf, SM2_POINT_LEN, DMA_TO_DEVICE)=
;
+       ct_dma =3D cmh_dma_map_single(ct_buf, ct_len, DMA_FROM_DEVICE);
+       if (cmh_dma_map_error(msg_dma) || cmh_dma_map_error(ep_dma) ||
+           cmh_dma_map_error(ct_dma)) {
+               ret =3D -ENOMEM;
+               goto out_unmap;
+       }
+
+       vcq_set_header(&vcq[0], PKE_VCQ_CMDS_MIN);
+       vcq_add_pke_sm2_enc_hash(&vcq[1], core_id, msg_dma, ep_dma, ct_dma,
+                                req.message_len, 0);
+       vcq_add_pke_flush(&vcq[2], core_id);
+
+       ret =3D cmh_tm_submit_sync_mbx(vcq, PKE_VCQ_CMDS_MIN, 1, MGMT_MBX);
+
+out_unmap:
+       if (!cmh_dma_map_error(ct_dma))
+               cmh_dma_unmap_single(ct_dma, ct_len, DMA_FROM_DEVICE);
+       if (!cmh_dma_map_error(ep_dma))
+               cmh_dma_unmap_single(ep_dma, SM2_POINT_LEN, DMA_TO_DEVICE);
+       if (!cmh_dma_map_error(msg_dma))
+               cmh_dma_unmap_single(msg_dma, req.message_len, DMA_TO_DEVIC=
E);
+
+       if (!ret) {
+               if (copy_to_user(u64_to_user_ptr(req.ciphertext),
+                                ct_buf, ct_len))
+                       ret =3D -EFAULT;
+       }
+
+out_free:
+       kfree(ct_buf);
+       kfree(ep_buf);
+       kfree_sensitive(msg_buf);
+       return ret;
+}
diff --git a/drivers/crypto/cmh/cmh_sys.c b/drivers/crypto/cmh/cmh_sys.c
new file mode 100644
index 000000000000..b01d058e6d89
--- /dev/null
+++ b/drivers/crypto/cmh/cmh_sys.c
@@ -0,0 +1,376 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2026 Cryptography Research, Inc. (CRI).
+ * CMH LKM -- SYS Core VCQ Builders
+ *
+ * VCQ builder functions for SYS core datastore commands.  Each function
+ * populates a single vcq_cmd slot.  Callers (cmh_mgmt.c, cmh_key.c)
+ * assemble complete VCQs by combining header + command(s) + flush,
+ * then submit via cmh_tm_submit_sync().
+ *
+ * Hardware-required datastore semantics
+ * --------------------------------------
+ * The commands below (NEW, WRITE, DATA, FIND, DELETE, FLUSH) are
+ * direct mappings of the eSW firmware SYS core command set.  The
+ * eSW maintains per-mailbox datastore namespaces with two object
+ * classes:
+ *
+ *   SYS_REF_TEMP   -- Temporary objects.  Lifetime is scoped to the
+ *                      current mailbox slot; reclaimed automatically
+ *                      when the slot is reused or on explicit FLUSH.
+ *                      Used for raw-key provisioning on every VCQ.
+ *
+ *   SYS_REF_PERSIST -- Persistent objects.  Survive across slots;
+ *                      require explicit DELETE to reclaim.  Identified
+ *                      by a 64-bit Content ID (CID) and resolved to
+ *                      a per-MBX ref via SYS_CMD_FIND.
+ *
+ * These semantics are hardware requirements, not driver policy.
+ * The per-MBX temp-stack and per-MBX ref namespace are eSW firmware
+ * design constraints that cannot be changed by the kernel driver.
+ */
+
+#include <linux/string.h>
+
+#include "cmh_sys.h"
+
+/**
+ * vcq_add_sys_flush() - Build a SYS_FLUSH VCQ command
+ * @slot: VCQ command slot to populate
+ */
+void vcq_add_sys_flush(struct vcq_cmd *slot)
+{
+       vcq_add_flush(slot, CORE_ID_SYS);
+}
+
+/**
+ * vcq_add_sys_new() - Build a SYS_NEW VCQ command
+ * @slot: VCQ command slot to populate
+ * @cid: Content identifier for the new datastore object
+ * @ref_dma: DMA address of the object reference buffer
+ * @len: Length of the object data in bytes
+ */
+void vcq_add_sys_new(struct vcq_cmd *slot, u64 cid, u64 ref_dma, u32 len)
+{
+       memset(slot, 0, sizeof(*slot));
+       slot->magic =3D VCQ_CMD_MAGIC;
+       slot->id =3D VCQ_CMD_ID(CORE_ID_SYS, 0, 1, SYS_CMD_NEW);
+       slot->hwc.sys.cmd_new.cid =3D cid;
+       slot->hwc.sys.cmd_new.ref =3D ref_dma;
+       slot->hwc.sys.cmd_new.len =3D len;
+}
+
+/**
+ * vcq_add_sys_write() - Build a SYS_WRITE VCQ command
+ * @slot: VCQ command slot to populate
+ * @ref: Datastore object reference handle
+ * @src_dma: DMA address of source data buffer
+ * @wrap_key: Wrapping key reference (0 if none)
+ * @len: Length of data to write in bytes
+ * @sys_type: Datastore object type identifier
+ */
+void vcq_add_sys_write(struct vcq_cmd *slot, u64 ref, u64 src_dma,
+                      u64 wrap_key, u32 len, u32 sys_type)
+{
+       memset(slot, 0, sizeof(*slot));
+       slot->magic =3D VCQ_CMD_MAGIC;
+       slot->id =3D VCQ_CMD_ID(CORE_ID_SYS, 0, 1, SYS_CMD_WRITE);
+       slot->hwc.sys.cmd_write.ref =3D ref;
+       slot->hwc.sys.cmd_write.src =3D src_dma;
+       slot->hwc.sys.cmd_write.key =3D wrap_key;
+       slot->hwc.sys.cmd_write.len =3D len;
+       slot->hwc.sys.cmd_write.type =3D sys_type;
+}
+
+/**
+ * vcq_add_sys_read() - Build a SYS_READ VCQ command
+ * @slot: VCQ command slot to populate
+ * @ref: Datastore object reference handle
+ * @dst_dma: DMA address of destination buffer
+ * @wrap_key: Wrapping key reference (0 if none)
+ * @len: Length of data to read in bytes
+ */
+void vcq_add_sys_read(struct vcq_cmd *slot, u64 ref, u64 dst_dma,
+                     u64 wrap_key, u32 len)
+{
+       memset(slot, 0, sizeof(*slot));
+       slot->magic =3D VCQ_CMD_MAGIC;
+       slot->id =3D VCQ_CMD_ID(CORE_ID_SYS, 0, 1, SYS_CMD_READ);
+       slot->hwc.sys.cmd_read.ref =3D ref;
+       slot->hwc.sys.cmd_read.dst =3D dst_dma;
+       slot->hwc.sys.cmd_read.key =3D wrap_key;
+       slot->hwc.sys.cmd_read.len =3D len;
+}
+
+/**
+ * vcq_add_sys_data() - Build a SYS_DATA VCQ command
+ * @slot: VCQ command slot to populate
+ * @ref: Datastore object reference handle
+ * @dst_dma: DMA address of destination buffer
+ * @len: Length of data section to read in bytes
+ */
+void vcq_add_sys_data(struct vcq_cmd *slot, u64 ref, u64 dst_dma, u32 len)
+{
+       memset(slot, 0, sizeof(*slot));
+       slot->magic =3D VCQ_CMD_MAGIC;
+       slot->id =3D VCQ_CMD_ID(CORE_ID_SYS, 0, 1, SYS_CMD_DATA);
+       slot->hwc.sys.cmd_data.ref =3D ref;
+       slot->hwc.sys.cmd_data.dst =3D dst_dma;
+       slot->hwc.sys.cmd_data.len =3D len;
+}
+
+/**
+ * vcq_add_sys_find() - Build a SYS_FIND VCQ command
+ * @slot: VCQ command slot to populate
+ * @cid: Content identifier to search for
+ * @dst_dma: DMA address of destination buffer for result
+ * @len: Length of destination buffer in bytes
+ */
+void vcq_add_sys_find(struct vcq_cmd *slot, u64 cid, u64 dst_dma, u32 len)
+{
+       memset(slot, 0, sizeof(*slot));
+       slot->magic =3D VCQ_CMD_MAGIC;
+       slot->id =3D VCQ_CMD_ID(CORE_ID_SYS, 0, 1, SYS_CMD_FIND);
+       slot->hwc.sys.cmd_find.cid =3D cid;
+       slot->hwc.sys.cmd_find.dst =3D dst_dma;
+       slot->hwc.sys.cmd_find.len =3D len;
+}
+
+/**
+ * vcq_add_sys_list() - Build a SYS_LIST VCQ command
+ * @slot: VCQ command slot to populate
+ * @ref: Datastore object reference for enumeration start
+ * @dst_dma: DMA address of destination buffer for list
+ * @len: Length of destination buffer in bytes
+ */
+void vcq_add_sys_list(struct vcq_cmd *slot, u64 ref, u64 dst_dma, u32 len)
+{
+       memset(slot, 0, sizeof(*slot));
+       slot->magic =3D VCQ_CMD_MAGIC;
+       slot->id =3D VCQ_CMD_ID(CORE_ID_SYS, 0, 1, SYS_CMD_LIST);
+       slot->hwc.sys.cmd_list.ref =3D ref;
+       slot->hwc.sys.cmd_list.dst =3D dst_dma;
+       slot->hwc.sys.cmd_list.len =3D len;
+}
+
+/**
+ * vcq_add_sys_grant() - Build a SYS_GRANT VCQ command
+ * @slot: VCQ command slot to populate
+ * @ref: Datastore object reference handle
+ * @read: Read permission bitmask
+ * @write: Write permission bitmask
+ * @execute: Execute permission bitmask
+ */
+void vcq_add_sys_grant(struct vcq_cmd *slot, u64 ref, u64 read,
+                      u64 write, u64 execute)
+{
+       memset(slot, 0, sizeof(*slot));
+       slot->magic =3D VCQ_CMD_MAGIC;
+       slot->id =3D VCQ_CMD_ID(CORE_ID_SYS, 0, 1, SYS_CMD_GRANT);
+       slot->hwc.sys.cmd_grant.ref =3D ref;
+       slot->hwc.sys.cmd_grant.read =3D read;
+       slot->hwc.sys.cmd_grant.write =3D write;
+       slot->hwc.sys.cmd_grant.execute =3D execute;
+}
+
+/**
+ * vcq_add_sys_export() - Build a SYS_EXPORT VCQ command
+ * @slot: VCQ command slot to populate
+ * @cid: Content identifier of object to export
+ * @dst_dma: DMA address of destination buffer for wrapped blob
+ * @wrap_key: Wrapping key reference for export
+ * @len: Length of destination buffer in bytes
+ */
+void vcq_add_sys_export(struct vcq_cmd *slot, u64 cid, u64 dst_dma,
+                       u64 wrap_key, u32 len)
+{
+       memset(slot, 0, sizeof(*slot));
+       slot->magic =3D VCQ_CMD_MAGIC;
+       slot->id =3D VCQ_CMD_ID(CORE_ID_SYS, 0, 1, SYS_CMD_EXPORT);
+       slot->hwc.sys.cmd_export.cid =3D cid;
+       slot->hwc.sys.cmd_export.dst =3D dst_dma;
+       slot->hwc.sys.cmd_export.key =3D wrap_key;
+       slot->hwc.sys.cmd_export.len =3D len;
+}
+
+/**
+ * vcq_add_sys_import() - Build a SYS_IMPORT VCQ command
+ * @slot: VCQ command slot to populate
+ * @src_dma: DMA address of wrapped datastore blob to import
+ * @wrap_key: Wrapping key reference for unwrapping
+ * @len: Length of wrapped blob in bytes
+ */
+void vcq_add_sys_import(struct vcq_cmd *slot, u64 src_dma,
+                       u64 wrap_key, u32 len)
+{
+       memset(slot, 0, sizeof(*slot));
+       slot->magic =3D VCQ_CMD_MAGIC;
+       slot->id =3D VCQ_CMD_ID(CORE_ID_SYS, 0, 1, SYS_CMD_IMPORT);
+       slot->hwc.sys.cmd_import.src =3D src_dma;
+       slot->hwc.sys.cmd_import.key =3D wrap_key;
+       slot->hwc.sys.cmd_import.len =3D len;
+}
+
+/* -- KIC Core VCQ Builders --------------------- */
+
+/**
+ * vcq_add_kic_hkdf1() - Build a KIC HKDF-Expand VCQ command
+ * @slot: VCQ command slot to populate
+ * @dst: Datastore reference for derived key output
+ * @base: Datastore reference for base key input
+ * @label_dma: DMA address of HKDF label/info buffer
+ * @key_len: Derived key length in bytes
+ * @label_len: Length of label buffer in bytes
+ * @type: Derived key datastore type
+ */
+void vcq_add_kic_hkdf1(struct vcq_cmd *slot, u64 dst, u64 base,
+                      u64 label_dma, u32 key_len, u32 label_len, u32 type)
+{
+       memset(slot, 0, sizeof(*slot));
+       slot->magic =3D VCQ_CMD_MAGIC;
+       slot->id =3D VCQ_CMD_ID(CORE_ID_KIC, 0, 1, KIC_CMD_HKDF1);
+       slot->hwc.kic.cmd_hkdf1.dst =3D dst;
+       slot->hwc.kic.cmd_hkdf1.base =3D base;
+       slot->hwc.kic.cmd_hkdf1.label =3D label_dma;
+       slot->hwc.kic.cmd_hkdf1.llen =3D label_len;
+       slot->hwc.kic.cmd_hkdf1.len =3D key_len;
+       slot->hwc.kic.cmd_hkdf1.type =3D type;
+}
+
+/**
+ * vcq_add_kic_hkdf2() - Build a KIC HKDF-with-salt VCQ command
+ * @slot: VCQ command slot to populate
+ * @dst: Datastore reference for derived key output
+ * @base: Datastore reference for base key input
+ * @salt: Datastore reference for HKDF salt key
+ * @label_dma: DMA address of HKDF label/info buffer
+ * @key_len: Derived key length in bytes
+ * @label_len: Length of label buffer in bytes
+ * @type: Derived key datastore type
+ */
+void vcq_add_kic_hkdf2(struct vcq_cmd *slot, u64 dst, u64 base, u64 salt,
+                      u64 label_dma, u32 key_len, u32 label_len, u32 type)
+{
+       memset(slot, 0, sizeof(*slot));
+       slot->magic =3D VCQ_CMD_MAGIC;
+       slot->id =3D VCQ_CMD_ID(CORE_ID_KIC, 0, 1, KIC_CMD_HKDF2);
+       slot->hwc.kic.cmd_hkdf2.dst =3D dst;
+       slot->hwc.kic.cmd_hkdf2.base =3D base;
+       slot->hwc.kic.cmd_hkdf2.salt =3D salt;
+       slot->hwc.kic.cmd_hkdf2.label =3D label_dma;
+       slot->hwc.kic.cmd_hkdf2.llen =3D label_len;
+       slot->hwc.kic.cmd_hkdf2.len =3D key_len;
+       slot->hwc.kic.cmd_hkdf2.type =3D type;
+}
+
+/**
+ * vcq_add_kic_aes_cmac_kdf() - Build a KIC AES-CMAC KDF VCQ command
+ * @slot: VCQ command slot to populate
+ * @out_key: Datastore reference for derived key output
+ * @base_key: Datastore reference for base key input
+ * @label_dma: DMA address of KDF label buffer
+ * @key_len: Derived key length in bytes
+ * @label_len: Length of label buffer in bytes
+ * @type: Derived key datastore type
+ */
+void vcq_add_kic_aes_cmac_kdf(struct vcq_cmd *slot, u64 out_key, u64 base_=
key,
+                             u64 label_dma, u32 key_len, u32 label_len,
+                             u32 type)
+{
+       memset(slot, 0, sizeof(*slot));
+       slot->magic =3D VCQ_CMD_MAGIC;
+       slot->id =3D VCQ_CMD_ID(CORE_ID_KIC, 0, 1, KIC_CMD_AES_CMAC_KDF);
+       slot->hwc.kic.cmd_aes_cmac_kdf.base_key =3D base_key;
+       slot->hwc.kic.cmd_aes_cmac_kdf.out_key =3D out_key;
+       slot->hwc.kic.cmd_aes_cmac_kdf.label =3D label_dma;
+       slot->hwc.kic.cmd_aes_cmac_kdf.key_len =3D key_len;
+       slot->hwc.kic.cmd_aes_cmac_kdf.label_len =3D label_len;
+       slot->hwc.kic.cmd_aes_cmac_kdf.type =3D type;
+}
+
+/**
+ * vcq_add_kic_dkek_derive() - Build a KIC DKEK derivation VCQ command
+ * @slot: VCQ command slot to populate
+ * @out_key: Datastore reference for derived DKEK output
+ * @base_key: Datastore reference for base key input
+ * @host_id: Host identifier for key binding
+ * @metadata_dma: DMA address of derivation metadata buffer
+ * @metadata_len: Length of metadata buffer in bytes
+ */
+void vcq_add_kic_dkek_derive(struct vcq_cmd *slot, u64 out_key, u64 base_k=
ey,
+                            u32 host_id, u64 metadata_dma, u32 metadata_le=
n)
+{
+       memset(slot, 0, sizeof(*slot));
+       slot->magic =3D VCQ_CMD_MAGIC;
+       slot->id =3D VCQ_CMD_ID(CORE_ID_KIC, 0, 1, KIC_CMD_DKEK_DERIVE);
+       slot->hwc.kic.cmd_dkek_derive.base_key =3D base_key;
+       slot->hwc.kic.cmd_dkek_derive.out_key =3D out_key;
+       slot->hwc.kic.cmd_dkek_derive.host_id =3D host_id;
+       slot->hwc.kic.cmd_dkek_derive.metadata =3D metadata_dma;
+       slot->hwc.kic.cmd_dkek_derive.metadata_len =3D metadata_len;
+}
+
+/* -- DRBG Core VCQ Builders -------------------- */
+
+/**
+ * vcq_add_drbg_reset() - Build a DRBG reset VCQ command
+ * @slot: VCQ command slot to populate
+ *
+ * Issues DRBG_CMD_RESET which clears the instantiated state, allowing
+ * a subsequent CONFIG to proceed without a double-instantiate error.
+ */
+void vcq_add_drbg_reset(struct vcq_cmd *slot)
+{
+       memset(slot, 0, sizeof(*slot));
+       slot->magic =3D VCQ_CMD_MAGIC;
+       slot->id =3D VCQ_CMD_ID(CORE_ID_DRBG, 0, 1, DRBG_CMD_RESET);
+}
+
+/**
+ * vcq_add_drbg_config() - Build a DRBG configuration VCQ command
+ * @slot: VCQ command slot to populate
+ * @ratio: Entropy-to-output ratio
+ * @strength: Security strength in bits
+ */
+void vcq_add_drbg_config(struct vcq_cmd *slot, u32 ratio, u32 strength)
+{
+       memset(slot, 0, sizeof(*slot));
+       slot->magic =3D VCQ_CMD_MAGIC;
+       slot->id =3D VCQ_CMD_ID(CORE_ID_DRBG, 0, 1, DRBG_CMD_CONFIG);
+       slot->hwc.drbg.cmd_config.entropy_ratio =3D ratio;
+       slot->hwc.drbg.cmd_config.security_strength =3D strength;
+}
+
+/**
+ * vcq_add_drbg_datastore() - Build a DRBG datastore setup VCQ command
+ * @slot: VCQ command slot to populate
+ * @ref: Datastore object reference handle
+ * @len: Length of datastore allocation in bytes
+ * @type: Datastore object type
+ */
+void vcq_add_drbg_datastore(struct vcq_cmd *slot, u64 ref, u32 len, u32 ty=
pe)
+{
+       memset(slot, 0, sizeof(*slot));
+       slot->magic =3D VCQ_CMD_MAGIC;
+       slot->id =3D VCQ_CMD_ID(CORE_ID_DRBG, 0, 1, DRBG_CMD_DATASTORE);
+       slot->hwc.drbg.cmd_datastore.ref =3D ref;
+       slot->hwc.drbg.cmd_datastore.len =3D len;
+       slot->hwc.drbg.cmd_datastore.type =3D type;
+}
+
+/* -- EAC Core VCQ Builder ---------------------- */
+
+/**
+ * vcq_add_eac_read() - Build an EAC read VCQ command
+ * @slot: VCQ command slot to populate
+ * @dst_dma: DMA address of destination buffer
+ * @len: Length of data to read in bytes
+ */
+void vcq_add_eac_read(struct vcq_cmd *slot, u64 dst_dma, u32 len)
+{
+       memset(slot, 0, sizeof(*slot));
+       slot->magic =3D VCQ_CMD_MAGIC;
+       slot->id =3D VCQ_CMD_ID(CORE_ID_EAC, 0, 1, EAC_CMD_READ);
+       slot->hwc.eac.cmd_read.dst =3D dst_dma;
+       slot->hwc.eac.cmd_read.len =3D len;
+}
diff --git a/drivers/crypto/cmh/include/cmh_key.h b/drivers/crypto/cmh/incl=
ude/cmh_key.h
new file mode 100644
index 000000000000..bad69c92b892
--- /dev/null
+++ b/drivers/crypto/cmh/include/cmh_key.h
@@ -0,0 +1,82 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2026 Cryptography Research, Inc. (CRI).
+ * CMH LKM -- Per-transform key context
+ *
+ * Per-transform key context used by all keyed crypto algorithms (AES,
+ * SM4, CCP, HMAC, KMAC).  Stores raw key bytes supplied via the crypto
+ * API .setkey() callback: the key is DMA-mapped once at setkey time and
+ * written to SYS_REF_TEMP in every VCQ.
+ *
+ * Each keyed algorithm driver embeds a struct cmh_key_ctx in its
+ * per-transform context and calls cmh_key_setkey_raw() from its
+ * .setkey() callback.
+ *
+ * Raw-key atomicity (SYS_REF_TEMP)
+ * ---------------------------------
+ * SYS_CMD_WRITE to SYS_REF_TEMP is packed into the same VCQ as the
+ * algorithm commands (AES_CMD_INIT, HC_CMD_HMAC, etc.).  SYS_REF_TEMP
+ * is per-MBX -- the CMH eSW allocates it in the tail of each mailbox's
+ * own VCQ buffer (mbx_alloc_temp), so concurrent raw-key requests on
+ * different MBXes do not interfere.
+ */
+
+#ifndef CMH_KEY_H
+#define CMH_KEY_H
+
+#include <linux/types.h>
+#include "cmh_config.h"
+#include "cmh_vcq.h"
+
+/* Key context mode */
+enum cmh_key_mode {
+       CMH_KEY_NONE =3D 0,       /* no key set yet */
+       CMH_KEY_RAW,            /* raw key bytes in memory */
+};
+
+/* Per-transform key context */
+struct cmh_key_ctx {
+       enum cmh_key_mode mode;
+       struct {
+               u8 *data;       /* kmemdup'd raw key bytes */
+               u32 len;        /* key length in bytes */
+               u32 sys_type;   /* SYS_TYPE_SET(flags, core_id) */
+               dma_addr_t dma; /* pre-mapped DMA addr (DMA_TO_DEVICE) */
+       } raw;
+};
+
+/**
+ * cmh_key_setkey_raw() - Store raw key bytes in the transform context
+ * @ctx: Per-transform key context
+ * @key: Raw key bytes
+ * @keylen: Key length in bytes
+ * @core_id: Target algorithm core (e.g. CORE_ID_AES)
+ *
+ * SYS_TYPE_FLAG_PT is set so the written temp key
+ * can be read back as plaintext if needed.  The actual SYS_CMD_WRITE
+ * to SYS_REF_TEMP is deferred to each encrypt/decrypt VCQ, where it
+ * is packed inline for atomicity.
+ *
+ * Return: 0 on success, -ENOMEM on allocation failure.
+ */
+int cmh_key_setkey_raw(struct cmh_key_ctx *ctx, const u8 *key,
+                      u32 keylen, u32 core_id);
+
+/**
+ * cmh_key_destroy() - Free key resources
+ * @ctx: Per-transform key context
+ *
+ * Zeroises and frees the raw key buffer.
+ */
+void cmh_key_destroy(struct cmh_key_ctx *ctx);
+
+/**
+ * cmh_ds_type_to_core_id() - Map datastore key type to core ID
+ * @ds_type: CMH_DS_* key type constant
+ *
+ * Return: Corresponding CORE_ID_*, or CORE_ID_NUM (0x1F) on
+ *         unrecognised type (caller should return -EINVAL).
+ */
+u32 cmh_ds_type_to_core_id(u32 ds_type);
+
+#endif /* CMH_KEY_H */
diff --git a/drivers/crypto/cmh/include/cmh_mgmt.h b/drivers/crypto/cmh/inc=
lude/cmh_mgmt.h
new file mode 100644
index 000000000000..b211014bd71d
--- /dev/null
+++ b/drivers/crypto/cmh/include/cmh_mgmt.h
@@ -0,0 +1,62 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2026 Cryptography Research, Inc. (CRI).
+ * CMH -- Key Management misc_device (/dev/cmh_mgmt)
+ *
+ * ioctl interface for key CRUD + datastore export/import,
+ * PKE operations (RSA, ECDSA, ECDH, EdDSA),
+ * and PQC operations (ML-KEM, ML-DSA, SLH-DSA).
+ *
+ * Registered alongside crypto algorithms in module_init,
+ * unregistered before them in module_exit.
+ */
+
+#ifndef CMH_MGMT_H
+#define CMH_MGMT_H
+
+#ifdef CONFIG_CRYPTO_DEV_CMH_MGMT
+
+/*
+ * Pin all mgmt ioctls to MBX 0 for DS ownership and SYS_REF_TEMP scope.
+ * Shared by cmh_mgmt.c, cmh_mgmt_pke.c, cmh_mgmt_pqc.c, cmh_pke_sm2.c.
+ */
+#define MGMT_MBX       0
+
+/* Maximum DMA buffer size for key data / datastore blobs */
+#define CMH_MGMT_MAX_DATA_LEN  (256 * 1024)  /* 256 KB */
+
+int  cmh_mgmt_register(void);
+void cmh_mgmt_unregister(void);
+
+/* -- PKE ioctl handlers (cmh_mgmt_pke.c) -- */
+int cmh_mgmt_pke_rsa_enc(void __user *argp);
+int cmh_mgmt_pke_rsa_dec(void __user *argp);
+int cmh_mgmt_pke_rsa_crt_dec(void __user *argp);
+int cmh_mgmt_pke_rsa_keygen(void __user *argp);
+int cmh_mgmt_pke_ecdsa_sign(void __user *argp);
+int cmh_mgmt_pke_ecdh(void __user *argp);
+int cmh_mgmt_pke_ecdh_keygen(void __user *argp);
+int cmh_mgmt_pke_eddsa_sign(void __user *argp);
+int cmh_mgmt_pke_eddsa_verify(void __user *argp);
+int cmh_mgmt_pke_ec_keygen(void __user *argp);
+int cmh_mgmt_pke_ec_pubgen(void __user *argp);
+int cmh_mgmt_pke_eddsa_keygen_sca(void __user *argp);
+
+/* -- PQC ioctl handlers (cmh_mgmt_pqc.c) -- */
+int cmh_mgmt_ml_kem_keygen(void __user *argp);
+int cmh_mgmt_ml_kem_enc(void __user *argp);
+int cmh_mgmt_ml_kem_dec(void __user *argp);
+int cmh_mgmt_ml_dsa_keygen(void __user *argp);
+int cmh_mgmt_ml_dsa_sign(void __user *argp);
+int cmh_mgmt_slhdsa_keygen(void __user *argp);
+int cmh_mgmt_slhdsa_sign(void __user *argp);
+int cmh_mgmt_slhdsa_sign_prehash(void __user *argp);
+
+#else /* !CONFIG_CRYPTO_DEV_CMH_MGMT */
+
+static inline int  cmh_mgmt_register(void) { return 0; }
+static inline void cmh_mgmt_unregister(void) { }
+
+#endif /* CONFIG_CRYPTO_DEV_CMH_MGMT */
+
+#endif /* CMH_MGMT_H */
diff --git a/drivers/crypto/cmh/include/cmh_pke.h b/drivers/crypto/cmh/incl=
ude/cmh_pke.h
new file mode 100644
index 000000000000..dcfdb3fc3cd6
--- /dev/null
+++ b/drivers/crypto/cmh/include/cmh_pke.h
@@ -0,0 +1,245 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2026 Cryptography Research, Inc. (CRI).
+ * CMH LKM -- PKE Common Types and Helpers
+ *
+ * Shared definitions for RSA, ECDSA, ECDH, EdDSA, and SM2 drivers.
+ * Curve -> coordinate-length mapping, VCQ byte-swap flags, and
+ * common VCQ builder prototypes.
+ */
+
+#ifndef CMH_PKE_H
+#define CMH_PKE_H
+
+#include <linux/types.h>
+#include "cmh_vcq.h"
+#include "cmh_pke_abi.h"
+
+/* VCQ byte-swap flags for DMA transfers (per CMH VCQ ABI) */
+#define VCQ_FLAG_SWAP_BYTES    0x400000U
+#define VCQ_FLAG_SWAP_WORDS    0x200000U
+
+/* VCQ byte-swap flags for PKE -- big-endian data on LE bus */
+#define PKE_SWAP_FLAGS (VCQ_FLAG_SWAP_BYTES | VCQ_FLAG_SWAP_WORDS)
+
+/* VCQ layout: header + [SYS_WRITE] + PKE_CMD + flush */
+#define PKE_VCQ_CMDS_MIN       3       /* header + cmd + flush */
+#define PKE_VCQ_CMDS_MAX       4       /* header + SYS_WRITE + cmd + flush=
 */
+
+/* Max RSA key size in bytes (4096 bits) */
+#define PKE_RSA_MAX_BYTES      512
+#define PKE_RSA_MIN_BITS       1024
+#define PKE_RSA_MAX_BITS       4096
+
+/* EdDSA SCA: Ed448 blinded private key length (bytes) */
+#define PKE_ED448_SK_SCA_LEN   226
+
+/**
+ * pke_curve_clen() - Get EC curve coordinate length in bytes
+ * @curve: PKE curve identifier (PKE_CURVE_*)
+ *
+ * Return: Coordinate length in bytes, or 0 for unknown curves.
+ */
+static inline u32 pke_curve_clen(u32 curve)
+{
+       switch (curve) {
+       case PKE_CURVE_P192:
+       case PKE_CURVE_BP192R1:
+               return 24;
+       case PKE_CURVE_P224:
+       case PKE_CURVE_BP224R1:
+               return 28;
+       case PKE_CURVE_P256:
+       case PKE_CURVE_SECP256K1:
+       case PKE_CURVE_BP256R1:
+       case PKE_CURVE_ANSSI_FRP256V1:
+       case PKE_CURVE_SM2:
+       case PKE_CURVE_25519:
+               return 32;
+       case PKE_CURVE_BP320R1:
+               return 40;
+       case PKE_CURVE_P384:
+       case PKE_CURVE_BP384R1:
+               return 48;
+       case PKE_CURVE_BP512R1:
+               return 64;
+       case PKE_CURVE_P521:
+               return 68; /* ceil(521/8) =3D 66, ABI uses ALIGN(66, 4) =3D=
 68 */
+       case PKE_CURVE_448:
+               return 56;
+       default:
+               return 0;
+       }
+}
+
+/**
+ * pke_curve_bits() - Get EC curve size in bits
+ * @curve: PKE curve identifier (PKE_CURVE_*)
+ *
+ * Return: Curve size in bits, or 0 for unknown curves.
+ */
+static inline u32 pke_curve_bits(u32 curve)
+{
+       switch (curve) {
+       case PKE_CURVE_P192:
+       case PKE_CURVE_BP192R1:
+               return 192;
+       case PKE_CURVE_P224:
+       case PKE_CURVE_BP224R1:
+               return 224;
+       case PKE_CURVE_P256:
+       case PKE_CURVE_SECP256K1:
+       case PKE_CURVE_BP256R1:
+       case PKE_CURVE_ANSSI_FRP256V1:
+       case PKE_CURVE_SM2:
+       case PKE_CURVE_25519:
+               return 256;
+       case PKE_CURVE_BP320R1:
+               return 320;
+       case PKE_CURVE_P384:
+       case PKE_CURVE_BP384R1:
+               return 384;
+       case PKE_CURVE_BP512R1:
+               return 512;
+       case PKE_CURVE_P521:
+               return 521;
+       case PKE_CURVE_448:
+               return 448;
+       default:
+               return 0;
+       }
+}
+
+/**
+ * pke_eddsa_key_len() - Get EdDSA key/pubkey length
+ * @curve: PKE curve identifier (PKE_CURVE_25519 or PKE_CURVE_448)
+ *
+ * Ed25519 uses 32 bytes (=3D=3D clen), Ed448 uses 57 bytes (clen + 1
+ * flag byte per RFC 8032).  Signature length is 2 * pke_eddsa_key_len().
+ *
+ * Return: Key length in bytes.
+ */
+static inline u32 pke_eddsa_key_len(u32 curve)
+{
+       u32 clen =3D pke_curve_clen(curve);
+
+       return (curve =3D=3D PKE_CURVE_448) ? clen + 1 : clen;
+}
+
+/**
+ * pke_curve_is_edwards() - Check if curve uses Edwards form
+ * @curve: PKE curve identifier (PKE_CURVE_*)
+ *
+ * Return: true for Curve25519 and Curve448, false otherwise.
+ */
+static inline bool pke_curve_is_edwards(u32 curve)
+{
+       return curve =3D=3D PKE_CURVE_25519 || curve =3D=3D PKE_CURVE_448;
+}
+
+/**
+ * pke_swap_flags() - Get VCQ byte-swap flags for a given curve
+ * @curve: PKE curve identifier (PKE_CURVE_*)
+ *
+ * Weierstrass curves need byte+word swap; Edwards curves do not.
+ *
+ * Return: VCQ swap flags to OR into the command ID.
+ */
+static inline u32 pke_swap_flags(u32 curve)
+{
+       return pke_curve_is_edwards(curve) ? 0 : PKE_SWAP_FLAGS;
+}
+
+/* Common VCQ builder prototypes */
+
+void vcq_add_pke_flush(struct vcq_cmd *slot, u32 core_id);
+
+void vcq_add_pke_rsa_enc(struct vcq_cmd *slot, u32 core_id, u32 bits, u32 =
e_len,
+                        u64 e_dma, u64 n_dma, u64 m_dma, u64 c_dma,
+                        u32 flags);
+
+void vcq_add_pke_rsa_dec(struct vcq_cmd *slot, u32 core_id, u32 bits, u32 =
e_len,
+                        u64 e_dma, u64 n_dma, u64 c_dma, u64 m_dma,
+                        u64 d_ref, u32 flags);
+
+void vcq_add_pke_rsa_crt_dec(struct vcq_cmd *slot, u32 core_id, u32 bits, =
u32 e_len,
+                            u64 e_dma, u64 n_dma, u64 c_dma, u64 m_dma,
+                            u64 crt_ref, u32 flags);
+
+void vcq_add_pke_ecdsa_verify(struct vcq_cmd *slot, u32 core_id, u32 curve=
, u32 dlen,
+                             u64 pk_dma, u64 dig_dma, u64 sig_dma,
+                             u64 rp_dma, u32 flags);
+
+void vcq_add_pke_ecdsa_sign(struct vcq_cmd *slot, u32 core_id, u32 curve, =
u32 sklen,
+                           u64 dig_dma, u64 sig_dma, u64 sk_ref,
+                           u32 dlen, u32 flags);
+
+void vcq_add_pke_ecdsa_pubgen(struct vcq_cmd *slot, u32 core_id, u32 curve=
, u32 sklen,
+                             u64 pk_dma, u64 sk_ref, u32 flags);
+
+void vcq_add_pke_ecdsa_keygen(struct vcq_cmd *slot, u32 core_id, u32 curve=
, u32 sklen,
+                             u64 sk_ref, u32 sk_type, u32 flags);
+
+void vcq_add_pke_ecdh_keygen(struct vcq_cmd *slot, u32 core_id, u32 curve,=
 u32 sklen,
+                            u64 pkx_dma, u64 sk_ref, u32 flags);
+
+void vcq_add_pke_ecdh(struct vcq_cmd *slot, u32 core_id, u32 curve, u32 sk=
len,
+                     u32 sslen, u32 ss_type, u64 peer_dma, u64 sk_ref,
+                     u64 ss_ref, u32 flags);
+
+void vcq_add_pke_eddsa_verify(struct vcq_cmd *slot, u32 core_id, u32 curve=
, u32 dlen,
+                             u64 pky_dma, u64 dig_dma, u64 sig_dma,
+                             u64 rp_dma, u32 flags);
+
+void vcq_add_pke_eddsa_sign(struct vcq_cmd *slot, u32 core_id, u32 curve, =
u32 sklen,
+                           u64 dig_dma, u64 sig_dma, u64 sk_ref,
+                           u32 dlen, u32 flags);
+
+void vcq_add_pke_eddsa_pubgen(struct vcq_cmd *slot, u32 core_id, u32 curve=
, u32 sklen,
+                             u64 pky_dma, u64 sk_ref, u32 flags);
+
+void vcq_add_pke_eddsa_keygen_sca(struct vcq_cmd *slot, u32 core_id, u32 c=
urve,
+                                 u64 sk_ref, u64 sca_sk_ref);
+
+/* SM2 VCQ builders */
+
+void vcq_add_pke_sm2_ecdh_keygen(struct vcq_cmd *slot, u32 core_id, u64 no=
nce_dma,
+                                u64 session_key_dma, u32 nonce_len, u32 fl=
ags);
+
+void vcq_add_pke_sm2_ecdh(struct vcq_cmd *slot, u32 core_id, u32 nonce_len=
,
+                         u32 private_key_len, u64 nonce_dma,
+                         u64 peer_pk_dma, u64 peer_sk_dma,
+                         u64 priv_ref, u64 sp_ref, u32 sp_type, u32 flags)=
;
+
+void vcq_add_pke_sm2_dec_point(struct vcq_cmd *slot, u32 core_id, u32 ct_l=
en,
+                              u32 pk_len, u64 ct_dma, u64 dp_dma,
+                              u64 priv_ref, u32 flags);
+
+void vcq_add_pke_sm2_enc_point(struct vcq_cmd *slot, u32 core_id, u64 nonc=
e_dma,
+                              u64 pk_dma, u64 ct_dma, u64 ep_dma,
+                              u32 nonce_len, u32 flags);
+
+void vcq_add_pke_sm2_id_digest(struct vcq_cmd *slot, u32 core_id, u64 id_d=
ma,
+                              u64 pk_dma, u64 dig_dma, u32 id_len,
+                              u32 flags);
+
+void vcq_add_pke_sm2_ecdh_hash(struct vcq_cmd *slot, u32 core_id, u64 peer=
_dig_dma,
+                              u64 dig_dma, u64 sp_ref, u64 sk_ref,
+                              u32 sk_type, u32 flags);
+
+void vcq_add_pke_sm2_dec_hash(struct vcq_cmd *slot, u32 core_id, u64 ct_dm=
a,
+                             u64 dp_dma, u64 pt_dma, u32 ct_len, u32 flags=
);
+
+void vcq_add_pke_sm2_enc_hash(struct vcq_cmd *slot, u32 core_id, u64 msg_d=
ma,
+                             u64 ep_dma, u64 ct_dma, u32 msg_len, u32 flag=
s);
+
+/* Registration */
+
+int cmh_pke_rsa_register(void);
+void cmh_pke_rsa_unregister(void);
+int cmh_pke_ecdsa_register(void);
+void cmh_pke_ecdsa_unregister(void);
+int cmh_pke_ecdh_register(void);
+void cmh_pke_ecdh_unregister(void);
+
+#endif /* CMH_PKE_H */
diff --git a/drivers/crypto/cmh/include/cmh_pke_sm2.h b/drivers/crypto/cmh/=
include/cmh_pke_sm2.h
new file mode 100644
index 000000000000..a2c7164b8d49
--- /dev/null
+++ b/drivers/crypto/cmh/include/cmh_pke_sm2.h
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2026 Cryptography Research, Inc. (CRI).
+ * CMH LKM -- SM2 PKE Ioctl Handler Declarations
+ *
+ * SM2 signature (GM/T 0003.2) requires the caller to compute
+ * ZA =3D SM3(ENTLA || IDA || a || b || xG || yG || xA || yA)
+ * and pass SM3(ZA || M) as the digest to the sign/verify path.
+ * The CMH eSW does NOT compute ZA internally; the full
+ * identity pre-hash is the caller's responsibility.
+ *
+ * For the in-kernel akcipher "sm2" algorithm this means the
+ * caller (e.g. asymmetric_key subsystem) must pre-hash with ZA
+ * before invoking verify.  The SM2_ID_DIGEST ioctl below can
+ * compute ZA for userspace callers of the misc-device path.
+ */
+
+#ifndef CMH_PKE_SM2_H
+#define CMH_PKE_SM2_H
+
+int cmh_mgmt_sm2_ecdh_keygen(void __user *argp);
+int cmh_mgmt_sm2_ecdh(void __user *argp);
+int cmh_mgmt_sm2_dec_point(void __user *argp);
+int cmh_mgmt_sm2_enc_point(void __user *argp);
+int cmh_mgmt_sm2_id_digest(void __user *argp);
+int cmh_mgmt_sm2_ecdh_hash(void __user *argp);
+int cmh_mgmt_sm2_dec_hash(void __user *argp);
+int cmh_mgmt_sm2_enc_hash(void __user *argp);
+
+#endif /* CMH_PKE_SM2_H */
diff --git a/drivers/crypto/cmh/include/cmh_pqc.h b/drivers/crypto/cmh/incl=
ude/cmh_pqc.h
new file mode 100644
index 000000000000..cd4761a0ce5c
--- /dev/null
+++ b/drivers/crypto/cmh/include/cmh_pqc.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2026 Cryptography Research, Inc. (CRI).
+ * CMH LKM -- PQC Algorithm Registration
+ *
+ * Registration/unregistration functions for PQC akcipher algorithms:
+ * ML-DSA, SLH-DSA, LMS, XMSS.
+ */
+
+#ifndef CMH_PQC_H
+#define CMH_PQC_H
+
+int cmh_pqc_mldsa_register(void);
+void cmh_pqc_mldsa_unregister(void);
+
+int cmh_pqc_slhdsa_register(void);
+void cmh_pqc_slhdsa_unregister(void);
+
+int cmh_pqc_lms_register(void);
+void cmh_pqc_lms_unregister(void);
+
+int cmh_pqc_xmss_register(void);
+void cmh_pqc_xmss_unregister(void);
+
+#endif /* CMH_PQC_H */
diff --git a/drivers/crypto/cmh/include/cmh_sys.h b/drivers/crypto/cmh/incl=
ude/cmh_sys.h
new file mode 100644
index 000000000000..dd336b67bd65
--- /dev/null
+++ b/drivers/crypto/cmh/include/cmh_sys.h
@@ -0,0 +1,111 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2026 Cryptography Research, Inc. (CRI).
+ * CMH LKM -- SYS Core VCQ Builders
+ *
+ * VCQ builder functions for SYS core commands (NEW, WRITE, READ,
+ * FIND, GRANT, DATA, EXPORT, IMPORT).  Each builder populates one
+ * vcq_cmd slot with the appropriate magic, command ID, and payload.
+ *
+ * Callers combine these with vcq_set_header() + vcq_add_flush()
+ * and submit via cmh_tm_submit_sync().
+ */
+
+#ifndef CMH_SYS_H
+#define CMH_SYS_H
+
+#include "cmh_vcq.h"
+
+void vcq_add_sys_new(struct vcq_cmd *slot, u64 cid, u64 ref_dma, u32 len);
+void vcq_add_sys_write(struct vcq_cmd *slot, u64 ref, u64 src_dma,
+                      u64 wrap_key, u32 len, u32 sys_type);
+void vcq_add_sys_read(struct vcq_cmd *slot, u64 ref, u64 dst_dma,
+                     u64 wrap_key, u32 len);
+void vcq_add_sys_data(struct vcq_cmd *slot, u64 ref, u64 dst_dma, u32 len)=
;
+void vcq_add_sys_find(struct vcq_cmd *slot, u64 cid, u64 dst_dma, u32 len)=
;
+void vcq_add_sys_list(struct vcq_cmd *slot, u64 ref, u64 dst_dma, u32 len)=
;
+void vcq_add_sys_grant(struct vcq_cmd *slot, u64 ref, u64 read,
+                      u64 write, u64 execute);
+void vcq_add_sys_export(struct vcq_cmd *slot, u64 cid, u64 dst_dma,
+                       u64 wrap_key, u32 len);
+void vcq_add_sys_import(struct vcq_cmd *slot, u64 src_dma,
+                       u64 wrap_key, u32 len);
+
+/* KIC core VCQ builders */
+void vcq_add_kic_hkdf1(struct vcq_cmd *slot, u64 dst, u64 base,
+                      u64 label_dma, u32 key_len, u32 label_len, u32 type)=
;
+void vcq_add_kic_hkdf2(struct vcq_cmd *slot, u64 dst, u64 base, u64 salt,
+                      u64 label_dma, u32 key_len, u32 label_len, u32 type)=
;
+void vcq_add_kic_aes_cmac_kdf(struct vcq_cmd *slot, u64 out_key, u64 base_=
key,
+                             u64 label_dma, u32 key_len, u32 label_len,
+                             u32 type);
+void vcq_add_kic_dkek_derive(struct vcq_cmd *slot, u64 out_key, u64 base_k=
ey,
+                            u32 host_id, u64 metadata_dma, u32 metadata_le=
n);
+
+/* DRBG core VCQ builders */
+void vcq_add_drbg_reset(struct vcq_cmd *slot);
+void vcq_add_drbg_config(struct vcq_cmd *slot, u32 ratio, u32 strength);
+void vcq_add_drbg_datastore(struct vcq_cmd *slot, u64 ref, u32 len, u32 ty=
pe);
+
+/* QSE core VCQ builders */
+void vcq_add_qse_flush(struct vcq_cmd *slot, u32 core_id);
+void vcq_add_qse_ml_kem_keygen(struct vcq_cmd *slot, u32 core_id, u32 k, u=
32 flags,
+                              u64 seed, u64 z, u64 ek, u64 dk, u32 dk_type=
,
+                              bool masked);
+void vcq_add_qse_ml_kem_enc(struct vcq_cmd *slot, u32 core_id, u32 k, u32 =
flags,
+                           u64 coin, u64 ek, u64 ct, u64 ss, u32 ss_type,
+                           bool masked);
+void vcq_add_qse_ml_kem_dec(struct vcq_cmd *slot, u32 core_id, u32 k, u32 =
flags,
+                           u64 ct, u64 dk, u64 ss, u32 ss_type,
+                           bool masked);
+void vcq_add_qse_ml_dsa_keygen(struct vcq_cmd *slot, u32 core_id, u32 mode=
, u32 flags,
+                              u64 seed, u64 pk, u64 sk, u32 sk_type,
+                              bool masked);
+void vcq_add_qse_ml_dsa_sign(struct vcq_cmd *slot, u32 core_id, u32 mode, =
u32 flags,
+                            u64 rnd, u64 m, u64 sk, u64 sig, u32 mlen,
+                            bool masked);
+void vcq_add_qse_ml_dsa_verify(struct vcq_cmd *slot, u32 core_id, u32 mode=
, u32 flags,
+                              u64 m, u64 pk, u64 sig, u32 mlen);
+
+/* HCQ core VCQ builders */
+void vcq_add_hcq_flush(struct vcq_cmd *slot, u32 core_id);
+void vcq_add_hcq_slhdsa_keygen(struct vcq_cmd *slot, u32 core_id, u32 para=
m_set,
+                              u32 seed_len, u32 pk_len, u32 sk_len,
+                              u64 seed, u64 pk, u64 sk);
+void vcq_add_hcq_slhdsa_sign(struct vcq_cmd *slot, u32 core_id, u32 param_=
set,
+                            u32 msg_len, u32 ctx_len,
+                            u64 add_random, u64 msg, u64 ctx,
+                            u64 sk, u64 sig);
+void vcq_add_hcq_slhdsa_sign_internal(struct vcq_cmd *slot, u32 core_id, u=
32 param_set,
+                                     u32 msg_len, u64 add_random,
+                                     u64 msg, u64 sk, u64 sig);
+void vcq_add_hcq_slhdsa_verify(struct vcq_cmd *slot, u32 core_id, u32 para=
m_set,
+                              u32 msg_len, u32 ctx_len,
+                              u64 msg, u64 ctx, u64 pk, u64 sig);
+void vcq_add_hcq_slhdsa_sign_prehash(struct vcq_cmd *slot, u32 core_id,
+                                    u32 cmd, u32 param_set, u32 prehash_al=
go,
+                                    u32 msg_len, u32 ctx_len,
+                                    u64 add_random, u64 msg, u64 ctx,
+                                    u64 sk, u64 sig);
+void vcq_add_hcq_slhdsa_verify_prehash(struct vcq_cmd *slot, u32 core_id,
+                                      u32 cmd, u32 param_set, u32 prehash_=
algo,
+                                      u32 msg_len, u32 ctx_len,
+                                      u64 msg, u64 ctx, u64 pk, u64 sig);
+void vcq_add_hcq_slhdsa_verify_internal(struct vcq_cmd *slot, u32 core_id,=
 u32 param_set,
+                                       u32 msg_len, u64 msg, u64 pk, u64 s=
ig);
+void vcq_add_hcq_slhdsa_pubgen(struct vcq_cmd *slot, u32 core_id, u32 para=
m_set,
+                              u32 sk_len, u64 sk, u64 pk);
+void vcq_add_hcq_lms_verify(struct vcq_cmd *slot, u32 core_id, u32 lms_hss=
,
+                           u32 pk_len, u32 sig_len, u32 dig_len,
+                           u64 pk, u64 sig, u64 dig);
+void vcq_add_hcq_xmss_verify(struct vcq_cmd *slot, u32 core_id, u32 xmss_m=
t,
+                            u32 pk_len, u32 sig_len, u32 dig_len,
+                            u64 pk, u64 sig, u64 dig);
+
+/* SYS core flush */
+void vcq_add_sys_flush(struct vcq_cmd *slot);
+
+/* EAC core VCQ builder */
+void vcq_add_eac_read(struct vcq_cmd *slot, u64 dst_dma, u32 len);
+
+#endif /* CMH_SYS_H */
diff --git a/include/uapi/linux/cmh_mgmt_ioctl.h b/include/uapi/linux/cmh_m=
gmt_ioctl.h
new file mode 100644
index 000000000000..a690454fae69
--- /dev/null
+++ b/include/uapi/linux/cmh_mgmt_ioctl.h
@@ -0,0 +1,895 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/*
+ * Copyright (c) 2026 Cryptography Research, Inc. (CRI).
+ * CMH LKM -- Key Management ioctl Interface (User-Space API)
+ *
+ * ioctl commands for /dev/cmh_mgmt -- key CRUD, datastore
+ * export/import, KIC key derivation, PKE, SM2, and PQC operations.
+ *
+ * Relationship to the in-kernel crypto API
+ * -----------------------------------------
+ * Most commands here have no crypto API representation (no transform
+ * type or verb exists): keystore CRUD, key generation, KIC key
+ * derivation, ML-KEM encapsulate/decapsulate, SM2 multi-step
+ * encrypt/decrypt/key-exchange, EdDSA, EAC, and DRBG configuration.
+ * For these the character device is the only available UAPI.
+ *
+ * A bounded subset names primitives the driver ALSO registers with
+ * the crypto API, and the overlap is intentional:
+ *   - Hardware-held-key operations (RSA decrypt, ECDSA/ML-DSA/SLH-DSA
+ *     sign, ECDH) reference a private key by datastore handle.  The
+ *     crypto API set_priv_key()/set_secret() take only raw key bytes
+ *     and cannot name a key that never leaves the hardware; these
+ *     ioctls keep the key hardware-resident.  The registered
+ *     transforms serve raw-key in-kernel users -- the paths are
+ *     complementary.
+ *
+ * Multi-step protocol flows are documented above the PKE and SM2
+ * struct sections.  Single-command ioctls are self-documenting.
+ *
+ * Versioned structs: user space sets .version =3D CMH_MGMT_V1 so the
+ * driver can extend structs in the future without breaking ABI.
+ */
+
+#ifndef _UAPI_CMH_MGMT_IOCTL_H
+#define _UAPI_CMH_MGMT_IOCTL_H
+
+#include <linux/types.h>
+#include <linux/ioctl.h>
+#include <linux/const.h>
+
+#define CMH_MGMT_V1            1
+
+/* Special reference values */
+#define CMH_REF_NONE           0x0000000000000000ULL   /* no key (plaintex=
t) */
+
+/* Flags for cmh_ioctl_key_new.flags / cmh_ioctl_key_write.flags */
+#define CMH_FLAG_PT            _BITUL(16)      /* key can be read as plain=
text */
+#define CMH_FLAG_XC            _BITUL(17)      /* key can be exported over=
 XC bus */
+#define CMH_FLAG_SCA           _BITUL(18)      /* SCA key stored in 2 shar=
es */
+#define CMH_FLAG_MASK          (CMH_FLAG_PT | CMH_FLAG_XC | CMH_FLAG_SCA)
+
+/*
+ * Datastore key types -- the LKM maps these to core IDs internally.
+ * User space passes these in cmh_ioctl_key_new.ds_type.
+ */
+#define CMH_DS_RAW_VALUE               1
+#define CMH_DS_AES_KEY                 2
+#define CMH_DS_AES_XTS_KEY             3
+#define CMH_DS_HMAC_KEY                        4
+#define CMH_DS_KMAC_KEY                        5
+#define CMH_DS_SM4_KEY                 6
+#define CMH_DS_CHACHA20_KEY            7
+
+/* PKE key types -- all map to CORE_ID_PKE (0x0A) */
+#define CMH_DS_RSA_PRIV_KEY            10
+#define CMH_DS_RSA_PUB_KEY             11
+#define CMH_DS_RSA_CRT_KEY             12
+#define CMH_DS_ECDSA_PRIV_KEY          13
+#define CMH_DS_ECDSA_PUB_KEY           14
+#define CMH_DS_ECDH_PRIV_KEY           15
+#define CMH_DS_EDDSA_PRIV_KEY          16
+#define CMH_DS_SHARED_SECRET           17
+#define CMH_DS_SM2_PRIV_KEY            18
+
+/* QSE key types -- map to CORE_ID_QSE (0x09) */
+#define CMH_DS_ML_KEM_DK               20
+#define CMH_DS_ML_DSA_SK               21
+
+/* HCQ key types -- map to CORE_ID_HCQ (0x08) */
+#define CMH_DS_SLHDSA_SK               25
+
+/* ioctl argument structures */
+
+struct cmh_ioctl_key_new {
+       __u32 version;          /* must be CMH_MGMT_V1 */
+       __u32 ds_type;          /* CMH_DS_* key type */
+       __u32 len;              /* key length in bytes */
+       __u32 flags;            /* CMH_FLAG_* (e.g. CMH_FLAG_PT) */
+       __u64 cid;              /* caller ID (name) for the key */
+       __u64 ref;              /* [out] CMH eSW returns key_ref here */
+};
+
+struct cmh_ioctl_key_write {
+       __u32 version;
+       __u32 len;              /* key data length */
+       __u32 ds_type;          /* CMH_DS_* key type */
+       __u32 flags;            /* CMH_FLAG_* (e.g. CMH_FLAG_PT) */
+       __u64 ref;              /* key reference from KEY_NEW */
+       __u64 wrap_key;         /* wrapping key ref (CMH_REF_NONE =3D plain=
text) */
+       __u64 data;             /* user-space pointer to key material */
+};
+
+struct cmh_ioctl_key_read {
+       __u32 version;
+       __u32 len;              /* buffer length */
+       __u64 ref;              /* key reference */
+       __u64 wrap_key;         /* wrapping key ref (CMH_REF_NONE =3D plain=
text) */
+       __u64 data;             /* user-space pointer to output buffer */
+       __u32 out_len;          /* [out] actual bytes written */
+       __u32 __reserved;
+};
+
+struct cmh_ioctl_key_find {
+       __u32 version;
+       __u32 __reserved;
+       __u64 cid;              /* caller ID to search for */
+       __u64 ref;              /* [out] resolved key reference */
+       __u32 len;              /* [out] key length */
+       __u32 type;             /* [out] key type */
+};
+
+/*
+ * KEY_LIST -- iterate datastore objects.
+ *
+ * Pass start_ref=3D0 to begin from the first accessible object.
+ * On return, ref/cid/len/type describe that object.  Pass the
+ * returned ref as start_ref in the next call to advance.  Iteration
+ * ends when ref =3D=3D 0 (no more objects).
+ */
+struct cmh_ioctl_key_list {
+       __u32 version;
+       __u32 __reserved;
+       __u64 start_ref;        /* starting DS reference (0 =3D first) */
+       __u64 ref;              /* [out] object reference */
+       __u64 cid;              /* [out] caller ID */
+       __u32 len;              /* [out] object length */
+       __u32 type;             /* [out] object type */
+};
+
+struct cmh_ioctl_key_grant {
+       __u32 version;
+       __u32 __reserved;
+       __u64 ref;              /* key reference */
+       __u64 read;             /* per-MBX read permission bitfield */
+       __u64 write;            /* per-MBX write permission bitfield */
+       __u64 execute;          /* per-MBX execute permission bitfield */
+};
+
+/* Export blob overhead beyond the raw object data (bytes) */
+#define CMH_DS_EXPORT_OVERHEAD_WRAPPED 48      /* 16B hdr + 16B nonce + 16=
B tag */
+#define CMH_DS_EXPORT_OVERHEAD_PLAIN   16      /* 16B hdr only */
+
+/**
+ * struct cmh_ioctl_ds_export - Export a datastore object to a wrapped blo=
b
+ * @version:   protocol version (CMH_MGMT_V1)
+ * @len:       DMA buffer size; must be >=3D export blob size:
+ *               wrapped:   CMH_DS_EXPORT_OVERHEAD_WRAPPED + object_len
+ *               plaintext: CMH_DS_EXPORT_OVERHEAD_PLAIN + object_len
+ *             object_len is known from KEY_NEW or KEY_FIND.
+ *             If too small, the eSW rejects the command (-EIO).
+ * @cid:       caller ID of the object to export
+ * @wrap_key:  wrapping key ref (CMH_REF_NONE =3D plaintext export)
+ * @data:      user-space pointer to output buffer (at least @len bytes)
+ * @out_len:   [out] actual blob bytes written on success
+ * @__reserved: must be zero
+ */
+struct cmh_ioctl_ds_export {
+       __u32 version;
+       __u32 len;              /* buffer length (see sizing rule above) */
+       __u64 cid;              /* caller ID for response tagging */
+       __u64 wrap_key;         /* wrapping key ref (CMH_REF_NONE =3D plain=
text) */
+       __u64 data;             /* user-space pointer to output buffer */
+       __u32 out_len;          /* [out] actual bytes written */
+       __u32 __reserved;
+};
+
+struct cmh_ioctl_ds_import {
+       __u32 version;
+       __u32 len;              /* blob length */
+       __u64 wrap_key;         /* wrapping key ref (CMH_REF_NONE =3D plain=
text) */
+       __u64 data;             /* user-space pointer to import blob */
+};
+
+/* Flags for cmh_ioctl_kic_hkdf1.flags / cmh_ioctl_kic_hkdf2.flags */
+#define CMH_KIC_FLAG_TEMP      0x01    /* store result in TEMP (not persis=
tent DS) */
+
+/*
+ * KIC hardware base key references.
+ *
+ * Each CMH device has up to 8 hardware base keys provisioned in OTP/fuses=
.
+ * These values are passed in the base_key field of KIC ioctl structs.
+ * The key valid bitmask is visible via R_KIC_KEY_VALID (MMIO 0x100).
+ */
+#define CMH_KIC_KEY1           0x0000000100000001ULL
+#define CMH_KIC_KEY2           0x0000000200000002ULL
+#define CMH_KIC_KEY3           0x0000000300000003ULL
+#define CMH_KIC_KEY4           0x0000000400000004ULL
+#define CMH_KIC_KEY5           0x0000000500000005ULL
+#define CMH_KIC_KEY6           0x0000000600000006ULL
+#define CMH_KIC_KEY7           0x0000000700000007ULL
+#define CMH_KIC_KEY8           0x0000000800000008ULL
+
+struct cmh_ioctl_kic_hkdf1 {
+       __u32 version;
+       __u32 key_len;          /* output key length (e.g., 32) */
+       __u64 base_key;         /* KIC base key reference */
+       __u64 cid;              /* CID for the new DS entry (ignored if TEM=
P) */
+       __u64 label;            /* user-space pointer to label data */
+       __u32 label_len;        /* label length in bytes */
+       __u32 flags;            /* CMH_KIC_FLAG_* */
+       __u64 ref;              /* [out] derived key reference */
+};
+
+struct cmh_ioctl_kic_hkdf2 {
+       __u32 version;
+       __u32 key_len;          /* output key length (e.g., 32) */
+       __u64 base_key;         /* KIC base key reference */
+       __u64 salt_key;         /* salt key reference (CMH_REF_NONE =3D no =
salt) */
+       __u64 cid;              /* CID for the new DS entry (ignored if TEM=
P) */
+       __u64 label;            /* user-space pointer to label data */
+       __u32 label_len;        /* label length in bytes */
+       __u32 flags;            /* CMH_KIC_FLAG_* */
+       __u64 ref;              /* [out] derived key reference */
+};
+
+struct cmh_ioctl_kic_aes_cmac_kdf {
+       __u32 version;
+       __u32 key_len;          /* base & output key length (must be 32) */
+       __u64 base_key;         /* KIC base key or DS reference */
+       __u64 cid;              /* CID for the new DS entry (ignored if TEM=
P) */
+       __u64 label;            /* user-space pointer to label data */
+       __u32 label_len;        /* label length in bytes */
+       __u32 flags;            /* CMH_KIC_FLAG_* */
+       __u64 ref;              /* [out] derived key reference */
+};
+
+#define KIC_DKEK_MAX_METADATA  64      /* max metadata length for DKEK */
+
+struct cmh_ioctl_kic_dkek_derive {
+       __u32 version;
+       __u32 host_id;          /* target host ID (0 =3D caller's own) */
+       __u64 base_key;         /* KIC base key reference */
+       __u64 cid;              /* CID for the new DS entry (ignored if TEM=
P) */
+       __u64 metadata;         /* user-space pointer to metadata */
+       __u32 metadata_len;     /* metadata length in bytes */
+       __u32 flags;            /* CMH_KIC_FLAG_* */
+       __u64 ref;              /* [out] derived KEK reference */
+};
+
+/* -- PKE ioctl argument structures ----------- */
+
+/*
+ * PKE multi-step protocol flows
+ *
+ * RSA encrypt/decrypt:
+ *   1. KEY_NEW(CMH_DS_RSA_PRIV_KEY) + KEY_WRITE -> priv_ref (or RSA_KEYGE=
N -> priv_ref)
+ *   2. RSA_ENC(e, n, plaintext) -> ciphertext         (public key =3D raw=
 e,n)
+ *   3. RSA_DEC(e, n, ciphertext, priv_ref) -> plaintext   (or RSA_CRT_DEC=
)
+ *
+ * ECDSA sign:
+ *   1. EC_KEYGEN(curve) -> priv_ref                    (or KEY_NEW + KEY_=
WRITE)
+ *   2. EC_PUBGEN(priv_ref) -> public_key               (raw x||y returned=
)
+ *   3. ECDSA_SIGN(digest, priv_ref) -> signature
+ *   SM2 sign uses the same path with curve=3DCMH_CURVE_SM2.
+ *
+ * ECDH shared secret:
+ *   1. EC_KEYGEN(curve) -> priv_ref                    (or KEY_NEW + KEY_=
WRITE)
+ *   2. ECDH_KEYGEN(priv_ref) -> public_key_x           (derive pub from p=
riv)
+ *   3. Exchange public keys with peer
+ *   4. ECDH(peer_key_x, priv_ref) -> shared_secret     (raw or DS ref via=
 FLAG_DS_RESULT)
+ *
+ * EdDSA sign/verify:
+ *   1. EC_KEYGEN(CURVE_25519 or CURVE_448) -> priv_ref
+ *   2. EC_PUBGEN(priv_ref) -> public_key
+ *   3. EDDSA_SIGN(message, priv_ref) -> signature      (pure EdDSA, not p=
rehash)
+ *   4. EDDSA_VERIFY(message, signature, public_key_y)
+ *   For Ed448 SCA: EDDSA_KEYGEN_SCA(priv_ref) -> sca_ref (2-share blinded=
 key)
+ *
+ * SM2 encryption (GM/T 0003.4):
+ *   1. EC_KEYGEN(CMH_CURVE_SM2) -> priv_ref            (or KEY_NEW + KEY_=
WRITE)
+ *   2. EC_PUBGEN(priv_ref) -> public_key
+ *   3. SM2_ENC_POINT(public_key) -> C1, enc_point      (nonce_len=3D0: HW=
 ephemeral)
+ *   4. SM2_ENC_HASH(enc_point, message) -> ciphertext   (C1||C3||C2)
+ *   Decrypt:
+ *   5. SM2_DEC_POINT(C1, priv_ref) -> dec_point
+ *   6. SM2_DEC_HASH(ciphertext, dec_point) -> plaintext
+ *   enc_point and dec_point are raw DMA buffers (64B each), not DS refs.
+ *
+ * SM2 key exchange (GM/T 0003.3):
+ *   1. EC_KEYGEN(CMH_CURVE_SM2) -> priv_ref            (long-lived, persi=
stent DS)
+ *   2. EC_PUBGEN(priv_ref) -> public_key
+ *   3. SM2_ID_DIGEST(id, public_key) -> ZA             (SM3-based identit=
y digest)
+ *   4. SM2_ECDH_KEYGEN(nonce) -> session_key, r        (ephemeral scalar =
r)
+ *      - nonce_len=3D32: caller supplies r (deterministic)
+ *      - nonce_len=3D0:  HW generates r, writes it back to .nonce
+ *      Exchange session_key with peer.
+ *   5. SM2_ECDH(r, priv_ref, peer_pub, peer_sess) -> shared_point
+ *      - Must pass the same r from step 4 (nonce_len=3D32)
+ *      - shared_point_ref=3D0: reads back raw shared_point, destroys DS s=
lot
+ *      - shared_point_ref=3D&ref: keeps DS slot alive, writes ref for ECD=
H_HASH
+ *   6. SM2_ECDH_HASH(shared_point_ref, ZA_self, ZA_peer) -> shared_key (1=
6B)
+ *      - shared_point_ref is a persistent DS reference from step 5
+ *      - The DS slot is consumed by the hub; caller should delete it afte=
rward
+ *   The nonce r is a raw 32-byte scalar in userspace memory between steps=
 4-5.
+ *   The shared_point is a persistent DS ref between steps 5-6.
+ *   The long-lived private key (priv_ref) persists independently.
+ */
+
+/* PKE operation flags */
+#define CMH_PKE_FLAG_DS_RESULT _BITUL(0)       /* store result in DS, retu=
rn ref */
+
+struct cmh_ioctl_pke_rsa_enc {
+       __u32 version;
+       __u32 bits;             /* RSA key size in bits (512-4096) */
+       __u64 e;                /* user-space pointer to public exponent */
+       __u32 e_len;            /* exponent length in bytes */
+       __u32 __reserved;
+       __u64 n;                /* user-space pointer to modulus */
+       __u64 input;            /* user-space pointer to input data */
+       __u64 output;           /* user-space pointer to output buffer */
+};
+
+struct cmh_ioctl_pke_rsa_dec {
+       __u32 version;
+       __u32 bits;
+       __u64 e;                /* public exponent */
+       __u32 e_len;
+       __u32 __reserved;
+       __u64 n;                /* modulus */
+       __u64 input;            /* ciphertext */
+       __u64 output;           /* plaintext output */
+       __u64 key_ref;          /* private key DS reference */
+};
+
+struct cmh_ioctl_pke_rsa_crt_dec {
+       __u32 version;
+       __u32 bits;
+       __u64 e;
+       __u32 e_len;
+       __u32 __reserved;
+       __u64 n;
+       __u64 input;
+       __u64 output;
+       __u64 crt_ref;          /* CRT key DS reference */
+};
+
+struct cmh_ioctl_pke_rsa_keygen {
+       __u32 version;
+       __u32 bits;             /* key size in bits */
+       __u64 e;                /* user-space pointer to public exponent */
+       __u32 e_len;
+       __u32 flags;            /* CMH_FLAG_* */
+       __u64 n;                /* [out] user-space pointer to modulus buff=
er */
+       __u64 d_cid;            /* CID for private key DS entry */
+       __u64 d_ref;            /* [out] private key reference */
+       __u64 crt_cid;          /* CID for CRT key DS entry (0 =3D skip CRT=
) */
+       __u64 crt_ref;          /* [out] CRT key reference */
+};
+
+struct cmh_ioctl_pke_ecdsa_sign {
+       __u32 version;
+       __u32 curve;            /* ABI curve ID (e.g. 0x03 =3D P-256) */
+       __u64 digest;           /* user-space pointer to hash digest */
+       __u32 digest_len;       /* digest length in bytes */
+       __u32 __reserved;
+       __u64 signature;        /* [out] user-space pointer to (r,s) */
+       __u64 key_ref;          /* private key DS reference */
+};
+
+struct cmh_ioctl_pke_ecdh {
+       __u32 version;
+       __u32 curve;
+       __u64 peer_key_x;       /* user-space pointer to peer public key X =
*/
+       __u64 key_ref;          /* private key DS reference */
+       __u32 flags;            /* CMH_PKE_FLAG_DS_RESULT */
+       __u32 __reserved;
+       __u64 result_cid;       /* CID for DS result (if FLAG_DS_RESULT) */
+       __u64 output;           /* [out] raw shared secret or DS ref */
+};
+
+struct cmh_ioctl_pke_ecdh_keygen {
+       __u32 version;
+       __u32 curve;
+       __u64 key_ref;          /* private key DS reference */
+       __u64 public_key_x;     /* [out] user-space pointer to public key X=
 */
+};
+
+struct cmh_ioctl_pke_eddsa_sign {
+       __u32 version;
+       __u32 curve;            /* CURVE_25519 or CURVE_448 */
+       __u64 digest;           /* user-space ptr to message (not digest) *=
/
+       __u32 digest_len;
+       __u32 __reserved;
+       __u64 signature;        /* [out] user-space pointer to signature */
+       __u64 key_ref;          /* private key DS reference */
+};
+
+struct cmh_ioctl_pke_eddsa_verify {
+       __u32 version;
+       __u32 curve;
+       __u64 digest;
+       __u32 digest_len;
+       __u32 __reserved;
+       __u64 signature;
+       __u64 public_key_y;     /* user-space pointer to public key Y */
+};
+
+struct cmh_ioctl_pke_ec_keygen {
+       __u32 version;
+       __u32 curve;
+       __u32 flags;            /* CMH_FLAG_* */
+       __u32 __reserved;
+       __u64 cid;              /* CID for the new key DS entry */
+       __u64 ref;              /* [out] private key reference */
+};
+
+struct cmh_ioctl_pke_ec_pubgen {
+       __u32 version;
+       __u32 curve;
+       __u64 key_ref;          /* private key DS reference */
+       __u64 public_key;       /* [out] user-space pointer to public key *=
/
+};
+
+struct cmh_ioctl_pke_eddsa_keygen_sca {
+       __u32 version;
+       __u32 curve;            /* must be CURVE_448 */
+       __u64 key_ref;          /* input: normal Ed448 private key DS ref *=
/
+       __u64 cid;              /* CID for the new SCA key DS entry */
+       __u64 sca_ref;          /* [out] SCA private key reference */
+};
+
+/*
+ * ioctl numbers -- type 'J', sequential.
+ * 'C' conflicts with OSS sound, CAPI/ISDN, and COSA WAN drivers;
+ * 'J' is unregistered in Documentation/userspace-api/ioctl/ioctl-number.r=
st.
+ */
+
+#define CMH_MGMT_IOC_MAGIC     'J'
+
+#define CMH_IOCTL_KEY_NEW      _IOWR(CMH_MGMT_IOC_MAGIC, 0x01, struct cmh_=
ioctl_key_new)
+#define CMH_IOCTL_KEY_WRITE    _IOW(CMH_MGMT_IOC_MAGIC,  0x02, struct cmh_=
ioctl_key_write)
+#define CMH_IOCTL_KEY_READ     _IOWR(CMH_MGMT_IOC_MAGIC, 0x03, struct cmh_=
ioctl_key_read)
+#define CMH_IOCTL_KEY_FIND     _IOWR(CMH_MGMT_IOC_MAGIC, 0x04, struct cmh_=
ioctl_key_find)
+#define CMH_IOCTL_KEY_GRANT    _IOW(CMH_MGMT_IOC_MAGIC,  0x05, struct cmh_=
ioctl_key_grant)
+#define CMH_IOCTL_KEY_DELETE   _IOW(CMH_MGMT_IOC_MAGIC,  0x06, struct cmh_=
ioctl_key_grant)
+#define CMH_IOCTL_DS_EXPORT    _IOWR(CMH_MGMT_IOC_MAGIC, 0x07, struct cmh_=
ioctl_ds_export)
+#define CMH_IOCTL_DS_IMPORT    _IOW(CMH_MGMT_IOC_MAGIC,  0x08, struct cmh_=
ioctl_ds_import)
+#define CMH_IOCTL_KIC_HKDF1    _IOWR(CMH_MGMT_IOC_MAGIC, 0x09, struct cmh_=
ioctl_kic_hkdf1)
+#define CMH_IOCTL_KIC_HKDF2    _IOWR(CMH_MGMT_IOC_MAGIC, 0x0A, struct cmh_=
ioctl_kic_hkdf2)
+#define CMH_IOCTL_KEY_NEW_RANDOM _IOWR(CMH_MGMT_IOC_MAGIC, 0x0B, struct cm=
h_ioctl_key_new)
+#define CMH_IOCTL_KIC_AES_CMAC_KDF _IOWR(CMH_MGMT_IOC_MAGIC, 0x0C, \
+                                       struct cmh_ioctl_kic_aes_cmac_kdf)
+#define CMH_IOCTL_KIC_DKEK_DERIVE _IOWR(CMH_MGMT_IOC_MAGIC, 0x0D, \
+                                       struct cmh_ioctl_kic_dkek_derive)
+#define CMH_IOCTL_KEY_LIST     _IOWR(CMH_MGMT_IOC_MAGIC, 0x0E, struct cmh_=
ioctl_key_list)
+
+/* PKE operation ioctls */
+#define CMH_IOCTL_PKE_RSA_ENC          _IOWR(CMH_MGMT_IOC_MAGIC, 0x10, \
+                                       struct cmh_ioctl_pke_rsa_enc)
+#define CMH_IOCTL_PKE_RSA_DEC          _IOWR(CMH_MGMT_IOC_MAGIC, 0x11, \
+                                       struct cmh_ioctl_pke_rsa_dec)
+#define CMH_IOCTL_PKE_RSA_CRT_DEC      _IOWR(CMH_MGMT_IOC_MAGIC, 0x12, \
+                                       struct cmh_ioctl_pke_rsa_crt_dec)
+#define CMH_IOCTL_PKE_RSA_KEYGEN       _IOWR(CMH_MGMT_IOC_MAGIC, 0x13, \
+                                       struct cmh_ioctl_pke_rsa_keygen)
+#define CMH_IOCTL_PKE_ECDSA_SIGN       _IOWR(CMH_MGMT_IOC_MAGIC, 0x14, \
+                                       struct cmh_ioctl_pke_ecdsa_sign)
+#define CMH_IOCTL_PKE_ECDH             _IOWR(CMH_MGMT_IOC_MAGIC, 0x16, \
+                                       struct cmh_ioctl_pke_ecdh)
+#define CMH_IOCTL_PKE_ECDH_KEYGEN      _IOWR(CMH_MGMT_IOC_MAGIC, 0x17, \
+                                       struct cmh_ioctl_pke_ecdh_keygen)
+#define CMH_IOCTL_PKE_EDDSA_SIGN       _IOWR(CMH_MGMT_IOC_MAGIC, 0x18, \
+                                       struct cmh_ioctl_pke_eddsa_sign)
+#define CMH_IOCTL_PKE_EDDSA_VERIFY     _IOW(CMH_MGMT_IOC_MAGIC,  0x19, \
+                                       struct cmh_ioctl_pke_eddsa_verify)
+#define CMH_IOCTL_PKE_EC_KEYGEN                _IOWR(CMH_MGMT_IOC_MAGIC, 0=
x1A, \
+                                       struct cmh_ioctl_pke_ec_keygen)
+#define CMH_IOCTL_PKE_EC_PUBGEN                _IOWR(CMH_MGMT_IOC_MAGIC, 0=
x1B, \
+                                       struct cmh_ioctl_pke_ec_pubgen)
+#define CMH_IOCTL_PKE_EDDSA_KEYGEN_SCA _IOWR(CMH_MGMT_IOC_MAGIC, 0x1C, \
+                                       struct cmh_ioctl_pke_eddsa_keygen_s=
ca)
+
+/* -- PQC ioctl argument structures ----------- */
+
+/*
+ * PQC operation flags (bits [2:0]).
+ * PQC keygen ioctls accept CMH_FLAG_PT in bits [18:16] to explicitly
+ * set the DS key storage attribute when CMH_QSE_FLAG_DS_REF is set.
+ * CMH_FLAG_SCA and CMH_FLAG_XC are rejected -- QSE SCA protection uses
+ * polynomial masking (CMH_QSE_FLAG_MASKED), not 2-share storage,
+ * and the eSW dec/sign paths hardcode SYS_TYPE_FLAG_PT.
+ * If no CMH_FLAG_* bits are set, DS keys default to CMH_FLAG_PT.
+ */
+#define CMH_QSE_FLAG_MASKED    _BITUL(0)       /* use masked (SCA-resistan=
t) HW commands */
+#define CMH_QSE_FLAG_DS_REF    _BITUL(1)       /* store key output in DS, =
return ref */
+#define CMH_QSE_FLAG_HW_RNG    _BITUL(2)       /* use HW RNG for seed/rand=
omness */
+#define CMH_QSE_FLAG_MASK      (_BITUL(0) | _BITUL(1) | _BITUL(2))
+
+/* -- SYS wrap header size -------------------- */
+/* sys_read prepends a 16-byte header even for plaintext reads */
+#define CMH_SYS_WRAP_HDR_SIZE  16
+
+/* -- Seed / randomness lengths --------------- */
+
+#define CMH_QSE_SEED_LEN               32      /* ML-KEM/ML-DSA seed size =
*/
+#define CMH_QSE_SEED_LEN_MASKED                64      /* seed size for ma=
sked mode */
+
+/* -- ML-DSA ExternalMu sentinel -------------- */
+/* Pass this as mlen to use 64-byte pre-hashed mu instead of raw message *=
/
+#define CMH_ML_DSA_MLEN_EXTERNAL_MU    0xFFFFFFFFU
+
+/* -- ML-KEM size macros ---------------------- */
+
+#define CMH_ML_KEM_EK_SIZE(k)          (384U * (k) + 32U)
+#define CMH_ML_KEM_DK_SIZE(k)          (768U * (k) + 96U)
+/* CT sizes: k=3D2 -> 768, k=3D3 -> 1088, k=3D4 -> 1568 */
+#define CMH_ML_KEM_CT_SIZE_512         768U
+#define CMH_ML_KEM_CT_SIZE_768         1088U
+#define CMH_ML_KEM_CT_SIZE_1024                1568U
+#define CMH_ML_KEM_SS_LEN              32U
+
+/* -- ML-DSA size macros ---------------------- */
+/* Indexed by mode: [0]=3D44 (mode=3D2), [1]=3D65 (mode=3D3), [2]=3D87 (mo=
de=3D5) */
+
+#define CMH_ML_DSA_44_PK_SIZE          1312U
+#define CMH_ML_DSA_44_SK_SIZE          2560U
+#define CMH_ML_DSA_44_SIG_SIZE         2420U
+#define CMH_ML_DSA_65_PK_SIZE          1952U
+#define CMH_ML_DSA_65_SK_SIZE          4032U
+#define CMH_ML_DSA_65_SIG_SIZE         3309U
+#define CMH_ML_DSA_87_PK_SIZE          2592U
+#define CMH_ML_DSA_87_SK_SIZE          4896U
+#define CMH_ML_DSA_87_SIG_SIZE         4627U
+
+/* -- SLH-DSA parameter set IDs --------------- */
+
+#define CMH_SLHDSA_SHAKE_128S          1U
+#define CMH_SLHDSA_SHAKE_128F          2U
+#define CMH_SLHDSA_SHAKE_192S          3U
+#define CMH_SLHDSA_SHAKE_192F          4U
+#define CMH_SLHDSA_SHAKE_256S          5U
+#define CMH_SLHDSA_SHAKE_256F          6U
+#define CMH_SLHDSA_SHA2_128S           7U
+#define CMH_SLHDSA_SHA2_128F           8U
+#define CMH_SLHDSA_SHA2_192S           9U
+#define CMH_SLHDSA_SHA2_192F           10U
+#define CMH_SLHDSA_SHA2_256S           11U
+#define CMH_SLHDSA_SHA2_256F           12U
+#define CMH_SLHDSA_PARAM_MAX           12U
+
+/* SLH-DSA prehash algorithm IDs */
+#define CMH_SLHDSA_PREHASH_SHA256      1U
+#define CMH_SLHDSA_PREHASH_SHA512      2U
+#define CMH_SLHDSA_PREHASH_SHAKE128    3U
+#define CMH_SLHDSA_PREHASH_SHAKE256    4U
+#define CMH_SLHDSA_PREHASH_MAX         4U
+
+/* SLH-DSA n-value table indexed by (param_set - 1) */
+#define CMH_SLHDSA_N_128               16U
+#define CMH_SLHDSA_N_192               24U
+#define CMH_SLHDSA_N_256               32U
+
+/* SLH-DSA key sizes: pk =3D 2*n, sk =3D 4*n, seed =3D 3*n */
+#define CMH_SLHDSA_PK_SIZE(n)          (2U * (n))
+#define CMH_SLHDSA_SK_SIZE(n)          (4U * (n))
+#define CMH_SLHDSA_SEED_SIZE(n)                (3U * (n))
+
+/* SLH-DSA signature sizes indexed by (param_set - 1) */
+#define CMH_SLHDSA_SIG_SIZE_SHAKE_128S 7856U
+#define CMH_SLHDSA_SIG_SIZE_SHAKE_128F 17088U
+#define CMH_SLHDSA_SIG_SIZE_SHAKE_192S 16224U
+#define CMH_SLHDSA_SIG_SIZE_SHAKE_192F 35664U
+#define CMH_SLHDSA_SIG_SIZE_SHAKE_256S 29792U
+#define CMH_SLHDSA_SIG_SIZE_SHAKE_256F 49856U
+#define CMH_SLHDSA_SIG_SIZE_SHA2_128S  7856U
+#define CMH_SLHDSA_SIG_SIZE_SHA2_128F  17088U
+#define CMH_SLHDSA_SIG_SIZE_SHA2_192S  16224U
+#define CMH_SLHDSA_SIG_SIZE_SHA2_192F  35664U
+#define CMH_SLHDSA_SIG_SIZE_SHA2_256S  29792U
+#define CMH_SLHDSA_SIG_SIZE_SHA2_256F  49856U
+
+/* -- PKE curve IDs -------------- */
+
+#define CMH_CURVE_P192                 0x01U
+#define CMH_CURVE_P224                 0x02U
+#define CMH_CURVE_P256                 0x03U
+#define CMH_CURVE_P384                 0x04U
+#define CMH_CURVE_P521                 0x05U
+#define CMH_CURVE_SECP256K1            0x07U
+#define CMH_CURVE_BP192R1              0x11U
+#define CMH_CURVE_BP224R1              0x12U
+#define CMH_CURVE_BP256R1              0x13U
+#define CMH_CURVE_BP320R1              0x14U
+#define CMH_CURVE_BP384R1              0x15U
+#define CMH_CURVE_BP512R1              0x16U
+#define CMH_CURVE_SM2                  0x18U
+#define CMH_CURVE_25519                        0x21U
+#define CMH_CURVE_448                  0x22U
+
+/* ML-KEM */
+
+struct cmh_ioctl_ml_kem_keygen {
+       __u32 version;
+       __u32 k;                /* security parameter: 2/3/4 */
+       __u32 flags;            /* CMH_QSE_FLAG_* */
+       __u32 __reserved;
+       __u64 seed;             /* user-space pointer to seed (or 0 for HW =
RNG) */
+       __u64 z;                /* user-space pointer to z (or 0 for HW RNG=
) */
+       __u64 ek;               /* [out] user-space pointer to encapsulatio=
n key */
+       __u64 dk;               /* [out] user-space pointer to decapsulatio=
n key
+                                * or [out] DS ref if CMH_QSE_FLAG_DS_REF
+                                */
+       __u64 dk_cid;           /* CID for DS entry (if DS_REF) */
+       __u64 dk_ref;           /* [out] dk DS reference (if DS_REF) */
+};
+
+struct cmh_ioctl_ml_kem_enc {
+       __u32 version;
+       __u32 k;
+       __u32 flags;            /* CMH_QSE_FLAG_* */
+       __u32 __reserved;
+       __u64 coin;             /* user-space pointer to random coin (or 0)=
 */
+       __u64 ek;               /* user-space pointer to encapsulation key =
*/
+       __u64 ct;               /* [out] user-space pointer to ciphertext *=
/
+       __u64 ss;               /* [out] user-space pointer to shared secre=
t */
+       __u64 __reserved2[2];   /* reserved for future use */
+};
+
+struct cmh_ioctl_ml_kem_dec {
+       __u32 version;
+       __u32 k;
+       __u32 flags;            /* CMH_QSE_FLAG_* */
+       __u32 __reserved;
+       __u64 ct;               /* user-space pointer to ciphertext */
+       __u64 dk;               /* user-space pointer to dk or DS ref */
+       __u64 ss;               /* [out] user-space pointer to shared secre=
t */
+       __u64 __reserved2[2];   /* reserved for future use */
+};
+
+/* ML-DSA */
+
+struct cmh_ioctl_ml_dsa_keygen {
+       __u32 version;
+       __u32 mode;             /* security parameter: 2/3/5 */
+       __u32 flags;            /* CMH_QSE_FLAG_* */
+       __u32 __reserved;
+       __u64 seed;             /* user-space pointer to seed (or 0 for HW =
RNG) */
+       __u64 pk;               /* [out] user-space pointer to public key *=
/
+       __u64 sk;               /* [out] user-space pointer to secret key
+                                * or [out] DS ref if CMH_QSE_FLAG_DS_REF
+                                */
+       __u64 sk_cid;           /* CID for DS entry (if DS_REF) */
+       __u64 sk_ref;           /* [out] sk DS reference (if DS_REF) */
+};
+
+struct cmh_ioctl_ml_dsa_sign {
+       __u32 version;
+       __u32 mode;
+       __u32 flags;            /* CMH_QSE_FLAG_* */
+       __u32 mlen;             /* message length in bytes */
+       __u64 m;                /* user-space pointer to message */
+       __u64 sk;               /* user-space pointer to sk or DS ref */
+       __u64 sig;              /* [out] user-space pointer to signature */
+       __u64 rnd;              /* user-space pointer to randomness (or 0) =
*/
+};
+
+/* SLH-DSA */
+
+struct cmh_ioctl_slhdsa_keygen {
+       __u32 version;
+       __u32 parameter_set;    /* HCQ_SLHDSA_SHAKE_128S .. SHA2_256F */
+       __u32 flags;            /* CMH_QSE_FLAG_DS_REF */
+       __u32 __reserved;
+       __u64 seed;             /* user-space pointer to seed */
+       __u64 pk;               /* [out] user-space pointer to public key *=
/
+       __u64 sk;               /* [out] user-space pointer to secret key
+                                * or [out] DS ref if CMH_QSE_FLAG_DS_REF
+                                */
+       __u64 sk_cid;           /* CID for DS entry (if DS_REF) */
+       __u64 sk_ref;           /* [out] sk DS reference (if DS_REF) */
+};
+
+struct cmh_ioctl_slhdsa_sign {
+       __u32 version;
+       __u32 parameter_set;
+       __u32 msg_len;
+       __u32 ctx_len;
+       __u64 msg;              /* user-space pointer to message */
+       __u64 ctx;              /* user-space pointer to context (or 0) */
+       __u64 sk;               /* DS ref for secret key */
+       __u64 sig;              /* [out] user-space pointer to signature */
+       __u64 add_random;       /* user-space pointer to addl. randomness (=
or 0) */
+};
+
+struct cmh_ioctl_slhdsa_sign_prehash {
+       __u32 version;
+       __u32 parameter_set;
+       __u32 prehash_algo;     /* CMH_SLHDSA_PREHASH_* */
+       __u32 digest;           /* 0 =3D raw msg (eSW hashes), 1 =3D pre-co=
mputed digest */
+       __u32 msg_len;
+       __u32 ctx_len;
+       __u64 msg;              /* user-space pointer to message/digest */
+       __u64 ctx;              /* user-space pointer to context (or 0) */
+       __u64 sk;               /* DS ref for secret key */
+       __u64 sig;              /* [out] user-space pointer to signature */
+       __u64 add_random;       /* user-space pointer to addl. randomness (=
or 0) */
+};
+
+/* -- SM2 ioctl argument structures ----------- */
+
+/* SM2 fixed key sizes (sm2p256v1 curve, 256-bit) */
+#define CMH_SM2_CLEN                   32U     /* coordinate length */
+#define CMH_SM2_PUBKEY_LEN             64U     /* uncompressed (x||y) */
+#define CMH_SM2_POINT_LEN              64U     /* EC point (x||y) */
+#define CMH_SM2_SHARED_KEY_LEN         16U     /* ECDH shared key */
+#define CMH_SM2_DIGEST_LEN             32U     /* SM3 digest (ZA) */
+/*
+ * SM2 enc_hash/dec_hash payload limit.
+ *
+ * The eSW PKE driver implements only a single-block GM/T 0003.4 KDF
+ * (one SM3 invocation, 32 bytes of key stream).  Longer messages would
+ * silently produce incorrect ciphertext / plaintext, so the driver caps
+ * the payload at 32 bytes.  See Documentation/ABI/testing/cmh-mgmt.
+ */
+#define CMH_SM2_MAX_MSG_LEN            32U     /* encrypt/decrypt */
+#define CMH_SM2_MAX_ID_LEN             32U     /* identity string */
+#define CMH_SM2_CT_OVERHEAD            96U     /* C1(64) + C3(32) */
+#define CMH_SM2_MAX_CT_LEN             128U    /* 96 + max_msg =3D 128 */
+
+struct cmh_ioctl_sm2_ecdh_keygen {
+       __u32 version;
+       __u32 nonce_len;        /* 0 =3D HW generates r (written back), 32 =
=3D caller provides r */
+       __u64 nonce;            /* [in/out] user-space pointer to nonce buf=
fer (32B) */
+       __u64 session_key;      /* [out] user-space pointer to session key =
R=3Dr*G (64B) */
+};
+
+struct cmh_ioctl_sm2_ecdh {
+       __u32 version;
+       __u32 nonce_len;        /* 0 =3D HW generates (written back), 32 =
=3D caller provides */
+       __u64 nonce;            /* [in/out] user-space pointer to nonce r (=
32B) */
+       __u64 peer_public_key;  /* user-space pointer to peer pub key (64B)=
 */
+       __u64 peer_session_key; /* user-space pointer to peer session key (=
64B) */
+       __u64 key_ref;          /* private key DS reference */
+       __u64 shared_point;     /* [out] user-space pointer to shared point=
 (64B) */
+       __u64 shared_point_ref; /* [in/out] 0 =3D read-back mode; &ref =3D =
keep DS, write ref */
+};
+
+struct cmh_ioctl_sm2_dec_point {
+       __u32 version;
+       __u32 ciphertext_len;   /* total ciphertext length (97..128) */
+       __u64 ciphertext;       /* user-space pointer to ciphertext (64B: C=
1) */
+       __u64 dec_point;        /* [out] user-space pointer to dec point (6=
4B) */
+       __u64 key_ref;          /* private key DS reference */
+};
+
+struct cmh_ioctl_sm2_enc_point {
+       __u32 version;
+       __u32 nonce_len;        /* 0 =3D HW generates, 32 =3D caller provid=
es */
+       __u64 nonce;            /* user-space pointer to nonce (or 0) */
+       __u64 public_key;       /* user-space pointer to public key (64B) *=
/
+       __u64 ciphertext;       /* [out] user-space pointer to C1 (64B) */
+       __u64 enc_point;        /* [out] user-space pointer to enc point (6=
4B) */
+};
+
+struct cmh_ioctl_sm2_id_digest {
+       __u32 version;
+       __u32 id_len;           /* identity length in bytes (<=3D32) */
+       __u64 id;               /* user-space pointer to identity string */
+       __u64 public_key;       /* user-space pointer to public key (64B) *=
/
+       __u64 digest;           /* [out] user-space pointer to ZA digest (3=
2B) */
+};
+
+/*
+ * SM2 ECDH_HASH -- derive shared key from shared point + ZA digests.
+ *
+ * IMPORTANT: The digest fields use ABSOLUTE ordering per GM/T 0003.3,
+ * NOT relative own/peer ordering.  Both parties must pass:
+ *   peer_id_digest =3D Z_A (initiator's digest) -- hashed FIRST
+ *   id_digest      =3D Z_B (responder's digest) -- hashed SECOND
+ * The eSW computes: KDF(shared_point || peer_id_digest || id_digest).
+ */
+struct cmh_ioctl_sm2_ecdh_hash {
+       __u32 version;
+       __u32 __reserved;
+       __u64 peer_id_digest;   /* ptr to Z_A -- initiator's digest (32B) *=
/
+       __u64 id_digest;        /* ptr to Z_B -- responder's digest (32B) *=
/
+       __u64 shared_point_ref; /* DS reference from SM2_ECDH */
+       __u64 shared_key;       /* [out] ptr to shared key (16B) */
+};
+
+struct cmh_ioctl_sm2_dec_hash {
+       __u32 version;
+       __u32 ciphertext_len;   /* ciphertext length (97..128) */
+       __u64 ciphertext;       /* user-space pointer to full ciphertext */
+       __u64 dec_point;        /* user-space pointer to dec point (64B) */
+       __u64 plaintext;        /* [out] user-space pointer to plaintext */
+};
+
+struct cmh_ioctl_sm2_enc_hash {
+       __u32 version;
+       __u32 message_len;      /* message length (1..32) */
+       __u64 message;          /* user-space pointer to plaintext */
+       __u64 enc_point;        /* user-space pointer to enc point (64B) */
+       __u64 ciphertext;       /* [out] user-space pointer to ciphertext *=
/
+};
+
+/* PQC ioctl numbers */
+#define CMH_IOCTL_ML_KEM_KEYGEN                _IOWR(CMH_MGMT_IOC_MAGIC, 0=
x20, \
+                                       struct cmh_ioctl_ml_kem_keygen)
+#define CMH_IOCTL_ML_KEM_ENC           _IOWR(CMH_MGMT_IOC_MAGIC, 0x21, \
+                                       struct cmh_ioctl_ml_kem_enc)
+#define CMH_IOCTL_ML_KEM_DEC           _IOWR(CMH_MGMT_IOC_MAGIC, 0x22, \
+                                       struct cmh_ioctl_ml_kem_dec)
+#define CMH_IOCTL_ML_DSA_KEYGEN                _IOWR(CMH_MGMT_IOC_MAGIC, 0=
x23, \
+                                       struct cmh_ioctl_ml_dsa_keygen)
+#define CMH_IOCTL_ML_DSA_SIGN          _IOWR(CMH_MGMT_IOC_MAGIC, 0x24, \
+                                       struct cmh_ioctl_ml_dsa_sign)
+#define CMH_IOCTL_SLHDSA_KEYGEN                _IOWR(CMH_MGMT_IOC_MAGIC, 0=
x28, \
+                                       struct cmh_ioctl_slhdsa_keygen)
+#define CMH_IOCTL_SLHDSA_SIGN          _IOWR(CMH_MGMT_IOC_MAGIC, 0x29, \
+                                       struct cmh_ioctl_slhdsa_sign)
+#define CMH_IOCTL_SLHDSA_SIGN_PREHASH  _IOWR(CMH_MGMT_IOC_MAGIC, 0x2D, \
+                                       struct cmh_ioctl_slhdsa_sign_prehas=
h)
+
+/* SM2 operation ioctls */
+#define CMH_IOCTL_SM2_ECDH_KEYGEN      _IOWR(CMH_MGMT_IOC_MAGIC, 0x30, \
+                                       struct cmh_ioctl_sm2_ecdh_keygen)
+#define CMH_IOCTL_SM2_ECDH             _IOWR(CMH_MGMT_IOC_MAGIC, 0x31, \
+                                       struct cmh_ioctl_sm2_ecdh)
+#define CMH_IOCTL_SM2_DEC_POINT                _IOWR(CMH_MGMT_IOC_MAGIC, 0=
x32, \
+                                       struct cmh_ioctl_sm2_dec_point)
+#define CMH_IOCTL_SM2_ENC_POINT                _IOWR(CMH_MGMT_IOC_MAGIC, 0=
x33, \
+                                       struct cmh_ioctl_sm2_enc_point)
+#define CMH_IOCTL_SM2_ID_DIGEST                _IOWR(CMH_MGMT_IOC_MAGIC, 0=
x34, \
+                                       struct cmh_ioctl_sm2_id_digest)
+#define CMH_IOCTL_SM2_ECDH_HASH                _IOWR(CMH_MGMT_IOC_MAGIC, 0=
x35, \
+                                       struct cmh_ioctl_sm2_ecdh_hash)
+#define CMH_IOCTL_SM2_DEC_HASH         _IOWR(CMH_MGMT_IOC_MAGIC, 0x36, \
+                                       struct cmh_ioctl_sm2_dec_hash)
+#define CMH_IOCTL_SM2_ENC_HASH         _IOWR(CMH_MGMT_IOC_MAGIC, 0x37, \
+                                       struct cmh_ioctl_sm2_enc_hash)
+
+/*
+ * EAC (Error and Alarm Controller) -- read and clear error registers.
+ *
+ * Returns a snapshot of all hardware error/safety/notification registers.
+ * The eSW atomically reads and clears the registers on each call, so
+ * successive reads show only new events.
+ */
+struct cmh_ioctl_eac_read {
+       __u32 version;                  /* must be CMH_MGMT_V1 */
+       __u32 __reserved;
+       __u64 mailbox_notification;     /* [out] MBX safety notification bi=
tmask */
+       __u32 hw_error;                 /* [out] HWC error bitmask */
+       __u32 hw_nmi;                   /* [out] HWC NMI bitmask */
+       __u32 hw_panic;                 /* [out] HWC panic bitmask */
+       __u32 safety_fatal;             /* [out] HWC fatal safety bitmask *=
/
+       __u32 safety_notification;      /* [out] HWC safety notification bi=
tmask */
+       __u32 sw_info0;                 /* [out] eSW tracing info */
+       __u32 sw_info1;                 /* [out] eSW tracing info */
+       __u32 sram_bank_errors[4];      /* [out] correctable ECC error coun=
ts */
+       __u32 __pad;                    /* explicit tail padding (prevent i=
nfo leak) */
+};
+
+/*
+ * DRBG CONFIG -- configure the hardware DRBG before first use.
+ *
+ * This is a management operation normally performed once at system
+ * start-up.  Must be called before any hwrng reads or DRBG GENERATE
+ * operations.
+ */
+#define CMH_DRBG_RATIO_ONE             0       /* 1:1 entropy ratio */
+#define CMH_DRBG_RATIO_ONE_HALF                1       /* 1:2 */
+#define CMH_DRBG_RATIO_ONE_THIRD       2       /* 1:3 */
+#define CMH_DRBG_RATIO_ONE_FOURTH      3       /* 1:4 */
+
+#define CMH_DRBG_STRENGTH_128          0x00    /* 128-bit security */
+#define CMH_DRBG_STRENGTH_256          0x10    /* 256-bit security */
+
+struct cmh_ioctl_drbg_config {
+       __u32 version;                  /* must be CMH_MGMT_V1 */
+       __u32 entropy_ratio;            /* CMH_DRBG_RATIO_* */
+       __u32 security_strength;        /* CMH_DRBG_STRENGTH_* */
+       __u32 __reserved;
+};
+
+/* EAC ioctl number */
+#define CMH_IOCTL_EAC_READ             _IOWR(CMH_MGMT_IOC_MAGIC, 0x0F, \
+                                       struct cmh_ioctl_eac_read)
+
+/* DRBG management ioctl number */
+#define CMH_IOCTL_DRBG_CONFIG          _IOW(CMH_MGMT_IOC_MAGIC, 0x40, \
+                                       struct cmh_ioctl_drbg_config)
+
+#endif /* _UAPI_CMH_MGMT_IOCTL_H */
--
2.43.7


** This message and any attachments are for the sole use of the intended re=
cipient(s). It may contain information that is confidential and privileged.=
 If you are not the intended recipient of this message, you are prohibited =
from printing, copying, forwarding or saving it. Please delete the message =
and attachments and notify the sender immediately. **

Rambus Inc.<http://www.rambus.com>


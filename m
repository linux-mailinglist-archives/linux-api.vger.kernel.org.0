Return-Path: <linux-api+bounces-6808-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id x7rNJ+MFUGowsAIAu9opvQ
	(envelope-from <linux-api+bounces-6808-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Thu, 09 Jul 2026 22:34:43 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DA6A7356C0
	for <lists+linux-api@lfdr.de>; Thu, 09 Jul 2026 22:34:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=rambus.com header.s=selector1 header.b=XPWlzXnz;
	dmarc=pass (policy=reject) header.from=rambus.com;
	spf=pass (mail.lfdr.de: domain of "linux-api+bounces-6808-lists+linux-api=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-api+bounces-6808-lists+linux-api=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C0A3B30A3D17
	for <lists+linux-api@lfdr.de>; Thu,  9 Jul 2026 20:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 906C23CE4BA;
	Thu,  9 Jul 2026 20:31:31 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11020116.outbound.protection.outlook.com [40.93.198.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F31AD3BBFD3;
	Thu,  9 Jul 2026 20:31:28 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783629091; cv=fail; b=C8fe+wrI8aqo6QZ9iwb/bGteZDH93LnvA+g3UskYERaTB1c7J6nM0RDHoLHPahoehxW/EqmmA66GWn9buhyN0uAon+TQnaLIySZQkbnCBltLgRvdfsjGczR4fsj8NhJoBw4IsgwW0UPdcMSQSsks/6LS9/UvaDILHDNuV2xa6OM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783629091; c=relaxed/simple;
	bh=FjzfFkvyrfwv2VtrnCntXURbO8wueEzRkHTIpdqgGzk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BE/ZMn+ipe2tB/BCHlI8RWiLcoJqbJ//SMNiUBHyOTC9UORGECdsAkXlvqSctMS0BTuSfk+bd02BECKdbGc5/8+pn++gjSs+2BHK1k1BgdETqAzl+fAZmmMAfhBkQj6hzPW7rr0m+/LI1hUG++aQ2JyfIb1ryxnmMuEtFyHy47k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rambus.com; spf=fail smtp.mailfrom=rambus.com; dkim=pass (2048-bit key) header.d=rambus.com header.i=@rambus.com header.b=XPWlzXnz; arc=fail smtp.client-ip=40.93.198.116
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F0/EINbW2PFRHdJ2gK9bPlKcJ5noVrP2qbWJ0zewQiySU4Hp2aV+kR5B3M9tL33x9xqzoF+t3ZBHdE1rTtIGhcQd5nr0nfCHfPyFwVRXtq7TQLsBWFirtvkEx/tTpEO9X81lI7Aija1+zKZu0PC/ogCfGlkPxcnUUsphE1TIwH/9CVKL6YvC0nVm7YHIJfpwUqWQeDHph5M1+BpwLMak9MRrtBowVegYw6/2oYUST8EkwG3F/e1e//uA3sO1hWi/HJbEFh2H5l0D8yrk2m2Uakqe2ZoWrXvT0+6ygmWbyMTn9eF2JO1Hy/D59vk+0YCI/c3ViZsSi0gMqhTJ+QdgtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qJokKJ6NXURz//PX9o7RexvE9Rsmjs2lVLBugAi8SAQ=;
 b=PAjBe4dEMMr/lMFV1Tuhw7gyqXRmLNHydTcXjxicA+vadsZ6GXz+DVdYpH4aIPVKqwvlVlZqj2aoStIxEh/gm3JlP10CQb/93rcmS/r4zjAlJz3gqmXFYyQh7BKfUxA6f3EY5YbLAlxR9h8bejIEk9SBjTNVLk3pCl5wZXZPLj2EK8bHWacNFvTxhaQG7sz6DQJdz/mTbuST3cYlhIf+F/U0sEROR05ZWWiQttlOi+flnDUQfPhbQDEnWbhnneix6ludhq1PVKUcsXTRF6BDXcXb0gK6L7y3lks/F75n3W9apSTILSK91ugZ9kxrKaHyiZUNXMcDDWGk1WDpJHUXPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.86.86.210) smtp.rcpttodomain=cryptography.com smtp.mailfrom=rambus.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=rambus.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rambus.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qJokKJ6NXURz//PX9o7RexvE9Rsmjs2lVLBugAi8SAQ=;
 b=XPWlzXnz7QVKM60LAWG9ISOElOl1MjeAoFcQSvx5Gt3G+y4La3EiSM/IiW/DorDFlwwkHGU53mLtV6QIbMIBNoDAt5slBmXMhQDI6qOpNU5daZqQHnmP48mAz7K3ZDiBUGfY7PRZ7EOLf5H9TJxcH2xBXWJcF6EnqQEWWpmH/eZQmq9BKhiFo88/OsGXQNP47vLXILlWY0lkqQ9nkuNCQHvvv26tdVJ8KC0w13y57K7FaYrPhkGc0j0OAceJGIwTqMSNrh9kZokbhs+iH/UiGd1G0tj2k0BZu0rckmetbwTde67eTa9muAAODHkyjxYMbOsBgoCPrlwQQNd6SvX0Aw==
Received: from SJ0PR03CA0247.namprd03.prod.outlook.com (2603:10b6:a03:3a0::12)
 by CH3PR04MB9055.namprd04.prod.outlook.com (2603:10b6:610:169::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Thu, 9 Jul
 2026 20:31:13 +0000
Received: from SJ1PEPF00002318.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0:cafe::6f) by SJ0PR03CA0247.outlook.office365.com
 (2603:10b6:a03:3a0::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.10 via Frontend Transport; Thu, 9
 Jul 2026 20:31:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.86.86.210)
 smtp.mailfrom=rambus.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=rambus.com;
Received-SPF: Pass (protection.outlook.com: domain of rambus.com designates
 192.86.86.210 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.86.86.210; helo=hqxsv-psmtppxy02.rambus.com; pr=C
Received: from hqxsv-psmtppxy02.rambus.com (192.86.86.210) by
 SJ1PEPF00002318.mail.protection.outlook.com (10.167.242.228) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.6
 via Frontend Transport; Thu, 9 Jul 2026 20:31:11 +0000
Received: from hqxsv-cmdev3-skrishnamoorthy.rambus.com (hqn-lb-int-float.rambus.com [10.12.20.20])
	by hqxsv-psmtppxy02.rambus.com (Postfix) with ESMTPS id D97201801749;
	Thu,  9 Jul 2026 20:31:10 +0000 (UTC)
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
	Thi Nguyen <thin@rambus.com>
Subject: [PATCH v2 00/19] crypto: cmh - add CRI CryptoManager Hub driver
Date: Thu,  9 Jul 2026 13:30:18 -0700
Message-ID: <20260709203037.1884436-1-skrishnamoorthy@rambus.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002318:EE_|CH3PR04MB9055:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 93189629-da2d-4801-e994-08deddf903a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|82310400026|7416014|36860700016|13003099007|921020|6133799003|11063799006|56012099006|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	g/1uw9hjdSbkpAvZyzAaQ1m/fvAeug2M2WBMja8IrFtHncCRNiGAdYNJupF/I7Cj9jvOK6ejRt+q8iIWj5tnusDhw2WGGShEIMtziCG8sv9mCI2kypt8UkWtMn/Mj4VtzUbZq09EfApPfBpXnaWwjDgdhhWbAvjhrfyyq91dExsKXX6ppHpHOYEm1AGM9AMz+gqrGejoNPXV+RXxxYvy8n05gBi9VYfi92xFzvKImafac6ppoMgIefOdFEKsPdC+dkOuJzIQ+TtAT0oA7kyjQyY88TFJP1b66ljq0Rg08LvF36fa2kNjv4K4UgQWlxs+wYcX8DVzZsRZhZcCjpQvKMAE+EMutuSn2Hm0oujT1SrEb8um6i1OXyqbgquEujehEoN2rsEDMhHFt/wIUUUons7xFem0mePs5w0n4QxCeAZXl67sWu6o7thpUE8GBnConfK30nM4mmeLeDJOOWTLMR26+1ACp+OCTfnm2sRNLyVE8MBA0vdS9n4fyGAAPqgMbf+hhbU7TxUzOKF73VwxGzMwHI6/Wm4ShcuE1QlNMOgx6y5fOS1MKlREgQaD3BSqSJn7O8RBrTORNSbSivcsxgvMUwUtCqRrVehPVCBXdsoQaDXYEP4iPaY2TYIKPCR2DhneFun5pnEPbOu00UPgGfHn4TRO6iY8Z8xkVLkbKBtoYg3+37aOiZff681TtN026oho9GUWMYqqu97isAgWQa9M7din9Ux39xxG3dRn0Ky9cmW8XI6K/e94mTLwE0s/
X-Forefront-Antispam-Report:
	CIP:192.86.86.210;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hqxsv-psmtppxy02.rambus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(82310400026)(7416014)(36860700016)(13003099007)(921020)(6133799003)(11063799006)(56012099006)(18002099003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	7tIaAkCBTXbQR6QJ0S2F3MptOOWZlBpi9KVVr8pmsZuUTcllNc+R52VZiq4RPZ3dY9o1ABcW2XSlkePZIufIo/HY0GrtQfutS3MD8DZwLiEf4Lqx2z4DWHqS6stwM6x5yA4viVnv1z2qxOvOylc6UzyI76ufq4lz2+s68sue/SeiqXmH3wRShgLGCTNcGLibVC69C7wVnJKkFl9ihpkmZfh7V3afmk2+88drdXK8EdpFgQt2akq6LogfBHcFn9YEHwfoNkHHQeRuaKcet1xxTFIEfGKqIlppewNL9Yz4TstypC366hr6fX3jPKIqZpq34azEyrGQe7BsWFyZZXxZOaoA9bW5/wAEIwfHXONYADj5jz0kc4dHcUjqHhf1Wtf2Ihc+JGJeTO5x+1riDGh4P5ezs2jwSLRdgg5Cr5wKfQY3MfjxZ6ZBGoQOh88B+JGs
X-OriginatorOrg: rambus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 20:31:11.0734
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 93189629-da2d-4801-e994-08deddf903a9
X-MS-Exchange-CrossTenant-Id: bd0ba799-c2b9-413c-9c56-5d1731c4827c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bd0ba799-c2b9-413c-9c56-5d1731c4827c;Ip=[192.86.86.210];Helo=[hqxsv-psmtppxy02.rambus.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002318.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR04MB9055
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[rambus.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[rambus.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[skrishnamoorthy@rambus.com,linux-api@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[23];
	TAGGED_FROM(0.00)[bounces-6808-lists,linux-api=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:aou@eecs.berkeley.edu,m:aousherovitch@rambus.com,m:conor+dt@kernel.org,m:davem@davemloft.net,m:herbert@gondor.apana.org.au,m:corbet@lwn.net,m:krzk+dt@kernel.org,m:palmer@dabbelt.com,m:pjw@kernel.org,m:robh@kernel.org,m:skrishnamoorthy@rambus.com,m:shuah@kernel.org,m:alex@ghiti.fr,m:devicetree@vger.kernel.org,m:Joel.Wittenauer@cryptography.com,m:linux-api@vger.kernel.org,m:linux-crypto@vger.kernel.org,m:linux-doc@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:linux-riscv@lists.infradead.org,m:skhan@linuxfoundation.org,m:thin@rambus.com,m:conor@kernel.org,m:krzk@kernel.org,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[rambus.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skrishnamoorthy@rambus.com,linux-api@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[checkpatch.pl:url,rambus.com:dkim,rambus.com:mid,rambus.com:from_mime,rambus.com:url,rambus.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-api,dt];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3DA6A7356C0

From: Alex Ousherovitch <aousherovitch@rambus.com>

crypto: cmh - add CRI CryptoManager Hub hardware crypto accelerator

This series adds a driver for the CRI CryptoManager Hub (CMH), a
hardware cryptographic accelerator IP from Cryptography Research at
Rambus Inc. (https://www.rambus.com/cryptographyresearch/).
CMH provides a broad set of symmetric, asymmetric, and post-quantum
cryptographic algorithms accelerated in hardware, accessed via a
mailbox-based Virtual Command Queue (VCQ) interface.

The hardware is a platform device matched via device tree
(compatible = "cri,cmh").  It exposes a single MMIO register region
(SIC) with per-mailbox doorbell, status, and command registers.
Each mailbox has DMA-coherent queue memory for VCQ command
submission and completion.

Driver architecture:

  In-kernel users                       /dev/cmh_mgmt (ioctl)
  (dm-crypt, IPsec, kTLS, fscrypt)      (key management)
       |                                        |
       v                                        v
  +----------------------------------------------------+
  |        Kernel Crypto API + hwrng (72 total)        |
  |   ahash | skcipher | aead | akcipher | sig | kpp   |
  +----------------------------------------------------+
       |                                           |
       v                                           v
  +------------------+    +------------------------+
  | Transaction Mgr  |--->| Key / Mgmt subsystem   |
  | (kthread, CMQ)   |    | (datastore, ioctl ops) |
  +------------------+    +------------------------+
       |
       v
  +------------------+     +-------------------+
  | MQI (VCQ pack,   |---->| Response Handler  |
  |  DMA map, submit)|     | (threaded IRQ,    |
  +------------------+     |  watchdog, unmap) |
       |                   +-------------------+
       v                          ^
  +-----------+              +-----------+
  | Hardware  |--- IRQ ----->| Hardware  |
  | (mailbox) |              | (mailbox) |
  +-----------+              +-----------+

The transaction manager runs as a dedicated kthread that pulls
requests from a central command queue, packs VCQ entries, maps DMA
buffers, and submits to the least-loaded mailbox.  Completion is
handled by per-mailbox threaded IRQs.  The driver returns
-EINPROGRESS for async crypto requests and supports the
CRYPTO_TFM_REQ_MAY_BACKLOG flag for queue-full backpressure.

Registered algorithms (72 total):

  Type       Count  Algorithms
  ---------  -----  --------------------------------------------------
  ahash         15  SHA-{224,256,384,512}, SHA3-{224,256,384,512},
                     SHAKE-{128,256}, cSHAKE-{128,256},
                     KMAC-{128,256}, SM3
  ahash(HMAC)    8  HMAC-SHA-{224,256,384,512},
                     HMAC-SHA3-{224,256,384,512}
  ahash(MAC)     4  CMAC(AES), CMAC(SM4), XCBC(SM4), Poly1305
  skcipher      11  AES-{ECB,CBC,CTR,CFB,XTS},
                     SM4-{ECB,CBC,CTR,CFB,XTS}, ChaCha20
  aead           6  AES-{GCM,CCM}, SM4-{GCM,CCM},
                     rfc7539(chacha20,poly1305),
                     rfc7539esp(chacha20,poly1305)
  akcipher       1  RSA (2048--4096 bit; 512/1024 legacy/test)
  sig           23  ECDSA P-{256,384,521}, SM2 (verify-only),
                     ML-DSA-{44,65,87},
                     SLH-DSA (12 parameter sets),
                     LMS, LMS-HSS, XMSS, XMSS-MT
  kpp            3  ECDH P-{256,384}, X25519
  hwrng          1  DRBG-backed /dev/hwrng

Ioctl-only algorithms (not registered with the crypto API at all):
  - EdDSA (Ed25519, Ed448): sign and verify
  - ML-KEM (ML-KEM-512/768/1024): no standard kernel KEM API exists

The driver also exposes /dev/cmh_mgmt, a misc device providing 44
ioctl commands.  Relative to the in-kernel crypto API these fall into
two groups; the distinction matters because some commands name the
same primitives the driver also registers, and that overlap is
deliberate and bounded:

(1) Operations with no crypto API representation - the large
    majority.  The crypto API has no transform type or verb for
    these, so a character device is the only available UAPI:
      - hardware key lifecycle: create, import, export, derive,
        destroy, enumerate (keystore CRUD) - no keystore verb
      - KIC key derivation (HKDF, AES-CMAC-KDF, DKEK)
      - asymmetric key generation (RSA, EC, EdDSA, ML-DSA, SLH-DSA)
        and public-key derivation - the crypto API has no keygen verb
      - ML-KEM encapsulate/decapsulate - no kernel KEM API exists
      - SM2 encrypt/decrypt and key exchange (multi-step GM/T 0003)
      - EdDSA sign/verify - not registered with the crypto API
      - EAC Chip Authentication and DRBG (re)configuration

(2) Hardware-held-key operations on algorithms that ARE also
    registered (RSA decrypt, ECDSA/ML-DSA/SLH-DSA sign, ECDH).  These
    name the same primitives as the registered akcipher/sig/kpp
    transforms, but the crypto API's set_priv_key()/set_secret()
    accept only raw key bytes supplied by the caller; they cannot
    reference a private key that is generated inside, and never
    leaves, the hardware datastore - the central security property of
    this device.  The ioctl path keeps the private key
    hardware-resident, while the registered transforms serve raw-key
    in-kernel users.  The two paths are complementary, not redundant.

The device requires CAP_SYS_ADMIN.

/dev/cmh_mgmt is built conditionally on CONFIG_CRYPTO_DEV_CMH_MGMT
(default n); when disabled the ioctl interface is absent while all
kernel crypto API algorithms remain registered.

The ML-DSA sig algorithms are registered at priority 5001.  The
kernel's crypto/mldsa.c registers at priority 5000 with verify-only
(sign returns -EOPNOTSUPP).  Our driver provides full HW-accelerated
sign + verify, so the higher priority ensures the hardware
implementation is preferred when the driver is loaded.

Power management uses DEFINE_SIMPLE_DEV_PM_OPS.  On suspend the
transaction manager drains in-flight requests (configurable 10s
timeout, returns -ECANCELED on timeout), stops the kthread, and
masks IRQs.  On resume it re-verifies SIC/boot status and restarts
the kthread.

Dependencies:
  - Kernel 7.1+ (based on Herbert Xu's cryptodev-2.6 tree, 7.2.0-rc1)
  - sig_alg backend (upstream since 6.13)
  - CRYPTO_AHASH_REQ_VIRT (native support, no fallback needed)
  - CMH eSW loaded independently by hardware before driver probe

The driver registers all algorithms through the standard in-kernel
crypto API; in-kernel users (dm-crypt, fscrypt, IPsec, etc.) consume
them directly.  Key provisioning and hardware-held-key operations are
exposed to user space via /dev/cmh_mgmt ioctls.

Public hardware documentation:
  Product brief: https://go.rambus.com/ch-7xx-and-cc-7xx-product-brief
  No public datasheets are currently available.  The driver was
  developed against the CRI CryptoManager Hub Hardware Reference
  Manual (Rambus Inc. confidential).  Detailed hardware reference is
  available under NDA from Rambus Inc.; contact the maintainers listed
  in MAINTAINERS for access during review.

Tested on RISC-V and ARM64 QEMU emulation with the CMH hardware
model (QEMU TCG, 512 MiB RAM).  Also exercised on Xilinx VMK180
FPGA board with real CMH IP.

  - testmgr: 41 CMH algorithm registrations matched by upstream
    test vectors, all pass; 30 names report "No test for" (PQC
    families, KMAC, cSHAKE - no upstream vectors yet).
  - kselftest tools/testing/selftests/drivers/crypto/cmh:
    6 pass, 0 fail.

checkpatch.pl --strict: 0 errors, 0 warnings, 0 checks on all
files (the only output is the expected per-file "does MAINTAINERS
need updating?" reminder, satisfied by the MAINTAINERS patch).
sparse (C=2): 0 warnings.
W=1 -Werror: clean.
make dt_binding_check: clean (dtschema validates the
cri,cmh.yaml binding).

Tested with the following debug options enabled simultaneously
(submit-checklist "Test your code" item 1):
  CONFIG_PROVE_LOCKING, CONFIG_PROVE_RCU, CONFIG_DEBUG_LOCK_ALLOC,
  CONFIG_DEBUG_OBJECTS_RCU_HEAD, CONFIG_SLUB_DEBUG,
  CONFIG_DEBUG_PAGEALLOC, CONFIG_DEBUG_MUTEXES, CONFIG_DEBUG_SPINLOCK,
  CONFIG_DEBUG_PREEMPT, CONFIG_DEBUG_ATOMIC_SLEEP.
  Result: no lockdep warnings, no ODEBUG splats, no slab corruption.

Additionally tested (separate passes - mutually exclusive configs):
  - CONFIG_KASAN + CONFIG_UBSAN + CONFIG_DEBUG_KMEMLEAK + CONFIG_KFENCE:
    no sanitizer findings; KMEMLEAK scan reports 0 unreferenced objects.
  - CONFIG_KCSAN (arm64; riscv64 lacks HAVE_ARCH_KCSAN):
    0 data-race reports attributed to the driver.

Stack usage: worst-case under 1 KB on both riscv64 and arm64
(scripts/checkstack.pl).  Hardware command buffers live in
per-request context (heap-allocated by the crypto framework).

Alex Ousherovitch (19):
  dt-bindings: crypto: add Rambus CryptoManager Hub
  crypto: cmh - add core platform driver
  crypto: cmh - add key provisioning and management
  crypto: cmh - add SHA-2/SHA-3/SHAKE ahash
  crypto: cmh - add HMAC ahash
  crypto: cmh - add CSHAKE/KMAC ahash
  crypto: cmh - add SM3 ahash
  crypto: cmh - add AES skcipher/aead/cmac
  crypto: cmh - add SM4 skcipher/aead/cmac/xcbc
  crypto: cmh - add ChaCha20-Poly1305
  crypto: cmh - add DRBG hwrng
  crypto: cmh - add RSA akcipher
  crypto: cmh - add ECDSA/SM2 sig
  crypto: cmh - add ECDH/X25519 kpp
  crypto: cmh - add ML-KEM/ML-DSA (QSE)
  crypto: cmh - add SLH-DSA/LMS/XMSS (HCQ)
  Documentation: ioctl: add CMH ioctl documentation and register 'J'
  selftests: crypto: cmh - add kselftest for management ioctl
  MAINTAINERS: add Rambus CryptoManager Hub (CMH)

Changes in v2:
 - crypto: cmh: wait for both eSW readiness bits at probe. The probe
   readiness gate polled SW_BOOT_STATUS for MISSION (bit 6, primary
   VCQ engine) only, but the sidecar engine signals readiness
   separately via MISSION2 (bit 7), asserted asynchronously. Gate on
   both bits so an operation offloaded to the sidecar cannot race an
   engine that is not yet up.
 - crypto: cmh: compute cmac(sm4) of a zero-length message in software.
   The SM4 core mishandles an empty CMAC input, so -- exactly like the
   existing xcbc(sm4) empty-message path, and per NIST SP 800-38B -- the
   driver now derives the K2 subkey and computes the tag with a software
   cipher. Surfaced by the testmgr fuzz comparison against the generic
   cmac(sm4); no change for non-empty messages.
 - Documentation: link cmh_mgmt.rst into the userspace-api/ioctl index
   toctree, fixing a "document isn't included in any toctree" htmldocs
   warning reported on the v1 posting of patch 17.
 - crypto: cmh: carry the XTS block offset (xts_offset) inline in the
   AES INIT command, matching the updated CMH hardware ABI that
   retired the separate XTS_OFFSET command. Always 0 on the skcipher
   path (data units start at block 0); no functional change.
 - MAINTAINERS: drop the internal moderated list (sipsupport@rambus.com)
   and the T: tree line from the CMH entry, per review. The driver
   goes through the crypto tree, so keep only linux-crypto@vger.kernel.org
   and no T: line.
 - Rebased onto current cryptodev-2.6 (v7.2-rc1); no code changes were
   required (the merge window touches none of the crypto APIs the driver
   uses).

v1: https://lore.kernel.org/linux-crypto/20260625173328.1140487-1-skrishnamoorthy@rambus.com/

base-commit: e264401ce4776a288524e5b87593d4d864147115
-- 
2.43.7


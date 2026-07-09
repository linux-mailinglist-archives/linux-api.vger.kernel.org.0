Return-Path: <linux-api+bounces-6826-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id nAtDKMQFUGoWsAIAu9opvQ
	(envelope-from <linux-api+bounces-6826-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Thu, 09 Jul 2026 22:34:12 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 08A0A73568A
	for <lists+linux-api@lfdr.de>; Thu, 09 Jul 2026 22:34:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=rambus.com header.s=selector1 header.b=fe1V0Pef;
	dmarc=pass (policy=reject) header.from=rambus.com;
	spf=pass (mail.lfdr.de: domain of "linux-api+bounces-6826-lists+linux-api=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-api+bounces-6826-lists+linux-api=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 791883006803
	for <lists+linux-api@lfdr.de>; Thu,  9 Jul 2026 20:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79AE13E8326;
	Thu,  9 Jul 2026 20:32:13 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11021119.outbound.protection.outlook.com [52.101.52.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F883D1A9A;
	Thu,  9 Jul 2026 20:31:34 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783629132; cv=fail; b=r1spLrWVrrX4PTcB0tupwNdPi+FYdY8uyyDvpca9fma5DUtWdHKFleNMKK/IewO/NqkqXCmRJuqk9SloBGNvSOrkHbfqGzd2O+skyCpPUFi4rBjPEHPqI1T0OrgcDTgl+Kqb3jqEXUlZZLrSTb6lweBjOnx/x+/J2XfY2/mpCuY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783629132; c=relaxed/simple;
	bh=oL6LEx+W606uXVmOgGEfRYNJoA9ZqP4GzNkuw5NT5E8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=csHAYRRFT9YKnuvmssNAaYOZUprku+zc/O9OrB5DziBywr4RXq0GOCZX/v0XemblYs7iSP/l9oA5A6itWBg+OtOZgUzfg2y0EDdwOvMW9tNFdM7fyRECHtVyduUgDDqTuPmDU38H9nlN1f/lB4cCGQjfmYOWo7DC7muqAKe/b1M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rambus.com; spf=fail smtp.mailfrom=rambus.com; dkim=pass (2048-bit key) header.d=rambus.com header.i=@rambus.com header.b=fe1V0Pef; arc=fail smtp.client-ip=52.101.52.119
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FZArd6QIFHy6XbAaVdW+dm8HOqt0786ivheE4Ig+t0z8Er+xIwz0YcacxJDWlYqXdtfudyD42NdihaTOdvlzhLAf9j3cQ8k7EAgcJ10twagkT8fKivEn11RFepLXGU/jYlqwLukq7uLmPMJI75UAYFUJ7hX5B4Y7EYlr8MBwhq2WCOctrJGajQI4Bd9eXX+7oed9wbFSurQR12DmI3wsM2mKzUYEXXoTLuh9vET0P9rwv/FOUd42vAWe9N6UFWv/FQPr0O5KGwRYDtuLY/Pg4s5vfQE340ioU4QzcJrolxDCJwBY+5Mt5mRSoxdViIbLzqJqHvT3RmARnjwpCKPy6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MvWaqmMDaIP4dbALPszgEROX+uBbEmO3MVb0gh3VX7k=;
 b=Qp1xDcgbtw7rOGnadyEK/MPF1VNuw1DUmLO3cMj6zQtah3b9dFZnVJIxG639Km2ZkcFwtkG7CV2+I+nT/JKwRH0jYoqPi8eLtCFQIO6RAzOWqRpqdZ1oULpC1tETq0VIlksu49XrNARyTM9gX3Gs9Xr6Bk4tB8vEMhGJ8hXrEz7bPj1laX3Oav8sdVXZesFekmERK4yvRFTqbEiqAfPwSNpDvrx96EohJuKQ1bWrjRCjBUCVxXqw0Ns7tOo/fbf43o5ZHDRLbltybN9jk4iJqvaNDdV55ynWBxRTufQPqY5ZyAHwoByP8JXgiwuJeeei6TjIR5gjenma8VP8TgQ+Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.86.86.210) smtp.rcpttodomain=cryptography.com smtp.mailfrom=rambus.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=rambus.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rambus.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MvWaqmMDaIP4dbALPszgEROX+uBbEmO3MVb0gh3VX7k=;
 b=fe1V0PefoxAbqgR9imHkBxh23Rq7U4EFaOR8PB1dbT94G5VFRe8p9I2NkPjLANmAFhRPAhS8SluajCgjswzNE8gwtL+DQl/EZu4MK9TVz9fmq4dsjhKAL7MtMlqcJiQqhhCsY9StDqVzfzqeMJt+2/1GZkRe2DH24pmTG8/4cy1Sg2mhnYQK61ZefuB24jIrW6SgcUOCRBxPo0I/jfeANvnuXzszW4IprTGmEb/gcjeAFa7qP3AecuTgW2ttFs6chIvkSt17y2qzzy/Xio0g5tX0nV/Jlf0vReZLNz03i+XbjkXax14L8TsbQjHaeCYDMbruUI0wFaSVpuelRy4DrA==
Received: from MW4PR03CA0082.namprd03.prod.outlook.com (2603:10b6:303:b6::27)
 by CH1PR04MB9784.namprd04.prod.outlook.com (2603:10b6:610:2b2::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.16; Thu, 9 Jul
 2026 20:31:21 +0000
Received: from CO1PEPF000075EF.namprd03.prod.outlook.com
 (2603:10b6:303:b6:cafe::9e) by MW4PR03CA0082.outlook.office365.com
 (2603:10b6:303:b6::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.12 via Frontend Transport; Thu, 9
 Jul 2026 20:31:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.86.86.210)
 smtp.mailfrom=rambus.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=rambus.com;
Received-SPF: Pass (protection.outlook.com: domain of rambus.com designates
 192.86.86.210 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.86.86.210; helo=hqxsv-psmtppxy02.rambus.com; pr=C
Received: from hqxsv-psmtppxy02.rambus.com (192.86.86.210) by
 CO1PEPF000075EF.mail.protection.outlook.com (10.167.249.38) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.6
 via Frontend Transport; Thu, 9 Jul 2026 20:31:20 +0000
Received: from hqxsv-cmdev3-skrishnamoorthy.rambus.com (hqn-lb-int-float.rambus.com [10.12.20.20])
	by hqxsv-psmtppxy02.rambus.com (Postfix) with ESMTPS id 26933180174A;
	Thu,  9 Jul 2026 20:31:20 +0000 (UTC)
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
Subject: [PATCH v2 02/19] crypto: cmh - add core platform driver
Date: Thu,  9 Jul 2026 13:30:20 -0700
Message-ID: <20260709203037.1884436-3-skrishnamoorthy@rambus.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260709203037.1884436-1-skrishnamoorthy@rambus.com>
References: <20260709203037.1884436-1-skrishnamoorthy@rambus.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075EF:EE_|CH1PR04MB9784:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: ad4fbe14-c02e-4bd1-72e0-08deddf90957
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|7416014|376014|82310400026|23010399003|22082099003|18002099003|5023799004|11063799006|3023799007|7136999003|6133799003|56012099006|921020;
X-Microsoft-Antispam-Message-Info:
	UNQrvhNaajhRtuGZOvO5fxqfgss3CEEhlIqOCDIKyW0gf4WH6CuKmjMTjMZstJMcOuAfSYxAbVK9YI+kPwJ/VcVyqGn1Bm1nJbjOxC7Fxzj0WtwqtUYNZ5Z8oo1CC9LtdmxGrp1lfZGiKvA9mKWmslP6LdmYCVQ93gM19ZniqweI2lfvjtyuwjx5i5JDV8Dj68vmJbsAJ3CVWXwbnrC9DEueHo7rP1BSl1Ys7jXHXBDZ/BjSyl3C6142PL1+T1bXk6z4OEnXyYYyCA1fnlU16Ricj0L7PLpVoe7kUXk4aDi/W/KeKyv5264gEg159VEfYUqZHkag71LIaGEbamwPlBZzlsPOLXOC0Z1PX2GCVYeC/VwhzdYy84S6awCuWjW7bMq7FvHva58+GfFyX+P28pAOkn/5E+eocye8CZL0cjq5cFjiwAecF6V9v42gb/mxfjCT+Tjp1eGvOT/HJBGJTPQooo+nSd3v6i0risI0f00OZ8pf1GtYVepuf6IoAGvX4LkcUOnhh5PlrBQUyATWpkIq1yTf46dAJ6LZ/bnBaPifKei9VRQ3mXtqY8Z4llAWUEZGqDasJ2MMkm4ITz10IuAgFSbhh+7++jFR6m/r+TulXXKNv98b0ov76Qco3zZKgWmIM79rl+F7cLw1OY0XJLsm8+5FyoLXoU41eK/bzI+ANyo935797pCVTzVOt/On4WSNb20pP5D62yqDY+r93+wivxMOux3njsxzN7bWZ2jPsvuFOF2fRXj8n9lIIt5m
X-Forefront-Antispam-Report:
	CIP:192.86.86.210;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hqxsv-psmtppxy02.rambus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(7416014)(376014)(82310400026)(23010399003)(22082099003)(18002099003)(5023799004)(11063799006)(3023799007)(7136999003)(6133799003)(56012099006)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	KOepvymWz/QV2icvypF0OppsBLp9RtMWcKPNVKcypl+vKmKFZwlsDcnLveD51hfrjm9dnYxNrQ57jHEAP8gIELkInKiemmXBjcdOlYdgc/WBdmzHF71HNyXCw7T4CLM6CIyjuZL0K8BqwfGfejdn5Z3JSTsVKKkr124OcOEqn6Z1aOTQaHmQOma28z6oMcVCcSTsuAujEGKm38MPmEc/MdVpqhmvuo6qcpdNb7yBn1MZYto96yOHnloq0ZYjIqHQGMOpJ32D1eMzsU0F7i1yuJsYfSp2xz/k3spk+14c05AXfJTk19eH2E0sx9+cu4YnZuXWqvgOzjCB8U/ylGlwS0qO2yaW1nyvSXVNcvrA2pHaNwGhLVnVoLjJgq7w/z39VLifSl2p8TZB+IqCzAyoTSTBgty4VTCwcxMNnn2WK/pQnRLSsl8KA6soMxGd2mwW
X-OriginatorOrg: rambus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 20:31:20.5387
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ad4fbe14-c02e-4bd1-72e0-08deddf90957
X-MS-Exchange-CrossTenant-Id: bd0ba799-c2b9-413c-9c56-5d1731c4827c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bd0ba799-c2b9-413c-9c56-5d1731c4827c;Ip=[192.86.86.210];Helo=[hqxsv-psmtppxy02.rambus.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000075EF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR04MB9784
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
	RCPT_COUNT_TWELVE(0.00)[23];
	TAGGED_FROM(0.00)[bounces-6826-lists,linux-api=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,rambus.com:from_mime,rambus.com:email,rambus.com:mid,rambus.com:dkim,cryptography.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-api,dt];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 08A0A73568A

From: Alex Ousherovitch <aousherovitch@rambus.com>

Add the CRI CryptoManager Hub (CMH) hardware crypto accelerator
core platform driver.  This patch provides:

- Platform driver registration and probe/remove lifecycle
- Hardware configuration and core discovery
- Mailbox Queue Interface (MQI) for VCQ command submission
- Transaction manager with async completion and backlog support
- Result handler with threaded-IRQ completion
- DMA buffer management
- Debugfs instrumentation (when CONFIG_CRYPTO_DEV_CMH_DEBUG=y)
- Sysfs attributes (fw_version, hw_version, product, algorithms)
- Kconfig and Makefile integration

No crypto algorithms are registered yet -- those follow in
subsequent patches.

The driver communicates with the hardware via a mailbox-based VCQ
(Virtual Command Queue) interface.  Each crypto operation is packed
into VCQ command entries, submitted to a mailbox, and completed
asynchronously via interrupt.

MODULE_IMPORT_NS(CRYPTO_INTERNAL) imports two symbols:

  - crypto_cipher_setkey()      [crypto/cipher.c, EXPORT_SYMBOL_NS_GPL]
  - crypto_cipher_encrypt_one() [crypto/cipher.c, EXPORT_SYMBOL_NS_GPL]

These are the single-block cipher API used for software-fallback paths:
CCM empty-input tag computation (2 ECB encryptions + XOR) and XCBC(SM4)
empty-message workaround (3 ECB encryptions + XOR).  No public wrapper
exists; this is the same pattern used by in-tree crypto/ccm.c,
crypto/cmac.c, and crypto/xcbc.c.

Co-developed-by: Saravanakrishnan Krishnamoorthy <skrishnamoorthy@rambus.com>
Signed-off-by: Saravanakrishnan Krishnamoorthy <skrishnamoorthy@rambus.com>
Signed-off-by: Alex Ousherovitch <aousherovitch@rambus.com>
Reviewed-by: Joel Wittenauer <Joel.Wittenauer@cryptography.com>
Reviewed-by: Thi Nguyen <thin@rambus.com>
---
 Documentation/ABI/testing/debugfs-driver-cmh  |  155 ++
 Documentation/ABI/testing/sysfs-driver-cmh    |   66 +
 Documentation/crypto/device_drivers/cmh.rst   |  356 +++
 Documentation/crypto/device_drivers/index.rst |    1 +
 drivers/crypto/Kconfig                        |    1 +
 drivers/crypto/Makefile                       |    1 +
 drivers/crypto/cmh/Kconfig                    |   46 +
 drivers/crypto/cmh/Makefile                   |   25 +
 drivers/crypto/cmh/cmh_config.c               |  476 ++++
 drivers/crypto/cmh/cmh_debugfs.c              |  286 +++
 drivers/crypto/cmh/cmh_dma.c                  |  373 ++++
 drivers/crypto/cmh/cmh_main.c                 |  371 ++++
 drivers/crypto/cmh/cmh_mqi.c                  |  355 +++
 drivers/crypto/cmh/cmh_rh.c                   | 1145 ++++++++++
 drivers/crypto/cmh/cmh_sysfs.c                |  108 +
 drivers/crypto/cmh/cmh_txn.c                  | 1978 +++++++++++++++++
 drivers/crypto/cmh/include/cmh.h              |   27 +
 drivers/crypto/cmh/include/cmh_aes_abi.h      |   98 +
 drivers/crypto/cmh/include/cmh_ccp_abi.h      |  108 +
 drivers/crypto/cmh/include/cmh_config.h       |   91 +
 drivers/crypto/cmh/include/cmh_debugfs.h      |   90 +
 drivers/crypto/cmh/include/cmh_dma.h          |  219 ++
 drivers/crypto/cmh/include/cmh_drbg_abi.h     |   67 +
 drivers/crypto/cmh/include/cmh_eac_abi.h      |   44 +
 drivers/crypto/cmh/include/cmh_hc_abi.h       |  162 ++
 drivers/crypto/cmh/include/cmh_hcq_abi.h      |  221 ++
 drivers/crypto/cmh/include/cmh_kic_abi.h      |   77 +
 drivers/crypto/cmh/include/cmh_mqi.h          |   36 +
 drivers/crypto/cmh/include/cmh_pke_abi.h      |  272 +++
 drivers/crypto/cmh/include/cmh_qse_abi.h      |  181 ++
 drivers/crypto/cmh/include/cmh_registers.h    |  146 ++
 drivers/crypto/cmh/include/cmh_rh.h           |   93 +
 drivers/crypto/cmh/include/cmh_rng.h          |   31 +
 drivers/crypto/cmh/include/cmh_sm3_abi.h      |   79 +
 drivers/crypto/cmh/include/cmh_sm4_abi.h      |  101 +
 drivers/crypto/cmh/include/cmh_sys_abi.h      |  148 ++
 drivers/crypto/cmh/include/cmh_sysfs.h        |   14 +
 drivers/crypto/cmh/include/cmh_txn.h          |  463 ++++
 drivers/crypto/cmh/include/cmh_vcq.h          |  283 +++
 39 files changed, 8794 insertions(+)
 create mode 100644 Documentation/ABI/testing/debugfs-driver-cmh
 create mode 100644 Documentation/ABI/testing/sysfs-driver-cmh
 create mode 100644 Documentation/crypto/device_drivers/cmh.rst
 create mode 100644 drivers/crypto/cmh/Kconfig
 create mode 100644 drivers/crypto/cmh/Makefile
 create mode 100644 drivers/crypto/cmh/cmh_config.c
 create mode 100644 drivers/crypto/cmh/cmh_debugfs.c
 create mode 100644 drivers/crypto/cmh/cmh_dma.c
 create mode 100644 drivers/crypto/cmh/cmh_main.c
 create mode 100644 drivers/crypto/cmh/cmh_mqi.c
 create mode 100644 drivers/crypto/cmh/cmh_rh.c
 create mode 100644 drivers/crypto/cmh/cmh_sysfs.c
 create mode 100644 drivers/crypto/cmh/cmh_txn.c
 create mode 100644 drivers/crypto/cmh/include/cmh.h
 create mode 100644 drivers/crypto/cmh/include/cmh_aes_abi.h
 create mode 100644 drivers/crypto/cmh/include/cmh_ccp_abi.h
 create mode 100644 drivers/crypto/cmh/include/cmh_config.h
 create mode 100644 drivers/crypto/cmh/include/cmh_debugfs.h
 create mode 100644 drivers/crypto/cmh/include/cmh_dma.h
 create mode 100644 drivers/crypto/cmh/include/cmh_drbg_abi.h
 create mode 100644 drivers/crypto/cmh/include/cmh_eac_abi.h
 create mode 100644 drivers/crypto/cmh/include/cmh_hc_abi.h
 create mode 100644 drivers/crypto/cmh/include/cmh_hcq_abi.h
 create mode 100644 drivers/crypto/cmh/include/cmh_kic_abi.h
 create mode 100644 drivers/crypto/cmh/include/cmh_mqi.h
 create mode 100644 drivers/crypto/cmh/include/cmh_pke_abi.h
 create mode 100644 drivers/crypto/cmh/include/cmh_qse_abi.h
 create mode 100644 drivers/crypto/cmh/include/cmh_registers.h
 create mode 100644 drivers/crypto/cmh/include/cmh_rh.h
 create mode 100644 drivers/crypto/cmh/include/cmh_rng.h
 create mode 100644 drivers/crypto/cmh/include/cmh_sm3_abi.h
 create mode 100644 drivers/crypto/cmh/include/cmh_sm4_abi.h
 create mode 100644 drivers/crypto/cmh/include/cmh_sys_abi.h
 create mode 100644 drivers/crypto/cmh/include/cmh_sysfs.h
 create mode 100644 drivers/crypto/cmh/include/cmh_txn.h
 create mode 100644 drivers/crypto/cmh/include/cmh_vcq.h

diff --git a/Documentation/ABI/testing/debugfs-driver-cmh b/Documentation/ABI/testing/debugfs-driver-cmh
new file mode 100644
index 000000000000..3bbf903a4511
--- /dev/null
+++ b/Documentation/ABI/testing/debugfs-driver-cmh
@@ -0,0 +1,155 @@
+What:		/sys/kernel/debug/cmh/mbx<N>/vcqs_submitted
+Date:		June 2026
+KernelVersion:	7.1
+Contact:	linux-crypto@vger.kernel.org
+Description:
+		(RO) Total number of VCQ command entries submitted to
+		mailbox N since the driver was loaded.
+
+What:		/sys/kernel/debug/cmh/mbx<N>/vcqs_completed
+Date:		June 2026
+KernelVersion:	7.1
+Contact:	linux-crypto@vger.kernel.org
+Description:
+		(RO) Total number of VCQ command completions received
+		from mailbox N.
+
+What:		/sys/kernel/debug/cmh/mbx<N>/vcqs_errors
+Date:		June 2026
+KernelVersion:	7.1
+Contact:	linux-crypto@vger.kernel.org
+Description:
+		(RO) Total number of error completions received from
+		mailbox N.
+
+What:		/sys/kernel/debug/cmh/mbx<N>/queue_full_count
+Date:		June 2026
+KernelVersion:	7.1
+Contact:	linux-crypto@vger.kernel.org
+Description:
+		(RO) Number of times the transaction manager skipped
+		mailbox N because its in-flight queue was full.
+
+What:		/sys/kernel/debug/cmh/mbx<N>/max_queue_depth
+Date:		June 2026
+KernelVersion:	7.1
+Contact:	linux-crypto@vger.kernel.org
+Description:
+		(RO) High-water mark of in-flight transactions on
+		mailbox N.
+
+What:		/sys/kernel/debug/cmh/mbx<N>/inject_abort
+Date:		June 2026
+KernelVersion:	7.1
+Contact:	linux-crypto@vger.kernel.org
+Description:
+		(WO) Write any value to inject an MBX_COMMAND_ABORT on
+		mailbox N.  The abort triggers error-IRQ handling that
+		completes all in-flight transactions with -EIO and then
+		issues MBX_COMMAND_RESTART to resume the mailbox.
+		Only available when CONFIG_CRYPTO_DEV_CMH_DEBUG is enabled.
+
+What:		/sys/kernel/debug/cmh/mbx<N>/force_drain
+Date:		June 2026
+KernelVersion:	7.1
+Contact:	linux-crypto@vger.kernel.org
+Description:
+		(WO) Write any value to unconditionally FLUSH and drain
+		all pending transactions on mailbox N, completing each
+		with -ECANCELED, and reset all recovery bookkeeping
+		(including the wedged flag).  The mailbox is re-enabled
+		for new work immediately; no hardware health verification
+		is performed.  Use as a last-resort recovery when the eSW
+		is unresponsive and normal ABORT/RESTART escalation has
+		not recovered the mailbox.
+		Only available when CONFIG_CRYPTO_DEV_CMH_DEBUG is enabled.
+
+What:		/sys/kernel/debug/cmh/tm/cmq_posts
+Date:		June 2026
+KernelVersion:	7.1
+Contact:	linux-crypto@vger.kernel.org
+Description:
+		(RO) Total number of cmh_tm_post_command() calls (one
+		per crypto request submitted to the transaction manager).
+
+What:		/sys/kernel/debug/cmh/tm/cmq_depth_max
+Date:		June 2026
+KernelVersion:	7.1
+Contact:	linux-crypto@vger.kernel.org
+Description:
+		(RO) High-water mark of the command queue length.
+
+What:		/sys/kernel/debug/cmh/tm/cmq_eagain_count
+Date:		June 2026
+KernelVersion:	7.1
+Contact:	linux-crypto@vger.kernel.org
+Description:
+		(RO) Number of times the command queue was full and
+		returned -EAGAIN to the caller.
+
+What:		/sys/kernel/debug/cmh/tm/backoff_count
+Date:		June 2026
+KernelVersion:	7.1
+Contact:	linux-crypto@vger.kernel.org
+Description:
+		(RO) Number of times the transaction manager backed off
+		because all mailbox queues were full.
+
+What:		/sys/kernel/debug/cmh/tm/async_timeout_count
+Date:		June 2026
+KernelVersion:	7.1
+Contact:	linux-crypto@vger.kernel.org
+Description:
+		(RO) Number of async crypto requests that timed out
+		waiting for hardware completion.
+
+What:		/sys/kernel/debug/cmh/config/async_timeout_ms
+Date:		June 2026
+KernelVersion:	7.1
+Contact:	linux-crypto@vger.kernel.org
+Description:
+		(RW) Async request timeout in milliseconds.  On timeout
+		the driver issues MBX_COMMAND_ABORT; if the eSW is
+		unresponsive, the watchdog escalates through RESTART,
+		FLUSH, and force-drain to bound D-state duration.
+
+What:		/sys/kernel/debug/cmh/config/vcq_timeout_ms
+Date:		June 2026
+KernelVersion:	7.1
+Contact:	linux-crypto@vger.kernel.org
+Description:
+		(RW) VCQ command timeout in milliseconds.
+
+What:		/sys/kernel/debug/cmh/config/slow_op_timeout_ms
+Date:		June 2026
+KernelVersion:	7.1
+Contact:	linux-crypto@vger.kernel.org
+Description:
+		(RW) Slow-operation timeout in milliseconds.  Used for
+		operations known to take longer (e.g. RSA key generation,
+		PQC key generation).
+
+What:		/sys/kernel/debug/cmh/config/drain_timeout_ms
+Date:		June 2026
+KernelVersion:	7.1
+Contact:	linux-crypto@vger.kernel.org
+Description:
+		(RW) Drain timeout in milliseconds.  Maximum time to wait
+		for all in-flight transactions to complete during driver
+		removal or suspend.
+
+What:		/sys/kernel/debug/cmh/config/watchdog_ms
+Date:		June 2026
+KernelVersion:	7.1
+Contact:	linux-crypto@vger.kernel.org
+Description:
+		(RW) Result-handler watchdog interval in milliseconds.
+		Detects missed IRQs, stuck mailboxes, and abort-stall
+		conditions.  Clamped to a 10 ms minimum.
+
+What:		/sys/kernel/debug/cmh/config/drbg_timeout_ms
+Date:		June 2026
+KernelVersion:	7.1
+Contact:	linux-crypto@vger.kernel.org
+Description:
+		(RW) DRBG self-seed timeout in milliseconds.
diff --git a/Documentation/ABI/testing/sysfs-driver-cmh b/Documentation/ABI/testing/sysfs-driver-cmh
new file mode 100644
index 000000000000..62e593fac6fe
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-driver-cmh
@@ -0,0 +1,66 @@
+What:		/sys/devices/platform/<dev>/fw_version
+Date:		June 2026
+KernelVersion:	7.1
+Contact:	linux-crypto@vger.kernel.org
+Description:
+		Reports the CryptoManager Hub embedded software (eSW) firmware
+		version as a 32-bit hexadecimal value read from the SIC
+		SW_VERSION register.
+
+		Example: "0x00010002"
+
+		Read-only.
+
+What:		/sys/devices/platform/<dev>/hw_version
+Date:		June 2026
+KernelVersion:	7.1
+Contact:	linux-crypto@vger.kernel.org
+Description:
+		Reports the CryptoManager Hub hardware version as a 32-bit
+		hexadecimal value read from the SIC HW_VERSION0 register.
+
+		Example: "0x00000000"
+
+		Read-only.
+
+What:		/sys/devices/platform/<dev>/boot_status
+Date:		June 2026
+KernelVersion:	7.1
+Contact:	linux-crypto@vger.kernel.org
+Description:
+		Reports the CryptoManager Hub boot status register as a 32-bit
+		hexadecimal value.  This reflects the firmware boot
+		progress and final state:
+
+		  0x00000066 - firmware booted (post-self-test)
+		  other      - firmware boot in progress or failed
+
+		Read-only.
+
+What:		/sys/devices/platform/<dev>/mbx_available
+Date:		June 2026
+KernelVersion:	7.1
+Contact:	linux-crypto@vger.kernel.org
+Description:
+		Reports the mailbox availability bitmap as a 32-bit
+		hexadecimal value read from the SIC MBX_AVAILABILITY
+		register.  Each set bit indicates a hardware mailbox
+		instance that the firmware has made available.
+
+		Example: "0x00000003" (mailboxes 0 and 1 available)
+
+		Read-only.
+
+What:		/sys/devices/platform/<dev>/mbx_count
+Date:		June 2026
+KernelVersion:	7.1
+Contact:	linux-crypto@vger.kernel.org
+Description:
+		Reports the number of mailboxes the driver has configured,
+		as a decimal integer.  This reflects the driver's active
+		configuration (from DT properties or module parameters),
+		which may be fewer than illustrated by mbx_available.
+
+		Example: "2"
+
+		Read-only.
diff --git a/Documentation/crypto/device_drivers/cmh.rst b/Documentation/crypto/device_drivers/cmh.rst
new file mode 100644
index 000000000000..4319b9ff1ab1
--- /dev/null
+++ b/Documentation/crypto/device_drivers/cmh.rst
@@ -0,0 +1,356 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+====================================
+CRI CryptoManager Hub (CMH) Driver
+====================================
+
+Overview
+========
+
+The ``cmh`` driver supports the CRI CryptoManager Hub hardware cryptographic
+accelerator.  The hardware is accessed through a mailbox-based VCQ
+(Virtual Command Queue) interface: the driver writes command sequences
+into per-mailbox DMA queue buffers and rings a doorbell register; the
+CryptoManager Hub embedded software (eSW) processes the commands and signals
+completion via a per-mailbox interrupt.
+
+The driver registers algorithms with the Linux kernel crypto subsystem
+and exposes a management character device (``/dev/cmh_mgmt``) for
+operations that have no standard crypto API binding.
+
+Hardware Interface
+==================
+
+The CryptoManager Hub is presented as a platform device matched via Device Tree
+(compatible ``"cri,cmh"``).  The driver maps a single MMIO region
+(the SIC -- System Interface Controller) whose sub-regions contain
+per-mailbox doorbell, status, and command queue registers.
+
+The driver manages a configurable number of mailboxes (default 2).
+Each mailbox has a configurable number of slots (default 32) and a
+configurable stride (default 128 bytes per slot).  The driver allocates
+DMA-coherent memory for each mailbox queue during probe.
+
+Interrupts are per-mailbox completion/error interrupts.  The driver
+registers a threaded IRQ handler for each configured mailbox.
+
+The eSW is loaded independently of this driver -- typically by the
+boot firmware or a platform-specific loader -- so the driver does not
+use ``request_firmware()``.  Instead it waits for the eSW to reach
+mission mode during probe, bounded by ``fw_ready_timeout_ms``.
+
+Supported Algorithms
+====================
+
+The driver registers the following algorithm families:
+
+Hash (ahash)
+  SHA-224, SHA-256, SHA-384, SHA-512, SHA3-224, SHA3-256, SHA3-384,
+  SHA3-512, SHAKE-128, SHAKE-256, cSHAKE-128, cSHAKE-256, KMAC-128,
+  KMAC-256, SM3 (10 hash + 2 cSHAKE + 2 KMAC + 1 SM3 = 15 algorithms)
+
+HMAC (ahash)
+  HMAC-SHA-224, HMAC-SHA-256, HMAC-SHA-384, HMAC-SHA-512,
+  HMAC-SHA3-224, HMAC-SHA3-256, HMAC-SHA3-384, HMAC-SHA3-512
+  (8 algorithms)
+
+Symmetric Ciphers (skcipher)
+  AES: ECB, CBC, CTR, CFB, XTS (5 algorithms)
+  SM4: ECB, CBC, CTR, CFB, XTS (5 algorithms)
+  ChaCha20 (1 algorithm)
+
+AEAD
+  AES-GCM, AES-CCM (2 algorithms)
+  SM4-GCM, SM4-CCM (2 algorithms)
+  ``rfc7539(chacha20,poly1305)``, ``rfc7539esp(chacha20,poly1305)``
+  (2 algorithms)
+
+MAC (ahash)
+  CMAC(AES) (1 algorithm)
+  CMAC(SM4), XCBC(SM4) (2 algorithms)
+  Poly1305 (1 algorithm)
+
+Public-Key, Key Agreement, and PQC Signatures
+  RSA (akcipher, 1 algorithm)
+  ECDSA P-256, P-384, P-521 (sig, 3 algorithms)
+  SM2 (sig, verify-only, 1 algorithm)
+  ECDH P-256, P-384, X25519 (kpp, 3 algorithms)
+  ML-DSA-44, ML-DSA-65, ML-DSA-87 (sig, 3 algorithms)
+  SLH-DSA: all 12 parameter sets (sig, 12 algorithms)
+  LMS, LMS-HSS (sig, verify-only, 2 algorithms)
+  XMSS, XMSS-MT (sig, verify-only, 2 algorithms)
+  (ML-KEM keygen/encaps/decaps is available via ``/dev/cmh_mgmt``
+  only -- see `Limitations`_.)
+
+Hardware RNG
+  DRBG-backed hwrng (``/dev/hwrng``, 1 algorithm)
+
+All algorithm driver names use the ``cri-cmh-`` prefix (e.g.
+``cri-cmh-sha256``, ``cri-cmh-ecb-aes``, ``cri-cmh-gcm-aes``,
+``cri-cmh-mldsa44``).  Names generally follow the kernel's hyphenated
+template name; families that have no kernel template (e.g. ML-DSA) use
+the concatenated upstream algorithm name (``mldsa44``).
+
+Most algorithms register at priority 300 (301 for AES-CCM).
+The ML-DSA ``sig`` algorithms register at priority 5001 to
+outrank the kernel's generic software ML-DSA (priority 5000, which is
+verify-only); the CMH driver provides full hardware sign and verify.
+
+Request model
+-------------
+
+All crypto API operations are asynchronous: the driver queues each
+request to its transaction-manager kthread and returns
+``-EINPROGRESS``, invoking the caller's completion callback when the
+hardware finishes.  Requests that set ``CRYPTO_TFM_REQ_MAY_BACKLOG``
+are queued on a backlog of up to ``backlog_max_depth`` entries when the
+command queue is full; without that flag a full queue is reported as
+``-EBUSY``.  Hardware or eSW failures surface as ``-EIO``, malformed
+requests as ``-EINVAL``, oversized requests as ``-EMSGSIZE`` or
+``-EINVAL`` (see `Data-Size Limits`_), and unresponsive hardware as
+``-ETIMEDOUT``.  The ``/dev/cmh_mgmt`` ioctls are, by contrast,
+synchronous -- each ioctl blocks until the hardware completes.
+
+Driver Architecture
+===================
+
+The driver is structured as follows:
+
+Platform Driver
+  Matches DT compatible ``"cri,cmh"``.  Probe initializes all
+  subsystems in order; remove tears them down in reverse.
+
+Configuration
+  Parses DT properties and module parameter overrides.  Validates
+  mailbox counts, slot sizes, and stride values.
+
+MQI (Mailbox Queue Interface)
+  Allocates DMA-coherent queue memory per mailbox.  Manages slot
+  allocation, VCQ command writing, and doorbell ringing.
+
+Transaction Manager
+  A dedicated kthread dequeues crypto requests from a central command
+  queue, builds VCQ command sequences, and submits them to mailbox
+  slots.  Completion is signaled via wait queues.
+
+Response Handler
+  Per-mailbox threaded IRQ handlers walk completed slots, parse
+  results, and fire request completions.  A configurable watchdog
+  timer (the ``watchdog_ms`` debugfs knob, default 200 ms) detects
+  stuck requests and escalates through ABORT, RESTART, and FLUSH
+  recovery.
+
+Key Management (``/dev/cmh_mgmt``)
+  A misc character device providing ioctl-based access to datastore
+  key CRUD, key derivation (KIC), PKE operations (EdDSA, SM2),
+  PQC operations (ML-KEM, ML-DSA, SLH-DSA),
+  EAC error register readback, and DRBG runtime configuration.
+  See ``Documentation/ABI/testing/cmh-mgmt`` for the full ioctl list.
+
+Power Management
+  The driver implements ``DEFINE_SIMPLE_DEV_PM_OPS`` suspend/resume.
+  On suspend, the transaction-manager kthread is stopped and pending
+  transactions are drained, waiting up to ``drain_timeout_ms``
+  (default 10000 ms); resume restarts the kthread.
+
+Module Parameters
+=================
+
+The driver defines four production module parameters and five
+debug-only parameters (compiled only with
+``CONFIG_CRYPTO_DEV_CMH_DEBUG``).  In production, all mailbox topology,
+per-core affinity, slot counts, strides, and timeout tuning are taken
+from Device Tree properties, not module parameters.  The debug-only
+parameters exist solely to force alternate geometries at ``insmod``
+time during bringup and validation (for example, to drive the
+mailbox-contention and cross-mailbox dispatch paths without
+rebuilding the Device Tree); they default to "use the DT value"
+and have no effect in a production build.
+
+Production:
+
+``fw_ready_timeout_ms`` (uint, default 5000, RO)
+  Timeout in milliseconds to wait for CMH eSW to reach mission mode
+  during probe.
+
+``cmq_max_depth`` (uint, default 256, RO)
+  Maximum number of pending commands in the central Command Message
+  Queue.
+
+``backlog_max_depth`` (uint, default 1024, RO)
+  Maximum depth of the backlog queue for ``CRYPTO_TFM_REQ_MAY_BACKLOG``
+  requests.  Set to 0 to disable backlogs.
+
+``hwrng_quality`` (int, default 0, RO)
+  Quality value passed to ``hwrng_register()``.  0 disables kernel CRNG
+  seeding; 1-1024 sets the quality directly.
+
+Debug-only (``CONFIG_CRYPTO_DEV_CMH_DEBUG``):
+
+``mbx_count_override`` (uint, default 0, RO)
+  Override the DT mailbox count (0 = use DT) to force fewer
+  mailboxes than the hardware provides.
+
+``mbx_slots_override`` (uint, default 0, RO)
+  Override all MBX slots_log2 values (0 = use DT).
+
+``mbx_round_robin`` (bool, default false, RO)
+  Ignore DT ``cri,mbx`` affinity pins and round-robin all cores
+  across the configured mailboxes (0 = use DT affinity).  Restores
+  the unpinned dispatch that exercises cross-mailbox distribution.
+
+``drbg_config`` (charp, default "auto", RO)
+  DRBG configuration at probe: ``"auto"`` (normal) or ``"skip"``
+  (skip initial DRBG configuration).
+
+``skip_fw_check`` (bool, default false, RO)
+  Skip the SIC boot status and eSW mission-mode checks at probe.
+  Allows the module to load before the eSW has booted.
+
+Runtime-tunable timeout knobs are exposed via debugfs rather than
+module parameters; see `debugfs Counters`_ below.
+
+sysfs Attributes
+================
+
+The driver exposes five read-only attributes under the platform
+device sysfs directory: ``fw_version``, ``hw_version``,
+``boot_status``, ``mbx_available``, and ``mbx_count``.  See
+``Documentation/ABI/testing/sysfs-driver-cmh`` for the authoritative
+per-attribute description.
+
+debugfs Counters
+================
+
+When built with ``CONFIG_CRYPTO_DEV_CMH_DEBUG``, the driver creates
+``/sys/kernel/debug/cmh/`` with three groups: per-mailbox counters
+(``mbxN/``), transaction-manager statistics (``tm/``), and
+runtime-tunable timeout knobs (``config/``, including
+``drain_timeout_ms`` and ``watchdog_ms``).  See
+``Documentation/ABI/testing/debugfs-driver-cmh`` for the authoritative
+per-file description.
+
+Device Tree Binding
+===================
+
+See ``Documentation/devicetree/bindings/crypto/cri,cmh.yaml`` for the
+full DT binding schema and complete, schema-validated examples
+(including the per-mailbox topology properties ``cri,mbx-instances``,
+``cri,mbx-slots-log2``, and ``cri,mbx-strides-log2``).  When those
+properties are omitted the driver falls back to two mailboxes
+(instances 0 and 1) with the slot/stride defaults described above.
+
+User-Space Interfaces
+=====================
+
+``/dev/cmh_mgmt``
+  Management character device.  Opening it requires ``CAP_SYS_ADMIN``.
+  See ``Documentation/ABI/testing/cmh-mgmt`` for ioctl documentation.
+  The UAPI header is ``<linux/cmh_mgmt_ioctl.h>``.
+
+In-kernel crypto API
+  All algorithms register with the standard kernel crypto API and are
+  consumed by in-kernel users (dm-crypt, fscrypt, IPsec, kTLS, etc.).
+
+  Keys provisioned inside the hardware via ``/dev/cmh_mgmt`` are
+  referenced by an opaque hardware key identifier and are operated on
+  through the ``/dev/cmh_mgmt`` ioctl interface, without ever exposing
+  plaintext key material to user space.  See
+  ``Documentation/ABI/testing/cmh-mgmt`` for key provisioning.
+
+``/dev/hwrng``
+  The DRBG-backed hardware RNG is available as a standard hwrng device.
+
+Limitations
+===========
+
+- LMS and XMSS support verify-only (no sign/keygen in hardware for
+  stateful hash-based signatures).
+- SM2 sig registration is verify-only (sign via ``/dev/cmh_mgmt`` ioctl).
+- EdDSA (Ed25519/Ed448) is available only through ``/dev/cmh_mgmt``
+  ioctls; no kernel ``sig`` registration.
+- ML-KEM operations (encapsulate/decapsulate/keygen) are available only
+  through ``/dev/cmh_mgmt`` ioctls; no standard kernel crypto API
+  binding exists for KEM.
+
+Data-Size Limits
+================
+
+The driver imposes data-size limits on several APIs.  These are
+driver-level safety caps for kernel memory allocation unless noted
+otherwise.
+
+Symmetric / AEAD / MAC linearization caps:
+
+==============================  =======  =======================================
+Scope                           Limit    Origin
+==============================  =======  =======================================
+AES skcipher                    32 MiB   Driver-imposed DMA linearization cap
+SM4 skcipher                    32 MiB   Driver-imposed DMA linearization cap
+All AEAD + ChaCha20 skcipher    1 MiB    Driver-imposed DMA linearization cap
+==============================  =======  =======================================
+
+MAC and keyed-hash algorithms that buffer all input in kernel memory
+(hardware lacks context save/restore):
+
+====================  =======  =============================================
+Algorithm             Limit    Reason
+====================  =======  =============================================
+``cmac(aes)``         64 KiB   AES core has no external save/restore
+``cmac(sm4)``         64 KiB   SM4 core has no external save/restore
+``xcbc(sm4)``         64 KiB   SM4 core has no external save/restore
+``poly1305``          64 KiB   CCP core has no external save/restore
+``hmac(sha*)``        64 KiB   HMAC save/restore not supported (see below)
+``hmac(sha3-*)``      64 KiB   HMAC save/restore not supported (see below)
+``kmac128``           64 KiB   eSW rejects save when outlen != 0
+``kmac256``           64 KiB   eSW rejects save when outlen != 0
+====================  =======  =============================================
+
+HMAC save/restore is unsupported by the eSW firmware.  For HMAC-SHA3,
+exposing the Keccak sponge state would allow key recovery because the
+sponge permutation is invertible; HMAC-SHA2 save/restore is likewise
+not exposed by the eSW.
+
+HMAC ``.export()``/``.import()`` (used for request cloning) is limited
+to a single-page accumulated-data window of 4092 bytes (one page minus
+a 4-byte length header), since the crypto subsystem pre-allocates the
+state buffer per request.  Cloning a request that has accumulated more
+input than this window fails.
+
+Requests exceeding the limit are rejected with ``-EINVAL``.  Pure hash
+algorithms (SHA-2, SHA-3, SHAKE, cSHAKE, SM3) have no data limit because
+the hardware supports incremental save/restore.
+
+cSHAKE uses save/restore for ``.export()``/``.import()`` but accumulates
+data in ``.update()`` by design (the Keccak sponge has no block-alignment
+boundary to trigger per-update HW submission, and HC_CMD_GATHER amortizes
+the cost into a single finalize-time submission).
+
+Asymmetric / PQC algorithm limits:
+
+==============================  =========  ====================================
+Scope                           Limit      Origin
+==============================  =========  ====================================
+RSA key size                    4096 bit   HW-imposed
+ML-DSA message                  10 KiB     eSW-imposed (QSE ABI)
+SLH-DSA message                 128 B      eSW-imposed (HCQ ABI)
+SLH-DSA context                 255 B      Spec-imposed (FIPS 205)
+LMS public key                  60 B       eSW-imposed (HCQ ABI)
+LMS message                     256 B      eSW-imposed (HCQ ABI)
+LMS signature                   13,364 B   eSW-imposed (HCQ ABI)
+XMSS public key                 136 B      eSW-imposed (HCQ ABI)
+XMSS message                    64 B       eSW-imposed (HCQ ABI)
+XMSS signature                  27,688 B   eSW-imposed (HCQ ABI)
+SM2 encrypt message             32 B       eSW KDF (single SM3 block)
+==============================  =========  ====================================
+
+Miscellaneous limits:
+
+==============================  =========  ====================================
+Scope                           Limit      Origin
+==============================  =========  ====================================
+cSHAKE/KMAC customization       256 B      VCQ slot layout constraint
+KIC HKDF key                    64 B       Partially eSW-derived
+KIC HKDF label                  56 B       VCQ slot layout constraint
+Key/blob mgmt ioctls            256 KiB    Driver-imposed sanity cap
+==============================  =========  ====================================
diff --git a/Documentation/crypto/device_drivers/index.rst b/Documentation/crypto/device_drivers/index.rst
index c81d311ac61b..c0247fc97bf8 100644
--- a/Documentation/crypto/device_drivers/index.rst
+++ b/Documentation/crypto/device_drivers/index.rst
@@ -6,4 +6,5 @@ Hardware Device Driver Specific Documentation
 .. toctree::
    :maxdepth: 1
 
+   cmh
    octeontx2
diff --git a/drivers/crypto/Kconfig b/drivers/crypto/Kconfig
index 03a8f7a1f75e..9ab4b1218924 100644
--- a/drivers/crypto/Kconfig
+++ b/drivers/crypto/Kconfig
@@ -827,4 +827,5 @@ source "drivers/crypto/starfive/Kconfig"
 source "drivers/crypto/inside-secure/eip93/Kconfig"
 source "drivers/crypto/ti/Kconfig"
 
+source "drivers/crypto/cmh/Kconfig"
 endif # CRYPTO_HW
diff --git a/drivers/crypto/Makefile b/drivers/crypto/Makefile
index 2c33b83f3cfa..dae0d5f0500d 100644
--- a/drivers/crypto/Makefile
+++ b/drivers/crypto/Makefile
@@ -46,3 +46,4 @@ obj-y += intel/
 obj-y += starfive/
 obj-y += cavium/
 obj-y += ti/
+obj-$(CONFIG_CRYPTO_DEV_CMH) += cmh/
diff --git a/drivers/crypto/cmh/Kconfig b/drivers/crypto/cmh/Kconfig
new file mode 100644
index 000000000000..fa5adeca2512
--- /dev/null
+++ b/drivers/crypto/cmh/Kconfig
@@ -0,0 +1,46 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# CRI CryptoManager Hub (CMH) hardware crypto accelerator
+#
+
+config CRYPTO_DEV_CMH
+	tristate "CRI CryptoManager Hub (CMH) hardware crypto accelerator"
+	depends on CRYPTO && OF && HAS_IOMEM && (64BIT || COMPILE_TEST)
+	select CRYPTO_HASH
+	select CRYPTO_SKCIPHER
+	select CRYPTO_AEAD
+	select CRYPTO_AKCIPHER
+	select CRYPTO_SIG
+	select CRYPTO_KPP
+	select CRYPTO_ECC
+	select CRYPTO_RSA
+	select CRYPTO_AES
+	select CRYPTO_CCM
+	select CRYPTO_SM4_GENERIC
+	select HW_RANDOM
+	help
+	  Driver for the CRI CryptoManager Hub (CMH) hardware crypto accelerator.
+	  Accesses the hardware via a mailbox-based VCQ (Virtual Command
+	  Queue) interface and registers algorithms with the kernel
+	  crypto subsystem.
+
+	  Supported algorithm families: AES (ECB/CBC/CTR/XTS/CFB),
+	  SM4 (ECB/CBC/CTR/XTS/CFB), ChaCha20-Poly1305, AES-GCM, AES-CCM,
+	  SHA-2, SHA-3, SHAKE, CSHAKE, KMAC, SM3, HMAC, AES-CMAC,
+	  SM4-CMAC, SM4-XCBC, RSA, ECDSA, ECDH, SM2, and DRBG (hwrng).
+	  Ioctl-only algorithms: EdDSA, ML-KEM.
+
+	  To compile this driver as a module, choose M here.
+
+config CRYPTO_DEV_CMH_DEBUG
+	bool "CMH debug instrumentation (debugfs counters)"
+	depends on CRYPTO_DEV_CMH && DEBUG_FS
+	help
+	  Enable per-mailbox debugfs counters under
+	  /sys/kernel/debug/cmh/ for the CMH driver.
+	  Exposes VCQ submit/complete/error counts, queue depth
+	  high-water marks, and transaction manager backoff statistics.
+
+	  Useful for bringup, validation, and performance analysis.
+	  Not recommended for production.
+
diff --git a/drivers/crypto/cmh/Makefile b/drivers/crypto/cmh/Makefile
new file mode 100644
index 000000000000..0a4591c9fd86
--- /dev/null
+++ b/drivers/crypto/cmh/Makefile
@@ -0,0 +1,25 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Makefile for the CRI CryptoManager Hub (CMH) hardware crypto accelerator driver.
+#
+
+obj-$(CONFIG_CRYPTO_DEV_CMH) += cmh.o
+
+cmh-y := \
+	cmh_main.o \
+	cmh_config.o \
+	cmh_mqi.o \
+	cmh_txn.o \
+	cmh_rh.o \
+	cmh_dma.o \
+	cmh_sysfs.o
+
+ccflags-y += -I$(src)/include
+
+# Suppress -Woverride-init for the [0 ... N] = -1 range-initializer pattern
+# (standard kernel idiom for sparse lookup tables with a default value).
+CFLAGS_cmh_config.o += -Wno-override-init
+
+# Debug instrumentation: per-mailbox debugfs counters.
+# cmh_debugfs.o is linked into the composite cmh.o (same tristate).
+cmh-$(CONFIG_CRYPTO_DEV_CMH_DEBUG) += cmh_debugfs.o
diff --git a/drivers/crypto/cmh/cmh_config.c b/drivers/crypto/cmh/cmh_config.c
new file mode 100644
index 000000000000..4631eebb1556
--- /dev/null
+++ b/drivers/crypto/cmh/cmh_config.c
@@ -0,0 +1,476 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2026 Cryptography Research, Inc. (CRI).
+ * CMH LKM -- Configuration from Device Tree
+ *
+ * The CMH device tree node provides:
+ *   - reg: SIC base + size (mandatory)
+ *   - interrupts: per-MBX IRQs (mandatory for IRQ mode)
+ *   - cri,mbx-instances: array of MBX instance IDs
+ *   - cri,mbx-slots-log2: per-MBX slot count as log2
+ *   - cri,mbx-strides-log2: per-MBX stride as log2
+ *
+ * Per-core-type child nodes (e.g. aes@3, pke@a):
+ *   - reg: hardware core ID (CORE_ID_* from cmh_vcq.h)
+ *   - cri,mbx: (optional) pin to a specific MBX index
+ *
+ * Module parameters (non-topology):
+ *   - fw_ready_timeout_ms: CMH eSW mission-mode boot timeout
+ *   (hwrng_quality, cmq_max_depth, backlog_max_depth live in other files)
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/platform_device.h>
+#include <linux/of.h>
+
+#include "cmh_config.h"
+#include "cmh_dma.h"
+
+/* -- Module parameters ------------------------------------------------- */
+
+static unsigned int fw_ready_timeout_ms = CMH_DEFAULT_FW_READY_TIMEOUT_MS;
+module_param(fw_ready_timeout_ms, uint, 0444);
+MODULE_PARM_DESC(fw_ready_timeout_ms,
+		 "Timeout in ms to wait for CMH eSW mission mode (default 5000)");
+
+/*
+ * Debug-only MBX overrides for stress testing.
+ * When non-zero, these override the corresponding DT values, enabling
+ * contention stress tests to force a minimal MBX config
+ * (e.g. mbx_count_override=1 mbx_slots_override=1 for 1 MBX, 2 slots).
+ */
+#ifdef CONFIG_CRYPTO_DEV_CMH_DEBUG
+static unsigned int mbx_count_override;
+module_param(mbx_count_override, uint, 0444);
+MODULE_PARM_DESC(mbx_count_override,
+		 "[debug] Override DT MBX count (0 = use DT, default: 0)");
+
+static unsigned int mbx_slots_override;
+module_param(mbx_slots_override, uint, 0444);
+MODULE_PARM_DESC(mbx_slots_override,
+		 "[debug] Override all MBX slots_log2 (0 = use DT, default: 0)");
+
+static bool mbx_round_robin;
+module_param(mbx_round_robin, bool, 0444);
+MODULE_PARM_DESC(mbx_round_robin,
+		 "[debug] Ignore DT cri,mbx pins and round-robin all cores across MBXes (0 = use DT affinity, default: 0)");
+#endif
+
+/* -- Core ID -> core_type lookup --------------------------------------- */
+
+/*
+ * Map hardware core IDs (from DT child "reg") to enum cmh_core_type.
+ *
+ * Entries set to -1 are not dispatchable crypto cores: system cores
+ * (SYS, DMA, KIC, TIC, MPU, EMC, EAC) and the DRBG singleton
+ * (handled separately in cmh_rng.c).
+ */
+static const int core_id_to_type[CORE_ID_NUM] = {
+	[0 ... CORE_ID_NUM - 1] = -1,
+	[CORE_ID_HC]  = CMH_CORE_HC,
+	[CORE_ID_AES] = CMH_CORE_AES,
+	[CORE_ID_SM4] = CMH_CORE_SM4,
+	[CORE_ID_SM3] = CMH_CORE_SM3,
+	[CORE_ID_CCP] = CMH_CORE_CCP,
+	[CORE_ID_PKE] = CMH_CORE_PKE,
+	[CORE_ID_QSE] = CMH_CORE_QSE,
+	[CORE_ID_HCQ] = CMH_CORE_HCQ,
+};
+
+/* Human-readable names for error messages */
+static const char * const core_type_names[CMH_NUM_CORE_TYPES] = {
+	[CMH_CORE_HC]  = "hc",
+	[CMH_CORE_AES] = "aes",
+	[CMH_CORE_SM4] = "sm4",
+	[CMH_CORE_SM3] = "sm3",
+	[CMH_CORE_CCP] = "ccp",
+	[CMH_CORE_PKE] = "pke",
+	[CMH_CORE_QSE] = "qse",
+	[CMH_CORE_HCQ] = "hcq",
+};
+
+/* -- DT child node enumeration ----------------------------------------- */
+
+static int cmh_config_populate_cores(struct cmh_config *cfg,
+				     struct device_node *np)
+{
+	struct device_node *child;
+	u32 core_id, mbx_val;
+	int type, ret;
+
+	for_each_child_of_node(np, child) {
+		ret = of_property_read_u32(child, "reg", &core_id);
+		if (ret) {
+			dev_warn(cmh_dev(),
+				 "DT child %pOFn: missing 'reg', skipping\n",
+				 child);
+			continue;
+		}
+
+		if (core_id >= CORE_ID_NUM) {
+			dev_info(cmh_dev(),
+				 "DT child %pOFn: core_id 0x%02x unknown, skipping\n",
+				 child, core_id);
+			continue;
+		}
+
+		type = core_id_to_type[core_id];
+		if (type < 0) {
+			/* Not a dispatchable crypto core (DRBG, SYS, etc.) */
+			dev_dbg(cmh_dev(),
+				"DT child %pOFn: core_id 0x%02x not dispatchable\n",
+				child, core_id);
+			continue;
+		}
+
+		if (cfg->core_types[type].num_instances >=
+		    CMH_MAX_CORE_INSTANCES) {
+			dev_err(cmh_dev(),
+				"DT: too many instances for %s (max %u)\n",
+				core_type_names[type],
+				CMH_MAX_CORE_INSTANCES);
+			of_node_put(child);
+			return -EINVAL;
+		}
+
+		{
+			struct cmh_core_type_cfg *ct = &cfg->core_types[type];
+			u32 idx = ct->num_instances;
+
+			ct->core_ids[idx] = core_id;
+			ret = of_property_read_u32(child, "cri,mbx", &mbx_val);
+			ct->mbx[idx] = ret ? -1 : (s32)mbx_val;
+#ifdef CONFIG_CRYPTO_DEV_CMH_DEBUG
+			/*
+			 * Debug knob for the cross-core stress test: drop the
+			 * DT MBX pin so cmh_core_select_instance() round-robins
+			 * this core across all configured MBXes (the unpinned
+			 * dispatch behaviour exercised before cri,mbx affinity
+			 * was added to the baseline device tree).
+			 */
+			if (mbx_round_robin)
+				ct->mbx[idx] = -1;
+#endif
+			ct->num_instances++;
+		}
+	}
+
+	return 0;
+}
+
+/* -- Validation -------------------------------------------------------- */
+
+static int cmh_config_validate_core_types(struct cmh_config *cfg)
+{
+	unsigned int i, j, k;
+
+	for (i = 0; i < CMH_NUM_CORE_TYPES; i++) {
+		struct cmh_core_type_cfg *ct = &cfg->core_types[i];
+		const char *name = core_type_names[i];
+
+		/* Zero instances is valid -- core absent from DT */
+		if (ct->num_instances == 0)
+			continue;
+
+		if (ct->num_instances > CMH_MAX_CORE_INSTANCES) {
+			dev_err(cmh_dev(), "%s: num_instances %u > max %u\n",
+				name, ct->num_instances,
+				CMH_MAX_CORE_INSTANCES);
+			return -EINVAL;
+		}
+
+		/* Validate MBX indices */
+		for (j = 0; j < ct->num_instances; j++) {
+			if (ct->mbx[j] >= 0 &&
+			    (u32)ct->mbx[j] >= cfg->mbx_count) {
+#ifdef CONFIG_CRYPTO_DEV_CMH_DEBUG
+				if (mbx_count_override > 0) {
+					dev_info(cmh_dev(),
+						 "%s: mbx[%u]=%d >= overridden mbx_count %u, auto-assigning\n",
+						 name, j, ct->mbx[j],
+						 cfg->mbx_count);
+					ct->mbx[j] = -1;
+					continue;
+				}
+#endif
+				dev_err(cmh_dev(), "%s: mbx[%u]=%d >= mbx_count %u\n",
+					name, j, ct->mbx[j],
+					cfg->mbx_count);
+				return -EINVAL;
+			}
+		}
+
+		/* No duplicate core IDs within this type */
+		for (j = 1; j < ct->num_instances; j++) {
+			for (k = 0; k < j; k++) {
+				if (ct->core_ids[j] == ct->core_ids[k]) {
+					dev_err(cmh_dev(),
+						"%s: duplicate core_id 0x%02x at [%u] and [%u]\n",
+						name, ct->core_ids[j],
+						k, j);
+					return -EINVAL;
+				}
+			}
+		}
+
+		/* No duplicate MBX within this type (if explicit) */
+		for (j = 1; j < ct->num_instances; j++) {
+			if (ct->mbx[j] < 0)
+				continue;
+			for (k = 0; k < j; k++) {
+				if (ct->mbx[k] == ct->mbx[j]) {
+					dev_err(cmh_dev(),
+						"%s: duplicate mbx %d at [%u] and [%u]\n",
+						name, ct->mbx[j], k, j);
+					return -EINVAL;
+				}
+			}
+		}
+
+		/* All core IDs must fit in VCQ 8-bit field */
+		for (j = 0; j < ct->num_instances; j++) {
+			if (ct->core_ids[j] > CORE_ID_MAX) {
+				dev_err(cmh_dev(),
+					"%s: core_ids[%u]=0x%02x > CORE_ID_MAX\n",
+					name, j, ct->core_ids[j]);
+				return -EINVAL;
+			}
+		}
+	}
+
+	/* Cross-type: no core ID used by more than one type */
+	for (i = 0; i < CMH_NUM_CORE_TYPES; i++) {
+		struct cmh_core_type_cfg *ct_i = &cfg->core_types[i];
+
+		for (j = i + 1; j < CMH_NUM_CORE_TYPES; j++) {
+			struct cmh_core_type_cfg *ct_j = &cfg->core_types[j];
+
+			for (k = 0; k < ct_i->num_instances; k++) {
+				unsigned int m;
+
+				for (m = 0; m < ct_j->num_instances; m++) {
+					if (ct_i->core_ids[k] !=
+					    ct_j->core_ids[m])
+						continue;
+					dev_err(cmh_dev(),
+						"core_id 0x%02x conflict: %s[%u] and %s[%u]\n",
+						ct_i->core_ids[k],
+						core_type_names[i], k,
+						core_type_names[j], m);
+					return -EINVAL;
+				}
+			}
+		}
+	}
+
+	return 0;
+}
+
+static int cmh_config_validate(struct cmh_config *cfg)
+{
+	unsigned int i, j;
+	unsigned long max_instance_end;
+
+	if (cfg->mbx_count == 0 || cfg->mbx_count > CMH_MAX_CONFIGURED_MBX) {
+		dev_err(cmh_dev(), "mbx_count %u out of range (1..%u)\n",
+			cfg->mbx_count, CMH_MAX_CONFIGURED_MBX);
+		return -EINVAL;
+	}
+
+	for (i = 0; i < cfg->mbx_count; i++) {
+		struct cmh_mbx_config *m = &cfg->mailboxes[i];
+
+		if (m->instance >= CMH_MAX_MBX_INSTANCES) {
+			dev_err(cmh_dev(), "mbx_instances[%u]=%u >= %u\n",
+				i, m->instance, CMH_MAX_MBX_INSTANCES);
+			return -EINVAL;
+		}
+
+		if (m->slots_log2 < CMH_MBX_SLOTS_LOG2_MIN ||
+		    m->slots_log2 > CMH_MBX_SLOTS_LOG2_MAX) {
+			dev_err(cmh_dev(), "mbx_slots[%u]=%u out of range (%u..%u)\n",
+				i, m->slots_log2,
+			       CMH_MBX_SLOTS_LOG2_MIN, CMH_MBX_SLOTS_LOG2_MAX);
+			return -EINVAL;
+		}
+
+		if (m->stride_log2 < CMH_MBX_STRIDE_LOG2_MIN ||
+		    m->stride_log2 > CMH_MBX_STRIDE_LOG2_MAX) {
+			dev_err(cmh_dev(), "mbx_strides[%u]=%u out of range (%u..%u)\n",
+				i, m->stride_log2,
+			       CMH_MBX_STRIDE_LOG2_MIN, CMH_MBX_STRIDE_LOG2_MAX);
+			return -EINVAL;
+		}
+
+		/* Check for duplicate instance indices */
+		for (j = 0; j < i; j++) {
+			if (cfg->mailboxes[j].instance == m->instance) {
+				dev_err(cmh_dev(), "duplicate instance %u at indices %u and %u\n",
+					m->instance, j, i);
+				return -EINVAL;
+			}
+		}
+	}
+
+	/* Ensure SIC region is large enough for all requested instances */
+	max_instance_end = 0;
+	for (i = 0; i < cfg->mbx_count; i++) {
+		unsigned long end = ((unsigned long)cfg->mailboxes[i].instance + 1)
+				    << CMH_MBX_INSTANCE_SHIFT;
+		if (end > max_instance_end)
+			max_instance_end = end;
+	}
+
+	if (max_instance_end > cfg->sic_size) {
+		dev_err(cmh_dev(), "sic_size 0x%zx too small for instance requiring 0x%lx\n",
+			cfg->sic_size, max_instance_end);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+/* -- Public Interface -------------------------------------------------- */
+
+/**
+ * cmh_config_init() - Initialize device configuration from platform/DT data
+ * @cfg: Configuration structure to populate
+ * @pdev: Platform device providing DT node and resources
+ *
+ * Parse the "cri,cmh" device tree node for MMIO base address, interrupt
+ * specifiers, and per-mailbox properties (instance indices, slot counts,
+ * strides).  When DT properties are absent, fall back to module parameter
+ * arrays.  Populate per-core-type instance configuration from module
+ * parameters, then validate the complete configuration.
+ *
+ * Return: 0 on success, negative errno on failure.
+ */
+int cmh_config_init(struct cmh_config *cfg, struct platform_device *pdev)
+{
+	struct device_node *np = pdev->dev.of_node;
+	struct resource *res;
+	unsigned int i;
+	int ret, irq, nr;
+
+	if (!np) {
+		dev_err(&pdev->dev, "device tree node required\n");
+		return -ENODEV;
+	}
+
+	cfg->of_node = np;
+
+	/* SIC base + size from DT "reg" property (mandatory) */
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		dev_err(cmh_dev(), "missing DT reg resource\n");
+		return -EINVAL;
+	}
+	cfg->sic_base = res->start;
+	cfg->sic_size = resource_size(res);
+
+	/*
+	 * IRQ resolution order:
+	 *   1. Platform-level IRQ from the first DT "interrupts" entry.
+	 *   2. If absent (cfg->irq == -1), cmh_rh_resolve_irqs() tries
+	 *      per-MBX of_irq_get() for per-mailbox interrupt routing.
+	 *   3. If no IRQs are available at all, the response handler
+	 *      falls back to watchdog-timer polling (200 ms default).
+	 */
+	irq = platform_get_irq_optional(pdev, 0);
+	cfg->irq = (irq >= 0) ? irq : -1;
+
+	cfg->sic_mapped = NULL;
+	cfg->fw_ready_timeout_ms = fw_ready_timeout_ms;
+
+	/* -- MBX configuration from DT --------------------------------- */
+
+	nr = of_property_count_u32_elems(np, "cri,mbx-instances");
+	if (nr <= 0) {
+		dev_err(cmh_dev(), "missing or empty cri,mbx-instances in DT\n");
+		return -EINVAL;
+	}
+	if ((unsigned int)nr > CMH_MAX_CONFIGURED_MBX) {
+		dev_err(cmh_dev(), "too many MBX instances in DT (%d > %u)\n",
+			nr, CMH_MAX_CONFIGURED_MBX);
+		return -EINVAL;
+	}
+	cfg->mbx_count = nr;
+
+#ifdef CONFIG_CRYPTO_DEV_CMH_DEBUG
+	if (mbx_count_override > 0) {
+		if (mbx_count_override > cfg->mbx_count) {
+			dev_err(cmh_dev(),
+				"mbx_count_override %u > DT count %u\n",
+				mbx_count_override, cfg->mbx_count);
+			return -EINVAL;
+		}
+		dev_info(cmh_dev(), "[debug] overriding mbx_count: %u -> %u\n",
+			 cfg->mbx_count, mbx_count_override);
+		cfg->mbx_count = mbx_count_override;
+	}
+#endif
+
+	for (i = 0; i < cfg->mbx_count; i++) {
+		struct cmh_mbx_config *m = &cfg->mailboxes[i];
+		u32 val;
+
+		ret = of_property_read_u32_index(np, "cri,mbx-instances",
+						 i, &val);
+		if (ret) {
+			dev_err(cmh_dev(), "missing cri,mbx-instances[%u] in DT\n",
+				i);
+			return ret;
+		}
+		m->instance = val;
+
+		ret = of_property_read_u32_index(np, "cri,mbx-slots-log2",
+						 i, &val);
+		if (ret) {
+			m->slots_log2 = CMH_DEFAULT_SLOTS_LOG2;
+			dev_info(cmh_dev(),
+				 "MBX[%u]: cri,mbx-slots-log2 absent, using default %u\n",
+				 i, CMH_DEFAULT_SLOTS_LOG2);
+		} else {
+			m->slots_log2 = val;
+		}
+
+		ret = of_property_read_u32_index(np, "cri,mbx-strides-log2",
+						 i, &val);
+		if (ret) {
+			m->stride_log2 = CMH_DEFAULT_STRIDE_LOG2;
+			dev_info(cmh_dev(),
+				 "MBX[%u]: cri,mbx-strides-log2 absent, using default %u\n",
+				 i, CMH_DEFAULT_STRIDE_LOG2);
+		} else {
+			m->stride_log2 = val;
+		}
+
+#ifdef CONFIG_CRYPTO_DEV_CMH_DEBUG
+		if (mbx_slots_override > 0) {
+			m->slots_log2 = mbx_slots_override;
+			if (i == 0)
+				dev_info(cmh_dev(),
+					 "[debug] overriding slots_log2 -> %u\n",
+					 mbx_slots_override);
+		}
+#endif
+
+		m->queue_size = (1UL << m->slots_log2) << m->stride_log2;
+		m->dma_handle = 0;
+		m->virt_addr = NULL;
+		m->reg_base = NULL;
+	}
+
+	/* -- Core-type enumeration from DT child nodes ----------------- */
+
+	ret = cmh_config_populate_cores(cfg, np);
+	if (ret)
+		return ret;
+
+	ret = cmh_config_validate(cfg);
+	if (ret)
+		return ret;
+
+	return cmh_config_validate_core_types(cfg);
+}
diff --git a/drivers/crypto/cmh/cmh_debugfs.c b/drivers/crypto/cmh/cmh_debugfs.c
new file mode 100644
index 000000000000..bd7b083b9ef1
--- /dev/null
+++ b/drivers/crypto/cmh/cmh_debugfs.c
@@ -0,0 +1,286 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2026 Cryptography Research, Inc. (CRI).
+ * CMH LKM -- debugfs Per-MBX Counters and Fault Injection
+ *
+ * Creates the /sys/kernel/debug/cmh/ tree with:
+ *   mbxN/vcqs_submitted   (ro) Total VCQs sent to MBX N
+ *   mbxN/vcqs_completed   (ro) Total completions received
+ *   mbxN/vcqs_errors      (ro) Total error completions
+ *   mbxN/queue_full_count (ro) Times select_mailbox() skipped this MBX
+ *   mbxN/max_queue_depth  (ro) High-water mark of in-flight transactions
+ *   mbxN/inject_abort     (wo) Write any value to inject MBX_COMMAND_ABORT
+ *   mbxN/force_drain      (wo) Write any value to force-drain all pending txns
+ *   tm/cmq_posts          (ro) Total cmh_tm_post_command() calls
+ *   tm/cmq_depth_max      (ro) High-water mark of CMQ length
+ *   tm/cmq_eagain_count   (ro) Times CMQ was full (-EAGAIN)
+ *   tm/backoff_count      (ro) Times TM backed off (all MBX queues full)
+ *   tm/async_timeout_count (ro) Async requests that timed out
+ *
+ * This file is only compiled when CONFIG_CRYPTO_DEV_CMH_DEBUG=y (see Kbuild).
+ * Requires CONFIG_DEBUG_FS=y in the kernel (standard for dev builds).
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/debugfs.h>
+#include <linux/slab.h>
+
+#include "cmh_debugfs.h"
+#include "cmh_config.h"
+#include "cmh_registers.h"
+#include "cmh_dma.h"
+#include "cmh_txn.h"
+#include "cmh_rh.h"
+#include "cmh_rng.h"
+
+/* -- Module State ---------------------------------------------------------- */
+
+static struct {
+	struct dentry		*root;		/* /sys/kernel/debug/cmh/ */
+	struct cmh_mbx_stats	*mbx;		/* array[mbx_count] */
+	struct cmh_tm_stats	 tm;
+	struct cmh_config	*cfg;		/* for inject_abort register access */
+	u32			 mbx_count;
+} dbgfs;
+
+/* -- debugfs file ops for atomic64_t --------------------------------------- */
+
+static int cmh_dbgfs_u64_get(void *data, u64 *val)
+{
+	*val = (u64)atomic64_read((atomic64_t *)data);
+	return 0;
+}
+
+DEFINE_DEBUGFS_ATTRIBUTE(cmh_dbgfs_u64_ro_fops,
+			 cmh_dbgfs_u64_get, NULL, "%llu\n");
+
+/* -- Per-MBX directory ----------------------------------------------------- */
+
+/*
+ * inject_abort -- write-only debugfs file for fault injection.
+ *
+ * Writing any value triggers MBX_COMMAND_ABORT on this mailbox.
+ * The eSW calls mbx_abort() -> mbx_cmd_error(mbx, -EPIPE), fires the
+ * error IRQ, and the LKM RH completes in-flight transactions with -EIO
+ * then issues MBX_COMMAND_RESTART to resume the mailbox.
+ *
+ * Private data points to the MBX index (cast to void *).
+ */
+static ssize_t inject_abort_write(struct file *file,
+				  const char __user *ubuf,
+				  size_t count, loff_t *ppos)
+{
+	u32 idx = (u32)(unsigned long)file->private_data;
+	void __iomem *base;
+
+	if (!dbgfs.cfg || idx >= dbgfs.cfg->mbx_count)
+		return -EINVAL;
+
+	base = dbgfs.cfg->mailboxes[idx].reg_base;
+	dev_warn(cmh_dev(), "debugfs: injecting ABORT on mbx[%u]\n", idx);
+	cmh_reg_write32(MBX_COMMAND_ABORT, base, R_MBX_COMMAND);
+
+	return count;
+}
+
+static const struct file_operations inject_abort_fops = {
+	.owner = THIS_MODULE,
+	.open = simple_open,
+	.write = inject_abort_write,
+	.llseek = noop_llseek,
+};
+
+/*
+ * force_drain -- write-only debugfs file for administrative recovery.
+ *
+ * Writing any value issues MBX_COMMAND_FLUSH, drains all pending
+ * transactions on this mailbox (completing each with -ECANCELED),
+ * and resets all recovery bookkeeping (abort_stall_ticks,
+ * restart_pending, restart_retries, flush_count, wedged).
+ *
+ * Use this to recover D-state processes when the eSW is dead and
+ * normal ABORT/RESTART escalation has not recovered the mailbox.
+ */
+static ssize_t force_drain_write(struct file *file,
+				 const char __user *ubuf,
+				 size_t count, loff_t *ppos)
+{
+	u32 idx = (u32)(unsigned long)file->private_data;
+
+	if (!dbgfs.cfg || idx >= dbgfs.cfg->mbx_count)
+		return -EINVAL;
+
+	cmh_rh_force_drain_mbx(idx);
+	return count;
+}
+
+static const struct file_operations force_drain_fops = {
+	.owner = THIS_MODULE,
+	.open = simple_open,
+	.write = force_drain_write,
+	.llseek = noop_llseek,
+};
+
+static void create_mbx_dir(u32 idx, struct dentry *parent)
+{
+	struct cmh_mbx_stats *s = &dbgfs.mbx[idx];
+	struct dentry *d;
+	char name[16];
+
+	snprintf(name, sizeof(name), "mbx%u", idx);
+	d = debugfs_create_dir(name, parent);
+
+	debugfs_create_file("vcqs_submitted",   0444, d,
+			    &s->vcqs_submitted,   &cmh_dbgfs_u64_ro_fops);
+	debugfs_create_file("vcqs_completed",   0444, d,
+			    &s->vcqs_completed,   &cmh_dbgfs_u64_ro_fops);
+	debugfs_create_file("vcqs_errors",      0444, d,
+			    &s->vcqs_errors,      &cmh_dbgfs_u64_ro_fops);
+	debugfs_create_file("queue_full_count", 0444, d,
+			    &s->queue_full_count, &cmh_dbgfs_u64_ro_fops);
+	debugfs_create_file("max_queue_depth",  0444, d,
+			    &s->max_queue_depth,  &cmh_dbgfs_u64_ro_fops);
+	debugfs_create_file("inject_abort",     0200, d,
+			    (void *)(uintptr_t)idx, &inject_abort_fops);
+	debugfs_create_file("force_drain",      0200, d,
+			    (void *)(uintptr_t)idx, &force_drain_fops);
+}
+
+/* -- TM directory ---------------------------------------------------------- */
+
+static void create_tm_dir(struct dentry *parent)
+{
+	struct cmh_tm_stats *s = &dbgfs.tm;
+	struct dentry *d;
+
+	d = debugfs_create_dir("tm", parent);
+
+	debugfs_create_file("cmq_posts",        0444, d,
+			    &s->cmq_posts,        &cmh_dbgfs_u64_ro_fops);
+	debugfs_create_file("cmq_depth_max",    0444, d,
+			    &s->cmq_depth_max,    &cmh_dbgfs_u64_ro_fops);
+	debugfs_create_file("cmq_eagain_count", 0444, d,
+			    &s->cmq_eagain_count, &cmh_dbgfs_u64_ro_fops);
+	debugfs_create_file("backoff_count",    0444, d,
+			    &s->backoff_count,    &cmh_dbgfs_u64_ro_fops);
+	debugfs_create_file("async_timeout_count", 0444, d,
+			    &s->async_timeout_count, &cmh_dbgfs_u64_ro_fops);
+}
+
+/* -- Config directory: timeout tuning ---------------------------------- */
+
+static void create_config_dir(struct dentry *parent)
+{
+	struct dentry *d;
+
+	d = debugfs_create_dir("config", parent);
+
+	/* TM timeouts */
+	debugfs_create_u32("async_timeout_ms",   0644, d,
+			   cmh_tm_timeout_async_ptr());
+	debugfs_create_u32("vcq_timeout_ms",     0644, d,
+			   cmh_tm_timeout_vcq_ptr());
+	debugfs_create_u32("slow_op_timeout_ms", 0644, d,
+			   cmh_tm_timeout_slow_op_ptr());
+	debugfs_create_u32("drain_timeout_ms",   0644, d,
+			   cmh_tm_timeout_drain_ptr());
+
+	/* RH watchdog */
+	debugfs_create_u32("watchdog_ms",        0644, d,
+			   cmh_rh_timeout_watchdog_ptr());
+
+	/* DRBG timeout */
+	debugfs_create_u32("drbg_timeout_ms",    0644, d,
+			   cmh_rng_timeout_drbg_ptr());
+}
+
+/* -- Public Interface ------------------------------------------------------ */
+
+/**
+ * cmh_debugfs_init() - Create debugfs directory hierarchy for CMH
+ * @cfg: Platform configuration containing mailbox count and register bases.
+ *
+ * Allocates per-mailbox statistics and creates the /sys/kernel/debug/cmh/
+ * tree with per-mailbox counters, fault-injection files, and transaction
+ * manager statistics.  debugfs is optional; failure to create entries does
+ * not prevent module initialisation.
+ *
+ * Return: 0 on success (always returns 0 -- debugfs is best-effort).
+ */
+int cmh_debugfs_init(struct cmh_config *cfg)
+{
+	u32 mbx_count = cfg->mbx_count;
+	u32 i;
+
+	dbgfs.root = debugfs_create_dir("cmh", NULL);
+	if (IS_ERR_OR_NULL(dbgfs.root)) {
+		if (!IS_ERR(dbgfs.root))
+			dev_warn(cmh_dev(), "debugfs: creation returned NULL -- counters disabled\n");
+		else
+			dev_warn(cmh_dev(), "debugfs: creation failed (rc=%ld) -- counters disabled\n",
+				 PTR_ERR(dbgfs.root));
+		dbgfs.root = NULL;
+		return 0;  /* debugfs is optional -- never fail module init */
+	}
+
+	dbgfs.mbx_count = mbx_count;
+	dbgfs.cfg = cfg;
+	dbgfs.mbx = kcalloc(mbx_count, sizeof(*dbgfs.mbx), GFP_KERNEL);
+	if (!dbgfs.mbx) {
+		debugfs_remove_recursive(dbgfs.root);
+		dbgfs.root = NULL;
+		return 0;
+	}
+
+	for (i = 0; i < mbx_count; i++)
+		create_mbx_dir(i, dbgfs.root);
+
+	create_tm_dir(dbgfs.root);
+
+	create_config_dir(dbgfs.root);
+
+	dev_dbg(cmh_dev(), "debugfs: initialized (%u mailboxes)\n", mbx_count);
+	return 0;
+}
+
+/**
+ * cmh_debugfs_cleanup() - Remove all CMH debugfs entries
+ *
+ * Tears down the /sys/kernel/debug/cmh/ tree and frees per-mailbox
+ * statistics memory.  Safe to call even if cmh_debugfs_init() was never
+ * called or failed.
+ */
+void cmh_debugfs_cleanup(void)
+{
+	debugfs_remove_recursive(dbgfs.root);
+	dbgfs.root = NULL;
+	kfree(dbgfs.mbx);
+	dbgfs.mbx = NULL;
+	dev_dbg(cmh_dev(), "debugfs: cleaned up\n");
+}
+
+/**
+ * cmh_debugfs_mbx_stats() - Return per-mailbox statistics pointer
+ * @mbx_idx: Zero-based mailbox index.
+ *
+ * Return: Pointer to the statistics structure for @mbx_idx, or NULL if
+ *         debugfs is disabled or @mbx_idx is out of range.
+ */
+struct cmh_mbx_stats *cmh_debugfs_mbx_stats(u32 mbx_idx)
+{
+	if (!dbgfs.mbx || mbx_idx >= dbgfs.mbx_count)
+		return NULL;
+	return &dbgfs.mbx[mbx_idx];
+}
+
+/**
+ * cmh_debugfs_tm_stats() - Return transaction manager statistics pointer
+ *
+ * Return: Pointer to the singleton TM statistics structure.  The pointer
+ *         is always valid (points to static storage).
+ */
+struct cmh_tm_stats *cmh_debugfs_tm_stats(void)
+{
+	return &dbgfs.tm;
+}
diff --git a/drivers/crypto/cmh/cmh_dma.c b/drivers/crypto/cmh/cmh_dma.c
new file mode 100644
index 000000000000..36ea277420cf
--- /dev/null
+++ b/drivers/crypto/cmh/cmh_dma.c
@@ -0,0 +1,373 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2026 Cryptography Research, Inc. (CRI).
+ * CMH LKM -- DMA Operations
+ *
+ * Implements the cmh_dma.h interface using the kernel DMA API
+ * (dma_map_single, dma_alloc_coherent, etc.).
+ *
+ * Scatterlist linearization rationale
+ * ------------------------------------
+ * The eSW firmware supports SCATTERGATHER commands for all core
+ * types (AES_CMD_SCATTERGATHER, SM4_CMD_SCATTERGATHER,
+ * CCP_CMD_SCATTERGATHER, HC_CMD_GATHER), using a proprietary
+ * linked-list-item (LLI) descriptor chain format.  The hash driver
+ * already uses this via cmh_dma_build_sg() + HC_CMD_GATHER.
+ *
+ * For symmetric cipher and AEAD commands, the LKM currently
+ * linearizes scatterlist input into contiguous bounce buffers via
+ * scatterwalk_map_and_copy() rather than building LLI chains from
+ * kernel scatterlists.  This is a deliberate first-submission
+ * simplification with a concrete technical justification:
+ *
+ *   - The hash SG path is unidirectional (DMA_TO_DEVICE gather only).
+ *     Skcipher and AEAD require bidirectional handling: separate src
+ *     and dst scatterlists (which may alias for in-place operations),
+ *     plus AAD and authentication tag regions with distinct DMA
+ *     directions and alignment constraints.
+ *   - The CMH LLI format requires 64-byte aligned descriptor chain
+ *     pointers (the .lli field) with 32-bit length fields.  This
+ *     alignment is automatically satisfied by dma_alloc_coherent()
+ *     for the descriptor array; data buffer addresses have no
+ *     hardware alignment requirement.  Kernel SG entries have no
+ *     alignment guarantee for data, so direct SG-to-LLI translation
+ *     requires per-segment validation, potential splitting at
+ *     descriptor boundaries, and separate chains for src/dst/AAD --
+ *     substantially more complex than the unidirectional hash
+ *     gather case.
+ *   - Each skcipher/AEAD driver caps linearization at
+ *     CMH_AES_MAX_CRYPTLEN / CMH_SM4_MAX_CRYPTLEN (32 MiB).
+ *     Requests exceeding this cap are rejected with -EINVAL.
+ *     In practice, crypto API callers (dm-crypt, IPsec, kernel TLS)
+ *     send page-sized or smaller buffers, so the bounce allocation
+ *     is typically <= PAGE_SIZE and succeeds even under GFP_ATOMIC.
+ *
+ * A shared SG-to-LLI adapter handling bidirectional mappings,
+ * alignment splitting, and in-place src==dst detection for the
+ * skcipher/AEAD/MAC paths is planned as a follow-up series once the
+ * core driver is accepted.
+ *
+ * This linearization pattern is consistent with other upstream HW
+ * crypto drivers that use bounce buffers in their initial
+ * submissions (e.g. ccree, sa2ul, omap-aes).
+ */
+
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/dma-mapping.h>
+#include <linux/platform_device.h>
+#include <linux/overflow.h>
+#include <linux/string.h>
+
+#include "cmh_dma.h"
+
+/* Module-global device pointer, set in cmh_dma_init() */
+static struct device *cmh_device;
+
+/**
+ * cmh_dma_init() - Initialize the standard DMA backend
+ * @pdev: Platform device providing the struct device for DMA ops
+ *
+ * Stores the device pointer for use by all DMA wrapper functions.
+ *
+ * Return: 0 (always succeeds for the standard backend).
+ */
+int cmh_dma_init(struct platform_device *pdev)
+{
+	cmh_device = &pdev->dev;
+	return 0;
+}
+
+/**
+ * cmh_dma_cleanup() - Tear down the standard DMA backend
+ *
+ * Clears the stored device pointer.
+ */
+void cmh_dma_cleanup(void)
+{
+	cmh_device = NULL;
+}
+
+/**
+ * cmh_dev() - Return the platform device pointer
+ *
+ * Return: struct device pointer, or NULL outside probe/remove lifecycle.
+ */
+struct device *cmh_dev(void)
+{
+	return cmh_device;
+}
+
+/* -- Streaming DMA -------------------------------------------------------- */
+
+/**
+ * cmh_dma_map_single() - Map a kernel buffer for streaming DMA
+ * @buf:  Kernel virtual address
+ * @size: Buffer length in bytes
+ * @dir:  DMA direction
+ *
+ * Return: DMA address, or a DMA_MAPPING_ERROR value on failure.
+ */
+dma_addr_t cmh_dma_map_single(void *buf, size_t size,
+			      enum dma_data_direction dir)
+{
+	return dma_map_single(cmh_device, buf, size, dir);
+}
+
+/**
+ * cmh_dma_unmap_single() - Unmap a streaming DMA buffer
+ * @addr: DMA address returned by cmh_dma_map_single()
+ * @size: Buffer length in bytes
+ * @dir:  DMA direction (must match the map call)
+ */
+void cmh_dma_unmap_single(dma_addr_t addr, size_t size,
+			  enum dma_data_direction dir)
+{
+	dma_unmap_single(cmh_device, addr, size, dir);
+}
+
+/**
+ * cmh_dma_sync_for_cpu() - Sync a DMA buffer for CPU access
+ * @addr: DMA address of the mapped buffer
+ * @size: Region length in bytes
+ * @dir:  DMA direction
+ */
+void cmh_dma_sync_for_cpu(dma_addr_t addr, size_t size,
+			  enum dma_data_direction dir)
+{
+	dma_sync_single_for_cpu(cmh_device, addr, size, dir);
+}
+
+/**
+ * cmh_dma_sync_for_device() - Sync a DMA buffer for device access
+ * @addr: DMA address of the mapped buffer
+ * @size: Region length in bytes
+ * @dir:  DMA direction
+ */
+void cmh_dma_sync_for_device(dma_addr_t addr, size_t size,
+			     enum dma_data_direction dir)
+{
+	dma_sync_single_for_device(cmh_device, addr, size, dir);
+}
+
+/**
+ * cmh_dma_map_error() - Check whether a DMA mapping failed
+ * @addr: DMA address to check
+ *
+ * Return: Non-zero if @addr indicates a mapping error.
+ */
+int cmh_dma_map_error(dma_addr_t addr)
+{
+	return dma_mapping_error(cmh_device, addr);
+}
+
+/* -- Coherent DMA --------------------------------------------------------- */
+
+/**
+ * cmh_dma_alloc() - Allocate coherent DMA memory
+ * @size:   Allocation size in bytes
+ * @handle: Output DMA address
+ * @gfp:    GFP allocation flags
+ *
+ * Return: Kernel virtual address, or NULL on failure.
+ */
+void *cmh_dma_alloc(size_t size, dma_addr_t *handle, gfp_t gfp)
+{
+	return dma_alloc_coherent(cmh_device, size, handle, gfp);
+}
+
+/**
+ * cmh_dma_free() - Free coherent DMA memory
+ * @size:   Allocation size (must match cmh_dma_alloc)
+ * @virt:   Kernel virtual address
+ * @handle: DMA address
+ */
+void cmh_dma_free(size_t size, void *virt, dma_addr_t handle)
+{
+	dma_free_coherent(cmh_device, size, virt, handle);
+}
+
+/* -- Buffer write helpers ------------------------------------------------- */
+
+/**
+ * cmh_dma_write() - Copy data into a DMA buffer
+ * @dst: Destination (from cmh_dma_alloc)
+ * @src: Source kernel buffer
+ * @len: Byte count
+ */
+void cmh_dma_write(void *dst, const void *src, size_t len)
+{
+	memcpy(dst, src, len);
+}
+
+/**
+ * cmh_dma_fence() - No-op on standard DMA API platforms (coherent)
+ * @ptr: Unused -- present for interface compatibility
+ */
+void cmh_dma_fence(void *ptr)
+{
+	/* Standard DMA API: coherent memory, no cross-slave fence needed */
+}
+
+/**
+ * cmh_dma_zero() - Zero a DMA buffer
+ * @dst: Destination (from cmh_dma_alloc)
+ * @len: Byte count
+ */
+void cmh_dma_zero(void *dst, size_t len)
+{
+	memset(dst, 0, len);
+}
+
+/**
+ * cmh_dma_build_sg() - Build a scatter-gather DMA mapping
+ * @bufs: Array of buffer descriptors to map
+ * @count: Number of entries in @bufs
+ * @gfp: GFP flags for memory allocation
+ *
+ * Allocates a streaming-DMA descriptor array and maps each buffer in @bufs
+ * for DMA-to-device transfer, filling CMH eSW-format scatter-gather
+ * descriptors with linked-list pointers.
+ *
+ * The descriptor array uses streaming DMA (kmalloc + dma_map_single) rather
+ * than dma_alloc_coherent so that cmh_dma_free_sg() -- which calls
+ * dma_unmap_single + kfree -- is safe from any context including BH-disabled
+ * completion callbacks.
+ *
+ * Return: Pointer to the allocated cmh_sg_map on success, NULL on failure.
+ */
+struct cmh_sg_map *cmh_dma_build_sg(const struct cmh_dma_buf *bufs, u32 count,
+				    gfp_t gfp)
+{
+	struct cmh_sg_map *sgm;
+	u32 i;
+
+	if (!count)
+		return NULL;
+
+	sgm = kzalloc(struct_size(sgm, bufs, count), gfp);
+	if (!sgm)
+		return NULL;
+
+	sgm->count = count;
+	sgm->items_size = array_size(count, sizeof(*sgm->items));
+	if (sgm->items_size == SIZE_MAX)
+		goto err_free_sgm;
+
+	/*
+	 * Allocate descriptor array with kmalloc and map for streaming DMA.
+	 * We map first to obtain items_dma (needed for .lli pointers),
+	 * then sync-for-cpu, fill descriptors, and sync-for-device.
+	 */
+	sgm->items = kzalloc(sgm->items_size, gfp);
+	if (!sgm->items)
+		goto err_free_sgm;
+
+	sgm->items_dma = cmh_dma_map_single(sgm->items, sgm->items_size,
+					    DMA_TO_DEVICE);
+	if (cmh_dma_map_error(sgm->items_dma))
+		goto err_free_items;
+
+	/* Map each source buffer for device read */
+	for (i = 0; i < count; i++) {
+		dma_addr_t dma;
+
+		if (!bufs[i].len)
+			goto err_unmap;
+		sgm->bufs[i].len = bufs[i].len;
+		dma = cmh_dma_map_single(bufs[i].data, bufs[i].len,
+					 DMA_TO_DEVICE);
+		if (cmh_dma_map_error(dma))
+			goto err_unmap;
+		sgm->bufs[i].dma = dma;
+	}
+
+	/*
+	 * Reclaim CPU ownership of the descriptor buffer.  After
+	 * dma_map_single the device owns the mapping; we must call
+	 * sync_for_cpu before writing regardless of direction.  The
+	 * direction matches the original mapping (DMA_TO_DEVICE) --
+	 * this tells the DMA layer which cache operations apply:
+	 * invalidate so the CPU sees coherent data before we fill
+	 * the SG descriptors and later sync_for_device.
+	 */
+	cmh_dma_sync_for_cpu(sgm->items_dma, sgm->items_size,
+			     DMA_TO_DEVICE);
+
+	/* Fill CMH eSW SG descriptors */
+	for (i = 0; i < count; i++) {
+		u64 lli_val;
+
+		if (i + 1 < count)
+			lli_val = (u64)(sgm->items_dma +
+				(i + 1) * sizeof(*sgm->items));
+		else
+			lli_val = 0;
+
+		sgm->items[i].lli = lli_val;
+		sgm->items[i].src = (u64)sgm->bufs[i].dma;
+		sgm->items[i].dst = 0;
+		sgm->items[i].len = (u64)bufs[i].len;
+	}
+
+	/* Flush descriptor writes to device */
+	cmh_dma_sync_for_device(sgm->items_dma, sgm->items_size,
+				DMA_TO_DEVICE);
+
+	return sgm;
+
+err_unmap:
+	while (i--)
+		cmh_dma_unmap_single(sgm->bufs[i].dma,
+				     sgm->bufs[i].len, DMA_TO_DEVICE);
+	cmh_dma_unmap_single(sgm->items_dma, sgm->items_size,
+			     DMA_TO_DEVICE);
+err_free_items:
+	kfree(sgm->items);
+err_free_sgm:
+	kfree(sgm);
+	return NULL;
+}
+
+/**
+ * cmh_dma_free_sg() - Unmap and free a scatter-gather mapping
+ * @sgm: Scatter-gather mapping created by cmh_dma_build_sg(), or NULL
+ *
+ * Unmaps all DMA-mapped buffers, unmaps and frees the descriptor array,
+ * and releases the cmh_sg_map structure.  Safe to call from any context
+ * (including BH-disabled completion callbacks) because it uses only
+ * dma_unmap_single + kfree -- no vunmap/dma_free_coherent.
+ */
+void cmh_dma_free_sg(struct cmh_sg_map *sgm)
+{
+	u32 i;
+
+	if (!sgm)
+		return;
+
+	for (i = 0; i < sgm->count; i++)
+		cmh_dma_unmap_single(sgm->bufs[i].dma,
+				     sgm->bufs[i].len, DMA_TO_DEVICE);
+
+	cmh_dma_unmap_single(sgm->items_dma, sgm->items_size,
+			     DMA_TO_DEVICE);
+	kfree(sgm->items);
+	kfree(sgm);
+}
+
+/**
+ * cmh_dma_orphan_free() - Orphan cleanup callback for abandoned DMA buffers
+ * @data: Pointer to a struct cmh_dma_orphan describing the orphaned mapping
+ *
+ * Called by the transaction manager when a synchronous operation times out
+ * and the caller has already returned.  Unmaps the DMA buffer and frees
+ * the backing memory and the orphan descriptor itself.
+ */
+void cmh_dma_orphan_free(void *data)
+{
+	struct cmh_dma_orphan *o = data;
+
+	cmh_dma_unmap_single(o->addr, o->len, o->dir);
+	kfree_sensitive(o->buf);
+	kfree(o);
+}
diff --git a/drivers/crypto/cmh/cmh_main.c b/drivers/crypto/cmh/cmh_main.c
new file mode 100644
index 000000000000..de065a425a2c
--- /dev/null
+++ b/drivers/crypto/cmh/cmh_main.c
@@ -0,0 +1,371 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2026 Cryptography Research, Inc. (CRI).
+ * CMH LKM -- Platform Driver Entry and Exit
+ *
+ * Responsibilities:
+ *   - Match "cri,cmh" DT node via platform_driver
+ *   - Parse device-tree properties via cmh_config_init()
+ *   - ioremap the SIC region
+ *   - Verify CMH boot status (sanity check)
+ *   - Compute per-instance register bases
+ *   - Initialize MBX queues (MQI)
+ *   - Start Transaction Manager kthread
+ *   - Register Response Handler IRQ
+ *   - Register Kernel Crypto API hash algorithms
+ *   - Clean up in reverse order on exit or error
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/io.h>
+#include <linux/dma-mapping.h>
+#include <linux/platform_device.h>
+#include <linux/of.h>
+
+#include "cmh.h"
+#include "cmh_dma.h"
+#include "cmh_mqi.h"
+#include "cmh_txn.h"
+#include "cmh_rh.h"
+#include "cmh_registers.h"
+#include "cmh_debugfs.h"
+#include "cmh_sysfs.h"
+
+#include <linux/iopoll.h>
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Alex Ousherovitch <aousherovitch@rambus.com>");
+MODULE_AUTHOR("Saravanakrishnan Krishnamoorthy <skrishnamoorthy@rambus.com>");
+MODULE_AUTHOR("Joel Wittenauer <Joel.Wittenauer@cryptography.com>");
+MODULE_DESCRIPTION("CRI CryptoManager Hub (CMH) hardware crypto accelerator");
+MODULE_ALIAS("platform:cmh");
+MODULE_IMPORT_NS("CRYPTO_INTERNAL");
+
+#ifdef CONFIG_CRYPTO_DEV_CMH_DEBUG
+static bool skip_fw_check;
+module_param(skip_fw_check, bool, 0444);
+MODULE_PARM_DESC(skip_fw_check,
+		 "[debug] Skip eSW boot status check at probe (default: false)");
+#else
+#define skip_fw_check false
+#endif
+
+/* Global device state (single-instance module) */
+
+static struct cmh_device *g_cmh_dev;
+
+/* SIC Sanity Check */
+
+static int cmh_check_sic(struct cmh_config *cfg)
+{
+	const u32 ready = SIC_SW_BOOT_STATUS_MISSION |
+			  SIC_SW_BOOT_STATUS_MISSION2;
+	u32 boot_status;
+	u32 hw_version;
+	u32 sw_boot;
+	int ret;
+
+	boot_status = cmh_reg_read32(cfg->sic_mapped, R_SIC_BOOT_STATUS);
+	hw_version  = cmh_reg_read32(cfg->sic_mapped, R_SIC_HW_VERSION0);
+
+	dev_info(cmh_dev(), "SIC boot_status=0x%08x hw_version=0x%08x\n",
+		 boot_status, hw_version);
+
+	if ((boot_status & SIC_BOOT_STATUS_MASK) != SIC_BOOT_STATUS_PASS) {
+		dev_err(cmh_dev(), "SIC boot status check failed (0x%02x != 0x%02x)\n",
+			boot_status & SIC_BOOT_STATUS_MASK, SIC_BOOT_STATUS_PASS);
+		return -EIO;
+	}
+
+	/*
+	 * Wait for eSW readiness: MISSION signals the primary VCQ engine,
+	 * MISSION2 the sidecar engine (set asynchronously).  The driver
+	 * uses both, so require both bits.
+	 */
+	ret = read_poll_timeout(ioread32, sw_boot,
+				(sw_boot & ready) == ready,
+				1000,
+				(unsigned long)cfg->fw_ready_timeout_ms * 1000UL,
+				false,
+				cfg->sic_mapped + R_SIC_SW_BOOT_STATUS);
+	if (ret) {
+		sw_boot = cmh_reg_read32(cfg->sic_mapped, R_SIC_SW_BOOT_STATUS);
+		dev_err(cmh_dev(), "CMH eSW not ready (sw_boot_status=0x%08x, timeout=%ums)\n",
+			sw_boot, cfg->fw_ready_timeout_ms);
+		return -ETIMEDOUT;
+	}
+
+	dev_info(cmh_dev(), "CMH eSW fully operational (sw_boot_status=0x%08x)\n",
+		 sw_boot);
+
+	return 0;
+}
+
+/* Module Init -- platform driver probe */
+
+static int cmh_probe(struct platform_device *pdev)
+{
+	struct cmh_device *dev;
+	struct cmh_config *cfg;
+	unsigned int i;
+	int ret;
+
+	/* Single-instance guard: reject if already probed */
+	if (g_cmh_dev)
+		return -EBUSY;
+
+	dev_info(&pdev->dev, "loading v%s\n", CMH_VERSION);
+
+	dev = devm_kzalloc(&pdev->dev, sizeof(*dev), GFP_KERNEL);
+	if (!dev)
+		return -ENOMEM;
+
+	dev->dev = &pdev->dev;
+	cfg = &dev->config;
+
+	/* Declare DMA addressing capability */
+	ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
+	if (ret) {
+		dev_err(&pdev->dev, "dma_set_mask_and_coherent failed (rc=%d)\n",
+			ret);
+		goto err_free_dev;
+	}
+
+	/* Initialize DMA backend (standard API or FPGA pool) */
+	ret = cmh_dma_init(pdev);
+	if (ret) {
+		dev_err(&pdev->dev, "DMA init failed (rc=%d)\n", ret);
+		goto err_free_dev;
+	}
+
+	/* Step 1: Parse and validate configuration (DT + module params) */
+	ret = cmh_config_init(cfg, pdev);
+	if (ret)
+		goto err_dma_init;
+
+	dev_info(cmh_dev(), "sic_base=0x%llx size=0x%zx mbx_count=%u irq=%d\n",
+		 (unsigned long long)cfg->sic_base, cfg->sic_size,
+		 cfg->mbx_count, cfg->irq);
+
+	/* Step 2: ioremap the SIC region */
+	cfg->sic_mapped = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(cfg->sic_mapped)) {
+		ret = PTR_ERR(cfg->sic_mapped);
+		cfg->sic_mapped = NULL;
+		dev_err(cmh_dev(), "ioremap failed for SIC region (rc=%d)\n",
+			ret);
+		goto err_dma_init;
+	}
+
+	/* Step 3: Verify CMH is alive */
+	if (skip_fw_check) {
+		dev_info(cmh_dev(), "skipping eSW boot check (skip_fw_check=1)\n");
+	} else {
+		ret = cmh_check_sic(cfg);
+		if (ret)
+			goto err_dma_init;
+	}
+
+	/* Step 4: Compute per-instance register bases */
+	for (i = 0; i < cfg->mbx_count; i++) {
+		struct cmh_mbx_config *m = &cfg->mailboxes[i];
+
+		m->reg_base = cmh_mbx_instance_base(cfg->sic_mapped,
+						    m->instance);
+
+		dev_dbg(cmh_dev(), "mbx[%u] instance=%u reg_base=%p\n",
+			i, m->instance, m->reg_base);
+	}
+
+	(void)cmh_debugfs_init(cfg);
+
+	/* Initialise mailbox queue interface */
+	ret = cmh_mqi_init(cfg);
+	if (ret)
+		goto err_mqi_init;
+
+	/* Initialise transaction manager */
+	ret = cmh_tm_init(cfg);
+	if (ret)
+		goto err_tm_init;
+
+	/* Initialise response handler */
+	ret = cmh_rh_init(cfg);
+	if (ret)
+		goto err_rh_init;
+
+	g_cmh_dev = dev;
+	platform_set_drvdata(pdev, dev);
+
+	dev_info(cmh_dev(), "initialized successfully\n");
+	return 0;
+
+err_rh_init:
+	cmh_tm_cleanup();
+err_tm_init:
+	cmh_mqi_cleanup(cfg);
+err_mqi_init:
+	cmh_debugfs_cleanup();
+err_dma_init:
+	cmh_dma_cleanup();
+err_free_dev:
+	return ret;
+}
+
+/* Module Exit -- platform driver remove */
+
+static void cmh_remove(struct platform_device *pdev)
+{
+	struct cmh_device *dev = platform_get_drvdata(pdev);
+	struct cmh_config *cfg;
+
+	if (!dev)
+		return;
+
+	cfg = &dev->config;
+
+	cmh_rh_cleanup(cfg);
+	cmh_tm_cleanup();
+	cmh_mqi_cleanup(cfg);
+	cmh_debugfs_cleanup();
+	cmh_dma_cleanup();
+
+	dev_info(&pdev->dev, "unloaded successfully\n");
+
+	g_cmh_dev = NULL;
+}
+
+static const struct of_device_id cmh_of_match[] = {
+	{ .compatible = "cri,cmh" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, cmh_of_match);
+
+/*
+ * PM suspend/resume.
+ *
+ * Suspend: drain the TM first (while the RH is still active and can
+ * deliver completions for in-flight transactions), then quiesce the
+ * RH (cancel watchdog, mask HW interrupts).  This ordering ensures
+ * the drain_timeout_ms wait in cmh_tm_quiesce() can actually succeed
+ * -- if we suspended RH first, no completions would be delivered and
+ * the drain would always hit the force-cancel path.
+ *
+ * IRQ handlers remain registered (standard PM pattern: the kernel
+ * disables the IRQ lines during suspend, no need to free/re-request).
+ *
+ * Resume: re-check the SIC/SW boot status, re-synchronise the RH
+ * with hardware (head positions, interrupt masks, watchdog), then
+ * restart the TM kthread.
+ */
+
+static int cmh_suspend(struct device *dev)
+{
+	struct cmh_device *cmh = dev_get_drvdata(dev);
+
+	if (!cmh)
+		return 0;
+
+	dev_info(dev, "suspending\n");
+	cmh_tm_quiesce();
+	cmh_rh_suspend(&cmh->config);
+	return 0;
+}
+
+static int cmh_resume(struct device *dev)
+{
+	struct cmh_device *cmh = dev_get_drvdata(dev);
+	int ret;
+
+	if (!cmh)
+		return 0;
+
+	ret = cmh_check_sic(&cmh->config);
+	if (ret) {
+		dev_err(dev, "resume: CMH eSW health check failed (%d)\n",
+			ret);
+		return ret;
+	}
+
+	/*
+	 * cmh_rh_resume() is void: it only re-syncs MMIO head pointers,
+	 * clears stale interrupt status bits (W1C), re-enables interrupt
+	 * masks, and re-arms the watchdog timer -- none of which can fail
+	 * after the SIC health check above has confirmed HW accessibility.
+	 */
+	cmh_rh_resume(&cmh->config);
+
+	ret = cmh_tm_resume();
+	if (ret) {
+		dev_err(dev, "resume: TM restart failed (%d)\n", ret);
+		return ret;
+	}
+	dev_info(dev, "resumed successfully\n");
+	return 0;
+}
+
+static DEFINE_SIMPLE_DEV_PM_OPS(cmh_pm_ops,
+				cmh_suspend,
+				cmh_resume);
+
+/*
+ * Runtime PM is intentionally not implemented.  The CMH hardware does
+ * not expose HLOS-accessible clock gates or power domains -- the eSW
+ * firmware manages HW power state independently.  There is no mechanism
+ * for the kernel to idle, gate clocks, or power down the accelerator
+ * block from HLOS.  If a future platform variant exposes power control
+ * to HLOS (e.g. via a SCMI power domain), runtime PM support can be
+ * added at that time using SET_RUNTIME_PM_OPS and pm_runtime_get/put
+ * around VCQ submission paths.
+ *
+ * System sleep (suspend/resume) is supported via DEFINE_SIMPLE_DEV_PM_OPS
+ * above: suspend quiesces the TM and masks IRQs; resume re-verifies
+ * eSW health (SIC status) and restarts the TM thread.
+ */
+
+static struct platform_driver cmh_driver = {
+	.probe      = cmh_probe,
+	.remove     = cmh_remove,
+	.driver = {
+		.name           = CMH_DRV_NAME,
+		.of_match_table = cmh_of_match,
+		.dev_groups     = cmh_sysfs_groups,
+		.pm             = pm_sleep_ptr(&cmh_pm_ops),
+	},
+};
+
+static int __init cmh_init(void)
+{
+	int ret;
+
+	ret = platform_driver_register(&cmh_driver);
+	if (ret)
+		return ret;
+
+	/*
+	 * platform_driver_register() does not propagate probe() errors.
+	 * If a DT node matched but probe() failed (e.g. bad module params),
+	 * g_cmh_dev will not have been set.  Detect this and unregister.
+	 *
+	 * This is intentional for a non-discoverable accelerator with no
+	 * hotplug or deferred-probe scenarios -- the device is either
+	 * present at boot or not.  Leaving the driver registered after a
+	 * probe failure would silently produce a non-functional module.
+	 */
+	if (!g_cmh_dev) {
+		platform_driver_unregister(&cmh_driver);
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
+static void __exit cmh_exit(void)
+{
+	platform_driver_unregister(&cmh_driver);
+}
+
+module_init(cmh_init);
+module_exit(cmh_exit);
diff --git a/drivers/crypto/cmh/cmh_mqi.c b/drivers/crypto/cmh/cmh_mqi.c
new file mode 100644
index 000000000000..9a135be58562
--- /dev/null
+++ b/drivers/crypto/cmh/cmh_mqi.c
@@ -0,0 +1,355 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2026 Cryptography Research, Inc. (CRI).
+ * CMH LKM -- Mailbox Queue Initializer
+ *
+ * Responsibilities:
+ *   - Allocate queue buffers for each configured mailbox
+ *   - Execute the MBX lock/setup/enable register sequence
+ *   - Readback-verify all critical register writes
+ *   - Hold lock for MBX lifetime (CMH eSW requires it for host access)
+ *   - Clean up (flush + unlock + free) on exit or error
+ *
+ * Register sequence per instance (per CMH MBX hardware specification):
+ *   1. Read R_MBX_LOCK -> non-zero = ownership token acquired
+ *   2. W1C stale R_MBX_INTERRUPT bits (avoids spurious error cascade)
+ *   3. Set R_MBX_INTERRUPT_MASK = MBX_IRQ_MASK
+ *   4. Write QUEUE_LO/HI, SLOTS, STRIDE (queue address + geometry)
+ *   5. Sync TAIL = HEAD (CMH eSW owns HEAD; avoids stale-queue parse)
+ *   6. Readback verify QUEUE_LO/HI/SLOTS/STRIDE
+ *   7. Write HOST_INFO (signals CMH eSW "MBX configured")
+ *   8. Write COMMAND = MBX_COMMAND_RUN
+ *   9. Lock stays held -- released only in teardown
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/delay.h>
+#include <linux/jiffies.h>
+#include <linux/io.h>
+#include <linux/iopoll.h>
+
+#include "cmh_mqi.h"
+#include "cmh_dma.h"
+#include "cmh_registers.h"
+#include "cmh_config.h"
+
+/* Flush polling: eSW clears R_MBX_COMMAND to 0 when flush completes */
+#define MBX_FLUSH_POLL_US	50
+#define MBX_FLUSH_TIMEOUT_US	1000000	/* 1 second */
+
+/* MBX Lock / Unlock */
+
+/*
+ * Attempt to acquire the MBX hardware lock.
+ * Returns the lock token (non-zero) on success, 0 on timeout.
+ */
+static u32 cmh_mbx_lock(void __iomem *reg_base, u32 instance)
+{
+	unsigned long deadline = jiffies + msecs_to_jiffies(MBX_LOCK_TIMEOUT_MS);
+	u32 lock;
+
+	while (time_before(jiffies, deadline)) {
+		lock = cmh_reg_read32(reg_base, R_MBX_LOCK);
+		if (lock) {
+			dev_dbg(cmh_dev(), "mbx %u lock acquired (token=0x%08x)\n",
+				instance, lock);
+			return lock;
+		}
+		/* HW lock may be held by CMH eSW -- back off before retry */
+		usleep_range(MBX_LOCK_POLL_MIN_US, MBX_LOCK_POLL_MAX_US);
+	}
+
+	return 0;
+}
+
+/* Release the MBX lock: clear interrupt mask, write token back */
+static void cmh_mbx_unlock(void __iomem *reg_base, u32 lock_val)
+{
+	cmh_reg_write32(0, reg_base, R_MBX_INTERRUPT_MASK);
+	cmh_reg_write32(lock_val, reg_base, R_MBX_LOCK);
+}
+
+/* Register Readback Verification */
+
+static int cmh_verify_reg(void __iomem *base, u32 offset, u32 expected,
+			  const char *name, u32 instance)
+{
+	u32 actual = cmh_reg_read32(base, offset);
+
+	if (actual != expected) {
+		dev_err(cmh_dev(), "mbx %u %s readback mismatch: 0x%08x != 0x%08x\n",
+			instance, name, actual, expected);
+		return -EIO;
+	}
+	return 0;
+}
+
+/* Clear any stale interrupt bits left from a prior module lifecycle. */
+static void cmh_mbx_clear_stale_irqs(void __iomem *base, u32 instance)
+{
+	u32 stale = cmh_reg_read32(base, R_MBX_INTERRUPT);
+
+	if (stale) {
+		cmh_reg_write32(stale, base, R_MBX_INTERRUPT);
+		dev_dbg(cmh_dev(), "mbx %u cleared stale irq bits=0x%x\n",
+			instance, stale);
+	}
+}
+
+/* Read CMH eSW HEAD and set TAIL = HEAD so the queue appears empty. */
+static void cmh_mbx_sync_tail_to_head(void __iomem *base, u32 instance)
+{
+	u32 fw_head = cmh_reg_read32(base, R_MBX_QUEUE_HEAD);
+
+	cmh_reg_write32(fw_head, base, R_MBX_QUEUE_TAIL);
+	if (fw_head)
+		dev_dbg(cmh_dev(), "mbx %u synced tail=%u to fw head\n",
+			instance, fw_head);
+}
+
+/* Per-Mailbox Setup */
+
+static int cmh_mbx_setup_one(struct cmh_mbx_config *mbx)
+{
+	void __iomem *base = mbx->reg_base;
+	u32 addr_lo = lower_32_bits(mbx->dma_handle);
+	u32 addr_hi = upper_32_bits(mbx->dma_handle);
+	u32 lock_val;
+	int ret;
+
+	/* Step 1: Acquire exclusive access */
+	lock_val = cmh_mbx_lock(base, mbx->instance);
+	if (!lock_val) {
+		dev_err(cmh_dev(), "mbx %u lock timeout after %u ms\n",
+			mbx->instance, MBX_LOCK_TIMEOUT_MS);
+		return -ETIMEDOUT;
+	}
+
+	/*
+	 * Step 1.5: Clear stale interrupt bits from a prior module lifecycle.
+	 *
+	 * After rmmod, the CMH eSW may leave ERROR_IRQ set in
+	 * R_MBX_INTERRUPT even though STATUS is IDLE.  If we enable
+	 * the mask first, the stale bits immediately trigger the
+	 * CMH eSW interrupt chain, which can cascade into ERROR
+	 * status before the first hash operation.  W1C-clear them first.
+	 */
+	cmh_mbx_clear_stale_irqs(base, mbx->instance);
+
+	/* Step 2: Program interrupt mask (enable DONE/ERROR interrupts) */
+	cmh_reg_write32(MBX_IRQ_MASK, base, R_MBX_INTERRUPT_MASK);
+
+	/* Step 3: Configure queue address (64-bit split) */
+	cmh_reg_write32(addr_lo, base, R_MBX_QUEUE_LO);
+	cmh_reg_write32(addr_hi, base, R_MBX_QUEUE_HI);
+
+	/* Step 4: Configure queue geometry */
+	cmh_reg_write32(mbx->slots_log2, base, R_MBX_QUEUE_SLOTS);
+	cmh_reg_write32(mbx->stride_log2, base, R_MBX_QUEUE_STRIDE);
+
+	/*
+	 * Step 5: Synchronise TAIL to CMH eSW's HEAD.
+	 *
+	 * R_MBX_QUEUE_HEAD is read-only from the host side -- only the
+	 * CMH eSW can write it.  On a fresh boot HEAD is 0; after an
+	 * rmmod/insmod cycle it retains the value from the previous
+	 * session (e.g. 44).  Writing 0 from the host is silently
+	 * dropped by the MBX HW.
+	 *
+	 * If we set TAIL=0 while HEAD=44 the CMH eSW sees a non-empty
+	 * queue (head != tail with wrap-around) and immediately tries
+	 * to load a VCQ at the old head offset into our freshly-zeroed
+	 * DMA buffer, causing an "Invalid VCQ" EFAULT -> ECHILD cascade.
+	 *
+	 * Fix: read HEAD and set TAIL = HEAD so the queue looks empty.
+	 */
+	cmh_mbx_sync_tail_to_head(base, mbx->instance);
+
+	/*
+	 * Step 6: Readback verify critical registers.
+	 * HOST_INFO is deliberately deferred to after verification -- writing
+	 * it tells the CMH eSW "MBX is ready" and the CMH eSW may inspect
+	 * (and clear) the queue registers immediately.
+	 */
+	ret = cmh_verify_reg(base, R_MBX_QUEUE_LO, addr_lo,
+			     "QUEUE_LO", mbx->instance);
+	if (ret)
+		goto err_unlock;
+
+	ret = cmh_verify_reg(base, R_MBX_QUEUE_HI, addr_hi,
+			     "QUEUE_HI", mbx->instance);
+	if (ret)
+		goto err_unlock;
+
+	ret = cmh_verify_reg(base, R_MBX_QUEUE_SLOTS, mbx->slots_log2,
+			     "QUEUE_SLOTS", mbx->instance);
+	if (ret)
+		goto err_unlock;
+
+	ret = cmh_verify_reg(base, R_MBX_QUEUE_STRIDE, mbx->stride_log2,
+			     "QUEUE_STRIDE", mbx->instance);
+	if (ret)
+		goto err_unlock;
+
+	/*
+	 * Step 7: Host identification -- signals CMH eSW that MBX is configured.
+	 * Must come after readback verification (CMH eSW may inspect the MBX
+	 * immediately) and before COMMAND_RUN.
+	 */
+	cmh_reg_write32(MBX_HOST_INFO_LKM, base, R_MBX_HOST_INFO);
+
+	/* Step 8: Enable -- start the mailbox */
+	cmh_reg_write32(MBX_COMMAND_RUN, base, R_MBX_COMMAND);
+
+	/* Read status while we still hold the lock */
+	dev_dbg(cmh_dev(), "mbx %u setup: dma=0x%08x%08x slots=%u stride=%u status=0x%08x\n",
+		mbx->instance, addr_hi, addr_lo,
+		 mbx->slots_log2, mbx->stride_log2,
+		 cmh_reg_read32(base, R_MBX_STATUS));
+
+	/*
+	 * Lock stays held for the lifetime of this MBX session.
+	 *
+	 * mbx->lock_val is the ownership token returned by R_MBX_LOCK at
+	 * acquisition time.  The CMH eSW validates this token on every
+	 * register access and requires it to be written back to release.
+	 * It is NOT a transient mutex -- it persists until teardown.
+	 */
+	mbx->lock_val = lock_val;
+
+	return 0;
+
+err_unlock:
+	cmh_mbx_unlock(base, lock_val);
+	return ret;
+}
+
+/* Per-Mailbox Teardown */
+
+static void cmh_mbx_teardown_one(struct cmh_mbx_config *mbx)
+{
+	void __iomem *base = mbx->reg_base;
+	u32 status;
+
+	if (!base || !mbx->lock_val)
+		return;
+
+	if (MBX_STATUS_CODE(cmh_reg_read32(base, R_MBX_STATUS)) !=
+	    MBX_STATUS_OFFLINE) {
+		cmh_reg_write32(MBX_COMMAND_FLUSH, base, R_MBX_COMMAND);
+
+		/*
+		 * Wait for the eSW to process the flush before releasing
+		 * the DMA buffer.  The eSW clears R_MBX_COMMAND to zero
+		 * upon completion; if it doesn't within 1 s, log a
+		 * warning and proceed (best-effort teardown).
+		 *
+		 * DMA safety: by this point the RH and TM are already
+		 * shut down (remove order: algos -> RH -> TM -> MQI),
+		 * so no new transactions can be submitted and no
+		 * completions are in flight.  The queue buffer is only
+		 * read by the eSW during active command processing;
+		 * after flush the eSW will not touch it again.
+		 */
+		if (read_poll_timeout(cmh_reg_read32, status,
+				      status == 0,
+				      MBX_FLUSH_POLL_US,
+				      MBX_FLUSH_TIMEOUT_US,
+				      true, base, R_MBX_COMMAND))
+			dev_warn(cmh_dev(),
+				 "mbx %u flush timeout during teardown (status=0x%08x)\n",
+				 mbx->instance,
+				 cmh_reg_read32(base, R_MBX_STATUS));
+	}
+
+	cmh_mbx_unlock(base, mbx->lock_val);
+	mbx->lock_val = 0;
+}
+
+/* Public Interface */
+
+/**
+ * cmh_mqi_init() - Initialize all mailbox queues
+ * @cfg: CMH configuration describing the mailboxes to set up
+ *
+ * Allocates DMA queue buffers for each configured mailbox, then executes
+ * the MBX lock/setup/enable register sequence.  On failure, all
+ * successfully initialized mailboxes are torn down and buffers freed.
+ *
+ * Return: 0 on success, negative errno on failure.
+ */
+int cmh_mqi_init(struct cmh_config *cfg)
+{
+	unsigned int i, j;
+	int ret;
+
+	/* Allocate queue buffers */
+	for (i = 0; i < cfg->mbx_count; i++) {
+		struct cmh_mbx_config *m = &cfg->mailboxes[i];
+
+		m->virt_addr = cmh_dma_alloc(m->queue_size, &m->dma_handle,
+					     GFP_KERNEL);
+		if (!m->virt_addr) {
+			ret = -ENOMEM;
+			goto err_free_bufs;
+		}
+
+		dev_dbg(cmh_dev(), "mqi[%u] alloc %zu bytes @ virt=%pK dma=%pad\n",
+			i, m->queue_size, m->virt_addr, &m->dma_handle);
+	}
+
+	/* Lock/setup/enable each mailbox */
+	for (i = 0; i < cfg->mbx_count; i++) {
+		ret = cmh_mbx_setup_one(&cfg->mailboxes[i]);
+		if (ret) {
+			dev_err(cmh_dev(), "mqi[%u] setup failed (rc=%d)\n",
+				i, ret);
+			goto err_teardown;
+		}
+	}
+
+	dev_info(cmh_dev(), "MQI init complete (%u mailboxes)\n", cfg->mbx_count);
+	return 0;
+
+err_teardown:
+	for (j = 0; j < i; j++)
+		cmh_mbx_teardown_one(&cfg->mailboxes[j]);
+err_free_bufs:
+	for (j = 0; j < cfg->mbx_count; j++) {
+		if (cfg->mailboxes[j].virt_addr)
+			cmh_dma_free(cfg->mailboxes[j].queue_size,
+				     cfg->mailboxes[j].virt_addr,
+				     cfg->mailboxes[j].dma_handle);
+		cfg->mailboxes[j].virt_addr = NULL;
+		cfg->mailboxes[j].dma_handle = 0;
+	}
+	return ret;
+}
+
+/**
+ * cmh_mqi_cleanup() - Clean up all mailbox queues
+ * @cfg: CMH configuration describing the mailboxes to tear down
+ *
+ * Tears down each mailbox (flush + unlock) and frees the DMA queue
+ * buffers allocated by cmh_mqi_init().
+ */
+void cmh_mqi_cleanup(struct cmh_config *cfg)
+{
+	unsigned int i;
+
+	for (i = 0; i < cfg->mbx_count; i++) {
+		struct cmh_mbx_config *m = &cfg->mailboxes[i];
+
+		cmh_mbx_teardown_one(m);
+
+		if (m->virt_addr)
+			cmh_dma_free(m->queue_size, m->virt_addr,
+				     m->dma_handle);
+		m->virt_addr = NULL;
+		m->dma_handle = 0;
+	}
+
+	dev_info(cmh_dev(), "MQI cleanup complete\n");
+}
diff --git a/drivers/crypto/cmh/cmh_rh.c b/drivers/crypto/cmh/cmh_rh.c
new file mode 100644
index 000000000000..48cb51d24a5e
--- /dev/null
+++ b/drivers/crypto/cmh/cmh_rh.c
@@ -0,0 +1,1145 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2026 Cryptography Research, Inc. (CRI).
+ * CMH LKM -- Response Handler
+ *
+ * IRQ-driven completion processing using request_threaded_irq():
+ *
+ *   Hardirq:  For each MBX, read R_MBX_INTERRUPT.  If any bit is set,
+ *             W1C-clear it and mark the MBX for threaded processing.
+ *             Return IRQ_WAKE_THREAD if any MBX had work.
+ *
+ *   Thread:   For each pending MBX, read R_MBX_QUEUE_HEAD.  Walk the
+ *             per-MBX transaction queue (oldest first): for every txn
+ *             whose last_vcq_id < new_head, check status, fire the
+ *             completion callback, and free the transaction object.
+ *
+ * The DT "cri,cmh" node declares one PLIC interrupt per mailbox,
+ * matching the real CMH ch_sys_interrupt_mbx[N-1:0] topology.
+ * Each MBX gets its own Linux virq; the same hardirq/thread pair
+ * is registered for all of them.  The handler still scans all
+ * mailboxes on every invocation -- this is intentional, as it
+ * provides robustness against coalesced or missed edges.
+ *
+ * IRQ source: resolved from the "cri,cmh" DT node at init time.
+ * The module's irq= parameter can override with a single shared IRQ.
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/slab.h>
+#include <linux/atomic.h>
+#include <linux/of.h>
+#include <linux/of_irq.h>
+#include <linux/timer.h>
+#include <linux/jiffies.h>
+
+#include "cmh_rh.h"
+#include "cmh_txn.h"
+#include "cmh_registers.h"
+#include "cmh_config.h"
+#include "cmh_debugfs.h"
+#include "cmh_dma.h"
+
+/* Per-mailbox IRQ bookkeeping */
+struct cmh_rh_mbx {
+	u32        last_head;   /* last-observed MBX head position */
+	atomic_t   irq_bits;   /* interrupt bits saved by hardirq (atomic_or) */
+	bool       pending;     /* threaded handler should process this MBX */
+	bool       restart_pending; /* RESTART issued, awaiting eSW ack */
+	u32        restart_retries; /* watchdog ticks since RESTART issued */
+	u32        flush_count;     /* consecutive failed FLUSH escalations */
+	bool       wedged;          /* recovery failed, MBX offline */
+	u32        abort_stall_ticks; /* ticks since async timeout ABORT issued */
+};
+
+/* Module-level RH state */
+static struct {
+	struct cmh_config      *cfg;
+	int                     irqs[CMH_MAX_CONFIGURED_MBX]; /* per-MBX virqs */
+	u32                     nirqs;          /* number of registered IRQs */
+	struct cmh_rh_mbx      *mbx;            /* array[cfg->mbx_count] */
+	atomic_t                irq_count;      /* hardirq invocation counter */
+	bool                    active;
+} rh;
+
+/*
+ * Serialise the read-last_head / process_mbx / update-last_head
+ * sequence between the threaded IRQ handler (process context) and
+ * the watchdog timer (softirq context).  Without this, a timer
+ * softirq can preempt the kthread mid-sequence, causing both paths
+ * to process the same head advance and prematurely complete a
+ * subsequent transaction before the CMH eSW has written its DMA
+ * output -- leading to data corruption and SLAB freelist poisoning.
+ *
+ * The kthread acquires with spin_lock_bh (disables softirqs), the
+ * watchdog acquires with spin_lock (already in softirq context).
+ */
+static DEFINE_SPINLOCK(rh_process_lock);
+
+/*
+ * Watchdog timer -- missed-IRQ recovery.
+ *
+ * Fires every watchdog_ms while rh.active.  Reads MBX head registers;
+ * if any head has advanced without an IRQ, processes completions and
+ * logs a notice.  Standard kernel pattern, analogous to NIC watchdog
+ * timers.
+ *
+ * Safe from timer/softirq context: cmh_reg_read32() is an MMIO read,
+ * cmh_tm_pop_transaction() uses spin_lock_irqsave(), and TM completion
+ * callbacks (crypto_request_complete et al.) are documented safe from
+ * any context including softirq.  rh_process_lock serialises the
+ * head-read / process / head-update sequence against the threaded
+ * IRQ handler to prevent double-processing of the same completion.
+ *
+ * Default 200 ms (5 fires/s) provides ~10 recovery attempts within
+ * the default vcq_timeout_ms (2 s).  Tune via debugfs config/watchdog_ms
+ * for platforms where interrupt delivery is more reliable (e.g. MSI on
+ * FPGA/silicon -- 500 ms--1 s may suffice as a safety net).
+ */
+#define CMH_RH_WATCHDOG_MS_DEFAULT  200
+
+/*
+ * Floor for watchdog_ms to prevent a zero/near-zero value from
+ * spinning the timer in a tight softirq loop.  Enforced at the
+ * point of use so debugfs writes are never rejected.
+ */
+#define CMH_RH_WATCHDOG_MS_MIN      10
+
+/*
+ * Maximum watchdog ticks to wait for the eSW to process RESTART
+ * before escalating to FLUSH.  At the default 200 ms interval,
+ * 5 retries = 1 s -- generous for an operation that should take
+ * microseconds.  If the eSW hasn't responded by then, issue
+ * MBX_COMMAND_FLUSH to hard-reset the mailbox state.
+ */
+#define CMH_RH_RESTART_MAX_RETRIES  5
+
+/*
+ * Maximum consecutive FLUSH escalations before marking the MBX as
+ * wedged.  Each FLUSH cycle takes RESTART_MAX_RETRIES watchdog ticks
+ * (~1 s at default interval).  Two failed FLUSHes (~2 s total)
+ * strongly indicate the eSW is not processing MBX commands at all.
+ */
+#define CMH_RH_FLUSH_MAX_FAILURES   2
+
+/*
+ * Time budget (ms) after an async timeout ABORT before escalating
+ * to FLUSH + force-drain.  Converted to watchdog ticks at runtime
+ * via abort_stall_ms / watchdog_ms, so the actual wall-clock bound
+ * stays constant regardless of watchdog_ms tuning.
+ *
+ * The stall detector fires when:
+ *   - The head-of-queue transaction is in TXN_TIMED_OUT state
+ *   - HEAD hasn't advanced (eSW didn't process the ABORT)
+ *   - abort_stall_ticks exceeds the derived threshold
+ *
+ * At that point we issue FLUSH + force-drain, completing all pending
+ * transactions with -ETIMEDOUT and waking any blocked waiters.
+ *
+ * Default 5000 ms bounds worst-case D-state to
+ * async_timeout (2 s) + abort_stall (5 s) = ~7 s.
+ */
+#define CMH_RH_ABORT_STALL_MS       5000
+
+static unsigned int watchdog_ms = CMH_RH_WATCHDOG_MS_DEFAULT;
+
+/*
+ * Re-poke R_MBX_QUEUE_TAIL to generate a fresh interrupt to the eSW.
+ * Writing the current value back is a queue no-op but guarantees a
+ * SIC interrupt edge, ensuring the eSW wakes from WFI.
+ */
+static void cmh_rh_poke_tail(void __iomem *base)
+{
+	u32 tail = cmh_reg_read32(base, R_MBX_QUEUE_TAIL);
+
+	cmh_reg_write32(tail, base, R_MBX_QUEUE_TAIL);
+}
+
+/*
+ * Drain all remaining in-flight transactions for a mailbox, completing
+ * each with the given error code.  Called after FLUSH (which discards
+ * all queued VCQs) or when marking a mailbox as wedged.  Updates
+ * last_head to the current hardware HEAD so subsequent polls don't
+ * re-process the same (now-dead) VCQ IDs as successful completions.
+ *
+ * Caller must hold rh_process_lock.
+ */
+static void cmh_rh_drain_mbx(u32 mbx_idx, int error)
+{
+	struct transaction_obj *txn;
+
+	while ((txn = cmh_tm_pop_transaction(mbx_idx)) != NULL) {
+		dev_dbg(cmh_dev(), "rh: mbx[%u] drain vcq=%u..%u err=%d\n",
+			mbx_idx, txn->first_vcq_id,
+			txn->last_vcq_id, error);
+		cmh_txn_finish(txn, error);
+		cmh_tm_txq_completion_notify();
+	}
+
+	rh.mbx[mbx_idx].last_head =
+		cmh_reg_read32(rh.cfg->mailboxes[mbx_idx].reg_base,
+			       R_MBX_QUEUE_HEAD);
+}
+
+/**
+ * cmh_rh_force_drain_mbx() - FLUSH + drain a mailbox from external context
+ * @mbx_idx: Mailbox index to drain
+ *
+ * Issues MBX_COMMAND_FLUSH to the eSW, drains all pending transactions
+ * (completing each with -ECANCELED), and resets all recovery bookkeeping
+ * including the wedged flag.  This is an administrative last-resort
+ * recovery path exposed via debugfs.
+ *
+ * Context: process context.  Acquires rh_process_lock internally.
+ */
+void cmh_rh_force_drain_mbx(u32 mbx_idx)
+{
+	void __iomem *base;
+
+	if (!rh.cfg || !rh.mbx || mbx_idx >= rh.cfg->mbx_count)
+		return;
+
+	base = rh.cfg->mailboxes[mbx_idx].reg_base;
+
+	dev_warn(cmh_dev(), "rh: force-drain mbx[%u] (debugfs)\n", mbx_idx);
+	spin_lock_bh(&rh_process_lock);
+	cmh_reg_write32(MBX_IRQ_MASK, base, R_MBX_INTERRUPT);
+	cmh_reg_write32(MBX_COMMAND_FLUSH, base, R_MBX_COMMAND);
+	cmh_rh_poke_tail(base);
+	cmh_rh_drain_mbx(mbx_idx, -ECANCELED);
+	rh.mbx[mbx_idx].abort_stall_ticks = 0;
+	WRITE_ONCE(rh.mbx[mbx_idx].restart_pending, false);
+	rh.mbx[mbx_idx].restart_retries = 0;
+	rh.mbx[mbx_idx].flush_count = 0;
+	WRITE_ONCE(rh.mbx[mbx_idx].wedged, false);
+	spin_unlock_bh(&rh_process_lock);
+}
+
+/**
+ * cmh_rh_mbx_is_wedged() - Check if a mailbox is permanently wedged
+ * @mbx_idx: Mailbox index to check
+ *
+ * Return: true if the mailbox has failed recovery and is offline.
+ */
+bool cmh_rh_mbx_is_wedged(u32 mbx_idx)
+{
+	if (!rh.mbx || !rh.cfg || mbx_idx >= rh.cfg->mbx_count)
+		return false;
+
+	return READ_ONCE(rh.mbx[mbx_idx].wedged);
+}
+
+/**
+ * cmh_rh_abort_mbx() - Issue MBX_COMMAND_ABORT under rh_process_lock
+ * @mbx_idx: Mailbox index to abort
+ *
+ * Serialises the ABORT write with RESTART/FLUSH commands issued by the
+ * watchdog, preventing command-register clobber races.  Safe to call
+ * from any context (uses spin_lock_bh).
+ */
+void cmh_rh_abort_mbx(u32 mbx_idx)
+{
+	void __iomem *base;
+
+	if (!rh.cfg || !rh.mbx || mbx_idx >= rh.cfg->mbx_count)
+		return;
+
+	base = rh.cfg->mailboxes[mbx_idx].reg_base;
+
+	spin_lock_bh(&rh_process_lock);
+	cmh_reg_write32(MBX_COMMAND_ABORT, base, R_MBX_COMMAND);
+	spin_unlock_bh(&rh_process_lock);
+}
+
+static struct timer_list rh_watchdog;
+
+/*
+ * Hardirq handler -- runs with interrupts disabled.
+ *
+ * Read and W1C-clear R_MBX_INTERRUPT for each mailbox.
+ * If any MBX had a pending interrupt, return IRQ_WAKE_THREAD.
+ * Shared-IRQ safe: returns IRQ_NONE if we didn't handle anything.
+ */
+static irqreturn_t cmh_rh_hardirq(int irq, void *data)
+{
+	struct cmh_config *cfg = data;
+	bool handled = false;
+	u32 i;
+
+	for (i = 0; i < cfg->mbx_count; i++) {
+		void __iomem *base = cfg->mailboxes[i].reg_base;
+		u32 bits;
+
+		bits = cmh_reg_read32(base, R_MBX_INTERRUPT);
+		if (!bits)
+			continue;
+
+		/* W1C: write back the set bits to clear them */
+		cmh_reg_write32(bits, base, R_MBX_INTERRUPT);
+
+		/*
+		 * Accumulate bits atomically so a second hardirq
+		 * firing while the threaded handler runs does not
+		 * overwrite the first set of bits.
+		 */
+		atomic_or((int)bits, &rh.mbx[i].irq_bits);
+		WRITE_ONCE(rh.mbx[i].pending, true);
+		handled = true;
+	}
+
+	/*
+	 * Ordering: the kernel IRQ threading infrastructure
+	 * performs a full barrier between hardirq return and
+	 * the threaded handler invocation.
+	 */
+	if (handled)
+		atomic_inc(&rh.irq_count);
+
+	return handled ? IRQ_WAKE_THREAD : IRQ_NONE;
+}
+
+/*
+ * Process completions for a single mailbox.
+ *
+ * Walk the per-MBX transaction queue FIFO.  For each transaction
+ * whose last_vcq_id is strictly less than the new head, fire the
+ * completion callback and free the object.
+ *
+ * "Strictly less than" using signed (s32) arithmetic handles wrap-around:
+ * the CMH eSW uses monotonically increasing 32-bit VCQ IDs.
+ */
+static void cmh_rh_process_mbx(u32 mbx_idx, u32 new_head, u32 irq_bits)
+{
+	struct transaction_obj *txn;
+	int error = 0;
+
+	/* Determine error state from saved IRQ bits */
+	if (irq_bits & MBX_ERROR_IRQ) {
+		void __iomem *base = rh.cfg->mailboxes[mbx_idx].reg_base;
+		u32 status = cmh_reg_read32(base, R_MBX_STATUS);
+
+		error = -EIO;
+		dev_dbg(cmh_dev(), "rh: mbx[%u] error status=0x%08x (code=%u cmd_idx=%u)\n",
+			mbx_idx, status,
+		       MBX_STATUS_ERROR_CODE(status),
+		       MBX_STATUS_CMD_INDEX(status));
+
+		/*
+		 * ECHILD (10) in the parent status means a child VCQ
+		 * failed internally.  Read R_MBX_CHILD for the actual
+		 * root cause (real errno, child core ID, child cmd idx).
+		 */
+		if (MBX_STATUS_ERROR_CODE(status) == ECHILD) {
+			u32 child = cmh_reg_read32(base, R_MBX_CHILD);
+
+			dev_dbg(cmh_dev(),
+				"rh: mbx[%u] child error=0x%08x (core=%u code=%u cmd_idx=%u)\n",
+				mbx_idx, child,
+				MBX_STATUS_CORE_ID(child),
+				MBX_STATUS_ERROR_CODE(child),
+				MBX_STATUS_CMD_INDEX(child));
+		}
+
+		/*
+		 * CMH eSW does not advance head on error -- the MBX is
+		 * stuck in ERROR state until the host issues a recovery
+		 * command.  However, HEAD may have advanced past one or
+		 * more already-completed transactions before the error
+		 * occurred (their completion IRQ may not have been
+		 * processed yet).  Retire those normally first, then
+		 * force-complete the NEXT transaction (the one that
+		 * actually failed) with -EIO.
+		 *
+		 * MBX command semantics after ERROR:
+		 *   CONTINUE -- re-run the same VCQ at HEAD (retry)
+		 *   RESTART  -- advance HEAD+1, skip failed, resume
+		 *   FLUSH    -- HEAD=TAIL, flush all HWCs, discard queue
+		 */
+
+		/* First: retire transactions completed before the error */
+		while ((txn = cmh_tm_peek_transaction(mbx_idx)) != NULL) {
+			if ((s32)(new_head - txn->last_vcq_id) <= 0)
+				break;
+			txn = cmh_tm_pop_transaction(mbx_idx);
+			if (!txn)
+				break;
+			dev_dbg(cmh_dev(),
+				"rh: mbx[%u] pre-error complete vcq=%u..%u\n",
+				mbx_idx, txn->first_vcq_id,
+				txn->last_vcq_id);
+			cmh_txn_finish(txn, 0);
+			cmh_tm_txq_completion_notify();
+		}
+
+		/* Now pop and fail the transaction that actually errored */
+		txn = cmh_tm_pop_transaction(mbx_idx);
+		if (txn) {
+			dev_dbg(cmh_dev(), "rh: mbx[%u] error-complete vcq=%u..%u\n",
+				mbx_idx, txn->first_vcq_id,
+				txn->last_vcq_id);
+			cmh_txn_finish(txn, error);
+			cmh_tm_txq_completion_notify();
+		} else {
+			u32 head_reg, tail_reg;
+
+			head_reg = cmh_reg_read32(base, R_MBX_QUEUE_HEAD);
+			tail_reg = cmh_reg_read32(base, R_MBX_QUEUE_TAIL);
+			dev_warn_ratelimited(cmh_dev(),
+					     "rh: mbx[%u] ERROR with empty txn queue (orphaned) status=0x%08x head=%u tail=%u core=%u ecode=%u cmd_idx=%u\n",
+					     mbx_idx, status,
+					     head_reg, tail_reg,
+					     MBX_STATUS_CORE_ID(status),
+					     MBX_STATUS_ERROR_CODE(status),
+					     MBX_STATUS_CMD_INDEX(status));
+		}
+		{
+			struct cmh_mbx_stats *s = cmh_debugfs_mbx_stats(mbx_idx);
+
+			if (s)
+				atomic64_inc(&s->vcqs_errors);
+		}
+
+		/*
+		 * W1C-clear R_MBX_INTERRUPT before issuing RESTART.
+		 *
+		 * The eSW sets MBX_ERROR_IRQ in R_MBX_INTERRUPT when
+		 * it writes ERROR status.  On platforms where the
+		 * hardirq handler runs (IRQ wired to GIC), this bit
+		 * is cleared there.  On polling-only platforms (no
+		 * IRQ line), it must be cleared explicitly before
+		 * issuing a recovery command to de-assert the
+		 * MBX-to-SIC interrupt line.
+		 */
+		cmh_reg_write32(MBX_IRQ_MASK, base, R_MBX_INTERRUPT);
+		cmh_reg_write32(MBX_COMMAND_RESTART, base, R_MBX_COMMAND);
+
+		/*
+		 * Poke R_MBX_QUEUE_TAIL to guarantee the eSW receives
+		 * an interrupt.
+		 *
+		 * Writing R_MBX_COMMAND alone may not produce a new
+		 * SIC interrupt edge if the MBX-to-SIC line is still
+		 * asserted from prior error processing.  The eSW RUN
+		 * handler re-writes ERROR_IRQ to R_MBX_INTERRUPT on
+		 * every spurious wakeup while in ERROR state, which
+		 * can keep the SIC line high on level-triggered HW.
+		 *
+		 * R_MBX_QUEUE_TAIL writes always generate a fresh
+		 * interrupt to the eSW (this is the normal VCQ
+		 * submission path).  Writing the current TAIL value
+		 * back is a no-op from the queue perspective but
+		 * ensures the eSW wakes from WFI and processes the
+		 * RESTART command.
+		 */
+		cmh_rh_poke_tail(base);
+		WRITE_ONCE(rh.mbx[mbx_idx].restart_pending, true);
+		rh.mbx[mbx_idx].restart_retries = 0;
+		return;
+	}
+
+	/*
+	 * Pop completed transactions.  A transaction is complete when
+	 * the CMH eSW has advanced head past its last VCQ ID:
+	 *   (s32)(new_head - txn->last_vcq_id) > 0
+	 * Using signed comparison for correct wrap-around handling.
+	 *
+	 * Multi-VCQ note: transactions spanning multiple slots (e.g.
+	 * SLH-DSA with 3+ VCQs) are treated atomically -- either the
+	 * head has passed all of them or none.  The CMH eSW processes
+	 * multi-VCQ groups sequentially within a single mailbox and
+	 * only advances HEAD after the entire group completes.  Per-slot
+	 * progress validation (checking intermediate HEAD positions
+	 * within a multi-VCQ group) is not implemented because:
+	 *   1. The eSW guarantees atomic group completion semantics
+	 *   2. Partial progress is only observable during processing,
+	 *      never at a completion boundary
+	 *   3. Adding intermediate checks would require tracking
+	 *      per-slot status with no correctness benefit
+	 *
+	 * A defensive WARN_ON_ONCE detects eSW misbehavior: if HEAD
+	 * lands between first_vcq_id and last_vcq_id of a multi-VCQ
+	 * transaction, the eSW violated its atomic group contract.
+	 */
+	while ((txn = cmh_tm_peek_transaction(mbx_idx)) != NULL) {
+		if ((s32)(new_head - txn->last_vcq_id) <= 0) {
+			/*
+			 * Not yet complete.  For multi-VCQ transactions,
+			 * assert HEAD hasn't partially advanced into the
+			 * group -- that would indicate eSW firmware bug.
+			 */
+			WARN_ON_ONCE(txn->first_vcq_id != txn->last_vcq_id &&
+				     (s32)(new_head - txn->first_vcq_id) > 0);
+			break;
+		}
+
+		txn = cmh_tm_pop_transaction(mbx_idx);
+		if (!txn)
+			break;
+
+		dev_dbg(cmh_dev(), "rh: mbx[%u] complete vcq=%u..%u err=%d\n",
+			mbx_idx, txn->first_vcq_id, txn->last_vcq_id,
+			 error);
+
+		{
+			struct cmh_mbx_stats *s = cmh_debugfs_mbx_stats(mbx_idx);
+
+			if (s) {
+				u32 n = txn->last_vcq_id -
+					txn->first_vcq_id + 1;
+
+				atomic64_add(n, &s->vcqs_completed);
+			}
+		}
+
+		cmh_txn_finish(txn, error);
+		cmh_tm_txq_completion_notify();
+	}
+}
+
+/*
+ * Threaded IRQ handler -- runs in process context.
+ *
+ * Walk all MBXes that had pending interrupts.  After processing the
+ * pending set, do a final hardware poll of all MBX head registers to
+ * catch completions whose PLIC interrupt was consumed during an
+ * earlier register access (e.g. an inline interrupt notification
+ * during MMIO can cause the PLIC edge to be claimed before the
+ * hardirq sees it).
+ */
+static irqreturn_t cmh_rh_thread(int irq, void *data)
+{
+	struct cmh_config *cfg = data;
+	u32 i;
+	bool recheck;
+
+	do {
+		recheck = false;
+
+		for (i = 0; i < cfg->mbx_count; i++) {
+			u32 new_head, irq_bits;
+
+			if (!READ_ONCE(rh.mbx[i].pending))
+				continue;
+
+			irq_bits = (u32)atomic_xchg(&rh.mbx[i].irq_bits, 0);
+			WRITE_ONCE(rh.mbx[i].pending, false);
+
+			spin_lock_bh(&rh_process_lock);
+			new_head = cmh_reg_read32(cfg->mailboxes[i].reg_base,
+						  R_MBX_QUEUE_HEAD);
+
+			if (new_head == rh.mbx[i].last_head && !irq_bits) {
+				spin_unlock_bh(&rh_process_lock);
+				continue;
+			}
+
+			cmh_rh_process_mbx(i, new_head, irq_bits);
+			rh.mbx[i].last_head = new_head;
+			spin_unlock_bh(&rh_process_lock);
+		}
+
+		/*
+		 * Re-check: if the hardirq fired again while we were
+		 * processing, pending flags will be set again.
+		 */
+		for (i = 0; i < cfg->mbx_count; i++) {
+			if (READ_ONCE(rh.mbx[i].pending)) {
+				recheck = true;
+				break;
+			}
+		}
+	} while (recheck);
+
+	/*
+	 * Final hardware poll: read every MBX head register and status
+	 * to catch completions or errors whose interrupt was missed.
+	 */
+	for (i = 0; i < cfg->mbx_count; i++) {
+		u32 new_head;
+		u32 status;
+		u32 poll_irq_bits = 0;
+
+		spin_lock_bh(&rh_process_lock);
+		new_head = cmh_reg_read32(cfg->mailboxes[i].reg_base,
+					  R_MBX_QUEUE_HEAD);
+		status = cmh_reg_read32(cfg->mailboxes[i].reg_base,
+					R_MBX_STATUS);
+
+		if (MBX_STATUS_CODE(status) == MBX_STATUS_ERROR) {
+			if (READ_ONCE(rh.mbx[i].wedged)) {
+				spin_unlock_bh(&rh_process_lock);
+				continue;
+			}
+			if (READ_ONCE(rh.mbx[i].restart_pending)) {
+				/*
+				 * HEAD advanced while restart_pending means
+				 * RESTART worked but next VCQ also failed.
+				 * Clear restart state and process new error.
+				 */
+				if (new_head != rh.mbx[i].last_head) {
+					WRITE_ONCE(rh.mbx[i].restart_pending,
+						   false);
+					rh.mbx[i].restart_retries = 0;
+				} else {
+					spin_unlock_bh(&rh_process_lock);
+					continue;
+				}
+			}
+			poll_irq_bits = MBX_ERROR_IRQ;
+		} else {
+			WRITE_ONCE(rh.mbx[i].restart_pending, false);
+			rh.mbx[i].restart_retries = 0;
+			rh.mbx[i].flush_count = 0;
+		}
+
+		if (new_head != rh.mbx[i].last_head || poll_irq_bits) {
+			cmh_rh_process_mbx(i, new_head, poll_irq_bits);
+			rh.mbx[i].last_head = new_head;
+		}
+		spin_unlock_bh(&rh_process_lock);
+	}
+
+	return IRQ_HANDLED;
+}
+
+/*
+ * Watchdog timer callback -- missed-IRQ recovery.
+ *
+ * Reads all MBX head registers.  If any head advanced without a
+ * corresponding IRQ, process the completions here.  Re-arms itself
+ * while rh.active is true.
+ */
+static void cmh_rh_watchdog_fn(struct timer_list *t)
+{
+	u32 i;
+
+	if (!rh.active || !rh.cfg || !rh.mbx)
+		return;
+
+	for (i = 0; i < rh.cfg->mbx_count; i++) {
+		u32 new_head;
+		u32 status;
+		u32 irq_bits = 0;
+
+		spin_lock(&rh_process_lock);
+		new_head = cmh_reg_read32(rh.cfg->mailboxes[i].reg_base,
+					  R_MBX_QUEUE_HEAD);
+		status = cmh_reg_read32(rh.cfg->mailboxes[i].reg_base,
+					R_MBX_STATUS);
+
+		if (MBX_STATUS_CODE(status) == MBX_STATUS_ERROR) {
+			if (READ_ONCE(rh.mbx[i].wedged)) {
+				spin_unlock(&rh_process_lock);
+				continue;
+			}
+			/*
+			 * Back-to-back failure scenario: the crypto API
+			 * (e.g. testmgr) may submit requests continuously.
+			 * If RESTART succeeds but the next VCQ also fails,
+			 * the entire RESTART->IDLE->RUN->ERROR cycle can
+			 * complete within a single 200ms watchdog period.
+			 * Without the HEAD-advance check below, the watchdog
+			 * would mistake the new error for a failed RESTART,
+			 * increment restart_retries, and eventually escalate
+			 * to FLUSH -- wedging the mailbox unnecessarily.
+			 */
+			if (READ_ONCE(rh.mbx[i].restart_pending)) {
+				void __iomem *base =
+					rh.cfg->mailboxes[i].reg_base;
+
+				/*
+				 * HEAD advanced since RESTART was issued:
+				 * RESTART succeeded, this is a fresh error.
+				 * Clear recovery state and process normally.
+				 */
+				if (new_head != rh.mbx[i].last_head) {
+					dev_dbg(cmh_dev(),
+						"rh: watchdog: mbx[%u] head advanced %u->%u during restart -- new error\n",
+						i, rh.mbx[i].last_head,
+						new_head);
+					WRITE_ONCE(rh.mbx[i].restart_pending,
+						   false);
+					rh.mbx[i].restart_retries = 0;
+					goto new_error;
+				}
+
+				rh.mbx[i].restart_retries++;
+				if (rh.mbx[i].restart_retries >
+				    CMH_RH_RESTART_MAX_RETRIES) {
+					rh.mbx[i].flush_count++;
+					if (rh.mbx[i].flush_count >=
+					    CMH_RH_FLUSH_MAX_FAILURES) {
+						u32 hb, ei, cmd;
+
+						cmd = cmh_reg_read32(base, R_MBX_COMMAND);
+						hb = cmh_reg_read32(rh.cfg->sic_mapped,
+								    R_SIC_SW_HEARTBEAT);
+						ei = cmh_reg_read32(rh.cfg->sic_mapped,
+								    R_SIC_SW_ERROR_INFO);
+						dev_crit(cmh_dev(),
+							 "rh: mbx[%u] wedged after %u FLUSHes (cmd=0x%x status=0x%x hb=0x%x err=0x%x)\n",
+							 i,
+							 rh.mbx[i].flush_count,
+							 cmd, status,
+							 hb, ei);
+						WRITE_ONCE(rh.mbx[i].wedged,
+							   true);
+						cmh_rh_drain_mbx(i, -EIO);
+						spin_unlock(&rh_process_lock);
+						continue;
+					}
+					/*
+					 * Backstop: eSW did not respond
+					 * to RESTART within the retry
+					 * budget.  Escalate to FLUSH
+					 * which is a harder reset of
+					 * the eSW mailbox state.
+					 */
+					dev_err(cmh_dev(),
+						"rh: watchdog: mbx[%u] RESTART unresponsive after %u ticks, escalating to FLUSH (attempt %u/%u)\n",
+						i, rh.mbx[i].restart_retries,
+						rh.mbx[i].flush_count,
+						CMH_RH_FLUSH_MAX_FAILURES);
+					cmh_reg_write32(MBX_IRQ_MASK,
+							base,
+							R_MBX_INTERRUPT);
+					cmh_reg_write32(MBX_COMMAND_FLUSH,
+							base,
+							R_MBX_COMMAND);
+					cmh_rh_poke_tail(base);
+					cmh_rh_drain_mbx(i, -EIO);
+					WRITE_ONCE(rh.mbx[i].restart_pending,
+						   false);
+					rh.mbx[i].restart_retries = 0;
+					spin_unlock(&rh_process_lock);
+					continue;
+				}
+				/*
+				 * RESTART was already issued on a prior
+				 * tick but the eSW hasn't cleared the
+				 * ERROR status yet.  Do NOT pop another
+				 * transaction -- that would cascade-kill
+				 * unrelated in-flight work.  Re-poke TAIL
+				 * in case the eSW missed the interrupt.
+				 */
+				cmh_rh_poke_tail(base);
+				dev_dbg_ratelimited(cmh_dev(),
+						    "rh: watchdog: mbx[%u] restart pending (%u/%u) status=0x%08x, re-poke\n",
+						    i,
+						    rh.mbx[i].restart_retries,
+						    CMH_RH_RESTART_MAX_RETRIES,
+						    status);
+				spin_unlock(&rh_process_lock);
+				continue;
+			}
+new_error:
+			dev_dbg_ratelimited(cmh_dev(),
+					    "rh: watchdog: mbx[%u] error status=0x%08x (missed error IRQ) head=%u tail=%u core=%u ecode=%u cmd_idx=%u\n",
+					    i, status, new_head,
+					    cmh_reg_read32(rh.cfg->mailboxes[i].reg_base,
+							   R_MBX_QUEUE_TAIL),
+					    MBX_STATUS_CORE_ID(status),
+					    MBX_STATUS_ERROR_CODE(status),
+					    MBX_STATUS_CMD_INDEX(status));
+			irq_bits = MBX_ERROR_IRQ;
+		} else {
+			/* eSW cleared ERROR -- recovery succeeded */
+			WRITE_ONCE(rh.mbx[i].restart_pending, false);
+			rh.mbx[i].restart_retries = 0;
+			rh.mbx[i].flush_count = 0;
+		}
+
+		if (new_head != rh.mbx[i].last_head || irq_bits) {
+			if (new_head != rh.mbx[i].last_head)
+				dev_dbg_ratelimited(cmh_dev(),
+						    "rh: watchdog: mbx[%u] head %u->%u (missed IRQ recovery)\n",
+						    i, rh.mbx[i].last_head,
+						    new_head);
+			cmh_rh_process_mbx(i, new_head, irq_bits);
+			rh.mbx[i].last_head = new_head;
+			rh.mbx[i].abort_stall_ticks = 0;
+		}
+
+		/*
+		 * Abort-stall detector: if the head-of-queue transaction
+		 * timed out (state == TXN_TIMED_OUT) but the eSW hasn't
+		 * responded (HEAD didn't advance, no ERROR status):
+		 *
+		 *   tick 1:        issue MBX_COMMAND_ABORT (serialised
+		 *                  under rh_process_lock -- safe against
+		 *                  concurrent RESTART/FLUSH)
+		 *   ticks 2..N-1:  wait for eSW to respond with ERROR
+		 *   tick N:         escalate to FLUSH + force-drain
+		 *
+		 * If the eSW responds with ERROR between ticks, the ERROR
+		 * status branch above handles RESTART recovery and resets
+		 * abort_stall_ticks via the restart_pending guard.
+		 */
+		if (!READ_ONCE(rh.mbx[i].wedged) &&
+		    !READ_ONCE(rh.mbx[i].restart_pending)) {
+			struct transaction_obj *head_txn;
+
+			head_txn = cmh_tm_peek_transaction(i);
+			if (head_txn &&
+			    atomic_read(&head_txn->state) == TXN_TIMED_OUT) {
+				unsigned int stall_max;
+				void __iomem *base =
+					rh.cfg->mailboxes[i].reg_base;
+
+				rh.mbx[i].abort_stall_ticks++;
+
+				if (rh.mbx[i].abort_stall_ticks == 1) {
+					dev_warn(cmh_dev(),
+						 "rh: watchdog: mbx[%u] head txn timed out, issuing ABORT\n",
+						 i);
+					cmh_reg_write32(MBX_COMMAND_ABORT,
+							base,
+							R_MBX_COMMAND);
+				}
+
+				stall_max = DIV_ROUND_UP(CMH_RH_ABORT_STALL_MS,
+							 max(watchdog_ms,
+							     CMH_RH_WATCHDOG_MS_MIN));
+				if (rh.mbx[i].abort_stall_ticks >=
+				    stall_max) {
+					dev_err(cmh_dev(),
+						"rh: watchdog: mbx[%u] abort stall (%u ticks) -- FLUSH + drain\n",
+						i, rh.mbx[i].abort_stall_ticks);
+					cmh_reg_write32(MBX_COMMAND_FLUSH,
+							base, R_MBX_COMMAND);
+					cmh_rh_drain_mbx(i, -ETIMEDOUT);
+					rh.mbx[i].abort_stall_ticks = 0;
+				}
+			} else {
+				rh.mbx[i].abort_stall_ticks = 0;
+			}
+		}
+		spin_unlock(&rh_process_lock);
+	}
+
+	if (rh.active) {
+		unsigned int wdog = max(watchdog_ms, CMH_RH_WATCHDOG_MS_MIN);
+
+		mod_timer(&rh_watchdog,
+			  jiffies + msecs_to_jiffies(wdog));
+	}
+}
+
+/*
+ * Resolve per-MBX Linux virqs for the CMH interrupt lines.
+ *
+ * Strategy:
+ *   1. If cfg->irq >= 0, use it as a shared IRQ for all MBXes
+ *   2. Otherwise, find the "cri,cmh" DT node and map one IRQ per
+ *      active mailbox using cfg->mailboxes[i].instance as the DT
+ *      interrupt index (matching the per-MBX PLIC wiring)
+ *
+ * Populates rh.irqs[] and rh.nirqs.  Returns 0 on success, or a
+ * negative errno if no IRQs could be resolved (polling-only mode).
+ */
+static int cmh_rh_resolve_irqs(struct cmh_config *cfg)
+{
+	struct device_node *np;
+	u32 i;
+
+	rh.nirqs = 0;
+
+	/* Single legacy IRQ from DT: shared across all MBXes */
+	if (cfg->irq >= 0) {
+		rh.irqs[0] = cfg->irq;
+		rh.nirqs = 1;
+		dev_dbg(cmh_dev(), "rh: using single DT IRQ %d for all %u MBXes\n",
+			cfg->irq, cfg->mbx_count);
+		return 0;
+	}
+
+	np = cfg->of_node;
+	if (!np) {
+		dev_warn(cmh_dev(), "rh: no DT node -- IRQ disabled\n");
+		return -ENODEV;
+	}
+
+	for (i = 0; i < cfg->mbx_count; i++) {
+		int dt_idx = cfg->mailboxes[i].instance;
+		int virq = of_irq_get(np, dt_idx);
+
+		if (virq <= 0) {
+			dev_warn(cmh_dev(), "rh: failed to map IRQ for MBX%u (DT index %d, rc=%d)\n",
+				 i, dt_idx, virq);
+			return -ENODEV;
+		}
+		rh.irqs[i] = virq;
+		dev_dbg(cmh_dev(), "rh: MBX%u -> IRQ %d (DT index %d)\n",
+			i, virq, dt_idx);
+	}
+
+	rh.nirqs = cfg->mbx_count;
+	return 0;
+}
+
+/**
+ * cmh_rh_init() - Initialize the response handler
+ * @cfg: Device configuration (mailbox count, MMIO bases, IRQ info)
+ *
+ * Resolve per-mailbox IRQs from the device tree (or module parameter
+ * override), register threaded IRQ handlers (hardirq + kthread), and
+ * arm the missed-IRQ software watchdog timer.  If no IRQs can be
+ * resolved, falls back to watchdog-only polling mode.
+ *
+ * Return: 0 on success, negative errno on failure.
+ */
+int cmh_rh_init(struct cmh_config *cfg)
+{
+	int ret;
+	u32 i;
+
+	rh.cfg = cfg;
+	rh.nirqs = 0;
+	rh.active = false;
+	atomic_set(&rh.irq_count, 0);
+
+	/* Allocate per-MBX tracking */
+	rh.mbx = kcalloc(cfg->mbx_count, sizeof(*rh.mbx), GFP_KERNEL);
+	if (!rh.mbx)
+		return -ENOMEM;
+
+	/* Resolve per-MBX IRQs */
+	if (cmh_rh_resolve_irqs(cfg) < 0) {
+		/*
+		 * No IRQs available.  The watchdog timer provides
+		 * a polling fallback: it reads MBX head registers
+		 * periodically and processes completions.  This is
+		 * slower than IRQ-driven completion but functional.
+		 *
+		 * Completion latency in polling-only mode is bounded
+		 * by the watchdog interval (default 200 ms, tunable
+		 * via debugfs config/watchdog_ms).
+		 */
+		dev_warn(cmh_dev(),
+			 "rh: no IRQs -- using watchdog polling (interval %u ms)\n",
+			 watchdog_ms);
+
+		/* Seed last_head from HW before first watchdog tick */
+		for (i = 0; i < cfg->mbx_count; i++)
+			rh.mbx[i].last_head =
+				cmh_reg_read32(cfg->mailboxes[i].reg_base,
+					       R_MBX_QUEUE_HEAD);
+
+		rh.active = true;
+		timer_setup(&rh_watchdog, cmh_rh_watchdog_fn, 0);
+		mod_timer(&rh_watchdog, jiffies +
+			  msecs_to_jiffies(max(watchdog_ms,
+					       CMH_RH_WATCHDOG_MS_MIN)));
+		return 0;
+	}
+
+	/* Initialize per-MBX state: read current head positions */
+	for (i = 0; i < cfg->mbx_count; i++)
+		rh.mbx[i].last_head = cmh_reg_read32(rh.cfg->mailboxes[i].reg_base,
+						     R_MBX_QUEUE_HEAD);
+
+	/*
+	 * Register threaded IRQ handlers.
+	 *
+	 * DT per-MBX path: one distinct virq per MBX, nirqs == mbx_count.
+	 * DT single-IRQ path: one shared IRQ, nirqs == 1.  The handler
+	 * scans all mailboxes unconditionally, so a single registration
+	 * suffices.
+	 *
+	 * Use IRQF_SHARED only for the single-IRQ path where one line
+	 * is shared across all MBXes.  Dedicated per-MBX virqs need no
+	 * sharing flag.
+	 */
+	{
+		unsigned long irqflags = (rh.nirqs == 1 && cfg->mbx_count > 1)
+					  ? IRQF_SHARED : 0;
+
+		for (i = 0; i < rh.nirqs; i++) {
+			ret = request_threaded_irq(rh.irqs[i],
+						   cmh_rh_hardirq,
+						   cmh_rh_thread,
+						   irqflags,
+						   "cmh", cfg);
+			if (ret) {
+				dev_err(cmh_dev(), "rh: request_threaded_irq(%d) for MBX%u failed (rc=%d)\n",
+					rh.irqs[i], i, ret);
+				/* Unwind previously registered IRQs */
+				while (i--)
+					free_irq(rh.irqs[i], cfg);
+				rh.nirqs = 0;
+				kfree(rh.mbx);
+				rh.mbx = NULL;
+				return ret;
+			}
+		}
+	}
+
+	rh.active = true;
+
+	/* Enable MBX completion interrupts (DONE + ERROR) */
+	for (i = 0; i < cfg->mbx_count; i++) {
+		u32 stale;
+
+		/*
+		 * W1C any interrupt bits that accumulated between
+		 * MQI setup and now (e.g. CMH eSW processing stale
+		 * commands) before enabling the mask.
+		 */
+		stale = cmh_reg_read32(cfg->mailboxes[i].reg_base,
+				       R_MBX_INTERRUPT);
+		if (stale)
+			cmh_reg_write32(stale, cfg->mailboxes[i].reg_base,
+					R_MBX_INTERRUPT);
+
+		cmh_reg_write32(MBX_IRQ_MASK,
+				cfg->mailboxes[i].reg_base,
+				R_MBX_INTERRUPT_MASK);
+	}
+
+	dev_info(cmh_dev(), "rh: initialized (%u IRQs, %u mailboxes, watchdog %u ms)\n",
+		 rh.nirqs, cfg->mbx_count, watchdog_ms);
+
+	/* Arm missed-IRQ watchdog timer */
+	timer_setup(&rh_watchdog, cmh_rh_watchdog_fn, 0);
+	mod_timer(&rh_watchdog, jiffies +
+		  msecs_to_jiffies(max(watchdog_ms,
+				       CMH_RH_WATCHDOG_MS_MIN)));
+
+	return 0;
+}
+
+/**
+ * cmh_rh_suspend() - Suspend the response handler
+ * @cfg: Device configuration
+ *
+ * Stop the watchdog timer and mask mailbox interrupts at the hardware
+ * level.  The IRQ handlers remain registered so that resume can
+ * re-enable them without re-requesting.
+ */
+void cmh_rh_suspend(struct cmh_config *cfg)
+{
+	u32 i;
+
+	if (!rh.active)
+		return;
+
+	/* Stop the watchdog before masking HW interrupts */
+	timer_delete_sync(&rh_watchdog);
+
+	/* Mask MBX interrupts at the hardware level */
+	for (i = 0; i < cfg->mbx_count; i++)
+		cmh_reg_write32(0, cfg->mailboxes[i].reg_base,
+				R_MBX_INTERRUPT_MASK);
+
+	/*
+	 * Ensure no threaded IRQ handler is still in-flight.
+	 * After masking, a handler may already have been scheduled.
+	 * synchronize_irq() waits for it to complete before we
+	 * proceed with suspend (which tears down TM state).
+	 */
+	for (i = 0; i < rh.nirqs; i++)
+		synchronize_irq(rh.irqs[i]);
+
+	rh.active = false;
+	dev_dbg(cmh_dev(), "rh: suspended\n");
+}
+
+/**
+ * cmh_rh_resume() - Resume the response handler after suspend
+ * @cfg: Device configuration
+ *
+ * Re-synchronize per-mailbox head tracking with hardware, clear stale
+ * interrupt bits accumulated during the power transition, re-enable
+ * mailbox completion interrupts, and re-arm the watchdog timer.
+ */
+void cmh_rh_resume(struct cmh_config *cfg)
+{
+	u32 i;
+
+	if (!rh.mbx || !cfg)
+		return;
+
+	/* Re-sync per-MBX head tracking with hardware */
+	for (i = 0; i < cfg->mbx_count; i++) {
+		u32 stale;
+
+		rh.mbx[i].last_head =
+			cmh_reg_read32(cfg->mailboxes[i].reg_base,
+				       R_MBX_QUEUE_HEAD);
+
+		/* W1C any stale interrupt bits from the power transition */
+		stale = cmh_reg_read32(cfg->mailboxes[i].reg_base,
+				       R_MBX_INTERRUPT);
+		if (stale)
+			cmh_reg_write32(stale, cfg->mailboxes[i].reg_base,
+					R_MBX_INTERRUPT);
+
+		/* Re-enable MBX completion interrupts */
+		cmh_reg_write32(MBX_IRQ_MASK, cfg->mailboxes[i].reg_base,
+				R_MBX_INTERRUPT_MASK);
+	}
+
+	rh.active = true;
+
+	/* Re-arm the watchdog */
+	mod_timer(&rh_watchdog, jiffies +
+		  msecs_to_jiffies(max(watchdog_ms,
+				       CMH_RH_WATCHDOG_MS_MIN)));
+	dev_dbg(cmh_dev(), "rh: resumed\n");
+}
+
+/**
+ * cmh_rh_cleanup() - Clean up the response handler
+ * @cfg: Device configuration
+ *
+ * Stop the watchdog timer, mask mailbox interrupts at the hardware
+ * level, release all registered IRQ handlers, and free per-mailbox
+ * tracking state.  Safe to call even if init was never completed.
+ */
+void cmh_rh_cleanup(struct cmh_config *cfg)
+{
+	if (rh.active) {
+		u32 i;
+
+		/* Cancel watchdog before disabling interrupts */
+		timer_delete_sync(&rh_watchdog);
+
+		/* Disable MBX interrupts before releasing handlers */
+		for (i = 0; i < cfg->mbx_count; i++)
+			cmh_reg_write32(0,
+					cfg->mailboxes[i].reg_base,
+					R_MBX_INTERRUPT_MASK);
+
+		/* Release all per-MBX IRQs */
+		for (i = 0; i < rh.nirqs; i++)
+			free_irq(rh.irqs[i], cfg);
+		dev_dbg(cmh_dev(), "rh: %u IRQs released\n", rh.nirqs);
+		rh.nirqs = 0;
+		rh.active = false;
+	}
+
+	dev_dbg(cmh_dev(), "rh: %u IRQs handled\n",
+		atomic_read(&rh.irq_count));
+
+	kfree(rh.mbx);
+	rh.mbx = NULL;
+
+	dev_info(cmh_dev(), "rh: cleaned up\n");
+}
+
+/* -- debugfs timeout accessor ------------------------------------------ */
+
+#ifdef CONFIG_CRYPTO_DEV_CMH_DEBUG
+/**
+ * cmh_rh_timeout_watchdog_ptr() - Return pointer to watchdog_ms for debugfs
+ *
+ * Exposes the Response Handler watchdog timeout for runtime tuning
+ * via debugfs config/ directory.
+ *
+ * Return: pointer to the static watchdog_ms variable.
+ */
+unsigned int *cmh_rh_timeout_watchdog_ptr(void) { return &watchdog_ms; }
+#endif
diff --git a/drivers/crypto/cmh/cmh_sysfs.c b/drivers/crypto/cmh/cmh_sysfs.c
new file mode 100644
index 000000000000..ab482a222167
--- /dev/null
+++ b/drivers/crypto/cmh/cmh_sysfs.c
@@ -0,0 +1,108 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2026 Cryptography Research, Inc. (CRI).
+ * CMH LKM -- sysfs Device Attributes
+ *
+ * Exposes hardware identity and status as read-only sysfs attributes
+ * under /sys/devices/platform/cmh/.  Wired via .dev_groups in the
+ * platform_driver struct -- the driver core creates and removes these
+ * automatically around .probe() / .remove().
+ *
+ * Because .dev_groups is used (not manual sysfs_create_group), the
+ * driver core guarantees that attributes are created after .probe()
+ * sets drvdata and removed before .remove() clears it.  Therefore
+ * platform_get_drvdata() cannot return NULL in any show callback and
+ * no NULL check is needed.  Same pattern as caam/ctrl.c and
+ * ccree/cc_sysfs.c.
+ */
+
+#include <linux/device.h>
+#include <linux/platform_device.h>
+#include <linux/sysfs.h>
+
+#include "cmh.h"
+#include "cmh_registers.h"
+#include "cmh_sysfs.h"
+
+static ssize_t fw_version_show(struct device *dev,
+			       struct device_attribute *attr, char *buf)
+{
+	struct cmh_device *cmh = platform_get_drvdata(to_platform_device(dev));
+	struct cmh_config *cfg = &cmh->config;
+
+	if (!cfg->sic_mapped)
+		return -ENODEV;
+
+	return sysfs_emit(buf, "0x%08x\n",
+			  cmh_reg_read32(cfg->sic_mapped, R_SIC_SW_VERSION));
+}
+static DEVICE_ATTR_RO(fw_version);
+
+static ssize_t hw_version_show(struct device *dev,
+			       struct device_attribute *attr, char *buf)
+{
+	struct cmh_device *cmh = platform_get_drvdata(to_platform_device(dev));
+	struct cmh_config *cfg = &cmh->config;
+
+	if (!cfg->sic_mapped)
+		return -ENODEV;
+
+	return sysfs_emit(buf, "0x%08x\n",
+			  cmh_reg_read32(cfg->sic_mapped, R_SIC_HW_VERSION0));
+}
+static DEVICE_ATTR_RO(hw_version);
+
+static ssize_t boot_status_show(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	struct cmh_device *cmh = platform_get_drvdata(to_platform_device(dev));
+	struct cmh_config *cfg = &cmh->config;
+
+	if (!cfg->sic_mapped)
+		return -ENODEV;
+
+	return sysfs_emit(buf, "0x%08x\n",
+			  cmh_reg_read32(cfg->sic_mapped, R_SIC_BOOT_STATUS));
+}
+static DEVICE_ATTR_RO(boot_status);
+
+static ssize_t mbx_available_show(struct device *dev,
+				  struct device_attribute *attr, char *buf)
+{
+	struct cmh_device *cmh = platform_get_drvdata(to_platform_device(dev));
+	struct cmh_config *cfg = &cmh->config;
+
+	if (!cfg->sic_mapped)
+		return -ENODEV;
+
+	return sysfs_emit(buf, "0x%08x\n",
+			  cmh_reg_read32(cfg->sic_mapped, R_SIC_MBX_AVAILABILITY));
+}
+static DEVICE_ATTR_RO(mbx_available);
+
+static ssize_t mbx_count_show(struct device *dev,
+			      struct device_attribute *attr, char *buf)
+{
+	struct cmh_device *cmh = platform_get_drvdata(to_platform_device(dev));
+
+	return sysfs_emit(buf, "%u\n", cmh->config.mbx_count);
+}
+static DEVICE_ATTR_RO(mbx_count);
+
+static struct attribute *cmh_sysfs_attrs[] = {
+	&dev_attr_fw_version.attr,
+	&dev_attr_hw_version.attr,
+	&dev_attr_boot_status.attr,
+	&dev_attr_mbx_available.attr,
+	&dev_attr_mbx_count.attr,
+	NULL,
+};
+
+static const struct attribute_group cmh_sysfs_group = {
+	.attrs = cmh_sysfs_attrs,
+};
+
+const struct attribute_group *cmh_sysfs_groups[] = {
+	&cmh_sysfs_group,
+	NULL,
+};
diff --git a/drivers/crypto/cmh/cmh_txn.c b/drivers/crypto/cmh/cmh_txn.c
new file mode 100644
index 000000000000..3c696a8baac5
--- /dev/null
+++ b/drivers/crypto/cmh/cmh_txn.c
@@ -0,0 +1,1978 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2026 Cryptography Research, Inc. (CRI).
+ * CMH LKM -- Transaction Manager
+ *
+ * Dedicated kthread that dequeues command messages, builds VCQs in
+ * DMA queue slots, and rings the MBX doorbell.
+ *
+ * Command flow:
+ *   1. Caller posts command_msg via cmh_tm_post_command()
+ *   2. TM thread wakes, dequeues msg from CMQ
+ *   3. Selects mailbox (core-to-MBX affinity, or caller-pinned)
+ *   4. Copies pre-built VCQ entries into DMA slot at tail
+ *   5. Creates transaction_obj, appends to per-MBX txn queue
+ *   6. Writes tail+1 -> R_MBX_QUEUE_TAIL (doorbell)
+ *
+ * The Response Handler (cmh_rh.c) walks per-MBX txn queues
+ * when an IRQ fires and the head advances, firing completion callbacks.
+ *
+ * Transaction state machine
+ * -------------------------
+ * Each async transaction moves through the following states.  DMA
+ * buffers remain mapped and owned by the HW until the COMPLETE state
+ * is reached -- only then are they safe to unmap/free.
+ *
+ *   QUEUED --[TM posts to HW]--> INFLIGHT
+ *   (cmq)   |                       |      \
+ *          |                       |       \--[timer fires]-->
+ *          |                       |            TIMED_OUT
+ *          |                       |               |
+ *          |                  [HW completes /   [HW completes /
+ *          |                   RH pops txn]      RH pops txn]
+ *          |                       |               |
+ *          |                       v               v
+ *          |                    COMPLETE        COMPLETE
+ *          |                   (err=HW rc)    (err=-ETIMEDOUT)
+ *          |
+ *          +--[pre-submit fail]--> freed (callback never fires)
+ *
+ * Note: QUEUED is the command_msg phase (sitting in the CMQ list,
+ * not yet a transaction_obj).  The transaction_obj states tracked
+ * by atomic_cmpxchg are INFLIGHT, TIMED_OUT, and COMPLETE only.
+ *
+ * Completion callback context guarantee:
+ *   The crypto_request_complete() callback is invoked from one of:
+ *     - The RH threaded IRQ handler (process context, BH disabled)
+ *     - The watchdog timer (softirq / timer context)
+ *     - The TM kthread during queue drain/cleanup (process context)
+ *
+ *   It is NEVER invoked from hardirq context.
+ *
+ *   The watchdog path runs from timer softirq because it must recover
+ *   missed IRQs without sleeping.  This is crypto-API-compliant:
+ *   crypto_request_complete() is documented safe from any context
+ *   (including softirq).  Callers must NOT assume process context in
+ *   their completion callbacks -- all operations therein must be
+ *   softirq-safe (no mutex, no GFP_KERNEL, no sleeping locks).
+ *
+ *   For backlog promotion (-EINPROGRESS callbacks), the callback runs
+ *   under the CMQ spinlock with IRQs disabled -- callers must handle
+ *   this per the crypto API backlog contract.
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/kthread.h>
+#include <linux/slab.h>
+#include <linux/delay.h>
+#include <linux/io.h>
+#include <linux/iopoll.h>
+#include <linux/string.h>
+#include <linux/completion.h>
+#include <linux/overflow.h>
+#include <linux/refcount.h>
+
+#include "cmh_txn.h"
+#include "cmh_rh.h"
+#include "cmh_registers.h"
+#include "cmh_config.h"
+#include "cmh_vcq.h"
+#include "cmh_debugfs.h"
+#include "cmh_dma.h"
+
+/* Module State */
+
+static struct {
+	struct cmh_config      *cfg;
+	struct task_struct     *thread;
+	bool                    running;
+
+	/* Command Message Queue (CMQ) */
+	struct list_head        cmq;
+	spinlock_t              cmq_lock;   /* protects cmq + backlog lists */
+	wait_queue_head_t       cmq_waitq;
+
+	/* Backlog queue for CRYPTO_TFM_REQ_MAY_BACKLOG requests */
+	struct list_head        backlog;
+	u32                     backlog_depth;
+
+	/* Per-mailbox transaction queues */
+	struct cmh_mbx_txq     *txqs;       /* array[cfg->mbx_count] */
+
+	/* Round-robin mailbox selector */
+	u32                     next_mbx;
+} tm;
+
+static unsigned int cmq_max_depth = 256;
+module_param(cmq_max_depth, uint, 0444);
+MODULE_PARM_DESC(cmq_max_depth,
+		 "Max pending commands in the Command Message Queue (default: 256)");
+
+static unsigned int backlog_max_depth = 1024;
+module_param(backlog_max_depth, uint, 0444);
+MODULE_PARM_DESC(backlog_max_depth,
+		 "Max pending commands in the backlog queue (0 = disable backlog, default: 1024)");
+
+static unsigned int async_timeout_ms = 2000;
+
+#define CMH_TM_BACKOFF_MIN_US   100  /* queue-full backoff range (us) */
+#define CMH_TM_BACKOFF_MAX_US   500
+static unsigned int cmq_depth;       /* current CMQ depth, protected by tm.cmq_lock */
+
+/*
+ * Monotonically increasing counter bumped by cmh_tm_txq_completion_notify().
+ * Used as a generation check in the queue-full backoff predicate so that
+ * wait_event_interruptible_timeout() returns immediately when a TXQ
+ * completion frees a slot, rather than sleeping for the full timeout.
+ */
+static atomic_t txq_completion_gen;
+
+/* -- Debugfs stat helpers (avoid anonymous compound blocks) ------------- */
+
+static void cmh_stat_inc_mbx_queue_full(u32 mbx_idx)
+{
+	struct cmh_mbx_stats *s = cmh_debugfs_mbx_stats(mbx_idx);
+
+	if (s)
+		atomic64_inc(&s->queue_full_count);
+}
+
+static void cmh_stat_record_vcq_submit(u32 mbx_idx, u32 num_vcqs, u32 depth)
+{
+	struct cmh_mbx_stats *s = cmh_debugfs_mbx_stats(mbx_idx);
+
+	if (s) {
+		atomic64_add(num_vcqs, &s->vcqs_submitted);
+		cmh_stat_update_max(&s->max_queue_depth, (s64)depth);
+	}
+}
+
+static void cmh_stat_inc_tm_backoff(void)
+{
+	struct cmh_tm_stats *s = cmh_debugfs_tm_stats();
+
+	if (s)
+		atomic64_inc(&s->backoff_count);
+}
+
+static void cmh_stat_inc_cmq_eagain(void)
+{
+	struct cmh_tm_stats *s = cmh_debugfs_tm_stats();
+
+	if (s)
+		atomic64_inc(&s->cmq_eagain_count);
+}
+
+static void cmh_stat_record_cmq_post(u32 depth)
+{
+	struct cmh_tm_stats *s = cmh_debugfs_tm_stats();
+
+	if (s) {
+		atomic64_inc(&s->cmq_posts);
+		cmh_stat_update_max(&s->cmq_depth_max, (s64)depth);
+	}
+}
+
+static void cmh_stat_inc_async_timeout(void)
+{
+	struct cmh_tm_stats *s = cmh_debugfs_tm_stats();
+
+	if (s)
+		atomic64_inc(&s->async_timeout_count);
+}
+
+/*
+ * Drop one reference on a command_msg; free when the last ref is dropped.
+ * Used by cmh_tm_submit_sync() to share msg ownership between the
+ * waiter (caller) and the TM subsystem (thread or cleanup drain).
+ */
+static void command_msg_put(struct command_msg *msg)
+{
+	if (refcount_dec_and_test(&msg->refs)) {
+		kfree(msg->vcq_data);
+		kfree(msg);
+	}
+}
+
+/*
+ * Drop one reference on a transaction_obj; free when the last ref drops.
+ * Two references are held when the per-request timeout timer is armed:
+ * one for the TXQ owner (RH/cleanup), one for the timer callback.
+ * When no timer is armed, only the owner ref exists.
+ */
+static void txn_put(struct transaction_obj *txn)
+{
+	if (refcount_dec_and_test(&txn->refs))
+		kfree(txn);
+}
+
+/*
+ * Per-request async timeout callback (runs in softirq / timer context).
+ *
+ * This function ONLY marks the transaction state as TIMED_OUT via
+ * atomic cmpxchg and drops the timer reference.  It does NOT fire
+ * the completion callback, does NOT touch DMA buffers, and does NOT
+ * write any MBX registers.
+ *
+ * Rationale: the HW may still be writing to DMA buffers at this
+ * point.  Unmapping or freeing them here would be a use-after-free.
+ * The actual -ETIMEDOUT completion fires later, from process
+ * context, when the RH threaded IRQ pops the transaction after the
+ * HW finishes (or after MBX abort/drain on rmmod/suspend).
+ *
+ * MBX_COMMAND_ABORT is NOT issued here.  It is issued by the RH
+ * watchdog abort-stall detector under rh_process_lock, which
+ * serialises it against RESTART/FLUSH recovery commands.  Writing
+ * ABORT from timer softirq without the lock caused a race where
+ * concurrent timeouts clobbered an in-progress RESTART, wedging
+ * the mailbox.
+ *
+ * Context: softirq (timer).  Must not sleep.
+ */
+static void txn_timeout_fn(struct timer_list *t)
+{
+	struct transaction_obj *txn = timer_container_of(txn, t, timeout_timer);
+	int old;
+
+	old = atomic_cmpxchg(&txn->state, TXN_INFLIGHT, TXN_TIMED_OUT);
+	if (old == TXN_INFLIGHT) {
+		dev_err_ratelimited(cmh_dev(),
+				    "tm: async timeout vcq=%u..%u mbx=%u cmd_id=0x%08x\n",
+				    txn->first_vcq_id,
+				    txn->last_vcq_id, txn->mailbox_idx,
+				    txn->command_id);
+		cmh_stat_inc_async_timeout();
+	}
+
+	txn_put(txn); /* drop timer ref */
+}
+
+/**
+ * cmh_txn_finish() - Complete a popped transaction with FSM + timer cleanup
+ * @txn: Transaction object to complete
+ * @error: Error code from HW (0 on success)
+ *
+ * Three cases:
+ *   1. Normal: state INFLIGHT -> COMPLETE.  Fire callback with HW error.
+ *   2. Timed out: state already TXN_TIMED_OUT (timer marked it).
+ *      Fire callback with -ETIMEDOUT.  DMA is now safe because the
+ *      HW has finished and HEAD has advanced past this VCQ.
+ *   3. Force-cancel (drain/quiesce): handled by caller, not here.
+ */
+void cmh_txn_finish(struct transaction_obj *txn, int error)
+{
+	int old;
+
+	old = atomic_cmpxchg(&txn->state, TXN_INFLIGHT, TXN_COMPLETE);
+
+	/* Dequeue the timer if still pending; drop timer ref if we did */
+	if (timer_delete(&txn->timeout_timer))
+		txn_put(txn);
+
+	if (old == TXN_INFLIGHT) {
+		/* HW completion (may carry error) */
+		if (txn->complete)
+			txn->complete(txn->completion_data, error);
+	} else if (old == TXN_TIMED_OUT) {
+		/* Timer won earlier; now HW is done -- deliver -ETIMEDOUT */
+		if (txn->complete)
+			txn->complete(txn->completion_data, -ETIMEDOUT);
+	}
+
+	txn_put(txn); /* drop owner ref */
+}
+
+/* Mailbox Slot Addressing */
+
+/*
+ * Return a kernel-virtual pointer to the VCQ slot for the given vcqid.
+ * Mirrors CMH eSW's mbx_queue_addr() but uses the kernel virt_addr.
+ */
+static void *mbx_slot_ptr(struct cmh_mbx_config *mbx, u32 vcqid)
+{
+	u32 slot_mask = (1U << mbx->slots_log2) - 1U;
+	u32 slot_offset = (vcqid & slot_mask) << mbx->stride_log2;
+
+	return (u8 *)mbx->virt_addr + slot_offset;
+}
+
+/*
+ * Return the number of free slots in a mailbox queue.
+ */
+static u32 mbx_free_slots(struct cmh_mbx_config *mbx)
+{
+	u32 head = cmh_reg_read32(mbx->reg_base, R_MBX_QUEUE_HEAD);
+	u32 tail = cmh_reg_read32(mbx->reg_base, R_MBX_QUEUE_TAIL);
+	u32 size = 1U << mbx->slots_log2;
+
+	return size - (u32)(tail - head);
+}
+
+/**
+ * cmh_tm_max_cmds_per_vcq() - Return max commands per VCQ slot
+ *
+ * Scans all mailbox configurations and returns the minimum number of
+ * VCQ command entries that fit in a single slot, clamped to the
+ * MIN_VCQ_CMDS..MAX_VCQ_CMDS range.
+ *
+ * Return: Maximum usable VCQ command count per slot.
+ */
+u32 cmh_tm_max_cmds_per_vcq(void)
+{
+	u32 i, min_cmds = MAX_VCQ_CMDS;
+
+	for (i = 0; i < tm.cfg->mbx_count; i++) {
+		u32 stride = 1U << tm.cfg->mailboxes[i].stride_log2;
+		u32 cmds = stride / (u32)sizeof(struct vcq_cmd);
+
+		if (cmds < min_cmds)
+			min_cmds = cmds;
+	}
+
+	if (min_cmds < MIN_VCQ_CMDS)
+		min_cmds = MIN_VCQ_CMDS;
+
+	return min_cmds;
+}
+
+/**
+ * cmh_tm_mbx_count() - Return the number of configured mailboxes
+ *
+ * Return: Number of mailboxes in the current configuration.
+ */
+u32 cmh_tm_mbx_count(void)
+{
+	return tm.cfg->mbx_count;
+}
+
+/* Core-to-MBX Affinity -- Config-Driven Multi-Instance Support */
+
+/*
+ * Per-core-type configuration table.  Each entry holds one or more
+ * (core_id, mbx_idx) instances.  Defaults: single instance per core
+ * type with the standard CORE_ID_* and MBX auto-assigned on first use
+ * (mbx_idx = -1).  Module params can override for explicit assignment
+ * and multi-instance support.
+ *
+ * Round-robin across instances for each new crypto operation.
+ */
+
+struct core_instance_info {
+	u32		core_id;	/* VCQ dispatch core_id */
+	/*
+	 * Assigned MBX index, or -1 (sentinel) for auto-assign on first
+	 * use.  Uses atomic_t for a lockless once-only latch: the first
+	 * caller does atomic_cmpxchg(&mbx_idx, -1, new_mbx); all later
+	 * callers see the winning value via atomic_read().
+	 */
+	atomic_t	mbx_idx;
+};
+
+struct core_type_info {
+	u32		num_instances;
+	struct core_instance_info instances[CMH_MAX_CORE_INSTANCES];
+	atomic_t	next_instance;	/* round-robin counter */
+};
+
+static struct core_type_info core_types[CMH_NUM_CORE_TYPES] = {
+	[CMH_CORE_HC]  = { .num_instances = 1,
+	  .instances = { { .core_id = CORE_ID_HC,
+			   .mbx_idx = ATOMIC_INIT(-1) } } },
+	[CMH_CORE_AES] = { .num_instances = 1,
+	  .instances = { { .core_id = CORE_ID_AES,
+			   .mbx_idx = ATOMIC_INIT(-1) } } },
+	[CMH_CORE_SM4] = { .num_instances = 1,
+	  .instances = { { .core_id = CORE_ID_SM4,
+			   .mbx_idx = ATOMIC_INIT(-1) } } },
+	[CMH_CORE_SM3] = { .num_instances = 1,
+	  .instances = { { .core_id = CORE_ID_SM3,
+			   .mbx_idx = ATOMIC_INIT(-1) } } },
+	[CMH_CORE_CCP] = { .num_instances = 1,
+	  .instances = { { .core_id = CORE_ID_CCP,
+			   .mbx_idx = ATOMIC_INIT(-1) } } },
+	[CMH_CORE_PKE] = { .num_instances = 1,
+	  .instances = { { .core_id = CORE_ID_PKE,
+			   .mbx_idx = ATOMIC_INIT(-1) } } },
+	[CMH_CORE_QSE] = { .num_instances = 1,
+	  .instances = { { .core_id = CORE_ID_QSE,
+			   .mbx_idx = ATOMIC_INIT(-1) } } },
+	[CMH_CORE_HCQ] = { .num_instances = 1,
+	  .instances = { { .core_id = CORE_ID_HCQ,
+			   .mbx_idx = ATOMIC_INIT(-1) } } },
+};
+
+/* Round-robin counter for auto-assigning MBXes to core instances */
+static atomic_t affinity_next_mbx = ATOMIC_INIT(0);
+
+/**
+ * cmh_tm_affinity_reset() - Reset core-to-MBX affinity state
+ *
+ * Clears all auto-assigned MBX bindings and resets round-robin
+ * counters for both the global MBX allocator and per-core-type
+ * instance selectors.
+ */
+void cmh_tm_affinity_reset(void)
+{
+	u32 i, j;
+
+	atomic_set(&affinity_next_mbx, 0);
+
+	/* Reset multi-instance table */
+	for (i = 0; i < CMH_NUM_CORE_TYPES; i++) {
+		struct core_type_info *ct = &core_types[i];
+
+		atomic_set(&ct->next_instance, 0);
+		for (j = 0; j < ct->num_instances; j++)
+			atomic_set(&ct->instances[j].mbx_idx, -1);
+	}
+}
+
+/**
+ * cmh_core_default_id() - Return default core_id for a core type
+ * @type: Core type selector
+ *
+ * Returns the first-instance core_id for @type without advancing the
+ * round-robin counter.  Used by callers pinned to a fixed MBX (e.g.
+ * mgmt ioctls on MGMT_MBX) that only need the VCQ core_id field.
+ *
+ * Return: VCQ core_id value for the default instance of @type.
+ */
+u32 cmh_core_default_id(enum cmh_core_type type)
+{
+	if (WARN_ON_ONCE(type >= CMH_NUM_CORE_TYPES))
+		return 0;
+
+	return core_types[type].instances[0].core_id;
+}
+
+/**
+ * cmh_core_select_instance() - Select a core instance via round-robin
+ * @type: Core type selector
+ *
+ * Round-robin across configured instances, each permanently pinned to
+ * its MBX (auto-assigned on first use if mbx_idx was -1).
+ *
+ * Uses atomic_inc_return (pre-increment), so the very first call for a
+ * given type returns instance[1 % N].  Over the lifetime of the module
+ * the distribution is perfectly balanced; the off-by-one only affects
+ * the first cycle.
+ *
+ * The (u32) cast before the modulo ensures correct behaviour across
+ * the INT_MAX -> INT_MIN wraparound of atomic_t: (u32)INT_MIN =
+ * 0x80000000, and 0x80000000 % N still yields a valid index.
+ *
+ * Return: A core_dispatch with (core_id, mbx_idx) for the selected
+ *         instance.
+ */
+struct core_dispatch cmh_core_select_instance(enum cmh_core_type type)
+{
+	struct core_type_info *ct;
+	struct core_instance_info *inst;
+	struct core_dispatch d;
+	u32 idx, count;
+	s32 mbx, new_mbx, old;
+
+	if (WARN_ON_ONCE(type >= CMH_NUM_CORE_TYPES))
+		return (struct core_dispatch){ .core_id = 0, .mbx_idx = -1 };
+
+	ct = &core_types[type];
+	idx = (u32)atomic_inc_return(&ct->next_instance) % ct->num_instances;
+	inst = &ct->instances[idx];
+
+	d.core_id = inst->core_id;
+
+	mbx = atomic_read(&inst->mbx_idx);
+	if (mbx >= 0) {
+		d.mbx_idx = mbx;
+		return d;
+	}
+
+	/* Auto-assign on first use */
+	count = tm.cfg->mbx_count;
+	new_mbx = (s32)((u32)atomic_inc_return(&affinity_next_mbx) % count);
+	old = atomic_cmpxchg(&inst->mbx_idx, -1, new_mbx);
+
+	if (old >= 0) {
+		d.mbx_idx = old;
+	} else {
+		d.mbx_idx = new_mbx;
+		dev_info(cmh_dev(),
+			 "tm: core 0x%02x -> mbx %d (auto)\n",
+			 inst->core_id, new_mbx);
+	}
+
+	return d;
+}
+
+/**
+ * cmh_core_num_instances() - Return instance count for a core type
+ * @type: Core type selector
+ *
+ * Return: Number of configured instances for @type.
+ */
+u32 cmh_core_num_instances(enum cmh_core_type type)
+{
+	if (WARN_ON_ONCE(type >= CMH_NUM_CORE_TYPES))
+		return 1;
+
+	return core_types[type].num_instances;
+}
+
+/**
+ * cmh_core_get_instance() - Get dispatch info for a specific instance
+ * @type: Core type selector
+ * @idx: Instance index within @type
+ *
+ * Returns (core_id, mbx_idx) for a specific instance by index,
+ * without advancing the round-robin counter.  Triggers MBX auto-assign
+ * on first use if the instance has no MBX yet.
+ *
+ * Return: A core_dispatch with (core_id, mbx_idx) for instance @idx.
+ */
+struct core_dispatch cmh_core_get_instance(enum cmh_core_type type, u32 idx)
+{
+	struct core_type_info *ct;
+	struct core_instance_info *inst;
+	struct core_dispatch d;
+	u32 count;
+	s32 mbx, new_mbx, old;
+
+	if (WARN_ON_ONCE(type >= CMH_NUM_CORE_TYPES))
+		return (struct core_dispatch){ .core_id = 0, .mbx_idx = -1 };
+
+	ct = &core_types[type];
+	if (WARN_ON_ONCE(idx >= ct->num_instances))
+		return (struct core_dispatch){ .core_id = 0, .mbx_idx = -1 };
+
+	inst = &ct->instances[idx];
+	d.core_id = inst->core_id;
+
+	mbx = atomic_read(&inst->mbx_idx);
+	if (mbx >= 0) {
+		d.mbx_idx = mbx;
+		return d;
+	}
+
+	/* Auto-assign on first use */
+	count = tm.cfg->mbx_count;
+	new_mbx = (s32)((u32)atomic_inc_return(&affinity_next_mbx) % count);
+	old = atomic_cmpxchg(&inst->mbx_idx, -1, new_mbx);
+
+	if (old >= 0) {
+		d.mbx_idx = old;
+	} else {
+		d.mbx_idx = new_mbx;
+		dev_info(cmh_dev(),
+			 "tm: core 0x%02x -> mbx %d (auto)\n",
+			 inst->core_id, new_mbx);
+	}
+
+	return d;
+}
+
+/**
+ * cmh_tm_txq_completion_notify() - Wake TM thread after RH completion
+ *
+ * Wakes the TM thread after the Response Handler completes a
+ * transaction.  This unblocks the TM if it is waiting for a free MBX
+ * slot.  The generation counter bump ensures the wait_event predicate
+ * evaluates to true on the next check.
+ */
+void cmh_tm_txq_completion_notify(void)
+{
+	atomic_inc(&txq_completion_gen);
+	wake_up_interruptible(&tm.cmq_waitq);
+}
+
+/* Mailbox Selection */
+
+/*
+ * Select a mailbox with at least @slots_needed free slots (round-robin).
+ * Returns mailbox index, or -EAGAIN if no mailbox qualifies.
+ *
+ * Note: the free-slot check here is advisory -- actual slot availability
+ * is enforced by the ring arithmetic under dispatch_lock in submit_vcq().
+ * A TOCTOU gap exists between this check and the subsequent slot write,
+ * but it is safe: the worst case is a spurious -EAGAIN / backoff, never
+ * a ring overcommit.
+ */
+static int select_mailbox(u32 slots_needed)
+{
+	u32 count = tm.cfg->mbx_count;
+	u32 start = tm.next_mbx;
+	u32 i;
+
+	for (i = 0; i < count; i++) {
+		u32 idx = (start + i) % count;
+
+		if (cmh_rh_mbx_is_wedged(idx))
+			continue;
+
+		if (mbx_free_slots(&tm.cfg->mailboxes[idx]) >= slots_needed) {
+			tm.next_mbx = (idx + 1) % count;
+			return (int)idx;
+		}
+		cmh_stat_inc_mbx_queue_full(idx);
+	}
+
+	return -EAGAIN;
+}
+
+/*
+ * Resolve the target mailbox for a command message.
+ *
+ * If the message has a pinned MBX and it has enough free slots, use it.
+ * Otherwise fall back to round-robin selection.  Returns mailbox index,
+ * or -EAGAIN when no MBX has enough free slots or all are wedged.
+ */
+static int resolve_mbx(struct command_msg *msg)
+{
+	u32 slots = msg->num_vcqs > 0 ? msg->num_vcqs : 1;
+
+	if (msg->target_mbx >= 0 &&
+	    (u32)msg->target_mbx < tm.cfg->mbx_count) {
+		if (cmh_rh_mbx_is_wedged((u32)msg->target_mbx))
+			return -EAGAIN;
+		if (mbx_free_slots(&tm.cfg->mailboxes[msg->target_mbx]) >=
+		    slots)
+			return msg->target_mbx;
+		return -EAGAIN; /* pinned MBX full, retry */
+	}
+
+	return select_mailbox(slots);
+}
+
+/* VCQ Submission */
+
+/*
+ * Write VCQ(s) into consecutive DMA slots and ring the doorbell.
+ *
+ * A command_msg may carry one or more VCQs (num_vcqs field).  For a
+ * multi-VCQ message the flat vcq_data array contains N VCQs laid out
+ * contiguously, each starting with its own header whose cmds field
+ * gives that VCQ's entry count.  All VCQs are written to consecutive
+ * MBX slots and tracked by a single transaction_obj.
+ *
+ * Returns 0 on success, negative errno on failure.
+ */
+static int submit_vcq(struct command_msg *msg, u32 mbx_idx)
+{
+	struct cmh_mbx_config *mbx = &tm.cfg->mailboxes[mbx_idx];
+	struct cmh_mbx_txq *txq = &tm.txqs[mbx_idx];
+	struct transaction_obj *txn;
+	const struct vcq_cmd *cmds = msg->vcq_data;
+	u32 num_vcqs = msg->num_vcqs > 0 ? msg->num_vcqs : 1;
+	u32 tail, stride_bytes, offset = 0;
+	unsigned long flags;
+	u32 v;
+
+	mutex_lock(&txq->dispatch_lock);
+
+	/* Read current tail (first VCQ ID) */
+	tail = cmh_reg_read32(mbx->reg_base, R_MBX_QUEUE_TAIL);
+	stride_bytes = 1U << mbx->stride_log2;
+
+	/* Allocate transaction tracking object */
+	txn = kzalloc_obj(*txn, GFP_KERNEL);
+	if (!txn) {
+		mutex_unlock(&txq->dispatch_lock);
+		return -ENOMEM;
+	}
+
+	/* Write each VCQ into a consecutive DMA slot */
+	for (v = 0; v < num_vcqs; v++) {
+		u32 vcq_cmds, copy_size;
+		void *slot;
+
+		/*
+		 * For single-VCQ messages (backward compat) use the
+		 * msg-level vcq_count.  For multi-VCQ, parse the per-VCQ
+		 * header to find each VCQ's command count.
+		 */
+		if (num_vcqs == 1) {
+			vcq_cmds = msg->vcq_count;
+		} else {
+			const struct vcq_hdr *hdr =
+				(const struct vcq_hdr *)&cmds[offset].hwc;
+			vcq_cmds = hdr->cmds;
+		}
+
+		copy_size = vcq_cmds * sizeof(struct vcq_cmd);
+		if (copy_size > stride_bytes) {
+			dev_err(cmh_dev(), "tm: VCQ %u too large (%u bytes > stride %u)\n",
+				v, copy_size, stride_bytes);
+			mutex_unlock(&txq->dispatch_lock);
+			kfree(txn);
+			return -EMSGSIZE;
+		}
+
+		if (vcq_cmds < MIN_VCQ_CMDS || vcq_cmds > MAX_VCQ_CMDS) {
+			dev_err(cmh_dev(), "tm: invalid vcq_count %u (range %u..%u)\n",
+				vcq_cmds, MIN_VCQ_CMDS, MAX_VCQ_CMDS);
+			mutex_unlock(&txq->dispatch_lock);
+			kfree(txn);
+			return -EINVAL;
+		}
+
+		/* Copy pre-built VCQ into DMA slot */
+		slot = mbx_slot_ptr(mbx, tail + v);
+		cmh_dma_write(slot, &cmds[offset], copy_size);
+
+		/* Zero remaining slot bytes to avoid stale data */
+		if (copy_size < stride_bytes)
+			cmh_dma_zero((u8 *)slot + copy_size,
+				     stride_bytes - copy_size);
+
+		offset += vcq_cmds;
+	}
+
+	/* Ensure VCQ data is visible in memory before advancing tail */
+	wmb();
+	/* FPGA: confirm DRAM accepted writes before SIC doorbell (cross-slave) */
+	cmh_dma_fence(mbx_slot_ptr(mbx, tail + num_vcqs - 1));
+
+	/* Fill in transaction spanning all VCQs */
+	txn->first_vcq_id = tail;
+	txn->last_vcq_id = tail + num_vcqs - 1;
+	txn->mailbox_idx = mbx_idx;
+	txn->command_id = msg->command_id;
+	txn->error_code = 0;
+	txn->complete = msg->complete;
+	txn->completion_data = msg->completion_data;
+	atomic_set(&txn->state, TXN_INFLIGHT);
+	timer_setup(&txn->timeout_timer, txn_timeout_fn, 0);
+	INIT_LIST_HEAD(&txn->list);
+
+	/*
+	 * Set refcount: 2 if a per-txn timer will be armed (one ref for
+	 * the TXQ owner that pops it, one for the timer callback), or 1
+	 * if no timer (sync paths, or async_timeout_ms == 0).
+	 */
+	if (msg->timeout_jiffies)
+		refcount_set(&txn->refs, 2);
+	else
+		refcount_set(&txn->refs, 1);
+
+	/* Enqueue transaction under spinlock */
+	spin_lock_irqsave(&txq->lock, flags);
+	list_add_tail(&txn->list, &txq->head);
+	txq->depth++;
+	spin_unlock_irqrestore(&txq->lock, flags);
+
+	/* Ring doorbell: advance tail by number of VCQs submitted */
+	cmh_reg_write32(tail + num_vcqs, mbx->reg_base, R_MBX_QUEUE_TAIL);
+
+	/* Arm per-request timeout after doorbell (async only) */
+	if (msg->timeout_jiffies)
+		mod_timer(&txn->timeout_timer,
+			  jiffies + msg->timeout_jiffies);
+
+	mutex_unlock(&txq->dispatch_lock);
+
+	cmh_stat_record_vcq_submit(mbx_idx, num_vcqs, txq->depth);
+
+	dev_dbg(cmh_dev(), "tm: submitted %u vcq(s) id=%u..%u to mbx[%u] tail_now=%u\n",
+		num_vcqs, tail, tail + num_vcqs - 1, mbx_idx,
+		 tail + num_vcqs);
+
+	return 0;
+}
+
+/* TM Thread */
+
+static int cmh_tm_thread(void *data)
+{
+	struct command_msg *msg;
+	unsigned long flags;
+	int mbx_idx, ret;
+
+	dev_info(cmh_dev(), "tm: thread started\n");
+
+	while (!kthread_should_stop()) {
+		/* Wait for work or stop signal */
+		wait_event_interruptible(tm.cmq_waitq,
+					 !list_empty(&tm.cmq) || kthread_should_stop());
+
+		if (kthread_should_stop())
+			break;
+
+		/* Dequeue one command message */
+		spin_lock_irqsave(&tm.cmq_lock, flags);
+		if (list_empty(&tm.cmq)) {
+			spin_unlock_irqrestore(&tm.cmq_lock, flags);
+			continue;
+		}
+		msg = list_first_entry(&tm.cmq, struct command_msg, list);
+		list_del_init(&msg->list);
+		cmq_depth--;
+
+		/*
+		 * Promote one backlogged request into the CMQ now that
+		 * there is room.  Notify the crypto consumer with
+		 * -EINPROGRESS so it knows the request has left backlog.
+		 */
+		if (!list_empty(&tm.backlog)) {
+			struct command_msg *bl;
+
+			bl = list_first_entry(&tm.backlog,
+					      struct command_msg, list);
+			list_move_tail(&bl->list, &tm.cmq);
+			tm.backlog_depth--;
+			cmq_depth++;
+			cmh_stat_record_cmq_post(cmq_depth);
+			/*
+			 * Signal -EINPROGRESS while still under cmq_lock
+			 * so the consumer sees it before the final
+			 * completion.  The callback must be IRQ-safe
+			 * (required by the async contract anyway).
+			 */
+			if (bl->complete)
+				bl->complete(bl->completion_data,
+					     -EINPROGRESS);
+		}
+
+		spin_unlock_irqrestore(&tm.cmq_lock, flags);
+
+		/* Select a mailbox: pinned or round-robin */
+		mbx_idx = resolve_mbx(msg);
+
+		if (mbx_idx < 0) {
+			/*
+			 * Queue full -- re-enqueue at front and wait.
+			 *
+			 * Sleep on cmq_waitq with a short timeout.  The RH
+			 * calls cmh_tm_txq_completion_notify() after each
+			 * completed transaction, which bumps the generation
+			 * counter and wakes us immediately.  The timeout is
+			 * a safety net for missed wakeups.
+			 */
+			int gen = atomic_read(&txq_completion_gen);
+			unsigned long tmo;
+
+			spin_lock_irqsave(&tm.cmq_lock, flags);
+			list_add(&msg->list, &tm.cmq);
+			cmq_depth++;
+			spin_unlock_irqrestore(&tm.cmq_lock, flags);
+
+			tmo = usecs_to_jiffies(CMH_TM_BACKOFF_MAX_US);
+			wait_event_interruptible_timeout(tm.cmq_waitq,
+							 kthread_should_stop() ||
+							 atomic_read(&txq_completion_gen) != gen,
+							 tmo ?: 1);
+			cmh_stat_inc_tm_backoff();
+			continue;
+		}
+
+		/* Submit VCQ to selected mailbox */
+		WRITE_ONCE(msg->actual_mbx, mbx_idx);
+		ret = submit_vcq(msg, mbx_idx);
+		if (ret && msg->complete)
+			msg->complete(msg->completion_data, ret);
+		command_msg_put(msg);
+	}
+
+	dev_info(cmh_dev(), "tm: thread stopped\n");
+	return 0;
+}
+
+/* Public Interface */
+
+/**
+ * cmh_tm_init() - Initialize the Transaction Manager subsystem
+ * @cfg: Hardware configuration describing mailboxes and core types
+ *
+ * Allocates per-mailbox transaction queues, applies core-type
+ * configuration, and starts the TM kthread.
+ *
+ * Return: 0 on success, negative errno on failure.
+ */
+int cmh_tm_init(struct cmh_config *cfg)
+{
+	u32 i, j;
+
+	if (cmq_max_depth == 0) {
+		dev_warn(cmh_dev(),
+			 "tm: cmq_max_depth=0 invalid, clamping to 1\n");
+		cmq_max_depth = 1;
+	}
+
+	tm.cfg = cfg;
+	tm.next_mbx = 0;
+	cmq_depth = 0;
+
+	cmh_tm_affinity_reset();
+
+	/* Apply per-core-type config from DT child nodes */
+	for (i = 0; i < CMH_NUM_CORE_TYPES; i++) {
+		struct cmh_core_type_cfg *src = &cfg->core_types[i];
+		struct core_type_info *ct = &core_types[i];
+
+		ct->num_instances = src->num_instances;
+		for (j = 0; j < src->num_instances; j++) {
+			ct->instances[j].core_id = src->core_ids[j];
+			if (src->mbx[j] >= 0)
+				atomic_set(&ct->instances[j].mbx_idx,
+					   src->mbx[j]);
+		}
+	}
+
+	/* Initialize CMQ and backlog */
+	INIT_LIST_HEAD(&tm.cmq);
+	INIT_LIST_HEAD(&tm.backlog);
+	tm.backlog_depth = 0;
+	spin_lock_init(&tm.cmq_lock);
+	init_waitqueue_head(&tm.cmq_waitq);
+
+	/* Allocate per-mailbox transaction queues */
+	tm.txqs = kcalloc(cfg->mbx_count, sizeof(*tm.txqs), GFP_KERNEL);
+	if (!tm.txqs)
+		return -ENOMEM;
+
+	for (i = 0; i < cfg->mbx_count; i++) {
+		INIT_LIST_HEAD(&tm.txqs[i].head);
+		spin_lock_init(&tm.txqs[i].lock);
+		mutex_init(&tm.txqs[i].dispatch_lock);
+		tm.txqs[i].depth = 0;
+	}
+
+	/* Start TM thread */
+	tm.thread = kthread_run(cmh_tm_thread, NULL, "cmh_tm");
+	if (IS_ERR(tm.thread)) {
+		int ret = PTR_ERR(tm.thread);
+
+		dev_err(cmh_dev(), "tm: failed to start thread (rc=%d)\n", ret);
+		tm.thread = NULL;
+		kfree(tm.txqs);
+		tm.txqs = NULL;
+		return ret;
+	}
+
+	WRITE_ONCE(tm.running, true);
+	dev_info(cmh_dev(),
+		 "tm: initialized (%u mailboxes, cmq_depth=%u backlog=%u)\n",
+		 cfg->mbx_count, cmq_max_depth, backlog_max_depth);
+
+	return 0;
+}
+
+/*
+ * cmh_tm_stop_and_drain_cmq() - Stop TM thread and drain CMQ/backlog
+ *
+ * Shared preamble for cmh_tm_cleanup() and cmh_tm_quiesce(): stops the
+ * kthread, marks the TM as not running, then splices the CMQ and backlog
+ * to local lists and cancels every pending command_msg outside the lock.
+ */
+static void cmh_tm_stop_and_drain_cmq(void)
+{
+	struct command_msg *msg, *tmp_msg;
+	unsigned long flags;
+	LIST_HEAD(cmq_drain);
+	LIST_HEAD(backlog_drain);
+
+	if (tm.thread) {
+		kthread_stop(tm.thread);
+		tm.thread = NULL;
+	}
+	WRITE_ONCE(tm.running, false);
+
+	spin_lock_irqsave(&tm.cmq_lock, flags);
+	list_splice_init(&tm.cmq, &cmq_drain);
+	cmq_depth = 0;
+	list_splice_init(&tm.backlog, &backlog_drain);
+	tm.backlog_depth = 0;
+	spin_unlock_irqrestore(&tm.cmq_lock, flags);
+
+	list_for_each_entry_safe(msg, tmp_msg, &cmq_drain, list) {
+		list_del(&msg->list);
+		if (msg->complete)
+			msg->complete(msg->completion_data, -ECANCELED);
+		command_msg_put(msg);
+	}
+	list_for_each_entry_safe(msg, tmp_msg, &backlog_drain, list) {
+		list_del(&msg->list);
+		if (msg->complete)
+			msg->complete(msg->completion_data, -ECANCELED);
+		command_msg_put(msg);
+	}
+}
+
+/**
+ * cmh_tm_cleanup() - Tear down the Transaction Manager subsystem
+ *
+ * Stops the TM kthread, drains the CMQ, backlog, and all per-mailbox
+ * transaction queues, notifying waiters with -ECANCELED or -ETIMEDOUT.
+ * Frees all TM-owned resources.
+ */
+void cmh_tm_cleanup(void)
+{
+	struct transaction_obj *txn, *tmp_txn;
+	unsigned long flags;
+	u32 i;
+
+	cmh_tm_stop_and_drain_cmq();
+
+	/* Drain per-mailbox transaction queues */
+	if (tm.txqs) {
+		for (i = 0; i < tm.cfg->mbx_count; i++) {
+			LIST_HEAD(drain);
+			int old;
+
+			spin_lock_irqsave(&tm.txqs[i].lock, flags);
+			list_splice_init(&tm.txqs[i].head, &drain);
+			tm.txqs[i].depth = 0;
+			spin_unlock_irqrestore(&tm.txqs[i].lock, flags);
+
+			list_for_each_entry_safe(txn, tmp_txn, &drain, list) {
+				list_del(&txn->list);
+
+				if (timer_delete_sync(&txn->timeout_timer))
+					txn_put(txn);
+
+				old = atomic_cmpxchg(&txn->state,
+						     TXN_INFLIGHT,
+						     TXN_COMPLETE);
+				if (txn->complete) {
+					if (old == TXN_INFLIGHT)
+						txn->complete(txn->completion_data,
+							      -ECANCELED);
+					else if (old == TXN_TIMED_OUT)
+						txn->complete(txn->completion_data,
+							      -ETIMEDOUT);
+				}
+
+				txn_put(txn);
+			}
+		}
+		kfree(tm.txqs);
+		tm.txqs = NULL;
+	}
+
+	dev_info(cmh_dev(), "tm: cleaned up\n");
+}
+
+/*
+ * Default drain timeout for suspend/quiesce (milliseconds).
+ * Covers all symmetric + PKE operations.  PQC callers (SLH-DSA sign
+ * at up to 120 s) should complete before system suspend is requested.
+ */
+static unsigned int drain_timeout_ms = 10000;
+
+/**
+ * cmh_tm_quiesce() - Quiesce the TM for suspend or shutdown
+ *
+ * Stops the TM kthread, drains the CMQ and backlog, then waits up to
+ * drain_timeout_ms for in-flight transactions to complete via the
+ * Response Handler.  Any remaining transactions after the deadline
+ * are force-cancelled.
+ */
+void cmh_tm_quiesce(void)
+{
+	struct transaction_obj *txn, *tmp_txn;
+	unsigned long deadline;
+	unsigned long flags;
+	u32 i;
+	bool drained = true;
+
+	cmh_tm_stop_and_drain_cmq();
+
+	/* Wait for in-flight TXQ transactions to complete via RH */
+	if (!tm.txqs)
+		goto out;
+
+	deadline = jiffies + msecs_to_jiffies(drain_timeout_ms);
+	do {
+		drained = true;
+		for (i = 0; i < tm.cfg->mbx_count; i++) {
+			if (READ_ONCE(tm.txqs[i].depth)) {
+				drained = false;
+				break;
+			}
+		}
+		if (drained)
+			break;
+		usleep_range(1000, 2000);
+	} while (time_before(jiffies, deadline));
+
+	if (!drained) {
+		dev_warn(cmh_dev(),
+			 "tm: quiesce drain timeout (%u ms), cancelling remaining transactions\n",
+			 drain_timeout_ms);
+		for (i = 0; i < tm.cfg->mbx_count; i++) {
+			LIST_HEAD(drain);
+			int old;
+
+			spin_lock_irqsave(&tm.txqs[i].lock, flags);
+			list_splice_init(&tm.txqs[i].head, &drain);
+			tm.txqs[i].depth = 0;
+			spin_unlock_irqrestore(&tm.txqs[i].lock, flags);
+
+			list_for_each_entry_safe(txn, tmp_txn, &drain, list) {
+				list_del(&txn->list);
+
+				if (timer_delete_sync(&txn->timeout_timer))
+					txn_put(txn);
+
+				old = atomic_cmpxchg(&txn->state,
+						     TXN_INFLIGHT,
+						     TXN_COMPLETE);
+				if (txn->complete) {
+					if (old == TXN_INFLIGHT)
+						txn->complete(txn->completion_data,
+							      -ECANCELED);
+					else if (old == TXN_TIMED_OUT)
+						txn->complete(txn->completion_data,
+							      -ETIMEDOUT);
+				}
+
+				txn_put(txn);
+			}
+		}
+	}
+
+out:
+	dev_info(cmh_dev(), "tm: quiesced%s\n",
+		 drained ? "" : " (forced)");
+}
+
+/**
+ * cmh_tm_resume() - Resume the TM after suspend
+ *
+ * Restarts the TM kthread after a prior cmh_tm_quiesce().
+ *
+ * Return: 0 on success, negative errno if kthread creation fails.
+ */
+int cmh_tm_resume(void)
+{
+	if (tm.thread || !tm.cfg)
+		return 0;
+
+	tm.thread = kthread_run(cmh_tm_thread, NULL, "cmh_tm");
+	if (IS_ERR(tm.thread)) {
+		int ret = PTR_ERR(tm.thread);
+
+		dev_err(cmh_dev(), "tm: resume kthread_run failed (%d)\n",
+			ret);
+		tm.thread = NULL;
+		return ret;
+	}
+	WRITE_ONCE(tm.running, true);
+	dev_info(cmh_dev(), "tm: resumed\n");
+	return 0;
+}
+
+/**
+ * cmh_tm_try_cancel_command() - Cancel a queued command message
+ * @msg: Command message to cancel
+ *
+ * Attempts to remove @msg from the CMQ before the TM thread dequeues
+ * it.  Must be called while @msg is still valid (before the caller's
+ * stack frame that owns it is freed).
+ *
+ * Return: true if @msg was removed, false if already consumed by TM.
+ */
+bool cmh_tm_try_cancel_command(struct command_msg *msg)
+{
+	unsigned long flags;
+	bool cancelled = false;
+
+	spin_lock_irqsave(&tm.cmq_lock, flags);
+	if (!list_empty(&msg->list)) {
+		list_del_init(&msg->list);
+		cmq_depth--;
+		cancelled = true;
+	}
+	spin_unlock_irqrestore(&tm.cmq_lock, flags);
+
+	return cancelled;
+}
+
+/**
+ * cmh_tm_post_command() - Post a command message to the CMQ
+ * @msg: Pre-built command message to enqueue
+ *
+ * Enqueues @msg on the Command Message Queue and wakes the TM thread.
+ * If the CMQ is full, the message may be placed on the backlog queue
+ * (returning -EBUSY) if @msg->backlog_ok is set, or rejected with
+ * -EAGAIN.
+ *
+ * Return: 0 on success, -EBUSY if backlogged, -EAGAIN if full,
+ *         -ENODEV if TM is not running.
+ */
+int cmh_tm_post_command(struct command_msg *msg)
+{
+	unsigned long flags;
+
+	if (!READ_ONCE(tm.running))
+		return -ENODEV;
+
+	spin_lock_irqsave(&tm.cmq_lock, flags);
+	if (cmq_depth >= cmq_max_depth) {
+		if (msg->backlog_ok &&
+		    tm.backlog_depth < backlog_max_depth) {
+			list_add_tail(&msg->list, &tm.backlog);
+			tm.backlog_depth++;
+			spin_unlock_irqrestore(&tm.cmq_lock, flags);
+			return -EBUSY;
+		}
+		spin_unlock_irqrestore(&tm.cmq_lock, flags);
+		cmh_stat_inc_cmq_eagain();
+		return -EAGAIN;
+	}
+	INIT_LIST_HEAD(&msg->list);
+	list_add_tail(&msg->list, &tm.cmq);
+	cmq_depth++;
+	cmh_stat_record_cmq_post(cmq_depth);
+	spin_unlock_irqrestore(&tm.cmq_lock, flags);
+
+	wake_up_interruptible(&tm.cmq_waitq);
+	return 0;
+}
+
+/* Synchronous Submit (refcounted completion + timeout) */
+
+/*
+ * Heap-allocated sync context with refcounting.
+ *
+ * The completion callback may fire after the waiter has timed out and
+ * returned (e.g. during cmh_tm_cleanup on rmmod).  If the struct lived
+ * on the waiter's stack, the callback would touch freed memory --
+ * triggering a "BUG: spinlock bad magic" on the completion's spinlock.
+ *
+ * Two references are held: one by the waiter, one by the callback.
+ * Whichever runs last frees the struct.
+ */
+struct cmh_sync_ctx {
+	struct completion   done;
+	int                 error;
+	refcount_t          refs;   /* 2: waiter + callback */
+
+	/* Optional orphan cleanup -- called when the last ref drops after
+	 * the waiter abandoned an in-flight VCQ (noabort path).  Lets the
+	 * caller defer DMA-buffer cleanup until the eSW finishes writing.
+	 */
+	void (*orphan_cb)(void *data);
+	void *orphan_data;
+};
+
+static void cmh_sync_ctx_put(struct cmh_sync_ctx *ctx)
+{
+	if (refcount_dec_and_test(&ctx->refs)) {
+		if (ctx->orphan_cb)
+			ctx->orphan_cb(ctx->orphan_data);
+		kfree(ctx);
+	}
+}
+
+static void cmh_sync_complete(void *data, int error)
+{
+	struct cmh_sync_ctx *ctx = data;
+
+	ctx->error = error;
+	complete(&ctx->done);
+	cmh_sync_ctx_put(ctx);
+}
+
+/*
+ * Default VCQ completion timeout (milliseconds), tunable via debugfs
+ * config/vcq_timeout_ms.  Only affects the default timeout used by cmh_tm_submit_sync()
+ * and cmh_tm_submit_sync_mbx(); callers that pass an explicit timeout_hz
+ * (e.g. RSA keygen) are not affected.
+ */
+static unsigned int vcq_timeout_ms = 2000;
+
+/*
+ * Extended timeout for slow crypto operations: RSA keygen, PQC
+ * keygen/sign/verify.  Tunable via debugfs config/slow_op_timeout_ms.
+ */
+static unsigned int slow_op_timeout_ms = 300000;
+
+/**
+ * cmh_tm_submit_sync_tmo() - Synchronous VCQ submit with timeout
+ * @vcq_cmds: Array of pre-built VCQ command entries
+ * @vcq_count: Total number of entries in @vcq_cmds
+ * @num_vcqs: Number of VCQs packed in @vcq_cmds
+ * @target_mbx: Pinned mailbox index, or -1 for round-robin
+ * @timeout_hz: Completion timeout in jiffies
+ *
+ * Posts a VCQ command to the TM, waits for completion up to
+ * @timeout_hz.  On timeout, issues MBX_COMMAND_ABORT if the VCQ is
+ * already in-flight.  Must be called from process context.
+ *
+ * Return: 0 on success, -ETIMEDOUT, or negative errno.
+ */
+int cmh_tm_submit_sync_tmo(struct vcq_cmd *vcq_cmds, u32 vcq_count,
+			   u32 num_vcqs, s32 target_mbx,
+			   unsigned long timeout_hz)
+{
+	struct cmh_sync_ctx *sync;
+	struct command_msg *msg;
+	unsigned long left;
+	int ret;
+
+	/*
+	 * This path sleeps (GFP_KERNEL allocations + wait_for_completion)
+	 * and is not safe from atomic / non-sleepable contexts.  All
+	 * current callers run in process context (crypto API userspace or
+	 * ioctl), so this is never violated today.  Catch it loudly if
+	 * a future caller gets this wrong.
+	 */
+	WARN_ON_ONCE(!in_task());
+
+	sync = kzalloc_obj(*sync, GFP_KERNEL);
+	if (!sync)
+		return -ENOMEM;
+
+	msg = kzalloc_obj(*msg, GFP_KERNEL);
+	if (!msg) {
+		kfree(sync);
+		return -ENOMEM;
+	}
+
+	init_completion(&sync->done);
+	sync->error = 0;
+	refcount_set(&sync->refs, 2);  /* waiter + callback */
+
+	/*
+	 * Heap-copy the caller's VCQ array so the msg owns its data.
+	 * This decouples VCQ lifetime from the caller's stack frame,
+	 * which matters when the TM thread backs off (resolve_mbx
+	 * returns -1) and re-enqueues the msg after the caller's
+	 * wait_for_completion_timeout expires.
+	 */
+	msg->vcq_data = kmemdup(vcq_cmds, vcq_count * sizeof(*vcq_cmds),
+				GFP_KERNEL);
+	if (!msg->vcq_data) {
+		kfree(msg);
+		kfree(sync);
+		return -ENOMEM;
+	}
+
+	INIT_LIST_HEAD(&msg->list);
+	if (WARN_ON_ONCE(vcq_count < MIN_VCQ_CMDS)) {
+		ret = -EINVAL;
+		goto err_free;
+	}
+	msg->command_id = vcq_cmds[1].id;  /* first real command's ID */
+	msg->vcq_count  = vcq_count;
+	msg->num_vcqs   = num_vcqs;
+	msg->target_mbx = target_mbx;
+	msg->actual_mbx = -1;
+	msg->complete   = cmh_sync_complete;
+	msg->completion_data = sync;
+	refcount_set(&msg->refs, 2);       /* waiter + TM subsystem */
+
+	ret = cmh_tm_post_command(msg);
+	if (ret) {
+err_free:
+		kfree(msg->vcq_data);
+		kfree(msg);
+		kfree(sync);  /* callback will never fire */
+		return ret;
+	}
+
+	dev_dbg(cmh_dev(), "tm: submit_sync posted cmd 0x%08x, waiting...\n",
+		msg->command_id);
+
+	left = wait_for_completion_timeout(&sync->done, timeout_hz);
+	if (!left) {
+		dev_err(cmh_dev(),
+			"tm: submit_sync timeout (%lums) cmd=0x%08x\n",
+			timeout_hz * 1000 / HZ, msg->command_id);
+		if (cmh_tm_try_cancel_command(msg)) {
+			/*
+			 * Msg was still queued -- TM never saw it.
+			 * Drop the callback ref (no txn will fire it)
+			 * and free msg directly (sole owner).
+			 */
+			cmh_sync_ctx_put(sync);  /* no txn -> drop cb ref */
+			cmh_sync_ctx_put(sync);  /* drop waiter ref */
+			command_msg_put(msg);    /* matches refcount_set(2) */
+			command_msg_put(msg);
+		} else {
+			/*
+			 * TM has dequeued msg and the VCQ is in-flight.
+			 * Issue MBX_COMMAND_ABORT to force-stop the VCQ;
+			 * the RH will fire MBX_ERROR_IRQ, complete the
+			 * transaction with -EIO, and issue RESTART.
+			 *
+			 * cmh_rh_abort_mbx() serialises the write under
+			 * rh_process_lock, preventing clobber of a
+			 * concurrent RESTART/FLUSH from the watchdog.
+			 */
+			s32 abrt_mbx = READ_ONCE(msg->actual_mbx);
+
+			if (abrt_mbx >= 0 &&
+			    (u32)abrt_mbx < tm.cfg->mbx_count) {
+				dev_warn(cmh_dev(),
+					 "tm: aborting mbx[%d] cmd=0x%08x\n",
+					 abrt_mbx, msg->command_id);
+				cmh_rh_abort_mbx((u32)abrt_mbx);
+			}
+
+			/*
+			 * Wait for the RH completion (ABORT triggers
+			 * MBX_ERROR_IRQ within microseconds).  Fixed
+			 * 5 s ceiling -- not configurable because if
+			 * ABORT doesn't complete in this window the
+			 * HW is wedged and more waiting won't help.
+			 */
+			left = wait_for_completion_timeout(&sync->done,
+							   5 * HZ);
+			if (!left) {
+				/*
+				 * ABORT did not complete within 5 s -- HW
+				 * is wedged.  The eSW may still be writing
+				 * to DMA buffers owned by the caller, so we
+				 * cannot let the caller free them.  Transfer
+				 * ownership to the sync_ctx orphan mechanism;
+				 * the RH callback (if it ever fires) will
+				 * free via orphan_cb.  If it never fires, the
+				 * buffers leak -- acceptable for a wedged HW
+				 * path that should never occur in practice.
+				 */
+				dev_err(cmh_dev(),
+					"tm: abort timeout (5s) cmd=0x%08x - DMA buffers orphaned\n",
+					msg->command_id);
+			}
+			cmh_sync_ctx_put(sync);  /* drop waiter ref */
+			command_msg_put(msg);    /* drop waiter ref on msg */
+		}
+		return -ETIMEDOUT;
+	}
+
+	ret = sync->error;
+	cmh_sync_ctx_put(sync);  /* drop waiter ref */
+	command_msg_put(msg);    /* drop waiter ref on msg */
+	return ret;
+}
+
+/**
+ * cmh_tm_submit_sync_mbx() - Synchronous VCQ submit on a target MBX
+ * @vcq_cmds: Array of pre-built VCQ command entries
+ * @vcq_count: Total number of entries in @vcq_cmds
+ * @num_vcqs: Number of VCQs packed in @vcq_cmds
+ * @target_mbx: Pinned mailbox index, or -1 for round-robin
+ *
+ * Convenience wrapper around cmh_tm_submit_sync_tmo() using the
+ * default vcq_timeout_ms module parameter.
+ *
+ * Return: 0 on success, negative errno on failure.
+ */
+int cmh_tm_submit_sync_mbx(struct vcq_cmd *vcq_cmds, u32 vcq_count,
+			   u32 num_vcqs, s32 target_mbx)
+{
+	return cmh_tm_submit_sync_tmo(vcq_cmds, vcq_count, num_vcqs,
+				     target_mbx,
+				     msecs_to_jiffies(vcq_timeout_ms));
+}
+
+/**
+ * cmh_tm_async_timeout_jiffies() - Default async per-request timeout
+ *
+ * Return: Timeout in jiffies from the async_timeout_ms module param,
+ *         or 0 if async timeouts are disabled.
+ */
+unsigned long cmh_tm_async_timeout_jiffies(void)
+{
+	return async_timeout_ms ? msecs_to_jiffies(async_timeout_ms) : 0;
+}
+
+/**
+ * cmh_tm_slow_op_timeout_jiffies() - Timeout for slow crypto ops
+ *
+ * Returns the extended timeout used for RSA keygen, PQC keygen/sign,
+ * and similar long-running operations.
+ *
+ * Return: Timeout in jiffies from the slow_op_timeout_ms module param.
+ */
+unsigned long cmh_tm_slow_op_timeout_jiffies(void)
+{
+	return msecs_to_jiffies(slow_op_timeout_ms);
+}
+
+/**
+ * cmh_tm_submit_async() - Asynchronous VCQ submission
+ * @vcq_cmds: Array of pre-built VCQ command entries
+ * @vcq_count: Total number of entries in @vcq_cmds
+ * @num_vcqs: Number of VCQs packed in @vcq_cmds
+ * @target_mbx: Pinned mailbox index, or -1 for round-robin
+ * @callback: Completion callback (see context note below)
+ * @callback_data: Opaque data passed to @callback
+ * @backlog_ok: Allow backlogging if CMQ is full
+ * @timeout_jiffies: Per-request timeout (0 = no timeout)
+ *
+ * Builds a command_msg, heap-copies the VCQ data, and posts it to the
+ * CMQ via cmh_tm_post_command().
+ *
+ * Callback context guarantee:
+ *   The @callback may be invoked from one of:
+ *   - RH threaded IRQ handler (process context, BH disabled)
+ *   - RH watchdog timer (softirq / timer context)
+ *   - TM kthread if submit_vcq() fails post-dequeue
+ *   - cmh_tm_cleanup()/cmh_tm_quiesce() during drain (process context)
+ *   It is NEVER invoked from hardirq context.
+ *
+ *   Because the watchdog path runs from timer softirq, callbacks
+ *   MUST be safe in atomic/softirq context: no mutex, no GFP_KERNEL,
+ *   no sleeping locks.  crypto_request_complete() is safe (documented
+ *   callable from any context).  kfree_sensitive() and
+ *   scatterwalk_map_and_copy() are also safe (non-sleeping).
+ *   Callers must not assume thread affinity (callback may run on any CPU).
+ *
+ * Unlike the _sync variants, this function:
+ *   - Does NOT allocate a cmh_sync_ctx or wait for completion
+ *   - Uses GFP_ATOMIC for internal allocations because the crypto API
+ *     may call ->encrypt/->decrypt/->hash_final from softirq context
+ *     (e.g. network stack via IPsec/TLS); GFP_KERNEL would deadlock.
+ *
+ * The command_msg is single-owner (refcount 1) -- the TM subsystem
+ * owns it after post and frees it after dispatching to the HW.
+ *
+ * DMA buffer ownership: the caller transfers ownership to the callback
+ * on return of 0 or -EBUSY.  On any other return, the caller must
+ * clean up DMA buffers itself -- the callback will never fire.
+ *
+ * Return: 0 on successful post, -EBUSY if backlogged, -ENOMEM,
+ *         -EINVAL, -EAGAIN, or -ENODEV on failure.
+ */
+int cmh_tm_submit_async(struct vcq_cmd *vcq_cmds, u32 vcq_count,
+			u32 num_vcqs, s32 target_mbx,
+			cmh_completion_fn callback, void *callback_data,
+			bool backlog_ok, unsigned long timeout_jiffies)
+{
+	struct command_msg *msg;
+	int ret;
+
+	msg = kzalloc_obj(*msg, GFP_ATOMIC);
+	if (!msg)
+		return -ENOMEM;
+
+	msg->vcq_data = kmemdup(vcq_cmds,
+				array_size(vcq_count, sizeof(*vcq_cmds)),
+				GFP_ATOMIC);
+	if (!msg->vcq_data) {
+		kfree(msg);
+		return -ENOMEM;
+	}
+
+	INIT_LIST_HEAD(&msg->list);
+	if (WARN_ON_ONCE(vcq_count < MIN_VCQ_CMDS)) {
+		kfree(msg->vcq_data);
+		kfree(msg);
+		return -EINVAL;
+	}
+	msg->command_id      = vcq_cmds[1].id;
+	msg->vcq_count       = vcq_count;
+	msg->num_vcqs        = num_vcqs;
+	msg->target_mbx      = target_mbx;
+	msg->actual_mbx      = -1;
+	msg->complete        = callback;
+	msg->completion_data = callback_data;
+	msg->backlog_ok      = backlog_ok;
+	msg->timeout_jiffies = timeout_jiffies;
+	refcount_set(&msg->refs, 1);  /* sole owner: TM subsystem */
+
+	ret = cmh_tm_post_command(msg);
+	if (ret && ret != -EBUSY) {
+		kfree(msg->vcq_data);
+		kfree(msg);
+	}
+	return ret;
+}
+
+/**
+ * cmh_tm_submit_sync_noabort() - Sync submit without MBX abort on timeout
+ * @vcq_cmds: Array of pre-built VCQ command entries
+ * @vcq_count: Total number of entries in @vcq_cmds
+ * @num_vcqs: Number of VCQs packed in @vcq_cmds
+ * @timeout_hz: Completion timeout in jiffies
+ * @orphan_cb: Optional cleanup callback for abandoned DMA buffers
+ * @orphan_data: Opaque data passed to @orphan_cb
+ *
+ * On timeout, if the command was still queued it is cancelled and
+ * -EAGAIN is returned (caller may free all resources).  If the VCQ is
+ * already in-flight, the waiter drops its refs and returns -EINPROGRESS
+ * -- the RH callback will fire when the eSW finishes the VCQ and free
+ * the sync_ctx / msg via the refcount mechanism.
+ *
+ * @orphan_cb is invoked when the last ref on the sync_ctx drops after
+ * the waiter abandoned an in-flight VCQ, allowing the caller to defer
+ * DMA-buffer cleanup until the eSW finishes writing.
+ *
+ * This prevents a short-timeout command (e.g. DRBG GENERATE from the
+ * hwrng kthread) from aborting the entire MBX and killing unrelated
+ * long-running operations (e.g. SLH-DSA sign at 120 s).
+ *
+ * Return: 0 on success, -EAGAIN if cancelled from queue,
+ *         -EINPROGRESS if left in-flight, or negative errno.
+ */
+int cmh_tm_submit_sync_noabort(struct vcq_cmd *vcq_cmds, u32 vcq_count,
+			       u32 num_vcqs, unsigned long timeout_hz,
+			       void (*orphan_cb)(void *), void *orphan_data)
+{
+	struct cmh_sync_ctx *sync;
+	struct command_msg *msg;
+	unsigned long left;
+	int ret;
+
+	WARN_ON_ONCE(!in_task());
+
+	sync = kzalloc_obj(*sync, GFP_KERNEL);
+	if (!sync)
+		return -ENOMEM;
+
+	msg = kzalloc_obj(*msg, GFP_KERNEL);
+	if (!msg) {
+		kfree(sync);
+		return -ENOMEM;
+	}
+
+	init_completion(&sync->done);
+	sync->error = 0;
+	refcount_set(&sync->refs, 2);
+
+	INIT_LIST_HEAD(&msg->list);
+	if (WARN_ON_ONCE(vcq_count < MIN_VCQ_CMDS)) {
+		kfree(msg);
+		kfree(sync);
+		return -EINVAL;
+	}
+	msg->command_id = vcq_cmds[1].id;
+	msg->vcq_data = kmemdup(vcq_cmds, vcq_count * sizeof(*vcq_cmds),
+				GFP_KERNEL);
+	if (!msg->vcq_data) {
+		kfree(msg);
+		kfree(sync);
+		return -ENOMEM;
+	}
+	msg->vcq_count  = vcq_count;
+	msg->num_vcqs   = num_vcqs;
+	msg->target_mbx = -1;
+	msg->actual_mbx = -1;
+	msg->complete   = cmh_sync_complete;
+	msg->completion_data = sync;
+	refcount_set(&msg->refs, 2);
+
+	ret = cmh_tm_post_command(msg);
+	if (ret) {
+		kfree(msg->vcq_data);
+		kfree(msg);
+		kfree(sync);
+		return ret;
+	}
+
+	left = wait_for_completion_timeout(&sync->done, timeout_hz);
+	if (!left) {
+		if (cmh_tm_try_cancel_command(msg)) {
+			/* Still queued -- TM never saw it, clean up fully */
+			cmh_sync_ctx_put(sync);  /* drop cb ref */
+			cmh_sync_ctx_put(sync);  /* drop waiter ref */
+			command_msg_put(msg);    /* matches refcount_set(2) */
+			command_msg_put(msg);
+			return -EAGAIN;
+		}
+
+		/*
+		 * In-flight: skip ABORT.  Transfer orphan cleanup
+		 * ownership to sync_ctx -- the RH callback will
+		 * eventually complete this VCQ, and when the last
+		 * ref drops, orphan_cb frees any DMA buffers the
+		 * eSW was still writing to.
+		 */
+		dev_dbg_ratelimited(cmh_dev(),
+				    "tm: noabort timeout (%lums) cmd=0x%08x, leaving in-flight\n",
+				    timeout_hz * 1000 / HZ,
+				    msg->command_id);
+		sync->orphan_cb   = orphan_cb;
+		sync->orphan_data = orphan_data;
+		cmh_sync_ctx_put(sync);
+		command_msg_put(msg);
+		return -EINPROGRESS;
+	}
+
+	ret = sync->error;
+	cmh_sync_ctx_put(sync);
+	command_msg_put(msg);
+	return ret;
+}
+
+/**
+ * cmh_tm_submit_sync() - Synchronous VCQ submit with default timeout
+ * @vcq_cmds: Array of pre-built VCQ command entries
+ * @vcq_count: Total number of entries in @vcq_cmds
+ * @num_vcqs: Number of VCQs packed in @vcq_cmds
+ *
+ * Convenience wrapper: submits via round-robin MBX selection with the
+ * default vcq_timeout_ms.
+ *
+ * Return: 0 on success, negative errno on failure.
+ */
+int cmh_tm_submit_sync(struct vcq_cmd *vcq_cmds, u32 vcq_count,
+		       u32 num_vcqs)
+{
+	return cmh_tm_submit_sync_mbx(vcq_cmds, vcq_count, num_vcqs, -1);
+}
+
+#define MBX_FLUSH_TIMEOUT_MS	1000
+#define MBX_FLUSH_POLL_MIN_US	10
+#define MBX_FLUSH_POLL_MAX_US	50
+
+/**
+ * cmh_tm_flush_mbx() - Issue MBX_COMMAND_FLUSH and wait for completion
+ * @mbx_idx: Mailbox index to flush
+ *
+ * Resets the eSW child mailbox state: clears the VCQ command queue,
+ * resets head/tail, and -- critically -- resets the child temp stack
+ * via mbx_hdr_init() (sets hdr->temp back to &cmds[MAX_VCQ_CMDS]).
+ *
+ * Why this is needed:
+ *   KIC derivation commands that output to SYS_REF_TEMP allocate on the
+ *   per-MBX child temp LIFO stack (mbx_alloc_temp, each costing
+ *   ROUND_UP(len,4)+56 bytes).  These allocations persist across VCQ
+ *   completions because mbx_vcq_done() does NOT reset the temp stack.
+ *   Without an explicit flush, sequential KIC-TEMP ioctls exhaust the
+ *   ~960-byte temp area and subsequent derives fail with ENOMEM.
+ *
+ * What is NOT affected:
+ *   KIC HW keys, datastore objects, DRBG state -- these survive the
+ *   flush.  Only the queue pointers and temp stack are reset.
+ *
+ * Concurrency:
+ *   Acquires the per-MBX dispatch_lock mutex to serialise with VCQ
+ *   dispatch in submit_vcq().  This prevents the flush from resetting
+ *   head/tail while the TM kthread is writing a VCQ to a DMA slot on
+ *   the same MBX.  The eSW clears R_MBX_COMMAND to zero once the flush
+ *   completes.
+ *
+ * Return: 0 on success, -EINVAL, -ENODEV, -EBUSY, or -ETIMEDOUT.
+ */
+int cmh_tm_flush_mbx(s32 mbx_idx)
+{
+	struct cmh_mbx_config *mbx;
+	struct cmh_mbx_txq *txq;
+	void __iomem *base;
+	u32 reg;
+	int ret;
+
+	if (!tm.cfg || mbx_idx < 0 || (u32)mbx_idx >= tm.cfg->mbx_count)
+		return -EINVAL;
+
+	mbx = &tm.cfg->mailboxes[mbx_idx];
+	base = mbx->reg_base;
+	if (!base)
+		return -ENODEV;
+
+	txq = &tm.txqs[mbx_idx];
+	mutex_lock(&txq->dispatch_lock);
+
+	/* Ensure no command is already pending */
+	if (cmh_reg_read32(base, R_MBX_COMMAND) != 0) {
+		mutex_unlock(&txq->dispatch_lock);
+		return -EBUSY;
+	}
+
+	cmh_reg_write32(MBX_COMMAND_FLUSH, base, R_MBX_COMMAND);
+
+	/* Poll until eSW clears the command register */
+	ret = read_poll_timeout(cmh_reg_read32, reg, reg == 0,
+				MBX_FLUSH_POLL_MIN_US,
+				MBX_FLUSH_TIMEOUT_MS * 1000,
+				true, base, R_MBX_COMMAND);
+	if (ret)
+		dev_err(cmh_dev(), "mbx %u flush timeout (cmd=0x%08x)\n",
+			mbx->instance,
+			cmh_reg_read32(base, R_MBX_COMMAND));
+
+	mutex_unlock(&txq->dispatch_lock);
+	return ret;
+}
+
+/**
+ * cmh_vcq_pack_and_submit() - Pack payload into VCQs and submit sync
+ * @payload: Array of VCQ command entries (without headers)
+ * @count: Number of entries in @payload
+ * @packed: Caller-provided output buffer for packed VCQ data
+ * @max_packed: Size of @packed buffer in vcq_cmd entries
+ * @target_mbx: Pinned mailbox index, or -1 for round-robin
+ *
+ * Splits @payload into VCQ-sized chunks, prepends headers, and submits
+ * synchronously.
+ *
+ * Return: 0 on success, -EMSGSIZE if @packed is too small, or
+ *         negative errno from submit.
+ */
+int cmh_vcq_pack_and_submit(const struct vcq_cmd *payload, u32 count,
+			    struct vcq_cmd *packed, u32 max_packed,
+			    s32 target_mbx)
+{
+	u32 max_per_vcq = cmh_tm_max_cmds_per_vcq();
+	u32 max_payload_per = max_per_vcq - 1;
+	u32 num_vcqs = 0, total = 0, i = 0;
+
+	while (i < count) {
+		u32 chunk = min_t(u32, count - i, max_payload_per);
+		u32 vcq_cmds = chunk + 1;
+
+		if (total + vcq_cmds > max_packed)
+			return -EMSGSIZE;
+
+		vcq_set_header(&packed[total], vcq_cmds);
+		memcpy(&packed[total + 1], &payload[i],
+		       chunk * sizeof(struct vcq_cmd));
+
+		total += vcq_cmds;
+		i += chunk;
+		num_vcqs++;
+	}
+
+	return cmh_tm_submit_sync_mbx(packed, total, num_vcqs, target_mbx);
+}
+
+/**
+ * cmh_vcq_pack_and_submit_async() - Pack payload and submit async
+ * @payload: Array of VCQ command entries (without headers)
+ * @count: Number of entries in @payload
+ * @packed: Caller-provided output buffer for packed VCQ data
+ * @max_packed: Size of @packed buffer in vcq_cmd entries
+ * @target_mbx: Pinned mailbox index, or -1 for round-robin
+ * @callback: Completion callback
+ * @callback_data: Opaque data passed to @callback
+ * @backlog_ok: Allow backlogging if CMQ is full
+ * @timeout_jiffies: Per-request timeout (0 = no timeout)
+ *
+ * Asynchronous variant of cmh_vcq_pack_and_submit().  Splits @payload
+ * into VCQ-sized chunks, prepends headers, and submits via
+ * cmh_tm_submit_async().
+ *
+ * Return: 0 on success, -EBUSY if backlogged, -EMSGSIZE if @packed
+ *         is too small, or negative errno from submit.
+ */
+int cmh_vcq_pack_and_submit_async(const struct vcq_cmd *payload, u32 count,
+				  struct vcq_cmd *packed, u32 max_packed,
+				  s32 target_mbx,
+				  cmh_completion_fn callback,
+				  void *callback_data,
+				  bool backlog_ok,
+				  unsigned long timeout_jiffies)
+{
+	u32 max_per_vcq = cmh_tm_max_cmds_per_vcq();
+	u32 max_payload_per = max_per_vcq - 1;
+	u32 num_vcqs = 0, total = 0, i = 0;
+
+	while (i < count) {
+		u32 chunk = min_t(u32, count - i, max_payload_per);
+		u32 vcq_cmds = chunk + 1;
+
+		if (total + vcq_cmds > max_packed)
+			return -EMSGSIZE;
+
+		vcq_set_header(&packed[total], vcq_cmds);
+		memcpy(&packed[total + 1], &payload[i],
+		       chunk * sizeof(struct vcq_cmd));
+
+		total += vcq_cmds;
+		i += chunk;
+		num_vcqs++;
+	}
+
+	return cmh_tm_submit_async(packed, total, num_vcqs, target_mbx,
+				   callback, callback_data, backlog_ok,
+				   timeout_jiffies);
+}
+
+/**
+ * cmh_tm_peek_transaction() - Peek at the head of a mailbox TXQ
+ * @mbx_idx: Mailbox index to inspect
+ *
+ * Returns a pointer to the oldest in-flight transaction without
+ * removing it from the queue.  The caller must not free the returned
+ * object.
+ *
+ * Return: Pointer to the head transaction, or NULL if empty.
+ */
+struct transaction_obj *cmh_tm_peek_transaction(u32 mbx_idx)
+{
+	struct cmh_mbx_txq *txq;
+	struct transaction_obj *txn = NULL;
+	unsigned long flags;
+
+	if (!tm.txqs || mbx_idx >= tm.cfg->mbx_count)
+		return NULL;
+
+	txq = &tm.txqs[mbx_idx];
+
+	spin_lock_irqsave(&txq->lock, flags);
+	if (!list_empty(&txq->head))
+		txn = list_first_entry(&txq->head, struct transaction_obj,
+				       list);
+	spin_unlock_irqrestore(&txq->lock, flags);
+
+	return txn;
+}
+
+/**
+ * cmh_tm_pop_transaction() - Remove and return the head of a MBX TXQ
+ * @mbx_idx: Mailbox index to pop from
+ *
+ * Dequeues the oldest in-flight transaction from the per-mailbox
+ * transaction queue.  The caller takes ownership and must eventually
+ * call cmh_txn_finish() or txn_put().
+ *
+ * Return: Pointer to the dequeued transaction, or NULL if empty.
+ */
+struct transaction_obj *cmh_tm_pop_transaction(u32 mbx_idx)
+{
+	struct cmh_mbx_txq *txq;
+	struct transaction_obj *txn;
+	unsigned long flags;
+
+	if (!tm.txqs || mbx_idx >= tm.cfg->mbx_count)
+		return NULL;
+
+	txq = &tm.txqs[mbx_idx];
+
+	spin_lock_irqsave(&txq->lock, flags);
+	if (list_empty(&txq->head)) {
+		spin_unlock_irqrestore(&txq->lock, flags);
+		return NULL;
+	}
+	txn = list_first_entry(&txq->head, struct transaction_obj, list);
+	list_del_init(&txn->list);
+	txq->depth--;
+	spin_unlock_irqrestore(&txq->lock, flags);
+
+	return txn;
+}
+
+/* -- debugfs timeout accessors ----------------------------------------- */
+
+#ifdef CONFIG_CRYPTO_DEV_CMH_DEBUG
+/**
+ * cmh_tm_timeout_async_ptr() - Return pointer to async_timeout_ms for debugfs
+ *
+ * Return: pointer to the static async_timeout_ms variable.
+ */
+unsigned int *cmh_tm_timeout_async_ptr(void)    { return &async_timeout_ms; }
+
+/**
+ * cmh_tm_timeout_vcq_ptr() - Return pointer to vcq_timeout_ms for debugfs
+ *
+ * Return: pointer to the static vcq_timeout_ms variable.
+ */
+unsigned int *cmh_tm_timeout_vcq_ptr(void)      { return &vcq_timeout_ms; }
+
+/**
+ * cmh_tm_timeout_slow_op_ptr() - Return pointer to slow_op_timeout_ms for debugfs
+ *
+ * Return: pointer to the static slow_op_timeout_ms variable.
+ */
+unsigned int *cmh_tm_timeout_slow_op_ptr(void)  { return &slow_op_timeout_ms; }
+
+/**
+ * cmh_tm_timeout_drain_ptr() - Return pointer to drain_timeout_ms for debugfs
+ *
+ * Return: pointer to the static drain_timeout_ms variable.
+ */
+unsigned int *cmh_tm_timeout_drain_ptr(void)    { return &drain_timeout_ms; }
+#endif
diff --git a/drivers/crypto/cmh/include/cmh.h b/drivers/crypto/cmh/include/cmh.h
new file mode 100644
index 000000000000..18150ba39129
--- /dev/null
+++ b/drivers/crypto/cmh/include/cmh.h
@@ -0,0 +1,27 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2026 Cryptography Research, Inc. (CRI).
+ * CMH LKM -- Top-level Device Structure
+ */
+
+#ifndef CMH_H
+#define CMH_H
+
+#include <linux/device.h>
+
+#include "cmh_config.h"
+
+#define CMH_DRV_NAME   "cmh"
+#define CMH_VERSION    "1.0.0"
+
+/**
+ * struct cmh_device - Top-level driver state for a CMH hardware instance
+ * @config: Hardware configuration (core mappings, MBX layout, feature flags)
+ * @dev:    Platform or parent device used for DMA and logging
+ */
+struct cmh_device {
+	struct cmh_config       config;
+	struct device          *dev;
+};
+
+#endif /* CMH_H */
diff --git a/drivers/crypto/cmh/include/cmh_aes_abi.h b/drivers/crypto/cmh/include/cmh_aes_abi.h
new file mode 100644
index 000000000000..0b876dd67773
--- /dev/null
+++ b/drivers/crypto/cmh/include/cmh_aes_abi.h
@@ -0,0 +1,98 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2026 Cryptography Research, Inc. (CRI).
+ * CMH LKM -- AES Core ABI Definitions
+ *
+ * Kernel-side definitions for the CMH AES ABI.
+ * All constants and layouts derived from the CMH eSW ABI.
+ */
+
+#ifndef CMH_AES_ABI_H
+#define CMH_AES_ABI_H
+
+#include <linux/types.h>
+
+/* AES Block Size */
+
+#define CMH_AES_BLOCK_SIZE	16U
+#define CMH_AES_IV_SIZE		16U
+
+/* AES Modes (per CMH AES ABI) */
+
+#define AES_MODE_ECB		1U
+#define AES_MODE_CBC		2U
+#define AES_MODE_CTR		3U
+#define AES_MODE_CFB		4U
+#define AES_MODE_GCM		5U
+#define AES_MODE_CMAC		6U
+#define AES_MODE_CCM		7U
+#define AES_MODE_XTS		8U
+
+/* AES Operations (per CMH AES ABI) */
+
+#define AES_OP_DECRYPT		1U
+#define AES_OP_ENCRYPT		2U
+
+/* AES Command IDs */
+
+#define AES_CMD_INIT		0x01U
+#define AES_CMD_AAD_UPDATE	0x02U
+#define AES_CMD_AAD_FINAL	0x03U
+#define AES_CMD_UPDATE		0x04U
+#define AES_CMD_FINAL		0x05U
+#define AES_CMD_SCATTERGATHER	0x06U
+#define AES_CMD_CCM_INIT	0x0AU
+#define AES_CMD_AAD_FINAL_AUTH	0x0EU
+
+/* AES Command Structures */
+
+struct aes_cmd_init {
+	u64 key;	/* datastore reference for the key */
+	u64 iv;		/* DMA address of the IV (or nonce in CCM) */
+	u32 keylen;	/* key length in bytes */
+	u32 ivlen;	/* IV length in bytes (0..16) */
+	u32 mode;	/* AES mode (AES_MODE_*) */
+	u32 op;		/* AES operation (AES_OP_*) */
+	u32 aadlen;	/* AAD length or 0 */
+	u32 iolen;	/* plaintext/ciphertext length */
+	u32 taglen;	/* tag length or 0 */
+	u32 xts_offset;	/* XTS block index j; 0 for the skcipher path */
+};
+
+struct aes_cmd_aad_final {
+	u64 data;	/* DMA address of AAD data */
+	u32 datalen;	/* AAD data length */
+};
+
+struct aes_cmd_aad_final_auth {
+	u64 data;	/* DMA address of final AAD data */
+	u32 datalen;	/* final AAD data length */
+	u64 tag;		/* DMA address of tag */
+	u32 taglen;	/* tag length */
+};
+
+struct aes_cmd_update {
+	u64 input;	/* DMA address of input data */
+	u64 output;	/* DMA address of output data */
+	u32 iolen;	/* input/output data length */
+};
+
+struct aes_cmd_final {
+	u64 input;	/* DMA address of last input data */
+	u64 output;	/* DMA address of last output data */
+	u64 tag;	/* DMA address of tag (AEAD only) */
+	u32 iolen;	/* last input/output data length */
+	u32 taglen;	/* tag length (AEAD only) */
+};
+
+/* AES Command Union */
+
+union aes_cmd {
+	struct aes_cmd_init		cmd_init;
+	struct aes_cmd_update		cmd_update;
+	struct aes_cmd_final		cmd_final;
+	struct aes_cmd_aad_final	cmd_aad_final;
+	struct aes_cmd_aad_final_auth	cmd_aad_final_auth;
+};
+
+#endif /* CMH_AES_ABI_H */
diff --git a/drivers/crypto/cmh/include/cmh_ccp_abi.h b/drivers/crypto/cmh/include/cmh_ccp_abi.h
new file mode 100644
index 000000000000..4e3eb9feaec9
--- /dev/null
+++ b/drivers/crypto/cmh/include/cmh_ccp_abi.h
@@ -0,0 +1,108 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2026 Cryptography Research, Inc. (CRI).
+ * CMH LKM -- CCP Core ABI Definitions
+ *
+ * Kernel-side definitions for the CMH CCP ABI.
+ * All constants and layouts derived from the CMH eSW ABI.
+ *
+ * The CCP core provides three modes:
+ *   - ChaCha20 stream cipher (skcipher)
+ *   - Poly1305 one-time authenticator (shash)
+ *   - ChaCha20-Poly1305 AEAD (RFC 7539)
+ */
+
+#ifndef CMH_CCP_ABI_H
+#define CMH_CCP_ABI_H
+
+#include <linux/types.h>
+
+/* CCP Block Sizes */
+
+#define CCP_CHACHA_BLOCK_SIZE	64U	/* ChaCha20 block = 512 bits */
+#define CCP_POLY_BLOCK_SIZE	16U	/* Poly1305 block = 128 bits */
+#define CCP_CTRNONCE_SIZE	16U	/* 4-byte LE counter + 12-byte nonce */
+#define CCP_POLY_KEY_SIZE	16U	/* r_key and s_key each 16 bytes */
+#define CCP_POLY_TAG_SIZE	16U	/* Poly1305 tag = 128 bits */
+#define CCP_CHACHA_CTR_LEN	4U	/* 32-bit counter */
+
+/* CCP Operations (per CMH CCP ABI) */
+
+#define CCP_OP_DECRYPT		1U
+#define CCP_OP_ENCRYPT		2U
+
+/* CCP Command IDs */
+
+#define CCP_CMD_CHACHA20_INIT	0x01U
+#define CCP_CMD_POLY1305_INIT	0x02U
+#define CCP_CMD_AEAD_INIT	0x03U
+#define CCP_CMD_AAD_UPDATE	0x04U
+#define CCP_CMD_AAD_FINAL	0x05U
+#define CCP_CMD_UPDATE		0x06U
+#define CCP_CMD_FINAL		0x07U
+#define CCP_CMD_SCATTERGATHER	0x08U
+/* CCP_CMD_FLUSH = VCQ_CMD_FLUSH (0xFF) -- defined in cmh_vcq.h */
+
+/* CCP Command Structures */
+
+struct ccp_cmd_chacha {
+	u64 key;		/* datastore reference for the key */
+	u64 ctrnonce;		/* DMA address of the 16-byte counter+nonce */
+	u32 keylen;		/* key length: 16 or 32 bytes */
+	u32 ctrnoncelen;	/* always 16 */
+	u32 ctrlen;		/* counter length: 4 bytes */
+	u32 op;			/* CCP_OP_ENCRYPT or CCP_OP_DECRYPT */
+};
+
+struct ccp_cmd_poly {
+	u64 rkey;		/* datastore reference for the r key */
+	u64 skey;		/* datastore reference for the s key */
+	u32 rkeylen;		/* always 16 */
+	u32 skeylen;		/* always 16 */
+};
+
+struct ccp_cmd_aead {
+	u64 key;		/* datastore reference for the key */
+	u64 ctrnonce;		/* DMA address of the 16-byte counter+nonce */
+	u32 keylen;		/* key length: 32 bytes */
+	u32 ctrnoncelen;	/* always 16 */
+	u32 op;			/* CCP_OP_ENCRYPT or CCP_OP_DECRYPT */
+};
+
+struct ccp_cmd_aad_update {
+	u64 aad;		/* DMA address of AAD data */
+	u32 aadlen;		/* AAD length (must be multiple of 16) */
+};
+
+struct ccp_cmd_aad_final {
+	u64 aad;		/* DMA address of last AAD data */
+	u32 aadlen;		/* last AAD length (any size) */
+};
+
+struct ccp_cmd_update {
+	u64 input;		/* DMA address of input data */
+	u64 output;		/* DMA address of output data */
+	u32 iolen;		/* input/output length */
+};
+
+struct ccp_cmd_final {
+	u64 input;		/* DMA address of last input data */
+	u64 output;		/* DMA address of last output data */
+	u64 tag;		/* DMA address of the 16-byte tag */
+	u32 iolen;		/* last input/output data length */
+	u32 taglen;		/* tag length (always 16) */
+};
+
+/* CCP Command Union */
+
+union ccp_cmd {
+	struct ccp_cmd_chacha	cmd_chacha;
+	struct ccp_cmd_poly	cmd_poly;
+	struct ccp_cmd_aead	cmd_aead;
+	struct ccp_cmd_aad_update cmd_aad_update;
+	struct ccp_cmd_aad_final cmd_aad_final;
+	struct ccp_cmd_update	cmd_update;
+	struct ccp_cmd_final	cmd_final;
+};
+
+#endif /* CMH_CCP_ABI_H */
diff --git a/drivers/crypto/cmh/include/cmh_config.h b/drivers/crypto/cmh/include/cmh_config.h
new file mode 100644
index 000000000000..6a9e629ed353
--- /dev/null
+++ b/drivers/crypto/cmh/include/cmh_config.h
@@ -0,0 +1,91 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2026 Cryptography Research, Inc. (CRI).
+ * CMH LKM -- Configuration Structures and Defaults
+ */
+
+#ifndef CMH_CONFIG_H
+#define CMH_CONFIG_H
+
+#include <linux/types.h>
+#include <linux/dma-mapping.h>
+
+#include "cmh_registers.h"
+#include "cmh_vcq.h"
+
+/* Limits */
+
+/*
+ * Max mailboxes the driver manages simultaneously.  The hardware address
+ * space supports CMH_MAX_MBX_INSTANCES (64) instance indices, but this
+ * compile-time constant caps how many the driver allocates DMA queues,
+ * IRQ slots, and per-transform cache entries for.  To manage more
+ * mailboxes (up to the HW max), increase this value and rebuild the LKM
+ * -- it cannot be changed via module parameters at runtime.
+ */
+#define CMH_MAX_CONFIGURED_MBX    16
+#define CMH_MAX_CORE_INSTANCES    8
+
+/* MBX setup parameter ranges (per CMH hardware specification) */
+#define CMH_MBX_SLOTS_LOG2_MIN        1
+#define CMH_MBX_SLOTS_LOG2_MAX        15
+#define CMH_MBX_STRIDE_LOG2_MIN       7
+#define CMH_MBX_STRIDE_LOG2_MAX       10
+
+/* Default Configuration Values */
+
+#define CMH_DEFAULT_MBX_COUNT         2
+#define CMH_DEFAULT_SLOTS_LOG2        5   /* 2^5 = 32 slots */
+#define CMH_DEFAULT_STRIDE_LOG2       7   /* 2^7 = 128 bytes per slot */
+#define CMH_DEFAULT_IRQ               (-1) /* polling mode */
+#define CMH_DEFAULT_FW_READY_TIMEOUT_MS  5000 /* 5s for mission mode */
+
+/* Per-Core-Type Instance Configuration */
+
+struct cmh_core_type_cfg {
+	u32	num_instances;
+	u32	core_ids[CMH_MAX_CORE_INSTANCES];
+	s32	mbx[CMH_MAX_CORE_INSTANCES]; /* -1 = auto-assign */
+};
+
+/* Per-Mailbox Configuration */
+
+struct cmh_mbx_config {
+	u32             instance;       /* 0-based MBX instance index (0..63) */
+	u32             slots_log2;     /* log2(slot count), range 1..15 */
+	u32             stride_log2;    /* log2(bytes per slot), range 7..10 */
+	u32             lock_val;       /* MBX lock token (non-zero while held) */
+	dma_addr_t      dma_handle;     /* DMA bus address from dma_alloc_coherent */
+	void           *virt_addr;      /* kernel virtual address of MBXQ buffer */
+	size_t          queue_size;     /* total queue buffer size in bytes */
+	void __iomem   *reg_base;       /* ioremap'd register base for this instance */
+};
+
+/* Global Device Configuration */
+
+struct cmh_config {
+	phys_addr_t                 sic_base;
+	size_t                      sic_size;
+	void __iomem               *sic_mapped;    /* ioremap'd SIC region */
+	struct device_node         *of_node;       /* DT node (may be NULL) */
+	u32                         mbx_count;
+	struct cmh_mbx_config       mailboxes[CMH_MAX_CONFIGURED_MBX];
+	int                         irq;           /* -1 = poll, else IRQ line */
+	unsigned int                fw_ready_timeout_ms; /* FW mission-mode timeout */
+	struct cmh_core_type_cfg    core_types[CMH_NUM_CORE_TYPES];
+};
+
+/* Module Parameter Interface */
+
+struct platform_device;
+
+/**
+ * cmh_config_init() - Populate config from module params and device-tree
+ * @cfg: Configuration structure to fill
+ * @pdev: Platform device (for DT properties and IRQ lookup)
+ *
+ * Return: 0 on success, negative errno on failure.
+ */
+int cmh_config_init(struct cmh_config *cfg, struct platform_device *pdev);
+
+#endif /* CMH_CONFIG_H */
diff --git a/drivers/crypto/cmh/include/cmh_debugfs.h b/drivers/crypto/cmh/include/cmh_debugfs.h
new file mode 100644
index 000000000000..abaa837470c5
--- /dev/null
+++ b/drivers/crypto/cmh/include/cmh_debugfs.h
@@ -0,0 +1,90 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2026 Cryptography Research, Inc. (CRI).
+ * CMH LKM -- debugfs Per-MBX and TM Counters
+ *
+ * Exposes diagnostic counters under /sys/kernel/debug/cmh/:
+ *
+ *   mbxN/vcqs_submitted      Total VCQs sent to MBX N
+ *   mbxN/vcqs_completed      Total completions received
+ *   mbxN/vcqs_errors         Total error completions
+ *   mbxN/queue_full_count    Times select_mailbox() skipped this MBX
+ *   mbxN/max_queue_depth     High-water mark of in-flight transactions
+ *
+ *   tm/cmq_posts             Total cmh_tm_post_command() calls
+ *   tm/cmq_depth_max         High-water mark of CMQ length
+ *   tm/cmq_eagain_count      Times CMQ was full (-EAGAIN)
+ *   tm/backoff_count         Times TM backed off (all MBX queues full)
+ *   tm/async_timeout_count   Async requests that timed out
+ *
+ * Counters are atomic64_t -- safe to read from any context.
+ * When CONFIG_CRYPTO_DEV_CMH_DEBUG is off, all functions become no-ops and the
+ * compiler eliminates the counter code entirely.
+ */
+
+#ifndef CMH_DEBUGFS_H
+#define CMH_DEBUGFS_H
+
+#include <linux/types.h>
+#include <linux/atomic.h>
+
+/* Per-Mailbox Statistics */
+
+struct cmh_mbx_stats {
+	atomic64_t vcqs_submitted;
+	atomic64_t vcqs_completed;
+	atomic64_t vcqs_errors;
+	atomic64_t queue_full_count;
+	atomic64_t max_queue_depth;
+};
+
+/* TM-Level Statistics */
+
+struct cmh_tm_stats {
+	atomic64_t cmq_posts;
+	atomic64_t cmq_depth_max;
+	atomic64_t cmq_eagain_count;
+	atomic64_t backoff_count;
+	atomic64_t async_timeout_count;
+};
+
+/**
+ * cmh_stat_update_max() - Atomically update a high-water mark counter
+ * @counter: atomic64_t counter to update
+ * @val: New candidate value
+ *
+ * Updates @counter to @val if @val exceeds the current maximum.
+ * Lock-free via atomic cmpxchg loop.
+ */
+static inline void cmh_stat_update_max(atomic64_t *counter, s64 val)
+{
+	s64 cur;
+
+	do {
+		cur = atomic64_read(counter);
+		if (val <= cur)
+			return;
+	} while (atomic64_cmpxchg(counter, cur, val) != cur);
+}
+
+/* Interface (stub when CONFIG_CRYPTO_DEV_CMH_DEBUG is off) */
+
+struct cmh_config;
+
+#ifdef CONFIG_CRYPTO_DEV_CMH_DEBUG
+
+int  cmh_debugfs_init(struct cmh_config *cfg);
+void cmh_debugfs_cleanup(void);
+
+struct cmh_mbx_stats *cmh_debugfs_mbx_stats(u32 mbx_idx);
+struct cmh_tm_stats  *cmh_debugfs_tm_stats(void);
+
+#else /* !CONFIG_CRYPTO_DEV_CMH_DEBUG */
+
+static inline int  cmh_debugfs_init(struct cmh_config *c) { return 0; }
+static inline void cmh_debugfs_cleanup(void) {}
+static inline struct cmh_mbx_stats *cmh_debugfs_mbx_stats(u32 i) { return NULL; }
+static inline struct cmh_tm_stats  *cmh_debugfs_tm_stats(void)   { return NULL; }
+
+#endif /* CONFIG_CRYPTO_DEV_CMH_DEBUG */
+#endif /* CMH_DEBUGFS_H */
diff --git a/drivers/crypto/cmh/include/cmh_dma.h b/drivers/crypto/cmh/include/cmh_dma.h
new file mode 100644
index 000000000000..7dd0d8311785
--- /dev/null
+++ b/drivers/crypto/cmh/include/cmh_dma.h
@@ -0,0 +1,219 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2026 Cryptography Research, Inc. (CRI).
+ * CMH LKM -- DMA Interface
+ *
+ * Platform-independent DMA operations for the CMH crypto accelerator.
+ * All functions are implemented in cmh_dma.c (standard kernel DMA API).
+ *
+ * Alternate backends may be linked in place of cmh_dma.c for
+ * non-standard platforms.  Such backends must implement the same
+ * symbol set and may use different allocation and mapping semantics
+ * (e.g. pool-based alloc/free instead of address translation).
+ */
+
+#ifndef CMH_DMA_H
+#define CMH_DMA_H
+
+#include <linux/dma-mapping.h>
+#include <linux/types.h>
+
+#include "cmh_vcq.h"
+
+struct platform_device;
+
+/**
+ * cmh_dma_init() - Initialize the DMA backend
+ * @pdev: Platform device (provides struct device for DMA ops)
+ *
+ * Called early in .probe().  The standard backend stores the device
+ * pointer; alternate backends may set up additional resources.
+ *
+ * Return: 0 on success, negative errno on failure.
+ */
+int cmh_dma_init(struct platform_device *pdev);
+
+/**
+ * cmh_dma_cleanup() - Tear down the DMA backend
+ *
+ * Called in .remove() and error paths.  Releases any resources
+ * allocated by cmh_dma_init().
+ */
+void cmh_dma_cleanup(void);
+
+/**
+ * cmh_dev() - Global device accessor
+ *
+ * Returns the struct device * associated with the platform_driver instance.
+ * Valid only between cmh_dma_init() and cmh_dma_cleanup().
+ *
+ * Return: Platform device pointer, or NULL outside lifecycle.
+ */
+struct device *cmh_dev(void);
+
+/* Streaming DMA map / unmap (short-lived per-request buffers) */
+
+dma_addr_t cmh_dma_map_single(void *buf, size_t size,
+			      enum dma_data_direction dir);
+void cmh_dma_unmap_single(dma_addr_t addr, size_t size,
+			  enum dma_data_direction dir);
+
+/*
+ * Sync a DMA_FROM_DEVICE buffer so the CPU sees device-written data.
+ *
+ * Required before reading *buf when SWIOTLB bounce buffering is active
+ * (e.g. arm64 without IOMMU): the device writes to the bounce buffer,
+ * not the original allocation, so the CPU must sync before access.
+ * On architectures without bounce buffers (e.g. rv64) this is a no-op.
+ *
+ * Call between cmh_tm_submit_sync() and the first CPU read of the buffer,
+ * while the mapping is still live (before cmh_dma_unmap_single).
+ */
+void cmh_dma_sync_for_cpu(dma_addr_t addr, size_t size,
+			  enum dma_data_direction dir);
+
+/*
+ * Sync a DMA_TO_DEVICE buffer so the device sees CPU-written data.
+ *
+ * Required after CPU writes to a mapped streaming buffer (e.g. SG
+ * descriptor arrays that need items_dma for .lli pointer calculation
+ * before content is written).  Must be called before the device reads.
+ */
+void cmh_dma_sync_for_device(dma_addr_t addr, size_t size,
+			     enum dma_data_direction dir);
+
+int cmh_dma_map_error(dma_addr_t addr);
+
+/* Coherent DMA alloc / free (long-lived MBX queue buffers) */
+
+void *cmh_dma_alloc(size_t size, dma_addr_t *handle, gfp_t gfp);
+void cmh_dma_free(size_t size, void *virt, dma_addr_t handle);
+
+/**
+ * cmh_dma_write() - Copy data into a DMA-allocated buffer
+ * @dst: Destination pointer (from cmh_dma_alloc)
+ * @src: Source kernel buffer
+ * @len: Number of bytes to copy
+ *
+ * Copies @len bytes from @src to @dst.  @dst must have been obtained
+ * from cmh_dma_alloc().  Abstracted to allow platforms with non-standard
+ * DMA buffer access semantics.
+ */
+void cmh_dma_write(void *dst, const void *src, size_t len);
+
+/**
+ * cmh_dma_fence() - Fence preceding writes to DMA-allocated memory
+ * @ptr: Any pointer into the region that was written
+ *
+ * Ensures all preceding CPU writes to DMA memory are committed to the
+ * target memory controller before subsequent MMIO register writes.
+ *
+ * Required on FPGA platforms where DMA memory and device control
+ * registers reside on different AXI slaves -- a CPU-side wmb() only
+ * orders store dispatch, not arrival at the target.  A read from the
+ * DMA memory slave forces the memory controller to serialize behind
+ * all preceding writes from this CPU before responding, guaranteeing
+ * the data is committed before the doorbell register write is issued.
+ *
+ * On standard DMA API platforms (cache-coherent), this is a no-op.
+ */
+void cmh_dma_fence(void *ptr);
+
+/**
+ * cmh_dma_zero() - Zero a DMA-allocated buffer
+ * @dst: Destination pointer (from cmh_dma_alloc)
+ * @len: Number of bytes to zero
+ */
+void cmh_dma_zero(void *dst, size_t len);
+
+/*
+ * CMH eSW scatter-gather chain -- built with proper DMA mappings.
+ *
+ * The CMH eSW DMAC walks a linked list of dma_scattergather_item
+ * descriptors.  Each .src is the DMA address of an input buffer;
+ * each .lli is the DMA address of the next descriptor (0 = end).
+ *
+ * The descriptor array uses streaming DMA (kmalloc + dma_map_single)
+ * so that cmh_dma_free_sg() is safe from any context -- including
+ * BH-disabled completion callbacks where dma_free_coherent's
+ * vunmap() path would crash on non-coherent architectures.
+ */
+
+/* Input descriptor for cmh_dma_build_sg() -- one per data buffer */
+struct cmh_dma_buf {
+	void *data;
+	u32   len;
+};
+
+/* Opaque handle returned by cmh_dma_build_sg(); pass to cmh_dma_free_sg() */
+struct cmh_sg_map {
+	struct dma_scattergather_item *items;	/* CPU virtual address */
+	dma_addr_t  items_dma;			/* DMA address (pass to GATHER cmd) */
+	size_t      items_size;			/* allocation size */
+	u32         count;
+	struct {
+		dma_addr_t dma;
+		u32        len;
+	} bufs[];				/* per-entry source DMA handles */
+};
+
+/**
+ * cmh_dma_build_sg() - Build a DMA-mapped CMH eSW SG chain
+ * @bufs: Array of kernel buffer descriptors (data pointer + length)
+ * @count: Number of entries in @bufs (must be > 0; returns NULL for 0)
+ * @gfp: Allocation flags (GFP_KERNEL or GFP_ATOMIC)
+ *
+ * Allocates a dma_scattergather_item chain using streaming DMA
+ * (kmalloc + dma_map_single), DMA-maps each source buffer, and
+ * links the descriptors.
+ * The returned cmh_sg_map->items_dma is the address to pass to
+ * vcq_add_hc_gather() (or any core's scatter-gather command).
+ *
+ * Caller contract:
+ *   - Each bufs[i].data must point to DMA-mappable memory (kmalloc,
+ *     page-allocated, or vmalloc with DMA support).  Stack buffers
+ *     are NOT safe.
+ *   - Each bufs[i].len must be > 0.
+ *   - The returned cmh_sg_map must remain alive (not freed) until
+ *     the hardware completes the scatter-gather operation.  Only then
+ *     may cmh_dma_free_sg() be called.
+ *   - There is no hardware-imposed limit on @count, but callers are
+ *     responsible for bounding it to avoid excessive DMA mappings.
+ *     In practice, hash uses <= 2 entries (partial + new data).
+ *
+ * Return: Opaque cmh_sg_map handle, or NULL on allocation/mapping failure.
+ */
+struct cmh_sg_map *cmh_dma_build_sg(const struct cmh_dma_buf *bufs, u32 count,
+				    gfp_t gfp);
+
+/**
+ * cmh_dma_free_sg() - Unmap all buffers and free the SG chain
+ * @sgm: Handle from cmh_dma_build_sg(), or NULL (no-op)
+ */
+void cmh_dma_free_sg(struct cmh_sg_map *sgm);
+
+/*
+ * Orphan-DMA context -- generic helper for the noabort submit path.
+ *
+ * When cmh_tm_submit_sync_noabort() times out with a VCQ still
+ * in-flight, the eSW will continue writing to DMA buffers after the
+ * caller returns.  Callers wrap their DMA state in this struct and
+ * pass cmh_dma_orphan_free as the orphan_cb -- the RH callback frees
+ * the mapping + buffer when the VCQ eventually completes.
+ *
+ * Drain guarantee: cmh_tm_cleanup() calls timer_delete_sync() on each
+ * TXN timeout timer and splices all TXQ entries before invoking their
+ * completion callbacks.  This ensures no orphan callback can race with
+ * or run after TM cleanup completes -- by that point every in-flight
+ * transaction has been force-completed and its orphan_cb invoked.
+ */
+struct cmh_dma_orphan {
+	void                    *buf;
+	dma_addr_t               addr;
+	size_t                   len;
+	enum dma_data_direction  dir;
+};
+
+void cmh_dma_orphan_free(void *data);
+
+#endif /* CMH_DMA_H */
diff --git a/drivers/crypto/cmh/include/cmh_drbg_abi.h b/drivers/crypto/cmh/include/cmh_drbg_abi.h
new file mode 100644
index 000000000000..d4cebfe83d4b
--- /dev/null
+++ b/drivers/crypto/cmh/include/cmh_drbg_abi.h
@@ -0,0 +1,67 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2026 Cryptography Research, Inc. (CRI).
+ * CMH LKM -- DRBG Core ABI Definitions
+ *
+ * Kernel-side definitions for the CMH DRBG ABI.
+ * All constants and layouts derived from the CMH eSW ABI.
+ */
+
+#ifndef CMH_DRBG_ABI_H
+#define CMH_DRBG_ABI_H
+
+#include <linux/types.h>
+
+/* DRBG Commands */
+
+#define DRBG_CMD_CONFIG         0x01U
+#define DRBG_CMD_GENERATE       0x02U
+#define DRBG_CMD_DATASTORE      0x03U
+#define DRBG_CMD_RESET          0x04U
+
+/* DRBG Entropy Ratio (per CMH DRBG ABI) */
+
+#define DRBG_ENTROPY_RATIO_ONE          0U
+#define DRBG_ENTROPY_RATIO_ONE_HALF     1U
+#define DRBG_ENTROPY_RATIO_ONE_THIRD    2U
+#define DRBG_ENTROPY_RATIO_ONE_FOURTH   3U
+
+/* DRBG Security Strength (per CMH DRBG ABI) */
+
+#define DRBG_SECURITY_STRENGTH_128      0x00U
+#define DRBG_SECURITY_STRENGTH_256      0x10U
+
+/* DRBG Personalization Data Length */
+
+#define DRBG_PADATA_LEN         16U
+
+/* DRBG Command Structures */
+
+struct drbg_cmd_config {
+	u32 entropy_ratio;      /* drbg_entropy_ratio value */
+	u32 security_strength;  /* drbg_security_strength value */
+	u8  padata[DRBG_PADATA_LEN];
+};
+
+struct drbg_cmd_generate {
+	u64 dst;                /* DMA physical address for output */
+	u32 len;                /* requested output length in bytes */
+	u8  padata[DRBG_PADATA_LEN];
+};
+
+struct drbg_cmd_datastore {
+	u64 ref;                /* datastore reference */
+	u32 len;                /* data length in bytes */
+	u32 type;               /* datastore type */
+	u8  padata[DRBG_PADATA_LEN];
+};
+
+/* DRBG Command Union */
+
+union drbg_cmd {
+	struct drbg_cmd_config    cmd_config;
+	struct drbg_cmd_generate  cmd_generate;
+	struct drbg_cmd_datastore cmd_datastore;
+};
+
+#endif /* CMH_DRBG_ABI_H */
diff --git a/drivers/crypto/cmh/include/cmh_eac_abi.h b/drivers/crypto/cmh/include/cmh_eac_abi.h
new file mode 100644
index 000000000000..f0ebd3de1fb4
--- /dev/null
+++ b/drivers/crypto/cmh/include/cmh_eac_abi.h
@@ -0,0 +1,44 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2026 Cryptography Research, Inc. (CRI).
+ * CMH LKM -- EAC (Error and Alarm Controller) ABI Definitions
+ *
+ * Kernel-side definitions for the CMH EAC ABI.
+ * All constants and layouts derived from the CMH eSW ABI.
+ */
+
+#ifndef CMH_EAC_ABI_H
+#define CMH_EAC_ABI_H
+
+#include <linux/types.h>
+
+/* EAC Commands */
+
+#define EAC_CMD_READ		0x01U
+
+/* EAC Read Response -- eSW writes this to the DMA destination buffer */
+
+struct eac_read_rsp {
+	u64 mailbox_notification; /* bitmask: MBX that raised safety notif */
+	u32 hw_error;             /* bitmask: HWC that raised error */
+	u32 hw_nmi;               /* bitmask: HWC that raised NMI */
+	u32 hw_panic;             /* bitmask: HWC that raised HW panic */
+	u32 safety_fatal;         /* bitmask: HWC that raised fatal safety */
+	u32 safety_notification;  /* bitmask: HWC that raised safety notif */
+	u32 sw_info0;             /* eSW tracing information */
+	u32 sw_info1;             /* eSW tracing information */
+	u32 sram_bank_errors[4];  /* correctable ECC error counts per bank */
+};
+
+/* EAC Command Structures */
+
+struct eac_cmd_read {
+	u64 dst;	/* DMA destination for eac_read_rsp */
+	u32 len;	/* must be >= sizeof(struct eac_read_rsp) */
+};
+
+union eac_cmd {
+	struct eac_cmd_read cmd_read;
+};
+
+#endif /* CMH_EAC_ABI_H */
diff --git a/drivers/crypto/cmh/include/cmh_hc_abi.h b/drivers/crypto/cmh/include/cmh_hc_abi.h
new file mode 100644
index 000000000000..4e8c5ea3c69c
--- /dev/null
+++ b/drivers/crypto/cmh/include/cmh_hc_abi.h
@@ -0,0 +1,162 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2026 Cryptography Research, Inc. (CRI).
+ * CMH LKM -- Hash Core (HC) ABI Definitions
+ *
+ * Kernel-side definitions for the CMH HC (Hash Core) ABI.
+ * All constants and layouts derived from the CMH eSW ABI.
+ */
+
+#ifndef CMH_HC_ABI_H
+#define CMH_HC_ABI_H
+
+#include <linux/bits.h>
+#include <linux/types.h>
+
+/* HC Commands */
+
+#define HC_CMD_INIT             0x01U
+#define HC_CMD_HMAC             0x02U
+#define HC_CMD_UPDATE           0x03U
+#define HC_CMD_FINAL            0x04U
+#define HC_CMD_UPDATE2D         0x05U
+#define HC_CMD_SQUEEZE          0x07U
+#define HC_CMD_GATHER           0x08U
+#define HC_CMD_CSHAKE           0x09U
+#define HC_CMD_KMAC             0x0AU
+#define HC_CMD_SAVE             0x0BU
+#define HC_CMD_RESTORE          0x0CU
+
+/* HC Algorithms (per CMH HC ABI) */
+
+#define HC_ALGO_SHA2_224        1U
+#define HC_ALGO_SHA2_256        2U
+#define HC_ALGO_SHA2_384        3U
+#define HC_ALGO_SHA2_512        4U
+#define HC_ALGO_SHA3_224        5U
+#define HC_ALGO_SHA3_256        6U
+#define HC_ALGO_SHA3_384        7U
+#define HC_ALGO_SHA3_512        8U
+#define HC_ALGO_SHAKE128        9U
+#define HC_ALGO_SHAKE256        10U
+
+/* HC Algo Flags */
+
+#define HC_ALGO_FLAG_SCA_KEY    BIT(18)      /* SCA key in 2 shares */
+#define HC_ALGO_FLAG_SCA_OUT    BIT(19)      /* SCA output in 2 shares */
+
+#define HC_ALGO_SET(flags, algo)  (((flags) & 0xFF0000UL) | ((algo) & 0xFFUL))
+#define HC_ALGO_GET(algo)         ((algo) & 0xFFU)
+
+/* Hash Digest Sizes */
+
+#define CMH_SHA224_DIGEST_SIZE  28U
+#define CMH_SHA256_DIGEST_SIZE  32U
+#define CMH_SHA384_DIGEST_SIZE  48U
+#define CMH_SHA512_DIGEST_SIZE  64U
+
+/* SHA-3 digest sizes are the same as SHA-2 for matching output widths */
+#define CMH_SHA3_224_DIGEST_SIZE  28U
+#define CMH_SHA3_256_DIGEST_SIZE  32U
+#define CMH_SHA3_384_DIGEST_SIZE  48U
+#define CMH_SHA3_512_DIGEST_SIZE  64U
+
+/* SHAKE default output lengths (fixed-output ahash registration) */
+#define CMH_SHAKE128_DIGEST_SIZE  32U   /* 128-bit security -> 32 bytes */
+#define CMH_SHAKE256_DIGEST_SIZE  64U   /* 256-bit security -> 64 bytes */
+
+/* HC Context (for SAVE/RESTORE) */
+
+#define HC_CONTEXT_WORDS        149U
+#define HC_CONTEXT_SIZE         (HC_CONTEXT_WORDS * 4 + 4)  /* ctx[149] + crc */
+
+/* cSHAKE function name max length */
+
+#define HC_CSHAKE_MAX_NAMELEN   36U
+
+/*
+ * Maximum customization string (S) length for cSHAKE / KMAC.
+ *
+ * S is packed as inline VCQ data after the CSHAKE/KMAC command slot.
+ * The worst-case VCQ layout (KMAC with raw key + GATHER) uses 5 fixed
+ * slots out of CMH_KMAC_MAX_PAYLOAD (9), leaving 4 inline slots.
+ * Each VCQ slot is 64 bytes, so the safe limit is 4 * 64 = 256 bytes.
+ */
+#define HC_CSHAKE_MAX_CUSTOMLEN 256U
+
+/* HC Command Structures */
+
+struct hc_cmd_init {
+	u32 algo;       /* hc_algo value, optionally ORed with HC_ALGO_FLAG_* */
+};
+
+struct hc_cmd_hmac {
+	u64 key;        /* datastore reference for HMAC key */
+	u32 keylen;     /* key length in bytes */
+	u32 algo;       /* hc_algo value */
+};
+
+struct hc_cmd_update {
+	u64 input;      /* DMA physical address of input data */
+	u32 inlen;      /* input data length in bytes */
+};
+
+struct hc_cmd_final {
+	u64 digest;     /* DMA physical address for output digest */
+	u32 outlen;     /* digest length in bytes */
+};
+
+struct hc_cmd_update2d {
+	u64 input;      /* DMA source address for input data */
+	u64 output;     /* DMA destination address for pass-through data */
+	u32 iolen;      /* input/pass-through data length in bytes */
+};
+
+struct hc_cmd_gather {
+	u64 lista;      /* DMA address of dma_scattergather_item chain */
+	u32 sgcmd;      /* HC sub-command: HC_CMD_UPDATE or HC_CMD_UPDATE2D */
+};
+
+struct hc_cmd_cshake {
+	u64 custom;     /* DMA address for the customization string */
+	u32 customlen;  /* length of the customization string */
+	u32 algo;       /* HC_ALGO_SHAKE128 or HC_ALGO_SHAKE256 */
+	u32 namelen;    /* length of the function name string */
+	u8  name[HC_CSHAKE_MAX_NAMELEN]; /* function name string (inline) */
+};
+
+struct hc_cmd_kmac {
+	u64 key;        /* datastore reference for KMAC key */
+	u64 custom;     /* DMA address for the customization string */
+	u32 keylen;     /* key length in bytes */
+	u32 customlen;  /* length of the customization string */
+	u32 algo;       /* HC_ALGO_SHAKE128 or HC_ALGO_SHAKE256 */
+	u32 outlen;     /* requested output digest length */
+};
+
+struct hc_cmd_save {
+	u64 output;     /* DMA physical address for saved context */
+	u32 outlen;     /* must be HC_CONTEXT_SIZE */
+};
+
+struct hc_cmd_restore {
+	u64 input;      /* DMA physical address of saved context */
+	u32 inlen;      /* must be HC_CONTEXT_SIZE */
+};
+
+/* HC Command Union */
+
+union hc_cmd {
+	struct hc_cmd_init      cmd_init;
+	struct hc_cmd_hmac      cmd_hmac;
+	struct hc_cmd_cshake    cmd_cshake;
+	struct hc_cmd_kmac      cmd_kmac;
+	struct hc_cmd_update    cmd_update;
+	struct hc_cmd_final     cmd_final;
+	struct hc_cmd_update2d  cmd_update2d;
+	struct hc_cmd_gather    cmd_gather;
+	struct hc_cmd_save      cmd_save;
+	struct hc_cmd_restore   cmd_restore;
+};
+
+#endif /* CMH_HC_ABI_H */
diff --git a/drivers/crypto/cmh/include/cmh_hcq_abi.h b/drivers/crypto/cmh/include/cmh_hcq_abi.h
new file mode 100644
index 000000000000..b9fc2a80a408
--- /dev/null
+++ b/drivers/crypto/cmh/include/cmh_hcq_abi.h
@@ -0,0 +1,221 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2026 Cryptography Research, Inc. (CRI).
+ * CMH LKM -- HCQ Core ABI Definitions
+ *
+ * Kernel-side definitions for the CMH HCQ ABI.
+ * All constants and layouts derived from the CMH eSW ABI.
+ */
+
+#ifndef CMH_HCQ_ABI_H
+#define CMH_HCQ_ABI_H
+
+#include <linux/compiler_attributes.h>
+#include <linux/types.h>
+
+/* VCQ layout: header + [SYS cmds] + HCQ_CMD + [sys_read] + flush */
+#define HCQ_VCQ_CMDS_MIN	3	/* header + cmd + flush */
+#define HCQ_VCQ_CMDS_MAX	6	/* keygen: hdr+new+write+cmd+read+flush */
+
+/* HCQ Command IDs */
+#define HCQ_CMD_XMSS_VERIFY			0x03U
+#define HCQ_CMD_LMS_VERIFY			0x04U
+#define HCQ_CMD_SLHDSA_VERIFY_INTERNAL		0x05U
+#define HCQ_CMD_SLHDSA_VERIFY			0x06U
+#define HCQ_CMD_SLHDSA_VERIFY_PREHASH		0x07U
+#define HCQ_CMD_SLHDSA_VERIFY_PREHASH_DIGEST	0x08U
+#define HCQ_CMD_SLHDSA_KEYGEN			0x09U
+#define HCQ_CMD_SLHDSA_SIGN_INTERNAL		0x10U
+#define HCQ_CMD_SLHDSA_SIGN			0x11U
+#define HCQ_CMD_SLHDSA_SIGN_PREHASH		0x12U
+#define HCQ_CMD_SLHDSA_SIGN_PREHASH_DIGEST	0x13U
+#define HCQ_CMD_SLHDSA_PUBGEN			0x14U
+
+/* SLH-DSA Parameter Set IDs */
+#define HCQ_SLHDSA_SHAKE_128S	1U
+#define HCQ_SLHDSA_SHAKE_128F	2U
+#define HCQ_SLHDSA_SHAKE_192S	3U
+#define HCQ_SLHDSA_SHAKE_192F	4U
+#define HCQ_SLHDSA_SHAKE_256S	5U
+#define HCQ_SLHDSA_SHAKE_256F	6U
+#define HCQ_SLHDSA_SHA2_128S	7U
+#define HCQ_SLHDSA_SHA2_128F	8U
+#define HCQ_SLHDSA_SHA2_192S	9U
+#define HCQ_SLHDSA_SHA2_192F	10U
+#define HCQ_SLHDSA_SHA2_256S	11U
+#define HCQ_SLHDSA_SHA2_256F	12U
+#define HCQ_SLHDSA_PARAM_MAX	12U
+
+/* SLH-DSA Prehash Algorithm IDs */
+#define HCQ_SLHDSA_PREHASH_SHA256	1U
+#define HCQ_SLHDSA_PREHASH_SHA512	2U
+#define HCQ_SLHDSA_PREHASH_SHAKE128	3U
+#define HCQ_SLHDSA_PREHASH_SHAKE256	4U
+
+/* SLH-DSA size limits */
+#define SLHDSA_MAX_PK_SIZE	64U	/* 2*n, n=32 */
+#define SLHDSA_MAX_SK_SIZE	128U	/* 4*n, n=32 */
+#define SLHDSA_MAX_SEED_SIZE	96U	/* 3*n, n=32 */
+#define SLHDSA_MAX_SIG_SIZE	49856U	/* SHAKE-256f / SHA2-256f */
+#define SLHDSA_MAX_MSG_LEN	128U
+#define SLHDSA_MAX_CTX_LEN	255U
+
+/* LMS/HSS size limits -- derived from eSW HCQ ABI constraints */
+#define LMS_MAX_PK_LEN		60U	/* eSW public-key buffer */
+#define LMS_MAX_MSG_LEN		256U	/* SHS_LMS_MESSAGE_LEN_MAX */
+#define LMS_MAX_SIG_LEN		13364U	/* eSW signature buffer */
+
+/* XMSS/XMSS-MT size limits -- derived from eSW HCQ ABI constraints */
+#define XMSS_MAX_PK_LEN	136U	/* eSW public-key buffer */
+#define XMSS_MAX_MSG_LEN	64U	/* SHS_XMSS_MESSAGE_LEN_MAX */
+#define XMSS_MAX_SIG_LEN	27688U	/* eSW signature buffer */
+
+/* SLH-DSA n-value for each parameter set (index = param_set - 1) */
+extern const u32 slhdsa_n[];
+
+/* SLH-DSA signature sizes (index = param_set - 1) */
+extern const u32 slhdsa_sig_size[];
+
+/* Derive PK/SK/seed sizes from n */
+static inline u32 slhdsa_pk_size(u32 param_set)
+{
+	if (param_set < 1U || param_set > HCQ_SLHDSA_PARAM_MAX)
+		return 0;
+	return 2U * slhdsa_n[param_set - 1U];
+}
+
+static inline u32 slhdsa_sk_size(u32 param_set)
+{
+	if (param_set < 1U || param_set > HCQ_SLHDSA_PARAM_MAX)
+		return 0;
+	return 4U * slhdsa_n[param_set - 1U];
+}
+
+static inline u32 slhdsa_seed_size(u32 param_set)
+{
+	if (param_set < 1U || param_set > HCQ_SLHDSA_PARAM_MAX)
+		return 0;
+	return 3U * slhdsa_n[param_set - 1U];
+}
+
+static inline u32 slhdsa_get_sig_size(u32 param_set)
+{
+	if (param_set < 1U || param_set > HCQ_SLHDSA_PARAM_MAX)
+		return 0;
+	return slhdsa_sig_size[param_set - 1U];
+}
+
+/* HCQ Command Structures -- match CMH eSW ABI exactly */
+
+struct hcq_cmd_xmss_verify {
+	u32 xmss_mt;	/* 0 = XMSS, 1 = XMSS-MT */
+	u32 pk_len;
+	u32 sig_len;
+	u32 dig_len;
+	u64 pk;
+	u64 sig;
+	u64 dig;
+};
+
+struct hcq_cmd_lms_verify {
+	u32 lms_hss;	/* 0 = LMS, 1 = LMS-HSS */
+	u32 pk_len;
+	u32 sig_len;
+	u32 dig_len;
+	u64 pk;
+	u64 sig;
+	u64 dig;
+};
+
+struct hcq_cmd_slhdsa_verify_internal {
+	u32 parameter_set;
+	u32 message_len;
+	u64 message;
+	u64 pk;
+	u64 sig;
+};
+
+struct hcq_cmd_slhdsa_verify {
+	u32 parameter_set;
+	u32 message_len;
+	u64 message;
+	u64 context;
+	u64 pk;
+	u64 sig;
+	u32 context_len;
+};
+
+struct hcq_cmd_slhdsa_verify_prehash {
+	u32 parameter_set;
+	u32 prehash_algo;
+	u32 message_len;
+	u32 context_len;
+	u64 message;
+	u64 context;
+	u64 pk;
+	u64 sig;
+};
+
+struct hcq_cmd_slhdsa_keygen {
+	u32 parameter_set;
+	u32 seed_len;
+	u32 pk_len;
+	u32 sk_len;
+	u64 seed;	/* DS reference */
+	u64 pk;		/* extmem addr */
+	u64 sk;		/* DS reference */
+};
+
+struct hcq_cmd_slhdsa_sign_internal {
+	u32 parameter_set;
+	u32 message_len;
+	u64 add_random;	/* extmem addr, 0 = none */
+	u64 message;
+	u64 sk;		/* DS reference */
+	u64 sig;	/* extmem addr */
+};
+
+struct hcq_cmd_slhdsa_sign {
+	u32 parameter_set;
+	u32 message_len;
+	u64 add_random;
+	u64 message;
+	u64 context;
+	u64 sk;		/* DS reference */
+	u64 sig;	/* extmem addr */
+	u32 context_len;
+};
+
+struct hcq_cmd_slhdsa_sign_prehash {
+	u32 parameter_set;
+	u32 prehash_algo;
+	u32 message_len;
+	u32 context_len;
+	u64 add_random;
+	u64 message;
+	u64 context;
+	u64 sk;		/* DS reference */
+	u64 sig;	/* extmem addr */
+};
+
+struct hcq_cmd_slhdsa_pubgen {
+	u32 parameter_set;
+	u32 sk_len;
+	u64 sk;		/* DS reference */
+	u64 pk;		/* extmem addr */
+};
+
+union hcq_cmd {
+	struct hcq_cmd_xmss_verify		cmd_xmss_verify;
+	struct hcq_cmd_lms_verify		cmd_lms_verify;
+	struct hcq_cmd_slhdsa_verify_internal	cmd_slhdsa_verify_internal;
+	struct hcq_cmd_slhdsa_verify		cmd_slhdsa_verify;
+	struct hcq_cmd_slhdsa_verify_prehash	cmd_slhdsa_verify_prehash;
+	struct hcq_cmd_slhdsa_keygen		cmd_slhdsa_keygen;
+	struct hcq_cmd_slhdsa_sign_internal	cmd_slhdsa_sign_internal;
+	struct hcq_cmd_slhdsa_sign		cmd_slhdsa_sign;
+	struct hcq_cmd_slhdsa_sign_prehash	cmd_slhdsa_sign_prehash;
+	struct hcq_cmd_slhdsa_pubgen		cmd_slhdsa_pubgen;
+};
+
+#endif /* CMH_HCQ_ABI_H */
diff --git a/drivers/crypto/cmh/include/cmh_kic_abi.h b/drivers/crypto/cmh/include/cmh_kic_abi.h
new file mode 100644
index 000000000000..7f4fe3b9fd89
--- /dev/null
+++ b/drivers/crypto/cmh/include/cmh_kic_abi.h
@@ -0,0 +1,77 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2026 Cryptography Research, Inc. (CRI).
+ * CMH LKM -- KIC Core ABI Definitions
+ *
+ * Kernel-side definitions for the CMH KIC ABI (KIC commands only).
+ * Derived from the CMH eSW ABI.
+ */
+
+#ifndef CMH_KIC_ABI_H
+#define CMH_KIC_ABI_H
+
+#include <linux/types.h>
+
+/* KIC Commands */
+
+#define KIC_CMD_HKDF1		0x06U
+#define KIC_CMD_HKDF2		0x07U
+#define KIC_CMD_AES_CMAC_KDF	0x08U
+#define KIC_CMD_DKEK_DERIVE	0x09U
+
+/* Maximum key size for KIC operations (bytes) */
+#define KIC_KEY_SIZE		32U
+
+/*
+ * KIC Command Structures
+ *
+ * Field names (llen, len) mirror the CMH eSW ABI register layout.
+ * llen = label length, len = output key length.
+ */
+
+struct kic_cmd_hkdf1 {
+	u64 dst;	/* DS ref for derived key (SYS_REF_LAST) */
+	u64 base;	/* base key reference (e.g., KIC_KEY1) */
+	u64 label;	/* label pointer (0 for inline-next-slot) */
+	u32 llen;	/* label length */
+	u32 len;		/* output key length */
+	u32 type;	/* SYS_TYPE_SET(flags, core_id) */
+};
+
+struct kic_cmd_hkdf2 {
+	u64 dst;	/* DS ref for derived key */
+	u64 base;	/* base key reference */
+	u64 salt;	/* salt key reference (SYS_REF_NONE = no salt) */
+	u64 label;	/* label pointer */
+	u32 llen;	/* label length */
+	u32 len;		/* output key length */
+	u32 type;	/* SYS_TYPE_SET(flags, core_id) */
+};
+
+struct kic_cmd_aes_cmac_kdf {
+	u64 base_key;	/* KIC/DS reference for base key */
+	u64 out_key;	/* DS reference for derived key */
+	u64 label;	/* label DMA address */
+	u32 key_len;	/* base & output key length (must be 32) */
+	u32 label_len;	/* label length */
+	u32 type;	/* SYS_TYPE_SET(flags, core_id) for output */
+};
+
+struct kic_cmd_dkek_derive {
+	u64 base_key;		/* KIC base key reference */
+	u64 out_key;		/* DS reference for the derived KEK */
+	u32 host_id;		/* host ID (0 = caller's own) */
+	u32 metadata_len;	/* metadata length */
+	u64 metadata;		/* metadata DMA address */
+};
+
+/* KIC Command Union */
+
+union kic_cmd {
+	struct kic_cmd_hkdf1 cmd_hkdf1;
+	struct kic_cmd_hkdf2 cmd_hkdf2;
+	struct kic_cmd_aes_cmac_kdf cmd_aes_cmac_kdf;
+	struct kic_cmd_dkek_derive cmd_dkek_derive;
+};
+
+#endif /* CMH_KIC_ABI_H */
diff --git a/drivers/crypto/cmh/include/cmh_mqi.h b/drivers/crypto/cmh/include/cmh_mqi.h
new file mode 100644
index 000000000000..93b847859953
--- /dev/null
+++ b/drivers/crypto/cmh/include/cmh_mqi.h
@@ -0,0 +1,36 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2026 Cryptography Research, Inc. (CRI).
+ * CMH LKM -- Mailbox Queue Initializer
+ *
+ * Allocates DMA-capable queue buffers and programs MBX registers
+ * via the MBX lock/setup/enable/unlock register sequence.
+ */
+
+#ifndef CMH_MQI_H
+#define CMH_MQI_H
+
+#include "cmh_config.h"
+
+#define MBX_LOCK_TIMEOUT_MS     1000
+#define MBX_LOCK_POLL_MIN_US    10
+#define MBX_LOCK_POLL_MAX_US    50
+#define MBX_HOST_INFO_LKM       0x4C4B4D00U  /* "LKM\0" as host identifier */
+
+/**
+ * cmh_mqi_init() - Allocate MBX queue buffers and program registers
+ * @cfg: Global device configuration
+ *
+ * Performs the lock/setup/enable/unlock sequence for each configured MBX.
+ *
+ * Return: 0 on success, negative errno on failure.
+ */
+int cmh_mqi_init(struct cmh_config *cfg);
+
+/**
+ * cmh_mqi_cleanup() - Free MBX queue buffers and release locks
+ * @cfg: Global device configuration
+ */
+void cmh_mqi_cleanup(struct cmh_config *cfg);
+
+#endif /* CMH_MQI_H */
diff --git a/drivers/crypto/cmh/include/cmh_pke_abi.h b/drivers/crypto/cmh/include/cmh_pke_abi.h
new file mode 100644
index 000000000000..e0e7b946b4e3
--- /dev/null
+++ b/drivers/crypto/cmh/include/cmh_pke_abi.h
@@ -0,0 +1,272 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2026 Cryptography Research, Inc. (CRI).
+ * CMH LKM -- PKE Core ABI Definitions
+ *
+ * Kernel-side definitions for the CMH PKE ABI.
+ * All constants and layouts derived from the CMH eSW ABI.
+ */
+
+#ifndef CMH_PKE_ABI_H
+#define CMH_PKE_ABI_H
+
+#include <linux/types.h>
+
+/* PKE Command IDs */
+
+#define PKE_CMD_ECDSA_VERIFY		0x03U
+#define PKE_CMD_ECDSA_SIGN		0x04U
+#define PKE_CMD_ECDSA_PUBGEN		0x05U
+#define PKE_CMD_ECDSA_KEYGEN		0x06U
+#define PKE_CMD_EDDSA_VERIFY		0x07U
+#define PKE_CMD_EDDSA_SIGN		0x08U
+#define PKE_CMD_EDDSA_PUBGEN		0x09U
+#define PKE_CMD_ECDH_KEYGEN		0x0AU
+#define PKE_CMD_ECDH			0x0BU
+#define PKE_CMD_RSA_ENC			0x0CU
+#define PKE_CMD_RSA_DEC			0x0DU
+#define PKE_CMD_RSA_KEYGEN		0x0EU
+#define PKE_CMD_RSA_CRT_DEC		0x0FU
+#define PKE_CMD_SM2_ECDH_KEYGEN		0x16U
+#define PKE_CMD_SM2_ECDH		0x17U
+#define PKE_CMD_SM2_DEC_POINT		0x18U
+#define PKE_CMD_SM2_ENC_POINT		0x19U
+#define PKE_CMD_SM2_ID_DIGEST		0x1AU
+#define PKE_CMD_SM2_ECDH_HASH		0x1BU
+#define PKE_CMD_SM2_DEC_HASH		0x1CU
+#define PKE_CMD_SM2_ENC_HASH		0x1DU
+#define PKE_CMD_EDDSA_PRIV_KEYGEN_SCA	0x21U
+#define PKE_CMD_FLUSH			0xFFU
+
+/* EC Curve IDs (per CMH PKE ABI) */
+
+#define PKE_CURVE_P192			0x01U
+#define PKE_CURVE_P224			0x02U
+#define PKE_CURVE_P256			0x03U
+#define PKE_CURVE_P384			0x04U
+#define PKE_CURVE_P521			0x05U
+#define PKE_CURVE_SECP256K1		0x07U
+#define PKE_CURVE_BP192R1		0x11U
+#define PKE_CURVE_BP224R1		0x12U
+#define PKE_CURVE_BP256R1		0x13U
+#define PKE_CURVE_BP320R1		0x14U
+#define PKE_CURVE_BP384R1		0x15U
+#define PKE_CURVE_BP512R1		0x16U
+#define PKE_CURVE_ANSSI_FRP256V1	0x17U
+#define PKE_CURVE_SM2			0x18U
+#define PKE_CURVE_25519			0x21U
+#define PKE_CURVE_448			0x22U
+
+/* PKE Command Structures -- match CMH eSW ABI exactly */
+
+struct pke_cmd_ecdsa_verify {
+	u32 curve;
+	u32 digest_len;
+	u64 public_key;
+	u64 digest;
+	u64 signature;
+	u64 rprime;
+};
+
+struct pke_cmd_ecdsa_sign {
+	u32 curve;
+	u32 secret_key_len;
+	u64 digest;
+	u64 signature;
+	u64 secret_key;		/* DS reference */
+	u32 digest_len;
+};
+
+struct pke_cmd_ecdsa_pubgen {
+	u32 curve;
+	u32 secret_key_len;
+	u64 public_key;
+	u64 secret_key;		/* DS reference */
+};
+
+struct pke_cmd_ecdsa_keygen {
+	u32 curve;
+	u32 secret_key_len;
+	u64 secret_key;		/* DS reference */
+	u32 secret_key_type;
+};
+
+struct pke_cmd_eddsa_verify {
+	u32 curve;
+	u32 digest_len;
+	u64 public_key_y;
+	u64 digest;
+	u64 signature;
+	u64 rprime;
+};
+
+struct pke_cmd_eddsa_sign {
+	u32 curve;
+	u32 secret_key_len;
+	u64 digest;
+	u64 signature;
+	u64 secret_key;		/* DS reference */
+	u32 digest_len;
+};
+
+struct pke_cmd_eddsa_pubgen {
+	u32 curve;
+	u32 secret_key_len;
+	u64 public_key_y;
+	u64 secret_key;		/* DS reference */
+};
+
+struct pke_cmd_ecdh_keygen {
+	u32 curve;
+	u32 secret_key_len;
+	u64 public_key_x;
+	u64 secret_key;		/* DS reference */
+};
+
+struct pke_cmd_ecdh {
+	u32 curve;
+	u32 secret_key_len;
+	u32 shared_secret_len;
+	u32 shared_secret_type;
+	u64 peer_key_x;
+	u64 secret_key;		/* DS reference */
+	u64 shared_secret;	/* DS reference for result */
+};
+
+struct pke_cmd_rsa_enc {
+	u32 bits;
+	u32 e_len;
+	u64 e;
+	u64 n;
+	u64 m;
+	u64 c;
+};
+
+struct pke_cmd_rsa_dec {
+	u32 bits;
+	u32 e_len;
+	u64 e;
+	u64 n;
+	u64 c;
+	u64 m;
+	u64 d;			/* DS reference */
+};
+
+struct pke_cmd_rsa_crt_dec {
+	u32 bits;
+	u32 e_len;
+	u64 e;
+	u64 n;
+	u64 c;
+	u64 m;
+	u64 crt;		/* DS reference */
+};
+
+struct pke_cmd_rsa_keygen {
+	u32 bits;
+	u32 d_type;
+	u64 e;
+	u64 n;
+	u64 d;			/* DS reference */
+	u64 crt;		/* DS reference */
+	u32 crt_type;
+};
+
+struct pke_cmd_eddsa_keygen_sca {
+	u32 curve;
+	u64 secret_key;		/* DS reference: input normal SK */
+	u64 sca_secret_key;	/* DS reference: output blinded SK */
+};
+
+/* SM2 Command Structures */
+
+struct pke_cmd_sm2_ecdh_keygen {
+	u64 nonce;		/* DMA addr (32B input or output) */
+	u64 session_key;	/* DMA addr output (64B) */
+	u32 nonce_len;		/* 0 = HW generates, 32 = caller provides */
+};
+
+struct pke_cmd_sm2_ecdh {
+	u32 nonce_len;		/* 0 or 32 */
+	u32 private_key_len;	/* must be 32 */
+	u64 nonce;		/* DMA addr (32B) */
+	u64 peer_public_key;	/* DMA addr (64B) */
+	u64 peer_session_key;	/* DMA addr (64B) */
+	u64 private_key;		/* DS reference */
+	u64 shared_point;	/* DS reference (output, 64B) */
+	u32 shared_point_type;	/* SYS_TYPE_SET(flags, CORE_ID_PKE) */
+};
+
+struct pke_cmd_sm2_dec_point {
+	u32 ciphertext_len;	/* total CT length (97..128) */
+	u32 private_key_len;	/* must be 32 */
+	u64 ciphertext;		/* DMA addr (64B: C1 point) */
+	u64 dec_point;		/* DMA addr output (64B) */
+	u64 private_key;		/* DS reference */
+};
+
+struct pke_cmd_sm2_enc_point {
+	u64 nonce;		/* DMA addr (32B, optional) */
+	u64 public_key;		/* DMA addr (64B) */
+	u64 ciphertext;		/* DMA addr output (64B: C1) */
+	u64 enc_point;		/* DMA addr output (64B) */
+	u32 nonce_len;		/* 0 or 32 */
+};
+
+struct pke_cmd_sm2_id_digest {
+	u64 id;			/* DMA addr (identity, <=32B) */
+	u64 public_key;		/* DMA addr (64B) */
+	u64 digest;		/* DMA addr output (32B) */
+	u32 id_len;		/* identity length in bytes */
+};
+
+struct pke_cmd_sm2_ecdh_hash {
+	u64 peer_id_digest;	/* DMA addr (32B) */
+	u64 id_digest;		/* DMA addr (32B) */
+	u64 shared_point;	/* DS reference (64B input) */
+	u64 shared_key;		/* DS reference (16B output) */
+	u32 shared_key_type;	/* SYS_TYPE_SET(flags, CORE_ID_PKE) */
+};
+
+struct pke_cmd_sm2_dec_hash {
+	u64 ciphertext;		/* DMA addr (full ciphertext) */
+	u64 dec_point;		/* DMA addr (64B) */
+	u64 plaintext;		/* DMA addr output (ct_len - 96 bytes) */
+	u32 ciphertext_len;	/* 97..128 */
+};
+
+struct pke_cmd_sm2_enc_hash {
+	u64 message;		/* DMA addr (plaintext) */
+	u64 enc_point;		/* DMA addr (64B) */
+	u64 ciphertext;		/* DMA addr output (96 + msg_len) */
+	u32 message_len;	/* 1..32 */
+};
+
+/* PKE Command Union */
+
+union pke_cmd {
+	struct pke_cmd_ecdsa_verify	cmd_ecdsa_verify;
+	struct pke_cmd_ecdsa_sign	cmd_ecdsa_sign;
+	struct pke_cmd_ecdsa_pubgen	cmd_ecdsa_pubgen;
+	struct pke_cmd_ecdsa_keygen	cmd_ecdsa_keygen;
+	struct pke_cmd_eddsa_verify	cmd_eddsa_verify;
+	struct pke_cmd_eddsa_sign	cmd_eddsa_sign;
+	struct pke_cmd_eddsa_pubgen	cmd_eddsa_pubgen;
+	struct pke_cmd_ecdh_keygen	cmd_ecdh_keygen;
+	struct pke_cmd_ecdh		cmd_ecdh;
+	struct pke_cmd_rsa_enc		cmd_rsa_enc;
+	struct pke_cmd_rsa_dec		cmd_rsa_dec;
+	struct pke_cmd_rsa_crt_dec	cmd_rsa_crt_dec;
+	struct pke_cmd_rsa_keygen	cmd_rsa_keygen;
+	struct pke_cmd_eddsa_keygen_sca	cmd_eddsa_keygen_sca;
+	struct pke_cmd_sm2_ecdh_keygen	cmd_sm2_ecdh_keygen;
+	struct pke_cmd_sm2_ecdh		cmd_sm2_ecdh;
+	struct pke_cmd_sm2_dec_point	cmd_sm2_dec_point;
+	struct pke_cmd_sm2_enc_point	cmd_sm2_enc_point;
+	struct pke_cmd_sm2_id_digest	cmd_sm2_id_digest;
+	struct pke_cmd_sm2_ecdh_hash	cmd_sm2_ecdh_hash;
+	struct pke_cmd_sm2_dec_hash	cmd_sm2_dec_hash;
+	struct pke_cmd_sm2_enc_hash	cmd_sm2_enc_hash;
+};
+
+#endif /* CMH_PKE_ABI_H */
diff --git a/drivers/crypto/cmh/include/cmh_qse_abi.h b/drivers/crypto/cmh/include/cmh_qse_abi.h
new file mode 100644
index 000000000000..9834620e21d7
--- /dev/null
+++ b/drivers/crypto/cmh/include/cmh_qse_abi.h
@@ -0,0 +1,181 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2026 Cryptography Research, Inc. (CRI).
+ * CMH LKM -- QSE Core ABI Definitions
+ *
+ * Kernel-side definitions for the CMH QSE ABI.
+ * All constants and layouts derived from the CMH eSW ABI.
+ */
+
+#ifndef CMH_QSE_ABI_H
+#define CMH_QSE_ABI_H
+
+#include <linux/bits.h>
+#include <linux/compiler_attributes.h>
+#include <linux/types.h>
+
+/* VCQ layout: header + [SYS_NEW] + QSE_CMD + flush */
+#define QSE_VCQ_CMDS_MIN	3	/* header + cmd + flush */
+#define QSE_VCQ_CMDS_MAX	4	/* header + sys_new + cmd + flush */
+
+/* QSE Flags */
+#define QSE_FLAG_USE_REF	BIT(0)
+#define QSE_FLAG_USE_RNG	BIT(1)
+
+/* QSE Command IDs */
+#define QSE_CMD_ML_KEM_KEYGEN		0x01U
+#define QSE_CMD_ML_KEM_ENC		0x02U
+#define QSE_CMD_ML_KEM_DEC		0x03U
+#define QSE_CMD_ML_DSA_KEYGEN		0x04U
+#define QSE_CMD_ML_DSA_SIGN		0x05U
+#define QSE_CMD_ML_DSA_VERIFY		0x06U
+#define QSE_CMD_ML_KEM_KEYGEN_MASKED	0x07U
+#define QSE_CMD_ML_KEM_ENC_MASKED	0x08U
+#define QSE_CMD_ML_KEM_DEC_MASKED	0x09U
+#define QSE_CMD_ML_DSA_KEYGEN_MASKED	0x0AU
+#define QSE_CMD_ML_DSA_SIGN_MASKED	0x0BU
+
+/* ML-KEM category values */
+#define ML_KEM_K_512		2U
+#define ML_KEM_K_768		3U
+#define ML_KEM_K_1024		4U
+
+/* ML-DSA mode values */
+#define ML_DSA_MODE_44		2U
+#define ML_DSA_MODE_65		3U
+#define ML_DSA_MODE_87		5U
+
+/* ML-DSA special message length for externalMu (pre-hashed 64-byte input) */
+#define ML_DSA_MLEN_EXTERNAL_MU	0xFFFFFFFFU
+#define ML_DSA_EXTMU_LEN	64U	/* actual copy size for externalMu */
+
+/* ML-DSA maximum message length */
+#define ML_DSA_MAX_MLEN		10240U
+
+/* Shared secret size */
+#define ML_KEM_SS_LEN		32U
+#define ML_KEM_SS_LEN_MASKED	64U
+
+/* Seed sizes */
+#define QSE_SEED_LEN		32U
+#define QSE_SEED_LEN_MASKED	64U
+
+/*
+ * ML-KEM size tables -- indexed by (k - 2).
+ *  [0] = ML-KEM-512 (k=2)
+ *  [1] = ML-KEM-768 (k=3)
+ *  [2] = ML-KEM-1024 (k=4)
+ */
+#define ML_KEM_LEVELS		3U
+
+#define ML_KEM_EK_SIZE(k)	(384U * (k) + 32U)
+#define ML_KEM_DK_SIZE(k)	(768U * (k) + 96U)
+#define ML_KEM_DK_SIZE_MASKED(k) (1152U * (k) + 128U)
+
+static inline u32 ml_kem_ct_size(u32 k)
+{
+	u32 du = (k == 4U) ? 11U : 10U;
+	u32 dv = (k == 4U) ? 5U : 4U;
+
+	return 32U * (k * du + dv);
+}
+
+#define ML_KEM_CT_SIZE(k)	ml_kem_ct_size(k)
+
+/*
+ * ML-DSA size tables -- indexed by mode.
+ * Mode values: 2 (ML-DSA-44), 3 (ML-DSA-65), 5 (ML-DSA-87).
+ */
+extern const u32 ml_dsa_pk_size[];
+extern const u32 ml_dsa_sk_size[];
+extern const u32 ml_dsa_sk_size_masked[];
+extern const u32 ml_dsa_sig_size[];
+
+/* Map ML-DSA mode (2/3/5) -> table index (0/1/2) */
+static inline int ml_dsa_mode_idx(u32 mode)
+{
+	switch (mode) {
+	case 2: return 0;
+	case 3: return 1;
+	case 5: return 2;
+	default: return -1;
+	}
+}
+
+/* Map ML-KEM k (2/3/4) -> table index (0/1/2), or -1 if invalid */
+static inline int ml_kem_k_idx(u32 k)
+{
+	if (k >= 2U && k <= 4U)
+		return (int)(k - 2U);
+	return -1;
+}
+
+/* QSE Command Structures -- match CMH eSW ABI exactly */
+
+struct qse_cmd_ml_kem_keygen {
+	u32 k;
+	u32 flags;
+	u64 seed;
+	u64 z;
+	u64 ek;
+	u64 dk;
+	u32 dk_type;
+};
+
+struct qse_cmd_ml_kem_enc {
+	u32 k;
+	u32 flags;
+	u64 coin;
+	u64 ek;
+	u64 ct;
+	u64 ss;
+	u32 ss_type;
+};
+
+struct qse_cmd_ml_kem_dec {
+	u32 k;
+	u32 flags;
+	u64 ct;
+	u64 dk;
+	u64 ss;
+	u32 ss_type;
+};
+
+struct qse_cmd_ml_dsa_keygen {
+	u32 mode;
+	u32 flags;
+	u64 seed;
+	u64 pk;
+	u64 sk;
+	u32 sk_type;
+};
+
+struct qse_cmd_ml_dsa_sign {
+	u32 mode;
+	u32 flags;
+	u64 rnd;
+	u64 m;
+	u64 sk;
+	u64 sig;
+	u32 mlen;
+};
+
+struct qse_cmd_ml_dsa_verify {
+	u32 mode;
+	u32 flags;
+	u64 m;
+	u64 pk;
+	u64 sig;
+	u32 mlen;
+};
+
+union qse_cmd {
+	struct qse_cmd_ml_kem_keygen cmd_ml_kem_keygen;
+	struct qse_cmd_ml_kem_enc    cmd_ml_kem_enc;
+	struct qse_cmd_ml_kem_dec    cmd_ml_kem_dec;
+	struct qse_cmd_ml_dsa_keygen cmd_ml_dsa_keygen;
+	struct qse_cmd_ml_dsa_sign   cmd_ml_dsa_sign;
+	struct qse_cmd_ml_dsa_verify cmd_ml_dsa_verify;
+};
+
+#endif /* CMH_QSE_ABI_H */
diff --git a/drivers/crypto/cmh/include/cmh_registers.h b/drivers/crypto/cmh/include/cmh_registers.h
new file mode 100644
index 000000000000..cba4dc0e8258
--- /dev/null
+++ b/drivers/crypto/cmh/include/cmh_registers.h
@@ -0,0 +1,146 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2026 Cryptography Research, Inc. (CRI).
+ * CMH LKM -- Hardware Register Definitions
+ *
+ * Derived from the CMH hardware register specification.
+ * All offsets are taken directly from the hardware documentation.
+ */
+
+#ifndef CMH_REGISTERS_H
+#define CMH_REGISTERS_H
+
+#include <linux/io.h>
+#include <linux/types.h>
+
+/* MBX Instance Addressing */
+
+#define CMH_MBX_INSTANCE_SHIFT        12
+#define CMH_MBX_INSTANCE_SIZE         BIT(CMH_MBX_INSTANCE_SHIFT) /* 0x1000 */
+#define CMH_MAX_MBX_INSTANCES         64U
+
+/* MBX Per-Instance Register Offsets */
+
+#define R_MBX_LOCK                    0x000U
+#define R_MBX_HOST_INFO               0x004U
+#define R_MBX_QUEUE_LO                0x008U
+#define R_MBX_QUEUE_HI                0x00CU
+#define R_MBX_QUEUE_SLOTS             0x010U
+#define R_MBX_QUEUE_STRIDE            0x014U
+#define R_MBX_QUEUE_HEAD              0x018U
+#define R_MBX_QUEUE_TAIL              0x01CU
+#define R_MBX_INTERRUPT               0x020U
+#define R_MBX_INTERRUPT_MASK          0x024U
+#define R_MBX_COMMAND                 0x028U
+#define R_MBX_STATUS                  0x02CU
+#define R_MBX_CHILD                   0x030U
+#define R_MBX_ID                      0x034U
+#define R_MBX_HOST_CONFIG             0x038U
+#define R_MBX_SCRATCH                 0x03CU
+
+#define MBX_QUEUE_ALIGNMENT           0x4U
+
+/* MBX Interrupt Bits */
+
+#define MBX_DONE_IRQ                  BIT(0)
+#define MBX_ERROR_IRQ                 BIT(1)
+#define MBX_IRQ_MASK                  (MBX_DONE_IRQ | MBX_ERROR_IRQ)
+
+/* MBX Command Values */
+
+#define MBX_COMMAND_RUN               0x000U
+#define MBX_COMMAND_PAUSE             0xC2FU
+#define MBX_COMMAND_CONTINUE          0x5DBU
+#define MBX_COMMAND_RESTART           0xB78U
+#define MBX_COMMAND_ABORT             0x6F6U
+#define MBX_COMMAND_FLUSH             0x3A5U
+
+/* MBX Status Values */
+
+#define MBX_STATUS_IDLE               0x01U
+#define MBX_STATUS_BUSY               0x10U
+#define MBX_STATUS_HOLD               0x20U
+#define MBX_STATUS_PAUSED             0x28U
+#define MBX_STATUS_SUCCESS            0x40U
+#define MBX_STATUS_ERROR              0x80U
+#define MBX_STATUS_OFFLINE            0x88U  /* ERROR | 0x08: offline/stopped */
+
+#define MBX_MASK_DONE                 (MBX_STATUS_IDLE | MBX_STATUS_SUCCESS)
+#define MBX_MASK_RUNNING              (MBX_STATUS_BUSY | MBX_STATUS_HOLD)
+#define MBX_MASK_STOPPED              MBX_STATUS_OFFLINE
+
+/* MBX Status Field Extraction */
+
+#define MBX_STATUS_CODE(v)            ((v) & 0xFFU)
+#define MBX_STATUS_CORE_ID(v)         (((v) >> 8) & 0xFFU)
+#define MBX_STATUS_ERROR_CODE(v)      (((v) >> 16) & 0xFFU)
+#define MBX_STATUS_CMD_INDEX(v)       (((v) >> 24) & 0xFFU)
+
+/* SIC Register Offsets (relative to SIC base / instance 0 base) */
+
+#define R_SIC_BOOT_STATUS             0x100U
+#define SIC_BOOT_STATUS_MASK          0x77U
+#define SIC_BOOT_STATUS_PASS          0x66U
+
+#define R_SIC_MBX_AVAILABILITY        0x104U
+#define R_SIC_MBX_AVAILABILITY2       0x108U
+
+#define R_SIC_SW_BOOT_STATUS          0x12CU
+#define SIC_SW_BOOT_STATUS_STARTED    BIT(0)
+#define SIC_SW_BOOT_STATUS_READY      BIT(1)
+#define SIC_SW_BOOT_STATUS_MISSION    BIT(6)
+#define SIC_SW_BOOT_STATUS_MISSION2   BIT(7)
+
+#define R_SIC_SW_ERROR_INFO           0x130U
+#define R_SIC_SW_HEARTBEAT            0x154U
+
+#define R_SIC_GPINTERRUPT             0x160U
+
+#define R_SIC_HW_VERSION0             0x200U
+#define R_SIC_SW_VERSION              0x218U
+#define R_SIC_CORE_ENABLE             0x22CU
+
+/* Register Access Helpers */
+
+static inline u32 cmh_reg_read32(void __iomem *base, u32 offset)
+{
+	return ioread32((u8 __iomem *)base + offset);
+}
+
+static inline void cmh_reg_write32(u32 value, void __iomem *base, u32 offset)
+{
+	iowrite32(value, (u8 __iomem *)base + offset);
+}
+
+/*
+ * 64-bit register access via two 32-bit reads/writes.  Only correct for
+ * register pairs where split access is defined (e.g. QUEUE_LO/HI).
+ * Do not use for registers requiring atomic 64-bit access.
+ *
+ * No explicit barrier between the two halves is needed: ioread32/iowrite32
+ * include implicit ordering guarantees on all supported architectures
+ * (MMIO accessors are strongly ordered with respect to each other).
+ */
+static inline u64 cmh_reg_read64(void __iomem *base, u32 offset)
+{
+	u32 lo = ioread32((u8 __iomem *)base + offset);
+	u32 hi = ioread32((u8 __iomem *)base + offset + 4);
+
+	return ((u64)hi << 32) | lo;
+}
+
+static inline void cmh_reg_write64(u64 value, void __iomem *base, u32 offset)
+{
+	iowrite32((u32)value, (u8 __iomem *)base + offset);
+	iowrite32((u32)(value >> 32), (u8 __iomem *)base + offset + 4);
+}
+
+/* Return the ioremap'd base for MBX instance N within the SIC region */
+static inline void __iomem *cmh_mbx_instance_base(void __iomem *sic_mapped,
+						  u32 instance)
+{
+	return (u8 __iomem *)sic_mapped +
+	       ((unsigned long)instance << CMH_MBX_INSTANCE_SHIFT);
+}
+
+#endif /* CMH_REGISTERS_H */
diff --git a/drivers/crypto/cmh/include/cmh_rh.h b/drivers/crypto/cmh/include/cmh_rh.h
new file mode 100644
index 000000000000..b182c203a475
--- /dev/null
+++ b/drivers/crypto/cmh/include/cmh_rh.h
@@ -0,0 +1,93 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2026 Cryptography Research, Inc. (CRI).
+ * CMH LKM -- Response Handler
+ *
+ * IRQ-driven completion processing.  Uses request_threaded_irq():
+ *   - Hardirq: read+clear MBX interrupt registers, wake thread
+ *   - Threaded handler: walk per-MBX transaction queues,
+ *     fire completion callbacks, free transaction objects
+ *
+ * The Response Handler consumes transaction_obj entries enqueued
+ * by the Transaction Manager (cmh_txn.c) on each per-mailbox txq.
+ */
+
+#ifndef CMH_RH_H
+#define CMH_RH_H
+
+#include "cmh_config.h"
+
+/**
+ * cmh_rh_init() - Register IRQ handler and start response processing
+ * @cfg: Global device configuration
+ *
+ * Return: 0 on success, negative errno on failure.
+ */
+int  cmh_rh_init(struct cmh_config *cfg);
+
+/**
+ * cmh_rh_cleanup() - Free IRQ and stop response processing
+ * @cfg: Global device configuration
+ */
+void cmh_rh_cleanup(struct cmh_config *cfg);
+
+/**
+ * cmh_rh_suspend() - Quiesce RH for system suspend
+ * @cfg: Global device configuration
+ *
+ * Cancels the watchdog timer and masks MBX interrupts at the hardware
+ * level.  IRQ handlers remain registered (standard PM pattern).
+ * The threaded IRQ handler stays active so that cmh_tm_quiesce()
+ * (called after this) can still drain in-flight transactions via
+ * IRQ-driven completions.
+ */
+void cmh_rh_suspend(struct cmh_config *cfg);
+
+/**
+ * cmh_rh_resume() - Restart RH after system resume
+ * @cfg: Global device configuration
+ *
+ * Re-synchronises per-MBX head tracking with hardware, clears stale
+ * interrupt bits, re-enables MBX interrupt masks, and re-arms the
+ * watchdog timer.  Must be called before cmh_tm_resume().
+ */
+void cmh_rh_resume(struct cmh_config *cfg);
+
+/* debugfs timeout accessor (debug builds only) */
+#ifdef CONFIG_CRYPTO_DEV_CMH_DEBUG
+unsigned int *cmh_rh_timeout_watchdog_ptr(void);
+#endif
+
+/**
+ * cmh_rh_force_drain_mbx() - FLUSH + drain all pending transactions on a MBX
+ * @mbx_idx: Mailbox index to drain
+ *
+ * Issues MBX_COMMAND_FLUSH, drains all pending transactions with
+ * -ECANCELED, and resets all recovery bookkeeping (including the
+ * wedged flag).  Safe to call at any time; acquires rh_process_lock.
+ * Intended for debugfs last-resort recovery.
+ */
+void cmh_rh_force_drain_mbx(u32 mbx_idx);
+
+/**
+ * cmh_rh_mbx_is_wedged() - Check if a mailbox is permanently wedged
+ * @mbx_idx: Mailbox index to check
+ *
+ * Returns true if the mailbox has failed RESTART+FLUSH recovery and
+ * is offline.  Used by the TM to avoid submitting new work to a dead
+ * mailbox.
+ *
+ * Return: true if wedged, false otherwise (including out-of-range idx).
+ */
+bool cmh_rh_mbx_is_wedged(u32 mbx_idx);
+
+/**
+ * cmh_rh_abort_mbx() - Issue MBX_COMMAND_ABORT under rh_process_lock
+ * @mbx_idx: Mailbox index to abort
+ *
+ * Serialises the ABORT write with RESTART/FLUSH commands issued by the
+ * watchdog, preventing command-register clobber races.
+ */
+void cmh_rh_abort_mbx(u32 mbx_idx);
+
+#endif /* CMH_RH_H */
diff --git a/drivers/crypto/cmh/include/cmh_rng.h b/drivers/crypto/cmh/include/cmh_rng.h
new file mode 100644
index 000000000000..1a886a0d82c1
--- /dev/null
+++ b/drivers/crypto/cmh/include/cmh_rng.h
@@ -0,0 +1,31 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2026 Cryptography Research, Inc. (CRI).
+ * CMH LKM -- Hardware RNG (DRBG) Driver
+ *
+ * Registers a struct hwrng backed by the CMH DRBG core.
+ * Each .read() builds a VCQ with DRBG_CMD_GENERATE and submits it
+ * through the Transaction Manager for synchronous completion.
+ *
+ * The DRBG must be configured (CONFIG command) by the management host
+ * before the LKM is loaded -- the LKM only issues GENERATE requests.
+ *
+ * CRNG seeding control:
+ *   - Module param "hwrng_quality" (0=disabled, 1-1024=enable)
+ *   - Default: 0 (conservative -- no automatic kernel CRNG seeding)
+ */
+
+#ifndef CMH_RNG_H
+#define CMH_RNG_H
+
+struct platform_device;
+
+int  cmh_rng_register(struct platform_device *pdev);
+void cmh_rng_unregister(void);
+
+/* debugfs timeout accessor (debug builds only) */
+#ifdef CONFIG_CRYPTO_DEV_CMH_DEBUG
+unsigned int *cmh_rng_timeout_drbg_ptr(void);
+#endif
+
+#endif /* CMH_RNG_H */
diff --git a/drivers/crypto/cmh/include/cmh_sm3_abi.h b/drivers/crypto/cmh/include/cmh_sm3_abi.h
new file mode 100644
index 000000000000..cbbe80fe18d6
--- /dev/null
+++ b/drivers/crypto/cmh/include/cmh_sm3_abi.h
@@ -0,0 +1,79 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2026 Cryptography Research, Inc. (CRI).
+ * CMH LKM -- SM3 Hash Core ABI Definitions
+ *
+ * Kernel-side definitions for the CMH SM3 ABI.
+ * All constants and layouts derived from the CMH eSW ABI.
+ */
+
+#ifndef CMH_SM3_ABI_H
+#define CMH_SM3_ABI_H
+
+#include <linux/types.h>
+
+/* SM3 Commands */
+
+#define SM3_CMD_INIT            0x01U
+#define SM3_CMD_UPDATE          0x02U
+#define SM3_CMD_FINAL           0x03U
+#define SM3_CMD_UPDATE2D        0x04U
+#define SM3_CMD_GATHER          0x06U
+#define SM3_CMD_SAVE            0x07U
+#define SM3_CMD_RESTORE         0x08U
+
+/* SM3 Digest / Block Sizes */
+
+#define CMH_SM3_DIGEST_SIZE     32U
+#define CMH_SM3_BLOCK_SIZE      64U
+
+/* SM3 Context (for SAVE/RESTORE) */
+
+#define SM3_CONTEXT_WORDS       29U
+#define SM3_CONTEXT_SIZE        (SM3_CONTEXT_WORDS * 4 + 4)  /* ctx[29] + crc */
+
+/* SM3 Command Structures */
+
+struct sm3_cmd_update {
+	u64 input;      /* DMA physical address of input data */
+	u32 inlen;      /* input data length in bytes */
+};
+
+struct sm3_cmd_final {
+	u64 digest;     /* DMA physical address for output digest */
+	u32 outlen;     /* digest length in bytes */
+};
+
+struct sm3_cmd_update2d {
+	u64 input;      /* DMA source address for input data */
+	u64 output;     /* DMA destination address for pass-through data */
+	u32 iolen;      /* input/pass-through data length in bytes */
+};
+
+struct sm3_cmd_gather {
+	u64 lista;      /* DMA address of dma_scattergather_item chain */
+	u32 sgcmd;      /* SM3 sub-command: SM3_CMD_UPDATE or SM3_CMD_UPDATE2D */
+};
+
+struct sm3_cmd_save {
+	u64 output;     /* DMA physical address for saved context */
+	u32 outlen;     /* must be SM3_CONTEXT_SIZE */
+};
+
+struct sm3_cmd_restore {
+	u64 input;      /* DMA physical address of saved context */
+	u32 inlen;      /* must be SM3_CONTEXT_SIZE */
+};
+
+/* SM3 Command Union */
+
+union sm3_cmd {
+	struct sm3_cmd_update   cmd_update;
+	struct sm3_cmd_final    cmd_final;
+	struct sm3_cmd_update2d cmd_update2d;
+	struct sm3_cmd_gather   cmd_gather;
+	struct sm3_cmd_save     cmd_save;
+	struct sm3_cmd_restore  cmd_restore;
+};
+
+#endif /* CMH_SM3_ABI_H */
diff --git a/drivers/crypto/cmh/include/cmh_sm4_abi.h b/drivers/crypto/cmh/include/cmh_sm4_abi.h
new file mode 100644
index 000000000000..a34faea613dc
--- /dev/null
+++ b/drivers/crypto/cmh/include/cmh_sm4_abi.h
@@ -0,0 +1,101 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2026 Cryptography Research, Inc. (CRI).
+ * CMH LKM -- SM4 Core ABI Definitions
+ *
+ * Kernel-side definitions for the CMH SM4 ABI.
+ * All constants and layouts derived from the CMH eSW ABI.
+ */
+
+#ifndef CMH_SM4_ABI_H
+#define CMH_SM4_ABI_H
+
+#include <linux/types.h>
+
+/* SM4 Block Size */
+
+#define CMH_SM4_BLOCK_SIZE	16U
+#define CMH_SM4_IV_SIZE		16U
+#define CMH_SM4_KEY_SIZE	16U	/* SM4 always uses 128-bit keys */
+
+/* SM4 Modes (per CMH SM4 ABI) */
+
+#define SM4_MODE_ECB		1U
+#define SM4_MODE_CBC		2U
+#define SM4_MODE_CTR		3U
+#define SM4_MODE_CFB		5U
+#define SM4_MODE_GCM		6U
+#define SM4_MODE_CMAC		7U
+#define SM4_MODE_CCM		8U
+#define SM4_MODE_XTS		9U
+#define SM4_MODE_XCBC		10U
+
+/* SM4 Operations (per CMH SM4 ABI) */
+
+#define SM4_OP_DECRYPT		1U
+#define SM4_OP_ENCRYPT		2U
+
+/* SM4 Command IDs */
+
+#define SM4_CMD_INIT		0x01U
+#define SM4_CMD_AAD_UPDATE	0x02U
+#define SM4_CMD_AAD_FINAL	0x03U
+#define SM4_CMD_UPDATE		0x04U
+#define SM4_CMD_FINAL		0x05U
+#define SM4_CMD_SCATTERGATHER	0x06U
+#define SM4_CMD_CCM_INIT	0x09U
+
+/* SM4 Command Structures */
+
+struct sm4_cmd_init {
+	u64 key;	/* datastore reference for the key */
+	u64 iv;		/* DMA address of the IV */
+	u32 keylen;	/* key length in bytes (16, or 32 for XTS) */
+	u32 ivlen;	/* IV length in bytes (0..16) */
+	u32 mode;	/* SM4 mode (SM4_MODE_*) */
+	u32 op;		/* SM4 operation (SM4_OP_*) */
+	u32 aadlen;	/* AAD length or 0 */
+	u32 iolen;	/* plaintext/ciphertext length */
+};
+
+struct sm4_cmd_update {
+	u64 input;	/* DMA address of input data */
+	u64 output;	/* DMA address of output data */
+	u32 iolen;	/* input/output data length */
+};
+
+struct sm4_cmd_final {
+	u64 input;	/* DMA address of last input data */
+	u64 output;	/* DMA address of last output data */
+	u64 tag;	/* DMA address of tag (AEAD only) */
+	u32 iolen;	/* last input/output data length */
+	u32 taglen;	/* tag length (AEAD only) */
+};
+
+struct sm4_cmd_aad_final {
+	u64 data;	/* DMA address of AAD data */
+	u32 datalen;	/* AAD data length */
+};
+
+struct sm4_cmd_ccm_init {
+	u64 key;	/* datastore reference for the key */
+	u64 nonce;	/* DMA address of the nonce */
+	u32 keylen;	/* key length in bytes (always 16) */
+	u32 noncelen;	/* nonce length (15 - L) */
+	u32 op;		/* SM4 operation (SM4_OP_*) */
+	u32 aadlen;	/* AAD length */
+	u32 iolen;	/* plaintext/ciphertext length */
+	u32 taglen;	/* tag length */
+};
+
+/* SM4 Command Union */
+
+union sm4_cmd {
+	struct sm4_cmd_init	cmd_init;
+	struct sm4_cmd_update	cmd_update;
+	struct sm4_cmd_final	cmd_final;
+	struct sm4_cmd_aad_final cmd_aad_final;
+	struct sm4_cmd_ccm_init	cmd_ccm_init;
+};
+
+#endif /* CMH_SM4_ABI_H */
diff --git a/drivers/crypto/cmh/include/cmh_sys_abi.h b/drivers/crypto/cmh/include/cmh_sys_abi.h
new file mode 100644
index 000000000000..64110311e552
--- /dev/null
+++ b/drivers/crypto/cmh/include/cmh_sys_abi.h
@@ -0,0 +1,148 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2026 Cryptography Research, Inc. (CRI).
+ * CMH LKM -- SYS Core ABI Definitions
+ *
+ * Kernel-side definitions for the CMH SYS ABI.
+ * All constants and layouts derived from the CMH eSW ABI.
+ */
+
+#ifndef CMH_SYS_ABI_H
+#define CMH_SYS_ABI_H
+
+#include <linux/bits.h>
+#include <linux/types.h>
+
+/* SYS Commands (per CMH SYS ABI) */
+
+#define SYS_CMD_RUN		0x01U
+#define SYS_CMD_NOP		0x02U
+#define SYS_CMD_IMPORT		0x07U
+#define SYS_CMD_EXPORT		0x08U
+#define SYS_CMD_NEW		0x0AU
+#define SYS_CMD_READ		0x0BU
+#define SYS_CMD_WRITE		0x0CU
+#define SYS_CMD_GRANT		0x0DU
+#define SYS_CMD_LIST		0x0EU
+#define SYS_CMD_FIND		0x0FU
+#define SYS_CMD_DATA		0x11U
+
+/* SYS Reference Constants */
+
+#define SYS_REF_NONE		0x0000000000000000ULL
+#define SYS_REF_TEMP		0x1111111111111111ULL
+#define SYS_REF_LAST		0xFFFFFFFFFFFFFFFFULL
+
+typedef u64 sys_ref_t;
+
+/* SYS CID */
+
+#define SYS_CID_NONE		0x0000000000000000ULL
+
+/* SYS Type Encoding -- bits [7:0] = core_id, bits [23:16] = flags */
+
+#define SYS_TYPE_FLAG_PT	BIT(16)  /* can be read as plaintext */
+#define SYS_TYPE_FLAG_XC	BIT(17)  /* can be exported over XC bus */
+#define SYS_TYPE_FLAG_SCA	BIT(18)  /* SCA key in 2 shares */
+
+#define SYS_TYPE_SET(flags, core) \
+	(((flags) & 0xFF0000UL) | ((core) & 0xFFUL))
+#define SYS_TYPE_CORE(type)	((type) & 0xFFU)
+#define SYS_TYPE_FLAGS(type)	((type) & 0xFF0000U)
+#define SYS_TYPE_NONE		0U	/* DMA output, no DS storage */
+
+#define SYS_WRAP_HDR_SIZE	16	/* sys_read plaintext header */
+
+/* SYS Command Structures */
+
+struct sys_cmd_new {
+	u64 cid;	/* caller id (name) for the object */
+	u64 ref;	/* DMA address -- CMH eSW writes back reference here */
+	u32 len;	/* size of the new object in bytes */
+};
+
+struct sys_cmd_write {
+	u64 ref;	/* object datastore reference */
+	u64 src;	/* DMA source address of key data */
+	u64 key;	/* wrapping key reference (SYS_REF_NONE = plaintext) */
+	u32 len;	/* source buffer length */
+	u32 type;	/* SYS_TYPE_SET(flags, core_id) */
+};
+
+struct sys_cmd_read {
+	u64 ref;	/* object datastore reference */
+	u64 dst;	/* DMA destination for key data */
+	u64 key;	/* wrapping key reference (SYS_REF_NONE = plaintext) */
+	u32 len;	/* destination buffer length */
+};
+
+struct sys_cmd_data {
+	u64 ref;	/* object datastore reference */
+	u64 dst;	/* DMA destination for object data */
+	u32 len;	/* destination buffer length */
+};
+
+struct sys_cmd_find {
+	u64 cid;	/* caller id to search for */
+	u64 dst;	/* DMA destination for struct sys_list_item */
+	u32 len;	/* destination buffer length */
+};
+
+struct sys_cmd_list {
+	u64 ref;	/* starting DS reference (SYS_REF_NONE = first) */
+	u64 dst;	/* DMA destination for struct sys_list_item */
+	u32 len;	/* destination buffer length */
+};
+
+struct sys_cmd_grant {
+	u64 ref;	/* object datastore reference */
+	u64 read;	/* bitfield: allow read for mailboxes */
+	u64 write;	/* bitfield: allow write for mailboxes */
+	u64 execute;	/* bitfield: allow use for mailboxes */
+};
+
+struct sys_cmd_export {
+	u64 cid;	/* caller id for the response */
+	u64 dst;	/* DMA destination for the export blob */
+	u64 key;	/* wrapping key datastore reference */
+	u32 len;	/* destination buffer length */
+};
+
+struct sys_cmd_import {
+	u64 src;	/* DMA source address of import blob */
+	u64 key;	/* wrapping key datastore reference */
+	u32 len;	/* source buffer length */
+};
+
+/* SYS List/Find Response Item */
+
+struct sys_list_item {
+	u64 ref;	/* object datastore reference */
+	u64 cid;	/* caller id */
+	u32 len;	/* object length */
+	u32 type;	/* object type (SYS_TYPE_SET packed) */
+};
+
+/* Wrapped-read header (prepended to SYS_CMD_READ responses) */
+
+struct sys_wrap_hdr {
+	u64 cid;	/* caller id */
+	u32 wrap;	/* wrap data length following this header */
+	u32 len;	/* object data length following wrap data */
+};
+
+/* SYS Command Union */
+
+union sys_cmd {
+	struct sys_cmd_new	cmd_new;
+	struct sys_cmd_write	cmd_write;
+	struct sys_cmd_read	cmd_read;
+	struct sys_cmd_data	cmd_data;
+	struct sys_cmd_find	cmd_find;
+	struct sys_cmd_list	cmd_list;
+	struct sys_cmd_grant	cmd_grant;
+	struct sys_cmd_export	cmd_export;
+	struct sys_cmd_import	cmd_import;
+};
+
+#endif /* CMH_SYS_ABI_H */
diff --git a/drivers/crypto/cmh/include/cmh_sysfs.h b/drivers/crypto/cmh/include/cmh_sysfs.h
new file mode 100644
index 000000000000..864cf1c8fa00
--- /dev/null
+++ b/drivers/crypto/cmh/include/cmh_sysfs.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2026 Cryptography Research, Inc. (CRI).
+ * CMH LKM -- sysfs Device Attributes
+ */
+
+#ifndef CMH_SYSFS_H
+#define CMH_SYSFS_H
+
+struct attribute_group;
+
+extern const struct attribute_group *cmh_sysfs_groups[];
+
+#endif /* CMH_SYSFS_H */
diff --git a/drivers/crypto/cmh/include/cmh_txn.h b/drivers/crypto/cmh/include/cmh_txn.h
new file mode 100644
index 000000000000..6131f0b2224f
--- /dev/null
+++ b/drivers/crypto/cmh/include/cmh_txn.h
@@ -0,0 +1,463 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2026 Cryptography Research, Inc. (CRI).
+ * CMH LKM -- Transaction Manager
+ *
+ * Dedicated kthread managing concurrent VCQ submissions.
+ *
+ * Callers post command_msg objects into the Command Message Queue (CMQ).
+ * The TM thread dequeues them, selects a mailbox, builds VCQ(s) in the
+ * DMA queue slot, creates a transaction_obj, and rings the doorbell.
+ *
+ * The Response Handler (cmh_rh.c) walks per-mailbox transaction queues
+ * when an IRQ fires and fires completion callbacks.
+ */
+
+#ifndef CMH_TXN_H
+#define CMH_TXN_H
+
+#include <linux/types.h>
+#include <linux/list.h>
+#include <linux/spinlock.h>
+#include <linux/completion.h>
+#include <linux/jiffies.h>
+#include <linux/refcount.h>
+#include <linux/mutex.h>
+#include <linux/timer.h>
+#include <crypto/algapi.h>
+
+#include "cmh_config.h"
+#include "cmh_vcq.h"
+
+/* Command Message (caller -> TM) */
+
+typedef void (*cmh_completion_fn)(void *data, int error);
+
+struct command_msg {
+	struct list_head    list;           /* CMQ linked list node */
+	u32                 command_id;     /* VCQ_CMD_ID(core, flags, span, cmd) */
+	void               *vcq_data;      /* heap-owned copy of VCQ entries */
+	u32                 vcq_count;      /* total vcq_cmd entries across all VCQs */
+	u32                 num_vcqs;       /* how many VCQs in vcq_data (0 or 1 = single) */
+	s32                 target_mbx;     /* MBX index from core affinity, or -1 fallback */
+	s32                 actual_mbx;     /* MBX selected by TM thread, -1 until dispatched */
+	cmh_completion_fn   complete;       /* completion callback (may be NULL) */
+	void               *completion_data;
+	refcount_t          refs;           /* submit_sync: 2 = waiter + TM */
+	bool                backlog_ok;     /* accept into backlog when CMQ is full */
+	unsigned long       timeout_jiffies;/* per-txn async timeout (0 = none) */
+};
+
+/* Transaction Object (TM -> RH) */
+
+/* Per-transaction FSM states for async timeout resolution */
+#define TXN_INFLIGHT	0
+#define TXN_COMPLETE	1
+#define TXN_TIMED_OUT	2
+
+struct transaction_obj {
+	struct list_head    list;           /* per-mailbox txn queue node */
+	u32                 first_vcq_id;
+	u32                 last_vcq_id;
+	u32                 mailbox_idx;    /* index into cfg->mailboxes[] */
+	u32                 command_id;     /* VCQ_CMD_ID from first payload cmd */
+	int                 error_code;
+	cmh_completion_fn   complete;
+	void               *completion_data;
+	atomic_t            state;          /* TXN_INFLIGHT / COMPLETE / TIMED_OUT */
+	struct timer_list   timeout_timer;  /* per-request async timeout */
+	refcount_t          refs;           /* owner + timer (if armed) */
+};
+
+/* Per-Mailbox Transaction Queue */
+
+struct cmh_mbx_txq {
+	struct list_head    head;
+	spinlock_t          lock;           /* protects head list + depth */
+	u32                 depth;          /* number of in-flight transactions */
+	struct mutex        dispatch_lock;  /* serialises VCQ dispatch + MBX flush */
+};
+
+/* Public Interface */
+
+/**
+ * cmh_tm_init() - Initialise the Transaction Manager
+ * @cfg: Global device configuration (mailbox layout, IRQ, etc.)
+ *
+ * Starts the TM kthread and initialises per-mailbox transaction queues.
+ *
+ * Return: 0 on success, negative errno on failure.
+ */
+int  cmh_tm_init(struct cmh_config *cfg);
+
+/**
+ * cmh_tm_cleanup() - Stop the TM kthread and drain all queues
+ */
+void cmh_tm_cleanup(void);
+
+/**
+ * cmh_tm_quiesce() - Stop TM kthread and drain in-flight transactions
+ *
+ * Stops the TM kthread, rejects new posts, then waits (with a
+ * configurable timeout) for all per-MBX transaction queues to drain.
+ * If the timeout fires, remaining transactions are cancelled with
+ * -ECANCELED.
+ */
+void cmh_tm_quiesce(void);
+
+/**
+ * cmh_tm_resume() - Restart the TM kthread after resume
+ *
+ * Return: 0 on success, negative errno if the kthread fails to start.
+ */
+int  cmh_tm_resume(void);
+
+/**
+ * cmh_tm_post_command() - Post a command to the TM for submission
+ * @msg: Command message with pre-built VCQ data and completion callback
+ *
+ * Round-robin selects the next MBX with enough free slots for
+ * msg->num_vcqs VCQs.  All VCQs in a message are written to
+ * consecutive slots on the same MBX (back-to-back).
+ * The caller retains ownership of @msg until the completion callback fires.
+ *
+ * Return: 0 on success, -EAGAIN if queue full, -ENODEV if TM stopped.
+ */
+int  cmh_tm_post_command(struct command_msg *msg);
+
+/*
+ * Synchronous submit -- post one or more VCQs and wait for completion.
+ *
+ * Combines post_command + refcounted wait + timeout + cancel into one
+ * call.  This is the standard pattern for all synchronous crypto ops.
+ *
+ * Context: must be called from a sleepable (task) context.
+ *          Performs GFP_KERNEL allocations and sleeps on
+ *          wait_for_completion_timeout().  A WARN_ON_ONCE fires
+ *          if called from atomic / IRQ / softirq context.
+ *
+ * vcq_cmds:   pre-built VCQ array (headers + commands, contiguous)
+ * vcq_count:  total number of vcq_cmd entries across all VCQs
+ * num_vcqs:   number of VCQs in the array (0 or 1 = single VCQ)
+ *
+ * For multi-VCQ submissions, the array contains multiple VCQs laid
+ * out contiguously, each starting with its own header.  All VCQs are
+ * written to consecutive MBX slots and share one transaction object.
+ *
+ * Returns 0 on success, -ETIMEDOUT, or CMH eSW error code.
+ */
+int  cmh_tm_submit_sync(struct vcq_cmd *vcq_cmds, u32 vcq_count,
+			u32 num_vcqs);
+
+/*
+ * Synchronous submit pinned to a specific mailbox.
+ * target_mbx: -1 = round-robin, >= 0 = pin to that MBX index.
+ */
+int  cmh_tm_submit_sync_mbx(struct vcq_cmd *vcq_cmds, u32 vcq_count,
+			    u32 num_vcqs, s32 target_mbx);
+
+/*
+ * Synchronous submit with explicit timeout.
+ * timeout_hz: completion timeout in jiffies (use msecs_to_jiffies()).
+ */
+
+/*
+ * Extended timeout for slow crypto operations: RSA keygen, PQC
+ * keygen/sign/verify.  Controlled by the slow_op_timeout_ms module
+ * parameter.
+ */
+unsigned long cmh_tm_slow_op_timeout_jiffies(void);
+
+int  cmh_tm_submit_sync_tmo(struct vcq_cmd *vcq_cmds, u32 vcq_count,
+			    u32 num_vcqs, s32 target_mbx,
+			    unsigned long timeout_hz);
+
+/*
+ * Synchronous submit that never issues MBX_COMMAND_ABORT on timeout.
+ * Returns -EAGAIN if cancelled from queue, -EINPROGRESS if the VCQ is
+ * left in-flight.  On -EINPROGRESS, @orphan_cb(@orphan_data) will be
+ * called when the VCQ eventually completes (RH callback fires and the
+ * last sync_ctx ref drops).  Use this to defer DMA cleanup.
+ * Safe for background/kthread callers that must not disrupt other MBX work.
+ */
+int  cmh_tm_submit_sync_noabort(struct vcq_cmd *vcq_cmds, u32 vcq_count,
+				u32 num_vcqs, unsigned long timeout_hz,
+				void (*orphan_cb)(void *),
+				void *orphan_data);
+
+/*
+ * Asynchronous submit -- post VCQs and return immediately.
+ *
+ * On successful return (0), the provided @callback may be invoked from
+ * either the RH threaded IRQ context (normal completion path) or the TM
+ * kthread (if VCQ dispatch to the HW ring fails after the message was
+ * posted to the CMQ).  The caller must not assume a specific callback
+ * context.
+ *
+ * After a successful post, the caller must NOT touch VCQ buffers --
+ * ownership transfers to the TM.  If this function returns non-zero,
+ * the message was not posted, the callback will NOT fire, and the caller
+ * must perform cleanup.
+ *
+ * Uses GFP_ATOMIC internally -- the crypto API may invoke driver ops
+ * from softirq context (e.g. IPsec), so GFP_KERNEL would deadlock.
+ *
+ * If @backlog_ok is true and the CMQ is full, the message is placed on
+ * an overflow backlog queue and -EBUSY is returned.  The caller must
+ * treat -EBUSY as "accepted" (like -EINPROGRESS): the callback WILL
+ * fire once the request is promoted from backlog and completes.  When
+ * @backlog_ok is false, CMQ-full returns -EAGAIN (caller must clean up).
+ *
+ * Returns: 0 on successful post, -EBUSY (backlogged -- callback will
+ *          fire), -ENOMEM, -EINVAL (bad vcq_count), -EAGAIN (CMQ full,
+ *          no backlog), -ENODEV.
+ */
+int  cmh_tm_submit_async(struct vcq_cmd *vcq_cmds, u32 vcq_count,
+			 u32 num_vcqs, s32 target_mbx,
+			 cmh_completion_fn callback, void *callback_data,
+			 bool backlog_ok, unsigned long timeout_jiffies);
+
+/**
+ * cmh_tm_async_timeout_jiffies() - Default per-request async timeout
+ *
+ * Returns the debugfs-configurable timeout for symmetric data-path
+ * ops (async_timeout_ms converted to jiffies).  Akcipher/kpp callers
+ * should pass 0 instead (no per-request timeout; vcq_timeout_ms is the
+ * safety net).
+ */
+unsigned long cmh_tm_async_timeout_jiffies(void);
+
+/**
+ * cmh_tm_flush_mbx() - Issue MBX_COMMAND_FLUSH and wait for completion
+ * @mbx_idx: Mailbox index
+ *
+ * Resets the eSW child mailbox state including the temp stack.
+ * Must be called when no VCQ submission is in progress on @mbx_idx.
+ *
+ * Return: 0 on success, -ETIMEDOUT if eSW does not clear the command,
+ *         -EBUSY if a command is already pending.
+ */
+int  cmh_tm_flush_mbx(s32 mbx_idx);
+
+/**
+ * cmh_tm_try_cancel_command() - Try to cancel a queued command
+ * @msg: Command message to cancel
+ *
+ * Return: true if removed from CMQ, false if already consumed by the TM thread.
+ */
+bool cmh_tm_try_cancel_command(struct command_msg *msg);
+
+/**
+ * cmh_tm_peek_transaction() - Peek at the oldest transaction on a mailbox
+ * @mbx_idx: Mailbox index
+ *
+ * For use by the Response Handler.  Caller must hold txq->lock or call
+ * from a context where no concurrent pop is possible (e.g. threaded IRQ).
+ *
+ * Return: Pointer to the oldest transaction_obj, or NULL if empty.
+ */
+struct transaction_obj *cmh_tm_peek_transaction(u32 mbx_idx);
+
+/**
+ * cmh_tm_pop_transaction() - Remove and return the oldest transaction
+ * @mbx_idx: Mailbox index
+ *
+ * Return: Pointer to the removed transaction_obj, or NULL if empty.
+ */
+struct transaction_obj *cmh_tm_pop_transaction(u32 mbx_idx);
+
+/**
+ * cmh_txn_finish() - Complete a transaction with FSM + timer handling
+ * @txn: Transaction popped from the TXQ
+ * @error: Error code (0 for success, negative errno)
+ *
+ * Resolves the timer-vs-completion race via atomic cmpxchg, cancels
+ * the per-txn timeout timer if still pending, fires the completion
+ * callback (if this path wins the race), and drops the owner reference.
+ * The transaction is freed when the last reference is dropped.
+ *
+ * Called by the Response Handler after popping a completed transaction.
+ */
+void cmh_txn_finish(struct transaction_obj *txn, int error);
+
+/**
+ * cmh_tm_max_cmds_per_vcq() - Max vcq_cmd entries per MBX slot
+ *
+ * Returns the minimum across all configured MBXes so callers can pack
+ * VCQs without knowing which MBX will be selected.
+ *
+ * Return: At least MIN_VCQ_CMDS (2).
+ */
+u32  cmh_tm_max_cmds_per_vcq(void);
+
+/**
+ * cmh_tm_mbx_count() - Return the number of configured mailboxes
+ *
+ * Return: cfg->mbx_count.
+ */
+u32  cmh_tm_mbx_count(void);
+
+/**
+ * cmh_core_default_id() - Return the default core_id for a core type
+ * @type: Logical core type enum
+ *
+ * Returns the core_id of the first (index-0) instance without advancing
+ * the round-robin counter.  Intended for callers pinned to a fixed MBX
+ * (e.g. mgmt ioctls on MGMT_MBX) that only need the VCQ core_id field.
+ *
+ * In multi-instance configurations the returned core_id is always that
+ * of instance[0], regardless of which MBX instance[0] is assigned to.
+ * Mgmt callers submit on MGMT_MBX (0) -- the eSW accepts any valid
+ * core_id on any MBX for command dispatch.
+ *
+ * Return: u32 core_id.
+ */
+u32  cmh_core_default_id(enum cmh_core_type type);
+
+/**
+ * cmh_core_select_instance() - Multi-instance core dispatch selection
+ * @type: Logical core type enum
+ *
+ * Returns the next (core_id, mbx_idx) pair for @type using round-robin
+ * across configured instances.  On first use for an instance whose MBX
+ * is not pre-assigned, atomically assigns the next available MBX.
+ *
+ * With single-instance defaults, this degenerates to the same behaviour
+ * as the old single-entry core_to_mbx[] table -- one core type, one MBX.
+ *
+ * Return: struct core_dispatch with core_id and mbx_idx.
+ */
+struct core_dispatch cmh_core_select_instance(enum cmh_core_type type);
+
+/**
+ * cmh_core_num_instances() - Return count of configured instances
+ * @type: Logical core type enum
+ *
+ * Return: Number of instances (>= 1) for @type.
+ */
+u32  cmh_core_num_instances(enum cmh_core_type type);
+
+/**
+ * cmh_core_get_instance() - Get a specific instance by index
+ * @type: Logical core type enum
+ * @idx: Instance index (0-based, must be < cmh_core_num_instances())
+ *
+ * Returns (core_id, mbx_idx) for the given instance without advancing
+ * the round-robin counter.  Triggers auto-assign if the instance has
+ * no MBX yet.
+ *
+ * Return: struct core_dispatch with core_id and mbx_idx.
+ */
+struct core_dispatch cmh_core_get_instance(enum cmh_core_type type, u32 idx);
+
+/**
+ * cmh_tm_affinity_reset() - Reset all core-to-MBX assignments
+ *
+ * Called during init and cleanup.
+ */
+void cmh_tm_affinity_reset(void);
+
+/**
+ * cmh_tm_txq_completion_notify() - Wake TM thread after TXQ completion
+ *
+ * Called by the Response Handler after completing a transaction to
+ * unblock the TM thread if it is waiting for a free MBX slot.
+ */
+void cmh_tm_txq_completion_notify(void);
+
+/*
+ * Pack @count payload commands (no headers) into one or more VCQs
+ * respecting the per-slot size limit, then submit synchronously.
+ *
+ * @payload:    flat array of vcq_cmd entries (no headers)
+ * @count:      number of entries in @payload
+ * @packed:     caller-provided scratch buffer for the packed output
+ * @max_packed: size of @packed in vcq_cmd entries
+ * @target_mbx: -1 = round-robin, >= 0 = pin to this MBX index
+ *
+ * Each VCQ gets its own header.  All VCQs are submitted as a single
+ * back-to-back transaction on the same MBX.
+ */
+int  cmh_vcq_pack_and_submit(const struct vcq_cmd *payload, u32 count,
+			     struct vcq_cmd *packed, u32 max_packed,
+			     s32 target_mbx);
+
+/**
+ * cmh_vcq_pack_and_submit_async() - Pack payload commands and submit async
+ * @payload: Flat array of VCQ command entries (no headers)
+ * @count: Number of entries in @payload
+ * @packed: Caller-provided scratch buffer for packed output
+ * @max_packed: Size of @packed in vcq_cmd entries
+ * @target_mbx: Mailbox index (-1 for round-robin)
+ * @callback: Completion callback
+ * @callback_data: Opaque data passed to @callback
+ * @backlog_ok: If true, accept into backlog when CMQ is full
+ * @timeout_jiffies: Per-request timeout (0 to disable)
+ *
+ * Async variant of cmh_vcq_pack_and_submit().  Returns 0 on successful
+ * post; after a successful post, @callback may run from RH threaded IRQ
+ * context on normal completion, from the TM kthread if VCQ dispatch
+ * fails after posting, or from TM teardown paths such as
+ * cmh_tm_cleanup() / cmh_tm_quiesce() when queued or in-flight work is
+ * cancelled.  Callers must not assume a single callback context.  On
+ * non-zero return, the callback will NOT fire.
+ *
+ * @payload:          flat array of vcq_cmd entries (no headers)
+ * @count:            number of entries in @payload
+ * @packed:           caller-provided scratch buffer for the packed output
+ * @max_packed:       size of @packed in vcq_cmd entries
+ * @target_mbx:       -1 = round-robin, >= 0 = pin to this MBX index
+ * @callback:         completion callback (may run from IRQ or TM context)
+ * @callback_data:    opaque pointer passed to @callback
+ * @backlog_ok:       if true, queue the request when all MBXs are busy
+ * @timeout_jiffies:  maximum wait time for MBX slot (0 = no wait)
+ *
+ * Return: 0 on successful post, -EBUSY (backlogged), negative errno on failure.
+ */
+int  cmh_vcq_pack_and_submit_async(const struct vcq_cmd *payload, u32 count,
+				   struct vcq_cmd *packed, u32 max_packed,
+				   s32 target_mbx,
+				   cmh_completion_fn callback,
+				   void *callback_data,
+				   bool backlog_ok,
+				   unsigned long timeout_jiffies);
+
+/* debugfs timeout accessors (debug builds only) */
+#ifdef CONFIG_CRYPTO_DEV_CMH_DEBUG
+unsigned int *cmh_tm_timeout_async_ptr(void);
+unsigned int *cmh_tm_timeout_vcq_ptr(void);
+unsigned int *cmh_tm_timeout_slow_op_ptr(void);
+unsigned int *cmh_tm_timeout_drain_ptr(void);
+#endif
+
+/* -- Crypto request completion helper ---------------------------------- */
+
+struct device *cmh_dev(void);
+
+/**
+ * cmh_complete() - Complete a crypto request with optional error logging
+ * @req: The async crypto request to complete
+ * @err: Error code (0 = success, -EINPROGRESS = backlog promotion signal)
+ *
+ * Logs a rate-limited diagnostic on genuine errors, then hands the
+ * request back to the crypto framework.  -EINPROGRESS is excluded from
+ * logging -- it is the crypto API's backlog promotion notification, not
+ * an error.  Centralizes error reporting so individual algorithm drivers
+ * do not need per-callback logging.
+ */
+static inline void cmh_complete(struct crypto_async_request *req, int err)
+{
+	if (err && err != -EINPROGRESS) {
+		/*
+		 * For template instances (e.g. hmac(sha3-512-cmh)) the
+		 * driver name will be the outer template's, not ours.
+		 * Still useful for triage -- identifies the failing tfm.
+		 */
+		dev_dbg_ratelimited(cmh_dev(), "op error: alg=%s err=%d\n",
+				    crypto_tfm_alg_driver_name(req->tfm),
+				    err);
+	}
+	crypto_request_complete(req, err);
+}
+
+#endif /* CMH_TXN_H */
diff --git a/drivers/crypto/cmh/include/cmh_vcq.h b/drivers/crypto/cmh/include/cmh_vcq.h
new file mode 100644
index 000000000000..a9d04635d819
--- /dev/null
+++ b/drivers/crypto/cmh/include/cmh_vcq.h
@@ -0,0 +1,283 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2026 Cryptography Research, Inc. (CRI).
+ * CMH LKM -- VCQ (Virtual Command Queue) Definitions
+ *
+ * Kernel-side definitions for the CMH VCQ and DMA scatter-gather ABI,
+ * so the LKM can build VCQs without depending on CMH eSW headers.
+ *
+ * All constants and layouts are derived from the CMH eSW ABI.
+ *
+ * Per-core command definitions live in their own ABI headers (cmh_hc_abi.h,
+ * cmh_aes_abi.h, etc.) and are included here to form the hwc_cmd union.
+ */
+
+#ifndef CMH_VCQ_H
+#define CMH_VCQ_H
+
+#include <linux/types.h>
+#include <linux/build_bug.h>
+#include <linux/string.h>
+#include <linux/bits.h>
+
+#include "cmh_hc_abi.h"
+#include "cmh_sm3_abi.h"
+#include "cmh_drbg_abi.h"
+#include "cmh_sys_abi.h"
+#include "cmh_kic_abi.h"
+#include "cmh_aes_abi.h"
+#include "cmh_sm4_abi.h"
+#include "cmh_ccp_abi.h"
+#include "cmh_pke_abi.h"
+#include "cmh_qse_abi.h"
+#include "cmh_hcq_abi.h"
+#include "cmh_eac_abi.h"
+
+/* VCQ Magic Numbers */
+
+#define VCQ_HDR_MAGIC           0x01514356U  /* 'V' 'C' 'Q' 0x01 */
+#define VCQ_CMD_MAGIC           0x01444D43U  /* 'C' 'M' 'D' 0x01 */
+
+/* VCQ Command ID Encoding */
+
+#define VCQ_CMD_MASK            0x000000FFU
+#define VCQ_SPAN_MASK           0x0000FF00U
+#define VCQ_FLAG_MASK           0x00FF0000U
+#define VCQ_CORE_MASK           0xFF000000U
+
+#define VCQ_CMD_ID(core, flags, span, cmd) \
+	(((u32)(core) << 24) | ((flags) & VCQ_FLAG_MASK) | \
+	 (((u32)(span) << 8) & VCQ_SPAN_MASK) | ((cmd) & VCQ_CMD_MASK))
+
+/* Core IDs (per CMH hardware specification) */
+
+#define CORE_ID_SYS             0x00U
+#define CORE_ID_DMA             0x01U
+#define CORE_ID_HC              0x02U
+#define CORE_ID_AES             0x03U
+#define CORE_ID_SM4             0x04U
+#define CORE_ID_SM3             0x05U
+#define CORE_ID_XC              0x07U
+#define CORE_ID_HCQ             0x08U
+#define CORE_ID_QSE             0x09U
+#define CORE_ID_PKE             0x0AU
+#define CORE_ID_TIC             0x0BU
+#define CORE_ID_KIC             0x0CU
+#define CORE_ID_MPU             0x0EU
+#define CORE_ID_DRBG            0x0FU
+#define CORE_ID_EMC             0x11U
+#define CORE_ID_CCP             0x18U
+#define CORE_ID_EAC             0x1EU
+#define CORE_ID_NUM             0x1FU  /* eSW g_drvs[] array size sentinel */
+#define CORE_ID_MAX             0xFFU  /* VCQ encoding limit (8-bit field) */
+
+/**
+ * enum cmh_core_type - Logical core type for multi-instance dispatch
+ * @CMH_CORE_HC:         Hash / HMAC / CSHAKE / KMAC (CORE_ID_HC)
+ * @CMH_CORE_AES:        AES (CORE_ID_AES)
+ * @CMH_CORE_SM4:        SM4 (CORE_ID_SM4)
+ * @CMH_CORE_SM3:        SM3 (CORE_ID_SM3)
+ * @CMH_CORE_CCP:        ChaCha20 / Poly1305 (CORE_ID_CCP)
+ * @CMH_CORE_PKE:        RSA / ECDSA / ECDH / EdDSA / SM2 (CORE_ID_PKE)
+ * @CMH_CORE_QSE:        ML-KEM / ML-DSA (CORE_ID_QSE)
+ * @CMH_CORE_HCQ:        SLH-DSA / LMS / XMSS (CORE_ID_HCQ)
+ * @CMH_NUM_CORE_TYPES:  Number of core types (array sizing sentinel)
+ *
+ * Algorithm drivers use this enum (not raw CORE_ID_* constants) for
+ * MBX selection and VCQ dispatch.  Each value indexes into a config
+ * table that maps to one or more (core_id, mbx) pairs.
+ *
+ * Raw CORE_ID_* defines remain for:
+ *   - SYS_TYPE_SET() key-type tags in datastore operations
+ *   - DT child node ``reg`` values (hardware core identity for config lookup)
+ *   - Singleton system cores (SYS, KIC, DRBG, EAC) not in this enum
+ */
+enum cmh_core_type {
+	CMH_CORE_HC = 0,
+	CMH_CORE_AES,
+	CMH_CORE_SM4,
+	CMH_CORE_SM3,
+	CMH_CORE_CCP,
+	CMH_CORE_PKE,
+	CMH_CORE_QSE,
+	CMH_CORE_HCQ,
+	CMH_NUM_CORE_TYPES
+};
+
+/**
+ * struct core_dispatch - VCQ dispatch target returned by core selection
+ * @core_id: Hardware core ID to encode in VCQ_CMD_ID()
+ * @mbx_idx: Mailbox index to submit the VCQ to
+ */
+struct core_dispatch {
+	u32 core_id;
+	s32 mbx_idx;
+};
+
+/* Common VCQ Command (per CMH VCQ ABI) */
+
+#define VCQ_CMD_FLUSH           0xFFU
+
+/**
+ * struct vcq_hdr - VCQ header occupying the first slot of every VCQ
+ * @cmds: Total number of commands including the header itself
+ * @rsvd: Reserved -- used internally by CMH eSW firmware
+ */
+struct vcq_hdr {
+	u32 cmds;
+	u32 rsvd[13];
+};
+
+/* DMA Scatter-Gather Item (per CMH DMAC hardware specification) */
+
+/**
+ * struct dma_scattergather_item - DMA scatter-gather descriptor node
+ * @lli: Next descriptor address (0 = end of list)
+ * @src: Source address for input particle
+ * @dst: Destination address for output particle
+ * @len: Particle length (low 32 bits used by hardware)
+ *
+ * Linked-list node walked by the DMAC hardware.  @lli chains to the
+ * next item or is zero for end-of-list.
+ */
+struct dma_scattergather_item {
+	u64 lli;
+	u64 src;
+	u64 dst;
+	u64 len;
+};
+
+/* Unified HWC Command Union */
+/*
+ * Each per-core ABI header defines a union <core>_cmd.
+ * Add new cores here as they are implemented.
+ */
+
+union hwc_cmd {
+	struct vcq_hdr          hdr;
+	union hc_cmd            hc;
+	union sm3_cmd           sm3;
+	union drbg_cmd          drbg;
+	union sys_cmd           sys;
+	union kic_cmd           kic;
+	union aes_cmd           aes;
+	union sm4_cmd           sm4;
+	union ccp_cmd           ccp;
+	union pke_cmd           pke;
+	union qse_cmd           qse;
+	union hcq_cmd           hcq;
+	union eac_cmd           eac;
+};
+
+/**
+ * struct vcq_cmd - Single VCQ command entry (always 64 bytes)
+ * @magic: VCQ_HDR_MAGIC for the header slot, VCQ_CMD_MAGIC for commands
+ * @id:    Encoded command ID built via VCQ_CMD_ID(core, flags, span, cmd)
+ * @hwc:   Per-core command payload union
+ */
+struct vcq_cmd {
+	u32 magic;
+	u32 id;
+	union hwc_cmd hwc;
+};
+
+static_assert(sizeof(struct vcq_cmd) == 64,
+	      "struct vcq_cmd must be exactly 64 bytes (one VCQ slot)");
+
+/**
+ * vcq_set_header() - Write the standard VCQ header at slot[0]
+ * @slot:       Pointer to the first VCQ slot
+ * @total_cmds: Total number of commands including the header
+ */
+static inline void vcq_set_header(struct vcq_cmd *slot, u32 total_cmds)
+{
+	memset(slot, 0, sizeof(*slot));
+	slot->magic = VCQ_HDR_MAGIC;
+	slot->id = VCQ_CMD_ID(CORE_ID_SYS, 0, 1, SYS_CMD_RUN);
+	slot->hwc.hdr.cmds = total_cmds;
+}
+
+/* VCQ Command Limits */
+
+#define MIN_VCQ_CMDS            2U   /* header + at least one command */
+#define MAX_VCQ_CMDS            15U  /* including the header */
+#define MAX_VCQ_SIZE            (MAX_VCQ_CMDS * sizeof(struct vcq_cmd))
+
+/**
+ * vcq_add_inline_data() - Pack inline data into consecutive VCQ slots
+ * @slot:     Pointer to the command slot preceding the inline data
+ * @data:     Source data to copy into subsequent slots
+ * @data_len: Length of @data in bytes
+ *
+ * Appends data starting at slot+1 and updates the span field in
+ * slot->id.  The caller must ensure enough slots are reserved.
+ *
+ * Return: Total number of slots consumed (1 + inline slots).
+ */
+static inline u32 vcq_add_inline_data(struct vcq_cmd *slot,
+				      const void *data, u32 data_len)
+{
+	u32 inline_slots, total_span;
+
+	if (!data_len)
+		return 1;
+
+	inline_slots = (data_len + sizeof(struct vcq_cmd) - 1) /
+		       sizeof(struct vcq_cmd);
+	total_span = 1 + inline_slots;
+
+	/* Zero the inline slots, then copy data */
+	memset(slot + 1, 0, inline_slots * sizeof(struct vcq_cmd));
+	memcpy(slot + 1, data, data_len);
+
+	/* Update span in the command's id field */
+	slot->id = (slot->id & ~VCQ_SPAN_MASK) |
+		   (((u32)total_span << 8) & VCQ_SPAN_MASK);
+
+	return total_span;
+}
+
+/**
+ * vcq_add_flush() - Build a generic VCQ_CMD_FLUSH command
+ * @slot:    Pointer to the VCQ slot to populate
+ * @core_id: Hardware core ID for the flush command
+ */
+static inline void vcq_add_flush(struct vcq_cmd *slot, u32 core_id)
+{
+	memset(slot, 0, sizeof(*slot));
+	slot->magic = VCQ_CMD_MAGIC;
+	slot->id = VCQ_CMD_ID(core_id, 0, 1, VCQ_CMD_FLUSH);
+}
+
+/* Shared HC VCQ Builders -- used by hash, hmac, cshake, kmac drivers */
+
+static inline void vcq_add_hc_init(struct vcq_cmd *slot, u32 core_id,
+				   u32 algo)
+{
+	memset(slot, 0, sizeof(*slot));
+	slot->magic = VCQ_CMD_MAGIC;
+	slot->id = VCQ_CMD_ID(core_id, 0, 1, HC_CMD_INIT);
+	slot->hwc.hc.cmd_init.algo = algo;
+}
+
+static inline void vcq_add_hc_final(struct vcq_cmd *slot, u32 core_id,
+				    u64 digest_phys, u32 outlen)
+{
+	memset(slot, 0, sizeof(*slot));
+	slot->magic = VCQ_CMD_MAGIC;
+	slot->id = VCQ_CMD_ID(core_id, 0, 1, HC_CMD_FINAL);
+	slot->hwc.hc.cmd_final.digest = digest_phys;
+	slot->hwc.hc.cmd_final.outlen = outlen;
+}
+
+static inline void vcq_add_hc_gather(struct vcq_cmd *slot, u32 core_id,
+				     u64 lista_phys, u32 sgcmd)
+{
+	memset(slot, 0, sizeof(*slot));
+	slot->magic = VCQ_CMD_MAGIC;
+	slot->id = VCQ_CMD_ID(core_id, 0, 1, HC_CMD_GATHER);
+	slot->hwc.hc.cmd_gather.lista = lista_phys;
+	slot->hwc.hc.cmd_gather.sgcmd = sgcmd;
+}
+
+#endif /* CMH_VCQ_H */
-- 
2.43.7



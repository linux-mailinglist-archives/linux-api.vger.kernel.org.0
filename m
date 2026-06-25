Return-Path: <linux-api+bounces-6685-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id VdsvIMBmPWpD2ggAu9opvQ
	(envelope-from <linux-api+bounces-6685-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Thu, 25 Jun 2026 19:34:56 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 169406C7D1E
	for <lists+linux-api@lfdr.de>; Thu, 25 Jun 2026 19:34:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=rambus.com header.s=selector1 header.b=PNFJpP5g;
	spf=pass (mail.lfdr.de: domain of "linux-api+bounces-6685-lists+linux-api=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-api+bounces-6685-lists+linux-api=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=rambus.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BC2EA30841DE
	for <lists+linux-api@lfdr.de>; Thu, 25 Jun 2026 17:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA07E3ED101;
	Thu, 25 Jun 2026 17:34:15 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11021074.outbound.protection.outlook.com [52.101.62.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63EA63EB0FE;
	Thu, 25 Jun 2026 17:34:14 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782408855; cv=fail; b=G90Q/eGQBUVZZveJ7DmRrVC6PmWg6yagT6Jz9Rv00GErX3sxN50zFdCdW90w7CNg4n+HDkghdAauXI17LR6n1AAKGrT3quz/8yr1mav8fm2zD84t2PLVJX0nalmkAo6GHP8yEfix+5VxggEZFlB3nnLL0wXDhvThX/bqe97EQuo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782408855; c=relaxed/simple;
	bh=hLqOaqivW3RocLS0CzTpi2YwnHLk/EkiWluwWHMdBx0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jJR0uzH/rm8qgP5HWLRLONx5J74slbfDdw+Hxr6sbneKk7J1LyB3KQI51Gpd3xfMqiqsWNWPTAHaCFvf0F6xaj805Akac7RpnHqEfUM6ewP9LjL+RDhb5IggcLO7VayWvNUXe4vXq50jyNfc/NM0duxiqSaedCNddL3zKElHrsY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rambus.com; spf=fail smtp.mailfrom=rambus.com; dkim=pass (2048-bit key) header.d=rambus.com header.i=@rambus.com header.b=PNFJpP5g; arc=fail smtp.client-ip=52.101.62.74
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EmK68oU2oaV4t590qwz+J9p2CyIEl1Fttq1Vu46NuwHxUiEZbzELJZrsR987ydZrFUmSP5h4Q2s4z3AyrjTLri4bhw09F1b62x0j6NkdQxHgUvEpLDLCDzZBLzkzMiMqnSNaYFWKjzOsW0gpKoOXe4jQNGEdj/tRYH/ocQe2iFOqHh4SdGCwX0UTgE0lV+VEqKyI10zINiZ93xDOZifVSpdHwyRLbT7TJZ1jC9wuJrPdU3dEck9HdaIhpvS5y8/1hc51R+JCw5Rb9hF7oqjlwGHsE1Vhd4h4JqENcYJbmk8Rt1DyZbWwjIlWNwwWmOWP6MxNz+NdtV85DcbxII9dVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/3/a4Fm0bgWXNMRw8/5ZwMOyNawyFZztKFFN500z1os=;
 b=NEtPUt5AT8jdeWubDZDiF7Hll0f0mC/RUGGrld+sQkcQYS+ICnYCx2RkC98ZphVTuprNyR5qy7IJnvs8TxAccmS+l1fLThWtyb7NCHggtDvg7duec6bS/HJxFxlTdW+I+wrCW5dVEh18bxpDQq/WRo58lYyvraJutlF7IeyWCMCZFUzkK+p4KOH3KspV+bnrBQSCgBUYHA0dDPXyTTV81aYrq7bggusm4JfDCyXOL6GFaSzrECigrOeMqfDLdGxGdVdL5xAcQyQoCUBMbiZmMxVHGJNhhKK5PqVBnoWJfwR7kYFCuMDCOZM/yTA7ugCq9srr6mf/b8BwAiWmk0qC6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.86.86.210) smtp.rcpttodomain=cryptography.com smtp.mailfrom=rambus.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=rambus.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rambus.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/3/a4Fm0bgWXNMRw8/5ZwMOyNawyFZztKFFN500z1os=;
 b=PNFJpP5ge5WvLK41G5Hhdv1mZfMSU7IYSNfDCrWof32ZzOhiSghHJU1nQScEe6s1IcEFMhG1fkY+NQCMx0DFUB3qmgOd65XinRQ9Y5luLhczhAfNgp3yrn8eKPFWHkYZQBNheGI1PNHcYasUzEqvTUaj7oMKB7Vbk+H1Mr1tCH0/RLPFlbEdFdQgKBvLjGXmM7fvJNN9PJI8JyUdmsZrXhrjhH8ae3GYqu7UA1RXFtzl3I1HgVBdZ4h894yb81OUX/4f/R4PhfzHNcJHMwEZnrzxfyOayOvY8rkUZl0GG4ulBdEYP/L/wNC/5YU3dXFvnOK8HGaRkshEPER6JckxgQ==
Received: from BN9PR03CA0863.namprd03.prod.outlook.com (2603:10b6:408:13d::28)
 by IA3PR04MB9301.namprd04.prod.outlook.com (2603:10b6:208:51b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Thu, 25 Jun
 2026 17:34:10 +0000
Received: from BN2PEPF0000449E.namprd02.prod.outlook.com
 (2603:10b6:408:13d:cafe::47) by BN9PR03CA0863.outlook.office365.com
 (2603:10b6:408:13d::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.15 via Frontend Transport; Thu,
 25 Jun 2026 17:34:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.86.86.210)
 smtp.mailfrom=rambus.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=rambus.com;
Received-SPF: Pass (protection.outlook.com: domain of rambus.com designates
 192.86.86.210 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.86.86.210; helo=hqxsv-psmtppxy02.rambus.com; pr=C
Received: from hqxsv-psmtppxy02.rambus.com (192.86.86.210) by
 BN2PEPF0000449E.mail.protection.outlook.com (10.167.243.149) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.6
 via Frontend Transport; Thu, 25 Jun 2026 17:34:10 +0000
Received: from hqxsv-cmdev3-skrishnamoorthy.rambus.com (hqn-lb-int-float.rambus.com [10.12.20.20])
	by hqxsv-psmtppxy02.rambus.com (Postfix) with ESMTPS id 9EEF41801802;
	Thu, 25 Jun 2026 17:34:07 +0000 (UTC)
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
Subject: [PATCH 19/19] MAINTAINERS: add Rambus CryptoManager Hub (CMH)
Date: Thu, 25 Jun 2026 10:33:27 -0700
Message-ID: <20260625173328.1140487-20-skrishnamoorthy@rambus.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449E:EE_|IA3PR04MB9301:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: ce8f2c94-c2f6-4bca-c4c8-08ded2dff768
X-LD-Processed: bd0ba799-c2b9-413c-9c56-5d1731c4827c,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|82310400026|376014|7416014|1800799024|921020|6133799003|18002099003|22082099003|13003099007|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	vUM1AwQ9MLAuVvOlrESPCo0T8t6DP0H1ldCOBnAdTF0Z6c2RM1IlhzGn9WhNBf10IekrOBosW+FgWM7irZKsXiLbA1DrPcH5Q7aRDYlU1+zy7wT7rO2FMPyHRiQyIpGuWdWBE5sCGx2cs+VjxbBPxkvubspk7pz0M6yf4yYnA22xpxQaXnYUnbqfJ9VLBjyXH+Z3n4tmAbYCT0795RXBHksDJOGJrBof5oqshD1JAXw7NeLUxg+1mEOt3Rbg+GERYBragHU4rm8rPjsa1gY2COFiDa/yN0IKOPKXwAqdzGGQuGJVm7wIXElblQkEMCnYWomAh8TsOZWAGAboPjo47J6polggguJIao/BKJ6kKX8q27ocCtrLezraCFVrPyR40Cbs1nU8ZrcxEboP2kQdrs6Ky1jVCuAMYJFNCsBfuSCR3/unh+sdLsBtkbaAZY2LQIb20BdlVpRSlGgjHyfB8EVGprtxzTFq5OW09OisV1IjcPmyC5DqagGFZERvPzHwULPj0uFoKN+liJowbMlwxtF6eZEIBjnvBn3Y6xVMO/jfuQV5qQaIS/wNkTtebHQLkeQLO4G2KDB51sdR++YCAtzpS4WKgXCpJI73HSvC7JnvyEt4ksvqEaroKtMp9zIrWXXk7T10RZ/FhCshe7FuS432N4uFKslu6Pf+CGObkfVGGZPE9onPljQikQqvleI/MUmEVfWl8Kqmmtxweft2ioqtFKQuXDNHXcJoWkbK3YLWeNik0/IX7TsC98Qx0sOw
X-Forefront-Antispam-Report:
	CIP:192.86.86.210;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hqxsv-psmtppxy02.rambus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(82310400026)(376014)(7416014)(1800799024)(921020)(6133799003)(18002099003)(22082099003)(13003099007)(56012099006)(11063799006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	HKmx1Mnzgc+rLXB+egtQbNpbbz5JcDbEPx2vUQADlxN/UjPzjxMyg9fe/l8pQXjGPG/xGfKMnU0Xxsotu1eq8JgJCjm8JzNejbwVlJMgkCzaAG0Ji3d4E9k29QvjvKgjNDECFmpEYW4wSC//lWjNVdJ+FAxqnR0gBVXgiTmVO7mfcwEoLXC/Xe0JegHKmric6uTOjyAFvxDrnPIeCPKVa3Y26a3S9Hgwsz7ybZmXUgS0CKz4mijH/9nN6SzLYJbzekQWtF9A/wWwiS9yZ0Kb3uRpXYfIoEWvin+GyxL11ecPgBnsas/yWsThbxuR/eJzFkzEfuoSyO3IysA4zINVWjorkk0utkS2BXWe9Ww6V/qIZOKv7Xl1n1AXDh+4EaBNaCQSWXvus0yy+swco+ayxMDK+Jj2mAQM376ZnbnS1mH+31wNTF0SeFij+BePdhDJ
X-OriginatorOrg: rambus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 17:34:10.1895
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce8f2c94-c2f6-4bca-c4c8-08ded2dff768
X-MS-Exchange-CrossTenant-Id: bd0ba799-c2b9-413c-9c56-5d1731c4827c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bd0ba799-c2b9-413c-9c56-5d1731c4827c;Ip=[192.86.86.210];Helo=[hqxsv-psmtppxy02.rambus.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF0000449E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR04MB9301
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
	RCPT_COUNT_TWELVE(0.00)[24];
	TAGGED_FROM(0.00)[bounces-6685-lists,linux-api=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,cryptography.com:email,vger.kernel.org:from_smtp,rambus.com:url,rambus.com:from_mime,rambus.com:dkim,rambus.com:email,rambus.com:mid];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-api,dt];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 169406C7D1E

From: Alex Ousherovitch <aousherovitch@rambus.com>

Add MAINTAINERS entry for the CRI CryptoManager Hub (CMH) hardware
crypto accelerator driver under drivers/crypto/cmh/.

Co-developed-by: Saravanakrishnan Krishnamoorthy <skrishnamoorthy@rambus.co=
m>
Signed-off-by: Saravanakrishnan Krishnamoorthy <skrishnamoorthy@rambus.com>
Signed-off-by: Alex Ousherovitch <aousherovitch@rambus.com>
Reviewed-by: Joel Wittenauer <Joel.Wittenauer@cryptography.com>
Reviewed-by: Thi Nguyen <thin@rambus.com>
---
 MAINTAINERS | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 90034eb7874e..ecb389795e3d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6797,6 +6797,25 @@ F:       kernel/cred.c
 F:     rust/kernel/cred.rs
 F:     Documentation/security/credentials.rst

+CRI CRYPTOMANAGER HUB (CMH) HARDWARE CRYPTO ACCELERATOR
+M:     Alex Ousherovitch <aousherovitch@rambus.com>
+M:     Saravanakrishnan Krishnamoorthy <skrishnamoorthy@rambus.com>
+R:     Joel Wittenauer <Joel.Wittenauer@cryptography.com>
+R:     Thi Nguyen <thin@rambus.com>
+L:     linux-crypto@vger.kernel.org
+L:     sipsupport@rambus.com (moderated for non-subscribers)
+S:     Maintained
+T:     git https://git.kernel.org/pub/scm/linux/kernel/git/herbert/cryptod=
ev-2.6.git
+F:     Documentation/ABI/testing/cmh-mgmt
+F:     Documentation/ABI/testing/debugfs-driver-cmh
+F:     Documentation/ABI/testing/sysfs-driver-cmh
+F:     Documentation/crypto/device_drivers/cmh.rst
+F:     Documentation/devicetree/bindings/crypto/cri,cmh.yaml
+F:     Documentation/userspace-api/ioctl/cmh_mgmt.rst
+F:     drivers/crypto/cmh/
+F:     include/uapi/linux/cmh_mgmt_ioctl.h
+F:     tools/testing/selftests/drivers/crypto/cmh/
+
 INTEL CRPS COMMON REDUNDANT PSU DRIVER
 M:     Ninad Palsule <ninad@linux.ibm.com>
 L:     linux-hwmon@vger.kernel.org
--
2.43.7


** This message and any attachments are for the sole use of the intended re=
cipient(s). It may contain information that is confidential and privileged.=
 If you are not the intended recipient of this message, you are prohibited =
from printing, copying, forwarding or saving it. Please delete the message =
and attachments and notify the sender immediately. **

Rambus Inc.<http://www.rambus.com>


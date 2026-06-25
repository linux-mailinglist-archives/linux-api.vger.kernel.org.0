Return-Path: <linux-api+bounces-6696-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id NQopAthnPWq12ggAu9opvQ
	(envelope-from <linux-api+bounces-6696-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Thu, 25 Jun 2026 19:39:36 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 709DA6C7E4F
	for <lists+linux-api@lfdr.de>; Thu, 25 Jun 2026 19:39:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=rambus.com header.s=selector1 header.b=PJUUbXwX;
	spf=pass (mail.lfdr.de: domain of "linux-api+bounces-6696-lists+linux-api=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-api+bounces-6696-lists+linux-api=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=rambus.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 819903082F08
	for <lists+linux-api@lfdr.de>; Thu, 25 Jun 2026 17:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44A0B3EFD26;
	Thu, 25 Jun 2026 17:34:24 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11020140.outbound.protection.outlook.com [52.101.201.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F65F3EDAB5;
	Thu, 25 Jun 2026 17:34:19 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782408863; cv=fail; b=d1YpLW6l+sFZfFh4p9qF98CbLEd9IXe0XnSIwi6lAl6fp3VB/7C/4/7s+iT76e4y1Rkh90BmQGSr0+sReXrLI0g9RG0IYvCHeOFV22pnWFvXa5x6yQLp94VlK1ELtgu9+CqnyE/mfds2LXTo0Mbk4uUV2kOkw+ckpB21kxOohYU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782408863; c=relaxed/simple;
	bh=xPJbhWcJLDFCqnCwLw+bapDfMj/en5GBHaKXbUdhHD0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=buB9ggBp9tXAKIbg1xKATN6+3hYUylFH8DzVJz7M3w4hVfzFHE9qMmM3Dr236ZMkf5c9Zf68CY/lE6741qJ/sR/LhrRa809SEMVjUIbB4rJX2SZMqkWyOyuKPePRRYHtsQBato3Ra9aHd5AzWWJtIBxDjobOmnUDTifK7UafxQg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rambus.com; spf=fail smtp.mailfrom=rambus.com; dkim=pass (2048-bit key) header.d=rambus.com header.i=@rambus.com header.b=PJUUbXwX; arc=fail smtp.client-ip=52.101.201.140
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rLq8IPCLkL6B4m/TdLZtnmUAs5y3RL7kJNqQdDZynJPkD5aZNGx+i2yDmQrZp3E45ZHku497yePPKwNL7sCbAkZtW5KQH54dh+AGDmgrm4DTnG5o6U4T/oz4QFW8Z/HC85XQDJh5sF7xqdED0lVEm5YATldsyDCxeW+eTkC0Ygf+D4MFqMlpw4Od84p8lqhy++6t5jyZHHC7XjZCvb4+nxXJ8p5lMyj0krcV6jxcxiQ7hf+bDPDam1ugTpAaa+/pC8ec8VEALtbeqtK09u/2mccC3fPu4DLKFCOr2NQ86adZ6paBa3QX2wkXi2i6dI0gJ/WdeEPLelXw/gzbByPstA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CO1z/tA2e4LwGk8ji3yYZ/MrWHEtiG46iSLnQ+jalsI=;
 b=RkTe9tDlzXsjNX0ZMrwB/ypksq8burcuKimbBlMGRhVIYnqvXPRtJCp7+gBwne7YRCriCFtzaNkGnx/XU70tSRZVHXywLAiC6tsCig6xhWo5aaLn4LN2jloXKen16TAac+6oS+EPCWqaJLjPLfUD8tYkHbaN4ikLTtxPzeazvpvj2DiMv5bYkDsephwSPC0bHNVj30XR6rVzesIjn2fmd/Rc49tqBcBeasZcZmHvpQZmUsUrwBW0XBhfwcDV2JsNRC/xpER5uvhsH5M30ugFZ+rVuFQcM0kmH88wa5N1DNOU4z5v55L+mv87rthuWzabZXOWN05BH5F3Sh6kWsh9Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.86.86.210) smtp.rcpttodomain=cryptography.com smtp.mailfrom=rambus.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=rambus.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rambus.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CO1z/tA2e4LwGk8ji3yYZ/MrWHEtiG46iSLnQ+jalsI=;
 b=PJUUbXwX+O/zpRa5UI8kXEpdztjhhIzpLbPPHN8jgFhKfU+6DytysJNXIWOgC2bYTB+sFTC25hwFjVhoZVixSvzH0x2myovijMT6Rzp7qKMv2kOwJBzd47DWfXLmFeLyeeMAMBtWbaWyEr2PdeTI25LRWxPWeIOPcd4+zgriSB78GKtWNRXrHmZcdFn7ibsKeOw3XB8kQEitPuiLJfrRcOAs4QSGYckcKVknjkiRSuD9B3idpER84JmPCSyFh04aCXKPsDQtdKNDjzu0oRmH6deDPFOsslhwnxyR40drCtMdmyx5lC6XI+iEJ5NA9fIfJhu8P30Su6zFKNKQqoTj5g==
Received: from SJ2PR07CA0005.namprd07.prod.outlook.com (2603:10b6:a03:505::29)
 by BN0PR04MB8192.namprd04.prod.outlook.com (2603:10b6:408:144::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.17; Thu, 25 Jun
 2026 17:34:10 +0000
Received: from MWH0EPF000A6735.namprd04.prod.outlook.com
 (2603:10b6:a03:505:cafe::2d) by SJ2PR07CA0005.outlook.office365.com
 (2603:10b6:a03:505::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.16 via Frontend Transport; Thu,
 25 Jun 2026 17:34:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.86.86.210)
 smtp.mailfrom=rambus.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=rambus.com;
Received-SPF: Pass (protection.outlook.com: domain of rambus.com designates
 192.86.86.210 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.86.86.210; helo=hqxsv-psmtppxy02.rambus.com; pr=C
Received: from hqxsv-psmtppxy02.rambus.com (192.86.86.210) by
 MWH0EPF000A6735.mail.protection.outlook.com (10.167.249.27) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.6
 via Frontend Transport; Thu, 25 Jun 2026 17:34:10 +0000
Received: from hqxsv-cmdev3-skrishnamoorthy.rambus.com (hqn-lb-int-float.rambus.com [10.12.20.20])
	by hqxsv-psmtppxy02.rambus.com (Postfix) with ESMTPS id 81C2F1801800;
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
Subject: [PATCH 17/19] Documentation: ioctl: add CMH ioctl documentation and register 'J'
Date: Thu, 25 Jun 2026 10:33:25 -0700
Message-ID: <20260625173328.1140487-18-skrishnamoorthy@rambus.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6735:EE_|BN0PR04MB8192:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: af389a3b-034c-424e-f79e-08ded2dff744
X-LD-Processed: bd0ba799-c2b9-413c-9c56-5d1731c4827c,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|82310400026|376014|7416014|36860700016|921020|18002099003|22082099003|6133799003|3023799007|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	8HlpBVX9xUp7Z30PAqzwEgy4/3ZwrQ1TCsol/NmDmImrdRY/OmWPR7fDjrmhgCETr/D8OgnYA0OWL8552L2+/+RflVloyUvVAv++qtvJmq/XC1xNINAGnugWdsYAjz9b10crU4NEwpX88fDIcFQXV0tlhHu2xIWKDoGs7ij4VXHlRNXZlFTzfbYn7BxvJFPVB6mZbs+oRgyfb/5Nz2s6VpCGDN5Q4r8co9pMJdRg0hUwOkcXcfNw4QFAyyn9TyvnohRFyjOKbiBu/KM54cjsD1jX29nMNlFRwSJppU0NJpr0ILZojw3t0F7tnbaBOK/WYXBnE83a2ABCF9NXheZz5vchGXot/tZOVYamBmBd7NjLVtRhS/qXz+wnGus/5mQBXp0LORCaDg4RfXcOCrn7yn8zkFMXkN7WAafbZR1RBfD/xcSdczXDR9Yr+1exGVR61sSWXmwaYCMS14XfjL0CsHg3vcQOfUJntrTaK+2BJiZAjGUOsox/0qAw2gzQ0yn38GBFUNSOjqa1U69ofbV+EAlivtP8eD27VpfPobsP8kBH1/QkZ51Yl6zp/p08Eo2r7Tb2Ubbzspk1G3f4ZOos8zqvrmcFBQhz3t4gbS9gk/dTDpRyiwZGDDIbrcmDQsL+FsPfH9YPAYGuWncg7+SQmgcdK+1CJ/EiNTPPBplCgy2TApLnR8rji1mSRJurrwbuCnUcr1uOgfM2cEhHJNKR1sHzsfM7SMqZrS0kIRBVSIopPkASKFl+T7rovqxEEQGv
X-Forefront-Antispam-Report:
	CIP:192.86.86.210;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hqxsv-psmtppxy02.rambus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(82310400026)(376014)(7416014)(36860700016)(921020)(18002099003)(22082099003)(6133799003)(3023799007)(11063799006)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	UozkIKquCrFYTugxVngbNFNdE1m6OcJjMIMqvItbubdpQtmVYfVm7vvKyTarQVUG9ckv3ym6YGKctk/dtQstPVfvloZ2qrijJq48/UiwdtHLIzevXqsg3dMqSYdauQa0rmknAsoz07NWkeL9Hq3DZRfsn7vJO2uUjOCZ9m49deMlny9evxQPS2W3R0ru7QtNy9GfpSaQkKT0wKCPwYBKWWcvnXyYPabKe63QldKQVyR9dY2LRWAgkX6e+S54+TcYktCepu2jj31SzKxfyvmCVdzOtr/La8nPE9ZR8VJl7dpEkAJ+r2A4b6VIzIANHc+3YxhT51Br6I2dCEEKRulyVcfMaVB4ue4jnFFYM96SsMMwNjk2HYmmqil/a452A2du/1eqmXTniuHzy5pcYK6XJGRutUXxXbSNR802hV2WJpeQjR89E0Fs32h6fz0/XSEk
X-OriginatorOrg: rambus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 17:34:10.0071
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af389a3b-034c-424e-f79e-08ded2dff744
X-MS-Exchange-CrossTenant-Id: bd0ba799-c2b9-413c-9c56-5d1731c4827c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bd0ba799-c2b9-413c-9c56-5d1731c4827c;Ip=[192.86.86.210];Helo=[hqxsv-psmtppxy02.rambus.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6735.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR04MB8192
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
	TAGGED_FROM(0.00)[bounces-6696-lists,linux-api=lfdr.de];
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
X-Rspamd-Queue-Id: 709DA6C7E4F

From: Alex Ousherovitch <aousherovitch@rambus.com>

Add Documentation/userspace-api/ioctl/cmh_mgmt.rst documenting the
ioctl commands on the /dev/cmh_mgmt misc device for the CRI
CryptoManager Hub (CMH) hardware crypto accelerator driver.  Covers
key management, KIC key derivation, PKE (RSA, ECDSA, ECDH, EdDSA),
PQC (ML-KEM, ML-DSA, SLH-DSA), SM2, EAC, and DRBG.

Register ioctl magic number 'J' (0x4A) in ioctl-number.rst.  The
driver uses ioctls 0x01-0x40.

Co-developed-by: Saravanakrishnan Krishnamoorthy <skrishnamoorthy@rambus.co=
m>
Signed-off-by: Saravanakrishnan Krishnamoorthy <skrishnamoorthy@rambus.com>
Signed-off-by: Alex Ousherovitch <aousherovitch@rambus.com>
Reviewed-by: Joel Wittenauer <Joel.Wittenauer@cryptography.com>
Reviewed-by: Thi Nguyen <thin@rambus.com>
---
 .../userspace-api/ioctl/cmh_mgmt.rst          | 941 ++++++++++++++++++
 .../userspace-api/ioctl/ioctl-number.rst      |   1 +
 2 files changed, 942 insertions(+)
 create mode 100644 Documentation/userspace-api/ioctl/cmh_mgmt.rst

diff --git a/Documentation/userspace-api/ioctl/cmh_mgmt.rst b/Documentation=
/userspace-api/ioctl/cmh_mgmt.rst
new file mode 100644
index 000000000000..b0968ba6b153
--- /dev/null
+++ b/Documentation/userspace-api/ioctl/cmh_mgmt.rst
@@ -0,0 +1,941 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+CMH Key Management ioctl Interface (cmh_mgmt)
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+:Author: Cryptography Research, Inc. (CRI)
+:Maintainer: linux-crypto@vger.kernel.org
+
+Introduction
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+The ``/dev/cmh_mgmt`` character device provides user-space access to key
+management, key derivation, public-key, and post-quantum cryptographic
+operations on the CryptoManager Hub (CMH) hardware accelerator.
+
+The device is created by the ``cmh`` kernel module as a ``misc_device``.
+All operations are synchronous -- the ioctl blocks until the hardware
+completes.  Opening the device requires ``CAP_SYS_ADMIN``.
+
+All ioctl argument structures are versioned: user space sets the
+``version`` field to ``CMH_MGMT_V1`` (currently 1).  This allows the
+driver to extend structures in the future without breaking the ABI.
+
+Data types and ioctl numbers are defined in
+``<uapi/linux/cmh_mgmt_ioctl.h>``.  The ioctl type letter is ``'J'``
+(0x4A).
+
+Error Handling
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Unless otherwise noted, all ioctls return 0 on success and a negative
+errno on failure.  Common error codes:
+
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+``EINVAL`` Invalid ``version`` field, unsupported parameter, or
+           out-of-range length.
+``EFAULT`` Failed to copy data to/from user space.
+``ENOMEM`` Kernel memory allocation failed.
+``EIO``    Hardware returned an error (eSW command failure).
+``ENOENT`` Key not found (``KEY_FIND``, ``KEY_LIST``).
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Datastore Concepts
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+The CMH hardware maintains an embedded datastore managed by the eSW
+firmware.  Objects in the datastore are identified by a 64-bit reference
+(``ref``) and optionally by a 64-bit Content ID (``cid``).
+
+Two storage classes exist:
+
+**Temporary (SYS_REF_TEMP)**
+  Lifetime is scoped to a single mailbox slot.  The eSW firmware
+  reclaims the object when the slot is reused.  Used for raw-key
+  provisioning via ``KEY_NEW`` + ``KEY_WRITE``.
+
+**Persistent (SYS_REF_PERSIST)**
+  Survives across mailbox slots.  Requires explicit deletion via
+  ``KEY_DELETE``.  Identified by CID; resolved to a per-mailbox ref
+  via ``KEY_FIND``.
+
+Mailbox Dispatch
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+All ``/dev/cmh_mgmt`` ioctls are submitted on a single management
+mailbox.  This is a structural requirement of the eSW datastore model,
+not a tunable:
+
+* Datastore access control is **per-mailbox**.  ``KEY_NEW`` grants the
+  creating mailbox read/write/execute access; other mailboxes have none
+  until granted.  The returned 64-bit ``ref`` encodes a randomised
+  offset and does **not** carry the owning mailbox, so an operation that
+  receives only a ``ref`` (``KEY_GRANT``, ``KEY_READ``, ``KEY_DELETE``,
+  ``DS_EXPORT``) cannot itself determine which mailbox owns the object.
+  Using one fixed management mailbox guarantees that a key's create,
+  modify, grant, read and hardware-held-key compute steps all share the
+  mailbox that holds its access rights, without exposing mailbox
+  identity in the UABI.  User space may still widen a key's access to
+  additional mailboxes via ``KEY_GRANT``.
+
+* The eSW ``SYS_REF_TEMP`` scratch store is per-mailbox and persists
+  across ioctl calls, so a multi-step flow that derives into
+  ``SYS_REF_TEMP`` (for example a ``KIC_*`` derivation) and later
+  consumes it (``DS_EXPORT`` with ``wrap_key =3D SYS_REF_TEMP``) requires
+  both calls to use the same mailbox.
+
+Per-core ``cri,mbx`` device-tree affinity applies to the *stateless*
+in-kernel crypto API path, which carries no datastore state between
+requests and is balanced across mailboxes by the driver.
+
+Key Types
+=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+The ``ds_type`` field in ``KEY_NEW`` and ``KEY_WRITE`` selects the
+datastore object type.  Values are defined as ``CMH_DS_*`` constants:
+
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+Constant                           Value  Description
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+``CMH_DS_RAW_VALUE``               1      Raw byte array
+``CMH_DS_AES_KEY``                 2      AES key (128/192/256-bit)
+``CMH_DS_AES_XTS_KEY``             3      AES-XTS key (256/512-bit)
+``CMH_DS_HMAC_KEY``                4      HMAC key
+``CMH_DS_KMAC_KEY``                5      KMAC key
+``CMH_DS_SM4_KEY``                 6      SM4 key (128-bit)
+``CMH_DS_CHACHA20_KEY``            7      ChaCha20 key (256-bit)
+``CMH_DS_RSA_PRIV_KEY``            10     RSA private key
+``CMH_DS_RSA_PUB_KEY``             11     RSA public key
+``CMH_DS_RSA_CRT_KEY``             12     RSA CRT private key
+``CMH_DS_ECDSA_PRIV_KEY``          13     ECDSA private key
+``CMH_DS_ECDSA_PUB_KEY``           14     ECDSA public key
+``CMH_DS_ECDH_PRIV_KEY``           15     ECDH private key
+``CMH_DS_EDDSA_PRIV_KEY``          16     EdDSA private key
+``CMH_DS_SHARED_SECRET``           17     Shared secret
+``CMH_DS_SM2_PRIV_KEY``            18     SM2 private key
+``CMH_DS_ML_KEM_DK``               20     ML-KEM decapsulation key
+``CMH_DS_ML_DSA_SK``               21     ML-DSA secret key
+``CMH_DS_SLHDSA_SK``               25     SLH-DSA secret key
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Key Flags
+=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+The ``flags`` field in ``KEY_NEW`` and ``KEY_WRITE`` is a bitmask:
+
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+Flag                Bit          Description
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+``CMH_FLAG_PT``     16           Key can be read as plaintext
+``CMH_FLAG_XC``     17           Key can be exported over XC bus
+``CMH_FLAG_SCA``    18           SCA key stored in 2 shares
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Elliptic Curve IDs
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Curve identifiers for PKE operations (``curve`` field):
+
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D  =3D=3D=3D=3D=3D
+Constant                    Value
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D  =3D=3D=3D=3D=3D
+``CMH_CURVE_P192``          0x01
+``CMH_CURVE_P224``          0x02
+``CMH_CURVE_P256``          0x03
+``CMH_CURVE_P384``          0x04
+``CMH_CURVE_P521``          0x05
+``CMH_CURVE_SECP256K1``     0x07
+``CMH_CURVE_BP192R1``       0x11
+``CMH_CURVE_BP224R1``       0x12
+``CMH_CURVE_BP256R1``       0x13
+``CMH_CURVE_BP320R1``       0x14
+``CMH_CURVE_BP384R1``       0x15
+``CMH_CURVE_BP512R1``       0x16
+``CMH_CURVE_SM2``           0x18
+``CMH_CURVE_25519``         0x21
+``CMH_CURVE_448``           0x22
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D  =3D=3D=3D=3D=3D
+
+Key Management ioctls
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+CMH_IOCTL_KEY_NEW
+-----------------
+
+Create a new empty datastore object.
+
+:Direction: ``_IOWR``
+:Number: 0x01
+:Argument: ``struct cmh_ioctl_key_new``
+
+::
+
+  struct cmh_ioctl_key_new {
+      __u32 version;     /* must be CMH_MGMT_V1 */
+      __u32 ds_type;     /* CMH_DS_* key type */
+      __u32 len;         /* key length in bytes */
+      __u32 flags;       /* CMH_FLAG_* */
+      __u64 cid;         /* caller ID (name) for the key */
+      __u64 ref;         /* [out] key reference */
+  };
+
+The returned ``ref`` is used in subsequent ``KEY_WRITE``, ``KEY_READ``,
+and crypto operation ioctls.
+
+CMH_IOCTL_KEY_NEW_RANDOM
+------------------------
+
+Create a new datastore object filled with hardware-generated random data.
+
+:Direction: ``_IOWR``
+:Number: 0x0B
+:Argument: ``struct cmh_ioctl_key_new``
+
+Same structure as ``KEY_NEW``.  The hardware DRBG fills the object with
+``len`` random bytes.
+
+CMH_IOCTL_KEY_WRITE
+-------------------
+
+Write key material into a previously created datastore object.
+
+:Direction: ``_IOW``
+:Number: 0x02
+:Argument: ``struct cmh_ioctl_key_write``
+
+::
+
+  struct cmh_ioctl_key_write {
+      __u32 version;
+      __u32 len;         /* key data length */
+      __u32 ds_type;     /* CMH_DS_* key type */
+      __u32 flags;       /* CMH_FLAG_* */
+      __u64 ref;         /* key reference from KEY_NEW */
+      __u64 wrap_key;    /* wrapping key ref (CMH_REF_NONE =3D plaintext) =
*/
+      __u64 data;        /* user-space pointer to key material */
+  };
+
+If ``wrap_key`` is ``CMH_REF_NONE`` (0), key material is written in
+plaintext.  Otherwise, the data is unwrapped using the specified
+wrapping key.
+
+CMH_IOCTL_KEY_READ
+------------------
+
+Read key material from a datastore object.
+
+:Direction: ``_IOWR``
+:Number: 0x03
+:Argument: ``struct cmh_ioctl_key_read``
+
+::
+
+  struct cmh_ioctl_key_read {
+      __u32 version;
+      __u32 len;         /* buffer length */
+      __u64 ref;         /* key reference */
+      __u64 wrap_key;    /* wrapping key ref (CMH_REF_NONE =3D plaintext) =
*/
+      __u64 data;        /* user-space pointer to output buffer */
+      __u32 out_len;     /* [out] actual bytes written */
+      __u32 __reserved;
+  };
+
+Plaintext reads require the ``CMH_FLAG_PT`` attribute on the key.
+The eSW prepends a 16-byte header (``CMH_SYS_WRAP_HDR_SIZE``) even
+for plaintext reads; the output buffer must accommodate this.  The
+output overhead is ``CMH_DS_EXPORT_OVERHEAD_PLAIN`` (16 bytes) for
+plaintext reads and ``CMH_DS_EXPORT_OVERHEAD_WRAPPED`` (48 bytes:
+16-byte header + 16-byte nonce + 16-byte tag) for wrapped reads.
+
+CMH_IOCTL_KEY_FIND
+------------------
+
+Resolve a Content ID to a datastore reference.
+
+:Direction: ``_IOWR``
+:Number: 0x04
+:Argument: ``struct cmh_ioctl_key_find``
+
+::
+
+  struct cmh_ioctl_key_find {
+      __u32 version;
+      __u32 __reserved;
+      __u64 cid;         /* caller ID to search for */
+      __u64 ref;         /* [out] resolved key reference */
+      __u32 len;         /* [out] key length */
+      __u32 type;        /* [out] key type */
+  };
+
+Returns ``-ENOENT`` if no object with the given CID exists.
+
+CMH_IOCTL_KEY_LIST
+------------------
+
+Iterate datastore objects.
+
+:Direction: ``_IOWR``
+:Number: 0x0E
+:Argument: ``struct cmh_ioctl_key_list``
+
+::
+
+  struct cmh_ioctl_key_list {
+      __u32 version;
+      __u32 __reserved;
+      __u64 start_ref;   /* starting DS reference (0 =3D first) */
+      __u64 ref;         /* [out] object reference */
+      __u64 cid;         /* [out] caller ID */
+      __u32 len;         /* [out] object length */
+      __u32 type;        /* [out] object type */
+  };
+
+Pass ``start_ref=3D0`` to begin from the first object.  On return, pass
+the returned ``ref`` as ``start_ref`` in the next call.  Iteration ends
+when ``ref =3D=3D 0``.
+
+CMH_IOCTL_KEY_GRANT
+-------------------
+
+Set per-mailbox access permissions on a datastore object.
+
+:Direction: ``_IOW``
+:Number: 0x05
+:Argument: ``struct cmh_ioctl_key_grant``
+
+::
+
+  struct cmh_ioctl_key_grant {
+      __u32 version;
+      __u32 __reserved;
+      __u64 ref;         /* key reference */
+      __u64 read;        /* per-MBX read permission bitfield */
+      __u64 write;       /* per-MBX write permission bitfield */
+      __u64 execute;     /* per-MBX execute permission bitfield */
+  };
+
+CMH_IOCTL_KEY_DELETE
+--------------------
+
+Delete a datastore object (persistent keys only).
+
+:Direction: ``_IOW``
+:Number: 0x06
+:Argument: ``struct cmh_ioctl_key_grant``
+
+Uses the same structure as ``KEY_GRANT``; only the ``ref`` field is
+used.
+
+Datastore Export/Import ioctls
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
+
+CMH_IOCTL_DS_EXPORT
+-------------------
+
+Export the entire datastore as an encrypted blob.
+
+:Direction: ``_IOWR``
+:Number: 0x07
+:Argument: ``struct cmh_ioctl_ds_export``
+
+::
+
+  struct cmh_ioctl_ds_export {
+      __u32 version;
+      __u32 len;         /* buffer length */
+      __u64 cid;         /* caller ID for response tagging */
+      __u64 wrap_key;    /* wrapping key ref (CMH_REF_NONE =3D plaintext) =
*/
+      __u64 data;        /* user-space pointer to output buffer */
+      __u32 out_len;     /* [out] actual bytes written */
+      __u32 __reserved;
+  };
+
+CMH_IOCTL_DS_IMPORT
+-------------------
+
+Import a previously exported datastore blob.
+
+:Direction: ``_IOW``
+:Number: 0x08
+:Argument: ``struct cmh_ioctl_ds_import``
+
+::
+
+  struct cmh_ioctl_ds_import {
+      __u32 version;
+      __u32 len;         /* blob length */
+      __u64 wrap_key;    /* wrapping key ref (CMH_REF_NONE =3D plaintext) =
*/
+      __u64 data;        /* user-space pointer to import blob */
+  };
+
+Key Derivation ioctls (KIC)
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
+
+The Key Initialization Core (KIC) provides hardware key derivation from
+OTP-provisioned base keys.  Up to 8 base keys are available
+(``CMH_KIC_KEY1`` through ``CMH_KIC_KEY8``).
+
+CMH_IOCTL_KIC_HKDF1
+--------------------
+
+HKDF-based key derivation (single-step, label only).
+
+:Direction: ``_IOWR``
+:Number: 0x09
+:Argument: ``struct cmh_ioctl_kic_hkdf1``
+
+::
+
+  struct cmh_ioctl_kic_hkdf1 {
+      __u32 version;
+      __u32 key_len;     /* output key length */
+      __u64 base_key;    /* KIC base key reference */
+      __u64 cid;         /* CID for the new DS entry */
+      __u64 label;       /* user-space pointer to label data */
+      __u32 label_len;   /* label length in bytes */
+      __u32 flags;       /* CMH_KIC_FLAG_* */
+      __u64 ref;         /* [out] derived key reference */
+  };
+
+If ``CMH_KIC_FLAG_TEMP`` is set, the result is stored in the temporary
+datastore (not persistent).
+
+CMH_IOCTL_KIC_HKDF2
+--------------------
+
+HKDF-based key derivation (two-step, with salt key).
+
+:Direction: ``_IOWR``
+:Number: 0x0A
+:Argument: ``struct cmh_ioctl_kic_hkdf2``
+
+::
+
+  struct cmh_ioctl_kic_hkdf2 {
+      __u32 version;
+      __u32 key_len;
+      __u64 base_key;
+      __u64 salt_key;    /* salt key reference (CMH_REF_NONE =3D no salt) =
*/
+      __u64 cid;
+      __u64 label;
+      __u32 label_len;
+      __u32 flags;
+      __u64 ref;         /* [out] derived key reference */
+  };
+
+CMH_IOCTL_KIC_AES_CMAC_KDF
+---------------------------
+
+AES-CMAC-based key derivation (NIST SP 800-108).
+
+:Direction: ``_IOWR``
+:Number: 0x0C
+:Argument: ``struct cmh_ioctl_kic_aes_cmac_kdf``
+
+::
+
+  struct cmh_ioctl_kic_aes_cmac_kdf {
+      __u32 version;
+      __u32 key_len;     /* base & output key length (must be 32) */
+      __u64 base_key;
+      __u64 cid;
+      __u64 label;
+      __u32 label_len;
+      __u32 flags;
+      __u64 ref;         /* [out] derived key reference */
+  };
+
+CMH_IOCTL_KIC_DKEK_DERIVE
+--------------------------
+
+Derive a Device Key Encryption Key (DKEK) for secure key export.
+
+:Direction: ``_IOWR``
+:Number: 0x0D
+:Argument: ``struct cmh_ioctl_kic_dkek_derive``
+
+::
+
+  struct cmh_ioctl_kic_dkek_derive {
+      __u32 version;
+      __u32 host_id;     /* target host ID (0 =3D caller's own) */
+      __u64 base_key;
+      __u64 cid;
+      __u64 metadata;    /* user-space pointer to metadata */
+      __u32 metadata_len;
+      __u32 flags;
+      __u64 ref;         /* [out] derived KEK reference */
+  };
+
+PKE (Public Key Engine) ioctls
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
+
+RSA Operations
+--------------
+
+CMH_IOCTL_PKE_RSA_ENC
+~~~~~~~~~~~~~~~~~~~~~~
+
+RSA public-key encryption.
+
+:Direction: ``_IOWR``
+:Number: 0x10
+:Argument: ``struct cmh_ioctl_pke_rsa_enc``
+
+The public key (e, n) is passed as raw user-space buffers.
+
+CMH_IOCTL_PKE_RSA_DEC
+~~~~~~~~~~~~~~~~~~~~~~
+
+RSA private-key decryption using a datastore key reference.
+
+:Direction: ``_IOWR``
+:Number: 0x11
+:Argument: ``struct cmh_ioctl_pke_rsa_dec``
+
+CMH_IOCTL_PKE_RSA_CRT_DEC
+~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+RSA CRT private-key decryption (faster, uses CRT key format).
+
+:Direction: ``_IOWR``
+:Number: 0x12
+:Argument: ``struct cmh_ioctl_pke_rsa_crt_dec``
+
+CMH_IOCTL_PKE_RSA_KEYGEN
+~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Generate an RSA key pair in hardware.
+
+:Direction: ``_IOWR``
+:Number: 0x13
+:Argument: ``struct cmh_ioctl_pke_rsa_keygen``
+
+Returns private key and optional CRT key as datastore references.
+The modulus is written back to user space.
+
+ECDSA Operations
+----------------
+
+CMH_IOCTL_PKE_ECDSA_SIGN
+~~~~~~~~~~~~~~~~~~~~~~~~~
+
+ECDSA signature generation using a datastore private key.
+
+:Direction: ``_IOWR``
+:Number: 0x14
+:Argument: ``struct cmh_ioctl_pke_ecdsa_sign``
+
+CMH_IOCTL_PKE_ECDH
+~~~~~~~~~~~~~~~~~~~
+
+Compute ECDH shared secret from a peer public key and a datastore
+private key.
+
+:Direction: ``_IOWR``
+:Number: 0x16
+:Argument: ``struct cmh_ioctl_pke_ecdh``
+
+If ``CMH_PKE_FLAG_DS_RESULT`` is set, the shared secret is stored in
+the datastore and a reference is returned instead of raw bytes.
+
+CMH_IOCTL_PKE_ECDH_KEYGEN
+~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Derive a public key from a datastore private key.
+
+:Direction: ``_IOWR``
+:Number: 0x17
+:Argument: ``struct cmh_ioctl_pke_ecdh_keygen``
+
+EdDSA Operations
+----------------
+
+CMH_IOCTL_PKE_EDDSA_SIGN
+~~~~~~~~~~~~~~~~~~~~~~~~~
+
+EdDSA (Ed25519/Ed448) signature generation.
+
+:Direction: ``_IOWR``
+:Number: 0x18
+:Argument: ``struct cmh_ioctl_pke_eddsa_sign``
+
+Note: the ``digest`` field is the full message (pure EdDSA), not a
+pre-computed hash.
+
+CMH_IOCTL_PKE_EDDSA_VERIFY
+~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+EdDSA signature verification.
+
+:Direction: ``_IOW``
+:Number: 0x19
+:Argument: ``struct cmh_ioctl_pke_eddsa_verify``
+
+EC Key Management
+-----------------
+
+CMH_IOCTL_PKE_EC_KEYGEN
+~~~~~~~~~~~~~~~~~~~~~~~~
+
+Generate an EC private key in the hardware datastore.
+
+:Direction: ``_IOWR``
+:Number: 0x1A
+:Argument: ``struct cmh_ioctl_pke_ec_keygen``
+
+CMH_IOCTL_PKE_EC_PUBGEN
+~~~~~~~~~~~~~~~~~~~~~~~~
+
+Derive the public key from a datastore private key.
+
+:Direction: ``_IOWR``
+:Number: 0x1B
+:Argument: ``struct cmh_ioctl_pke_ec_pubgen``
+
+CMH_IOCTL_PKE_EDDSA_KEYGEN_SCA
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Generate a 2-share SCA-protected Ed448 private key.
+
+:Direction: ``_IOWR``
+:Number: 0x1C
+:Argument: ``struct cmh_ioctl_pke_eddsa_keygen_sca``
+
+Post-Quantum Cryptography (PQC) ioctls
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+PQC operations support the following flags in the ``flags`` field:
+
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D  =3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+Flag                          Bit   Description
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D  =3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+``CMH_QSE_FLAG_MASKED``       0     Use masked (SCA-resistant) HW path
+``CMH_QSE_FLAG_DS_REF``       1     Store key output in DS, return ref
+``CMH_QSE_FLAG_HW_RNG``       2     Use HW RNG for seed/randomness
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D  =3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+ML-KEM (FIPS 203)
+-----------------
+
+CMH_IOCTL_ML_KEM_KEYGEN
+~~~~~~~~~~~~~~~~~~~~~~~~
+
+Generate an ML-KEM key pair.
+
+:Direction: ``_IOWR``
+:Number: 0x20
+:Argument: ``struct cmh_ioctl_ml_kem_keygen``
+
+Security parameter ``k`` selects the strength: 2 (ML-KEM-512),
+3 (ML-KEM-768), or 4 (ML-KEM-1024).
+
+CMH_IOCTL_ML_KEM_ENC
+~~~~~~~~~~~~~~~~~~~~~
+
+ML-KEM encapsulation.  Produces ciphertext and shared secret.
+
+:Direction: ``_IOWR``
+:Number: 0x21
+:Argument: ``struct cmh_ioctl_ml_kem_enc``
+
+CMH_IOCTL_ML_KEM_DEC
+~~~~~~~~~~~~~~~~~~~~~
+
+ML-KEM decapsulation.  Recovers shared secret from ciphertext.
+
+:Direction: ``_IOWR``
+:Number: 0x22
+:Argument: ``struct cmh_ioctl_ml_kem_dec``
+
+ML-DSA (FIPS 204)
+-----------------
+
+CMH_IOCTL_ML_DSA_KEYGEN
+~~~~~~~~~~~~~~~~~~~~~~~~
+
+Generate an ML-DSA key pair.
+
+:Direction: ``_IOWR``
+:Number: 0x23
+:Argument: ``struct cmh_ioctl_ml_dsa_keygen``
+
+Security parameter ``mode`` selects the strength: 2 (ML-DSA-44),
+3 (ML-DSA-65), or 5 (ML-DSA-87).
+
+.. note::
+
+   When ``CMH_QSE_FLAG_DS_REF`` keeps the secret key in the datastore,
+   the public key returned in ``pk`` is the only copy: there is no
+   operation to derive the public key from the secret-key reference
+   for ML-DSA.  User space must persist ``pk`` at keygen time.
+
+CMH_IOCTL_ML_DSA_SIGN
+~~~~~~~~~~~~~~~~~~~~~~
+
+ML-DSA signature generation.
+
+:Direction: ``_IOWR``
+:Number: 0x24
+:Argument: ``struct cmh_ioctl_ml_dsa_sign``
+
+If ``mlen`` is set to ``CMH_ML_DSA_MLEN_EXTERNAL_MU`` (0xFFFFFFFF),
+the ``m`` pointer is interpreted as a 64-byte pre-hashed mu value
+(ExternalMu mode).
+
+CMH_IOCTL_SLHDSA_KEYGEN
+~~~~~~~~~~~~~~~~~~~~~~~~
+
+Generate an SLH-DSA key pair.
+
+:Direction: ``_IOWR``
+:Number: 0x28
+:Argument: ``struct cmh_ioctl_slhdsa_keygen``
+
+.. note::
+
+   When ``CMH_QSE_FLAG_DS_REF`` keeps the secret key in the datastore,
+   the public key returned in ``pk`` is the only copy: there is no
+   operation to derive the public key from the secret-key reference
+   for SLH-DSA.  User space must persist ``pk`` at keygen time.
+
+CMH_IOCTL_SLHDSA_SIGN
+~~~~~~~~~~~~~~~~~~~~~~
+
+SLH-DSA signature generation (pure mode).
+
+:Direction: ``_IOWR``
+:Number: 0x29
+:Argument: ``struct cmh_ioctl_slhdsa_sign``
+
+CMH_IOCTL_SLHDSA_SIGN_PREHASH
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+SLH-DSA pre-hash signature generation.
+
+:Direction: ``_IOWR``
+:Number: 0x2D
+:Argument: ``struct cmh_ioctl_slhdsa_sign_prehash``
+
+The ``prehash_algo`` field selects the hash algorithm
+(``CMH_SLHDSA_PREHASH_SHA256``, etc.).
+
+CMH_IOCTL_SM2_ENC_POINT
+~~~~~~~~~~~~~~~~~~~~~~~~
+
+:Direction: ``_IOWR``
+:Number: 0x33
+:Argument: ``struct cmh_ioctl_sm2_enc_point``
+
+CMH_IOCTL_SM2_ENC_HASH
+~~~~~~~~~~~~~~~~~~~~~~~
+
+:Direction: ``_IOWR``
+:Number: 0x37
+:Argument: ``struct cmh_ioctl_sm2_enc_hash``
+
+CMH_IOCTL_SM2_DEC_POINT
+~~~~~~~~~~~~~~~~~~~~~~~~
+
+:Direction: ``_IOWR``
+:Number: 0x32
+:Argument: ``struct cmh_ioctl_sm2_dec_point``
+
+CMH_IOCTL_SM2_DEC_HASH
+~~~~~~~~~~~~~~~~~~~~~~~
+
+:Direction: ``_IOWR``
+:Number: 0x36
+:Argument: ``struct cmh_ioctl_sm2_dec_hash``
+
+SM2 Key Exchange (GM/T 0003.3)
+------------------------------
+
+The key exchange protocol is a multi-step flow:
+
+1. ``EC_KEYGEN(CMH_CURVE_SM2)`` -- generate a long-lived private key.
+2. ``EC_PUBGEN`` -- derive the public key.
+3. ``SM2_ID_DIGEST`` -- compute the SM3 identity digest (ZA).
+4. ``SM2_ECDH_KEYGEN`` -- generate an ephemeral session key.
+5. Exchange session keys with the peer.
+6. ``SM2_ECDH`` -- compute the shared point.
+7. ``SM2_ECDH_HASH`` -- derive the shared key from the shared point
+   and both parties' ZA digests.
+
+CMH_IOCTL_SM2_ECDH_KEYGEN
+~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+:Direction: ``_IOWR``
+:Number: 0x30
+:Argument: ``struct cmh_ioctl_sm2_ecdh_keygen``
+
+``nonce_len`` must be 0 or 32.  If ``nonce_len=3D0``, the hardware
+generates the ephemeral scalar and writes it back to the ``nonce``
+buffer.
+
+CMH_IOCTL_SM2_ECDH
+~~~~~~~~~~~~~~~~~~~
+
+:Direction: ``_IOWR``
+:Number: 0x31
+:Argument: ``struct cmh_ioctl_sm2_ecdh``
+
+If ``shared_point_ref`` points to a non-zero value, the shared point
+is kept in the datastore for use by ``SM2_ECDH_HASH``.
+
+CMH_IOCTL_SM2_ID_DIGEST
+~~~~~~~~~~~~~~~~~~~~~~~~
+
+Compute the SM3 identity digest (ZA) for a public key and identity
+string.
+
+:Direction: ``_IOWR``
+:Number: 0x34
+:Argument: ``struct cmh_ioctl_sm2_id_digest``
+
+CMH_IOCTL_SM2_ECDH_HASH
+~~~~~~~~~~~~~~~~~~~~~~~~
+
+Derive the shared key from the shared point and ZA digests.
+
+:Direction: ``_IOWR``
+:Number: 0x35
+:Argument: ``struct cmh_ioctl_sm2_ecdh_hash``
+
+.. important::
+
+   The digest fields use **absolute** ordering per GM/T 0003.3, not
+   relative own/peer ordering.  Both parties must pass:
+
+   - ``peer_id_digest`` =3D Z_A (initiator's digest) -- hashed first
+   - ``id_digest`` =3D Z_B (responder's digest) -- hashed second
+
+Hardware Management ioctls
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
+
+CMH_IOCTL_EAC_READ
+-------------------
+
+Read and clear the hardware Error and Alarm Controller registers.
+
+:Direction: ``_IOWR``
+:Number: 0x0F
+:Argument: ``struct cmh_ioctl_eac_read``
+
+::
+
+  struct cmh_ioctl_eac_read {
+      __u32 version;
+      __u32 __reserved;
+      __u64 mailbox_notification;
+      __u32 hw_error;
+      __u32 hw_nmi;
+      __u32 hw_panic;
+      __u32 safety_fatal;
+      __u32 safety_notification;
+      __u32 sw_info0;
+      __u32 sw_info1;
+      __u32 sram_bank_errors[4];
+      __u32 __pad;
+  };
+
+The eSW atomically reads and clears the registers on each call.
+Successive reads show only new events since the last read.
+
+CMH_IOCTL_DRBG_CONFIG
+----------------------
+
+Configure the hardware DRBG before first use.
+
+:Direction: ``_IOW``
+:Number: 0x40
+:Argument: ``struct cmh_ioctl_drbg_config``
+
+::
+
+  struct cmh_ioctl_drbg_config {
+      __u32 version;
+      __u32 entropy_ratio;       /* CMH_DRBG_RATIO_* */
+      __u32 security_strength;   /* CMH_DRBG_STRENGTH_* */
+      __u32 __reserved;
+  };
+
+This is a management operation normally performed once at system
+startup.  Must be called before any ``hwrng`` reads or DRBG generate
+operations.
+
+ioctl Number Summary
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D  =3D=3D=3D=3D  =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+ioctl                                   Dir   Seq   Argument
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D  =3D=3D=3D=3D  =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+``CMH_IOCTL_KEY_NEW``                   IOWR  0x01  ``cmh_ioctl_key_new``
+``CMH_IOCTL_KEY_WRITE``                 IOW   0x02  ``cmh_ioctl_key_write`=
`
+``CMH_IOCTL_KEY_READ``                  IOWR  0x03  ``cmh_ioctl_key_read``
+``CMH_IOCTL_KEY_FIND``                  IOWR  0x04  ``cmh_ioctl_key_find``
+``CMH_IOCTL_KEY_GRANT``                 IOW   0x05  ``cmh_ioctl_key_grant`=
`
+``CMH_IOCTL_KEY_DELETE``                IOW   0x06  ``cmh_ioctl_key_grant`=
`
+``CMH_IOCTL_DS_EXPORT``                 IOWR  0x07  ``cmh_ioctl_ds_export`=
`
+``CMH_IOCTL_DS_IMPORT``                 IOW   0x08  ``cmh_ioctl_ds_import`=
`
+``CMH_IOCTL_KIC_HKDF1``                 IOWR  0x09  ``cmh_ioctl_kic_hkdf1`=
`
+``CMH_IOCTL_KIC_HKDF2``                 IOWR  0x0A  ``cmh_ioctl_kic_hkdf2`=
`
+``CMH_IOCTL_KEY_NEW_RANDOM``            IOWR  0x0B  ``cmh_ioctl_key_new``
+``CMH_IOCTL_KIC_AES_CMAC_KDF``          IOWR  0x0C  ``cmh_ioctl_kic_aes_cm=
ac_kdf``
+``CMH_IOCTL_KIC_DKEK_DERIVE``           IOWR  0x0D  ``cmh_ioctl_kic_dkek_d=
erive``
+``CMH_IOCTL_KEY_LIST``                  IOWR  0x0E  ``cmh_ioctl_key_list``
+``CMH_IOCTL_EAC_READ``                  IOWR  0x0F  ``cmh_ioctl_eac_read``
+``CMH_IOCTL_PKE_RSA_ENC``               IOWR  0x10  ``cmh_ioctl_pke_rsa_en=
c``
+``CMH_IOCTL_PKE_RSA_DEC``               IOWR  0x11  ``cmh_ioctl_pke_rsa_de=
c``
+``CMH_IOCTL_PKE_RSA_CRT_DEC``           IOWR  0x12  ``cmh_ioctl_pke_rsa_cr=
t_dec``
+``CMH_IOCTL_PKE_RSA_KEYGEN``            IOWR  0x13  ``cmh_ioctl_pke_rsa_ke=
ygen``
+``CMH_IOCTL_PKE_ECDSA_SIGN``            IOWR  0x14  ``cmh_ioctl_pke_ecdsa_=
sign``
+``CMH_IOCTL_PKE_ECDH``                  IOWR  0x16  ``cmh_ioctl_pke_ecdh``
+``CMH_IOCTL_PKE_ECDH_KEYGEN``           IOWR  0x17  ``cmh_ioctl_pke_ecdh_k=
eygen``
+``CMH_IOCTL_PKE_EDDSA_SIGN``            IOWR  0x18  ``cmh_ioctl_pke_eddsa_=
sign``
+``CMH_IOCTL_PKE_EDDSA_VERIFY``          IOW   0x19  ``cmh_ioctl_pke_eddsa_=
verify``
+``CMH_IOCTL_PKE_EC_KEYGEN``             IOWR  0x1A  ``cmh_ioctl_pke_ec_key=
gen``
+``CMH_IOCTL_PKE_EC_PUBGEN``             IOWR  0x1B  ``cmh_ioctl_pke_ec_pub=
gen``
+``CMH_IOCTL_PKE_EDDSA_KEYGEN_SCA``      IOWR  0x1C  ``cmh_ioctl_pke_eddsa_=
keygen_sca``
+``CMH_IOCTL_ML_KEM_KEYGEN``             IOWR  0x20  ``cmh_ioctl_ml_kem_key=
gen``
+``CMH_IOCTL_ML_KEM_ENC``                IOWR  0x21  ``cmh_ioctl_ml_kem_enc=
``
+``CMH_IOCTL_ML_KEM_DEC``                IOWR  0x22  ``cmh_ioctl_ml_kem_dec=
``
+``CMH_IOCTL_ML_DSA_KEYGEN``             IOWR  0x23  ``cmh_ioctl_ml_dsa_key=
gen``
+``CMH_IOCTL_ML_DSA_SIGN``               IOWR  0x24  ``cmh_ioctl_ml_dsa_sig=
n``
+``CMH_IOCTL_SLHDSA_KEYGEN``             IOWR  0x28  ``cmh_ioctl_slhdsa_key=
gen``
+``CMH_IOCTL_SLHDSA_SIGN``               IOWR  0x29  ``cmh_ioctl_slhdsa_sig=
n``
+``CMH_IOCTL_SLHDSA_SIGN_PREHASH``       IOWR  0x2D  ``cmh_ioctl_slhdsa_sig=
n_prehash``
+``CMH_IOCTL_SM2_ECDH_KEYGEN``           IOWR  0x30  ``cmh_ioctl_sm2_ecdh_k=
eygen``
+``CMH_IOCTL_SM2_ECDH``                  IOWR  0x31  ``cmh_ioctl_sm2_ecdh``
+``CMH_IOCTL_SM2_DEC_POINT``             IOWR  0x32  ``cmh_ioctl_sm2_dec_po=
int``
+``CMH_IOCTL_SM2_ENC_POINT``             IOWR  0x33  ``cmh_ioctl_sm2_enc_po=
int``
+``CMH_IOCTL_SM2_ID_DIGEST``             IOWR  0x34  ``cmh_ioctl_sm2_id_dig=
est``
+``CMH_IOCTL_SM2_ECDH_HASH``             IOWR  0x35  ``cmh_ioctl_sm2_ecdh_h=
ash``
+``CMH_IOCTL_SM2_DEC_HASH``              IOWR  0x36  ``cmh_ioctl_sm2_dec_ha=
sh``
+``CMH_IOCTL_SM2_ENC_HASH``              IOWR  0x37  ``cmh_ioctl_sm2_enc_ha=
sh``
+``CMH_IOCTL_DRBG_CONFIG``               IOW   0x40  ``cmh_ioctl_drbg_confi=
g``
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D  =3D=3D=3D=3D  =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Migration Plan
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Several ioctl commands provide operations that may gain dedicated kernel
+crypto API bindings in the future.  When those APIs land, the driver will
+register through them and the corresponding ioctls will be deprecated
+(retained for backward compatibility but no longer the primary interface):
+
+- **EdDSA** (``CMH_IOCTL_PKE_EDDSA_*``): will migrate to the kernel ``sig`=
`
+  API once ed25519/ed448 algorithm types are accepted upstream.
+
+- **ML-KEM** (``CMH_IOCTL_ML_KEM_*``): will migrate to the kernel KEM API
+  once the in-flight KEM subsystem series lands.
+
+- **Key lifecycle** (``CMH_IOCTL_KEY_*``): will evaluate integration with
+  the kernel KEYS subsystem (trusted-keys / encrypted-keys) as a follow-up
+  series.
+
+Operations that are inherently vendor-specific (EAC Chip Authentication,
+KIC key derivation, SM2 key exchange, DRBG configuration, datastore
+export/import) will remain as ioctls permanently -- they have no
+corresponding kernel abstraction and are not expected to gain one.
diff --git a/Documentation/userspace-api/ioctl/ioctl-number.rst b/Documenta=
tion/userspace-api/ioctl/ioctl-number.rst
index 29a08bc059dd..4a9ba12ee138 100644
--- a/Documentation/userspace-api/ioctl/ioctl-number.rst
+++ b/Documentation/userspace-api/ioctl/ioctl-number.rst
@@ -170,6 +170,7 @@ Code  Seq#    Include File                             =
                Comments
 'I'   all    linux/isdn.h                                              con=
flict!
 'I'   00-0F  drivers/isdn/divert/isdn_divert.h                         con=
flict!
 'I'   40-4F  linux/mISDNif.h                                           con=
flict!
+'J'   01-40  uapi/linux/cmh_mgmt_ioctl.h                               CRI=
 CryptoManager Hub (CMH)
 'K'   all    linux/kd.h
 'L'   00-1F  linux/loop.h                                              con=
flict!
 'L'   10-1F  drivers/scsi/mpt3sas/mpt3sas_ctl.h                        con=
flict!
--
2.43.7


** This message and any attachments are for the sole use of the intended re=
cipient(s). It may contain information that is confidential and privileged.=
 If you are not the intended recipient of this message, you are prohibited =
from printing, copying, forwarding or saving it. Please delete the message =
and attachments and notify the sender immediately. **

Rambus Inc.<http://www.rambus.com>


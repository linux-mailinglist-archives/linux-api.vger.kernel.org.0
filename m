Return-Path: <linux-api+bounces-6707-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id HME6DPebPWol4wgAu9opvQ
	(envelope-from <linux-api+bounces-6707-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Thu, 25 Jun 2026 23:21:59 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id BBED46C8B47
	for <lists+linux-api@lfdr.de>; Thu, 25 Jun 2026 23:21:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=rambus.com header.s=selector1 header.b=JSNp6c4N;
	spf=pass (mail.lfdr.de: domain of "linux-api+bounces-6707-lists+linux-api=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-api+bounces-6707-lists+linux-api=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=rambus.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 35968303EADF
	for <lists+linux-api@lfdr.de>; Thu, 25 Jun 2026 21:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 534F536683D;
	Thu, 25 Jun 2026 21:21:55 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11023075.outbound.protection.outlook.com [40.93.196.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B17A42F7EF8;
	Thu, 25 Jun 2026 21:21:53 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782422515; cv=fail; b=CDI0NthA6CjO0/JNJhkjfYBlNT1bclpwlbtU6v5nJnicG/wCNH0Ooz1YiU/TnJ1KXjG9CznNDs9dbv/pG1vmTuTf9pn2GYWkWLEXpjT8iTDmJCnx5au+r3jq+Nefut62SVOlyko3Ka7YbrFnXHQe+3ItojBPO2p8DJOXwCuSqVI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782422515; c=relaxed/simple;
	bh=DL6HMDLV9DFFzsJdaV7tADIe5c/NRRqAfeb9JW2PW9c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BJ2IQO3fF6B1WFgVlt9y661K1/1YUgou0yicA25ljjvboojJqb7YDWT0m1jZbmN+eWruFBG1mqmo7gCN/nSLg+ILj0x5Z08s6OKMbuk3gbLXXKeM+ixeVdqY92YQAHWYsb1SxSuMCozgUYM/cdBdGJXOtWzyMwgy6SY4I4N4mVo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rambus.com; spf=fail smtp.mailfrom=rambus.com; dkim=pass (2048-bit key) header.d=rambus.com header.i=@rambus.com header.b=JSNp6c4N; arc=fail smtp.client-ip=40.93.196.75
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vJeNGuHKmRaW+w6rXdbyke6VcvowXu8xxyA0gKKcDlwXbU9Eyg6RXL3v9exPIDpv8aH+LsOuq0l+aa6OEPgIqfih5CuJm5ncNII4hPoylvmhRP2MNE5JFvfadRBjZU4Hnd7wA2XLuoLM2FO1Tju9Ej/4Hexjf5njPEpYKxJvp27PbMQA8GzKImt5yu3di2zRE5P8Wu2CTH7kclvrGqCarks4ckzjMff8GHrGMb+cir5W1uKgzgJ7eVcmFb5NeuIOAiUyIvvsvIEquCg5sfMEkRMuVkvgPAigFuco4g8brNYISXy2QZvxVN64PZ15LkX+MRTvsV0G9hikAGKsV1zZPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YA51S0pesopoKLwbt6yUIBshppdISFMB8sZGTlRdlEk=;
 b=jriYLPeL+cjGa2MkYe2zAtrv3lyyYdQ3n8LCQ09485aJIhfKieMW1oRSRH2I/DuyRlIIiKliCxn9Wp9HyDxqK4ZL578zbSjALRdYTe5rXW8YK5/ly5m7VumAEd/vHX7DG6ErDFiqAdy/yVsChqepTmGwjIcOsKHodsOa96vg4laO5Dm5mZQZagLsrZQjQWW/dYfAbNgmMB5c08GymJ9KFiGQe4H0mcwMshj6edKvc3hNMQq9HTw0S9vKYIk2kH6DCYT2WnS55z/8BbTsxp4CZVMjWZETT8LEY6F8lydM9bSkscFVOq9tE2uIA8hGegVQYx84eCu3RDn8xy4Lr+kr+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=rambus.com; dmarc=pass action=none header.from=rambus.com;
 dkim=pass header.d=rambus.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rambus.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YA51S0pesopoKLwbt6yUIBshppdISFMB8sZGTlRdlEk=;
 b=JSNp6c4NR8WEbxOJLZ48CNvrVy7uPYiGYsAFpraF3JX71Tk7byo5fJOKconUtEIMbxOyE3lfJSTB/KVJ/LfVrp2aMI/Xn2ypj38Q/7SzZwstPQGDdf2vbLaWoT+PdnWbkd4gXydeSXF3ogrf1+htLAQ4hUrjD4Hear1MVGI1y7XeUPG+1t3MEIHuN09eCd/dC2OBLpRJ/fh2UqPJa1UZwbxJlqAM81O1O/gd8e+qpR90i7Ju73LmlgEPumatjxVTqutm7RcJw5SNjTO9xmXM4WO4HVO8xUsedVcRZsPrLL7nsLeez39gl1hshyplfkBO9k/vf7MJ0iEjNCT6jQ5KVg==
Received: from SA1PR04MB9851.namprd04.prod.outlook.com (2603:10b6:806:4ac::5)
 by DSVPR04MB10174.namprd04.prod.outlook.com (2603:10b6:8:3a6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.17; Thu, 25 Jun
 2026 21:21:50 +0000
Received: from SA1PR04MB9851.namprd04.prod.outlook.com
 ([fe80::5f38:dbea:4e4c:9a0f]) by SA1PR04MB9851.namprd04.prod.outlook.com
 ([fe80::5f38:dbea:4e4c:9a0f%6]) with mapi id 15.21.0159.016; Thu, 25 Jun 2026
 21:21:50 +0000
From: "Krishnamoorthy, Saravanakrishnan" <skrishnamoorthy@rambus.com>
To: Randy Dunlap <rdunlap@infradead.org>, Albert Ou <aou@eecs.berkeley.edu>,
	"Ousherovitch, Alex" <aousherovitch@rambus.com>, Conor Dooley
	<conor+dt@kernel.org>, "David S. Miller" <davem@davemloft.net>, Herbert Xu
	<herbert@gondor.apana.org.au>, Jonathan Corbet <corbet@lwn.net>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Paul
 Walmsley <pjw@kernel.org>, Rob Herring <robh@kernel.org>, Shuah Khan
	<shuah@kernel.org>
CC: Alexandre Ghiti <alex@ghiti.fr>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "Wittenauer, Joel"
	<Joel.Wittenauer@cryptography.com>, "linux-api@vger.kernel.org"
	<linux-api@vger.kernel.org>, "linux-crypto@vger.kernel.org"
	<linux-crypto@vger.kernel.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "linux-riscv@lists.infradead.org"
	<linux-riscv@lists.infradead.org>, Shuah Khan <skhan@linuxfoundation.org>,
	SIPSupport <sipsupport@rambus.com>, "Nguyen, Thi" <thin@rambus.com>
Subject: Re: [PATCH 17/19] Documentation: ioctl: add CMH ioctl documentation
 and register 'J'
Thread-Topic: [PATCH 17/19] Documentation: ioctl: add CMH ioctl documentation
 and register 'J'
Thread-Index: AQHdBMjaL7m/gAnGP0iQl0ogSD/mPrZPl3gAgAAv1so=
Date: Thu, 25 Jun 2026 21:21:50 +0000
Message-ID:
 <SA1PR04MB985100241C022033C8F4B952C2EC2@SA1PR04MB9851.namprd04.prod.outlook.com>
References: <20260625173328.1140487-1-skrishnamoorthy@rambus.com>
 <20260625173328.1140487-18-skrishnamoorthy@rambus.com>
 <60a7850d-1527-4517-aae8-cd5cbebcb9b5@infradead.org>
In-Reply-To: <60a7850d-1527-4517-aae8-cd5cbebcb9b5@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR04MB9851:EE_|DSVPR04MB10174:EE_
x-ms-office365-filtering-correlation-id: e00322b9-ffad-44a8-f011-08ded2ffc597
x-ld-processed: bd0ba799-c2b9-413c-9c56-5d1731c4827c,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|7416014|376014|1800799024|366016|38070700021|921020|11063799006|56012099006|4143699003|22082099003|18002099003|3023799007;
x-microsoft-antispam-message-info:
 KbUWLw+0+oelTWPHFRMH80sQ7lk0Yki0ui0oEF3gikUdsv/BuUo7T06O4NVp9ds0644UHi4HkljJ/lJX/TG+NyOUEutYwky5rhjN8aNSUALq9mxwUadfH98ivNLIjwsv+S+ER+iqosrQrMK64hKboCpgPxL9+Y7+on+oEveW7EPCrnatmoj+q8EOS+iOu2x6loRUhadNUUg+dA8/pVHrf0TTR4CT8NKigkZfMk4uYxNnaYrzIKGiC9n5SeLKkggNu/HirpCvnD+a1w2/v5MYiFiSf21b0G9IgyUtLG/yNJwGDvaECDLC2YTrlWMJHMkFGRvont6+vbhA1tp6eNVpkf7fkyEDYk6IZ2y/9EOkvTLyThpjg3AnhJ+xQRgqT2o/PLKF3Cl+kOV1PKonQUggYE97Z2bewobTX9iN4R1CtckO7cBH9fvb3i2GLBMNyj/hYG9ZpLB3D7cP3z23/r3k2rtcRHa2NeDpi6Fz5MGBUTxkY3RaC67wvun11rfquOxd06hXOBTjoU5xhiKGfxgxiYhzPya5hKO6TexM2pEf0bm1zNRRHJrIeSTz4S6QMpPLlVu77WuGG+tOFm7VsVmNMhLFcIOWJt/AomYpskBw4q/SW3SLezR2vHgY7Q3zNP6fvYSJTVhCd3QrmRF/UN3qXhdfvaZQzXkb5c5FX8nJNOpIZsF/XDg0FKi9BhsBQeAm29u7zBRQ2UUZgv1f+oboJFOhTCuHZzj7cc2yy0yB86A=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR04MB9851.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(366016)(38070700021)(921020)(11063799006)(56012099006)(4143699003)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?DrXJ097McVWHo4nbN3PpbmZYUbb91Bsu3aEd/dJVUI33VtXCDme9WfOAFtez?=
 =?us-ascii?Q?uikt3MPmk4dvoqz2NC1ceAyaKRvLHKAAQwSS155uJE09GQ9pmTLL+ojgDx5K?=
 =?us-ascii?Q?/RgAqYBMxRfaA0H7NVfUw9yr0vGpxiu/DkzsGSEdzWrHRR3UwuFDez+RFOzQ?=
 =?us-ascii?Q?lXh/XtG/5hWFb1PiG5svSY8fojaGCr4i6C89KSPm7g9nt4cdMmz6RujfctTU?=
 =?us-ascii?Q?9qAIKcUy/4CGaP5Gb7kNFhcP0Madkg0Z0PHcZDxNlTZOwVv60Vog5WYPlYse?=
 =?us-ascii?Q?o0vOsAlstMJcErU4zWdVd0T7ai1xPpanolmrWZ9AHjj0Dqm48mMdO5sIWKoM?=
 =?us-ascii?Q?2oEiX+q9zycUxpK+TOQ40kPnxdhIsmhFN8u7QGLf/D+w/9Q6upaf2+2vz2qv?=
 =?us-ascii?Q?jmSga7vEBEMFc4xh8yJbNOpulFplUR0l8bp9YEpMeyZaDZ8r7XbWtvyGzF6h?=
 =?us-ascii?Q?d2bxPWBhdzwoSzT5AHzjvcXcSpFecrk5juMNwZ1tym6+GzmfkCrHDKmi1Iq7?=
 =?us-ascii?Q?yByjy1vjkFctmYxmqCFeQazqnzT+stmyrXTkLqrABRQuXQnwn0EEGLjl5TgF?=
 =?us-ascii?Q?+Mpvv5O4m+culHPjw/i0dJXB+joaO5FyC0+wMDRSKOEhcBR9zXniWaxQFd8q?=
 =?us-ascii?Q?7+r0T5bSE7rvo3bjSVIL9fl0HG++AolEvST/za5yur0eBkCXSlXbPkIl9IAf?=
 =?us-ascii?Q?VoAk1yEq3HIkzmKk3db1STK0FtPgdZIGLKYkGlKOUUtdnWflZHCm8v023k/f?=
 =?us-ascii?Q?OAIekdEIbUXLlOow0FRfLYxDVK93FUa7U0F+I1oexv9ZMUex+JNxq4/5YsSc?=
 =?us-ascii?Q?QQlP60yPCdHhJLRzJ3C+H2EbsSqndITD9gDRfulNzTRJdo3coXRkAxnMqEAd?=
 =?us-ascii?Q?l0Qe70qoENoswcO2TPyt08Sdd88sJ9jyXi5REzj1R4j7E0m/GU4ICPsPZhjs?=
 =?us-ascii?Q?H0DmXUPZv3GwE17+5iOf7L4rDWYxqHlf+YirWSlXw2ccvz+CifxLblBbEJFo?=
 =?us-ascii?Q?GhBWESgohGv4EaZVtUNQGbbZGCkCoJApWXzKNYm7PWD5Vylzguk9JErN2SF6?=
 =?us-ascii?Q?EtMc1fg74xppgwFNdAQGPZvprI/t8+69AatXuG52r8OiCLBtL0ri2WMkBQ8R?=
 =?us-ascii?Q?OqIg3cuTRamCUFXEKqhZVPvTxeMqsSreUYxe6Jc2XU4GmAN1cs+Cpn57ibFb?=
 =?us-ascii?Q?HIoJ35Kbus0PRfqL4wOB4SrQcBiAV/g/Upa3vol9Mur/9R/usweJF96ZdDcc?=
 =?us-ascii?Q?C6DzYPDyFT7uC5xVL3bqpp5i/K4N7Szh01rkg7mjV7jFJsq9wrx26/Uh/Mwj?=
 =?us-ascii?Q?C4p0A0PQE0pYtk2IWvMJIyrT88NFEX1a2nBuUl476dzN9a4Ki9C+St8oNlrl?=
 =?us-ascii?Q?xa9/TSQ18NShkLceoY7ZlkAleyrY6mTyK5fDiuuld9dtAIK5kd3s9RK/qwS3?=
 =?us-ascii?Q?PNAPLutVozzpg+KAo+aADQDsOzesY+G2KFbgQVGQFhSzy2RoH5AfJUZYoS8S?=
 =?us-ascii?Q?NaCz8b44RplLXtW01uVYmaZfur9ELC6CHifgMA/Sv8t+7ElOgxHcXfEzKlvB?=
 =?us-ascii?Q?m3rvIX6Q4x9U+fA03j5dppYYwJbJMn9IMUQLQuPdChFlOYROI2U2yMyQYBg2?=
 =?us-ascii?Q?92tDoVcMzHS8jdzSUTz42t6FojvnOBjV90lCOhkdEiJdw9L7umGQIbsIwmbR?=
 =?us-ascii?Q?U6RLY632++R8BagRzG2sXf6d0WJUbDBuiWVBDHi0fTAAV6Cqx0akIguVBksu?=
 =?us-ascii?Q?LXqUpg80jw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: rambus.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR04MB9851.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e00322b9-ffad-44a8-f011-08ded2ffc597
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2026 21:21:50.6714
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bd0ba799-c2b9-413c-9c56-5d1731c4827c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qJrINyB66J0oepJbgqqIgmif1iOa+jy9k9DlZH9+nqyWK63TQnwLI3lI/oOfTLmC7lMxpkv+czHPKf3beGEnDMOFLPYaTS9Wb861l79xi1Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR04MB10174
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[rambus.com,reject];
	R_DKIM_ALLOW(-0.20)[rambus.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6707-lists,linux-api=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:rdunlap@infradead.org,m:aou@eecs.berkeley.edu,m:aousherovitch@rambus.com,m:conor+dt@kernel.org,m:davem@davemloft.net,m:herbert@gondor.apana.org.au,m:corbet@lwn.net,m:krzk+dt@kernel.org,m:palmer@dabbelt.com,m:pjw@kernel.org,m:robh@kernel.org,m:shuah@kernel.org,m:alex@ghiti.fr,m:devicetree@vger.kernel.org,m:Joel.Wittenauer@cryptography.com,m:linux-api@vger.kernel.org,m:linux-crypto@vger.kernel.org,m:linux-doc@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:linux-riscv@lists.infradead.org,m:skhan@linuxfoundation.org,m:sipsupport@rambus.com,m:thin@rambus.com,m:conor@kernel.org,m:krzk@kernel.org,s:lists@lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	FORGED_SENDER(0.00)[skrishnamoorthy@rambus.com,linux-api@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[rambus.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skrishnamoorthy@rambus.com,linux-api@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	REDIRECTOR_URL(0.00)[aka.ms];
	TAGGED_RCPT(0.00)[linux-api,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,infradead.org:email,aka.ms:url,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,cryptography.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BBED46C8B47

Thanks for catching this, Randy. You're right. cmh_mgmt.rst isn't pulled in=
to any toctree. We will fix it in v2 by adding cmh_mgmt to the toctree in D=
ocumentation/userspace-api/ioctl/index.rst (alongside cdrom/hdio).

Krishnan

________________________________________
From: Randy Dunlap <rdunlap@infradead.org>
Sent: Thursday, June 25, 2026 11:29 AM
To: Krishnamoorthy, Saravanakrishnan; Albert Ou; Ousherovitch, Alex; Conor =
Dooley; David S. Miller; Herbert Xu; Jonathan Corbet; Krzysztof Kozlowski; =
Palmer Dabbelt; Paul Walmsley; Rob Herring; Shuah Khan
Cc: Alexandre Ghiti; devicetree@vger.kernel.org; Wittenauer, Joel; linux-ap=
i@vger.kernel.org; linux-crypto@vger.kernel.org; linux-doc@vger.kernel.org;=
 linux-kernel@vger.kernel.org; linux-kselftest@vger.kernel.org; linux-riscv=
@lists.infradead.org; Shuah Khan; SIPSupport; Nguyen, Thi
Subject: Re: [PATCH 17/19] Documentation: ioctl: add CMH ioctl documentatio=
n and register 'J'

[Some people who received this message don't often get email from rdunlap@i=
nfradead.org. Learn why this is important at https://aka.ms/LearnAboutSende=
rIdentification ]

Caution: < External Email >

On 6/25/26 10:33 AM, Saravanakrishnan Krishnamoorthy wrote:
> From: Alex Ousherovitch <aousherovitch@rambus.com>
>
> Add Documentation/userspace-api/ioctl/cmh_mgmt.rst documenting the
> ioctl commands on the /dev/cmh_mgmt misc device for the CRI
> CryptoManager Hub (CMH) hardware crypto accelerator driver.  Covers
> key management, KIC key derivation, PKE (RSA, ECDSA, ECDH, EdDSA),
> PQC (ML-KEM, ML-DSA, SLH-DSA), SM2, EAC, and DRBG.
>
> Register ioctl magic number 'J' (0x4A) in ioctl-number.rst.  The
> driver uses ioctls 0x01-0x40.
>
> Co-developed-by: Saravanakrishnan Krishnamoorthy <skrishnamoorthy@rambus.=
com>
> Signed-off-by: Saravanakrishnan Krishnamoorthy <skrishnamoorthy@rambus.co=
m>
> Signed-off-by: Alex Ousherovitch <aousherovitch@rambus.com>
> Reviewed-by: Joel Wittenauer <Joel.Wittenauer@cryptography.com>
> Reviewed-by: Thi Nguyen <thin@rambus.com>
> ---
>  .../userspace-api/ioctl/cmh_mgmt.rst          | 941 ++++++++++++++++++
>  .../userspace-api/ioctl/ioctl-number.rst      |   1 +
>  2 files changed, 942 insertions(+)
>  create mode 100644 Documentation/userspace-api/ioctl/cmh_mgmt.rst
>

One docs build warning:

Documentation/userspace-api/ioctl/cmh_mgmt.rst: WARNING: document isn't inc=
luded in any toctree [toc.not_included]


--
~Randy



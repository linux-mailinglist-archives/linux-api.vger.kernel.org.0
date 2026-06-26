Return-Path: <linux-api+bounces-6715-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id R72+MNezPmrfKQkAu9opvQ
	(envelope-from <linux-api+bounces-6715-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Fri, 26 Jun 2026 19:16:07 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 21CD66CF5E7
	for <lists+linux-api@lfdr.de>; Fri, 26 Jun 2026 19:16:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=rambus.com header.s=selector1 header.b=QSZZIqOS;
	spf=pass (mail.lfdr.de: domain of "linux-api+bounces-6715-lists+linux-api=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-api+bounces-6715-lists+linux-api=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=rambus.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D41693014545
	for <lists+linux-api@lfdr.de>; Fri, 26 Jun 2026 17:16:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A8A637C910;
	Fri, 26 Jun 2026 17:16:02 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11022131.outbound.protection.outlook.com [40.93.195.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E55A2D8370;
	Fri, 26 Jun 2026 17:16:00 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782494162; cv=fail; b=IwjGlNwDzZiPkVHHzwdkGODYtZA7FNfo6vIlTj46fYfbx+0adY6kysjCmENcmVcNNUSDL20RmU1rRI/EpXGoFql5oPI/oPwea1IrF8i2nI2wgp9NYEFX75bVIA0w8KTlUYWJna9u1weocpfwFJ0/ubl5dzycgg+801Ed36pgaE8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782494162; c=relaxed/simple;
	bh=hK4pybsUgkZOLKrhXMsERfUwuxQgQDFVtrE2BIflXV4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hz+Kcgu1aEWxcjWBU0FTj29ktM0GJI4b5/6sajjTDizh+hxjMXeU9ckgEzonj2NFTBJG8W+QfKZtFQD3qT/PGslf0jgiajKm+TEHT1ebZ3zZHRFloA3CpksoJw1+sRsWgBFPyLi8BMA05+1td/taqfvtPgaie/48nzVLYSce2wY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rambus.com; spf=fail smtp.mailfrom=rambus.com; dkim=pass (2048-bit key) header.d=rambus.com header.i=@rambus.com header.b=QSZZIqOS; arc=fail smtp.client-ip=40.93.195.131
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B51aRV5f1ZE8u0WcDYPa1jXOiQ4+1KAKK15P6AKjgVV92wSYUMCEQ1VaMho9UujxeYbsoBZlhPvf0cUOxK1pJ9LGeCyxzYYD+K3yCl1a9mf3PmMTRbmN8AmNGVPfqo/RIySvj28D5OZexP704hgwF4k1jlXgVSLn38siIWXmpPU+YC4XVfn6s9D27lAcou8RmjtCvgPnuaLgRNfM05rHiIo/fW5tlsZ1R2cISdpoc/0S1G8NhluaclAPCO7E9LtMi5y6YC8uIQtVVqT80eynwLR22GQpqp5712DS3KSZzi1tf2PhSt/yvLRZBDZhbIksoH9xkHd7w5yO+ayDrrTgrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dHk7bdevnza8YDrilNUlP8i9oy/vzflv77OUa0a/1wc=;
 b=QDTckK7YQH8EMLgzQ3a2LLh/X+b7a0Tbs+mn+fFiHBJsWkGjXXYxf/dwTiWLrQngooR31gCrYnkiNS9zL5xWvRl027sgxYxoFQsEirt+Qsxlq9dN1huYMTi7517EEcR/AqiKm0dgCpiz7Uz7JoHWZ+WkgIDcVjduEvsFPPJwYDRqGIAJBk4jhgFXliBlWPHMOngBrcvrMk3BKm7qdQRA9MVAqDsxCTVVKwCWRa6C9BkdA/Jcb6eU8vfZAZ+QxOeAREpSzI2fv1BcL7CKdFVXuCfUwPQOUxpNEaQeAj66JKH7Xxp3nvq91h74Hc596mCZBQNLgLSULuvdoEOrsviyMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=rambus.com; dmarc=pass action=none header.from=rambus.com;
 dkim=pass header.d=rambus.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rambus.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dHk7bdevnza8YDrilNUlP8i9oy/vzflv77OUa0a/1wc=;
 b=QSZZIqOSL3exA8bpqG7ZuT1WHWM1B7+W7KcVFkGQE5rfvFOYvTYMAfiCr5hW3dRRY26cD8xwz2wfYoUiWrdCuNeNnDoL0r+6E2Cj9mdMWrjV1yuUNRHc72nKHd+UssPeitXMva9WZw/Xcn+7Lci4pjGKzOorElgXmD0BASfT27dE6jyD3ir2zv0b0atNNsXVrzyA68qnbeUVmBqq2tOSqQlVGb0YSP3VQ60/z0rZqnu2BkVzYU0dwK6lrj88/0NFNHPR5gRgOlOkJIT8D5aSQDGom5oxLR9wzgLi2PooMoZC4/SQjTjvAOX03U1LrNOZoLIzhS+gCtNVmrLFSkLvBg==
Received: from SA1PR04MB9851.namprd04.prod.outlook.com (2603:10b6:806:4ac::5)
 by SJ2PR04MB8581.namprd04.prod.outlook.com (2603:10b6:a03:4f6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.14; Fri, 26 Jun
 2026 17:15:49 +0000
Received: from SA1PR04MB9851.namprd04.prod.outlook.com
 ([fe80::5f38:dbea:4e4c:9a0f]) by SA1PR04MB9851.namprd04.prod.outlook.com
 ([fe80::5f38:dbea:4e4c:9a0f%6]) with mapi id 15.21.0159.016; Fri, 26 Jun 2026
 17:15:49 +0000
From: "Krishnamoorthy, Saravanakrishnan" <skrishnamoorthy@rambus.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: Albert Ou <aou@eecs.berkeley.edu>, "Ousherovitch, Alex"
	<aousherovitch@rambus.com>, Conor Dooley <conor+dt@kernel.org>, "David S.
 Miller" <davem@davemloft.net>, Herbert Xu <herbert@gondor.apana.org.au>,
	Jonathan Corbet <corbet@lwn.net>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <pjw@kernel.org>, Rob
 Herring <robh@kernel.org>, Shuah Khan <shuah@kernel.org>, Alexandre Ghiti
	<alex@ghiti.fr>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"Wittenauer, Joel" <Joel.Wittenauer@cryptography.com>,
	"linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
	"linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>, Shuah
 Khan <skhan@linuxfoundation.org>, SIPSupport <sipsupport@rambus.com>,
	"Nguyen, Thi" <thin@rambus.com>
Subject: Re: [PATCH 01/19] dt-bindings: crypto: add Rambus CryptoManager Hub
Thread-Topic: [PATCH 01/19] dt-bindings: crypto: add Rambus CryptoManager Hub
Thread-Index: AQHdBMjWbbt+vQeNuk6AgpyYttH26LZQqwqAgABoWTo=
Date: Fri, 26 Jun 2026 17:15:49 +0000
Message-ID:
 <SA1PR04MB98512F483110B601D5B335F8C2EB2@SA1PR04MB9851.namprd04.prod.outlook.com>
References: <20260625173328.1140487-1-skrishnamoorthy@rambus.com>
 <20260625173328.1140487-2-skrishnamoorthy@rambus.com>
 <20260626-radiant-affable-raccoon-f48b9a@quoll>
In-Reply-To: <20260626-radiant-affable-raccoon-f48b9a@quoll>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR04MB9851:EE_|SJ2PR04MB8581:EE_
x-ms-office365-filtering-correlation-id: 4811c2a7-23a6-4aba-7685-08ded3a691a3
x-ld-processed: bd0ba799-c2b9-413c-9c56-5d1731c4827c,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|366016|23010399003|1800799024|376014|3023799007|56012099006|11063799006|4143699003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info:
 sUhTB6H/VVbQDpub1hNTrq67Wn9rHUh07w9xIxGVwOEe+mX9J4kYGiWzyw7cLNC2+avlufJB6xcFz/X8etM3WMwdgbTq5bw0w1+RSx+Str+R7sjc8b76wvoP/6+LWMMovNl8/QKGPmHTfd3sBBT0iMaJUHT189MwGD1myshzGeK+1sPcQPM9qbvvv2yurVAfw3JIz3nkY9H85My74Efa9Fllb9IxxeyAPzV9/14z0jjAF89nIbDSoIVSTLkQPHSEX1+RYsxDZM424hqV5orjRjqqNFho9BsEK4P4Ew6eUY6ErPZN+jf6sdeHugZSUekHip3lVBWaTCTHojLC28voNqUirc5HeVXMX4Eo580f0EUQ7tlkahQY6jcit7txxaJxdRuoKi0dkNNyx1Qzj/menDSUG/AJFBeiU54eSsxpdoq2TQEIfzy9aCV7tIAMKLht2npa451Zx10knRUtMhMc29zCS5oxnKqIvSXiJxxFCR+bqJd/9TDsDwzz2k2OZb26H2DDz8OA5Y/Co57B2P1+0zdhiMK4WaO0I27cuzHQbwVK+SwPmzRtmn1nlQ6l3pAKD+sqJli7u7a0zRT6v4f6oEc9/RfPa2ZzXdtCztcp5kKE4Sji9H917OPozinVPgTOwHQSsIWQUgGLwEj2OwynNep/xSBGxXTGSjGUFeoRhn8cCzeRCgKbQN4W66MH66ujkXxCi/WTM40cf//D72mkLsZ51kRhN9XAab26yWpFRdw=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR04MB9851.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(23010399003)(1800799024)(376014)(3023799007)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?DpbhL0m7kSGisyGbDBerOesHbI/8sR+fDZOJ0/y5YTps616nyYj5SKDC8efQ?=
 =?us-ascii?Q?lvCCNv9/+XqMQ0o/tnebJ87Wzkh2ILyxK3A91l9VWO1FmS9ibJbN0SGEsZr7?=
 =?us-ascii?Q?jSANsz9Hy6EWibr7FK/1nxJOeuBw5liaSiMWF4ssx5sWiy48PQKhNo7gVfwJ?=
 =?us-ascii?Q?dClb9luJqWUZAhW53fb+JR1DR/7ksyzBaqo7JtMPsoaIUEE99Pyqn3Bc0eGB?=
 =?us-ascii?Q?i4LRazSMvS/tELZWTaANX4jKEsn2KgX6XfstMHxUhDkRrvKCl9TOLHOeHpxT?=
 =?us-ascii?Q?W/hCf0+AAE1ARYAei9oQWnuU1b5mM5e/3q9SOKyLdXo5r1c0i8hon441IMSP?=
 =?us-ascii?Q?bSr0vPznySq4GxUl3QaZa1v63CNOs5bISwua+LKEjAilVxZC2vE97049MpIQ?=
 =?us-ascii?Q?Xe55elB1Ep4AEfiPQCANGhlZf1YvxvfC/NufypQgcy52tTUOCJd5swVrhKft?=
 =?us-ascii?Q?N0INmFMBgnlHfBTdRxpZ0JlNLxbicp15XF1uhAD80pHIzAbRKqmAWHoeR3bx?=
 =?us-ascii?Q?KWa9xdaxYSsNXMAH49qA2YV8pykNYjUf+tgmdIJGgdHZOFo85oVypru4r6Iq?=
 =?us-ascii?Q?Lf/rMf/0uwz1LFOfaDA1+Lfi8yBlW6fXodClkKJzcgccQmX7KNy+GS/N9r5j?=
 =?us-ascii?Q?1ND0x4iPM9XDxvIG6XFVLwGeZxRH5yRJC0CwZAxgtwknH4sSElPlur5h1wUp?=
 =?us-ascii?Q?+2Nr0NIPgjrOD406forg9nbFUtfJs+Jk0ze3DNg0rik1Wd4HGZj24AaPyMBa?=
 =?us-ascii?Q?jXPyd/Iptb6YKcPydp5LsYv4CjSxXUJbcElFIs+qtYBpwnRvNHHvSAXK9cqj?=
 =?us-ascii?Q?Hhm7rGdgdmYN9TV065mqroHt1eAzKnivWVa5pVYQDEcgdGKjskTTQ2p7soVq?=
 =?us-ascii?Q?XQARstr7zjoCltLXM9RZlReN1f1/N/GHSpWjTjSNhgGoiVreghP3iEoq10RQ?=
 =?us-ascii?Q?z0AWUdlwukf69DxdoBe//3Qx58W9rIoI+M+uQNDob2+l2weiJLWFspY4Bdd1?=
 =?us-ascii?Q?ezvjOSuv1MnhqPh1sP1Fr1NVnGPyigYMf4lbdfG7zQsVZVn+nqhOCGhlg6qJ?=
 =?us-ascii?Q?U9JoF5bfSAl6vm4bChwX6sJNLBlHFu2Ijjm8QHiQsxLydYc/p35S2l8nkwJs?=
 =?us-ascii?Q?X5RLCJxyzUxl3zCFz5OSFwLg/tYaG5XWryzQIu7s69+lOwY/dUPLaSHoh1Ws?=
 =?us-ascii?Q?VL9kgFj3XQ493ZexYZ72gORGdleEp7jbYTFLs0O9ZeYKKR/9zWKOrK84+OoH?=
 =?us-ascii?Q?udqjWSFNr+zJ/bVW1IHD6eGKDhGhxxIdcInIvQ5oZHKJqfTOC4boTbSOvFqz?=
 =?us-ascii?Q?410jnxl7OTMJi+ENT25+ZMOmx2r3twJbpJJXnyg3krBmOV8Z2SURtrAd/3JE?=
 =?us-ascii?Q?/MCdNPYg+8mWfVxHzxLvr9WVn9iP0Efoq6/dgHmW0qgNsytqJ3hi37SvGrt/?=
 =?us-ascii?Q?LZ/rf8wPillYS0JUgaZkrzpHt6GjFKXyp/seuS3pzj42bHl7UzLijaGlZYwR?=
 =?us-ascii?Q?J2H+goeHAT5eFz0Ir4EziFqLQqC+DkjQY1KVuk4PW+xKl+mgWkKE8U7lpiNu?=
 =?us-ascii?Q?2P0hpAsdPenum4D13v1xDty5Fk/UdCLWOkdAPpFH1VtYbRZ+4yIXbCXdS8Em?=
 =?us-ascii?Q?oqd1ASdAVxPKnkWUC0b7MM5J/ESOJ+dnMF7C1SSJeN3W3z/onlmHaYo1lcfK?=
 =?us-ascii?Q?I5BjuOkSUx7UhkbKb03tSMfSJ8+YFmoNwIednoVsW1vOA/3PJBnsDzkJMaWm?=
 =?us-ascii?Q?NMX3F2RMyw=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4811c2a7-23a6-4aba-7685-08ded3a691a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2026 17:15:49.4225
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bd0ba799-c2b9-413c-9c56-5d1731c4827c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZsQbvMO6uAPO/50tLqHRRziXnNe4d1kGxxFKlhkhDFHWQZW0YBIZ4M8kmt67pI48F59h0J0EsQZscrk3ls6elinqB9WHB6QHYhBNKYcFDZQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR04MB8581
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[rambus.com,reject];
	R_DKIM_ALLOW(-0.20)[rambus.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6715-lists,linux-api=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:krzk@kernel.org,m:aou@eecs.berkeley.edu,m:aousherovitch@rambus.com,m:conor+dt@kernel.org,m:davem@davemloft.net,m:herbert@gondor.apana.org.au,m:corbet@lwn.net,m:krzk+dt@kernel.org,m:palmer@dabbelt.com,m:pjw@kernel.org,m:robh@kernel.org,m:shuah@kernel.org,m:alex@ghiti.fr,m:devicetree@vger.kernel.org,m:Joel.Wittenauer@cryptography.com,m:linux-api@vger.kernel.org,m:linux-crypto@vger.kernel.org,m:linux-doc@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:linux-riscv@lists.infradead.org,m:skhan@linuxfoundation.org,m:sipsupport@rambus.com,m:thin@rambus.com,m:conor@kernel.org,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	REDIRECTOR_URL(0.00)[aka.ms];
	TAGGED_RCPT(0.00)[linux-api,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,infradead.org:email,SA1PR04MB9851.namprd04.prod.outlook.com:mid,vger.kernel.org:from_smtp,aka.ms:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 21CD66CF5E7

Hi Krzysztof,
Understood, and apologies. The confidentiality footer was auto-appended by =
our corporate mail gateway, not something we intended on an open-source sub=
mission. We've had IT disable it, so it won't be on future mail. We'll rese=
nd the series as v2 without the disclaimer.
Sorry for the noise.

Krishnan (Saravanakrishnan Krishnamoorthy)

________________________________________
From: Krzysztof Kozlowski <krzk@kernel.org>
Sent: Friday, June 26, 2026 3:55 AM
To: Krishnamoorthy, Saravanakrishnan
Cc: Albert Ou; Ousherovitch, Alex; Conor Dooley; David S. Miller; Herbert X=
u; Jonathan Corbet; Krzysztof Kozlowski; Palmer Dabbelt; Paul Walmsley; Rob=
 Herring; Shuah Khan; Alexandre Ghiti; devicetree@vger.kernel.org; Wittenau=
er, Joel; linux-api@vger.kernel.org; linux-crypto@vger.kernel.org; linux-do=
c@vger.kernel.org; linux-kernel@vger.kernel.org; linux-kselftest@vger.kerne=
l.org; linux-riscv@lists.infradead.org; Shuah Khan; SIPSupport; Nguyen, Thi
Subject: Re: [PATCH 01/19] dt-bindings: crypto: add Rambus CryptoManager Hu=
b

[Some people who received this message don't often get email from krzk@kern=
el.org. Learn why this is important at https://aka.ms/LearnAboutSenderIdent=
ification ]

Caution: < External Email >

On Thu, Jun 25, 2026 at 10:33:09AM -0700, Saravanakrishnan Krishnamoorthy w=
rote:
> From: Alex Ousherovitch <aousherovitch@rambus.com>
>
> Add device tree binding schema for the CRI CryptoManager Hub (CMH)
> hardware crypto accelerator.  The binding covers the parent SoC-level
> node with register region, interrupt, DMA properties, and per-core
> child nodes identified by compatible string and unit address.

...

>
> ** This message and any attachments are for the sole use of the intended =
recipient(s). It may contain information that is confidential and privilege=
d. If you are not the intended recipient of this message, you are prohibite=
d from printing, copying, forwarding or saving it. Please delete the messag=
e and attachments and notify the sender immediately. **

OK, we are done. I am removing your posting from Patchwork.

Best regards,
Krzysztof



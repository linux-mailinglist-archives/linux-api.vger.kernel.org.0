Return-Path: <linux-api+bounces-6835-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id dC/SIVdyVWo5ogAAu9opvQ
	(envelope-from <linux-api+bounces-6835-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Tue, 14 Jul 2026 01:18:47 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A02874FADD
	for <lists+linux-api@lfdr.de>; Tue, 14 Jul 2026 01:18:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=rambus.com header.s=selector1 header.b=4paO3ghM;
	spf=pass (mail.lfdr.de: domain of "linux-api+bounces-6835-lists+linux-api=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-api+bounces-6835-lists+linux-api=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=rambus.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6EEA13047027
	for <lists+linux-api@lfdr.de>; Mon, 13 Jul 2026 23:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE6E93D7A01;
	Mon, 13 Jul 2026 23:17:28 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11022130.outbound.protection.outlook.com [52.101.43.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE6A3D3D09;
	Mon, 13 Jul 2026 23:17:26 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783984648; cv=fail; b=fH+W7+0j5dcEqwlNzyVdbe/zXnWyyl/GsrRlJtKjZN3TjjLCdJguKoax/1WdXt0pM1wz4UZQ2KcQ3++iqNS7H0XKJITxSCQNJi2VdXJRP+ymwqGAKEWUyuVv8qvNB8lNNgtQwoQkmuMgrHDwBdlFikehVEFGxtOo+HDTdkcpWxc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783984648; c=relaxed/simple;
	bh=KP4IS+NJyeWUGwxgKau0ZWm9Gi7mCZOmE5OO9keyZP8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EvGK2Ja42nP5o8ra3Hlr+1S3nTVI/U25wsvcB2quawbITJBMtnSczPvn9d+qgnEgHXVvk6+Do4825PLcKMwKsdHWu+GiTNyfFhR11LzDIIJpcayiViW5y7ORWiPiXvjKd86pQ+Hc2VeV/WxNv33kwOMRbnsBnJCYFwfsyMD6rko=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rambus.com; spf=fail smtp.mailfrom=rambus.com; dkim=pass (2048-bit key) header.d=rambus.com header.i=@rambus.com header.b=4paO3ghM; arc=fail smtp.client-ip=52.101.43.130
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G6OZar+1sCmvc5v5PbjYAebfk/NnNYOfskcMS9Xq0dbp5hgIlEIB9ReIlkRt+boE8unQm3J4wkSE0VGFY0OoDQKvM2Lx48Hk5lrvu5xbkkCnWTD7bYIloh6YFHiJw6n/WDEh2YjjAHg3GVLkazHvVmP5xPxXUO0rZPGfX9ZihvMkwJjvA63xL1H0bAyZl6UymR6qnhekyVbQejx4XSoD0Mij/3duOqLP4vJThy6+W9+5jXqzW297ssYbcAb77Gxpqt0cE2fekIRDj4eHGH8s2HdQpSseqh6tpivvMm8EjSttCtWtu5Q/BQQMIIJ9dBazHwAKbG+ZuAO/ArS4IcK5uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XlokhTNmQnMlSk/SvVWNKFln8Yvmnxi25KW4cKZf+0o=;
 b=iEMx1E02zcM9kkDlC2+TWsFMhYzIvQZSYqFwu3qEQ8hPjSy9v1wYXtlBKzwXYk4vDoGlU+N7FktWB5bZr6RV7NSCCVrfUBBmU4Og2TdggOXn0DKOe0fJxhWK9n5WLufS/OlwVS0AJJF4ChL7nvKy8Kac3pu0DORAbMhCfETl59rXq8w/D0qxr0fI4vRd2XokswBtZ+5TvR7xmTE0XE+sKmFnQ6uW/9eX1I5NT4JiABWx4AAbVYXYAGZjJaM+1mk17rWxvJ9IT5PgEPWk8I3ryafDxDJZP+vlYufcRRSdB3dW4v0KG5/CMTMT71Uh91pArg96MhjfgopvESmHZhKsRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=rambus.com; dmarc=pass action=none header.from=rambus.com;
 dkim=pass header.d=rambus.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rambus.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XlokhTNmQnMlSk/SvVWNKFln8Yvmnxi25KW4cKZf+0o=;
 b=4paO3ghMNdGwTzp6i732ze+Kb5YZPqgdqSLD7Mi4ZG5BrEYgvLEf14FvHs++EZYxn62EAa5jg0mporcWv2j83XKrJpK5VyghvrScIvjhzjE4f2kCdqs7Uggi3Gg11uOuL0z7QUvM+d7mMkaL+1l9RlHdGU9coNyRZt80TVHKrDxGwo2JfUu/BQF+oBkdAxmYz3FS+PQUFBNV3/my8edm1uq4CpmKvdpibqClEpoVlcW8trNBN6L6Sq9ZRmup8AWkqeVBUkloMjbbcxNjJ/2SstvUn0G5yf6wYY+MU2ut7f0OEhQv1vUUvcntcWJMrajO8HZQEGpNikEkb42l6/bjNQ==
Received: from SA3PR04MB9001.namprd04.prod.outlook.com (2603:10b6:806:398::17)
 by MN6PR04MB9431.namprd04.prod.outlook.com (2603:10b6:208:4f6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Mon, 13 Jul
 2026 23:17:23 +0000
Received: from SA3PR04MB9001.namprd04.prod.outlook.com
 ([fe80::3da3:45d7:8860:e196]) by SA3PR04MB9001.namprd04.prod.outlook.com
 ([fe80::3da3:45d7:8860:e196%6]) with mapi id 15.21.0202.018; Mon, 13 Jul 2026
 23:17:22 +0000
From: "Ousherovitch, Alex" <aousherovitch@rambus.com>
To: Conor Dooley <conor@kernel.org>
CC: Conor Dooley <conor.dooley@microchip.com>, "Krishnamoorthy,
 Saravanakrishnan" <skrishnamoorthy@rambus.com>, Albert Ou
	<aou@eecs.berkeley.edu>, Conor Dooley <conor+dt@kernel.org>, "David S.
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
 Khan <skhan@linuxfoundation.org>, "Nguyen, Thi" <thin@rambus.com>
Subject: RE: [PATCH v2 01/19] dt-bindings: crypto: add Rambus CryptoManager
 Hub
Thread-Topic: [PATCH v2 01/19] dt-bindings: crypto: add Rambus CryptoManager
 Hub
Thread-Index: AQHdD+HshuImNmj2q0GDF9X/lpOPwbZmdM8AgADs7vCAAn+MAIACOkyA
Date: Mon, 13 Jul 2026 23:17:22 +0000
Message-ID:
 <SA3PR04MB9001B1D246895B224C6EFD54D7FA2@SA3PR04MB9001.namprd04.prod.outlook.com>
References: <20260709203037.1884436-1-skrishnamoorthy@rambus.com>
 <20260709203037.1884436-2-skrishnamoorthy@rambus.com>
 <20260710-siding-unmatched-5e066fbe4c01@wendy>
 <SA3PR04MB9001E7DC9B2D4788EDCE2390D7FD2@SA3PR04MB9001.namprd04.prod.outlook.com>
 <20260712-washable-clapping-5dfb79d1bdef@spud>
In-Reply-To: <20260712-washable-clapping-5dfb79d1bdef@spud>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
dlp-product: dlpe-windows
dlp-version: 11.11.2.117
dlp-reaction: no-action
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA3PR04MB9001:EE_|MN6PR04MB9431:EE_
x-ms-office365-filtering-correlation-id: f7d72489-590d-486e-23f8-08dee134e494
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|23010399003|7416014|366016|38070700021|3023799007|5023799004|22082099003|6133799003|4143699003|56012099006|11063799006|18002099003;
x-microsoft-antispam-message-info:
 1p5nyxPAOO5cqcwyZtpdemqAxdbMjfuU1CnYgQ8goM0Kx4roEXXMuaXWsJLpB4FnuLmIGo0OLIxWKd7brCugb8PgNBlP9D1ebPrNhFDk++dDtt6D75h2y1vQEcPPGmDSZqVqWvvuWrEVnSf+O3Gn52I4zMQJ6j/AUwXqwinPu+okdARJzkOZnD52S0jC1lyaWOPKGsK/ArngFLhUbI6uWWS0YAuo1zIfCPKqkYw3mh+lgaiBAwU3YJk2AgKtrBA+5j/dUGF2KSCIVcDHlAvOrul5ksO5WhchQeOneRvS6jfWqN6wFczUlvNas6pluoU4qzMqMbgU5+eO8OAADKpEvmgbmoIn+pqdpnU24NrLM2MsaaTSKzYrRpVaPlyQlcxpndZ2vf5kqfrw7nK2W0oWVt6vHZ+ivZdBlJ1E1RnIyubnJAn9xP+eIPejr9S8AkhsIYGXiUIpXd1XEhNbCbDg2Pe2orEXnwbI/SgD1SwS2YC1U7O69CozJhOG11ZU/x1uMuDLK43iJSwRqXbzd91ZbtnhUeWurnJCP9ZHa3ZxYjA+cJY/oojc6eNFmv8kP2fqppHJL43ZXn6a9MUVBJE/8gJAObN9mcA7L+kqU/kYQtEyMD9YlN1voxYlh4Yx2tdr6GatJlx3Kb1uVgivF/On8jyGCKd33yE6rUWI4BeFXz6rtlFetf78P9J2gWEVUrWu4cs9lPovgKQd6fxgs98rt5mosSd+3KpttxJMux2CW4w=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR04MB9001.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(7416014)(366016)(38070700021)(3023799007)(5023799004)(22082099003)(6133799003)(4143699003)(56012099006)(11063799006)(18002099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Qp1/DADRpG65yC/3V0VJ2vIjTcOKaTb8U73vZgIVSNGxIqTbqiwshHCk6A+0?=
 =?us-ascii?Q?qexc6u8mjCCKQSsWxNsF8d07lZht4gSHh3CN1cjCUOIJ5AmWQvKiPYErDDcs?=
 =?us-ascii?Q?DQ/gL9tNdZXsy3PImXAqcTQu9cTPVgCRGtX6VUxT3nX2c8FcnyEesOwD+SFh?=
 =?us-ascii?Q?kYCBpzR2zZogj24ya78PYOv3uhw1JkeDVK8jeaPAP4jSyVSYy0ZInPfSS420?=
 =?us-ascii?Q?M5AFcIxRc4HfYHgu5mzsZ+iX6lNqrtVcF1sISDbReasUd8MaguwxeSYGuHYC?=
 =?us-ascii?Q?9HKFDq+klHMVd0BG4aqTkqdJ1nM48O0/yF2n8kUD7J0Jfl1/qhnjBaIiMleN?=
 =?us-ascii?Q?nXpEvEQ7ZpMTfiRcWBgjEpEaGgkSxh8q+gNbL8TBp+PxzpoPHbTmvXUvubdF?=
 =?us-ascii?Q?wLMsC0HiCiOceKFm5zXyol/TjGoBKmOsUEC2PXxi6Kd/Kz4g3RYaAptRsn1q?=
 =?us-ascii?Q?sfh5snwWPSW39HlUuQJpFwM5quJgKk3bPuEiMPvrGcp4Oc8NHaQgPKYbcXPU?=
 =?us-ascii?Q?dGvukhYUmNoFnAOXy72bVbkTnz/kw648e2uhYXX0ui4rCK+65/UFSg0dDbwR?=
 =?us-ascii?Q?vXcQSdX3nhWOSwJS3O/Uatgw4xeCGs4xC+k7HLXULlTF8stjbw29kKR/c/Iv?=
 =?us-ascii?Q?TFZbGFuUZXm74VfDb34G5+6UpLdHz8UXNxj0kyVYFjYiA17JtFcpI/c1NCa4?=
 =?us-ascii?Q?ioflrY9bynO0IBvg0LPEuFfqmTJDA2aMwi52qsCd0b+tHEKEPydZnN0S734C?=
 =?us-ascii?Q?5cOENPwm0oEuxVKPKcl8n3I5fXH1mpKFzfc8t0x09e7YG8tcE5FEWRl7RvC9?=
 =?us-ascii?Q?OdNBieNkH4AU5NIT8rA2Rj5s3r0Y5aGXQzEmK0o0qcm20+Jp1Q3g+pA5u69E?=
 =?us-ascii?Q?pIV5JrG4s3qVLjoC7hZ83YJsW1u0hE5NMMGFycgt27Nn8zBHk/iBmjsw1Jib?=
 =?us-ascii?Q?o/SEYT8wlYly/NtivJidHcdzG9WKco/f1ymXsji32iL6HEuiJp6xjxWhXsJD?=
 =?us-ascii?Q?lH6ANa0tvJBmQcZgFMwyN/QGDHLQci2AtR+r3wtx0eSNHZng2M+uO5wQmnrg?=
 =?us-ascii?Q?PF+gMnaSnOazymXHyUJs24GgXlowi2vJMkWv0JfBdc9F31mItKCItpjC5ntZ?=
 =?us-ascii?Q?FeqLsNKUM8v4lAQBPhH3j65OgIgi+zl3cx9kFchP8lmfax0EObTHgIfTurCj?=
 =?us-ascii?Q?AEoJ/H64TmOChShajn5GNYfUehkyzBzu2EMHiqDDSSDWId4Cyoq0fbZ9mrUI?=
 =?us-ascii?Q?67nsr8vhkeG6yNygcrhmM8bAEzzNsl1yioXi0Z7iXK4X/Z9D3BLttHRQT6lz?=
 =?us-ascii?Q?JlJfsuQNn7hrc4QVtSQRbZ50l1KTW/WWeuXp8/dCjH9mk21PZy9hVwql4Xfg?=
 =?us-ascii?Q?S4UgYwixlK+F8UrTffzoPMD4GbWbP5H9aNd4f13NsV1H1PCUhtzXl5rLp1Iy?=
 =?us-ascii?Q?WmNNoeJxTbKOh6XVid19DH4xsW6kFtMgj1r1zqY/+RvWjQXpGc/rB/gXg/Uz?=
 =?us-ascii?Q?FdDxS1ddqvZate3n4jUoLTQD8msP/Us2RZb0ID4f0rx0s5/h7GSossQmIskh?=
 =?us-ascii?Q?zRU7mG/aRYGeUZ/LgDZi8M/kmeSd+Emyx4pbbmGrw0QFd6q9eyCgH1E64TQl?=
 =?us-ascii?Q?rPdOucVuQCTQOZ6/DevAe57T/hfe2lTHblH0yzJSg9QbWThZ4m/T6MrCU026?=
 =?us-ascii?Q?Cpyh7d+LYPyYw156BzX7uX/CYkpOEWcFGKgk3gHTJFpetNBp1dLzgkTNvxpU?=
 =?us-ascii?Q?G3TxSuGT9Q=3D=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: SA3PR04MB9001.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7d72489-590d-486e-23f8-08dee134e494
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2026 23:17:22.2524
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bd0ba799-c2b9-413c-9c56-5d1731c4827c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sTE0WmePlUJ2pOQjM34m121XHF6DSEA4QwW1WEDnYdtaFguhbF8ztPDjELtfuxrcMslykacqWYKRDpB+rPIDMF9StK5t5ur9DFyR0o29K/0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR04MB9431
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[rambus.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[rambus.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6835-lists,linux-api=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:conor@kernel.org,m:conor.dooley@microchip.com,m:skrishnamoorthy@rambus.com,m:aou@eecs.berkeley.edu,m:conor+dt@kernel.org,m:davem@davemloft.net,m:herbert@gondor.apana.org.au,m:corbet@lwn.net,m:krzk+dt@kernel.org,m:palmer@dabbelt.com,m:pjw@kernel.org,m:robh@kernel.org,m:shuah@kernel.org,m:alex@ghiti.fr,m:devicetree@vger.kernel.org,m:Joel.Wittenauer@cryptography.com,m:linux-api@vger.kernel.org,m:linux-crypto@vger.kernel.org,m:linux-doc@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:linux-riscv@lists.infradead.org,m:skhan@linuxfoundation.org,m:thin@rambus.com,m:krzk@kernel.org,s:lists@lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	FORGED_SENDER(0.00)[aousherovitch@rambus.com,linux-api@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aousherovitch@rambus.com,linux-api@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[rambus.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-api,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[SA3PR04MB9001.namprd04.prod.outlook.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,rambus.com:from_mime,rambus.com:dkim,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1A02874FADD

On Sun, Jul 12, 2026 at 06:16, Conor Dooley <conor@kernel.org> wrote:
> Please fix your quoting, you need to retain context beyond what I said
> so that people who get 100s of mails per day (me) remember what it was
> in response to.

Apologies -- retained the context here, and I'll keep it in future
replies.

Short version: v3 switches the vendor prefix to "rambus", makes each
mailbox a subnode with its own reg (as agreed), adds a device-specific
compatible, and adds clocks + an optional reset. One property (the VCQ
ring geometry) I'd like to keep in DT -- reasoning below, happy to be
overruled.

> > > This company no longer exists, you should probably introduce a
> > > rambus vendor prefix instead.
> >
> > Cryptography Research, Inc. does still exist -- it's now a
> > wholly-owned subsidiary of Rambus (our co-maintainer is
> > @cryptography.com). The prefix names the IP originator, which is
> > consistent with existing subsidiary/acquired-vendor prefixes in the
> > tree (e.g. al =3D Annapurna Labs under Amazon, mstar noted as acquired
> > by MediaTek, fsl, cavium, xlnx). We'd prefer to keep "cri" on that
> > basis, and can annotate the description as "Cryptography Research,
> > Inc. (a Rambus company)" to make the ownership explicit. Happy to
> > switch if you feel strongly.
>
> I'm not sure that these examples actually aid your cause. al has been
> replaced by amazon, fsl is not used for new devices, new xlnx devices
> use amd (only example for now is the riscv stuff I think), cavium has
> had nothing added in donkey's years etc. mstar I don't see anything
> new in years either.

Fair enough -- point taken. v3 uses a "rambus" vendor prefix (added to
vendor-prefixes.yaml) and drops "cri". The description still credits
Cryptography Research, Inc. as the IP originator.

> > > This whole subnode thing seems like it is only required because you
> > > don't have device-specific compatibles [cores].
> >
> > Core presence is actually discoverable at runtime from the
> > CORE_ENABLE register, so v3 will drop the per-core child nodes
> > entirely and probe for enabled cores -- no per-variant compatible
> > needed.
>
> No, per-variant compatibles (for the devices/socs that this IP is
> integrated into) are a requirement. While it would have been handy for
> detecting capabilities, it's a requirement for other reasons:
> differences between integrations be that functional or enforcing the
> correct constraints on properties, issues only present on select
> devices, etc.

Agreed, and done. Runtime CORE_ENABLE probing stays only for capability
detection; it does not replace the compatible. v3 adds a device-specific
compatible keyed to the IP revision:

    compatible =3D "rambus,cmh-v1030";

with an SoC integration expected to list its own compatible first and
fall back to the IP one:

    compatible =3D "<vendor>,<soc>-cmh", "rambus,cmh-v1030";

This follows the pattern already used for licensable security IP, e.g.
inside-secure,safexcel-eip197b and arm,cryptocell-712-ree.

> On that note, I see there's no clocks or resets properties added by
> your patch. While the IP may not have a reset (although I suspect it
> probably does) there's no way it functions without a clock.

Correct on both. v3 adds them:

- clocks: the hub has a main functional input clock (plus, on
  side-channel-core configurations, a half-rate variant, and a
  real-time-tick clock). The block gates its clocks internally, so the
  host doesn't gate them -- the property just describes the input
  pin(s). Where a secure power controller owns the clock and Linux has
  no handle, it's absent, as drivers/crypto/xilinx/zynqmp-* do.

- reset: the hub has two external, active-low reset inputs -- a power-on
  reset and a hard reset. On an integration these are top-level wires
  driven by a reset controller in the management domain, not by Linux.
  Where the Linux host is the management host and one of those lines is
  exposed to it as a GPIO, v3 describes it via reset-gpios; otherwise
  it's absent and Linux doesn't reset the block.

> > > This looks like it should be deducible from a device-specific
> > > compatible. [slots/strides]
> >
> > These aren't fixed per silicon -- they're the per-mailbox layout of
> > the VCQ rings in host DMA memory, chosen at platform integration and
> > programmed by the driver into the mailbox QUEUE/SLOTS/STRIDE
> > registers. They can differ per mailbox on the same silicon, so a
> > compatible can't encode them. v3 will keep them as optional,
> > defaulted properties on the per-mailbox subnodes.
>
> I'm not sure. Unless there's more than one instance, this definitely
> sounds like something that you can determine from the compatible.
> Generally these kinds of accelerators tend not to have multiple
> instances though, so each platform will have a different compatible,
> and the driver can store an array of mailbox configurations.

This is the one I'd like to keep in DT. The slot count and stride are
the host-DMA ring geometry the driver programs into QUEUE_SLOTS /
QUEUE_STRIDE at probe. They're fixed neither by the silicon nor by the
integration: the same SoC (same compatible) ships to multiple customers
who provision different amounts of host memory for the rings, and a
customer may tune it further per board -- so two boards can share a
compatible yet need different geometry. They're optional with defaults
(6 / 9), so the common case sets nothing.

The reason I reached for DT is that the alternatives are each worse for
a per-board value that has to be known at probe: per-compatible
match_data means a new compatible and a driver patch for every board
that tunes it (two boards on the same SoC can't differ), and a module
parameter is exactly the sort of global knob I'd expect you'd rather not
add. DT lets the integrator set it without touching the driver. If you'd
still prefer one of those, tell me which and I'll switch.

> > > this could probably be handled via reg-names? [affinity]
> >
> > Yes -- v3 will express affinity per mailbox (a "role" of a specific
> > core type for a dedicated mailbox, or "generic" for the round-robin
> > pool), which is the subnode analog of your reg-names idea. One
> > caveat: this cleanly covers 1:1 core-to-mailbox dedication plus a
> > shared pool; a mailbox dedicated to several specific cores would need
> > multiple role tokens.

Following up on my own reply: I kept an explicit core-ID affinity list
on each mailbox node rather than roles/reg-names. As the caveat above
hinted, roles get awkward once a mailbox serves several cores, and they
can't distinguish separate instances of the same core type -- the core
ID handles both, and the driver would map a role back to an ID anyway.

Thanks for the review,
Alex


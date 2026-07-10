Return-Path: <linux-api+bounces-6830-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +hSqONB8UWr5FQMAu9opvQ
	(envelope-from <linux-api+bounces-6830-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Sat, 11 Jul 2026 01:14:24 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D4D273FB9B
	for <lists+linux-api@lfdr.de>; Sat, 11 Jul 2026 01:14:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=rambus.com header.s=selector1 header.b="1B/q9c7Q";
	dmarc=pass (policy=reject) header.from=rambus.com;
	spf=pass (mail.lfdr.de: domain of "linux-api+bounces-6830-lists+linux-api=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-api+bounces-6830-lists+linux-api=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CCF7D301464F
	for <lists+linux-api@lfdr.de>; Fri, 10 Jul 2026 23:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5687E40961B;
	Fri, 10 Jul 2026 23:14:20 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11022127.outbound.protection.outlook.com [40.93.195.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AEA9340A46;
	Fri, 10 Jul 2026 23:14:18 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783725260; cv=fail; b=jZepRbUBxmQ0TZi4d/PWH0ul2zIBEgMJCcuxgY8LPqMcZBNf28h4KV0vLJEF8KezVMSa74rOiI5gw25KvlnqIbsZ8g9vboexO29US7nC9gxRVjZUSc3Lq4Aw1aVc9nV+PneOl6BFKbDSOZ0aPTuE64LMGI463Q4H0E41qhc96oE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783725260; c=relaxed/simple;
	bh=JI1nOgpMbHbZz9QBC7nmNhlcJEMqsGjSWesFDJnuluM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UtMI4cg+394DQKhj4J13Ij87jtfHffXh6fTDYxWyV1W7gJPq8awzWr5v5ofoohut9WEkna/zPFaXjh3G6OAQJ04v8eIVhIU42Zeavkqxp5qVbVbTHSCj1DXEsqOPxJduukBV7+yiX7eyxmxewIceJUt+aUOpwRjB9OYXo7nHeL8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rambus.com; spf=fail smtp.mailfrom=rambus.com; dkim=pass (2048-bit key) header.d=rambus.com header.i=@rambus.com header.b=1B/q9c7Q; arc=fail smtp.client-ip=40.93.195.127
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fMB7nhjXOkqAu+fWCaQf6UKRAOu+eWxSJySUSfffkCdWpcjXElbgAyLhREL6syuQ4TVYC8tr/xrFdCgsnbRC0z9GbSb2Ep7/G7AX2jhVkI5Rp9ndAKYFFI208usgN566X1SU08Zp9dACxK5hzj/ltq1AG7p6BYQjAKCZ6VDVSWR3KGsaO+hOKMosV8fmw00fLax/gfSjbUjlw7STFH2qrZcvddbOKT70RzzzH7yWIIK7bqnOG3rWYsUfTUg/okCp2x4bZzX+lHSWfaW82cNniYH02MtlqmMCNUXQy5jjeDWvVPUCEGwUV/4OF9HS+a1ZCxqeI7w4rPhz3tKFfb7R6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JI1nOgpMbHbZz9QBC7nmNhlcJEMqsGjSWesFDJnuluM=;
 b=Hy3xmbh25gIvdFWtSXEYEF0FlfNkQ8403KWtunhuZyhkyhVxW8uWOqqYJ6VCa1gvjhC1PalSNfL8NeKI/0lTgwHzMGYM9UeB/CAJAFCcxTWEda3hL4KYe8L7/8yKFi1W2HoPP8rOqtlkj1PfWxjFdXR8OBt3MgIvtYNqMnJDMwNlj8B9DNpQOhn+agcSyms7fZD7/FVjLGdKCzHg5f+/qb1YywFESYgF71zcVpF1JsPRMKa6BnbpT1mdVxMPjLN1RdnaXuakZIEbTY4jcVEk15Xh28BVoxKC+prQsam/4mVRSULQ2Wr/odovQnX9D2S80ASwfdG8OnNiEImEXWvj1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=rambus.com; dmarc=pass action=none header.from=rambus.com;
 dkim=pass header.d=rambus.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rambus.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JI1nOgpMbHbZz9QBC7nmNhlcJEMqsGjSWesFDJnuluM=;
 b=1B/q9c7Q4c9YqYDyr3O40QaFPu3AWlyeBKWGuZKp8pFYiEekr0Zm+1aZSPZ+OlNQkaknb66qQSV9J14qNK+Y0+n/+pfLjPCD7iRwFMYXzjcsZlaHYJbEJFnJF3HTSuXP703kvH0CLfEDb+8rosz92XR/ILWfMbTb5L5f/G5mTzzyCKFCcNPOuOYFA21Uc+E0nCXxOjVCNuTMKqyGMdHrL6yI8VONx1DK3OhRlRtT7w85ejRtiruk6r8wO3uV8vlnzhxBBsKiU0c/lkWEnrf1SYxQXTr7dM4Nu6neTFR68BXg07Ggz0+kIGhmLYHH6swuEAOi/HbpjE6VQhwo625MaA==
Received: from SA3PR04MB9001.namprd04.prod.outlook.com (2603:10b6:806:398::17)
 by PH0PR04MB8279.namprd04.prod.outlook.com (2603:10b6:510:105::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.18; Fri, 10 Jul
 2026 23:14:12 +0000
Received: from SA3PR04MB9001.namprd04.prod.outlook.com
 ([fe80::3da3:45d7:8860:e196]) by SA3PR04MB9001.namprd04.prod.outlook.com
 ([fe80::3da3:45d7:8860:e196%6]) with mapi id 15.21.0181.017; Fri, 10 Jul 2026
 23:14:12 +0000
From: "Ousherovitch, Alex" <aousherovitch@rambus.com>
To: Conor Dooley <conor.dooley@microchip.com>, "Krishnamoorthy,
 Saravanakrishnan" <skrishnamoorthy@rambus.com>
CC: Albert Ou <aou@eecs.berkeley.edu>, Conor Dooley <conor+dt@kernel.org>,
	"David S. Miller" <davem@davemloft.net>, Herbert Xu
	<herbert@gondor.apana.org.au>, Jonathan Corbet <corbet@lwn.net>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Paul
 Walmsley <pjw@kernel.org>, Rob Herring <robh@kernel.org>, Shuah Khan
	<shuah@kernel.org>, Alexandre Ghiti <alex@ghiti.fr>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "Wittenauer, Joel"
	<Joel.Wittenauer@cryptography.com>, "linux-api@vger.kernel.org"
	<linux-api@vger.kernel.org>, "linux-crypto@vger.kernel.org"
	<linux-crypto@vger.kernel.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "linux-riscv@lists.infradead.org"
	<linux-riscv@lists.infradead.org>, Shuah Khan <skhan@linuxfoundation.org>,
	"Nguyen, Thi" <thin@rambus.com>
Subject: RE: [PATCH v2 01/19] dt-bindings: crypto: add Rambus CryptoManager
 Hub
Thread-Topic: [PATCH v2 01/19] dt-bindings: crypto: add Rambus CryptoManager
 Hub
Thread-Index: AQHdD+HshuImNmj2q0GDF9X/lpOPwbZmdM8AgADs7vA=
Date: Fri, 10 Jul 2026 23:14:11 +0000
Message-ID:
 <SA3PR04MB9001E7DC9B2D4788EDCE2390D7FD2@SA3PR04MB9001.namprd04.prod.outlook.com>
References: <20260709203037.1884436-1-skrishnamoorthy@rambus.com>
 <20260709203037.1884436-2-skrishnamoorthy@rambus.com>
 <20260710-siding-unmatched-5e066fbe4c01@wendy>
In-Reply-To: <20260710-siding-unmatched-5e066fbe4c01@wendy>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
dlp-product: dlpe-windows
dlp-version: 11.11.2.117
dlp-reaction: no-action
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA3PR04MB9001:EE_|PH0PR04MB8279:EE_
x-ms-office365-filtering-correlation-id: 3d81d6f3-1286-4f69-8186-08deded8f3f9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|7416014|376014|366016|1800799024|38070700021|56012099006|4143699003|11063799006|22082099003|18002099003;
x-microsoft-antispam-message-info:
 cKElAf2hElcTrc30MNdglEnoajQqDxXtzsqfpiiB6zBA3K2g0M6hNpR4UFd/cKLDwCYEBeVRYNZPCiGhuZgVB+BzitikIwNaZQdgT+5opstrLBwFIb4MkyNY3WWGo9KPEWzoc2PG9fWEShtznbFoauBUJO3gFh+czFcv81zjo8bE3690uLJ8TB3bMFNh7wI5rakJc1sMviOE+XTIAQgCUDmH8BzzqHeCKM8oFVMOKM0vHHlyO/DeA8UNFY97J22ufIVdCQVB5p6Rda0kXkhzTiL7Z/INLUCiCFtEg1h+4CPhbdBSxb5W1yMRN4XJEeAIrO0TwEjrXSsgmXQD+/twsMiGoslUjSkyhhCaMkjSxwTseJ3YM+B5JwBhQ7AGk9cl+2Ic1DYu3iTtsY3s2vrhVvsd0vcaUQYqhmvvZ2kSmozkolFyrKw3ky/zYP6fXIgdvkfFHkmZIYAiytRl4HA8VKDqxDi8NIxaeT5WWgYLe4nDk4EUhVk5SoWgzfqNNNH6ASduclEgL0YkiMeCOwQgDNWimk6DQhqc2pw8dnMB1XZzpXSq1nunWyhs5Vk+6gFa2THfgBc3jDH3Fqz6eu42zkA6+Xze+vprTYJr+5VMAmWiK97p+j+UiXha5mjlGstv2w/3U/rlNOpR/mxvzWF5jDoqXgO4w9kHb0oPqcwmoAdrbaMdw9Mwib5oJRx99fGkleGBtK1At8L5Yl6SBVuaICwwYoiMIkXb5Ro7I8g86AA=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR04MB9001.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(366016)(1800799024)(38070700021)(56012099006)(4143699003)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?zg89MWmfEpDkNexMjoRsJdbDAbiDg59nAjSJZL/4vLiKPs/K5GovK0idWtno?=
 =?us-ascii?Q?4nSMfxUCwvA1TVD7iKV+Avi/5LijHxI8f5ttY2xIQajFseQYJY/lweqgpBf1?=
 =?us-ascii?Q?5XD/NDJ+9CsUJgQAOvGsXKIvSc/TYtWFO856mem+VGktwddsjD9mw/Wq75Tp?=
 =?us-ascii?Q?1MwpBJQgW6tHwiVqNULyZVRwTgdjjg3A4EN67hVcQvVTIiVM5+kOo6QsM0Oy?=
 =?us-ascii?Q?LADcM4oP7U9V1MPcUeweSXRFqHdoyv1KS2OL0MTtCcBnGytEVwlF2ePw07Gs?=
 =?us-ascii?Q?IRG5Dz4D3Ao70AyRfFkiiefqWXbpoh931arzNADL4tc/6n/RrMfJHx6bpZHV?=
 =?us-ascii?Q?aNOiu+to3V22jd9c37VYoyGlfFFGmzzoNTLO2R+cku58bv5TanBClbFh2Mq6?=
 =?us-ascii?Q?DsN4/w5QtANSKeYad/KQTD31O331EvhqxWNsILV4y17WpOFV7zntMutvNKkx?=
 =?us-ascii?Q?waTrbMrIo4eSBcW24qUlca+NDP6GQ8EDFPigfaKceVbjwX+kNPzV0D9q50UH?=
 =?us-ascii?Q?bAxQ2zoPBQkDOJ/g4ahbBqKxLAhy4KBRFx69SfD/g5WvyrYQ7i1LxBJHPzRY?=
 =?us-ascii?Q?9PRGCU+L9jrEuOfN2k4UFA+UtWbMamLVLDkn+ED0ouwD2r5+6uVz1BQuD3Xy?=
 =?us-ascii?Q?W35/kd5Ih8G1r3BqwcoEFBBBKMGJQExiULeT8bVsf6tZmLcvJR4c/uISaAIy?=
 =?us-ascii?Q?MU3mh9nRJuyTtDhB1us2YYryGPGG9B3Doi8xnSbJygh7KX16ER+Z1pFf/P7V?=
 =?us-ascii?Q?7ffFvafdDDwp8XFPeW1QJDkxHwpIXhKB527JG/AA30R84M8cMy+VC53KSuZU?=
 =?us-ascii?Q?ZNkyh1syLyMCCUAuC/Bm9CpUX3qoQTo9T/Wz5Kpm4foPlBE+VRXpnkIfD2nA?=
 =?us-ascii?Q?xMOUthOVfBoVhJ7YZchoU/AiQGrOvOch1wAgV9Q0jFKJAh0i5cC2IoBUkDwQ?=
 =?us-ascii?Q?PQ0B2j7xkbOuzCfpGjAfRvPMsTl2Qu/5Cv8SUhR/ZJhnF/52cTRB5ndhVUIY?=
 =?us-ascii?Q?fIkfSh62DisxoVjPH0V+c6jg9f82NhaP1bhxHmITWkRfOWiGdrmQxBbFnadW?=
 =?us-ascii?Q?WZSR8+wRvAl/4MLQAm6o5h38qX9WicA1NNaxIcvM7pPFV8mEZQoSrqGqSWEV?=
 =?us-ascii?Q?WMmxOLsj+n6ZI/hwwRqk97JxF92EOAqKrfBT0qO+oJf6ghFZoIzeYC6epEMs?=
 =?us-ascii?Q?3POYDEz26IsG5xQl3NKB1xc9hVaH8wQMroPocRYBh/DGcOTzKSh6/Mo1wBZH?=
 =?us-ascii?Q?QLoF1oxIZ9KI/kXWrvsCBAkgraGjbEf3/D0xsNeHEvc3YC1x28Gs4a3AcEvK?=
 =?us-ascii?Q?2ekWP7f/jWuV5F+EvTdPAxKzgKnn3qeS8LyE2hXgrerNpWOYERUmbb6KpXBH?=
 =?us-ascii?Q?2OGDgY3Ny7ZkPh6acz+f/QHslJkRQQDl5dpJWXcDqdIvAwR4/nW2KSL88DIM?=
 =?us-ascii?Q?B7ueiDdmQobBIdVxSTEE8Y8k6nuHTu8Qk5ZC6Tpn5Ho6eABCFy/gtCadTgJX?=
 =?us-ascii?Q?KATdgwpQg7UWpBealJvsRsEa6HU3M+2UrvS4fLDMapz4oAAa/yKNTaxw7gDR?=
 =?us-ascii?Q?AnPPkmyVkvvTygo7j0hO6wwa5bt9fDmFg07VUCRZK0IFJbMZQWp1oIVaAhBG?=
 =?us-ascii?Q?4FFRdw2Jv6CNDoxrFX69XUoRpyZ42fNYBOIJMHG4uXMzhCSaDT/OuBBFjnN6?=
 =?us-ascii?Q?QWRE8s03zHrbJhZM/ri/GIcgm+FUsl60ktfgCF2bmjPTDWguiMs0eWolWKo2?=
 =?us-ascii?Q?GoA6ZCjkWg=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d81d6f3-1286-4f69-8186-08deded8f3f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2026 23:14:12.0688
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bd0ba799-c2b9-413c-9c56-5d1731c4827c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PUbuGh22NwrSEbGxQqb2+hwmWkaheiiISUQ8ylUhdelsOjElDbM0FbVMigZjFzINUBnkeJj7OqrWYznYHFlV+FYSj8fERMV8aNA1c+J/394=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB8279
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[rambus.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[rambus.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6830-lists,linux-api=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:conor.dooley@microchip.com,m:skrishnamoorthy@rambus.com,m:aou@eecs.berkeley.edu,m:conor+dt@kernel.org,m:davem@davemloft.net,m:herbert@gondor.apana.org.au,m:corbet@lwn.net,m:krzk+dt@kernel.org,m:palmer@dabbelt.com,m:pjw@kernel.org,m:robh@kernel.org,m:shuah@kernel.org,m:alex@ghiti.fr,m:devicetree@vger.kernel.org,m:Joel.Wittenauer@cryptography.com,m:linux-api@vger.kernel.org,m:linux-crypto@vger.kernel.org,m:linux-doc@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:linux-riscv@lists.infradead.org,m:skhan@linuxfoundation.org,m:thin@rambus.com,m:conor@kernel.org,m:krzk@kernel.org,s:lists@lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-api,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[microchip.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,rambus.com:from_mime,rambus.com:dkim,vger.kernel.org:from_smtp,SA3PR04MB9001.namprd04.prod.outlook.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3D4D273FB9B

On Fri, Jul 10, 2026 at 1:59 AM, Conor Dooley <conor.dooley@microchip.com> =
wrote:

> This company no longer exists, you should probably introduce a rambus
> vendor prefix instead.

Cryptography Research, Inc. does still exist -- it's now a wholly-owned
subsidiary of Rambus (our co-maintainer is @cryptography.com). The
prefix names the IP originator, which is consistent with existing
subsidiary/acquired-vendor prefixes in the tree (e.g. al =3D Annapurna
Labs under Amazon, mstar noted as acquired by MediaTek, fsl, cavium,
xlnx). We'd prefer to keep "cri" on that basis, and can annotate the
description as "Cryptography Research, Inc. (a Rambus company)" to make
the ownership explicit. Happy to switch if you feel strongly.

> This property seems like it could be replaced by having a reg entry
> for each mailbox.

Agreed -- v3 will make each mailbox a subnode with its own reg window
and drop cri,mbx-instances.

> This looks like it should be deducible from a device-specific
> compatible. [slots/strides]

These aren't fixed per silicon -- they're the per-mailbox layout of the
VCQ rings in host DMA memory, chosen at platform integration and
programmed by the driver into the mailbox QUEUE/SLOTS/STRIDE registers.
They can differ per mailbox on the same silicon, so a compatible can't
encode them. v3 will keep them as optional, defaulted properties on the
per-mailbox subnodes.

> This whole subnode thing seems like it is only required because you
> don't have device-specific compatibles [cores].

Core presence is actually discoverable at runtime from the CORE_ENABLE
register, so v3 will drop the per-core child nodes entirely and probe
for enabled cores -- no per-variant compatible needed.

> this could probably be handled via reg-names? [affinity]

Yes -- v3 will express affinity per mailbox (a "role" of a specific core
type for a dedicated mailbox, or "generic" for the round-robin pool),
which is the subnode analog of your reg-names idea. One caveat: this
cleanly covers 1:1 core-to-mailbox dedication plus a shared pool; a
mailbox dedicated to several specific cores would need multiple role
tokens.

Thanks -- this restructures nicely.


Return-Path: <linux-api+bounces-6642-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id FxURI4opOmpj3AcAu9opvQ
	(envelope-from <linux-api+bounces-6642-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Tue, 23 Jun 2026 08:36:58 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E5E16B4940
	for <lists+linux-api@lfdr.de>; Tue, 23 Jun 2026 08:36:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=docforce.onmicrosoft.com header.s=selector2-docforce-onmicrosoft-com header.b=GpK7Asux;
	spf=pass (mail.lfdr.de: domain of "linux-api+bounces-6642-lists+linux-api=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-api+bounces-6642-lists+linux-api=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C4F8F3023310
	for <lists+linux-api@lfdr.de>; Tue, 23 Jun 2026 06:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D0C03C3C19;
	Tue, 23 Jun 2026 06:30:20 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11021078.outbound.protection.outlook.com [52.101.65.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A93C73C4164;
	Tue, 23 Jun 2026 06:30:18 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782196220; cv=fail; b=L3B+X2Ga3jdp6HuSnTHpCuqy8Zysan0v0GoMgiUEHfpSrGeK5Am6b9kA/7lfNf0Fo0RFMQwTHxWchN3y5ElsyltZTpMn7Clqz6AifJ9KcXjz4mN7NzG1WvKO8T/h+HKIvFQY7eMe/pCCxMFpINByQZaRN6l8YqrSh10rRHQmsjc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782196220; c=relaxed/simple;
	bh=ELC3ZzvnQeufB+ZvpE+37kUNNJBJxEfEzvZWPG3HJ64=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Nv8/DpX/Yz55jI3+BjR5LcoLOBBUpp9fzxtHF9Bt/PfkeLkY+fPqcubkaIpW4kRrErpQQnGPzUPrXyMmrpQPLkwq2d0/CCSZ/97ppyMWj7CD5fOO8V5r2IOb1sPcC4tTejOkRni9zvoFGXhBWIYm8t1aSoxjoehDyplswA1sTS0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=docforce.de; spf=pass smtp.mailfrom=docforce.de; dkim=pass (1024-bit key) header.d=docforce.onmicrosoft.com header.i=@docforce.onmicrosoft.com header.b=GpK7Asux; arc=fail smtp.client-ip=52.101.65.78
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CjdN7u2FPAndQa7ZphnXji5lGV+bF2+dM1cUuJWpgEmYWpdwrVIjC4FCX3jOi8+oXFR2n8+2uSAOmrv3jLP90xEdrv6mZ657rC3UbXOJzvJXB/eJt1yjRKcH5gr5qlMqrwz3elM4u4LiIPqSDngSvxUW9038e7WYEDCFuID4m0dKR3r2Ty7kkzuPQ/ruPuWdt9mJZOLQrO21iES2l/O1+ZlXoIIZWQE9pjEMnDQei2PIi9e7wZga+QqRvPi1SrhO+AyGWB1O5ANXexG2Fcy9ORcRJ/e7IO+dy9YcRYqmBFRj0ilKdwBh3wtZBEv8aPu/rRVvOVZz9PvCUublNZXneQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ELC3ZzvnQeufB+ZvpE+37kUNNJBJxEfEzvZWPG3HJ64=;
 b=VtwBb7gJDkPoZVzZomMRC0fpgKe0hAqZlIxFdl+AeK3aBW3hgkGfZgHDaOBtfvZesRintBlqs4XOda9AHLHIf8Wc+nv/qq677WhJJj0wreTKBBuXKzmjPLVqeCJmjcuRP/COg+LlOnE0knUc714N+MeqcyCkt1v8oL5QAizSss1KnE58e3Z75IlmmRGgwvkqSB/YVwRA75YEio38yVidwy/Lr1QrmVNlYkLqxyDl/XMwK31lM36fCdvovApHxJJgFylIdkajCn6j+2C0sA9sdZSGAY2T5wTvXq2fEzZIOG58ZgNZGYmW5xyvJz3uGbWWME36F2PYwMfzqfwQ0+wVHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=docforce.de; dmarc=pass action=none header.from=docforce.de;
 dkim=pass header.d=docforce.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=docforce.onmicrosoft.com; s=selector2-docforce-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ELC3ZzvnQeufB+ZvpE+37kUNNJBJxEfEzvZWPG3HJ64=;
 b=GpK7AsuxQJwVeuVE9Byuu4cZync3em6xFyjyNGIVCok7cVYJm8T3f7CS75zj9aaEd/GRTrq8f3Z2gRG26pdAcJsmSPw5Oq9hydoPnnKW0T93PnbNfU5J6eZ4qibgxrINd/9FXtPo6NRcwbU1obi6n8yMoKg0R5mie66rLTNRuKQ=
Received: from AM6PR05MB4903.eurprd05.prod.outlook.com (2603:10a6:20b:12::11)
 by GVXPR05MB12014.eurprd05.prod.outlook.com (2603:10a6:150:322::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.18; Tue, 23 Jun
 2026 06:30:16 +0000
Received: from AM6PR05MB4903.eurprd05.prod.outlook.com
 ([fe80::6b8f:8919:9555:ce34]) by AM6PR05MB4903.eurprd05.prod.outlook.com
 ([fe80::6b8f:8919:9555:ce34%6]) with mapi id 15.21.0139.018; Tue, 23 Jun 2026
 06:30:15 +0000
From: Tim Parth <tim.parth@docforce.de>
To: "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Subject: [RFC] signal: per-thread control over alternate signal stack delivery
 for selected signals
Thread-Topic: [RFC] signal: per-thread control over alternate signal stack
 delivery for selected signals
Thread-Index: Ad0C2a5mCii6+plqRmWqi0ohehBXMg==
Date: Tue, 23 Jun 2026 06:30:15 +0000
Message-ID:
 <AM6PR05MB49032404F2001561036ADA1BE1EE2@AM6PR05MB4903.eurprd05.prod.outlook.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR05MB4903:EE_|GVXPR05MB12014:EE_
x-ms-office365-filtering-correlation-id: 908a1b2c-f0a6-4f14-fe74-08ded0f0e36a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|10070799003|366016|376014|1800799024|6133799003|18002099003|56012099006|5023799004|38070700021;
x-microsoft-antispam-message-info:
 azKI+U6AkIFxter+7FYBLrkiraQpT0N8C5Su0jNR+D7+7dFZqxB7kn43cPHclmFNHXeOA1KzULg0V0xvSoOBwMvxrlEF+pylPWtmXzlnQzyx9dJtAUxKKsG7Y6OOrddyIC78Dp8Ri5qMuwzw387/eQuRzSqEHz335NTM9XOqJ1fyR5MbdVyvhHJFIj8muNTH3Rl+Rym359rpFfMzOWXNuVk1UvfIGEeN9FW0MRtFl1Jl21putsfaj2T9ntcV6gw01Z0n0vRNPnn7Fqfh1kvpDYjFwom+pYUZ9yPqrfJSR2NgpJ4LmKje3IvjMN2ZecPS1s1WxtPen3/C9NWRPHvXoYzXOj72DlO5TBzQNLw3I3wNmE0Qr2+svxi+WMwO0TTrFqpcmZWh8yB6fNm3axFVLgpI1VUq2nBM5nAE1JYg/VkBZloFeSjMGrl6cizCaa68jsRWHVTQgPnO/VPywVzia16Crpzf1XgPNfw8AQA5Jy5xcTJl83aLP9FPBtHmpkqr8O0aaazL2YsC/2Ox9Ktgy49SpmMjUjNkoIjHBqTwGOL9OXfo/EoMDWa0JIA7lDh5a3AIa9ogEgkMaL1Ua4CFtrRbz/nUYIDeMrGSZ3Pm61yAS5SmGQ77grOryi32FZguN4SbXb6bdAs160BZsrzmUc5ui0B43AF9jHYOffWjI8aP6gfzOrcRGxVZj42CViAEXdVRn6Vcrww8G7T0bx+JZJ3Qxh8Bh3r//ujivsjb/P8=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR05MB4903.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(10070799003)(366016)(376014)(1800799024)(6133799003)(18002099003)(56012099006)(5023799004)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?k+lhFM+cgn3fIPJXNUrE9ir4Vy5g0LhqOj0syVNk3YugowmJn/3f4Y0U88DB?=
 =?us-ascii?Q?+GgG73uOMzm82tA1WbGW/oiIaZ4tob9L4poKkash1MCpX83C6C7+RFDU2Hk0?=
 =?us-ascii?Q?oilfJ9Q5qliSm98KzQinnJRIJGSzS68/BDGNZjpzUv8Y4ikTHYD3OKa6gkcV?=
 =?us-ascii?Q?SBA3PVxVtuguRzwevfuZWDwuOQGtuI4ALdc1I/EjB+bf+dbCh+XP7nhvYx5+?=
 =?us-ascii?Q?eIgGjp0XLRJZunm3rXtJQYNHtkN7eZox3rxd/GKp4f40mm/wawlOmcXhQtSl?=
 =?us-ascii?Q?pdtwGkCKJtzB4wq/h3FcO+dj+HmaCY+CvMp45D7YB5TsVzaMuZ9rcRxZOztX?=
 =?us-ascii?Q?q1+Gk+yfFgdTgRjGuUu8pJNQRZ5W53KGuF2hoKwO6RVb6+DBURmV5T3POIIq?=
 =?us-ascii?Q?mlG7nMSShEIiXycQEb7fdoTBusuGYgFRuXtugmSWVk4V2Nkrw4EJ360HQBMS?=
 =?us-ascii?Q?NXKGphqerWRScSQyM3CciGcrZHuDubZFhYsqFsFnwvzRX38oYgjJ9lMv80+3?=
 =?us-ascii?Q?7+5Dof/Tqo1BXxoP+LX0XFmXeS8aA1Ovxjq1u3zNwNqDurGfaJseLDheLZAp?=
 =?us-ascii?Q?8a42ZjG7O4OpQ89Me/ldqMuNwxRinwMxGOnqI99qvkY0vHDc55TYkDglR2ZN?=
 =?us-ascii?Q?1ItR1ZlxJn4qzLdrfELsR/YOmviq+K8QpTarqvaEW94vN0/5EGWUvd21SDu2?=
 =?us-ascii?Q?6KrH2rFGHYCZcEhRDn8XEaoXPbB13I8C3E3LC1gcrNKntgujlj3AFSAi0mA4?=
 =?us-ascii?Q?8P5I82sWJdr8ks3JbIsQ/YyoWrt/ncfcjXUB9bOWQ5Rw0iIz0dxiDx73yV/O?=
 =?us-ascii?Q?wZ6pE1VuL2Cl8VO90+ge0ThRUj/aQ52s5QN6ojCfh4Y8LgazxRtDNMObTVgv?=
 =?us-ascii?Q?nvaO3mY7IrWdPiAW8WlX49wpw8UPTLSyWvTD8a28psHrsY2Obcb7eBneT9Oy?=
 =?us-ascii?Q?hSF73iq7PcfFGPRnB+gqhqiMH1GaF7yLkkv2JFnc28V8n1W4UrArtHOJKr8N?=
 =?us-ascii?Q?BQNEJtFb0AzXGnGq7AI2IAC54S4y6uHCYCjCn2KZzSN8pZluzKVpGldaakRh?=
 =?us-ascii?Q?Czp1IE4/qLGaugrMSToHgHSo6/iRgwSVtX/vL2Zjh8O76x19e7a01AoqekMp?=
 =?us-ascii?Q?I3ZcWuuSqQHfXtRyHTikXt/pX9KNjHwXeiNs2lgdn4gdrgv06octVk0o1ItG?=
 =?us-ascii?Q?igJAjUPu3O8Q115JX/mWNYqUwIiWC00UWaMlMAz9P4PLG2/JVa5SrWEXlV0x?=
 =?us-ascii?Q?856HwpfGlJ6mTzfXdb+yo7IRWNuHgLc1PvL15nG0Uv/kCJ951ua0VkWXuLn6?=
 =?us-ascii?Q?XtkKG+irJ9KYEeTSH3REEE/Wd2tQPwhMFUCepiOKl7YO4+8PAu3qdfag13jv?=
 =?us-ascii?Q?GpM/mfaXyRciSRMSRtapwcvhEEMErye6Z8ncJucK3EmhElqu2CNpUxTMA/+8?=
 =?us-ascii?Q?7fgsElIPZqsNHK7M/S9D7tu587oeTszCtNp4Ll/V37577iCpAAPxRps6NJ6R?=
 =?us-ascii?Q?I+lP0eMbLfdNYy3hg2zoQA6M+yqIlhZTA4LRu2WN/r+ZWt3sKiYq0pDSMgZk?=
 =?us-ascii?Q?u1SNpAZSaJ1Nafj/9rXHeYWGpNeAZx4eRo4SnpTbdqrkeq7BlHBPSrirkPev?=
 =?us-ascii?Q?phyUMta9QnA2bQlIowhSVLRHhCvPF/nlBsMfoZgiGJDdAMDOKpFrXS78AFIe?=
 =?us-ascii?Q?2cdPrQS/rcu6J5glKYJu7/eNn0SykYwh1IVt8CMWfrYCfJ/bApA5DuQQ51zf?=
 =?us-ascii?Q?9lqKRoG4YL2riGkdQ+CSZU0HLa5B0m3Dxs4jABrIhydvG14K96IQ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: docforce.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR05MB4903.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 908a1b2c-f0a6-4f14-fe74-08ded0f0e36a
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2026 06:30:15.8727
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b5f6141d-a00a-4f0a-86d2-fddfde43e6e2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EplNt3hLgdhvk+OnkJKe0XaU98ELClJVBsvG3+uJ4NxZ9dx1v0z5yzgU9vLxUHm6hx/zwk74y+zU/LrDU9tYFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR05MB12014
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_ALLOW(-0.20)[docforce.onmicrosoft.com:s=selector2-docforce-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6642-lists,linux-api=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[docforce.de];
	FORGED_RECIPIENTS(0.00)[m:linux-api@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-arch@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_EQ_ADDR_ALL(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[tim.parth@docforce.de,linux-api@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tim.parth@docforce.de,linux-api@vger.kernel.org];
	DKIM_TRACE(0.00)[docforce.onmicrosoft.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-api];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,docforce.de:from_mime,AM6PR05MB4903.eurprd05.prod.outlook.com:mid,docforce.onmicrosoft.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7E5E16B4940

Hi,

I am looking for guidance on a Linux signal ABI limitation that shows up in=
 multi-runtime processes, specifically a .NET host loading a Go c-shared li=
brary.

Disclaimer: I am reporting this from the application/runtime integration si=
de, not as a kernel developer. I arrived here after tracing crashes in a .N=
ET application hosting a Go shared library through several runtime-specific=
 issues, reproductions, and analyses. My understanding of the Linux signal =
subsystem and ABI details is therefore limited, and I may be missing import=
ant details.

The technical summary below reflects my best understanding of the issue bas=
ed on the referenced investigations. I used AI-assisted editing to help str=
ucture and clarify this report, but the observations, reproducer, and refer=
enced analyses come from the linked investigations.

This is not a claim that the current kernel behavior violates the existing =
ABI. Rather, I believe the current ABI lacks a way for multiple language ru=
ntimes in the same process to compose their signal and sigaltstack requirem=
ents safely.

Observed failure
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

A .NET process loads a Go shared library built with -buildmode=3Dc-shared a=
nd calls it via P/Invoke. Under stress, the process crashes with SIGSEGV wh=
ile CoreCLR is handling SIGRTMIN for runtime activation / GC suspension.

The reproducer is here:

https://github.com/egonelbre/csharp-go-interop-issue/tree/main/dotnet-go-re=
producer

Related runtime issues:

https://github.com/golang/go/issues/78883
https://github.com/dotnet/runtime/issues/127320

The .NET-side analysis shows that the crash happens inside CoreCLR's inject=
_activation_handler path. The kernel delivered SIGRTMIN on the thread's alt=
ernate signal stack, and CoreCLR then ran a call chain deep enough to overf=
low that stack. In the reported case the per-thread alternate stack install=
ed by CoreCLR was 16 KiB. Increasing it to around 49 KiB avoids the crash i=
n the provided stress test, but that is a runtime-specific mitigation and d=
oes not address the general ABI composition problem.

Current ABI interaction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

The problematic interaction is:

1. Signal disposition, including SA_ONSTACK, is per-process.
2. sigaltstack is per-thread.
3. On signal delivery, Linux uses the alternate signal stack if the handler=
 has SA_ONSTACK and the current thread has an alternate stack.
4. The Go runtime documents that non-Go signal handlers must use SA_ONSTACK=
, because Go may be running on limited stacks. For -buildmode=3Dc-shared, w=
hen Go sees an existing signal handler it may turn on SA_ONSTACK and otherw=
ise keep the existing handler.
5. CoreCLR has internal signals such as SIGRTMIN whose handlers may need a =
different stack policy or a larger stack budget than the alternate stack cu=
rrently registered on that thread.

The result is that one runtime can make a process-wide SA_ONSTACK decision =
that affects handlers and threads owned by another runtime. The other runti=
me can install a larger per-thread sigaltstack, but that becomes an arms ra=
ce and does not give a runtime any way to express which signals should use =
which stack policy on a particular thread.

Why existing mechanisms do not fully solve this
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

- Raising SIGSTKSZ or MINSIGSTKSZ does not solve the general issue. The ker=
nel can only know the signal frame requirements, not the maximum user-space=
 stack consumption of an arbitrary signal handler and everything it calls.

- The kernel cannot automatically extend an alternate signal stack.

- Clearing SA_ONSTACK with sigaction is process-wide and can violate the re=
quirements of another runtime, for example Go's requirement that signal han=
dlers run on an alternate stack when Go code may be interrupted.

- SS_AUTODISARM helps with a different class of problems, such as avoiding =
corruption when switching away from a signal handler, but it does not let a=
 thread express "use an alternate stack for SIGSEGV but not for this runtim=
e-internal suspension signal", nor does it provide separate stack policies =
for different signals.

Possible ABI direction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

One possible direction would be an opt-in, per-thread signal-altstack polic=
y, for example a prctl() or similar interface that lets a thread provide a =
signal mask for which SA_ONSTACK should be ignored on that thread:
PR_SET_SIGALTSTACK_EXCLUDE_MASK(sigset_t *mask, size_t sigsetsize)

The default mask would be empty, preserving current behavior. Signal delive=
ry would then become, conceptually:

if (handler_has_SA_ONSTACK &&
thread_has_altstack &&
!signal_is_in_current_thread_altstack_exclude_mask)
deliver_on_altstack;
else
deliver_on_normal_stack;

This is only a sketch. I am not attached to this exact interface. Another s=
hape might be preferable, such as a more general per-thread/per-signal alte=
rnate stack policy or a way to associate alternate stack requirements with =
particular signals.

Questions
=3D=3D=3D=3D=3D=3D=3D=3D=3D

1. Is the signal maintainers' view that multi-runtime processes should solv=
e this entirely in userspace by agreeing on one sufficiently large per-thre=
ad sigaltstack?

2. Would a per-thread/per-signal opt-in policy for alternate signal stack d=
elivery be considered acceptable as a Linux UAPI extension?

3. If such a UAPI is plausible, is prctl() the right place, or would mainta=
iners prefer a different interface?

4. Which subsystem/list should own this discussion? I am sending this first=
 to linux-api and LKML because this appears to be a userspace ABI issue aro=
und signal delivery.

Environment from the reproducer report
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

- Architecture: x86_64
- OS: Linux
- Example distro: Ubuntu 24.04
- Go: go1.26.2 linux/amd64
- .NET: 10.0.6 and runtime main were tested in the linked report
- Signal involved in the reproducer: SIGRTMIN
- Failure mode: SIGSEGV while running CoreCLR activation handling on the
alternate signal stack

Thanks,

Tim Parth


Return-Path: <linux-api+bounces-5886-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KEqiGMj3oWnzxwQAu9opvQ
	(envelope-from <linux-api+bounces-5886-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Fri, 27 Feb 2026 21:00:08 +0100
X-Original-To: lists+linux-api@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E69121BD288
	for <lists+linux-api@lfdr.de>; Fri, 27 Feb 2026 21:00:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 97975300B98D
	for <lists+linux-api@lfdr.de>; Fri, 27 Feb 2026 20:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5A113E9F95;
	Fri, 27 Feb 2026 20:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="RAAHFyAn"
X-Original-To: linux-api@vger.kernel.org
Received: from YQZPR01CU011.outbound.protection.outlook.com (mail-canadaeastazon11020086.outbound.protection.outlook.com [52.101.191.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 833173A1A2D;
	Fri, 27 Feb 2026 20:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.191.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772222402; cv=fail; b=CADnH8j+YGj3szXKx8Ksp+owl3L9gUWCwP96JaD/RWZYXrzRfB8wPf6C9yYundZU61LhzmmN/EsCeL9+njTbIB8gRLKzu+zfM6ukL/4UABP+uu0/nk8Jk9iiHpne+SKz5s1w+PDo06RReETCegHMB8hrT6eT1KQEmYyuZnaAN6U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772222402; c=relaxed/simple;
	bh=3rYWW8W4x/LYdLvQOB55l3dLsKMiTTyyZOf6swQOwhg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pjkULzeYnZDxs6vB3KlCnwmTXNVtB04uOzaR3KAX686ImCXjGQkVsz0KL2Dcc3RLTFgjeGG8IBIBBQtMQsEWxJJ41IfkyR2Pacjgafz8UsOeplCz9wxX/cXQBSj1O//xw9WUqOPRbiMr0IBU83N40lqqm1o73VIzQGkcV8PAWiY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=RAAHFyAn; arc=fail smtp.client-ip=52.101.191.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k85k7OiC1q+9VVUPw8JN/64YTGqvtq0q/3ieElBypku5ESX6aOAoImCC+n+yevy+JlZTLohdSI7LmQTI7SNVVVmXpcC9bdg5OQU5hA6zVK3OF6RgGAxJgjyd8f4JX/9xnsn7g4lokFsjJhkQcCOTvNRI3kzgKg/CGMfUtd22on/fmjh9KB317k82yW+juxuviYFhvxGOU8+S4PPjyD6Tp2tVdZN5f96o72NAtB/K/FxMx2Fnl13gGvOBSventpP7zn7z2VjVOSIC+8Pcez+ZqaLqtvWOhreJul+pcxGe7xLd4wutm+ocXtotbXfE3TqDtQ9yh5xpSJWlehG2AvqiDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9IntPXcPFmhqCD1e9cD3m/Eile5mNnWJG2QJmD9Ke74=;
 b=qPUZ4nk/qVRVHL1nL7a8JM2qbBUVm2nm4A12IOJy+MiKx22rTB9Ilz9JMYARWqX+PXH38xgZTX6BbRwEnFr7FXnUkZ1hPrWl7ED2bXLwnKW50899dPzNDbIorMA6cY8ZGdavqJ45mBH408QQ8mhlz89BSGNdjW70Ra/VXT2LKUXg2evny3r4YSIQasD6U7/Nlfn3vYPBsJKVXfDwyzGAfcJZWq2IfxHPiVQ+jaWbYKfq+WwLmlMI4PwwDf/SvV1fIvEWVojRDeciw5wetGoBjpdszC//gXeY5r8lssKBVJHVRb5mHVDCt/CAA7syS2H21Pm+QOLYsPx3D3R9+evlpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9IntPXcPFmhqCD1e9cD3m/Eile5mNnWJG2QJmD9Ke74=;
 b=RAAHFyAnJRwxLlyAUpK/eBxbeLgIe/5zYupI6UtZCPGA9JuWXmPNUjNIKJFhOq882++4VIG4i31AJcKNF3MCWO6GEBT18u6S9AvOohQdL41SWH9/MhZqAU9Ct5knyMb9YyCW2O9aL0omaQlfNsWA4dJ7xxHJmPE7QAbTFVBUFqNtH/mMJDYA5H9nrNdenEL5CQqtTrSLF9cpEbeB1tmT/uSfg8yeU5/LW1VS2c98+8I2+MZfuU1WO8u+DjG0Z6V1OuYtPgQMmKQhmxX12TDZP3duGs5dvKhSS5voF0REHKmkTabxc4XRyRvJUlTNJSUhjDjdr0W9S5UjKopIuxLIBg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YQXPR01MB5559.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:2f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.16; Fri, 27 Feb
 2026 19:59:57 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6004:a862:d45d:90c1]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6004:a862:d45d:90c1%3]) with mapi id 15.20.9654.015; Fri, 27 Feb 2026
 19:59:57 +0000
Message-ID: <bd7a8dd3-8dee-4886-abe6-bdda25fe4a0d@efficios.com>
Date: Fri, 27 Feb 2026 14:59:54 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/2] futex: how to solve the robust_list race
 condition?
To: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Cc: kernel-dev@igalia.com, "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 linux-api@vger.kernel.org, Darren Hart <dvhart@infradead.org>,
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Florian Weimer <fweimer@redhat.com>,
 Torvald Riegel <triegel@redhat.com>, Davidlohr Bueso <dave@stgolabs.net>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Rich Felker
 <dalias@aerifal.cx>, Carlos O'Donell <carlos@redhat.com>,
 Michal Hocko <mhocko@suse.com>, linux-kernel@vger.kernel.org,
 libc-alpha <libc-alpha@sourceware.org>, Arnd Bergmann <arnd@arndb.de>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
References: <20260220202620.139584-1-andrealmeid@igalia.com>
 <0d334517-63ee-46c9-884d-6c2ae8388b87@efficios.com>
 <67be0aa1-2241-43ef-aa01-a89ced26c8f6@efficios.com>
 <a1e24288-6ffc-438d-8a2a-d152134c9555@efficios.com>
 <ed918547-1406-4ae6-8a94-4e03712a4923@igalia.com>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <ed918547-1406-4ae6-8a94-4e03712a4923@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0263.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10f::15) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YQXPR01MB5559:EE_
X-MS-Office365-Filtering-Correlation-Id: e458fa89-04f7-4dcb-c873-08de763ac809
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	eFlCqBFmlZ8547zevEL4cPGnT3/KFk3X4FEgne7apQoTXnRcpPbuBxQo6FMT0zYzL6aHrtPJAfIS8d1usMGLI3Z66xs7kvvkDmsTlkVgPixxWDiCFe/hbj99oCsWcNPK1kMrTmBM826LoFSuu/KMPf0h/FOHyygvRlvcl3E+6c8LSVZx2cvVEXhOa3G0tzGLbyu9yN2KCrtbF2mcbkQhRopjV65M2fR9B5IZ7jn5sUyAOM2I9m++ARFDMZCdOsGlHtHUHtwPNXlVYZTqhGPaIEMBRnGB0hG7N4Egr1b57ppQvp3jnmfqAeiTaCwVIphCYXKg32kpsRdtj1qIy6XAM61UaxfjIG4LI4x1OB+0371fd7D1G/0OVN8dpbiIVoLYI4wXV6rCTTzks2zZSpSvS0ZbzIlFbaQ8dYLWx8M1dxOpzk8aHYdZyFaxH9zSPQ2cxfd8/GpH42nG3MBrDbU2XnZVv8WEdVqbN873B4+GitHDfK2zRkVp7TO2BOXy0w/syTXxRzZMBA4D/du+NnkBMXS1JDOj2hY8EbMrVUWR7n23Jx3uegPn2ROjBOPj3aZsI2B10ksJnZe0xioLz9+s4vgW1Lg3D15DGsy53D6cGu0GiJXHf0teHGm2TFg5XDZ/JAI8Ab/U8SmUNQ9b3NLUgqnpYGLD0tioWeAo2+IAdY8OiFv72JZwG0HGoJIiKvQw
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TXVJVC9IRWpldHFzclJ1NGtCdysrTUdkVDIwQU9leWQ2SDg5WTlvdkt6L2h1?=
 =?utf-8?B?enl2U2RxZHdoMWtESXN2M0E5TkZEbGQ0eGFPTmVFZy9mR0oxR0ExT0RuamxY?=
 =?utf-8?B?VTA0c0g2bXlVSEVFdERwTGs5Mmx5cWFwaHN0c3hZa3M1b1NDMHBhQ0R4NjBW?=
 =?utf-8?B?cysyajN3R1I1S1NCc3VDTzMySUJ5MjgyY1hNWFBuRWZYSW1RTFRHdGxRcTdB?=
 =?utf-8?B?eDk3RkhPMVFSRmRsTHBhelFXK2FQUmlaZW40YVJ5L3lxUy9xVGZDaDZrNjRH?=
 =?utf-8?B?OHFXd0ZwY3FBalQwYlBNbDFmSVlLZHFzbnYyd2xZWSttMWM0MG00eHV3S3Mr?=
 =?utf-8?B?R0hxVlcvOVNGdTI1bGpNM2NXeHhtTXNieW1CZHYrU2ppb1RXTy9UckJlMWV6?=
 =?utf-8?B?anJnVThuOEtjdEtyeUEvNzZLTk43Z1pGVytEMVBuRzJobXB5MWROcnl6c2Fr?=
 =?utf-8?B?N0YzQzRTYWZTNFBUNzJkVVpaR2UvNlJNRXV5cFdUTXFMVUNUZ1BNbUlRVHRv?=
 =?utf-8?B?YXE1dmhzUSt0ajhuRTFBUWp0LzMxOXJVWmFtREVzUXZmQzkzL2RIYlJ6d3NG?=
 =?utf-8?B?a2pxWXp3dUZaYkdQaWFaM3dsZUVzTzYyTGg4M3lwaXFSaTdjTUxWVExaWVJO?=
 =?utf-8?B?dDJzZUJSVHR6MHNGd205c1JlN1RiZXplTXk4ODlzVll1ZGh6RFNOOEswaFBB?=
 =?utf-8?B?akNVK1pyK2twSDNwQ21SSHZwNWpLd3FibkZPSy81clU2Y3YraUY5bXIzWDNQ?=
 =?utf-8?B?OGlvZW5SclF0bExybXo1R0RUQ0xoRGhNdFVSUVJEMUx5YndFQmF6SnJrdmQy?=
 =?utf-8?B?cEE5M2hnMkZ2Y1l0QXBXYzhZZlc3Qm80Q09VMEN5OTJCbTdtaUp6R05hMDBB?=
 =?utf-8?B?RGllQTRVZjVWYnRkMWtIU1pYQW5UcGNiTFVTaUVrbndUcVROenovODl3Zkdl?=
 =?utf-8?B?dXZXcFFZaWgyakdRNGpYKzVXb3doNS8vMXROdnF3d3RsaHZlNFk4SVg2WWp6?=
 =?utf-8?B?U0REWWF1QXJ1MFVRVXhZbG9MR0hyR0ZTY2R5aWhSOUVRbW5wVldTSjZlUUxX?=
 =?utf-8?B?SldPdDFIWUYyRkxEaVFyM1I4aXBNRlBUbjVmM2kvY3dpT1BSNWlybTN1c2dZ?=
 =?utf-8?B?TGtwbHpGdHlHUWQvZzBaYnRlbVlpYVhsaXQxQWd1Rkg5Q2Fqb01Qa2JQdDcw?=
 =?utf-8?B?QUR1bHlkRzVRaHpKL29UODlGNnVLalIrWWduQWlVNnRUTDJMTnVLdVBLTGlX?=
 =?utf-8?B?MkFvbHBiVnozajBvdjhCU3pWQUZmR3M1a3l1WWJuZ0JycDhSZ1lybWVIa1dl?=
 =?utf-8?B?NWZTMDJHUlJSNCtBY2Z5OVQ4WWxkVExCNjZNL0FNWnBMWjIvZ1p1aTBJVmxv?=
 =?utf-8?B?V2M3Q2o2OHBzdjZFdnJNbExoWjcxeW5MQmJTcTdnQXpxaVJWMmNkdVZEZ3ha?=
 =?utf-8?B?NXBmbk5WZkFIZjQyL1p2OXhqSjZRTzFTaUlHV09IdWVieVU2YUhwTDJsbERJ?=
 =?utf-8?B?ZmQwbCtSaDFzUGxiSlRYUTMrT0lVNXZkZFNpNWpPdWFLelZYRHlJMiszVDJ5?=
 =?utf-8?B?V1FjNHJCb3AwSmI2YktoV1BWb1dPZ0trSDFRMklDNDZDVFBpL2xhUCtSazlp?=
 =?utf-8?B?ZkRJV1FxMXR4cG1sbEdpNStVUktkSHo2aXJSUWJFcUs4eGw1K1I2OFpPK0N0?=
 =?utf-8?B?Mmt0c2Ric2d0czZtbGZXcWhvc3hSdDBRMURnTUJ1YnBzS1ZZUGp4RmtDb1BU?=
 =?utf-8?B?aGg1VUNheXpwcWpRUWwvcHFlckhFcHlMQlZ6R2J1ejZsZlMrWWxURmJoRnA4?=
 =?utf-8?B?VzRWRHRnS1NvTlg2T0M4Y0t5aWZJamxkTjM5QldUaWVuMkY0a08yY3Nzb3pa?=
 =?utf-8?B?SWdXY1NueVdRczg2VStqN04zZm5yWkg0WVhEQTBNRmowNWVpOGV4TFYzQlpr?=
 =?utf-8?B?cHg0eDdlQWcwb1FOMzZqSjQxVDZjbFZzZWtNQmRJOHJKNitOQURTRFR1TTUr?=
 =?utf-8?B?MjhQcnhJWDd6Y3AwL2t6ay9HVkZya05ueWJ0blVGc0pQMHlXV004Q0d0dG84?=
 =?utf-8?B?N1F6U2padUZydmMxeXdabngyek9KWmYxN01DM1ZnTlFlclNLd2pNS3lid21M?=
 =?utf-8?B?RG1CTUdCU2ltcDRiNkorTkxZNDR0dEhhTnc3Q2hlUVhkSVFhRmtuUUhVR3Fi?=
 =?utf-8?B?alV0VHNESnN2ZVcrbjFtTzRvVkZKRDRrVTZWYzY5UnFlQUF1Q1dkT0RpaldS?=
 =?utf-8?B?VEFDbS9XV2JFMXhnclVEQXJyR2pGbVlWUVBqeFhvemI1d2RINDZDRENYMUxM?=
 =?utf-8?B?bGFHckw5QkNpUHI2czJlQlk1dTBYMW4rYytQUDVMamFJZWZNTGVVWUIzYzRP?=
 =?utf-8?Q?O+/P/ZwmlFopb1Bs=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e458fa89-04f7-4dcb-c873-08de763ac809
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2026 19:59:57.0896
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jjpIBJXQMfJvnl4QMfSyBYTjMe8rVWCt1XTP8bMDeEENn3yI0on4YtocPXRO1a9AoET0806uABsFGOVUVX/6qSYejRTnGi9bGrVco35YW2o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQXPR01MB5559
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUBJECT_ENDS_QUESTION(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[efficios.com,none];
	R_DKIM_ALLOW(-0.20)[efficios.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-5886-lists,linux-api=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[efficios.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mathieu.desnoyers@efficios.com,linux-api@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-api];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,efficios.com:mid,efficios.com:url,efficios.com:dkim]
X-Rspamd-Queue-Id: E69121BD288
X-Rspamd-Action: no action

On 2026-02-27 14:16, André Almeida wrote:
[...]
>> Trying to find a backward compatible way to solve this may be tricky.
>> Here is one possible approach I have in mind: Introduce a new syscall,
>> e.g. sys_cleanup_robust_list(void *addr)
>>
>> This system call would be invoked on pthread_mutex_destroy(3) of
>> robust mutexes, and do the following:
>>
>> - Calculate the offset of @addr within its mapping,
>> - Iterate on all processes which map the backing store which contain
>>    the lock address @addr.
>>    - Iterate on each thread sibling within each of those processes,
>>      - If the thread has a robust list, and its list_op_pending points
>>        to the same offset within the backing store mapping, clear the
>>        list_op_pending pointer.
>>
>> The overhead would be added specifically to pthread_mutex_destroy(3),
>> and only for robust mutexes.
>>
>> Thoughts ?
>>
[...]
> 
> About the system call, we would call sys_cleanup_robust_list() before 
> freeing/unmapping the robust mutex. To guarantee that we check every 
> process that shares the memory region, would we need to check *every* 
> single process? I don't think there's a way find a way to find such maps 
> without checking them all.

We should be able to do it with just an iteration on the struct address_space
reverse mapping (list of vma which map the shared mapping).

AFAIU we'd want to get the struct address_space associated with the
__user pointer, then, while holding i_mmap_lock_read(mapping), iterate
on its reverse mapping (i_mmap field) with vma_interval_tree_foreach. We
can get each mm_struct through vma->vm_mm.

We'd want to do most of this in a kthread and use other mm_struct through
use_mm().

For each mm_struct, we go through the owner field to get the thread
group leader, and iterate on all thread siblings (for_each_thread).

For each of those threads, we'd want to clear the list_op_pending
if it matches the offset of @addr within the mapping. I suspect we'd
want to clear that userspace pointer with a futex_atomic_cmpxchg_inatomic
which only clears the pointer if the old value match the one we expect.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


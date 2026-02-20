Return-Path: <linux-api+bounces-5870-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uGLJCD7VmGk4NQMAu9opvQ
	(envelope-from <linux-api+bounces-5870-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Fri, 20 Feb 2026 22:42:22 +0100
X-Original-To: lists+linux-api@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 3401D16B070
	for <lists+linux-api@lfdr.de>; Fri, 20 Feb 2026 22:42:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 96D113003736
	for <lists+linux-api@lfdr.de>; Fri, 20 Feb 2026 21:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D6B130EF95;
	Fri, 20 Feb 2026 21:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="udCdf4BW"
X-Original-To: linux-api@vger.kernel.org
Received: from YT5PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11021143.outbound.protection.outlook.com [40.107.192.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45AE754654;
	Fri, 20 Feb 2026 21:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.192.143
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771623737; cv=fail; b=gQgHej9xpZ5SNAKCxYwXCIcu7eZix2z+Zh7q4ZTWM2uiBht8efBNBv/0GuiaR9jR5EcWXO6JPEq/y8yTiSbqkEuXTG/xNp8NUqluXyeyepSQz1OWZCKqDvmDnLyfka3nhxoQq+ZyGeJxqq/jyvSkO/ynLNhl4wji/w7QjkV+WA8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771623737; c=relaxed/simple;
	bh=uCqwSPEE+6LtXRudxLorT9OHl9QUkLCkfNUnYToOyhs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QdO5WPJGNTJl6/FiI2Eze6QkVAmK1y6c1q3gYvJHmfHMi3YWMqAqn1H9EQ0YQSgze9K8MIY7b7NdEm996eExE5YlxftI8LH2lrrxucw/4pOnsUJkUDfj3utX0Q5v1tRhiburfcm+088lPqBRhM6rS8NTsoDH2diPqCES5Erh6Rk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=udCdf4BW; arc=fail smtp.client-ip=40.107.192.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wRzV74B06XtH81cUJRrjlfWweySvpGpb4lMcy57gvVlhGgsTUCGUmDhAGzGgjos3N3ylFmm1M0k4XRgBGo7ns0g3S/FCFkO2thfBJOqvffSomTvQt00hM6MY8qYyYaHW9kUMNM5LmpIJiRNOOy+7ZE1wMEvXCD2CrrH5L8Wke4VVU/+ltDiVhwCb0KyENYU/9zMiVK1ZsReDqg00qVuDoX/xXmizIV0/aSk0ovKewaw/v2B4jAxh/wCI2C2jABSqc5T4vAtM8hWFkZRSrDhNAGdmzva7SBz401kVVU0rU29gMyK9sCI8ViM5qjJV0PEh4grrMRtft1Mn9WfE7pFGfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AjAlxv08pByVmyx+1eEOAeFzVeoaFRJq36vJSND1+8Q=;
 b=HZKAiHpqsCVE9S/hwQZM4rI0pGKVYhcQWJJ+5EsLp3lHLk9dgEAeH8qJm5WK/lDSk+wDQ0ItnKEoNrGI+qxbA5Iqde6I4ppk7/euxOPEDQMTZX6t8y5guZEiYDDKloOh+2iWYbejH7uG3tpP2FZ0c84Ax1g0zaIBTRYDfRiLaI4H5z9FUIDSCdnpRV/J8uj578UICkCU6nf1z76DgqDm1/V5qTibjou5lFXaO9rESY8vxUCI1+WST/6v8+i2nQJz+OxsGi6b7xLAdCqdcQ82+fOKdOxK6bXvfI1zvmgvMjOdvIBDsbqjek5eG4FEIqIRg7ppn9kkF5Gq5+LiRjAing==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AjAlxv08pByVmyx+1eEOAeFzVeoaFRJq36vJSND1+8Q=;
 b=udCdf4BWCgJSj3x2hQcjonnmtCXwVOXHBMvSLMAleMHhgW+TV+/PrpCSL4Ka53Zk6rFI+VvyUamZ3+PrBmZ2IRjh2Fcwbik7EXbInTLvuqGfLqafcuYmH4ss2hy5JDgMi6nW5d61ueW8xq8xl8XdDFNQUYDKqEbNKqL5QPUI7Pgcsdbgdedr4EzKHuHY5VwYFf6awmwEMo/1XPHbOd39lYtgKsfvHVzvuwa262UT1lqMHLTn2Xl2iwkyiNGCZZxz0iFJQGsreFEWGLLs+UpBBuCviIL/w58e3d11nWaRpqUsige5P1MGCn0PMgsjd221X69rG7eHH7Arj8re0s9VmQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YQBPR0101MB6072.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:37::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.16; Fri, 20 Feb
 2026 21:42:10 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6004:a862:d45d:90c1]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6004:a862:d45d:90c1%5]) with mapi id 15.20.9632.017; Fri, 20 Feb 2026
 21:42:10 +0000
Message-ID: <0d334517-63ee-46c9-884d-6c2ae8388b87@efficios.com>
Date: Fri, 20 Feb 2026 16:42:08 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/2] futex: how to solve the robust_list race
 condition?
To: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>,
 Carlos O'Donell <carlos@redhat.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Peter Zijlstra <peterz@infradead.org>, Florian Weimer <fweimer@redhat.com>,
 Rich Felker <dalias@aerifal.cx>, Torvald Riegel <triegel@redhat.com>,
 Darren Hart <dvhart@infradead.org>, Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Davidlohr Bueso <dave@stgolabs.net>,
 Arnd Bergmann <arnd@arndb.de>, "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Michal Hocko <mhocko@suse.com>
Cc: kernel-dev@igalia.com, linux-api@vger.kernel.org,
 linux-kernel@vger.kernel.org, libc-alpha <libc-alpha@sourceware.org>
References: <20260220202620.139584-1-andrealmeid@igalia.com>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20260220202620.139584-1-andrealmeid@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT3PR01CA0144.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:83::30) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YQBPR0101MB6072:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c61a50a-52ae-47ce-83ed-08de70c8e6cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MEphaHVFUWxWQ0FLZlhOUmxMalNOc2JadFpJaFh5azY4NnhLdWRQR2d5VzRZ?=
 =?utf-8?B?TzYzV010Y2sxUDV3K0dTMTc2NUl5aFdSSm9tU2dXWUVXQlBVZmFaVGZSc3U3?=
 =?utf-8?B?MFliV1kreks5b1lvaWlrNTlXREJudmtDejdxRi9aMkl5TVVJVGV3TnhHbStp?=
 =?utf-8?B?anI5eEdETUhSNzVYOEdOM0R1VGxmS3l3MUFsMTRGNFVqa1pOVEE5bGpPMDRT?=
 =?utf-8?B?cFZPZkpHQno2UzZacjVmQXcvWFRYd1laamdKLzhLUlFNZzRyOFYwQWxGc1Av?=
 =?utf-8?B?RVJzUnV5ZlRzYkpkSnhzQ2hKNkdWUExlSjllZlFhamdvTHo3aFhUbkFRQXAz?=
 =?utf-8?B?Z1dURVo2MzA5Qm56Y21LVW1hNlgxUG5UY0I4WUhBZmIzUGhuOTEwYk1TSWw5?=
 =?utf-8?B?Mnl2dVU2VDBWM2xTY2VkazV2UFJqTzBnLzFZeTYwZWJBWE1RWW9yTklrN3cy?=
 =?utf-8?B?MkV6VGU1NG5CNjhUWGo5THNndFRHbDJCcTJTNXIxRlpEcTZMSUVWZ3pzQzRS?=
 =?utf-8?B?a0pJUDhzV3VORzFYMy8wRTFlUFNzb3V2cmp5US9jdG1kYlJjNUR4c3JnT1kv?=
 =?utf-8?B?YllrY3ZJWklPcDNIWllkZUNtT2F6bHJjZGtDYWE1RklXb09NR2o2SXBFbGNL?=
 =?utf-8?B?eGtOWGVpSGlTeEtnS3pNYStvdVQ1WHV3T2VDZjRzTTdUVXJ6UWd3YUNNeDcw?=
 =?utf-8?B?c0FOVnhkK0FJaHg2cGFndmRpa2MxTk1GN2g1eDJFTHg5ODhUUG9xTm8wbnVv?=
 =?utf-8?B?TnQ0SnF2eWJZWElYT0NjY2kzZWdNc0hWY2VrSnBmMFJBdlF0dXI5RXZMM3Nn?=
 =?utf-8?B?a0ZoM2VwNGZ6YVlXMEVzaVovemtRU0lwVTE2UUFzVW51ZzlMbkFoakxWeHVi?=
 =?utf-8?B?b1k3ZGZ0UWNoTk44M0lodnF4amRzY3ZIY2ozUFc2ZWpQMUxlT3FiYURvdzNN?=
 =?utf-8?B?bFJnTzlzU0NaeWVxVFFocWVnY1ZsczR0NklQYXhiN0ovSWcxdWJoc3FxVEdX?=
 =?utf-8?B?bVdmZE9kUGhjelhON3BHcUk2c1oxNDZidEhQQ1JWemU4WXRkUTR4QXJXclJm?=
 =?utf-8?B?Y3MwdGhRNVI0OGRXbjJjSVdxM3FYamsyYWxDeXdsdXcrTnkzZy9XUWdMcGtz?=
 =?utf-8?B?RzN4WW5QSUhrSVJTZGNDMndId0lxaE1zdEIrS3RqRTJhOGdEOGk1LzNXazBr?=
 =?utf-8?B?aTlickJ6bi9YRDFadlo0eDdHZGFaaEwyTVJEeko5MHpnR2xrNHFlTmlENWQy?=
 =?utf-8?B?d1hUTk5ja1ZSOUszc1FpQWJLMUhySFFJWDgvUTZPczJVZ1UzaWJEazI4RkhP?=
 =?utf-8?B?aHNDUGI5YkRSUTR3elJPUG5lQ3N3VERpT1ZlbTVoc2duK056NEhlS3VHRG1m?=
 =?utf-8?B?NFZpbTN5bmtCNlpLL0d5YlpqUzkzeFdIaFVqLzBNd0Z4NU1mUDh2VkFYUmFV?=
 =?utf-8?B?WmFoSC8yRlRmcHpFbC91OVdqWFIyNWt6cE5FMVVLZy9ZN2tLN1J2OEpxOUJW?=
 =?utf-8?B?U3NkdWg4V0xQWW54WHFaaU9yeTl3U3MzVEFHMEhsT1Q2U2txN2hUbXhubTBq?=
 =?utf-8?B?aVQ3ZUJQWVZJM294cWNaeksvYjVFOVFwZDRrb3ZFTWszclZSN1I3aGsyRXFn?=
 =?utf-8?B?TnRNTmdXbGl4eUtCdncyOElpdERkRUZjbm5Zakl4V0c5bFdZU0FxL0NrM1VX?=
 =?utf-8?B?TUkycURUMWRRQUF2anRRbWswZGpRZU12MEk3R2VWV3d4MUpYcXc0Nkx1d2Nx?=
 =?utf-8?B?ZWY1Um5ydGNpaXJ3U3VqVmozNlBISG5PR0lVZEp1TjN5ck9xQUdzUzZ3V0V0?=
 =?utf-8?B?cVEvYm13WDJkZ3NsbVFoSWtFOFhVek11bTNGM3ZoNHd5ZFdyTWVpT2JEYktm?=
 =?utf-8?B?d3JWOU5QeVNHVm1EaUhnemRoME5va3p0ZUhHZ0dodVRMRWtkZWk4U2RmVXcw?=
 =?utf-8?B?Zi8yck8wRDNQM0VqQXZaSUNjZEc3eVZ4TC92R0h5dkk0Vitqa2w1M01JYXdC?=
 =?utf-8?B?eWRncXYwRUtWVk9ZWnN3b3Z6TDBoWDlJY3Uwb3pyM2cvL2drb3pWc2UzUWdn?=
 =?utf-8?B?aGRXVHhMdzJDT3JQcjFxVmxDRGp2L1huQVR2TTdmN1pDMWE5WVlvdU1rbzY2?=
 =?utf-8?Q?lXpg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L3UwWCtoam82MzhudG83c1FxQVhmTU1iWXJaMGlUTXRvdkY0dHdWSHJ4eVkw?=
 =?utf-8?B?bnJuekZpRi9pMjRXbi82enE5cXhFZlUyNDZoU0MxMzUvTk5rSGs5SUpRWVJh?=
 =?utf-8?B?c2o2TVg3UDQ1eDl0SkxZcDhBYWhnTjJEUnVlTzJ2K2pwMXZnbmN3Sm90Ykg3?=
 =?utf-8?B?YjEyYzNJb0NpdmZQUkdjZFVhTE1xU1U4Vk5xNG5TcEFNUE00ZVZ3cUxGOTRm?=
 =?utf-8?B?NjhVR2h1eWIyL2FsRmVlMkZkRk9ZZStDSU1obGIzc05BWG8ycm5rMjcyZTJ2?=
 =?utf-8?B?NkpYcVVsTWlYeXRTR2c2M2F2Y2FKOUdHVURYVFh1TU00YUNpNHRSeVNSRjdS?=
 =?utf-8?B?OXhFeEdCQXF0a0I1ZzF5VHdhOEJEQkQ5WVNHYTNCUnpJWjVkSVUyUGxmMC85?=
 =?utf-8?B?R0VLU2doYWViTkoxTllza2NXSXBlUSt0ZnZ3eWIvcHJWMXJ5NnVwQ3BUeklJ?=
 =?utf-8?B?NStlUHVGS0g2NmhIRXhMbzRvSUtUVjIzdHdYYm1paVNLNG1TQmVBMk0zNUI3?=
 =?utf-8?B?bTFoU2x1dUNSaHp1enJpYUhEcUpIbGNaZytBTGxGZjBNNHhmQldYcVZrYkM4?=
 =?utf-8?B?QlozczZhd0I5cWc3YUYzbCs2aEQ4QXN3UFZFRUJSRWordW1MVVowQnIxUVBj?=
 =?utf-8?B?VklZUVpsN0k0bThzVDlQamJsUGJkR1NDc3NtM3ZCcllSeXF4VEpuVjZhbGJW?=
 =?utf-8?B?UEltdEZlUWU4bTlEbnYvenNiUGlBV0JidWZCMUF0aTBWTjBIMTlpK25VUGhN?=
 =?utf-8?B?UTM0ZWJSY05hOUFMRXBTbW81OHdFMndmT1dzZlVFRmIxZUJzeEQ4NndadlZC?=
 =?utf-8?B?WndHTlp0VjhtZnlaVUJjd0dMZEpyR0MrdnVsdHFRK0xVS29rOVhYaWIySHJN?=
 =?utf-8?B?QnM4NlJkY0ZZc0hYdVpWdUxkY011djBwNVZCUVhITFBmL252NUl3ZUtCdzkv?=
 =?utf-8?B?V2VodVlYSmN5SVFuSURQN1MybEJzUHVlQ2VBN2U4Y3FBN3RFdm50NE56blZJ?=
 =?utf-8?B?aG5pS3habUFWaVgyRWRpOTZjV09wcDRLQ0dCMjJUVUx6KzJyc0xJYjFsOWYv?=
 =?utf-8?B?aHlqR0RrVmRxczlLaG1VQlJydzRxY2tUdzIzdnBlM0VNOVNsUjNOTVo1amtn?=
 =?utf-8?B?eVpRcFduV3VnRUcwajJrV0VzemJ2WVE2cjM5V1JwVGhFOFZmcG01TE9nRnM1?=
 =?utf-8?B?NjVzVElSUm1QVCs3VUZucURRZ3lYc0dwb1FzMnFlR1N1eFdxQXJJNlhvblNi?=
 =?utf-8?B?aVdYUkJ6SHVHY2VDRXd4aTJkTUc0OS9NUEY3bjNRdUcwNHVxUTNEOFE2NDJG?=
 =?utf-8?B?dnY3QVh6OXp0VnhpY3ZnVXluUFV4MHZOcW5aemhnanBGTnZ0QWZBaW5Ub0Qr?=
 =?utf-8?B?WUU5ZUxRL1VxWEpNUDBjc0EyZUhONndXY0oxQ2xqUys4WHEvM1ovSWtZUEd2?=
 =?utf-8?B?dEVtMW94dEVZNm5meGdkZktDNnc5eXlycThvNHFBejNZTVBDdWY2bks1Wk1p?=
 =?utf-8?B?ZTdoVThBb25hb1VTNjcwVTJ1cGpqSi9mKzAxRDNJZ1M0QkUyNTEyWnJUdVpy?=
 =?utf-8?B?MzhRT1hIVmdlaHBBNzYvT2FkUEYrVFdUOXNLTmFsdk43TmRxQ1V4cDN3SGlC?=
 =?utf-8?B?RnVINFd0SlZHYmNIV0JCblQ5aDFJR1RXTXdRM29rQkdrOFlNYmdlQTZiTk5M?=
 =?utf-8?B?NEdZNlRFWGRUOFQ3aWdRYnUwSXdKVmNmRkZVNzNPcWRmVzV3WUhwMjJJWkda?=
 =?utf-8?B?MUVLR2UzT3ROMTVINTBZOTlOd2hzVTdOLzBDSHhHUEpiWHlLNFpMMnNoWmRz?=
 =?utf-8?B?R1Y5YWFaNTd0ZC9ON09vSitDMjVIbGRlMWFxNE5UbmVySE9yd1hxc3RzYytK?=
 =?utf-8?B?OU05Zy92NHZRVEF6S3hlWWxXdTVUaEJpMUlJSkJoakIxcThVd0dPdURubklK?=
 =?utf-8?B?WHE3KzNvMng2YjB1NE1ka2hOMzhkNjVGVEZldnQzNVgvVUY1WjhBR2V3MFJw?=
 =?utf-8?B?UzhjWjMrYU13djBwREg2RktqZngwZnRoRjNVaENCSzlWM0NCdW04dW1FQUpZ?=
 =?utf-8?B?cit1YXVMbnRtT21HTDZBZG5VMEVsSmlpSzdqN05EQW9pOFJLOHMrUkdrM0w1?=
 =?utf-8?B?Myt4a29SMXJJY0RRQ0RoODN1L01oUWQ3YnRkRGErUmEzWkN2Y3NQSDNUaWV6?=
 =?utf-8?B?SnlSUklRRUIxd3NYM200VmxhUmVwY1JiTWtaaTZNZmFCRnZrV3RPRWVRUWRH?=
 =?utf-8?B?dEhsb1dZMkMyTWpIaXlEK3kzVnhrZ01Ta0FBNVdKV1UvSTJyL09YaW8wSDVk?=
 =?utf-8?B?c2MyZUF5Wlc2RGNuZjdVYzA5K0JVY3NpQjQvRDArNFBSS0hJQVgraFl3c0U4?=
 =?utf-8?Q?vyqsB/TKuLymchSE=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c61a50a-52ae-47ce-83ed-08de70c8e6cc
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2026 21:42:10.2617
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k77aTWnPXlcNF0UI2m1RUSpOelTKCt/HvLnEU7wZLbXQOnniyMY1GKU2OBZmAmaKRVL9esf5NguIVz2davIDh8FAIXMhxHHnpB8x1NroKyA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQBPR0101MB6072
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUBJECT_ENDS_QUESTION(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[efficios.com,none];
	R_DKIM_ALLOW(-0.20)[efficios.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-5870-lists,linux-api=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[efficios.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mathieu.desnoyers@efficios.com,linux-api@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-api];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,sourceware.org:url,lpc.events:url]
X-Rspamd-Queue-Id: 3401D16B070
X-Rspamd-Action: no action

+CC libc-alpha.

On 2026-02-20 15:26, André Almeida wrote:
> During LPC 2025, I presented a session about creating a new syscall for
> robust_list[0][1]. However, most of the session discussion wasn't much related
> to the new syscall itself, but much more related to an old bug that exists in
> the current robust_list mechanism.
> 
> Since at least 2012, there's an open bug reporting a race condition, as
> Carlos O'Donell pointed out:
> 
>    "File corruption race condition in robust mutex unlocking"
>    https://sourceware.org/bugzilla/show_bug.cgi?id=14485
> 
> To help understand the bug, I've created a reproducer (patch 1/2) and a
> companion kernel hack (patch 2/2) that helps to make the race condition
> more likely. When the bug happens, the reproducer shows a message
> comparing the original memory with the corrupted one:
> 
>    "Memory was corrupted by the kernel: 8001fe8d8001fe8d vs 8001fe8dc0000000"
> 
> I'm not sure yet what would be the appropriated approach to fix it, so I
> decided to reach the community before moving forward in some direction.
> One suggestion from Peter[2] resolves around serializing the mmap() and the
> robust list exit path, which might cause overheads for the common case,
> where list_op_pending is empty.
> 
> However, giving that there's a new interface being prepared, this could
> also give the opportunity to rethink how list_op_pending works, and get
> rid of the race condition by design.
> 
> Feedback is very much welcome.

Looking at this bug, one thing I'm starting to consider is that it
appears to be an issue inherent to lack of synchronization between
pthread_mutex_destroy(3) and the per-thread list_op_pending fields
and not so much a kernel issue.

Here is why I think the issue is purely userspace:

Let's suppose we have a shared memory area across Processes 1 and Process 2,
which internally have its own custom memory allocator in userspace to
allocate/free space within that shared memory.

Process 1, Thread A stumbles through the scenario highlighted by this bug, and
basically gets preempted at this FIXME in libc __pthread_mutex_unlock_full():

       if (__glibc_unlikely ((atomic_exchange_release (&mutex->__data.__lock, 0)
                              & FUTEX_WAITERS) != 0))
         futex_wake ((unsigned int *) &mutex->__data.__lock, 1, private);

       /* We must clear op_pending after we release the mutex.
          FIXME However, this violates the mutex destruction requirements
          because another thread could acquire the mutex, destroy it, and
          reuse the memory for something else; then, if this thread crashes,
          and the memory happens to have a value equal to the TID, the kernel
          will believe it is still related to the mutex (which has been
          destroyed already) and will modify some other random object.  */
       __asm ("" ::: "memory");
       THREAD_SETMEM (THREAD_SELF, robust_head.list_op_pending, NULL);

Then Process 1, Thread B runs, grabs the lock, releases it, and based on
program state it knows it can pthread_mutex_destroy() this lock, free its
associated memory through the custom shared memory allocator, and allocate
it for other purposes. Then we get to the point where Process 1 is
killed, and where the robust futex kernel code corrupts data in shared
memory because of the dangling list_op_pending pointer.

That shared memory data is still observable by Process B, which will get a
corrupted state.

Notice how this all happens without any munmap(2)/mmap(2) in the sequence ?
This is why I think this is purely a userspace issue rather than an issue
we can solve by adding extra synchronization in the kernel.

The one point we have in that sequence where I think we can add synchronization
is pthread_mutex_destroy(3) in libc. One possible "big hammer" solution would be
to make pthread_mutex_destroy iterate on all other threads list_op_pending
and busy-wait if it finds that the mutex address is in use. It would of course
only have to do that for robust futexes.

If that big hammer solution is not fast enough for many-threaded use-cases,
then we can think of other approaches such as adding a reference counter
in the mutex structure, or introducing hazard pointers in userspace to reduce
synchronization iteration from nr_threads to nr_cpus (or even down to max
rseq mm_cid).

Thoughts ?

Thanks,

Mathieu

> 
> Thanks!
> 	André
> 
> [0] https://lore.kernel.org/lkml/20251122-tonyk-robust_futex-v6-0-05fea005a0fd@igalia.com/
> [1] https://lpc.events/event/19/contributions/2108/
> [2] https://lore.kernel.org/lkml/20241219171344.GA26279@noisy.programming.kicks-ass.net/

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


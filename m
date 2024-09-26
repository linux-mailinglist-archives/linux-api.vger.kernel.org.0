Return-Path: <linux-api+bounces-2341-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED12598708E
	for <lists+linux-api@lfdr.de>; Thu, 26 Sep 2024 11:45:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDA7A1C213AA
	for <lists+linux-api@lfdr.de>; Thu, 26 Sep 2024 09:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 985961A725D;
	Thu, 26 Sep 2024 09:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dQWyHMfA";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="RIQHpWjK"
X-Original-To: linux-api@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF616482EB;
	Thu, 26 Sep 2024 09:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727343927; cv=fail; b=G7uaWe5+y1ljoOv5oO2ZWgJiesZW4NoEfbX0Fh7af2Jsl6vXPhZ/zcEBjzG5oVvv4f+4oOVtDajmWpisvJJP8juH7GbVNT3tcfklQdww5fudcOoU3s+/qXku/ytCBwQ2foKOMNS5ODHvZpI+91O+CaXc3hHpVI8B9xBU2jgy8mg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727343927; c=relaxed/simple;
	bh=Wl1HfwiZyeU9oeTHYjnbiTbD1kUDri+xuUqM6Rz0iBI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EOayja/5lKEI5ikr5YM67DiR3xhaj37If8s/7EC8Jt/Z+1GuWQLQdRTa5B9ti1wWN1OvYRjS/06LJOarAXo1tUZ6maFmY7ZZBBwpieIIjyfSYwGqWr0y+ffLEik0qjLq2VLk3hUc9pBjayVVqA/DGgVSQoz8Efe5LFIg/yE+LG0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dQWyHMfA; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=RIQHpWjK; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48Q1fa6o008622;
	Thu, 26 Sep 2024 09:44:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=Wl1HfwiZyeU9oeT
	HYjnbiTbD1kUDri+xuUqM6Rz0iBI=; b=dQWyHMfAO/txp5LV4ieBPFSRKHLYjyZ
	dOWfvqUZi5um75lLBDu8SHXoSpqMK3SlRP0pOZak+TC4D41GyZUJH9RgjrzwC0o5
	mfcVZQmhCFp6ir4mrgY879ySBuk4dXiFluRGGSC6PefXtgjHWmuAoas9BaCzh0NX
	fj6u+TXrCYTSlFk2TLGIjT20QNep4MTUMlBlUgI0wHgM/MkdlqbQ0JoNcmGI5IIo
	oG/QTGX6/FBsIckuMxntrLTY78d0gmAR3pOYbRVAK6DkZX4oQPplf5DGBb829Fi6
	2t9g2L8Yx+wOU5LevVQPgqmCmTcyPCbgYrxwMSfisgpclPsc1dWM4CA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41sp1amk2q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Sep 2024 09:44:40 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48Q8QsbA009787;
	Thu, 26 Sep 2024 09:44:39 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41smkbk12q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Sep 2024 09:44:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=txnzjif5PDRiqB4ZPiJMTzfqNPoxsbi5aSxjuEqu6cYeY7orkPEihqiThMD5iBGEWrjUbJczLctX6f+BJtcdsJCzicCZ9dAbARnh+5lvvaeLYNmsKKR7Ob/gX4XsV949r3baPkdFvN3UcloKhgZ4EKJoCmCghRtrCKZq3nS2FdfLMRPL0RwEBU8FTXhgLOkqEewRUzI6djaSHzT+A2mhceYFLYAn1k+JL4/N7SAAanRz+lYhcp3iHN5Pk2pemn4X5CC50nLHDAzDXMpOFZxpAjSxrHy3GBozfaJpX9XVWf8SZklJnmE63eAAOXHcFKw6YY2PtRwbxnGsi0afaJhu0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wl1HfwiZyeU9oeTHYjnbiTbD1kUDri+xuUqM6Rz0iBI=;
 b=VVszkGwwGo2LoLBSLI8I0/o8K2JibiAWpf8B9/DlXAvO4afHfcp/GyiZ9o3mcNYfIwr1qNSjh6pVHSdp2w9lJ3kC5hKCZVLf2yTylpk5b32lEUJDYGCgExSMoep4Mx+k8taflEcG9TpYzrE7+xs8e7eM+EBJWwTc7FfRol5zNYGxqqzsPUHjmiTFn+XOcRbKxfaTHsTMyDdW+qATc0lldH3w1xR0x+QbQ0Nvume5QiHY07S0aVNgg6TFS8YUy3mONrTVnU2CcxYKVUQQ+lmwhbZ5Xs3QsyLaeiwotgdW/fBgSg/kR4z9f+i7/yUwWIEvXE4kzVxEqo76erjINNo/IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wl1HfwiZyeU9oeTHYjnbiTbD1kUDri+xuUqM6Rz0iBI=;
 b=RIQHpWjKurLoVIvZchCW7zprZjGK5UEmRKtX2iLEk0ebsp00iP//qRDiNFtZGwvsQr3U3zVN96mHO+qBVMRZHLj1tDJMBfXZ5hGJlw9Z1og75UbooBbC4lkgwT9LTWDM6pu2ziipG1KGsxjVrarqYDIROFubIBFxrg5JQy7sy/A=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by BN0PR10MB4823.namprd10.prod.outlook.com (2603:10b6:408:12d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.9; Thu, 26 Sep
 2024 09:44:36 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.8005.010; Thu, 26 Sep 2024
 09:44:36 +0000
Date: Thu, 26 Sep 2024 10:44:31 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Vlastimil Babka <vbabka@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Suren Baghdasaryan <surenb@google.com>, Arnd Bergmann <arnd@arndb.de>,
        Shakeel Butt <shakeel.butt@linux.dev>, linux-api@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Minchan Kim <minchan@kernel.org>,
        Richard Henderson <richard.henderson@linaro.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>, linux-alpha@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org,
        "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org,
        Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>,
        christian@brauner.io
Subject: Re: [PATCH v2 0/2]  unrestrict process_madvise() for current process
Message-ID: <9cf0e96d-287f-4749-ba85-8414c06aa54c@lucifer.local>
References: <cover.1727176176.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1727176176.git.lorenzo.stoakes@oracle.com>
X-ClientProxiedBy: LO4P123CA0687.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:37b::13) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|BN0PR10MB4823:EE_
X-MS-Office365-Filtering-Correlation-Id: 93d6544e-fe22-47f2-5e97-08dcde0fd52e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|366016|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AfKcW2PAd3tFtpeiFvWAIL4mUahrTNSdcejxOQwyeN8I8Wp3L0oRjVLfEa43?=
 =?us-ascii?Q?AZiWVKV1RVZw8IzaUpbSb/2yG3YOpVINqg1EjIW/NAhayBq3xJ9OOT1yDqFB?=
 =?us-ascii?Q?F9VMiTljGyE5aHcsQ4X9KNcybWUHJaWkZx09A4AoJC+3fPHXpPbkSN+MOh3T?=
 =?us-ascii?Q?p9fah2AHfN5I0fGIXevC9c7TOLkCaJU83nP2Z2xK82IFnCyN2r2ApIMQ8zX9?=
 =?us-ascii?Q?Gs75CsfvGt3GX8NID7AGJwTE9wCvfHCh3HWL9s8elM4gufYfn6lkEq/w7OB9?=
 =?us-ascii?Q?UYVdE/9MsdACpSZpBsj90MlJRkvk/gLC8URd47LuKYi+O7wwx1T272zBm3H4?=
 =?us-ascii?Q?J4Y9ANxwflB45SG8xcQ2UmxzSraNzaoY1a2NiLxQpka2yoP71IvqZgVi9fvS?=
 =?us-ascii?Q?npnJQzjwxGL88y/JA3p4+mr8RlaazrF8WEnlf3SsFlUGyt2vd2WjLvsLu7tj?=
 =?us-ascii?Q?oQFaX1kX1IsK1IywgayuK1LnAZkHMPiqA3twbrvAm9nKqZzjHAHLS3mh+nvr?=
 =?us-ascii?Q?Nq0w1ZsDfdwCZmFvOAnQWtB3KTEqvIoq54DI4JKxHfJQTzxN38+5XtB96Y1R?=
 =?us-ascii?Q?olkM0lzyK508Qvq8WTm0TuZPkpm0PlDZdwlVPt5bRoFQlDVW6rSx/VB+Jv+e?=
 =?us-ascii?Q?FojOifXjHPIuzRvkIpMWJXw4J7WdbURnSKv8Y1DSSoVLwx6Ng6uvj9TpQvu4?=
 =?us-ascii?Q?lFr6wBShivmdwlrVkKJQBcQElEZr/NJgQBz7CdKlswBg64kM6t9uZxNKRlBZ?=
 =?us-ascii?Q?YdeSfGEzCm73X3LgWOzGaE1CAQ36bMo/cbas6ECCb7nnV0A41Dl0EvhVgBsx?=
 =?us-ascii?Q?h9NozYHkN4VWGH3B8wrGRIKTm5C4yeREH8T4RUgXFuDp2o1hyjBKZA0s3cGh?=
 =?us-ascii?Q?mpTrvqC0fJqH2BYABaLMRIrKcDeliLh7blV6P9jujQN9B4mIIeDotWh8bf1Y?=
 =?us-ascii?Q?bAdBsiejfVlTAgN0z28KKwgT9g4s0E3Q+ggIWxiTduPpzgwJT6/9lD35ZUpa?=
 =?us-ascii?Q?jucLxJgH5IjgMMXAkUzpqOC/SDnmbZk7oc8O+kI/ZBrF9kba9/MIsiUUyEBV?=
 =?us-ascii?Q?hMTXBXH7A5uRxmgFtg2U3ds3fJ9qquBa+IEvWA2J+JMG9KtLd06uCq2vvKu6?=
 =?us-ascii?Q?qGPGh0ZQb4vXeqZOe7s47LxdYETx+qyLWc0H9L8v/D0xRu3+3VJ88wgXo3dQ?=
 =?us-ascii?Q?UjOJb+NS4Te2U0w5cxmro/8+T7rQqc/3NL//UQbEUdcJ+qUS0fthaDW6RrlC?=
 =?us-ascii?Q?K0Ns9YwP+OL7ZEQkzJLMsD8nY7dDRvdVXn0qq9MIKdOVqwyRt2XZlOXOESSL?=
 =?us-ascii?Q?ECFTycg76SM+JSoj5kRE3zRIU+fQbe8MKA2q6+9pXfzvOw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AIwnYy728xaPXfUHIW2wALMmV2dRmJMjYv27TCSUpGj9GrDljWU80kzURUu9?=
 =?us-ascii?Q?Zx4De1w+720s3w589xuSL4Cm3c1Ca4PRiHcNZ+TUsftGn3K0F/kEy1Nf3ASb?=
 =?us-ascii?Q?bmqJGFDnPpu1bcl+Hdf4X5VuA+u/kUtzy4f3sW0fQIMIGuejy/twX5UPJIQX?=
 =?us-ascii?Q?d27H8/Vf1d9QVKf/g8pS///IPC+zfqv0BcJzKaAmN/7cZ/cC9xH2mfaWSOHv?=
 =?us-ascii?Q?UCq3ulqz8lN1i2yz5Vch8xLI47GqX1NKVrzfmLjNQcjEgVtLgxRWG0bcXMJ8?=
 =?us-ascii?Q?wmneJa+m1+aLf3L+Znvht8aEdd+lkzniu1kTQupIYJbmXk2of5DXhCR0ysEP?=
 =?us-ascii?Q?+XvqOk6/MmXuunCQI+D6WT9DcRowYf+21iYo6jhypWyV+CGK5n+r81k8cqWA?=
 =?us-ascii?Q?109znQ3FyZM3yQhOWC+xYjpc2r/YZWYWFKcY101po+C8dyiG9rvMCITkNFmx?=
 =?us-ascii?Q?onPq37kicI0dreSoJUifOYdeCnwzV+s58fH0SC9sT4DsADttFMJi9xrdJBdm?=
 =?us-ascii?Q?ABmJHzur/RSSQAw/ofElvqRsc6cHjXzxmY/0qKP6Cpc8bP6UUeA4wuhcXg2m?=
 =?us-ascii?Q?7Uhebrkay+1iFSZmLyK6GBI+kcdQipzIkTyZ8UgvwQhbgGDglsY7aAWSMhFT?=
 =?us-ascii?Q?JJDojPSCCyQtOJvkKbDP6K0TU2eYTgW6Nzk9fyEII/CVAiYdgdeyLRyhk/5G?=
 =?us-ascii?Q?xaMXNTxIJYLoIuCB1OaEOpO1qKR0GkIC4luT/ExS1sA0WOL8dd3dZ3Ifknwr?=
 =?us-ascii?Q?se2ag0RKS654i44G0mnSJ5rpB2c59Iofhk/YIc2HEv+e0AzGPRBiiLrYagbE?=
 =?us-ascii?Q?lqBGaEsGJ4lc7IN1w4UvKNvtw6z1fWhrR6J3PFN0iBaIi73kErVIy/UaKXGE?=
 =?us-ascii?Q?z+HVPBxfkt61dK4Ok3pXe6h16bGgcPbKnSv+Kt+DwassqIhEVt7ZRRM0sezV?=
 =?us-ascii?Q?zYXcVv3oQOZbIJJ41nNDkEMUILi6wkZ7izvTculcahty3fE2Sh/gkajsrHoT?=
 =?us-ascii?Q?VMGJuqxkpJxaPYXHG28Sysu1NXBsDu8WsXs680CI59X2QTKMkL+0sjWeG9jJ?=
 =?us-ascii?Q?hMDTrrB/eumRx9TxAiHbFVsUSRiS1UlpI55aRj64uMTiGFbOKMDfiAenrWI2?=
 =?us-ascii?Q?d+fc2mF/kKPQ1mHcyAQY4rBpwmKBg13HzPcbDJTqeT6aCo8TU8If1qqpWBcJ?=
 =?us-ascii?Q?jpLlsdswYm1GVr+IIKd+t5mGLKVIq6wkKWx+jzn9vK1F/Z93KtjNVo8iY55N?=
 =?us-ascii?Q?/ovdblfJRuQdyaJtdvq9+7dTaNIhjaST8yzW5Y2QKUUIyDFkoOCoiJoQm4Xi?=
 =?us-ascii?Q?ntmKUfk+IhwfH8zDIxBp1wZulExFXG2i1hPjDkvs9fh0Aj3VBD22wTDspOMQ?=
 =?us-ascii?Q?LrDld1yw0hG5zafyZvnHVxzfLTrgRb5CdWgPz8YimCGaZpiFunONhLCiMTXD?=
 =?us-ascii?Q?yofDHZO1yCmIeiskAWsQSNuNaadPBDoBZgrft2+uOHjSxoJ0NgXkJ6xqQTLs?=
 =?us-ascii?Q?MZjRoxtOQ1KtDm4i8CAsmYu+U2usb59NBOD/j3utbLCFewMSxcIyEttvYsiW?=
 =?us-ascii?Q?mU0UuN6flcGzyY8HdNRGBH8tUKEOauq90J8RkSvRwRZYBK6xYMhzzALt3TIx?=
 =?us-ascii?Q?hlskv4ZDz+6D8ewwbRsMAdZkEyaMaUIrfpolM0UEwhAKlNwzhswI8GJKHxlp?=
 =?us-ascii?Q?IGUVzg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	YsUaG0Xe/tErIKPY45dCW4qvIHS48ASjVbNzzsHpu4egj+TUCBBnoj1e7kGuDAhWihuwpYnlLuo/jmorcPZmKM5LlALQda+Kx8pv48DGa/UDdtqDzC1+n5Mx4yR1Yk3i9g6FqVzH7/HgRXstAmJZT9QOd6UaKDP/xacmbE8V5dFCPNMJGalRhdq716l80pT61/5anW++M20CjsTGskSSOdAFtUuMdN5nhGPW0ACYcTxZzW2kQ6o3e2MqGk4kh0uHuKIi1wuz/bOaT53gqqVZOUhUQUs+JBKSxH+J0Fkzm9Mq6OcwE/3ii9NVuTC/n/qVPjVWFm0NQOb9E6stTk0Tqe380S3t2NU31ANkEMuMrriyftAjn1m22rhhzegVXQg8eyeVOLefLG3C8h9Wvm6QNYJ0vMi3brxjAy1qYEHw3BKsU6oRy9fMKEfThwcDnEFJ5/c9eog++2sxzf7VHBCtGIv8D5JlhPCU2/7bay10d7ETYVNa8ErnDNXx36e/DSX5wGSr+iOXttZwPUh0q9//ZvqqXxc7/XOI5wZiAifZaS4Jv9+KVqg5Bx1IQP73rIB6JW0wdZi/bQA63UlxWBW750k/efRKnFGfbi1nQyQ32tk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93d6544e-fe22-47f2-5e97-08dcde0fd52e
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2024 09:44:36.3199
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7J9alx5c0wHLOAYdhJwjClT/cJWV/TVY77DMyF9dlapGTXLzWDxiz0qWx12K1e4tH946fZGp1K4q6OgbpGNccRfytT59zBSRTZNul7Ivcik=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4823
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-26_03,2024-09-26_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=629
 malwarescore=0 mlxscore=0 bulkscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2409260064
X-Proofpoint-ORIG-GUID: P-7RH18hd1wuD6MrRTMihu-KImCKyZDb
X-Proofpoint-GUID: P-7RH18hd1wuD6MrRTMihu-KImCKyZDb

Hi Andrew, please drop this series, I'm going to take a different approach.

Thanks.

[snip]


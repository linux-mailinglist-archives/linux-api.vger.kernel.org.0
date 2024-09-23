Return-Path: <linux-api+bounces-2320-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 631BD97EEDA
	for <lists+linux-api@lfdr.de>; Mon, 23 Sep 2024 18:05:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82D171C21629
	for <lists+linux-api@lfdr.de>; Mon, 23 Sep 2024 16:05:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 236A219F111;
	Mon, 23 Sep 2024 16:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ReigIwKm";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="RSyriIYL"
X-Original-To: linux-api@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D6E19F10D;
	Mon, 23 Sep 2024 16:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727107478; cv=fail; b=EXdc9U0M6B1xy2tHKNbuYgSycODI5YkQxMr/yuJ/DN6IHZzcujL2rYseKsUkcHbUvoE6uxSkFni86903wigswrasv2O/nOhuThsjFB2ASIRqCmkMm8waM6Zaw0zQDycXzgqVAHOc/9rH5hOM1b44061G5TmGg/te9KHZPaOZVkg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727107478; c=relaxed/simple;
	bh=fTGi1/VCAxEEp8XehiDgV2r1pqM1HTn23fenMylzOls=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tQ0SfTtbB1xSTuvavkJW9Tpdnae3kwkGIvj1KV3Cj8fVDWwuGxlYy3oKS4ZA2JQFed5qIkKUrX/YcJoLLpsN+A3uwWv1S7hMndRBviV+WiPfPKf/i4Gp9FGjmIEOXO/uTXpVjkfXF7xbuN8twMtVOYVTkMplOyPjwXWfJ2fwNeA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ReigIwKm; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=RSyriIYL; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48NFtX9P021774;
	Mon, 23 Sep 2024 16:04:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=W0q67exA6YdXcrL3YepDeU7tz8LTl7V+/D0PXUIJ5u8=; b=
	ReigIwKmhPvAbU0nnhXVgzhmro2B0LyTxZotEdG/Y+9tql2Tflk9JaJ+H0dKptFc
	T6jcbPARjoQV1aYMnr24nQMrGTnw8qPgr7lGgZCGYMhTtZhPARhh2nRhX3Twmbcd
	I99cbvhD+vucbDsUYm7Pe9RPhFjzViav1wtZNYjY/5XVjwiwlR8KMeDCSLGhUDr3
	t62IAn8wQtsMqMI5doFUpN1fOmlvd3CGE5eMMzLVzAZ82kSWdfwDK17hkKu97UM5
	gv/812aXLcCddf2yTs0Xu+P1Oqt6lYIOmAUgv/sWp4Q6bXvzJpApeDg6hyTTm5io
	jTpGV1n+G30M0H6Dll6FDw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41smx32q47-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Sep 2024 16:04:12 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48NFUeje000461;
	Mon, 23 Sep 2024 16:04:11 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2045.outbound.protection.outlook.com [104.47.55.45])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41smk7qpkr-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Sep 2024 16:04:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ma8ulFKpyY0yVSUFJ992rFc5eKV1ahTQt7dFZV+F+gObsGQuAHk7u4hglXH8WMvdQ5yZXwA3XVqLhGh6fwRDEfsU3vT6ewOOLeOno++MW4Kd3yZytYKjNrh9y5x+qTDh7g5vMPdFxFjVoyR3IOdeHbpOoyhzKFkN5rXF2llHWUWatlRrrvIG6LMYuxeYine1WN13hgsLklidjWUPvsA60ZTZuM54hFY7+D2d2r+x4fxuJWTlOPep6szBUfN6t1CfotRvb0ZDscRswMlDOv3N3f8DbHgOi0Gg9BtafiyDUYTU/DaS9vYtZz4vVk8RWBswHF2xtlZ2Y25NWSlvDcqOyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W0q67exA6YdXcrL3YepDeU7tz8LTl7V+/D0PXUIJ5u8=;
 b=ykEYuvLxKA3QFXC8J+LzZoKDENhVaGH7+DX/v4qnccQCQ5EktBqhKMBUSz9PZlYMIB9rofHQMCBzsP/vFd/93mkdf9J3I9l3/YZI3iAD2hxc2mj2w4BNnnTIPaHmfz3Mj+SiW7xjUBQu8ZsN7daLOivdrmWDQIhS7IjqbmFOAp9VmbknPucujN1fju8BIEfko5Ak4shH/JYxmvJF0NhmzV9kIiCOh9W3xfU21c8JRVt3quRkbz93AbfXtHfCG69iyeArj0t+m4kJZkbe05JuVah6TyemoXbO+fztVdodwAUzukiWwyktNpbjzgILpJX6WvM7ATbYMN1u2F6kgLawCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W0q67exA6YdXcrL3YepDeU7tz8LTl7V+/D0PXUIJ5u8=;
 b=RSyriIYLVO6A0lwpiijVMPpi5ucG3TW32ozKIM9Nq/raEGTkhekW6dwU4G6PljGO/c2grOWbjpHhjsuGYbSbA4h2eYvZ5KrS9+ZRYoybxeN9lt2waSXcY6GxD+/8/lsd29/kFTz5l56Dpy0FWqJRxNscc2hZQ7lrUpoLDzESxXE=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by DM4PR10MB6744.namprd10.prod.outlook.com (2603:10b6:8:10c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.13; Mon, 23 Sep
 2024 16:04:08 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.8005.010; Mon, 23 Sep 2024
 16:04:08 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Vlastimil Babka <vbabka@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Suren Baghdasaryan <surenb@google.com>, Arnd Bergmann <arnd@arndb.de>,
        Shakeel Butt <shakeel.butt@linux.dev>, linux-api@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Minchan Kim <minchan@kernel.org>
Subject: [PATCH 1/2] mm/madvise: introduce PR_MADV_SELF flag to process_madvise()
Date: Mon, 23 Sep 2024 17:03:56 +0100
Message-ID: <077be0d59cb1047870a84c87c62e7b027af1c75d.1727106751.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1727106751.git.lorenzo.stoakes@oracle.com>
References: <cover.1727106751.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0495.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:13a::20) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|DM4PR10MB6744:EE_
X-MS-Office365-Filtering-Correlation-Id: f3c438b7-86c0-43c2-d0ea-08dcdbe95a11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|10070799003|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?I/lgZUYvPLkX21hO9tXjo5dGnd649UQu0DiC8DvVqeb34PURpX6uZDpdRcRf?=
 =?us-ascii?Q?cSvSwSOWddGv18f30uMXsCS57i5FLLGJVOAk9Wm5Dg2lzsifT/kFZjmprFZf?=
 =?us-ascii?Q?ZXremJybjDUKYt8ihHJJOZkqTg3XvdfgIc/H8bqRtjUZZlxEkeYDx29Eqfc9?=
 =?us-ascii?Q?H7wYAw0z6vKxqjOXglBMr1s4S7v8GtCqakR/wsFlBR+d5AnocS7JGt8P1Ufv?=
 =?us-ascii?Q?QMquQbk5EuA+FtrQESEmvNMuU60HQaLKqoiS94QCe2KqgkM7Vn/BQJnce4kR?=
 =?us-ascii?Q?SCoXcgF1y3wg6Fc1RI07A7n2nxPLTDW6R55fugcezQJ38yHEehcFhfij47Fk?=
 =?us-ascii?Q?L6iFJ8GXjtRc5vkCtkICqxY7Ef5cPkHQpBx6N3NHo0jd9UmKH7XNtfyx63Ua?=
 =?us-ascii?Q?/6HbX6ScUWM50eHqi6AmY8JAnu2rbzFCxv3BKz7Ki5F8rPyKyc83MLdQblWS?=
 =?us-ascii?Q?iJhPVKvcjewGg+cUL1gd+NSz3y0qntg13EpwkChi8okdZ89rYxoBLH4lZ7Du?=
 =?us-ascii?Q?TeXEQ+lp/SKZAM/bO12Wz+AsABXuBxtspbEQNlMCwAdwQTD4EaQ5tyKHOTAQ?=
 =?us-ascii?Q?1i+EhfxifkdwGCAy/erKn1yJp0tiBhWEEMvTmMufgwf/MvojCgh0EBx4tu5g?=
 =?us-ascii?Q?QngGONUpEJkroGqSkgLjDXonzthhHM5vWscS2rSJ3AIKwANmrShpAaQnPlY8?=
 =?us-ascii?Q?XK2QtxoMm7ZpZvGWPaK1M1xas26JeVwkUw6Gv3125NdB7O35kXzHqbSATM6Q?=
 =?us-ascii?Q?srEwF9Vhkx+5GxGnyVQWz+HrDqwMMzZjFUVTW0QCfWPeOiI+cIPDlD9NO4Az?=
 =?us-ascii?Q?vlAbMTnVAaji34LN3+uAsCd3CFZG954zmZygUvstA3WmlltvS5qKc4aHY1MR?=
 =?us-ascii?Q?V0K6/Q1TpQ0jfTRNmCjXit60GlNN92TMJBIdyk/C7nwA3+5a1OXRa8mHHYVq?=
 =?us-ascii?Q?yfrG07YkTdaj768OJenpkI0errobkkTwbr+VvnFZ9O2mZxGMKwlcSdOidqdd?=
 =?us-ascii?Q?59NVZqWl1g4kacpk6uohyLvluK0JbF15/7ja8rXfLKictS9SmajXNvBJcmXY?=
 =?us-ascii?Q?4V+9RQHjYySijIyHNjph8sVKTSWPSvDlVziaWT+tQ8hLdjDjeCHZdVQ3tfpi?=
 =?us-ascii?Q?ZXfi7RRBCfHrX/T6L/T5VgPUrdS3xV8Dka35+km7zx5Cx46+c9qDpVSxVlDc?=
 =?us-ascii?Q?t7r2NMApiacPRlJnLe4zFT0bWtEEwR65spXzAdGe5n00CY2J/+I21Z4x4fx1?=
 =?us-ascii?Q?/m6azQ54wxaT1Sjuu7YgXY5muGJg7jrbFgbn3Mn/EqWx5iZVIkG1CNg2nnBS?=
 =?us-ascii?Q?56CL6IcxbGGAddvUeVNpVJqTS3vcltMUvZqB902ujY/18g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ELe0cC/VvYJzuHeb280kcJBxR9LxJa0/XuLYAyraZ8UdS1Iq6+izpSvtM2A/?=
 =?us-ascii?Q?hpbd1AULIcUO9x9/fvSr7nVKbGFuzSdQFyqpzN2Hbhc5V0q4Xjp6ZTWebnxD?=
 =?us-ascii?Q?LpQUVdOOwGoD1436Zmkk/1P+lnb5gBKIaFJ3wUShfXsee4Dej70VheAOfBy7?=
 =?us-ascii?Q?1sQjNfDkWRaK6UKzrHLGriYqPub7VBYVB0Zn1O1bWD6JrCcc2hmQav2lpljR?=
 =?us-ascii?Q?B8JKt73Vt76+fMAzzuyweuMjQb9MZ8NkA2P038lTgtCaVc6Ksix610aEYs7K?=
 =?us-ascii?Q?z+2mIwqSr98eV+ifeQXrYZ9XByOulrUaoO2p9Vlk0NMgbjByYRzEUwWpdqs0?=
 =?us-ascii?Q?9MA11SXLw7oXDBXln4xTgfuQRro3eZxvHcEdhlX4arbu0+eRv/tSSCdSYpcK?=
 =?us-ascii?Q?qJp3LJtqWxgts0umPo8AJHelWHAm/9kzMoQ4XmaXUvphzHffUzpOxUnYYSI9?=
 =?us-ascii?Q?8/5TnKRR7XR21WRAB62MttAmimJEXAFCKUT1gBtQArEXYpxu8+rCl18aibag?=
 =?us-ascii?Q?IBw1RpNEp0FEITqDLafBb61Kb/lgNqvVZAv80SOgdzX+wxZV6H6G1dm6VKcN?=
 =?us-ascii?Q?E72HUdQN4FZTLE/CpdCTyb+u0MXMNeML65JNcOv4a1S4w898qR+9mOcGNFS4?=
 =?us-ascii?Q?bY3oXr9qx20RUCB709uXlMLYDNjRmzObVeDQJ6U1LMIdMgStUxQ+gKkkbI/c?=
 =?us-ascii?Q?T5tTYb/mh3RQ/yrWyk6kKB7Ka1FtqrgjrCnkZUHoGPzh3H/qwB01CWDuKufz?=
 =?us-ascii?Q?uslGhJMn+UBarMI9ygqE0NNZrB7WRVQq1FkldBKgy3P5aw6ijKA4AKJcMS4e?=
 =?us-ascii?Q?AOYdV4FojbySCeTsaU3eHUV+Y57r5WcgCWanosDcLd+VKuCdzu4qZMq+DJkv?=
 =?us-ascii?Q?c7B/2tMq6PN5Upd0WthD682I4qudt+X9sAIQqWbPe/Lmr9dLGKghVu0wzlmx?=
 =?us-ascii?Q?TepYLlZZHk89SlLyWGfG/qysjKplGpvPlrVMIha14fyuzJR/aopBh/VuM32Y?=
 =?us-ascii?Q?C4kD6Af32/Q9ixM9uL44NlcFUMfGso6PvJj1RfUWvoJ+dxGGlLhZ8H2fz+vK?=
 =?us-ascii?Q?bL3OK+gu5sxEj0VvWBOJ0L0fCCXeMB2grMLD3jzED87dShy8WWVz0x1eooWp?=
 =?us-ascii?Q?0Xf7OBno1SjzqO9VKXwfyblRifRSfwkal3ziObaSvw3RoxaTIHE7bQs7CYDL?=
 =?us-ascii?Q?9mQiNLGxK7Ey5Fh2nHfOp9WhNZy5yeVSeXxT5Quq8UOrrHfTB72+HLjqGs1p?=
 =?us-ascii?Q?vY9j4o4FMPUyhPvlhgvZuev097qLmX9ZmWbnfjqE/EwYiQxebJnd13+iHy+8?=
 =?us-ascii?Q?fbgwMKeuzrtHrE7Hw2nOJXZXBZmEQOPWeFWM273toyWt8FqYVj6wxNyhouls?=
 =?us-ascii?Q?pDp0bqWNOUHouY3tGIGptvIGoPwSdXVneSNrs95otu03tzeIUjBjsVYLkumW?=
 =?us-ascii?Q?94R8HMldQux+7d12D5EbyIH/l6cRyzwPWx1YoIPFP5YikP32FhC5UhdtBAbG?=
 =?us-ascii?Q?MjDofkzjCmPGVIRoTftBtpOjfGCApZpXtpnl+7PxRyYGGxhqIy2CZkBtgWzV?=
 =?us-ascii?Q?PdHK9B0/nwJ3wAVt56wiIb3Zudgy8CtteUX4cqJ3rkluEZP72n+Q185f3o+Y?=
 =?us-ascii?Q?gVVCoi1QmDDndqYKPZoGBrkFFUBlfbFlQhrtbBT/7nW6WkooUg1ckL84EpV9?=
 =?us-ascii?Q?uqywPQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Q9SWoSQjloUIaay1zLP9PXXNbHfyYX57sUQc4uhmZOMigTpn0TT6qoUtH5zypjtLpPxa1Y7Llm7cRnW2k/12rrdxjNne1fOK6AxKf9Eh+vD+kC/3MftVHCblsEzUbtgnAckImrND6U/V4UdxnqZ+hK3r9rvr+QIFa2wriQzJ2r7H4KpiHIsKeAwKNh5iQO17L8hn7F992kiffTkNS/6lIdMf+m/MaD/XuGnkHz+QQiZjXF8z6bxLyQxbVedJo5bmv30HHBvAu7C9klnwVV0rWp9wqRgvZrhEqXugw1Sl+eq2zaKzg5Iwrt4wvF2C/rwANvNaj4DDd5y4ZiInQK4/yPSCIoqkcW+yXco4OMzgov5rBVQcPvIQmu7N7XSUoV6InBaoUkXSoKQWOXlE1zy2q1wqMC0J58T5bdBFmSy0we01a1hpV3I4AAb0PDvANlcfiodmsr4tcUkdOmJekXxC8VPnWhhlxWd0dYoFSaki1+mShPcb4eu3vpaZ5SdQzEO857AXph9kPnRUoapjg4gt79RxsIDm5rd6vVw7V5QaKgiZhwxYV0X8uyHV5Neo4jO+Hs09dP5K0P+7qL/UOqVfh3YpxLUH+ApSwjLfmt066d0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3c438b7-86c0-43c2-d0ea-08dcdbe95a11
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2024 16:04:06.5729
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hCMFRWTBx1WJlx8kreCh4bLMfOcDaHIzRnJDnjRe/h0MfZhvQ3EsA+6b+MSr2YoobYNdPo2oq2pMOBZqYRbJZX49oM3fhl40N/sDFEgcqSQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6744
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-23_12,2024-09-23_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 malwarescore=0 mlxscore=0 bulkscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2409230120
X-Proofpoint-ORIG-GUID: Cfg6OGNxv8c_XJD9P9l8cUjYFLk5aDDd
X-Proofpoint-GUID: Cfg6OGNxv8c_XJD9P9l8cUjYFLk5aDDd

process_madvise() was conceived as a useful means for performing a vector
of madvise() operations on a remote process's address space.

However it's useful to be able to do so on the current process also. It is
currently rather clunky to do this (requiring a pidfd to be opened for the
current process) and introduces unnecessary overhead in incrementing
reference counts for the task and mm.

Avoid all of this by providing a PR_MADV_SELF flag, which causes
process_madvise() to simply ignore the pidfd parameter and instead apply
the operation to the current process.

Since we are operating on our own process, no restrictions need be applied
on behaviors we can perform, so do not limit these in that case.

Also extend the case of a user specifying the current process via pidfd to
not be restricted on behaviors which can be performed.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 include/uapi/asm-generic/mman-common.h |  2 +
 mm/madvise.c                           | 58 +++++++++++++++++++-------
 2 files changed, 44 insertions(+), 16 deletions(-)

diff --git a/include/uapi/asm-generic/mman-common.h b/include/uapi/asm-generic/mman-common.h
index 6ce1f1ceb432..8f59f23dee09 100644
--- a/include/uapi/asm-generic/mman-common.h
+++ b/include/uapi/asm-generic/mman-common.h
@@ -87,4 +87,6 @@
 #define PKEY_ACCESS_MASK	(PKEY_DISABLE_ACCESS |\
 				 PKEY_DISABLE_WRITE)
 
+#define PR_MADV_SELF	(1<<0)		/* process_madvise() flag - apply to self */
+
 #endif /* __ASM_GENERIC_MMAN_COMMON_H */
diff --git a/mm/madvise.c b/mm/madvise.c
index ff139e57cca2..549b36d1463c 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -1208,7 +1208,8 @@ madvise_behavior_valid(int behavior)
 	}
 }
 
-static bool process_madvise_behavior_valid(int behavior)
+/* Can we invoke process_madvise() on a remote mm for the specified behavior? */
+static bool process_madvise_remote_valid(int behavior)
 {
 	switch (behavior) {
 	case MADV_COLD:
@@ -1477,6 +1478,28 @@ SYSCALL_DEFINE3(madvise, unsigned long, start, size_t, len_in, int, behavior)
 	return do_madvise(current->mm, start, len_in, behavior);
 }
 
+/* Perform an madvise operation over a vector of addresses and lengths. */
+static ssize_t vector_madvise(struct mm_struct *mm, struct iov_iter *iter,
+			      int behavior)
+{
+	ssize_t ret = 0;
+	size_t total_len;
+
+	total_len = iov_iter_count(iter);
+
+	while (iov_iter_count(iter)) {
+		ret = do_madvise(mm, (unsigned long)iter_iov_addr(iter),
+				 iter_iov_len(iter), behavior);
+		if (ret < 0)
+			break;
+		iov_iter_advance(iter, iter_iov_len(iter));
+	}
+
+	ret = (total_len - iov_iter_count(iter)) ? : ret;
+
+	return ret;
+}
+
 SYSCALL_DEFINE5(process_madvise, int, pidfd, const struct iovec __user *, vec,
 		size_t, vlen, int, behavior, unsigned int, flags)
 {
@@ -1486,10 +1509,9 @@ SYSCALL_DEFINE5(process_madvise, int, pidfd, const struct iovec __user *, vec,
 	struct iov_iter iter;
 	struct task_struct *task;
 	struct mm_struct *mm;
-	size_t total_len;
 	unsigned int f_flags;
 
-	if (flags != 0) {
+	if (flags & ~PR_MADV_SELF) {
 		ret = -EINVAL;
 		goto out;
 	}
@@ -1498,13 +1520,26 @@ SYSCALL_DEFINE5(process_madvise, int, pidfd, const struct iovec __user *, vec,
 	if (ret < 0)
 		goto out;
 
+	/*
+	 * Perform an madvise operation on the current process. No restrictions
+	 * need be applied, nor do we need to pin the task or mm_struct.
+	 */
+	if (flags & PR_MADV_SELF) {
+		ret = vector_madvise(current->mm, &iter, behavior);
+		goto free_iov;
+	}
+
 	task = pidfd_get_task(pidfd, &f_flags);
 	if (IS_ERR(task)) {
 		ret = PTR_ERR(task);
 		goto free_iov;
 	}
 
-	if (!process_madvise_behavior_valid(behavior)) {
+	/*
+	 * We need only perform this check if we are attempting to manipulate a
+	 * remote process's address space.
+	 */
+	if (mm != current->mm && !process_madvise_remote_valid(behavior)) {
 		ret = -EINVAL;
 		goto release_task;
 	}
@@ -1518,24 +1553,15 @@ SYSCALL_DEFINE5(process_madvise, int, pidfd, const struct iovec __user *, vec,
 
 	/*
 	 * Require CAP_SYS_NICE for influencing process performance. Note that
-	 * only non-destructive hints are currently supported.
+	 * only non-destructive hints are currently supported for remote
+	 * processes.
 	 */
 	if (mm != current->mm && !capable(CAP_SYS_NICE)) {
 		ret = -EPERM;
 		goto release_mm;
 	}
 
-	total_len = iov_iter_count(&iter);
-
-	while (iov_iter_count(&iter)) {
-		ret = do_madvise(mm, (unsigned long)iter_iov_addr(&iter),
-					iter_iov_len(&iter), behavior);
-		if (ret < 0)
-			break;
-		iov_iter_advance(&iter, iter_iov_len(&iter));
-	}
-
-	ret = (total_len - iov_iter_count(&iter)) ? : ret;
+	ret = vector_madvise(mm, &iter, behavior);
 
 release_mm:
 	mmput(mm);
-- 
2.46.0



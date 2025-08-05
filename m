Return-Path: <linux-api+bounces-4302-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D2E61B1B968
	for <lists+linux-api@lfdr.de>; Tue,  5 Aug 2025 19:33:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7ECC718A71CB
	for <lists+linux-api@lfdr.de>; Tue,  5 Aug 2025 17:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B14EA20C469;
	Tue,  5 Aug 2025 17:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="L/U2sEwL";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="BhrdeY18"
X-Original-To: linux-api@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ACBE1514F7;
	Tue,  5 Aug 2025 17:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754415202; cv=fail; b=JyXeV1CmlFFOkNtjh72ST9kxH9VK0ou4yGECvQQDa/tjs6NRsfUcqVcKYdv5vZAoI7bXdckIyffm5i4+LaN+yjpw7W4Wv53GLtz/nV9p5NcIw0xzqjUTi0qbKLiE1F8AYmXe6yrWQm++aRLTEwNcwhPQlPkOeh0FaGpF0z/Tz04=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754415202; c=relaxed/simple;
	bh=GVl0J+opRiUgR3WVEYCOsZ68YsN4HKTUPcc4+wnXG0M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=r/ff1B7TKfOOAX0KNTyDhroBW263qW8pCIacEp8ndDq+dpnuCdewmdebMh3wHNp9HTIoZXfbHLPyX9FF5t5S6pFQz1s3UO8eLGdx1qFOQD0z2BA5lQmgDNl8yYbDFfEstqTcqB1BB/s4Hq+kDOYiA6DDtoY6WxVoTAqlRPr4pI4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=L/U2sEwL; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=BhrdeY18; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 575G16bM019945;
	Tue, 5 Aug 2025 17:32:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=4nGx+EyaXj/T2kvftpSDel3d7Qe/xUU3MueglapTnuY=; b=
	L/U2sEwLcOdGLvxrwXqbkYLINdB7ae0oWn3p3VqI50OeMj2tSB9E5QHW/tP8i8yN
	kL+pbC63zdj3NeXecyRu9X1+8L07YglBCCkNE13zptAYtX+12ktUXPAcuw8AWvu5
	VlR4tt77MszivSWF9KmfMkXc7TxqUc0yzI80Uir3AM3DXy7cKPttkElLBaWlyqz9
	GvmvC1pJmg5sqTzE7SIn76XBjAsqFpqo5ldrTITnISxmzjwcIltrnyrA8C7ZHUnx
	Bc4KXqNwBUVm7ZUUuPS6ZPIFsZ43PDLEhouXkFjl0VHG5fQ5CZ/kM5tVQf+zYk+N
	a3IMUVtCyaxMqFgGhdzMMw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 489aqfnc0f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 05 Aug 2025 17:32:16 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 575GLTbI012029;
	Tue, 5 Aug 2025 17:32:15 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12on2069.outbound.protection.outlook.com [40.107.237.69])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48a7q28w4n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 05 Aug 2025 17:32:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RR5IWE9kFISekp0fi7J8DwtwlyRp+1T2y4tG9UmLd+KxCAqvEtDBgAxlXT/uqKRvHfmFt4jsGLnFdq+ai0XE9a/SwuE/7fQ9ykvmc7fioDevcqYCAyoLzzMMG3oGylpJUap43flCLIqTPFXU8Ir3Mv5fhpiqFMuSbc5vYnq+0F9vA2aWeVT3fhW0pQLEK64rVFIm7k2V5JMDO/tGPFpipb4Xp/hyNHTfwEjXMd7VSDS3qmysZR2FRM/eDRUZlTfpUR87UbuK3Btmae0PCiYwh9PaoYqa4dHeWagpoHEvFMCNDhS90e775uuD1VsCRuYrtuuL2K7pnPgw4TCpf/rw7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4nGx+EyaXj/T2kvftpSDel3d7Qe/xUU3MueglapTnuY=;
 b=pAFkijs05mLyPdlgDAjSkTQnxVuQztvqxh6f6+bo6arSW8tW9nCXlf+6Q8gemWp2eG1LadZEwCgNj2JcoxeNACOf2ZQ3hj65qNSt6vAVYSjOThaXohX5/fQVX7lChsm62XXPP/q9va1QyrAXh2HUs7jZbRUKfaBt03LS+Z/savELDN9zD1/955KTsBp2380ZK6zclpWnjnNkCbGj+XvRylRB6AHXwre3L+yYAiWof66ynbq/QJ/DAvdV6UaaBHnKdJvddaXupy2l7fiR4KYfoE/6e9J3n3JHHxGZMJxJSzJU5/pAXO+nQylr11ZEfjCIhPmvQ7h93dZziMDspP7v3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4nGx+EyaXj/T2kvftpSDel3d7Qe/xUU3MueglapTnuY=;
 b=BhrdeY18ga7IpfRVSS43i6AWx7TSw0VRPUfAJJ9ZW8547mZzsooug1r47owkICWvLsbNZEXDUZ5X1vAlV8qrfpXNZ3XcvWjcKj1hHiHVu+BYrCAEhezzb6nN6TELLaUfAvZIkos66D6x2cQMV5P9Yg+qzo2G2iPjW8RxzVde5SI=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by PH0PR10MB6436.namprd10.prod.outlook.com (2603:10b6:510:21c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.21; Tue, 5 Aug
 2025 17:32:11 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9009.013; Tue, 5 Aug 2025
 17:32:10 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Alejandro Colomar <alx@kernel.org>
Cc: linux-man@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, Rik van Riel <riel@surriel.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org
Subject: [PATCH v4 2/2] man/man2/mremap.2: describe previously undocumented shrink behaviour
Date: Tue,  5 Aug 2025 18:31:56 +0100
Message-ID: <c7ba8ba09b1c0b015134c54824788ef4aa47fd46.1754414738.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1754414738.git.lorenzo.stoakes@oracle.com>
References: <cover.1754414738.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0395.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cf::19) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|PH0PR10MB6436:EE_
X-MS-Office365-Filtering-Correlation-Id: 740e8a9f-315b-44f8-fff2-08ddd446024f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YRuBEN4OuaXNOBhDIC2UW85uEdYcTi2geYqFeHT17BFLqSICXy3QCiA43dkG?=
 =?us-ascii?Q?OZCf0LZWaKtGdT70in/DLXBtpogFE8srowz8xwZ9B0rxy7DUkW6IxbvpLFgd?=
 =?us-ascii?Q?2Z04B/9vWAV84pTeK6nHekk0gIM4HcekWyx9XaPM4yZ7iUy9VehElWvV1Scv?=
 =?us-ascii?Q?IyOQMyo1buJLjAQuwj1Ii5cuW1X3OcwktSZF0lxqmDi/VQFqQhEEMHXSnMJf?=
 =?us-ascii?Q?DglBQWvOsr57oOx/Y4k8UQqE/T1lKZj/rMR2G9EIaI9nyzVkaA+HX0SshOaN?=
 =?us-ascii?Q?/Jg1mUXbiumYylJnpmrL+qLgDaufxPWwQwOGCNsfrzqSIdtXeDYsW6NHrNvg?=
 =?us-ascii?Q?1w7s3RyN3FVeozfgejCjvHj/n2rE04Q/bGDUIpbTiGvmSCM6XfMElJiapn3R?=
 =?us-ascii?Q?QxD7qT+Q0+gs8w1WVE/kJBTevz3iPO/wVUoGHpKWupy3voxaY9kU9NWZx7Rr?=
 =?us-ascii?Q?fg2KJegR3PcMSfmWnbZdFi1v6/M7+Yvg8hSbFoWarS54/orC5km8gM9PlNwh?=
 =?us-ascii?Q?6MtS3tgqbdOE+9bk0R7gnJlL/8u8K0IXw97x/YxaggINkQoyZgslfGrZRGkT?=
 =?us-ascii?Q?YIizYPv9B3hUoTg0ffC5ElD+jyCOUcsXx33bSJiznVX+t84mlAh6zIWbTf2b?=
 =?us-ascii?Q?ILgugkcJ5RHH20za1XSanjIQCvHfw8S4m8e3Ml8Ghu7OiYDuJT7bLrGu4oqp?=
 =?us-ascii?Q?l9XUJV7IFoqo7cQdfeXKvizBHcKofn2xqjwctej0Uz9gcdVb49SaZ9wFFz7M?=
 =?us-ascii?Q?VV+ahY0IYj9N09LrchKdC1QtETOpAZ80sVecR+bkD9ccW10nq5sN2GEHgRGv?=
 =?us-ascii?Q?hyBryDsn0EEo5dB0s/rTSuULXj65rJi0arSc/ITTx7bql31+1xHbUZ93C5sK?=
 =?us-ascii?Q?LNM/qWbUpxZXnWl+Q8eV4AnYEaeo/aMIjfMxpouPQJzRQaB3M1Ct6nn/ciOY?=
 =?us-ascii?Q?XVpXqATDy/QbyWJ9jpfc5AFkmTu4hWwoSMJPHBObJ1b23hS6+senK7zv3RzC?=
 =?us-ascii?Q?kmk+QWBo2aLwJV4ncJlzIpmT14hRUQt+O4qSOg/cxp6AG4J68kC3ndBv/Tii?=
 =?us-ascii?Q?HzgvlNLN52FsPSQAD8VUOXv3vg2PCFSJMJl8jWw9rf70scYqIIDbLy/2ymgf?=
 =?us-ascii?Q?r71dsySh1JNKN4U/yauVFDEHR6IevMDvCoh+GznZLiA6THmMqX286OAnJqOW?=
 =?us-ascii?Q?BH5en12QmMbVnWB76HbpgOEnUd3GOjIEAh99ZkmbCK/Dkfagdo91baf9BUHm?=
 =?us-ascii?Q?6txn7NilVeAm8EndmU6YZDefTNzquNRy2z9jJ3LgUEGoXcRAzYKebnjvTFtt?=
 =?us-ascii?Q?a+QZgBEI4Mggl78SKFgw4JUPz4CzrrpejQEpCKqqZ7DErynOmk2sK3pm1uV3?=
 =?us-ascii?Q?i5LCE6Z44zSKBMn7xOJxff1jyLdeAyL15myeKyeq5SmaNvto+3NV/9Jm1rjI?=
 =?us-ascii?Q?QdygWq2ZHAo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0MuuByg8cUcBC3lyJ1aHvuNSVQyoNBwjEU7IOLg5Stck28zfV32zkzQ6AUoG?=
 =?us-ascii?Q?ykmpbdJ0cW+nsxJFSuZEYG+SHvYL1sH3fHAuXKfV2+PV2NiBwwNeFWQhak7J?=
 =?us-ascii?Q?NfiHlz1/GInMszPd2xIwYhHg2MwlZ5W4Afs/GZlzdQxaK6yfwdHpBzFYOVfs?=
 =?us-ascii?Q?0N2V32wRER3itfe9kfpMMpb1AnQkXyTmoI3bBdaTsmKWp1RvrvQnY+kZYbGz?=
 =?us-ascii?Q?QaRWNyfPnzkMozDRhg7M3ngqR2ivRmdu4bhTcOE2VzGsplwCPusTkr6VlMml?=
 =?us-ascii?Q?lRxbV+QLNCoP+KxXgsk3lhmt7Evg/hO/OF346tA2ea99s9BFOwiiN/VAS+cg?=
 =?us-ascii?Q?XypbwsasozzwYYp07lgnPsB0dvgtVy6pm7n3S97Pa2qFRpeWLWaCKyyvI7xz?=
 =?us-ascii?Q?e5lX/NBLXAvlWdgswjy3cxgALuH0M9EqrYyGBn/dUgYT8m+b6/40n0nNUSFo?=
 =?us-ascii?Q?9/LY4rIJlprJ1qQIwia5qF9UibBkDGmNkd6Kl2zG+VXbXIo533gykpnkApwk?=
 =?us-ascii?Q?/bja5bGVavOJLzwZ04J83QYjNAmqhRJOqKkSGQWbtt6Wt/k8UFiBxLiINDv9?=
 =?us-ascii?Q?Z69rC0+mUFlhDP56jTcYj6XA7wJ3dFQHBtnrcXN9t2s0a7UabTPMNa7Qv3Rd?=
 =?us-ascii?Q?VFz9Ic+YthDbakciGJVLDScWy1J8En5ME2Ki+ZqB66e8IJmBzV3KodVww3OA?=
 =?us-ascii?Q?LpxKSj7E21egiejhP8TbSzjx7lyhLm+EkKW/UsbmSUYI8/sI2Fyq6OdEuRwB?=
 =?us-ascii?Q?X80CWlJ5nRUkK1f/iliLKf/K/pf8gVDO9uZ/X3IYi3qBSmkXWKnJ0qA7apj7?=
 =?us-ascii?Q?MDDQbpKa0iqaSEgwd/KzqwN0sNTb4olyz7fn8cdIQK2Y35pSvodFsbw1NS6a?=
 =?us-ascii?Q?ZeCISLxI5BjRebuwBHqcuWmQ9etUGx/QiKnm9Llxm5pjT2ZOVpj+UbUfUdRI?=
 =?us-ascii?Q?qCvUU/guG9lMlG8UGT0vX53VbBNyhTV7NvGcil2FCMRcwssFwjEZ0SGCUEUe?=
 =?us-ascii?Q?PgCkynn7LoOGDh+Xv77VMHTb82fxh21D8xjuqSvvTZDq4NPbWQZzGz5G4aaY?=
 =?us-ascii?Q?v8EecliIAwHjJDuhvCeB8SmcwYHiTdWPpdnfj1hDlMx4JARMOVIe+EGHgld7?=
 =?us-ascii?Q?Cbp3AheZqEijNrf3xDoHPNw+TTX6iSxrHH+rp+RbINJsNyHPjhfD2ejFb7wx?=
 =?us-ascii?Q?0/hYPMd0u16wAyeZxJO6OwMdBbCiBDQsA0cHaKteFEXgwOICBZLBSw0rJb9x?=
 =?us-ascii?Q?RGixmABclk3fzkP+4VzSoPmDMZhwU2iRSdIYYdmJPDVESqDCst05Mc14wF0l?=
 =?us-ascii?Q?v7ycsxsrufExLcC22WgOX6cjy+K9x66GGdOw0Fy/lDYj91CprB/B7T/I4luX?=
 =?us-ascii?Q?U++lh1TmPQcMY8KtVw04qjdVTFgvSG/P3s6cTpo1vQyUdgpdT4y0KwAUrfEL?=
 =?us-ascii?Q?iMd7SNkjc91PvioiWWW0d1iqClzJ2GvwksuRZDJBWefh58AFYB8kq6mR1Sgb?=
 =?us-ascii?Q?Q9eyV8hriCBmq7/QG1pqBWpmM/cEs8p8gIzJmb+PKXAVxv+ImKRRyI36QHJU?=
 =?us-ascii?Q?5MhKN+Sy4naS8NOOiE8GgRQ5KejW+Ivp27YS6Pz40CkbDkD+oRLf61zvKao8?=
 =?us-ascii?Q?Xg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	8ueiLVkbAtDKLA5yRA0ptbR4Tq1o8WXkaDYYia3m53gX8sDaLe+v7/bZv4aGx2YgMwM2g1imGSIuiOwOiuGdaBZv8hcwDd7CWx0TlG67rzLtywu40OG4nFRw3zoqfqU+eOTlEkTWXiQ4CSNv1esp1hO8FOv3sB2Ch0utX4YkLxNGYQxYF6FDDVYJUaZ53A2fWgLqHJKBGlJnl/AStUQb4SO3rNrQl8ugc4ecJ2hoTVNOJUhdJk4W1ezqLvPl3bOnLd6qTbDxE/vRd3All6l7tT7zaAB0r/s31U9XzubWsQ6+tBjM7i7DrGECPjiwHyzYpG3SLAKlRd4lpVJosTfSwl+owvlSIQD07jW3iF0wdUP4UAjdhvHbECToU1BRkuG2augJ5Ze97i49V5C0rlb4KoE1d80ohiA6aesCGLXnUZ9+JgXMf574ZHn3mOBrlC3TXfKt1f0iIDjztnmS8xpeBRgeSC97od//ZuYJFsOglQ2S7YidEXVyOs58fNMcLBq6U6G3ExEyhE9fAsmVyN+XwCvwCo2sBdObQgAhuVixL44UDPw1MQDrdFD53Ny8RzZ6jAmXsRGykwtcOT1REuyeH84UFQGAQZ9RH/oXiNo6X8w=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 740e8a9f-315b-44f8-fff2-08ddd446024f
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2025 17:32:10.8610
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AZamujse3S1jBqXC6Z5m+PEsokaKDNyYszOCVTQj1FAyogg/dPpEDny5ra2P2AxulWfzchQcNQKFMJyeeOvTF4nm4aUW6UmE5+iIdqnVzKE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB6436
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-05_04,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 spamscore=0 phishscore=0 mlxlogscore=999 mlxscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2508050122
X-Authority-Analysis: v=2.4 cv=TrvmhCXh c=1 sm=1 tr=0 ts=68924020 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=2OwXVqhp2XgA:10
 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=hqxEFHVobavvttKUrIwA:9 cc=ntf
 awl=host:12066
X-Proofpoint-GUID: z_ePvDpij-gQ71sGK3MY0PIq9gmheCzp
X-Proofpoint-ORIG-GUID: z_ePvDpij-gQ71sGK3MY0PIq9gmheCzp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA1MDEyMyBTYWx0ZWRfXyPV5IbfNP9kZ
 UDpEi7YG4O7Pl1l85He7lr4YGeHwKdlEsvN+HhkPer6mpu96ZdqCp/Gg+VzZG+JherA65evZYXs
 V9W4U/kpUd5JBeQi1KmwkOfhXTA7NCa7Xpc1NYQCH2on+jB4+kn3SeQTaBgRxkKt+Hw6BOmwtWV
 G+B0qBYGCh2t0Asypr2JjbLhT42j7Fm1C+tYg048ZOhpqoLltAagz0pL6/9FDlKiCSHS+O7Jwl/
 81680V6oknMky+uSHFZBWUDib2z4HieMAvlTtrEQMh0OCEgCLO7JXFAQzg1rSuYO9/SdU138Gp4
 6kbRPspqDwnq6L/cEFZWLBePVGI+z/bTZaO1Y08VyRZAyNHxRDwW6DAdN88rHp9MIasmFOPfS/5
 Bp/Itm99IPKjCc0wpUvwOJAsLUJ+cIQdlzszVz7A9oZh94PWemBzu1HkQz15fM5uLL37sETO

There is pre-existing logic that appears to be undocumented for an mremap()
shrink operation, where it turns out that the usual 'input range must span
a single mapping' requirement no longer applies.

In fact, it turns out that the input range specified by [old_address,
old_address + old_size) may span any number of mappings.

If shrinking in-place (that is, neither the MREMAP_FIXED nor
MREMAP_DONTUNMAP flags are specified), then the new span may also span any
number of VMAs - [old_address, old_address + new_size).

If shrinking and moving, the range specified by [old_address, old_address +
new_size) must span a single VMA.

There must be at least one VMA contained within the [old_address,
old_address + old_size) range, and old_address must be within the range of
a VMA.

Explicitly document this.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 man/man2/mremap.2 | 31 +++++++++++++++++++++++++++++--
 1 file changed, 29 insertions(+), 2 deletions(-)

diff --git a/man/man2/mremap.2 b/man/man2/mremap.2
index 6ba51310c..631c835b8 100644
--- a/man/man2/mremap.2
+++ b/man/man2/mremap.2
@@ -48,8 +48,35 @@ The
 .B MREMAP_DONTUNMAP
 flag may be specified.
 .P
-If the operation is not
-simply moving mappings,
+Equally, if the operation performs a shrink,
+that is if
+.I old_size
+is greater than
+.IR new_size ,
+then
+.I old_size
+may also span multiple mappings
+which do not have to be
+adjacent to one another.
+If this shrink is performed
+in-place,
+that is,
+neither
+.BR MREMAP_FIXED ,
+nor
+.B MREMAP_DONTUNMAP
+are specified,
+.I new_size
+may also span multiple VMAs.
+However, if the range is moved,
+then
+.I new_size
+must span only a single mapping.
+.P
+If the operation is neither a
+.B MREMAP_FIXED
+move
+nor a shrink,
 then
 .I old_size
 must span only a single mapping.
-- 
2.50.1



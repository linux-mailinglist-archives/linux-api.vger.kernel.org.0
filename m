Return-Path: <linux-api+bounces-4301-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AAE7B1B963
	for <lists+linux-api@lfdr.de>; Tue,  5 Aug 2025 19:33:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D162627241
	for <lists+linux-api@lfdr.de>; Tue,  5 Aug 2025 17:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCB8BA55;
	Tue,  5 Aug 2025 17:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VVQaiXhf";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="qeUfoW0y"
X-Original-To: linux-api@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18360295504;
	Tue,  5 Aug 2025 17:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754415171; cv=fail; b=iot9eZbJHmNUv8TTPm5Nq0c+U/KdwBqrqoGaiHDEp21Psd4r7JxTI5cnluVZoF5oNEinpHd7mTy+Ac+OG++BNf28vdp8HxKFsb0qFyby6WyVd3iPMFbzY9fDUFrnzLtMccT90ccslgpJk7ok5jkb7171G80F7FfJzT2SxSYZZts=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754415171; c=relaxed/simple;
	bh=zlvXQNyE9BkOn0wKLiN9ogV5fb+F3Gn3bL4Sdb9YoWk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Yp60cUEPURzdHxdXOXQyk76InryG70EpX15d7uRJGtiwgmTBHMP0Cuwav+5+Opg3WUdtvSuoklijwpnhqE5EulqLPaoVs3C0vl+3mXIJkSWrwXyWKWB1wont3Y1GMEUTzkXyHVB9MqHI7773FdpOQHj3Jyro4FHDdzYSCjnrtzA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=VVQaiXhf; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=qeUfoW0y; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 575G1ADb014821;
	Tue, 5 Aug 2025 17:32:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=fToKJ6Ln0KmoCoJb1BINCH8lrRsFr3xgZ6j1b9jueq0=; b=
	VVQaiXhfe+nsWw7hA7h+lGcuJn30U/nLfgJ6uwqt+1FMMz84RgYehfboxS6+QXvv
	CHzeFBy8hXkqxVBUUdf6iAR2iS3oFrsW7T1Oess79ALqSGCoB4JyJra1i2mPhTA5
	9YkZlGtAPIlHuNYuexi0gFhvsdvcIcj33U/XbVnicGxUSbt+1iPEDSdyc4c0FFzG
	XALASF9w+1n9RXKxhZyGq53QWeJWZlk9Eq/J99GSWhyX6LWG0JtecwqHoedIjISP
	qO5XmsFmG771ZpxIcGiyGNKPkuNNcdAcjLglFYb71cRa3buTPTpFJPQeXRJGsGJ4
	LINULuYJHJ/cfeT9VbCOWQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 489994nba6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 05 Aug 2025 17:32:12 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 575GOBFW025291;
	Tue, 5 Aug 2025 17:32:10 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04on2074.outbound.protection.outlook.com [40.107.100.74])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48a7mt225s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 05 Aug 2025 17:32:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g1VwUnDQhkO2iAXTrvotK37QZYq0KRzNwX0922149WOY1GypRafrvpD260h0rz/z6CYgRy5W7TfjmFIUl8JwaRAPHdhAAak0X9klwh6/hpRXUyuAfRWr1wxW0I0LUHGTdW2NFSjhrtkpKP+vjaAwqCZJzOVHBg2vRQFBOq5wuAZJh0qve+l7KhJCY5tEa4WOPaEjVRualSUB0JH4cc11CdGpN2lJ3sMfvLsx7eNLqttIK2OTg0lAq+EVQyqtTArGhduyXU9/2YRnQcu2xFkuRo/VlgaUTazyX6IpKJWXLHV7kS8not5vDKGn3JIQsq8lkCtrXu0h6CRRckWUyiglyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fToKJ6Ln0KmoCoJb1BINCH8lrRsFr3xgZ6j1b9jueq0=;
 b=JwyaOIVITgQna4NZAwsM2lbVVpgckvSztyGR+uw3JNj0NwgA2GXTgRNJi7hnepa/LnpxQBBqSAo9CsYHUb/F9W1JB5jyds2N45Lrz3Ju3Dw0453xDZzWxK9feqlGq06EojNMqhR0Cc7/WocbUD0uymMCyXNi2MJPXdw8Gu4yU5qQ9Vz/2snHc5VxqMogjXpPURfeO2ggzjvoeDT2btOOTqrraufTjZGMFoo+zah5wbTDOJhOCgHyG83a0fqGyAsHP7jrSBOvVpWVLVrj/9rOPp3/Ns4xnX3AtxAubqgdHaeVuNDXkjeWgG/fE1kD9yjfOqlqLhhBDriVgpMIRU33WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fToKJ6Ln0KmoCoJb1BINCH8lrRsFr3xgZ6j1b9jueq0=;
 b=qeUfoW0yy9VqBqTpDhePJlHzp7foDIuCZI5cjiblvRUo5vGyRijbO+txkCIq2dZIr9xHOw0ozM2/yzMSTmNYRpzRoouzgesyM6eOfb01Bz4oliB1SLU+0oMLwDyO65CfMXwWC+1VTRsmxMR4MlHecnXY9OQi0ODW2O6aXUl6EHg=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by PH7PR10MB7804.namprd10.prod.outlook.com (2603:10b6:510:2fe::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Tue, 5 Aug
 2025 17:32:08 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9009.013; Tue, 5 Aug 2025
 17:32:07 +0000
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
Subject: [PATCH v4 1/2] man/man2/mremap.2: describe multiple mapping move
Date: Tue,  5 Aug 2025 18:31:55 +0100
Message-ID: <53e4284ffe80a63260c957369ccacea8f5c16adc.1754414738.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1754414738.git.lorenzo.stoakes@oracle.com>
References: <cover.1754414738.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4PR09CA0013.eurprd09.prod.outlook.com
 (2603:10a6:20b:5e0::19) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|PH7PR10MB7804:EE_
X-MS-Office365-Filtering-Correlation-Id: fbada35b-d36c-4899-80f6-08ddd446005a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ro/mCld5DBVk3D4qURO/qqig7ScFmEX/q11ePro27byN0EXoCQ/b7wFVQlrp?=
 =?us-ascii?Q?CsNkD5xzb3rVJx40gG6fIh+5oudTqcPaPr2BI4pTWQx5woaCKabctgnRLWD6?=
 =?us-ascii?Q?fVUNeIX4dFIl+YzNZOmfx1cNG4hvTlRFr8zTFW6ywwW1ux10nKg0XXQ9sE3+?=
 =?us-ascii?Q?yseK0Vm3Q6o3OKqr/fEv/OP5ISubVQoRVccEfSFR1aenf4+hLCi7rEjR48fI?=
 =?us-ascii?Q?lOGTAQEeqm+qy9+ZGwc1sG4a/Vc+hLuiaAMpLQhbXtRNhoM5BvoYMzdTuTjc?=
 =?us-ascii?Q?6duazPyVcFsreUUeYWfHJSpKroeweGHKDBzktMk0Jo/YOuvlAl3CY1oRA2RB?=
 =?us-ascii?Q?/9o7OnDBPkAsYYiQrJ9akMejYq4BZazKx1VTG6PGCeFBHMc7W8iRPFNRb90t?=
 =?us-ascii?Q?Bp0SBFnpJPpgvq2Rk+JHF2lBDVdfdD/Zn5W8vYP5kqK7U9kgnu5Xoqq31JBn?=
 =?us-ascii?Q?pV6TIzZCVQ0Da0MQkaFrZWnjBMPpu75lSQeIXsRg9HRwQRN8Mtga5pYl1JA3?=
 =?us-ascii?Q?XQMcrxTB2OflCXXPYWJUoPLcVBcFh9ZCk3OZyZpgkka33a0wnyZ84ybZx3Ml?=
 =?us-ascii?Q?ZZ/7m1LpTZ1AbhTEN7VR37g8kaL5wZjRqDaRz1LTX+2KsBwZ3s6vkgwyieRb?=
 =?us-ascii?Q?ZO3HQZCWTr3iKlug+0f8wj0Dd5zrItCPQ5rEiLhkkuda2KLeXAmDxVwhZGLy?=
 =?us-ascii?Q?Xvraf7EdLORBYCKi8VH+mSl21xt+gOqMT4rYm12y8+izYyvnGZWuNdo/sZMO?=
 =?us-ascii?Q?tLaVZegHN74BhqX57bn8yEZydQN4D3MaThO1vIC/Lvweqw0UTiJ+5Ly3SSj1?=
 =?us-ascii?Q?9lNlaWqIn70IkMmEscmeA5mwMZjWDpPWVN4JkiRLcZqbe2WF0ANIn5vMTzSA?=
 =?us-ascii?Q?mYj6qIXykgu57voLkWUeLOY5wtqsPPRnn6iUd8zLNhy3ZfrcchPqDkd385S3?=
 =?us-ascii?Q?3UfIbdX5YC1vcDJaBPPxntP5eKp0BS+5g9Ev/kO2KE5upNOXW+NUPIvGG5y2?=
 =?us-ascii?Q?qezT4BIun10/12dJq3QFxjzhDnqfrPBpCAI39QOzeHTa6TRSp9tWBAZDVFMS?=
 =?us-ascii?Q?kGG811Yy8/zGSz9AZKH1nv3OD/5z5J4rppPyI7KeGPev/mcnXUW276d3vTUs?=
 =?us-ascii?Q?lwhJoxcS1IPyi32ZgUEt9/udKA88JQ5qVDd3NWWikB6Df+Hbk6tZyXJwoRs1?=
 =?us-ascii?Q?tr9h+AgyzNlZRvxUcwbx9p303CABXQWVz133o/ZJWXupIhkXlRtx/C7FMHSC?=
 =?us-ascii?Q?3HJNEigVS3KchrC0ioO6bdOEDpeyFfLyD8y3jbXBH5NA6Ep4G+/vGDo03JzU?=
 =?us-ascii?Q?Ivn03kvyBgR9qnPvPg2uisef+pXOV7jCn0yfG6/wqFFmQSJQiLoTmimM5x4Z?=
 =?us-ascii?Q?0ISKu3KE64Y7EZJIlCJkADig41hJPKTd4fWKaPi4mVLcVEUyhAQ/0xRSVzYk?=
 =?us-ascii?Q?AP7pwROJeTM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1fxXDGgswc3vOVUPqvwaBqy5flMGhZcreev0KVMD3NDhVamy5QXDK0VNehoF?=
 =?us-ascii?Q?k6A6o0Lr0VjL4NDklO9e+l3bHOssh4tF5T/eCyHqtrPkqHZ8WwKYQWbPz17Y?=
 =?us-ascii?Q?SowIWi/T4OLZuwlJJ1I8oRa+MoKVZqEQSpjK9V1TQOfgCGO+qwmbFlcpJ0Rp?=
 =?us-ascii?Q?TvVEbnJevIahRAlY/YwsCwZCTL/f2dWXVLJzpgNNmbc3tkBk3UF26pXW5UUE?=
 =?us-ascii?Q?uG9m39Oo4wLC9gpZuY314gN+XGa7lQcSld4W37+WBgbC1i82YSw9DnsoKhQN?=
 =?us-ascii?Q?l94zgesaIOyGhDGWRtaPcGNfTk4I38qH2G561CV8lgnZtFAAkJWQBpV4Sjxx?=
 =?us-ascii?Q?fpjmV3SAdh49PNZcbrpLja7PE2V1nsxF4dUMGlj1Y2zesGRJmt8DOMjmU+Ny?=
 =?us-ascii?Q?7YdYSjU3/Qm1TYP34QqioOVGP6gUrbPCZyMBh7ZeoumdhyYg4SO3mc9UFLHa?=
 =?us-ascii?Q?UJEVJnUIIAaWjfxipiULEz+yQcAoYNjklg/2SXa/RKpNzmnaz0mWWC8v876x?=
 =?us-ascii?Q?WWBSID4tTW4CuHCgBHbDdP4Bwp06nMH2WPNNtir9QSnHxCEAuvmkPa1N4OR1?=
 =?us-ascii?Q?W+TYTrVk21sZY/OHzUGSwX538Y1NSTqG8r1sfDEVM60s8pptN0k5du43b+9q?=
 =?us-ascii?Q?F9UNa6WlSi5zpNnXF8E3libulCHnf7kN5s+UE715Yau6bv8nu3PomYUB7EPp?=
 =?us-ascii?Q?mLPXmzgXy15l8+YOWh/J4fSvW99GLEfcyu/XKPmMHSoeZqcSXZy1ThvSvnoJ?=
 =?us-ascii?Q?WkETLJW6/ipxa8ZzJRR0nEj2FU/q9BIzS1Jnchku8Ty7iswEBDD4K+9aj18O?=
 =?us-ascii?Q?F2fHfd08v8hThkgBRvuSFIA3YPccog78Xl3k2pnlKdjyMIV5TKFQJCEcrMtv?=
 =?us-ascii?Q?u9dciMzneOb1IhnxFEZTmLvbGQgQTJxydbTpbsS+31jY2y4933QVR3LaqUJG?=
 =?us-ascii?Q?EreGDwuFUVHkeenQCOZeWRavX+rMgW1EPHr0bjaZACC6nHZFO9P7cF/YVIrF?=
 =?us-ascii?Q?toH40IY6u3ubVfM9744PR9i4NNOkhtDr7hehz9Av/ROAH7VQtRYBRJKQ9wnw?=
 =?us-ascii?Q?dQvTyEtx12Pr3UL8MLDCbZ8dXdVJ9JNZ12F99xgreC/JUKCIIMAwklM0atkG?=
 =?us-ascii?Q?yabnQhUTE842rrw1zNOow/MqtvUN64Drm1yJdSRzOh2cTm85Sebu5WJ5ZwR3?=
 =?us-ascii?Q?0ZFZNs4JzgjH5CI5+opB9TJEXtkxJrFedhdte0NHT3N+XGgV/nYvjz+iPeSG?=
 =?us-ascii?Q?pxVe+imNhXSv8okbtN0ThBdW9YF6KdOCs0evx6q9fK5ZymqJJUzp665lhUzq?=
 =?us-ascii?Q?168BfuVIQWoR97uqW6DMvGb+mzOuKIFlAKeDFJZDpjGQFBwhqN/BoMk+Za1y?=
 =?us-ascii?Q?KGNmh1VbSkjkHVlbFwORBfDO1V3mzv02oh0wQNO9fXb4S/ueNT1eiYAhWlpy?=
 =?us-ascii?Q?qhNnFwaLm+Qh/HHis90AqL29xnDYbGVzHn0UHrqLzon5QkXlLxkoXm7RpPML?=
 =?us-ascii?Q?93VuZu8Vg6fLhz58fFuYWWez2VciOyp1q48DsTxyqMbHjmHghssEDYmZ7FAs?=
 =?us-ascii?Q?HSlc0m4spLAS0b2pnnV7Blxqbp21ada3hYm8F9UMFdxjjQNUPOrWsIUHkj0q?=
 =?us-ascii?Q?2Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	vt+KpgoFFZZGuFcaFlE5KOJjpShJfLw27dGbTc6Jzw8DqIcdGajpvKlyor+x0OExoJlm/Vj2Jh6Jrwt7Lnd5pdenDZLPQ6eO3/OXS2u+88OJVXcwWvkF6cw5IUC7Qzk/jQarPvzMyp8rDvjzHkrU18hCAfaFLBXYlwpl+9wwuLBbXxB4LWd+UWgtNcUCEg74OivWs1iXaMLhAEoZpjvRUMbGUesAk/6WVFGpkUvTOVOs4Z1hiZCWY91Umf7DcHriUGXSThbRUoiaDQaLcLK3yjQiVhHHiTPvczyJfUO1Ha6R8Uu7C36duACxHb3CvZCVzZEc43mNWHtKA99VVcDfVjHgqS3AXlUgO8UInoNh4X9uWknpw1q13IjkLS1PjYH6+8AFq/cQwZEIz5VcllXfAOCmzq3mQDk+cMxYRqgtyOqMB0EDjomDqpir9zIDH2GKDirofuM/fmhrjXnpUD7n0Xtiil2yJN0TcZfxJ2ILmSWDU9qzntAxNgSqiuoCSwAHVv1nv5iSiXBhjawxRxCD+rL2twTJujbOQzqaT2cIA9zbAnPQjTbPS65GlGmSc5X5mI/zLBn2wb+deb+NDbynSRIjkxJViA29uoEJEO++CXQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbada35b-d36c-4899-80f6-08ddd446005a
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2025 17:32:07.6823
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F28h5/5OYRZw7uNP211MX6qLC0g20durWcz8IERUVhF0Y/dRINcjK3HVPUKJa1YNvSFK2lyWshUgqGsZfYxlOqNAvBEo7j2hW+L5TK4Znh0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7804
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-05_04,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 suspectscore=0
 adultscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2508050122
X-Proofpoint-ORIG-GUID: GTSYmcoBEXwdUH6j_1vKc9uwjrUOX1q4
X-Authority-Analysis: v=2.4 cv=HY4UTjE8 c=1 sm=1 tr=0 ts=6892401c b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=2OwXVqhp2XgA:10
 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=GqBoVHICbIhs-Fc4uBUA:9 cc=ntf
 awl=host:13596
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA1MDEyMyBTYWx0ZWRfX+8vH8KR92imt
 Xof2sBdVoSSJ3WGGE9U+ZhXlSDB9CtYsPDLGwGAYEov9+0HqrQTFX8nNBFd53zkkOCaM8DaQfv6
 iT8T8TWmrNY6hnaxQk2MFij1LYbHVRJ5qyCx5nXWVtsjEo8F/dqRJwVOkvVXGlRnOX/z5WG4LwD
 2+frzInaEeJdo2M80MGDj8QoSVVHv/GNUcIJHsmiqmNn3NYqkE93K68kEb6UctgFTwBDgeBJDdE
 EF3GjslU9ORveZ/VbxQZSP9riV5nRwZ8c5s7WN3k90+mINlzplttLKUVrLSFwiORmk3PXyvuRr9
 IJ9yxMlaZygSSYcOVFvINVYI6kEINvTxhw++R365rjvYA7xaAeQZRbqWrFemwQM5ZX4ZZnjTuZN
 bq8EBSbS5wWtdZmB280fRzxwb2bgAwGKLTUnWZ1PfhA4BUcdVs/fZMSRKTmSKMIIROqqiyMQ
X-Proofpoint-GUID: GTSYmcoBEXwdUH6j_1vKc9uwjrUOX1q4

Document the new behaviour introduced in Linux 6.17 whereby it is now
possible to move multiple mappings in a single operation, as long as the
operation is purely a move, that is old_size is equal to new_size and
MREMAP_FIXED is specified.

To make things clearer, also describe this 'pure move' operation, before
expanding upon it to describe the newly introduced behaviour.

This change also explains the limitations of of this method and the
possibility of partial failure.

Finally, we pluralise language where it makes sense to so the documentation
does not contradict either this new capability nor the pre-existing edge
case.

Example code is enclosed below demonstrating the behaviour which is now
possible:

int main(void)
{
	unsigned long page_size = sysconf(_SC_PAGESIZE);
	void *ptr = mmap(NULL, 10 * page_size, PROT_READ | PROT_WRITE,
			 MAP_ANON | MAP_PRIVATE, -1, 0);
	void *tgt_ptr = mmap(NULL, 10 * page_size, PROT_NONE,
			     MAP_ANON | MAP_PRIVATE, -1, 0);
	int i;

	if (ptr == MAP_FAILED || tgt_ptr == MAP_FAILED) {
		perror("mmap");
		return EXIT_FAILURE;
	}

	/* Unmap every other page. */
	for (i = 1; i < 10; i += 2)
		munmap(ptr + i * page_size, page_size);

	/* Now move all 5 distinct mappings to tgt_ptr. */
	ptr = mremap(ptr, 10 * page_size, 10 * page_size,
		     MREMAP_MAYMOVE | MREMAP_FIXED, tgt_ptr);
	if (ptr == MAP_FAILED) {
		perror("mremap");
		return EXIT_FAILURE;
	}

	return EXIT_SUCCESS;
}

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 man/man2/mremap.2 | 84 ++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 73 insertions(+), 11 deletions(-)

diff --git a/man/man2/mremap.2 b/man/man2/mremap.2
index 2168ca728..6ba51310c 100644
--- a/man/man2/mremap.2
+++ b/man/man2/mremap.2
@@ -25,18 +25,47 @@ moving it at the same time (controlled by the
 argument and
 the available virtual address space).
 .P
+Mappings can also simply be moved
+(without any resizing)
+by specifying equal
+.I old_size
+and
+.I new_size
+and using the
+.B MREMAP_FIXED
+flag
+(see below).
+Since Linux 6.17,
+while
+.I old_address
+must reside within a mapping,
+.I old_size
+may span multiple mappings
+which do not have to be
+adjacent to one another when
+performing a move like this.
+The
+.B MREMAP_DONTUNMAP
+flag may be specified.
+.P
+If the operation is not
+simply moving mappings,
+then
+.I old_size
+must span only a single mapping.
+.P
 .I old_address
-is the old address of the virtual memory block that you
-want to expand (or shrink).
+is the old address of the first virtual memory block that you
+want to expand, shrink, and/or move.
 Note that
 .I old_address
 has to be page aligned.
 .I old_size
-is the old size of the
-virtual memory block.
+is the size of the range containing
+virtual memory blocks to be manipulated.
 .I new_size
 is the requested size of the
-virtual memory block after the resize.
+virtual memory blocks after the resize.
 An optional fifth argument,
 .IR new_address ,
 may be provided; see the description of
@@ -105,13 +134,43 @@ If
 is specified, then
 .B MREMAP_MAYMOVE
 must also be specified.
+.IP
+Since Linux 6.17,
+if
+.I old_size
+is equal to
+.I new_size
+and
+.B MREMAP_FIXED
+is specified, then
+.I old_size
+may span beyond the mapping in which
+.I old_address
+resides.
+In this case,
+gaps between mappings in the original range
+are maintained in the new range.
+The whole operation is performed atomically
+unless an error arises,
+in which case the operation may be partially
+completed,
+that is,
+some mappings may be moved and others not.
+.IP
+
+Moving multiple mappings is not permitted if
+any of those mappings have either
+been registered with
+.BR userfaultfd (2) ,
+or map drivers that
+specify their own custom address mapping logic.
 .TP
 .BR MREMAP_DONTUNMAP " (since Linux 5.7)"
 .\" commit e346b3813067d4b17383f975f197a9aa28a3b077
 This flag, which must be used in conjunction with
 .BR MREMAP_MAYMOVE ,
-remaps a mapping to a new address but does not unmap the mapping at
-.IR old_address .
+remaps mappings to a new address but does not unmap them
+from their original address.
 .IP
 The
 .B MREMAP_DONTUNMAP
@@ -149,13 +208,13 @@ mapped.
 See NOTES for some possible applications of
 .BR MREMAP_DONTUNMAP .
 .P
-If the memory segment specified by
+If the memory segments specified by
 .I old_address
 and
 .I old_size
-is locked (using
+are locked (using
 .BR mlock (2)
-or similar), then this lock is maintained when the segment is
+or similar), then this lock is maintained when the segments are
 resized and/or relocated.
 As a consequence, the amount of memory locked by the process may change.
 .SH RETURN VALUE
@@ -188,7 +247,10 @@ virtual memory address for this process.
 You can also get
 .B EFAULT
 even if there exist mappings that cover the
-whole address space requested, but those mappings are of different types.
+whole address space requested, but those mappings are of different types,
+and the
+.BR mremap ()
+operation being performed does not support this.
 .TP
 .B EINVAL
 An invalid argument was given.
-- 
2.50.1



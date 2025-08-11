Return-Path: <linux-api+bounces-4438-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21217B20CDA
	for <lists+linux-api@lfdr.de>; Mon, 11 Aug 2025 17:02:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 965A0189DE64
	for <lists+linux-api@lfdr.de>; Mon, 11 Aug 2025 15:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C99A2DEA65;
	Mon, 11 Aug 2025 15:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OACx+nF2";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="TEzBq2Kl"
X-Original-To: linux-api@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E2715853B;
	Mon, 11 Aug 2025 15:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754924463; cv=fail; b=MO+jy+Um53iKFyoiol30WmEf5EFZw9nj3PM5TB8xjmR2E/11+RyKm8IXLAYmtURLwC+sbAkJZJExiM/Rfcq6uRHQ8ZyOTrQ/Rix1arm7DJx2wRJqVnSRko8Al6xWnVBT9dqRaRAQkIbFDNwljJj5t5+sHkX761SZz/vFSLuwIbQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754924463; c=relaxed/simple;
	bh=vMtoNbQJqPxPkb3AhZnM64TVJSL733QGMO5zP8oLZaE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bK8FnKuTNtoTEEm5+wYFImPFGZ3q5BfPBssK0CM0n5U0Ur8uQTG1tS5fTymGvN6jakcAGVXL8qG0RNsRAD4JWK80LRgT1+ppro1NlTsIB74R9Q9PR+UyNys5v/UxrIpva/mYvm1aSHKwGDfTiePiEYAaelQznIGtJn/R8zPrH4g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=OACx+nF2; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=TEzBq2Kl; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57BEu8IL001270;
	Mon, 11 Aug 2025 14:59:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=VnQbxv81bQToP1ewEcYK+YrQcOwx3fjEquaaYdn0KZA=; b=
	OACx+nF26hs4evxF7rbMecpFDcoj78lQJEf4lL0pNIXYl9Wt1VOR2OCdK8S+CDhl
	Lu/Y1JeuXK/vfu36JM34zix+ythL0Op8OXqVuj+x21/rBa2YEflsoyXYQMLswDQX
	EGNoo2kr97pVq8QjqjmT4IG2mEdPBZJGCkHwsDpG3ec5veiCWfYmVRZhlveFCP7Z
	9uWfovw6xvp6ihGzvlv+wRxMJi+RlKY7a3aVl+kSio8pn/Er8BqMi3GBivJht6Tw
	ueH/UPy/5NqF2qy2MucLYp5EN59bPz0M7zZs2bE+f1EKBP0OS7ABU1yuNSzIyhAE
	8V4BE0ekYweWxjSFv40A9A==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48dw44ttp3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Aug 2025 14:59:56 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57BEptU1030192;
	Mon, 11 Aug 2025 14:59:55 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12on2069.outbound.protection.outlook.com [40.107.243.69])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48dvs8rh8p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Aug 2025 14:59:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KXvNDtcuY9Ph0HPMBseT/doDL3G0CVttGMYyS6v4meufj1awiTMrrYfWi/wL8Lw5vnf6VJxGwi9/baJ/2l/2YafPLaLZfxdJAMIOjd2efbw9R7qN24beeWhz5TDJ3w3ZoTS6gnpyOc1hhjTOMmV2VqdxuAhh3hm+8SPehqOWlgT5ZBm2X1vrVV+Vy05v+36e2vngjL2gAG3dQCMuFrIXv0tJ9LUipG8iIPLkAT1mybBJhj6ngc+ymvvOY/hgQZrUkzvfqPWF9bytxG5ObUaRyUgbpFAlyj62h3KGDlxU3MBl3WThBEiEp6hvUD8xk0GOfKW8E+2OR6xnhTCjs4eT9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VnQbxv81bQToP1ewEcYK+YrQcOwx3fjEquaaYdn0KZA=;
 b=lit9GMwD0AiU25q6BXIeYt6Ske44dBjU+ubT4kv/FAKeeLx/tfaB2k174opTNzPq37+5e82N7BFae9Um7/7dyixMER8uEc6DJhLhTCvPXJNhJ/8YpV+HBuKKsUWQmceI6GJRQGjjQm+C2wDyYybUA7I3f+O3nVflhRqKEyPxxilSN/i5jaUdrovCRhcEhBJYFN8hP+7M7j/Nt7tM/OFH0vh93yD8x+VRRAUi/JwowLGDIZ9iSmOI/TTIjtYqJoSG/+laU53ZK7nrLgHeLsbQEghUwGBqeW4tMOTEN8ChGxfPiC0PecC1KB/dD+ASJo2kEZydH331Iolw3YwlfDv7sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VnQbxv81bQToP1ewEcYK+YrQcOwx3fjEquaaYdn0KZA=;
 b=TEzBq2Kl+OnAODMSJ4srh4frwR+BmKhuhMhBHLP+4fcdIT381GB3yuu6Txxu9HWOrSvWLM+0cLCAofVx83Lakznn3k/F9aYcoo3AU8UAtHn91WWwVp0v3kEoOMK0dsyCvwLR6L41x7XBMANF5AlQRhAFsVPIhnoFvRbGoy9UO/Y=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SA1PR10MB7553.namprd10.prod.outlook.com (2603:10b6:806:376::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Mon, 11 Aug
 2025 14:59:51 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9009.018; Mon, 11 Aug 2025
 14:59:51 +0000
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
Subject: [PATCH v5 2/3] man/man2/mremap.2: describe multiple mapping move
Date: Mon, 11 Aug 2025 15:59:38 +0100
Message-ID: <4e0c992a6374e417367475e3b3bbbc9d43380f4c.1754924278.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1754924278.git.lorenzo.stoakes@oracle.com>
References: <cover.1754924278.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0072.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:8::30) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SA1PR10MB7553:EE_
X-MS-Office365-Filtering-Correlation-Id: 1fdb0aae-bdf8-4961-d11e-08ddd8e7b94c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mVCVRx5el+CrLbKbBNjrnxnJH2C2JTHfFPezXhrH8+b7CVxhHQyjKJcvLyCG?=
 =?us-ascii?Q?e2FaqOZbMxEU0lHMdMoJ9r7nWAcQS0Hjs88E77uBtmkgzG64+xLzdwgTFLjm?=
 =?us-ascii?Q?dR4gk0DSng30wZL7GENrK9DirLwtxSvoszyeqSFX6jy9Wuj9k7fEWdaJF/0J?=
 =?us-ascii?Q?SS0w8zL2fvIckLyLr9OsCkzsK3KjUsnU+1Z91yKljVFvoBwzxkYh8A5xRv3C?=
 =?us-ascii?Q?dxlS8RK8VlTai6E/aqoX86LvJwzz8SDbkx6J8DoSPEPL7p1mQUDFJg+7vkjs?=
 =?us-ascii?Q?4WEWsL++nq3vr4dCMkzXiSDVvTZy+Fuq6pibZOveK5Hlw8THwj77+FMF7mTS?=
 =?us-ascii?Q?QTAFQGY1l+0sL7mAvLv0S/yqFcnY7RuIhRdEv2QpP+NtjPc2AmljG/ASpaU/?=
 =?us-ascii?Q?Wt8G0tSU5xMx4JDgWLkTR4i7bU/sds3CnjzdweGS68Pfbb+gTcHmtETOFSbX?=
 =?us-ascii?Q?SkM7yeZR8NAQ3nzg43HRjUzyK7UxP0j+sieaEzPMIsMIFdB+HpJrb1tmyT/c?=
 =?us-ascii?Q?h3gIYDdXhNLSRIPh1RZ01gyOHnQGOLQDIhAbsg/LgsS0Vzpo/krkEI9RFC3b?=
 =?us-ascii?Q?HFr/PKdO3KUxxhW9+iNQG1+bOCcPUGbGtvoQZCcZ6cPMyVXGjGgEWLCHBITd?=
 =?us-ascii?Q?ATcNIpfSHnnMFQ0/xJyWF2apWtoJMCf7ZuBQWn63Fo7IAwsygcySc+DnXiPl?=
 =?us-ascii?Q?JAP/AUGl/a7fQgvg7k3To3Ra1AFg8Zs4FDQn5durt5vE3OgoYfXjjoSHjlJl?=
 =?us-ascii?Q?PYdH1hWet46Jm2bvxIc6EzQUVnxM2V/qqdZJt2LbT6Zdj8qfMDAUe6pQcYUe?=
 =?us-ascii?Q?8JAgZT5Ov+03Usc5GlMmRqt2VCYrqDE7+X52JFVa0FyEKKO5Q2MGbHGdSzzu?=
 =?us-ascii?Q?2QMsZsXgIf417haRMJ8XwupbTR6tyHkp9+lqrUktEaRpTLKxbyrncJQwncdm?=
 =?us-ascii?Q?zI2olqys3w9fyhtBLzjZtbFj43wX3MCvwv5YHeQXy6UBbZAGyYhmja+L5eW1?=
 =?us-ascii?Q?Zd/9a1NJTiWbROdVgG5XDS+tjKxD1YbPX2cNhHEkXPCPgm/384TGyqZ7t9Gx?=
 =?us-ascii?Q?9LaONUlgJgXAeYKmYEI+EaG7Jcr/hBRJvc7DtzLePSJlQxylnbnLKxAn8eX/?=
 =?us-ascii?Q?A8KwmMZFzPO43WVchEVE7rYvae7WDT7HZT8bbHkGmBUx23L4+jRGONae77Vg?=
 =?us-ascii?Q?v5Sb4xYYXsL7PclougbbX3IDE3Yi+pCEBE564JkkuIczMNA6iMT5a2tvCEAd?=
 =?us-ascii?Q?4aHniqT2PYitNrOD6ezCKKHvRbE22LMJSqXJFYq5lt4eGARsQXGcmdu/K17M?=
 =?us-ascii?Q?/BdainakKn+CYBeGA8vN8vEaq4hrBbDTsK2E3v0T1VEZcZ4dXKW9VEW5QUgW?=
 =?us-ascii?Q?OHBhWPQIyV8jN86Pwgc9IHQVloNL6QIhLBmVKQ2YNWk/F/6jgpI4Li4PTTVc?=
 =?us-ascii?Q?MD/Uf3CyDXA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lf6XALefZkg5K+B+WDITBeTQ1MQ83VZ9gPoZUnjj+Qso+9GwcnieY7CB7laD?=
 =?us-ascii?Q?Q6I7Dtt4qy77jXvRfzV8D/ALK4WzdrcAXMzGMF7KZJriLHGj92Qces/0JKgT?=
 =?us-ascii?Q?vYT1kVuzxw5KE+jjAXdSYLvJqFHbeO4oCGxamhRUmWpeauLy++H1dlwPyw40?=
 =?us-ascii?Q?kzBOeFax8ZmF2J8mvyVLk75oz582R2XreP+eRUm60hY7DUCuUQgJyxpJqVT1?=
 =?us-ascii?Q?fKeNP/zwo/Bf1EQOf6sBmjoC4NxWafiQBGcsPS78LwEew+ZbwVgHraBq71yH?=
 =?us-ascii?Q?AKzCeUsaggyeWfjaWPJGOBP5GWCgUWSvdTJI8r72b1QIROg0lzKL/4V0I69h?=
 =?us-ascii?Q?z8NJeDLMNwAU5YggqdPEgKIkj9G6FtZNsa40dMjUpZwg/azXsV4dTKJmSO9q?=
 =?us-ascii?Q?6JZlnK8wQT9KaFi2e4X+t0hJ3GQiAeaB07BITzZogkGFiSWSsJXeGH7Ouzze?=
 =?us-ascii?Q?petwbwMQSNqZWJyISPY8IDzXOkA7u41vRbHYQl02Z+RgNPbnvLEd1MY3jWgC?=
 =?us-ascii?Q?pgYuIZRIl2zmIJoOpJBmpB1Witixb8F5g8tC4qaq0tFbVOYwakkNVHZI5CWy?=
 =?us-ascii?Q?75UeZ36K9zzzmPg2/fpG8vy9ZvQBt9ukPtewRQ1Byd76rpvjyrErrWl/H9HL?=
 =?us-ascii?Q?sOoeHI8jstllzlcYnAaxM+0Kd5mZ0uEU/j5nMJgcXqInWIM+Li8dlOIJX0F5?=
 =?us-ascii?Q?8l3kAQlMhli9XPWEYU2HW8mTXbKPk0z9nSkwJyLqUVbShl1pt6UQ6ODsPWkM?=
 =?us-ascii?Q?WmsSUYGKFX4oiYm41k/VVl05H9ouJxv80IRr6ew/rkZuA2eTx8WEeF1XkgsX?=
 =?us-ascii?Q?YSgWW36U6LDRivbR5+gB70SvYnP5TY+Hos3CCVgAazDdJFPsN64HIraitTIN?=
 =?us-ascii?Q?WjE4PsBZVgasmE5YwxR7rCuZ3zCGZkWAEllw+bs5QQvavhDLHEUTKywzilDQ?=
 =?us-ascii?Q?rd3D+qq28j1a6cHX5BvbHdsiv0SeQ3UyhqoLADZ8oN05j+r+2sy2OUEkNIBW?=
 =?us-ascii?Q?KbZplwkO7W6hVYUMCAOLfgGkjQLoWAaNEVsTLiC+x0X+62xCGG5D5GIdxKCV?=
 =?us-ascii?Q?WE5C+rt0C8l7UKh8EZfMlN1DFPs7piJHR5F6WkJYawx774Ss4MZtIUg/IKM3?=
 =?us-ascii?Q?ci9gK+EsgFZ/Bcw8/O/OFE2NCWsSzTuGBh7kl4J3St1b4B2KlEccNxWUbCt8?=
 =?us-ascii?Q?OQA7JwewPGHbRm2/Xo2esVUlMrKhVO23f9ogTVckpmBJLbCnqDLTiv3Kww2z?=
 =?us-ascii?Q?KI7j68lxdg58Q50fLI0uEwc7IWlsZMvbqTXc6goRiFN1S+9kQ9OoKZ35lynH?=
 =?us-ascii?Q?4B9+Mz5vdm3USWnpS0IxTmHwaaO/9S/UHQE+qAbdSAHtjSvnU09OLd1hB0RP?=
 =?us-ascii?Q?vbf4mXEfxBVHyqpxIOTgsxKFR1sJP5lNIdAT3qOkPhy45auAlW4iF6HGJuwz?=
 =?us-ascii?Q?T+xstSxiqG19I4JV+KBgnxlkz2kkt0cEx4WViBCpxwEVgJS9wNsrdpUbeLT8?=
 =?us-ascii?Q?ICP42K+n5ghrBv+lb0A9iJBmFqj6TISpuRv1gBwDvZjWF8L+WObti6S1hz3S?=
 =?us-ascii?Q?2498GG7VpuA1JDBUxTDIfIpwFbEwcruvGA+E1R3vZ05tleE50mIlgpElO2UW?=
 =?us-ascii?Q?QA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	yon9Eh/oJnMzUpiLiJFiq4KouQZUcoWVYvRb8Akxze/IDrtlrz8lvmkGDCyhZRDCBtih3wbXtzwKy07eAVQzqe6nXfpsSYI/k4lDwFJau74kRx/8tcSIzEjJktoOZfMnMhVPmCBS6mOBnKdRpB0ietfFNaD1twJm9HbW4TpQiGJooJRSRIrvqFIaxNr4kMvbos6Zq7wonBFUgpj0GLb5QJWlLK9tD8D9BIPA7GCMIFDPNigiwZVFNjdDYVpENniCXl77yzRUQbfhgAZd7MSr2Lqstr3HtIce47nIVdIGSTWetaGS9D7XVx4OAP48qOgiz2VpDYL1lqtYdWPzmeTyfW8Jk6i/p+6wFb10fRHG9QITBlUKoF2OmfA5Orm/ajxBlq0cACGuv70SwIIbhRgEGZe2PkiwoXLQdC9hpo+fq6Da9Trp70yJ3hgOEAXWhSi55sld2EBB9bZlVsZIJC6A9t367eAYjAZFEaBUnE1g7RwPzyX3MH2Qqll58WOnJA6F50e7Di6kZjn9Z+jqBUJms4txjdjq67pDvyo8usKJthY0K99WhwyNaZyLcBgImL8JIthkboFImcJGLUZUMKdFy3Tv91EderWwmQJm++l7y/M=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fdb0aae-bdf8-4961-d11e-08ddd8e7b94c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 14:59:51.5928
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EumhU7/8LoRbd1kl1PcZDs0c18yOiTFQa74g0iqZVMV5vwka05DnuNj67DG2z6OmBLbA1ZcDxowc/Uib+2abzOETlvAIPX5qk+YbelqvfAM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7553
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-11_03,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 adultscore=0 mlxscore=0 bulkscore=0 spamscore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2507300000 definitions=main-2508110096
X-Proofpoint-ORIG-GUID: MjyqA16ukg5wgZ3HU3k-AWbQxXLl0gjN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODExMDA5NSBTYWx0ZWRfX7abGZsy8n4wj
 IyJelkrB6ubAXQv5qKqBqmnqJjMCxQB8PCP+KJ1hA1fF544Le2FlLdFtMDZHYYYF73SqxIc9kG1
 4ywEiYWuwBmQi3S2PPqAyI09DHtcZQixEHPIBoPlie58xsYBJDOhaS2ZXQXPS1WjRqceXMDNr8k
 2lMBGOQ05ZBZgDFFbqKAgw5DvRF3Igkh6wLv+/wFlc7/isvrT8VHwv22MKG7zuv0rfjZU0vuFau
 Tpv758CzjmaxA0ADK+yz//B25SU6boASia6wxxGzufwXGpfoiqkv8utTUuIjs8XoDaoJL/8vNqi
 EKum2LQPONEjAX6CRJDAYJWGK+QBxZX+aQrifpF3/Qbf/TwE5NB1H52k8vVyJA73/r+HobCfSrL
 xdRmDrd7U22fWkbEXEP0WlJN652WHpCO66qi3QMiuEa13z9QezlM8ocCbzoTqkjZJ+oaC1oV
X-Authority-Analysis: v=2.4 cv=X9FSKHTe c=1 sm=1 tr=0 ts=689a056c cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=2OwXVqhp2XgA:10
 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=w0sU8pBHjJpXSIfg0X0A:9
X-Proofpoint-GUID: MjyqA16ukg5wgZ3HU3k-AWbQxXLl0gjN

Document the new behaviour introduced in Linux 6.17 whereby it is now
possible to move multiple mappings in a single operation, as long as the
operation is purely a move, that is old_size is equal to new_size and
MREMAP_FIXED is specified.

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
 man/man2/mremap.2 | 68 +++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 57 insertions(+), 11 deletions(-)

diff --git a/man/man2/mremap.2 b/man/man2/mremap.2
index 4e3c8e54e..6d14bf627 100644
--- a/man/man2/mremap.2
+++ b/man/man2/mremap.2
@@ -35,22 +35,36 @@ and using the
 .B MREMAP_FIXED
 flag
 (see below).
+Since Linux 6.17,
+while
+.I old_address
+must be mapped,
+.I old_size
+may span multiple mappings
+including unmapped areas between
+them when performing a move like this.
 The
 .B MREMAP_DONTUNMAP
 flag may also be specified.
 .P
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
@@ -119,13 +133,42 @@ If
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
@@ -163,13 +206,13 @@ mapped.
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
@@ -202,7 +245,10 @@ virtual memory address for this process.
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



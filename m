Return-Path: <linux-api+bounces-4430-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51BCCB1FE92
	for <lists+linux-api@lfdr.de>; Mon, 11 Aug 2025 07:31:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CB9B3A587A
	for <lists+linux-api@lfdr.de>; Mon, 11 Aug 2025 05:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35112257452;
	Mon, 11 Aug 2025 05:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="qWcH/8DL";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ZcO1QgYI"
X-Original-To: linux-api@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 492A1198E91;
	Mon, 11 Aug 2025 05:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754890284; cv=fail; b=Om9mCuWk5yR4jdGsTCOK/uZnoUmyYS5KNWBLYM3+nUrYsME0GQFewOHmE4B68rsOB7pcFOpgkHnHWZEsmm7oyznHSkS5uo5/D6undZfGGJYyE8XadIW5P33ZwAIkOwt3u222o3Su4SU/S8abrs4hABBpHEiNIRZeTVnJglsdffs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754890284; c=relaxed/simple;
	bh=9bXyF1pb12YkaUOtej7xx+KUQ0nXAIUtPaX52hdMybk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YWQymXkWlGCBRSSZinG3JI4YKyIiJPgDXI2eRgGjLbLB31kuisCZZ5/znuUqNc78hGz4kJ0CNrelJSat/vmDx4xDZyVEQjKAeUyhBcvrvfdeEhsCqI2auT0WQsmIvwFq6X9Fo7sNrPya1LuzqeWk+yukcyJTHgIlFbVDOiIko28=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=qWcH/8DL; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ZcO1QgYI; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57B3NCML009862;
	Mon, 11 Aug 2025 05:30:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=2J+LOhKd6hdEnR2Km3
	5ecQts4YVG00BWaH5uSHLI0Mk=; b=qWcH/8DLbiVSzvu/7IkTSYAyAOt4cCChJ8
	yQrj5MYU3GufVj+m0AYFG6+aFcRB7XkDvg/b4WC9Ql6UQ5TDV/ezFzvQB9FtZ8tW
	lR18GmIq2zn8o+Mo5zXL8eXTWbwC3Ksan90qtre0tMZHuNRXZ0kwlpVYCO1dZDB5
	wQAQJKpsPIQPJgZf+MTRB3aCiDj5MPh2mQq/MU3bOHsKedPmT8IJECAAKWavn8hu
	NlVpqVy9zn+fOrTpCN5Iv6RAdBxzeuDELu5VEUJ4CGgaH+dMA6SoQqRUBxRxlKby
	FJYEbbo/MjMQddYvTqh1FdQoRoScpzyQcXXbn+ItAc+1VEoVvw1A==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48dvx49rrw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Aug 2025 05:30:45 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57B51ggD030194;
	Mon, 11 Aug 2025 05:30:44 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11on2043.outbound.protection.outlook.com [40.107.223.43])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48dvs86rxr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Aug 2025 05:30:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l5JSQqqJOqxeL8uohtUSI7DIpshOpFJLvwPy2471tGXsBUhI4MwAoHvs53k/tsvJ+x/imCfi0HIfE+T2wNqJJICAPcHW+2avvyDsRWKH3XGESrSrOcaZ0c160FCmetdsstQ1td0Q20mwTU+jzJH3d6V45KKQD+J+KKYSB+6Mxhv/m76K9ZshpTkwn8exoHDI5ESMf5PaLMhcbBaJ2TlmQe319Ge+8LwV4WNJeyPw88MuACgUzqEfRZSWW6cmpA1GHe+McYHvbreiwJC+LQxzCwngvwlXUqGxqGoJE/uG8kvwaA4VCQMqXGOxa6N5orhF2RGQju0gibN1Pti+ygfRIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2J+LOhKd6hdEnR2Km35ecQts4YVG00BWaH5uSHLI0Mk=;
 b=pMWZfOQb9yx+lrYkET/+0mexXrxyrow1r8knx7P5DMK1Hx6HD/wyCPxV8/zuG5YrJO87ExZiiPEe7JkxWlYVDYrEhb0bT2XZlsyCjXLwWhxVHedTJ0YLtCHUteNVMY40PXG5IvRZNVkDL4K8NEWVH3zsIurRvL476yVnHPcSerb9qK8a4xi+LghH/lZ5uhWlQoWzypOQdOR+mF2xMDLVSNSX9z+w36iN8DVHA0UTeMCzj/jJDC+8rdeIRn7bepr0glLccqzPsYUV9Pha6IlYt55Dy+RjTOJN/pcb3t7jN4jNWBHnNrpzEoIJqy1WvEnsrnPPqjpfeCldRm+A7PTaDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2J+LOhKd6hdEnR2Km35ecQts4YVG00BWaH5uSHLI0Mk=;
 b=ZcO1QgYINHOTK8FSCIIhQfoAOsFy1L86LiuAaWxOyosNd3/4t732Hbkt+UHcCV9TinXnkENZoD0FeIEIGJ8ip+/9E4VyYrpt2v3U9hX52J85y9BhD2llDlaf8eiFN4M6hz9m32iRmk1ufhEV1+vM1Pa9ahj0+cLIHWtx+tF7nHk=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DM4PR10MB6744.namprd10.prod.outlook.com (2603:10b6:8:10c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Mon, 11 Aug
 2025 05:30:41 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9009.018; Mon, 11 Aug 2025
 05:30:41 +0000
Date: Mon, 11 Aug 2025 06:30:38 +0100
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
Subject: Re: [PATCH v4 1/2] man/man2/mremap.2: describe multiple mapping move
Message-ID: <664b00e3-69a0-498a-a7dd-a3d294c0c188@lucifer.local>
References: <cover.1754414738.git.lorenzo.stoakes@oracle.com>
 <53e4284ffe80a63260c957369ccacea8f5c16adc.1754414738.git.lorenzo.stoakes@oracle.com>
 <ekjakm6zburrawhk34smm3fd43zufzguisfean4hmv7vyjp7fq@uvy6n47qbydl>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ekjakm6zburrawhk34smm3fd43zufzguisfean4hmv7vyjp7fq@uvy6n47qbydl>
X-ClientProxiedBy: MM0P280CA0016.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:a::29) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DM4PR10MB6744:EE_
X-MS-Office365-Filtering-Correlation-Id: 556594eb-5b3b-4e03-2637-08ddd8983632
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iAv6QJ0jxPScOBOnz5f6/LFkMam8olz3XPqnD3JtYdv7XQ0bqL1Vw9lvZNpb?=
 =?us-ascii?Q?2QVIOgbcv7aCehiahHVnrThu0lLA/fSKnmgu/zwMQo+FhnfdufWMzbO1YRFt?=
 =?us-ascii?Q?XqMEy2OKBi27PPbuw++ARriqCyqn7MuEoR4i6Mbg1ENzd1f5hhdgAe0FY9dk?=
 =?us-ascii?Q?4xV7F3EBD4r5nwM7Pwxmc7AS1IaVCic+FbCbfT+6ksomYfQg+p+gRCO7DdE6?=
 =?us-ascii?Q?UmoYu2G7WF+dNwTEhncSg3kmlgLJ26jDXwboBe3qq/n4p+sOtaWFjElW5brt?=
 =?us-ascii?Q?T+FzySQZpQVqqzLBjWdpbnKfqQzVEnvI0lVUV/8c9mdfPOeSkq/OOcA3SPBw?=
 =?us-ascii?Q?ItuVTJ522SVhLyvHMMUu3x/LrdwOmmirqCX9DVUttqWpEUH7Bg/Ir/N/MzD1?=
 =?us-ascii?Q?EYy7+j93bavrJL0S4gRqtwIhLBV5V/MPaNubvQ33Ob3TjvXyAH+JfPA5z7Fl?=
 =?us-ascii?Q?um1ZUi0GgDzR2YnIDGxqrXY2nU7fbRXwAQHBXtT8H4TnNHDcL0/AdNcO+iC1?=
 =?us-ascii?Q?dGLwhi69UVV1lBmRPZuMMTQU3s3sjDrw4LNOVQ1qRx20HNKBiZIJbss/OGuZ?=
 =?us-ascii?Q?Z1jbXXMBAdrn1vjeZzIayWRbHLjaCN3QEKg42ov9eSGa9bTzQQYVVPyinOfd?=
 =?us-ascii?Q?LTdFP2jrNrCAVjSsouylbP+3lQ5Bpvqg1j+BJ55C/OitUvJMrpowc4OAipbx?=
 =?us-ascii?Q?aXl/dfqCLedzPPPoPPhxTqdwGZDuDBSSP9qb8fviH7kE0NUtnNx30QyYhuHr?=
 =?us-ascii?Q?pD2hpsEa3mMRIf/YyXD7chhFEDbrNUGHUiA2SPsveWmXCOIaD+zawmdGxVhZ?=
 =?us-ascii?Q?hFR2firieKIwGQJ6elFmk6CA1ushEKioGDEwIrnEcBpt6D4PqwDD+hZYGFfp?=
 =?us-ascii?Q?QsgRcG/E43Q8TJWoLVrUwXPKCtkA8fbXWNiVyIDZ/mJixnpvN3vwd2IM7jWc?=
 =?us-ascii?Q?sZRIkqa+eyYdYCyT2epSPhPwg64K6PFdsEl3lZjdcO4yybXB4AbIl5zcIYly?=
 =?us-ascii?Q?rsNtlZOq8eTWcV4hx3tdN2FNKyjJeqGnvmVjsFlOWKsMxTogaFiTqlZq8A4y?=
 =?us-ascii?Q?0InUkfAcZun0soqs8bFaBdiUuODPmSARnohCEGs7lw9OaXqdTKE4mS12jmWY?=
 =?us-ascii?Q?kM0xkgwiT3wLyDkv8sN5e+iZs9TX6mJYdx9cYy8FXDRYeY7UErPc1s5dseWg?=
 =?us-ascii?Q?dvc8GY0p50m7UaNEsMQkjFTT1t26zrEU59CsANmrthOBAoeC677WQamn1VYG?=
 =?us-ascii?Q?cxXcGIqmA37LesLBQFVESpy6LvyoeotzRlGTdFn/QJbD9/FfoTHO+A4wfhrZ?=
 =?us-ascii?Q?mRz1/beJ8zLYNafCssOauPj0QwsJYP7i+TFW39IKo/iMv2UcFLIl7ZMpMjp+?=
 =?us-ascii?Q?lyRkkiw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BYtuzKbbkB8hb4wi3XQNJjgtRH5eyxKiPMVo6pxD7gKDN63tbL29yDeWsKBO?=
 =?us-ascii?Q?tM+Kzr0H1+9qfochapl/bbO4wIsxbhUkLm1bBzsJR7GdtUdflWjI4Ue3kXWA?=
 =?us-ascii?Q?Kyz25qSpO8Di10VvcMkZ9lnm33Zu4qkrAVoW68gihai5OYTKI7njZwC0z0b7?=
 =?us-ascii?Q?pKdc5mG+hTubjNYrJVo2adY59/xQhQ6UlwwQ9uNlC6P1PuhcqfwrWRUJcZsX?=
 =?us-ascii?Q?E1JmBghQUMj6jxd/12NIq1GazH/xK9PMDytU6+BASGWbAw86fwVM4Z1Mth/J?=
 =?us-ascii?Q?7OKI22dngVjmc/UgNR+scdbX/F9RoTvex0ETb52f5edNpu8YnMYczPric1iY?=
 =?us-ascii?Q?92c9UVgExRF/E8/sOQKvJ8u4JfERD2rHJdnSfBekSfajJSeTLOJdqAzDZAti?=
 =?us-ascii?Q?WWH+blKQhz09bYerp9Z/zManALr2SIZAyGDMmLvmRNjfR/CTZUTi03VM/dLa?=
 =?us-ascii?Q?OPjiXiPCMsAwzN2tuz2ObqZaFZfuT9t114jGe9crvkXTyYyq6vAADSoVrCny?=
 =?us-ascii?Q?lmXUrP/zyB1byK2if3Ln3vMrHVgKWV3tmcIO4coL5boUkOqxiyYVvv+PqzKa?=
 =?us-ascii?Q?kBEjQ09FsmjTCZV5q6TpRaGML464tcCO4LZ66ce7VhaLfH+DjgSAQjvKfYOV?=
 =?us-ascii?Q?F0D/OjQmTHf9D2zP5354Gd4iNYajcWIr5fY4x9BvqHaeM/8ZTXLY5pLeoMu2?=
 =?us-ascii?Q?EroJtNSP8iFxVMn8gXRP2Gpozk7C6OyS9UUNQFxZbjzdtU/zhJ1M9rOcDWLs?=
 =?us-ascii?Q?RT2XJLwimJ8LdLPe4buRkNja+CPo+aCTJ1N5Xv6DfbQPXowlMPBXMYSDh3Wn?=
 =?us-ascii?Q?YIUrfrzf6ZHcNrdaRbAk+1spncNa3uRR6WErOcOZuzfEwCWulBECtYnnLgv6?=
 =?us-ascii?Q?EYgwpW7lhlMh4P6s4N3Q+AujBbuhO+FZp7eUzw5clOtomqtzl1ex7RQnVHZp?=
 =?us-ascii?Q?3PNf9QrLXh2A7A25N//2ctYswdXKdTxSD/5/lo7LwlYJ2Xc49mKjqYtSoPQv?=
 =?us-ascii?Q?25NKiEg4K9A8vwkpy+VQhjey4wuhBpb2dX0rF/0cODQr/2wXu4pePgdvOpWU?=
 =?us-ascii?Q?4wSjF+LmJuRzxLnhohU2YtmVqiWfdu3mx2br6zLlBgUXXT+C4maTHYqVXXnp?=
 =?us-ascii?Q?nOzQ4MvyQXnVJOU7Pu6zuiTIQr1gpGIYI6IOCs1njoDkuUxnyL3ArNmMdnKe?=
 =?us-ascii?Q?YCsbJT136cS3QEIAaAPkYIXv5x/h1YwTaS3G51aKcgAk684+A7iLDMYQikQj?=
 =?us-ascii?Q?Nu7uqfs+Qs4y5/JyiBa9bCYHN/kWxYjuLU/aNxS8bYN3sc/8PwvSnKGA72aM?=
 =?us-ascii?Q?gh4HiMyju8aJbjpxgoxcnvSp2QD6TleliJInYrCmSE5osIP8YZwSEOfJ0+M3?=
 =?us-ascii?Q?RHmj6TukTvp6dEZDLo4HR29pplklQrrKHdS7KquYpvnCRXE7QMCviy/OllqV?=
 =?us-ascii?Q?pzLEgSJXZyE23L64EzkzU9+e5PStQIQ3p2X4E/mcFyX2XNMcBqFAjKbYNyo5?=
 =?us-ascii?Q?j07xJFBUYMCYzmppmmcfjMZKT4xdVbQEQKYYAm/iJywz+6leqczsvuD2y9Kg?=
 =?us-ascii?Q?HAmbf1iYJVSCIr2/wk63M409znMVWA7V8uIChYxDhol4xXc202uH4uAaHyIR?=
 =?us-ascii?Q?4w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	9Id6XFCs5S+SXLITgf5hloJiIQB4+OONXro/fMNLeB2qKtFaJZF8G33nx1Qkq5vvlw/bMsIaLy6+G9x09eFfQciZGJZN0SCtPCJrjucfxcDnPcZKzZ4mEKHOJ4Bb/x9xV3k7PYivwb/MfXiOOolorBjlgVkolui4iIV49u/VMfbzo3L+r6X1K+WotDnWtuz4MXSrSRn6+YF8rOku3JmsQ0eWjLSH10Rcs09AFHaMmEja3PamgSVtNv99CpIyvJBw8hw/y8pkBOniDTxIvV7CMaDioFx+2Kku9cHBn5rmGfQTEwB61Ulk5SYfw8mzCokWkUCSNaz3nXFg/FNE6Uc65IbkwhNRMx9tW/zd386RpxroW4LQcjO0DiAElSmLrkREm+DLCv7Eqng+x1N+KHFmMOFLnFsAbyzO4pbWCQoU27o7ngwQp4+C54FXsC0ozXXQjdulMBX8nytQ4T6mJ7rVi6aaNVNGap4uJuuRpuqvcdKjxqu3CrTqb2WI+RQcOXXPtTXM79pnkxSNl9KXXbVveb9Q3mK0gSFjOPbkXYoTYqlZ0lLjJFELbwZGpTX3ZjNn4/ovP+WUwroH+VSGeCnaQZwNefbOQh4htsgmDZuLCnY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 556594eb-5b3b-4e03-2637-08ddd8983632
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 05:30:41.4196
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ShZ5/wyWtuGUEU9r4EvV5BNwdTj+2EdXqSS/Hzm5Glb8hm/WLqz95gpX3rudBQEic6jezVsxqdaiOPMO6dT7Lz43xO4LNrzsgQOTZ+vowHU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6744
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-10_06,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 adultscore=0 mlxscore=0 bulkscore=0 spamscore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2507300000 definitions=main-2508110035
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODExMDAzNSBTYWx0ZWRfXznE83g3RZ+fv
 ZR398is3a0Lo/zHNmaVG8nN6d/S0fVaPLGD2cUMUCZYUOQrfuyppmoq/lmtrN/K4JYEHN19q04J
 btWgssag2Tofws+8i2fhUhuVdN+kD1qeHzVFQxO5YbGl7tgXfmfl4OhMIJV1kVV6v7B7MMT5gfk
 WQIxcPPKmn+AkR+pNIbPVVNvyNoz1io4XrmF66g01qJ8XnzVClluT1z8vXeIYb1VifHx7nVpyJK
 BqW7vMWHqv12ldNlAKHqF2FJzsAj9YGG93rZ107BDJk2XU+zKL/6JxkyCDjEK2Xlx8FRmOddWHV
 PU2sdxozvPzroqnY95BN6QTBJvrAuu6LKDvju2eyWsNskfIZxJkMKfL4GHzGRPOdTx+wGrGTx0g
 z0TJkB8wf09tmttruRUTdUb79GbEcREFTDfmZ/udXCo3QjaXjLlsrzTvSIdCOvOQ3ukRQQ1J
X-Authority-Analysis: v=2.4 cv=eIsTjGp1 c=1 sm=1 tr=0 ts=68998005 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=MEjK9-KKAAAA:8 a=yPCof4ZbAAAA:8
 a=1BYhWEQi5xbd546j0NMA:9 a=CjuIK1q_8ugA:10 a=wDCLW6yMUrMVbYbmd6V3:22
X-Proofpoint-GUID: hA00lLWjYX2WuCcxc1IiOK3S9YoDDR5Y
X-Proofpoint-ORIG-GUID: hA00lLWjYX2WuCcxc1IiOK3S9YoDDR5Y

On Sat, Aug 09, 2025 at 04:25:18PM +0200, Alejandro Colomar wrote:
> Hi Lorenzo,
>
> On Tue, Aug 05, 2025 at 06:31:55PM +0100, Lorenzo Stoakes wrote:
> > Document the new behaviour introduced in Linux 6.17 whereby it is now
> > possible to move multiple mappings in a single operation, as long as the
> > operation is purely a move, that is old_size is equal to new_size and
> > MREMAP_FIXED is specified.
> >
> > To make things clearer, also describe this 'pure move' operation, before
> > expanding upon it to describe the newly introduced behaviour.
>
> Can we split this further into two commits?

OK can do.

>
> >
> > This change also explains the limitations of of this method and the
> > possibility of partial failure.
> >
> > Finally, we pluralise language where it makes sense to so the documentation
> > does not contradict either this new capability nor the pre-existing edge
> > case.
> >
> > Example code is enclosed below demonstrating the behaviour which is now
> > possible:
> >
> > int main(void)
> > {
> > 	unsigned long page_size = sysconf(_SC_PAGESIZE);
> > 	void *ptr = mmap(NULL, 10 * page_size, PROT_READ | PROT_WRITE,
> > 			 MAP_ANON | MAP_PRIVATE, -1, 0);
> > 	void *tgt_ptr = mmap(NULL, 10 * page_size, PROT_NONE,
> > 			     MAP_ANON | MAP_PRIVATE, -1, 0);
> > 	int i;
> >
> > 	if (ptr == MAP_FAILED || tgt_ptr == MAP_FAILED) {
> > 		perror("mmap");
> > 		return EXIT_FAILURE;
> > 	}
> >
> > 	/* Unmap every other page. */
> > 	for (i = 1; i < 10; i += 2)
> > 		munmap(ptr + i * page_size, page_size);
> >
> > 	/* Now move all 5 distinct mappings to tgt_ptr. */
> > 	ptr = mremap(ptr, 10 * page_size, 10 * page_size,
> > 		     MREMAP_MAYMOVE | MREMAP_FIXED, tgt_ptr);
> > 	if (ptr == MAP_FAILED) {
> > 		perror("mremap");
> > 		return EXIT_FAILURE;
> > 	}
> >
> > 	return EXIT_SUCCESS;
> > }
> >
> > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > ---
> >  man/man2/mremap.2 | 84 ++++++++++++++++++++++++++++++++++++++++-------
> >  1 file changed, 73 insertions(+), 11 deletions(-)
> >
> > diff --git a/man/man2/mremap.2 b/man/man2/mremap.2
> > index 2168ca728..6ba51310c 100644
> > --- a/man/man2/mremap.2
> > +++ b/man/man2/mremap.2
> > @@ -25,18 +25,47 @@ moving it at the same time (controlled by the
> >  argument and
> >  the available virtual address space).
> >  .P
> > +Mappings can also simply be moved
> > +(without any resizing)
> > +by specifying equal
> > +.I old_size
> > +and
> > +.I new_size
> > +and using the
> > +.B MREMAP_FIXED
> > +flag
> > +(see below).
> > +Since Linux 6.17,
> > +while
> > +.I old_address
> > +must reside within a mapping,
>
> I don't understand this.  What does it mean that old_address must reside
> within a mapping?  It's a point, not a size, so I'm not sure I
> understand it.

I think if it were a size it would be more confusing no?

It's an address, the address must be located within an existing memory mapping.

Will replace with 'located' for clarity.

>
> > +.I old_size
> > +may span multiple mappings
> > +which do not have to be
> > +adjacent to one another when
> > +performing a move like this.
> > +The
> > +.B MREMAP_DONTUNMAP
> > +flag may be specified.
> > +.P
> > +If the operation is not
> > +simply moving mappings,
> > +then
> > +.I old_size
> > +must span only a single mapping.
> > +.P
> >  .I old_address
> > -is the old address of the virtual memory block that you
> > -want to expand (or shrink).
> > +is the old address of the first virtual memory block that you
> > +want to expand, shrink, and/or move.
> >  Note that
> >  .I old_address
> >  has to be page aligned.
> >  .I old_size
> > -is the old size of the
> > -virtual memory block.
> > +is the size of the range containing
> > +virtual memory blocks to be manipulated.
> >  .I new_size
> >  is the requested size of the
> > -virtual memory block after the resize.
> > +virtual memory blocks after the resize.
> >  An optional fifth argument,
> >  .IR new_address ,
> >  may be provided; see the description of
> > @@ -105,13 +134,43 @@ If
> >  is specified, then
> >  .B MREMAP_MAYMOVE
> >  must also be specified.
> > +.IP
> > +Since Linux 6.17,
> > +if
> > +.I old_size
> > +is equal to
> > +.I new_size
> > +and
> > +.B MREMAP_FIXED
> > +is specified, then
> > +.I old_size
> > +may span beyond the mapping in which
> > +.I old_address
> > +resides.
> > +In this case,
> > +gaps between mappings in the original range
> > +are maintained in the new range.
> > +The whole operation is performed atomically
> > +unless an error arises,
> > +in which case the operation may be partially
> > +completed,
> > +that is,
> > +some mappings may be moved and others not.
> > +.IP
> > +
>
> Why this blank?

Oops that was a mistake, will fix on respin.

>
>
> Cheers,
> Alex
>
> > +Moving multiple mappings is not permitted if
> > +any of those mappings have either
> > +been registered with
> > +.BR userfaultfd (2) ,
> > +or map drivers that
> > +specify their own custom address mapping logic.
> >  .TP
> >  .BR MREMAP_DONTUNMAP " (since Linux 5.7)"
> >  .\" commit e346b3813067d4b17383f975f197a9aa28a3b077
> >  This flag, which must be used in conjunction with
> >  .BR MREMAP_MAYMOVE ,
> > -remaps a mapping to a new address but does not unmap the mapping at
> > -.IR old_address .
> > +remaps mappings to a new address but does not unmap them
> > +from their original address.
> >  .IP
> >  The
> >  .B MREMAP_DONTUNMAP
> > @@ -149,13 +208,13 @@ mapped.
> >  See NOTES for some possible applications of
> >  .BR MREMAP_DONTUNMAP .
> >  .P
> > -If the memory segment specified by
> > +If the memory segments specified by
> >  .I old_address
> >  and
> >  .I old_size
> > -is locked (using
> > +are locked (using
> >  .BR mlock (2)
> > -or similar), then this lock is maintained when the segment is
> > +or similar), then this lock is maintained when the segments are
> >  resized and/or relocated.
> >  As a consequence, the amount of memory locked by the process may change.
> >  .SH RETURN VALUE
> > @@ -188,7 +247,10 @@ virtual memory address for this process.
> >  You can also get
> >  .B EFAULT
> >  even if there exist mappings that cover the
> > -whole address space requested, but those mappings are of different types.
> > +whole address space requested, but those mappings are of different types,
> > +and the
> > +.BR mremap ()
> > +operation being performed does not support this.
> >  .TP
> >  .B EINVAL
> >  An invalid argument was given.
> > --
> > 2.50.1
> >
>
> --
> <https://www.alejandro-colomar.es/>


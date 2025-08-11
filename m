Return-Path: <linux-api+bounces-4439-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D983B20CF2
	for <lists+linux-api@lfdr.de>; Mon, 11 Aug 2025 17:04:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99CC83BC886
	for <lists+linux-api@lfdr.de>; Mon, 11 Aug 2025 15:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7BD42DEA94;
	Mon, 11 Aug 2025 15:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jKiYnbu0";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="qGyLoW7o"
X-Original-To: linux-api@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59BDC2DEA99;
	Mon, 11 Aug 2025 15:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754924466; cv=fail; b=QCcHMCJGEc1IrRmhbQXOx0RBloESErDalrTkkdGrxc/bx9IBaEOnXWFFQ8TeItXX7qvknmnmACdVKCQCVa6wXWN9he/FQRpVr11LuVOoXhLI9AjQmCyHLxdRDgWxUFUpcrFOGK2ERW+/4o5E9cBMjNaann+Y2PhfvNfMmsYHqLs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754924466; c=relaxed/simple;
	bh=Vj2IxebctccNDW08shaFzF+hFGuHfjEeaZDpoRqVI5M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ct9C6oyZJxVIu+IpbJ4PR+nLA0lt6EYri/OQPGDWMGvaYZh3wK+CWSTJX4XRzX3CxpjUdxNNWVU1KMCiYKjFwo1ZsMKLZxtvJdhLvXmliWJvYWuuZu/dpZi3TgSEL3QvpHNyaGqo3E1MKTMdfBOCsH3y/vyt3KhWC/qpJdofSzA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jKiYnbu0; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=qGyLoW7o; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57BEuFZm022462;
	Mon, 11 Aug 2025 14:59:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=eke5O0l8ECzfh2oJPq6z4c+0Ae1qGlDC7hfldsYPOaw=; b=
	jKiYnbu01emWedc83J8svJFfHcAM63P2UQs26zXo+DRuD9QeRQwi1g4a52H4psjw
	XKL8u8YBAR78KQTYqvmcgXEX8jXJeK9dvICxBsTxDrcasLZUhzhbm/XSOm9HvkO1
	5AvwRt5HjdzxjCU6PSIOdQv3jDI8Qw22YuMQ3U8W8TeobWpsUAWpdHMDQAH1QLPG
	E3uypw4Ac+VMwpT7oEWiAZ2iksFBOkIXytiTVCqKWuOiBMIUhIl5TkePLA09UjCD
	fCkLU2KTSoLV7lTXKp1caLbzI5Uil8GeX8lQxibhsWcf601tpJSGftlx77936y6w
	Ldj8UAFhB/mEOsQqWDKXTA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48dxcf2tau-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Aug 2025 14:59:50 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57BDvk7s006371;
	Mon, 11 Aug 2025 14:59:49 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12on2082.outbound.protection.outlook.com [40.107.244.82])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48dvs8h5wt-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Aug 2025 14:59:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mNPTjYYh/kZbhw2HS1OMxhN/gDsjuNAb2ligXisIlZBKsIPQpvGoEkkuDVZLoCHQhhq6P+YfztJboVH6y2LreG2r5+JaJuLNjbZeZd+hJkUR0P35jxQtlK0rMDMwnR49kQ/QEZ0/O9cqEsCl3mj/VvwydxNkUbopg7jH/WhR3CDmUtaSd4uLbViZKEgBoFy7Fufxd0Ze7h5AegHDFXjueMhs+QrYn1Gl8uKaSthwEaIjA5Uf+rt+2iMl29rRENnjA+H1HEEn/yiBYQsDxSm/sFxpcPHgrVhyx/Hv5W/Lu2ovxCbHcVW1Nm65/U1491YCEwO+pjVSEj03yXjnitL59A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eke5O0l8ECzfh2oJPq6z4c+0Ae1qGlDC7hfldsYPOaw=;
 b=RK97wRLdoeYhnjhh0DxAxsdYzodvuycluQdbz0CPQa06jGn/VgL+81HFOxrLJECAPHjptyiD5NnPAgHo2ePwZZA8PjAybtG+0poBOglhlsvYLMfC32mqR94qJMIXZnhZSY5QC7z6jfXJs+CaU/nZln0kQkH6eiHoSXMgA6rguoLz+6ys3/mY9bIPBQ0nWYk/Kuhue4q19S3Lah1Uq9V0LMPW2P4aN35prV5d00CoCUlViseboXWqyH2zccFFSf516p7aoq2dD2qSy1luvv0gtdMTlR0jwPzPdzQYeCcL9tsFnsyJ5FJQ830iNfKVU8rHSNDoDVZjIo9Cgi7xUKzRjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eke5O0l8ECzfh2oJPq6z4c+0Ae1qGlDC7hfldsYPOaw=;
 b=qGyLoW7odGm3WMf+mMAtaJx8JLHD123tRJgaWWClhol+ZvjDZHan4OA7pWBsM3gHc39rdaeaIiwEGoGsr230GPSWc6FFPf6AnghrXot/jX+DdfgXtq0GZDMh7pYdJPhYlyVrwDmo1x1+BVxbEyrCSAL296qbDVqij75tj1WHql4=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SA1PR10MB7553.namprd10.prod.outlook.com (2603:10b6:806:376::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Mon, 11 Aug
 2025 14:59:47 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9009.018; Mon, 11 Aug 2025
 14:59:47 +0000
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
Subject: [PATCH v5 1/3] man/man2/mremap.2: explicitly document the simple move operation
Date: Mon, 11 Aug 2025 15:59:37 +0100
Message-ID: <0a5d0d6e9f75e8e2de05506f73c41b069d77de36.1754924278.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1754924278.git.lorenzo.stoakes@oracle.com>
References: <cover.1754924278.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0027.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:a::34) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SA1PR10MB7553:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ccd0d70-1319-4ca9-f383-08ddd8e7b6f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yAet+M1iciP0H/clGwxbRHCKN33BxUWTp4qjyYt2UzFDan6U4hBDYkxF06Re?=
 =?us-ascii?Q?pthO0D1g4/ejxnH1Sa9lQpJuvYRq/U8Mt6i6x50MWnBluZqOYID0df1LgESx?=
 =?us-ascii?Q?bh+5wfw12ON7zyKl8ebpgT1YqhON5XW9C9l/LFTRNukwrmIJLrCTed+7DZbw?=
 =?us-ascii?Q?5WftkSCtOl1uchWZ42ja3hdUQNET4yiXmrlTnQt6wWH4OYmp0Q6DO05446sb?=
 =?us-ascii?Q?4DrqnsABdr/2F50Gl/aeCie1BYrruyoiNzfXldNG7s3zV01tZ62/eXKHmwVn?=
 =?us-ascii?Q?yVqEH3N91yViLp9xqPEhAciLgmzypAhI4JixwFD5Y3cjHborhkL1hWqEXv9c?=
 =?us-ascii?Q?6vbv12hW97JVNb/qsU4NhPYfhAX1SAsfc3ZR1lhjS7bRsGXHMoclUjoSgYIe?=
 =?us-ascii?Q?arUBkN/heKTOQiNI/QKpUMb8S//11u69mKB6ukq0BIZ44451XBGf5KIgshgE?=
 =?us-ascii?Q?fKofxQMC1mSf85TqoItbAXWDfvjroKSDLWcLnDtol6mMsS6oJZGaMUS+tZsO?=
 =?us-ascii?Q?uujAIMVrY2Ztge9znx9YxkXljcTKpvAejAMWUbPoyGOYLQGu7t6oLN+5Nhpu?=
 =?us-ascii?Q?fzK0oNbsMoEco5bdtaGSkmR3bmeRntQO4vuql2AeUWUzY0fdt56I6wuqfFAs?=
 =?us-ascii?Q?ws92kEbWXA+YzRcMwCklVVh8ngDZPKTHiglXfg7wnGf6N9lHUP2Ep84KRzmq?=
 =?us-ascii?Q?35P3q7Jp+cpRWTzYQ7jkqLz5xp+VbQYwVgTufogNzGtWA0ALsBvuqQnYtGG0?=
 =?us-ascii?Q?uUpoUcKfUWudWgHloMCZPnQUmPOgiAN+nyoR5m7x0FrX1tUrbzT5T7597W8P?=
 =?us-ascii?Q?OoJjGOHh2bcpAYN85A3JUh1DzXBEKD1h6UfcncdDGAIwfhV4PdU4Y7qGq1EI?=
 =?us-ascii?Q?M0nIpJMDgSS10SGTtPsfZJKxS+xnuugx7Xd/ZpsUCRvF/4VP0GFvmZi+WDtP?=
 =?us-ascii?Q?tuTKFMwRMo9DnihwjLrQjSe83w58q3oeRXFoNCOl+zPRoWJeSqvC3m7HGLBh?=
 =?us-ascii?Q?XmMAs6uCXrpNBOHWOjNQ4QQRTz/6xS9iX5pSFrl82VpOx3wFl2tjTtKt9ftk?=
 =?us-ascii?Q?1ue0pOfNP13TqudBpmsNygz4GwNX3fzLHJ/SQcqA8/irgaxy+3BXgiNdyorx?=
 =?us-ascii?Q?uhhIBWZahBE7q74NzMZ8dsE1YmQ94FpB7cWXuOGJqMQ6R0Fo+oL+6tfQIVwg?=
 =?us-ascii?Q?TnDNByIMu0t/7wRuvI00jHEQmDFhL5i5n7O56R44oAMAckybB0iwqrMv7Gtk?=
 =?us-ascii?Q?htQhjbjqu2EZl7NfxvuK/cv0dUTSYEaYpskE1VmpUiAfKKLQ3hkAyENFmTrW?=
 =?us-ascii?Q?bxAKIJHB7hj6tgEpaPVRb8Kui5C3AwCPya7PNudKSxO2qhIMcepEiI0eFmOv?=
 =?us-ascii?Q?V8nkIMRvnzf6uUEH/chu3Zjvr3cEgpAlCy5FeVeavEerzLNSOJCe09+ZxOoy?=
 =?us-ascii?Q?wXVnHcS6jjc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pFtf+muzLuMw8XA1UAQpEh3ypH6Q1Ek6kpBxUuv/ZP9uXonbvTWn2U9J9avx?=
 =?us-ascii?Q?pxETDDAOqq//OkaIGARYFZhZ9mC5b59req4jV4fZldoT3as45nJRu6y3W2ZG?=
 =?us-ascii?Q?uPC5aieNkX1D2l+m2dJ5xw/yiJQznhakMp6j2M9hskwJvs9lRGEI6kOkUxP4?=
 =?us-ascii?Q?6Sbgx30oiRM/eu1l5mylWeLY4tUPAhN7vPfFmj5Vju1fduRm/dVYiQ8KY7MD?=
 =?us-ascii?Q?AwlMd2MohgypIVYnZmrjmystzxJUMac8IXg+GXsWugcfJUosTy60WhAk2oxB?=
 =?us-ascii?Q?69jLTtDJ3QM2TYNSHv1jgieHyseuW+olHE9yOJimMhO59ITLjfsMYlF/+LAv?=
 =?us-ascii?Q?1G5LQcQ/Zhf5wTbxye8EHveLdzxv3Cxd5LVZS990vADRwoVIDLzRvmMpHgXL?=
 =?us-ascii?Q?vAVYdByC3xGfhXcel33KCui7YLhm08MFOhvUg0sMhXZ31PfemhH0wM2Zn3/I?=
 =?us-ascii?Q?IyEkNRuXoMqrra0CQ0Vk03b6ueIEpIPtqSqM6PgwyPrJGEqNiUgeS6moUyVJ?=
 =?us-ascii?Q?bKP3sLmJMiDP/6zMLxyOwxl8wtdcfO8x2gntA//OdFu0lnSU9r9PiTTC0mKK?=
 =?us-ascii?Q?95MmuGBGPFz+IgV//Z6CO2tv4cQjj0Cv+sPzRY0wtBf28+vkI8KsJcoyZ/Dq?=
 =?us-ascii?Q?gXaJyZdlcTPdq1e566XnonjBbGdROvYbOuElfJ8xjR3Ih1msfdge2BnHHAwH?=
 =?us-ascii?Q?29uyQ/eOU/pB/BQ8778xLBTveecdc9Sxs/eMXP10MEVAh1EFqOf8y2CKI/+N?=
 =?us-ascii?Q?df+Z3WpzBP+mALmHiyKL4n7EW2nsrVd4Dx2LK30AkXjYdDdJ44sdt3czlmGD?=
 =?us-ascii?Q?kRJzmlZj3TE52GQMqfyl7FFbEG4mqC64AiKPIVSB1FdlmGZderyjGKl8hoc8?=
 =?us-ascii?Q?w6yNcU7fZTCzxVYSVmJDFmSjWXlgs6nZZOBvPBzFiZpyVBTg+or+Bi+nFZvY?=
 =?us-ascii?Q?hCk9rdQGy4yzqZsY5CkH15sPCJX2mjp0C31dJjSR5OAjmYOJksGC1Pvd3w9v?=
 =?us-ascii?Q?VFrglKGHWC6Ywa7ga+2YpbZPBB75ZIFYRjOiHLRLJRE9Ds8KuPrjBcXS78mX?=
 =?us-ascii?Q?p2dicPAyQf2N00PG8n11Ur34wfiwBh6N4xCjJOXrY5T/2+iET+x/qmD1vubz?=
 =?us-ascii?Q?TiZhj9y/bzQtI7YdwH73AjBhSFuGqniX4PY2goN4vaetdXiZqYjdnJRmuhuM?=
 =?us-ascii?Q?4JKcK+pTgqPtmV75z1eZaMva2N75FxjMR6nIYYt6uhfkspWNR48sxfVWR6eo?=
 =?us-ascii?Q?/1wAGvkKRSZFdPGAMSxvC8QVgvNSDO4fcfViD0zQ9AybdjvBDha/sxDSEeBB?=
 =?us-ascii?Q?S0+FdOwXyvQqRjVF0wNycqJPP3lg6zJuJb4OX1uV7JMtyWlhOH7aEUpFDtvU?=
 =?us-ascii?Q?O1Bc6SDr2Q+wPDdi60makevkrE44YnsaVlh5dZ09QTsSSiYxye58OkPodEfr?=
 =?us-ascii?Q?s/VmhW/Qej9nXCONPg+PDAvCfam3aCQarL0e3um44koMerMIwNBZ1guz/4zG?=
 =?us-ascii?Q?C7NabQWU3r4/6kbhQHvHC55d2MwGRF+GB1WmmXLYewOCtGmYk4dft5WWBwh5?=
 =?us-ascii?Q?MRLZnCUCtpi3ZZnB+plPudCs9NbiIBDC+IUyG5PM897ItRPFVONs6qEoMvVf?=
 =?us-ascii?Q?/w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	RGs9V9ppw8AoggBoQ9wVgtwEl5dmFei1aIDNcu/bt1W9/J+OlynZdjMEExG8xKDF8/lHhkaHnUFX/W+MTsYW+yIjr76XVV4Tyg3UohhG31ob+Qfw20raVRqTr7+rnlrr9RWXTVo/1U+AXT4P62BNY87HZ2e3eRNSThF/6NOQnhUul/7Q23qdxfBTML6CxyHA9tkfs02wiKkOJFCd5yrOEWOMxTf+8yQAAzN4k/xQv16ki2+EmK6qa/tjEoHQLhN014sgP3QOooMq5WL+49tj2qKrGRb7c9STkzO0w5iAODzT3dlCewVCOwonYrJetuUmG49j0QReY7KgrprfAGLeDbVcHXUAnCP2ploU9PDxnnop3HK7rs3hQRVYk2KuRGN/tUJZxkXYq/svKKlUMKhLDvqmS9PTtjN52nA2ShGMx36OhiXzjUThpZzqRQtkXbjscjnJQUj9cJ1BxhGUsxZdAMFXAwRDt26x5EnvXO8BlkZ21YugBEEX75MS1LbiqypGpqSASWqIii032ZP90NgYgndgbyJMQWi7H6gG9zO14nHxAEEaNc+QLBt9xJwp9j6quul1xayuUubSDkRSoYnxuEEImh9YWvhr5OI1/44FLUU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ccd0d70-1319-4ca9-f383-08ddd8e7b6f3
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 14:59:47.5665
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tq4dVm2nmHOOIpAT7U4m/t1G1eamrt8bZQI7o2zkSKwgd8mb3zmSzy7xiPKfwHeKPeVeQimBZb/dO0Ahp4Qj+2tiYCO9BAtmHnILzbVPJ9Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7553
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-11_03,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 malwarescore=0
 spamscore=0 bulkscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2507300000
 definitions=main-2508110096
X-Proofpoint-GUID: hQdQs00EL6xIbfGyXcbtJCjaPSp3EKxv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODExMDA5NSBTYWx0ZWRfX1dcbAG0GAkhv
 cJVNE8OXAoeiVwugNhgiuiW6pjiVISitgR/DihgQBAn8Ii0GS6QJtw0rWoLHvhjLW/7eO9y83C0
 IMJgrG+PR1fPSjNBECi/WAyr3E/BxATGVtBdO9IGS67PRlllJGGfbJZ5JpZ6AxY3lJUbGHC1QV9
 6TfBx/XPNsvlnRjwJ2RGRkVG2E0mahYX+QKH8rmZLfodKuaCo4tG2mJb1dpIFGOoUy+UJRdR/Ne
 dvUqPJhlTAvdwaHmuZOBUoejJPSdoMgTEyn1tIrY31Y9LLtlI4VJGPNy8MusE5zpO/OjrCRVAMk
 SsW2q7WyCNFV4cLr+CHhX5GgKL0GLQnnO4PnbkyRfciJFGlVNZJ/8FsIer44VOe3sqcpjDu/8eC
 d3DzEm6khDEvHWo+rcPTedaJ9mkoDC8ubH5uLaDHipWeD61IOOroP/m2V02WhGDnxIK0aT1l
X-Authority-Analysis: v=2.4 cv=W8M4VQWk c=1 sm=1 tr=0 ts=689a0566 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=2OwXVqhp2XgA:10
 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=jsI8mISQ8N6HiLSqmHcA:9 cc=ntf
 awl=host:13600
X-Proofpoint-ORIG-GUID: hQdQs00EL6xIbfGyXcbtJCjaPSp3EKxv

In preparation for discussing newly introduced mremap() behaviour to permit
the move of multiple mappings at once, add a section to the mremap.2 man
page to describe these operations in general.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 man/man2/mremap.2 | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/man/man2/mremap.2 b/man/man2/mremap.2
index 2168ca728..4e3c8e54e 100644
--- a/man/man2/mremap.2
+++ b/man/man2/mremap.2
@@ -25,6 +25,20 @@ moving it at the same time (controlled by the
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
+The
+.B MREMAP_DONTUNMAP
+flag may also be specified.
+.P
 .I old_address
 is the old address of the virtual memory block that you
 want to expand (or shrink).
-- 
2.50.1



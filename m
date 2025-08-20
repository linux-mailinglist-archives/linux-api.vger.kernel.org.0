Return-Path: <linux-api+bounces-4525-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F4F2B2DAE9
	for <lists+linux-api@lfdr.de>; Wed, 20 Aug 2025 13:28:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1F6F4E44DC
	for <lists+linux-api@lfdr.de>; Wed, 20 Aug 2025 11:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD86D2E3AEE;
	Wed, 20 Aug 2025 11:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="I7ZMPSy0";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="pAzoXWNt"
X-Original-To: linux-api@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD4952E542C;
	Wed, 20 Aug 2025 11:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755689099; cv=fail; b=LWVqisLYpS22s3TgTfHSpbG628W5RDwzmeCXkruDUF3jx7FlV2I1VEpFgFXZgFq7ZeIVUyg3NYcIx696DUQgrQ9g5T0uH6q0AYpIGHWRk7yxuf0bLeExZnSgjfbOT1N3XYTzgvNZGba8j937zNRp1eL6JoTU/jEQexKvPhpHEb4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755689099; c=relaxed/simple;
	bh=feCM5RJy6vzZGs1kuiHmtK/60HF2YKAYP8/xJgLKO5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=se4G5mF99n79RbaYcG8iA9EHZAipM4VUrIgr5k7pkmrcSLgUTMBy//il4YSlhuX0m5K4e9qGllB3FEmV7JWKaGGuAQ25XtZsiePQWptRikZ8rACo8HEey+X1/xaIOJR0uKlOoqKV60M2iOCvbyviQdloL5KUhlahjmMCKredW9A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=I7ZMPSy0; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=pAzoXWNt; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57KAxFLN012214;
	Wed, 20 Aug 2025 11:24:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=RC1wHnfGuQ2/b4i0bP
	lr2yWUrb/RtgX+Y4fLw2JjIPE=; b=I7ZMPSy0OZrmRllMQpIxehof3MzR3X7tmK
	wuJq9oVicNPSqwWNICdxSy74CnRG3MqlISpgej2Lb3vTC+5LxPNKtusBmIIfvtQI
	8Le2Ho0ahm72QyFzccS325uJvZwpjRPfoS6+uJycd+XOUqfgaL7voym4I39/0XBh
	788bEkDu/nkdrtprfl/bxMKbU/hS4RNy+1RHe/5YQg59M8dtKIW86ZJQ0qbslX1N
	aoJdZew77bOugdHiq630KYp105E1bl7XjcpK68jN52y0Na2goGtzQzUPw4B3visG
	FSLLNG9fMml56brAHrV5L8DqLNJV5aK3QYaQvNhiOc6/4ZuZBTxQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48n0tr125t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 Aug 2025 11:24:23 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57KAkCDI030334;
	Wed, 20 Aug 2025 11:24:23 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02on2080.outbound.protection.outlook.com [40.107.212.80])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48my3tw154-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 Aug 2025 11:24:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qp6xEvR0PknpohkMG6yL68jR721wNqbczwfYOKyGHPUDnsrcxjTC6ZeyPs0jolETbAbtcncJRpXMCBqapLrp/vn0om/368J5/MRUXPC1IW5vua6CBs1wl5ZpBKXwzjbmSQt3oy21u/dLboyf5EpjBLehkk5iT1rDaC73I3R10MNhbuIwFUn+dd69N6oW2zQcsAE3N7BIDR22h4evImh017QmtYYrmAn3WB7IV5SfVZ5t2MX6GidiEptVpzwWxJsK4Bk4e86XmXSrVUJf/R38FwFrfZMb6vhELfsAohzLm0IdTPINfyhMUYQ6IZ4Aia2xSREY/+z9Yh3g2gpH+QnGTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RC1wHnfGuQ2/b4i0bPlr2yWUrb/RtgX+Y4fLw2JjIPE=;
 b=ocDOirmSdXf+PkZGXTJnU4Jefg5gSLLHMlSjmsmqCDo60yEh3hE/ncvPWuT5ql5WI4DmK7YtM5auqN2RFm9IT1/S9nq5IIqJD8GoYmFHFsGV9V+7rmsNcfpLf8+FKzZPXjkltjQtdCBB9j1dyZEvB0gL4MLpV+qDujyRLqyb3WNdSv/V8x56Nu6dorDGVY0eDoA0oudXKWkaFNtXXApttyNG/4DVKQUTTXQnyasHjAt/IKEnrMIZIbcYyDUfwb42+X63VzwSa0sgaa1w98Kddo5EnKiv3eBe9UsPlSivZ1JamXK5+zZjHtQ2P7gwJW89shE2Z4JafVhHZbslEMUnQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RC1wHnfGuQ2/b4i0bPlr2yWUrb/RtgX+Y4fLw2JjIPE=;
 b=pAzoXWNtqlctw/TqVBpKMIw7mnpidFc6G9yVwSta9VrNrXw1gbDp9CGA/4VNM5q8MfnluGrG7TEW84Rjzy4H5RulWATVV9hgUzN6VpkYFLuNYLepr0pBiDPLjRie7zyob7Nb2On65JEW3TbCZo7te3sBuGPl6UyGKIJOW5U+5GA=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SN7PR10MB6363.namprd10.prod.outlook.com (2603:10b6:806:26d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Wed, 20 Aug
 2025 11:24:15 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9031.024; Wed, 20 Aug 2025
 11:24:15 +0000
Date: Wed, 20 Aug 2025 12:24:11 +0100
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
Subject: Re: [PATCH v5 3/3] man/man2/mremap.2: describe previously
 undocumented shrink behaviour
Message-ID: <2c7f0625-9810-480d-b29c-43b5cfedef3b@lucifer.local>
References: <cover.1754924278.git.lorenzo.stoakes@oracle.com>
 <ab2264d8c29d103d400c028f0417cada002ffc11.1754924278.git.lorenzo.stoakes@oracle.com>
 <uvh2e2jjdk44tdwrhmnd46atwgdzwwmny4kczxqv2vm33gjqpp@63lsupn6y2u6>
 <fb880acd-25df-4386-a13c-9b68640477ef@lucifer.local>
 <jmjlamoqau6rs32ldggra4ojiwim7b7h7xtgzh63m64xejsid4@cdnae7mjdeh3>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jmjlamoqau6rs32ldggra4ojiwim7b7h7xtgzh63m64xejsid4@cdnae7mjdeh3>
X-ClientProxiedBy: LO3P123CA0032.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:388::8) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SN7PR10MB6363:EE_
X-MS-Office365-Filtering-Correlation-Id: f78b2d70-0e04-4657-2f35-08dddfdc1829
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GN7KObLYqGDAEoIMQ0yWzErziEPh97z2syVVHtQ2x+dPyYuiZVVkp+hTsdHR?=
 =?us-ascii?Q?3nhFH3jiJu0GwOvZszjV8HpaKJlcbTAVQ/Dk8X7Ruc2pkPPCqeU/tRnIXLGZ?=
 =?us-ascii?Q?8NQtNg0JzwJcTzu3VjCBZsa6DGDNIGQnkroIgjyWoYjS1cx0v/7ICVPYqpFi?=
 =?us-ascii?Q?gahO8COkOGzTcsTWMf7sEpLeVvSigOGokmQMqs7cEXW5fKV7taf+Ia8nnojg?=
 =?us-ascii?Q?QOR7KSoU2WPNlbOscDI15bw649TmzqqwItSl8kmZqZL40hldQQRRPILLd4Es?=
 =?us-ascii?Q?iyh5KZROBfo4r9EnGgagVsZedIq3MEZrZQAROGAgdsR7oRyXEPARwgdT64aD?=
 =?us-ascii?Q?WkdKhg3SoLbaOA08EWFNPI1Va+lQT/CnsXaSMuaLR1TNpIAm0SiNpreUsl2i?=
 =?us-ascii?Q?HYPjir6IV06JC42mbt3R2RCzfq3342mblc7Qk45aRi7bSjF64yMCim+N88Zg?=
 =?us-ascii?Q?ofPsqu2MJRD1n/r8wY44te100e8zFWYD+h8hbfR3VCEmFO2K2iFXPc+5HQpq?=
 =?us-ascii?Q?AZ8t5bCHuxWcr/lRt0ZPYkwKAoOopkvU0ooDmgE5iQX+nyojPJWFwfZc5XhV?=
 =?us-ascii?Q?YeKAJAKkmfmiDiRnIV1JChIJXeMfjRXhe7DgNm1Vug88ByJ5W7kemd5PJ7Yi?=
 =?us-ascii?Q?uqLGl9D5LGJ8bz1v9jTi+YBJkLBiqu9wUqiVhW04+0Vb2pUk9HBzCirg+6SD?=
 =?us-ascii?Q?rbY02jUllc/5EY9TmodJCjUEGVqA3VGuZven3f9WjUOO7w4NwHdbqoN0lVq0?=
 =?us-ascii?Q?y2Lg9XRmlZ16GWQbahJFO3mDuWth8esG+hGRhK7ST2rSzskAy4SX4J/rp0s1?=
 =?us-ascii?Q?HdIdb3uaWgkl9ZVLrXcqYPcE7hvYk99H/lQnmA9r7UmVu/B318jazdLmy8Eu?=
 =?us-ascii?Q?FKIHfSkBS+uoqq933GpgpWHej8fOpn6cNpwyjNMg+zDrtMt3nR6Y0KMDQpyA?=
 =?us-ascii?Q?8KyCUnyAEipKvO2wjFUlVNqYJyJaj2/Qk+9dytVwNrcmIHACrUsNRaSkU7Xz?=
 =?us-ascii?Q?VFFAgOxGWmWEeMZj7LsVNL2pB81wCi3Cdp1wXVChrnEYgzeuBXFMGrwfnlq8?=
 =?us-ascii?Q?+iWFlx/RAHfqyoM6WzMKOv3q1zZSG+alTCzaB/S6MRfH9LoOFRW0i2NerOoU?=
 =?us-ascii?Q?JM4VojuwBNwb2fdKrZSZioGgBSlayNS4YKueCD8eOJdXLGRxWyesAelMTvDn?=
 =?us-ascii?Q?qPrRT4T+x3j56HweJljGTS5z+UTnThtXI08RNELP6wRIuYhpMP2xUz+akt4T?=
 =?us-ascii?Q?uo/9ruR2xRLHWMfzAyTgyk4G/1OcxBiXXI4IIwENY2hQb2NxcY93ZLCKTtsr?=
 =?us-ascii?Q?tCqzrREwQiF20KqnvJ/kud8O0AHFIFaiTH3bRfsBuOCChVURMTcLyyyr+HZd?=
 =?us-ascii?Q?CUmA4bPOGqpIfpylHhDBoMr5VC/9?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yMQM1q4In6rs7SVWNyVtl/sH+PVvcfuNj+LVx7AD509OiDT92D5uNy+Ibwah?=
 =?us-ascii?Q?LKckIorDhCgl9ztQpSn6YJEchJAFB86RrVJy0AC8kFU1gS9kmjiXiTm46emr?=
 =?us-ascii?Q?A58psZPOLNzTG4DrN95xiFlR2wYoC9cGzTVSh4A+lSq1j+mKJ+3kmzDq8Rjw?=
 =?us-ascii?Q?9j35nLsUmE4sEURxCZhMyrI8QHYUatMceD2iLlrKFSfi4o82xK5mtbDnLVla?=
 =?us-ascii?Q?m6i272qGsck0KXFxoc4jRdmVNw+JqOS3CiqItSCFioadNGkOuVAtNaIyHo/o?=
 =?us-ascii?Q?+bMaJomchB6ViiPw16FEL+IQ3DwIxIR4uBhd6sLNBjEbJHADFH2m0kUOrljs?=
 =?us-ascii?Q?LQKRHgI1bBU2KinACEFYzP+qXl0TWoQSKJPGvO6ufVaGSuMSNlxPL9gmOO/2?=
 =?us-ascii?Q?WDoRGOQw2bbCaZtTi9wzLdAoHzmNILHiE7oUaeBGDBcEUlU8i9hsEbWj1oHF?=
 =?us-ascii?Q?+e2nP9qoKYq2/pJugViz0SaTFykd5hh09f4QyUsJFS8JvK0psG5+G8Tci9T+?=
 =?us-ascii?Q?nwzT9TJKoofmFoY4xmuq2NouTEvJkHKCUlxlxQUvHiOEbjRRAjWUGODxXJuu?=
 =?us-ascii?Q?v9BUHP5jFne17mgQfQIXPFXgmlioIYv2KYwTZoJhIgMt9XIf6N5j4v0tfLpo?=
 =?us-ascii?Q?k0CGuPON8qx/tye5/zbHi2s8DVLdQg/MD/bcq1vaOPPUvwtZbRwwLcR5JlD4?=
 =?us-ascii?Q?2Wlu9rXJabveGDFmkYJeaJjZHSCsLhDKV1HhZPDXVfA7NcBzQi5ZRKKSaiMl?=
 =?us-ascii?Q?OogkaK4T4JvAqZNzTW4KALbQJC/uerTsb5wrCI10jKzUBLdJDcKI0akz/THx?=
 =?us-ascii?Q?1Ty01no0/zj9+On56ZB9yZNoUSM8xvokOXl5vwGPwzRUM+VLXBNMwtC2FbJR?=
 =?us-ascii?Q?7clDtB29na7xWPRkk2QhDbkguPXiOCY6To63bDakUqOlAm6Ldh2ofNbtGtzm?=
 =?us-ascii?Q?bDMY4Ku9mH4M9Hl0cZSXQwUmK6sfxzQ+COLCEV5IhErkhhthmF3CQzq6I2Ks?=
 =?us-ascii?Q?6+gCiUpCJbfInDvB7Etz4vjzx7tsy4Zd+ehSpCggUA5T2ek7iBC0ksHwnkFC?=
 =?us-ascii?Q?rMX1cjC1kSNWqkbKWCBKpsU2md6eTD4m63IxjWLjAr/Li/b95hE3p/q0bbjD?=
 =?us-ascii?Q?H8qaViGEu9+K4Q+/pMcSoiVXP63uvBp6VczGDwIZ6WlVETmp3osXHlbb9RTK?=
 =?us-ascii?Q?lnIH06RDAlcX38lxPwKeK+1yV0ogjM3cKspnOTeN0OePxt2DXhYxA+nRVmNj?=
 =?us-ascii?Q?xKeRwtshr3qFF3MnN/3bgT+BuJPk31SB+u/98VCFWV1TLjbmFWhScjWYTKX7?=
 =?us-ascii?Q?JDuaxdpEm7Gb5VcaPdkAoYZ32B8zQbNHcBTBg0WGJPVHNfdeO8o8KxRqRot/?=
 =?us-ascii?Q?IDwwXySlq3GvZRLMvjMrVTDSp780j2UOYgTw1eu7hpEdFlUxND5VoxRK+dTw?=
 =?us-ascii?Q?S6uUl3qGvtfBS6V1Jz0BJ13tqLp7xTOKDDz2mkgQAXwpi6EsUL6sIyu5Oahm?=
 =?us-ascii?Q?OB3Oh0dZoBj06gysZBb18JoXfG7uluY535oQM+qhI5gSAX4wez5hFiAa99zJ?=
 =?us-ascii?Q?OJnieeCagtNBU3O/VzSK+p64B9gOFnaWt85opyY8Rr9VMbCXgPuXg1eS9I1r?=
 =?us-ascii?Q?Bg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	wvh+VWmmJUJfyze5TtOem+x3CkExN7pqCQtqo97ImayHeUQGzVw7OuD/fK6zKuNqlLijDT6r/kUgH98VQN9g85MQF3HOX4FQp4YSazy7ihwA5lN9+DwefjtFQBsQTi7FseiEwLxw9X7egbYvwwU3yIoLMCWBhjPrgAM47vsTexx3jmmOtx6fM+0gm6TIBRP5lRhaO9eFc3UYiySX71dU1v+AfZPst1J73/ROR93KHxS2BEL+pSy31bl3H608t3i5uc6pCezKTi13tCtF5UcWDXCQPKSL08EkmlOP0lGYuI0wY64GGRVKcjx6TgysYqNfY2kJLwT5L01mVHRMj7UMiZAHUV7ue2NVZ3SrfcRLDbXxuJsFais7Mvcn9Iyv0IQvx6gThcBaLw8Lf5eJ24/TmL5kZqG7SDv9n+9DtFNFDcfZih+6+cMb/z6qANeO70wOF9OpDNR/BvWMoesH7KgwG2M5QqW1l0aGx1Io/KVkfDIm8H7XMtKzH757wVV/qmQC0B4zXMF0SvQAxudlie/NznnNMjj4l75NLoxTs56uL0zOV9gTDMQxT7lwsm05WlGy+5GMCIZJ+2ZJ0KfP44lPFUf1EmhSbZoDnqxk/YKrKYE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f78b2d70-0e04-4657-2f35-08dddfdc1829
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 11:24:14.8549
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Kvi6t6YfERGi4lavfdiJM1Be59d8nWmsRRScQjvjhaBexpvVN01AAbcyzuud+gHc/G2/kI0R3lcoZ88NqBxoRBAOEsIJLTT58GpabGoyULs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6363
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-20_03,2025-08-20_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 phishscore=0
 mlxscore=0 adultscore=0 mlxlogscore=995 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2508200100
X-Proofpoint-GUID: GL21NMdTIOUTqtYPwMqWOjDcGYWnrm-A
X-Authority-Analysis: v=2.4 cv=FY1uBJ+6 c=1 sm=1 tr=0 ts=68a5b067 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=MEjK9-KKAAAA:8 a=rBu-zQOFr9hPmMrUqdUA:9
 a=CjuIK1q_8ugA:10 a=wDCLW6yMUrMVbYbmd6V3:22 cc=ntf awl=host:13600
X-Proofpoint-ORIG-GUID: GL21NMdTIOUTqtYPwMqWOjDcGYWnrm-A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE5MDE5NyBTYWx0ZWRfXzVeu2qFjZhFo
 wR+2iwfUhQ21/FdhmzGeD1XW52ahM2kv/AfIQXncdcze9mRoaNJvTDATHSRz+aSrco0KRVbbrDb
 2GydnAafzB7Kve5yWocBQy+Wk0MwuUn9a40XSGdes9NYLhxCLOVLFJF0dxelQypPHTWO4i21dkO
 tROchPyEkWf8LPDJRvr/QzomC6+oGIe116fnBZAoUthx+IG+VNbQFFZgeqxDDvHmyk0B1YDr5t/
 r/gOdG+2Qdh/sukXyCyG3TCrfsHjIkCummVpx5pjdnuaIYtwJYRuI9gP9CLKRpWAJbTGj++XnYr
 vBgkgLnu//DeeAj7/EfH9pdtbAY2/SpQByg3YE5nK0adQ+iseORtdZtsenbVkvMz0G4SDLzu70M
 YHcZEHi51oHJgQAp8QFb8KSNJQ82XbBe/ArWTDfyku4D6QlEi6A=

On Wed, Aug 20, 2025 at 12:50:25PM +0200, Alejandro Colomar wrote:
> Hi Lorenzo,
>
> On Tue, Aug 19, 2025 at 09:37:39PM +0100, Lorenzo Stoakes wrote:
> > > > diff --git a/man/man2/mremap.2 b/man/man2/mremap.2
> > > > index 6d14bf627..53d4eda29 100644
> > > > --- a/man/man2/mremap.2
> > > > +++ b/man/man2/mremap.2
> > > > @@ -47,8 +47,35 @@ The
> > > >  .B MREMAP_DONTUNMAP
> > > >  flag may also be specified.
> > > >  .P
> > > > -If the operation is not
> > > > -simply moving mappings,
> > > > +Equally, if the operation performs a shrink,
>
> I've changed s/Equally/Similarly/
>
> > > > +that is if
> > >
> > > Missing comma.
> >
> > Could you fix that up? Thnks!
> >
> > >
> > > > +.I old_size
> > > > +is greater than
> > > > +.IR new_size ,
> > > > +then
> > > > +.I old_size
> > > > +may also span multiple mappings
> > > > +which do not have to be
> > > > +adjacent to one another.
> > >
> > > I'm wondering if there's a missing comma or not before 'which'.
> > > The meaning of the sentence would be different.
> > >
> > > So, I should ask:
> > >
> > > Does old_size > new_size mean that old_size may span multiple mappings
> > > and you're commenting that multiple mappings need not be adjacent?
> >
> > Yes.
> >
> > >
> > > Or are multiple mappings always allowed and old_size > new_size allows
> > > non-adjacent ones?
> >
> > No.
> >
> > >
> > > I suspect it's the former, right?  Then, it's missing a comma, right?
> >
> > Yes could you fix that up?
>
> Yup.
>
> >
> > >
> > >
> > > Other than this, the patch looks good.
> >
> > Thanks!
>
> Thanks for the patch!  I've applied it with those amendments.
> <https://www.alejandro-colomar.es/src/alx/linux/man-pages/man-pages.git/commit/?h=contrib&id=21b1c7188ce1d66ef294eb1681361315a35e8070>

All sounds good, thanks for doing that and also for applies for other patches in
series :)

Cheers, Lorenzo

>
>
> Have a lovely day!
> Alex
>
> --
> <https://www.alejandro-colomar.es/>


Return-Path: <linux-api+bounces-2337-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6975298654F
	for <lists+linux-api@lfdr.de>; Wed, 25 Sep 2024 19:05:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4A6DB25022
	for <lists+linux-api@lfdr.de>; Wed, 25 Sep 2024 17:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2F9C34CC4;
	Wed, 25 Sep 2024 17:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GG1HXv+V";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="l5qStjS5"
X-Original-To: linux-api@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98CA883CD9;
	Wed, 25 Sep 2024 17:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727283946; cv=fail; b=b8b6PVJy7z0XSuPOAwYzV6YeFq+YCd5v3fva2DM1cdR6nTFSNZBY9tc6cLVONrfM3JX46ws3c13rvnJKqa8hpGoYIHvHdars9thmYRJ2Rgnzx/lJN/+OhkTsar2bYUTHqz3VVsfVRBRFJ2CiIAd9tqGc/BrGxg1MsvdMc4fpYOw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727283946; c=relaxed/simple;
	bh=V/FTcU6Alt5lu7AGW2SpA28X80AOXDoiFdtree1iqsk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Q69jKm8ZSYbGBq53W7JfUWFaJq0MP6fHHcs0o647wJQ8A5twDrhnXETTwjd+O1gnP3sB0cnULhLuDCNIEMTGFAazmIGTOSlfujNHG1U5p58g46LTNQ87nURFPQYxqJ9We3VDuLIu+NuyKn3cGCZP2pd6nHUxl9j6rEhDY5I4/50=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=GG1HXv+V; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=l5qStjS5; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48PGtbt5018183;
	Wed, 25 Sep 2024 17:05:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=7hIgIl3LS2qTJKW
	d/hf4MGpOCwmba4gYbRgfZD1/zig=; b=GG1HXv+VmduVTfVqPIZylfXtItORD3Q
	+arQNXXHO3FPLEMp2vQp/5UEL0t5Ep54VEg8sOEl5lZa3VDSxEpSon+rZvKSuMVF
	f/vwgnMjWpV6L4q4kOw2aDpD7ilnFb+PWYgYjjERDcXSdJ/OrytTBSpUneSWw3Ld
	S06Drtp4/PeMXAq9wlbc9PIEJR0JSzTdIonMjhNKYBeA7tRFFuht2LN7NU/xfNHO
	0dmUB6RtbUDiPOk1p1LpAuNxQbRCGmC4/oDgp+n7gPPWvhW80NPazPWt+akLVhIS
	5+/VsUZeMFap5zBof86C4zIUYAqGEXBESX9PeQ0DEj0lHv2C6L0+CsQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41smr1b0ke-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Sep 2024 17:05:07 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48PGn2h7026109;
	Wed, 25 Sep 2024 17:05:06 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41smkawqg9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Sep 2024 17:05:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zH0GR5pa9lmmqlgL7uexrX+Gu6J8PbicutZyCViHT0nsmziJp2iyDdvqDx7Ml/m8jKd3bPG6wDy0dtJOBH1stbNnXTICjxDsuVIFNc1PQ7mFWkqqXfSNmsRSvqsFWQwBNfuvf7fafX3wGha8nam6w4je3uVoB9MLjMRw732F7zt6UW6OAEyfbocgcgEDur5QNJcr2iTiJtfQlBRESKY2asH2lZmYSuVxJ4RA9yGBt15quH2yuzZj200zs2qBTXc1H3tJ3DD0mdO2J6n4BKqWB0Y56WCoBD2qaj55+HxAZ7dwz+qkECM8ULG71alIKDaiUX0qDvsgclVpfkemAnl+Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7hIgIl3LS2qTJKWd/hf4MGpOCwmba4gYbRgfZD1/zig=;
 b=DEBxPem56WZozuliV3fKlpyV5X1AN5dXmY3Yqu1IyO/pUc4dIX/1rGIckfBxA1LIrEOkqv2P3LqYi/uRfgz/LTJ0CnK9HHSDsIWMAZYdhExJ+BAvx+SJml5qqq6MBUNh5w4wPTfVsmfPEH6lbO2NUloYAaHsyYKdESVXsT3xPgs+HTV6uPzf6mB7Cv5CqhISDGypb0Yk2MaY6hm2R4wsBUVFqLDZJCcGCII920Z4NC1hu4yhGoj9zWZBLcTAgdVfsodwwvH612tUkYEBdKQoFtl/W5e9swWCnew9KJrsgbCseJalWw7TXL8RCfwOK6VRC6M+D/K4kfwEc/I9XQMjyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7hIgIl3LS2qTJKWd/hf4MGpOCwmba4gYbRgfZD1/zig=;
 b=l5qStjS5Ie9LgQQqpMMUBOloNEXMDFapDUg38N8mjBVe8vL3kh7MwzdJ4g/+mKY7jEKdmUG8PItw2lAvbTcbxBq9SlEstDAl0d9+1wFDvmhIy5rmjPcoW4kc9HUrYgOEjE23EHDml6242jwXvxyDtGPJW5Nm8+t6Jm9VYEZnqLw=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by CH2PR10MB4247.namprd10.prod.outlook.com (2603:10b6:610:7a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.13; Wed, 25 Sep
 2024 17:05:03 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.8005.010; Wed, 25 Sep 2024
 17:05:02 +0000
Date: Wed, 25 Sep 2024 18:04:59 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Pedro Falcato <pedro.falcato@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Suren Baghdasaryan <surenb@google.com>, Arnd Bergmann <arnd@arndb.de>,
        linux-api@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Minchan Kim <minchan@kernel.org>,
        Richard Henderson <richard.henderson@linaro.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>, linux-alpha@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org,
        "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org,
        Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>,
        christian@brauner.io
Subject: Re: [PATCH v2 1/2] mm/madvise: introduce PR_MADV_SELF flag to
 process_madvise()
Message-ID: <6b449c32-0954-4db1-9df5-23b766dc2d9a@lucifer.local>
References: <cover.1727176176.git.lorenzo.stoakes@oracle.com>
 <1ecf2692b3bcdd693ad61d510ce0437abb43a1bd.1727176176.git.lorenzo.stoakes@oracle.com>
 <u64scsk52b3ek4b7fh72tdylkf3qh537txcqhvozmaasrlug3r@eqsmstvs324c>
 <4740dfc7-71da-4eb4-b071-35116288571f@lucifer.local>
 <xilfrvlstq4fqr46jlrzvq2vlr22nizdrwlcdizp774nlt6pfj@jukzlcwc7bed>
 <7f40a8f6-c2f1-45f2-b9ff-88e169a33906@lucifer.local>
 <wvk5y3m47qmox4by6u3zpxtwartjmoaqaaqswbgui626zkjajq@22wjmqo36hes>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <wvk5y3m47qmox4by6u3zpxtwartjmoaqaaqswbgui626zkjajq@22wjmqo36hes>
X-ClientProxiedBy: LO2P265CA0111.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:c::27) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|CH2PR10MB4247:EE_
X-MS-Office365-Filtering-Correlation-Id: fd5a4d6f-0320-49f5-4815-08dcdd84320e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RvMEDzjzKt+Vjfr0sAewzH8aRqdrK1fo5yKRpH5Ce9girEVCjv+EL7rGDp72?=
 =?us-ascii?Q?0rGEFpV1SjQX7DixvXDUypmTdM/ZZT1pQrNRtrYk9GC0m8wxI1WPyjZCcc8m?=
 =?us-ascii?Q?d5M0ZAGK7dTF+npV61q5b58oAac66eGe9sZGDwux/yjExE40QDX+UpX11j20?=
 =?us-ascii?Q?16ronlWO4fOkz2FOx4hkFPcQdVIFb5FbX7FsrXXuu1+tb69hCI2jS98mAPaU?=
 =?us-ascii?Q?/fzm69NfIwDcPsHBH98ovnyZwDBPPzEQRT2BYekPGTybZdB6t/vDUFjvYSCf?=
 =?us-ascii?Q?op6HcXxskuUPhd7p4bKhhKjmdQr59aLw1x5r7nH5+wm5vNB5gSOM0idY8uY6?=
 =?us-ascii?Q?LKOBEV/y+vLua1lWtnpZsF3Bj/KBY0J/cYWOlqnllevdQ/8EkfMcQwDH8qEG?=
 =?us-ascii?Q?2AclvWXprX9hn9U1XjhgbOheSbnjEdQHsijwt7YE8NL+bCIsoIakTGrPPyk5?=
 =?us-ascii?Q?DpzhiS+7boGWyMzgEzVHKDyUwT8pFQws5b+CS22Hx2kap2texGPFC0KAuD0U?=
 =?us-ascii?Q?kVElNYk8rkAK8ZdQ1oaCn3ct1ps4Y0CM5tL/mpkS9rdSo6QG8qQJntra9EA5?=
 =?us-ascii?Q?Y5VJepDAZbQx64/Iqj9i9n4lef/8ds7dn2ibZocvnF+VtQjzuaiOSInkvksM?=
 =?us-ascii?Q?RjaSs5LYw97AGtszE+oAvqQ7gS0VsLMxAJhi8GxyHwuoWo5NiIIShRmSKeTe?=
 =?us-ascii?Q?xuhsUFK9Db57TM5cLApEGVQgx4UH94dT5YB/TbeolmQG4UuiWGnwsE+8dapj?=
 =?us-ascii?Q?90nm6vQeBDw8YKECGE/BsbmNcufWCGucL3f/FsyzdVVcGhQ7ImjLgiKE8E6P?=
 =?us-ascii?Q?trHQFkoAO7uzS4PAf1KC9Apedarc4x1a5X7dKNONwq1vI2ui4HrJOPUEacHN?=
 =?us-ascii?Q?ub3ygykTMXoN/nEKPXJx5559/gyT/8tiSez+YhwREInFRraNrBOiqKOOBZQE?=
 =?us-ascii?Q?Gm3ut9i3K/AHEw9TIZzii+sC955/vetVBgHEMdW7kyAtdbZnVtwv1BBgfwZq?=
 =?us-ascii?Q?mKxWvRO8/DyoaZoMLu2GHRNYs2lWEKebIierxJfvYy8qCgHUkgB20zvrMo1a?=
 =?us-ascii?Q?ppEFBhUY23meHKMXTg1SkTrel9BI6+AnCkmblyE3/2OkrFh8Cy8kH1hDQSp7?=
 =?us-ascii?Q?Fg5P9WsM3Bm3j8z0SJ7YuH5Qr0xzE1RdWj0aBvCpU6xgyj2n+hqNLKZ/vJez?=
 =?us-ascii?Q?+WhioWAHANTNlX+jC+3RqAEy9iFBtq02CcvuGPBuGwLkicaU/Y9M3poe5Aka?=
 =?us-ascii?Q?bkovdyAzSy0loNGlMchkBoxK7fnfawwpQVt508D5nQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sg+QMQcKtADvxzJ25VsKN3geQtpmFCSnmGaUXlh96QjBru66JrxCEnxagQG8?=
 =?us-ascii?Q?xAC9CnnurnImjTahpHT9HIN6pwDeFJMNDSOSYyr/lkcqjknbpoyv98AsQamR?=
 =?us-ascii?Q?KjZND99Ps9jzPuCvL2FrYsnTRVAK5FtxdVWssA8L5PKM4OQPYfuyYq6RnHE4?=
 =?us-ascii?Q?scEAFnrj2rNIfRwWgeGQL5jF98Fw/5BDzTwk6FZdAUKwXHj05yae2vImpDbx?=
 =?us-ascii?Q?f+zbOIWQ2cs4ftbdvqgR9B0y4g2AvKNoUtORx7q9WsGXfw1t4+TeqtqXkVwy?=
 =?us-ascii?Q?iomDViOsuHdT7cDLP6IyxaQGP2uK53pQje2DzXbmCvT7UzmlcdwF69WCILcF?=
 =?us-ascii?Q?iwA4+8nWs1KzMqo2eAtRS9oaEfEYrsWMj62JeZWUX238yCAEMN7wcU/JdBmZ?=
 =?us-ascii?Q?oByXDJsq0dbBhAfTV3YOgUcPCZn2AupEIDoCvPFQmh1sVATQ1mEvnKQ8R5d1?=
 =?us-ascii?Q?P59uKLUU17d7PpwQez5x/T06WRhH6l7ygZ4Ex8MdRj/nY090gfZZPhTP7+Fi?=
 =?us-ascii?Q?kLQcRsqXQYFHYcYr1BeUrahPluU0+wF8NAw3+73IGPjiHMiIfwYwTRB/eB5H?=
 =?us-ascii?Q?WudCWGwTrzSAB0iNkm2qetC42kM49dPFur1IhgT6sbkfBo5PQQb3S2DLLuuq?=
 =?us-ascii?Q?Iq85uRWJXvqxN18cMN7E+88kEQ66J4KJJzW4pXKQedhfNzbxgVE+diA2wdJa?=
 =?us-ascii?Q?gr4x4LKpbI7zAB6OEGr39nZkC03FuvJfcYCq0T980gWlxS7jIkSD7KU1uWD7?=
 =?us-ascii?Q?uKmcmRZtyufQMhZIucXf95Y9G8hRp7Lr37lbA5HnUKPLgNt1Mfn0NTiPUs77?=
 =?us-ascii?Q?he4d9xjJT2dGFeXqgL6yvHjijRr0ArKjGdMqpPSN7993He0L6V7N+g5fzvYy?=
 =?us-ascii?Q?SRG81d5caQCaHxcfY0HI8o/cyTvr+VWRshohvz/uQJlSN/KiX/g/atJLORIZ?=
 =?us-ascii?Q?hZ8K3bUip/TqV2ytauq3CSa1ZCUHyG8I2ETVp8sOSQ79FfTkbrdqCSKH749n?=
 =?us-ascii?Q?16F1f6G/WNwYbTI9Bz08u/awi1idmUZzfMwYkxEYCkDXZncZrTj7T/BwPXpD?=
 =?us-ascii?Q?25ZPdYq4y4Broo61xmccCPNts+DUMrg/9NHH7T6YmRsbLXu7KxywYTdokDO6?=
 =?us-ascii?Q?6HFnZesL+b3u8kyQyC45ZTTXVqhuvEon7oY4IKr1kPfFxs6jXT6VxDbP22cl?=
 =?us-ascii?Q?SXJrBM/5+9hrQRDZcHHPeDFVByeKxTZoZRXCWuNT50/jRi+uXtog8EHHdhy8?=
 =?us-ascii?Q?AHVo8V0YAys4MJ7Zpa6U3BzVw+SQDYctnWJd+OzKAFC+Yt7cdP0sEdS+mTVE?=
 =?us-ascii?Q?OlU3gimgKFQ32VrLp7QS5vRtQTanCCAq+sI/pVQ1FuZg27VLfS7zvtdcopyt?=
 =?us-ascii?Q?naE2JyHhI0+XIN/l6wZj7L4IbNGAImv4Ru1ilDDcNXbw6fbhQDncFXqJMLws?=
 =?us-ascii?Q?EaivEYtUXpMqijkKvszvLdAqRijUszZ5FWWk3IGELYv82kPRg/XJ1PlXcRML?=
 =?us-ascii?Q?z0VdoL89fLH4AHfqR+lmEsOLA9Nm0RBofzaveNOlPXxHeW1IQkoyu2f3a+4+?=
 =?us-ascii?Q?9Qps0w8mntUbbpQIRO52wMPBPztKOgGdYuUVXt0ecxgYEq2ugiPO2ygZtY25?=
 =?us-ascii?Q?Cg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	E9kBKqjV5ARadFEmL2rt6Rwduju1Z1lvhP64SqKmxx/yJtiuZXPzR1btXCli73g22LkZIGeBKw+EwIeDPRg623usssZ+mMzrRhZItQvrUlzzOzoPPOr9Wk0DQvw/EWI9+wS0Zl4MIWaxJO5iUZNEceWU+IO6q7TEttUSlxWQgmnHL+Ohkp9EZplI/9T0qsBt3cG+iV6/CNNfeotHEo+WLg8CdDMXdwe1ZLeqzDsRdWCsUX2Z347XhQfKpGB9bb1jQPaWE8eDwczOR894zyqW6IUdAb8a4Dzm3gv9DFTpvdnNySKirWghcbYZnxtkWo7Q0F7YuK0Ljc9ahG/JSWajtbQl1ZOIi+WU4WQNKwpl7NfqWaqFntJ/2+hjw2Nd05YcmNZltZL3aH+g8XGAGKn9W4AdCsYi2uP3FgbhwooskMy0U86IpM8FKSoPBZljHV4uCILckYMC8dLy23c+D0c7mcNp6keDfct/CRpeUzNzmOd50HGZfuGOrnRtRIdFcaMH26mdjb31RdCUtzjhRLuKrfsimhHibQK9AL7iQF9HJ95s2LK7oK3V+chvJEyYwdftOjQstKNf9CgvkRCBwozZwi8eK3kIlC5VrQdBUCBiU14=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd5a4d6f-0320-49f5-4815-08dcdd84320e
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2024 17:05:02.6231
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6+E/vcKcu17jVM87tVWvJPL1Q826+hcbfA4fYZrlMM67arnVHVlTha/02lV6tfuayw1lhmKVAr/RLO/16lo36ySh3tK50CEOJjOc+JAz8jg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4247
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-25_11,2024-09-25_02,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 phishscore=0 mlxscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2409250121
X-Proofpoint-ORIG-GUID: p8RuW0orLtDqbypL_FirEevV3b46iC4a
X-Proofpoint-GUID: p8RuW0orLtDqbypL_FirEevV3b46iC4a

On Wed, Sep 25, 2024 at 09:19:17AM GMT, Shakeel Butt wrote:
> I have no idea what makes you think I am blocking the feature that you
> repond in a weird tone but let me be upfront what I am asking: Let's
> collectively decide which is the better option (in terms of
> maintainability and extensibility) and move forward.

I'm not sure what you mean by 'weird tone'... perhaps a miscommunication?

To summarise in my view - a suggestion was made to, rather than provide the
proposed flag - a pidfd sentinel should be introduced.

Simply introducing a sentinel that represents 'the current process' without
changing interfaces that accept a pidfd would be broken - so implementing
this implies that _all_ pidfd interfaces are updated, as well as tests.

I suggest doing so is, of course, entirely out of the scope of this
change. Therefore if we were to require that here - it would block the
feature while I go work on that.

I think this is pretty clear right? And I also suggest that doing so is
likely to take quite some time, and may not even have a positive outcome.

So it's not a case of 'shall we take approach A or approach B?' but rather
'should we take approach A or entirely implement a new feature B, then once
that is done, use it'.

So as to your 'collectively decide what is the better option' - in my
previous response I argued that the best approach between 'use an
unimplemented suggested entirely new feature of pidfd' vs. 'implement a
flag that would in no way block the prior approach' - a flag works better.

If you can provide specific arguments as to why I'm wrong then by all means
I'm happy to hear them.

>
> On Wed, Sep 25, 2024 at 03:48:07PM GMT, Lorenzo Stoakes wrote:
> > On Wed, Sep 25, 2024 at 07:02:59AM GMT, Shakeel Butt wrote:
> > > Cced Christian
> > >
> > > On Tue, Sep 24, 2024 at 02:12:49PM GMT, Lorenzo Stoakes wrote:
> > > > On Tue, Sep 24, 2024 at 01:51:11PM GMT, Pedro Falcato wrote:
> > > > > On Tue, Sep 24, 2024 at 12:16:27PM GMT, Lorenzo Stoakes wrote:
> > > > > > process_madvise() was conceived as a useful means for performing a vector
> > > > > > of madvise() operations on a remote process's address space.
> > > > > >
> > > > > > However it's useful to be able to do so on the current process also. It is
> > > > > > currently rather clunky to do this (requiring a pidfd to be opened for the
> > > > > > current process) and introduces unnecessary overhead in incrementing
> > > > > > reference counts for the task and mm.
> > > > > >
> > > > > > Avoid all of this by providing a PR_MADV_SELF flag, which causes
> > > > > > process_madvise() to simply ignore the pidfd parameter and instead apply
> > > > > > the operation to the current process.
> > > > > >
> > > > >
> > > > > How about simply defining a pseudo-fd PIDFD_SELF in the negative int space?
> > > > > There's precedent for it in the fs space (AT_FDCWD). I think it's more ergonomic
> > > > > and if you take out the errno space we have around 2^31 - 4096 available sentinel
> > > > > values.
> > > > >
> > > > > e.g:
> > > > >
> > > > > /* AT_FDCWD = -10, -1 is dangerous, pick a different value */
> > > > > #define PIDFD_SELF   -11
> > > > >
> > > > > int pidfd = target_pid == getpid() ? PIDFD_SELF : pidfd_open(...);
> > > > > process_madvise(pidfd, ...);
> > > > >
> > > > >
> > > > > What do you think?
> > > >
> > > > I like the way you're thinking, but I don't think this is something we can
> > > > do in the context of this series.
> > > >
> > > > I mean, I totally accept using a flag here and ignoring the pidfd field is
> > > > _ugly_, no question. But I'm trying to find the smallest change that
> > > > achieves what we want.
> > >
> > > I don't think "smallest change" should be the target. We are changing
> > > user API and we should aim to make it as robust as possible against
> > > possible misuse or making uninteded assumptions.
> >
> > I think introducing a new pidfd sentinel that isn't used anywhere else is
> > far more liable to mistakes than adding an explicit flag.
> >
> > Could you provide examples of possible misuse of this flag or unintended
> > assumptions it confers (other than the -1 thing addressed below).
> >
> > The flag is explicitly 'target this process, ignore pidfd'. We can document
> > it as such (I will patch manpages too).
> >
> > >
> > > The proposed implementation opened the door for the applications to
> > > provide dummy pidfd if PR_MADV_SELF is used. You definitely need to
> > > restrict it to some known value like -1 used by mmap() syscall.
> >
> > Why?
> >
> > mmap() is special in that you have a 'dual' situation with shmem that is
> > both file-backed and private and of course you can do MAP_SHARED |
> > MAP_PRIVATE and have mmap() transparently assign something to you, etc.
> >
> > Here we explicitly have a flag whose semantics are 'ignore pidfd, target
> > self'.
> >
> > If you choose to use a brand new flag that explicitly states this and
> > provide a 'dummy' pidfd which then has nothing done to it - what exactly is
> > the problem?
>
> IMHO having a fixed dummy would allow the kernel more flexibility in
> future for evolving the API.

OK. I agree with having a fixed dummy value as stated.

>
> >
> > I mean if you feel strongly, we can enforce this, but I'm not sure -1
> > implying a special case for pidfd is a thing either.
> >
> > On the other hand it would be _weird_ and broken for the user to provide a
> > valid pidfd so maybe we should as it is easy to do and the user has clearly
> > done something wrong.
> >
> > So fine, agreed, I'll add that.
> >
>
> No, don't just agree. The response like "-1 is not good for so and so
> reasons" is totally fine and my request would be add that reasoning in
> the commit message. My only request is that we have thought through
> alternatives and document the reasonsing behind the decided approach.

I didn't just agree, as I said, my reasoning is:

	On the other hand it would be _weird_ and broken for the user to
	provide a valid pidfd so maybe we should as it is easy to do and
	the user has clearly done something wrong.

If we're in alignment with that then all good!

>
> > >
> > > >
> > > > To add such a sentinel would be a change to the pidfd mechanism as a whole,
> > > > and we'd be left in the awkward situation that no other user of the pidfd
> > > > mechanism would be implementing this, but we'd have to expose this as a
> > > > general sentinel value for all pidfd users.
> > >
> > > There might be future users which can take advantage of this. I can even
> > > imagine pidfd_send_signal() can use PIDFD_SELF as well.
> >
> > I'm confused by this comment - I mean absolutely, as I said I like the
> > idea, but this just proves the point that you'd have to go around and
> > implement this everywhere that uses a pidfd?
> >
> > That is a big undertaking, and not blocked by this change. Nor is
> > maintaining the flag proposed here egregious.
>
> By big undertaking, do you mean other syscalls that take pidfd
> (pidfd_getfd, pidfd_send_signal & process_mrelease) to handle PIDFD_SELF
> or something else?

I mean if you add a pidfd sentinel that represents 'the current process' it
may get passed to any interface that accepts a pidfd, so all of them have
to handle it _somehow_.

Also you'll want to update tests accordingly and clearly need to get
community buy-in for that feature.

You may want to just add a bunch of:

if (pidfd == SENTINEL)
	return -EINVAL;

So it's not impossible my instincts are off and we can get away with simply
doing that.

On the other hand, would that be confusing? Wouldn't we need to update
documentation, manpages, etc. to say explicitly 'hey this sentinel is just
not supported'?

Again totally fine with the idea, like it actually, just my instincts are
it will involve some work. I may be wrong.

>
> >
> > Blocking a useful feature because we may in future possibly add a new means
> > of doing the same thing seems a little silly to me.
> >
>
> Hah!!

See top of mail.

>
> > > >
> > > > One nice thing with doing this as a flag is that, later, if somebody is
> > > > willing to do the larger task of having a special sentinel pidfd value to
> > > > mean 'the current process', we could use this in process_madvise() and
> > > > deprecate this flag :)
> > > >
> > >
> > > Once something is added to an API, particularly syscalls, the removal
> > > is almost impossible.
> >
> > And why would it be such a problem to have this flag remain? I said
> > deprecate not remove. And only in the sense that 'you may as well use the
> > sentinel'.
> >
>
> My point was to aim for the solution where we can avoid such scenario
> but it is totally understandable and acceptable that we still have to go
> through deprecation process in future.
>
> > The flag is very clear in its meaning, and confers no special problem in
> > remaining supported. It is a private flag that overlaps no others.
> >
> > I mean it'd in effect being a change to a single line 'if pidfd is sentinel
> > or flag is used'. If we can't support that going forward, then we should
> > give up this kernel stuff and frolick in the fields joyously instead...
> >
> > Again, if you can tell me why it'd be such a problem then fine we can
> > address that.
> >
> > But blocking a series and demanding a change to an entire other feature
> > just to support something I'd say requires some pretty specific reasons as
> > to why you have a problem with the change.
> >
> > >
> > > Anyways, I don't have very strong opinion one way or other but whatever
> > > we decide, let's make it robust.
> >
> > I mean... err... it sounds like you do kinda have pretty strong opinions ;)
>
> I am not sure how more explicit I have to be to but I am hoping now it
> is more clear than before.

I mean perhaps I misinterpreted you as strongly advocating for the sentinel
and your intent was rather to provide argument on that side also so the
community can decide as you say - sure.

But with you indifferent as you say as to which way to go, and my having
provided arguments for the flags (again happy to hear push-back of course)
- I suggest we go forward with the series as-is, other than a fixpatch I'll
send for the -1 thing.

>
> Shakeel

Thanks for your review!


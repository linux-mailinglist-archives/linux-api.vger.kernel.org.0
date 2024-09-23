Return-Path: <linux-api+bounces-2319-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8579497EED7
	for <lists+linux-api@lfdr.de>; Mon, 23 Sep 2024 18:04:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB6EB1C2157F
	for <lists+linux-api@lfdr.de>; Mon, 23 Sep 2024 16:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC41B19F108;
	Mon, 23 Sep 2024 16:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Z3z5Ci3Q";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="KcZEe/6x"
X-Original-To: linux-api@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE10F19EEC9;
	Mon, 23 Sep 2024 16:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727107473; cv=fail; b=FkrTfeW29qJ8MQ4LGLVidAdi+JQAsvAfQPM90q0uNLpulh3eI2Z8E13Q5X6GFUVDYFpBweIQR6FNnTyG9QftBl8U78arunHBbomgpaWh+9+ksX4usXcKG0jSHemR+9g/srUEApsXVlNqf9LUP6dEde1mVIw4thLy0WBJHJ7Wi/I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727107473; c=relaxed/simple;
	bh=rg3TAgRDLBFS3ZbhpiPvDEe10pTVJyd+IVF5lk3jKgU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VO5oA+sC/CbH57oE8tj8Ad39E7Rxc5Rw+TGPE4DfsCTIad0mLG1M02m3SuPc5mvL7K4YQqJNp7CnxwmLiqJXK8Jf4Kah9voWzc/K7NOX84mQ92J8jf87MeArdIArhGDwn/YWXNpmJi7ACDXpXnJpOPw4+XiaeptEsEN4r/wMpCM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Z3z5Ci3Q; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=KcZEe/6x; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48NFtXhk021790;
	Mon, 23 Sep 2024 16:04:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=xZeDwn2PWu8UYuFKltEJq/RpzlHL3GN0BRBf7w2ydCY=; b=
	Z3z5Ci3QvDcARDcbBc84JiKwInr3Yk+/L3MXiNq23BH9MpEzYu+QMtNRrC/YOOIY
	JM5w3gyCsl3c8+Pjw7ywvbdZzeN2TBJ5aR8ji4pJZlF+UZD2rD/GY2Bc9Ag07RRs
	cBldrfKK2O7nqvw2CxAHrRGckp0nwJsz+2xPkCpiLmeATzrDs1lnLHSVGcVGXWuu
	pWF5eZH95sO5kKx7+pwibKmfuTQQKxez9GHOfzXd9sUmL9ClEq4oZMebrq86GvZT
	RRPZkvw+Y+AIwp7YkqH0DOyJn6Kq9zHHViZIUY3roCMWRrtMRkupATIvTvn6boNz
	4YwdaSju1Ywhnrs+OweU6Q==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41smx32q4a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Sep 2024 16:04:12 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48NFUejg000461;
	Mon, 23 Sep 2024 16:04:12 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2045.outbound.protection.outlook.com [104.47.55.45])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41smk7qpkr-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Sep 2024 16:04:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jf6P48mGil8mw3zglHadaQ1SAh5Jh9AA5hDtunb7tdnjjOG1eqvgWHJu3aSHBRjOzXNlSdjVBzgRNKCc3nNRU7HS3J4dypsYiccYHOf1Ynzf7VGIGv3Ffd/ZTUZYm7W4LFo3SU4jPpsopXm3Spn7Rfq6jjh2zleE87qwQJ4w2xCEc+uaK+jEGjYvqh+Qd2rmnok7xElKySrKBa1n3iJN/PwsbdmruUPDl6apd7AW11jqGCY6Nk7qctYU35h/bvbfUCytMGEpziAcO+jH3f0pZACYWfaXuVGQL2Mx6H3D6Vhhcx3L5+/SiUVe3Jbmcjv7CytINbxUhvaWqn9d/nFojg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xZeDwn2PWu8UYuFKltEJq/RpzlHL3GN0BRBf7w2ydCY=;
 b=qI6JmJ1vlW0LrW5BmmZ5V1jwyQVxyn5YvT5ROBOn9wRMZvN0uJNwS8dX70H0mspLUaIQ8H0NT35juD0jHpBDabpT2/d1CqesruOu3BWGzo896IhGFsPAMamonrdJli7PuKLqGQUfml7wIH9UW8yxllP92kz7JdA+HQmaMJETqz7xm4zY1LKTljzdTbqaN8FBHKXeCRkBqGsxUinHXW2uCtFaOJA7SuDnvjRFJ0K1h0oiSYH/jmnHrveOWhQ0Fgqh397HA3DuiHlu3V7He51KtT6IeEeH4yLbAph1TwVIzHD/XuzzFSpWd1IBX3enwcsAMZoVD61OY9iXCiBA6fWbmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xZeDwn2PWu8UYuFKltEJq/RpzlHL3GN0BRBf7w2ydCY=;
 b=KcZEe/6xW9qVLI0n35boO+mUXxmipQY+cGMnj5pr7dFjkq2p6meSz8IzkDmFE6X91T05rQgdI5AVlPcgliQ9S/Uj2lGFGA3DTH7S4lEm5JhRqzRn2uIFboqR5ObB2x+i3BthFTElUVLH7ODjQbsHo+XdTz7QesaEtZGU1KmUgrA=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by DM4PR10MB6744.namprd10.prod.outlook.com (2603:10b6:8:10c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.13; Mon, 23 Sep
 2024 16:04:09 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.8005.010; Mon, 23 Sep 2024
 16:04:09 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Vlastimil Babka <vbabka@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Suren Baghdasaryan <surenb@google.com>, Arnd Bergmann <arnd@arndb.de>,
        Shakeel Butt <shakeel.butt@linux.dev>, linux-api@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Minchan Kim <minchan@kernel.org>
Subject: [PATCH 2/2] selftests/mm: add test for process_madvise PR_MADV_SELF flag use
Date: Mon, 23 Sep 2024 17:03:57 +0100
Message-ID: <07d65076cb1632a67043b70bbcec8e450d5b8fb7.1727106751.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1727106751.git.lorenzo.stoakes@oracle.com>
References: <cover.1727106751.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0640.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:296::21) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|DM4PR10MB6744:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d73c895-864a-45b0-79e8-08dcdbe95bc6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|10070799003|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?irAcSunEduZxK15oui3zM+XZAjh4tFJjZgRXp1y5skI8uIiIayvkbycAdsdG?=
 =?us-ascii?Q?UxLoS1e9xIC4H01ioGSF7DIxxYv4D3MHzAVv1rJ+QvOYQwP2jHNJd/AkpkWt?=
 =?us-ascii?Q?vB2m5yDnfGABboCgJLugWGv1+CCKZK/Cm/1wxEg8eYRm5I12ZxWdDA2+oB33?=
 =?us-ascii?Q?SmrY1vEwWFYKQl+32hj5A8d0EoH3gjAVfil/Kc9YxNTdMbWr1F+PSmOo3ZYG?=
 =?us-ascii?Q?jYnvnJn8mcClzFX15q9ZUf4efrFp9w5SkBI9tMZbh2i+cMP4kKvPEBl5qLSd?=
 =?us-ascii?Q?N5BC6SYhCba4mQj4u5nJSLjQcMO3MLR857EXovff/9Mexa6KJVMr/kxIEjUD?=
 =?us-ascii?Q?e9iKWlraGHVLru17ub6JZeg7yxy0SRkMYrCMP4VjvJvMlw8bTflU2ebugiIT?=
 =?us-ascii?Q?GlTzhbSVFqdE6JGk+9+JH+rxZawhy4IVGe6QCAkXWeUJjP5Mq6EteFJB3XTY?=
 =?us-ascii?Q?GQTVs1/Va5AqrL/f7wMZSz4uOzHqhUNoz06558b2YMlOqK89J91OD7oZ2aHe?=
 =?us-ascii?Q?at3nCvmDQc7L+arjagDlobvD9JK15tlw2XjOWChV/+u+YyLcep+RVu0iLFT1?=
 =?us-ascii?Q?ig5Mr/6s7B5HJp44uJw0oEcX06RMPsJcD3sCVf3zunKQmDD95jWNmVjeEHnP?=
 =?us-ascii?Q?HgirB/Wk2Mfs7OYWUZkdL8kwV1irdvGrUkJA70neKgXcSVukuxQa89coSK3v?=
 =?us-ascii?Q?AaUh+W3v8+dMQ6geauqhsq+VN+uJpdG8WzMjXOzbFnU0SeA1L+6nW6B+CKBE?=
 =?us-ascii?Q?HBBv246fjzpfkWt76f8cSrMTGxgmDuDiT79mfrdoznS0b8f206/NBzCRG3to?=
 =?us-ascii?Q?CyYpiCjttXh4ORdIqjMvMfvDosgpghPRS/O81l52r4t9a5cdbTvAnVXw/vAF?=
 =?us-ascii?Q?2Z/lc5eBV8hKvaFya/W6jJYI0yUa7oanCYG9wCrweLNcjU5gFiSjVzirzYRW?=
 =?us-ascii?Q?8EeMUNtykWCqMEEBR0OEyZjvD1GSe+r9izYL+hjCiu+t7dzInnLyu9WlB5D1?=
 =?us-ascii?Q?TavtKEcHWm89spJ6uSaLKfQKtOTLI0KRHPb2GoOSiZp3vx7SpAFR2rh7EDkK?=
 =?us-ascii?Q?92M9bvWmTGmEQ+KfvCE4A+23vGSROSm8Tipf0lALIGW5jLnK7rQ07yuvLEWB?=
 =?us-ascii?Q?dWUIAd9F63Mkz17Z3+bquPecdvg/6k/PT2bELDfQoc9p20tpvU+sWWMIQjoa?=
 =?us-ascii?Q?+IVJu/V4//Ir4hadPZMxw1iASHYkQ2mHbI4V+q3fHxIYVpPznbAK9kqSu/V5?=
 =?us-ascii?Q?f8CyMP95x8ueBU2cjLQlkxgKbD/YkmX5sFe8q59YzKAkugQllBSpXyYJpKGs?=
 =?us-ascii?Q?JCv8NFlNOrSc7RLR1FRwrnhjVt5biL3XsmqInIm5+IAzTg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?J51PnNrzHeBy6qqilOStJgR7xOctCD/BAgWglYn6AaROT2kOH0GbSDi77kx9?=
 =?us-ascii?Q?6fDdMwx/0VAgsbjWzMysia7WrjGF713Zdvq+v8osSEewcWvzECaqqV51RBj6?=
 =?us-ascii?Q?is+6Oe8PwSgtg+JCzqvomnPy7wyyrxRp9P17MpB8mH03aVckIE7M/7e+c6O0?=
 =?us-ascii?Q?0FOcjLgx7jzVyJlKZG8nYud4Ob+W2IKWn5LgbeG6ky93h0qm9yEZfcY1Juus?=
 =?us-ascii?Q?N80dSnr2BVuJyNaNGHQNFgNAHsQxaMArWAqP6WqKaZYw1rTRXZsRj95mez3K?=
 =?us-ascii?Q?DgoWN6K6DCv2+9ySg3xghU7LgK5gvmCm79XNE1OrRxbpDTHzygF7B1za/6P4?=
 =?us-ascii?Q?Aez3GI6lTXk9HkwG1BwX5vkxY9uvj1WNFKGZeHqrWOia0VCYTRHGTu6R3WJO?=
 =?us-ascii?Q?Yt8gz0bKxtM0ZiPl1p6nFdWoHADABzt75IwFEaspreE7+GXPJa7D4sncreuC?=
 =?us-ascii?Q?FhJNUYnuQOVBw9O1Cjh0dNTGeojQ6Yu8QI+U03c/Io7tOdYMOE14Y0j0eW5b?=
 =?us-ascii?Q?Zb5Wg0a9fLIpX2NYGTCFkizflh56lloIkyW5ZbdlMba2MJCSJJJ58wkiV2jO?=
 =?us-ascii?Q?XTJFTS9ihG36+ZAAykTwpWnDM7ecuCg07BlNJcy+NWJ3GDt3aWcBLg31ocG0?=
 =?us-ascii?Q?A+UUSWKMhi95rexJZLkGsLr8aSW5X9dqnirlXVQa+RihVJVcJO2uGOyXwX74?=
 =?us-ascii?Q?N9nd5jnBZvICqirez7e3Qi2YO8OTig2tJmMDZRuJVroqe7gWkyXnZTihPLis?=
 =?us-ascii?Q?9b96aRaP/VWTvcGUPXBQpqLIcAr88UM3y0zKNS0tCECwNecLaTJ1RkrdQIex?=
 =?us-ascii?Q?mMahNAVHJHj05BiB9ygqV+i1hRctV/yDIx99B1LMMQM6OLxJxaSF2P2X95pR?=
 =?us-ascii?Q?9Kd/Ai46FtTFfB0747lTPREVnVwcpi5mmFn5nPsgFqq8SWgqxsn6hqCOm9B2?=
 =?us-ascii?Q?CfG/8kXKjnrO19Ur+nQKGPNb3m1a3ag5MTtRCHQm/pmCWUSChmiAgTNySj7h?=
 =?us-ascii?Q?RzNoEc6Ozb3aPdpk55mPxygBD3tBQY1ZuUcs9K6VHcL3oqJT/QtFAABYygTO?=
 =?us-ascii?Q?MqNfGTvIXbnrqYkSxyoDlQFF/GBUtj++pr1oIKoa/6n7TuAc5Sa1T3WQfuH7?=
 =?us-ascii?Q?sjEdDy4rLbaguf2kn4E/qIuQ0ebX+AdAlckabRT4uTDvcgI4tvxXpMoOTEwP?=
 =?us-ascii?Q?1e4IuUuAJ2bXMIMNL6pCOpAvSafQiRUGhTNySeE5jiHg2nYp5wFLB61Ain5W?=
 =?us-ascii?Q?QRnjS6VNIuy4hZ4ioK9iewVtuJ8saRlI2bJSQ4kCBakmonfZTR01o3+0pn5Z?=
 =?us-ascii?Q?TN+SJ1Z418hl8/zkpsdt7e6vtTFj5Abt91ByOQnQlHuzNkCTkbOMOmgjb87N?=
 =?us-ascii?Q?rGWsuVKW/I1hxisGy5ezwXsNKgeovRzPU6mmk2SlX9C0EX75hf6BHSA8ByXZ?=
 =?us-ascii?Q?HmmohyyxOC0zAw+mnyK3rnzTUt4fPe1z2PpBWKL4Th73jZ0IxA5gKigkBr19?=
 =?us-ascii?Q?pHCNtLt6+g3X1HW+7UEEMgPXOmRT9VSXSG54Y6870+Aee7rsb3TN2Fm53yXY?=
 =?us-ascii?Q?8Uxqyt9dpimv8cJsytE6ci4xbUmcclfYiWca9wWqPtjxsK4T0DMITPqbIm/D?=
 =?us-ascii?Q?sVvDWhso9hBvMRkWf7vF5vOdSoCBhXNylE9wpTEmhO8Ug9eSN8XfhPVSvhIg?=
 =?us-ascii?Q?00+wWw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	35F5tZRQUz+t6Q+4klRS85eQStmsuTSrIffgELSbzvvsVUjj/p+lHXvjTdJEHqpO3o58MvdB3NWVys2lzLntmcBXeLvr4dWeMSKHMDBTbUD8WnRxckRB6esHoMD9bKHdTTqXpCSS9ecdYik2gPxxBC9dqRY6OJqQo18uxcW5109mXWp6YFewnngkHipBGu7ZpHh4eDOWOAKwOxiaZ/IKcDP1Pp+90fjo/ljViZB2HyNtVyEWaaY1nehlC6uHjtHoL0fT0/AAbkZPIHtlbGn8zCFVj+0sAkGvkZHvM3ezJFzH2J+ip+eNKQwZliLEQMw1hcMiZKZzwxcU/S71/C1l7g6Lkx0jFGoedIK3hIALKfPXkN3gbU/4LO5+vEk11OKzmuD3bgdjVexayEKlgEZYHYyamx5SPCZXOcTqcAj80HKXi18uzFO3XZoKQXbLI5x9mpNLcXggp+U6BuaMcp5anD+8jb8bAuA5WP7gEd0sdo/8Vx7BL3aD+foC6yv7xUReEokVTKGFnh82gJaBIZvOn3YRg/usBJ7q3cOWxdYWGMxitZtf2ZolK88j9qt+fu/LTyX+ulvJNSrlZK57+tJ+W7UEDN05hy3ddMoIXNQZTdI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d73c895-864a-45b0-79e8-08dcdbe95bc6
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2024 16:04:09.4260
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7oOrepPtiEsAShj2znTUld/aMb/SuKyTg6ulVbeq4uPv1h0fHco+ASi+Tur3H5beodgs/ENXZ7ntbW9ZBiKMYUzAvHyOph67tf1XDiT35aw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6744
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-23_12,2024-09-23_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 malwarescore=0 mlxscore=0 bulkscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2409230120
X-Proofpoint-ORIG-GUID: rrPXbEMX6V55EjXN4jVsHtEw7xKEkHpX
X-Proofpoint-GUID: rrPXbEMX6V55EjXN4jVsHtEw7xKEkHpX

Add a new process_madvise() selftest, and add a test for the newly
introduced PR_MADV_SELF flag.

Assert that we can perform a vector operation of an operation that would
not be permitted on a remote mm (MADV_DONTNEED in this instance) on ones in
our own mm and that the operation is correctly peformed.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 tools/testing/selftests/mm/.gitignore        |   1 +
 tools/testing/selftests/mm/Makefile          |   1 +
 tools/testing/selftests/mm/process_madvise.c | 115 +++++++++++++++++++
 3 files changed, 117 insertions(+)
 create mode 100644 tools/testing/selftests/mm/process_madvise.c

diff --git a/tools/testing/selftests/mm/.gitignore b/tools/testing/selftests/mm/.gitignore
index da030b43e43b..a875376601b7 100644
--- a/tools/testing/selftests/mm/.gitignore
+++ b/tools/testing/selftests/mm/.gitignore
@@ -51,3 +51,4 @@ hugetlb_madv_vs_map
 mseal_test
 seal_elf
 droppable
+process_madvise
diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selftests/mm/Makefile
index 02e1204971b0..7503ec177cd2 100644
--- a/tools/testing/selftests/mm/Makefile
+++ b/tools/testing/selftests/mm/Makefile
@@ -79,6 +79,7 @@ TEST_GEN_FILES += hugetlb_fault_after_madv
 TEST_GEN_FILES += hugetlb_madv_vs_map
 TEST_GEN_FILES += hugetlb_dio
 TEST_GEN_FILES += droppable
+TEST_GEN_FILES += process_madvise
 
 ifneq ($(ARCH),arm64)
 TEST_GEN_FILES += soft-dirty
diff --git a/tools/testing/selftests/mm/process_madvise.c b/tools/testing/selftests/mm/process_madvise.c
new file mode 100644
index 000000000000..7a29b77d837d
--- /dev/null
+++ b/tools/testing/selftests/mm/process_madvise.c
@@ -0,0 +1,115 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#define _GNU_SOURCE
+#include "../kselftest_harness.h"
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/mman.h>
+#include <sys/uio.h>
+
+/* May not be available in host system yet. */
+#ifndef PR_MADV_SELF
+#define PR_MADV_SELF	(1<<0)
+#endif
+
+FIXTURE(process_madvise)
+{
+	unsigned long page_size;
+};
+
+FIXTURE_SETUP(process_madvise)
+{
+	self->page_size = (unsigned long)sysconf(_SC_PAGESIZE);
+};
+
+FIXTURE_TEARDOWN(process_madvise)
+{
+}
+
+static void populate_range(char *ptr, size_t len)
+{
+	memset(ptr, 'x', len);
+}
+
+static bool is_range_zeroed(char *ptr, size_t len)
+{
+	size_t i;
+
+	for (i = 0; i < len; i++) {
+		if (ptr[i] != '\0')
+			return false;
+	}
+
+	return true;
+}
+
+TEST_F(process_madvise, pr_madv_self)
+{
+	const unsigned long page_size = self->page_size;
+	struct iovec vec[3];
+	char *ptr_region, *ptr, *ptr2, *ptr3;
+
+	/* Establish a region in which to place VMAs. */
+	ptr_region = mmap(NULL, 100 * page_size, PROT_NONE,
+			  MAP_PRIVATE | MAP_ANON, -1, 0);
+	ASSERT_NE(ptr_region, MAP_FAILED);
+
+	/* Place a 5 page mapping offset by one page into the region. */
+	ptr = mmap(&ptr_region[page_size], 5 * page_size,
+		   PROT_READ | PROT_WRITE,
+		   MAP_FIXED | MAP_ANON | MAP_PRIVATE, -1, 0);
+	ASSERT_NE(ptr, MAP_FAILED);
+	populate_range(ptr, 5 * page_size);
+	vec[0].iov_base = ptr;
+	vec[0].iov_len = 5 * page_size;
+	/* Free the PROT_NONE region before this region. */
+	ASSERT_EQ(munmap(ptr_region, page_size), 0);
+
+	/* Place a 10 page mapping in the middle of the region. */
+	ptr2 = mmap(&ptr_region[50 * page_size], 10 * page_size,
+		    PROT_READ | PROT_WRITE,
+		    MAP_FIXED | MAP_ANON | MAP_PRIVATE, -1, 0);
+	ASSERT_NE(ptr2, MAP_FAILED);
+	populate_range(ptr2, 10 * page_size);
+	vec[1].iov_base = ptr2;
+	vec[1].iov_len = 10 * page_size;
+	/* Free the PROT_NONE region before this region. */
+	ASSERT_EQ(munmap(&ptr_region[6 * page_size], 44 * page_size), 0);
+
+	/* Place a 3 page mapping at the end of the region, offset by 1. */
+	ptr3 = mmap(&ptr_region[96 * page_size], 3 * page_size,
+		    PROT_READ | PROT_WRITE,
+		    MAP_FIXED | MAP_ANON | MAP_PRIVATE, -1, 0);
+	ASSERT_NE(ptr3, MAP_FAILED);
+	populate_range(ptr3, 3 * page_size);
+	vec[2].iov_base = ptr3;
+	vec[2].iov_len = 3 * page_size;
+	/* Free the PROT_NONE region before this region. */
+	ASSERT_EQ(munmap(&ptr_region[60 * page_size], 36 * page_size), 0);
+	/* Free the PROT_NONE region after this region. */
+	ASSERT_EQ(munmap(&ptr_region[99 * page_size], page_size), 0);
+
+	/*
+	 * OK now we should have three distinct regions of memory. Zap
+	 * them with MADV_DONTNEED. This should clear the populated ranges and
+	 * we can then assert on them being zeroed.
+	 *
+	 * The function returns the number of bytes advised, so assert this is
+	 * equal to the total size of the three regions.
+	 */
+	ASSERT_EQ(process_madvise(0, vec, 3, MADV_DONTNEED, PR_MADV_SELF),
+		  (5 + 10 + 3) * page_size);
+
+	/* Make sure these ranges are now zeroed. */
+	ASSERT_TRUE(is_range_zeroed(ptr, 5 * page_size));
+	ASSERT_TRUE(is_range_zeroed(ptr2, 10 * page_size));
+	ASSERT_TRUE(is_range_zeroed(ptr2, 3 * page_size));
+
+	/* Cleanup. */
+	ASSERT_EQ(munmap(ptr, 5 * page_size), 0);
+	ASSERT_EQ(munmap(ptr2, 10 * page_size), 0);
+	ASSERT_EQ(munmap(ptr3, 3 * page_size), 0);
+}
+
+TEST_HARNESS_MAIN
-- 
2.46.0



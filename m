Return-Path: <linux-api+bounces-2318-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41D7697EED5
	for <lists+linux-api@lfdr.de>; Mon, 23 Sep 2024 18:04:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77620B2168B
	for <lists+linux-api@lfdr.de>; Mon, 23 Sep 2024 16:04:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B2BD19D067;
	Mon, 23 Sep 2024 16:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mzt+b9+p";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="UggMc2kG"
X-Original-To: linux-api@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B3E31990C5;
	Mon, 23 Sep 2024 16:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727107468; cv=fail; b=RClKzREL0BEjWxYeJ2Oo8MRO4VMMjnaZQIct58UDGvdHtF22hwm9AIUiRBMgstuqq6c/o1Xpbrqvivap1M5zWel57ZoaSGMng2T9gHuA8Mjln8R/uTR4T3lcLQSNFkzszvhL8c6v6aTni+mHFxMfo8H7npolKQ5iMyCEsZKSVqk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727107468; c=relaxed/simple;
	bh=tEhCg8hV0UpA9kt+LOaI99WK2NipCuPx3LJ8F9Bd51s=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=IJwPg/XmkkaIOpfTbUqVLdwXAzytRgcj2fIYp/tzYXIAe6IDYd4bU+fiSjQiyO18enTTs2hlvd7vYz+58qBCcwirVdbvLBU3lubgi/C0jzNC2CWFd+ak6UmdbAAO01OzFkJ3EoIiscp6v+zLCB6NxHbPZOxUVUIag1xdurBnqGY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mzt+b9+p; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=UggMc2kG; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48NFtZXB012334;
	Mon, 23 Sep 2024 16:04:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:content-transfer-encoding
	:content-type:mime-version; s=corp-2023-11-20; bh=mZ+aU5UZcVqTdB
	zvkHuzXvSJY72J51Ci/yzu8mZGWT0=; b=mzt+b9+pXnsI1z/7HfGxCv6XZVFwoZ
	nuFZKK8QN8HMmttfKtHBftowolWSNLykzxLxk7XCHQJKJR8Po1BPFz9HooE7eqOD
	fx2oMB1rQVNVM1cdMsfx9KcMpCCKV+n8mByyPsCVI88SBepe9TDxo9r2dwBkdKMF
	rCC4hGQOJUkYPuQ8/1kkZWiM+hREU1POoFiJNbKCsi6qGMIvwKr+EYQsAVx5/Uro
	SFcoRL+q1KbPfAPAUpmDCyhaZZI8jGE8dqAdOznPAkqkfQXoUf7qYviIBwDq+2op
	KcI6yyJX3jgJBPD1iuLrwAmYOxXjisHwLPLle/GMFS4hg0efjyLECVOg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41smjd2pbn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Sep 2024 16:04:11 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48NFUejd000461;
	Mon, 23 Sep 2024 16:04:10 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2045.outbound.protection.outlook.com [104.47.55.45])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41smk7qpkr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Sep 2024 16:04:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ifIZje8gnuHXEqe7GRB3H4VwEPYGgVMkM/HLkySvXIcxX9B25UL6VW3h8mXshLTAJ+0CzNjqrxpmV7OjBQg5QKAzNdzFEDP2F4OkcET25xzbqqIlVaSAKKamguZ5wFUaFw7QQkf0pfShIIT43g52bOHed1piJD5HlQRR6K3S5kW5HTjG4hTJc9t6rBKftaClTu8RLbcZBEGZRJXzraQttpG52U0DweLXK4+yZ2JV6tBqmsjv/UH1Tgm9FdBduvVo10eyWzXN9fVUCf1ZbCzVMc0r+F9lgfzQNagep1vAFwk+rqVP+qc5AgcDcNwfv5ebk0C49QUYD6YzbcraEq/UpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mZ+aU5UZcVqTdBzvkHuzXvSJY72J51Ci/yzu8mZGWT0=;
 b=gwEeIApUgMOHk1bR812/zAFMG9YCKJorX3Vjq/sBsWIpsAidubbBpNHjShZf8nd2woDM3DeXAJJYmD2mACiUXfcABL+OzCBzlvADhTyBgU/UBMHjgWLts/Jvb/Agmt9Sl0TmGTxAgAPtOLoK1syThX+XTEG0VAR7c28HbGW5mP/vj1TwHwewknYDOg90Ha0euzGK3M2AsGmbUC54d5/9BdVsTuuHwZ+VMDAXN/ebGunczHf3ql/+5WUgDmb7k51eN5fdSOqtqCfZDqNGDFcuil7avywY7FaWPpcRlMc0LKcNGEv/P2EvjSIgQt1UF8aB98PxHtSVGxVzbCtH1NkJ2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mZ+aU5UZcVqTdBzvkHuzXvSJY72J51Ci/yzu8mZGWT0=;
 b=UggMc2kGBcGPghzX/G6Yl3gRbcYSrSoGNnZ/RO994qcoFLDjS3dylEkhTeSwPyYqjHF/23kEks7TMEUCiF5PxCyitdwcmztP/7ICD7jqDtgetIQyRRbhR50lEz4iMuG7P8P7dNU8NcQxHOuYWDpVedrQ4SwafmMhIhFpzqoxYxo=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by DM4PR10MB6744.namprd10.prod.outlook.com (2603:10b6:8:10c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.13; Mon, 23 Sep
 2024 16:04:03 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.8005.010; Mon, 23 Sep 2024
 16:04:03 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Vlastimil Babka <vbabka@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Suren Baghdasaryan <surenb@google.com>, Arnd Bergmann <arnd@arndb.de>,
        Shakeel Butt <shakeel.butt@linux.dev>, linux-api@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Minchan Kim <minchan@kernel.org>
Subject: [PATCH 0/2] unrestrict process_madvise() for current process
Date: Mon, 23 Sep 2024 17:03:55 +0100
Message-ID: <cover.1727106751.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.46.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0381.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18f::8) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|DM4PR10MB6744:EE_
X-MS-Office365-Filtering-Correlation-Id: 3656529c-1f68-44d2-ed57-08dcdbe9585f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|10070799003|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Zs7rsEV0G+k73oFAOTJD5pdwI+sOqcaLdg+Ca86VYgb6S/FlJwcxXXHlwO7O?=
 =?us-ascii?Q?/mjC6iL8iB82+TRPANe7M+ZX/vI4kKmDHLMYcNCr1pVbVS1bfIYXz2SrLHhl?=
 =?us-ascii?Q?ttehmd/idoIrq32VGaFgbOfB7qgMgyjrVanqmOZ63NPhwnKsy+qsEzcQNnAI?=
 =?us-ascii?Q?Eo2uRq0gp8XbQNgbD/QQzwSzToi5kixk9bS+BSdHvfoJ2xAsF1rBHheOB88l?=
 =?us-ascii?Q?Bk7mefFRkTZut4nH7YinS83mtjt9jVObpve4n34PANw7z/Mo/XWp6dOI5XPb?=
 =?us-ascii?Q?sKUfU6e/9GkgbC2rqPogiSMcXM7b4RDYcgsq9YxHBwQT3OnLB4zdasY+X3MV?=
 =?us-ascii?Q?MUAWCq9fosSKVC/hG8JdsuFqCG9nW+LUR4vpp3zHzN3CKF2k3SWW/+yr96NV?=
 =?us-ascii?Q?PMvvELwHS3XH5ZNHYu3/pb8ujzulgq0I8WG1H7adGuTddwNYcSM71Wv91bVp?=
 =?us-ascii?Q?cmOWwO+mY1sjxV695uHwcutDRG1Nd0Z7RteGuNqxgDUKzFm6XpoOGrqY7Uoz?=
 =?us-ascii?Q?pkuhMwEzXHPL1QZz+glWnV1oxBA0GT40HMz0nauJpFDRTs4RMBk0fCumDCXI?=
 =?us-ascii?Q?oIEjY+5iXulnJ3ZTyaiugSpGzIRgmcKt7OHChLzKJK+3X5kpBgEnR6DkC0RQ?=
 =?us-ascii?Q?iKtN0BcdtWm/tQivX7HBfCSvTNfeXNL9eoGmlaZG9osvhXE0OpTi9iBaUvH0?=
 =?us-ascii?Q?BiqC5sV7YiXW8vobU5ychipFfGCWCwrNJs2A3AN1ekMRIct8SUK0L1B8p8Nd?=
 =?us-ascii?Q?SXg/jrolvNi848KYEftyrR3CsR6GlwgEgW5aYX/V3RgBiUT4+GJ32G0ncIY6?=
 =?us-ascii?Q?eL+wYMg/dsEffMlYVGgUFiUVIwasY+F+qreXuNe8KGTCj1Ikwgmwz2P7zU3h?=
 =?us-ascii?Q?RNGQynAaq91UtBL34CV9LXyvTcmSs1O7PtYnRXgF9qItkRAqTUviIFZKjhNx?=
 =?us-ascii?Q?ItiTiaItj8RzDTgtNA57soLo7nYaRibKmYVq9haD506Yn1hFLea1Y480ZZI1?=
 =?us-ascii?Q?7hmw0M79bKuO6qMQYfCpfsH3AaspX4dpfjnxQ6gskzBl+qS5AZv07FwaMDiA?=
 =?us-ascii?Q?Hc9NFBjsINeEnf9Tj33ARoY2Pgm8xFVgl9pC2+RHy1S5V9tFWIu9ZWP7LJm3?=
 =?us-ascii?Q?HsXbe4L1FALI7HX99ZyXJZSW1pobYrAwukfbIdE4TZFkhKcxNplXYL1Mzt09?=
 =?us-ascii?Q?9PWHV0tally6V0cIQzoOvCgRNR8lcAhoorVySVq7FZYVZXxwj9g3fNkyti9m?=
 =?us-ascii?Q?iGt7VbyGmxZuGHWc/98Ja8sxftVxVXpm80vWJ2T5C5ZW5ZGjfkfwMFe15LeR?=
 =?us-ascii?Q?2qnP0dQ+D6PVkLEBHO22FXayy5bmRZmb+yKY0Rx1CcdfGg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qOwzZjw2b30ptQISoXvKy7KK6BxQXelnF293uWLaI4yRfwOGnhC58Xt0kvTj?=
 =?us-ascii?Q?A4WQwbswbki8oR9fGiVSKWqfe2/c5fQqk8cOBB9955k3WftRkBNB0nqlTaHG?=
 =?us-ascii?Q?cBEHQjaSX1hcybR9Px1IENso73rjD+btAace5e286O/ILLsiKBr6JQqb7LRZ?=
 =?us-ascii?Q?xTR0K3sdjXaMS3nWQ7ezEa34e9MgWSalaA1eTkcVPB+2agw4GZAJqpdNXzZU?=
 =?us-ascii?Q?ivOUy3QubIYP8Fq3MKm3Zd5puWOLgS1dEBqour7vOg3duE0+IxmYS8yGnwoH?=
 =?us-ascii?Q?n1YE6FYfXj6QAI1xrnNuESKS1xYRJ8ledZGiPAClxFaUni9wqai+P5n27y/h?=
 =?us-ascii?Q?u3qhJ1orSaBEtHonIEpM8xQeBjqiJaw2+Ytt4Lftf0ofesJ3NMwFb3IFXeU5?=
 =?us-ascii?Q?wkvvtr/fDfvY00c2w0OtwK7HWa5Kv73wAG9CI/tcI3I5x58b8+zHf054GPPI?=
 =?us-ascii?Q?Z7b3TdR0g0StzkCeF82GNI1uMMS/8wc9AbHyI4hY7/bLKZQORtGDiFlPiOwh?=
 =?us-ascii?Q?JjN8VTQZzEC0kB3fby4kqyd3CvM4D/ROWLNqjh2a6hGWHUmPh+ym/y2toBr+?=
 =?us-ascii?Q?376Zvx+zrjrzA+OHO4AeEuLCe8NX765lxHVE5Ung6lHIqcmHSa6kSl1HYlgl?=
 =?us-ascii?Q?UGe4sm9DMYTX7+nZpQTQTGvuQqI6r1/5CtMGcPN/BLvRHu74FhlXCzhP0ciO?=
 =?us-ascii?Q?gM3VDZ2I573I62Y6qkjz/8v4uF0BYUAELkZF+CBIo3ZDCKLUlfiCjXeZ6LgG?=
 =?us-ascii?Q?IbZvgRN4tVt0TvXeVBWTFhCSO6OdIldTRrg1dM6I9LrLAmA97FPTSRtqvSTR?=
 =?us-ascii?Q?kRI2djhv/mqDkIBCyjAYPdDjjwV8waSr7R/Gp4s5aJrtgVWfneCxvClv0qqT?=
 =?us-ascii?Q?hbSbkMCvaG895TXWYoXeCmvoISBgDF0Xgm5N0MhrxrvTsLgj+KCcx1IN0wbB?=
 =?us-ascii?Q?DAVKQfiycSCkiEn+sGMnXujjWmP2I51NuoWV5sdssvaQ6uHa/aYBgcykTEaG?=
 =?us-ascii?Q?FsLKOPtp4CxTryxzMEJw2zph0WLIK7wGgOzzF1sqo1tpJ8A9L6lxnGHWBxK3?=
 =?us-ascii?Q?mzJL5G2mrDKdWu/ygp0agmjK37i/aujVhGxxNg8yozHKBcqucbQbrfIO0piF?=
 =?us-ascii?Q?3Qq8kBv/lqfs9KUMTydSUZ0H2qPILNoT5WNIfbwtkvoTK3fEl03v/VJMlvbq?=
 =?us-ascii?Q?kkVnI4CXUy1ffDxdvSmfSkQT2q3AljUq+s7AG6b95reQ0xaYkV8D2b6m60Ck?=
 =?us-ascii?Q?34wh4o02/qKto/5zA0gK/+MCXoy2ipsHcXJn8TNUvjCuQq1kcQpQOk/UZQnZ?=
 =?us-ascii?Q?2hwBrKoca0xa3z+I+zFkA2rLS0DxwjHxuyGyOkeFhWlTK5Njnp9OLdfpz0RZ?=
 =?us-ascii?Q?hyjVX236zYTaXR61k13EL/Etwdrbef0fH6ECREVWP2V3Z+y4hWHGs+XRRwzZ?=
 =?us-ascii?Q?bgG1y7J5cnjAc8JxYDBMy6/BYywYnloHIrLqU4hwWwsqhIqJn4KTHeVzuDXz?=
 =?us-ascii?Q?dXn59SNgSDz38y4BznOtBXjHcMgaJiyQIv5xcESNXe3i2PvhwbI+F7/p0N5/?=
 =?us-ascii?Q?xA3rQ2AfvTHqHIMNd6gnQZo9AIjGhczihlcOmMDv5E5WBZLllnXkq4Ek8238?=
 =?us-ascii?Q?tQ1zp7Nbpor3BArsQ8rFeOWJjUb++1ELLblLbnGUDuQeD72eODChkaKASGE0?=
 =?us-ascii?Q?KPQr4Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	HiTymrsWr9oXydvoFbVJWj/fTJVPl/0pz9f9+gyr3yT4STbXunRN1H4ImaHwV07XSAAqP4d78JhH0MOKvV6kDAPxW3F+HWgOdU08lxsynx+fOBI46mATCQCfOduIv0HM50cKMFc+V+R5USaXJBUPmwpnMGZHN9J9TbYI4U3lJMstws+T5pblL3TyQvVd0451cO+drct8O1YuDAVD6ICYT0L43QYD0ukI8rOo3PuTD8Q1LnRBPI7LpscGRAzb5JOB5sfjxk+MSL09Iub4/sQZTJKvFBYnMSRfBCJnBb9DNe5PYfuOMK3XOs++1jDer3bG7/YXBI1hV/9BDl8jqGd86oqcY37s05kxLYYzCI6qHCHgqQXbDre+MmjGH90Cne1BPUywnc7EeDq+nsHsoirDEX8wfyuW6I+d0+pxPF31vApUQaVFgr2unTW/IBvKdK68wjvoohgkl1dnt9aYLqd/oT/rPN/Vv5C0/Hxiu56OyEVijaqGyjpFR/yWqOwsCTLQWH8gH+ta4vA13yuHnNYyZxE3ZpAbCEJlxdCYmMNqCAFCEWAeRbJps9Ondd9/BUhBI/uwzosKeFql01XFx4FaN8PLlOzVL7M9zgg+qO2G56Q=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3656529c-1f68-44d2-ed57-08dcdbe9585f
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2024 16:04:03.7199
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KTNd4e1BNcN2y5v0bELu03ylEuZKNxh04Fe0YmPdB0e4iGmkHey+Jv7kNEkLoRsn12cahYcPGZAnl/DMAc3hEolBA+rov3Swhou7yKThfbc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6744
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-23_12,2024-09-23_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=651
 malwarescore=0 mlxscore=0 bulkscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2409230120
X-Proofpoint-ORIG-GUID: -MP63334Ec2nf1eY-wqg3Z2EDKzEVz6b
X-Proofpoint-GUID: -MP63334Ec2nf1eY-wqg3Z2EDKzEVz6b

The process_madvise() call was introduced in commit ecb8ac8b1f14
("mm/madvise: introduce process_madvise() syscall: an external memory
hinting API") as a means of performing madvise() operations on another
process.

However, as it provides the means by which to perform multiple madvise()
operations in a batch via an iovec, it is useful to utilise the same
interface for performing operations on the current process rather than a
remote one.

Using this interface targeting the current process is cumbersome - a pidfd
needs to be setup for the current pid, and we are limited to only a subset
of madvise() operations, a limitation sensible for manipulating remote
processes but not meaningful when manipulating the current one.

Commit 22af8caff7d1 ("mm/madvise: process_madvise() drop capability check
if same mm") removed the need for a caller invoking process_madvise() on
its own pidfd to possess the CAP_SYS_NICE capability, however this leaves
the restrictions on operation in place and the cumbersome need for a 'self
pidfd'.

This patch series eliminates both limitations:

1. The restriction on permitted operations is removed when operating
   on the current process.

2. A new flag is introduced - PR_MADV_SELF - which eliminates the need for
   a pidfd - if this flag is set, the pidfd argument is ignored and the
   operation is simply applied to the current process.

Therefore a user can simply invoke:

	process_madvise(0, iovec, n, MADV_..., PR_MADV_SELF);

And perform any madvise() operation they like on the n ranges specified by
the iovec parameter.

This series also introduces a series of self-tests for this feature
asserting that the flag functions as expected.

Lorenzo Stoakes (2):
  mm/madvise: introduce PR_MADV_SELF flag to process_madvise()
  selftests/mm: add test for process_madvise PR_MADV_SELF flag use

 include/uapi/asm-generic/mman-common.h       |   2 +
 mm/madvise.c                                 |  58 +++++++---
 tools/testing/selftests/mm/.gitignore        |   1 +
 tools/testing/selftests/mm/Makefile          |   1 +
 tools/testing/selftests/mm/process_madvise.c | 115 +++++++++++++++++++
 5 files changed, 161 insertions(+), 16 deletions(-)
 create mode 100644 tools/testing/selftests/mm/process_madvise.c

--
2.46.0


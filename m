Return-Path: <linux-api+bounces-4250-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E8C4B133BA
	for <lists+linux-api@lfdr.de>; Mon, 28 Jul 2025 06:35:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34FA318963C1
	for <lists+linux-api@lfdr.de>; Mon, 28 Jul 2025 04:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5522B20E71D;
	Mon, 28 Jul 2025 04:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="I0y3Qiyh";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="DP1otKAQ"
X-Original-To: linux-api@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 980631E5B91;
	Mon, 28 Jul 2025 04:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753677341; cv=fail; b=GpXpNP/2ABBjD13XCAO+j15ihMcKQqtehMeE1oBlPotR50ttsZTbj1SDHKvkH3TydI5Pn/CSvpQcHBpNMpb8FRFJTcu17nXA9ah+OwGVz+uZKhcYVPMrv6/rJaiNY6tHGhlJ3VU72DJvciN6da9rPK9YAHMcCnn27l6lzG5anQk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753677341; c=relaxed/simple;
	bh=RnjuRVgv3KBHapsQVASZIgrqu5LHKiUra5Xk5IAGyJM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=G/8GDGimk2V+oDYuxIywTGtmwpoqbpWvCHBy4z+a7CBj0wyztEs4NSV9vA7pAKpt5ougnBKxWzdEPLfIuSt6bax4qi4srbABjh3qbS43zquLCcgRwJbcMp02f49iVmf+xQT0I9kPY8m/mGbfN2RLsgTpTdHORjj7/gsWLFRFvko=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=I0y3Qiyh; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=DP1otKAQ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56RL0I2W015829;
	Mon, 28 Jul 2025 04:34:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=p27KvbT9BXH2qzieH3
	gL5zpV17D8sn7tHr0OAe2QlCA=; b=I0y3QiyhHrKC0nzm/pJ1hYAoKSvTi8AM8G
	TJ1f7k3NsF6jh6xGT4j+m56/mVEoslubYnpOP7HtAxYdQqYCumK742hZ5mw4adhA
	o/d1nwBau4DUVxWWn6FyJ+0P/TUlmJ/RsyCKsGk6S0MYddGPl+FjtvMuM0dFH+EB
	ycGUC4bs6Tfgi41WDK+heH6t5S91K56ge9DJ1dB5epczDk29PwamA9eHFbNfN/9j
	t1JSUOJn9MKPHCasNz2dRd8bZex3MoJ5fDy4LncU2cEzViRuH2s7wbcg88v/gYCQ
	l7CHCTiAcUegvXGgpPlb+7t4ecz9y/gCJ1SJ3iq9aoi810W7hnqA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 484qjwjakx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Jul 2025 04:34:53 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56S3UQKd003110;
	Mon, 28 Jul 2025 04:34:53 GMT
Received: from cy4pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11010019.outbound.protection.outlook.com [40.93.198.19])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 484nf81gpr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Jul 2025 04:34:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HkvZXlUO7DWA45NRT01LNrZTPJQtwr02Wx2UGjOi2GSzxPAAMISpyNRMbGj6YF/odfEVscLBm09jM54EmEpV07xXsXk7xMYfBa0vVQB1rVLSswsn57grnC/rocWrcXq4xmxcYVdod6LT11pn+rwcVz0Bf1ad7iIqEmOsa5FGWWfgxfBgqElmjvdw8qEkQh08ek9/4Ug9Rh62Is5oiovB6H1B289VEmtM9zIBSQ/zPeDI4LUzBybnqx9nVyn76KJb2lIKJT4W/0ToMTzIS82o1K+uUaBOVRTbS2yVAdE80xXTlPV1HUVGyKzbfkBbh3D1TfMhcZ5nE/NI0VlCDjaPvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p27KvbT9BXH2qzieH3gL5zpV17D8sn7tHr0OAe2QlCA=;
 b=FbJ1OhKuzk93mTWxDtYYNN/vQKQ1FHSff6TnRkgM9ePMmwyw+ivS9s/mBfIKqOpRTZw80b9VvVEuRgICYvVKwHpRM+yyLbE4Rt5CTIydVzu75X2+8pBoGkQry8vPdrgWJVaZ+Jm5OQ/bbchYySZcd49NlOctOeqRtXJPTwWrzZ+86Xmmsd2u4MSdAY0DZ3NLSax6bEdWxzzRH5ivtmMV56TwY4TziAK8VAPWedfFzL7/Z4DSH2rmJyKwPhBgeoEhEWCXT+bpY6xHFIQhfqJQ8DeFbu0m70YrWwm935d+Rl4nYkbFOjoGK4tFoMemcTa7iBciUwVGTvphRzBL5QMZww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p27KvbT9BXH2qzieH3gL5zpV17D8sn7tHr0OAe2QlCA=;
 b=DP1otKAQrek8hGiY8byAGdggepIF9nIwrGkuls16LYWNeMZaKk2IR9FXw/+XU2mNgFfEXEFvsXNOBBNG3RZiPEfh9Ri9OOOh7AH3lhjK1aCzEDtjjpaotShAXYAbD0/2aa4oBqnoztRLDya3GUgV7/xmgHYXKiQdHwJgjS/lIEY=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by CH2PR10MB4136.namprd10.prod.outlook.com (2603:10b6:610:7f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.24; Mon, 28 Jul
 2025 04:34:50 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8964.025; Mon, 28 Jul 2025
 04:34:50 +0000
Date: Mon, 28 Jul 2025 05:34:48 +0100
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
Subject: Re: [PATCH] man/man2/mremap.2: describe multiple mapping move, shrink
Message-ID: <1ad24ea7-ed36-49c7-94dc-42aecac3c2dd@lucifer.local>
References: <20250723174634.75054-1-lorenzo.stoakes@oracle.com>
 <siwe6k4ks44mvdzy7rmir2pmf7547gqxknuoppcn54pkh4lwdb@lko3ecfdjtda>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <siwe6k4ks44mvdzy7rmir2pmf7547gqxknuoppcn54pkh4lwdb@lko3ecfdjtda>
X-ClientProxiedBy: MM0P280CA0003.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:a::14) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|CH2PR10MB4136:EE_
X-MS-Office365-Filtering-Correlation-Id: a37c1431-f92f-403b-ecce-08ddcd90175b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WBm5BP5tkIyefDAc4i3LJSyBwfcJV/lXnn/cg9MXgNVdg5Krz/yqeEorWY1W?=
 =?us-ascii?Q?wvG1B0lVAiObFRSDwGiRf62pJddDV1Z9SwRlJwBfxWpyZ/hnx2/KL7reJX2H?=
 =?us-ascii?Q?SM1wiu3RSHDhgt25qu285+M8QzG1+hysyU77ZKHT9sh4Zak5ZU6Ft+dAOUaO?=
 =?us-ascii?Q?YMw9hmx1gQBEZ6azJeUsxlBSCXtEco4UhcIgLPEIqbqxruJducc7IQjbvsQl?=
 =?us-ascii?Q?A4X1fRpr0LfKqHx8XQyBSCs+uhU2kC6Txna0fEhQJ9F8HGHjPByKozhJir6n?=
 =?us-ascii?Q?kTiTXuNplLLtUM3y5b571fmhM6yUfxuWVeJr9eZ9eNDuh1C0h+xv8ua8lmXd?=
 =?us-ascii?Q?mzo559Gm8kVEYSFzbzywv1JDZ8DIUWsLl6TNQmRQjLKZp5XmhYg5IXZTW63J?=
 =?us-ascii?Q?L2gNAywl5gQ6HJt+7qlcsZlMJBDNLBpbto+uO01rtwXJH1pFVnxIlkyLMmmp?=
 =?us-ascii?Q?xOFxi08W3jAB5mzxH6+Br8CiX79OUonxYWI3eVxWV9/LDqhpzw/+U7M7b1Pk?=
 =?us-ascii?Q?pbvAjyjkY7WvA9oSe9YbQxwLI+gMCsqSwoS7Mh+T2lKzF67FfuFd4xwC4dbB?=
 =?us-ascii?Q?AFjK+h37QExYiVo8zDl8WijkA7MUSKZkSC94fkdgNiS2A1zfD1KlHLfQp42Q?=
 =?us-ascii?Q?r4ulelkKl2yk4/QXr13xxURRqZhYCqaeeKwUD39gEbBtawTiRY0AXUJOR+S9?=
 =?us-ascii?Q?qmzTKWFI9VzcCR2iHM3K7WKN56EEMVoD7zjEQKnlDfwkojgI2diSk1an0SiU?=
 =?us-ascii?Q?ILlnYwRVkdgc1hGq8jw7ct4CKS1h2gD/fKFMVA7Evtmk2S9wVuoX31Q58WJt?=
 =?us-ascii?Q?637TgXilcf8LFtRHiGJ1thUSubhwydWRrKwIsfKzBtXa7UvUg0EoR3Q+EwX7?=
 =?us-ascii?Q?vESH83wtEUw3ENcnicmUoC+mAp0dfDuqoHJEwHNk5uaqxa5rrMKw8xxnPqLe?=
 =?us-ascii?Q?HnOtRBzxF4a3uQejg+/40C5eVYznjPcno0zfRaTMIkC6TNWWBITQTiAViry3?=
 =?us-ascii?Q?yLulkp91o/quE/JK4GhdpMzX/ul5m+TDjYWWFP+N7iWLy9MtfI/Qz3t64Rej?=
 =?us-ascii?Q?YydZJrnFjewtugJl7Kniy5NjEEPmX1g/4lhbZi7X0wz9l88TgoldVM6elqX0?=
 =?us-ascii?Q?4jPHEM8B3tzvgZQ/OqRo0HBCblqmV+Rd/Uj74IhNTyBoaXixqtZlTzkYFtqz?=
 =?us-ascii?Q?BDMqUsyB3INFpDEknieH2J5MRS3Ze7sBTygrRLygpbc/Isn14It97GGWFdLZ?=
 =?us-ascii?Q?wBWwkowPzRG7Zer9KahyR2EC1UEILBu5gURMrmVj9uhQHFbXt6lF56v2F0rG?=
 =?us-ascii?Q?h2sy7jzWoxIuJJB2JeNe9mmZGUgIhIgTEGHkENMEuU4UCLzmd/EcDsdJrGQ5?=
 =?us-ascii?Q?LF/Jo0h5uOFjZLimksC2g8rzWJ5up/DjgTBR00jwxXUXagkBug=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8cxOSED1aIgkdgmsQ3mXhQr88Vu0RSVZFwxK89cVaYrXHkNLuST8AMq65IS4?=
 =?us-ascii?Q?z8kHAl42Atk2WpI7lClxR40/f8adQnG6CjBDu3xzZmVyzmWuDvY1r56eZKzd?=
 =?us-ascii?Q?mC9aahBtji1K+cRnB14jZLkB1cw44CsHUIdK7/GudZcStskKquBYGqCAonyU?=
 =?us-ascii?Q?mpkSWziFyBHOxNNigBlc59+DPSFaBBrc+d6/faUibIbUpBmRJ5sKJxll0b2Z?=
 =?us-ascii?Q?8A0Q5vewDDRQuygOoc702xZj+owMRDOFG3GJOik/CieSSu0szyMzdBY4Hxj0?=
 =?us-ascii?Q?Q/Tzrb26F/04cpJ11mj75F9OD41XDlyPZw2bxNUQaIdYJEicqawxlnyn4HX2?=
 =?us-ascii?Q?scKD1l3XhygzN20dnZtZGzPPpubU1QV9Vl11ejjsY65CGGtzZz+BLCy1okyN?=
 =?us-ascii?Q?9nRLWASNXe5jFXapPRMtLeO+gR+BZzfocGsrZP4R/RwXcNYrNbcbsVChDG+d?=
 =?us-ascii?Q?thJNDEcr0gM2kUjRyJpUncjdCDB4oX7z1Tm0jqfbItvdMs+coqJL7Qclq65m?=
 =?us-ascii?Q?jdijlCj5FCwyRXbVyYEx/wAJUq8SDcM0i9J960k93q/58fngz6mi7eiK3fWd?=
 =?us-ascii?Q?hSr67MIOUX3h5Mal6zblbfI+ylFDDLi16VceNg6/ylUL5Zhe3HTEhXJ4sgPJ?=
 =?us-ascii?Q?zOGnH1Tz1U4OSBjXm99XnYERWpr83l8bUuTKiJPPSFbM9q7c13rgTemWGGed?=
 =?us-ascii?Q?zIQmhrhEiEMbddvqoIzLqmBFCDjqBHGkiirGYHL5Jvo+mpEJaXYX5dJXX0Oo?=
 =?us-ascii?Q?fpo492tz8/H7PFyGvfPzci7s/DlVLgKHu7fQoSpUCMGCKWBLyxdZKqwHVm/3?=
 =?us-ascii?Q?xSEF5kKUgEWp/kvqVqf7hMSwtb5HkGi8dIxARxUcvtu69ueIt42iTM+6eVhT?=
 =?us-ascii?Q?009MyHEBsUYRK+mzLivlb5AZw9E3W6TG+uB/YzkppvoqaOuny86O3vG3r9kK?=
 =?us-ascii?Q?nthv08kH/Bwz3XjSMe6P80Pk/PPbAyXNXp2l0bOmDEB8M7pwfbceFmWY7nj+?=
 =?us-ascii?Q?ssexsL96WGf4wyosA94sQKrqY97evsyL6nnCpV1wS8HysssBU1Pm/daz/6l/?=
 =?us-ascii?Q?xuF1AdLpFRh8lCO1FIR5BBbQhXSpbU/zKnx4c5s/68tt5a6mRjAqkoqg4FhE?=
 =?us-ascii?Q?dUMB0lqt6gupbkxsPjTmQBCxXZryuDfihZ+irE9JB3Gxqa2kHFud0HhLIg+U?=
 =?us-ascii?Q?3Lc2ejWFJOqnoZDq2QcnryTdiZsARHbps0ZZvu1wOe95pF4hRYd8MsVEhIVo?=
 =?us-ascii?Q?sASezMdJaxYcOqjcCmyZvyQwojt9Ks8F5K0uknwag7qVebGsI2T8I7QQMUUs?=
 =?us-ascii?Q?s67ZdB+Wx7EIM5ocYKWqc7LzALo/+7ZkervGpIL3UUvx93B9UbmyXRz9YTLW?=
 =?us-ascii?Q?WPnQPD0TTcL/85STAo50Uat2PX+bltdyUoLh6ibcTQ04p7hh0Zy9Gwyf7jjA?=
 =?us-ascii?Q?Ex9iutWI8PpAj1dXhW7Ym4cUnRo7FF3tKonTo2ZlY9vAuVVoR0IuQddDK/cq?=
 =?us-ascii?Q?wPVHXgzXA9J7D1iISfhC/MQQAln5/cm3VqniOCvXccaTRec6C7p+HcpZkvgc?=
 =?us-ascii?Q?2yOoOZv4qE82S8Oy8qPmOsfZ9cUYT2w67uj3AIoCmj6EZtmri95GzIcz84sN?=
 =?us-ascii?Q?tA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Bc89SKNfVw4BWNzh2jxOyJvmYXrdAJp+m9xrwJjDjkL3VfNdrPJFqmAdZGDd6kcRhNf0aZd5ek9vbBN1sLDwQUTET96fNaDqvtonpIE98E65TSchJE4UkcClnRCUeUX38BIz6y4/6oP7rZdQLaE4I1LwjElbDF27IKcNpNZkSXjA5MSZoDEgUEwxWQKHwTzewU5MK3kXFfNpeYcQn0CYo+r4DO8qagQO2VRQW/hAHLcNU2YCO06xAG0WhXvt4wyGGjkv4x2gnUCkg7Gi4TAdWxGaZOxjD1n2QwgT3wSIbhEVxlduH3HS1HehAqLODfv7vGbVWD3xtsWfJk//eEEs4oTFWCAhfxZbr4yB4wjdXiPY0kmRz8VON97HHWUX9sm4Fqt4nu6nG6dEN9Voq2WdNBfF1tGk38meccA1l9ltkTsfP/Y34VTIgI3mXrI7fpIeNCgF1xwvrfaTvbCcv+cOYf5GQD2hATGN3chfFItKNU0mABUkbEonh7cZOvO5bRs87yUgAWoqiDwHULCEOO7bqv8X4nUNg5vHruFipE396WG+7/Z6GzoaLiEtRjMYBuiwYhteud/UAwILfj3spsXFQch5XQZULnE7OdxwqKm6ahI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a37c1431-f92f-403b-ecce-08ddcd90175b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2025 04:34:50.8014
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xpTfOVgvGn2OTRbT2Wvug2xqAstu7R4yGrULDO54CIyOE7O/ZcH8jlrS6g39S5AXTZDSCpmPWmFsntu1fXmn48Np8sEdweFy0ZLIFdh9n1E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4136
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-28_02,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 spamscore=0
 mlxscore=0 phishscore=0 adultscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507280032
X-Authority-Analysis: v=2.4 cv=OvdPyz/t c=1 sm=1 tr=0 ts=6886fded cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10
 a=p1DML15G3rLQB4SvCksA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: lLiKBrEJfnmTSDpPG6E8DZcJgDoxSVB5
X-Proofpoint-ORIG-GUID: lLiKBrEJfnmTSDpPG6E8DZcJgDoxSVB5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI4MDAzMiBTYWx0ZWRfX9xqVZKnCBV9h
 CB01JZmWAMsux1A8RKXteDVNnCmDSJppd94lRV4DcytHLPjwQMRf6AZPgKcl9smpfOG0GpNfdLI
 9jH+t9KSvRA6DqH+KeK4zqx72361pX02xa5vL5eCaQ5kud/u8bi2Ncny7Qhgh/aUxDDMmmOBax8
 v4m5187h9W2X3CaeVevc77aMeS2r9jXtlcZ06HX0MRmO8faNya8CGJk1rHzgjKTMzSYP4wCW/js
 XWLqDRZWoxT1J5VRzxYJd6e/GkmCbWUETQyztix9JHcPdJFvjQkLRp6V/zURiaKSch176nRjC88
 Bmdr/aAsR0y5uqhqdAHthNWxZ9Cr4+ANHrRH722tR9aqk0G9o+lyOMQ9AaRQGW39gqYXxRvZlwU
 TyNKbACDezGeeHEk6Dag05PX8r3B2jmmaqf5zdjxoclAnE02tEk9UPr6t1rrKPXcurVAfFWc

On Fri, Jul 25, 2025 at 10:44:59PM +0200, Alejandro Colomar wrote:
> Hi Lorenzo,
>
> On Wed, Jul 23, 2025 at 06:46:34PM +0100, Lorenzo Stoakes wrote:
> > There is pre-existing logic that appears to be undocumented for an mremap()
> > shrink operation, where it turns out that the usual 'input range must span
> > a single mapping' requirement no longer applies.
> >
> > In fact, it turns out that the input range specified by [old_address,
> > old_size) may span any number of mappings, as long old_address resides at
> > or within a mapping and [old_address, new_size) spans only a single
> > mapping.
> >
> > Explicitly document this.
> >
> > In addition, document the new behaviour introduced in Linux 6.17 whereby it
> > is now possible to move multiple mappings in a single operation, as long as
> > the operation is purely a move, that is old_size is equal to new_size and
> > MREMAP_FIXED is specified.
>
> Please separate the new behavior into a separate patch.  Each patch
> should change one thing only.

OK will split and send two separate patches. Since this will cause merge pain
otherwise, I'll send it as a series.


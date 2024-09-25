Return-Path: <linux-api+bounces-2335-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C0709861ED
	for <lists+linux-api@lfdr.de>; Wed, 25 Sep 2024 17:04:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC5EB1F275F0
	for <lists+linux-api@lfdr.de>; Wed, 25 Sep 2024 15:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1EFE1D5AAA;
	Wed, 25 Sep 2024 14:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="En3L9ELP";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="YL+oBEYu"
X-Original-To: linux-api@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD4E1D5AA5;
	Wed, 25 Sep 2024 14:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727275748; cv=fail; b=pEijrgoZeKC5cP4F8HjPXyvZ7Ov5iMG6YVZ2AtlAVjZUAX3mRhphGpZxsD5C/wtlX0vQMpaiXIKbD+r3cO4tHYvIY1Voev7PDjcC0VCxk1Qg8PM1JNRbVuXBwx59onX5OSCCXKYBcwO1T9WkDkKiOsoojpyNNyst2QUe8HNz77o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727275748; c=relaxed/simple;
	bh=jkbsQFvoZCXNQUfE7pJtXaMONnZr8G3I1oLBlSIRKCU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sYvQmrjKSJ7nIvAjQVL0YNiyQcQOK02aJwTs9/WPMEsSToQR2G5Ki+iNZACIQoi27W1PoE0oJ2shGZl6/ABjnblIBmfJALJkWHtzuw3XJi0fZKahlt8iW1xUth5k5F+/apTEsDCLNUvTnqG24VkNBNA6w/4ddoSbfj6x65LB7A8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=En3L9ELP; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=YL+oBEYu; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48PE0Xjf025800;
	Wed, 25 Sep 2024 14:48:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=C7TaxZMdM+Vrc9/
	6HMeXMEH9+0m2FssLJNN3swrqhsg=; b=En3L9ELPplf6OwjoHo4QevS/2EHmwIU
	LMP7FmWik6uus2M+i2qegMZ+nlAe5DI496JvthMXav7Sa009FeZxsnTz3C5J/CzV
	gnyiV8adtLBnSwmp8H2Ixlkp3HN3dr+p9kSQFi7IlxItP9qcSoTLCWevYnnnaqTg
	Ema9suP5FGElysfQ7hH/46bv82iaXnRW6ihPQbVqgc3x7gadabVpnvIlkLam87Yj
	UM4ndsRzE9VpmciSD8HFSR0rCgT0N7VDIikc8xySwFHNemv4e+z+VXlWz3wsq0jS
	h8TdjnIMO6qjhs7dR6g/c6hDMauc8DDUV4As+uzlAHLcZ1WOq6HfvLw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41snrt80x4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Sep 2024 14:48:22 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48PDhaXN031138;
	Wed, 25 Sep 2024 14:48:21 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2048.outbound.protection.outlook.com [104.47.73.48])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41tkc7bccj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Sep 2024 14:48:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YwIB6Dabxnn9vNaYQicjMdv4ty+l3N0MMiCru5SIhM48+CHeHiK6rjMAP8fnoZDaWlpSoBS1cjlOb8RJigu/Drs/H51tVgiVOCniJxUFJDC9MvKxt5atjDLgJGPjQdSFsrqBDMq8w5dBfm3q6eTfKUEuda6rdPmQx19kd7Lwbm31sskOSQyPm48zLPmJPjylXpn2hV2OQt9S3/LlQ9QlksOnrkZm+XGyusb1BJtHcUjj7KwFXT4CrKt4SLFSkKDchb0jOAlNEAVfr7QqSYYoNG56ayupMYwg9N7vGbC1pUBetno4KaRQCX/Y9z9fpPal4X2+BBHGR2cwSFey5qXiew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C7TaxZMdM+Vrc9/6HMeXMEH9+0m2FssLJNN3swrqhsg=;
 b=bSIbcOm9qh7XdlGn8OEoZOElEo9izCGq/TSC941PWVkUzZSm+YlW3Wm33pnQ2LxwY0qqBd9m2QONpcjEFAnvtd4Yc1oaXllO8S/H6SAzHexc/yM+KjukUe3Ev7eZ7lAcBw1XEsIX2aq/0Rn2/y6I8rtvKCQeIlfnkSmyMiliK4PeLMWj7DwS/fphe5wRYhNvFnMFIf/IggMGJ5ffHFSuLmQwd7puy95wdXOWkgpScv2zg4JrVSktbOljGgov5i9EWx1AoBwnhC+kg3VDvhK432iszJdWWsCaeJLts2ogAnQ/TXvq+pWcGyxZeWmTHuZqfBAbS5QS+1wTdPZ0Iz2knw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C7TaxZMdM+Vrc9/6HMeXMEH9+0m2FssLJNN3swrqhsg=;
 b=YL+oBEYu68AT5860TuZMjJQfYKQ0UjFcFXxabb64voNctc+jUnryndPeTaRUaDkznF9GtG/yY2fcls+vgmLIrHAmhcmYpXtlZ4HvAoEFs2u6YliNUA33+s6R5XI47le/drN5GUYiTl6MNnPxVXgIVOSXU/4SP02vtdNKWz/gOW4=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by PH7PR10MB7009.namprd10.prod.outlook.com (2603:10b6:510:270::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.13; Wed, 25 Sep
 2024 14:48:12 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.8005.010; Wed, 25 Sep 2024
 14:48:12 +0000
Date: Wed, 25 Sep 2024 15:48:07 +0100
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
Message-ID: <7f40a8f6-c2f1-45f2-b9ff-88e169a33906@lucifer.local>
References: <cover.1727176176.git.lorenzo.stoakes@oracle.com>
 <1ecf2692b3bcdd693ad61d510ce0437abb43a1bd.1727176176.git.lorenzo.stoakes@oracle.com>
 <u64scsk52b3ek4b7fh72tdylkf3qh537txcqhvozmaasrlug3r@eqsmstvs324c>
 <4740dfc7-71da-4eb4-b071-35116288571f@lucifer.local>
 <xilfrvlstq4fqr46jlrzvq2vlr22nizdrwlcdizp774nlt6pfj@jukzlcwc7bed>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xilfrvlstq4fqr46jlrzvq2vlr22nizdrwlcdizp774nlt6pfj@jukzlcwc7bed>
X-ClientProxiedBy: LO4P265CA0081.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2bd::9) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|PH7PR10MB7009:EE_
X-MS-Office365-Filtering-Correlation-Id: ec602292-2ca0-4505-258d-08dcdd711467
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?P4/cwAc3Lr/6kTh5XijW9czhVgzamrg3G2q94pEnzZ3JF7G5TI7gaEunRr01?=
 =?us-ascii?Q?kyHHHan5bsIW32z2LPXS71s+zt/qA0MPhV9t3ePyS1pgqLWMUilJfzySlaY8?=
 =?us-ascii?Q?h/BvIRqY6V6LKVP3qvJtvXuFDFJf4Xx+4wIrgVX+x+0QWW3oeKas+cgBgfeV?=
 =?us-ascii?Q?lALXWoxd3myx48rVywfgawywhKwW1XtaB1AnsrEOyk/lz7vm6/LNbwub4tOZ?=
 =?us-ascii?Q?giJpChm8jrxMuZEEUXnqI9W7MJO/kMSRc2R5LiTvQAvX53yF9YSqBT38D4LX?=
 =?us-ascii?Q?VpbXxddi3BYEPZvOD7EN5ooAbLihwWtW1keqtHu0vsIA55SFBcT9Y7dljnhR?=
 =?us-ascii?Q?c1sQhjgt5cLVBF63PPvLfGxWm4DcdXLwzQJmSJSNEqF2x4WUtBFmwRPycoxO?=
 =?us-ascii?Q?WuDzVtsacf41sUmfMx+VSR28guoNocs/aFhHun6Mw4VD6ZILHmc75aaMVKE4?=
 =?us-ascii?Q?n+WsyOIZNwUGUlVB05zlBqcxRBuY0bVL1s3OogDEBaJyqIEwiTxYzlIiVzvS?=
 =?us-ascii?Q?L8PfG2Hxj6HKQWZEUNVS/lJpwEX/5HRfWZ3HRWda+J9Dxm5yOI1VwO1+cQUV?=
 =?us-ascii?Q?zr/EmCxGYsGSLEQkEiYfkBZ2kn+GxjEjGdzNdD6A5Yex1y7r/hpusPvLoVH2?=
 =?us-ascii?Q?KoEhXGF2rYbxToeJvGlkCcOpD3oUCSD9qF41tfVU/hvr/NhpTkRqdLFv3N3z?=
 =?us-ascii?Q?LkzvJ0hbKDtORRNb+uiPTH+jhky+SQ+sUgiUWB0s7XvBWJnHl2p74vgLDmlE?=
 =?us-ascii?Q?7KRUBPT3fBknkaC9OTnB+feTOch7FUcB1HNMBCVhtqZAn58nHrEyLkJyXtxA?=
 =?us-ascii?Q?8oJcQBWyasIqtqcLsLKioVwNAqSFHjjmo05eAXx3PQvu0N/0+UPyyjox1z17?=
 =?us-ascii?Q?R7kd44mnuE2IO2R5OSzmg4sDz03pAJVHdyiFtvTP9QUh2ROx8VzdgyEp+8Np?=
 =?us-ascii?Q?VylR7vfXt0cTVVf7HNNFyaJ+ywfx+BS9Ph6x9gOM1KBZu38A4iyS6TcWZIIs?=
 =?us-ascii?Q?oCXYyRi8Bqj4AeLVG2PQbMU2zXoug64YfgNYQsgURdgSzQ+LpwGzG5Gds9VE?=
 =?us-ascii?Q?5Bgj1wJv1guQCryacog6sarCjHNEyF6K55dI9+t+CN+rNpne0sSzWgLpBScz?=
 =?us-ascii?Q?k1y5qB5d4KbXjWe09T4Ipo97Ku6iksANIaDe+bepDpBSNBhM3shSvRgiZbOQ?=
 =?us-ascii?Q?H3eoFsk4DmmKSS6uts1QQVki9dWQLsyaf8f2PZe4JgIt9lu329Vm9vbbpzB9?=
 =?us-ascii?Q?JcgnQrbBWq4Yv0lMrLqxr1/rhvzs4rvJl9B54JiSz9WahhcAm/PQOnSwrCKV?=
 =?us-ascii?Q?wXBwpvkrTQvLLctRC5xXOLZCmcnbaPbpRKhGNr7Xj+0WHA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UpgIfQ9xVmfy73USrWSnL2pbdDDTbOhEpRqCl6Gq2VHHkl7NEq+qeklFX+Hm?=
 =?us-ascii?Q?zh5ogB0GxBqGTuw5KWhp0voE7/7CxibRO+cnrLJe6DYk34Xo4eUgSWpzShF7?=
 =?us-ascii?Q?e1XEBw91TkO7tpp1aA3dPRVPv0xf0NF7fostsu94Svfgzpc/KbblCyHHJ6KC?=
 =?us-ascii?Q?6lIiYSTJOnDjssI9TgdnaOuKJjkm3qjA50Szgb/KpV5nN+E938F2tMb4oyw0?=
 =?us-ascii?Q?1aTLqLqy9Wcd7ZrEOy8SrKPm2Ed1oD8BkIZ4c8VnGFpJ61wZKq3RF1e8JcDe?=
 =?us-ascii?Q?4kkY1YnQiqs2p8pzI2gIOuIs/CKuV+DBWi2mQjVmMOdIANyviJpEaQznDJof?=
 =?us-ascii?Q?JmICOzYmLPtBBQYfTmlDOvL7NC+6f4uUMoapRNDPA4e68KWOTwV4Pp5o1VUS?=
 =?us-ascii?Q?pG8Wfkop6oS7l90igOtF9DFfU+iz4h3r9PoGAcDDz/Dwy9YzYnN0w1+5nH3a?=
 =?us-ascii?Q?SHB/RUJQGe7lN2uXuRbolaZMAMliBkiBErTb/WnbQ6+eEoHc3w2LM+ZPAPae?=
 =?us-ascii?Q?ryBqb9yINdJC/HRPNc5VXJYq07CWTI4SkWLkLFfbqilld4FAyVpHZHgOj46S?=
 =?us-ascii?Q?zmdbX1E2uKc0lWgZn2ga3s0aJycYWJ+7yifmc/mmLGdt8BEBZ0sq1O+33erl?=
 =?us-ascii?Q?FKWWCupJWo6b8p1BenPd703l+nfmXbJiyehAE1Q0EKsrrY4nr5O7vwdHBshM?=
 =?us-ascii?Q?j1oeM+qhJAyibVdcSSCZ8coP4fUKCkwNFCimz8d4DnPOP+2+PzwfMY1e7J0z?=
 =?us-ascii?Q?PQQ47UZKEqM343rsYSsy1lrWjBtf/xef6alwT+37gF5zPX1Q45zBX2301dBd?=
 =?us-ascii?Q?debD7iEbLEH3RKZMSuZde8qmvA5eFRiNQaL5tfiK3CiOtcmD1JRDuioF7SKN?=
 =?us-ascii?Q?J27lrvfNeCBaf4sajNntcBYbVuDlE3aeo9YBLJeP0eaBxNe1ndHOX4zaSbC9?=
 =?us-ascii?Q?uVQLN0qDgViIeTOzwdusxOvsqW43IN1znBJ4RpET44474EEJECgXCCSee//2?=
 =?us-ascii?Q?p0yinfweAOG4pdMv2WizT3n5Q64QJd9C3MMHbDJj0fueBDMBRVIMY3fz5zhV?=
 =?us-ascii?Q?JD7Jfr4rqzk0C9jTWs6H84d4J4rd6T0swvqNKREAtHRifK6rPh/rurk3TjsM?=
 =?us-ascii?Q?yil4C9Now8D/dmNKfEaYmUSPE0HwT8toEOo/B3EaumPfQcwFwgR9fNjEkSuh?=
 =?us-ascii?Q?Sah87B7dAFsz6m4nnef8nhQuwxBNVwogQ3hKEfpThoGcwLXBVErZroe3qyz4?=
 =?us-ascii?Q?YnLqkKDud/QHq9MbRXdUitPCFU9dYPmMy6BUbQkh/vT2NsREdSAmiy0xtBG9?=
 =?us-ascii?Q?yDrncKM6yGfV/wsnhL0qX/63WTHYm9RwxLJ3TUcCC95pKSeTPnogspJcrQx0?=
 =?us-ascii?Q?6D6lxHZ7oKjOc+68ETy+t5ZMynN0d3BdVU0FCafLhS2PQAJCkTLNBf3gxwxr?=
 =?us-ascii?Q?FQlhrVKSBSougl/k63KFmP2BmrxqSOIxlpSSHgeEQ6M92FGU2K6U1D44xDhx?=
 =?us-ascii?Q?RfoDxJUQlJA+8LTvjxNANkFAIiFlRFq7GNGLUVOj9VgcdWan0fYYjcyVjiXG?=
 =?us-ascii?Q?/DLLlesZD0YEh8zE0fTZzztiGrzFKKKGN8ZKUgiaQtkiM/GcSH+KPDPTWz10?=
 =?us-ascii?Q?+A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	zYnult71UWzSOgqLSqKGEGMDCnd0OVbr2VL7qYQTzl6G1r1rt6UGPV3TwPEa1OUHXA/PcyW3SJL+XxVxJ5bGuTWt7wX+hOcHvY4GGirI1v04i0jufxXNA9u8CY0FfY8XFkBrT2nENuIvCz1v49o/fQNMRzovZ7abR4UXn26CGtmLkhVSVliumqXqx0dF3M78uRDuG7NsD92frn7AV+TqvDF2fwwN7EUn4/QwYntQ8Kx2QhKvnuNm3GR1PWmuzQAkGPAo2g14fzom5bwnp3xwFDghUfpsuMR48OvlXh8HJ+DHi9ol7nnknQzX3SwKX/8xNps/z4LCD4A2e/jdXTz6EbMNjqtxmqeVn8ALBm03aIpqnvLd5pZX5KH1ACiHT/uCsXdCjY0fnpsS0IHfyX/0JgZ7Vik2X3XqwcMJ6EOiDR9F5P7hSrGm/wl1a6TPsBY2bgyz10/oRVNda7NHFGWgBBsLS1myZY0tsT9RMXBBNP+STRoudgT9Ky+JkANUZT9dFsrdfwQr414EaPvF07+ZT71iPV+L78wdEYJdCYIbS0/CdS0JIVmmWYyBwFQYmbOpOnXcRy/Blz5o5OmGbMbfBv5fP00h43numas/0+gX/Kc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec602292-2ca0-4505-258d-08dcdd711467
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2024 14:48:12.4863
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uS0LhRBN3x7QGLej4NCTbL1Enp8N9UJi66vFu7paKhgx3cfW9B40hh6vISW8KJzeqS0fho8KAgtSM+gh3VlO467u+SJ1LVQQEuFAL7Q1lgc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7009
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-25_10,2024-09-25_02,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 adultscore=0 mlxscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2409250105
X-Proofpoint-GUID: Xwuo8DD0ab77DQ-v1RWa5Ov2GD3BCGRB
X-Proofpoint-ORIG-GUID: Xwuo8DD0ab77DQ-v1RWa5Ov2GD3BCGRB

On Wed, Sep 25, 2024 at 07:02:59AM GMT, Shakeel Butt wrote:
> Cced Christian
>
> On Tue, Sep 24, 2024 at 02:12:49PM GMT, Lorenzo Stoakes wrote:
> > On Tue, Sep 24, 2024 at 01:51:11PM GMT, Pedro Falcato wrote:
> > > On Tue, Sep 24, 2024 at 12:16:27PM GMT, Lorenzo Stoakes wrote:
> > > > process_madvise() was conceived as a useful means for performing a vector
> > > > of madvise() operations on a remote process's address space.
> > > >
> > > > However it's useful to be able to do so on the current process also. It is
> > > > currently rather clunky to do this (requiring a pidfd to be opened for the
> > > > current process) and introduces unnecessary overhead in incrementing
> > > > reference counts for the task and mm.
> > > >
> > > > Avoid all of this by providing a PR_MADV_SELF flag, which causes
> > > > process_madvise() to simply ignore the pidfd parameter and instead apply
> > > > the operation to the current process.
> > > >
> > >
> > > How about simply defining a pseudo-fd PIDFD_SELF in the negative int space?
> > > There's precedent for it in the fs space (AT_FDCWD). I think it's more ergonomic
> > > and if you take out the errno space we have around 2^31 - 4096 available sentinel
> > > values.
> > >
> > > e.g:
> > >
> > > /* AT_FDCWD = -10, -1 is dangerous, pick a different value */
> > > #define PIDFD_SELF   -11
> > >
> > > int pidfd = target_pid == getpid() ? PIDFD_SELF : pidfd_open(...);
> > > process_madvise(pidfd, ...);
> > >
> > >
> > > What do you think?
> >
> > I like the way you're thinking, but I don't think this is something we can
> > do in the context of this series.
> >
> > I mean, I totally accept using a flag here and ignoring the pidfd field is
> > _ugly_, no question. But I'm trying to find the smallest change that
> > achieves what we want.
>
> I don't think "smallest change" should be the target. We are changing
> user API and we should aim to make it as robust as possible against
> possible misuse or making uninteded assumptions.

I think introducing a new pidfd sentinel that isn't used anywhere else is
far more liable to mistakes than adding an explicit flag.

Could you provide examples of possible misuse of this flag or unintended
assumptions it confers (other than the -1 thing addressed below).

The flag is explicitly 'target this process, ignore pidfd'. We can document
it as such (I will patch manpages too).

>
> The proposed implementation opened the door for the applications to
> provide dummy pidfd if PR_MADV_SELF is used. You definitely need to
> restrict it to some known value like -1 used by mmap() syscall.

Why?

mmap() is special in that you have a 'dual' situation with shmem that is
both file-backed and private and of course you can do MAP_SHARED |
MAP_PRIVATE and have mmap() transparently assign something to you, etc.

Here we explicitly have a flag whose semantics are 'ignore pidfd, target
self'.

If you choose to use a brand new flag that explicitly states this and
provide a 'dummy' pidfd which then has nothing done to it - what exactly is
the problem?

I mean if you feel strongly, we can enforce this, but I'm not sure -1
implying a special case for pidfd is a thing either.

On the other hand it would be _weird_ and broken for the user to provide a
valid pidfd so maybe we should as it is easy to do and the user has clearly
done something wrong.

So fine, agreed, I'll add that.

>
> >
> > To add such a sentinel would be a change to the pidfd mechanism as a whole,
> > and we'd be left in the awkward situation that no other user of the pidfd
> > mechanism would be implementing this, but we'd have to expose this as a
> > general sentinel value for all pidfd users.
>
> There might be future users which can take advantage of this. I can even
> imagine pidfd_send_signal() can use PIDFD_SELF as well.

I'm confused by this comment - I mean absolutely, as I said I like the
idea, but this just proves the point that you'd have to go around and
implement this everywhere that uses a pidfd?

That is a big undertaking, and not blocked by this change. Nor is
maintaining the flag proposed here egregious.

Blocking a useful feature because we may in future possibly add a new means
of doing the same thing seems a little silly to me.

> >
> > One nice thing with doing this as a flag is that, later, if somebody is
> > willing to do the larger task of having a special sentinel pidfd value to
> > mean 'the current process', we could use this in process_madvise() and
> > deprecate this flag :)
> >
>
> Once something is added to an API, particularly syscalls, the removal
> is almost impossible.

And why would it be such a problem to have this flag remain? I said
deprecate not remove. And only in the sense that 'you may as well use the
sentinel'.

The flag is very clear in its meaning, and confers no special problem in
remaining supported. It is a private flag that overlaps no others.

I mean it'd in effect being a change to a single line 'if pidfd is sentinel
or flag is used'. If we can't support that going forward, then we should
give up this kernel stuff and frolick in the fields joyously instead...

Again, if you can tell me why it'd be such a problem then fine we can
address that.

But blocking a series and demanding a change to an entire other feature
just to support something I'd say requires some pretty specific reasons as
to why you have a problem with the change.

>
> Anyways, I don't have very strong opinion one way or other but whatever
> we decide, let's make it robust.

I mean... err... it sounds like you do kinda have pretty strong opinions ;)

But anyway - as to robustness, again, could you please provide examples of
possible misuse of this flag or unintended assumptions it confers (other
than the -1 thing addressed above)? I would be happy to address them.

If not then let's move forward with this useful feature?


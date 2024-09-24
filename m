Return-Path: <linux-api+bounces-2333-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 08FEA984694
	for <lists+linux-api@lfdr.de>; Tue, 24 Sep 2024 15:14:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A3821F21073
	for <lists+linux-api@lfdr.de>; Tue, 24 Sep 2024 13:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3059B1A7265;
	Tue, 24 Sep 2024 13:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fJ6W4Nez";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="YwDQNptf"
X-Original-To: linux-api@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 378D9149C54;
	Tue, 24 Sep 2024 13:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727183644; cv=fail; b=E40CHYBm4PIxLYkQl/Vnt6t6ItkWC09vjmfRIhOfvMvciJpyaQKlvYn7ZvgVJXb/lKfcFAfUj+QJIa9KKlKWKkP5uyfWDU7gUkWDrl9qplIxQ+LS3UdUtTXDHZc41yUIq5cHZ1dLA6XL0q5tlJtGYyEGrnOwLTQGDyqGwx2jzKo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727183644; c=relaxed/simple;
	bh=M24UAGAjbVlwXn6YJcr5TSIy0IEt8llyOnKQpuqNI7o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IqsQoR59vtaCKsAmPwDr8J1Apbkqp6QCtJ7l3uRVotwNi3q8A1fIyNfo23ANm85nAdBgq9rLwd7EWQxQ4QZd85SEGxEN4fty1ganUtSdPyTFME5agxtD7A3M+s1pc+2olV+UnWwfdQ3tiRauj7vPpl2HABKqSSQDqZ4wWxthT3c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=fJ6W4Nez; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=YwDQNptf; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48OC90YP026254;
	Tue, 24 Sep 2024 13:13:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=tAqnu8fSD9M0GRs
	5u7WcGUtJ5pw2UWY4KO6AgCk7YSQ=; b=fJ6W4NezomkSHpTRVla2us3/TPp4oRj
	yLnKNn/uwheYLMi0J5R3pl2s1S2ElkF3Eu7fm40LSfvWSi0aNUFLX5tMC0+cMbMQ
	Va0pSc4oXMhC+Vr8md7olIa+uszvxExBcqcFeu9aZyP9ym3ztAxgc4ehxU12PB5A
	xne5wa/+Pl70WgKk7DhDNcQ2SOGcFTZpnYmng+FMY7Z+IW4sILNiAG2XdXhgnILM
	JV6Hzrile+jiD8BP9wk6U7Pod9VlVWx8keOypZ2HdFc+c8QJb6bWecMz0F/N64gt
	sVwSpXWHyQ2KEe+wCZHUpdInlqwL0PMCK+VaIk+mzy8drAQh6PCYqcQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41sppu7cjs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Sep 2024 13:13:23 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48OD87R7000461;
	Tue, 24 Sep 2024 13:13:22 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2043.outbound.protection.outlook.com [104.47.70.43])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41smk8wy3s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Sep 2024 13:13:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CgyAQuh7fYoMCbJKVPaOcAhyyMTuADaujaMRrJ7qwaZsPRvo5gN0HebWQa7bde0+MtvVxHgpRQJtP7U3Y84ZFfpIxnFblejmFE2V6SBvEpYJaC/DGzbwo48yfb76upgaV2DbtZB6gJjKH5iYznIsHTmAIk4yG2/Z+9MaRQbT2RTflske56MkNrdDG0nwuM9AxxxiV7V5nxeBbf26eEZbxbvJsTM7RyLLpsqDUe6GAzZ5iSmG+egBmqaysAwXx02oMIQBk1M2cyXIxO7CDsDc6QSgj8R8qrNhZinc1v3nB48wh6lOisZ8BTHxObwC8dJ1btYloF2TISyRY4x0LDfKoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tAqnu8fSD9M0GRs5u7WcGUtJ5pw2UWY4KO6AgCk7YSQ=;
 b=x+ZNWZlG1iFz7ZUh//oGhPNMIannd+Jn6ShQGfMMIhxPmCJj4FHTZle++XyxH6CbPthpzNnHeDpR6Ud4qu2KwPXiwC3Agu6DYw/HnNxrlADzXuwIkCMtn1C0hyvcymfWeDOmnL4N8cmplGaCXJ+D4lHWDWfdSsyvelEMlST7tN78drZNd2yOs4DtJB0AxXINSwt9CIY8qIzd+0kqL8RlpS3itWbeHMngS1tnbbnB7HFvHDZS6WmOvtP6v6fRtV60n/hRu3JB7b0x3BA3//dyoi53L/va9jAR28LC9TWitW/7cZd6M743TfUVtbZd3U0jr7PoFW2kdgfyOhw4jVuneg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tAqnu8fSD9M0GRs5u7WcGUtJ5pw2UWY4KO6AgCk7YSQ=;
 b=YwDQNptfwQpKtrKYmsSQphzvFF3PPVRnZOaEEH9Y4ndIQXSNXSmeo/AoM1fhA8P+XmwLyU1+JfRTKl7ClrPEEuVjnyOcIChQsxHHnRFS+Ay5V8I2ulP35U4Zyp3WcoKU6zq7H7mCOdSPT0ga7qdkYFouVjplnnLNQCiH47iiUEs=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by DS0PR10MB6800.namprd10.prod.outlook.com (2603:10b6:8:13b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.10; Tue, 24 Sep
 2024 13:12:53 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.8005.010; Tue, 24 Sep 2024
 13:12:52 +0000
Date: Tue, 24 Sep 2024 14:12:49 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Pedro Falcato <pedro.falcato@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Suren Baghdasaryan <surenb@google.com>, Arnd Bergmann <arnd@arndb.de>,
        Shakeel Butt <shakeel.butt@linux.dev>, linux-api@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Minchan Kim <minchan@kernel.org>,
        Richard Henderson <richard.henderson@linaro.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>, linux-alpha@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org,
        "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org,
        Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>
Subject: Re: [PATCH v2 1/2] mm/madvise: introduce PR_MADV_SELF flag to
 process_madvise()
Message-ID: <4740dfc7-71da-4eb4-b071-35116288571f@lucifer.local>
References: <cover.1727176176.git.lorenzo.stoakes@oracle.com>
 <1ecf2692b3bcdd693ad61d510ce0437abb43a1bd.1727176176.git.lorenzo.stoakes@oracle.com>
 <u64scsk52b3ek4b7fh72tdylkf3qh537txcqhvozmaasrlug3r@eqsmstvs324c>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <u64scsk52b3ek4b7fh72tdylkf3qh537txcqhvozmaasrlug3r@eqsmstvs324c>
X-ClientProxiedBy: LO2P265CA0143.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9f::35) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|DS0PR10MB6800:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c071dc0-6e87-4556-d194-08dcdc9a98d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Tlq7pkb6W/zPxFL21yxx2iEzxVGqGf7gfSu966cyMwPl/UM3lQmzo4/jXUV8?=
 =?us-ascii?Q?NbrrmOGVJiv9qMWqbPeABRZZotmM6xzZR2vOBd6of/emBwnob6iJYiVeulLS?=
 =?us-ascii?Q?VxV4i8JGk1JDkVxSkFprNO3E5+uYn8rnjPSvsCd10kyOSddeSU8E+oQJ1vHW?=
 =?us-ascii?Q?ttcpfTfZLbu3mTCD4wGIbW9VUAQSgFBgajyrwOl6sl7hBUrNUAXPc4UZ2+ot?=
 =?us-ascii?Q?daIRv5orBgjTK9Vtk4G9mP0wiBz6GZGZJ7uyYcJ1juJGup1qvvJSVydie7xP?=
 =?us-ascii?Q?vFxRLMu4SwAA+32tKWZBbZ1IJNjLYhSmkXtlO21GSjCPeE3LdrwUXASSJLoD?=
 =?us-ascii?Q?w3C7EeRuDfaFOh04uANpXs8zVHWKrX4ee7L4QUBaequmWoka3UveJgQByCSU?=
 =?us-ascii?Q?te6CNYsklGawmSOYYmMdbJ3F3gTGJNcd/HnssLn+cCT/C5yIeNPqT3Csryzu?=
 =?us-ascii?Q?0daDudg5D0Z9lucGBMHuRpBzZC1/pwHFx04CtrEndqh2WlfgaK5yUgTtFb8i?=
 =?us-ascii?Q?Hv205GMO/QJKJqCL3f7UviO1O+O0ZITvRZUxdEWSLj/reRpw7lld3uk31YFw?=
 =?us-ascii?Q?IFzGUuouKf92Hpuo//2bBi5EPYZ9nheEWP8IjfQr8dbDw4/QfFj0tOHUvtWX?=
 =?us-ascii?Q?R9vUHmWzZGqXJ1G/pgovtBkIS7ZigKeW1gomQ8GJrV2qWRDqRfSsxhZ3jj+g?=
 =?us-ascii?Q?8vKek2UnKbNYGu2CQYimKsLfVl1pBzkzIaexlIJiplnUOBSJaL223zwS3wHO?=
 =?us-ascii?Q?Y34j7yc1OqF3baL+oL4GSNIZpzLYyiCU3Zeu0uI9J42giZLrCapWB+AlLI7/?=
 =?us-ascii?Q?+fiC2MBLP6SOgmPNN/5VIR9x7HeU3hHQerBM/eDbI5so/YFfctThgiCBOOiQ?=
 =?us-ascii?Q?09Gj+F7sAh+2ga6oEmbFEgbHMKZWZoLbSH+W2HQtaLXJap7o2MyEUCS8clfa?=
 =?us-ascii?Q?5TqSGn4puVZzk34LPi48Cjyu2JHCWKO3LN9rHRWbsnNJ/AkTuhLHgS10I6NG?=
 =?us-ascii?Q?zf2AKDPysjj/8fdtlVWSqd84vilgnaGB47HUJ5K6TF93Yrw6rBXcjY+07bBf?=
 =?us-ascii?Q?lkMxnKcKZnDOhbsFLdj9nKy7v+ewwXLFOsmksTfQSHkz2PGi6GxcdyIH2Zyg?=
 =?us-ascii?Q?XPD5zDLnGbXcrfLsiLiPNiqX1ciBCJHbxdvzpHRJQQR1nF4DXFSWfMrAJn8k?=
 =?us-ascii?Q?XmuMNCVvPH5aiS8dWq/mNzOHgWAxPHZDiJM1U9sEj0VPXivDyUz3lfUX9J2p?=
 =?us-ascii?Q?E72TNcZlXFDvmFlma9xYAHfVFzr/UHWVGTj9I5yGPRiBPtF120KezrGDwkb4?=
 =?us-ascii?Q?V4W8AHuEXOtNAIH3JHhvHFsm2JBu+KgCl4OGR7PX6XrVJw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?764jOreYD7ugSjC4CQaGY11lMLAWt8FVzuIim4OM8MDTG4CmxfDq43j7UG4t?=
 =?us-ascii?Q?lE1iGp3NFo+gEeofqFWiFfB0WrpkTjS7Sk0tgB8Po/YWIFGtkkUMjx4Z2gux?=
 =?us-ascii?Q?wE/ZWSV1x0DUjA5VW49TB9b5x4dA6r2Fc50MG48zGwWbYCLCQUuaGczn0M8+?=
 =?us-ascii?Q?n7wfj6dGIoqkZQsloJpBBArz1ehQxP7VityeQtVWl/XkZCBQkUjqSIa5nYSP?=
 =?us-ascii?Q?y/NPO+P2Yrr8OVnumrOCyip5g6KXFwQYWU9ZmPZHIymqoPxxrqEj9rPHc3ON?=
 =?us-ascii?Q?4Pw1qb+aaw2NH/mJAPBOUD0ks8uWBsFvTdvF+WcMhYjB9C4t4mSmSRv0QC2W?=
 =?us-ascii?Q?jQUXF+6UcstpuDx4fzdZaZ0UdFjbtOpSW4FupyUhpN6Nb0FOBucKsSMpwkY9?=
 =?us-ascii?Q?mU+WJG85uSXWQLuyfN/Wh2N0tslsUnyRZ7BJNltsKYQ43+Te/NuCwGF4vqlH?=
 =?us-ascii?Q?dLfPAgshBxSEkUw3/BsPy8gP89CnCPzawn/VMINser5yjndSTOb/FGWUGjWJ?=
 =?us-ascii?Q?h9OZ52i/uyhGunhJ4VJDIoCsmXHsdNxCTnrOKBImylC+yUqtsFLadsgWUmDl?=
 =?us-ascii?Q?S/kzpZwfgTFLKo5Tih3N22zYxW7MURcMzev2XMMO9Iv4Fmt02emL+TOZx/5A?=
 =?us-ascii?Q?+6J9elWOzMELmFGw9geqd8SVUNHlyJHXbCtcAYynkAIWEb+Q+loBRdTlZaBU?=
 =?us-ascii?Q?nGhz2bOfJr+W9lmTQj3gZCJa7UQI9O2vKSCdjOdSaFNWSeaTAocMG7SGQ2DJ?=
 =?us-ascii?Q?JxCVwz6JQ4GIjpAclZZY4JsHMkW9Vp4yH5f8U5hO92+FZvrgFq7MQIO2i75z?=
 =?us-ascii?Q?1IbrtKWlvK0u88yEtycRR/fhGoP7GR5kzXJv8X7uJipTbvd1zZiI2Uq0Jxsv?=
 =?us-ascii?Q?/uQ2rPpKgAhKq44vhcrc122KYROt1dwJGsdQscDAhXXakrtFdOyuRX4zH1CT?=
 =?us-ascii?Q?pbayrGPoK0SxsoKX7a8hGv2d7lr6sTtHSlO9JYZnwJsEDaI+uZoc5M3rg/Yd?=
 =?us-ascii?Q?7jdmqF7TREaTEWZKLUCEbzskXtj5BCAnv8p6tir0YuM9qMqiWVSgVZF86pTn?=
 =?us-ascii?Q?s7i3XWssNk9puGklFwkeikDx+cnVu8cT4558oCC8d8VH2ghsjG39UpBwI547?=
 =?us-ascii?Q?NdQGyLiWAkt9aHWddEwcZbS/YX7SGq6DblTUJxIhIrl1sXzroxuo8tC5H2Fl?=
 =?us-ascii?Q?2jVEZq3X3vxUdW2CEwHAhKiTJO/Lweh0jUrAOzvKg3bEFU7EUfYJO3s9jlV4?=
 =?us-ascii?Q?UhvzQJad7NlfhEy1QWLPN8EVkQ3oyjsaKL/XPGTByd/OG0je5XdzS2G58g1N?=
 =?us-ascii?Q?k+v3DLxkgYP7TUQoqpJE8+FFfwLPYKwVR2R4iD7lXElYvnq7Q9dFVh40OCJq?=
 =?us-ascii?Q?mL/tLM/Xj7dwIf0K0pFPdp1dRUkNHctPXee2tsUVJpRJB6pnca5j1tmkrZnu?=
 =?us-ascii?Q?bG2MkGWm+HrFKxfDDMm1RcZ1O2w0q+oiON0LurOyucsp0zS86FWERm/120N6?=
 =?us-ascii?Q?cEobizr6Tod5pJe3J+WtoeqC5eN56723jQXRjxkasy3z7IjTi52iFhRYl8kW?=
 =?us-ascii?Q?VfNBrnOF5KdXae2FNxaYm+sy2t+OpvJWz6US6FpMARa95sduMxyDkXwKaMEi?=
 =?us-ascii?Q?zQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	u8RCHUqo55Bvr1h5WHhEjWtLQrXp4orIH1MmVKrcZcUrHIg+4lE/Xr3DEbcgwiCbrxHegL2cIDlc9uDxg2LZquwV4L7wg6DI3lV+5/j/JtqYZuiK0bav1GI3bBlgTj9jAUQ2UGbZxzdbSq4zhjXE9gW9djrnRz4Dxv4QjrT35RqroMHN1JDWaXimfLq9F0rf9cDKpL2y+axzR/07qEji1qfcwCayU9jitlGPe28l6scRDai0k9Sn0QS7DiIYoQUtTXYLzf7Vpt5iJHzdiI3mqSMF7GIhuklrzxhtInN5VreP8UH6okV7DrDVnBCTFWq/NmabinBgNBMRXjUrRQqBvsLmWvkSqPubQ9agPabWiBEoGJ504vntWuzrtcBNi1uDjZkaDZ/4A2eLLDboncz42xJnAa62t6oo6EJu9CPpkTSNGCUll6u3h25Rm0rDNnN0ALI4hTVszQIsieAplaObW+OGkaY0UFeEdUXVi19CjYATBrWhvk9XPryf2oFxPcHLZA99hsa6bxkSK6HX4CZJc9Q/JpJMJkIHpqFCXR2qGqA71r46ziTbiCebwwGnhQ9+rtz28wAB6enX0yDgogh8WDiYktAKeoU2CY1HF7TIQ14=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c071dc0-6e87-4556-d194-08dcdc9a98d7
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2024 13:12:52.8605
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pGku+1D/CvVknaVDmoiFgeBIt2ayjNZgNjNQCX94EaRZTuNrZp6vl1aNgw5pftk9JquLzJMdeYYhvydDG3GCl7tcl+V6uI3znkVhtfAsZ2s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6800
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-24_02,2024-09-24_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 malwarescore=0 mlxscore=0 bulkscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2409240094
X-Proofpoint-GUID: MdGomXpFxL2lrrYDEHfA0w_WUyxAx8Dv
X-Proofpoint-ORIG-GUID: MdGomXpFxL2lrrYDEHfA0w_WUyxAx8Dv

On Tue, Sep 24, 2024 at 01:51:11PM GMT, Pedro Falcato wrote:
> On Tue, Sep 24, 2024 at 12:16:27PM GMT, Lorenzo Stoakes wrote:
> > process_madvise() was conceived as a useful means for performing a vector
> > of madvise() operations on a remote process's address space.
> >
> > However it's useful to be able to do so on the current process also. It is
> > currently rather clunky to do this (requiring a pidfd to be opened for the
> > current process) and introduces unnecessary overhead in incrementing
> > reference counts for the task and mm.
> >
> > Avoid all of this by providing a PR_MADV_SELF flag, which causes
> > process_madvise() to simply ignore the pidfd parameter and instead apply
> > the operation to the current process.
> >
>
> How about simply defining a pseudo-fd PIDFD_SELF in the negative int space?
> There's precedent for it in the fs space (AT_FDCWD). I think it's more ergonomic
> and if you take out the errno space we have around 2^31 - 4096 available sentinel
> values.
>
> e.g:
>
> /* AT_FDCWD = -10, -1 is dangerous, pick a different value */
> #define PIDFD_SELF   -11
>
> int pidfd = target_pid == getpid() ? PIDFD_SELF : pidfd_open(...);
> process_madvise(pidfd, ...);
>
>
> What do you think?

I like the way you're thinking, but I don't think this is something we can
do in the context of this series.

I mean, I totally accept using a flag here and ignoring the pidfd field is
_ugly_, no question. But I'm trying to find the smallest change that
achieves what we want.

To add such a sentinel would be a change to the pidfd mechanism as a whole,
and we'd be left in the awkward situation that no other user of the pidfd
mechanism would be implementing this, but we'd have to expose this as a
general sentinel value for all pidfd users.

One nice thing with doing this as a flag is that, later, if somebody is
willing to do the larger task of having a special sentinel pidfd value to
mean 'the current process', we could use this in process_madvise() and
deprecate this flag :)

>
> --
> Pedro


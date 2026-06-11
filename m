Return-Path: <linux-api+bounces-6599-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id x2uECpRUKmr+nQMAu9opvQ
	(envelope-from <linux-api+bounces-6599-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Thu, 11 Jun 2026 08:24:20 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EDF066F001
	for <lists+linux-api@lfdr.de>; Thu, 11 Jun 2026 08:24:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=hLQBc8df;
	spf=pass (mail.lfdr.de: domain of "linux-api+bounces-6599-lists+linux-api=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-api+bounces-6599-lists+linux-api=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0761B3026209
	for <lists+linux-api@lfdr.de>; Thu, 11 Jun 2026 06:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 474A035F191;
	Thu, 11 Jun 2026 06:24:15 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B07602D73A6;
	Thu, 11 Jun 2026 06:24:13 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781159055; cv=fail; b=mI7u1z05cEOrENQwGYwqpAA6TUqG8e9+2g1D5U0GKnkrpFtCHFtmQwFJBrcIQZCOtck5x+figYOJttElTYNfrRvFE8cMRtO7XuihFR3aWeWw+nz8iEZKYTuAPcrzYyGKo5EiFBai9v2HllAdN3HHGfZuE0Iq7nu7P5CsuEX0vYQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781159055; c=relaxed/simple;
	bh=jPq5/4WAAPS4J29iFoUG4nu1Ga3P3Ny8sNaXodLFUEg=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=qIZwc94we7XOukseEWdU+R8ktL5ioRj6RCs+CFNlezxsMr5MbmFRRKc1o4r4k95ZMiviAVIJZF6xKd//TeD/Y9byX+HRV8FTr5+lfq0bhylOYpdlFcU7hYWNyMQziw7M58yTmdixCxM1VbzMabMn4xcExOXFUw2X4T5XNQ2xiAg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hLQBc8df; arc=fail smtp.client-ip=192.198.163.17
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781159053; x=1812695053;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=jPq5/4WAAPS4J29iFoUG4nu1Ga3P3Ny8sNaXodLFUEg=;
  b=hLQBc8dfoZLnXaKW2HmoDedU/NdGxf6Un+VfrIedZFThQp5swAw2S8ga
   VDL6Bi1c7GDmxk01WM67gcZasVsDrYFQFUB+VaXw8KjCXlQhQBQetFOcA
   kFk5iQbu6frGv5MvK11cSzyRl7VyquPNZCmAMDkKaO8fPm53LB8PhJCqM
   qpsfiOf8VQQgxNFm44MsJRnIibGBi4q23QIdxZXfSVtracp47fmypFKLM
   nl78XYbUZIc+ao7nI7s7i6+N9tdnq+DAC0KXLsw39O1wvPhSF0CclNHcW
   UUljSal9T9BxHd7L5cAIs2eDcoDu9ziBYy8cZMC17IOIyuYuejfswpjdN
   g==;
X-CSE-ConnectionGUID: 18wHzJDSR8+f+dfvZf9i5g==
X-CSE-MsgGUID: jWn3UyxFTdmvnm55DWIH3Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="81813075"
X-IronPort-AV: E=Sophos;i="6.24,198,1774335600"; 
   d="scan'208";a="81813075"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2026 23:24:13 -0700
X-CSE-ConnectionGUID: RMKXXxFoR526xMXoITQM+w==
X-CSE-MsgGUID: AsSER8NbQjCLti/u/trHww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,198,1774335600"; 
   d="scan'208";a="251485717"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2026 23:24:13 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 10 Jun 2026 23:24:12 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 10 Jun 2026 23:24:12 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.43) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 10 Jun 2026 23:24:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oChb4Lhx0tGxQJCYD99qZ4UUS944fPGFOqQUR6Hu8YEYOUeFG4xX+JokstRIMyqdBiFYnwogqKI4/5kZ/UzVNd42t2aXJDxP6AiVEgq0hXPkL/Xd0vTL3IefGDTW1DNdNZggmn0HAoWRuXVdYkkEn8yEvfWZV7NBvBNvufC9v//G/Rn1/j48yoA8uPZRGbwzwyMsAi7WpWNDbr4EzxuUaqUaR/GXsZJbH4rv6LKBQ9HGiRkGiWWPwYOYP6HdaCHudcU329XXEcOTR9HYFto/k7CRZ3PzizVIYRTUvLvVlDUDCX0PG22FEGrCcKaM2IhwnnrQs2lDAmKXfAccDqSvPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4XMy/byEHkafaOk3znmb9L5yziOw4yI/QvH75Jj3VOs=;
 b=nq62xME2dPgwGWCFdKKmS0AgUoVst4FuVlnJH1Cxgg53aYfbYhvHDUvxxwzqRjyMcIR39cejdZj7UKw6FJO5ketbY+M9BXuPVHnXQRs2aq72YrF2VWWiCc4d7+EDKlkI7vEqjtHq07f5KKWZ2tgM8dUhtWKIyvhemDxH7GOuBwr2UyLv2EjjNGlH2eAJCvLXXGp3wtBRk2aQigvcjuJGAG5SJiQAjgJCviSQVNFCNWPbLlsS9KvrCQ+HB0T5/F9dyrWN6xtiyHgUfRglClp8lP11jNzn6wp+4gLIJrCCZ+YL28rOBMKFvO1xAxWGumw6JVG4o0DWQXT/SP02ZQkpyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5832.namprd11.prod.outlook.com (2603:10b6:510:141::7)
 by CO1PR11MB4993.namprd11.prod.outlook.com (2603:10b6:303:6c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.11; Thu, 11 Jun
 2026 06:24:03 +0000
Received: from PH0PR11MB5832.namprd11.prod.outlook.com
 ([fe80::106e:78dd:4c96:d707]) by PH0PR11MB5832.namprd11.prod.outlook.com
 ([fe80::106e:78dd:4c96:d707%5]) with mapi id 15.21.0092.011; Thu, 11 Jun 2026
 06:24:03 +0000
Date: Thu, 11 Jun 2026 14:23:52 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Askar Safin <safinaskar@gmail.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Christian Brauner
	<brauner@kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-api@vger.kernel.org>, <oliver.sang@intel.com>
Subject: [linux-next:master] [vmsplice]  e2c0b23680:
 stress-ng.vm-splice.vm-splice_calls_per_sec 10.2% regression
Message-ID: <202606111018.cc992614-lkp@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: s-nail v14.9.25
X-ClientProxiedBy: KUZPR04CA0012.apcprd04.prod.outlook.com
 (2603:1096:d10:32::7) To PH0PR11MB5832.namprd11.prod.outlook.com
 (2603:10b6:510:141::7)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5832:EE_|CO1PR11MB4993:EE_
X-MS-Office365-Filtering-Correlation-Id: bf43496f-3b8c-4d2e-98f6-08dec7820696
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|56012099006|3023799007|11063799006|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info: RSgw84A46BnzDdcI0fbtiEhwDzMnnudVI9RbjrCRH6R/klV13a90b/7Q+aLyOXnOnIpbvatDSOdfof3nx5I8nbwbE36IzXGlw73rDuxXy4qZPBGnRYhIo436FGqTghHWg/4909yztI6wyXIo5SvTyIP2YDMYDHfCiKKIn9Et+XUumy9OjKaF3rHW3CTc76jW+vhALrh9r8PKdDJ5+/Yg/La2lo9+JBKrwRxYOrUg8jCTAsms29L9LHnJOI1ICtELBBdEI8bqB7NiFIprn4BFNOeeaooBFr7bBvT3LzRvQZSi4PMidFBXWUtYHjamkJ+ob/X/vT2+jLZgH/WQxpybTpm315dA63eYVcjbzrJ8kG0lYjznxyihwCTbFm34YryIaKkjNfwfN/lR4ux3v55yIwNC2jKIjfRH96sQxfypxQGxCK+UviCjt2dxXIJBA3j7+EiIKT2GDv7kUjFDb5MHCLEIc2qH9EOLLIintiMbuORouVUYAWAVNNEkLkAXN84ro+T2ODgbwpgchfNGVH112StlwwPG99K+jPOGjFxpBQZKTtNjkGKLHJN6HQau9TEgidCZ7jB1ZNIFofC8FsSzBiAufcdCAS7q4ezqlUDPUFAE9m+RDv2JP8FE7xjLvVsKjcbVKCIms8hm//pNEbti4PXKgg1bwN5tC1cKMBRlJJCbfjRvuL18FfTFMCxFQJbxcPZukky8ih3BVEu9MCAVJA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5832.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(56012099006)(3023799007)(11063799006)(6133799003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?RF7B4vA6JfEkMgQucls3F37TuIXEc9mZp1gp7MYaYw7hrc1hf9Abwii513?=
 =?iso-8859-1?Q?Mny0RRYJnGOeBEJ3iuJZTwMSOOyhNqk59GoqvLKRJfRWBtEATLltNpPBIP?=
 =?iso-8859-1?Q?v+Bz0RyNdSWzOPwRQPagTWe3wKHeITnAMAExAkOTQ+D0tCJImZB/qSt6Zq?=
 =?iso-8859-1?Q?9u2Go5JF9P8gtApfWhMT2ddxyqQDgmpvPRtlBustDm3RXL8S/7/QypWF17?=
 =?iso-8859-1?Q?PpqG3SbyG08+zJrYKBlhMlkmhaSc7HPZ4oubMX/Lb8O+6fyvDznMclJ2Zy?=
 =?iso-8859-1?Q?3r8PLTglhT0i689PbGGqEUJPFxtKpuJuKhjIJuRA5RnZtz60juVlTb0MPh?=
 =?iso-8859-1?Q?8aQVi3upN71oqRCmPN8PO7v6Kh+uWZH/cNWiOZDvrKyt8j/HBfDgewy8Yb?=
 =?iso-8859-1?Q?voRH/TTanreous4S851WppbS/aONadTFYdkoTRgT7gYdTJEDO3SFhn5w4G?=
 =?iso-8859-1?Q?yPdRMFvf5L5yzQxye4u5285G/1qbRPV2tlUc+D38sfB88N/+6kikPkng3g?=
 =?iso-8859-1?Q?mYZYjLV5C6N1zpBdi1ITr38j71acn+2PLhB6KxihxGioP/OYQEarnNiUSv?=
 =?iso-8859-1?Q?vphZghk3EljeCTQkTc/EnoxMgfKiKlk/XlvgIOeGn3GKeBi3ts3zO2qA4p?=
 =?iso-8859-1?Q?rkKl56l3f7zlS1fQOea8MNcVG65IA3um7gNdg8azQ36P/VatvdMJ6NHX4w?=
 =?iso-8859-1?Q?f5ejW5YS5pGV/e0XjxQi6VmDbdPVE38H9FXRoK6op8px8i0OxJhNb/zBFm?=
 =?iso-8859-1?Q?4F69YYAzmI9UfGHsPkUCzVUQ03S7wET2Y81SGeL6Imx7wlc/EmeuYqrqZf?=
 =?iso-8859-1?Q?cwdJqlLSTglABWyWpGmeJyBVTSxWhm40Tnh9xgahSJQikjTl3xs0LzzWwK?=
 =?iso-8859-1?Q?jnUSP81dNmKW2s6k7bhKrDVLq053u9nqqx6pTWYTHtt+JAnwCu2peduw+U?=
 =?iso-8859-1?Q?eseJ9FzU7IpHUFjuULt/jN9Sc7XOb63Z77lMcJr+x9GE6DKCwgSkBDKdfk?=
 =?iso-8859-1?Q?Hl/CRIduUjceqJkEorFSlfeH0cdmbZMfsptx6XV8vINwykV+hHjGtNg6W5?=
 =?iso-8859-1?Q?swbTGf4e7tBtE5Jcdx2I3RcOMc4TnGVOc1E1uy0bTDOUIoxUR/L4d8Lrqq?=
 =?iso-8859-1?Q?VgBRuGNC44Ea+TXqGsA+ZnwFJ/pkjaISEzb8XK92HRLKpjGjCX7EC/ru/M?=
 =?iso-8859-1?Q?HaBE3arZWDTuH4w6wGBgdBTJMKVt659co/sA38+x+xNZQ2raFZZM8SCLV2?=
 =?iso-8859-1?Q?N3CM+3WJNVAVReF8IUDAXbCcm211tJSnf5QEc9MadsdTAQiUaX+EB2aDvp?=
 =?iso-8859-1?Q?Bb1A4XYebjv6ORKgfipZtzgotvrhB0JhJX7zFcuDTNBTYhpm7nioyHD0R8?=
 =?iso-8859-1?Q?w54SU2s6/HwTP8TRuji9ufwrMGC8Cfs4W9UJr0+d4sCJVcFzr6Xb+NihAZ?=
 =?iso-8859-1?Q?9F8QcmWiHAPr+LHuIuJZD1ROk9ujsKcuWIjs0Ds46S37WFVnSoBOTmEPa2?=
 =?iso-8859-1?Q?31Gea14Q+h2YEXlNFcW6QoStHPRzZcQwTo1KvjLJZkfzuAS1x+mNX0A7mK?=
 =?iso-8859-1?Q?hT7DX/VguZz9j4v9TNII0ArllD/EEvf7K8ym/+CzXLIuQGifRWiQNveRzt?=
 =?iso-8859-1?Q?/IeoMjsrjGijtVE78wJfZl6aOR7eQLU41lOqAvJnNTh19TN2pH96p2eIqY?=
 =?iso-8859-1?Q?XLoxNcV0dCAzp3pdFVf1wFkBk4MosyQTBhD6cxUWBE07e5R279KWEVpGt5?=
 =?iso-8859-1?Q?DHIKg6QWj2FTLCuTvPLNMXYoIci6iO+y61M05BhXke1BxOgJO9CyvCgm1A?=
 =?iso-8859-1?Q?wsCL2345rA=3D=3D?=
X-Exchange-RoutingPolicyChecked: OMu0z9STbq1TWavZl1TznmCf92MwSdDYUXFHz1Jd21XJcLQDnHoYQNLhx0qXXYKkFE+YebF4/2d9cRQMGjm8ZdLjxGzqvY71e24b+6NDQIiH+kHk+ugp83y/Gz6YYBMsuZj1gEvbm6vlN/OQTPyJEatpUp+ZhXHe4WIO7mgtOQn/BpzWlkp8Np8nLOoimPTZCqhUm3l4qaGf6noIDaQQu++K4F+tty6MxCZ4OrP1pxIJmGrAOBHxnKqSe/yURONV/LNTJMdj8sBwcYQn4X21Wu5lsl7/xSuz3oVOvxLgIjC7ii9IOyt96esj9fzSNmHEDb9pyB9dOMYg+lJzUaUkJw==
X-MS-Exchange-CrossTenant-Network-Message-Id: bf43496f-3b8c-4d2e-98f6-08dec7820696
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5832.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 06:24:00.5529
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /LDuZoY+xENUp2hsTJSz73aMcIY6xdGWH/iLrKoNrNU9buhWlrQgo3ydXd3XOY068xmN/usoLsMoQLZA9gRliA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4993
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-6599-lists,linux-api=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS(0.00)[m:safinaskar@gmail.com,m:oe-lkp@lists.linux.dev,m:lkp@intel.com,m:brauner@kernel.org,m:linux-fsdevel@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-api@vger.kernel.org,m:oliver.sang@intel.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[oliver.sang@intel.com,linux-api@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,01.org:url,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,intel.com:dkim,intel.com:email,intel.com:mid,intel.com:from_mime];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[oliver.sang@intel.com,linux-api@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-api];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8EDF066F001



Hello,

kernel test robot noticed a 10.2% regression of stress-ng.vm-splice.vm-splice_calls_per_sec on:


commit: e2c0b2368081bef7d1f6758cc9e7edde8521237c ("vmsplice: make vmsplice a trivial wrapper for preadv2/pwritev2")
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

[still regression on linux-next/master 6e845bcb78c95af935094040bd4edc3c2b6dd784]

testcase: stress-ng
config: x86_64-rhel-9.4
compiler: gcc-14
test machine: 192 threads 2 sockets Intel(R) Xeon(R) 6740E  CPU @ 2.4GHz (Sierra Forest) with 256G memory
parameters:

	nr_threads: 100%
	testtime: 60s
	test: vm-splice
	cpufreq_governor: performance



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202606111018.cc992614-lkp@intel.com


Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20260611/202606111018.cc992614-lkp@intel.com

=========================================================================================
compiler/cpufreq_governor/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  gcc-14/performance/x86_64-rhel-9.4/100%/debian-13-x86_64-20250902.cgz/lkp-srf-2sp3/vm-splice/stress-ng/60s

commit: 
  a9f7db50ed ("tee: fs/splice.c: remove unused parameter "flags" from "link_pipe"")
  e2c0b23680 ("vmsplice: make vmsplice a trivial wrapper for preadv2/pwritev2")

a9f7db50ed2fff96 e2c0b2368081bef7d1f6758cc9e 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
      2122            -2.7%       2064        stress-ng.time.user_time
  13281641           -10.2%   11928183        stress-ng.vm-splice.MB_per_sec_vm-splice_rate
 1.183e+10            -4.8%  1.126e+10        stress-ng.vm-splice.ops
 1.972e+08            -4.8%  1.878e+08        stress-ng.vm-splice.ops_per_sec
   3.4e+09           -10.2%  3.054e+09        stress-ng.vm-splice.vm-splice_calls_per_sec
      1397 ±  7%     -21.1%       1103 ± 10%  sched_debug.cfs_rq:/.runnable_avg.max
      1.28           -22.1%       1.00 ± 44%  turbostat.IPC
     74419            +3.9%      77317        proc-vmstat.nr_shmem
    633806            +1.1%     640727        proc-vmstat.numa_local
    331878 ± 13%     -30.3%     231247 ± 18%  numa-numastat.node0.local_node
     37379 ± 76%    +241.6%     127705 ± 50%  numa-numastat.node0.other_node
    298829 ± 14%     +36.1%     406730 ± 10%  numa-numastat.node1.local_node
    162072 ± 17%     -55.7%      71783 ± 89%  numa-numastat.node1.other_node
    332129 ± 13%     -30.4%     231269 ± 18%  numa-vmstat.node0.numa_local
     37379 ± 76%    +241.6%     127705 ± 50%  numa-vmstat.node0.numa_other
    298881 ± 14%     +36.1%     406833 ± 10%  numa-vmstat.node1.numa_local
    162072 ± 17%     -55.7%      71783 ± 89%  numa-vmstat.node1.numa_other




Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki



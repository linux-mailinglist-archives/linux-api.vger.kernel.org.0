Return-Path: <linux-api+bounces-2144-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FD01949F77
	for <lists+linux-api@lfdr.de>; Wed,  7 Aug 2024 07:55:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23CC6289212
	for <lists+linux-api@lfdr.de>; Wed,  7 Aug 2024 05:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 326B5198A1B;
	Wed,  7 Aug 2024 05:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CcnSmljk"
X-Original-To: linux-api@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 542A8191F83;
	Wed,  7 Aug 2024 05:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723010114; cv=fail; b=suCfmpZEwYNBe5Uho/3ItwyM1nkgd9bqNGHa+q7/tejeuOnpxQV75YWCgP2SKwZxJg57i90/lYa30Go+AZU0D0kS02X9b/YLBbKZ7K8XPE3DdHwOBhv8aFveKss0qnK2tNVlWf9V46V5UM7NlQGVEeiU6KeOdiZlTd2M7Kb1IvY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723010114; c=relaxed/simple;
	bh=BQVly84yE55e/5CqljtylDC+gwzQi8I39Md+PkHZ180=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=umr2cWZZ1wbQbJHTLmFmh2FmGeWdp2nVTuSc4hS3VDqazQ/+vefNGoLEZLk7yYCn4wgkiXYFaK/FQZNYQVy7oG+WXZaAISlipfaxNQXdf0/Jl7VI1noDqgErLgbNKgJjE7/dO6Q0eT4TyKNCRJkfjp+lBJaJuuHloVXuO6d3ZSs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CcnSmljk; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723010110; x=1754546110;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=BQVly84yE55e/5CqljtylDC+gwzQi8I39Md+PkHZ180=;
  b=CcnSmljkAYZzyjcNP9SgiSyf9u4w7ZFHgMnvO0AJeXvXyq+Stvf/7Lsn
   dx3WXyMuwBUDfXHOOJIJzYb7UJKDQfHTYHrHETBNpndC6MLVApCOzufmX
   Tv6lUrPag/mHtnV0BxxSm+JPfi1GlXg2uDUfiZoKDy2iogShsUE73PWtO
   mS1QhC5K8TjM9qwB5yAAkp/eBJLcmOjG2b2p9SEfLSUK/O1voSo7Yw0YS
   mjUzzsY6MnOVjVFPo3D+uVcmx00MvAMOZd5Hz4/o1GtGG1gNElpjMfcus
   nskqeVfjtbAhOmXIBvoHkotdCtAxKnkptIvKF1t28XmtpPP2dABfPFq0c
   g==;
X-CSE-ConnectionGUID: 2r7BLkDpT5GhQeOh3ISF6A==
X-CSE-MsgGUID: vKlpR0t9RLeoW70zg13lWA==
X-IronPort-AV: E=McAfee;i="6700,10204,11156"; a="31690254"
X-IronPort-AV: E=Sophos;i="6.09,269,1716274800"; 
   d="scan'208";a="31690254"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2024 22:55:08 -0700
X-CSE-ConnectionGUID: 9jRkNkGZTMCn0/Hl/F+7Lg==
X-CSE-MsgGUID: YrEpSe5KQUq42lzM8W+7Lw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,269,1716274800"; 
   d="scan'208";a="61682320"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Aug 2024 22:55:08 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 6 Aug 2024 22:55:08 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 6 Aug 2024 22:55:07 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 6 Aug 2024 22:55:07 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.170)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 6 Aug 2024 22:55:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=boI2/WX1NAfHeWWrEw/gNnOHvTjjP+G8VF19Sh/g1S2Xvcqp8ffDa/d5ulfatde5Me/cst/d3lpy+7MPT6RiT1n6N56d8jjlZBdOdR4MEsSTKsxUe88/eAEwGYmer2os6gJAwfijoTnmFioWKx1o2Zs4bJjQhEfmJoSgrMwibxTszjf4aeSXhx34cQLtXsd3S2sMvZDrIiD2bD5MeD858B4tRFAt9cgzVsjMLjo/XCWRqGKMnolY9e99J3Am09pjE/xhin40MVmMYPzhy13COzg8Cqt+oieRaR2sppnw3xnd6IGdcrMXpIbxNNzzsk1PZ0PxPRdLVvavXCgqDdT8Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M5WXcqa7MOFGrzdpYMdUFtRT789K2+NQ0KYU3nUWwv4=;
 b=chK3mu7J2Dz/uE3aWlcITBqtonLv19tkpYlZWao0aNQXn3RhYkO+Dr1T9Hh55vEgsj/gkXHhWBlX+55ibzIppXhlM3R2nQYDy9t0vLcFsB26Mxz8FPvasGsbBO/gmHtBzUSQMJ6MwbFAIi9N1f4JnWt6oUHdrHrXV3MRsqPYBbFeWg7mAdjNGKRK6AZhfV/XWantF38l0x6l/1oh4Xf3U71Gf111l/KDkPIZbkSRKgO9nO4zenCee52IP74pIfdpbyDW3vE9ugkhDrcMCz5cwPaB8gsQQEz1Q2kdlW0Mh0P/A4tDgd0ug7glz5NhI0anXWUgkGix4ZaItFXuSyd9Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SA1PR11MB6783.namprd11.prod.outlook.com (2603:10b6:806:25f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.27; Wed, 7 Aug
 2024 05:55:03 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.7828.023; Wed, 7 Aug 2024
 05:55:03 +0000
Date: Wed, 7 Aug 2024 13:54:45 +0800
From: Oliver Sang <oliver.sang@intel.com>
To: Pedro Falcato <pedro.falcato@gmail.com>
CC: Linus Torvalds <torvalds@linux-foundation.org>, Jeff Xu
	<jeffxu@google.com>, Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin
	<npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, Jeff Xu
	<jeffxu@chromium.org>, <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
	<linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
	Kees Cook <keescook@chromium.org>, "Liam R. Howlett"
	<Liam.Howlett@oracle.com>, Dave Hansen <dave.hansen@intel.com>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, Guenter Roeck
	<groeck@chromium.org>, Jann Horn <jannh@google.com>, Jonathan Corbet
	<corbet@lwn.net>, Jorge Lucangeli Obes <jorgelo@chromium.org>, Matthew Wilcox
	<willy@infradead.org>, Muhammad Usama Anjum <usama.anjum@collabora.com>,
	Stephen =?iso-8859-1?Q?R=F6ttger?= <sroettger@google.com>, Suren Baghdasaryan
	<surenb@google.com>, Amer Al Shanawany <amer.shanawany@gmail.com>, "Javier
 Carrasco" <javier.carrasco.cruz@gmail.com>, Shuah Khan <shuah@kernel.org>,
	<linux-api@vger.kernel.org>, <linux-mm@kvack.org>, <ying.huang@intel.com>,
	<feng.tang@intel.com>, <fengwei.yin@intel.com>, <oliver.sang@intel.com>
Subject: Re: [linus:master] [mseal] 8be7258aad:
 stress-ng.pagemove.page_remaps_per_sec -4.4% regression
Message-ID: <ZrMMJfe9aXSWxJz6@xsang-OptiPlex-9020>
References: <202408041602.caa0372-oliver.sang@intel.com>
 <CAHk-=whbxLj0thXPzN9aW4CcX1D2_dntNu+x9-8uBakamBggLA@mail.gmail.com>
 <CAKbZUD3B03Zjex4STW8J_1VJhpsYb=1mnZL2-vSaW-CaZdzLiA@mail.gmail.com>
 <CALmYWFuXVCvAfrcDOCAR72z2_rmnm09QeVVqdhzqjF-fZ9ndUA@mail.gmail.com>
 <CAHk-=wgPHCJ0vZMfEP50VPjSVi-CzL0fhTGXgNLQn=Pp9W0DVA@mail.gmail.com>
 <CAHk-=wgdTWpCqTMgM9SJxG2=oYwhAueU_fDHMPifjpH5eHG8qw@mail.gmail.com>
 <ZrG8+/1YjxN/Hsb7@xsang-OptiPlex-9020>
 <CAKbZUD1278Bq+5QwjH=LeYSgcugZ3JbvkLeoB3whei_gkEXV+w@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKbZUD1278Bq+5QwjH=LeYSgcugZ3JbvkLeoB3whei_gkEXV+w@mail.gmail.com>
X-ClientProxiedBy: SI2PR06CA0001.apcprd06.prod.outlook.com
 (2603:1096:4:186::21) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SA1PR11MB6783:EE_
X-MS-Office365-Filtering-Correlation-Id: a2d6aea7-d698-4ddc-0b1d-08dcb6a57ab5
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cHpTaVJ4V1pZd0V5SFMvcjBFMVFZdW85bzg4dlJEazNyV3QvSjIyZmZnc1Fo?=
 =?utf-8?B?ZldzMjRmaW1tbGsvTDNORldUbndaemlTRk8ySHY0czEvUEtlOGt2ejFiczRR?=
 =?utf-8?B?K1NDQ0ZaTUtqdFo3NzVmSjJ5MXh1NFhCaEJyTWRTZ3owZno1S0pQK1VsZGc3?=
 =?utf-8?B?eUt1b3ZPc0pUc1cyWnRhVWoyenBIWUV1ZnZjanpMTStHRHpMVXFCYXdUb0Nu?=
 =?utf-8?B?SFJyNlNvY0RvcGZOVFpNZVA5UDk5eEhEbEN5SGozNWNTMDlKdFgwN0NReEZW?=
 =?utf-8?B?NnpjZnhHM2diSVh4QnB3eE8wVEtzaVNLNTdtMVZlL0hLNlpvYXBLLy85c1Zx?=
 =?utf-8?B?OGFPbEMvS3NXZjBDUyt1UzJHVktsMG9pT2RUVU1GSWxhSXhmOXlNMmVwWlI1?=
 =?utf-8?B?N0hMakJWbEJjdlkrRTVaeVZaUkdHVFhmaWJlUHBOY0diSXQrNTAzS0s1c2R0?=
 =?utf-8?B?NlJTRTQrMmNtZ3pSL05jMjZzNjU0WUh2ZnFKenFjZXdBZkd6Wng1VDJKZnVx?=
 =?utf-8?B?UUx3NXBPeSsrSFVNTithVEVLclUwTkZLRmFibXQ4V2RvdktmRHlwUmRyN2ow?=
 =?utf-8?B?Ync5SkcwcWp1VUtiU1ozajk2NkQ3dTRBdEQzUSs1dTFTL1htNlhMS2VJTFUz?=
 =?utf-8?B?Y0NwbzlJaXVsbGdMd3FiUmhhY0UzNlhYWjFIWGdiQlRvNnVVK1BZbitNTW9F?=
 =?utf-8?B?bUQwYm03MTQzMFlIYm1tT3o0aWV4Y0g3M09rcndpRjhEOTdVRjNyYmoxZ01Y?=
 =?utf-8?B?UTNRU01CWG1qK3lpWSs3TzYzNUREWGlzWGY5bE51MFh4THVuTFFFdXRYWkI3?=
 =?utf-8?B?bEljcjJxcTMzU3ZIUGpGa1R1SUgyeEtCdk5CS0EwWDNlZVdjVGM0L1JGbGcx?=
 =?utf-8?B?RzRJdTlCRFVuN2dNRmQ5ZkoxWHJ0S2s3SUwrSGUxQ1FyNW5ld1VjVmJlRmVS?=
 =?utf-8?B?UEZkZWRaemRSYkx0Q0tPRE13a3VvV2xyTUtrdTdTd3RMaXF6dXpoZENJK3JK?=
 =?utf-8?B?ZThsV21zeU5NbnI0ekhvcGRDZ0NycHoyNFhEUVVqZzR6bHl5YUpDMzh0WXE5?=
 =?utf-8?B?blMzZU52VEx4cWcwQVlUVTA4TUtycmpESVN3djZ6Y0JHNEhlY1J0ZlVxRTB2?=
 =?utf-8?B?ekt2QUZ5a1B0ZDVjaENoMUF0MjZ6elU4d1RobUpsQjd6QUExVUYweCtZNWNU?=
 =?utf-8?B?MTQ1aXA2djBseHBKMnlnSFR3UENMV3NzbEw5QUx6WGlBOUFrZDZFbFNkVlhy?=
 =?utf-8?B?V1MyNitQNUhDci9BMWZBNG5IVkJlSW9ERVNDR0wxOHNDcEpIaXptRTBWclEy?=
 =?utf-8?B?b3g1MjFaRFZ3c1N6TkdiWXZlVWxneU10WGlHRVFYTTJHTGU0cy9ITG9ackhI?=
 =?utf-8?B?b1VXUXo2OGttdnJqc1lLVnhlQzU0QjdzWVR0YWIxNmQzaVFnQnd4Y25ORmVo?=
 =?utf-8?B?aVdDbEE1aVFUQWNqZTNaSW9HVW1KZGNFUU1Zdy9vSjM2YTd0WWo2T1NDMmw4?=
 =?utf-8?B?MGtDYU1LcFVDamY0M25BYmFibDA3OVNHV1M3TW1NZzA1dFFWNGFjci91VlNZ?=
 =?utf-8?B?VDE4R2lKTnF0SzErKy9yNGh1RGw4UUJIdmRwOUdvd3lNcUprbGhyZXE2dlhl?=
 =?utf-8?B?cG1KbnJnWEpnc3I3Y05rVUx4aXgwajIrYmRsZVBqbEo1QWQwMzNxODBwK2gw?=
 =?utf-8?B?YjFtbGNZcWI1ZGcrWHFDZDBQTEJlUVFqcFFPanNUL25KUmJWa1lrazZLeFE3?=
 =?utf-8?Q?y8TDLA3MyTCUUss2kg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q2EvcTl0Y3IyOEw3N0g0ZVBmUjgxTi9lOS9OZGNIV09wWkVFc0x5cFFKZVhq?=
 =?utf-8?B?cEcvY1FqclRLbWZycGxqZWFCalovd2NmVlJLeFJLbjZDL2FydUhDT1hFL2Q1?=
 =?utf-8?B?Z0hkcVN2WmpPZUlPNGxjQnVBZmpYbGd5TkgzdHYxKzIyM1NZNHNQNG1uUFZI?=
 =?utf-8?B?K2xydTdPU2VwUjRnUDZkYzQyWTVNRHF5R0ZyZW9LQWMxc29CZEJ6RnY1ajh3?=
 =?utf-8?B?MHdxWkZ2OFBaWVZnTkNydmVTWHJUSENOUGdKbDcxT2lkY2lOMUxzcGIxOWVh?=
 =?utf-8?B?WE1xdlF3dkdRRE9yTWxibWJBaDRPYkh3V3o5OTB2cEVSMjBlZlU1OHVhOE9y?=
 =?utf-8?B?bjF2em81WUIwSXZtaW1nRE11U0RkZXpEYURQUW9NNDhQd2FSUjV0UVV0Q0JR?=
 =?utf-8?B?aVpEYWtCbWkxVDk4N28zbEk1NkdvU2tUYzBBOFNBbVQ4TFdmSmgwaHpZZHh2?=
 =?utf-8?B?NzBEMGhZU25lTC9qZ2d3UDhLMTlwaWdnVUd6K3o5Y0kxcFFlSGRMQ0k2Zjhn?=
 =?utf-8?B?M3N5SC83eThxaHdHelVoQ2VZZkYwMnAram5veHpLZHdMQjJWYmI0Z0tlWUhO?=
 =?utf-8?B?L1F6bStLd3Z0cHR1bUprK3czY1NDd29pRjNkSzEybWpwQzIwYmU2cThmOVlt?=
 =?utf-8?B?dmorbkllT2QxV2IrM2hobE0vdXpQNnY3R3o5cEFjYXBZY0JWMEt5Z2tFN1lZ?=
 =?utf-8?B?cEVKbERGS1RFcjRiZ3QzNThPUFJDdmk3YS9kL3NnUGFUekViZFlsYlE1S1ZE?=
 =?utf-8?B?ZE0wKytEZzJhWll6SGtZZkdhMnlLT0lDdnRZU3NxTS9CbXNCRlFnaERNbFQx?=
 =?utf-8?B?bjhFcEN4R1kxNHdWNkRFM3lKc0hGZXdzR2Y4YmhKb3kvUWlyaHlnbFVxdjBR?=
 =?utf-8?B?Yks0VHRtRHgwcStoYWFHaSt0UFgzalRQN1dlQW93bG9pYTk4NUJGM3g3UlZM?=
 =?utf-8?B?UFg3SlBxRXBiSVZQTHpxZTNWeU1pcGF2KytteGJNZTFPWVRma3lsZFNFY2xX?=
 =?utf-8?B?TzdSMHlhQ2x3N243MUVMamdFaEMvQ1plT0NQYm14VVVUT0lEMjI0OURuSWhs?=
 =?utf-8?B?YkxSZzMxcDFKY1lVYzA1ZkVnL0s0ZnBUL0VsUzdmQlI1WHhHRjlRcm5vZ0lI?=
 =?utf-8?B?aDZIaDVFVDRlMWpVSVFJdG4wMTBOYmgzY1R5d213Wjc5M3MwaTlrOEVGcFpG?=
 =?utf-8?B?NWlKaFpYRjVDWW9VdWdsV2NqUEtOWURhTWJhVHRvbUJQaUR4VFY4Q0VUdGpJ?=
 =?utf-8?B?YmNYUVlaU1FaSlU1dG5QekNGZkxtbm1OTjRCbmt2Y3FlNVdsaktYRFlLTVYw?=
 =?utf-8?B?TlM5NXI1amJTUUJ2bExoSTlsMW9GS25YL0hCVHh6Uy9TdDZhQzE0VWxuekhR?=
 =?utf-8?B?c3BZVkRPSmFiQWV5OE1pbU1BdUZJeHFqZ0JKTllHT2NpN2tWYUJJdSszVUxN?=
 =?utf-8?B?bytPYTI2RVFtRjFNZE1JSFF5OVpDMVA2TE15czNtWi9qcUJDUmVDRXdQZ2hK?=
 =?utf-8?B?ckliQVZlREYxU1RtRDI4SklkTlNqUXVwUHF0V05odDZMVzNZbTN6TVdPaFBT?=
 =?utf-8?B?OE9ncnlUT01pSVIvUFNTREpUc1V5M0FkRUNiTnc3bXJCdUJLc0dZQ29ybWVq?=
 =?utf-8?B?NUVqMW9ud3pmOHl2ZS9WL2dyekJYeVJJNW4xbENDODEreDZOVm0xc29xOXEw?=
 =?utf-8?B?Z3JscFVNaC8xcjRxcGNlaXZlVW1BYXhkQVVDVzhFSDhJRFBKeVdWdTBHNEpm?=
 =?utf-8?B?K1puUjNyWTFDbjkxazcrRGlGTjFSUC9OTi9aQXZNeWVnd3pCejFPa1l1T2Rk?=
 =?utf-8?B?NU1QdUJGU0JQS0FwNkxaN1d3MjR1TUZNYTlETEVDcEVPWmZjdUgwMnUzMXJX?=
 =?utf-8?B?MDRZeXVodVRPUHE4bjgxS2lXbXp4bXdyVDd4R0NIUnROUWdRWlc4NlU4T2xp?=
 =?utf-8?B?b0hrZUFtNFAwSVdoc2I2L1RtMDc3VTJrY21WM3R0QVltTXZrWWpTMlhrV1da?=
 =?utf-8?B?Tm5HemZ6V2R2MnhpamJjM0hNMDFDSldIcjMvOWR2aEZmaHYyUHdXQ05QcW0z?=
 =?utf-8?B?REd2em1RV2E3bUgyRjVDd0Fxc2g4SHNpZVhWbGt4SWI0a3ZiencwWWpZUTgy?=
 =?utf-8?B?cGY3K2JOMGJVZ1JnWTIwMlRrc2phMTlXT1N2dG5LRnVUeWhPbXBsUytYQjFQ?=
 =?utf-8?B?Q2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a2d6aea7-d698-4ddc-0b1d-08dcb6a57ab5
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2024 05:55:03.0189
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bqxlr7k5PzbRn2VehB0y/qzM1b4XFpesoSq7omeWOTMSZBNtx/Vz2RLQzpgr+Q3yJwSRc3ldN0VJ/k37xa8nDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6783
X-OriginatorOrg: intel.com

hi, Pedro,

On Tue, Aug 06, 2024 at 10:37:08PM +0100, Pedro Falcato wrote:
> On Tue, Aug 6, 2024 at 7:05 AM Oliver Sang <oliver.sang@intel.com> wrote:
> >
> > hi, Linus,
> >
> > On Mon, Aug 05, 2024 at 12:33:58PM -0700, Linus Torvalds wrote:
> > > On Mon, 5 Aug 2024 at 11:55, Linus Torvalds
> > > <torvalds@linux-foundation.org> wrote:
> > > >
> > > > So please consider this a "maybe something like this" patch, but that
> > > > 'arch_unmap()' really is pretty nasty
> > >
> > > Actually, the whole powerpc vdso code confused me. It's not the vvar
> > > thing that wants this close thing, it's the other ones that have the
> > > remap thing.
> > >
> > > .. and there were two of those error cases that needed to reset the
> > > vdso pointer.
> > >
> > > That all shows just how carefully I was reading this code.
> > >
> > > New version - still untested, but now I've read through it one more
> > > time - attached.
> >
> > we tested this version by applying it directly upon 8be7258aad,  but seems it
> > have little impact to performance. still similar regression if comparing to
> > ff388fe5c4.
> 
> Hi,
> 
> I've just sent out a patch set[1] that should alleviate (or hopefully
> totally fix) these performance regressions. It'd be great if you could
> test it.

yes, your patch set totally fixes the regression.

our bot automatically fetch the patch set and apply it upon mainline
d4560686726f7 as below.

d58de4f958df2 (linux-review/Pedro-Falcato/mm-Move-can_modify_vma-to-mm-internal-h/20240807-054658) mm: Remove can_modify_mm()
32668c3efc23f mseal: Replace can_modify_mm_madv with a vma variant
5c3f48cf634c9 mseal: Fix is_madv_discard()
8cde2d71bd0f8 mm/mremap: Replace can_modify_mm with can_modify_vma
cc3471461a854 mm/mprotect: Replace can_modify_mm with can_modify_vma
abff8a9b6023e mm/munmap: Replace can_modify_mm with can_modify_vma
c1bf07aa19804 mm: Move can_modify_vma to mm/internal.h
d4560686726f7 (HEAD, linus/master) Merge tag 'for_linus' of git://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost

I tested patch set tip d58de4f958df2 as well as d4560686726f7, below is the
results combining with 8be7258aad and its parent.

data from 8be7258aad and d4560686726f7 are close enough to within the noise.
the patch set tip recover the performance to the level of ff388fe5c4.


=========================================================================================
compiler/cpufreq_governor/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  gcc-12/performance/x86_64-rhel-8.3/100%/debian-12-x86_64-20240206.cgz/lkp-icl-2sp7/pagemove/stress-ng/60s

commit:
  ff388fe5c4 ("mseal: wire up mseal syscall")
  8be7258aad ("mseal: add mseal syscall")
  d456068672 ("Merge tag 'for_linus' of git://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost")
  d58de4f958 ("mm: Remove can_modify_mm()")

ff388fe5c481d39c 8be7258aad44b5e25977a98db13 d4560686726f7a357922f300fc8 d58de4f958df225c04fd490fe2d
---------------- --------------------------- --------------------------- ---------------------------
         %stddev     %change         %stddev     %change         %stddev     %change         %stddev
             \          |                \          |                \          |                \
     44.92            -0.4%      44.76            -5.1%      42.62            -5.7%      42.37        boot-time.boot
     33.12            -0.4%      33.00            -7.0%      30.81            -7.0%      30.81        boot-time.dhcp
      2631            -0.4%       2620            -5.6%       2483            -6.2%       2468        boot-time.idle
      4958            +1.3%       5024            +1.2%       5017            +0.0%       4960        time.percent_of_cpu_this_job_got
      2916            +1.5%       2960            +1.4%       2956            +0.1%       2919        time.system_time
     65.85            -7.0%      61.27            -6.8%      61.40            -3.4%      63.64        time.user_time
     17869 ±  8%      -5.6%      16869 ± 28%     -24.5%      13488 ± 25%      -3.5%      17240 ±  9%  numa-vmstat.node0.nr_slab_reclaimable
      5182 ± 29%     +19.8%       6207 ± 75%     +80.1%       9334 ± 36%      +7.9%       5591 ± 28%  numa-vmstat.node1.nr_slab_reclaimable
     10153 ±170%   +1041.4%     115893 ±214%   +2787.4%     293183 ± 97%    +371.7%      47894 ± 90%  numa-vmstat.node1.nr_unevictable
     10153 ±170%   +1041.4%     115893 ±214%   +2787.4%     293183 ± 97%    +371.7%      47894 ± 90%  numa-vmstat.node1.nr_zone_unevictable
     71475 ±  8%      -5.6%      67478 ± 28%     -24.5%      53952 ± 25%      -3.5%      68960 ±  9%  numa-meminfo.node0.KReclaimable
     71475 ±  8%      -5.6%      67478 ± 28%     -24.5%      53952 ± 25%      -3.5%      68960 ±  9%  numa-meminfo.node0.SReclaimable
     20732 ± 29%     +19.8%      24839 ± 75%     +80.1%      37346 ± 36%      +7.9%      22364 ± 28%  numa-meminfo.node1.KReclaimable
     20732 ± 29%     +19.8%      24839 ± 75%     +80.1%      37346 ± 36%      +7.9%      22364 ± 28%  numa-meminfo.node1.SReclaimable
     40615 ±170%   +1041.4%     463573 ±214%   +2787.4%    1172733 ± 97%    +371.7%     191576 ± 90%  numa-meminfo.node1.Unevictable
     23051            +0.1%      23079            -1.0%      22823            -1.0%      22831        proc-vmstat.nr_slab_reclaimable
  41535129            -4.5%   39669773            -4.9%   39501465            -0.3%   41415171        proc-vmstat.numa_hit
  41465484            -4.5%   39602956            -4.9%   39434855            -0.3%   41347677        proc-vmstat.numa_local
  77303973            -4.6%   73780662            -5.0%   73449965            -0.3%   77049179        proc-vmstat.pgalloc_normal
  77022096            -4.6%   73502058            -5.0%   73168463            -0.3%   76769054        proc-vmstat.pgfree
  18381956            -4.9%   17473438            -5.1%   17450543            -0.4%   18316849        stress-ng.pagemove.ops
    306349            -4.9%     291188            -5.1%     290820            -0.4%     305268        stress-ng.pagemove.ops_per_sec
    209930            -6.2%     196996 ±  2%      -5.4%     198614            -0.5%     208922        stress-ng.pagemove.page_remaps_per_sec
      4958            +1.3%       5024            +1.2%       5017            +0.0%       4960        stress-ng.time.percent_of_cpu_this_job_got
      2916            +1.5%       2960            +1.4%       2956            +0.1%       2919        stress-ng.time.system_time
 3.337e+10 ±  4%      +2.3%  3.414e+10 ±  3%      +5.0%  3.503e+10            +1.2%  3.376e+10        perf-stat.i.branch-instructions
      1.13            -2.1%       1.10            -2.3%       1.10            +0.1%       1.13        perf-stat.i.cpi
 1.695e+11 ±  4%      +1.1%  1.715e+11 ±  3%      +3.8%  1.761e+11            +1.2%  1.715e+11        perf-stat.i.instructions
      0.89            +2.2%       0.91            +2.1%       0.91            -0.4%       0.89        perf-stat.i.ipc
      1.04            -7.2%       0.97            -7.2%       0.97            -0.2%       1.04        perf-stat.overall.MPKI
      1.13            -2.3%       1.10            -2.1%       1.10            +0.3%       1.13        perf-stat.overall.cpi
      1082            +5.4%       1140            +5.5%       1141            +0.5%       1087        perf-stat.overall.cycles-between-cache-misses
      0.89            +2.3%       0.91            +2.1%       0.91            -0.3%       0.88        perf-stat.overall.ipc
 3.284e+10 ±  4%      +2.4%  3.362e+10 ±  2%      +4.8%  3.443e+10            +1.1%   3.32e+10        perf-stat.ps.branch-instructions
    192.79            -3.9%     185.32 ±  2%      -1.7%     189.49            +0.2%     193.10        perf-stat.ps.cpu-migrations
 1.669e+11 ±  4%      +1.2%  1.689e+11 ±  2%      +3.7%  1.731e+11            +1.1%  1.687e+11        perf-stat.ps.instructions
 1.048e+13            +2.8%  1.078e+13            +2.1%   1.07e+13            -0.6%  1.042e+13        perf-stat.total.instructions
     74.97            -1.9       73.07            -1.7       73.32            +0.4       75.38        perf-profile.calltrace.cycles-pp.move_vma.__do_sys_mremap.do_syscall_64.entry_SYSCALL_64_after_hwframe.mremap
     36.79            -1.6       35.22            -1.4       35.36            +0.3       37.08        perf-profile.calltrace.cycles-pp.do_vmi_align_munmap.do_vmi_munmap.move_vma.__do_sys_mremap.do_syscall_64
     24.98            -1.3       23.64            -1.3       23.73            +0.0       24.99        perf-profile.calltrace.cycles-pp.copy_vma.move_vma.__do_sys_mremap.do_syscall_64.entry_SYSCALL_64_after_hwframe
     19.91            -1.1       18.85            -1.2       18.69            -0.2       19.72        perf-profile.calltrace.cycles-pp.__split_vma.do_vmi_align_munmap.do_vmi_munmap.move_vma.__do_sys_mremap
     10.70 ±  3%      -0.9        9.84 ±  3%      -0.9        9.78 ±  2%      -0.4       10.33 ±  3%  perf-profile.calltrace.cycles-pp.kthread.ret_from_fork.ret_from_fork_asm
     10.70 ±  3%      -0.9        9.84 ±  3%      -0.9        9.78 ±  2%      -0.4       10.33 ±  3%  perf-profile.calltrace.cycles-pp.ret_from_fork.ret_from_fork_asm
     10.70 ±  3%      -0.9        9.84 ±  3%      -0.9        9.78 ±  2%      -0.4       10.33 ±  3%  perf-profile.calltrace.cycles-pp.ret_from_fork_asm
     10.64 ±  3%      -0.9        9.79 ±  3%      -0.9        9.73 ±  2%      -0.4       10.29 ±  3%  perf-profile.calltrace.cycles-pp.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
     10.63 ±  3%      -0.9        9.78 ±  3%      -0.9        9.72 ±  2%      -0.4       10.28 ±  3%  perf-profile.calltrace.cycles-pp.handle_softirqs.run_ksoftirqd.smpboot_thread_fn.kthread.ret_from_fork
     10.63 ±  3%      -0.9        9.78 ±  3%      -0.9        9.72 ±  2%      -0.4       10.28 ±  3%  perf-profile.calltrace.cycles-pp.run_ksoftirqd.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
     10.63 ±  3%      -0.9        9.78 ±  3%      -0.9        9.72 ±  2%      -0.4       10.28 ±  3%  perf-profile.calltrace.cycles-pp.rcu_core.handle_softirqs.run_ksoftirqd.smpboot_thread_fn.kthread
     10.59 ±  3%      -0.8        9.74 ±  3%      -0.9        9.68 ±  2%      -0.4       10.24 ±  3%  perf-profile.calltrace.cycles-pp.rcu_do_batch.rcu_core.handle_softirqs.run_ksoftirqd.smpboot_thread_fn
     14.77            -0.8       14.00            -0.7       14.11            +0.0       14.80        perf-profile.calltrace.cycles-pp.vma_merge.copy_vma.move_vma.__do_sys_mremap.do_syscall_64
      1.48            -0.5        0.99            -0.5        0.99            +0.0        1.52        perf-profile.calltrace.cycles-pp.mas_find.do_vmi_munmap.move_vma.__do_sys_mremap.do_syscall_64
      5.95 ±  3%      -0.5        5.47 ±  3%      -0.5        5.44 ±  2%      -0.2        5.73 ±  3%  perf-profile.calltrace.cycles-pp.kmem_cache_free.rcu_do_batch.rcu_core.handle_softirqs.run_ksoftirqd
      7.88            -0.4        7.48            -0.3        7.57            +0.1        7.97        perf-profile.calltrace.cycles-pp.move_page_tables.move_vma.__do_sys_mremap.do_syscall_64.entry_SYSCALL_64_after_hwframe
      4.62 ±  3%      -0.4        4.25 ±  3%      -0.4        4.20 ±  2%      -0.2        4.42 ±  3%  perf-profile.calltrace.cycles-pp.__slab_free.kmem_cache_free.rcu_do_batch.rcu_core.handle_softirqs
      6.72            -0.4        6.36            -0.4        6.33            -0.1        6.66        perf-profile.calltrace.cycles-pp.vm_area_dup.__split_vma.do_vmi_align_munmap.do_vmi_munmap.move_vma
      6.15            -0.3        5.82            -0.3        5.86            +0.0        6.16        perf-profile.calltrace.cycles-pp.vma_complete.__split_vma.do_vmi_align_munmap.do_vmi_munmap.move_vma
      6.11            -0.3        5.78            -0.3        5.77            -0.0        6.07        perf-profile.calltrace.cycles-pp.kmem_cache_alloc_noprof.vm_area_dup.__split_vma.do_vmi_align_munmap.do_vmi_munmap
      5.78            -0.3        5.49            -0.2        5.57            +0.1        5.85        perf-profile.calltrace.cycles-pp.move_ptes.move_page_tables.move_vma.__do_sys_mremap.do_syscall_64
      5.54            -0.3        5.25            -0.3        5.28            +0.0        5.56        perf-profile.calltrace.cycles-pp.mas_store_prealloc.vma_complete.__split_vma.do_vmi_align_munmap.do_vmi_munmap
      5.56            -0.3        5.28            -0.3        5.28            -0.0        5.54        perf-profile.calltrace.cycles-pp.mas_store_prealloc.vma_merge.copy_vma.move_vma.__do_sys_mremap
      5.19            -0.3        4.92            -0.2        4.95            +0.0        5.21        perf-profile.calltrace.cycles-pp.mas_wr_store_entry.mas_store_prealloc.vma_complete.__split_vma.do_vmi_align_munmap
      5.20            -0.3        4.94            -0.3        4.95            -0.0        5.18        perf-profile.calltrace.cycles-pp.mas_wr_store_entry.mas_store_prealloc.vma_merge.copy_vma.move_vma
      3.20 ±  4%      -0.3        2.94 ±  3%      -0.3        2.93 ±  2%      -0.1        3.11 ±  3%  perf-profile.calltrace.cycles-pp.vm_area_free_rcu_cb.rcu_do_batch.rcu_core.handle_softirqs.run_ksoftirqd
      4.09            -0.2        3.85            -0.3        3.82            -0.1        4.03        perf-profile.calltrace.cycles-pp.vm_area_dup.copy_vma.move_vma.__do_sys_mremap.do_syscall_64
      4.68            -0.2        4.45            -0.2        4.46            -0.0        4.67        perf-profile.calltrace.cycles-pp.mas_wr_node_store.mas_wr_store_entry.mas_store_prealloc.vma_merge.copy_vma
      2.63 ±  3%      -0.2        2.42 ±  3%      -0.2        2.43 ±  2%      -0.1        2.57 ±  3%  perf-profile.calltrace.cycles-pp.kmem_cache_free.vm_area_free_rcu_cb.rcu_do_batch.rcu_core.handle_softirqs
      2.36 ±  2%      -0.2        2.16 ±  4%      -0.3        2.04 ± 14%      -0.1        2.28 ±  3%  perf-profile.calltrace.cycles-pp.__memcpy.mas_wr_node_store.mas_wr_store_entry.mas_store_prealloc.vma_complete
      3.56            -0.2        3.36            -0.2        3.34            -0.0        3.52        perf-profile.calltrace.cycles-pp.kmem_cache_alloc_noprof.vm_area_dup.copy_vma.move_vma.__do_sys_mremap
      4.00            -0.2        3.81            -0.1        3.87 ±  2%      +0.1        4.06        perf-profile.calltrace.cycles-pp.mas_wr_node_store.mas_wr_store_entry.mas_store_prealloc.vma_complete.__split_vma
      1.35            -0.2        1.16            -0.2        1.16            +0.0        1.36        perf-profile.calltrace.cycles-pp.mas_find.do_vmi_munmap.do_munmap.mremap_to.__do_sys_mremap
      3.40            -0.2        3.22            -0.2        3.24            +0.0        3.41        perf-profile.calltrace.cycles-pp.flush_tlb_mm_range.move_ptes.move_page_tables.move_vma.__do_sys_mremap
      2.22            -0.2        2.06            -0.2        2.07            +0.0        2.24        perf-profile.calltrace.cycles-pp.find_vma_prev.copy_vma.move_vma.__do_sys_mremap.do_syscall_64
      0.96            -0.2        0.82            -0.2        0.81            +0.0        0.97        perf-profile.calltrace.cycles-pp.mas_walk.mas_find.do_vmi_munmap.do_munmap.mremap_to
      3.25            -0.1        3.10            -0.1        3.14            +0.0        3.30        perf-profile.calltrace.cycles-pp.mas_store_gfp.do_vmi_align_munmap.do_vmi_munmap.move_vma.__do_sys_mremap
      1.81 ±  4%      -0.1        1.67 ±  3%      -0.2        1.64 ±  2%      -0.1        1.74 ±  3%  perf-profile.calltrace.cycles-pp.__slab_free.kmem_cache_free.vm_area_free_rcu_cb.rcu_do_batch.rcu_core
      1.97 ±  3%      -0.1        1.83 ±  3%      -0.6        1.41 ±  3%      -0.5        1.50 ±  2%  perf-profile.calltrace.cycles-pp.mod_objcg_state.__memcg_slab_post_alloc_hook.kmem_cache_alloc_noprof.vm_area_dup.__split_vma
      2.26            -0.1        2.12            -0.2        2.05            -0.1        2.16        perf-profile.calltrace.cycles-pp.mas_preallocate.__split_vma.do_vmi_align_munmap.do_vmi_munmap.move_vma
      3.10            -0.1        2.96            +0.3        3.38            +0.5        3.60        perf-profile.calltrace.cycles-pp.__memcg_slab_post_alloc_hook.kmem_cache_alloc_noprof.vm_area_dup.__split_vma.do_vmi_align_munmap
      3.13            -0.1        2.99            -0.1        3.06            +0.1        3.23        perf-profile.calltrace.cycles-pp.unmap_vmas.unmap_region.do_vmi_align_munmap.do_vmi_munmap.move_vma
      2.97            -0.1        2.85            -0.2        2.75 ±  2%      -0.0        2.94 ±  2%  perf-profile.calltrace.cycles-pp.anon_vma_clone.__split_vma.do_vmi_align_munmap.do_vmi_munmap.move_vma
      2.05            -0.1        1.93            -0.1        1.98            -0.1        1.99        perf-profile.calltrace.cycles-pp.mas_preallocate.vma_merge.copy_vma.move_vma.__do_sys_mremap
      8.26            -0.1        8.14            +0.2        8.45            +0.5        8.78        perf-profile.calltrace.cycles-pp.unmap_region.do_vmi_align_munmap.do_vmi_munmap.move_vma.__do_sys_mremap
      2.45            -0.1        2.34            -0.1        2.34            +0.0        2.46        perf-profile.calltrace.cycles-pp.flush_tlb_func.flush_tlb_mm_range.move_ptes.move_page_tables.move_vma
      2.43            -0.1        2.32            -0.0        2.39            +0.1        2.55        perf-profile.calltrace.cycles-pp.unmap_page_range.unmap_vmas.unmap_region.do_vmi_align_munmap.do_vmi_munmap
      1.75 ±  2%      -0.1        1.64 ±  3%      -0.1        1.64 ±  4%      +0.0        1.77 ±  4%  perf-profile.calltrace.cycles-pp.vma_prepare.vma_merge.copy_vma.move_vma.__do_sys_mremap
      0.54            -0.1        0.44 ± 37%      -0.0        0.51            +0.0        0.55        perf-profile.calltrace.cycles-pp.mas_find.find_vma_prev.copy_vma.move_vma.__do_sys_mremap
      1.27 ±  2%      -0.1        1.16 ±  4%      -0.1        1.14 ±  6%      -0.0        1.23 ±  4%  perf-profile.calltrace.cycles-pp.__memcpy.mas_wr_node_store.mas_wr_store_entry.mas_store_prealloc.vma_merge
      1.32 ±  3%      -0.1        1.22 ±  3%      -0.1        1.20 ±  2%      -0.0        1.28 ±  3%  perf-profile.calltrace.cycles-pp.rcu_cblist_dequeue.rcu_do_batch.rcu_core.handle_softirqs.run_ksoftirqd
      2.21            -0.1        2.11            -0.1        2.11            +0.0        2.23        perf-profile.calltrace.cycles-pp.native_flush_tlb_one_user.flush_tlb_func.flush_tlb_mm_range.move_ptes.move_page_tables
      1.85            -0.1        1.76            -0.1        1.78            +0.0        1.87        perf-profile.calltrace.cycles-pp.vma_link.copy_vma.move_vma.__do_sys_mremap.do_syscall_64
      2.14 ±  2%      -0.1        2.05 ±  2%      -0.1        2.00 ±  2%      +0.0        2.14 ±  2%  perf-profile.calltrace.cycles-pp.kmem_cache_alloc_noprof.anon_vma_clone.__split_vma.do_vmi_align_munmap.do_vmi_munmap
      1.79 ±  2%      -0.1        1.70            +0.1        1.93            +0.3        2.06        perf-profile.calltrace.cycles-pp.__memcg_slab_post_alloc_hook.kmem_cache_alloc_noprof.vm_area_dup.copy_vma.move_vma
      1.40            -0.1        1.31            -0.1        1.27            -0.1        1.34        perf-profile.calltrace.cycles-pp.mas_alloc_nodes.mas_preallocate.__split_vma.do_vmi_align_munmap.do_vmi_munmap
      1.39            -0.1        1.30            -0.1        1.34            -0.1        1.33        perf-profile.calltrace.cycles-pp.mas_alloc_nodes.mas_preallocate.vma_merge.copy_vma.move_vma
      1.24            -0.1        1.16            -0.1        1.13            -0.1        1.19        perf-profile.calltrace.cycles-pp.kmem_cache_alloc_noprof.mas_alloc_nodes.mas_preallocate.__split_vma.do_vmi_align_munmap
      0.94            -0.1        0.86            -0.1        0.86            +0.0        0.96        perf-profile.calltrace.cycles-pp.mas_walk.mas_find.do_vmi_munmap.move_vma.__do_sys_mremap
      1.23            -0.1        1.15            -0.0        1.18            -0.1        1.18        perf-profile.calltrace.cycles-pp.kmem_cache_alloc_noprof.mas_alloc_nodes.mas_preallocate.vma_merge.copy_vma
      1.54            -0.1        1.46            -0.0        1.50            +0.1        1.60        perf-profile.calltrace.cycles-pp.zap_pmd_range.unmap_page_range.unmap_vmas.unmap_region.do_vmi_align_munmap
      0.73            -0.1        0.67            -0.1        0.67            +0.0        0.74        perf-profile.calltrace.cycles-pp.mas_walk.find_vma_prev.copy_vma.move_vma.__do_sys_mremap
      1.15            -0.1        1.09            -0.1        1.08            -0.0        1.13        perf-profile.calltrace.cycles-pp.___slab_alloc.kmem_cache_alloc_noprof.vm_area_dup.__split_vma.do_vmi_align_munmap
      0.60 ±  2%      -0.1        0.54            -0.0        0.56            -0.0        0.59        perf-profile.calltrace.cycles-pp.security_mmap_addr.__get_unmapped_area.mremap_to.__do_sys_mremap.do_syscall_64
      1.27            -0.1        1.21            -0.0        1.22            +0.0        1.30        perf-profile.calltrace.cycles-pp.mas_wr_store_entry.mas_store_gfp.do_vmi_align_munmap.do_vmi_munmap.move_vma
     38.74            -0.1       38.68            +0.1       38.80            +0.3       39.06        perf-profile.calltrace.cycles-pp.do_vmi_munmap.move_vma.__do_sys_mremap.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.38 ±  4%      -0.1        1.32 ±  2%      -0.2        1.20 ±  3%      -0.1        1.27 ±  2%  perf-profile.calltrace.cycles-pp.obj_cgroup_charge.__memcg_slab_post_alloc_hook.kmem_cache_alloc_noprof.vm_area_dup.__split_vma
      0.72            -0.1        0.66            -0.1        0.66            +0.0        0.72        perf-profile.calltrace.cycles-pp.mas_prev.vma_merge.copy_vma.move_vma.__do_sys_mremap
      0.70 ±  2%      -0.1        0.64 ±  3%      +0.1        0.80 ±  3%      +0.2        0.85 ±  3%  perf-profile.calltrace.cycles-pp.mod_objcg_state.__memcg_slab_post_alloc_hook.kmem_cache_alloc_noprof.vm_area_dup.copy_vma
      0.79            -0.1        0.73            -0.1        0.73            +0.0        0.79        perf-profile.calltrace.cycles-pp.___slab_alloc.kmem_cache_alloc_noprof.mas_alloc_nodes.mas_preallocate.__split_vma
      0.80 ±  2%      -0.1        0.75            -0.1        0.72 ±  3%      -0.0        0.77 ±  2%  perf-profile.calltrace.cycles-pp.__call_rcu_common.mas_wr_node_store.mas_wr_store_entry.mas_store_prealloc.vma_merge
      0.78            -0.1        0.72            -0.0        0.73            +0.0        0.78        perf-profile.calltrace.cycles-pp.___slab_alloc.kmem_cache_alloc_noprof.mas_alloc_nodes.mas_preallocate.vma_merge
      1.02            -0.1        0.96            +0.0        1.02            +0.1        1.09        perf-profile.calltrace.cycles-pp.zap_pte_range.zap_pmd_range.unmap_page_range.unmap_vmas.unmap_region
      1.63            -0.1        1.58            -0.1        1.58            +0.0        1.64        perf-profile.calltrace.cycles-pp.__get_unmapped_area.mremap_to.__do_sys_mremap.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.62            -0.0        0.58            -0.1        0.57            +0.0        0.63        perf-profile.calltrace.cycles-pp.mas_prev_setup.mas_prev.vma_merge.copy_vma.move_vma
      0.60 ±  3%      -0.0        0.56 ±  3%      -0.0        0.59 ±  3%      +0.0        0.63 ±  3%  perf-profile.calltrace.cycles-pp.__memcg_slab_free_hook.kmem_cache_free.vm_area_free_rcu_cb.rcu_do_batch.rcu_core
      0.67            -0.0        0.62            -0.1        0.59            -0.1        0.61 ±  2%  perf-profile.calltrace.cycles-pp.percpu_counter_add_batch.do_vmi_align_munmap.do_vmi_munmap.move_vma.__do_sys_mremap
      0.86            -0.0        0.81            -0.0        0.82            +0.0        0.87        perf-profile.calltrace.cycles-pp.mtree_load.vma_to_resize.mremap_to.__do_sys_mremap.do_syscall_64
      1.02            -0.0        0.97            -0.0        0.98            +0.0        1.04        perf-profile.calltrace.cycles-pp.vma_to_resize.mremap_to.__do_sys_mremap.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.76 ±  2%      -0.0        0.71            -0.1        0.71 ±  2%      -0.0        0.74 ±  2%  perf-profile.calltrace.cycles-pp.allocate_slab.___slab_alloc.kmem_cache_alloc_noprof.vm_area_dup.__split_vma
      0.81            -0.0        0.77            -0.1        0.76            -0.0        0.81        perf-profile.calltrace.cycles-pp.mtree_load.__do_sys_mremap.do_syscall_64.entry_SYSCALL_64_after_hwframe.mremap
      0.70            -0.0        0.66            -0.0        0.66            -0.0        0.69        perf-profile.calltrace.cycles-pp.__call_rcu_common.do_vmi_align_munmap.do_vmi_munmap.move_vma.__do_sys_mremap
      0.67 ±  2%      -0.0        0.63            -0.0        0.65 ±  2%      +0.0        0.68        perf-profile.calltrace.cycles-pp.syscall_return_via_sysret.mremap
      0.56            -0.0        0.51            -0.2        0.38 ± 57%      +0.0        0.56        perf-profile.calltrace.cycles-pp.mas_walk.mas_prev_setup.mas_prev.vma_merge.copy_vma
      0.69            -0.0        0.65            -0.0        0.64 ±  2%      -0.0        0.68        perf-profile.calltrace.cycles-pp.___slab_alloc.kmem_cache_alloc_noprof.vm_area_dup.copy_vma.move_vma
      0.98            -0.0        0.93            -0.0        0.94            +0.0        0.98        perf-profile.calltrace.cycles-pp.mas_find.do_vmi_align_munmap.do_vmi_munmap.move_vma.__do_sys_mremap
      0.77 ±  5%      -0.0        0.73 ±  2%      -0.1        0.66 ±  4%      -0.1        0.70 ±  4%  perf-profile.calltrace.cycles-pp.obj_cgroup_charge.__memcg_slab_post_alloc_hook.kmem_cache_alloc_noprof.vm_area_dup.copy_vma
      0.78            -0.0        0.74            -0.0        0.75            +0.0        0.79        perf-profile.calltrace.cycles-pp.mas_store_prealloc.vma_link.copy_vma.move_vma.__do_sys_mremap
      1.12            -0.0        1.08            -0.1        1.06            +0.0        1.12        perf-profile.calltrace.cycles-pp.clear_bhb_loop.mremap
      0.68            -0.0        0.65            -0.0        0.66            +0.0        0.68        perf-profile.calltrace.cycles-pp.mas_preallocate.vma_link.copy_vma.move_vma.__do_sys_mremap
      1.00            -0.0        0.97            -0.0        0.96            +0.0        1.02        perf-profile.calltrace.cycles-pp.mt_find.vma_merge.copy_vma.move_vma.__do_sys_mremap
      0.62            -0.0        0.59            -0.0        0.59            -0.0        0.62        perf-profile.calltrace.cycles-pp.mas_prev_slot.do_vmi_align_munmap.do_vmi_munmap.move_vma.__do_sys_mremap
      0.88            -0.0        0.85            -0.0        0.85            +0.0        0.88        perf-profile.calltrace.cycles-pp.userfaultfd_unmap_complete.__do_sys_mremap.do_syscall_64.entry_SYSCALL_64_after_hwframe.mremap
      1.15            -0.0        1.12            -0.1        1.08            -0.0        1.13        perf-profile.calltrace.cycles-pp.anon_vma_clone.copy_vma.move_vma.__do_sys_mremap.do_syscall_64
      0.60            -0.0        0.57 ±  2%      +0.0        0.62            +0.1        0.66        perf-profile.calltrace.cycles-pp.__pte_offset_map_lock.zap_pte_range.zap_pmd_range.unmap_page_range.unmap_vmas
      0.59            -0.0        0.56            -0.0        0.56            -0.0        0.57        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64.mremap
      0.62 ±  2%      -0.0        0.59 ±  2%      -0.0        0.59            +0.0        0.63        perf-profile.calltrace.cycles-pp.get_old_pud.move_page_tables.move_vma.__do_sys_mremap.do_syscall_64
      0.65            -0.0        0.63            -0.0        0.63            +0.0        0.66        perf-profile.calltrace.cycles-pp.mas_update_gap.mas_store_gfp.do_vmi_align_munmap.do_vmi_munmap.move_vma
      0.55            -0.0        0.53            +0.0        0.58            +0.1        0.61        perf-profile.calltrace.cycles-pp.__pte_offset_map_lock.move_ptes.move_page_tables.move_vma.__do_sys_mremap
      0.74            -0.0        0.72            -0.1        0.68 ±  2%      -0.0        0.71 ±  2%  perf-profile.calltrace.cycles-pp.kmem_cache_alloc_noprof.anon_vma_clone.copy_vma.move_vma.__do_sys_mremap
      0.67            +0.1        0.74            +0.1        0.73            +0.0        0.68        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__madvise
      0.76            +0.1        0.84            +0.1        0.82            +0.0        0.78        perf-profile.calltrace.cycles-pp.__madvise
      0.66            +0.1        0.74            +0.1        0.73            +0.0        0.67        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__madvise
      0.63            +0.1        0.71            +0.1        0.70            +0.0        0.64        perf-profile.calltrace.cycles-pp.__x64_sys_madvise.do_syscall_64.entry_SYSCALL_64_after_hwframe.__madvise
      0.62            +0.1        0.70            +0.1        0.69            +0.0        0.64        perf-profile.calltrace.cycles-pp.do_madvise.__x64_sys_madvise.do_syscall_64.entry_SYSCALL_64_after_hwframe.__madvise
      3.47            +0.1        3.55            +0.4        3.89            +0.5        3.95        perf-profile.calltrace.cycles-pp.free_pgtables.unmap_region.do_vmi_align_munmap.do_vmi_munmap.move_vma
     87.67            +0.8       88.47            +0.9       88.53            +0.3       88.01        perf-profile.calltrace.cycles-pp.mremap
      0.00            +0.9        0.86            +0.8        0.84            +0.0        0.00        perf-profile.calltrace.cycles-pp.mas_walk.mas_find.can_modify_mm.do_vmi_munmap.do_munmap
      0.00            +0.9        0.88            +0.9        0.86            +0.0        0.00        perf-profile.calltrace.cycles-pp.mas_walk.mas_find.can_modify_mm.mremap_to.__do_sys_mremap
      0.00            +0.9        0.90 ±  2%      +0.9        0.90            +0.0        0.00        perf-profile.calltrace.cycles-pp.mas_walk.mas_find.can_modify_mm.do_vmi_munmap.move_vma
     84.82            +1.0       85.80            +1.0       85.84            +0.4       85.19        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.mremap
     84.66            +1.0       85.65            +1.0       85.69            +0.4       85.04        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.mremap
     83.71            +1.0       84.73            +1.2       84.89            +0.5       84.18        perf-profile.calltrace.cycles-pp.__do_sys_mremap.do_syscall_64.entry_SYSCALL_64_after_hwframe.mremap
      0.00            +1.1        1.10            +1.1        1.08            +0.0        0.00        perf-profile.calltrace.cycles-pp.mas_find.can_modify_mm.mremap_to.__do_sys_mremap.do_syscall_64
      0.00            +1.2        1.21            +1.2        1.20            +0.0        0.00        perf-profile.calltrace.cycles-pp.mas_find.can_modify_mm.do_vmi_munmap.do_munmap.mremap_to
      2.09            +1.5        3.60            +1.5        3.59            +0.0        2.11        perf-profile.calltrace.cycles-pp.do_munmap.mremap_to.__do_sys_mremap.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +1.5        1.51            +1.5        1.50            +0.0        0.00        perf-profile.calltrace.cycles-pp.mas_find.can_modify_mm.do_vmi_munmap.move_vma.__do_sys_mremap
      1.59            +1.5        3.12            +1.5        3.11            +0.0        1.60        perf-profile.calltrace.cycles-pp.do_vmi_munmap.do_munmap.mremap_to.__do_sys_mremap.do_syscall_64
      0.00            +1.6        1.62            +1.6        1.59            +0.0        0.00        perf-profile.calltrace.cycles-pp.can_modify_mm.mremap_to.__do_sys_mremap.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +1.7        1.72            +1.7        1.72            +0.0        0.00        perf-profile.calltrace.cycles-pp.can_modify_mm.do_vmi_munmap.do_munmap.mremap_to.__do_sys_mremap
      0.00            +2.0        2.01            +2.0        1.99            +0.0        0.00        perf-profile.calltrace.cycles-pp.can_modify_mm.do_vmi_munmap.move_vma.__do_sys_mremap.do_syscall_64
      5.34            +3.0        8.38            +3.0        8.34            +0.1        5.41        perf-profile.calltrace.cycles-pp.mremap_to.__do_sys_mremap.do_syscall_64.entry_SYSCALL_64_after_hwframe.mremap
     75.13            -1.9       73.22            -1.7       73.47            +0.4       75.55        perf-profile.children.cycles-pp.move_vma
     37.01            -1.6       35.43            -1.4       35.56            +0.3       37.30        perf-profile.children.cycles-pp.do_vmi_align_munmap
     25.06            -1.3       23.71            -1.3       23.80            +0.0       25.06        perf-profile.children.cycles-pp.copy_vma
     20.00            -1.1       18.94            -1.2       18.77            -0.2       19.81        perf-profile.children.cycles-pp.__split_vma
     19.86            -1.0       18.87            -0.9       18.92            -0.0       19.84        perf-profile.children.cycles-pp.rcu_core
     19.84            -1.0       18.85            -0.9       18.90            -0.0       19.82        perf-profile.children.cycles-pp.rcu_do_batch
     19.88            -1.0       18.89            -0.9       18.94            -0.0       19.86        perf-profile.children.cycles-pp.handle_softirqs
     10.70 ±  3%      -0.9        9.84 ±  3%      -0.9        9.78 ±  2%      -0.4       10.33 ±  3%  perf-profile.children.cycles-pp.kthread
     10.70 ±  3%      -0.9        9.84 ±  3%      -0.9        9.78 ±  2%      -0.4       10.34 ±  3%  perf-profile.children.cycles-pp.ret_from_fork
     10.70 ±  3%      -0.9        9.84 ±  3%      -0.9        9.78 ±  2%      -0.4       10.34 ±  3%  perf-profile.children.cycles-pp.ret_from_fork_asm
     10.64 ±  3%      -0.9        9.79 ±  3%      -0.9        9.73 ±  2%      -0.4       10.29 ±  3%  perf-profile.children.cycles-pp.smpboot_thread_fn
     10.63 ±  3%      -0.9        9.78 ±  3%      -0.9        9.72 ±  2%      -0.4       10.28 ±  3%  perf-profile.children.cycles-pp.run_ksoftirqd
     17.53            -0.8       16.70            -0.8       16.76            +0.0       17.54        perf-profile.children.cycles-pp.kmem_cache_free
     15.28            -0.8       14.47            -1.0       14.33            -0.2       15.04        perf-profile.children.cycles-pp.kmem_cache_alloc_noprof
     15.16            -0.8       14.37            -0.7       14.48            +0.0       15.20        perf-profile.children.cycles-pp.vma_merge
     12.18            -0.6       11.54            -0.6       11.60            +0.0       12.20        perf-profile.children.cycles-pp.mas_wr_store_entry
     11.98            -0.6       11.36            -0.6       11.41            +0.0       11.98        perf-profile.children.cycles-pp.mas_store_prealloc
     12.11            -0.6       11.51            -0.6       11.50            -0.1       12.02        perf-profile.children.cycles-pp.__slab_free
     10.86            -0.6       10.26            -0.7       10.21            -0.1       10.75        perf-profile.children.cycles-pp.vm_area_dup
      9.89            -0.5        9.40            -0.5        9.44            +0.0        9.93        perf-profile.children.cycles-pp.mas_wr_node_store
      8.36            -0.4        7.92            -0.4        7.97            +0.1        8.49        perf-profile.children.cycles-pp.__memcg_slab_post_alloc_hook
      7.98            -0.4        7.58            -0.3        7.68            +0.1        8.08        perf-profile.children.cycles-pp.move_page_tables
      6.69            -0.4        6.33            -0.3        6.39            +0.0        6.72        perf-profile.children.cycles-pp.vma_complete
      5.86            -0.3        5.56            -0.2        5.64            +0.1        5.93        perf-profile.children.cycles-pp.move_ptes
      5.11            -0.3        4.81            -0.3        4.80            -0.2        4.95        perf-profile.children.cycles-pp.mas_preallocate
      6.05            -0.3        5.75            -0.3        5.77            +0.0        6.07        perf-profile.children.cycles-pp.vm_area_free_rcu_cb
      2.98 ±  2%      -0.3        2.73 ±  4%      -0.3        2.66 ±  6%      -0.1        2.88 ±  3%  perf-profile.children.cycles-pp.__memcpy
      3.48            -0.2        3.26            -0.2        3.25            -0.0        3.45        perf-profile.children.cycles-pp.___slab_alloc
      3.46 ±  2%      -0.2        3.26            +0.3        3.71 ±  2%      +0.5        3.92 ±  2%  perf-profile.children.cycles-pp.mod_objcg_state
      2.91            -0.2        2.73            -0.2        2.73            -0.1        2.79        perf-profile.children.cycles-pp.mas_alloc_nodes
      2.43            -0.2        2.25            -0.2        2.27            +0.0        2.45        perf-profile.children.cycles-pp.find_vma_prev
      3.47            -0.2        3.29            -0.2        3.27 ±  2%      +0.0        3.50 ±  2%  perf-profile.children.cycles-pp.down_write
      3.46            -0.2        3.28            -0.2        3.30            +0.0        3.46        perf-profile.children.cycles-pp.flush_tlb_mm_range
      4.22            -0.2        4.06            -0.3        3.91            -0.1        4.16        perf-profile.children.cycles-pp.anon_vma_clone
      3.32            -0.2        3.17            -0.1        3.25            +0.1        3.42        perf-profile.children.cycles-pp.__memcg_slab_free_hook
      3.35            -0.2        3.20            -0.1        3.24            +0.0        3.40        perf-profile.children.cycles-pp.mas_store_gfp
      2.22            -0.1        2.07            -0.1        2.12            +0.0        2.24        perf-profile.children.cycles-pp.__cond_resched
      2.05 ±  2%      -0.1        1.91            -0.1        1.92            -0.0        2.04        perf-profile.children.cycles-pp.allocate_slab
      3.18            -0.1        3.04            -0.1        3.11            +0.1        3.28        perf-profile.children.cycles-pp.unmap_vmas
      2.24            -0.1        2.11 ±  2%      -0.1        2.10 ±  3%      +0.0        2.25 ±  3%  perf-profile.children.cycles-pp.vma_prepare
      2.12            -0.1        2.00            -0.2        1.95            -0.0        2.08        perf-profile.children.cycles-pp.__call_rcu_common
      2.66            -0.1        2.53            -0.1        2.53            +0.0        2.68        perf-profile.children.cycles-pp.mtree_load
      2.46            -0.1        2.34            -0.1        2.34            +0.0        2.47        perf-profile.children.cycles-pp.rcu_cblist_dequeue
      2.45 ±  4%      -0.1        2.33 ±  2%      -0.3        2.15 ±  3%      -0.2        2.28 ±  2%  perf-profile.children.cycles-pp.obj_cgroup_charge
      2.49            -0.1        2.38            -0.1        2.39            +0.0        2.51        perf-profile.children.cycles-pp.flush_tlb_func
      8.32            -0.1        8.21            +0.2        8.52            +0.5        8.85        perf-profile.children.cycles-pp.unmap_region
      2.48            -0.1        2.37            -0.0        2.44            +0.1        2.59        perf-profile.children.cycles-pp.unmap_page_range
      2.23            -0.1        2.13            -0.1        2.12            +0.0        2.24        perf-profile.children.cycles-pp.native_flush_tlb_one_user
      1.77            -0.1        1.67            -0.1        1.68            -0.0        1.76        perf-profile.children.cycles-pp.mas_wr_walk
      1.88            -0.1        1.78            -0.1        1.80            +0.0        1.89        perf-profile.children.cycles-pp.vma_link
      1.40            -0.1        1.31            -0.1        1.32            -0.0        1.40 ±  2%  perf-profile.children.cycles-pp.shuffle_freelist
      1.84            -0.1        1.75            -0.1        1.75            +0.0        1.85        perf-profile.children.cycles-pp.up_write
      0.97 ±  2%      -0.1        0.88            -0.1        0.90 ±  2%      -0.0        0.94 ±  2%  perf-profile.children.cycles-pp.rcu_all_qs
      1.03            -0.1        0.95            -0.1        0.94            +0.0        1.04        perf-profile.children.cycles-pp.mas_prev
      0.92            -0.1        0.85            -0.1        0.84            -0.0        0.92        perf-profile.children.cycles-pp.mas_prev_setup
      1.58            -0.1        1.50            -0.0        1.54            +0.1        1.64        perf-profile.children.cycles-pp.zap_pmd_range
      1.24            -0.1        1.17            -0.1        1.18            -0.0        1.24        perf-profile.children.cycles-pp.mas_prev_slot
      1.58            -0.1        1.51            -0.1        1.52            +0.0        1.59        perf-profile.children.cycles-pp.mas_update_gap
      0.62            -0.1        0.56            -0.0        0.58            -0.0        0.62        perf-profile.children.cycles-pp.security_mmap_addr
      0.49 ±  2%      -0.1        0.43            -0.0        0.44 ±  2%      -0.0        0.46 ±  3%  perf-profile.children.cycles-pp.setup_object
      0.90            -0.1        0.84            -0.1        0.75            -0.1        0.78        perf-profile.children.cycles-pp.percpu_counter_add_batch
      0.98            -0.1        0.92            -0.0        0.97            +0.0        1.02        perf-profile.children.cycles-pp.mas_pop_node
      0.85            -0.1        0.80            -0.1        0.78            -0.0        0.84        perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      1.68            -0.1        1.62            -0.1        1.62            +0.0        1.68        perf-profile.children.cycles-pp.__get_unmapped_area
      1.23            -0.1        1.18            +0.0        1.27            +0.1        1.34        perf-profile.children.cycles-pp.__pte_offset_map_lock
      1.08            -0.1        1.03            -0.0        1.08            +0.1        1.14        perf-profile.children.cycles-pp.zap_pte_range
      0.69 ±  2%      -0.0        0.64            -0.0        0.67 ±  2%      +0.0        0.70        perf-profile.children.cycles-pp.syscall_return_via_sysret
      1.04            -0.0        1.00            -0.0        1.00            +0.0        1.08        perf-profile.children.cycles-pp.vma_to_resize
      1.08            -0.0        1.04            -0.0        1.04            +0.0        1.10        perf-profile.children.cycles-pp.mas_leaf_max_gap
      0.51 ±  3%      -0.0        0.47            -0.0        0.47            -0.0        0.51        perf-profile.children.cycles-pp.anon_vma_interval_tree_insert
      1.18            -0.0        1.14            -0.1        1.12            +0.0        1.18        perf-profile.children.cycles-pp.clear_bhb_loop
      0.57            -0.0        0.53            -0.0        0.52 ±  2%      -0.0        0.54        perf-profile.children.cycles-pp.mas_wr_end_piv
      0.43            -0.0        0.40            -0.1        0.38            -0.0        0.41 ±  3%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
      1.14            -0.0        1.10            -0.0        1.09            +0.0        1.15        perf-profile.children.cycles-pp.mt_find
      0.62            -0.0        0.58            -0.0        0.58            -0.0        0.61        perf-profile.children.cycles-pp.__put_partials
      0.46 ±  7%      -0.0        0.42 ±  2%      -0.0        0.43            -0.0        0.45        perf-profile.children.cycles-pp._raw_spin_lock
      0.90            -0.0        0.87            -0.0        0.88            +0.0        0.90        perf-profile.children.cycles-pp.userfaultfd_unmap_complete
      0.46 ±  3%      -0.0        0.42 ±  3%      -0.0        0.42 ±  2%      -0.0        0.45 ±  2%  perf-profile.children.cycles-pp.__alloc_pages_noprof
      0.61            -0.0        0.58            -0.0        0.58            -0.0        0.60        perf-profile.children.cycles-pp.entry_SYSCALL_64
      0.44 ±  3%      -0.0        0.40 ±  3%      -0.0        0.40 ±  2%      -0.0        0.43 ±  2%  perf-profile.children.cycles-pp.get_page_from_freelist
      0.48            -0.0        0.45 ±  2%      -0.0        0.45            -0.0        0.46        perf-profile.children.cycles-pp.mas_prev_range
      0.64            -0.0        0.61            -0.0        0.61            +0.0        0.65        perf-profile.children.cycles-pp.get_old_pud
      0.31 ±  2%      -0.0        0.28 ±  3%      -0.0        0.29 ±  2%      +0.0        0.32 ±  3%  perf-profile.children.cycles-pp.security_vm_enough_memory_mm
      0.33 ±  3%      -0.0        0.30 ±  2%      -0.0        0.30 ±  2%      -0.0        0.32 ±  2%  perf-profile.children.cycles-pp.mas_put_in_tree
      0.32 ±  2%      -0.0        0.29 ±  2%      -0.0        0.30 ±  3%      -0.0        0.31 ±  2%  perf-profile.children.cycles-pp.tlb_finish_mmu
      0.47            -0.0        0.44 ±  2%      -0.0        0.42 ±  2%      -0.0        0.45        perf-profile.children.cycles-pp.rcu_segcblist_enqueue
      0.70 ±  3%      -0.0        0.68            -0.0        0.66 ±  3%      -0.1        0.60        perf-profile.children.cycles-pp.__anon_vma_interval_tree_remove
      0.32 ±  3%      -0.0        0.30 ±  2%      -0.0        0.30            -0.0        0.32        perf-profile.children.cycles-pp.free_unref_page
      0.55            -0.0        0.53            -0.0        0.55 ±  2%      +0.0        0.58        perf-profile.children.cycles-pp.refill_obj_stock
      0.33            -0.0        0.31            -0.0        0.32            +0.0        0.33        perf-profile.children.cycles-pp.mas_destroy
      0.25 ±  4%      -0.0        0.23 ±  3%      -0.0        0.23 ±  3%      -0.0        0.25 ±  2%  perf-profile.children.cycles-pp.rmqueue
      0.35            -0.0        0.34            -0.0        0.34            +0.0        0.36        perf-profile.children.cycles-pp.__rb_insert_augmented
      0.39            -0.0        0.37            -0.0        0.36 ±  2%      -0.0        0.38        perf-profile.children.cycles-pp.down_write_killable
      0.22 ±  4%      -0.0        0.20 ±  3%      -0.0        0.20 ±  3%      -0.0        0.22 ±  3%  perf-profile.children.cycles-pp.__rmqueue_pcplist
      0.21 ±  4%      -0.0        0.19 ±  3%      -0.0        0.19 ±  3%      -0.0        0.20 ±  3%  perf-profile.children.cycles-pp.rmqueue_bulk
      0.52            -0.0        0.51 ±  2%      +0.1        0.59            +0.1        0.64        perf-profile.children.cycles-pp.__pte_offset_map
      0.30 ±  2%      -0.0        0.28 ±  2%      -0.1        0.23 ±  3%      -0.0        0.25 ±  3%  perf-profile.children.cycles-pp.__vm_enough_memory
      0.26            -0.0        0.24 ±  2%      -0.0        0.21            -0.0        0.22        perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      0.28 ±  2%      -0.0        0.27 ±  2%      -0.0        0.26            -0.0        0.28 ±  2%  perf-profile.children.cycles-pp.free_unref_page_commit
      0.29            -0.0        0.27            -0.0        0.27 ±  2%      +0.0        0.29 ±  2%  perf-profile.children.cycles-pp.tlb_gather_mmu
      0.16 ±  2%      -0.0        0.14 ±  3%      -0.0        0.14 ±  2%      -0.0        0.14 ±  3%  perf-profile.children.cycles-pp.mas_wr_append
      0.28 ±  2%      -0.0        0.26            +0.0        0.32            +0.1        0.33 ±  2%  perf-profile.children.cycles-pp.khugepaged_enter_vma
      0.32            -0.0        0.30            -0.0        0.30            -0.0        0.32 ±  2%  perf-profile.children.cycles-pp.mas_wr_store_setup
      0.09 ±  4%      -0.0        0.08 ±  5%      -0.0        0.06 ±  6%      -0.0        0.07        perf-profile.children.cycles-pp.vma_dup_policy
      0.43            -0.0        0.42            -0.0        0.41            +0.0        0.43        perf-profile.children.cycles-pp.mremap_userfaultfd_complete
      0.13 ±  6%      -0.0        0.12 ± 11%      -0.0        0.10 ±  4%      +0.0        0.13 ±  9%  perf-profile.children.cycles-pp.vm_stat_account
      0.36            -0.0        0.35            -0.0        0.35            +0.0        0.37        perf-profile.children.cycles-pp.madvise_vma_behavior
      0.18 ±  2%      -0.0        0.17 ±  2%      -0.0        0.16 ±  2%      +0.0        0.18 ±  2%  perf-profile.children.cycles-pp.__free_one_page
      0.16 ±  3%      -0.0        0.15 ±  3%      -0.0        0.12            -0.0        0.13 ±  3%  perf-profile.children.cycles-pp.x64_sys_call
      0.15 ±  3%      -0.0        0.14 ±  3%      -0.0        0.13 ±  2%      -0.0        0.14 ±  2%  perf-profile.children.cycles-pp.flush_tlb_batched_pending
      0.15 ±  2%      -0.0        0.14 ±  3%      +0.0        0.19 ±  2%      +0.1        0.20 ±  2%  perf-profile.children.cycles-pp.mas_node_count_gfp
      0.24 ±  2%      +0.0        0.24 ±  3%      +0.0        0.24 ±  2%      +0.0        0.27 ±  6%  perf-profile.children.cycles-pp.lru_add_drain
      0.07            +0.0        0.07 ±  6%      -0.0        0.05            -0.0        0.05 ±  9%  perf-profile.children.cycles-pp.__x64_sys_mremap
      0.14 ±  3%      +0.0        0.15 ±  2%      +0.0        0.14 ±  5%      +0.0        0.14 ±  2%  perf-profile.children.cycles-pp.free_pgd_range
      0.08 ±  4%      +0.0        0.10 ±  4%      +0.0        0.08            +0.0        0.08        perf-profile.children.cycles-pp.mm_get_unmapped_area_vmflags
      0.78            +0.1        0.85            +0.1        0.84            +0.0        0.79        perf-profile.children.cycles-pp.__madvise
      0.63            +0.1        0.71            +0.1        0.70            +0.0        0.64        perf-profile.children.cycles-pp.__x64_sys_madvise
      0.63            +0.1        0.70            +0.1        0.70            +0.0        0.64        perf-profile.children.cycles-pp.do_madvise
      3.52            +0.1        3.60            +0.4        3.97            +0.5        4.03        perf-profile.children.cycles-pp.free_pgtables
      0.00            +0.1        0.09            +0.1        0.09 ±  3%      +0.0        0.00        perf-profile.children.cycles-pp.can_modify_mm_madv
      1.30            +0.2        1.46            +0.2        1.48            +0.0        1.32        perf-profile.children.cycles-pp.mas_next_slot
     88.06            +0.8       88.84            +0.9       88.91            +0.3       88.40        perf-profile.children.cycles-pp.mremap
     83.81            +1.0       84.84            +1.2       84.99            +0.5       84.28        perf-profile.children.cycles-pp.__do_sys_mremap
     85.98            +1.0       87.02            +1.1       87.07            +0.4       86.38        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     85.50            +1.1       86.56            +1.1       86.60            +0.4       85.89        perf-profile.children.cycles-pp.do_syscall_64
      2.12            +1.5        3.62            +1.5        3.61            +0.0        2.13        perf-profile.children.cycles-pp.do_munmap
     40.41            +1.5       41.93            +1.6       42.04            +0.3       40.75        perf-profile.children.cycles-pp.do_vmi_munmap
      3.62            +2.4        5.98            +2.3        5.93            +0.0        3.65        perf-profile.children.cycles-pp.mas_walk
      5.40            +3.0        8.44            +3.0        8.41            +0.1        5.47        perf-profile.children.cycles-pp.mremap_to
      5.26            +3.2        8.48            +3.2        8.44            +0.1        5.31        perf-profile.children.cycles-pp.mas_find
      0.00            +5.5        5.46            +5.4        5.42            +0.0        0.00        perf-profile.children.cycles-pp.can_modify_mm
     11.49            -0.6       10.92            -0.6       10.92            -0.1       11.41        perf-profile.self.cycles-pp.__slab_free
      4.32            -0.2        4.07            -1.1        3.26 ±  2%      -0.9        3.46        perf-profile.self.cycles-pp.__memcg_slab_post_alloc_hook
      1.96            -0.2        1.80 ±  4%      -0.2        1.75 ±  6%      -0.1        1.89 ±  3%  perf-profile.self.cycles-pp.__memcpy
      2.36 ±  2%      -0.1        2.24 ±  2%      -0.1        2.22 ±  3%      +0.0        2.38 ±  2%  perf-profile.self.cycles-pp.down_write
      2.42            -0.1        2.30            -0.1        2.31            +0.0        2.44        perf-profile.self.cycles-pp.rcu_cblist_dequeue
      2.33            -0.1        2.22            -0.1        2.21            -0.0        2.32        perf-profile.self.cycles-pp.mtree_load
      2.21            -0.1        2.10            -0.1        2.10            +0.0        2.22        perf-profile.self.cycles-pp.native_flush_tlb_one_user
      2.04 ±  5%      -0.1        1.95 ±  3%      -0.2        1.80 ±  3%      -0.1        1.90 ±  3%  perf-profile.self.cycles-pp.obj_cgroup_charge
      1.62            -0.1        1.54            -0.1        1.55            +0.0        1.63 ±  2%  perf-profile.self.cycles-pp.__memcg_slab_free_hook
      1.52            -0.1        1.44            -0.1        1.45            -0.0        1.50        perf-profile.self.cycles-pp.mas_wr_walk
      1.15 ±  2%      -0.1        1.07            -0.1        1.08            -0.0        1.14 ±  2%  perf-profile.self.cycles-pp.shuffle_freelist
      1.53            -0.1        1.45            -0.1        1.46            +0.0        1.53        perf-profile.self.cycles-pp.up_write
      1.44            -0.1        1.36            -0.1        1.33            -0.0        1.41        perf-profile.self.cycles-pp.__call_rcu_common
      0.70 ±  2%      -0.1        0.62            -0.1        0.64 ±  3%      -0.0        0.67 ±  2%  perf-profile.self.cycles-pp.rcu_all_qs
      1.72            -0.1        1.66            +1.0        2.68 ±  2%      +1.1        2.84        perf-profile.self.cycles-pp.mod_objcg_state
      0.51 ±  3%      -0.1        0.45            -0.0        0.47            -0.0        0.50        perf-profile.self.cycles-pp.security_mmap_addr
      2.52            -0.1        2.46            -0.2        2.36            -0.2        2.33        perf-profile.self.cycles-pp.kmem_cache_alloc_noprof
      0.94 ±  2%      -0.1        0.88 ±  4%      -0.1        0.88 ±  3%      -0.0        0.92 ±  5%  perf-profile.self.cycles-pp.vm_area_dup
      1.18            -0.1        1.12            -0.1        1.12            -0.0        1.18        perf-profile.self.cycles-pp.vma_merge
      0.89            -0.1        0.83            -0.1        0.83            -0.0        0.88        perf-profile.self.cycles-pp.___slab_alloc
      1.38            -0.1        1.33            -0.0        1.34            +0.0        1.39        perf-profile.self.cycles-pp.do_vmi_align_munmap
      0.62            -0.1        0.56 ±  2%      -0.1        0.56            -0.0        0.59        perf-profile.self.cycles-pp.mremap
      1.00            -0.1        0.95            -0.1        0.94            -0.0        0.97        perf-profile.self.cycles-pp.mas_preallocate
      0.98            -0.1        0.93            -0.0        0.94            -0.0        0.98        perf-profile.self.cycles-pp.move_ptes
      0.99            -0.1        0.94            -0.0        0.94            -0.0        0.99        perf-profile.self.cycles-pp.mas_prev_slot
      1.09            -0.0        1.04 ±  2%      -0.0        1.07            +0.0        1.14        perf-profile.self.cycles-pp.__cond_resched
      0.94            -0.0        0.90            -0.1        0.88            -0.0        0.94        perf-profile.self.cycles-pp.vm_area_free_rcu_cb
      0.85            -0.0        0.80            -0.0        0.84            +0.0        0.88        perf-profile.self.cycles-pp.mas_pop_node
      0.77            -0.0        0.72            -0.1        0.64            -0.1        0.66        perf-profile.self.cycles-pp.percpu_counter_add_batch
      0.68            -0.0        0.63            -0.1        0.62            -0.0        0.66        perf-profile.self.cycles-pp.__split_vma
      1.17            -0.0        1.13            -0.1        1.11            +0.0        1.17        perf-profile.self.cycles-pp.clear_bhb_loop
      0.95            -0.0        0.91            -0.0        0.91            +0.0        0.95        perf-profile.self.cycles-pp.mas_leaf_max_gap
      0.79            -0.0        0.75            -0.0        0.77            +0.0        0.80        perf-profile.self.cycles-pp.mas_wr_store_entry
      0.44            -0.0        0.40            -0.0        0.41            +0.0        0.44        perf-profile.self.cycles-pp.do_munmap
      1.22            -0.0        1.18            -0.0        1.19            +0.0        1.22        perf-profile.self.cycles-pp.move_vma
      0.45            -0.0        0.42            -0.0        0.41            -0.0        0.43        perf-profile.self.cycles-pp.mas_wr_end_piv
      0.89            -0.0        0.86            -0.0        0.87            +0.0        0.90        perf-profile.self.cycles-pp.mas_store_gfp
      0.43 ±  2%      -0.0        0.40            -0.1        0.38            -0.0        0.41 ±  3%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
      0.78            -0.0        0.75            -0.0        0.76            +0.0        0.79        perf-profile.self.cycles-pp.userfaultfd_unmap_complete
      0.66            -0.0        0.63            -0.0        0.63            -0.0        0.66        perf-profile.self.cycles-pp.mas_store_prealloc
      1.49            -0.0        1.46            -0.0        1.45 ±  2%      +0.0        1.50        perf-profile.self.cycles-pp.kmem_cache_free
      0.60            -0.0        0.58            -0.0        0.58            +0.0        0.61        perf-profile.self.cycles-pp.unmap_region
      0.86            -0.0        0.83            -0.0        0.84            +0.0        0.88        perf-profile.self.cycles-pp.move_page_tables
      0.43 ±  4%      -0.0        0.40            -0.0        0.40            -0.0        0.42        perf-profile.self.cycles-pp.anon_vma_interval_tree_insert
      0.99            -0.0        0.97            -0.0        0.95            +0.0        1.00        perf-profile.self.cycles-pp.mt_find
      0.71            -0.0        0.68            -0.0        0.67            -0.0        0.69        perf-profile.self.cycles-pp.unmap_page_range
      0.36 ±  3%      -0.0        0.33 ±  2%      -0.0        0.34 ±  3%      +0.0        0.36 ±  2%  perf-profile.self.cycles-pp.syscall_return_via_sysret
      0.55            -0.0        0.52            -0.0        0.52            +0.0        0.55        perf-profile.self.cycles-pp.get_old_pud
      0.49            -0.0        0.47            -0.0        0.47            +0.0        0.49        perf-profile.self.cycles-pp.find_vma_prev
      0.27            -0.0        0.25            -0.0        0.25            -0.0        0.26 ±  2%  perf-profile.self.cycles-pp.mas_prev_setup
      0.41            -0.0        0.39            -0.0        0.39            +0.0        0.42        perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.61            -0.0        0.58            -0.0        0.59            +0.0        0.62        perf-profile.self.cycles-pp.copy_vma
      0.37 ±  6%      -0.0        0.35 ±  2%      -0.0        0.36            -0.0        0.37        perf-profile.self.cycles-pp._raw_spin_lock
      0.47            -0.0        0.45 ±  2%      -0.0        0.46            -0.0        0.47        perf-profile.self.cycles-pp.flush_tlb_mm_range
      0.42 ±  2%      -0.0        0.40 ±  2%      -0.0        0.38 ±  2%      -0.0        0.41        perf-profile.self.cycles-pp.rcu_segcblist_enqueue
      0.27            -0.0        0.25 ±  2%      -0.0        0.24 ±  2%      -0.0        0.26 ±  2%  perf-profile.self.cycles-pp.mas_put_in_tree
      0.44            -0.0        0.42            -0.0        0.42            +0.0        0.44        perf-profile.self.cycles-pp.mas_update_gap
      0.39            -0.0        0.37            -0.0        0.38            -0.0        0.39        perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.49            -0.0        0.47            +0.0        0.50 ±  2%      +0.0        0.52        perf-profile.self.cycles-pp.refill_obj_stock
      0.27 ±  2%      -0.0        0.25 ±  2%      -0.0        0.26            -0.0        0.27        perf-profile.self.cycles-pp.tlb_finish_mmu
      0.34            -0.0        0.32            -0.0        0.32            -0.0        0.33        perf-profile.self.cycles-pp.zap_pmd_range
      0.48            -0.0        0.46            -0.0        0.48            +0.0        0.49        perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.58 ±  2%      -0.0        0.56            -0.0        0.54 ±  3%      -0.1        0.48        perf-profile.self.cycles-pp.__anon_vma_interval_tree_remove
      0.28            -0.0        0.26            -0.0        0.27            +0.0        0.28 ±  2%  perf-profile.self.cycles-pp.mas_alloc_nodes
      0.24 ±  2%      -0.0        0.22            -0.0        0.22            +0.0        0.24 ±  2%  perf-profile.self.cycles-pp.mas_prev
      0.14 ±  3%      -0.0        0.12 ±  2%      -0.0        0.12            -0.0        0.12        perf-profile.self.cycles-pp.syscall_exit_to_user_mode
      0.52            -0.0        0.51            -0.0        0.51            +0.0        0.55        perf-profile.self.cycles-pp.mremap_to
      0.26            -0.0        0.24            -0.0        0.24            -0.0        0.26        perf-profile.self.cycles-pp.__rb_insert_augmented
      0.40            -0.0        0.39            -0.0        0.39            +0.0        0.41 ±  2%  perf-profile.self.cycles-pp.__pte_offset_map_lock
      0.38            -0.0        0.37            -0.0        0.36            -0.0        0.38        perf-profile.self.cycles-pp.mremap_userfaultfd_complete
      0.28            -0.0        0.26 ±  3%      -0.0        0.26            -0.0        0.27 ±  2%  perf-profile.self.cycles-pp.mas_prev_range
      0.33 ±  2%      -0.0        0.32            -0.0        0.31            -0.0        0.33 ±  2%  perf-profile.self.cycles-pp.zap_pte_range
      0.28            -0.0        0.26            -0.0        0.27            +0.0        0.28        perf-profile.self.cycles-pp.flush_tlb_func
      0.22            -0.0        0.21 ±  2%      -0.0        0.20 ±  2%      -0.0        0.21        perf-profile.self.cycles-pp.entry_SYSCALL_64
      0.10            -0.0        0.09            -0.0        0.09 ±  3%      -0.0        0.10 ±  3%  perf-profile.self.cycles-pp.mod_node_page_state
      0.17            -0.0        0.16            -0.0        0.17 ±  2%      +0.0        0.17        perf-profile.self.cycles-pp.__thp_vma_allowable_orders
      0.44            -0.0        0.42 ±  2%      +0.1        0.50            +0.1        0.54        perf-profile.self.cycles-pp.__pte_offset_map
      0.06            -0.0        0.05            -0.1        0.00            -0.0        0.02 ±129%  perf-profile.self.cycles-pp.vma_dup_policy
      0.13 ±  3%      -0.0        0.12 ±  3%      -0.0        0.09            -0.0        0.09 ±  5%  perf-profile.self.cycles-pp.x64_sys_call
      0.31            -0.0        0.30            -0.0        0.29            -0.0        0.29        perf-profile.self.cycles-pp.unmap_vmas
      0.10 ± 10%      -0.0        0.09 ± 12%      -0.0        0.08 ±  5%      +0.0        0.10 ± 12%  perf-profile.self.cycles-pp.vm_stat_account
      0.08 ±  5%      -0.0        0.07 ±  4%      +0.0        0.11 ±  3%      +0.0        0.12 ±  3%  perf-profile.self.cycles-pp.mas_node_count_gfp
      0.22            -0.0        0.21 ±  2%      -0.0        0.20            -0.0        0.21 ±  2%  perf-profile.self.cycles-pp.do_syscall_64
      0.11            -0.0        0.10 ±  4%      -0.0        0.10            +0.0        0.11        perf-profile.self.cycles-pp.security_vm_enough_memory_mm
      0.08            -0.0        0.08 ±  5%      -0.0        0.08 ±  4%      +0.0        0.09        perf-profile.self.cycles-pp.__vm_enough_memory
      0.07            +0.0        0.07            +0.0        0.08            +0.0        0.09 ±  3%  perf-profile.self.cycles-pp.khugepaged_enter_vma
      0.15 ±  3%      +0.0        0.16 ±  3%      +0.0        0.16 ±  3%      +0.0        0.17 ±  2%  perf-profile.self.cycles-pp.vma_to_resize
      0.56            +0.0        0.57            -0.0        0.53            -0.0        0.53        perf-profile.self.cycles-pp.__do_sys_mremap
      0.06 ±  5%      +0.0        0.07            +0.0        0.06            +0.0        0.06        perf-profile.self.cycles-pp.mm_get_unmapped_area_vmflags
      0.11 ±  4%      +0.0        0.12 ±  4%      -0.0        0.11 ±  3%      +0.0        0.12 ±  3%  perf-profile.self.cycles-pp.free_pgd_range
      0.21            +0.0        0.22 ±  2%      -0.0        0.21 ±  2%      +0.0        0.22 ±  2%  perf-profile.self.cycles-pp.thp_get_unmapped_area_vmflags
      0.45            +0.0        0.48            +0.0        0.48            -0.0        0.44        perf-profile.self.cycles-pp.do_vmi_munmap
      0.27            +0.0        0.32            +0.3        0.60            +0.4        0.62        perf-profile.self.cycles-pp.free_pgtables
      0.36 ±  2%      +0.1        0.44            +0.0        0.37 ±  2%      -0.0        0.35        perf-profile.self.cycles-pp.unlink_anon_vmas
      1.06            +0.1        1.19            +0.1        1.20            +0.0        1.08        perf-profile.self.cycles-pp.mas_next_slot
      1.49            +0.5        2.01            +0.5        1.98            +0.0        1.50        perf-profile.self.cycles-pp.mas_find
      0.00            +1.4        1.38            +1.4        1.38            +0.0        0.00        perf-profile.self.cycles-pp.can_modify_mm
      3.15            +2.1        5.23            +2.0        5.19            +0.0        3.16        perf-profile.self.cycles-pp.mas_walk


> 
> For everyone: Apologies if you're in the CC list and I didn't CC you,
> but I tried to keep my patch set's CC list relatively short and clean
> (and I focused on the active participants).
> Everyone's comments are very welcome.
> 
> [1]: https://lore.kernel.org/all/20240806212808.1885309-1-pedro.falcato@gmail.com/
> -- 
> Pedro


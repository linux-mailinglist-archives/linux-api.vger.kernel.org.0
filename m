Return-Path: <linux-api+bounces-2132-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F06C948924
	for <lists+linux-api@lfdr.de>; Tue,  6 Aug 2024 08:05:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E17181F23A10
	for <lists+linux-api@lfdr.de>; Tue,  6 Aug 2024 06:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1B0D1BA87B;
	Tue,  6 Aug 2024 06:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z1m1tfEZ"
X-Original-To: linux-api@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A872CA5;
	Tue,  6 Aug 2024 06:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722924309; cv=fail; b=ftOz5utWkmCFuaIbSlJy6BheJY4WbJ9cO9ZDfyHnUBOKD1nUImzg7KznYG5s+N8hasMuEN0Pg+O0UCWz57m5boUVwc9GTZoEIB8SKBGJXD1XQD//RQ2nixK4xyhTZ783ofr+ftH3Qkil5/A0GCWsNQrhmuy9bIZj6u8GheJisl8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722924309; c=relaxed/simple;
	bh=bYjcOFpVh0k05ye08stxN3aYXSvWuhpwloS5lolAuAE=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tLk4B53fVOuiKGHFKlvsw93Zq64dLw0wlVuDyOMAYKuXGClq36L1nIeA3Z/vQV0J8dRSSDkqKGe2gVxmHFYIPayTkKXoCd8LlOSqCiGkedcbZemPxihFGMtG6oi59Q3m1vAPe5+Ox6/s8h9F3r5E4krldBv8OK9WNx5Rw/2k224=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z1m1tfEZ; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722924307; x=1754460307;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=bYjcOFpVh0k05ye08stxN3aYXSvWuhpwloS5lolAuAE=;
  b=Z1m1tfEZqm8eP8QHVvrfY+/lMFatbqSGAg8ol1+aNkhN9SLB5Zwzfrze
   NhDsjzBwxqysE8nTWesZ2sVCSWaGuaZGI0P/pH/nZv9qQQahl+1bmIiEa
   7Mbhh/JZHYZn4A56apTmv5IULRR0hTW24E/BVphOuh8VS30rmpsYjU2bi
   cGOIbp8KEyutcb/MFQsO7owAXOuGQXLVyHpSCAFuFDtt9L+/3imL4n5Lq
   Q1O2SJJDYw7BF0P+ZQ8SafmiMkMHYboDsJd+hVXzCl/zu0JysTX2njCA8
   TPP+GCtkFdUAa8n2jl4dGZGi12fV0PBmcw7+80ZMmbBh4P8fGI7Td/xL8
   A==;
X-CSE-ConnectionGUID: BJI3DNz3S4iGPn+UpslJAg==
X-CSE-MsgGUID: H01pbLokRz2GUQfwblLXhA==
X-IronPort-AV: E=McAfee;i="6700,10204,11155"; a="20588607"
X-IronPort-AV: E=Sophos;i="6.09,266,1716274800"; 
   d="scan'208";a="20588607"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2024 23:05:05 -0700
X-CSE-ConnectionGUID: WM0a+K3vS7mn9hHQ+q8Z1A==
X-CSE-MsgGUID: +1LXiGKzRUaH6WJJT0jIKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,266,1716274800"; 
   d="scan'208";a="56484654"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Aug 2024 23:05:04 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 5 Aug 2024 23:05:03 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 5 Aug 2024 23:05:03 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 5 Aug 2024 23:05:03 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 5 Aug 2024 23:05:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cAtZdt/tMv+jAVO1OAGuWnyQUmvmAr0r3wijFWKU//8Qnkeea7hMP6bxFJCRjuAQoHSy5W+ZBg0YxbfdREaFExpvvgTi86wX/vWuhb8Sdc9rD5lEobVb1CwZONG/Xp/qphHRr2DZP9VtOUMwx5niSl0ETSlrkgSKDmtYZfn/MeBJH9M1CEOddsoeW4DGjDbebvKRqwV7qs7Y+zhrmXJW4NvjDMWHVvXeEJs0JdC8lNOUuX95pZ4SzjKwRThDjxl4X8/6Beh1Cxa6I5fljSemDNSmc0t/Pj0WTQxbCOIR/1KM0kOufDCpni+Ik5Bws59UaCzTh3rcBr7p2lsVQutPTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s6N7KgvRg/OlLObmnSQ14nRRRTA8yjBsRZvzmEuKRmw=;
 b=geLGpzRqVmwLF7XiXEhk4tTuk6kZ63dr8mloMvTX/Y06HUmFp7MkUcsfdFQ/BbhsVV1Kfalp43yUKyuQD43zg4qwv7bTEvJuHzMHBJHDcCQKK+RbP9HpQhwJKB5vs5zOrLP7yxwyELGNSH9Pfi8MyWHTniYL6SeCrNJBzNkieX96ngs469+MlFGCQRQiJCFhcba3OgRjarAjt2XN/HMAqSLm7qDY8MWK9PBixNtJMnngy0d10bk5Etq37OO6AbIbQL080hwsEzgYnbT+Bffg2K+DVFLeYnk11q0Tvglwtm3Tmt6Hz59qu97i3zJ7Jqyy+2OfDLchtWBKPdRL5fczYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SN7PR11MB7512.namprd11.prod.outlook.com (2603:10b6:806:345::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.20; Tue, 6 Aug
 2024 06:05:00 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.7828.023; Tue, 6 Aug 2024
 06:05:00 +0000
Date: Tue, 6 Aug 2024 14:04:43 +0800
From: Oliver Sang <oliver.sang@intel.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
CC: Jeff Xu <jeffxu@google.com>, Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy
	<christophe.leroy@csgroup.eu>, Pedro Falcato <pedro.falcato@gmail.com>, "Jeff
 Xu" <jeffxu@chromium.org>, <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
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
Message-ID: <ZrG8+/1YjxN/Hsb7@xsang-OptiPlex-9020>
References: <202408041602.caa0372-oliver.sang@intel.com>
 <CAHk-=whbxLj0thXPzN9aW4CcX1D2_dntNu+x9-8uBakamBggLA@mail.gmail.com>
 <CAKbZUD3B03Zjex4STW8J_1VJhpsYb=1mnZL2-vSaW-CaZdzLiA@mail.gmail.com>
 <CALmYWFuXVCvAfrcDOCAR72z2_rmnm09QeVVqdhzqjF-fZ9ndUA@mail.gmail.com>
 <CAHk-=wgPHCJ0vZMfEP50VPjSVi-CzL0fhTGXgNLQn=Pp9W0DVA@mail.gmail.com>
 <CAHk-=wgdTWpCqTMgM9SJxG2=oYwhAueU_fDHMPifjpH5eHG8qw@mail.gmail.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=wgdTWpCqTMgM9SJxG2=oYwhAueU_fDHMPifjpH5eHG8qw@mail.gmail.com>
X-ClientProxiedBy: SI2PR04CA0008.apcprd04.prod.outlook.com
 (2603:1096:4:197::20) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SN7PR11MB7512:EE_
X-MS-Office365-Filtering-Correlation-Id: 32d6e35a-c4d1-4bdc-8120-08dcb5ddb488
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?t0q5MmzOGv/kKgj1WRJYYvAxs+nvDMayv9aFh5mZ4izY2h9LgsjV0RoPZo?=
 =?iso-8859-1?Q?E3aAI5oStdm5awJKMWEiteLoEnVr1hTmMdsfZV9iNL9Y4dNbyvHJL/1igY?=
 =?iso-8859-1?Q?WLqrv9At5hpmM8i8E8ngtGJeeRsr7bEHVV4AFDYKxizmwfyn4EWJt4cE6d?=
 =?iso-8859-1?Q?RpQ2phf97jaEAcaXlTYicUDMno5CLq8mS4A1sKvleza/p7sWLMZINabRiz?=
 =?iso-8859-1?Q?rXQIOTBcAmTb+bjj6+azUMBvvcMxFPBHY5z3Ey0NAgxdJEZKrsx9CBP8Gf?=
 =?iso-8859-1?Q?lx7mHazWr5qDBtHEaHfVV7PTPkThAFXQsR+PKgtNdds+8FyWJMbxhbZ/oI?=
 =?iso-8859-1?Q?uRo8szKotxcgSl/R6qrAQ+t2a5Nm3+5ycu2icgEY9xS1fvFN0hEZ6lp74M?=
 =?iso-8859-1?Q?qzd1/uAu4FqftLVr9ZF2w4G8pqEcY21g8PIjO1AaFZFmq9duKoqlZZ3dyn?=
 =?iso-8859-1?Q?Jlx+gKCSOun9IGVrkEMm0tiUd2lVfQ3ruVpvPHuCC2rMMHgsTr5oW+O7S8?=
 =?iso-8859-1?Q?SoGxaiFLueFoCfXUt85CXCD94ARR9jRaC21Z1P86yvSyrMWBFGrNbAGLHW?=
 =?iso-8859-1?Q?ia7CgVqyFwRyuEOGu8IkjF7NWAliZ5zwwPLsIp0mqlw5jFsavGeZyEgD88?=
 =?iso-8859-1?Q?uZa7D21hXZLVClf8kVrScH+sGPk8n6yuOXsejA0DnTTG+14dllftOXiFOX?=
 =?iso-8859-1?Q?doh8zK5zoq/ceFcPgMjA92jfCCf8lXwe+ySl+9zYSgsIAznvEWxyOpaaRP?=
 =?iso-8859-1?Q?/6Ff9t1wofOeniKpE8i0WoV5CapeDREfL1WYYoTrHbmaCGGuibWNZ+h/h9?=
 =?iso-8859-1?Q?6/EetVSay00VUumxTQqYYsfNLg0kew0l/BqkHqtXrYjC+ZUqozkh0eZbME?=
 =?iso-8859-1?Q?lOVLrV/hLKajIGKpOxWR1VEuFpm0yTWycDbddTdT7Q24lqL1lyB7MpbyMA?=
 =?iso-8859-1?Q?KGsMrfiIjSVjWVYa8CgHeiv8yVaEIFScy34z/UNyB/qy5mQ7H8yET256pl?=
 =?iso-8859-1?Q?ZkcYzQTVAXIXjwxRdsstdqwq/ZQDeZU53wuwn2qjUvP1NCg007IHsu48jr?=
 =?iso-8859-1?Q?o4TYSmSJgIdIBUiGkdQGz5ccdRabohoqlEbju0NRjHM92PCAh/dXJ0kb1B?=
 =?iso-8859-1?Q?/pggODjbrDp0hyMiRnTQhVd1qIMchHRTigM8kPne3YSkkjUgjx4fC2uvw4?=
 =?iso-8859-1?Q?CjFCtXJk5uZHPi0s4OJma0v4510zHM4SKAK9ENk1sx1/Qt0OT2K+TvwmPS?=
 =?iso-8859-1?Q?qGOf7iACrZZtOsRZ47feJZanUpljOBLRR3y9hhM0v5j5ksSv2rS2sKnDwk?=
 =?iso-8859-1?Q?x/Lz3ndj/2QWiA/kPHfvYBjJwC1KMMeDM8SRjS+Rn80UmUCa7Ur2GdLOgi?=
 =?iso-8859-1?Q?pHTDQhFdfdmeU7iK1QP3pr1P/opkt0lA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?1Awhzp4spSpcX9RXYrVWzirQMG1V8m852JtvwZns7fGdxJsE5OllGJqXvK?=
 =?iso-8859-1?Q?s2WFrk5VaD7G2E6fBaIuFRQBiZw5va8Q4o5kxVMbOEG+adTu7j0fjwx9DG?=
 =?iso-8859-1?Q?ICwTwk8oe+T1ncWyfJup5zikBbSZVW+9f1V++CSEtb6p3YLKNCh13Lzy9R?=
 =?iso-8859-1?Q?FWjxLWwhBF63o1qZ8hd9urtEO05hGUwg7XwyMxit/+BeI97kobiFzJV6rI?=
 =?iso-8859-1?Q?V/BUhXncvR1nSofOufWyuBVmm4+2ssxyubcX60mjB+iJXIXR50A5f3YOBx?=
 =?iso-8859-1?Q?v02aS8LL0t2uuyLX4oBaYurjEroDUQl9ZO6mFs/YMbJpBU/ktBw/hSyoU/?=
 =?iso-8859-1?Q?hyMQ11Vr0ClIL5CXAlqP59YVhju5GmxOR05j07ps4uFFjC/2m9YzWL23ZU?=
 =?iso-8859-1?Q?YHSThSOl72g1bdc8+8Q4eoh5Tsie2S81yCUqT1QZ4ZDntUvp2kLCjaTj74?=
 =?iso-8859-1?Q?xYKtjcAfGTS4q0xMY3BZDHkp5dq6DRmskAjbmi9DOTXQlNgdxX6ZhUjQmU?=
 =?iso-8859-1?Q?9qVxIa1l0IBtT8fZT9j9u5iqWjZHK98yXk51/tULmwCBntucN6m9OsozXt?=
 =?iso-8859-1?Q?IbxsdKv3bnmL0x3pp1M68omu3XfjrZBB2DRybhNMFybyjTuWlb/MkAPmui?=
 =?iso-8859-1?Q?eI0UyxA2GFTNga019xk5gEEyT3F8V/HVcg3I4IunQgFmc4Qb6y0kvakC6O?=
 =?iso-8859-1?Q?3CFosXbwBgE4ii0bIeuOw7mn/+/78bNFNkOBDGy5N8HuGcc6qld58EZoD4?=
 =?iso-8859-1?Q?+52J6ke593xASGFSOemwVPr3/jNQ9ytzXNte9Vmo+3VHUv5zIt2Vgk3n88?=
 =?iso-8859-1?Q?47mpJSCGWsFOGBu68qbiJbhoaANW5r8l0TGQsriR9x4sEDPausnnAllo4Z?=
 =?iso-8859-1?Q?yAdhwYqCkTX+veOeXKBVJ6vwibAap0pteVAnapZ+ebbs+Uarwb4lyAC2xo?=
 =?iso-8859-1?Q?AhLUtae/4Em3kiuODTFgOs9X0wWHJxYUo5guZbpFbRb5+xN+ZzNIni+bd7?=
 =?iso-8859-1?Q?0/ZUWcdXYzX2GVLAHOKDXnLzOnNIjqQYFEMKMOUyYK9Zj8J5KTprFOmzyI?=
 =?iso-8859-1?Q?V6SztLwedmRkQXDZA8aw/2lEKbnFTrlRsl/jdqkQmv2f6rkEob/8T1OU2k?=
 =?iso-8859-1?Q?gtOC6zRkpeAIJitjHNXCKyKNc5FFFxP0aa0L/ztbfRdWekKE1RrCxs6WBS?=
 =?iso-8859-1?Q?TmvHa7MjKZe2XtSLym/8JhVLnsekdZuamd9vfoLbuNnEmHDMF8A5+E07U/?=
 =?iso-8859-1?Q?80dExDNg634YNgc9aCaz6nkTK3w3IdjJH/xvnz9WStjj2MboFC5DE8ihdr?=
 =?iso-8859-1?Q?x3dwFtao58obtOMVyN4lj0tjoC7Zo54IQXkjX5dt2zrbHq2+7wXztxgbUF?=
 =?iso-8859-1?Q?W4CIJLD0QtFhVqetDwdArKrUgYC2X+nj7dJlMej/2fsJZ9RTlugtv9JW3f?=
 =?iso-8859-1?Q?GF/osj0YteyqD0WfgXiEtCm6WLo+KovyPG7OZq+yIGC8ZzsKIjD1vXRM/t?=
 =?iso-8859-1?Q?+OdHnEu+gvl2rtRFGyLljFqR+DajDC3BZImAwRtqdbouMNOJdkUWEbYlxG?=
 =?iso-8859-1?Q?lfHWE+vwakyFrqBV2kId7FbwyM9+IxX0Pk1J1QGJFpLls9bcYc0yBOKY8Z?=
 =?iso-8859-1?Q?qpwE653Hk3U2LoSJf4wfqgQkTwgRpYw/noH9EImv2hBunlFT0IXgt73Q?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 32d6e35a-c4d1-4bdc-8120-08dcb5ddb488
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2024 06:05:00.5240
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FJpMiS8S/ntKKnYw+xHtGvDLp3WaWc5blh332M3hrmD5DRNL+ttV71M7GeG2tOBGejXgnJkPOd6/zLeID01ZkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7512
X-OriginatorOrg: intel.com

hi, Linus,

On Mon, Aug 05, 2024 at 12:33:58PM -0700, Linus Torvalds wrote:
> On Mon, 5 Aug 2024 at 11:55, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > So please consider this a "maybe something like this" patch, but that
> > 'arch_unmap()' really is pretty nasty
> 
> Actually, the whole powerpc vdso code confused me. It's not the vvar
> thing that wants this close thing, it's the other ones that have the
> remap thing.
> 
> .. and there were two of those error cases that needed to reset the
> vdso pointer.
> 
> That all shows just how carefully I was reading this code.
> 
> New version - still untested, but now I've read through it one more
> time - attached.

we tested this version by applying it directly upon 8be7258aad,  but seems it
have little impact to performance. still similar regression if comparing to
ff388fe5c4.

(the data for 8be7258aad and ff388fe5c4 are a little different with what we
have in previous report, since we rerun tests by gcc-12 compiler. 0day team
change back to gcc-12 from gcc-13 recently due to some issues)

=========================================================================================
compiler/cpufreq_governor/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  gcc-12/performance/x86_64-rhel-8.3/100%/debian-12-x86_64-20240206.cgz/lkp-icl-2sp7/pagemove/stress-ng/60s

commit:
  ff388fe5c4 ("mseal: wire up mseal syscall")
  8be7258aad ("mseal: add mseal syscall")
  4605212a16  <--- your patch

ff388fe5c481d39c 8be7258aad44b5e25977a98db13 4605212a162071afdd9c713e936
---------------- --------------------------- ---------------------------
         %stddev     %change         %stddev     %change         %stddev
             \          |                \          |                \
      4958            +1.3%       5024            +1.2%       5020        time.percent_of_cpu_this_job_got
      2916            +1.5%       2960            +1.4%       2957        time.system_time
     65.85            -7.0%      61.27            -7.0%      61.23        time.user_time
  41535129            -4.5%   39669773            -4.3%   39746835        proc-vmstat.numa_hit
  41465484            -4.5%   39602956            -4.3%   39677556        proc-vmstat.numa_local
  77303973            -4.6%   73780662            -4.4%   73912128        proc-vmstat.pgalloc_normal
  77022096            -4.6%   73502058            -4.4%   73637326        proc-vmstat.pgfree
  18381956            -4.9%   17473438            -5.0%   17457167        stress-ng.pagemove.ops
    306349            -4.9%     291188            -5.0%     290931        stress-ng.pagemove.ops_per_sec
    209930            -6.2%     196996 ±  2%      -7.6%     193911        stress-ng.pagemove.page_remaps_per_sec
      4958            +1.3%       5024            +1.2%       5020        stress-ng.time.percent_of_cpu_this_job_got
      2916            +1.5%       2960            +1.4%       2957        stress-ng.time.system_time
      1.13            -2.1%       1.10            -2.2%       1.10        perf-stat.i.cpi
      0.89            +2.2%       0.91            +2.1%       0.91        perf-stat.i.ipc
      1.04            -7.2%       0.97            -7.1%       0.97        perf-stat.overall.MPKI
      1.13            -2.3%       1.10            -2.2%       1.10        perf-stat.overall.cpi
      1082            +5.4%       1140            +5.3%       1139        perf-stat.overall.cycles-between-cache-misses
      0.89            +2.3%       0.91            +2.3%       0.91        perf-stat.overall.ipc
    192.79            -3.9%     185.32 ±  2%      -2.4%     188.21 ±  3%  perf-stat.ps.cpu-migrations
 1.048e+13            +2.8%  1.078e+13            +2.6%  1.075e+13        perf-stat.total.instructions
     74.97            -1.9       73.07            -2.1       72.88        perf-profile.calltrace.cycles-pp.move_vma.__do_sys_mremap.do_syscall_64.entry_SYSCALL_64_after_hwframe.mremap
     36.79            -1.6       35.22            -1.6       35.17        perf-profile.calltrace.cycles-pp.do_vmi_align_munmap.do_vmi_munmap.move_vma.__do_sys_mremap.do_syscall_64
     24.98            -1.3       23.64            -1.4       23.57        perf-profile.calltrace.cycles-pp.copy_vma.move_vma.__do_sys_mremap.do_syscall_64.entry_SYSCALL_64_after_hwframe
     19.91            -1.1       18.85            -1.1       18.83        perf-profile.calltrace.cycles-pp.__split_vma.do_vmi_align_munmap.do_vmi_munmap.move_vma.__do_sys_mremap
     10.70 ±  3%      -0.9        9.84 ±  3%      -0.6       10.06 ±  2%  perf-profile.calltrace.cycles-pp.kthread.ret_from_fork.ret_from_fork_asm
     10.70 ±  3%      -0.9        9.84 ±  3%      -0.6       10.06 ±  2%  perf-profile.calltrace.cycles-pp.ret_from_fork.ret_from_fork_asm
     10.70 ±  3%      -0.9        9.84 ±  3%      -0.6       10.06 ±  2%  perf-profile.calltrace.cycles-pp.ret_from_fork_asm
     10.64 ±  3%      -0.9        9.79 ±  3%      -0.6       10.02 ±  2%  perf-profile.calltrace.cycles-pp.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
     10.63 ±  3%      -0.9        9.78 ±  3%      -0.6       10.01 ±  2%  perf-profile.calltrace.cycles-pp.handle_softirqs.run_ksoftirqd.smpboot_thread_fn.kthread.ret_from_fork
     10.63 ±  3%      -0.9        9.78 ±  3%      -0.6       10.01 ±  2%  perf-profile.calltrace.cycles-pp.run_ksoftirqd.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
     10.63 ±  3%      -0.9        9.78 ±  3%      -0.6       10.01 ±  2%  perf-profile.calltrace.cycles-pp.rcu_core.handle_softirqs.run_ksoftirqd.smpboot_thread_fn.kthread
     10.59 ±  3%      -0.8        9.74 ±  3%      -0.6        9.97 ±  2%  perf-profile.calltrace.cycles-pp.rcu_do_batch.rcu_core.handle_softirqs.run_ksoftirqd.smpboot_thread_fn
     14.77            -0.8       14.00            -0.9       13.91        perf-profile.calltrace.cycles-pp.vma_merge.copy_vma.move_vma.__do_sys_mremap.do_syscall_64
      1.48            -0.5        0.99            -0.5        0.99        perf-profile.calltrace.cycles-pp.mas_find.do_vmi_munmap.move_vma.__do_sys_mremap.do_syscall_64
      5.95 ±  3%      -0.5        5.47 ±  3%      -0.4        5.59 ±  2%  perf-profile.calltrace.cycles-pp.kmem_cache_free.rcu_do_batch.rcu_core.handle_softirqs.run_ksoftirqd
      7.88            -0.4        7.48            -0.4        7.44        perf-profile.calltrace.cycles-pp.move_page_tables.move_vma.__do_sys_mremap.do_syscall_64.entry_SYSCALL_64_after_hwframe
      4.62 ±  3%      -0.4        4.25 ±  3%      -0.3        4.35 ±  2%  perf-profile.calltrace.cycles-pp.__slab_free.kmem_cache_free.rcu_do_batch.rcu_core.handle_softirqs
      6.72            -0.4        6.36            -0.3        6.39        perf-profile.calltrace.cycles-pp.vm_area_dup.__split_vma.do_vmi_align_munmap.do_vmi_munmap.move_vma
      6.15            -0.3        5.82            -0.4        5.80        perf-profile.calltrace.cycles-pp.vma_complete.__split_vma.do_vmi_align_munmap.do_vmi_munmap.move_vma
      6.11            -0.3        5.78            -0.3        5.82        perf-profile.calltrace.cycles-pp.kmem_cache_alloc_noprof.vm_area_dup.__split_vma.do_vmi_align_munmap.do_vmi_munmap
      5.78            -0.3        5.49            -0.3        5.46        perf-profile.calltrace.cycles-pp.move_ptes.move_page_tables.move_vma.__do_sys_mremap.do_syscall_64
      5.54            -0.3        5.25            -0.3        5.22        perf-profile.calltrace.cycles-pp.mas_store_prealloc.vma_complete.__split_vma.do_vmi_align_munmap.do_vmi_munmap
      5.56            -0.3        5.28            -0.3        5.24        perf-profile.calltrace.cycles-pp.mas_store_prealloc.vma_merge.copy_vma.move_vma.__do_sys_mremap
      5.19            -0.3        4.92            -0.3        4.89        perf-profile.calltrace.cycles-pp.mas_wr_store_entry.mas_store_prealloc.vma_complete.__split_vma.do_vmi_align_munmap
      5.20            -0.3        4.94            -0.3        4.91        perf-profile.calltrace.cycles-pp.mas_wr_store_entry.mas_store_prealloc.vma_merge.copy_vma.move_vma
      3.20 ±  4%      -0.3        2.94 ±  3%      -0.2        3.01 ±  2%  perf-profile.calltrace.cycles-pp.vm_area_free_rcu_cb.rcu_do_batch.rcu_core.handle_softirqs.run_ksoftirqd
      4.09            -0.2        3.85            -0.2        3.85        perf-profile.calltrace.cycles-pp.vm_area_dup.copy_vma.move_vma.__do_sys_mremap.do_syscall_64
      4.68            -0.2        4.45            -0.3        4.41        perf-profile.calltrace.cycles-pp.mas_wr_node_store.mas_wr_store_entry.mas_store_prealloc.vma_merge.copy_vma
      2.63 ±  3%      -0.2        2.42 ±  3%      -0.2        2.48 ±  2%  perf-profile.calltrace.cycles-pp.kmem_cache_free.vm_area_free_rcu_cb.rcu_do_batch.rcu_core.handle_softirqs
      2.36 ±  2%      -0.2        2.16 ±  4%      -0.2        2.17 ±  2%  perf-profile.calltrace.cycles-pp.__memcpy.mas_wr_node_store.mas_wr_store_entry.mas_store_prealloc.vma_complete
      3.56            -0.2        3.36            -0.2        3.37        perf-profile.calltrace.cycles-pp.kmem_cache_alloc_noprof.vm_area_dup.copy_vma.move_vma.__do_sys_mremap
      4.00            -0.2        3.81            -0.2        3.78        perf-profile.calltrace.cycles-pp.mas_wr_node_store.mas_wr_store_entry.mas_store_prealloc.vma_complete.__split_vma
      1.35            -0.2        1.16            -0.2        1.17        perf-profile.calltrace.cycles-pp.mas_find.do_vmi_munmap.do_munmap.mremap_to.__do_sys_mremap
      3.40            -0.2        3.22            -0.2        3.21        perf-profile.calltrace.cycles-pp.flush_tlb_mm_range.move_ptes.move_page_tables.move_vma.__do_sys_mremap
      2.22            -0.2        2.06            -0.2        2.05        perf-profile.calltrace.cycles-pp.find_vma_prev.copy_vma.move_vma.__do_sys_mremap.do_syscall_64
      0.96            -0.2        0.82            -0.1        0.82        perf-profile.calltrace.cycles-pp.mas_walk.mas_find.do_vmi_munmap.do_munmap.mremap_to
      3.25            -0.1        3.10            -0.2        3.10        perf-profile.calltrace.cycles-pp.mas_store_gfp.do_vmi_align_munmap.do_vmi_munmap.move_vma.__do_sys_mremap
      1.81 ±  4%      -0.1        1.67 ±  3%      -0.1        1.71 ±  2%  perf-profile.calltrace.cycles-pp.__slab_free.kmem_cache_free.vm_area_free_rcu_cb.rcu_do_batch.rcu_core
      1.97 ±  3%      -0.1        1.83 ±  3%      -0.2        1.81 ±  4%  perf-profile.calltrace.cycles-pp.mod_objcg_state.__memcg_slab_post_alloc_hook.kmem_cache_alloc_noprof.vm_area_dup.__split_vma
      2.26            -0.1        2.12            -0.2        2.11        perf-profile.calltrace.cycles-pp.mas_preallocate.__split_vma.do_vmi_align_munmap.do_vmi_munmap.move_vma
      3.10            -0.1        2.96            -0.1        2.99        perf-profile.calltrace.cycles-pp.__memcg_slab_post_alloc_hook.kmem_cache_alloc_noprof.vm_area_dup.__split_vma.do_vmi_align_munmap
      3.13            -0.1        2.99            -0.1        3.00        perf-profile.calltrace.cycles-pp.unmap_vmas.unmap_region.do_vmi_align_munmap.do_vmi_munmap.move_vma
      2.97            -0.1        2.85            -0.2        2.82        perf-profile.calltrace.cycles-pp.anon_vma_clone.__split_vma.do_vmi_align_munmap.do_vmi_munmap.move_vma
      2.05            -0.1        1.93            -0.1        1.92        perf-profile.calltrace.cycles-pp.mas_preallocate.vma_merge.copy_vma.move_vma.__do_sys_mremap
      8.26            -0.1        8.14            -0.1        8.16        perf-profile.calltrace.cycles-pp.unmap_region.do_vmi_align_munmap.do_vmi_munmap.move_vma.__do_sys_mremap
      2.45            -0.1        2.34            -0.1        2.34        perf-profile.calltrace.cycles-pp.flush_tlb_func.flush_tlb_mm_range.move_ptes.move_page_tables.move_vma
      2.43            -0.1        2.32            -0.1        2.32        perf-profile.calltrace.cycles-pp.unmap_page_range.unmap_vmas.unmap_region.do_vmi_align_munmap.do_vmi_munmap
      1.75 ±  2%      -0.1        1.64 ±  3%      -0.1        1.61 ±  3%  perf-profile.calltrace.cycles-pp.vma_prepare.vma_merge.copy_vma.move_vma.__do_sys_mremap
      0.54            -0.1        0.44 ± 37%      -0.2        0.36 ± 63%  perf-profile.calltrace.cycles-pp.mas_find.find_vma_prev.copy_vma.move_vma.__do_sys_mremap
      2.21            -0.1        2.11            -0.1        2.11        perf-profile.calltrace.cycles-pp.native_flush_tlb_one_user.flush_tlb_func.flush_tlb_mm_range.move_ptes.move_page_tables
      1.27 ±  2%      -0.1        1.16 ±  4%      -0.1        1.18 ±  2%  perf-profile.calltrace.cycles-pp.__memcpy.mas_wr_node_store.mas_wr_store_entry.mas_store_prealloc.vma_merge
      1.32 ±  3%      -0.1        1.22 ±  3%      -0.1        1.25        perf-profile.calltrace.cycles-pp.rcu_cblist_dequeue.rcu_do_batch.rcu_core.handle_softirqs.run_ksoftirqd
      1.85            -0.1        1.76            -0.1        1.76        perf-profile.calltrace.cycles-pp.vma_link.copy_vma.move_vma.__do_sys_mremap.do_syscall_64
      2.14 ±  2%      -0.1        2.05 ±  2%      -0.1        2.00 ±  2%  perf-profile.calltrace.cycles-pp.kmem_cache_alloc_noprof.anon_vma_clone.__split_vma.do_vmi_align_munmap.do_vmi_munmap
      1.40            -0.1        1.31            -0.1        1.30        perf-profile.calltrace.cycles-pp.mas_alloc_nodes.mas_preallocate.__split_vma.do_vmi_align_munmap.do_vmi_munmap
      1.77 ±  3%      -0.1        1.68 ±  2%      -0.1        1.64 ±  2%  perf-profile.calltrace.cycles-pp.__memcg_slab_post_alloc_hook.kmem_cache_alloc_noprof.anon_vma_clone.__split_vma.do_vmi_align_munmap
      1.39            -0.1        1.30            -0.1        1.30        perf-profile.calltrace.cycles-pp.mas_alloc_nodes.mas_preallocate.vma_merge.copy_vma.move_vma
      1.24            -0.1        1.16            -0.1        1.16        perf-profile.calltrace.cycles-pp.kmem_cache_alloc_noprof.mas_alloc_nodes.mas_preallocate.__split_vma.do_vmi_align_munmap
      1.40 ±  3%      -0.1        1.32 ±  4%      -0.1        1.26 ±  5%  perf-profile.calltrace.cycles-pp.down_write.vma_prepare.vma_merge.copy_vma.move_vma
      0.94            -0.1        0.86            -0.1        0.86        perf-profile.calltrace.cycles-pp.mas_walk.mas_find.do_vmi_munmap.move_vma.__do_sys_mremap
      1.23            -0.1        1.15            -0.1        1.15        perf-profile.calltrace.cycles-pp.kmem_cache_alloc_noprof.mas_alloc_nodes.mas_preallocate.vma_merge.copy_vma
      1.54            -0.1        1.46            -0.1        1.46        perf-profile.calltrace.cycles-pp.zap_pmd_range.unmap_page_range.unmap_vmas.unmap_region.do_vmi_align_munmap
      0.73            -0.1        0.67            -0.1        0.67        perf-profile.calltrace.cycles-pp.mas_walk.find_vma_prev.copy_vma.move_vma.__do_sys_mremap
      1.15            -0.1        1.09            -0.1        1.09        perf-profile.calltrace.cycles-pp.___slab_alloc.kmem_cache_alloc_noprof.vm_area_dup.__split_vma.do_vmi_align_munmap
      0.60 ±  2%      -0.1        0.54            -0.1        0.54        perf-profile.calltrace.cycles-pp.security_mmap_addr.__get_unmapped_area.mremap_to.__do_sys_mremap.do_syscall_64
      1.27            -0.1        1.21            -0.1        1.21        perf-profile.calltrace.cycles-pp.mas_wr_store_entry.mas_store_gfp.do_vmi_align_munmap.do_vmi_munmap.move_vma
      0.72            -0.1        0.66            -0.1        0.65        perf-profile.calltrace.cycles-pp.mas_prev.vma_merge.copy_vma.move_vma.__do_sys_mremap
      0.70 ±  2%      -0.1        0.64 ±  3%      -0.1        0.64 ±  4%  perf-profile.calltrace.cycles-pp.mod_objcg_state.__memcg_slab_post_alloc_hook.kmem_cache_alloc_noprof.vm_area_dup.copy_vma
      0.79            -0.1        0.73            -0.1        0.73        perf-profile.calltrace.cycles-pp.___slab_alloc.kmem_cache_alloc_noprof.mas_alloc_nodes.mas_preallocate.__split_vma
      0.80 ±  2%      -0.1        0.75            -0.1        0.74 ±  2%  perf-profile.calltrace.cycles-pp.__call_rcu_common.mas_wr_node_store.mas_wr_store_entry.mas_store_prealloc.vma_merge
      0.78            -0.1        0.72            -0.1        0.72        perf-profile.calltrace.cycles-pp.___slab_alloc.kmem_cache_alloc_noprof.mas_alloc_nodes.mas_preallocate.vma_merge
      1.02            -0.1        0.96            -0.1        0.96        perf-profile.calltrace.cycles-pp.zap_pte_range.zap_pmd_range.unmap_page_range.unmap_vmas.unmap_region
      1.63            -0.1        1.58            -0.1        1.57        perf-profile.calltrace.cycles-pp.__get_unmapped_area.mremap_to.__do_sys_mremap.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.62            -0.0        0.58            -0.1        0.57        perf-profile.calltrace.cycles-pp.mas_prev_setup.mas_prev.vma_merge.copy_vma.move_vma
      0.60 ±  3%      -0.0        0.56 ±  3%      -0.0        0.57 ±  2%  perf-profile.calltrace.cycles-pp.__memcg_slab_free_hook.kmem_cache_free.vm_area_free_rcu_cb.rcu_do_batch.rcu_core
      0.86            -0.0        0.81            -0.0        0.81        perf-profile.calltrace.cycles-pp.mtree_load.vma_to_resize.mremap_to.__do_sys_mremap.do_syscall_64
      0.67            -0.0        0.62            -0.0        0.63        perf-profile.calltrace.cycles-pp.percpu_counter_add_batch.do_vmi_align_munmap.do_vmi_munmap.move_vma.__do_sys_mremap
      1.02            -0.0        0.97            -0.0        0.97        perf-profile.calltrace.cycles-pp.vma_to_resize.mremap_to.__do_sys_mremap.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.76 ±  2%      -0.0        0.71            -0.0        0.72 ±  2%  perf-profile.calltrace.cycles-pp.allocate_slab.___slab_alloc.kmem_cache_alloc_noprof.vm_area_dup.__split_vma
      0.70            -0.0        0.66            -0.0        0.66        perf-profile.calltrace.cycles-pp.__call_rcu_common.do_vmi_align_munmap.do_vmi_munmap.move_vma.__do_sys_mremap
      0.67 ±  2%      -0.0        0.63            -0.0        0.63        perf-profile.calltrace.cycles-pp.syscall_return_via_sysret.mremap
      0.81            -0.0        0.77            -0.0        0.77        perf-profile.calltrace.cycles-pp.mtree_load.__do_sys_mremap.do_syscall_64.entry_SYSCALL_64_after_hwframe.mremap
      0.56            -0.0        0.51            -0.1        0.44 ± 40%  perf-profile.calltrace.cycles-pp.mas_walk.mas_prev_setup.mas_prev.vma_merge.copy_vma
      0.98            -0.0        0.93            -0.0        0.93        perf-profile.calltrace.cycles-pp.mas_find.do_vmi_align_munmap.do_vmi_munmap.move_vma.__do_sys_mremap
      0.69            -0.0        0.65            -0.0        0.65        perf-profile.calltrace.cycles-pp.___slab_alloc.kmem_cache_alloc_noprof.vm_area_dup.copy_vma.move_vma
      0.78            -0.0        0.74            -0.0        0.74        perf-profile.calltrace.cycles-pp.mas_store_prealloc.vma_link.copy_vma.move_vma.__do_sys_mremap
      1.12            -0.0        1.08            -0.0        1.07        perf-profile.calltrace.cycles-pp.clear_bhb_loop.mremap
      0.68            -0.0        0.65            -0.0        0.65        perf-profile.calltrace.cycles-pp.mas_preallocate.vma_link.copy_vma.move_vma.__do_sys_mremap
      1.00            -0.0        0.97            -0.0        0.97        perf-profile.calltrace.cycles-pp.mt_find.vma_merge.copy_vma.move_vma.__do_sys_mremap
      0.62            -0.0        0.59            -0.0        0.59        perf-profile.calltrace.cycles-pp.mas_prev_slot.do_vmi_align_munmap.do_vmi_munmap.move_vma.__do_sys_mremap
      0.88            -0.0        0.85            -0.0        0.85        perf-profile.calltrace.cycles-pp.userfaultfd_unmap_complete.__do_sys_mremap.do_syscall_64.entry_SYSCALL_64_after_hwframe.mremap
      1.15            -0.0        1.12            -0.0        1.14        perf-profile.calltrace.cycles-pp.anon_vma_clone.copy_vma.move_vma.__do_sys_mremap.do_syscall_64
      0.60            -0.0        0.57 ±  2%      -0.0        0.57        perf-profile.calltrace.cycles-pp.__pte_offset_map_lock.zap_pte_range.zap_pmd_range.unmap_page_range.unmap_vmas
      0.59            -0.0        0.56            -0.0        0.55        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64.mremap
      0.62 ±  2%      -0.0        0.59 ±  2%      -0.0        0.58        perf-profile.calltrace.cycles-pp.get_old_pud.move_page_tables.move_vma.__do_sys_mremap.do_syscall_64
      0.65            -0.0        0.63            -0.0        0.62        perf-profile.calltrace.cycles-pp.mas_update_gap.mas_store_gfp.do_vmi_align_munmap.do_vmi_munmap.move_vma
      0.67            +0.1        0.74            +0.1        0.74        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__madvise
      0.76            +0.1        0.84            +0.1        0.83        perf-profile.calltrace.cycles-pp.__madvise
      0.66            +0.1        0.74            +0.1        0.74        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__madvise
      0.63            +0.1        0.71            +0.1        0.71        perf-profile.calltrace.cycles-pp.__x64_sys_madvise.do_syscall_64.entry_SYSCALL_64_after_hwframe.__madvise
      0.62            +0.1        0.70            +0.1        0.70        perf-profile.calltrace.cycles-pp.do_madvise.__x64_sys_madvise.do_syscall_64.entry_SYSCALL_64_after_hwframe.__madvise
      3.47            +0.1        3.55            +0.1        3.56        perf-profile.calltrace.cycles-pp.free_pgtables.unmap_region.do_vmi_align_munmap.do_vmi_munmap.move_vma
     87.67            +0.8       88.47            +0.6       88.26        perf-profile.calltrace.cycles-pp.mremap
      0.00            +0.9        0.86            +0.9        0.86        perf-profile.calltrace.cycles-pp.mas_walk.mas_find.can_modify_mm.do_vmi_munmap.do_munmap
      0.00            +0.9        0.88            +0.9        0.88        perf-profile.calltrace.cycles-pp.mas_walk.mas_find.can_modify_mm.mremap_to.__do_sys_mremap
      0.00            +0.9        0.90 ±  2%      +0.9        0.89        perf-profile.calltrace.cycles-pp.mas_walk.mas_find.can_modify_mm.do_vmi_munmap.move_vma
     84.82            +1.0       85.80            +0.8       85.60        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.mremap
     84.66            +1.0       85.65            +0.8       85.45        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.mremap
     83.71            +1.0       84.73            +0.8       84.55        perf-profile.calltrace.cycles-pp.__do_sys_mremap.do_syscall_64.entry_SYSCALL_64_after_hwframe.mremap
      0.00            +1.1        1.10            +1.1        1.10        perf-profile.calltrace.cycles-pp.mas_find.can_modify_mm.mremap_to.__do_sys_mremap.do_syscall_64
      0.00            +1.2        1.21            +1.2        1.22        perf-profile.calltrace.cycles-pp.mas_find.can_modify_mm.do_vmi_munmap.do_munmap.mremap_to
      2.09            +1.5        3.60            +1.5        3.60        perf-profile.calltrace.cycles-pp.do_munmap.mremap_to.__do_sys_mremap.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +1.5        1.51            +1.5        1.49        perf-profile.calltrace.cycles-pp.mas_find.can_modify_mm.do_vmi_munmap.move_vma.__do_sys_mremap
      1.59            +1.5        3.12            +1.5        3.13        perf-profile.calltrace.cycles-pp.do_vmi_munmap.do_munmap.mremap_to.__do_sys_mremap.do_syscall_64
      0.00            +1.6        1.62            +1.6        1.62        perf-profile.calltrace.cycles-pp.can_modify_mm.mremap_to.__do_sys_mremap.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +1.7        1.72            +1.7        1.73        perf-profile.calltrace.cycles-pp.can_modify_mm.do_vmi_munmap.do_munmap.mremap_to.__do_sys_mremap
      0.00            +2.0        2.01            +2.0        1.99        perf-profile.calltrace.cycles-pp.can_modify_mm.do_vmi_munmap.move_vma.__do_sys_mremap.do_syscall_64
      5.34            +3.0        8.38            +3.0        8.37        perf-profile.calltrace.cycles-pp.mremap_to.__do_sys_mremap.do_syscall_64.entry_SYSCALL_64_after_hwframe.mremap
     75.13            -1.9       73.22            -2.1       73.04        perf-profile.children.cycles-pp.move_vma
     37.01            -1.6       35.43            -1.6       35.38        perf-profile.children.cycles-pp.do_vmi_align_munmap
     25.06            -1.3       23.71            -1.4       23.65        perf-profile.children.cycles-pp.copy_vma
     20.00            -1.1       18.94            -1.1       18.91        perf-profile.children.cycles-pp.__split_vma
     19.86            -1.0       18.87            -1.0       18.89        perf-profile.children.cycles-pp.rcu_core
     19.84            -1.0       18.85            -1.0       18.87        perf-profile.children.cycles-pp.rcu_do_batch
     19.88            -1.0       18.89            -1.0       18.91        perf-profile.children.cycles-pp.handle_softirqs
     10.70 ±  3%      -0.9        9.84 ±  3%      -0.6       10.06 ±  2%  perf-profile.children.cycles-pp.kthread
     10.70 ±  3%      -0.9        9.84 ±  3%      -0.6       10.06 ±  2%  perf-profile.children.cycles-pp.ret_from_fork
     10.70 ±  3%      -0.9        9.84 ±  3%      -0.6       10.06 ±  2%  perf-profile.children.cycles-pp.ret_from_fork_asm
     10.64 ±  3%      -0.9        9.79 ±  3%      -0.6       10.02 ±  2%  perf-profile.children.cycles-pp.smpboot_thread_fn
     10.63 ±  3%      -0.9        9.78 ±  3%      -0.6       10.01 ±  2%  perf-profile.children.cycles-pp.run_ksoftirqd
     17.53            -0.8       16.70            -0.8       16.72        perf-profile.children.cycles-pp.kmem_cache_free
     15.28            -0.8       14.47            -0.8       14.48        perf-profile.children.cycles-pp.kmem_cache_alloc_noprof
     15.16            -0.8       14.37            -0.9       14.29        perf-profile.children.cycles-pp.vma_merge
     12.18            -0.6       11.54            -0.7       11.49        perf-profile.children.cycles-pp.mas_wr_store_entry
     11.98            -0.6       11.36            -0.7       11.30        perf-profile.children.cycles-pp.mas_store_prealloc
     12.11            -0.6       11.51            -0.6       11.51        perf-profile.children.cycles-pp.__slab_free
     10.86            -0.6       10.26            -0.6       10.30        perf-profile.children.cycles-pp.vm_area_dup
      9.89            -0.5        9.40            -0.6        9.33        perf-profile.children.cycles-pp.mas_wr_node_store
      8.36            -0.4        7.92            -0.4        7.91        perf-profile.children.cycles-pp.__memcg_slab_post_alloc_hook
      7.98            -0.4        7.58            -0.4        7.55        perf-profile.children.cycles-pp.move_page_tables
      6.69            -0.4        6.33            -0.4        6.32        perf-profile.children.cycles-pp.vma_complete
      5.86            -0.3        5.56            -0.3        5.53        perf-profile.children.cycles-pp.move_ptes
      5.11            -0.3        4.81            -0.3        4.80        perf-profile.children.cycles-pp.mas_preallocate
      6.05            -0.3        5.75            -0.3        5.76        perf-profile.children.cycles-pp.vm_area_free_rcu_cb
      2.98 ±  2%      -0.3        2.73 ±  4%      -0.2        2.75 ±  2%  perf-profile.children.cycles-pp.__memcpy
      3.48            -0.2        3.26            -0.2        3.27        perf-profile.children.cycles-pp.___slab_alloc
      3.46 ±  2%      -0.2        3.26            -0.2        3.27 ±  2%  perf-profile.children.cycles-pp.mod_objcg_state
      2.91            -0.2        2.73            -0.2        2.73        perf-profile.children.cycles-pp.mas_alloc_nodes
      2.43            -0.2        2.25            -0.2        2.25        perf-profile.children.cycles-pp.find_vma_prev
      3.47            -0.2        3.29            -0.2        3.23 ±  2%  perf-profile.children.cycles-pp.down_write
      3.46            -0.2        3.28            -0.2        3.27        perf-profile.children.cycles-pp.flush_tlb_mm_range
      4.22            -0.2        4.06            -0.2        4.05        perf-profile.children.cycles-pp.anon_vma_clone
      3.32            -0.2        3.17            -0.1        3.18        perf-profile.children.cycles-pp.__memcg_slab_free_hook
      3.35            -0.2        3.20            -0.2        3.20        perf-profile.children.cycles-pp.mas_store_gfp
      2.22            -0.1        2.07            -0.1        2.07        perf-profile.children.cycles-pp.__cond_resched
      3.18            -0.1        3.04            -0.1        3.05        perf-profile.children.cycles-pp.unmap_vmas
      2.05 ±  2%      -0.1        1.91            -0.1        1.93 ±  2%  perf-profile.children.cycles-pp.allocate_slab
      2.24            -0.1        2.11 ±  2%      -0.2        2.08 ±  2%  perf-profile.children.cycles-pp.vma_prepare
      2.12            -0.1        2.00            -0.1        2.00        perf-profile.children.cycles-pp.__call_rcu_common
      2.66            -0.1        2.53            -0.1        2.54        perf-profile.children.cycles-pp.mtree_load
      2.46            -0.1        2.34            -0.1        2.34        perf-profile.children.cycles-pp.rcu_cblist_dequeue
      2.49            -0.1        2.38            -0.1        2.38        perf-profile.children.cycles-pp.flush_tlb_func
      8.32            -0.1        8.21            -0.1        8.22        perf-profile.children.cycles-pp.unmap_region
      2.48            -0.1        2.37            -0.1        2.37        perf-profile.children.cycles-pp.unmap_page_range
      2.23            -0.1        2.13            -0.1        2.13        perf-profile.children.cycles-pp.native_flush_tlb_one_user
      1.77            -0.1        1.67            -0.1        1.67        perf-profile.children.cycles-pp.mas_wr_walk
      1.88            -0.1        1.78            -0.1        1.78        perf-profile.children.cycles-pp.vma_link
      1.40            -0.1        1.31            -0.1        1.31        perf-profile.children.cycles-pp.shuffle_freelist
      1.84            -0.1        1.75            -0.1        1.76 ±  2%  perf-profile.children.cycles-pp.up_write
      0.97 ±  2%      -0.1        0.88            -0.1        0.88        perf-profile.children.cycles-pp.rcu_all_qs
      1.03            -0.1        0.95            -0.1        0.95        perf-profile.children.cycles-pp.mas_prev
      0.92            -0.1        0.85            -0.1        0.84        perf-profile.children.cycles-pp.mas_prev_setup
      1.58            -0.1        1.50            -0.1        1.50        perf-profile.children.cycles-pp.zap_pmd_range
      1.24            -0.1        1.17            -0.1        1.16        perf-profile.children.cycles-pp.mas_prev_slot
      1.58            -0.1        1.51            -0.1        1.51        perf-profile.children.cycles-pp.mas_update_gap
      0.62            -0.1        0.56            -0.1        0.56        perf-profile.children.cycles-pp.security_mmap_addr
      0.49 ±  2%      -0.1        0.43            -0.1        0.44 ±  2%  perf-profile.children.cycles-pp.setup_object
      0.90            -0.1        0.84            -0.1        0.85        perf-profile.children.cycles-pp.percpu_counter_add_batch
      0.98            -0.1        0.92            -0.1        0.93        perf-profile.children.cycles-pp.mas_pop_node
      0.85            -0.1        0.80            -0.1        0.79        perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      1.68            -0.1        1.62            -0.1        1.61        perf-profile.children.cycles-pp.__get_unmapped_area
      1.23            -0.1        1.18            -0.1        1.17        perf-profile.children.cycles-pp.__pte_offset_map_lock
      1.08            -0.1        1.03            -0.1        1.03        perf-profile.children.cycles-pp.zap_pte_range
      0.69 ±  2%      -0.0        0.64            -0.0        0.65        perf-profile.children.cycles-pp.syscall_return_via_sysret
      1.04            -0.0        1.00            -0.1        0.99        perf-profile.children.cycles-pp.vma_to_resize
      1.08            -0.0        1.04            -0.0        1.04        perf-profile.children.cycles-pp.mas_leaf_max_gap
      0.51 ±  3%      -0.0        0.47            -0.0        0.49 ±  4%  perf-profile.children.cycles-pp.anon_vma_interval_tree_insert
      1.18            -0.0        1.14            -0.1        1.13        perf-profile.children.cycles-pp.clear_bhb_loop
      0.57            -0.0        0.53            -0.0        0.53        perf-profile.children.cycles-pp.mas_wr_end_piv
      0.43            -0.0        0.40            -0.0        0.39        perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
      1.14            -0.0        1.10            -0.0        1.10        perf-profile.children.cycles-pp.mt_find
      0.46 ±  7%      -0.0        0.42 ±  2%      -0.0        0.42        perf-profile.children.cycles-pp._raw_spin_lock
      0.62            -0.0        0.58            -0.0        0.59        perf-profile.children.cycles-pp.__put_partials
      0.90            -0.0        0.87            -0.0        0.87        perf-profile.children.cycles-pp.userfaultfd_unmap_complete
      0.46 ±  3%      -0.0        0.42 ±  3%      -0.0        0.42 ±  3%  perf-profile.children.cycles-pp.__alloc_pages_noprof
      0.61            -0.0        0.58            -0.0        0.58        perf-profile.children.cycles-pp.entry_SYSCALL_64
      0.48            -0.0        0.45 ±  2%      -0.0        0.45        perf-profile.children.cycles-pp.mas_prev_range
      0.64            -0.0        0.61            -0.0        0.60        perf-profile.children.cycles-pp.get_old_pud
      0.31 ±  2%      -0.0        0.28 ±  3%      -0.0        0.28 ±  3%  perf-profile.children.cycles-pp.security_vm_enough_memory_mm
      0.33 ±  3%      -0.0        0.30 ±  2%      -0.0        0.30 ±  3%  perf-profile.children.cycles-pp.mas_put_in_tree
      0.32 ±  2%      -0.0        0.29 ±  2%      -0.0        0.30 ±  2%  perf-profile.children.cycles-pp.tlb_finish_mmu
      0.47            -0.0        0.44 ±  2%      -0.0        0.44        perf-profile.children.cycles-pp.rcu_segcblist_enqueue
      0.33            -0.0        0.31            -0.0        0.32        perf-profile.children.cycles-pp.mas_destroy
      0.40            -0.0        0.39            -0.0        0.38        perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.35            -0.0        0.34            -0.0        0.33        perf-profile.children.cycles-pp.__rb_insert_augmented
      0.25 ±  4%      -0.0        0.23 ±  3%      -0.0        0.23 ±  3%  perf-profile.children.cycles-pp.rmqueue
      0.39            -0.0        0.37            -0.0        0.37        perf-profile.children.cycles-pp.down_write_killable
      0.18 ±  3%      -0.0        0.17 ±  5%      -0.0        0.16 ±  5%  perf-profile.children.cycles-pp.cap_vm_enough_memory
      0.22 ±  4%      -0.0        0.20 ±  3%      -0.0        0.20 ±  3%  perf-profile.children.cycles-pp.__rmqueue_pcplist
      0.21 ±  4%      -0.0        0.19 ±  3%      -0.0        0.19 ±  3%  perf-profile.children.cycles-pp.rmqueue_bulk
      0.52            -0.0        0.51 ±  2%      -0.0        0.50        perf-profile.children.cycles-pp.__pte_offset_map
      0.26            -0.0        0.24 ±  2%      -0.0        0.24 ±  2%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      0.30 ±  2%      -0.0        0.28 ±  2%      -0.0        0.28 ±  3%  perf-profile.children.cycles-pp.__vm_enough_memory
      0.29            -0.0        0.27            -0.0        0.27 ±  3%  perf-profile.children.cycles-pp.tlb_gather_mmu
      0.16 ±  2%      -0.0        0.14 ±  3%      -0.0        0.14 ±  4%  perf-profile.children.cycles-pp.mas_wr_append
      0.28 ±  2%      -0.0        0.26            -0.0        0.26        perf-profile.children.cycles-pp.khugepaged_enter_vma
      0.32            -0.0        0.30            -0.0        0.30        perf-profile.children.cycles-pp.mas_wr_store_setup
      0.20 ±  2%      -0.0        0.18 ±  2%      -0.0        0.18 ±  2%  perf-profile.children.cycles-pp.__thp_vma_allowable_orders
      0.32            -0.0        0.30            -0.0        0.30 ±  2%  perf-profile.children.cycles-pp.pte_offset_map_nolock
      0.09 ±  4%      -0.0        0.08 ±  5%      -0.0        0.07 ±  6%  perf-profile.children.cycles-pp.vma_dup_policy
      0.36            -0.0        0.35            -0.0        0.35        perf-profile.children.cycles-pp.madvise_vma_behavior
      0.16 ±  3%      -0.0        0.16 ±  2%      -0.0        0.15 ±  3%  perf-profile.children.cycles-pp._find_next_bit
      0.14 ±  3%      +0.0        0.15 ±  2%      +0.0        0.15        perf-profile.children.cycles-pp.free_pgd_range
      0.08 ±  4%      +0.0        0.10 ±  4%      +0.0        0.10 ±  4%  perf-profile.children.cycles-pp.mm_get_unmapped_area_vmflags
      0.78            +0.1        0.85            +0.1        0.85        perf-profile.children.cycles-pp.__madvise
      0.63            +0.1        0.71            +0.1        0.71        perf-profile.children.cycles-pp.__x64_sys_madvise
      0.63            +0.1        0.70            +0.1        0.70        perf-profile.children.cycles-pp.do_madvise
      3.52            +0.1        3.60            +0.1        3.61        perf-profile.children.cycles-pp.free_pgtables
      0.00            +0.1        0.09            +0.1        0.09 ±  4%  perf-profile.children.cycles-pp.can_modify_mm_madv
      1.30            +0.2        1.46            +0.2        1.46        perf-profile.children.cycles-pp.mas_next_slot
     88.06            +0.8       88.84            +0.6       88.64        perf-profile.children.cycles-pp.mremap
     83.81            +1.0       84.84            +0.8       84.65        perf-profile.children.cycles-pp.__do_sys_mremap
     85.98            +1.0       87.02            +0.8       86.82        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     85.50            +1.1       86.56            +0.9       86.36        perf-profile.children.cycles-pp.do_syscall_64
      2.12            +1.5        3.62            +1.5        3.63        perf-profile.children.cycles-pp.do_munmap
     40.41            +1.5       41.93            +1.5       41.86        perf-profile.children.cycles-pp.do_vmi_munmap
      3.62            +2.4        5.98            +2.3        5.95        perf-profile.children.cycles-pp.mas_walk
      5.40            +3.0        8.44            +3.0        8.43        perf-profile.children.cycles-pp.mremap_to
      5.26            +3.2        8.48            +3.2        8.47        perf-profile.children.cycles-pp.mas_find
      0.00            +5.5        5.46            +5.4        5.45        perf-profile.children.cycles-pp.can_modify_mm
     11.49            -0.6       10.92            -0.6       10.93        perf-profile.self.cycles-pp.__slab_free
      4.32            -0.2        4.07            -0.3        3.98 ±  2%  perf-profile.self.cycles-pp.__memcg_slab_post_alloc_hook
      1.96            -0.2        1.80 ±  4%      -0.1        1.83 ±  2%  perf-profile.self.cycles-pp.__memcpy
      2.36 ±  2%      -0.1        2.24 ±  2%      -0.2        2.19 ±  2%  perf-profile.self.cycles-pp.down_write
      2.42            -0.1        2.30            -0.1        2.32        perf-profile.self.cycles-pp.rcu_cblist_dequeue
      2.33            -0.1        2.22            -0.1        2.23        perf-profile.self.cycles-pp.mtree_load
      2.21            -0.1        2.10            -0.1        2.10        perf-profile.self.cycles-pp.native_flush_tlb_one_user
      1.62            -0.1        1.54            -0.1        1.55 ±  2%  perf-profile.self.cycles-pp.__memcg_slab_free_hook
      1.52            -0.1        1.44            -0.1        1.44        perf-profile.self.cycles-pp.mas_wr_walk
      1.15 ±  2%      -0.1        1.07            -0.1        1.08        perf-profile.self.cycles-pp.shuffle_freelist
      1.53            -0.1        1.45            -0.1        1.47 ±  2%  perf-profile.self.cycles-pp.up_write
      1.44            -0.1        1.36            -0.1        1.36        perf-profile.self.cycles-pp.__call_rcu_common
      0.70 ±  2%      -0.1        0.62            -0.1        0.63        perf-profile.self.cycles-pp.rcu_all_qs
      1.72            -0.1        1.66            -0.1        1.66        perf-profile.self.cycles-pp.mod_objcg_state
      3.77            -0.1        3.70 ±  4%      -0.2        3.62 ±  2%  perf-profile.self.cycles-pp.mas_wr_node_store
      0.51 ±  3%      -0.1        0.45            -0.1        0.45        perf-profile.self.cycles-pp.security_mmap_addr
      0.94 ±  2%      -0.1        0.88 ±  4%      -0.1        0.88 ±  2%  perf-profile.self.cycles-pp.vm_area_dup
      1.18            -0.1        1.12            -0.1        1.12        perf-profile.self.cycles-pp.vma_merge
      1.38            -0.1        1.33            -0.1        1.32        perf-profile.self.cycles-pp.do_vmi_align_munmap
      0.89            -0.1        0.83            -0.1        0.83        perf-profile.self.cycles-pp.___slab_alloc
      0.62            -0.1        0.56 ±  2%      -0.1        0.56 ±  2%  perf-profile.self.cycles-pp.mremap
      1.00            -0.1        0.95            -0.1        0.95        perf-profile.self.cycles-pp.mas_preallocate
      0.98            -0.1        0.93            -0.0        0.93        perf-profile.self.cycles-pp.move_ptes
      0.99            -0.1        0.94            -0.1        0.93        perf-profile.self.cycles-pp.mas_prev_slot
      1.09            -0.0        1.04 ±  2%      -0.0        1.05        perf-profile.self.cycles-pp.__cond_resched
      0.94            -0.0        0.90            -0.1        0.89        perf-profile.self.cycles-pp.vm_area_free_rcu_cb
      0.85            -0.0        0.80            -0.0        0.81        perf-profile.self.cycles-pp.mas_pop_node
      0.77            -0.0        0.72            -0.0        0.73        perf-profile.self.cycles-pp.percpu_counter_add_batch
      0.68            -0.0        0.63            -0.0        0.64        perf-profile.self.cycles-pp.__split_vma
      1.17            -0.0        1.13            -0.1        1.12        perf-profile.self.cycles-pp.clear_bhb_loop
      0.95            -0.0        0.91            -0.0        0.91        perf-profile.self.cycles-pp.mas_leaf_max_gap
      0.79            -0.0        0.75            -0.0        0.76        perf-profile.self.cycles-pp.mas_wr_store_entry
      0.44            -0.0        0.40            -0.0        0.40        perf-profile.self.cycles-pp.do_munmap
      1.22            -0.0        1.18            -0.0        1.19        perf-profile.self.cycles-pp.move_vma
      0.89            -0.0        0.86            -0.0        0.86        perf-profile.self.cycles-pp.mas_store_gfp
      0.45            -0.0        0.42            -0.0        0.42        perf-profile.self.cycles-pp.mas_wr_end_piv
      0.43 ±  2%      -0.0        0.40            -0.0        0.39        perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
      0.78            -0.0        0.75            -0.0        0.76        perf-profile.self.cycles-pp.userfaultfd_unmap_complete
      0.66            -0.0        0.63            -0.0        0.63        perf-profile.self.cycles-pp.mas_store_prealloc
      1.49            -0.0        1.46            -0.0        1.45        perf-profile.self.cycles-pp.kmem_cache_free
      0.60            -0.0        0.58            -0.0        0.58        perf-profile.self.cycles-pp.unmap_region
      0.86            -0.0        0.83            -0.0        0.83        perf-profile.self.cycles-pp.move_page_tables
      0.43 ±  4%      -0.0        0.40            -0.0        0.42 ±  4%  perf-profile.self.cycles-pp.anon_vma_interval_tree_insert
      0.99            -0.0        0.97            -0.0        0.97        perf-profile.self.cycles-pp.mt_find
      0.36 ±  3%      -0.0        0.33 ±  2%      -0.0        0.33 ±  2%  perf-profile.self.cycles-pp.syscall_return_via_sysret
      0.71            -0.0        0.68            -0.0        0.68        perf-profile.self.cycles-pp.unmap_page_range
      0.55            -0.0        0.52            -0.0        0.51        perf-profile.self.cycles-pp.get_old_pud
      0.49            -0.0        0.47            -0.0        0.47        perf-profile.self.cycles-pp.find_vma_prev
      0.27            -0.0        0.25            -0.0        0.25 ±  2%  perf-profile.self.cycles-pp.mas_prev_setup
      0.41            -0.0        0.39            -0.0        0.39        perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.61            -0.0        0.58            -0.0        0.58        perf-profile.self.cycles-pp.copy_vma
      0.47            -0.0        0.45 ±  2%      -0.0        0.45        perf-profile.self.cycles-pp.flush_tlb_mm_range
      0.37 ±  6%      -0.0        0.35 ±  2%      -0.0        0.35        perf-profile.self.cycles-pp._raw_spin_lock
      0.42 ±  2%      -0.0        0.40 ±  2%      -0.0        0.40        perf-profile.self.cycles-pp.rcu_segcblist_enqueue
      0.27            -0.0        0.25 ±  2%      -0.0        0.25 ±  2%  perf-profile.self.cycles-pp.mas_put_in_tree
      0.39            -0.0        0.37            -0.0        0.37        perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.44            -0.0        0.42            -0.0        0.42        perf-profile.self.cycles-pp.mas_update_gap
      0.49            -0.0        0.47            -0.0        0.48 ±  2%  perf-profile.self.cycles-pp.refill_obj_stock
      0.27 ±  2%      -0.0        0.25 ±  2%      -0.0        0.25        perf-profile.self.cycles-pp.tlb_finish_mmu
      0.34            -0.0        0.32            -0.0        0.32 ±  2%  perf-profile.self.cycles-pp.zap_pmd_range
      0.48            -0.0        0.46            -0.0        0.46        perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.28            -0.0        0.26            -0.0        0.26        perf-profile.self.cycles-pp.mas_alloc_nodes
      0.24 ±  2%      -0.0        0.22            -0.0        0.22        perf-profile.self.cycles-pp.mas_prev
      0.14 ±  3%      -0.0        0.12 ±  2%      -0.0        0.12 ±  2%  perf-profile.self.cycles-pp.syscall_exit_to_user_mode
      0.26            -0.0        0.24            -0.0        0.24        perf-profile.self.cycles-pp.__rb_insert_augmented
      0.40            -0.0        0.39            -0.0        0.39        perf-profile.self.cycles-pp.__pte_offset_map_lock
      0.28            -0.0        0.26 ±  3%      -0.0        0.26        perf-profile.self.cycles-pp.mas_prev_range
      0.33 ±  2%      -0.0        0.32            -0.0        0.31        perf-profile.self.cycles-pp.zap_pte_range
      0.28            -0.0        0.26            -0.0        0.26        perf-profile.self.cycles-pp.flush_tlb_func
      0.44            -0.0        0.42 ±  2%      -0.0        0.42        perf-profile.self.cycles-pp.__pte_offset_map
      0.22            -0.0        0.21 ±  2%      -0.0        0.21 ±  2%  perf-profile.self.cycles-pp.entry_SYSCALL_64
      0.17            -0.0        0.16            -0.0        0.16        perf-profile.self.cycles-pp.__thp_vma_allowable_orders
      0.10            -0.0        0.09            -0.0        0.09 ±  3%  perf-profile.self.cycles-pp.mod_node_page_state
      0.06            -0.0        0.05            -0.0        0.05        perf-profile.self.cycles-pp.vma_dup_policy
      0.06 ±  5%      +0.0        0.07            +0.0        0.07 ±  4%  perf-profile.self.cycles-pp.mm_get_unmapped_area_vmflags
      0.11 ±  4%      +0.0        0.12 ±  4%      +0.0        0.12 ±  2%  perf-profile.self.cycles-pp.free_pgd_range
      0.21            +0.0        0.22 ±  2%      +0.0        0.22        perf-profile.self.cycles-pp.thp_get_unmapped_area_vmflags
      0.45            +0.0        0.48            +0.0        0.48        perf-profile.self.cycles-pp.do_vmi_munmap
      0.27            +0.0        0.32            +0.0        0.31        perf-profile.self.cycles-pp.free_pgtables
      0.36 ±  2%      +0.1        0.44            +0.1        0.45        perf-profile.self.cycles-pp.unlink_anon_vmas
      1.06            +0.1        1.19            +0.1        1.19        perf-profile.self.cycles-pp.mas_next_slot
      1.49            +0.5        2.01            +0.5        2.02        perf-profile.self.cycles-pp.mas_find
      0.00            +1.4        1.38            +1.4        1.38        perf-profile.self.cycles-pp.can_modify_mm
      3.15            +2.1        5.23            +2.1        5.22        perf-profile.self.cycles-pp.mas_walk

> 
>                 Linus

>  arch/powerpc/include/asm/mmu_context.h |  9 ---------
>  arch/powerpc/kernel/vdso.c             | 17 +++++++++++++++--
>  arch/x86/include/asm/mmu_context.h     |  5 -----
>  include/asm-generic/mm_hooks.h         | 11 +++--------
>  include/linux/mm_types.h               |  2 ++
>  mm/mmap.c                              | 15 ++++++---------
>  6 files changed, 26 insertions(+), 33 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/mmu_context.h b/arch/powerpc/include/asm/mmu_context.h
> index 37bffa0f7918..a334a1368848 100644
> --- a/arch/powerpc/include/asm/mmu_context.h
> +++ b/arch/powerpc/include/asm/mmu_context.h
> @@ -260,15 +260,6 @@ static inline void enter_lazy_tlb(struct mm_struct *mm,
>  
>  extern void arch_exit_mmap(struct mm_struct *mm);
>  
> -static inline void arch_unmap(struct mm_struct *mm,
> -			      unsigned long start, unsigned long end)
> -{
> -	unsigned long vdso_base = (unsigned long)mm->context.vdso;
> -
> -	if (start <= vdso_base && vdso_base < end)
> -		mm->context.vdso = NULL;
> -}
> -
>  #ifdef CONFIG_PPC_MEM_KEYS
>  bool arch_vma_access_permitted(struct vm_area_struct *vma, bool write,
>  			       bool execute, bool foreign);
> diff --git a/arch/powerpc/kernel/vdso.c b/arch/powerpc/kernel/vdso.c
> index 7a2ff9010f17..6fa041a6690a 100644
> --- a/arch/powerpc/kernel/vdso.c
> +++ b/arch/powerpc/kernel/vdso.c
> @@ -81,6 +81,13 @@ static int vdso64_mremap(const struct vm_special_mapping *sm, struct vm_area_str
>  	return vdso_mremap(sm, new_vma, &vdso64_end - &vdso64_start);
>  }
>  
> +static int vvar_close(const struct vm_special_mapping *sm,
> +		      struct vm_area_struct *vma)
> +{
> +	struct mm_struct *mm = vma->vm_mm;
> +	mm->context.vdso = NULL;
> +}
> +
>  static vm_fault_t vvar_fault(const struct vm_special_mapping *sm,
>  			     struct vm_area_struct *vma, struct vm_fault *vmf);
>  
> @@ -92,11 +99,13 @@ static struct vm_special_mapping vvar_spec __ro_after_init = {
>  static struct vm_special_mapping vdso32_spec __ro_after_init = {
>  	.name = "[vdso]",
>  	.mremap = vdso32_mremap,
> +	.close = vvar_close,
>  };
>  
>  static struct vm_special_mapping vdso64_spec __ro_after_init = {
>  	.name = "[vdso]",
>  	.mremap = vdso64_mremap,
> +	.close = vvar_close,
>  };
>  
>  #ifdef CONFIG_TIME_NS
> @@ -207,8 +216,10 @@ static int __arch_setup_additional_pages(struct linux_binprm *bprm, int uses_int
>  	vma = _install_special_mapping(mm, vdso_base, vvar_size,
>  				       VM_READ | VM_MAYREAD | VM_IO |
>  				       VM_DONTDUMP | VM_PFNMAP, &vvar_spec);
> -	if (IS_ERR(vma))
> +	if (IS_ERR(vma)) {
> +		mm->context.vdso = NULL;
>  		return PTR_ERR(vma);
> +	}
>  
>  	/*
>  	 * our vma flags don't have VM_WRITE so by default, the process isn't
> @@ -223,8 +234,10 @@ static int __arch_setup_additional_pages(struct linux_binprm *bprm, int uses_int
>  	vma = _install_special_mapping(mm, vdso_base + vvar_size, vdso_size,
>  				       VM_READ | VM_EXEC | VM_MAYREAD |
>  				       VM_MAYWRITE | VM_MAYEXEC, vdso_spec);
> -	if (IS_ERR(vma))
> +	if (IS_ERR(vma)) {
> +		mm->context.vdso = NULL;
>  		do_munmap(mm, vdso_base, vvar_size, NULL);
> +	}
>  
>  	return PTR_ERR_OR_ZERO(vma);
>  }
> diff --git a/arch/x86/include/asm/mmu_context.h b/arch/x86/include/asm/mmu_context.h
> index 8dac45a2c7fc..80f2a3187aa6 100644
> --- a/arch/x86/include/asm/mmu_context.h
> +++ b/arch/x86/include/asm/mmu_context.h
> @@ -232,11 +232,6 @@ static inline bool is_64bit_mm(struct mm_struct *mm)
>  }
>  #endif
>  
> -static inline void arch_unmap(struct mm_struct *mm, unsigned long start,
> -			      unsigned long end)
> -{
> -}
> -
>  /*
>   * We only want to enforce protection keys on the current process
>   * because we effectively have no access to PKRU for other
> diff --git a/include/asm-generic/mm_hooks.h b/include/asm-generic/mm_hooks.h
> index 4dbb177d1150..6eea3b3c1e65 100644
> --- a/include/asm-generic/mm_hooks.h
> +++ b/include/asm-generic/mm_hooks.h
> @@ -1,8 +1,8 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
>  /*
> - * Define generic no-op hooks for arch_dup_mmap, arch_exit_mmap
> - * and arch_unmap to be included in asm-FOO/mmu_context.h for any
> - * arch FOO which doesn't need to hook these.
> + * Define generic no-op hooks for arch_dup_mmap and arch_exit_mmap
> + * to be included in asm-FOO/mmu_context.h for any arch FOO which
> + * doesn't need to hook these.
>   */
>  #ifndef _ASM_GENERIC_MM_HOOKS_H
>  #define _ASM_GENERIC_MM_HOOKS_H
> @@ -17,11 +17,6 @@ static inline void arch_exit_mmap(struct mm_struct *mm)
>  {
>  }
>  
> -static inline void arch_unmap(struct mm_struct *mm,
> -			unsigned long start, unsigned long end)
> -{
> -}
> -
>  static inline bool arch_vma_access_permitted(struct vm_area_struct *vma,
>  		bool write, bool execute, bool foreign)
>  {
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 485424979254..ef32d87a3adc 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -1313,6 +1313,8 @@ struct vm_special_mapping {
>  
>  	int (*mremap)(const struct vm_special_mapping *sm,
>  		     struct vm_area_struct *new_vma);
> +	void (*close)(const struct vm_special_mapping *sm,
> +		      struct vm_area_struct *vma);
>  };
>  
>  enum tlb_flush_reason {
> diff --git a/mm/mmap.c b/mm/mmap.c
> index d0dfc85b209b..adaaf1ef197a 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -2789,7 +2789,7 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
>   *
>   * This function takes a @mas that is either pointing to the previous VMA or set
>   * to MA_START and sets it up to remove the mapping(s).  The @len will be
> - * aligned and any arch_unmap work will be preformed.
> + * aligned.
>   *
>   * Return: 0 on success and drops the lock if so directed, error and leaves the
>   * lock held otherwise.
> @@ -2809,16 +2809,12 @@ int do_vmi_munmap(struct vma_iterator *vmi, struct mm_struct *mm,
>  		return -EINVAL;
>  
>  	/*
> -	 * Check if memory is sealed before arch_unmap.
> -	 * Prevent unmapping a sealed VMA.
> +	 * Check if memory is sealed, prevent unmapping a sealed VMA.
>  	 * can_modify_mm assumes we have acquired the lock on MM.
>  	 */
>  	if (unlikely(!can_modify_mm(mm, start, end)))
>  		return -EPERM;
>  
> -	 /* arch_unmap() might do unmaps itself.  */
> -	arch_unmap(mm, start, end);
> -
>  	/* Find the first overlapping VMA */
>  	vma = vma_find(vmi, end);
>  	if (!vma) {
> @@ -3232,14 +3228,12 @@ int do_vma_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
>  	struct mm_struct *mm = vma->vm_mm;
>  
>  	/*
> -	 * Check if memory is sealed before arch_unmap.
> -	 * Prevent unmapping a sealed VMA.
> +	 * Check if memory is sealed, prevent unmapping a sealed VMA.
>  	 * can_modify_mm assumes we have acquired the lock on MM.
>  	 */
>  	if (unlikely(!can_modify_mm(mm, start, end)))
>  		return -EPERM;
>  
> -	arch_unmap(mm, start, end);
>  	return do_vmi_align_munmap(vmi, vma, mm, start, end, uf, unlock);
>  }
>  
> @@ -3624,6 +3618,9 @@ static vm_fault_t special_mapping_fault(struct vm_fault *vmf);
>   */
>  static void special_mapping_close(struct vm_area_struct *vma)
>  {
> +	const struct vm_special_mapping *sm = vma->vm_private_data;
> +	if (sm->close)
> +		sm->close(sm, vma);
>  }
>  
>  static const char *special_mapping_name(struct vm_area_struct *vma)



Return-Path: <linux-api+bounces-2107-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 50A01946DB4
	for <lists+linux-api@lfdr.de>; Sun,  4 Aug 2024 10:59:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A91F81F20F36
	for <lists+linux-api@lfdr.de>; Sun,  4 Aug 2024 08:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D3E5200C7;
	Sun,  4 Aug 2024 08:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FR+0/S7l"
X-Original-To: linux-api@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F545210E7;
	Sun,  4 Aug 2024 08:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722761991; cv=fail; b=bqAd4BBSuhZvVZ9Bf8wM6GlgrY0u4TQe6PndpXShjr95LhsHaap9jTjSksg9Seyu2T3RAkGrzPDuLGum7jnnbjO4AOx3Byq2XbbbYSub0ez0deMuX26vXN3iqdwptib3/DEbsnG17esYLM+pfEFeKzS453/tC1o7uNI2BFjLjiM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722761991; c=relaxed/simple;
	bh=RflbGY0V/dyw5jlK9+37jKuUzrr55Gl1pAflbZa3lR8=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=XtWsPg5mnI/QSXF+So64r60r023TEIomOY2hYT/Dqwq0rLsPvthGUXlhDhLkplmmuLM2qIJiQoHwVpVqf0vsVoVwn1zpL7guZU4ISO/68MnF89mFhji4P7owu1809hrZakG3Srx5zJKhcnvarOolRCyC/Aa3CbUunOMBcXBy7Zs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FR+0/S7l; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722761987; x=1754297987;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=RflbGY0V/dyw5jlK9+37jKuUzrr55Gl1pAflbZa3lR8=;
  b=FR+0/S7lgJup0rVaruWsGYyHrX1XWA137usxKxc18unA5d+1z4EkK8v3
   XBgblHU6T8KANUjeXSoo0fQLEdORziexQ28UR8yQfE/O/+o2Z+puNnTjY
   aPiCvCObIxUfohRmHrv/NXzL4B+MNxDHD8Gsb8mHyC4HZzVlKytlAyoFB
   xDfuuikrDJFKJLtKazPHMYji8tc7uBhz4V60cVP0OL5Cy9IPTBeQYiDC5
   QKG3HEe00cn/F/uSUd9eBNj9kmv5MIkGqybWq9rrPFwhbTgGjrCwbO/ny
   7XI5JtYDL06TNiPxTr1TgNWNNK3uHmcav/EsCq+6yItDe/VMzbxp8fuFp
   w==;
X-CSE-ConnectionGUID: cHFenqWJT8i61Xg2xcH3mw==
X-CSE-MsgGUID: cquMCtfvS9+a4aOSJhOv8g==
X-IronPort-AV: E=McAfee;i="6700,10204,11153"; a="24604441"
X-IronPort-AV: E=Sophos;i="6.09,262,1716274800"; 
   d="scan'208";a="24604441"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2024 01:59:46 -0700
X-CSE-ConnectionGUID: 2TYD1t1tSx6i7GGt5m05iw==
X-CSE-MsgGUID: ss1xbmCDRLGd/q3xi1SgWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,262,1716274800"; 
   d="scan'208";a="60864934"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Aug 2024 01:59:46 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 4 Aug 2024 01:59:45 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 4 Aug 2024 01:59:45 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 4 Aug 2024 01:59:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wrrh7zHGRSrPidgomc/67/LLla5GQ/jXrmJE3k6FclW5ywn4SwSmpexkhbkzwKVF3Rm6Gbu8eLCJpqNC9gIOMrQkM4Mc2kIU0dzJALyXCoB53B/HoaDbmPBaxOjUCaMA/0CZcp8EZ765Mqcu1V6RxoMDJmSBW+QQMA7gjzK2QxcyCoAYN4gpEnUcBd4eZlctiDwr5SByfifZJY9aaT95UlVJDA7yKdETCnbtaG4FBAZ6TcVvXXytEEpLP8EDSjMc2PNQxfQAUkcbYXwClfp9PB/v5h1d6JDjMLhiIVcYKnSx2rD0UI2SWY3MwxlQ3JTAES/fusrb37u0v+upzMoSag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nfoziPe1hmCr+/IJ+C08RfFLQH5noRRKk2rJTU8BNDY=;
 b=kQIAw/XZsT0OWL7cDZW/I1JA3e/GiKo/zmXox/3ZG4xM3K0hBOP5ebJ3nl6pxBcrBDmAFnckoE+dlkg0UJJDIp5cFYy5dfwDpEqZQQcMsrhVFHaa+XcnrzaLEHeMPA4ALzo5+Hqrv0zvyVE74pvVClssGYYqznSp7WzvTf0cWEV4cAroBIE84lzIqimxwWkVpkKyA9/oIokyg0Elh2IkmfFik6h4S6ShVqVFTCng5Lhhk8RhG7d5hqiqc+MeqSJfDw7nXGlpc998om7AS1h7Nkrz1xsnt09Doouo1HmjNEpW6bYvGxW5JiIRbuFex0ygvzS8n9PxmhetvIPG9gH3zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by CH3PR11MB7868.namprd11.prod.outlook.com (2603:10b6:610:12e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.25; Sun, 4 Aug
 2024 08:59:42 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.7828.023; Sun, 4 Aug 2024
 08:59:42 +0000
Date: Sun, 4 Aug 2024 16:59:20 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Jeff Xu <jeffxu@chromium.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>, Kees Cook <keescook@chromium.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Pedro Falcato
	<pedro.falcato@gmail.com>, Dave Hansen <dave.hansen@intel.com>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, Guenter Roeck
	<groeck@chromium.org>, Jann Horn <jannh@google.com>, Jeff Xu
	<jeffxu@google.com>, Jonathan Corbet <corbet@lwn.net>, Jorge Lucangeli Obes
	<jorgelo@chromium.org>, Linus Torvalds <torvalds@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>, Muhammad Usama Anjum
	<usama.anjum@collabora.com>, Stephen =?iso-8859-1?Q?R=F6ttger?=
	<sroettger@google.com>, Suren Baghdasaryan <surenb@google.com>, "Amer Al
 Shanawany" <amer.shanawany@gmail.com>, Javier Carrasco
	<javier.carrasco.cruz@gmail.com>, Shuah Khan <shuah@kernel.org>,
	<linux-api@vger.kernel.org>, <linux-mm@kvack.org>, <ying.huang@intel.com>,
	<feng.tang@intel.com>, <fengwei.yin@intel.com>, <oliver.sang@intel.com>
Subject: [linus:master] [mseal]  8be7258aad:
 stress-ng.pagemove.page_remaps_per_sec -4.4% regression
Message-ID: <202408041602.caa0372-oliver.sang@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0056.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::7) To SA1PR11MB8594.namprd11.prod.outlook.com
 (2603:10b6:806:3b1::21)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|CH3PR11MB7868:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bdb50e7-d15c-415f-8b73-08dcb463c66a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?zh5F3kGZ/9CvcxJRvMZ9jkicgiuZuqVNebAy9uzbv5+ogcy/ia4c4d4uv4?=
 =?iso-8859-1?Q?TBu99CO+FQyzzmTMGUXcAU5jvU85O30b959zpsgNGFWIRXxvZSWIwrT8Aq?=
 =?iso-8859-1?Q?lzR6zLj0L4AbnmN2kLb+6H+fuizZtf+r7IZktl5gInuOBEt5BC8KkyynQT?=
 =?iso-8859-1?Q?J9uvVQuwjY5EvmrcchObmX1G6ZH5KXDbMFinVy+Bp3zh9FmlxLz72I9jSh?=
 =?iso-8859-1?Q?49JwYewXdjip/Ur7dh+Vyi5sAdV3hFu/dCa0/rIyFxw0X35II5WL79SglR?=
 =?iso-8859-1?Q?GccbdLiyYydoBrBnogz4rB/XQ/sR6djRYzzKVTVFTd8gxujrMPg+Jq5lNY?=
 =?iso-8859-1?Q?vpW3s51AxRXLD0KaGu/wUlTT0FLKkTJ4bpmP/D15FJDnzPOaguKxCRop3v?=
 =?iso-8859-1?Q?5YjxJFnMdj06xnE7T62jaYrULH5Q7aa6ytY/wn0kZP3AEj4cDfy6LSlYYe?=
 =?iso-8859-1?Q?7lrOpJEpHnSccoXhnsLVtTqcqvJBZ3GcPS8bHr3dJkI10yUTUY5Ae/9LrK?=
 =?iso-8859-1?Q?TvhgrQ0YWbTvEV6UbQ+I/P3uHZgadVBET30Iqut3gvc1IGVqwQlsmASj0F?=
 =?iso-8859-1?Q?R+JhPXrJccl27jh9RjTwaeDLvsEu+lCCHJdPSXpvxJF8tMQhlVIp01vKJz?=
 =?iso-8859-1?Q?g0vDEy/STrZNz7bI1BaCFuiHXtCH/xDbocnzXzqnZXejc2cKq12i1OMW29?=
 =?iso-8859-1?Q?HzOBSgoFByntmuYvs4QXPSci58vJPa1vsg0+nojh+StDIr4jfgSKn04Gvr?=
 =?iso-8859-1?Q?Xr2ixo2am6poCRPjIIJ5dJV5HbBI1Mt+qot1S30a+Y8nWBkjs4ATwJToaY?=
 =?iso-8859-1?Q?V+q3E0aUFlbeg9YTUS/zDfqMActgaj5cFLiYq3qw4R0h/ateF/HC0kkWHg?=
 =?iso-8859-1?Q?s1uJ2Ie9u+tATvuZXmFaZeON0+FnDO0vTXacmvt8Wt0frzd32eCuapk6R5?=
 =?iso-8859-1?Q?0Nkg6Tbt4UwpD288iOJjt15DUNwXhuGHm8Q7lnDZBPVnrsEVe3QtYyod+i?=
 =?iso-8859-1?Q?GTPZ/p/uFh8JfFkmkLfpH5mISJ7KJF6UcWZcBb1gxxsqkIwA5mjGVpno/W?=
 =?iso-8859-1?Q?GXZOLbQTRuTv9m/joGOxtbpvGcVpupNTVCFnSxV75i+NPh3Cpdstv+k+22?=
 =?iso-8859-1?Q?G9hr5ptPGNHIHL4N34F5aLvKMi03sbw11B9Ip3MIq3QNGjcqhjCzrJcgof?=
 =?iso-8859-1?Q?dwY/De92lFrv9KM+STiNG9LtdZLLhHnzeNChC5MVMDJztk6datnD9EuKeh?=
 =?iso-8859-1?Q?NPcd1kIB1ooOdH5h4uIqLY66xGBWfa8fF04UcrG5AHUJsdviywtOejOKdf?=
 =?iso-8859-1?Q?DTZvq7IBAC3+Nq8o3Yuhk4l1WPAUJNbHFSr0Md60neuH8MIFTtuXTBvPbt?=
 =?iso-8859-1?Q?A09WgfUcHn?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?Mww8i42xtxOC9kmurlnbQVDl8tcRO5WGorjki3/SUqEPNInWcROB5MJvD+?=
 =?iso-8859-1?Q?qyzLhJxT+cxl8oHU2Uhigt4HRqndsUerQOI7f3lQRjkA8AfTolAV4KMDtZ?=
 =?iso-8859-1?Q?U60cburjFu7HTlnYbtJDdgm2TCRhygQ12qmKFwrUG8MgIxzubPcM+tSCAU?=
 =?iso-8859-1?Q?BDcyxYWaPQFjB9RWq1+jWCHq4ry97RBqXOo6aMjNiSQCOja5STQFEGVfgY?=
 =?iso-8859-1?Q?uZVHVgwQKaiweMCje2OQaMOWpvvznWo25hhFKCAbR6ckHQeaokjnfdXBT9?=
 =?iso-8859-1?Q?iKEZ8/vE0edhyAp/HlMp52WtYE3gWveiAwvS74ib67xFOWKn2cTMCb1VQA?=
 =?iso-8859-1?Q?CjO5OAT3fO82ACY6MCltLK7VcZm8oi6K/MAJXGNBfOGo29ro8pl9QRIFQ+?=
 =?iso-8859-1?Q?rFUsL2sxfkYkeDcKhgo5h+Ti9YB1BJZLuDrD8XxE4ay8m8tt6Q5Sitnhdd?=
 =?iso-8859-1?Q?X808BORFRrJVADb9AuOt5TPPPs02vdAjZUIooYAwMGS5RKJDw/Ke2UsxEu?=
 =?iso-8859-1?Q?AUy0GMYQfvaf6dq+XODbJ2Nk/jWYzHjXM2D2QnPHnm2tBKqT9mCg0ksmft?=
 =?iso-8859-1?Q?zv08+eo92PTvsbP2AzWd7DP2fULrmyzAN2Ap67SSW6WePKRFDaSpx9SGzL?=
 =?iso-8859-1?Q?NQC8TT+Of9MYyiLzuMjGAg+nY3/F9RFB4m5EGTKOHfNnjI82PczGAAGGbm?=
 =?iso-8859-1?Q?SUhUBkoQ7XaNTp8aeqmKRsoNmHqGngQwdfklFJSJGUC5CeCFC4nIklqDae?=
 =?iso-8859-1?Q?S/y9JmuqaxzKlXUEjApOx23GW2fHfojWZDQmjAjj9eesHmQx9JFIpH4zTZ?=
 =?iso-8859-1?Q?o0MyrWGJvK7MsfRh7G0rf0+TaTp1BNaWOw6aL33aBhg404EWzB4zVaW9vM?=
 =?iso-8859-1?Q?an1g8Bie3OP3fSuCSu9VT3kioNCIFcCPsNRhtpYDcR2q5UpYnyAyo4B9RG?=
 =?iso-8859-1?Q?bXxDz6d3C4pwnF9wKJutYGeLe9K12yrZn4sD6dIDpNf9SPAC097L2LmkoA?=
 =?iso-8859-1?Q?C7uD4Xul0ou6VtSqJwG81cnSaaQ4Tgqhe6RJiKLLghVQhHPVspui1PHpO0?=
 =?iso-8859-1?Q?yRpY3FocJKGTmv/iMnydugtl+oKA3IzwNWv2tLg21Hi2A7KIxEWXUcBpzW?=
 =?iso-8859-1?Q?mNyuTfdQ8V4AAt87NQQSfPrQtJYRc/4c7TYhFbck1WrkLl2v2LK7T00Hkp?=
 =?iso-8859-1?Q?NV2q13+b1KhbbCBmqjdNuYiZEXUrv4YunXPhamAC396sawsOVTUt51VEkZ?=
 =?iso-8859-1?Q?+bb8UmzNe/YDMqjSTZZYZkNi3PCJWJQ5VQpauzHL/6I4FU+chwkEuDkzgn?=
 =?iso-8859-1?Q?RpYUsGB/O1tUuanSRzBWYK+0SIw0t3YM9ltTIO9Vc4uQsoEqJ44CB3V4lR?=
 =?iso-8859-1?Q?jrivl69AyVLnVVvxFiZDyOZEYeaVAPrJscokhoBz9TtSjk4vceLXpId71W?=
 =?iso-8859-1?Q?0qfZvPZ0Qb5izzOtiVTbfcFlfKqXV7sOEaJUy3B8LgGPMynP1ZveFqtqMH?=
 =?iso-8859-1?Q?cnAWrqfHgEouNR8VomT8lWMyetJkjyhL6j61ZQPkmmkeqoHegCkUhS6nmz?=
 =?iso-8859-1?Q?BGsGUvE4PUnCVXeokSYsrUk5d++bHYubk9pdsO+S7VvhR5M5aiW5d4zx9Y?=
 =?iso-8859-1?Q?6r4uCGyqT6hw5xxnwjdEsfC8yqr92SWQWZlhTf4HD/bs+xPhsP5dSNOA?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bdb50e7-d15c-415f-8b73-08dcb463c66a
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8594.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2024 08:59:42.0217
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oYCDZxvVtsFhSKnUNlyDi2fQoEcu1neH9Xw2VQczUyYtk4/FVA3YcxpwXdvIHn3AlK40xe0vRPc5rzrSIHDAIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7868
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed a -4.4% regression of stress-ng.pagemove.page_remaps_per_sec on:


commit: 8be7258aad44b5e25977a98db136f677fa6f4370 ("mseal: add mseal syscall")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

testcase: stress-ng
test machine: 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory
parameters:

	nr_threads: 100%
	testtime: 60s
	test: pagemove
	cpufreq_governor: performance


In addition to that, the commit also has significant impact on the following tests:

+------------------+---------------------------------------------------------------------------------------------+
| testcase: change | stress-ng: stress-ng.pkey.ops_per_sec -3.6% regression                                      |
| test machine     | 224 threads 2 sockets Intel(R) Xeon(R) Platinum 8480CTDX (Sapphire Rapids) with 256G memory |
| test parameters  | cpufreq_governor=performance                                                                |
|                  | nr_threads=100%                                                                             |
|                  | test=pkey                                                                                   |
|                  | testtime=60s                                                                                |
+------------------+---------------------------------------------------------------------------------------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202408041602.caa0372-oliver.sang@intel.com


Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240804/202408041602.caa0372-oliver.sang@intel.com

=========================================================================================
compiler/cpufreq_governor/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  gcc-13/performance/x86_64-rhel-8.3/100%/debian-12-x86_64-20240206.cgz/lkp-icl-2sp7/pagemove/stress-ng/60s

commit: 
  ff388fe5c4 ("mseal: wire up mseal syscall")
  8be7258aad ("mseal: add mseal syscall")

ff388fe5c481d39c 8be7258aad44b5e25977a98db13 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
  41625945            -4.3%   39842322        proc-vmstat.numa_hit
  41559175            -4.3%   39774160        proc-vmstat.numa_local
  77484314            -4.4%   74105555        proc-vmstat.pgalloc_normal
  77205752            -4.4%   73826672        proc-vmstat.pgfree
  18361466            -4.2%   17596652        stress-ng.pagemove.ops
    306014            -4.2%     293262        stress-ng.pagemove.ops_per_sec
    205312            -4.4%     196176        stress-ng.pagemove.page_remaps_per_sec
      4961            +1.0%       5013        stress-ng.time.percent_of_cpu_this_job_got
      2917            +1.2%       2952        stress-ng.time.system_time
      1.07            -6.6%       1.00        perf-stat.i.MPKI
 3.354e+10            +3.5%  3.473e+10        perf-stat.i.branch-instructions
 1.795e+08            -4.2%  1.719e+08        perf-stat.i.cache-misses
 2.376e+08            -4.1%  2.279e+08        perf-stat.i.cache-references
      1.13            -3.0%       1.10        perf-stat.i.cpi
      1077            +4.3%       1124        perf-stat.i.cycles-between-cache-misses
 1.717e+11            +2.7%  1.762e+11        perf-stat.i.instructions
      0.88            +3.1%       0.91        perf-stat.i.ipc
      1.05            -6.8%       0.97        perf-stat.overall.MPKI
      0.25 ±  2%      -0.0        0.24        perf-stat.overall.branch-miss-rate%
      1.13            -3.0%       1.10        perf-stat.overall.cpi
      1084            +4.0%       1127        perf-stat.overall.cycles-between-cache-misses
      0.88            +3.1%       0.91        perf-stat.overall.ipc
 3.298e+10            +3.5%  3.415e+10        perf-stat.ps.branch-instructions
 1.764e+08            -4.3%  1.689e+08        perf-stat.ps.cache-misses
 2.336e+08            -4.1%   2.24e+08        perf-stat.ps.cache-references
    194.57            -2.4%     189.96 ±  2%  perf-stat.ps.cpu-migrations
 1.688e+11            +2.7%  1.733e+11        perf-stat.ps.instructions
 1.036e+13            +3.0%  1.068e+13        perf-stat.total.instructions
     75.12            -1.9       73.22        perf-profile.calltrace.cycles-pp.move_vma.__do_sys_mremap.do_syscall_64.entry_SYSCALL_64_after_hwframe.mremap
     36.84            -1.6       35.29        perf-profile.calltrace.cycles-pp.do_vmi_align_munmap.do_vmi_munmap.move_vma.__do_sys_mremap.do_syscall_64
     24.90            -1.2       23.72        perf-profile.calltrace.cycles-pp.copy_vma.move_vma.__do_sys_mremap.do_syscall_64.entry_SYSCALL_64_after_hwframe
     19.89            -0.9       18.98        perf-profile.calltrace.cycles-pp.__split_vma.do_vmi_align_munmap.do_vmi_munmap.move_vma.__do_sys_mremap
     10.56 ±  2%      -0.8        9.78 ±  2%  perf-profile.calltrace.cycles-pp.rcu_core.handle_softirqs.run_ksoftirqd.smpboot_thread_fn.kthread
     10.56 ±  2%      -0.8        9.79 ±  2%  perf-profile.calltrace.cycles-pp.handle_softirqs.run_ksoftirqd.smpboot_thread_fn.kthread.ret_from_fork
     10.56 ±  2%      -0.8        9.79 ±  2%  perf-profile.calltrace.cycles-pp.run_ksoftirqd.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
     10.57 ±  2%      -0.8        9.80 ±  2%  perf-profile.calltrace.cycles-pp.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
     10.52 ±  2%      -0.8        9.75 ±  2%  perf-profile.calltrace.cycles-pp.rcu_do_batch.rcu_core.handle_softirqs.run_ksoftirqd.smpboot_thread_fn
     10.62 ±  2%      -0.8        9.85 ±  2%  perf-profile.calltrace.cycles-pp.kthread.ret_from_fork.ret_from_fork_asm
     10.62 ±  2%      -0.8        9.85 ±  2%  perf-profile.calltrace.cycles-pp.ret_from_fork.ret_from_fork_asm
     10.62 ±  2%      -0.8        9.85 ±  2%  perf-profile.calltrace.cycles-pp.ret_from_fork_asm
     14.75            -0.7       14.07        perf-profile.calltrace.cycles-pp.vma_merge.copy_vma.move_vma.__do_sys_mremap.do_syscall_64
      1.50            -0.6        0.94        perf-profile.calltrace.cycles-pp.mas_find.do_vmi_munmap.move_vma.__do_sys_mremap.do_syscall_64
      5.88 ±  2%      -0.4        5.47 ±  2%  perf-profile.calltrace.cycles-pp.kmem_cache_free.rcu_do_batch.rcu_core.handle_softirqs.run_ksoftirqd
      7.80            -0.3        7.47        perf-profile.calltrace.cycles-pp.move_page_tables.move_vma.__do_sys_mremap.do_syscall_64.entry_SYSCALL_64_after_hwframe
      4.55 ±  2%      -0.3        4.24 ±  2%  perf-profile.calltrace.cycles-pp.__slab_free.kmem_cache_free.rcu_do_batch.rcu_core.handle_softirqs
      6.76            -0.3        6.45        perf-profile.calltrace.cycles-pp.vm_area_dup.__split_vma.do_vmi_align_munmap.do_vmi_munmap.move_vma
      6.15            -0.3        5.86        perf-profile.calltrace.cycles-pp.kmem_cache_alloc_noprof.vm_area_dup.__split_vma.do_vmi_align_munmap.do_vmi_munmap
      8.22            -0.3        7.93        perf-profile.calltrace.cycles-pp.unmap_region.do_vmi_align_munmap.do_vmi_munmap.move_vma.__do_sys_mremap
      6.12            -0.3        5.87        perf-profile.calltrace.cycles-pp.vma_complete.__split_vma.do_vmi_align_munmap.do_vmi_munmap.move_vma
      5.74            -0.2        5.50        perf-profile.calltrace.cycles-pp.move_ptes.move_page_tables.move_vma.__do_sys_mremap.do_syscall_64
      3.16 ±  2%      -0.2        2.94        perf-profile.calltrace.cycles-pp.vm_area_free_rcu_cb.rcu_do_batch.rcu_core.handle_softirqs.run_ksoftirqd
      5.50            -0.2        5.28        perf-profile.calltrace.cycles-pp.mas_store_prealloc.vma_complete.__split_vma.do_vmi_align_munmap.do_vmi_munmap
      1.36            -0.2        1.14        perf-profile.calltrace.cycles-pp.mas_find.do_vmi_munmap.do_munmap.mremap_to.__do_sys_mremap
      5.15            -0.2        4.94        perf-profile.calltrace.cycles-pp.mas_wr_store_entry.mas_store_prealloc.vma_complete.__split_vma.do_vmi_align_munmap
      5.51            -0.2        5.31        perf-profile.calltrace.cycles-pp.mas_store_prealloc.vma_merge.copy_vma.move_vma.__do_sys_mremap
      5.16            -0.2        4.97        perf-profile.calltrace.cycles-pp.mas_wr_store_entry.mas_store_prealloc.vma_merge.copy_vma.move_vma
      2.24            -0.2        2.05        perf-profile.calltrace.cycles-pp.find_vma_prev.copy_vma.move_vma.__do_sys_mremap.do_syscall_64
      2.60 ±  2%      -0.2        2.42 ±  2%  perf-profile.calltrace.cycles-pp.kmem_cache_free.vm_area_free_rcu_cb.rcu_do_batch.rcu_core.handle_softirqs
      4.67            -0.2        4.49        perf-profile.calltrace.cycles-pp.mas_wr_node_store.mas_wr_store_entry.mas_store_prealloc.vma_merge.copy_vma
      3.41            -0.2        3.23        perf-profile.calltrace.cycles-pp.free_pgtables.unmap_region.do_vmi_align_munmap.do_vmi_munmap.move_vma
      3.00            -0.2        2.83 ±  2%  perf-profile.calltrace.cycles-pp.anon_vma_clone.__split_vma.do_vmi_align_munmap.do_vmi_munmap.move_vma
      0.96            -0.2        0.80        perf-profile.calltrace.cycles-pp.mas_walk.mas_find.do_vmi_munmap.do_munmap.mremap_to
      4.04            -0.2        3.88        perf-profile.calltrace.cycles-pp.vm_area_dup.copy_vma.move_vma.__do_sys_mremap.do_syscall_64
      3.20 ±  2%      -0.2        3.04 ±  2%  perf-profile.calltrace.cycles-pp.__memcg_slab_post_alloc_hook.kmem_cache_alloc_noprof.vm_area_dup.__split_vma.do_vmi_align_munmap
      3.53            -0.1        3.38        perf-profile.calltrace.cycles-pp.kmem_cache_alloc_noprof.vm_area_dup.copy_vma.move_vma.__do_sys_mremap
      3.40            -0.1        3.26        perf-profile.calltrace.cycles-pp.flush_tlb_mm_range.move_ptes.move_page_tables.move_vma.__do_sys_mremap
      2.20 ±  2%      -0.1        2.06 ±  2%  perf-profile.calltrace.cycles-pp.kmem_cache_alloc_noprof.anon_vma_clone.__split_vma.do_vmi_align_munmap.do_vmi_munmap
      1.84 ±  3%      -0.1        1.71 ±  3%  perf-profile.calltrace.cycles-pp.__memcg_slab_post_alloc_hook.kmem_cache_alloc_noprof.anon_vma_clone.__split_vma.do_vmi_align_munmap
      1.78 ±  2%      -0.1        1.65 ±  3%  perf-profile.calltrace.cycles-pp.vma_prepare.vma_merge.copy_vma.move_vma.__do_sys_mremap
      2.69            -0.1        2.56        perf-profile.calltrace.cycles-pp.unlink_anon_vmas.free_pgtables.unmap_region.do_vmi_align_munmap.do_vmi_munmap
      1.78 ±  2%      -0.1        1.66 ±  2%  perf-profile.calltrace.cycles-pp.__slab_free.kmem_cache_free.vm_area_free_rcu_cb.rcu_do_batch.rcu_core
      1.36 ±  2%      -0.1        1.23 ±  2%  perf-profile.calltrace.cycles-pp.rcu_cblist_dequeue.rcu_do_batch.rcu_core.handle_softirqs.run_ksoftirqd
      0.95            -0.1        0.83        perf-profile.calltrace.cycles-pp.mas_walk.mas_find.do_vmi_munmap.move_vma.__do_sys_mremap
      3.29            -0.1        3.17        perf-profile.calltrace.cycles-pp.mas_store_gfp.do_vmi_align_munmap.do_vmi_munmap.move_vma.__do_sys_mremap
      2.08            -0.1        1.96        perf-profile.calltrace.cycles-pp.mas_preallocate.vma_merge.copy_vma.move_vma.__do_sys_mremap
      1.43 ±  3%      -0.1        1.32 ±  3%  perf-profile.calltrace.cycles-pp.down_write.vma_prepare.vma_merge.copy_vma.move_vma
      2.21            -0.1        2.10        perf-profile.calltrace.cycles-pp.mas_preallocate.__split_vma.do_vmi_align_munmap.do_vmi_munmap.move_vma
      2.47            -0.1        2.36        perf-profile.calltrace.cycles-pp.flush_tlb_func.flush_tlb_mm_range.move_ptes.move_page_tables.move_vma
      2.21            -0.1        2.12        perf-profile.calltrace.cycles-pp.native_flush_tlb_one_user.flush_tlb_func.flush_tlb_mm_range.move_ptes.move_page_tables
      1.41            -0.1        1.32        perf-profile.calltrace.cycles-pp.mas_alloc_nodes.mas_preallocate.__split_vma.do_vmi_align_munmap.do_vmi_munmap
      1.26            -0.1        1.18        perf-profile.calltrace.cycles-pp.kmem_cache_alloc_noprof.mas_alloc_nodes.mas_preallocate.__split_vma.do_vmi_align_munmap
      1.82            -0.1        1.75        perf-profile.calltrace.cycles-pp.vma_link.copy_vma.move_vma.__do_sys_mremap.do_syscall_64
      0.71            -0.1        0.63        perf-profile.calltrace.cycles-pp.mas_prev.vma_merge.copy_vma.move_vma.__do_sys_mremap
      1.29            -0.1        1.22        perf-profile.calltrace.cycles-pp.mas_wr_store_entry.mas_store_gfp.do_vmi_align_munmap.do_vmi_munmap.move_vma
      0.61            -0.1        0.54        perf-profile.calltrace.cycles-pp.mas_prev_setup.mas_prev.vma_merge.copy_vma.move_vma
      1.36            -0.1        1.29        perf-profile.calltrace.cycles-pp.kmem_cache_free.unlink_anon_vmas.free_pgtables.unmap_region.do_vmi_align_munmap
      1.40            -0.1        1.33        perf-profile.calltrace.cycles-pp.mas_alloc_nodes.mas_preallocate.vma_merge.copy_vma.move_vma
      0.70            -0.1        0.64        perf-profile.calltrace.cycles-pp.mas_walk.find_vma_prev.copy_vma.move_vma.__do_sys_mremap
      1.23            -0.1        1.17        perf-profile.calltrace.cycles-pp.kmem_cache_alloc_noprof.mas_alloc_nodes.mas_preallocate.vma_merge.copy_vma
      1.66            -0.1        1.60        perf-profile.calltrace.cycles-pp.__get_unmapped_area.mremap_to.__do_sys_mremap.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.16            -0.1        1.10        perf-profile.calltrace.cycles-pp.anon_vma_clone.copy_vma.move_vma.__do_sys_mremap.do_syscall_64
      0.96            -0.1        0.90        perf-profile.calltrace.cycles-pp.__memcg_slab_free_hook.kmem_cache_free.unlink_anon_vmas.free_pgtables.unmap_region
      1.14            -0.1        1.08        perf-profile.calltrace.cycles-pp.___slab_alloc.kmem_cache_alloc_noprof.vm_area_dup.__split_vma.do_vmi_align_munmap
      0.79            -0.1        0.74        perf-profile.calltrace.cycles-pp.___slab_alloc.kmem_cache_alloc_noprof.mas_alloc_nodes.mas_preallocate.__split_vma
      1.04            -0.1        1.00        perf-profile.calltrace.cycles-pp.vma_to_resize.mremap_to.__do_sys_mremap.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.58            -0.0        0.53        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64.mremap
      0.61            -0.0        0.56        perf-profile.calltrace.cycles-pp.__memcg_slab_free_hook.kmem_cache_free.vm_area_free_rcu_cb.rcu_do_batch.rcu_core
      0.56            -0.0        0.52        perf-profile.calltrace.cycles-pp.mas_find.find_vma_prev.copy_vma.move_vma.__do_sys_mremap
      0.57            -0.0        0.53 ±  2%  perf-profile.calltrace.cycles-pp.__memcg_slab_free_hook.kmem_cache_free.rcu_do_batch.rcu_core.handle_softirqs
      0.78            -0.0        0.74        perf-profile.calltrace.cycles-pp.___slab_alloc.kmem_cache_alloc_noprof.mas_alloc_nodes.mas_preallocate.vma_merge
      0.88            -0.0        0.84        perf-profile.calltrace.cycles-pp.mtree_load.vma_to_resize.mremap_to.__do_sys_mremap.do_syscall_64
      0.70            -0.0        0.66        perf-profile.calltrace.cycles-pp.__call_rcu_common.do_vmi_align_munmap.do_vmi_munmap.move_vma.__do_sys_mremap
      0.68            -0.0        0.64        perf-profile.calltrace.cycles-pp.percpu_counter_add_batch.do_vmi_align_munmap.do_vmi_munmap.move_vma.__do_sys_mremap
      0.68            -0.0        0.64        perf-profile.calltrace.cycles-pp.syscall_return_via_sysret.mremap
      0.97            -0.0        0.93        perf-profile.calltrace.cycles-pp.mas_find.do_vmi_align_munmap.do_vmi_munmap.move_vma.__do_sys_mremap
      1.11            -0.0        1.08        perf-profile.calltrace.cycles-pp.clear_bhb_loop.mremap
      0.75            -0.0        0.72        perf-profile.calltrace.cycles-pp.allocate_slab.___slab_alloc.kmem_cache_alloc_noprof.vm_area_dup.__split_vma
      0.74            -0.0        0.71        perf-profile.calltrace.cycles-pp.kmem_cache_alloc_noprof.anon_vma_clone.copy_vma.move_vma.__do_sys_mremap
      0.60 ±  2%      -0.0        0.57        perf-profile.calltrace.cycles-pp.security_mmap_addr.__get_unmapped_area.mremap_to.__do_sys_mremap.do_syscall_64
      0.67 ±  2%      -0.0        0.64        perf-profile.calltrace.cycles-pp.___slab_alloc.kmem_cache_alloc_noprof.vm_area_dup.copy_vma.move_vma
      0.82            -0.0        0.79        perf-profile.calltrace.cycles-pp.mtree_load.__do_sys_mremap.do_syscall_64.entry_SYSCALL_64_after_hwframe.mremap
      0.63            -0.0        0.60        perf-profile.calltrace.cycles-pp.mas_prev_slot.do_vmi_align_munmap.do_vmi_munmap.move_vma.__do_sys_mremap
      0.99            -0.0        0.96        perf-profile.calltrace.cycles-pp.mt_find.vma_merge.copy_vma.move_vma.__do_sys_mremap
      0.62 ±  2%      -0.0        0.59        perf-profile.calltrace.cycles-pp.get_old_pud.move_page_tables.move_vma.__do_sys_mremap.do_syscall_64
      0.87            -0.0        0.84        perf-profile.calltrace.cycles-pp.userfaultfd_unmap_complete.__do_sys_mremap.do_syscall_64.entry_SYSCALL_64_after_hwframe.mremap
      0.78            -0.0        0.75        perf-profile.calltrace.cycles-pp.mas_store_prealloc.vma_link.copy_vma.move_vma.__do_sys_mremap
      0.64            -0.0        0.62        perf-profile.calltrace.cycles-pp.mas_preallocate.vma_link.copy_vma.move_vma.__do_sys_mremap
      0.90            -0.0        0.87        perf-profile.calltrace.cycles-pp.mtree_load.vma_merge.copy_vma.move_vma.__do_sys_mremap
      0.54            -0.0        0.52        perf-profile.calltrace.cycles-pp.__pte_offset_map_lock.move_ptes.move_page_tables.move_vma.__do_sys_mremap
      1.04            +0.0        1.08        perf-profile.calltrace.cycles-pp.zap_pte_range.zap_pmd_range.unmap_page_range.unmap_vmas.unmap_region
      0.76            +0.1        0.83        perf-profile.calltrace.cycles-pp.__madvise
      0.63            +0.1        0.70        perf-profile.calltrace.cycles-pp.__x64_sys_madvise.do_syscall_64.entry_SYSCALL_64_after_hwframe.__madvise
      0.62            +0.1        0.70        perf-profile.calltrace.cycles-pp.do_madvise.__x64_sys_madvise.do_syscall_64.entry_SYSCALL_64_after_hwframe.__madvise
      0.66            +0.1        0.74        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__madvise
      0.66            +0.1        0.74        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__madvise
     87.74            +0.7       88.45        perf-profile.calltrace.cycles-pp.mremap
      0.00            +0.9        0.86        perf-profile.calltrace.cycles-pp.mas_walk.mas_find.can_modify_mm.do_vmi_munmap.do_munmap
      0.00            +0.9        0.86        perf-profile.calltrace.cycles-pp.mas_walk.mas_find.can_modify_mm.mremap_to.__do_sys_mremap
     84.88            +0.9       85.77        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.mremap
     84.73            +0.9       85.62        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.mremap
      0.00            +0.9        0.92 ±  2%  perf-profile.calltrace.cycles-pp.mas_walk.mas_find.can_modify_mm.do_vmi_munmap.move_vma
     83.84            +0.9       84.78        perf-profile.calltrace.cycles-pp.__do_sys_mremap.do_syscall_64.entry_SYSCALL_64_after_hwframe.mremap
      0.00            +1.1        1.06        perf-profile.calltrace.cycles-pp.mas_find.can_modify_mm.mremap_to.__do_sys_mremap.do_syscall_64
      0.00            +1.2        1.21        perf-profile.calltrace.cycles-pp.mas_find.can_modify_mm.do_vmi_munmap.do_munmap.mremap_to
      2.07            +1.5        3.55        perf-profile.calltrace.cycles-pp.do_munmap.mremap_to.__do_sys_mremap.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.58            +1.5        3.07        perf-profile.calltrace.cycles-pp.do_vmi_munmap.do_munmap.mremap_to.__do_sys_mremap.do_syscall_64
      0.00            +1.5        1.52        perf-profile.calltrace.cycles-pp.mas_find.can_modify_mm.do_vmi_munmap.move_vma.__do_sys_mremap
      0.00            +1.6        1.57        perf-profile.calltrace.cycles-pp.can_modify_mm.mremap_to.__do_sys_mremap.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +1.7        1.72        perf-profile.calltrace.cycles-pp.can_modify_mm.do_vmi_munmap.do_munmap.mremap_to.__do_sys_mremap
      0.00            +2.0        2.01        perf-profile.calltrace.cycles-pp.can_modify_mm.do_vmi_munmap.move_vma.__do_sys_mremap.do_syscall_64
      5.39            +2.9        8.32        perf-profile.calltrace.cycles-pp.mremap_to.__do_sys_mremap.do_syscall_64.entry_SYSCALL_64_after_hwframe.mremap
     75.29            -1.9       73.37        perf-profile.children.cycles-pp.move_vma
     37.06            -1.6       35.50        perf-profile.children.cycles-pp.do_vmi_align_munmap
     24.98            -1.2       23.80        perf-profile.children.cycles-pp.copy_vma
     19.99            -1.0       19.02        perf-profile.children.cycles-pp.handle_softirqs
     19.97            -1.0       19.00        perf-profile.children.cycles-pp.rcu_core
     19.95            -1.0       18.98        perf-profile.children.cycles-pp.rcu_do_batch
     19.98            -0.9       19.06        perf-profile.children.cycles-pp.__split_vma
     17.55            -0.8       16.76        perf-profile.children.cycles-pp.kmem_cache_free
     10.56 ±  2%      -0.8        9.79 ±  2%  perf-profile.children.cycles-pp.run_ksoftirqd
     10.57 ±  2%      -0.8        9.80 ±  2%  perf-profile.children.cycles-pp.smpboot_thread_fn
     15.38            -0.8       14.62        perf-profile.children.cycles-pp.kmem_cache_alloc_noprof
     10.62 ±  2%      -0.8        9.85 ±  2%  perf-profile.children.cycles-pp.kthread
     10.62 ±  2%      -0.8        9.86 ±  2%  perf-profile.children.cycles-pp.ret_from_fork
     10.62 ±  2%      -0.8        9.86 ±  2%  perf-profile.children.cycles-pp.ret_from_fork_asm
     15.14            -0.7       14.44        perf-profile.children.cycles-pp.vma_merge
     12.08            -0.5       11.55        perf-profile.children.cycles-pp.__slab_free
     12.11            -0.5       11.62        perf-profile.children.cycles-pp.mas_wr_store_entry
     10.86            -0.5       10.39        perf-profile.children.cycles-pp.vm_area_dup
     11.89            -0.5       11.44        perf-profile.children.cycles-pp.mas_store_prealloc
      8.49            -0.4        8.06        perf-profile.children.cycles-pp.__memcg_slab_post_alloc_hook
      9.88            -0.4        9.49        perf-profile.children.cycles-pp.mas_wr_node_store
      7.91            -0.3        7.58        perf-profile.children.cycles-pp.move_page_tables
      6.06            -0.3        5.78        perf-profile.children.cycles-pp.vm_area_free_rcu_cb
      8.28            -0.3        8.00        perf-profile.children.cycles-pp.unmap_region
      6.69            -0.3        6.42        perf-profile.children.cycles-pp.vma_complete
      5.06            -0.3        4.80        perf-profile.children.cycles-pp.mas_preallocate
      5.82            -0.2        5.57        perf-profile.children.cycles-pp.move_ptes
      4.24            -0.2        4.01        perf-profile.children.cycles-pp.anon_vma_clone
      3.50            -0.2        3.30        perf-profile.children.cycles-pp.down_write
      2.44            -0.2        2.25        perf-profile.children.cycles-pp.find_vma_prev
      3.46            -0.2        3.28        perf-profile.children.cycles-pp.___slab_alloc
      3.45            -0.2        3.27        perf-profile.children.cycles-pp.free_pgtables
      2.54            -0.2        2.37        perf-profile.children.cycles-pp.rcu_cblist_dequeue
      3.35            -0.2        3.18        perf-profile.children.cycles-pp.__memcg_slab_free_hook
      2.93            -0.2        2.78        perf-profile.children.cycles-pp.mas_alloc_nodes
      2.28 ±  2%      -0.2        2.12 ±  2%  perf-profile.children.cycles-pp.vma_prepare
      3.46            -0.1        3.32        perf-profile.children.cycles-pp.flush_tlb_mm_range
      3.41            -0.1        3.27 ±  2%  perf-profile.children.cycles-pp.mod_objcg_state
      2.76            -0.1        2.63        perf-profile.children.cycles-pp.unlink_anon_vmas
      3.41            -0.1        3.28        perf-profile.children.cycles-pp.mas_store_gfp
      2.21            -0.1        2.09        perf-profile.children.cycles-pp.__cond_resched
      2.04            -0.1        1.94        perf-profile.children.cycles-pp.allocate_slab
      2.10            -0.1        2.00        perf-profile.children.cycles-pp.__call_rcu_common
      2.51            -0.1        2.40        perf-profile.children.cycles-pp.flush_tlb_func
      1.04            -0.1        0.94        perf-profile.children.cycles-pp.mas_prev
      2.71            -0.1        2.61        perf-profile.children.cycles-pp.mtree_load
      2.23            -0.1        2.14        perf-profile.children.cycles-pp.native_flush_tlb_one_user
      0.22 ±  5%      -0.1        0.13 ± 13%  perf-profile.children.cycles-pp.vm_stat_account
      0.95            -0.1        0.87        perf-profile.children.cycles-pp.mas_prev_setup
      1.65            -0.1        1.57        perf-profile.children.cycles-pp.mas_wr_walk
      1.84            -0.1        1.76        perf-profile.children.cycles-pp.up_write
      1.27            -0.1        1.20        perf-profile.children.cycles-pp.mas_prev_slot
      1.84            -0.1        1.77        perf-profile.children.cycles-pp.vma_link
      1.39            -0.1        1.32        perf-profile.children.cycles-pp.shuffle_freelist
      0.96            -0.1        0.90 ±  2%  perf-profile.children.cycles-pp.rcu_all_qs
      0.86            -0.1        0.80        perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      1.70            -0.1        1.64        perf-profile.children.cycles-pp.__get_unmapped_area
      0.34 ±  3%      -0.1        0.29 ±  5%  perf-profile.children.cycles-pp.security_vm_enough_memory_mm
      0.60            -0.0        0.55        perf-profile.children.cycles-pp.entry_SYSCALL_64
      0.92            -0.0        0.87        perf-profile.children.cycles-pp.percpu_counter_add_batch
      1.07            -0.0        1.02        perf-profile.children.cycles-pp.vma_to_resize
      1.59            -0.0        1.54        perf-profile.children.cycles-pp.mas_update_gap
      0.44 ±  2%      -0.0        0.40 ±  2%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
      0.70            -0.0        0.66        perf-profile.children.cycles-pp.syscall_return_via_sysret
      1.13            -0.0        1.09        perf-profile.children.cycles-pp.mt_find
      0.20 ±  6%      -0.0        0.17 ±  9%  perf-profile.children.cycles-pp.cap_vm_enough_memory
      0.99            -0.0        0.95        perf-profile.children.cycles-pp.mas_pop_node
      0.63 ±  2%      -0.0        0.59        perf-profile.children.cycles-pp.security_mmap_addr
      0.62            -0.0        0.59        perf-profile.children.cycles-pp.__put_partials
      1.17            -0.0        1.14        perf-profile.children.cycles-pp.clear_bhb_loop
      0.46            -0.0        0.43 ±  2%  perf-profile.children.cycles-pp.__alloc_pages_noprof
      0.44            -0.0        0.41 ±  2%  perf-profile.children.cycles-pp.get_page_from_freelist
      0.90            -0.0        0.87        perf-profile.children.cycles-pp.userfaultfd_unmap_complete
      0.64 ±  2%      -0.0        0.62        perf-profile.children.cycles-pp.get_old_pud
      1.07            -0.0        1.05        perf-profile.children.cycles-pp.mas_leaf_max_gap
      0.22 ±  3%      -0.0        0.20 ±  2%  perf-profile.children.cycles-pp.__rmqueue_pcplist
      0.55            -0.0        0.53        perf-profile.children.cycles-pp.refill_obj_stock
      0.25            -0.0        0.23 ±  3%  perf-profile.children.cycles-pp.rmqueue
      0.48            -0.0        0.45        perf-profile.children.cycles-pp.mremap_userfaultfd_prep
      0.33            -0.0        0.30        perf-profile.children.cycles-pp.free_unref_page
      0.46            -0.0        0.44        perf-profile.children.cycles-pp.setup_object
      0.21 ±  3%      -0.0        0.19 ±  2%  perf-profile.children.cycles-pp.rmqueue_bulk
      0.31 ±  3%      -0.0        0.29        perf-profile.children.cycles-pp.__vm_enough_memory
      0.40            -0.0        0.38        perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.36            -0.0        0.35        perf-profile.children.cycles-pp.madvise_vma_behavior
      0.54            -0.0        0.53 ±  2%  perf-profile.children.cycles-pp.mas_wr_end_piv
      0.46            -0.0        0.44 ±  2%  perf-profile.children.cycles-pp.rcu_segcblist_enqueue
      0.34            -0.0        0.32 ±  2%  perf-profile.children.cycles-pp.mas_destroy
      0.28            -0.0        0.26 ±  3%  perf-profile.children.cycles-pp.mas_wr_store_setup
      0.30            -0.0        0.28        perf-profile.children.cycles-pp.pte_offset_map_nolock
      0.19            -0.0        0.18 ±  2%  perf-profile.children.cycles-pp.__thp_vma_allowable_orders
      0.08 ±  4%      -0.0        0.07        perf-profile.children.cycles-pp.ksm_madvise
      0.17            -0.0        0.16        perf-profile.children.cycles-pp.get_any_partial
      0.08            -0.0        0.07        perf-profile.children.cycles-pp.syscall_exit_to_user_mode_prepare
      0.45            +0.0        0.47        perf-profile.children.cycles-pp._raw_spin_lock
      1.10            +0.0        1.14        perf-profile.children.cycles-pp.zap_pte_range
      0.78            +0.1        0.85        perf-profile.children.cycles-pp.__madvise
      0.63            +0.1        0.70        perf-profile.children.cycles-pp.__x64_sys_madvise
      0.62            +0.1        0.70        perf-profile.children.cycles-pp.do_madvise
      0.00            +0.1        0.09 ±  4%  perf-profile.children.cycles-pp.can_modify_mm_madv
      1.32            +0.1        1.46        perf-profile.children.cycles-pp.mas_next_slot
     88.13            +0.7       88.83        perf-profile.children.cycles-pp.mremap
     83.94            +0.9       84.88        perf-profile.children.cycles-pp.__do_sys_mremap
     86.06            +0.9       87.00        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     85.56            +1.0       86.54        perf-profile.children.cycles-pp.do_syscall_64
     40.49            +1.4       41.90        perf-profile.children.cycles-pp.do_vmi_munmap
      2.10            +1.5        3.57        perf-profile.children.cycles-pp.do_munmap
      3.62            +2.3        5.90        perf-profile.children.cycles-pp.mas_walk
      5.44            +2.9        8.38        perf-profile.children.cycles-pp.mremap_to
      5.30            +3.1        8.39        perf-profile.children.cycles-pp.mas_find
      0.00            +5.4        5.40        perf-profile.children.cycles-pp.can_modify_mm
     11.46            -0.5       10.96        perf-profile.self.cycles-pp.__slab_free
      4.30            -0.2        4.08        perf-profile.self.cycles-pp.__memcg_slab_post_alloc_hook
      2.51            -0.2        2.34        perf-profile.self.cycles-pp.rcu_cblist_dequeue
      2.41 ±  2%      -0.2        2.25        perf-profile.self.cycles-pp.down_write
      2.21            -0.1        2.11        perf-profile.self.cycles-pp.native_flush_tlb_one_user
      2.37            -0.1        2.28        perf-profile.self.cycles-pp.mtree_load
      1.60            -0.1        1.51        perf-profile.self.cycles-pp.__memcg_slab_free_hook
      0.18 ±  3%      -0.1        0.10 ± 15%  perf-profile.self.cycles-pp.vm_stat_account
      1.25            -0.1        1.18        perf-profile.self.cycles-pp.move_vma
      1.76            -0.1        1.69        perf-profile.self.cycles-pp.mod_objcg_state
      1.42            -0.1        1.35 ±  2%  perf-profile.self.cycles-pp.__call_rcu_common
      1.41            -0.1        1.34        perf-profile.self.cycles-pp.mas_wr_walk
      1.52            -0.1        1.46        perf-profile.self.cycles-pp.up_write
      1.02            -0.1        0.95        perf-profile.self.cycles-pp.mas_prev_slot
      0.96            -0.1        0.90 ±  2%  perf-profile.self.cycles-pp.vm_area_free_rcu_cb
      1.50            -0.1        1.45        perf-profile.self.cycles-pp.kmem_cache_free
      0.69 ±  3%      -0.1        0.64 ±  2%  perf-profile.self.cycles-pp.rcu_all_qs
      1.14 ±  2%      -0.1        1.09        perf-profile.self.cycles-pp.shuffle_freelist
      1.10            -0.1        1.05        perf-profile.self.cycles-pp.__cond_resched
      1.40            -0.0        1.35        perf-profile.self.cycles-pp.do_vmi_align_munmap
      0.99            -0.0        0.94        perf-profile.self.cycles-pp.mas_preallocate
      0.88            -0.0        0.83        perf-profile.self.cycles-pp.___slab_alloc
      0.55            -0.0        0.50        perf-profile.self.cycles-pp.mremap_to
      0.98            -0.0        0.93        perf-profile.self.cycles-pp.move_ptes
      0.78            -0.0        0.74        perf-profile.self.cycles-pp.percpu_counter_add_batch
      0.21 ±  2%      -0.0        0.18 ±  2%  perf-profile.self.cycles-pp.entry_SYSCALL_64
      0.44 ±  2%      -0.0        0.40 ±  2%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
      0.92            -0.0        0.89        perf-profile.self.cycles-pp.mas_store_gfp
      0.86            -0.0        0.82        perf-profile.self.cycles-pp.mas_pop_node
      0.50            -0.0        0.46        perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      1.15            -0.0        1.12        perf-profile.self.cycles-pp.clear_bhb_loop
      1.14            -0.0        1.11        perf-profile.self.cycles-pp.vma_merge
      0.66            -0.0        0.63        perf-profile.self.cycles-pp.__split_vma
      0.16 ±  6%      -0.0        0.13 ±  7%  perf-profile.self.cycles-pp.cap_vm_enough_memory
      0.82            -0.0        0.79        perf-profile.self.cycles-pp.mas_wr_store_entry
      0.54 ±  2%      -0.0        0.52        perf-profile.self.cycles-pp.get_old_pud
      0.43            -0.0        0.40        perf-profile.self.cycles-pp.do_munmap
      0.51 ±  2%      -0.0        0.48 ±  2%  perf-profile.self.cycles-pp.security_mmap_addr
      0.50            -0.0        0.48        perf-profile.self.cycles-pp.refill_obj_stock
      0.24            -0.0        0.22        perf-profile.self.cycles-pp.mas_prev
      0.71            -0.0        0.69        perf-profile.self.cycles-pp.unmap_page_range
      0.48            -0.0        0.45        perf-profile.self.cycles-pp.find_vma_prev
      0.42            -0.0        0.40        perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.66            -0.0        0.64        perf-profile.self.cycles-pp.mas_store_prealloc
      0.31            -0.0        0.29        perf-profile.self.cycles-pp.mas_prev_setup
      0.43            -0.0        0.41        perf-profile.self.cycles-pp.mas_wr_end_piv
      0.78            -0.0        0.76        perf-profile.self.cycles-pp.userfaultfd_unmap_complete
      0.28            -0.0        0.26 ±  2%  perf-profile.self.cycles-pp.mas_put_in_tree
      0.42            -0.0        0.40        perf-profile.self.cycles-pp.mremap_userfaultfd_prep
      0.28            -0.0        0.26        perf-profile.self.cycles-pp.free_pgtables
      0.39            -0.0        0.37        perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.30 ±  2%      -0.0        0.28        perf-profile.self.cycles-pp.zap_pmd_range
      0.32            -0.0        0.31        perf-profile.self.cycles-pp.unmap_vmas
      0.21            -0.0        0.20        perf-profile.self.cycles-pp.__get_unmapped_area
      0.18 ±  2%      -0.0        0.17 ±  2%  perf-profile.self.cycles-pp.lru_add_drain_cpu
      0.06            -0.0        0.05        perf-profile.self.cycles-pp.ksm_madvise
      0.45            +0.0        0.46        perf-profile.self.cycles-pp.do_vmi_munmap
      0.37            +0.0        0.39        perf-profile.self.cycles-pp._raw_spin_lock
      1.06            +0.1        1.18        perf-profile.self.cycles-pp.mas_next_slot
      1.50            +0.5        1.97        perf-profile.self.cycles-pp.mas_find
      0.00            +1.4        1.35        perf-profile.self.cycles-pp.can_modify_mm
      3.13            +2.0        5.13        perf-profile.self.cycles-pp.mas_walk


***************************************************************************************************
lkp-spr-r02: 224 threads 2 sockets Intel(R) Xeon(R) Platinum 8480CTDX (Sapphire Rapids) with 256G memory
=========================================================================================
compiler/cpufreq_governor/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  gcc-13/performance/x86_64-rhel-8.3/100%/debian-12-x86_64-20240206.cgz/lkp-spr-r02/pkey/stress-ng/60s

commit: 
  ff388fe5c4 ("mseal: wire up mseal syscall")
  8be7258aad ("mseal: add mseal syscall")

ff388fe5c481d39c 8be7258aad44b5e25977a98db13 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
     10539            -2.5%      10273        vmstat.system.cs
      0.28 ±  5%     -20.1%       0.22 ±  7%  sched_debug.cfs_rq:/.h_nr_running.stddev
      1419 ±  7%     -15.3%       1202 ±  6%  sched_debug.cfs_rq:/.util_avg.max
      0.28 ±  6%     -18.4%       0.23 ±  8%  sched_debug.cpu.nr_running.stddev
 8.736e+08            -3.6%  8.423e+08        stress-ng.pkey.ops
  14560560            -3.6%   14038795        stress-ng.pkey.ops_per_sec
    770.39 ±  4%      -5.0%     732.04        stress-ng.time.user_time
    244657 ±  3%      +5.8%     258782 ±  3%  proc-vmstat.nr_slab_unreclaimable
  73133541            -2.1%   71588873        proc-vmstat.numa_hit
  72873579            -2.1%   71357274        proc-vmstat.numa_local
 1.842e+08            -2.5%  1.796e+08        proc-vmstat.pgalloc_normal
 1.767e+08            -2.8%  1.717e+08        proc-vmstat.pgfree
   1345346 ± 40%     -73.1%     362064 ±124%  numa-vmstat.node0.nr_inactive_anon
   1345340 ± 40%     -73.1%     362062 ±124%  numa-vmstat.node0.nr_zone_inactive_anon
   2420830 ± 14%     +35.1%    3270248 ± 16%  numa-vmstat.node1.nr_file_pages
   2067871 ± 13%     +51.5%    3132982 ± 17%  numa-vmstat.node1.nr_inactive_anon
    191406 ± 17%     +33.6%     255808 ± 14%  numa-vmstat.node1.nr_mapped
      2452 ± 61%    +104.4%       5012 ± 35%  numa-vmstat.node1.nr_page_table_pages
   2067853 ± 13%     +51.5%    3132966 ± 17%  numa-vmstat.node1.nr_zone_inactive_anon
   5379238 ± 40%     -73.0%    1453605 ±123%  numa-meminfo.node0.Inactive
   5379166 ± 40%     -73.0%    1453462 ±123%  numa-meminfo.node0.Inactive(anon)
   8741077 ± 22%     -36.7%    5531290 ± 28%  numa-meminfo.node0.MemUsed
   9651902 ± 13%     +35.8%   13105318 ± 16%  numa-meminfo.node1.FilePages
   8239855 ± 13%     +52.4%   12556929 ± 17%  numa-meminfo.node1.Inactive
   8239712 ± 13%     +52.4%   12556853 ± 17%  numa-meminfo.node1.Inactive(anon)
    761944 ± 18%     +34.6%    1025906 ± 14%  numa-meminfo.node1.Mapped
  11679628 ± 11%     +31.2%   15322841 ± 14%  numa-meminfo.node1.MemUsed
      9874 ± 62%    +104.6%      20200 ± 36%  numa-meminfo.node1.PageTables
      0.74            -4.2%       0.71        perf-stat.i.MPKI
 1.245e+11            +2.3%  1.274e+11        perf-stat.i.branch-instructions
      0.37            -0.0        0.35        perf-stat.i.branch-miss-rate%
 4.359e+08            -2.1%  4.265e+08        perf-stat.i.branch-misses
 4.672e+08            -2.6%  4.548e+08        perf-stat.i.cache-misses
 7.276e+08            -2.7%  7.082e+08        perf-stat.i.cache-references
      1.00            -1.6%       0.98        perf-stat.i.cpi
      1364            +2.9%       1404        perf-stat.i.cycles-between-cache-misses
 6.392e+11            +1.7%  6.499e+11        perf-stat.i.instructions
      1.00            +1.6%       1.02        perf-stat.i.ipc
      0.74            -4.3%       0.71        perf-stat.overall.MPKI
      0.35            -0.0        0.33        perf-stat.overall.branch-miss-rate%
      1.00            -1.6%       0.99        perf-stat.overall.cpi
      1356            +2.9%       1395        perf-stat.overall.cycles-between-cache-misses
      1.00            +1.6%       1.01        perf-stat.overall.ipc
 1.209e+11            +1.9%  1.232e+11        perf-stat.ps.branch-instructions
 4.188e+08            -2.6%  4.077e+08        perf-stat.ps.branch-misses
 4.585e+08            -3.1%  4.441e+08        perf-stat.ps.cache-misses
 7.124e+08            -3.1%  6.901e+08        perf-stat.ps.cache-references
     10321            -2.6%      10053        perf-stat.ps.context-switches





Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki



Return-Path: <linux-api+bounces-2126-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9A0194870F
	for <lists+linux-api@lfdr.de>; Tue,  6 Aug 2024 03:44:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C85EB22473
	for <lists+linux-api@lfdr.de>; Tue,  6 Aug 2024 01:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41A968F6D;
	Tue,  6 Aug 2024 01:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K+RnqkTc"
X-Original-To: linux-api@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD313D7A;
	Tue,  6 Aug 2024 01:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722908690; cv=fail; b=k3w7fJdNQk7NAJoJBI07TlZ4CQkMYR4eznLEyUX19UwcuYKIVwtREUa5x5jHbh63QVQJeIonQHerp7d1lgoA36HlalxHV1nX9io/BfMYCK/rdnV4TABPNwggVEGyFtBWp3W4YmiQ+E3Et4+JPfVn75QOxaSAfIUcMTP0MlHPtnI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722908690; c=relaxed/simple;
	bh=Z9AkDU4dU4982DEAg9DpkQjIbsLKGdcn6b1A493pU5M=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gWoL5It+xFcYM+VAgSo4sBq3X0LrtEf6mDxICbm5g1R2wjXoFjGLUZ9NiyJ2it750yK8rw2Qia2Bby8Mb9VDeYy1gVQ2KeA2YURP0NY5t69IuDt4gdls99ffhVAgM967d47SahSIGxtcBLwuWzTeivkbbMyUmaPPSr0Y+Icc9Hw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K+RnqkTc; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722908687; x=1754444687;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=Z9AkDU4dU4982DEAg9DpkQjIbsLKGdcn6b1A493pU5M=;
  b=K+RnqkTcWhHgAPxge4LRQzgqagOR+qv36mFZ3HIX5qRWu2VMki7lV8GC
   I8Wd1RJZIu7txGHgicU350dPV8yDa2BfHYJvwgaL2dDlpB1aTsVW3z2qC
   KkUIYDMtU+eVpYngJLOllsOof+GWvTWBwjhUplXEBwXUlmsxKshzYO+Ld
   5CTanfiHynJX9Y43BZAEQh5AlIjLjkY2Y9Jmhchx48jUntI99Q9LFEUb/
   6IFkMuoRxrMWcn9BJvGNrWgMsHGQ2nqiP4sOBoQoFl6AyMlwLa4pXC812
   Oq3ibvEmt+mnLO5b2lSUlBxq6Pjrcq0WhD1Rx2LtP+OW9hHAy8x7fYdXg
   w==;
X-CSE-ConnectionGUID: Hm24URs1Q0eJtMBS6JHAJw==
X-CSE-MsgGUID: lRqvgCR3SN+XwpZa/W8wrg==
X-IronPort-AV: E=McAfee;i="6700,10204,11155"; a="21049852"
X-IronPort-AV: E=Sophos;i="6.09,266,1716274800"; 
   d="scan'208";a="21049852"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2024 18:44:46 -0700
X-CSE-ConnectionGUID: XnyizFCnRLWToLfl2AEgMQ==
X-CSE-MsgGUID: mp8dRpQcTHukfeBWWcHF8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,266,1716274800"; 
   d="scan'208";a="56232381"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Aug 2024 18:44:44 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 5 Aug 2024 18:44:43 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 5 Aug 2024 18:44:43 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.172)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 5 Aug 2024 18:44:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S4J8YDl9HPC9id//ji9yTa8lV5x2k/lVBN46BY6uISG90a/UkRCUmQf6kXQyLm5ZZdniTNZk+9ihXAHo/vaU20hXg7tGvryJWDw8ZqrowtrqGSwGAHGfU2r60JUoXNzL+4lDLqQDhcI8vAd6+42QMeTCezCGDZ/wtYC1W5QUlryimGSkZwlkEUkKeKOgXB+beSvwM2BZoawB2CQRzdNHzKCi75ik3Jr3MoRdz4nXyYMZEaJBoeTjmM2z6d8YxvHGlo9aIrreiMT72f3eDZO21/nkbmPQ2P+Pwy+3trWJbxJs6nAy5K/R9CYptmJiMyVVyasYdgRePTFBbtDvt3S2vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rYvLyZT8F9RmMA41FpJ0XF/MeUpOzWNEuBeG6gkD8EU=;
 b=BIKcIEkIQjXBksgLcweRfPgT/qHwP3bmjjabshxnTy8h8mFNoL2uSB7S04tdvirFxW8f2UNAmRYDVta5lC89EUYqM5imik30XQoIukOUAXKuNjipeJVo0OF0mCnyPzjpEBWysdyIRzt4/I8ELNK7ftqf/STiADf+DK5OgoBT3gMn7r/k4yjqHUQSC/ihIOc6LKYRrIL9Cm1GYimXWPsc2KRpC8j805HcMNOjLc9e6u5zdOgcOJ0OZjjm0DZPboYDQez2ahs9WPRhdwpVI+LNpH1BcJQws+mpiLv1DQEbzJYP9XHZSIVvbNwQCBY/wwcBkuAoaZ9NebsfgrRfQd8sTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by PH7PR11MB6329.namprd11.prod.outlook.com (2603:10b6:510:1ff::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Tue, 6 Aug
 2024 01:44:39 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.7828.023; Tue, 6 Aug 2024
 01:44:39 +0000
Date: Tue, 6 Aug 2024 09:44:23 +0800
From: Oliver Sang <oliver.sang@intel.com>
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
Subject: Re: [linus:master] [mseal] 8be7258aad:
 stress-ng.pagemove.page_remaps_per_sec -4.4% regression
Message-ID: <ZrF/9+Z/h7wlLub4@xsang-OptiPlex-9020>
References: <202408041602.caa0372-oliver.sang@intel.com>
 <CABi2SkWco0svzUqCK8OsTmivXTvoWUHrE6AJxpm=NaT2uMb=WA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABi2SkWco0svzUqCK8OsTmivXTvoWUHrE6AJxpm=NaT2uMb=WA@mail.gmail.com>
X-ClientProxiedBy: SG2PR02CA0138.apcprd02.prod.outlook.com
 (2603:1096:4:188::12) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|PH7PR11MB6329:EE_
X-MS-Office365-Filtering-Correlation-Id: d984c979-69aa-41b7-0548-08dcb5b955b2
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aDNMZlE0VXdmeUdMdk1yVytaeDlZeG9WbDV1aXgyUzV0V2Z3a0pPbFRRbWY0?=
 =?utf-8?B?Y1AzWEhQNUZSTDZrNGNuME5ta0VOOEFLU3Z2bmVMa3BweHRyNGcrbEVPcyts?=
 =?utf-8?B?c2ppcGQ0NjcxQWI1OVRqOGlEV1NoeW9mSVFZUE4rQW51RFZ3Q3NNK1QrS1Zw?=
 =?utf-8?B?WTlRdkNmRlZaMC95aHBQVGxISi9LK3FRV3o0a1NBUGhXbTVlZzhWV0pBS0Rw?=
 =?utf-8?B?NFQxWXExWHVUQ2hJY3ZQU1pTNTFjNjloM1pwREloZ0tvMi9aRzdkQTJCb29h?=
 =?utf-8?B?ejVlVUdlM09lN1hFa1VCcTVXcVpjL0ZTVmRMbHIzaHE5YXBrSmdYLzNJU0kw?=
 =?utf-8?B?ZFlhSHRmUS9DWUNxU3lSaDdTMXZVaDJCU2NBbVBtTkVpcXREcDFlbmNTcUd1?=
 =?utf-8?B?dEprZ0FUYW5EVm1zUkFjVDdkK3RUMCtaQWRsakdZZXJKMWtDUmFYbmduQXVw?=
 =?utf-8?B?NlJneC9wM3h0MjJ4UU9PeW00blNyMjJ6VjM3dEJEMU5KUTIwYXhMVXN0dEZx?=
 =?utf-8?B?VE9mSVVFeEdOY2tOS1pIelVtR1E4c284bFUvc3dCaDFJK1ZzZXNOVW5QbFBZ?=
 =?utf-8?B?b1BBOVI4UjRSSk5zRm5yeVJoa0VDTmlFMGszTWNrdit4MWtnSUlzTi9ETWtB?=
 =?utf-8?B?WXY2QlJSMTB0Rk1IQkpZbW41WjB3aGNCWEhlK3RIc3p3WE1jeTNKdWl2cjIx?=
 =?utf-8?B?Nk16anhaVzFlRFBFOXF6RTI4ZjBCR1ZqejkvWG9jV0ZsY1JiYXQvMGhTYlAr?=
 =?utf-8?B?cjhQTVJCcW0wN3JZN2FOamhYdjR0UXhGZEsrUGhZZ2dIdTNOWG8vMXY5T1BN?=
 =?utf-8?B?UE5zRlJ4dC83RHdiU3NOSjVCZHR5OTc5Y0JDdDhNWU04enZ6djQ4SWdObUg3?=
 =?utf-8?B?WlBtMEZhTVNXMGVTdGhYLytyQk5WL2trOXZudTdlOURWODhBSEliQ0x2M0VM?=
 =?utf-8?B?YlBOdHh0TVlkMGZ2MzVHaW1xN2xUK0Rya2RndU9vU3l5eVM1YVFoYkZZM2lh?=
 =?utf-8?B?NitvQVRyMnFTcnQzSTJMelQ5dWUyQVBUVGRUbDFIcUVMK2JLVjlmaUpkT0p6?=
 =?utf-8?B?NzkwejFrMWI0dVNWbDU3K2d2eFEzdzJLL1ZrMURieDJ0NkppNUYxTTFZbHFO?=
 =?utf-8?B?c1pHZXMwcmV1WWdKdkZ1RTlIbWpOS1lGWndWcC9zdTVGMllsQ1BhNzF2bGJI?=
 =?utf-8?B?aUhERVhEdDVEUmVwdXpUeitqRnF1N0lMWW9Ddk5Xa09MV2lCeE9qbTA0OHJh?=
 =?utf-8?B?OUlPNExrTGdHOHE0TDBzOWFCU3owWkI3Y0pKRk5ML2N5TStsam5HMmVmVGEw?=
 =?utf-8?B?S1ZoYloyNnFqT0ZoSkNXam5BeEtVUnJOYi90ZHo5WnBTZ0hEUll6UkhhRjYz?=
 =?utf-8?B?c3hxeitjOTdPbEhHWmpZQjZsSC9zbnQxd0FTZkd2N1pHaitjbllSb2NVYnMv?=
 =?utf-8?B?Wkc1ZjFhTWtyb2NydkliUmpSVnlQbE14SjVTZ3A4UXVyRVJCZVdzK0FkMHEw?=
 =?utf-8?B?alhiZ1lYS2dnUnZXVE9MNkNuZ24rUlpUVDlyUmJYdmJQVStnaE8wN2dOQkN4?=
 =?utf-8?B?OEtqekZ3ZmRybnoxR1ZMa2xReWJmajRJODVBRVdJaktlaHhLTmlWYW53ZXJE?=
 =?utf-8?B?ZEx2bmNZSzFSYzZ1VFJ1bXRkUE9QeERmZlFLSW8zelFBS2EwaEljTHc1Zm1s?=
 =?utf-8?B?RDNrYVQzMjJSSVZDWHU4STJUMkF4bWZBOUpzZ285NVZpRjhCVFdKUHdEUVpV?=
 =?utf-8?Q?YG8Pa47t7wHjLBgaPZSEjKnXFw8ExE9FEZw2F1s?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Ny92ampNZ2s3T3hNOXNKNUwzUkkxV0VMeVFnaG96ejRXTUo5OXl6TWlwdC95?=
 =?utf-8?B?cFZTR2hLZ3IrVmZEVDZWVFhkVG5xcHZLQTUzL0M5Vm1EN1ppOW5TTVZFVFhC?=
 =?utf-8?B?ODZ5RzJ5K0lwYk5rR1I0V1lUNjl4Q2pXR2N0b25HNEpoTEFzV0dOSlpmSG9Y?=
 =?utf-8?B?Z2hBeEVEbU5pVS9RZzVjU3FyK2VXSWVqanRMSW9zeHp4VmtDbGlmRCtWN0hH?=
 =?utf-8?B?OUZuTlRRVzBoYzAwUDh2QXFBYXU0N2xDZlhOV05zVW1aR2pVMDZuOWE3OXpS?=
 =?utf-8?B?emNIZWpWMG4wYnRHRnNxSlhXZmZZVjJKcjQ0ejM2L1lFR3VWd3l6NEIrWXFq?=
 =?utf-8?B?SGhqK1hBeEtLdWFNenZjWEJ0bHVUdVE0MHNFQ0lHRXgva2dlMnc3eG9oRGlU?=
 =?utf-8?B?NHZORHFHeEhCczcvWThRVFI3VXZCMXBrTHJ6NmJabmVtaVBTemk0c0U5K0hW?=
 =?utf-8?B?RnBUVExodTFMQm5NSUQ3dFhMeSsvWVJMVDgyYk1IdU15VDlFbThtTm9vZGJE?=
 =?utf-8?B?ZDhvUW1PY3VsZTByS04rRTdXTXBmYVBHdmVtd2tFcXp3a2x6ZWdMU25XZzk4?=
 =?utf-8?B?MnpEQmx3dWJWUTBOMGYrSGtJYnkwdHkwTWd5RHM2MjZGRkM4SkJzcmN0WnIv?=
 =?utf-8?B?eXFoT2JwN3V0cFljdTdCaXFWMEFab3Q2QkRuUVh6RmpncVdxVWxKY1hEdnVs?=
 =?utf-8?B?dEVYSmI3QlZ5QkxYZlNSdTY4UVZZWnBrd2t2c1NWOFM2eWhkTDM0ZWpZbm5Q?=
 =?utf-8?B?WEZpdks3L0FrTk5HdkpONzlqdkQxbk5KMjJOM1h4QzdCRjZ0dTRHcVJRZnM3?=
 =?utf-8?B?WVovSlVBTTdrSWgwU2hYU2FFWElSeFNJY3c0SVNFY2NiZG5USFRKVVh0V054?=
 =?utf-8?B?bHEzYTZ1bVRVbXVFTEhhbnZSaXp5NHpyV25BQ01VR3hEblZlQnZWbVRMVnRh?=
 =?utf-8?B?Yndqd2NDb3ZWMEFZdHRHTVA0cUYyQU1UVnIzTkxFaTBvejBUS0hJOUhrVnF0?=
 =?utf-8?B?V1duSW5pd2xISlo3bGorQVhtSkVCUGNrVFh2UnVPMGIvUGw5b3Z4ZzM3Z01U?=
 =?utf-8?B?V1FUTVNVTGVqRWdzTFg5L3ZGaTNYSTVOWVlUanM4bFg2UUs0bm93QXpwNHVC?=
 =?utf-8?B?VW5NeHRzOUJmMERmSFlNSGpVVjkyRDdTaXBTcHBHRlhST0l2SytNMHRDcSt1?=
 =?utf-8?B?cDNxOE1FTkFjbms0MWRMY2R3T2poUE1WWG9JVzUxZXZlZ0d1LzFWSnFTRjha?=
 =?utf-8?B?UTU2dXFJTlFjUFNoOWRaQW9BOWMxRHFObitEZG5aRHFxZzZ2cC8rTGVWNGV1?=
 =?utf-8?B?UjVjT3lxUDN0a0tjVEZvS0hNYU05dEd4L0VQUTZ0Q1EwNjJsSVUrdFo3RWZh?=
 =?utf-8?B?ak44TVd4RitVdktQcWRNdTRLMTBYV0syUSsyd1JlTUlSa1pYK1B2NWJWakNr?=
 =?utf-8?B?Z3lXa3VUVURpdEtMekdZVXZSbkNMUG02cjM3UjQvOHpIOE1lRTFBYnZMQzcv?=
 =?utf-8?B?cm9ublhreEgyRmRNVVg0OHhPQURMWGY2L0g1NURVaUJzcmRrdlAyYnV5Q21z?=
 =?utf-8?B?SkV3RlRpT2dBYU8zOHo2QnMySUJMWDZVejdaTFlEWi9IV3huYnpGcmR5ZkZV?=
 =?utf-8?B?MGxSZjhDWEJac2NuZmJ0Q085Yzd0aHFSNmpTWEJya0l2VFBnMTZHZWtRTXJR?=
 =?utf-8?B?L3hhRzJZaThsYXhCQTdWQ0Fzd1R6cWRxbEFLODRoU0dpOG5sTGFkbEduT1ZP?=
 =?utf-8?B?WjdwTGxObmZuV3NFUEZnOGJLWmlXaXg0cGRXdFVkMzNxRE82ZXkrOGRsOEdh?=
 =?utf-8?B?M3V1Mys0bGtsem9iOE1URkZWWHhQSE8rRUcwSWx2Q1FveVhobitCaFFpMVk2?=
 =?utf-8?B?UDJSYnI1cm9JVVhwcnAwRWl0QlZrZmlnaXAydVVxbUpxWUVadGU0RjVIMzBx?=
 =?utf-8?B?aWJNWCtUb29nak1VbGREdzI1WXpIblR6cmErUjVFd2pTUU1KT2o5WGRYTEc5?=
 =?utf-8?B?Ym4rVENQcmJndmM0UFc3VlczS2h4c3k1UnJtVDBNRUZPWnRHMmx2dGRUbzAw?=
 =?utf-8?B?eFA3SXJ4dzVkL2lSeE9XQUlzSU1lNHRCaFVRQlBCRVhVOWVEMkdVN2JSbVhC?=
 =?utf-8?B?bFFnd1M3WHowN3R2ajJYTVpyVU5jcGJ2YUZGQTZsd21wT3pvYUVwcU02STRp?=
 =?utf-8?B?b3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d984c979-69aa-41b7-0548-08dcb5b955b2
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2024 01:44:39.4878
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sc2KRVW6sprHZ88GqSme8SEItzuO8pT1JtOhp2i9rB7gkHD+RjngGcPnLcUV54VzE8Lh6cfUTYrwlmW54JLsPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6329
X-OriginatorOrg: intel.com

hi, Jeff,

On Mon, Aug 05, 2024 at 09:58:33AM -0700, Jeff Xu wrote:
> On Sun, Aug 4, 2024 at 1:59 AM kernel test robot <oliver.sang@intel.com> wrote:
> >
> >
> >
> > Hello,
> >
> > kernel test robot noticed a -4.4% regression of stress-ng.pagemove.page_remaps_per_sec on:
> >
> >
> > commit: 8be7258aad44b5e25977a98db136f677fa6f4370 ("mseal: add mseal syscall")
> > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> >
> > testcase: stress-ng
> > test machine: 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory
> > parameters:
> >
> >         nr_threads: 100%
> >         testtime: 60s
> >         test: pagemove
> >         cpufreq_governor: performance
> >
> >
> > In addition to that, the commit also has significant impact on the following tests:
> >
> > +------------------+---------------------------------------------------------------------------------------------+
> > | testcase: change | stress-ng: stress-ng.pkey.ops_per_sec -3.6% regression                                      |
> > | test machine     | 224 threads 2 sockets Intel(R) Xeon(R) Platinum 8480CTDX (Sapphire Rapids) with 256G memory |
> > | test parameters  | cpufreq_governor=performance                                                                |
> > |                  | nr_threads=100%                                                                             |
> > |                  | test=pkey                                                                                   |
> > |                  | testtime=60s                                                                                |
> > +------------------+---------------------------------------------------------------------------------------------+
> >
> >
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <oliver.sang@intel.com>
> > | Closes: https://lore.kernel.org/oe-lkp/202408041602.caa0372-oliver.sang@intel.com
> >
> >
> > Details are as below:
> > -------------------------------------------------------------------------------------------------->
> >
> >
> > The kernel config and materials to reproduce are available at:
> > https://download.01.org/0day-ci/archive/20240804/202408041602.caa0372-oliver.sang@intel.com
> >
> There is an error when I try to reproduce the test:

what's your os? we support some distributions
https://github.com/intel/lkp-tests?tab=readme-ov-file#supported-distributions

> 
> bin/lkp install job.yaml
> 
> --------------------------------------------------------
> Some packages could not be installed. This may mean that you have
> requested an impossible situation or if you are using the unstable
> distribution that some required packages have not yet been created
> or been moved out of Incoming.
> The following information may help to resolve the situation:
> 
> The following packages have unmet dependencies:
>  libdw1 : Depends: libelf1 (= 0.190-1+b1)
>  libdw1t64 : Breaks: libdw1 (< 0.191-2)
> E: Unable to correct problems, you have held broken packages.
> Cannot install some packages of perf-c2c depends
> -----------------------------------------------------------------------------------------
> 
> And where is stress-ng.pagemove.page_remaps_per_sec test implemented,
> is that part of lkp-tests ?

stress-ng is in https://github.com/ColinIanKing/stress-ng

> 
> Thanks
> -Jeff
> 
> > =========================================================================================
> > compiler/cpufreq_governor/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
> >   gcc-13/performance/x86_64-rhel-8.3/100%/debian-12-x86_64-20240206.cgz/lkp-icl-2sp7/pagemove/stress-ng/60s
> >
> > commit:
> >   ff388fe5c4 ("mseal: wire up mseal syscall")
> >   8be7258aad ("mseal: add mseal syscall")
> >
> > ff388fe5c481d39c 8be7258aad44b5e25977a98db13
> > ---------------- ---------------------------
> >          %stddev     %change         %stddev
> >              \          |                \
> >   41625945            -4.3%   39842322        proc-vmstat.numa_hit
> >   41559175            -4.3%   39774160        proc-vmstat.numa_local
> >   77484314            -4.4%   74105555        proc-vmstat.pgalloc_normal
> >   77205752            -4.4%   73826672        proc-vmstat.pgfree
> >   18361466            -4.2%   17596652        stress-ng.pagemove.ops
> >     306014            -4.2%     293262        stress-ng.pagemove.ops_per_sec
> >     205312            -4.4%     196176        stress-ng.pagemove.page_remaps_per_sec
> >       4961            +1.0%       5013        stress-ng.time.percent_of_cpu_this_job_got
> >       2917            +1.2%       2952        stress-ng.time.system_time
> >       1.07            -6.6%       1.00        perf-stat.i.MPKI
> >  3.354e+10            +3.5%  3.473e+10        perf-stat.i.branch-instructions
> >  1.795e+08            -4.2%  1.719e+08        perf-stat.i.cache-misses
> >  2.376e+08            -4.1%  2.279e+08        perf-stat.i.cache-references
> >       1.13            -3.0%       1.10        perf-stat.i.cpi
> >       1077            +4.3%       1124        perf-stat.i.cycles-between-cache-misses
> >  1.717e+11            +2.7%  1.762e+11        perf-stat.i.instructions
> >       0.88            +3.1%       0.91        perf-stat.i.ipc
> >       1.05            -6.8%       0.97        perf-stat.overall.MPKI
> >       0.25 ą  2%      -0.0        0.24        perf-stat.overall.branch-miss-rate%
> >       1.13            -3.0%       1.10        perf-stat.overall.cpi
> >       1084            +4.0%       1127        perf-stat.overall.cycles-between-cache-misses
> >       0.88            +3.1%       0.91        perf-stat.overall.ipc
> >  3.298e+10            +3.5%  3.415e+10        perf-stat.ps.branch-instructions
> >  1.764e+08            -4.3%  1.689e+08        perf-stat.ps.cache-misses
> >  2.336e+08            -4.1%   2.24e+08        perf-stat.ps.cache-references
> >     194.57            -2.4%     189.96 ą  2%  perf-stat.ps.cpu-migrations
> >  1.688e+11            +2.7%  1.733e+11        perf-stat.ps.instructions
> >  1.036e+13            +3.0%  1.068e+13        perf-stat.total.instructions
> >      75.12            -1.9       73.22        perf-profile.calltrace.cycles-pp.move_vma.__do_sys_mremap.do_syscall_64.entry_SYSCALL_64_after_hwframe.mremap
> >      36.84            -1.6       35.29        perf-profile.calltrace.cycles-pp.do_vmi_align_munmap.do_vmi_munmap.move_vma.__do_sys_mremap.do_syscall_64
> >      24.90            -1.2       23.72        perf-profile.calltrace.cycles-pp.copy_vma.move_vma.__do_sys_mremap.do_syscall_64.entry_SYSCALL_64_after_hwframe
> >      19.89            -0.9       18.98        perf-profile.calltrace.cycles-pp.__split_vma.do_vmi_align_munmap.do_vmi_munmap.move_vma.__do_sys_mremap
> >      10.56 ą  2%      -0.8        9.78 ą  2%  perf-profile.calltrace.cycles-pp.rcu_core.handle_softirqs.run_ksoftirqd.smpboot_thread_fn.kthread
> >      10.56 ą  2%      -0.8        9.79 ą  2%  perf-profile.calltrace.cycles-pp.handle_softirqs.run_ksoftirqd.smpboot_thread_fn.kthread.ret_from_fork
> >      10.56 ą  2%      -0.8        9.79 ą  2%  perf-profile.calltrace.cycles-pp.run_ksoftirqd.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
> >      10.57 ą  2%      -0.8        9.80 ą  2%  perf-profile.calltrace.cycles-pp.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
> >      10.52 ą  2%      -0.8        9.75 ą  2%  perf-profile.calltrace.cycles-pp.rcu_do_batch.rcu_core.handle_softirqs.run_ksoftirqd.smpboot_thread_fn
> >      10.62 ą  2%      -0.8        9.85 ą  2%  perf-profile.calltrace.cycles-pp.kthread.ret_from_fork.ret_from_fork_asm
> >      10.62 ą  2%      -0.8        9.85 ą  2%  perf-profile.calltrace.cycles-pp.ret_from_fork.ret_from_fork_asm
> >      10.62 ą  2%      -0.8        9.85 ą  2%  perf-profile.calltrace.cycles-pp.ret_from_fork_asm
> >      14.75            -0.7       14.07        perf-profile.calltrace.cycles-pp.vma_merge.copy_vma.move_vma.__do_sys_mremap.do_syscall_64
> >       1.50            -0.6        0.94        perf-profile.calltrace.cycles-pp.mas_find.do_vmi_munmap.move_vma.__do_sys_mremap.do_syscall_64
> >       5.88 ą  2%      -0.4        5.47 ą  2%  perf-profile.calltrace.cycles-pp.kmem_cache_free.rcu_do_batch.rcu_core.handle_softirqs.run_ksoftirqd
> >       7.80            -0.3        7.47        perf-profile.calltrace.cycles-pp.move_page_tables.move_vma.__do_sys_mremap.do_syscall_64.entry_SYSCALL_64_after_hwframe
> >       4.55 ą  2%      -0.3        4.24 ą  2%  perf-profile.calltrace.cycles-pp.__slab_free.kmem_cache_free.rcu_do_batch.rcu_core.handle_softirqs
> >       6.76            -0.3        6.45        perf-profile.calltrace.cycles-pp.vm_area_dup.__split_vma.do_vmi_align_munmap.do_vmi_munmap.move_vma
> >       6.15            -0.3        5.86        perf-profile.calltrace.cycles-pp.kmem_cache_alloc_noprof.vm_area_dup.__split_vma.do_vmi_align_munmap.do_vmi_munmap
> >       8.22            -0.3        7.93        perf-profile.calltrace.cycles-pp.unmap_region.do_vmi_align_munmap.do_vmi_munmap.move_vma.__do_sys_mremap
> >       6.12            -0.3        5.87        perf-profile.calltrace.cycles-pp.vma_complete.__split_vma.do_vmi_align_munmap.do_vmi_munmap.move_vma
> >       5.74            -0.2        5.50        perf-profile.calltrace.cycles-pp.move_ptes.move_page_tables.move_vma.__do_sys_mremap.do_syscall_64
> >       3.16 ą  2%      -0.2        2.94        perf-profile.calltrace.cycles-pp.vm_area_free_rcu_cb.rcu_do_batch.rcu_core.handle_softirqs.run_ksoftirqd
> >       5.50            -0.2        5.28        perf-profile.calltrace.cycles-pp.mas_store_prealloc.vma_complete.__split_vma.do_vmi_align_munmap.do_vmi_munmap
> >       1.36            -0.2        1.14        perf-profile.calltrace.cycles-pp.mas_find.do_vmi_munmap.do_munmap.mremap_to.__do_sys_mremap
> >       5.15            -0.2        4.94        perf-profile.calltrace.cycles-pp.mas_wr_store_entry.mas_store_prealloc.vma_complete.__split_vma.do_vmi_align_munmap
> >       5.51            -0.2        5.31        perf-profile.calltrace.cycles-pp.mas_store_prealloc.vma_merge.copy_vma.move_vma.__do_sys_mremap
> >       5.16            -0.2        4.97        perf-profile.calltrace.cycles-pp.mas_wr_store_entry.mas_store_prealloc.vma_merge.copy_vma.move_vma
> >       2.24            -0.2        2.05        perf-profile.calltrace.cycles-pp.find_vma_prev.copy_vma.move_vma.__do_sys_mremap.do_syscall_64
> >       2.60 ą  2%      -0.2        2.42 ą  2%  perf-profile.calltrace.cycles-pp.kmem_cache_free.vm_area_free_rcu_cb.rcu_do_batch.rcu_core.handle_softirqs
> >       4.67            -0.2        4.49        perf-profile.calltrace.cycles-pp.mas_wr_node_store.mas_wr_store_entry.mas_store_prealloc.vma_merge.copy_vma
> >       3.41            -0.2        3.23        perf-profile.calltrace.cycles-pp.free_pgtables.unmap_region.do_vmi_align_munmap.do_vmi_munmap.move_vma
> >       3.00            -0.2        2.83 ą  2%  perf-profile.calltrace.cycles-pp.anon_vma_clone.__split_vma.do_vmi_align_munmap.do_vmi_munmap.move_vma
> >       0.96            -0.2        0.80        perf-profile.calltrace.cycles-pp.mas_walk.mas_find.do_vmi_munmap.do_munmap.mremap_to
> >       4.04            -0.2        3.88        perf-profile.calltrace.cycles-pp.vm_area_dup.copy_vma.move_vma.__do_sys_mremap.do_syscall_64
> >       3.20 ą  2%      -0.2        3.04 ą  2%  perf-profile.calltrace.cycles-pp.__memcg_slab_post_alloc_hook.kmem_cache_alloc_noprof.vm_area_dup.__split_vma.do_vmi_align_munmap
> >       3.53            -0.1        3.38        perf-profile.calltrace.cycles-pp.kmem_cache_alloc_noprof.vm_area_dup.copy_vma.move_vma.__do_sys_mremap
> >       3.40            -0.1        3.26        perf-profile.calltrace.cycles-pp.flush_tlb_mm_range.move_ptes.move_page_tables.move_vma.__do_sys_mremap
> >       2.20 ą  2%      -0.1        2.06 ą  2%  perf-profile.calltrace.cycles-pp.kmem_cache_alloc_noprof.anon_vma_clone.__split_vma.do_vmi_align_munmap.do_vmi_munmap
> >       1.84 ą  3%      -0.1        1.71 ą  3%  perf-profile.calltrace.cycles-pp.__memcg_slab_post_alloc_hook.kmem_cache_alloc_noprof.anon_vma_clone.__split_vma.do_vmi_align_munmap
> >       1.78 ą  2%      -0.1        1.65 ą  3%  perf-profile.calltrace.cycles-pp.vma_prepare.vma_merge.copy_vma.move_vma.__do_sys_mremap
> >       2.69            -0.1        2.56        perf-profile.calltrace.cycles-pp.unlink_anon_vmas.free_pgtables.unmap_region.do_vmi_align_munmap.do_vmi_munmap
> >       1.78 ą  2%      -0.1        1.66 ą  2%  perf-profile.calltrace.cycles-pp.__slab_free.kmem_cache_free.vm_area_free_rcu_cb.rcu_do_batch.rcu_core
> >       1.36 ą  2%      -0.1        1.23 ą  2%  perf-profile.calltrace.cycles-pp.rcu_cblist_dequeue.rcu_do_batch.rcu_core.handle_softirqs.run_ksoftirqd
> >       0.95            -0.1        0.83        perf-profile.calltrace.cycles-pp.mas_walk.mas_find.do_vmi_munmap.move_vma.__do_sys_mremap
> >       3.29            -0.1        3.17        perf-profile.calltrace.cycles-pp.mas_store_gfp.do_vmi_align_munmap.do_vmi_munmap.move_vma.__do_sys_mremap
> >       2.08            -0.1        1.96        perf-profile.calltrace.cycles-pp.mas_preallocate.vma_merge.copy_vma.move_vma.__do_sys_mremap
> >       1.43 ą  3%      -0.1        1.32 ą  3%  perf-profile.calltrace.cycles-pp.down_write.vma_prepare.vma_merge.copy_vma.move_vma
> >       2.21            -0.1        2.10        perf-profile.calltrace.cycles-pp.mas_preallocate.__split_vma.do_vmi_align_munmap.do_vmi_munmap.move_vma
> >       2.47            -0.1        2.36        perf-profile.calltrace.cycles-pp.flush_tlb_func.flush_tlb_mm_range.move_ptes.move_page_tables.move_vma
> >       2.21            -0.1        2.12        perf-profile.calltrace.cycles-pp.native_flush_tlb_one_user.flush_tlb_func.flush_tlb_mm_range.move_ptes.move_page_tables
> >       1.41            -0.1        1.32        perf-profile.calltrace.cycles-pp.mas_alloc_nodes.mas_preallocate.__split_vma.do_vmi_align_munmap.do_vmi_munmap
> >       1.26            -0.1        1.18        perf-profile.calltrace.cycles-pp.kmem_cache_alloc_noprof.mas_alloc_nodes.mas_preallocate.__split_vma.do_vmi_align_munmap
> >       1.82            -0.1        1.75        perf-profile.calltrace.cycles-pp.vma_link.copy_vma.move_vma.__do_sys_mremap.do_syscall_64
> >       0.71            -0.1        0.63        perf-profile.calltrace.cycles-pp.mas_prev.vma_merge.copy_vma.move_vma.__do_sys_mremap
> >       1.29            -0.1        1.22        perf-profile.calltrace.cycles-pp.mas_wr_store_entry.mas_store_gfp.do_vmi_align_munmap.do_vmi_munmap.move_vma
> >       0.61            -0.1        0.54        perf-profile.calltrace.cycles-pp.mas_prev_setup.mas_prev.vma_merge.copy_vma.move_vma
> >       1.36            -0.1        1.29        perf-profile.calltrace.cycles-pp.kmem_cache_free.unlink_anon_vmas.free_pgtables.unmap_region.do_vmi_align_munmap
> >       1.40            -0.1        1.33        perf-profile.calltrace.cycles-pp.mas_alloc_nodes.mas_preallocate.vma_merge.copy_vma.move_vma
> >       0.70            -0.1        0.64        perf-profile.calltrace.cycles-pp.mas_walk.find_vma_prev.copy_vma.move_vma.__do_sys_mremap
> >       1.23            -0.1        1.17        perf-profile.calltrace.cycles-pp.kmem_cache_alloc_noprof.mas_alloc_nodes.mas_preallocate.vma_merge.copy_vma
> >       1.66            -0.1        1.60        perf-profile.calltrace.cycles-pp.__get_unmapped_area.mremap_to.__do_sys_mremap.do_syscall_64.entry_SYSCALL_64_after_hwframe
> >       1.16            -0.1        1.10        perf-profile.calltrace.cycles-pp.anon_vma_clone.copy_vma.move_vma.__do_sys_mremap.do_syscall_64
> >       0.96            -0.1        0.90        perf-profile.calltrace.cycles-pp.__memcg_slab_free_hook.kmem_cache_free.unlink_anon_vmas.free_pgtables.unmap_region
> >       1.14            -0.1        1.08        perf-profile.calltrace.cycles-pp.___slab_alloc.kmem_cache_alloc_noprof.vm_area_dup.__split_vma.do_vmi_align_munmap
> >       0.79            -0.1        0.74        perf-profile.calltrace.cycles-pp.___slab_alloc.kmem_cache_alloc_noprof.mas_alloc_nodes.mas_preallocate.__split_vma
> >       1.04            -0.1        1.00        perf-profile.calltrace.cycles-pp.vma_to_resize.mremap_to.__do_sys_mremap.do_syscall_64.entry_SYSCALL_64_after_hwframe
> >       0.58            -0.0        0.53        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64.mremap
> >       0.61            -0.0        0.56        perf-profile.calltrace.cycles-pp.__memcg_slab_free_hook.kmem_cache_free.vm_area_free_rcu_cb.rcu_do_batch.rcu_core
> >       0.56            -0.0        0.52        perf-profile.calltrace.cycles-pp.mas_find.find_vma_prev.copy_vma.move_vma.__do_sys_mremap
> >       0.57            -0.0        0.53 ą  2%  perf-profile.calltrace.cycles-pp.__memcg_slab_free_hook.kmem_cache_free.rcu_do_batch.rcu_core.handle_softirqs
> >       0.78            -0.0        0.74        perf-profile.calltrace.cycles-pp.___slab_alloc.kmem_cache_alloc_noprof.mas_alloc_nodes.mas_preallocate.vma_merge
> >       0.88            -0.0        0.84        perf-profile.calltrace.cycles-pp.mtree_load.vma_to_resize.mremap_to.__do_sys_mremap.do_syscall_64
> >       0.70            -0.0        0.66        perf-profile.calltrace.cycles-pp.__call_rcu_common.do_vmi_align_munmap.do_vmi_munmap.move_vma.__do_sys_mremap
> >       0.68            -0.0        0.64        perf-profile.calltrace.cycles-pp.percpu_counter_add_batch.do_vmi_align_munmap.do_vmi_munmap.move_vma.__do_sys_mremap
> >       0.68            -0.0        0.64        perf-profile.calltrace.cycles-pp.syscall_return_via_sysret.mremap
> >       0.97            -0.0        0.93        perf-profile.calltrace.cycles-pp.mas_find.do_vmi_align_munmap.do_vmi_munmap.move_vma.__do_sys_mremap
> >       1.11            -0.0        1.08        perf-profile.calltrace.cycles-pp.clear_bhb_loop.mremap
> >       0.75            -0.0        0.72        perf-profile.calltrace.cycles-pp.allocate_slab.___slab_alloc.kmem_cache_alloc_noprof.vm_area_dup.__split_vma
> >       0.74            -0.0        0.71        perf-profile.calltrace.cycles-pp.kmem_cache_alloc_noprof.anon_vma_clone.copy_vma.move_vma.__do_sys_mremap
> >       0.60 ą  2%      -0.0        0.57        perf-profile.calltrace.cycles-pp.security_mmap_addr.__get_unmapped_area.mremap_to.__do_sys_mremap.do_syscall_64
> >       0.67 ą  2%      -0.0        0.64        perf-profile.calltrace.cycles-pp.___slab_alloc.kmem_cache_alloc_noprof.vm_area_dup.copy_vma.move_vma
> >       0.82            -0.0        0.79        perf-profile.calltrace.cycles-pp.mtree_load.__do_sys_mremap.do_syscall_64.entry_SYSCALL_64_after_hwframe.mremap
> >       0.63            -0.0        0.60        perf-profile.calltrace.cycles-pp.mas_prev_slot.do_vmi_align_munmap.do_vmi_munmap.move_vma.__do_sys_mremap
> >       0.99            -0.0        0.96        perf-profile.calltrace.cycles-pp.mt_find.vma_merge.copy_vma.move_vma.__do_sys_mremap
> >       0.62 ą  2%      -0.0        0.59        perf-profile.calltrace.cycles-pp.get_old_pud.move_page_tables.move_vma.__do_sys_mremap.do_syscall_64
> >       0.87            -0.0        0.84        perf-profile.calltrace.cycles-pp.userfaultfd_unmap_complete.__do_sys_mremap.do_syscall_64.entry_SYSCALL_64_after_hwframe.mremap
> >       0.78            -0.0        0.75        perf-profile.calltrace.cycles-pp.mas_store_prealloc.vma_link.copy_vma.move_vma.__do_sys_mremap
> >       0.64            -0.0        0.62        perf-profile.calltrace.cycles-pp.mas_preallocate.vma_link.copy_vma.move_vma.__do_sys_mremap
> >       0.90            -0.0        0.87        perf-profile.calltrace.cycles-pp.mtree_load.vma_merge.copy_vma.move_vma.__do_sys_mremap
> >       0.54            -0.0        0.52        perf-profile.calltrace.cycles-pp.__pte_offset_map_lock.move_ptes.move_page_tables.move_vma.__do_sys_mremap
> >       1.04            +0.0        1.08        perf-profile.calltrace.cycles-pp.zap_pte_range.zap_pmd_range.unmap_page_range.unmap_vmas.unmap_region
> >       0.76            +0.1        0.83        perf-profile.calltrace.cycles-pp.__madvise
> >       0.63            +0.1        0.70        perf-profile.calltrace.cycles-pp.__x64_sys_madvise.do_syscall_64.entry_SYSCALL_64_after_hwframe.__madvise
> >       0.62            +0.1        0.70        perf-profile.calltrace.cycles-pp.do_madvise.__x64_sys_madvise.do_syscall_64.entry_SYSCALL_64_after_hwframe.__madvise
> >       0.66            +0.1        0.74        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__madvise
> >       0.66            +0.1        0.74        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__madvise
> >      87.74            +0.7       88.45        perf-profile.calltrace.cycles-pp.mremap
> >       0.00            +0.9        0.86        perf-profile.calltrace.cycles-pp.mas_walk.mas_find.can_modify_mm.do_vmi_munmap.do_munmap
> >       0.00            +0.9        0.86        perf-profile.calltrace.cycles-pp.mas_walk.mas_find.can_modify_mm.mremap_to.__do_sys_mremap
> >      84.88            +0.9       85.77        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.mremap
> >      84.73            +0.9       85.62        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.mremap
> >       0.00            +0.9        0.92 ą  2%  perf-profile.calltrace.cycles-pp.mas_walk.mas_find.can_modify_mm.do_vmi_munmap.move_vma
> >      83.84            +0.9       84.78        perf-profile.calltrace.cycles-pp.__do_sys_mremap.do_syscall_64.entry_SYSCALL_64_after_hwframe.mremap
> >       0.00            +1.1        1.06        perf-profile.calltrace.cycles-pp.mas_find.can_modify_mm.mremap_to.__do_sys_mremap.do_syscall_64
> >       0.00            +1.2        1.21        perf-profile.calltrace.cycles-pp.mas_find.can_modify_mm.do_vmi_munmap.do_munmap.mremap_to
> >       2.07            +1.5        3.55        perf-profile.calltrace.cycles-pp.do_munmap.mremap_to.__do_sys_mremap.do_syscall_64.entry_SYSCALL_64_after_hwframe
> >       1.58            +1.5        3.07        perf-profile.calltrace.cycles-pp.do_vmi_munmap.do_munmap.mremap_to.__do_sys_mremap.do_syscall_64
> >       0.00            +1.5        1.52        perf-profile.calltrace.cycles-pp.mas_find.can_modify_mm.do_vmi_munmap.move_vma.__do_sys_mremap
> >       0.00            +1.6        1.57        perf-profile.calltrace.cycles-pp.can_modify_mm.mremap_to.__do_sys_mremap.do_syscall_64.entry_SYSCALL_64_after_hwframe
> >       0.00            +1.7        1.72        perf-profile.calltrace.cycles-pp.can_modify_mm.do_vmi_munmap.do_munmap.mremap_to.__do_sys_mremap
> >       0.00            +2.0        2.01        perf-profile.calltrace.cycles-pp.can_modify_mm.do_vmi_munmap.move_vma.__do_sys_mremap.do_syscall_64
> >       5.39            +2.9        8.32        perf-profile.calltrace.cycles-pp.mremap_to.__do_sys_mremap.do_syscall_64.entry_SYSCALL_64_after_hwframe.mremap
> >      75.29            -1.9       73.37        perf-profile.children.cycles-pp.move_vma
> >      37.06            -1.6       35.50        perf-profile.children.cycles-pp.do_vmi_align_munmap
> >      24.98            -1.2       23.80        perf-profile.children.cycles-pp.copy_vma
> >      19.99            -1.0       19.02        perf-profile.children.cycles-pp.handle_softirqs
> >      19.97            -1.0       19.00        perf-profile.children.cycles-pp.rcu_core
> >      19.95            -1.0       18.98        perf-profile.children.cycles-pp.rcu_do_batch
> >      19.98            -0.9       19.06        perf-profile.children.cycles-pp.__split_vma
> >      17.55            -0.8       16.76        perf-profile.children.cycles-pp.kmem_cache_free
> >      10.56 ą  2%      -0.8        9.79 ą  2%  perf-profile.children.cycles-pp.run_ksoftirqd
> >      10.57 ą  2%      -0.8        9.80 ą  2%  perf-profile.children.cycles-pp.smpboot_thread_fn
> >      15.38            -0.8       14.62        perf-profile.children.cycles-pp.kmem_cache_alloc_noprof
> >      10.62 ą  2%      -0.8        9.85 ą  2%  perf-profile.children.cycles-pp.kthread
> >      10.62 ą  2%      -0.8        9.86 ą  2%  perf-profile.children.cycles-pp.ret_from_fork
> >      10.62 ą  2%      -0.8        9.86 ą  2%  perf-profile.children.cycles-pp.ret_from_fork_asm
> >      15.14            -0.7       14.44        perf-profile.children.cycles-pp.vma_merge
> >      12.08            -0.5       11.55        perf-profile.children.cycles-pp.__slab_free
> >      12.11            -0.5       11.62        perf-profile.children.cycles-pp.mas_wr_store_entry
> >      10.86            -0.5       10.39        perf-profile.children.cycles-pp.vm_area_dup
> >      11.89            -0.5       11.44        perf-profile.children.cycles-pp.mas_store_prealloc
> >       8.49            -0.4        8.06        perf-profile.children.cycles-pp.__memcg_slab_post_alloc_hook
> >       9.88            -0.4        9.49        perf-profile.children.cycles-pp.mas_wr_node_store
> >       7.91            -0.3        7.58        perf-profile.children.cycles-pp.move_page_tables
> >       6.06            -0.3        5.78        perf-profile.children.cycles-pp.vm_area_free_rcu_cb
> >       8.28            -0.3        8.00        perf-profile.children.cycles-pp.unmap_region
> >       6.69            -0.3        6.42        perf-profile.children.cycles-pp.vma_complete
> >       5.06            -0.3        4.80        perf-profile.children.cycles-pp.mas_preallocate
> >       5.82            -0.2        5.57        perf-profile.children.cycles-pp.move_ptes
> >       4.24            -0.2        4.01        perf-profile.children.cycles-pp.anon_vma_clone
> >       3.50            -0.2        3.30        perf-profile.children.cycles-pp.down_write
> >       2.44            -0.2        2.25        perf-profile.children.cycles-pp.find_vma_prev
> >       3.46            -0.2        3.28        perf-profile.children.cycles-pp.___slab_alloc
> >       3.45            -0.2        3.27        perf-profile.children.cycles-pp.free_pgtables
> >       2.54            -0.2        2.37        perf-profile.children.cycles-pp.rcu_cblist_dequeue
> >       3.35            -0.2        3.18        perf-profile.children.cycles-pp.__memcg_slab_free_hook
> >       2.93            -0.2        2.78        perf-profile.children.cycles-pp.mas_alloc_nodes
> >       2.28 ą  2%      -0.2        2.12 ą  2%  perf-profile.children.cycles-pp.vma_prepare
> >       3.46            -0.1        3.32        perf-profile.children.cycles-pp.flush_tlb_mm_range
> >       3.41            -0.1        3.27 ą  2%  perf-profile.children.cycles-pp.mod_objcg_state
> >       2.76            -0.1        2.63        perf-profile.children.cycles-pp.unlink_anon_vmas
> >       3.41            -0.1        3.28        perf-profile.children.cycles-pp.mas_store_gfp
> >       2.21            -0.1        2.09        perf-profile.children.cycles-pp.__cond_resched
> >       2.04            -0.1        1.94        perf-profile.children.cycles-pp.allocate_slab
> >       2.10            -0.1        2.00        perf-profile.children.cycles-pp.__call_rcu_common
> >       2.51            -0.1        2.40        perf-profile.children.cycles-pp.flush_tlb_func
> >       1.04            -0.1        0.94        perf-profile.children.cycles-pp.mas_prev
> >       2.71            -0.1        2.61        perf-profile.children.cycles-pp.mtree_load
> >       2.23            -0.1        2.14        perf-profile.children.cycles-pp.native_flush_tlb_one_user
> >       0.22 ą  5%      -0.1        0.13 ą 13%  perf-profile.children.cycles-pp.vm_stat_account
> >       0.95            -0.1        0.87        perf-profile.children.cycles-pp.mas_prev_setup
> >       1.65            -0.1        1.57        perf-profile.children.cycles-pp.mas_wr_walk
> >       1.84            -0.1        1.76        perf-profile.children.cycles-pp.up_write
> >       1.27            -0.1        1.20        perf-profile.children.cycles-pp.mas_prev_slot
> >       1.84            -0.1        1.77        perf-profile.children.cycles-pp.vma_link
> >       1.39            -0.1        1.32        perf-profile.children.cycles-pp.shuffle_freelist
> >       0.96            -0.1        0.90 ą  2%  perf-profile.children.cycles-pp.rcu_all_qs
> >       0.86            -0.1        0.80        perf-profile.children.cycles-pp._raw_spin_lock_irqsave
> >       1.70            -0.1        1.64        perf-profile.children.cycles-pp.__get_unmapped_area
> >       0.34 ą  3%      -0.1        0.29 ą  5%  perf-profile.children.cycles-pp.security_vm_enough_memory_mm
> >       0.60            -0.0        0.55        perf-profile.children.cycles-pp.entry_SYSCALL_64
> >       0.92            -0.0        0.87        perf-profile.children.cycles-pp.percpu_counter_add_batch
> >       1.07            -0.0        1.02        perf-profile.children.cycles-pp.vma_to_resize
> >       1.59            -0.0        1.54        perf-profile.children.cycles-pp.mas_update_gap
> >       0.44 ą  2%      -0.0        0.40 ą  2%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
> >       0.70            -0.0        0.66        perf-profile.children.cycles-pp.syscall_return_via_sysret
> >       1.13            -0.0        1.09        perf-profile.children.cycles-pp.mt_find
> >       0.20 ą  6%      -0.0        0.17 ą  9%  perf-profile.children.cycles-pp.cap_vm_enough_memory
> >       0.99            -0.0        0.95        perf-profile.children.cycles-pp.mas_pop_node
> >       0.63 ą  2%      -0.0        0.59        perf-profile.children.cycles-pp.security_mmap_addr
> >       0.62            -0.0        0.59        perf-profile.children.cycles-pp.__put_partials
> >       1.17            -0.0        1.14        perf-profile.children.cycles-pp.clear_bhb_loop
> >       0.46            -0.0        0.43 ą  2%  perf-profile.children.cycles-pp.__alloc_pages_noprof
> >       0.44            -0.0        0.41 ą  2%  perf-profile.children.cycles-pp.get_page_from_freelist
> >       0.90            -0.0        0.87        perf-profile.children.cycles-pp.userfaultfd_unmap_complete
> >       0.64 ą  2%      -0.0        0.62        perf-profile.children.cycles-pp.get_old_pud
> >       1.07            -0.0        1.05        perf-profile.children.cycles-pp.mas_leaf_max_gap
> >       0.22 ą  3%      -0.0        0.20 ą  2%  perf-profile.children.cycles-pp.__rmqueue_pcplist
> >       0.55            -0.0        0.53        perf-profile.children.cycles-pp.refill_obj_stock
> >       0.25            -0.0        0.23 ą  3%  perf-profile.children.cycles-pp.rmqueue
> >       0.48            -0.0        0.45        perf-profile.children.cycles-pp.mremap_userfaultfd_prep
> >       0.33            -0.0        0.30        perf-profile.children.cycles-pp.free_unref_page
> >       0.46            -0.0        0.44        perf-profile.children.cycles-pp.setup_object
> >       0.21 ą  3%      -0.0        0.19 ą  2%  perf-profile.children.cycles-pp.rmqueue_bulk
> >       0.31 ą  3%      -0.0        0.29        perf-profile.children.cycles-pp.__vm_enough_memory
> >       0.40            -0.0        0.38        perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
> >       0.36            -0.0        0.35        perf-profile.children.cycles-pp.madvise_vma_behavior
> >       0.54            -0.0        0.53 ą  2%  perf-profile.children.cycles-pp.mas_wr_end_piv
> >       0.46            -0.0        0.44 ą  2%  perf-profile.children.cycles-pp.rcu_segcblist_enqueue
> >       0.34            -0.0        0.32 ą  2%  perf-profile.children.cycles-pp.mas_destroy
> >       0.28            -0.0        0.26 ą  3%  perf-profile.children.cycles-pp.mas_wr_store_setup
> >       0.30            -0.0        0.28        perf-profile.children.cycles-pp.pte_offset_map_nolock
> >       0.19            -0.0        0.18 ą  2%  perf-profile.children.cycles-pp.__thp_vma_allowable_orders
> >       0.08 ą  4%      -0.0        0.07        perf-profile.children.cycles-pp.ksm_madvise
> >       0.17            -0.0        0.16        perf-profile.children.cycles-pp.get_any_partial
> >       0.08            -0.0        0.07        perf-profile.children.cycles-pp.syscall_exit_to_user_mode_prepare
> >       0.45            +0.0        0.47        perf-profile.children.cycles-pp._raw_spin_lock
> >       1.10            +0.0        1.14        perf-profile.children.cycles-pp.zap_pte_range
> >       0.78            +0.1        0.85        perf-profile.children.cycles-pp.__madvise
> >       0.63            +0.1        0.70        perf-profile.children.cycles-pp.__x64_sys_madvise
> >       0.62            +0.1        0.70        perf-profile.children.cycles-pp.do_madvise
> >       0.00            +0.1        0.09 ą  4%  perf-profile.children.cycles-pp.can_modify_mm_madv
> >       1.32            +0.1        1.46        perf-profile.children.cycles-pp.mas_next_slot
> >      88.13            +0.7       88.83        perf-profile.children.cycles-pp.mremap
> >      83.94            +0.9       84.88        perf-profile.children.cycles-pp.__do_sys_mremap
> >      86.06            +0.9       87.00        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
> >      85.56            +1.0       86.54        perf-profile.children.cycles-pp.do_syscall_64
> >      40.49            +1.4       41.90        perf-profile.children.cycles-pp.do_vmi_munmap
> >       2.10            +1.5        3.57        perf-profile.children.cycles-pp.do_munmap
> >       3.62            +2.3        5.90        perf-profile.children.cycles-pp.mas_walk
> >       5.44            +2.9        8.38        perf-profile.children.cycles-pp.mremap_to
> >       5.30            +3.1        8.39        perf-profile.children.cycles-pp.mas_find
> >       0.00            +5.4        5.40        perf-profile.children.cycles-pp.can_modify_mm
> >      11.46            -0.5       10.96        perf-profile.self.cycles-pp.__slab_free
> >       4.30            -0.2        4.08        perf-profile.self.cycles-pp.__memcg_slab_post_alloc_hook
> >       2.51            -0.2        2.34        perf-profile.self.cycles-pp.rcu_cblist_dequeue
> >       2.41 ą  2%      -0.2        2.25        perf-profile.self.cycles-pp.down_write
> >       2.21            -0.1        2.11        perf-profile.self.cycles-pp.native_flush_tlb_one_user
> >       2.37            -0.1        2.28        perf-profile.self.cycles-pp.mtree_load
> >       1.60            -0.1        1.51        perf-profile.self.cycles-pp.__memcg_slab_free_hook
> >       0.18 ą  3%      -0.1        0.10 ą 15%  perf-profile.self.cycles-pp.vm_stat_account
> >       1.25            -0.1        1.18        perf-profile.self.cycles-pp.move_vma
> >       1.76            -0.1        1.69        perf-profile.self.cycles-pp.mod_objcg_state
> >       1.42            -0.1        1.35 ą  2%  perf-profile.self.cycles-pp.__call_rcu_common
> >       1.41            -0.1        1.34        perf-profile.self.cycles-pp.mas_wr_walk
> >       1.52            -0.1        1.46        perf-profile.self.cycles-pp.up_write
> >       1.02            -0.1        0.95        perf-profile.self.cycles-pp.mas_prev_slot
> >       0.96            -0.1        0.90 ą  2%  perf-profile.self.cycles-pp.vm_area_free_rcu_cb
> >       1.50            -0.1        1.45        perf-profile.self.cycles-pp.kmem_cache_free
> >       0.69 ą  3%      -0.1        0.64 ą  2%  perf-profile.self.cycles-pp.rcu_all_qs
> >       1.14 ą  2%      -0.1        1.09        perf-profile.self.cycles-pp.shuffle_freelist
> >       1.10            -0.1        1.05        perf-profile.self.cycles-pp.__cond_resched
> >       1.40            -0.0        1.35        perf-profile.self.cycles-pp.do_vmi_align_munmap
> >       0.99            -0.0        0.94        perf-profile.self.cycles-pp.mas_preallocate
> >       0.88            -0.0        0.83        perf-profile.self.cycles-pp.___slab_alloc
> >       0.55            -0.0        0.50        perf-profile.self.cycles-pp.mremap_to
> >       0.98            -0.0        0.93        perf-profile.self.cycles-pp.move_ptes
> >       0.78            -0.0        0.74        perf-profile.self.cycles-pp.percpu_counter_add_batch
> >       0.21 ą  2%      -0.0        0.18 ą  2%  perf-profile.self.cycles-pp.entry_SYSCALL_64
> >       0.44 ą  2%      -0.0        0.40 ą  2%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
> >       0.92            -0.0        0.89        perf-profile.self.cycles-pp.mas_store_gfp
> >       0.86            -0.0        0.82        perf-profile.self.cycles-pp.mas_pop_node
> >       0.50            -0.0        0.46        perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
> >       1.15            -0.0        1.12        perf-profile.self.cycles-pp.clear_bhb_loop
> >       1.14            -0.0        1.11        perf-profile.self.cycles-pp.vma_merge
> >       0.66            -0.0        0.63        perf-profile.self.cycles-pp.__split_vma
> >       0.16 ą  6%      -0.0        0.13 ą  7%  perf-profile.self.cycles-pp.cap_vm_enough_memory
> >       0.82            -0.0        0.79        perf-profile.self.cycles-pp.mas_wr_store_entry
> >       0.54 ą  2%      -0.0        0.52        perf-profile.self.cycles-pp.get_old_pud
> >       0.43            -0.0        0.40        perf-profile.self.cycles-pp.do_munmap
> >       0.51 ą  2%      -0.0        0.48 ą  2%  perf-profile.self.cycles-pp.security_mmap_addr
> >       0.50            -0.0        0.48        perf-profile.self.cycles-pp.refill_obj_stock
> >       0.24            -0.0        0.22        perf-profile.self.cycles-pp.mas_prev
> >       0.71            -0.0        0.69        perf-profile.self.cycles-pp.unmap_page_range
> >       0.48            -0.0        0.45        perf-profile.self.cycles-pp.find_vma_prev
> >       0.42            -0.0        0.40        perf-profile.self.cycles-pp._raw_spin_lock_irqsave
> >       0.66            -0.0        0.64        perf-profile.self.cycles-pp.mas_store_prealloc
> >       0.31            -0.0        0.29        perf-profile.self.cycles-pp.mas_prev_setup
> >       0.43            -0.0        0.41        perf-profile.self.cycles-pp.mas_wr_end_piv
> >       0.78            -0.0        0.76        perf-profile.self.cycles-pp.userfaultfd_unmap_complete
> >       0.28            -0.0        0.26 ą  2%  perf-profile.self.cycles-pp.mas_put_in_tree
> >       0.42            -0.0        0.40        perf-profile.self.cycles-pp.mremap_userfaultfd_prep
> >       0.28            -0.0        0.26        perf-profile.self.cycles-pp.free_pgtables
> >       0.39            -0.0        0.37        perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
> >       0.30 ą  2%      -0.0        0.28        perf-profile.self.cycles-pp.zap_pmd_range
> >       0.32            -0.0        0.31        perf-profile.self.cycles-pp.unmap_vmas
> >       0.21            -0.0        0.20        perf-profile.self.cycles-pp.__get_unmapped_area
> >       0.18 ą  2%      -0.0        0.17 ą  2%  perf-profile.self.cycles-pp.lru_add_drain_cpu
> >       0.06            -0.0        0.05        perf-profile.self.cycles-pp.ksm_madvise
> >       0.45            +0.0        0.46        perf-profile.self.cycles-pp.do_vmi_munmap
> >       0.37            +0.0        0.39        perf-profile.self.cycles-pp._raw_spin_lock
> >       1.06            +0.1        1.18        perf-profile.self.cycles-pp.mas_next_slot
> >       1.50            +0.5        1.97        perf-profile.self.cycles-pp.mas_find
> >       0.00            +1.4        1.35        perf-profile.self.cycles-pp.can_modify_mm
> >       3.13            +2.0        5.13        perf-profile.self.cycles-pp.mas_walk
> >
> >
> > ***************************************************************************************************
> > lkp-spr-r02: 224 threads 2 sockets Intel(R) Xeon(R) Platinum 8480CTDX (Sapphire Rapids) with 256G memory
> > =========================================================================================
> > compiler/cpufreq_governor/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
> >   gcc-13/performance/x86_64-rhel-8.3/100%/debian-12-x86_64-20240206.cgz/lkp-spr-r02/pkey/stress-ng/60s
> >
> > commit:
> >   ff388fe5c4 ("mseal: wire up mseal syscall")
> >   8be7258aad ("mseal: add mseal syscall")
> >
> > ff388fe5c481d39c 8be7258aad44b5e25977a98db13
> > ---------------- ---------------------------
> >          %stddev     %change         %stddev
> >              \          |                \
> >      10539            -2.5%      10273        vmstat.system.cs
> >       0.28 ą  5%     -20.1%       0.22 ą  7%  sched_debug.cfs_rq:/.h_nr_running.stddev
> >       1419 ą  7%     -15.3%       1202 ą  6%  sched_debug.cfs_rq:/.util_avg.max
> >       0.28 ą  6%     -18.4%       0.23 ą  8%  sched_debug.cpu.nr_running.stddev
> >  8.736e+08            -3.6%  8.423e+08        stress-ng.pkey.ops
> >   14560560            -3.6%   14038795        stress-ng.pkey.ops_per_sec
> >     770.39 ą  4%      -5.0%     732.04        stress-ng.time.user_time
> >     244657 ą  3%      +5.8%     258782 ą  3%  proc-vmstat.nr_slab_unreclaimable
> >   73133541            -2.1%   71588873        proc-vmstat.numa_hit
> >   72873579            -2.1%   71357274        proc-vmstat.numa_local
> >  1.842e+08            -2.5%  1.796e+08        proc-vmstat.pgalloc_normal
> >  1.767e+08            -2.8%  1.717e+08        proc-vmstat.pgfree
> >    1345346 ą 40%     -73.1%     362064 ą124%  numa-vmstat.node0.nr_inactive_anon
> >    1345340 ą 40%     -73.1%     362062 ą124%  numa-vmstat.node0.nr_zone_inactive_anon
> >    2420830 ą 14%     +35.1%    3270248 ą 16%  numa-vmstat.node1.nr_file_pages
> >    2067871 ą 13%     +51.5%    3132982 ą 17%  numa-vmstat.node1.nr_inactive_anon
> >     191406 ą 17%     +33.6%     255808 ą 14%  numa-vmstat.node1.nr_mapped
> >       2452 ą 61%    +104.4%       5012 ą 35%  numa-vmstat.node1.nr_page_table_pages
> >    2067853 ą 13%     +51.5%    3132966 ą 17%  numa-vmstat.node1.nr_zone_inactive_anon
> >    5379238 ą 40%     -73.0%    1453605 ą123%  numa-meminfo.node0.Inactive
> >    5379166 ą 40%     -73.0%    1453462 ą123%  numa-meminfo.node0.Inactive(anon)
> >    8741077 ą 22%     -36.7%    5531290 ą 28%  numa-meminfo.node0.MemUsed
> >    9651902 ą 13%     +35.8%   13105318 ą 16%  numa-meminfo.node1.FilePages
> >    8239855 ą 13%     +52.4%   12556929 ą 17%  numa-meminfo.node1.Inactive
> >    8239712 ą 13%     +52.4%   12556853 ą 17%  numa-meminfo.node1.Inactive(anon)
> >     761944 ą 18%     +34.6%    1025906 ą 14%  numa-meminfo.node1.Mapped
> >   11679628 ą 11%     +31.2%   15322841 ą 14%  numa-meminfo.node1.MemUsed
> >       9874 ą 62%    +104.6%      20200 ą 36%  numa-meminfo.node1.PageTables
> >       0.74            -4.2%       0.71        perf-stat.i.MPKI
> >  1.245e+11            +2.3%  1.274e+11        perf-stat.i.branch-instructions
> >       0.37            -0.0        0.35        perf-stat.i.branch-miss-rate%
> >  4.359e+08            -2.1%  4.265e+08        perf-stat.i.branch-misses
> >  4.672e+08            -2.6%  4.548e+08        perf-stat.i.cache-misses
> >  7.276e+08            -2.7%  7.082e+08        perf-stat.i.cache-references
> >       1.00            -1.6%       0.98        perf-stat.i.cpi
> >       1364            +2.9%       1404        perf-stat.i.cycles-between-cache-misses
> >  6.392e+11            +1.7%  6.499e+11        perf-stat.i.instructions
> >       1.00            +1.6%       1.02        perf-stat.i.ipc
> >       0.74            -4.3%       0.71        perf-stat.overall.MPKI
> >       0.35            -0.0        0.33        perf-stat.overall.branch-miss-rate%
> >       1.00            -1.6%       0.99        perf-stat.overall.cpi
> >       1356            +2.9%       1395        perf-stat.overall.cycles-between-cache-misses
> >       1.00            +1.6%       1.01        perf-stat.overall.ipc
> >  1.209e+11            +1.9%  1.232e+11        perf-stat.ps.branch-instructions
> >  4.188e+08            -2.6%  4.077e+08        perf-stat.ps.branch-misses
> >  4.585e+08            -3.1%  4.441e+08        perf-stat.ps.cache-misses
> >  7.124e+08            -3.1%  6.901e+08        perf-stat.ps.cache-references
> >      10321            -2.6%      10053        perf-stat.ps.context-switches
> >
> >
> >
> >
> >
> > Disclaimer:
> > Results have been estimated based on internal Intel analysis and are provided
> > for informational purposes only. Any difference in system hardware or software
> > design or configuration may affect actual performance.
> >
> >
> > --
> > 0-DAY CI Kernel Test Service
> > https://github.com/intel/lkp-tests/wiki
> >


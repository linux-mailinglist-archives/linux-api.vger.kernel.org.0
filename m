Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81E2B6B5328
	for <lists+linux-api@lfdr.de>; Fri, 10 Mar 2023 22:45:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232103AbjCJVpi (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 10 Mar 2023 16:45:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232138AbjCJVpB (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 10 Mar 2023 16:45:01 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22C2F1314DE;
        Fri, 10 Mar 2023 13:44:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678484640; x=1710020640;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=bshkaOCebRSTioeM7LzsdGb3rduoByuHvzLRZT9AKVc=;
  b=TZa4k3UyUDTFFVs6BuRM2p9n50jJOsGkSYy3aBU13sWTyfkYCeHqH7lo
   U+4vQO8U9esLGPR9G6WUP+5c53dJSs0+nf0TvLK/tUrqZ39xLarAOfHNI
   7VDcosqXrM8oCdsohTYDyHzxs0/KMvOgErs/G2baChUZ9WFo9Vkw1FUGm
   seZmQy+bSkv0uXOZiX8DIRC/5HKCoTn1cvVLcz0APkB/Gfr2wb7GWr3f1
   cwzevthUxXxdDGBNQNmHYsr2K4xqpqdJj1Ap6HxeWuiRNVhdXFtUAnMyh
   9EYX+sxUGJqGvXEbDxHmWi53riRL8Q4TL/4lRG74FAZdBKHqfWxxQqpqU
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10645"; a="316484057"
X-IronPort-AV: E=Sophos;i="5.98,250,1673942400"; 
   d="scan'208";a="316484057"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2023 13:43:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10645"; a="923816170"
X-IronPort-AV: E=Sophos;i="5.98,250,1673942400"; 
   d="scan'208";a="923816170"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga006.fm.intel.com with ESMTP; 10 Mar 2023 13:43:08 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 10 Mar 2023 13:43:07 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Fri, 10 Mar 2023 13:43:07 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.42) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Fri, 10 Mar 2023 13:43:07 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nlSamYmlMsy1hd1RPFAsZQOtCj9GYXAsb28T0ogzV55VYYcvPPA3xcQ5/jnp3cRSNolthWbo5UW/J8yRZ8Ewww+DfTvSml0CHPESBcjaYKSIUknMcG5SH3JD+vHWGt098NHy5nYjWmtwSinSvDYOvqUXLds/EHFfpD73pu93RFeFn9LFX7ahGuy+zBRDY+sW8wBrvJlhLfw+rBiaUZeN7RyO5hKw2jypUYuUSZnlbU2o3Pfi2bp2mKMTtQ9k0vjfLVmh/GEMzm7K5lcxRqQvdF+pMJfZfZN+okse66DNz6U3vSBzTiy1zqQ2ol6AouYuZMg3pXjj2bPuIzM5Ls1EwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bshkaOCebRSTioeM7LzsdGb3rduoByuHvzLRZT9AKVc=;
 b=jRqmk5zyRWEMi0pS55C6j76Q/UVgyKHSUiXg/h9Y+SfhxwQUCR7JXKWARNB2guZMB/op/w0PpX2U9RWK8kVLd/8rLdX9VjNWHFKR7l3N30vn0ry39QKIeE4CEQ6j4Oq9FhTIGV0D5biuO0Pqk4EtpT+Gcr/ON6itF30tWwndDf/S+asbQiNfQxsWaW7GOHm+sO7nxviH7EyCgKGrIiuRytQHwc5ClQgfynzAKEW5ZinfASpckuwjmXt1BRQBOmYEKNU/FPhVZANs2ISw8V7Iqcvk34ELMYZCgoEs4m4HFLiuZUYTvKNyWr4vXkd1uNCMGW9gANjQ4YgBk10DbkkGiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by PH8PR11MB6756.namprd11.prod.outlook.com (2603:10b6:510:1cb::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19; Fri, 10 Mar
 2023 21:43:04 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::d41f:9f07:ed56:a536]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::d41f:9f07:ed56:a536%3]) with mapi id 15.20.6178.019; Fri, 10 Mar 2023
 21:43:04 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "debug@rivosinc.com" <debug@rivosinc.com>
CC:     "david@redhat.com" <david@redhat.com>,
        "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "Eranian, Stephane" <eranian@google.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "szabolcs.nagy@arm.com" <szabolcs.nagy@arm.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "jannh@google.com" <jannh@google.com>,
        "dethoma@microsoft.com" <dethoma@microsoft.com>,
        "kcc@google.com" <kcc@google.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "bp@alien8.de" <bp@alien8.de>, "oleg@redhat.com" <oleg@redhat.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "pavel@ucw.cz" <pavel@ucw.cz>, "x86@kernel.org" <x86@kernel.org>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "Schimpe, Christina" <christina.schimpe@intel.com>,
        "al.grant@arm.com" <al.grant@arm.com>, "nd@arm.com" <nd@arm.com>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Subject: Re: [PATCH v7 33/41] x86/shstk: Introduce map_shadow_stack syscall
Thread-Topic: [PATCH v7 33/41] x86/shstk: Introduce map_shadow_stack syscall
Thread-Index: AQHZSvtF2ujwSwjQQE2i7wvNH++zdK7nwRCAgAsaUoCAAAxuAIAAGMOAgAAz4oCAAVxiAIAAC8eA
Date:   Fri, 10 Mar 2023 21:43:03 +0000
Message-ID: <fb12a7efba525bbae26113666fc4418a10ee5adf.camel@intel.com>
References: <20230227222957.24501-1-rick.p.edgecombe@intel.com>
         <20230227222957.24501-34-rick.p.edgecombe@intel.com>
         <ZADbP7HvyPHuwUY9@arm.com> <20230309185511.GA1964069@debug.ba.rivosinc.com>
         <aaf918de8585204fb0785ac1fc0f686a8fd88bb0.camel@intel.com>
         <20230309210817.GB1964069@debug.ba.rivosinc.com>
         <a3c951fee51cc05e291d3a570ed485eaec1963cf.camel@intel.com>
         <20230310210054.GA2286507@debug.ba.rivosinc.com>
In-Reply-To: <20230310210054.GA2286507@debug.ba.rivosinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|PH8PR11MB6756:EE_
x-ms-office365-filtering-correlation-id: 3478a48e-2b8b-462b-99b8-08db21b06d92
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1OcK5QLNw2od4yy3VwXQLOkXnvEWSAMBCCvNkyJCYCq2aJ2ZGoIUBnJrYBXRM3oann5i8GGqhDh62PqLoTHRiazEy9z6PQ0JmbYG3ZtrA8OC7cWTSquXdI6ZRvN4zhWY9SiTOUXHi/QVb++G9yvxqFHltrhsLuuUisusrljn4BBnsd9G4wO4vP36MJXo3H0ia+qNFgwqDwWACKXvsTQrZPq2OWeydTetv/PkuFY35VGg8fc9sDz0J9npgh3PsW18q8miIJO4pjQ6kbZXCqRYjQomD04pGMad9krHT4uw7wVGysEhSlByZm9RX9438pBbrB38BCQDCsVsGKsSqxqrtUw9qJl6s85vQycyng3Yqconf/T4gTfcXPJkn3G8WF+FFXEQczUvgq9OwgTsGrRLGoMxAorDLzjtVueJhQIOxNmZvFNcvhewMDAnKw7uXj4CDJKQlIHMF3oLns9wkStYGeQb52Sbx86hr/WsDXH7gU2o+lUdEWQVDuPpgX83wXxhdooqJWNt+eEAgLft3n8W7YIy4Hv6KPoGWLaJiCBI+0TjoU/peL+GnzgXuH3z9aAtrfYf0A4ndPJv77N8rYDYglp9wf3COMlvsa1HJa71M52siS8OoNFFJjGA/Ao8VXQtKCUwTduXJnXHkK1PttBlI23xZhneRg6P/k4HdPBYKCRwuNUVsQdMGqrKePiNDdrSS2aUxpWnh1btbZ5k77EVpnpn5eDzYDJxqNKrwti1PX2hDZrVgp1z0FN+ds+w/jrlOVjS9YfD618BMJ6QTaZUAg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(376002)(136003)(39860400002)(396003)(346002)(451199018)(66899018)(54906003)(36756003)(86362001)(38070700005)(38100700002)(6512007)(6506007)(82960400001)(122000001)(186003)(26005)(83380400001)(2616005)(316002)(5660300002)(7406005)(71200400001)(478600001)(966005)(8936002)(6486002)(7416002)(41300700001)(66476007)(4326008)(6916009)(30864003)(64756008)(2906002)(8676002)(66446008)(66946007)(66556008)(76116006)(11634003)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QllxaGlkYU5RVENRVjlJU1FKUGJwSXpaSjg2NmRHZGhhZFpuRDROY3NBTXVK?=
 =?utf-8?B?VGt4OHJMLzBJaHpZekhXak85VzhmemUvT2hhN2MvTVJZN2Q0SkZ4OE8yanBv?=
 =?utf-8?B?WUk5SWppaDR3Z3Q4NmhmQlBwcll3ZG1LZ3g0M2x3OW9BN0gzeTNBNDdTZ0lK?=
 =?utf-8?B?N2Z4TWdwUVU3TVhnZTlldjhLWmdIZGtlMXRSV1RSaHZKa3FYNFRlT2U5NGFq?=
 =?utf-8?B?Z2JCNTY0QlRraXQ1TFZyRlc5dXBOQkdUSmM0UHRxeUhkbVJOd2xjZm1NMWRw?=
 =?utf-8?B?L2ZKMC95K3dUN1hDSHI1eXp2REhmZnZwdTJXejc1V09ieEFRci80dTZGUGFW?=
 =?utf-8?B?eFZscnU1eW9YY0RaTHNIYXF0UjhMVjlhR2xJYmJZYXVEYStueW01WEc0WjJX?=
 =?utf-8?B?TGxaZHNacWNwUzAyQ0FBdDNrbkR1SHpvcE4xTmNYYUVqdGoxL3FpZWVpeDRv?=
 =?utf-8?B?ckxycG5aWHNuYy9GaXlDZm5SVmtPSnlqQTRiSHNyVm00azNmQ201QU1YWnk2?=
 =?utf-8?B?QzdHWDVVWjBOVy8xMHU1VXhJVzkyMzBLSFRJVWI1N2tldXg3dHFzMTRwRHFW?=
 =?utf-8?B?YncrUEI3ZVNIUncwZUVTbm82dGNGTlgrbGV5d2k1WTlCVFozNDZTcGhTb0Rm?=
 =?utf-8?B?bFBmb3NESjM5T0llVkNmb2tMNVpQSWhhbzJxYy9QcWdlK2pJMnREbkZOUXYy?=
 =?utf-8?B?bHVDSjV1TGNObHhvWHJqN0xQWkRKYUNKR0pTVEsvR3gwamtyOWlONnp1R0xS?=
 =?utf-8?B?VmJlckh3bnJHQktnS3JyZ0l4MzYyemVjUUxoMG1mOEVTTHEwaTh0djh4dWxr?=
 =?utf-8?B?VDNKY29aUkFjbzBGWUQ0SW1rWWdrZENwY3VXTkJLS2E0ZmlEQ1MwTXdNMWR0?=
 =?utf-8?B?d1BUOGFHNXZqUHM3SzR0aGJZY0J2VVR3WUtkTzBKQVVWMDFWRFk0U3MyY0Zq?=
 =?utf-8?B?TUttS29jMnJtbExVWGkrQXhMQUQwZXhjRy9wQW02cWEwWlVDejRxd3pZTnFm?=
 =?utf-8?B?cUp2VmIvWVlhbnJscyt3S0tsUmhYdVlOenlMY3lGc2Y4Sk55eUVxVE05OFo4?=
 =?utf-8?B?bkZVSnZoMG15UVdoTUo3ZlNNRnBYdmdDam9ZTGlWNHdXTzhydVdsbUE4L0JZ?=
 =?utf-8?B?bGpzTkw5N25JOVA0b0d0U3JGQzZkT0VGdUw1M05KTnlnOHozUDh4dXlJMFov?=
 =?utf-8?B?YUpJdmNtdTY4RlFxU05HbWNNMHA1YlBkL0VuYmdYdDlrek42K2RwWXlpaEFV?=
 =?utf-8?B?TjlPZ2Q1cWxVNS9HR2dMZy9GUVg1Mk9TNzFwWmkzbENxNW8zQllFMWFXYVNu?=
 =?utf-8?B?aDAvSjV6NnJaUDlUZXgySlpPNUVKNWRnbGRNMHZwN1MrTEo0UFBNMEpoWTl5?=
 =?utf-8?B?MW5PMkJkaE9FOEI2RVFGdDVwd2JnM1N3U1J3MlV3NzdqS29vOEw4WlJ0cXVP?=
 =?utf-8?B?cVpKUzJDSTVsbWhvK3liaDRpL2h1ejc4ZXlpeFVmYndiSmNyVkxwZmJEOFpG?=
 =?utf-8?B?NXRJVEF2NFNXZUt5VVRpaWFHV2JsK2tDYXo0VllHUGd0aE00cFZKM2sxZFAx?=
 =?utf-8?B?dFlMMURaemdRTGVHQXZOdDlKNW5KTTR0WmNaUUJQMnEzQVZ5UUVaaW9POHhq?=
 =?utf-8?B?Zjd4VUNXemF4dDJRT3cxYUo4REFUZUd6VnRjYkdTRG1jeHByT1YrUS9JZ2J6?=
 =?utf-8?B?dzRLUkJXTmZ2UCsvYVJkMzk2WmNOUTBHd1BYY2xvcElxVzlkSitNZDBhM2FM?=
 =?utf-8?B?OUZiSFdlT3o3MEdhSHhCbExFaTV3NHV3a0FvYzQ1ZWEzY1hWVzBWd3dhSFN4?=
 =?utf-8?B?bnNpcjA0d0Iva2x4TG1TbVp3TnZ3MXE5MFl3SVpVWlFhVE41TWphL3BjcWs0?=
 =?utf-8?B?clFuYTdUZUZZL0FCMTB2VUdWQ1FwdWtPdHNGVTIrcVJ1RmNmTjh5RXJkY2Ex?=
 =?utf-8?B?SHkxdmRPTnVwZDkrek1sV0ZId3VvVDBDam1va0d0VlJzSFg3UUs1S0RtVm9t?=
 =?utf-8?B?d3JkaWIyVGJDY3gzQnNuNndpcCtQTGw3d1ZqaUVlbGtzZUVXYXRWZnNWVXIr?=
 =?utf-8?B?cVcrTVVWKzRKMFdPc3RYWnN3T2NqVGluV2N5UDNSSXNyRFRwSE9QblVLbVFW?=
 =?utf-8?B?dEdadjVuMUd0RmRXR1dJWGYwaGYxWVlRdmhsSlNhTnJFZzZwR1d0RC84MnBP?=
 =?utf-8?Q?TnukgGOxsfUZS8ZIOaELj8k=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7A5BFDBE556F4E4A8DA0CC1890F772EF@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3478a48e-2b8b-462b-99b8-08db21b06d92
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2023 21:43:03.9029
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 58v/sPhDDSFiJOHZ5eCYZZKjhTmBBYFP4NoTaEsuuRVjU74Ys0x3H1oiyxQAd0wAhSxICHqtz1QdEyIUGeFOT7v610QtIjFDr87bimUejtw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6756
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

T24gRnJpLCAyMDIzLTAzLTEwIGF0IDEzOjAwIC0wODAwLCBEZWVwYWsgR3VwdGEgd3JvdGU6DQo+
IE9uIEZyaSwgTWFyIDEwLCAyMDIzIGF0IDEyOjE0OjAxQU0gKzAwMDAsIEVkZ2Vjb21iZSwgUmlj
ayBQIHdyb3RlOg0KPiA+IE9uIFRodSwgMjAyMy0wMy0wOSBhdCAxMzowOCAtMDgwMCwgRGVlcGFr
IEd1cHRhIHdyb3RlOg0KPiA+ID4gT24gVGh1LCBNYXIgMDksIDIwMjMgYXQgMDc6Mzk6NDFQTSAr
MDAwMCwgRWRnZWNvbWJlLCBSaWNrIFANCj4gPiA+IHdyb3RlOg0KPiA+ID4gPiBPbiBUaHUsIDIw
MjMtMDMtMDkgYXQgMTA6NTUgLTA4MDAsIERlZXBhayBHdXB0YSB3cm90ZToNCj4gPiA+ID4gPiBP
biBUaHUsIE1hciAwMiwgMjAyMyBhdCAwNToyMjowN1BNICswMDAwLCBTemFib2xjcyBOYWd5DQo+
ID4gPiA+ID4gd3JvdGU6DQo+ID4gPiA+ID4gPiBUaGUgMDIvMjcvMjAyMyAxNDoyOSwgUmljayBF
ZGdlY29tYmUgd3JvdGU6DQo+ID4gPiA+ID4gPiA+IFByZXZpb3VzbHksIGEgbmV3IFBST1RfU0hB
RE9XX1NUQUNLIHdhcyBhdHRlbXB0ZWQsDQo+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+IC4uLg0K
PiA+ID4gPiA+ID4gPiBTbyByYXRoZXIgdGhhbiByZXB1cnBvc2UgdHdvIGV4aXN0aW5nIHN5c2Nh
bGxzIChtbWFwLA0KPiA+ID4gPiA+ID4gPiBtYWR2aXNlKQ0KPiA+ID4gPiA+ID4gPiB0aGF0IGRv
bid0DQo+ID4gPiA+ID4gPiA+IHF1aXRlIGZpdCwganVzdCBpbXBsZW1lbnQgYSBuZXcgbWFwX3No
YWRvd19zdGFjayBzeXNjYWxsDQo+ID4gPiA+ID4gPiA+IHRvDQo+ID4gPiA+ID4gPiA+IGFsbG93
DQo+ID4gPiA+ID4gPiA+IHVzZXJzcGFjZSB0byBtYXAgYW5kIHNldHVwIG5ldyBzaGFkb3cgc3Rh
Y2tzIGluIG9uZSBzdGVwLg0KPiA+ID4gPiA+ID4gPiBXaGlsZQ0KPiA+ID4gPiA+ID4gPiB1Y29u
dGV4dA0KPiA+ID4gPiA+ID4gPiBpcyB0aGUgcHJpbWFyeSBtb3RpdmF0b3IsIHVzZXJzcGFjZSBt
YXkgaGF2ZSBvdGhlcg0KPiA+ID4gPiA+ID4gPiB1bmZvcmVzZWVuDQo+ID4gPiA+ID4gPiA+IHJl
YXNvbnMgdG8NCj4gPiA+ID4gPiA+ID4gc2V0dXAgaXQncyBvd24gc2hhZG93IHN0YWNrcyB1c2lu
ZyB0aGUgV1JTUyBpbnN0cnVjdGlvbi4NCj4gPiA+ID4gPiA+ID4gVG93YXJkcw0KPiA+ID4gPiA+
ID4gPiB0aGlzDQo+ID4gPiA+ID4gPiA+IHByb3ZpZGUgYSBmbGFnIHNvIHRoYXQgc3RhY2tzIGNh
biBiZSBvcHRpb25hbGx5IHNldHVwDQo+ID4gPiA+ID4gPiA+IHNlY3VyZWx5DQo+ID4gPiA+ID4g
PiA+IGZvciB0aGUNCj4gPiA+ID4gPiA+ID4gY29tbW9uIGNhc2Ugb2YgdWNvbnRleHQgd2l0aG91
dCBlbmFibGluZyBXUlNTLiBPcg0KPiA+ID4gPiA+ID4gPiBwb3RlbnRpYWxseQ0KPiA+ID4gPiA+
ID4gPiBoYXZlIHRoZQ0KPiA+ID4gPiA+ID4gPiBrZXJuZWwgc2V0IHVwIHRoZSBzaGFkb3cgc3Rh
Y2sgaW4gc29tZSBuZXcgd2F5Lg0KPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiAuLi4NCj4gPiA+
ID4gPiA+ID4gVGhlIGZvbGxvd2luZyBleGFtcGxlIGRlbW9uc3RyYXRlcyBob3cgdG8gY3JlYXRl
IGEgbmV3DQo+ID4gPiA+ID4gPiA+IHNoYWRvdw0KPiA+ID4gPiA+ID4gPiBzdGFjayB3aXRoDQo+
ID4gPiA+ID4gPiA+IG1hcF9zaGFkb3dfc3RhY2s6DQo+ID4gPiA+ID4gPiA+IHZvaWQgKnNoc3Rr
ID0gbWFwX3NoYWRvd19zdGFjayhhZGRyLCBzdGFja19zaXplLA0KPiA+ID4gPiA+ID4gPiBTSEFE
T1dfU1RBQ0tfU0VUX1RPS0VOKTsNCj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gaSB0aGluaw0K
PiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiBtbWFwKGFkZHIsIHNpemUsIFBST1RfUkVBRCwgTUFQ
X0FOT058TUFQX1NIQURPV19TVEFDSywgLTEsDQo+ID4gPiA+ID4gPiAwKTsNCj4gPiA+ID4gPiA+
IA0KPiA+ID4gPiA+ID4gY291bGQgZG8gdGhlIHNhbWUgd2l0aCBsZXNzIGRpc3J1cHRpb24gdG8g
dXNlcnMgKG5ldw0KPiA+ID4gPiA+ID4gc3lzY2FsbHMNCj4gPiA+ID4gPiA+IGFyZSBoYXJkZXIg
dG8gZGVhbCB3aXRoIHRoYW4gbmV3IGZsYWdzKS4gaXQgd291bGQgZG8gdGhlDQo+ID4gPiA+ID4g
PiBndWFyZCBwYWdlIGFuZCBpbml0aWFsIHRva2VuIHNldHVwIHRvbyAodGhlcmUgaXMgbm8gZmxh
Zw0KPiA+ID4gPiA+ID4gZm9yDQo+ID4gPiA+ID4gPiBpdCBidXQgY291bGQgYmUgc3F1ZWV6ZWQg
aW4pLg0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IERpc2N1c3Npb24gb24gdGhpcyB0b3BpYyBpbiB2
Ng0KPiA+ID4gPiA+IA0KPiA+ID4gPiANCj4gPiA+ID4gDQo+ID4gDQo+ID4gDQpodHRwczovL2xv
cmUua2VybmVsLm9yZy9hbGwvMjAyMzAyMjMwMDAzNDAuR0I5NDU5NjZAZGVidWcuYmEucml2b3Np
bmMuY29tLw0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IEFnYWluIEkga25vdyBlYXJsaWVyIENFVCBw
YXRjaGVzIGhhZCBwcm90ZWN0aW9uIGZsYWcgYW5kDQo+ID4gPiA+ID4gc29tZWhvdw0KPiA+ID4g
PiA+IGR1ZQ0KPiA+ID4gPiA+IHRvIHB1c2hiYWNrDQo+ID4gPiA+ID4gb24gbWFpbGluZyBsaXN0
LA0KPiA+ID4gPiA+ICBpdCB3YXMgYWRvcHRlZCB0byBnbyBmb3Igc3BlY2lhbCBzeXNjYWxsIGJl
Y2F1c2Ugbm8gb25lIGVsc2UNCj4gPiA+ID4gPiBoYWQgc2hhZG93IHN0YWNrLg0KPiA+ID4gPiA+
IA0KPiA+ID4gPiA+IFNlZWluZyBhIHJlc3BvbnNlIGZyb20gU3phYm9sY3MsIEkgYW0gYXNzdW1p
bmcgYXJtNCB3b3VsZA0KPiA+ID4gPiA+IGFsc28NCj4gPiA+ID4gPiB3YW50DQo+ID4gPiA+ID4g
dG8gZm9sbG93DQo+ID4gPiA+ID4gdXNpbmcgbW1hcCB0byBtYW51ZmFjdHVyZSBzaGFkb3cgc3Rh
Y2suIEZvciByZWZlcmVuY2UgUkZDDQo+ID4gPiA+ID4gcGF0Y2hlcw0KPiA+ID4gPiA+IGZvcg0K
PiA+ID4gPiA+IHJpc2MtdiBzaGFkb3cgc3RhY2ssDQo+ID4gPiA+ID4gdXNlIGEgbmV3IHByb3Rl
Y3Rpb24gZmxhZyA9IFBST1RfU0hBRE9XU1RBQ0suDQo+ID4gPiA+ID4gDQo+ID4gPiA+IA0KPiA+
ID4gPiANCj4gPiANCj4gPiANCmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xrbWwvMjAyMzAyMTMw
NDUzNTEuMzk0NTgyNC0xLWRlYnVnQHJpdm9zaW5jLmNvbS8NCj4gPiA+ID4gPiANCj4gPiA+ID4g
PiBJIGtub3cgZWFybGllciBkaXNjdXNzaW9uIGhhZCBiZWVuIHRoYXQgd2UgbGV0IHRoaXMgZ28g
YW5kIGRvDQo+ID4gPiA+ID4gYQ0KPiA+ID4gPiA+IHJlLQ0KPiA+ID4gPiA+IGZhY3RvciBsYXRl
ciBhcyBvdGhlcg0KPiA+ID4gPiA+IGFyY2ggc3VwcG9ydCB0cmlja2xlIGluLiBCdXQgYXMgSSB0
aG91Z2h0IG1vcmUgb24gdGhpcyBhbmQgSQ0KPiA+ID4gPiA+IHRoaW5rIGl0DQo+ID4gPiA+ID4g
bWF5IGp1c3QgYmUNCj4gPiA+ID4gPiBtZXNzeSBmcm9tIHVzZXIgbW9kZSBwb2ludCBvZiB2aWV3
IGFzIHdlbGwgdG8gaGF2ZSBjb2duaXRpb24NCj4gPiA+ID4gPiBvZg0KPiA+ID4gPiA+IHR3bw0K
PiA+ID4gPiA+IGRpZmZlcmVudCB3YXlzIG9mDQo+ID4gPiA+ID4gY3JlYXRpbmcgc2hhZG93IHN0
YWNrLiBPbmUgd291bGQgYmUgc3BlY2lhbCBzeXNjYWxsIChpbg0KPiA+ID4gPiA+IGN1cnJlbnQN
Cj4gPiA+ID4gPiBsaWJjKQ0KPiA+ID4gPiA+IGFuZCBhbm90aGVyIGBtbWFwYA0KPiA+ID4gPiA+
ICh3aGVuZXZlciBmdXR1cmUgcmUtZmFjdG9yIGhhcHBlbnMpDQo+ID4gPiA+ID4gDQo+ID4gPiA+
ID4gSWYgaXQncyBub3QgdG9vIGxhdGUsIGl0IHdvdWxkIGJlIG1vcmUgd2lzZSB0byB0YWtlIGBt
bWFwYA0KPiA+ID4gPiA+IGFwcHJvYWNoIHJhdGhlciB0aGFuIHNwZWNpYWwgYHN5c2NhbGxgIGFw
cHJvYWNoLg0KPiA+ID4gPiANCj4gPiA+ID4gVGhlcmUgaXMgc29ydCBvZiB0d28gdGhpbmdzIGlu
dGVybWl4ZWQgaGVyZSB3aGVuIHdlIHRhbGsgYWJvdXQNCj4gPiA+ID4gYQ0KPiA+ID4gPiBQUk9U
X1NIQURPV19TVEFDSy4NCj4gPiA+ID4gDQo+ID4gPiA+IE9uZSBpczogd2hhdCBpcyB0aGUgaW50
ZXJmYWNlIGZvciBzcGVjaWZ5aW5nIGhvdyB0aGUgc2hhZG93DQo+ID4gPiA+IHN0YWNrDQo+ID4g
PiA+IHNob3VsZCBiZSBwcm92aXNpb25lZCB3aXRoIGRhdGE/IFJpZ2h0IG5vdyB0aGVyZSBhcmUg
dHdvIHdheXMNCj4gPiA+ID4gc3VwcG9ydGVkLCBhbGwgemVybyBvciB3aXRoIGFuIFg4NiBzaGFk
b3cgc3RhY2sgcmVzdG9yZSB0b2tlbg0KPiA+ID4gPiBhdA0KPiA+ID4gPiB0aGUNCj4gPiA+ID4g
ZW5kLiBUaGVuIHRoZXJlIHdhcyBhbHJlYWR5IHNvbWUgY29udmVyc2F0aW9uIGFib3V0IGEgdGhp
cmQNCj4gPiA+ID4gdHlwZS4NCj4gPiA+ID4gSW4NCj4gPiA+ID4gd2hpY2ggY2FzZSB0aGUgcXVl
c3Rpb24gd291bGQgYmUgaXMgdXNpbmcgbW1hcCBNQVBfIGZsYWdzIHRoZQ0KPiA+ID4gPiByaWdo
dA0KPiA+ID4gPiBwbGFjZSBmb3IgdGhpcz8gSG93IG1hbnkgdHlwZXMgb2YgaW5pdGlhbGl6YXRp
b24gd2lsbCBiZSBuZWVkZWQNCj4gPiA+ID4gaW4NCj4gPiA+ID4gdGhlDQo+ID4gPiA+IGVuZCBh
bmQgd2hhdCBpcyB0aGUgb3ZlcmxhcCBiZXR3ZWVuIHRoZSBhcmNoaXRlY3R1cmVzPw0KPiA+ID4g
DQo+ID4gPiBGaXJzdCBvZiBhbGwsIGFyY2hlcyBjYW4gY2hvb3NlIHRvIGhhdmUgdG9rZW4gYXQg
dGhlIGJvdHRvbSBvcg0KPiA+ID4gbm90Lg0KPiA+ID4gDQo+ID4gPiBUb2tlbiBzZXJ2ZSBmb2xs
b3dpbmcgcHVycG9zZXMNCj4gPiA+ICAgLSBJdCBhbGxvd3Mgb25lIHRvIHB1dCBkZXNpcmVkIHZh
bHVlIGluIHNoYWRvdyBzdGFjayBwb2ludGVyIGluDQo+ID4gPiBzYWZlL3NlY3VyZSBtYW5uZXIu
DQo+ID4gPiAgICAgTm90ZTogeDg2IGRvZXNuJ3QgcHJvdmlkZSBhbnkgb3Bjb2RlIGVuY29kaW5n
IHRvIHZhbHVlIGluIFNTUA0KPiA+ID4gcmVnaXN0ZXIuIFNvIGhhdmluZw0KPiA+ID4gICAgIGEg
dG9rZW4gaXMga2luZCBvZiBhIG5lY2Vzc2l0eSBiZWNhdXNlIHg4NiBkb2Vzbid0IGVhc2lseQ0K
PiA+ID4gYWxsb3cNCj4gPiA+IHdyaXRpbmcgc2hhZG93IHN0YWNrLg0KPiA+ID4gDQo+ID4gPiAg
IC0gQSB0b2tlbiBhdCB0aGUgYm90dG9tIGFjdHMgbWFya2VyIC8gYmFycmllciBhbmQgY2FuIGJl
IHVzZWZ1bA0KPiA+ID4gaW4NCj4gPiA+IGRlYnVnZ2luZw0KPiA+ID4gDQo+ID4gPiAgIC0gSWYg
KGFuZCBhIGJpZyAqaWYqKSB3ZSBldmVyIHJlYWNoIGEgcG9pbnQgaW4gZnV0dXJlIHdoZXJlDQo+
ID4gPiByZXR1cm4NCj4gPiA+IGFkZHJlc3MgaXMgb25seSBwdXNoZWQNCj4gPiA+ICAgICBvbiBz
aGFkb3cgc3RhY2sgKHg4NiBzaG91bGQgaGF2ZSBtb3RpdmF0aW9uIHRvIGRvIHRoaXMNCj4gPiA+
IGJlY2F1c2UNCj4gPiA+IGxlc3MgdW9wcyBvbiBjYWxsL3JldCksDQo+ID4gPiAgICAgYSB0b2tl
biBhdCB0aGUgYm90dG9tIChib3R0b20gbWVhbnMgbG93ZXIgYWRkcmVzcykgaXMNCj4gPiA+IGVu
c3VyaW5nDQo+ID4gPiBzdXJlIHNob3Qgd2F5IG9mIGdldHRpbmcNCj4gPiA+ICAgICBhIGZhdWx0
IHdoZW4gZXhoYXVzdGVkLg0KPiA+ID4gDQo+ID4gPiBDdXJyZW50IFJJU0NWIHppc3NscGNmaSBw
cm9wb3NhbCBkb2Vzbid0IGRlZmluZSBDUFUgYmFzZWQgdG9rZW5zDQo+ID4gPiBiZWNhdXNlIGl0
J3MgUklTQy4NCj4gPiA+IEl0IGFsbG93cyBtZWNoYW5pc21zIHVzaW5nIHdoaWNoIHNvZnR3YXJl
IGNhbiBkZWZpbmUgZm9ybWF0dGluZw0KPiA+ID4gb2YNCj4gPiA+IHRva2VuIGZvciBpdHNlbGYu
DQo+ID4gPiBOb3Qgc3VyZSBvZiB3aGF0IEFSTSBpcyBkb2luZy4NCj4gPiANCj4gPiBPaywgc28g
cmlzY3YgZG9lc24ndCBuZWVkIHRvIGhhdmUgdGhlIGtlcm5lbCB3cml0ZSB0aGUgdG9rZW4sIGJ1
dA0KPiA+IHg4Ng0KPiA+IGRvZXMuDQo+ID4gDQo+ID4gPiANCj4gPiA+IE5vdyBjb21pbmcgdG8g
dGhlIHBvaW50IG9mIGFsbCB6ZXJvIHYvcyBzaGFkb3cgc3RhY2sgdG9rZW4uDQo+ID4gPiBXaHkg
bm90IGFsd2F5cyBoYXZlIHRva2VuIGF0IHRoZSBib3R0b20/DQo+ID4gDQo+ID4gV2l0aCBXUlNT
IHlvdSBjYW4gc2V0dXAgdGhlIHNoYWRvdyBzdGFjayBob3dldmVyIHlvdSB3YW50LiBTbyB0aGUN
Cj4gPiB1c2VyDQo+ID4gd291bGQgdGhlbiBoYXZlIHRvIHRha2UgY2FyZSB0byBlcmFzZSB0aGUg
dG9rZW4gaWYgdGhleSBkaWRuJ3Qgd2FudA0KPiA+IGl0Lg0KPiA+IE5vdCB0aGUgZW5kIG9mIHRo
ZSB3b3JsZCwgYnV0IGtpbmQgb2YgY2x1bmt5IGlmIHRoZXJlIGlzIG5vIHJlYXNvbg0KPiA+IGZv
cg0KPiA+IGl0Lg0KPiANCj4gWWVzIGJ1dCBrZXJuZWwgYWx3YXlzIGFzc3VtZXMgdGhlIHVzZXIg
aXMgZ29pbmcgdG8gdXNlIHRoZSB0b2tlbi4gSXQnDQo+IHVwdG8gdGhlIHVzZXINCj4gdG8gZGVj
aWRlIHdoZXRoZXIgdGhleSB3YW50IHRvIHVzZSB0aGUgcmVzdG9yZSB0b2tlbiBvciBub3QuIElm
DQo+IHRoZXkndmUgV1JTUyBjYXBhYmlsaXR5DQo+IHNlY3VyaXR5IHBvc3R1cmUgaXMgYW55d2F5
cyBkaWx1dGVkLiBBbiBhdHRhY2tlciB3aG8gd291bGQgYmUgY2xldmVyDQo+IGVub3VnaCB0bw0K
PiByZS11c2UgYFJTVE9SU1NQYCBwcmVzZW50IGluIGFkZHJlc3Mgc3BhY2UgdG8gcmVzdG9yZSB1
c2luZyBrZXJuZWwNCj4gcHJlcGFyZWQgdG9rZW4sIHNob3VsZA0KPiBhbnl3YXlzIGNhbiBiZSBj
bGV2ZXIgZW5vdWdoIHRvIHVzZSBXUlNTIGFzIHdlbGwuDQo+IA0KPiBJdCBraW5kIG9mIG1ha2Vz
IHNoYWRvdyBzdGFjayBjcmVhdGlvbiBzaW1wbGVyIGZvciBrZXJuZWwgdG8gYWx3YXlzDQo+IHBs
YWNlIHRoZSB0b2tlbi4NCj4gVGhpcyBwb2ludCBpcyBpcnJlc3BlY3RpdmUgb2Ygd2hldGhlciB0
byB1c2Ugc3lzdGVtIGNhbGwgb3IgbW1hcC4NCg0KVGhpbmsgYWJvdXQgbGlrZSBDUklVIHJlc3Rv
cmluZyB0aGUgc2hhZG93IHN0YWNrLCBvciBvdGhlciBzcGVjaWFsDQpjYXNlcyBsaWtlIHRoYXQu
IFVzZXJzcGFjZSBjYW4gYWx3YXlzIG92ZXJ3cml0ZSB0aGUgdG9rZW4sIGJ1dCB0aGlzDQppbnZv
bHZlcyBzb21lIGFtb3VudCBvZiBleHRyYSB3b3JrIChleHRyYSB3cml0ZXMsIGVhcmxpZXIgZmF1
bHRpbmcgaW4NCnRoZSBwYWdlLCBldGMpLiBJdCBpcyBjbHVua3kgYW5kIHZlcnkgbmVnbGlnaWJs
eSB3b3JzZS4NCg0KPiANCj4gPiANCj4gPiA+IA0KPiA+ID4gSW4gY2FzZSBvZiB4ODYsIFdoeSBu
ZWVkIGZvciB0d28gd2F5cyBhbmQgd2h5IG5vdCBhbHdheXMgaGF2ZSBhDQo+ID4gPiB0b2tlbg0K
PiA+ID4gYXQgdGhlIGJvdHRvbS4NCj4gPiA+IFRoZSB3YXkgeDg2IGlzIGdvaW5nLCB1c2VyIG1v
ZGUgaXMgcmVzcG9uc2libGUgZm9yIGVzdGFibGlzaGluZw0KPiA+ID4gc2hhZG93IHN0YWNrIGFu
ZCB0aHVzDQo+ID4gPiB3aGVuZXZlciBzaGFkb3cgc3RhY2sgaXMgY3JlYXRlZCB0aGVuIGlmIHg4
NiBrZXJuZWwNCj4gPiA+IGltcGxlbWVudGF0aW9uDQo+ID4gPiBhbHdheXMgcGxhY2UgYSB0b2tl
bg0KPiA+ID4gYXQgdGhlIGJhc2UvYm90dG9tLg0KPiA+IA0KPiA+IFRoZXJlIHdhcyBhbHNvIHNv
bWUgZGlzY3Vzc2lvbiByZWNlbnRseSBvZiBhZGRpbmcgYSB0b2tlbiBBTkQgYW4NCj4gPiBlbmQg
b2YNCj4gPiBzdGFjayBtYXJrZXIsIGFzIGEgcG90ZW50aWFsIHNvbHV0aW9uIGZvciBiYWNrdHJh
Y2luZyBpbiB1Y29udGV4dA0KPiA+IHN0YWNrcy4gSW4gdGhpcyBjYXNlIGl0IGNvdWxkIGNhdXNl
IGFuIEFCSSBicmVhayB0byBqdXN0IHN0YXJ0DQo+ID4gYWRkaW5nDQo+ID4gdGhlIGVuZCBvZiBz
dGFjayBtYXJrZXIgd2hlcmUgdGhlIHRva2VuIHdhcywgYW5kIHNvIHdvdWxkIHJlcXVpcmUgYQ0K
PiA+IG5ldw0KPiA+IG1hcF9zaGFkb3dfc3RhY2sgZmxhZy4NCj4gDQo+IFdhcyB0aGlzIGRpc2N1
c3NlZCB3aHkgcmVzdG9yZSB0b2tlbiBpdHNlbGYgY2FuJ3QgYmUgdXNlZCBhcyBtYXJrZXINCj4g
Zm9yDQo+IGVuZCBvZiBzdGFjayAoaWYgd2UgYXNzdW1lIHRoZXJlIGlzIGFsd2F5cyBnb2luZyB0
byBiZSBvbmUgYXQgdGhlDQo+IGJvdHRvbSkuDQo+IEl0J3MgYSB1bmlxdWUgdmFsdWUuIEFuIGFk
ZHJlc3MgcG9pbnRpbmcgdG8gaXRzZWxmLg0KDQpJIHRob3VnaHQgdGhlIHNhbWUgdGhpbmcgYXQg
Zmlyc3QsIGJ1dCBpdCBnZXRzIGNsb2JiZXJlZCBkdXJpbmcgdGhlDQpwaXZvdCBhbmQgcHVzaC4N
Cg0KPiANCj4gPiANCj4gPiA+IA0KPiA+ID4gTm93IHVzZXIgbW9kZSBjYW4gZG8gZm9sbG93aW5n
Oi0tDQo+ID4gPiAgIC0gSWYgaXQgaGFzIGFjY2VzcyB0byBXUlNTLCBpdCBjYW4gc3VyZSBnbyBh
aGVhZCBhbmQgY3JlYXRlIGENCj4gPiA+IHRva2VuDQo+ID4gPiBvZiBpdHMgY2hvb3NpbmcgYW5k
DQo+ID4gPiAgICAgb3ZlcndyaXRlIGtlcm5lbCBjcmVhdGVkIHRva2VuLiBhbmQgdGhlbiBkbyBS
U1RPUlNTUCBvbiBpdCdzDQo+ID4gPiBvd24NCj4gPiA+IGNyZWF0ZWQgdG9rZW4uDQo+ID4gPiAN
Cj4gPiA+ICAgLSBJZiBpdCBkb2Vzbid0IGhhdmUgYWNjZXNzIHRvIFdSU1MgKGFuZCBkb250IG5l
ZWQgdG8gY3JlYXRlDQo+ID4gPiBpdHMNCj4gPiA+IG93biB0b2tlbiksIGl0IGNhbiBkbw0KPiA+
ID4gICAgIFJTVE9SU1NQIG9uIHRoaXMuIEFzIHNvb24gYXMgaXQgZG9lcywgbm8gb3RoZXIgdGhy
ZWFkIGluDQo+ID4gPiBwcm9jZXNzDQo+ID4gPiBjYW4gcmVzdG9yZSB0byBpdC4NCj4gPiA+ICAg
ICBPbiBgZm9ya2AsIHlvdSBnZXQgdGhlIHNhbWUgdW4tcmVzdG9yYWJsZSB0b2tlbi4NCj4gPiA+
IA0KPiA+ID4gU28gd2h5IG5vdCBhbHdheXMgaGF2ZSBhIHRva2VuIGF0IHRoZSBib3R0b20uDQo+
ID4gPiBUaGlzIGlzIG15IHBsYW4gZm9yIHJpc2N2IGltcGxlbWVudGF0aW9uIGFzIHdlbGwgKHRv
IGhhdmUgYSB0b2tlbg0KPiA+ID4gYXQNCj4gPiA+IHRoZSBib3R0b20pDQo+ID4gPiANCj4gPiA+
ID4gDQo+ID4gPiA+IFRoZSBvdGhlciB0aGluZyBpczogc2hvdWxkIHNoYWRvdyBzdGFjayBtZW1v
cnkgY3JlYXRpb24gYmUNCj4gPiA+ID4gdGlnaHRseQ0KPiA+ID4gPiBjb250cm9sbGVkPyBGb3Ig
ZXhhbXBsZSBpbiB4ODYgd2UgbGltaXQgdGhpcyB0byBhbm9ueW1vdXMNCj4gPiA+ID4gbWVtb3J5
LA0KPiA+ID4gPiBldGMuDQo+ID4gPiA+IFNvbWUgcmVhc29ucyBmb3IgdGhpcyBhcmUgeDg2IHNw
ZWNpZmljLCBidXQgc29tZSBhcmUgbm90LiBTbyBpZg0KPiA+ID4gPiB3ZQ0KPiA+ID4gPiBkaXNh
bGxvdyBtb3N0IG9mIHRoZSBvcHRpb25zIHdoeSBhbGxvdyB0aGUgaW50ZXJmYWNlIHRvIHRha2UN
Cj4gPiA+ID4gdGhlbT8NCj4gPiA+ID4gQW5kDQo+ID4gPiA+IHRoZW4geW91IGFyZSBpbiB0aGUg
cG9zaXRpb24gb2YgY2FyZWZ1bGx5IG1haW50YWluaW5nIGEgbGlzdCBvZg0KPiA+ID4gPiBub3Qt
DQo+ID4gPiA+IGFsbG93ZWQgb3B0aW9ucyBpbnN0ZWFkIGxldHRpbmcgYSBsaXN0IG9mIGFsbG93
ZWQgb3B0aW9ucyBzaXQNCj4gPiA+ID4gdGhlcmUuDQo+ID4gPiANCj4gPiA+IEkgYW0gbmV3IHRv
IGxpbnV4IGtlcm5lbCBhbmQgdGh1cyBtYXkgYmUgbm90IGFibGUgdG8gZm9sbG93IHRoZQ0KPiA+
ID4gYXJndW1lbnQgb2YNCj4gPiA+IGxpbWl0aW5nIHRvIGFub255bW91cyBtZW1vcnkuDQo+ID4g
PiANCj4gPiA+IFdoeSBpcyBsaW1pdGluZyBpdCB0byBhbm9ueW1vdXMgbWVtb3J5IGEgcHJvYmxl
bS4gSUlSQywgQVJNJ3MNCj4gPiA+IFBST1RfTVRFIGlzIGFwcGxpY2FibGUNCj4gPiA+IG9ubHkg
dG8gYW5vbnltb3VzIG1lbW9yeS4gSSBjYW4gcHJvYmFibHkgZmluZCBmZXcgbW9yZSBleGFtcGxl
cy4NCj4gPiANCj4gPiBPaCBJIHNlZSwgdGhleSBoYXZlIGEgc3BlY2lhbCBhcmNoIFZNQSBmbGFn
IFZNX01URV9BTExPV0VEIHRoYXQNCj4gPiBvbmx5DQo+ID4gZ2V0cyBzZXQgaWYgYWxsIHRoZSBy
dWxlcyBhcmUgZm9sbG93ZWQuIFRoZW4gUFJPVF9NVEUgY2FuIG9ubHkgYmUNCj4gPiBzZXQNCj4g
PiBvbiB0aGF0IHRvIHNldCBWTV9NVEUuIFRoYXQgaXMga2luZCBvZiBuaWNlIGJlY2F1c2UgY2Vy
dGFpbiBvdGhlcg0KPiA+IHNwZWNpYWwgc2l0dWF0aW9ucyBjYW4gY2hvb3NlIHRvIHN1cHBvcnQg
aXQuDQo+IA0KPiBUaGF0J3MgYmVjYXVzZSBNVEUgaXMgZGlmZmVyZW50LiBJdCBhbGxvd3MgdG8g
YXNzaWduIHRhZ3MgdG8gZXhpc3RpbmcNCj4gdmlydHVhbCBtZW1vcnkuIFNvIG9uZSBuZWVkIHRv
IGtub3cgd2hldGhlciBhIG1lbW9yeSBjYW4gaGF2ZSB0YWdzDQo+IGFzc2lnbmVkLg0KPiANCj4g
PiANCj4gPiBJdCBkb2VzIHRha2UgYW5vdGhlciBhcmNoIHZtYSBmbGFnIHRob3VnaC4gRm9yIHg4
NiBJIGd1ZXNzIEkgd291bGQNCj4gPiBuZWVkDQo+ID4gdG8gZmlndXJlIG91dCBob3cgdG8gc3F1
ZWV6ZSBWTV9TSEFET1dfU1RBQ0sgaW50byBvdGhlciBmbGFncyB0bw0KPiA+IGhhdmUgYQ0KPiA+
IGZyZWUgZmxhZyB0byB1c2UgdGhlIHNhbWUgbWV0aG9kLiBJdCBhbHNvIG9ubHkgc3VwcG9ydHMg
bXByb3RlY3QoKQ0KPiA+IGFuZA0KPiA+IHNoYWRvdyBzdGFjayB3b3VsZCBvbmx5IHdhbnQgdG8g
c3VwcG9ydCBtbWFwKCkuIEFuZCB5b3Ugc3RpbGwgaGF2ZQ0KPiA+IHRoZQ0KPiA+IGluaXRpYWxp
emF0aW9uIHN0dWZmIHRvIHBsdW1iIHRocm91Z2guIFllYSwgSSB0aGluayB0aGUgUFJPVF9NVEUg
aXMNCj4gPiBhDQo+ID4gZ29vZCB0aGluZyB0byBjb25zaWRlciwgYnV0IGl0J3Mgbm90IHN1cGVy
IG9idmlvdXMgdG8gbWUgaG93DQo+ID4gc2ltaWxhcg0KPiA+IHRoZSBsb2dpYyB3b3VsZCBiZSBm
b3Igc2hhZG93IHN0YWNrLg0KPiANCj4gSSBkb250IHRoaW5rIHlvdSBuZWVkIGFub3RoZXIgVk1B
IGZsYWcuIE1lbW9yeSB0YWdnaW5nIGFsbG93cyBhZGRpbmcNCj4gdGFncw0KPiB0byBleGlzdGlu
ZyB2aXJ0dWFsIG1lbW9yeS4NCg0KLi4ubmVlZCBhbm90aGVyIFZNQSBmbGFnIHRvIHVzZSB0aGUg
ZXhpc3RpbmcgbW1hcCBhcmNoIGJyZWFrb3V0cyBpbiB0aGUNCnNhbWUgd2F5IGFzIFZNX01URS4g
T2YgY291cnNlIGNoYW5naW5nIG1tYXAgbWFrZXMgb3RoZXIgc29sdXRpb25zDQpwb3NzaWJsZS4N
Cg0KPiAgVGhhdCdzIHdoeSBoYXZpbmcgYG1wcm90ZWN0YCBtYWtlcyBzZW5zZSBmb3IgTVRFLg0K
PiBJbiBzaGFkb3cgc3RhY2sgY2FzZSwgdGhlcmUgaXMgbm8gcmVxdWlyZW1lbnQgb2YgY2hhbmdp
bmcgYSBzaGFkb3cNCj4gc3RhY2sNCj4gdG8gcmVndWxhciBtZW1vcnkgb3IgdmljZS12ZXJzYS4g
DQoNCnVmZmQgbmVlZHMgbXByb3RlY3QgaW50ZXJuYWxzLiBZb3UgbWlnaHQgdGFrZSBhIGxvb2sg
YXQgaXQgaW4gcmVnYXJkcw0KdG8geW91ciBWTV9XUklURS9tcHJvdGVjdCBibG9ja2luZyBhcHBy
b2FjaCBmb3IgcmlzY3YuIEkgd2FzIGltYWdpbmluZywNCmV2ZW4gaWYgbW1hcCB3YXMgdGhlIHN5
c2NhbGwsIG1wcm90ZWN0KCkgd291bGQgbm90IGJlIGJsb2NrZWQgaW4gdGhlDQp4ODYgY2FzZSBh
dCBsZWFzdC4gVGhlIG1wcm90ZWN0KCkgYmxvY2tpbmcgaXMgYSBzZXBhcmF0ZSB0aGluZyB0aGFu
IHRoZQ0Kc3lzY2FsbCwgcmlnaHQ/DQoNCj4gDQo+IEFsbCB0aGF0J3MgbmVlZGVkIHRvIGNoYW5n
ZSBpcyBgbW1hcGAuIGBtcHJvdGVjdGAgc2hvdWxkIGZhaWwuDQo+IFN5c2NhbGwNCj4gYXBwcm9h
Y2ggZ2l2ZXMgdGhhdCBiZW5lZml0IGJ5IGRlZmF1bHQgYmVjYXVzZSB0aGVyZSBpcyBubyBwcm90
ZWN0aW9uDQo+IGZsYWcNCj4gZm9yIHNoYWRvdyBzdGFjay4NCj4gDQo+IEkgd2FzIGdpdmluZyBl
eGFtcGxlIHRoYXQgYW55IGZlYXR1cmUgd2hpY2ggZ2l2ZXMgbmV3IG1lYW5pbmcgdG8NCj4gdmly
dHVhbCBtZW1vcnkNCj4gaGFzIGJlZW4gYWJsZSB0byB3b3JrIHdpdGggZXhpc3RpbmcgbWVtb3J5
IG1hcHBpbmcgQVBJcyB3aXRob3V0IHRoZQ0KPiBuZWVkIG9mIG5ldw0KPiBzeXN0ZW0gY2FsbCAo
aW5jbHVkaW5nIHdoZXRoZXIgeW91J3JlIGRlYWxpbmcgd2l0aCBhbm9ueW1vdXMgbWVtb3J5KS4N
Cj4gDQo+ID4gDQo+ID4gVGhlIHF1ZXN0aW9uIEknbSBhc2tpbmcgdGhvdWdoIGlzLCBub3QgImNh
biBtbWFwIGNvZGUgYW5kIHJ1bGVzIGJlDQo+ID4gY2hhbmdlZCB0byBlbmZvcmNlIHRoZSByZXF1
aXJlZCBsaW1pdGF0aW9ucz8iLiBJIHRoaW5rIGl0IGlzIHllcy4NCj4gPiBCdXQNCj4gPiB0aGUg
cXVlc3Rpb24gaXMgIndoeSBpcyB0aGF0IHBsdW1iaW5nIGJldHRlciB0aGFuIGEgbmV3IHN5c2Nh
bGw/Ii4NCj4gPiBJDQo+ID4gZ3Vlc3MgdG8gZ2V0IGEgYmV0dGVyIGlkZWEsIHRoZSBtbWFwIHNv
bHV0aW9uIHdvdWxkIG5lZWQgdG8gZ2V0DQo+ID4gUE9DZWQuDQo+ID4gSSBoYWQgaGFsZiBkb25l
IHRoaXMgYXQgb25lIHBvaW50LCBidXQgYWJhbmRvbmVkIHRoZSBhcHByb2FjaC4NCj4gPiANCj4g
PiBGb3IgeW91ciBxdWVzdGlvbiBhYm91dCB3aHkgbGltaXQgaXQsIHRoZSBzcGVjaWFsIHg4NiBj
YXNlIGlzIHRoZQ0KPiA+IERpcnR5PTEsV3JpdGU9MCBQVEUgYml0IGNvbWJpbmF0aW9uIGZvciBz
aGFkb3cgc3RhY2tzLiBTbyBmb3INCj4gPiBzaGFkb3cNCj4gPiBzdGFjayB5b3UgY291bGQgaGF2
ZSBzb21lIGNvbmZ1c2lvbiBhYm91dCB3aGV0aGVyIGEgUFRFIGlzIGFjdHVhbGx5DQo+ID4gZGly
dHkgZm9yIHdyaXRlYmFjaywgZXRjLiBJIHdvdWxkbid0IHNheSBpdCdzIGtub3duIHRvIGJlDQo+
ID4gaW1wb3NzaWJsZSB0bw0KPiA+IGRvIE1BUF9TSEFSRUQsIGJ1dCBpdCBoYXMgbm90IGJlZW4g
ZnVsbHkgYW5hbHl6ZWQgZW5vdWdoIHRvIGtub3cNCj4gPiB3aGF0DQo+ID4gdGhlIGNoYW5nZXMg
d291bGQgYmUuIFRoZXJlIHdlcmUgc29tZSBzb2x2YWJsZSBjb25jcmV0ZSBpc3N1ZXMgdGhhdA0K
PiA+IHRpcHBlZCB0aGUgc2NhbGUgYXMgd2VsbC4gSXQgd2FzIGFsc28gbm90IGV4cGVjdGVkIHRv
IGJlIGEgY29tbW9uDQo+ID4gdXNhZ2UsIGlmIGF0IGFsbC4NCj4gDQo+IEkgYW0gbm90IHN1cmUg
aG93IGNvbmZ1c2lvbiBvZiBEPTEsVz0wIGlzIG5vdCBjb21wbGV0ZWx5IHRha2VuIGF3YXkNCj4g
YnkNCj4gc3lzY2FsbCBhcHByb2FjaC4gSXQnbGwgYWx3YXlzIGJlIHRoZXJlLiBPbmUgY2FuIG9u
bHkgZG8gdGhpbmdzIHRvDQo+IG1pbmltaXplDQo+IHRoZSBjaGFuY2VzLg0KPiANCj4gSW4gY2Fz
ZSBvZiBzeXNjYWxsIGFwcHJvYWNoLCBzeXNjYWxsIG1ha2VzIHN1cmUgdGhhdCANCj4gDQo+IGBm
bGFncyA9IE1BUF9BTk9OWU1PVVMgfCBNQVBfUFJJVkFURSB8IE1BUF9BQk9WRTRHYA0KPiANCj4g
VGhpcyBjYW4gYmUgZWFzaWx5IGNoZWNrZWQgaW4gYXJjaCBzcGVjaWZpYyBsYW5kaW5nIGZ1bmN0
aW9uIGZvcg0KPiBtbWFwLg0KDQpSaWdodCwgdGhpcyBpcyB3aHkgSSBsaXN0ZWQgdHdvIHR5cGVz
IG9mIHRoaW5ncyBpbiB0aGUgbWl4IGhlcmUuIFRoZQ0KbWVtb3J5IGZlYXR1cmVzIHN1cHBvcnRl
ZCwgYW5kIHdoYXQgdGhlIHN5c2NhbGwgaXMuIFlvdSBhc2tlZCB3aHkgbGltaXQNCnRoZSBtZW1v
cnkgZmVhdHVyZXMsIHNvIHRoYXQgaXMgdGhlIGV4cGxhbmF0aW9uLg0KDQo+IA0KPiANCj4gQWRk
aXRpb25hbGx5LCBJZiB5b3UgYWx3YXlzIGhhdmUgdGhlIHRva2VuIGF0IGJhc2UsIHlvdSBkb24n
dCBuZWVkDQo+IHRoYXQgQUJJDQo+IGJldHdlZW4gdXNlciBhbmQga2VybmVsLg0KPiANCj4gDQo+
ID4gDQo+ID4gVGhlIG5vbi14ODYsIGdlbmVyYWwgcmVhc29ucyBmb3IgaXQsIGFyZSBmb3IgYSBz
bWFsbGVyIGJlbmVmaXQuIEl0DQo+ID4gYmxvY2tzIGEgbG90IG9mIHdheXMgc2hhZG93IHN0YWNr
IG1lbW9yeSBjb3VsZCBiZSB3cml0dGVuIHRvLiBMaWtlDQo+ID4gc2F5DQo+ID4geW91IGhhdmUg
YSBtZW1vcnkgbWFwcGVkIHdyaXRhYmxlIGZpbGUsIGFuZCB5b3UgYWxzbyBtYXAgaXQgc2hhZG93
DQo+ID4gc3RhY2suIFNvIGl0IGhhcyBiZXR0ZXIgc2VjdXJpdHkgcHJvcGVydGllcyBkZXBlbmRp
bmcgb24gd2hhdCB5b3VyDQo+ID4gdGhyZWF0IG1vZGVsIGlzLg0KPiANCj4gSSB3b3VsZG4ndCBz
YXkgYW55IGFyY2hpdGVjdHVyZSBzaG91bGQgYWxsb3cgc3VjaCBwcmltaXRpdmVzLiBJdCBraW5k
DQo+IG9mIGRlZmVhdHMNCj4gdGhlIHB1cnBvc2UgZm9yIHNoYWRvdyBzdGFjay4gWWVzIGlmIHNv
bWUgc29ydCBvZiBzZWN1cmUgbWVtb3J5IGlzDQo+IG5lZWRlZCwgdGhlcmUgbWF5DQo+IGJlIG5l
dyBJU0EgZXh0ZW5zaW9ucyBmb3IgdGhhdC4NCg0KWWVhLCBzZWVtcyByZWFzb25hYmxlIHRvIHBy
ZXZlbnQgdGhpcyByZWdhcmRsZXNzIG9mIHRoZSBleHRyYSB4ODYNCnJlYXNvbnMsIGlmIHRoYXQg
aXMgd2hhdCB5b3UgYXJlIHNheWluZy4gSXQgZGVwZW5kcyBvbiBwZW9wbGUncyB0aHJlYXQNCm1v
ZGVscyAoYXMgYWx3YXlzIGluIHNlY3VyaXR5KS4NCg0KPiANCj4gPiANCj4gPiA+IA0KPiA+ID4g
RXZlbnR1YWxseSBzeXNjYWxsIHdpbGwgYWxzbyBnbyBhaGVhZCBhbmQgdXNlIG1lbW9yeSBtYW5h
Z2VtZW50DQo+ID4gPiBjb2RlDQo+ID4gPiB0bw0KPiA+ID4gcGVyZm9ybSBtYXBwaW5nLiBTbyBJ
IGRpZG4ndCB1bmRlcnN0YW5kIHRoZSByZWFzb25pbmcgaGVyZS4gVGhlDQo+ID4gPiB3YXkNCj4g
PiA+IHN5c2NhbGwNCj4gPiA+IGNhbiBsaW1pdCBpdCB0byBhbm9ueW1vdXMgbWVtb3J5LCB3aHkg
bW1hcCBjYW4ndCBkbyB0aGUgc2FtZSBpZg0KPiA+ID4gaXQNCj4gPiA+IHNlZXMNCj4gPiA+IFBS
T1RfU0hBRE9XU1RBQ0suDQo+ID4gPiANCj4gPiA+ID4gDQo+ID4gPiA+IFRoZSBvbmx5IGJlbmVm
aXQgSSd2ZSBoZWFyZCBpcyB0aGF0IGl0IHNhdmVzIGNyZWF0aW5nIGEgbmV3DQo+ID4gPiA+IHN5
c2NhbGwsDQo+ID4gPiA+IGJ1dCBpdCBhbHNvIHNhdmVzIHNldmVyYWwgTUFQXyBmbGFncy4gVGhh
dCwgYW5kIHRoYXQgdGhlIFJGQw0KPiA+ID4gPiBmb3INCj4gPiA+ID4gcmlzY3YNCj4gPiA+ID4g
ZGlkIGEgUFJPVF9TSEFET1dfU1RBQ0sgdG8gc3RhcnQuIFNvLCB5ZXMsIHR3byBwZW9wbGUgYXNr
ZWQgdGhlDQo+ID4gPiA+IHNhbWUNCj4gPiA+ID4gcXVlc3Rpb24sIGJ1dCBJJ20gc3RpbGwgbm90
IHNlZWluZyBhbnkgYmVuZWZpdHMuIENhbiB5b3UgZ2l2ZQ0KPiA+ID4gPiB0aGUNCj4gPiA+ID4g
cHJvcw0KPiA+ID4gPiBhbmQgY29ucyBwbGVhc2U/DQo+ID4gPiANCj4gPiA+IEFnYWluIHRoZSB3
YXkgc3lzY2FsbCB3aWxsIGxpbWl0IGl0IHRvIGFub255bW91cyBtZW1vcnksIFdoeSBtbWFwDQo+
ID4gPiBjYW4ndCBkbyBzYW1lPw0KPiA+ID4gVGhlcmUgaXMgcHJlY2VkZW5jZSBmb3IgaXQgKGxp
a2UgUFJPVF9NVEUgaXMgYXBwbGljYWJsZSBvbmx5IHRvDQo+ID4gPiBhbm9ueW1vdXMgbWVtb3J5
KQ0KPiA+ID4gDQo+ID4gPiBTbyBpZiBpdCBjYW4gYmUgZG9uZSwgdGhlbiB3aHkgaW50cm9kdWNl
IGEgbmV3IHN5c2NhbGw/DQo+ID4gPiANCj4gPiA+ID4gDQo+ID4gPiA+IEJUVywgaW4gZ2xpYmMg
bWFwX3NoYWRvd19zdGFjayBpcyBjYWxsZWQgZnJvbSBhcmNoIGNvZGUuIFNvIEkNCj4gPiA+ID4g
dGhpbmsNCj4gPiA+ID4gdXNlcnNwYWNlIHdpc2UsIGZvciB0aGlzIHRvIGFmZmVjdCBvdGhlciBh
cmNoaXRlY3R1cmVzIHRoZXJlDQo+ID4gPiA+IHdvdWxkDQo+ID4gPiA+IG5lZWQNCj4gPiA+ID4g
dG8gYmUgc29tZSBjb2RlIHRoYXQgY291bGQgZG8gdGhpbmdzIGdlbmVyaWNhbGx5LCB3aXRoIHNv
bWVob3cNCj4gPiA+ID4gdGhlDQo+ID4gPiA+IHNoYWRvdyBzdGFjayBwaXZvdCBhYnN0cmFjdGVk
IGJ1dCB0aGUgc2hhZG93IHN0YWNrIGFsbG9jYXRpb24NCj4gPiA+ID4gbm90Lg0KPiA+ID4gDQo+
ID4gPiBBZ3JlZWQsIHllcyBpdCBjYW4gYmUgZG9uZSBpbiBhIHdheSB3aGVyZSBpdCB3b24ndCBw
dXQgdGF4IG9uDQo+ID4gPiBvdGhlcg0KPiA+ID4gYXJjaGl0ZWN0dXJlcy4NCj4gPiA+IA0KPiA+
ID4gQnV0IHdoYXQgYWJvdXQgZnJhZ21lbnRhdGlvbiB3aXRoaW4geDg2LiBXaWxsIHg4NiBhbHdh
eXMgY2hvb3NlDQo+ID4gPiB0bw0KPiA+ID4gdXNlIHN5c3RlbSBjYWxsDQo+ID4gPiBtZXRob2Qg
bWFwIHNoYWRvdyBzdGFjay4gSWYgZnV0dXJlIHJlLWZhY3RvciByZXN1bHRzIGluIHg4NiBhbHNv
DQo+ID4gPiB1c2UNCj4gPiA+IGBtbWFwYCBtZXRob2QuDQo+ID4gPiBJc24ndCBpdCBhIG1lc3Mg
Zm9yIHg4NiBnbGliYyB0byBmaWd1cmUgb3V0IHdoYXQgdG8gZG87IHdoZXRoZXINCj4gPiA+IHRv
DQo+ID4gPiB1c2Ugc3lzdGVtIGNhbGwNCj4gPiA+IG9yIGBtbWFwYD8NCj4gPiA+IA0KPiA+IA0K
PiA+IE9rLCBzbyB0aGlzIGlzIHRoZSBkb3duc2lkZSBJIGd1ZXNzLiBXaGF0IGhhcHBlbnMgaWYg
d2Ugd2FudCB0bw0KPiA+IHN1cHBvcnQNCj4gPiB0aGUgb3RoZXIgdHlwZXMgb2YgbWVtb3J5IGlu
IHRoZSBmdXR1cmUgYW5kIGVuZCB1cCB1c2luZyBtbWFwIGZvcg0KPiA+IHRoaXM/DQo+ID4gVGhl
biB3ZSBoYXZlIDE1LTIwIGxpbmVzIG9mIGV4dHJhIHN5c2NhbGwgd3JhcHBpbmcgY29kZSB0byBt
YWludGFpbg0KPiA+IHRvDQo+ID4gc3VwcG9ydCBsZWdhY3kuDQo+ID4gDQo+ID4gRm9yIHRoZSBt
bWFwIHNvbHV0aW9uLCB3ZSBoYXZlIHRoZSBkb3duc2lkZSBvZiB1c2luZyBleHRyYSBNQVBfDQo+
ID4gZmxhZ3MsDQo+ID4gYW5kICpzb21lKiBhbW91bnQgb2YgY3VycmVudGx5IHVua25vd24gdm1f
ZmxhZyBhbmQgYWRkcmVzcyByYW5nZQ0KPiA+IGxvZ2ljLA0KPiA+IHBsdXMgbW1hcCBhcmNoIGJy
ZWFrb3V0cyB0byBhZGQgdG8gY29yZSBNTS4gTGlrZSBJIHNhaWQgZWFybGllciwNCj4gPiB5b3UN
Cj4gPiB3b3VsZCBuZWVkIHRvIFBPQyBpdCBvdXQgdG8gc2VlIGhvdyBiYWQgdGhhdCBsb29rcyBh
bmQgZ2V0IHNvbWUNCj4gPiBjb3JlIE1NDQo+ID4gZmVlZGJhY2sgb24gdGhlIG5ldyB0eXBlIG9m
IE1BUCBmbGFnIHVzYWdlLiBCdXQsIHN5c2NhbGxzIGJlaW5nDQo+ID4gcHJldHR5DQo+ID4gc3Ry
YWlnaHRmb3J3YXJkLCBpdCB3b3VsZCBwcm9iYWJseSBiZSAqc29tZSogYW1vdW50IG9mIGFkZGVk
DQo+ID4gY29tcGxleGl0eQ0KPiA+IF9ub3dfIHRvIHN1cHBvcnQgc29tZXRoaW5nIHRoYXQgbWln
aHQgaGFwcGVuIGluIHRoZSBmdXR1cmUuIEknbSBub3QNCj4gPiBzZWVpbmcgZWl0aGVyIG9uZSBh
cyBhIGxhbmRzbGlkZSB3aW4uDQo+ID4gDQo+ID4gSXQncyBraW5kIG9mIGFuIGV0ZXJuYWwgc29m
dHdhcmUgZGVzaWduIHBoaWxvc29waGljYWwgcXVlc3Rpb24sDQo+ID4gaXNuJ3QNCj4gPiBpdD8g
SG93IG11Y2ggd29yayBzaG91bGQgeW91IGRvIHRvIHByZXBhcmUgZm9yIHRoaW5ncyB0aGF0IG1p
Z2h0IGJlDQo+ID4gbmVlZGVkIGluIHRoZSBmdXR1cmU/IEZyb20gd2hhdCBJJ3ZlIHNlZW4gdGhl
IGJhbGFuY2UgaW4gdGhlIGtlcm5lbA0KPiA+IHNlZW1zIHRvIGJlIHRvIHRyeSBub3QgdG8gcGFp
bnQgeW91cnNlbGYgaW4gdG8gYW4gQUJJIGNvcm5lciwgYnV0DQo+ID4gb3RoZXJ3aXNlIGxldCB0
aGUga2VybmVsIGV2b2x2ZSBuYXR1cmFsbHkgaW4gcmVzcG9uc2UgdG8gcmVhbA0KPiA+IHVzYWdl
cy4NCj4gPiBJZiBhbnlvbmUgd2FudHMgdG8gY29ycmVjdCB0aGlzLCBwbGVhc2UgZG8uIEJ1dCBv
dGhlcndpc2UgSSB0aGluaw0KPiA+IHRoZQ0KPiA+IG5ldyBzeXNjYWxsIGlzIGFsaWduZWQgd2l0
aCB0aGF0Lg0KPiA+IA0KPiA+IFRCSCwgeW91IGFyZSBtYWtpbmcgbWUgd29uZGVyIGlmIEknbSBt
aXNzaW5nIHNvbWV0aGluZy4gSXQgc2VlbXMNCj4gPiB5b3UNCj4gPiBzdHJvbmdseSBkb24ndCBw
cmVmZXIgdGhpcyBhcHByb2FjaCwgYnV0IEknbSBub3QgaGVhcmluZyBhbnkgaHVnZQ0KPiA+IHBv
dGVudGlhbCBuZWdhdGl2ZSBpbXBhY3RzLiBBbmQgeW91IGFsc28gc2F5IGl0IHdvbid0IHRheCB0
aGUgcmlzY3YNCj4gPiBpbXBsZW1lbnRhdGlvbi4gSXMgdGhpcyBqdXN0IHNvbWV0aGluZyBqdXN0
IHNtZWxscyBiYWQgaGVyZT8gT3IgaXQNCj4gPiB3b3VsZCBzaHJpbmsgdGhlIHJpc2N2IHNlcmll
cz8NCj4gDQo+IE5vIHlvdSdyZSBub3QgbWlzc2luZyBhbnl0aGluZy4gSXQncyBqdXN0IHdpZXJk
bmVzcyBvZiBhZGRpbmcgYQ0KPiBzeXN0ZW0gY2FsbA0KPiB3aGljaCBlbmZvcmNlcyBjZXJ0YWlu
IE1BUF9YWCBmbGFncyBhbmQgcHJldHR5IG11Y2ggbWFwcGluZyBBUEkuDQo+IEFuZCBkaWZmZXJl
bmNlIGJldHdlZW4gYXJjaGl0ZWN0dXJlcyBvbiBob3cgdGhleSB3aWxsIGNyZWF0ZSBzaGFkb3cN
Cj4gc3RhY2suICsgDQo+IGlmIHg4NiBjaG9vc2VzIHRvIHVzZSBgbW1hcGAgaW4gZnV0dXJlLCB0
aGVuIHRoZXJlIGlzIHVnbGluZXNzIGluDQo+IHVzZXIgbW9kZSB0bw0KPiBkZWNpZGUgd2hpY2gg
bWV0aG9kIHRvIGNob29zZS4NCg0KT2ssIEkgdGhpbmsgSSB3aWxsIGxlYXZlIGl0IGdpdmVuIGl0
J3MgZW50aXJlbHkgaW4gYXJjaC94ODYuIEl0IGp1c3QNCmdvdCBzb21lIHNwZWNpYWwgZXJyb3Ig
Y29kZXMgaW4gdGhlIG90aGVyIHRocmVhZCB0b2RheSB0b28uDQoNCj4gDQo+IEFuZCB5ZXMgeW91
IGdvdCBpdCByaWdodCwgdG8gc29tZSBleHRlbnQgdGhlcmUgaXMgbXkgb3duIHNlbGZpc2huZXNz
DQo+IHBsYXlpbmcgb3V0DQo+IGFzIHdlbGwgaGVyZSB0byByZWR1Y2UgcmlzY3YgcGF0Y2hlcy4N
Cj4gDQoNCkZlZWwgZnJlZSB0byBqb2luIHRoZSBtYXBfc2hhZG93X3N0YWNrIHBhcnR5LiA6KQ0K

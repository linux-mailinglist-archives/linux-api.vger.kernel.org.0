Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D18F7159A0F
	for <lists+linux-api@lfdr.de>; Tue, 11 Feb 2020 20:52:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729731AbgBKTwv (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 11 Feb 2020 14:52:51 -0500
Received: from mga03.intel.com ([134.134.136.65]:7803 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728049AbgBKTwu (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Tue, 11 Feb 2020 14:52:50 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Feb 2020 11:52:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,428,1574150400"; 
   d="scan'208";a="226597654"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
  by fmsmga007.fm.intel.com with ESMTP; 11 Feb 2020 11:52:48 -0800
Received: from fmsmsx158.amr.corp.intel.com (10.18.116.75) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 11 Feb 2020 11:52:49 -0800
Received: from FMSEDG001.ED.cps.intel.com (10.1.192.133) by
 fmsmsx158.amr.corp.intel.com (10.18.116.75) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 11 Feb 2020 11:52:49 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.42) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Tue, 11 Feb 2020 11:52:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y/yk5zEL61ve7bwwaXmn10aPuqeW3SGe6CXcmAmA4hKkPejolpTKvXpSO5rufL49EJxXw+Q3UeO6kTwjv8EfW3tTe0kJX3UU0xpgXeyIpqG7efWzOc8xEwCYTlivEh/IG/+eHGC4AuLhHzL3DaMwVwb4If187VtzT4E0bRaKC6YIADj/KNrlNZHplRIr6BqEVTQhKQcFmzjGInSTAUq1ey/bpuXyriPd6OCsZZqTEb4+U5K/p1qw786NcSNMSskGYI0AoKrIcfzGR8G9vNmdG2UMMrlwUlSHemJBy6d3ReEdwMjZyPTgETxJsd7YRLfwRZpsczOp6FfP69JIFKYsdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RxuEGOeu03+jjzS/vLmydq24ldf9GcYLhMh0Ul+c52Q=;
 b=AGHBDl29proY9x+9ErGyHXThDF99HS1/XWKF311a8HqGTKdzxw+d6BaguhrK4m7/JVcL7jwYAgTjb7pwR0cBQMfAUztHTIAdUF9/01iT10cZcE3WYi/KNmU8Awkaam+lW75OU1nq4SA8AN9/DIvMOYGp0Sgz5ojKsQNcRqBxq4w1vBjsPU6Lr+bRv6nNj9wXLPtwgsSSjS0gCmAXzId8leH7UYI6E2XZLO2EIgyQQw4UInLCT1Oz7gVHdzTIqQlieKlkmuXd5fjHkUJzOtBrUh/h+GW0tp+hrerIuHfW0czL0hKaNbYITyE25/9NJ3tnLhQ3VgERSa5viICfEuSUcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RxuEGOeu03+jjzS/vLmydq24ldf9GcYLhMh0Ul+c52Q=;
 b=qH3iCtZaMlL9SN4unIdIZ0HNAOrXoKnB7z7qTqZOwhvd7KcodmtU88fGeUkN6qdD/lpwu+yfGJbQPlh+op15kYlyB+ML6WYaV+tohPDAKETqWe1Y/Au2lA8Z1kjw2c8+fGNw95pNb3228PMgR9ich5y6tq4IfeYPBvRRoNFZcik=
Received: from CY4PR11MB0072.namprd11.prod.outlook.com (10.171.253.27) by
 CY4PR11MB1463.namprd11.prod.outlook.com (10.172.65.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.23; Tue, 11 Feb 2020 19:52:47 +0000
Received: from CY4PR11MB0072.namprd11.prod.outlook.com
 ([fe80::38cc:5fb0:e16e:7b5b]) by CY4PR11MB0072.namprd11.prod.outlook.com
 ([fe80::38cc:5fb0:e16e:7b5b%3]) with mapi id 15.20.2707.030; Tue, 11 Feb 2020
 19:52:47 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "rppt@kernel.org" <rppt@kernel.org>,
        "Hansen, Dave" <dave.hansen@intel.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "alan@linux.intel.com" <alan@linux.intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "willy@infradead.org" <willy@infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "cl@linux.com" <cl@linux.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "Reshetova, Elena" <elena.reshetova@intel.com>,
        "tycho@tycho.ws" <tycho@tycho.ws>,
        "luto@kernel.org" <luto@kernel.org>,
        "kirill@shutemov.name" <kirill@shutemov.name>
Subject: Re: [RFC PATCH] mm: extend memfd with ability to create "secret"
 memory areas
Thread-Topic: [RFC PATCH] mm: extend memfd with ability to create "secret"
 memory areas
Thread-Index: AQHV4QFPx/fsO70zbUuEQhjuwQxhXagOesyAgAMQlgCABNxdgA==
Date:   Tue, 11 Feb 2020 19:52:47 +0000
Message-ID: <ab0a11ad5fde0cc71a725aac3ea81cc996e35bf1.camel@intel.com>
References: <20200130162340.GA14232@rapoport-lnx>
         <df5a888b-1a11-e806-741d-94684b22c966@intel.com>
         <20200208173922.GA15879@hump>
In-Reply-To: <20200208173922.GA15879@hump>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=rick.p.edgecombe@intel.com; 
x-originating-ip: [134.134.136.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4be565f4-d500-4eb9-ece9-08d7af2bf7d2
x-ms-traffictypediagnostic: CY4PR11MB1463:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR11MB14633850EBF445A503316FEFC9180@CY4PR11MB1463.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0310C78181
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39860400002)(366004)(136003)(396003)(346002)(189003)(199004)(71200400001)(2616005)(478600001)(6506007)(36756003)(186003)(2906002)(4326008)(4744005)(5660300002)(66446008)(86362001)(7416002)(6512007)(110136005)(54906003)(8936002)(66946007)(8676002)(76116006)(91956017)(26005)(6636002)(66476007)(64756008)(66556008)(316002)(6486002)(81166006)(81156014)(219293001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR11MB1463;H:CY4PR11MB0072.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8XFYgOItGaM8aZMiGNJC1FM85GNL8J0pVNenceTZn/cGgtDbZ7xdDJEur+lk/dJ0WdFQdktOcVQ7LhM2OArSBeQC5tYnGsGUH+IzfgCevXfMNeklcVEvkqzqTGu1O4qYNUjyA9eH3xiz7mt5YtjdDgo35KIBeGYCD4/mSY4vxWO75smWzuQ1jwFhgMsRul4U4F+vAt6IFYzBjlYdooyKcLRJNcWhCWyLonHrKBr6Ugza8TFjZ36OSGbZTVCE5qvK3Y86mx6IgMfaDyyXtsXRwf2g5OuHeaSuXvL2lEMmgaskxOQLvzRbZ5BOz1f3r2H3ItfkcC8Bi2NudansJMBE+E/fE/2FtppBGdUXlCTrPTcUjzpYtXtTJqOOAzTQGDVGNZ1v3/E2/Ddd2Efv2YD/jbXgEswU3hk8LJmO9hKITKaglS/0AB+N4byBgW6VoJZAcBWqHB+6uuLJGAuIh2qgjZoo2hlgY4yxKGEDRIw93fw3vVGoLAzojVKE5VfHDBtp
x-ms-exchange-antispam-messagedata: N/N8ZPfIdcxe6CDXK/63fZ0LmrVg6wzOnpsaS3/9kQeK7NAVDFvjkP97LIkd8ij9MN9apJm+l41RS5v5VbQ44/yD7SHevyWlHARBjEuavfgLykLUhRI/BBZD4yVE9KNCyO/w9yqjdF/q4q2YN+6laA==
Content-Type: text/plain; charset="utf-8"
Content-ID: <7C45F3DD1BF1A748ACA077A657B22C5C@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 4be565f4-d500-4eb9-ece9-08d7af2bf7d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2020 19:52:47.0995
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Pid0PXboa76kq5nMOGZjzxhKOK9NoB86oJCFIeowZBrOTdSkOM5+ETzZwbb3kZpDZ59BGsrsj9J3zvTWpZrsZV07I9uHoaZVyQqrypNoTSA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1463
X-OriginatorOrg: intel.com
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

T24gU2F0LCAyMDIwLTAyLTA4IGF0IDE5OjM5ICswMjAwLCBNaWtlIFJhcG9wb3J0IHdyb3RlOg0K
PiA+IERvIHdlIG5lZWQgdG8gbWFrZSBrbWFwKCkgd29yayBvbiB0aGVzZT8NCj4gDQo+IEkgZG9u
J3QgdGhpbmsgd2UgbmVlZCB0byBtYWtlIGttYXAoKSB3b3JrIG9uIHRoZXNlLiBUaGUgaWRlYSBp
cyB0byBwcmV2ZW50DQo+IGtlcm5lbCBmcm9tIGFjY2Vzc2luZyBzdWNoIG1lbW9yeSBhcmVhcy4N
Cg0KRm9yIHRoZSBWTSB1c2UgY2FzZSwgS1ZNIGRvZXMga21hcCgpIGd1ZXN0IG1lbW9yeSB3aGVu
IGVtdWxhdGluZyBwYWdlIHRhYmxlDQpvcGVyYXRpb25zIGluIHNvbWUgY2FzZXM6DQphcmNoL3g4
Ni9rdm0vcGFnaW5nX3RtcGwuaDpGTkFNRShjbXB4Y2hnX2dwdGUpLg0K

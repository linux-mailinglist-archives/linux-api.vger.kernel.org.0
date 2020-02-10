Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CAC1E157035
	for <lists+linux-api@lfdr.de>; Mon, 10 Feb 2020 09:06:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbgBJIGy (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 10 Feb 2020 03:06:54 -0500
Received: from mga01.intel.com ([192.55.52.88]:55918 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725468AbgBJIGy (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Mon, 10 Feb 2020 03:06:54 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Feb 2020 00:06:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,424,1574150400"; 
   d="scan'208";a="227112515"
Received: from orsmsx107.amr.corp.intel.com ([10.22.240.5])
  by fmsmga008.fm.intel.com with ESMTP; 10 Feb 2020 00:06:53 -0800
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX107.amr.corp.intel.com (10.22.240.5) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 10 Feb 2020 00:06:52 -0800
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 10 Feb 2020 00:06:52 -0800
Received: from ORSEDG001.ED.cps.intel.com (10.7.248.4) by
 orsmsx609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 10 Feb 2020 00:06:52 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.175)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 10 Feb 2020 00:06:51 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FeNfcfcfji2ysPWBqeHU/clJ+t9PNwQoEMx3afkPdZDWpDQOh58wx5t2OIpdXdrvm/REmd5NXLPAm5HGUPp2X3hLl5RTZAhStak+ZfWgs7bhaqb4AhZL6x32o134iEjtJLtvyeE6IalYT+TTpxcrqHCsSVZQb4L4EMmtAghnO+BJ5gwNHsKZeFtO9gN2neW8TtYUonkXlwo6CZ6uMMsAnEDDwpOE8i4Fb+O04JOI7igRmtR+CMhruaJlE3/J5ImV7YfXBTX9PNDfn02eeuy3hICHxP4bRLNn4tRuBemjIQXWyCuvKKfjwr7ZQY22/74+ef/gd/XS1Sjj/S1f8av+rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fnUyLd5ZpEf9JULjrjDReyskdwB47v/MMUHP3QXh/iE=;
 b=AcCAq6TtXD+L1h5+9T/vsmRT8SZpRNYjKKgxYEGCAF0k5nDy0H+tFxPpfiDQ0pMVy3t4RvCuw9xg3ar6QogutqGDa/wfMXYNcE2Jy2tb/RrZ+RKDF6QL50vlWToxg8e0u/k0Q0jCJkYoP1pkKsvdRJAj7NvQnkriIQ0cnf2ms0cJ406ODYsJBd0jOLTdyB3QHQK3VzoL0DGS7fwQEXs1hOb0bzOqQK3XARd1e6sOTuBuUPiHyoCR02PbCjQB9rbYLbHZr13FjH7xBiI7jlThuV85xr1nHnZfqMiFdb2vgjeKWvoUbJ4qVs8qDYQuTGBuZINpj5h9BcCP0Q0o7zohJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fnUyLd5ZpEf9JULjrjDReyskdwB47v/MMUHP3QXh/iE=;
 b=qfr2sqkQjxDYdF/8ygJVE9iOcJ9NRc/3ERO172fXIdLVUAkJ5Tmypx2pUlKtKQ6FRQaDMDMxcAJW5MjxbyPHDV7C13BQb+ZbBFhnXV9CEl4YOmzZOu4dWb0ErcNfy0ttR0sJGPWmVg15m1cLK6VwXrCugNenl9MPP1AyL4/LTOc=
Received: from BL0PR11MB3281.namprd11.prod.outlook.com (10.167.234.225) by
 BL0PR11MB3300.namprd11.prod.outlook.com (10.167.182.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.24; Mon, 10 Feb 2020 08:06:49 +0000
Received: from BL0PR11MB3281.namprd11.prod.outlook.com
 ([fe80::6922:6eaf:ef86:a691]) by BL0PR11MB3281.namprd11.prod.outlook.com
 ([fe80::6922:6eaf:ef86:a691%7]) with mapi id 15.20.2707.030; Mon, 10 Feb 2020
 08:06:49 +0000
From:   "Reshetova, Elena" <elena.reshetova@intel.com>
To:     Mike Rapoport <rppt@kernel.org>,
        "Hansen, Dave" <dave.hansen@intel.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Andy Lutomirski" <luto@kernel.org>,
        Christopher Lameter <cl@linux.com>,
        "Dave Hansen" <dave.hansen@linux.intel.com>,
        James Bottomley <jejb@linux.ibm.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tycho Andersen <tycho@tycho.ws>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: RE: [RFC PATCH] mm: extend memfd with ability to create "secret"
 memory areas
Thread-Topic: [RFC PATCH] mm: extend memfd with ability to create "secret"
 memory areas
Thread-Index: AQHV14m+Mmd68cx3eUajc6Oqc5ecjqgOjbuAgAMQlgCAAoLcYA==
Date:   Mon, 10 Feb 2020 08:06:49 +0000
Message-ID: <BL0PR11MB3281C858712D469C88F52537E7190@BL0PR11MB3281.namprd11.prod.outlook.com>
References: <20200130162340.GA14232@rapoport-lnx>
 <df5a888b-1a11-e806-741d-94684b22c966@intel.com>
 <20200208173922.GA15879@hump>
In-Reply-To: <20200208173922.GA15879@hump>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.2.0.6
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=elena.reshetova@intel.com; 
x-originating-ip: [192.198.151.191]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a3457665-bbf5-4e02-57df-08d7ae002e41
x-ms-traffictypediagnostic: BL0PR11MB3300:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR11MB33009390E45D6CCFBF23C907E7190@BL0PR11MB3300.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 03094A4065
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(39860400002)(396003)(366004)(136003)(189003)(199004)(5660300002)(4326008)(71200400001)(76116006)(52536014)(9686003)(86362001)(66476007)(64756008)(66446008)(66946007)(6506007)(7416002)(26005)(53546011)(33656002)(66556008)(6636002)(186003)(54906003)(110136005)(7696005)(2906002)(55016002)(478600001)(316002)(81166006)(81156014)(8936002)(8676002)(966005)(219293001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR11MB3300;H:BL0PR11MB3281.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AYOm80V+xsR/gJL3pBxbfzRPsN69r0bAsm+Khnu+pKyl40liE4fWzr7OvQ6m+4b9cbNOaM3gC81KvortTAHqq1VE2Bhzgtf4Bo0FOefidgCSNWZViz3DRtsg+fOcz2DQxPRZJar0dE7vu87nI2ZqTxq6tpG8YKO/UjT0ofxVVTdWYoEWHv5Vu6oTitgsUfcpAO8yNndnmL84ohaIJwieJmT+BHvIND6HcGO38IAewYKYhNC1jtN9YrxJcGP32K/RFDE70isURBHlupyoGpBZRGj61uOEaI19Rr8QJxCV045uBzgd7Em5irImPZCA5XeGHO7GSr7i/LPEeFXdHJsOS17ykbUuc+vgNt1iTA0qUcZczxOEYp3sm5Tda+RCXq8b3HpOcFLiczXI5il+mH7zXUay43akOKDfY32DRPMJGqWnidGdNRexRVi0F2p+AajmOSwF5+i6qV3i8+YDWkvgmJsUDAXNyZtgN5nGSGCYVJB+yEWcvqsvtG+51vQrrs5Qk+tKLw7IpV+kUTWKSyiPXKJoIEu/esnIMpWmx80ak0eZb/7y84SSwf0pxEBWTc33
x-ms-exchange-antispam-messagedata: WiSnMA+TB9aKpWj9Y1OPKMl7icmF5P0boLLCaQIuxrhgGGoAb7xTuIX07Vx5++UyyehoSUEPyzRmN6vLkq0lhgHtBaY2qI985+kfhuan3n2GQLNp4ocRB2FxMgz5ay4nraVEl0R3d5l0z0T9WkGjrw==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: a3457665-bbf5-4e02-57df-08d7ae002e41
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2020 08:06:49.4232
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x/J3zDVxQn9KBYz6VlZAvHSBRh48BOZukAUlqHPY1+4SKInZ2Vt27r8aeIsW2YX8IGhTxnwpk3bwqCR2Wsy5asZkcLzH9z5m7yuRyXrU/tQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR11MB3300
X-OriginatorOrg: intel.com
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org


> On Thu, Feb 06, 2020 at 10:51:13AM -0800, Dave Hansen wrote:
> > On 1/30/20 8:23 AM, Mike Rapoport wrote:
> > >  include/linux/memfd.h      |   9 ++
> > >  include/uapi/linux/magic.h |   1 +
> > >  include/uapi/linux/memfd.h |   6 +
> > >  mm/Kconfig                 |   4 +
> > >  mm/Makefile                |   1 +
> > >  mm/memfd.c                 |  10 +-
> > >  mm/secretmem.c             | 244 +++++++++++++++++++++++++++++++++++=
++
> > >  7 files changed, 273 insertions(+), 2 deletions(-)
> >
> > It seems pretty self-contained and relatively harmless.
> >
> > But, how much work is it going to be to tell the rest of the kernel tha=
t
> > page_to_virt() doesn't work any more?
>=20
> Why page_to_virt() won't work anymore? Or you refer to that the kernel co=
de
> won't be able to access the page contents?
>=20
> > Do we need to make kmap() work on these?
>=20
> I don't think we need to make kmap() work on these. The idea is to preven=
t
> kernel from accessing such memory areas.
>=20
> > I guess fixing vm_normal_page() would fix a lot of that.
> >
> > In general, my concern about creating little self-contained memory type=
s
> > is that they will get popular and folks will start wanting more feature=
s
> > from them.  For instance, what if I want NUMA affinity, migration, or
> > large page mappings that are secret?
>=20
> Sure, why not :)
> Well, this is true for any feature: it may become popular, people will
> start using it and it will add more complexity.
>=20
> My goal is to design this thing keeping in mind that all the above (and
> probably more) will be requested sooner or later.
>=20
> > Can these pages work as guest memory?
>=20
> Actually, this is one of the driving usecases. I believe that people that
> use mem=3DX to limit kernel control of the memory and the manage the
> remaining memory for the guests can switch to fd-based approach.
>=20
> > Who would the first users of this thing be?
>=20
> We were thinking about using such areas to store small secrets, e.g. with
> openssl_malloc().
>=20

To elaborate more on this - openssl has "secure heap" feature [1], which=20
is basically a mmap area with MLOCK_ONFAULT and MADV_DONTDUMP.
It is optional feature and can be used for storing things like RSA private =
keys
in a bit more secure memory area (vs. just normal allocation). It is fully=
=20
transparent for userspace applications (hidden behind openssl API), but=20
provides additional security when enabled. So, it seems like a natural cand=
idate
for smth like securememory, which in addition to MLOCK_ONFAULT and=20
MADV_DONTDUMP can provide further security guarantees like exclusive=20
memory and no-caching.=20

[1] https://www.openssl.org/docs/manmaster/man3/OPENSSL_secure_malloc.html

Best Regards,
Elena.

Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BF52266908
	for <lists+linux-api@lfdr.de>; Fri, 11 Sep 2020 21:39:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725908AbgIKTjY (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 11 Sep 2020 15:39:24 -0400
Received: from mga04.intel.com ([192.55.52.120]:35496 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725906AbgIKTjO (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Fri, 11 Sep 2020 15:39:14 -0400
IronPort-SDR: oEYaWAgeu2ATZrtH/fVdq0ocmEjtKnnghewuEG5yU/a6hdB9S6la42dxg2o+gnKYfOmO9YRwcK
 L5bY2fK6D8jA==
X-IronPort-AV: E=McAfee;i="6000,8403,9741"; a="156236548"
X-IronPort-AV: E=Sophos;i="5.76,416,1592895600"; 
   d="scan'208";a="156236548"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2020 12:35:26 -0700
IronPort-SDR: M7/D4TnmvrVYdO12abJTw9PGqbe4NCf6FHJQShTyWGPx3iBQdeT2VMiyV+wugMzVMBfrLcNF3y
 zlqqVxToic/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,416,1592895600"; 
   d="scan'208";a="505599370"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga006.fm.intel.com with ESMTP; 11 Sep 2020 12:35:26 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 11 Sep 2020 12:35:26 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 11 Sep 2020 12:35:26 -0700
Received: from fmsmsx610.amr.corp.intel.com ([10.18.126.90]) by
 fmsmsx610.amr.corp.intel.com ([10.18.126.90]) with mapi id 15.01.1713.004;
 Fri, 11 Sep 2020 12:35:26 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     "Hansen, Dave" <dave.hansen@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@suse.com>
CC:     Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        =?utf-8?B?SmFuIEjDtnBwbmVy?= <hoeppner@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: Ways to deprecate /sys/devices/system/memory/memoryX/phys_device
 ?
Thread-Topic: Ways to deprecate /sys/devices/system/memory/memoryX/phys_device
 ?
Thread-Index: AQHWiHEhJKJA6edVxE2SxRFnpdxADalj0+dw
Date:   Fri, 11 Sep 2020 19:35:24 +0000
Message-ID: <75611c1b4ab44265acff75aa8754d48f@intel.com>
References: <f14f7f00-0501-bb93-88cc-780ae4fbaad3@intel.com>
 <3E00A442-7107-48DA-8172-EED95F6E1663@redhat.com>
 <20200911072035.GC7986@dhcp22.suse.cz>
 <02cdbf90-b29f-a9ec-c83d-49f2548e3e91@redhat.com>
 <20200911091252.GD7986@dhcp22.suse.cz>
 <0f532ff3-972b-bd91-30fe-1c3111d920bf@redhat.com>
 <3b079fda-4e89-b61b-0aca-a0c4ae834fd8@intel.com>
In-Reply-To: <3b079fda-4e89-b61b-0aca-a0c4ae834fd8@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
x-originating-ip: [10.1.200.100]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

PiBJdCdzIGFjdHVhbGx5IHJlYWxseSBoYXJkIHRvIG1hcCBhIERJTU0gdG8gYSBwaHlzaWNhbCBh
ZGRyZXNzLg0KPiBJbnRlcmxlYXZpbmcgY2FuIG1lYW4gdGhhdCBvbmUgcGFnZSBhY3R1YWxseSBz
cGFucyBhIGJ1bmNoIG9mIERJTU1zLg0KDQpIZWghIElmIE5VTUEgbW9kZSBpcyB0dXJuZWQgb2Zm
IHlvdXIgc2luZ2xlIHBhZ2UgbWF5IGhhdmUgY2FjaGUgbGluZXMNCmZyb20gKmV2ZXJ5KiBESU1N
IGluIHRoZSBzeXN0ZW0uIEV2ZW4gd2l0aCBOVU1BIHR1cm5lZCBvbiB0aGUgcGFnZQ0Kd2lsbCBo
YXZlIGNhY2hlIGxpbmVzIGZyb20gZXZlcnkgRElNTSBvbiB0aGUgc29ja2V0Lg0KDQotVG9ueQ0K

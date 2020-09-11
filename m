Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75798266962
	for <lists+linux-api@lfdr.de>; Fri, 11 Sep 2020 22:09:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725817AbgIKUJw (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 11 Sep 2020 16:09:52 -0400
Received: from mga12.intel.com ([192.55.52.136]:61558 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725783AbgIKUJv (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Fri, 11 Sep 2020 16:09:51 -0400
IronPort-SDR: UCjortz85d+shLAY+rl1Gupgve6/LzX+S38zmdsvruYCygtEKWZOcW7+wCLWdSdxts8tY1Uc7i
 YioolS7nJmAQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9741"; a="138358894"
X-IronPort-AV: E=Sophos;i="5.76,417,1592895600"; 
   d="scan'208";a="138358894"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2020 13:09:49 -0700
IronPort-SDR: hzgsC3LsNJG81nYDLIe/oRi+JknExWcXmp28RBIQmFXFq+D5A6Nrf1e2PGT7MGqbaOvEqyPQhm
 mdwPPK+NtZFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,417,1592895600"; 
   d="scan'208";a="450097544"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by orsmga004.jf.intel.com with ESMTP; 11 Sep 2020 13:09:48 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 11 Sep 2020 13:09:48 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 11 Sep 2020 13:09:47 -0700
Received: from fmsmsx610.amr.corp.intel.com ([10.18.126.90]) by
 fmsmsx610.amr.corp.intel.com ([10.18.126.90]) with mapi id 15.01.1713.004;
 Fri, 11 Sep 2020 13:09:47 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     David Hildenbrand <david@redhat.com>
CC:     "Hansen, Dave" <dave.hansen@intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
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
Thread-Index: AQHWiHEhJKJA6edVxE2SxRFnpdxADalj0+dwgAB73gD//4yZsA==
Date:   Fri, 11 Sep 2020 20:09:47 +0000
Message-ID: <64ad68af6abe4d6b9a346e777e2bd864@intel.com>
References: <75611c1b4ab44265acff75aa8754d48f@intel.com>
 <F078F2C8-989D-4A5A-BCB8-F7E215A795A4@redhat.com>
In-Reply-To: <F078F2C8-989D-4A5A-BCB8-F7E215A795A4@redhat.com>
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

PiBIb3cgd291bGQgaXQgYmVoYXZlIGFmdGVyIGhvdHBsdWdnaW5nIGEgc2luZ2xlIERJTU0gIC0g
SSBhc3N1bWUgYSBzaW5nbGUgcGFnZSB3aWxsIG9ubHkgYmUgbWFwcGVkIHRvIHRoYXQgRElNTSAo
b3RoZXJ3aXNlIGEgbG90IG9mIHN0dWZmIHdvdWxkIGhhYmUgdG8gYmUgbW92ZWQgYXJvdW5kLiBX
b3VsZCB0aGUgbWFwcGluZyBjaGFuZ2UgYWZ0ZXIgYSByZWJvb3QgLSBlc3BlY2lhbGx5IGNhbiBh
IERJTU0gdGhhdCBjb3VsZCBnZXQgaG90dW5wbHVnZ2VkIGJlZm9yZSBzdWRkZW5seSBubyBsb25n
ZXIgYmUgaG90dW5wbHVnZ2VkIGluZGl2aWR1YWxseT8NCg0KDQpXZSBkb24ndCBjdXJyZW50bHkg
aGF2ZSBhbnkgcGxhdGZvcm1zIHRoYXQgd291bGQgYWxsb3cgaG90IGFkZGluZyBhdCB0aGUgRElN
TSBsZXZlbC4NClRoZSBCcmlja2xhbmQgZ2VuZXJhdGlvbiBvZiBFNyBYZW9uIHNlcnZlcnMgKEl2
eWJyaWRnZSwgSGFzd2VsbCwgQnJvYWR3ZWxsKSBhbGxvd2VkDQpmb3IgaG90IHBsdWdnaW5nIGEg
cmlzZXIgY2FyZCB0aGF0IGNvbnRhaW5lZCB1cCB0byAxMiBESU1Ncy4NCg0KSWYgeW91IGRpZCBh
ZGQgbWVtb3J5IGl0IHdvdWxkIGhhdmUgdG8gYXBwZWFyIGF0IHRoZSB0b3Agb2YgdGhlIHN5c3Rl
bSBwaHlzaWNhbA0KYWRkcmVzcyBzcGFjZS4gTm8gaW50ZXJsZWF2ZSAodW5sZXNzIHlvdSBhZGRl
ZCBtb3JlIHRoYW4gb25lIERJTU0gaW4gYSBzaW5nbGUNCm9wZXJhdGlvbikuICBBZnRlciBhIHJl
Ym9vdCB0aGUgc3lzdGVtIHdvdWxkIGxpa2VseSBzaHVmZmxlIHRoaW5ncyBhcm91bmQgdG8gYW5k
DQppbnRlcmxlYXZlLg0KDQotVG9ueQ0K

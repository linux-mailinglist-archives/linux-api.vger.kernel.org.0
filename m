Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E12C0337A0E
	for <lists+linux-api@lfdr.de>; Thu, 11 Mar 2021 17:53:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbhCKQwa (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 11 Mar 2021 11:52:30 -0500
Received: from mga01.intel.com ([192.55.52.88]:23860 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229705AbhCKQwW (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 11 Mar 2021 11:52:22 -0500
IronPort-SDR: YAdINEIgmbH/hQVcIK1v9V1MPj7M6ZP7BEzzK0lVX/pS4MtkjYC1k04fkX/fyRWdO0SVRRTCJH
 Zo/gr2Wrm5wQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9920"; a="208524935"
X-IronPort-AV: E=Sophos;i="5.81,241,1610438400"; 
   d="scan'208";a="208524935"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2021 08:52:16 -0800
IronPort-SDR: pLYlvNMkjbGeEf4DGOz05C1/jN6MKQ7sSXym97DOI81RuiFg9om+rbzMSFdenQWzFhhjJnrQPp
 Zt1HnO3fx8QA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,241,1610438400"; 
   d="scan'208";a="409545876"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga007.jf.intel.com with ESMTP; 11 Mar 2021 08:52:11 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 11 Mar 2021 08:52:11 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 11 Mar 2021 08:52:10 -0800
Received: from fmsmsx610.amr.corp.intel.com ([10.18.126.90]) by
 fmsmsx610.amr.corp.intel.com ([10.18.126.90]) with mapi id 15.01.2106.013;
 Thu, 11 Mar 2021 08:52:10 -0800
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Andy Lutomirski <luto@amacapital.net>,
        Aili Yao <yaoaili@kingsoft.com>
CC:     Oleg Nesterov <oleg@redhat.com>,
        Linux API <linux-api@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        HORIGUCHI NAOYA <naoya.horiguchi@nec.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        "yangfeng1@kingsoft.com" <yangfeng1@kingsoft.com>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "sunhao2@kingsoft.com" <sunhao2@kingsoft.com>
Subject: RE: [PATCH v3] x86/fault: Send a SIGBUS to user process always for
 hwpoison page access.
Thread-Topic: [PATCH v3] x86/fault: Send a SIGBUS to user process always for
 hwpoison page access.
Thread-Index: AQHW+52QL4Na2ZzwuU6zOFVHHVSkcqpmUikAgAAvRAD//40+AIAC4sSAgAMSD4CAA5534IAAicMAgAKzWQCAAAergIAGtN8AgADz2wCAAI0/AP//fEfggACQgACAA46dgIAAAmIAgAB7hlA=
Date:   Thu, 11 Mar 2021 16:52:10 +0000
Message-ID: <0a0909a9005842fa9e49ba9917580e79@intel.com>
References: <4fc1b4e8f1fb4c8c81f280db09178797@intel.com>
 <047D5B49-FDBB-494C-81E9-DA811476747D@amacapital.net>
 <20210311091941.45790fcf@alex-virtual-machine>
 <CALCETrVqkK29n=6wtVhd7qgTWf83x3SUk6+bkD30asHyWSqppw@mail.gmail.com>
In-Reply-To: <CALCETrVqkK29n=6wtVhd7qgTWf83x3SUk6+bkD30asHyWSqppw@mail.gmail.com>
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
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

PiBJIHRoaW5rIHdlIG5lZWQgdG8gYXQgbGVhc3QgZml4IHRoZSBleGlzdGluZyBidWcgYmVmb3Jl
IHdlIGFkZCBtb3JlDQo+IHNpZ25hbHMuICBBRkFJQ1MgdGhlIE1DRV9JTl9LRVJORUxfQ09QWUlO
IGNvZGUgaXMgYnVzdGVkIGZvciBrZXJuZWwNCj4gdGhyZWFkcy4NCg0KQ2FuIGEga2VybmVsIHRo
cmVhZCBkbyBnZXRfdXNlcigpIG9yIGNvcHlfZnJvbV91c2VyKCk/ICBEbyB3ZSBoYXZlIGtlcm5l
bCB0aHJlYWRzDQp0aGF0IGhhdmUgYW4gYXNzb2NpYXRlZCB1c2VyIGFkZHJlc3Mgc3BhY2UgdG8g
Y29weSBmcm9tPw0KDQotVG9ueQ0K

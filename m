Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA97AEA2C1
	for <lists+linux-api@lfdr.de>; Wed, 30 Oct 2019 18:48:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727513AbfJ3RsV (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 30 Oct 2019 13:48:21 -0400
Received: from mga07.intel.com ([134.134.136.100]:59435 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726635AbfJ3RsV (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 30 Oct 2019 13:48:21 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Oct 2019 10:48:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,248,1569308400"; 
   d="scan'208";a="203266873"
Received: from orsmsx103.amr.corp.intel.com ([10.22.225.130])
  by orsmga003.jf.intel.com with ESMTP; 30 Oct 2019 10:48:20 -0700
Received: from orsmsx160.amr.corp.intel.com (10.22.226.43) by
 ORSMSX103.amr.corp.intel.com (10.22.225.130) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 30 Oct 2019 10:48:20 -0700
Received: from orsmsx112.amr.corp.intel.com ([169.254.3.185]) by
 ORSMSX160.amr.corp.intel.com ([169.254.13.29]) with mapi id 14.03.0439.000;
 Wed, 30 Oct 2019 10:48:20 -0700
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "peterz@infradead.org" <peterz@infradead.org>
CC:     "adobriyan@gmail.com" <adobriyan@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "luto@kernel.org" <luto@kernel.org>,
        "kirill@shutemov.name" <kirill@shutemov.name>,
        "bp@alien8.de" <bp@alien8.de>,
        "rppt@linux.ibm.com" <rppt@linux.ibm.com>,
        "arnd@arndb.de" <arnd@arndb.de>
Subject: Re: [PATCH RFC] mm: add MAP_EXCLUSIVE to create exclusive user
 mappings
Thread-Topic: [PATCH RFC] mm: add MAP_EXCLUSIVE to create exclusive user
 mappings
Thread-Index: AQHVjbnGcEUDTQSU2UGbl4rq5h7p8qdw7lIAgAARIwCAAVbQAIABFmkAgACBroA=
Date:   Wed, 30 Oct 2019 17:48:20 +0000
Message-ID: <b4d87f54b02cfccb58442f791485cad1ac080063.camel@intel.com>
References: <1572171452-7958-1-git-send-email-rppt@kernel.org>
         <1572171452-7958-2-git-send-email-rppt@kernel.org>
         <20191028123124.ogkk5ogjlamvwc2s@box> <20191028130018.GA7192@rapoport-lnx>
         <20191028131623.zwuwguhm4v4s5imh@box>
         <20191028135521.GB4097@hirez.programming.kicks-ass.net>
         <0a35765f7412937c1775daa05177b20113760aee.camel@intel.com>
         <20191028210052.GM4643@worktop.programming.kicks-ass.net>
         <69c57f7fa9a1be145827673b37beff155a3adc3c.camel@intel.com>
         <20191030100418.GV4097@hirez.programming.kicks-ass.net>
In-Reply-To: <20191030100418.GV4097@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.54.75.11]
Content-Type: text/plain; charset="utf-8"
Content-ID: <7AA923C2D8CFCE44B7E3F1866A3D8051@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

T24gV2VkLCAyMDE5LTEwLTMwIGF0IDExOjA0ICswMTAwLCBQZXRlciBaaWpsc3RyYSB3cm90ZToN
Cj4gPiBZb3UgbWVhbiBzaGF0dGVyIHBlcmZvcm1hbmNlPw0KPiANCj4gU2hhdHRlciAoYWxsKSBs
YXJnZSBwYWdlcy4NCg0KU28gaXQgbG9va3MgbGlrZSB0aGlzIGlzIGFscmVhZHkgaGFwcGVuaW5n
IHRoZW4gdG8gc29tZSBkZWdyZWUuIEl0J3Mgbm90IGp1c3QNCkJQRiBlaXRoZXIsIGFueSBtb2R1
bGVfYWxsb2MoKSB1c2VyIGlzIGdvaW5nIHRvIGRvIHNvbWV0aGluZyBzaW1pbGFyIHdpdGggdGhl
DQpkaXJlY3QgbWFwIGFsaWFzIG9mIHRoZSBwYWdlIHRoZXkgZ290IGZvciB0aGUgdGV4dC4NCg0K
U28gdGhlcmUgbXVzdCBiZSBhdCBsZWFzdCBzb21lIHVzYWdlcyB3aGVyZSBicmVha2luZyB0aGUg
ZGlyZWN0IG1hcCBkb3duLCBmb3INCmxpa2UgYSBwYWdlIHRvIHN0b3JlIGEga2V5IG9yIHNvbWV0
aGluZywgaXNuJ3QgdG90YWxseSBob3JyaWJsZS4NCg0K

Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B5D0E797D
	for <lists+linux-api@lfdr.de>; Mon, 28 Oct 2019 20:59:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727012AbfJ1T72 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 28 Oct 2019 15:59:28 -0400
Received: from mga03.intel.com ([134.134.136.65]:9009 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725776AbfJ1T72 (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Mon, 28 Oct 2019 15:59:28 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Oct 2019 12:59:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,241,1569308400"; 
   d="scan'208";a="224740400"
Received: from orsmsx107.amr.corp.intel.com ([10.22.240.5])
  by fmsmga004.fm.intel.com with ESMTP; 28 Oct 2019 12:59:26 -0700
Received: from orsmsx112.amr.corp.intel.com ([169.254.3.185]) by
 ORSMSX107.amr.corp.intel.com ([169.254.1.115]) with mapi id 14.03.0439.000;
 Mon, 28 Oct 2019 12:59:26 -0700
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "kirill@shutemov.name" <kirill@shutemov.name>,
        "peterz@infradead.org" <peterz@infradead.org>
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
        "rppt@linux.ibm.com" <rppt@linux.ibm.com>,
        "bp@alien8.de" <bp@alien8.de>, "arnd@arndb.de" <arnd@arndb.de>
Subject: Re: [PATCH RFC] mm: add MAP_EXCLUSIVE to create exclusive user
 mappings
Thread-Topic: [PATCH RFC] mm: add MAP_EXCLUSIVE to create exclusive user
 mappings
Thread-Index: AQHVjbnGcEUDTQSU2UGbl4rq5h7p8qdw7lIA
Date:   Mon, 28 Oct 2019 19:59:25 +0000
Message-ID: <0a35765f7412937c1775daa05177b20113760aee.camel@intel.com>
References: <1572171452-7958-1-git-send-email-rppt@kernel.org>
         <1572171452-7958-2-git-send-email-rppt@kernel.org>
         <20191028123124.ogkk5ogjlamvwc2s@box> <20191028130018.GA7192@rapoport-lnx>
         <20191028131623.zwuwguhm4v4s5imh@box>
         <20191028135521.GB4097@hirez.programming.kicks-ass.net>
In-Reply-To: <20191028135521.GB4097@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.54.75.11]
Content-Type: text/plain; charset="utf-8"
Content-ID: <D229CC7531AD5E4DBDB18933FD17DC5A@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

T24gTW9uLCAyMDE5LTEwLTI4IGF0IDE0OjU1ICswMTAwLCBQZXRlciBaaWpsc3RyYSB3cm90ZToN
Cj4gT24gTW9uLCBPY3QgMjgsIDIwMTkgYXQgMDQ6MTY6MjNQTSArMDMwMCwgS2lyaWxsIEEuIFNo
dXRlbW92IHdyb3RlOg0KPiANCj4gPiBJIHRoaW5rIGFjdGl2ZSB1c2Ugb2YgdGhpcyBmZWF0dXJl
IHdpbGwgbGVhZCB0byBwZXJmb3JtYW5jZSBkZWdyYWRhdGlvbiBvZg0KPiA+IHRoZSBzeXN0ZW0g
d2l0aCB0aW1lLg0KPiA+IA0KPiA+IFNldHRpbmcgYSBzaW5nbGUgNGsgcGFnZSBub24tcHJlc2Vu
dCBpbiB0aGUgZGlyZWN0IG1hcHBpbmcgd2lsbCByZXF1aXJlDQo+ID4gc3BsaXR0aW5nIDJNIG9y
IDFHIHBhZ2Ugd2UgdXN1YWxseSBtYXAgZGlyZWN0IG1hcHBpbmcgd2l0aC4gQW5kIGl0J3Mgb25l
DQo+ID4gd2F5IHJvYWQuIFdlIGRvbid0IGhhdmUgYW55IG1lY2hhbmlzbSB0byBtYXAgdGhlIG1l
bW9yeSB3aXRoIGh1Z2UgcGFnZQ0KPiA+IGFnYWluIGFmdGVyIHRoZSBhcHBsaWNhdGlvbiBoYXMg
ZnJlZWQgdGhlIHBhZ2UuDQo+IA0KPiBSaWdodCwgd2UgcmVjZW50bHkgaGFkIGEgJ2J1Zycgd2hl
cmUgZnRyYWNlIHRyaWdnZXJlZCBzb21ldGhpbmcgbGlrZQ0KPiB0aGlzIGFuZCBmYWNlYm9vayBy
YW4gaW50byBpdCBhcyBhIHBlcmZvcm1hbmNlIHJlZ3Jlc3Npb24uIFNvIHllcywgdGhpcw0KPiBp
cyBhIHJlYWwgY29uY2Vybi4NCg0KRG9uJ3QgZS9jQlBGIGZpbHRlcnMgYWxzbyBicmVhayB0aGUg
ZGlyZWN0IG1hcCBkb3duIHRvIDRrIHBhZ2VzIHdoZW4gY2FsbGluZw0Kc2V0X21lbW9yeV9ybygp
IG9uIHRoZSBmaWx0ZXIgZm9yIDY0IGJpdCB4ODYgYW5kIGFybT8NCg0KSSd2ZSBiZWVuIHdvbmRl
cmluZyBpZiB0aGUgcGFnZSBhbGxvY2F0b3Igc2hvdWxkIG1ha2Ugc29tZSBlZmZvcnQgdG8gZmlu
ZCBhDQpicm9rZW4gZG93biBwYWdlIGZvciBhbnl0aGluZyB0aGF0IGNhbiBiZSBrbm93biB3aWxs
IGhhdmUgZGlyZWN0IG1hcCBwZXJtaXNzaW9ucw0KY2hhbmdlZCAob3IgaWYgaXQgYWxyZWFkeSBn
cm91cHMgdGhlbSBzb21laG93KS4gQnV0IGFsc28sIHdoeSBhbnkgcG90ZW50aWFsDQpzbG93ZG93
biBvZiA0ayBwYWdlcyBvbiB0aGUgZGlyZWN0IG1hcCBoYXNuJ3QgYmVlbiBub3RpY2VkIGZvciBh
cHBzIHRoYXQgZG8gYQ0KbG90IG9mIGluc2VydGlvbnMgYW5kIHJlbW92YWxzIG9mIEJQRiBmaWx0
ZXJzLCBpZiB0aGlzIGlzIGluZGVlZCB0aGUgY2FzZS4NCg0KDQo=

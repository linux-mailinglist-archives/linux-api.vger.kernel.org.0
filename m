Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D875AE8E12
	for <lists+linux-api@lfdr.de>; Tue, 29 Oct 2019 18:27:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727512AbfJ2R1p (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 29 Oct 2019 13:27:45 -0400
Received: from mga11.intel.com ([192.55.52.93]:43995 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726316AbfJ2R1p (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Tue, 29 Oct 2019 13:27:45 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Oct 2019 10:27:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,244,1569308400"; 
   d="scan'208";a="399862741"
Received: from orsmsx102.amr.corp.intel.com ([10.22.225.129])
  by fmsmga005.fm.intel.com with ESMTP; 29 Oct 2019 10:27:44 -0700
Received: from orsmsx112.amr.corp.intel.com ([169.254.3.185]) by
 ORSMSX102.amr.corp.intel.com ([169.254.3.181]) with mapi id 14.03.0439.000;
 Tue, 29 Oct 2019 10:27:44 -0700
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
Thread-Index: AQHVjbnGcEUDTQSU2UGbl4rq5h7p8qdw7lIAgAARIwCAAVbQAA==
Date:   Tue, 29 Oct 2019 17:27:43 +0000
Message-ID: <69c57f7fa9a1be145827673b37beff155a3adc3c.camel@intel.com>
References: <1572171452-7958-1-git-send-email-rppt@kernel.org>
         <1572171452-7958-2-git-send-email-rppt@kernel.org>
         <20191028123124.ogkk5ogjlamvwc2s@box> <20191028130018.GA7192@rapoport-lnx>
         <20191028131623.zwuwguhm4v4s5imh@box>
         <20191028135521.GB4097@hirez.programming.kicks-ass.net>
         <0a35765f7412937c1775daa05177b20113760aee.camel@intel.com>
         <20191028210052.GM4643@worktop.programming.kicks-ass.net>
In-Reply-To: <20191028210052.GM4643@worktop.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.54.75.11]
Content-Type: text/plain; charset="utf-8"
Content-ID: <4DA018406618604E969C1F0F7211E856@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

T24gTW9uLCAyMDE5LTEwLTI4IGF0IDIyOjAwICswMTAwLCBQZXRlciBaaWpsc3RyYSB3cm90ZToN
Cj4gT24gTW9uLCBPY3QgMjgsIDIwMTkgYXQgMDc6NTk6MjVQTSArMDAwMCwgRWRnZWNvbWJlLCBS
aWNrIFAgd3JvdGU6DQo+ID4gT24gTW9uLCAyMDE5LTEwLTI4IGF0IDE0OjU1ICswMTAwLCBQZXRl
ciBaaWpsc3RyYSB3cm90ZToNCj4gPiA+IE9uIE1vbiwgT2N0IDI4LCAyMDE5IGF0IDA0OjE2OjIz
UE0gKzAzMDAsIEtpcmlsbCBBLiBTaHV0ZW1vdiB3cm90ZToNCj4gPiA+IA0KPiA+ID4gPiBJIHRo
aW5rIGFjdGl2ZSB1c2Ugb2YgdGhpcyBmZWF0dXJlIHdpbGwgbGVhZCB0byBwZXJmb3JtYW5jZSBk
ZWdyYWRhdGlvbg0KPiA+ID4gPiBvZg0KPiA+ID4gPiB0aGUgc3lzdGVtIHdpdGggdGltZS4NCj4g
PiA+ID4gDQo+ID4gPiA+IFNldHRpbmcgYSBzaW5nbGUgNGsgcGFnZSBub24tcHJlc2VudCBpbiB0
aGUgZGlyZWN0IG1hcHBpbmcgd2lsbCByZXF1aXJlDQo+ID4gPiA+IHNwbGl0dGluZyAyTSBvciAx
RyBwYWdlIHdlIHVzdWFsbHkgbWFwIGRpcmVjdCBtYXBwaW5nIHdpdGguIEFuZCBpdCdzIG9uZQ0K
PiA+ID4gPiB3YXkgcm9hZC4gV2UgZG9uJ3QgaGF2ZSBhbnkgbWVjaGFuaXNtIHRvIG1hcCB0aGUg
bWVtb3J5IHdpdGggaHVnZSBwYWdlDQo+ID4gPiA+IGFnYWluIGFmdGVyIHRoZSBhcHBsaWNhdGlv
biBoYXMgZnJlZWQgdGhlIHBhZ2UuDQo+ID4gPiANCj4gPiA+IFJpZ2h0LCB3ZSByZWNlbnRseSBo
YWQgYSAnYnVnJyB3aGVyZSBmdHJhY2UgdHJpZ2dlcmVkIHNvbWV0aGluZyBsaWtlDQo+ID4gPiB0
aGlzIGFuZCBmYWNlYm9vayByYW4gaW50byBpdCBhcyBhIHBlcmZvcm1hbmNlIHJlZ3Jlc3Npb24u
IFNvIHllcywgdGhpcw0KPiA+ID4gaXMgYSByZWFsIGNvbmNlcm4uDQo+ID4gDQo+ID4gRG9uJ3Qg
ZS9jQlBGIGZpbHRlcnMgYWxzbyBicmVhayB0aGUgZGlyZWN0IG1hcCBkb3duIHRvIDRrIHBhZ2Vz
IHdoZW4gY2FsbGluZw0KPiA+IHNldF9tZW1vcnlfcm8oKSBvbiB0aGUgZmlsdGVyIGZvciA2NCBi
aXQgeDg2IGFuZCBhcm0/DQo+ID4gDQo+ID4gSSd2ZSBiZWVuIHdvbmRlcmluZyBpZiB0aGUgcGFn
ZSBhbGxvY2F0b3Igc2hvdWxkIG1ha2Ugc29tZSBlZmZvcnQgdG8gZmluZCBhDQo+ID4gYnJva2Vu
IGRvd24gcGFnZSBmb3IgYW55dGhpbmcgdGhhdCBjYW4gYmUga25vd24gd2lsbCBoYXZlIGRpcmVj
dCBtYXANCj4gPiBwZXJtaXNzaW9ucw0KPiA+IGNoYW5nZWQgKG9yIGlmIGl0IGFscmVhZHkgZ3Jv
dXBzIHRoZW0gc29tZWhvdykuIEJ1dCBhbHNvLCB3aHkgYW55IHBvdGVudGlhbA0KPiA+IHNsb3dk
b3duIG9mIDRrIHBhZ2VzIG9uIHRoZSBkaXJlY3QgbWFwIGhhc24ndCBiZWVuIG5vdGljZWQgZm9y
IGFwcHMgdGhhdCBkbw0KPiA+IGENCj4gPiBsb3Qgb2YgaW5zZXJ0aW9ucyBhbmQgcmVtb3ZhbHMg
b2YgQlBGIGZpbHRlcnMsIGlmIHRoaXMgaXMgaW5kZWVkIHRoZSBjYXNlLg0KPiANCj4gVGhhdCBz
aG91bGQgYmUgbGltaXRlZCB0byB0aGUgbW9kdWxlIHJhbmdlLiBSYW5kb20gZGF0YSBtYXBzIGNv
dWxkDQo+IHNoYXR0ZXIgdGhlIHdvcmxkLg0KDQpCUEYgaGFzIG9uZSB2bWFsbG9jIHNwYWNlIGFs
bG9jYXRpb24gZm9yIHRoZSBieXRlIGNvZGUgYW5kIG9uZSBmb3IgdGhlIG1vZHVsZQ0Kc3BhY2Ug
YWxsb2NhdGlvbiBmb3IgdGhlIEpJVC4gQm90aCBnZXQgUk8gYWxzbyBzZXQgb24gdGhlIGRpcmVj
dCBtYXAgYWxpYXMgb2YNCnRoZSBwYWdlcywgYW5kIHJlc2V0IFJXIHdoZW4gZnJlZWQuDQoNCllv
dSBtZWFuIHNoYXR0ZXIgcGVyZm9ybWFuY2U/DQo=

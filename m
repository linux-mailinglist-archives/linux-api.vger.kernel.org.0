Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 169302CEED0
	for <lists+linux-api@lfdr.de>; Fri,  4 Dec 2020 14:35:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729035AbgLDNf1 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 4 Dec 2020 08:35:27 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:59958 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728103AbgLDNf1 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 4 Dec 2020 08:35:27 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-112-IjqBB8ewNq6TE9Oy5nRVtQ-1; Fri, 04 Dec 2020 13:33:48 +0000
X-MC-Unique: IjqBB8ewNq6TE9Oy5nRVtQ-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Fri, 4 Dec 2020 13:33:47 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Fri, 4 Dec 2020 13:33:47 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Topi Miettinen' <toiwoton@gmail.com>,
        'Mike Rapoport' <rppt@kernel.org>
CC:     "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Linux API <linux-api@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>
Subject: RE: [PATCH] mm/vmalloc: randomize vmalloc() allocations
Thread-Topic: [PATCH] mm/vmalloc: randomize vmalloc() allocations
Thread-Index: AQHWyUIaOaq71c1O10ObeOeJDE6bhanmALEggADFggCAACeloA==
Date:   Fri, 4 Dec 2020 13:33:47 +0000
Message-ID: <f2f19b0c0f4148a8aaa64fd7bdc821d1@AcuMS.aculab.com>
References: <20201201214547.9721-1-toiwoton@gmail.com>
 <9d34fb0a-7aba-1e84-6426-006ea7c3d9f5@gmail.com>
 <20201203065801.GH751215@kernel.org>
 <2a672ff3df0c47538ed7d1974c864f0b@AcuMS.aculab.com>
 <3d20f41c-6c8e-755b-33b4-964b5cc5ac71@gmail.com>
In-Reply-To: <3d20f41c-6c8e-755b-33b4-964b5cc5ac71@gmail.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=C51A453 smtp.mailfrom=david.laight@aculab.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

RnJvbTogVG9waSBNaWV0dGluZW4NCj4gU2VudDogMDQgRGVjZW1iZXIgMjAyMCAxMDo1OA0KPiAN
Cj4gT24gNC4xMi4yMDIwIDEuMTUsIERhdmlkIExhaWdodCB3cm90ZToNCj4gPiBGcm9tOiBNaWtl
IFJhcG9wb3J0DQo+ID4+IFNlbnQ6IDAzIERlY2VtYmVyIDIwMjAgMDY6NTgNCj4gPj4NCj4gPj4g
T24gV2VkLCBEZWMgMDIsIDIwMjAgYXQgMDg6NDk6MDZQTSArMDIwMCwgVG9waSBNaWV0dGluZW4g
d3JvdGU6DQo+ID4+PiBPbiAxLjEyLjIwMjAgMjMuNDUsIFRvcGkgTWlldHRpbmVuIHdyb3RlOg0K
PiA+Pj4+IE1lbW9yeSBtYXBwaW5ncyBpbnNpZGUga2VybmVsIGFsbG9jYXRlZCB3aXRoIHZtYWxs
b2MoKSBhcmUgaW4NCj4gPj4+PiBwcmVkaWN0YWJsZSBvcmRlciBhbmQgcGFja2VkIHRpZ2h0bHkg
dG93YXJkIHRoZSBsb3cgYWRkcmVzc2VzLiBXaXRoDQo+ID4+Pj4gbmV3IGtlcm5lbCBib290IHBh
cmFtZXRlciAncmFuZG9taXplX3ZtYWxsb2M9MScsIHRoZSBlbnRpcmUgYXJlYSBpcw0KPiA+Pj4+
IHVzZWQgcmFuZG9tbHkgdG8gbWFrZSB0aGUgYWxsb2NhdGlvbnMgbGVzcyBwcmVkaWN0YWJsZSBh
bmQgaGFyZGVyIHRvDQo+ID4+Pj4gZ3Vlc3MgZm9yIGF0dGFja2Vycy4NCj4gPg0KPiA+IElzbid0
IHRoYXQgZ29pbmcgdG8gaG9ycmlibHkgZnJhZ21lbnQgdGhlIGF2YWlsYWJsZSBhZGRyZXNzIHNw
YWNlDQo+ID4gYW5kIG1ha2UgZXZlbiBtb2RlcmF0ZSBzaXplZCBhbGxvY2F0aW9uIHJlcXVlc3Rz
IGZhaWwgKG9yIHNsZWVwKS4NCj4gDQo+IEZvciAzMiBiaXQgYXJjaGl0ZWN0dXJlIHRoaXMgaXMg
YSByZWFsIGlzc3VlLCBidXQgSSBkb24ndCB0aGluayBmb3IgNjQNCj4gYml0cyBpdCB3aWxsIGJl
IGEgcHJvYmxlbS4gWW91IGNhbid0IGZyYWdtZW50IHRoZSB2aXJ0dWFsIG1lbW9yeSBzcGFjZQ0K
PiBmb3Igc21hbGwgYWxsb2NhdGlvbnMgYmVjYXVzZSB0aGUgcmVzdWx0aW5nIHBhZ2UgdGFibGVz
IHdpbGwgbm90IGZpdCBpbg0KPiBSQU0gZm9yIGV4aXN0aW5nIG9yIG5lYXIgZnV0dXJlIHN5c3Rl
bXMuDQoNCkhtbW0gdHJ1bHkgcmFuZG9tIGFsbG9jYXRpb25zIGFyZSBnb2luZyB0byBuZWVkIDMg
b3IgNCBleHRyYSBwYWdlIHRhYmxlcw0Kb24gNjRiaXQgc3lzdGVtcy4gQSBiaXQgb3ZlcmhlYWQg
Zm9yIDRrIGFsbG9jYXRlcy4NCldoaWxlIHlvdSB3b24ndCBydW4gb3V0IG9mIGFkZHJlc3Mgc3Bh
Y2UsIHlvdSB3aWxsIHJ1biBvdXQgb2YgbWVtb3J5Lg0KDQpSYW5kb21pc2luZyB0aGUgYWxsb2Nh
dGVkIGFkZHJlc3Mgd2l0aCB0aGUgYXJlYSB0aGF0IGFscmVhZHkNCmhhcyBwYWdlIHRhYmxlcyBh
bGxvY2F0ZWQgbWlnaHQgbWFrZSBhIGJpdCBvZiBzZW5zZS4NClRoZW4gYWxsb2NhdGUgc2ltaWxh
cihpc2gpIHNpemVkIGl0ZW1zIGZyb20gdGhlIHNhbWUgJ2xhcmdlJyBwYWdlcy4NCg0KSSB3YXMg
d29uZGVyaW5nIGlmIGEgZmxhZyBpbmRpY2F0aW5nIHdoZXRoZXIgYW4gYWxsb2NhdGUgd2FzICds
b25nIHRlcm0nDQpvciAnc2hvcnQgdGVybScgbWlnaHQgaGVscCB0aGUgcGxhY2VtZW50Lg0KU2hv
cnQgdGVybSBzbWFsbCBpdGVtcyBjb3VsZCBiZSB1c2VkIHRvIGZpbGwgdGhlIHNwYWNlIGluICds
YXJnZSBwYWdlcycgbGVmdA0KYnkgbm9uLWFsaWduZWQgbGVuZ3RoIGxhcmdlIGl0ZW1zLg0KDQpU
cm91YmxlIGlzIHlvdSBuZWVkIGEgQ0JVIChDcnlzdGFsIEJhbGwgVW5pdCkgdG8gZ2V0IGl0IHJp
Z2h0Lg0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5
IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRp
b24gTm86IDEzOTczODYgKFdhbGVzKQ0K


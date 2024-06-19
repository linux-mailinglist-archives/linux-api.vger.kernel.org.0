Return-Path: <linux-api+bounces-1758-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EF7990E9E6
	for <lists+linux-api@lfdr.de>; Wed, 19 Jun 2024 13:42:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A6871B210D0
	for <lists+linux-api@lfdr.de>; Wed, 19 Jun 2024 11:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C89B713CF82;
	Wed, 19 Jun 2024 11:37:26 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D779E8173C
	for <linux-api@vger.kernel.org>; Wed, 19 Jun 2024 11:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.85.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718797046; cv=none; b=VFypSh31LoMGpaAqwBooP7/6ByomvHRR9r9vgwFrx5xkSY+rbgwDrACUeXyz8LSpTDy6viJU2BC1n/nh2SpBKOIN60TaAKlna+bxzxigR564OeNH5ww8+aU6GpqwJR/hecbaETUI28IsUWRgLGoxOC7XmhWVnLOWdLIUBndmuEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718797046; c=relaxed/simple;
	bh=BSHkKLrECWLAlbeSl4v1U37C/da+oM2lEsa5kkc5HAU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=unRPwLeo7aW7P1fj2D30PiK99Akuco8KOg9as2mIOVHS1s/u5b6UHr7Zc0Bd+tVycxI7F1jCzaIKwcSO6NzfCLjBiTWbiFUVt8KMpSg1//AZY95qTZ/B4BNaksRBh7yH5BnCd5OO/IK4RLJn7O7LlltjV9Su9oNJBPhNubxweEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.85.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-194-CS909xtoNvSfQqELdIGVDA-1; Wed, 19 Jun 2024 12:37:22 +0100
X-MC-Unique: CS909xtoNvSfQqELdIGVDA-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Wed, 19 Jun
 2024 12:36:46 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Wed, 19 Jun 2024 12:36:46 +0100
From: David Laight <David.Laight@ACULAB.COM>
To: "'Jason A. Donenfeld'" <Jason@zx2c4.com>, Andy Lutomirski
	<luto@amacapital.net>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"patches@lists.linux.dev" <patches@lists.linux.dev>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "linux-crypto@vger.kernel.org"
	<linux-crypto@vger.kernel.org>, "linux-api@vger.kernel.org"
	<linux-api@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, Adhemerval Zanella Netto
	<adhemerval.zanella@linaro.org>, Carlos O'Donell <carlos@redhat.com>,
	"Florian Weimer" <fweimer@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Jann
 Horn <jannh@google.com>, Christian Brauner <brauner@kernel.org>, David
 Hildenbrand <dhildenb@redhat.com>
Subject: RE: [PATCH v17 4/5] random: introduce generic vDSO getrandom()
 implementation
Thread-Topic: [PATCH v17 4/5] random: introduce generic vDSO getrandom()
 implementation
Thread-Index: AQHawbWRB8EYMZoZREup+2i1zqOfJbHO9S3w
Date: Wed, 19 Jun 2024 11:36:46 +0000
Message-ID: <e860c5fdea5b4d26b1d95d32e2662a9d@AcuMS.aculab.com>
References: <20240614190646.2081057-1-Jason@zx2c4.com>
 <20240614190646.2081057-5-Jason@zx2c4.com>
 <CALCETrVQtQO87U3SEgQyHfkNKsrcS8PjeZrsy2MPAU7gQY70XA@mail.gmail.com>
 <ZnDQ-HQH8NlmCcIr@zx2c4.com>
 <CALCETrWzXQMXjvL+nGq-+aLVUeiABJ46DACtLnrLXxmwh9s_dg@mail.gmail.com>
 <ZnHftrP3H410gScf@zx2c4.com>
In-Reply-To: <ZnHftrP3H410gScf@zx2c4.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64

RnJvbTogSmFzb24gQS4gRG9uZW5mZWxkDQo+IFNlbnQ6IDE4IEp1bmUgMjAyNCAyMDoyOA0KPiBP
biBUdWUsIEp1biAxOCwgMjAyNCBhdCAxMDo1NToxN0FNIC0wNzAwLCBBbmR5IEx1dG9taXJza2kg
d3JvdGU6DQo+ID4gT24gTW9uLCBKdW4gMTcsIDIwMjQgYXQgNToxMuKAr1BNIEphc29uIEEuIERv
bmVuZmVsZCA8SmFzb25AengyYzQuY29tPiB3cm90ZToNCj4gPiA+DQo+ID4gPiBIaSBBbmR5LA0K
PiA+ID4NCj4gPiA+IE9uIE1vbiwgSnVuIDE3LCAyMDI0IGF0IDA1OjA2OjIyUE0gLTA3MDAsIEFu
ZHkgTHV0b21pcnNraSB3cm90ZToNCj4gPiA+ID4gT24gRnJpLCBKdW4gMTQsIDIwMjQgYXQgMTI6
MDjigK9QTSBKYXNvbiBBLiBEb25lbmZlbGQgPEphc29uQHp4MmM0LmNvbT4gd3JvdGU6DQo+ID4g
PiA+ID4NCj4gPiA+ID4gPiBQcm92aWRlIGEgZ2VuZXJpYyBDIHZEU08gZ2V0cmFuZG9tKCkgaW1w
bGVtZW50YXRpb24sIHdoaWNoIG9wZXJhdGVzIG9uDQo+ID4gPiA+ID4gYW4gb3BhcXVlIHN0YXRl
IHJldHVybmVkIGJ5IHZnZXRyYW5kb21fYWxsb2MoKSBhbmQgcHJvZHVjZXMgcmFuZG9tIGJ5dGVz
DQo+ID4gPiA+ID4gdGhlIHNhbWUgd2F5IGFzIGdldHJhbmRvbSgpLiBUaGlzIGhhcyBhIHRoZSBB
UEkgc2lnbmF0dXJlOg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gICBzc2l6ZV90IHZnZXRyYW5kb20o
dm9pZCAqYnVmZmVyLCBzaXplX3QgbGVuLCB1bnNpZ25lZCBpbnQgZmxhZ3MsIHZvaWQgKm9wYXF1
ZV9zdGF0ZSk7DQo+ID4gPiA+DQo+ID4gPiA+IExhc3QgdGltZSBhcm91bmQsIEkgbWVudGlvbmVk
IHNvbWUgcG90ZW50aWFsIGlzc3VlcyB3aXRoIHRoaXMgZnVuY3Rpb24NCj4gPiA+ID4gc2lnbmF0
dXJlLCBhbmQgSSBkaWRuJ3Qgc2VlIGFueSBhbnN3ZXIuICBNeSBzcGVjaWZpYyBvYmplY3Rpb24g
d2FzIHRvDQo+ID4gPiA+IHRoZSBmYWN0IHRoYXQgdGhlIGNhbGxlciBwYXNzZXMgaW4gYSBwb2lu
dGVyIGJ1dCBub3QgYSBsZW5ndGgsIGFuZA0KPiA+ID4gPiB0aGlzIHBvdGVudGlhbGx5IG1ha2Vz
IHJlYXNvbmluZyBhYm91dCBtZW1vcnkgc2FmZXR5IGF3a3dhcmQsDQo+ID4gPiA+IGVzcGVjaWFs
bHkgaWYgYW55dGhpbmcgbGlrZSBDUklVIGlzIGludm9sdmVkLg0KPiA+ID4NCj4gPiA+IE9oLCBJ
IHVuZGVyc3Rvb2QgdGhpcyBiYWNrd2FyZHMgbGFzdCB0aW1lIC0gSSB0aG91Z2h0IHlvdSB3ZXJl
DQo+ID4gPiBjcml0aWNpemluZyB0aGUgc2l6ZV90IGxlbiBhcmd1bWVudCwgd2hpY2ggZGlkbid0
IG1ha2UgYW55IHNlbnNlLg0KPiA+ID4NCj4gPiA+IFJlLXJlYWRpbmcgbm93LCB3aGF0IHlvdSdy
ZSBzdWdnZXN0aW5nIGlzIHRoYXQgSSBhZGQgYW4gYWRkaXRpb25hbA0KPiA+ID4gYXJndW1lbnQg
Y2FsbGVkIGBzaXplX3Qgb3BhcXVlX2xlbmAsIGFuZCB0aGVuIHRoZSBpbXBsZW1lbnRhdGlvbiBk
b2VzDQo+ID4gPiBzb21ldGhpbmcgbGlrZToNCj4gPiA+DQo+ID4gPiAgICAgaWYgKG9wYXF1ZV9s
ZW4gIT0gc2l6ZW9mKHN0cnVjdCB2Z2V0cmFuZG9tX3N0YXRlKSkNCj4gPiA+ICAgICAgICAgZ290
byBmYWxsYmFja19zeXNjYWxsOw0KPiA+ID4NCj4gPiA+IFdpdGggdGhlIHJlYXNvbmluZyB0aGF0
IGZhbGxpbmcgYmFjayB0byBzeXNjYWxsIGlzIGJldHRlciB0aGFuIHJldHVybmluZw0KPiA+ID4g
LUVJTlZBTCwgYmVjYXVzZSB0aGF0IGNvdWxkIGhhcHBlbiBpbiBhIG5hdHVyYWwgd2F5IGR1ZSB0
byBDUklVLiBJbg0KPiA+ID4gY29udHJhc3QsIHlvdXIgb2JqZWN0aW9uIHRvIG9wYXF1ZV9zdGF0
ZSBub3QgYmVpbmcgYWxpZ25lZCBmYWxsaW5nIGJhY2sNCj4gPiA+IHRvIHRoZSBzeXNjYWxsIHdh
cyB0aGF0IGl0IHNob3VsZCBuZXZlciBoYXBwZW4gZXZlciwgc28gLUVGQVVMVCBpcyBtb3JlDQo+
ID4gPiBmaXR0aW5nLg0KPiA+ID4NCj4gPiA+IElzIHRoYXQgY29ycmVjdD8NCj4gPg0KPiA+IE15
IGFsdGVybmF0aXZlIHN1Z2dlc3Rpb24sIHdoaWNoIGlzIGZhciBsZXNzIHdlbGwgZm9ybWVkLCB3
b3VsZCBiZSB0bw0KPiA+IG1ha2UgdGhlIG9wYXF1ZSBhcmd1bWVudCBiZSBzb21laG93IG5vdCBw
b2ludGVyLWxpa2UgYW5kIGJlIG1vcmUgb2YgYW4NCj4gPiBvcGFxdWUgaGFuZGxlLiAgU28gaXQg
d291bGQgYmUgdWludHB0cl90IGluc3RlYWQgb2Ygdm9pZCAqLCBhbmQgdGhlDQo+ID4gdXNlciBB
UEkgd291bGQgYmUgYnVpbHQgYXJvdW5kIHRoZSB1c2VyIGdldHRpbmcgYSBsaXN0IG9mIGhhbmRs
ZXMNCj4gPiBpbnN0ZWFkIG9mIGEgYmxvY2sgb2YgbWVtb3J5Lg0KPiA+DQo+ID4gVGhlIGJlbmVm
aXQgd291bGQgYmUgYSB0aW55IGJpdCBsZXNzIG92ZXJoZWFkIChwb3RlbnRpYWxseSksIGJ1dCB0
aGUNCj4gPiBBUEkgd291bGQgbmVlZCBzdWJzdGFudGlhbGx5IG1vcmUgcmV3b3JrLiAgSSdtIG5v
dCBjb252aW5jZWQgdGhhdCB0aGlzDQo+ID4gd291bGQgYmUgd29ydGh3aGlsZS4NCj4gDQo+IEkn
ZCB0aG91Z2h0IGFib3V0IHRoaXMgdG9vIC0tIGEgV2luZG93cy1zdHlsZSBoYW5kbGUgc3lzdGVt
IC0tIGJ1dA0KPiBpdCBzZWVtZWQgY29tcGxpY2F0ZWQgYW5kIGp1c3Qgbm90IHdvcnRoIGl0LCBz
byB0aGUgc2ltcGxpY2l0eSBoZXJlDQo+IHNlZW1zIG1vcmUgYXBwZWFsaW5nLiBJJ20gaGFwcHkg
dG8gdGFrZSB5b3VyIHN1Z2dlc3Rpb24gb2YgYW4gb3BhcXVlX2xlbg0KPiBhcmd1bWVudCAoYW5k
IGl0J3MgYWxyZWFkeSBpbXBsZW1lbnRlZCBpbiBteSAidmRzbyIgYnJhbmNoKSwgYW5kDQo+IGxl
YXZpbmcgaXQgYXQgdGhhdC4NCg0KVGhleSBkb24ndCB3b3JrIGVpdGhlci4uLg0KDQpQcm9iYWJs
eSBiZXN0IGlzIHRvIG1ha2UgaXQgJ3N0cnVjdCB2Z2V0cmFuZG9tX3N0YXRlIConIGJ1dCBuZXZl
cg0KYWN0dWFsbHkgZGVmaW5lIHRoYXQgc3RydWN0dXJlIGluIGFueSB1c2VyIGhlYWRlci4NClRo
ZW4gYXQgbGVhc3QgdGhlIGFwcGxpY2F0aW9uIGdldHMgc29tZSB0eXBlIGNoZWNraW5nIGZyb20g
dGhlIGNvbXBpbGVyDQp0aGF0IHRoZSBjb3JyZWN0IHBvaW50ZXIgaXMgYmVpbmcgcGFzc2VkLg0K
DQpEZXBlbmRpbmcgb24gd2hlcmUvaG93IHRoZSBkYXRhIGlzIGFsbG9jYXRlZCB5b3UgbWF5IHRo
ZW4gbm90IG5lZWQNCmEgbGVuZ3RoPyANCg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVz
cyBMYWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEg
MVBULCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==



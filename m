Return-Path: <linux-api+bounces-1598-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D66EA8CE1CB
	for <lists+linux-api@lfdr.de>; Fri, 24 May 2024 09:52:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 147041C20D64
	for <lists+linux-api@lfdr.de>; Fri, 24 May 2024 07:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9360D82D7A;
	Fri, 24 May 2024 07:52:47 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFC2D374FF
	for <linux-api@vger.kernel.org>; Fri, 24 May 2024 07:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.86.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716537167; cv=none; b=LSbo+7BFvXb16dmUrm0vE5wh3ka7+DGzO9SVge3b4Np4AKIyYpCwky2cWbzuVHOTwXBe/9aAkDwh7X53Mc2P/jCkHSW4Tu0JvexxxnayTn+YWw5ibdWJM4qRE+gdEdpO43UmgGHHpUuehj1MzfafoloaW6aYLnCO2gOxqjS7BgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716537167; c=relaxed/simple;
	bh=0WCNFDXp1xMSbC4bwKH3Ol6IPf4WEDGeRYHim8+28wU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=gi0O3Z4uY/ejDlSoi3flmKLk0wcei7CihF48IR5T0obtgBd4dq1JEXJGgyi/kzQ0F3L5/CaX4XSWyfwk6x/ZInVfrZq5jmcz1JOfHSLDr7vQGMY3aM4NYKAqEz2k4vB4PQXiKN47qWy9zk0cDL/QO+xFdXCjYZLRUFyC6fIc2+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.86.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-199-p_PFq1w1MwCWhi6R7Pg5-g-1; Fri, 24 May 2024 08:52:37 +0100
X-MC-Unique: p_PFq1w1MwCWhi6R7Pg5-g-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Fri, 24 May
 2024 08:52:05 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Fri, 24 May 2024 08:52:05 +0100
From: David Laight <David.Laight@ACULAB.COM>
To: =?utf-8?B?J0FuZHLDqSBBbG1laWRhJw==?= <andrealmeid@igalia.com>, "Mathieu
 Desnoyers" <mathieu.desnoyers@efficios.com>, Peter Zijlstra
	<peterz@infradead.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Thomas
 Gleixner" <tglx@linutronix.de>, "Paul E . McKenney" <paulmck@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>, "H . Peter Anvin" <hpa@zytor.com>, "Paul
 Turner" <pjt@google.com>, "linux-api@vger.kernel.org"
	<linux-api@vger.kernel.org>, Christian Brauner <brauner@kernel.org>, "Florian
 Weimer" <fw@deneb.enyo.de>, "carlos@redhat.com" <carlos@redhat.com>, "Peter
 Oskolkov" <posk@posk.io>, Alexander Mikhalitsyn <alexander@mihalicyn.com>,
	Chris Kennelly <ckennelly@google.com>, Ingo Molnar <mingo@redhat.com>,
	"Darren Hart" <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>,
	"libc-alpha@sourceware.org" <libc-alpha@sourceware.org>, Steven Rostedt
	<rostedt@goodmis.org>, Jonathan Corbet <corbet@lwn.net>, Noah Goldstein
	<goldstein.w.n@gmail.com>, Daniel Colascione <dancol@google.com>,
	"longman@redhat.com" <longman@redhat.com>, "kernel-dev@igalia.com"
	<kernel-dev@igalia.com>
Subject: RE: [PATCH v2 1/1] futex: Add FUTEX_SPIN operation
Thread-Topic: [PATCH v2 1/1] futex: Add FUTEX_SPIN operation
Thread-Index: AQHarUzWukUXPS/11kKDb3WyV7rGCLGmAfcw
Date: Fri, 24 May 2024 07:52:05 +0000
Message-ID: <16a6a6f28cc547b7a0a27ae6eebcca43@AcuMS.aculab.com>
References: <20240523200704.281514-1-andrealmeid@igalia.com>
 <20240523200704.281514-2-andrealmeid@igalia.com>
In-Reply-To: <20240523200704.281514-2-andrealmeid@igalia.com>
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

RnJvbTogQW5kcsOpIEFsbWVpZGENCj4gU2VudDogMjMgTWF5IDIwMjQgMjE6MDcNCj4gDQo+IEFk
ZCBhIG5ldyBtb2RlIGZvciBmdXRleCB3YWl0LCB0aGUgZnV0ZXggc3Bpbi4NCj4gDQo+IEdpdmVu
IHRoZSBGVVRFWDJfU1BJTiBmbGFnLCBwYXJzZSB0aGUgZnV0ZXggdmFsdWUgYXMgdGhlIFRJRCBv
ZiB0aGUgbG9jaw0KPiBvd25lci4gVGhlbiwgYmVmb3JlIGdvaW5nIHRvIHRoZSBub3JtYWwgd2Fp
dCBwYXRoLCBzcGlucyB3aGlsZSB0aGUgbG9jaw0KPiBvd25lciBpcyBydW5uaW5nIGluIGEgZGlm
ZmVyZW50IENQVSwgdG8gYXZvaWQgdGhlIHdob2xlIGNvbnRleHQgc3dpdGNoDQo+IG9wZXJhdGlv
biBhbmQgdG8gcXVpY2tseSByZXR1cm4gdG8gdXNlcnNwYWNlLiBJZiB0aGUgbG9jayBvd25lciBp
cyBub3QNCj4gcnVubmluZywganVzdCBzbGVlcCBhcyB0aGUgbm9ybWFsIGZ1dGV4IHdhaXQgcGF0
aC4NCj4gDQo+IFRoZSB1c2VyIHZhbHVlIGlzIG1hc2tlZCB3aXRoIEZVVEVYX1RJRF9NQVNLLCB0
byBhbGxvdyBzb21lIGJpdHMgZm9yDQo+IGZ1dHVyZSB1c2UuDQo+IA0KPiBUaGUgY2hlY2sgZm9y
IHRoZSBvd25lciB0byBiZSBydW5uaW5nIG9yIG5vdCBpcyBpbXBvcnRhbnQgdG8gYXZvaWQNCj4g
c3Bpbm5pbmcgZm9yIHNvbWV0aGluZyB0aGF0IHdvbid0IGJlIHJlbGVhc2VkIHF1aWNrbHkuIFVz
ZXJzcGFjZSBpcw0KPiByZXNwb25zaWJsZSBvbiBwcm92aWRpbmcgdGhlIHByb3BlciBUSUQsIHRo
ZSBrZXJuZWwgZG9lcyBhIGJhc2ljIGNoZWNrLg0KDQpUaGUga2VybmVsIG5lZWRzIHRvIGRvIHNv
bWV0aGluZyB0byBzdG9wIGEgdXNlci1wcm9jZXNzIHNwaW5uaW5nIGluLWtlcm5lbA0KaW5kZWZp
bml0ZWx5Lg0KDQouLi4NCj4gK3N0YXRpYyBpbmxpbmUgYm9vbCB0YXNrX29uX2NwdShzdHJ1Y3Qg
dGFza19zdHJ1Y3QgKnApDQo+ICt7DQo+ICsjaWZkZWYgQ09ORklHX1NNUA0KPiArCXJldHVybiAh
IShwLT5vbl9jcHUpOw0KPiArI2Vsc2UNCj4gKwlyZXR1cm4gZmFsc2U7DQo+ICsjZW5kaWYNCj4g
K30NCg0KSSBzdXNwZWN0IHRoYXQgaXNuJ3QgZ29pbmcgdG8gd29yayBpbiBhIFZNIHdoZXJlIHRo
ZSBlbnRpcmUgJ2NwdScNCmNhbiBiZSBzbGVlcGluZy4NCg0KVGhpcyBpcyBzaW1pbGFyIHRvIHRo
ZSAoSSBkb24ndCB0aGluayB3b3JrcyBwcm9wZXJseSkgY2hlY2sNCmluIHRoZSAnb3NxJyAob3B0
aW1pc3RpYyBzcGluIHF1ZXVlKSB1c2VkIHdoZW4gd2FpdGluZyBmb3INCnRoZSB0aHJlYWQgc3Bp
bm5pbmcgb24gYSBtdXRleC9yd2xvY2sgdG8gY2hhbmdlIHN0YXRlLg0KDQpJSVJDIHRoYXQgY29k
ZSBhbHNvIGNoZWNrcyB3aGV0aGVyIHRoZSBjdXJyZW50IHRocmVhZCBzaG91bGQNCmJlIHByZS1l
bXB0ZWQgYnkgYSBoaWdoZXIgcHJpb3JpdHkgcHJvY2Vzcy4NCg0KCURhdmlkDQoNCi0NClJlZ2lz
dGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24g
S2V5bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==



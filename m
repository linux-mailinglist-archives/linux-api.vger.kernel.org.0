Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ECC4F45E30
	for <lists+linux-api@lfdr.de>; Fri, 14 Jun 2019 15:30:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728067AbfFNN3d (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 14 Jun 2019 09:29:33 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:52159 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727970AbfFNN3d (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 14 Jun 2019 09:29:33 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-94-RqD6NxA4PzKkGGWAwFsofQ-1; Fri, 14 Jun 2019 14:29:30 +0100
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b::d117) by AcuMS.aculab.com
 (fd9f:af1c:a25b::d117) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri,
 14 Jun 2019 14:29:29 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Fri, 14 Jun 2019 14:29:29 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Mathieu Desnoyers' <mathieu.desnoyers@efficios.com>,
        Florian Weimer <fweimer@redhat.com>
CC:     carlos <carlos@redhat.com>, Joseph Myers <joseph@codesourcery.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        libc-alpha <libc-alpha@sourceware.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ben Maurer <bmaurer@fb.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        Dave Watson <davejwatson@fb.com>, Paul Turner <pjt@google.com>,
        Rich Felker <dalias@libc.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api <linux-api@vger.kernel.org>
Subject: RE: [PATCH 1/5] glibc: Perform rseq(2) registration at C startup and
 thread creation (v10)
Thread-Topic: [PATCH 1/5] glibc: Perform rseq(2) registration at C startup and
 thread creation (v10)
Thread-Index: AdUitTFqJqb3c4uCSB28nMsheH09dA==
Date:   Fri, 14 Jun 2019 13:29:29 +0000
Message-ID: <69a53ec2ce184af29c4cae58e0b2fb57@AcuMS.aculab.com>
References: <20190503184219.19266-1-mathieu.desnoyers@efficios.com>
 <c16c9785-7f8c-430b-a4df-a53e47bf1600@redhat.com>
 <914051741.43025.1560348011775.JavaMail.zimbra@efficios.com>
 <802638054.3032.1560506584705.JavaMail.zimbra@efficios.com>
 <87ftocwkei.fsf@oldenburg2.str.redhat.com>
 <1635690189.3049.1560507249693.JavaMail.zimbra@efficios.com>
 <87tvcsv1pk.fsf@oldenburg2.str.redhat.com>
 <1190407525.3131.1560516910936.JavaMail.zimbra@efficios.com>
 <1085273942.3137.1560517301721.JavaMail.zimbra@efficios.com>
In-Reply-To: <1085273942.3137.1560517301721.JavaMail.zimbra@efficios.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: RqD6NxA4PzKkGGWAwFsofQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

RnJvbTogTWF0aGlldSBEZXNub3llcnMNCj4gU2VudDogMTQgSnVuZSAyMDE5IDE0OjAyDQouLi4N
Cj4gQnV0IG15IG9yaWdpbmFsIGlzc3VlIHJlbWFpbnM6IGlmIEkgZGVmaW5lIGEgdmFyaWFibGUg
Y2FsbGVkIF9fcnNlcV9oYW5kbGVkDQo+IHdpdGhpbiBlaXRoZXIgdGhlIG1haW4gZXhlY3V0YWJs
ZSBvciB0aGUgcHJlbG9hZGVkIGxpYnJhcnksIGl0IG92ZXJzaGFkb3dzDQo+IHRoZSBsaWJjIG9u
ZToNCg0KMSkgVGhhdCBpcyB0aGUgd2FzIGVsZiBzeW1ib2wgcmVzb2x1dGlvbiBpcyByZXF1aXJl
ZCB0byB3b3JrLg0KICAgT3RoZXJ3aXNlIHZhcmlhYmxlcyBsaWtlICdlcnJubycgKG5vbi10aHJl
YWQgc2FmZSBmb3JtKSB3b3VsZG4ndCB3b3JrLg0KDQoyKSBEb24ndCBkbyBpdCB0aGVuIDotKQ0K
ICAgTmFtZXMgc3RhcnRpbmcgd2l0aCBfXyB3aWxsIGJlIHJlc2VydmVkIChwcm9iYWJseSAnZm9y
IHRoZSBpbXBsZW1lbnRhdGlvbicpLg0KDQpUaGUgcmVhbCAnZnVuJyBzdGFydHMgYmVjYXVzZSwg
dW5kZXIgc29tZSBjaXJjdW1zdGFuY2VzLCBsb29raW5nIHVwIGEgc3ltYm9sIGFzOg0KCWZvbyA9
IGRsc3ltKGxpYl9oYW5kbGUsICJmb28iKTsNCkNhbiBmaW5kIHRoZSBkYXRhIGl0ZW0gaW5zdGVh
ZCBvZiB0aGUgZnVuY3Rpb24hDQpVc3VhbGx5IGl0IHdvcmtzIChldmVuIHdoZW4gZm9vIGlzIGds
b2JhbCBkYXRhKSBiZWNhdXNlICdsaWJfaGFuZGxlJyByZWZlcnMNCnRvIGEgZGlmZmVyZW50IHN5
bWJvbCB0YWJsZS4NCkJ1dCBpdCBjYW4gZ28gaG9ycmlibHkgd3JvbmcuDQoNCglEYXZpZA0KDQot
DQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwg
TWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2Fs
ZXMpDQo=


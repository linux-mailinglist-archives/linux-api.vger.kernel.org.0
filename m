Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03DA534F3E7
	for <lists+linux-api@lfdr.de>; Wed, 31 Mar 2021 00:02:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232879AbhC3WCF (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 30 Mar 2021 18:02:05 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.85.151]:55352 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232909AbhC3WBg (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 30 Mar 2021 18:01:36 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-56-VPkzaPYQPbW1z4A_hL62xg-1; Tue, 30 Mar 2021 23:01:29 +0100
X-MC-Unique: VPkzaPYQPbW1z4A_hL62xg-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.2; Tue, 30 Mar 2021 23:01:28 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.012; Tue, 30 Mar 2021 23:01:28 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Len Brown' <lenb@kernel.org>,
        Andy Lutomirski <luto@amacapital.net>
CC:     Dave Hansen <dave.hansen@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        "Bae, Chang Seok" <chang.seok.bae@intel.com>,
        X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        libc-alpha <libc-alpha@sourceware.org>,
        Florian Weimer <fweimer@redhat.com>,
        Rich Felker <dalias@libc.org>, Kyle Huey <me@kylehuey.com>,
        Keno Fischer <keno@juliacomputing.com>,
        Linux API <linux-api@vger.kernel.org>
Subject: RE: Candidate Linux ABI for Intel AMX and hypothetical new related
 features
Thread-Topic: Candidate Linux ABI for Intel AMX and hypothetical new related
 features
Thread-Index: AQHXJaVUlzUXmfEGake4TC38qhSBR6qdEWYA
Date:   Tue, 30 Mar 2021 22:01:28 +0000
Message-ID: <4aa49572cc5f4797922352d1760f3ef4@AcuMS.aculab.com>
References: <d10affcb-d315-cebc-4162-084f0a1e4d43@intel.com>
 <F2653B18-239A-42BB-84EE-04F18B712279@amacapital.net>
 <CAJvTdKnwexRpHrLFQv+2ykK9WEqtXMwehjfa_D7T+O_8DO_CGA@mail.gmail.com>
In-Reply-To: <CAJvTdKnwexRpHrLFQv+2ykK9WEqtXMwehjfa_D7T+O_8DO_CGA@mail.gmail.com>
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

RnJvbTogTGVuIEJyb3duDQo+IFNlbnQ6IDMwIE1hcmNoIDIwMjEgMjE6NDINCj4gDQo+IE9uIFR1
ZSwgTWFyIDMwLCAyMDIxIGF0IDQ6MjAgUE0gQW5keSBMdXRvbWlyc2tpIDxsdXRvQGFtYWNhcGl0
YWwubmV0PiB3cm90ZToNCj4gPg0KPiA+DQo+ID4gPiBPbiBNYXIgMzAsIDIwMjEsIGF0IDEyOjEy
IFBNLCBEYXZlIEhhbnNlbiA8ZGF2ZS5oYW5zZW5AaW50ZWwuY29tPiB3cm90ZToNCj4gPiA+DQo+
ID4gPiDvu79PbiAzLzMwLzIxIDEwOjU2IEFNLCBMZW4gQnJvd24gd3JvdGU6DQo+ID4gPj4gT24g
VHVlLCBNYXIgMzAsIDIwMjEgYXQgMTowNiBQTSBBbmR5IEx1dG9taXJza2kgPGx1dG9AYW1hY2Fw
aXRhbC5uZXQ+IHdyb3RlOg0KPiA+ID4+Pj4gT24gTWFyIDMwLCAyMDIxLCBhdCAxMDowMSBBTSwg
TGVuIEJyb3duIDxsZW5iQGtlcm5lbC5vcmc+IHdyb3RlOg0KPiA+ID4+Pj4gSXMgaXQgcmVxdWly
ZWQgKGJ5IHRoZSAiQUJJIikgdGhhdCBhIHVzZXIgcHJvZ3JhbSBoYXMgZXZlcnl0aGluZw0KPiA+
ID4+Pj4gb24gdGhlIHN0YWNrIGZvciB1c2VyLXNwYWNlIFhTQVZFL1hSRVNUT1IgdG8gZ2V0IGJh
Y2sNCj4gPiA+Pj4+IHRvIHRoZSBzdGF0ZSBvZiB0aGUgcHJvZ3JhbSBqdXN0IGJlZm9yZSByZWNl
aXZpbmcgdGhlIHNpZ25hbD8NCj4gPiA+Pj4gVGhlIGN1cnJlbnQgTGludXggc2lnbmFsIGZyYW1l
IGZvcm1hdCBoYXMgWFNUQVRFIGluIHVuY29tcGFjdGVkIGZvcm1hdCwNCj4gPiA+Pj4gc28gZXZl
cnl0aGluZyBoYXMgdG8gYmUgdGhlcmUuDQo+ID4gPj4+IE1heWJlIHdlIGNvdWxkIGhhdmUgYW4g
b3B0IGluIG5ldyBzaWduYWwgZnJhbWUgZm9ybWF0LCBidXQgdGhlIGRldGFpbHMgd291bGQgbmVl
ZCB0byBiZSB3b3JrZWQNCj4gb3V0Lg0KPiA+ID4+Pg0KPiA+ID4+PiBJdCBpcyBjZXJ0YWlubHkg
dGhlIGNhc2UgdGhhdCBhIHNpZ25hbCBzaG91bGQgYmUgYWJsZSB0byBiZSBkZWxpdmVyZWQsIHJ1
biDigJxhc3luYy1zaWduYWwtc2FmZeKAnQ0KPiBjb2RlLA0KPiA+ID4+PiBhbmQgcmV0dXJuLCB3
aXRob3V0IGNvcnJ1cHRpbmcgcmVnaXN0ZXIgY29udGVudHMuDQo+ID4gPj4gQW5kIHNvIGFuIGFu
IGFja25vd2xlZGdlbWVudDoNCj4gPiA+Pg0KPiA+ID4+IFdlIGNhbid0IGNoYW5nZSB0aGUgbGVn
YWN5IHNpZ25hbCBzdGFjayBmb3JtYXQgd2l0aG91dCBicmVha2luZw0KPiA+ID4+IGV4aXN0aW5n
IHByb2dyYW1zLiAgVGhlIGxlZ2FjeSBpcyB1bmNvbXByZXNzZWQgWFNUQVRFLiAgSXQgaXMgYQ0K
PiA+ID4+IGNvbXBsZXRlIHNldCBvZiBhcmNoaXRlY3R1cmFsIHN0YXRlIC0tIGV2ZXJ5dGhpbmcg
bmVjZXNzYXJ5IHRvDQo+ID4gPj4gWFJFU1RPUi4gIEZ1cnRoZXIsIHRoZSBzaWdyZXR1cm4gZmxv
dyBhbGxvd3MgdGhlIHNpZ25hbCBoYW5kbGVyIHRvDQo+ID4gPj4gKmNoYW5nZSogYW55IG9mIHRo
YXQgc3RhdGUsIHNvIHRoYXQgaXQgYmVjb21lcyBhY3RpdmUgdXBvbiByZXR1cm4gZnJvbQ0KPiA+
ID4+IHNpZ25hbC4NCj4gPiA+DQo+ID4gPiBPbmUgbml0IHdpdGggdGhpczogWFJTVE9SIGl0c2Vs
ZiBjYW4gd29yayB3aXRoIHRoZSBjb21wYWN0ZWQgZm9ybWF0IG9yDQo+ID4gPiB1bmNvbXBhY3Rl
ZCBmb3JtYXQuICBVbmxpa2UgdGhlIFhTQVZFL1hTQVZFQyBzaWRlIHdoZXJlIGNvbXBhY3Rpb24g
aXMNCj4gPiA+IGV4cGxpY2l0IGZyb20gdGhlIGluc3RydWN0aW9uIGl0c2VsZiwgWFJTVE9SIGNo
YW5nZXMgaXRzIGJlaGF2aW9yIGJ5DQo+ID4gPiByZWFkaW5nIFhDT01QX0JWLiAgVGhlcmUncyBu
byBYUlNUT1JDLg0KPiA+ID4NCj4gPiA+IFRoZSBpc3N1ZSB3aXRoIHVzaW5nIHRoZSBjb21wYWN0
ZWQgZm9ybWF0IGlzIHdoZW4gbGVnYWN5IHNvZnR3YXJlIGluIHRoZQ0KPiA+ID4gc2lnbmFsIGhh
bmRsZXIgbmVlZHMgdG8gZ28gYWNjZXNzIHRoZSBzdGF0ZS4gICpUaGF0KiBpcyB3aGF0IGNhbid0
DQo+ID4gPiBoYW5kbGUgYSBjaGFuZ2UgaW4gdGhlIFhTQVZFIGJ1ZmZlciBmb3JtYXQgKGVpdGhl
ciBvcHRpbWl6ZWQvWFNBVkVPUFQsDQo+ID4gPiBvciBjb21wYWN0ZWQvWFNBVkVDKS4NCj4gPg0K
PiA+IFRoZSBjb21wYWN0ZWQgZm9ybWF0IGlzbuKAmXQgY29tcGFjdCBlbm91Z2ggYW55d2F5LiBJ
ZiB3ZSB3YW50IHRvIGtlZXAgQU1YIGFuZCBBVlg1MTIgZW5hYmxlZCBpbiBYQ1IwDQo+IHRoZW4g
d2UgbmVlZCB0byBmdXJ0aGVyIG11Y2sgd2l0aCB0aGUgZm9ybWF0IHRvIG9taXQgdGhlIG5vdC1p
bi11c2UgZmVhdHVyZXMuIEkgKnRoaW5rKiB3ZSBjYW4gcHVsbA0KPiB0aGlzIG9mZiBpbiBhIHdh
eSB0aGF0IHN0aWxsIGRvZXMgdGhlIHJpZ2h0IHRoaW5nIHdydCBYUlNUT1IuDQo+IA0KPiBBZ3Jl
ZWQuICBDb21wYWN0ZWQgZm9ybWF0IGRvZXNuJ3Qgc2F2ZSBhbnkgc3BhY2Ugd2hlbiBJTklUPTAs
IHNvIGl0IGlzDQo+IG9ubHkgYSBoYWxmLXN0ZXAgZm9yd2FyZC4NCj4gDQo+ID4gSWYgd2UgZ28g
dGhpcyByb3V0ZSwgSSB0aGluayB3ZSB3YW50IGEgd2F5IGZvciBzaWdyZXR1cm4gdG8gdW5kZXJz
dGFuZCBhIHBvaW50ZXIgdG8gdGhlIHN0YXRlDQo+IGluc3RlYWQgb2YgaW5saW5lIHN0YXRlIHRv
IGFsbG93IHByb2dyYW1zIHRvIGNoYW5nZSB0aGUgc3RhdGUuICBPciBtYXliZSBqdXN0IHRvIGhh
dmUgYSB3YXkgdG8gYXNrDQo+IHNpZ3JldHVybiB0byBza2lwIHRoZSByZXN0b3JlIGVudGlyZWx5
Lg0KPiANCj4gVGhlIGxlZ2FjeSBhcHByb2FjaCBwdXRzIGFsbCBhcmNoaXRlY3R1cmFsIHN0YXRl
IG9uIHRoZSBzaWduYWwgc3RhY2sNCj4gaW4gWFNUQVRFIGZvcm1hdC4NCj4gDQo+IElmIHdlIG1h
a2UgdGhlIHNpZ25hbCBzdGFjayBzbWFsbGVyIHdpdGggYSBuZXcgZmFzdC1zaWduYWwgc2NoZW1l
LCB3ZQ0KPiBuZWVkIHRvIGZpbmQgYW5vdGhlciBwbGFjZSBmb3IgdGhhdCBzdGF0ZSB0byBsaXZl
Lg0KPiANCj4gSXQgY2FuJ3QgbGl2ZSBpbiB0aGUgdGFzayBjb250ZXh0IHN3aXRjaCBidWZmZXIu
ICBJZiB3ZSBwdXQgaXQgdGhlcmUNCj4gYW5kIHRoZW4gdGFrZSBhbiBpbnRlcnJ1cHQgd2hpbGUg
cnVubmluZyB0aGUgc2lnbmFsIGhhbmRsZXIsIHRoZW4gd2UnZA0KPiBvdmVyd3JpdGUgdGhlIHNp
Z25hbGVkIHRocmVhZCdzIHN0YXRlIHdpdGggdGhlIHNpZ25hbCBoYW5kbGVyJ3Mgc3RhdGUuDQo+
IA0KPiBDYW4gd2UgbGVhdmUgaXQgaW4gbGl2ZSByZWdpc3RlcnM/ICBUaGF0IHdvdWxkIGJlIHRo
ZSBzcGVlZC1vZi1saWdodA0KPiBzaWduYWwgaGFuZGxlciBhcHByb2FjaC4gIEJ1dCB3ZSdkIG5l
ZWQgdG8gdGVhY2ggdGhlIHNpZ25hbCBoYW5kbGVyIHRvDQo+IG5vdCBjbG9iYmVyIGl0LiAgUGVy
aGFwcyB0aGF0IGNvdWxkIGJlIHBhcnQgb2YgdGhlIGNvbnRyYWN0IHRoYXQgYQ0KPiBmYXN0IHNp
Z25hbCBoYW5kbGVyIHNpZ25zPyAgSU5JVD0wIEFNWCBzdGF0ZSBjb3VsZCBzaW1wbHkgc2l0DQo+
IHBhdGllbnRseSBpbiB0aGUgQU1YIHJlZ2lzdGVycyBmb3IgdGhlIGR1cmF0aW9uIG9mIHRoZSBz
aWduYWwgaGFuZGxlci4NCj4gWW91IGNhbid0IGdldCBhbnkgZmFzdGVyIHRoYW4gZG9pbmcgbm90
aGluZyA6LSkNCj4gDQo+IE9mIGNvdXJzZSBwYXJ0IG9mIHRoZSBjb250cmFjdCBmb3IgdGhlIGZh
c3Qgc2lnbmFsIGhhbmRsZXIgaXMgdGhhdCBpdA0KPiBrbm93cyB0aGF0IGl0IGNhbid0IHBvc3Np
Ymx5IHVzZSBYUkVTVE9SIG9mIHRoZSBzdHVmZiBvbiB0aGUgc3RhY2sgdG8NCj4gbmVjZXNzYXJp
bHkgZ2V0IGJhY2sgdG8gdGhlIHN0YXRlIG9mIHRoZSBzaWduYWxlZCB0aHJlYWQgKGFzc3VtaW5n
IHdlDQo+IGV2ZW4gdXNlZCBYU1RBVEUgZm9ybWF0IG9uIHRoZSBmYXN0IHNpZ25hbCBoYW5kbGVy
IHN0YWNrLCBpdCB3b3VsZA0KPiBmb3JnZXQgdGhlIGNvbnRlbnRzIG9mIHRoZSBBTVggcmVnaXN0
ZXJzLCBpbiB0aGlzIGV4YW1wbGUpDQoNCmdjYyB3aWxsIGp1c3QgdXNlIHRoZSBBVlggcmVnaXN0
ZXJzIGZvciAnbm9ybWFsJyBjb2RlIHdpdGhpbg0KdGhlIHNpZ25hbCBoYW5kbGVyLg0KU28gaXQg
aGFzIHRvIGhhdmUgaXRzIG93biBjb3B5IG9mIGFsbCB0aGUgcmVnaXN0ZXJzLg0KKFdlbGwsIG1h
eWJlIHlvdSBjb3VsZCBtYWtlIHRoZSBUTVggaW5zdHJ1Y3Rpb25zIGZhdWx0LA0KYnV0IHRoYXQg
d291bGQgbmVlZCBhIG5lc3RlZCBzaWduYWwgZGVsaXZlcmVkLikNCg0KVGhlcmUgaXMgYWxzbyB0
aGUgcmVnaXN0ZXIgc2F2ZSBidWZmZXIgdGhhdCB5b3UgbmVlZCBpbiBvcmRlcg0KdG8gbG9uZy1q
dW1wIG91dCBvZiBhIHNpZ25hbCBoYW5kbGVyLg0KVW5mb3J0dW5hdGVseSB0aGF0IGlzIHJlcXVp
cmVkIHRvIHdvcmsuDQpJJ20gcHJldHR5IHN1cmUgdGhlIG9yaWdpbmFsIHNldGptcC9sb25nam1w
IGp1c3Qgc2F2ZWQgdGhlIHN0YWNrDQpwb2ludGVyIC0gYnV0IHRoYXQgcmVhbGx5IGRvZXNuJ3Qg
d29yayBhbnkgbW9yZS4NCg0KT1RPSCBtb3N0IHNpZ25hbCBoYW5kbGVycyBkb24ndCBjYXJlIC0g
YnV0IHRoZXJlIGlzbid0IGEgZmxhZw0KdG8gc2lnc2V0KCkgKGV0Yykgc28gYXNrIGZvciBhIHNw
ZWNpZmljIHJlZ2lzdGVyIGxheW91dC4NCg0KSSBkaWQgaGF2ZSAnZnVuJyBjaGFuZ2luZyB0aGUg
eDg2IHNlZ21lbnQgcmVnaXN0ZXJzIHNvIHRoYXQNCnRoZSAncmV0dXJuIHRvIHVzZXInIGZhdWx0
ZWQgaW4ga2VybmVsIGR1cmluZyB0aGUgbGFzdCBiaXQNCm9mIHRoZSAncmV0dXJuIHRvIHVzZXIn
IHBhdGggLSBhbmQgdGhlbiBmaXhpbmcgdGhlIGZhbGxvdXQuDQoNCglEYXZpZA0KDQotDQpSZWdp
c3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9u
IEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=


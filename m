Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8D9F35BB86
	for <lists+linux-api@lfdr.de>; Mon, 12 Apr 2021 09:59:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236974AbhDLIAL (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 12 Apr 2021 04:00:11 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:48710 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236808AbhDLIAL (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 12 Apr 2021 04:00:11 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-177-w4-rwq0vMZOVpPL_bKeeTg-1; Mon, 12 Apr 2021 08:59:50 +0100
X-MC-Unique: w4-rwq0vMZOVpPL_bKeeTg-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.2; Mon, 12 Apr 2021 08:59:49 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.012; Mon, 12 Apr 2021 08:59:49 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Len Brown' <lenb@kernel.org>, Andy Lutomirski <luto@kernel.org>
CC:     Dave Hansen <dave.hansen@intel.com>,
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
Thread-Index: AQHXLwXzDTWBaounok6N1DMugTlKTaqwgXFQ
Date:   Mon, 12 Apr 2021 07:59:49 +0000
Message-ID: <7f38dca513424e8ca1d99074ad6c4621@AcuMS.aculab.com>
References: <CAJvTdK=evAofQRcmt_iwtYx2f_wTGUDpXzvjuiVwgZZ6BZV_Qg@mail.gmail.com>
 <E8BCA270-4F23-4E1B-BAD6-917DBE36F5F6@amacapital.net>
 <CAJvTdK=Lqbzy6bs8qiE8MZ5LSzyZJ-FMUTcNPD4MxYJGEMBW3g@mail.gmail.com>
 <CALCETrW_5QDSo2sfEjBZSJ=Q3EsXTc03Unztn0Rq1caxqwtWpw@mail.gmail.com>
 <CAJvTdKkDUywOUxb8Toth-7d4U4_S_9_EYHO38XqAPKc2_MXtdA@mail.gmail.com>
 <CALCETrXA-JzBWKdzBZJA8P+pPNKEkxNRPqLganWMpvm6KEUmCw@mail.gmail.com>
 <CAJvTdK=RFei+b0W89ZTtqoiiR_M0wAJz_EuBTijgEHpacfZS7Q@mail.gmail.com>
In-Reply-To: <CAJvTdK=RFei+b0W89ZTtqoiiR_M0wAJz_EuBTijgEHpacfZS7Q@mail.gmail.com>
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

RnJvbTogTGVuIEJyb3duDQo+IFNlbnQ6IDExIEFwcmlsIDIwMjEgMjA6MDcNCi4uLg0KPiBHcmFu
dGVkLCBpZiB5b3UgaGF2ZSBhbiBhcHBsaWNhdGlvbiB0aGF0IGlzIHN0YXRpY2FsbHkgbGlua2Vk
IGFuZCBydW4NCj4gb24gbmV3IGhhcmR3YXJlDQo+IGFuZCBuZXcgT1MsIGl0IGNhbiBzdGlsbCBm
YWlsLg0KDQpUaGF0IGFsc28gaW5jbHVkZXMgYW55dGhpbmcgY29tcGlsZWQgYW5kIHJlbGVhc2Vk
IGFzIGEgcHJvZ3JhbQ0KYmluYXJ5IHRoYXQgbXVzdCBydW4gb24gb2xkZXIgTGludXggaW5zdGFs
bGF0aW9ucy4NCg0KU3VjaCBwcm9ncmFtcyBoYXZlIHRvIGJlIGNvbXBpbGVkIHdpdGggb2xkIGNv
cGllcyBvZiB0aGUgc3lzdGVtDQpoZWFkZXJzIChhbmQgcHJvYmFibHkgd2l0aCBhbiBvZiBnY2Mp
Lg0KDQpXaGlsZSBzdWNoIHByb2dyYW1zIHRoZW1zZWx2ZXMgd29uJ3QgdXNlIEFWWCB3aXRob3V0
IGNoZWNraW5nDQpmb3IgT1Mgc3VwcG9ydCwgdGhlIGdsaWJjIGNvZGUgb24gdGhlIGluc3RhbGxl
ZCBzeXN0ZW0gbWlnaHQuDQoNClN1Y2ggcHJvZ3JhbXMgY2FuIGJlIG1vZGlmaWVkIHRvIHJ1bi10
aW1lIGRldGVjdCB0aGUgcmVxdWlyZWQNCnNpZ25hbCBzdGFjayBzaXplIC0gYnV0IGNhbm5vdCBy
ZWx5IG9uIGdsaWJjIHRvIGNvbnZlcnQNClNJR1NUS1NaIGludG8gYSBmdW5jdGlvbiBjYWxsLg0K
DQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQs
IE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86
IDEzOTczODYgKFdhbGVzKQ0K


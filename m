Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8850A27714A
	for <lists+linux-api@lfdr.de>; Thu, 24 Sep 2020 14:44:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727763AbgIXMoF (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 24 Sep 2020 08:44:05 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:46260 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727751AbgIXMoF (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 24 Sep 2020 08:44:05 -0400
X-Greylist: delayed 377 seconds by postgrey-1.27 at vger.kernel.org; Thu, 24 Sep 2020 08:44:04 EDT
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-42-w-QZRmrqOgiSZ0QwhDWzxw-1; Thu, 24 Sep 2020 13:37:43 +0100
X-MC-Unique: w-QZRmrqOgiSZ0QwhDWzxw-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Thu, 24 Sep 2020 13:37:42 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Thu, 24 Sep 2020 13:37:42 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Jann Horn' <jannh@google.com>, Kees Cook <keescook@chromium.org>
CC:     YiFei Zhu <yifeifz2@illinois.edu>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Tycho Andersen <tycho@tycho.pizza>,
        "Andy Lutomirski" <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        "Andrea Arcangeli" <aarcange@redhat.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Dimitrios Skarlatos <dskarlat@cs.cmu.edu>,
        Valentin Rothberg <vrothber@redhat.com>,
        "Hubertus Franke" <frankeh@us.ibm.com>,
        Jack Chen <jianyan2@illinois.edu>,
        "Josep Torrellas" <torrella@illinois.edu>,
        Tianyin Xu <tyxu@illinois.edu>, bpf <bpf@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Linux API <linux-api@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 3/6] seccomp: Implement constant action bitmaps
Thread-Topic: [PATCH 3/6] seccomp: Implement constant action bitmaps
Thread-Index: AQHWkm52E4NdUTUYRkuK8ZQr+ESnnKl3uRCg
Date:   Thu, 24 Sep 2020 12:37:42 +0000
Message-ID: <ec31caaea19247f0b9bd9c73ccaa7dbd@AcuMS.aculab.com>
References: <20200923232923.3142503-1-keescook@chromium.org>
 <20200923232923.3142503-4-keescook@chromium.org>
 <CAG48ez0d80fOSTyn5QbH33WPz5UkzJJOo+V8of7YMR8pVQxumw@mail.gmail.com>
 <202009240018.A4D8274F@keescook>
 <CAG48ez1MWhrtkbWTNpc1v-WqWYiLM_JrCKvuE6DdH6vBY3MJzQ@mail.gmail.com>
In-Reply-To: <CAG48ez1MWhrtkbWTNpc1v-WqWYiLM_JrCKvuE6DdH6vBY3MJzQ@mail.gmail.com>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Content-Language: en-US
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

RnJvbTogSmFubiBIb3JuDQo+IFNlbnQ6IDI0IFNlcHRlbWJlciAyMDIwIDEzOjI5DQouLi4NCj4g
SSB0aGluayBvdXIgZ29hbCBoZXJlIHNob3VsZCBiZSB0aGF0IGlmIGEgc3lzY2FsbCBpcyBhbHdh
eXMgYWxsb3dlZCwNCj4gc2VjY29tcCBzaG91bGQgZXhlY3V0ZSB0aGUgc21hbGxlc3QgYW1vdW50
IG9mIGluc3RydWN0aW9ucyB3ZSBjYW4gZ2V0DQo+IGF3YXkgd2l0aCwgYW5kIHRvdWNoIHRoZSBz
bWFsbGVzdCBhbW91bnQgb2YgbWVtb3J5IHBvc3NpYmxlIChhbmQNCj4gcHJlZmVyYWJseSB0aGF0
IG1lbW9yeSBzaG91bGQgYmUgc2hhcmVkIGJldHdlZW4gdGhyZWFkcykuIFRoZSBiaXRtYXANCj4g
ZmFzdHBhdGggc2hvdWxkIHByb2JhYmx5IGFsc28gYXZvaWQgcG9wdWxhdGVfc2VjY29tcF9kYXRh
KCkuDQoNCklmIG1vc3Qgc3lzY2FsbHMgYXJlIGV4cGVjdGVkIHRvIGJlIGFsbG93ZWQgdGhlbiBh
biBpbml0aWFsOg0KCWlmIChnbG9iYWxfbWFzayAmICgxdSA8PCAoc3lzY2FsbF9udW1iZXIgJiA2
MykpDQp0ZXN0IGNhbiBiZSB1c2VkIHRvIHNraXAgYW55IGZ1cnRoZXIgbG9va3Vwcy4NCg0KQWx0
aG91Z2ggSVNUUiBzb21lb25lIHN1Z2dlc3RpbmcgdGhhdCB0aGUgZ2xvYmFsX21hc2sgc2hvdWxk
DQpiZSBwZXItY3B1IGJlY2F1c2UgZXZlbiBzaGFyZWQgcmVhZC1vbmx5IGNhY2hlIGxpbmVzIHdl
cmUNCmV4cGVuc2l2ZSBvbiBzb21lIGFyY2hpdGVjdHVyZS4NCg0KCURhdmlkDQoNCi0NClJlZ2lz
dGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24g
S2V5bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==


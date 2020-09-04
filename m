Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BF8F25D995
	for <lists+linux-api@lfdr.de>; Fri,  4 Sep 2020 15:26:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730255AbgIDN0R (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 4 Sep 2020 09:26:17 -0400
Received: from mail-eopbgr70118.outbound.protection.outlook.com ([40.107.7.118]:47938
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730398AbgIDNZn (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Fri, 4 Sep 2020 09:25:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YtfKgqc3XNgAMutLBOiwGGhG6T4Ah3jTGs5k5f2Ba0jYy0nvSGf6ff1Il8P45qmzxQqcxTNZAIjOuo5yBvzu8b2k/35MfO/a/UOajwZH7Qhh/omolpQWLFThRhCY7VHAFuz/Rq8R1yJ7vLKe7xF2IiuigyLPbqPQ9jCAU6LFeFE8dwtULjykcfVpP7U4MXlBuLhRyTo7BNSXW6dHvRmNgPxVWJMVpZK3AkQjUC6r4fqmdbeUJ3uQRYUjDhrGHZLm+/IbB2wMG6uX7arQ+idTRbL1FE7vTPAdolMn0Px4nzSpaQaikevPeRMHCOmuV4BGtcMJ7nAmZjNZY/sYiVeNzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KLQ+IE2fbi/yk/t/pkSSq7RObL1ukAzGD7Lss85EXDQ=;
 b=ACPdIM4GBvFwL3/NdDVrtpVNnhzh47IpUHNyJXcKpmjbsxzMt08bKMhqsftdMM2DOPoYZTelINYlrQLM3j8FYb3yl1zr1TmYigrPZhWt26Lst3SnCzv89gur8IhaTshvjnuLT6z/ImrAv8SY6MkJcnCxcmqveC0f7Xbu3yWB9HLEg7d3i9Rfr2Pv9uGCByN27SPCrV4jde6psy1xWe84Gu8nyxGuiSLppnC0B18SSvkdc2piCYpoGSpSwVUXIDtHzrK0hxIK6gSILBAjfh0RfWCJl/s5lB/rgVDx2CcJxUuzRe0wgIZURImqO7d4ONvdn6z1ydHwig++eQH4l/LDOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bitdefender.com; dmarc=pass action=none
 header.from=bitdefender.com; dkim=pass header.d=bitdefender.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bitdefender.onmicrosoft.com; s=selector2-bitdefender-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KLQ+IE2fbi/yk/t/pkSSq7RObL1ukAzGD7Lss85EXDQ=;
 b=bU0YYtBji8jANHws2IjeldK5IPlwvn+HHZnQf+kyha6ReiVC3gPaRhVj0ofVMNNtYQyX+WoS6Fp1WuFZKDmG7cEe3ifaDqBjbTI/jHy7i2x0bJ+E7aMpUwEOf8VscWq+Ko0iS7+7ikPt7GG+Hl+dvJGO7cgefZDpCtcTovStlWw=
Received: from AM7PR02MB6082.eurprd02.prod.outlook.com (2603:10a6:20b:1af::16)
 by AM5PR0201MB2388.eurprd02.prod.outlook.com (2603:10a6:203:32::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15; Fri, 4 Sep
 2020 13:24:43 +0000
Received: from AM7PR02MB6082.eurprd02.prod.outlook.com
 ([fe80::9dcc:d3cc:dbe:5b33]) by AM7PR02MB6082.eurprd02.prod.outlook.com
 ([fe80::9dcc:d3cc:dbe:5b33%8]) with mapi id 15.20.3348.016; Fri, 4 Sep 2020
 13:24:43 +0000
From:   Mircea CIRJALIU - MELIU <mcirjaliu@bitdefender.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>,
        =?utf-8?B?QWRhbGJlcnQgTGF6xINy?= <alazar@bitdefender.com>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Graf <graf@amazon.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?utf-8?B?TWloYWkgRG9uyJt1?= <mdontu@bitdefender.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Sargun Dhillon <sargun@sargun.me>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: RE: [RESEND RFC PATCH 0/5] Remote mapping
Thread-Topic: [RESEND RFC PATCH 0/5] Remote mapping
Thread-Index: AQHWgq7sJAwNYCdpy0yn8gtG4wotq6lYY8IAgAAIjBA=
Date:   Fri, 4 Sep 2020 13:24:43 +0000
Message-ID: <AM7PR02MB60824E11A81A63A7CE94848CBB2D0@AM7PR02MB6082.eurprd02.prod.outlook.com>
References: <20200904113116.20648-1-alazar@bitdefender.com>
 <20200904121148.GR24045@ziepe.ca>
In-Reply-To: <20200904121148.GR24045@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: ziepe.ca; dkim=none (message not signed)
 header.d=none;ziepe.ca; dmarc=none action=none header.from=bitdefender.com;
x-originating-ip: [31.5.46.39]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 03f2b603-ec7c-4b43-309c-08d850d5e2a2
x-ms-traffictypediagnostic: AM5PR0201MB2388:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM5PR0201MB23882A25349DB812F16A902BBB2D0@AM5PR0201MB2388.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EQRiFbdO+Yp9ej4nvqh3yH/wcRBqXyf6/L3juB134Cx5RRqtYzyJWD0HSEOG8Cxxt8sf+x6OFwpj3PkEovbLBoGa0L9/txBRpPzh0suWF5ju493v4IEmNRibcfvwMeaoynNnfsddsogw/rBjrzuh6F6N2bebfWhRLzcIH3OXYx9AY05Lq2bsLkN4MlhHAEqbC5T0VSC1YTnFBlaOIM/pY9nP12rZEE7+PJTOi6k6G4cY1XLJnrZt2JAHj3iw/4KHAVKV4HdMODt5dnlO9brycp1pLbtlQMnzeOzxuNf7LqzmhsQLY/PPN0wL8dKEpPYFWDItJUhvkamS0nKzhIVFWYBw82z58EjGxvJSLT/Un6BRaHjfOoMDF/sWaVHM2VChwLuR8Q+ENJFwoXlRSojZOg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR02MB6082.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(376002)(39860400002)(396003)(346002)(366004)(9686003)(83380400001)(33656002)(66946007)(7696005)(8936002)(64756008)(66446008)(66556008)(5660300002)(66476007)(110136005)(26005)(478600001)(2906002)(6506007)(966005)(8676002)(55016002)(71200400001)(54906003)(316002)(7416002)(6636002)(86362001)(4326008)(76116006)(186003)(52536014)(66574015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: RgGeJRfpIHTXFCdQ8vFZNaiV5nrGHC4/M3f60DDqrEV0JCbrIUrtslLdg04GsxoxsLEM7yjMJIoJYJuOa6/pLNMW//BjuboWGtY6wiQXzNSA4Rr3QJU8ZPDUaUtaNJk3CdjPYQAJlz50sQVfrXD0Ild5pSyEE97ZWVMikHDETrpQfWPdpIFR7XmoC7X7xsvwO7utngWbup5eAqmWI7GCCoQnoncEhN1b2xk+8jOencYdLhQiggv0L/Z/rp6EAqMOI65hjOSiyy3TEWabzsBlOKG7wMSdiIxSpmDxSE71mQkf9+0ltMt9CkKUtcTJsYKusVu5BQKebYgwb/lIGnZc3OxJGY7EwmZ6alxtsjlxh27F6XE0JKU7+UlifjRBSyR4KOmJv2a+JzQQ3AOXg7kBYirU+I1L/AHyGeuV8PYTyqTZoLCZJzuVNU0989IhXj+ORj5oKn5VEL1kNnaCa1rAGMqcQawhkI7OivqEl5TBgihd7OlmrRxi9yWqryreildeUOc5eN3lRcMfwt1oq8If2tGJvjdlJC6gqy+uGPGDAMf5rIDlP96opQ8OdVUkjnpVG0uY82d/vRz4inayMyICQwGJLE3s9Qp7eaGQrNkJIUQDSbiW0P4o2UG8IBPJhLAkWgFbMdDLrcFUw1rqnV5ayA==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bitdefender.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM7PR02MB6082.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03f2b603-ec7c-4b43-309c-08d850d5e2a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2020 13:24:43.2814
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 487baf29-f1da-469a-9221-243f830c36f3
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AlBLpzYLnlNeHGenlzjuUWc7VPGsr8JJPzbUnvXa2K87JxVwXhjlRI8Xtxg2D/t0it9dkzGXdCOusFifv8780M4HbwDRGTE9wivth1K95WM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0201MB2388
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

PiBPbiBGcmksIFNlcCAwNCwgMjAyMCBhdCAwMjozMToxMVBNICswMzAwLCBBZGFsYmVydCBMYXrE
g3Igd3JvdGU6DQo+ID4gVk1BcyBvYnRhaW5lZCBieSBtbWFwKClpbmcgbWVtb3J5IGFjY2VzcyBm
ZHMgbWlycm9yIHRoZSBjb250ZW50cyBvZg0KPiA+IHRoZSByZW1vdGUgcHJvY2VzcyBhZGRyZXNz
IHNwYWNlIHdpdGhpbiB0aGUgc3BlY2lmaWVkIHJhbmdlLiBQYWdlcyBhcmUNCj4gPiBpbnN0YWxs
ZWQgaW4gdGhlIGN1cnJlbnQgcHJvY2VzcyBwYWdlIHRhYmxlcyBhdCBmYXVsdCB0aW1lIGFuZCBy
ZW1vdmVkDQo+ID4gYnkgdGhlIG1tdV9pbnRlcnZhbF9ub3RpZmllciBpbnZhbGlkYXRlIGNhbGxi
Y2suIE5vIGZ1cnRoZXIgbWVtb3J5DQo+IG1hbmFnZW1lbnQgaXMgaW52b2x2ZWQuDQo+ID4gT24g
YXR0ZW1wdHMgdG8gYWNjZXNzIGEgaG9sZSwgb3IgaWYgYSBtYXBwaW5nIHdhcyByZW1vdmVkIGJ5
DQo+ID4gUElERkRfTUVNX1VOTUFQLCBvciBpZiB0aGUgcmVtb3RlIHByb2Nlc3MgYWRkcmVzcyBz
cGFjZSB3YXMgcmVhcGVkDQo+IGJ5DQo+ID4gT09NLCB0aGUgcmVtb3RlIG1hcHBpbmcgZmF1bHQg
aGFuZGxlciByZXR1cm5zIFZNX0ZBVUxUX1NJR0JVUy4NCj4gDQo+IEkgc3RpbGwgdGhpbmsgYW55
dGhpbmcgYWxvbmcgdGhlc2UgbGluZXMgbmVlZHMgdG8gbWVldCB0aGUgWFBNRU0gdXNlIGNhc2Vz
IGFzDQo+IHdlbGwsIHdlIGhhdmUgdG8gaGF2ZSBtb3JlIGdlbmVyYWwgc29sdXRpb25zIGZvciBz
dWNoIE1NDQo+IHN0dWZmOg0KPiANCj4gaHR0cHM6Ly9naXRsYWIuY29tL2hqZWxtbi94cG1lbQ0K
PiANCj4gSG93ZXZlciwgSSB0aGluayB0aGlzIGZ1bmRhbWVudGFsbHkgZmFsbHMgaW50byBzb21l
IG9mIHRoZSBzYW1lIGJhZCBkaXJlY3Rpb24NCj4gYXMgeHBtZW0uDQo+IA0KPiBJIHdvdWxkIG11
Y2ggcmF0aGVyIHNlZSB0aGlzIGRlc2lnbiBjb3B5ICYgY2xvbmUgdGhlIFZNQSdzIHRoYW4gdHJ5
IHRvDQo+IG1pcnJvciB0aGUgUFRFcyBpbnNpZGUgdGhlIFZNQXMgZnJvbSB0aGUgcmVtb3RlIGlu
dG8gYSBzaW5nbGUgZ2lhbnQgVk1BIGFuZA0KPiBzb21laG93IHNwbGl0L21pcnJvciB0aGUgVk1B
IG9wcy4NCg0KVGhpcyBkZXNpZ24gd2FzIG1hZGUgc3BlY2lmaWNhbGx5IGZvciB2aXJ0dWFsIG1h
Y2hpbmUgaW50cm9zcGVjdGlvbiwgd2hlcmUgd2UgDQpjYXJlIG1vcmUgYWJvdXQgdGhlIGNvbnRl
bnRzIG9mIHRoZSBhZGRyZXNzIHNwYWNlLCByYXRoZXIgdGhhbiB0aGUgcmVtb3RlIFZNQXMNCmFu
ZCB0aGVpciB2bW9wcy4gKFJpZ2h0IG5vdyBvbmx5IGFub24gcGFnZXMgY2FuIGJlIG1hcHBlZCwg
YnV0IEkgZ3Vlc3MNCndlIGNhbiBleHRlbmQgdG8gcGFnZWNhY2hlIHBhZ2VzIGFzIHdlbGwuKSBJ
IGp1c3QgdXNlZCB3aGF0IHNlZW1lZCB0byBiZSB0aGUNCmNvbW1vbiBkZW5vbWluYXRvciB0byBh
bGwgcGFnZS1yZWxhdGVkIG9wZXJhdGlvbnM6IHJhbmdlIGludmFsaWRhdGlvbi4NClRoaXMgbG9v
a3MgbGlrZSBhIGdlbmVyYWwgc29sdXRpb24uDQoNCklNTyBjbG9uaW5nIGEgVk1BIGluIGFuIGFk
ZHJlc3Mgc3BhY2UgdGhhdCBoYXMgYSBjb21wbGV0ZWx5IGRpZmZlcmVudCBsYXlvdXQNCndpbGwg
cHJlc2VudCBpdHMgb3duIHNldCBvZiBjYXZlYXRzOiBXaGF0IGhhcHBlbnMgaWYgdGhlIFZNQSBy
ZXNpemVzL3NwbGl0cz8gDQpDYW4geW91IHJlcGxheSBhbGwgdGhlIHJlbW90ZSBWTUEgdm1vcHMg
b24gdGhlIGNsb25lIFZNQT8NCg0KPiBUaGlzIGlzIGp1c3QgdG9vIHdlaXJkIGFuZCBmcmFnaWxl
IHRvIGJlIG1haW50YWlibGUgb3ZlciBhIGxvbmcgdGVybS4NCj4gDQo+IEZvciBpbnN0YW5jZSwg
b25lIG9mIHRoZSBtYWpvciBidWdzIGluIHRoaW5ncyBsaWtlIHhwbWVtIHdhcyB0aGF0IHRoZXkg
YXJlDQo+IGluY29tcGF0aWJsZSB3aXRoIGdldF91c2VyX3BhZ2VzKCksIGxhcmdlbHkgYmVjYXVz
ZSBvZiB0aGlzIGlzc3VlLg0KDQpXZSBzdXBwb3J0IGdldF91c2VyX3BhZ2VzKCksIHRoYXQncyBo
b3cgd2UgaW50ZWdyYXRlIHdpdGggS1ZNLg0KVGhlIGRpZmZlcmVuY2UgaXMgdGhlIHBhZ2UgcmV0
dXJuZWQgd2lsbCBub3QgYmVsb25nIHRvIHRoZSBjdXJyZW50IHByb2Nlc3MuDQoNCj4gSSBmZWVs
IGxpa2UgSSBzYWlkIHRoaXMgYWxyZWFkeS4uDQo+IA0KPiBKYXNvbg0K

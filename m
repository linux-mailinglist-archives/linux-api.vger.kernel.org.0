Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3378E260367
	for <lists+linux-api@lfdr.de>; Mon,  7 Sep 2020 19:49:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729413AbgIGRsu (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 7 Sep 2020 13:48:50 -0400
Received: from mail-eopbgr60126.outbound.protection.outlook.com ([40.107.6.126]:34115
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729171AbgIGMlW (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Mon, 7 Sep 2020 08:41:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q33PJJaQvdsVDTohrG2G9BE53FmQhDf/g5PcU925LK+0Fb12mH9+nv1dr/Ev9Dzgp936qe5AUgcheRcJCefQaGVckq1bvVR+bi3kWJam1V+1zqWKYo5+DTQDyTkLmaf4p8uBX4SRRZIO/7zgzYmt+V25qHTlRtwWKYdfcw655mDwe1H9y2gVJ91ERKE9tptOvYK+D+a4yGHM+mMwvlR+YOvgzFh5n2jGjRYxbihVZzBEZufRyKHPAFU1O1LiHlLW1+vh0J+rzdFyzitThlIExjzAi8Rj49UiOaDLf0jpGqvCxjEUnW6wdcnl99HZe70AjMmzvwn8BOEmBaRaFKO/6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8f+11I25Kq4475KbbqkSK1BWQE/jv5FMbjSnAkBFm/c=;
 b=R4G5npaG7Vc4TajDJFhU/buM5U70Ow1QFUWKPaoKH4qrVIvCSKiKJ4yo/WsqADBtW1WfkR4hg05G+UbwXt1thqseCeYg4934Rl2B5PjULeoi28ZiR2Ib1fMosqVmKgffo7QnRC3GGYK2cR+UEFjlZZB7mMofS1fHIT0pnK/cMpglcX/sbyves9L3fi89x1xbdNucvARrbSe7rMXZo7BMPgdrTrWBv7x1WqW424nH9+4Y2ge6wLvBY23J6fsEr6aZTlYqp8OB6yUtmHmmvfGUEfgkydGsP6SYUVRiwNfap8p65hhW9LJKD7jhh4oP2u7rIVx7XERnfkoaVK7SUyXkWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bitdefender.com; dmarc=pass action=none
 header.from=bitdefender.com; dkim=pass header.d=bitdefender.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bitdefender.onmicrosoft.com; s=selector2-bitdefender-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8f+11I25Kq4475KbbqkSK1BWQE/jv5FMbjSnAkBFm/c=;
 b=eRrfKlQylq7nd3vlodXUgQ0OVBjccvRE4Vw9qJQYeo9uJ+2jgSjNx2VwtAIy68uqHfXMFPEpgoWUU4Ds6j5tCENBQDTLED0jBKITBjXJ3uxOT53uLJ5B18rKkpDg+IpJtybdvN+e+E1h+w11aFtkeG9sWRN7XKxzkl6eZFzVFuQ=
Received: from AM7PR02MB6082.eurprd02.prod.outlook.com (2603:10a6:20b:1af::16)
 by AM7PR02MB6049.eurprd02.prod.outlook.com (2603:10a6:20b:1ac::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15; Mon, 7 Sep
 2020 12:41:11 +0000
Received: from AM7PR02MB6082.eurprd02.prod.outlook.com
 ([fe80::9dcc:d3cc:dbe:5b33]) by AM7PR02MB6082.eurprd02.prod.outlook.com
 ([fe80::9dcc:d3cc:dbe:5b33%8]) with mapi id 15.20.3348.019; Mon, 7 Sep 2020
 12:41:11 +0000
From:   Mircea CIRJALIU - MELIU <mcirjaliu@bitdefender.com>
To:     Andy Lutomirski <luto@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>
CC:     =?utf-8?B?QWRhbGJlcnQgTGF6xINy?= <alazar@bitdefender.com>,
        Linux-MM <linux-mm@kvack.org>,
        Linux API <linux-api@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Graf <graf@amazon.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Jerome Glisse <jglisse@redhat.com>,
        =?utf-8?B?TWloYWkgRG9uyJt1?= <mdontu@bitdefender.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Sargun Dhillon <sargun@sargun.me>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: RE: [RESEND RFC PATCH 0/5] Remote mapping
Thread-Topic: [RESEND RFC PATCH 0/5] Remote mapping
Thread-Index: AQHWgq7sJAwNYCdpy0yn8gtG4wotq6lY4MAAgAAIYgCAAAb9gIAAF6+AgAAV2QCAA+RPkA==
Date:   Mon, 7 Sep 2020 12:41:11 +0000
Message-ID: <AM7PR02MB608288CF5CCBA9383BBD7C8ABB280@AM7PR02MB6082.eurprd02.prod.outlook.com>
References: <d22e1e08-e2c1-510e-5ae7-accbf69731bf@redhat.com>
 <70D23368-A24D-4A15-8FC7-FA728D102475@amacapital.net>
 <836cff86-e670-8c69-6cbd-b22c5b5538df@redhat.com>
 <CALCETrUcxFJzN_Vz7qe+79eg8033+uUKOAAMEVj-cB1Gp6pouw@mail.gmail.com>
In-Reply-To: <CALCETrUcxFJzN_Vz7qe+79eg8033+uUKOAAMEVj-cB1Gp6pouw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=bitdefender.com;
x-originating-ip: [31.5.46.39]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ec86077b-8d70-4266-e45b-08d8532b4d4d
x-ms-traffictypediagnostic: AM7PR02MB6049:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM7PR02MB60495F4E1A37CFD45695704EBB280@AM7PR02MB6049.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: B0YF+dtJ5LGvxNggSXeBjvYpshlt6SfphcYxbXjq8Wicr/CXb8MMqrMh+a8IxGPmTXZ+eTgD4GuwGH/qVgE2Z5MvnNWWpfD/tPqon0iLdwlls43vn4S52E4IFQfQR4hkqBurtbhyXEGpzwPZMprT7XNiaJ+PTR6ZM7ESZgZPFFhjKMIzpkZuNHUav9v+tFkzYL5cjg8cWiaCU/JyF+3TXNNtGGW4/U3mCD745UKWImtnSJntzJZiZz+s7bKBs2J4l4YcM6dginkYdUDYkM9sxDHFk3uFXiaprGev/116thD9PVS1AopTiBeo8JsXwWwfOdzK1fAMJ6ABv1qzZo3F9w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR02MB6082.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(39850400004)(346002)(376002)(136003)(366004)(66476007)(8676002)(186003)(71200400001)(66556008)(64756008)(66446008)(2906002)(76116006)(478600001)(7696005)(54906003)(110136005)(8936002)(9686003)(86362001)(4326008)(6506007)(316002)(26005)(33656002)(66946007)(83380400001)(52536014)(5660300002)(7416002)(55016002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: s8Egv3CBTBMNfunYQCmpydIHTWqH+/6argD4vDS5Haik7GLvRSZr1YAHkxlXWNbdYAuNxYWcXLfK1X5zCpG4qu1NZV0kO9bg8L9OMAJ5AS9Io0NR2L38XsR/cYHBH1r53qTkqKOOYtGCUILfxL+b50mbUyQgBR4G4BgPI+EKrT7yiTMHG5Fttf1OqMlA8JVpGhq+ksKPH2CAMcXINRFBgcnTdj/Dw5JN2oyHmvsadOuNugleYPRHXF2i6LT92jNFuLTfuf/uUR9nPWrLlqlQOAB4kVp6IWQSmizzJVORwPurP7hEWRbZnM0m+OfF0aeqlcWGFqksHN9erpYpWW5ey+w3M1SkV5SwCIp4wRBTb7HnidDYH0HU+eGbmTKuCmoMqEwCb5qqRFE7DERStGdzDpkV+ZRjWtY1Vo3u7mPveO2fMjVClL831Ie/wpSZn7gaGYhSKZ/0CCAKD0pSh0cPdwSoviv4tvMMzKihyczlpKq0xrGEhfgptKqUhMLZnA51oEaa683C8hID10dJrL61AI2a1LXFqTqr9Sfhv3icrMPtsEBnRZMueHEYYrDcPPmEqFuRj2cPN787jX3uKIT5rlOMIKkm7dY7J1iXWrsHOCFxI9f37kX0rWVSa0AUGOYDbwCDddig6sXCKBIZHLKRrw==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bitdefender.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM7PR02MB6082.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec86077b-8d70-4266-e45b-08d8532b4d4d
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2020 12:41:11.7051
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 487baf29-f1da-469a-9221-243f830c36f3
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BL0HcDT5Pn8GVAHgqW/5pP+GetJRl53QCxAuxg4U64EaWaHyvq5rlFSTNd6BRBUEA6hNoma6jpoRkHsn1VFnyzRQ/Y5UkDVujorCdbq7ve0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR02MB6049
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

PiBGcm9tOiBBbmR5IEx1dG9taXJza2kgPGx1dG9Aa2VybmVsLm9yZz4NCj4gPiA+IEFzIGl0IHN0
YW5kcywgdGhlIHdheSB0aGF0IEtWTSBtZW1vcnkgbWFwcGluZ3MgYXJlIGNyZWF0ZWQgc2VlbXMg
dG8NCj4gPiA+IGJlIGNvbnZlbmllbnQsIGJ1dCBpdCBhbHNvIHNlZW1zIHRvIGJlIHJlc3VsdGlu
ZyBpbiBpbmNyZWFzaW5nDQo+ID4gPiBiaXphcnJlIHVzZXJzcGFjZSBtYXBwaW5ncy4gIEF0IHdo
YXQgcG9pbnQgaXMgdGhlIHJpZ2h0IHNvbHV0aW9uIHRvDQo+ID4gPiBkZWNvdXBsZSBLVk3igJlz
IG1hcHBpbmdzIGZyb20gUUVNVeKAmXM/DQoNCkNvbnZlbmllbmNlIGlzIG9uZSBvZiB0aGUgZHJp
dmVycyBvZiBjb2RlIHJldXNlLg0KDQo+ID4gU28gd2hhdCB5b3UgYXJlIHN1Z2dlc3RpbmcgaXMg
dGhhdCBLVk0gbWFuYWdlcyBpdHMgb3duIGFkZHJlc3Mgc3BhY2UNCj4gPiBpbnN0ZWFkIG9mIGhv
c3QgdmlydHVhbCBhZGRyZXNzZXMgKGFuZCB3aXRoIG5vIHJlbGF0aW9uc2hpcCB0byBob3N0DQo+
ID4gdmlydHVhbCBhZGRyZXNzZXMsIGl0IHdvdWxkIGJlIGp1c3QgYSAiY29va2llIik/ICBJdCB3
b3VsZCB0aGVuIG5lZWQgYQ0KPiA+IGNvdXBsZSBpb2N0bHMgdG8gbW1hcC9tdW5tYXAgKGNyZWF0
aW5nIGFuZCBkZWxldGluZyBWTUFzKSBpbnRvIHRoZQ0KPiA+IGFkZHJlc3Mgc3BhY2UsIGFuZCB0
aG9zZSBjb29raWVzIHdvdWxkIGJlIHBhc3NlZCB0bw0KPiA+IEtWTV9TRVRfVVNFUl9NRU1PUllf
UkVHSU9OLiAgUUVNVSB3b3VsZCBzdGlsbCBuZWVkIGFjY2VzcyB0bw0KPiB0aGVzZQ0KPiA+IFZN
QXMsIHdvdWxkIGl0IG1tYXAgYSBmaWxlIGRlc2NyaXB0b3IgcHJvdmlkZWQgYnkgS1ZNPyAgQWxs
IGluIGFsbCB0aGUNCj4gPiBpbXBsZW1lbnRhdGlvbiBzZWVtcyBxdWl0ZSBjb21wbGV4LCBhbmQg
SSBkb24ndCB1bmRlcnN0YW5kIHdoeSBpdA0KPiA+IHdvdWxkIGF2b2lkIGluY29oZXJlbnQgU0VW
IG1hcHBpbmdzOyB3aGF0IGFtIEkgbWlzc2luZz8NCj4gDQo+IEl0IG1pZ2h0IG5vdCBhdm9pZCBp
bmNvaGVyZW50IFNFViBtYXBwaW5ncyBpbiBwYXJ0aWN1bGFyLCBidXQgaXQgd291bGQNCj4gY2Vy
dGFpbmx5IGVuYWJsZSBvdGhlciwgc29tZXdoYXQgcmVsYXRlZCB1c2VjYXNlcy4gIEZvciBleGFt
cGxlLCBRRU1VDQo+IGNvdWxkIGhhdmUgS1ZNIG1hcCBhIG1lbWZkIHdpdGhvdXQgaXRzZWxmIG1h
cHBpbmcgdGhhdCBtZW1mZCwgd2hpY2gNCj4gd291bGQgcmVkdWNlIHRoZSBleHRlbnQgdG8gd2hp
Y2ggdGhlIG1lbW9yeSB3b3VsZCBiZSBleHBvc2VkIHRvIGFuDQo+IGF0dGFja2VyIHdobyBjYW4g
cmVhZCBRRU1VIG1lbW9yeS4NCg0KSXNuJ3QgdGhpcyBzZWN1cml0eSB0aHJvdWdoIG9ic2N1cml0
eT8NCg0KPiBGb3IgdGhpcyBwaWRmZC1tZW0gc2NoZW1lIGluIHBhcnRpY3VsYXIsIGl0IG1pZ2h0
IGF2b2lkIHRoZSBuYXN0eSBjb3JuZXIgY2FzZQ0KPiBJIG1lbnRpb25lZC4gIFdpdGggcGlkZmQt
bWVtIGFzIGluIHRoaXMgcGF0Y2hzZXQsIEknbSBjb25jZXJuZWQgYWJvdXQgd2hhdA0KPiBoYXBw
ZW5zIHdoZW4gcHJvY2VzcyBBIG1hcHMgc29tZSBwcm9jZXNzIEIgbWVtb3J5LCBwcm9jZXNzIEIg
bWFwcw0KPiBzb21lIG9mIHByb2Nlc3MgQSdzIG1lbW9yeSwgYW5kIHRoZXJlJ3MgYSByZWN1cnNp
dmUgbWFwcGluZyB0aGF0IHJlc3VsdHMuDQo+IE9yIHdoZW4gYSBwcm9jZXNzIG1hcHMgaXRzIG93
biBtZW1vcnksIGZvciB0aGF0IG1hdHRlci4gIElmIEtWTSBjb3VsZCBtYXANCj4gZmQncyBkaXJl
Y3RseSwgdGhlbiB0aGVyZSBjb3VsZCBiZSBhIHBhcmFsbGVsIG1lY2hhbmlzbSBmb3IgS1ZNIHRv
IGltcG9ydA0KPiBwb3J0aW9ucyBvZiBtb3JlIHRoYW4gb25lIHByb2Nlc3MncyBhZGRyZXNzIHNw
YWNlLCBhbmQgdGhpcyBwYXJ0aWN1bGFyDQo+IHByb2JsZW0gd291bGQgYmUgYXZvaWRlZC4gIFNv
IGEgcHJvY2VzcyB3b3VsZCBjcmVhdGUgcGlkZmQtbWVtLWxpa2UNCj4gb2JqZWN0IGFuZCBwYXNz
IHRoYXQgdG8gS1ZNICh2aWEgYW4gaW50ZXJtZWRpYXJ5IHByb2Nlc3Mgb3IgZGlyZWN0bHkpIGFu
ZA0KPiBLVk0gY291bGQgbWFwIHRoYXQsIGJ1dCBubyBub3JtYWwgcHJvY2VzcyB3b3VsZCBiZSBh
bGxvd2VkIHRvIG1hcCBpdC4gIFRoaXMNCj4gYXZvaWRzIHRoZSByZWN1cnNpb24gcHJvYmxlbXMu
DQo+IA0KPiBPciBtZW1mZCBjb3VsZCBnZXQgZmFuY2llciB3aXRoIG9wZXJhdGlvbnMgdG8gc3Bs
aXQgbWVtZmRzLCByZW1vdmUgcGFnZXMNCj4gZnJvbSBtZW1mZHMsIGV0Yy4gIE1heWJlIHRoYXQn
cyBvdmVya2lsbC4NCj4gDQo+IChPciBhIGZhbmN5IHJlY3Vyc2lvbiBkZXRlY3RvciBjb3VsZCBi
ZSBidWlsdCwgYnV0IHRoaXMgaGFzIGJlZW4gYSBwYWluIHBvaW50IGluDQo+IEFGX1VOSVgsIGVw
b2xsLCBldGMgaW4gdGhlIHBhc3QuICBJdCBtYXkgYmUgc29sdmFibGUsIGJ1dCBpdCB3b24ndCBi
ZSBwcmV0dHkuKQ0KPiANCj4gSSBhZG1pdCB0aGF0IGFsbG93aW5nIEtWTSB0byBtYXAgZmQncyBk
aXJlY3RseSB3aXRob3V0IHNvbWUgc3BlY2lmaWMNCj4gdm1fb3BlcmF0aW9ucyBzdXBwb3J0IGZv
ciB0aGlzIGNvdWxkIGJlIGNoYWxsZW5naW5nLCBidXQgSVNUTSBrdm0gY291bGQNCj4gcGxhdXNp
Ymx5IG93biBhbiBtbV9zdHJ1Y3QgYW5kIHBhZ2V0YWJsZXMgYXQgdGhlIGNvc3Qgb2Ygc29tZSB3
YXN0ZWQNCj4gbWVtb3J5LiAgVGhlIHJlc3VsdCB3b3VsZCwgdW5kZXIgdGhlIGhvb2QsIHdvcmsg
bW9yZSBvciBsZXNzIGxpa2UgdGhlDQo+IGN1cnJlbnQgaW1wbGVtZW50YXRpb24sIGJ1dCB0aGUg
QVBJIHdvdWxkIGJlIHF1aXRlIGRpZmZlcmVudC4NCg0KVGhpcyBsb29rcyBsaWtlIGFuIGF0dGVt
cHQgdG8gcGFzcyBtZW1vcnkgcmVsYXRlZCBjb25jZXJucyB0byBLVk0gZGV2ZWxvcGVycy4NClRo
ZSB1c2Vyc3BhY2UgbWFwcGluZyBtZWNoYW5pc20gaXMgZ29vZCBhcyBpdCBpcy4gUHJvYmFibHkg
bm90IHBlcmZlY3QsIGp1c3QgDQpnb29kLiBUaGUgcHJvYmxlbSBpcyB0aGF0IGl0J3Mgc3R1Y2sg
dG8gYSBmZXcgVk1BIG1vZGVscyBhbmQgbmVlZHMgdG8gZXZvbHZlDQp0b3dhcmRzIG1vcmUgYml6
YXJyZS9za2V0Y2h5L3dlaXJkL2ZyYWdpbGUgcGF0dGVybnMuDQoNCkFsc28gdGhlIG1lbW9yeSBj
b2RlIGlzIG9uZSBvZiB0aGUgbW9zdCB0aWdodGx5IGNvdXBsZWQgY29kZSBJIGhhdmUgc2Vlbi4N
ClByb2JhYmx5IGV4cGxhaW5zIHRoZSBmZWFyIG9mIHRoZSBtYWludGFpbmVycyB0byB0cnkgc29t
ZXRoaW5nIG5ldy4NCg0KTWlyY2VhDQoNCg==

Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40F2D25DB3A
	for <lists+linux-api@lfdr.de>; Fri,  4 Sep 2020 16:19:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730467AbgIDOTV (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 4 Sep 2020 10:19:21 -0400
Received: from mail-eopbgr70102.outbound.protection.outlook.com ([40.107.7.102]:1115
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730526AbgIDOSn (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Fri, 4 Sep 2020 10:18:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QoaMpP49EM5QeBvYgZDWnkA+rBDLBOA/qXUS4n7xWuU+91H335bhE8pcfYFKdeRH8K9UNm+2adDhGEjQm9kh/ImP/O2fv6s2daCZZzmVaTADMo4P6n0IwmFwTHgCJk2994fH49nA9852JOqhSZ48rclCA1LVhny+qKi5zK+jD/wPnxXBWYA0FVkMyguj1nCNhumJJ/cqa0TaG2iKNwrl/8O9EWXwf9jcTtZ2ETJhqp2Owj1/must/g1LjNtiWPMClCAnAimOGjyFF1R/N0ezHPqtgmKBVA3dEcyDRV8nldks0hX01eQElzjOaFOnvvKBWezvTk6lfx8REcVEOcS+vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b1MUeTd7IDSoux4vYuOpT59H+wgaOtyrSP52e19NaVQ=;
 b=WYhDvkmQF5cEEt4WdOrDJqo3eX9QCDF8zPFTi+9ddgQtYBb9ouS2+kVKH27TRfjv8KAlnDFzjbkpGpTCbanKXjRB+vc9PCR56Sv1YM7LVr0+TMkMd3zt8BVxB44ZphMG5niYSZuDMx5Y7dYhAX7Lf1cYxLpwlq6uODYSv8+PbaeJfUj8y+/ZyIh2XevdkAEPWpiZENd4IftsC5xKzz/qpJDkINkgMHNat3gRLGjV1m89oyc67P+ytDFFf5WHzSzIVQdSU2AZv43QdfSI/1PPkxA1DBqx+Z2MUoxpWSOuub4jan1igA4pGBiHqwhSpaAvop22nCb4hOnqFMhAb8TyVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bitdefender.com; dmarc=pass action=none
 header.from=bitdefender.com; dkim=pass header.d=bitdefender.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bitdefender.onmicrosoft.com; s=selector2-bitdefender-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b1MUeTd7IDSoux4vYuOpT59H+wgaOtyrSP52e19NaVQ=;
 b=Swc8rA93V3VvKNhho7Q67Yaw3YO1L3RPdpxAjVySwJKNWDG5tiLBCH0rp39Wa6G5VNzc5GeQ2p28R44DLbZ8RQCbpJcJVBLd4DDxSD0LBroD+fqR9nR9PppuRnai6O47xr55XFIDvv45zPaxo8ktVaQguZbI5avO7g8p7rnv/HU=
Received: from AM7PR02MB6082.eurprd02.prod.outlook.com (2603:10a6:20b:1af::16)
 by AM6PR02MB4280.eurprd02.prod.outlook.com (2603:10a6:20b:41::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19; Fri, 4 Sep
 2020 14:18:37 +0000
Received: from AM7PR02MB6082.eurprd02.prod.outlook.com
 ([fe80::9dcc:d3cc:dbe:5b33]) by AM7PR02MB6082.eurprd02.prod.outlook.com
 ([fe80::9dcc:d3cc:dbe:5b33%8]) with mapi id 15.20.3348.016; Fri, 4 Sep 2020
 14:18:37 +0000
From:   Mircea CIRJALIU - MELIU <mcirjaliu@bitdefender.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     =?utf-8?B?QWRhbGJlcnQgTGF6xINy?= <alazar@bitdefender.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
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
Thread-Index: AQHWgq7sJAwNYCdpy0yn8gtG4wotq6lYY8IAgAAIjBCAAA/agIAACefA
Date:   Fri, 4 Sep 2020 14:18:37 +0000
Message-ID: <AM7PR02MB6082B1192A87C027DE2FD668BB2D0@AM7PR02MB6082.eurprd02.prod.outlook.com>
References: <20200904113116.20648-1-alazar@bitdefender.com>
 <20200904121148.GR24045@ziepe.ca>
 <AM7PR02MB60824E11A81A63A7CE94848CBB2D0@AM7PR02MB6082.eurprd02.prod.outlook.com>
 <20200904133907.GS24045@ziepe.ca>
In-Reply-To: <20200904133907.GS24045@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: ziepe.ca; dkim=none (message not signed)
 header.d=none;ziepe.ca; dmarc=none action=none header.from=bitdefender.com;
x-originating-ip: [31.5.46.39]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a8449fc5-d6b4-4c43-3807-08d850dd6a27
x-ms-traffictypediagnostic: AM6PR02MB4280:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR02MB428016D5CC0E6365BA81F679BB2D0@AM6PR02MB4280.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qmg74KRNG1IGiuS/TfL6p2sC+AhW3lzLV2bBaVpE3CQ6sfbFSAlSPBCoFYIQJgttlOjtcjgsPXP/sD5oQKGOafjzFNd/EzJPLCIvnIDbQgr+ai4LRSQoKmMtf0IbdXEH5cBLOHFFRQZtGe36fYWOdk3XMftDymhC0q1toUgWM9I2dmYE1PkIhUzphmCx6pDYuRveIeP7ZbOeSBR0Hy2UOQGqnvKxSY5kfTWM5xj+U2STxS1uW1MnwerxDuc630rl+9yRKWTWKaXZi7ajOKOc1jouqmASIlrihz2LlpdQKc5tU6VqQ68NnhKUGNSNssRkxovpP5oaYxe8XF2xS6SAbOZbCwGy0Qb4oWH7LJG01aE67Xngygzk2ifEEnfT+KbAPnKbvkh5RwgR+BFpdkwSNQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR02MB6082.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(366004)(376002)(39850400004)(346002)(396003)(83380400001)(4326008)(71200400001)(66446008)(66574015)(52536014)(86362001)(5660300002)(66476007)(7416002)(64756008)(76116006)(66946007)(66556008)(26005)(9686003)(55016002)(7696005)(478600001)(54906003)(6506007)(6916009)(8936002)(186003)(33656002)(966005)(316002)(2906002)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: MVbLhLbNl4PlJ+V9CRrnKVPvikz6M9lv1mNcn7aYzgglvjr278h0uf1w9XVUrp+v1r/IRW/EfBmdkIHj8PDxlytaAFHclWg0QFiVr/FheMDeonDbu2PXqWMsy0LhNpFpVoDvhp68z2JcXGHeYEAO1MtswVAajih9Ttlv+fTW3ee2FKDhPMtumWU/n/E12TitpaKuQcL+87d9SHCrj23z2PfwcwD83UhI3gjphfp4lTcYig4ryLHM3MqmKMZBBO1GojdwLJDJYHhXKhkzXPDAfOPFgPy8MPjE1j4yrKZGerhX1bdcQiKV3p8dIl4jtaNAKqoPgwWauVH6IsiwvG7xOwQVmDqKU+tiwagGlmfGc+4j4foWkFPLLwQUT7ur1WmsIDjQ80K994crv60LRIly2kGmfKFjTRvmx32bMwXcgh8jj86fxMRtwPoLV9cQ9CRgVJcdNxcCvivQo2aCwflcQJPlPQjos5qWuVWwUV7h4UHs+i2JDpPOwUYLqkFXmytPUw6+Y1YVgiuNBrIGnc/yONbuP/xI6+4VHFN97mb/DmEMPr9di4Ws7E8oqpAW7nufPCaSAVvpENnUc+sFXRKE6P/aWOxeaeiMyUHLIfB/vHKFAmAeClhZn+pEWDzSCWGeCHgewh1rqTAC2Ru2d24W7A==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bitdefender.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM7PR02MB6082.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8449fc5-d6b4-4c43-3807-08d850dd6a27
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2020 14:18:37.1148
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 487baf29-f1da-469a-9221-243f830c36f3
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 25JzNbFu+z7r3rhHe/9yHYov+Heo/gdNrg19kpTChHsAd4kN2WCJoAMWuVIv14aLSfGWlKEREfXFB/o+rjI9jbbAfrew8iLnZvoVEFRwnDY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR02MB4280
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

PiBPbiBGcmksIFNlcCAwNCwgMjAyMCBhdCAwMToyNDo0M1BNICswMDAwLCBNaXJjZWEgQ0lSSkFM
SVUgLSBNRUxJVSB3cm90ZToNCj4gPiA+IE9uIEZyaSwgU2VwIDA0LCAyMDIwIGF0IDAyOjMxOjEx
UE0gKzAzMDAsIEFkYWxiZXJ0IExhesSDciB3cm90ZToNCj4gPiA+ID4gVk1BcyBvYnRhaW5lZCBi
eSBtbWFwKClpbmcgbWVtb3J5IGFjY2VzcyBmZHMgbWlycm9yIHRoZSBjb250ZW50cw0KPiA+ID4g
PiBvZiB0aGUgcmVtb3RlIHByb2Nlc3MgYWRkcmVzcyBzcGFjZSB3aXRoaW4gdGhlIHNwZWNpZmll
ZCByYW5nZS4NCj4gPiA+ID4gUGFnZXMgYXJlIGluc3RhbGxlZCBpbiB0aGUgY3VycmVudCBwcm9j
ZXNzIHBhZ2UgdGFibGVzIGF0IGZhdWx0DQo+ID4gPiA+IHRpbWUgYW5kIHJlbW92ZWQgYnkgdGhl
IG1tdV9pbnRlcnZhbF9ub3RpZmllciBpbnZhbGlkYXRlIGNhbGxiY2suDQo+ID4gPiA+IE5vIGZ1
cnRoZXIgbWVtb3J5DQo+ID4gPiBtYW5hZ2VtZW50IGlzIGludm9sdmVkLg0KPiA+ID4gPiBPbiBh
dHRlbXB0cyB0byBhY2Nlc3MgYSBob2xlLCBvciBpZiBhIG1hcHBpbmcgd2FzIHJlbW92ZWQgYnkN
Cj4gPiA+ID4gUElERkRfTUVNX1VOTUFQLCBvciBpZiB0aGUgcmVtb3RlIHByb2Nlc3MgYWRkcmVz
cyBzcGFjZSB3YXMNCj4gcmVhcGVkDQo+ID4gPiBieQ0KPiA+ID4gPiBPT00sIHRoZSByZW1vdGUg
bWFwcGluZyBmYXVsdCBoYW5kbGVyIHJldHVybnMgVk1fRkFVTFRfU0lHQlVTLg0KPiA+ID4NCj4g
PiA+IEkgc3RpbGwgdGhpbmsgYW55dGhpbmcgYWxvbmcgdGhlc2UgbGluZXMgbmVlZHMgdG8gbWVl
dCB0aGUgWFBNRU0gdXNlDQo+ID4gPiBjYXNlcyBhcyB3ZWxsLCB3ZSBoYXZlIHRvIGhhdmUgbW9y
ZSBnZW5lcmFsIHNvbHV0aW9ucyBmb3Igc3VjaCBNTQ0KPiA+ID4gc3R1ZmY6DQo+ID4gPg0KPiA+
ID4gaHR0cHM6Ly9naXRsYWIuY29tL2hqZWxtbi94cG1lbQ0KPiA+ID4NCj4gPiA+IEhvd2V2ZXIs
IEkgdGhpbmsgdGhpcyBmdW5kYW1lbnRhbGx5IGZhbGxzIGludG8gc29tZSBvZiB0aGUgc2FtZSBi
YWQNCj4gPiA+IGRpcmVjdGlvbiBhcyB4cG1lbS4NCj4gPiA+DQo+ID4gPiBJIHdvdWxkIG11Y2gg
cmF0aGVyIHNlZSB0aGlzIGRlc2lnbiBjb3B5ICYgY2xvbmUgdGhlIFZNQSdzIHRoYW4gdHJ5DQo+
ID4gPiB0byBtaXJyb3IgdGhlIFBURXMgaW5zaWRlIHRoZSBWTUFzIGZyb20gdGhlIHJlbW90ZSBp
bnRvIGEgc2luZ2xlDQo+ID4gPiBnaWFudCBWTUEgYW5kIHNvbWVob3cgc3BsaXQvbWlycm9yIHRo
ZSBWTUEgb3BzLg0KPiA+DQo+ID4gVGhpcyBkZXNpZ24gd2FzIG1hZGUgc3BlY2lmaWNhbGx5IGZv
ciB2aXJ0dWFsIG1hY2hpbmUgaW50cm9zcGVjdGlvbiwNCj4gPiB3aGVyZSB3ZSBjYXJlIG1vcmUg
YWJvdXQgdGhlIGNvbnRlbnRzIG9mIHRoZSBhZGRyZXNzIHNwYWNlLCByYXRoZXINCj4gPiB0aGFu
IHRoZSByZW1vdGUgVk1BcyBhbmQgdGhlaXIgdm1vcHMuIChSaWdodCBub3cgb25seSBhbm9uIHBh
Z2VzIGNhbg0KPiA+IGJlIG1hcHBlZCwgYnV0IEkgZ3Vlc3Mgd2UgY2FuIGV4dGVuZCB0byBwYWdl
Y2FjaGUgcGFnZXMgYXMgd2VsbC4pIEkNCj4gPiBqdXN0IHVzZWQgd2hhdCBzZWVtZWQgdG8gYmUg
dGhlIGNvbW1vbiBkZW5vbWluYXRvciB0byBhbGwgcGFnZS1yZWxhdGVkDQo+IG9wZXJhdGlvbnM6
IHJhbmdlIGludmFsaWRhdGlvbi4NCj4gPiBUaGlzIGxvb2tzIGxpa2UgYSBnZW5lcmFsIHNvbHV0
aW9uLg0KPiANCj4gVGhlIHBvaW50IGlzIHRoYXQgYSBWTUEgaXMgaG93IHRoZSBNTSBjb25uZWN0
cyBpdHMgcGFydHMgdG9nZXRoZXIsIGNsb25pbmcNCj4gdGhlIGNvbnRlbnQgb2YgYSBWTUEgd2l0
aG91dCB0aGUgcmVzdCBvZiB0aGUgVk1BIG1ldGEtZGF0YSBpcyBqdXN0IGdvaW5nIHRvDQo+IGJl
IHZlcnkgZnJhZ2lsZSBpbiB0aGUgbG9uZyBydW4uLg0KPiANCj4gRXNwZWNpYWxseSBpZiB0aGUg
Vk1BIGlzIHByZXNlbnRlZCBhcyBhIG5vcm1hbCBWTUEgd2l0aCB3b3JraW5nIHN0cnVjdA0KPiBw
YWdlcy9ldGMsIG5vdCBhIHBmbiBtYXAuDQo+DQo+ID4gSU1PIGNsb25pbmcgYSBWTUEgaW4gYW4g
YWRkcmVzcyBzcGFjZSB0aGF0IGhhcyBhIGNvbXBsZXRlbHkgZGlmZmVyZW50DQo+ID4gbGF5b3V0
IHdpbGwgcHJlc2VudCBpdHMgb3duIHNldCBvZiBjYXZlYXRzOiBXaGF0IGhhcHBlbnMgaWYgdGhl
IFZNQQ0KPiByZXNpemVzL3NwbGl0cz8NCj4gPiBDYW4geW91IHJlcGxheSBhbGwgdGhlIHJlbW90
ZSBWTUEgdm1vcHMgb24gdGhlIGNsb25lIFZNQT8NCj4gDQo+IFRoZSBtaXJyb3Igd291bGQgaGF2
ZSB0byByZWNsb25lIHRoZSBzb3VyY2UgVk1BIGV2ZXJ5IHRpbWUgdGhlIHNvdXJjZQ0KPiBWTUEg
Y2hhbmdlcy4NCj4gDQo+ID4gPiBUaGlzIGlzIGp1c3QgdG9vIHdlaXJkIGFuZCBmcmFnaWxlIHRv
IGJlIG1haW50YWlibGUgb3ZlciBhIGxvbmcgdGVybS4NCj4gPiA+DQo+ID4gPiBGb3IgaW5zdGFu
Y2UsIG9uZSBvZiB0aGUgbWFqb3IgYnVncyBpbiB0aGluZ3MgbGlrZSB4cG1lbSB3YXMgdGhhdA0K
PiA+ID4gdGhleSBhcmUgaW5jb21wYXRpYmxlIHdpdGggZ2V0X3VzZXJfcGFnZXMoKSwgbGFyZ2Vs
eSBiZWNhdXNlIG9mIHRoaXMNCj4gaXNzdWUuDQo+ID4NCj4gPiBXZSBzdXBwb3J0IGdldF91c2Vy
X3BhZ2VzKCksIHRoYXQncyBob3cgd2UgaW50ZWdyYXRlIHdpdGggS1ZNLg0KPiANCj4gVGhpcyBz
ZWVtcyByZWFsbHkgc2tldGNoeSwgZ2V0X3VzZXJfcGFnZXMgaXMgc2Vuc2l0aXZlIHRvIHRoZSBW
TUEsIHdoYXQNCj4gaGFwcGVucyB3aGVuIFZNQSBmbGFncyBhcmUgZGlmZmVyZW50L2V0Yz8NCg0K
QSBkZWJ1Z2dlciBzaG91bGRuJ3QgY29tcGxhaW4gaWYgYSBwb3J0aW9uIG9mIHRoZSBkZWJ1Z2dl
ZSBpcyByZWFkLW9ubHksDQpqdXN0IG92ZXJ3cml0ZSB0aGUgZGF0YS4NCg0KPiBKYXNvbg0K

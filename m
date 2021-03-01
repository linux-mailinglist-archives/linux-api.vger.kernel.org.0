Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1DE732899D
	for <lists+linux-api@lfdr.de>; Mon,  1 Mar 2021 19:03:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235710AbhCASAj (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 1 Mar 2021 13:00:39 -0500
Received: from mail-eopbgr1400129.outbound.protection.outlook.com ([40.107.140.129]:54432
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234747AbhCARzR (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Mon, 1 Mar 2021 12:55:17 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J5zBr/4LNe/bFm/XPsVJABudaLm7rkAj5JWwqjtDshj5U1maD6HFpNYgFXQs/xDodqVkNGERiqPUXpBYQpclNlU2flY++crlWulLsnN/PT98OSfMgoqZtGz2/bhWXDoxG3g818QdXH97tAsv4TNGGRRI2SA4L1D2O7n8V71iKKu9qbzF3+eaM198PiWH/eUA1nVEQMbUso0cNxqh1qce86NE0lNzWZ06PfdfaPNFRa2FxmIXizBT8qofD+9UIXT+FzYBOZuSoS3iyXGyVFpsYY9BWgdhvkW70K7OCRuKwDchGhS3Ikck4TCDZeCo8f8pEfcES1dpTn+gKUPIgt2IkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ksQOXYnvVdV9oiy0FmYG2JIB+sPjMaxbDgWmH+SImow=;
 b=PBGrWA/bGV8NUof/+tV9JguJnF0XFY0SqWAtajqm1KZXmmee9posV8N496sIuYk8rHtxIi+QbvCVc9d9pygRWGnAdMJFnlabzj50T23O7CPhyV4womJ/4TXYnUB86TDkQcJwLh+St2rVRgmqqotI5Go2F5KMZpPRdK255VYqg0KHqv+ws6NsdA8GakdJ+/iD75U8Gl/2+SYEfAaTAFcTEgHa51ojnUe+OraotZJOEJjHhBejWBfOC2ywRGauniiS+CPIl0PNNtito6kJNJU2oGS8scolCgry5YJyiVGGWdzJ/+7+jGAuImMoSxLtsDzVgjKWZ+wMXW9hmHfWyMgWJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ksQOXYnvVdV9oiy0FmYG2JIB+sPjMaxbDgWmH+SImow=;
 b=sKOrAsW6MaQL0vWug0EU7OKkQC7rkx3njgXFauagKmBP4PLyi9U0cTg00wPAUx6TSMh20gswmPVtfc5BnLXnMjmdUwZuwGT/cunS5DIz5Q5MeCrl5s3HwadC4eB0/bquQscpys+VOhmESDUITrQbRw0HQ/t9fT3DyqMQZzeRZBI=
Received: from OSAPR01MB2737.jpnprd01.prod.outlook.com (2603:1096:603:38::21)
 by OSBPR01MB3494.jpnprd01.prod.outlook.com (2603:1096:604:41::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Mon, 1 Mar
 2021 17:54:22 +0000
Received: from OSAPR01MB2737.jpnprd01.prod.outlook.com
 ([fe80::4d2d:3155:768e:50e0]) by OSAPR01MB2737.jpnprd01.prod.outlook.com
 ([fe80::4d2d:3155:768e:50e0%7]) with mapi id 15.20.3890.028; Mon, 1 Mar 2021
 17:54:22 +0000
From:   Fabrizio Castro <fabrizio.castro.jz@renesas.com>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Arnd Bergmann <arnd@kernel.org>
CC:     Rob Herring <robh+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux API <linux-api@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        "REE dirk.behme@de.bosch.com" <dirk.behme@de.bosch.com>,
        Peter Erben <Peter.Erben@de.bosch.com>,
        Linux Media Mailing List <linux-media@vger.kernel.org>
Subject: RE: [PATCH 4/7] misc: Add driver for DAB IP found on Renesas R-Car
 devices
Thread-Topic: [PATCH 4/7] misc: Add driver for DAB IP found on Renesas R-Car
 devices
Thread-Index: AQHXC8kAUgvuEwTuE0CHH++Hj25LCKpqP0IAgAApOQCABQduUA==
Date:   Mon, 1 Mar 2021 17:54:22 +0000
Message-ID: <OSAPR01MB27374ACC15B53B3C4E43F718C29A9@OSAPR01MB2737.jpnprd01.prod.outlook.com>
References: <20210225225147.29920-1-fabrizio.castro.jz@renesas.com>
 <20210225225147.29920-5-fabrizio.castro.jz@renesas.com>
 <CAK8P3a1+CZTAcR5T=gN565Q8=CdZnu5KYsAijKXLY8taofEpGg@mail.gmail.com>
 <YDjyDB/l6dVoodKZ@pendragon.ideasonboard.com>
In-Reply-To: <YDjyDB/l6dVoodKZ@pendragon.ideasonboard.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: ideasonboard.com; dkim=none (message not signed)
 header.d=none;ideasonboard.com; dmarc=none action=none
 header.from=renesas.com;
x-originating-ip: [2.28.163.123]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ff4e7c77-4a3f-4fa5-7e93-08d8dcdb0bd4
x-ms-traffictypediagnostic: OSBPR01MB3494:
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <OSBPR01MB34944CC72976236585A009A6C29A9@OSBPR01MB3494.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RUQlLJfAip4UST5yPVG9kXiy9GL1sRzj9W+mx1fqv+mZgnQKdxcIgrvqi1Z8H90whQTN4PokMF6dnXInEx6dNUXAcPV5GbMvGFD8dSuyUdv74wXJzMpx3+O/c5Yu9t37/quOFR7slbZt5FJU5HHzSaYbTha0Ws6VhZ+26p5I+Es5tAo+i6UYlZKufX+zz5NQNkg+yncMU56XXzjLjuQ3QWlOI4/F75Db4dRsr9JUUPM0hcaNl4DBUvqY0bNM9oAjA95zAHu/lq8se52WTjv3GXympaWlaZEc3kjblzN0j62lgwpgOod50DgHCQrSyPkoHwzSNpOg/S0PDVP/4XDG6+Lq1giW8SCHhyEHqVwvj+2JHr9EEbefoen+2hOeaVFXvxeU2xMqAvPSxvE432DeHKspvL8iVIyWb8DVGQ2N55Rr4fg9CnuICk5kKSlrVcII/zLSNVcLLtqzD9qtDDriKsDXBLIwnSljxEnEtyMcl19AsZCcFm+0OEoCdwYoUGRTflOIWqDtaBKFYBi5FTaZ4A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSAPR01MB2737.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(376002)(366004)(396003)(136003)(7416002)(54906003)(110136005)(55016002)(76116006)(7696005)(5660300002)(8676002)(9686003)(2906002)(52536014)(316002)(186003)(66476007)(53546011)(6506007)(66946007)(64756008)(66446008)(33656002)(66556008)(8936002)(4326008)(86362001)(478600001)(26005)(71200400001)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?bmN3cjFMVnI3WlFvUjdMa2NZNU1pNTUzZEpFelNwaVRELzFlOTJVcVFUMGNm?=
 =?utf-8?B?NmZmaDJuRkZJcDNiRjF0Mm9KKzRqMlFCNCtWMXAwODlqN29sSTlaVlk4OUQ2?=
 =?utf-8?B?dDVXclgvR2FJdThkOWNUNDlDdENrZ25DekozQnNULzNCcVY3em1mTTF0OVkx?=
 =?utf-8?B?aUQzcGwyQlFjS29ub2wxVjBZVFpwMFNDRmlqejFvS0FJM1pPQ2gxdmZBRmp5?=
 =?utf-8?B?Q0VQVnhPUmpoQldFbjBtZktrT0M2M3VpVTJJaDVDblNMRVNNSzE3MGNnVElk?=
 =?utf-8?B?U09HRXB4RjZ2TjRjeVZVM2FFNVEvNERoYVVpSnRyNisxb1BsYUxZUm1BM2Fr?=
 =?utf-8?B?L3lGRHEwRUFmVWRsakxNOERwd1FRTUdQNGIzNGNSUGxhN25Va3pDbllNL2dL?=
 =?utf-8?B?VWtTMzJ6NGtaZ0w0TCt1VkhTWXZkOWE1cU92ZHlkNlJ3Um4veDh2NnZrdXJa?=
 =?utf-8?B?ZFp4b2J1dDN6YVNyTVBncm52SXRqbnJ1cUlycmk2ZXZITjZacElHcmlWYVda?=
 =?utf-8?B?ZVVqa2JzaUIvdjgyWmg3OFV4Zyt3bnFaa3RUVTZhUW9KajNoRUZIWXgvZ1Qx?=
 =?utf-8?B?aXlrY3RJbE0vRDZOYmpSbXBnK2ZCaVdyc01uK0F4cE5JdXRwTG94US9ySERr?=
 =?utf-8?B?MU5DTW1lVU5FeXlFNmhISURPWWdDOU9KdzRQWEUySWY1TlkvYXdOTWlIc0J1?=
 =?utf-8?B?U3Q5NDRoeTZUbTlOUitLTWtGZzdqQnB2V3VCU3FnSlV3SjNkcEduMGlCTGJs?=
 =?utf-8?B?UGwvYzBnbThtVlY4Sk91ckxrcUhkeTcyUThyVlM5UFo3VmJsMi8vOXoweUp0?=
 =?utf-8?B?S0UvNGh4clpHUklBRGx6S1pCVDNYVThnbWpDbTZHQUpaMDJQL3p1NGxZR0M0?=
 =?utf-8?B?UFdpS0J3cnBiTXQwN0NUY2N3TzQyalBPdHU0ZkZSb2V0T3I5TlB5SURkaU5V?=
 =?utf-8?B?V2tvZ2g1bkFsemowM0V3eDhWcmV6bXB0YThsZXFuQ09aRjhvZXpMQ2VDOFlG?=
 =?utf-8?B?NzZhYTNKNE90UVJQN1FXMkRobVZ0QlVDN2dVeTVQSThXL3Ura09OYk9iNUQv?=
 =?utf-8?B?Sll3VEluQ0NHRjAvUWY2bUhySXBqdTA1MERhbWd2UkVQWUJSaHBPR2FBZ0dw?=
 =?utf-8?B?a2ZDbFpZL0VocjZrOTZaWmNUSk93MVVVU0V2ZlM2ZTBaVHlaNXhtRmdqYmhR?=
 =?utf-8?B?SWx0UWVNdXdFWlJiMFN4cFdSYmc3OEtNWTJnYzh2c3R4L1BIM3RHOElpN05k?=
 =?utf-8?B?S0tDMnVsVzZlMTJPSkNMWUJWcW1oblNCVFAxWVJtYy92STByYTIySGNydkl5?=
 =?utf-8?B?YkgrZ05HS1RNSmV3YnI2S3VYSy9ENFdnaE9EeEFITC80T3hlcytLQVlhbnVM?=
 =?utf-8?B?Tm1SN0ZqdWJmWWk3TmlsTHJiRnQ3N0pmWFFoTnVpTXNlZC9LOGl2VzJ6ZmJs?=
 =?utf-8?B?V0FHemduVm4xS2NIc0RHR2Q3d3FMQzlPZTYveDhQeVU3Y2x2WlZTdTZITTYr?=
 =?utf-8?B?UUR5ZGM1dnlXL3IxS1Y4RzVmU3VMMFljWmkrSmxIS3l6RUg2aWxDelhwclNS?=
 =?utf-8?B?SmJseFBJSU9NYjZhYnFaQXVSLzZWeFd5WTEyb3VweTIyTUswSWQvaE9QZC9T?=
 =?utf-8?B?eTc2KzVRU3N2dGJOeGRYMkxkNytJSXE1NU9qQXRWQjRXRFRLejZRZEFWQzNS?=
 =?utf-8?B?VmlNcEhvY1JsMFBYVkh6QWJxSmdwUDBQQlA3TXg1UVZBQ0lHc2ViaGgybXRi?=
 =?utf-8?Q?Lsr1mHrrpYwDscXlGsCgwGmGzPj+SN/gKcx0H8q?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSAPR01MB2737.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff4e7c77-4a3f-4fa5-7e93-08d8dcdb0bd4
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2021 17:54:22.5270
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gpLVTJyi1P6ds3TN4827oTLqscJt3KdYJ1/4ej8S6PXxXirSXvOeadND7Xq3U1RYKY8pgqqNddzfMkEJ1/44DYaGw3ZHpjJ0ex/lHFYhYyo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB3494
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

SGkgTGF1cmVudCwNCg0KVGhhbmsgeW91IGZvciB5b3VyIGZlZWRiYWNrIQ0KDQo+IEZyb206IExh
dXJlbnQgUGluY2hhcnQgPGxhdXJlbnQucGluY2hhcnRAaWRlYXNvbmJvYXJkLmNvbT4NCj4gU2Vu
dDogMjYgRmVicnVhcnkgMjAyMSAxMzowNQ0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDQvN10gbWlz
YzogQWRkIGRyaXZlciBmb3IgREFCIElQIGZvdW5kIG9uIFJlbmVzYXMgUi0NCj4gQ2FyIGRldmlj
ZXMNCj4gDQo+IEhpIEZhYnJpemlvLA0KPiANCj4gVGhhbmsgeW91IGZvciB0aGUgcGF0Y2guDQo+
IA0KPiBPbiBGcmksIEZlYiAyNiwgMjAyMSBhdCAxMTozNzo0NEFNICswMTAwLCBBcm5kIEJlcmdt
YW5uIHdyb3RlOg0KPiA+IE9uIFRodSwgRmViIDI1LCAyMDIxIGF0IDExOjUxIFBNIEZhYnJpemlv
IENhc3RybyB3cm90ZToNCj4gPiA+DQo+ID4gPiBUaGUgREFCIGhhcmR3YXJlIGFjY2VsZXJhdG9y
IGZvdW5kIG9uIFItQ2FyIEUzIGFuZCBSLUNhciBNMy1OIGRldmljZXMNCj4gaXMNCj4gPiA+IGEg
aGFyZHdhcmUgYWNjZWxlcmF0b3IgZm9yIHNvZnR3YXJlIERBQiBkZW1vZHVsYXRvcnMuDQo+ID4g
PiBJdCBjb25zaXN0cyBvZiBvbmUgRkZUIChGYXN0IEZvdXJpZXIgVHJhbnNmb3JtKSBtb2R1bGUg
YW5kIG9uZSBkZWNvZGVyDQo+ID4gPiBtb2R1bGUsIGNvbXBhdGlibGUgd2l0aCBEQUIgc3BlY2lm
aWNhdGlvbiAoRVRTSSBFTiAzMDAgNDAxIGFuZA0KPiA+ID4gRVRTSSBUUyAxMDIgNTYzKS4NCj4g
PiA+IFRoZSBkZWNvZGVyIG1vZHVsZSBjYW4gcGVyZm9ybSBGSUMgZGVjb2RpbmcgYW5kIE1TQyBk
ZWNvZGluZw0KPiBwcm9jZXNzaW5nDQo+ID4gPiBmcm9tIGRlLXB1bmN0dXJlIHRvIGZpbmFsIGRl
Y29kZWQgcmVzdWx0Lg0KPiA+ID4NCj4gPiA+IFRoaXMgcGF0Y2ggYWRkcyBhIGRldmljZSBkcml2
ZXIgdG8gc3VwcG9ydCB0aGUgRkZUIG1vZHVsZSBvbmx5Lg0KPiA+ID4NCj4gPiA+IFNpZ25lZC1v
ZmYtYnk6IEZhYnJpemlvIENhc3RybyA8ZmFicml6aW8uY2FzdHJvLmp6QHJlbmVzYXMuY29tPg0K
PiA+ID4gLS0tDQo+ID4gPiAgTUFJTlRBSU5FUlMgICAgICAgICAgICAgICAgICAgICAgfCAgIDcg
KysNCj4gPiA+ICBkcml2ZXJzL21pc2MvS2NvbmZpZyAgICAgICAgICAgICB8ICAgMSArDQo+ID4g
PiAgZHJpdmVycy9taXNjL01ha2VmaWxlICAgICAgICAgICAgfCAgIDEgKw0KPiA+ID4gIGRyaXZl
cnMvbWlzYy9yY2FyX2RhYi9LY29uZmlnICAgIHwgIDExICsrDQo+ID4gPiAgZHJpdmVycy9taXNj
L3JjYXJfZGFiL01ha2VmaWxlICAgfCAgIDggKysNCj4gPiA+ICBkcml2ZXJzL21pc2MvcmNhcl9k
YWIvcmNhcl9kZXYuYyB8IDE3Ng0KPiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+
ID4gPiAgZHJpdmVycy9taXNjL3JjYXJfZGFiL3JjYXJfZGV2LmggfCAxMTYgKysrKysrKysrKysr
KysrKysrKysNCj4gPiA+ICBkcml2ZXJzL21pc2MvcmNhcl9kYWIvcmNhcl9mZnQuYyB8IDE2MCAr
KysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+ID4gPiAgaW5jbHVkZS91YXBpL2xpbnV4L3Jj
YXJfZGFiLmggICAgfCAgMzUgKysrKysrDQo+ID4NCj4gPiBDYW4geW91IGV4cGxhaW4gd2h5IHRo
aXMgaXMgbm90IGluIGRyaXZlcnMvbWVkaWEvPw0KPiA+DQo+ID4gSSBkb24ndCB0aGluayB3ZSB3
YW50IGEgY3VzdG9tIGlvY3RsIGludGVyZmFjZSBmb3IgYSBkZXZpY2UgdGhhdA0KPiBpbXBsZW1l
bnRzDQo+ID4gYSBnZW5lcmljIHNwZWNpZmljYXRpb24uIE15IGZpcnN0IGZlZWxpbmcgd291bGQg
YmUgdGhhdCB0aGlzIHNob3VsZCBub3QNCj4gPiBoYXZlIGEgdXNlci1sZXZlbCBBUEkgYnV0IGlu
c3RlYWQgZ2V0IGNhbGxlZCBieSB0aGUgREFCIHJhZGlvIGRyaXZlci4NCj4gPg0KPiA+IFdoYXQg
aXMgdGhlIGludGVuZGVkIHVzYWdlIG1vZGVsIGhlcmU/IEkgYXNzdW1lIHRoZSBpZGVhIGlzIHRv
DQo+ID4gdXNlIGl0IGluIGFuIGFwcGxpY2F0aW9uIHRoYXQgcmVjZWl2ZXMgYXVkaW8gb3IgbWV0
YWRhdGEgZnJvbSBEQUIuDQo+ID4gV2hhdCBkcml2ZXIgZG8geW91IHVzZSBmb3IgdGhhdD8NCj4g
DQo+IEkgc2Vjb25kIEFybmQgaGVyZSwgYSBzdGFuZGFyZCBBUEkgd291bGQgYmUgYmVzdC4NCj4g
DQo+ID4gPiArc3RhdGljIGxvbmcgcmNhcl9kYWJfdW5sb2NrZWRfaW9jdGwoc3RydWN0IGZpbGUg
KmZpbGUsIHVuc2lnbmVkIGludA0KPiBjbWQsDQo+ID4gPiArICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICB1bnNpZ25lZCBsb25nIGFyZykNCj4gPiA+ICt7DQo+ID4gPiArICAgICAg
IHZvaWQgX191c2VyICphcmdwID0gKHZvaWQgX191c2VyICopYXJnOw0KPiA+ID4gKyAgICAgICBz
dHJ1Y3QgcmNhcl9kYWIgKmRhYjsNCj4gPiA+ICsgICAgICAgaW50IHJldDsNCj4gPiA+ICsNCj4g
PiA+ICsgICAgICAgZGFiID0gY29udGFpbmVyX29mKGZpbGUtPnByaXZhdGVfZGF0YSwgc3RydWN0
IHJjYXJfZGFiLCBtaXNjKTsNCj4gPiA+ICsNCj4gPiA+ICsgICAgICAgc3dpdGNoIChjbWQpIHsN
Cj4gPiA+ICsgICAgICAgY2FzZSBSQ0FSX0RBQl9JT0NfRkZUOg0KPiA+ID4gKyAgICAgICAgICAg
ICAgIGlmICghYWNjZXNzX29rKGFyZ3AsIHNpemVvZihzdHJ1Y3QgcmNhcl9kYWJfZmZ0X3JlcSkp
KQ0KPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIC1FRkFVTFQ7DQo+ID4gPiAr
ICAgICAgICAgICAgICAgcmV0ID0gcmNhcl9kYWJfZmZ0KGRhYiwgYXJncCk7DQo+ID4gPiArICAg
ICAgICAgICAgICAgYnJlYWs7DQo+ID4gPiArICAgICAgIGRlZmF1bHQ6DQo+ID4gPiArICAgICAg
ICAgICAgICAgcmV0ID0gLUVOT1RUWTsNCj4gPiA+ICsgICAgICAgfQ0KPiA+ID4gKw0KPiA+ID4g
KyAgICAgICByZXR1cm4gcmV0Ow0KPiA+ID4gK30NCj4gPiA+ICsNCj4gPiA+ICtzdGF0aWMgY29u
c3Qgc3RydWN0IGZpbGVfb3BlcmF0aW9ucyByY2FyX2RhYl9mb3BzID0gew0KPiA+ID4gKyAgICAg
ICAub3duZXIgICAgICAgICAgPSBUSElTX01PRFVMRSwNCj4gPiA+ICsgICAgICAgLnVubG9ja2Vk
X2lvY3RsID0gcmNhcl9kYWJfdW5sb2NrZWRfaW9jdGwsDQo+ID4gPiArfTsNCj4gPg0KPiA+IFRo
ZXJlIHNob3VsZCBiZSBhICcuY29tcGF0X2lvY3RsID0gY29tcGF0X3B0cl9pb2N0bCcNCj4gPiBl
bnRyeSwgcHJvdmlkZWQgdGhhdCB0aGUgYXJndW1lbnRzIGFyZSBjb21wYXRpYmxlIGJldHdlZW4N
Cj4gPiAzMi1iaXQgYW5kIDY0LWJpdCB1c2VyIHNwYWNlLg0KPiA+DQo+ID4gPiArDQo+ID4gPiAr
c3RhdGljIGludCByY2FyX2RhYl9mZnRfaW5pdChzdHJ1Y3QgcmNhcl9kYWIgKmRhYiwgc3RydWN0
DQo+IHJjYXJfZGFiX2ZmdF9yZXEgKmZmdCkNCj4gPiA+ICt7DQo+ID4gPiArICAgICAgIHUzMiBt
b2RlOw0KPiA+ID4gKw0KPiA+ID4gKyAgICAgICBmb3IgKG1vZGUgPSAwOyBtb2RlIDwgQVJSQVlf
U0laRShyY2FyX2RhYl9mZnRfc2l6ZV9sdXQpOw0KPiBtb2RlKyspDQo+ID4gPiArICAgICAgICAg
ICAgICAgaWYgKHJjYXJfZGFiX2ZmdF9zaXplX2x1dFttb2RlXSA9PSBmZnQtPnBvaW50cykNCj4g
PiA+ICsgICAgICAgICAgICAgICAgICAgICAgIGJyZWFrOw0KPiA+ID4gKyAgICAgICBpZiAobW9k
ZSA9PSBBUlJBWV9TSVpFKHJjYXJfZGFiX2ZmdF9zaXplX2x1dCkpDQo+ID4gPiArICAgICAgICAg
ICAgICAgcmV0dXJuIC1FSU5WQUw7DQo+ID4gPiArICAgICAgIGlmIChmZnQtPm9mZG1fbnVtYmVy
ID09IDApDQo+ID4gPiArICAgICAgICAgICAgICAgcmV0dXJuIC1FSU5WQUw7DQo+ID4gPiArDQo+
ID4gPiArICAgICAgIHJjYXJfZGFiX3dyaXRlKGRhYiwgUkNBUl9EQUJfRkZUU1NSLCBtb2RlKTsN
Cj4gPiA+ICsgICAgICAgcmNhcl9kYWJfd3JpdGUoZGFiLCBSQ0FSX0RBQl9GRlROVU1PRkRNUiwg
ZmZ0LT5vZmRtX251bWJlcik7DQo+ID4gPiArICAgICAgIHJjYXJfZGFiX3dyaXRlKGRhYiwgUkNB
Ul9EQUJfRkZUSU5BRERSLCAodTMyKWRhYi0NCj4gPmZmdC5kbWFfaW5wdXRfYnVmKTsNCj4gPiA+
ICsgICAgICAgcmNhcl9kYWJfd3JpdGUoZGFiLCBSQ0FSX0RBQl9GRlRPVVRBRERSLCAodTMyKWRh
Yi0NCj4gPmZmdC5kbWFfb3V0cHV0X2J1Zik7DQo+ID4NCj4gPiBNYXliZSB1c2UgbG93ZXJfMzJf
Yml0cygpIGluc3RlYWQgb2YgdGhlICh1MzIpIGNhc3QuDQo+ID4NCj4gPiBGb3IgY2xhcml0eSwg
eW91IG1heSBhbHNvIHdhbnQgdG8gc3BlY2lmaWNhbGx5IGFzayBmb3IgYSAzMi1iaXQgRE1BIG1h
c2sNCj4gPiBpbiB0aGUgcHJvYmUgZnVuY3Rpb24sIHdpdGggYSBjb21tZW50IHRoYXQgZGVzY3Jp
YmVzIHdoYXQgdGhlIGhhcmR3YXJlDQo+ID4gbGltaXRhdGlvbiBpcy4NCj4gPg0KPiA+ID4gKw0K
PiA+ID4gKyAgICAgICBpZiAoY29weV9mcm9tX3VzZXIoZGFiLT5mZnQuaW5wdXRfYnVmZmVyLCBm
ZnRfcmVxLQ0KPiA+aW5wdXRfYWRkcmVzcywNCj4gPiA+ICsgICAgICAgICAgICAgICAgICAgICAg
ICAgIGJ1ZmZlcl9zaXplKSkgew0KPiA+ID4gKyAgICAgICAgICAgICAgIG11dGV4X3VubG9jaygm
ZGFiLT5mZnQubG9jayk7DQo+ID4gPiArICAgICAgICAgICAgICAgcmV0dXJuIC1FRkFVTFQ7DQo+
ID4gPiArICAgICAgIH0NCj4gPiA+ICsNCj4gPiA+ICsgICAgICAgZGFiLT5mZnQuZG9uZSA9IGZh
bHNlOw0KPiA+ID4gKyAgICAgICByZXQgPSByY2FyX2RhYl9mZnRfaW5pdChkYWIsIGZmdF9yZXEp
Ow0KPiA+ID4gKyAgICAgICBpZiAocmV0KSB7DQo+ID4gPiArICAgICAgICAgICAgICAgbXV0ZXhf
dW5sb2NrKCZkYWItPmZmdC5sb2NrKTsNCj4gPiA+ICsgICAgICAgICAgICAgICByZXR1cm4gcmV0
Ow0KPiA+ID4gKyAgICAgICB9DQo+ID4gPiArDQo+ID4gPiArICAgICAgIHJjYXJfZGFiX2ZmdF9l
bmFibGUoZGFiKTsNCj4gPiA+ICsgICAgICAgd2FpdF9ldmVudF9pbnRlcnJ1cHRpYmxlX3RpbWVv
dXQoZGFiLT5mZnQud2FpdCwgZGFiLT5mZnQuZG9uZSwNCj4gSFopOw0KPiA+ID4gKyAgICAgICBp
ZiAoIWRhYi0+ZmZ0LmRvbmUpIHsNCj4gPiA+ICsgICAgICAgICAgICAgICByY2FyX2RhYl9mZnRf
ZGlzYWJsZShkYWIpOw0KPiA+ID4gKyAgICAgICAgICAgICAgIHJldCA9IC1FRkFVTFQ7DQo+ID4N
Cj4gPiAtRUZBVUxUIGRvZXNuJ3QgbG9vayBsaWtlIHRoZSByaWdodCBlcnJvciBmb3IgdGltZW91
dCBvciBzaWduYWwNCj4gPiBoYW5kbGluZy4gQmV0dGVyIGNoZWNrIHRoZSByZXR1cm4gY29kZSBm
cm9tDQo+IHdhaXRfZXZlbnRfaW50ZXJydXB0aWJsZV90aW1lb3V0KCkNCj4gPiBpbnN0ZWFkLg0K
PiA+DQo+ID4gPiArDQo+ID4gPiArc3RydWN0IHJjYXJfZGFiX2ZmdF9yZXEgew0KPiA+ID4gKyAg
ICAgICBpbnQgcG9pbnRzOyAgICAgICAgICAgICAgICAgICAgIC8qDQo+ID4gPiArICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICogVGhlIG51bWJlciBvZiBwb2ludHMgdG8N
Cj4gdXNlLg0KPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAq
IExlZ2FsIHZhbHVlcyBhcmUgMjU2LCA1MTIsDQo+IDEwMjQsIGFuZA0KPiA+ID4gKyAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAqIDIwNDguDQo+ID4gPiArICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICovDQo+ID4gPiArICAgICAgIHVuc2lnbmVk
IGNoYXIgb2ZkbV9udW1iZXI7ICAgICAgLyoNCj4gPiA+ICsgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgKiBPcnRob2dvbmFsIEZyZXF1ZW5jeQ0KPiBEaXZpc2lvbg0KPiA+
ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAqIE11bHRpcGxleGlu
ZyAoT0ZETSkuDQo+ID4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICogTWluaW11bSB2YWx1ZSBpcyAxLCBtYXhpbXVtDQo+IHZhbHVlIGlzDQo+ID4gPiArICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICogMjU1Lg0KPiA+ID4gKyAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAqLw0KPiA+ID4gKyAgICAgICB2b2lkIF9f
dXNlciAqaW5wdXRfYWRkcmVzczsgICAgIC8qDQo+ID4gPiArICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICogVXNlciBzcGFjZSBhZGRyZXNzIGZvciB0aGUNCj4gaW5wdXQN
Cj4gPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKiBidWZmZXIu
DQo+ID4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICovDQo+ID4g
PiArICAgICAgIHZvaWQgX191c2VyICpvdXRwdXRfYWRkcmVzczsgICAgLyoNCj4gPiA+ICsgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKiBVc2VyIHNwYWNlIGFkZHJlc3Mg
Zm9yIHRoZQ0KPiBvdXRwdXQNCj4gPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgKiBidWZmZXIuDQo+ID4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICovDQo+ID4gPiArfTsNCj4gPg0KPiA+IFBsZWFzZSByZWFkIERvY3VtZW50YXRp
b24vZHJpdmVyLWFwaS9pb2N0bC5yc3QgYW5kIG1ha2UgdGhpcyBhIHBvcnRhYmxlDQo+ID4gZGF0
YSBzdHJ1Y3R1cmUuDQo+IA0KPiBXZSd2ZSBzdWZmZXJlZCBlbm91Z2ggd2l0aCBETUEgdG8gdXNl
ciBwb2ludGVycy4gTGV0J3MgdXNlIGRtYWJ1Zg0KPiBpbnN0ZWFkLg0KDQpXaWxsIGdpdmUgaXQg
YSB0cnkNCg0KVGhhbmtzLA0KRmFiDQoNCg0KPiANCj4gLS0NCj4gUmVnYXJkcywNCj4gDQo+IExh
dXJlbnQgUGluY2hhcnQNCg==

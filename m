Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA9E3328194
	for <lists+linux-api@lfdr.de>; Mon,  1 Mar 2021 15:59:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236736AbhCAO7D (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 1 Mar 2021 09:59:03 -0500
Received: from mail-eopbgr1410092.outbound.protection.outlook.com ([40.107.141.92]:6073
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234651AbhCAO7A (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Mon, 1 Mar 2021 09:59:00 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oF7/0H72S0xIHX9Q1x3yGMHiCUMiD8iy9N0m1JexxvWCcqxPtbGsGoOMaRBQf98bQ1cZoTLmlvKU+kpxZZNuARxARzEy5q4nh6vrF8zpQkf0lngNsQ8a8sHtXof8YuZ+gH7hWRuwqx6UrdRhFjxtEpdOuFOjwblnQws8U7/P87mT7lUwGZYEZpmyn1S93VsbR25bUzbOeSyQd/b5gv8w9Bij5zPNWlxkqWGxh6UBFtjdVM0rBL862Ydg3uBPiSt4AW7YdeMylmu1zXHI8tGeDMqCWOIxFkeffEXzqod6DXdXnfKGJs/lVH4x57zYs/wkUSf/2YjzLWKdGyS/HLiRHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d3s8dbbwhUvksb2eccsUYViS4AeVY89nrEG91hFu66M=;
 b=loaSFq1d1Jd5BkkEJetfK601L3zTV4VCYezTMf7985TMJgd9QVmDA8LRYAREHsuN7vc+1mZltv53Kfm3bAsT0EAJpUWJbybH6jnWu1qLW7zWyW1oriSQkYhlJ2L5O+ewbAyV6L4xE29QnWXxnGTFD7H1EzsgmALmScnbqh/T382z/l/BBH071N+LIjfm665gEkNh4yWSyjYjbgYhDyB0AwwI2RPmLeX9BJFUxM5wBregYgMRhTOhlCV9L6x9JGVUW8dZhXyCptKwwNI2DiqqyK49JYicz0t0xThaWCTKb2AXIGaFlza9+kBMMNNJh9k2S+spXyRPh8x84hrIYJk1EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d3s8dbbwhUvksb2eccsUYViS4AeVY89nrEG91hFu66M=;
 b=dONtQnv+7T7BE/YvyOJKm1L0sx47E075w/e2HoVk7VCp18vm3RN7n/CyhOl4bZw39uYuMLqCcGf5rHg7KFUuD5U2hN/HYmS4BPkjn/mBD5BUglLDzkMes4+bKZYMxG+sPhg1GXV6D/fxcZeJRIbczFTphbyeVyh7Mc+dUNFvQds=
Received: from OSAPR01MB2737.jpnprd01.prod.outlook.com (2603:1096:603:38::21)
 by OS0PR01MB5779.jpnprd01.prod.outlook.com (2603:1096:604:bf::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Mon, 1 Mar
 2021 14:58:10 +0000
Received: from OSAPR01MB2737.jpnprd01.prod.outlook.com
 ([fe80::4d2d:3155:768e:50e0]) by OSAPR01MB2737.jpnprd01.prod.outlook.com
 ([fe80::4d2d:3155:768e:50e0%7]) with mapi id 15.20.3890.028; Mon, 1 Mar 2021
 14:58:10 +0000
From:   Fabrizio Castro <fabrizio.castro.jz@renesas.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Rob Herring <robh+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux API <linux-api@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        "REE dirk.behme@de.bosch.com" <dirk.behme@de.bosch.com>,
        Peter Erben <Peter.Erben@de.bosch.com>
Subject: RE: [PATCH 2/7] clk: renesas: r8a77965: Add DAB clock
Thread-Topic: [PATCH 2/7] clk: renesas: r8a77965: Add DAB clock
Thread-Index: AQHXC8j5EQG4xEwyhEGkm3G1ZaUM1KpqH9sAgAUebOA=
Date:   Mon, 1 Mar 2021 14:58:10 +0000
Message-ID: <OSAPR01MB27370EBB65BF8B90D2B543AAC29A9@OSAPR01MB2737.jpnprd01.prod.outlook.com>
References: <20210225225147.29920-1-fabrizio.castro.jz@renesas.com>
 <20210225225147.29920-3-fabrizio.castro.jz@renesas.com>
 <CAMuHMdXNBeVK0ze8HSA=t5TTfhyuRz=+yLHMBioUbsuBxUoWyA@mail.gmail.com>
In-Reply-To: <CAMuHMdXNBeVK0ze8HSA=t5TTfhyuRz=+yLHMBioUbsuBxUoWyA@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linux-m68k.org; dkim=none (message not signed)
 header.d=none;linux-m68k.org; dmarc=none action=none header.from=renesas.com;
x-originating-ip: [2.28.163.123]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 103fcbfe-061b-4b6b-90aa-08d8dcc26e8e
x-ms-traffictypediagnostic: OS0PR01MB5779:
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <OS0PR01MB5779293BF3829EB57485F492C29A9@OS0PR01MB5779.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ViZQkrRtZ/Ap9NBEJcfOQUuniwH7GPBNxXHFlg3xO+dSroI4ZGthiTohSa552+DPl0YncHSgioRctV3L2rDHmau01HBruaLUPPiOnbuooOtTPZ7cFTRYZijVNed1RNIBeaV39cAfd/AGT7P7KRmULN6Tq+10nZglFKklc01urNBI7npV/XnpMVq7NW0SkkgBn8UiwYRnCLsu61EiRjgQLt58fTURHZheWJIfUoco0mq/kBWsJRzNPgQBIjNfBqozXnE2cvU36GQVBKPD0YcAULL0FqhwAYKYWYTi1dH9oVoNFxVUB7U60a6oZ1q9Yhl9SY5VkilppwgGcXoY5/8Qw7Ve1EFZgn7i+vAdr4Wtyxn1YyvKQqpgTg0XCfnPP7yV7hypJaJxNsixeIDoP7H3OXBOxTdKUd7dF1w2/nbFwpasqZs+eYAnYhJWOWhWBp+0C9gmFw7CcMj0Ode4T1C+n8LbHK46YXtLan48Fl/D9V/Do1RzTSzTXx9gmfwyuqSAgjPHVNAxmPdx8jYYSo23ZA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSAPR01MB2737.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(376002)(39860400002)(346002)(366004)(7696005)(8676002)(7416002)(86362001)(55016002)(83380400001)(4326008)(478600001)(8936002)(186003)(26005)(52536014)(6916009)(9686003)(53546011)(54906003)(71200400001)(316002)(6506007)(5660300002)(76116006)(33656002)(66446008)(64756008)(66556008)(66476007)(2906002)(107886003)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?TWQ5QlE3Ung1YVQvOUw4dFVoZVFBaU1jSGZTK3RYVlY1MStvUmg3bndFUUJp?=
 =?utf-8?B?aXg4ZTFucktjQTQ3VFJwUDFVSitvUWdITmFGcjIrb1dwcS9aQ0pBM21jV1g0?=
 =?utf-8?B?d3JDQ2pseERnSTU4YmJ6SjVTS3V3SXNoTjM5MXRUYS9mdVBETWJqU3lPemdl?=
 =?utf-8?B?N1ZiV3hKdWE4L0U3RjI1N24wTG9tVHhMN2VxK0NSV0hnQTRZUGMreDlibkVX?=
 =?utf-8?B?K0lOZWo3aTF2YWMzYk5DbUVQc1I5dEsxeDZLTG1LOGxEWC9OckEzdmc5Sit2?=
 =?utf-8?B?T1ZjamNlbjlUekpDdE9iSU12QWVRZEg2NjRjejA0aEtUL0hCaUcrcW1YOUVT?=
 =?utf-8?B?YkZ4OGpYSWFKMy81MGgzWlRWU2dkTnJ6TTNRT3BVcitwUm5ad3I4WnpDa0c5?=
 =?utf-8?B?eGMySEkxWHZITTRrSE5lZ0t4WHRoWkNiTEtOeWljeS9DdE5TZjNvZXFJN28z?=
 =?utf-8?B?c016RnlHRXM5aGNEZmdyelhVSU1KbEVpb0NJWER2aEl1Y3ZBem5ZREJBZWRn?=
 =?utf-8?B?Sk9xRjR3RTlHMnNEQTc5QnM4d3N6V05lcFdkQkFwQTllais0OTUzYXNMVzhB?=
 =?utf-8?B?eGVMb3J3ZDBrdmlYR0F1N3l2WHJaS1pycXJLbGl3QlNtaU9yaEdRV2hRUEk4?=
 =?utf-8?B?Z253d0NYd3RKTFdSZTg0Mmc1UXluaU54dWVxZXh5anZUenhOMlFRelZtNHVL?=
 =?utf-8?B?NGQxbDg2ZXpuU2pMc3AwOThUU2lZalRMNDRhM0hDT1ZYWTFzQ1piL0ppRFp2?=
 =?utf-8?B?aTFkb1F5SDhlVTFXS2MrNGNpZDkydWh2R3BtYkxHTGIvMTBwdHY1c1pYZjBY?=
 =?utf-8?B?d0VHR1FSV2VIOUlvaUozL0QyTlhSMEdsTVhVWVVIQVZZbTM2bUpmbnhLU2JK?=
 =?utf-8?B?Q1dDVUh0UlFZRVRRZEhMZVZVVmU4b0lnVGVSMjVBb2FjbkpPam5GR0JDeXYw?=
 =?utf-8?B?UmwwQ0lTK0ovL1ZhZmZqeUgxUEZONmRNV2V6UmJmcEY5eHJXeTY3R0ZjWWdt?=
 =?utf-8?B?VmlZOVRrVGN5MWFPYTNvVnJOUXR1Y0ZOTUl2aFVuR3dLVVhiZnk0aWMyNW1V?=
 =?utf-8?B?MWxCRnJaWEk3dWE5eW5ZTU9XckdBUEVSL2J2eFF0aXl6aUk5L0RqQ21nK1BI?=
 =?utf-8?B?RXU3RElrcHBzd2hqR1JQRVlXUnlNOXVwMFN3UVNhc1dwVUNOYW9KYWNFMkxY?=
 =?utf-8?B?Mm9JQUdsNFc0YlBwNnMxTjZrQldhVTR5aTUrVlVhbkEyV082R2Mxdy9EV3B4?=
 =?utf-8?B?M2F3Ti9nZ3pMdExKSFVtekI3RUVvRjdXQ2tRNnFwWkxtanY4OEdLZGJ6Njlz?=
 =?utf-8?B?MnpyR3hFaVpGWE5zR0ZqZVo2TFE5dkZuSGVWTTN2M2owSnByTS85U2VyNzZi?=
 =?utf-8?B?cUtiUzNXdnprY096eW9lK1lxbGlDU1ZuWGNTWnZGbVlSa0RHRUJ3d0tqeito?=
 =?utf-8?B?bXgyaXhpRnlyN2U2ZWdhU1kyU0xWaFFLSERmRTRnNmt4Zmw2cVVDUEs0ZFVX?=
 =?utf-8?B?MXBHendxQzVFY3Y3V0ZoWUh2bWhkZmJ6OXNJUkFiL0w1MGVyTU5pK1JPYlR3?=
 =?utf-8?B?NGxDc2t4emxWYzl5QVFiTkFuRVFkZjNZRWlORVl0bnIxYSttNzdYTHBWY0tR?=
 =?utf-8?B?Mi9yc0wwTDNtSGRJdFl5TFM2ZUdEM2xuUS84b2p0NUhOazU4NkJVN0N1VUpx?=
 =?utf-8?B?b2Z1U2VDSTFoakQxcjJBNkVNeS9ieUUxdTV4cDB5MmNPTWFBK1RzcGl5Tm12?=
 =?utf-8?Q?LsiJsI8eOGQT6I70Nzjj1m8A84gCbgJKPn+E5/S?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSAPR01MB2737.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 103fcbfe-061b-4b6b-90aa-08d8dcc26e8e
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2021 14:58:10.7749
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z8QromI4HFmk4stFDsf9HTy3px1IpMfecaomksnYaX2WD/QDZQaBGOMYAeuf8JgJpavtfE8oExkW5A48t36xkP3sRRZbXWnd6HRdEtAbNFk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB5779
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

SGkgR2VlcnQsDQoNCg0KVGhhbmtzIGZvciB5b3VyIGZlZWRiYWNrIQ0KDQo+IEZyb206IEdlZXJ0
IFV5dHRlcmhvZXZlbiA8Z2VlcnRAbGludXgtbTY4ay5vcmc+DQo+IFNlbnQ6IDI2IEZlYnJ1YXJ5
IDIwMjEgMDg6NDUNCj4gU3ViamVjdDogUmU6IFtQQVRDSCAyLzddIGNsazogcmVuZXNhczogcjhh
Nzc5NjU6IEFkZCBEQUIgY2xvY2sNCj4gDQo+IEhpIEZhYnJpemlvLA0KPiANCj4gT24gVGh1LCBG
ZWIgMjUsIDIwMjEgYXQgMTE6NTMgUE0gRmFicml6aW8gQ2FzdHJvDQo+IDxmYWJyaXppby5jYXN0
cm8uanpAcmVuZXNhcy5jb20+IHdyb3RlOg0KPiA+IFRoaXMgcGF0Y2ggYWRkcyB0aGUgREFCIGNs
b2NrIHRvIHRoZSBSOEE3Nzk2NSBTb0MuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBGYWJyaXpp
byBDYXN0cm8gPGZhYnJpemlvLmNhc3Ryby5qekByZW5lc2FzLmNvbT4NCj4gDQo+IFRoYW5rcyBm
b3IgeW91ciBwYXRjaCENCj4gDQo+ID4gLS0tIGEvZHJpdmVycy9jbGsvcmVuZXNhcy9yOGE3Nzk2
NS1jcGctbXNzci5jDQo+ID4gKysrIGIvZHJpdmVycy9jbGsvcmVuZXNhcy9yOGE3Nzk2NS1jcGct
bXNzci5jDQo+ID4gQEAgLTI1MCw2ICsyNTAsNyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IG1zc3Jf
bW9kX2NsayByOGE3Nzk2NV9tb2RfY2xrc1tdDQo+IF9faW5pdGNvbnN0ID0gew0KPiA+ICAgICAg
ICAgREVGX01PRCgic3NpMiIsICAgICAgICAgICAgICAgICAxMDEzLCAgIE1PRF9DTEtfSUQoMTAw
NSkpLA0KPiA+ICAgICAgICAgREVGX01PRCgic3NpMSIsICAgICAgICAgICAgICAgICAxMDE0LCAg
IE1PRF9DTEtfSUQoMTAwNSkpLA0KPiA+ICAgICAgICAgREVGX01PRCgic3NpMCIsICAgICAgICAg
ICAgICAgICAxMDE1LCAgIE1PRF9DTEtfSUQoMTAwNSkpLA0KPiA+ICsgICAgICAgREVGX01PRCgi
ZGFiIiwgICAgICAgICAgICAgICAgICAxMDE2LCAgIFI4QTc3OTY1X0NMS19TMEQ2KSwNCj4gDQo+
IFVuZm9ydHVuYXRlbHkgdGhpcyBiaXQgaXMgbm90IGRvY3VtZW50ZWQgaW4gdGhlIFItQ2FyIEdl
bjMgSGFyZHdhcmUNCj4gVXNlcidzIE1hbnVhbCwgc28gSSBoYXZlIHRvIHRydXN0IHlvdSBvbiB0
aGlzLg0KPiANCj4gV2hpbGUgaXQncyBub3QgdW51c3VhbCB0aGF0IHRoZSBzYW1lIG1vZHVsZSBv
biBSLUNhciBFMyBhbmQgTTMtTg0KPiBoYXMgZGlmZmVyZW50IHBhcmVudCBjbG9ja3MsIGl0IGRv
ZXMgc3RyaWtlIG1lIGFzIG9kZCB0aGF0IFMwRDYgb24gTTMtTg0KPiBydW5zIGF0IDEzMyBNSHos
IHdoaWxlIFMzRDEgb24gRTMgcnVucyBhdCAyNjYgTUh6Lg0KPiBQcm9iYWJseSBpdCBkb2Vzbid0
IG1hdHRlciB0aGF0IG11Y2gsIGFzIHlvdXIgZHJpdmVyIGRvZXNuJ3QgY2FyZQ0KPiBhYm91dCB0
aGUgYWN0dWFsIGNsb2NrIHJhdGUuDQoNCkkgaGFkIHRoZSBzYW1lIGNvbmNlcm5zIGJ1dCB3ZSBo
YXZlIHJlY2VpdmVkIGNvbmZpcm1hdGlvbiBmb3IgdGhpcy4NCkhvcGVmdWxseSBhbiBvZmZpY2lh
bCBkb2N1bWVudCB3aWxsIGJlIHJlbGVhc2VkIHNvb24uDQoNClRoYW5rcywNCkZhYg0KDQo+IA0K
PiA+ICAgICAgICAgREVGX01PRCgic2N1LWFsbCIsICAgICAgICAgICAgICAxMDE3LCAgIFI4QTc3
OTY1X0NMS19TM0Q0KSwNCj4gPiAgICAgICAgIERFRl9NT0QoInNjdS1kdmMxIiwgICAgICAgICAg
ICAgMTAxOCwgICBNT0RfQ0xLX0lEKDEwMTcpKSwNCj4gPiAgICAgICAgIERFRl9NT0QoInNjdS1k
dmMwIiwgICAgICAgICAgICAgMTAxOSwgICBNT0RfQ0xLX0lEKDEwMTcpKSwNCj4gDQo+IEdye29l
dGplLGVldGluZ31zLA0KPiANCj4gICAgICAgICAgICAgICAgICAgICAgICAgR2VlcnQNCj4gDQo+
IA0KPiAtLQ0KPiBHZWVydCBVeXR0ZXJob2V2ZW4gLS0gVGhlcmUncyBsb3RzIG9mIExpbnV4IGJl
eW9uZCBpYTMyIC0tIGdlZXJ0QGxpbnV4LQ0KPiBtNjhrLm9yZw0KPiANCj4gSW4gcGVyc29uYWwg
Y29udmVyc2F0aW9ucyB3aXRoIHRlY2huaWNhbCBwZW9wbGUsIEkgY2FsbCBteXNlbGYgYSBoYWNr
ZXIuDQo+IEJ1dA0KPiB3aGVuIEknbSB0YWxraW5nIHRvIGpvdXJuYWxpc3RzIEkganVzdCBzYXkg
InByb2dyYW1tZXIiIG9yIHNvbWV0aGluZyBsaWtlDQo+IHRoYXQuDQo+ICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgLS0gTGludXMgVG9ydmFsZHMNCg==

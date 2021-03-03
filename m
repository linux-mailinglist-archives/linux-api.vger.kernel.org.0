Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D76BB32C668
	for <lists+linux-api@lfdr.de>; Thu,  4 Mar 2021 02:02:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355468AbhCDA2p (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 3 Mar 2021 19:28:45 -0500
Received: from mail-eopbgr1410094.outbound.protection.outlook.com ([40.107.141.94]:37716
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1843020AbhCCKYV (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 3 Mar 2021 05:24:21 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jez1owRVBI2WZN3di8JN4cBBxX3i6o8CU2Eqxn4LqejgFjO/LgeD/BofahbTECYcS+YIL1oKXgaeDjc+v4WzxYKTKCXtQB7zJLF5JXNNEwz4c23TL/BaOR1ySOwDhyL67W8ySiQuQw0JaBsnzUpDv/JkzoS5Whg0Hd8LpqOAij8ZzlYHpObWCsehNBUyDmUAK8m5Ydja+aKN8xzNWduUTrCa3T12igybNoId9OYF4bcK0/FfBi6tr81WfB1mFjS97U4OmjZZIFzwjoUivfQe7f1asrP5nBCF92+MEvygrCuMLT39Bj7mQ9FOgEhn4PgeQK3eh9I8ClqVG39w1DfVFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TrMpNFwTsZYKql/Y2/JGXVW6wsfNY3SNN5OY7POcdVY=;
 b=YYq/ddA/6Y3/enjaPESVhbQwvqnHv0CaJY528gDUfK6liidNg6OP3eOb1SFFLDZ8Ect5cNmTZSWLwn2nzuAaGqQcAgOPuMjnXQZPvTHx61lQHi1hSrG5IvvQL065IoRLvtykls9XDQqRjca6Rqq6xtWl1L+9pK9Sd61rBUKC5AH+23DAR+czzqMoiRH/plSTW3qClzULQAcELSe+mCBQXV1fCd6JXfcH/YFkw3WkCKS0WMtEYWpOIrngczrT1hzM3ZwyibgLgC51y/eU/tgYw/xdvPYG4bvrfRlckL9UKMXBdBmoe4t8euTwETIauLf/nFx7NSasni7Nt9PJDd/IOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TrMpNFwTsZYKql/Y2/JGXVW6wsfNY3SNN5OY7POcdVY=;
 b=Qa+WwqIFm/JpW+pvW0aojj9nc290V7mVE6teCqxBCQwVlWpEMjbiIHISN/rXWDRmQz9UFHsXPYq6CgOslzZ1ta24xW2hgVnBLVThJGMhBcTQTABYdbqxtGMJW1EBoDL8ERc3WWjnSfCPgqi3se2AK7ZxoJt+C2W64TUi4hrI7I0=
Received: from OSAPR01MB2737.jpnprd01.prod.outlook.com (2603:1096:603:38::21)
 by OSAPR01MB3154.jpnprd01.prod.outlook.com (2603:1096:603:3f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Wed, 3 Mar
 2021 10:23:31 +0000
Received: from OSAPR01MB2737.jpnprd01.prod.outlook.com
 ([fe80::4d2d:3155:768e:50e0]) by OSAPR01MB2737.jpnprd01.prod.outlook.com
 ([fe80::4d2d:3155:768e:50e0%7]) with mapi id 15.20.3890.030; Wed, 3 Mar 2021
 10:23:31 +0000
From:   Fabrizio Castro <fabrizio.castro.jz@renesas.com>
To:     Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Rob Herring <robh+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
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
Thread-Index: AQHXC8j5EQG4xEwyhEGkm3G1ZaUM1KpqH9sAgABEB4CABNsssIAC16RA
Date:   Wed, 3 Mar 2021 10:23:31 +0000
Message-ID: <OSAPR01MB273765F50637DEC38F3A7C3CC2989@OSAPR01MB2737.jpnprd01.prod.outlook.com>
References: <20210225225147.29920-1-fabrizio.castro.jz@renesas.com>
 <20210225225147.29920-3-fabrizio.castro.jz@renesas.com>
 <CAMuHMdXNBeVK0ze8HSA=t5TTfhyuRz=+yLHMBioUbsuBxUoWyA@mail.gmail.com>
 <YDjuMRkU+g52I1gm@pendragon.ideasonboard.com>
 <OSAPR01MB2737B48A9C32BE7162BB701AC29A9@OSAPR01MB2737.jpnprd01.prod.outlook.com>
In-Reply-To: <OSAPR01MB2737B48A9C32BE7162BB701AC29A9@OSAPR01MB2737.jpnprd01.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: renesas.com; dkim=none (message not signed)
 header.d=none;renesas.com; dmarc=none action=none header.from=renesas.com;
x-originating-ip: [2.28.163.123]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3ec5ab3d-67d6-4b40-2ab6-08d8de2e6507
x-ms-traffictypediagnostic: OSAPR01MB3154:
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <OSAPR01MB31542537D0E7E00F75BD05C6C2989@OSAPR01MB3154.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RAwCAOyiOn2OaM0F4BU7kNDd08djLoW8ENpEnl/q8KQGhdLLOACgrWkhhwrl0wvb5OtVqlGMtZ0WfMF4x/UnF7zY4ABilOf6tLbRlxTCZGHCb2Lokqy8Q6RbUEC7Pd6bb+bKqqvyM0XXX4GLJoWlCErK0PNKgpK8pFAbl2d4HBSketuy/aMhtbhmj+6YObdVbmoujzBYy/3PxBKJURkO+U/Sh0ON9ScVzDHv7k9ZQp3JVfWrtBhuJu8+KDdaj+SYwYNgPO7sw4fJ1dIF2kaKfmFGLxpVOA2P50JZqnYz2eb0mdws53sxefSuYloGGqBMDUj9ViRulbUIxgvknVDt21y3H8Jxja/LEYpAt19Q4esnsDTTKsy5MZ5zTq0FyGJ03B/R0dkEOanbe2WO/8IVYyXn8Pb/kcLI59OmQqdPNjr3Mw8Ab+MGeKf5E+HxKFLNY0zZNEHPzt7JfZggkiLA+OZjXff2E5TP8U1OnYXb6/Lp0Bh8xXJ5DGm7FCJ/TAWnldxZ3Ra/DP0M3Waqqjimxg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSAPR01MB2737.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(396003)(39860400002)(376002)(346002)(6506007)(5660300002)(55016002)(2906002)(53546011)(107886003)(52536014)(33656002)(9686003)(7416002)(76116006)(186003)(7696005)(83380400001)(478600001)(66946007)(26005)(66446008)(64756008)(71200400001)(8676002)(316002)(54906003)(86362001)(66556008)(4326008)(66476007)(110136005)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?TlFnSHQ4NFZISmpmcFJWc1FKVmdnZjJvamI4d0tGcW9wY2U1UWVUM1lWRFBn?=
 =?utf-8?B?Q29iazNDRzliclpwODRxVEMvVkhnSWg2aUdreUl6OFBRUVNxZlVpdmRRQUlY?=
 =?utf-8?B?N2lCSmw3bzd3QWRvbWt2YWl5WW5xSkYzQlhyTXJQMDZJR2tEd2xMaGJ0Mnp1?=
 =?utf-8?B?Ym1PeWpUWFFIQURtNW1qZ0tDSlFzNzNsRGU0VGFhRzhYSU9MNnd0cnVPeXlI?=
 =?utf-8?B?QW1DMm4zOVFWb01HQVJ5MHV6ODV4aTh4cFo2NFpXZG95cm9pODV3dmJnYkI4?=
 =?utf-8?B?MnlHSytXR2NFQ2puNVpoNkx3d1hFSkRITG91b1dHR0N0VUoyRkpZWWlJY1gx?=
 =?utf-8?B?ZDFWSlZ5c1ducTZkQmNKVzFnV2ZFYUJDTUY5SGtKUzVuelNuTkxNWkhiRmNr?=
 =?utf-8?B?alA0bHRXZjh3eEtGRjBDNVRnSXNycUd5VnQ5QkUxQm94NFdlR3J1eE9qeUhZ?=
 =?utf-8?B?VWliTDlDV3FNVnJMTC9CczZ6ZHcrSFgxMVR0ZXlVNUhOUGY5d3BxaUk2Nnhy?=
 =?utf-8?B?a1FKT1oyejBBVUNpVWt0ekZVTTBlSHdpRmoyZ3htU3gwWUQ3aXE4WER6c1pV?=
 =?utf-8?B?TkdUQ1ZKbU8rdkV1YkdQcXJvVTN2MGkyVDdXdyt5OENZTzFqZmdiU3dhZXls?=
 =?utf-8?B?SFg3ckd6YWFmV0ZTSHBVejFCTnJDcEVMaDZhNzA1MTA2akNsL0IweFpsbzFR?=
 =?utf-8?B?aFM4VXVBV05tSTIyNGdFNU5Pc2o5aU8yVWxrLy83KzN4NTZxRGxISDVZclYy?=
 =?utf-8?B?YU0yNy90MDZJYnErcGt6Q2ljZisxWTkySkwydFVpbXB1TlUyaUdDZUxCOFYy?=
 =?utf-8?B?RlNBNnRiYmVPRW5HN3FheTBiWjN4a1FGT3FUM2F1VkliVFFOTTRKY0E4WlNU?=
 =?utf-8?B?ajBZeCtOdHJSYVJrdVJTZFhjamVzdzByYy93N3M2clJoMWF0U2xZM3kwSDg4?=
 =?utf-8?B?VEZOUVZRRzFPSURWNmFMV1pQRW5wZXRKVHBFVTFQS1VaUWI2L2VWc0FXb0Uw?=
 =?utf-8?B?WFg4RUJkU0o2UHZVcmJGK2RBZG5LbkgyOGtqYVRTK1UzMXNDUUxONDZjZW9a?=
 =?utf-8?B?K01zdzlxbUFRajhqdHptWEZJc1RMQWZkMWRjMm4rV2l5YnJycEplSnA4L3hq?=
 =?utf-8?B?eDVDYWVzeDZmMGlEUXdCcmt0dnV1MHJHYVpHUlhnVjl6SnE3UE44VEVTQW51?=
 =?utf-8?B?TkpRdWtBSFdzYjlLb0o0WkF5bldERDhTQWdDczN2S0l1Uzd4VlprMzF1VFhB?=
 =?utf-8?B?cVlCcmFYb0JzcGJacElTMHJESXltY3JTNENSempPbmxIQ25DUnFYNGtEcFh1?=
 =?utf-8?B?bVJLYUwvVlV0eDlTRUNyZmVlc1FKM0N5RmQwemtZNVBkbERiTXJMWFNxUkI2?=
 =?utf-8?B?aFN3TGcwQ1IxNklzaWJVNlExdzNNcHVrU0gvZERoZW5tVkI2aTJVaGZnWWtY?=
 =?utf-8?B?RUgwQWtXMWN0d2o2b2RaT21oUklVd0pnNGZoNkliYnZtdXFVVk5ENUhEdUNR?=
 =?utf-8?B?RlVVVWt6TW5JS1dPTXhrZGo5N3V5cmR1dnlvSmFXdWg1RGlzSFFqSFFrTHpF?=
 =?utf-8?B?TzdwSHlyZWJ3MG1tWkVOWGxhZXUwazdvUkFSb3JITmhZS3ZLNkxKOFhkYTl0?=
 =?utf-8?B?SS93T1dudklkQXhOcG1WeWZDbTVZUUNvTlZPUTFZeWVta3JzaGYrYndYSzUr?=
 =?utf-8?B?YjZGUWRpMzROSXpVT05wUmRwQnpybXFpMXNKSW40U3A1Y3lHYWREL2dpUW9U?=
 =?utf-8?Q?9v9gWNpzMsqPwEgb18=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSAPR01MB2737.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ec5ab3d-67d6-4b40-2ab6-08d8de2e6507
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2021 10:23:31.6506
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qLU95ikGJnwqahSySXiDrVr+HY8MjPCYyKjDbD33XWvRZy3y3MwuETYhFz6fZ5SOfz81Y9NZVaT9c81sBvNazLRBJKpzFYXmjgtNMFW4psc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB3154
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

SGkgR2VlcnQsDQoNCj4gRnJvbTogRmFicml6aW8gQ2FzdHJvIDxmYWJyaXppby5jYXN0cm8uanpA
cmVuZXNhcy5jb20+DQo+IFNlbnQ6IDAxIE1hcmNoIDIwMjEgMTU6MDENCj4gU3ViamVjdDogUkU6
IFtQQVRDSCAyLzddIGNsazogcmVuZXNhczogcjhhNzc5NjU6IEFkZCBEQUIgY2xvY2sNCj4gDQo+
IEhpIExhdXJlbnQsDQo+IA0KPiBUaGFua3MgZm9yIHlvdXIgZmVlZGJhY2shDQo+IA0KPiA+IEZy
b206IExhdXJlbnQgUGluY2hhcnQgPGxhdXJlbnQucGluY2hhcnRAaWRlYXNvbmJvYXJkLmNvbT4N
Cj4gPiBTZW50OiAyNiBGZWJydWFyeSAyMDIxIDEyOjQ5DQo+ID4gU3ViamVjdDogUmU6IFtQQVRD
SCAyLzddIGNsazogcmVuZXNhczogcjhhNzc5NjU6IEFkZCBEQUIgY2xvY2sNCj4gPg0KPiA+IEhp
IEZhYnJpemlvLA0KPiA+DQo+ID4gVGhhbmsgeW91IGZvciB0aGUgcGF0Y2guDQo+ID4NCj4gPiBP
biBGcmksIEZlYiAyNiwgMjAyMSBhdCAwOTo0NToyMEFNICswMTAwLCBHZWVydCBVeXR0ZXJob2V2
ZW4gd3JvdGU6DQo+ID4gPiBPbiBUaHUsIEZlYiAyNSwgMjAyMSBhdCAxMTo1MyBQTSBGYWJyaXpp
byBDYXN0cm8gd3JvdGU6DQo+ID4gPiA+IFRoaXMgcGF0Y2ggYWRkcyB0aGUgREFCIGNsb2NrIHRv
IHRoZSBSOEE3Nzk2NSBTb0MuDQo+ID4gPiA+DQo+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IEZhYnJp
emlvIENhc3RybyA8ZmFicml6aW8uY2FzdHJvLmp6QHJlbmVzYXMuY29tPg0KPiA+ID4NCj4gPiA+
IFRoYW5rcyBmb3IgeW91ciBwYXRjaCENCj4gPiA+DQo+ID4gPiA+IC0tLSBhL2RyaXZlcnMvY2xr
L3JlbmVzYXMvcjhhNzc5NjUtY3BnLW1zc3IuYw0KPiA+ID4gPiArKysgYi9kcml2ZXJzL2Nsay9y
ZW5lc2FzL3I4YTc3OTY1LWNwZy1tc3NyLmMNCj4gPiA+ID4gQEAgLTI1MCw2ICsyNTAsNyBAQCBz
dGF0aWMgY29uc3Qgc3RydWN0IG1zc3JfbW9kX2Nsaw0KPiA+IHI4YTc3OTY1X21vZF9jbGtzW10g
X19pbml0Y29uc3QgPSB7DQo+ID4gPiA+ICAgICAgICAgREVGX01PRCgic3NpMiIsICAgICAgICAg
ICAgICAgICAxMDEzLCAgIE1PRF9DTEtfSUQoMTAwNSkpLA0KPiA+ID4gPiAgICAgICAgIERFRl9N
T0QoInNzaTEiLCAgICAgICAgICAgICAgICAgMTAxNCwgICBNT0RfQ0xLX0lEKDEwMDUpKSwNCj4g
PiA+ID4gICAgICAgICBERUZfTU9EKCJzc2kwIiwgICAgICAgICAgICAgICAgIDEwMTUsICAgTU9E
X0NMS19JRCgxMDA1KSksDQo+ID4gPiA+ICsgICAgICAgREVGX01PRCgiZGFiIiwgICAgICAgICAg
ICAgICAgICAxMDE2LCAgIFI4QTc3OTY1X0NMS19TMEQ2KSwNCj4gPiA+DQo+ID4gPiBVbmZvcnR1
bmF0ZWx5IHRoaXMgYml0IGlzIG5vdCBkb2N1bWVudGVkIGluIHRoZSBSLUNhciBHZW4zIEhhcmR3
YXJlDQo+ID4gPiBVc2VyJ3MgTWFudWFsLCBzbyBJIGhhdmUgdG8gdHJ1c3QgeW91IG9uIHRoaXMu
DQo+ID4gPg0KPiA+ID4gV2hpbGUgaXQncyBub3QgdW51c3VhbCB0aGF0IHRoZSBzYW1lIG1vZHVs
ZSBvbiBSLUNhciBFMyBhbmQgTTMtTg0KPiA+ID4gaGFzIGRpZmZlcmVudCBwYXJlbnQgY2xvY2tz
LCBpdCBkb2VzIHN0cmlrZSBtZSBhcyBvZGQgdGhhdCBTMEQ2IG9uIE0zLQ0KPiBODQo+ID4gPiBy
dW5zIGF0IDEzMyBNSHosIHdoaWxlIFMzRDEgb24gRTMgcnVucyBhdCAyNjYgTUh6Lg0KPiA+ID4g
UHJvYmFibHkgaXQgZG9lc24ndCBtYXR0ZXIgdGhhdCBtdWNoLCBhcyB5b3VyIGRyaXZlciBkb2Vz
bid0IGNhcmUNCj4gPiA+IGFib3V0IHRoZSBhY3R1YWwgY2xvY2sgcmF0ZS4NCj4gPg0KPiA+IEkg
aGF2ZSB0aGUgZXhhY3Qgc2FtZSBjb25jZXJucywgaGVyZSBhbmQgZm9yIDEvNy4NCj4gDQo+IEkg
aGVhciB5b3UsIGJ1dCB5b3Uga25vdyBob3cgdGhlc2Ugc29ydCBvZiB0aGluZ3MgZ28sIGEgYml0
IHdhcyBsZWZ0DQo+IGJlaGluZCwgbm93IHRoZXkgYXJlIGF3YXJlIG9mIHRoaXMgYml0IG1pc3Np
bmcgZnJvbSB0aGUgZG9jdW1lbnRhdGlvbg0KPiBhbmQgYXQgc29tZSBwb2ludCB0aGV5IHdpbGwg
cmVsZWFzZSBhIGRvY3VtZW50IGFkZHJlc3NpbmcgdGhpcyBwYXJ0aWN1bGFyDQo+IHBvaW50LiBN
ZWFud2hpbGUsIHdlIGhhdmUgcmVjZWl2ZWQgd3JpdHRlbiBjb25maXJtYXRpb24gZm9yIHRoaXMs
IHNvDQo+IGl0IHNob3VsZCBiZSBva2F5Lg0KDQpJIHRoaW5rIHRoaXMgcGF0Y2ggaXMgd29ydGgg
dGFraW5nLg0KDQpUaGFua3MsDQpGYWINCg0KDQo+IA0KPiBUaGFua3MsDQo+IEZhYg0KPiANCj4g
Pg0KPiA+ID4gPiAgICAgICAgIERFRl9NT0QoInNjdS1hbGwiLCAgICAgICAgICAgICAgMTAxNywg
ICBSOEE3Nzk2NV9DTEtfUzNENCksDQo+ID4gPiA+ICAgICAgICAgREVGX01PRCgic2N1LWR2YzEi
LCAgICAgICAgICAgICAxMDE4LCAgIE1PRF9DTEtfSUQoMTAxNykpLA0KPiA+ID4gPiAgICAgICAg
IERFRl9NT0QoInNjdS1kdmMwIiwgICAgICAgICAgICAgMTAxOSwgICBNT0RfQ0xLX0lEKDEwMTcp
KSwNCj4gPg0KPiA+IC0tDQo+ID4gUmVnYXJkcywNCj4gPg0KPiA+IExhdXJlbnQgUGluY2hhcnQN
Cg==

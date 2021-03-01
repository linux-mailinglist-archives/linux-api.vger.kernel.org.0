Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 222D6328159
	for <lists+linux-api@lfdr.de>; Mon,  1 Mar 2021 15:51:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236597AbhCAOv0 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 1 Mar 2021 09:51:26 -0500
Received: from mail-eopbgr1400090.outbound.protection.outlook.com ([40.107.140.90]:14834
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233245AbhCAOvX (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Mon, 1 Mar 2021 09:51:23 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zl7WTvz+bOQ7VTZ0exGYe4dfpejWfiRGGy+qmyx/MgvSXMRYZp7GdY63MAnrDLqCrPkCddxQKln5r7j+cV/9JGo7FdsZhKRJ2NEIH/BTg6N2WL6n/AhNP2/bhUrV643+qwuQY0/TS5cHFDgdw9CjhtGZv2ogGQpYaLTA0XEO2tv3IzE10A3PTd6RT8wEpJ4qaNzGdF3lil89ezONnHRKQdH0/YQc3zcI9IDSZ0XAcivnY+X9Q2kgLQjIcklruPBR93RpZd4xfH2fkgk+nYsUSfTfokL+V7vyXBsxabMARii8aQZYMsaGZaVzjwaPgqVZQ5YN4ZoMMXzZc8aVGiCOnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pnDFGEHYyT8P1pM7PxyfMMT7WmOCeFH64N3dsw/LLI0=;
 b=aM1cgf1MxsYffw6/wcJe4SFYIKmRtWh1CAKCeJrYX5w0uQiNPXYqxnZDyNvtLCJs15SrS0rlXw+aRurcFy2bdjiDrYzzNQ248BW4dILecN9AcqykVjA0WUTKuhjHAVAFUWHUDc7nuTv0sANHrT/d8o5NQdRcsOji5iEBDcSdIHeElPj1B9q6753zVd6/K33Bxnb7p6BfPGFSW041V8uw3nupO/qNb0HoA4oLc777hE78f75uWERjIwdd4RXR0OTLQgA6/4zIF8t6tAGPmqjSaLXxRE5vlaSqvtj8cVWEfJjForHKJEYFRHczLP6yRqKs/MsBz4FSJLSmptI13hR8vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pnDFGEHYyT8P1pM7PxyfMMT7WmOCeFH64N3dsw/LLI0=;
 b=ONdnrepGxh+Ieg6MDh2G3BhyMLzxp+OlGFx3UfSdRbLz/Tjyg8D1VkoKQiRg4WVnzihAgHtrYuzwfhtqgJgipLjcZk2oAaWwKdBWzfMZ6JtalOrIwsbpcu1LZ6D58SGd80chDZrIHcQfKyjSpG13sOOxpHJ7ZJyJPG84inuSF7o=
Received: from OSAPR01MB2737.jpnprd01.prod.outlook.com (2603:1096:603:38::21)
 by OSBPR01MB4600.jpnprd01.prod.outlook.com (2603:1096:604:7e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.23; Mon, 1 Mar
 2021 14:50:32 +0000
Received: from OSAPR01MB2737.jpnprd01.prod.outlook.com
 ([fe80::4d2d:3155:768e:50e0]) by OSAPR01MB2737.jpnprd01.prod.outlook.com
 ([fe80::4d2d:3155:768e:50e0%7]) with mapi id 15.20.3890.028; Mon, 1 Mar 2021
 14:50:32 +0000
From:   Fabrizio Castro <fabrizio.castro.jz@renesas.com>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
CC:     Rob Herring <robh+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        "REE dirk.behme@de.bosch.com" <dirk.behme@de.bosch.com>,
        Peter Erben <Peter.Erben@de.bosch.com>
Subject: RE: [PATCH 0/7] Add FFT Support for R-Car Gen3 devices
Thread-Topic: [PATCH 0/7] Add FFT Support for R-Car Gen3 devices
Thread-Index: AQHXC8jtZRf9eazPyUyQ9uR0bT8rzqpqXA4AgATf7cA=
Date:   Mon, 1 Mar 2021 14:50:32 +0000
Message-ID: <OSAPR01MB2737459B1C15430613E84CACC29A9@OSAPR01MB2737.jpnprd01.prod.outlook.com>
References: <20210225225147.29920-1-fabrizio.castro.jz@renesas.com>
 <YDjnoGDOCXm86ffW@pendragon.ideasonboard.com>
In-Reply-To: <YDjnoGDOCXm86ffW@pendragon.ideasonboard.com>
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
x-ms-office365-filtering-correlation-id: 24cbaf76-fddc-40d6-d0db-08d8dcc15d44
x-ms-traffictypediagnostic: OSBPR01MB4600:
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <OSBPR01MB4600C88EB4668726F2A61E65C29A9@OSBPR01MB4600.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HUZoRdcAl950uTwzt94s+WT+aOK4F8+YGugSe1wtLTw7L6tDl6erV8HPHrDslOhOFFPryz4hUy9cVDLxtvlNqt5FIqSmIEfZGHd+fQGaud+K7z2GzaW37akH9tSPhrDrTDL4DHHjKC/fqTThJLbCpTdJhXQrUINZyWGfBIBgOowqaMlzTGGKqVxvSkN19mORyFtK/4/RSpoPzfmkEykcBMn5bGSAGfCf9IWdxC2306cu4Vk+V9hHuMqz9BBDkUd3o1TQZnktGVikTvpQZAShQt8v0XJ6yyLA/6GO5eA8JLN4knWr0iBpmnVXEa5GV5M0m78a0uZWBC5PqTTmpENrfpRUCwBrxXYfQaHYeLkqkgeVk3lKdtyZHcvemqe677AFU1znZho89ZskDCBXvBdbyG4/p9Vj2XMC8IUpmuM/MoQw9x/MGp9HyjTekFXnyd912UFzzPsM/Q8OMuiLCTjfzFtCAbcNBv2O5oN1Bea5xUYGRM3In8v8suVzIXzJ18i2GC4iDPRB56gZESLGF4dmRA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSAPR01MB2737.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(136003)(396003)(39860400002)(366004)(83380400001)(55016002)(8676002)(86362001)(7416002)(66446008)(9686003)(6916009)(52536014)(478600001)(33656002)(316002)(66476007)(26005)(107886003)(66946007)(8936002)(5660300002)(2906002)(7696005)(64756008)(54906003)(186003)(53546011)(6506007)(76116006)(71200400001)(4326008)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?NS9mMlN0QWRuaWNDUEJ3VGFmeWlGczBHZjArUWNyWExsMFNFOFk3MUZWSmdL?=
 =?utf-8?B?a3ErSFd1NVovMnRtQTB6dTVXM1BGdW8zUXorL3p1cnpub052N2VZRUsrSkJX?=
 =?utf-8?B?V2xwY0ttTHdsZEMxUVA2ZDMybWY4eEVlenEwWGRxaE9wcUtKTlBTWjFNQ0Zo?=
 =?utf-8?B?a3BPbG9JdDVhM2dXZG14cGs1bm05RW4wZTgza0dkZHpOQkcwL1NXTEN4K0Y3?=
 =?utf-8?B?R2Q4ckt2cVRzRmdtOEV5c01kdVM5Z0FpSDQrUDNSK1lRK01QZ1VpRGl6MXR2?=
 =?utf-8?B?UGlWZ2hQVFRUWi9NWFVtaWhhc0hZZzE4OEY4N1BsY3Z3RjRMcm9rb3d6U29I?=
 =?utf-8?B?MWtWU3FDdGNPaldsYjArK296aFErZnV6VzRRR0dUdkNua2JwcFVvazl0cXdE?=
 =?utf-8?B?dXRiOFJEYTVrQ3A1a1FVeHIrUEZzZDFmektORWpPckc1ck9CRE1XREltMHl3?=
 =?utf-8?B?c2d1SHF6TURxWlM4TWJKb2dTMlNkalFDejZrV3R6RlF0RGVBWi9paVFkNXBJ?=
 =?utf-8?B?bU5KVzh3TGtxRjVSVk5Ya2NnSU5lc0VIUDZ5U3ZwM0l1ZlBYY3dLR0NnOEFk?=
 =?utf-8?B?V21IQjNmbldDd1dJQkZnRkxleEZlSTRkQk9PWlQwU084UWhoYk12TER3Z0pN?=
 =?utf-8?B?b0RXazFaNk16a1RGTzFSRHo0WDBzS2czVlBySjNzT2Z6S1ZEWS9vWWxyQjZZ?=
 =?utf-8?B?dmxOZzZkYkZKVHl6Q284RFVIeHVheVpmc0RHRzFrUm9QVGhWQnpGVzRNSE9W?=
 =?utf-8?B?K252UW0vVHNVSWwxWlRpdUQ5bEpPTGpSUXNSU2hnLzhCS0tVeDJvZW8xbTVR?=
 =?utf-8?B?WjAvSnE1WllGcDFobVBES1RSQmlxd09FazBWclRjR01TeVhreSt3ZzRYdkdq?=
 =?utf-8?B?WkRsbm14OHM0alZNcDJxY3pSdFJlQi96TVg5THMwNVo2TTRjME1jc250WVRM?=
 =?utf-8?B?NzU5ckVEUFZsa0pMczAyNFMwbjZlQkRYVU9KdlFHWjdhU0VhSm1RS1lScWo3?=
 =?utf-8?B?SVRlMWRSalptRTYwM0hNcnY1UGpNZ2NKZzQwM1FLcEVwOHN2U2JUQmlXZXBj?=
 =?utf-8?B?RDF3c2Uyb3hWQzhDLzNuaWFybkJKWlA5L3hlVUpIUlhuL1JXK2NmVXBXb212?=
 =?utf-8?B?akc1ZEE2S3R6L09uemVPb3VCRTJHRXZGbjB6Q3I2TWMzZnF6c2VHbUdHemUy?=
 =?utf-8?B?NmV1YmdyQzdBY2xQUkpkaUZYNjlZK2RacVJFTVIyRWNWY0xYcTBQdlI4UXRV?=
 =?utf-8?B?VklOZVYzaTlZbkl1aTVCRXlkRFIvUnZsOER3VUdGVVdzeGEvbFRnUWp3WWhO?=
 =?utf-8?B?VStPMkl6ZFEwTTBOenV0WGtSbGJFZVJLT1RlSjFmTVZZSnZXaTlDdjZQK3lC?=
 =?utf-8?B?Z1pKSHhuK3VGQTB3dkJTTW5GWFlyVElMSUNGWDZXNnVLUVVYdGltZGM0ZlJF?=
 =?utf-8?B?eGlrTlpHdnpkMnRnTE42c0Q4T1hMVmxYWHlUbDU0N242ZHlkL1hFMVdYNHBT?=
 =?utf-8?B?QVdCMStkbVhBbnpzak5hMUxtYkFhVUJHRmxLVVd1UTl4ZjIyMUgyVUdVZC9h?=
 =?utf-8?B?ZHBQdVJ6UmxaVHJncjZ4SnEwUFVlcFVKQytrYzB0am9FYWpPZVNBaU9YUUtJ?=
 =?utf-8?B?Slltd0NWVG5PVy90Q1VjeG1raExZVVpCT3RXd0ZqUEVNd1lwQWowNmdHS3Nq?=
 =?utf-8?B?c2NkZ1Z6Z0RqWi94UWtVTndwM1JEK2hRUTJxR3MxeHNNVlVWSkYvNjhuOUo4?=
 =?utf-8?Q?tCH7S93cRbyvo3CKJ8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSAPR01MB2737.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24cbaf76-fddc-40d6-d0db-08d8dcc15d44
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2021 14:50:32.3105
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kG9T7WpxdFuKtzE4nHjDwAHfsmkUOrLY+LYNyXtrm2+UAlOOLoSWZlNJCMZIp8lGfDK3onpgBJ6Vb6BMn4sIpCndKrkoGVxThb5vuodQIJQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB4600
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

SGkgTGF1cmVudCwNCg0KVGhhbmsgeW91IGZvciB5b3VyIGZlZWRiYWNrIQ0KDQo+IEZyb206IExh
dXJlbnQgUGluY2hhcnQgPGxhdXJlbnQucGluY2hhcnRAaWRlYXNvbmJvYXJkLmNvbT4NCj4gU2Vu
dDogMjYgRmVicnVhcnkgMjAyMSAxMjoyMQ0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDAvN10gQWRk
IEZGVCBTdXBwb3J0IGZvciBSLUNhciBHZW4zIGRldmljZXMNCj4gDQo+IEhpIEZhYnJpemlvLA0K
PiANCj4gT24gVGh1LCBGZWIgMjUsIDIwMjEgYXQgMTA6NTE6NDBQTSArMDAwMCwgRmFicml6aW8g
Q2FzdHJvIHdyb3RlOg0KPiA+IFRoZSBEQUIgaGFyZHdhcmUgYWNjZWxlcmF0b3IgZm91bmQgb24g
Ui1DYXIgRTMgKGEuay5hLiByOGE3Nzk5MCkNCj4gPiBhbmQgUi1DYXIgTTMtTiAoYS5rLmEuIHI4
YTc3OTY1KSBkZXZpY2VzIGlzIGEgaGFyZHdhcmUgYWNjZWxlcmF0b3INCj4gPiBmb3Igc29mdHdh
cmUgREFCIGRlbW9kdWxhdG9ycy4NCj4gPiBJdCBjb25zaXN0cyBvZiBvbmUgRkZUIChGYXN0IEZv
dXJpZXIgVHJhbnNmb3JtKSBtb2R1bGUgYW5kIG9uZQ0KPiA+IGRlY29kZXIgbW9kdWxlLCBjb21w
YXRpYmxlIHdpdGggREFCIHNwZWNpZmljYXRpb24gKEVUU0kgRU4gMzAwIDQwMQ0KPiA+IGFuZCBF
VFNJIFRTIDEwMiA1NjMpLg0KPiA+IFRoZSBkZWNvZGVyIG1vZHVsZSBjYW4gcGVyZm9ybSBGSUMg
ZGVjb2RpbmcgYW5kIE1TQyBkZWNvZGluZw0KPiA+IHByb2Nlc3NpbmcgZnJvbSBkZS1wdW5jdHVy
ZSB0byBmaW5hbCBkZWNvZGVkIHJlc3VsdC4NCj4gPg0KPiA+IFRoaXMgc2VyaWVzIGFkZHMgRkZU
IHN1cHBvcnQgb25seSBmb3IgUi1DYXIgRTMgYW5kIFItQ2FyIE0zLU4sDQo+ID4gRklDIGFuZCBN
U0Mgc3VwcG9ydCB3aWxsIGJlIGFkZGVkIGxhdGVyIG9uLg0KPiANCj4gT3V0IG9mIGN1cmlvc2l0
eSwgY291bGQgdGhlIEZGVCBtb2R1bGUgYmUgdXNlZCBhcyBhbiBhY2NlbGVyYXRvciBmb3IgMkQN
Cj4gRkZUIG9uIGltYWdlcyA/DQoNCkkgaGF2ZW4ndCB0cmllZCB1c2luZyBpdCB0aGF0IHdheSBi
dXQgSSBkb24ndCB0aGluayBzby4NCg0KVGhhbmtzLA0KRmFiIA0KDQo+IA0KPiA+IEZhYnJpemlv
IENhc3RybyAoNyk6DQo+ID4gICBjbGs6IHJlbmVzYXM6IHI4YTc3OTkwOiBBZGQgREFCIGNsb2Nr
DQo+ID4gICBjbGs6IHJlbmVzYXM6IHI4YTc3OTY1OiBBZGQgREFCIGNsb2NrDQo+ID4gICBkdC1i
aW5kaW5nczogbWlzYzogQWRkIGJpbmRpbmcgZm9yIFItQ2FyIERBQg0KPiA+ICAgbWlzYzogQWRk
IGRyaXZlciBmb3IgREFCIElQIGZvdW5kIG9uIFJlbmVzYXMgUi1DYXIgZGV2aWNlcw0KPiA+ICAg
YXJtNjQ6IGR0czogcmVuZXNhczogcjhhNzc5OTA6IEFkZCBEQUIgc3VwcG9ydA0KPiA+ICAgYXJt
NjQ6IGR0czogcmVuZXNhczogcjhhNzc5NjU6IEFkZCBEQUIgc3VwcG9ydA0KPiA+ICAgYXJtNjQ6
IGNvbmZpZ3M6IEFkZCBSLUNhciBEQUIgc3VwcG9ydA0KPiA+DQo+ID4gIC4uLi9kZXZpY2V0cmVl
L2JpbmRpbmdzL21pc2MvcmVuZXNhcyxkYWIueWFtbCB8ICA3NSArKysrKysrKw0KPiA+ICBNQUlO
VEFJTkVSUyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgIDcgKw0KPiA+ICBh
cmNoL2FybTY0L2Jvb3QvZHRzL3JlbmVzYXMvcjhhNzc5NjUuZHRzaSAgICAgfCAgMTIgKysNCj4g
PiAgYXJjaC9hcm02NC9ib290L2R0cy9yZW5lc2FzL3I4YTc3OTkwLmR0c2kgICAgIHwgIDEyICsr
DQo+ID4gIGFyY2gvYXJtNjQvY29uZmlncy9kZWZjb25maWcgICAgICAgICAgICAgICAgICB8ICAg
MSArDQo+ID4gIGRyaXZlcnMvY2xrL3JlbmVzYXMvcjhhNzc5NjUtY3BnLW1zc3IuYyAgICAgICB8
ICAgMSArDQo+ID4gIGRyaXZlcnMvY2xrL3JlbmVzYXMvcjhhNzc5OTAtY3BnLW1zc3IuYyAgICAg
ICB8ICAgMSArDQo+ID4gIGRyaXZlcnMvbWlzYy9LY29uZmlnICAgICAgICAgICAgICAgICAgICAg
ICAgICB8ICAgMSArDQo+ID4gIGRyaXZlcnMvbWlzYy9NYWtlZmlsZSAgICAgICAgICAgICAgICAg
ICAgICAgICB8ICAgMSArDQo+ID4gIGRyaXZlcnMvbWlzYy9yY2FyX2RhYi9LY29uZmlnICAgICAg
ICAgICAgICAgICB8ICAxMSArKw0KPiA+ICBkcml2ZXJzL21pc2MvcmNhcl9kYWIvTWFrZWZpbGUg
ICAgICAgICAgICAgICAgfCAgIDggKw0KPiA+ICBkcml2ZXJzL21pc2MvcmNhcl9kYWIvcmNhcl9k
ZXYuYyAgICAgICAgICAgICAgfCAxNzYgKysrKysrKysrKysrKysrKysrDQo+ID4gIGRyaXZlcnMv
bWlzYy9yY2FyX2RhYi9yY2FyX2Rldi5oICAgICAgICAgICAgICB8IDExNiArKysrKysrKysrKysN
Cj4gPiAgZHJpdmVycy9taXNjL3JjYXJfZGFiL3JjYXJfZmZ0LmMgICAgICAgICAgICAgIHwgMTYw
ICsrKysrKysrKysrKysrKysNCj4gPiAgaW5jbHVkZS91YXBpL2xpbnV4L3JjYXJfZGFiLmggICAg
ICAgICAgICAgICAgIHwgIDM1ICsrKysNCj4gPiAgMTUgZmlsZXMgY2hhbmdlZCwgNjE3IGluc2Vy
dGlvbnMoKykNCj4gPiAgY3JlYXRlIG1vZGUgMTAwNjQ0DQo+IERvY3VtZW50YXRpb24vZGV2aWNl
dHJlZS9iaW5kaW5ncy9taXNjL3JlbmVzYXMsZGFiLnlhbWwNCj4gPiAgY3JlYXRlIG1vZGUgMTAw
NjQ0IGRyaXZlcnMvbWlzYy9yY2FyX2RhYi9LY29uZmlnDQo+ID4gIGNyZWF0ZSBtb2RlIDEwMDY0
NCBkcml2ZXJzL21pc2MvcmNhcl9kYWIvTWFrZWZpbGUNCj4gPiAgY3JlYXRlIG1vZGUgMTAwNjQ0
IGRyaXZlcnMvbWlzYy9yY2FyX2RhYi9yY2FyX2Rldi5jDQo+ID4gIGNyZWF0ZSBtb2RlIDEwMDY0
NCBkcml2ZXJzL21pc2MvcmNhcl9kYWIvcmNhcl9kZXYuaA0KPiA+ICBjcmVhdGUgbW9kZSAxMDA2
NDQgZHJpdmVycy9taXNjL3JjYXJfZGFiL3JjYXJfZmZ0LmMNCj4gPiAgY3JlYXRlIG1vZGUgMTAw
NjQ0IGluY2x1ZGUvdWFwaS9saW51eC9yY2FyX2RhYi5oDQo+IA0KPiAtLQ0KPiBSZWdhcmRzLA0K
PiANCj4gTGF1cmVudCBQaW5jaGFydA0K

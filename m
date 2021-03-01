Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BD643281AD
	for <lists+linux-api@lfdr.de>; Mon,  1 Mar 2021 16:03:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236764AbhCAPCE (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 1 Mar 2021 10:02:04 -0500
Received: from mail-eopbgr1410119.outbound.protection.outlook.com ([40.107.141.119]:16256
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236767AbhCAPCD (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Mon, 1 Mar 2021 10:02:03 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KHmMnNxGvqS82k8V7rpF29csKC5099ZCuTJDQdtwW1L3JTkFqaA+O3eHmcqgAu9p1Y0j8wcqjw1soHL6IV3e+Ut2+KaY9F6eShqMxkrkKMfUKQYh2sS57n80lHZHaGCp6CfFd5iQW0DBjZUVJYy+q7mE3uZLDG1MTc5pRmbD0Tv6Jc6BcZtYBSjP1mmA6gZwHS7W9dc7fjsI8y0oY/+FOTceXtQ5ZhLDGU/XbRHMVlF29Q2YyaC1JbShY41pg+3TX3EyCDjOiWOoGxjdssER3MG/VM2QFgbgoQLEGpWI7pLFJQGkj8z1yA9jDHgDeqv9fULUySu+W33FljJXZLqpfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uW4GOIZTuH1e/H4Y+8dGAhyfZ7Q8fdNytoWhIcJylxk=;
 b=RPNdVZiqoRni31xDZXb1DvaH18fb69QLSxX5VywQpZRrTt4bcr0KDE0Om1D+Bn1QlZe62BTmJVoZwST4O74UvM/E2WB4RTiNumlk4WLq3sAoKm7rkeJTnk7ILuUILSvQ/olnAhtEUdmDzyQ0YgCTrREjpjEV5U/S8/wGMU3aMW2bahupApZZSI3BS9QfJ6df0oCQKOdSdg+aBIHTluaVBtArCBitIaGMjpNm1Un7Gij4XHoguTGLC9fZ2W6wlpsNj+b3stmCyP7/VYSyinmvCgvx60mcu63O1JXOco5IGxdJulB/vaArEgCFc4+Bjry33gMyl+fsLTlwvcWLdtiNag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uW4GOIZTuH1e/H4Y+8dGAhyfZ7Q8fdNytoWhIcJylxk=;
 b=oMwbM2nnCkrBSrp8TpxrIH/0I2rd//hLcuX35MIKhZ2sga8sPT+ayIgkdWHqTnTsGQ0Y0BxeUKt0pwl5Gw6RFfHQuLBpoBSkWDNvI6tUGDHg+7MqLhbeXgLlNh+nQeAFApusv4bLQtNXRjQtEPQVQ4DRig91ZzbbYJ5pFuMv93c=
Received: from OSAPR01MB2737.jpnprd01.prod.outlook.com (2603:1096:603:38::21)
 by OSBPR01MB4056.jpnprd01.prod.outlook.com (2603:1096:604:4c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Mon, 1 Mar
 2021 15:01:14 +0000
Received: from OSAPR01MB2737.jpnprd01.prod.outlook.com
 ([fe80::4d2d:3155:768e:50e0]) by OSAPR01MB2737.jpnprd01.prod.outlook.com
 ([fe80::4d2d:3155:768e:50e0%7]) with mapi id 15.20.3890.028; Mon, 1 Mar 2021
 15:01:14 +0000
From:   Fabrizio Castro <fabrizio.castro.jz@renesas.com>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
CC:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
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
Thread-Index: AQHXC8j5EQG4xEwyhEGkm3G1ZaUM1KpqH9sAgABEB4CABNsssA==
Date:   Mon, 1 Mar 2021 15:01:14 +0000
Message-ID: <OSAPR01MB2737B48A9C32BE7162BB701AC29A9@OSAPR01MB2737.jpnprd01.prod.outlook.com>
References: <20210225225147.29920-1-fabrizio.castro.jz@renesas.com>
 <20210225225147.29920-3-fabrizio.castro.jz@renesas.com>
 <CAMuHMdXNBeVK0ze8HSA=t5TTfhyuRz=+yLHMBioUbsuBxUoWyA@mail.gmail.com>
 <YDjuMRkU+g52I1gm@pendragon.ideasonboard.com>
In-Reply-To: <YDjuMRkU+g52I1gm@pendragon.ideasonboard.com>
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
x-ms-office365-filtering-correlation-id: 1535c278-15fa-4958-815a-08d8dcc2dbe3
x-ms-traffictypediagnostic: OSBPR01MB4056:
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <OSBPR01MB40566158E7A7A9DD5A4128EAC29A9@OSBPR01MB4056.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: l9UjUhBQM/QEM3sxQHE8zru+5k5xCPgh39H5/FWcFbjqsA6nEbG0dUTKiCI3rogS08tfALaWBEKVTy4Rnk4hy/ecARyoRfVBkWHj5qG1BTmwcC5u16Fjkrj55V3/xsCyv0iwVau78OuD6l1ot5LoyN8E2GOalNpEz/kI2qOVHhq8Fh+SjnPQPrZIc6qR4rDwM1R+yOIfnyH/ZFnld5gum5uOv9b1jVcTXb5ctEccYoPESrLjEABk1fv/QiWxdLo61uCx6hO1OPQ9I5Egg5cEAXv2Npj0zcUYcZk1veSnr8FcN41EQe+qJ4G4aRayABv5zOV2jNa5z6GFXt++1r/SivKyVLnAr1lk/LF5weedwHc/ci6u/MtYaFMtSYpYn5Pr1H8QmkMCc1euxExiqQmnrCtDCrkM5qLpruEigtUm2DVgd62ko22+/OB2ufzZtFT1tcGkLMVnX8kJXb5lXA3G2mztt7kN4uyBCoAd19BBEAYZ7qkySEmALmbu2fR4+wmfDcHlVnFJpB/0Aod6r5/DGQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSAPR01MB2737.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(366004)(39860400002)(136003)(346002)(83380400001)(8936002)(478600001)(54906003)(53546011)(5660300002)(9686003)(7696005)(316002)(76116006)(6506007)(7416002)(107886003)(71200400001)(66556008)(64756008)(6916009)(186003)(26005)(33656002)(55016002)(66446008)(86362001)(66476007)(8676002)(4326008)(52536014)(66946007)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?ZmoxMjFGckJIWEpacEROZG1Hc0EzcWtTdzh5UWY3T2ZPVlRGQUFGQWt1dEl4?=
 =?utf-8?B?WGVhNVc5cTZPS003d2ZTMVdxVTdUR1BEbzQ0MXhHWUhxUXpRNW1mMDJKcnMx?=
 =?utf-8?B?amFWMERNWHhVc1hIZ28wUkFNckkydHFBbVB6dGFMKzFMNG4rL0ZRMWQ0NW1L?=
 =?utf-8?B?R2xoNGRBNjJkUWg1K1NJZWNJSCt2WlllZkhhMDl3eTlFdVliMEp5cjJQVkxs?=
 =?utf-8?B?RjkxZ0I2U0Rnb3lZMmk5VjBsYnF0bk45ZGI0aVYzRHJuZU9xa2ZJaGdtMm5I?=
 =?utf-8?B?UVJVOWVtZ25RMDdIZ3hLaVhlakFsV2VkaXNkeUdVcmFheVd1L2tTQU41ZmQx?=
 =?utf-8?B?cDg1OHQ4Vi96NS9pdTVyMjdVV2V4N3IwNTB2eWlqY2hPVGhKL1dIK2NoaGJ4?=
 =?utf-8?B?UjVkSUw4MGNCMGJpQllRQzZYSDIzZ01NNHUrZHIxam5VZnY0L1dETEREUldL?=
 =?utf-8?B?Zlc1UDdZZExCcHVHelJ2YWFzdGE3eC8vc0ZydGZZRFVUTHQ0YXp2SXZxR25V?=
 =?utf-8?B?ekQ0Z21vT2l1TUZrYUJ4ZEJnbkc3dFc5WllMQ0EzV1F0RlhTRFZ2MExFQitC?=
 =?utf-8?B?TXllQXNtd0ZieTQ5YnVtVXplV0ZScDg2VWpCZ0dqdmVuSGIvZmZCYVR2V05K?=
 =?utf-8?B?UnRERWcvRDBiL2UzcXlQL0s1OUJoWlJCWkhWRGtUQ0NHNnBjWXU1akxHNElN?=
 =?utf-8?B?NUtQTmpNenB6TDNIajVZdjFGSytpRHNmemZMM2xnREdyaFpDZDdzaDBwNzZP?=
 =?utf-8?B?ZC9maUhHTVYvSDFlZVlPSUVZVytjLytxMmNQSWV0TWZqOW9UOG53bW5DZEJN?=
 =?utf-8?B?c0ovVWNhQTVWZk9GUENuZm9SUU5iVTNFOUU2clhnaUF5Uk1WVm5PcVBVeGFi?=
 =?utf-8?B?WjkvWDRiWHRISGl1VEdvY29EL0NoMWY4MnhISDVyUm5HejdxVzdrd0VTNC8r?=
 =?utf-8?B?ZXBKbmpVN3ZkcFlrWTdyOUdEUGk0YUNBKzRDZEVqYkVvY2N5YVlWOSsyNCsy?=
 =?utf-8?B?ZGcxT1VoNDZybnNwRm82aFNHZGVVS3o2ZnBieHhqY0JFQXRsc2hvL1lNUlkv?=
 =?utf-8?B?NDRoMFNzekg3d2s5d1FBWDkzN1cvRTBpQ1FOY0NHQ1UxVnBjNlVBTUN5Zlhj?=
 =?utf-8?B?SzNIU3Jwckg2M0NqdXZqOGFXK2tXWXdjZjZKZmdzN1JVTTRVWjVCdWpqOUx0?=
 =?utf-8?B?Z25HMkkrMTdXMTZDdWRETmZuOTZNWEZEcSswVFl1eU16by9HTXVnaXpaeXd6?=
 =?utf-8?B?dHRHWExDb0lEdTl2cktRemJ0K1NnRWRoNVlSZW1HNU5vQjhXUko1OGRGd3pa?=
 =?utf-8?B?eVBUNU1HQ0hBTzdqZTRUdzdVL2orRkVhV2R1TjJxZnpaYjZuSzB6Qm5lcFVp?=
 =?utf-8?B?Ym5KLzNJdm05anlHT3d5c2UxU2t1QnZHZ0ZHMGowb1V0MHBCTTVYTTJraXZi?=
 =?utf-8?B?UTdBNTRlU29LOHNZUXlYcjVrZXhHd1dneW43UGxxRFdnbXVGQS9IRlM2YlYy?=
 =?utf-8?B?TTI2V3VmSmU3RlVRRUhDN2hmMDlCV2pxYm1PRXVsbzgwZFoyOTdHMVBNL0ZW?=
 =?utf-8?B?ck5Wb2NseEw3TUtYdzdRUVF4dGRCNjBLVTgyWHd0NnlDKzJNcWI0UFZlZ1lG?=
 =?utf-8?B?RXc2elV6V0xJNWRuejVHZi94alBUT3h1YVQxOTkwVC9ZdCtUUHcwTWpyaUhL?=
 =?utf-8?B?OGJrZ2lJVklpSnJUdlFUdithVHlZVkd1Z2VlbWRGMDFQd3phdWc5QnZuV3ZZ?=
 =?utf-8?Q?SI7SxS/meKOIT9aiRVDg/bs+IlqhBBRHfNzAp7A?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSAPR01MB2737.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1535c278-15fa-4958-815a-08d8dcc2dbe3
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2021 15:01:14.2152
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WqcfTdBOV4pY+MVOwsKIauGXcLBYoSsI3aL5KoUftVuvrOjLTGKby2UKC1D1Qhh8hbFXqry2rUMDJo9IVcIAR0NJL0MryEFjTfWVsnYXp28=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB4056
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

SGkgTGF1cmVudCwNCg0KVGhhbmtzIGZvciB5b3VyIGZlZWRiYWNrIQ0KDQo+IEZyb206IExhdXJl
bnQgUGluY2hhcnQgPGxhdXJlbnQucGluY2hhcnRAaWRlYXNvbmJvYXJkLmNvbT4NCj4gU2VudDog
MjYgRmVicnVhcnkgMjAyMSAxMjo0OQ0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDIvN10gY2xrOiBy
ZW5lc2FzOiByOGE3Nzk2NTogQWRkIERBQiBjbG9jaw0KPiANCj4gSGkgRmFicml6aW8sDQo+IA0K
PiBUaGFuayB5b3UgZm9yIHRoZSBwYXRjaC4NCj4gDQo+IE9uIEZyaSwgRmViIDI2LCAyMDIxIGF0
IDA5OjQ1OjIwQU0gKzAxMDAsIEdlZXJ0IFV5dHRlcmhvZXZlbiB3cm90ZToNCj4gPiBPbiBUaHUs
IEZlYiAyNSwgMjAyMSBhdCAxMTo1MyBQTSBGYWJyaXppbyBDYXN0cm8gd3JvdGU6DQo+ID4gPiBU
aGlzIHBhdGNoIGFkZHMgdGhlIERBQiBjbG9jayB0byB0aGUgUjhBNzc5NjUgU29DLg0KPiA+ID4N
Cj4gPiA+IFNpZ25lZC1vZmYtYnk6IEZhYnJpemlvIENhc3RybyA8ZmFicml6aW8uY2FzdHJvLmp6
QHJlbmVzYXMuY29tPg0KPiA+DQo+ID4gVGhhbmtzIGZvciB5b3VyIHBhdGNoIQ0KPiA+DQo+ID4g
PiAtLS0gYS9kcml2ZXJzL2Nsay9yZW5lc2FzL3I4YTc3OTY1LWNwZy1tc3NyLmMNCj4gPiA+ICsr
KyBiL2RyaXZlcnMvY2xrL3JlbmVzYXMvcjhhNzc5NjUtY3BnLW1zc3IuYw0KPiA+ID4gQEAgLTI1
MCw2ICsyNTAsNyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IG1zc3JfbW9kX2Nsaw0KPiByOGE3Nzk2
NV9tb2RfY2xrc1tdIF9faW5pdGNvbnN0ID0gew0KPiA+ID4gICAgICAgICBERUZfTU9EKCJzc2ky
IiwgICAgICAgICAgICAgICAgIDEwMTMsICAgTU9EX0NMS19JRCgxMDA1KSksDQo+ID4gPiAgICAg
ICAgIERFRl9NT0QoInNzaTEiLCAgICAgICAgICAgICAgICAgMTAxNCwgICBNT0RfQ0xLX0lEKDEw
MDUpKSwNCj4gPiA+ICAgICAgICAgREVGX01PRCgic3NpMCIsICAgICAgICAgICAgICAgICAxMDE1
LCAgIE1PRF9DTEtfSUQoMTAwNSkpLA0KPiA+ID4gKyAgICAgICBERUZfTU9EKCJkYWIiLCAgICAg
ICAgICAgICAgICAgIDEwMTYsICAgUjhBNzc5NjVfQ0xLX1MwRDYpLA0KPiA+DQo+ID4gVW5mb3J0
dW5hdGVseSB0aGlzIGJpdCBpcyBub3QgZG9jdW1lbnRlZCBpbiB0aGUgUi1DYXIgR2VuMyBIYXJk
d2FyZQ0KPiA+IFVzZXIncyBNYW51YWwsIHNvIEkgaGF2ZSB0byB0cnVzdCB5b3Ugb24gdGhpcy4N
Cj4gPg0KPiA+IFdoaWxlIGl0J3Mgbm90IHVudXN1YWwgdGhhdCB0aGUgc2FtZSBtb2R1bGUgb24g
Ui1DYXIgRTMgYW5kIE0zLU4NCj4gPiBoYXMgZGlmZmVyZW50IHBhcmVudCBjbG9ja3MsIGl0IGRv
ZXMgc3RyaWtlIG1lIGFzIG9kZCB0aGF0IFMwRDYgb24gTTMtTg0KPiA+IHJ1bnMgYXQgMTMzIE1I
eiwgd2hpbGUgUzNEMSBvbiBFMyBydW5zIGF0IDI2NiBNSHouDQo+ID4gUHJvYmFibHkgaXQgZG9l
c24ndCBtYXR0ZXIgdGhhdCBtdWNoLCBhcyB5b3VyIGRyaXZlciBkb2Vzbid0IGNhcmUNCj4gPiBh
Ym91dCB0aGUgYWN0dWFsIGNsb2NrIHJhdGUuDQo+IA0KPiBJIGhhdmUgdGhlIGV4YWN0IHNhbWUg
Y29uY2VybnMsIGhlcmUgYW5kIGZvciAxLzcuDQoNCkkgaGVhciB5b3UsIGJ1dCB5b3Uga25vdyBo
b3cgdGhlc2Ugc29ydCBvZiB0aGluZ3MgZ28sIGEgYml0IHdhcyBsZWZ0DQpiZWhpbmQsIG5vdyB0
aGV5IGFyZSBhd2FyZSBvZiB0aGlzIGJpdCBtaXNzaW5nIGZyb20gdGhlIGRvY3VtZW50YXRpb24N
CmFuZCBhdCBzb21lIHBvaW50IHRoZXkgd2lsbCByZWxlYXNlIGEgZG9jdW1lbnQgYWRkcmVzc2lu
ZyB0aGlzIHBhcnRpY3VsYXINCnBvaW50LiBNZWFud2hpbGUsIHdlIGhhdmUgcmVjZWl2ZWQgd3Jp
dHRlbiBjb25maXJtYXRpb24gZm9yIHRoaXMsIHNvDQppdCBzaG91bGQgYmUgb2theS4NCg0KVGhh
bmtzLA0KRmFiDQoNCj4gDQo+ID4gPiAgICAgICAgIERFRl9NT0QoInNjdS1hbGwiLCAgICAgICAg
ICAgICAgMTAxNywgICBSOEE3Nzk2NV9DTEtfUzNENCksDQo+ID4gPiAgICAgICAgIERFRl9NT0Qo
InNjdS1kdmMxIiwgICAgICAgICAgICAgMTAxOCwgICBNT0RfQ0xLX0lEKDEwMTcpKSwNCj4gPiA+
ICAgICAgICAgREVGX01PRCgic2N1LWR2YzAiLCAgICAgICAgICAgICAxMDE5LCAgIE1PRF9DTEtf
SUQoMTAxNykpLA0KPiANCj4gLS0NCj4gUmVnYXJkcywNCj4gDQo+IExhdXJlbnQgUGluY2hhcnQN
Cg==

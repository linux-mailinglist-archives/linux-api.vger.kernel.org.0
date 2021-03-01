Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B98123281E9
	for <lists+linux-api@lfdr.de>; Mon,  1 Mar 2021 16:13:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236953AbhCAPMW (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 1 Mar 2021 10:12:22 -0500
Received: from mail-eopbgr1410137.outbound.protection.outlook.com ([40.107.141.137]:64040
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236915AbhCAPLd (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Mon, 1 Mar 2021 10:11:33 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EuXxpRYYPOLPfoNhNXdGzMnkfMJ/0Fm624YdvbKTBCLuHqyZKqhnmuOez8EnxUB0SCOsyomkjnaT1Wb0lOieqkI6PO4p32JfqR2etVHLISIpuNiuk0ptdbCMehsMUCN621HLK9Cadw4uLmyv8OhsYsskiGsKfirHzZHiK09s7cKKdK71U5PX8GQK1AYjH3CJR5li2o6EO7ktxK2oNifmk5yWaH9U91RrhcsEdfK7cwsV/ZOnBL6zkx8JTbKTZlGdHTnoOoJSHjazJGIsbUg/pTeNFL1SakiPLo61gfdsfiz+B8pXRrR+K6FMeFgiE/yH2iO1k2ZeHk9TPwuO1RnZqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qlFX7PRYp+ci0Bv2tI1ZYqH5H13/wXwgFYNozdzy+Jo=;
 b=PUvVBS+ykxKspahqps1uyo3WF0TqQypR7h66kibtmwiFT1Kiizx+dxYX6GCbOvI6vnkN1CaLbfsZzxrsIRH1hc+1vQQZli5cPaJnGMDwJ1DBoa9AHG52l0IamvZEDQnM8eI6egmAF3EQ8rH1HQEeCpF/bqKuw1v+/hIOLO3BkT8aei/n6/a+IZmUBWnNao3K1eEEgBPSUVhZkheYqk+EoejusLigFkq2CEnew9yL/18A+QHQLTr8oIbqzG25uMGLXkaAxKjOGrRtfUIDErBZKqu1OmdneKdFE+vaPspcsME5pEZOX3KrSlD/KCynOB1E1ykkqwI/U4w5fraZEYSVfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qlFX7PRYp+ci0Bv2tI1ZYqH5H13/wXwgFYNozdzy+Jo=;
 b=RhNABit/4oNWeKx/9HFfWbfF/qYbk6eOBXDhTDHVZHUNctSSnq2ZUCYRxkKE/7wwWOLH4RhnK5/Rd8EHG4q1UVj/+Bc2X29rnPmtXJbvH0F2HA3TwHRLeMJ0gWbA4hT+DMe5eorRe88Tcei8OhcnVZkNsagksUtK1V9gNNSUiM0=
Received: from OSAPR01MB2737.jpnprd01.prod.outlook.com (2603:1096:603:38::21)
 by OSBPR01MB5270.jpnprd01.prod.outlook.com (2603:1096:604:4c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.23; Mon, 1 Mar
 2021 15:10:44 +0000
Received: from OSAPR01MB2737.jpnprd01.prod.outlook.com
 ([fe80::4d2d:3155:768e:50e0]) by OSAPR01MB2737.jpnprd01.prod.outlook.com
 ([fe80::4d2d:3155:768e:50e0%7]) with mapi id 15.20.3890.028; Mon, 1 Mar 2021
 15:10:43 +0000
From:   Fabrizio Castro <fabrizio.castro.jz@renesas.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Rob Herring <robh+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
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
Subject: RE: [PATCH 3/7] dt-bindings: misc: Add binding for R-Car DAB
Thread-Topic: [PATCH 3/7] dt-bindings: misc: Add binding for R-Car DAB
Thread-Index: AQHXC8j9uaI63SAiyE2WHTRNCWQ/bapqHq2AgAUhZ0A=
Date:   Mon, 1 Mar 2021 15:10:43 +0000
Message-ID: <OSAPR01MB273701818D9BA7E5F9CCED24C29A9@OSAPR01MB2737.jpnprd01.prod.outlook.com>
References: <20210225225147.29920-1-fabrizio.castro.jz@renesas.com>
 <20210225225147.29920-4-fabrizio.castro.jz@renesas.com>
 <CAMuHMdURsd5bvHNTOqJGbVQBc4FFo=jLr=Xf2GZntO-Crh1R-A@mail.gmail.com>
In-Reply-To: <CAMuHMdURsd5bvHNTOqJGbVQBc4FFo=jLr=Xf2GZntO-Crh1R-A@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linux-m68k.org; dkim=none (message not signed)
 header.d=none;linux-m68k.org; dmarc=none action=none header.from=renesas.com;
x-originating-ip: [2.28.163.123]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2c3f8771-f9bf-4f43-0d68-08d8dcc42f50
x-ms-traffictypediagnostic: OSBPR01MB5270:
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <OSBPR01MB52700C3487EBB464CAFB0162C29A9@OSBPR01MB5270.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wn9V/3Vrb9FzLPVQrw+qkuFKPOLhhXfnL5u994OXRuyIGO37l9G/D1iDo3MRVxKPxI8KKZtPMpnhJwkrfJy6d4Q6uLqzGXvhFlHXT3Ta3SeMVKNCPmaBM0ZSqZop3PAKCSHyMcXeTrUPicnrYzBGCxh8PnNxbD5hOSMu5CGafrImZErbcmGJl7HTaXKIobWHWxO5+SmUEiCG+bzBbSRetogL1OsN5qNk+80tpKAGlVeEat3mo3U45f1GSQgCt4uPZ5ZSvOngY1rMfvikBjxdOmphJKbOUpjREQFPs8dQqne0Icnwuv3U8FzScBb095EGFeanTDXPjHUBnVXO6ZHdj4XFdQUqTgKAQ301SZ+KIkZN069uXg9tyRPF3RTyv/sC6WIpEJQROnMQw36Hb01vJOiA2RUmpDIdI3G0uaU4/Zy5T+ZPZj72lh3sM7zG57FP+ng/dFU7D4TltyxgvhBiKar+xCgl3NU7zumyYrQrqKLFujLlsMjeCW+lrerOFSVuDAidzFNb0QlBVhc5LrAXGA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSAPR01MB2737.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(396003)(346002)(136003)(366004)(83380400001)(86362001)(5660300002)(8676002)(478600001)(8936002)(71200400001)(33656002)(53546011)(6506007)(2906002)(26005)(66556008)(6916009)(7696005)(186003)(52536014)(316002)(76116006)(66476007)(64756008)(7416002)(55016002)(66946007)(54906003)(4326008)(9686003)(107886003)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?cDFPZ3JBTkdpNlBaNEFjaGZkL2xTR0FSWFA0VnFMRTZVaVpKemxsdkF6QTFs?=
 =?utf-8?B?UWUxeHE4YkdMeE5OWWZuOFFJMUtic0VKQ3V1czJEeGFEQlJKVlBmUFV1Qkl4?=
 =?utf-8?B?a3h1R0pVWXZzb0wzcFg0ZVRFOVNQV015L3JFaStmYk1rRkxTejhOdFl3Q3p4?=
 =?utf-8?B?YUxWbXRCN0xGcmdYcEU0WWhpWE9MTGNCdWRQSERsT3VXTXhkL3FxS3VxVkRF?=
 =?utf-8?B?am1LQ1BieitPalRnd2tHS1p2cFJpNndFZUFGZGg1YVZWRHZhYWdaTnBzby8y?=
 =?utf-8?B?TDBTdE4wYXZsY3N5NzNDZ1lnRHhuVTVYMU15SnAyUGJGeHRoUlRPbTkrMHhk?=
 =?utf-8?B?aW4rSnZscHRzaks5T2JKbktuZnpFS05TdU56Um93ODVpeUp0UnZBS1g2MXV3?=
 =?utf-8?B?RGJlS2RJMXUxb24zbno0WmlIc2RadXJ6RzNoQkNFUkJIMzEwZmwwampRdVU3?=
 =?utf-8?B?UzNpT3lzcGZOMGEwRm9tSlA3MlhxblV1UFRmNUJZZ0JaSHoxeWFYS3FWeW9z?=
 =?utf-8?B?bkozQktZYlIyNWxObGVrV1pXYzZRb1NrU3o1bnZPcUZvZWNkQ2dLU2N1MmpU?=
 =?utf-8?B?dTVCVEhnTXpEMmJibkZ3cEJYOEFPS1BsakwxRzVEbmp2N0pmNWRtemFGM2Fs?=
 =?utf-8?B?aGFlbGVrQmx2ZGEvaVdBKytWdCtkeWlXME5rbU0wMWN3RmxmbnlISldVT1VW?=
 =?utf-8?B?NTBYTkYweGhuK1NPQTdXVmhCc0QyVXJObm5FeVZtL3NrS1JjTFEvYXoyQWlD?=
 =?utf-8?B?VzNzSXYwQXNnM2FuZTE3NFloWWNBMDh2VnVMU1dIck5CN0g4L0RZMVBJcERi?=
 =?utf-8?B?M0N1WkNvNXhkRmJVWUV6ditpVnlNak8zdUtNMDVhTGRZbllHS05kUGc1Z05Y?=
 =?utf-8?B?WjAxOXA4ellnVVc5bVhkSmNNNm82dUgwaFRjMnJwaHBxdURZTFl4bXpHQVpj?=
 =?utf-8?B?ck9SWFVzdnloZk11ZW1BUWdmTHpNT1N1YXVvOTZYVUhLQ1d1VUZmRGJ5cEdq?=
 =?utf-8?B?RkJqRzg3a28rSWVkNHNqNmxtZEk3NnNmcndjWjNwS0owdnJCY3ZyUEw5UUdJ?=
 =?utf-8?B?OFlDWnYvMUs2aURBTi9PMTJTOFJVNGxONlVPdUVzSkJINlZmWGRHR2lTWUlj?=
 =?utf-8?B?MVFKenBQRmhSSVZXM3Y4MnpocldzanpXcVRVRDU3VGlNRCtnZkg1T3Exc2pr?=
 =?utf-8?B?MXAyYzB4Zlc0Z2NObFdCcFllUG5KbjdPM3czVm0vZ01EN2cwSDArd2U5WEpS?=
 =?utf-8?B?MENGM3EvaUVoUlZIRUJNY2k0QVBVdTVib0dPNEFXSitLUFFwTlN6T2NaWGRD?=
 =?utf-8?B?QzlhU2JBWktwMW5LYWp4WTVFbmp3OEI1VkV5SDgwanRwZ1dNVm13bHRla3Na?=
 =?utf-8?B?cDMyVERkd0tRbEZGNVhVVXRJODd0eDM4M2I1dnFKTFlBeS80eXBDSHBXdHMy?=
 =?utf-8?B?T25lUDY3QWxEaFNhWnh6QmE0N3JyK2tzQ3RNTmZpblJUQzM3L1lLYWRpSTF4?=
 =?utf-8?B?WUVIVmtMOFl5a0pJc2pUWHk2VXhTcXdDQSs2ajJ6VmRSVlloN2tBekp0V2lS?=
 =?utf-8?B?RGpjS2ExYVhPTjlaSlFjZDRyT052Y0o3ZU9hR09KN0kvSGU3c0tlaytYTHBy?=
 =?utf-8?B?UUV0bm5oY2JKME1lckpWYi8zUURUZEdiUnhDVzB6WDk3QjlsQVJmNmZSYVlq?=
 =?utf-8?B?T0NpRlZ5bU9ob1hIY3A5NExqMDduYXIwTkJKMnJYVDI0NGh6NVhXdnROVkZE?=
 =?utf-8?Q?hkaHyREa2xa/cT8hpCOTIEpa5GW3wbTj5I1cquQ?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSAPR01MB2737.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c3f8771-f9bf-4f43-0d68-08d8dcc42f50
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2021 15:10:43.6872
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gj0iaYxAqB44giGsrdh5vyIunitNwThnRUHwkZrEqEgejfFvbhDb9I1kCh4VJ/JUmmgu8/mltqTuVfsA8MVgxXF3jdQqUjkKfqq5XbOeV7Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB5270
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

SGkgR2VlcnQsDQoNClRoYW5rcyBmb3IgeW91ciBmZWVkYmFjayENCg0KPiBGcm9tOiBHZWVydCBV
eXR0ZXJob2V2ZW4gPGdlZXJ0QGxpbnV4LW02OGsub3JnPg0KPiBTZW50OiAyNiBGZWJydWFyeSAy
MDIxIDA4OjQxDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMy83XSBkdC1iaW5kaW5nczogbWlzYzog
QWRkIGJpbmRpbmcgZm9yIFItQ2FyIERBQg0KPiANCj4gSGkgRmFicml6aW8sDQo+IA0KPiBPbiBU
aHUsIEZlYiAyNSwgMjAyMSBhdCAxMTo1MyBQTSBGYWJyaXppbyBDYXN0cm8NCj4gPGZhYnJpemlv
LmNhc3Ryby5qekByZW5lc2FzLmNvbT4gd3JvdGU6DQo+ID4gRG9jdW1lbnQgYmluZGluZ3MgZm9y
IFItQ2FyIERBQiBoYXJkd2FyZSBhY2NlbGVyYXRvciwgY3VycmVudGx5DQo+ID4gZm91bmQgb24g
dGhlIHI4YTc3OTkwIFNvQyAoYS5rLmEuIFItQ2FyIEUzKSBhbmQgb24gdGhlIHI4YTc3OTY1DQo+
ID4gU29DIChhLmsuYS4gUi1DYXIgTTMtTikuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBGYWJy
aXppbyBDYXN0cm8gPGZhYnJpemlvLmNhc3Ryby5qekByZW5lc2FzLmNvbT4NCj4gDQo+IFRoYW5r
cyBmb3IgeW91ciBwYXRjaCENCj4gDQo+ID4gLS0tIC9kZXYvbnVsbA0KPiA+ICsrKyBiL0RvY3Vt
ZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9taXNjL3JlbmVzYXMsZGFiLnlhbWwNCj4gDQo+
ID4gK3Byb3BlcnRpZXM6DQo+ID4gKyAgY29tcGF0aWJsZToNCj4gPiArICAgIGl0ZW1zOg0KPiA+
ICsgICAgICAtIGVudW06DQo+ID4gKyAgICAgICAgICAtIHJlbmVzYXMsZGFiLXI4YTc3OTY1ICAg
ICAjIFItQ2FyIE0zLU4NCj4gPiArICAgICAgICAgIC0gcmVuZXNhcyxkYWItcjhhNzc5OTAgICAg
ICMgUi1DYXIgRTMNCj4gDQo+IFBsZWFzZSB1c2UgdGhlIHJlY29tbWVuZGVkIG9yZGVyIGZvciBu
ZXcgYmluZGluZ3M6DQo+IA0KPiAgICAgcmVuZXNhcyxyOGE3Nzk2NS1kYWINCj4gICAgIHJlbmVz
YXMscjhhNzc5OTAtZGFiDQoNClNvcnJ5IGFib3V0IHRoaXMsIHdpbGwgY2hhbmdlLg0KDQo+IA0K
PiA+ICsgICAgICAtIGNvbnN0OiByZW5lc2FzLHJjYXItZ2VuMy1kYWIgIyBHZW5lcmljIGZhbGxi
YWNrIGZvciBSLUNhciBHZW4zDQo+IGRldmljZXMNCj4gPiArDQo+ID4gKyAgcmVnOg0KPiA+ICsg
ICAgbWF4SXRlbXM6IDENCj4gPiArDQo+ID4gKyAgaW50ZXJydXB0czoNCj4gPiArICAgIG1heEl0
ZW1zOiAxDQo+ID4gKw0KPiA+ICsgIGNsb2NrczoNCj4gPiArICAgIG1heEl0ZW1zOiAxDQo+ID4g
Kw0KPiA+ICsgIGNsb2NrLW5hbWVzOg0KPiA+ICsgICAgY29uc3Q6IGRhYg0KPiANCj4gZmNrPw0K
DQpBZ3JlZWQuDQoNClRoYW5rcywNCkZhYg0KDQo+IA0KPiBHcntvZXRqZSxlZXRpbmd9cywNCj4g
DQo+ICAgICAgICAgICAgICAgICAgICAgICAgIEdlZXJ0DQo+IA0KPiAtLQ0KPiBHZWVydCBVeXR0
ZXJob2V2ZW4gLS0gVGhlcmUncyBsb3RzIG9mIExpbnV4IGJleW9uZCBpYTMyIC0tIGdlZXJ0QGxp
bnV4LQ0KPiBtNjhrLm9yZw0KPiANCj4gSW4gcGVyc29uYWwgY29udmVyc2F0aW9ucyB3aXRoIHRl
Y2huaWNhbCBwZW9wbGUsIEkgY2FsbCBteXNlbGYgYSBoYWNrZXIuDQo+IEJ1dA0KPiB3aGVuIEkn
bSB0YWxraW5nIHRvIGpvdXJuYWxpc3RzIEkganVzdCBzYXkgInByb2dyYW1tZXIiIG9yIHNvbWV0
aGluZyBsaWtlDQo+IHRoYXQuDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgLS0g
TGludXMgVG9ydmFsZHMNCg==

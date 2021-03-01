Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E89D9328396
	for <lists+linux-api@lfdr.de>; Mon,  1 Mar 2021 17:22:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237261AbhCAQWH (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 1 Mar 2021 11:22:07 -0500
Received: from mail-eopbgr1410093.outbound.protection.outlook.com ([40.107.141.93]:16374
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237755AbhCAQUx (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Mon, 1 Mar 2021 11:20:53 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=juC79sIjfOCURr4mUIR9hGkSkE/i3qe9tRmWsjP/tGHA2bxGylQIR8h0PDjLCNJxGQE4jx0IXQBN9ij35ITg07fvGrFGge6FgKJ0LLiOqfpW2BOJvc2NnoBvOkLYcjcQsBj9wldPfMGQODH0G/uTFsdqxMS2r/0q5mAFEjsoR0fx3NiQccLMukJyysiSpqrwuN/oh0GIcXo9Z9e0q1YKsl/o4H/5BoF693Be96VxUP682MN/1aAK2vHo6UJTJXV9igegCiLyt50vXlIr1/WNgDO7FoqQmzdwAfyOXv/pW0FTPt/uVMrR5dXwSQ5nbIzOhzqhp3dZqikfBMhnfcVeZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4ftQl5G2/IApOGibu2S3QVjMCyyLgss/F0n9zh7LZW8=;
 b=DVhXDiSolkBjL9koWUgNBhmYdVleskJGqc2wlr9Q9kQV1M3hJPM9lKUxRtcDaFMZIshltD1hFbkPAOcAC/Si4YEPph1X4oeekK7AUQrnKaBL12SSbZUGHppW7KFnWGfr8bHeuJDW94g642iWlhwtajETiuXsqsd3lrJk6wK07njAmzYLyR55ox6adSpKgbuyp9COCOQufMuoXzZ+8dWAk49ehwj4FFFOx07/raUwN4v+0kwF+d1e1K86Ac22DXi9uQeKqEr2VognUPUMB6dZKgvIxZTs8jC8VJCIz6rAIeoXK+XepC9FaZttMmMRbkLseYwF1N6Z/qfX+WM6SfbJ9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4ftQl5G2/IApOGibu2S3QVjMCyyLgss/F0n9zh7LZW8=;
 b=RLbz73W8zgHDanDxHAUwjpvm26tzByOcHnph0YoU8eWe5EIArYg3/oJuDhOQ7nvhLU2ISS4kZZsIcPTf4ec2KT2TXZgqaa2q/H7lBqp7D7TYnvqrfIxHPIkAnW/0lW0K8SLQCOQ66MCYaSPIkvhW0bj/pt+poryXpqdb9Z3eUr8=
Received: from OSAPR01MB2737.jpnprd01.prod.outlook.com (2603:1096:603:38::21)
 by OSAPR01MB1763.jpnprd01.prod.outlook.com (2603:1096:603:31::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Mon, 1 Mar
 2021 16:19:26 +0000
Received: from OSAPR01MB2737.jpnprd01.prod.outlook.com
 ([fe80::4d2d:3155:768e:50e0]) by OSAPR01MB2737.jpnprd01.prod.outlook.com
 ([fe80::4d2d:3155:768e:50e0%7]) with mapi id 15.20.3890.028; Mon, 1 Mar 2021
 16:19:25 +0000
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
Subject: RE: [PATCH 4/7] misc: Add driver for DAB IP found on Renesas R-Car
 devices
Thread-Topic: [PATCH 4/7] misc: Add driver for DAB IP found on Renesas R-Car
 devices
Thread-Index: AQHXC8kAUgvuEwTuE0CHH++Hj25LCKpqLYcAgAUWp7A=
Date:   Mon, 1 Mar 2021 16:19:25 +0000
Message-ID: <OSAPR01MB2737942444EC65E89A1F5FC9C29A9@OSAPR01MB2737.jpnprd01.prod.outlook.com>
References: <20210225225147.29920-1-fabrizio.castro.jz@renesas.com>
 <20210225225147.29920-5-fabrizio.castro.jz@renesas.com>
 <CAMuHMdU1uTy_smaZGDcpRnDEUgKn-EYdpqEwP1qTN1=P5M073w@mail.gmail.com>
In-Reply-To: <CAMuHMdU1uTy_smaZGDcpRnDEUgKn-EYdpqEwP1qTN1=P5M073w@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linux-m68k.org; dkim=none (message not signed)
 header.d=none;linux-m68k.org; dmarc=none action=none header.from=renesas.com;
x-originating-ip: [2.28.163.123]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 83638a35-0cf9-49c2-9a25-08d8dccdc83e
x-ms-traffictypediagnostic: OSAPR01MB1763:
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <OSAPR01MB1763620C23CBC537076B8A0FC29A9@OSAPR01MB1763.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dPoJLucEZSG7p+le4chwLdHeajRIruZlqDLgmKtRTBpfJ+834goxprkky1sITyjAqf1Fvq6/4b5lrjrol8wI51GO7XFWIS2cA/WMm1trKQIhvjw86Sqh3IZl6RY7VsQQjvH6rHwUbyg8h5PjSyhbQqH9PvKOAUiRFKiTyTGDVM8tC+KchS3Xss5Bn3ALCO+BFaWJJh4ZYt1WbEf6wIqn55u+X+3oRbukKcav0FrvjStwtGtqBqocqb7IflgtJAvAKkzqK1F72tjS+c5LTY/Bo3T1GNH84A1oKmkwJ6+CUd81+9KfVvRRrWMEqgdZISSY1kQpJknYEz3AONc9sSFO4H5U1M767lsk3iZpx4srLZ3A/Em6Bb/Gul1ivuUxjk5LICikbXX2TpMDnJnaK0zKK3WiaXzWagBI+1/oEPgT6hODwNk2Se02FAzp/FunlFxsRdgeAkyEBEUXQn+bpqnLE/VSAeNfvroU0Pjw+xw3Hjrucm90bRdlN6FuPUdHJo2j90Y8WEPwyFyrT5TYwXDCjw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSAPR01MB2737.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(376002)(366004)(39860400002)(346002)(26005)(6916009)(2906002)(186003)(8676002)(83380400001)(30864003)(107886003)(7416002)(71200400001)(4326008)(316002)(54906003)(76116006)(6506007)(64756008)(55016002)(8936002)(33656002)(52536014)(66946007)(9686003)(53546011)(66446008)(5660300002)(66476007)(86362001)(7696005)(66556008)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?ZjhvMEQ3NjF4VFRnMVN1VmlCZEFJbGxyai9aK0lKZUFYV0F2b1V2SHhPdnBC?=
 =?utf-8?B?aGVha2QvdUFTQXp1T2pFZWREUkdQWHdpcmN0T1A0WTFoQWFKbHFyTW56cG1t?=
 =?utf-8?B?aFluQXNRdy8zNTYzQlNOdmtDZjgzMmJ5QzJZY0JpVmJyR21YU0RnclpYa2J0?=
 =?utf-8?B?Q0JINCtLdndVaUhzejliWUIwUE9BR1dEYlZhMjY0dit3bkhva2c1OXkzLzBD?=
 =?utf-8?B?T1BSQ1pkcXdYYkU4cm5tUTFXbTFXUzdacDViYm9iSjZyZm1xOUhsanFMVlJk?=
 =?utf-8?B?NlMvNTRhSVJMaFN6UG1UVU9kWEp6MUdZTDNQMkFkSHU3S3grdk9UbVlnOFZq?=
 =?utf-8?B?REhrVTE2T3BLYVdNUjFwbXNLRkxOcGRIaE5ra0dXd1dseEhQZVp1eFhhRVd0?=
 =?utf-8?B?REEwWEhnQTJHZStqUUo1MW4zM2p5VFZydUNveWsxei9qa29CcDBTa1VGb24v?=
 =?utf-8?B?YWV2Q0trVjI4dytjWUZKbm5yTkZvblpwZ09ibmpNNkNUNmREUFRDSFpoSVFB?=
 =?utf-8?B?djM3a1EzZlpZT1RPelIwRThpdElRdURJZDFzN2tpTFRTS2owb0NUSmNJOXdL?=
 =?utf-8?B?WmFqN01qbmVDdlgwa3g2dXVGaWNvcXErTUM5U3FNNWtRbWVpWGNiLzVER3Bh?=
 =?utf-8?B?UEduc0xlcUVkdDRsK2pvbVZtZFlSaUF2b083YWZYTFJSbk1DWEV5UkVyOURE?=
 =?utf-8?B?LzNTMDNTelNLSFZKcU9OWGh0cUs3K2Y4NDlTTTBjSFlTTWNqbEIvQ3lTTUpq?=
 =?utf-8?B?SXAvZHM0cTd4OXN1UGJiaGN4VXN2cWJ6cVFOWnhOTlVseW5xcWdEWHJMNEZO?=
 =?utf-8?B?aTkxZ01tdkRLSzA2TFliZE50SS9hbkRtVGdXbTVSQnlnaUFZQ2oyL2pPRlFY?=
 =?utf-8?B?NnR0cWZ1NE9HV0hFbnNlTWtmYS9mTFFoOFk1eGZnWVZpdHUrQURCZmVDQm9K?=
 =?utf-8?B?QUloYzR0cW1lUnRCdjVhVlhkTlBFODNQR0RGOXRBeEJWd0FIckNRVTI2SEVW?=
 =?utf-8?B?ZmdJSHByMThtTThPdmxaQ3ZiNXh6UTVPUTh6ZWUzSE5pVU0yRGRYaWFtNGlZ?=
 =?utf-8?B?ejVjQ045OUZaUHhaYmh2djNPcHZxakppR1UyNmRWU3I1aGpzUEtxM01pNFRl?=
 =?utf-8?B?L2JmQ1NtOE0zQ0pXWmV1YUY3b1ZPNkwzSDJ1ZjBqczZ0em5uYU9WSzh3dVZu?=
 =?utf-8?B?V21hRDBtV1hwb2tod0dEdm01eGtCUGd2aW03cmFlRVNCS1JMbVYvdXhRcVNZ?=
 =?utf-8?B?SXRULzJmUUpLUGNiUTIrZWlzc0djQ0JDUzRFUmVkdE9IZnVuZkF2RS9lYndG?=
 =?utf-8?B?TThsNXI3cEtsRVoweFBFbVEwVWpOUjU3d3A2Y2R0bVl1RmJKVkNFWWZqNjhu?=
 =?utf-8?B?Qk5CaGpuNWZ3SndFNDFPM1UzdmFiVzluajZxdDFvQmIzM05rcy9oZG1XN2lw?=
 =?utf-8?B?UXZ4c3FEbnhZNmJ2U3RjdDVzZ29NcThpMnhiT0RFOHQvb2xQd1FuMjJlRTc0?=
 =?utf-8?B?T3VmTWxST3BmYWlPdjhCblN5WlQxUTlVNndQTUNnVXYvRHFhYmpCVmZtS3ov?=
 =?utf-8?B?MnIvVkRTejlCdTY3VHBhREZBd2R1UGxKQmVab3lFRzllZ3ZqSzlhNmFaYnlv?=
 =?utf-8?B?MWw4aDgwbVpjdmZ2WkVGUjdyN1NQNGRzcEJiQzBZRGszMlNvMDJTUmpiTFR4?=
 =?utf-8?B?WGF1NEJWb2NBV1d0T3FLNVVITlFrK3dIRldkZk1GUHpwNkFEejJjNFlNVjBn?=
 =?utf-8?Q?YWsU46UGSPBlMHwnEOP7qping/PIv5eNJde4Khz?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSAPR01MB2737.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83638a35-0cf9-49c2-9a25-08d8dccdc83e
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2021 16:19:25.4170
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2aP8dGofWRI019Cwpl/8QYVhJ9Vy6fj0pwTp5z9JFfUqglgsfJhK98rzwIMOTvlbhMRnzWM33Gz5/g45nvPCVGa5cEhcUI+P41j7nxpVQeo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB1763
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

SGkgR2VlcnQsDQoNClRoYW5rcyBmb3IgeW91ciBmZWVkYmFjayENCg0KPiBGcm9tOiBHZWVydCBV
eXR0ZXJob2V2ZW4gPGdlZXJ0QGxpbnV4LW02OGsub3JnPg0KPiBTZW50OiAyNiBGZWJydWFyeSAy
MDIxIDA5OjM0DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggNC83XSBtaXNjOiBBZGQgZHJpdmVyIGZv
ciBEQUIgSVAgZm91bmQgb24gUmVuZXNhcyBSLQ0KPiBDYXIgZGV2aWNlcw0KPiANCj4gSGkgRmFi
cml6aW8sDQo+IA0KPiBPbiBUaHUsIEZlYiAyNSwgMjAyMSBhdCAxMTo1MyBQTSBGYWJyaXppbyBD
YXN0cm8NCj4gPGZhYnJpemlvLmNhc3Ryby5qekByZW5lc2FzLmNvbT4gd3JvdGU6DQo+ID4gVGhl
IERBQiBoYXJkd2FyZSBhY2NlbGVyYXRvciBmb3VuZCBvbiBSLUNhciBFMyBhbmQgUi1DYXIgTTMt
TiBkZXZpY2VzIGlzDQo+ID4gYSBoYXJkd2FyZSBhY2NlbGVyYXRvciBmb3Igc29mdHdhcmUgREFC
IGRlbW9kdWxhdG9ycy4NCj4gPiBJdCBjb25zaXN0cyBvZiBvbmUgRkZUIChGYXN0IEZvdXJpZXIg
VHJhbnNmb3JtKSBtb2R1bGUgYW5kIG9uZSBkZWNvZGVyDQo+ID4gbW9kdWxlLCBjb21wYXRpYmxl
IHdpdGggREFCIHNwZWNpZmljYXRpb24gKEVUU0kgRU4gMzAwIDQwMSBhbmQNCj4gPiBFVFNJIFRT
IDEwMiA1NjMpLg0KPiA+IFRoZSBkZWNvZGVyIG1vZHVsZSBjYW4gcGVyZm9ybSBGSUMgZGVjb2Rp
bmcgYW5kIE1TQyBkZWNvZGluZyBwcm9jZXNzaW5nDQo+ID4gZnJvbSBkZS1wdW5jdHVyZSB0byBm
aW5hbCBkZWNvZGVkIHJlc3VsdC4NCj4gPg0KPiA+IFRoaXMgcGF0Y2ggYWRkcyBhIGRldmljZSBk
cml2ZXIgdG8gc3VwcG9ydCB0aGUgRkZUIG1vZHVsZSBvbmx5Lg0KPiA+DQo+ID4gU2lnbmVkLW9m
Zi1ieTogRmFicml6aW8gQ2FzdHJvIDxmYWJyaXppby5jYXN0cm8uanpAcmVuZXNhcy5jb20+DQo+
IA0KPiBUaGFua3MgZm9yIHlvdXIgcGF0Y2ghDQo+IA0KPiA+IC0tLSBhL2RyaXZlcnMvbWlzYy9L
Y29uZmlnDQo+ID4gKysrIGIvZHJpdmVycy9taXNjL0tjb25maWcNCj4gPiBAQCAtNDYxLDQgKzQ2
MSw1IEBAIHNvdXJjZSAiZHJpdmVycy9taXNjL2JjbS12ay9LY29uZmlnIg0KPiA+ICBzb3VyY2Ug
ImRyaXZlcnMvbWlzYy9jYXJkcmVhZGVyL0tjb25maWciDQo+ID4gIHNvdXJjZSAiZHJpdmVycy9t
aXNjL2hhYmFuYWxhYnMvS2NvbmZpZyINCj4gPiAgc291cmNlICJkcml2ZXJzL21pc2MvdWFjY2Uv
S2NvbmZpZyINCj4gPiArc291cmNlICJkcml2ZXJzL21pc2MvcmNhcl9kYWIvS2NvbmZpZyINCj4g
DQo+IHJjYXItZGFiPw0KDQpJIHdpbGwgY2hhbmdlIHRoZSBkaXJlY3RvcnkgbmFtZQ0KDQo+IA0K
PiANCj4gPiAtLS0gL2Rldi9udWxsDQo+ID4gKysrIGIvZHJpdmVycy9taXNjL3JjYXJfZGFiL0tj
b25maWcNCj4gPiBAQCAtMCwwICsxLDExIEBADQo+ID4gKyMgU1BEWC1MaWNlbnNlLUlkZW50aWZp
ZXI6IEdQTC0yLjArDQo+ID4gKyMNCj4gPiArIyBSLUNhciBEQUIgSGFyZHdhcmUgQWNjZWxlcmF0
b3INCj4gPiArIw0KPiA+ICsNCj4gPiArY29uZmlnIFJDQVJfREFCDQo+IA0KPiBEQUJfUkNBUj8N
Cg0KQWdyZWVkDQoNCj4gDQo+ID4gKyAgICAgICB0cmlzdGF0ZSAiREFCIGFjY2VsZXJhdG9yIGZv
ciBSZW5lc2FzIFItQ2FyIGRldmljZXMiDQo+ID4gKyAgICAgICBkZXBlbmRzIG9uIEFSQ0hfUjhB
Nzc5OTAgfHwgQVJDSF9SOEE3Nzk2NQ0KPiANCj4gfHwgQ09NUElMRV9URVNUDQoNCldpbGwgZG8N
Cg0KPiANCj4gPiArICAgICAgIGhlbHANCj4gPiArICAgICAgICAgU29tZSBSLUNhciBkZXZpY2Vz
IGNvbWUgd2l0aCBhbiBJUCB0byBhY2NlbGVyYXRlIERBQiBkZWNvZGluZy4NCj4gPiArICAgICAg
ICAgRW5hYmxlIHRoaXMgb3B0aW9uIHRvIGFkZCBkcml2ZXIgc3VwcG9ydC4NCj4gDQo+ID4gLS0t
IC9kZXYvbnVsbA0KPiA+ICsrKyBiL2RyaXZlcnMvbWlzYy9yY2FyX2RhYi9yY2FyX2Rldi5jDQo+
ID4gQEAgLTAsMCArMSwxNzYgQEANCj4gPiArLy8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQ
TC0yLjArDQo+ID4gKy8qDQo+ID4gKyAqIFItQ2FyIEdlbjMgREFCIGhhcmR3YXJlIGFjY2VsZXJh
dG9yIGRyaXZlcg0KPiA+ICsgKg0KPiA+ICsgKiBDb3B5cmlnaHQgKEMpIDIwMjEgUmVuZXNhcyBF
bGVjdHJvbmljcyBDb3Jwb3JhdGlvbg0KPiA+ICsgKg0KPiA+ICsgKi8NCj4gPiArI2luY2x1ZGUg
PGxpbnV4L2Nsay5oPg0KPiA+ICsjaW5jbHVkZSA8bGludXgvaW50ZXJydXB0Lmg+DQo+ID4gKyNp
bmNsdWRlIDxsaW51eC9rZXJuZWwuaD4NCj4gPiArI2luY2x1ZGUgPGxpbnV4L21vZHVsZS5oPg0K
PiA+ICsjaW5jbHVkZSA8bGludXgvbXV0ZXguaD4NCj4gPiArI2luY2x1ZGUgPGxpbnV4L29mLmg+
DQo+ID4gKyNpbmNsdWRlIDxsaW51eC9wbGF0Zm9ybV9kZXZpY2UuaD4NCj4gPiArI2luY2x1ZGUg
PGxpbnV4L3VhY2Nlc3MuaD4NCj4gPiArDQo+ID4gKyNpbmNsdWRlIDx1YXBpL2xpbnV4L3JjYXJf
ZGFiLmg+DQo+ID4gKyNpbmNsdWRlICJyY2FyX2Rldi5oIg0KPiA+ICsNCj4gPiAraXJxcmV0dXJu
X3QgcmNhcl9kYWJfaXJxKGludCBpcnEsIHZvaWQgKmRldmlkKQ0KPiANCj4gc3RhdGljLCBhcyBk
aXNjb3ZlcmVkIGJ5IHRoZSByb2JvdC4NCg0KWWVwDQoNCj4gDQo+ID4gK3sNCj4gPiArICAgICAg
IHN0cnVjdCByY2FyX2RhYiAqZGFiID0gZGV2aWQ7DQo+ID4gKyAgICAgICB1MzIgaW50c3IsIGlu
dGNyMTsNCj4gPiArDQo+ID4gKyAgICAgICBzcGluX2xvY2soJmRhYi0+c2hhcmVkX3JlZ3NfbG9j
ayk7DQo+ID4gKw0KPiA+ICsgICAgICAgaW50Y3IxID0gcmNhcl9kYWJfcmVhZChkYWIsIFJDQVJf
REFCX0lOVENSMSk7DQo+ID4gKyAgICAgICByY2FyX2RhYl93cml0ZShkYWIsIFJDQVJfREFCX0lO
VENSMSwgMHgwMDAwMDNGRik7DQo+IA0KPiBNYWdpYyB2YWx1ZSAoc2V0dGluZyB1bmRvY3VtZW50
ZWQgYml0cz8pLCBwbGVhc2UgdXNlIGEgZGVmaW5lLg0KDQpUaGUgZG9jdW1lbnRhdGlvbiAoU2Vj
dGlvbiA0NEIuMi4yMSBvZiB0aGUgUi1DYXIgR2VuMyBIVyBVc2VyDQptYW51YWwpIHNheXMgdG8g
d3JpdGUgKHJlc2VydmVkKSBiaXRzIDMxIHRvIDEwIGFzIDAsIHRvIHdyaXRlDQoocmVzZXJ2ZWQp
IGJpdHMgOSB0byAzIGFzIDEsIGFuZCB0aGUgcmVtYWluaW5nIDMgYml0cyAoMiB0byAwKSwNCmFy
ZSBpbnRlcnJ1cHQgbWFza2luZyBiaXRzIHNldCB0byAxIGluIHRoaXMgY2FzZSB0byB0ZW1wb3Jh
cmlseQ0KZGlzYWJsZSBpbnRlcnJ1cHRzLg0KDQpJIGNhbiBvZiBjb3Vyc2UgYWRkIGEgZGVmaW5l
IGZvciB0aGlzLg0KDQo+IA0KPiA+ICsNCj4gPiArICAgICAgIGludHNyID0gcmNhcl9kYWJfcmVh
ZChkYWIsIFJDQVJfREFCX0lOVFNSKTsNCj4gPiArICAgICAgIGlmICghaW50c3IpIHsNCj4gPiAr
ICAgICAgICAgICAgICAgcmNhcl9kYWJfd3JpdGUoZGFiLCBSQ0FSX0RBQl9JTlRDUjEsIGludGNy
MSk7DQo+ID4gKyAgICAgICAgICAgICAgIHNwaW5fdW5sb2NrKCZkYWItPnNoYXJlZF9yZWdzX2xv
Y2spOw0KPiA+ICsgICAgICAgICAgICAgICByZXR1cm4gSVJRX05PTkU7DQo+ID4gKyAgICAgICB9
DQo+ID4gKw0KPiA+ICsgICAgICAgLyogUmUtZW5hYmxlIGludGVycnVwdHMgdGhhdCBoYXZlbid0
IGZpcmVkICovDQo+ID4gKyAgICAgICByY2FyX2RhYl93cml0ZShkYWIsIFJDQVJfREFCX0lOVENS
MSwgMHgzRkYgJiAoaW50c3IgfCBpbnRjcjEpKTsNCj4gPiArICAgICAgIC8qIENsZWFyIGludGVy
cnVwdHMgKi8NCj4gPiArICAgICAgIHJjYXJfZGFiX3dyaXRlKGRhYiwgUkNBUl9EQUJfSU5UU1Is
IDB4NyAmIH5pbnRzcik7DQo+IA0KPiBNb3JlIG1hZ2ljIHZhbHVlcy4NCg0KQXMgcGVyIHNlY3Rp
b24gNDRCLjIuMjAgZnJvbSB0aGUgUi1DYXIgR2VuMyBIVyBVc2VyIE1hbnVhbCwNCkJpdCAzMSB0
byAzIGFyZSByZXNlcnZlZCBhbmQgcmVhZHMgYW5kIHdyaXRlcyBhcyAwLCBhbmQgYQ0KMCBoYXMg
dG8gYmUgd3JpdHRlbiB0byBiaXRzIDIgdG8gMCB0byBjbGVhciB0aGUgaW50ZXJydXB0cy4NCg0K
SSB3aWxsIHVzZSBhIGRlZmluZSBmb3IgdGhpcyBhcyB3ZWxsLg0KDQo+IA0KPiA+ICsNCj4gPiAr
ICAgICAgIHNwaW5fdW5sb2NrKCZkYWItPnNoYXJlZF9yZWdzX2xvY2spOw0KPiA+ICsNCj4gPiAr
ICAgICAgIGlmIChpbnRzciAmIFJDQVJfREFCX0lOVFNSX0ZGVF9ET05FKQ0KPiA+ICsgICAgICAg
ICAgICAgICByY2FyX2RhYl9mZnRfaXJxKGRhYik7DQo+ID4gKw0KPiA+ICsgICAgICAgcmV0dXJu
IElSUV9IQU5ETEVEOw0KPiA+ICt9DQo+ID4gKw0KPiA+ICtzdGF0aWMgbG9uZyByY2FyX2RhYl91
bmxvY2tlZF9pb2N0bChzdHJ1Y3QgZmlsZSAqZmlsZSwgdW5zaWduZWQgaW50DQo+IGNtZCwNCj4g
PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1bnNpZ25lZCBsb25nIGFyZykN
Cj4gPiArew0KPiA+ICsgICAgICAgdm9pZCBfX3VzZXIgKmFyZ3AgPSAodm9pZCBfX3VzZXIgKilh
cmc7DQo+ID4gKyAgICAgICBzdHJ1Y3QgcmNhcl9kYWIgKmRhYjsNCj4gPiArICAgICAgIGludCBy
ZXQ7DQo+ID4gKw0KPiA+ICsgICAgICAgZGFiID0gY29udGFpbmVyX29mKGZpbGUtPnByaXZhdGVf
ZGF0YSwgc3RydWN0IHJjYXJfZGFiLCBtaXNjKTsNCj4gPiArDQo+ID4gKyAgICAgICBzd2l0Y2gg
KGNtZCkgew0KPiA+ICsgICAgICAgY2FzZSBSQ0FSX0RBQl9JT0NfRkZUOg0KPiA+ICsgICAgICAg
ICAgICAgICBpZiAoIWFjY2Vzc19vayhhcmdwLCBzaXplb2Yoc3RydWN0IHJjYXJfZGFiX2ZmdF9y
ZXEpKSkNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gLUVGQVVMVDsNCj4gPiAr
ICAgICAgICAgICAgICAgcmV0ID0gcmNhcl9kYWJfZmZ0KGRhYiwgYXJncCk7DQo+IA0KPiBEbyB5
b3UgZW52aXNpb24gZXZlciB1c2luZyB0aGUgRkZUIG9wZXJhdGlvbiBmcm9tIGtlcm5lbCBzcGFj
ZT8NCj4gTWlnaHQgYmUgZWFzaWVyIGlmIHlvdSBoYW5kbGUgdGhlIGNvcHlfe2Zyb20sdG99X3Vz
ZXIoKSBoZXJlLg0KDQpCdWZmZXJzIGFyZSBwcmUtYWxsb2NhdGVkIGFuZCBzaGFyZWQgYW1vbmcg
cmVxdWVzdHMsIHRoZXJlZm9yZSBhY2Nlc3MgdG8gdGhlDQpidWZmZXJzIGhhcyB0byBiZSBwcm90
ZWN0ZWQgd2l0aCBhIG11dGV4LiBUbyBrZWVwIHRoaW5ncyB0aWR5IChhbGwgRkZUIHJlbGF0ZWQN
CndvcmsgaW4gdGhlIEZGVCByZWxhdGVkIHNvdXJjZSBmaWxlKSBJIHByZWZlciB0byBrZWVwIHRo
aXMgYXMgaXQgaXMsIGFzIEZJQw0KYW5kIE1TQyB3aWxsIGFkZCBtb3JlIHRvIHRoZSBpb2N0bC4N
Cg0KPiANCj4gPiArICAgICAgICAgICAgICAgYnJlYWs7DQo+ID4gKyAgICAgICBkZWZhdWx0Og0K
PiA+ICsgICAgICAgICAgICAgICByZXQgPSAtRU5PVFRZOw0KPiA+ICsgICAgICAgfQ0KPiA+ICsN
Cj4gPiArICAgICAgIHJldHVybiByZXQ7DQo+ID4gK30NCj4gPiArDQo+ID4gK3N0YXRpYyBjb25z
dCBzdHJ1Y3QgZmlsZV9vcGVyYXRpb25zIHJjYXJfZGFiX2ZvcHMgPSB7DQo+ID4gKyAgICAgICAu
b3duZXIgICAgICAgICAgPSBUSElTX01PRFVMRSwNCj4gPiArICAgICAgIC51bmxvY2tlZF9pb2N0
bCA9IHJjYXJfZGFiX3VubG9ja2VkX2lvY3RsLA0KPiANCj4gRG9lcyB0aGlzIG5lZWQgY29tcGF0
X2lvY3RsIGhhbmRsaW5nPw0KDQpXaWxsIGFkZA0KDQo+IA0KPiA+ICt9Ow0KPiA+ICsNCj4gPiAr
c3RhdGljIGludCByY2FyX2RhYl9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0K
PiA+ICt7DQo+ID4gKyAgICAgICBzdHJ1Y3QgZGV2aWNlICpkZXYgPSAmcGRldi0+ZGV2Ow0KPiA+
ICsgICAgICAgc3RydWN0IHJjYXJfZGFiICpkYWI7DQo+ID4gKyAgICAgICBpbnQgcmV0LCBpcnE7
DQo+ID4gKw0KPiA+ICsgICAgICAgZGFiID0gZGV2bV9remFsbG9jKGRldiwgc2l6ZW9mKCpkYWIp
LCBHRlBfS0VSTkVMKTsNCj4gPiArICAgICAgIGlmICghZGFiKQ0KPiA+ICsgICAgICAgICAgICAg
ICByZXR1cm4gLUVOT01FTTsNCj4gPiArICAgICAgIGRhYi0+cGRldiA9IHBkZXY7DQo+ID4gKw0K
PiA+ICsgICAgICAgZGFiLT5iYXNlID0gZGV2bV9wbGF0Zm9ybV9pb3JlbWFwX3Jlc291cmNlKHBk
ZXYsIDApOw0KPiA+ICsgICAgICAgaWYgKElTX0VSUihkYWItPmJhc2UpKQ0KPiA+ICsgICAgICAg
ICAgICAgICByZXR1cm4gUFRSX0VSUihkYWItPmJhc2UpOw0KPiA+ICsNCj4gPiArICAgICAgIGly
cSA9IHBsYXRmb3JtX2dldF9pcnEocGRldiwgMCk7DQo+ID4gKyAgICAgICBpZiAoaXJxIDwgMCkg
ew0KPiA+ICsgICAgICAgICAgICAgICBkZXZfZXJyKGRldiwgIkNhbid0IGdldCB0aGUgaXJxLlxu
Iik7DQo+ID4gKyAgICAgICAgICAgICAgIHJldHVybiAtRUlOVkFMOw0KPiA+ICsgICAgICAgfQ0K
PiA+ICsNCj4gPiArICAgICAgIGRhYi0+Y2xrID0gZGV2bV9jbGtfZ2V0KCZwZGV2LT5kZXYsICJk
YWIiKTsNCj4gPiArICAgICAgIGlmIChJU19FUlIoZGFiLT5jbGspKSB7DQo+ID4gKyAgICAgICAg
ICAgICAgIHJldCA9IFBUUl9FUlIoZGFiLT5jbGspOw0KPiA+ICsgICAgICAgICAgICAgICBkZXZf
ZXJyKGRldiwgIkNhbid0IGdldCB0aGUgY2xvY2sgKCVkKS5cbiIsIHJldCk7DQo+ID4gKyAgICAg
ICAgICAgICAgIHJldHVybiByZXQ7DQo+ID4gKyAgICAgICB9DQo+ID4gKw0KPiA+ICsgICAgICAg
c3Bpbl9sb2NrX2luaXQoJmRhYi0+c2hhcmVkX3JlZ3NfbG9jayk7DQo+ID4gKw0KPiA+ICsgICAg
ICAgcmV0ID0gY2xrX3ByZXBhcmVfZW5hYmxlKGRhYi0+Y2xrKTsNCj4gDQo+IERvZXMgdGhlIG1v
ZHVsZSBjbG9jayBuZWVkIHRvIGJlIGVuYWJsZWQgYWxsIHRoZSB0aW1lPw0KDQpObywgaXQgZG9l
c24ndC4NCg0KPiBXaGF0IGFib3V0IHVzaW5nIFJ1bnRpbWUgUE0gaW5zdGVhZCBvZiBleHBsaWNp
dCBjbG9jayBoYW5kbGluZywgc28geW91cg0KPiBkcml2ZXIgd2lsbCBrZWVwIG9uIHdvcmtpbmcg
b24gZnV0dXJlIFNvQ3Mgd2hlcmUgdGhlIERBQiBibG9jayBpcyBwYXJ0IG9mDQo+IGEgcG93ZXIg
ZG9tYWluPw0KDQpDYW4gZG8sIHdpbGwgc3dpdGNoIHRvIHVzaW5nIFJ1bnRpbWUgUE0uDQoNCj4g
DQo+ID4gKyAgICAgICBpZiAocmV0KQ0KPiA+ICsgICAgICAgICAgICAgICByZXR1cm4gcmV0Ow0K
PiA+ICsNCj4gPiArICAgICAgIHJldCA9IHJjYXJfZGFiX2ZmdF9wcm9iZShkYWIpOw0KPiA+ICsg
ICAgICAgaWYgKHJldCkNCj4gPiArICAgICAgICAgICAgICAgZ290byBlcnJvcl9jbG9ja19kaXNh
YmxlOw0KPiA+ICsNCj4gPiArICAgICAgIHJldCA9IGRldm1fcmVxdWVzdF9pcnEoZGV2LCBpcnEs
IHJjYXJfZGFiX2lycSwgMCwgZGV2X25hbWUoZGV2KSwNCj4gZGFiKTsNCj4gPiArICAgICAgIGlm
IChyZXQpIHsNCj4gPiArICAgICAgICAgICAgICAgZGV2X2VycihkZXYsICJDYW4ndCByZXF1ZXN0
IHRoZSBpcnEgKCVkKS5cbiIsIHJldCk7DQo+ID4gKyAgICAgICAgICAgICAgIGdvdG8gZXJyb3Jf
cmVtb3ZlOw0KPiA+ICsgICAgICAgfQ0KPiA+ICsNCj4gPiArICAgICAgIHBsYXRmb3JtX3NldF9k
cnZkYXRhKHBkZXYsIGRhYik7DQo+ID4gKw0KPiA+ICsgICAgICAgZGFiLT5taXNjLm1pbm9yID0g
TUlTQ19EWU5BTUlDX01JTk9SOw0KPiA+ICsgICAgICAgZGFiLT5taXNjLm5hbWUgPSBSQ0FSX0RB
Ql9EUlZfTkFNRTsNCj4gPiArICAgICAgIGRhYi0+bWlzYy5mb3BzID0gJnJjYXJfZGFiX2ZvcHM7
DQo+ID4gKyAgICAgICByZXQgPSBtaXNjX3JlZ2lzdGVyKCZkYWItPm1pc2MpOw0KPiA+ICsgICAg
ICAgaWYgKHJldCkgew0KPiA+ICsgICAgICAgICAgICAgICBkZXZfZXJyKGRldiwgIkNhbid0IHJl
Z2lzdGVyIG1pc2MgZGV2aWNlICglZCkuXG4iLCByZXQpOw0KPiA+ICsgICAgICAgICAgICAgICBn
b3RvIGVycm9yX3JlbW92ZTsNCj4gPiArICAgICAgIH0NCj4gPiArDQo+ID4gKyAgICAgICBkZXZf
aW5mbyhkZXYsICJSLUNhciBHZW4zIERBQiBtaXNjIGRyaXZlciByZWFkeS5cbiIpOw0KPiA+ICsN
Cj4gPiArICAgICAgIHJldHVybiAwOw0KPiA+ICsNCj4gPiArZXJyb3JfcmVtb3ZlOg0KPiA+ICsg
ICAgICAgcmNhcl9kYWJfZmZ0X3JlbW92ZShkYWIpOw0KPiA+ICsNCj4gPiArZXJyb3JfY2xvY2tf
ZGlzYWJsZToNCj4gPiArICAgICAgIGNsa19kaXNhYmxlX3VucHJlcGFyZShkYWItPmNsayk7DQo+
ID4gKw0KPiA+ICsgICAgICAgcmV0dXJuIHJldDsNCj4gPiArfQ0KPiANCj4gPiAtLS0gL2Rldi9u
dWxsDQo+ID4gKysrIGIvZHJpdmVycy9taXNjL3JjYXJfZGFiL3JjYXJfZGV2LmgNCj4gDQo+ID4g
Ky8qIFJlZ2lzdGVyIERBQl9GRlRDUiAqLw0KPiA+ICsjZGVmaW5lIFJDQVJfREFCX0ZGVENSX0ZG
VF9FTl9ESVNBQkxFRCAgICAgICAgIDANCj4gPiArI2RlZmluZSBSQ0FSX0RBQl9GRlRDUl9GRlRf
RU5fRU5BQkxFRCAgICAgICAgICAxDQo+IA0KPiBEbyB5b3UgbmVlZCBib3RoPw0KDQpXZSBkb24n
dCwgSSBoYXZlIGp1c3QgdGhvdWdodCBpdCBtYWRlIHRoaW5ncyBjbGVhcmVyLg0KDQo+IA0KPiAj
ZGVmaW5lIFJDQVJfREFCX0ZGVENSX0ZGVF9FTiAgICAgICAgQklUKDApDQo+IA0KPiA+ICsNCj4g
PiArLyogUmVnaXN0ZXIgREFCX0ZGVFJFUUNSICovDQo+ID4gKyNkZWZpbmUgUkNBUl9EQUJfRkZU
UkVRQ1JfRkZUX1JFUV9JTkFDVElWRSAgICAgMA0KPiA+ICsjZGVmaW5lIFJDQVJfREFCX0ZGVFJF
UUNSX0ZGVF9SRVFfQUNUSVZFICAgICAgIDENCj4gDQo+IERvIHlvdSBuZWVkIGJvdGg/DQoNCldl
IGRvbid0LCBJIGhhdmUganVzdCB0aG91Z2h0IGl0IG1hZGUgdGhpbmdzIGNsZWFyZXIuDQoNCj4g
DQo+ID4gKw0KPiA+ICsvKiBSZWdpc3RlciBEQUJfSU5UU1IgKi8NCj4gPiArI2RlZmluZSBSQ0FS
X0RBQl9JTlRTUl9GRlRfRE9ORSAgICAgICAgICAgICAgICAgICAgICAgIDB4MQ0KPiANCj4gQklU
KDApICh0aGVyZSBhcmUgbW9yZSBiaXRzIGZvciBGSUMgYW5kIE1TQykNCg0KV2lsbCBjaGFuZ2UN
Cg0KPiANCj4gPiArDQo+ID4gKy8qIFJlZ2lzdGVyIERBQl9JTlRDUjEgKi8NCj4gPiArI2RlZmlu
ZSBSQ0FSX0RBQl9JTlRDUjFfRkZUX0RPTkVfTUFTSyAgICAgICAgICAweDENCj4gDQo+IEJJVCgw
KSAodGhlcmUgYXJlIG1vcmUgYml0cyBmb3IgRklDIGFuZCBNU0MpDQoNCldpbGwgY2hhbmdlDQoN
Cj4gDQo+ID4gKyNkZWZpbmUgUkNBUl9EQUJfSU5UQ1IxX0ZGVF9ET05FX0lOVF9FTkFCTEVEICAg
MA0KPiA+ICsjZGVmaW5lIFJDQVJfREFCX0lOVENSMV9GRlRfRE9ORV9JTlRfRElTQUJMRUQgIDEN
Cj4gDQo+IERvIHlvdSBuZWVkIHRoZXNlPw0KPiBJJ2QganVzdCByZXRhaW4gUkNBUl9EQUJfSU5U
Q1IxX0ZGVF9ET05FLg0KDQpBZ3JlZWQNCg0KPiANCj4gRm9yIGVuYWJsaW5nIGludGVycnVwdHM6
DQo+IA0KPiAgICAgcmNhcl9kYWJfdXBkYXRlX2JpdHNfbG9ja2VkKGRhYiwgUkNBUl9EQUJfSU5U
Q1IxLA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFJDQVJfREFCX0lOVENSMV9G
RlRfRE9ORSwNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBSQ0FSX0RBQl9JTlRD
UjFfRkZUX0RPTkUpOw0KPiANCj4gYW5kIGZvciBkaXNhYmxpbmc6DQo+IA0KPiAgICAgcmNhcl9k
YWJfdXBkYXRlX2JpdHNfbG9ja2VkKGRhYiwgUkNBUl9EQUJfSU5UQ1IxLA0KPiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIENBUl9EQUJfSU5UQ1IxX0ZGVF9ET05FLCAwKTsNCg0KT2th
eQ0KDQo+IA0KPiA+ICsNCj4gPiArc3RydWN0IHJjYXJfZGFiX2ZmdCB7DQo+ID4gKyAgICAgICBi
b29sIGRvbmU7ICAgICAgICAgICAgICAgICAgICAgIC8qDQo+ID4gKyAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAqIENvbmRpdGlvbiBmb3Igd2FraW5nIHVwIHRoZQ0KPiBw
cm9jZXNzDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAqIHNs
ZWVwaW5nIHdoaWxlIEZGVCBpcyBpbg0KPiBwcm9ncmVzcy4NCj4gPiArICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICovDQo+IA0KPiBQbGVhc2UgdXNlIGtlcm5lbGRvYyBm
b3IgZG9jdW1lbnRpbmcgc3RydWN0dXJlcy4NCg0KT2sNCg0KPiANCj4gPiArICAgICAgIHdhaXRf
cXVldWVfaGVhZF90IHdhaXQ7ICAgICAgICAgLyogV2FpdCBxdWV1ZSBmb3IgRkZULiAqLw0KPiA+
ICsgICAgICAgc3RydWN0IG11dGV4IGxvY2s7ICAgICAgICAgICAgICAvKiBNdXRleCBmb3IgRkZU
LiAqLw0KPiA+ICsgICAgICAgZG1hX2FkZHJfdCBkbWFfaW5wdXRfYnVmOyAgICAgICAvKg0KPiA+
ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKiBJbnB1dCBidWZmZXIg
c2VlbiBieSB0aGUgRkZUDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAqIG1vZHVsZS4NCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICovDQo+ID4gKyAgICAgICBkbWFfYWRkcl90IGRtYV9vdXRwdXRfYnVmOyAgICAgIC8qDQo+
ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAqIE91dHB1dCBidWZm
ZXIgc2VlbiBieSB0aGUgRkZUDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAqIG1vZHVsZS4NCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICovDQo+ID4gKyAgICAgICB2b2lkICppbnB1dF9idWZmZXI7ICAgICAgICAgICAgIC8q
IElucHV0IGJ1ZmZlciBzZWVuIGJ5IHRoZSBDUFUNCj4gKi8NCj4gPiArICAgICAgIHZvaWQgKm91
dHB1dF9idWZmZXI7ICAgICAgICAgICAgLyogT3V0cHV0IGJ1ZmZlciBzZWVuIGJ5IHRoZSBDUFUN
Cj4gKi8NCj4gDQo+IFBsZWFzZSB1c2UgY29uc2lzdGVudCBuYW1pbmcgKGJ1ZiB2cyBidWZmZXIp
Lg0KDQpPaw0KDQo+IA0KPiA+ICt9Ow0KPiANCj4gPiAtLS0gL2Rldi9udWxsDQo+ID4gKysrIGIv
ZHJpdmVycy9taXNjL3JjYXJfZGFiL3JjYXJfZmZ0LmMNCj4gDQo+ID4gK2ludCByY2FyX2RhYl9m
ZnQoc3RydWN0IHJjYXJfZGFiICpkYWIsIHN0cnVjdCByY2FyX2RhYl9mZnRfcmVxIF9fdXNlcg0K
PiAqZmZ0X3JlcSkNCj4gPiArew0KPiA+ICsgICAgICAgaW50IGJ1ZmZlcl9zaXplLCByZXQ7DQo+
ID4gKw0KPiA+ICsgICAgICAgYnVmZmVyX3NpemUgPSBmZnRfcmVxLT5wb2ludHMgKiA0Ow0KPiAN
Cj4gTWlzc2luZyB2YWxpZGF0aW9uIG9mIGJ1ZmZlcl9zaXplPw0KDQpXaWxsIGFkZA0KDQo+IA0K
PiA+ICsNCj4gPiArICAgICAgIG11dGV4X2xvY2soJmRhYi0+ZmZ0LmxvY2spOw0KPiA+ICsNCj4g
PiArICAgICAgIGlmIChjb3B5X2Zyb21fdXNlcihkYWItPmZmdC5pbnB1dF9idWZmZXIsIGZmdF9y
ZXEtDQo+ID5pbnB1dF9hZGRyZXNzLA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgIGJ1
ZmZlcl9zaXplKSkgew0KPiA+ICsgICAgICAgICAgICAgICBtdXRleF91bmxvY2soJmRhYi0+ZmZ0
LmxvY2spOw0KPiA+ICsgICAgICAgICAgICAgICByZXR1cm4gLUVGQVVMVDsNCj4gPiArICAgICAg
IH0NCj4gPiArDQo+ID4gKyAgICAgICBkYWItPmZmdC5kb25lID0gZmFsc2U7DQo+IA0KPiBZb3Ug
Y2FuIGluaXQgZG9uZSBpbiByY2FyX2RhYl9mZnRfaW5pdCgpLCB0b28uDQoNCldpbGwgbW92ZQ0K
DQo+IA0KPiA+ICsgICAgICAgcmV0ID0gcmNhcl9kYWJfZmZ0X2luaXQoZGFiLCBmZnRfcmVxKTsN
Cj4gPiArICAgICAgIGlmIChyZXQpIHsNCj4gPiArICAgICAgICAgICAgICAgbXV0ZXhfdW5sb2Nr
KCZkYWItPmZmdC5sb2NrKTsNCj4gPiArICAgICAgICAgICAgICAgcmV0dXJuIHJldDsNCj4gPiAr
ICAgICAgIH0NCj4gPiArDQo+ID4gKyAgICAgICByY2FyX2RhYl9mZnRfZW5hYmxlKGRhYik7DQo+
ID4gKyAgICAgICB3YWl0X2V2ZW50X2ludGVycnVwdGlibGVfdGltZW91dChkYWItPmZmdC53YWl0
LCBkYWItPmZmdC5kb25lLA0KPiBIWik7DQo+ID4gKyAgICAgICBpZiAoIWRhYi0+ZmZ0LmRvbmUp
IHsNCj4gDQo+IFlvdSBjYW4ganVzdCBjaGVjayB0aGUgcmV0dXJuIHZhbHVlIG9mIHdhaXRfZXZl
bnRfaW50ZXJydXB0aWJsZV90aW1lb3V0KCkuDQoNCldpbGwgY2hhbmdlDQoNCj4gDQo+ID4gKyAg
ICAgICAgICAgICAgIHJjYXJfZGFiX2ZmdF9kaXNhYmxlKGRhYik7DQo+ID4gKyAgICAgICAgICAg
ICAgIHJldCA9IC1FRkFVTFQ7DQo+IA0KPiAtRVRJTUVPVVQ/DQoNClllYWgsIGJldHRlciwgdGhh
bmtzDQoNCj4gDQo+ID4gKyAgICAgICB9IGVsc2UgaWYgKGNvcHlfdG9fdXNlcihmZnRfcmVxLT5v
dXRwdXRfYWRkcmVzcywgZGFiLQ0KPiA+ZmZ0Lm91dHB1dF9idWZmZXIsDQo+ID4gKyAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBidWZmZXJfc2l6ZSkpIHsNCj4gPiArICAgICAgICAgICAg
ICAgcmV0ID0gLUVGQVVMVDsNCj4gPiArICAgICAgIH0NCj4gPiArDQo+ID4gKyAgICAgICBtdXRl
eF91bmxvY2soJmRhYi0+ZmZ0LmxvY2spOw0KPiA+ICsNCj4gPiArICAgICAgIHJldHVybiByZXQ7
DQo+ID4gK30NCj4gDQo+ID4gLS0tIC9kZXYvbnVsbA0KPiA+ICsrKyBiL2luY2x1ZGUvdWFwaS9s
aW51eC9yY2FyX2RhYi5oDQo+ID4gQEAgLTAsMCArMSwzNSBAQA0KPiA+ICsvKiBTUERYLUxpY2Vu
c2UtSWRlbnRpZmllcjogR1BMLTIuMCsgV0lUSCBMaW51eC1zeXNjYWxsLW5vdGUgKi8NCj4gPiAr
LyoNCj4gPiArICogUi1DYXIgR2VuMyBEQUIgdXNlciBzcGFjZSBpbnRlcmZhY2UgZGF0YSBzdHJ1
Y3R1cmVzDQo+ID4gKyAqDQo+ID4gKyAqIENvcHlyaWdodCAoQykgMjAyMSBSZW5lc2FzIEVsZWN0
cm9uaWNzIENvcnBvcmF0aW9uDQo+ID4gKyAqDQo+ID4gKyAqLw0KPiA+ICsjaWZuZGVmIF9SQ0FS
X0RBQl9IXw0KPiA+ICsjZGVmaW5lIF9SQ0FSX0RBQl9IXw0KPiA+ICsNCj4gPiArc3RydWN0IHJj
YXJfZGFiX2ZmdF9yZXEgew0KPiA+ICsgICAgICAgaW50IHBvaW50czsgICAgICAgICAgICAgICAg
ICAgICAvKg0KPiANCj4gdW5zaWduZWQgaW50DQoNCldpbGwgY2hhbmdlDQoNCj4gDQo+ID4gKyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAqIFRoZSBudW1iZXIgb2YgcG9p
bnRzIHRvIHVzZS4NCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICogTGVnYWwgdmFsdWVzIGFyZSAyNTYsIDUxMiwNCj4gMTAyNCwgYW5kDQo+ID4gKyAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAqIDIwNDguDQo+ID4gKyAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAqLw0KPiANCj4gUGxlYXNlIHVzZSBrZXJuZWxk
b2MgdG8gZG9jdW1lbnQgc3RydWN0IG1lbWJlcnMuDQoNCk9rDQoNCj4gDQo+ID4gKyAgICAgICB1
bnNpZ25lZCBjaGFyIG9mZG1fbnVtYmVyOyAgICAgIC8qDQo+ID4gKyAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAqIE9ydGhvZ29uYWwgRnJlcXVlbmN5IERpdmlzaW9uDQo+
ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAqIE11bHRpcGxleGlu
ZyAoT0ZETSkuDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAq
IE1pbmltdW0gdmFsdWUgaXMgMSwgbWF4aW11bQ0KPiB2YWx1ZSBpcw0KPiA+ICsgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKiAyNTUuDQo+ID4gKyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAqLw0KPiANCj4gUGxlYXNlIG1ha2UgcGFkZGluZyBl
eHBsaWNpdC4NCg0KT2theQ0KDQo+IEknZCBhbHNvIHNvcnQgdGhlIG1lbWJlcnMgYnkgZGVjcmVh
c2luZyBzaXplLCBpLmUuIHBvaW50ZXJzIGZpcnN0Lg0KDQpPa2F5DQoNCj4gDQo+ID4gKyAgICAg
ICB2b2lkIF9fdXNlciAqaW5wdXRfYWRkcmVzczsgICAgIC8qDQo+IA0KPiBpbnB1dF9idWY/DQoN
ClN1cmUNCg0KPiANCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICogVXNlciBzcGFjZSBhZGRyZXNzIGZvciB0aGUNCj4gaW5wdXQNCj4gPiArICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICogYnVmZmVyLg0KPiA+ICsgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgKi8NCj4gPiArICAgICAgIHZvaWQgX191c2VyICpv
dXRwdXRfYWRkcmVzczsgICAgLyoNCj4gDQo+IG91dHB1dF9idWY/DQoNClN1cmUNCg0KPiANCj4g
PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICogVXNlciBzcGFjZSBh
ZGRyZXNzIGZvciB0aGUNCj4gb3V0cHV0DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAqIGJ1ZmZlci4NCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICovDQo+ID4gK307DQo+ID4gKw0KPiA+ICsjZGVmaW5lICAgICAgICBSQ0FS
X0RBQl9JT0NfRkZUICAgICAgICAgICAgICAgIF9JT1dSKDB4OTAsIDEsIHN0cnVjdA0KPiByY2Fy
X2RhYl9mZnRfcmVxICopDQo+ID4gKw0KPiA+ICsjZW5kaWYgLyogX1JDQVJfREFCX0hfICovDQoN
ClRoYW5rcywNCkZhYg0KDQo+IA0KPiBHcntvZXRqZSxlZXRpbmd9cywNCj4gDQo+ICAgICAgICAg
ICAgICAgICAgICAgICAgIEdlZXJ0DQo+IA0KPiAtLQ0KPiBHZWVydCBVeXR0ZXJob2V2ZW4gLS0g
VGhlcmUncyBsb3RzIG9mIExpbnV4IGJleW9uZCBpYTMyIC0tIGdlZXJ0QGxpbnV4LQ0KPiBtNjhr
Lm9yZw0KPiANCj4gSW4gcGVyc29uYWwgY29udmVyc2F0aW9ucyB3aXRoIHRlY2huaWNhbCBwZW9w
bGUsIEkgY2FsbCBteXNlbGYgYSBoYWNrZXIuDQo+IEJ1dA0KPiB3aGVuIEknbSB0YWxraW5nIHRv
IGpvdXJuYWxpc3RzIEkganVzdCBzYXkgInByb2dyYW1tZXIiIG9yIHNvbWV0aGluZyBsaWtlDQo+
IHRoYXQuDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgLS0gTGludXMgVG9ydmFs
ZHMNCg==

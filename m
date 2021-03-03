Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32C5032C669
	for <lists+linux-api@lfdr.de>; Thu,  4 Mar 2021 02:02:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446884AbhCDA2p (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 3 Mar 2021 19:28:45 -0500
Received: from mail-eopbgr1410103.outbound.protection.outlook.com ([40.107.141.103]:21344
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1842984AbhCCKXZ (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 3 Mar 2021 05:23:25 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ABtEpaWKTftcwExwenDPqRmnlqFtAYpaF8E0w3OHBAr4BA/Zn9wK7FzyACLEt37kIeLzTOQKZCgp7X5veACzgItDtaZ950qOlpmyE39sP2nAZ+kIGGBv9BXEmSz3wuboIdTX4ANvZBUvliB6VeH4OtrAh7SrMBd92VCcuf9wbrhHaJGq/HCR6NQWRo4+iUg1HPPA8ouljIfs6gg8MDR2pNS6Ycgpv3FwdSdEyUBwuvogd7MrDt7RiXvhktQixgLBt79FfjFgu64KcQJjutbAavjVDzRvSzPFNvP2doUdAj+CFPG4Byjqe5Aw8Cfk1vWdHZtlUVk4svzxo0MQ7p91Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+/mcDZ1ad1Fep9hsa2k2rPEy2X0f58Cqkq3oyFW8dUM=;
 b=DpuCQ/chaEQMmxgymhfPWaqgIRiilnUP0sKJuC1BIqdCqIScgL++flFdCdpR4nZF7odQZsuwZi3e6hhBJZsFmE0HxtpvKFFMooS9Gz+yLGDjph3HxIhmhRJTmc5VheTe8kGC0LGEo1IgcpXdcMwSw/css/26zWNZ6yArub7v8ZajjI5TS4opGD742KoXO1qTjsbzoFDVl33r/ItdomvFeX0My5it+iilEc+EePWq5su0UxmaPFLrbJrDOpKFEJoz0p5qb9IWftXK5eAQjHX8/2M+AlfyxwUREM7HDq9bEi6fOSo0ItdY9NKi0Z2yec0lMjdW+Iaj4TXYoLROPl3thA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+/mcDZ1ad1Fep9hsa2k2rPEy2X0f58Cqkq3oyFW8dUM=;
 b=VXASfUrLa3v5IkM84GBXk0xSaN4UoG/OTfLCN2nbGq8yQYknbuypwWTAZamvxSYwGo67HK7U67o0L0Ol3ndnjfgitEPzgX9zuX1Jm4t/g6rMAzYZfN5YzAYHnfadjtFQmqi/Ky3Snw+S9FSyU8uPNmStriK3oJa0UznHx/+7TD8=
Received: from OSAPR01MB2737.jpnprd01.prod.outlook.com (2603:1096:603:38::21)
 by OSAPR01MB2195.jpnprd01.prod.outlook.com (2603:1096:603:1a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Wed, 3 Mar
 2021 10:22:34 +0000
Received: from OSAPR01MB2737.jpnprd01.prod.outlook.com
 ([fe80::4d2d:3155:768e:50e0]) by OSAPR01MB2737.jpnprd01.prod.outlook.com
 ([fe80::4d2d:3155:768e:50e0%7]) with mapi id 15.20.3890.030; Wed, 3 Mar 2021
 10:22:34 +0000
From:   Fabrizio Castro <fabrizio.castro.jz@renesas.com>
To:     Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
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
Subject: RE: [PATCH 1/7] clk: renesas: r8a77990: Add DAB clock
Thread-Topic: [PATCH 1/7] clk: renesas: r8a77990: Add DAB clock
Thread-Index: AQHXC8j1zeRZ+zJn+kesHeuyQY+PTapqHN+AgAUeS2CAAts/oA==
Date:   Wed, 3 Mar 2021 10:22:34 +0000
Message-ID: <OSAPR01MB27379B9046FB5B4F4214B0E2C2989@OSAPR01MB2737.jpnprd01.prod.outlook.com>
References: <20210225225147.29920-1-fabrizio.castro.jz@renesas.com>
 <20210225225147.29920-2-fabrizio.castro.jz@renesas.com>
 <CAMuHMdX4gn2ganKyq89LNW8uV==AX9efy9+DSYJUyv-pC=qv9w@mail.gmail.com>
 <OSAPR01MB27376625ABDAEDA41BA00E5CC29A9@OSAPR01MB2737.jpnprd01.prod.outlook.com>
In-Reply-To: <OSAPR01MB27376625ABDAEDA41BA00E5CC29A9@OSAPR01MB2737.jpnprd01.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: renesas.com; dkim=none (message not signed)
 header.d=none;renesas.com; dmarc=none action=none header.from=renesas.com;
x-originating-ip: [2.28.163.123]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: bf5717bb-9ea4-4876-cdab-08d8de2e42c8
x-ms-traffictypediagnostic: OSAPR01MB2195:
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <OSAPR01MB219579E798EB7F9792580E1BC2989@OSAPR01MB2195.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Xai7vCYpA8gQDnOMStvriTsgchoUd+QnwtoYde95Zz4tkc/v6/xxyIT1aOAeAepHTjCSZ1l28WGqos1A6YVWGz4k9Yg5GxGy7OqukR/9JKmt4s6B9F8kMyMpjH7rPiZ/mBput0FqGsjuMbkg6uSCLuovJoSBK0a6IRyqHoqMcn5CtgaOw140p4MEyzfdQfolohdgBc5RDC6W64Uiawojqjudqyr0L2VyhKauOlExSlBZZ+JO5x70yhFhFUJSZeDjmf/XUyPs1VuNpm3UUZ7wp3JcLE+iiq9r4hMj2kUu0D9mOIKLYUYxaesoMng6j039ax47yPaE8ZWrGx+za5mTQ7iWafJKWT182Km7nEhBhUERpwAJCJT1Ss5yFq6AMmqVr8Y9cgxEv1GD4N9JxngPgTGBlW1o9NI0RWjG5j3G0b4CK7k1ayIi+cyVxEr4rYQAKRK+zHo+MwQakKqqjKT6H3FXrlVlFt9KmEjxyKtkLEVMrE7B0cZKEuGpW1TisgQ1FJZnbxHkLH4EZ67N4tHDJg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSAPR01MB2737.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(376002)(396003)(366004)(39860400002)(186003)(7416002)(26005)(478600001)(6506007)(8936002)(71200400001)(7696005)(8676002)(53546011)(2906002)(52536014)(66946007)(66556008)(316002)(66476007)(83380400001)(33656002)(9686003)(54906003)(110136005)(55016002)(5660300002)(107886003)(86362001)(4326008)(64756008)(76116006)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?Um5xc0FkeCt4WEJ2Zi81M0RMaFUzbjR1MW5IT1NGWWMxdUx2TDRDVCtQVzV0?=
 =?utf-8?B?NW9aTW91K1h5Vzc2amsrR2hGV1NONUh1dks5VWtJSmZlRnFwd1QyNmZuOUtw?=
 =?utf-8?B?d09xYUtDbVdzQTJtTTVvK3c1cjhrQzBCV1RvM1Yvdm8zemp4ZFV4bmVRcFIx?=
 =?utf-8?B?R3ozNlpmRGRCam9XckJyODkwRVhkUXBVcGtkZEtKZjMrenM3SlhTOXErTy9v?=
 =?utf-8?B?azVkSjlhVFZEMlEzaFp6OFJjTFhxdlVGQTh0bWp2Ujl0S2NmbEJKc2JwVzZs?=
 =?utf-8?B?ODVONlRBemRFMkp3bkJCaW16bVF5NkRrVWJ1ZlNBUG01OTlpWXlwNnVFRmY1?=
 =?utf-8?B?ZnpkZHZ2bDlNRGJiZDY3WXRVRktxbGpHeTNETllOVDVDcFhvaEdseDJzVTRM?=
 =?utf-8?B?TTB6ODRSbElTUWlJT1Z3ajUyMUY3Sm1MTytKMFFnVzBOMXJmb2RSMGFCejhl?=
 =?utf-8?B?ZTJLN0syczI3SEMzUk5JSmJjd1JFSkxTNFFJVkxTc0U4a2pweUtpMUh3RTVN?=
 =?utf-8?B?aklnSU5jY2E1eXQxNGVGTHMyTnRKVFZBQmJZdDFaQWxpK0RuSkZwUlVISjht?=
 =?utf-8?B?cmZHTU5JdFQvV28xUzQ3cVZqRTJVY3NzUWM3WklrK0w2cVVBdjdNK3lLZFJB?=
 =?utf-8?B?ZkR4a1VVbzNuWjcvc09Kdjk0UEFvR2tULzc1dUdleFYvamRXUjJZSE1UWG4r?=
 =?utf-8?B?ZzNmTWRrYk5TcEVaVU43cDdxaXJmNm1mZ3VBR25PZGpnTktXenE5WWZVbDl2?=
 =?utf-8?B?WFE1V01MUHlkbW9PWExrUkwyNGxjdVdBNXorRUZJQ3lkZ1RHTklLQStHUUpY?=
 =?utf-8?B?NFdUYVVtTEhuZnd3MktwOHp1K2Rub3VweHhvNk9wU1I4VlQ5UU9ybG5QZ20v?=
 =?utf-8?B?UVZkOEdjYVFzQW1PcHJzQ2x4c0FydFowQSt2ci9EQll4UktsN2w4L2FHZ0sv?=
 =?utf-8?B?SXNsSElHQ00rVWs4dXJJVVlFL2dFcnVDbjV4NmpNOUVaVmR0V2NLcnJLR09N?=
 =?utf-8?B?cytUYzZVTnc2VDZqdVFZbnVxL1R1dk9aNnFrTFJ4RElHdXZLYTNjYm4vY1Iz?=
 =?utf-8?B?cXM0bkdTU1hpVTdmbS9tdnpzbXo2bWtDWkQ2dVBxSHdyOW4waEY0eUtHbSsr?=
 =?utf-8?B?OXZ2TXlUY0pEb2ZaNitmOVV1S2ZMWUNLREJpeXVucm5zZ3JqK1JBVUw3bUNq?=
 =?utf-8?B?NXV5NmlOSThyNjFKYzJ4Z1dFTmdSQnZOYXR4Tm91VVNzZjdpUEJva2Z0WTlT?=
 =?utf-8?B?ZDFEa05NTGRJclJzdHZBUXE3S3J3ZVllT3Y2b3hwYm1rdk9Fd3lMU3YvNHJ0?=
 =?utf-8?B?T3gzTWhPZ0R1dGNnYVc2c2h1cmQxbGFBUkpqUGh6SjhCYm9JU3N5aHJPMEFx?=
 =?utf-8?B?RlpqV0dpZ1ZqK2U2MVVBTi9mdkhEMlkzMHphR25zNlVpQ0J0RzdENVBHQXgw?=
 =?utf-8?B?MXZnaFBkUG5hMlJxdVhSbE1QZ2V4aUJWSFhqSjlQMWtTOEdBSFgyS004TFFu?=
 =?utf-8?B?K2FYa1NaZjVOOWpEczNTcHpkL01VV241VzZaUjJ2dGdrOHBETzZRNVNLdGdM?=
 =?utf-8?B?RzI0WU02UW1uY3RqczNndFpYWkoxSFJ6dllPU0ZnRGJvZXdDZTVqSlpXcXBi?=
 =?utf-8?B?TzNRNlZ0ampYdUMwYTVFM1lCN2lpU0Z4RDlka2xTSDVGWktpcjQxVjRGVk1R?=
 =?utf-8?B?SFpqUlZTNE1zZU01Qnd3R2J3UzFnSk83WkxDUGVjNlZYblhKcmFGZzJEVjFx?=
 =?utf-8?Q?d6GP9w4DoMpi0Aj1kQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSAPR01MB2737.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf5717bb-9ea4-4876-cdab-08d8de2e42c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2021 10:22:34.1104
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q5H3qtYXKJ5aTjuuy9mGTz9rjApCS6MEABMPitM0zH1X2RBCpAyo314+Zkhf8msOvtdfoAhpfP54yxkqVew3dFT3qJIZMFrnOEO1AvKrgNc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB2195
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

SGkgR2VlcnQsDQoNCj4gRnJvbTogRmFicml6aW8gQ2FzdHJvIDxmYWJyaXppby5jYXN0cm8uanpA
cmVuZXNhcy5jb20+DQo+IFNlbnQ6IDAxIE1hcmNoIDIwMjEgMTQ6NDcNCj4gU3ViamVjdDogUkU6
IFtQQVRDSCAxLzddIGNsazogcmVuZXNhczogcjhhNzc5OTA6IEFkZCBEQUIgY2xvY2sNCj4gDQo+
IEhpIEdlZXJ0LA0KPiANCj4gVGhhbmtzIGZvciB5b3VyIGZlZWRiYWNrIQ0KPiANCj4gPiBGcm9t
OiBHZWVydCBVeXR0ZXJob2V2ZW4gPGdlZXJ0QGxpbnV4LW02OGsub3JnPg0KPiA+IFNlbnQ6IDI2
IEZlYnJ1YXJ5IDIwMjEgMDg6MzUNCj4gPiBTdWJqZWN0OiBSZTogW1BBVENIIDEvN10gY2xrOiBy
ZW5lc2FzOiByOGE3Nzk5MDogQWRkIERBQiBjbG9jaw0KPiA+DQo+ID4gSGkgRmFicml6aW8sDQo+
ID4NCj4gPiBPbiBUaHUsIEZlYiAyNSwgMjAyMSBhdCAxMTo1MiBQTSBGYWJyaXppbyBDYXN0cm8N
Cj4gPiA8ZmFicml6aW8uY2FzdHJvLmp6QHJlbmVzYXMuY29tPiB3cm90ZToNCj4gPiA+IFRoaXMg
cGF0Y2ggYWRkcyB0aGUgREFCIGNsb2NrIHRvIHRoZSBSOEE3Nzk5MCBTb0MuDQo+ID4gPg0KPiA+
ID4gU2lnbmVkLW9mZi1ieTogRmFicml6aW8gQ2FzdHJvIDxmYWJyaXppby5jYXN0cm8uanpAcmVu
ZXNhcy5jb20+DQo+ID4NCj4gPiBUaGFua3MgZm9yIHlvdXIgcGF0Y2ghDQo+ID4NCj4gPiA+IC0t
LSBhL2RyaXZlcnMvY2xrL3JlbmVzYXMvcjhhNzc5OTAtY3BnLW1zc3IuYw0KPiA+ID4gKysrIGIv
ZHJpdmVycy9jbGsvcmVuZXNhcy9yOGE3Nzk5MC1jcGctbXNzci5jDQo+ID4gPiBAQCAtMjMyLDYg
KzIzMiw3IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgbXNzcl9tb2RfY2xrDQo+IHI4YTc3OTkwX21v
ZF9jbGtzW10NCj4gPiBfX2luaXRjb25zdCA9IHsNCj4gPiA+ICAgICAgICAgREVGX01PRCgic3Np
MiIsICAgICAgICAgICAgICAgICAxMDEzLCAgIE1PRF9DTEtfSUQoMTAwNSkpLA0KPiA+ID4gICAg
ICAgICBERUZfTU9EKCJzc2kxIiwgICAgICAgICAgICAgICAgIDEwMTQsICAgTU9EX0NMS19JRCgx
MDA1KSksDQo+ID4gPiAgICAgICAgIERFRl9NT0QoInNzaTAiLCAgICAgICAgICAgICAgICAgMTAx
NSwgICBNT0RfQ0xLX0lEKDEwMDUpKSwNCj4gPiA+ICsgICAgICAgREVGX01PRCgiZGFiIiwgICAg
ICAgICAgICAgICAgICAxMDE2LCAgIFI4QTc3OTkwX0NMS19TM0QxKSwNCj4gPg0KPiA+IFVuZm9y
dHVuYXRlbHkgdGhpcyBiaXQgaXMgbm90IGRvY3VtZW50ZWQgaW4gdGhlIFItQ2FyIEdlbjMgSGFy
ZHdhcmUNCj4gPiBVc2VyJ3MgTWFudWFsLCBzbyBJIGhhdmUgdG8gdHJ1c3QgeW91IG9uIHRoaXMu
DQo+IA0KPiBZZWFoLCB1bmZvcnR1bmF0ZWx5IHRoZXJlIGlzIG5vIG9mZmljaWFsIGRvY3VtZW50
IHdpdGggdGhpcyBpbmZvcm1hdGlvbg0KPiBhcyBvZiB5ZXQuDQoNCkkgdGhpbmsgdGhpcyBwYXRj
aCBpcyB3b3J0aCB0YWtpbmcuDQoNClRoYW5rcywNCkZhYg0KDQo+IA0KPiBDaGVlcnMsDQo+IEZh
Yg0KPiANCj4gPg0KPiA+ID4gICAgICAgICBERUZfTU9EKCJzY3UtYWxsIiwgICAgICAgICAgICAg
IDEwMTcsICAgUjhBNzc5OTBfQ0xLX1MzRDQpLA0KPiA+ID4gICAgICAgICBERUZfTU9EKCJzY3Ut
ZHZjMSIsICAgICAgICAgICAgIDEwMTgsICAgTU9EX0NMS19JRCgxMDE3KSksDQo+ID4gPiAgICAg
ICAgIERFRl9NT0QoInNjdS1kdmMwIiwgICAgICAgICAgICAgMTAxOSwgICBNT0RfQ0xLX0lEKDEw
MTcpKSwNCj4gPg0KPiA+IEdye29ldGplLGVldGluZ31zLA0KPiA+DQo+ID4gICAgICAgICAgICAg
ICAgICAgICAgICAgR2VlcnQNCj4gPg0KPiA+IC0tDQo+ID4gR2VlcnQgVXl0dGVyaG9ldmVuIC0t
IFRoZXJlJ3MgbG90cyBvZiBMaW51eCBiZXlvbmQgaWEzMiAtLSBnZWVydEBsaW51eC0NCj4gPiBt
NjhrLm9yZw0KPiA+DQo+ID4gSW4gcGVyc29uYWwgY29udmVyc2F0aW9ucyB3aXRoIHRlY2huaWNh
bCBwZW9wbGUsIEkgY2FsbCBteXNlbGYgYSBoYWNrZXIuDQo+ID4gQnV0DQo+ID4gd2hlbiBJJ20g
dGFsa2luZyB0byBqb3VybmFsaXN0cyBJIGp1c3Qgc2F5ICJwcm9ncmFtbWVyIiBvciBzb21ldGhp
bmcNCj4gbGlrZQ0KPiA+IHRoYXQuDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAtLSBMaW51cyBUb3J2YWxkcw0K

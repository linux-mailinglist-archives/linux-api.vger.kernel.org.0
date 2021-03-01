Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A96C328148
	for <lists+linux-api@lfdr.de>; Mon,  1 Mar 2021 15:49:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236546AbhCAOrz (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 1 Mar 2021 09:47:55 -0500
Received: from mail-eopbgr1410121.outbound.protection.outlook.com ([40.107.141.121]:7992
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236445AbhCAOrw (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Mon, 1 Mar 2021 09:47:52 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ca0B0aqfI2OtggX25KlV/8m1Mm5umM9V+SxTUt9SnUxeVfvzIBqWEwZohM//BBBhZedtNa6LG2TE/E63ss8HYr7LNyDVp25207dSY7xoP5EWr+oWoMh7yLMzq2gUtP/Rw5ViRB6Y2I5k429hMSD30duuIVfl0xDsHaexFzt7SYNIQ88sXqVVX32Dm8+y5+zvrZW0jmpS6wsHs4CdcYtO/2aoUyYSoBmzvi5WiE+1zpYJGyo9Ccin23rJgEm71EG01V3P/Z76ie2B7iy6NyFY0AhcHEwPMrQNKI4iVDwvM2+bsC4c6pz4+zNWevorHkXrGkE5X9bJbnMMB6XJXBCRYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8bfCCZ3BdiPUnBREhxDRLuAj+pV55897GASMKTItDgk=;
 b=CHroQD8G2LT2wY/uPPTbGChomG3iyZWlgJgny5xnSxwCpProozlI6QtK29Cy5jOvOiWq1IZkRgP+HfKuBZgcc/DF+uCAg0OfL/OFtiBOQrrmipLBxxhNsSJYLpV9QtD+ILusyQXSTZE7NLRGVXJMKn9BdQD/KiGDiJ8mN+Fku/HfwtETIQiy7Q9jCh8RooWIoVuQoquaBWQ/GeETNGHeBuxYBeGGzqzH2W+SQx4G7amHf+rtrsUXMVJWmwlAt+GM/FgHfoPOKYhHf8BJ8qRKN1y/5tMbjwPDWjDWtBIjEGedfBOVBlRXf8R9N8iND0P2GYb6CEfsLkqSZanhZ+zs4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8bfCCZ3BdiPUnBREhxDRLuAj+pV55897GASMKTItDgk=;
 b=fAC+2rOjsYEr/qoiZn3tO3DkTezmEf7T0jXAzhNcAVrLj45K/kKwwvPd6gpg8SeKgyTGguDU9dHRL+3CLHEBaes1tlfiX1ezJ/A4iCPOkvrd2PbmUXBvDi6KVdaE/pxrOU6Dmrj38QJKpuXnz06HztSihaQOmpF2L0z2Jpfg1IM=
Received: from OSAPR01MB2737.jpnprd01.prod.outlook.com (2603:1096:603:38::21)
 by OSBPR01MB4421.jpnprd01.prod.outlook.com (2603:1096:604:74::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Mon, 1 Mar
 2021 14:47:01 +0000
Received: from OSAPR01MB2737.jpnprd01.prod.outlook.com
 ([fe80::4d2d:3155:768e:50e0]) by OSAPR01MB2737.jpnprd01.prod.outlook.com
 ([fe80::4d2d:3155:768e:50e0%7]) with mapi id 15.20.3890.028; Mon, 1 Mar 2021
 14:47:01 +0000
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
Subject: RE: [PATCH 1/7] clk: renesas: r8a77990: Add DAB clock
Thread-Topic: [PATCH 1/7] clk: renesas: r8a77990: Add DAB clock
Thread-Index: AQHXC8j1zeRZ+zJn+kesHeuyQY+PTapqHN+AgAUeS2A=
Date:   Mon, 1 Mar 2021 14:47:01 +0000
Message-ID: <OSAPR01MB27376625ABDAEDA41BA00E5CC29A9@OSAPR01MB2737.jpnprd01.prod.outlook.com>
References: <20210225225147.29920-1-fabrizio.castro.jz@renesas.com>
 <20210225225147.29920-2-fabrizio.castro.jz@renesas.com>
 <CAMuHMdX4gn2ganKyq89LNW8uV==AX9efy9+DSYJUyv-pC=qv9w@mail.gmail.com>
In-Reply-To: <CAMuHMdX4gn2ganKyq89LNW8uV==AX9efy9+DSYJUyv-pC=qv9w@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linux-m68k.org; dkim=none (message not signed)
 header.d=none;linux-m68k.org; dmarc=none action=none header.from=renesas.com;
x-originating-ip: [2.28.163.123]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 50fd3260-2e01-4b71-bfd8-08d8dcc0df81
x-ms-traffictypediagnostic: OSBPR01MB4421:
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <OSBPR01MB4421F8B56AD389F694230F55C29A9@OSBPR01MB4421.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jPvE9L5OqhAtZ2qnHRxNREzNQOQCdRbFESBQjWZCI/ACVV7m5y6KkYHH75Nqq8KuxVFGy65AMNtbIfbna0V/HD6dpSJUTYKW+5rq8u3/S/PzgI+P4YFmYhw7dq6Ngz87Ga+nByavRyB2LPcCtydi2h6H3cR4f9ZEOIq9SIqLPnFPhFYUpCLo3aFMD3tJ1U519l1vqEOguMbiCRqICvSgygEEyIrK7x0OrqAUco3ze4VZ3WW5KcdzgdLXL3hvqsRCWfMJl+Pq02d0ASNIma19O0iTh44gH2L/dgq5xPkheOWdoF+PEOvJc+qga+65c/y76jEwf8QfS9o7aCKNwOWcAXQjKv9WnC3R90iRcoUwogMqpprw7HSht5zim6C1aqGLbuZXKI3MZ2eIiSBvBsS47hzYme3+ZMIIwX3TMa1Ic2l+f9iyWbNWRqFlTFsrfjfzjb5TgH774wXKJa1FwwXB0IbtggyQUaOoIgg1Z1DYxQRHpLOYR/jRs5yB118vqGNa6JcpsSL7LnOTnrBAykAl8A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSAPR01MB2737.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39860400002)(366004)(136003)(346002)(376002)(8936002)(64756008)(8676002)(66446008)(66476007)(76116006)(33656002)(66946007)(52536014)(5660300002)(6506007)(26005)(53546011)(478600001)(66556008)(55016002)(186003)(4326008)(7696005)(2906002)(316002)(6916009)(9686003)(54906003)(7416002)(107886003)(86362001)(71200400001)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?QW9mRkZSb2k3YzlHaVR4b1NFMFZ5amtIVUhBMmxjd1lFSHdKR1hicTI2WTVG?=
 =?utf-8?B?K1B0Q1IzV1NpMU5XeFUzamNsUVowSWlpZWJoTWhLeDBUKzNtOXVLSGZZV3Ey?=
 =?utf-8?B?YjhRZW4zQ3NYbkpFUzkzL25hZ09lNVN3T0JhcEtQUTNQOU90T1dMcXV0Um1Z?=
 =?utf-8?B?Y1g2SDJsNGV6RVR0dUd4WWw1anlpbXZNUTAwUDRPRmUyYmpnWnV6VGducmN0?=
 =?utf-8?B?U3JiMFVLWkF0dHNjSFBzM3JNM3cxQkRGMHR3NkRrUG9uaTU1TmdFRGRmVGk1?=
 =?utf-8?B?MHVKejNXWHlYczUwdFZLWGg2Mi8vMHNCd21ZUDJIWDI1RElvRzZKQ2dmN2Rx?=
 =?utf-8?B?aVRycHkxRlgya1JmeE5rQyszdlExdW9WeFFwcmlLVjBWTFIySE1oQmRVeTdl?=
 =?utf-8?B?OE9WOHRlSlVocjhjM1AyV3MxaDJiZEdlLzBIckxTZkM2emlxSDlydUxJaXpF?=
 =?utf-8?B?OUdGaEhjUGc2MnNBZ0pwb1hic0tmMVZKNU1IL1EwWWIxb3BRTy9XUVJtZDF6?=
 =?utf-8?B?cFAvTUh5aUVZdnlVSHpRWmRtdS9vT04zRlUva21lZkZZcFBBMG5WVkIwa1Nu?=
 =?utf-8?B?bWNXT1d2QWYzSDBtd09xZFpCRmpXVit1eUJiVVFpRjhWNUVOT2xOWGtrdW5y?=
 =?utf-8?B?VkZJMS9wcDRCQVBUc29wSkorUkVPcVFuT1kzd3FBVXN3dmpWZWY3NmluYXFI?=
 =?utf-8?B?TUJYY2dsOWI0TW9zY2VYZVBhUk8zK1BndHhmWFdYdG5KVzZZZGsrZUpTMHNs?=
 =?utf-8?B?MHhScmkrZTlhdzJ4akx4SXBGSGtKc3N1MGVHOEdiVG5SUkxzMUN4NStXeE1i?=
 =?utf-8?B?U1FwUlhUNU0zY0xzdXpPUk02YnAwZTEvVDJWaFpLVW1YQ2xtWEcxKzAxbTli?=
 =?utf-8?B?SU91L1RDQmw5NFlJK1czbkIrQXk2M1N4dGdGdEFyaVZPb0VwdWZHcDJqWlgv?=
 =?utf-8?B?aG9oSURDdHBaSjZjbXFmU25MVkErYUtHbkpMRFZXVVFmd21aeVJFVy9NWWFq?=
 =?utf-8?B?UnUyWHpKUWxhcDhNYkkyM3pMUXlYc0tQVkhWN3lGSzlrWk51c0hKZFJXOHFp?=
 =?utf-8?B?SWdvSis2THFINWdLUFM4Yk5NMjJPdnNwMW5sdm0vUlM1QXJLcTNKYjFkYlZ1?=
 =?utf-8?B?N1d1TWdVRHFESE85MUp4WTZCNFk4UkFNaVpFU09leDNwK1krSHpaQVk2NTk4?=
 =?utf-8?B?YmZzYlBpSnVTaVVmYXdsZWZldjlGWEIrU1ZXbDhaRDFYTS9ibVNmMjkzd0Ez?=
 =?utf-8?B?S1dpSCtnOC9PSzhrS242aXRxZG41R3drOUJEaHlYTVhpU3RpRFhCTHJ1Z0F3?=
 =?utf-8?B?STdrdVhVdGp0RGRKSFo0YW8wTVl0TXlUc2prZVFIWVNyenRLTW4vODhML1Yz?=
 =?utf-8?B?NTY3aS9wa2VTVllJYmtBRWsyUFdtdUsyUjRTV3Z5Y2xoSDRzc3Q2ZFlMRk9B?=
 =?utf-8?B?OEVrUitxS0JxUVdYUHpJU1JNSTkvZDdUeUNtMW84cmw1OEx5TmRSTUVJeU1N?=
 =?utf-8?B?WG9pNXl1ZktTamVFR3l4OUFBRG9YYmgvR1NYNWV2RlBMcUQreXlDc3hJaFFr?=
 =?utf-8?B?cy82bU1ZVCtJQ0ZTN3dtbTQrQ0wvR1J5TVN0d096TWlwU05RV0RKZkpKZ3RW?=
 =?utf-8?B?TXZCdmtuSGxCZ0F3Uk00VGFuckp6YXJSblUvWEpMMW1BMHNKTkNFZmQ3UTM4?=
 =?utf-8?B?SkhLQzJBbDMxalBsdzdFa1BoSG5TWHBoamlCRkttSmdmcG5ySS9GTzB2V2M4?=
 =?utf-8?Q?ZIdg5Ds4n9VBI9GCAc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSAPR01MB2737.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50fd3260-2e01-4b71-bfd8-08d8dcc0df81
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2021 14:47:01.2970
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eft7N/suhbQIXfyvWfadSTE6gAB4y7dAXZrkiUwLF0taWMF54OPMznZhtN/h7ZxFvqwOgesjeGiiJJIGybr9XqOde7TkQ0p+Np5FiXoP0bA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB4421
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

SGkgR2VlcnQsDQoNClRoYW5rcyBmb3IgeW91ciBmZWVkYmFjayENCg0KPiBGcm9tOiBHZWVydCBV
eXR0ZXJob2V2ZW4gPGdlZXJ0QGxpbnV4LW02OGsub3JnPg0KPiBTZW50OiAyNiBGZWJydWFyeSAy
MDIxIDA4OjM1DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMS83XSBjbGs6IHJlbmVzYXM6IHI4YTc3
OTkwOiBBZGQgREFCIGNsb2NrDQo+IA0KPiBIaSBGYWJyaXppbywNCj4gDQo+IE9uIFRodSwgRmVi
IDI1LCAyMDIxIGF0IDExOjUyIFBNIEZhYnJpemlvIENhc3Rybw0KPiA8ZmFicml6aW8uY2FzdHJv
Lmp6QHJlbmVzYXMuY29tPiB3cm90ZToNCj4gPiBUaGlzIHBhdGNoIGFkZHMgdGhlIERBQiBjbG9j
ayB0byB0aGUgUjhBNzc5OTAgU29DLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogRmFicml6aW8g
Q2FzdHJvIDxmYWJyaXppby5jYXN0cm8uanpAcmVuZXNhcy5jb20+DQo+IA0KPiBUaGFua3MgZm9y
IHlvdXIgcGF0Y2ghDQo+IA0KPiA+IC0tLSBhL2RyaXZlcnMvY2xrL3JlbmVzYXMvcjhhNzc5OTAt
Y3BnLW1zc3IuYw0KPiA+ICsrKyBiL2RyaXZlcnMvY2xrL3JlbmVzYXMvcjhhNzc5OTAtY3BnLW1z
c3IuYw0KPiA+IEBAIC0yMzIsNiArMjMyLDcgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBtc3NyX21v
ZF9jbGsgcjhhNzc5OTBfbW9kX2Nsa3NbXQ0KPiBfX2luaXRjb25zdCA9IHsNCj4gPiAgICAgICAg
IERFRl9NT0QoInNzaTIiLCAgICAgICAgICAgICAgICAgMTAxMywgICBNT0RfQ0xLX0lEKDEwMDUp
KSwNCj4gPiAgICAgICAgIERFRl9NT0QoInNzaTEiLCAgICAgICAgICAgICAgICAgMTAxNCwgICBN
T0RfQ0xLX0lEKDEwMDUpKSwNCj4gPiAgICAgICAgIERFRl9NT0QoInNzaTAiLCAgICAgICAgICAg
ICAgICAgMTAxNSwgICBNT0RfQ0xLX0lEKDEwMDUpKSwNCj4gPiArICAgICAgIERFRl9NT0QoImRh
YiIsICAgICAgICAgICAgICAgICAgMTAxNiwgICBSOEE3Nzk5MF9DTEtfUzNEMSksDQo+IA0KPiBV
bmZvcnR1bmF0ZWx5IHRoaXMgYml0IGlzIG5vdCBkb2N1bWVudGVkIGluIHRoZSBSLUNhciBHZW4z
IEhhcmR3YXJlDQo+IFVzZXIncyBNYW51YWwsIHNvIEkgaGF2ZSB0byB0cnVzdCB5b3Ugb24gdGhp
cy4NCg0KWWVhaCwgdW5mb3J0dW5hdGVseSB0aGVyZSBpcyBubyBvZmZpY2lhbCBkb2N1bWVudCB3
aXRoIHRoaXMgaW5mb3JtYXRpb24NCmFzIG9mIHlldC4NCg0KQ2hlZXJzLA0KRmFiDQoNCj4gDQo+
ID4gICAgICAgICBERUZfTU9EKCJzY3UtYWxsIiwgICAgICAgICAgICAgIDEwMTcsICAgUjhBNzc5
OTBfQ0xLX1MzRDQpLA0KPiA+ICAgICAgICAgREVGX01PRCgic2N1LWR2YzEiLCAgICAgICAgICAg
ICAxMDE4LCAgIE1PRF9DTEtfSUQoMTAxNykpLA0KPiA+ICAgICAgICAgREVGX01PRCgic2N1LWR2
YzAiLCAgICAgICAgICAgICAxMDE5LCAgIE1PRF9DTEtfSUQoMTAxNykpLA0KPiANCj4gR3J7b2V0
amUsZWV0aW5nfXMsDQo+IA0KPiAgICAgICAgICAgICAgICAgICAgICAgICBHZWVydA0KPiANCj4g
LS0NCj4gR2VlcnQgVXl0dGVyaG9ldmVuIC0tIFRoZXJlJ3MgbG90cyBvZiBMaW51eCBiZXlvbmQg
aWEzMiAtLSBnZWVydEBsaW51eC0NCj4gbTY4ay5vcmcNCj4gDQo+IEluIHBlcnNvbmFsIGNvbnZl
cnNhdGlvbnMgd2l0aCB0ZWNobmljYWwgcGVvcGxlLCBJIGNhbGwgbXlzZWxmIGEgaGFja2VyLg0K
PiBCdXQNCj4gd2hlbiBJJ20gdGFsa2luZyB0byBqb3VybmFsaXN0cyBJIGp1c3Qgc2F5ICJwcm9n
cmFtbWVyIiBvciBzb21ldGhpbmcgbGlrZQ0KPiB0aGF0Lg0KPiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIC0tIExpbnVzIFRvcnZhbGRzDQo=

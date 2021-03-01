Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B202328182
	for <lists+linux-api@lfdr.de>; Mon,  1 Mar 2021 15:56:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236709AbhCAOzz (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 1 Mar 2021 09:55:55 -0500
Received: from mail-eopbgr1400094.outbound.protection.outlook.com ([40.107.140.94]:5517
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236700AbhCAOzr (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Mon, 1 Mar 2021 09:55:47 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PdbgDnZ2uWyEnFbqWInHE2rmn4LzE8e070LbZWhMzIVGvHUDp+oYP5g1L2Q44LVxeKyCTiORXiGatLn9Ng32FyC2C6HRE9ZZ67yUUoXmujZqKZJsD/Og+faJi4rkEdAGmf6WL8xfG3PtPywVVFWHTgCkFPHuv3Ar/2QsD7Kz18W0jqu0ES6x73AzGyRroJGYztJQTAluwfnq6RLpe5GJOFy6DUzIyud6+8YbsDCw2mq236npl3AMihvusW1mew7j4uhKnUAPEcK/k/SIe2icCtqEn5GmPr5UAz1ziRX05lorOx6JAnPWAVYd5d2WypmL1H+a54VpWsP3n3FqIgIR4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ehpf6JVjWak+oRRCI4okz1LZteH8QN1y75NJCzsSLw4=;
 b=YQbe3yiHX71XudWTdsv9WWreKpeGjAHTPGdpU8itagLrypdFvQW6RHo98UWECha7MGwvdr0ljaecd7FAwglVPBxVZYtv7bh6iamV/EqNo5VL8igSWzPSpMKVUzQSdQAVUZHAE77xM2DwZskuwdy9WIu/xCCsKcJ+dvDkfnrTPfiKamRXSMeOOqwVAjoFDmfKlPguPxOSZraJgkCS13ytvp68d7Vqo3A4v4OmuPFCpW/567lBstbwLLMrB7bmhEaoU0Kr2jV8kh/gY+D/ceTSuQHBHj0t9IUfSDV9Z9YSHs+pdWRKOadhreiaDF2jPjY+xiPoQ4OFJTaex4a7+m81Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ehpf6JVjWak+oRRCI4okz1LZteH8QN1y75NJCzsSLw4=;
 b=Xvj/kuPJ9AZCX6URvZQIHaw3nMOsh2fh+oh/HPrO/vDu4BMoTPG2I6dabZuOlDw9+jsLNv2SqoNYE9wkSdGYGFv3rgKoPWaH5MoIOTQ27AgyFGQ4WQtbqY1UoNcTNat1UMZEIC7oIarvZbogrMYhWXNngmm/Zeq49RGULxxxHy4=
Received: from OSAPR01MB2737.jpnprd01.prod.outlook.com (2603:1096:603:38::21)
 by OSAPR01MB3905.jpnprd01.prod.outlook.com (2603:1096:604:5f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.25; Mon, 1 Mar
 2021 14:55:18 +0000
Received: from OSAPR01MB2737.jpnprd01.prod.outlook.com
 ([fe80::4d2d:3155:768e:50e0]) by OSAPR01MB2737.jpnprd01.prod.outlook.com
 ([fe80::4d2d:3155:768e:50e0%7]) with mapi id 15.20.3890.028; Mon, 1 Mar 2021
 14:55:18 +0000
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
Subject: RE: [PATCH 6/7] arm64: dts: renesas: r8a77965: Add DAB support
Thread-Topic: [PATCH 6/7] arm64: dts: renesas: r8a77965: Add DAB support
Thread-Index: AQHXC8kH6HUnpdoXVkeKsvkZkp6N1apqY5iAgATaYrA=
Date:   Mon, 1 Mar 2021 14:55:18 +0000
Message-ID: <OSAPR01MB2737A9717CDCF32674CF4AB6C29A9@OSAPR01MB2737.jpnprd01.prod.outlook.com>
References: <20210225225147.29920-1-fabrizio.castro.jz@renesas.com>
 <20210225225147.29920-7-fabrizio.castro.jz@renesas.com>
 <YDjt83Yri6jiEq6B@pendragon.ideasonboard.com>
In-Reply-To: <YDjt83Yri6jiEq6B@pendragon.ideasonboard.com>
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
x-ms-office365-filtering-correlation-id: fb6c39e2-4098-4fdc-e5a7-08d8dcc20804
x-ms-traffictypediagnostic: OSAPR01MB3905:
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <OSAPR01MB390591FB962A7338AAA8ACA1C29A9@OSAPR01MB3905.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FQ7XTCs6NlNYyrXMkrPlfLOeXPqgV0WIRx3majAevvlfCgklfKXvOHKpUkmtSqwkwF4/0Q/vIY29N4AXY0A8XRarORekf5AzWLPI5z9xs+u7jNq8x9o/NyyYmxhxT4d8dZTaxA14iGuu8i8BeIzRH8j2nR28h5Twm5k6R1g8xc2zubmGSIltzpqZM/CG2bFet2ZnD2f59witB5oJtzNHtf/JmKFSqFhkuq1ia6ApSmIY4DuBT7VLQtu/M60D41nAVs15tJ5M6UiCsO1x4bLCWpMCXq+kmo+bZVF9f/BmV7cNZ/8pn1zfUXxIKHSvd3x3QQBEKp9ddHT1ssUat4s72DTLeSaoR8QVzk7JcbcImb5hgDoJ7kUnZC4nm/at1Sl4KwvpZYR2Z05+t2quDt2B8LAOhTel4IoD8cfRsbY2+mjp1Cet8WS97xhBowwDpZljhVGXC1LZXwXsJPhcIO74JtADobBcZ6zigEiymguOwkRF5kiaI52cml1Sio7qtvdG2Uv/aSIci8ErK5/CPYSfPw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSAPR01MB2737.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(396003)(136003)(346002)(376002)(186003)(7696005)(55016002)(52536014)(4326008)(6506007)(71200400001)(7416002)(66946007)(9686003)(5660300002)(107886003)(26005)(53546011)(6916009)(316002)(83380400001)(54906003)(8676002)(2906002)(478600001)(76116006)(66556008)(64756008)(86362001)(8936002)(66476007)(33656002)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?RCthOFQxSzBpd2lHblI4TVpMZUhZWGl2Z0RMN1JxYS9SN2MrUlRZRjVpMWtw?=
 =?utf-8?B?cUxYVnNNYmNiRUtTdDZadGtmSnppcGl0YUtPTXUvTk1sbFZHUjhzSTVCaFBx?=
 =?utf-8?B?dmZzeXEvMllRODlaYVpLS2RNOUlrbldpOU03U3FoakFGczdJTzcxZ0U3cnhS?=
 =?utf-8?B?SXlOWGErVThoRHE0YytxY21mRXo3TkFJa0NEemlkNHkvc3pycWxzRUVMK25H?=
 =?utf-8?B?WlRoVzIxQ0k1V2t6TzFnb3FkUEIvWFR5WHRCMFZVVkg1bk1MMXovZk9BclJo?=
 =?utf-8?B?TXd2RWRyd3lXSTBwdHB0S1RPUUZtTkpHMG05aXFBSlFFT3hqR0d3SGtrRlJV?=
 =?utf-8?B?VWRhaXNJdWozOTk1b1B5UzVKU21reURBTU50dGREdzExckswV0ltTHdmTFBu?=
 =?utf-8?B?N0JaWTcyYXR1dytzY3hCbUF4OXE5M1FGYTBsZjJKdmdZQmk0bnd3QW9FdnBP?=
 =?utf-8?B?MUtEbDlnQkxXSDBJTlk3YWhQSEMwWTJ2UytQczF4N2FrUEo0bTlwT2oxM0lh?=
 =?utf-8?B?ZjBUTzdDRnRpQ21YdFRkQytVV1p0WlRLQWR5Nkxld1ZPT29RMnRlWndxQzNC?=
 =?utf-8?B?aElja3o3dHJvdUpkb1VjbDV6RDJQSXphb01LNmVIckkrYlIwNGFPalE4N0V4?=
 =?utf-8?B?bkowWms4bGVidXIweXhqc2hNWjdtSlZNdGF1aVdKVTdTMi9wTXlFbk45MjV3?=
 =?utf-8?B?Rzc4OEdpakVvTWlINkVHclNJK2tvUTc4by9RWU92OFNJc1Z4UDI0U2kxam5k?=
 =?utf-8?B?ajVwYmRWdkdVWUZkaHpvSDNyRU80UnpYbGdaUGhjUmZGTWVlWjAydDZtV08z?=
 =?utf-8?B?OU00ZGo4R1ZmOWN4b1Buai9xWVc3TDlFZFhLL0J6d1dCT0VlcTN3VkllbmdD?=
 =?utf-8?B?c3daeWc0d29EWWxkUEdCdmZFNnFVSmxFbUwzc3l1Y3ZhTy9aNkRobDZMMUJG?=
 =?utf-8?B?VExPbmQxMHdxV0FXYWc0aTlvb29GUkdwZ0RNdkZZZ0k4K0VHU1QwaXhyT2NX?=
 =?utf-8?B?U0xEdStSYWUxclNkeE5BOCtMUEdSdDU3WW9vU24wNVNJU2k0VHdFK0ZtVXBG?=
 =?utf-8?B?dEo1ZGdTM01QWWFSUmVqNXhPNWczSExidDU1YnZNMFlPcWNMdUhZUmJETGFo?=
 =?utf-8?B?R0Y4emFhQWdObkMyenM3NGhmeitFQXBqblhSR3gyMkgwMmUybDFjS1ZsUjVt?=
 =?utf-8?B?UUhSa2lLSEFrK3NqVHZJRTVmYVYzbGtFcEhxazVpVWlKTXZrZXc0Q1BuRUl6?=
 =?utf-8?B?cXlvUXZYZ3RLY1ZMVUx4dXZIakFZaHpKVnR3a240cXB6UHNFWWN6MmVuSkFa?=
 =?utf-8?B?MDc4dzZ4VXg0c2FtNHNGTDZkQmUvTXpVRkJWODUwU05LZ3ZvSDVZK01pQjUz?=
 =?utf-8?B?cnB2NDlRQmxEWFMxeU8vTGRWdGZMRHp5ZmNoUW9VM2k0UDk1YWF5SzlJMWg2?=
 =?utf-8?B?NzJKZUYybFVjNURQN2FHMmtEQzZFZ1k2aThIUmdGZTJTRDlsdWhxd0NpeEQx?=
 =?utf-8?B?VldtQnU2K0MxV24ybDVJek5hM2p4RksvaG5JZnk5RjRhOVRYVWc5T3ZhK1Fh?=
 =?utf-8?B?VlRjbGRIbnUxVFNvei8wck5XRnpTRTZSbnBYVTBWSVpTaG9mZWRKMTJRMStm?=
 =?utf-8?B?cXpkUWVTRldOVmRDaSthdG9hQms5WEduSjlTV3Q4MmNza1pWWjBaZy94S1Bw?=
 =?utf-8?B?RVBkNGdmaHh1K1JXUWNzZkNnUVZnTlpZZEFqaWlmYlA0YlFjNS8yUGxnYlVI?=
 =?utf-8?Q?P3vWXg2MCZbh/lqyG8TUN20FCa65tYcF7WQGDdV?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSAPR01MB2737.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb6c39e2-4098-4fdc-e5a7-08d8dcc20804
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2021 14:55:18.7570
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JytfRseKtoji/bOHIFeMGP6eZVTGPYuPc/xOxJd4DjyHXgLAxDqzys96V+oxGo5WW/UoKay+cZ46brgykvt+PHNDeLb6ryiVUVOkO41KJJ8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB3905
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

SGkgTGF1cmVudCwNCg0KVGhhbmtzIGZvciB5b3VyIGZlZWRiYWNrIQ0KDQo+IEZyb206IExhdXJl
bnQgUGluY2hhcnQgPGxhdXJlbnQucGluY2hhcnRAaWRlYXNvbmJvYXJkLmNvbT4NCj4gU2VudDog
MjYgRmVicnVhcnkgMjAyMSAxMjo0OA0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDYvN10gYXJtNjQ6
IGR0czogcmVuZXNhczogcjhhNzc5NjU6IEFkZCBEQUIgc3VwcG9ydA0KPiANCj4gSGkgRmFicml6
aW8sDQo+IA0KPiBUaGFuayB5b3UgZm9yIHRoZSBwYXRjaC4NCj4gDQo+IE9uIFRodSwgRmViIDI1
LCAyMDIxIGF0IDEwOjUxOjQ2UE0gKzAwMDAsIEZhYnJpemlvIENhc3RybyB3cm90ZToNCj4gPiBS
LUNhciBNMy1OIChhLmsuYS4gcjhhNzc5NjUpIGNvbWVzIHdpdGggdGhlIERBQiBoYXJkd2FyZSBh
Y2NlbGVyYXRvci4NCj4gPiBUaGlzIHBhdGNoIGFkZHMgU29DIHNwZWNpZmljIHN1cHBvcnQuDQo+
ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBGYWJyaXppbyBDYXN0cm8gPGZhYnJpemlvLmNhc3Ryby5q
ekByZW5lc2FzLmNvbT4NCj4gPiAtLS0NCj4gPiAgYXJjaC9hcm02NC9ib290L2R0cy9yZW5lc2Fz
L3I4YTc3OTY1LmR0c2kgfCAxMiArKysrKysrKysrKysNCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDEy
IGluc2VydGlvbnMoKykNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9hcmNoL2FybTY0L2Jvb3QvZHRz
L3JlbmVzYXMvcjhhNzc5NjUuZHRzaQ0KPiBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvcmVuZXNhcy9y
OGE3Nzk2NS5kdHNpDQo+ID4gaW5kZXggNjU3YjIwZDM1MzNiLi5iNjE3NmZkNWI3MDMgMTAwNjQ0
DQo+ID4gLS0tIGEvYXJjaC9hcm02NC9ib290L2R0cy9yZW5lc2FzL3I4YTc3OTY1LmR0c2kNCj4g
PiArKysgYi9hcmNoL2FybTY0L2Jvb3QvZHRzL3JlbmVzYXMvcjhhNzc5NjUuZHRzaQ0KPiA+IEBA
IC0xMDEzLDYgKzEwMTMsMTggQEAgaXBtbXVfdnAwOiBpb21tdUBmZTk5MDAwMCB7DQo+ID4gIAkJ
CSNpb21tdS1jZWxscyA9IDwxPjsNCj4gPiAgCQl9Ow0KPiA+DQo+ID4gKwkJZGFiOiBkYWJAZTY3
MzAwMDAgew0KPiA+ICsJCQljb21wYXRpYmxlID0gInJlbmVzYXMsZGFiLXI4YTc3OTY1IiwNCj4g
PiArCQkJCSAgICAgInJlbmVzYXMscmNhci1nZW4zLWRhYiI7DQo+ID4gKwkJCXJlZyA9IDwweDAw
IDB4ZTY3MzAwMDAgMHgwMCAweDEyMD47DQo+ID4gKwkJCWludGVycnVwdHMgPSA8R0lDX1NQSSAx
NjAgSVJRX1RZUEVfTEVWRUxfSElHSD47DQo+ID4gKwkJCWNsb2NrcyA9IDwmY3BnIENQR19NT0Qg
MTAxNj47DQo+ID4gKwkJCWNsb2NrLW5hbWVzID0gImRhYiI7DQo+ID4gKwkJCXBvd2VyLWRvbWFp
bnMgPSA8JnN5c2MgUjhBNzc5NjVfUERfQUxXQVlTX09OPjsNCj4gPiArCQkJcmVzZXRzID0gPCZj
cGcgMTAxNj47DQo+IA0KPiBTYW1lIGNvbW1lbnRzIGFzIGZvciByOGE3Nzk5MC4NCg0KSSB3aWxs
IHJldmlzZSBhY2NvcmRpbmdseSBmb3IgdjIuDQoNClRoYW5rcywNCkZhYg0KDQo+IA0KPiBSZXZp
ZXdlZC1ieTogTGF1cmVudCBQaW5jaGFydCA8bGF1cmVudC5waW5jaGFydEBpZGVhc29uYm9hcmQu
Y29tPg0KPiANCj4gPiArCQkJc3RhdHVzID0gImRpc2FibGVkIjsNCj4gPiArCQl9Ow0KPiA+ICsN
Cj4gPiAgCQlhdmI6IGV0aGVybmV0QGU2ODAwMDAwIHsNCj4gPiAgCQkJY29tcGF0aWJsZSA9ICJy
ZW5lc2FzLGV0aGVyYXZiLXI4YTc3OTY1IiwNCj4gPiAgCQkJCSAgICAgInJlbmVzYXMsZXRoZXJh
dmItcmNhci1nZW4zIjsNCj4gDQo+IC0tDQo+IFJlZ2FyZHMsDQo+IA0KPiBMYXVyZW50IFBpbmNo
YXJ0DQo=

Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B419F328176
	for <lists+linux-api@lfdr.de>; Mon,  1 Mar 2021 15:56:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236671AbhCAOyy (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 1 Mar 2021 09:54:54 -0500
Received: from mail-eopbgr1400094.outbound.protection.outlook.com ([40.107.140.94]:5517
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236607AbhCAOyM (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Mon, 1 Mar 2021 09:54:12 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l8aU9w4fyJSeVS9TXjaOw8MvrH3rKRSseidRBQNlS5LarLS5ka3spkVuzszAZQdHP1DUTwo+borI6qOv4kEX5VtEQKMktOSaw1zkXDv1dGdtd5IyPcx++uqFs21zO4Eq88ffKlS9eZlBE4EmU2IvZHG5QiFr1axAQVEjKAv0ywhfFwMKtV1H5Mpm7C2w+pA/bk1Nl2Boq3ltQM/xz+kHzEaRFBeFOujDIdrNIidRovS5w3rcaml8NFZIEh9HVOueZ71eJMIahIVJggorwTSurXE+TmISFbhKUdTZOaGV4nyAn7KA9KhhObGa8BYml8E6KJEp/Au8tzYEinM26qtebA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4bt8lOxaI7MLeXTditrg6oDUdEO5Bh6pgzCxwLCLU1Q=;
 b=H4bNKllPVyLN3aVqLZJ43lPIn+bIWXnVVZfYzFEwuA4k+JaBV6W7DoTofaKWgmJB4t2faIXuLQ8IDWpPgMj002IlHDc/r+U7wCpaiXrEPYspbFXhgCohU3qKD/Pdvsq+Chs/Mqv7TopM4+rjP45WntWZKcq9iBWXFtH0hhrAlUHMc6XprjUx3hmCsRb3olXxZvkj+aehjPUad8DOdAf6W0I3ItLrSffer5+lKS2rRfx+mZaeFQ2Ss/+HV5TFDPSlwJxWzhlB+s88TqdLXsJGlg+kbxqhnsZbgwfUWPs5hxLgW17S73hGoH5wAkltiFN26WlKL367JuDiMYxhqJvYnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4bt8lOxaI7MLeXTditrg6oDUdEO5Bh6pgzCxwLCLU1Q=;
 b=XheJxdJ5Ukrj6g+NxFO8GdDStoFqy0DlttqwQChu7kgs/QXXL3ag5s1Vr9+XoUieLUAtMtTCR0BsW+n6xC3A/nz81hsuDwXtEB6swuBbiLm+T38QP2K+bjBeJGBPCXsgqgc86CCBt1WtIZZspuu/H81KUMvPJisbkY3aNXedEQ0=
Received: from OSAPR01MB2737.jpnprd01.prod.outlook.com (2603:1096:603:38::21)
 by OSAPR01MB3905.jpnprd01.prod.outlook.com (2603:1096:604:5f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.25; Mon, 1 Mar
 2021 14:53:21 +0000
Received: from OSAPR01MB2737.jpnprd01.prod.outlook.com
 ([fe80::4d2d:3155:768e:50e0]) by OSAPR01MB2737.jpnprd01.prod.outlook.com
 ([fe80::4d2d:3155:768e:50e0%7]) with mapi id 15.20.3890.028; Mon, 1 Mar 2021
 14:53:21 +0000
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
Subject: RE: [PATCH 5/7] arm64: dts: renesas: r8a77990: Add DAB support
Thread-Topic: [PATCH 5/7] arm64: dts: renesas: r8a77990: Add DAB support
Thread-Index: AQHXC8kDG3KbJtXN00qk3+r5x4JlDapqY2aAgATZ5wA=
Date:   Mon, 1 Mar 2021 14:53:21 +0000
Message-ID: <OSAPR01MB27374198130C769D28398804C29A9@OSAPR01MB2737.jpnprd01.prod.outlook.com>
References: <20210225225147.29920-1-fabrizio.castro.jz@renesas.com>
 <20210225225147.29920-6-fabrizio.castro.jz@renesas.com>
 <YDjtyWUZ/rjskGGr@pendragon.ideasonboard.com>
In-Reply-To: <YDjtyWUZ/rjskGGr@pendragon.ideasonboard.com>
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
x-ms-office365-filtering-correlation-id: 5efa03da-d079-441c-bc91-08d8dcc1c217
x-ms-traffictypediagnostic: OSAPR01MB3905:
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <OSAPR01MB3905EE73C7A26A66A109EC28C29A9@OSAPR01MB3905.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cm5vbt+1Hbcfn9bXjmIdmLUuAakrIF1cflVN7CTOtZmfJlsX626SEP9Mh8bc3bQU8DOo+Dxcx7ElYY6cq9Q29X5WF9Wxh/viteQN0ur9dPETDxatCTNWPNyd5xjdWKAlz2bYNvhUQWh85TkPz/aDlxtnznUPrbuVsV+ikLBpq+nnX6onpafFZloounAh/rJrymGlxM3ThFWi8C2EEdrNCNvKa1w1TMq14ZcZkBa9r1AElgBHPRiYZo+ra+tXsWFuaSg/NdLcZ163DLLa9j8taXk9b4jBnhwHBG9oxMQ6RIKRDpCxcf9xhUHpNrMlK8Lnc9cQymqBlrY2k/30urrvPhUZX4cePbC6uSyZ+X5LBBiDxFGzIAvxV3Ac941J2RCbzNBhFBqDfx+7CeDZ7lyz0X8tZF5wArVXx51OuUaupK1Sb17CRzhoH5+jPzeurM41BFsNPNpU1JX0+F2ASw8owFxnL3VJSc9S0MgaGQvJT14Zfrk69UuALdpxCIZVc98+q1f5HCYdDAFvfF2UI5v8IA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSAPR01MB2737.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(396003)(136003)(346002)(376002)(186003)(7696005)(55016002)(52536014)(4326008)(6506007)(71200400001)(7416002)(66946007)(9686003)(5660300002)(107886003)(26005)(53546011)(6916009)(316002)(83380400001)(54906003)(8676002)(2906002)(478600001)(76116006)(66556008)(64756008)(86362001)(8936002)(66476007)(33656002)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?UGM4bjlVVjJNcGZrQW1ISGlRdVlTb0R1V2NVV2xzZVNHTmxnQjA0eHFzMWlu?=
 =?utf-8?B?YWtlb2hhQUM5UXZkYzBRN2hQRVRnR3hlNUdWSnFUaHRwRklZanZHQUNSR2Q5?=
 =?utf-8?B?cndVWFRWSDhUVjFSRVpGK3cyOW92anA0QnBVL05CclJ3UklxQmFGRWI1SHNS?=
 =?utf-8?B?NmNnaDZNM0NqMmc0YitaKzZtbGJUSzVNVU9xVU95ODdSS0RPeGR3Y1RGS0hj?=
 =?utf-8?B?N2hFbHVJOXJOTGoycy9SWDRrZGdKY1N2d2VUdFZ6NXdYZUNDWXhZTlBvWE9h?=
 =?utf-8?B?UUtXUHdWMGVZOFpkRit5VUp0RGhyYlhRdlhYYTNXd3krNXFSMG9WZWFxSjN1?=
 =?utf-8?B?eVhFNVZyNG02SFE5S3dCTW1xYzJqNUFDSVZEa3JLNWdYVHdCZkgrMnZEUFkz?=
 =?utf-8?B?VmxlL2dyTFV3S1RuQzFrb1d4TTVNaDBpZ08yUXZBQUhScEtXaTlzYk04YnlO?=
 =?utf-8?B?T29UMkZyQjZKcEZVL1haN09QckJzYzlyQk1LWHZCbmYrVy9YWUdKQzcrY1Nw?=
 =?utf-8?B?V1RaOGtBeTYxYjk4SkJIS1k0ZjdTTVExbVBLMk0zL0pRSEdONlB3b1BCaXUw?=
 =?utf-8?B?UW0wWHk1dThYWGE0Nkd0RTNjRkpjWnR4L1NQUWNSVGYyR2p3MU80VFFsaWFG?=
 =?utf-8?B?c2Q0dVBmOEsyVmVxQnltdVdrclZnSDJURVpuSXdSQ3VGc2tGY0VHbWVZRTJy?=
 =?utf-8?B?UzVyZTRhdWE5Q0l5MXZNOXJRTHMrTThHbzlEeFpQMmZ6VFgrQ0Z2OHRZRDI5?=
 =?utf-8?B?eThsSndvR1hzN1VVWmlpeWh0NVdGL3J5L0Y5cmVNVjU0c09jNXZaM0x5d0Rp?=
 =?utf-8?B?dmo1clp2QVZaVm5TTzJLQ1Uvc1BYRHJCeWprT2tMVkx5NGJYMFdra0dFUFpK?=
 =?utf-8?B?T0IrcnlORDllWmpBQ0JneTlQQUowTHg2RWVOc0FORW5FaWpFaVg0Nk5CY055?=
 =?utf-8?B?NkI5dFlLSWlzMkh3M2dWSUIxOUZ5c2IybUh5WU8wMEs0ODlybHd5bEF0RnFR?=
 =?utf-8?B?aE1ld25hVFpWQlRVa0NkazRiTFd5VWxMQklncWdqT2U4NTA5WEM1VlluT2Ey?=
 =?utf-8?B?TXl0TnRpUCtzT1JyVm93K1VFMzZoYzFFSmZPYUlQV1Rua1A3ek4vWGtGWHFm?=
 =?utf-8?B?a1Q5S1RpTkpKaUUxREZ6UVo0TlorRkZaVHpNY29KYmpLZlpocGFQNHZ4T2gy?=
 =?utf-8?B?RHhLTnZJSFI2TzFWYUNhYjh4ZkdScUJuV1NWam4xNk8zajhzZFkzVDM3Q3lS?=
 =?utf-8?B?WkV6MFlDdVEyYTdMVG1td2NWNHlzV0J0NjFFbXJkbk40SDdySXBjQkNKazBP?=
 =?utf-8?B?Ym5iaHZBUXpoSnQrK3RWMUpyeGl6aFFRTmlPaTlKdHAyNU4rM2p6b3lVdHhT?=
 =?utf-8?B?VUhmWkU1bjQ5NlpneWlvMzVqMkJyVW1nL1dnZDVYRzE3OXlIQ1FFMC8zY21u?=
 =?utf-8?B?WUdyL0kyNk9ma0R6OXozcEovZjl2SEhnWlpBOWhodmdRVVlxVXVMS2tKWTNo?=
 =?utf-8?B?d3ZiTU5PYXBQSEQrUjNJQy9FMklleHRvRWczOElOMnRqSWcvVG1lQkI3OTdB?=
 =?utf-8?B?WXlxR2RNNGhaNG5OTy9HTjRpWHpwNUUvMzczRXY2NGhnRnllSkZTNTBmWnE2?=
 =?utf-8?B?MmRMYytvQkFiSnBwRGNWOWwxOGVqVENsdENRRFhRb1dCQkVzQ1ZIZGx4bDhH?=
 =?utf-8?B?QWVNSVBrczdOTTFLV0VqZlNEUU1LdCttaE5hdDU3S1FybXRLNDVqbDZYS3p3?=
 =?utf-8?Q?PEvvrNDATtK58MTKI0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSAPR01MB2737.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5efa03da-d079-441c-bc91-08d8dcc1c217
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2021 14:53:21.4960
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yMFLumxdqLu5i+0isNu0VxSLcnhoL9n0XNTR9ZG/rPDVVG/h8jsbVo0THh9leWsbJ4YDi4lIeqJBy2W/fIjrLWrYfwGGVAnXaObW5pvAGZY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB3905
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

SGkgTGF1cmVudCwNCg0KVGhhbmtzIGZvciB5b3VyIGZlZWRiYWNrIQ0KDQo+IEZyb206IExhdXJl
bnQgUGluY2hhcnQgPGxhdXJlbnQucGluY2hhcnRAaWRlYXNvbmJvYXJkLmNvbT4NCj4gU2VudDog
MjYgRmVicnVhcnkgMjAyMSAxMjo0Nw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDUvN10gYXJtNjQ6
IGR0czogcmVuZXNhczogcjhhNzc5OTA6IEFkZCBEQUIgc3VwcG9ydA0KPiANCj4gSGkgRmFicml6
aW8sDQo+IA0KPiBUaGFuayB5b3UgZm9yIHRoZSBwYXRjaC4NCj4gDQo+IE9uIFRodSwgRmViIDI1
LCAyMDIxIGF0IDEwOjUxOjQ1UE0gKzAwMDAsIEZhYnJpemlvIENhc3RybyB3cm90ZToNCj4gPiBS
LUNhciBFMyAoYS5rLmEuIHI4YTc3OTkwKSBjb21lcyB3aXRoIHRoZSBEQUIgaGFyZHdhcmUgYWNj
ZWxlcmF0b3IuDQo+ID4gVGhpcyBwYXRjaCBhZGRzIFNvQyBzcGVjaWZpYyBzdXBwb3J0Lg0KPiA+
DQo+ID4gU2lnbmVkLW9mZi1ieTogRmFicml6aW8gQ2FzdHJvIDxmYWJyaXppby5jYXN0cm8uanpA
cmVuZXNhcy5jb20+DQo+ID4gLS0tDQo+ID4gIGFyY2gvYXJtNjQvYm9vdC9kdHMvcmVuZXNhcy9y
OGE3Nzk5MC5kdHNpIHwgMTIgKysrKysrKysrKysrDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxMiBp
bnNlcnRpb25zKCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm02NC9ib290L2R0cy9y
ZW5lc2FzL3I4YTc3OTkwLmR0c2kNCj4gYi9hcmNoL2FybTY0L2Jvb3QvZHRzL3JlbmVzYXMvcjhh
Nzc5OTAuZHRzaQ0KPiA+IGluZGV4IDUwMTBmMjNmYWZjYy4uNWE2YjgzNWYxMzdhIDEwMDY0NA0K
PiA+IC0tLSBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvcmVuZXNhcy9yOGE3Nzk5MC5kdHNpDQo+ID4g
KysrIGIvYXJjaC9hcm02NC9ib290L2R0cy9yZW5lc2FzL3I4YTc3OTkwLmR0c2kNCj4gPiBAQCAt
OTYzLDYgKzk2MywxOCBAQCBpcG1tdV92cDA6IGlvbW11QGZlOTkwMDAwIHsNCj4gPiAgCQkJI2lv
bW11LWNlbGxzID0gPDE+Ow0KPiA+ICAJCX07DQo+ID4NCj4gPiArCQlkYWI6IGRhYkBlNjczMDAw
MCB7DQo+ID4gKwkJCWNvbXBhdGlibGUgPSAicmVuZXNhcyxkYWItcjhhNzc5OTAiLA0KPiA+ICsJ
CQkJICAgICAicmVuZXNhcyxyY2FyLWdlbjMtZGFiIjsNCj4gPiArCQkJcmVnID0gPDB4MDAgMHhl
NjczMDAwMCAweDAwIDB4MTIwPjsNCj4gDQo+IFdlIG9mdGVuIGV4cHJlc3MgdGhlIGZpcnN0IGNl
bGwgYXMganVzdCAwLg0KDQpJIHdpbGwgcmVwbGFjZSAweDAwIHdpdGggMC4NCg0KPiANCj4gCQkJ
cmVnID0gPDAgMHhlNjczMDAwMCAwIDB4MTIwPjsNCj4gDQo+ID4gKwkJCWludGVycnVwdHMgPSA8
R0lDX1NQSSAxNjAgSVJRX1RZUEVfTEVWRUxfSElHSD47DQo+ID4gKwkJCWNsb2NrcyA9IDwmY3Bn
IENQR19NT0QgMTAxNj47DQo+IA0KPiBBcyB0aGUgY2xvY2sgaXNuJ3QgZG9jdW1lbnRlZCBpbiB0
aGUgZG9jdW1lbnRhdGlvbiwgSSBjYW4ndCB2ZXJpZnkgdGhpcw0KPiBvZiB0aGUgcmVzZXRzIHBy
b3BlcnR5IDotUw0KPiANCj4gPiArCQkJY2xvY2stbmFtZXMgPSAiZGFiIjsNCj4gDQo+IEknbGwg
Y29tbWVudCBvbiB0aGUgY2xvY2sgbmFtZSBpbiB0aGUgRFQgYmluZGluZ3MuDQoNClRoYW5rcywN
CkZhYg0KDQo+IA0KPiBSZXZpZXdlZC1ieTogTGF1cmVudCBQaW5jaGFydCA8bGF1cmVudC5waW5j
aGFydEBpZGVhc29uYm9hcmQuY29tPg0KPiANCj4gPiArCQkJcG93ZXItZG9tYWlucyA9IDwmc3lz
YyBSOEE3Nzk5MF9QRF9BTFdBWVNfT04+Ow0KPiA+ICsJCQlyZXNldHMgPSA8JmNwZyAxMDE2PjsN
Cj4gPiArCQkJc3RhdHVzID0gImRpc2FibGVkIjsNCj4gPiArCQl9Ow0KPiA+ICsNCj4gPiAgCQlh
dmI6IGV0aGVybmV0QGU2ODAwMDAwIHsNCj4gPiAgCQkJY29tcGF0aWJsZSA9ICJyZW5lc2FzLGV0
aGVyYXZiLXI4YTc3OTkwIiwNCj4gPiAgCQkJCSAgICAgInJlbmVzYXMsZXRoZXJhdmItcmNhci1n
ZW4zIjsNCj4gDQo+IC0tDQo+IFJlZ2FyZHMsDQo+IA0KPiBMYXVyZW50IFBpbmNoYXJ0DQo=

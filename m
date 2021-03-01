Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 208A5328165
	for <lists+linux-api@lfdr.de>; Mon,  1 Mar 2021 15:53:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236595AbhCAOwu (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 1 Mar 2021 09:52:50 -0500
Received: from mail-eopbgr1400137.outbound.protection.outlook.com ([40.107.140.137]:6212
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236624AbhCAOwh (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Mon, 1 Mar 2021 09:52:37 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iz0zZlVhwt5q7WK6CNmLeu5LTTlZh0X9YHnon+0qqxlO+nTnCbyXyP2AiRfCVbH78eVHWX9XzBVr+Lr+P9NIDdAzocJRXtvUyuUuZ4K+9DlV3nu06QNTz3c+NG/+i3Ku+u6aKchtQkqi/iJ5xwKYy2/V26nAXGl/FVLRQeCjKhp+ci9KMqm1Ni7+XWuoIdeXUVTewvS4RvVscSPX8UzGcwU519l1wVbLRQ6r2zfuS5u17NGh0J2mFqjb1NVcve4zB4pM2vMvGes6fzk7XquVLnUrgrOkMbcrvNZ7L/hS7QbxtwUZWk4H6g2Bsz6SdOukoSfNenlH/noA7C7k0TU9uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wDp68d8DekZwH7OYOaIyLNy8S1UuGlo97+DVd6xUXcA=;
 b=GTn4ylyqFQcnXhotHchJ5s+nhpsWiBRErKq9qKL250vWkgrccTwEfqx6GpydnStKPkXnQg7i72IEHFpTW72IoyhyKorA9qCfrA56G5DmYul1YukScJCnz+M9kmiFUQfu4v0NTabLvKy0hPzlDXhueHx4x7Xoz8PmsdJt2WjBLTfy3ynx6WYZ7Yc6TGtHzof/TZVf8oVed3VclbM8t/l71YZ/DI+VkQhjva0gnyP4Ectl1cLrvAH/AOSZc+0eksicQfet4aRci/jB9uFjClIMw5xeXCt2kBv6D24eu/3FcckUXjMlIeUptpu/jnSXyuLEhPv9WQ7oYvahfs6Z6hYDTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wDp68d8DekZwH7OYOaIyLNy8S1UuGlo97+DVd6xUXcA=;
 b=GdbLDDo3l65FNq2gOSrY+uab/3KNEaySp/y265dpmiLXcCFG7JUjUPYvVDdARkkgUlCQYGBELsEH8Ey67IwhMVZid8Hrf3yzNyL43S7iNF1/NPp4xUyeZBo0ko+3KWHltlaB6EjSusyNE1m2a1O2t9s+TncwqhgdRYJv5gKh5IQ=
Received: from OSAPR01MB2737.jpnprd01.prod.outlook.com (2603:1096:603:38::21)
 by OSBPR01MB4600.jpnprd01.prod.outlook.com (2603:1096:604:7e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.23; Mon, 1 Mar
 2021 14:51:48 +0000
Received: from OSAPR01MB2737.jpnprd01.prod.outlook.com
 ([fe80::4d2d:3155:768e:50e0]) by OSAPR01MB2737.jpnprd01.prod.outlook.com
 ([fe80::4d2d:3155:768e:50e0%7]) with mapi id 15.20.3890.028; Mon, 1 Mar 2021
 14:51:48 +0000
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
Subject: RE: [PATCH 5/7] arm64: dts: renesas: r8a77990: Add DAB support
Thread-Topic: [PATCH 5/7] arm64: dts: renesas: r8a77990: Add DAB support
Thread-Index: AQHXC8kDG3KbJtXN00qk3+r5x4JlDapqLosAgAUOabA=
Date:   Mon, 1 Mar 2021 14:51:48 +0000
Message-ID: <OSAPR01MB2737FB342DDB09D12EADEEABC29A9@OSAPR01MB2737.jpnprd01.prod.outlook.com>
References: <20210225225147.29920-1-fabrizio.castro.jz@renesas.com>
 <20210225225147.29920-6-fabrizio.castro.jz@renesas.com>
 <CAMuHMdVg-BwAxBZ3ts4BpMMWPc88BG8TkD5JOosRg7O57EB33Q@mail.gmail.com>
In-Reply-To: <CAMuHMdVg-BwAxBZ3ts4BpMMWPc88BG8TkD5JOosRg7O57EB33Q@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linux-m68k.org; dkim=none (message not signed)
 header.d=none;linux-m68k.org; dmarc=none action=none header.from=renesas.com;
x-originating-ip: [2.28.163.123]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 405e2d4f-5a63-451f-62aa-08d8dcc18a97
x-ms-traffictypediagnostic: OSBPR01MB4600:
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <OSBPR01MB46003153A1E5712BC0813B9EC29A9@OSBPR01MB4600.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Thcd5RfIwswPqWU0HUhneX5/22nDHe8gxZ21eWiNvKNZKP+cMIOjVlPEhrPSKDXwx67JeEuvk93Us6ZuBtFTZndfzqkHb4pJfcWIWOQfN0MC/JYtOWDqlrLB2iqBZeRWbaOOmGUBPUYTAksUkd6wBKngxQOBH6tZZlV6arbU2xxJ3L5OrG1KxT0olXahh7e7u7sbjWfbcF769f7R+IYk3xwKn8wwtAP2Clb3Sgs1PdGNsDcDfCsjAbiWvpaB1CuKqcaJYifJKE0nm0D6ayOQaf5lJYUIZUV54QbhqBUHoRd/eg6Xp/yOBvSM1rLX1nlOluTUWWZwvL0V32lGYUUzKzAQ2+pKzMu8csEcR4VgJSLqhgYG0q3x+e4O8uLCb+qhVJ6PWZFSgYHhPwQjW75WH4pX6SmbbqQIPr5bbYm4c0o/bVk94DXW9g/c0KZgRLe0X2T2hsVsEjBjuhM+cjdtPRnQu4kp25Ao/XSEWijaiRM3yyIt+6PTbRgqAiKcwgqVtyFl3FtdNE+rbhLKceAang==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSAPR01MB2737.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(136003)(396003)(39860400002)(366004)(83380400001)(55016002)(8676002)(86362001)(7416002)(66446008)(9686003)(6916009)(4744005)(52536014)(478600001)(33656002)(316002)(66476007)(26005)(107886003)(66946007)(8936002)(5660300002)(2906002)(7696005)(64756008)(54906003)(186003)(53546011)(6506007)(76116006)(71200400001)(4326008)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?dTQ3SEJ1TzA2bW9JU1FmUFFDVzNuMU9wdkx0RGpFdHg4SEhhV3Fndkt3aU9Q?=
 =?utf-8?B?V0FqUncrWHVmak9LV2w2Wkx4bTV0MkQyekdQam5YMndNblNYL1ZUY2dIUWhk?=
 =?utf-8?B?Y1IxajRBcys5Qm1pbmMzc3JuR3d4ZFcycUEzZWVrdlB2MXh1SnpGdE9wUFU2?=
 =?utf-8?B?dTl3YjYwV0JZSzAxdFdOT0dadHM1YW5YQlNZeVdGTy9yRGFmdXlwb0dWNlI1?=
 =?utf-8?B?cEc2d2c1Yk1SSWJKTGpZYTZxcjg2RjlmNzNOY2pqVW1GeWsvMmZEc200c1VF?=
 =?utf-8?B?U1BBdkVEdzhQcWZxOS9rTE1IUUhTRUhYa2NhQzhkMGFJNjAxTnN3QjhUQ2xZ?=
 =?utf-8?B?ZThqejhId2lhdkFLdkF0KzhrNlFEQkpFd1lCVGRVRHg4dTBFMWFiZk9XR1Ja?=
 =?utf-8?B?VDZramd1akE3TkJUQ1VCTndDdXFKdk8yemF5RzVscGZJUmdNS3dlMk1kNlJR?=
 =?utf-8?B?RTFtQU9QcGhjalIyZS9XV1ByVjh1Y1ljMGRzeDBtTnB3TXJMSnE4RlBnSE10?=
 =?utf-8?B?SlhBamlkWk5rT0FpSFcydnBXZ0pwMFZkSTdHUW1UZnRoNFcrbVNyN3RIUWEy?=
 =?utf-8?B?VklqNmljR3NrTjUxc3Y3K2YrMlR5b2hiL3Z1V0J0ejV3RCtsZDFYOUFhYnpR?=
 =?utf-8?B?NVJhOFoyL2FCTmNOS01aVE5RazJxTThtVzlZd0wyUkFPYTNERmh1VHJSNFln?=
 =?utf-8?B?VTl2aEdrRlBnbXpIdzJmSlZzRWtTK3Z3dktWMzJ2V2pHUjBJdUVqYUVhOFJv?=
 =?utf-8?B?OVhQRDlHcVJVNUJQQTJxQmw3NjJKY1NkUTlEaU1qcGczWjdaTnlPbDV0MFRJ?=
 =?utf-8?B?NFFER3FaRUsvNTVIak9jOXpuS0p3Vk9yQ0p5dzBFYnhDYmwzSURjN3Z4YnBG?=
 =?utf-8?B?Y0tiSHU4Z2NsdktwWHpjNWpNUVdRTVV5ZHFvRkduTzVmTGdNOUI3SE91VWE5?=
 =?utf-8?B?a1dyeE1XNTJGZ0dXOWY5cmU3eEtneG9zK3l1U3VzMUQrTnJMakUzNlgvRXBz?=
 =?utf-8?B?UW03RGNpV2tYOWhONXl6aUNBd1lCVVNqNmNheFBMVnY1aE5wMmUxK00rRnl4?=
 =?utf-8?B?WGZ5SUxIWWNTMFJOc2F2VXhma1JnZGtRdENTSFRydDBZTi9VZ2tQOThjenVl?=
 =?utf-8?B?UFBvejkzdW5IYmpyZnJ0eU5wK2haRTlBc3N3ZURXdnJKaGd1dGx0ekI4eFFr?=
 =?utf-8?B?Q0pZajBaU2FiZkZQd2l0Wmd0ODJGOFVJMWZhU2IyODVXYlNTSDQvbVFBekhn?=
 =?utf-8?B?US9LNVl5dVNNSnRQNkIrV3Y5aVFwbDFzOHBaMlNkbDhmOTBsL1pMSGdGSGpl?=
 =?utf-8?B?Mk9GVzNLOW9rYWxNYlhNMkM4ZkFTK0NSZmxqZndsWjNJTUV6cVJvR0ZySERz?=
 =?utf-8?B?TUlBbUJMbzlTM3JlRlVaemhpeDhEZXE0dmZzN2dYbC9LSFZyOXFxQVpINHJW?=
 =?utf-8?B?UUxCYmhDWGZ1U1BJeXlaTXE3RVRBeE1pQ25KQjh1czVGb082Q0lheG5taVB4?=
 =?utf-8?B?NjhPKzFBRFgwMWJhQmJJN2RxYnBlL1NGM05JS0xhWnZlSjRqUmdlT2JhY3p4?=
 =?utf-8?B?cXByQ0VMSUZOMEFtcFJKV3MvYlFlNkI0K0JmZEtKbUlzb1luU0JobkgwVXVs?=
 =?utf-8?B?azRLNzZNdDJSS1JJVkIxQmFDWjdEVjlydkxLZC9Kc2p2eTFrMTkzMzFZUzhY?=
 =?utf-8?B?eFUxcm9GNXhRYjRhK3c0OTd4U1Nzb1BaN09uSllYU21HMVFHbGJyMXU0ZG9U?=
 =?utf-8?Q?/SyW47igO6Ynsursz4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSAPR01MB2737.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 405e2d4f-5a63-451f-62aa-08d8dcc18a97
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2021 14:51:48.3701
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZyheeAVnHESRi7QU1X45PAGhSwrKLc3KwkwdxySwyZPd22aHkmOJCGETlhGmriWkcrIZPaibqeP9joubouzYhDKzTZZ3315hTnGkIRXBV2E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB4600
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

SGkgR2VlcnQsDQoNClRoYW5rcyBmb3IgeW91ciBmZWVkYmFjayENCg0KPiBGcm9tOiBHZWVydCBV
eXR0ZXJob2V2ZW4gPGdlZXJ0QGxpbnV4LW02OGsub3JnPg0KPiBTZW50OiAyNiBGZWJydWFyeSAy
MDIxIDA5OjM4DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggNS83XSBhcm02NDogZHRzOiByZW5lc2Fz
OiByOGE3Nzk5MDogQWRkIERBQiBzdXBwb3J0DQo+IA0KPiBPbiBUaHUsIEZlYiAyNSwgMjAyMSBh
dCAxMTo1MyBQTSBGYWJyaXppbyBDYXN0cm8NCj4gPGZhYnJpemlvLmNhc3Ryby5qekByZW5lc2Fz
LmNvbT4gd3JvdGU6DQo+ID4gUi1DYXIgRTMgKGEuay5hLiByOGE3Nzk5MCkgY29tZXMgd2l0aCB0
aGUgREFCIGhhcmR3YXJlIGFjY2VsZXJhdG9yLg0KPiA+IFRoaXMgcGF0Y2ggYWRkcyBTb0Mgc3Bl
Y2lmaWMgc3VwcG9ydC4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEZhYnJpemlvIENhc3RybyA8
ZmFicml6aW8uY2FzdHJvLmp6QHJlbmVzYXMuY29tPg0KPiANCj4gTEdUTSAoaWdub3JpbmcgY2xv
Y2stbmFtZXMgYmlrZXNoZWRkaW5nKQ0KDQpXaWxsIGNoYW5nZSB0aGUgY2xvY2sgbmFtZSBhcyBw
ZXIgeW91ciBjb21tZW50cy4NCg0KVGhhbmtzLA0KRmFiDQoNCj4gDQo+IEdye29ldGplLGVldGlu
Z31zLA0KPiANCj4gICAgICAgICAgICAgICAgICAgICAgICAgR2VlcnQNCj4gDQo+IC0tDQo+IEdl
ZXJ0IFV5dHRlcmhvZXZlbiAtLSBUaGVyZSdzIGxvdHMgb2YgTGludXggYmV5b25kIGlhMzIgLS0g
Z2VlcnRAbGludXgtDQo+IG02OGsub3JnDQo+IA0KPiBJbiBwZXJzb25hbCBjb252ZXJzYXRpb25z
IHdpdGggdGVjaG5pY2FsIHBlb3BsZSwgSSBjYWxsIG15c2VsZiBhIGhhY2tlci4NCj4gQnV0DQo+
IHdoZW4gSSdtIHRhbGtpbmcgdG8gam91cm5hbGlzdHMgSSBqdXN0IHNheSAicHJvZ3JhbW1lciIg
b3Igc29tZXRoaW5nIGxpa2UNCj4gdGhhdC4NCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAtLSBMaW51cyBUb3J2YWxkcw0K

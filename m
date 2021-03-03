Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2699D32C664
	for <lists+linux-api@lfdr.de>; Thu,  4 Mar 2021 02:02:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355462AbhCDA2o (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 3 Mar 2021 19:28:44 -0500
Received: from mail-eopbgr1400137.outbound.protection.outlook.com ([40.107.140.137]:2592
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1582435AbhCCKVm (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 3 Mar 2021 05:21:42 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XflhrqJgDcENJiWWV/vJN3pMsSYVLm9D3GXrzzE6UC5tETRG4FMuxHWb9dpVRScPzMUO8Yma5cdIlhaztLeNwQmDnMSaRBObiibE7FswY3jFeRZpe18bQxBAlkspKxvYlbTIfidUadG1ZNIZVgvFXueYTYXMEKmsWn+PDE1E3nGztvlW8Acdf4W8WVqynJjT+AihXyxM1EwLnM4YeuYhXt5bAg3zftf8pt468CybYm5DhU8qFhwHggCxKGOlC+0ip1gOHz8vXpKu6LxgWr+6Q78PEfA5p0+XpE5qU/iGVkKSG1U/4keUYRAKz/9ic9+4caew8ZkHAutOPy8jLQvbWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4ZyX+KwzxuQFhOFsSZrrnrx68Zed9UedMY70nc1S/bg=;
 b=nW/sbogQgL8L9EBCe8gS74r2nhmnl5r0mleBAmC1R/km3DO+CNyuUZZiC+ug2o3zxA7uhkGRVT54B6mYbsfSPenMHwsM2Pt2sBm5beu0CcW8D7w18MhTGJN7DI0v4jVhPqAkjoxYUmxu40YnRR/+makGVZtlQddijaET9/EITh//EmfzgwjeFZGgK2/2jcMANtXeSFXMN3tn3bTVxZoxUzj/3Mpmu2Bfhk1VL3snBL/smIC+DFalHDxn4Ie2wWW5EoGYkJKSaZB1T+6FdVre5YGA4h1ohLsfwKG11sduuaLb5AyBFL+XRRRvoOdQhrRrMj/PKCWguTkzCvKi8ivbaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4ZyX+KwzxuQFhOFsSZrrnrx68Zed9UedMY70nc1S/bg=;
 b=nRu7gw7lgUWu+GdBqBNX6TUV62gSI6fb7qbF/8iBky7N3zX4vx5uJJRVKQObiuwtRfg80M81jvmyuKFd1Ar2WSTuQ8HeFuC6JQBgCSm2BPVPT2Hf1Z+cDtKAOZ+1OhqviletVSTv6VNxkeGA/m09mOyFmenG6Ox7n/V0/Azn7WM=
Received: from OSAPR01MB2737.jpnprd01.prod.outlook.com (2603:1096:603:38::21)
 by OSAPR01MB3154.jpnprd01.prod.outlook.com (2603:1096:603:3f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Wed, 3 Mar
 2021 10:20:50 +0000
Received: from OSAPR01MB2737.jpnprd01.prod.outlook.com
 ([fe80::4d2d:3155:768e:50e0]) by OSAPR01MB2737.jpnprd01.prod.outlook.com
 ([fe80::4d2d:3155:768e:50e0%7]) with mapi id 15.20.3890.030; Wed, 3 Mar 2021
 10:20:50 +0000
From:   Fabrizio Castro <fabrizio.castro.jz@renesas.com>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
CC:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Arnd Bergmann <arnd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux API <linux-api@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        "REE dirk.behme@de.bosch.com" <dirk.behme@de.bosch.com>,
        Peter Erben <Peter.Erben@de.bosch.com>,
        Linux Media Mailing List <linux-media@vger.kernel.org>
Subject: RE: [PATCH 4/7] misc: Add driver for DAB IP found on Renesas R-Car
 devices
Thread-Topic: [PATCH 4/7] misc: Add driver for DAB IP found on Renesas R-Car
 devices
Thread-Index: AQHXC8kAUgvuEwTuE0CHH++Hj25LCKpqP0IAgAUWopCAAT2HAIAAAMjAgAAUboCAAW0Q8A==
Date:   Wed, 3 Mar 2021 10:20:50 +0000
Message-ID: <OSAPR01MB2737B061973D4D29729AB17BC2989@OSAPR01MB2737.jpnprd01.prod.outlook.com>
References: <20210225225147.29920-1-fabrizio.castro.jz@renesas.com>
 <20210225225147.29920-5-fabrizio.castro.jz@renesas.com>
 <CAK8P3a1+CZTAcR5T=gN565Q8=CdZnu5KYsAijKXLY8taofEpGg@mail.gmail.com>
 <OSAPR01MB2737666F47174B68A8EC8DD8C29A9@OSAPR01MB2737.jpnprd01.prod.outlook.com>
 <CAAEAJfDDhN4btecUzu=3ZYxP=amnOD=vq0bhhetx7voKdeMZ9Q@mail.gmail.com>
 <OSAPR01MB2737169C686080958657D65AC2999@OSAPR01MB2737.jpnprd01.prod.outlook.com>
 <YD4wWYc7/pDucm3s@pendragon.ideasonboard.com>
In-Reply-To: <YD4wWYc7/pDucm3s@pendragon.ideasonboard.com>
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
x-ms-office365-filtering-correlation-id: e3ea9196-63a7-4d48-b648-08d8de2e0511
x-ms-traffictypediagnostic: OSAPR01MB3154:
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <OSAPR01MB31545FF9B39AC039F4BC596BC2989@OSAPR01MB3154.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Dz3q5WEUJBl4MCLXjgOZqdnKEM1kxIuRO/utXbBqfhQpUMHfVXjeHsO9jvx3XpSjx3AUFIdHh8IDfqzpLNa+AqWahZIifg6bQx8hlPsw7+8ib9MVUyJQAOqvPVCKtgbJZZao1ivpQgWjcY5XqVCXeoVR5Q5mZRYVIcoKYnGZ3JiHpiKcPQVCBR6ley3+B3FPTaiessC49CM34me6LuzfwJJ+Ghv3b/e+b/wfdisI5u3NaJf3Ikp5oedssfXsDfLPD+azVYquJbdEi7zUol5cN9wtpoV+y259suCtQ13iY1bQ1jfBWduToWVP4Xy9WWSAhdFLOYHCXJB/pq3qvNAILDxR9C8XxFzt3+FM9xV34636EiRpxhDIoAOaYKqWDaaNVazg02ZRP8UV064c80YITJxsxc6KlD3prec5ZTGAzRIn5q6Hr9wFimHQ2/I7yZThi3knIpbOrmrU8WIgLCpGz4jPysjqpGfJ54rbBe9paroVxFDn1ppOkDK2UpklEZXhojMbpOakE5r7YjjQKgZ1Hg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSAPR01MB2737.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(396003)(39860400002)(376002)(346002)(6506007)(5660300002)(55016002)(2906002)(53546011)(52536014)(33656002)(9686003)(7416002)(76116006)(186003)(7696005)(83380400001)(478600001)(66946007)(26005)(66446008)(64756008)(71200400001)(8676002)(316002)(54906003)(86362001)(66556008)(4326008)(66476007)(6916009)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?ZkVuY0dhV211dE5ibmt1WDNiR28vQ0drSlo1Z2gvYnRiV25LMy8xZ3VmMmxC?=
 =?utf-8?B?NzVYMmVuakxQVzNlOTNiUi9wTkx4aDFBT0RLWjJxcHdNOUJtRHFBZmlYMWlT?=
 =?utf-8?B?T01MZnFxSCtHR1ptaWYycW81aC9Zam9KNFNRUnM3SEpBOU9yVlJqOFl3KzE0?=
 =?utf-8?B?bUJVTytMdWFxUUVYNVY1NjVHMjVGS0hXbm1HM2FRNGc0VGxhWG9qSk9Gcmhj?=
 =?utf-8?B?QWlTTmxZaFVGNnM2SlBQMXpQeDk5OHZBRnl4bWhuS0UvNjFvOFJjQXpvbmlX?=
 =?utf-8?B?Kzh3M3J2TG1iMUlUVkRWZ1Jsck9mLzl0dERqaGRaT2lSNDVPckdMOVdiODJJ?=
 =?utf-8?B?TGVBMXJYUGh0c1R1TE1NMVZJd0NNVGhVdGZRbmN1a245YTRGZWRuMHhRUUJ2?=
 =?utf-8?B?S2Y2aU1GYnVhZGhwYmRVeFdmVGlSU0dzeHdWM1hEUEVGNG1WZXljSVZZMit5?=
 =?utf-8?B?RWhaR2lKVlhWenRXRmEzV013MUE4OE1ra2JhVnpaUDNZL2pBR1AxMit6VTBI?=
 =?utf-8?B?MDNHVnErZDEvUk9zN3c0SFRTaXlTUkxMRjNwb21GamZ0VERJRkFXRmxkU1ZB?=
 =?utf-8?B?RURSRTZVenFZbmF5TWZYRnRFK05GRmVtNGNReVoyNlZ1bmYydzB4aVI4U2Ux?=
 =?utf-8?B?cGsrR3kxRmVvQ0pxeWpBM2prbGJFbVNMbDh3N1hZZ0d0Mm9qTXZIMXF0cXVs?=
 =?utf-8?B?Q2RVNUZic0c2RWZvRjlTek80aHF3czFoYkJGa1pSOUR3NjU4MVlIN0drcDR2?=
 =?utf-8?B?UkZQZnIyV0JqV3IvelVSSjBPSVpOZi9KaFhHWlNXQnZhRXJSUDRJNnhOWGhT?=
 =?utf-8?B?QUx4K3dUOFptUEFZUEdLN1V4RHFDN2dicGViZHpYTGdETHJGdmdzUzRBUVpT?=
 =?utf-8?B?NHgwUmI5cmxZeXFiOEs4ZEd0OW1GWkdWYmY2cGJxRkVZdFhJOWxMYXdhZEJN?=
 =?utf-8?B?dXZzQUZycmpjSXNKY3EwU1NaL2lyT21Md082dW5oa2tuNmRiWHJBK1Jjdi9F?=
 =?utf-8?B?MER5ZkdGeWRwWkNxWWZIR3JnYnJSSUFSdFloTUx0MFk4MG5maGNpRTNTU0xU?=
 =?utf-8?B?YUVPWEhVMGVqWmdyNDRZN1o5L3pvT3RXZklxck5pRTNlcS9ZOVNITkxldWNp?=
 =?utf-8?B?MjQvaFIvN3hTRlNzcDNJODNrTkQxUTJ1QmFoTlNJZjVmL3Y4S1dXQmJWbkR0?=
 =?utf-8?B?cXBxNzRtQVlDOTJkbU1kR3NWU1FzN253U2xrd3lGSVZqZHR5N29OTGhwNHAx?=
 =?utf-8?B?ZUtkYVBsN2xrRE9tdXhCMGtFQ2JrYTM5ZGtwc0Z1MVZZUVdSTjVDYjZFWHRD?=
 =?utf-8?B?R0JUT095MHJoN0VzdzlwZkJhRm9oSTFHbU9rS0dVcXRZRmxXMjhzNFJGeThG?=
 =?utf-8?B?UXo2YlJ3bmxPZmxXMitZL080OEpGTlNReTliVS84SzhtMU5EYnJRQjFjTnQv?=
 =?utf-8?B?RjJ1SDZsSGo2cHN0K09kRm1DK2hkOUpHL09tYTBnTFNGQ0ZDMEh6ZDNoOC9N?=
 =?utf-8?B?OHJSRVczYUlxSjZDTzd4c1J2VFlFeG04TVlHcXJ0SHVmRjA3V0ZHb29GWnB6?=
 =?utf-8?B?N3dFUVlnRnVKaW1vZkV2Sm1yd2xTMS9hVEtSZVU3ZU9uZ2l5a1Y2WDEvZTdk?=
 =?utf-8?B?SzRZOWV1U0pPK0VoQ2dOZHhSOVJ5UkY5ejhWV2R6U0FPbHVTckRYZHJjY0hE?=
 =?utf-8?B?VUlhS1VSTFVmY0h6U1R6TnlJOUtCVGd4S0htZTk4dlF5Z2hORWh2Z3FpbFY4?=
 =?utf-8?Q?wPOEPgiSpDCcWwKi5U=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSAPR01MB2737.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3ea9196-63a7-4d48-b648-08d8de2e0511
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2021 10:20:50.5935
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uYntg9xxUFAp4kJ97/fYy4Uc7A0Fqmf+PWJbCVWav7Xp2wjH3y2sUdlgCjnnfc6Wr/rkOSND/94uJZsQ4/2PghsdIC4m1gPvL3PKdIKp4Es=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB3154
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

SGkgTGF1cmVudCwNCg0KVGhhbmtzIGZvciB5b3VyIGZlZWRiYWNrIQ0KDQo+IEZyb206IExhdXJl
bnQgUGluY2hhcnQgPGxhdXJlbnQucGluY2hhcnRAaWRlYXNvbmJvYXJkLmNvbT4NCj4gU2VudDog
MDIgTWFyY2ggMjAyMSAxMjozMg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDQvN10gbWlzYzogQWRk
IGRyaXZlciBmb3IgREFCIElQIGZvdW5kIG9uIFJlbmVzYXMgUi0NCj4gQ2FyIGRldmljZXMNCj4g
DQo+IEhpIEZhYnJpemlvLA0KPiANCj4gT24gVHVlLCBNYXIgMDIsIDIwMjEgYXQgMTI6MjA6MTdQ
TSArMDAwMCwgRmFicml6aW8gQ2FzdHJvIHdyb3RlOg0KPiA+IE9uIDAyIE1hcmNoIDIwMjEgMTE6
MTcsIEV6ZXF1aWVsIEdhcmNpYSB3cm90ZToNCj4gPiA+IE9uIE1vbiwgMSBNYXIgMjAyMSBhdCAx
NDozNiwgRmFicml6aW8gQ2FzdHJvIHdyb3RlOg0KPiA+ID4gPiBPbiAyNiBGZWJydWFyeSAyMDIx
IDEwOjM4LCBBcm5kIEJlcmdtYW5uIHdyb3RlOg0KPiA+ID4gPiA+IE9uIFRodSwgRmViIDI1LCAy
MDIxIGF0IDExOjUxIFBNIEZhYnJpemlvIENhc3RybyB3cm90ZToNCj4gPiA+ID4gPiA+DQo+ID4g
PiA+ID4gPiBUaGUgREFCIGhhcmR3YXJlIGFjY2VsZXJhdG9yIGZvdW5kIG9uIFItQ2FyIEUzIGFu
ZCBSLUNhciBNMy1ODQo+IGRldmljZXMgaXMNCj4gPiA+ID4gPiA+IGEgaGFyZHdhcmUgYWNjZWxl
cmF0b3IgZm9yIHNvZnR3YXJlIERBQiBkZW1vZHVsYXRvcnMuDQo+ID4gPiA+ID4gPiBJdCBjb25z
aXN0cyBvZiBvbmUgRkZUIChGYXN0IEZvdXJpZXIgVHJhbnNmb3JtKSBtb2R1bGUgYW5kIG9uZQ0K
PiBkZWNvZGVyDQo+ID4gPiA+ID4gPiBtb2R1bGUsIGNvbXBhdGlibGUgd2l0aCBEQUIgc3BlY2lm
aWNhdGlvbiAoRVRTSSBFTiAzMDAgNDAxIGFuZA0KPiA+ID4gPiA+ID4gRVRTSSBUUyAxMDIgNTYz
KS4NCj4gPiA+ID4gPiA+IFRoZSBkZWNvZGVyIG1vZHVsZSBjYW4gcGVyZm9ybSBGSUMgZGVjb2Rp
bmcgYW5kIE1TQyBkZWNvZGluZw0KPiBwcm9jZXNzaW5nDQo+ID4gPiA+ID4gPiBmcm9tIGRlLXB1
bmN0dXJlIHRvIGZpbmFsIGRlY29kZWQgcmVzdWx0Lg0KPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+
IFRoaXMgcGF0Y2ggYWRkcyBhIGRldmljZSBkcml2ZXIgdG8gc3VwcG9ydCB0aGUgRkZUIG1vZHVs
ZSBvbmx5Lg0KPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IEZhYnJpemlv
IENhc3RybyA8ZmFicml6aW8uY2FzdHJvLmp6QHJlbmVzYXMuY29tPg0KPiA+ID4gPiA+ID4gLS0t
DQo+ID4gPiA+ID4gPiAgTUFJTlRBSU5FUlMgICAgICAgICAgICAgICAgICAgICAgfCAgIDcgKysN
Cj4gPiA+ID4gPiA+ICBkcml2ZXJzL21pc2MvS2NvbmZpZyAgICAgICAgICAgICB8ICAgMSArDQo+
ID4gPiA+ID4gPiAgZHJpdmVycy9taXNjL01ha2VmaWxlICAgICAgICAgICAgfCAgIDEgKw0KPiA+
ID4gPiA+ID4gIGRyaXZlcnMvbWlzYy9yY2FyX2RhYi9LY29uZmlnICAgIHwgIDExICsrDQo+ID4g
PiA+ID4gPiAgZHJpdmVycy9taXNjL3JjYXJfZGFiL01ha2VmaWxlICAgfCAgIDggKysNCj4gPiA+
ID4gPiA+ICBkcml2ZXJzL21pc2MvcmNhcl9kYWIvcmNhcl9kZXYuYyB8IDE3Ng0KPiArKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrDQo+ID4gPiA+ID4gPiAgZHJpdmVycy9taXNjL3JjYXJf
ZGFiL3JjYXJfZGV2LmggfCAxMTYgKysrKysrKysrKysrKysrKysrKysNCj4gPiA+ID4gPiA+ICBk
cml2ZXJzL21pc2MvcmNhcl9kYWIvcmNhcl9mZnQuYyB8IDE2MA0KPiArKysrKysrKysrKysrKysr
KysrKysrKysrKysrDQo+ID4gPiA+ID4gPiAgaW5jbHVkZS91YXBpL2xpbnV4L3JjYXJfZGFiLmgg
ICAgfCAgMzUgKysrKysrDQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBDYW4geW91IGV4cGxhaW4gd2h5
IHRoaXMgaXMgbm90IGluIGRyaXZlcnMvbWVkaWEvPw0KPiA+ID4gPg0KPiA+ID4gPiBJIHdhc24n
dCBlbnRpcmVseSBzdXJlIHdlcmUgdG8gcHV0IGl0IHRvIGJlIGhvbmVzdCBhcyBJIGNvdWxkbid0
DQo+IGZpbmQNCj4gPiA+ID4gYW55dGhpbmcgc2ltaWxhciwgdGhhdCdzIHdoeSAibWlzYyIgZm9y
IHYxLCB0byBtYWlubHkgZ2V0IGEgZmVlZGJhY2sNCj4gPiA+ID4gYW5kIGFkdmljZS4NCj4gPiA+
ID4NCj4gPiA+ID4gPiBJIGRvbid0IHRoaW5rIHdlIHdhbnQgYSBjdXN0b20gaW9jdGwgaW50ZXJm
YWNlIGZvciBhIGRldmljZSB0aGF0DQo+ID4gPiA+ID4gaW1wbGVtZW50cw0KPiA+ID4gPiA+IGEg
Z2VuZXJpYyBzcGVjaWZpY2F0aW9uLiBNeSBmaXJzdCBmZWVsaW5nIHdvdWxkIGJlIHRoYXQgdGhp
cw0KPiBzaG91bGQgbm90DQo+ID4gPiA+ID4gaGF2ZSBhIHVzZXItbGV2ZWwgQVBJIGJ1dCBpbnN0
ZWFkIGdldCBjYWxsZWQgYnkgdGhlIERBQiByYWRpbw0KPiBkcml2ZXIuDQo+ID4gPiA+DQo+ID4g
PiA+IEkgaGVhciB5b3UsIHRoZSB0cm91YmxlIGlzIHRoYXQgdGhlIG1vZHVsZXMgb2YgdGhpcyBJ
UCBzaG91bGQgYmUNCj4gc2Vlbg0KPiA+ID4gPiBhcyBwYXJ0IG9mIGEgU1cgYW5kIEhXIHByb2Nl
c3NpbmcgcGlwZWxpbmUuDQo+ID4gPiA+IFNvbWUgb2YgdGhlIFNXIGNvbXBvbmVudHMgb2YgdGhl
IHBpcGVsaW5lIGNhbiBiZSBwcm9wcmlldGFyeSwgYW5kDQo+ID4gPiA+IHVuZm9ydHVuYXRlbHkg
d2UgZG9uJ3QgaGF2ZSBhY2Nlc3MgKHlldCkgdG8gYSBmcmFtZXdvcmsgdGhhdCBhbGxvd3MNCj4g
dXMgdG8NCj4gPiA+ID4gdGVzdCBhbmQgZGVtb25zdHJhdGUgdGhlIHdob2xlIHBpcGVsaW5lLCBm
b3IgdGhlIG1vbWVudCB3ZSBjYW4gb25seQ0KPiB0ZXN0DQo+ID4gPiA+IHRoaW5ncyBpbiBpc29s
YXRpb24uIEl0J2xsIHRha2UgdXMgYSB3aGlsZSB0byBjb21lIHVwIHdpdGggYSBmdWxsDQo+IHNv
bHV0aW9uDQo+ID4gPiA+IChvciB0byBoYXZlIGFjY2VzcyB0byBvbmUpLCBhbmQgaW4gdGhlIG1l
YW50aW1lIG91ciBTb0NzIGNvbWUgd2l0aA0KPiBhbiBJUA0KPiA+ID4gPiB0aGF0IGNhbid0IGJl
IHVzZWQgYmVjYXVzZSB0aGVyZSBpcyBubyBkcml2ZXIgZm9yIGl0ICh5ZXQpLg0KPiA+ID4gPg0K
PiA+ID4gPiBBZnRlciBkaXNjdXNzaW5nIHRoaW5ncyBmdXJ0aGVyIHdpdGggR2VlcnQgYW5kIExh
dXJlbnQsIEkgdGhpbmsgdGhleQ0KPiA+ID4gPiBhcmUgcmlnaHQgaW4gc2F5aW5nIHRoYXQgdGhl
IGJlc3QgcGF0aCBmb3IgdGhpcyBpcyBwcm9iYWJseSB0byBhZGQNCj4gdGhpcw0KPiA+ID4gPiBk
cml2ZXIgdW5kZXIgImRyaXZlcnMvc3RhZ2luZyIgYXMgYW4gaW50ZXJpbSBzb2x1dGlvbiwgc28g
dGhhdCB0aGUNCj4gSVAgd2lsbA0KPiA+ID4gPiBiZSBhY2Nlc3NpYmxlIGJ5IGRldmVsb3BlcnMs
IGFuZCB3aGVuIHdlIGhhdmUgZXZlcnl0aGluZyB3ZSBuZWVkIChhDQo+IGZ1bGx5DQo+ID4gPiA+
IGZsZWRnZWQgcHJvY2Vzc2luZyBmcmFtZXdvcmspLCB3ZSB3aWxsIGFibGUgdG8gaW50ZWdyYXRl
IGl0IGJldHRlcg0KPiB3aXRoDQo+ID4gPiA+IHRoZSBvdGhlciBjb21wb25lbnRzIChpZiBwb3Nz
aWJsZSkuDQo+ID4gPiA+DQo+ID4gPiA+ID4gV2hhdCBpcyB0aGUgaW50ZW5kZWQgdXNhZ2UgbW9k
ZWwgaGVyZT8gSSBhc3N1bWUgdGhlIGlkZWEgaXMgdG8NCj4gPiA+ID4gPiB1c2UgaXQgaW4gYW4g
YXBwbGljYXRpb24gdGhhdCByZWNlaXZlcyBhdWRpbyBvciBtZXRhZGF0YSBmcm9tIERBQi4NCj4g
PiA+ID4gPiBXaGF0IGRyaXZlciBkbyB5b3UgdXNlIGZvciB0aGF0Pw0KPiA+ID4gPg0KPiA+ID4g
PiBUaGlzIElQIGlzIHNpbWlsYXIgdG8gYSBETUEgdG8gc29tZSBleHRlbnQsIGluIHRoZSBzZW5z
ZSB0aGF0IGl0DQo+IHRha2VzDQo+ID4gPiA+IGlucHV0IGRhdGEgZnJvbSBhIGJ1ZmZlciBpbiBt
ZW1vcnkgYW5kIGl0IHdyaXRlcyBvdXRwdXQgZGF0YSBvbnRvIGENCj4gYnVmZmVyDQo+ID4gPiA+
IGluIG1lbW9yeSwgYW5kIG9mIGNvdXJzZSBpdCBkb2VzIHNvbWUgcHJvY2Vzc2luZyBpbiBiZXR3
ZWVuLg0KPiA+ID4NCj4gPiA+IFRoYXQgc291bmRzIGxpa2Ugc29tZXRoaW5nIHRoYXQgY2FuIGZp
dCBWNEwyIE1FTTJNRU0gZHJpdmVyLg0KPiA+ID4gWW91IHF1ZXVlIHR3byBidWZmZXJzIGFuZCBh
biBvcGVyYXRpb24sIGFuZCB0aGVuIHJ1biBhIGpvYi4NCj4gPg0KPiA+IFY0TDIgTUVNMk1FTSBz
ZWVtcyBnb29kIGZvciB0aGlzIGluIGdlbmVyYWwsIGhvd2V2ZXIgdGhlIERBQiBJUCBpcyBnb2lu
Zw0KPiA+IHRvIGJlIHNoYXJlZCBieSBtdWx0aXBsZSBwcm9jZXNzaW5nIHBpcGVsaW5lcyAoYXMg
dXN1YWxseSB3ZSBoYXZlDQo+IHNldmVyYWwNCj4gPiBEUklGIGludGVyZmFjZXMsIGFuZCBvbmx5
IDEgREFCIElQKSwgYW5kIGZvciB3aGF0IGNvbmNlcm5zIEZGVA0KPiBzcGVjaWZpY2FsbHkNCj4g
PiB0aGVyZSBpcyBvbmx5IDEgRkZUIG1vZHVsZSBpbnNpZGUgdGhlIERBQiBJUC4NCj4gPiBNeSB1
bmRlcnN0YW5kaW5nIGlzIHRoYXQgdGhlIGNhcGFiaWxpdGllcyBvZiBWNEwyIE1FTTJNRU0gZGV2
aWNlcyBhcmUNCj4gPiBjb25maWd1cmVkIGZvciB0aGUgc3BlY2lmaWMgcGlwZWxpbmUsIGJ1dCBp
biB0aGUgdGhpcyBjb250ZXh0IHVzZXIgc3BhY2UNCj4gPiB3b3VsZCBoYXZlIHRvIGNvbnRpbnVv
dXNseSBzd2l0Y2ggdGhlIGNhcGFiaWxpdGllcyBvZiB0aGUgREFCIElQIChhdCB0aGUNCj4gPiBy
aWdodCBtb21lbnQpIHRvIGFsbG93IHByb2Nlc3NpbmcgZm9yIGRhdGEgc3RyZWFtcyByZXF1aXJp
bmcgZGlmZmVyZW50DQo+ID4gY2FwYWJpbGl0aWVzLg0KPiA+DQo+ID4gQW0gSSB3cm9uZz8NCj4g
DQo+IFY0TDIgTTJNIGRldmljZXMgY2FuIGJlIG9wZW5lZCBtdWx0aXBsZSB0aW1lcywgYnV0IGRp
ZmZlcmVudCBwcm9jZXNzZXMsDQo+IHdoaWNoIGNhbiBjb25maWd1cmUgdGhlIGRldmljZSBpbiBk
aWZmZXJlbnQgd2F5cywgYW5kIHN1Ym1pdCBqb2JzIHRoYXQNCj4gYXJlIHRoZW4gc2NoZWR1bGVk
IGJ5IHRoZSBWNEwyIE0yTSBmcmFtZXdvcmsuDQoNCkknbGwgZ2l2ZSBpdCBhIHRyeSBpbiBkdWUg
dGltZSB0aGVuLg0KDQpJIHRoaW5rIHRoZSBjbG9jayByZWxhdGVkIHBhdGNoZXMgYXJlIHdvcnRo
IG1lcmdpbmcuDQoNClRoYW5rcywNCkZhYg0KDQo+IA0KPiA+ID4gPiBJdCdzIG5vdCBkaXJlY3Rs
eSBjb25uZWN0ZWQgdG8gYW55IG90aGVyIFJhZGlvIHJlbGF0ZWQgSVAuDQo+ID4gPiA+IFRoZSB1
c2VyIHNwYWNlIGFwcGxpY2F0aW9uIGNhbiByZWFkIERBQiBJUSBzYW1wbGVzIGZyb20gdGhlIFIt
Q2FyDQo+IERSSUYNCj4gPiA+ID4gaW50ZXJmYWNlICh2aWEgZHJpdmVyIGRyaXZlcnMvbWVkaWEv
cGxhdGZvcm0vcmNhcl9kcmlmLmMsIG9yIGZyb20NCj4gb3RoZXINCj4gPiA+ID4gc291cmNlcyBz
aW5jZSB0aGlzIElQIGlzIGRlY291cGxlZCBmcm9tIERSSUYpLCBhbmQgdGhlbiB3aGVuIGl0J3MN
Cj4gdGltZQ0KPiA+ID4gPiB0byBhY2NlbGVyYXRlIEZGVCwgRklDLCBvciBNU0MsIGl0IGNhbiBy
ZXF1ZXN0IHNlcnZpY2VzIHRvIHRoZSBEQUINCj4gSVAsIHNvDQo+ID4gPiA+IHRoYXQgdGhlIGFw
cCBjYW4gZ28gb24gYW5kIHVzZSB0aGUgcHJvY2Vzc29yIHRvIGRvIHNvbWUgd29yaywgd2hpbGUN
Cj4gdGhlIERBQg0KPiA+ID4gPiBJUCBwcm9jZXNzZXMgdGhpbmdzLg0KPiA+ID4gPiBBIGZyYW1l
d29yayB0byBjb25uZWN0IGFuZCBleGNoYW5nZSBwcm9jZXNzaW5nIGJsb2NrcyAoZWl0aGVyIFNX
IG9yDQo+IEhXKSBhbmQNCj4gPiA+ID4gaW50ZXJmYWNlcyBpcyB0aGVyZWZvcmUgdml0YWwgdG8g
cHJvcGVybHkgcGxhY2UgYSBrZXJuZWwNCj4gaW1wbGVtZW50YXRpb24NCj4gPiA+ID4gaW4gdGhl
IGdyZWF0IHNjaGVtZSBvZiB0aGluZ3MsIGluIGl0cyBhYnNlbmNlIGEgc2ltcGxlIGRyaXZlciBj
YW4NCj4gaGVscA0KPiA+ID4NCj4gPiA+IEknbSBub3QgZW50aXJlbHkgc3VyZSB3ZSBhcmUgbWlz
c2luZyBhIGZyYW1ld29yay4gV2hhdCdzIG1pc3NpbmcgaW4NCj4gPiA+IFY0TDIgTUVNMk1FTT8N
Cj4gPg0KPiA+IEkgd2FzIHJlZmVycmluZyB0byBhIHVzZXIgc3BhY2UgZnJhbWV3b3JrIChJIHNo
b3VsZCBoYXZlIGJlZW4gbW9yZQ0KPiBzcGVjaWZpYw0KPiA+IHdpdGggbXkgcHJldmlvdXMgZW1h
aWwpLg0KPiA+DQo+ID4gPiBCZWZvcmUgY29uc2lkZXJpbmcgZHJpdmVycy9zdGFnaW5nLCBpdCB3
b3VsZCBiZSBpbnRlcmVzdGluZyB0byBmaWd1cmUNCj4gPiA+IG91dCBpZiBWNEwyIGNhbiBkbyBp
dCBhcy1pcywgYW5kIGlmIG5vdCwgZGlzY3VzcyB3aGF0J3MgbWlzc2luZy4NCj4gPg0KPiA+IEkg
dGhpbmsgYW4gaW50ZXJpbSBzb2x1dGlvbiB3b3VsZCBhbGxvdyB1cyBhbmQgdXNlcnMgdG8gZXZh
bHVhdGUgdGhpbmdzDQo+IGENCj4gPiBsaXR0bGUgYml0IGJldHRlciwgc28gdGhhdCB3ZSBjYW4g
aW50ZWdyYXRlIHRoaXMgSVAgd2l0aCBWNEwyIGxhdGVyIG9uLg0KPiANCj4gLS0NCj4gUmVnYXJk
cywNCj4gDQo+IExhdXJlbnQgUGluY2hhcnQNCg==

Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6998032B2DF
	for <lists+linux-api@lfdr.de>; Wed,  3 Mar 2021 04:49:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232836AbhCCDAZ (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 2 Mar 2021 22:00:25 -0500
Received: from mail-eopbgr1400113.outbound.protection.outlook.com ([40.107.140.113]:44150
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1350385AbhCBMVL (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Tue, 2 Mar 2021 07:21:11 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iR0Z1MVnIVj2RUVh7RODHRj3slyVfeIoG3eh3dSB1py6PbaIUiO3Ja6qVu9tUnc4dSH0UnBDv9Wktv3471+BrbCtLm54PEb92dEs7SNNlB+h70MCIfX/Ms+qs2/GzvIJ4bUS58wtqFzSp2o9fKRuOuDk8l0RDx/7SlEOOJJjBDs6VD3y4W8hIArKitJmYpAFi7HfR+3syF8uLksBWKaISIXS/zIdqbZFsHuswLekn3yU6cPk8NtSkwLvfDD/CXBJzyueEanEZhuTQelmil4vVuV6uyagPoSH19aLl8rKxT2pmxbZfpliBiocMeyDJ5sGASAqwCCaLKLUmtQ7k+N7Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zp7jqLkDZLL0G+xKwZm34qZNDsmVvwS/hp94IaS4DLU=;
 b=XjaMg9RnE1M1ivBPN3Eauwq+K8bjsgHL5n7Inca5f83iTGSlqc1/d8WXMIGasEbHUOx1n/W38IQmlDfFoEZoMxCsjSSOpoqSRCrKwEtwygk0iaKBUPcHxxtKAON8VYmLSs6z6kDpTplXG2sJm+utso7fgxgkAm12fWXWPdvZoJfZUcJnJt4MADJRr8cVoKvSNxdwG8n1D1yAmZ+jk/COoG6kxyO0hnYbWOjzYtNKuQfhT/eUTWTRFkVZ+lbKF5ujLgNoT9s3whNrEZsrxvdaOKRWj0I8s6yobIlcpVt1renG17snnJVGyspQI2F70UETA2FlANJevKE2Btqb/PT7Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zp7jqLkDZLL0G+xKwZm34qZNDsmVvwS/hp94IaS4DLU=;
 b=galcA/QtyZdWQi/BJCbDhHKWMnMI1P6s21Mq0jshjsmawJ5mgHaiqtUMV1jGM6cKh9bYwxwuze0bccoqNBZC5K4XFE5xoi9Vh6+hQ7RrcEJV4paf66a7LaTwA5pJhyBD8Q9Sz384r5s4R5NmAMDztzRIo/+P585KeGT4TqAMHYM=
Received: from OSAPR01MB2737.jpnprd01.prod.outlook.com (2603:1096:603:38::21)
 by OSBPR01MB2471.jpnprd01.prod.outlook.com (2603:1096:604:19::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.28; Tue, 2 Mar
 2021 12:20:17 +0000
Received: from OSAPR01MB2737.jpnprd01.prod.outlook.com
 ([fe80::4d2d:3155:768e:50e0]) by OSAPR01MB2737.jpnprd01.prod.outlook.com
 ([fe80::4d2d:3155:768e:50e0%7]) with mapi id 15.20.3890.028; Tue, 2 Mar 2021
 12:20:17 +0000
From:   Fabrizio Castro <fabrizio.castro.jz@renesas.com>
To:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
CC:     Arnd Bergmann <arnd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
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
Thread-Index: AQHXC8kAUgvuEwTuE0CHH++Hj25LCKpqP0IAgAUWopCAAT2HAIAAAMjA
Date:   Tue, 2 Mar 2021 12:20:17 +0000
Message-ID: <OSAPR01MB2737169C686080958657D65AC2999@OSAPR01MB2737.jpnprd01.prod.outlook.com>
References: <20210225225147.29920-1-fabrizio.castro.jz@renesas.com>
 <20210225225147.29920-5-fabrizio.castro.jz@renesas.com>
 <CAK8P3a1+CZTAcR5T=gN565Q8=CdZnu5KYsAijKXLY8taofEpGg@mail.gmail.com>
 <OSAPR01MB2737666F47174B68A8EC8DD8C29A9@OSAPR01MB2737.jpnprd01.prod.outlook.com>
 <CAAEAJfDDhN4btecUzu=3ZYxP=amnOD=vq0bhhetx7voKdeMZ9Q@mail.gmail.com>
In-Reply-To: <CAAEAJfDDhN4btecUzu=3ZYxP=amnOD=vq0bhhetx7voKdeMZ9Q@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vanguardiasur.com.ar; dkim=none (message not signed)
 header.d=none;vanguardiasur.com.ar; dmarc=none action=none
 header.from=renesas.com;
x-originating-ip: [2.28.163.123]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 434f33a5-29ed-43b7-18c9-08d8dd758a75
x-ms-traffictypediagnostic: OSBPR01MB2471:
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <OSBPR01MB247188DD049316117867A066C2999@OSBPR01MB2471.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dzYXm536nSuxrYjW7nImqd0FkY3qljH5pszt0Bqm/rMRuY+LFmH+RJ3VO/z112c/ZbA4elWCd7WfHlH9mGC96DDXOCZchPrSoXXci/fYa/KreP4v1TZMQ926iGcTJwkONRhPK774VPM2gTj+nyggZFJbbBAHbbEIQ4jH63j+8gpIuKWWWR8FnCI5WwRLAR/SN80D5gmCbNwTp21Uv0MGxyX030K93/1wTeE37796Xkxsbblsag6RzbnjbNTCgPsHq1BN/o64yOg2s4jw6Eb7tpJADSJVB+DeLPxbuLXFeOg9OaWrTS8b1bsVTIDjCD9/L6PkUHe+YyIsd57EcCMHHpeNph4V2CsY91jy73OsGcEghJrLfBLMpnA10GUJ+mj5+MwB95P/e5RvyY7KRz9wmj3/w+sbsPNzjt+/fUD6C2RuRwKFuN9QH4tIdw2jP2WxCDVvfUAeIWNGRSUnTkOmk8AX3rXqfks+wz46I7EC58LUuxS3MsttLm43hmto7XzZOUXitkTZjgbA6a1El1URFA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSAPR01MB2737.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(376002)(39850400004)(366004)(346002)(76116006)(83380400001)(26005)(54906003)(64756008)(66556008)(52536014)(7696005)(66446008)(186003)(53546011)(71200400001)(33656002)(4326008)(66476007)(6506007)(2906002)(86362001)(66946007)(5660300002)(9686003)(8676002)(8936002)(55016002)(6916009)(7416002)(478600001)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?ZXd1bjdZMWUvVWo0aHRNT2tMUlFyQ3B3ZzNjYmZ2cXRrWDhaeGtxVmpwY21r?=
 =?utf-8?B?SDBRK2VNdHdPdzJ4MXF4WVVoUnFIVUNDaXZxMXJwMkNCTHdCQ3J1ZG8rcTBM?=
 =?utf-8?B?cmZXZnJQd2N5T2VrWHYzcTlqNmNsN1hPV2dza01vMC91aUkyOUxPWkNIY2tW?=
 =?utf-8?B?R2tpbytpSTBpeG1lK1NoM2VETkNRSDN0eHJ0MG5BZzhyMFdyT3lML09qRkxn?=
 =?utf-8?B?ZFJKWUtndk5kc1FrTzYyUWd6L1lneEFEOFdSSGtkWnpMaWhhNDlBWTdJejZz?=
 =?utf-8?B?aUxoc2pQRFF3Y0hUMUtYeDRQM1pWL2hLV01hcWVjSGhYaC9LaDlCMy80Ykor?=
 =?utf-8?B?aU1PclJxcHhKVU5raDVHZE5FWjJjMnJMVS9rWjdueDMzdnNMTFQ0T3ZKYWsw?=
 =?utf-8?B?UzkrY3VEbTB2SXZ1Skw3ZVU4S29WdlBhWFFVTit5TmNmVFJaU0dDck9kZEt4?=
 =?utf-8?B?NWpuZmp2bjkvbGVIMWR3Z09HREdINkJrelJEcHpHVnJVYmhlKzhFVyszT2JF?=
 =?utf-8?B?eFhveFBSRHBWTWoyMWVOWUI5UFZucVNudFBmY0J3SHJWSXUzU3NDY1pWcnll?=
 =?utf-8?B?eFpUYnJGdTYrR1krTlB3OURMeXRHUTBQdzAvUDZlcGtMQkdMaWozVHpJa09v?=
 =?utf-8?B?UUI3WnQxbGxqTFlEeW0zNjBaL3lTTm4yVFJIYjZlVWl3ZTdXWHZlWDNUcElG?=
 =?utf-8?B?RGdsbjUrNW40MFJhM0JLZUZldkd3UWU5eXVwR1A1VFQyVmxzYm9tRUhlUit5?=
 =?utf-8?B?N1ZCWkNjZ202VXovVzRqdjR1N1YyNitET2VOSlMwZ0FuL1ZkenUyZjIvTVh6?=
 =?utf-8?B?L2RIUHVadTIyUzNLL0QzaWd5cjFFNjRqd245c2dYNE96NGd6WTdJWHQyNitD?=
 =?utf-8?B?amhZQVpZL214bzVibUszZXprc0pwYjZpempBdzlQQkJNcXNxRHRENjFmSWRI?=
 =?utf-8?B?YnRrS2JXejlwOVFHSGJYZTYzZFoxdEtHZ3hkZWQ1aDdBNmpEbk9vbmgxR3k2?=
 =?utf-8?B?bHEwKzhtNS9zSkVkOVY5ZjRMaHF4aFpkZWJIVUVpSFpLVUdRSjdJc3dwUGVv?=
 =?utf-8?B?d1VXR0VFL0JzRjNFdUdUK3NlWkhrUkNkUE1XdUhwWC9tYjRjNFFlT3ZmRTl0?=
 =?utf-8?B?TkY4aU8rckZEWmg3MVlISFVIZXVXbzZ2UjM1YkRjNVp1U3VMU1ZDSTZxSi94?=
 =?utf-8?B?NU1FNG5pU3hRZHZhZkU2WnZYbGtRbWl0aEQ4VjJKR3RwSFBsUlc5bDExZkti?=
 =?utf-8?B?NktsZVJtTnV5NW1IL3dka25HZFhhSDZHTmpKS292eUxyYzkxWC82K2c0TUlL?=
 =?utf-8?B?OGZpQmliYUVhUnVYQm85dTZmc1hIN3dDRkZmSWo2SHlvS3JJOWViZ3dlTExy?=
 =?utf-8?B?T2x5Vkl6QlBJWFEzT2k1MDliM2UwUUVTNVR0Y3lQSU96eXcrcDk4M3JQcWRG?=
 =?utf-8?B?dHN3Wmp2NnVjR3pKWjU3UXI4SWI0QUN4d2Vpam11Z0NGai9VcThVZUdlQjgx?=
 =?utf-8?B?dXdYRkZTYlhDNkhHOHNIN08vbnJ6bnV2dmJSaU5hdzVDYXhYSy93aERzbStP?=
 =?utf-8?B?M3Q1Q2JueWpvZ0hiS3c2UEEwc0dub01QVW42YnExZDhQOEViOTZUZGpadU1M?=
 =?utf-8?B?WEZoN29PeXUwbnF5Z1Z4K0xMajNzOTZEZUlVZUpQcVVIT0swdTN6YmF6bE9r?=
 =?utf-8?B?enlYYWJaLzRmeGJYdlJ1blV0UkdsM2wwMmlDM2hhZzZLc29MYTlMSUlYTjh1?=
 =?utf-8?Q?adRERZqho89CsP0GIm5B04Whq7/tElQLxCLglyy?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSAPR01MB2737.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 434f33a5-29ed-43b7-18c9-08d8dd758a75
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2021 12:20:17.5078
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X2Trh58QRsorh+jnpvqgAoTBD8EKF9VtjwiT8J1QjOvQKQDD5UzEaFPK2Vw0ej8R11SkqjYzb8QvlvpOuI1ZrijnP6ue1OCQFpJKwb+8VKI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB2471
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

SGVsbG8gRXplcXVpZWwsDQoNCg0KVGhhbmtzIGZvciB5b3VyIGZlZWRiYWNrIQ0KDQo+IEZyb206
IEV6ZXF1aWVsIEdhcmNpYSA8ZXplcXVpZWxAdmFuZ3VhcmRpYXN1ci5jb20uYXI+DQo+IFNlbnQ6
IDAyIE1hcmNoIDIwMjEgMTE6MTcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCA0LzddIG1pc2M6IEFk
ZCBkcml2ZXIgZm9yIERBQiBJUCBmb3VuZCBvbiBSZW5lc2FzIFItDQo+IENhciBkZXZpY2VzDQo+
IA0KPiBIZWxsbyBldmVyeW9uZSwNCj4gDQo+IE9uIE1vbiwgMSBNYXIgMjAyMSBhdCAxNDozNiwg
RmFicml6aW8gQ2FzdHJvDQo+IDxmYWJyaXppby5jYXN0cm8uanpAcmVuZXNhcy5jb20+IHdyb3Rl
Og0KPiA+DQo+ID4gSGkgQXJuZCwNCj4gPg0KPiA+IFRoYW5rcyBmb3IgeW91ciBmZWVkYmFjayEN
Cj4gPg0KPiA+ID4gRnJvbTogQXJuZCBCZXJnbWFubiA8YXJuZEBrZXJuZWwub3JnPg0KPiA+ID4g
U2VudDogMjYgRmVicnVhcnkgMjAyMSAxMDozOA0KPiA+ID4gU3ViamVjdDogUmU6IFtQQVRDSCA0
LzddIG1pc2M6IEFkZCBkcml2ZXIgZm9yIERBQiBJUCBmb3VuZCBvbiBSZW5lc2FzDQo+IFItDQo+
ID4gPiBDYXIgZGV2aWNlcw0KPiA+ID4NCj4gPiA+IE9uIFRodSwgRmViIDI1LCAyMDIxIGF0IDEx
OjUxIFBNIEZhYnJpemlvIENhc3Rybw0KPiA+ID4gPGZhYnJpemlvLmNhc3Ryby5qekByZW5lc2Fz
LmNvbT4gd3JvdGU6DQo+ID4gPiA+DQo+ID4gPiA+IFRoZSBEQUIgaGFyZHdhcmUgYWNjZWxlcmF0
b3IgZm91bmQgb24gUi1DYXIgRTMgYW5kIFItQ2FyIE0zLU4NCj4gZGV2aWNlcyBpcw0KPiA+ID4g
PiBhIGhhcmR3YXJlIGFjY2VsZXJhdG9yIGZvciBzb2Z0d2FyZSBEQUIgZGVtb2R1bGF0b3JzLg0K
PiA+ID4gPiBJdCBjb25zaXN0cyBvZiBvbmUgRkZUIChGYXN0IEZvdXJpZXIgVHJhbnNmb3JtKSBt
b2R1bGUgYW5kIG9uZQ0KPiBkZWNvZGVyDQo+ID4gPiA+IG1vZHVsZSwgY29tcGF0aWJsZSB3aXRo
IERBQiBzcGVjaWZpY2F0aW9uIChFVFNJIEVOIDMwMCA0MDEgYW5kDQo+ID4gPiA+IEVUU0kgVFMg
MTAyIDU2MykuDQo+ID4gPiA+IFRoZSBkZWNvZGVyIG1vZHVsZSBjYW4gcGVyZm9ybSBGSUMgZGVj
b2RpbmcgYW5kIE1TQyBkZWNvZGluZw0KPiBwcm9jZXNzaW5nDQo+ID4gPiA+IGZyb20gZGUtcHVu
Y3R1cmUgdG8gZmluYWwgZGVjb2RlZCByZXN1bHQuDQo+ID4gPiA+DQo+ID4gPiA+IFRoaXMgcGF0
Y2ggYWRkcyBhIGRldmljZSBkcml2ZXIgdG8gc3VwcG9ydCB0aGUgRkZUIG1vZHVsZSBvbmx5Lg0K
PiA+ID4gPg0KPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBGYWJyaXppbyBDYXN0cm8gPGZhYnJpemlv
LmNhc3Ryby5qekByZW5lc2FzLmNvbT4NCj4gPiA+ID4gLS0tDQo+ID4gPiA+ICBNQUlOVEFJTkVS
UyAgICAgICAgICAgICAgICAgICAgICB8ICAgNyArKw0KPiA+ID4gPiAgZHJpdmVycy9taXNjL0tj
b25maWcgICAgICAgICAgICAgfCAgIDEgKw0KPiA+ID4gPiAgZHJpdmVycy9taXNjL01ha2VmaWxl
ICAgICAgICAgICAgfCAgIDEgKw0KPiA+ID4gPiAgZHJpdmVycy9taXNjL3JjYXJfZGFiL0tjb25m
aWcgICAgfCAgMTEgKysNCj4gPiA+ID4gIGRyaXZlcnMvbWlzYy9yY2FyX2RhYi9NYWtlZmlsZSAg
IHwgICA4ICsrDQo+ID4gPiA+ICBkcml2ZXJzL21pc2MvcmNhcl9kYWIvcmNhcl9kZXYuYyB8IDE3
Ng0KPiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+ID4gPiA+ICBkcml2ZXJzL21p
c2MvcmNhcl9kYWIvcmNhcl9kZXYuaCB8IDExNiArKysrKysrKysrKysrKysrKysrKw0KPiA+ID4g
PiAgZHJpdmVycy9taXNjL3JjYXJfZGFiL3JjYXJfZmZ0LmMgfCAxNjAgKysrKysrKysrKysrKysr
KysrKysrKysrKysrKw0KPiA+ID4gPiAgaW5jbHVkZS91YXBpL2xpbnV4L3JjYXJfZGFiLmggICAg
fCAgMzUgKysrKysrDQo+ID4gPg0KPiA+ID4gQ2FuIHlvdSBleHBsYWluIHdoeSB0aGlzIGlzIG5v
dCBpbiBkcml2ZXJzL21lZGlhLz8NCj4gPg0KPiA+IEkgd2Fzbid0IGVudGlyZWx5IHN1cmUgd2Vy
ZSB0byBwdXQgaXQgdG8gYmUgaG9uZXN0IGFzIEkgY291bGRuJ3QgZmluZA0KPiA+IGFueXRoaW5n
IHNpbWlsYXIsIHRoYXQncyB3aHkgIm1pc2MiIGZvciB2MSwgdG8gbWFpbmx5IGdldCBhIGZlZWRi
YWNrDQo+ID4gYW5kIGFkdmljZS4NCj4gPg0KPiA+ID4NCj4gPiA+IEkgZG9uJ3QgdGhpbmsgd2Ug
d2FudCBhIGN1c3RvbSBpb2N0bCBpbnRlcmZhY2UgZm9yIGEgZGV2aWNlIHRoYXQNCj4gPiA+IGlt
cGxlbWVudHMNCj4gPiA+IGEgZ2VuZXJpYyBzcGVjaWZpY2F0aW9uLiBNeSBmaXJzdCBmZWVsaW5n
IHdvdWxkIGJlIHRoYXQgdGhpcyBzaG91bGQNCj4gbm90DQo+ID4gPiBoYXZlIGEgdXNlci1sZXZl
bCBBUEkgYnV0IGluc3RlYWQgZ2V0IGNhbGxlZCBieSB0aGUgREFCIHJhZGlvIGRyaXZlci4NCj4g
Pg0KPiA+IEkgaGVhciB5b3UsIHRoZSB0cm91YmxlIGlzIHRoYXQgdGhlIG1vZHVsZXMgb2YgdGhp
cyBJUCBzaG91bGQgYmUgc2Vlbg0KPiA+IGFzIHBhcnQgb2YgYSBTVyBhbmQgSFcgcHJvY2Vzc2lu
ZyBwaXBlbGluZS4NCj4gPiBTb21lIG9mIHRoZSBTVyBjb21wb25lbnRzIG9mIHRoZSBwaXBlbGlu
ZSBjYW4gYmUgcHJvcHJpZXRhcnksIGFuZA0KPiA+IHVuZm9ydHVuYXRlbHkgd2UgZG9uJ3QgaGF2
ZSBhY2Nlc3MgKHlldCkgdG8gYSBmcmFtZXdvcmsgdGhhdCBhbGxvd3MgdXMNCj4gdG8NCj4gPiB0
ZXN0IGFuZCBkZW1vbnN0cmF0ZSB0aGUgd2hvbGUgcGlwZWxpbmUsIGZvciB0aGUgbW9tZW50IHdl
IGNhbiBvbmx5IHRlc3QNCj4gPiB0aGluZ3MgaW4gaXNvbGF0aW9uLiBJdCdsbCB0YWtlIHVzIGEg
d2hpbGUgdG8gY29tZSB1cCB3aXRoIGEgZnVsbA0KPiBzb2x1dGlvbg0KPiA+IChvciB0byBoYXZl
IGFjY2VzcyB0byBvbmUpLCBhbmQgaW4gdGhlIG1lYW50aW1lIG91ciBTb0NzIGNvbWUgd2l0aCBh
biBJUA0KPiA+IHRoYXQgY2FuJ3QgYmUgdXNlZCBiZWNhdXNlIHRoZXJlIGlzIG5vIGRyaXZlciBm
b3IgaXQgKHlldCkuDQo+ID4NCj4gPiBBZnRlciBkaXNjdXNzaW5nIHRoaW5ncyBmdXJ0aGVyIHdp
dGggR2VlcnQgYW5kIExhdXJlbnQsIEkgdGhpbmsgdGhleQ0KPiA+IGFyZSByaWdodCBpbiBzYXlp
bmcgdGhhdCB0aGUgYmVzdCBwYXRoIGZvciB0aGlzIGlzIHByb2JhYmx5IHRvIGFkZCB0aGlzDQo+
ID4gZHJpdmVyIHVuZGVyICJkcml2ZXJzL3N0YWdpbmciIGFzIGFuIGludGVyaW0gc29sdXRpb24s
IHNvIHRoYXQgdGhlIElQDQo+IHdpbGwNCj4gPiBiZSBhY2Nlc3NpYmxlIGJ5IGRldmVsb3BlcnMs
IGFuZCB3aGVuIHdlIGhhdmUgZXZlcnl0aGluZyB3ZSBuZWVkIChhDQo+IGZ1bGx5DQo+ID4gZmxl
ZGdlZCBwcm9jZXNzaW5nIGZyYW1ld29yayksIHdlIHdpbGwgYWJsZSB0byBpbnRlZ3JhdGUgaXQg
YmV0dGVyIHdpdGgNCj4gPiB0aGUgb3RoZXIgY29tcG9uZW50cyAoaWYgcG9zc2libGUpLg0KPiA+
DQo+ID4gPg0KPiA+ID4gV2hhdCBpcyB0aGUgaW50ZW5kZWQgdXNhZ2UgbW9kZWwgaGVyZT8gSSBh
c3N1bWUgdGhlIGlkZWEgaXMgdG8NCj4gPiA+IHVzZSBpdCBpbiBhbiBhcHBsaWNhdGlvbiB0aGF0
IHJlY2VpdmVzIGF1ZGlvIG9yIG1ldGFkYXRhIGZyb20gREFCLg0KPiA+ID4gV2hhdCBkcml2ZXIg
ZG8geW91IHVzZSBmb3IgdGhhdD8NCj4gPg0KPiA+IFRoaXMgSVAgaXMgc2ltaWxhciB0byBhIERN
QSB0byBzb21lIGV4dGVudCwgaW4gdGhlIHNlbnNlIHRoYXQgaXQgdGFrZXMNCj4gPiBpbnB1dCBk
YXRhIGZyb20gYSBidWZmZXIgaW4gbWVtb3J5IGFuZCBpdCB3cml0ZXMgb3V0cHV0IGRhdGEgb250
byBhDQo+IGJ1ZmZlcg0KPiA+IGluIG1lbW9yeSwgYW5kIG9mIGNvdXJzZSBpdCBkb2VzIHNvbWUg
cHJvY2Vzc2luZyBpbiBiZXR3ZWVuLg0KPiANCj4gVGhhdCBzb3VuZHMgbGlrZSBzb21ldGhpbmcg
dGhhdCBjYW4gZml0IFY0TDIgTUVNMk1FTSBkcml2ZXIuDQo+IFlvdSBxdWV1ZSB0d28gYnVmZmVy
cyBhbmQgYW4gb3BlcmF0aW9uLCBhbmQgdGhlbiBydW4gYSBqb2IuDQoNClY0TDIgTUVNMk1FTSBz
ZWVtcyBnb29kIGZvciB0aGlzIGluIGdlbmVyYWwsIGhvd2V2ZXIgdGhlIERBQiBJUCBpcyBnb2lu
Zw0KdG8gYmUgc2hhcmVkIGJ5IG11bHRpcGxlIHByb2Nlc3NpbmcgcGlwZWxpbmVzIChhcyB1c3Vh
bGx5IHdlIGhhdmUgc2V2ZXJhbA0KRFJJRiBpbnRlcmZhY2VzLCBhbmQgb25seSAxIERBQiBJUCks
IGFuZCBmb3Igd2hhdCBjb25jZXJucyBGRlQgc3BlY2lmaWNhbGx5DQp0aGVyZSBpcyBvbmx5IDEg
RkZUIG1vZHVsZSBpbnNpZGUgdGhlIERBQiBJUC4NCk15IHVuZGVyc3RhbmRpbmcgaXMgdGhhdCB0
aGUgY2FwYWJpbGl0aWVzIG9mIFY0TDIgTUVNMk1FTSBkZXZpY2VzIGFyZQ0KY29uZmlndXJlZCBm
b3IgdGhlIHNwZWNpZmljIHBpcGVsaW5lLCBidXQgaW4gdGhlIHRoaXMgY29udGV4dCB1c2VyIHNw
YWNlDQp3b3VsZCBoYXZlIHRvIGNvbnRpbnVvdXNseSBzd2l0Y2ggdGhlIGNhcGFiaWxpdGllcyBv
ZiB0aGUgREFCIElQIChhdCB0aGUNCnJpZ2h0IG1vbWVudCkgdG8gYWxsb3cgcHJvY2Vzc2luZyBm
b3IgZGF0YSBzdHJlYW1zIHJlcXVpcmluZyBkaWZmZXJlbnQNCmNhcGFiaWxpdGllcy4NCg0KQW0g
SSB3cm9uZz8NCg0KPiANCj4gPiBJdCdzIG5vdCBkaXJlY3RseSBjb25uZWN0ZWQgdG8gYW55IG90
aGVyIFJhZGlvIHJlbGF0ZWQgSVAuDQo+ID4gVGhlIHVzZXIgc3BhY2UgYXBwbGljYXRpb24gY2Fu
IHJlYWQgREFCIElRIHNhbXBsZXMgZnJvbSB0aGUgUi1DYXIgRFJJRg0KPiA+IGludGVyZmFjZSAo
dmlhIGRyaXZlciBkcml2ZXJzL21lZGlhL3BsYXRmb3JtL3JjYXJfZHJpZi5jLCBvciBmcm9tIG90
aGVyDQo+ID4gc291cmNlcyBzaW5jZSB0aGlzIElQIGlzIGRlY291cGxlZCBmcm9tIERSSUYpLCBh
bmQgdGhlbiB3aGVuIGl0J3MgdGltZQ0KPiA+IHRvIGFjY2VsZXJhdGUgRkZULCBGSUMsIG9yIE1T
QywgaXQgY2FuIHJlcXVlc3Qgc2VydmljZXMgdG8gdGhlIERBQiBJUCwNCj4gc28NCj4gPiB0aGF0
IHRoZSBhcHAgY2FuIGdvIG9uIGFuZCB1c2UgdGhlIHByb2Nlc3NvciB0byBkbyBzb21lIHdvcmss
IHdoaWxlIHRoZQ0KPiBEQUINCj4gPiBJUCBwcm9jZXNzZXMgdGhpbmdzLg0KPiA+IEEgZnJhbWV3
b3JrIHRvIGNvbm5lY3QgYW5kIGV4Y2hhbmdlIHByb2Nlc3NpbmcgYmxvY2tzIChlaXRoZXIgU1cg
b3IgSFcpDQo+IGFuZA0KPiA+IGludGVyZmFjZXMgaXMgdGhlcmVmb3JlIHZpdGFsIHRvIHByb3Bl
cmx5IHBsYWNlIGEga2VybmVsIGltcGxlbWVudGF0aW9uDQo+ID4gaW4gdGhlIGdyZWF0IHNjaGVt
ZSBvZiB0aGluZ3MsIGluIGl0cyBhYnNlbmNlIGEgc2ltcGxlIGRyaXZlciBjYW4gaGVscA0KPiAN
Cj4gSSdtIG5vdCBlbnRpcmVseSBzdXJlIHdlIGFyZSBtaXNzaW5nIGEgZnJhbWV3b3JrLiBXaGF0
J3MgbWlzc2luZyBpbg0KPiBWNEwyIE1FTTJNRU0/DQoNCkkgd2FzIHJlZmVycmluZyB0byBhIHVz
ZXIgc3BhY2UgZnJhbWV3b3JrIChJIHNob3VsZCBoYXZlIGJlZW4gbW9yZSBzcGVjaWZpYw0Kd2l0
aCBteSBwcmV2aW91cyBlbWFpbCkuDQoNCj4gDQo+IEJlZm9yZSBjb25zaWRlcmluZyBkcml2ZXJz
L3N0YWdpbmcsIGl0IHdvdWxkIGJlIGludGVyZXN0aW5nIHRvIGZpZ3VyZQ0KPiBvdXQgaWYgVjRM
MiBjYW4gZG8gaXQgYXMtaXMsIGFuZCBpZiBub3QsIGRpc2N1c3Mgd2hhdCdzIG1pc3NpbmcuDQoN
CkkgdGhpbmsgYW4gaW50ZXJpbSBzb2x1dGlvbiB3b3VsZCBhbGxvdyB1cyBhbmQgdXNlcnMgdG8g
ZXZhbHVhdGUgdGhpbmdzIGENCmxpdHRsZSBiaXQgYmV0dGVyLCBzbyB0aGF0IHdlIGNhbiBpbnRl
Z3JhdGUgdGhpcyBJUCB3aXRoIFY0TDIgbGF0ZXIgb24uDQoNClRoYW5rcywNCkZhYg0KDQo+IA0K
PiBUaGFua3MsDQo+IEV6ZXF1aWVsDQo=

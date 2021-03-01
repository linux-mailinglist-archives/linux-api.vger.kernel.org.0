Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9BA132817A
	for <lists+linux-api@lfdr.de>; Mon,  1 Mar 2021 15:56:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236676AbhCAOzZ (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 1 Mar 2021 09:55:25 -0500
Received: from mail-eopbgr1400094.outbound.protection.outlook.com ([40.107.140.94]:5517
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236630AbhCAOzN (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Mon, 1 Mar 2021 09:55:13 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WC/lKtj5K+ygfMIIZhdOXPk982uxlkGkkzUUVfbrPs706PYocqrbN4j+oYab1kYzAW5qB/gVvYXIb1rMZErVX6cCc/2cUs3QfQE0N2nkzRbOBaPdXqPrQTjIWJutxpapoexSWywwRAHycATbz4YB7WvDVEL5zpSS8YZdJfkzoKW33J/o/+YZKCM4LrKDeE8DgGgrq//eCZk2c4IH4Yi/CN/GV9ylapEYUVDi4apRisjj1jV3r522D/LKbYxjvwd+0LxpYw/rxXZfpd1/rEEfL7jA4PgkNmmTpUhx1O3DBqYAYaWxtQsz14hkw5rxnHaa8+gHrPldj9hfaZkq2ndwPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=15F2AHovvT9ptgmVHXtBCSeBYbRWfglfzSbkV8JmIuU=;
 b=HlpTaWFqpUUldcbyKKH9zUPxLtSUoYkTHPCYEWc1wlU7wSsGCcmITGEuZ4oxMigMIt0gNWjwIMfOCi9ATmfwdUpEE2bvRh/mwPeC3z5UBn17xyCvicT3+T5+Sm10cOrKi++qJYcUOQDwcDxJpQSs4sPpxii61LbbpGAuMNlwxsqY9TMXWFJZq/nMMeDKyo8RjTVaVwdhgY1tYo38n+m8U8vF850GhUHIVv2eVFzCYU1KLwikEsGy+RpDEsB6ToKZ9gwVQolCR02pFMGNy7T86RwaPjmzHxCoj0E6oHbdbr3zs0QauQw/eaRzpf5aOz5iiWIVWwLMC5C0ST6MdHUCcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=15F2AHovvT9ptgmVHXtBCSeBYbRWfglfzSbkV8JmIuU=;
 b=oXCZ1fM5Oqmych4Q+yeDNqknMXgrRKxGuj8NswnP6qCMxApCuigdFfw2Apgjz2gH67lSSmOr9MsWMWQ2+eAYcczlNHBw5LcjvXVYZN1Jf9HwLnfhChPcI9Y9Xiyp2NXO1F5CoJ15kCsptUqUnBiW+1kpmNLp0hfn29RlLB2Cqfw=
Received: from OSAPR01MB2737.jpnprd01.prod.outlook.com (2603:1096:603:38::21)
 by OSAPR01MB3905.jpnprd01.prod.outlook.com (2603:1096:604:5f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.25; Mon, 1 Mar
 2021 14:54:17 +0000
Received: from OSAPR01MB2737.jpnprd01.prod.outlook.com
 ([fe80::4d2d:3155:768e:50e0]) by OSAPR01MB2737.jpnprd01.prod.outlook.com
 ([fe80::4d2d:3155:768e:50e0%7]) with mapi id 15.20.3890.028; Mon, 1 Mar 2021
 14:54:17 +0000
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
Subject: RE: [PATCH 6/7] arm64: dts: renesas: r8a77965: Add DAB support
Thread-Topic: [PATCH 6/7] arm64: dts: renesas: r8a77965: Add DAB support
Thread-Index: AQHXC8kH6HUnpdoXVkeKsvkZkp6N1apqLmUAgAUPVyA=
Date:   Mon, 1 Mar 2021 14:54:17 +0000
Message-ID: <OSAPR01MB27372CD25ABCB8CA63A38B17C29A9@OSAPR01MB2737.jpnprd01.prod.outlook.com>
References: <20210225225147.29920-1-fabrizio.castro.jz@renesas.com>
 <20210225225147.29920-7-fabrizio.castro.jz@renesas.com>
 <CAMuHMdUN49Tee2_50037jPvXGh-55bZG03guC1vxkU1TnAaLZQ@mail.gmail.com>
In-Reply-To: <CAMuHMdUN49Tee2_50037jPvXGh-55bZG03guC1vxkU1TnAaLZQ@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linux-m68k.org; dkim=none (message not signed)
 header.d=none;linux-m68k.org; dmarc=none action=none header.from=renesas.com;
x-originating-ip: [2.28.163.123]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 78a5584c-0275-486d-23ad-08d8dcc1e377
x-ms-traffictypediagnostic: OSAPR01MB3905:
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <OSAPR01MB39053E506BC83230BA81BA9FC29A9@OSAPR01MB3905.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VzWGAorSEXzuwS+vc5CtrguvkCwWYDW9cZZD1rCEBpu/uUcB9Sc6IrHxEtSErf7HO7CSJ246rcKj9s7R8e0LOc7kmOdW7uqypYRjMh1o6MEfGoat5c0kIFMXAQ0l1wVtZ+h6MlvpRIDBZ/lOooocydtRtjxf6guSrp+dAuEz+xB8u3myn3hr5Q1dlY5qBq7T5xi/fEugOT0Rse0g6oS3oB3GvSFiFBh4yMNaBpARV+LU8AThFsLGiYwTeby5mWVj5CADqjZfUmhxVP7e+FjZKLyTPed1wpd8qZ91GfG8IxYPABitEmdvO+/FmzzGLkkagEthDzf74XSLD5nCh9OLwvXFzzI8KBRRhFXafumB6M0JxEocoVtXHQ2jVvdDpwSPk/dVMAtlRYTf/+xyw3rZAM7fOoUGYq7XJ0k768aEJ1YjrNFlcYO+5k30GdQqBiO1Ly+kd7JDtIQQflI1hhDSN8COe7f1idiqXrFeUC8pDz4KUmF3k01f+lo+AX7mc/v8PuyhVZcbACtTIxdGS0SzKg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSAPR01MB2737.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(396003)(136003)(346002)(376002)(186003)(7696005)(55016002)(52536014)(4326008)(6506007)(71200400001)(7416002)(66946007)(9686003)(5660300002)(107886003)(26005)(53546011)(6916009)(316002)(83380400001)(54906003)(8676002)(2906002)(478600001)(76116006)(66556008)(64756008)(86362001)(8936002)(66476007)(33656002)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?WStSNU9yS0gyU1pKd0dCWnk1bDZDSCtWKzlIREV5N3ZIVi80Y2NTZDl5NXFq?=
 =?utf-8?B?bkthd1JidFBTVi9uVWZlOThJOG45bWsxdzFUZVNVZEQ4dUtYVG5qSEExVk9P?=
 =?utf-8?B?SmJVT0I1S2xUVGZxeXN0R2xnRlIyUEdiMlpNMkp4RlhjOGR3WGlnYXUwWnc3?=
 =?utf-8?B?SS80R3pFQkJCUkp3RExIZmhpR3NZY0c3eWhLdEYzVU9zNUMzUUp2V2JnR1gy?=
 =?utf-8?B?SUxNd0pLTklmU05Xd0hEdG1zMG1aR3VSWnNXRXozTjFibWZBQ29KMlU3OXhl?=
 =?utf-8?B?RnpHcHNFN0s1cjhYcGdJT3llQmptU0hDTlFGQmVsQ0RBaG1FaVhIaTBMRHg5?=
 =?utf-8?B?RGZET1ZMSmRsYncyWHJ2Sng3bEpPcnZPWVppV3ZUdTU1bTkvVW16bkNncldH?=
 =?utf-8?B?K0RINUZJSkU3YWRYYmZPWDM3Qk5Xd2pIUGF6V0QvNGVvVlVNQ0ptK0s1RDc2?=
 =?utf-8?B?OVUxS0tqajFCaFlPNmNNaW1oaUYyMk5VcTN6bjVLNDJGY3htLzZLc082aDBI?=
 =?utf-8?B?ODJHMFh4MjRzMG93SWdJK056UnlUOTdCSjFoMDNzdGlzR1hlLzBBVDBxcXcx?=
 =?utf-8?B?dWwxdEU3VW9PQjQ3OW9SZUR2NE9rTXZuQlpKN0dLL3JpY1d3cHhNbjV2aHhn?=
 =?utf-8?B?RVNsbnNoK2dqUVRPbTk0K2NmTmU1eXNycTJmUzRVS2pyVDJvZ2V6UXpvVnRk?=
 =?utf-8?B?NUZFWVpKR0pDc294T1FEeXkvd2tjT0dTbzJxOHFBNTNwVnFpRlBhZ0NFMlhL?=
 =?utf-8?B?cTkvVXZQV2xPUkhORVFPRnFncGxzcWtRUXcrVEpYUjRrT2tPMklCN1hIT2tY?=
 =?utf-8?B?aTVwcTFkTGFnVFY1c0pIamxEWXpMZ3hxUk94Q1p6YVB6VTVzSXNQMVZHQnB3?=
 =?utf-8?B?TGtyTTMvQWFJNVUvMFNCd3VyZTcwejZLYm9OR01UWkNueGZMaUZBQ0pTU2Ir?=
 =?utf-8?B?S1dKUjNvd05KblNUbEY2VUo5TExiV2dPb3lRYXRSU2JmWTRQMmVJWHZqSVpr?=
 =?utf-8?B?MDZydk1xN251REc3MzhDUlhOSXpoMGVkQVBNbHg2Y3Y3aS9jTjlaL21KOFpt?=
 =?utf-8?B?TmROb2FzOU1XWDlnRG5DM1JDQ21POUREWXlmWHZpd2xvb0FvcVBBNGdPUUdL?=
 =?utf-8?B?dGwyNE5BazhHc1lnRGJaMHp0QTMzZ0tYZGlBQ1VFT2JFbkNISkpvbDNEdDRk?=
 =?utf-8?B?ZkhYb09WUnFEc3BRcHVteG9oeHlydHBCaWRHNllkVHZIemZwbUdZRUhwZE1C?=
 =?utf-8?B?a1BSWm9mNWVySkFkc0hSUkJXQ2JBZTErV1lqaW1VMHpuSnBDazZadVZvUjNr?=
 =?utf-8?B?dkJHQStWVXovODl5bFl5cXdwWUdJZVgxM2QwODY0eW1UbGdxRUQvcXhmcC9S?=
 =?utf-8?B?LzBnRFNCbW9EZFlEeUtIV0t4RXJJVDNWclF3bG1ZUUh2MlhnSnBiOEM5QzBK?=
 =?utf-8?B?dm4xOXdnOTd1dlNQVi9QMmZsU0NjRmV4WjdFbWwydHpQeXl6TEU3UDRMK0xk?=
 =?utf-8?B?eW00L0VRUEhTeWFVNGcyMFR6VXMzRnhVenRZVTVlbXI2VElma2tpRmNFcEdS?=
 =?utf-8?B?djZEUXFRRGZkRUhZYXIvWDZLSHY5OHRka2YxNHMvZFgxbkJvVE1leFQyUmRu?=
 =?utf-8?B?L21WR0JUMDdlNkU4WWhPckIrd2ZBT3c5aXB4TWNBWmFHZmxTaHFaVmR0bGdm?=
 =?utf-8?B?Vjc5dFVEc1VKS29OS3pyemYyT1FBOXJ4WmdpOGtMSnlZTGV1RnlWLzA0NXM0?=
 =?utf-8?Q?cH7R4Wl47uHA1KrgX+hSs3Fj9+ZEb8nc3l2keub?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSAPR01MB2737.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78a5584c-0275-486d-23ad-08d8dcc1e377
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2021 14:54:17.4460
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zQFR4U1LDqZOxNVUAqX5ASPNmkqgh+YJDS8APBnU52scMUNgENqslIBFOAkG3Y43cL1cUXJTpzcErPB9DSVGNwXGZQMpsfq1usfbYdpyUGM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB3905
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

SGkgR2VlcnQsDQoNClRoYW5rcyBmb3IgeW91IGZlZWRiYWNrIQ0KDQo+IEZyb206IEdlZXJ0IFV5
dHRlcmhvZXZlbiA8Z2VlcnRAbGludXgtbTY4ay5vcmc+DQo+IFNlbnQ6IDI2IEZlYnJ1YXJ5IDIw
MjEgMDk6MzcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCA2LzddIGFybTY0OiBkdHM6IHJlbmVzYXM6
IHI4YTc3OTY1OiBBZGQgREFCIHN1cHBvcnQNCj4gDQo+IEhpIEZhYnJpemlvLA0KPiANCj4gT24g
VGh1LCBGZWIgMjUsIDIwMjEgYXQgMTE6NTMgUE0gRmFicml6aW8gQ2FzdHJvDQo+IDxmYWJyaXpp
by5jYXN0cm8uanpAcmVuZXNhcy5jb20+IHdyb3RlOg0KPiA+IFItQ2FyIE0zLU4gKGEuay5hLiBy
OGE3Nzk2NSkgY29tZXMgd2l0aCB0aGUgREFCIGhhcmR3YXJlIGFjY2VsZXJhdG9yLg0KPiA+IFRo
aXMgcGF0Y2ggYWRkcyBTb0Mgc3BlY2lmaWMgc3VwcG9ydC4NCj4gPg0KPiA+IFNpZ25lZC1vZmYt
Ynk6IEZhYnJpemlvIENhc3RybyA8ZmFicml6aW8uY2FzdHJvLmp6QHJlbmVzYXMuY29tPg0KPiAN
Cj4gTEdUTSAoaWdub3JpbmcgY2xvY2stbmFtZXMgYmlrZXNoZWRkaW5nKQ0KDQpXaWxsIGNoYW5n
ZSB0aGUgY2xvY2sgbmFtZSBhcyBwZXIgeW91ciBzdWdnZXN0aW9uLg0KDQpUaGFua3MsDQpGYWIN
Cg0KPiANCj4gPiAtLS0gYS9hcmNoL2FybTY0L2Jvb3QvZHRzL3JlbmVzYXMvcjhhNzc5NjUuZHRz
aQ0KPiA+ICsrKyBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvcmVuZXNhcy9yOGE3Nzk2NS5kdHNpDQo+
ID4gQEAgLTEwMTMsNiArMTAxMywxOCBAQCBpcG1tdV92cDA6IGlvbW11QGZlOTkwMDAwIHsNCj4g
PiAgICAgICAgICAgICAgICAgICAgICAgICAjaW9tbXUtY2VsbHMgPSA8MT47DQo+ID4gICAgICAg
ICAgICAgICAgIH07DQo+ID4NCj4gPiArICAgICAgICAgICAgICAgZGFiOiBkYWJAZTY3MzAwMDAg
ew0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIGNvbXBhdGlibGUgPSAicmVuZXNhcyxkYWIt
cjhhNzc5NjUiLA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAicmVu
ZXNhcyxyY2FyLWdlbjMtZGFiIjsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICByZWcgPSA8
MHgwMCAweGU2NzMwMDAwIDB4MDAgMHgxMjA+Ow0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAg
IGludGVycnVwdHMgPSA8R0lDX1NQSSAxNjAgSVJRX1RZUEVfTEVWRUxfSElHSD47DQo+ID4gKyAg
ICAgICAgICAgICAgICAgICAgICAgY2xvY2tzID0gPCZjcGcgQ1BHX01PRCAxMDE2PjsNCj4gPiAr
ICAgICAgICAgICAgICAgICAgICAgICBjbG9jay1uYW1lcyA9ICJkYWIiOw0KPiA+ICsgICAgICAg
ICAgICAgICAgICAgICAgIHBvd2VyLWRvbWFpbnMgPSA8JnN5c2MgUjhBNzc5NjVfUERfQUxXQVlT
X09OPjsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICByZXNldHMgPSA8JmNwZyAxMDE2PjsN
Cj4gPiArICAgICAgICAgICAgICAgICAgICAgICBzdGF0dXMgPSAiZGlzYWJsZWQiOw0KPiA+ICsg
ICAgICAgICAgICAgICB9Ow0KPiA+ICsNCj4gPiAgICAgICAgICAgICAgICAgYXZiOiBldGhlcm5l
dEBlNjgwMDAwMCB7DQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgY29tcGF0aWJsZSA9ICJy
ZW5lc2FzLGV0aGVyYXZiLXI4YTc3OTY1IiwNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgInJlbmVzYXMsZXRoZXJhdmItcmNhci1nZW4zIjsNCj4gDQo+IEdye29ldGpl
LGVldGluZ31zLA0KPiANCj4gICAgICAgICAgICAgICAgICAgICAgICAgR2VlcnQNCj4gDQo+IC0t
DQo+IEdlZXJ0IFV5dHRlcmhvZXZlbiAtLSBUaGVyZSdzIGxvdHMgb2YgTGludXggYmV5b25kIGlh
MzIgLS0gZ2VlcnRAbGludXgtDQo+IG02OGsub3JnDQo+IA0KPiBJbiBwZXJzb25hbCBjb252ZXJz
YXRpb25zIHdpdGggdGVjaG5pY2FsIHBlb3BsZSwgSSBjYWxsIG15c2VsZiBhIGhhY2tlci4NCj4g
QnV0DQo+IHdoZW4gSSdtIHRhbGtpbmcgdG8gam91cm5hbGlzdHMgSSBqdXN0IHNheSAicHJvZ3Jh
bW1lciIgb3Igc29tZXRoaW5nIGxpa2UNCj4gdGhhdC4NCj4gICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAtLSBMaW51cyBUb3J2YWxkcw0K

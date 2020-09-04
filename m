Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9975E25DDFB
	for <lists+linux-api@lfdr.de>; Fri,  4 Sep 2020 17:40:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726111AbgIDPk7 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 4 Sep 2020 11:40:59 -0400
Received: from mail-db8eur05on2131.outbound.protection.outlook.com ([40.107.20.131]:21408
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726108AbgIDPk6 (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Fri, 4 Sep 2020 11:40:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GSXG2f4oLoiHDiRT58HpdnM20QprQfwZggTTe/qwUZwjiYB+cUwTcphkD5k2Cy6l17kpzcAFOmC1t9JutgEzJSmtZ0OpaJgzYK2N627aepryIbojDlqWnFCMxigNidp4kH7i+KyhET0GK7ddpd3SAHjL46szaIc0jbjuHFNwBX2HUri9mv8D4iYH5w9lHZ0OrL+cjUTBckQK0W+p45K8j1i6H9LjuZPWxCm0RjSiNKcxpJnArR8UIrP5KulwXpAfm+9RderXO4bBB8SAQtWe7iEjcnXdgip8QTMPT+DWprmM05fMbNO+XqQPp+jGE/ZAD6mvN7tqHYtJcG77UIYz6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LANrDnSyKyLKZIGsN6HYTtTmceB4R8l0fa+FHHrZu8g=;
 b=CfiD7g6rR/XRjRJGhTcNvTD3AQ62hVlv3O6fFKA4kVvWwQE5C+NcxHOq5oRyvEWhqCt+/IarQMLKUKYN9gT8lztum4wfgBy6lJKZHM2UIX+Aqn4PiaVw0mALj+2GaZQAMdB0jtbIziLHvpLMB8wJPiSHBZ0XGvdyX72G1UtWbivW3sm3JAjVxoqZVmcCVYQ7c7ftOOE4e/vA/6zuEZMG86myeJUbVKcNyJc5XAJL/0NzlZK2Gn+DNfYJTQ0cauAcQeuB4PSvr9NU8zxrLRN+jnaU4eVqjUKBYY5sbaQYS/f6XyAmzkvYNGUFIC35raWQ0ycUtiWZpF9PfnnwbOEAaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bitdefender.com; dmarc=pass action=none
 header.from=bitdefender.com; dkim=pass header.d=bitdefender.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bitdefender.onmicrosoft.com; s=selector2-bitdefender-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LANrDnSyKyLKZIGsN6HYTtTmceB4R8l0fa+FHHrZu8g=;
 b=kGF0311jy+DlpKCRxGcJPDe8MdqGI3rg0dLRKtxlzdgbIrMC+ddrGNivEtP9ZHFXkS/szt4UVpKfKpd0DtcUMJv5HJwyZJPSiSxixGPFYaLAmW+JA+eve4T1vTAgW/T1DIphCyET5bV3sWAuehTi7ikdeNH32l5GVHl/luj9DkE=
Received: from AM7PR02MB6082.eurprd02.prod.outlook.com (2603:10a6:20b:1af::16)
 by AM7PR02MB6417.eurprd02.prod.outlook.com (2603:10a6:20b:1b0::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15; Fri, 4 Sep
 2020 15:40:55 +0000
Received: from AM7PR02MB6082.eurprd02.prod.outlook.com
 ([fe80::9dcc:d3cc:dbe:5b33]) by AM7PR02MB6082.eurprd02.prod.outlook.com
 ([fe80::9dcc:d3cc:dbe:5b33%8]) with mapi id 15.20.3348.016; Fri, 4 Sep 2020
 15:40:55 +0000
From:   Mircea CIRJALIU - MELIU <mcirjaliu@bitdefender.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     =?utf-8?B?QWRhbGJlcnQgTGF6xINy?= <alazar@bitdefender.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Graf <graf@amazon.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?utf-8?B?TWloYWkgRG9uyJt1?= <mdontu@bitdefender.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Sargun Dhillon <sargun@sargun.me>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: RE: [RESEND RFC PATCH 0/5] Remote mapping
Thread-Topic: [RESEND RFC PATCH 0/5] Remote mapping
Thread-Index: AQHWgq7sJAwNYCdpy0yn8gtG4wotq6lYY8IAgAAIjBCAAA/agIAACefAgAAG14CAAAt+EA==
Date:   Fri, 4 Sep 2020 15:40:55 +0000
Message-ID: <AM7PR02MB6082C74BEE8285D242F3A03CBB2D0@AM7PR02MB6082.eurprd02.prod.outlook.com>
References: <20200904113116.20648-1-alazar@bitdefender.com>
 <20200904121148.GR24045@ziepe.ca>
 <AM7PR02MB60824E11A81A63A7CE94848CBB2D0@AM7PR02MB6082.eurprd02.prod.outlook.com>
 <20200904133907.GS24045@ziepe.ca>
 <AM7PR02MB6082B1192A87C027DE2FD668BB2D0@AM7PR02MB6082.eurprd02.prod.outlook.com>
 <20200904143903.GT24045@ziepe.ca>
In-Reply-To: <20200904143903.GT24045@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: ziepe.ca; dkim=none (message not signed)
 header.d=none;ziepe.ca; dmarc=none action=none header.from=bitdefender.com;
x-originating-ip: [31.5.46.39]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3e1fd1a3-c594-49f1-0480-08d850e8e960
x-ms-traffictypediagnostic: AM7PR02MB6417:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM7PR02MB6417EF5CCD52BA62E8E853FBBB2D0@AM7PR02MB6417.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tNhrgSPJB+pKKth3Xef4dbxDizjSYFeMNUv2qH//iZs2LdiY8Ly6X4dbJGAWSdS59UJJMkcED2f+tgTBMRfCvjtFJpKebhYatGqW8KlQ5q/d0dA0iEF53x5JWZAczlPC1ndBIM+7XN2bqgkehARjtMK3zVuuTKD+MkIGUPICb50A7ui+AOWfsw34pETekAYZkuLeYAOFi0sZ+TxJy0Al/xpXLJ6wa77F8t2PwaeHLWsXyAm1HH1KiZZIfH7MUpCvImEEeTKZWfV2EX10ADDycu+JRjuIW4HDl11VwYCaa5D83GIXgwDgaHIDVDHJ/Lj0rCliMOfF6snzGOzN3mD79JXKFfsnQ7ykaJdb9OoBeMDiMxkARz1/xH+6VU4RTy9g2ImJUV/fU7dTfxJGv/zRUA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR02MB6082.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(39850400004)(396003)(376002)(346002)(136003)(366004)(83380400001)(86362001)(478600001)(966005)(8676002)(71200400001)(54906003)(316002)(8936002)(55016002)(7416002)(2906002)(52536014)(186003)(6506007)(5660300002)(64756008)(7696005)(76116006)(66946007)(66446008)(66556008)(26005)(6916009)(9686003)(4326008)(66476007)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: rNrQgfyb3zATtJl0lum7Mvb77o9It3KD4FwyWZtZDM32FXlCvZQxtM/D5mqHHJuWygc/31bSHOtxr0g7uCMgqtRO+zNwp0WT+HOTGbSG39jQn/y8ojKyqGxYW2Gmu4wjyZWzRu2yWMEsME2fo9qTv/LbvxeASMOCIdXTke2CYeTEEupBPvbUZOINQkS2c8ktXKQXqZ8WOl/mX6wtHuwmtZtCNIAXSp3w1+DfrYX5Ij636DomMTwQXLxiCeRaY2u5Ojt+etVKVOAfShN0ahzNNqyCF8iFDNUhkMogcpPNo/JnyBnanT2yn8/rT9TZC9Bxa5112ZH9NsJEJS9eEzE31twEknKv0ePl+H1RtHPnxql2OpxX8hNOBOawW2uqJteOt7DiLI8w2wkLngRiCRtxdgiN43E825FgcjWHaIOUUsKN1eCCvlsx5XDr7xvPB0MT6lDieHxgSOcadO+VVMYvIggUMpCeekni4RX/hlPh6Ohv6A9PD68Xk/4jdpNswO2XIqEiC+vOaDbXcULXTBH/uYIqPTuJ3TJn34MujRRfwCPLuzClHOoYmwGYJqq1WjRmolCuPNWM/aAtusUfoaVqHybe76zmwRnc3tM2o3q3CpwysRTf5vj2OoPxFFeSrNYar5PKp/89LqjTQsmuRPH7OA==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bitdefender.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM7PR02MB6082.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e1fd1a3-c594-49f1-0480-08d850e8e960
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2020 15:40:55.0406
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 487baf29-f1da-469a-9221-243f830c36f3
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7qCIR/BaAn9vNVGL+ZvkAP1gcTGkQaIq1/gah0a8DWTWxpu+NmZ+MtAWAUEryekFavSgjshmr9QUKaKdSqWZ6v5i9tSkWwYuQL1TXEn72ZE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR02MB6417
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

PiBPbiBGcmksIFNlcCAwNCwgMjAyMCBhdCAwMjoxODozN1BNICswMDAwLCBNaXJjZWEgQ0lSSkFM
SVUgLSBNRUxJVSB3cm90ZToNCj4gPiA+IFRoaXMgc2VlbXMgcmVhbGx5IHNrZXRjaHksIGdldF91
c2VyX3BhZ2VzIGlzIHNlbnNpdGl2ZSB0byB0aGUgVk1BLA0KPiA+ID4gd2hhdCBoYXBwZW5zIHdo
ZW4gVk1BIGZsYWdzIGFyZSBkaWZmZXJlbnQvZXRjPw0KPiA+DQo+ID4gQSBkZWJ1Z2dlciBzaG91
bGRuJ3QgY29tcGxhaW4gaWYgYSBwb3J0aW9uIG9mIHRoZSBkZWJ1Z2dlZSBpcw0KPiA+IHJlYWQt
b25seSwganVzdCBvdmVyd3JpdGUgdGhlIGRhdGEuDQo+IA0KPiBBdCB0aGlzIHBvaW50IHRoZSBr
ZXJuZWwgQVBJIGhlcmUgaXMgc28gaW5jcmVkaWJseSBsaW1pdGVkIHlvdSBtYXkgYXMgd2VsbCB1
c2UgYQ0KPiBtZW1mZCBmb3IgcGFzc2luZyB0aGUgc2hhcmVkIGFkZHJlc3Mgc3BhY2UgaW5zdGVh
ZCBvZiB0cnlpbmcgdG8gZG8gYW5kDQo+IG1haW50YWluIHRoaXMgY29tcGxleGl0eS4NCj4gDQo+
IFlvdXIgdXNlIGNhc2UgaXMgb25seSBxZW11LCBzbyB3aGF0IGlzIHRoZSBwcm9ibGVtIHRvIHJl
cGxhY2UgdGhlIGFsbG9jYXRvcg0KPiBiYWNraW5nIFZNIG1lbW9yeSBpbiB1c2Vyc3BhY2U/IE90
aGVyIHBlb3BsZSBoYXZlIGJlZW4gdGFsa2luZyBhYm91dA0KPiBkb2luZyBhIG1lbWZkIGFscmVh
ZHkgZm9yIGRpZmZlcmVudCByZWFzb25zIC0gYW5kIG1lbWZkIGNhbiBhbHJlYWR5IGJlDQo+IHNo
YXJlZCBhcyB0aGlzIHNjaGVtZSBkZXNpcmVzLg0KDQpLU00gZG9lc24ndCB3b3JrIG9uIHNobWVt
Lg0KT25jZSB5b3UgcmVwbGFjZSB0aGUgYWxsb2NhdG9yIHlvdSByZW5kZXIgS1NNIHVzZWxlc3Mu
DQoNCkJlc2lkZXMgdGhhdCwgSSBoYWQgYSBtYWlsIG9uY2UgZnJvbSBQYW9sbyBCb256aW5pOg0K
Pj4gSGksDQo+Pg0KPj4gaGVyZSBhdCBGT1NERU0gd2UgZGlzY3Vzc2VkIGhhdmluZyBhIHdheSBm
b3IgYSBwYXJlbnQgcHJvY2VzcyB0byANCj4+IHNwbGl0IHBhcnRzIG9mIGFuIG1tYXAgcmFuZ2Ug
d2l0aCBvbmUgb3IgbW9yZSBjaGlsZCBwcm9jZXNzZXMuICBUaGlzIA0KPj4gdHVybnMgb3V0IHRv
IGJlIGEgZ2VuZXJhbGl6YXRpb24gb2YgdGhlIHJlbW90ZSBtZW1vcnkgbWFwcGluZyBjb25jZXB0
IA0KPj4gdGhhdCBCaXREZWZlbmRlciBwcm9wb3NlZCBmb3IgdmlydHVhbCBtYWNoaW5lIGludHJv
c3BlY3Rpb24gKCANCj4+IGh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcGF0Y2gvMTEyODQ1
NjEvKS4gIFNvIGZhciB0aGUgcGF0Y2hlcyANCj4+IGhhdmVuJ3QgaGFkIGEgZ3JlYXQgcmVjZXB0
aW9uIGZyb20gdGhlIE1NIHBlb3BsZSwgYnV0IGl0IHNob3VsZG4ndCBiZSANCj4+IGhhcmQgdG8g
YWRqdXN0IHRoZSBBUEkgYWNjb3JkaW5nIHRvIHRoZSBza2V0Y2ggYmVsb3cuICBJIGFtIGFsc28g
DQo+PiBpbmNsdWRpbmcgTWlyY2VhIHdobyBpcyB0aGUgYXV0aG9yLg0KPj4NCj4+IFRoZSBwcm9w
b3NlZCBBUEkgaXMgYSBuZXcgcGlkZmQgc3lzdGVtIGNhbGwsIHRocm91Z2ggd2hpY2ggdGhlIHBh
cmVudCANCj4+IGNhbiBtYXAgcG9ydGlvbnMgb2YgaXRzIHZpcnR1YWwgYWRkcmVzcyBzcGFjZSBp
bnRvIGEgZmlsZSBkZXNjcmlwdG9yIA0KPj4gYW5kIHRoZW4gcGFzcyB0aGF0IGZpbGUgZGVzY3Jp
cHRvciB0byBhIGNoaWxkLg0KKHRoZSByZXN0IGNhbiBiZSBmb3VuZCBpbiB0aGUgY292ZXIgbGV0
dGVyKQ0KDQpUaGVyZWZvcmUgSSBoYWQgdG8gZG8gYSBtb2R1bGUgdGhhdCBwZWVrcyBpbnRvIGFu
b24gcHJvY2VzcyBtZW1vcnkuDQpBbmQgYmUgY29tcGF0aWJsZSB3aXRoIEtTTS4gVGhpcyB3YXMg
YW1vbmcgdGhlIHJlcXVpcmVtZW50cyBmb3IgdGhlIGZpcnN0DQp2ZXJzaW9uIG9mIHJlbW90ZSBt
YXBwaW5nLCB3aGljaCBlbmRlZCB1cCBub24tc2NhbGFibGUuDQoNCkZpZ3VyZXMgb3V0IGl0IGNh
biBwZWVrIGludG8gYW55IGtpbmQgb2YgbWVtb3J5IGludm9sdmluZyBwYWdlcy4NCkFsc28gaXQg
ZG9lc24ndCBoYXZlIHRoZSBvdmVyaGVhZCBhc3NvY2lhdGVkIHdpdGggbWFwcGluZyBhIHBhZ2Ug
aW4gYSBWTUEuDQpBbmQgY29tcGFyZWQgdG8gcHRyYWNlKCksIGl0IGNhbiBrZWVwIHRoZSBwYWdl
cyByZXNpZGVudCBhcyBsb25nIGFzIG5lZWRlZC4NCg0KTWlyY2VhDQo=

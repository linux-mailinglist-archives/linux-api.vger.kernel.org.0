Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72837262A5F
	for <lists+linux-api@lfdr.de>; Wed,  9 Sep 2020 10:32:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728363AbgIIIcu (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 9 Sep 2020 04:32:50 -0400
Received: from mail-eopbgr10122.outbound.protection.outlook.com ([40.107.1.122]:54351
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726293AbgIIIcu (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 9 Sep 2020 04:32:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TUIOwEPb+chPrK7BMtMls4hJrWAuRgi5LCIGwWRFdbW3UKO7L2PEzPj0vrIpcr5eedWg2G2yhkTiegPtfUtotFETLsWdsDwwqZ4an+PVKVE3AgOrMh3sCZyoQjabZpx+gULkaE90LceO0KrxtRV9jPZZTDDqf09LOt6cXr1lAPEjWRiO1Hma2RrKcHovm+NgtqCBrpVBrW8wTbhCoLQQV/2ArqFRFm3DaPfAWQBWZc+CjQEUBsC39sV663pEFpGudoAozTUBv22043QxECiLOSvRCiCNsTAjypJUPkNveETlCmQ4Q4L5B/xFUR1KiZMHRmPHpUZ8hNNBMjDQDIBmkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bqPXXhSrNVseNwW3K+rNJDB+ot7RyO3mCFIJex9EpNI=;
 b=cBJu728xt7pBZfbYsxDFA73YRFNrkz2LXNBJjJ0t+WVp09ydt0hlaz+gQKuEAyBc0LDDUxri01qngMoWq5hHyWJ8jKLtLDDDrYv7vj0PgUUGpZCPskmRESwcwsu0zPe/8vKhkc/rk1D11nNazBc86D54p37yMxi/uL1qInBfehfumLi/Z5reqkpki6FunuGKaTZdHE0mVnvqelV/Fz+RxpvNB9CFKYcJh3a7TUDfJ9aQX18dSoZz21Jm7HTS6YDkORrvf+A8N3DRHd7Ggbk6rRyeFPFRWhjxkwPXzUEi6Qlg6xQGf13g+/PB/Ns7CneYoW4FTpbXPTk8uFYT9B8G8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bitdefender.com; dmarc=pass action=none
 header.from=bitdefender.com; dkim=pass header.d=bitdefender.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bitdefender.onmicrosoft.com; s=selector2-bitdefender-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bqPXXhSrNVseNwW3K+rNJDB+ot7RyO3mCFIJex9EpNI=;
 b=aKu4bNceSHq80hLRVTsC7HRqv1E/k2pLjfAOWKtxyWZKEG+GwR1SZc56jFoShKhrQuHwhsilCy4xjHXEthDpXmZoi/bVYOTlDa09b+q8WDj9Q6r/+skhcwNZ0bosfq19SBS58AFKL1uJ1kBGQlam1x0zb0yLqJ7TMJDQTILTmJA=
Received: from AM7PR02MB6082.eurprd02.prod.outlook.com (2603:10a6:20b:1af::16)
 by AM7PR02MB6196.eurprd02.prod.outlook.com (2603:10a6:20b:1a2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15; Wed, 9 Sep
 2020 08:32:43 +0000
Received: from AM7PR02MB6082.eurprd02.prod.outlook.com
 ([fe80::9dcc:d3cc:dbe:5b33]) by AM7PR02MB6082.eurprd02.prod.outlook.com
 ([fe80::9dcc:d3cc:dbe:5b33%8]) with mapi id 15.20.3348.019; Wed, 9 Sep 2020
 08:32:43 +0000
From:   Mircea CIRJALIU - MELIU <mcirjaliu@bitdefender.com>
To:     Oleg Nesterov <oleg@redhat.com>,
        =?utf-8?B?QWRhbGJlcnQgTGF6xINy?= <alazar@bitdefender.com>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
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
        Aleksa Sarai <cyphar@cyphar.com>, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: RE: [RESEND RFC PATCH 4/5] mm/remote_mapping: use a pidfd to access
 memory belonging to unrelated process
Thread-Topic: [RESEND RFC PATCH 4/5] mm/remote_mapping: use a pidfd to access
 memory belonging to unrelated process
Thread-Index: AQHWgq7udc7sgvAgO02/se2hAi+LbKldQWcAgAK1QDA=
Date:   Wed, 9 Sep 2020 08:32:42 +0000
Message-ID: <AM7PR02MB608232256B97797EDE394552BB260@AM7PR02MB6082.eurprd02.prod.outlook.com>
References: <20200904113116.20648-1-alazar@bitdefender.com>
 <20200904113116.20648-5-alazar@bitdefender.com>
 <20200907143008.GB31050@redhat.com>
In-Reply-To: <20200907143008.GB31050@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=bitdefender.com;
x-originating-ip: [31.5.46.39]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f019f4fc-8ab8-425e-670c-08d8549aebed
x-ms-traffictypediagnostic: AM7PR02MB6196:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM7PR02MB61962B2113165B10BB36817EBB260@AM7PR02MB6196.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wnvoAKY+OAPfoWL6BV0UD0qdE2SS6SbnCY5YzGZ96fUuC03Xzqut/u2etkU8/6gc/PbtVZDjW2xZ64flnW9FFaI7CErinRKitI2jIHziEt9l0OOjwrHCaCeI/lAo7o5PM9EJ2h9LNNiO1GeepYAfjHsZjz9OHtai71i+cmBQDsH1kpiqH6ytEMaaj4+skAdp2HlCL69D49C5FaAs+YeCrHZH4jsu43P+jGPftDHwArR1b6Gt0h2IoTvPP1MhOIXo5oSVv/9+AjfbIcPW5og8YCMXE7WBFQcSZ0xiaY8ofutZ0CUEqkxJoQhjC2X4/119gAqnj811wl9gcC7uMobWjQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR02MB6082.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(366004)(346002)(39850400004)(396003)(136003)(4326008)(8676002)(7416002)(7696005)(54906003)(110136005)(8936002)(83380400001)(9686003)(55016002)(2906002)(316002)(186003)(6636002)(66574015)(66556008)(26005)(478600001)(66946007)(6506007)(64756008)(66446008)(66476007)(5660300002)(33656002)(86362001)(76116006)(71200400001)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: /I0HNG37dVXz1b9/pT6jEFsFu4ttCPQCvpjUB052cXYI/BZlIY/s0NjpYdFuAbA75HTsJAUxfcK9j/tQ5zjXg+XjuiKCr8JsTWKdJL9LvrC3YsYbod+LWRd749VXDZ7taukQ12LM1+v7SEF4dbXuxwp5C9ZatA1Nc++0SOau9+08GFPXdhHK4i+lR9rNGlCRG+w0YQwXPmPm6qc7od1knxUi+4Nto7Iq4RObLTynpNMxgUk4vW7Q5Cv/5DzH3Gt4wGHMghqTutff9QGRNNjXCATsm5R8W9DU8Z71idMgFygDPCHiuvYqazgInXNzsrfv1CWx95KgJj9+cP/AlHxSTeF6EuF9BWhycKCWp9fJb19zhnWTvmfE5HfWqerYQp2IHF/8FEjCPgjCfOw0145XwcUM8P9XAFxdV1n/IBQYLgtUJICmHEgIybDhLN66vmIHMBubUL2Zdz5dhlHg6wR5TGTAGqKmOltiXzNbcOmND7ebXmc5AVgb4lcja1xjsaahS+rOMRBMuCNbZ6aPinfaejEmpHgj3xAYz5SlZU2c8dvc5eYvyHpVQriAi2L0cBCcfmSKDOnwpqBi2Lf9hHERpVUWfBgg7BUtawoGvIEJdFqCxVD/bK7l1tHd/WjakOnXMom0npaErT1uXJYKPLWaoQ==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bitdefender.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM7PR02MB6082.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f019f4fc-8ab8-425e-670c-08d8549aebed
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2020 08:32:43.1223
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 487baf29-f1da-469a-9221-243f830c36f3
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yqG8xBkY6RQxLuwkd3O05wuDYMzOOH4bIwwMVfd6JI6CLnnGgF/8at8DnS0O8CBwAMne2j2EDyixIjBDeWnq6FhM0n4aL2BwZxFghWj+3Cg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR02MB6196
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

PiBGcm9tOiBPbGVnIE5lc3Rlcm92IDxvbGVnQHJlZGhhdC5jb20+DQo+IA0KPiBpdCBzZWVtcyB0
aGF0IG5vYm9keSBpcyBnb2luZyB0byByZXZpZXcgdGhpcyBwYXRjaCA7KQ0KPiANCj4gU28gSSB0
cmllZCB0byByZWFkIG1pcnJvcl92bV9mYXVsdCgpIGFuZCB0aGUgdXNhZ2Ugb2YgbW1hcF9zZW0g
ZG9lc24ndA0KPiBsb29rIHJpZ2h0IHRvIG1lLiBCdXQgbGV0IG1lIHJlcGVhdCwgdGhpcyBpcyBu
b3QgbXkgYXJlYSBJIGNhbiBiZSBlYXNpbHkgd3JvbmcsDQo+IHBsZWFzZSBjb3JyZWN0IG1lLg0K
PiANCj4gT24gMDkvMDQsIEFkYWxiZXJ0IExhesSDciB3cm90ZToNCj4gPg0KPiA+ICtzdGF0aWMg
dm1fZmF1bHRfdCBtaXJyb3Jfdm1fZmF1bHQoc3RydWN0IHZtX2ZhdWx0ICp2bWYpIHsNCj4gPiAr
CXN0cnVjdCB2bV9hcmVhX3N0cnVjdCAqdm1hID0gdm1mLT52bWE7DQo+ID4gKwlzdHJ1Y3QgbW1f
c3RydWN0ICptbSA9IHZtYS0+dm1fbW07DQo+ID4gKwlzdHJ1Y3QgcmVtb3RlX3ZtYV9jb250ZXh0
ICpjdHggPSB2bWEtPnZtX3ByaXZhdGVfZGF0YTsNCj4gPiArCXN0cnVjdCByZW1vdGVfdmlldyAq
dmlldyA9IGN0eC0+dmlldzsNCj4gPiArCXN0cnVjdCBmaWxlICpmaWxlID0gdm1hLT52bV9maWxl
Ow0KPiA+ICsJc3RydWN0IHJlbW90ZV9maWxlX2NvbnRleHQgKmZjdHggPSBmaWxlLT5wcml2YXRl
X2RhdGE7DQo+ID4gKwl1bnNpZ25lZCBsb25nIHJlcV9hZGRyOw0KPiA+ICsJdW5zaWduZWQgaW50
IGd1cF9mbGFnczsNCj4gPiArCXN0cnVjdCBwYWdlICpyZXFfcGFnZTsNCj4gPiArCXZtX2ZhdWx0
X3QgcmVzdWx0ID0gVk1fRkFVTFRfU0lHQlVTOw0KPiA+ICsJc3RydWN0IG1tX3N0cnVjdCAqc3Jj
X21tID0gZmN0eC0+bW07DQo+ID4gKwl1bnNpZ25lZCBsb25nIHNlcTsNCj4gPiArCWludCBpZHg7
DQo+ID4gKw0KPiA+ICtmYXVsdF9yZXRyeToNCj4gPiArCXNlcSA9IG1tdV9pbnRlcnZhbF9yZWFk
X2JlZ2luKCZ2aWV3LT5tbWluKTsNCj4gPiArDQo+ID4gKwlpZHggPSBzcmN1X3JlYWRfbG9jaygm
ZmN0eC0+ZmF1bHRfc3JjdSk7DQo+ID4gKw0KPiA+ICsJLyogY2hlY2sgaWYgdmlldyB3YXMgaW52
YWxpZGF0ZWQgKi8NCj4gPiArCWlmICh1bmxpa2VseSghUkVBRF9PTkNFKHZpZXctPnZhbGlkKSkp
IHsNCj4gPiArCQlwcl9kZWJ1ZygiJXM6IHJlZ2lvbiBbJWx4LSVseCkgd2FzIGludmFsaWRhdGVk
ISFcbiIsDQo+IF9fZnVuY19fLA0KPiA+ICsJCQl2aWV3LT5vZmZzZXQsIHZpZXctPm9mZnNldCAr
IHZpZXctPnNpemUpOw0KPiA+ICsJCWdvdG8gb3V0X2ludmFsaWQ7CQkvKiBWTV9GQVVMVF9TSUdC
VVMgKi8NCj4gPiArCX0NCj4gPiArDQo+ID4gKwkvKiBkcm9wIGN1cnJlbnQgbW0gc2VtYXBjaG9y
ZSAqLw0KPiA+ICsJdXBfcmVhZCgmY3VycmVudC0+bW0tPm1tYXBfc2VtKTsNCj4gDQo+IFBsZWFz
ZSB1c2UgbW1hcF9yZWFkX2xvY2svdW5sb2NrKG1tKSBpbnN0ZWFkIG9mDQo+IGRvd24vdXBfcmVh
ZChtbWFwX3NlbSkuDQo+IA0KPiBCdXQgd2h5IGlzIGl0IHNhZmUgdG8gZHJvcCAtPm1tYXBfc2Vt
IHdpdGhvdXQgY2hlY2tpbmcNCj4gRkFVTFRfRkxBR19BTExPV19SRVRSWS9SRVRSWV9OT1dBSVQg
Pw0KPiANCkRyb3BwaW5nIG1tYXBfc2VtIHdpbGwgaGF2ZSB0aGUgc2FtZSBlZmZlY3RzIHJlZ2Fy
ZGxlc3Mgb2YgRkFVTFRfRkxBR19BTExPV19SRVRSWS9SRVRSWV9OT1dBSVQuDQpBbm90aGVyIHRo
cmVhZCBjYW4gdW5tYXAgdGhlIFZNQSBmcm9tIHVuZGVybmVhdGggdXMsIG9yIHJlbWFwIGFub3Ro
ZXIgb25lIGluIGl0cyBwbGFjZS4NCkluIHRoZSBlbmQsIHRoZSBWTUEgaGFzIHRvIGJlIHJldmFs
aWRhdGVkIHdoZW4gcmUtYWNxdWlyaW5nIHRoZSBtbWFwX3NlbS4NCk9yIGFtIEkgd3Jvbmc/IQ0K
DQpUaGUgcmVhc29uIEkgZHJvcHBlZCBtbWFwX3NlbSBpcyBjYXVzZSBJIGhhZCB0byBhY3F1aXJl
IHRoZSByZW1vdGUgbW0tPm1tYXBfc2VtIA0KYW5kIHRyaWVkIHRvIGF2b2lkIGFueSBuZXN0ZWQg
c2VtYXBob3JlIHNjZW5hcmlvcy4NCkFGQUlLIHRoZSBmYXVsdGluZyBydWxlcyBhbGxvdyB1cyB0
byByZXR1cm4gd2l0aCBtbWFwX3NlbSBkcm9wcGVkIHdoZW4gRkFVTFRfRkxBR19BTExPV19SRVRS
WQ0KaXMgc2V0LCBidXQgc3RhdGUgbm90aGluZyBhYm91dCBkcm9wcGluZyBhbmQgcmUtYWNxdWly
aW5nIG1tYXBfc2VtIGluIHRoZSBmYXVsdCBoYW5kbGVyLg0KDQo+ID4gKwkvKiB0YWtlIHJlbW90
ZSBtbSBzZW1hcGhvcmUgKi8NCj4gPiArCWlmICh2bWYtPmZsYWdzICYgRkFVTFRfRkxBR19BTExP
V19SRVRSWSkgew0KPiA+ICsJCWlmICghZG93bl9yZWFkX3RyeWxvY2soJnNyY19tbS0+bW1hcF9z
ZW0pKSB7DQo+IA0KPiBJIGRvbid0IHVuZGVyc3RhbmQgdGhpcy4uLiBwZXJoYXBzIHlvdSBtZWFu
dCBGQVVMVF9GTEFHX1JFVFJZX05PV0FJVCA/DQoNClNlZW1zIHlvdSdyZSByaWdodC4gSSBuZXZl
ciB1bmRlcnN0b29kIHRoZSBkZWZpbml0aW9uIG9mIEZBVUxUX0ZMQUdfUkVUUllfTk9XQUlULg0K
QEZBVUxUX0ZMQUdfUkVUUllfTk9XQUlUOiBEb24ndCBkcm9wIG1tYXBfc2VtIGFuZCB3YWl0IHdo
ZW4gcmV0cnlpbmcuDQpTaG91bGQgaGF2ZSBiZWVuOiBEb24ndCBkcm9wIG1tYXBfc2VtIGFuZCBk
b24ndCB3YWl0IHdoZW4gcmV0cnlpbmcuDQpBbmQgJ0Rvbid0IGRyb3AgbW1hcF9zZW0nIGlzIHN1
cHBvc2VkIHRvIG1lYW46DQovKg0KICAqIE5PVEUhIFRoaXMgd2lsbCBtYWtlIHVzIHJldHVybiB3
aXRoIFZNX0ZBVUxUX1JFVFJZLCBidXQgd2l0aA0KICAqIHRoZSBtbWFwX3NlbSBzdGlsbCBoZWxk
LiBUaGF0J3MgaG93IEZBVUxUX0ZMQUdfUkVUUllfTk9XQUlUDQogICogaXMgc3VwcG9zZWQgdG8g
d29yay4gV2UgaGF2ZSB3YXkgdG9vIG1hbnkgc3BlY2lhbCBjYXNlcy4uDQogICovDQo6figNCg0K
PiA+ICsJICogSWYgRkFVTFRfRkxBR19BTExPV19SRVRSWSBpcyBzZXQsIHRoZSBtbWFwX3NlbSBt
dXN0IGJlDQo+IHJlbGVhc2VkDQo+ID4gKwkgKiBiZWZvcmUgcmV0dXJuaW5nIFZNX0ZBVUxUX1JF
VFJZIG9ubHkgaWYNCj4gRkFVTFRfRkxBR19SRVRSWV9OT1dBSVQgaXMNCj4gPiArCSAqIG5vdCBz
ZXQuDQo+IA0KPiBXZWxsLCBpaXVjIEZBVUxUX0ZMQUdfQUxMT1dfUkVUUlkgbWVhbnMgdGhhdCAt
PmZhdWx0KCkgX2Nhbl8gZHJvcA0KPiBtbWFwX3NlbSBhbmQgcmV0dXJuIFZNX0ZBVUxUX1JFVFJZ
ICh1bmxlc3MgTk9XQUlUKS4NCg0KVGhhdCBjb21tZW50IGlzIGp1c3QgY29waWVkIGZyb20gZWxz
ZXdoZXJlIGluIHRoZSBjb2RlLg0KTXkgaW50ZXJwcmV0YXRpb24gd2FzIHRoYXQgdGhlIGZhdWx0
IGhhbmRsZXIgX3Nob3VsZF8gcmV0dXJuIHdpdGggbW1hcF9zZW0NCmhlbGQgb3Igbm90IGRlcGVu
ZGluZyBvbiBGQVVMVF9GTEFHX1JFVFJZX05PV0FJVC4NCg0KPiA+ICsJaWYgKHZtZi0+ZmxhZ3Mg
JiAoRkFVTFRfRkxBR19BTExPV19SRVRSWSB8DQo+IEZBVUxUX0ZMQUdfVFJJRUQpKSB7DQo+ID4g
KwkJaWYgKCEodm1mLT5mbGFncyAmIEZBVUxUX0ZMQUdfS0lMTEFCTEUpKQ0KPiA+ICsJCQlpZiAo
Y3VycmVudCAmJiBmYXRhbF9zaWduYWxfcGVuZGluZyhjdXJyZW50KSkgew0KPiA+ICsJCQkJdXBf
cmVhZCgmY3VycmVudC0+bW0tPm1tYXBfc2VtKTsNCj4gPiArCQkJCXJldHVybiBWTV9GQVVMVF9S
RVRSWTsNCj4gDQo+IEkgZmFpbCB0byB1bmRlcnN0YW5kIHRoaXMuIEJ1dCBpbiBhbnkgY2FzZSwg
eW91IGRvIG5vdCBuZWVkIHRvIGNoZWNrIGN1cnJlbnQgIT0NCj4gTlVMTCBhbmQgdXBfcmVhZCgp
IGxvb2tzIHdyb25nIGlmIFJFVFJZX05PV0FJVD8NCg0KTXkgYmFkLiBJIGRpZG4ndCBuZWVkIHRv
IGNoZWNrIGN1cnJlbnQgIT0gTlVMTC4gDQpUaGVyZSB3YXMgdGhlIGNhc2Ugd2hlbiB0aGUgZmF1
bHQgd2FzIGludm9rZWQgZnJvbSBhIGt0aHJlYWQgaW4gS1ZNJ3MgYXN5bmNfcGYNCmFuZCBJIGNv
bmZ1c2VkIGN1cnJlbnQgd2l0aCBjdXJyZW50LT5tbS4NCg0KTWlyY2VhDQoNCg==

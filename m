Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8F22284A96
	for <lists+linux-api@lfdr.de>; Tue,  6 Oct 2020 13:02:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725943AbgJFLCa (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 6 Oct 2020 07:02:30 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:19642 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725891AbgJFLCa (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 6 Oct 2020 07:02:30 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 096B1XOW002048;
        Tue, 6 Oct 2020 04:01:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfpt0220;
 bh=18rNlfc6TOqqbE/RitnlBslpMX6lfMlUhaFaSYg83yI=;
 b=KjfJBrJ9zW4eqZOTDr3wB8flTafmV4+etvo/QjkvU0C9pCbRyeK0VZEtZJx7GbbLbDpd
 kN4gK9Z41YlcfIsowXcDzUNTWxNoD6EpFrYRcX3tBLUlqFo0w9LPl+7AShTt3Wo2wsk1
 tRbSerasSPWEz2Z2bqZ0GTI2B88W98tNIcOMGsALf/3dWO/YTqsO8bAqJ9UqC/AlFMkC
 wrRTnQ1IbXs+25wJseOAk2q8MhD0cdHbW1uryJrvgbwCLXDKK/y0A0QQdOjHh1k04pYv
 CnPnJZfCO5YF9wpaVK3cKjXQGMs6jgUC9xOeH1pLgtQw2OMzDo7lTb9yXpYJcBZ1QxoX 3w== 
Received: from sc-exch01.marvell.com ([199.233.58.181])
        by mx0b-0016f401.pphosted.com with ESMTP id 33xrtng2b2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 06 Oct 2020 04:01:53 -0700
Received: from SC-EXCH01.marvell.com (10.93.176.81) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 6 Oct
 2020 04:01:51 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by SC-EXCH01.marvell.com (10.93.176.81) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Tue, 6 Oct 2020 04:01:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dUrEQrpslJv71hniuSwi4Nl3rRe6Cg+DFo6+IhqhmF0gLokmZL4gFej9nc0VbV1Y3yuMTZVVv7Me3tZyPn/PFEZcCCew3ofJZalLsqsTWLXeeHAo9t7YwRoeK32IdrIDa3Uazu56G9SZIMIcZWNWNFPRFeyFH5+RIsENWQPo1uzyBrNyMRKZFZLqyMbsk8XtmAlaY4i697ijenkAX/jKfqYOd/uuDcGPMHD9C0Xn93NpC1e3rZaEDuw5CmYqD58muw0YltvQbx4NOzAQ1NVgJp+BqRLQitDa5501RvqLMxX8Rf/CI9E9P4y5yuimCVHM3gHhIlzqLMvrq4fE9mNSiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=18rNlfc6TOqqbE/RitnlBslpMX6lfMlUhaFaSYg83yI=;
 b=kd0YFQUy+psErHPOv3fsiSEbyIUXZzEcO6L7ZRYveN6JUUEeg8XHdnKR2s0DOacqBs0epBsc0kpoNy1teIPrmhNsGwy6hz77Wp/EnmDAYUxkGAA3BJ/yyrdXtbxFCppmoHdew5LkR68j9d00GMGclCrfuNRknTe9cndby9Ga3JzU69qVmWmdHXz/1Hny8XlbWjR0prWCHtUPWXr9eGTEjExmk7rCX3VzhntN1Xl/2gig19l5hVvZzIGsErbQS9/fpdyUsWZ9KDVqA49N7MH2+LrjLUMfmNBcV5Hh+QTFS73UKpgxkgX+iYA8Ro44n9H4Xz8JTiBDNjmxozZnNSxbpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=18rNlfc6TOqqbE/RitnlBslpMX6lfMlUhaFaSYg83yI=;
 b=bIZNaILJGyhgwU6YVyhUU/OupjzPYHhJ630HakXEVwaNVK8ecwC8M1x3o7RizLPTTHtgl3N4y4pyxpN+swB3c8oLAfNq0utl7/ZJQHRN2+ZyrAVrfcEosEdzdHfiifrwzIvlz5AKFvcFcu5RJteCpN32iI16yA+yFy+wKRaJDOA=
Received: from MW2PR18MB2267.namprd18.prod.outlook.com (2603:10b6:907:3::11)
 by MWHPR1801MB1967.namprd18.prod.outlook.com (2603:10b6:301:63::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.39; Tue, 6 Oct
 2020 11:01:50 +0000
Received: from MW2PR18MB2267.namprd18.prod.outlook.com
 ([fe80::54a1:710f:41a5:c76f]) by MW2PR18MB2267.namprd18.prod.outlook.com
 ([fe80::54a1:710f:41a5:c76f%5]) with mapi id 15.20.3433.045; Tue, 6 Oct 2020
 11:01:49 +0000
From:   Alex Belits <abelits@marvell.com>
To:     "frederic@kernel.org" <frederic@kernel.org>
CC:     "mingo@kernel.org" <mingo@kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        Prasun Kapoor <pkapoor@marvell.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [EXT] Re: [PATCH v4 03/13] task_isolation: userspace hard
 isolation from kernel
Thread-Topic: [EXT] Re: [PATCH v4 03/13] task_isolation: userspace hard
 isolation from kernel
Thread-Index: AQHWYDdZDqoeqvfF50CzG3l43t/UoamDNPAAgATEYwCAAI5YAIACWBIA
Date:   Tue, 6 Oct 2020 11:01:49 +0000
Message-ID: <ed60dc426cfd8a2fe5e389d3a7f36bafa6a8439e.camel@marvell.com>
References: <04be044c1bcd76b7438b7563edc35383417f12c8.camel@marvell.com>
         <b18546567a2ed61073ae86f2d9945257ab285dfa.camel@marvell.com>
         <20201001135640.GA1748@lothringen>
         <7e54b3c5e0d4c91eb64f2dd1583dd687bc34757e.camel@marvell.com>
         <20201004231404.GA66364@lothringen>
In-Reply-To: <20201004231404.GA66364@lothringen>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=marvell.com;
x-originating-ip: [173.228.7.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: def4d9d0-f22a-4d81-0cb4-08d869e7399f
x-ms-traffictypediagnostic: MWHPR1801MB1967:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR1801MB19671EF0429937410119E6B4BC0D0@MWHPR1801MB1967.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bPM/Bf/p8KFGcveS0nMMUsRW7XGBztlljmUa5LSFmBqlClPMhVTRG3vk33ra7KEjZoB5WALKK/+STLr71oB8JO8HiYb2NZZzZRPg7Ju+VfbsDHArIoNLhJOIfCG2wJssC1pf6GbKyxYjQO4M/iXhjH/ypvJTrYoyzE2yMosXZ+qvqR/4r7gTN3KxZZ/miID1ytCPK92iHp/4sJMPMwKiH9xi2/Pob8kfBVBgH9HnLQlbhjRDHwcvf17FiYYrc+meP3TW6BouwFpidO0B9EvvqEbnGd69Nc/J1xOFMgsnUSVQRWJfJZzCEBCBJwq7W3SfLBHA5+cy4i8i5Cem63tB9A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR18MB2267.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(376002)(346002)(366004)(39860400002)(186003)(83380400001)(5660300002)(6916009)(86362001)(36756003)(2906002)(478600001)(26005)(6512007)(54906003)(8936002)(2616005)(66556008)(66446008)(76116006)(7416002)(6506007)(6486002)(4326008)(8676002)(316002)(71200400001)(66476007)(64756008)(91956017)(66946007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: /yMTPfvlhuKlH1MafzKs48wJfuo/Fmzih/0WS9o3pe4wsWjnPitz6OExAnyOFzWYQ/T4kyzbRplTBjkg1gz9vh+bTamuNbilINTZGfRoLJQuV1PcHUkdJWFBFiVpci5AQHwD3ET8s5YFEganUveKrO/5rFuqpi/I8vH6+COjo7recvIZPPTT8B0xsW343lEinhPWwds+mKBanHWDkdQBKvXd+QsUxmHbaC1MLMbiDsKZfZxkZcJpkICE7nLaI8b900EK5VzRBg77b6oBRYFJDjPRf7IWKA9oTqGuOESR4vMALOS9rgAMsL652XDo+IxAaGrZ2ujrxXivIawAaEeerT80hKIATz1Goe2cxvd6xwIfAPm5Iw68iEEePItCXh+RfquwdWTWRKI1hMfptzMO7ZlJayKswkSGEDY18BgL6EbvtpXQPxuK5vE3D1aXurDmKO+kvRD3U+l+FbtxdKaYqpkcLoszUEWC0vlL/0ZqJt+J18JQ/2AreCO1EitE3tjKMbt1tpNKLYNTByP03nxXprnn2o2I4fNEATrIlMGTRCA73Kt9H1zashhyfQ2kZcPvGdCC1qsdl6ENONxCCqqvjBzjIwBiYJWx2qMN2ImMyhJ/Ta0MqlNJKKCy6P54b8/4wdmNCIRIzJu33T8OaJBtuA==
Content-Type: text/plain; charset="utf-8"
Content-ID: <2007B98DE2762943933523B1C0F749CB@namprd18.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR18MB2267.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: def4d9d0-f22a-4d81-0cb4-08d869e7399f
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2020 11:01:49.5803
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xw40xc5pJ2NXbSzKSIBY+UVd6YpSkV/en8+1IYMnKle1o6npK+cNH9ltAKZhgkAVh4u2zFCpweiaRJ02YfTK5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1801MB1967
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-06_03:2020-10-06,2020-10-06 signatures=0
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

T24gTW9uLCAyMDIwLTEwLTA1IGF0IDAxOjE0ICswMjAwLCBGcmVkZXJpYyBXZWlzYmVja2VyIHdy
b3RlOg0KPiBTcGVha2luZyBvZiB3aGljaCwgSSBhZ3JlZSB3aXRoIFRob21hcyB0aGF0IGl0J3Mg
dW5uZWNlc3NhcnkuDQo+ID4gPiBJdCdzDQo+ID4gPiB0b28gbXVjaA0KPiA+ID4gY29kZSBhbmQg
Y29tcGxleGl0eS4gV2UgY2FuIHVzZSB0aGUgZXhpc3RpbmcgdHJhY2UgZXZlbnRzIGFuZA0KPiA+
ID4gcGVyZm9ybQ0KPiA+ID4gdGhlDQo+ID4gPiBhbmFseXNpcyBmcm9tIHVzZXJzcGFjZSB0byBm
aW5kIHRoZSBzb3VyY2Ugb2YgdGhlIGRpc3R1cmJhbmNlLg0KPiA+IA0KPiA+IFRoZSBpZGVhIGJl
aGluZCB0aGlzIGlzIHRoYXQgaXNvbGF0aW9uIGJyZWFraW5nIGV2ZW50cyBhcmUgc3VwcG9zZWQN
Cj4gPiB0bw0KPiA+IGJlIGtub3duIHRvIHRoZSBhcHBsaWNhdGlvbnMgd2hpbGUgYXBwbGljYXRp
b25zIHJ1biBub3JtYWxseSwgYW5kDQo+ID4gdGhleQ0KPiA+IHNob3VsZCBub3QgcmVxdWlyZSBh
bnkgYW5hbHlzaXMgb3IgaHVtYW4gaW50ZXJ2ZW50aW9uIHRvIGJlDQo+ID4gaGFuZGxlZC4NCj4g
DQo+IFN1cmUgYnV0IHlvdSBjYW4gdXNlIHRyYWNlIGV2ZW50cyBmb3IgdGhhdC4gSnVzdCB0cmFj
ZSBpbnRlcnJ1cHRzLA0KPiB3b3JrcXVldWVzLA0KPiB0aW1lcnMsIHN5c2NhbGxzLCBleGNlcHRp
b25zIGFuZCBzY2hlZHVsZXIgZXZlbnRzIGFuZCB5b3UgZ2V0IGFsbCB0aGUNCj4gbG9jYWwNCj4g
ZGlzdHVyYmFuY2UuIFlvdSBtaWdodCB3YW50IHRvIHR1bmUgYSBmZXcgZmlsdGVycyBidXQgdGhh
dCdzIHByZXR0eQ0KPiBtdWNoIGl0Lg0KDQpBbmQga2VlcCBhbGwgdHJhY2luZyBlbmFibGVkIGFs
bCB0aGUgdGltZSwganVzdCB0byBiZSBhYmxlIHRvIGZpZ3VyZQ0Kb3V0IHRoYXQgZGlzdHVyYmFu
Y2UgaGFwcGVuZWQgYXQgYWxsPw0KDQpPciBkbyB5b3UgbWVhbiB0aGF0IHdlIGNhbiB1c2Uga2Vy
bmVsIGVudHJ5IG1lY2hhbmlzbSB0byByZWxpYWJseQ0KZGV0ZXJtaW5lIHRoYXQgaXNvbGF0aW9u
IGJyZWFraW5nIGV2ZW50IGhhcHBlbmVkIChzbyB0aGUgaXNvbGF0aW9uLQ0KYnJlYWtpbmcgcHJv
Y2VkdXJlIGNhbiBiZSB0cmlnZ2VyZWQgYXMgZWFybHkgYXMgcG9zc2libGUpLCB5ZXQgYXZvaWQN
CnRyeWluZyB0byBkZXRlcm1pbmUgd2h5IGV4YWN0bHkgaXQgaGFwcGVuZWQsIGFuZCB1c2UgdHJh
Y2luZyBpZiB3ZSB3YW50DQp0byBrbm93Pw0KDQpPcmlnaW5hbCBwYXRjaCBkaWQgdGhlIG9wcG9z
aXRlLCBpdCB0cmlnZ2VyZWQgYW55IGlzb2xhdGlvbi1icmVha2luZw0KcHJvY2VkdXJlIG9ubHkg
b25jZSBpdCB3YXMga25vd24gc3BlY2lmaWNhbGx5LCB3aGF0IGtpbmQgb2YgZXZlbnQNCmhhcHBl
bmVkIC0tIGEgaGFyZHdhcmUgaW50ZXJydXB0LCBJUEksIHN5c2NhbGwsIHBhZ2UgZmF1bHQsIG9y
IGFueQ0Kb3RoZXIga2luZCBvZiBleGNlcHRpb24sIHBvc3NpYmx5IHNvbWV0aGluZyBhcmNoaXRl
Y3R1cmUtc3BlY2lmaWMuDQpUaGlzLCBvZiBjb3Vyc2UsIGFsd2F5cyBoYWQgYSBwb3RlbnRpYWwg
cHJvYmxlbSB3aXRoIGNvdmVyYWdlIC0tIGlmDQpoYW5kbGluZyBvZiBzb21ldGhpbmcgaXMgbWlz
c2luZywgaXNvbGF0aW9uIGJyZWFraW5nIGlzIG5vdCBoYW5kbGVkIGF0DQphbGwsIGFuZCB0aGVy
ZSBpcyBubyBvYnZpb3VzIHdheSBvZiBmaW5kaW5nIGlmIHdlIGNvdmVyZWQgZXZlcnl0aGluZy4N
ClRoaXMgYWxzbyBtYWRlIHRoZSBwYXRjaCBsYXJnZSBhbmQgc29tZXdoYXQgdWdseS4NCg0KV2hl
biBJIGhhdmUgYWRkZWQgYSBtZWNoYW5pc20gZm9yIGxvdy1sZXZlbCBpc29sYXRpb24gYnJlYWtp
bmcgaGFuZGxpbmcNCm9uIGtlcm5lbCBlbnRyeSwgaXQgYWxzbyBwYXJ0aWFsbHkgaW1wcm92ZWQg
dGhlIHByb2JsZW0gd2l0aA0KY29tcGxldGVuZXNzLiBQYXJ0aWFsbHkgYmVjYXVzZSBJIGhhdmUg
bm90IHlldCBhZGRlZCBoYW5kbGluZyBvZg0KInVua25vd24gY2F1c2UiIGJlZm9yZSByZXR1cm5p
bmcgdG8gdXNlcnNwYWNlLCBob3dldmVyIHRoYXQgd291bGQgYmUgYQ0KbG9naWNhbCB0aGluZyB0
byBkby4gVGhlbiBpZiB3ZSBlbnRlcmVkIGtlcm5lbCBmcm9tIGlzb2xhdGlvbiwgZGlkDQpzb21l
dGhpbmcsIGFuZCBhcmUgcmV0dXJuaW5nIHRvIHVzZXJzcGFjZSBzdGlsbCBub3Qga25vd2luZyB3
aGF0IGtpbmQNCm9mIGlzb2xhdGlvbi1icmVha2luZyBldmVudCBoYXBwZW5lZCwgd2UgY2FuIHN0
aWxsIHRyaWdnZXIgaXNvbGF0aW9uDQpicmVha2luZy4NCg0KRGlkIEkgZ2V0IGl0IHJpZ2h0LCBh
bmQgeW91IG1lYW4gdGhhdCB3ZSBjYW4gcmVtb3ZlIGFsbCBzcGVjaWZpYw0KaGFuZGxpbmcgb2Yg
aXNvbGF0aW9uIGJyZWFraW5nIGNhdXNlcywgZXhjZXB0IGZvciBzeXNjYWxsIHRoYXQgZXhpdHMN
Cmlzb2xhdGlvbiwgYW5kIHJlcG9ydCBpc29sYXRpb24gYnJlYWtpbmcgaW5zdGVhZCBvZiBub3Jt
YWxseSByZXR1cm5pbmcNCnRvIHVzZXJzcGFjZT8gVGhlbiBpc29sYXRpb24gYnJlYWtpbmcgd2ls
bCBiZSBoYW5kbGVkIHJlbGlhYmx5IHdpdGhvdXQNCmtub3dpbmcgdGhlIGNhdXNlLCBhbmQgd2Ug
Y2FuIGxlYXZlIGRldGVybWluaW5nIHRoZSBjYXVzZSB0byB0aGUNCnRyYWNpbmcgbWVjaGFuaXNt
IChpZiBlbmFibGVkKT8NCg0KVGhpcyBkb2VzIG1ha2Ugc2Vuc2UuIEhvd2V2ZXIgZm9yIG1lIGl0
IGxvb2tzIHNvbWV3aGF0IHN0cmFuZ2UsIGJlY2F1c2UNCkkgYXNzdW1lIGlzb2xhdGlvbiBicmVh
a2luZyB0byBiZSBhIGtpbmQgb2YgcnVudGltZSBlcnJvciwgdGhhdA0KdXNlcnNwYWNlIHNvZnR3
YXJlIGlzIHN1cHBvc2VkIHRvIGdldCBzb21lIGJhc2ljIGluZm9ybWF0aW9uIGFib3V0IC0tDQps
aWtlLCBzaWduYWxzIGRpc3Rpbmd1aXNoaW5nIGJldHdlZW4sIHNheSwgU0lHU0VHViBhbmQgU0lH
UElQRSwgb3INCndyaXRlKCkgYmVpbmcgYWJsZSB0byBzZXQgZXJybm8gdG8gRU5PU1BDIG9yIEVJ
Ty4gVGhlbiB1c2Vyc3BhY2UNCnJlY2VpdmVzIGJhc2ljIGluZm9ybWF0aW9uIGFib3V0IHRoZSBj
YXVzZSBvZiBleGNlcHRpb24gb3IgZXJyb3IsIGFuZA0KY2FuIGRvIHNvbWUgbWVhbmluZ2Z1bCBy
ZXBvcnRpbmcsIG9yIGRlY2lkZSBpZiB0aGUgZXJyb3Igc2hvdWxkIGJlDQpmYXRhbCBmb3IgdGhl
IGFwcGxpY2F0aW9uIG9yIGhhbmRsZWQgZGlmZmVyZW50bHksIGJhc2VkIG9uIGl0cyBpbnRlcm5h
bA0KbG9naWMuIFRvIGdldCB0aG9zZSBkaXN0aW5jdGlvbnMsIGFwcGxpY2F0aW9uIGRvZXMgbm90
IGhhdmUgdG8gYmUgYXdhcmUNCm9mIGFueXRoaW5nIGludGVybmFsIHRvIHRoZSBrZXJuZWwuDQoN
ClNpbWlsYXJseSBkaXN0aW5ndWlzaGluZyBiZXR3ZWVuLCBzYXksIGEgcGFnZSBmYXVsdCwgZGV2
aWNlIGludGVycnVwdA0KYW5kIGEgdGltZXIgbWF5IGJlIGltcG9ydGFudCBmb3IgYSBsb2dpYyBp
bXBsZW1lbnRlZCBpbiB1c2Vyc3BhY2UsIGFuZA0KSSB0aGluaywgaXQgbWF5IGJlIG5pY2UgdG8g
YWxsb3cgdXNlcnNwYWNlIHRvIGdldCB0aGlzIGluZm9ybWF0aW9uDQppbW1lZGlhdGVseSBhbmQg
d2l0aG91dCBiZWluZyBhd2FyZSBvZiBhbnkgYWRkaXRpb25hbCBkZXRhaWxzIG9mIGtlcm5lbA0K
aW1wbGVtZW50YXRpb24uIFRoZSBjdXJyZW50IHBhdGNoIGRvZXNuJ3QgZG8gdGhpcyB5ZXQsIGhv
d2V2ZXIgdGhlDQppbnRlbnRpb24gaXMgdG8gaW1wbGVtZW50IHJlbGlhYmxlIGlzb2xhdGlvbiBi
cmVha2luZyBieSBjaGVja2luZyBvbg0KdXNlcnNwYWNlIHJlLWVudHJ5LCBwbHVzIG1ha2UgcmVw
b3J0aW5nIG9mIGNhdXNlcywgaWYgYW55IHdlcmUgZm91bmQsDQp2aXNpYmxlIHRvIHRoZSB1c2Vy
c3BhY2UgaW4gc29tZSBjb252ZW5pZW50IHdheS4NCg0KVGhlIHBhcnQgdGhhdCBkZXRlcm1pbmVz
IHRoZSBjYXVzZSBjYW4gYmUgaW1wbGVtZW50ZWQgc2VwYXJhdGVseSBmcm9tDQppc29sYXRpb24g
YnJlYWtpbmcgbWVjaGFuaXNtLiBUaGVuIHdlIGNhbiBoYXZlIGlzb2xhdGlvbiBicmVha2luZyBv
bg0Ka2VybmVsIGVudHJ5IChvciBwb3RlbnRpYWxseSBzb21lIG90aGVyIGNvbmRpdGlvbiBvbiBr
ZXJuZWwgZW50cnkgdGhhdA0KcmVxdWlyZXMgbG9nZ2luZyB0aGUgY2F1c2UpIGVuYWJsZSByZXBv
cnRpbmcsIHRoZW4gcmVwb3J0aW5nIG1lY2hhbmlzbSwNCmlmIGl0IGV4aXN0cyB3aWxsIGZpbGwg
dGhlIGJsYW5rcywgYW5kIG9uY2UgZWl0aGVyIGNhdXNlIGlzIGtub3duLCBvcg0KaXQncyB0aW1l
IHRvIHJldHVybiB0byB1c2Vyc3BhY2UsIG5vdGlmaWNhdGlvbiB3aWxsIGJlIGRvbmUgd2l0aA0K
d2hhdGV2ZXIgaW5mb3JtYXRpb24gaXMgYXZhaWxhYmxlLiBGb3Igc29tZSBpbi1kZXB0aCBhbmFs
eXNpcywgaWYNCm5lY2Vzc2FyeSBmb3IgZGVidWdnaW5nIHRoZSBrZXJuZWwsIHdlIGNhbiBoYXZl
IHRyYWNpbmcgY2hlY2sgaWYgd2UgYXJlDQppbiB0aGlzICJzdXNwaWNpb3VzIGtlcm5lbCBlbnRy
eSIgbW9kZSwgYW5kIGxvZyB0aGluZ3MgdGhhdCBvdGhlcndpc2UNCndvdWxkIG5vdCBiZS4NCg0K
PiBBcyBmb3IgdGhlIHNvdXJjZSBvZiB0aGUgZGlzdHVyYmFuY2VzLCBpZiB5b3UgcmVhbGx5IG5l
ZWQgdGhhdA0KPiBpbmZvcm1hdGlvbiwNCj4geW91IGNhbiB0cmFjZSB0aGUgd29ya3F1ZXVlIGFu
ZCB0aW1lciBxdWV1ZSBldmVudHMgYW5kIGp1c3QgZmlsdGVyDQo+IHRob3NlIHRoYXQNCj4gdGFy
Z2V0IHlvdXIgaXNvbGF0ZWQgQ1BVcy4NCg0KRm9yIHRoZSBwdXJwb3NlIG9mIGh1bWFuIGRlYnVn
Z2luZyB0aGUga2VybmVsIG9yIGFwcGxpY2F0aW9uLCB0aGUgbW9yZQ0KaW5mb3JtYXRpb24gaXMg
KHVzdWFsbHkpIHRoZSBiZXR0ZXIsIHNvIHRoZSBvbmx5IGNvbmNlcm4gaGVyZSBpcyB0aGF0DQpu
b3cgdXNlciBpcyByZXNwb25zaWJsZSBmb3IgY29tcGxldGVuZXNzIG9mIHRoaW5ncyBoZSBpcyB0
cmFjaW5nLg0KSG93ZXZlciBmcm9tIGFwcGxpY2F0aW9uJ3MgcG9pbnQgb2Ygdmlldywgb3IgZm9y
IGxvZ2dpbmcgaW4gYQ0KcHJvZHVjdGlvbiBlbnZpcm9ubWVudCBpdCdzIHVzdWFsbHkgbW9yZSBp
bXBvcnRhbnQgdG8gZ2V0IGdlbmVyYWwgdHlwZQ0Kb2YgZXZlbnRzLCBzbyBpdCdzIHBvc3NpYmxl
IHRvLCBzYXksIGNvbmZpcm0gdGhhdCBub3RoaW5nICJyZWFsbHkgYmFkIg0KaGFwcGVuZWQsIG9y
IHRvIHRyaWdnZXIgdGhlIGVtZXJnZW5jeSByZXNwb25zZSBpZiBpdCBkaWQuIFNheSwgaWYgdGhl
DQpvbmx5IGNhdXNlcyBvZiBpc29sYXRpb24gYnJlYWtpbmcgd2FzIElQSSB3aXRoaW4gZmV3IG1v
bWVudHMgb2YNCmFwcGxpY2F0aW9uIHN0YXJ0dXAsIG9yIHNpZ25hbCBmcm9tIHNvbWV3aGVyZSBl
bHNlIHdoZW4gYXBwbGljYXRpb24gd2FzDQpyZXN0YXJ0ZWQsIHRoZXJlIGlzIG5vIGNhdXNlIGZv
ciBjb25jZXJuLiBIb3dldmVyIGlmIGhhcmR3YXJlDQppbnRlcnJ1cHRzIGFycml2ZSBhdCByYW5k
b20gcG9pbnRzIGluIHRpbWUsIHNvbWV0aGluZyBpcyBjbGVhcmx5IHdyb25nLg0KQW5kIGlmIHBh
Z2UgZmF1bHRzIGhhcHBlbiwgbW9zdCBsaWtlbHkgYXBwbGljYXRpb24gZm9yZ290IHRvIHBhZ2Ut
aW4NCmFuZCBsb2NrIGl0cyBhZGRyZXNzIHNwYWNlLg0KDQpBZ2FpbiwgaW4gbXkgb3BpbmlvbiB0
aGlzIGlzIG5vdCB1bmxpa2UgcmVwb3J0aW5nIEVOT1NQQyB2cy4gRUlPIHdoaWxlDQpkb2luZyBm
aWxlIEkvTyAtLSB0aGUgZm9ybWVyICh1c3VhbGx5KSBpbmRpY2F0ZXMgYSBjb21tb24gcHJvYmxl
bSB0aGF0DQptYXkgcmVxdWlyZSBhcHBsaWNhdGlvbi1sZXZlbCBjbGVhbnVwLCB0aGUgbGF0dGVy
IChhbHNvIHVzdWFsbHkpIG1lYW5zDQp0aGF0IHNvbWV0aGluZyBpcyBzZXJpb3VzbHkgd3Jvbmcu
DQoNCj4gPiBBIHByb2Nlc3MgbWF5IGV4aXQgaXNvbGF0aW9uIGJlY2F1c2Ugc29tZSBsZWZ0b3Zl
ciBkZWxheWVkIHdvcmssDQo+ID4gZm9yDQo+ID4gZXhhbXBsZSwgYSB0aW1lciBvciBhIHdvcmtx
dWV1ZSwgaXMgc3RpbGwgcHJlc2VudCBvbiBhIENQVSwgb3INCj4gPiBiZWNhdXNlDQo+ID4gYSBw
YWdlIGZhdWx0IG9yIHNvbWUgb3RoZXIgZXhjZXB0aW9uLCBub3JtYWxseSBoYW5kbGVkIHNpbGVu
dGx5LCBpcw0KPiA+IGNhdXNlZCBieSB0aGUgdGFzay4gSXQgaXMgYWxzbyBwb3NzaWJsZSB0byBk
aXJlY3QgYW4gaW50ZXJydXB0IHRvIGENCj4gPiBDUFUNCj4gPiB0aGF0IGlzIHJ1bm5pbmcgYW4g
aXNvbGF0ZWQgdGFzayAtLSBjdXJyZW50bHkgaXQncyBwZXJmZWN0bHkgdmFsaWQNCj4gPiB0bw0K
PiA+IHNldCBpbnRlcnJ1cHQgc21wIGFmZmluaXR5IHRvIGEgQ1BVIHJ1bm5pbmcgaXNvbGF0ZWQg
dGFzaywgYW5kIHRoZW4NCj4gPiBpbnRlcnJ1cHQgd2lsbCBjYXVzZSBicmVha2luZyBpc29sYXRp
b24uIFdoaWxlIGl0J3MgcHJvYmFibHkgbm90DQo+ID4gdGhlDQo+ID4gYmVzdCB3YXkgb2YgaGFu
ZGxpbmcgaW50ZXJydXB0cywgSSB3b3VsZCByYXRoZXIgbm90IHByb2hpYml0IHRoaXMNCj4gPiBl
eHBsaWNpdGx5Lg0KPiANCj4gU3VyZSwgYnV0IHlvdSBjYW4gdHJhY2UgYWxsIHRoZXNlIGV2ZW50
cyB3aXRoIHRoZSBleGlzdGluZyB0cmFjaW5nDQo+IGludGVyZmFjZSB3ZSBoYXZlLg0KDQpSaWdo
dC4gSG93ZXZlciBpdCB3b3VsZCByZXF1aXJlIHNvbWVvbmUgdG8gaW50ZW50aW9uYWxseSBkbyB0
cmFjaW5nIG9mDQphbGwgdGhvc2UgZXZlbnRzLCBhbGwgZm9yIHRoZSBwdXJwb3NlIG9mIG9idGFp
bmluZyBhIHR5cGUgb2YgcnVudGltZQ0KZXJyb3IuIEFzIGFuIGVtYmVkZGVkIHN5c3RlbXMgZGV2
ZWxvcGVyLCB3aG8gaGFkIHRvIGxvb2sgZm9yIHNpZ25zIG9mDQp1bnVzdWFsIGJ1Z3Mgb24gYSBs
YXJnZSBudW1iZXIgb2YgY3VzdG9tZXJzJyBzeXN0ZW1zLCBhbmQgaGFkIHRvDQpkaXN0aW5ndWlz
aCB0aGVtIGZyb20gcmVwb3J0cyBvZiBoYXJkd2FyZSBtYWxmdW5jdGlvbnMsIEkgd291bGQgcHJl
ZmVyDQpzb21ldGhpbmcgY2xlYXJseSBpZGVudGlmaWFibGUgaW4gdGhlIGxvZ3MgKG9mIGtlcm5l
bCwgYXBwbGljYXRpb24sIG9yDQphbnl0aGluZyBlbHNlKSB3aGVuIG5vIG9uZSBpcyBzcGVjaWZp
Y2FsbHkgaW52ZXN0aWdhdGluZyBhbnkgcHJvYmxlbS4NCg0KV2hlbiBhbnl0aGluZyBzdXNwaWNp
b3VzIGhhcHBlbnMsIG9mdGVuIHRoZSBzeXN0ZW0gaXMgcGh5c2ljYWxseQ0KdW5yZWFjaGFibGUs
IGFuZCB0aGUgcHJvYmxlbSBtYXkgb3IgbWF5IG5vdCBoYXBwZW4gYWdhaW4sIHNvIHRoZSBmaXJz
dA0KcmVwb3J0IGZyb20gYSBydW5uaW5nIHN5c3RlbSBtYXkgYmUgdGhlIG9ubHkgdGhpbmcgYXZh
aWxhYmxlLiBXaGVuDQpldmVyeXRoaW5nIGlzIGdvaW5nIHdlbGwsIHRoZSBzYW1lIHN5c3RlbXMg
bW9yZSBvZnRlbiBoYXZlIGhhcmR3YXJlDQpmYWlsdXJlcyB0aGFuIHJlcG9ydCB2YWxpZCBzb2Z0
d2FyZSBidWdzIChvciwgaWRlYWxseSwgYWxsIHJlcG9ydHMgYXJlDQpmcm9tIGhhcmR3YXJlIGZh
aWx1cmVzKSwgc28gaXQncyBtdWNoIGJldHRlciB0byBrbm93IHRoYXQgaWYgc29mdHdhcmUNCndp
bGwgZG8gc29tZXRoaW5nIHdyb25nLCBpdCB3b3VsZCBiZSBwb3NzaWJsZSB0byBpZGVudGlmeSB0
aGUgcHJvYmxlbQ0KZnJvbSB0aGUgZmlyc3QgcmVwb3J0LCByYXRoZXIgdGhhbiBndWVzcy4NCg0K
U29tZXRpbWVzIGVxdWlwbWVudCBnZXRzIGZpcm13YXJlIHVwZGF0ZXMgbWFueSB5ZWFycyBhZnRl
ciBwcm9kdWN0aW9uLA0Kd2hlbiB0aGVyZSBhcmUgcmVwb3J0cyBvZiBhbGwga2luZHMgb2YgZmFp
bHVyZXMgZHVlIHRvIG1lY2hhbmljYWwgb3INCnRoZXJtYWwgZGFtYWdlLCBmYXVsdHkgcGFydHMs
IGJhZCByZXBhaXIgd29yaywgZGV0ZXJpb3JhdGluZyBmbGFzaCwNCmV0Yy4gQW1vbmcgdGhvc2Ug
dGhlcmUgbWlnaHQgYmUgc29tZXRoaW5nIHRoYXQgaW5kaWNhdGVzIG5ldyBidWdzIG1hZGUNCmJ5
IGEgbmV3IGdlbmVyYXRpb24gb2YgZGV2ZWxvcGVycyAob2NjYXNpb25hbGx5IGxpdGVyYWxseSks
DQpyZWdyZXNzaW9ucywgZXRjLiBJbiB0aG9zZSBzaXR1YXRpb25zIGdldHRpbmcgdXNlZnVsIGlu
Zm9ybWF0aW9uIGZyb20NCnRoZSBlcnJvciBtZXNzYWdlIGluIHRoZSBmaXJzdCByZXBvcnQgY2Fu
IG1ha2UgYSBkaWZmZXJlbmNlIGJldHdlZW4NCnF1aWNrbHkgaWRlbnRpZnlpbmcgdGhlIHByb2Js
ZW0gYW5kIGdvaW5nIG9uIGEgd2lsZCBnb29zZSBjaGFzZS4NCg0KLS0gDQpBbGV4DQo=

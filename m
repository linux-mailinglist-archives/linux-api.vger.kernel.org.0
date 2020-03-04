Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D4F1F1794A0
	for <lists+linux-api@lfdr.de>; Wed,  4 Mar 2020 17:12:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728278AbgCDQMO (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 4 Mar 2020 11:12:14 -0500
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:23648 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726561AbgCDQMO (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 4 Mar 2020 11:12:14 -0500
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 024G6KKT027592;
        Wed, 4 Mar 2020 08:11:50 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfpt0818;
 bh=1IXkDM+Te/AKoYU3JaM83/mTvTvMvHJVkHPtCtNOrUM=;
 b=efkDZzcSx/PRH3Ok6MbputY/n0OG+BRxth9T/7llkMyxqzW1BraQkSv9wpc9Gpw4xza1
 wiGzBcCo2l5mmMwTTN+xPmLjyeTPFqJM9KVTvX7aLQTudP7prHS1bVh1I7qK1Pc04EeP
 T6P2FFhtwgNt80jeho8/Ut1qML3k8W5oaMI4gfIwT48TDbeWdGEGZIm2PAZtxqILnCIC
 FsfhsJtHt5OSqJsUEN7Cjfby44JzsaldTkJe+qr+0/IF081mbc10Ap9SxU/s1yJLDhYu
 4E/lNCE3/e+Yrcyc1/VvZuEV//FTkNVHh5bbEgnjGhk2YgjFagBcPzHfnQZkXtlbGxxW 1Q== 
Received: from sc-exch03.marvell.com ([199.233.58.183])
        by mx0a-0016f401.pphosted.com with ESMTP id 2yhxw4d9js-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 04 Mar 2020 08:11:50 -0800
Received: from SC-EXCH02.marvell.com (10.93.176.82) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 4 Mar
 2020 08:11:48 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.174)
 by SC-EXCH02.marvell.com (10.93.176.82) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Wed, 4 Mar 2020 08:11:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A8h7b1mL0jvCvtRSAQ1rALOycOnThn+JZBqwSzeNum0TCb0pF0I9T++o233Q5Oa88fLPsRoMi8h1zXM38knAUMh+MsmIECDOpstWvE8PhpTlEwcmaqzB6eCS4yumXeeyCm1sF24ADpSVizJ4u77OQokqmNby3OlSUEhvUacN6O6vB+1OYXrFC57pPpdlrh29CIKILfHAfwuqQeQO7aBrSEiZE1Yp0L24uUkNWhajL2ay6m+PxJGKsabE+nAeUj66V2xEtd82/EEc/QCopFgUfaabJfMPLH/nvEXv9BL5DmmcRfstkbmCrzp9GB+80yJIINaxmjhEUfk8hS7tuhf7DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1IXkDM+Te/AKoYU3JaM83/mTvTvMvHJVkHPtCtNOrUM=;
 b=eMkL60U+/lXOQsf0Mne6kz+HHuYfopkWRZTpa/u1yWTWyDKbWFG5VF5G0K9Nt5FG/58l4W+tRJQ8Iilmx5FwekWFlqeI/7lSzR8FaUWaKwvGhnu2vmcdOI3FYo1vIeDhQkhlClfA/SyKF99JKPL/aklELPnhNp9vqqhuyF4AbPhyil1GslBzWNYzia60IvQBtCyVruC3N1+jhQ3QVuQJdd/dZwXL42eWpI/keqjQt1JqoVCrGn69azv/JvRy8pdkEeX5rTohV98+KQXBJ1XPiKKmzmT0HiB/s/06ohPaBRK6l+vfDZ41QfnEK1WV4uFrjqo78M+uOiJrIiP8QviCKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1IXkDM+Te/AKoYU3JaM83/mTvTvMvHJVkHPtCtNOrUM=;
 b=GFGSZEK34AoihhsXLrjU6gAHzGOwPCjjoqJV7m7Z4vdJY8JsANfyyPjB0MjLYpOUBilcgK8fRK6FsdZRyn76T/cyTXVD5FxG7h0SwWI7BPhQTQ+26qdh/NY26yCa4re571oRnzF4io/B6c0bppYLpZHXMzlJ47eUecsZqxRnKAQ=
Received: from BYAPR18MB2535.namprd18.prod.outlook.com (2603:10b6:a03:137::17)
 by BYAPR18MB2470.namprd18.prod.outlook.com (2603:10b6:a03:12e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.14; Wed, 4 Mar
 2020 16:11:47 +0000
Received: from BYAPR18MB2535.namprd18.prod.outlook.com
 ([fe80::8cd1:1741:8d2d:1c23]) by BYAPR18MB2535.namprd18.prod.outlook.com
 ([fe80::8cd1:1741:8d2d:1c23%7]) with mapi id 15.20.2772.019; Wed, 4 Mar 2020
 16:11:47 +0000
From:   Alex Belits <abelits@marvell.com>
To:     "frederic@kernel.org" <frederic@kernel.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>
CC:     "mingo@kernel.org" <mingo@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Prasun Kapoor <pkapoor@marvell.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "linux-mm@vger.kernel.org" <linux-mm@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Subject: [PATCH 07/12] task_isolation: arch/arm: enable task isolation
 functionality
Thread-Topic: [PATCH 07/12] task_isolation: arch/arm: enable task isolation
 functionality
Thread-Index: AQHV8j+aD4w1sH5tPE6cJ49VPpXKtg==
Date:   Wed, 4 Mar 2020 16:11:46 +0000
Message-ID: <1c99a9d8d0afea11fd818c0c2b987504adb8a216.camel@marvell.com>
References: <4473787e1b6bc3cc226067e8d122092a678b63de.camel@marvell.com>
In-Reply-To: <4473787e1b6bc3cc226067e8d122092a678b63de.camel@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [199.233.58.128]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6f34d784-d4dd-4d3c-8de1-08d7c056bd62
x-ms-traffictypediagnostic: BYAPR18MB2470:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR18MB2470C3288502DBC748DD3308BCE50@BYAPR18MB2470.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0332AACBC3
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(39860400002)(136003)(366004)(346002)(396003)(199004)(189003)(478600001)(2906002)(8676002)(86362001)(5660300002)(91956017)(6486002)(4326008)(36756003)(76116006)(81166006)(81156014)(2616005)(66446008)(71200400001)(66946007)(66556008)(110136005)(64756008)(316002)(26005)(66476007)(8936002)(54906003)(6506007)(186003)(6512007);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR18MB2470;H:BYAPR18MB2535.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xl+osr9myRaz6IRfDYbGj9hEJQkW2d7jRJSfyEOASaEy30UNywOboZa5ppuWwoSMOrqyIWUuIoEetQvQKbyhPAkcPc0GJO2HOh4UmTSMGRVmEiFb5fd4uH2eK0t5dXOP3Uz0ehPf3AHXkr/NZzQiSwzvNeiBKLZCVPn0YGO6qxB4kVnwni+hBur3bQJWb/RZbIVDRvHLLoMybuRIYV2TK4r6DFc/8AoYhWRRL6E8T1qDzONNQtvDHy9/IJrKMWMzB+q1QAHp2re5L+xlOjK2cU6TfkSdXos2A/Aoa/r76CCfZuy1OuKd8XTaRQx17OJck9BqIzDqKxt29SNHtOYfcWD80QV89bq1AF+Baly57ugU20K8DVissKH5YnbRkoFFy4LRl6Ie5nFkdxaJUFB6/DXRpMHxAjSgI1QLAhbtLkeoFIJCl3hqbic7ruXtQiTz
x-ms-exchange-antispam-messagedata: rVV0XpJpFYlidEa4EzT9WpFouRuz6w4V54RHtfCKq213PjG+rnwtYLfTjN3C9uSDmtQe6dHaN8AfYRZxE/cAIKuIqI4/vz2qPpoonwT20N48TdTT11GG0WJhdY0cACh42UVfsPynuhdhtBjoSQ/rVw==
Content-Type: text/plain; charset="utf-8"
Content-ID: <16D26AAF19DEBE4892F4DEC3B3CB2BE8@namprd18.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f34d784-d4dd-4d3c-8de1-08d7c056bd62
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2020 16:11:46.9699
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XeIy54f9W/r9txPwmpFj6g+GLNgpBZSQpc/2I+KkKO68a+JkH5xNruWVIPHZ5fGel4HGCWhN8IA/iwwIOK1wbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR18MB2470
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-04_05:2020-03-04,2020-03-04 signatures=0
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

RnJvbTogRnJhbmNpcyBHaXJhbGRlYXUgPGZyYW5jaXMuZ2lyYWxkZWF1QGdtYWlsLmNvbT4NCg0K
VGhpcyBwYXRjaCBpcyBhIHBvcnQgb2YgdGhlIHRhc2sgaXNvbGF0aW9uIGZ1bmN0aW9uYWxpdHkg
dG8gdGhlIGFybSAzMi1iaXQNCmFyY2hpdGVjdHVyZS4gVGhlIHRhc2sgaXNvbGF0aW9uIG5lZWRz
IGFuIGFkZGl0aW9uYWwgdGhyZWFkIGZsYWcgdGhhdA0KcmVxdWlyZXMgdG8gY2hhbmdlIHRoZSBl
bnRyeSBhc3NlbWJseSBjb2RlIHRvIGFjY2VwdCBhIGJpdGZpZWxkIGxhcmdlciB0aGFuDQpvbmUg
Ynl0ZS4gVGhlIGNvbnN0YW50cyBfVElGX1NZU0NBTExfV09SSyBhbmQgX1RJRl9XT1JLX01BU0sg
YXJlIG5vdw0KZGVmaW5lZCBpbiB0aGUgbGl0ZXJhbCBwb29sLiBUaGUgcmVzdCBvZiB0aGUgcGF0
Y2ggaXMgc3RyYWlnaHRmb3J3YXJkIGFuZA0KcmVmbGVjdHMgd2hhdCBpcyBkb25lIG9uIG90aGVy
IGFyY2hpdGVjdHVyZXMuDQoNClRvIGF2b2lkIHByb2JsZW1zIHdpdGggdGhlIHRzdCBpbnN0cnVj
dGlvbiBpbiB0aGUgdjdtIGJ1aWxkLCB3ZSByZW51bWJlcg0KVElGX1NFQ0NPTVAgdG8gYml0IDgg
YW5kIGxldCBUSUZfVEFTS19JU09MQVRJT04gdXNlIGJpdCA3Lg0KDQpTaWduZWQtb2ZmLWJ5OiBB
bGV4IEJlbGl0cyA8YWJlbGl0c0BtYXJ2ZWxsLmNvbT4NCi0tLQ0KIGFyY2gvYXJtL0tjb25maWcg
ICAgICAgICAgICAgICAgICAgfCAgMSArDQogYXJjaC9hcm0vaW5jbHVkZS9hc20vdGhyZWFkX2lu
Zm8uaCB8IDEwICsrKysrKystLS0NCiBhcmNoL2FybS9rZXJuZWwvZW50cnktY29tbW9uLlMgICAg
IHwgMTUgKysrKysrKysrKy0tLS0tDQogYXJjaC9hcm0va2VybmVsL3NpZ25hbC5jICAgICAgICAg
ICB8IDEwICsrKysrKysrKy0NCiBhcmNoL2FybS9rZXJuZWwvc21wLmMgICAgICAgICAgICAgIHwg
IDQgKysrKw0KIGFyY2gvYXJtL21tL2ZhdWx0LmMgICAgICAgICAgICAgICAgfCAgOCArKysrKysr
LQ0KIDYgZmlsZXMgY2hhbmdlZCwgMzggaW5zZXJ0aW9ucygrKSwgMTAgZGVsZXRpb25zKC0pDQoN
CmRpZmYgLS1naXQgYS9hcmNoL2FybS9LY29uZmlnIGIvYXJjaC9hcm0vS2NvbmZpZw0KaW5kZXgg
OTc4NjRhYWJjMmE2Li4xYTY2ZTZjNjgwN2MgMTAwNjQ0DQotLS0gYS9hcmNoL2FybS9LY29uZmln
DQorKysgYi9hcmNoL2FybS9LY29uZmlnDQpAQCAtNjcsNiArNjcsNyBAQCBjb25maWcgQVJNDQog
CXNlbGVjdCBIQVZFX0FSQ0hfS0dEQiBpZiAhQ1BVX0VORElBTl9CRTMyICYmIE1NVQ0KIAlzZWxl
Y3QgSEFWRV9BUkNIX01NQVBfUk5EX0JJVFMgaWYgTU1VDQogCXNlbGVjdCBIQVZFX0FSQ0hfU0VD
Q09NUF9GSUxURVIgaWYgQUVBQkkgJiYgIU9BQklfQ09NUEFUDQorCXNlbGVjdCBIQVZFX0FSQ0hf
VEFTS19JU09MQVRJT04NCiAJc2VsZWN0IEhBVkVfQVJDSF9USFJFQURfU1RSVUNUX1dISVRFTElT
VA0KIAlzZWxlY3QgSEFWRV9BUkNIX1RSQUNFSE9PSw0KIAlzZWxlY3QgSEFWRV9BUk1fU01DQ0Mg
aWYgQ1BVX1Y3DQpkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vaW5jbHVkZS9hc20vdGhyZWFkX2luZm8u
aCBiL2FyY2gvYXJtL2luY2x1ZGUvYXNtL3RocmVhZF9pbmZvLmgNCmluZGV4IDBkMGQ1MTc4ZTJj
My4uZWMzYzIwODRjMzkxIDEwMDY0NA0KLS0tIGEvYXJjaC9hcm0vaW5jbHVkZS9hc20vdGhyZWFk
X2luZm8uaA0KKysrIGIvYXJjaC9hcm0vaW5jbHVkZS9hc20vdGhyZWFkX2luZm8uaA0KQEAgLTEz
OSw3ICsxMzksOCBAQCBleHRlcm4gaW50IHZmcF9yZXN0b3JlX3VzZXJfaHdzdGF0ZShzdHJ1Y3Qg
dXNlcl92ZnAgKiwNCiAjZGVmaW5lIFRJRl9TWVNDQUxMX1RSQUNFCTQJLyogc3lzY2FsbCB0cmFj
ZSBhY3RpdmUgKi8NCiAjZGVmaW5lIFRJRl9TWVNDQUxMX0FVRElUCTUJLyogc3lzY2FsbCBhdWRp
dGluZyBhY3RpdmUgKi8NCiAjZGVmaW5lIFRJRl9TWVNDQUxMX1RSQUNFUE9JTlQJNgkvKiBzeXNj
YWxsIHRyYWNlcG9pbnQgaW5zdHJ1bWVudGF0aW9uICovDQotI2RlZmluZSBUSUZfU0VDQ09NUAkJ
NwkvKiBzZWNjb21wIHN5c2NhbGwgZmlsdGVyaW5nIGFjdGl2ZSAqLw0KKyNkZWZpbmUgVElGX1RB
U0tfSVNPTEFUSU9OCTcJLyogdGFzayBpc29sYXRpb24gYWN0aXZlICovDQorI2RlZmluZSBUSUZf
U0VDQ09NUAkJOAkvKiBzZWNjb21wIHN5c2NhbGwgZmlsdGVyaW5nIGFjdGl2ZSAqLw0KIA0KICNk
ZWZpbmUgVElGX05PSFoJCTEyCS8qIGluIGFkYXB0aXZlIG5vaHogbW9kZSAqLw0KICNkZWZpbmUg
VElGX1VTSU5HX0lXTU1YVAkxNw0KQEAgLTE1MywxOCArMTU0LDIxIEBAIGV4dGVybiBpbnQgdmZw
X3Jlc3RvcmVfdXNlcl9od3N0YXRlKHN0cnVjdCB1c2VyX3ZmcCAqLA0KICNkZWZpbmUgX1RJRl9T
WVNDQUxMX1RSQUNFCSgxIDw8IFRJRl9TWVNDQUxMX1RSQUNFKQ0KICNkZWZpbmUgX1RJRl9TWVND
QUxMX0FVRElUCSgxIDw8IFRJRl9TWVNDQUxMX0FVRElUKQ0KICNkZWZpbmUgX1RJRl9TWVNDQUxM
X1RSQUNFUE9JTlQJKDEgPDwgVElGX1NZU0NBTExfVFJBQ0VQT0lOVCkNCisjZGVmaW5lIF9USUZf
VEFTS19JU09MQVRJT04JKDEgPDwgVElGX1RBU0tfSVNPTEFUSU9OKQ0KICNkZWZpbmUgX1RJRl9T
RUNDT01QCQkoMSA8PCBUSUZfU0VDQ09NUCkNCiAjZGVmaW5lIF9USUZfVVNJTkdfSVdNTVhUCSgx
IDw8IFRJRl9VU0lOR19JV01NWFQpDQogDQogLyogQ2hlY2tzIGZvciBhbnkgc3lzY2FsbCB3b3Jr
IGluIGVudHJ5LWNvbW1vbi5TICovDQogI2RlZmluZSBfVElGX1NZU0NBTExfV09SSyAoX1RJRl9T
WVNDQUxMX1RSQUNFIHwgX1RJRl9TWVNDQUxMX0FVRElUIHwgXA0KLQkJCSAgIF9USUZfU1lTQ0FM
TF9UUkFDRVBPSU5UIHwgX1RJRl9TRUNDT01QKQ0KKwkJCSAgIF9USUZfU1lTQ0FMTF9UUkFDRVBP
SU5UIHwgX1RJRl9TRUNDT01QIHwgXA0KKwkJCSAgIF9USUZfVEFTS19JU09MQVRJT04pDQogDQog
LyoNCiAgKiBDaGFuZ2UgdGhlc2UgYW5kIHlvdSBicmVhayBBU00gY29kZSBpbiBlbnRyeS1jb21t
b24uUw0KICAqLw0KICNkZWZpbmUgX1RJRl9XT1JLX01BU0sJCShfVElGX05FRURfUkVTQ0hFRCB8
IF9USUZfU0lHUEVORElORyB8IFwNCi0JCQkJIF9USUZfTk9USUZZX1JFU1VNRSB8IF9USUZfVVBS
T0JFKQ0KKwkJCQkgX1RJRl9OT1RJRllfUkVTVU1FIHwgX1RJRl9VUFJPQkUgfCBcDQorCQkJCSBf
VElGX1RBU0tfSVNPTEFUSU9OKQ0KIA0KICNlbmRpZiAvKiBfX0tFUk5FTF9fICovDQogI2VuZGlm
IC8qIF9fQVNNX0FSTV9USFJFQURfSU5GT19IICovDQpkaWZmIC0tZ2l0IGEvYXJjaC9hcm0va2Vy
bmVsL2VudHJ5LWNvbW1vbi5TIGIvYXJjaC9hcm0va2VybmVsL2VudHJ5LWNvbW1vbi5TDQppbmRl
eCAyNzFjYjhhMWViYTEuLjZjZWI1Y2I4MDhhOSAxMDA2NDQNCi0tLSBhL2FyY2gvYXJtL2tlcm5l
bC9lbnRyeS1jb21tb24uUw0KKysrIGIvYXJjaC9hcm0va2VybmVsL2VudHJ5LWNvbW1vbi5TDQpA
QCAtNTMsNyArNTMsOCBAQCBfX3JldF9mYXN0X3N5c2NhbGw6DQogCWNtcAlyMiwgI1RBU0tfU0la
RQ0KIAlibG5lCWFkZHJfbGltaXRfY2hlY2tfZmFpbGVkDQogCWxkcglyMSwgW3RzaywgI1RJX0ZM
QUdTXQkJQCByZS1jaGVjayBmb3Igc3lzY2FsbCB0cmFjaW5nDQotCXRzdAlyMSwgI19USUZfU1lT
Q0FMTF9XT1JLIHwgX1RJRl9XT1JLX01BU0sNCisJbGRyCXIyLCA9X1RJRl9TWVNDQUxMX1dPUksg
fCBfVElGX1dPUktfTUFTSw0KKwl0c3QJcjEsIHIyDQogCWJuZQlmYXN0X3dvcmtfcGVuZGluZw0K
IA0KIA0KQEAgLTkwLDcgKzkxLDggQEAgX19yZXRfZmFzdF9zeXNjYWxsOg0KIAljbXAJcjIsICNU
QVNLX1NJWkUNCiAJYmxuZQlhZGRyX2xpbWl0X2NoZWNrX2ZhaWxlZA0KIAlsZHIJcjEsIFt0c2ss
ICNUSV9GTEFHU10JCUAgcmUtY2hlY2sgZm9yIHN5c2NhbGwgdHJhY2luZw0KLQl0c3QJcjEsICNf
VElGX1NZU0NBTExfV09SSyB8IF9USUZfV09SS19NQVNLDQorCWxkcglyMiwgPV9USUZfU1lTQ0FM
TF9XT1JLIHwgX1RJRl9XT1JLX01BU0sNCisJdHN0CXIxLCByMg0KIAliZXEJbm9fd29ya19wZW5k
aW5nDQogIFVOV0lORCguZm5lbmQJCSkNCiBFTkRQUk9DKHJldF9mYXN0X3N5c2NhbGwpDQpAQCAt
OTgsNyArMTAwLDggQEAgRU5EUFJPQyhyZXRfZmFzdF9zeXNjYWxsKQ0KIAkvKiBTbG93ZXIgcGF0
aCAtIGZhbGwgdGhyb3VnaCB0byB3b3JrX3BlbmRpbmcgKi8NCiAjZW5kaWYNCiANCi0JdHN0CXIx
LCAjX1RJRl9TWVNDQUxMX1dPUksNCisJbGRyCXIyLCA9X1RJRl9TWVNDQUxMX1dPUksNCisJdHN0
CXIxLCByMg0KIAlibmUJX19zeXNfdHJhY2VfcmV0dXJuX25vc2F2ZQ0KIHNsb3dfd29ya19wZW5k
aW5nOg0KIAltb3YJcjAsIHNwCQkJCUAgJ3JlZ3MnDQpAQCAtMTMxLDcgKzEzNCw4IEBAIEVOVFJZ
KHJldF90b191c2VyX2Zyb21faXJxKQ0KIAljbXAJcjIsICNUQVNLX1NJWkUNCiAJYmxuZQlhZGRy
X2xpbWl0X2NoZWNrX2ZhaWxlZA0KIAlsZHIJcjEsIFt0c2ssICNUSV9GTEFHU10NCi0JdHN0CXIx
LCAjX1RJRl9XT1JLX01BU0sNCisJbGRyCXIyLCA9X1RJRl9XT1JLX01BU0sNCisJdHN0CXIxLCBy
Mg0KIAlibmUJc2xvd193b3JrX3BlbmRpbmcNCiBub193b3JrX3BlbmRpbmc6DQogCWFzbV90cmFj
ZV9oYXJkaXJxc19vbiBzYXZlID0gMA0KQEAgLTI1MSw3ICsyNTUsOCBAQCBsb2NhbF9yZXN0YXJ0
Og0KIAlsZHIJcjEwLCBbdHNrLCAjVElfRkxBR1NdCQlAIGNoZWNrIGZvciBzeXNjYWxsIHRyYWNp
bmcNCiAJc3RtZGIJc3AhLCB7cjQsIHI1fQkJCUAgcHVzaCBmaWZ0aCBhbmQgc2l4dGggYXJncw0K
IA0KLQl0c3QJcjEwLCAjX1RJRl9TWVNDQUxMX1dPUksJCUAgYXJlIHdlIHRyYWNpbmcgc3lzY2Fs
bHM/DQorCWxkcglyMTEsID1fVElGX1NZU0NBTExfV09SSwkJQCBhcmUgd2UgdHJhY2luZyBzeXNj
YWxscz8NCisJdHN0CXIxMCwgcjExDQogCWJuZQlfX3N5c190cmFjZQ0KIA0KIAlpbnZva2Vfc3lz
Y2FsbCB0YmwsIHNjbm8sIHIxMCwgX19yZXRfZmFzdF9zeXNjYWxsDQpkaWZmIC0tZ2l0IGEvYXJj
aC9hcm0va2VybmVsL3NpZ25hbC5jIGIvYXJjaC9hcm0va2VybmVsL3NpZ25hbC5jDQppbmRleCBh
YjI1Njg5OTZkZGIuLmY3NzVjYmNiNzQ4NyAxMDA2NDQNCi0tLSBhL2FyY2gvYXJtL2tlcm5lbC9z
aWduYWwuYw0KKysrIGIvYXJjaC9hcm0va2VybmVsL3NpZ25hbC5jDQpAQCAtMTIsNiArMTIsNyBA
QA0KICNpbmNsdWRlIDxsaW51eC90cmFjZWhvb2suaD4NCiAjaW5jbHVkZSA8bGludXgvdXByb2Jl
cy5oPg0KICNpbmNsdWRlIDxsaW51eC9zeXNjYWxscy5oPg0KKyNpbmNsdWRlIDxsaW51eC9pc29s
YXRpb24uaD4NCiANCiAjaW5jbHVkZSA8YXNtL2VsZi5oPg0KICNpbmNsdWRlIDxhc20vY2FjaGVm
bHVzaC5oPg0KQEAgLTYzOSw2ICs2NDAsOSBAQCBzdGF0aWMgaW50IGRvX3NpZ25hbChzdHJ1Y3Qg
cHRfcmVncyAqcmVncywgaW50IHN5c2NhbGwpDQogCXJldHVybiAwOw0KIH0NCiANCisjZGVmaW5l
IFdPUktfUEVORElOR19MT09QX0ZMQUdTCShfVElGX05FRURfUkVTQ0hFRCB8IF9USUZfU0lHUEVO
RElORyB8CVwNCisJCQkJIF9USUZfTk9USUZZX1JFU1VNRSB8IF9USUZfVVBST0JFKQ0KKw0KIGFz
bWxpbmthZ2UgaW50DQogZG9fd29ya19wZW5kaW5nKHN0cnVjdCBwdF9yZWdzICpyZWdzLCB1bnNp
Z25lZCBpbnQgdGhyZWFkX2ZsYWdzLCBpbnQgc3lzY2FsbCkNCiB7DQpAQCAtNjc2LDcgKzY4MCwx
MSBAQCBkb193b3JrX3BlbmRpbmcoc3RydWN0IHB0X3JlZ3MgKnJlZ3MsIHVuc2lnbmVkIGludCB0
aHJlYWRfZmxhZ3MsIGludCBzeXNjYWxsKQ0KIAkJfQ0KIAkJbG9jYWxfaXJxX2Rpc2FibGUoKTsN
CiAJCXRocmVhZF9mbGFncyA9IGN1cnJlbnRfdGhyZWFkX2luZm8oKS0+ZmxhZ3M7DQotCX0gd2hp
bGUgKHRocmVhZF9mbGFncyAmIF9USUZfV09SS19NQVNLKTsNCisJfSB3aGlsZSAodGhyZWFkX2Zs
YWdzICYgV09SS19QRU5ESU5HX0xPT1BfRkxBR1MpOw0KKw0KKwlpZiAodGhyZWFkX2ZsYWdzICYg
X1RJRl9UQVNLX0lTT0xBVElPTikNCisJCXRhc2tfaXNvbGF0aW9uX3N0YXJ0KCk7DQorDQogCXJl
dHVybiAwOw0KIH0NCiANCmRpZmYgLS1naXQgYS9hcmNoL2FybS9rZXJuZWwvc21wLmMgYi9hcmNo
L2FybS9rZXJuZWwvc21wLmMNCmluZGV4IDQ2ZTFiZTllNTdhOC4uOTVmMTliOTgwNzc2IDEwMDY0
NA0KLS0tIGEvYXJjaC9hcm0va2VybmVsL3NtcC5jDQorKysgYi9hcmNoL2FybS9rZXJuZWwvc21w
LmMNCkBAIC0yNiw2ICsyNiw3IEBADQogI2luY2x1ZGUgPGxpbnV4L2NvbXBsZXRpb24uaD4NCiAj
aW5jbHVkZSA8bGludXgvY3B1ZnJlcS5oPg0KICNpbmNsdWRlIDxsaW51eC9pcnFfd29yay5oPg0K
KyNpbmNsdWRlIDxsaW51eC9pc29sYXRpb24uaD4NCiANCiAjaW5jbHVkZSA8bGludXgvYXRvbWlj
Lmg+DQogI2luY2x1ZGUgPGFzbS9idWdzLmg+DQpAQCAtNTYwLDYgKzU2MSw3IEBAIHZvaWQgYXJj
aF9zZW5kX2NhbGxfZnVuY3Rpb25faXBpX21hc2soY29uc3Qgc3RydWN0IGNwdW1hc2sgKm1hc2sp
DQogDQogdm9pZCBhcmNoX3NlbmRfd2FrZXVwX2lwaV9tYXNrKGNvbnN0IHN0cnVjdCBjcHVtYXNr
ICptYXNrKQ0KIHsNCisJdGFza19pc29sYXRpb25fcmVtb3RlX2NwdW1hc2sobWFzaywgIndha2V1
cCBJUEkiKTsNCiAJc21wX2Nyb3NzX2NhbGwobWFzaywgSVBJX1dBS0VVUCk7DQogfQ0KIA0KQEAg
LTU3OSw2ICs1ODEsNyBAQCB2b2lkIGFyY2hfaXJxX3dvcmtfcmFpc2Uodm9pZCkNCiAjaWZkZWYg
Q09ORklHX0dFTkVSSUNfQ0xPQ0tFVkVOVFNfQlJPQURDQVNUDQogdm9pZCB0aWNrX2Jyb2FkY2Fz
dChjb25zdCBzdHJ1Y3QgY3B1bWFzayAqbWFzaykNCiB7DQorCXRhc2tfaXNvbGF0aW9uX3JlbW90
ZV9jcHVtYXNrKG1hc2ssICJ0aW1lciBJUEkiKTsNCiAJc21wX2Nyb3NzX2NhbGwobWFzaywgSVBJ
X1RJTUVSKTsNCiB9DQogI2VuZGlmDQpAQCAtNzAyLDYgKzcwNSw3IEBAIHZvaWQgaGFuZGxlX0lQ
SShpbnQgaXBpbnIsIHN0cnVjdCBwdF9yZWdzICpyZWdzKQ0KIA0KIHZvaWQgc21wX3NlbmRfcmVz
Y2hlZHVsZShpbnQgY3B1KQ0KIHsNCisJdGFza19pc29sYXRpb25fcmVtb3RlKGNwdSwgInJlc2No
ZWR1bGUgSVBJIik7DQogCXNtcF9jcm9zc19jYWxsKGNwdW1hc2tfb2YoY3B1KSwgSVBJX1JFU0NI
RURVTEUpOw0KIH0NCiANCmRpZmYgLS1naXQgYS9hcmNoL2FybS9tbS9mYXVsdC5jIGIvYXJjaC9h
cm0vbW0vZmF1bHQuYw0KaW5kZXggYmQwZjQ4MjFmN2UxLi5hY2QxMWE2OWM0ZTQgMTAwNjQ0DQot
LS0gYS9hcmNoL2FybS9tbS9mYXVsdC5jDQorKysgYi9hcmNoL2FybS9tbS9mYXVsdC5jDQpAQCAt
MTcsNiArMTcsNyBAQA0KICNpbmNsdWRlIDxsaW51eC9zY2hlZC9kZWJ1Zy5oPg0KICNpbmNsdWRl
IDxsaW51eC9oaWdobWVtLmg+DQogI2luY2x1ZGUgPGxpbnV4L3BlcmZfZXZlbnQuaD4NCisjaW5j
bHVkZSA8bGludXgvaXNvbGF0aW9uLmg+DQogDQogI2luY2x1ZGUgPGFzbS9wZ3RhYmxlLmg+DQog
I2luY2x1ZGUgPGFzbS9zeXN0ZW1fbWlzYy5oPg0KQEAgLTMzMiw4ICszMzMsMTMgQEAgZG9fcGFn
ZV9mYXVsdCh1bnNpZ25lZCBsb25nIGFkZHIsIHVuc2lnbmVkIGludCBmc3IsIHN0cnVjdCBwdF9y
ZWdzICpyZWdzKQ0KIAkvKg0KIAkgKiBIYW5kbGUgdGhlICJub3JtYWwiIGNhc2UgZmlyc3QgLSBW
TV9GQVVMVF9NQUpPUg0KIAkgKi8NCi0JaWYgKGxpa2VseSghKGZhdWx0ICYgKFZNX0ZBVUxUX0VS
Uk9SIHwgVk1fRkFVTFRfQkFETUFQIHwgVk1fRkFVTFRfQkFEQUNDRVNTKSkpKQ0KKwlpZiAobGlr
ZWx5KCEoZmF1bHQgJiAoVk1fRkFVTFRfRVJST1IgfCBWTV9GQVVMVF9CQURNQVAgfA0KKwkJCSAg
ICAgIFZNX0ZBVUxUX0JBREFDQ0VTUykpKSkgew0KKwkJLyogTm8gc2lnbmFsIHdhcyBnZW5lcmF0
ZWQsIGJ1dCBub3RpZnkgdGFzay1pc29sYXRpb24gdGFza3MuICovDQorCQlpZiAodXNlcl9tb2Rl
KHJlZ3MpKQ0KKwkJCXRhc2tfaXNvbGF0aW9uX2ludGVycnVwdCgicGFnZSBmYXVsdCBhdCAlI2x4
IiwgYWRkcik7DQogCQlyZXR1cm4gMDsNCisJfQ0KIA0KIAkvKg0KIAkgKiBJZiB3ZSBhcmUgaW4g
a2VybmVsIG1vZGUgYXQgdGhpcyBwb2ludCwgd2UNCi0tIA0KMi4yMC4xDQoNCg==

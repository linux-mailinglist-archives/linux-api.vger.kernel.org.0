Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0A522C3798
	for <lists+linux-api@lfdr.de>; Wed, 25 Nov 2020 04:41:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726602AbgKYDVt (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 24 Nov 2020 22:21:49 -0500
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:48148 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726532AbgKYDVt (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 24 Nov 2020 22:21:49 -0500
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0AP3KBl7013934;
        Tue, 24 Nov 2020 19:20:38 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfpt0220;
 bh=JmlDDgFD5V/E4vxIzz4pM6tRCjfleqwaAKG2KAcKtYM=;
 b=Y1EFoFrw0NDdL2aapeEA9O2VCCSSwM9zU6Nkg9SXQpuu9APKX2p/S9zSlDkzl4LDT6yZ
 HqQ08BvrUll2TGS5BmE8+JjpQOGegj+byzt7nhsKcR/HhQPK4xWDZeDytcsBdpmNeGT1
 KYEIf4NCuwIC3C65kCMOdy7N9MYI6iLJo8JifC7uLuElAp0eDPO847DXXkvCE2/pH++k
 IJOSr3cMILC2UwUXdSOyb9OLDnwcw22x2llMJ/iPkHI4lzwONp9ge/tE+EzXs6SDSLU/
 yUzkRDRH8X/5v+eSbn28dBXFjxv0LK1yAGr+CGPgD2k7fKqxi0PuQeSCtExr7kF/dB8N Gw== 
Received: from sc-exch02.marvell.com ([199.233.58.182])
        by mx0a-0016f401.pphosted.com with ESMTP id 34y14ucsam-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 24 Nov 2020 19:20:38 -0800
Received: from SC-EXCH04.marvell.com (10.93.176.84) by SC-EXCH02.marvell.com
 (10.93.176.82) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 24 Nov
 2020 19:20:36 -0800
Received: from SC-EXCH01.marvell.com (10.93.176.81) by SC-EXCH04.marvell.com
 (10.93.176.84) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 24 Nov
 2020 19:20:37 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.36.55) by
 SC-EXCH01.marvell.com (10.93.176.81) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Tue, 24 Nov 2020 19:20:36 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rghtfb/0DCZEhW4B2dHOQW4dlqugAa9ZMPZbsRdK4cKrIgE1rHxsRQ/1sRzZQUj2fiZ1YGIgGw7OMiE+zM1MsHuq3wIgRK+tvj1VcCdikYGZudkezEoxdFM5epAoHL0vijzh9a+xZBqJomQD3YPxGnrQrEhyJT+59jDbr3jmFucfqqFkh+Km0teG0THuUGkuB0sw3tql4YxojH8oCKzPH7YWfj9ZBYZqyTf0cezKPkmPXV/SA1U0AVuCTfkpf838iLBeKV9M4Fbl/4QMm7FKjOdyXb2uxm/L8p+KZKaIvnl7m7+W9AQ143Lyh4LWcaT+Ctk6CBRJfYXv4bTGsElHZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JmlDDgFD5V/E4vxIzz4pM6tRCjfleqwaAKG2KAcKtYM=;
 b=MpG9DF3Ng7u3dOpYVlJ8ngKA9Cm2s9oHNabG4Wru+ikdCW8RXM/CwwidjFTIx4AKA4C2X9LIJsGqGgT+WYAf1J6GirE+7jeXBYzJMFcTxjtVUzOzsiHTWAE/iu9Q/XASgHCv5M1K/CyK3RJLWZWJ4/czigwW8ZqK+9LHxmYsHPJqJIDMaq0T6giaLzyNO/AfsoSDsLSHTjBRZ8P306ekWVHRN61dsLlu4ADZBUb0/wtGL9jq/PXKiXwOhecRcmNu6vhIm61GGvB9XOEzByGo9a+X6FqGY3sF/HGe0Wp0n+zmCbJJ/bl3A94y1Zqxjt4TGlxCNtsjExF3baPAvZfqTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JmlDDgFD5V/E4vxIzz4pM6tRCjfleqwaAKG2KAcKtYM=;
 b=M2ndBrzAl3GOCUMh7yBqkALHQYDHmh9kqDC7Qiw5kB4vRj37VxHLop8MNiI92p065bBA7eaSSAsc0nrKhtzkw/bkJGJpm3um6C5DQ3BGk0D28Emb9G7qKIKq5JzwQxRAeuQX5u78Pkb2dXJ/Z73soyEJPRIiANX3ahTAQw+Vpko=
Received: from MW2PR18MB2267.namprd18.prod.outlook.com (2603:10b6:907:3::11)
 by MWHPR18MB1440.namprd18.prod.outlook.com (2603:10b6:320:2c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.22; Wed, 25 Nov
 2020 03:20:35 +0000
Received: from MW2PR18MB2267.namprd18.prod.outlook.com
 ([fe80::e17f:37fb:4eb3:c703]) by MW2PR18MB2267.namprd18.prod.outlook.com
 ([fe80::e17f:37fb:4eb3:c703%4]) with mapi id 15.20.3564.039; Wed, 25 Nov 2020
 03:20:34 +0000
From:   Alex Belits <abelits@marvell.com>
To:     "frederic@kernel.org" <frederic@kernel.org>
CC:     Prasun Kapoor <pkapoor@marvell.com>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "trix@redhat.com" <trix@redhat.com>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "peterx@redhat.com" <peterx@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "nitesh@redhat.com" <nitesh@redhat.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "mtosatti@redhat.com" <mtosatti@redhat.com>,
        "will@kernel.org" <will@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "leon@sidebranch.com" <leon@sidebranch.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "pauld@redhat.com" <pauld@redhat.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [EXT] Re: [PATCH v5 9/9] task_isolation: kick_all_cpus_sync:
 don't kick isolated cpus
Thread-Topic: [EXT] Re: [PATCH v5 9/9] task_isolation: kick_all_cpus_sync:
 don't kick isolated cpus
Thread-Index: AQHWwcJHihlNClCxdEOODDjRi5wCaKnWTJeAgAAC64CAAAucAIAB1ToA
Date:   Wed, 25 Nov 2020 03:20:34 +0000
Message-ID: <45bb2800f2c966ed04ced8dfa85615c377fac4b2.camel@marvell.com>
References: <8d887e59ca713726f4fcb25a316e1e932b02823e.camel@marvell.com>
         <3236b13f42679031960c5605be20664e90e75223.camel@marvell.com>
         <20201123222907.GC1751@lothringen>
         <c65ac23c1c408614110635c33eaf4ace98da4343.camel@marvell.com>
         <20201123232106.GD1751@lothringen>
In-Reply-To: <20201123232106.GD1751@lothringen>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=marvell.com;
x-originating-ip: [173.228.7.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 55ef8eb2-533d-4ede-c770-08d890f112b5
x-ms-traffictypediagnostic: MWHPR18MB1440:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR18MB14409BDD234F8A4982FB9ECCBCFA0@MWHPR18MB1440.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: B0byi0kQVG8Z+R5XExLn1lGCmWyT7IdrMdAAtstKnoT2oPnQKPv3tqPdXy2BzQP4YAZwrNuuOv8Rw39rZs+9pHRPUtibtZgJ3FYPt76/ay0HX4xYOqSFp/1/4ddbMw8eZNBpOlaaUDvIS8DDfTP8oUlpjbYlZDqrsKtb3pn3zE/uAVeQmflZepH5A21RFK2Wu/TuCIicag4MmJz9TiWzoKMx/vyPCtT3OPlcVs4FOGxpMZUuT2Zz6WYFvWeE9VBRnb5v4zARM991P124JaREMdy0NnFRoFO+BT5xMMrCY2rYpT/hW9LPA9T2pceV+VI8k8DmsRnByvz/ClOERXdfOg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR18MB2267.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(376002)(366004)(39850400004)(396003)(6506007)(83380400001)(7416002)(4326008)(6486002)(6512007)(91956017)(36756003)(5660300002)(76116006)(66476007)(64756008)(66946007)(66556008)(66446008)(86362001)(186003)(26005)(478600001)(71200400001)(2616005)(316002)(54906003)(4001150100001)(2906002)(6916009)(8676002)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 4gvzcjKq4r5qQCylHcBxvSfgfiTFVF8LxUMCYWskBL1IYxGImcJRp1E+CkpEzn4utYa9c6rTFLmtF0YtDEp1LxsGBOIeZX7W3t+1csM6lOR+GuzJVw0uoNocReydcPX0OpcJ5z/GlTMihUHOM3T8RyHHu3p6xYTwoaZeoXMamBm8oHR3LfWAJEbDmVc9yqBVPX50uWZfixifHHz1N/ukdF5UmgPUVdP8Hid5C61SPV/UNh+NEFNxlrvmvs8wXudkEzgmNBtKAIjZL00tD+VISpYRAKFmbPRUPH18ufl20CYAvV1gO8ZpL52iUTKFkgWXSqfZlcmxYT9A3IXNKmVP3yY6o6BSWvAidc1UHYrYOXWPq6P6D6Bzyislk+tb6s8kSm6SPp/JqEI+hteTNP0TMbzNQZnkaUEPdludIXyKSgunLyCV3voyYZ2v9PALQOQjaWxW8m2aA57hdEvMZsrOtETRHYxPKYxQQwCUmKqbeJprpsror68lCD1QN9t0Eyh/X44RYtWIG4+1OIuvmj2fmvpx1soQ2E33viJr5OLRE2pT/pWBkmsbFK3/D5WNQod9lqQSVmXS0QUeaoTd7Us9Uo5xkbVTI2ubh28A1vg2CCzLDDGtNA+EdBQ27xRrW2GfDtLmYB41mSCdIGG9wGwW48wL2y/tj46VPJ0PF5CRptoS2vLyA0SjVFMO/ZTTw0VLYwIB6P0KeFv/ILVbpcgR0e0pc8kGfgcWTof7q0mW6rTK/dCqPEYVlYhVwItAKvuWjX6ZuPPYEW+DSNQXE/ABKjwA+NVTacI0g1EgeD5Bv/8Lkv0D1sv57tQgg6KzAavXUIu8NwKhz698B+aItbNizrZ1J8qFvpyRDfqnCBWlm/PxFlMzd1hVW2sWLRgDTSzP2BU4YS/0utqN0OOk1grC6g==
Content-Type: text/plain; charset="utf-8"
Content-ID: <6B9838A204A0934595C222765B6BC2D1@namprd18.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR18MB2267.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55ef8eb2-533d-4ede-c770-08d890f112b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2020 03:20:34.5307
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Vrk7gYZPmHhU5DNFtoSH5HrS+oyzfcJa7Ri2xtMDzdfTGOXATwsPWauLNOAzJqJXNiKq+O3LnJszUHcxSz8ujQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR18MB1440
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-24_11:2020-11-24,2020-11-24 signatures=0
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

DQpPbiBUdWUsIDIwMjAtMTEtMjQgYXQgMDA6MjEgKzAxMDAsIEZyZWRlcmljIFdlaXNiZWNrZXIg
d3JvdGU6DQo+IE9uIE1vbiwgTm92IDIzLCAyMDIwIGF0IDEwOjM5OjM0UE0gKzAwMDAsIEFsZXgg
QmVsaXRzIHdyb3RlOg0KPiA+IA0KPiA+IFRoaXMgaXMgZGlmZmVyZW50IGZyb20gdGltZXJzLiBU
aGUgb3JpZ2luYWwgZGVzaWduIHdhcyBiYXNlZCBvbiB0aGUNCj4gPiBpZGVhIHRoYXQgZXZlcnkg
Q1BVIHNob3VsZCBiZSBhYmxlIHRvIGVudGVyIGtlcm5lbCBhdCBhbnkgdGltZSBhbmQNCj4gPiBy
dW4NCj4gPiBrZXJuZWwgY29kZSB3aXRoIG5vIGFkZGl0aW9uYWwgcHJlcGFyYXRpb24uIFRoZW4g
dGhlIG9ubHkgc29sdXRpb24NCj4gPiBpcw0KPiA+IHRvIGFsd2F5cyBkbyBmdWxsIGJyb2FkY2Fz
dCBhbmQgcmVxdWlyZSBhbGwgQ1BVcyB0byBwcm9jZXNzIGl0Lg0KPiA+IA0KPiA+IFdoYXQgSSBh
bSB0cnlpbmcgdG8gaW50cm9kdWNlIGlzIHRoZSBpZGVhIG9mIENQVSB0aGF0IGlzIG5vdCBsaWtl
bHkNCj4gPiB0bw0KPiA+IHJ1biBrZXJuZWwgY29kZSBhbnkgc29vbiwgYW5kIGNhbiBhZmZvcmQg
dG8gZ28gdGhyb3VnaCBhbg0KPiA+IGFkZGl0aW9uYWwNCj4gPiBzeW5jaHJvbml6YXRpb24gcHJv
Y2VkdXJlIG9uIHRoZSBuZXh0IGVudHJ5IGludG8ga2VybmVsLiBUaGUNCj4gPiBzeW5jaHJvbml6
YXRpb24gaXMgbm90IHNraXBwZWQsIGl0IHNpbXBseSBoYXBwZW5zIGxhdGVyLCBlYXJseSBpbg0K
PiA+IGtlcm5lbCBlbnRyeSBjb2RlLg0KPiANCj4gQWggSSBzZWUsIHRoaXMgaXMgb3JkZXJlZCB0
aGF0IHdheToNCj4gDQo+IGxsX2lzb2xfZmxhZ3MgPSBJU09MQVRFRA0KPiANCj4gICAgICAgICAg
Q1BVIDAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIENQVSAxDQo+ICAgICAtLS0tLS0t
LS0tLS0tLS0tLS0gICAgICAgICAgICAgICAgICAgICAgIC0tLS0tLS0tLS0tLS0tLS0tDQo+ICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgLy8ga2VybmVsIGVudHJ5
DQo+ICAgICBkYXRhX3RvX3N5bmMgPSAxICAgICAgICAgICAgICAgICAgICAgICAgbGxfaXNvbF9m
bGFncyA9IElTT0xBVEVEX0JST0tFTg0KPiAgICAgc21wX21iKCkgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIHNtcF9tYigpDQo+ICAgICBpZiBsbF9pc29sX2ZsYWdzKENQVSAxKSA9PSBJ
U09MQVRFRCAgICAgUkVBRCBkYXRhX3RvX3N5bmMNCj4gICAgICAgICAgc21wX2NhbGwoQ1BVIDEp
DQo+IA0KDQpUaGUgY2hlY2sgZm9yIGxsX2lzb2xfZmxhZ3MoQ1BVIDEpIGlzIHJldmVyc2VkLCBh
bmQgaXQncyBhIGJpdCBtb3JlDQpjb21wbGV4LiBJbiB0ZXJtcyBvZiBzY2VuYXJpb3MsIG9uIGVu
dHJ5IGZyb20gaXNvbGF0aW9uIHRoZSBmb2xsb3dpbmcNCmNhbiBoYXBwZW46DQoNCjEuIEtlcm5l
bCBlbnRyeSBoYXBwZW5zIHNpbXVsdGFuZW91c2x5IHdpdGggb3BlcmF0aW9uIHRoYXQgcmVxdWly
ZXMNCnN5bmNocm9uaXphdGlvbiwga2VybmVsIGVudHJ5IHByb2Nlc3NpbmcgaGFwcGVucyBiZWZv
cmUgdGhlIGNoZWNrIGZvcg0KaXNvbGF0aW9uIG9uIHRoZSBzZW5kZXIgc2lkZToNCg0KbGxfaXNv
bF9mbGFncyhDUFUgMSkgPSBJU09MQVRFRA0KDQogICAgICAgICBDUFUgMCAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgQ1BVIDENCiAgICAtLS0tLS0tLS0tLS0tLS0tLS0gICAgICAgICAg
ICAgICAgICAgICAgLS0tLS0tLS0tLS0tLS0tLS0NCiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgLy8ga2VybmVsIGVudHJ5DQogICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIGlmIChsbF9pc29sX2ZsYWdzID09IElTT0xBVEVEKSB7DQog
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGxsX2lzb2xf
ZmxhZ3MgPSBJU09MQVRFRF9CUk9LRU4NCiAgICBkYXRhX3RvX3N5bmMgPSAxICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgc21wX21iKCkNCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgLy8gZGF0YV90b19zeW5jIHVuZGV0ZXJtaW5lZA0KICAgIHNt
cF9tYigpICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB9DQogICAgLy8gbGxfaXNvbF9m
bGFncyhDUFUgMSkgdXBkYXRlZA0KICAgIGlmIGxsX2lzb2xfZmxhZ3MoQ1BVIDEpICE9IElTT0xB
VEVEDQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIC8vIGludGVy
cnVwdHMgZW5hYmxlZA0KICAgICAgICAgc21wX2NhbGwoQ1BVIDEpICAgICAgICAgICAgICAgICAg
ICAgICAgICAvLyBrZXJuZWwgZW50cnkgYWdhaW4NCiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgaWYgKGxsX2lzb2xfZmxhZ3MgPT0gSVNPTEFURUQpDQog
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIC8v
IG5vdGhpbmcgaGFwcGVucw0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAvLyBleHBsaWNpdCBvciBpbXBsaWVkIGJhcnJpZXJzDQogICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIC8vIGRhdGFfdG9fc3luYyB1cGRh
dGVkDQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIC8v
IGtlcm5lbCBleGl0DQogICAgLy8gQ1BVIDAgYXNzdW1lcywgQ1BVIDEgd2lsbCBzZWUgICAgICAg
IFJFQUQgZGF0YV90b19zeW5jDQogICAgLy8gZGF0YV90b19zeW5jID0gMSB3aGVuIGluIGtlcm5l
bA0KDQoyLiBLZXJuZWwgZW50cnkgaGFwcGVucyBzaW11bHRhbmVvdXNseSB3aXRoIG9wZXJhdGlv
biB0aGF0IHJlcXVpcmVzDQpzeW5jaHJvbml6YXRpb24sIGtlcm5lbCBlbnRyeSBwcm9jZXNzaW5n
IGhhcHBlbnMgYWZ0ZXIgdGhlIGNoZWNrIGZvcg0KaXNvbGF0aW9uIG9uIHRoZSBzZW5kZXIgc2lk
ZToNCg0KbGxfaXNvbF9mbGFncyhDUFUgMSkgPSBJU09MQVRFRA0KDQogICAgICAgICBDUFUgMCAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgQ1BVIDENCiAgICAtLS0tLS0tLS0tLS0tLS0t
LS0gICAgICAgICAgICAgICAgICAgICAgLS0tLS0tLS0tLS0tLS0tLS0NCiAgICBkYXRhX3RvX3N5
bmMgPSAxICAgICAgICAgICAgICAgICAgICAgICAgLy8ga2VybmVsIGVudHJ5DQogICAgc21wX21i
KCkgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIC8vIGRhdGFfdG9fc3luYyB1bmRldGVy
bWluZWQNCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgLy8gc2hv
dWxkIG5vdCBhY2Nlc3MgZGF0YV90b19zeW5jIGhlcmUNCiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgaWYgKGxsX2lzb2xfZmxhZ3MgPT0gSVNPTEFURUQpIHsgICAg
ICANCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGxs
X2lzb2xfZmxhZ3MgPSBJU09MQVRFRF9CUk9LRU4NCiAgICAvLyBsbF9pc29sX2ZsYWdzKENQVSAx
KSB1bmRldGVybWluZWQgICAgICAgICAgIHNtcF9tYigpDQogICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAvLyBkYXRhX3RvX3N5bmMgdXBkYXRlZA0KICAg
IGlmIGxsX2lzb2xfZmxhZ3MoQ1BVIDEpICE9IElTT0xBVEVEICAgICB9DQogICAgICAgICAvLyBw
b3NzaWJseSBub3RoaW5nIGhhcHBlbnMNCiAgICAvLyBDUFUgMCBhc3N1bWVzLCBDUFUgMSB3aWxs
IHNlZSAgICAgICAgUkVBRCBkYXRhX3RvX3N5bmMNCiAgICAvLyBkYXRhX3RvX3N5bmMgPSAxIHdo
ZW4gaW4ga2VybmVsDQoNCjMuIEtlcm5lbCBlbnRyeSBwcm9jZXNzaW5nIGNvbXBsZXRlZCBiZWZv
cmUgdGhlIGNoZWNrIGZvciBpc29sYXRpb24gb24gdGhlIHNlbmRlcg0Kc2lkZToNCg0KbGxfaXNv
bF9mbGFncyhDUFUgMSkgPSBJU09MQVRFRA0KDQogICAgICAgICBDUFUgMCAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgQ1BVIDENCiAgICAtLS0tLS0tLS0tLS0tLS0tLS0gICAgICAgICAg
ICAgICAgICAgICAgLS0tLS0tLS0tLS0tLS0tLS0NCiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgLy8ga2VybmVsIGVudHJ5DQogICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIGlmIChsbF9pc29sX2ZsYWdzID09IElTT0xBVEVEKSB7DQog
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGxsX2lzb2xf
ZmxhZ3MgPSBJU09MQVRFRF9CUk9LRU4NCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgc21wX21iKCkNCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgfQ0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAvLyBpbnRlcnJ1cHRzIGFyZSBlbmFibGVkIGF0IHNvbWUNCiAgICBkYXRhX3RvX3N5bmMg
PSAxICAgICAgICAgICAgICAgICAgICAgICAgLy8gcG9pbnQgaGVyZSwgZGF0YV90b19zeW5jIHZh
bHVlDQogICAgc21wX21iKCkgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIC8vIGlzIHVu
ZGV0ZXJtaW5lZCwgQ1BVIDAgbWFrZXMgbm8NCiAgICAvLyBsbF9pc29sX2ZsYWdzKENQVSAxKSB1
cGRhdGVkICAgICAgICAgLy8gYXNzdW1wdGlvbnMgYWJvdXQgaXQNCiAgICBpZiBsbF9pc29sX2Zs
YWdzKENQVSAxKSAhPSBJU09MQVRFRCAgICAgLy8NCiAgICAgICAgICBzbXBfY2FsbChDUFUgMSkg
ICAgICAgICAgICAgICAgICAgICAgICAgLy8ga2VybmVsIGVudHJ5IGFnYWluDQogICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGlmIChsbF9pc29sX2ZsYWdz
ID09IElTT0xBVEVEKQ0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAvLyBub3RoaW5nIGhhcHBlbnMNCiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgLy8gZXhwbGljaXQgb3IgaW1wbGllZCBiYXJyaWVy
cw0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAvLyBk
YXRhX3RvX3N5bmMgdXBkYXRlZA0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAvLyBrZXJuZWwgZXhpdA0KICAgIC8vIENQVSAwIGFzc3VtZXMsIENQVSAx
IHdpbGwgc2VlDQogICAgLy8gZGF0YV90b19zeW5jID0gMSB3aGVuIGluIGtlcm5lbA0KICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBSRUFEIGRhdGFfdG9fc3luYw0K
DQo0LiBLZXJuZWwgZW50cnkgcHJvY2Vzc2luZyBoYXBwZW5zIGFmdGVyIHRoZSBjaGVjayBmb3Ig
aXNvbGF0aW9uIG9uIHRoZSBzZW5kZXINCnNpZGU6DQoNCmxsX2lzb2xfZmxhZ3MoQ1BVIDEpID0g
SVNPTEFURUQNCg0KICAgICAgICAgQ1BVIDAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IENQVSAxDQogICAgLS0tLS0tLS0tLS0tLS0tLS0tICAgICAgICAgICAgICAgICAgICAgIC0tLS0t
LS0tLS0tLS0tLS0tDQogICAgZGF0YV90b19zeW5jID0gMSAgICAgICAgICAgICAgICAgICAgICAg
IC8vIHVzZXJzcGFjZSBvciBlYXJseSBrZXJuZWwgZW50cnkNCiAgICBzbXBfbWIoKQ0KICAgIGlm
IGxsX2lzb2xfZmxhZ3MoQ1BVIDEpICE9IElTT0xBVEVEDQogICAgICAgICAgc21wX2NhbGwoQ1BV
IDEpIC8vIHNraXBwZWQgICAgICAgIC8vIHVzZXJzcGFjZSBvciBlYXJseSBrZXJuZWwgZW50cnkN
CiAgICAvLyBDUFUgMCBhc3N1bWVzLCBDUFUgMSB3aWxsIHNlZSAgICAgICAgLy8gY29udGludWVz
IHVuZGlzdHVyYmVkDQogICAgLy8gZGF0YV90b19zeW5jID0gMSB3aGVuIGluIGtlcm5lbA0KICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAvLyBrZXJuZWwgZW50cnkN
CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgLy8gZGF0YV90b19z
eW5jIHVuZGV0ZXJtaW5lZA0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAvLyBzaG91bGQgbm90IGFjY2VzcyBkYXRhX3RvX3N5bmMgaGVyZQ0KICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBpZiAobGxfaXNvbF9mbGFncyA9PSBJU09M
QVRFRCkgew0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBsbF9pc29sX2ZsYWdzID0gSVNPTEFURURfQlJPS0VODQogICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIHNtcF9tYigpDQogICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIC8vIGRhdGFfdG9fc3luYyB1cGRhdGVkDQog
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIH0NCiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgUkVBRCBkYXRhX3RvX3N5bmMNCg0KVGhp
cyBhbHNvIGFwcGxpZXMgdG8gZXhpdCB0byB1c2Vyc3BhY2UgYWZ0ZXIgZW5hYmxpbmcgaXNvbGF0
aW9uIC0tIG9uY2UNCmxsX2lzb2xfZmxhZ3MgaXMgc2V0IHRvIElTT0xBVEVELCBzeW5jaHJvbml6
YXRpb24gd2lsbCBiZSBtaXNzZWQsIHNvDQpvbmUgZmluYWwgYmFycmllciBzaG91bGQgaGFwcGVu
IGJlZm9yZSByZXR1cm5pbmcgdG8gdXNlcnNwYWNlIGFuZA0KZW5hYmxpbmcgaW50ZXJydXB0cyBp
biB0aGUgcHJvY2Vzcy4gSW4gdGhpcyBjYXNlICJ1bmx1Y2t5IiB0aW1pbmcgd291bGQNCnJlc3Vs
dCBpbiBzbXAgY2FsbCBpbnRlcnJ1cHRpbmcgdXNlcnNwYWNlIHRoYXQgaXMgYWxyZWFkeSBzdXBw
b3NlZCB0bw0KYmUgaXNvbGF0ZWQsIGl0IHdpbGwgdHJpZ2dlciBub3JtYWwgaXNvbGF0aW9uIGJy
ZWFraW5nIHByb2NlZHVyZSBidXQNCm90aGVyd2lzZSB3aWxsIGJlIGFuIHVucmVtYXJrYWJsZSBz
eW5jaHJvbml6YXRpb24gY2FsbC4gT24gdGhlIG90aGVyDQpoYW5kLCBzeW5jaHJvbml6YXRpb24g
dGhhdCB3YXMgc3VwcG9zZWQgdG8gaGFwcGVuIGFmdGVyIHNldHRpbmcNCmxsX2lzb2xfZmxhZ3Ms
IHdpbGwgYmUgZGVsYXllZCB0byB0aGUgbmV4dCBrZXJuZWwgZW50cnksIHNvIHRoZXJlDQpzaG91
bGQgYmUgbm90aGluZyB0aGF0IG5lZWRzIHN5bmNocm9uaXphdGlvbiBiZXR3ZWVuIHRoZSBlbmQg
b2YNCnRhc2tfaXNvbGF0aW9uX2V4aXRfdG9fdXNlcl9tb2RlKCkgYW5kIGVudGVyaW5nIHVzZXJz
cGFjZSAoaW50ZXJydXB0cw0KYXJlIG9rLCB0aG91Z2gsIHRoZXkgd2lsbCB0cmlnZ2VyIGlzb2xh
dGlvbiBicmVha2luZykuDQoNClRoaXMgaXMgd2h5IEkgaGF2ZSBwbGFjZWQgdGFza19pc29sYXRp
b25fa2VybmVsX2VudGVyKCkNCmFuZCB0YXNrX2lzb2xhdGlvbl9leGl0X3RvX3VzZXJfbW9kZSgp
IGluIGVudHJ5L2V4aXQgY29kZSwgYW5kIHdoZW4gSQ0KaGF2ZSBzZWVuIGFueSBhbWJpZ3VpdHkg
b3IgaGFkIGFueSBkb3VidCBhbGxvd2VkIGR1cGxpY2F0ZSBjYWxscyB0bw0KdGFza19pc29sYXRp
b25fa2VybmVsX2VudGVyKCkgb24gZW50cnkuIElmIEkgb3ZlcmRpZCBhbnkgb2YgdGhhdCwgSQ0K
d291bGQgYXBwcmVjaWF0ZSBmaXhlcyBhbmQgY2xhcmlmaWNhdGlvbnMsIGhvd2V2ZXIgaXQgc2hv
dWxkIGJlIHRha2VuDQppbnRvIGFjY291bnQgdGhhdCBmb3Igbm93IGRpZmZlcmVudCBhcmNoaXRl
Y3R1cmVzIGFuZCBldmVuIGRyaXZlcnMgbWF5DQpjYWxsIGNvbW1vbiBhbmQgc3BlY2lmaWMgZnVu
Y3Rpb25zIGluIGEgc2xpZ2h0bHkgZGlmZmVyZW50IG9yZGVyLg0KDQpTeW5jaHJvbml6YXRpb24g
YWxzbyBhcHBsaWVzIHRvIHBvc3NpYmxlIGVmZmVjdHMgb24gcGlwZWxpbmUgKHdoZW4NCm9yaWdp
bmF0aW5nIENQVSB3cml0ZXMgaW5zdHJ1Y3Rpb25zKS4NCg0KVGhlcmUgaXMgYSB2ZXJzaW9uIHVu
ZGVyIGRldmVsb3BtZW50IHRoYXQgZGVsYXlzIFRMQiBmbHVzaGVzIGluIHRoaXMNCm1hbm5lci4g
T24gYXJtNjQgdGhhdCByZXF1aXJlcyBhIHN3aXRjaCB0byBzb2Z0IFRMQiBmbHVzaGVzLCBhbmQg
dGhhdCdzDQphbm90aGVyIHBvdGVudGlhbCBiYWxsIG9mIHdheC4gT24gYXJjaGl0ZWN0dXJlcyB0
aGF0IGFscmVhZHkgdXNlIHNvZnQNClRMQiBmbHVzaGVzLCB0aGlzIHdpbGwgYmUgdW5hdm9pZGFi
bGUgYmVjYXVzZSBUTEIgZmx1c2ggYmVjb21lcyBhbm90aGVyDQpJUEksIGFuZCBJUElzIGJyZWFr
IGlzb2xhdGlvbi4gTWF5YmUgaXQgd2lsbCBiZSBiZXR0ZXIgdG8gbWFrZSBhDQpzb21ld2hhdCBz
bWFydGVyIFRMQiBoYW5kbGluZyBpbiBnZW5lcmFsLCBzbyBpdCB3aWxsIGJlIHBvc3NpYmxlIHRv
DQphdm9pZCBib3RoZXJpbmcgdW5yZWxhdGVkIENQVXMuIEJ1dCB0aGVuLCBJIGd1ZXNzLCBoYXJk
d2FyZSBtYXkgc3RpbGwNCm92ZXJkbyBpdC5UaGVuIGl0IHdpbGwgYmUgY2xvc2VyIHRvIHRoZSBz
aXR1YXRpb24gd2l0aCB0aW1lcnMuIEZvciBub3csDQpJIHdhbnQgdG8gZmlyc3QgZG8gdGhlIG9i
dmlvdXMgYW5kIGV4Y2x1ZGUgaXNvbGF0ZWQgdGFza3MgZnJvbSBUTEINCnVwZGF0ZXMgdW50aWwg
dGhleSBhcmUgYmFjayBpbiBrZXJuZWwsIGFuZCBkbyBhIHNsb3cgZnVsbCBmbHVzaCBvbg0KaXNv
bGF0aW9uIGJyZWFraW5nLg0KDQo+IFlvdSBzaG91bGQgZG9jdW1lbnQgdGhhdCwgaWU6IGV4cGxh
aW4gd2h5IHdoYXQgeW91J3JlIGRvaW5nIGlzIHNhZmUuDQoNCkkgdHJpZWQgdG8gZG8gdGhhdCBp
biBjb21tZW50cywgaG93ZXZlciB0aGlzIGlzIGNsZWFybHkgaW5zdWZmaWNpZW50DQpkZXNwaXRl
IHRoZWlyIHZlcmJvc2l0eS4gV291bGQgaXQgbWFrZSBzZW5zZSB0byBjcmVhdGUgYSBzZXBhcmF0
ZQ0KZG9jdW1lbnRhdGlvbiB0ZXh0IGZpbGU/IEN1cnJlbnQgZG9jdW1lbnRhdGlvbiBzZWVtcyB0
byBiZSBsaWdodCBvbg0KZGV0YWlsZWQgc3BlY2lmaWNhdGlvbnMgZm9yIHRoaW5ncyB1bmRlciBo
ZWF2eSBkZXZlbG9wbWVudCBleGNlcHQgZm9yDQpzb21ldGhpbmcgdmVyeSBzaWduaWZpY2FudCB0
aGF0IGFmZmVjdHMgbmVhcmx5IGV2ZXJ5b25lLg0KDQpXb3VsZCBpdCBtYWtlIHNlbnNlIHRvIGlu
Y2x1ZGUgYWxsIHNjZW5hcmlvcyBsaWtlIHRoZSBhYm92ZSBwbHVzIGV4aXQNCnRvIHVzZXJzcGFj
ZSwgYW5kIGV4aXN0aW5nIHNlcXVlbmNlcyBvZiBjYWxscyB0aGF0IHNob3VsZCBsZWFkIHRvDQpz
eW5jaHJvbml6YXRpb24gY2FsbHMsIHRhc2tfaXNvbGF0aW9uX2tlcm5lbF9lbnRlcigpIG9yDQp0
YXNrX2lzb2xhdGlvbl9leGl0X3RvX3VzZXJfbW9kZSgpPw0KDQoNCj4gQWxzbyBCZXdhcmUgdGhv
dWdoIHRoYXQgdGhlIGRhdGEgdG8gc3luYyBpbiBxdWVzdGlvbiBkb2Vzbid0IG5lZWQgdG8NCj4g
YmUgdmlzaWJsZQ0KPiBpbiB0aGUgZW50cnkgY29kZSBiZWZvcmUgdGFza19pc29sYXRpb25fa2Vy
bmVsX2VudGVyKCkuDQoNClJpZ2h0LiBBbmQgYWZ0ZXIgdGFza19pc29sYXRpb25fZXhpdF90b191
c2VyX21vZGUoKSBhcyB3ZWxsLiBUaGlzIGlzDQp3aHkgSSBoYWQgdG8gZGlnIHRocm91Z2ggZW50
cnkvZXhpdCBjb2RlLiBJIGNhbiBwcm9kdWNlIGEgc29tZXdoYXQNCnVzYWJsZSBjYWxsIHNlcXVl
bmNlIGRpYWdyYW0uDQoNCklmIGJ5IGFueSBjaGFuY2UgSSBhbSB3cm9uZyB0aGVyZSBzb21ld2hl
cmUsIEkgd2VsY29tZSBhbGwgcmVsZXZhbnQNCmNvbW1lbnRzIGFuZCBjb3JyZWN0aW9ucy4NCg0K
QXQgdGhpcyBwb2ludCBJIGFtIG5vdCBzdXJlIG9ubHkgYWJvdXQgdGhpbmdzIHRoYXQgYXJlIGNh
bGxlZCB3aGVuDQpDT05GSUdfVFJBQ0VfSVJRRkxBR1MgaXMgZW5hYmxlZCwgc2ltcGx5IGJlY2F1
c2UgSSBoYXZlIG5vdCB5ZXQgY2hlY2tlZA0Kd2hhdCB0aGV5IGRlcGVuZCBvbiwgYW5kIHZpcnR1
YWxpemF0aW9uLXNwZWNpZmljIGVudHJ5L2V4aXQgaXMgbm90DQplbnRpcmVseSBjbGVhciB0byBt
ZS4gTWF5YmUgZm9yIGNvcnJlY3RuZXNzIHNha2UgSSBzaG91bGQgaGF2ZSBkZWNsYXJlZA0KdGFz
ayBpc29sYXRpb24gaW5jb21wYXRpYmxlIHdpdGggdGhvc2UgdW50aWwgSSBlaXRoZXIga25vdyBm
b3Igc3VyZSBvcg0KYWRkZWQgd29ya2luZyBzdXBwb3J0IGZvciB0aGVtLg0KDQo+ICBZb3UgbmVl
ZCB0byBhdWRpdCBhbGwNCj4gdGhlIGNhbGxlcnMgb2Yga2lja19hbGxfY3B1c19zeW5jKCkuDQoN
ClJpZ2h0IG5vdyBpdCdzIGp1c3QgdGhyZWUgcGxhY2VzLg0KDQpkb190dW5lX2NwdWNhY2hlKCkg
ZG9lcyB0aGUgcmlnaHQgdGhpbmcsIGtlZXBzIENQVXMgZnJvbSBzZWVpbmcgb2xkDQp2YWx1ZXMg
b2YgY2FjaGVwLT5jcHVfY2FjaGUgYXMgdGhleSBhcmUgYmVpbmcgZGVhbGxvY2F0ZWQuDQoNCnBv
d2VycGMga3ZtX2FyY2hfZGVzdHJveV92bSgpIGNhcmVzIG9ubHkgYWJvdXQgQ1BVcyB3aXRoIFZD
UFVzIG9uIHRoZW0sDQp3aGF0IGZvciBub3cgc2hvdWxkIG5vdCBiZSB1c2VkIHdpdGggaXNvbGF0
aW9uLg0KDQphcm02NCBmbHVzaF9pY2FjaGVfcmFuZ2UoKSBpcyB0aGUgbWFpbiByZWFzb24gd2h5
IHRoaXMgY291bGQgYmUNCnBvdGVudGlhbGx5IHByb2JsZW1hdGljLCBpdCBtYWtlcyBzdXJlIHRo
YXQgb3RoZXIgQ1BVcyB3aWxsIG5vdCBydW4NCnN0YWxlIGluc3RydWN0aW9ucywgYW5kIGl0J3Mg
Y2FsbGVkIGZyb20gYWxsIHBsYWNlcyB3aGVyZSBjb2RlIGlzDQptb2RpZmllZC4gSWYgaW4gb3Ro
ZXIgc2l0dWF0aW9uIHNvbWUga2luZCBvZiBkZWxheWVkIHByb2Nlc3NpbmcgY291bGQNCmJlIHBv
c3NpYmxlLCB0aGlzIG9uZSBoYXMgdG8gYmUgZG9uZSBpbiB0aGUgcmlnaHQgc2VxdWVuY2UuIEFu
ZCB0aGF0J3MNCnRoZSByZWFzb24gZm9yIGluc3RyX3N5bmMoKSBhZnRlciBzbXBfbWIoKSBpbg0K
dGFza19pc29sYXRpb25fa2VybmVsX2VudGVyKCkuIFNpbmNlIGZsdXNoX2ljYWNoZV9yYW5nZSgp
IGNvdWxkIHNraXANCnRoaXMgQ1BVLCB3ZSBoYXZlIHRvIHN5bmNocm9uaXplIGl0IGJ5IG91cnNl
bHZlcy4NCg0KVGhlcmUgaXMgYW4gaW1wb3J0YW50IGlzc3VlIG9mIG5vdCBoYXZpbmcgZWFybHkg
a2VybmVsIGVudHJ5IC8gbGF0ZQ0Ka2VybmVsIGV4aXQgcmVseSBvbiBzb21ldGhpbmcgdGhhdCBt
YXkgYmUgc3RhbGUgKHdpdGggYm90aCBkYXRhIGFuZA0KY29kZSkuIFdpdGggdGhlIGFib3ZlIG1l
bnRpb25lZCBleGNlcHRpb25zIGZvciBub3csIGl0IGNhbiBiZQ0KZGVtb25zdHJhdGVkIHRoYXQg
dGhpcyBpcyBjb3JyZWN0LiBJdCBzaG91bGQgYmUgdGFrZW4gaW50byBhY2NvdW50IHRoYXQNCmV2
ZW4gdGhvdWdoIHN0YXRpYyBrZXlzIGFyZSB1c2VkIGluIGVhcmx5IGtlcm5lbCBlbnRyeSBjb2Rl
LCBzdGF0aWMNCmtleXMgc2V0dGluZyBkb2VzIG5vdCBzeW5jaHJvbml6ZSBmbHVzaGVzLCBhbmQg
dGhlcmVmb3JlIGFscmVhZHkgc2hvdWxkDQpiZSBkb25lIGJlZm9yZSB1c2UuDQoNClRhc2sgaXNv
bGF0aW9uIGluIHZpcnR1YWxpemF0aW9uIGd1ZXN0cyBjYW4gYmUgYSBwZXJmZWN0bHkgdmFsaWQg
dGhpbmcNCnRvIHN1cHBvcnQgKGl0IGp1c3QgaGFzIHRvIGJlIHByb3BhZ2F0ZWQgdG8gdGhlIGhv
c3QgaWYgcGVybWl0dGVkKSwNCmhvd2V2ZXIgdGhpcyBpcyBzb21ldGhpbmcgSSB3aWxsIHdhbnQg
dG8gcmV2aXNpdCBpbiB0aGUgZnV0dXJlLiBGb3INCm5vdywgSSBhc3N1bWUgdGhhdCB2aXJ0dWFs
aXphdGlvbi1yZWxhdGVkIGV2ZW50cyBhcmUgbm90IHN1cHBvc2VkIHRvDQpicmVhayBpc29sYXRp
b24sIGhvd2V2ZXIgaXQgd291bGQgYmUgbmljZSB0byBiZSByZWFkeSBmb3IgaGFuZGxpbmcgdGhh
dA0KcG9zc2liaWxpdHkuDQoNCi0tIA0KQWxleA0K

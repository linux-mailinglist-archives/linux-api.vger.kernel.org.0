Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5056406F51
	for <lists+linux-api@lfdr.de>; Fri, 10 Sep 2021 18:14:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbhIJQP2 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 10 Sep 2021 12:15:28 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:34252 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232537AbhIJQPL (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 10 Sep 2021 12:15:11 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18AE5db6005261;
        Fri, 10 Sep 2021 16:13:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=wK4cuOX7BeHtuehJU4p5qtoKpXKDSjIZBuQMUPtXmKU=;
 b=V2sy6skgtaccuHQWlMaQM4FWK3mIEyhjSIqG/6FjlQZ7j0s6aFAia7tVCQyLAevcik/3
 QyfKkVzotgCnuIdfZ9pycCe91Z1ED2gglOmoC7x20gsGeHAfYbkwU/ma8a2x6fqqLgFf
 sj8EjUrNHYSqy8lq9bmaUKsQWAhJWrUSSq9Eq+6AueMCqg1j4j4tAStM/qsd1Pudipvc
 6lBl3FS0OYZjBtu6gwl+fzM+MJEvO0IIlRVSMSyf+J8xgHwLOgXz63EmQsbum1xcDcJP
 1oOmHKanHzDQfHB8AOFFRKnSGXXTLAl3rNgtIMwFiT9I+/5RnDVsglAFb+0Au4Rh0paP Mg== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=wK4cuOX7BeHtuehJU4p5qtoKpXKDSjIZBuQMUPtXmKU=;
 b=LQ619joJnG/YCepJcnlWSgC5kgxpNnBnPfuBYbRXZ/FRLTk+/XcFzfK3TLXYMv2SIMpi
 LOpe3sgmcgK62v+zvCWWpZOK63iKI27bLmphvREAgKRL4G4zzCu4+V5W+ksVc/lXxuwT
 acKBznju56jRmzXbMqTw6dZYj6MMWCM79J3258dMCgonH7SdYT3yw3by28tkxChs2A3+
 Tz25/psMW5FOarP+1AlHYgN1sYbrR3aFYdeQ3crmy7Sq8aGcbWPagbP67T6Op4vF2rpe
 6FvsjLleXm9nnkGj4CHIHMH9b08fEO4GOFn09mtW3gPUXjbteuotYTRaR5m1/nSH1wIu lg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3aytj5jbkx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Sep 2021 16:13:55 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18AGAwDV194963;
        Fri, 10 Sep 2021 16:13:54 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2049.outbound.protection.outlook.com [104.47.73.49])
        by userp3030.oracle.com with ESMTP id 3aytfu3vf2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Sep 2021 16:13:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Eb1oG5+2VSyAFI9NDzXUdTx4b8g0J5aureN0zMGnrbKwzAG6IZkq3zpxSvCRfATaPzdWWSJ6JwFE7A1JcDNGNCFqsc3E7oKWw4tCA1EHkb5n0RX1Yb7y9/2qUaXE8dYz0O2e68HO4J4VZlcbG5y86V+yWDyjdoZTkMdY/1ErvGG18TaWQPuKEO+MHioivSzUS/H1NDmRE4H1/eAaYbAp64m9N35Hr1bdPJbloxAJPU/sFs07q5v9wbUAVAcnQzf4Zol44jo6XBHVgeeKZdXaiHRQPJS8K2O99x9JL9XIuOM1dv1tmnIE5qJtqn7d8jAjJi4A04EPyxR1xM5C/rB7hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=wK4cuOX7BeHtuehJU4p5qtoKpXKDSjIZBuQMUPtXmKU=;
 b=RDigxQvo73CL5RkNhDVyZ3d6tdt9IBf88qiap79skB9f223133T++EKw0Dqkm30bNW+6zD8c8LGW6HZYmYKRaNztUr9HZu/3Ubqc3Z+fxSQe9KpGoE9LVDuQo4oh6ZdUzuHxXTSYW/xPGvXgZ1OlAU1ZKCQIReOdkLkWMbyCDsKw6zv4/QAqb94GwT6MxzOuK1YZVp7YCFFfQNGnQy/JtiGTJ4qVbDnWpcobYJFK9i3t+2pKGpq0P7Ys6SBzpchGfY3EBMdmZtpi7wFHolD68nq+Zcr+MBQVQbvWDzTK+syjUQPx1lY+Ssgz53ABU2z2tRy4l2J16AVkKMk6EChCdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wK4cuOX7BeHtuehJU4p5qtoKpXKDSjIZBuQMUPtXmKU=;
 b=d3gLRDYtURAH8yVOH+KXqC4aHPCbfkTWt+dp4SBIXC8UNSZcQKUKCmQpJTC2ulMAmSuAtIZCkHamW6kDIgokt5E/0JKOTBBHOzxgxWsOhj7WIROrI1H/dXS7RxhOWpTIBsnsbs6XAZvMHfXHB5LZEYd7O3kU/Up8zYq9BRnX4XU=
Received: from BYAPR10MB2629.namprd10.prod.outlook.com (2603:10b6:a02:b7::24)
 by SJ0PR10MB4479.namprd10.prod.outlook.com (2603:10b6:a03:2af::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14; Fri, 10 Sep
 2021 16:13:52 +0000
Received: from BYAPR10MB2629.namprd10.prod.outlook.com
 ([fe80::4c4:78db:507d:90c3]) by BYAPR10MB2629.namprd10.prod.outlook.com
 ([fe80::4c4:78db:507d:90c3%7]) with mapi id 15.20.4500.017; Fri, 10 Sep 2021
 16:13:52 +0000
From:   Prakash Sangappa <prakash.sangappa@oracle.com>
To:     Peter Oskolkov <posk@google.com>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-api <linux-api@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Paul Turner <pjt@google.com>,
        Jann Horn <jannh@google.com>, Peter Oskolkov <posk@posk.io>
Subject: Re: [RESEND RFC PATCH 0/3] Provide fast access to thread specific
 data
Thread-Topic: [RESEND RFC PATCH 0/3] Provide fast access to thread specific
 data
Thread-Index: AQHXpQ/fLwtDYf3gz0mKOoI4Vng/XaudZBfggAAPeYA=
Date:   Fri, 10 Sep 2021 16:13:52 +0000
Message-ID: <3591AC6D-45D2-476A-80B1-46BFA1742602@oracle.com>
References: <1631147036-13597-1-git-send-email-prakash.sangappa@oracle.com>
 <CAFTs51VDUPWu=r9d=ThABc-Z6wCwTOC+jKDCq=Jk8Pfid61xyQ@mail.gmail.com>
 <CAPNVh5dsN0LPHg6TJ_MO2XKtpTEe0n4Y6+HjwERJPSrb2J0cbg@mail.gmail.com>
In-Reply-To: <CAPNVh5dsN0LPHg6TJ_MO2XKtpTEe0n4Y6+HjwERJPSrb2J0cbg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
authentication-results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: afe1973d-e25b-4cac-60f6-08d97475fb54
x-ms-traffictypediagnostic: SJ0PR10MB4479:
x-microsoft-antispam-prvs: <SJ0PR10MB447967C6373D42CBEC4D53ABE4D69@SJ0PR10MB4479.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pWBdRcd6aCf1pGmvwyWc9chUwk4fJgGkzK2VK1c0AvWaM6U0ct8j4Nk14Rc0G50/f3dYApfwzN7Vul6Ls8HDFmHgZJqPTUD1IcrYWi2RFap4jItag3qEAr3PONbx/STEIV3XHeyB/PDCPSaV6a9D/WXAWWmYvDw9iYB9FYxWcnmTubxvJldY/W20/JIleRynWb6b3Al2WxQ0ke9+n1NhzJATUOxytVLBq8szWG1Svz3J8ei8Tta9J5OImrDyjLrUwSrQeRUF1RkpVGBgzV07Zc6dEaxOJiuNYKZCwE5pnxzduCShQoyxEUu2JLnTU736lXAykFYaWfrRDAzPkREwaeGUT135M9gjkvk57HrSrfYmQ86PMsp9DcKLR8qE7DfDu8zL7ym7w+BCeeJzTbgs+shEGd6orhjamO/E9YFiGLwcf/JjVY6dQYNmKb/wFO+fkimWaywjXndO1SrePvomwHzxzPfKKt7xcejdv8daIDOPIKocY5kKq2HDBbtMrGRRDLORRnhKaFJNLI1KKD36WA9DNownxGRaBdPVCju7tSatRH+MyWWq98lgoycuPm3nYmKb2hPLQfB4DyhVPpHPfZdIfAxoUO1GSLGdeHeEmgp6PiT6AuHOk6Sk+dgSkAE3HaXQL4IpWXYA5SC+azqB0P7XIB2EMI5V/6tv7XjLqT+TyZNde3k3/NTBYkHphCg5KpOu1oatelPCrIh0AZsPL8RFu+kQP+mrN4EKN9SJsdTAfmB5cOQn9owRqkztXHPcE/dw80PKuc1oqBUKPmWYcB3voCFrgtVSCEMks8jtOn6cXCJhs4Tx1+6Fzqv9TByu
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2629.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(136003)(366004)(396003)(346002)(39860400002)(66556008)(66476007)(83380400001)(66946007)(53546011)(186003)(316002)(8676002)(8936002)(64756008)(38070700005)(66446008)(2906002)(54906003)(71200400001)(91956017)(76116006)(33656002)(6506007)(5660300002)(44832011)(38100700002)(36756003)(2616005)(86362001)(966005)(6916009)(122000001)(4326008)(6486002)(478600001)(6512007)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ay81ZTRTb2lFVU1veS90T3pEZU9EcnBLb0F0VWN6R0JEcUp2eHl5NmVLUDNP?=
 =?utf-8?B?SDBSVngxUGFqVEUzTWpDN3phNmE0ZFJkUWErWFB5RzlZUzlxeGxnOUZTenNm?=
 =?utf-8?B?NTd6KzBOaDNMOVA1WUdDWTRKdWpic05RNjJ1OFNNZXlzc2gyd2pza0M3QmZM?=
 =?utf-8?B?TTJ5SkM0RWFBWVYrZ2RUVlBaTzAzZzRYS0JLUmZBMklNR2hrS3JUYzFLK3pm?=
 =?utf-8?B?V2NyekVXOVJ6ZkIzZDA1eGU0azlUNHMwb2FaR0x3RVNVMG5LUE9yWkg1ZDBL?=
 =?utf-8?B?K2EvZ1RtdmZnZUMxWnlIZlM0M1A2WThBWXN0eEVFQ01CS3Y4M0t2VVZyMEpW?=
 =?utf-8?B?bisvTkxnamNIa3N4RHE2eWRDeE1kUWpjbWNkVlgrRHNILzdaVFVydDdUZk1j?=
 =?utf-8?B?UkJEWDdUbmkvU3ExNGlaUjQwWkJ2bmxXcDVjRGVsbFdpdm5RZUpmMEhqWVAy?=
 =?utf-8?B?UE8yVlVNTHZCa1pIY2h2V1YyMlo2RloyLzdiajVlZlhLRnFJY2EvYmp3T01Z?=
 =?utf-8?B?VFpWbWpWRzRiZ3BSa2xjSFBNRXhaVnlvbzhMWDU3RlZwNTd3MVQ4MGI5Y0Fq?=
 =?utf-8?B?WHZyYTNQc1RwNTUyVEkwYW1LM1pYVTZMQk9MK1Y0K3c2MkhOaDVSRUxhMU5B?=
 =?utf-8?B?WUJrTDRBcHRMNnlBV3pIK3RzMVRkeU42cnpQTGpvK1RCNkQzaWVwUDFFTjc5?=
 =?utf-8?B?Q2pVdXdPQ2dCQzkxTEw0eVZySE5pdDlCdHVsSlorYVl3RjJOc2pCeHdDL3po?=
 =?utf-8?B?V3JmWFRodyt6TG8xYUtGQ3VDbnhXUW1YSEI5Q3kzZ2FjY1NDVXlyVmdzVTRh?=
 =?utf-8?B?eWFmeHNrY1lGdGtCS251am4yRGZGOGZtSnVOMG5mQVNySWtVN1htQkdlVDFU?=
 =?utf-8?B?Y3FZMHZZMVpxZ092ZGlTd09yTnphcDRndFduTjVTU2JWeUxtMWorbkR6b2FZ?=
 =?utf-8?B?dGlHckNCQ2RuQURkNXFVaExuMWdMc0xRcEgxbWRIWEVPb1BsWkFxQ3E4VGdI?=
 =?utf-8?B?YnVkMlN3dEVZd2VwTXJWT3d4YjRJQWRwWklNdXV1cXNyWHBzd3JEeDFPM3lt?=
 =?utf-8?B?dGgwKzQrYXFIR2VzSHMyeWdZL1dZWUszU255WUliRlVnby9UdTllRWhHZXdx?=
 =?utf-8?B?em1jTE5xMS95TWU4MHI3NjFGaEJVTjgyWGx3YzFuWWNTdVloU2x2Zi8xd3Fs?=
 =?utf-8?B?OEZ2ZCtzc003TE5xQ1R5QmxScytvekNsSjZBZjZrZmV2eXlCSWJOVFJwdFpB?=
 =?utf-8?B?Q1FWV0JGQjVJTFBycjhsSmpPa2l5Q1Nsd0RMeFRROVZrOVZhV0E3WEV3L0s2?=
 =?utf-8?B?eUtTVzRGTXR0TFBoeFpNMENuOURwWlhpM3FyZFpWQ2Z2K0dkY2V2a3M0eUUx?=
 =?utf-8?B?VFFyTE0waERjVkg1MmYwSXJnWGR2ZGxXb2dGWlBYQWdoMGJveFJYTFMyWElE?=
 =?utf-8?B?RFZ4Nk1BNlhNY01FcTFqUWhWZTE5aHRJMHRqbnYxeWYwZVJHWGdJR0dGdDFQ?=
 =?utf-8?B?aHQwZDlOQUN2em94R2EvWW5jYVNiSklNdGNMU3hYaEp1Tk9QVXQ0a3ZKVVBB?=
 =?utf-8?B?ejUydTNTdXdXZE0yR20zdldsMHQyd29IRTdqT0VmM3dOVGdDN2V0bEtMQ3JJ?=
 =?utf-8?B?WHZNVFJpaW5hcVUyYjZJeHZZVTBkbkc3MUFONndtdjlmOHpNZldPMjBsc3pP?=
 =?utf-8?B?MzVDOXM1K2pxUEhCeGFiNDJMZnIzMkVGa1g3THpkSFNZbXhTdmt4SGI0dmtF?=
 =?utf-8?B?UC81MlE2UGpMUitIVER0ZERxWmE1Q3pDbTBPb2tTV05zOWtLaS9mckVVQU5Q?=
 =?utf-8?Q?bnOD7mnIykdkYHFeqzCfSDNiRAH1n37gCVkpw=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <7C887DEA16F7E14FA313A21D3AEB5F8C@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2629.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afe1973d-e25b-4cac-60f6-08d97475fb54
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2021 16:13:52.5033
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CP3QQvf7ytva/ALfVzKyjFTMn+dHk4abgPAwCjBZyHj9RRuXQ2bvoUj7rOSEiuPwcCJxTTofaE7xP0KdykfBIsxbYasHplftLZMiTjK0nlA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4479
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10103 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 phishscore=0
 spamscore=0 malwarescore=0 suspectscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109030001
 definitions=main-2109100094
X-Proofpoint-GUID: gSOVX5JeRehoCh3X0VGCGJZCNKC52O6t
X-Proofpoint-ORIG-GUID: gSOVX5JeRehoCh3X0VGCGJZCNKC52O6t
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

DQoNCj4gT24gU2VwIDEwLCAyMDIxLCBhdCA4OjE4IEFNLCBQZXRlciBPc2tvbGtvdiA8cG9za0Bn
b29nbGUuY29tPiB3cm90ZToNCj4gDQo+IE9uIFdlZCwgU2VwIDgsIDIwMjEgYXQgNToxNiBQTSBQ
cmFrYXNoIFNhbmdhcHBhDQo+IDxwcmFrYXNoLnNhbmdhcHBhQG9yYWNsZS5jb20+IHdyb3RlOg0K
Pj4gDQo+PiBJbmNsdWRpbmcgbGl1bngta2VybmVsLi4NCj4+IA0KPj4gUmVzZW5kaW5nIFJGQy4g
VGhpcyBwYXRjaHNldCBpcyBub3QgZmluYWwuIEkgYW0gbG9va2luZyBmb3IgZmVlZGJhY2sgb24N
Cj4+IHRoaXMgcHJvcG9zYWwgdG8gc2hhcmUgdGhyZWFkIHNwZWNpZmljIGRhdGEgZm9yIHVzIGlu
IGxhdGVuY3kgc2Vuc2l0aXZlDQo+PiBjb2RlcGF0aC4NCj4gDQo+IEhpIFByYWthc2gsDQoNCg0K
PiANCj4gSSdkIGxpa2UgdG8gYWRkIGhlcmUgdGhhdCBKYW5uIGFuZCBJIGhhdmUgYmVlbiBkaXNj
dXNzaW5nIGEgc2ltaWxhcg0KPiBmZWF0dXJlIGZvciBteSBVTUNHIHBhdGNoc2V0Og0KPiANCj4g
aHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC9DQUc0OGV6MG1nQ1hwWG5xQVVzYTBUY0ZCUGpy
aWQtNzRHaj14RzhIWnFqMm4rT1BvS3dAbWFpbC5nbWFpbC5jb20vDQoNCkhpIFBldGVyLA0KDQpJ
IHdpbGwgdGFrZSAgYSBsb29rLg0KDQo+IA0KPiBJbiBzaG9ydCwgZHVlIHRvIHRoZSBuZWVkIHRv
IHJlYWQvd3JpdGUgdG8gdGhlIHVzZXJzcGFjZSBmcm9tDQo+IG5vbi1zbGVlcGFibGUgY29udGV4
dHMgaW4gdGhlIGtlcm5lbCBpdCBzZWVtcyB0aGF0IHdlIG5lZWQgdG8gaGF2ZSBzb21lDQo+IGZv
cm0gb2YgcGVyIHRhc2svdGhyZWFkIGtlcm5lbC91c2Vyc3BhY2Ugc2hhcmVkIG1lbW9yeSB0aGF0
IGlzIHBpbm5lZCwNCj4gc2ltaWxhciB0byB3aGF0IHlvdXIgc3lzX3Rhc2tfZ2V0c2hhcmVkIGRv
ZXMuDQoNCkV4YWN0bHkuIEZvciB0aGlzIHJlYXNvbiB3YW50ZWQga2VybmVsIHRvIGFsbG9jYXRl
IHRoZSBwaW5uZWQgbWVtb3J5Lg0KRGlkbuKAmXQgd2FudCB0byBkZWFsIHdpdGggZmlsZXMgZXRj
IGFzIGEgbGFyZ2UgbnVtYmVyIHRocmVhZHMgd2lsbCBiZSB1c2luZw0KdGhlIHNoYXJlZCBzdHJ1
Y3R1cmUgbWVjaGFuaXNtLiANCg0KPiANCj4gRG8geW91IHRoaW5rIHlvdXIgc3lzX3Rhc2tfZ2V0
c2hhcmVkIGNhbiBiZSB0d2Vha2VkIHRvIHJldHVybiBhbg0KPiBhcmJpdHJhcmlseS1zaXplZCBi
bG9jayBvZiBtZW1vcnkgKHN1YmplY3QgdG8gb3ZlcmFsbCBjb25zdHJhaW50cykNCj4gcmF0aGVy
IHRoYW4gYSBmaXhlZCBudW1iZXIgb2YgIm9wdGlvbnMiPw0KDQpJIHN1cHBvc2UgaXQgY291bGQu
IEhvdyBiaWcgb2YgYSBzaXplPyBXZSBkb27igJl0IHdhbnQgdG8gaG9sZCBvbiB0byANCmFyYml0
cmFyaWx5IGxhcmdlICBhbW91bnQgb2YgcGlubmVkIG1lbW9yeS4gVGhlIHByZWZlcmVuY2Ugd291
bGQgDQpiZSBmb3IgdGhlIGtlcm5lbCB0byBkZWNpZGUgd2hhdCBpcyBnb2luZyB0byBiZSBzaGFy
ZWQgYmFzZWQgb24NCndoYXQgZnVuY3Rpb25hbGl0eS9kYXRhIHNoYXJpbmcgaXMgc3VwcG9ydGVk
LiBJbiB0aGF0IHNlbnNlIHRoZSBzaXplIA0KaXMgcHJlIGRlZmluZWQgbm90IHNvbWV0aGluZyB0
aGUgdXNlcnNwYWNlL2FwcGxpY2F0aW9uIGNhbiBhc2suIA0KDQpJIGhhdmUgbm90IGxvb2tlZCBh
dCB5b3VyIHVzZSBjYXNlLg0KDQo+IA0KPiBPbiBhIG1vcmUgZ2VuZXJhbCBub3RlLCB3ZSBoYXZl
IGEga2VybmVsIGV4dGVuc2lvbiBpbnRlcm5hbGx5IGF0DQo+IEdvb2dsZSwgbmFtZWQgImt1Y2hh
bm5lbCIsIHRoYXQgaXMgc2ltaWxhciB0byB3aGF0IHlvdSBwcm9wb3NlIGhlcmU6DQo+IHBlciB0
YXNrL3RocmVhZCBzaGFyZWQgbWVtb3J5IHdpdGggY291bnRlcnMgYW5kIG90aGVyIHN0YXQgZmll
bGRzIHRoYXQNCj4gdGhlIGtlcm5lbCBwb3B1bGF0ZXMgYW5kIHRoZSB1c2Vyc3BhY2UgcmVhZHMg
KGFuZCBzb21lIGFkZGl0aW9uYWwNCj4gZnVuY3Rpb25hbGl0eSB0aGF0IGlzIG5vdCB0b28gcmVs
ZXZhbnQgdG8gdGhlIGRpc2N1c3Npb24pLg0KDQpXZSBoYXZlIGZldyBvdGhlciB1c2UgY2FzZXMg
Zm9yIHRoaXMgd2UgYXJlIGxvb2tpbmcgYXQsIHdoaWNoIEkgY2FuIA0KZGVzY3JpYmUgbGF0ZXIu
IA0KDQotUHJha2FzaA0KDQo+IA0KPiBUaGFua3MsDQo+IFBldGVyDQo+IA0KPiBbLi4uXQ0KDQo=

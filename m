Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 302CB405C1F
	for <lists+linux-api@lfdr.de>; Thu,  9 Sep 2021 19:30:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240946AbhIIRcC (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 9 Sep 2021 13:32:02 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:44632 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241213AbhIIRcB (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 9 Sep 2021 13:32:01 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 189GZHwt008952;
        Thu, 9 Sep 2021 17:30:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=61AjseyUkDlMRRysfHufwB3uFTu/XEyd2J2l5jWFpjE=;
 b=pZil7V8Twdh96PIZYTyG3r4u3aRZLOhMRtgTWCr6HZ8T6ekD5XEmWqYhFDiAaYFhhUyw
 811cylvwl9xtt9Kz5mx70cws20rtNMFNspSZVaYIZ3B5NlGUzh25iPaD7XocZCDbwkmM
 +fIxcgBISexbYJMEpG0vQtvQpICZlg7wj7py5D/lJwL8rfpE1aPl+AjGVXEEU/4OaV3u
 Baszz7freZ3YeYg1uXfR4dt6tpoSICe6+cWnc3F6lBeui00zQxzuK7Y/YJPrMB/z3Fyy
 GkI/4MmQKMr2DfAkbQ+hnJBziBeE2plzaBGGJ/k17u9WiRjL3/EWRez0u7hgi9btx83b VA== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=61AjseyUkDlMRRysfHufwB3uFTu/XEyd2J2l5jWFpjE=;
 b=z8TVayIjj/DoSQIFWvYrxxru+xSw5ff+VzENic6yQFEKyXtDqdxwn7BRcVoiYWTHit0i
 JjI7fjkzDPwtgemR+VTKKS1ZwLpwurXnsnk5llFad9E6vtUD1NUhu3qzzwd1hB/pfkpg
 wF2m9J7sT9SAZzf33XURDK9k7wT3uA6N6OcJ00PIchY6P9f2aVQC4BMPaGHerKBT9m59
 Shp3V5A2pQmvgiwLQjSSs8BOxQ5caSsavkafswUvxePBhiBA0Mgm1ph/7S/bbrX70XGu
 Z6jTgmVPn4BWy60VRTzXxztTxAmjjlbTSIQzMxbZxTYgxmJoNoplE3zYeLfuhfum9o4O lg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3aygy699q9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 Sep 2021 17:30:49 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 189HQqDi102213;
        Thu, 9 Sep 2021 17:30:48 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by userp3020.oracle.com with ESMTP id 3axst5rvjj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 Sep 2021 17:30:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nLIuG+aTwB4au/qkIGJGmeQC2tr0Be+A5kCFHrb6+OW87FJtbNylr8iaOW2LHHApeZb95+/t+nMaDXpixp41USmrZYFXKW6GAJbDMThCf4QcEoHIlWu+9+ZEShowO3dODXuUijnGpzEW7n25LFdUyFVrkVhfuZZpyj0CE9jK4UW0d0nIMBhCExyGAW1G0O/HGr1XlvOlQ09unl2zqNGw/gYzRFgocx1lEmIY3JNo3IciEAk+JKqiPNSNGL86oEYgNMz2jla8PdCLf/rJCtryjWGIrQ8IM8xogZ0OJC3CelYuicFdRAmqJ5sRvHOtNGAgrTl07uuRZ010MbeOMkwf1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=61AjseyUkDlMRRysfHufwB3uFTu/XEyd2J2l5jWFpjE=;
 b=K/3ZNvtRMb1MItXOZFtvmuBEGkJXb/hTMNDkM6r5RZvN3wpoIbjQUcd3UNCZlSXkfYStLPOLFPG5VCHlnQdGrS+mrdB6CO9GAznPHXS1xnpKuz/4bd78QxOD6nAVz0GnKy6i8RP0IGaSvQkec7RczEWpyJzQnsMAj4qPjkjVPFPZFpdgpU0Uh0iLIBChHcw05xd0uVqldCs9IALvN+lvPO1DsAlj6XYnPdSZ8r0Gpn1XvWLtzeOANRESINnPtwT282CKC+GQL8ECI7h0Qc0I62IXdUhBDL80Hi235yxYFuBIbVJF3wrIee3OynSHoZOQc0DTmEcZqilIFCR+qRIyMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=61AjseyUkDlMRRysfHufwB3uFTu/XEyd2J2l5jWFpjE=;
 b=bGvNEQNiBdxuIYYjo/HdRXO7OxzqTHx3aQHSPNo09wpEwpAb00WfiuS64zNNCsCdYLHUBARTeExhhIpcpTPdOmdET+oAw0dEr0lmCk8Bo28Qy/ZWqS/51UAGsaAWi4ClkQgnsp7CGVsG6hY6KgdwqFZqEPoNthbiMKDO+sc9ktI=
Received: from BYAPR10MB2629.namprd10.prod.outlook.com (2603:10b6:a02:b7::24)
 by SJ0PR10MB4815.namprd10.prod.outlook.com (2603:10b6:a03:2da::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14; Thu, 9 Sep
 2021 17:30:45 +0000
Received: from BYAPR10MB2629.namprd10.prod.outlook.com
 ([fe80::c9c2:64d4:c67f:6837]) by BYAPR10MB2629.namprd10.prod.outlook.com
 ([fe80::c9c2:64d4:c67f:6837%7]) with mapi id 15.20.4478.025; Thu, 9 Sep 2021
 17:30:45 +0000
From:   Prakash Sangappa <prakash.sangappa@oracle.com>
To:     Jann Horn <jannh@google.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>
Subject: Re: [RESEND RFC PATCH 1/3] Introduce per thread user-kernel shared
 structure
Thread-Topic: [RESEND RFC PATCH 1/3] Introduce per thread user-kernel shared
 structure
Thread-Index: AQHXpQ/g06hPOdU64EmuN7MijWkmM6ua8BWAgAEGoIA=
Date:   Thu, 9 Sep 2021 17:30:45 +0000
Message-ID: <F1DBA19D-8151-42AF-9C97-DF75159B8F88@oracle.com>
References: <1631147036-13597-1-git-send-email-prakash.sangappa@oracle.com>
 <1631147036-13597-2-git-send-email-prakash.sangappa@oracle.com>
 <CAG48ez1isvC9c8aem1m6n2uPPHzG4H-otDW7yEUJXDktf=q0Ag@mail.gmail.com>
In-Reply-To: <CAG48ez1isvC9c8aem1m6n2uPPHzG4H-otDW7yEUJXDktf=q0Ag@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
authentication-results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fa4bccdb-4587-412c-f2e8-08d973b78e49
x-ms-traffictypediagnostic: SJ0PR10MB4815:
x-microsoft-antispam-prvs: <SJ0PR10MB481597B967398624A5C3BEF3E4D59@SJ0PR10MB4815.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: G0a4V1xLkKAUaUmCD2+Wq+hVClO+fTGKb9cF9mMwPnFCzg+QNVBBubRj+s2ZLRgzehQ5KqDJnUwiRw39hPTNn5ILexw+noBHVudI1Lteuth74b47ldyiVVPdPeefv9m8Z2/j7Yo5RH6SZsmjBEPICQXWqMvbrcxgzeGlPPQgXixypWoE0Cpdtcg3xyYSQaUruyLpm2/JePRsp3zgieFJikFNLU+JC4dsbS1u1Xfmvf68ZJ+40jdwu1Os72Ntq+qiW5DSBkEI4wDgGGamx549yaR2r7Jma+VDRGp3lCos6Oj+RGfGOSGcCVgZwlQTChPN/eJ3AH2l62RkhP0oXZDWM943dYI6ulRfQDScDT7Fs48HqrZYpeacNeUrIDIXKQN3KSUVT/c8HhgAOO5yiIp3sTeXZDnBsWJR6BGX6tScgjwpVTlSnjWbAQr5AnrAH0yjNZaOhHwiPvKvxvfDSiVhdskDTHyLwmXPPQ5MFljfycLhxZJ2xnCr6ozxMS/IlO8XeAhQ6XZJd+c1uieVxGMwh+bJjof7zdqdcZyTTvZ+g0NwJei/y3ufgZk8RgKiHxl2uEAW0Eh0X5P0EovAAVV5qBJERsx9uIw5rLCcYE5AamUB8ZwIDtmUuMKRPjUdTpxCBNnYp21urysjOntavqORMdetnFjd9qzx3WT9sxvLZG9482Fq2F17LvUWJ7Dog6zjojT6ls5uT785rzGnef6XBXdUCyLaXwXPHsLuqmCZOKA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2629.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(136003)(376002)(346002)(366004)(39860400002)(4326008)(186003)(64756008)(66556008)(66446008)(44832011)(38070700005)(2616005)(66946007)(6916009)(53546011)(478600001)(33656002)(6506007)(36756003)(54906003)(8676002)(66476007)(76116006)(86362001)(83380400001)(316002)(91956017)(2906002)(8936002)(6512007)(5660300002)(122000001)(38100700002)(6486002)(71200400001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?vzzWc0ByZ6+UY3zNDjZIbd7bC+UB6kMgoDUSqG4ObelIE24/VHmdyT5HOoBi?=
 =?us-ascii?Q?BU8biN4YLP67KD5iynz8+azE3QOC+w5GcYWasS+OhNoKnO8oWjl8yXvCKArR?=
 =?us-ascii?Q?mTdNJZA1mDf2XCWYbBWn70UAV2ozJ+oJTGpSeb8J98gTwG0/ugWd1FMgnifC?=
 =?us-ascii?Q?oQPFYmN0sC7mp9h3azHudruJ9/qWXBMyaNsac9s8iLQifNIt6bnmB3bStWjG?=
 =?us-ascii?Q?aUy8HswnfGSSO0F6zKgHoMXy8MrYhngwfD18IwQABqmWaxpF7gM5nQRK7amK?=
 =?us-ascii?Q?1OBCbW2AXPhrcq5yobNc0hwlT0/njn1oxR8vhcOC6R/1RLGaJR09VdORLbmV?=
 =?us-ascii?Q?vqXRV8UI2D3IcxGy0m6Rm0V9OCBnJ/A0f/5DfnJVwmZk4qDvFKWw8YkpDjqG?=
 =?us-ascii?Q?LDV9aBGZVVPPaei41jX+nm4jX/VekIWbJ9CdDiG8fF4LebaFOSXgorzHQmho?=
 =?us-ascii?Q?iparxeNeybixOzwQUQIYuAgPu1cC+Yaat/qlsR+8Tm8/VyiZAvoYpVr8alrz?=
 =?us-ascii?Q?HyqNatJAOjXtID36iXI9p33FZx07Y1vXA6dryQXQNNsk2gCVcoV1kLQewlqh?=
 =?us-ascii?Q?UmJ7xMBovfXtRCX7Y0AWPknWsG3YrPZXuZ/cWnbbulFhjvJ4Z1sYoKxYzrCo?=
 =?us-ascii?Q?qwuLvbaXMXONIQIFdPAMm0TCXPu3FHKVpsrwTuNgzGAZK2M4J1S1iqNVQ493?=
 =?us-ascii?Q?gJBSN8d9K9H9eVIChO4jwt+1KLUhd9zCowBvZ4HMAmuXyabyA3VeRbe4nI5v?=
 =?us-ascii?Q?p9w8lr5H9caRP6HU+AfNYn0VgIYA3fNg4YUjKDL+thUlt5i0OVp75JyjHupQ?=
 =?us-ascii?Q?UYJ4lKZwFlbJPC+UyKpPzns9NjC88HyridxniTpy+2Jw4j36nKkQwtXFSSOe?=
 =?us-ascii?Q?k+RSZMAabYq/fiu90GzA5iL0pVGOxuKT1EwTDlv9J2CNeNB6QNR7EWBWFWYO?=
 =?us-ascii?Q?Y38wbntHmV8jVouk5+0kzqXnkY7LiagDyAOyuUA6unxzxEFlzLbkB/xZQ4Jw?=
 =?us-ascii?Q?ULpU+ewv5xRGYCFNr71UZ7Hf3f7yTywDeIPxp5HhUKY2c941rzWXRMYwobTy?=
 =?us-ascii?Q?GGi9EbcxI2iqWmKPDVV8ynljq9ZIk0qpWA//4aj5hjO+3nSp+mq3AjnGDwh7?=
 =?us-ascii?Q?x0y60Dlx5iKFO8N/sQWQAoE46YS2MKacRBE+FRoee8Akm+VURhNzKJnaFjya?=
 =?us-ascii?Q?vztymAG4RE2jXWNo/iJCuxQItQ8hDKGALWpuVy+tC3HMMM+EGY8Gsvi7H+uS?=
 =?us-ascii?Q?RWFk9HoeqMcnyYjmrhjWekn5jrvsy5tk7aO0jVaeKjnASr+ZNPaUTSiCaKDd?=
 =?us-ascii?Q?vHjObsDn2+5L6625zIH2NvGQJp6/uKfkuYvtMRIiKAAg44LnTKQRmHSK8UPi?=
 =?us-ascii?Q?gBF3A88=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <435572A83659224A98041FEB7BC3A475@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2629.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa4bccdb-4587-412c-f2e8-08d973b78e49
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2021 17:30:45.2816
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /tq2gIR8Qr5Vqt8g+WC6STwRFDxcK/pQtGs686TarXuuxqEQm6V8y/vZeIpJpcXaVTYiYdQ+1NNpawvgJMDru5zuDOGUZhfrJwqbPU4O0x8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4815
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10102 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 spamscore=0 mlxscore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109090107
X-Proofpoint-GUID: kTqr9MIRyza9t-OdU20lLG8dgVU0vqny
X-Proofpoint-ORIG-GUID: kTqr9MIRyza9t-OdU20lLG8dgVU0vqny
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org



> On Sep 8, 2021, at 6:50 PM, Jann Horn <jannh@google.com> wrote:
>=20
> On Thu, Sep 9, 2021 at 2:16 AM Prakash Sangappa
> <prakash.sangappa@oracle.com> wrote:
>> A structure per thread is allocated from a page that is shared mapped
>> between user space and kernel as means for faster communication. This wi=
ll
>> facilitate sharing information, Ex: per thread stats shared between kern=
el
>> and user space, that can be read by applications without the need for
>> making frequent system calls in latency sensitive code path.
> [...]
>> +               /* Try to map as high as possible, this is only a hint. =
*/
>> +               pg->vaddr =3D get_unmapped_area(NULL, TASK_SIZE - PAGE_S=
IZE,
>> +                                       PAGE_SIZE, 0, 0);
>=20
> I don't have an opinion on the rest of this patch, but from a security
> perspective, please don't map things at fixed addresses; let the mmap
> code pick some random address that it wants to use. If an attacker
> manages to overwrite some userspace pointer with chosen data, we don't
> want them to know an address where they can be sure something is
> mapped.

Sure. I will address this.=20
Thanks,
-Prakash

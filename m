Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2444440B5DF
	for <lists+linux-api@lfdr.de>; Tue, 14 Sep 2021 19:25:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbhINR0S (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 14 Sep 2021 13:26:18 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:45294 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231573AbhINR0M (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 14 Sep 2021 13:26:12 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18EHMQIa015671;
        Tue, 14 Sep 2021 17:24:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=zdnsgl87GRDJ4dLKeM2SCUXSPqqlNYrFfE360WN/q3E=;
 b=r/qpUhFc76/5QyxTn3+xBJuHJ3Ccyx60SU0JqMSbKik9GXp5Hua7nPa9g+xA3OuWIv8N
 tFwXS2Bk7/+W5PdqLzt3Y1LhWG3BxO1mlIj6bj6F6SGJhQRU+PKhfE5hhva9qL5ZhNkq
 5ICBW57PSSjb8U81jVW83wyI4ppoYCNCqYTw+u4WVWdrZQPVcyWDQsyPgMUQilP/HeC2
 76qi/31kp7rhUYCswu71WJWOW7ckH/+MpRctZI3b9ZoRIXa7P658NGRlxMV1/BKBjmsW
 8kSj90LCGYdFcu6s6+WLYqFfdRKkxnpnGiNwqN5+IelluJGGd8pcCisFDfq6aTGx3sit 6Q== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=zdnsgl87GRDJ4dLKeM2SCUXSPqqlNYrFfE360WN/q3E=;
 b=Pn9KIa5XXqJqzpFfH4nLM8Ek3ET5dsuD6IZNMOqMBW6REaQKDl29Vx9jd740oFd0n0nV
 zf5v4eX7t6avAr9usimqn9xQy6kDr71SStKC5dDb3p0A721BXnar5Vo/PE6vHGO0NRzx
 0INO/UMK7b7MlwCtTE6MpsIwo22uZXvorjRZbVsqd6HBBuEDp4AiJ/U/vDI5DhSFzsiu
 PZZkByzYUpevcnUzBv8U4jjxdjhYsLVMVRQZeI9MvboZihUVjBBEcKRWGL5RglzHfItS
 9UQl1UhBN7VCuaUBrkjwveeYRbtZHWTABdP3fKP8keEizMA7FbDrENzFkgGIYqiQAaon Lg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3b2p3mje9c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Sep 2021 17:24:52 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18EHAXPF082263;
        Tue, 14 Sep 2021 17:24:51 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2104.outbound.protection.outlook.com [104.47.55.104])
        by aserp3030.oracle.com with ESMTP id 3b0jgdecwj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Sep 2021 17:24:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZnBlYM/Tdqtywb7w4ArdewWN/KrZK6GuuIyamEqZgUAn3GIfcVZ7LztdRgAmaDCKNYRaVRqJnEC+BPEPSx+GTuuDcCPiQp8xsqM9TTbqSb3eWIvxn+ZxAYRKI5C0HNgzP8Vu6UJeDavzmpKK9iQYunOQGjgrovHaLXIpRNKSyPVDyhw49EbdyeC71XsCZQnG1zBrbJtW/423nlH8pBMxeoMd2Tbr+z6YAynYXYswA0JXkhLonCIHKa20fX2Ss9dWDZEJ94W9AmmZhZTICGiVpEE/TwNRFhpStWr0GImWLxeZu/HAoKGw3v3mZigRBeQzf2RRhIdDyqkyDen8UVv9UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=zdnsgl87GRDJ4dLKeM2SCUXSPqqlNYrFfE360WN/q3E=;
 b=eoYZByxHzalQFc8erP6bBFaLvX67lnaiEgyQ07/JoX5DbT9Pt8X1jnd4xVAw/8fY5BL6aD17Lh+hAWCRiAtt1DGXy+XvPYcIxit776y3vLh5EqSZR/HyGf3LnF5hep9g6eNArF7oRsAMJSbYHDSWse/ZSBOP83+9Ud76MCPT0f6W3TTNJLGAaKUEk0kEUVjRtLnYDfbkzVwpLPp61pQkNM8o9UWBdmE1tMn3MPbhZlA7/ltwc9kg3H+Y/2NXxrh30fGGliGfmDSFjwIJC43GaYu+O2/QPpL2Wzzyxf5QJy5+je6T7dXK8Daao/orE5DviV8uy0VPFlPqoSfgLzAvjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zdnsgl87GRDJ4dLKeM2SCUXSPqqlNYrFfE360WN/q3E=;
 b=iXc9R/kegGGJzB4Kthv8/uENw7w18Bkkt1ToJGzHkgJs1G4PiA72BVNiv4nC4N1mu/lpykqHs1ZDhcSn0ZcSdWM1cOg1iSkAkbtp3w7i12IIDIb37NnkBgGYD3chvSq53rwpFdZh3Ohz6HIFbRCd2+zAafFpiFHh9/r/G9X8uRM=
Received: from BYAPR10MB2629.namprd10.prod.outlook.com (2603:10b6:a02:b7::24)
 by SJ0PR10MB4557.namprd10.prod.outlook.com (2603:10b6:a03:2d4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Tue, 14 Sep
 2021 17:24:49 +0000
Received: from BYAPR10MB2629.namprd10.prod.outlook.com
 ([fe80::4c4:78db:507d:90c3]) by BYAPR10MB2629.namprd10.prod.outlook.com
 ([fe80::4c4:78db:507d:90c3%7]) with mapi id 15.20.4500.019; Tue, 14 Sep 2021
 17:24:49 +0000
From:   Prakash Sangappa <prakash.sangappa@oracle.com>
To:     Andy Lutomirski <luto@kernel.org>
CC:     Linux API <linux-api@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RESEND RFC PATCH 0/3] Provide fast access to thread specific
 data
Thread-Topic: [RESEND RFC PATCH 0/3] Provide fast access to thread specific
 data
Thread-Index: AQHXpQ4DkHk4xUSqc0e/8XETIulFxqub+hOAgAfWpgA=
Date:   Tue, 14 Sep 2021 17:24:49 +0000
Message-ID: <4A2A9989-F407-4D5D-A9ED-C82EF3E8103E@oracle.com>
References: <1631146225-13387-1-git-send-email-prakash.sangappa@oracle.com>
 <CALCETrVHf90pWD6YnE3DCOo2bw1StKGPvZMgFz9a08eWPK2pFg@mail.gmail.com>
In-Reply-To: <CALCETrVHf90pWD6YnE3DCOo2bw1StKGPvZMgFz9a08eWPK2pFg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 63a8498a-bb3e-43a2-01c8-08d977a48e35
x-ms-traffictypediagnostic: SJ0PR10MB4557:
x-microsoft-antispam-prvs: <SJ0PR10MB4557B3C2C763566F223878AEE4DA9@SJ0PR10MB4557.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uTn7WCQa/rpexi8vTdYVmVrtHDqCYITahPxie5n2A3TFrr4cekJlXXFZlt8gEvb6ykZt24X4x7O0qIOM1eMmzyTLsv6a2CNX67TbKHCiKSxwpzuU4inC++moBSxsnQFlK92wYl1hABi2Cfdz/X/9Joq4jFCJo2oaip3Q6G7Agl+XAL4O5ZY656Jk6odPZp/bLyQJIXHpiZ0ghBmk9MtttJYsGPBdWlPZJfU5vXEb5zTEb1Eta3LYmeY1cKbLg/3AE2Und2l+VqV11rwkJc6sqSAv/YhkWzevQDrxZpmcbLcC8CTFobTJGugXha9gs41WAxTWkznNPGX4qNCduHhp2+euojDR6IriKREVnRtFSMun0ZJH+lm78U34HhiyoCE4C+XFCTPYVx3ubVPloJcGKAJqopTtj3ryVhTH64o0EdTuE1qT47+/T8P/PjtrAdMD3iq+m/kSIKO/4rk9B9bP+d3FbJCikAVyTLc2bv90g3Sd8jcsG+NadcuQVuSlr/6/rK0HhrDNtbZT7zVrvMUsB1syp5+bPNxe2VTSywE+e8/B0uYOuVym0oqb+n6NAMrcGSXfKDqi8yn5s8TfHL8aOui7pqJ8fvlQcPCQeYN3W65oey4+TV7S7zOwjlBtIaOnkEvgcOf94uQ1fmopN6lQ6arS34GzBtWhu/m0sK37T85S5P6ovVNAG7gqoH7CLvXxrC81kMIdAEGLnWJqQBpEbNbWJbUNxCyghdhUTDAmI8esoBKGswarQJ43/qi9JadJ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2629.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(376002)(366004)(136003)(346002)(396003)(8676002)(186003)(8936002)(2616005)(66446008)(66556008)(64756008)(6916009)(4326008)(86362001)(316002)(478600001)(36756003)(33656002)(38070700005)(6486002)(6506007)(53546011)(5660300002)(71200400001)(2906002)(54906003)(122000001)(76116006)(66946007)(38100700002)(66476007)(44832011)(91956017)(83380400001)(6512007)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?cqTpRxt7SoEuC+uaKyWBKENHBwOWjK1zrzzyRmzhgubHPB79SKb7aHPlkAEA?=
 =?us-ascii?Q?KvirzBBUoHFbxF3AXRhDWCo7Q8Dlf7ddvQGPpNfapWkhdh2rzyebP+r/m7Ja?=
 =?us-ascii?Q?YkPtjOHL6glUjIFwKqMuQr+VzuctUGKV/rSEtSPdeJU1Qpi2XmrnwZVm9mJY?=
 =?us-ascii?Q?ZRe1zbNhu+FAkqHRMcrcuqs4qCjCw3j9WDurCluxnvN6TYsT2SJhfGhOfIMc?=
 =?us-ascii?Q?IgqGpvp/KWvDjoAQOqUosL7nalGY8uW5lxMB076zjYQ1Rl7u4MYqARn1HLiZ?=
 =?us-ascii?Q?BGo++GXTeutFY7Bdc5POiNbVm2huF5o5MhoOkv32MQg4U+RLYC6hvtqLfl5i?=
 =?us-ascii?Q?/iufivpbyePCKY/fqTDc7mX9Ks5xdIq1WbdZ/rs0IybKfn8whf6z56bPPxdb?=
 =?us-ascii?Q?ntM8eHcLsRRPi/8cLsvczL94y4DanvEjRTsoeYCZ29cQnGveTQ/KTaf2Sx3P?=
 =?us-ascii?Q?nX/3vYV4NHt3MYs+9Qy+Elu/9k2mJ/GLIQKd3rS23t12GTkB/Wgo9yngXQoX?=
 =?us-ascii?Q?X23kuKZSiMvTCfNfPYnmaVXS+TNl85lwuQCizVpyT1rhiOnamZLpHvhrRdKK?=
 =?us-ascii?Q?oU9sAXibMbVGbCtHP0WcgvuEpB6WqLxY520fWEE8SKi8I1oHbOzbGo7LOmnI?=
 =?us-ascii?Q?v8QQD3TBJmDYOU8tuEIWsOWPg9pAUmfEyh9gi3ceffhXGKraxA+DkLB9h1eI?=
 =?us-ascii?Q?Pp38vvVDEsN+zjsEdhJ9mkFqejjGhVv2JSkm2MP9jAeluSAKwZXLJgjA9YwJ?=
 =?us-ascii?Q?cemdPDMS1uzVWSKKekENEGZNX3PsW6IaOphs1klB3Jd32xJZAbrlUqfZte0e?=
 =?us-ascii?Q?tK7YLbIPilgoQb6e0VX63ttPiYPzyUZGRhtfxPsLryvVaF6j5L/hJKEMTyLh?=
 =?us-ascii?Q?uyPwQt3AUhftw8FCDq5gg7kIpzq+udODFNYcG3+18GoIGdOUEUWNpvX/JWdR?=
 =?us-ascii?Q?PWXvFQ58X/mqxvJuuE5PlNJGubx/0CCN1osiSnXnTWtKEfKrdBfwGoow64A1?=
 =?us-ascii?Q?jUwHZNpk8HD64DOplAkZvxrHFRfLKXjnRaERdLMfGZfe9tVbnyhc6B2XWG+P?=
 =?us-ascii?Q?FJzbCnR2PlbQHzdah7UcdWns5k7WRi7A4ugOp4ktvj2K2OzDdKd7/IXtv5AN?=
 =?us-ascii?Q?mMk4ykw9gRwm45wleEQE3en+nhoMnKPunOsdJDj0aohwFN+xTRE3v8hyTuWG?=
 =?us-ascii?Q?NrXIhM/EQQsgDhPxA86oodUhKwggla5k/UOe3AHXynMcCTjvw0JeJOv0LUkU?=
 =?us-ascii?Q?M0Vdy/648tKZUaHK95gOLSZ9Un2mTI0Q5IQVuxTototBEVmvWRSNjEqOpy9o?=
 =?us-ascii?Q?AD7Xa9VqBVZmfHww6Da2mJtjC4JwdcgUCXJUbmLbPsRZtBUs0k2hjbgwBSAO?=
 =?us-ascii?Q?cW7pwBM=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <EC18DB45FCEF8744BD1633FBB6C87CFC@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2629.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63a8498a-bb3e-43a2-01c8-08d977a48e35
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2021 17:24:49.2447
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x4zZomTtJG6SRf/TCAMo/1OBNh8WF0CE3C6Y+IrFbjy4OPXJ4rX05LcBu90Qt1vmBG/kflWjMR9V8NyAML47JNj9iyxyXSekY/e7Yqv1K5w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4557
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10107 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0
 mlxlogscore=999 adultscore=0 bulkscore=0 spamscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109140100
X-Proofpoint-GUID: DV07fmSUR9apCZD6ow6163QIyPbwdltG
X-Proofpoint-ORIG-GUID: DV07fmSUR9apCZD6ow6163QIyPbwdltG
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org



> On Sep 9, 2021, at 10:42 AM, Andy Lutomirski <luto@kernel.org> wrote:
>=20
> On Wed, Sep 8, 2021 at 5:02 PM Prakash Sangappa
> <prakash.sangappa@oracle.com> wrote:
>>=20
>> Resending RFC. This patchset is not final. I am looking for feedback on
>> this proposal to share thread specific data for us in latency sensitive
>> codepath.
>>=20
>> (patchset based on v5.14-rc7)
>>=20
>> Cover letter previously sent:
>> ----------------------------
>>=20
>> Some applications, like a Databases require reading thread specific stat=
s
>> frequently from the kernel in latency sensitive codepath. The overhead o=
f
>> reading stats from kernel using system call affects performance.
>> One use case is reading thread's scheduler stats from /proc schedstat fi=
le
>> (/proc/pid/schedstat) to collect time spent by a thread executing on the
>> cpu(sum_exec_runtime), time blocked waiting on runq(run_delay). These
>> scheduler stats, read several times per transaction in latency-sensitive
>> codepath, are used to measure time taken by DB operations.
>>=20
>> This patch proposes to introduce a mechanism for kernel to share thread
>> stats thru a per thread shared structure shared between userspace and
>> kernel. The per thread shared structure is allocated on a page shared
>> mapped between user space and kernel, which will provide a way for fast
>> communication between user and kernel. Kernel publishes stats in this
>> shared structure. Application thread can read from it in user space
>> without requiring system calls.
>=20
>=20
> Can these use cases be addressed by creating a perf event
> (perf_event_open) and mmapping it?


As I understand these will be sampling based used for profiling? So will no=
t=20
be suitable for the use case we are looking at.=20

Also, it would require every thread to open and create perf event mappings.=
=20
Not sure how well this would scale given the requirement Is for use by a la=
rge=20
number of threads.=20

The proposal here is to provision a per thread shared memory space(between=
=20
userspace and kernel) with a small memory footprint as it needs to be alloc=
ated
from pinned memory, to share thread specific info, like per thread sched st=
ats
here. This should have low overhead and scale better.=20




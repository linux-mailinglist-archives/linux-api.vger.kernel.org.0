Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 164E240B439
	for <lists+linux-api@lfdr.de>; Tue, 14 Sep 2021 18:10:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbhINQL7 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 14 Sep 2021 12:11:59 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:16864 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231739AbhINQL6 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 14 Sep 2021 12:11:58 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18EF85Fo006296;
        Tue, 14 Sep 2021 16:10:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=fA/W1TYWg8kmOxY7YN7VHQx3nFqt0a6zPlYmsUCUyMo=;
 b=0OvI+RMitG2oVWyDu1t9C2XmmnmMpUTBiLWvoKpgntbDgpguDF7dGaIn1b7emkEpqkzC
 34ASYJry6cbEUl9ai9gQetE2slsWiYTETktv+7AwxW5BgZv//7bgTtiEQt3AonWHsbwc
 4QQ3tCPH59OHsuzSHulNQVRmDoC3oNa/Kw3yIOM6yPSuSi1CHZgSVqMGllYl3Zt6xBAF
 tI1OVW3ryOzMITZwYe3dRotD2oxEZ2XHQTcpXHZNBlQB+zXgi3jfMh/gw+i6mgz2KMJ6
 6gPqWUSmHcYidreU9fohzg1GlTQFTOAurW7uzj/3Wjw90rW15nvHTO3w79VQ9cwgpWHw 7A== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=fA/W1TYWg8kmOxY7YN7VHQx3nFqt0a6zPlYmsUCUyMo=;
 b=DQ9W5dQrT9T22A43VzJQbp389yUr89tbsWcloesME/94cj6O+hp39AY3+F3yAqtODp74
 ZEYYjTjTAo9Pxv65/H9RZEelBbnMTDk1HMQm+9r/mSC3W6TKVVpGbW8gh7fAgDRc9sd+
 L37NoXKVJCfHbHYTxCDHEsMl8ZqOh/hu2JJwmbam576yvPCi1V400oXVe0iT5wud2PiI
 3VamFQlJpr3ch9d9BWekfE+B8uv28459uePa4O9FgicAF+yD17eo1gm8vqmHtuOPTY3u
 SnQGqc62y+LSFNlpFFylHX5blOMUgqCl6rGKCznJ91K64ndwHHcv90K0fFEwU2W20Bjk 1Q== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3b2p4f24jx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Sep 2021 16:10:32 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18EGAPxc091874;
        Tue, 14 Sep 2021 16:10:31 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2106.outbound.protection.outlook.com [104.47.58.106])
        by aserp3020.oracle.com with ESMTP id 3b0m96hxdv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Sep 2021 16:10:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aoC8sJ97LAo+LgjRYWsPA7Ry349BZr5NwyXQXkaxSBLqX4sd5SvJfWy0aZvUexmIwp3VN9SF45aurIuswv8oGqNBy87W9JGIWU1tLCkiZ64qdpNXqgwHZo424sAKu1gl8uievlCs/YTv3NypshswrlhkvfuMwbcS0BQr9UmVaaCC0U9hlQCQbIrUgbY5f1pA2vR770CerU7H1PtiHt1SxBXt7mYGvy23VTc5PiMnznwXwCSbMHSXoxtLDXJ8RDd1ALlfrAIjGvlkzXrSMeXt8oE5e+8zRDfJ0tOJucU2x12l3Jg8KRy4BTBwmDK/gfrpRdqqCWiNWqw/4cKLsACEvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=fA/W1TYWg8kmOxY7YN7VHQx3nFqt0a6zPlYmsUCUyMo=;
 b=OcHaCJcaV2dLSVJA6NV4LAI6ALddGf0AlAdFstMEi1M0rdlp3Q0sGXBN7yGW4EPdneFL0DYRHHofrgrtnlXwr+BMFtt2mxcpe+A3Dvlb5b0y60bz9OYUWLQwZ64JKd5U01ioEBMCljMYKLMkpUAwLi0o0X0Q2tLhmILANn441xlcvabPmq2IpUoaze4Z0/6bnEdpuyVncMsIMIHs7tHueXuJfgcwSEAIOzZyAvZjaJXmNINsu1YcB8pygzYxzsKRJ3Wia797jX7JniRxiPJus3h1bn87q6mQKXvEBhCZguzAquh+wP/y5HANO5moZYqNOPvmpcXI4MIfvaCCsuz2zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fA/W1TYWg8kmOxY7YN7VHQx3nFqt0a6zPlYmsUCUyMo=;
 b=bZ1wAu0W+VMe5UGyeacFRiG6xjMsFaimtcK9J3HNsQ3J4pc0En4gxh+sOa9wkmg0VlaEda7LfLLkkTdJbMZCN4gJG6RbaF/ZRw9YvZXy8F9NL15YKzW1nSVK8ZuumKzzCcoj1MlXiIU4xqQ45aQW1/kXdqq3WmmhOolDzPuar4w=
Received: from BYAPR10MB2629.namprd10.prod.outlook.com (2603:10b6:a02:b7::24)
 by BY5PR10MB4226.namprd10.prod.outlook.com (2603:10b6:a03:210::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Tue, 14 Sep
 2021 16:10:09 +0000
Received: from BYAPR10MB2629.namprd10.prod.outlook.com
 ([fe80::4c4:78db:507d:90c3]) by BYAPR10MB2629.namprd10.prod.outlook.com
 ([fe80::4c4:78db:507d:90c3%7]) with mapi id 15.20.4500.019; Tue, 14 Sep 2021
 16:10:09 +0000
From:   Prakash Sangappa <prakash.sangappa@oracle.com>
To:     Peter Oskolkov <posk@google.com>
CC:     Jann Horn <jannh@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-api <linux-api@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Paul Turner <pjt@google.com>,
        Peter Oskolkov <posk@posk.io>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RESEND RFC PATCH 0/3] Provide fast access to thread specific
 data
Thread-Topic: [RESEND RFC PATCH 0/3] Provide fast access to thread specific
 data
Thread-Index: AQHXpQ/fLwtDYf3gz0mKOoI4Vng/XaudZBfggAAPeYCAAAP0AIAALdiAgAAG1oCABJVsAIAABqAAgAFzmwA=
Date:   Tue, 14 Sep 2021 16:10:09 +0000
Message-ID: <BEE6A914-6EB0-4649-9604-572728B04D70@oracle.com>
References: <1631147036-13597-1-git-send-email-prakash.sangappa@oracle.com>
 <CAFTs51VDUPWu=r9d=ThABc-Z6wCwTOC+jKDCq=Jk8Pfid61xyQ@mail.gmail.com>
 <CAPNVh5dsN0LPHg6TJ_MO2XKtpTEe0n4Y6+HjwERJPSrb2J0cbg@mail.gmail.com>
 <3591AC6D-45D2-476A-80B1-46BFA1742602@oracle.com>
 <CAPNVh5fMUQCa37iprcAykgkHzY5Rj8DSiwtZBU6FbnzjOv8ciw@mail.gmail.com>
 <CAG48ez1sPjPYePmXTgtFbaj6_0yY0Z_bGw+apwO_zTV-qwftSA@mail.gmail.com>
 <CAPNVh5fP-QnziX7NpYqKv+0Ha8-prhvTHiCbUB0jx+_P36QUGg@mail.gmail.com>
 <6A88B271-EC5E-46B7-8D60-A7543635FDC5@oracle.com>
 <CAPNVh5fQXB7tLi=tKyabmScZge53PwzQ3kqP2ASE+3DD+eTdGg@mail.gmail.com>
In-Reply-To: <CAPNVh5fQXB7tLi=tKyabmScZge53PwzQ3kqP2ASE+3DD+eTdGg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
authentication-results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3dddada4-390d-4bca-dbbb-08d9779a2022
x-ms-traffictypediagnostic: BY5PR10MB4226:
x-microsoft-antispam-prvs: <BY5PR10MB4226A57534411B2E0CC3B102E4DA9@BY5PR10MB4226.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0GmoaEVuK6QodsAunOoaalhR2CWRidy5FYugfWyfzDY28qTSPlvjGkNFi+m9mkzsuL4PN+TjhAUNQ2OqVtzwjweJTS6W73GRIE5nvANDYvlR66Kj0UwPpZcbs9IzDOA0i8gJsv0ORfXuL2c9WCVQJFQtTdmg5rnYi+qVB/5KjIGYAmfxtF1MH3HbeaGYmRGWW8RlWoZNkJv5KZYuNwi2oiSR0QM62bufq94BaVDe5B9J3P66PiJxWAV8G+lLcLq0OFz6fydpUUprmPPaM+6F69myi2ORmEJxG5kQLs3BbPUJeUU8mx4+aL+vkfDFhN6kS0bCLFPgN8uKz4BGROB7hrMKy9BS7gtvBpJo1FmMzxiu9WGJm17xFDtqBuEgrTvIWqYQS7UgPInJKwC8vBOvg6NYM27+ya3d1OCvpRr3tQU9K6vKhOp/ACygBJLkgH6mBK1ykCjGWFMqCa+i5EHvXjC2CPNag5RR6XxmuqHjCv0hdTXUq8vctn91jI/x1VzleK57aP05oRJEOxXoJS/kxjAswG+XGJBX54m8uvkp7KUcSogXWqL8dDBDpXOHx6zsW2tcI/ZQ3b87It6tZLzUPulRI4FUTrx4y/Wa74PPqvoC+5Cb/mNAI0AKXZ9jdCAqSRGPnhzVmGaCxv1upOc87GVWFl8zyKz294a39vERr+4NyBxtQpzJSbrrJp26acVvEILklm4KfTrOM6ukQ/w3IHJQv64hApUAb5xu9JLT3JGq6NTR2mXidYZ44Ogt8Bj7kM7SUqPls2oCVSgye9/LHPP9h/rZ+gD5qjsqfXpD7lcB8hR3khKYZcJ6RNkIEkTQ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2629.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(346002)(39860400002)(366004)(136003)(376002)(54906003)(8936002)(966005)(33656002)(122000001)(38100700002)(316002)(66476007)(66446008)(66946007)(91956017)(64756008)(66556008)(76116006)(71200400001)(6486002)(478600001)(4326008)(6916009)(86362001)(2616005)(44832011)(38070700005)(186003)(83380400001)(2906002)(6506007)(53546011)(8676002)(5660300002)(36756003)(6512007)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QUk2dVlpYm1FdEJxZ1RqZTFwMjg2RkcxcHV2TnZjbnVYRFN3dU5UN2s1TEwr?=
 =?utf-8?B?SEZiMXN3dWNVQ001ZnUzQVlVTEZRSS9YdU9Ed1pFRjgybk9KMEVZd01GT083?=
 =?utf-8?B?OVNFMzV2RFJoKzJwMk4wZWtnaXhGT2RGWHo0aDFPQ050S3hLZmQvbG5rM0V6?=
 =?utf-8?B?cFBnVnhpVTdHMTBoNVpaZitzdU53VW1iRHpVcUtEWUFxcm9jdXRROEUzK2Fl?=
 =?utf-8?B?OFVVQVlobDlhWmYyN3g2OVhUWDVTbi90NUxxSzRFRTdVVm5ONFZmZmE3SnBk?=
 =?utf-8?B?YUh0K2lYZGFNVi9iTVNiYlZJUlpEcU96UGpjU2xQZjU2Y2xWdVFyVHN4S0dx?=
 =?utf-8?B?T0pMR3lIMnFMdURkVlRPYW15MmpmWXVnL2M0QURWWTUvQjFDcHQ5NGR3ZFI5?=
 =?utf-8?B?MEc3QVlxSFlJYStmR2x1WHhveUVTWVpocGFHQm9UaVhXSEg0aHlpeSswTzRh?=
 =?utf-8?B?MlZMOE0rWndiNzh5S0dqVjRuZ0hicngyZXdrNGljeDR2cDcyK0RJNjRlV3VY?=
 =?utf-8?B?cFI1ZUdiQitpSDZSTjZvcm1XUm05RGVrQzhucFZuYzF6L0xEUm5mQ2N6Qmdw?=
 =?utf-8?B?UkpncEt0YVFIQU5GODJqNzJDa3FldUFKUUkvWDR0ajBGTDdPRlpPb2hNNGY4?=
 =?utf-8?B?akhSdVFmTUJzNzBWNk5XalYySVJNRTdVNGFsU05mL28yUjYySFBrc05Fck5J?=
 =?utf-8?B?WmIzL1h0SVZPU3N0MUhkTVBEK1Z6ZTdrUDM4UlI4RkxRV1VxUEhOcVNscFFO?=
 =?utf-8?B?S1NKNTRUQ0djL2V3ZzVQOHJwR0l2d2JhdHVDUWRsSGs3aklldng4ZGsyUEpr?=
 =?utf-8?B?MlU1YUM3ZnYrY2R3WGlkUjMrSFJLQWVRWHN4OTNOYjRMY043ZmNraHk5Nkg3?=
 =?utf-8?B?MmJFMGtHOG1KVTRBMzZUVVo1K2pqdEVNS0hRR1lJNDhLZjFvYjBSUG9DanVK?=
 =?utf-8?B?TlkwSWVPM2RHT1lkN0RNZ0ZlNFdCZ0wrbDN6eFRBTVVkeEJOZlo2SFM3anJU?=
 =?utf-8?B?clJ6YTJmcmRwTXJnTHJUaHlBMjVHOWRPY3V2NlF2SjFPWnlrODRBQ3YrVThB?=
 =?utf-8?B?QzNZaUI3WFpFdVgxcFM2VHFkNDRuWDRXbU5VVEk5NzR6dXMzZk9WeXhpN0sw?=
 =?utf-8?B?M3A0Y2w5VXFMYnAxZEJTdkNna2ExQit5UGE5dTBacVdUMExyb1djTHVhaCtP?=
 =?utf-8?B?SHdrQTNLaXFJLzVlWURXZ1pBcUdlUzByWUxtaTYrR0w3UmVZcll3TG9ZcnZp?=
 =?utf-8?B?RmhiUzNjUEJaRks0ODBZalpSTHA2VGgwdmFKN25hcFpwMzJWZkFmR2ljeXpH?=
 =?utf-8?B?TGNFVzJ1WmpiME15Y1VHNjJkUDNrN2NUdS9PL2VWMjBaY3FLUkZpZk1KbSs5?=
 =?utf-8?B?YVlHR1BXeFRFNmEyMzdiMjl6VEZpY3l2cFZuREUvR0pOUktrWXNFb0E3OWhv?=
 =?utf-8?B?RkVPbEg1YmJKajVGd1dSN2h6dlllSXF5L3NXYmphQXBCblNsN0FJTUorTXEy?=
 =?utf-8?B?WEpSZ1pleWQ4TVVQd1BRK1gxeXZqOFRqc2NhS3dXSzR5Wnk5N2llMFY4MHlK?=
 =?utf-8?B?QVVzMFo2b0c2TmZZQ3RmY05OTHQ3cms0azV0b3JuaEJ1d3dUWVpveVY0OE1s?=
 =?utf-8?B?V1p1VEJkVlpPUmlKSFdXdGNBNzNGL1JiODZtYjBMU2EyRTRPd3BOeXNFMitN?=
 =?utf-8?B?bUVoU2MzOHlEYUJoMjJFVGNZdVN2ZmYvQlo3R1k5aVFPd05pR21ORTlSRWJK?=
 =?utf-8?B?WVk2ODJkOVh0V2JZSW9DNmQrSXM1SzBFTXNUMi8vZytJUkxacUNJRm1ZdStn?=
 =?utf-8?Q?UM5TYpHtHZqh/jZ4ob1+ZaCoVc0gHmOUh2bzg=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <0D64293AC2A1FF449AB2EDECD8315CBD@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2629.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dddada4-390d-4bca-dbbb-08d9779a2022
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2021 16:10:09.3182
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RaQtn3KCglChbWV53/X2WNzlI/0ixGlSB3nGEdGhzH6TGqmQbm+G/MwFMV1m9S5mPPHq2LyGuNZJI3UWlfBb1wsOA/5MRzzmBHonyIHpDgs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4226
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10106 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 malwarescore=0
 adultscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109030001
 definitions=main-2109140096
X-Proofpoint-GUID: MFgz2yVKkKBwwH260Uodu7zCFSjcEJW3
X-Proofpoint-ORIG-GUID: MFgz2yVKkKBwwH260Uodu7zCFSjcEJW3
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

DQoNCj4gT24gU2VwIDEzLCAyMDIxLCBhdCAxMTowMCBBTSwgUGV0ZXIgT3Nrb2xrb3YgPHBvc2tA
Z29vZ2xlLmNvbT4gd3JvdGU6DQo+IA0KPiBPbiBNb24sIFNlcCAxMywgMjAyMSBhdCAxMDozNiBB
TSBQcmFrYXNoIFNhbmdhcHBhDQo+IDxwcmFrYXNoLnNhbmdhcHBhQG9yYWNsZS5jb20+IHdyb3Rl
Og0KPiANCj4gWy4uLl0NCj4gDQo+Pj4gVGhpcyBzb3VuZHMsIGFnYWluLCBhcyBpZiB0aGUga2Vy
bmVsIHNob3VsZCBiZSBhd2FyZSBvZiB0aGUga2luZCBvZg0KPj4+IGl0ZW1zIGJlaW5nIGFsbG9j
YXRlZDsgaGF2aW5nIGEgbW9yZSBnZW5lcmljIG1lY2hhbmlzbSBvZiBhbGxvY2F0aW5nDQo+Pj4g
cGlubmVkIG1lbW9yeSBmb3IgdGhlIHVzZXJzcGFjZSB0byB1c2UgYXQgaXRzIGRpc2NyZXRpb24g
d291bGQgYmUgbW9yZQ0KPj4+IGdlbmVyYWxseSB1c2VmdWwsIEkgdGhpbmsuIEJ1dCBob3cgdGhl
biB0aGUga2VybmVsL3N5c3RlbSBzaG91bGQgYmUNCj4+PiBwcm90ZWN0ZWQgZnJvbSBhIGJ1Z2d5
IG9yIG1hbGljaW91cyBwcm9jZXNzIHRyeWluZyB0byBncmFiIHRvbyBtdWNoPw0KPj4+IA0KPj4+
IE9uZSBvcHRpb24gd291bGQgYmUgdG8gaGF2ZSBhIGdlbmVyaWMgaW4ta2VybmVsIG1lY2hhbmlz
bSBmb3IgdGhpcywNCj4+PiBidXQgZXhwb3NlIGl0IHRvIHRoZSB1c2Vyc3BhY2UgdmlhIGRvbWFp
bi1zcGVjaWZpYyBzeXNjYWxscyB0aGF0IGRvDQo+Pj4gdGhlIGFjY291bnRpbmcgeW91IGhpbnQg
YXQuIFRoaXMgc291bmRzIGEgYml0IGxpa2UgYW4gb3Zlci1lbmdpbmVlcmVkDQo+Pj4gc29sdXRp
b24sIHRob3VnaOKApg0KPj4gDQo+PiANCj4+IFdoYXQgd2lsbCB0aGlzIHBpbm5lZCBtZW1vcnkg
YmUgdXNlZCBmb3IgaW4geW91ciB1c2UgY2FzZSwNCj4+IGNhbiB5b3UgZXhwbGFpbj8NCj4gDQo+
IEZvciB1c2Vyc3BhY2Ugc2NoZWR1bGluZywgdG8gc2hhcmUgdGhyZWFkL3Rhc2sgc3RhdGUgaW5m
b3JtYXRpb24NCj4gYmV0d2VlbiB0aGUga2VybmVsIGFuZCB0aGUgdXNlcnNwYWNlLiBUaGlzIG1l
bW9yeSB3aWxsIGJlIGFsbG9jYXRlZA0KPiBwZXIgdGFzay90aHJlYWQ7IGJvdGggdGhlIGtlcm5l
bCBhbmQgdGhlIHVzZXJzcGFjZSB3aWxsIHdyaXRlIHRvIHRoZQ0KPiBzaGFyZWQgbWVtb3J5LCBh
bmQgdGhlc2UgcmVhZHMvd3JpdGVzIHdpbGwgaGFwcGVuIG5vdCBvbmx5IGluIHRoZQ0KPiBtZW1v
cnkgcmVnaW9ucyBiZWxvbmdpbmcgdG8gdGhlICJjdXJyZW50IiB0YXNrL3RocmVhZCwgYnV0IGFs
c28gdG8NCj4gcmVtb3RlIHRhc2tzL3RocmVhZHMuDQo+IA0KPiBTb21ld2hhdCBkZXRhaWxlZCBk
b2MvcnN0IGlzIGhlcmU6DQo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xrbWwvMjAyMTA5MDgx
ODQ5MDUuMTYzNzg3LTUtcG9za0Bnb29nbGUuY29tLw0KDQooUmVzZW5kaW5nIHJlcGx5KQ0KDQpG
cm9tIHdoYXQgSSBjb3VsZCBnbGVhbiBmcm9tIHRoZSBsaW5rIGFib3ZlLCBsb29rcyBsaWtlIHlv
dSB3aWxsIG5lZWQgdGhlIA0KZW50aXJlICdzdHJ1Y3QgdW1jZ190YXNr4oCZKHdoaWNoIGlzIDI0
IGJ5dGVzIGluIHNpemUpIGluIHRoZSBwZXIgdGhyZWFkIHNoYXJlZA0KbWFwcGVkIHNwYWNlKHBp
bm5lZCBtZW1vcnk/KSBBY2Nlc3NlZC91cGRhdGVkIGJvdGggaW4gIHVzZXIgc3BhY2UgDQphbmQg
a2VybmVsLiBBcHBlYXJzIHRoZSBzdGF0ZSB0cmFuc2l0aW9ucyBoZXJlIGFyZSBzcGVjaWZpYyB0
byB1bWNnLiAgU28sIA0KbWF5IG5vdCBiZSB1c2FibGUgaW4gb3RoZXIgdXNlIGNhc2VzIHRoYXQg
YXJlIGludGVyZXN0ZWQgaW4ganVzdCBjaGVja2luZyANCmlmIGEgdGhyZWFkIGlzIGV4ZWN1dGlu
ZyBvbiBjcHUgb3IgYmxvY2tlZC4NCg0KV2UgaGF2ZSBhIHJlcXVpcmVtZW50IHRvIHNoYXJlIHRo
cmVhZCBzdGF0ZSBhcyB3ZWxsKG9uIG9yIG9mZiBjcHUpIGluIHRoZSANCnNoYXJlZCBzdHJ1Y3R1
cmUsIHdoaWNoIGFsc28gd2lsbCBiZSBhY2Nlc3NlZCBieSBvdGhlciB0aHJlYWRzIGluIHRoZSB1
c2VyIA0Kc3BhY2UuIEtlcm5lbCB1cGRhdGVzIHRoZSBzdGF0ZSB3aGVuIHRoZSB0aHJlYWQgYmxv
Y2tzIG9yIHJlc3VtZXMgZXhlY3V0aW9uLg0KTmVlZCB0byBzZWUgaWYgbWF5IGJlIHRoZSB0YXNr
IHN0YXRlIHlvdSBoYXZlIGNvdWxkIGJlIHJlcHVycG9zZWQgd2hlbiANCm5vdCB1c2VkIGJ5IHVt
Y2cgdGhyZWFkcy4NCg0KUmVnYXJkaW5nIHVzZSBvZiBwaW5uZWQgbWVtb3J5LCBpdCBpcyBub3Qg
YXJiaXRyYXJ5IGFtb3VudCBwZXIgdGhyZWFkIHRoZW4NCnJpZ2h0PyBCYXNpY2FsbHkgeW91IG5l
ZWQgMjQgYnl0ZXMgcGVyIHRocmVhZC4gVGhlIHByb3Bvc2VkIHRhc2tfZ2V0c2hhcmVkKCkgDQph
bGxvY2F0ZXMgcGlubmVkIG1lbW9yeSBwYWdlcyB0byBhY2NvbW1vZGF0ZSAgcmVxdWVzdHMgZnJv
bSBhcyBtYW55IA0KdGhyZWFkcyBpbiBhIHByb2Nlc3MgdGhhdCBuZWVkIHRvIHVzZSB0aGUgc2hh
cmVkIHN0cnVjdHVyZQ0KKHBhZGRlZCB0byAxMjggYnl0ZXMpLiBUaGUgIGFtb3VudCBvZiBtZW1v
cnkvcGFnZXMgY29uc3VtZWQgd2lsbCBiZQ0KYm91bmQgYnkgdGhlIG51bWJlciB0aHJlYWRzIGEg
cHJvY2VzcyBjYW4gY3JlYXRlLiBBcyBJIG1lbnRpb25lZCBpbiB0aGUNCmNvdmVyIGxldHRlciBt
dWx0aXBsZSBzaGFyZWQgc3RydWN0dXJlcyBhcmUgZml0L2FsbG9jYXRlZCBmcm9tIGEgcGFnZS4=

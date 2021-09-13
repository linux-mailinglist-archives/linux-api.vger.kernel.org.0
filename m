Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92CD0409ABA
	for <lists+linux-api@lfdr.de>; Mon, 13 Sep 2021 19:36:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243058AbhIMRhz (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 13 Sep 2021 13:37:55 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:2756 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238180AbhIMRhy (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 13 Sep 2021 13:37:54 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18DFuvFP029754;
        Mon, 13 Sep 2021 17:36:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=9bEUNbHq1eC3xRhF4/sRWNsV4bqeA8BD13dzBIdtlTE=;
 b=wtRJQkkXQqV5fH9CQUhabIDi5PPW549bfyaahUx4xHN4rdeLAFj9sEfjH0nYP1r+CBym
 2yAgdh4xawQHsygoYa3kWPKGWPgrLH1WdeZgR/ZLUPT3zuHMp2d3j5u1XIr7HDbmG6hU
 IVK7EA79VyfnAsLOBIoF+I/H7KJ2tWRxpgorvOyHGeiaIt53IPLiwq6pcN9W0NxbyEF/
 HrdioagGIZON80Se/w3cjbzC1PK9LV51S9Y8UAene7OIunxJYGl5k6VzRuDfrzUFZT2n
 Nq/ReoZijkr+h2jjnthog3dILV7A5ldsS5razqD4+GqSgJxXflpdJS7i1X+2HT3BW9Jm qQ== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=9bEUNbHq1eC3xRhF4/sRWNsV4bqeA8BD13dzBIdtlTE=;
 b=p71Rxdvt+IHeAv45oXbzFyz5A8pAOkDFyZPrSVW4/ytmxSUi5WnUlSZK88Dv7cD+ZQ/M
 rS7ZRaYtqgoq0hkepX65EsgNW1HP0HRf8N8/ioLKHcGws+UI0S2QZtNSanvkxzImi+XO
 xHl2vUjcFUecKsq0QunqfkyshmkOth7gLG+zgGIRlXpy5zDtTDSOXJ8yf3Dtew0UEcDL
 sXhP7TCLBiXhRyn2PpYrYCzgWK2zlomkcpmPSi3i8onOh0P8pnjjPZBddvrB8bqd1yWe
 AP78/2q2m7h6V9SF3J0mXeYb3j3Yi4wFEWz0lUo5S5KwpOz+bfN4Ra2AIVYkGIaUJKtt aQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3b1jkjbm2f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Sep 2021 17:36:28 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18DHLOPk117752;
        Mon, 13 Sep 2021 17:36:27 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
        by userp3030.oracle.com with ESMTP id 3b0hjttmy2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Sep 2021 17:36:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dOD+IhXea9PylzPS1ZX08+i/0sNI2PIednEVqKA4bAi4iPo6xS+hntwh/A/r8NoQ+HkUN6ILi3vIRQPirJUFfQC0t/AchaaPCVZnmya6mtNioWoRJlJMbyyxt8avwF4uX48vqxtlqPqLosaQjKFfG8WXKNY3V9pDOwYlA+l+RzE6XwWY9g9W6ig693gdOfT6ke8PKUUty5DAqOy15cbcMxtDDyqSlySifIC+a7mpZpcHNjhTusdTqI4nO0kzJITRKmRU4udeerQs6aJFJGtC+UIumj/umbkhVs4Q5SU66DcNszTTJqIpPlV/oxufis9i03MV/Xa2QYfkAfewphKGEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=9bEUNbHq1eC3xRhF4/sRWNsV4bqeA8BD13dzBIdtlTE=;
 b=Ftl3SOyZynPV6o2mDpyEbAhWT2xBJCGDaXwQ8n2cy2e6WNWu9yuhT331XhqhWsLXgwzdz7si852ykM83HfMNIvKYyqRnc+OeoohBaKu74QFL8eoDElEBqsB1AZ0GJ5dQaq4qfKkLJEmrFj/GeW9EkZPBAPtU2kgmHuMZFDe1XRKB2vvsQtLOQ728VRkSTfwUa9iLEJCd/s3L2No9EkvCAuPeCuQzk7JBCaWoeOBb9CAV5gP3JYEv2GZAnB407VOeWuDG0YXWX5PIWT49E8wrT6jsexVp4/XGvR/Qyn+nRGOecHK/dEPtlJuRP0oO0gr6S6kNty533sOdzvTi01vGKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9bEUNbHq1eC3xRhF4/sRWNsV4bqeA8BD13dzBIdtlTE=;
 b=X7/kbPU1XGj1SbmzCMH+9RGJmx/qBNp8s0Nj85RHI6pY41qNYI6FmJh1fCCHVbbuK07G6bGSe8vyKBKQ7UAmgr7WHuVDA9ZFt7njUb8kQfovJcSJyZSVCtL/pNeilwLfaLWZBpNtuF8CF+tShyu7X2wJyMLqG3jowTlSgDn12Mw=
Received: from BYAPR10MB2629.namprd10.prod.outlook.com (2603:10b6:a02:b7::24)
 by BYAPR10MB2885.namprd10.prod.outlook.com (2603:10b6:a03:82::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.15; Mon, 13 Sep
 2021 17:36:24 +0000
Received: from BYAPR10MB2629.namprd10.prod.outlook.com
 ([fe80::4c4:78db:507d:90c3]) by BYAPR10MB2629.namprd10.prod.outlook.com
 ([fe80::4c4:78db:507d:90c3%7]) with mapi id 15.20.4500.019; Mon, 13 Sep 2021
 17:36:24 +0000
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
Thread-Index: AQHXpQ/fLwtDYf3gz0mKOoI4Vng/XaudZBfggAAPeYCAAAP0AIAALdiAgAAG1oCABJVsAA==
Date:   Mon, 13 Sep 2021 17:36:24 +0000
Message-ID: <6A88B271-EC5E-46B7-8D60-A7543635FDC5@oracle.com>
References: <1631147036-13597-1-git-send-email-prakash.sangappa@oracle.com>
 <CAFTs51VDUPWu=r9d=ThABc-Z6wCwTOC+jKDCq=Jk8Pfid61xyQ@mail.gmail.com>
 <CAPNVh5dsN0LPHg6TJ_MO2XKtpTEe0n4Y6+HjwERJPSrb2J0cbg@mail.gmail.com>
 <3591AC6D-45D2-476A-80B1-46BFA1742602@oracle.com>
 <CAPNVh5fMUQCa37iprcAykgkHzY5Rj8DSiwtZBU6FbnzjOv8ciw@mail.gmail.com>
 <CAG48ez1sPjPYePmXTgtFbaj6_0yY0Z_bGw+apwO_zTV-qwftSA@mail.gmail.com>
 <CAPNVh5fP-QnziX7NpYqKv+0Ha8-prhvTHiCbUB0jx+_P36QUGg@mail.gmail.com>
In-Reply-To: <CAPNVh5fP-QnziX7NpYqKv+0Ha8-prhvTHiCbUB0jx+_P36QUGg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
authentication-results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2cfbef41-8553-4cf6-6f56-08d976dd024a
x-ms-traffictypediagnostic: BYAPR10MB2885:
x-microsoft-antispam-prvs: <BYAPR10MB288514A135D31AE28FD90F24E4D99@BYAPR10MB2885.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UyT/RXZyrIOvy28N5cpzkPZu29d32/sKqp0lmhZzz531oVnGEQP45CdZy0k3TITqhWRwJrjLw2a/Y1UHIrbbSI/EhrEY5AP//HjfZhx2xzTXfki3WvYnPxDMSaZJSm3KQxIlhNQ6k0Dhleq+K98TIGhjC/Dy4EzeBPb/zpZmZEK806FKdAJVZ0G/R2usddC9sAv/oDv1uFlJpeeF0o12cSTdpas1pneJ0IbIEQ4EoSxWglFYwUq1bcbqfEFvi9ZrL9MmLhkT9VvdSmNgvvIF+ui+bNPtFu82c16+GLfkBOfw1BtEANh0kGpd7SrnwRNLFWg+jwSBoE2KbqM8FrvytrKJbRIsMnXlVtGzI8CRKx9/YrbDfEoBZCxW/OeYPkLteRBJIg00PO2iwS/XZZ8yB7mI6JBTKvRh1Fz6cjKT1I3uJrwvluQRnCMdLr8tr87s0+Qr/BWgY6Zx7jVPzKy7P2Wzlbs0gcflEVoS1GFxLTjw8YLkTeq7hAg0ukfET8PhC3vSM4+OizbTuIj8g8PteWZ0oC4v0nYVTob9ThuDl94svDrywcWyyGmpyRI4JwDAN2dE27/FhHeFauQCKCCPBJqQhTmrE/ch9OvlbsyXedAGjMj4Q5BK61PtrZxPTsK2flNUJ2X+eLRVQZaVHASZ8SAcjpjBJF/9Dn+xMtuFkFrv3faYRRyp+1KUq+dl9mjjDBwtMY5oZMTiSXItHlf9NLZqtmnMaUAWVsQ+WW7F97k5nf/ioVoI1sWBXwAWJhO1
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2629.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(396003)(136003)(39860400002)(366004)(6486002)(4326008)(54906003)(6512007)(26005)(66446008)(64756008)(66946007)(38070700005)(76116006)(38100700002)(33656002)(8676002)(316002)(66556008)(66476007)(122000001)(6916009)(2906002)(71200400001)(36756003)(2616005)(86362001)(83380400001)(6506007)(5660300002)(44832011)(8936002)(53546011)(186003)(478600001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UUlxQzk3Y0tJeEhqb1VyR3F0QW5qRUxpbytiTTVBK1piajJnbHVCWGZhV3F1?=
 =?utf-8?B?NjBUbGt2UGNoNElVais3Mk5aY2hPMTBUdnNTa0x6ZWswenMyTnZzem5WTXI1?=
 =?utf-8?B?WTh5bXRwZG03cjM2aDhzVm9JOThwYlFiNXpDNWdZYjUwZjBwTFFRMmVrSVFs?=
 =?utf-8?B?R1VjZ3BlZU41YStCQ3k5UUFYT2R1d2pzaXZVRDdpSU1NcGhWdk5pUWJlQng1?=
 =?utf-8?B?YVV1ZDAyVi84dlVSekRwWHo4eU5BOFg4TUVzSU02bUUzOXFvQ0hndEc1QlRq?=
 =?utf-8?B?clNwLzJCS1BKamZBOW0yTEJiOXB4Y3NZM0hCZGk1NUdRdVE2QnJ5R2JpS09V?=
 =?utf-8?B?L044bnRsMmE5a1ZsckJIQmpDYzVaRzJ5VTFBZlhSYWJIcHdFeG1iR1AyLzNv?=
 =?utf-8?B?WUtYemRneVNMbUdDMzVjUFF4VEE3VHM0QTRoTmRqODhMa08zaWZ2ZFMrTFFR?=
 =?utf-8?B?elNaaVpvb3FqREc4RUhjVVJkU0FjZkdQTi85a3pMUmk3Tnc4bi83WDBCVjZq?=
 =?utf-8?B?WVBBRGJYeXJITFBEelA0U2dBZ3M3ZmdMS0pYUytDbXpVOGF2MHB3RStZOVRZ?=
 =?utf-8?B?ZjNaUmlrQWVNamkyRWNHNkZSc3Nla1BBaFVsU3E2a0EvQjk3a3NSVjQ0RlJx?=
 =?utf-8?B?REhYanRUdzFwdmtTRlVwUWRzOUxBNXZDV3Z0YUxxK3ZlVGZud3VpUHJhdlJ4?=
 =?utf-8?B?dFhNMGtvMzdtS2xtMzRobzVNZHc3ZTZYeFU4SFprTC8raDVXWGpaQlZmRHZI?=
 =?utf-8?B?OFpKQndoTnlMdzFWeW92VUNHU3QvSUlBRWxtQ3BsNnpmRm5LcWJRUi9SbWp3?=
 =?utf-8?B?K28yc1NsdDI3WURMZWNvUFM1VkZxSDc1TlJQZ1NIbUVrSXFDSU10V1pOcTR5?=
 =?utf-8?B?UXJGWldmdWRWUzZidFZEZUcrK3MrOXMwWGFieFp2bDZxOWNmbHhTZWdCN3ZL?=
 =?utf-8?B?UlM2aitxTEZnNjkzVkhxYy9tN3VYU0hOZENUdzFRSkhFQm5KZlBOZWxyU1Bp?=
 =?utf-8?B?ZVR6VjR1d0Z4dGtralFLRUQ1djIrUXBvZll6Nzh5SjM2VUxJU2pQQnFIbGEw?=
 =?utf-8?B?SmEzYnQ2U1ZKS0dhWEdIeDdkTTZoallCM2JOMGN4bzRLekNzY2VIb1k0MDVZ?=
 =?utf-8?B?ci9nTjFSZ2J6cUZPTTdxQ1JxYzJwK2FnQXFGWVRYNzJoc09OVHpJQmNVQVNM?=
 =?utf-8?B?cjIzL29Na2pEdmREOWttTVJXQkM3ajZuS3NQZkRjeng5T1JLTnA0VUJpb2Fq?=
 =?utf-8?B?bjdIN25zOHJwM1FlL3RUbm04TFY5cFVUUUovRkF4bHlBdlNPWHB0Q0x3cXha?=
 =?utf-8?B?NW13cTBRaFlIQjNDbDYzTFpDQ0xtSksvUXFxeFZuSnJWYkpGelJUUWNXMXpt?=
 =?utf-8?B?dVlsbUFkTEZhM1R6c1hvcGV4WUx2YklSVW1CL2JQamNWa0VRN1gvbGd4ODQz?=
 =?utf-8?B?UUVLSGh1eGdGRHFuYXlqc1U2YkFHb0hqR1JPV3crM2swQUR4UU9iKzZmenNu?=
 =?utf-8?B?ZDRNZmpSOUYvNEhCK1QzU254eHpDWE5vY0U1Z1NSUXdpWHFKQzJsVXBLV0x5?=
 =?utf-8?B?OHltUXVnRmVnWTRtQlMyVVlJRVNVcklST294ZkVtREY3SGRJVmJUbHZTdXpY?=
 =?utf-8?B?ZVZEeDJ3L1hudVovb3VDKysyTnVtbE5qOWwwdXlLTE43RUQwRzUzNDNtU24r?=
 =?utf-8?B?VXdyamdwTUc0ZTRXek84SEFPRXF2aWdVTGF4K2tnUDZydC9TODMya0FSTGlZ?=
 =?utf-8?Q?D1nmDHGYCJ7m8tzE2nEdb/WDFi14u4KX5k9RVbZ?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <A12BA5376DF6814D8DE7F1EE925B9950@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2629.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cfbef41-8553-4cf6-6f56-08d976dd024a
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Sep 2021 17:36:24.7048
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z02r7lR9lwxPaSqmhKYENSpBrmM5R/PFBkfS+cLFbW4g7RptyRtL7i/BhwN3rG62yy+LflQ2bPGvjHYidFSgPQ86i1vlPNKa9XCbBj7TtmQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2885
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10106 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 phishscore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109030001
 definitions=main-2109130111
X-Proofpoint-GUID: rYzOe5UDc-XP-yZMT4_GGxKR17mw6OvJ
X-Proofpoint-ORIG-GUID: rYzOe5UDc-XP-yZMT4_GGxKR17mw6OvJ
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

DQoNCj4gT24gU2VwIDEwLCAyMDIxLCBhdCAxMjozNiBQTSwgUGV0ZXIgT3Nrb2xrb3YgPHBvc2tA
Z29vZ2xlLmNvbT4gd3JvdGU6DQo+IA0KPiBPbiBGcmksIFNlcCAxMCwgMjAyMSBhdCAxMjoxMiBQ
TSBKYW5uIEhvcm4gPGphbm5oQGdvb2dsZS5jb20+IHdyb3RlOg0KPj4gDQo+PiBPbiBGcmksIFNl
cCAxMCwgMjAyMSBhdCA2OjI4IFBNIFBldGVyIE9za29sa292IDxwb3NrQGdvb2dsZS5jb20+IHdy
b3RlOg0KPj4+IE9uIEZyaSwgU2VwIDEwLCAyMDIxIGF0IDk6MTMgQU0gUHJha2FzaCBTYW5nYXBw
YQ0KPj4+IDxwcmFrYXNoLnNhbmdhcHBhQG9yYWNsZS5jb20+IHdyb3RlOg0KPj4+Pj4gRG8geW91
IHRoaW5rIHlvdXIgc3lzX3Rhc2tfZ2V0c2hhcmVkIGNhbiBiZSB0d2Vha2VkIHRvIHJldHVybiBh
bg0KPj4+Pj4gYXJiaXRyYXJpbHktc2l6ZWQgYmxvY2sgb2YgbWVtb3J5IChzdWJqZWN0IHRvIG92
ZXJhbGwgY29uc3RyYWludHMpDQo+Pj4+PiByYXRoZXIgdGhhbiBhIGZpeGVkIG51bWJlciBvZiAi
b3B0aW9ucyI/DQo+Pj4+IA0KPj4+PiBJIHN1cHBvc2UgaXQgY291bGQuIEhvdyBiaWcgb2YgYSBz
aXplPyBXZSBkb27igJl0IHdhbnQgdG8gaG9sZCBvbiB0bw0KPj4+PiBhcmJpdHJhcmlseSBsYXJn
ZSAgYW1vdW50IG9mIHBpbm5lZCBtZW1vcnkuIFRoZSBwcmVmZXJlbmNlIHdvdWxkDQo+Pj4+IGJl
IGZvciB0aGUga2VybmVsIHRvIGRlY2lkZSB3aGF0IGlzIGdvaW5nIHRvIGJlIHNoYXJlZCBiYXNl
ZCBvbg0KPj4+PiB3aGF0IGZ1bmN0aW9uYWxpdHkvZGF0YSBzaGFyaW5nIGlzIHN1cHBvcnRlZC4g
SW4gdGhhdCBzZW5zZSB0aGUgc2l6ZQ0KPj4+PiBpcyBwcmUgZGVmaW5lZCBub3Qgc29tZXRoaW5n
IHRoZSB1c2Vyc3BhY2UvYXBwbGljYXRpb24gY2FuIGFzay4NCj4+PiANCj4+PiBUaGVyZSBjb3Vs
ZCBiZSBhIHN5c2N0bCBvciBzb21lIG90aGVyIG1lY2hhbmlzbSB0aGF0IGxpbWl0cyB0aGUgYW1v
dW50DQo+Pj4gb2YgbWVtb3J5IHBpbm5lZCBwZXIgbW0gKG9yIHBlciB0YXNrKS4gSGF2aW5nICJv
cHRpb25zIiBoYXJkY29kZWQgZm9yDQo+Pj4gc3VjaCBhIGdlbmVyYWxseSB1c2VmdWwgZmVhdHVy
ZSBzZWVtcyBsaW1pdGluZy4uLg0KPj4gDQo+PiBUaGF0IHNlZW1zIGxpa2UgaXQnbGwganVzdCBj
cmVhdGUgdHJvdWJsZSBhIGZldyB5ZWFycyBkb3duIHRoZSBsaW5lDQo+PiB3aGVuIHRoZSBhcmJp
dHJhcmlseS1jaG9zZW4gbGltaXQgdGhhdCBub2JvZHkgaXMgbW9uaXRvcmluZyBibG93cyB1cA0K
Pj4gaW4gc29tZW9uZSdzIHByb2R1Y3Rpb24gZW52aXJvbm1lbnQuDQo+PiANCj4+IElmIHRoaXMg
YXJlYSBpcyB1c2VkIGZvciBzcGVjaWZpYyBwZXItdGhyZWFkIGl0ZW1zLCB0aGVuIHRoZSBrZXJu
ZWwNCj4+IHNob3VsZCBiZSBhYmxlIHRvIGVuZm9yY2UgdGhhdCB5b3Ugb25seSBhbGxvY2F0ZSBh
cyBtdWNoIHNwYWNlIGFzIGlzDQo+PiBuZWVkZWQgZm9yIGFsbCB0aHJlYWRzIG9mIHRoZSBwcm9j
ZXNzIChiYXNlZCBvbiB0aGUgbWF4aW11bSBudW1iZXINCj4+IHRoYXQgaGF2ZSBldmVyIGJlZW4g
cnVubmluZyBpbiBwYXJhbGxlbCBpbiB0aGUgcHJvY2VzcyksIHJpZ2h0PyBXaGljaA0KPj4gd291
bGQgcHJvYmFibHkgd29yayBiZXN0IGlmIHRoZSBrZXJuZWwgbWFuYWdlZCB0aG9zZSBhbGxvY2F0
aW9ucy4NCj4gDQo+IFRoaXMgc291bmRzLCBhZ2FpbiwgYXMgaWYgdGhlIGtlcm5lbCBzaG91bGQg
YmUgYXdhcmUgb2YgdGhlIGtpbmQgb2YNCj4gaXRlbXMgYmVpbmcgYWxsb2NhdGVkOyBoYXZpbmcg
YSBtb3JlIGdlbmVyaWMgbWVjaGFuaXNtIG9mIGFsbG9jYXRpbmcNCj4gcGlubmVkIG1lbW9yeSBm
b3IgdGhlIHVzZXJzcGFjZSB0byB1c2UgYXQgaXRzIGRpc2NyZXRpb24gd291bGQgYmUgbW9yZQ0K
PiBnZW5lcmFsbHkgdXNlZnVsLCBJIHRoaW5rLiBCdXQgaG93IHRoZW4gdGhlIGtlcm5lbC9zeXN0
ZW0gc2hvdWxkIGJlDQo+IHByb3RlY3RlZCBmcm9tIGEgYnVnZ3kgb3IgbWFsaWNpb3VzIHByb2Nl
c3MgdHJ5aW5nIHRvIGdyYWIgdG9vIG11Y2g/DQo+IA0KPiBPbmUgb3B0aW9uIHdvdWxkIGJlIHRv
IGhhdmUgYSBnZW5lcmljIGluLWtlcm5lbCBtZWNoYW5pc20gZm9yIHRoaXMsDQo+IGJ1dCBleHBv
c2UgaXQgdG8gdGhlIHVzZXJzcGFjZSB2aWEgZG9tYWluLXNwZWNpZmljIHN5c2NhbGxzIHRoYXQg
ZG8NCj4gdGhlIGFjY291bnRpbmcgeW91IGhpbnQgYXQuIFRoaXMgc291bmRzIGEgYml0IGxpa2Ug
YW4gb3Zlci1lbmdpbmVlcmVkDQo+IHNvbHV0aW9uLCB0aG91Z2jigKYNCg0KDQpXaGF0IHdpbGwg
dGhpcyBwaW5uZWQgbWVtb3J5IGJlIHVzZWQgZm9yIGluIHlvdXIgdXNlIGNhc2UsDQpjYW4geW91
IGV4cGxhaW4/DQoNCg==

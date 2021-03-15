Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F38CF33AAA8
	for <lists+linux-api@lfdr.de>; Mon, 15 Mar 2021 06:12:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbhCOFLj (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 15 Mar 2021 01:11:39 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:5844 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229529AbhCOFLE (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 15 Mar 2021 01:11:04 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12F4wuMN029247;
        Sun, 14 Mar 2021 22:10:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=mPC5FamLe0WYFusNdk1eYPkcjhbr9F/0xlMzm3C2raQ=;
 b=SRtxpdESbOn0CSa1j4XvncVWSpjNgNb5RjNB39ePluKT7L8OnKrJJHh499yxi9swyFVT
 1ZrrcNYkqsiU/DtgpXvZWfb+Ezb8gbUdv1ffICn5EDZBzuelbcfbtdpyrMvtHegLvIXi
 olX5cZwhwCBh12kE+KNOPxYwdfl6AVFrb2BxzQOzgw+tv7QKBvOlF9tjNXJ2dQt8rTQp
 EOfMSZjkt0hc7mzFJ7598Ff+ZItuWD+sou3T0EbWLfO+/dG065Z6dlpt/MMQpwIYA7oA
 fOWIWS6O435cq4ag1cnrEobOC9WGRm/cOKp8apYOPFFFBhWrVjV+PZd+dUTuRUtPbSe7 9Q== 
Received: from nam02-cy1-obe.outbound.protection.outlook.com (mail-cys01nam02lp2053.outbound.protection.outlook.com [104.47.37.53])
        by mx0b-0014ca01.pphosted.com with ESMTP id 378sv2csqc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 14 Mar 2021 22:10:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l7F/mvOyo5ho5WDsxMghnK1B0HPSqIdNJg1D7JZew+x8dNTC3ti5vpkrJvogK3PTTFHKae6ZXvJCaHyhTUeXTAKBgYFBoT1ETf650LBdPzSiJvL0MNSdS1dyxk1XiZ6rXrrzYYZK+dM9H+Ge/ZvoufnZRcWBTgUXXW8sqenOOJLdEnvL6QwYazTeVRhqZMpkSzIMLMlvPSpDyBF64zwxNHFLpSVIXaN387E0YT5z69YTq/XyQRI0KFjks6/yiRMSpgxNvR3+62n7CTvKu9uStW1pcqOiqh4jIYFLdnPMLLNHYJOXC88OrcaeFOk3TXRPS3xJXEWGwyBYERGqMc1Xtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mPC5FamLe0WYFusNdk1eYPkcjhbr9F/0xlMzm3C2raQ=;
 b=mej0XOMtuWdEZwiBrcbXIIt8Fvij33Z8seTW/AuGQJ7RJhQGu8M6quP8YM63QJ9Z8NKja51adR80oQqX5XBLpkYGwgqo5FdDLpKg6+SRlJtuvYDcpjvEhGLoFf+ZdXXTRmeFfRnu7yxQmHBELTMaMFwcAtEmkZny8hyncjI6HS2YgDMPEov3Xw40BxFUYQoxn35ux1qRyWMhaYfVD75ZgMaHB+0myHnex4/r/IX9pT6CRKmnuyrmBn5K8AkjRfSN5WMg3cqUuXakk7s1mwizuSZRd4DP7/GVhCJ5EdnzhmRd/DJPKXZmKbdeYh0+qHcyE2TqGpcOrtJs7K9lHoqBdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mPC5FamLe0WYFusNdk1eYPkcjhbr9F/0xlMzm3C2raQ=;
 b=2pM8TjWN6R4T2wnCyDhlaPzu0VyleIP1m1RQlKsfZ3FtvkRJEXluFaJnuPItl4NxCNToftdESeczn7SHO6yc66EPPdAt/3CY59qiKEaF2bokFfbn37jjzw3/MczyLJA8H8oSllPeUszucHMVz/Wwd7TO3c2L7D4DLoepDjvyTQs=
Received: from BYAPR07MB5381.namprd07.prod.outlook.com (2603:10b6:a03:6d::24)
 by BYAPR07MB5384.namprd07.prod.outlook.com (2603:10b6:a03:6f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Mon, 15 Mar
 2021 05:10:54 +0000
Received: from BYAPR07MB5381.namprd07.prod.outlook.com
 ([fe80::5a:c16d:31b1:bcd0]) by BYAPR07MB5381.namprd07.prod.outlook.com
 ([fe80::5a:c16d:31b1:bcd0%7]) with mapi id 15.20.3933.032; Mon, 15 Mar 2021
 05:10:54 +0000
From:   Pawel Laszczak <pawell@cadence.com>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
CC:     Peter Chen <peter.chen@kernel.org>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rahul Kumar <kurahul@cadence.com>
Subject: RE: [PATCH 1/2] usb: gadget: uvc: Updating bcdUVC field to 0x0110
Thread-Topic: [PATCH 1/2] usb: gadget: uvc: Updating bcdUVC field to 0x0110
Thread-Index: AQHXFAXCCxCcL/5z3EuR/eM58OtZrKqCwxcAgAAFhgCAAbtgMA==
Date:   Mon, 15 Mar 2021 05:10:54 +0000
Message-ID: <BYAPR07MB53819AA049448C4D8E6E506DDD6C9@BYAPR07MB5381.namprd07.prod.outlook.com>
References: <20210308102735.9251-1-pawell@gli-login.cadence.com>
 <20210314015846.GB17526@b29397-desktop>
 <YE1yeEPwHoMgML0s@pendragon.ideasonboard.com>
In-Reply-To: <YE1yeEPwHoMgML0s@pendragon.ideasonboard.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccGF3ZWxsXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctY2Y1OGQwMjAtODU0Yy0xMWViLTg3ODYtMWM0ZDcwMWRmYmE0XGFtZS10ZXN0XGNmNThkMDIxLTg1NGMtMTFlYi04Nzg2LTFjNGQ3MDFkZmJhNGJvZHkudHh0IiBzej0iMjkwNyIgdD0iMTMyNjAyNTg2NTE4MjYwMzIzIiBoPSJjWXQ4TFJzdEc2NktMWkhRaEU1alNGd1p0Ums9IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-rorf: true
authentication-results: ideasonboard.com; dkim=none (message not signed)
 header.d=none;ideasonboard.com; dmarc=none action=none
 header.from=cadence.com;
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 988207c8-bba2-4dbb-78e2-08d8e770b5f1
x-ms-traffictypediagnostic: BYAPR07MB5384:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR07MB53843DBE981B08FA1E0A1DB0DD6C9@BYAPR07MB5384.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1443;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: C76IzxNP5AYhIcTAJvNeeY0rSw4bxLMIyhWv3MVNeUNjJtJ00M3Y3353c/4pE5Myhxg79HwmSusKAa5CSzJJjeY8wxe9zYc/8XWrlXkw58eKSPdACLchoZaHEDqHDSwNFcDgEyET+d5LYpNUceWZR9Nihneg3JvxscnqWu3I3zq7lFIYpRDMNO7qpCIWaNz81L1elYmF/RAJ7R4qhmga61FKuGg1jA6Kis8HtvehPDQiLglqrQQeVRcfVqY3AANheGWbdBRbwyI2F3cT1UnBbCykozxy112qp+D9oWFal8cOqqW6tl0SO16l+gYdWBOkt2YfdR5ABqLLnVmAoK+mK6fElS34sbsnybsgfJLlMm5dT+3QMDKxpf2dXCXjiIEaBx03G/PCEfRJYUj0UvR19Gcu4s/Bz8oSA6yAgqc3Ypqx6mBnU4CaGCOvRt+r0OvquNd8srsVjDMwqC7A5ANnXdROq61Wpq5CKAegZnx6m/GEUCOJV3OJDo+bPTvN/MfrHX4OOHEV6JlOpw7mfQ9Bje2gAHqmTSOEtWi0PoKCp2bPPFJEaT+XiynC4ZjTyAtE42erGuBtR6DaMgQBRu/Y/yTasXF677MHXsuaUDrojYU2+WQWkswmBYaQxPszzSbS
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR07MB5381.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(366004)(396003)(136003)(376002)(36092001)(83380400001)(316002)(6506007)(6916009)(53546011)(2906002)(107886003)(9686003)(55016002)(71200400001)(7696005)(8676002)(4326008)(8936002)(54906003)(26005)(33656002)(52536014)(66946007)(86362001)(186003)(66476007)(66556008)(76116006)(66446008)(64756008)(5660300002)(66574015)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?Yjh4cnhQYlYzQkVacFlOZzNFSk5EbldaMzR5L295aURic2lUYmRVM3Z5RXJF?=
 =?utf-8?B?U1JhQmZaRDl1ZURrUXlnd0JhTXRZeU9zeG5Hemw2enlQNXNJdnBwU21VbVJ5?=
 =?utf-8?B?dENVWnRSOURnemdBVGp2emtGSGJ2UFJ1ODVLSFFQdlZ4QUU5OGlpZEVxd09h?=
 =?utf-8?B?VXVIZyt6a1kwOHZ1cWZEZVlvQ3FLSldwZVNjM1pNQmxGRXZuNXpPMjZmVG42?=
 =?utf-8?B?cVdqTEhzV3hJMVNMbU9YYksvMFpWUlluL1VEZ0QvVUtIbXY4U1hlTHdmZFM1?=
 =?utf-8?B?TjVHK3FpOGtTaWhzajRyMEhQUTBjQnN2cnhhT0FwU0I4U043QmxSNVAvTHNY?=
 =?utf-8?B?dlFTcjNRK1R1WGh5ZFdTTHl5Nk9WNENGcVZkWElISzYrRmdqcDlpTFJOWUdq?=
 =?utf-8?B?NU44SExrWTY4TXk0RWxielhqcExyanBzK0p0ejg0eTYraDEzM1dMY2ViYkZw?=
 =?utf-8?B?SEptbDdKWm5vV215U3ZDTi9zWGxSNW1tbkUrRzFnQmZDSGVGQmE2M1FNSElx?=
 =?utf-8?B?aVloZ2tUNHROTHZLUExWaU9TTG9KNVl0RjR4aFQwcmt5S3paVGtma0R2OFJO?=
 =?utf-8?B?NkI3YnZ0UXI3Szg1WVhadzFSUEhxK3ZiNVZZSEszWS9jWHNNQmtyaWNxZ0JK?=
 =?utf-8?B?ZnlRSUhjZFVFM1gwM3FKZEI0RlhIeWwrcW84NmNUNFJwek5GbzlWK3g2SmNS?=
 =?utf-8?B?c1NFaDF3TkdmZHphZkhaMWYzUVNCL3g2dGVvT3g2SXJNbGpremxqaERUZ3kr?=
 =?utf-8?B?Z3QvbmJSUTJJUlhXWTRsVTZyalcwZmlicTBzTFYvTFRQaDNuMkxjc2lQMTRD?=
 =?utf-8?B?M1RlMHMyWG9iNytNWmIrRW5HVnlEYVZDNlRrbnBzTmowM1JxSzVJOGFseDdT?=
 =?utf-8?B?VDY2SXpCeUUyTGNtNGV1NU5HWlJlT2FCV0lwQWZaTVBuS1BGVXZ2WjlhaExP?=
 =?utf-8?B?TWlkYU9oQW5OL0dyZHd2QW9qb2tWNmRsdnlaYWV5ajdoMHpkRGJDZ054djM4?=
 =?utf-8?B?SS90RzNGQTQrazI0VFExL1grUzNRbWY0YnZKakZrcnV0bkVtZW1NSGZhd3ZS?=
 =?utf-8?B?Mm1iSytDYzhMZGNHWWEvUUxwaGoxTEVwaTZ3OUx5Mnk1REV1SkliaTdWK1BV?=
 =?utf-8?B?RERpM3RiT045VFVEM0NUYjRSQU5FZklPNkpRT1pDakQ1Lzk0WTU1V1VpazNh?=
 =?utf-8?B?MERYU1FSY200S3pVYmxUMkY2aWxWT2VXcTJFOEw5YkxTOUM2UWE3ajgza3FN?=
 =?utf-8?B?QWxteXV4Vi9MLzczRWVxSkJQNlVEUWJlN3lqdXBRVUZUUm1xc0JRSm16RGlz?=
 =?utf-8?B?dnNhUWN3enVJUEdIVVFIdUhhYXl0eWFEWk1aZTRVbHl1ZkFxc1BjRDhNeUhP?=
 =?utf-8?B?L3dmZ2tBOGlOUWQ3WHp1Z084S0gzbXByQ3VZQ0NNWmtUZnp5WG5DNUgyQU5X?=
 =?utf-8?B?TjNoazgvVlg3WW5tbEZzRTVEVFNjcy9FTXpxdVFvazRGY0VuNjJtQ1Mrc1N0?=
 =?utf-8?B?bU9NRmxVN3htT0FvYVBJS2tSSUZrY1FMV0lvU1IvK3pTSXVab1poWGtTSCtt?=
 =?utf-8?B?dEhDaU5kNTlmZTBTampXblhCNGhSRGhUVTdIMTYyZkF6dkpPYkNlbDlCWlk0?=
 =?utf-8?B?VEJEeW9yVnhhUHk1aUpDbkdTOWVGT1NIYWx2TGxnN3B6dEV0RHA4em5SdURa?=
 =?utf-8?B?V0tPUkV6dk44QXMxNGxMY0UrNWF3blJ6Zk1pNWVzeU1PTE9LbTFYNnA0ZXNJ?=
 =?utf-8?Q?KE/iJtCB5sfj1epZ+22/XLVdgCxkSJDZfOq7EbM?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR07MB5381.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 988207c8-bba2-4dbb-78e2-08d8e770b5f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2021 05:10:54.6730
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UNIGg6WNALx5mypeYKqNKjoslfs4ohQKQdJL11fe4ZnUrM9WxnlA55jJJvnPZguvpoAurVwteRDORt4leowjiKx+HvhelCwcZ/aeBNhWBP8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB5384
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-15_01:2021-03-15,2021-03-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 phishscore=0
 mlxlogscore=999 priorityscore=1501 bulkscore=0 impostorscore=0 spamscore=0
 adultscore=0 malwarescore=0 suspectscore=0 mlxscore=0 lowpriorityscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103150034
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

SGkgTGF1cmVudA0KPg0KPkhlbGxvIFBhd2VsLA0KPg0KPlRoYW5rIHlvdSBmb3IgdGhlIHBhdGNo
Lg0KPg0KPk9uIFN1biwgTWFyIDE0LCAyMDIxIGF0IDA5OjU4OjQ2QU0gKzA4MDAsIFBldGVyIENo
ZW4gd3JvdGU6DQo+PiBPbiAyMS0wMy0wOCAxMToyNzozNCwgUGF3ZWwgTGFzemN6YWsgd3JvdGU6
DQo+PiA+IEZyb206IFBhd2VsIExhc3pjemFrIDxwYXdlbGxAY2FkZW5jZS5jb20+DQo+PiA+DQo+
PiA+IENvbW1hbmQgVmVyaWZpZXIgZHVyaW5nIFVWQyBEZXNjcmlwdG9yIFRlc3RzIChDbGFzcyBW
aWRlbyBDb250cm9sDQo+PiA+IEludGVyZmFjZSBEZXNjcmlwdG9yIFRlc3QgVmlkZW8pIGNvbXBs
ZWlucyBhYm91dDoNCj4+DQo+PiAlcy9jb21wbGVpbnMvY29tcGxhaW5zDQo+Pg0KPj4gPiBWaWRl
byBDb250cm9sIEludGVyZmFjZSBIZWFkZXIgYmNkVVZDIGlzIDB4MDEwMC4gVVNCIFZpZGVvIENs
YXNzDQo+PiA+IHNwZWNpZmljYXRpb24gMS4wIGhhcyBiZWVuIHJlcGxhY2VkIGJ5IDEuMSBzcGVj
aWZpY2F0aW9uDQo+PiA+IChVVkM6IDYuMi4yNikgQ2xhc3MgVmlkZW8gQ29udHJvbCBJbnRlcmZh
Y2UgRGVzY3JpcHRvciBiY2RVVkMgaXMgbm90IDEuMQ0KPj4NCj4+IFdoYXQgZG9lcyB0aGlzIChV
VkM6IDYuMi4yNikgbWVhbj8gVGhlcmUgYXJlIG9ubHkgNCBjaGFwdGVycyBmb3IgdGhpcw0KPj4g
c3BlYywgQW0gSSBzb21ldGhpbmcgd3Jvbmc/DQo+DQo+SSBhc3N1bWUgdGhpcyBpcyBhIHJlZmVy
ZW5jZSB0byBhIHRlc3QgY2FzZSBpbiB0aGUgdGVzdCBzdWl0ZS4NCg0KSXQncyBhIHJlZmVyZW5j
ZSB0byBVVkMgQ29tcGxpYW5jZSBUZXN0IFNwZWMucGRmLiANClRoaXMgZG9jdW1lbnQgaXMgcGFy
dCBvZiBDb21tYW5kIFZlcmlmaWVyIHRlc3Rlci4NCg0KSSB3aWxsIHJlc2VuZCB0aGUgcGF0Y2gg
d2l0aG91dCB0eXBvLiANCg0KVGhhbmtzDQoNCj4NCj4+ID4gU2lnbmVkLW9mZi1ieTogUGF3ZWwg
TGFzemN6YWsgPHBhd2VsbEBjYWRlbmNlLmNvbT4NCj4+ID4gLS0tDQo+PiA+ICBkcml2ZXJzL3Vz
Yi9nYWRnZXQvZnVuY3Rpb24vdXZjX2NvbmZpZ2ZzLmMgfCAyICstDQo+PiA+ICBkcml2ZXJzL3Vz
Yi9nYWRnZXQvbGVnYWN5L3dlYmNhbS5jICAgICAgICAgfCAyICstDQo+PiA+ICAyIGZpbGVzIGNo
YW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4+ID4NCj4+ID4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvdXNiL2dhZGdldC9mdW5jdGlvbi91dmNfY29uZmlnZnMuYyBiL2RyaXZl
cnMvdXNiL2dhZGdldC9mdW5jdGlvbi91dmNfY29uZmlnZnMuYw0KPj4gPiBpbmRleCAwMGZiNThl
NTBhMTUuLmNkMjhkZWM4MzdkZCAxMDA2NDQNCj4+ID4gLS0tIGEvZHJpdmVycy91c2IvZ2FkZ2V0
L2Z1bmN0aW9uL3V2Y19jb25maWdmcy5jDQo+PiA+ICsrKyBiL2RyaXZlcnMvdXNiL2dhZGdldC9m
dW5jdGlvbi91dmNfY29uZmlnZnMuYw0KPj4gPiBAQCAtMjMxLDcgKzIzMSw3IEBAIHN0YXRpYyBz
dHJ1Y3QgY29uZmlnX2l0ZW0gKnV2Y2dfY29udHJvbF9oZWFkZXJfbWFrZShzdHJ1Y3QgY29uZmln
X2dyb3VwICpncm91cCwNCj4+ID4gIAloLT5kZXNjLmJMZW5ndGgJCQk9IFVWQ19EVF9IRUFERVJf
U0laRSgxKTsNCj4+ID4gIAloLT5kZXNjLmJEZXNjcmlwdG9yVHlwZQkJPSBVU0JfRFRfQ1NfSU5U
RVJGQUNFOw0KPj4gPiAgCWgtPmRlc2MuYkRlc2NyaXB0b3JTdWJUeXBlCT0gVVZDX1ZDX0hFQURF
UjsNCj4+ID4gLQloLT5kZXNjLmJjZFVWQwkJCT0gY3B1X3RvX2xlMTYoMHgwMTAwKTsNCj4+ID4g
KwloLT5kZXNjLmJjZFVWQwkJCT0gY3B1X3RvX2xlMTYoMHgwMTEwKTsNCj4+ID4gIAloLT5kZXNj
LmR3Q2xvY2tGcmVxdWVuY3kJPSBjcHVfdG9fbGUzMig0ODAwMDAwMCk7DQo+PiA+DQo+PiA+ICAJ
Y29uZmlnX2l0ZW1faW5pdF90eXBlX25hbWUoJmgtPml0ZW0sIG5hbWUsICZ1dmNnX2NvbnRyb2xf
aGVhZGVyX3R5cGUpOw0KPj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZ2FkZ2V0L2xlZ2Fj
eS93ZWJjYW0uYyBiL2RyaXZlcnMvdXNiL2dhZGdldC9sZWdhY3kvd2ViY2FtLmMNCj4+ID4gaW5k
ZXggYTlmOGViOGUxYzc2Li4zYTYxZGU0YmIyYjEgMTAwNjQ0DQo+PiA+IC0tLSBhL2RyaXZlcnMv
dXNiL2dhZGdldC9sZWdhY3kvd2ViY2FtLmMNCj4+ID4gKysrIGIvZHJpdmVycy91c2IvZ2FkZ2V0
L2xlZ2FjeS93ZWJjYW0uYw0KPj4gPiBAQCAtOTAsNyArOTAsNyBAQCBzdGF0aWMgY29uc3Qgc3Ry
dWN0IFVWQ19IRUFERVJfREVTQ1JJUFRPUigxKSB1dmNfY29udHJvbF9oZWFkZXIgPSB7DQo+PiA+
ICAJLmJMZW5ndGgJCT0gVVZDX0RUX0hFQURFUl9TSVpFKDEpLA0KPj4gPiAgCS5iRGVzY3JpcHRv
clR5cGUJPSBVU0JfRFRfQ1NfSU5URVJGQUNFLA0KPj4gPiAgCS5iRGVzY3JpcHRvclN1YlR5cGUJ
PSBVVkNfVkNfSEVBREVSLA0KPj4gPiAtCS5iY2RVVkMJCQk9IGNwdV90b19sZTE2KDB4MDEwMCks
DQo+PiA+ICsJLmJjZFVWQwkJCT0gY3B1X3RvX2xlMTYoMHgwMTEwKSwNCj4+ID4gIAkud1RvdGFs
TGVuZ3RoCQk9IDAsIC8qIGR5bmFtaWMgKi8NCj4+ID4gIAkuZHdDbG9ja0ZyZXF1ZW5jeQk9IGNw
dV90b19sZTMyKDQ4MDAwMDAwKSwNCj4+ID4gIAkuYkluQ29sbGVjdGlvbgkJPSAwLCAvKiBkeW5h
bWljICovDQo+DQo+VGhlIGNoYW5nZSBsb29rcyBnb29kIHRvIG1lLiBXaXRoIHRoZSB0eXBvIGlu
IHRoZSBjb21taXQgbWVzc2FnZSBmaXhlZCwNCj4NCj5SZXZpZXdlZC1ieTogTGF1cmVudCBQaW5j
aGFydCA8bGF1cmVudC5waW5jaGFydEBpZGVhc29uYm9hcmQuY29tPg0KPg0KLS0NCg0KUmVnYXJk
cw0KUGF3ZWwgTGFzemN6YWsNCg==

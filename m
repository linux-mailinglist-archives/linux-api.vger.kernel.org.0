Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B136333AC09
	for <lists+linux-api@lfdr.de>; Mon, 15 Mar 2021 08:11:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbhCOHKk (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 15 Mar 2021 03:10:40 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:17974 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229828AbhCOHKa (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 15 Mar 2021 03:10:30 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12F79QDO024736;
        Mon, 15 Mar 2021 00:10:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=qbn2OsVNHwRdr1jsod6PteXw9+dn0tTp7yVXEeyVSsM=;
 b=MqmdL+KMK6Ofk5UqEWxKcaLRYbkV8RnUEUcz+kMQAE9qF8ojQQS02LNjk1AbuDgHY9cj
 yGpziWZx4Kn1T545PPe1oRNkeoQmtQpJ8C/K+oMVWrkg6yebBK18iyvEMUPnb9+YgzgY
 6M3dmOqs/6Q+Og18T234YMaExuwBqNvThT4tcfTO8sKBie7G0HSEek+lVMzsMqZZL7LE
 NqlcW79aPm0oO2gl1PMArte8C0qrlGqEJoO6261vF0Y2rLdulh4YfFoOOQpf4xDPDNH2
 RbOQ1V3Wh1TNyjKvCs9kJ4xvS77UN3dVq+Ry5hzULQgHNUfow6zRByNhxa5hu4JL2ifu sQ== 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
        by mx0b-0014ca01.pphosted.com with ESMTP id 378sv2d1yj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 Mar 2021 00:10:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ehG9rqlPG4Ly7G8Q0QuNzkQlvSbKAq/XpqMr451Hf6jLdNqCwPntxak+RGXjnY4xzdiZNzn+AHU51Op3PVF3pvuMQFxDiU316u9smGppiuqnq4E0RocQM4xKb7OKqFJUM1MrPzS4W4Ev5pjHQAPxxB7KRe+DpKsohNQV07pEbdsqzAnBj2glQZ62ZTxD6bZWaiKgKwGQfCpN3lczsu7eWKRz1+UO0zA04g3WwmZi78D8FvlPPVVnP06LFCauh+f4t9u+fjiFXvbYcjyACgQQKj3l4Hqac6vLKKASR07Cge6lQe+cRBKUE9cEyKvKDvXtkXYVz650nKcr1y6Dwhe1vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qbn2OsVNHwRdr1jsod6PteXw9+dn0tTp7yVXEeyVSsM=;
 b=JgnEbYw6Zfu0xbukwQlciAQz9JR9ABp0O2bsgxOuAxJ3jV6ryXW+jWmfO4f6/mf2IRmxywneDFzn/1BYzouIe/TrBDgiOYhCn/LiAb/2R5IvxicPkN0OKERUc/MCgnXD3WnS/uxsmyWPBNbR6BNEvXAQK2t5aNnxakADZ3bQPW4q/mD3mQvYnJ+ZefOujUqSzKlg98LLFC5OnMAfmKqyOHrFDhSoz1/JOXissM18rK8T3YqKMc5yPsx1GO3790O569/Qnof+qEmgVTRbLrC7j7d1dPrhAdEXbGkRoEcSVLPI39YGfsZ7DTg5wRxj9cpB8gD08WuPZAx+mqeqdcM4ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qbn2OsVNHwRdr1jsod6PteXw9+dn0tTp7yVXEeyVSsM=;
 b=iEyS++NMQ+sSVVmoQpjtkFrXsu0F8JiSVLaMrnIOqGaVBu6D4WCkF2AB6c2YpjPLLK8t29nnj10ZYhcwaUQdzH9q+mmUmvmkrslXiu/wOlR5VJiUozRC6znu0lH3KDPFv85c4/jbx2hXJx5LX+qkIzJTBUL+Zm5kgd7Ta6RSn2o=
Received: from BYAPR07MB5381.namprd07.prod.outlook.com (2603:10b6:a03:6d::24)
 by BY5PR07MB7218.namprd07.prod.outlook.com (2603:10b6:a03:205::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Mon, 15 Mar
 2021 07:10:22 +0000
Received: from BYAPR07MB5381.namprd07.prod.outlook.com
 ([fe80::5a:c16d:31b1:bcd0]) by BYAPR07MB5381.namprd07.prod.outlook.com
 ([fe80::5a:c16d:31b1:bcd0%7]) with mapi id 15.20.3933.032; Mon, 15 Mar 2021
 07:10:22 +0000
From:   Pawel Laszczak <pawell@cadence.com>
To:     Pawel Laszczak <pawell@cadence.com>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "laurent.pinchart@ideasonboard.com" 
        <laurent.pinchart@ideasonboard.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "peter.chen@kernel.org" <peter.chen@kernel.org>,
        Rahul Kumar <kurahul@cadence.com>
Subject: RE: [PATCH v3 2/2] usb: webcam: Invalid size of Processing Unit
 Descriptor
Thread-Topic: [PATCH v3 2/2] usb: webcam: Invalid size of Processing Unit
 Descriptor
Thread-Index: AQHXGWjrBgWYuAhXOUG6So5qfKHKwaqEoOHg
Date:   Mon, 15 Mar 2021 07:10:22 +0000
Message-ID: <BYAPR07MB5381E81CB3AFB6D68E95F4B1DD6C9@BYAPR07MB5381.namprd07.prod.outlook.com>
References: <20210315065926.30152-1-pawell@gli-login.cadence.com>
 <20210315065926.30152-2-pawell@gli-login.cadence.com>
In-Reply-To: <20210315065926.30152-2-pawell@gli-login.cadence.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccGF3ZWxsXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctODAyNmQ4MWUtODU1ZC0xMWViLTg3ODYtMWM0ZDcwMWRmYmE0XGFtZS10ZXN0XDgwMjZkODIwLTg1NWQtMTFlYi04Nzg2LTFjNGQ3MDFkZmJhNGJvZHkudHh0IiBzej0iMjgwNSIgdD0iMTMyNjAyNjU4MjAzNTYzNDU1IiBoPSJmVFk0bi9MdU1ubVh3K0xhdEU5a0hWcCtyd2s9IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-rorf: true
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c87fafe3-d991-4df1-7c9b-08d8e7816631
x-ms-traffictypediagnostic: BY5PR07MB7218:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR07MB721875FD0DC8963E230E18E4DD6C9@BY5PR07MB7218.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1332;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sVqGObPcVpv+0JwA3oqtEc/Zkdc1xjSXrht5xH7XqcD77/USyVFyQ+4juuLF+ZnciILMTVJztPnT+YTpFt/u4j8qzxMIe11Ls0+7294MEkZNKx+I74pg1AlqTej71vadiDtQiA+FhfPQ7FcbdsJiTIcD+2a/gjhtuSOtBeOWXJy9NTE1NhpLDusn47fNJ+4dVNAQPIEGrIDM4QUaeer+l1U57fuGS4pAcQoRSnniAJ8e4b6mfhGCvtOjqY8iJwoYlVPnAxEnsyzkLAe3tryh9nHZs4aoQujFxbLaKfC5E4YYrDT/iJQk9l00dOCywVIKLcIsI3fVawfVGMypatnKLPnNXIsHHXGwRPruS0PBRzGsub7Kr3OMqx80GS3/nV5PUZVay23gSm3NzGdbG3dtG7ob4T953ETYXLZF+F+nhXJ1RV9l4wdi6xNP2pVCMHhBVmktec1Hp+PBG7/FcyoJRuuAignJP8n1nDfiPHM8KOQLeCu4cLpAJqKvbhtZKyI7BNk5DJtAVJyCTKXD2amIZwcwn1Mj9mty0lbKFMU29XTHmg31+HCnm3GFmwyZWB9wrv2a3Bz22umMShd5fn2sOb3nApv3dCDUQ72Sn01CP7A=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR07MB5381.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(396003)(366004)(346002)(39860400002)(36092001)(66946007)(9686003)(55016002)(6506007)(64756008)(66476007)(26005)(5660300002)(4326008)(54906003)(8936002)(33656002)(8676002)(7696005)(66446008)(76116006)(52536014)(86362001)(66556008)(107886003)(71200400001)(2906002)(66574015)(316002)(83380400001)(186003)(478600001)(110136005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?2w0AnJlFXpSErq3wf84GWcgayVIx9Dbnq5TV802iKifX2FLcaKSuGoAT5Lbe?=
 =?us-ascii?Q?OyBxx5qoNI7tgdCbTr1K5d9Pq1GFngTnx8oYWl6MB5ybCx7URrcVIryZjlEX?=
 =?us-ascii?Q?zt7Y3k/7+P6UpH0uX5qxMfOPC5BYYoxef5/eIdN/3u+stVFU0kI47V7dJI5j?=
 =?us-ascii?Q?JtK0Amx/7K5+Nwy+t9P9tgS01nQJG7ZlayrTm3O9otqG7x41Fo9EABNCySdQ?=
 =?us-ascii?Q?GQgXxZBIMG6JP7Y0Tsqxy5PjGtwEUiQhwrr2ixM56OPxZ3ergQhdKTZO4eWT?=
 =?us-ascii?Q?YtQADn89wNOBkTefC0PY4iFNNOPC7z3RtvKkao7o6NTZ2txMN5ttmr3fEjD7?=
 =?us-ascii?Q?NY3a4/XXlmqpAi4a/6ynIsPvJgOIQIfVHT46Yv5Icv1KW/YlRCCihNPBLrqU?=
 =?us-ascii?Q?xw/XSUpUFUZDYeRqoebWa/Q8EatVCJBwrkHuFqwbhWlaM8RUJ0G0MQ1rhiwA?=
 =?us-ascii?Q?LxDNRdzIYgs0vcU4mP+snTCTybsMBUwA/yUAIrqSA5qySFsiG2BFc+hfvZjp?=
 =?us-ascii?Q?bt/YPzN9/eG5gmLg2Op7L8rqa04ryVvYCycaaR/qkXAQb1wfY0WjQk8Vxkuj?=
 =?us-ascii?Q?N/U7wmU2p9hg0WU6v2Dak700r0D5oUdGCbLrK9BjSHUpeTistZYMJWOa9/hM?=
 =?us-ascii?Q?BLiKuOzwMCee4caDVn92IyYUVdeg/Vqoz1m1ptNn+1PyxQhDkOP/WyfXaH+K?=
 =?us-ascii?Q?UBvbiG7kmmMjugtXBEa4FF86Z8sny7EeqVYjrkQkXgJ6Ud/C6RMRTxwFmOdO?=
 =?us-ascii?Q?RlWyo5JUlwghQc7pmIMR+HbvlT7deREAc+vuRFTXoW/tP12Abox/9ac7Qd9E?=
 =?us-ascii?Q?2eCH48ty0k8Jk18YbYIKgpfTfUcNTs2fpSE5dmhhlBJTAqituN9roxwO+RgK?=
 =?us-ascii?Q?ku7s5WIDiUNlHYGlPJr+DSVC5cGiyNLoxX4fLMz3W2a8zmWWaBUf3xR11D0/?=
 =?us-ascii?Q?Yg4NI0qYPnGAI9zHeFFhQXcbnwdwkO4Cvk9vd+rgeQEN5PVKV5+h34zlRvsP?=
 =?us-ascii?Q?KW1P95urA6yePI0LvNDAZ3ZJ+KduKxOpRk/GLujvhbFyqfDMCYUf/W5deUmm?=
 =?us-ascii?Q?IPIzO07JgaQq52ZUvD6m7uW1Vk46Y4FjoHfoOO1oe0gOh0w75OiCQ7h1m1P/?=
 =?us-ascii?Q?gVREwY0aKhx64ZdUHWo3g5om2Wb0mil8pzZlLsfbMn/saYqfWN7GqVy8oL4F?=
 =?us-ascii?Q?9GUtYXE+6zGiFXwi58kDhFnGwnmV1qNHQfcx5YvYLf2DFGtG53vFLxBtBLfN?=
 =?us-ascii?Q?f3SYMIQjkH7EsgozKRU3DrFMvVdqgqEkw5bXr0C8yPhcQyadIuzkcjNFMAtU?=
 =?us-ascii?Q?WwZTm5o8iWlaSfygvYZNuZOk?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR07MB5381.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c87fafe3-d991-4df1-7c9b-08d8e7816631
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2021 07:10:22.3352
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 21XRPWJPhr3GdetA8a+CQVVc/Sh8dst7PLFa/KW8SsS/iaYtRpKi8VXxLjI4KceD9gqj07AyN8rnl7XyfCpIc3Tq+ZWSIlEFcFb/FT4SmdE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR07MB7218
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-15_01:2021-03-15,2021-03-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 phishscore=0
 mlxlogscore=999 priorityscore=1501 bulkscore=0 impostorscore=0 spamscore=0
 adultscore=0 malwarescore=0 suspectscore=0 mlxscore=0 lowpriorityscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103150049
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org


Please ignore this one patch. I need to resend it. It causes compilation er=
ror.
Sorry for that. =20

>
>From: Pawel Laszczak <pawell@cadence.com>
>
>According with USB Device Class Definition for Video Device the
>Processing Unit Descriptor bLength should be 12 (10 + bmControlSize),
>but it has 11.
>
>Invalid length caused that Processing Unit Descriptor Test Video form
>CV tool failed. To fix this issue patch adds bmVideoStandards into
>uvc_processing_unit_descriptor structure.
>
>The bmVideoStandards field was added in UVC 1.1 and it wasn't part of
>UVC 1.0a.
>
>Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>Signed-off-by: Pawel Laszczak <pawell@cadence.com>
>
>---
>Changelog:
>v3:
>- updated the commit message
>- added bmVideoStandard field to UVC gadget driver
>v2:
>- updated UVC_DT_PROCESSING_UNIT_SIZE macro
>
> drivers/usb/gadget/function/f_uvc.c | 1 +
> drivers/usb/gadget/legacy/webcam.c  | 1 +
> include/uapi/linux/usb/video.h      | 3 ++-
> 3 files changed, 4 insertions(+), 1 deletion(-)
>
>diff --git a/drivers/usb/gadget/function/f_uvc.c b/drivers/usb/gadget/func=
tion/f_uvc.c
>index 5d62720bb9e1..e3b0a79c8f01 100644
>--- a/drivers/usb/gadget/function/f_uvc.c
>+++ b/drivers/usb/gadget/function/f_uvc.c
>@@ -823,6 +823,7 @@ static struct usb_function_instance *uvc_alloc_inst(vo=
id)
> 	pd->bmControls[0]		=3D 1;
> 	pd->bmControls[1]		=3D 0;
> 	pd->iProcessing			=3D 0;
>+	pd->bmVideoStandards		=3D 0;
>
> 	od =3D &opts->uvc_output_terminal;
> 	od->bLength			=3D UVC_DT_OUTPUT_TERMINAL_SIZE;
>diff --git a/drivers/usb/gadget/legacy/webcam.c b/drivers/usb/gadget/legac=
y/webcam.c
>index 3a61de4bb2b1..accb4dacf715 100644
>--- a/drivers/usb/gadget/legacy/webcam.c
>+++ b/drivers/usb/gadget/legacy/webcam.c
>@@ -125,6 +125,7 @@ static const struct uvc_processing_unit_descriptor uvc=
_processing =3D {
> 	.bmControls[0]		=3D 1,
> 	.bmControls[1]		=3D 0,
> 	.iProcessing		=3D 0,
>+	.bmVideoStandrads	=3D 0,
> };
>
> static const struct uvc_output_terminal_descriptor uvc_output_terminal =
=3D {
>diff --git a/include/uapi/linux/usb/video.h b/include/uapi/linux/usb/video=
.h
>index d854cb19c42c..bfdae12cdacf 100644
>--- a/include/uapi/linux/usb/video.h
>+++ b/include/uapi/linux/usb/video.h
>@@ -302,9 +302,10 @@ struct uvc_processing_unit_descriptor {
> 	__u8   bControlSize;
> 	__u8   bmControls[2];
> 	__u8   iProcessing;
>+	__u8   bmVideoStandards;
> } __attribute__((__packed__));
>
>-#define UVC_DT_PROCESSING_UNIT_SIZE(n)			(9+(n))
>+#define UVC_DT_PROCESSING_UNIT_SIZE(n)			(10+(n))
>
> /* 3.7.2.6. Extension Unit Descriptor */
> struct uvc_extension_unit_descriptor {
>--
>2.25.1

Regards,
Pawel Laszczak

Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C6D533ABE0
	for <lists+linux-api@lfdr.de>; Mon, 15 Mar 2021 08:01:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229985AbhCOHAm (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 15 Mar 2021 03:00:42 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:51630 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229951AbhCOHA2 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 15 Mar 2021 03:00:28 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12F6xDMY013494;
        Mon, 15 Mar 2021 00:00:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=F6ebSNeKQjYEKTADs5ZY9rLutL91LV87vmOmK8EP48c=;
 b=BHdEZycdS7Km1Z8LHvYYoHzGq9FdjsQ1OzyAwr8h295g4SuBtUK7r2vWoC07cFM5jRq/
 UJAwvXIMaDZyY5gzxnf0EL4YJZbWjSFo8OtpiOHl/dsW2CT2YhU7k0DwEZzYS2NGvr+R
 WgBU8u5LyQKIOy8/tvcf63iG2Fi9oryeG3tJQcBHjf+QxYmoxtgQ9nNKLdEcYfsoQAZQ
 JQ+d/RR/nWXs16hBMIeCuL8DGPWhbjs81Cq35MbBCHleUEAGTNfEDBWRP76dkuDxg8h6
 PmisOol6CtnYvvtMm0iXs+3j+QRNu1Zpp7nXi+9jF77tSwRzwjibcgwxNGoEx/P8hP07 XQ== 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
        by mx0a-0014ca01.pphosted.com with ESMTP id 378tu1vk3e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 Mar 2021 00:00:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dvCj/zIBrv+SSplFjEB4KjGcgyUMTVvzI5fJlhPsnHRsR7zW5bdLwa5dti1eAIACwuiD51V7D/XBBquXF9sXjFo4Je2YSrF4pJ7ok9TFP6aBWcg1MZAvw4fUtwA+43jiu77HpBq5q2Siln/YCgEn2EVGnwFcbPBLAEWkb2mwA3zNW6oDBfxFE0bYZdxmS+qQq5W40qHMlr7NXCWB+hQjs4fT4sipfuFX6MuJf3HJ0JfJV07Hwu6C5g9lY/DZAjLofmOpie1ZTaMhIFVm0maVjo2ngvQOeQ1B8ocsysASXBb3p7EGsqI0lSCnIEZlCC5HzKpAayuB3eK6/QInqtWCQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F6ebSNeKQjYEKTADs5ZY9rLutL91LV87vmOmK8EP48c=;
 b=G0BviDG5MFaO/98LdEblKPzHQfYMWQMruUehYjPxN65KiIajZRKGPoUtaHHj56U9A6a8eX27n8gmQslG75PFkczQE1fZ5CxsK+UK2SCIIIAJgOpyXXfOlTjG8feHB6I4gtq1Z/qNUjlcZr5Ps0Uxg7ksuuJAkqXsTPuXpJn0w5QLWqii9TVK6aj7XO6kpudcbKRpFIkHKezdpeSW4S7Ew/bYfHt36HC6hJOfHxyEstGBEu8fZ1HEzZ3DQ7FJ4O9H8e2+9zcu+ZTfxz+x+6Aau3S0ZRYZ+JeQUy+KMkspgafqy4Yy69wdizEsO56psAWfd1wOwQ0hKm4aLYwgacwydg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 158.140.1.148) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F6ebSNeKQjYEKTADs5ZY9rLutL91LV87vmOmK8EP48c=;
 b=Qsa+bAAUis1+f6hOC+vo2LqdI7QL3nylvbbe8wCUhHYg0lIRIqks1WzTMC+ND4DLyx8II79JX7+0Nugj/GxxgHulJFQiigxKSwYl5Q6l/ity5IkjWPke66G3iR49ZbROY6CwYs0WfbZdPQA1ENKMrr/y+WKNMIKrePlFHPLlLik=
Received: from DM5PR07CA0059.namprd07.prod.outlook.com (2603:10b6:4:ad::24) by
 DS7PR07MB8333.namprd07.prod.outlook.com (2603:10b6:5:3a5::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3933.32; Mon, 15 Mar 2021 07:00:23 +0000
Received: from DM6NAM12FT014.eop-nam12.prod.protection.outlook.com
 (2603:10b6:4:ad:cafe::30) by DM5PR07CA0059.outlook.office365.com
 (2603:10b6:4:ad::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.31 via Frontend
 Transport; Mon, 15 Mar 2021 07:00:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 158.140.1.148)
 smtp.mailfrom=cadence.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none
 header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 158.140.1.148 as permitted sender) receiver=protection.outlook.com;
 client-ip=158.140.1.148; helo=sjmaillnx2.cadence.com;
Received: from sjmaillnx2.cadence.com (158.140.1.148) by
 DM6NAM12FT014.mail.protection.outlook.com (10.13.178.128) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3955.9 via Frontend Transport; Mon, 15 Mar 2021 07:00:22 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx2.cadence.com (8.14.4/8.14.4) with ESMTP id 12F70KBp021550
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Mar 2021 00:00:21 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 15 Mar 2021 08:00:19 +0100
Received: from gli-login.cadence.com (10.187.128.100) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Mon, 15 Mar 2021 08:00:19 +0100
Received: from gli-login.cadence.com (localhost [127.0.0.1])
        by gli-login.cadence.com (8.14.4/8.14.4) with ESMTP id 12F70JLL033228;
        Mon, 15 Mar 2021 08:00:19 +0100
Received: (from pawell@localhost)
        by gli-login.cadence.com (8.14.4/8.14.4/Submit) id 12F70Jm9033215;
        Mon, 15 Mar 2021 08:00:19 +0100
From:   Pawel Laszczak <pawell@cadence.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>
CC:     <linux-api@vger.kernel.org>, <laurent.pinchart@ideasonboard.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <peter.chen@kernel.org>, <kurahul@cadence.com>,
        Pawel Laszczak <pawell@cadence.com>
Subject: [PATCH v3 2/2] usb: webcam: Invalid size of Processing Unit Descriptor
Date:   Mon, 15 Mar 2021 07:59:26 +0100
Message-ID: <20210315065926.30152-2-pawell@gli-login.cadence.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210315065926.30152-1-pawell@gli-login.cadence.com>
References: <20210315065926.30152-1-pawell@gli-login.cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7268dcc1-5ec1-4b2b-185d-08d8e78000c2
X-MS-TrafficTypeDiagnostic: DS7PR07MB8333:
X-Microsoft-Antispam-PRVS: <DS7PR07MB8333AE71317A3AE5C2B8E21BDD6C9@DS7PR07MB8333.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1060;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R+9e0GJ/kFPUBP0SW9FVIXG64ZMB2pNCDDd5LXieBtB/J84Vyt8tsiSlk+x6zBswG7HYa4Zc0LDZOpSoyDZWKAAA3uiPsgZ1uU3gr0ASPCSm4TAs8E40XcuPZtCXxJwiw9pzLAis+vdaS3cK+8oeUvEQePcTg8my0P4oON4G532bqPKHq0f+7DKoxtn5h6YVgXg3ou2fUDzYRJbEZ01eckPnIZM2TGlRhdtunv5dX7wNRWs4sVGhVPLB0Dg/Zzn0oksvapHMGfUzzJn2IVYen3My7ETcw3GobS5fheDJzZwJHCKbdmFqb1mq7+Z3AJNDg0dw2aulHU09gcPfASQgszxeT5BJiw0JKZyIen32u/VKVu//4ETdLkx5dMburYZc4ngKmIEhNsOh9xX5S7J2iJGdTTZ7fd+QrdRLFL+4pnELwgQrlf2ag/DioEENljHcnmAbvQ5EAZibcWWkz4zvgLQpiGW2eVgjuPNZ4Co4Xe242KhpB5nyQycOC5bML/NfnrjS+Xpg2XEykckmLnE25J5KKDLSJAHGiIDyPihGILhbKpkTgvsQ0B8p4hMehM4q+gB4fBxKCdeMxXZLDEpjNzr5YWNLX+eVB61TD4xDhT6gKgnFWJDa9FKHalk68H781lBTJWgM89k4bSh4PgNjkkr12GghTNhP6KPno+38KFfMU2oNDxqtsdEMkPzjvEv6
X-Forefront-Antispam-Report: CIP:158.140.1.148;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:sjmaillnx2.cadence.com;PTR:unknown.Cadence.COM;CAT:NONE;SFS:(4636009)(136003)(396003)(376002)(39860400002)(346002)(36092001)(36840700001)(46966006)(42186006)(316002)(36906005)(26005)(5660300002)(1076003)(36860700001)(66574015)(6666004)(83380400001)(82310400003)(82740400003)(7636003)(8676002)(70586007)(186003)(107886003)(86362001)(54906003)(70206006)(2906002)(110136005)(4326008)(8936002)(426003)(47076005)(478600001)(336012)(356005);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2021 07:00:22.6416
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7268dcc1-5ec1-4b2b-185d-08d8e78000c2
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.148];Helo=[sjmaillnx2.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM12FT014.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR07MB8333
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-15_01:2021-03-15,2021-03-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 adultscore=15
 priorityscore=1501 bulkscore=0 phishscore=0 clxscore=1015
 lowpriorityscore=0 malwarescore=0 spamscore=0 suspectscore=0
 impostorscore=0 mlxscore=0 mlxlogscore=999 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103150047
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

From: Pawel Laszczak <pawell@cadence.com>

According with USB Device Class Definition for Video Device the
Processing Unit Descriptor bLength should be 12 (10 + bmControlSize),
but it has 11.

Invalid length caused that Processing Unit Descriptor Test Video form
CV tool failed. To fix this issue patch adds bmVideoStandards into
uvc_processing_unit_descriptor structure.

The bmVideoStandards field was added in UVC 1.1 and it wasn't part of
UVC 1.0a.

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Pawel Laszczak <pawell@cadence.com>

---
Changelog:
v3:
- updated the commit message
- added bmVideoStandard field to UVC gadget driver
v2:
- updated UVC_DT_PROCESSING_UNIT_SIZE macro

 drivers/usb/gadget/function/f_uvc.c | 1 +
 drivers/usb/gadget/legacy/webcam.c  | 1 +
 include/uapi/linux/usb/video.h      | 3 ++-
 3 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/function/f_uvc.c b/drivers/usb/gadget/function/f_uvc.c
index 5d62720bb9e1..e3b0a79c8f01 100644
--- a/drivers/usb/gadget/function/f_uvc.c
+++ b/drivers/usb/gadget/function/f_uvc.c
@@ -823,6 +823,7 @@ static struct usb_function_instance *uvc_alloc_inst(void)
 	pd->bmControls[0]		= 1;
 	pd->bmControls[1]		= 0;
 	pd->iProcessing			= 0;
+	pd->bmVideoStandards		= 0;
 
 	od = &opts->uvc_output_terminal;
 	od->bLength			= UVC_DT_OUTPUT_TERMINAL_SIZE;
diff --git a/drivers/usb/gadget/legacy/webcam.c b/drivers/usb/gadget/legacy/webcam.c
index 3a61de4bb2b1..accb4dacf715 100644
--- a/drivers/usb/gadget/legacy/webcam.c
+++ b/drivers/usb/gadget/legacy/webcam.c
@@ -125,6 +125,7 @@ static const struct uvc_processing_unit_descriptor uvc_processing = {
 	.bmControls[0]		= 1,
 	.bmControls[1]		= 0,
 	.iProcessing		= 0,
+	.bmVideoStandrads	= 0,
 };
 
 static const struct uvc_output_terminal_descriptor uvc_output_terminal = {
diff --git a/include/uapi/linux/usb/video.h b/include/uapi/linux/usb/video.h
index d854cb19c42c..bfdae12cdacf 100644
--- a/include/uapi/linux/usb/video.h
+++ b/include/uapi/linux/usb/video.h
@@ -302,9 +302,10 @@ struct uvc_processing_unit_descriptor {
 	__u8   bControlSize;
 	__u8   bmControls[2];
 	__u8   iProcessing;
+	__u8   bmVideoStandards;
 } __attribute__((__packed__));
 
-#define UVC_DT_PROCESSING_UNIT_SIZE(n)			(9+(n))
+#define UVC_DT_PROCESSING_UNIT_SIZE(n)			(10+(n))
 
 /* 3.7.2.6. Extension Unit Descriptor */
 struct uvc_extension_unit_descriptor {
-- 
2.25.1


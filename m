Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D19D933ABDF
	for <lists+linux-api@lfdr.de>; Mon, 15 Mar 2021 08:01:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbhCOHAm (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 15 Mar 2021 03:00:42 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:62558 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229807AbhCOHAW (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 15 Mar 2021 03:00:22 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12F6wSQY013210;
        Mon, 15 Mar 2021 00:00:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=proofpoint;
 bh=MV5ouADjwoaoJMEFIVm7nYVKyknhi2cn/2l02gBFhY4=;
 b=a7OBFUJIyHQZEuVDS4vY6xrbSoNYWpXXsIgxV+F09oGrWwudgF2+P2y43yprlc8BIQtN
 jYVNKwE0x1ZQ0Ppft6cSIJc3ACOsjioAwtru1YCw/XJvZ8lgeMSpDmKHBpwaiYBDwBxO
 mtZYVfy5wbCZETo/R0gXMrSYvHdUqtj3Nq/YgsDBDfQ+CLnjFgBzGKBPq7jkoO2Yt/A/
 aG/C24jIsUvDiiw/VJfCwW7uwU8urHEvPXMwyVCQFTzAojWTc4GMZXFQ705wHI2u//hj
 ZLDXxAJUZ6bwaYO/OunzNQ9HUlGdUH5kSq61c2U0vW1GRo/ynQhle5/0S1cc6FmeG0Hl VA== 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2102.outbound.protection.outlook.com [104.47.55.102])
        by mx0a-0014ca01.pphosted.com with ESMTP id 378tu1vk35-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 Mar 2021 00:00:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CNDcpG5AJZWqai6GeC6yr5Ky/1FBRUotyEKC2N6ehCm+vaj6kdds0a+5KCyx3Z/BHlhHkHKZxEyaJ/LUFztp6/DqWuj0nFeeZLdnIoUVHV14BxjS/JJ8ds/p/qelLR2F1NDdhtGdhiTh1OmZzSmMam1U7kjKwQyBPGciDYcZ2RPMCVmPnZ6AADCp0O9qt0+wjBEOCHZZ0Uu3rXvN669z4JOWTHqS/vIcWexo/nx5YitaEGep9mNHhhEmMVO1kcQWjCR+9/jzLr/Jr71h87+6lasoJamJ4Cwl+WysD7skBPGArL/mmjCepj5H9NZc1EOBE0K4Z7OD2AwPx7wBPVS97A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MV5ouADjwoaoJMEFIVm7nYVKyknhi2cn/2l02gBFhY4=;
 b=QJ+Nv5RFVTEGdtsLvIAkUmcBuaYnyISq5Wzglw7VE0hU+cQPYPRrT1c2fAe2yP6sCXyUzaXDww1V3qFDZkqdIsnT3dOAHPktbIRnhDbZFD8sUZUVfv7PmZngWOhmTYJtXy6aZIWmrgSJO3qHFw63zdT0pjNK+ztYNiaHj73iztHsiYVCYTYWU6BxC++ZKDVkpdFcJwCTH2smFnTeJEi/qdg/04mgtrvkIN9JJchlEXwxXdAn0Rb5SCnPDATCvNNjAeN4/Gcp/o3HzAeoWsdv9Mx2Tx2FVZWnEIUy4XgiuPHdp7Rz5GqNJjtWSj6zE47xcWcqQOe5L9nE96vnFVljDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 158.140.1.147) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MV5ouADjwoaoJMEFIVm7nYVKyknhi2cn/2l02gBFhY4=;
 b=epV9AB6w/kpGa1dCB4ThlwtwD7oHGG9ThRWZKTu/bHVk/ciw65VSm4CpnStaawOgdUdW3BA+URNnD+NEjK0ppyY1jkDefqi4Th7iyA+RQQbgYiu/qH4BAOeaYLwbkTT2StxK3a/bCpyAUc58fbbVVKCCqTw1no6pEVe/Wkp3c+8=
Received: from CO2PR18CA0061.namprd18.prod.outlook.com (2603:10b6:104:2::29)
 by SN6PR07MB5230.namprd07.prod.outlook.com (2603:10b6:805:a9::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Mon, 15 Mar
 2021 07:00:14 +0000
Received: from MW2NAM12FT030.eop-nam12.prod.protection.outlook.com
 (2603:10b6:104:2:cafe::be) by CO2PR18CA0061.outlook.office365.com
 (2603:10b6:104:2::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.31 via Frontend
 Transport; Mon, 15 Mar 2021 07:00:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 158.140.1.147)
 smtp.mailfrom=cadence.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none
 header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 158.140.1.147 as permitted sender) receiver=protection.outlook.com;
 client-ip=158.140.1.147; helo=sjmaillnx1.cadence.com;
Received: from sjmaillnx1.cadence.com (158.140.1.147) by
 MW2NAM12FT030.mail.protection.outlook.com (10.13.181.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3955.9 via Frontend Transport; Mon, 15 Mar 2021 07:00:13 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 12F70B4T030261
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Mar 2021 00:00:12 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 15 Mar 2021 08:00:11 +0100
Received: from gli-login.cadence.com (10.187.128.100) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Mon, 15 Mar 2021 08:00:10 +0100
Received: from gli-login.cadence.com (localhost [127.0.0.1])
        by gli-login.cadence.com (8.14.4/8.14.4) with ESMTP id 12F70A1p032479;
        Mon, 15 Mar 2021 08:00:10 +0100
Received: (from pawell@localhost)
        by gli-login.cadence.com (8.14.4/8.14.4/Submit) id 12F70A7U032455;
        Mon, 15 Mar 2021 08:00:10 +0100
From:   Pawel Laszczak <pawell@cadence.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>
CC:     <linux-api@vger.kernel.org>, <laurent.pinchart@ideasonboard.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <peter.chen@kernel.org>, <kurahul@cadence.com>,
        Pawel Laszczak <pawell@cadence.com>
Subject: [PATCH v2 1/2] usb: gadget: uvc: Updating bcdUVC field to 0x0110
Date:   Mon, 15 Mar 2021 07:59:25 +0100
Message-ID: <20210315065926.30152-1-pawell@gli-login.cadence.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f3c9ed4f-a532-4f92-17db-08d8e77ffb90
X-MS-TrafficTypeDiagnostic: SN6PR07MB5230:
X-Microsoft-Antispam-PRVS: <SN6PR07MB5230E3C66277FB43951CCD9BDD6C9@SN6PR07MB5230.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:330;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FIwbShHf7F0H/LHJgLzntroD8YKIyxzArjWxDTznQXK3uo7IJLA+n4OXBqMjjHfHqQBKgmeXaZvr18XLH/VbwDCRsUGLMn3wpb0bea12n6dj4TZiDUda/9YjOJ2B9f+B55fQu0JSajCKV15jSBDNNHWdFcfBPqKHoa7/IuFPZEnM23Vy4mACUK8Pdv5KU8i0iQ+tH+0fFP6p5UWuZ3eIrFfyE31r/mUWqa57IQXWZb9Xux6guIrMUydYxAw8UOCfGhEVaUup0IDxXv0XG+smpSDdk6gkH/HFfuKd7GrOd25iyWIRhqWUnq8/XZSL+GSlbftbqUUoFYWvmq/15lU0KgOltcFq/8GT9gVfmhk4i61mhFCL/k6kmGOJUJRXeTonEok0rYgqoRieTs+WNYO8KFbDK5doNpZJ7o2Qt7oRNNzTuImBWEoUDdvI9DYPlwDKAxfS2FGH1cuI14gIbd+6bvV4bMgVqrap4ceEMTx2F6Qby8dpR/Q2OT9yC13lJx0FJwiKJNGVkCaBYi4/MBfCdVy8m/2gQ2+4dgYAPUUcqBzoOlth2LmBwulYzoygBSq/8lFBYgN7McSqvEvjr4En4devK9cs+/GmTNfcPr9SKHL4eGDvAOwHHoSb9HotBssuUdpDJOYYqPHE4aQN6mH3csS/e5Paa5spWoG00+CXSWfS5qAbbeDtcFHyZFYvni8f
X-Forefront-Antispam-Report: CIP:158.140.1.147;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:sjmaillnx1.cadence.com;PTR:unknown.Cadence.COM;CAT:NONE;SFS:(4636009)(346002)(136003)(376002)(396003)(39860400002)(36092001)(46966006)(36840700001)(316002)(107886003)(83380400001)(82310400003)(82740400003)(7636003)(8936002)(1076003)(426003)(336012)(356005)(86362001)(36860700001)(66574015)(6666004)(47076005)(2906002)(5660300002)(70586007)(4326008)(36906005)(70206006)(110136005)(42186006)(478600001)(186003)(26005)(8676002)(54906003);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2021 07:00:13.9682
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f3c9ed4f-a532-4f92-17db-08d8e77ffb90
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.147];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: MW2NAM12FT030.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR07MB5230
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-15_01:2021-03-15,2021-03-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 adultscore=0
 priorityscore=1501 bulkscore=0 phishscore=0 clxscore=1015
 lowpriorityscore=0 malwarescore=0 spamscore=0 suspectscore=0
 impostorscore=0 mlxscore=0 mlxlogscore=709 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103150047
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

From: Pawel Laszczak <pawell@cadence.com>

Command Verifier during UVC Descriptor Tests (Class Video Control
Interface Descriptor Test Video) complains about:

Video Control Interface Header bcdUVC is 0x0100. USB Video Class
specification 1.0 has been replaced by 1.1 specification
(UVC: 6.2.26) Class Video Control Interface Descriptor bcdUVC is not 1.1

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Pawel Laszczak <pawell@cadence.com>

---
Changlog:
v2:
- fixed typo in commit message

 drivers/usb/gadget/function/uvc_configfs.c | 2 +-
 drivers/usb/gadget/legacy/webcam.c         | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/gadget/function/uvc_configfs.c b/drivers/usb/gadget/function/uvc_configfs.c
index 00fb58e50a15..cd28dec837dd 100644
--- a/drivers/usb/gadget/function/uvc_configfs.c
+++ b/drivers/usb/gadget/function/uvc_configfs.c
@@ -231,7 +231,7 @@ static struct config_item *uvcg_control_header_make(struct config_group *group,
 	h->desc.bLength			= UVC_DT_HEADER_SIZE(1);
 	h->desc.bDescriptorType		= USB_DT_CS_INTERFACE;
 	h->desc.bDescriptorSubType	= UVC_VC_HEADER;
-	h->desc.bcdUVC			= cpu_to_le16(0x0100);
+	h->desc.bcdUVC			= cpu_to_le16(0x0110);
 	h->desc.dwClockFrequency	= cpu_to_le32(48000000);
 
 	config_item_init_type_name(&h->item, name, &uvcg_control_header_type);
diff --git a/drivers/usb/gadget/legacy/webcam.c b/drivers/usb/gadget/legacy/webcam.c
index a9f8eb8e1c76..3a61de4bb2b1 100644
--- a/drivers/usb/gadget/legacy/webcam.c
+++ b/drivers/usb/gadget/legacy/webcam.c
@@ -90,7 +90,7 @@ static const struct UVC_HEADER_DESCRIPTOR(1) uvc_control_header = {
 	.bLength		= UVC_DT_HEADER_SIZE(1),
 	.bDescriptorType	= USB_DT_CS_INTERFACE,
 	.bDescriptorSubType	= UVC_VC_HEADER,
-	.bcdUVC			= cpu_to_le16(0x0100),
+	.bcdUVC			= cpu_to_le16(0x0110),
 	.wTotalLength		= 0, /* dynamic */
 	.dwClockFrequency	= cpu_to_le32(48000000),
 	.bInCollection		= 0, /* dynamic */
-- 
2.25.1


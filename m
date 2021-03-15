Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C731333AC1B
	for <lists+linux-api@lfdr.de>; Mon, 15 Mar 2021 08:18:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbhCOHSR (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 15 Mar 2021 03:18:17 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:11796 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230004AbhCOHSM (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 15 Mar 2021 03:18:12 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12F79QEq024736;
        Mon, 15 Mar 2021 00:18:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=proofpoint;
 bh=M7wadDaEHidsJyEHp+q6ZqmQRy0O+jzAsF5IOXVPc0Y=;
 b=KOLEhQQLV3AZdfP+hiDyiTIRiyeWwTb4g9QU9ESaoPHt30r2bGuTQKmS5QHx3hS08CZs
 TY3o3UXlwSOZiX85mThsou5UcPIXDZWvmkDvSkT8cTxmvdbNWZ7MO7nUNNV8Fp+z5oKE
 Z+LXwCYXvrkz5WEuB7LCr/z/mPd1GG/GmNRFYkZaXJdthCcB/zqSFfG2xfvUxLJZjw6/
 ySZcDMYKk8B1uiZEFay7n6fOJjRNwBK2BaTYDewJl/Q8zsizabOY3BGDSUeqIPhmJ1/U
 EnT87W08r+JSG48Yoq0RmqQ3PF2Ujkz04rkQeLmxh512JZ/axupSyzob6lOGI6rt8IxG DA== 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
        by mx0b-0014ca01.pphosted.com with ESMTP id 378sv2d2kw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 Mar 2021 00:18:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CW6pQnJwTE1XlKKtC60B1/YjEhb/kC9RCXFxk7BvT0o55AhtGA5jhYAPMQgVez9ltbU6AnLHwWid5YXaSwy4pNtq2WbQ1Z8U/N8kMT19jQIqvckwtn+y32bOVGwXwDEjIFeV3n0gHkbpE7XareWjHsWyrBlB1mHE5gAPj31aDGCYL8VwvAvfakgLtwuWkNTPw5eRXtG9LTycxZW4fNBJejALdgz61KQveVLgBnZALlgy5QILUe0fvPUy70zFm9LYWF1LlFY7HwxIqm+bKMK979DKqui/7BqEaXcCryGGKYHrC9cl3slrdihH4WmaAhE1SiyLPbrsVNB2E12v8H35dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M7wadDaEHidsJyEHp+q6ZqmQRy0O+jzAsF5IOXVPc0Y=;
 b=ltJwBgKr0XKWXNYmhjhv3J0jp4jHC+9AKWaKquR9WmrfCxilVEDeW3LPhQnioyhrxNfDKCvb9JTAtmrIN0DiM9FTreAQsmj5zFsSw4Z+nbBby2X4htnxZIwAIvR/VrONl3sinZloT6SMBk83Os3Y0yM4Aj8zWAe837xfR1gnPeSBMXbFxTHJFyOcVti3veQIDhUEOBdw4/agInEI2uLCZ+XqA5ySXrRTTacS96Edbho/X3SiRJR3GLepvCY+8yoKK5g+ZIKDFmc72ZSpggxhuJ9rMem/JPZvYfyG3GIVmkRAJVrsutBDSeYf6WLpVufIu0wXIu1FpKBivHKxNzRf0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 158.140.1.148) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M7wadDaEHidsJyEHp+q6ZqmQRy0O+jzAsF5IOXVPc0Y=;
 b=3MX4S0WUTAARK3yEx08VgMAKBnx95y9qb8jEQgotj7T5xllm2q7+1MFmMgtUuIl4VFIjQkOlJ5H8D0daF92qaZr8+6PUgsrZ/mGLBYVm4sGuf3nLzEO8plFYMONIVwusEjpD16aM5BhlMcPbfA0qlw3cKCvXEBy2vZg94PDWrbs=
Received: from MWHPR04CA0054.namprd04.prod.outlook.com (2603:10b6:300:6c::16)
 by CY4PR07MB3013.namprd07.prod.outlook.com (2603:10b6:903:cf::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Mon, 15 Mar
 2021 07:18:05 +0000
Received: from MW2NAM12FT068.eop-nam12.prod.protection.outlook.com
 (2603:10b6:300:6c:cafe::b5) by MWHPR04CA0054.outlook.office365.com
 (2603:10b6:300:6c::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.31 via Frontend
 Transport; Mon, 15 Mar 2021 07:18:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 158.140.1.148)
 smtp.mailfrom=cadence.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none
 header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 158.140.1.148 as permitted sender) receiver=protection.outlook.com;
 client-ip=158.140.1.148; helo=sjmaillnx2.cadence.com;
Received: from sjmaillnx2.cadence.com (158.140.1.148) by
 MW2NAM12FT068.mail.protection.outlook.com (10.13.181.184) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3955.9 via Frontend Transport; Mon, 15 Mar 2021 07:18:04 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx2.cadence.com (8.14.4/8.14.4) with ESMTP id 12F7I22K023567
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Mar 2021 00:18:04 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 15 Mar 2021 08:18:02 +0100
Received: from gli-login.cadence.com (10.187.128.100) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Mon, 15 Mar 2021 08:18:02 +0100
Received: from gli-login.cadence.com (localhost [127.0.0.1])
        by gli-login.cadence.com (8.14.4/8.14.4) with ESMTP id 12F7I1er030327;
        Mon, 15 Mar 2021 08:18:01 +0100
Received: (from pawell@localhost)
        by gli-login.cadence.com (8.14.4/8.14.4/Submit) id 12F7I1Qs030326;
        Mon, 15 Mar 2021 08:18:01 +0100
From:   Pawel Laszczak <pawell@cadence.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>
CC:     <linux-api@vger.kernel.org>, <laurent.pinchart@ideasonboard.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <peter.chen@kernel.org>, <kurahul@cadence.com>,
        Pawel Laszczak <pawell@cadence.com>
Subject: [PATCH v4 2/2] usb: webcam: Invalid size of Processing Unit Descriptor
Date:   Mon, 15 Mar 2021 08:17:48 +0100
Message-ID: <20210315071748.29706-1-pawell@gli-login.cadence.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 66468f36-7af9-4184-a7a9-08d8e78279da
X-MS-TrafficTypeDiagnostic: CY4PR07MB3013:
X-Microsoft-Antispam-PRVS: <CY4PR07MB3013D7A7289593C7DC1271DEDD6C9@CY4PR07MB3013.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1060;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RyeXhtDSd4yPgcKgWNgPN/TRq9IPRS4zJtUlDafHeNPNE+Qh5oFUhhTHEIzya+izZvTBYJLW744nKYmQXNe0fZbUTsovgD+fS9m9kuSxfLKEyVjHyrkrqhzy2nQGPRKMzM6lwXeSSrpb6QXzBUB2Y0rsHV0M/wtiIvwm1/GpsSJpm7DVHjg4HgGemdKDtJ6hW/cXGeFaPd/6S4AYB9guCvITnSLGi0cRpa8Ms2ixd32vlTcOJmAoh6dVBZXCmgKooMUCxdxr5huxbeC3PN6ISOQ19JIqgUqR5wkQjEZyz7z1Namgav8Pcmp25UNukDs2WdN0Cw/u0otOrIzuG5tbco6oP4HjoGVr0MSy6qntw2GPieXcjh4gjVyg0KGt9XBygA+gv3CEAL2GuOY2IiYuspt8PplzeaeH/UMG/Khxwoc9h9egu69iiGH5SH3ZifIlbAn8NT+uoxPi4R//avZlceWMQTkHip2Ja+oYmj2fPmDsVGKYzxVc0yAPzTFXyH1TRxjwIx7pgGAjucbnYj8jQ4SSnsSR3u493iAsZuTKqUMsz91JSrqh0D9wbGITTJWQmhmfsoEZ60I1mtI0XVuwjSUwSUqpZFJIZLskFjKmrhD01sU80xSocRRrNBxsHSfcgHbe0xBBZOvJwd6vgZHkcfSIwmn9Yem+8dGpCm1ncX7ErlL9yeaGSoh/baYxWGru
X-Forefront-Antispam-Report: CIP:158.140.1.148;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:sjmaillnx2.cadence.com;PTR:unknown.Cadence.COM;CAT:NONE;SFS:(4636009)(346002)(136003)(39860400002)(396003)(376002)(36092001)(36840700001)(46966006)(426003)(186003)(54906003)(83380400001)(110136005)(42186006)(47076005)(8676002)(8936002)(336012)(82310400003)(86362001)(1076003)(26005)(6666004)(316002)(5660300002)(107886003)(70206006)(70586007)(36906005)(66574015)(478600001)(356005)(2906002)(36860700001)(7636003)(4326008)(82740400003);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2021 07:18:04.8443
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 66468f36-7af9-4184-a7a9-08d8e78279da
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.148];Helo=[sjmaillnx2.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: MW2NAM12FT068.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR07MB3013
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-15_01:2021-03-15,2021-03-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 phishscore=0
 mlxlogscore=922 priorityscore=1501 bulkscore=0 impostorscore=0 spamscore=0
 adultscore=8 malwarescore=0 suspectscore=0 mlxscore=0 lowpriorityscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103150049
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
v4:
- fixed compilation error caused by v2
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
+	.bmVideoStandards	= 0,
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


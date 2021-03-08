Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 240EB330B19
	for <lists+linux-api@lfdr.de>; Mon,  8 Mar 2021 11:29:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230342AbhCHK2u (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 8 Mar 2021 05:28:50 -0500
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:32988 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230111AbhCHK20 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 8 Mar 2021 05:28:26 -0500
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 128AJxKo026495;
        Mon, 8 Mar 2021 02:28:22 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=proofpoint;
 bh=27BXUSSZ/MHaVEuVakHQqwXwUOGeLmhTJpuje4Et+4k=;
 b=h8jA4VLABypv2avnLkFcmyXrIfNwFTnNGuJpZs+GpE2/OVStEbF0G2/+QNyNb3OGDhXN
 Wks8DDKtH2KsfhBxFfXOy22tP3Fh6fP2sU2JO8thHsSLNpDZy7pqTZhKgmijfBg4EocO
 UeJ6zmAZ8DPQ3bVIKwOB6jxDKlQFl2Qz6+nE4bcYSRvpfcDjI271yvS3941+Wu0QjiZb
 Tp9W3w/d25ATUubTgt/HDi2A/ZM5cAxqomzqLsk07SJXidhVzT66qEKey6vw2xfP47/g
 MtFBKLcKUJC1USUtDrR2Q4R2arP73cFqntZNN7F/CLTLGSC+idbf8bn6ZkZBO8TlFYiW 6g== 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2103.outbound.protection.outlook.com [104.47.70.103])
        by mx0b-0014ca01.pphosted.com with ESMTP id 374674vuuj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 Mar 2021 02:28:22 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UzXhka+JO9RhMOfRpKZgttDQofJrvwkKnFQw8g/p3UKOHfDefQhDAT9hFbx8yga2Ayz4a2V0JjQE6uyQVEvOZXzwkC5ySR6H69d5btu/u2BWlSFPCQKrhh3DWBjWknfp+T0OXZZpE1aOzgNHXD1/9MtKRIuB7fhdEKxeuCBNjg3NDjDFhvk+FKjJaffAtxgl5AGTTsBAOyvB5Xy/lXsw+z+Qpukes23YvMnFtPM6UTyrm+E51tvglocg9fYMHv6JD+8/LmAZSrsfm7gP1satb+K+MkowcUhzsurOq+HG3OEx/QSlTLre+WbJj3op9NY+K1NKko0nOFgDuCP9PAKASw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=27BXUSSZ/MHaVEuVakHQqwXwUOGeLmhTJpuje4Et+4k=;
 b=n0/Vho2FCKSuCtPOuXGkSwjJMUxrGZRrEGjdjwHGsHLD/uDNHrynxADMtTLHyYGmZT/Yohd/bCetVGGYO/7En54qz6cgcxN73GWpwXA3xyowaLZSJe4MR7224CChzlctCKKxKWCd7OW50VkK87WO33AWRtaPfyDVOvHGk6LFGxb6vqeXKFUptv5mZpAbc3z0fIxM/QHg2f6S/BSnk45TT60BU0J4e2XHMmCbLrU2S8rxe58zqkX/aIF3cc09d1pFNr2dE/H+VFS3G4uFb6XzPbAWnISwV3yPitZVqTba5vsKrA46Qm/IlQ+lghBVgSYiZkIHGgvr0npvGi2BDE1Seg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 158.140.1.148) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=27BXUSSZ/MHaVEuVakHQqwXwUOGeLmhTJpuje4Et+4k=;
 b=H05pehvn1JJFa8L58MOKMB4BZMbwJcH9XnQVXvl8LMKmfRQ45RJixnYWSPmu2uOU9i8lj4V2jTJdAsOZWqLDNu4EhLqiuf5UKi8bZ9zJZ5KT1hiQzuxDmFrOg297UJH9/HjsNTMX0vrk2MlyDCInxtvlqfdbB4Ttp5Uuirk1AlQ=
Received: from DM6PR03CA0014.namprd03.prod.outlook.com (2603:10b6:5:40::27) by
 BN8PR07MB6210.namprd07.prod.outlook.com (2603:10b6:408:b5::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3890.23; Mon, 8 Mar 2021 10:28:20 +0000
Received: from DM6NAM12FT061.eop-nam12.prod.protection.outlook.com
 (2603:10b6:5:40:cafe::a4) by DM6PR03CA0014.outlook.office365.com
 (2603:10b6:5:40::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend
 Transport; Mon, 8 Mar 2021 10:28:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 158.140.1.148)
 smtp.mailfrom=cadence.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none
 header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 158.140.1.148 as permitted sender) receiver=protection.outlook.com;
 client-ip=158.140.1.148; helo=sjmaillnx2.cadence.com;
Received: from sjmaillnx2.cadence.com (158.140.1.148) by
 DM6NAM12FT061.mail.protection.outlook.com (10.13.179.123) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3933.16 via Frontend Transport; Mon, 8 Mar 2021 10:28:20 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx2.cadence.com (8.14.4/8.14.4) with ESMTP id 128ASHYS028203
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 8 Mar 2021 02:28:19 -0800
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 8 Mar 2021 11:28:04 +0100
Received: from gli-login.cadence.com (10.187.128.100) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Mon, 8 Mar 2021 11:28:04 +0100
Received: from gli-login.cadence.com (localhost [127.0.0.1])
        by gli-login.cadence.com (8.14.4/8.14.4) with ESMTP id 128AS4ZG010553;
        Mon, 8 Mar 2021 11:28:04 +0100
Received: (from pawell@localhost)
        by gli-login.cadence.com (8.14.4/8.14.4/Submit) id 128AS3qo010552;
        Mon, 8 Mar 2021 11:28:03 +0100
From:   Pawel Laszczak <pawell@cadence.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>
CC:     <linux-api@vger.kernel.org>, <laurent.pinchart@ideasonboard.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <peter.chen@kernel.org>, <kurahul@cadence.com>,
        Pawel Laszczak <pawell@cadence.com>
Subject: [PATCH 1/2] usb: gadget: uvc: Updating bcdUVC field to 0x0110
Date:   Mon, 8 Mar 2021 11:27:34 +0100
Message-ID: <20210308102735.9251-1-pawell@gli-login.cadence.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 06c91725-f93a-4cf8-1a74-08d8e21ce52c
X-MS-TrafficTypeDiagnostic: BN8PR07MB6210:
X-Microsoft-Antispam-PRVS: <BN8PR07MB6210026926D21C544B284DB5DD939@BN8PR07MB6210.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1107;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XSctOznHGEt6CNnnsppR9i417+YiBkdZeQrxvlXtYHOLDHcXEOEAORQZ8HkmgR6dbgODHx3buJkc0BXcW3m1GJbhldp4TFTGgCEnM9zi93GiWvb/i3UTvOk4b41e+hTcO3XSM8uv0atDe7AfanKQMjbbr7EAoz/G+4rpdMQYh2dlhQTL8ANOuLKNhtcweeKUQ7X1McyqUv9Uu6hIdfXGUaTzEez24TeDd4t/EAGjdSf9lfcdqgQWytyWSZtTI1t6pSeAjBtoDgNS7RI004b0SCZ66TTYHnmU/48AZ8jW6cdOuiPaGBuhTZN/KBhW7ZmPDdb7GhEivZl6RbFQUyuN7mJKXKCyT36Zs1Kb2zz0XVgCgjUR8cXdUrLKfvm0daQ9KeJvToAUKS2Wvb1oqKtLTZSm4qBxH3m0Xornyg6W/XbGnFrXP2rRtcyB0KuFHmuRqzVQvEatQ2UfP0r87hymIzwYheqSbnf+Ph5S+OcQ0uWs6zXCb3l62+IslSA3naZ+wFiQhhIhraX9B2LcSipfEf81SNBRibI/RN71aALpTist2VU3nLqhxvWb/nxJ+qNbX6TaEDR7+uyX3g7bh2P2dcbf9mtLL4W5NnpkLK/+OzCMrm2GGzKU7hpoCTz4PObNpV24t88kvo63aLUEiUfBueRdhFJDErFyudZ78vGYut8uoOzigGuPEB4dcHNi4ZO/
X-Forefront-Antispam-Report: CIP:158.140.1.148;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:sjmaillnx2.cadence.com;PTR:unknown.Cadence.COM;CAT:NONE;SFS:(4636009)(346002)(136003)(376002)(39860400002)(396003)(36092001)(36840700001)(46966006)(66574015)(356005)(426003)(478600001)(316002)(336012)(47076005)(82740400003)(8936002)(8676002)(2906002)(70206006)(36860700001)(7636003)(5660300002)(186003)(83380400001)(54906003)(26005)(4326008)(110136005)(86362001)(82310400003)(6666004)(70586007)(1076003)(107886003)(42186006)(36906005);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2021 10:28:20.3740
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 06c91725-f93a-4cf8-1a74-08d8e21ce52c
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.148];Helo=[sjmaillnx2.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM12FT061.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR07MB6210
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-08_04:2021-03-08,2021-03-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 suspectscore=0
 phishscore=0 clxscore=1015 bulkscore=0 impostorscore=0 priorityscore=1501
 spamscore=0 malwarescore=0 lowpriorityscore=0 mlxlogscore=654 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103080054
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

From: Pawel Laszczak <pawell@cadence.com>

Command Verifier during UVC Descriptor Tests (Class Video Control
Interface Descriptor Test Video) compleins about:

Video Control Interface Header bcdUVC is 0x0100. USB Video Class
specification 1.0 has been replaced by 1.1 specification
(UVC: 6.2.26) Class Video Control Interface Descriptor bcdUVC is not 1.1

Signed-off-by: Pawel Laszczak <pawell@cadence.com>
---
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


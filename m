Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EDED333483
	for <lists+linux-api@lfdr.de>; Wed, 10 Mar 2021 05:47:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232339AbhCJErK (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 9 Mar 2021 23:47:10 -0500
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:4816 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230198AbhCJEqy (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 9 Mar 2021 23:46:54 -0500
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12A4iKa9027090;
        Tue, 9 Mar 2021 20:46:44 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=proofpoint;
 bh=pZnA7WSOuV0jUYGP53mm6b4vhFrmY5biDNstAinwM+w=;
 b=PxYIkSUykDWLqfLcV46rhzaePC7DtRpSocFqt14TqQU/tXc6SoARH20pQCingAISMHoP
 BJnOMsm47DOo0gK/e/oBPC+SwbFdjff9O8oK4lZKt1xCdK/5XjPfDdvNMu1D+eOuv1XN
 RyZHgm+KUGZSm50GnVtQozU08CZkw3agMIqJdpHzriPOmrWheCbwuDuucoIP2aUS2EXY
 Snpu0/C75Q1ilqmhwJmwZ+t4854s4SPi+p/yIRwuPWxwUn8ag+L9lRqvNXsHF6jGFa6V
 SRAtkD9x86bIgJt9f1Cj+pJofxLIJq1JDLVMI0b4/04BA7RJr5L1GTvcGQxfQLYK92oS EA== 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
        by mx0b-0014ca01.pphosted.com with ESMTP id 3746753etu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 Mar 2021 20:46:44 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OdPTxoHDGPPGQESdyLpTSKbWtgkn+PeCrJwxMQX20NPw9ViDImO1sUClp+7koLASj7yGfKBn0uEPhUXNWWMwvzr+AtnPC33BtMCGh3fnXNIgFIMzHWRKaZ0DBeeXXWNT/tANEL51AaeXpxb8f6qKl4NDwx0mtSWjEI//JOOgcchcSrW9BHFMRU4S+wwhfJ77te1K2O80TiRfTSepR+WU/NeuzLd9KTHDrTyIEkyzA6DvMws+zhjEB9JLWtqG+SfjvxpZcUMuPcWAlq0JtRpL2lXCIFxM8DYHIERtoZlTQNbeKBym3Z5Nrtobf7wMjY9LQipqUtemjo+dwcZ9mnHw0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pZnA7WSOuV0jUYGP53mm6b4vhFrmY5biDNstAinwM+w=;
 b=LKoDkDVfymaUshy3i7J203guGy6/ZVVc3ZL+ReneyTrrz4KalPTGJkQjVOxlPwB97FSWX3JWc3xkIwPBrFd2ZoFidnL99R1Ywuq7dHud2THYZci0Leyr5IF3CJ9EQKQ+WeQKlAX90LIZuk28C+04f+zPCnon8HJccEs0jYM7uGHoKUldEuoVxVZ2qfvRYgly4ZlHm4lf7iVn3YXiLzbnB3y95lVM1pg9CqDpV+kL7Xaetyr4BPy+KxGd0rTe51MO+6uoQ+YVQQPiezHjNgkAOoZUUD5yx92+QejEtYWJb8MaXPQ2k+n7yAtNOFSK0nRO87RDeQ8nV+okTzT42qQw2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 199.43.4.23) smtp.rcpttodomain=kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pZnA7WSOuV0jUYGP53mm6b4vhFrmY5biDNstAinwM+w=;
 b=JKt044vhSiXtpLVZYA5rRuOazi7mRkBoHmyWR6PPMxCXkxB+faG4Fj9V19KARvlLsjB0bAXgFtWiHzLoAfETH9iwisHzWMCFF34RZODrHbmkjCxsyjzmgNECf8mTMoXfgypGjYSdHi11c3jmLKM7joDGUG8Ktoaiul/bbFf4tPU=
Received: from DM6PR07CA0102.namprd07.prod.outlook.com (2603:10b6:5:337::35)
 by SN6PR07MB4958.namprd07.prod.outlook.com (2603:10b6:805:a4::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Wed, 10 Mar
 2021 04:46:41 +0000
Received: from DM6NAM12FT019.eop-nam12.prod.protection.outlook.com
 (2603:10b6:5:337:cafe::e8) by DM6PR07CA0102.outlook.office365.com
 (2603:10b6:5:337::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend
 Transport; Wed, 10 Mar 2021 04:46:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 199.43.4.23)
 smtp.mailfrom=cadence.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 199.43.4.23 as permitted sender) receiver=protection.outlook.com;
 client-ip=199.43.4.23; helo=rmmaillnx1.cadence.com;
Received: from rmmaillnx1.cadence.com (199.43.4.23) by
 DM6NAM12FT019.mail.protection.outlook.com (10.13.178.84) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3933.16 via Frontend Transport; Wed, 10 Mar 2021 04:46:41 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by rmmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 12A4kcgG025556
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 9 Mar 2021 23:46:40 -0500
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 10 Mar 2021 05:46:25 +0100
Received: from gli-login.cadence.com (10.187.128.100) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Wed, 10 Mar 2021 05:46:25 +0100
Received: from gli-login.cadence.com (localhost [127.0.0.1])
        by gli-login.cadence.com (8.14.4/8.14.4) with ESMTP id 12A4kPcJ006026;
        Wed, 10 Mar 2021 05:46:25 +0100
Received: (from pawell@localhost)
        by gli-login.cadence.com (8.14.4/8.14.4/Submit) id 12A4kOBC005936;
        Wed, 10 Mar 2021 05:46:24 +0100
From:   Pawel Laszczak <pawell@cadence.com>
To:     <linux-api@vger.kernel.org>, <gregkh@linuxfoundation.org>
CC:     <balbi@kernel.org>, <laurent.pinchart@ideasonboard.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <peter.chen@kernel.org>, <kurahul@cadence.com>,
        Pawel Laszczak <pawell@cadence.com>
Subject: [PATCH v2 2/2] usb: webcam: Invalid size of Processing Unit Descriptor
Date:   Wed, 10 Mar 2021 05:45:40 +0100
Message-ID: <20210310044540.4088-1-pawell@gli-login.cadence.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4e431c9d-f30d-4e27-3aad-08d8e37f7faa
X-MS-TrafficTypeDiagnostic: SN6PR07MB4958:
X-Microsoft-Antispam-PRVS: <SN6PR07MB49581A2CEA7E64BAB4C3630FDD919@SN6PR07MB4958.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PVGetPBVGXtWQkoiZXsd+3K7TKN4v1gcFo9umS3pWR0T5Oc0itc408LEAZABQXiFCxCIYSzKXc66zBJqSo1/JtCQClLoDzUbinGxDbWvMRG2dINrBJZSlLBVJOwXpt+8EZ36L14+Nss2kLt6+ByHAW6jYg6pezTxrtKBlsy0nUAQlm2Hk3BQU+C2taFIouaQOSpna1o9c+Za7dRboW7id3V5U/TDyyjFER5mGnNxJmxYrOTz4IW3XlFjuTFkN6+gHbFSpn9moMuUilKURrtovaEkV2Lghdrm2Gd0nCWztDCW81r3jTW2IucA8Xw1feT4tLckEPI9qg4qMFTznIfSjtw8Guozi/y6dpfb5XzXVmub0JlN3rniHY0PxfmgpULAWaXLt3w6yinVXRXJ7RuJfUeK8kk74+aaKjp+N7dMJYgN/YPjqZWHMS0pb+QiAHk4YqvR88IH2mGl71QiK7kigqvYmGKBbK/JfM3ZkHYbgdDPGsu4Lm/g8Kh62H/1kBK2NIGPn+8AszSeIo2prHvMoUPXjkn2+anrWBPq0TxZvyJlAz7s1XNPTYMigu8gx0Ta4drKWFuq6h26148/S1nwJCsKyxtKPwtyyWEgmr2zmoCQgcyQRi4QIKmUv4Jgyc8a55QpYbVf5k2omL4weXKpo50il4L6kaAv7tjDiLly0AUqVBo4fzuNE0b3ie47zm8dIgywHqZQbn9OMLJX4nXCHg==
X-Forefront-Antispam-Report: CIP:199.43.4.23;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:rmmaillnx1.cadence.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(346002)(136003)(39860400002)(376002)(396003)(36092001)(36840700001)(46966006)(8676002)(86362001)(5660300002)(426003)(81166007)(316002)(70586007)(42186006)(2906002)(47076005)(6666004)(110136005)(54906003)(186003)(8936002)(336012)(478600001)(4326008)(70206006)(36906005)(1076003)(26005)(356005)(36860700001)(82310400003)(83380400001)(82740400003)(107886003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2021 04:46:41.4299
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e431c9d-f30d-4e27-3aad-08d8e37f7faa
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[199.43.4.23];Helo=[rmmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM12FT019.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR07MB4958
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-10_03:2021-03-09,2021-03-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 suspectscore=0
 phishscore=0 clxscore=1015 bulkscore=0 impostorscore=0 priorityscore=1501
 spamscore=0 malwarescore=0 lowpriorityscore=0 mlxlogscore=762 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103100022
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

Signed-off-by: Pawel Laszczak <pawell@cadence.com>
---
Changelog:
v2:
- updated UVC_DT_PROCESSING_UNIT_SIZE macro

 include/uapi/linux/usb/video.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

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


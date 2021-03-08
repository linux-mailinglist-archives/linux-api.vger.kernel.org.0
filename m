Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 352F2330B16
	for <lists+linux-api@lfdr.de>; Mon,  8 Mar 2021 11:29:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230135AbhCHK2t (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 8 Mar 2021 05:28:49 -0500
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:8490 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230126AbhCHK2R (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 8 Mar 2021 05:28:17 -0500
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 128AK7PN027437;
        Mon, 8 Mar 2021 02:28:11 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=OBKMP1phaAFh+09Pc1TZ37g3M8vO6rqr9IwHMoeZZIo=;
 b=UtMvZk3VEDF8wWHZUsyZ6NQizf3P3qY702oejojzy8dEsdH5MT3DnbStsQfsUbIpx0l4
 M8GCrAooCESIkvy6zK4LDzKHNdEyQ0ihCM5CKGaT3Tfq+9NcqEOkoNvsxKAP8FjZA54Y
 /fb5g3tGRGm/HmM1IRA7Pwd/XJiv4+JMZtv1dypN84uOb1SbOBAeSLILYxjOzMbN5qUh
 wh7t5ziAR/VaIuvs0D7I8G4VA3H2FBebU6UdC4kZSF4GNlyK8OnKcimE23FIIcgHzN45
 g5QCI5tZvll6wf64dsKcTddWrr8MfgP61boMWhVntA6mQ25ZmJmZHkImOtUqxH4NWXyP fw== 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        by mx0b-0014ca01.pphosted.com with ESMTP id 374674vuu1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 Mar 2021 02:28:11 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Exb2mYcFW1AAY++9Qk6drAGvUOm/BtCZmURcS7+EzrJApsUJk6eOQl2kdLxurick24KPpj1dj92fIoye5UoVqBI1dkWdiCF1Ntw75Qoz+lZBG8ywC7CzGkAU9BMQtouNbxT5GAoXADpFMdsUZOQnu8uJo1wB1H0UMEMLdp74q+PBQiRrn6d9uiU+drdFGxtb5Xy39ceefa+fLJkrllTmDlm/qrht65egdanukMuFULn8UWIytAv5er1sGb+DaQKvt3ThunSwYWLba2Eq4+jDZFm721hJ2rrw3AZJmyHk6x0cGCYtGtrkrbN2EP0oep3/EqO+DTwJWrBEVOfNERLdYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OBKMP1phaAFh+09Pc1TZ37g3M8vO6rqr9IwHMoeZZIo=;
 b=XWjZK28vjn9wdaTcDYSak8F1cZFRt/HvlpwQIm4j1tDeGoKgpQriIampHS6zgDhkNgMIDqYnmd5BD2T/1GkU+Ar5Ldr9CvQzYsDMe9ozKuwawcfqmMBfIkV8akO/8eqQK36Icqy0wt1zKEvEgO9RyBNNLsIMyY2buJ3mZobhxVLQ7dbpBtCRgPXxSBNkz92H/zlt7zPHjQyzxvYONSDeXl9x/f9+E5h9oql+2Up7XwrN5Dz9tZN2xPbXQFsd3fGQfsNckGhwpHjC5Y97o6LCC0WW7Cly4i4ekIXCPbTWCIY0ewJ2EulWyzcv/leC+opEEFLzo6xJ8c+3XRzj7D+7fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 158.140.1.147) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OBKMP1phaAFh+09Pc1TZ37g3M8vO6rqr9IwHMoeZZIo=;
 b=7DWy3NrrFhoSuTThw+Q3Kb7HOxqRafd/JNU0csWtI4BhN7q4lC2TvbAG0ImBSITM4nxayE1F3Jv2bNGkYE9h0Xft0MWXUP4u/IJESf2HWf2bg36ZJ/NVQmeiS5cigmsiAcgXcZalduVqddk5dxZaEg9nppx//pejE+3YwadmCzc=
Received: from MW2PR16CA0016.namprd16.prod.outlook.com (2603:10b6:907::29) by
 MWHPR07MB3535.namprd07.prod.outlook.com (2603:10b6:301:63::38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3890.26; Mon, 8 Mar 2021 10:28:08 +0000
Received: from MW2NAM12FT005.eop-nam12.prod.protection.outlook.com
 (2603:10b6:907:0:cafe::96) by MW2PR16CA0016.outlook.office365.com
 (2603:10b6:907::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend
 Transport; Mon, 8 Mar 2021 10:28:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 158.140.1.147)
 smtp.mailfrom=cadence.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none
 header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 158.140.1.147 as permitted sender) receiver=protection.outlook.com;
 client-ip=158.140.1.147; helo=sjmaillnx1.cadence.com;
Received: from sjmaillnx1.cadence.com (158.140.1.147) by
 MW2NAM12FT005.mail.protection.outlook.com (10.13.180.72) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3933.16 via Frontend Transport; Mon, 8 Mar 2021 10:28:08 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 128AS6Ag003739
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 8 Mar 2021 02:28:07 -0800
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 8 Mar 2021 11:28:05 +0100
Received: from gli-login.cadence.com (10.187.128.100) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Mon, 8 Mar 2021 11:28:05 +0100
Received: from gli-login.cadence.com (localhost [127.0.0.1])
        by gli-login.cadence.com (8.14.4/8.14.4) with ESMTP id 128AS42d010561;
        Mon, 8 Mar 2021 11:28:04 +0100
Received: (from pawell@localhost)
        by gli-login.cadence.com (8.14.4/8.14.4/Submit) id 128AS4sx010560;
        Mon, 8 Mar 2021 11:28:04 +0100
From:   Pawel Laszczak <pawell@cadence.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>
CC:     <linux-api@vger.kernel.org>, <laurent.pinchart@ideasonboard.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <peter.chen@kernel.org>, <kurahul@cadence.com>,
        Pawel Laszczak <pawell@cadence.com>
Subject: [PATCH 2/2] usb: webcam: Invalid size of Processing Unit Descriptor
Date:   Mon, 8 Mar 2021 11:27:35 +0100
Message-ID: <20210308102735.9251-2-pawell@gli-login.cadence.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210308102735.9251-1-pawell@gli-login.cadence.com>
References: <20210308102735.9251-1-pawell@gli-login.cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0974b368-4b14-4089-7f15-08d8e21cddf5
X-MS-TrafficTypeDiagnostic: MWHPR07MB3535:
X-Microsoft-Antispam-PRVS: <MWHPR07MB3535EA86540AE6287B8DD090DD939@MWHPR07MB3535.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Pc22cPqdhWL+NpVoy38jKrM6xpeP+uEDu219PLUAEmi3J4dO9JhF4oKyk0E7sx6rhkG8mTFszFCRRkpbguQJQSdHJBKuoYE9GggMoJPZCSxsZkRms7KpwCsL61l9Gi+Iz/mjL8AZNsPGNHskFfb5M5ppcjV2C939UexBAeE1cmyX4MGY2rTi9wIQdTDog/BO2wIVvaOn+B7gStyYaUc8tkOoSNwpatVby5H8q0UlEVzQ73No5TA4YQsweUjrRecPv1urKKPTG0gvEnCsZXr08zm/rzVE9ke1pq0dAehLBvEIc7UsPARAj2EpmDO4us6GyFsnRAt6Qi5HCeWov7z0zD2Lh3ueNuHBXVoL3pLI+6nT0WCOY9vyFNGr4LulcS6F3FYBG+5bRi97IAcxrW6mqOMSpvSyce/+DzU+xKGbKlbeK4/2kccywshOYKCRI+XidFz18MPX8XfKQc8ym5JpxjynYTdRQsABOmREUE0TOlufAXJxxxBKJ0OtZ7F4TDrPuwYGlNE19fYLZvCxxtPdeykjf+JANS30ZhUonCsqFyEw8rHV7jIDW75Q7w8LWcvcb4GFkkfdYHFzKlVSWejHnPDIZ9S31/+0LpOeAD7vagdr7/F1jPs6jolItoaZdrnpAQ6ZJx8mRkPAb2R0Tmcm7onw2Axq/Vy0W/Pg3Tuxh3iVUMOq6oiO3V02roiwCxxf
X-Forefront-Antispam-Report: CIP:158.140.1.147;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:sjmaillnx1.cadence.com;PTR:unknown.Cadence.COM;CAT:NONE;SFS:(4636009)(136003)(39860400002)(396003)(376002)(346002)(36092001)(46966006)(36840700001)(70206006)(478600001)(110136005)(70586007)(86362001)(2906002)(107886003)(5660300002)(4326008)(316002)(6666004)(36860700001)(186003)(8676002)(8936002)(42186006)(36906005)(7636003)(26005)(54906003)(1076003)(82740400003)(47076005)(82310400003)(336012)(4744005)(356005)(426003);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2021 10:28:08.3200
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0974b368-4b14-4089-7f15-08d8e21cddf5
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.147];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: MW2NAM12FT005.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR07MB3535
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-08_04:2021-03-08,2021-03-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 suspectscore=0
 phishscore=0 clxscore=1011 bulkscore=0 impostorscore=0 priorityscore=1501
 spamscore=0 malwarescore=0 lowpriorityscore=0 mlxlogscore=748 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103080054
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
 include/uapi/linux/usb/video.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/uapi/linux/usb/video.h b/include/uapi/linux/usb/video.h
index d854cb19c42c..2a54e8fdd341 100644
--- a/include/uapi/linux/usb/video.h
+++ b/include/uapi/linux/usb/video.h
@@ -302,6 +302,7 @@ struct uvc_processing_unit_descriptor {
 	__u8   bControlSize;
 	__u8   bmControls[2];
 	__u8   iProcessing;
+	__u8   bmVideoStandards;
 } __attribute__((__packed__));
 
 #define UVC_DT_PROCESSING_UNIT_SIZE(n)			(9+(n))
-- 
2.25.1


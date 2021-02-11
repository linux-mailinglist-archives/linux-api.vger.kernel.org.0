Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7657B3174E7
	for <lists+linux-api@lfdr.de>; Thu, 11 Feb 2021 01:02:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232565AbhBKABr (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 10 Feb 2021 19:01:47 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:47420 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233070AbhBKABq (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 10 Feb 2021 19:01:46 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11ANxaVS100498;
        Thu, 11 Feb 2021 00:00:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2020-01-29;
 bh=/7tRKLhmR9Fod6pz20+R5W+ybuNIeWcbqc39uZiR1tI=;
 b=Ntbtpy7INk0h0yZvHKzlktrnxq9EqPl4yprOwwcIM5wN+kP+hI7iHnWiQD6NEUfZ3Nc0
 fuklVi1mKUMBr5jEqfYiqnmnog9/eh/7Kpm2gw/wX4vY9CVwVaSkPSggq9znt5Qw8dp9
 Ey6w8XqwRBMtg8NUmWcVjKoyfNxWn8oUSH90xOSlcZavjWSvih1cTw5eyD2jhX8JB+NE
 f4xXmyhjJQgEEol9I0vktmHIsBgElEl14d2YmEIrVabqCkJIClzS+S0trmzX64A50nb9
 NtpGsppEk2m7mXy4cQ1MpTbD6+Y5Ea4S7roTwOvoXyvAoU2wX9wndnAZLcPTCO1hzdDV +g== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 36m4upv23b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Feb 2021 00:00:53 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11ANp4ga188251;
        Thu, 11 Feb 2021 00:00:52 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2102.outbound.protection.outlook.com [104.47.55.102])
        by userp3030.oracle.com with ESMTP id 36j51y8k49-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Feb 2021 00:00:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=byYJvCWDT+2R9wRMdLRe4u3SrUh/c1RM1IPz1FKAQV1rE8B3sav4wtly5A767QoqCyahZbvUG5kds6ca/dq8xE/lz2nfAWONAQjNVC0lBZOgssBOJ9l8sQN+BwrYRucsg3xW+W6J9PoGMZUHPbbiZyRi0DHQ4jnwf9WBJsRQyoU/AB7fZyBuDeg/zz1k4pi99k8/PEzt7pirQVBzRBnL7C5p7J65l4iU7EjjdFHlhKznCwQULkCJ+BDkOckwopQm1Gmldg3EWrpOVZxl+JtiY4LY++ge4QrgZS1WyXGUqoad8rdJtdel2SKlXd482dl7nqY3GoAA/GeT2En80donYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/7tRKLhmR9Fod6pz20+R5W+ybuNIeWcbqc39uZiR1tI=;
 b=IEt9pvzS21JhmgCAWlpXvQbN0uRwqqgmj4swSbFliSK1R2sd32tyGk1B8BlKfk++f79g/iRDONHYWrWf+BSfnhdvqpn28HDWDS4LeBFMVsSrg2nsKMPttm0BsqkOWgeVAcavoWQU6jT+GcQ36Ga2l82xNr16RhUOaxGeOCdXEuP33xOJCOpfXGfxkUqRSgA5mbUlv96G+zId1jhZwQPvCBWSKnuyKpKECMwZPmx/wdrj3I1H5kFE2ufKJqHxmsemo1S210S7/ttC4sbBlTsVBA+TA9Y/i/wuSGEfP3ReYpVaFn53zeQR38u3gfgYyTjdzeeyFCVYsP3uk1Z4jd+6Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/7tRKLhmR9Fod6pz20+R5W+ybuNIeWcbqc39uZiR1tI=;
 b=gDXsyVz3H7kmewicThsdwRMfGxv/aSfc8vDNA1Z0xzLf/bb3jnLst3X6Vd+iPuX7GTCBXYr9MIDqcferFe0TV4bl6QkNqkUPN1T/aezvmzBzZ1RqZ3bKosf8h4pv9kQ/syMYbhoSLXa9iO4ZcwJWQNNnHcSitMFur4Jdj/2ny1Q=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from SJ0PR10MB4494.namprd10.prod.outlook.com (2603:10b6:a03:2d4::12)
 by BY5PR10MB4290.namprd10.prod.outlook.com (2603:10b6:a03:203::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.19; Thu, 11 Feb
 2021 00:00:50 +0000
Received: from SJ0PR10MB4494.namprd10.prod.outlook.com
 ([fe80::7445:f44:72aa:da07]) by SJ0PR10MB4494.namprd10.prod.outlook.com
 ([fe80::7445:f44:72aa:da07%4]) with mapi id 15.20.3825.031; Thu, 11 Feb 2021
 00:00:50 +0000
From:   rao.shoaib@oracle.com
To:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        davem@davemloft.net, kuba@kernel.org, andy.rudoff@intel.com
Cc:     willy@infradead.org, Rao Shoaib <rao.shoaib@oracle.com>
Subject: [PATCH v2 1/1] af_unix: Allow Unix sockets to raise SIGURG
Date:   Wed, 10 Feb 2021 16:00:43 -0800
Message-Id: <20210211000043.136979-1-rao.shoaib@oracle.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [2606:b400:8301:1010::16aa]
X-ClientProxiedBy: SJ0PR03CA0091.namprd03.prod.outlook.com
 (2603:10b6:a03:333::6) To SJ0PR10MB4494.namprd10.prod.outlook.com
 (2603:10b6:a03:2d4::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from shoaib-laptop.us.oracle.com (2606:b400:8301:1010::16aa) by SJ0PR03CA0091.namprd03.prod.outlook.com (2603:10b6:a03:333::6) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.25 via Frontend Transport; Thu, 11 Feb 2021 00:00:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a935c66e-b45f-41ad-3222-08d8ce2017ac
X-MS-TrafficTypeDiagnostic: BY5PR10MB4290:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR10MB42906593205B6CBF17D190CFEF8C9@BY5PR10MB4290.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OLPfKdm5rDo1PxtZ9afIeVFfPscFiVSIUHkuxO91uO+5vN9LsCDLqXVrkVlIEjRtKrwmG7N4W6OQdNFkzCqBQgXYAQlcOsqN5Cyecmm44N+X38HMBb9QwuIiShiIhR+7DzCcUBuVgUc8/9+sWyWp9U31xMjbUSbrlnFUg5ZvRZz92p42XOFLnmz86vnZfXM4ejSrJ5yQdjafZ9L6FeltvRF86Teu1L8mh+NlGgh2XspHt1uqiTAyBF7O+aKx6edubpvIiDQY63zOaFcagIhWVMp8ccVp8BC+9j8wGbRImNn9elql9+sBGYPXBLkQZlWBZvFkp7mbH8hW3jMajX9Ulyg1qidoh1n3mGsICto2yaLVHjyRbCFTvWPeUWEmHkBVT3u/liQQJ7D7PH6OMHO5oFYR2P9D/DjToTdfFDdHAw1/EelBixoImT3JyxT9TSvDYzO+587EWVpDgbdKfaZkSEmVo+TD5Qm8WLlNCNvhaqs0AYR2CZj57ZtQLMj71tZQBL3uRC4METjIWFwY55EG3Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4494.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(366004)(396003)(346002)(136003)(39860400002)(86362001)(2906002)(8676002)(9686003)(1076003)(2616005)(107886003)(4326008)(16526019)(6486002)(5660300002)(83380400001)(6666004)(7696005)(66946007)(66556008)(66476007)(8936002)(52116002)(186003)(316002)(478600001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?PgaLSBieWOMLlKU1hYw73zf+vBcyde9Ur0FcKlNiGDohLKZrAIdcUvOL99zE?=
 =?us-ascii?Q?Tq56GAeM3GugXIEtmR/LdvVKYTgxXDrVmG7UT7wAA8t6fMqaS/SrJRnwynr/?=
 =?us-ascii?Q?9ZJr/VKC6eYRstdc7zxhpH32EDQho/Z4kUXi0cwpH9o3RICzlzbPQeY7GeFq?=
 =?us-ascii?Q?QWkglZbcfSmxJJz5Ot4sFBjTwsjKOclWRdqqLdoD9rQ4uDuvcth/7SX79z59?=
 =?us-ascii?Q?9U6b0UgSMWSGGU+mP2X5EOHSxQyELWfNHuItmjy+KXms4AY5lOMpj+x/KzSG?=
 =?us-ascii?Q?YvZaVxQl3t4tNaaE3dW2w7GCSlgzeooyiC3hjzRcZJXKZRQdFGS7hu4JTAIb?=
 =?us-ascii?Q?hOIyNCW59NWlMxSQ9Nf4kWisw01vsLCy3PCiK0TgwuNEFGYKkVOWswi9juUU?=
 =?us-ascii?Q?nNopl3KREHdN57YOegVeUe7Z4Hcd2R1zLpGH/kJI0/q5w8IHsJsla8BJa2cA?=
 =?us-ascii?Q?KOxsgG5lBLrhdZkCb+m+9ZxFdZ8mHmtiycP+lGHy+fAJ7vPbwL4QMAX65eol?=
 =?us-ascii?Q?MRhxOzr2WMYsNYPwirbrOJIIQl4XvURzTsg/JEtNFOzDKF4zDrm63WA1vOuc?=
 =?us-ascii?Q?m/KDg3lFBF+1mVjul2lmd7eDC/JmVxi30nRIPR+wZtA1l5JmhgvRqajk7dvh?=
 =?us-ascii?Q?Wbq2ksKR0m6B+YQJ2X+ht0lQI3f80blBY0gj3e2D5yeW1oAfHYnN6hOR+bvs?=
 =?us-ascii?Q?k/QlC4sxPuMU+VFn57AeG5Bu9sTRaqpNIjGZnUyFmNvj8I9gZP8uRbI0IK49?=
 =?us-ascii?Q?us6OCdoz92SmWeF8o+QSMy0/Gac4so/cMAGucY8iQ8TQo1bvIAx8WFLeG1Jy?=
 =?us-ascii?Q?Vu9XELt7PUdf1sLNEltAe80hYppFeeAM/m84DHX5Bc2n1JNNhlJj6EymIKtl?=
 =?us-ascii?Q?fGsJ/HXDFnS9Zq9BmHyVx/N+PohhH/prDUTVEEGfUtKxPnEzo3IFdNbE1cGL?=
 =?us-ascii?Q?LPobHNN/YIgzAxyBpxwliaXxzymzYFTy4rRhfaBAUUwp6S+fcRf1DpxPYxEt?=
 =?us-ascii?Q?3GdX1pEhyl3IzBvpd0axyZUogqKPWc71YNo6o9ymURiTpNBSwCHwdOXA+BHx?=
 =?us-ascii?Q?HnVc7HQJPEOg+p8pKk84B7VvdCigxt6uFZsPZfQFJcvoOHRicdNPklSCSpLt?=
 =?us-ascii?Q?P4vN0rVvS/JkNNdzMTF4btKT911nPY5clU3rIVQv8KleRHIfRKKcYwMQtago?=
 =?us-ascii?Q?pK93+p+lD00TDo3ncxIRQIiwlNh4X6mKGaLpDxlyQHmLPMCAZ5jeLG4wM7lK?=
 =?us-ascii?Q?xzdEUMxeLmg/kJU38ZPMxIcSt4ZZvcALKEEnafaAYrlmK5yqSOcuTS2s/LRZ?=
 =?us-ascii?Q?7EVI+h4tc3CQ3hp4LBLndnKS83QRI8vVEiCh/4Rs/J160987c5nGFVklt6zJ?=
 =?us-ascii?Q?7AhMW2I=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a935c66e-b45f-41ad-3222-08d8ce2017ac
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4494.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2021 00:00:50.6312
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LD+uezehRlRMqIUkcMtxmvm0J8pzHKDOcEHIy7tW1LwtIaLxvsuFS70SWo/bB5PABB2HHe1Ic+8M16G1llL2dg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4290
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9891 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 phishscore=0
 mlxscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102100208
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9891 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 mlxscore=0
 mlxlogscore=999 spamscore=0 impostorscore=0 malwarescore=0 clxscore=1015
 suspectscore=0 adultscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102100209
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

From: Rao Shoaib <rao.shoaib@oracle.com>

TCP sockets allow SIGURG to be sent to the process holding the other
end of the socket.  Extend Unix sockets to have the same ability
but only if the data length is zero.

The API is the same in that the sender uses sendmsg() with MSG_OOB to
raise SIGURG.  Unix sockets behave in the same way as TCP sockets with
SO_OOBINLINE set.

SIGURG is ignored by default, so applications which do not know about this
feature will be unaffected.  In addition to installing a SIGURG handler,
the receiving application must call F_SETOWN or F_SETOWN_EX to indicate
which process or thread should receive the signal.

Signed-off-by: Rao Shoaib <rao.shoaib@oracle.com>
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 net/unix/af_unix.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 92784e5..65f6179 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -1840,7 +1840,8 @@ static int unix_stream_sendmsg(struct socket *sock, struct msghdr *msg,
 		return err;
 
 	err = -EOPNOTSUPP;
-	if (msg->msg_flags&MSG_OOB)
+
+	if (len && (msg->msg_flags & MSG_OOB))
 		goto out_err;
 
 	if (msg->msg_namelen) {
@@ -1856,6 +1857,9 @@ static int unix_stream_sendmsg(struct socket *sock, struct msghdr *msg,
 	if (sk->sk_shutdown & SEND_SHUTDOWN)
 		goto pipe_err;
 
+	if (msg->msg_flags & MSG_OOB)
+		sk_send_sigurg(other);
+
 	while (sent < len) {
 		size = len - sent;
 
-- 
1.8.3.1


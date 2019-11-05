Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A277BF0175
	for <lists+linux-api@lfdr.de>; Tue,  5 Nov 2019 16:30:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389962AbfKEPaA (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 5 Nov 2019 10:30:00 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58758 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389940AbfKEP3v (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 5 Nov 2019 10:29:51 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id xA5FRxog100532
        for <linux-api@vger.kernel.org>; Tue, 5 Nov 2019 10:29:50 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2w3aga4n9p-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-api@vger.kernel.org>; Tue, 05 Nov 2019 10:29:50 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-api@vger.kernel.org> from <rppt@linux.ibm.com>;
        Tue, 5 Nov 2019 15:29:48 -0000
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 5 Nov 2019 15:29:44 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xA5FT82Z18809216
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 5 Nov 2019 15:29:08 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 822D352052;
        Tue,  5 Nov 2019 15:29:43 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.8.59])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id 703345204E;
        Tue,  5 Nov 2019 15:29:41 +0000 (GMT)
Received: by rapoport-lnx (sSMTP sendmail emulation); Tue, 05 Nov 2019 17:29:40 +0200
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Daniel Colascione <dancol@google.com>,
        Jann Horn <jannh@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Lokesh Gidra <lokeshgidra@google.com>,
        Nick Kralevich <nnk@google.com>,
        Nosh Minwalla <nosh@google.com>,
        Pavel Emelyanov <ovzxemul@gmail.com>,
        Tim Murray <timmurray@google.com>, linux-api@vger.kernel.org,
        linux-mm@kvack.org, Mike Rapoport <rppt@linux.ibm.com>
Subject: [PATCH 1/1] userfaultfd: require CAP_SYS_PTRACE for UFFD_FEATURE_EVENT_FORK
Date:   Tue,  5 Nov 2019 17:29:37 +0200
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1572967777-8812-1-git-send-email-rppt@linux.ibm.com>
References: <1572967777-8812-1-git-send-email-rppt@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19110515-0020-0000-0000-00000382C8FB
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19110515-0021-0000-0000-000021D8F36B
Message-Id: <1572967777-8812-2-git-send-email-rppt@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-11-05_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1911050127
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Current implementation of UFFD_FEATURE_EVENT_FORK modifies the file
descriptor table from the read() implementation of uffd, which may have
security implications for unprivileged use of the userfaultfd.

Limit availability of UFFD_FEATURE_EVENT_FORK only for callers that have
CAP_SYS_PTRACE.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 fs/userfaultfd.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index f9fd18670e22..d99d166fd892 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -1834,13 +1834,12 @@ static int userfaultfd_api(struct userfaultfd_ctx *ctx,
 	if (copy_from_user(&uffdio_api, buf, sizeof(uffdio_api)))
 		goto out;
 	features = uffdio_api.features;
-	if (uffdio_api.api != UFFD_API || (features & ~UFFD_API_FEATURES)) {
-		memset(&uffdio_api, 0, sizeof(uffdio_api));
-		if (copy_to_user(buf, &uffdio_api, sizeof(uffdio_api)))
-			goto out;
-		ret = -EINVAL;
-		goto out;
-	}
+	ret = -EINVAL;
+	if (uffdio_api.api != UFFD_API || (features & ~UFFD_API_FEATURES))
+		goto err_out;
+	ret = -EPERM;
+	if ((features & UFFD_FEATURE_EVENT_FORK) && !capable(CAP_SYS_PTRACE))
+		goto err_out;
 	/* report all available features and ioctls to userland */
 	uffdio_api.features = UFFD_API_FEATURES;
 	uffdio_api.ioctls = UFFD_API_IOCTLS;
@@ -1853,6 +1852,11 @@ static int userfaultfd_api(struct userfaultfd_ctx *ctx,
 	ret = 0;
 out:
 	return ret;
+err_out:
+	memset(&uffdio_api, 0, sizeof(uffdio_api));
+	if (copy_to_user(buf, &uffdio_api, sizeof(uffdio_api)))
+		ret = -EFAULT;
+	goto out;
 }
 
 static long userfaultfd_ioctl(struct file *file, unsigned cmd,
-- 
2.7.4


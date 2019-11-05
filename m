Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B1380F016E
	for <lists+linux-api@lfdr.de>; Tue,  5 Nov 2019 16:29:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389941AbfKEP3v (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 5 Nov 2019 10:29:51 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43384 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2389884AbfKEP3v (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 5 Nov 2019 10:29:51 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id xA5FReFX042378
        for <linux-api@vger.kernel.org>; Tue, 5 Nov 2019 10:29:49 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2w3apstdrb-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-api@vger.kernel.org>; Tue, 05 Nov 2019 10:29:49 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-api@vger.kernel.org> from <rppt@linux.ibm.com>;
        Tue, 5 Nov 2019 15:29:47 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 5 Nov 2019 15:29:41 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xA5FTeZZ55640148
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 5 Nov 2019 15:29:40 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CE50AA4051;
        Tue,  5 Nov 2019 15:29:40 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BAB3CA404D;
        Tue,  5 Nov 2019 15:29:38 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.8.59])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue,  5 Nov 2019 15:29:38 +0000 (GMT)
Received: by rapoport-lnx (sSMTP sendmail emulation); Tue, 05 Nov 2019 17:29:38 +0200
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
Subject: [PATCH 0/1] userfaultfd: require CAP_SYS_PTRACE for UFFD_FEATURE_EVENT_FORK
Date:   Tue,  5 Nov 2019 17:29:36 +0200
X-Mailer: git-send-email 2.7.4
X-TM-AS-GCONF: 00
x-cbid: 19110515-0008-0000-0000-0000032AEF58
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19110515-0009-0000-0000-00004A4A4A16
Message-Id: <1572967777-8812-1-git-send-email-rppt@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-11-05_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=811 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1911050127
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hi,

A while ago Andy noticed [1] that UFFD_FEATURE_EVENT_FORK used by an
unprivileged user may have security implications.

As the first step of the solution the following patch limits the
availably of UFFD_FEATURE_EVENT_FORK only for those having CAP_SYS_PTRACE.

The usage of CAP_SYS_PTRACE ensures compatibility with CRIU.

Yet, if there are other users of non-cooperative userfaultfd that run
without CAP_SYS_PTRACE, they would be broken :(

[1] https://lore.kernel.org/lkml/CALCETrWY+5ynDct7eU_nDUqx=okQvjm=Y5wJvA4ahBja=CQXGw@mail.gmail.com

Mike Rapoport (1):
  userfaultfd: require CAP_SYS_PTRACE for UFFD_FEATURE_EVENT_FORK

 fs/userfaultfd.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

-- 
2.7.4


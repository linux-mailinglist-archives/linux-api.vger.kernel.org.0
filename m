Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5704444AC71
	for <lists+linux-api@lfdr.de>; Tue,  9 Nov 2021 12:19:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245667AbhKILVy (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 9 Nov 2021 06:21:54 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:61554 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245677AbhKILVy (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 9 Nov 2021 06:21:54 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1A9BHVCV026166;
        Tue, 9 Nov 2021 11:18:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=pp1;
 bh=wAF50VjjpA4GthliuDEwcBjQD4pGrgZQrnR8Ma+EU3U=;
 b=qPHMtrgYg2AS+W7PO7h8PixuuBoVFVpKZ4BNgrxbciaWUyap1dnEekBi0i4LSnxIDCfA
 gJUAhYj/gGBh6wvsOXeJz4nFWwOyNHn9nrs9JeSwLQ/1+/BLSPc8zrn0J7UDvpHsJMzm
 V6vQVe+09R+yhbr11pSxirCkfvWQGyKcL80bRxNxCZg/e1G1jUhVnJJ4DVVo19aoPNF0
 pG2Qd6BKXZ1Cls4Giy1ctr6wqABcBT5TRSu8Uh50kfmJaQWjK5gVG93cPVunn63UUrk/
 uQd/EQ9SK+g+imh93k29EP/Epj1apVQqUEKmvEwTqgZRRcX1ms9WAVI1apvxUGsQFYNK MQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3c7r0080pk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 Nov 2021 11:18:29 +0000
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1A9BISA7031777;
        Tue, 9 Nov 2021 11:18:28 GMT
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3c7r0080nr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 Nov 2021 11:18:28 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1A9BHZnn023357;
        Tue, 9 Nov 2021 11:18:26 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma05fra.de.ibm.com with ESMTP id 3c5hb9d9b2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 Nov 2021 11:18:25 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1A9BINWx61735174
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 9 Nov 2021 11:18:23 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A26F911C071;
        Tue,  9 Nov 2021 11:18:23 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DB53311C0A9;
        Tue,  9 Nov 2021 11:18:22 +0000 (GMT)
Received: from localhost (unknown [9.171.40.178])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue,  9 Nov 2021 11:18:22 +0000 (GMT)
Date:   Tue, 9 Nov 2021 12:18:21 +0100
From:   Vasily Gorbik <gor@linux.ibm.com>
To:     =?utf-8?B?QW5kcsOp?= Almeida <andrealmeid@collabora.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        kernel@collabora.com, krisman@collabora.com,
        linux-api@vger.kernel.org, libc-alpha@sourceware.org,
        mtk.manpages@gmail.com, Davidlohr Bueso <dave@stgolabs.net>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 20/22] selftests: futex: Test sys_futex_waitv() timeout
Message-ID: <your-ad-here.call-01636456701-ext-5362@work.hours>
References: <20210923171111.300673-1-andrealmeid@collabora.com>
 <20210923171111.300673-21-andrealmeid@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210923171111.300673-21-andrealmeid@collabora.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 8ZGmmKZpwycNjdqnKbJEhyKvGA9dmtlt
X-Proofpoint-ORIG-GUID: kf8K6Tt8LcVW4t_5syGH8K0ZSp_ZFWJY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-09_03,2021-11-08_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 malwarescore=0 priorityscore=1501 mlxlogscore=999
 bulkscore=0 clxscore=1011 adultscore=0 suspectscore=0 spamscore=0
 phishscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111090067
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, Sep 23, 2021 at 02:11:09PM -0300, André Almeida wrote:
> Test if the futex_waitv timeout is working as expected, using the
> supported clockid options.

> +	/* futex_waitv with CLOCK_MONOTONIC */
> +	if (futex_get_abs_timeout(CLOCK_MONOTONIC, &to, timeout_ns))
> +		return RET_FAIL;
> +	res = futex_waitv(&waitv, 1, 0, &to, CLOCK_MONOTONIC);
> +	test_timeout(res, &ret, "futex_waitv monotonic", ETIMEDOUT);
> +
> +	/* futex_waitv with CLOCK_REALTIME */
> +	if (futex_get_abs_timeout(CLOCK_REALTIME, &to, timeout_ns))
> +		return RET_FAIL;
> +	res = futex_waitv(&waitv, 1, 0, &to, CLOCK_REALTIME);
> +	test_timeout(res, &ret, "futex_waitv realtime", ETIMEDOUT);

Hi André,

when built with -m32 and run as compat this two futex_waitv calls hang
on x86 and s390 (noticed while wiring up futex_waitv). The rest of the
futex selftests pass. This suggests some common compat issue? Any ideas?

diff --git a/tools/testing/selftests/futex/functional/Makefile b/tools/testing/selftests/futex/functional/Makefile
index 5cc38de9d8ea..ddcb597d13ea 100644
--- a/tools/testing/selftests/futex/functional/Makefile
+++ b/tools/testing/selftests/futex/functional/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 INCLUDES := -I../include -I../../ -I../../../../../usr/include/ \
        -I$(KBUILD_OUTPUT)/kselftest/usr/include
-CFLAGS := $(CFLAGS) -g -O2 -Wall -D_GNU_SOURCE -pthread $(INCLUDES)
+CFLAGS := $(CFLAGS) -g -m32 -O2 -Wall -D_GNU_SOURCE -pthread $(INCLUDES)
 LDLIBS := -lpthread -lrt
 
 HEADERS := \
--

Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6B22216080
	for <lists+linux-api@lfdr.de>; Mon,  6 Jul 2020 22:49:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725941AbgGFUtm (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 6 Jul 2020 16:49:42 -0400
Received: from mail.efficios.com ([167.114.26.124]:56924 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725860AbgGFUtm (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 6 Jul 2020 16:49:42 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 926692DCDA5;
        Mon,  6 Jul 2020 16:49:41 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id zgXfZ8ULZHuK; Mon,  6 Jul 2020 16:49:41 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 2780F2DCE1F;
        Mon,  6 Jul 2020 16:49:41 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 2780F2DCE1F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1594068581;
        bh=XlqRnfsoWKc5MVLCjC5AxpBd+CFQtEQAvuC1zE63+Y0=;
        h=From:To:Date:Message-Id;
        b=kYIFEzQeOrM7uwndSuipxq1i/t1+T8X4j91h/fDUIb/fqSqnT31p+CpQ3crCqc5iw
         B3X3jvDFQjenxqoTmKUiCZ/XtNaZyEutEyla1JpI2DaD3oe4vDj2EOUimK3ypjg2r6
         sgz4/DCtz9YHhweZaiprXuqe7OwlzbJBLqu8q6hCz2loIwsxJlvQEkteiG6AcnwWfW
         r9wqv00CWTEo8RDX7G1ynaFN5dWmc2WND8hvuVXfdF+SyXd8bing4Ilhk4MZUWxmzD
         wDyppX9nX214yeF4WgxT5dupBKCZDO6j+Th5hIfeGX2M1yy3nZKFqEoCZLOPd2AuNk
         XblzTfeWga1cQ==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 1T7FcRgLYua3; Mon,  6 Jul 2020 16:49:41 -0400 (EDT)
Received: from localhost.localdomain (192-222-181-218.qc.cable.ebox.net [192.222.181.218])
        by mail.efficios.com (Postfix) with ESMTPSA id A243A2DCDA3;
        Mon,  6 Jul 2020 16:49:40 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E . McKenney" <paulmck@linux.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        linux-api@vger.kernel.org, Florian Weimer <fw@deneb.enyo.de>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RFC PATCH for 5.8 0/4] rseq cpu_id ABI fix
Date:   Mon,  6 Jul 2020 16:49:09 -0400
Message-Id: <20200706204913.20347-1-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hi,

Recent integration of rseq into glibc unearthed an issue with inaccurate
cpu_id field for newly created tasks. This series includes a fix for the
underlying issue (meant to be backported to stable), as well as new rseq
flags to let user-space know that the kernel implements this fix, so
glibc and other rseq users can use this flag to know whether they can
safely use rseq without risk of corrupting their per-cpu data. This new
flag could either be added only to the master branch (no stable
backport) or backported to stable, depending on what seems the most
appropriate.

This is an RFC aiming for quick inclusion into the Linux kernel, unless
we prefer reverting the entire rseq glibc integration and try again in 6
months. Their upcoming release is on August 3rd, so we need to take a
decision on this matter quickly.

Thanks,

Mathieu

Mathieu Desnoyers (4):
  sched: Fix unreliable rseq cpu_id for new tasks
  rseq: Introduce RSEQ_FLAG_REGISTER
  rseq: Introduce RSEQ_FLAG_RELIABLE_CPU_ID
  rseq: selftests: Expect reliable cpu_id field

 include/uapi/linux/rseq.h           | 15 +++++-
 kernel/rseq.c                       | 81 ++++++++++++++++-------------
 kernel/sched/core.c                 |  2 +
 tools/testing/selftests/rseq/rseq.c | 10 +++-
 4 files changed, 71 insertions(+), 37 deletions(-)

-- 
2.17.1


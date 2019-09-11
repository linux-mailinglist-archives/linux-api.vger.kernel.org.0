Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 34856AF3A5
	for <lists+linux-api@lfdr.de>; Wed, 11 Sep 2019 02:27:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726540AbfIKA1y (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 10 Sep 2019 20:27:54 -0400
Received: from mail.efficios.com ([167.114.142.138]:59944 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725916AbfIKA1y (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 10 Sep 2019 20:27:54 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id F232DBD644;
        Tue, 10 Sep 2019 20:27:52 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id i4l41c7yM7eK; Tue, 10 Sep 2019 20:27:52 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 0374EBD637;
        Tue, 10 Sep 2019 20:27:52 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 0374EBD637
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1568161672;
        bh=/u+Mdpc+ccw/lm1pYsAQ24noYQi7kzECenEnBrFGCs4=;
        h=From:To:Date:Message-Id;
        b=iDxfLMMOmVhgWeWT5yVEwWsyEOFV9uMW3p+i1kouJAF/OUw8o1suaKztYGIVvhR/w
         TXDHUq0+yVwULLyLqi1n5Jt/ICLuHVclRj9m2IIZ3+Vk+B4G/YH+y4u599ly/inXs0
         /M+U0Inqy1AOqXL3XJu++0XAi990LQozPP0o9E8W4mwwc0WjQf7PZpdnMuW46li2Di
         oedQw9gKW2Me1kAcr44aJAmtQ+1si8GPPw0qVFdU0OusQfmbFDVMD74OtCKbOLwV6H
         f1IHnpCIW05wWsx7iL2oBK5PY+l58Bozd0V1xF7wRNtu7mOJHPwy8XVwuNYpH9VQef
         Try3hjVL0fQMw==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id 0_xTGo_E6YM5; Tue, 10 Sep 2019 20:27:51 -0400 (EDT)
Received: from localhost.localdomain (192-222-181-218.qc.cable.ebox.net [192.222.181.218])
        by mail.efficios.com (Postfix) with ESMTPSA id B9A42BD631;
        Tue, 10 Sep 2019 20:27:51 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Paul Turner <pjt@google.com>
Cc:     linux-kernel@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "H . Peter Anvin" <hpa@zytor.com>, linux-api@vger.kernel.org
Subject: [RFC PATCH 1/4] rseq: Fix: Reject unknown flags on rseq unregister
Date:   Tue, 10 Sep 2019 20:27:41 -0400
Message-Id: <20190911002744.8690-1-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

It is preferrable to reject unknown flags within rseq unregistration
rather than to ignore them. It is an oversight caused by the fact that
the check for unknown flags is after the rseq unregister flag check.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: "H . Peter Anvin" <hpa@zytor.com>
Cc: Paul Turner <pjt@google.com>
Cc: linux-api@vger.kernel.org
---
 kernel/rseq.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/rseq.c b/kernel/rseq.c
index 27c48eb7de40..a4f86a9d6937 100644
--- a/kernel/rseq.c
+++ b/kernel/rseq.c
@@ -310,6 +310,8 @@ SYSCALL_DEFINE4(rseq, struct rseq __user *, rseq, u32, rseq_len,
 	int ret;
 
 	if (flags & RSEQ_FLAG_UNREGISTER) {
+		if (flags & ~RSEQ_FLAG_UNREGISTER)
+			return -EINVAL;
 		/* Unregister rseq for current thread. */
 		if (current->rseq != rseq || !current->rseq)
 			return -EINVAL;
-- 
2.17.1


Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B93321E619
	for <lists+linux-api@lfdr.de>; Tue, 14 Jul 2020 05:04:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726894AbgGNDEA (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 13 Jul 2020 23:04:00 -0400
Received: from mail.efficios.com ([167.114.26.124]:46290 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726848AbgGNDD7 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 13 Jul 2020 23:03:59 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id AF9D82B87A8;
        Mon, 13 Jul 2020 23:03:58 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id nGaKxuycUWNC; Mon, 13 Jul 2020 23:03:58 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 5E3AA2B8A02;
        Mon, 13 Jul 2020 23:03:56 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 5E3AA2B8A02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1594695836;
        bh=hWvRJ4JuvRDS88JLdxiQVweIlzH+3zG8cEkM3JG7ei0=;
        h=From:To:Date:Message-Id;
        b=ogOQpKRjacYrJ3CRhGMKyzdqJSc+NbksTYxSNU8FW1nRmMb2Xh6N5umfU3PFNpmbV
         ZMMewoyj4mkwk8qMpaOSGgZfnZ5bXcoDrr8mYz7vCHMla+fKDX1b2L37wKXptESvSt
         c9tBKZc6bGVIsUfZAAqiLfHDXKoaujovff7f8s44VetFf/+o8KOpWD98FfnyRl+eH6
         t+ZuFOBzJDFheQr3ywIG8fMJNq5RJ79QdzporFqmjcNyHM/kcy0WSXkXPdXKkH3Dw1
         i/RxIInruAByyJsL+yZ0N8ryXXsrgXYLq9nA2b/AjlDDZqa8uedTYmxctZ9zIFBbeR
         v0+9fXxB7FIcg==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id BX0KfU3bRstg; Mon, 13 Jul 2020 23:03:56 -0400 (EDT)
Received: from localhost.localdomain (192-222-181-218.qc.cable.ebox.net [192.222.181.218])
        by mail.efficios.com (Postfix) with ESMTPSA id D329B2B879E;
        Mon, 13 Jul 2020 23:03:55 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@linux.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        linux-api@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Florian Weimer <fw@deneb.enyo.de>, carlos@redhat.com,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RFC PATCH 4/4] selftests: rseq: print rseq extensible size in basic test
Date:   Mon, 13 Jul 2020 23:03:48 -0400
Message-Id: <20200714030348.6214-5-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200714030348.6214-1-mathieu.desnoyers@efficios.com>
References: <20200714030348.6214-1-mathieu.desnoyers@efficios.com>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Print whether extensible size feature is supported by the kernel
and __rseq_abi definition, along with the contents of the kernel_size
field if it is available.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 tools/testing/selftests/rseq/basic_test.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/tools/testing/selftests/rseq/basic_test.c b/tools/testing/selftests/rseq/basic_test.c
index d8efbfb89193..976e040574a1 100644
--- a/tools/testing/selftests/rseq/basic_test.c
+++ b/tools/testing/selftests/rseq/basic_test.c
@@ -10,6 +10,7 @@
 #include <stdio.h>
 #include <string.h>
 #include <sys/time.h>
+#include <inttypes.h>
 
 #include "rseq.h"
 
@@ -35,6 +36,17 @@ void test_cpu_pointer(void)
 	sched_setaffinity(0, sizeof(affinity), &affinity);
 }
 
+static void print_rseq_size(void)
+{
+	bool supported = (__rseq_abi.flags & RSEQ_TLS_FLAG_SIZE) && __rseq_abi.kernel_size != 0;
+
+	printf("extensible struct rseq supported: %s",
+		supported ? "yes" : "no");
+	if (supported)
+		printf(" (kernel_size=%" PRIu16 ")", __rseq_abi.kernel_size);
+	printf("\n");
+}
+
 int main(int argc, char **argv)
 {
 	if (rseq_register_current_thread()) {
@@ -42,6 +54,9 @@ int main(int argc, char **argv)
 			errno, strerror(errno));
 		goto init_thread_error;
 	}
+
+	print_rseq_size();
+
 	printf("testing current cpu\n");
 	test_cpu_pointer();
 	if (rseq_unregister_current_thread()) {
-- 
2.17.1


Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57B9A21E614
	for <lists+linux-api@lfdr.de>; Tue, 14 Jul 2020 05:03:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726150AbgGNDD5 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 13 Jul 2020 23:03:57 -0400
Received: from mail.efficios.com ([167.114.26.124]:46198 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726432AbgGNDD4 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 13 Jul 2020 23:03:56 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id C42872B8642;
        Mon, 13 Jul 2020 23:03:55 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 6-nSYf6aGGFD; Mon, 13 Jul 2020 23:03:55 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 90B5E2B8901;
        Mon, 13 Jul 2020 23:03:55 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 90B5E2B8901
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1594695835;
        bh=w9++onGpxSKMGIZF8bfKR0TS6LlGjGmbqBWAtBmSjx4=;
        h=From:To:Date:Message-Id;
        b=cBHrCYvIqybF1wJu4N/CsRu9xLt3RsHCO0k+6j/CN7fg8stsNk7jvNd9ZwgLtmvkY
         8uAoZEHL9M54DF9BMK9vPhkRcdxryAV2Jk+3g2a+pwn8b81oKCW/e0upmbso3YkMcz
         GAFRWk2iVch5nDgFOkUeGHY1EzsnW5TjRYM9svqSfOhAsBNfH/jUlYCbNOJJYtjVBT
         Y6ocJlrXLM4dwV0GvzjAkheuCyTFKKLxl3O3YoXbqGA22+yoO4vf8W4NROlf5lh6IQ
         AE0s36yBQV7nWRYR362wZwGxwgaB0uCobcGU19BvxcrQW0fB19FE2GvdlGgedFDhm/
         UUATQwEvp4P2g==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 5Wlf2mxEeFwU; Mon, 13 Jul 2020 23:03:55 -0400 (EDT)
Received: from localhost.localdomain (192-222-181-218.qc.cable.ebox.net [192.222.181.218])
        by mail.efficios.com (Postfix) with ESMTPSA id 2C4842B8640;
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
Subject: [RFC PATCH 1/4] selftests: rseq: Use fixed value as rseq_len parameter
Date:   Mon, 13 Jul 2020 23:03:45 -0400
Message-Id: <20200714030348.6214-2-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200714030348.6214-1-mathieu.desnoyers@efficios.com>
References: <20200714030348.6214-1-mathieu.desnoyers@efficios.com>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

The rseq registration and unregistration expect a fixed-size length
(32 bytes). In preparation to extend struct rseq, pass a fixed value
rather than the size of the rseq structure.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 include/uapi/linux/rseq.h           | 5 +++++
 tools/testing/selftests/rseq/rseq.c | 5 ++---
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/include/uapi/linux/rseq.h b/include/uapi/linux/rseq.h
index 9a402fdb60e9..e11d9df5e564 100644
--- a/include/uapi/linux/rseq.h
+++ b/include/uapi/linux/rseq.h
@@ -37,6 +37,11 @@ enum rseq_cs_flags {
 		(1U << RSEQ_CS_FLAG_NO_RESTART_ON_MIGRATE_BIT),
 };
 
+/* The rseq_len expected by rseq registration is always 32 bytes. */
+enum rseq_len_expected {
+	RSEQ_LEN_EXPECTED = 32,
+};
+
 /*
  * struct rseq_cs is aligned on 4 * 8 bytes to ensure it is always
  * contained within a single cache-line. It is usually declared as
diff --git a/tools/testing/selftests/rseq/rseq.c b/tools/testing/selftests/rseq/rseq.c
index 7159eb777fd3..da2264c679b9 100644
--- a/tools/testing/selftests/rseq/rseq.c
+++ b/tools/testing/selftests/rseq/rseq.c
@@ -87,7 +87,7 @@ int rseq_register_current_thread(void)
 	}
 	if (__rseq_refcount++)
 		goto end;
-	rc = sys_rseq(&__rseq_abi, sizeof(struct rseq), 0, RSEQ_SIG);
+	rc = sys_rseq(&__rseq_abi, RSEQ_LEN_EXPECTED, 0, RSEQ_SIG);
 	if (!rc) {
 		assert(rseq_current_cpu_raw() >= 0);
 		goto end;
@@ -115,8 +115,7 @@ int rseq_unregister_current_thread(void)
 	}
 	if (--__rseq_refcount)
 		goto end;
-	rc = sys_rseq(&__rseq_abi, sizeof(struct rseq),
-		      RSEQ_FLAG_UNREGISTER, RSEQ_SIG);
+	rc = sys_rseq(&__rseq_abi, RSEQ_LEN_EXPECTED, RSEQ_FLAG_UNREGISTER, RSEQ_SIG);
 	if (!rc)
 		goto end;
 	__rseq_refcount = 1;
-- 
2.17.1


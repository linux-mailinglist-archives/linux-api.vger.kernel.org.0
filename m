Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0CD45E6064
	for <lists+linux-api@lfdr.de>; Thu, 22 Sep 2022 13:05:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbiIVLFX (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 22 Sep 2022 07:05:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230265AbiIVLFT (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 22 Sep 2022 07:05:19 -0400
X-Greylist: delayed 329 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 22 Sep 2022 04:05:15 PDT
Received: from smtpout.efficios.com (smtpout.efficios.com [IPv6:2607:5300:203:5aae::31e5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6897BD5774;
        Thu, 22 Sep 2022 04:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1663844383;
        bh=YAwP6DkbOJBcsKrzPF8S0oe3UEgm+Ijtk/YzWr+PCjk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZJ5ivquivigWWu39pheY6F4yr9fpiOhMVmEYNkfcuoW86qbcYxpJGkmr4hcBd2rmX
         TcQJQ0jdMF1G2hLnNFeFU0y7BUIN16XK2LIs8r1sjy9jBFAuLw9WiJPEb1dfA9srWa
         cmsPiB/teQZN8NfzNGzj2iuYIM+zujtyTKdrICN6anY9Q0IRk2hjsdluV7DN23V8PX
         nRB7gwsKDQFYdRHQCiujCOvEUIk7ebf9yuwQDF44//SlikJEpsTmBtYeaTwiMfM5ek
         Un8lz5HIWnGomdm3G0lXyoeroPOGVpjZIrCUQZN8T7Mr+ht7Pxus2J/7rA4JFESHeW
         0kukeqUdhL3Mw==
Received: from localhost.localdomain (192-222-180-24.qc.cable.ebox.net [192.222.180.24])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4MYC3M0qNMzNF8;
        Thu, 22 Sep 2022 06:59:43 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        linux-api@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
        Florian Weimer <fw@deneb.enyo.de>, David.Laight@ACULAB.COM,
        carlos@redhat.com, Peter Oskolkov <posk@posk.io>,
        Alexander Mikhalitsyn <alexander@mihalicyn.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH v4 03/25] rseq: Extend struct rseq with numa node id
Date:   Thu, 22 Sep 2022 06:59:18 -0400
Message-Id: <20220922105941.237830-4-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220922105941.237830-1-mathieu.desnoyers@efficios.com>
References: <20220922105941.237830-1-mathieu.desnoyers@efficios.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Adding the NUMA node id to struct rseq is a straightforward thing to do,
and a good way to figure out if anything in the user-space ecosystem
prevents extending struct rseq.

This NUMA node id field allows memory allocators such as tcmalloc to
take advantage of fast access to the current NUMA node id to perform
NUMA-aware memory allocation.

It can also be useful for implementing fast-paths for NUMA-aware
user-space mutexes.

It also allows implementing getcpu(2) purely in user-space.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 include/trace/events/rseq.h |  4 +++-
 include/uapi/linux/rseq.h   |  8 ++++++++
 kernel/rseq.c               | 19 +++++++++++++------
 3 files changed, 24 insertions(+), 7 deletions(-)

diff --git a/include/trace/events/rseq.h b/include/trace/events/rseq.h
index a04a64bc1a00..6bd442697354 100644
--- a/include/trace/events/rseq.h
+++ b/include/trace/events/rseq.h
@@ -16,13 +16,15 @@ TRACE_EVENT(rseq_update,
 
 	TP_STRUCT__entry(
 		__field(s32, cpu_id)
+		__field(s32, node_id)
 	),
 
 	TP_fast_assign(
 		__entry->cpu_id = raw_smp_processor_id();
+		__entry->node_id = cpu_to_node(raw_smp_processor_id());
 	),
 
-	TP_printk("cpu_id=%d", __entry->cpu_id)
+	TP_printk("cpu_id=%d node_id=%d", __entry->cpu_id, __entry->node_id)
 );
 
 TRACE_EVENT(rseq_ip_fixup,
diff --git a/include/uapi/linux/rseq.h b/include/uapi/linux/rseq.h
index 05d3c4cdeb40..1cb90a435c5c 100644
--- a/include/uapi/linux/rseq.h
+++ b/include/uapi/linux/rseq.h
@@ -131,6 +131,14 @@ struct rseq {
 	 */
 	__u32 flags;
 
+	/*
+	 * Restartable sequences node_id field. Updated by the kernel. Read by
+	 * user-space with single-copy atomicity semantics. This field should
+	 * only be read by the thread which registered this data structure.
+	 * Aligned on 32-bit. Contains the current NUMA node ID.
+	 */
+	__u32 node_id;
+
 	/*
 	 * Flexible array member at end of structure, after last feature field.
 	 */
diff --git a/kernel/rseq.c b/kernel/rseq.c
index 46dc5c2ce2b7..cb7d8a5afc82 100644
--- a/kernel/rseq.c
+++ b/kernel/rseq.c
@@ -84,15 +84,17 @@
  *   F1. <failure>
  */
 
-static int rseq_update_cpu_id(struct task_struct *t)
+static int rseq_update_cpu_node_id(struct task_struct *t)
 {
-	u32 cpu_id = raw_smp_processor_id();
 	struct rseq __user *rseq = t->rseq;
+	u32 cpu_id = raw_smp_processor_id();
+	u32 node_id = cpu_to_node(cpu_id);
 
 	if (!user_write_access_begin(rseq, t->rseq_len))
 		goto efault;
 	unsafe_put_user(cpu_id, &rseq->cpu_id_start, efault_end);
 	unsafe_put_user(cpu_id, &rseq->cpu_id, efault_end);
+	unsafe_put_user(node_id, &rseq->node_id, efault_end);
 	/*
 	 * Additional feature fields added after ORIG_RSEQ_SIZE
 	 * need to be conditionally updated only if
@@ -108,9 +110,9 @@ static int rseq_update_cpu_id(struct task_struct *t)
 	return -EFAULT;
 }
 
-static int rseq_reset_rseq_cpu_id(struct task_struct *t)
+static int rseq_reset_rseq_cpu_node_id(struct task_struct *t)
 {
-	u32 cpu_id_start = 0, cpu_id = RSEQ_CPU_ID_UNINITIALIZED;
+	u32 cpu_id_start = 0, cpu_id = RSEQ_CPU_ID_UNINITIALIZED, node_id = 0;
 
 	/*
 	 * Reset cpu_id_start to its initial state (0).
@@ -124,6 +126,11 @@ static int rseq_reset_rseq_cpu_id(struct task_struct *t)
 	 */
 	if (put_user(cpu_id, &t->rseq->cpu_id))
 		return -EFAULT;
+	/*
+	 * Reset node_id to its initial state (0).
+	 */
+	if (put_user(node_id, &t->rseq->node_id))
+		return -EFAULT;
 	/*
 	 * Additional feature fields added after ORIG_RSEQ_SIZE
 	 * need to be conditionally reset only if
@@ -306,7 +313,7 @@ void __rseq_handle_notify_resume(struct ksignal *ksig, struct pt_regs *regs)
 		if (unlikely(ret < 0))
 			goto error;
 	}
-	if (unlikely(rseq_update_cpu_id(t)))
+	if (unlikely(rseq_update_cpu_node_id(t)))
 		goto error;
 	return;
 
@@ -353,7 +360,7 @@ SYSCALL_DEFINE4(rseq, struct rseq __user *, rseq, u32, rseq_len,
 			return -EINVAL;
 		if (current->rseq_sig != sig)
 			return -EPERM;
-		ret = rseq_reset_rseq_cpu_id(current);
+		ret = rseq_reset_rseq_cpu_node_id(current);
 		if (ret)
 			return ret;
 		current->rseq = NULL;
-- 
2.25.1


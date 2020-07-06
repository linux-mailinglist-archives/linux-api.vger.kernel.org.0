Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA5EC216087
	for <lists+linux-api@lfdr.de>; Mon,  6 Jul 2020 22:49:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727063AbgGFUtq (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 6 Jul 2020 16:49:46 -0400
Received: from mail.efficios.com ([167.114.26.124]:57036 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726915AbgGFUtp (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 6 Jul 2020 16:49:45 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 864182DCBC1;
        Mon,  6 Jul 2020 16:49:44 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 4s6JLSRq24oJ; Mon,  6 Jul 2020 16:49:44 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id D55052DCAC7;
        Mon,  6 Jul 2020 16:49:42 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com D55052DCAC7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1594068582;
        bh=rN5G63HY20iVL5jdiy3A5QPcL3ii8OKrJYS4rK5ji/k=;
        h=From:To:Date:Message-Id;
        b=GuVCBKDX+iEeZ+68jWrZCmVp9U0YVO8+SWqblfdPSroaxAz2qHcsxeKjgaX5W1Zvw
         GkZhyoZmWCgXTFC8K/PRMCKM00vcSbhMU4siQRYj5LFUdJKNeLGhLdwJUEFu+H5PVI
         opm8wDQimHONpUVwtu58Y35Z2bBchP5ZB7rEaVnGPHxwm0uMHBwf6VEaHxivuGzAly
         PEfQg06ZHtvsh4OIOfbDl7fB7MNue3h9CA55EbUCK9MZAtrVDBeJrZlTgFQ9lXyzTC
         oL89anirwILBOTltIkRJbV/uakxe27/YVPQKZ32aV1WCfxdZiAvpiQTBGWfaTOZF7I
         9X3QELa9+0C2Q==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ZL6wLRdCWb7k; Mon,  6 Jul 2020 16:49:42 -0400 (EDT)
Received: from localhost.localdomain (192-222-181-218.qc.cable.ebox.net [192.222.181.218])
        by mail.efficios.com (Postfix) with ESMTPSA id 1940F2DCAC6;
        Mon,  6 Jul 2020 16:49:42 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E . McKenney" <paulmck@linux.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        linux-api@vger.kernel.org, Florian Weimer <fw@deneb.enyo.de>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Neel Natu <neelnatu@google.com>
Subject: [RFC PATCH for 5.8 3/4] rseq: Introduce RSEQ_FLAG_RELIABLE_CPU_ID
Date:   Mon,  6 Jul 2020 16:49:12 -0400
Message-Id: <20200706204913.20347-4-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200706204913.20347-1-mathieu.desnoyers@efficios.com>
References: <20200706204913.20347-1-mathieu.desnoyers@efficios.com>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

commit 93b585c08d16 ("Fix: sched: unreliable rseq cpu_id for new tasks")
addresses an issue with cpu_id field of newly created processes. Expose
a flag which can be used by user-space to query whether the kernel
implements this fix.

Considering that this issue can cause corruption of user-space per-cpu
data updated with rseq, it is recommended that user-space detects
availability of this fix by using the RSEQ_FLAG_RELIABLE_CPU_ID flag
either combined with registration or on its own before using rseq.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Florian Weimer <fw@deneb.enyo.de>
Cc: "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: "H . Peter Anvin" <hpa@zytor.com>
Cc: Paul Turner <pjt@google.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Neel Natu <neelnatu@google.com>
Cc: linux-api@vger.kernel.org
---
 include/uapi/linux/rseq.h | 5 +++++
 kernel/rseq.c             | 4 ++++
 2 files changed, 9 insertions(+)

diff --git a/include/uapi/linux/rseq.h b/include/uapi/linux/rseq.h
index 3b5fba25461a..a548b77c9520 100644
--- a/include/uapi/linux/rseq.h
+++ b/include/uapi/linux/rseq.h
@@ -21,13 +21,18 @@ enum rseq_cpu_id_state {
 /*
  * RSEQ_FLAG_UNREGISTER:       Unregister rseq ABI for caller thread.
  * RSEQ_FLAG_REGISTER:         Register rseq ABI for caller thread.
+ * RSEQ_FLAG_RELIABLE_CPU_ID:  rseq provides a reliable cpu_id field.
  *
  * Flag value 0 has the same behavior as RSEQ_FLAG_REGISTER, but cannot be
  * combined with other flags. This behavior is kept for backward compatibility.
+ *
+ * The flag RSEQ_FLAG_REGISTER can be combined with the RSEQ_FLAG_RELIABLE_CPU_ID
+ * flag.
  */
 enum rseq_flags {
 	RSEQ_FLAG_UNREGISTER			= (1 << 0),
 	RSEQ_FLAG_REGISTER			= (1 << 1),
+	RSEQ_FLAG_RELIABLE_CPU_ID		= (1 << 2),
 };
 
 enum rseq_cs_flags_bit {
diff --git a/kernel/rseq.c b/kernel/rseq.c
index 47ce221cd6f9..32cc2e0d961f 100644
--- a/kernel/rseq.c
+++ b/kernel/rseq.c
@@ -333,6 +333,8 @@ SYSCALL_DEFINE4(rseq, struct rseq __user *, rseq, u32, rseq_len,
 		current->rseq_sig = 0;
 		break;
 	case RSEQ_FLAG_REGISTER:
+		fallthrough;
+	case RSEQ_FLAG_REGISTER | RSEQ_FLAG_RELIABLE_CPU_ID:
 		if (current->rseq) {
 			/*
 			 * If rseq is already registered, check whether
@@ -365,6 +367,8 @@ SYSCALL_DEFINE4(rseq, struct rseq __user *, rseq, u32, rseq_len,
 		 */
 		rseq_set_notify_resume(current);
 		break;
+	case RSEQ_FLAG_RELIABLE_CPU_ID:
+		break;
 	default:
 		return -EINVAL;
 	}
-- 
2.17.1


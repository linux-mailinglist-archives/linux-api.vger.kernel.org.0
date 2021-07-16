Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E81453CBC16
	for <lists+linux-api@lfdr.de>; Fri, 16 Jul 2021 20:47:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232452AbhGPSup (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 16 Jul 2021 14:50:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232403AbhGPSuj (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 16 Jul 2021 14:50:39 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6357BC061768
        for <linux-api@vger.kernel.org>; Fri, 16 Jul 2021 11:47:33 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id t9so10831454pgn.4
        for <linux-api@vger.kernel.org>; Fri, 16 Jul 2021 11:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=posk.io; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HYSiVE7XjB1Ew8WItN7rDm+Y+y3XNGUOiTyT30oxATI=;
        b=fgnEwuEoLDxYvND1A6Em6xlmEmKOyoIci0b04rgBH2/p6gc9/2iByTQQNi8uHhQoG7
         YrYuRv6UemIjkvr2RH5wryh9wrzWWlh+kptjlGs1P6H9btVY18QqodhBI+0pxQiBCBZm
         tTNmDT5ddasO6IsPVgcPUAU+gTEZyEPPIHjHFF3z6DDy62b03bq0k1qEgMviqm3jpvKU
         eUevMx9o9r1uOX/PDCFPzxeIcgrSBYStnBtiK2yGgTdQqv9BmgmiL+P5ME+K5t6Xd8zu
         dkz9fgdujxHinKOGAdWNERhxDLkjFPJIVaTQEMgbVhCwgSJqB4JF9fFweDumnG/a4gU1
         c6bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HYSiVE7XjB1Ew8WItN7rDm+Y+y3XNGUOiTyT30oxATI=;
        b=SOo26BnepQFfYUt1kTKXWEH8PaoAF5+Ky7C1FJf7i1OdpHyCGZX4bXwNdJ3uiRLX4B
         8j4V5dCs7H3bhtMV7zxnSGh/HzsnOQ3KDBanJh2spIiBa1PyZdZ70Se93GDyeAm+o0Ii
         OMgPoRdzL8f8qlLodLhSJsPoNb+PnVUAAc6u5rJsSYsryqPZyB/u4LQQ5lildCPwEu1U
         BDLUbXrJrV43YAven/ho/XsN0NbMyqT6FGN9xdqJNifv4iK6mknUM/fHjDyGRKUSrt8+
         DHrLQ7BzpsTNHijmuRvq+4O45Jqsg10THpC4XN4WJ9dNjxVdQgyzQaiqGRoR1GLnhHkT
         WdrQ==
X-Gm-Message-State: AOAM531c4ShsBuaCMXPYgg7OxgW1w457L9n4cb1JEmH7ZYbeXtmvs9fQ
        rRu/leJGdiIr5RcXe7MGrlFc9w==
X-Google-Smtp-Source: ABdhPJz1CAcw8vki0KV/s0MVBAZz8FhSo9QX60bB6rAkOo6/hQ/rsQOg1CaDmF8wmdLBN8/lz0kFmA==
X-Received: by 2002:a63:e958:: with SMTP id q24mr11384461pgj.438.1626461252993;
        Fri, 16 Jul 2021 11:47:32 -0700 (PDT)
Received: from localhost.localdomain (23-118-52-46.lightspeed.sntcca.sbcglobal.net. [23.118.52.46])
        by smtp.gmail.com with ESMTPSA id q125sm3170240pga.87.2021.07.16.11.47.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jul 2021 11:47:32 -0700 (PDT)
From:   Peter Oskolkov <posk@posk.io>
X-Google-Original-From: Peter Oskolkov <posk@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Cc:     Paul Turner <pjt@google.com>, Ben Segall <bsegall@google.com>,
        Peter Oskolkov <posk@google.com>,
        Peter Oskolkov <posk@posk.io>,
        Joel Fernandes <joel@joelfernandes.org>,
        Andrei Vagin <avagin@google.com>,
        Jim Newsome <jnewsome@torproject.org>,
        Jann Horn <jannh@google.com>,
        Thierry Delisle <tdelisle@uwaterloo.ca>
Subject: [RFC PATCH 3/4 v0.3] sched/umcg: RFC: add userspace sll helpers
Date:   Fri, 16 Jul 2021 11:47:18 -0700
Message-Id: <20210716184719.269033-4-posk@google.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210716184719.269033-1-posk@google.com>
References: <20210716184719.269033-1-posk@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

The helpers below can work with userspace single-linked lists concurrently
without indefinitely spinning in the kernel. Specifically:

push (add to the head of the list):

  step = 0
  while (++step < N)
     old = *head
     *next = old
     cmp_xchng(head, &old, next)

pop (remove the first element from the list):
    mark the node as deleted by flipping its lowest bit without
    actually removing the node from the list:

  curr = *head
  step = 0

  while (curr && ++step < N)

	next = *curr
	if (next & 1)
		curr = next & ~1
		continue

	if (cmp_xchng(curr, next, next | 1))
		return curr
	else
		curr = next & ~1

It is the userspace's responsibility to actually remove the
nodes marked as deleted from the list.

v0.2->v0.3 changes:
  - removed spinning from the kernel (other than capped cmpxchg).

Signed-off-by: Peter Oskolkov <posk@google.com>
---
 kernel/sched/umcg.h | 116 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 116 insertions(+)

diff --git a/kernel/sched/umcg.h b/kernel/sched/umcg.h
index 288017f5368c..435531d751f2 100644
--- a/kernel/sched/umcg.h
+++ b/kernel/sched/umcg.h
@@ -165,5 +165,121 @@ static inline int cmpxchg_user_64(u64 __user *uaddr, u64 *old, u64 new)
 	ret;								\
 })

+/**
+ * umcg_sll_push - push a node onto a single-linked-list (stack) in userspace
+ * @head      - a pointer to the head of the stack;
+ * @node      - a pointer to the node to push;
+ * @max_tries - the maximum number of attempts to push the node onto the list.
+ *
+ * Push a node onto a single-linked list (stack). The function tries
+ * @max_tries times and returns -EAGAIN if too many concurrent updates, so that
+ * the caller may yield the CPU.
+ *
+ * Return:
+ * 0        - success;
+ * -EFAULT  - error;
+ * -EAGAIN  - try again.
+ */
+static inline int umcg_sll_push(u64 __user *head, u64 __user *node, int max_tries)
+{
+	int step;
+
+	for (step = 0; step < max_tries; step++) {
+		int ret;
+		u64 first;
+
+		smp_mb();  /* Make the read below clean. */
+		if (get_user(first, head))
+			return -EFAULT;
+
+		if (put_user(first, node))
+			return -EFAULT;
+		smp_mb();  /* Make the write above visible. */
+
+		ret = cmpxchg_user_64(head, &first, (u64)node);
+		if (!ret)
+			return 0;
+
+		if (ret == -EAGAIN) {
+			cpu_relax();
+			continue;
+		}
+
+		if (WARN_ONCE(ret != -EFAULT, "unexpected umcg_cmpxchg result"))
+			return -EFAULT;
+
+		return -EFAULT;
+	}
+
+	return -EAGAIN;
+}
+
+/**
+ * umcg_sll_pop - pop a node from a single-linked-list (stack) in the userspace
+ * @head      - a pointer to the head of the stack;
+ * @value     - a pointer to where store the popped value;
+ * @max_tries - the maximum number of nodes to try to pop.
+ *
+ * Pop a node from a single-linked list (stack). Internally, popped nodes
+ * are marked as such, and not actually removed from the list, to avoid
+ * the ABA problem. It is the responsibility of the userspace to do GC.
+ *
+ * As an additional protection, the function checks only the first
+ * @max_tries nodes.
+ *
+ * Note: on success, @value should be cast to (u64 __user *) if not zero.
+ *
+ * Return:
+ * 0        - success;
+ * -EFAULT  - error;
+ * -EAGAIN  - try again.
+ */
+static inline int umcg_sll_pop(u64 __user *head, u64 *value, int max_tries)
+{
+	int step;
+	u64 curr;
+
+	smp_mb();  /* Make the read below clean. */
+	if (get_user(curr, head))
+		return -EFAULT;
+
+	for (step = 0; step < max_tries; step++) {
+		int ret;
+		u64 next;
+
+		if (!curr) {
+			*value = 0UL;
+			return 0;
+		}
+
+		if (curr & 1UL)
+			return -EFAULT;  /* Should not happen. */
+
+		smp_mb();  /* Make the read below clean. */
+		if (get_user(next, (u64 __user *)curr))
+			return -EFAULT;
+
+		if (next & 1UL) { /* curr is deleted */
+			curr = next & ~1UL;
+			continue;
+		}
+
+		ret = cmpxchg_user_64((u64 __user *)curr, &next, next | 1UL);
+		if (!ret) {
+			*value = curr;
+			return 0;
+		}
+		if (ret == -EAGAIN) {
+			curr = next & ~1UL;
+			cpu_relax();
+			continue;
+		}
+
+		if (ret)
+			return -EFAULT;
+	}
+
+	return -EAGAIN;
+}
 #endif  /* CONFIG_X86_64 */
 #endif  /* _KERNEL_SCHED_UMCG_H */
--
2.25.1


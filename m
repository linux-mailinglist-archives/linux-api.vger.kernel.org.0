Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9DD83213CB
	for <lists+linux-api@lfdr.de>; Mon, 22 Feb 2021 11:09:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230312AbhBVKJl (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 22 Feb 2021 05:09:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230430AbhBVKHJ (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 22 Feb 2021 05:07:09 -0500
Received: from mail-lj1-x249.google.com (mail-lj1-x249.google.com [IPv6:2a00:1450:4864:20::249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4032EC0617AA
        for <linux-api@vger.kernel.org>; Mon, 22 Feb 2021 02:05:18 -0800 (PST)
Received: by mail-lj1-x249.google.com with SMTP id h28so5290900lji.20
        for <linux-api@vger.kernel.org>; Mon, 22 Feb 2021 02:05:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=HAlNXozqX9ktnkUu4jC8ShsKasBf/lGNx2LEBgLBBTs=;
        b=nmjk8ojRochjyOzQEglhDpzJdpBBsPPhrjob//aOe9JkCotAcObhJdJCd/ia6o7xYw
         hY+Nwu0I3X4NMc/6cykncCNkyesyGbnmnKlKLcIe35SbeQNbWPNTTtDpk47XVVdHin4j
         iWqQblXj/Wtk8vSXLpyl3aFTUf1qV5hjbyriK4Q7dY0M9l3zrPkJjl2JLDtSsw1ua3bi
         JgHqfTzlR4pFX+jljVfkZuknvN9nYarZ7o1aGrygpmpyPcq4S4E1QQjD/s2hNm0qQakX
         9FjVuYloD6Imgv6XwfYyKh5QDkypbG+cKLhDNPNJ+KKCj3O5N1CdsO188F8I2nQ3V7zU
         GRQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=HAlNXozqX9ktnkUu4jC8ShsKasBf/lGNx2LEBgLBBTs=;
        b=E+KW08mToxOe4yduAHHucloWOie3CmdRnLMCpfZG5MhcF3olj9ZhiixV27XOs/Jmtc
         QhnwSr50GM0COUf59tp8UPIO6XRsSAEU2jXarLg7YJm2aUvVYa11tH9+7MxYklGwXY2w
         uvvx2vfX+qP59NOFkg5tBNCTH+cv5cWxvbz31or6ebbv2ZLZDYnorBU9T7eN1ncZXFAE
         qWrcABl6KIgNp3tatU7BxTyZ1078o4EVARp6SNHncinV2Igt6s9PXXAU0mju2L03tEiv
         Y9RfaHUTbm7K9E9HWrRdtTaH1XQl1mW09DDgDL3WX5TUIryxBN6a9MrrqLJViowS4uyp
         tXhw==
X-Gm-Message-State: AOAM531k4pzFR5u0w0jz9ZPNSONkkVAh1Hc4UVTPXxB9wtIQwVmQk2Hj
        JPOCzmnCytxeZTZVCnIw5yoxuk7HKlU=
X-Google-Smtp-Source: ABdhPJw/fbF4KyyczueUKrx8WTf1vLbXQzsQll7nbv32NTG0y8vwcMQq/G8gehT6GoSeKnRlLnvUOC5HIO4=
Sender: "figiel via sendgmr" <figiel@odra.waw.corp.google.com>
X-Received: from odra.waw.corp.google.com ([2a00:79e0:2:11:6904:20e5:9b8e:70ff])
 (user=figiel job=sendgmr) by 2002:a2e:6a11:: with SMTP id f17mr14482103ljc.14.1613988316410;
 Mon, 22 Feb 2021 02:05:16 -0800 (PST)
Date:   Mon, 22 Feb 2021 11:04:43 +0100
Message-Id: <20210222100443.4155938-1-figiel@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.617.g56c4b15f3c-goog
Subject: [PATCH] ptrace: add PTRACE_GET_RSEQ_CONFIGURATION request
From:   Piotr Figiel <figiel@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        mathieu.desnoyers@efficios.com, peterz@infradead.org,
        paulmck@kernel.org, boqun.feng@gmail.com, oleg@redhat.com
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        Andrei Vagin <avagin@gmail.com>, linux-kernel@vger.kernel.org,
        posk@google.com, kyurtsever@google.com, ckennelly@google.com,
        pjt@google.com, emmir@google.com, linux-man@vger.kernel.org,
        linux-api@vger.kernel.org, Piotr Figiel <figiel@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

For userspace checkpoint and restore (C/R) a way of getting process state
containing RSEQ configuration is needed.

There are two ways this information is going to be used:
 - to re-enable RSEQ for threads which had it enabled before C/R
 - to detect if a thread was in a critical section during C/R

Since C/R preserves TLS memory and addresses RSEQ ABI will be restored
using the address registered before C/R.

Detection whether the thread is in a critical section during C/R is needed
to enforce behavior of RSEQ abort during C/R. Attaching with ptrace()
before registers are dumped itself doesn't cause RSEQ abort.
Restoring the instruction pointer within the critical section is
problematic because rseq_cs may get cleared before the control is passed
to the migrated application code leading to RSEQ invariants not being
preserved. C/R code will use RSEQ ABI address to find the abort handler
to which the instruction pointer needs to be set.

To achieve above goals expose the RSEQ ABI address and the signature value
with the new ptrace request PTRACE_GET_RSEQ_CONFIGURATION.

This new ptrace request can also be used by debuggers so they are aware
of stops within restartable sequences in progress.

Signed-off-by: Piotr Figiel <figiel@google.com>
Reviewed-by: Michal Miroslaw <emmir@google.com>

---
 include/uapi/linux/ptrace.h |  8 ++++++++
 kernel/ptrace.c             | 23 +++++++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/include/uapi/linux/ptrace.h b/include/uapi/linux/ptrace.h
index 83ee45fa634b..d54cf6b6ce7c 100644
--- a/include/uapi/linux/ptrace.h
+++ b/include/uapi/linux/ptrace.h
@@ -102,6 +102,14 @@ struct ptrace_syscall_info {
 	};
 };
 
+#define PTRACE_GET_RSEQ_CONFIGURATION	0x420f
+
+struct ptrace_rseq_configuration {
+	__u64 rseq_abi_pointer;
+	__u32 signature;
+	__u32 pad;
+};
+
 /*
  * These values are stored in task->ptrace_message
  * by tracehook_report_syscall_* to describe the current syscall-stop.
diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index 61db50f7ca86..a936af66cf6f 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -31,6 +31,7 @@
 #include <linux/cn_proc.h>
 #include <linux/compat.h>
 #include <linux/sched/signal.h>
+#include <linux/minmax.h>
 
 #include <asm/syscall.h>	/* for syscall_get_* */
 
@@ -779,6 +780,22 @@ static int ptrace_peek_siginfo(struct task_struct *child,
 	return ret;
 }
 
+#ifdef CONFIG_RSEQ
+static long ptrace_get_rseq_configuration(struct task_struct *task,
+					  unsigned long size, void __user *data)
+{
+	struct ptrace_rseq_configuration conf = {
+		.rseq_abi_pointer = (u64)(uintptr_t)task->rseq,
+		.signature = task->rseq_sig,
+	};
+
+	size = min_t(unsigned long, size, sizeof(conf));
+	if (copy_to_user(data, &conf, size))
+		return -EFAULT;
+	return size;
+}
+#endif
+
 #ifdef PTRACE_SINGLESTEP
 #define is_singlestep(request)		((request) == PTRACE_SINGLESTEP)
 #else
@@ -1222,6 +1239,12 @@ int ptrace_request(struct task_struct *child, long request,
 		ret = seccomp_get_metadata(child, addr, datavp);
 		break;
 
+#ifdef CONFIG_RSEQ
+	case PTRACE_GET_RSEQ_CONFIGURATION:
+		ret = ptrace_get_rseq_configuration(child, addr, datavp);
+		break;
+#endif
+
 	default:
 		break;
 	}
-- 
2.30.0.617.g56c4b15f3c-goog


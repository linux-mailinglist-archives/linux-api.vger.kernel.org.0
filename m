Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8AA1C6D52F
	for <lists+linux-api@lfdr.de>; Thu, 18 Jul 2019 21:47:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404084AbfGRTp1 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 18 Jul 2019 15:45:27 -0400
Received: from mail-ua1-f73.google.com ([209.85.222.73]:34321 "EHLO
        mail-ua1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404052AbfGRTpW (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 18 Jul 2019 15:45:22 -0400
Received: by mail-ua1-f73.google.com with SMTP id d16so2807897uaq.1
        for <linux-api@vger.kernel.org>; Thu, 18 Jul 2019 12:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=GlHyjiKYcevEFIyOZW8SL29SSZvUxPfaX8jHBCGYcts=;
        b=KjZeWxLzRjaEewcNpBwxH4bE4M0nnZ1BuixJyCLfzZCmjc13Tv1LVmxIlZh2L4CiZN
         GtxNdz5wNF+CzOZuTHsFYtDsOCj9ZY2bqHZifpLTMjBjqBq00YYNTbIn0Jew8W5q70Vl
         XTyheqJWhQwlcD8q9h9ZW6ohwqh5wGDGcIUK8H7cpd3liEBEVHpdtMPf+RaVR1KN+z45
         1Imx51gl8srUzXKQh0pncST/cmOc7izMujQraVKmwwviPQdZaaB+gINNpZJSjPsOGdcP
         mb7uDRnKnZEqtmSXwP9DOU1nE59u2XmNfPTfBuGPHJ9Q34GZWiZJOKvcpNYUAZJJaqwZ
         ouDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=GlHyjiKYcevEFIyOZW8SL29SSZvUxPfaX8jHBCGYcts=;
        b=C62GJpoz1eFzgbIqu25W6IpX7YPkcvQdsU8aaETF7yROzGZXQZCpXTD62Gu+pCCq9L
         mXXIy0RHrR72KxSNRUhq6g3leX7dUvRONmJFHANAFaqxPssZ7Y/BUjBVLcW+NguOkY5j
         xHEoRjemrc2JcKAGc+tob8jiCK8Z5P7qhfKXFXkUwE716h1QY8bqzcAxL8XTweZsKpsw
         j4xX8wVUzDTHdvXSgvLmA0ZWsLLG+nB26RC7QlRQRxC2KFxuNZKb+JoKjpReQuV1uV5m
         UWXpuHhGDPaOGhyljDdkfye4f3CIVzjU76V4mZL6xNPzTkiStCGGpQ30+SpfcZ5PjVJC
         2Jcw==
X-Gm-Message-State: APjAAAXeai2gEMDTor1ArXmewXoG+8V3ddxfECtRoOnWm/XThTnFatpq
        PPHaQZb+kaZ6J3vOQYU/C17cbJt5ZxjU/wXwhSrFgQ==
X-Google-Smtp-Source: APXvYqzqfSSnMa83xZI4pbsWAteKtmq2fSntxtFajOxrJ53OslB4e9IXvjgwNQNVpEM39FEfNiu2Is+F0l5fFdtxv4bk1A==
X-Received: by 2002:ab0:308c:: with SMTP id h12mr29575921ual.72.1563479120915;
 Thu, 18 Jul 2019 12:45:20 -0700 (PDT)
Date:   Thu, 18 Jul 2019 12:44:10 -0700
In-Reply-To: <20190718194415.108476-1-matthewgarrett@google.com>
Message-Id: <20190718194415.108476-25-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190718194415.108476-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.22.0.510.g264f2c817a-goog
Subject: [PATCH V36 24/29] Lock down perf when in confidentiality mode
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        Matthew Garrett <mjg59@google.com>,
        Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

From: David Howells <dhowells@redhat.com>

Disallow the use of certain perf facilities that might allow userspace to
access kernel data.

Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Matthew Garrett <mjg59@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
---
 include/linux/security.h     | 1 +
 kernel/events/core.c         | 7 +++++++
 security/lockdown/lockdown.c | 1 +
 3 files changed, 9 insertions(+)

diff --git a/include/linux/security.h b/include/linux/security.h
index 8dd1741a52cd..8ef366de70b0 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -119,6 +119,7 @@ enum lockdown_reason {
 	LOCKDOWN_KCORE,
 	LOCKDOWN_KPROBES,
 	LOCKDOWN_BPF_READ,
+	LOCKDOWN_PERF,
 	LOCKDOWN_CONFIDENTIALITY_MAX,
 };
 
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 785d708f8553..738d6f1cf5ec 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -10806,6 +10806,13 @@ SYSCALL_DEFINE5(perf_event_open,
 	    perf_paranoid_kernel() && !capable(CAP_SYS_ADMIN))
 		return -EACCES;
 
+	err = security_locked_down(LOCKDOWN_PERF);
+	if (err && (attr.sample_type & PERF_SAMPLE_REGS_INTR))
+		/* REGS_INTR can leak data, lockdown must prevent this */
+		return err;
+
+	err = 0;
+
 	/*
 	 * In cgroup mode, the pid argument is used to pass the fd
 	 * opened to the cgroup directory in cgroupfs. The cpu argument
diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
index 1b89d3e8e54d..fb437a7ef5f2 100644
--- a/security/lockdown/lockdown.c
+++ b/security/lockdown/lockdown.c
@@ -34,6 +34,7 @@ static char *lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1] = {
 	[LOCKDOWN_KCORE] = "/proc/kcore access",
 	[LOCKDOWN_KPROBES] = "use of kprobes",
 	[LOCKDOWN_BPF_READ] = "use of bpf to read kernel RAM",
+	[LOCKDOWN_PERF] = "unsafe use of perf",
 	[LOCKDOWN_CONFIDENTIALITY_MAX] = "confidentiality",
 };
 
-- 
2.22.0.510.g264f2c817a-goog


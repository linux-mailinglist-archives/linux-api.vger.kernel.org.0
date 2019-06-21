Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 874E94DEA0
	for <lists+linux-api@lfdr.de>; Fri, 21 Jun 2019 03:23:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbfFUBVj (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 20 Jun 2019 21:21:39 -0400
Received: from mail-qk1-f201.google.com ([209.85.222.201]:33853 "EHLO
        mail-qk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726811AbfFUBUq (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 20 Jun 2019 21:20:46 -0400
Received: by mail-qk1-f201.google.com with SMTP id h198so5924535qke.1
        for <linux-api@vger.kernel.org>; Thu, 20 Jun 2019 18:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=rwC++06a7emXTczyYuhqKwwtVamKbzjmP5eAmmQf+uI=;
        b=qneJRbjWP0ZWGk0Np6UT3+Qp6gWjbiIxxvE4k42LU/v9AV3EispEPoiMKojKSgfgP3
         IDsHyaGL9JhBP3hSvMsBcS6+WA9lWH1SDz1eF3F1qD0g/DYVT9YQQi2/LDhgWUmDy4DH
         2Jb0NJtVy+rnWBVEMFzQ3jHOz4eylUaI1FsqdPKv40tJFl0XCjiMrmZWBrX9e62cII4i
         8YO590wyVDRsmWdCP+j3By9xhynKx1h2zUuQlRqwWYy/oyrvXhK10BxuOQhdRGmYRCHi
         CTT74lcfXtIUTtDrratlNy3w9wOHSchivveNBwqMdWuOJbudFsYSF/QWMHZvEO7rMzYF
         qtfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=rwC++06a7emXTczyYuhqKwwtVamKbzjmP5eAmmQf+uI=;
        b=kFDgjG4IUtyHhGnqC2oBtjBfZ5hntUQj6O0WVEMnfyFjCywAt7H4mBxpMNufKgbHWO
         Qm7swPtwaOwwoHthRtlfODe5xh5aoGrw8D5dBpLUoHi1c0Xstl4WtuBKxzajMlYjK1NI
         xEmV2uubVc2Mj/dxgVzeHPARnPcqmMjojmLypaDNC0qPdbRgHlIf7fPoWZ131Og60lNS
         aXwjHT8CUlWM7R7MTfYNPRnNaOthk6blVRF6Cg3Ojg4EaushpGYKgi2xQ7W6TN5TDR17
         GKjcd69bVvse5BmYerswiVrIRy2AW9oybp7Fd9Qjg0Oj2uxP9k+pOCMQnhb5PJmsN8rU
         6pag==
X-Gm-Message-State: APjAAAVMqFAM4LhyHHoguEIiwAYYGGDQG8dMOrCPDeWQ/+nomge/Of40
        zBi1uv6uOn0pJxtHZPyvanWvctM7VRgTMWxVFBZwnA==
X-Google-Smtp-Source: APXvYqyhiebJiF4BkrDZrHKoyqUV/pVArTTNDYY7GxukHPiXKoQy4FlhLxNmU2Vd+P0ehPu+dPTPNGR0lYBfm1MBD9qvdQ==
X-Received: by 2002:a37:b843:: with SMTP id i64mr15047820qkf.77.1561080045580;
 Thu, 20 Jun 2019 18:20:45 -0700 (PDT)
Date:   Thu, 20 Jun 2019 18:19:34 -0700
In-Reply-To: <20190621011941.186255-1-matthewgarrett@google.com>
Message-Id: <20190621011941.186255-24-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190621011941.186255-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH V33 23/30] Lock down tracing and perf kprobes when in
 confidentiality mode
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, David Howells <dhowells@redhat.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Matthew Garrett <mjg59@google.com>,
        "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        davem@davemloft.net, Masami Hiramatsu <mhiramat@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

From: David Howells <dhowells@redhat.com>

Disallow the creation of perf and ftrace kprobes when the kernel is
locked down in confidentiality mode by preventing their registration.
This prevents kprobes from being used to access kernel memory to steal
crypto data, but continues to allow the use of kprobes from signed
modules.

Reported-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Matthew Garrett <mjg59@google.com>
Cc: Naveen N. Rao <naveen.n.rao@linux.ibm.com>
Cc: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
Cc: davem@davemloft.net
Cc: Masami Hiramatsu <mhiramat@kernel.org>
---
 include/linux/security.h     | 1 +
 kernel/trace/trace_kprobe.c  | 4 ++++
 security/lockdown/lockdown.c | 1 +
 3 files changed, 6 insertions(+)

diff --git a/include/linux/security.h b/include/linux/security.h
index 6752584729e2..dae4aa83352c 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -96,6 +96,7 @@ enum lockdown_reason {
 	LOCKDOWN_MMIOTRACE,
 	LOCKDOWN_INTEGRITY_MAX,
 	LOCKDOWN_KCORE,
+	LOCKDOWN_KPROBES,
 	LOCKDOWN_CONFIDENTIALITY_MAX,
 };
 
diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 5d5129b05df7..940ca20987aa 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -11,6 +11,7 @@
 #include <linux/uaccess.h>
 #include <linux/rculist.h>
 #include <linux/error-injection.h>
+#include <linux/security.h>
 
 #include "trace_dynevent.h"
 #include "trace_kprobe_selftest.h"
@@ -415,6 +416,9 @@ static int __register_trace_kprobe(struct trace_kprobe *tk)
 {
 	int i, ret;
 
+	if (security_is_locked_down(LOCKDOWN_KPROBES))
+		return -EPERM;
+
 	if (trace_probe_is_registered(&tk->tp))
 		return -EINVAL;
 
diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
index 80ff4a31d8aa..89ad853daec2 100644
--- a/security/lockdown/lockdown.c
+++ b/security/lockdown/lockdown.c
@@ -32,6 +32,7 @@ static char *lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1] = {
 	[LOCKDOWN_MMIOTRACE] = "unsafe mmio",
 	[LOCKDOWN_INTEGRITY_MAX] = "integrity",
 	[LOCKDOWN_KCORE] = "/proc/kcore access",
+	[LOCKDOWN_KPROBES] = "use of kprobes",
 	[LOCKDOWN_CONFIDENTIALITY_MAX] = "confidentiality",
 };
 
-- 
2.22.0.410.gd8fdbe21b5-goog


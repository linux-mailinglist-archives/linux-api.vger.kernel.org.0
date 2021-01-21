Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2ABF02FEB7C
	for <lists+linux-api@lfdr.de>; Thu, 21 Jan 2021 14:21:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731670AbhAUNUq (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 21 Jan 2021 08:20:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731880AbhAUNUF (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 21 Jan 2021 08:20:05 -0500
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFD9DC061757
        for <linux-api@vger.kernel.org>; Thu, 21 Jan 2021 05:19:22 -0800 (PST)
Received: by mail-qt1-x84a.google.com with SMTP id b8so1397171qtr.18
        for <linux-api@vger.kernel.org>; Thu, 21 Jan 2021 05:19:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=i4YH3yLeIclRhhtAEf9273ZCA7Cxi6HCBtpgwrGQcZU=;
        b=sibTmKiLS9ajF4FE1rUs6hEKWQLhtFXelqmUugPjx/BwXAb19nRZuH5azNdMExPV8j
         2bVfJ8ahp97a3Sf+oNrY6vrPivAv2ANLtKGPx8GEGoeCsqx/aDG9DNOfM7WsfczQzxdv
         45VVZa9Li/fI2aLoMb2vPlCIiEw7CsMDRMlYACkZSVVZT292TOlGys0PdNDyL8/NkIkG
         YNYES0RZmp0BS71aOT0S23OLsNFfq23VTQL5eaAf1P/cGfztvVQSun1wDrbUMZDLuRHC
         elMCG1c1vNU/0rstvHTiWcFBYb1fYJiPs0r1lXdOP0odQ0H0IhvcixBrHEf7ThaCvMUw
         QMcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=i4YH3yLeIclRhhtAEf9273ZCA7Cxi6HCBtpgwrGQcZU=;
        b=ukANUqdI6gocDPlIPySn70RdaTl5JtpXzXcjZqahbKRk+30QMoN0DxFfqQGmRlSEq4
         2zaHWzHZipGPss8E1bbDBqr1jwemVj9U6Q1+j8RhD/SLXVfB5HFQYO++fWuOt1R+qEza
         LjqxlO4TW1HWOd4AKG8O7TNiAF0iAB80CB4W9rR3Cdfs4YBAIhMf0gi+ToWInUl6WKry
         RsgUFQuyD3TxTfDXQlKB6muxBMWrwl14CRBXe4nAVgOAJ9L8q60f9h8tu21hVCsBReSc
         XR8+79Iy3crGb+cZ8p7MwmqkCMOpkYsA2etH9TLH5dGvy4s9IpU816+QMCP/lQjOW2YZ
         HW7A==
X-Gm-Message-State: AOAM530SUVfD4Sf/17Xh9UGY7Ed4M6+V8WBRCqndJUSUSfN3nQ47ZBId
        KrFE3z6IyrPu+UBttoTQtHIhRK8cWdk=
X-Google-Smtp-Source: ABdhPJx7bFVBrO2SM5sg340Yp6559cJ8hXAbFop3C0sgAI2F2N9pzXbIGGX0yzZRy/LBdKjyMwx+2xX017k=
Sender: "glider via sendgmr" <glider@glider.muc.corp.google.com>
X-Received: from glider.muc.corp.google.com ([2a00:79e0:15:13:f693:9fff:fef4:9ff])
 (user=glider job=sendgmr) by 2002:a0c:8601:: with SMTP id p1mr14110664qva.22.1611235161865;
 Thu, 21 Jan 2021 05:19:21 -0800 (PST)
Date:   Thu, 21 Jan 2021 14:19:13 +0100
In-Reply-To: <20210121131915.1331302-1-glider@google.com>
Message-Id: <20210121131915.1331302-2-glider@google.com>
Mime-Version: 1.0
References: <20210121131915.1331302-1-glider@google.com>
X-Mailer: git-send-email 2.30.0.296.g2bfb1c46d8-goog
Subject: [PATCH v3 1/3] tracing: add error_report_end trace point
From:   Alexander Potapenko <glider@google.com>
To:     akpm@linux-foundation.org, glider@google.com
Cc:     elver@google.com, andreyknvl@google.com, dvyukov@google.com,
        mingo@redhat.com, pmladek@suse.com, rostedt@goodmis.org,
        sergey.senozhatsky@gmail.com, linux-mm@kvack.org,
        linux-api@vger.kernel.org, vbabka@suse.cz,
        gregkh@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Introduce error_report_end tracepoint. It can be used in debugging tools
like KASAN, KFENCE, etc. to provide extensions to the error reporting
mechanisms (e.g. allow tests hook into error reporting, ease error report
collection from production kernels).
Another benefit would be making use of ftrace for debugging or
benchmarking the tools themselves.

Should we need it, the tracepoint name leaves us with the possibility to
introduce a complementary error_report_start tracepoint in the future.

Suggested-by: Marco Elver <elver@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Andrey Konovalov <andreyknvl@google.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Marco Elver <elver@google.com>
Cc: Petr Mladek <pmladek@suse.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc: linux-mm@kvack.org
Cc: linux-api@vger.kernel.org
Signed-off-by: Alexander Potapenko <glider@google.com>

---
v3: - delete error_report_start that is unlikely to be unused in
      the nearest future
    - add missing copyright headers

v2: - change error_report_start and error_report_end prototypes
      to accept enum error_detector instead of char*
      (as suggested by Steven Rostedt)
---
 include/trace/events/error_report.h | 74 +++++++++++++++++++++++++++++
 kernel/trace/Makefile               |  1 +
 kernel/trace/error_report-traces.c  | 12 +++++
 3 files changed, 87 insertions(+)
 create mode 100644 include/trace/events/error_report.h
 create mode 100644 kernel/trace/error_report-traces.c

diff --git a/include/trace/events/error_report.h b/include/trace/events/error_report.h
new file mode 100644
index 000000000000..96f64bf218b2
--- /dev/null
+++ b/include/trace/events/error_report.h
@@ -0,0 +1,74 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Declarations for error reporting tracepoints.
+ *
+ * Copyright (C) 2021, Google LLC.
+ */
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM error_report
+
+#if !defined(_TRACE_ERROR_REPORT_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_ERROR_REPORT_H
+
+#include <linux/tracepoint.h>
+
+#ifndef __ERROR_REPORT_DECLARE_TRACE_ENUMS_ONCE_ONLY
+#define __ERROR_REPORT_DECLARE_TRACE_ENUMS_ONCE_ONLY
+
+enum error_detector {
+	ERROR_DETECTOR_KFENCE,
+	ERROR_DETECTOR_KASAN
+};
+
+#endif /* __ERROR_REPORT_DECLARE_TRACE_ENUMS_ONCE_ONLY */
+
+#define error_detector_list	\
+	EM(ERROR_DETECTOR_KFENCE, "kfence")	\
+	EMe(ERROR_DETECTOR_KASAN, "kasan")
+/* Always end the list with an EMe. */
+
+#undef EM
+#undef EMe
+
+#define EM(a, b)	TRACE_DEFINE_ENUM(a);
+#define EMe(a, b)	TRACE_DEFINE_ENUM(a);
+
+error_detector_list
+
+#undef EM
+#undef EMe
+
+#define EM(a, b) { a, b },
+#define EMe(a, b) { a, b }
+
+#define show_error_detector_list(val) \
+	__print_symbolic(val, error_detector_list)
+
+DECLARE_EVENT_CLASS(error_report_template,
+		    TP_PROTO(enum error_detector error_detector, unsigned long id),
+		    TP_ARGS(error_detector, id),
+		    TP_STRUCT__entry(__field(enum error_detector, error_detector)
+					     __field(unsigned long, id)),
+		    TP_fast_assign(__entry->error_detector = error_detector;
+				   __entry->id = id;),
+		    TP_printk("[%s] %lx",
+			      show_error_detector_list(__entry->error_detector),
+			      __entry->id));
+
+/**
+ * error_report_end - called after printing the error report
+ * @error_detector:	short string describing the error detection tool
+ * @id:			pseudo-unique descriptor identifying the report
+ *			(e.g. the memory access address)
+ *
+ * This event occurs right after a debugging tool finishes printing the error
+ * report.
+ */
+DEFINE_EVENT(error_report_template, error_report_end,
+	     TP_PROTO(enum error_detector error_detector, unsigned long id),
+	     TP_ARGS(error_detector, id));
+
+#endif /* _TRACE_ERROR_REPORT_H */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
diff --git a/kernel/trace/Makefile b/kernel/trace/Makefile
index 7e44cea89fdc..b28d3e5013cd 100644
--- a/kernel/trace/Makefile
+++ b/kernel/trace/Makefile
@@ -81,6 +81,7 @@ obj-$(CONFIG_SYNTH_EVENTS) += trace_events_synth.o
 obj-$(CONFIG_HIST_TRIGGERS) += trace_events_hist.o
 obj-$(CONFIG_BPF_EVENTS) += bpf_trace.o
 obj-$(CONFIG_KPROBE_EVENTS) += trace_kprobe.o
+obj-$(CONFIG_TRACEPOINTS) += error_report-traces.o
 obj-$(CONFIG_TRACEPOINTS) += power-traces.o
 ifeq ($(CONFIG_PM),y)
 obj-$(CONFIG_TRACEPOINTS) += rpm-traces.o
diff --git a/kernel/trace/error_report-traces.c b/kernel/trace/error_report-traces.c
new file mode 100644
index 000000000000..632c8c7ff079
--- /dev/null
+++ b/kernel/trace/error_report-traces.c
@@ -0,0 +1,12 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Error reporting trace points.
+ *
+ * Copyright (C) 2021, Google LLC.
+ */
+
+#define CREATE_TRACE_POINTS
+#include <trace/events/error_report.h>
+
+EXPORT_TRACEPOINT_SYMBOL_GPL(error_report_end);
+
-- 
2.30.0.296.g2bfb1c46d8-goog


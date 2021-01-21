Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0A872FEB7B
	for <lists+linux-api@lfdr.de>; Thu, 21 Jan 2021 14:21:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731513AbhAUNUo (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 21 Jan 2021 08:20:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731670AbhAUNUF (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 21 Jan 2021 08:20:05 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E844CC0613C1
        for <linux-api@vger.kernel.org>; Thu, 21 Jan 2021 05:19:24 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id b3so2146526yba.20
        for <linux-api@vger.kernel.org>; Thu, 21 Jan 2021 05:19:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=EZM8uwys0tIYTV5rV7IMpiN4Wky1Ucyd+XglcRPDA0k=;
        b=WFun/2AwoihyT9AoddjjkcKTUjc9aI3jv7IFGHwz+lYgIMz5b4WPNxXTiyzbrd+LJk
         WO3FxCB1Z/havwsDuvKosLXatsLCtqTnsMN3N5jAgG74u80nWFXEmQ+mBgYjdUB//JjX
         Q6kAQ+pAl8XYDz2Ei2+nblI2fGGTv+uKtJHtRqlXQfEDBJAQS+jkFBswpyKA8etRcnUH
         OOs71Y+Fd5/i9qecUzQiepvITmFqkejQn7UN/r27rnGMC+BNYBM5HmdI/y7s1YXWGRBt
         lfvhUY4CVirmJMHsy+tYXnPwttmMKEyvF9fWE1SPqi/BxiZHoPg/x/SPCfVGkwMJnOka
         xM9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=EZM8uwys0tIYTV5rV7IMpiN4Wky1Ucyd+XglcRPDA0k=;
        b=cbzWnDJExCSZmZmmECpx7z37sJ+mtMbK26zcYMjZkVGsEKQZeKoQ0rPQia7U9Vl3Ei
         qQf4whGgnM+oZf64N0ltEHC23beu0pZ97VdfY5MEtb0En6sanuMfvDpurQLfo928ZgMN
         QDmkaeb+hN23ot2bDbdMOnXR4fpmUCv1vPbiX12D7gl6wTogBZS4LCKkcHa0aH164Zuj
         x7PpQQ8jzc8bIWMbPzKuJ9kxrzzX1kSbh9Z0Daj4KA+sWs8wD8Xdkox8tTeqHa5ZD/hX
         IcsIr/LrqvNuLmwLeR5QAXU8GDow8WbsD7B/0ftw6UEofiElO9ccP6NNe+55y5AD6OXp
         5UWQ==
X-Gm-Message-State: AOAM533QpEYNzuZgbcLqiZrA5PfjHIqYgCcY1PSBYPnX1zffvjA1rkhp
        73FI99z6On9U2K6D5PxE9JE7pqynThk=
X-Google-Smtp-Source: ABdhPJwtDkTgRZRk3yc/3yCU/TR+GnrcNDSCBz+LT6IxxpACRB4tZzjHkAxKgNiuzuLPqOyxu2xUmBX1mnc=
Sender: "glider via sendgmr" <glider@glider.muc.corp.google.com>
X-Received: from glider.muc.corp.google.com ([2a00:79e0:15:13:f693:9fff:fef4:9ff])
 (user=glider job=sendgmr) by 2002:a25:3bc5:: with SMTP id i188mr20415374yba.332.1611235164118;
 Thu, 21 Jan 2021 05:19:24 -0800 (PST)
Date:   Thu, 21 Jan 2021 14:19:14 +0100
In-Reply-To: <20210121131915.1331302-1-glider@google.com>
Message-Id: <20210121131915.1331302-3-glider@google.com>
Mime-Version: 1.0
References: <20210121131915.1331302-1-glider@google.com>
X-Mailer: git-send-email 2.30.0.296.g2bfb1c46d8-goog
Subject: [PATCH 2/3] kfence: use error_report_end tracepoint
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

Make it possible to trace KFENCE error reporting. A good usecase is
watching for trace events from the userspace to detect and process
memory corruption reports from the kernel.

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
Signed-off-by: Alexander Potapenko <glider@google.com>

---
v3:
 - dropped error_report_start

v2:
 - change error_report_start and error_report_end prototypes
   to accept enum error_detector instead of char*
   (as suggested by Steven Rostedt)
---
 mm/kfence/report.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/kfence/report.c b/mm/kfence/report.c
index 901bd7ee83d8..f9fc93b2fe2e 100644
--- a/mm/kfence/report.c
+++ b/mm/kfence/report.c
@@ -14,6 +14,7 @@
 #include <linux/seq_file.h>
 #include <linux/stacktrace.h>
 #include <linux/string.h>
+#include <trace/events/error_report.h>
 
 #include <asm/kfence.h>
 
@@ -246,6 +247,7 @@ void kfence_report_error(unsigned long address, bool is_write, struct pt_regs *r
 		show_regs(regs);
 	else
 		dump_stack_print_info(KERN_ERR);
+	trace_error_report_end(ERROR_DETECTOR_KFENCE, address);
 	pr_err("==================================================================\n");
 
 	lockdep_on();
-- 
2.30.0.296.g2bfb1c46d8-goog


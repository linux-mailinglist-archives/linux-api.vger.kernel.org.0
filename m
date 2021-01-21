Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7F342FEF40
	for <lists+linux-api@lfdr.de>; Thu, 21 Jan 2021 16:44:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731382AbhAUNVY (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 21 Jan 2021 08:21:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731885AbhAUNUI (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 21 Jan 2021 08:20:08 -0500
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26E1CC0613CF
        for <linux-api@vger.kernel.org>; Thu, 21 Jan 2021 05:19:28 -0800 (PST)
Received: by mail-wr1-x449.google.com with SMTP id g16so1004271wrv.1
        for <linux-api@vger.kernel.org>; Thu, 21 Jan 2021 05:19:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=3UapMw1B/lQ8O8rK1t5yloPW20aKmQdYgqwziIYXJaY=;
        b=UKSOk4WzR2mtDoCBipGA36JhtfgylD1LozvLVpUwCjthtsOSGbdlWMc2q8E2pmyHdh
         3ImBadYTaBj0ZhQ+OwufJlquLcifn27sJvDhP0iaz3UGUhMdgJ+ZkmZkw/tS7/zcjsdU
         Tgi7ErDfePAS28w8dFBLeqBfhd7QxzXchYbQqGyVwlSPXpoZfZEbQGSWasZmh6lV8Tto
         J68r/4NDvEugjF8vneCaHszTUtwU1yUHjFp64o+lFACtZ1m94s7NluiylwXXRR9NZYGX
         VlEqcWHT2m77F7gPpMAfNi1xcWxFQilRXACXBtGrekrUVW3fkZmmd86URU/K8Zy5mWUu
         y+WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=3UapMw1B/lQ8O8rK1t5yloPW20aKmQdYgqwziIYXJaY=;
        b=V5pQ2Cyeb7uj4bH+hGLKIVkx/U1TKzVb/m4MRJT83ZZcP9YpQN0Ml7Wq7f5lOF9ANj
         1OpAziWKQNakdphONEBUJPpUagym1f0b8HEPiLbdxkXg4Tw7B1JfsxV5A9K2EEwT1p8m
         F9P5jP3ir6AYrq5iyEART8C9oG40vNMRGipUIfMTpSfvhnb9LF9tMs2LJLydLp0SILED
         lt/VoF3/TKM+FkEB423lS6GqNere8qTg6idsKCjUPENrACxfzvfgcUFLWcgL/grjOmin
         pWsuG3/lY7vg+Sf02Z9hgpvTqrqYzystpuO2RuBWKaEVPYmbOw/EdL+yJneC0bhtc+s9
         rXJQ==
X-Gm-Message-State: AOAM532FDwRkhcclSArGOP2zbHSMLk0dKOigaqa1prJwnjuBJ0VKkz1H
        0l9IO3GJ/wZ8KlIJp/2rsGDl2N4XVU0=
X-Google-Smtp-Source: ABdhPJw5JH6viWlCpNTEeENNaqAUbl0z56mqHOR+JS2XF/jIGeIsHBiubDSgHt35cRONxjNqkHPgiHd/phA=
Sender: "glider via sendgmr" <glider@glider.muc.corp.google.com>
X-Received: from glider.muc.corp.google.com ([2a00:79e0:15:13:f693:9fff:fef4:9ff])
 (user=glider job=sendgmr) by 2002:a5d:6c6b:: with SMTP id r11mr3209323wrz.38.1611235166783;
 Thu, 21 Jan 2021 05:19:26 -0800 (PST)
Date:   Thu, 21 Jan 2021 14:19:15 +0100
In-Reply-To: <20210121131915.1331302-1-glider@google.com>
Message-Id: <20210121131915.1331302-4-glider@google.com>
Mime-Version: 1.0
References: <20210121131915.1331302-1-glider@google.com>
X-Mailer: git-send-email 2.30.0.296.g2bfb1c46d8-goog
Subject: [PATCH 3/3] kasan: use error_report_end tracepoint
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

Make it possible to trace KASAN error reporting. A good usecase is
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
 mm/kasan/report.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/mm/kasan/report.c b/mm/kasan/report.c
index 234f35a84f19..87b271206163 100644
--- a/mm/kasan/report.c
+++ b/mm/kasan/report.c
@@ -25,6 +25,7 @@
 #include <linux/module.h>
 #include <linux/sched/task_stack.h>
 #include <linux/uaccess.h>
+#include <trace/events/error_report.h>
 
 #include <asm/sections.h>
 
@@ -84,8 +85,9 @@ static void start_report(unsigned long *flags)
 	pr_err("==================================================================\n");
 }
 
-static void end_report(unsigned long *flags)
+static void end_report(unsigned long *flags, unsigned long addr)
 {
+	trace_error_report_end(ERROR_DETECTOR_KASAN, addr);
 	pr_err("==================================================================\n");
 	add_taint(TAINT_BAD_PAGE, LOCKDEP_NOW_UNRELIABLE);
 	spin_unlock_irqrestore(&report_lock, *flags);
@@ -355,7 +357,7 @@ void kasan_report_invalid_free(void *object, unsigned long ip)
 	print_address_description(object, tag);
 	pr_err("\n");
 	print_memory_metadata(object);
-	end_report(&flags);
+	end_report(&flags, (unsigned long)object);
 }
 
 static void __kasan_report(unsigned long addr, size_t size, bool is_write,
@@ -401,7 +403,7 @@ static void __kasan_report(unsigned long addr, size_t size, bool is_write,
 		dump_stack();
 	}
 
-	end_report(&flags);
+	end_report(&flags, addr);
 }
 
 bool kasan_report(unsigned long addr, size_t size, bool is_write,
-- 
2.30.0.296.g2bfb1c46d8-goog


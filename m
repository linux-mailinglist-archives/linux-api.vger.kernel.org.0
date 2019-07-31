Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B52B7D0A8
	for <lists+linux-api@lfdr.de>; Thu,  1 Aug 2019 00:17:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731365AbfGaWRX (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 31 Jul 2019 18:17:23 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:39174 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731364AbfGaWRX (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 31 Jul 2019 18:17:23 -0400
Received: by mail-pf1-f202.google.com with SMTP id 6so44205036pfi.6
        for <linux-api@vger.kernel.org>; Wed, 31 Jul 2019 15:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=XvMhL8IcfVDNreN9SwFKf8wrtWYtjyv1vRVRyj1buwk=;
        b=W9cI3RPflL4c24ovch/52afOAvuq1DhLW6d+6JcVypuSEDBi+/161uWz7FOWeu7l4o
         uuYOAnN5evOgfmJXgdhaUbz2WJptg4yJiMR6Wwye9GuFVZ5Ps5yrdZkg6keJgh9ul0gA
         k/ByRAD38a/Ih7GV117hNLB0q0GSb29kFiM8p989TjI8wClGYyeKbp9V4iNkueKeEbyo
         PcmSQDUbYAAcXEWtWMO6R5czWcQ8/y/bPH9coyx4WgrjoiKhBp0/D6Yrod5WE0sy4+Pa
         38NNF2OHvq8iNfaw5+k7mRWujpt5sGnyv1dCGMfXJeZddS4XAMRCPd+QFTLcyT1XdYtM
         px1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=XvMhL8IcfVDNreN9SwFKf8wrtWYtjyv1vRVRyj1buwk=;
        b=tKMh53JXjl9Wv9gShGGY3O1L1pvORdgHRxEd9tsi1Ui9kZWSAjZzh+1qD3SQEQpZLk
         2gEjokTx7tvObEYUPp5laGGSNPVSf3cgje1gxR7omGhXG83nE30IMUZRbsLx8m95wuw9
         /2gTtsEcGmCgCTHhKWRbsQE3HRm4bA1/n//xR4fSJi8vnPOOT2dbX5ErbrMR/QKw/3SO
         Mnd3a+NzpdkQ4SVjuL69Pz0EpzpnDL2lUy6JMFDylXXZDfKXdleKSMGMzJfeuPSq7Zfw
         SQsmvWd/NdIE9Gyrhl+YhSkfOCxVRBK9OKZt2wYS2p6hQQTo0hy91yrSByKSQoYZPiiD
         VavQ==
X-Gm-Message-State: APjAAAXVbVElZfmGv9M0jPDueMkTzXc7L6XXS0uuibRwiYTErJxF+uxp
        1HZMd1lGSy1stDE9VznmtyLb2xUKBeMit9TnGqBBuQ==
X-Google-Smtp-Source: APXvYqx17wXe+gpNAd3o3lTDSw6EZOYhYK2Ai9SHQvAutywjVDyQNvDTWItFuoT51ck80sN/Cs6cCWRrqFeirbm1QX5o+w==
X-Received: by 2002:a63:b20f:: with SMTP id x15mr6928111pge.453.1564611442370;
 Wed, 31 Jul 2019 15:17:22 -0700 (PDT)
Date:   Wed, 31 Jul 2019 15:16:10 -0700
In-Reply-To: <20190731221617.234725-1-matthewgarrett@google.com>
Message-Id: <20190731221617.234725-23-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190731221617.234725-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
Subject: [PATCH V37 22/29] Lock down tracing and perf kprobes when in
 confidentiality mode
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Matthew Garrett <mjg59@google.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        davem@davemloft.net
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
Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
Cc: Naveen N. Rao <naveen.n.rao@linux.ibm.com>
Cc: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
Cc: davem@davemloft.net
Cc: Masami Hiramatsu <mhiramat@kernel.org>
---
 include/linux/security.h     | 1 +
 kernel/trace/trace_kprobe.c  | 5 +++++
 security/lockdown/lockdown.c | 1 +
 3 files changed, 7 insertions(+)

diff --git a/include/linux/security.h b/include/linux/security.h
index f0cffd0977d3..987d8427f091 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -117,6 +117,7 @@ enum lockdown_reason {
 	LOCKDOWN_MMIOTRACE,
 	LOCKDOWN_INTEGRITY_MAX,
 	LOCKDOWN_KCORE,
+	LOCKDOWN_KPROBES,
 	LOCKDOWN_CONFIDENTIALITY_MAX,
 };
 
diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 9d483ad9bb6c..d5fbade68b33 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -11,6 +11,7 @@
 #include <linux/uaccess.h>
 #include <linux/rculist.h>
 #include <linux/error-injection.h>
+#include <linux/security.h>
 
 #include <asm/setup.h>  /* for COMMAND_LINE_SIZE */
 
@@ -389,6 +390,10 @@ static int __register_trace_kprobe(struct trace_kprobe *tk)
 {
 	int i, ret;
 
+	ret = security_locked_down(LOCKDOWN_KPROBES);
+	if (ret)
+		return ret;
+
 	if (trace_kprobe_is_registered(tk))
 		return -EINVAL;
 
diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
index c050b82c7f9f..6b123cbf3748 100644
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
2.22.0.770.g0f2c4a37fd-goog


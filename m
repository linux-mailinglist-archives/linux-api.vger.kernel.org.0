Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D81EB4163F4
	for <lists+linux-api@lfdr.de>; Thu, 23 Sep 2021 19:11:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242309AbhIWRND (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 23 Sep 2021 13:13:03 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:46912 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235318AbhIWRND (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 23 Sep 2021 13:13:03 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: tonyk)
        with ESMTPSA id 9ECCE1F445F9
From:   =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     kernel@collabora.com, krisman@collabora.com,
        linux-api@vger.kernel.org, libc-alpha@sourceware.org,
        mtk.manpages@gmail.com, Davidlohr Bueso <dave@stgolabs.net>,
        Arnd Bergmann <arnd@arndb.de>,
        =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
Subject: [PATCH v2 01/22] futex: Move to kernel/futex/
Date:   Thu, 23 Sep 2021 14:10:50 -0300
Message-Id: <20210923171111.300673-2-andrealmeid@collabora.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210923171111.300673-1-andrealmeid@collabora.com>
References: <20210923171111.300673-1-andrealmeid@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

In preparation for splitup..

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: André Almeida <andrealmeid@collabora.com>
Signed-off-by: André Almeida <andrealmeid@collabora.com>
---
 MAINTAINERS                      | 2 +-
 kernel/Makefile                  | 2 +-
 kernel/futex/Makefile            | 3 +++
 kernel/{futex.c => futex/core.c} | 2 +-
 4 files changed, 6 insertions(+), 3 deletions(-)
 create mode 100644 kernel/futex/Makefile
 rename kernel/{futex.c => futex/core.c} (99%)

diff --git a/MAINTAINERS b/MAINTAINERS
index ca6d6fde85cf..bcf4d307fce1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7725,7 +7725,7 @@ F:	Documentation/locking/*futex*
 F:	include/asm-generic/futex.h
 F:	include/linux/futex.h
 F:	include/uapi/linux/futex.h
-F:	kernel/futex.c
+F:	kernel/futex/*
 F:	tools/perf/bench/futex*
 F:	tools/testing/selftests/futex/
 
diff --git a/kernel/Makefile b/kernel/Makefile
index 4df609be42d0..3f6ab5d5041b 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -59,7 +59,7 @@ obj-$(CONFIG_FREEZER) += freezer.o
 obj-$(CONFIG_PROFILING) += profile.o
 obj-$(CONFIG_STACKTRACE) += stacktrace.o
 obj-y += time/
-obj-$(CONFIG_FUTEX) += futex.o
+obj-$(CONFIG_FUTEX) += futex/
 obj-$(CONFIG_GENERIC_ISA_DMA) += dma.o
 obj-$(CONFIG_SMP) += smp.o
 ifneq ($(CONFIG_SMP),y)
diff --git a/kernel/futex/Makefile b/kernel/futex/Makefile
new file mode 100644
index 000000000000..b89ba3fba343
--- /dev/null
+++ b/kernel/futex/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+
+obj-y += core.o
diff --git a/kernel/futex.c b/kernel/futex/core.c
similarity index 99%
rename from kernel/futex.c
rename to kernel/futex/core.c
index c15ad276fd15..f9bc9aa0ce1e 100644
--- a/kernel/futex.c
+++ b/kernel/futex/core.c
@@ -42,7 +42,7 @@
 
 #include <asm/futex.h>
 
-#include "locking/rtmutex_common.h"
+#include "../locking/rtmutex_common.h"
 
 /*
  * READ this before attempting to hack on futexes!
-- 
2.33.0


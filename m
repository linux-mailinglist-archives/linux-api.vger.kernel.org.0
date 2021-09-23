Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06866416418
	for <lists+linux-api@lfdr.de>; Thu, 23 Sep 2021 19:13:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242634AbhIWROX (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 23 Sep 2021 13:14:23 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:47204 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242647AbhIWROS (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 23 Sep 2021 13:14:18 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: tonyk)
        with ESMTPSA id 1C63D1F44614
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
Subject: [PATCH v2 18/22] futex,arm: Wire up sys_futex_waitv()
Date:   Thu, 23 Sep 2021 14:11:07 -0300
Message-Id: <20210923171111.300673-19-andrealmeid@collabora.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210923171111.300673-1-andrealmeid@collabora.com>
References: <20210923171111.300673-1-andrealmeid@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Wire up syscall entry point for ARM architectures, for both 32 and 64-bit.

Signed-off-by: André Almeida <andrealmeid@collabora.com>
---
 arch/arm/tools/syscall.tbl        | 1 +
 arch/arm64/include/asm/unistd.h   | 2 +-
 arch/arm64/include/asm/unistd32.h | 2 ++
 3 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm/tools/syscall.tbl b/arch/arm/tools/syscall.tbl
index e842209e135d..543100151f2b 100644
--- a/arch/arm/tools/syscall.tbl
+++ b/arch/arm/tools/syscall.tbl
@@ -462,3 +462,4 @@
 446	common	landlock_restrict_self		sys_landlock_restrict_self
 # 447 reserved for memfd_secret
 448	common	process_mrelease		sys_process_mrelease
+449	common	futex_waitv			sys_futex_waitv
diff --git a/arch/arm64/include/asm/unistd.h b/arch/arm64/include/asm/unistd.h
index 3cb206aea3db..6bdb5f5db438 100644
--- a/arch/arm64/include/asm/unistd.h
+++ b/arch/arm64/include/asm/unistd.h
@@ -38,7 +38,7 @@
 #define __ARM_NR_compat_set_tls		(__ARM_NR_COMPAT_BASE + 5)
 #define __ARM_NR_COMPAT_END		(__ARM_NR_COMPAT_BASE + 0x800)
 
-#define __NR_compat_syscalls		449
+#define __NR_compat_syscalls		450
 #endif
 
 #define __ARCH_WANT_SYS_CLONE
diff --git a/arch/arm64/include/asm/unistd32.h b/arch/arm64/include/asm/unistd32.h
index 844f6ae58662..41ea1195e44b 100644
--- a/arch/arm64/include/asm/unistd32.h
+++ b/arch/arm64/include/asm/unistd32.h
@@ -903,6 +903,8 @@ __SYSCALL(__NR_landlock_add_rule, sys_landlock_add_rule)
 __SYSCALL(__NR_landlock_restrict_self, sys_landlock_restrict_self)
 #define __NR_process_mrelease 448
 __SYSCALL(__NR_process_mrelease, sys_process_mrelease)
+#define __NR_futex_waitv 449
+__SYSCALL(__NR_futex_waitv, sys_futex_waitv)
 
 /*
  * Please add new compat syscalls above this comment and update
-- 
2.33.0


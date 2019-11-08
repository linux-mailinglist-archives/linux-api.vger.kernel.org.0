Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3FC51F59AE
	for <lists+linux-api@lfdr.de>; Fri,  8 Nov 2019 22:24:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732515AbfKHVTR (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 8 Nov 2019 16:19:17 -0500
Received: from mout.kundenserver.de ([212.227.17.13]:58599 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732900AbfKHVTR (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 8 Nov 2019 16:19:17 -0500
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MBV2f-1idO8m32wp-00CyPO; Fri, 08 Nov 2019 22:19:03 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     y2038@lists.linaro.org
Cc:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Christian Brauner <christian@brauner.io>,
        linux-api@vger.kernel.org
Subject: [PATCH 23/23] y2038: allow disabling time32 system calls
Date:   Fri,  8 Nov 2019 22:12:22 +0100
Message-Id: <20191108211323.1806194-14-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20191108210236.1296047-1-arnd@arndb.de>
References: <20191108210236.1296047-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:8kgYmNQ9FQSllSkEOIPxyYOL2e1TJIU6BTRoAdURd2aYBpXFJhd
 409Fe05T9SdzWJBV9ZMaytQs0D1F/noKiyW+cBwL6Mq+wqcALiUG5OQbIPZYgcTmtSeEFGK
 Vwwsqnwq0U+WDi1bkb2BlASWPv0v0gPnlTh1U8aXTHIwdNUyuE9MptbSqctOps1MhDWqx/e
 XV/Lm4FFZPIxUbZ6YjATA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:hJ2TEM4EV1Y=:iSp181kxBetQ1yK6nXykii
 8LC4sZ/lqSN2IvVz1A4FjxKMqpPsXPuBLsHuFxF+Af3XKM/RH5eRCj5mB9JnboRPLuNZW6Imm
 p8gH5ipo/xtrA/puj9L9eRyF0SKsKFmkO+0+pcQpMQymBcZJ2+GfXbh73qhWNlIqkpcTopxDr
 Gyub9NXs61nhCgRyvtXiXMVCuor2+SOmAKlG6O38HyRoXY1+7nhjZ2xmaRAeSdVDfUz9SaeTq
 G2SrWhULxo2y0G8iFy7mWuIceR3DmorBlplFI898D3PsK09A4O6iUWDwUsPz/7aPPL0jFYUwe
 60PT6plnvm8t2E6oIRBVCckbNi2Nuq/cLdsH9KxqbvRzc6m2K7mMPts77STA5dy8Q4PlreGnC
 +cwSpRcleKAeuta7i4T3Gs2AEMCzYiwLNTFAfA6NFB8nE3MIaJ2DTso1H3yUVu6DzprtsCnCf
 B31sgAaFJPbr7I3iFZxA4ziyE6rLHClmT/a1sRJ3N2Qd1yUFKsgO95RARL1+khYXkZtB2rE6k
 9wsOk2p9ftdVQKjjCwm7nFHPKELK08fkGUEjQsmAuDNt44WrNMF/VKbF+DoXPzaygm1dsvYKU
 wVvM9/RKg8PxVCZ9h9tprN6dxYEdMxabGs9fbclBwxzGjRcIuY00h4LSg99LB3fVX1LPCVREa
 /0OVhjGQZzgZmS0xj1ALFlM//5NdX8n7Xqh7IocWowZlIyajNmKzJJbrEMI5lvV3DhEABvg9V
 LlVKJVKI0Tf9pIqpaj4Y1rRMEUm2hfrmrLbnV2zIihBUOFomUUViAyGyyA6aUu9T6oKe778d5
 STTcmwByYrkPJc94TyeKOIteL7oqz4fLjujgUG+Svt8o64+z2a1dpRWNApdIr5SegsFh/jst9
 Oeuvc/763VC7LMrYwGSQ==
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

At the moment, the compilation of the old time32 system calls depends
purely on the architecture. As systems with new libc based on 64-bit
time_t are getting deployed, even architectures that previously supported
these (notably x86-32 and arm32 but also many others) no longer depend on
them, and removing them from a kernel image results in a smaller kernel
binary, the same way we can leave out many other optional system calls.

More importantly, on an embedded system that needs to keep working
beyond year 2038, any user space program calling these system calls
is likely a bug, so removing them from the kernel image does provide
an extra debugging help for finding broken applications.

I've gone back and forth on hiding this option unless CONFIG_EXPERT
is set. This version leaves it visible based on the logic that
eventually it will be turned off indefinitely.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/Kconfig    |  3 ++-
 kernel/sys_ni.c | 23 +++++++++++++++++++++++
 2 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 0e1fded2940e..1203955ed4d0 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -797,7 +797,8 @@ config COMPAT_OLD_SIGACTION
 	bool
 
 config COMPAT_32BIT_TIME
-	def_bool !64BIT || COMPAT
+	bool "Provide system calls for 32-bit time_t"
+	default !64BIT || COMPAT
 	help
 	  This enables 32 bit time_t support in addition to 64 bit time_t support.
 	  This is relevant on all 32-bit architectures, and 64-bit architectures
diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
index 34b76895b81e..3b69a560a7ac 100644
--- a/kernel/sys_ni.c
+++ b/kernel/sys_ni.c
@@ -410,6 +410,29 @@ COND_SYSCALL(send);
 COND_SYSCALL(bdflush);
 COND_SYSCALL(uselib);
 
+/* optional: time32 */
+COND_SYSCALL(time32);
+COND_SYSCALL(stime32);
+COND_SYSCALL(utime32);
+COND_SYSCALL(adjtimex_time32);
+COND_SYSCALL(sched_rr_get_interval_time32);
+COND_SYSCALL(nanosleep_time32);
+COND_SYSCALL(rt_sigtimedwait_time32);
+COND_SYSCALL_COMPAT(rt_sigtimedwait_time32);
+COND_SYSCALL(timer_settime32);
+COND_SYSCALL(timer_gettime32);
+COND_SYSCALL(clock_settime32);
+COND_SYSCALL(clock_gettime32);
+COND_SYSCALL(clock_getres_time32);
+COND_SYSCALL(clock_nanosleep_time32);
+COND_SYSCALL(utimes_time32);
+COND_SYSCALL(futimesat_time32);
+COND_SYSCALL(pselect6_time32);
+COND_SYSCALL_COMPAT(pselect6_time32);
+COND_SYSCALL(ppoll_time32);
+COND_SYSCALL_COMPAT(ppoll_time32);
+COND_SYSCALL(utimensat_time32);
+COND_SYSCALL(clock_adjtime32);
 
 /*
  * The syscalls below are not found in include/uapi/asm-generic/unistd.h
-- 
2.20.0


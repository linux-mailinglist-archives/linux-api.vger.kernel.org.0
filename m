Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A34C8F599E
	for <lists+linux-api@lfdr.de>; Fri,  8 Nov 2019 22:24:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731687AbfKHVRJ (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 8 Nov 2019 16:17:09 -0500
Received: from mout.kundenserver.de ([217.72.192.73]:39767 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729617AbfKHVRJ (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 8 Nov 2019 16:17:09 -0500
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MPGiR-1iGill2Ewf-00Pfj2; Fri, 08 Nov 2019 22:16:44 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     y2038@lists.linaro.org, John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Stephen Boyd <sboyd@kernel.org>,
        David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Christian Brauner <christian@brauner.io>,
        Jens Axboe <axboe@kernel.dk>, Ingo Molnar <mingo@kernel.org>,
        Corey Minyard <cminyard@mvista.com>,
        zhengbin <zhengbin13@huawei.com>,
        Li RongQing <lirongqing@baidu.com>, linux-api@vger.kernel.org
Subject: [PATCH 17/23] y2038: time: avoid timespec usage in settimeofday()
Date:   Fri,  8 Nov 2019 22:12:16 +0100
Message-Id: <20191108211323.1806194-8-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20191108210236.1296047-1-arnd@arndb.de>
References: <20191108210236.1296047-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:wVshbT+Rs8/VikEWMEyXeLpYFujcte2DKlRU0hq3zkGqSD7/ggC
 ygDEdVeGORYn8F1DRnmVs0ye4ZRZyC8WZ/oJHMj80QAM40h9DuovvRJCygRfF0NwTkUVUkc
 VXWiX8cyr522zIOPoE7TvSpz8nKEF8mVO/9HuXPoD3sh+O598eVubO6C2QnEWdYannsiPFb
 VmZ9O7pmhM+NyMWqgEdAQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:W0d6/OZZjqs=:Lbeg5117r3XMRKTKmdlxk5
 1dxvM9R7+omevXsmSib0qdI+f2YGTdsEjwSm5vQ4e6493tRiVH5jvvgJtwWrfoL+dqrVXx4vk
 ELndXVbDDmS+PvmQ2GZVpXBPITzV1TiMwK1g73synyWXG277DBTJmR3MDoHGMZyj8ONCdnjGU
 YP1U7hREnmQ6aqfuSUm9zc/ZTNsPxOthF4ZinfgqvXGDgyMz/qCI2Ix8HL8t5oDkEaAdTqvCt
 c6mQoz9isAPifqiEBPuIV9uZpsycHnVV7Y2xKMEOg6U63YDb2ZZO9UiLtAVeJwUaZsiVEASoA
 Td2aAzVWivAHFDvycrFs3mhbZenqi6ZD3vU0rpk1q6PRyG+zIs9orqDnQs87G/hYMevPgv7Wd
 RIen7H5toNquKzyCQ5zTmNCyU5DM0zLKNZ7X73c0LfIPaErVxuPUspl10Ix0sX2Em1xOs/wIs
 HYOmOlJ9kNUfw12zmIHNSdBcz7oe6frliHbiNVW1nDhK2MGABOp9BZXPRZYzGsVtgIO/+2kCj
 qNte92VkmzjYU9aEoIgUo7YLMkOS5JZJLGMVWPyvZfh0Tu+xvr1Bzcsvd1GdACxxnbQE3KVfV
 QNGUdF24YEkGSZsHCwC7GzuRxt9RmZtw0+E/vwlEITefGw/9fGCH1AefXm5wxfCuhibNLKFxh
 nuAR/MzDCUJ3HVd49mKFbq0VQ2MlBrTvcOZ/qKWabpweS5h9ronRECXNl+HOItiyxLKX4TrX/
 ugzVjBiUYdCNUzTRLV1iR1WxbekWHeOauVBEr4HhHBmpcSsnjRRJfIlrO50Zozpci7gRJ2Bke
 ZZg63CgHNX2Ajjj3wpMr5XK8kRi/lMK+NuMbEJ+iCiom1lKQAu4+z3C6PGvdEz3X3HAKb59vN
 FGHT6NNw6qywPEc3JeDA==
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

The compat_get_timeval() and timeval_valid() interfaces
are deprecated and getting removed along with the definition
of struct timeval itself.

Change the two implementations of the settimeofday()
system call to open-code these helpers and completely
avoid references to timeval.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/linux/syscalls.h |  2 +-
 kernel/time/time.c       | 20 +++++++++-----------
 2 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index e665920fa359..d0391cc2dae9 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -734,7 +734,7 @@ asmlinkage long sys_getcpu(unsigned __user *cpu, unsigned __user *node, struct g
 /* kernel/time.c */
 asmlinkage long sys_gettimeofday(struct __kernel_old_timeval __user *tv,
 				struct timezone __user *tz);
-asmlinkage long sys_settimeofday(struct timeval __user *tv,
+asmlinkage long sys_settimeofday(struct __kernel_old_timeval __user *tv,
 				struct timezone __user *tz);
 asmlinkage long sys_adjtimex(struct __kernel_timex __user *txc_p);
 asmlinkage long sys_adjtimex_time32(struct old_timex32 __user *txc_p);
diff --git a/kernel/time/time.c b/kernel/time/time.c
index bc114f0be8f1..6bfbe640fd3b 100644
--- a/kernel/time/time.c
+++ b/kernel/time/time.c
@@ -196,22 +196,21 @@ int do_sys_settimeofday64(const struct timespec64 *tv, const struct timezone *tz
 	return 0;
 }
 
-SYSCALL_DEFINE2(settimeofday, struct timeval __user *, tv,
+SYSCALL_DEFINE2(settimeofday, struct __kernel_old_timeval __user *, tv,
 		struct timezone __user *, tz)
 {
 	struct timespec64 new_ts;
-	struct timeval user_tv;
 	struct timezone new_tz;
 
 	if (tv) {
-		if (copy_from_user(&user_tv, tv, sizeof(*tv)))
+		if (get_user(new_ts.tv_sec, &tv->tv_sec) ||
+		    get_user(new_ts.tv_nsec, &tv->tv_usec))
 			return -EFAULT;
 
-		if (!timeval_valid(&user_tv))
+		if (tv->tv_usec > USEC_PER_SEC)
 			return -EINVAL;
 
-		new_ts.tv_sec = user_tv.tv_sec;
-		new_ts.tv_nsec = user_tv.tv_usec * NSEC_PER_USEC;
+		new_ts.tv_nsec *= NSEC_PER_USEC;
 	}
 	if (tz) {
 		if (copy_from_user(&new_tz, tz, sizeof(*tz)))
@@ -245,18 +244,17 @@ COMPAT_SYSCALL_DEFINE2(settimeofday, struct old_timeval32 __user *, tv,
 		       struct timezone __user *, tz)
 {
 	struct timespec64 new_ts;
-	struct timeval user_tv;
 	struct timezone new_tz;
 
 	if (tv) {
-		if (compat_get_timeval(&user_tv, tv))
+		if (get_user(new_ts.tv_sec, &tv->tv_sec) ||
+		    get_user(new_ts.tv_nsec, &tv->tv_usec))
 			return -EFAULT;
 
-		if (!timeval_valid(&user_tv))
+		if (new_ts.tv_nsec > USEC_PER_SEC)
 			return -EINVAL;
 
-		new_ts.tv_sec = user_tv.tv_sec;
-		new_ts.tv_nsec = user_tv.tv_usec * NSEC_PER_USEC;
+		new_ts.tv_nsec *= NSEC_PER_USEC;
 	}
 	if (tz) {
 		if (copy_from_user(&new_tz, tz, sizeof(*tz)))
-- 
2.20.0


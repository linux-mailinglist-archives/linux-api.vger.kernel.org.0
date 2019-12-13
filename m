Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E94D11EC5D
	for <lists+linux-api@lfdr.de>; Fri, 13 Dec 2019 21:59:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbfLMU7B (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 13 Dec 2019 15:59:01 -0500
Received: from mout.kundenserver.de ([212.227.126.187]:59065 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725937AbfLMU7B (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 13 Dec 2019 15:59:01 -0500
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MsZBb-1hqEMw1io7-00u5gf; Fri, 13 Dec 2019 21:58:37 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     y2038@lists.linaro.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Arnd Bergmann <arnd@arndb.de>, David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Jens Axboe <axboe@kernel.dk>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        linux-api@vger.kernel.org
Subject: [PATCH v2 23/24] y2038: rename itimerval to __kernel_old_itimerval
Date:   Fri, 13 Dec 2019 21:53:51 +0100
Message-Id: <20191213205417.3871055-14-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20191213204936.3643476-1-arnd@arndb.de>
References: <20191213204936.3643476-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:TqEgrqVYKBUXuLUugtmSXz5Jp0XWvxFbL1EF+DOHK3fjEd6Fk++
 cRocth6aVdmtqKW7gyyAItEa53K8m1Gj+h/gCmRCJQ9zcX1JYTHfDh/mFaEreuJDcAKCAZT
 /V9BL4c/fgg/VV2hxw/J3nff8wTDToWlulMn4wWP2yM+Dmfi6/N/FbZBS6ov0rwtgjxVJtk
 c8qGaN7z75Bvc1ShlL9ZA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:+nujEEc8rtU=:gcuncyiULxaR/b5DAOMBO4
 oR6U8INsRH3MZPCNpISnel4mn+Th5CEnjPhMuYbhPA4rqvNI08Q1scKBLZNct5p3rcFjDwIbz
 UQoWffQ5d+Vj2Jn8UKlSYJQXU52k2xvazBuG4p0PjLQoH4j0q6O/LJ205v5nPBWeoz8rj7kI8
 HqaAhvKSpkQiSwJoZUjs9m3r4zxOXPmS1EkaaUwWgeEH0OJLXMXs1+u0f4lUPqkCGws7ijvic
 3ApO1TPXrmsIno6Q79YNWvQ1fCrQiJlRC0uXjPfCiDwGY5eTqkPfT18zvl62gsf/Np4eAiidp
 IGZIE9Lhfthids1bllMSSx8JVmG+LSI/HCAQ4dKeZBqJ8ttA8rcfvMQVPkogWclTTyxGldeLZ
 rnd2wX0yS9MZ+jAUnbFJ/LcIpdx3w72hz666SrW9hMBDOHLcscDx34uZKFsoWDCkTifyCjl7z
 AypDolytB3UPMJQAnj9tFLm5K+dp0srYZaXb7GwUVp6i8MpI210/zVJFOhq5aPOfWkCvjRHNb
 rZPp4nxsnppchEXbWmFkSdPqGCbEEoVljg7H6Ep2RB6ATD5Hx2iSRTRiUguyYgSmAgzfsJsCU
 cRE6ctY6cBBcpuOw7F5+k2og4/8z1HI5a/aM5l7Xd4kEuGkqIC7Kaswp7zS0wixJx41Jk3ole
 SRIW0zvRsp17fOmCXbHpUT+yik5W7XTAZd4JlNg+3cSmlIJLGyomTzFN/UGD0uvocGaO165rp
 qhOoRT5Vq6DsCmyglMiyfsTiwYjF83UA0eGSzww+ca9Tpqs9epkhVvRNhvCAmu2Ce+9EsSHwc
 SdUS4EMmf/Sbp/RB91XuBjZ/nSkpgqUyVRZIbhlf2rU/cClbeahuKr/QL3qvA45DahX1lHSjI
 g8WIW7F2WBR4mn4nyMTg==
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Take the renaming of timeval and timespec one level further,
also renaming itimerval to __kernel_old_itimerval, to avoid
namespace conflicts with the user-space structure that may
use 64-bit time_t members.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/linux/syscalls.h        |  9 ++++-----
 include/uapi/linux/time_types.h |  5 +++++
 kernel/time/itimer.c            | 18 +++++++++---------
 3 files changed, 18 insertions(+), 14 deletions(-)

diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index d0391cc2dae9..27245fec2a8a 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -16,8 +16,7 @@ struct inode;
 struct iocb;
 struct io_event;
 struct iovec;
-struct itimerspec;
-struct itimerval;
+struct __kernel_old_itimerval;
 struct kexec_segment;
 struct linux_dirent;
 struct linux_dirent64;
@@ -591,10 +590,10 @@ asmlinkage long sys_nanosleep_time32(struct old_timespec32 __user *rqtp,
 				     struct old_timespec32 __user *rmtp);
 
 /* kernel/itimer.c */
-asmlinkage long sys_getitimer(int which, struct itimerval __user *value);
+asmlinkage long sys_getitimer(int which, struct __kernel_old_itimerval __user *value);
 asmlinkage long sys_setitimer(int which,
-				struct itimerval __user *value,
-				struct itimerval __user *ovalue);
+				struct __kernel_old_itimerval __user *value,
+				struct __kernel_old_itimerval __user *ovalue);
 
 /* kernel/kexec.c */
 asmlinkage long sys_kexec_load(unsigned long entry, unsigned long nr_segments,
diff --git a/include/uapi/linux/time_types.h b/include/uapi/linux/time_types.h
index 074e391d73a1..bcc0002115d3 100644
--- a/include/uapi/linux/time_types.h
+++ b/include/uapi/linux/time_types.h
@@ -33,6 +33,11 @@ struct __kernel_old_timespec {
 	long			tv_nsec;	/* nanoseconds */
 };
 
+struct __kernel_old_itimerval {
+	struct __kernel_old_timeval it_interval;/* timer interval */
+	struct __kernel_old_timeval it_value;	/* current value */
+};
+
 struct __kernel_sock_timeval {
 	__s64 tv_sec;
 	__s64 tv_usec;
diff --git a/kernel/time/itimer.c b/kernel/time/itimer.c
index 9e59c9ea92aa..ca4e6d57d68b 100644
--- a/kernel/time/itimer.c
+++ b/kernel/time/itimer.c
@@ -97,20 +97,20 @@ static int do_getitimer(int which, struct itimerspec64 *value)
 	return 0;
 }
 
-static int put_itimerval(struct itimerval __user *o,
+static int put_itimerval(struct __kernel_old_itimerval __user *o,
 			 const struct itimerspec64 *i)
 {
-	struct itimerval v;
+	struct __kernel_old_itimerval v;
 
 	v.it_interval.tv_sec = i->it_interval.tv_sec;
 	v.it_interval.tv_usec = i->it_interval.tv_nsec / NSEC_PER_USEC;
 	v.it_value.tv_sec = i->it_value.tv_sec;
 	v.it_value.tv_usec = i->it_value.tv_nsec / NSEC_PER_USEC;
-	return copy_to_user(o, &v, sizeof(struct itimerval)) ? -EFAULT : 0;
+	return copy_to_user(o, &v, sizeof(struct __kernel_old_itimerval)) ? -EFAULT : 0;
 }
 
 
-SYSCALL_DEFINE2(getitimer, int, which, struct itimerval __user *, value)
+SYSCALL_DEFINE2(getitimer, int, which, struct __kernel_old_itimerval __user *, value)
 {
 	struct itimerspec64 get_buffer;
 	int error = do_getitimer(which, &get_buffer);
@@ -314,11 +314,11 @@ SYSCALL_DEFINE1(alarm, unsigned int, seconds)
 
 #endif
 
-static int get_itimerval(struct itimerspec64 *o, const struct itimerval __user *i)
+static int get_itimerval(struct itimerspec64 *o, const struct __kernel_old_itimerval __user *i)
 {
-	struct itimerval v;
+	struct __kernel_old_itimerval v;
 
-	if (copy_from_user(&v, i, sizeof(struct itimerval)))
+	if (copy_from_user(&v, i, sizeof(struct __kernel_old_itimerval)))
 		return -EFAULT;
 
 	/* Validate the timevals in value. */
@@ -333,8 +333,8 @@ static int get_itimerval(struct itimerspec64 *o, const struct itimerval __user *
 	return 0;
 }
 
-SYSCALL_DEFINE3(setitimer, int, which, struct itimerval __user *, value,
-		struct itimerval __user *, ovalue)
+SYSCALL_DEFINE3(setitimer, int, which, struct __kernel_old_itimerval __user *, value,
+		struct __kernel_old_itimerval __user *, ovalue)
 {
 	struct itimerspec64 set_buffer, get_buffer;
 	int error;
-- 
2.20.0


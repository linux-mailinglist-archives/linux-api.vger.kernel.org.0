Return-Path: <linux-api+bounces-6760-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id p79fOkQjRmpXKgsAu9opvQ
	(envelope-from <linux-api+bounces-6760-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Thu, 02 Jul 2026 10:37:24 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B4E156F4DCC
	for <lists+linux-api@lfdr.de>; Thu, 02 Jul 2026 10:37:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linutronix.de header.s=2020 header.b=ODI4rx+o;
	dkim=pass header.d=linutronix.de header.s=2020e header.b=4u6eZy6u;
	spf=pass (mail.lfdr.de: domain of "linux-api+bounces-6760-lists+linux-api=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-api+bounces-6760-lists+linux-api=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linutronix.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CA2A53012CFA
	for <lists+linux-api@lfdr.de>; Thu,  2 Jul 2026 08:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8195642643F;
	Thu,  2 Jul 2026 08:21:34 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E140A388E42;
	Thu,  2 Jul 2026 08:21:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782980494; cv=none; b=XxOWsasUqxRIXu6tTIiAe2BEw9q9lwaC9sknFTvyH4o7S0neYUujonk8rLT7q29pIjQxOZ/lqtWgPFvhaj0Zg2f3K3wBOk4U+YcePQ9wswUuO8J+HXDP9HYQKSz2b0k/f5kvUyvDOsWIhUAF/ognG7asJgQ0iDOejC/QvGSgU8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782980494; c=relaxed/simple;
	bh=gj4V+syfmAXpdEr+HAh+eG00nr/CFRTmxa9XCdZH050=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=F3GgZowY2lDLmu0vUyyOkhbCj+Dvfjmro9z9nXgGUgs8Gr1eFJpBX8PyvfqXlVNIG40rJxyQgFYBfrs7Vlsg6QNMvUtLQmWgKpKqQAVDFQnERwKsKVeF8w0o/htYeH8oc7e90zsd2HTgO4Anvmxg/zlgINQrwvhCT0eiPsSbJDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ODI4rx+o; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4u6eZy6u; arc=none smtp.client-ip=193.142.43.55
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1782980490;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hw7CMtSzZ3T03/nHIxRfsVoUiZsPLzFgwT0l0XLT+Jg=;
	b=ODI4rx+oZm7smBBBPpFBoEzJffCzbGEdLsD5wPz/Z8SWP2KWUliPgSciBLpp/HnVa9HmGg
	u6bIFv7MkwrEaqND87SmtGQ7ULAhisPC9KtkyHrqLK9b8tiO5Esp1+GUp7LIU2TJZJdZ8l
	RiwnTbK25PJ7owO7x/NA2E/DDb4qx25xKPlJQkpLKiuAG6Zk9U6nDjbFa7yMjhYuMyVgIU
	pJs4sbQf1tsOYCRwAkkBh+7op5j3IGOFTrlewqWvZ6996ySNqZn/PfX1++o+FUIpjcfM2c
	WETCgoBy0PHMFdSjgI8xR5410KhZDwYqng4RRYVUzaE9wF6e3tOwaB4kjXZpIQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1782980490;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hw7CMtSzZ3T03/nHIxRfsVoUiZsPLzFgwT0l0XLT+Jg=;
	b=4u6eZy6uRINUX51mFPcy79lFscIhOYvFi8pzq8BrNmI3lHtBbhToMDZMYez4+Vw+p3h4vU
	qxvfvL8PolrSSdCA==
Date: Thu, 02 Jul 2026 10:21:25 +0200
Subject: [PATCH v3 1/9] time: Respect COMPAT_32BIT_TIME for old time type
 functions
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260702-vdso-compat_32bit_time-v3-1-db9f36d8d432@linutronix.de>
References: <20260702-vdso-compat_32bit_time-v3-0-db9f36d8d432@linutronix.de>
In-Reply-To: <20260702-vdso-compat_32bit_time-v3-0-db9f36d8d432@linutronix.de>
To: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
 "H. Peter Anvin" <hpa@zytor.com>, Russell King <linux@armlinux.org.uk>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>, 
 John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, 
 Andreas Larsson <andreas@gaisler.com>
Cc: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linuxppc-dev@lists.ozlabs.org, linux-mips@vger.kernel.org, 
 Arnd Bergmann <arnd@arndb.de>, linux-api@vger.kernel.org, 
 sparclinux@vger.kernel.org, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782980489; l=4399;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=gj4V+syfmAXpdEr+HAh+eG00nr/CFRTmxa9XCdZH050=;
 b=kHodoXYGMDqQpGUjixS5+cbPKN/0Jqd7NpPoi4peiRMHPp8ULeu4jga/P4nLlW1n9oTDU5nYk
 vG017ekPc5IBx5pLMAdQGd0O4fsI3rokIoP9aC8/mbb7ofJAdOTZSq4
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS(0.00)[m:luto@kernel.org,m:tglx@kernel.org,m:mingo@redhat.com,m:bp@alien8.de,m:dave.hansen@linux.intel.com,m:x86@kernel.org,m:hpa@zytor.com,m:linux@armlinux.org.uk,m:catalin.marinas@arm.com,m:will@kernel.org,m:maddy@linux.ibm.com,m:mpe@ellerman.id.au,m:npiggin@gmail.com,m:chleroy@kernel.org,m:tsbogend@alpha.franken.de,m:vincenzo.frascino@arm.com,m:jstultz@google.com,m:sboyd@kernel.org,m:davem@davemloft.net,m:andreas@gaisler.com,m:thomas.weissschuh@linutronix.de,m:linux-kernel@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linuxppc-dev@lists.ozlabs.org,m:linux-mips@vger.kernel.org,m:arnd@arndb.de,m:linux-api@vger.kernel.org,m:sparclinux@vger.kernel.org,m:philmd@oss.qualcomm.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[thomas.weissschuh@linutronix.de,linux-api@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-6760-lists,linux-api=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[29];
	FREEMAIL_TO(0.00)[kernel.org,redhat.com,alien8.de,linux.intel.com,zytor.com,armlinux.org.uk,arm.com,linux.ibm.com,ellerman.id.au,gmail.com,alpha.franken.de,google.com,davemloft.net,gaisler.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thomas.weissschuh@linutronix.de,linux-api@vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-api];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RWL_MAILSPIKE_POSSIBLE(0.00)[104.64.211.4:from];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linutronix.de:dkim,linutronix.de:email,linutronix.de:mid,linutronix.de:from_mime,vger.kernel.org:from_smtp,arndb.de:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B4E156F4DCC

The "old" time types use 32-bit seconds which are not y2038-safe.
Respect COMPAT_32BIT_TIME for functions using those types.
time(), stime() and gettimeofday() are disabled completely.

settimeofday() is kept as it is required to do the initial timewarping
after boot. However the 'tv' argument will be rejected.

Link: https://lore.kernel.org/lkml/e9487ebe-3730-438a-9c23-e45f75986ecc@app.fastmail.com/
Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
---
 kernel/sys_ni.c    |  4 ++++
 kernel/time/time.c | 24 ++++++++++++++++++++----
 2 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
index add3032da16f..c8be0abaa407 100644
--- a/kernel/sys_ni.c
+++ b/kernel/sys_ni.c
@@ -351,6 +351,10 @@ COND_SYSCALL(ppoll_time32);
 COND_SYSCALL_COMPAT(ppoll_time32);
 COND_SYSCALL(utimensat_time32);
 COND_SYSCALL(clock_adjtime32);
+COND_SYSCALL(gettimeofday);
+COND_SYSCALL_COMPAT(gettimeofday);
+COND_SYSCALL(time);
+COND_SYSCALL(stime);
 
 /*
  * The syscalls below are not found in include/uapi/asm-generic/unistd.h
diff --git a/kernel/time/time.c b/kernel/time/time.c
index 0dd63a91e7c5..f836a31751f4 100644
--- a/kernel/time/time.c
+++ b/kernel/time/time.c
@@ -43,6 +43,12 @@
 #include <generated/timeconst.h>
 #include "timekeeping.h"
 
+#if defined(CONFIG_64BIT) || defined(CONFIG_COMPAT_32BIT_TIME)
+#define __WANT_OLD_TIME_TYPE_SYSCALL 1
+#endif
+
+static_assert(sizeof(__kernel_old_time_t) == 8 ? IS_ENABLED(__WANT_OLD_TIME_TYPE_SYSCALL) : true);
+
 /*
  * The timezone where the local system is located.  Used as a default by some
  * programs who obtain this value by using gettimeofday.
@@ -51,7 +57,7 @@ struct timezone sys_tz;
 
 EXPORT_SYMBOL(sys_tz);
 
-#ifdef __ARCH_WANT_SYS_TIME
+#if defined(__ARCH_WANT_SYS_TIME) && defined(__WANT_OLD_TIME_TYPE_SYSCALL)
 
 /*
  * sys_time() can be implemented in user-level using
@@ -96,7 +102,7 @@ SYSCALL_DEFINE1(stime, __kernel_old_time_t __user *, tptr)
 	return 0;
 }
 
-#endif /* __ARCH_WANT_SYS_TIME */
+#endif /* __ARCH_WANT_SYS_TIME && __WANT_OLD_TIME_TYPE_SYSCALL */
 
 #ifdef CONFIG_COMPAT_32BIT_TIME
 #ifdef __ARCH_WANT_SYS_TIME32
@@ -137,6 +143,7 @@ SYSCALL_DEFINE1(stime32, old_time32_t __user *, tptr)
 #endif /* __ARCH_WANT_SYS_TIME32 */
 #endif
 
+#ifdef __WANT_OLD_TIME_TYPE_SYSCALL
 SYSCALL_DEFINE2(gettimeofday, struct __kernel_old_timeval __user *, tv,
 		struct timezone __user *, tz)
 {
@@ -154,6 +161,7 @@ SYSCALL_DEFINE2(gettimeofday, struct __kernel_old_timeval __user *, tv,
 	}
 	return 0;
 }
+#endif /* __WANT_OLD_TIME_TYPE_SYSCALL */
 
 /*
  * In case for some reason the CMOS clock has not already been running
@@ -203,6 +211,9 @@ SYSCALL_DEFINE2(settimeofday, struct __kernel_old_timeval __user *, tv,
 	struct timezone new_tz;
 
 	if (tv) {
+		if (!IS_ENABLED(__WANT_OLD_TIME_TYPE_SYSCALL))
+			return -EINVAL;
+
 		if (get_user(new_ts.tv_sec, &tv->tv_sec) ||
 		    get_user(new_ts.tv_nsec, &tv->tv_usec))
 			return -EFAULT;
@@ -220,7 +231,7 @@ SYSCALL_DEFINE2(settimeofday, struct __kernel_old_timeval __user *, tv,
 	return do_sys_settimeofday64(tv ? &new_ts : NULL, tz ? &new_tz : NULL);
 }
 
-#ifdef CONFIG_COMPAT
+#ifdef CONFIG_COMPAT_32BIT_TIME
 COMPAT_SYSCALL_DEFINE2(gettimeofday, struct old_timeval32 __user *, tv,
 		       struct timezone __user *, tz)
 {
@@ -239,7 +250,9 @@ COMPAT_SYSCALL_DEFINE2(gettimeofday, struct old_timeval32 __user *, tv,
 
 	return 0;
 }
+#endif /* CONFIG_COMPAT_32BIT_TIME */
 
+#ifdef CONFIG_COMPAT
 COMPAT_SYSCALL_DEFINE2(settimeofday, struct old_timeval32 __user *, tv,
 		       struct timezone __user *, tz)
 {
@@ -247,6 +260,9 @@ COMPAT_SYSCALL_DEFINE2(settimeofday, struct old_timeval32 __user *, tv,
 	struct timezone new_tz;
 
 	if (tv) {
+		if (!IS_ENABLED(CONFIG_COMPAT_32BIT_TIME))
+			return -EINVAL;
+
 		if (get_user(new_ts.tv_sec, &tv->tv_sec) ||
 		    get_user(new_ts.tv_nsec, &tv->tv_usec))
 			return -EFAULT;
@@ -263,7 +279,7 @@ COMPAT_SYSCALL_DEFINE2(settimeofday, struct old_timeval32 __user *, tv,
 
 	return do_sys_settimeofday64(tv ? &new_ts : NULL, tz ? &new_tz : NULL);
 }
-#endif
+#endif /* CONFIG_COMPAT */
 
 #ifdef CONFIG_64BIT
 SYSCALL_DEFINE1(adjtimex, struct __kernel_timex __user *, txc_p)

-- 
2.55.0



Return-Path: <linux-api+bounces-6735-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id RW01EYtyQ2oyYgoAu9opvQ
	(envelope-from <linux-api+bounces-6735-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Tue, 30 Jun 2026 09:38:51 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8616C6E13A9
	for <lists+linux-api@lfdr.de>; Tue, 30 Jun 2026 09:38:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linutronix.de header.s=2020 header.b="duF4/mQY";
	dkim=pass header.d=linutronix.de header.s=2020e header.b=u4mle6I4;
	spf=pass (mail.lfdr.de: domain of "linux-api+bounces-6735-lists+linux-api=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-api+bounces-6735-lists+linux-api=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linutronix.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 37EFC300ADB8
	for <lists+linux-api@lfdr.de>; Tue, 30 Jun 2026 07:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA77D3C109A;
	Tue, 30 Jun 2026 07:38:40 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A87A2E736F;
	Tue, 30 Jun 2026 07:38:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782805120; cv=none; b=rcgupTmEcaE59CEaxlVHaBiyHw9MlrXJxZsmz8qKIFUnaIsDsc5rHSO15ZPIxGrueEwwBTH0sd1QFrZshGzgAOKKpbO0jtk4XP72AsjWvR3JVirPk+dgP6xxQjcXs2wztEelV4CnxpaxfeNrQfpfxAFVh1fR0ll97yzrC77wXDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782805120; c=relaxed/simple;
	bh=I0ELZhoYhq+LtWILvEK7psoB2pGAmCGtbLQ0fZb65NY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=a16EXbBM5Q652L4CH8FHWT56OqJrsw2defBj7iOC0MzHqB2uxZ47Eh1hA/CombpmBqKHzdX4j9T0pNiS+5YFMo5HMeN01O2l2yMjMHGd8ocdgWK/2WFCeBzMquV1iwOphzbGathhdhwo8Qr5Bcxp4QBFMUubJ37E51B6zWsICM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=duF4/mQY; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=u4mle6I4; arc=none smtp.client-ip=193.142.43.55
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1782805117;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S6M91utBDyER/aDTBiMUHXasRniYlvJ/pyD2pTrwayk=;
	b=duF4/mQYT5hX6gEHw8dMuRJJo2OIBeQFDn5XWX2fk7Z3ISsbZOA8FSLj9v2JCtnNso3IrQ
	2ZANMF7hOH/up3rX7dqHPd1sG9vJvHOUgU1Gc2guMVNYJ9Kkrh8Y5USQCgV16/iMHmUR2e
	zuV6hUjsUKOCMO3woVkdVsqjn4biPEM7zL8Oee2eB9vNe/HpOUEi8dEY4g5z9QE5+VCQ3O
	NS8dEp1YJxkTo8mERydkkRUNFXNYVU6DL3BTh100oS4LlRrEaMKwvqKI4QoI96SrQyy3tf
	3a/7TCIPYqTEuiIWerP5P5hrnk2yK/k0DD0jcCHD4b5ZJf4FZdTzDe+B+oMfIQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1782805117;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S6M91utBDyER/aDTBiMUHXasRniYlvJ/pyD2pTrwayk=;
	b=u4mle6I4bI3ZXtqPrEkvjfUQYZBLbkncMssz1fQpgdGYNQXy3ywpK7odOmEw5AVrKcK3ec
	rb6OaJiMs2XtzBAg==
Date: Tue, 30 Jun 2026 09:38:30 +0200
Subject: [PATCH v2 1/9] time: Respect COMPAT_32BIT_TIME for old time type
 functions
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260630-vdso-compat_32bit_time-v2-1-520d194640dd@linutronix.de>
References: <20260630-vdso-compat_32bit_time-v2-0-520d194640dd@linutronix.de>
In-Reply-To: <20260630-vdso-compat_32bit_time-v2-0-520d194640dd@linutronix.de>
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
 sparclinux@vger.kernel.org
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782805116; l=4359;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=I0ELZhoYhq+LtWILvEK7psoB2pGAmCGtbLQ0fZb65NY=;
 b=lKA+JCeWX+SJ7DzYMd60wozWzPqzhbOUH6o+Db6m7VKmveoGRrNH+JYFCw8hjKwqFs3A4FGuz
 C9lPF1/nufrA5wH6XkTdI0/vczjSKBfYsJNkCCfz6HTQGadj6Ihxem5
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:luto@kernel.org,m:tglx@kernel.org,m:mingo@redhat.com,m:bp@alien8.de,m:dave.hansen@linux.intel.com,m:x86@kernel.org,m:hpa@zytor.com,m:linux@armlinux.org.uk,m:catalin.marinas@arm.com,m:will@kernel.org,m:maddy@linux.ibm.com,m:mpe@ellerman.id.au,m:npiggin@gmail.com,m:chleroy@kernel.org,m:tsbogend@alpha.franken.de,m:vincenzo.frascino@arm.com,m:jstultz@google.com,m:sboyd@kernel.org,m:davem@davemloft.net,m:andreas@gaisler.com,m:thomas.weissschuh@linutronix.de,m:linux-kernel@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linuxppc-dev@lists.ozlabs.org,m:linux-mips@vger.kernel.org,m:arnd@arndb.de,m:linux-api@vger.kernel.org,m:sparclinux@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER(0.00)[thomas.weissschuh@linutronix.de,linux-api@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-6735-lists,linux-api=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[28];
	FREEMAIL_TO(0.00)[kernel.org,redhat.com,alien8.de,linux.intel.com,zytor.com,armlinux.org.uk,arm.com,linux.ibm.com,ellerman.id.au,gmail.com,alpha.franken.de,google.com,davemloft.net,gaisler.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thomas.weissschuh@linutronix.de,linux-api@vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-api];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linutronix.de:dkim,linutronix.de:email,linutronix.de:mid,linutronix.de:from_mime,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8616C6E13A9

The "old" time types use 32-bit seconds which are not y2038-safe.
Respect COMPAT_32BIT_TIME for functions using those types.
time(), stime() and gettimeofday() are disabled completely.

settimeofday() is kept as it is required to do the initial timewarping
after boot. However the 'tv' argument will be rejected.

Link: https://lore.kernel.org/lkml/e9487ebe-3730-438a-9c23-e45f75986ecc@app.fastmail.com/
Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
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
index 0dd63a91e7c5..0b7aa432bc76 100644
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
+		if (!IS_ENABLED(__WANT_OLD_TIME_TYPE_SYSCALL))
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



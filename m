Return-Path: <linux-api+bounces-6765-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0sZjBq4jRmppKgsAu9opvQ
	(envelope-from <linux-api+bounces-6765-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Thu, 02 Jul 2026 10:39:10 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CF6E36F4DF4
	for <lists+linux-api@lfdr.de>; Thu, 02 Jul 2026 10:39:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linutronix.de header.s=2020 header.b=NlVdL41w;
	dkim=pass header.d=linutronix.de header.s=2020e header.b=0bw0jIRW;
	spf=pass (mail.lfdr.de: domain of "linux-api+bounces-6765-lists+linux-api=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-api+bounces-6765-lists+linux-api=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linutronix.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 169BB307021F
	for <lists+linux-api@lfdr.de>; Thu,  2 Jul 2026 08:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C8E142B301;
	Thu,  2 Jul 2026 08:21:43 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21EBC42982C;
	Thu,  2 Jul 2026 08:21:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782980503; cv=none; b=iC5G+xT8dtD4PtB/KaVQD9CDtENyCqWEITC6N705Gu9X18h/C3NGi87K1grHyYzVmdBdM8rpnn5dBgSCUVgZTF8k+ier6bb1YMmL4rVlzpzedZ9hSaA7GeLJjJcGdk7SDRGivehzxbIDncZTgwLlXQoEbZpXF/Az8C6dIGYIaGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782980503; c=relaxed/simple;
	bh=A9MgaUprgJVGbFgeodL0zyKOakZj3wMsENaid0m8QO4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Hnhw8++RSG5jCF+5liiw2i4nZyFR7fJQxP4bsmsBakFmI1PBcdlNbcQpI3t7rmFsSr8XwjhrtnR5A2AZigQIe2aKQ2JYpJT3I1G9t2SPd7PlIj+eCwsCuq0V7fHrvl4hobiMgfVJxFs3IubUgZ4W2zkQMIRxV6f+ScycNBPJ+j4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NlVdL41w; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0bw0jIRW; arc=none smtp.client-ip=193.142.43.55
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1782980499;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JyL5PdaPFHYX3i7vQWHjIhQnNMA6B18Dy1lEHBssn4w=;
	b=NlVdL41wJjParPIUJnXa2XIDarzeHenpV2+nyfxGjlPYEnb8ZP1btKocZoSgONOK1W8bfi
	fPwBosRPvwAlyHOHg0UcLPrgKwlwb3/zkJyN8ylnaVMzev4FomBfmmNv8wDYWTJZziEJ0/
	VbVYZgGRWcgGj+BZAMwYD4lWMbopLxBShBL7MBpE6P6nG/LdCXSDQUoqzyis3FYcATFH07
	LniJ8SdQweQkFry0Mcy7hxBD3oZp8jFmspkUp1u+BUXK29OEi7oYICV2yysRfAZTO9WeSD
	PITz+ahnVJ5VHS9iSYJLzQiF2bh7rkTMb9TZbj04HgghiBYnBEbB6WNufJNpug==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1782980499;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JyL5PdaPFHYX3i7vQWHjIhQnNMA6B18Dy1lEHBssn4w=;
	b=0bw0jIRWs3vrFQs1H1oSIYdaDp8Y9fC9SKBoyWMkIGWWhAh3yXn8EbVJVaAb5Ls2pJnsXE
	pPCnjDimInHr+4Ag==
Date: Thu, 02 Jul 2026 10:21:30 +0200
Subject: [PATCH v3 6/9] powerpc/vdso: Respect COMPAT_32BIT_TIME
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260702-vdso-compat_32bit_time-v3-6-db9f36d8d432@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782980489; l=4815;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=A9MgaUprgJVGbFgeodL0zyKOakZj3wMsENaid0m8QO4=;
 b=ioxD5xT1F09ElJiA4jXNW6UAuz4w1BiJNze+L6ddQbxyZtMz+uqOHcTzXmB8Uyf1O0qqN3tou
 ivKRRIORIVcA8EaxM6HbdrpJ81mHQ8ymLbLTgF2kZajR3jS2EhXtxAk
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:luto@kernel.org,m:tglx@kernel.org,m:mingo@redhat.com,m:bp@alien8.de,m:dave.hansen@linux.intel.com,m:x86@kernel.org,m:hpa@zytor.com,m:linux@armlinux.org.uk,m:catalin.marinas@arm.com,m:will@kernel.org,m:maddy@linux.ibm.com,m:mpe@ellerman.id.au,m:npiggin@gmail.com,m:chleroy@kernel.org,m:tsbogend@alpha.franken.de,m:vincenzo.frascino@arm.com,m:jstultz@google.com,m:sboyd@kernel.org,m:davem@davemloft.net,m:andreas@gaisler.com,m:thomas.weissschuh@linutronix.de,m:linux-kernel@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linuxppc-dev@lists.ozlabs.org,m:linux-mips@vger.kernel.org,m:arnd@arndb.de,m:linux-api@vger.kernel.org,m:sparclinux@vger.kernel.org,m:philmd@oss.qualcomm.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER(0.00)[thomas.weissschuh@linutronix.de,linux-api@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-6765-lists,linux-api=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[29];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,linutronix.de:dkim,linutronix.de:email,linutronix.de:mid,linutronix.de:from_mime,vger.kernel.org:from_smtp,arndb.de:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CF6E36F4DF4

If CONFIG_COMPAT_32BIT_TIME is disabled then the vDSO should not
provide any 32-bit time related functionality. This is the intended
effect of the kconfig option and also the fallback system calls would
also not be implemented.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/powerpc/kernel/vdso/gettimeofday.S  |  8 ++++++++
 arch/powerpc/kernel/vdso/vdso32.lds.S    |  8 +++++---
 arch/powerpc/kernel/vdso/vgettimeofday.c | 16 ++++++++++------
 3 files changed, 23 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/kernel/vdso/gettimeofday.S b/arch/powerpc/kernel/vdso/gettimeofday.S
index 1c8e51691bf8..c635cd1e77be 100644
--- a/arch/powerpc/kernel/vdso/gettimeofday.S
+++ b/arch/powerpc/kernel/vdso/gettimeofday.S
@@ -67,9 +67,11 @@
  * int __kernel_gettimeofday(struct timeval *tv, struct timezone *tz);
  *
  */
+#if defined(__powerpc64__) || defined(CONFIG_COMPAT_32BIT_TIME)
 V_FUNCTION_BEGIN(__kernel_gettimeofday)
 	cvdso_call __c_kernel_gettimeofday
 V_FUNCTION_END(__kernel_gettimeofday)
+#endif
 
 /*
  * Exact prototype of clock_gettime()
@@ -77,9 +79,11 @@ V_FUNCTION_END(__kernel_gettimeofday)
  * int __kernel_clock_gettime(clockid_t clock_id, struct timespec *tp);
  *
  */
+#if defined(__powerpc64__) || defined(CONFIG_COMPAT_32BIT_TIME)
 V_FUNCTION_BEGIN(__kernel_clock_gettime)
 	cvdso_call __c_kernel_clock_gettime
 V_FUNCTION_END(__kernel_clock_gettime)
+#endif
 
 /*
  * Exact prototype of clock_gettime64()
@@ -99,9 +103,11 @@ V_FUNCTION_END(__kernel_clock_gettime64)
  * int __kernel_clock_getres(clockid_t clock_id, struct timespec *res);
  *
  */
+#if defined(__powerpc64__) || defined(CONFIG_COMPAT_32BIT_TIME)
 V_FUNCTION_BEGIN(__kernel_clock_getres)
 	cvdso_call __c_kernel_clock_getres
 V_FUNCTION_END(__kernel_clock_getres)
+#endif
 
 /*
  * Exact prototype of clock_getres_time64()
@@ -122,6 +128,8 @@ V_FUNCTION_END(__kernel_clock_getres_time64)
  * time_t time(time *t);
  *
  */
+#if defined(__powerpc64__) || defined(CONFIG_COMPAT_32BIT_TIME)
 V_FUNCTION_BEGIN(__kernel_time)
 	cvdso_call __c_kernel_time call_time=1
 V_FUNCTION_END(__kernel_time)
+#endif
diff --git a/arch/powerpc/kernel/vdso/vdso32.lds.S b/arch/powerpc/kernel/vdso/vdso32.lds.S
index 3f384a2526ae..5e87c18fd282 100644
--- a/arch/powerpc/kernel/vdso/vdso32.lds.S
+++ b/arch/powerpc/kernel/vdso/vdso32.lds.S
@@ -119,13 +119,15 @@ VERSION
 {
 	VDSO_VERSION_STRING {
 	global:
-		__kernel_get_syscall_map;
+#ifdef CONFIG_COMPAT_32BIT_TIME
 		__kernel_gettimeofday;
 		__kernel_clock_gettime;
-		__kernel_clock_gettime64;
 		__kernel_clock_getres;
-		__kernel_clock_getres_time64;
 		__kernel_time;
+#endif /* CONFIG_COMPAT_32BIT_TIME */
+		__kernel_get_syscall_map;
+		__kernel_clock_gettime64;
+		__kernel_clock_getres_time64;
 		__kernel_get_tbfreq;
 		__kernel_sync_dicache;
 		__kernel_sigtramp32;
diff --git a/arch/powerpc/kernel/vdso/vgettimeofday.c b/arch/powerpc/kernel/vdso/vgettimeofday.c
index 3c194e1ab562..4b712fb01a3f 100644
--- a/arch/powerpc/kernel/vdso/vgettimeofday.c
+++ b/arch/powerpc/kernel/vdso/vgettimeofday.c
@@ -18,23 +18,25 @@ int __c_kernel_clock_getres(clockid_t clock_id, struct __kernel_timespec *res,
 	return __cvdso_clock_getres_data(vd, clock_id, res);
 }
 #else
+#ifdef CONFIG_COMPAT_32BIT_TIME
 int __c_kernel_clock_gettime(clockid_t clock, struct old_timespec32 *ts,
 			     const struct vdso_time_data *vd)
 {
 	return __cvdso_clock_gettime32_data(vd, clock, ts);
 }
 
-int __c_kernel_clock_gettime64(clockid_t clock, struct __kernel_timespec *ts,
-			       const struct vdso_time_data *vd)
-{
-	return __cvdso_clock_gettime_data(vd, clock, ts);
-}
-
 int __c_kernel_clock_getres(clockid_t clock_id, struct old_timespec32 *res,
 			    const struct vdso_time_data *vd)
 {
 	return __cvdso_clock_getres_time32_data(vd, clock_id, res);
 }
+#endif /* CONFIG_COMPAT_32BIT_TIME */
+
+int __c_kernel_clock_gettime64(clockid_t clock, struct __kernel_timespec *ts,
+			       const struct vdso_time_data *vd)
+{
+	return __cvdso_clock_gettime_data(vd, clock, ts);
+}
 
 int __c_kernel_clock_getres_time64(clockid_t clock_id, struct __kernel_timespec *res,
 				   const struct vdso_time_data *vd)
@@ -43,6 +45,7 @@ int __c_kernel_clock_getres_time64(clockid_t clock_id, struct __kernel_timespec
 }
 #endif
 
+#if defined(__powerpc64__) || defined(CONFIG_COMPAT_32BIT_TIME)
 int __c_kernel_gettimeofday(struct __kernel_old_timeval *tv, struct timezone *tz,
 			    const struct vdso_time_data *vd)
 {
@@ -53,3 +56,4 @@ __kernel_old_time_t __c_kernel_time(__kernel_old_time_t *time, const struct vdso
 {
 	return __cvdso_time_data(vd, time);
 }
+#endif

-- 
2.55.0



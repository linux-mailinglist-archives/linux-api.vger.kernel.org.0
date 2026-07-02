Return-Path: <linux-api+bounces-6762-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id h8mmGbciRmozKgsAu9opvQ
	(envelope-from <linux-api+bounces-6762-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Thu, 02 Jul 2026 10:35:03 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EE94B6F4D65
	for <lists+linux-api@lfdr.de>; Thu, 02 Jul 2026 10:35:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linutronix.de header.s=2020 header.b=2iwXWmQI;
	dkim=pass header.d=linutronix.de header.s=2020e header.b=SBVDxiAy;
	spf=pass (mail.lfdr.de: domain of "linux-api+bounces-6762-lists+linux-api=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-api+bounces-6762-lists+linux-api=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linutronix.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E16873054174
	for <lists+linux-api@lfdr.de>; Thu,  2 Jul 2026 08:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6346E42A784;
	Thu,  2 Jul 2026 08:21:40 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7B4A42980D;
	Thu,  2 Jul 2026 08:21:38 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782980500; cv=none; b=l/VFAe/C/X+PIOiniwtf/tYuzcxzY0d3Rg4k0rA9jJXIjWxuvutz47sIyvGOzycYBvvOVC73h6C+31FgFMLlmHMyX91RkUk8+AUn47Q6tIed/xZxWq0rDc5SlbQK74coBAM5KfoqsDUQkAPxErkfoZ5/GUNTwHqoKx8+w93gAIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782980500; c=relaxed/simple;
	bh=aE7B3vly9DVH5JNvTLoDjijb1pgHA5flYmw5pog0TZM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XFxrJ7bIZIGIce3xTyqfUvzyMrIyoQlOEpYck0KGW31hXI073vOODU0gECOJk5jFx8TZ2QoE7hw2cLbh7ZSeNtPqpJbWjuOhLkfp1GLZiTP/AEnG8INxo3gpkUoqEG8OZcfMu7W1OegTYm22yDVh5QNpAt6Gn65wclZgHyxbNjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2iwXWmQI; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SBVDxiAy; arc=none smtp.client-ip=193.142.43.55
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1782980495;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SSwZ2fRFDA2B6U/uyvpiDsqnsXPvOjViDV0jUJxsvyw=;
	b=2iwXWmQIYgFDTQyeAME9Zso9Qtf0EiOr4yoVSfEh2dZJSGiHIxlnnInb8cz70jhKBEtjKj
	iw6SuTH4hFTrWYzh5lcHkpcK530yqwQhv2iiWTBiXUHX4mfKJiinYiEBOcaxJiD8HPtCrf
	66pg9vHZM7qyMOowR0w4TX86gqJrX0JicckvsBlu5aCaox4iiFcW7baRWadXNVnJtpDZEd
	NkRkJP/SJwvx7Fk7EqDUDHv/Li9OQmkXREeegpDYl3wXX6UC6ICpTyQym1tL7+ddv0ryAB
	aOelgILRJr5dNjFXugOurzNNLOXjzuCzzxKJvUiu2jeqVAnYnN+YKsC6WP9Iwg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1782980495;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SSwZ2fRFDA2B6U/uyvpiDsqnsXPvOjViDV0jUJxsvyw=;
	b=SBVDxiAyRNJI6ZrNDor6bfSlx959wrkz9D9TmxhtQOouqzzqbJx/vUi1Ih5JA6VM8yyGNw
	P2IMNk0zxy6Wf0Bg==
Date: Thu, 02 Jul 2026 10:21:27 +0200
Subject: [PATCH v3 3/9] x86/vdso: Respect COMPAT_32BIT_TIME
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260702-vdso-compat_32bit_time-v3-3-db9f36d8d432@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782980489; l=3288;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=aE7B3vly9DVH5JNvTLoDjijb1pgHA5flYmw5pog0TZM=;
 b=JoI1ppcgZTmMlDXlGvea1wDNGWX7R7KezhNa1+xNMdembkpPHF5FHdzzxrsZ1mBomtqL0kLKE
 IIyAN6HiRn/A9JWkmOftgK0gbP8fMl1IiSeYzE/7zXf7Su6WXph5Igk
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:luto@kernel.org,m:tglx@kernel.org,m:mingo@redhat.com,m:bp@alien8.de,m:dave.hansen@linux.intel.com,m:x86@kernel.org,m:hpa@zytor.com,m:linux@armlinux.org.uk,m:catalin.marinas@arm.com,m:will@kernel.org,m:maddy@linux.ibm.com,m:mpe@ellerman.id.au,m:npiggin@gmail.com,m:chleroy@kernel.org,m:tsbogend@alpha.franken.de,m:vincenzo.frascino@arm.com,m:jstultz@google.com,m:sboyd@kernel.org,m:davem@davemloft.net,m:andreas@gaisler.com,m:thomas.weissschuh@linutronix.de,m:linux-kernel@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linuxppc-dev@lists.ozlabs.org,m:linux-mips@vger.kernel.org,m:arnd@arndb.de,m:linux-api@vger.kernel.org,m:sparclinux@vger.kernel.org,m:philmd@oss.qualcomm.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER(0.00)[thomas.weissschuh@linutronix.de,linux-api@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-6762-lists,linux-api=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arndb.de:email,linutronix.de:dkim,linutronix.de:email,linutronix.de:mid,linutronix.de:from_mime,vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EE94B6F4D65

If CONFIG_COMPAT_32BIT_TIME is disabled then the vDSO should not
provide any 32-bit time related functionality. This is the intended
effect of the kconfig option and also the fallback system calls would
also not be implemented.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/x86/entry/vdso/common/vclock_gettime.c | 20 ++++++++++++--------
 arch/x86/entry/vdso/vdso32/vdso32.lds.S     |  2 ++
 2 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/arch/x86/entry/vdso/common/vclock_gettime.c b/arch/x86/entry/vdso/common/vclock_gettime.c
index 57066f346b3f..304dbd1f9db4 100644
--- a/arch/x86/entry/vdso/common/vclock_gettime.c
+++ b/arch/x86/entry/vdso/common/vclock_gettime.c
@@ -15,6 +15,7 @@
 
 #include "lib/vdso/gettimeofday.c"
 
+#if defined(__x86_64__) || defined(CONFIG_COMPAT_32BIT_TIME)
 int __vdso_gettimeofday(struct __kernel_old_timeval *tv, struct timezone *tz)
 {
 	return __cvdso_gettimeofday(tv, tz);
@@ -29,6 +30,7 @@ __kernel_old_time_t __vdso_time(__kernel_old_time_t *t)
 }
 
 __kernel_old_time_t time(__kernel_old_time_t *t)	__attribute__((weak, alias("__vdso_time")));
+#endif /* CONFIG_COMPAT_32BIT_TIME */
 
 
 #if defined(CONFIG_X86_64) && !defined(BUILD_VDSO32_64)
@@ -51,6 +53,7 @@ int clock_getres(clockid_t, struct __kernel_timespec *)
 
 #else
 /* i386 only */
+#ifdef CONFIG_COMPAT_32BIT_TIME
 int __vdso_clock_gettime(clockid_t clock, struct old_timespec32 *ts)
 {
 	return __cvdso_clock_gettime32(clock, ts);
@@ -59,14 +62,6 @@ int __vdso_clock_gettime(clockid_t clock, struct old_timespec32 *ts)
 int clock_gettime(clockid_t, struct old_timespec32 *)
 	__attribute__((weak, alias("__vdso_clock_gettime")));
 
-int __vdso_clock_gettime64(clockid_t clock, struct __kernel_timespec *ts)
-{
-	return __cvdso_clock_gettime(clock, ts);
-}
-
-int clock_gettime64(clockid_t, struct __kernel_timespec *)
-	__attribute__((weak, alias("__vdso_clock_gettime64")));
-
 int __vdso_clock_getres(clockid_t clock, struct old_timespec32 *res)
 {
 	return __cvdso_clock_getres_time32(clock, res);
@@ -74,6 +69,15 @@ int __vdso_clock_getres(clockid_t clock, struct old_timespec32 *res)
 
 int clock_getres(clockid_t, struct old_timespec32 *)
 	__attribute__((weak, alias("__vdso_clock_getres")));
+#endif /* CONFIG_COMPAT_32BIT_TIME */
+
+int __vdso_clock_gettime64(clockid_t clock, struct __kernel_timespec *ts)
+{
+	return __cvdso_clock_gettime(clock, ts);
+}
+
+int clock_gettime64(clockid_t, struct __kernel_timespec *)
+	__attribute__((weak, alias("__vdso_clock_gettime64")));
 
 int __vdso_clock_getres_time64(clockid_t clock, struct __kernel_timespec *ts)
 {
diff --git a/arch/x86/entry/vdso/vdso32/vdso32.lds.S b/arch/x86/entry/vdso/vdso32/vdso32.lds.S
index cee8f7f9fe80..00629192db56 100644
--- a/arch/x86/entry/vdso/vdso32/vdso32.lds.S
+++ b/arch/x86/entry/vdso/vdso32/vdso32.lds.S
@@ -23,10 +23,12 @@ VERSION
 {
 	LINUX_2.6 {
 	global:
+#ifdef CONFIG_COMPAT_32BIT_TIME
 		__vdso_clock_gettime;
 		__vdso_gettimeofday;
 		__vdso_time;
 		__vdso_clock_getres;
+#endif /* CONFIG_COMPAT_32BIT_TIME */
 		__vdso_clock_gettime64;
 		__vdso_clock_getres_time64;
 		__vdso_getcpu;

-- 
2.55.0



Return-Path: <linux-api+bounces-6764-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id D3MIELYhRmr0KQsAu9opvQ
	(envelope-from <linux-api+bounces-6764-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Thu, 02 Jul 2026 10:30:46 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BB36D6F4CC5
	for <lists+linux-api@lfdr.de>; Thu, 02 Jul 2026 10:30:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linutronix.de header.s=2020 header.b=zIUckbgh;
	dkim=pass header.d=linutronix.de header.s=2020e header.b=mzvGG3dO;
	spf=pass (mail.lfdr.de: domain of "linux-api+bounces-6764-lists+linux-api=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-api+bounces-6764-lists+linux-api=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linutronix.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4EC2030D1D76
	for <lists+linux-api@lfdr.de>; Thu,  2 Jul 2026 08:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DD1942A79E;
	Thu,  2 Jul 2026 08:21:42 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D3042A780;
	Thu,  2 Jul 2026 08:21:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782980501; cv=none; b=jMwRzhYq3Bnnsmi8P5c6fv3ZR/Bo7aty+sdR96BGHnU3lETE78IliKbizJrlJ61Q8RdarSt/hgmy0eXiVxyEBxqTANfjyRFuvrxhpGG7/Ltx2WEQooRpe76xfEg6QvNyAYRLGEKlPLPSPcPVWZsFNNdv1ln5A88gqj1w1qR9Rxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782980501; c=relaxed/simple;
	bh=ES3WKPDyUgyS4mPZBdPnY42fiogZCV5UazSQTeq58Dk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gGPbr07DJZAa6Y6bWJ29GIcdJqTQp0l4wgpkY2IVerVLMEK0Fa/xAgFkp6hLmnasoem2nQZ2XuYcXfjgBhYl18JLUC5uA8TYPyRacH+HvkHe3SfqfWKdZeCf8390Taqdrwsv7KCwB5ndkKWZlIqvtWlVjeYlUSrCbKQMIM0Vles=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zIUckbgh; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mzvGG3dO; arc=none smtp.client-ip=193.142.43.55
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1782980499;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+lF/nwHjua943bbA428Xe7dIjOUux5tR7dU/qOukkB0=;
	b=zIUckbghrVUWq++3SdwGiNS6hqtwL1ECE/nGMKBxSzyoK0nNuEQlPC9olbDNMF4LyX0DaD
	D9jsQJgfpptuGSBiygZMLxvc8xM5JPlTNq/+/usMun6pndhcmi8+cAGDjeMZBD8CVSWjMC
	cSxTX4O+9hFM2EXNLrc1cCrHMJ09RdlGSXV3zIBp1BGrSbX5AGRx+3tDyEshidtpxCKTbf
	Iw2mfti3Ve+tCM9dI6iAGNm5VM3jkSEBKK3MfJjAKUFGTOO9bv1Y6oQ2WYlsZM767k7o3w
	BBR9FZV6OH99wAQpqY+31OLLg/bCcoibEM0T7udoPGbaTJSwx1EDbCYTkmyaYw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1782980499;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+lF/nwHjua943bbA428Xe7dIjOUux5tR7dU/qOukkB0=;
	b=mzvGG3dOcZHn3Bw/VMQq3Xn/YGXVidMo+yuUs/NZ8JkXHKA9jalYehmEdgClhub48HYaD0
	Xd54bdWSzOK2epAg==
Date: Thu, 02 Jul 2026 10:21:29 +0200
Subject: [PATCH v3 5/9] ARM: VDSO: Respect COMPAT_32BIT_TIME
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260702-vdso-compat_32bit_time-v3-5-db9f36d8d432@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782980489; l=2321;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=ES3WKPDyUgyS4mPZBdPnY42fiogZCV5UazSQTeq58Dk=;
 b=ybrdOPQuXpKp06a4BqOOw7OeR9tiucSdB1PuF41euwS2bSZTkMgA8GwtnbkNpvOB/AYkjXRhC
 CJQa5ZQgOsyChDKK/jbOt1p/WQCBYmDgYI3F5wUWT0kXdflZin1iR+t
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:luto@kernel.org,m:tglx@kernel.org,m:mingo@redhat.com,m:bp@alien8.de,m:dave.hansen@linux.intel.com,m:x86@kernel.org,m:hpa@zytor.com,m:linux@armlinux.org.uk,m:catalin.marinas@arm.com,m:will@kernel.org,m:maddy@linux.ibm.com,m:mpe@ellerman.id.au,m:npiggin@gmail.com,m:chleroy@kernel.org,m:tsbogend@alpha.franken.de,m:vincenzo.frascino@arm.com,m:jstultz@google.com,m:sboyd@kernel.org,m:davem@davemloft.net,m:andreas@gaisler.com,m:thomas.weissschuh@linutronix.de,m:linux-kernel@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linuxppc-dev@lists.ozlabs.org,m:linux-mips@vger.kernel.org,m:arnd@arndb.de,m:linux-api@vger.kernel.org,m:sparclinux@vger.kernel.org,m:philmd@oss.qualcomm.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER(0.00)[thomas.weissschuh@linutronix.de,linux-api@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-6764-lists,linux-api=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,arndb.de:email,qualcomm.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linutronix.de:dkim,linutronix.de:email,linutronix.de:mid,linutronix.de:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BB36D6F4CC5

If CONFIG_COMPAT_32BIT_TIME is disabled then the vDSO should not
provide any 32-bit time related functionality. This is the intended
effect of the kconfig option and also the fallback system calls would
also not be implemented.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/vdso/vdso.lds.S      |  2 ++
 arch/arm/vdso/vgettimeofday.c | 14 ++++++++------
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/arch/arm/vdso/vdso.lds.S b/arch/arm/vdso/vdso.lds.S
index 74d8d8bc8a40..e61038c0195a 100644
--- a/arch/arm/vdso/vdso.lds.S
+++ b/arch/arm/vdso/vdso.lds.S
@@ -70,9 +70,11 @@ VERSION
 {
 	LINUX_2.6 {
 	global:
+#ifdef CONFIG_COMPAT_32BIT_TIME
 		__vdso_clock_gettime;
 		__vdso_gettimeofday;
 		__vdso_clock_getres;
+#endif /* CONFIG_COMPAT_32BIT_TIME */
 		__vdso_clock_gettime64;
 		__vdso_clock_getres_time64;
 	local: *;
diff --git a/arch/arm/vdso/vgettimeofday.c b/arch/arm/vdso/vgettimeofday.c
index f7a2f5dc2fdc..3eebeddbfd18 100644
--- a/arch/arm/vdso/vgettimeofday.c
+++ b/arch/arm/vdso/vgettimeofday.c
@@ -10,16 +10,17 @@
 #include <asm/unwind.h>
 #include <vdso/gettime.h>
 
+#ifdef CONFIG_COMPAT_32BIT_TIME
 int __vdso_clock_gettime(clockid_t clock,
 			 struct old_timespec32 *ts)
 {
 	return __cvdso_clock_gettime32(clock, ts);
 }
 
-int __vdso_clock_gettime64(clockid_t clock,
-			   struct __kernel_timespec *ts)
+int __vdso_clock_getres(clockid_t clock_id,
+			struct old_timespec32 *res)
 {
-	return __cvdso_clock_gettime(clock, ts);
+	return __cvdso_clock_getres_time32(clock_id, res);
 }
 
 int __vdso_gettimeofday(struct __kernel_old_timeval *tv,
@@ -27,11 +28,12 @@ int __vdso_gettimeofday(struct __kernel_old_timeval *tv,
 {
 	return __cvdso_gettimeofday(tv, tz);
 }
+#endif /* CONFIG_COMPAT_32BIT_TIME */
 
-int __vdso_clock_getres(clockid_t clock_id,
-			struct old_timespec32 *res)
+int __vdso_clock_gettime64(clockid_t clock,
+			   struct __kernel_timespec *ts)
 {
-	return __cvdso_clock_getres_time32(clock_id, res);
+	return __cvdso_clock_gettime(clock, ts);
 }
 
 int __vdso_clock_getres_time64(clockid_t clock_id, struct __kernel_timespec *res)

-- 
2.55.0



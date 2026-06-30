Return-Path: <linux-api+bounces-6743-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id s8yxEzNzQ2p4YgoAu9opvQ
	(envelope-from <linux-api+bounces-6743-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Tue, 30 Jun 2026 09:41:39 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A4D7E6E149E
	for <lists+linux-api@lfdr.de>; Tue, 30 Jun 2026 09:41:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linutronix.de header.s=2020 header.b=2UBKjP6Z;
	dkim=pass header.d=linutronix.de header.s=2020e header.b=f83Sn6qI;
	spf=pass (mail.lfdr.de: domain of "linux-api+bounces-6743-lists+linux-api=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-api+bounces-6743-lists+linux-api=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linutronix.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7F6A6300FC6B
	for <lists+linux-api@lfdr.de>; Tue, 30 Jun 2026 07:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F6FD3E8C78;
	Tue, 30 Jun 2026 07:38:45 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A549A3E639D;
	Tue, 30 Jun 2026 07:38:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782805125; cv=none; b=OF4/OxQeLkMauFRgJaCY+n+6vFxEezkPcnyJ3g7g4ls+SRF62IcsjdEriW1qLshxMS1k70zWtRKSDa6WYVfUhShqGrfBfyCTBBDba7IipgPMvOBL7h0QsYmiYhgrWOoGUMSUIIOSAccVhAgpPwpbUGybS27YzwUulwjkvunOZvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782805125; c=relaxed/simple;
	bh=12QPBY1A1qwsYzo0GG6Ngj7WiSTW+DNwVbPq5hDEyT0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dPMd0MH/ESysEQUqyQQdJT9jYCwQzcKIYBMmZaHDwpKzDdypJ/Cx8xv0V68rCGNSoyjR/PVE1GTpcQnjsPo2HHTC/DDMM5+LpjH4sF17fC8CLHzgKvN33vBPSr15+cylh07hpJ+tG1l+PWTBzAiLMJKDACTdEAb7UnMhwWynwu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2UBKjP6Z; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=f83Sn6qI; arc=none smtp.client-ip=193.142.43.55
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1782805122;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J4jNR7IvW42yw2Udss8oMjXgT07Ci6ORkUJxbmsVFdo=;
	b=2UBKjP6ZHy3CRwMmUBUaL4kxEI/lQaVcZ5OwMsP2rjGQK+Loprr1BGaBZhBw4YAEi9z7dU
	M6igmNLI6dzAbCY20DEcphw4Q23zX7ya0jVLPy1lAkYUxtq9SepZP+OwypzPhHcj32BEhW
	Ezr2rAUK9JSOMiHtPCv7BzToplrlEQpPvrHeE2TEtb61dJiWT68d19hF+dfZil7Tmxs6Lo
	ddgnosAdzz+yq40r9sqRL3jnyJsPKSGU9rlv4WRbs43teWKh7R6DXeWYtUWhV2ir4tXK7v
	SNGZToUOxEBZII5zQxuMYa2cAOzWQOtElc3AGWQuRNgVxxh4O9E7EEVOj7u1FA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1782805122;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J4jNR7IvW42yw2Udss8oMjXgT07Ci6ORkUJxbmsVFdo=;
	b=f83Sn6qIhsaRZ/jxhSBKO89iQ/va46I2A9tQdntRDGvOCFXzAvYqPM/0vGIBMq5yP/ZOjK
	szz6xhbpCi37U5BA==
Date: Tue, 30 Jun 2026 09:38:38 +0200
Subject: [PATCH v2 9/9] vdso/gettimeofday: Verify COMPAT_32BIT_TIME
 interactions
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260630-vdso-compat_32bit_time-v2-9-520d194640dd@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782805116; l=1853;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=12QPBY1A1qwsYzo0GG6Ngj7WiSTW+DNwVbPq5hDEyT0=;
 b=iLniktrStdEyXZsTH8ubljifMoWZxQv7NLjjYBM7Yr1YVx3xlPUy0sysk+14qkrzN0NXTK1Vh
 udMagMcO4uOBheZv2oJSUM8e5CtprPBwpBd6EQbpcV+gSy6NQKJfUGS
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS(0.00)[m:luto@kernel.org,m:tglx@kernel.org,m:mingo@redhat.com,m:bp@alien8.de,m:dave.hansen@linux.intel.com,m:x86@kernel.org,m:hpa@zytor.com,m:linux@armlinux.org.uk,m:catalin.marinas@arm.com,m:will@kernel.org,m:maddy@linux.ibm.com,m:mpe@ellerman.id.au,m:npiggin@gmail.com,m:chleroy@kernel.org,m:tsbogend@alpha.franken.de,m:vincenzo.frascino@arm.com,m:jstultz@google.com,m:sboyd@kernel.org,m:davem@davemloft.net,m:andreas@gaisler.com,m:thomas.weissschuh@linutronix.de,m:linux-kernel@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linuxppc-dev@lists.ozlabs.org,m:linux-mips@vger.kernel.org,m:arnd@arndb.de,m:linux-api@vger.kernel.org,m:sparclinux@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[thomas.weissschuh@linutronix.de,linux-api@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-6743-lists,linux-api=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linutronix.de:dkim,linutronix.de:email,linutronix.de:mid,linutronix.de:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A4D7E6E149E

If CONFIG_COMPAT_32BIT_TIME is disabled then the vDSO should not
provide any 32-bit time related functionality.

Add some build-time validations to make sure the architecture-specific
glue satisfies this requirement.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 lib/vdso/gettimeofday.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/lib/vdso/gettimeofday.c b/lib/vdso/gettimeofday.c
index b8c1fc85eb74..f7a591aba59f 100644
--- a/lib/vdso/gettimeofday.c
+++ b/lib/vdso/gettimeofday.c
@@ -25,6 +25,8 @@
  */
 #include <asm/vdso/gettimeofday.h>
 
+#include <linux/build_bug.h>
+
 /* Bring in default accessors */
 #include <vdso/vsyscall.h>
 
@@ -325,6 +327,8 @@ __cvdso_clock_gettime32_data(const struct vdso_time_data *vd, clockid_t clock,
 	struct __kernel_timespec ts;
 	bool ok;
 
+	BUILD_BUG_ON(!IS_ENABLED(CONFIG_COMPAT_32BIT_TIME));
+
 	ok = __cvdso_clock_gettime_common(vd, clock, &ts);
 
 	if (unlikely(!ok))
@@ -354,6 +358,8 @@ __cvdso_gettimeofday_data(const struct vdso_time_data *vd,
 	BUILD_BUG();
 #endif
 
+	BUILD_BUG_ON(sizeof(tv->tv_sec) != 8 && !IS_ENABLED(CONFIG_COMPAT_32BIT_TIME));
+
 	if (likely(tv != NULL)) {
 		struct __kernel_timespec ts;
 
@@ -392,6 +398,8 @@ __cvdso_time_data(const struct vdso_time_data *vd, __kernel_old_time_t *time)
 	BUILD_BUG();
 #endif
 
+	BUILD_BUG_ON(sizeof(*time) != 8 && !IS_ENABLED(CONFIG_COMPAT_32BIT_TIME));
+
 	if (vdso_is_timens_clock(vc)) {
 		vd = vdso_timens_data(vd);
 		vc = vd->clock_data;
@@ -481,6 +489,8 @@ __cvdso_clock_getres_time32_data(const struct vdso_time_data *vd, clockid_t cloc
 	struct __kernel_timespec ts;
 	bool ok;
 
+	BUILD_BUG_ON(!IS_ENABLED(CONFIG_COMPAT_32BIT_TIME));
+
 	ok = __cvdso_clock_getres_common(vd, clock, &ts);
 
 	if (unlikely(!ok))

-- 
2.55.0



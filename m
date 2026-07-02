Return-Path: <linux-api+bounces-6759-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id M5kiDGoiRmoTKgsAu9opvQ
	(envelope-from <linux-api+bounces-6759-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Thu, 02 Jul 2026 10:33:46 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 69C9C6F4D08
	for <lists+linux-api@lfdr.de>; Thu, 02 Jul 2026 10:33:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linutronix.de header.s=2020 header.b=of+N59Ha;
	dkim=pass header.d=linutronix.de header.s=2020e header.b=uN9Hdc83;
	spf=pass (mail.lfdr.de: domain of "linux-api+bounces-6759-lists+linux-api=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-api+bounces-6759-lists+linux-api=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linutronix.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5600830446C2
	for <lists+linux-api@lfdr.de>; Thu,  2 Jul 2026 08:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8994841C2F4;
	Thu,  2 Jul 2026 08:21:33 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 092121EFFA1;
	Thu,  2 Jul 2026 08:21:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782980493; cv=none; b=b4AP0nWKtWVkmxcdCHQSl6pkoBzXEOicofN7Zd5fxlSaeLzpiqLjh8mQzfJx/Hv7JVu2dUmjdId1exYUB5zIA6Mk7f0aG/KaZvPJ5qn8Lw6Jv1BkrjKqVJfC7AOJM1z4pubYkWxvNVkEWDxz8FmIZuO6RsYVhhYCFn4cpH4GyX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782980493; c=relaxed/simple;
	bh=MR/1oQsubIswpQ1T7czms/mRrVaRqITHlz2n6JTUpl4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=O26hkKSvBhee3op0Vgxnlqb0671KZjNZJcn6hw7EQ8KAAsd7dIrG3ATvYOO5K3a1QfZJggAtOB/Qvsl76hO7Ve4EtX9/1fxwFE04jrSQOYu1ZYcx/3L/+9fTEaDJJ2AxZKqFsCnK3t0zWRM+W9nw1xe0ajBfZWBBX3mNTxAZ+S8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=of+N59Ha; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uN9Hdc83; arc=none smtp.client-ip=193.142.43.55
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1782980489;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=mJSzPYcuu70d1v2EawqMn7TqthwcQ1ssQg57IVhDWI4=;
	b=of+N59HaFTcbezAeOk+/17hY+A9dAUMSL0R9JbFEMZlA+nby5ylWi5WlxMj2cbxVgqtoX6
	3ROYEFfYafIQYkmKGJb3YKKBa8oT7It8ES1jGDuDnHZJg6BLs8TOAxVlYtOUje+4JN5zUh
	6rlS5LGUaV411jwX0tZLB2y1sqG3lcNLRh+9913Yt+jc2oHHKtciVLG5TH2EiEqdQyI9iT
	uGULIJoJUlBFYcyCwNWA0mQgbR8IdI8+L8xAOlesgBKm/lm+v/HWEO9qNkt66NrD7OTPU7
	VsVL0vpxTO7Xh55obb8zzMh8t1KQ+g4ycfp6un1P5BGtR3J5X8ButatRWQK55w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1782980489;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=mJSzPYcuu70d1v2EawqMn7TqthwcQ1ssQg57IVhDWI4=;
	b=uN9Hdc83IPYWMSKfkIs/YtSKjNdtWXYIe8rXO0da85TsqVeJfAaNeJbY+tm0TW1LYRA9+j
	B/4b13cGjW5KHSCQ==
Subject: [PATCH v3 0/9] vDSO: Respect COMPAT_32BIT_TIME
Date: Thu, 02 Jul 2026 10:21:24 +0200
Message-Id: <20260702-vdso-compat_32bit_time-v3-0-db9f36d8d432@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3XNwQoCIRDG8VcJzxk6lm6deo+IcNepBkoXNdmIf
 ffc7RAEHf8fzG9eLGEkTGy3eLGIhRIFX0MtF6y7Wn9BTq42AwFaSKl4cSnwLtx7m08KWsqnTHf
 k2IjGaIVboy2rx33EMw0zfDjWvlLKIT7nP0VO64cEMP/IIrng6iyg0da0tlP7G/lHjsHTsHLIJ
 rbAl9JK/KWgUhsQTm7Xei2c+6XGcXwD1i+6ywsBAAA=
X-Change-ID: 20260113-vdso-compat_32bit_time-e808763e976a
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782980489; l=4251;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=MR/1oQsubIswpQ1T7czms/mRrVaRqITHlz2n6JTUpl4=;
 b=IAPP7P7TT/qjpqsC8+BNXtHg/cnx42xojUXsQ9R2Hz9jbgOm2ACYHF+sMsfHVfS0U/4lV37Yl
 zsUyVwUeFmFBYzA4OF5fifGvug2xcpYakRt7qN14FxkhZlDROdgH2hq
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS(0.00)[m:luto@kernel.org,m:tglx@kernel.org,m:mingo@redhat.com,m:bp@alien8.de,m:dave.hansen@linux.intel.com,m:x86@kernel.org,m:hpa@zytor.com,m:linux@armlinux.org.uk,m:catalin.marinas@arm.com,m:will@kernel.org,m:maddy@linux.ibm.com,m:mpe@ellerman.id.au,m:npiggin@gmail.com,m:chleroy@kernel.org,m:tsbogend@alpha.franken.de,m:vincenzo.frascino@arm.com,m:jstultz@google.com,m:sboyd@kernel.org,m:davem@davemloft.net,m:andreas@gaisler.com,m:thomas.weissschuh@linutronix.de,m:linux-kernel@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linuxppc-dev@lists.ozlabs.org,m:linux-mips@vger.kernel.org,m:arnd@arndb.de,m:linux-api@vger.kernel.org,m:sparclinux@vger.kernel.org,m:philmd@oss.qualcomm.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[thomas.weissschuh@linutronix.de,linux-api@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-6759-lists,linux-api=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 69C9C6F4D08

If CONFIG_COMPAT_32BIT_TIME is disabled then the vDSO should not
provide any 32-bit time related functionality. This is the intended
effect of the kconfig option and also the fallback system calls would
also not be implemented.

I also tried to introduce some helpers to avoid much of the ifdeffery,
but due to the high variance in the architecture-specific glue code
these would need to handle, they ended up being worse than the current
proposal.

As a side-effect this will make the self-tests more reliable,
as there is now always a matching syscall available for each vDSO function.

clock_getres_time64() was only introduced in v6.19, so libc implementations
are likely not using it yet.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
Changes in v3:
- Pick up tags.
- Fix incorrect references gettimeofday() in per-arch commit messages.
- Test for CONFIG_COMPAT_32BIT_TIME over __WANT_OLD_TIME_TYPE_SYSCALL in compat_settimeofday()
- Link to v2: https://patch.msgid.link/20260630-vdso-compat_32bit_time-v2-0-520d194640dd@linutronix.de

Changes in v2:
- Also handle SPARC.
- Drop MIPS cleanup patches.
- Also handle gettimeofday().
- Add more static validations.
- Rebase on v7.2-rc1.
- Link to v1: https://lore.kernel.org/r/20260227-vdso-compat_32bit_time-v1-0-3f0286a7bac3@linutronix.de

To: Andy Lutomirski <luto@kernel.org>
To: Thomas Gleixner <tglx@kernel.org>
To: Ingo Molnar <mingo@redhat.com>
To: Borislav Petkov <bp@alien8.de>
To: Dave Hansen <dave.hansen@linux.intel.com>
To: x86@kernel.org
To: H. Peter Anvin <hpa@zytor.com>
To: Russell King <linux@armlinux.org.uk>
To: Catalin Marinas <catalin.marinas@arm.com>
To: Will Deacon <will@kernel.org>
To: Madhavan Srinivasan <maddy@linux.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
To: Nicholas Piggin <npiggin@gmail.com>
To: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: Vincenzo Frascino <vincenzo.frascino@arm.com>
To: John Stultz <jstultz@google.com>
To: Stephen Boyd <sboyd@kernel.org>
To: "David S. Miller" <davem@davemloft.net>
To: Andreas Larsson <andreas@gaisler.com>
Cc: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-mips@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: linux-api@vger.kernel.org
Cc: sparclinux@vger.kernel.org
Cc: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

---
Thomas Weißschuh (9):
      time: Respect COMPAT_32BIT_TIME for old time type functions
      vdso/gettimeofday: Validate system call existence for time() and gettimeofday()
      x86/vdso: Respect COMPAT_32BIT_TIME
      arm64: vdso32: Respect COMPAT_32BIT_TIME
      ARM: VDSO: Respect COMPAT_32BIT_TIME
      powerpc/vdso: Respect COMPAT_32BIT_TIME
      MIPS: VDSO: Respect COMPAT_32BIT_TIME
      sparc: vdso: Respect COMPAT_32BIT_TIME
      vdso/gettimeofday: Verify COMPAT_32BIT_TIME interactions

 arch/arm/vdso/vdso.lds.S                    |  2 ++
 arch/arm/vdso/vgettimeofday.c               | 14 ++++++++------
 arch/arm64/kernel/vdso32/vdso.lds.S         |  2 ++
 arch/arm64/kernel/vdso32/vgettimeofday.c    | 14 ++++++++------
 arch/mips/vdso/vdso.lds.S                   |  2 ++
 arch/mips/vdso/vgettimeofday.c              |  3 +++
 arch/powerpc/kernel/vdso/gettimeofday.S     |  8 ++++++++
 arch/powerpc/kernel/vdso/vdso32.lds.S       |  8 +++++---
 arch/powerpc/kernel/vdso/vgettimeofday.c    | 16 ++++++++++------
 arch/sparc/vdso/vclock_gettime.c            |  4 ++++
 arch/sparc/vdso/vdso32/vdso32.lds.S         |  6 ++++--
 arch/x86/entry/vdso/common/vclock_gettime.c | 20 ++++++++++++--------
 arch/x86/entry/vdso/vdso32/vdso32.lds.S     |  2 ++
 kernel/sys_ni.c                             |  4 ++++
 kernel/time/time.c                          | 24 ++++++++++++++++++++----
 lib/vdso/gettimeofday.c                     | 20 ++++++++++++++++++++
 16 files changed, 114 insertions(+), 35 deletions(-)
---
base-commit: e6da2429169af9b33f3629b69905d89bb5ee9e64
change-id: 20260113-vdso-compat_32bit_time-e808763e976a

Best regards,
--  
Thomas Weißschuh (Schneider Electric) <thomas.weissschuh@linutronix.de>



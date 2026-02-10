Return-Path: <linux-api+bounces-5819-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id INHCHthki2kMUQAAu9opvQ
	(envelope-from <linux-api+bounces-5819-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Tue, 10 Feb 2026 18:03:20 +0100
X-Original-To: lists+linux-api@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B8A211D805
	for <lists+linux-api@lfdr.de>; Tue, 10 Feb 2026 18:03:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 61BD83008D5B
	for <lists+linux-api@lfdr.de>; Tue, 10 Feb 2026 17:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBE0A3191A9;
	Tue, 10 Feb 2026 17:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="eHCnZIrm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="L54FpaJv"
X-Original-To: linux-api@vger.kernel.org
Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B623931B114;
	Tue, 10 Feb 2026 17:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770742985; cv=none; b=Xlv333jBWGKkgrs5ky23xOoL0Rs/R0h0d9x9oeO24R/8LCf5jss8VwizscP2L3cMPD/Z1KEO38p5de4U+vVDcdsu8qMPauUyRgR9gJBZegsegz664sAx5fWOTigQy3RIjOONsx80fRdDAT4EfqPAzpjr//ZvYbLzns32dmMclfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770742985; c=relaxed/simple;
	bh=stPxOkgbO1jeBz9CXCloRLRAQOM7pP6vBZNW0yyqfeg=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:Subject:Content-Type; b=d5uMmnFNDy/EJP1pFjJZIfEM87RzXhUoO286FQORqxhgFt6NVDEhYzIS38goyjJ8ZLnwch1n+/1U/M9SQblUU/ME6yyh4mZEf79cz3l85rA6QNvzaqTA8Sm5tDBlj/WlInM6RTjpw7ov7KfsQOujVFAGSYTs9ycjkBsxQiex8RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=eHCnZIrm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=L54FpaJv; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id CCB261D0002A;
	Tue, 10 Feb 2026 12:03:02 -0500 (EST)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-04.internal (MEProxy); Tue, 10 Feb 2026 12:03:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm2; t=1770742982; x=1770829382; bh=Lt
	kBbfwxVwRXO8FBLfGRvqyTfc4xuFOhN2AraliA2kU=; b=eHCnZIrmc3TA6CeuB9
	ZnGerFyEBTs/ZUC4APwTkgSMBEaqh1Y7Ii3Es7LpTSh2iwmBMWCpbJuU9p1WeXMB
	qRiT7R6V8M0bZhuqJWk6dtF6XZhP8qXXPB3QLoJbpesUAowEtYnp1dvW01gXYYgo
	WIuvIB1B6IOGqB/1C95apay3kSBTs1TTeHnFnQ/7ZVAcXsy8ZhUPLeBX6zFo3Si5
	KsGnowPNGM/2C5dkXnZxWeL8XdC/PAbNvU9m21O80RJi8XcScpBPnSM/FQI0d5HV
	gWbe8X9lHgVKbJe2cVUULhW7yti/V/lXuH46EPCC2FvUlxcKAdRuh59v7t3k8ekl
	6KHA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1770742982; x=1770829382; bh=LtkBbfwxVwRXO8FBLfGRvqyTfc4x
	uFOhN2AraliA2kU=; b=L54FpaJvw/CMQfX6I4vTb4Dlp3vGH7HJF5dc0YAqfs5I
	4qiUPzcSZCWAdfcHi70GBucKFd7y/FzkORnwYzcsyHd7j37NdnKP/uZ4VJinUPzu
	RtwadAb69ucyfIcth+c8k+8NZulu92wqHIhB4gkaLsm7Q66okd/QkGcAWf8njpJE
	Z6j/1X031LnauG236hKvGBreQRJlbd0YibXcUj6SpZRBa18/CCM0ErF5D938ANo+
	JqFFQx729kvULwI6DQOZrhJ506wq1g5CxD9frrnaNhxi5tfOSo4OBT1JODS3hxUC
	xU/ET3iL6dlgqrv42U7PMvMzhcf5i201t7s/SHUUPw==
X-ME-Sender: <xms:xGSLaacwokSefzO97-uoLtxPWRzI7QdAexrD6BWLw_F9pX0RBMQmNw>
    <xme:xGSLafCUR3iwv6-9CNBkFcLPVklhXKyMdqtnKPKTwPJh4bTCN5y-DDHRteXCrIQRf
    pFrC6_FEnPx7PsQ74lhJDvOydRR4Y8STCVTUzE2z_1o7R_XBrpMJcql>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvtddtvdefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkffutgfgsehtqhertdertdejnecuhfhrohhmpedftehrnhguuceu
    vghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvghrnh
    epvdeigeeghffhhffguedvvdelvdfftdfgvdfftddvgfeggefhkedtfeeutddvuefgnecu
    ffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggvpdhnsggprhgtphht
    thhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehthhhomhgrshdrfigvih
    hsshhstghhuhhhsehlihhnuhhtrhhonhhigidruggvpdhrtghpthhtohepthhorhhvrghl
    ughssehlihhnuhigqdhfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopehlihhnuh
    igqdgrphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidq
    rghrtghhsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:xGSLaanGMmok0MA0NQVZt4MmaJahxb7aO6cUAg_LplUdslenjugnyA>
    <xmx:xGSLadS5fNbdWuPC8Py5xTdJxd5Xn0Zu3DuFjP_Op_8jgrWFT44RsA>
    <xmx:xGSLacKqahEJp3DbsrVC01qFEMhwBYFtzXlnANx2VjnmXs4-hFi62w>
    <xmx:xGSLaTDn2QF1A1zKEqc8SvDJcNfHjT3m2gvtlLiSWCbcQPX8_oi25w>
    <xmx:xmSLaeLEFdqoCfDRXbL2PbnW0QxSQIqM8Z8eMrh6j5IolofVVGSS3WKW>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id A6F5370006F; Tue, 10 Feb 2026 12:03:00 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 10 Feb 2026 18:02:40 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
Cc: Linux-Arch <linux-arch@vger.kernel.org>, linux-api@vger.kernel.org,
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Message-Id: <836fc2ce-751f-4eb0-bdb4-f43f83401b89@app.fastmail.com>
Subject: [GIT PULL] asm-generic header updates for 7.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[arndb.de,none];
	R_DKIM_ALLOW(-0.20)[arndb.de:s=fm2,messagingengine.com:s=fm3];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-api];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,messagingengine.com:dkim];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[arnd@arndb.de,linux-api@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-5819-lists,linux-api=lfdr.de];
	DKIM_TRACE(0.00)[arndb.de:+,messagingengine.com:+]
X-Rspamd-Queue-Id: 5B8A211D805
X-Rspamd-Action: no action

The following changes since commit 0f61b1860cc3f52aef9036d7235ed1f017632=
193:

  Linux 6.19-rc5 (2026-01-11 17:03:14 -1000)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git t=
ags/asm-generic-7.0

for you to fetch changes up to adbbd9714f8058730f93c8df5c5bf1679456424b:

  scripts: headers_install.sh: Remove config leak ignore machinery (2026=
-01-30 16:46:17 +0100)

----------------------------------------------------------------
asm-generic header updates for 7.0

A series from Thomas Wei=C3=9Fschuh cleans up the UAPI header files to no
longer contain any references to Kconfig symbols, as these make no sense
in userspace. The build-time check for these was originally added by Sam
Ravnborg in linux-2.6.28, and a later version started warning for all
newly added CONFIG_* checks here but kept a list of known exceptions. Wi=
th
the last exceptions gone from that list, the warning is now unconditional
in 'make headers_install'.

John Garry contributed a cleanup of cpumask_of_node().

----------------------------------------------------------------
John Garry (1):
      include/asm-generic/topology.h: Remove unused definition of cpumas=
k_of_node()

Thomas Wei=C3=9Fschuh (5):
      ARC: Always use SWAPE instructions for __arch_swab32()
      ARM: uapi: Drop PSR_ENDSTATE
      nios2: uapi: Remove custom asm/swab.h from UAPI
      x86/uapi: Stop leaking kconfig references to userspace
      scripts: headers_install.sh: Remove config leak ignore machinery

 arch/arc/Kconfig                         |  5 ---
 arch/arc/Makefile                        |  3 +-
 arch/arc/include/uapi/asm/swab.h         | 63 -------------------------=
-------
 arch/arm/include/asm/processor.h         |  3 +-
 arch/arm/include/uapi/asm/ptrace.h       |  9 -----
 arch/arm/kernel/signal.c                 |  3 +-
 arch/nios2/include/{uapi =3D> }/asm/swab.h |  0
 arch/x86/include/uapi/asm/auxvec.h       |  2 +-
 include/asm-generic/topology.h           |  8 +---
 scripts/headers_install.sh               | 30 +--------------
 10 files changed, 10 insertions(+), 116 deletions(-)
 rename arch/nios2/include/{uapi =3D> }/asm/swab.h (100%)

diff --git a/arch/arc/Kconfig b/arch/arc/Kconfig
index f27e6b90428e..2ed7186c81c5 100644
--- a/arch/arc/Kconfig
+++ b/arch/arc/Kconfig
@@ -121,7 +121,6 @@ choice
 config ARC_CPU_770
 	bool "ARC770"
 	depends on ISA_ARCOMPACT
-	select ARC_HAS_SWAPE
 	help
 	  Support for ARC770 core introduced with Rel 4.10 (Summer 2011)
 	  This core has a bunch of cool new features:
@@ -340,10 +339,6 @@ config ARC_HAS_LLSC
 	default y
 	depends on !ARC_CANT_LLSC
=20
-config ARC_HAS_SWAPE
-	bool "Insn: SWAPE (endian-swap)"
-	default y
-
 if ISA_ARCV2
=20
 config ARC_USE_UNALIGNED_MEM_ACCESS
diff --git a/arch/arc/Makefile b/arch/arc/Makefile
index 0c5e6e6314f2..868805ffcfea 100644
--- a/arch/arc/Makefile
+++ b/arch/arc/Makefile
@@ -9,7 +9,7 @@ ifeq ($(CROSS_COMPILE),)
 CROSS_COMPILE :=3D $(call cc-cross-prefix, arc-linux- arceb-linux- arc-=
linux-gnu-)
 endif
=20
-cflags-y	+=3D -fno-common -pipe -fno-builtin -mmedium-calls -D__linux__
+cflags-y	+=3D -fno-common -pipe -fno-builtin -mmedium-calls -mswape -D_=
_linux__
=20
 tune-mcpu-def-$(CONFIG_ISA_ARCOMPACT)	:=3D -mcpu=3Darc700
 tune-mcpu-def-$(CONFIG_ISA_ARCV2)	:=3D -mcpu=3Dhs38
@@ -41,7 +41,6 @@ endif
 cflags-y				+=3D -fsection-anchors
=20
 cflags-$(CONFIG_ARC_HAS_LLSC)		+=3D -mlock
-cflags-$(CONFIG_ARC_HAS_SWAPE)		+=3D -mswape
=20
 ifdef CONFIG_ISA_ARCV2
=20
diff --git a/arch/arc/include/uapi/asm/swab.h b/arch/arc/include/uapi/as=
m/swab.h
index 8d1f1ef44ba7..417ea30f29f5 100644
--- a/arch/arc/include/uapi/asm/swab.h
+++ b/arch/arc/include/uapi/asm/swab.h
@@ -19,9 +19,6 @@
=20
 #include <linux/types.h>
=20
-/* Native single cycle endian swap insn */
-#ifdef CONFIG_ARC_HAS_SWAPE
-
 #define __arch_swab32(x)		\
 ({					\
 	unsigned int tmp =3D x;		\
@@ -32,66 +29,6 @@
 	tmp;				\
 })
=20
-#else
-
-/* Several ways of Endian-Swap Emulation for ARC
- * 0: kernel generic
- * 1: ARC optimised "C"
- * 2: ARC Custom instruction
- */
-#define ARC_BSWAP_TYPE	1
-
-#if (ARC_BSWAP_TYPE =3D=3D 1)		/******* Software only ********/
-
-/* The kernel default implementation of htonl is
- *		return  x<<24 | x>>24 |
- *		 (x & (__u32)0x0000ff00UL)<<8 | (x & (__u32)0x00ff0000UL)>>8;
- *
- * This generates 9 instructions on ARC (excluding the ld/st)
- *
- * 8051fd8c:	ld     r3,[r7,20]	; Mem op : Get the value to be swapped
- * 8051fd98:	asl    r5,r3,24		; get  3rd Byte
- * 8051fd9c:	lsr    r2,r3,24		; get  0th Byte
- * 8051fda0:	and    r4,r3,0xff00
- * 8051fda8:	asl    r4,r4,8		; get 1st Byte
- * 8051fdac:	and    r3,r3,0x00ff0000
- * 8051fdb4:	or     r2,r2,r5		; combine 0th and 3rd Bytes
- * 8051fdb8:	lsr    r3,r3,8		; 2nd Byte at correct place in Dst Reg
- * 8051fdbc:	or     r2,r2,r4		; combine 0,3 Bytes with 1st Byte
- * 8051fdc0:	or     r2,r2,r3		; combine 0,3,1 Bytes with 2nd Byte
- * 8051fdc4:	st     r2,[r1,20]	; Mem op : save result back to mem
- *
- * Joern suggested a better "C" algorithm which is great since
- * (1) It is portable to any architecture
- * (2) At the same time it takes advantage of ARC ISA (rotate intrns)
- */
-
-#define __arch_swab32(x)					\
-({	unsigned long __in =3D (x), __tmp;			\
-	__tmp =3D __in << 8 | __in >> 24; /* ror tmp,in,24 */	\
-	__in =3D __in << 24 | __in >> 8; /* ror in,in,8 */	\
-	__tmp ^=3D __in;						\
-	__tmp &=3D 0xff00ff;					\
-	__tmp ^ __in;						\
-})
-
-#elif (ARC_BSWAP_TYPE =3D=3D 2)	/* Custom single cycle bswap instructio=
n */
-
-#define __arch_swab32(x)						\
-({									\
-	unsigned int tmp =3D x;						\
-	__asm__(							\
-	"	.extInstruction	bswap, 7, 0x00, SUFFIX_NONE, SYNTAX_2OP	\n"\
-	"	bswap  %0, %1						\n"\
-	: "=3Dr" (tmp)							\
-	: "r" (tmp));							\
-	tmp;								\
-})
-
-#endif /* ARC_BSWAP_TYPE=3Dzzz */
-
-#endif /* CONFIG_ARC_HAS_SWAPE */
-
 #if !defined(__STRICT_ANSI__) || defined(__KERNEL__)
 #define __SWAB_64_THRU_32__
 #endif
diff --git a/arch/arm/include/asm/processor.h b/arch/arm/include/asm/pro=
cessor.h
index 326864f79d18..bba83228bc22 100644
--- a/arch/arm/include/asm/processor.h
+++ b/arch/arm/include/asm/processor.h
@@ -73,7 +73,8 @@ static inline void arch_thread_struct_whitelist(unsign=
ed long *offset,
 		regs->ARM_cpsr =3D USR26_MODE;				\
 	if (elf_hwcap & HWCAP_THUMB && pc & 1)				\
 		regs->ARM_cpsr |=3D PSR_T_BIT;				\
-	regs->ARM_cpsr |=3D PSR_ENDSTATE;					\
+	if (IS_ENABLED(CONFIG_CPU_ENDIAN_BE8))				\
+		regs->ARM_cpsr |=3D PSR_E_BIT;				\
 	regs->ARM_pc =3D pc & ~1;		/* pc */			\
 	regs->ARM_sp =3D sp;		/* sp */			\
 })
diff --git a/arch/arm/include/uapi/asm/ptrace.h b/arch/arm/include/uapi/=
asm/ptrace.h
index 8896c23ccba7..2ef917957005 100644
--- a/arch/arm/include/uapi/asm/ptrace.h
+++ b/arch/arm/include/uapi/asm/ptrace.h
@@ -102,15 +102,6 @@
 #define PSR_IT_MASK	0x0600fc00	/* If-Then execution state mask */
 #define PSR_ENDIAN_MASK	0x00000200	/* Endianness state mask */
=20
-/*
- * Default endianness state
- */
-#ifdef CONFIG_CPU_ENDIAN_BE8
-#define PSR_ENDSTATE	PSR_E_BIT
-#else
-#define PSR_ENDSTATE	0
-#endif
-
 /*=20
  * These are 'magic' values for PTRACE_PEEKUSR that return info about w=
here a
  * process is located in memory.
diff --git a/arch/arm/kernel/signal.c b/arch/arm/kernel/signal.c
index 79a6730fa0eb..7be9188d83d9 100644
--- a/arch/arm/kernel/signal.c
+++ b/arch/arm/kernel/signal.c
@@ -337,7 +337,8 @@ setup_return(struct pt_regs *regs, struct ksignal *k=
sig,
 			return 1;
 	}
=20
-	cpsr |=3D PSR_ENDSTATE;
+	if (IS_ENABLED(CONFIG_CPU_ENDIAN_BE8))
+		cpsr |=3D PSR_E_BIT;
=20
 	/*
 	 * Maybe we need to deliver a 32-bit signal to a 26-bit task.
diff --git a/arch/nios2/include/uapi/asm/swab.h b/arch/nios2/include/asm=
/swab.h
similarity index 100%
rename from arch/nios2/include/uapi/asm/swab.h
rename to arch/nios2/include/asm/swab.h
diff --git a/arch/x86/include/uapi/asm/auxvec.h b/arch/x86/include/uapi/=
asm/auxvec.h
index 6beb55bbefa4..bdde9e18f94e 100644
--- a/arch/x86/include/uapi/asm/auxvec.h
+++ b/arch/x86/include/uapi/asm/auxvec.h
@@ -11,7 +11,7 @@
 #define AT_SYSINFO_EHDR		33
=20
 /* entries in ARCH_DLINFO: */
-#if defined(CONFIG_IA32_EMULATION) || !defined(CONFIG_X86_64)
+#if defined(__KERNEL__) && (defined(CONFIG_IA32_EMULATION) || !defined(=
CONFIG_X86_64))
 # define AT_VECTOR_SIZE_ARCH 3
 #else /* else it's non-compat x86-64 */
 # define AT_VECTOR_SIZE_ARCH 2
diff --git a/include/asm-generic/topology.h b/include/asm-generic/topolo=
gy.h
index 4dbe715be65b..9865ba48c5b1 100644
--- a/include/asm-generic/topology.h
+++ b/include/asm-generic/topology.h
@@ -45,11 +45,7 @@
 #endif
=20
 #ifndef cpumask_of_node
-  #ifdef CONFIG_NUMA
-    #define cpumask_of_node(node)	((node) =3D=3D 0 ? cpu_online_mask : =
cpu_none_mask)
-  #else
-    #define cpumask_of_node(node)	((void)(node), cpu_online_mask)
-  #endif
+#define cpumask_of_node(node)	((void)(node), cpu_online_mask)
 #endif
 #ifndef pcibus_to_node
 #define pcibus_to_node(bus)	((void)(bus), -1)
@@ -61,7 +57,7 @@
 				 cpumask_of_node(pcibus_to_node(bus)))
 #endif
=20
-#endif	/* CONFIG_NUMA */
+#endif	/* !CONFIG_NUMA */
=20
 #if !defined(CONFIG_NUMA) || !defined(CONFIG_HAVE_MEMORYLESS_NODES)
=20
diff --git a/scripts/headers_install.sh b/scripts/headers_install.sh
index 0e4e939efc94..9c15e748761c 100755
--- a/scripts/headers_install.sh
+++ b/scripts/headers_install.sh
@@ -64,36 +64,10 @@ configs=3D$(sed -e '
 	d
 ' $OUTFILE)
=20
-# The entries in the following list do not result in an error.
-# Please do not add a new entry. This list is only for existing ones.
-# The list will be reduced gradually, and deleted eventually. (hopefull=
y)
-#
-# The format is <file-name>:<CONFIG-option> in each line.
-config_leak_ignores=3D"
-arch/arc/include/uapi/asm/swab.h:CONFIG_ARC_HAS_SWAPE
-arch/arm/include/uapi/asm/ptrace.h:CONFIG_CPU_ENDIAN_BE8
-arch/nios2/include/uapi/asm/swab.h:CONFIG_NIOS2_CI_SWAB_NO
-arch/nios2/include/uapi/asm/swab.h:CONFIG_NIOS2_CI_SWAB_SUPPORT
-arch/x86/include/uapi/asm/auxvec.h:CONFIG_IA32_EMULATION
-arch/x86/include/uapi/asm/auxvec.h:CONFIG_X86_64
-"
-
 for c in $configs
 do
-	leak_error=3D1
-
-	for ignore in $config_leak_ignores
-	do
-		if echo "$INFILE:$c" | grep -q "$ignore$"; then
-			leak_error=3D
-			break
-		fi
-	done
-
-	if [ "$leak_error" =3D 1 ]; then
-		echo "error: $INFILE: leak $c to user-space" >&2
-		exit 1
-	fi
+	echo "error: $INFILE: leak $c to user-space" >&2
+	exit 1
 done
=20
 rm -f $TMPFILE


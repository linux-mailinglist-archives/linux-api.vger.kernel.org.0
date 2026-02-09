Return-Path: <linux-api+bounces-5814-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id pjVWD9o4iWmW4gQAu9opvQ
	(envelope-from <linux-api+bounces-5814-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Mon, 09 Feb 2026 02:31:06 +0100
X-Original-To: lists+linux-api@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F86510ACF5
	for <lists+linux-api@lfdr.de>; Mon, 09 Feb 2026 02:31:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 176CC3005390
	for <lists+linux-api@lfdr.de>; Mon,  9 Feb 2026 01:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E2771F872D;
	Mon,  9 Feb 2026 01:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U69hS5qq"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-dy1-f194.google.com (mail-dy1-f194.google.com [74.125.82.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B911925BC
	for <linux-api@vger.kernel.org>; Mon,  9 Feb 2026 01:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770600661; cv=none; b=cPaHC1NHwWdSNFD2Msml0+i9Yw80sCsLHLIz3zXiNif4c/IhEwtuLkYyu7cFLlWQbFiHF5NRCnqBIyYE+YK4S1JSL+kxcRoF9lNkeSDXCdDB0W0RlD864WouV2zcAjQOdRDUim+XCsBZcxgVeh/izfNdzmIV4JouSnKh5HeMQkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770600661; c=relaxed/simple;
	bh=wI7neA7cOvGa+Pa0dTc3DjbMHPyblEyYN6NXplSL/Lw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=HrRJmldC5oU/0YJdpVHQjqj7f5vJsJCSaj6vdQ7SdF5i2FnmLkSyaagZ/kzLSpVPD7jpFbt21ueCnjLj0O+4maq1Owy0pDnA3yiXsAgL6z7CcqBIhq0l/Xp73XH4hW86D3Mo/3Wvr2bvjC9kNuZQe4JdkHyXSwNFmHoW6ClGQvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U69hS5qq; arc=none smtp.client-ip=74.125.82.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f194.google.com with SMTP id 5a478bee46e88-2ba6aa57d5fso554535eec.1
        for <linux-api@vger.kernel.org>; Sun, 08 Feb 2026 17:31:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770600660; x=1771205460; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=6miEFhpEOrxthrDbq/PS9u2QwZimnW/h6jNiIcsQ9d8=;
        b=U69hS5qqCXid2zK6ApQDiz/pxjhR+UNhEANJg/2nEg3WjPs3PUNaifn78w8izNhKp5
         LRCz5mJ3t5EBjef3ylHXedufT9rlTKpuMgODYlQW9hGjuHSlwoxy8+KkknjV4BryunZz
         oVNQTCrgmFfr6/IpRNwSF1BZFf38c8vzPQDtg78uetJoTHLYijRhKqm/kFKppUfQD2Fp
         5ZrvxSxzd/CWE9xDhfxM4aLNlzRH2WsX3BF6GoObukOruSG4M3+gykfiPGvnrazH98PP
         zPLyrIm3vjPbm2ZMt/Jl2CcTf5cQQIW/5JhwlNHItW3mzESwvhB/79ltpOtq7vFz3pYa
         pYTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770600660; x=1771205460;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6miEFhpEOrxthrDbq/PS9u2QwZimnW/h6jNiIcsQ9d8=;
        b=OnlqU6uCoaDQSC5qcRMnq+qBcLmIae3nMIFz40Tta9nFqmCr5EojtdXh/LWLQDpAYS
         cR0a7WWFbpjGuFVh0pQpf8yds70AuIQ6PNTemb7rnNUeASbox5aeYsY5wrqpwYCIs8I8
         UQGdo1DV3P+aR3Sv1AF9d4ha8BBPaf/EBHAZc5WknQ3Joh3tPfrx9iOxT0erUAK4cKGc
         jrjNcRCxkZrJF6wdrdVeKTDE2hoHWbf5yjWYVvjDELT2vKg6sQqifpt8AaOXMzFoyXwh
         BmVhGcNKtQipLouraP4BZEnZS7LysMz9J1EW3H8ctq4efBalcKWJAp2EsD/YlHDZZaUp
         dX7g==
X-Gm-Message-State: AOJu0YwZZIvQPSkiTPokS3e2tNKnOVAvaROuUAkBtmnZCbW1o7QUKcrD
	BVvcaaSM41nkyjBzI1fjPel6cwrjKEom/JdjiKFYH9lMQJB83+DRD9gSyeDBQRMH
X-Gm-Gg: AZuq6aJhfbGnYFSZyPWlF6RFZjNybSA8oBA71isbyfNfYr4nzSW58KrEXDGEZlP85xg
	pVrCZe8PiXmcDmenfmd4UvmDEvYrQJeHqdgtC07/bdxTCIhyHNP9qy+kbiFsJmi4Y5yaozRVZ+r
	IOxwnNNspJdNNvj07bAuZi5XmZrrSsXP2gcPZUnsOrMzfF+0PXX65/w0GPLM6TZz1s08hfTnqJd
	IhhawbB2XXy6rVy7nJmsgB8t2duCBUyHVmnNbkObHP/X6YJCo5fG2pbV8HHAPVMVlXsDTxy6/Jz
	k+n2G27O3k2l9jna9BLPqeCDikCuylEXLsZFtG2+hMve0xUwZgWy5Hr3XD3Y/onDuOkXJdaaJb/
	Ub3BRivjMsVGd+4AIKex32GEIFxBtgXCzdOnIK+fplSc1falhJOZHLFXIkjk9WloYk49z8fSetQ
	my9NotFKSYOlS+lxv7k2ZTFRh0gT/pA9OfldsizF2dvt1YKvNXGLRidZGmkTCACpZ39rzTiwhIG
	QWP6cebg/ISiJ3cvSs22GbdtEH2IofZvEoZlBC81FE6eKGGH+Itr3eX+qcMXoUrkD9NuChO/5Ly
	kIeeKw9y
X-Received: by 2002:a05:7300:7b94:b0:2b0:5028:bafd with SMTP id 5a478bee46e88-2b856453d5cmr3724692eec.8.1770600659180;
        Sun, 08 Feb 2026 17:30:59 -0800 (PST)
Received: from ethan-latitude5420.. (host-127-120.cafrjco.fresno.ca.us.clients.pavlovmedia.net. [68.180.127.120])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b855b0f624sm7577329eec.14.2026.02.08.17.30.58
        for <linux-api@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Feb 2026 17:30:58 -0800 (PST)
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
To: linux-api@vger.kernel.org
Subject: [PATCH] arch: m68k: remove incomplete, unusable Apollo hardware support
Date: Sun,  8 Feb 2026 17:30:41 -0800
Message-ID: <20260209013041.37536-1-enelsonmoore@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-5814-lists,linux-api=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_NEQ_ENVFROM(0.00)[enelsonmoore@gmail.com,linux-api@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-api];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6F86510ACF5
X-Rspamd-Action: no action

The m68k architecture contains very incomplete support for running on
Apollo Domain hardware. There are only timer, console, and framebuffer
drivers, and no storage or network drivers, so there is no way to
practically use it. It is not even capable of rebooting by itself (see
dn_dummy_reset() in arch/m68k/apollo/config.c).

arch/m68k/apollo has only received tree-wide changes and fixes by
inspection in the entire Git history (since Linux 2.6.12-rc2), so there
is clearly no interest in completing support for Apollo hardware.
Remove it to reduce future maintenance workload.

There are no uses of the removed <asm/bootinfo-apollo.h> UAPI header or
the constants removed from the <asm/bootinfo.h> UAPI header on GitHub
or Debian Code Search.

Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
---
 arch/m68k/Kbuild                             |   1 -
 arch/m68k/Kconfig.devices                    |   4 +-
 arch/m68k/Kconfig.machine                    |   8 -
 arch/m68k/apollo/Makefile                    |   6 -
 arch/m68k/apollo/apollo.h                    |   4 -
 arch/m68k/apollo/config.c                    | 240 --------
 arch/m68k/apollo/dn_ints.c                   |  50 --
 arch/m68k/configs/apollo_defconfig           | 595 -------------------
 arch/m68k/configs/multi_defconfig            |   1 -
 arch/m68k/include/asm/apollohw.h             |  90 ---
 arch/m68k/include/asm/config.h               |   2 -
 arch/m68k/include/asm/irq.h                  |   2 -
 arch/m68k/include/asm/setup.h                |  32 +-
 arch/m68k/include/uapi/asm/bootinfo-apollo.h |  29 -
 arch/m68k/include/uapi/asm/bootinfo.h        |   5 +-
 arch/m68k/kernel/head.S                      |  70 +--
 arch/m68k/kernel/setup_mm.c                  |   9 -
 drivers/video/fbdev/Kconfig                  |   8 -
 drivers/video/fbdev/Makefile                 |   1 -
 drivers/video/fbdev/dnfb.c                   | 307 ----------
 20 files changed, 19 insertions(+), 1445 deletions(-)
 delete mode 100644 arch/m68k/apollo/Makefile
 delete mode 100644 arch/m68k/apollo/apollo.h
 delete mode 100644 arch/m68k/apollo/config.c
 delete mode 100644 arch/m68k/apollo/dn_ints.c
 delete mode 100644 arch/m68k/configs/apollo_defconfig
 delete mode 100644 arch/m68k/include/asm/apollohw.h
 delete mode 100644 arch/m68k/include/uapi/asm/bootinfo-apollo.h
 delete mode 100644 drivers/video/fbdev/dnfb.c

diff --git a/arch/m68k/Kbuild b/arch/m68k/Kbuild
index 7762af9f6def..421bad0780e1 100644
--- a/arch/m68k/Kbuild
+++ b/arch/m68k/Kbuild
@@ -5,7 +5,6 @@ obj-$(CONFIG_AMIGA)		+= amiga/
 obj-$(CONFIG_ATARI)		+= atari/
 obj-$(CONFIG_MAC)		+= mac/
 obj-$(CONFIG_HP300)		+= hp300/
-obj-$(CONFIG_APOLLO)		+= apollo/
 obj-$(CONFIG_MVME147)		+= mvme147/
 obj-$(CONFIG_MVME16x)		+= mvme16x/
 obj-$(CONFIG_BVME6000)		+= bvme6000/
diff --git a/arch/m68k/Kconfig.devices b/arch/m68k/Kconfig.devices
index e6e3efac1840..75370aadba6a 100644
--- a/arch/m68k/Kconfig.devices
+++ b/arch/m68k/Kconfig.devices
@@ -9,8 +9,8 @@ config ARCH_MAY_HAVE_PC_FDC
 menu "Platform devices"
 
 config HEARTBEAT
-	bool "Use power LED as a heartbeat" if AMIGA || APOLLO || ATARI || Q40
-	default y if !AMIGA && !APOLLO && !ATARI && !Q40 && HP300
+	bool "Use power LED as a heartbeat" if AMIGA || ATARI || Q40
+	default y if !AMIGA && !ATARI && !Q40 && HP300
 	help
 	  Use the power-on LED on your machine as a load meter.  The exact
 	  behavior is platform-dependent, but normally the flash frequency is
diff --git a/arch/m68k/Kconfig.machine b/arch/m68k/Kconfig.machine
index de39f23b180e..f67eb3d202c6 100644
--- a/arch/m68k/Kconfig.machine
+++ b/arch/m68k/Kconfig.machine
@@ -38,14 +38,6 @@ config MAC
 	  browse the documentation available at <http://www.mac.linux-m68k.org/>;
 	  otherwise say N.
 
-config APOLLO
-	bool "Apollo support"
-	depends on MMU
-	select LEGACY_TIMER_TICK
-	help
-	  Say Y here if you want to run Linux on an MC680x0-based Apollo
-	  Domain workstation such as the DN3500.
-
 config VME
 	bool "VME (Motorola and BVM) support"
 	depends on MMU
diff --git a/arch/m68k/apollo/Makefile b/arch/m68k/apollo/Makefile
deleted file mode 100644
index 676c74b26878..000000000000
--- a/arch/m68k/apollo/Makefile
+++ /dev/null
@@ -1,6 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0-only
-#
-# Makefile for Linux arch/m68k/apollo source directory
-#
-
-obj-y		:= config.o dn_ints.o
diff --git a/arch/m68k/apollo/apollo.h b/arch/m68k/apollo/apollo.h
deleted file mode 100644
index 1fe9d856df30..000000000000
--- a/arch/m68k/apollo/apollo.h
+++ /dev/null
@@ -1,4 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-
-/* dn_ints.c */
-void dn_init_IRQ(void);
diff --git a/arch/m68k/apollo/config.c b/arch/m68k/apollo/config.c
deleted file mode 100644
index e324c5f671de..000000000000
--- a/arch/m68k/apollo/config.c
+++ /dev/null
@@ -1,240 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#include <linux/init.h>
-#include <linux/types.h>
-#include <linux/kernel.h>
-#include <linux/mm.h>
-#include <linux/rtc.h>
-#include <linux/interrupt.h>
-
-#include <asm/setup.h>
-#include <asm/bootinfo.h>
-#include <asm/bootinfo-apollo.h>
-#include <asm/byteorder.h>
-#include <asm/apollohw.h>
-#include <asm/irq.h>
-#include <asm/machdep.h>
-#include <asm/config.h>
-
-#include "apollo.h"
-
-u_long sio01_physaddr;
-u_long sio23_physaddr;
-u_long rtc_physaddr;
-u_long pica_physaddr;
-u_long picb_physaddr;
-u_long cpuctrl_physaddr;
-u_long timer_physaddr;
-u_long apollo_model;
-
-extern void dn_sched_init(void);
-extern int dn_dummy_hwclk(int, struct rtc_time *);
-static void dn_dummy_reset(void);
-#ifdef CONFIG_HEARTBEAT
-static void dn_heartbeat(int on);
-#endif
-static irqreturn_t dn_timer_int(int irq,void *);
-static void dn_get_model(char *model);
-static const char *apollo_models[] = {
-	[APOLLO_DN3000-APOLLO_DN3000] = "DN3000 (Otter)",
-	[APOLLO_DN3010-APOLLO_DN3000] = "DN3010 (Otter)",
-	[APOLLO_DN3500-APOLLO_DN3000] = "DN3500 (Cougar II)",
-	[APOLLO_DN4000-APOLLO_DN3000] = "DN4000 (Mink)",
-	[APOLLO_DN4500-APOLLO_DN3000] = "DN4500 (Roadrunner)"
-};
-
-int __init apollo_parse_bootinfo(const struct bi_record *record)
-{
-	int unknown = 0;
-	const void *data = record->data;
-
-	switch (be16_to_cpu(record->tag)) {
-	case BI_APOLLO_MODEL:
-		apollo_model = be32_to_cpup(data);
-		break;
-
-	default:
-		 unknown=1;
-	}
-
-	return unknown;
-}
-
-static void __init dn_setup_model(void)
-{
-	pr_info("Apollo hardware found: [%s]\n",
-		apollo_models[apollo_model - APOLLO_DN3000]);
-
-	switch(apollo_model) {
-		case APOLLO_UNKNOWN:
-			panic("Unknown apollo model");
-			break;
-		case APOLLO_DN3000:
-		case APOLLO_DN3010:
-			sio01_physaddr=SAU8_SIO01_PHYSADDR;
-			rtc_physaddr=SAU8_RTC_PHYSADDR;
-			pica_physaddr=SAU8_PICA;
-			picb_physaddr=SAU8_PICB;
-			cpuctrl_physaddr=SAU8_CPUCTRL;
-			timer_physaddr=SAU8_TIMER;
-			break;
-		case APOLLO_DN4000:
-			sio01_physaddr=SAU7_SIO01_PHYSADDR;
-			sio23_physaddr=SAU7_SIO23_PHYSADDR;
-			rtc_physaddr=SAU7_RTC_PHYSADDR;
-			pica_physaddr=SAU7_PICA;
-			picb_physaddr=SAU7_PICB;
-			cpuctrl_physaddr=SAU7_CPUCTRL;
-			timer_physaddr=SAU7_TIMER;
-			break;
-		case APOLLO_DN4500:
-			panic("Apollo model not yet supported");
-			break;
-		case APOLLO_DN3500:
-			sio01_physaddr=SAU7_SIO01_PHYSADDR;
-			sio23_physaddr=SAU7_SIO23_PHYSADDR;
-			rtc_physaddr=SAU7_RTC_PHYSADDR;
-			pica_physaddr=SAU7_PICA;
-			picb_physaddr=SAU7_PICB;
-			cpuctrl_physaddr=SAU7_CPUCTRL;
-			timer_physaddr=SAU7_TIMER;
-			break;
-		default:
-			panic("Undefined apollo model");
-			break;
-	}
-
-
-}
-
-static void dn_serial_print(const char *str)
-{
-    while (*str) {
-        if (*str == '\n') {
-            sio01.rhrb_thrb = (unsigned char)'\r';
-            while (!(sio01.srb_csrb & 0x4))
-                ;
-        }
-        sio01.rhrb_thrb = (unsigned char)*str++;
-        while (!(sio01.srb_csrb & 0x4))
-            ;
-    }
-}
-
-void __init config_apollo(void)
-{
-	int i;
-
-	dn_setup_model();
-
-	mach_sched_init=dn_sched_init; /* */
-	mach_init_IRQ=dn_init_IRQ;
-	mach_hwclk           = dn_dummy_hwclk; /* */
-	mach_reset	     = dn_dummy_reset;  /* */
-#ifdef CONFIG_HEARTBEAT
-	mach_heartbeat = dn_heartbeat;
-#endif
-	mach_get_model       = dn_get_model;
-
-	cpuctrl=0xaa00;
-
-	/* clear DMA translation table */
-	for(i=0;i<0x400;i++)
-		addr_xlat_map[i]=0;
-
-}
-
-irqreturn_t dn_timer_int(int irq, void *dev_id)
-{
-	unsigned char *at = (unsigned char *)apollo_timer;
-
-	legacy_timer_tick(1);
-	timer_heartbeat();
-
-	READ_ONCE(*(at + 3));
-	READ_ONCE(*(at + 5));
-
-	return IRQ_HANDLED;
-}
-
-void dn_sched_init(void)
-{
-	/* program timer 1 */
-	*(volatile unsigned char *)(apollo_timer + 3) = 0x01;
-	*(volatile unsigned char *)(apollo_timer + 1) = 0x40;
-	*(volatile unsigned char *)(apollo_timer + 5) = 0x09;
-	*(volatile unsigned char *)(apollo_timer + 7) = 0xc4;
-
-	/* enable IRQ of PIC B */
-	*(volatile unsigned char *)(pica+1)&=(~8);
-
-#if 0
-	pr_info("*(0x10803) %02x\n",
-		*(volatile unsigned char *)(apollo_timer + 0x3));
-	pr_info("*(0x10803) %02x\n",
-		*(volatile unsigned char *)(apollo_timer + 0x3));
-#endif
-
-	if (request_irq(IRQ_APOLLO, dn_timer_int, 0, "time", NULL))
-		pr_err("Couldn't register timer interrupt\n");
-}
-
-int dn_dummy_hwclk(int op, struct rtc_time *t) {
-
-
-  if(!op) { /* read */
-    t->tm_sec=rtc->second;
-    t->tm_min=rtc->minute;
-    t->tm_hour=rtc->hours;
-    t->tm_mday=rtc->day_of_month;
-    t->tm_wday=rtc->day_of_week;
-    t->tm_mon = rtc->month - 1;
-    t->tm_year=rtc->year;
-    if (t->tm_year < 70)
-	t->tm_year += 100;
-  } else {
-    rtc->second=t->tm_sec;
-    rtc->minute=t->tm_min;
-    rtc->hours=t->tm_hour;
-    rtc->day_of_month=t->tm_mday;
-    if(t->tm_wday!=-1)
-      rtc->day_of_week=t->tm_wday;
-    rtc->month = t->tm_mon + 1;
-    rtc->year = t->tm_year % 100;
-  }
-
-  return 0;
-
-}
-
-static void dn_dummy_reset(void)
-{
-  dn_serial_print("The end !\n");
-
-  for(;;);
-
-}
-
-static void dn_get_model(char *model)
-{
-    strcpy(model, "Apollo ");
-    if (apollo_model >= APOLLO_DN3000 && apollo_model <= APOLLO_DN4500)
-        strcat(model, apollo_models[apollo_model - APOLLO_DN3000]);
-}
-
-#ifdef CONFIG_HEARTBEAT
-static int dn_cpuctrl=0xff00;
-
-static void dn_heartbeat(int on) {
-
-	if(on) {
-		dn_cpuctrl&=~0x100;
-		cpuctrl=dn_cpuctrl;
-	}
-	else {
-		dn_cpuctrl&=~0x100;
-		dn_cpuctrl|=0x100;
-		cpuctrl=dn_cpuctrl;
-	}
-}
-#endif
-
diff --git a/arch/m68k/apollo/dn_ints.c b/arch/m68k/apollo/dn_ints.c
deleted file mode 100644
index ba96a92f8f18..000000000000
--- a/arch/m68k/apollo/dn_ints.c
+++ /dev/null
@@ -1,50 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#include <linux/interrupt.h>
-#include <linux/irq.h>
-
-#include <asm/traps.h>
-#include <asm/apollohw.h>
-
-#include "apollo.h"
-
-static unsigned int apollo_irq_startup(struct irq_data *data)
-{
-	unsigned int irq = data->irq;
-
-	if (irq < 8)
-		*(volatile unsigned char *)(pica+1) &= ~(1 << irq);
-	else
-		*(volatile unsigned char *)(picb+1) &= ~(1 << (irq - 8));
-	return 0;
-}
-
-static void apollo_irq_shutdown(struct irq_data *data)
-{
-	unsigned int irq = data->irq;
-
-	if (irq < 8)
-		*(volatile unsigned char *)(pica+1) |= (1 << irq);
-	else
-		*(volatile unsigned char *)(picb+1) |= (1 << (irq - 8));
-}
-
-static void apollo_irq_eoi(struct irq_data *data)
-{
-	*(volatile unsigned char *)(pica) = 0x20;
-	*(volatile unsigned char *)(picb) = 0x20;
-}
-
-static struct irq_chip apollo_irq_chip = {
-	.name           = "apollo",
-	.irq_startup    = apollo_irq_startup,
-	.irq_shutdown   = apollo_irq_shutdown,
-	.irq_eoi	= apollo_irq_eoi,
-};
-
-
-void __init dn_init_IRQ(void)
-{
-	m68k_setup_user_interrupt(VEC_USER + 96, 16);
-	m68k_setup_irq_controller(&apollo_irq_chip, handle_fasteoi_irq,
-				  IRQ_APOLLO, 16);
-}
diff --git a/arch/m68k/configs/apollo_defconfig b/arch/m68k/configs/apollo_defconfig
deleted file mode 100644
index d9d1f3c4c70d..000000000000
--- a/arch/m68k/configs/apollo_defconfig
+++ /dev/null
@@ -1,595 +0,0 @@
-CONFIG_LOCALVERSION="-apollo"
-CONFIG_SYSVIPC=y
-CONFIG_POSIX_MQUEUE=y
-CONFIG_BSD_PROCESS_ACCT=y
-CONFIG_BSD_PROCESS_ACCT_V3=y
-CONFIG_LOG_BUF_SHIFT=16
-# CONFIG_UTS_NS is not set
-# CONFIG_IPC_NS is not set
-# CONFIG_PID_NS is not set
-# CONFIG_NET_NS is not set
-CONFIG_BLK_DEV_INITRD=y
-CONFIG_CC_OPTIMIZE_FOR_SIZE=y
-CONFIG_KEXEC=y
-CONFIG_BOOTINFO_PROC=y
-CONFIG_M68020=y
-CONFIG_M68030=y
-CONFIG_M68040=y
-CONFIG_M68060=y
-CONFIG_APOLLO=y
-CONFIG_HEARTBEAT=y
-CONFIG_PROC_HARDWARE=y
-CONFIG_MODULES=y
-CONFIG_MODULE_UNLOAD=y
-CONFIG_TRIM_UNUSED_KSYMS=y
-CONFIG_PARTITION_ADVANCED=y
-CONFIG_AMIGA_PARTITION=y
-CONFIG_ATARI_PARTITION=y
-CONFIG_MAC_PARTITION=y
-CONFIG_BSD_DISKLABEL=y
-CONFIG_MINIX_SUBPARTITION=y
-CONFIG_SOLARIS_X86_PARTITION=y
-CONFIG_UNIXWARE_DISKLABEL=y
-CONFIG_SUN_PARTITION=y
-# CONFIG_EFI_PARTITION is not set
-CONFIG_SYSV68_PARTITION=y
-CONFIG_MQ_IOSCHED_DEADLINE=m
-CONFIG_MQ_IOSCHED_KYBER=m
-CONFIG_IOSCHED_BFQ=m
-# CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
-CONFIG_BINFMT_MISC=m
-# CONFIG_COMPACTION is not set
-CONFIG_DMAPOOL_TEST=m
-CONFIG_USERFAULTFD=y
-CONFIG_NET=y
-CONFIG_PACKET=y
-CONFIG_PACKET_DIAG=m
-CONFIG_UNIX=y
-CONFIG_UNIX_DIAG=m
-CONFIG_TLS=m
-CONFIG_XFRM_MIGRATE=y
-CONFIG_NET_KEY=y
-CONFIG_XDP_SOCKETS=y
-CONFIG_XDP_SOCKETS_DIAG=m
-CONFIG_INET=y
-CONFIG_IP_PNP=y
-CONFIG_IP_PNP_DHCP=y
-CONFIG_IP_PNP_BOOTP=y
-CONFIG_IP_PNP_RARP=y
-CONFIG_NET_IPIP=m
-CONFIG_NET_IPGRE_DEMUX=m
-CONFIG_NET_IPGRE=m
-CONFIG_NET_IPVTI=m
-CONFIG_NET_FOU_IP_TUNNELS=y
-CONFIG_INET_AH=m
-CONFIG_INET_ESP=m
-CONFIG_INET_ESP_OFFLOAD=m
-CONFIG_INET_IPCOMP=m
-CONFIG_INET_DIAG=m
-CONFIG_INET_UDP_DIAG=m
-CONFIG_INET_RAW_DIAG=m
-CONFIG_IPV6=m
-CONFIG_IPV6_ROUTER_PREF=y
-CONFIG_INET6_AH=m
-CONFIG_INET6_ESP=m
-CONFIG_INET6_ESP_OFFLOAD=m
-CONFIG_INET6_IPCOMP=m
-CONFIG_IPV6_ILA=m
-CONFIG_IPV6_VTI=m
-CONFIG_IPV6_GRE=m
-CONFIG_NETFILTER=y
-CONFIG_NETFILTER_NETLINK_HOOK=m
-CONFIG_NF_CONNTRACK=m
-CONFIG_NF_CONNTRACK_ZONES=y
-CONFIG_NF_CONNTRACK_AMANDA=m
-CONFIG_NF_CONNTRACK_FTP=m
-CONFIG_NF_CONNTRACK_H323=m
-CONFIG_NF_CONNTRACK_IRC=m
-CONFIG_NF_CONNTRACK_NETBIOS_NS=m
-CONFIG_NF_CONNTRACK_SNMP=m
-CONFIG_NF_CONNTRACK_PPTP=m
-CONFIG_NF_CONNTRACK_SANE=m
-CONFIG_NF_CONNTRACK_SIP=m
-CONFIG_NF_CONNTRACK_TFTP=m
-CONFIG_NF_TABLES=m
-CONFIG_NF_TABLES_INET=y
-CONFIG_NF_TABLES_NETDEV=y
-CONFIG_NFT_NUMGEN=m
-CONFIG_NFT_CT=m
-CONFIG_NFT_FLOW_OFFLOAD=m
-CONFIG_NFT_CONNLIMIT=m
-CONFIG_NFT_LOG=m
-CONFIG_NFT_LIMIT=m
-CONFIG_NFT_MASQ=m
-CONFIG_NFT_REDIR=m
-CONFIG_NFT_NAT=m
-CONFIG_NFT_TUNNEL=m
-CONFIG_NFT_QUEUE=m
-CONFIG_NFT_QUOTA=m
-CONFIG_NFT_REJECT=m
-CONFIG_NFT_COMPAT=m
-CONFIG_NFT_HASH=m
-CONFIG_NFT_FIB_INET=m
-CONFIG_NFT_XFRM=m
-CONFIG_NFT_SOCKET=m
-CONFIG_NFT_OSF=m
-CONFIG_NFT_TPROXY=m
-CONFIG_NFT_SYNPROXY=m
-CONFIG_NFT_DUP_NETDEV=m
-CONFIG_NFT_FWD_NETDEV=m
-CONFIG_NFT_FIB_NETDEV=m
-CONFIG_NFT_REJECT_NETDEV=m
-CONFIG_NF_FLOW_TABLE_INET=m
-CONFIG_NF_FLOW_TABLE=m
-CONFIG_NETFILTER_XTABLES_LEGACY=y
-CONFIG_NETFILTER_XT_SET=m
-CONFIG_NETFILTER_XT_TARGET_CHECKSUM=m
-CONFIG_NETFILTER_XT_TARGET_CLASSIFY=m
-CONFIG_NETFILTER_XT_TARGET_CONNMARK=m
-CONFIG_NETFILTER_XT_TARGET_DSCP=m
-CONFIG_NETFILTER_XT_TARGET_HMARK=m
-CONFIG_NETFILTER_XT_TARGET_IDLETIMER=m
-CONFIG_NETFILTER_XT_TARGET_LOG=m
-CONFIG_NETFILTER_XT_TARGET_MARK=m
-CONFIG_NETFILTER_XT_TARGET_NFLOG=m
-CONFIG_NETFILTER_XT_TARGET_NFQUEUE=m
-CONFIG_NETFILTER_XT_TARGET_NOTRACK=m
-CONFIG_NETFILTER_XT_TARGET_TEE=m
-CONFIG_NETFILTER_XT_TARGET_TPROXY=m
-CONFIG_NETFILTER_XT_TARGET_TRACE=m
-CONFIG_NETFILTER_XT_TARGET_TCPMSS=m
-CONFIG_NETFILTER_XT_TARGET_TCPOPTSTRIP=m
-CONFIG_NETFILTER_XT_MATCH_ADDRTYPE=m
-CONFIG_NETFILTER_XT_MATCH_BPF=m
-CONFIG_NETFILTER_XT_MATCH_CLUSTER=m
-CONFIG_NETFILTER_XT_MATCH_COMMENT=m
-CONFIG_NETFILTER_XT_MATCH_CONNBYTES=m
-CONFIG_NETFILTER_XT_MATCH_CONNLABEL=m
-CONFIG_NETFILTER_XT_MATCH_CONNLIMIT=m
-CONFIG_NETFILTER_XT_MATCH_CONNMARK=m
-CONFIG_NETFILTER_XT_MATCH_CONNTRACK=m
-CONFIG_NETFILTER_XT_MATCH_DEVGROUP=m
-CONFIG_NETFILTER_XT_MATCH_DSCP=m
-CONFIG_NETFILTER_XT_MATCH_ESP=m
-CONFIG_NETFILTER_XT_MATCH_HASHLIMIT=m
-CONFIG_NETFILTER_XT_MATCH_HELPER=m
-CONFIG_NETFILTER_XT_MATCH_IPCOMP=m
-CONFIG_NETFILTER_XT_MATCH_IPRANGE=m
-CONFIG_NETFILTER_XT_MATCH_LENGTH=m
-CONFIG_NETFILTER_XT_MATCH_LIMIT=m
-CONFIG_NETFILTER_XT_MATCH_MAC=m
-CONFIG_NETFILTER_XT_MATCH_MARK=m
-CONFIG_NETFILTER_XT_MATCH_MULTIPORT=m
-CONFIG_NETFILTER_XT_MATCH_NFACCT=m
-CONFIG_NETFILTER_XT_MATCH_OSF=m
-CONFIG_NETFILTER_XT_MATCH_OWNER=m
-CONFIG_NETFILTER_XT_MATCH_POLICY=m
-CONFIG_NETFILTER_XT_MATCH_PKTTYPE=m
-CONFIG_NETFILTER_XT_MATCH_QUOTA=m
-CONFIG_NETFILTER_XT_MATCH_RATEEST=m
-CONFIG_NETFILTER_XT_MATCH_REALM=m
-CONFIG_NETFILTER_XT_MATCH_RECENT=m
-CONFIG_NETFILTER_XT_MATCH_SOCKET=m
-CONFIG_NETFILTER_XT_MATCH_STATE=m
-CONFIG_NETFILTER_XT_MATCH_STATISTIC=m
-CONFIG_NETFILTER_XT_MATCH_STRING=m
-CONFIG_NETFILTER_XT_MATCH_TCPMSS=m
-CONFIG_NETFILTER_XT_MATCH_TIME=m
-CONFIG_NETFILTER_XT_MATCH_U32=m
-CONFIG_IP_SET=m
-CONFIG_IP_SET_BITMAP_IP=m
-CONFIG_IP_SET_BITMAP_IPMAC=m
-CONFIG_IP_SET_BITMAP_PORT=m
-CONFIG_IP_SET_HASH_IP=m
-CONFIG_IP_SET_HASH_IPMARK=m
-CONFIG_IP_SET_HASH_IPPORT=m
-CONFIG_IP_SET_HASH_IPPORTIP=m
-CONFIG_IP_SET_HASH_IPPORTNET=m
-CONFIG_IP_SET_HASH_IPMAC=m
-CONFIG_IP_SET_HASH_MAC=m
-CONFIG_IP_SET_HASH_NETPORTNET=m
-CONFIG_IP_SET_HASH_NET=m
-CONFIG_IP_SET_HASH_NETNET=m
-CONFIG_IP_SET_HASH_NETPORT=m
-CONFIG_IP_SET_HASH_NETIFACE=m
-CONFIG_IP_SET_LIST_SET=m
-CONFIG_NFT_DUP_IPV4=m
-CONFIG_NFT_FIB_IPV4=m
-CONFIG_NF_TABLES_ARP=y
-CONFIG_NF_LOG_ARP=m
-CONFIG_NF_LOG_IPV4=m
-CONFIG_IP_NF_IPTABLES=m
-CONFIG_IP_NF_MATCH_AH=m
-CONFIG_IP_NF_MATCH_ECN=m
-CONFIG_IP_NF_MATCH_RPFILTER=m
-CONFIG_IP_NF_MATCH_TTL=m
-CONFIG_IP_NF_TARGET_REJECT=m
-CONFIG_IP_NF_TARGET_SYNPROXY=m
-CONFIG_IP_NF_NAT=m
-CONFIG_IP_NF_TARGET_MASQUERADE=m
-CONFIG_IP_NF_TARGET_NETMAP=m
-CONFIG_IP_NF_TARGET_REDIRECT=m
-CONFIG_IP_NF_TARGET_ECN=m
-CONFIG_IP_NF_TARGET_TTL=m
-CONFIG_IP_NF_RAW=m
-CONFIG_IP_NF_ARPFILTER=m
-CONFIG_IP_NF_ARP_MANGLE=m
-CONFIG_NFT_DUP_IPV6=m
-CONFIG_NFT_FIB_IPV6=m
-CONFIG_IP6_NF_IPTABLES=m
-CONFIG_IP6_NF_MATCH_AH=m
-CONFIG_IP6_NF_MATCH_EUI64=m
-CONFIG_IP6_NF_MATCH_FRAG=m
-CONFIG_IP6_NF_MATCH_OPTS=m
-CONFIG_IP6_NF_MATCH_HL=m
-CONFIG_IP6_NF_MATCH_IPV6HEADER=m
-CONFIG_IP6_NF_MATCH_MH=m
-CONFIG_IP6_NF_MATCH_RPFILTER=m
-CONFIG_IP6_NF_MATCH_RT=m
-CONFIG_IP6_NF_MATCH_SRH=m
-CONFIG_IP6_NF_TARGET_HL=m
-CONFIG_IP6_NF_TARGET_REJECT=m
-CONFIG_IP6_NF_TARGET_SYNPROXY=m
-CONFIG_IP6_NF_RAW=m
-CONFIG_IP6_NF_NAT=m
-CONFIG_IP6_NF_TARGET_MASQUERADE=m
-CONFIG_IP6_NF_TARGET_NPT=m
-CONFIG_NF_TABLES_BRIDGE=m
-CONFIG_NFT_BRIDGE_META=m
-CONFIG_NFT_BRIDGE_REJECT=m
-CONFIG_NF_CONNTRACK_BRIDGE=m
-CONFIG_BRIDGE_NF_EBTABLES_LEGACY=m
-CONFIG_BRIDGE_NF_EBTABLES=m
-CONFIG_BRIDGE_EBT_BROUTE=m
-CONFIG_BRIDGE_EBT_T_FILTER=m
-CONFIG_BRIDGE_EBT_T_NAT=m
-CONFIG_BRIDGE_EBT_802_3=m
-CONFIG_BRIDGE_EBT_AMONG=m
-CONFIG_BRIDGE_EBT_ARP=m
-CONFIG_BRIDGE_EBT_IP=m
-CONFIG_BRIDGE_EBT_IP6=m
-CONFIG_BRIDGE_EBT_LIMIT=m
-CONFIG_BRIDGE_EBT_MARK=m
-CONFIG_BRIDGE_EBT_PKTTYPE=m
-CONFIG_BRIDGE_EBT_STP=m
-CONFIG_BRIDGE_EBT_VLAN=m
-CONFIG_BRIDGE_EBT_ARPREPLY=m
-CONFIG_BRIDGE_EBT_DNAT=m
-CONFIG_BRIDGE_EBT_MARK_T=m
-CONFIG_BRIDGE_EBT_REDIRECT=m
-CONFIG_BRIDGE_EBT_SNAT=m
-CONFIG_BRIDGE_EBT_LOG=m
-CONFIG_BRIDGE_EBT_NFLOG=m
-CONFIG_IP_SCTP=m
-CONFIG_RDS=m
-CONFIG_RDS_TCP=m
-CONFIG_L2TP=m
-CONFIG_BRIDGE=m
-CONFIG_ATALK=m
-CONFIG_6LOWPAN=m
-CONFIG_6LOWPAN_GHC_EXT_HDR_HOP=m
-CONFIG_6LOWPAN_GHC_UDP=m
-CONFIG_6LOWPAN_GHC_ICMPV6=m
-CONFIG_6LOWPAN_GHC_EXT_HDR_DEST=m
-CONFIG_6LOWPAN_GHC_EXT_HDR_FRAG=m
-CONFIG_6LOWPAN_GHC_EXT_HDR_ROUTE=m
-CONFIG_DNS_RESOLVER=y
-CONFIG_BATMAN_ADV=m
-# CONFIG_BATMAN_ADV_BATMAN_V is not set
-CONFIG_NETLINK_DIAG=m
-CONFIG_MPLS=y
-CONFIG_NET_MPLS_GSO=m
-CONFIG_MPLS_ROUTING=m
-CONFIG_MPLS_IPTUNNEL=m
-CONFIG_NET_NSH=m
-CONFIG_AF_KCM=m
-# CONFIG_WIRELESS is not set
-CONFIG_PSAMPLE=m
-CONFIG_NET_IFE=m
-CONFIG_DEVTMPFS=y
-CONFIG_DEVTMPFS_MOUNT=y
-CONFIG_TEST_ASYNC_DRIVER_PROBE=m
-CONFIG_CONNECTOR=m
-CONFIG_ZRAM=m
-CONFIG_BLK_DEV_LOOP=y
-CONFIG_BLK_DEV_DRBD=m
-CONFIG_BLK_DEV_NBD=m
-CONFIG_BLK_DEV_RAM=y
-CONFIG_ATA_OVER_ETH=m
-CONFIG_DUMMY_IRQ=m
-CONFIG_RAID_ATTRS=m
-CONFIG_SCSI=y
-CONFIG_BLK_DEV_SD=y
-CONFIG_CHR_DEV_ST=m
-CONFIG_BLK_DEV_SR=y
-CONFIG_CHR_DEV_SG=m
-CONFIG_SCSI_CONSTANTS=y
-CONFIG_SCSI_SAS_ATTRS=m
-CONFIG_ISCSI_TCP=m
-CONFIG_ISCSI_BOOT_SYSFS=m
-CONFIG_MD=y
-CONFIG_MD_LINEAR=m
-CONFIG_BLK_DEV_DM=m
-CONFIG_DM_UNSTRIPED=m
-CONFIG_DM_CRYPT=m
-CONFIG_DM_SNAPSHOT=m
-CONFIG_DM_THIN_PROVISIONING=m
-CONFIG_DM_WRITECACHE=m
-CONFIG_DM_ERA=m
-CONFIG_DM_CLONE=m
-CONFIG_DM_MIRROR=m
-CONFIG_DM_RAID=m
-CONFIG_DM_ZERO=m
-CONFIG_DM_MULTIPATH=m
-CONFIG_DM_UEVENT=y
-CONFIG_DM_LOG_WRITES=m
-CONFIG_DM_INTEGRITY=m
-CONFIG_TARGET_CORE=m
-CONFIG_TCM_IBLOCK=m
-CONFIG_TCM_FILEIO=m
-CONFIG_TCM_PSCSI=m
-CONFIG_NETDEVICES=y
-CONFIG_DUMMY=m
-CONFIG_WIREGUARD=m
-CONFIG_OVPN=m
-CONFIG_EQUALIZER=m
-CONFIG_NET_TEAM=m
-CONFIG_NET_TEAM_MODE_BROADCAST=m
-CONFIG_NET_TEAM_MODE_ROUNDROBIN=m
-CONFIG_NET_TEAM_MODE_RANDOM=m
-CONFIG_NET_TEAM_MODE_ACTIVEBACKUP=m
-CONFIG_NET_TEAM_MODE_LOADBALANCE=m
-CONFIG_MACVLAN=m
-CONFIG_MACVTAP=m
-CONFIG_IPVLAN=m
-CONFIG_IPVTAP=m
-CONFIG_VXLAN=m
-CONFIG_GENEVE=m
-CONFIG_BAREUDP=m
-CONFIG_GTP=m
-CONFIG_PFCP=m
-CONFIG_MACSEC=m
-CONFIG_NETCONSOLE=m
-CONFIG_NETCONSOLE_DYNAMIC=y
-CONFIG_TUN=m
-CONFIG_VETH=m
-CONFIG_PPP=m
-CONFIG_PPP_BSDCOMP=m
-CONFIG_PPP_DEFLATE=m
-CONFIG_PPP_FILTER=y
-CONFIG_PPP_MPPE=m
-CONFIG_PPPOE=m
-CONFIG_PPTP=m
-CONFIG_PPPOL2TP=m
-CONFIG_PPP_ASYNC=m
-CONFIG_PPP_SYNC_TTY=m
-CONFIG_SLIP=m
-CONFIG_SLIP_COMPRESSED=y
-CONFIG_SLIP_SMART=y
-CONFIG_SLIP_MODE_SLIP6=y
-# CONFIG_WLAN is not set
-CONFIG_INPUT_EVDEV=m
-# CONFIG_KEYBOARD_ATKBD is not set
-# CONFIG_MOUSE_PS2 is not set
-CONFIG_MOUSE_SERIAL=m
-CONFIG_SERIO=m
-CONFIG_USERIO=m
-# CONFIG_LEGACY_PTYS is not set
-# CONFIG_HW_RANDOM is not set
-CONFIG_NTP_PPS=y
-CONFIG_PPS_CLIENT_LDISC=m
-CONFIG_PTP_1588_CLOCK=m
-# CONFIG_HWMON is not set
-CONFIG_FB=y
-CONFIG_FRAMEBUFFER_CONSOLE=y
-CONFIG_FRAMEBUFFER_CONSOLE_LEGACY_ACCELERATION=y
-CONFIG_LOGO=y
-# CONFIG_LOGO_LINUX_VGA16 is not set
-# CONFIG_LOGO_LINUX_CLUT224 is not set
-CONFIG_HID=m
-CONFIG_HIDRAW=y
-CONFIG_UHID=m
-# CONFIG_HID_GENERIC is not set
-# CONFIG_HID_ITE is not set
-# CONFIG_HID_REDRAGON is not set
-# CONFIG_USB_SUPPORT is not set
-CONFIG_RTC_CLASS=y
-# CONFIG_RTC_NVMEM is not set
-CONFIG_RTC_DRV_GENERIC=m
-# CONFIG_VIRTIO_MENU is not set
-# CONFIG_VHOST_MENU is not set
-# CONFIG_IOMMU_SUPPORT is not set
-CONFIG_DAX=m
-CONFIG_EXT4_FS=y
-CONFIG_JFS_FS=m
-CONFIG_XFS_FS=m
-CONFIG_OCFS2_FS=m
-# CONFIG_OCFS2_DEBUG_MASKLOG is not set
-CONFIG_BTRFS_FS=m
-CONFIG_FANOTIFY=y
-CONFIG_QUOTA_NETLINK_INTERFACE=y
-CONFIG_AUTOFS_FS=m
-CONFIG_FUSE_FS=m
-CONFIG_CUSE=m
-CONFIG_OVERLAY_FS=m
-CONFIG_ISO9660_FS=y
-CONFIG_JOLIET=y
-CONFIG_ZISOFS=y
-CONFIG_UDF_FS=m
-CONFIG_MSDOS_FS=m
-CONFIG_VFAT_FS=m
-CONFIG_EXFAT_FS=m
-CONFIG_NTFS3_FS=m
-CONFIG_NTFS3_LZX_XPRESS=y
-CONFIG_PROC_KCORE=y
-CONFIG_PROC_CHILDREN=y
-CONFIG_TMPFS=y
-CONFIG_ORANGEFS_FS=m
-CONFIG_AFFS_FS=m
-CONFIG_ECRYPT_FS=m
-CONFIG_ECRYPT_FS_MESSAGING=y
-CONFIG_HFS_FS=m
-CONFIG_HFSPLUS_FS=m
-CONFIG_CRAMFS=m
-CONFIG_SQUASHFS=m
-CONFIG_SQUASHFS_LZ4=y
-CONFIG_SQUASHFS_LZO=y
-CONFIG_MINIX_FS=m
-CONFIG_OMFS_FS=m
-CONFIG_HPFS_FS=m
-CONFIG_QNX4FS_FS=m
-CONFIG_QNX6FS_FS=m
-CONFIG_UFS_FS=m
-CONFIG_EROFS_FS=m
-CONFIG_NFS_FS=y
-CONFIG_NFS_V4=m
-CONFIG_NFS_SWAP=y
-CONFIG_ROOT_NFS=y
-CONFIG_NFSD=m
-CONFIG_RPCSEC_GSS_KRB5=m
-CONFIG_CIFS=m
-# CONFIG_CIFS_STATS2 is not set
-# CONFIG_CIFS_DEBUG is not set
-CONFIG_CODA_FS=m
-CONFIG_NLS_CODEPAGE_437=y
-CONFIG_NLS_CODEPAGE_737=m
-CONFIG_NLS_CODEPAGE_775=m
-CONFIG_NLS_CODEPAGE_850=m
-CONFIG_NLS_CODEPAGE_852=m
-CONFIG_NLS_CODEPAGE_855=m
-CONFIG_NLS_CODEPAGE_857=m
-CONFIG_NLS_CODEPAGE_860=m
-CONFIG_NLS_CODEPAGE_861=m
-CONFIG_NLS_CODEPAGE_862=m
-CONFIG_NLS_CODEPAGE_863=m
-CONFIG_NLS_CODEPAGE_864=m
-CONFIG_NLS_CODEPAGE_865=m
-CONFIG_NLS_CODEPAGE_866=m
-CONFIG_NLS_CODEPAGE_869=m
-CONFIG_NLS_CODEPAGE_936=m
-CONFIG_NLS_CODEPAGE_950=m
-CONFIG_NLS_CODEPAGE_932=m
-CONFIG_NLS_CODEPAGE_949=m
-CONFIG_NLS_CODEPAGE_874=m
-CONFIG_NLS_ISO8859_8=m
-CONFIG_NLS_CODEPAGE_1250=m
-CONFIG_NLS_CODEPAGE_1251=m
-CONFIG_NLS_ASCII=m
-CONFIG_NLS_ISO8859_1=y
-CONFIG_NLS_ISO8859_2=m
-CONFIG_NLS_ISO8859_3=m
-CONFIG_NLS_ISO8859_4=m
-CONFIG_NLS_ISO8859_5=m
-CONFIG_NLS_ISO8859_6=m
-CONFIG_NLS_ISO8859_7=m
-CONFIG_NLS_ISO8859_9=m
-CONFIG_NLS_ISO8859_13=m
-CONFIG_NLS_ISO8859_14=m
-CONFIG_NLS_ISO8859_15=m
-CONFIG_NLS_KOI8_R=m
-CONFIG_NLS_KOI8_U=m
-CONFIG_NLS_MAC_ROMAN=m
-CONFIG_NLS_MAC_CELTIC=m
-CONFIG_NLS_MAC_CENTEURO=m
-CONFIG_NLS_MAC_CROATIAN=m
-CONFIG_NLS_MAC_CYRILLIC=m
-CONFIG_NLS_MAC_GAELIC=m
-CONFIG_NLS_MAC_GREEK=m
-CONFIG_NLS_MAC_ICELAND=m
-CONFIG_NLS_MAC_INUIT=m
-CONFIG_NLS_MAC_ROMANIAN=m
-CONFIG_NLS_MAC_TURKISH=m
-CONFIG_DLM=m
-CONFIG_ENCRYPTED_KEYS=m
-CONFIG_HARDENED_USERCOPY=y
-CONFIG_CRYPTO_USER=m
-CONFIG_CRYPTO_NULL=m
-CONFIG_CRYPTO_CRYPTD=m
-CONFIG_CRYPTO_BENCHMARK=m
-CONFIG_CRYPTO_RSA=m
-CONFIG_CRYPTO_DH=m
-CONFIG_CRYPTO_ECDH=m
-CONFIG_CRYPTO_ECDSA=m
-CONFIG_CRYPTO_ECRDSA=m
-CONFIG_CRYPTO_AES=y
-CONFIG_CRYPTO_AES_TI=m
-CONFIG_CRYPTO_ANUBIS=m
-CONFIG_CRYPTO_ARIA=m
-CONFIG_CRYPTO_BLOWFISH=m
-CONFIG_CRYPTO_CAMELLIA=m
-CONFIG_CRYPTO_CAST5=m
-CONFIG_CRYPTO_CAST6=m
-CONFIG_CRYPTO_DES=m
-CONFIG_CRYPTO_FCRYPT=m
-CONFIG_CRYPTO_KHAZAD=m
-CONFIG_CRYPTO_SEED=m
-CONFIG_CRYPTO_SERPENT=m
-CONFIG_CRYPTO_SM4_GENERIC=m
-CONFIG_CRYPTO_TEA=m
-CONFIG_CRYPTO_TWOFISH=m
-CONFIG_CRYPTO_ADIANTUM=m
-CONFIG_CRYPTO_ARC4=m
-CONFIG_CRYPTO_CTS=m
-CONFIG_CRYPTO_HCTR2=m
-CONFIG_CRYPTO_LRW=m
-CONFIG_CRYPTO_PCBC=m
-CONFIG_CRYPTO_XTS=m
-CONFIG_CRYPTO_AEGIS128=m
-CONFIG_CRYPTO_MD4=m
-CONFIG_CRYPTO_MICHAEL_MIC=m
-CONFIG_CRYPTO_RMD160=m
-CONFIG_CRYPTO_SHA1=m
-CONFIG_CRYPTO_SM3_GENERIC=m
-CONFIG_CRYPTO_WP512=m
-CONFIG_CRYPTO_XCBC=m
-CONFIG_CRYPTO_LZO=m
-CONFIG_CRYPTO_842=m
-CONFIG_CRYPTO_LZ4=m
-CONFIG_CRYPTO_LZ4HC=m
-CONFIG_CRYPTO_ZSTD=m
-CONFIG_CRYPTO_DRBG_HASH=y
-CONFIG_CRYPTO_DRBG_CTR=y
-CONFIG_CRYPTO_USER_API_HASH=m
-CONFIG_CRYPTO_USER_API_SKCIPHER=m
-CONFIG_CRYPTO_USER_API_RNG=m
-CONFIG_CRYPTO_USER_API_AEAD=m
-# CONFIG_CRYPTO_HW is not set
-CONFIG_PRIME_NUMBERS=m
-CONFIG_CRC_BENCHMARK=y
-CONFIG_XZ_DEC_TEST=m
-CONFIG_GLOB_SELFTEST=m
-# CONFIG_SECTION_MISMATCH_WARN_ONLY is not set
-CONFIG_MAGIC_SYSRQ=y
-CONFIG_TEST_LOCKUP=m
-CONFIG_WW_MUTEX_SELFTEST=m
-CONFIG_EARLY_PRINTK=y
-CONFIG_KUNIT=m
-CONFIG_KUNIT_ALL_TESTS=m
-CONFIG_TEST_DHRY=m
-CONFIG_TEST_MIN_HEAP=m
-CONFIG_TEST_DIV64=m
-CONFIG_TEST_MULDIV64=m
-CONFIG_REED_SOLOMON_TEST=m
-CONFIG_ATOMIC64_SELFTEST=m
-CONFIG_ASYNC_RAID6_TEST=m
-CONFIG_TEST_HEXDUMP=m
-CONFIG_TEST_KSTRTOX=m
-CONFIG_TEST_BITMAP=m
-CONFIG_TEST_UUID=m
-CONFIG_TEST_XARRAY=m
-CONFIG_TEST_MAPLE_TREE=m
-CONFIG_TEST_RHASHTABLE=m
-CONFIG_TEST_IDA=m
-CONFIG_TEST_BITOPS=m
-CONFIG_TEST_VMALLOC=m
-CONFIG_TEST_BPF=m
-CONFIG_FIND_BIT_BENCHMARK=m
-CONFIG_TEST_FIRMWARE=m
-CONFIG_TEST_SYSCTL=m
-CONFIG_LINEAR_RANGES_TEST=m
-CONFIG_TEST_UDELAY=m
-CONFIG_TEST_STATIC_KEYS=m
-CONFIG_TEST_KMOD=m
-CONFIG_TEST_MEMCAT_P=m
-CONFIG_TEST_MEMINIT=m
-CONFIG_TEST_FREE_PAGES=m
diff --git a/arch/m68k/configs/multi_defconfig b/arch/m68k/configs/multi_defconfig
index 74f0a1f6d871..b06de259c697 100644
--- a/arch/m68k/configs/multi_defconfig
+++ b/arch/m68k/configs/multi_defconfig
@@ -19,7 +19,6 @@ CONFIG_M68KFPU_EMU=y
 CONFIG_AMIGA=y
 CONFIG_ATARI=y
 CONFIG_MAC=y
-CONFIG_APOLLO=y
 CONFIG_VME=y
 CONFIG_MVME147=y
 CONFIG_MVME16x=y
diff --git a/arch/m68k/include/asm/apollohw.h b/arch/m68k/include/asm/apollohw.h
deleted file mode 100644
index 52066f3b8658..000000000000
--- a/arch/m68k/include/asm/apollohw.h
+++ /dev/null
@@ -1,90 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/* apollohw.h : some structures to access apollo HW */
-
-#ifndef _ASMm68k_APOLLOHW_H_
-#define _ASMm68k_APOLLOHW_H_
-
-#include <linux/types.h>
-
-#include <asm/bootinfo-apollo.h>
-
-
-extern u_long apollo_model;
-
-
-/*
-   see scn2681 data sheet for more info.
-   member names are read_write.
-*/
-
-#define DECLARE_2681_FIELD(x) unsigned char x; unsigned char dummy##x
-
-struct SCN2681 {
-
-	DECLARE_2681_FIELD(mra);
-	DECLARE_2681_FIELD(sra_csra);
-	DECLARE_2681_FIELD(BRGtest_cra);
-	DECLARE_2681_FIELD(rhra_thra);
-	DECLARE_2681_FIELD(ipcr_acr);
-	DECLARE_2681_FIELD(isr_imr);
-	DECLARE_2681_FIELD(ctu_ctur);
-	DECLARE_2681_FIELD(ctl_ctlr);
-	DECLARE_2681_FIELD(mrb);
-	DECLARE_2681_FIELD(srb_csrb);
-	DECLARE_2681_FIELD(tst_crb);
-	DECLARE_2681_FIELD(rhrb_thrb);
-	DECLARE_2681_FIELD(reserved);
-	DECLARE_2681_FIELD(ip_opcr);
-	DECLARE_2681_FIELD(startCnt_setOutBit);
-	DECLARE_2681_FIELD(stopCnt_resetOutBit);
-
-};
-
-struct mc146818 {
-        unsigned char second, alarm_second;
-        unsigned char minute, alarm_minute;
-        unsigned char hours, alarm_hours;
-        unsigned char day_of_week, day_of_month;
-        unsigned char month, year;
-};
-
-
-#define IO_BASE 0x80000000
-
-extern u_long sio01_physaddr;
-extern u_long sio23_physaddr;
-extern u_long rtc_physaddr;
-extern u_long pica_physaddr;
-extern u_long picb_physaddr;
-extern u_long cpuctrl_physaddr;
-extern u_long timer_physaddr;
-
-#define SAU7_SIO01_PHYSADDR 0x10400
-#define SAU7_SIO23_PHYSADDR 0x10500
-#define SAU7_RTC_PHYSADDR 0x10900
-#define SAU7_PICA 0x11000
-#define SAU7_PICB 0x11100
-#define SAU7_CPUCTRL 0x10100
-#define SAU7_TIMER 0x010800
-
-#define SAU8_SIO01_PHYSADDR 0x8400
-#define SAU8_RTC_PHYSADDR 0x8900
-#define SAU8_PICA 0x9400
-#define SAU8_PICB 0x9500
-#define SAU8_CPUCTRL 0x8100
-#define SAU8_TIMER 0x8800
-
-#define sio01 ((*(volatile struct SCN2681 *)(IO_BASE + sio01_physaddr)))
-#define sio23 ((*(volatile struct SCN2681 *)(IO_BASE + sio23_physaddr)))
-#define rtc (((volatile struct mc146818 *)(IO_BASE + rtc_physaddr)))
-#define cpuctrl (*(volatile unsigned int *)(IO_BASE + cpuctrl_physaddr))
-#define pica (IO_BASE + pica_physaddr)
-#define picb (IO_BASE + picb_physaddr)
-#define apollo_timer (IO_BASE + timer_physaddr)
-#define addr_xlat_map ((unsigned short *)(IO_BASE + 0x17000))
-
-#define isaIO2mem(x) (((((x) & 0x3f8)  << 7) | (((x) & 0xfc00) >> 6) | ((x) & 0x7)) + 0x40000 + IO_BASE)
-
-#define IRQ_APOLLO	IRQ_USER
-
-#endif
diff --git a/arch/m68k/include/asm/config.h b/arch/m68k/include/asm/config.h
index 9bb888ab5009..9c73a73a7b3c 100644
--- a/arch/m68k/include/asm/config.h
+++ b/arch/m68k/include/asm/config.h
@@ -9,7 +9,6 @@
 #define _M68K_CONFIG_H
 
 extern int amiga_parse_bootinfo(const struct bi_record *record);
-extern int apollo_parse_bootinfo(const struct bi_record *record);
 extern int atari_parse_bootinfo(const struct bi_record *record);
 extern int bvme6000_parse_bootinfo(const struct bi_record *record);
 extern int hp300_parse_bootinfo(const struct bi_record *record);
@@ -20,7 +19,6 @@ extern int q40_parse_bootinfo(const struct bi_record *record);
 extern int virt_parse_bootinfo(const struct bi_record *record);
 
 extern void config_amiga(void);
-extern void config_apollo(void);
 extern void config_atari(void);
 extern void config_bvme6000(void);
 extern void config_hp300(void);
diff --git a/arch/m68k/include/asm/irq.h b/arch/m68k/include/asm/irq.h
index 2263e92d418a..51cd970b0778 100644
--- a/arch/m68k/include/asm/irq.h
+++ b/arch/m68k/include/asm/irq.h
@@ -26,8 +26,6 @@
 #define NR_IRQS	43
 #elif defined(CONFIG_AMIGA) || !defined(CONFIG_MMU)
 #define NR_IRQS	32
-#elif defined(CONFIG_APOLLO)
-#define NR_IRQS	24
 #else /* CONFIG_HP300 etc. */
 #define NR_IRQS	8
 #endif
diff --git a/arch/m68k/include/asm/setup.h b/arch/m68k/include/asm/setup.h
index e4ec169f5c7d..1719d0ee59ea 100644
--- a/arch/m68k/include/asm/setup.h
+++ b/arch/m68k/include/asm/setup.h
@@ -34,7 +34,7 @@ extern unsigned long m68k_machtype;
 
 #if !defined(CONFIG_AMIGA)
 #  define MACH_IS_AMIGA (0)
-#elif defined(CONFIG_ATARI) || defined(CONFIG_MAC) || defined(CONFIG_APOLLO) \
+#elif defined(CONFIG_ATARI) || defined(CONFIG_MAC)                           \
 	|| defined(CONFIG_MVME16x) || defined(CONFIG_BVME6000)               \
 	|| defined(CONFIG_HP300) || defined(CONFIG_Q40)                      \
 	|| defined(CONFIG_SUN3X) || defined(CONFIG_MVME147)                  \
@@ -48,7 +48,7 @@ extern unsigned long m68k_machtype;
 
 #if !defined(CONFIG_ATARI)
 #  define MACH_IS_ATARI (0)
-#elif defined(CONFIG_AMIGA) || defined(CONFIG_MAC) || defined(CONFIG_APOLLO) \
+#elif defined(CONFIG_AMIGA) || defined(CONFIG_MAC)                           \
 	|| defined(CONFIG_MVME16x) || defined(CONFIG_BVME6000)               \
 	|| defined(CONFIG_HP300) || defined(CONFIG_Q40)                      \
 	|| defined(CONFIG_SUN3X) || defined(CONFIG_MVME147)                  \
@@ -62,7 +62,7 @@ extern unsigned long m68k_machtype;
 
 #if !defined(CONFIG_MAC)
 #  define MACH_IS_MAC (0)
-#elif defined(CONFIG_AMIGA) || defined(CONFIG_ATARI) || defined(CONFIG_APOLLO) \
+#elif defined(CONFIG_AMIGA) || defined(CONFIG_ATARI)                           \
 	|| defined(CONFIG_MVME16x) || defined(CONFIG_BVME6000)                 \
 	|| defined(CONFIG_HP300) || defined(CONFIG_Q40)                        \
 	|| defined(CONFIG_SUN3X) || defined(CONFIG_MVME147)                    \
@@ -82,24 +82,10 @@ extern unsigned long m68k_machtype;
 #define MACH_IS_SUN3 (0)
 #endif
 
-#if !defined (CONFIG_APOLLO)
-#  define MACH_IS_APOLLO (0)
-#elif defined(CONFIG_AMIGA) || defined(CONFIG_MAC) || defined(CONFIG_ATARI) \
-	|| defined(CONFIG_MVME16x) || defined(CONFIG_BVME6000)              \
-	|| defined(CONFIG_HP300) || defined(CONFIG_Q40)                     \
-	|| defined(CONFIG_SUN3X) || defined(CONFIG_MVME147)                 \
-	|| defined(CONFIG_VIRT)
-#  define MACH_IS_APOLLO (m68k_machtype == MACH_APOLLO)
-#else
-#  define MACH_APOLLO_ONLY
-#  define MACH_IS_APOLLO (1)
-#  define MACH_TYPE (MACH_APOLLO)
-#endif
-
 #if !defined (CONFIG_MVME147)
 #  define MACH_IS_MVME147 (0)
 #elif defined(CONFIG_AMIGA) || defined(CONFIG_MAC) || defined(CONFIG_ATARI) \
-	|| defined(CONFIG_APOLLO) || defined(CONFIG_BVME6000)               \
+	|| defined(CONFIG_BVME6000)                                         \
 	|| defined(CONFIG_HP300) || defined(CONFIG_Q40)                     \
 	|| defined(CONFIG_SUN3X) || defined(CONFIG_MVME16x)                 \
 	|| defined(CONFIG_VIRT)
@@ -113,7 +99,7 @@ extern unsigned long m68k_machtype;
 #if !defined (CONFIG_MVME16x)
 #  define MACH_IS_MVME16x (0)
 #elif defined(CONFIG_AMIGA) || defined(CONFIG_MAC) || defined(CONFIG_ATARI) \
-	|| defined(CONFIG_APOLLO) || defined(CONFIG_BVME6000)               \
+	|| defined(CONFIG_BVME6000)                                         \
 	|| defined(CONFIG_HP300) || defined(CONFIG_Q40)                     \
 	|| defined(CONFIG_SUN3X) || defined(CONFIG_MVME147)                 \
 	|| defined(CONFIG_VIRT)
@@ -127,7 +113,7 @@ extern unsigned long m68k_machtype;
 #if !defined (CONFIG_BVME6000)
 #  define MACH_IS_BVME6000 (0)
 #elif defined(CONFIG_AMIGA) || defined(CONFIG_MAC) || defined(CONFIG_ATARI) \
-	|| defined(CONFIG_APOLLO) || defined(CONFIG_MVME16x)                \
+	|| defined(CONFIG_MVME16x)                                          \
 	|| defined(CONFIG_HP300) || defined(CONFIG_Q40)                     \
 	|| defined(CONFIG_SUN3X) || defined(CONFIG_MVME147)                 \
 	|| defined(CONFIG_VIRT)
@@ -141,7 +127,7 @@ extern unsigned long m68k_machtype;
 #if !defined (CONFIG_HP300)
 #  define MACH_IS_HP300 (0)
 #elif defined(CONFIG_AMIGA) || defined(CONFIG_MAC) || defined(CONFIG_ATARI) \
-	|| defined(CONFIG_APOLLO) || defined(CONFIG_MVME16x) \
+	|| defined(CONFIG_MVME16x) \
 	|| defined(CONFIG_BVME6000) || defined(CONFIG_Q40) \
 	|| defined(CONFIG_SUN3X) || defined(CONFIG_MVME147) \
 	|| defined(CONFIG_VIRT)
@@ -169,7 +155,7 @@ extern unsigned long m68k_machtype;
 #if !defined (CONFIG_SUN3X)
 #  define MACH_IS_SUN3X (0)
 #elif defined(CONFIG_AMIGA) || defined(CONFIG_MAC) || defined(CONFIG_ATARI) \
-	|| defined(CONFIG_APOLLO) || defined(CONFIG_MVME16x)                \
+	|| defined(CONFIG_MVME16x)                                          \
 	|| defined(CONFIG_BVME6000) || defined(CONFIG_HP300)                \
 	|| defined(CONFIG_Q40) || defined(CONFIG_MVME147)                   \
 	|| defined(CONFIG_VIRT)
@@ -183,7 +169,7 @@ extern unsigned long m68k_machtype;
 #if !defined(CONFIG_VIRT)
 #  define MACH_IS_VIRT (0)
 #elif defined(CONFIG_AMIGA) || defined(CONFIG_MAC) || defined(CONFIG_ATARI) \
-	|| defined(CONFIG_APOLLO) || defined(CONFIG_MVME16x)                \
+	|| defined(CONFIG_MVME16x)                                          \
 	|| defined(CONFIG_BVME6000) || defined(CONFIG_HP300)                \
 	|| defined(CONFIG_Q40) || defined(CONFIG_SUN3X)                     \
 	|| defined(CONFIG_MVME147)
diff --git a/arch/m68k/include/uapi/asm/bootinfo-apollo.h b/arch/m68k/include/uapi/asm/bootinfo-apollo.h
deleted file mode 100644
index c226f7957938..000000000000
--- a/arch/m68k/include/uapi/asm/bootinfo-apollo.h
+++ /dev/null
@@ -1,29 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-/*
-** asm/bootinfo-apollo.h -- Apollo-specific boot information definitions
-*/
-
-#ifndef _UAPI_ASM_M68K_BOOTINFO_APOLLO_H
-#define _UAPI_ASM_M68K_BOOTINFO_APOLLO_H
-
-
-    /*
-     *  Apollo-specific tags
-     */
-
-#define BI_APOLLO_MODEL		0x8000	/* model (__be32) */
-
-
-    /*
-     *  Apollo models (BI_APOLLO_MODEL)
-     */
-
-#define APOLLO_UNKNOWN		0
-#define APOLLO_DN3000		1
-#define APOLLO_DN3010		2
-#define APOLLO_DN3500		3
-#define APOLLO_DN4000		4
-#define APOLLO_DN4500		5
-
-
-#endif /* _UAPI_ASM_M68K_BOOTINFO_APOLLO_H */
diff --git a/arch/m68k/include/uapi/asm/bootinfo.h b/arch/m68k/include/uapi/asm/bootinfo.h
index 28d2d44c08d0..a199a7ecd3cd 100644
--- a/arch/m68k/include/uapi/asm/bootinfo.h
+++ b/arch/m68k/include/uapi/asm/bootinfo.h
@@ -80,7 +80,7 @@ struct mem_info {
 #define MACH_AMIGA		1
 #define MACH_ATARI		2
 #define MACH_MAC		3
-#define MACH_APOLLO		4
+/* 4 was MACH_APOLLO */
 #define MACH_SUN3		5
 #define MACH_MVME147		6
 #define MACH_MVME16x		7
@@ -134,7 +134,7 @@ struct mem_info {
 #define MMUB_68030		1	/* Internal MMU */
 #define MMUB_68040		2	/* Internal MMU */
 #define MMUB_68060		3	/* Internal MMU */
-#define MMUB_APOLLO		4	/* Custom Apollo */
+/* 4 was MMUB_APOLLO */
 #define MMUB_SUN3		5	/* Custom Sun-3 */
 #define MMUB_COLDFIRE		6	/* Internal MMU */
 
@@ -143,7 +143,6 @@ struct mem_info {
 #define MMU_68040		(1 << MMUB_68040)
 #define MMU_68060		(1 << MMUB_68060)
 #define MMU_SUN3		(1 << MMUB_SUN3)
-#define MMU_APOLLO		(1 << MMUB_APOLLO)
 #define MMU_COLDFIRE		(1 << MMUB_COLDFIRE)
 
 
diff --git a/arch/m68k/kernel/head.S b/arch/m68k/kernel/head.S
index 2e4ef0358887..573b30100679 100644
--- a/arch/m68k/kernel/head.S
+++ b/arch/m68k/kernel/head.S
@@ -449,7 +449,7 @@ func_define	mmu_get_ptr_table_entry,2
 func_define	mmu_get_page_table_entry,2
 func_define	mmu_print
 func_define	get_new_page
-#if defined(CONFIG_HP300) || defined(CONFIG_APOLLO)
+#ifdef CONFIG_HP300
 func_define	set_leds
 #endif
 
@@ -528,17 +528,10 @@ func_define	putn,1
 #define is_mvme16x(lab) cmpl &MACH_MVME16x,%pc@(m68k_machtype); jeq lab
 #define is_bvme6000(lab) cmpl &MACH_BVME6000,%pc@(m68k_machtype); jeq lab
 #define is_not_hp300(lab) cmpl &MACH_HP300,%pc@(m68k_machtype); jne lab
-#define is_not_apollo(lab) cmpl &MACH_APOLLO,%pc@(m68k_machtype); jne lab
 #define is_not_q40(lab) cmpl &MACH_Q40,%pc@(m68k_machtype); jne lab
 #define is_not_sun3x(lab) cmpl &MACH_SUN3X,%pc@(m68k_machtype); jne lab
 #define is_not_virt(lab) cmpl &MACH_VIRT,%pc@(m68k_machtype); jne lab
 
-#define hasnt_leds(lab) cmpl &MACH_HP300,%pc@(m68k_machtype); \
-			jeq 42f; \
-			cmpl &MACH_APOLLO,%pc@(m68k_machtype); \
-			jne lab ;\
-		42:\
-
 #define is_040_or_060(lab)	btst &CPUTYPE_0460,%pc@(L(cputype)+3); jne lab
 #define is_not_040_or_060(lab)	btst &CPUTYPE_0460,%pc@(L(cputype)+3); jeq lab
 #define is_040(lab)		btst &CPUTYPE_040,%pc@(L(cputype)+3); jne lab
@@ -551,8 +544,8 @@ func_define	putn,1
    the console is running.  Writing a 1 bit turns the corresponding LED
    _off_ - on the 340 bit 7 is towards the back panel of the machine.  */
 .macro	leds	mask
-#if defined(CONFIG_HP300) || defined(CONFIG_APOLLO)
-	hasnt_leds(.Lled\@)
+#ifdef CONFIG_HP300
+	is_not_hp300(.Lled\@)
 	pea	\mask
 	func_call	set_leds
 	addql	#4,%sp
@@ -1250,16 +1243,6 @@ L(notsun3x):
 L(novirt):
 #endif
 
-#ifdef CONFIG_APOLLO
-	is_not_apollo(L(notapollo))
-
-	putc	'P'
-	mmu_map         #0x80000000,#0,#0x02000000,#_PAGE_NOCACHE030
-
-L(notapollo):
-	jbra	L(mmu_init_done)
-#endif
-
 L(mmu_init_done):
 
 	putc	'G'
@@ -1445,16 +1428,6 @@ L(mmu_fixup_done):
 	/* enable copro */
 	oriw	#0x4000,0x61000000
 1:
-#endif
-
-#ifdef CONFIG_APOLLO
-	is_not_apollo(1f)
-
-	/*
-	 * Fix up the iobase before printing
-	 */
-	movel	#0x80000000,L(iobase)
-1:
 #endif
 
 	putc	'I'
@@ -2982,10 +2955,6 @@ L(serial_init_not_mac):
 L(serial_init_not_mvme16x):
 #endif
 
-#ifdef CONFIG_APOLLO
-/* We count on the PROM initializing SIO1 */
-#endif
-
 #ifdef CONFIG_HP300
 /* We count on the boot loader initialising the UART */
 #endif
@@ -3167,17 +3136,6 @@ func_start	serial_putc,%d0/%d1/%a0/%a1
 2:
 #endif
 
-#ifdef CONFIG_APOLLO
-	is_not_apollo(2f)
-	movl    %pc@(L(iobase)),%a1
-	moveb	%d0,%a1@(LTHRB0)
-1:      moveb   %a1@(LSRB0),%d0
-	andb	#0x4,%d0
-	beq	1b
-	jbra	L(serial_putc_done)
-2:
-#endif
-
 #ifdef CONFIG_HP300
 	is_not_hp300(3f)
 	movl    %pc@(L(iobase)),%a1
@@ -3293,23 +3251,14 @@ ENTRY(debug_cons_nputs)
 	rts
 #endif /* CONFIG_EARLY_PRINTK */
 
-#if defined(CONFIG_HP300) || defined(CONFIG_APOLLO)
+#ifdef CONFIG_HP300
 func_start	set_leds,%d0/%a0
 	movel	ARG1,%d0
-#ifdef CONFIG_HP300
 	is_not_hp300(1f)
 	movel	%pc@(L(iobase)),%a0
 	moveb	%d0,%a0@(0x1ffff)
-	jra	2f
-#endif
+	jra	1f
 1:
-#ifdef CONFIG_APOLLO
-	movel   %pc@(L(iobase)),%a0
-	lsll    #8,%d0
-	eorw    #0xff00,%d0
-	moveb	%d0,%a0@(LCPUCTRL)
-#endif
-2:
 func_return	set_leds
 #endif
 
@@ -3768,8 +3717,7 @@ __INITDATA
 m68k_init_mapped_size:
 	.long	0
 
-#if defined(CONFIG_ATARI) || defined(CONFIG_AMIGA) || \
-    defined(CONFIG_HP300) || defined(CONFIG_APOLLO)
+#if defined(CONFIG_ATARI) || defined(CONFIG_AMIGA) || defined(CONFIG_HP300)
 L(custom):
 L(iobase):
 	.long 0
@@ -3850,12 +3798,6 @@ L(mac_sccbase):
 	.long	0
 #endif /* CONFIG_MAC */
 
-#if defined (CONFIG_APOLLO)
-LSRB0        = 0x10412
-LTHRB0       = 0x10416
-LCPUCTRL     = 0x10100
-#endif
-
 #if defined(CONFIG_HP300)
 DCADATA	     = 0x11
 DCALSR	     = 0x1b
diff --git a/arch/m68k/kernel/setup_mm.c b/arch/m68k/kernel/setup_mm.c
index c7e8de0d34bb..2451dda2f701 100644
--- a/arch/m68k/kernel/setup_mm.c
+++ b/arch/m68k/kernel/setup_mm.c
@@ -178,8 +178,6 @@ static void __init m68k_parse_bootinfo(const struct bi_record *record)
 				unknown = mvme147_parse_bootinfo(record);
 			else if (MACH_IS_HP300)
 				unknown = hp300_parse_bootinfo(record);
-			else if (MACH_IS_APOLLO)
-				unknown = apollo_parse_bootinfo(record);
 			else if (MACH_IS_VIRT)
 				unknown = virt_parse_bootinfo(record);
 			else
@@ -275,11 +273,6 @@ void __init setup_arch(char **cmdline_p)
 		config_sun3();
 		break;
 #endif
-#ifdef CONFIG_APOLLO
-	case MACH_APOLLO:
-		config_apollo();
-		break;
-#endif
 #ifdef CONFIG_MVME147
 	case MACH_MVME147:
 		config_mvme147();
@@ -433,8 +426,6 @@ static int show_cpuinfo(struct seq_file *m, void *v)
 		mmu = "68060";
 	else if (m68k_mmutype & MMU_SUN3)
 		mmu = "Sun-3";
-	else if (m68k_mmutype & MMU_APOLLO)
-		mmu = "Apollo";
 	else if (m68k_mmutype & MMU_COLDFIRE)
 		mmu = "ColdFire";
 	else
diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
index a733f90eca55..2796e3dd7eaa 100644
--- a/drivers/video/fbdev/Kconfig
+++ b/drivers/video/fbdev/Kconfig
@@ -184,14 +184,6 @@ config FB_CYBER2000_I2C
 	  Integraphics CyberPro 20x0 and 5000 VGA chips.  This is used
 	  on the Netwinder machines for the SAA7111 video capture.
 
-config FB_APOLLO
-	bool
-	depends on (FB = y) && APOLLO
-	default y
-	select FB_CFB_FILLRECT
-	select FB_CFB_IMAGEBLIT
-	select FB_IOMEM_FOPS
-
 config FB_Q40
 	bool
 	depends on (FB = y) && Q40
diff --git a/drivers/video/fbdev/Makefile b/drivers/video/fbdev/Makefile
index b3d12f977c06..bc2e45da30d6 100644
--- a/drivers/video/fbdev/Makefile
+++ b/drivers/video/fbdev/Makefile
@@ -63,7 +63,6 @@ obj-$(CONFIG_FB_HGA)              += hgafb.o
 obj-$(CONFIG_FB_XVR500)           += sunxvr500.o
 obj-$(CONFIG_FB_XVR2500)          += sunxvr2500.o
 obj-$(CONFIG_FB_XVR1000)          += sunxvr1000.o
-obj-$(CONFIG_FB_APOLLO)           += dnfb.o
 obj-$(CONFIG_FB_Q40)              += q40fb.o
 obj-$(CONFIG_FB_TGA)              += tgafb.o
 obj-$(CONFIG_FB_HP300)            += hpfb.o
diff --git a/drivers/video/fbdev/dnfb.c b/drivers/video/fbdev/dnfb.c
deleted file mode 100644
index c4d24540d9ef..000000000000
--- a/drivers/video/fbdev/dnfb.c
+++ /dev/null
@@ -1,307 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-#include <linux/kernel.h>
-#include <linux/errno.h>
-#include <linux/string.h>
-#include <linux/mm.h>
-#include <linux/delay.h>
-#include <linux/interrupt.h>
-#include <linux/platform_device.h>
-
-#include <asm/setup.h>
-#include <asm/irq.h>
-#include <asm/amigahw.h>
-#include <asm/amigaints.h>
-#include <asm/apollohw.h>
-#include <linux/fb.h>
-#include <linux/module.h>
-
-/* apollo video HW definitions */
-
-/*
- * Control Registers.   IOBASE + $x
- *
- * Note: these are the Memory/IO BASE definitions for a mono card set to the
- * alternate address
- *
- * Control 3A and 3B serve identical functions except that 3A
- * deals with control 1 and 3b deals with Color LUT reg.
- */
-
-#define AP_IOBASE       0x3b0	/* Base address of 1 plane board. */
-#define AP_STATUS       isaIO2mem(AP_IOBASE+0)	/* Status register.  Read */
-#define AP_WRITE_ENABLE isaIO2mem(AP_IOBASE+0)	/* Write Enable Register Write */
-#define AP_DEVICE_ID    isaIO2mem(AP_IOBASE+1)	/* Device ID Register. Read */
-#define AP_ROP_1        isaIO2mem(AP_IOBASE+2)	/* Raster Operation reg. Write Word */
-#define AP_DIAG_MEM_REQ isaIO2mem(AP_IOBASE+4)	/* Diagnostic Memory Request. Write Word */
-#define AP_CONTROL_0    isaIO2mem(AP_IOBASE+8)	/* Control Register 0.  Read/Write */
-#define AP_CONTROL_1    isaIO2mem(AP_IOBASE+0xa)	/* Control Register 1.  Read/Write */
-#define AP_CONTROL_3A   isaIO2mem(AP_IOBASE+0xe)	/* Control Register 3a. Read/Write */
-#define AP_CONTROL_2    isaIO2mem(AP_IOBASE+0xc)	/* Control Register 2. Read/Write */
-
-
-#define FRAME_BUFFER_START 0x0FA0000
-#define FRAME_BUFFER_LEN 0x40000
-
-/* CREG 0 */
-#define VECTOR_MODE 0x40	/* 010x.xxxx */
-#define DBLT_MODE   0x80	/* 100x.xxxx */
-#define NORMAL_MODE 0xE0	/* 111x.xxxx */
-#define SHIFT_BITS  0x1F	/* xxx1.1111 */
-	/* other bits are Shift value */
-
-/* CREG 1 */
-#define AD_BLT      0x80	/* 1xxx.xxxx */
-#define NORMAL      0x80 /* 1xxx.xxxx */	/* What is happening here ?? */
-#define INVERSE     0x00 /* 0xxx.xxxx */	/* Clearing this reverses the screen */
-#define PIX_BLT     0x00	/* 0xxx.xxxx */
-
-#define AD_HIBIT        0x40	/* xIxx.xxxx */
-
-#define ROP_EN          0x10	/* xxx1.xxxx */
-#define DST_EQ_SRC      0x00	/* xxx0.xxxx */
-#define nRESET_SYNC     0x08	/* xxxx.1xxx */
-#define SYNC_ENAB       0x02	/* xxxx.xx1x */
-
-#define BLANK_DISP      0x00	/* xxxx.xxx0 */
-#define ENAB_DISP       0x01	/* xxxx.xxx1 */
-
-#define NORM_CREG1      (nRESET_SYNC | SYNC_ENAB | ENAB_DISP)	/* no reset sync */
-
-/* CREG 2 */
-
-/*
- * Following 3 defines are common to 1, 4 and 8 plane.
- */
-
-#define S_DATA_1s   0x00 /* 00xx.xxxx */	/* set source to all 1's -- vector drawing */
-#define S_DATA_PIX  0x40 /* 01xx.xxxx */	/* takes source from ls-bits and replicates over 16 bits */
-#define S_DATA_PLN  0xC0 /* 11xx.xxxx */	/* normal, each data access =16-bits in
-						   one plane of image mem */
-
-/* CREG 3A/CREG 3B */
-#       define RESET_CREG 0x80	/* 1000.0000 */
-
-/* ROP REG  -  all one nibble */
-/*      ********* NOTE : this is used r0,r1,r2,r3 *********** */
-#define ROP(r2,r3,r0,r1) ( (U_SHORT)((r0)|((r1)<<4)|((r2)<<8)|((r3)<<12)) )
-#define DEST_ZERO               0x0
-#define SRC_AND_DEST    0x1
-#define SRC_AND_nDEST   0x2
-#define SRC                             0x3
-#define nSRC_AND_DEST   0x4
-#define DEST                    0x5
-#define SRC_XOR_DEST    0x6
-#define SRC_OR_DEST             0x7
-#define SRC_NOR_DEST    0x8
-#define SRC_XNOR_DEST   0x9
-#define nDEST                   0xA
-#define SRC_OR_nDEST    0xB
-#define nSRC                    0xC
-#define nSRC_OR_DEST    0xD
-#define SRC_NAND_DEST   0xE
-#define DEST_ONE                0xF
-
-#define SWAP(A) ((A>>8) | ((A&0xff) <<8))
-
-/* frame buffer operations */
-
-static int dnfb_blank(int blank, struct fb_info *info);
-static void dnfb_copyarea(struct fb_info *info, const struct fb_copyarea *area);
-
-static const struct fb_ops dn_fb_ops = {
-	.owner		= THIS_MODULE,
-	__FB_DEFAULT_IOMEM_OPS_RDWR,
-	.fb_blank	= dnfb_blank,
-	.fb_fillrect	= cfb_fillrect,
-	.fb_copyarea	= dnfb_copyarea,
-	.fb_imageblit	= cfb_imageblit,
-	__FB_DEFAULT_IOMEM_OPS_MMAP,
-};
-
-static const struct fb_var_screeninfo dnfb_var = {
-	.xres		= 1280,
-	.yres		= 1024,
-	.xres_virtual	= 2048,
-	.yres_virtual	= 1024,
-	.bits_per_pixel	= 1,
-	.height		= -1,
-	.width		= -1,
-	.vmode		= FB_VMODE_NONINTERLACED,
-};
-
-static const struct fb_fix_screeninfo dnfb_fix = {
-	.id		= "Apollo Mono",
-	.smem_start	= (FRAME_BUFFER_START + IO_BASE),
-	.smem_len	= FRAME_BUFFER_LEN,
-	.type		= FB_TYPE_PACKED_PIXELS,
-	.visual		= FB_VISUAL_MONO10,
-	.line_length	= 256,
-};
-
-static int dnfb_blank(int blank, struct fb_info *info)
-{
-	if (blank)
-		out_8(AP_CONTROL_3A, 0x0);
-	else
-		out_8(AP_CONTROL_3A, 0x1);
-	return 0;
-}
-
-static
-void dnfb_copyarea(struct fb_info *info, const struct fb_copyarea *area)
-{
-
-	int incr, y_delta, pre_read = 0, x_end, x_word_count;
-	uint start_mask, end_mask, dest;
-	ushort *src, dummy;
-	short i, j;
-
-	incr = (area->dy <= area->sy) ? 1 : -1;
-
-	src = (ushort *)(info->screen_base + area->sy * info->fix.line_length +
-			(area->sx >> 4));
-	dest = area->dy * (info->fix.line_length >> 1) + (area->dx >> 4);
-
-	if (incr > 0) {
-		y_delta = (info->fix.line_length * 8) - area->sx - area->width;
-		x_end = area->dx + area->width - 1;
-		x_word_count = (x_end >> 4) - (area->dx >> 4) + 1;
-		start_mask = 0xffff0000 >> (area->dx & 0xf);
-		end_mask = 0x7ffff >> (x_end & 0xf);
-		out_8(AP_CONTROL_0,
-		     (((area->dx & 0xf) - (area->sx & 0xf)) % 16) | (0x4 << 5));
-		if ((area->dx & 0xf) < (area->sx & 0xf))
-			pre_read = 1;
-	} else {
-		y_delta = -((info->fix.line_length * 8) - area->sx - area->width);
-		x_end = area->dx - area->width + 1;
-		x_word_count = (area->dx >> 4) - (x_end >> 4) + 1;
-		start_mask = 0x7ffff >> (area->dx & 0xf);
-		end_mask = 0xffff0000 >> (x_end & 0xf);
-		out_8(AP_CONTROL_0,
-		     ((-((area->sx & 0xf) - (area->dx & 0xf))) % 16) |
-		     (0x4 << 5));
-		if ((area->dx & 0xf) > (area->sx & 0xf))
-			pre_read = 1;
-	}
-
-	for (i = 0; i < area->height; i++) {
-
-		out_8(AP_CONTROL_3A, 0xc | (dest >> 16));
-
-		if (pre_read) {
-			dummy = *src;
-			src += incr;
-		}
-
-		if (x_word_count) {
-			out_8(AP_WRITE_ENABLE, start_mask);
-			*src = dest;
-			src += incr;
-			dest += incr;
-			out_8(AP_WRITE_ENABLE, 0);
-
-			for (j = 1; j < (x_word_count - 1); j++) {
-				*src = dest;
-				src += incr;
-				dest += incr;
-			}
-
-			out_8(AP_WRITE_ENABLE, start_mask);
-			*src = dest;
-			dest += incr;
-			src += incr;
-		} else {
-			out_8(AP_WRITE_ENABLE, start_mask | end_mask);
-			*src = dest;
-			dest += incr;
-			src += incr;
-		}
-		src += (y_delta / 16);
-		dest += (y_delta / 16);
-	}
-	out_8(AP_CONTROL_0, NORMAL_MODE);
-}
-
-/*
- * Initialization
- */
-
-static int dnfb_probe(struct platform_device *dev)
-{
-	struct fb_info *info;
-	int err = 0;
-
-	info = framebuffer_alloc(0, &dev->dev);
-	if (!info)
-		return -ENOMEM;
-
-	info->fbops = &dn_fb_ops;
-	info->fix = dnfb_fix;
-	info->var = dnfb_var;
-	info->var.red.length = 1;
-	info->var.red.offset = 0;
-	info->var.green = info->var.blue = info->var.red;
-	info->screen_base = (u_char *) info->fix.smem_start;
-
-	err = fb_alloc_cmap(&info->cmap, 2, 0);
-	if (err < 0)
-		goto release_framebuffer;
-
-	err = register_framebuffer(info);
-	if (err < 0) {
-		fb_dealloc_cmap(&info->cmap);
-		goto release_framebuffer;
-	}
-	platform_set_drvdata(dev, info);
-
-	/* now we have registered we can safely setup the hardware */
-	out_8(AP_CONTROL_3A, RESET_CREG);
-	out_be16(AP_WRITE_ENABLE, 0x0);
-	out_8(AP_CONTROL_0, NORMAL_MODE);
-	out_8(AP_CONTROL_1, (AD_BLT | DST_EQ_SRC | NORM_CREG1));
-	out_8(AP_CONTROL_2, S_DATA_PLN);
-	out_be16(AP_ROP_1, SWAP(0x3));
-
-	printk("apollo frame buffer alive and kicking !\n");
-	return err;
-
-release_framebuffer:
-	framebuffer_release(info);
-	return err;
-}
-
-static struct platform_driver dnfb_driver = {
-	.probe	= dnfb_probe,
-	.driver	= {
-		.name	= "dnfb",
-	},
-};
-
-static struct platform_device dnfb_device = {
-	.name	= "dnfb",
-};
-
-static int __init dnfb_init(void)
-{
-	int ret;
-
-	if (!MACH_IS_APOLLO)
-		return -ENODEV;
-
-	if (fb_get_options("dnfb", NULL))
-		return -ENODEV;
-
-	ret = platform_driver_register(&dnfb_driver);
-
-	if (!ret) {
-		ret = platform_device_register(&dnfb_device);
-		if (ret)
-			platform_driver_unregister(&dnfb_driver);
-	}
-	return ret;
-}
-
-module_init(dnfb_init);
-
-MODULE_LICENSE("GPL");
-- 
2.43.0



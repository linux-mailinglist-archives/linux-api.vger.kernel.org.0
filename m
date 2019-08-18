Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 79F9C917CB
	for <lists+linux-api@lfdr.de>; Sun, 18 Aug 2019 18:24:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726743AbfHRQYk (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sun, 18 Aug 2019 12:24:40 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:44762 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726247AbfHRQYk (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sun, 18 Aug 2019 12:24:40 -0400
Received: from pd9ef1cb8.dip0.t-ipconnect.de ([217.239.28.184] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hzNyd-0008Fa-TT; Sun, 18 Aug 2019 18:24:20 +0200
Date:   Sun, 18 Aug 2019 18:24:18 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Dmitry Safonov <0x7f454c46@gmail.com>
cc:     Andy Lutomirski <luto@kernel.org>,
        Dmitry Safonov <dima@arista.com>, linux-kernel@vger.kernel.org,
        Adrian Reber <adrian@lisas.de>,
        Andrei Vagin <avagin@openvz.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jann Horn <jannh@google.com>, Jeff Dike <jdike@addtoit.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Shuah Khan <shuah@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        containers@lists.linux-foundation.org, criu@openvz.org,
        linux-api@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCHv6 23/36] x86/vdso: Allocate timens vdso
In-Reply-To: <alpine.DEB.2.21.1908171709360.1923@nanos.tec.linutronix.de>
Message-ID: <alpine.DEB.2.21.1908181823010.1923@nanos.tec.linutronix.de>
References: <20190815163836.2927-1-dima@arista.com> <20190815163836.2927-24-dima@arista.com> <b719199a-ed91-610b-38bc-015a0749f600@kernel.org> <alpine.DEB.2.21.1908162208190.1923@nanos.tec.linutronix.de> <483678c7-7687-5445-f09e-e45e9460d559@gmail.com>
 <alpine.DEB.2.21.1908171709360.1923@nanos.tec.linutronix.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Sun, 18 Aug 2019, Thomas Gleixner wrote:
> 
> Patch below. I tested this with the normal order and by installing a
> 'timens' page unconditionally for all processes. I'll reply with the timens
> testing hacks so you can see what I did.

First hack...

Thanks,

	tglx

8<-----------------

Subject: x86/vdso: Hack to enable time name space  for testing
From: Thomas Gleixner <tglx@linutronix.de>
Date: Sun, 18 Aug 2019 16:42:26 +0200

Select CONFIG_VDSO_TIMENS and prepare for the extra magic time namespace
vvar page. The fault handler is not handling it yet as the path is never
taken (hopefully)

Not-Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/Kconfig                         |    1 +
 arch/x86/entry/vdso/vdso-layout.lds.S    |    3 ++-
 arch/x86/entry/vdso/vdso2c.c             |    3 +++
 arch/x86/include/asm/vdso.h              |    1 +
 arch/x86/include/asm/vdso/gettimeofday.h |    9 +++++++++
 5 files changed, 16 insertions(+), 1 deletion(-)

--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -224,6 +224,7 @@ config X86
 	select VIRT_TO_BUS
 	select X86_FEATURE_NAMES		if PROC_FS
 	select PROC_PID_ARCH_STATUS		if PROC_FS
+	select VDSO_TIMENS
 
 config INSTRUCTION_DECODER
 	def_bool y
--- a/arch/x86/entry/vdso/vdso-layout.lds.S
+++ b/arch/x86/entry/vdso/vdso-layout.lds.S
@@ -16,7 +16,7 @@ SECTIONS
 	 * segment.
 	 */
 
-	vvar_start = . - 3 * PAGE_SIZE;
+	vvar_start = . - 4 * PAGE_SIZE;
 	vvar_page = vvar_start;
 
 	/* Place all vvars at the offsets in asm/vvar.h. */
@@ -28,6 +28,7 @@ SECTIONS
 
 	pvclock_page = vvar_start + PAGE_SIZE;
 	hvclock_page = vvar_start + 2 * PAGE_SIZE;
+	timens_page = vvar_start + 3 * PAGE_SIZE;
 
 	. = SIZEOF_HEADERS;
 
--- a/arch/x86/entry/vdso/vdso2c.c
+++ b/arch/x86/entry/vdso/vdso2c.c
@@ -75,12 +75,14 @@ enum {
 	sym_vvar_page,
 	sym_pvclock_page,
 	sym_hvclock_page,
+	sym_timens_page,
 };
 
 const int special_pages[] = {
 	sym_vvar_page,
 	sym_pvclock_page,
 	sym_hvclock_page,
+	sym_timens_page,
 };
 
 struct vdso_sym {
@@ -93,6 +95,7 @@ struct vdso_sym required_syms[] = {
 	[sym_vvar_page] = {"vvar_page", true},
 	[sym_pvclock_page] = {"pvclock_page", true},
 	[sym_hvclock_page] = {"hvclock_page", true},
+	[sym_timens_page] = {"timens_page", true},
 	{"VDSO32_NOTE_MASK", true},
 	{"__kernel_vsyscall", true},
 	{"__kernel_sigreturn", true},
--- a/arch/x86/include/asm/vdso.h
+++ b/arch/x86/include/asm/vdso.h
@@ -21,6 +21,7 @@ struct vdso_image {
 	long sym_vvar_page;
 	long sym_pvclock_page;
 	long sym_hvclock_page;
+	long sym_timens_page;
 	long sym_VDSO32_NOTE_MASK;
 	long sym___kernel_sigreturn;
 	long sym___kernel_rt_sigreturn;
--- a/arch/x86/include/asm/vdso/gettimeofday.h
+++ b/arch/x86/include/asm/vdso/gettimeofday.h
@@ -265,6 +265,15 @@ static __always_inline const struct vdso
 	return __vdso_data;
 }
 
+/* HACK .... */
+#define VDSO_TIMENS_PAGEOFFSET		(3 * PAGE_SIZE)
+
+static __always_inline
+const struct vdso_data *__arch_get_timens_vdso_data(const struct vdso_data *vd)
+{
+	return (void *)vd + VDSO_TIMENS_PAGEOFFSET;
+}
+
 /*
  * x86 specific delta calculation.
  *

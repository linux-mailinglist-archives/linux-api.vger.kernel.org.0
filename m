Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 23FD1917D3
	for <lists+linux-api@lfdr.de>; Sun, 18 Aug 2019 18:29:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726089AbfHRQ3m (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sun, 18 Aug 2019 12:29:42 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:44780 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726005AbfHRQ3m (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sun, 18 Aug 2019 12:29:42 -0400
Received: from pd9ef1cb8.dip0.t-ipconnect.de ([217.239.28.184] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hzO3U-0008Nc-7D; Sun, 18 Aug 2019 18:29:20 +0200
Date:   Sun, 18 Aug 2019 18:29:19 +0200 (CEST)
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
In-Reply-To: <alpine.DEB.2.21.1908181823010.1923@nanos.tec.linutronix.de>
Message-ID: <alpine.DEB.2.21.1908181828070.1923@nanos.tec.linutronix.de>
References: <20190815163836.2927-1-dima@arista.com> <20190815163836.2927-24-dima@arista.com> <b719199a-ed91-610b-38bc-015a0749f600@kernel.org> <alpine.DEB.2.21.1908162208190.1923@nanos.tec.linutronix.de> <483678c7-7687-5445-f09e-e45e9460d559@gmail.com>
 <alpine.DEB.2.21.1908171709360.1923@nanos.tec.linutronix.de> <alpine.DEB.2.21.1908181823010.1923@nanos.tec.linutronix.de>
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

> On Sun, 18 Aug 2019, Thomas Gleixner wrote:
> > 
> > Patch below. I tested this with the normal order and by installing a
> > 'timens' page unconditionally for all processes. I'll reply with the timens
> > testing hacks so you can see what I did.
> 
> First hack...

And the second one.

Thanks,

	tglx

8<-----------------

Subject: x86/vdso: Hack to test the time namespace path
From: Thomas Gleixner <tglx@linutronix.de>
Date: Sun, 18 Aug 2019 16:49:00 +0200

Install a special TIMENS vvar page which forces the VDSO to take the time
namespace path for testing.

Not-Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/entry/vdso/vma.c |   34 +++++++++++++++++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

--- a/arch/x86/entry/vdso/vma.c
+++ b/arch/x86/entry/vdso/vma.c
@@ -84,6 +84,33 @@ static int vdso_mremap(const struct vm_s
 	return 0;
 }
 
+/* Hack for testing */
+static struct page *vdso_timens_page;
+
+static int __init init_vdso_timens(void)
+{
+	struct vdso_data *vdata;
+	void *va;
+
+	vdso_timens_page = alloc_page(GFP_KERNEL | __GFP_ZERO);
+	if (!vdso_timens_page)
+		return -ENOMEM;
+
+	/* Hack: vdso data is at offset 0x80 in the page ... */
+	va = page_address(vdso_timens_page);
+	vdata = (struct vdso_data *)(va + 0x80);
+
+	vdata[0].seq = 1;
+	vdata[0].clock_mode = UINT_MAX;
+	vdata[1].seq = 1;
+	vdata[1].clock_mode = UINT_MAX;
+
+	/* All offsets are zero */
+
+	return 0;
+}
+subsys_initcall(init_vdso_timens);
+
 static vm_fault_t vvar_fault(const struct vm_special_mapping *sm,
 		      struct vm_area_struct *vma, struct vm_fault *vmf)
 {
@@ -106,7 +133,7 @@ static vm_fault_t vvar_fault(const struc
 	if (sym_offset == 0)
 		return VM_FAULT_SIGBUS;
 
-	if (sym_offset == image->sym_vvar_page) {
+	if (sym_offset == image->sym_timens_page) {
 		return vmf_insert_pfn(vma, vmf->address,
 				__pa_symbol(&__vvar_page) >> PAGE_SHIFT);
 	} else if (sym_offset == image->sym_pvclock_page) {
@@ -123,6 +150,11 @@ static vm_fault_t vvar_fault(const struc
 		if (tsc_pg && vclock_was_used(VCLOCK_HVCLOCK))
 			return vmf_insert_pfn(vma, vmf->address,
 					vmalloc_to_pfn(tsc_pg));
+	} else if (sym_offset == image->sym_vvar_page) {
+		unsigned long pfn;
+
+		pfn = page_to_pfn(vdso_timens_page);
+		return vmf_insert_pfn(vma, vmf->address, pfn);
 	}
 
 	return VM_FAULT_SIGBUS;

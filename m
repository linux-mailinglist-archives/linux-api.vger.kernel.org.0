Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5EB9A83E4D
	for <lists+linux-api@lfdr.de>; Wed,  7 Aug 2019 02:27:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726334AbfHGA1h (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 6 Aug 2019 20:27:37 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35065 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726238AbfHGA1d (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 6 Aug 2019 20:27:33 -0400
Received: by mail-wm1-f68.google.com with SMTP id l2so78128746wmg.0
        for <linux-api@vger.kernel.org>; Tue, 06 Aug 2019 17:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cDIr3JODYU7FS0xjE/N2Ulu9ZMmr6z8UFiq2vRQunkU=;
        b=aRgkvqOZypFL1/+cRARkYeVzqMhWIzxt01DgyFAQb995klAsM66uzb5etRCvcV8RAa
         YcLX99lx7OWiF7ZiiZXRAQijNuxGijp4f0Mx2yCgx0WYIdnE1rOVZqR0UL66u/mJ85LH
         vj3/1wmGb5dYM+72+JvRgod6AnaecJnTOZ5/VBivyjVpPRQmlLF91JHR4djNZLXeQ6rv
         f4q6T28H9Rv38HUhqXiQ3dMzIZi0SkF1ewfwxxAyopJ9eKDlezX8Jn69s6ysE7DSvNeL
         vu0NftliOnuX8yzPWg3i1SDvHhiF3zicfRkQdRuo4IP+itZYz8SbQo99ZvVY7sSzlKJ2
         9iCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cDIr3JODYU7FS0xjE/N2Ulu9ZMmr6z8UFiq2vRQunkU=;
        b=Ds34cCOYlDuYDh1UjZPc7XHLOdtWlCFqFy7FDrvSu4ZEMJxXdGjn1YFf9SpsfRlhes
         22z4eMNlwMWGWJrwv4o/muTpA5CEEK3bQ2C060KDmzs8kLryGHz/ufoansNzgIUaiqi8
         Tf5K4hwrS0lfx28LDbJxhgR9jQa2Arb0kmuNsCLnbitRFAdhr1fxt4+fNW0dnNRsYa0K
         I22uMRTRRwoWFpcsmaFOjVA4sr+kSbvd9jz90ND85P2b8DFdX/yqBDLhXsNsZoqlDj3P
         GnfMiw5BSVSY9+6vGOVBx/OBSr4ytNCwv0Dv0vaoPkOxbRToxsUAQtcojrRmrkciH4ta
         FAIw==
X-Gm-Message-State: APjAAAUN78EGjHA/POqlCbrpAOudBKGsgCd5y2Qig2NvtX/hJABI15ub
        b2xwotengKlhsvvyqoz1ai9Hr+8HxrYGmlLby3dkIciq+xJY5apIiBIrSrsIcRYlrykh8BEJYHW
        VS4n+iSqAfq+OBfH7i0Fhc1JjD7HaJVZSjNdwrRxL3LoCILSUs0NfeVjW3kJuMeUse/5m9TbuBu
        47eXbRw7UxJCevyguq6Ar/Zk1zxw==
X-Google-Smtp-Source: APXvYqzoEPr4la8SIJDIRJK5slHoshwb6Ys904nvCBSvuJG6JnLwyA5lE7lMsxWDNwQcy2ehturhOg==
X-Received: by 2002:a1c:f115:: with SMTP id p21mr6281128wmh.134.1565137650594;
        Tue, 06 Aug 2019 17:27:30 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id y6sm121847291wmd.16.2019.08.06.17.27.29
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 06 Aug 2019 17:27:29 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     dima@arista.com
Cc:     0x7f454c46@gmail.com, adrian@lisas.de, arnd@arndb.de,
        avagin@gmail.com, avagin@openvz.org, christian.brauner@ubuntu.com,
        containers@lists.linux-foundation.org, criu@openvz.org,
        ebiederm@xmission.com, gorcunov@openvz.org, hpa@zytor.com,
        jannh@google.com, jdike@addtoit.com, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, luto@kernel.org, mingo@redhat.com,
        oleg@redhat.com, shuah@kernel.org, tglx@linutronix.de,
        vincenzo.frascino@arm.com, x86@kernel.org, xemul@virtuozzo.com
Subject: [PATCHv6 25/37] x86/vdso: Switch image on setns()/clone()
Date:   Wed,  7 Aug 2019 01:27:28 +0100
Message-Id: <20190807002728.19743-1-dima@arista.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190729215758.28405-26-dima@arista.com>
References: <20190729215758.28405-26-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CLOUD-SEC-AV-Info: arista,google_mail,monitor
X-CLOUD-SEC-AV-Sent: true
X-Gm-Spam: 0
X-Gm-Phishy: 0
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

As it has been discussed on timens RFC, adding a new conditional branch
`if (inside_time_ns)` on VDSO for all processes is undesirable.
It will add a penalty for everybody as branch predictor may mispredict
the jump. Also there are instruction cache lines wasted on cmp/jmp.

Those effects of introducing time namespace are very much unwanted
having in mind how much work have been spent on micro-optimisation
vdso code.

Addressing those problems, there are two versions of VDSO's .so:
for host tasks (without any penalty) and for processes inside of time
namespace with clk_to_ns() that subtracts offsets from host's time.

Whenever a user does setns() or unshare(CLONE_TIMENS) followed
by clone(), change VDSO image in mm and zap VVAR/VDSO page tables.
They will be re-faulted with corresponding image and VVAR offsets.

Co-developed-by: Andrei Vagin <avagin@gmail.com>
Signed-off-by: Andrei Vagin <avagin@gmail.com>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
v5..v6 Change:
  Rebased over current_is_single_threaded() change in the first patch.

 arch/x86/entry/vdso/vma.c   | 23 +++++++++++++++++++++++
 arch/x86/include/asm/vdso.h |  1 +
 kernel/time_namespace.c     | 11 +++++++++++
 3 files changed, 35 insertions(+)

diff --git a/arch/x86/entry/vdso/vma.c b/arch/x86/entry/vdso/vma.c
index 8a8211fd4cfc..91cf5a5c8c9e 100644
--- a/arch/x86/entry/vdso/vma.c
+++ b/arch/x86/entry/vdso/vma.c
@@ -25,6 +25,7 @@
 #include <asm/cpufeature.h>
 #include <clocksource/hyperv_timer.h>
 #include <asm/page.h>
+#include <asm/tlb.h>
 
 #if defined(CONFIG_X86_64)
 unsigned int __read_mostly vdso64_enabled = 1;
@@ -266,6 +267,28 @@ static const struct vm_special_mapping vvar_mapping = {
 	.mremap = vvar_mremap,
 };
 
+#ifdef CONFIG_TIME_NS
+int vdso_join_timens(struct task_struct *task)
+{
+	struct mm_struct *mm = task->mm;
+	struct vm_area_struct *vma;
+
+	if (down_write_killable(&mm->mmap_sem))
+		return -EINTR;
+
+	for (vma = mm->mmap; vma; vma = vma->vm_next) {
+		unsigned long size = vma->vm_end - vma->vm_start;
+
+		if (vma_is_special_mapping(vma, &vvar_mapping) ||
+		    vma_is_special_mapping(vma, &vdso_mapping))
+			zap_page_range(vma, vma->vm_start, size);
+	}
+
+	up_write(&mm->mmap_sem);
+	return 0;
+}
+#endif
+
 /*
  * Add vdso and vvar mappings to current process.
  * @image          - blob to map
diff --git a/arch/x86/include/asm/vdso.h b/arch/x86/include/asm/vdso.h
index 03f468c63a24..ccf89dedd04f 100644
--- a/arch/x86/include/asm/vdso.h
+++ b/arch/x86/include/asm/vdso.h
@@ -45,6 +45,7 @@ extern struct vdso_image vdso_image_32;
 extern void __init init_vdso_image(struct vdso_image *image);
 
 extern int map_vdso_once(const struct vdso_image *image, unsigned long addr);
+extern int vdso_join_timens(struct task_struct *task);
 
 #endif /* __ASSEMBLER__ */
 
diff --git a/kernel/time_namespace.c b/kernel/time_namespace.c
index cdfa1b75bd0d..2e7e0af44f04 100644
--- a/kernel/time_namespace.c
+++ b/kernel/time_namespace.c
@@ -15,6 +15,7 @@
 #include <linux/cred.h>
 #include <linux/err.h>
 #include <linux/mm.h>
+#include <asm/vdso.h>
 
 ktime_t do_timens_ktime_to_host(clockid_t clockid, ktime_t tim,
 				struct timens_offsets *ns_offsets)
@@ -199,6 +200,7 @@ static void timens_put(struct ns_common *ns)
 static int timens_install(struct nsproxy *nsproxy, struct ns_common *new)
 {
 	struct time_namespace *ns = to_time_ns(new);
+	int ret;
 
 	if (!current_is_single_threaded())
 		return -EUSERS;
@@ -207,6 +209,10 @@ static int timens_install(struct nsproxy *nsproxy, struct ns_common *new)
 	    !ns_capable(current_user_ns(), CAP_SYS_ADMIN))
 		return -EPERM;
 
+	ret = vdso_join_timens(current);
+	if (ret)
+		return ret;
+
 	get_time_ns(ns);
 	get_time_ns(ns);
 	put_time_ns(nsproxy->time_ns);
@@ -221,10 +227,15 @@ int timens_on_fork(struct nsproxy *nsproxy, struct task_struct *tsk)
 {
 	struct ns_common *nsc = &nsproxy->time_ns_for_children->ns;
 	struct time_namespace *ns = to_time_ns(nsc);
+	int ret;
 
 	if (nsproxy->time_ns == nsproxy->time_ns_for_children)
 		return 0;
 
+	ret = vdso_join_timens(tsk);
+	if (ret)
+		return ret;
+
 	get_time_ns(ns);
 	put_time_ns(nsproxy->time_ns);
 	nsproxy->time_ns = ns;
-- 
2.22.0


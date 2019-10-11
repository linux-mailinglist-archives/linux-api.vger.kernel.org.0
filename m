Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 262FAD3720
	for <lists+linux-api@lfdr.de>; Fri, 11 Oct 2019 03:30:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727777AbfJKBZN (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 10 Oct 2019 21:25:13 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53584 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728225AbfJKBYY (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 10 Oct 2019 21:24:24 -0400
Received: by mail-wm1-f66.google.com with SMTP id i16so8688230wmd.3
        for <linux-api@vger.kernel.org>; Thu, 10 Oct 2019 18:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HsA49FAjairc2qJZ7Rycye1Rp6D5SMcZ1vPARhzkRr0=;
        b=bZoJjrvB3n/42m49tC4IKb+nQWjCHnj14ZsTo6lQL55BwhnwcleE8WANJQIceDBNdF
         qJjlbc/V5JRDCAHT0y28UUUBi11lenYFjL0zQfwVxqLE4Lr5uZ6AjW7ZhnBXwY4GVYHN
         Sj8DOU4qUvfQo5hZe/IwH5f4n5EubpGDaK2cMHg5HkKSDiGBbAYLNHArQxvlFruLwdgw
         Q+fV4mNpaF0XFPPGsPvnlm7PLj60dxTxYHmvv5Uvfa0X1f6cgYi+7XqpqnvfFw/WUwVm
         S+DWbVTyxgzxuEKj+nLnSVWUNrar8TWF357bgCOybyIOJ+b3f8AZLK3L7e1RfO6/HsHC
         Ws7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HsA49FAjairc2qJZ7Rycye1Rp6D5SMcZ1vPARhzkRr0=;
        b=dSFnPJ21VHCgRjdfpVrc7XcBu4RS8OLUX1y28pj1/hVOAVAzL5umAFAxTipL3h52i3
         4vfVsINgwfL/bQ91DqmmCz4bd+M+hqg/TmqAJdeBTEXTasJW+HXb36eFhqSIL16u1TY1
         PhGSTq3foZqlPEHOzXsmS6ZbCCfHaRkjHp4rP72qhluEDEZScFnHDSpsbZ406cG2lWTI
         8dWeD21OlzSyuUQQJmQEQMdQx5W9zClFqwgovFhj+bu7Adp0aw3OMQKpQ3E1lqqGCFlb
         FWJy1etFFOsqfOY5vI3GFIdnIua5v7fEqn1s1JfiSv/iAoAmWm/7c/peLkco0AZRV9EA
         IHkQ==
X-Gm-Message-State: APjAAAUjTh9QUeYQ57iId6EoOCFcE/M/W8qHccNBdXiCwxN6VY8vQunb
        r/hcBU3XmKB1Ctztz0VlRRpxJA==
X-Google-Smtp-Source: APXvYqxc5jhAdxF7N7IqtgP9wocuBXRn/OBCxjRJu7PgAL2qGccHHzMTpSKQmfjQYk2ZMFg+xRgJKA==
X-Received: by 2002:a1c:dcd6:: with SMTP id t205mr999451wmg.10.1570757060434;
        Thu, 10 Oct 2019 18:24:20 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8084:ea2:c100:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id l13sm7699795wmj.25.2019.10.10.18.24.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2019 18:24:19 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Adrian Reber <adrian@lisas.de>,
        Andrei Vagin <avagin@openvz.org>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jann Horn <jannh@google.com>, Jeff Dike <jdike@addtoit.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        containers@lists.linux-foundation.org, criu@openvz.org,
        linux-api@vger.kernel.org, x86@kernel.org,
        Andrei Vagin <avagin@gmail.com>
Subject: [PATCHv7 23/33] x86/vdso: Handle faults on timens page
Date:   Fri, 11 Oct 2019 02:23:31 +0100
Message-Id: <20191011012341.846266-24-dima@arista.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191011012341.846266-1-dima@arista.com>
References: <20191011012341.846266-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

If a task belongs to a time namespace then the VVAR page which contains
the system wide VDSO data is replaced with a namespace specific page
which has the same layout as the VVAR page.

Co-developed-by: Andrei Vagin <avagin@gmail.com>
Signed-off-by: Andrei Vagin <avagin@gmail.com>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 arch/x86/entry/vdso/vma.c | 53 +++++++++++++++++++++++++++++++++++++--
 mm/mmap.c                 |  2 ++
 2 files changed, 53 insertions(+), 2 deletions(-)

diff --git a/arch/x86/entry/vdso/vma.c b/arch/x86/entry/vdso/vma.c
index 5dab706aca2e..f6e13ab29d94 100644
--- a/arch/x86/entry/vdso/vma.c
+++ b/arch/x86/entry/vdso/vma.c
@@ -14,11 +14,13 @@
 #include <linux/elf.h>
 #include <linux/cpu.h>
 #include <linux/ptrace.h>
+#include <linux/time_namespace.h>
 #include <asm/pvclock.h>
 #include <asm/vgtod.h>
 #include <asm/proto.h>
 #include <asm/vdso.h>
 #include <asm/vvar.h>
+#include <asm/tlb.h>
 #include <asm/page.h>
 #include <asm/desc.h>
 #include <asm/cpufeature.h>
@@ -107,10 +109,36 @@ static int vvar_mremap(const struct vm_special_mapping *sm,
 	return 0;
 }
 
+#ifdef CONFIG_TIME_NS
+static struct page *find_timens_vvar_page(struct vm_area_struct *vma)
+{
+	if (likely(vma->vm_mm == current->mm))
+		return current->nsproxy->time_ns->vvar_page;
+
+	/*
+	 * VM_PFNMAP | VM_IO protect .fault() handler from being called
+	 * through interfaces like /proc/$pid/mem or
+	 * process_vm_{readv,writev}() as long as there's no .access()
+	 * in special_mapping_vmops().
+	 * For more details check_vma_flags() and __access_remote_vm()
+	 */
+
+	WARN(1, "vvar_page accessed remotely");
+
+	return NULL;
+}
+#else
+static inline struct page *find_timens_vvar_page(struct vm_area_struct *vma)
+{
+	return NULL;
+}
+#endif
+
 static vm_fault_t vvar_fault(const struct vm_special_mapping *sm,
 		      struct vm_area_struct *vma, struct vm_fault *vmf)
 {
 	const struct vdso_image *image = vma->vm_mm->context.vdso_image;
+	unsigned long pfn;
 	long sym_offset;
 
 	if (!image)
@@ -130,8 +158,21 @@ static vm_fault_t vvar_fault(const struct vm_special_mapping *sm,
 		return VM_FAULT_SIGBUS;
 
 	if (sym_offset == image->sym_vvar_page) {
-		return vmf_insert_pfn(vma, vmf->address,
-				__pa_symbol(&__vvar_page) >> PAGE_SHIFT);
+		struct page *timens_page = find_timens_vvar_page(vma);
+
+		pfn = __pa_symbol(&__vvar_page) >> PAGE_SHIFT;
+
+		/*
+		 * If a task belongs to a time namespace then a namespace
+		 * specific VVAR is mapped with the sym_vvar_page offset and
+		 * the real VVAR page is mapped with the sym_timens_page
+		 * offset.
+		 * See also the comment near timens_setup_vdso_data().
+		 */
+		if (timens_page)
+			pfn = page_to_pfn(timens_page);
+
+		return vmf_insert_pfn(vma, vmf->address, pfn);
 	} else if (sym_offset == image->sym_pvclock_page) {
 		struct pvclock_vsyscall_time_info *pvti =
 			pvclock_get_pvti_cpu0_va();
@@ -146,6 +187,14 @@ static vm_fault_t vvar_fault(const struct vm_special_mapping *sm,
 		if (tsc_pg && vclock_was_used(VCLOCK_HVCLOCK))
 			return vmf_insert_pfn(vma, vmf->address,
 					virt_to_phys(tsc_pg) >> PAGE_SHIFT);
+	} else if (sym_offset == image->sym_timens_page) {
+		struct page *timens_page = find_timens_vvar_page(vma);
+
+		if (!timens_page)
+			return VM_FAULT_SIGBUS;
+
+		pfn = __pa_symbol(&__vvar_page) >> PAGE_SHIFT;
+		return vmf_insert_pfn(vma, vmf->address, pfn);
 	}
 
 	return VM_FAULT_SIGBUS;
diff --git a/mm/mmap.c b/mm/mmap.c
index a7d8c84d19b7..af722a47db3c 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -3363,6 +3363,8 @@ static const struct vm_operations_struct special_mapping_vmops = {
 	.fault = special_mapping_fault,
 	.mremap = special_mapping_mremap,
 	.name = special_mapping_name,
+	/* vDSO code relies that VVAR can't be accessed remotely */
+	.access = NULL,
 };
 
 static const struct vm_operations_struct legacy_special_mapping_vmops = {
-- 
2.23.0


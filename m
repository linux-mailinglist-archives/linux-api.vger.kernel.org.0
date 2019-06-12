Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2687843003
	for <lists+linux-api@lfdr.de>; Wed, 12 Jun 2019 21:27:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728910AbfFLT05 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 12 Jun 2019 15:26:57 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50568 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728818AbfFLT04 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 12 Jun 2019 15:26:56 -0400
Received: by mail-wm1-f66.google.com with SMTP id c66so7715047wmf.0
        for <linux-api@vger.kernel.org>; Wed, 12 Jun 2019 12:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XRp885uMdJAuEcfk6wtJl9pFzB2CTFcS76XeafSjAG0=;
        b=cgBypDFhuJcDvgJ3WfCUXJ4p2srOcYCtmlL+6uFeUK8ndgTjI2oa5/w6wWKXdkIxS3
         ehBJMYJjnYTTy1ak8qVT9aN+e6G8M7e1GF0L8qlWat67vX7x4rMP19sRgiyr3xsrl1wG
         iE0VeIIL+dwcFHU0fLTqhkN9DCqLsr6lokjrBR1ZVFEzrgDYC7yiRByQBQfAgDWoca98
         /KRZHLS2c2L/GEY2w57c9fI2XkElkHAzacYDLSZKCB8kbU2DAu3YfU0/ZEo3ce2DrA6G
         qhX9TnPEG1pZqxCl3AxaUWJYQZ4PVneftyyaqFa5qWEzh+TpKdaSLUmnAozjRxDBlVCR
         GqhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XRp885uMdJAuEcfk6wtJl9pFzB2CTFcS76XeafSjAG0=;
        b=AGeejoU1YfCbIcmy9vx8j9YubZD/AbstaCoC81Nhz8Wgdj44pkH6jfl0CNROIrMh1Y
         jMZo1hJVBOJMf+ivnlbRji9ipp0aTFCuv2uHun/2GzcqkUykNWKAmaGtNI8c2DKTFse6
         NCoEfkiawBjhw7eBRusdkCYHqfeDnmFXGh/vUiNEihU4WP8DXN2sK+SsMAbsKfDXtHmT
         lNNqoAGNItsNphr5TabXkl1dEyZRUe6m6QiTp4HoHw4jzJaAYGdLFKgux5xLR6gvTmHP
         NlQNYYpwtsEIAteU6dBP8MrUYlqRLnKoovkIkyMOuUQD+ec3WPz7+FXg6bCAAeZb8SfL
         KGXA==
X-Gm-Message-State: APjAAAXzrVdg2kqwwuKVMVYWKQnfAFme4p+4/m3u8O0Pf3VVEixlbB9p
        GebqoTeWh/JHLNhK6MvZpqrMkQ==
X-Google-Smtp-Source: APXvYqzUGCVDmc5eqnvclrAqsBL7OQbG1i0dwhsUMkIaidCFpYFdjiRURuI7F+Ni1zwbOyaMDND/Sw==
X-Received: by 2002:a1c:1b81:: with SMTP id b123mr521266wmb.144.1560367612994;
        Wed, 12 Jun 2019 12:26:52 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id r5sm612526wrg.10.2019.06.12.12.26.51
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 12 Jun 2019 12:26:52 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <dima@arista.com>, Adrian Reber <adrian@lisas.de>,
        Andrei Vagin <avagin@openvz.org>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jann Horn <jannh@google.com>, Jeff Dike <jdike@addtoit.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        containers@lists.linux-foundation.org, criu@openvz.org,
        linux-api@vger.kernel.org, x86@kernel.org
Subject: [PATCHv4 16/28] x86/vdso: Allocate timens vdso
Date:   Wed, 12 Jun 2019 20:26:15 +0100
Message-Id: <20190612192628.23797-17-dima@arista.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190612192628.23797-1-dima@arista.com>
References: <20190612192628.23797-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The propose is to allocate a second vdso code with dynamically
patched out (disabled by static_branch) timens code on boot time.

Allocate another vdso and copy original code.

Co-developed-by: Andrei Vagin <avagin@openvz.org>
Signed-off-by: Andrei Vagin <avagin@openvz.org>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 arch/x86/entry/vdso/vdso2c.h |   2 +-
 arch/x86/entry/vdso/vma.c    | 113 +++++++++++++++++++++++++++++++++--
 arch/x86/include/asm/vdso.h  |   9 +--
 3 files changed, 114 insertions(+), 10 deletions(-)

diff --git a/arch/x86/entry/vdso/vdso2c.h b/arch/x86/entry/vdso/vdso2c.h
index 7556bb70ed8b..885b988aea19 100644
--- a/arch/x86/entry/vdso/vdso2c.h
+++ b/arch/x86/entry/vdso/vdso2c.h
@@ -157,7 +157,7 @@ static void BITSFUNC(go)(void *raw_addr, size_t raw_len,
 	}
 	fprintf(outfile, "\n};\n\n");
 
-	fprintf(outfile, "const struct vdso_image %s = {\n", image_name);
+	fprintf(outfile, "struct vdso_image %s __ro_after_init = {\n", image_name);
 	fprintf(outfile, "\t.text = raw_data,\n");
 	fprintf(outfile, "\t.size = %lu,\n", mapping_size);
 	if (alt_sec) {
diff --git a/arch/x86/entry/vdso/vma.c b/arch/x86/entry/vdso/vma.c
index 8a7f4cfe1fad..cc06c6b70167 100644
--- a/arch/x86/entry/vdso/vma.c
+++ b/arch/x86/entry/vdso/vma.c
@@ -30,26 +30,128 @@
 unsigned int __read_mostly vdso64_enabled = 1;
 #endif
 
-void __init init_vdso_image(const struct vdso_image *image)
+void __init init_vdso_image(struct vdso_image *image)
 {
 	BUG_ON(image->size % PAGE_SIZE != 0);
 
 	apply_alternatives((struct alt_instr *)(image->text + image->alt),
 			   (struct alt_instr *)(image->text + image->alt +
 						image->alt_len));
+#ifdef CONFIG_TIME_NS
+	image->text_timens = vmalloc_32(image->size);
+	if (WARN_ON(image->text_timens == NULL))
+		return;
+
+	memcpy(image->text_timens, image->text, image->size);
+#endif
 }
 
 struct linux_binprm;
 
+#ifdef CONFIG_TIME_NS
+static inline struct timens_offsets *current_timens_offsets(void)
+{
+	return current->nsproxy->time_ns->offsets;
+}
+
+static int vdso_check_timens(struct vm_area_struct *vma, bool *in_timens)
+{
+	struct task_struct *tsk;
+
+	if (likely(vma->vm_mm == current->mm)) {
+		*in_timens = !!current_timens_offsets();
+		return 0;
+	}
+
+	/*
+	 * .fault() handler can be called over remote process through
+	 * interfaces like /proc/$pid/mem or process_vm_{readv,writev}()
+	 * Considering such access to vdso as a slow-path.
+	 */
+
+#ifdef CONFIG_MEMCG
+	rcu_read_lock();
+
+	tsk = rcu_dereference(vma->vm_mm->owner);
+	if (tsk) {
+		task_lock(tsk);
+		/*
+		 * Shouldn't happen: nsproxy is unset in exit_mm().
+		 * Before that exit_mm() holds mmap_sem to set (mm = NULL).
+		 * It's impossible to have a fault in task without mm
+		 * and mmap_sem is taken during the fault.
+		 */
+		if (WARN_ON_ONCE(tsk->nsproxy == NULL)) {
+			task_unlock(tsk);
+			rcu_read_unlock();
+			return -EIO;
+		}
+		*in_timens = !!tsk->nsproxy->time_ns->offsets;
+		task_unlock(tsk);
+		rcu_read_unlock();
+		return 0;
+	}
+	rcu_read_unlock();
+#endif
+
+	read_lock(&tasklist_lock);
+	for_each_process(tsk) {
+		struct task_struct *c;
+
+		if (tsk->flags & PF_KTHREAD)
+			continue;
+		for_each_thread(tsk, c) {
+			if (c->mm == vma->vm_mm)
+				goto found;
+			if (c->mm)
+				break;
+		}
+	}
+	read_unlock(&tasklist_lock);
+	return -ESRCH;
+
+found:
+	task_lock(tsk);
+	read_unlock(&tasklist_lock);
+	*in_timens = !!tsk->nsproxy->time_ns->offsets;
+	task_unlock(tsk);
+
+	return 0;
+}
+#else /* CONFIG_TIME_NS */
+static inline int vdso_check_timens(struct vm_area_struct *vma, bool *in_timens)
+{
+	*in_timens = false;
+	return 0;
+}
+static inline struct timens_offsets *current_timens_offsets(void)
+{
+	return NULL;
+}
+#endif /* CONFIG_TIME_NS */
+
 static vm_fault_t vdso_fault(const struct vm_special_mapping *sm,
 		      struct vm_area_struct *vma, struct vm_fault *vmf)
 {
 	const struct vdso_image *image = vma->vm_mm->context.vdso_image;
+	unsigned long offset = vmf->pgoff << PAGE_SHIFT;
+	bool in_timens;
+	int err;
 
 	if (!image || (vmf->pgoff << PAGE_SHIFT) >= image->size)
 		return VM_FAULT_SIGBUS;
 
-	vmf->page = virt_to_page(image->text + (vmf->pgoff << PAGE_SHIFT));
+	err = vdso_check_timens(vma, &in_timens);
+	if (err)
+		return VM_FAULT_SIGBUS;
+
+	WARN_ON_ONCE(in_timens && !image->text_timens);
+
+	if (in_timens && image->text_timens)
+		vmf->page = vmalloc_to_page(image->text_timens + offset);
+	else
+		vmf->page = virt_to_page(image->text + offset);
+
 	get_page(vmf->page);
 	return 0;
 }
@@ -138,13 +240,14 @@ static vm_fault_t vvar_fault(const struct vm_special_mapping *sm,
 			return vmf_insert_pfn(vma, vmf->address,
 					vmalloc_to_pfn(tsc_pg));
 	} else if (sym_offset == image->sym_timens_page) {
-		struct time_namespace *ns = current->nsproxy->time_ns;
+		/* We can fault only in current context for VM_PFNMAP mapping */
+		struct timens_offsets *offsets = current_timens_offsets();
 		unsigned long pfn;
 
-		if (!ns->offsets)
+		if (!offsets)
 			pfn = page_to_pfn(ZERO_PAGE(0));
 		else
-			pfn = page_to_pfn(virt_to_page(ns->offsets));
+			pfn = page_to_pfn(virt_to_page(offsets));
 
 		return vmf_insert_pfn(vma, vmf->address, pfn);
 	}
diff --git a/arch/x86/include/asm/vdso.h b/arch/x86/include/asm/vdso.h
index 9d420c545607..03f468c63a24 100644
--- a/arch/x86/include/asm/vdso.h
+++ b/arch/x86/include/asm/vdso.h
@@ -12,6 +12,7 @@
 
 struct vdso_image {
 	void *text;
+	void *text_timens;
 	unsigned long size;   /* Always a multiple of PAGE_SIZE */
 
 	unsigned long alt, alt_len;
@@ -30,18 +31,18 @@ struct vdso_image {
 };
 
 #ifdef CONFIG_X86_64
-extern const struct vdso_image vdso_image_64;
+extern struct vdso_image vdso_image_64;
 #endif
 
 #ifdef CONFIG_X86_X32
-extern const struct vdso_image vdso_image_x32;
+extern struct vdso_image vdso_image_x32;
 #endif
 
 #if defined CONFIG_X86_32 || defined CONFIG_COMPAT
-extern const struct vdso_image vdso_image_32;
+extern struct vdso_image vdso_image_32;
 #endif
 
-extern void __init init_vdso_image(const struct vdso_image *image);
+extern void __init init_vdso_image(struct vdso_image *image);
 
 extern int map_vdso_once(const struct vdso_image *image, unsigned long addr);
 
-- 
2.22.0


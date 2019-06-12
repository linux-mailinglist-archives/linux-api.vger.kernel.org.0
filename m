Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4967842FED
	for <lists+linux-api@lfdr.de>; Wed, 12 Jun 2019 21:27:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728923AbfFLT05 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 12 Jun 2019 15:26:57 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35137 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728845AbfFLT05 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 12 Jun 2019 15:26:57 -0400
Received: by mail-wr1-f65.google.com with SMTP id m3so18175109wrv.2
        for <linux-api@vger.kernel.org>; Wed, 12 Jun 2019 12:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KpgdAMMCHnPQrDnLWhMZsDPSXUfV6qkEmWfI7FzOlUQ=;
        b=keqEN34JtTtVA7NKymgP2DYb/nFo9R+KJ9voJ+K1mUldzJgJNdwdmfRFevkx3wbtpQ
         y+Z5h2YHYMTjI9RXifQ3Bz/iSKaJz0wuKmf4g60pyj6dJlt+qK+u3akwpE/HN+9l+TYH
         agKbQaN4gwFB5g65iMOmWJxyxwl+SkzNXpCmytzc5dC+miFRJod47pkvdP+0Ll45Js9Q
         vgPkatnJslN5IedjjLpV2IY6sRQx7GmPqakvVlcsc/bJiI7/w9A/Es0NteCl+SOVI79C
         lCsCAk3OdZhsklHsd9mn8zBQKbrgpreITVC+cJprWx9zdla4GgGN+E40qMK65hKT7kcX
         od/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KpgdAMMCHnPQrDnLWhMZsDPSXUfV6qkEmWfI7FzOlUQ=;
        b=Q/jp+qQEgIkxC+/bETom9AlwU0VJlisS10uLXJlILJIaRLFJ1uOtahOEPhyZ3HuTu0
         3Syslh3plPLyYZH3x0Yla6be8S46LRYx5pST3gci5jtEGsEkMSev8MpQE7onvRBSsg8v
         us+y/XT6F6dF46BDS2JOwIpTYngBsWF3csDkrlMTBDRMssTmb7VvbXokZIfltLhrQbmC
         82P7k8FtwSabLUvKGAy68TZxZ3YXa69ZLMIm4xwkvOHkPJzR8wgvBnV8N9vCi9UiosX4
         BxyCTrwjXX5H910ZJn5Xcwzro+BoX5axash7Dk7186W6LtyP57dtbZZHQjq7jnSjJYEK
         y0rg==
X-Gm-Message-State: APjAAAVTSJgYrMon6IXVGeQPEITApEK0o9qDvAGU07Akm/eznNnv/ltx
        FtEGQdoTDxE0TMrLq6uFGF24Qg==
X-Google-Smtp-Source: APXvYqw3oH/hLJ/mRBSulnvkir8RqsRXYTcoktY1T8F1V0GbvrLnAvvPebR0hcKcDXuF6mscRQCoHg==
X-Received: by 2002:a5d:52cc:: with SMTP id r12mr16812548wrv.132.1560367614492;
        Wed, 12 Jun 2019 12:26:54 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id r5sm612526wrg.10.2019.06.12.12.26.53
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 12 Jun 2019 12:26:53 -0700 (PDT)
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
        linux-api@vger.kernel.org, x86@kernel.org,
        Andrei Vagin <avagin@gmail.com>
Subject: [PATCHv4 17/28] x86/vdso: Switch image on setns()/unshare()/clone()
Date:   Wed, 12 Jun 2019 20:26:16 +0100
Message-Id: <20190612192628.23797-18-dima@arista.com>
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

Addressing those problems, there are two versions of VDSO's .so:
for host tasks (without any penalty) and for processes inside of time
namespace with clk_to_ns() that subtracts offsets from host's time.

Whenever a user does setns()/unshare() or clone() with CLONE_TIMENS,
change VDSO image in mm and zap existing VVAR/VDSO page tables.
They will be re-faulted with corresponding image and VVAR offsets.

Co-developed-by: Andrei Vagin <avagin@gmail.com>
Signed-off-by: Andrei Vagin <avagin@gmail.com>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 arch/x86/entry/vdso/vma.c   | 28 ++++++++++++++++++++++++++++
 arch/x86/include/asm/vdso.h |  1 +
 kernel/time_namespace.c     | 11 +++++++++++
 3 files changed, 40 insertions(+)

diff --git a/arch/x86/entry/vdso/vma.c b/arch/x86/entry/vdso/vma.c
index cc06c6b70167..3ed5bf4932af 100644
--- a/arch/x86/entry/vdso/vma.c
+++ b/arch/x86/entry/vdso/vma.c
@@ -25,6 +25,7 @@
 #include <asm/cpufeature.h>
 #include <asm/mshyperv.h>
 #include <asm/page.h>
+#include <asm/tlb.h>
 
 #if defined(CONFIG_X86_64)
 unsigned int __read_mostly vdso64_enabled = 1;
@@ -266,6 +267,33 @@ static const struct vm_special_mapping vvar_mapping = {
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
+#else /* CONFIG_TIME_NS */
+int vdso_join_timens(struct task_struct *task)
+{
+	return -ENXIO;
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
index b3cffdf2635c..2a2cab14ac29 100644
--- a/kernel/time_namespace.c
+++ b/kernel/time_namespace.c
@@ -14,6 +14,7 @@
 #include <linux/proc_ns.h>
 #include <linux/sched/task.h>
 #include <linux/mm.h>
+#include <asm/vdso.h>
 
 ktime_t do_timens_ktime_to_host(clockid_t clockid, ktime_t tim, struct timens_offsets *ns_offsets)
 {
@@ -182,11 +183,16 @@ static void timens_put(struct ns_common *ns)
 static int timens_install(struct nsproxy *nsproxy, struct ns_common *new)
 {
 	struct time_namespace *ns = to_time_ns(new);
+	int ret;
 
 	if (!ns_capable(ns->user_ns, CAP_SYS_ADMIN) ||
 	    !ns_capable(current_user_ns(), CAP_SYS_ADMIN))
 		return -EPERM;
 
+	ret = vdso_join_timens(current);
+	if (ret)
+		return ret;
+
 	get_time_ns(ns);
 	get_time_ns(ns);
 	put_time_ns(nsproxy->time_ns);
@@ -201,10 +207,15 @@ int timens_on_fork(struct nsproxy *nsproxy, struct task_struct *tsk)
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


Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D74718F0D3
	for <lists+linux-api@lfdr.de>; Thu, 15 Aug 2019 18:39:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732466AbfHOQjR (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 15 Aug 2019 12:39:17 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40854 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732478AbfHOQjQ (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 15 Aug 2019 12:39:16 -0400
Received: by mail-wm1-f67.google.com with SMTP id v19so1776992wmj.5
        for <linux-api@vger.kernel.org>; Thu, 15 Aug 2019 09:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=r/9uyT+mnIHOaH/ccTtg/Nxut5gT2ypiz9lprU+hrks=;
        b=MYDLo6I1xHd/KR1Jq+sZWa0ONwa92tRKpvfI4g25iKa2lvx2eFR7GcGlcJUhrNEkkH
         fgSqPDxBa7YWh8Wjvi5A2KVO9M1toYcNRqwY9ORUantp3/6NvYW2ivpFAcm5lVCLCYfh
         Pxy4X68e1Hco+Tuz3TJpDXgxDFY9R9nNvlnWPcror/fXPTALT8M0G4IJgIw5f+V1k1vH
         HptVNegpIx+XaYA4kJcQwLPiuhmppOsm4p8OSFLPBFb1g8cKPaNtANUKLEalke7azxAu
         +jYnnJxROTsSpEcy2VgV8e1eIcJrf55SRUTiuo4dVOQRL3YpM1mcSPBDGcbNoiE0r8+c
         PsBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=r/9uyT+mnIHOaH/ccTtg/Nxut5gT2ypiz9lprU+hrks=;
        b=rZLO4Cmd37aSCwVquB02ZQvSA1ZuLLKjnjY7kqGUlxlLsAaKQLoxsCObNpUnHfhenb
         jbKfmEX4EVdR0DcgXmEbjhhZuVHyEMXhgfyFjgUlFWlOs7f8TQtwDrMYGTWWc2gn1o4n
         6Zxjxprk/hDzy+NBAjHmpq1coZO0eOioScEeDRAXvGZvFWNDUTr5l47Ib7DJsBg3X6Nx
         0igfZZ8iChFrrYRee4r2OXphVFXtvgQ2f0Y0PDtHuvUZu+u+NZoiqglnGqulnpr0aoPt
         XbRVEJI/dV8pVY/V6SBUpCPHUzGiK/1+G6Er/xmbhFtNNmeHDEWoddU1uGClAsGy3KmA
         NLaQ==
X-Gm-Message-State: APjAAAVby1/70A5oN7b5c5DTEcqhkarMF8sVBnzgDnk9pTjqjZP/g2nw
        Eukq0nJs3LFsTk/Vkjusi+sYdg==
X-Google-Smtp-Source: APXvYqyaeGx4F4ZKjGtGiS1uS8X/cbv+de31lrxL5NVHQopePXSDhQC7FYVLZjy5ytMpTUbCFIFDzw==
X-Received: by 2002:a1c:9d53:: with SMTP id g80mr3599678wme.103.1565887154182;
        Thu, 15 Aug 2019 09:39:14 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id f7sm5755046wrf.8.2019.08.15.09.39.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2019 09:39:11 -0700 (PDT)
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
Subject: [PATCHv6 24/36] x86/vdso: Switch image on setns()/clone()
Date:   Thu, 15 Aug 2019 17:38:24 +0100
Message-Id: <20190815163836.2927-25-dima@arista.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190815163836.2927-1-dima@arista.com>
References: <20190815163836.2927-1-dima@arista.com>
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

Whenever a user does setns() or unshare(CLONE_TIMENS) followed
by clone(), change VDSO image in mm and zap VVAR/VDSO page tables.
They will be re-faulted with corresponding image and VVAR offsets.

Co-developed-by: Andrei Vagin <avagin@gmail.com>
Signed-off-by: Andrei Vagin <avagin@gmail.com>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
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
index ff2c5de7e815..a01c25fe76d5 100644
--- a/kernel/time_namespace.c
+++ b/kernel/time_namespace.c
@@ -15,6 +15,7 @@
 #include <linux/cred.h>
 #include <linux/err.h>
 #include <linux/mm.h>
+#include <asm/vdso.h>
 
 ktime_t do_timens_ktime_to_host(clockid_t clockid, ktime_t tim,
 				struct timens_offsets *ns_offsets)
@@ -201,6 +202,7 @@ static void timens_put(struct ns_common *ns)
 static int timens_install(struct nsproxy *nsproxy, struct ns_common *new)
 {
 	struct time_namespace *ns = to_time_ns(new);
+	int ret;
 
 	if (!current_is_single_threaded())
 		return -EUSERS;
@@ -209,6 +211,10 @@ static int timens_install(struct nsproxy *nsproxy, struct ns_common *new)
 	    !ns_capable(current_user_ns(), CAP_SYS_ADMIN))
 		return -EPERM;
 
+	ret = vdso_join_timens(current);
+	if (ret)
+		return ret;
+
 	get_time_ns(ns);
 	get_time_ns(ns);
 	put_time_ns(nsproxy->time_ns);
@@ -223,10 +229,15 @@ int timens_on_fork(struct nsproxy *nsproxy, struct task_struct *tsk)
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


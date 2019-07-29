Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B16B779BBE
	for <lists+linux-api@lfdr.de>; Tue, 30 Jul 2019 00:00:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730415AbfG2V6h (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 29 Jul 2019 17:58:37 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34691 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730347AbfG2V6h (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 29 Jul 2019 17:58:37 -0400
Received: by mail-wr1-f66.google.com with SMTP id 31so63499087wrm.1
        for <linux-api@vger.kernel.org>; Mon, 29 Jul 2019 14:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fidQOr6jX0NXgsvarGBS4A7gX8P5kq+zzTOArYA4KeA=;
        b=nLWubxdHInBQUDMiN7R7Cj6+z7qNYuvYyuA7XYH54vmSY0hYmCheX1BTI80aQRAaPr
         V+1IUEqRVDQW/0DDJMGUOEH4PUrwPWICTVKzsk094UyTA5xPM8O19rIEP4pL6kt5vHCK
         /77H4BU9MhWzYe8Eluo5Ar63vWQyLvQmzx5lCpZUB+kl8XVzKv5kt/O9sCQPO8dKN2Ab
         KHRdfTdmu6pgeGVhDngfCgmq2pdKeD22ywFDkuso3oVb22PMsY7KSDoDi2DSx0WU18VN
         +ZnmurCCsrpci7A440cvle2FntYxwpRJyMnTs6MGHe3Ly70G6Hsy52DtehPsC3idMunV
         FGYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fidQOr6jX0NXgsvarGBS4A7gX8P5kq+zzTOArYA4KeA=;
        b=OLYXTwYBtX83BKPQOL3sS0BWlFs7iuEluZqCWU6QIOLIpdKFLNae36XyeA6ZaQJSHn
         a+zj0Im403Crjj8s438elK5VU4/K3k3Aua0XWbTkvtREBdWaUfpUXcz8jsEf4GstLWfd
         FnUsrkT2WrxgiulfzbszODP7jbWq0m9zjdZcw/PqsHR40rM+yITPDTzBRtETJPXBoD8C
         kKvteASTtujQFuZDiL4K8Ys2m5iMmBnC1lflaVM1+OCeJ6eoi/EseI1I7SG/0kQ1wazI
         FMOM4a3wIQpNvG8oGSRBIj6hso09sbx9vnXVMqwUNnrocCnvyn9aEBpfG6o6rfpL55v+
         Kqig==
X-Gm-Message-State: APjAAAW4lUlAnQ4S4aAwLqzL1mfTJVYznm01z1am779wTqJie/ANgpSk
        23Fd3LN/QtLJ3Pq2r3GxB77wPckwloEVJvRuP3mb87v4rUvOaQDn4saZ0tf8AtYIsw1fGP/qkjG
        HUu9nrSEvBqgvQFsbHZ0eCc+CupER2n8XPjl7vSybPCO1AEujgP13ErqekdPcvhUvZp4zhchf1s
        xhiu8FiWq2YjcQAqkrrK9arPQrFQ==
X-Google-Smtp-Source: APXvYqwl+tpd/ttJU7lU16shUU1od0XIOAoEfPw1I5Kh+YUBNQ3niNi9ZFqW7glSRn0uTti930YiKw==
X-Received: by 2002:a5d:5386:: with SMTP id d6mr20012069wrv.207.1564437514945;
        Mon, 29 Jul 2019 14:58:34 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id x20sm49230728wmc.1.2019.07.29.14.58.33
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 29 Jul 2019 14:58:34 -0700 (PDT)
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
Subject: [PATCHv5 25/37] x86/vdso: Switch image on setns()/clone()
Date:   Mon, 29 Jul 2019 22:57:07 +0100
Message-Id: <20190729215758.28405-26-dima@arista.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190729215758.28405-1-dima@arista.com>
References: <20190729215758.28405-1-dima@arista.com>
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
index 9807c5c90cb2..4b2eb92ad595 100644
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
 
 	if (!thread_group_empty(current))
 		return -EINVAL;
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


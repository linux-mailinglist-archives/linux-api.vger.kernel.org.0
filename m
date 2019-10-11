Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 51A32D371C
	for <lists+linux-api@lfdr.de>; Fri, 11 Oct 2019 03:30:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728378AbfJKBZD (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 10 Oct 2019 21:25:03 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53588 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728239AbfJKBYZ (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 10 Oct 2019 21:24:25 -0400
Received: by mail-wm1-f65.google.com with SMTP id i16so8688288wmd.3
        for <linux-api@vger.kernel.org>; Thu, 10 Oct 2019 18:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gWD0ajueU3FDZugFOeZjcuv8DzQScIgD3lk4LddX0o0=;
        b=EhcGaFKYu218GQzSN/qZhWvFpix+VaufF9g+EZNmmiCDUnuO0vUw4GvIPdOPE8FOCB
         el7ZfzJwXT0tUV0pELO7ZUfUuXCer6YUVxCGH16my851zEWcBJcWE62P6IMus4ddnggb
         DEJqUNgY7nV7hkPNdj83DNUcQ7zBrl8TC29sjPYGGw53BFsdZDi/1S9tnpORZ4bEqv6w
         7Bc8rDvZRgVBgd5tbBovpUtXew9lMC6GkZF6x5TSceo9LhKwbfo7iEPzv9sK9zwTvDC7
         q6nBlxZul6lqD0abv9A0axw/EfMou/IDI91CjVQL1o/SGw4Ko/kYQCHdICmoIlGqwLOQ
         1AmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gWD0ajueU3FDZugFOeZjcuv8DzQScIgD3lk4LddX0o0=;
        b=TfAXLh4NBJmy1fCm2Ftn35Use0U6/tUDEe/ZBunbbrVsSMilzda12tw6Xx02Op7Yh4
         vx88ROxWWqODD485d6824JuwhyvT6CWjOFnUSHMTtRr5Glt8h8rl0rPnfX/yY/68edR2
         M9BYZIr9nnIQO/KmWAEGRl98mdPrAVMHQD+EeQp9s/sipRpg0WFjft972hkhgjeX5Cro
         LaJneN9Cyk1cEpHStwMUcw7yAc4NnAspFS/7L5leoOGSFcg+BD2rBgpa4cUwZSBoCFnt
         ZtqsWhazS7xMyC16VYIxYeALO0SQjOmi/ajp9/v8wAMDmr6mvx6o6JqUm37+Oqpg5HGU
         rEyA==
X-Gm-Message-State: APjAAAVLyVhTpfsaNu6z1ryw6X0LzPkS5YhcfHrU0f/bdMD86ailL/NU
        ryxMmxtzHP+AqmzsUh9MVknuYA==
X-Google-Smtp-Source: APXvYqyZbqU/RKBZIpBR6d31fGxswiRSAKkGg3hbg5igkpPVS7ppB+tsdItS7JKB0oBlnmSzkfAP3A==
X-Received: by 2002:a1c:bc07:: with SMTP id m7mr958262wmf.103.1570757063384;
        Thu, 10 Oct 2019 18:24:23 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8084:ea2:c100:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id l13sm7699795wmj.25.2019.10.10.18.24.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2019 18:24:22 -0700 (PDT)
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
Subject: [PATCHv7 25/33] x86/vdso: Zap vvar pages on switch a time namspace
Date:   Fri, 11 Oct 2019 02:23:33 +0100
Message-Id: <20191011012341.846266-26-dima@arista.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191011012341.846266-1-dima@arista.com>
References: <20191011012341.846266-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

The VVAR page layout depends on whether a task belongs to the root or
non-root time namespace. Whenever a task changes its namespace, the VVAR
page tables are cleared and then they will re-faulted with a
corresponding layout.

Co-developed-by: Andrei Vagin <avagin@gmail.com>
Signed-off-by: Andrei Vagin <avagin@gmail.com>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 arch/x86/entry/vdso/vma.c      | 27 +++++++++++++++++++++++++++
 include/linux/time_namespace.h |  3 +++
 kernel/time/namespace.c        | 10 ++++++++++
 3 files changed, 40 insertions(+)

diff --git a/arch/x86/entry/vdso/vma.c b/arch/x86/entry/vdso/vma.c
index d6cb8a16f368..57ada3e95f8d 100644
--- a/arch/x86/entry/vdso/vma.c
+++ b/arch/x86/entry/vdso/vma.c
@@ -50,6 +50,7 @@ void __init init_vdso_image(const struct vdso_image *image)
 						image->alt_len));
 }
 
+static const struct vm_special_mapping vvar_mapping;
 struct linux_binprm;
 
 static vm_fault_t vdso_fault(const struct vm_special_mapping *sm,
@@ -127,6 +128,32 @@ static struct page *find_timens_vvar_page(struct vm_area_struct *vma)
 
 	return NULL;
 }
+
+/*
+ * The vvar page layout depends on whether a task belongs to the root or
+ * non-root time namespace. Whenever a task changes its namespace, the VVAR
+ * page tables are cleared and then they will re-faulted with a
+ * corresponding layout.
+ * See also the comment near timens_setup_vdso_data() for details.
+ */
+int vdso_join_timens(struct task_struct *task, struct time_namespace *ns)
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
+		if (vma_is_special_mapping(vma, &vvar_mapping))
+			zap_page_range(vma, vma->vm_start, size);
+	}
+
+	up_write(&mm->mmap_sem);
+	return 0;
+}
 #else
 static inline struct page *find_timens_vvar_page(struct vm_area_struct *vma)
 {
diff --git a/include/linux/time_namespace.h b/include/linux/time_namespace.h
index c479cfda2c3e..dcf3dbf2836b 100644
--- a/include/linux/time_namespace.h
+++ b/include/linux/time_namespace.h
@@ -30,6 +30,9 @@ struct time_namespace {
 extern struct time_namespace init_time_ns;
 
 #ifdef CONFIG_TIME_NS
+extern int vdso_join_timens(struct task_struct *task,
+			    struct time_namespace *ns);
+
 static inline struct time_namespace *get_time_ns(struct time_namespace *ns)
 {
 	kref_get(&ns->kref);
diff --git a/kernel/time/namespace.c b/kernel/time/namespace.c
index e14cd1ca387d..0dc0742ed1ee 100644
--- a/kernel/time/namespace.c
+++ b/kernel/time/namespace.c
@@ -280,6 +280,7 @@ static void timens_put(struct ns_common *ns)
 static int timens_install(struct nsproxy *nsproxy, struct ns_common *new)
 {
 	struct time_namespace *ns = to_time_ns(new);
+	int err;
 
 	if (!current_is_single_threaded())
 		return -EUSERS;
@@ -290,6 +291,10 @@ static int timens_install(struct nsproxy *nsproxy, struct ns_common *new)
 
 	timens_set_vvar_page(current, ns);
 
+	err = vdso_join_timens(current, ns);
+	if (err)
+		return err;
+
 	get_time_ns(ns);
 	put_time_ns(nsproxy->time_ns);
 	nsproxy->time_ns = ns;
@@ -304,6 +309,7 @@ int timens_on_fork(struct nsproxy *nsproxy, struct task_struct *tsk)
 {
 	struct ns_common *nsc = &nsproxy->time_ns_for_children->ns;
 	struct time_namespace *ns = to_time_ns(nsc);
+	int err;
 
 	/* create_new_namespaces() already incremented the ref counter */
 	if (nsproxy->time_ns == nsproxy->time_ns_for_children)
@@ -311,6 +317,10 @@ int timens_on_fork(struct nsproxy *nsproxy, struct task_struct *tsk)
 
 	timens_set_vvar_page(tsk, ns);
 
+	err = vdso_join_timens(tsk, ns);
+	if (err)
+		return err;
+
 	get_time_ns(ns);
 	put_time_ns(nsproxy->time_ns);
 	nsproxy->time_ns = ns;
-- 
2.23.0


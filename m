Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C71056D4F4
	for <lists+linux-api@lfdr.de>; Thu, 18 Jul 2019 21:47:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391333AbfGRToX (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 18 Jul 2019 15:44:23 -0400
Received: from mail-pg1-f201.google.com ([209.85.215.201]:47443 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391319AbfGRToW (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 18 Jul 2019 15:44:22 -0400
Received: by mail-pg1-f201.google.com with SMTP id o19so17211368pgl.14
        for <linux-api@vger.kernel.org>; Thu, 18 Jul 2019 12:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=597mNbti9AE4jskQLQ5sdKqhsrWUg3noqnu7lsx00Ik=;
        b=ZkbTGs7FpCCiRrttiRilxiosF826QIW9kfAEaMUPuIIsni9gHspwmsJZINkI68V1h+
         thby5knIHW5YcyoqCtJTb28itY6d4hcSzENtydyHVroBQPbRu5BDoYVVNE9cD46wMWvC
         +Ds1ahXGoXfrchTMurL0hVloEDiYdIsBPqw/lZef45ZqW+QAsGyd+tD+Ksk6OxWbnRr9
         s4QFsT1vI+rA6XNKsTFnpILQZgUtcf3RnYdK+jYdpErSbDlB1BZhDxxbLbzdHtOFv4+w
         NdD0YMfgj2C/se3LHFetW4Zb+7rs60QWm2t7nDKuPII9tZvkOc9iCGzEcoAvACnBvA40
         A6TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=597mNbti9AE4jskQLQ5sdKqhsrWUg3noqnu7lsx00Ik=;
        b=P/qZggvzK41gd7MDkbixAq2423pfHnHf0I87CsIEQOEMi+F7emFLmAGfn/bWwOuBfi
         J+fKVQmKgtD5hKhDtjIoi7VzXs+75Ni0f1trnyVMVg+YeslGF50i43EGaeap8qS7q9gT
         87S5SPRToKM3I/+VWARAd7OFmudHmMTFG9NkH256ZzOU8/EmxWs391idebWaQwrgf07w
         GWiFQpif2OIEWgAzDJLZvEntchGPBE1aFh9beQzVXBXxRXEYZo3/uYpmEQ8dgmKwWsqS
         ivn85xaxR94Q9g06ieScze4skWxzD9H28VxbhDN09gkOkNtJk1x64mbaK3ac7boK2/hH
         c0PQ==
X-Gm-Message-State: APjAAAVyLf6sDxCAMWLSVgb/4/0aYnuu8yA6FQTQ5CvFFnpWPvDtydmi
        JwxZy3dID9BuCTrkla9RMLS4OL2Wx9SeNz6/S5cXeg==
X-Google-Smtp-Source: APXvYqxC8oXMhGBSsruKuBX7m7e9PA7Cmox+WxmN9bWO2QCRGCC8FVz1afN0q1rtFmZ+/IoG9TgL/daj+aJpQTz6+ZTZyA==
X-Received: by 2002:a65:464d:: with SMTP id k13mr44644813pgr.99.1563479061158;
 Thu, 18 Jul 2019 12:44:21 -0700 (PDT)
Date:   Thu, 18 Jul 2019 12:43:47 -0700
In-Reply-To: <20190718194415.108476-1-matthewgarrett@google.com>
Message-Id: <20190718194415.108476-2-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190718194415.108476-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.22.0.510.g264f2c817a-goog
Subject: [PATCH V36 01/29] security: Support early LSMs
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Matthew Garrett <matthewgarrett@google.com>,
        Matthew Garrett <mjg59@google.com>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

The lockdown module is intended to allow for kernels to be locked down
early in boot - sufficiently early that we don't have the ability to
kmalloc() yet. Add support for early initialisation of some LSMs, and
then add them to the list of names when we do full initialisation later.
Early LSMs are initialised in link order and cannot be overridden via
boot parameters, and cannot make use of kmalloc() (since the allocator
isn't initialised yet).

Signed-off-by: Matthew Garrett <mjg59@google.com>
Acked-by: Kees Cook <keescook@chromium.org>
---
 include/asm-generic/vmlinux.lds.h |  8 ++++-
 include/linux/lsm_hooks.h         |  6 ++++
 include/linux/security.h          |  1 +
 init/main.c                       |  1 +
 security/security.c               | 50 ++++++++++++++++++++++++++-----
 5 files changed, 57 insertions(+), 9 deletions(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index ca42182992a5..6cc6174a2a4c 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -215,8 +215,13 @@
 			__start_lsm_info = .;				\
 			KEEP(*(.lsm_info.init))				\
 			__end_lsm_info = .;
+#define EARLY_LSM_TABLE()	. = ALIGN(8);				\
+			__start_early_lsm_info = .;			\
+			KEEP(*(.early_lsm_info.init))			\
+			__end_early_lsm_info = .;
 #else
 #define LSM_TABLE()
+#define EARLY_LSM_TABLE()
 #endif
 
 #define ___OF_TABLE(cfg, name)	_OF_TABLE_##cfg(name)
@@ -616,7 +621,8 @@
 	ACPI_PROBE_TABLE(irqchip)					\
 	ACPI_PROBE_TABLE(timer)						\
 	EARLYCON_TABLE()						\
-	LSM_TABLE()
+	LSM_TABLE()							\
+	EARLY_LSM_TABLE()
 
 #define INIT_TEXT							\
 	*(.init.text .init.text.*)					\
diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index df1318d85f7d..aebb0e032072 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -2104,12 +2104,18 @@ struct lsm_info {
 };
 
 extern struct lsm_info __start_lsm_info[], __end_lsm_info[];
+extern struct lsm_info __start_early_lsm_info[], __end_early_lsm_info[];
 
 #define DEFINE_LSM(lsm)							\
 	static struct lsm_info __lsm_##lsm				\
 		__used __section(.lsm_info.init)			\
 		__aligned(sizeof(unsigned long))
 
+#define DEFINE_EARLY_LSM(lsm)						\
+	static struct lsm_info __early_lsm_##lsm			\
+		__used __section(.early_lsm_info.init)			\
+		__aligned(sizeof(unsigned long))
+
 #ifdef CONFIG_SECURITY_SELINUX_DISABLE
 /*
  * Assuring the safety of deleting a security module is up to
diff --git a/include/linux/security.h b/include/linux/security.h
index 5f7441abbf42..66a2fcbe6ab0 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -195,6 +195,7 @@ int unregister_blocking_lsm_notifier(struct notifier_block *nb);
 
 /* prototypes */
 extern int security_init(void);
+extern int early_security_init(void);
 
 /* Security operations */
 int security_binder_set_context_mgr(struct task_struct *mgr);
diff --git a/init/main.c b/init/main.c
index ff5803b0841c..0fefca3fd43c 100644
--- a/init/main.c
+++ b/init/main.c
@@ -593,6 +593,7 @@ asmlinkage __visible void __init start_kernel(void)
 	boot_cpu_init();
 	page_address_init();
 	pr_notice("%s", linux_banner);
+	early_security_init();
 	setup_arch(&command_line);
 	mm_init_cpumask(&init_mm);
 	setup_command_line(command_line);
diff --git a/security/security.c b/security/security.c
index 250ee2d76406..90f1e291c800 100644
--- a/security/security.c
+++ b/security/security.c
@@ -33,6 +33,7 @@
 
 /* How many LSMs were built into the kernel? */
 #define LSM_COUNT (__end_lsm_info - __start_lsm_info)
+#define EARLY_LSM_COUNT (__end_early_lsm_info - __start_early_lsm_info)
 
 struct security_hook_heads security_hook_heads __lsm_ro_after_init;
 static BLOCKING_NOTIFIER_HEAD(blocking_lsm_notifier_chain);
@@ -277,6 +278,8 @@ static void __init ordered_lsm_parse(const char *order, const char *origin)
 static void __init lsm_early_cred(struct cred *cred);
 static void __init lsm_early_task(struct task_struct *task);
 
+static int lsm_append(const char *new, char **result);
+
 static void __init ordered_lsm_init(void)
 {
 	struct lsm_info **lsm;
@@ -323,6 +326,26 @@ static void __init ordered_lsm_init(void)
 	kfree(ordered_lsms);
 }
 
+int __init early_security_init(void)
+{
+	int i;
+	struct hlist_head *list = (struct hlist_head *) &security_hook_heads;
+	struct lsm_info *lsm;
+
+	for (i = 0; i < sizeof(security_hook_heads) / sizeof(struct hlist_head);
+	     i++)
+		INIT_HLIST_HEAD(&list[i]);
+
+	for (lsm = __start_early_lsm_info; lsm < __end_early_lsm_info; lsm++) {
+		if (!lsm->enabled)
+			lsm->enabled = &lsm_enabled_true;
+		prepare_lsm(lsm);
+		initialize_lsm(lsm);
+	}
+
+	return 0;
+}
+
 /**
  * security_init - initializes the security framework
  *
@@ -330,14 +353,18 @@ static void __init ordered_lsm_init(void)
  */
 int __init security_init(void)
 {
-	int i;
-	struct hlist_head *list = (struct hlist_head *) &security_hook_heads;
+	struct lsm_info *lsm;
 
 	pr_info("Security Framework initializing\n");
 
-	for (i = 0; i < sizeof(security_hook_heads) / sizeof(struct hlist_head);
-	     i++)
-		INIT_HLIST_HEAD(&list[i]);
+	/*
+	 * Append the names of the early LSM modules now that kmalloc() is
+	 * available
+	 */
+	for (lsm = __start_early_lsm_info; lsm < __end_early_lsm_info; lsm++) {
+		if (lsm->enabled)
+			lsm_append(lsm->name, &lsm_names);
+	}
 
 	/* Load LSMs in specified order. */
 	ordered_lsm_init();
@@ -384,7 +411,7 @@ static bool match_last_lsm(const char *list, const char *lsm)
 	return !strcmp(last, lsm);
 }
 
-static int lsm_append(char *new, char **result)
+static int lsm_append(const char *new, char **result)
 {
 	char *cp;
 
@@ -422,8 +449,15 @@ void __init security_add_hooks(struct security_hook_list *hooks, int count,
 		hooks[i].lsm = lsm;
 		hlist_add_tail_rcu(&hooks[i].list, hooks[i].head);
 	}
-	if (lsm_append(lsm, &lsm_names) < 0)
-		panic("%s - Cannot get early memory.\n", __func__);
+
+	/*
+	 * Don't try to append during early_security_init(), we'll come back
+	 * and fix this up afterwards.
+	 */
+	if (slab_is_available()) {
+		if (lsm_append(lsm, &lsm_names) < 0)
+			panic("%s - Cannot get early memory.\n", __func__);
+	}
 }
 
 int call_blocking_lsm_notifier(enum lsm_event event, void *data)
-- 
2.22.0.510.g264f2c817a-goog


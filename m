Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A40A7D104
	for <lists+linux-api@lfdr.de>; Thu,  1 Aug 2019 00:19:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731168AbfGaWQf (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 31 Jul 2019 18:16:35 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:55028 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731162AbfGaWQe (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 31 Jul 2019 18:16:34 -0400
Received: by mail-pf1-f201.google.com with SMTP id y66so44179268pfb.21
        for <linux-api@vger.kernel.org>; Wed, 31 Jul 2019 15:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=8bsfxMGI0ih4pMPPTAd5DGb7PjaX6MOPHshFINx/tPw=;
        b=T8uBhn8F/ebCXCZz2jG/dmMBma/ouENxi0HKWAV964xKK73heHQ5Ra/HzG/HvRQwlg
         B4JKuzhKDXFW75XvHPJix48g3361z/2MwfwidKZ2ktXR1eq+O0ilRgQgCssdwO8U+RKc
         3n2dswQwFvDauZmmoe7gX+lo8nh34Acf1SdsBk4sHFr3HzEdoCX7pVfuVIGGOzwgzEQm
         dvNawHjayohqrMVboebjhR1NcnR9g2i/V3Ll66Pe4ot+DdTUNqc6/zJ9Em3eSKos+tmV
         127ExBYZ4BuOvK1e0Bb1ANPHPPcEb1W2XphOYtxNIQBTyPme9OwpRSxqv9t0T3WrNXpo
         1hsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=8bsfxMGI0ih4pMPPTAd5DGb7PjaX6MOPHshFINx/tPw=;
        b=qHmP0SeeJOqKMWhlYepzXDglwSX6K5hmLHg7yCVIdqW4eQRbozOY3i3TBkF1npu/xb
         EaBxXbbihw4wmSxvyyqwOvm4/TrQ8CrVNK/PFmhxS91yQ0VjRB9LrtR3uYVdjF9IVH7U
         PwrxzX41Kcv1B45pX6v9k2cU9/pL47WmEi3esfK4JIssPGsym3NJHmSo78jh0//37zWJ
         pxItYNdBHXl9gq8uQBwYEV67dX7Ge86EC/HbC5d+Yz3SVPhvguwJ+5DEfGwFbeOE3qvT
         vcmgKVad0FYNHh20gucyDc+9oVxWXcvmGEVrEwIS1Yjx9BOpzl7BrQyp8AenbdjzmCOW
         XjIQ==
X-Gm-Message-State: APjAAAXKaSMm49phzZOYVnJnW0/v7kDw0f/wR8TY6KwhFp8RVlAda5Cn
        6lQyOUO+K4sMQk/QLz/3mhTHzarddk4wKPvWMqoUNw==
X-Google-Smtp-Source: APXvYqyDtr49MmYBTKFlbKYjg7EQeCqIVdXTvKdl9KZF4JUS8Zi+2yH0uSkl3nFdWiWd4/qUFgElR5qHaJCW1NxybxnT2Q==
X-Received: by 2002:a63:204b:: with SMTP id r11mr75966516pgm.121.1564611393620;
 Wed, 31 Jul 2019 15:16:33 -0700 (PDT)
Date:   Wed, 31 Jul 2019 15:15:51 -0700
In-Reply-To: <20190731221617.234725-1-matthewgarrett@google.com>
Message-Id: <20190731221617.234725-4-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190731221617.234725-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
Subject: [PATCH V37 03/29] security: Add a static lockdown policy LSM
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Matthew Garrett <matthewgarrett@google.com>,
        Matthew Garrett <mjg59@google.com>,
        Kees Cook <keescook@chromium.org>,
        David Howells <dhowells@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

While existing LSMs can be extended to handle lockdown policy,
distributions generally want to be able to apply a straightforward
static policy. This patch adds a simple LSM that can be configured to
reject either integrity or all lockdown queries, and can be configured
at runtime (through securityfs), boot time (via a kernel parameter) or
build time (via a kconfig option). Based on initial code by David
Howells.

Signed-off-by: Matthew Garrett <mjg59@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Cc: David Howells <dhowells@redhat.com>
---
 .../admin-guide/kernel-parameters.txt         |   9 +
 include/linux/security.h                      |   3 +
 security/Kconfig                              |  11 +-
 security/Makefile                             |   2 +
 security/lockdown/Kconfig                     |  47 +++++
 security/lockdown/Makefile                    |   1 +
 security/lockdown/lockdown.c                  | 172 ++++++++++++++++++
 7 files changed, 240 insertions(+), 5 deletions(-)
 create mode 100644 security/lockdown/Kconfig
 create mode 100644 security/lockdown/Makefile
 create mode 100644 security/lockdown/lockdown.c

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index ef52d01524af..0b962844ac2a 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2267,6 +2267,15 @@
 	lockd.nlm_udpport=M	[NFS] Assign UDP port.
 			Format: <integer>
 
+	lockdown=	[SECURITY]
+			{ integrity | confidentiality }
+			Enable the kernel lockdown feature. If set to
+			integrity, kernel features that allow userland to
+			modify the running kernel are disabled. If set to
+			confidentiality, kernel features that allow userland
+			to extract confidential information from the kernel
+			are also disabled.
+
 	locktorture.nreaders_stress= [KNL]
 			Set the number of locking read-acquisition kthreads.
 			Defaults to being automatically set based on the
diff --git a/include/linux/security.h b/include/linux/security.h
index c2b1204e8e26..54a0532ec12f 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -97,6 +97,9 @@ enum lsm_event {
  * potentially a moving target. It is easy to misuse this information
  * in a way that could break userspace. Please be careful not to do
  * so.
+ *
+ * If you add to this, remember to extend lockdown_reasons in
+ * security/lockdown/lockdown.c.
  */
 enum lockdown_reason {
 	LOCKDOWN_NONE,
diff --git a/security/Kconfig b/security/Kconfig
index 0d65594b5196..2a1a2d396228 100644
--- a/security/Kconfig
+++ b/security/Kconfig
@@ -237,6 +237,7 @@ source "security/apparmor/Kconfig"
 source "security/loadpin/Kconfig"
 source "security/yama/Kconfig"
 source "security/safesetid/Kconfig"
+source "security/lockdown/Kconfig"
 
 source "security/integrity/Kconfig"
 
@@ -276,11 +277,11 @@ endchoice
 
 config LSM
 	string "Ordered list of enabled LSMs"
-	default "yama,loadpin,safesetid,integrity,smack,selinux,tomoyo,apparmor" if DEFAULT_SECURITY_SMACK
-	default "yama,loadpin,safesetid,integrity,apparmor,selinux,smack,tomoyo" if DEFAULT_SECURITY_APPARMOR
-	default "yama,loadpin,safesetid,integrity,tomoyo" if DEFAULT_SECURITY_TOMOYO
-	default "yama,loadpin,safesetid,integrity" if DEFAULT_SECURITY_DAC
-	default "yama,loadpin,safesetid,integrity,selinux,smack,tomoyo,apparmor"
+	default "lockdown,yama,loadpin,safesetid,integrity,smack,selinux,tomoyo,apparmor" if DEFAULT_SECURITY_SMACK
+	default "lockdown,yama,loadpin,safesetid,integrity,apparmor,selinux,smack,tomoyo" if DEFAULT_SECURITY_APPARMOR
+	default "lockdown,yama,loadpin,safesetid,integrity,tomoyo" if DEFAULT_SECURITY_TOMOYO
+	default "lockdown,yama,loadpin,safesetid,integrity" if DEFAULT_SECURITY_DAC
+	default "lockdown,yama,loadpin,safesetid,integrity,selinux,smack,tomoyo,apparmor"
 	help
 	  A comma-separated list of LSMs, in initialization order.
 	  Any LSMs left off this list will be ignored. This can be
diff --git a/security/Makefile b/security/Makefile
index c598b904938f..be1dd9d2cb2f 100644
--- a/security/Makefile
+++ b/security/Makefile
@@ -11,6 +11,7 @@ subdir-$(CONFIG_SECURITY_APPARMOR)	+= apparmor
 subdir-$(CONFIG_SECURITY_YAMA)		+= yama
 subdir-$(CONFIG_SECURITY_LOADPIN)	+= loadpin
 subdir-$(CONFIG_SECURITY_SAFESETID)    += safesetid
+subdir-$(CONFIG_SECURITY_LOCKDOWN_LSM)	+= lockdown
 
 # always enable default capabilities
 obj-y					+= commoncap.o
@@ -27,6 +28,7 @@ obj-$(CONFIG_SECURITY_APPARMOR)		+= apparmor/
 obj-$(CONFIG_SECURITY_YAMA)		+= yama/
 obj-$(CONFIG_SECURITY_LOADPIN)		+= loadpin/
 obj-$(CONFIG_SECURITY_SAFESETID)       += safesetid/
+obj-$(CONFIG_SECURITY_LOCKDOWN_LSM)	+= lockdown/
 obj-$(CONFIG_CGROUP_DEVICE)		+= device_cgroup.o
 
 # Object integrity file lists
diff --git a/security/lockdown/Kconfig b/security/lockdown/Kconfig
new file mode 100644
index 000000000000..7374ba76d8eb
--- /dev/null
+++ b/security/lockdown/Kconfig
@@ -0,0 +1,47 @@
+config SECURITY_LOCKDOWN_LSM
+	bool "Basic module for enforcing kernel lockdown"
+	depends on SECURITY
+	help
+	  Build support for an LSM that enforces a coarse kernel lockdown
+	  behaviour.
+
+config SECURITY_LOCKDOWN_LSM_EARLY
+	bool "Enable lockdown LSM early in init"
+	depends on SECURITY_LOCKDOWN_LSM
+	help
+	  Enable the lockdown LSM early in boot. This is necessary in order
+	  to ensure that lockdown enforcement can be carried out on kernel
+	  boot parameters that are otherwise parsed before the security
+	  subsystem is fully initialised. If enabled, lockdown will
+	  unconditionally be called before any other LSMs.
+
+choice
+	prompt "Kernel default lockdown mode"
+	default LOCK_DOWN_KERNEL_FORCE_NONE
+	depends on SECURITY_LOCKDOWN_LSM
+	help
+	  The kernel can be configured to default to differing levels of
+	  lockdown.
+
+config LOCK_DOWN_KERNEL_FORCE_NONE
+	bool "None"
+	help
+	  No lockdown functionality is enabled by default. Lockdown may be
+	  enabled via the kernel commandline or /sys/kernel/security/lockdown.
+
+config LOCK_DOWN_KERNEL_FORCE_INTEGRITY
+	bool "Integrity"
+	help
+	 The kernel runs in integrity mode by default. Features that allow
+	 the kernel to be modified at runtime are disabled.
+
+config LOCK_DOWN_KERNEL_FORCE_CONFIDENTIALITY
+	bool "Confidentiality"
+	help
+	 The kernel runs in confidentiality mode by default. Features that
+	 allow the kernel to be modified at runtime or that permit userland
+	 code to read confidential material held inside the kernel are
+	 disabled.
+
+endchoice
+
diff --git a/security/lockdown/Makefile b/security/lockdown/Makefile
new file mode 100644
index 000000000000..e3634b9017e7
--- /dev/null
+++ b/security/lockdown/Makefile
@@ -0,0 +1 @@
+obj-$(CONFIG_SECURITY_LOCKDOWN_LSM) += lockdown.o
diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
new file mode 100644
index 000000000000..d30c4d254b5f
--- /dev/null
+++ b/security/lockdown/lockdown.c
@@ -0,0 +1,172 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Lock down the kernel
+ *
+ * Copyright (C) 2016 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public Licence
+ * as published by the Free Software Foundation; either version
+ * 2 of the Licence, or (at your option) any later version.
+ */
+
+#include <linux/security.h>
+#include <linux/export.h>
+#include <linux/lsm_hooks.h>
+
+static enum lockdown_reason kernel_locked_down;
+
+static char *lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1] = {
+	[LOCKDOWN_NONE] = "none",
+	[LOCKDOWN_INTEGRITY_MAX] = "integrity",
+	[LOCKDOWN_CONFIDENTIALITY_MAX] = "confidentiality",
+};
+
+static enum lockdown_reason lockdown_levels[] = {LOCKDOWN_NONE,
+						 LOCKDOWN_INTEGRITY_MAX,
+						 LOCKDOWN_CONFIDENTIALITY_MAX};
+
+/*
+ * Put the kernel into lock-down mode.
+ */
+static int lock_kernel_down(const char *where, enum lockdown_reason level)
+{
+	if (kernel_locked_down >= level)
+		return -EPERM;
+
+	kernel_locked_down = level;
+	pr_notice("Kernel is locked down from %s; see man kernel_lockdown.7\n",
+		  where);
+	return 0;
+}
+
+static int __init lockdown_param(char *level)
+{
+	if (!level)
+		return -EINVAL;
+
+	if (strcmp(level, "integrity") == 0)
+		lock_kernel_down("command line", LOCKDOWN_INTEGRITY_MAX);
+	else if (strcmp(level, "confidentiality") == 0)
+		lock_kernel_down("command line", LOCKDOWN_CONFIDENTIALITY_MAX);
+	else
+		return -EINVAL;
+
+	return 0;
+}
+
+early_param("lockdown", lockdown_param);
+
+/**
+ * lockdown_is_locked_down - Find out if the kernel is locked down
+ * @what: Tag to use in notice generated if lockdown is in effect
+ */
+static int lockdown_is_locked_down(enum lockdown_reason what)
+{
+	if (kernel_locked_down >= what) {
+		if (lockdown_reasons[what])
+			pr_notice("Lockdown: %s is restricted; see man kernel_lockdown.7\n",
+				  lockdown_reasons[what]);
+		return -EPERM;
+	}
+
+	return 0;
+}
+
+static struct security_hook_list lockdown_hooks[] __lsm_ro_after_init = {
+	LSM_HOOK_INIT(locked_down, lockdown_is_locked_down),
+};
+
+static int __init lockdown_lsm_init(void)
+{
+#if defined(CONFIG_LOCK_DOWN_KERNEL_FORCE_INTEGRITY)
+	lock_kernel_down("Kernel configuration", LOCKDOWN_INTEGRITY_MAX);
+#elif defined(CONFIG_LOCK_DOWN_KERNEL_FORCE_CONFIDENTIALITY)
+	lock_kernel_down("Kernel configuration", LOCKDOWN_CONFIDENTIALITY_MAX);
+#endif
+	security_add_hooks(lockdown_hooks, ARRAY_SIZE(lockdown_hooks),
+			   "lockdown");
+	return 0;
+}
+
+static ssize_t lockdown_read(struct file *filp, char __user *buf, size_t count,
+			     loff_t *ppos)
+{
+	char temp[80];
+	int i, offset = 0;
+
+	for (i = 0; i < ARRAY_SIZE(lockdown_levels); i++) {
+		enum lockdown_reason level = lockdown_levels[i];
+
+		if (lockdown_reasons[level]) {
+			const char *label = lockdown_reasons[level];
+
+			if (kernel_locked_down == level)
+				offset += sprintf(temp+offset, "[%s] ", label);
+			else
+				offset += sprintf(temp+offset, "%s ", label);
+		}
+	}
+
+	/* Convert the last space to a newline if needed. */
+	if (offset > 0)
+		temp[offset-1] = '\n';
+
+	return simple_read_from_buffer(buf, count, ppos, temp, strlen(temp));
+}
+
+static ssize_t lockdown_write(struct file *file, const char __user *buf,
+			      size_t n, loff_t *ppos)
+{
+	char *state;
+	int i, len, err = -EINVAL;
+
+	state = memdup_user_nul(buf, n);
+	if (IS_ERR(state))
+		return PTR_ERR(state);
+
+	len = strlen(state);
+	if (len && state[len-1] == '\n') {
+		state[len-1] = '\0';
+		len--;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(lockdown_levels); i++) {
+		enum lockdown_reason level = lockdown_levels[i];
+		const char *label = lockdown_reasons[level];
+
+		if (label && !strcmp(state, label))
+			err = lock_kernel_down("securityfs", level);
+	}
+
+	kfree(state);
+	return err ? err : n;
+}
+
+static const struct file_operations lockdown_ops = {
+	.read  = lockdown_read,
+	.write = lockdown_write,
+};
+
+static int __init lockdown_secfs_init(void)
+{
+	struct dentry *dentry;
+
+	dentry = securityfs_create_file("lockdown", 0600, NULL, NULL,
+					&lockdown_ops);
+	if (IS_ERR(dentry))
+		return PTR_ERR(dentry);
+
+	return 0;
+}
+
+core_initcall(lockdown_secfs_init);
+
+#ifdef CONFIG_SECURITY_LOCKDOWN_LSM_EARLY
+DEFINE_EARLY_LSM(lockdown) = {
+#else
+DEFINE_LSM(lockdown) = {
+#endif
+	.name = "lockdown",
+	.init = lockdown_lsm_init,
+};
-- 
2.22.0.770.g0f2c4a37fd-goog


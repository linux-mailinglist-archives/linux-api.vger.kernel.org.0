Return-Path: <linux-api+bounces-5554-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D5287CCD8D1
	for <lists+linux-api@lfdr.de>; Thu, 18 Dec 2025 21:44:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 046443063C00
	for <lists+linux-api@lfdr.de>; Thu, 18 Dec 2025 20:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31D5A2E0926;
	Thu, 18 Dec 2025 20:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ogzR9M+Y"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 031E12DECC5;
	Thu, 18 Dec 2025 20:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766090569; cv=none; b=jD4i7vNWCz8m80HNhW7oEyyEG7eouRratkSc/qif4B4URZ7bOedPUZelmJ8EcO7PH2I+R1TAA/caGxtdZVC3W6o5ZZ3T5pf2LeYq6cqMcFeiY/++Zc50uBTE4xLANukaZjS9cHAKmjX9598i5xn5yk2J9fpsXNPJ5J0Pd3+i+cM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766090569; c=relaxed/simple;
	bh=4njXAcsXQgxzf4FI+Pl/TwMQWMtJkYo+TBa/CAdD/RQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZALtr1RWIYB8bx4u9YEL++SdIu1yiPn8/tOmPFjwi8Yu7b0piYjAMDUvAQXiPq1KqLOO9ymxRiCXAaf0Pj4uiHbb1C4ZqVdpx7cdwdGTcH4VvqMNonhYPGBiIqArTKXk95mAFSYQPfj+z3fMmFiCDIz8DX7WDbEkIXhswG3Uc64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ogzR9M+Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DD3EC16AAE;
	Thu, 18 Dec 2025 20:42:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766090568;
	bh=4njXAcsXQgxzf4FI+Pl/TwMQWMtJkYo+TBa/CAdD/RQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ogzR9M+Y/t6RFbp3aBNkqojGdsWkWS4Hio91QkeoAErCWQXy6ZO38CuHD+oL7ssBo
	 HwN74EuIoVBpI1ty7xBqke1c+xlWTVTOJLsL91g/EEXe7XND5c1UWY04LsE9E4u54M
	 7XXgw+F2aBHwmEkMGzaCWx0S4Mo2Wjbl8Su1LiiOdMsmveKkNZbZuZXXhI+x7qsHyt
	 xBeKwIsEu1IEO8DrwLftJ+/XktfDI+zbu5CsiB+OrF+qXWnC8sxx0e9ebA0NRAEHYN
	 xPn+h3oq+q9PbNGIcXZ5d4lg2uS6kYqW02yweYkP1chr+59OV1MJlciHikqodiev/d
	 lamxhscxAzxVQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-api@vger.kernel.org
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tools@kernel.org,
	gpaoloni@redhat.com,
	Sasha Levin <sashal@kernel.org>
Subject: [RFC PATCH v5 03/15] kernel/api: add debugfs interface for kernel API specifications
Date: Thu, 18 Dec 2025 15:42:25 -0500
Message-ID: <20251218204239.4159453-4-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251218204239.4159453-1-sashal@kernel.org>
References: <20251218204239.4159453-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a debugfs interface to expose kernel API specifications at runtime.
This allows tools and users to query the complete API specifications
through the debugfs filesystem.

The interface provides:
- /sys/kernel/debug/kapi/list - lists all available API specifications
- /sys/kernel/debug/kapi/specs/<name> - detailed info for each API

Each specification file includes:
- Function name, version, and descriptions
- Execution context requirements and flags
- Parameter details with types, flags, and constraints
- Return value specifications and success conditions
- Error codes with descriptions and conditions
- Locking requirements and constraints
- Signal handling specifications
- Examples, notes, and deprecation status

This enables runtime introspection of kernel APIs for documentation
tools, static analyzers, and debugging purposes.

Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/api/Kconfig        |  20 +++
 kernel/api/Makefile       |   3 +
 kernel/api/kapi_debugfs.c | 358 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 381 insertions(+)
 create mode 100644 kernel/api/kapi_debugfs.c

diff --git a/kernel/api/Kconfig b/kernel/api/Kconfig
index fde25ec70e134..d2754b21acc43 100644
--- a/kernel/api/Kconfig
+++ b/kernel/api/Kconfig
@@ -33,3 +33,23 @@ config KAPI_RUNTIME_CHECKS
 	  development. The checks use WARN_ONCE to report violations.
 
 	  If unsure, say N.
+
+config KAPI_SPEC_DEBUGFS
+	bool "Export kernel API specifications via debugfs"
+	depends on KAPI_SPEC
+	depends on DEBUG_FS
+	help
+	  This option enables exporting kernel API specifications through
+	  the debugfs filesystem. When enabled, specifications can be
+	  accessed at /sys/kernel/debug/kapi/.
+
+	  The debugfs interface provides:
+	  - A list of all available API specifications
+	  - Detailed information for each API including parameters,
+	    return values, errors, locking requirements, and constraints
+	  - Complete machine-readable representation of the specs
+
+	  This is useful for documentation tools, static analyzers, and
+	  runtime introspection of kernel APIs.
+
+	  If unsure, say N.
diff --git a/kernel/api/Makefile b/kernel/api/Makefile
index acab17c78afa3..716f128eea71d 100644
--- a/kernel/api/Makefile
+++ b/kernel/api/Makefile
@@ -10,6 +10,9 @@ obj-$(CONFIG_KAPI_SPEC)		+= kernel_api_spec.o
 ifeq ($(CONFIG_KAPI_SPEC),y)
 obj-$(CONFIG_KAPI_SPEC)		+= generated_api_specs.o
 
+# Debugfs interface for kernel API specs
+obj-$(CONFIG_KAPI_SPEC_DEBUGFS) += kapi_debugfs.o
+
 # Find all potential apispec files (this is evaluated at make time)
 apispec-files := $(shell find $(objtree) -name "*.apispec.h" -type f 2>/dev/null)
 
diff --git a/kernel/api/kapi_debugfs.c b/kernel/api/kapi_debugfs.c
new file mode 100644
index 0000000000000..84d5446d93916
--- /dev/null
+++ b/kernel/api/kapi_debugfs.c
@@ -0,0 +1,358 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Kernel API specification debugfs interface
+ *
+ * This provides a debugfs interface to expose kernel API specifications
+ * at runtime, allowing tools and users to query the complete API specs.
+ */
+
+#include <linux/debugfs.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/seq_file.h>
+#include <linux/kernel_api_spec.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+
+/* External symbols for kernel API spec section */
+extern struct kernel_api_spec __start_kapi_specs[];
+extern struct kernel_api_spec __stop_kapi_specs[];
+
+static struct dentry *kapi_debugfs_root;
+
+/* Helper function to print parameter type as string */
+static const char *param_type_str(enum kapi_param_type type)
+{
+	switch (type) {
+	case KAPI_TYPE_INT: return "int";
+	case KAPI_TYPE_UINT: return "uint";
+	case KAPI_TYPE_PTR: return "ptr";
+	case KAPI_TYPE_STRUCT: return "struct";
+	case KAPI_TYPE_UNION: return "union";
+	case KAPI_TYPE_ARRAY: return "array";
+	case KAPI_TYPE_FD: return "fd";
+	case KAPI_TYPE_ENUM: return "enum";
+	case KAPI_TYPE_USER_PTR: return "user_ptr";
+	case KAPI_TYPE_PATH: return "path";
+	case KAPI_TYPE_FUNC_PTR: return "func_ptr";
+	case KAPI_TYPE_CUSTOM: return "custom";
+	default: return "unknown";
+	}
+}
+
+/* Helper to print parameter flags */
+static void print_param_flags(struct seq_file *m, u32 flags)
+{
+	seq_printf(m, "    flags: ");
+	if (flags & KAPI_PARAM_IN) seq_printf(m, "IN ");
+	if (flags & KAPI_PARAM_OUT) seq_printf(m, "OUT ");
+	if (flags & KAPI_PARAM_INOUT) seq_printf(m, "INOUT ");
+	if (flags & KAPI_PARAM_OPTIONAL) seq_printf(m, "OPTIONAL ");
+	if (flags & KAPI_PARAM_CONST) seq_printf(m, "CONST ");
+	if (flags & KAPI_PARAM_USER) seq_printf(m, "USER ");
+	if (flags & KAPI_PARAM_VOLATILE) seq_printf(m, "VOLATILE ");
+	if (flags & KAPI_PARAM_DMA) seq_printf(m, "DMA ");
+	if (flags & KAPI_PARAM_ALIGNED) seq_printf(m, "ALIGNED ");
+	seq_printf(m, "\n");
+}
+
+/* Helper to print context flags */
+static void print_context_flags(struct seq_file *m, u32 flags)
+{
+	seq_printf(m, "Context flags: ");
+	if (flags & KAPI_CTX_PROCESS) seq_printf(m, "PROCESS ");
+	if (flags & KAPI_CTX_HARDIRQ) seq_printf(m, "HARDIRQ ");
+	if (flags & KAPI_CTX_SOFTIRQ) seq_printf(m, "SOFTIRQ ");
+	if (flags & KAPI_CTX_NMI) seq_printf(m, "NMI ");
+	if (flags & KAPI_CTX_SLEEPABLE) seq_printf(m, "SLEEPABLE ");
+	if (flags & KAPI_CTX_ATOMIC) seq_printf(m, "ATOMIC ");
+	if (flags & KAPI_CTX_PREEMPT_DISABLED) seq_printf(m, "PREEMPT_DISABLED ");
+	if (flags & KAPI_CTX_IRQ_DISABLED) seq_printf(m, "IRQ_DISABLED ");
+	seq_printf(m, "\n");
+}
+
+/* Show function for individual API spec */
+static int kapi_spec_show(struct seq_file *m, void *v)
+{
+	struct kernel_api_spec *spec = m->private;
+	int i;
+
+	seq_printf(m, "Kernel API Specification\n");
+	seq_printf(m, "========================\n\n");
+
+	/* Basic info */
+	seq_printf(m, "Name: %s\n", spec->name);
+	seq_printf(m, "Version: %u\n", spec->version);
+	seq_printf(m, "Description: %s\n", spec->description);
+	if (strlen(spec->long_description) > 0)
+		seq_printf(m, "Long description: %s\n", spec->long_description);
+
+	/* Context */
+	print_context_flags(m, spec->context_flags);
+	seq_printf(m, "\n");
+
+	/* Parameters */
+	if (spec->param_count > 0) {
+		seq_printf(m, "Parameters (%u):\n", spec->param_count);
+		for (i = 0; i < spec->param_count; i++) {
+			struct kapi_param_spec *param = &spec->params[i];
+			seq_printf(m, "  [%d] %s:\n", i, param->name);
+			seq_printf(m, "    type: %s (%s)\n",
+				   param_type_str(param->type), param->type_name);
+			print_param_flags(m, param->flags);
+			if (strlen(param->description) > 0)
+				seq_printf(m, "    description: %s\n", param->description);
+			if (param->size > 0)
+				seq_printf(m, "    size: %zu\n", param->size);
+			if (param->alignment > 0)
+				seq_printf(m, "    alignment: %zu\n", param->alignment);
+
+			/* Print constraints if any */
+			if (param->constraint_type != KAPI_CONSTRAINT_NONE) {
+				seq_printf(m, "    constraints:\n");
+				switch (param->constraint_type) {
+				case KAPI_CONSTRAINT_RANGE:
+					seq_printf(m, "      type: range\n");
+					seq_printf(m, "      min: %lld\n", param->min_value);
+					seq_printf(m, "      max: %lld\n", param->max_value);
+					break;
+				case KAPI_CONSTRAINT_MASK:
+					seq_printf(m, "      type: mask\n");
+					seq_printf(m, "      valid_bits: 0x%llx\n", param->valid_mask);
+					break;
+				case KAPI_CONSTRAINT_ENUM:
+					seq_printf(m, "      type: enum\n");
+					seq_printf(m, "      count: %u\n", param->enum_count);
+					break;
+				case KAPI_CONSTRAINT_USER_STRING:
+					seq_printf(m, "      type: user_string\n");
+					seq_printf(m, "      min_len: %lld\n", param->min_value);
+					seq_printf(m, "      max_len: %lld\n", param->max_value);
+					break;
+				case KAPI_CONSTRAINT_USER_PATH:
+					seq_printf(m, "      type: user_path\n");
+					seq_printf(m, "      max_len: PATH_MAX (4096)\n");
+					break;
+				case KAPI_CONSTRAINT_USER_PTR:
+					seq_printf(m, "      type: user_ptr\n");
+					seq_printf(m, "      size: %zu bytes\n", param->size);
+					break;
+				case KAPI_CONSTRAINT_CUSTOM:
+					seq_printf(m, "      type: custom\n");
+					if (strlen(param->constraints) > 0)
+						seq_printf(m, "      description: %s\n",
+							   param->constraints);
+					break;
+				default:
+					break;
+				}
+			}
+			seq_printf(m, "\n");
+		}
+	}
+
+	/* Return value */
+	seq_printf(m, "Return value:\n");
+	seq_printf(m, "  type: %s\n", spec->return_spec.type_name);
+	if (strlen(spec->return_spec.description) > 0)
+		seq_printf(m, "  description: %s\n", spec->return_spec.description);
+
+	switch (spec->return_spec.check_type) {
+	case KAPI_RETURN_EXACT:
+		seq_printf(m, "  success: == %lld\n", spec->return_spec.success_value);
+		break;
+	case KAPI_RETURN_RANGE:
+		seq_printf(m, "  success: [%lld, %lld]\n",
+			   spec->return_spec.success_min,
+			   spec->return_spec.success_max);
+		break;
+	case KAPI_RETURN_FD:
+		seq_printf(m, "  success: valid file descriptor (>= 0)\n");
+		break;
+	case KAPI_RETURN_ERROR_CHECK:
+		seq_printf(m, "  success: error check\n");
+		break;
+	case KAPI_RETURN_CUSTOM:
+		seq_printf(m, "  success: custom check\n");
+		break;
+	default:
+		break;
+	}
+	seq_printf(m, "\n");
+
+	/* Errors */
+	if (spec->error_count > 0) {
+		seq_printf(m, "Errors (%u):\n", spec->error_count);
+		for (i = 0; i < spec->error_count; i++) {
+			struct kapi_error_spec *err = &spec->errors[i];
+			seq_printf(m, "  %s (%d): %s\n",
+				   err->name, err->error_code, err->description);
+			if (strlen(err->condition) > 0)
+				seq_printf(m, "    condition: %s\n", err->condition);
+		}
+		seq_printf(m, "\n");
+	}
+
+	/* Locks */
+	if (spec->lock_count > 0) {
+		seq_printf(m, "Locks (%u):\n", spec->lock_count);
+		for (i = 0; i < spec->lock_count; i++) {
+			struct kapi_lock_spec *lock = &spec->locks[i];
+			const char *type_str, *scope_str;
+			switch (lock->lock_type) {
+			case KAPI_LOCK_MUTEX: type_str = "mutex"; break;
+			case KAPI_LOCK_SPINLOCK: type_str = "spinlock"; break;
+			case KAPI_LOCK_RWLOCK: type_str = "rwlock"; break;
+			case KAPI_LOCK_SEMAPHORE: type_str = "semaphore"; break;
+			case KAPI_LOCK_RCU: type_str = "rcu"; break;
+			case KAPI_LOCK_SEQLOCK: type_str = "seqlock"; break;
+			default: type_str = "unknown"; break;
+			}
+			switch (lock->scope) {
+			case KAPI_LOCK_INTERNAL: scope_str = "acquired and released"; break;
+			case KAPI_LOCK_ACQUIRES: scope_str = "acquired (not released)"; break;
+			case KAPI_LOCK_RELEASES: scope_str = "released (held on entry)"; break;
+			case KAPI_LOCK_CALLER_HELD: scope_str = "held by caller"; break;
+			default: scope_str = "unknown"; break;
+			}
+			seq_printf(m, "  %s (%s): %s\n",
+				   lock->lock_name, type_str, lock->description);
+			seq_printf(m, "    scope: %s\n", scope_str);
+		}
+		seq_printf(m, "\n");
+	}
+
+	/* Constraints */
+	if (spec->constraint_count > 0) {
+		seq_printf(m, "Additional constraints (%u):\n", spec->constraint_count);
+		for (i = 0; i < spec->constraint_count; i++) {
+			struct kapi_constraint_spec *cons = &spec->constraints[i];
+
+			seq_printf(m, "  - %s", cons->name);
+			if (cons->description[0])
+				seq_printf(m, ": %s", cons->description);
+			seq_printf(m, "\n");
+			if (cons->expression[0])
+				seq_printf(m, "    expression: %s\n", cons->expression);
+		}
+		seq_printf(m, "\n");
+	}
+
+	/* Signals */
+	if (spec->signal_count > 0) {
+		seq_printf(m, "Signal handling (%u):\n", spec->signal_count);
+		for (i = 0; i < spec->signal_count; i++) {
+			struct kapi_signal_spec *sig = &spec->signals[i];
+			seq_printf(m, "  %s (%d):\n", sig->signal_name, sig->signal_num);
+			seq_printf(m, "    direction: ");
+			if (sig->direction & KAPI_SIGNAL_SEND) seq_printf(m, "send ");
+			if (sig->direction & KAPI_SIGNAL_RECEIVE) seq_printf(m, "receive ");
+			if (sig->direction & KAPI_SIGNAL_HANDLE) seq_printf(m, "handle ");
+			if (sig->direction & KAPI_SIGNAL_BLOCK) seq_printf(m, "block ");
+			if (sig->direction & KAPI_SIGNAL_IGNORE) seq_printf(m, "ignore ");
+			seq_printf(m, "\n");
+			seq_printf(m, "    action: ");
+			switch (sig->action) {
+			case KAPI_SIGNAL_ACTION_DEFAULT: seq_printf(m, "default"); break;
+			case KAPI_SIGNAL_ACTION_TERMINATE: seq_printf(m, "terminate"); break;
+			case KAPI_SIGNAL_ACTION_COREDUMP: seq_printf(m, "coredump"); break;
+			case KAPI_SIGNAL_ACTION_STOP: seq_printf(m, "stop"); break;
+			case KAPI_SIGNAL_ACTION_CONTINUE: seq_printf(m, "continue"); break;
+			case KAPI_SIGNAL_ACTION_CUSTOM: seq_printf(m, "custom"); break;
+			case KAPI_SIGNAL_ACTION_RETURN: seq_printf(m, "return"); break;
+			case KAPI_SIGNAL_ACTION_RESTART: seq_printf(m, "restart"); break;
+			default: seq_printf(m, "unknown"); break;
+			}
+			seq_printf(m, "\n");
+			if (strlen(sig->description) > 0)
+				seq_printf(m, "    description: %s\n", sig->description);
+		}
+		seq_printf(m, "\n");
+	}
+
+	/* Additional info */
+	if (strlen(spec->examples) > 0) {
+		seq_printf(m, "Examples:\n%s\n\n", spec->examples);
+	}
+	if (strlen(spec->notes) > 0) {
+		seq_printf(m, "Notes:\n%s\n\n", spec->notes);
+	}
+	if (strlen(spec->since_version) > 0) {
+		seq_printf(m, "Since: %s\n", spec->since_version);
+	}
+
+	return 0;
+}
+
+static int kapi_spec_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, kapi_spec_show, inode->i_private);
+}
+
+static const struct file_operations kapi_spec_fops = {
+	.open = kapi_spec_open,
+	.read = seq_read,
+	.llseek = seq_lseek,
+	.release = single_release,
+};
+
+/* Show all available API specs */
+static int kapi_list_show(struct seq_file *m, void *v)
+{
+	struct kernel_api_spec *spec;
+	int count = 0;
+
+	seq_printf(m, "Available Kernel API Specifications\n");
+	seq_printf(m, "===================================\n\n");
+
+	for (spec = __start_kapi_specs; spec < __stop_kapi_specs; spec++) {
+		seq_printf(m, "%s - %s\n", spec->name, spec->description);
+		count++;
+	}
+
+	seq_printf(m, "\nTotal: %d specifications\n", count);
+	return 0;
+}
+
+static int kapi_list_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, kapi_list_show, NULL);
+}
+
+static const struct file_operations kapi_list_fops = {
+	.open = kapi_list_open,
+	.read = seq_read,
+	.llseek = seq_lseek,
+	.release = single_release,
+};
+
+static int __init kapi_debugfs_init(void)
+{
+	struct kernel_api_spec *spec;
+	struct dentry *spec_dir;
+
+	/* Create main directory */
+	kapi_debugfs_root = debugfs_create_dir("kapi", NULL);
+
+	/* Create list file */
+	debugfs_create_file("list", 0444, kapi_debugfs_root, NULL, &kapi_list_fops);
+
+	/* Create specs subdirectory */
+	spec_dir = debugfs_create_dir("specs", kapi_debugfs_root);
+
+	/* Create a file for each API spec */
+	for (spec = __start_kapi_specs; spec < __stop_kapi_specs; spec++) {
+		debugfs_create_file(spec->name, 0444, spec_dir, spec, &kapi_spec_fops);
+	}
+
+	pr_info("Kernel API debugfs interface initialized\n");
+	return 0;
+}
+
+static void __exit kapi_debugfs_exit(void)
+{
+	debugfs_remove_recursive(kapi_debugfs_root);
+}
+
+/* Initialize as part of kernel, not as a module */
+fs_initcall(kapi_debugfs_init);
\ No newline at end of file
-- 
2.51.0



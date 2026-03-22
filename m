Return-Path: <linux-api+bounces-6016-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +B0nJ/ncv2m69QMAu9opvQ
	(envelope-from <linux-api+bounces-6016-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Sun, 22 Mar 2026 13:13:45 +0100
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 47C6C2E9102
	for <lists+linux-api@lfdr.de>; Sun, 22 Mar 2026 13:13:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AD5353019525
	for <lists+linux-api@lfdr.de>; Sun, 22 Mar 2026 12:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 620AA37FF69;
	Sun, 22 Mar 2026 12:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CenWkvgA"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33DF4370D75;
	Sun, 22 Mar 2026 12:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774181442; cv=none; b=BXmB9tMiufHbowyT+7Msd+w6aM5lvVy16UXOmm9dgqsNkfTAs7a7VZjWfA4nAITGao0C+1zA3HbwanZ9bNsAo4gtE+DLC1pqkRzdDGBaDgs3L0iZezpFIrqzgtewp6rxwWV5s53Si0pnuuVGZA3MQhnUtuoQmlHGjbKoG4x0Tqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774181442; c=relaxed/simple;
	bh=SPN3XSnQ1h8fly62MbQ4j01Dhm2wQmb+Q9hIdR23MQg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GDmJPqJ+JvUbe19QxtSKCrBB4tV84ub9em/i+8KYMQ+qsFBKFtbF2IemT+yRvjFhViOvAVcFWn0MCYebQSMoq2W5MSl6R0QqaqXO7aNOubgwpnlUQ3jlwb7XGQrwFBMVdv8r9/il3DDWMscsiDfBxN5Rfe6Hs04iQM4+PYu9U0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CenWkvgA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F5D6C2BCB3;
	Sun, 22 Mar 2026 12:10:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774181442;
	bh=SPN3XSnQ1h8fly62MbQ4j01Dhm2wQmb+Q9hIdR23MQg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CenWkvgA273/bQPRUaMPDn8DlieNsZXyEnXT3V0UTXjGbb5hP27vSEcv98BmqVbx7
	 TSEhecykElwsV7kQDY6xkMfNPV1uGyGFkyes6O8uFFNfW1cwJk5I8/lEy/e0gEAayH
	 Q10Z4pOFNqc3YvlxdkmtEL3ohWZsETrb2uGCKayaUUCbLeXDnb/h+BAKBdr+eStC54
	 inmpD3p/OnfIuOny7IwyFHEw7m57VTCzX9t87NE1pqBahNfevs8tj/Eu3NiAA0P8pM
	 rb1Gc5Z2qgp4w9obKs6e2QaYJ1VBuiNTNo++VoRsXGZmRnDxqznGgTMtiQVR12zpot
	 nPXyb80hxHY1w==
From: Sasha Levin <sashal@kernel.org>
To: linux-api@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: linux-doc@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kbuild@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	workflows@vger.kernel.org,
	tools@kernel.org,
	x86@kernel.org,
	Thomas Gleixner <tglx@kernel.org>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Dmitry Vyukov <dvyukov@google.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Cyril Hrubis <chrubis@suse.cz>,
	Kees Cook <kees@kernel.org>,
	Jake Edge <jake@lwn.net>,
	David Laight <david.laight.linux@gmail.com>,
	Askar Safin <safinaskar@zohomail.com>,
	Gabriele Paoloni <gpaoloni@redhat.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Andrew Morton <akpm@linux-foundation.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH v2 3/9] kernel/api: add debugfs interface for kernel API specifications
Date: Sun, 22 Mar 2026 08:10:17 -0400
Message-ID: <20260322121026.869758-4-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260322121026.869758-1-sashal@kernel.org>
References: <20260322121026.869758-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6016-lists,linux-api=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[30];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,linuxfoundation.org,lwn.net,google.com,infradead.org,suse.cz,gmail.com,zohomail.com,redhat.com,zeniv.linux.org.uk,linux-foundation.org,arndb.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,linux-api@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-api];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 47C6C2E9102
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
 Documentation/dev-tools/kernel-api-spec.rst |  49 +-
 kernel/api/kapi_debugfs.c                   | 499 ++++++++++++++++++++
 2 files changed, 547 insertions(+), 1 deletion(-)
 create mode 100644 kernel/api/kapi_debugfs.c

diff --git a/Documentation/dev-tools/kernel-api-spec.rst b/Documentation/dev-tools/kernel-api-spec.rst
index 505bcb76e805c..c4ff7d61045c8 100644
--- a/Documentation/dev-tools/kernel-api-spec.rst
+++ b/Documentation/dev-tools/kernel-api-spec.rst
@@ -165,6 +165,7 @@ Runtime validation is controlled by kernel configuration:
 
 1. Enable ``CONFIG_KAPI_SPEC`` to build the framework
 2. Enable ``CONFIG_KAPI_RUNTIME_CHECKS`` for runtime validation
+3. Optionally enable ``CONFIG_KAPI_SPEC_DEBUGFS`` for debugfs interface
 
 Validation Behavior
 -------------------
@@ -194,6 +195,51 @@ custom validation functions via the ``validate`` field in the constraint spec:
     .type = KAPI_CONSTRAINT_CUSTOM,
     .validate = validate_buffer_size,
 
+DebugFS Interface
+=================
+
+The debugfs interface provides runtime access to API specifications:
+
+Directory Structure
+-------------------
+
+::
+
+    /sys/kernel/debug/kapi/
+    ├── list                     # Overview of all registered API specs
+    └── specs/                   # Per-API specification files
+        ├── sys_open             # Human-readable spec for sys_open
+        ├── sys_close            # Human-readable spec for sys_close
+        ├── sys_read             # Human-readable spec for sys_read
+        └── sys_write            # Human-readable spec for sys_write
+
+Usage Examples
+--------------
+
+List all available API specifications::
+
+    $ cat /sys/kernel/debug/kapi/list
+    Available Kernel API Specifications
+    ===================================
+
+    sys_open - Open or create a file
+    sys_close - Close a file descriptor
+    sys_read - Read data from a file descriptor
+    sys_write - Write data to a file descriptor
+
+    Total: 4 specifications
+
+Query specific API::
+
+    $ cat /sys/kernel/debug/kapi/specs/sys_open
+    Kernel API Specification
+    ========================
+
+    Name: sys_open
+    Version: 1
+    Description: Open or create a file
+    ...
+
 Performance Considerations
 ==========================
 
@@ -557,7 +603,8 @@ Submitting Specifications
 1. Add specifications to the same file as the API implementation
 2. Follow existing patterns and naming conventions
 3. Test with CONFIG_KAPI_RUNTIME_CHECKS enabled
-4. Run scripts/checkpatch.pl on your changes
+4. Verify debugfs output is correct
+5. Run scripts/checkpatch.pl on your changes
 
 Review Criteria
 ---------------
diff --git a/kernel/api/kapi_debugfs.c b/kernel/api/kapi_debugfs.c
new file mode 100644
index 0000000000000..dd51faa250178
--- /dev/null
+++ b/kernel/api/kapi_debugfs.c
@@ -0,0 +1,499 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2026 Sasha Levin <sashal@kernel.org>
+ *
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
+static const char * const param_type_names[] = {
+	[KAPI_TYPE_VOID]     = "void",
+	[KAPI_TYPE_INT]      = "int",
+	[KAPI_TYPE_UINT]     = "uint",
+	[KAPI_TYPE_PTR]      = "ptr",
+	[KAPI_TYPE_STRUCT]   = "struct",
+	[KAPI_TYPE_UNION]    = "union",
+	[KAPI_TYPE_ARRAY]    = "array",
+	[KAPI_TYPE_FD]       = "fd",
+	[KAPI_TYPE_ENUM]     = "enum",
+	[KAPI_TYPE_USER_PTR] = "user_ptr",
+	[KAPI_TYPE_PATH]     = "path",
+	[KAPI_TYPE_FUNC_PTR] = "func_ptr",
+	[KAPI_TYPE_CUSTOM]   = "custom",
+};
+
+static const char *param_type_str(enum kapi_param_type type)
+{
+	if (type < ARRAY_SIZE(param_type_names) && param_type_names[type])
+		return param_type_names[type];
+	return "unknown";
+}
+
+/* Helper to print parameter flags */
+static void print_param_flags(struct seq_file *m, u32 flags)
+{
+	seq_puts(m, "    flags: ");
+	if ((flags & KAPI_PARAM_INOUT) == KAPI_PARAM_INOUT)
+		seq_puts(m, "INOUT ");
+	else if (flags & KAPI_PARAM_IN)
+		seq_puts(m, "IN ");
+	else if (flags & KAPI_PARAM_OUT)
+		seq_puts(m, "OUT ");
+	if (flags & KAPI_PARAM_OPTIONAL)
+		seq_puts(m, "OPTIONAL ");
+	if (flags & KAPI_PARAM_CONST)
+		seq_puts(m, "CONST ");
+	if (flags & KAPI_PARAM_USER)
+		seq_puts(m, "USER ");
+	if (flags & KAPI_PARAM_VOLATILE)
+		seq_puts(m, "VOLATILE ");
+	if (flags & KAPI_PARAM_DMA)
+		seq_puts(m, "DMA ");
+	if (flags & KAPI_PARAM_ALIGNED)
+		seq_puts(m, "ALIGNED ");
+	seq_puts(m, "\n");
+}
+
+/* Helper to print context flags */
+static void print_context_flags(struct seq_file *m, u32 flags)
+{
+	seq_puts(m, "Context flags: ");
+	if (flags & KAPI_CTX_PROCESS)
+		seq_puts(m, "PROCESS ");
+	if (flags & KAPI_CTX_HARDIRQ)
+		seq_puts(m, "HARDIRQ ");
+	if (flags & KAPI_CTX_SOFTIRQ)
+		seq_puts(m, "SOFTIRQ ");
+	if (flags & KAPI_CTX_NMI)
+		seq_puts(m, "NMI ");
+	if (flags & KAPI_CTX_SLEEPABLE)
+		seq_puts(m, "SLEEPABLE ");
+	if (flags & KAPI_CTX_ATOMIC)
+		seq_puts(m, "ATOMIC ");
+	if (flags & KAPI_CTX_PREEMPT_DISABLED)
+		seq_puts(m, "PREEMPT_DISABLED ");
+	if (flags & KAPI_CTX_IRQ_DISABLED)
+		seq_puts(m, "IRQ_DISABLED ");
+	seq_puts(m, "\n");
+}
+
+/* Show function for individual API spec */
+static int kapi_spec_show(struct seq_file *m, void *v)
+{
+	struct kernel_api_spec *spec = m->private;
+	int i;
+
+	seq_puts(m, "Kernel API Specification\n");
+	seq_puts(m, "========================\n\n");
+
+	/* Basic info */
+	seq_printf(m, "Name: %s\n", spec->name);
+	seq_printf(m, "Version: %u\n", spec->version);
+	seq_printf(m, "Description: %s\n", spec->description);
+	if (strnlen(spec->long_description, sizeof(spec->long_description)) > 0)
+		seq_printf(m, "Long description: %.*s\n",
+			   (int)sizeof(spec->long_description), spec->long_description);
+
+	/* Context */
+	print_context_flags(m, spec->context_flags);
+	seq_puts(m, "\n");
+
+	/* Parameters */
+	if (spec->param_count > 0) {
+		seq_printf(m, "Parameters (%u):\n", spec->param_count);
+		for (i = 0; i < spec->param_count && i < KAPI_MAX_PARAMS; i++) {
+			struct kapi_param_spec *param = &spec->params[i];
+			seq_printf(m, "  [%d] %s:\n", i, param->name);
+			seq_printf(m, "    type: %s (%s)\n",
+				   param_type_str(param->type), param->type_name);
+			print_param_flags(m, param->flags);
+			if (strnlen(param->description, sizeof(param->description)) > 0)
+				seq_printf(m, "    description: %.*s\n",
+					   (int)sizeof(param->description), param->description);
+			if (param->size > 0)
+				seq_printf(m, "    size: %zu\n", param->size);
+			if (param->alignment > 0)
+				seq_printf(m, "    alignment: %zu\n", param->alignment);
+
+			/* Print constraints if any */
+			if (param->constraint_type != KAPI_CONSTRAINT_NONE) {
+				seq_puts(m, "    constraints:\n");
+				switch (param->constraint_type) {
+				case KAPI_CONSTRAINT_RANGE:
+					seq_puts(m, "      type: range\n");
+					seq_printf(m, "      min: %lld\n", param->min_value);
+					seq_printf(m, "      max: %lld\n", param->max_value);
+					break;
+				case KAPI_CONSTRAINT_MASK:
+					seq_puts(m, "      type: mask\n");
+					seq_printf(m, "      valid_bits: 0x%llx\n", param->valid_mask);
+					break;
+				case KAPI_CONSTRAINT_ENUM:
+					seq_puts(m, "      type: enum\n");
+					seq_printf(m, "      count: %u\n", param->enum_count);
+					break;
+				case KAPI_CONSTRAINT_USER_STRING:
+					seq_puts(m, "      type: user_string\n");
+					seq_printf(m, "      min_len: %lld\n", param->min_value);
+					seq_printf(m, "      max_len: %lld\n", param->max_value);
+					break;
+				case KAPI_CONSTRAINT_USER_PATH:
+					seq_puts(m, "      type: user_path\n");
+					seq_puts(m, "      max_len: PATH_MAX (4096)\n");
+					break;
+				case KAPI_CONSTRAINT_USER_PTR:
+					seq_puts(m, "      type: user_ptr\n");
+					seq_printf(m, "      size: %zu bytes\n", param->size);
+					break;
+				case KAPI_CONSTRAINT_ALIGNMENT:
+					seq_puts(m, "      type: alignment\n");
+					seq_printf(m, "      alignment: %zu\n", param->alignment);
+					break;
+				case KAPI_CONSTRAINT_POWER_OF_TWO:
+					seq_puts(m, "      type: power_of_two\n");
+					break;
+				case KAPI_CONSTRAINT_PAGE_ALIGNED:
+					seq_puts(m, "      type: page_aligned\n");
+					break;
+				case KAPI_CONSTRAINT_NONZERO:
+					seq_puts(m, "      type: nonzero\n");
+					break;
+				case KAPI_CONSTRAINT_CUSTOM:
+					seq_puts(m, "      type: custom\n");
+					if (strnlen(param->constraints, sizeof(param->constraints)) > 0)
+						seq_printf(m, "      description: %.*s\n",
+							   (int)sizeof(param->constraints),
+							   param->constraints);
+					break;
+				default:
+					break;
+				}
+			}
+			seq_puts(m, "\n");
+		}
+	}
+
+	/* Return value */
+	seq_puts(m, "Return value:\n");
+	seq_printf(m, "  type: %s\n", spec->return_spec.type_name);
+	if (strnlen(spec->return_spec.description, sizeof(spec->return_spec.description)) > 0)
+		seq_printf(m, "  description: %.*s\n",
+			   (int)sizeof(spec->return_spec.description),
+			   spec->return_spec.description);
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
+		seq_puts(m, "  success: valid file descriptor (>= 0)\n");
+		break;
+	case KAPI_RETURN_ERROR_CHECK:
+		seq_puts(m, "  success: error check\n");
+		break;
+	case KAPI_RETURN_CUSTOM:
+		seq_puts(m, "  success: custom check\n");
+		break;
+	default:
+		break;
+	}
+	seq_puts(m, "\n");
+
+	/* Errors */
+	if (spec->error_count > 0) {
+		seq_printf(m, "Errors (%u):\n", spec->error_count);
+		for (i = 0; i < spec->error_count && i < KAPI_MAX_ERRORS; i++) {
+			struct kapi_error_spec *err = &spec->errors[i];
+			seq_printf(m, "  %s (%d): %s\n",
+				   err->name, err->error_code, err->description);
+			if (strnlen(err->condition, sizeof(err->condition)) > 0)
+				seq_printf(m, "    condition: %s\n", err->condition);
+		}
+		seq_puts(m, "\n");
+	}
+
+	/* Locks */
+	if (spec->lock_count > 0) {
+		seq_printf(m, "Locks (%u):\n", spec->lock_count);
+		for (i = 0; i < spec->lock_count && i < KAPI_MAX_CONSTRAINTS; i++) {
+			struct kapi_lock_spec *lock = &spec->locks[i];
+			const char *type_str, *scope_str;
+			switch (lock->lock_type) {
+			case KAPI_LOCK_MUTEX:
+				type_str = "mutex";
+				break;
+			case KAPI_LOCK_SPINLOCK:
+				type_str = "spinlock";
+				break;
+			case KAPI_LOCK_RWLOCK:
+				type_str = "rwlock";
+				break;
+			case KAPI_LOCK_SEMAPHORE:
+				type_str = "semaphore";
+				break;
+			case KAPI_LOCK_RCU:
+				type_str = "rcu";
+				break;
+			case KAPI_LOCK_SEQLOCK:
+				type_str = "seqlock";
+				break;
+			default:
+				type_str = "unknown";
+				break;
+			}
+			switch (lock->scope) {
+			case KAPI_LOCK_INTERNAL:
+				scope_str = "acquired and released";
+				break;
+			case KAPI_LOCK_ACQUIRES:
+				scope_str = "acquired (not released)";
+				break;
+			case KAPI_LOCK_RELEASES:
+				scope_str = "released (held on entry)";
+				break;
+			case KAPI_LOCK_CALLER_HELD:
+				scope_str = "held by caller";
+				break;
+			default:
+				scope_str = "unknown";
+				break;
+			}
+			seq_printf(m, "  %s (%s): %s\n",
+				   lock->lock_name, type_str, lock->description);
+			seq_printf(m, "    scope: %s\n", scope_str);
+		}
+		seq_puts(m, "\n");
+	}
+
+	/* Constraints */
+	if (spec->constraint_count > 0) {
+		seq_printf(m, "Additional constraints (%u):\n", spec->constraint_count);
+		for (i = 0; i < spec->constraint_count && i < KAPI_MAX_CONSTRAINTS; i++) {
+			struct kapi_constraint_spec *cons = &spec->constraints[i];
+
+			seq_printf(m, "  - %s", cons->name);
+			if (cons->description[0])
+				seq_printf(m, ": %s", cons->description);
+			seq_puts(m, "\n");
+			if (cons->expression[0])
+				seq_printf(m, "    expression: %s\n", cons->expression);
+		}
+		seq_puts(m, "\n");
+	}
+
+	/* Signals */
+	if (spec->signal_count > 0) {
+		seq_printf(m, "Signal handling (%u):\n", spec->signal_count);
+		for (i = 0; i < spec->signal_count && i < KAPI_MAX_SIGNALS; i++) {
+			struct kapi_signal_spec *sig = &spec->signals[i];
+			seq_printf(m, "  %s (%d):\n", sig->signal_name, sig->signal_num);
+			seq_puts(m, "    direction: ");
+			if (sig->direction & KAPI_SIGNAL_SEND)
+				seq_puts(m, "send ");
+			if (sig->direction & KAPI_SIGNAL_RECEIVE)
+				seq_puts(m, "receive ");
+			if (sig->direction & KAPI_SIGNAL_HANDLE)
+				seq_puts(m, "handle ");
+			if (sig->direction & KAPI_SIGNAL_BLOCK)
+				seq_puts(m, "block ");
+			if (sig->direction & KAPI_SIGNAL_IGNORE)
+				seq_puts(m, "ignore ");
+			seq_puts(m, "\n");
+			seq_puts(m, "    action: ");
+			switch (sig->action) {
+			case KAPI_SIGNAL_ACTION_DEFAULT:
+				seq_puts(m, "default");
+				break;
+			case KAPI_SIGNAL_ACTION_TERMINATE:
+				seq_puts(m, "terminate");
+				break;
+			case KAPI_SIGNAL_ACTION_COREDUMP:
+				seq_puts(m, "coredump");
+				break;
+			case KAPI_SIGNAL_ACTION_STOP:
+				seq_puts(m, "stop");
+				break;
+			case KAPI_SIGNAL_ACTION_CONTINUE:
+				seq_puts(m, "continue");
+				break;
+			case KAPI_SIGNAL_ACTION_CUSTOM:
+				seq_puts(m, "custom");
+				break;
+			case KAPI_SIGNAL_ACTION_RETURN:
+				seq_puts(m, "return");
+				break;
+			case KAPI_SIGNAL_ACTION_RESTART:
+				seq_puts(m, "restart");
+				break;
+			default:
+				seq_puts(m, "unknown");
+				break;
+			}
+			seq_puts(m, "\n");
+			if (strnlen(sig->description, sizeof(sig->description)) > 0)
+				seq_printf(m, "    description: %.*s\n",
+					   (int)sizeof(sig->description), sig->description);
+		}
+		seq_puts(m, "\n");
+	}
+
+	/* Side effects */
+	if (spec->side_effect_count > 0) {
+		seq_printf(m, "Side effects (%u):\n", spec->side_effect_count);
+		for (i = 0; i < spec->side_effect_count && i < KAPI_MAX_SIDE_EFFECTS; i++) {
+			const struct kapi_side_effect *eff = &spec->side_effects[i];
+
+			seq_printf(m, "  - %.*s",
+				   (int)sizeof(eff->target), eff->target);
+			if (strnlen(eff->description, sizeof(eff->description)) > 0)
+				seq_printf(m, ": %.*s",
+					   (int)sizeof(eff->description), eff->description);
+			if (eff->reversible)
+				seq_puts(m, " (reversible)");
+			seq_puts(m, "\n");
+		}
+		seq_puts(m, "\n");
+	}
+
+	/* State transitions */
+	if (spec->state_trans_count > 0) {
+		seq_printf(m, "State transitions (%u):\n", spec->state_trans_count);
+		for (i = 0; i < spec->state_trans_count && i < KAPI_MAX_STATE_TRANS; i++) {
+			const struct kapi_state_transition *trans = &spec->state_transitions[i];
+
+			seq_printf(m, "  %.*s: %.*s -> %.*s\n",
+				   (int)sizeof(trans->object), trans->object,
+				   (int)sizeof(trans->from_state), trans->from_state,
+				   (int)sizeof(trans->to_state), trans->to_state);
+			if (strnlen(trans->description, sizeof(trans->description)) > 0)
+				seq_printf(m, "    %.*s\n",
+					   (int)sizeof(trans->description), trans->description);
+		}
+		seq_puts(m, "\n");
+	}
+
+	/* Capabilities */
+	if (spec->capability_count > 0) {
+		seq_printf(m, "Capabilities (%u):\n", spec->capability_count);
+		for (i = 0; i < spec->capability_count && i < KAPI_MAX_CAPABILITIES; i++) {
+			const struct kapi_capability_spec *cap = &spec->capabilities[i];
+
+			seq_printf(m, "  %.*s (%d):\n",
+				   (int)sizeof(cap->cap_name), cap->cap_name,
+				   cap->capability);
+			if (strnlen(cap->allows, sizeof(cap->allows)) > 0)
+				seq_printf(m, "    allows: %.*s\n",
+					   (int)sizeof(cap->allows), cap->allows);
+			if (strnlen(cap->without_cap, sizeof(cap->without_cap)) > 0)
+				seq_printf(m, "    without: %.*s\n",
+					   (int)sizeof(cap->without_cap), cap->without_cap);
+		}
+		seq_puts(m, "\n");
+	}
+
+	/* Additional info */
+	if (strnlen(spec->examples, sizeof(spec->examples)) > 0) {
+		seq_printf(m, "Examples:\n%.*s\n\n",
+			   (int)sizeof(spec->examples), spec->examples);
+	}
+	if (strnlen(spec->notes, sizeof(spec->notes)) > 0) {
+		seq_printf(m, "Notes:\n%.*s\n\n",
+			   (int)sizeof(spec->notes), spec->notes);
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
+/*
+ * Show all available API specs.
+ *
+ * Note: This only iterates the static .kapi_specs section. Specs registered
+ * dynamically via kapi_register_spec() are not included in this listing
+ * or in the per-spec debugfs files.
+ */
+static int kapi_list_show(struct seq_file *m, void *v)
+{
+	struct kernel_api_spec *spec;
+	int count = 0;
+
+	seq_puts(m, "Available Kernel API Specifications\n");
+	seq_puts(m, "===================================\n\n");
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
+	for (spec = __start_kapi_specs; spec < __stop_kapi_specs; spec++)
+		debugfs_create_file(spec->name, 0444, spec_dir, spec, &kapi_spec_fops);
+
+	return 0;
+}
+
+/* Initialize as part of kernel, not as a module */
+fs_initcall(kapi_debugfs_init);
-- 
2.51.0



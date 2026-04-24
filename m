Return-Path: <linux-api+bounces-6170-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qCKaMbGh62mFPQAAu9opvQ
	(envelope-from <linux-api+bounces-6170-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Fri, 24 Apr 2026 19:00:33 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 890B34617B2
	for <lists+linux-api@lfdr.de>; Fri, 24 Apr 2026 19:00:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3C830303A3E7
	for <lists+linux-api@lfdr.de>; Fri, 24 Apr 2026 16:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61AC23EAC75;
	Fri, 24 Apr 2026 16:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HNxJpbxY"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 301BC3E95BC;
	Fri, 24 Apr 2026 16:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777049506; cv=none; b=rOfiuy+NVtvbbNMjJilRJA3fDzED3Tc6G8D7njrImKK9GZo87DyQfCvRtD5LYBZVmSX/E6pu0pwcRek90zQlCzbItoPwwuUOMffTglnA9LSpbJax1znbHzp8OY07vFwzxX7x4LbEiueUtBEPJDRynHi37Gwrz+4yGpzC0mglX8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777049506; c=relaxed/simple;
	bh=CuzfsCtQ4AsmqdkU0vPXCh+rITbi7e/d2TzVmD7ike0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pQei6jW8yoAcOb/kqLjxckXRBB7nZrutWUOQ+QkgSHR79E7fjqcCkfIsy9pJ8eTH6LTi1pbwFy45JxQroJS+KiAGUBVzoolWHMSs4w+X7X4P+QjX7sNiIfMRB93ocxGpRMEKoFmjCXgiRSl1L4H9ykQAQ8PLCTNy6TtJ7S2/sCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HNxJpbxY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AD6CC2BCC6;
	Fri, 24 Apr 2026 16:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777049505;
	bh=CuzfsCtQ4AsmqdkU0vPXCh+rITbi7e/d2TzVmD7ike0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HNxJpbxYNO/ZYWTyKTcKdRzsLP6Wmk/BYqw/rO9XsfAT5Vpn0p3c0mJXI7qmPdoRk
	 wZO/CFSbTIpRDjB5APKOoZzPwPyH35sB87Tdltrl/HY5uusPN7V4LbIzYDrErG1Spu
	 jZtM8C8EoQ1o+BHhWkRuHv6l8EomZkt539IQIgoQC4sTOTbgTHm3WdPWWjlujJvSqQ
	 AjB7m86irw5WDy8i+ZVs5yAVdTeIEY130Ldkz94BcgkA9MWOk1u6UC58Li1EBBXq7D
	 NxWLJnNIGcd817hdyMu5DdsGN1fC1rXPobT2nX+/yvowrDx2gfyF+vl344FeIXiqEu
	 bM/SmvlgUY7GQ==
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
Subject: [PATCH v3 3/9] kernel/api: add debugfs interface for kernel API specifications
Date: Fri, 24 Apr 2026 12:51:23 -0400
Message-ID: <20260424165130.2306833-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260424165130.2306833-1-sashal@kernel.org>
References: <20260424165130.2306833-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 890B34617B2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,linuxfoundation.org,lwn.net,google.com,infradead.org,suse.cz,gmail.com,zohomail.com,redhat.com,zeniv.linux.org.uk,linux-foundation.org,arndb.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6170-lists,linux-api=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[30];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,linux-api@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-api];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[]

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
 kernel/api/kapi_debugfs.c                   | 553 ++++++++++++++++++++
 2 files changed, 601 insertions(+), 1 deletion(-)
 create mode 100644 kernel/api/kapi_debugfs.c

diff --git a/Documentation/dev-tools/kernel-api-spec.rst b/Documentation/dev-tools/kernel-api-spec.rst
index 479bc78797ba8..49d53ba2e27f7 100644
--- a/Documentation/dev-tools/kernel-api-spec.rst
+++ b/Documentation/dev-tools/kernel-api-spec.rst
@@ -229,6 +229,7 @@ Runtime validation is controlled by kernel configuration:
 
 1. Enable ``CONFIG_KAPI_SPEC`` to build the framework
 2. Enable ``CONFIG_KAPI_RUNTIME_CHECKS`` for runtime validation
+3. Optionally enable ``CONFIG_KAPI_SPEC_DEBUGFS`` for debugfs interface
 
 Validation Behavior
 -------------------
@@ -269,6 +270,51 @@ custom validation functions via the ``validate`` field in the constraint spec:
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
 
@@ -641,7 +687,8 @@ Submitting Specifications
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
index 0000000000000..5a78287fc6cb8
--- /dev/null
+++ b/kernel/api/kapi_debugfs.c
@@ -0,0 +1,553 @@
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
+#include "internal.h"
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
+	if (spec->long_description && *spec->long_description)
+		seq_printf(m, "Long description: %s\n", spec->long_description);
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
+
+			seq_printf(m, "  [%d] %s:\n", i, param->name);
+			seq_printf(m, "    type: %s (%s)\n",
+				   param_type_str(param->type), param->type_name);
+			print_param_flags(m, param->flags);
+			if (param->description && *param->description)
+				seq_printf(m, "    description: %s\n", param->description);
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
+					seq_printf(m, "      valid_bits: 0x%llx\n",
+						   param->valid_mask);
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
+					if (param->constraints && *param->constraints)
+						seq_printf(m, "      description: %s\n",
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
+	if (spec->return_spec.description && *spec->return_spec.description)
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
+
+			seq_printf(m, "  %s (%d): %s\n",
+				   err->name, err->error_code, err->description);
+			if (err->condition && *err->condition)
+				seq_printf(m, "    condition: %s\n", err->condition);
+		}
+		seq_puts(m, "\n");
+	}
+
+	/* Locks */
+	if (spec->lock_count > 0) {
+		seq_printf(m, "Locks (%u):\n", spec->lock_count);
+		for (i = 0; i < spec->lock_count && i < KAPI_MAX_LOCKS; i++) {
+			struct kapi_lock_spec *lock = &spec->locks[i];
+			const char *type_str, *scope_str;
+
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
+			if (cons->description && *cons->description)
+				seq_printf(m, ": %s", cons->description);
+			seq_puts(m, "\n");
+			if (cons->expression && *cons->expression)
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
+
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
+			case KAPI_SIGNAL_ACTION_QUEUE:
+				seq_puts(m, "queue");
+				break;
+			case KAPI_SIGNAL_ACTION_DISCARD:
+				seq_puts(m, "discard");
+				break;
+			case KAPI_SIGNAL_ACTION_TRANSFORM:
+				seq_puts(m, "transform");
+				break;
+			default:
+				seq_puts(m, "unknown");
+				break;
+			}
+			seq_puts(m, "\n");
+			if (sig->description && *sig->description)
+				seq_printf(m, "    description: %s\n", sig->description);
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
+			seq_printf(m, "  - %s", eff->target);
+			if (eff->description && *eff->description)
+				seq_printf(m, ": %s", eff->description);
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
+			seq_printf(m, "  %s: %s -> %s\n", trans->object,
+				   trans->from_state, trans->to_state);
+			if (trans->description && *trans->description)
+				seq_printf(m, "    %s\n", trans->description);
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
+			seq_printf(m, "  %s (%d):\n", cap->cap_name,
+				   cap->capability);
+			if (cap->allows && *cap->allows)
+				seq_printf(m, "    allows: %s\n", cap->allows);
+			if (cap->without_cap && *cap->without_cap)
+				seq_printf(m, "    without: %s\n", cap->without_cap);
+		}
+		seq_puts(m, "\n");
+	}
+
+	/* Additional info */
+	if (spec->examples && *spec->examples)
+		seq_printf(m, "Examples:\n%s\n\n", spec->examples);
+	if (spec->notes && *spec->notes)
+		seq_printf(m, "Notes:\n%s\n\n", spec->notes);
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
+ * JSON view of a single spec.  Calls kapi_export_json() into a temporary
+ * buffer and pastes the result into the seq_file.  This gives userspace a
+ * machine-readable rendering that matches the output produced by
+ * kapi_export_json() from --vmlinux / --source tooling, so consumers can
+ * diff the three modes for equivalence.
+ */
+#define KAPI_JSON_BUF_SIZE	(64 * 1024)
+
+static int kapi_spec_json_show(struct seq_file *m, void *v)
+{
+	const struct kernel_api_spec *spec = m->private;
+	char *buf;
+	int ret;
+
+	if (!spec)
+		return -EINVAL;
+
+	buf = kmalloc(KAPI_JSON_BUF_SIZE, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	ret = kapi_export_json(spec, buf, KAPI_JSON_BUF_SIZE);
+	if (ret < 0) {
+		kfree(buf);
+		return ret;
+	}
+
+	seq_puts(m, buf);
+	kfree(buf);
+	return 0;
+}
+
+static int kapi_spec_json_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, kapi_spec_json_show, inode->i_private);
+}
+
+static const struct file_operations kapi_spec_json_fops = {
+	.open = kapi_spec_json_open,
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
+	const struct kernel_api_spec * const *pp;
+	int count = 0;
+
+	seq_puts(m, "Available Kernel API Specifications\n");
+	seq_puts(m, "===================================\n\n");
+
+	for (pp = __start_kapi_specs; pp < __stop_kapi_specs; pp++) {
+		const struct kernel_api_spec *spec = *pp;
+
+		if (!spec)
+			continue;
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
+	const struct kernel_api_spec * const *pp;
+	struct dentry *spec_dir, *json_dir;
+
+	kapi_debugfs_root = debugfs_create_dir("kapi", NULL);
+	if (IS_ERR(kapi_debugfs_root)) {
+		pr_warn("kapi: cannot create /sys/kernel/debug/kapi: %pe\n",
+			kapi_debugfs_root);
+		kapi_debugfs_root = NULL;
+		return 0;
+	}
+
+	debugfs_create_file("list", 0444, kapi_debugfs_root, NULL,
+			    &kapi_list_fops);
+	spec_dir = debugfs_create_dir("specs", kapi_debugfs_root);
+	json_dir = debugfs_create_dir("specs-json", kapi_debugfs_root);
+
+	for (pp = __start_kapi_specs; pp < __stop_kapi_specs; pp++) {
+		const struct kernel_api_spec *spec = *pp;
+
+		if (!spec || !spec->name)
+			continue;
+		debugfs_create_file(spec->name, 0444, spec_dir,
+				    (void *)spec, &kapi_spec_fops);
+		debugfs_create_file(spec->name, 0444, json_dir,
+				    (void *)spec, &kapi_spec_json_fops);
+	}
+
+	return 0;
+}
+
+/* Initialize as part of kernel, not as a module */
+fs_initcall(kapi_debugfs_init);
-- 
2.53.0



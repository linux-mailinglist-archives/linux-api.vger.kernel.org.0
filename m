Return-Path: <linux-api+bounces-3977-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F47AAE6E40
	for <lists+linux-api@lfdr.de>; Tue, 24 Jun 2025 20:10:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C70CB1647CB
	for <lists+linux-api@lfdr.de>; Tue, 24 Jun 2025 18:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E4E92EE5ED;
	Tue, 24 Jun 2025 18:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Eby8a/Sz"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE74E2EE27E;
	Tue, 24 Jun 2025 18:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750788476; cv=none; b=Dt1Kab6DmnWdgtw0eeBJ2acfTI+3uS6OP7gNPpdQ8TK8cXOKbmkqOFhEHCBJs/UpBHOKtNO6ZV/mGYe0nxHc6gBbZRDSA+tnF8Ib4rhyjLHUGNjovdMgG1uobgWoo/c93SOxrfBjRbkVoDvea42YPS4s2KhbE5j75mJksLMYWe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750788476; c=relaxed/simple;
	bh=YaXvH82Wn7hOPwrr6cenK1Mqp+OzEWeKAD/7wb9cCkg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Wfy2qF2jZyD7XrIArJaDYyZNSBjrHtE4jgEPGDkqqkXFfmHrLVdKHiVf6JH3KU1l6INGpRHUgBelLBjHGEJQRdCz5qHgVEdNxUuVNs8u3DmQnr8sepxPt+08EZfRgxfr99CGVe25cgvz33g6MxXlEa/Y5aCu0WS94ivLzaZ4nco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Eby8a/Sz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84D43C4CEE3;
	Tue, 24 Jun 2025 18:07:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750788475;
	bh=YaXvH82Wn7hOPwrr6cenK1Mqp+OzEWeKAD/7wb9cCkg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Eby8a/Szp3WaAFzD4vcTpRdJsDbbtoqVKqtMx3Roo9oVXpBMeMLAAX8vmv/6KQoA2
	 PtbWuFTEw1dbYBYckZiH691F+z8Q/+Atdwsvn29+KlK3tIRLdPkiLet0clpFOWUd5c
	 OsEgZ1gvbOd3uBq2hSYOMUOegKbfiygIzoH/f/hSCwYlcE9rNxniHN/R+c8tGcO6EK
	 mDHa/pMGc8dv0aKS6JHMfALv0a/CllEerXh2PP+3zdk5P6t0rTE5La+SutrV+5TBXd
	 CD5FCWgwhhLYWhiK3kR1wZzXvnLcQ/WH6jujWzNajYCEuYejdnJI7dlGWB6brv3EG/
	 gojVtGjDNMhRQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-doc@vger.kernel.org,
	linux-api@vger.kernel.org,
	workflows@vger.kernel.org,
	tools@kernel.org,
	Sasha Levin <sashal@kernel.org>
Subject: [RFC v2 16/22] kernel/api: add IOCTL specification infrastructure
Date: Tue, 24 Jun 2025 14:07:36 -0400
Message-Id: <20250624180742.5795-17-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250624180742.5795-1-sashal@kernel.org>
References: <20250624180742.5795-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add IOCTL API specification support to the kernel API specification
framework. This enables detailed documentation and runtime validation of
IOCTL interfaces.

Key features:
- IOCTL specification structure with command info and parameter details
- Registration/unregistration functions for IOCTL specs
- Helper macros for defining IOCTL specifications
- KAPI_IOCTL_SPEC_DRIVER macro for simplified driver integration
- Runtime validation support with KAPI_DEFINE_FOPS wrapper
- Validation of IOCTL parameters and return values
- Integration with existing kernel API spec infrastructure

The validation framework checks:
- Parameter constraints (ranges, enums, masks)
- User pointer validity
- Buffer size constraints
- Return value correctness against specification

Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/kernel_api_spec.h | 199 +++++++++++++++++-
 kernel/api/Makefile             |   5 +-
 kernel/api/ioctl_validation.c   | 355 ++++++++++++++++++++++++++++++++
 kernel/api/kernel_api_spec.c    |  89 +++++++-
 4 files changed, 642 insertions(+), 6 deletions(-)
 create mode 100644 kernel/api/ioctl_validation.c

diff --git a/include/linux/kernel_api_spec.h b/include/linux/kernel_api_spec.h
index 1ee76a5f3ee1f..4be9636b19158 100644
--- a/include/linux/kernel_api_spec.h
+++ b/include/linux/kernel_api_spec.h
@@ -779,6 +779,13 @@ struct kernel_api_spec {
 	char connection_termination[KAPI_MAX_DESC_LEN];
 	char data_transfer_semantics[KAPI_MAX_DESC_LEN];
 #endif /* CONFIG_NET */
+
+	/* IOCTL-specific fields */
+	unsigned int cmd;			/* IOCTL command number */
+	char cmd_name[KAPI_MAX_NAME_LEN];	/* Human-readable command name */
+	size_t input_size;			/* Size of input structure (0 if none) */
+	size_t output_size;			/* Size of output structure (0 if none) */
+	char file_ops_name[KAPI_MAX_NAME_LEN];	/* Name of the file_operations structure */
 } __attribute__((packed));
 
 /* Macros for defining API specifications */
@@ -963,6 +970,13 @@ struct kernel_api_spec {
 #define KAPI_NOTES(n) \
 	.notes = n,
 
+/**
+ * KAPI_SINCE_VERSION - Set the since version
+ * @version: Version string when the API was introduced
+ */
+#define KAPI_SINCE_VERSION(version) \
+	.since_version = version,
+
 /**
  * KAPI_DEPRECATED - Mark API as deprecated
  */
@@ -1105,10 +1119,10 @@ struct kernel_api_spec {
 			.constraint_type = KAPI_CONSTRAINT_MASK, \
 			.valid_mask = mask,
 
-#define KAPI_FIELD_CONSTRAINT_ENUM(values, count) \
+#define KAPI_FIELD_CONSTRAINT_ENUM(...) \
 			.constraint_type = KAPI_CONSTRAINT_ENUM, \
-			.enum_values = values, \
-			.enum_count = count,
+			.enum_values = __VA_ARGS__, \
+			.enum_count = ARRAY_SIZE(__VA_ARGS__),
 
 #define KAPI_STRUCT_FIELD_END },
 
@@ -1171,6 +1185,20 @@ struct kernel_api_spec {
 #define KAPI_STATE_TRANS_COUNT(n) \
 	.state_trans_count = n,
 
+/**
+ * KAPI_ERROR_COUNT - Set the error count
+ * @count: Number of errors defined
+ */
+#define KAPI_ERROR_COUNT(count) \
+	.error_count = count,
+
+/**
+ * KAPI_PARAM_COUNT - Set the parameter count
+ * @count: Number of parameters defined
+ */
+#define KAPI_PARAM_COUNT(count) \
+	.param_count = count,
+
 /* Helper macros for common side effect patterns */
 #define KAPI_EFFECTS_MEMORY	(KAPI_EFFECT_ALLOC_MEMORY | KAPI_EFFECT_FREE_MEMORY)
 #define KAPI_EFFECTS_LOCKING	(KAPI_EFFECT_LOCK_ACQUIRE | KAPI_EFFECT_LOCK_RELEASE)
@@ -1183,7 +1211,7 @@ struct kernel_api_spec {
 #define KAPI_PARAM_OUT		(KAPI_PARAM_OUT)
 #define KAPI_PARAM_INOUT	(KAPI_PARAM_IN | KAPI_PARAM_OUT)
 #define KAPI_PARAM_OPTIONAL	(KAPI_PARAM_OPTIONAL)
-#define KAPI_PARAM_USER_PTR	(KAPI_PARAM_USER | KAPI_PARAM_PTR)
+#define KAPI_PARAM_USER_PTR	(KAPI_PARAM_USER)
 
 /* Common signal timing constants */
 #define KAPI_SIGNAL_TIME_ENTRY		"entry"
@@ -1495,6 +1523,169 @@ static inline bool kapi_get_param_constraint(const char *api_name, int param_idx
 #define KAPI_CONSTRAINT_COUNT(n) \
 	.constraint_count = n,
 
+/* IOCTL-specific functions */
+#ifdef CONFIG_KAPI_SPEC
+int kapi_register_ioctl_spec(const struct kernel_api_spec *spec);
+void kapi_unregister_ioctl_spec(unsigned int cmd);
+const struct kernel_api_spec *kapi_get_ioctl_spec(unsigned int cmd);
+
+#ifdef CONFIG_KAPI_RUNTIME_CHECKS
+struct file;
+int kapi_validate_ioctl(struct file *filp, unsigned int cmd, void __user *arg);
+int kapi_validate_ioctl_struct(const struct kernel_api_spec *spec,
+                               const void *data, size_t size);
+
+/* IOCTL validation wrapper support */
+struct kapi_fops_wrapper {
+	const struct file_operations *real_fops;
+	struct file_operations *wrapped_fops;
+	long (*real_ioctl)(struct file *, unsigned int, unsigned long);
+};
+
+void kapi_register_wrapper(struct kapi_fops_wrapper *wrapper);
+long kapi_ioctl_validation_wrapper(struct file *filp, unsigned int cmd,
+                                   unsigned long arg);
+
+/* Macro for defining file operations with automatic IOCTL validation */
+#define KAPI_DEFINE_FOPS(name, ...) \
+static const struct file_operations __kapi_real_##name = { \
+	__VA_ARGS__ \
+}; \
+static struct file_operations __kapi_wrapped_##name; \
+static struct kapi_fops_wrapper __kapi_wrapper_##name; \
+static const struct file_operations *name; \
+static void kapi_init_fops_##name(void) \
+{ \
+	if (__kapi_real_##name.unlocked_ioctl) { \
+		__kapi_wrapped_##name = __kapi_real_##name; \
+		__kapi_wrapper_##name.real_fops = &__kapi_real_##name; \
+		__kapi_wrapper_##name.wrapped_fops = &__kapi_wrapped_##name; \
+		__kapi_wrapper_##name.real_ioctl = \
+			__kapi_real_##name.unlocked_ioctl; \
+		__kapi_wrapped_##name.unlocked_ioctl = \
+			kapi_ioctl_validation_wrapper; \
+		kapi_register_wrapper(&__kapi_wrapper_##name); \
+		name = &__kapi_wrapped_##name; \
+	} else { \
+		name = &__kapi_real_##name; \
+	} \
+}
+
+#else /* !CONFIG_KAPI_RUNTIME_CHECKS */
+
+/* When runtime checks are disabled, no wrapping occurs */
+#define KAPI_DEFINE_FOPS(name, ...) \
+static const struct file_operations name = { __VA_ARGS__ }; \
+static inline void kapi_init_fops_##name(void) {}
+
+#endif /* CONFIG_KAPI_RUNTIME_CHECKS */
+#else /* !CONFIG_KAPI_SPEC */
+static inline int kapi_register_ioctl_spec(const struct kernel_api_spec *spec)
+{
+	return 0;
+}
+static inline void kapi_unregister_ioctl_spec(unsigned int cmd) {}
+static inline const struct kernel_api_spec *kapi_get_ioctl_spec(unsigned int cmd)
+{
+	return NULL;
+}
+#endif /* CONFIG_KAPI_SPEC */
+
+/* IOCTL-specific macros */
+
+/**
+ * DEFINE_KAPI_IOCTL_SPEC - Define an IOCTL API specification using kernel_api_spec
+ * @ioctl_name: IOCTL command name/identifier
+ */
+#define DEFINE_KAPI_IOCTL_SPEC(ioctl_name) \
+	static struct kernel_api_spec __kapi_ioctl_spec_##ioctl_name \
+	__used __section(".kapi_specs") = {	\
+		.name = __stringify(ioctl_name),	\
+		.api_type = KAPI_API_IOCTL,	\
+		.version = 1,
+
+/**
+ * KAPI_IOCTL_CMD - Set the IOCTL command number
+ * @cmd_val: The IOCTL command value
+ */
+#define KAPI_IOCTL_CMD(cmd_val) \
+	.cmd = cmd_val,
+
+/**
+ * KAPI_IOCTL_CMD_NAME - Set the IOCTL command name
+ * @name_str: String name of the command
+ */
+#define KAPI_IOCTL_CMD_NAME(name_str) \
+	.cmd_name = name_str,
+
+/**
+ * KAPI_IOCTL_INPUT_SIZE - Set the input structure size
+ * @size: Size of the input structure
+ */
+#define KAPI_IOCTL_INPUT_SIZE(size) \
+	.input_size = size,
+
+/**
+ * KAPI_IOCTL_OUTPUT_SIZE - Set the output structure size
+ * @size: Size of the output structure
+ */
+#define KAPI_IOCTL_OUTPUT_SIZE(size) \
+	.output_size = size,
+
+/**
+ * KAPI_IOCTL_FILE_OPS_NAME - Set the file operations name
+ * @ops_name: Name of the file_operations structure
+ */
+#define KAPI_IOCTL_FILE_OPS_NAME(ops_name) \
+	.file_ops_name = ops_name,
+
+/**
+ * Common IOCTL parameter specifications
+ */
+#define KAPI_IOCTL_PARAM_SIZE							\
+	KAPI_PARAM(0, "size", "__u32", "Size of the structure")		\
+		KAPI_PARAM_FLAGS(KAPI_PARAM_IN)					\
+		.type = KAPI_TYPE_UINT,						\
+		.constraint_type = KAPI_CONSTRAINT_CUSTOM,			\
+		.constraints = "Must match sizeof(struct)",			\
+	KAPI_PARAM_END
+
+#define KAPI_IOCTL_PARAM_FLAGS							\
+	KAPI_PARAM(1, "flags", "__u32", "Feature flags")			\
+		KAPI_PARAM_FLAGS(KAPI_PARAM_IN)					\
+		.type = KAPI_TYPE_UINT,						\
+		.constraint_type = KAPI_CONSTRAINT_MASK,			\
+		.valid_mask = 0,	/* 0 means no flags currently */	\
+	KAPI_PARAM_END
+
+/**
+ * KAPI_IOCTL_PARAM_USER_BUF - User buffer parameter
+ * @idx: Parameter index
+ * @name: Parameter name
+ * @desc: Parameter description
+ * @len_idx: Index of the length parameter
+ */
+#define KAPI_IOCTL_PARAM_USER_BUF(idx, name, desc, len_idx)		\
+	KAPI_PARAM(idx, name, "__aligned_u64", desc)			\
+		KAPI_PARAM_FLAGS(KAPI_PARAM_IN | KAPI_PARAM_USER_PTR)	\
+		.type = KAPI_TYPE_USER_PTR,				\
+		.size_param_idx = len_idx,				\
+	KAPI_PARAM_END
+
+/**
+ * KAPI_IOCTL_PARAM_USER_OUT_BUF - User output buffer parameter
+ * @idx: Parameter index
+ * @name: Parameter name
+ * @desc: Parameter description
+ * @len_idx: Index of the length parameter
+ */
+#define KAPI_IOCTL_PARAM_USER_OUT_BUF(idx, name, desc, len_idx)	\
+	KAPI_PARAM(idx, name, "__aligned_u64", desc)			\
+		KAPI_PARAM_FLAGS(KAPI_PARAM_OUT | KAPI_PARAM_USER_PTR)	\
+		.type = KAPI_TYPE_USER_PTR,				\
+		.size_param_idx = len_idx,				\
+	KAPI_PARAM_END
+
 /* Network operation characteristics macros */
 #define KAPI_NET_CONNECTION_ORIENTED \
 	.is_connection_oriented = true,
diff --git a/kernel/api/Makefile b/kernel/api/Makefile
index 07b8c007ec156..9d2daf38f0029 100644
--- a/kernel/api/Makefile
+++ b/kernel/api/Makefile
@@ -6,5 +6,8 @@
 # Core API specification framework
 obj-$(CONFIG_KAPI_SPEC)		+= kernel_api_spec.o
 
+# IOCTL validation framework
+obj-$(CONFIG_KAPI_SPEC)		+= ioctl_validation.o
+
 # Debugfs interface for kernel API specs
-obj-$(CONFIG_KAPI_SPEC_DEBUGFS)	+= kapi_debugfs.o
\ No newline at end of file
+obj-$(CONFIG_KAPI_SPEC_DEBUGFS)	+= kapi_debugfs.o
diff --git a/kernel/api/ioctl_validation.c b/kernel/api/ioctl_validation.c
new file mode 100644
index 0000000000000..cf3aa761eec2b
--- /dev/null
+++ b/kernel/api/ioctl_validation.c
@@ -0,0 +1,355 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * ioctl_validation.c - Runtime validation for IOCTL API specifications
+ *
+ * Provides functions to validate ioctl parameters against their specifications
+ * at runtime when CONFIG_KAPI_RUNTIME_CHECKS is enabled.
+ */
+
+#include <linux/kernel.h>
+#include <linux/kernel_api_spec.h>
+#include <linux/uaccess.h>
+#include <linux/file.h>
+#include <linux/fs.h>
+#include <linux/slab.h>
+#include <linux/container_of.h>
+#include <linux/export.h>
+#include <uapi/fwctl/fwctl.h>
+
+#ifdef CONFIG_KAPI_RUNTIME_CHECKS
+
+/**
+ * kapi_validate_ioctl - Validate an ioctl call against its specification
+ * @filp: File pointer
+ * @cmd: IOCTL command
+ * @arg: IOCTL argument
+ *
+ * Return: 0 if valid, negative errno if validation fails
+ */
+int kapi_validate_ioctl(struct file *filp, unsigned int cmd, void __user *arg)
+{
+	const struct kernel_api_spec *spec;
+	void *data = NULL;
+	size_t copy_size;
+	int ret = 0;
+	int i;
+
+	spec = kapi_get_ioctl_spec(cmd);
+	if (!spec)
+		return 0; /* No spec, can't validate */
+
+	pr_debug("kapi: validating ioctl %s (0x%x)\n", spec->cmd_name, cmd);
+
+	/* Check if this ioctl requires specific capabilities */
+	if (spec->param_count > 0) {
+		for (i = 0; i < spec->param_count; i++) {
+			const struct kapi_param_spec *param = &spec->params[i];
+
+			/* Check for capability requirements in constraints */
+			if (param->constraint_type == KAPI_CONSTRAINT_CUSTOM &&
+			    param->constraints[0] && strstr(param->constraints, "CAP_")) {
+				/* Could add capability checks here if needed */
+			}
+		}
+	}
+
+	/* For ioctls with input/output structures, copy and validate */
+	if (spec->input_size > 0 || spec->output_size > 0) {
+		copy_size = max(spec->input_size, spec->output_size);
+
+		/* Allocate temporary buffer for validation */
+		data = kzalloc(copy_size, GFP_KERNEL);
+		if (!data)
+			return -ENOMEM;
+
+		/* Copy input data from user */
+		if (spec->input_size > 0) {
+			ret = copy_from_user(data, arg, spec->input_size);
+			if (ret) {
+				ret = -EFAULT;
+				goto out;
+			}
+		}
+
+		/* Validate structure fields */
+		ret = kapi_validate_ioctl_struct(spec, data, copy_size);
+		if (ret)
+			goto out;
+	}
+
+out:
+	kfree(data);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(kapi_validate_ioctl);
+
+/**
+ * struct field_offset - Maps structure fields to their offsets
+ * @field_idx: Parameter index
+ * @offset: Offset in structure
+ * @size: Size of field
+ */
+struct field_offset {
+	int field_idx;
+	size_t offset;
+	size_t size;
+};
+
+/* Common ioctl structure layouts */
+static const struct field_offset fwctl_info_offsets[] = {
+	{0, 0, sizeof(u32)},  /* size */
+	{1, 4, sizeof(u32)},  /* flags */
+	{2, 8, sizeof(u32)},  /* out_device_type */
+	{3, 12, sizeof(u32)}, /* device_data_len */
+	{4, 16, sizeof(u64)}, /* out_device_data */
+};
+
+static const struct field_offset fwctl_rpc_offsets[] = {
+	{0, 0, sizeof(u32)},  /* size */
+	{1, 4, sizeof(u32)},  /* scope */
+	{2, 8, sizeof(u32)},  /* in_len */
+	{3, 12, sizeof(u32)}, /* out_len */
+	{4, 16, sizeof(u64)}, /* in */
+	{5, 24, sizeof(u64)}, /* out */
+};
+
+/**
+ * get_field_offsets - Get field offset information for an ioctl
+ * @cmd: IOCTL command
+ * @count: Returns number of fields
+ *
+ * Return: Array of field offsets or NULL
+ */
+static const struct field_offset *get_field_offsets(unsigned int cmd, int *count)
+{
+	switch (cmd) {
+	case FWCTL_INFO:
+		*count = ARRAY_SIZE(fwctl_info_offsets);
+		return fwctl_info_offsets;
+	case FWCTL_RPC:
+		*count = ARRAY_SIZE(fwctl_rpc_offsets);
+		return fwctl_rpc_offsets;
+	default:
+		*count = 0;
+		return NULL;
+	}
+}
+
+/**
+ * extract_field_value - Extract a field value from structure
+ * @data: Structure data
+ * @param: Parameter specification
+ * @offset_info: Field offset information
+ *
+ * Return: Field value or 0 on error
+ */
+static s64 extract_field_value(const void *data,
+			       const struct kapi_param_spec *param,
+			       const struct field_offset *offset_info)
+{
+	const void *field = data + offset_info->offset;
+
+	switch (param->type) {
+	case KAPI_TYPE_UINT:
+		if (offset_info->size == sizeof(u32))
+			return *(u32 *)field;
+		else if (offset_info->size == sizeof(u64))
+			return *(u64 *)field;
+		break;
+	case KAPI_TYPE_INT:
+		if (offset_info->size == sizeof(s32))
+			return *(s32 *)field;
+		else if (offset_info->size == sizeof(s64))
+			return *(s64 *)field;
+		break;
+	case KAPI_TYPE_USER_PTR:
+		/* User pointers are typically u64 in ioctl structures */
+		return (s64)(*(u64 *)field);
+	default:
+		break;
+	}
+
+	return 0;
+}
+
+/**
+ * kapi_validate_ioctl_struct - Validate an ioctl structure against specification
+ * @spec: IOCTL specification
+ * @data: Structure data
+ * @size: Size of the structure
+ *
+ * Return: 0 if valid, negative errno if validation fails
+ */
+int kapi_validate_ioctl_struct(const struct kernel_api_spec *spec,
+				const void *data, size_t size)
+{
+	const struct field_offset *offsets;
+	int offset_count;
+	int i, j;
+
+	if (!spec || !data)
+		return -EINVAL;
+
+	/* Get field offset information for this ioctl */
+	offsets = get_field_offsets(spec->cmd, &offset_count);
+
+	/* Validate each parameter in the structure */
+	for (i = 0; i < spec->param_count && i < KAPI_MAX_PARAMS; i++) {
+		const struct kapi_param_spec *param = &spec->params[i];
+		const struct field_offset *offset_info = NULL;
+		s64 value;
+
+		/* Find offset information for this parameter */
+		if (offsets) {
+			for (j = 0; j < offset_count; j++) {
+				if (offsets[j].field_idx == i) {
+					offset_info = &offsets[j];
+					break;
+				}
+			}
+		}
+
+		if (!offset_info) {
+			pr_debug("kapi: no offset info for param %d\n", i);
+			continue;
+		}
+
+		/* Extract field value */
+		value = extract_field_value(data, param, offset_info);
+
+		/* Special handling for user pointers */
+		if (param->type == KAPI_TYPE_USER_PTR) {
+			/* Check if pointer looks valid (non-kernel address) */
+			if (value && (value >= TASK_SIZE)) {
+				pr_warn("ioctl %s: parameter %s has kernel pointer %llx\n",
+					spec->cmd_name, param->name, value);
+				return -EINVAL;
+			}
+
+			/* For size validation, check against size_param_idx */
+			if (param->size_param_idx >= 0 &&
+			    param->size_param_idx < offset_count) {
+				const struct field_offset *size_offset = NULL;
+
+				for (j = 0; j < offset_count; j++) {
+					if (offsets[j].field_idx == param->size_param_idx) {
+						size_offset = &offsets[j];
+						break;
+					}
+				}
+
+				if (size_offset) {
+					s64 buf_size = extract_field_value(data,
+						&spec->params[param->size_param_idx],
+						size_offset);
+
+					/* Validate buffer size constraints */
+					if (buf_size > 0 &&
+					    !kapi_validate_param(&spec->params[param->size_param_idx],
+								 buf_size)) {
+						pr_warn("ioctl %s: buffer size %lld invalid for %s\n",
+							spec->cmd_name, buf_size, param->name);
+						return -EINVAL;
+					}
+				}
+			}
+		} else {
+			/* Validate using the standard parameter validation */
+			if (!kapi_validate_param(param, value)) {
+				pr_warn("ioctl %s: parameter %s validation failed (value=%lld)\n",
+					spec->cmd_name, param->name, value);
+				return -EINVAL;
+			}
+		}
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(kapi_validate_ioctl_struct);
+
+/* Global registry of wrappers - in real implementation this would be per-module */
+static struct kapi_fops_wrapper *kapi_global_wrapper;
+
+/**
+ * kapi_register_wrapper - Register a wrapper (called from macro)
+ * @wrapper: Wrapper to register
+ */
+void kapi_register_wrapper(struct kapi_fops_wrapper *wrapper)
+{
+	/* Simple implementation - just store the last one */
+	kapi_global_wrapper = wrapper;
+}
+EXPORT_SYMBOL_GPL(kapi_register_wrapper);
+
+/**
+ * kapi_find_wrapper - Find wrapper for given file_operations
+ * @fops: File operations structure to check
+ *
+ * Return: Wrapper structure or NULL if not wrapped
+ */
+static struct kapi_fops_wrapper *kapi_find_wrapper(const struct file_operations *fops)
+{
+	/* Simple implementation - just return the global one if it matches */
+	if (kapi_global_wrapper && kapi_global_wrapper->wrapped_fops == fops)
+		return kapi_global_wrapper;
+	return NULL;
+}
+
+/**
+ * kapi_ioctl_validation_wrapper - Wrapper function for transparent validation
+ * @filp: File pointer
+ * @cmd: IOCTL command
+ * @arg: User argument
+ *
+ * This function is called instead of the real ioctl handler when validation
+ * is enabled. It performs pre-validation, calls the real handler, then does
+ * post-validation.
+ *
+ * Return: Result from the real ioctl handler or error
+ */
+long kapi_ioctl_validation_wrapper(struct file *filp, unsigned int cmd,
+				   unsigned long arg)
+{
+	struct kapi_fops_wrapper *wrapper;
+	const struct kernel_api_spec *spec;
+	long ret;
+
+	wrapper = kapi_find_wrapper(filp->f_op);
+	if (!wrapper || !wrapper->real_ioctl)
+		return -EINVAL;
+
+	/* Pre-validation */
+	spec = kapi_get_ioctl_spec(cmd);
+	if (spec) {
+		ret = kapi_validate_ioctl(filp, cmd, (void __user *)arg);
+		if (ret)
+			return ret;
+	}
+
+	/* Call the real ioctl handler */
+	ret = wrapper->real_ioctl(filp, cmd, arg);
+
+	/* Post-validation - check return value against spec */
+	if (spec && spec->error_count > 0) {
+		/* Validate that returned error is in the spec */
+		if (ret < 0) {
+			int i;
+			bool found = false;
+			for (i = 0; i < spec->error_count; i++) {
+				if (ret == spec->errors[i].error_code) {
+					found = true;
+					break;
+				}
+			}
+			if (!found) {
+				pr_warn("IOCTL %s returned unexpected error %ld\n",
+					spec->cmd_name, ret);
+			}
+		}
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(kapi_ioctl_validation_wrapper);
+
+#endif /* CONFIG_KAPI_RUNTIME_CHECKS */
diff --git a/kernel/api/kernel_api_spec.c b/kernel/api/kernel_api_spec.c
index 8827e9f96c111..7be653ac2333b 100644
--- a/kernel/api/kernel_api_spec.c
+++ b/kernel/api/kernel_api_spec.c
@@ -1119,4 +1119,91 @@ static int __init kapi_debugfs_init(void)
 
 late_initcall(kapi_debugfs_init);
 
-#endif /* CONFIG_DEBUG_FS */
\ No newline at end of file
+#endif /* CONFIG_DEBUG_FS */
+
+/* IOCTL specification registry */
+#ifdef CONFIG_KAPI_SPEC
+
+
+static DEFINE_MUTEX(ioctl_spec_mutex);
+static LIST_HEAD(ioctl_specs);
+
+struct ioctl_spec_entry {
+	struct list_head list;
+	const struct kernel_api_spec *spec;
+};
+
+/**
+ * kapi_register_ioctl_spec - Register an IOCTL API specification
+ * @spec: IOCTL specification to register
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+int kapi_register_ioctl_spec(const struct kernel_api_spec *spec)
+{
+	struct ioctl_spec_entry *entry;
+
+	if (!spec || spec->cmd_name[0] == '\0')
+		return -EINVAL;
+
+	entry = kzalloc(sizeof(*entry), GFP_KERNEL);
+	if (!entry)
+		return -ENOMEM;
+
+	entry->spec = spec;
+
+	mutex_lock(&ioctl_spec_mutex);
+	list_add_tail(&entry->list, &ioctl_specs);
+	mutex_unlock(&ioctl_spec_mutex);
+
+	pr_debug("Registered IOCTL spec: %s (0x%x)\n", spec->cmd_name, spec->cmd);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(kapi_register_ioctl_spec);
+
+/**
+ * kapi_unregister_ioctl_spec - Unregister an IOCTL API specification
+ * @cmd: IOCTL command number to unregister
+ */
+void kapi_unregister_ioctl_spec(unsigned int cmd)
+{
+	struct ioctl_spec_entry *entry, *tmp;
+
+	mutex_lock(&ioctl_spec_mutex);
+	list_for_each_entry_safe(entry, tmp, &ioctl_specs, list) {
+		if (entry->spec->cmd == cmd) {
+			list_del(&entry->list);
+			kfree(entry);
+			pr_debug("Unregistered IOCTL spec for cmd 0x%x\n", cmd);
+			break;
+		}
+	}
+	mutex_unlock(&ioctl_spec_mutex);
+}
+EXPORT_SYMBOL_GPL(kapi_unregister_ioctl_spec);
+
+/**
+ * kapi_get_ioctl_spec - Retrieve IOCTL specification by command number
+ * @cmd: IOCTL command number
+ *
+ * Return: Pointer to the specification or NULL if not found
+ */
+const struct kernel_api_spec *kapi_get_ioctl_spec(unsigned int cmd)
+{
+	struct ioctl_spec_entry *entry;
+	const struct kernel_api_spec *spec = NULL;
+
+	mutex_lock(&ioctl_spec_mutex);
+	list_for_each_entry(entry, &ioctl_specs, list) {
+		if (entry->spec->cmd == cmd) {
+			spec = entry->spec;
+			break;
+		}
+	}
+	mutex_unlock(&ioctl_spec_mutex);
+
+	return spec;
+}
+EXPORT_SYMBOL_GPL(kapi_get_ioctl_spec);
+
+#endif /* CONFIG_KAPI_SPEC */
-- 
2.39.5



Return-Path: <linux-api+bounces-3922-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7B4DAD9D29
	for <lists+linux-api@lfdr.de>; Sat, 14 Jun 2025 15:52:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1FD33A7CFE
	for <lists+linux-api@lfdr.de>; Sat, 14 Jun 2025 13:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BF1C2EA493;
	Sat, 14 Jun 2025 13:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L+F/2xVY"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 105922EA486;
	Sat, 14 Jun 2025 13:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749908957; cv=none; b=QfYrCuIKBC/T42x1ADhM2LASTkA9GnZQKV80beM2RdxPFzeUYkYbSvpzg/aymFfgEK610vUW12M/8KME9AZt+QN6as04tr7cBirbNio+5vBSkO6AzSHD/UmiFBtSOzTH/oNW8cuspngnnPp1r44MET8qdVrlKwb8UhapE8eXD4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749908957; c=relaxed/simple;
	bh=GI44pLwmhBFun8knb7fvgIc7M6bBnm5MRa+vS7fKwr4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Of0V+WhkaMQfiNkztgkhN+0kZwt9b5+fnr3pnfEwGETaGjS7yMepeOeXKLEnyB8+xUMSU4eAdYoLeRMso4aSo1yhZWAQDeIhcq775m9BIsTiwXo3pF93L2OggI3V+9N3yO2i5ChhvmIT/QHMh7p7KoOIyKh1uB6sLvFgUhBoDx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L+F/2xVY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 081E9C4CEF1;
	Sat, 14 Jun 2025 13:49:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749908955;
	bh=GI44pLwmhBFun8knb7fvgIc7M6bBnm5MRa+vS7fKwr4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L+F/2xVYT9Rfkf2heHdSWUjzyn1HxlZbdab0/2+LyZudEA1u/SE7d9XsQxFyPu/q4
	 r/6irRC862b0by83XBD4oKuObnWc5ZOzbh7Z5Cf+CGJRtmDNf3kx1ocqpjjkKUYP0I
	 ogQ+n8Ypb4xv1ZmhBxjY2HTvpxJQXC5UcwE1Gv9Cng9dmnmr1U2LXLo+hgrvo6mmz+
	 teLJpiiEuSrID4G+Q1p+bl9ApzdI7nOoIvF+UXr3Dq8aeeK7boJiO/HckkFkgQ3SEq
	 h2jIQ1W3AlMnLnB3SYdW7fOO64SLhY02I5kYi/IyYaYoN/IIiE0TQBhCz+iY9nLV4N
	 TSWwBW1Qz43+A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-api@vger.kernel.org,
	workflows@vger.kernel.org,
	tools@kernel.org,
	Sasha Levin <sashal@kernel.org>
Subject: [RFC 16/19] kernel/api: add IOCTL specification infrastructure
Date: Sat, 14 Jun 2025 09:48:55 -0400
Message-Id: <20250614134858.790460-17-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250614134858.790460-1-sashal@kernel.org>
References: <20250614134858.790460-1-sashal@kernel.org>
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
 include/linux/ioctl_api_spec.h  | 540 ++++++++++++++++++++++++++++++++
 include/linux/kernel_api_spec.h |   2 +-
 kernel/api/Makefile             |   5 +-
 kernel/api/ioctl_validation.c   | 360 +++++++++++++++++++++
 kernel/api/kernel_api_spec.c    |  90 +++++-
 5 files changed, 994 insertions(+), 3 deletions(-)
 create mode 100644 include/linux/ioctl_api_spec.h
 create mode 100644 kernel/api/ioctl_validation.c

diff --git a/include/linux/ioctl_api_spec.h b/include/linux/ioctl_api_spec.h
new file mode 100644
index 0000000000000..ab3337449ad77
--- /dev/null
+++ b/include/linux/ioctl_api_spec.h
@@ -0,0 +1,540 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * ioctl_api_spec.h - IOCTL API specification framework
+ *
+ * Extends the kernel API specification framework to support ioctl validation
+ * and documentation.
+ */
+
+#ifndef _LINUX_IOCTL_API_SPEC_H
+#define _LINUX_IOCTL_API_SPEC_H
+
+#include <linux/kernel_api_spec.h>
+#include <linux/ioctl.h>
+#include <linux/types.h>
+
+/* Forward declarations */
+struct file;
+
+/**
+ * struct kapi_ioctl_spec - IOCTL-specific API specification
+ * @api_spec: Base API specification
+ * @cmd: IOCTL command number
+ * @cmd_name: Human-readable command name
+ * @input_size: Size of input structure (0 if none)
+ * @output_size: Size of output structure (0 if none)
+ * @file_ops_name: Name of the file_operations structure
+ */
+struct kapi_ioctl_spec {
+	struct kernel_api_spec api_spec;
+	unsigned int cmd;
+	const char *cmd_name;
+	size_t input_size;
+	size_t output_size;
+	const char *file_ops_name;
+};
+
+/* Registry functions for IOCTL specifications */
+#ifdef CONFIG_KAPI_SPEC
+int kapi_register_ioctl_spec(const struct kapi_ioctl_spec *spec);
+void kapi_unregister_ioctl_spec(unsigned int cmd);
+const struct kapi_ioctl_spec *kapi_get_ioctl_spec(unsigned int cmd);
+
+/* IOCTL validation functions */
+#ifdef CONFIG_KAPI_RUNTIME_CHECKS
+int kapi_validate_ioctl(struct file *filp, unsigned int cmd, void __user *arg);
+int kapi_validate_ioctl_struct(const struct kapi_ioctl_spec *spec,
+			       const void *data, size_t size);
+#else
+static inline int kapi_validate_ioctl(struct file *filp, unsigned int cmd,
+				      void __user *arg)
+{
+	return 0;
+}
+#endif /* CONFIG_KAPI_RUNTIME_CHECKS */
+
+#else /* !CONFIG_KAPI_SPEC */
+static inline int kapi_register_ioctl_spec(const struct kapi_ioctl_spec *spec)
+{
+	return 0;
+}
+static inline void kapi_unregister_ioctl_spec(unsigned int cmd) {}
+static inline const struct kapi_ioctl_spec *kapi_get_ioctl_spec(unsigned int cmd)
+{
+	return NULL;
+}
+#endif /* CONFIG_KAPI_SPEC */
+
+/* Helper macros for IOCTL specification */
+
+/**
+ * DEFINE_IOCTL_API_SPEC - Start an IOCTL API specification
+ * @name: Unique identifier for the specification
+ * @cmd: IOCTL command number
+ * @cmd_name_str: String name of the command
+ */
+#define DEFINE_IOCTL_API_SPEC(name, cmd, cmd_name_str)			\
+static const struct kapi_ioctl_spec name##_spec = {			\
+	.cmd = cmd,							\
+	.cmd_name = cmd_name_str,					\
+	.api_spec = {							\
+		.name = #name,
+
+/**
+ * KAPI_IOCTL_SIZE - Specify input/output structure sizes
+ * @in_size: Size of input structure
+ * @out_size: Size of output structure
+ */
+#define KAPI_IOCTL_SIZE(in_size, out_size)				\
+	},								\
+	.input_size = in_size,						\
+	.output_size = out_size,
+
+/**
+ * KAPI_IOCTL_FILE_OPS - Specify the file_operations structure name
+ * @ops_name: Name of the file_operations structure
+ */
+#define KAPI_IOCTL_FILE_OPS(ops_name)					\
+	.file_ops_name = #ops_name,
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
+/**
+ * KAPI_IOCTL_PARAM_LEN - Buffer length parameter
+ * @idx: Parameter index
+ * @name: Parameter name
+ * @desc: Parameter description
+ * @max_size: Maximum allowed size
+ */
+#define KAPI_IOCTL_PARAM_LEN(idx, name, desc, max_size)		\
+	KAPI_PARAM(idx, name, "__u32", desc)				\
+		KAPI_PARAM_FLAGS(KAPI_PARAM_INOUT)			\
+		.type = KAPI_TYPE_UINT,					\
+		.constraint_type = KAPI_CONSTRAINT_RANGE,		\
+		.min_value = 0,						\
+		.max_value = max_size,					\
+	KAPI_PARAM_END
+
+/* End the IOCTL specification */
+#define KAPI_IOCTL_END_SPEC						\
+};									\
+									\
+static int __init name##_spec_init(void)				\
+{									\
+	return kapi_register_ioctl_spec(&name##_spec);			\
+}									\
+									\
+static void __exit name##_spec_exit(void)				\
+{									\
+	kapi_unregister_ioctl_spec(name##_spec.cmd);			\
+}									\
+									\
+module_init(name##_spec_init);						\
+module_exit(name##_spec_exit);
+
+/* Inline IOCTL specification support */
+
+/* Forward declaration */
+struct fwctl_ucmd;
+
+/**
+ * struct kapi_ioctl_handler - IOCTL handler with inline specification
+ * @spec: IOCTL specification
+ * @handler: Original IOCTL handler function
+ */
+struct kapi_ioctl_handler {
+	struct kapi_ioctl_spec spec;
+	int (*handler)(struct fwctl_ucmd *ucmd);
+};
+
+/**
+ * DEFINE_IOCTL_HANDLER - Define an IOCTL handler with inline specification
+ * @name: Handler name
+ * @cmd: IOCTL command number
+ * @handler_func: Handler function
+ * @struct_type: Structure type for this IOCTL
+ * @last_field: Last field in the structure
+ */
+#define DEFINE_IOCTL_HANDLER(name, cmd, handler_func, struct_type, last_field)	\
+static const struct kapi_ioctl_handler name = {				\
+	.spec = {							\
+		.cmd = cmd,						\
+		.cmd_name = #cmd,					\
+		.input_size = sizeof(struct_type),			\
+		.output_size = sizeof(struct_type),			\
+		.api_spec = {						\
+			.name = #name,
+
+#define KAPI_IOCTL_HANDLER_END						\
+		},							\
+	},								\
+	.handler = handler_func,					\
+}
+
+/**
+ * kapi_ioctl_wrapper - Wrapper function for transparent IOCTL validation
+ * @filp: File pointer
+ * @cmd: IOCTL command
+ * @arg: User argument
+ * @real_ioctl: The real ioctl handler
+ *
+ * This wrapper performs validation before and after the actual IOCTL call
+ */
+static inline long kapi_ioctl_wrapper(struct file *filp, unsigned int cmd,
+				      unsigned long arg,
+				      long (*real_ioctl)(struct file *, unsigned int, unsigned long))
+{
+	long ret;
+
+#ifdef CONFIG_KAPI_RUNTIME_CHECKS
+	/* Pre-validation */
+	ret = kapi_validate_ioctl(filp, cmd, (void __user *)arg);
+	if (ret)
+		return ret;
+#endif
+
+	/* Call the real IOCTL handler */
+	ret = real_ioctl(filp, cmd, arg);
+
+#ifdef CONFIG_KAPI_RUNTIME_CHECKS
+	/* Post-validation could be added here if needed */
+	/* For example, validating output parameters */
+#endif
+
+	return ret;
+}
+
+/**
+ * KAPI_IOCTL_OPS - Define file_operations with transparent validation
+ * @name: Name of the file_operations structure
+ * @real_ioctl: The real ioctl handler function
+ * @... : Other file operation handlers
+ */
+#define KAPI_IOCTL_OPS(name, real_ioctl, ...)				\
+static long name##_validated_ioctl(struct file *filp, unsigned int cmd, \
+				   unsigned long arg)			\
+{									\
+	return kapi_ioctl_wrapper(filp, cmd, arg, real_ioctl);		\
+}									\
+									\
+static const struct file_operations name = {				\
+	.unlocked_ioctl = name##_validated_ioctl,			\
+	__VA_ARGS__							\
+}
+
+/**
+ * KAPI_IOCTL_OP_ENTRY - Define an IOCTL operation table entry with spec
+ * @_ioctl: IOCTL command macro
+ * @_handler: Handler structure (defined with DEFINE_IOCTL_HANDLER)
+ * @_struct: Structure type
+ * @_last: Last field name
+ */
+#define KAPI_IOCTL_OP_ENTRY(_ioctl, _handler, _struct, _last)		\
+	[_IOC_NR(_ioctl) - FWCTL_CMD_BASE] = {				\
+		.size = sizeof(_struct) +				\
+			BUILD_BUG_ON_ZERO(sizeof(union fwctl_ucmd_buffer) < \
+					  sizeof(_struct)),		\
+		.min_size = offsetofend(_struct, _last),		\
+		.ioctl_num = _ioctl,					\
+		.execute = _handler.handler,				\
+	}
+
+/* Helper to register all handlers in a module */
+#define KAPI_REGISTER_IOCTL_HANDLERS(handlers, count)			\
+static int __init kapi_ioctl_handlers_init(void)			\
+{									\
+	int i, ret;							\
+	for (i = 0; i < count; i++) {					\
+		ret = kapi_register_ioctl_spec(&handlers[i].spec);	\
+		if (ret) {						\
+			while (--i >= 0)				\
+				kapi_unregister_ioctl_spec(handlers[i].spec.cmd); \
+			return ret;					\
+		}							\
+	}								\
+	return 0;							\
+}									\
+									\
+static void __exit kapi_ioctl_handlers_exit(void)			\
+{									\
+	int i;								\
+	for (i = 0; i < count; i++)					\
+		kapi_unregister_ioctl_spec(handlers[i].spec.cmd);	\
+}									\
+									\
+module_init(kapi_ioctl_handlers_init);					\
+module_exit(kapi_ioctl_handlers_exit)
+
+/**
+ * KAPI_REGISTER_IOCTL_SPECS - Register an array of IOCTL specifications
+ * @specs: Array of pointers to kapi_ioctl_spec
+ * @count: Number of specifications
+ *
+ * This macro generates init/exit functions to register/unregister
+ * the IOCTL specifications. The functions return 0 on success or
+ * negative error code on failure.
+ *
+ * Usage:
+ *   static const struct kapi_ioctl_spec *my_ioctl_specs[] = {
+ *       &spec1, &spec2, &spec3,
+ *   };
+ *   KAPI_REGISTER_IOCTL_SPECS(my_ioctl_specs, ARRAY_SIZE(my_ioctl_specs))
+ *
+ * Then call the generated functions in your module init/exit:
+ *   ret = kapi_register_##name();
+ *   kapi_unregister_##name();
+ */
+#define KAPI_REGISTER_IOCTL_SPECS(name, specs)				\
+static int kapi_register_##name(void)					\
+{									\
+	int i, ret;							\
+	for (i = 0; i < ARRAY_SIZE(specs); i++) {			\
+		ret = kapi_register_ioctl_spec(specs[i]);		\
+		if (ret) {						\
+			pr_warn("Failed to register IOCTL spec for %s: %d\n", \
+				specs[i]->cmd_name, ret);		\
+			while (--i >= 0)				\
+				kapi_unregister_ioctl_spec(specs[i]->cmd); \
+			return ret;					\
+		}							\
+	}								\
+	pr_info("Registered %zu IOCTL specifications\n", 		\
+		ARRAY_SIZE(specs));					\
+	return 0;							\
+}									\
+									\
+static void kapi_unregister_##name(void)				\
+{									\
+	int i;								\
+	for (i = 0; i < ARRAY_SIZE(specs); i++)			\
+		kapi_unregister_ioctl_spec(specs[i]->cmd);		\
+}
+
+/**
+ * KAPI_DEFINE_IOCTL_SPEC - Define a single IOCTL specification
+ * @name: Name of the specification variable
+ * @cmd: IOCTL command number
+ * @cmd_name: String name of the command
+ * @in_size: Input structure size
+ * @out_size: Output structure size
+ * @fops_name: Name of the file_operations structure
+ *
+ * This macro starts the definition of an IOCTL specification.
+ * It must be followed by the API specification details and
+ * ended with KAPI_END_IOCTL_SPEC.
+ *
+ * Example:
+ *   KAPI_DEFINE_IOCTL_SPEC(my_ioctl_spec, MY_IOCTL, "MY_IOCTL",
+ *                          sizeof(struct my_input), sizeof(struct my_output),
+ *                          "my_fops")
+ *   KAPI_DESCRIPTION("Description here")
+ *   ...
+ *   KAPI_END_IOCTL_SPEC;
+ */
+#define KAPI_DEFINE_IOCTL_SPEC(name, cmd, cmd_name_str, in_size, out_size, fops) \
+static const struct kapi_ioctl_spec name = {				\
+	.cmd = (cmd),							\
+	.cmd_name = cmd_name_str,					\
+	.input_size = in_size,						\
+	.output_size = out_size,					\
+	.file_ops_name = fops,						\
+	.api_spec = {							\
+		.name = #name,
+
+#define KAPI_END_IOCTL_SPEC						\
+	},								\
+}
+
+/**
+ * KAPI_IOCTL_SPEC_DRIVER - Complete IOCTL specification for a driver
+ * @driver_name: Name of the driver (used for logging)
+ * @specs_array: Name of the array containing IOCTL spec pointers
+ *
+ * This macro provides everything needed for IOCTL spec registration:
+ * 1. Generates the specs array declaration
+ * 2. Creates init/exit functions for registration
+ * 3. Provides simple function names to call from module init/exit
+ *
+ * Usage:
+ *   // Define individual specs
+ *   KAPI_DEFINE_IOCTL_SPEC(spec1, ...) ... KAPI_END_IOCTL_SPEC;
+ *   KAPI_DEFINE_IOCTL_SPEC(spec2, ...) ... KAPI_END_IOCTL_SPEC;
+ *
+ *   // Create the driver registration (at end of file)
+ *   KAPI_IOCTL_SPEC_DRIVER("my_driver", {
+ *       &spec1,
+ *       &spec2,
+ *   })
+ *
+ *   // In module init: ret = kapi_ioctl_specs_init();
+ *   // In module exit: kapi_ioctl_specs_exit();
+ */
+#define KAPI_IOCTL_SPEC_DRIVER(driver_name, ...)			\
+static const struct kapi_ioctl_spec *__kapi_ioctl_specs[] = __VA_ARGS__;									\
+									\
+static int __init kapi_ioctl_specs_init(void)				\
+{									\
+	int i, ret;							\
+	for (i = 0; i < ARRAY_SIZE(__kapi_ioctl_specs); i++) {		\
+		ret = kapi_register_ioctl_spec(__kapi_ioctl_specs[i]);	\
+		if (ret) {						\
+			pr_warn("%s: Failed to register %s: %d\n",	\
+				driver_name,				\
+				__kapi_ioctl_specs[i]->cmd_name, ret);	\
+			while (--i >= 0)				\
+				kapi_unregister_ioctl_spec(		\
+					__kapi_ioctl_specs[i]->cmd);	\
+			return ret;					\
+		}							\
+	}								\
+	pr_info("%s: Registered %zu IOCTL specifications\n",		\
+		driver_name, ARRAY_SIZE(__kapi_ioctl_specs));		\
+	return 0;							\
+}									\
+									\
+static void kapi_ioctl_specs_exit(void)				\
+{									\
+	int i;								\
+	for (i = 0; i < ARRAY_SIZE(__kapi_ioctl_specs); i++)		\
+		kapi_unregister_ioctl_spec(__kapi_ioctl_specs[i]->cmd);\
+}
+
+/* Transparent IOCTL validation wrapper support */
+
+#ifdef CONFIG_KAPI_RUNTIME_CHECKS
+
+/**
+ * struct kapi_fops_wrapper - Wrapper for file_operations with validation
+ * @real_fops: Original file_operations
+ * @wrapped_fops: Modified file_operations with validation wrapper
+ * @real_ioctl: Original unlocked_ioctl handler
+ */
+struct kapi_fops_wrapper {
+	const struct file_operations *real_fops;
+	const struct file_operations *wrapped_fops;
+	long (*real_ioctl)(struct file *, unsigned int, unsigned long);
+};
+
+/* Forward declarations */
+long kapi_ioctl_validation_wrapper(struct file *filp, unsigned int cmd,
+				   unsigned long arg);
+void kapi_register_wrapper(struct kapi_fops_wrapper *wrapper);
+
+/**
+ * kapi_wrap_file_operations - Wrap file_operations for transparent validation
+ * @fops: Original file_operations to wrap
+ *
+ * This creates a wrapper that intercepts ioctl calls for validation.
+ * The wrapper is stored in a static variable in the calling module.
+ */
+#define kapi_wrap_file_operations(fops)					\
+({										\
+	static struct kapi_fops_wrapper __kapi_wrapper = {		\
+		.real_fops = &(fops),					\
+	};								\
+	if (__kapi_wrapper.real_fops->unlocked_ioctl) {		\
+		__kapi_wrapper.wrapped_fops = (fops);			\
+		__kapi_wrapper.real_ioctl = (fops).unlocked_ioctl;	\
+		__kapi_wrapper.wrapped_fops.unlocked_ioctl = 		\
+			kapi_ioctl_validation_wrapper;			\
+		&__kapi_wrapper.wrapped_fops;				\
+	} else {							\
+		&(fops);						\
+	}								\
+})
+
+
+/**
+ * KAPI_DEFINE_FOPS - Define file_operations with automatic validation
+ * @name: Name of the file_operations structure
+ * @... : File operation handlers
+ *
+ * Usage:
+ *   KAPI_DEFINE_FOPS(my_fops,
+ *       .owner = THIS_MODULE,
+ *       .open = my_open,
+ *       .unlocked_ioctl = my_ioctl,
+ *   );
+ *
+ * Then in your module init, call: kapi_init_fops_##name()
+ */
+#define KAPI_DEFINE_FOPS(name, ...)					\
+static const struct file_operations __kapi_real_##name = {		\
+	__VA_ARGS__							\
+};									\
+static struct file_operations __kapi_wrapped_##name;			\
+static struct kapi_fops_wrapper __kapi_wrapper_##name;			\
+static const struct file_operations *name;				\
+static void kapi_init_fops_##name(void)				\
+{									\
+	if (__kapi_real_##name.unlocked_ioctl) {			\
+		__kapi_wrapped_##name = __kapi_real_##name;		\
+		__kapi_wrapper_##name.real_fops = &__kapi_real_##name;	\
+		__kapi_wrapper_##name.wrapped_fops = &__kapi_wrapped_##name; \
+		__kapi_wrapper_##name.real_ioctl = 			\
+			__kapi_real_##name.unlocked_ioctl;		\
+		__kapi_wrapped_##name.unlocked_ioctl = 		\
+			kapi_ioctl_validation_wrapper;			\
+		kapi_register_wrapper(&__kapi_wrapper_##name);		\
+		name = &__kapi_wrapped_##name;				\
+	} else {							\
+		name = &__kapi_real_##name;				\
+	}								\
+}
+
+#else /* !CONFIG_KAPI_RUNTIME_CHECKS */
+
+/* When runtime checks are disabled, no wrapping occurs */
+#define kapi_wrap_file_operations(fops) (&(fops))
+#define KAPI_DEFINE_FOPS(name, ...) \
+static const struct file_operations name = { __VA_ARGS__ }; \
+static inline void kapi_init_fops_##name(void) {}
+
+#endif /* CONFIG_KAPI_RUNTIME_CHECKS */
+
+#endif /* _LINUX_IOCTL_API_SPEC_H */
\ No newline at end of file
diff --git a/include/linux/kernel_api_spec.h b/include/linux/kernel_api_spec.h
index 04df5892bc6d6..9590fe3bb007c 100644
--- a/include/linux/kernel_api_spec.h
+++ b/include/linux/kernel_api_spec.h
@@ -849,7 +849,7 @@ struct kernel_api_spec {
 #define KAPI_PARAM_OUT		(KAPI_PARAM_OUT)
 #define KAPI_PARAM_INOUT	(KAPI_PARAM_IN | KAPI_PARAM_OUT)
 #define KAPI_PARAM_OPTIONAL	(KAPI_PARAM_OPTIONAL)
-#define KAPI_PARAM_USER_PTR	(KAPI_PARAM_USER | KAPI_PARAM_PTR)
+#define KAPI_PARAM_USER_PTR	(KAPI_PARAM_USER)
 
 /* Validation and runtime checking */
 
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
index 0000000000000..25f6db8cb33eb
--- /dev/null
+++ b/kernel/api/ioctl_validation.c
@@ -0,0 +1,360 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * ioctl_validation.c - Runtime validation for IOCTL API specifications
+ *
+ * Provides functions to validate ioctl parameters against their specifications
+ * at runtime when CONFIG_KAPI_RUNTIME_CHECKS is enabled.
+ */
+
+#include <linux/kernel.h>
+#include <linux/ioctl_api_spec.h>
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
+	const struct kapi_ioctl_spec *spec;
+	const struct kernel_api_spec *api_spec;
+	void *data = NULL;
+	size_t copy_size;
+	int ret = 0;
+	int i;
+
+	spec = kapi_get_ioctl_spec(cmd);
+	if (!spec)
+		return 0; /* No spec, can't validate */
+
+	api_spec = &spec->api_spec;
+
+	pr_debug("kapi: validating ioctl %s (0x%x)\n", spec->cmd_name, cmd);
+
+	/* Check if this ioctl requires specific capabilities */
+	if (api_spec->param_count > 0) {
+		for (i = 0; i < api_spec->param_count; i++) {
+			const struct kapi_param_spec *param = &api_spec->params[i];
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
+int kapi_validate_ioctl_struct(const struct kapi_ioctl_spec *spec,
+				const void *data, size_t size)
+{
+	const struct kernel_api_spec *api_spec = &spec->api_spec;
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
+	for (i = 0; i < api_spec->param_count && i < KAPI_MAX_PARAMS; i++) {
+		const struct kapi_param_spec *param = &api_spec->params[i];
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
+						&api_spec->params[param->size_param_idx],
+						size_offset);
+
+					/* Validate buffer size constraints */
+					if (buf_size > 0 &&
+					    !kapi_validate_param(&api_spec->params[param->size_param_idx],
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
+	const struct kapi_ioctl_spec *spec;
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
+	if (spec && spec->api_spec.error_count > 0) {
+		/* Validate that returned error is in the spec */
+		if (ret < 0) {
+			int i;
+			bool found = false;
+			for (i = 0; i < spec->api_spec.error_count; i++) {
+				if (ret == spec->api_spec.errors[i].error_code) {
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
index 29c0c84d87f7c..70e16a49f5dbe 100644
--- a/kernel/api/kernel_api_spec.c
+++ b/kernel/api/kernel_api_spec.c
@@ -1166,4 +1166,92 @@ static int __init kapi_debugfs_init(void)
 
 late_initcall(kapi_debugfs_init);
 
-#endif /* CONFIG_DEBUG_FS */
\ No newline at end of file
+#endif /* CONFIG_DEBUG_FS */
+
+/* IOCTL specification registry */
+#ifdef CONFIG_KAPI_SPEC
+
+#include <linux/ioctl_api_spec.h>
+
+static DEFINE_MUTEX(ioctl_spec_mutex);
+static LIST_HEAD(ioctl_specs);
+
+struct ioctl_spec_entry {
+	struct list_head list;
+	const struct kapi_ioctl_spec *spec;
+};
+
+/**
+ * kapi_register_ioctl_spec - Register an IOCTL API specification
+ * @spec: IOCTL specification to register
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+int kapi_register_ioctl_spec(const struct kapi_ioctl_spec *spec)
+{
+	struct ioctl_spec_entry *entry;
+
+	if (!spec || !spec->cmd_name)
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
+const struct kapi_ioctl_spec *kapi_get_ioctl_spec(unsigned int cmd)
+{
+	struct ioctl_spec_entry *entry;
+	const struct kapi_ioctl_spec *spec = NULL;
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



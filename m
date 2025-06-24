Return-Path: <linux-api+bounces-3980-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 038C1AE6E53
	for <lists+linux-api@lfdr.de>; Tue, 24 Jun 2025 20:12:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60EE87B381F
	for <lists+linux-api@lfdr.de>; Tue, 24 Jun 2025 18:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF6D72F0021;
	Tue, 24 Jun 2025 18:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TRB3JWCf"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F252EFD8A;
	Tue, 24 Jun 2025 18:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750788477; cv=none; b=KxWzQ+OGl7t0h9MbXT287JC/EmFJ1OX8UD+H5C4uimAkft0TU2Pgrzv94S4jXlcn7ZGJrpsIZord4JoJ5rrMec5vhgqKtR04ChlTaw+PgyXlUiZjHufoxw+Rn2XKPYcFxr1JZswEc7Sk8na3F1Q0tYQUUq/DhW5aJmSxPOH2XBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750788477; c=relaxed/simple;
	bh=+QYzMmGITAujrkiofiANJZrdIGqCtmCxH1UfrGM+YpQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bFtSvfo6LW9/f8XIiR/MhmQA85ol0/aplWUv1oga1k8QD2xjTCo4dckXhrkIw0q9OcUkfdH3QJOBCVcsT8Whc1HYkof5jc9CjP9LLiVJVO6vvZzTqm5ojJQmBOIrl1aBQKRrNp60QfksQrBzaMKqz9vbJJ3wOAOu8Sp3FjfLz2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TRB3JWCf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12BD7C4CEFB;
	Tue, 24 Jun 2025 18:07:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750788477;
	bh=+QYzMmGITAujrkiofiANJZrdIGqCtmCxH1UfrGM+YpQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TRB3JWCfiGmWPrU7EI2DaYnczJoMFlVkJJdARCSGfHCCrNo89X1stge8/4NswucTM
	 7xbYE/p4DFqQS0kU+lE6bMbE6NdPdqpV2/B9pyzDZL8TJtff71Z9ODSZ7WfAkWbLMN
	 hguPEuA2rA5larf49Lfy4d77FxqnclB9CLJ0uJu/t/6VF6PhtC6EIrMz5/S/RWAz0N
	 83rcY8EDcevvjXD3KkrQQoRue9OE3upToBPK8exwMYpWegHdUOAeuzzl1D/SSNcZx8
	 s1ZeFlwSGrdVne5fWsAE6oz9Y8t5c/vbdKB0eTXjkiBylErXVEidQJEmxRkpcpqhm9
	 gcLg04wRyIQKw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-doc@vger.kernel.org,
	linux-api@vger.kernel.org,
	workflows@vger.kernel.org,
	tools@kernel.org,
	Sasha Levin <sashal@kernel.org>
Subject: [RFC v2 19/22] kernel/api: Add sysfs validation support to kernel API specification framework
Date: Tue, 24 Jun 2025 14:07:39 -0400
Message-Id: <20250624180742.5795-20-sashal@kernel.org>
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

Extend the kernel API specification infrastructure to support sysfs attributes,
enabling runtime validation and comprehensive documentation of sysfs interfaces.

This patch integrates sysfs support into the existing KAPI framework,
maintaining consistency across different kernel API types. The
implementation adds new parameter types (STRING, BOOL, HEX, BINARY,
BITMAP) specifically for sysfs attributes, along with sysfs-specific
fields in the kapi_param_spec structure including path, permissions,
default values, units, and allowed string values.

Runtime validation functions have been added to check sysfs read/write
operations, validate parameter types and ranges, and enforce permission
constraints.

Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/kernel_api_spec.h | 123 +++++++++++-
 kernel/api/kernel_api_spec.c    | 336 +++++++++++++++++++++++++++++++-
 2 files changed, 451 insertions(+), 8 deletions(-)

diff --git a/include/linux/kernel_api_spec.h b/include/linux/kernel_api_spec.h
index ee7371909d0e4..fd8ff6ec85d99 100644
--- a/include/linux/kernel_api_spec.h
+++ b/include/linux/kernel_api_spec.h
@@ -43,6 +43,11 @@ struct sigaction;
  * @KAPI_TYPE_FD: File descriptor - validated in process context
  * @KAPI_TYPE_USER_PTR: User space pointer - validated for access and size
  * @KAPI_TYPE_PATH: Pathname - validated for access and path limits
+ * @KAPI_TYPE_STRING: String type - for sysfs and other string attributes
+ * @KAPI_TYPE_BOOL: Boolean type - for sysfs and other boolean attributes
+ * @KAPI_TYPE_HEX: Hexadecimal type - for sysfs hex values
+ * @KAPI_TYPE_BINARY: Binary data type - for sysfs binary attributes
+ * @KAPI_TYPE_BITMAP: Bitmap type - for sysfs bitmap attributes
  * @KAPI_TYPE_CUSTOM: Custom/complex types
  */
 enum kapi_param_type {
@@ -58,6 +63,11 @@ enum kapi_param_type {
 	KAPI_TYPE_FD,		/* File descriptor - validated in process context */
 	KAPI_TYPE_USER_PTR,	/* User space pointer - validated for access and size */
 	KAPI_TYPE_PATH,		/* Pathname - validated for access and path limits */
+	KAPI_TYPE_STRING,	/* String type - for sysfs and other string attributes */
+	KAPI_TYPE_BOOL,		/* Boolean type - for sysfs and other boolean attributes */
+	KAPI_TYPE_HEX,		/* Hexadecimal type - for sysfs hex values */
+	KAPI_TYPE_BINARY,	/* Binary data type - for sysfs binary attributes */
+	KAPI_TYPE_BITMAP,	/* Bitmap type - for sysfs bitmap attributes */
 	KAPI_TYPE_CUSTOM,
 };
 
@@ -72,6 +82,10 @@ enum kapi_param_type {
  * @KAPI_PARAM_USER: User space pointer
  * @KAPI_PARAM_DMA: DMA-capable memory required
  * @KAPI_PARAM_ALIGNED: Alignment requirements
+ * @KAPI_PARAM_SYSFS_READONLY: Sysfs read-only attribute
+ * @KAPI_PARAM_SYSFS_WRITEONLY: Sysfs write-only attribute
+ * @KAPI_PARAM_SYSFS_RW: Sysfs read-write attribute
+ * @KAPI_PARAM_SYSFS_BINARY: Sysfs binary attribute
  */
 enum kapi_param_flags {
 	KAPI_PARAM_IN		= (1 << 0),
@@ -83,6 +97,10 @@ enum kapi_param_flags {
 	KAPI_PARAM_USER		= (1 << 6),
 	KAPI_PARAM_DMA		= (1 << 7),
 	KAPI_PARAM_ALIGNED	= (1 << 8),
+	KAPI_PARAM_SYSFS_READONLY = (1 << 9),
+	KAPI_PARAM_SYSFS_WRITEONLY = (1 << 10),
+	KAPI_PARAM_SYSFS_RW	= (1 << 11),
+	KAPI_PARAM_SYSFS_BINARY = (1 << 12),
 };
 
 /**
@@ -164,6 +182,13 @@ enum kapi_constraint_type {
  * @constraints: Additional constraints description
  * @size_param_idx: Index of parameter that determines size (-1 if fixed size)
  * @size_multiplier: Multiplier for size calculation (e.g., sizeof(struct))
+ * @sysfs_path: Path in sysfs (for sysfs attributes)
+ * @sysfs_permissions: Sysfs file permissions (e.g., 0644)
+ * @default_value: Default value as string (for sysfs)
+ * @units: Units of measurement (e.g., "ms", "bytes")
+ * @step: Step value for numeric types
+ * @allowed_strings: Array of allowed string values
+ * @allowed_string_count: Number of allowed string values
  */
 struct kapi_param_spec {
 	char name[KAPI_MAX_NAME_LEN];
@@ -183,6 +208,14 @@ struct kapi_param_spec {
 	char constraints[KAPI_MAX_DESC_LEN];
 	int size_param_idx;	/* Index of param that determines size, -1 if N/A */
 	size_t size_multiplier;	/* Size per unit (e.g., sizeof(struct epoll_event)) */
+	/* Sysfs-specific fields */
+	char sysfs_path[KAPI_MAX_NAME_LEN];
+	umode_t sysfs_permissions;
+	char default_value[KAPI_MAX_NAME_LEN];
+	char units[32];
+	s64 step;
+	const char **allowed_strings;
+	u32 allowed_string_count;
 } __attribute__((packed));
 
 /**
@@ -667,9 +700,22 @@ struct kapi_addr_family_spec {
 } __attribute__((packed));
 #endif /* CONFIG_NET */
 
+/**
+ * enum kapi_api_type - Type of kernel API
+ * @KAPI_API_FUNCTION: Function/syscall API
+ * @KAPI_API_IOCTL: IOCTL API
+ * @KAPI_API_SYSFS: Sysfs attribute API
+ */
+enum kapi_api_type {
+	KAPI_API_FUNCTION = 0,
+	KAPI_API_IOCTL,
+	KAPI_API_SYSFS,
+};
+
 /**
  * struct kernel_api_spec - Complete kernel API specification
- * @name: Function name
+ * @name: Function/attribute name
+ * @api_type: Type of API (function, ioctl, sysfs)
  * @version: API version
  * @description: Brief description
  * @long_description: Detailed description
@@ -698,9 +744,12 @@ struct kapi_addr_family_spec {
  * @side_effects: Side effect specifications
  * @state_trans_count: Number of state transition specifications
  * @state_transitions: State transition specifications
+ * @subsystem: Subsystem name (for sysfs)
+ * @device_type: Device type (for sysfs)
  */
 struct kernel_api_spec {
 	char name[KAPI_MAX_NAME_LEN];
+	enum kapi_api_type api_type;
 	u32 version;
 	char description[KAPI_MAX_DESC_LEN];
 	char long_description[KAPI_MAX_DESC_LEN * 4];
@@ -786,6 +835,10 @@ struct kernel_api_spec {
 	size_t input_size;			/* Size of input structure (0 if none) */
 	size_t output_size;			/* Size of output structure (0 if none) */
 	char file_ops_name[KAPI_MAX_NAME_LEN];	/* Name of the file_operations structure */
+
+	/* Sysfs-specific fields */
+	char subsystem[KAPI_MAX_NAME_LEN];
+	char device_type[KAPI_MAX_NAME_LEN];
 } __attribute__((packed));
 
 /* Macros for defining API specifications */
@@ -1208,6 +1261,47 @@ struct kernel_api_spec {
 #define KAPI_EFFECTS_RESOURCES	(KAPI_EFFECT_RESOURCE_CREATE | KAPI_EFFECT_RESOURCE_DESTROY)
 #define KAPI_EFFECTS_IO		(KAPI_EFFECT_NETWORK | KAPI_EFFECT_FILESYSTEM)
 
+/* Sysfs-specific macros */
+
+/**
+ * DEFINE_SYSFS_API_SPEC - Define a sysfs attribute API specification
+ * @attr_name: Sysfs attribute name
+ */
+#define DEFINE_SYSFS_API_SPEC(attr_name) \
+	static struct kernel_api_spec __kapi_sysfs_spec_##attr_name \
+	__used __section(".kapi_specs") = {	\
+		.name = __stringify(attr_name),	\
+		.api_type = KAPI_API_SYSFS,	\
+		.version = 1,
+
+/**
+ * For sysfs attributes, use KAPI_PARAM with sysfs-specific fields
+ */
+#define KAPI_PATH(path) \
+		.sysfs_path = path,
+
+#define KAPI_PERMISSIONS(perms) \
+		.sysfs_permissions = perms,
+
+#define KAPI_DEFAULT(defval) \
+		.default_value = defval,
+
+#define KAPI_UNITS(unit) \
+		.units = unit,
+
+#define KAPI_STEP(s) \
+		.step = s,
+
+#define KAPI_ALLOWED_STRINGS(strings, count) \
+		.allowed_strings = strings,	\
+		.allowed_string_count = count,
+
+#define KAPI_SUBSYSTEM(subsys) \
+	.subsystem = subsys,
+
+#define KAPI_DEVICE_TYPE(dtype) \
+	.device_type = dtype,
+
 /* Helper macros for common patterns */
 
 #define KAPI_PARAM_IN		(KAPI_PARAM_IN)
@@ -1329,6 +1423,13 @@ bool kapi_validate_signal_action(const struct kernel_api_spec *spec, int signum,
 				 struct sigaction *act);
 int kapi_get_signal_error(const struct kernel_api_spec *spec, int signum);
 bool kapi_is_signal_restartable(const struct kernel_api_spec *spec, int signum);
+
+/* Sysfs validation functions */
+int kapi_validate_sysfs_write(const char *attr_name, const char *buf, size_t count);
+int kapi_validate_sysfs_read(const char *attr_name);
+int kapi_validate_sysfs_permission(const char *attr_name, umode_t mode);
+bool kapi_validate_sysfs_string(const struct kapi_param_spec *param, const char *buf, size_t count);
+bool kapi_validate_sysfs_number(const struct kapi_param_spec *param, const char *buf);
 #else
 static inline bool kapi_validate_params(const struct kernel_api_spec *spec, ...)
 {
@@ -1384,6 +1485,26 @@ static inline bool kapi_is_signal_restartable(const struct kernel_api_spec *spec
 {
 	return false;
 }
+static inline int kapi_validate_sysfs_write(const char *attr_name, const char *buf, size_t count)
+{
+	return 0;
+}
+static inline int kapi_validate_sysfs_read(const char *attr_name)
+{
+	return 0;
+}
+static inline int kapi_validate_sysfs_permission(const char *attr_name, umode_t mode)
+{
+	return 0;
+}
+static inline bool kapi_validate_sysfs_string(const struct kapi_param_spec *param, const char *buf, size_t count)
+{
+	return true;
+}
+static inline bool kapi_validate_sysfs_number(const struct kapi_param_spec *param, const char *buf)
+{
+	return true;
+}
 #endif
 
 /* Export/query functions */
diff --git a/kernel/api/kernel_api_spec.c b/kernel/api/kernel_api_spec.c
index 7be653ac2333b..9b4d3e4fa9f5f 100644
--- a/kernel/api/kernel_api_spec.c
+++ b/kernel/api/kernel_api_spec.c
@@ -139,6 +139,11 @@ static const char *param_type_to_string(enum kapi_param_type type)
 		[KAPI_TYPE_FD] = "file_descriptor",
 		[KAPI_TYPE_USER_PTR] = "user_pointer",
 		[KAPI_TYPE_PATH] = "pathname",
+		[KAPI_TYPE_STRING] = "string",
+		[KAPI_TYPE_BOOL] = "bool",
+		[KAPI_TYPE_HEX] = "hex",
+		[KAPI_TYPE_BINARY] = "binary",
+		[KAPI_TYPE_BITMAP] = "bitmap",
 		[KAPI_TYPE_CUSTOM] = "custom",
 	};
 
@@ -238,11 +243,15 @@ int kapi_export_json(const struct kernel_api_spec *spec, char *buf, size_t size)
 	ret = scnprintf(buf, size,
 		"{\n"
 		"  \"name\": \"%s\",\n"
+		"  \"api_type\": \"%s\",\n"
 		"  \"version\": %u,\n"
 		"  \"description\": \"%s\",\n"
 		"  \"long_description\": \"%s\",\n"
 		"  \"context_flags\": \"0x%x\",\n",
 		spec->name,
+		spec->api_type == KAPI_API_FUNCTION ? "function" :
+		spec->api_type == KAPI_API_IOCTL ? "ioctl" :
+		spec->api_type == KAPI_API_SYSFS ? "sysfs" : "unknown",
 		spec->version,
 		spec->description,
 		spec->long_description,
@@ -261,13 +270,38 @@ int kapi_export_json(const struct kernel_api_spec *spec, char *buf, size_t size)
 			"      \"type\": \"%s\",\n"
 			"      \"type_class\": \"%s\",\n"
 			"      \"flags\": \"0x%x\",\n"
-			"      \"description\": \"%s\"\n"
-			"    }%s\n",
+			"      \"description\": \"%s\"",
 			param->name,
 			param->type_name,
 			param_type_to_string(param->type),
 			param->flags,
-			param->description,
+			param->description);
+
+		/* Add sysfs-specific fields if this is a sysfs API */
+		if (spec->api_type == KAPI_API_SYSFS) {
+			if (param->sysfs_path[0])
+				ret += scnprintf(buf + ret, size - ret,
+					",\n      \"sysfs_path\": \"%s\"", param->sysfs_path);
+			if (param->sysfs_permissions)
+				ret += scnprintf(buf + ret, size - ret,
+					",\n      \"permissions\": \"0%o\"", param->sysfs_permissions);
+			if (param->default_value[0])
+				ret += scnprintf(buf + ret, size - ret,
+					",\n      \"default_value\": \"%s\"", param->default_value);
+			if (param->units[0])
+				ret += scnprintf(buf + ret, size - ret,
+					",\n      \"units\": \"%s\"", param->units);
+			if (param->step)
+				ret += scnprintf(buf + ret, size - ret,
+					",\n      \"step\": %lld", param->step);
+			if (param->min_value != 0 || param->max_value != 0)
+				ret += scnprintf(buf + ret, size - ret,
+					",\n      \"range\": [%lld, %lld]",
+					param->min_value, param->max_value);
+		}
+
+		ret += scnprintf(buf + ret, size - ret,
+			"\n    }%s\n",
 			(i < spec->param_count - 1) ? "," : "");
 	}
 
@@ -409,13 +443,25 @@ int kapi_export_json(const struct kernel_api_spec *spec, char *buf, size_t size)
 	ret += scnprintf(buf + ret, size - ret,
 		"  \"since_version\": \"%s\",\n"
 		"  \"deprecated\": %s,\n"
-		"  \"replacement\": \"%s\",\n"
+		"  \"replacement\": \"%s\",\n",
+		spec->since_version,
+		spec->deprecated ? "true" : "false",
+		spec->replacement);
+
+	/* Sysfs-specific fields */
+	if (spec->api_type == KAPI_API_SYSFS) {
+		if (spec->subsystem[0])
+			ret += scnprintf(buf + ret, size - ret,
+				"  \"subsystem\": \"%s\",\n", spec->subsystem);
+		if (spec->device_type[0])
+			ret += scnprintf(buf + ret, size - ret,
+				"  \"device_type\": \"%s\",\n", spec->device_type);
+	}
+
+	ret += scnprintf(buf + ret, size - ret,
 		"  \"examples\": \"%s\",\n"
 		"  \"notes\": \"%s\"\n"
 		"}\n",
-		spec->since_version,
-		spec->deprecated ? "true" : "false",
-		spec->replacement,
 		spec->examples,
 		spec->notes);
 
@@ -492,6 +538,282 @@ EXPORT_SYMBOL_GPL(kapi_print_spec);
 
 #ifdef CONFIG_KAPI_RUNTIME_CHECKS
 
+/**
+ * kapi_validate_sysfs_string - Validate a string value for sysfs
+ * @param: Parameter specification
+ * @buf: Buffer containing the string
+ * @count: Size of buffer
+ *
+ * Return: true if valid, false otherwise
+ */
+bool kapi_validate_sysfs_string(const struct kapi_param_spec *param,
+				 const char *buf, size_t count)
+{
+	size_t len = count;
+	int i;
+
+	if (!param || param->type != KAPI_TYPE_STRING)
+		return false;
+
+	/* Remove trailing newline if present */
+	if (len > 0 && buf[len - 1] == '\n')
+		len--;
+
+	/* Check length constraints */
+	if (param->size > 0 && len > param->size) {
+		pr_warn("Sysfs %s: string too long (max: %zu, got: %zu)\n",
+			param->name, param->size, len);
+		return false;
+	}
+
+	/* Check against allowed values if specified */
+	if (param->allowed_strings && param->allowed_string_count > 0) {
+		char *str = kstrndup(buf, len, GFP_KERNEL);
+		bool found = false;
+
+		if (!str)
+			return false;
+
+		for (i = 0; i < param->allowed_string_count; i++) {
+			if (strcmp(str, param->allowed_strings[i]) == 0) {
+				found = true;
+				break;
+			}
+		}
+
+		kfree(str);
+
+		if (!found) {
+			pr_warn("Sysfs %s: value not in allowed list\n", param->name);
+			return false;
+		}
+	}
+
+	return true;
+}
+EXPORT_SYMBOL_GPL(kapi_validate_sysfs_string);
+
+/**
+ * kapi_validate_sysfs_number - Validate a numeric value for sysfs
+ * @param: Parameter specification
+ * @buf: Buffer containing the value
+ *
+ * Return: true if valid, false otherwise
+ */
+bool kapi_validate_sysfs_number(const struct kapi_param_spec *param,
+				 const char *buf)
+{
+	s64 int_val;
+	u64 uint_val;
+	int ret;
+
+	if (!param)
+		return false;
+
+	switch (param->type) {
+	case KAPI_TYPE_INT:
+		ret = kstrtoll(buf, 0, &int_val);
+		if (ret) {
+			pr_warn("Sysfs %s: invalid integer format\n", param->name);
+			return false;
+		}
+
+		/* Check range constraints */
+		if (int_val < param->min_value || int_val > param->max_value) {
+			pr_warn("Sysfs %s: value %lld out of range [%lld, %lld]\n",
+				param->name, int_val, param->min_value, param->max_value);
+			return false;
+		}
+
+		/* Check step constraint */
+		if (param->step > 0) {
+			s64 offset = int_val - param->min_value;
+			if (offset % param->step != 0) {
+				pr_warn("Sysfs %s: value %lld not aligned to step %lld\n",
+					param->name, int_val, param->step);
+				return false;
+			}
+		}
+		break;
+
+	case KAPI_TYPE_UINT:
+	case KAPI_TYPE_HEX:
+		ret = kstrtoull(buf, 0, &uint_val);
+		if (ret) {
+			pr_warn("Sysfs %s: invalid unsigned integer format\n", param->name);
+			return false;
+		}
+
+		/* Check range constraints */
+		if (uint_val < (u64)param->min_value || uint_val > (u64)param->max_value) {
+			pr_warn("Sysfs %s: value %llu out of range [%llu, %llu]\n",
+				param->name, uint_val, (u64)param->min_value, (u64)param->max_value);
+			return false;
+		}
+
+		/* Check valid bits mask */
+		if (param->valid_mask && (uint_val & ~param->valid_mask)) {
+			pr_warn("Sysfs %s: value 0x%llx contains invalid bits (mask: 0x%llx)\n",
+				param->name, uint_val, param->valid_mask);
+			return false;
+		}
+		break;
+
+	case KAPI_TYPE_BOOL:
+		{
+			bool val;
+			ret = kstrtobool(buf, &val);
+			if (ret) {
+				pr_warn("Sysfs %s: invalid boolean value\n", param->name);
+				return false;
+			}
+		}
+		break;
+
+	default:
+		pr_warn("Sysfs %s: unsupported type %d for numeric validation\n",
+			param->name, param->type);
+		return false;
+	}
+
+	return true;
+}
+EXPORT_SYMBOL_GPL(kapi_validate_sysfs_number);
+
+/**
+ * kapi_validate_sysfs_write - Validate a write operation to sysfs attribute
+ * @attr_name: Name of the sysfs attribute
+ * @buf: Buffer containing the value to write
+ * @count: Size of buffer
+ *
+ * Return: 0 if valid, negative error code otherwise
+ */
+int kapi_validate_sysfs_write(const char *attr_name, const char *buf, size_t count)
+{
+	const struct kernel_api_spec *spec;
+	const struct kapi_param_spec *param;
+	int ret;
+
+	spec = kapi_get_spec(attr_name);
+	if (!spec || spec->api_type != KAPI_API_SYSFS)
+		return 0; /* No spec or not a sysfs spec, allow operation */
+
+	if (spec->param_count == 0)
+		return 0; /* No parameters defined */
+
+	param = &spec->params[0]; /* Sysfs attributes have single parameter */
+
+	/* Check access permissions */
+	if (param->flags & KAPI_PARAM_SYSFS_READONLY) {
+		pr_warn("Sysfs %s: write to read-only attribute\n", attr_name);
+		return -EPERM;
+	}
+
+	/* Validate based on type */
+	switch (param->type) {
+	case KAPI_TYPE_STRING:
+		if (!kapi_validate_sysfs_string(param, buf, count))
+			return -EINVAL;
+		break;
+
+	case KAPI_TYPE_INT:
+	case KAPI_TYPE_UINT:
+	case KAPI_TYPE_HEX:
+	case KAPI_TYPE_BOOL:
+		if (!kapi_validate_sysfs_number(param, buf))
+			return -EINVAL;
+		break;
+
+	case KAPI_TYPE_BINARY:
+		/* Binary attributes have their own validation */
+		if (param->size > 0 && count > param->size) {
+			pr_warn("Sysfs %s: binary data too large (max: %zu)\n",
+				attr_name, param->size);
+			return -EINVAL;
+		}
+		break;
+
+	case KAPI_TYPE_CUSTOM:
+		if (param->validate) {
+			ret = param->validate((s64)(unsigned long)buf);
+			if (!ret) {
+				pr_warn("Sysfs %s: custom validation failed\n", attr_name);
+				return -EINVAL;
+			}
+		}
+		break;
+
+	default:
+		pr_warn("Sysfs %s: unknown type %d\n", attr_name, param->type);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(kapi_validate_sysfs_write);
+
+/**
+ * kapi_validate_sysfs_read - Validate a read operation from sysfs attribute
+ * @attr_name: Name of the sysfs attribute
+ *
+ * Return: 0 if valid, negative error code otherwise
+ */
+int kapi_validate_sysfs_read(const char *attr_name)
+{
+	const struct kernel_api_spec *spec;
+	const struct kapi_param_spec *param;
+
+	spec = kapi_get_spec(attr_name);
+	if (!spec || spec->api_type != KAPI_API_SYSFS)
+		return 0; /* No spec or not a sysfs spec, allow operation */
+
+	if (spec->param_count == 0)
+		return 0; /* No parameters defined */
+
+	param = &spec->params[0]; /* Sysfs attributes have single parameter */
+
+	/* Check access permissions */
+	if (param->flags & KAPI_PARAM_SYSFS_WRITEONLY) {
+		pr_warn("Sysfs %s: read from write-only attribute\n", attr_name);
+		return -EPERM;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(kapi_validate_sysfs_read);
+
+/**
+ * kapi_validate_sysfs_permission - Validate permission change for sysfs attribute
+ * @attr_name: Name of the sysfs attribute
+ * @mode: New permission mode
+ *
+ * Return: 0 if valid, negative error code otherwise
+ */
+int kapi_validate_sysfs_permission(const char *attr_name, umode_t mode)
+{
+	const struct kernel_api_spec *spec;
+	const struct kapi_param_spec *param;
+
+	spec = kapi_get_spec(attr_name);
+	if (!spec || spec->api_type != KAPI_API_SYSFS)
+		return 0; /* No spec or not a sysfs spec, allow operation */
+
+	if (spec->param_count == 0)
+		return 0; /* No parameters defined */
+
+	param = &spec->params[0]; /* Sysfs attributes have single parameter */
+
+	/* Check if permissions match specification */
+	if (param->sysfs_permissions && param->sysfs_permissions != mode) {
+		pr_warn("Sysfs %s: permission mismatch (expected: 0%o, got: 0%o)\n",
+			attr_name, param->sysfs_permissions, mode);
+		/* We warn but don't fail - this might be intentional */
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(kapi_validate_sysfs_permission);
+
 /**
  * kapi_validate_fd - Validate that a file descriptor is valid in current context
  * @fd: File descriptor to validate
-- 
2.39.5



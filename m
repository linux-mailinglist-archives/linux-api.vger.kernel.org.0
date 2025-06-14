Return-Path: <linux-api+bounces-3921-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 06BDAAD9D2B
	for <lists+linux-api@lfdr.de>; Sat, 14 Jun 2025 15:52:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0157A189391C
	for <lists+linux-api@lfdr.de>; Sat, 14 Jun 2025 13:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4D682EA481;
	Sat, 14 Jun 2025 13:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pTDpGcSb"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB0672EA47A;
	Sat, 14 Jun 2025 13:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749908956; cv=none; b=SutzRmDrvb6XHs2aYlFkuCXaZqcycMLcXvFiKAm8O0HF+oTR48YG8laV+w187colXsqcVCAp6p7g5Gvl70jWAhymX38yPesyURVoXbfqboGvEU5LFMUO6UPMduZbexvwCRkSq75W/FaCI+wd8iISo8bAM/OoD+A9NUqpnF1amjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749908956; c=relaxed/simple;
	bh=MSsLjvVcoT+7z7CV8XQN9Se7pCyds4GF+lbNqQEVNZs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cBFxseFDBlCPbSD+RYLFSKavLAjxnLzZdSAFibSP6J25U4KLmXY93nEagoE15wRUPfld61Hrho8P9c3O1dynplJ4aWoyvwJOksaa6lo1ckiJVuHcSNfeDLJ6EQ125QqScm+Z6iCHYi24cDBGqYFKLTrz6o7onedv3xGK2/S4h1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pTDpGcSb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E75E5C4CEEB;
	Sat, 14 Jun 2025 13:49:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749908956;
	bh=MSsLjvVcoT+7z7CV8XQN9Se7pCyds4GF+lbNqQEVNZs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pTDpGcSbyfqDa7BpCN3gOZ16M9+CEy3zHIhgcK1ES2WlRNZ7kVAIObB8DpsQAPO1e
	 b90xd5+braap/yZePx6VIc0ITjm7EFesP00z59JwgWdv0k2A3DRtTuxpcZF0e4fQtE
	 cme+zs9dlsIH2dpkbDuc8ZAejy50utMF4sGgR9loViLHss4UWe6L88Id5Dnd8GoTtW
	 uMGSVC80s/OW+hJlntBiiPR5u6GUZuGBK3UE5hb+vOJwgvxWbipo6FwUhN9ZvcA1w6
	 2HdzMw/luFxVVNdRKYfDFuAOHYzwnaRyTNka9INAzaJkcjGbKlxunqav7mrXQN8g3W
	 3Vao7WMyeKMJQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-api@vger.kernel.org,
	workflows@vger.kernel.org,
	tools@kernel.org,
	Sasha Levin <sashal@kernel.org>
Subject: [RFC 17/19] fwctl: add detailed IOCTL API specifications
Date: Sat, 14 Jun 2025 09:48:56 -0400
Message-Id: <20250614134858.790460-18-sashal@kernel.org>
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

Add kernel API specifications to the fwctl driver using the IOCTL
specification framework. This provides detailed documentation and
enables runtime validation of the fwctl IOCTL interface.

Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/fwctl/main.c | 295 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 293 insertions(+), 2 deletions(-)

diff --git a/drivers/fwctl/main.c b/drivers/fwctl/main.c
index bc6378506296c..fc85d54ecb6a0 100644
--- a/drivers/fwctl/main.c
+++ b/drivers/fwctl/main.c
@@ -10,6 +10,8 @@
 #include <linux/module.h>
 #include <linux/sizes.h>
 #include <linux/slab.h>
+#include <linux/ioctl_api_spec.h>
+#include <linux/kernel_api_spec.h>
 
 #include <uapi/fwctl/fwctl.h>
 
@@ -261,13 +263,291 @@ static int fwctl_fops_release(struct inode *inode, struct file *filp)
 	return 0;
 }
 
-static const struct file_operations fwctl_fops = {
+/* Use KAPI_DEFINE_FOPS for automatic validation wrapping */
+KAPI_DEFINE_FOPS(fwctl_fops,
 	.owner = THIS_MODULE,
 	.open = fwctl_fops_open,
 	.release = fwctl_fops_release,
 	.unlocked_ioctl = fwctl_fops_ioctl,
+);
+
+/* IOCTL API Specifications */
+
+static const struct kapi_ioctl_spec fwctl_info_spec = {
+	.cmd = FWCTL_INFO,
+	.cmd_name = "FWCTL_INFO",
+	.input_size = sizeof(struct fwctl_info),
+	.output_size = sizeof(struct fwctl_info),
+	.file_ops_name = "fwctl_fops",
+	.api_spec = {
+		.name = "fwctl_info",
+	KAPI_DESCRIPTION("Query device information and capabilities")
+	KAPI_LONG_DESC("Returns basic information about the fwctl instance, "
+		       "including the device type and driver-specific data. "
+		       "The driver-specific data format depends on the device type.")
+	KAPI_CONTEXT(KAPI_CTX_PROCESS | KAPI_CTX_SLEEPABLE)
+
+	/* Parameters */
+	KAPI_IOCTL_PARAM_SIZE
+	KAPI_IOCTL_PARAM_FLAGS
+
+	KAPI_PARAM(2, "out_device_type", "__u32", "Device type from enum fwctl_device_type")
+		KAPI_PARAM_FLAGS(KAPI_PARAM_OUT)
+		.type = KAPI_TYPE_UINT,
+		.constraint_type = KAPI_CONSTRAINT_ENUM,
+		.enum_values = (const s64[]){FWCTL_DEVICE_TYPE_ERROR,
+					     FWCTL_DEVICE_TYPE_MLX5,
+					     FWCTL_DEVICE_TYPE_CXL,
+					     FWCTL_DEVICE_TYPE_PDS},
+		.enum_count = 4,
+	KAPI_PARAM_END
+
+	KAPI_PARAM(3, "device_data_len", "__u32", "Length of device data buffer")
+		KAPI_PARAM_FLAGS(KAPI_PARAM_INOUT)
+		.type = KAPI_TYPE_UINT,
+		.constraint_type = KAPI_CONSTRAINT_RANGE,
+		.min_value = 0,
+		.max_value = SZ_1M,	/* Reasonable limit for device info */
+	KAPI_PARAM_END
+
+	KAPI_IOCTL_PARAM_USER_OUT_BUF(4, "out_device_data",
+				      "Driver-specific device data", 3)
+
+	/* Return value */
+	KAPI_RETURN("int", "0 on success, negative errno on failure")
+		.type = KAPI_TYPE_INT,
+		.check_type = KAPI_RETURN_ERROR_CHECK,
+		.error_values = (const s64[]){-EFAULT, -EOPNOTSUPP, -ENODEV},
+		.error_count = 3,
+	KAPI_RETURN_END
+
+	/* Errors */
+	KAPI_ERROR(0, -EFAULT, "EFAULT", "Failed to copy data to/from user space",
+		   "Check that provided pointers are valid user space addresses")
+	KAPI_ERROR(1, -EOPNOTSUPP, "EOPNOTSUPP", "Invalid flags provided",
+		   "Currently flags must be 0")
+	KAPI_ERROR(2, -ENODEV, "ENODEV", "Device has been hot-unplugged",
+		   "The underlying device is no longer available")
+
+	.error_count = 3,
+	.param_count = 5,
+	.since_version = "6.13",
+
+	/* Structure specifications */
+	KAPI_STRUCT_SPEC(0, fwctl_info, "Device information query structure")
+		KAPI_STRUCT_SIZE(sizeof(struct fwctl_info), __alignof__(struct fwctl_info))
+		KAPI_STRUCT_FIELD_COUNT(4)
+
+		KAPI_STRUCT_FIELD(0, "size", KAPI_TYPE_UINT, "__u32",
+				  "Structure size for versioning")
+			KAPI_FIELD_OFFSET(offsetof(struct fwctl_info, size))
+			KAPI_FIELD_SIZE(sizeof(__u32))
+		KAPI_STRUCT_FIELD_END
+
+		KAPI_STRUCT_FIELD(1, "flags", KAPI_TYPE_UINT, "__u32",
+				  "Must be 0, reserved for future use")
+			KAPI_FIELD_OFFSET(offsetof(struct fwctl_info, flags))
+			KAPI_FIELD_SIZE(sizeof(__u32))
+			KAPI_FIELD_CONSTRAINT_RANGE(0, 0)
+		KAPI_STRUCT_FIELD_END
+
+		KAPI_STRUCT_FIELD(2, "out_device_type", KAPI_TYPE_UINT, "__u32",
+				  "Device type identifier")
+			KAPI_FIELD_OFFSET(offsetof(struct fwctl_info, out_device_type))
+			KAPI_FIELD_SIZE(sizeof(__u32))
+		KAPI_STRUCT_FIELD_END
+
+		KAPI_STRUCT_FIELD(3, "device_data_len", KAPI_TYPE_UINT, "__u32",
+				  "Length of device-specific data")
+			KAPI_FIELD_OFFSET(offsetof(struct fwctl_info, device_data_len))
+			KAPI_FIELD_SIZE(sizeof(__u32))
+		KAPI_STRUCT_FIELD_END
+	KAPI_STRUCT_SPEC_END
+
+	KAPI_STRUCT_SPEC_COUNT(1)
+
+	/* Side effects */
+	KAPI_SIDE_EFFECT(0, KAPI_EFFECT_NONE,
+			 "none",
+			 "Read-only operation with no side effects")
+	KAPI_SIDE_EFFECT_END
+
+	KAPI_SIDE_EFFECT_COUNT(1)
+
+	/* State transitions */
+	KAPI_STATE_TRANS_COUNT(0)	/* No state transitions for query operation */
+	},
 };
 
+static const struct kapi_ioctl_spec fwctl_rpc_spec = {
+	.cmd = FWCTL_RPC,
+	.cmd_name = "FWCTL_RPC",
+	.input_size = sizeof(struct fwctl_rpc),
+	.output_size = sizeof(struct fwctl_rpc),
+	.file_ops_name = "fwctl_fops",
+	.api_spec = {
+		.name = "fwctl_rpc",
+	KAPI_DESCRIPTION("Execute a Remote Procedure Call to device firmware")
+	KAPI_LONG_DESC("Delivers an RPC to the device firmware and returns the response. "
+		       "The RPC format is device-specific and determined by out_device_type "
+		       "from FWCTL_INFO. Different scopes have different permission requirements.")
+	KAPI_CONTEXT(KAPI_CTX_PROCESS | KAPI_CTX_SLEEPABLE)
+
+	/* Parameters */
+	KAPI_IOCTL_PARAM_SIZE
+
+	KAPI_PARAM(1, "scope", "__u32", "Access scope from enum fwctl_rpc_scope")
+		KAPI_PARAM_FLAGS(KAPI_PARAM_IN)
+		.type = KAPI_TYPE_UINT,
+		.constraint_type = KAPI_CONSTRAINT_ENUM,
+		.enum_values = (const s64[]){FWCTL_RPC_CONFIGURATION,
+					     FWCTL_RPC_DEBUG_READ_ONLY,
+					     FWCTL_RPC_DEBUG_WRITE,
+					     FWCTL_RPC_DEBUG_WRITE_FULL},
+		.enum_count = 4,
+		.constraints = "FWCTL_RPC_DEBUG_WRITE_FULL requires CAP_SYS_RAWIO",
+	KAPI_PARAM_END
+
+	KAPI_PARAM(2, "in_len", "__u32", "Length of input buffer")
+		KAPI_PARAM_FLAGS(KAPI_PARAM_IN)
+		.type = KAPI_TYPE_UINT,
+		.constraint_type = KAPI_CONSTRAINT_RANGE,
+		.min_value = 0,
+		.max_value = MAX_RPC_LEN,
+	KAPI_PARAM_END
+
+	KAPI_PARAM(3, "out_len", "__u32", "Length of output buffer")
+		KAPI_PARAM_FLAGS(KAPI_PARAM_INOUT)
+		.type = KAPI_TYPE_UINT,
+		.constraint_type = KAPI_CONSTRAINT_RANGE,
+		.min_value = 0,
+		.max_value = MAX_RPC_LEN,
+	KAPI_PARAM_END
+
+	KAPI_IOCTL_PARAM_USER_BUF(4, "in", "RPC request in device-specific format", 2)
+	KAPI_IOCTL_PARAM_USER_OUT_BUF(5, "out", "RPC response in device-specific format", 3)
+
+	/* Return value */
+	KAPI_RETURN("int", "0 on success, negative errno on failure")
+		.type = KAPI_TYPE_INT,
+		.check_type = KAPI_RETURN_ERROR_CHECK,
+		.error_values = (const s64[]){-EMSGSIZE, -EOPNOTSUPP, -EPERM,
+					      -ENOMEM, -EFAULT, -ENODEV},
+		.error_count = 6,
+	KAPI_RETURN_END
+
+	/* Errors */
+	KAPI_ERROR(0, -EMSGSIZE, "EMSGSIZE", "RPC message too large",
+		   "in_len or out_len exceeds MAX_RPC_LEN (2MB)")
+	KAPI_ERROR(1, -EOPNOTSUPP, "EOPNOTSUPP", "Invalid scope value",
+		   "scope must be one of the defined fwctl_rpc_scope values")
+	KAPI_ERROR(2, -EPERM, "EPERM", "Insufficient permissions",
+		   "FWCTL_RPC_DEBUG_WRITE_FULL requires CAP_SYS_RAWIO")
+	KAPI_ERROR(3, -ENOMEM, "ENOMEM", "Memory allocation failed",
+		   "Unable to allocate buffers for RPC")
+	KAPI_ERROR(4, -EFAULT, "EFAULT", "Failed to copy data to/from user space",
+		   "Check that provided pointers are valid user space addresses")
+	KAPI_ERROR(5, -ENODEV, "ENODEV", "Device has been hot-unplugged",
+		   "The underlying device is no longer available")
+
+	.error_count = 6,
+	.param_count = 6,
+	.since_version = "6.13",
+	.notes = "FWCTL_RPC_DEBUG_WRITE and FWCTL_RPC_DEBUG_WRITE_FULL will "
+		 "taint the kernel with TAINT_FWCTL on first use",
+
+	/* Structure specifications */
+	KAPI_STRUCT_SPEC(0, fwctl_rpc, "RPC request/response structure")
+		KAPI_STRUCT_SIZE(sizeof(struct fwctl_rpc), __alignof__(struct fwctl_rpc))
+		KAPI_STRUCT_FIELD_COUNT(6)
+
+		KAPI_STRUCT_FIELD(0, "size", KAPI_TYPE_UINT, "__u32",
+				  "Structure size for versioning")
+			KAPI_FIELD_OFFSET(offsetof(struct fwctl_rpc, size))
+			KAPI_FIELD_SIZE(sizeof(__u32))
+		KAPI_STRUCT_FIELD_END
+
+		KAPI_STRUCT_FIELD(1, "scope", KAPI_TYPE_UINT, "__u32",
+				  "Access scope level")
+			KAPI_FIELD_OFFSET(offsetof(struct fwctl_rpc, scope))
+			KAPI_FIELD_SIZE(sizeof(__u32))
+			KAPI_FIELD_CONSTRAINT_ENUM((const s64[]){FWCTL_RPC_CONFIGURATION,
+								  FWCTL_RPC_DEBUG_READ_ONLY,
+								  FWCTL_RPC_DEBUG_WRITE,
+								  FWCTL_RPC_DEBUG_WRITE_FULL}, 4)
+		KAPI_STRUCT_FIELD_END
+
+		KAPI_STRUCT_FIELD(2, "in_len", KAPI_TYPE_UINT, "__u32",
+				  "Input data length")
+			KAPI_FIELD_OFFSET(offsetof(struct fwctl_rpc, in_len))
+			KAPI_FIELD_SIZE(sizeof(__u32))
+		KAPI_STRUCT_FIELD_END
+
+		KAPI_STRUCT_FIELD(3, "out_len", KAPI_TYPE_UINT, "__u32",
+				  "Output buffer length")
+			KAPI_FIELD_OFFSET(offsetof(struct fwctl_rpc, out_len))
+			KAPI_FIELD_SIZE(sizeof(__u32))
+		KAPI_STRUCT_FIELD_END
+
+		KAPI_STRUCT_FIELD(4, "in", KAPI_TYPE_PTR, "__aligned_u64",
+				  "Pointer to input data")
+			KAPI_FIELD_OFFSET(offsetof(struct fwctl_rpc, in))
+			KAPI_FIELD_SIZE(sizeof(__aligned_u64))
+		KAPI_STRUCT_FIELD_END
+
+		KAPI_STRUCT_FIELD(5, "out", KAPI_TYPE_PTR, "__aligned_u64",
+				  "Pointer to output buffer")
+			KAPI_FIELD_OFFSET(offsetof(struct fwctl_rpc, out))
+			KAPI_FIELD_SIZE(sizeof(__aligned_u64))
+		KAPI_STRUCT_FIELD_END
+	KAPI_STRUCT_SPEC_END
+
+	KAPI_STRUCT_SPEC_COUNT(1)
+
+	/* Side effects */
+	KAPI_SIDE_EFFECT(0, KAPI_EFFECT_HARDWARE | KAPI_EFFECT_MODIFY_STATE,
+			 "device firmware",
+			 "May modify device configuration or firmware state")
+		KAPI_EFFECT_CONDITION("scope >= FWCTL_RPC_DEBUG_WRITE")
+	KAPI_SIDE_EFFECT_END
+
+	KAPI_SIDE_EFFECT(1, KAPI_EFFECT_MODIFY_STATE,
+			 "kernel taint",
+			 "Taints kernel with TAINT_FWCTL on first debug write")
+		KAPI_EFFECT_CONDITION("scope >= FWCTL_RPC_DEBUG_WRITE && first use")
+	KAPI_SIDE_EFFECT_END
+
+	KAPI_SIDE_EFFECT(2, KAPI_EFFECT_SCHEDULE,
+			 "process",
+			 "May block while firmware processes the RPC")
+		KAPI_EFFECT_CONDITION("firmware operation takes time")
+	KAPI_SIDE_EFFECT_END
+
+	KAPI_SIDE_EFFECT_COUNT(3)
+
+	/* State transitions */
+	KAPI_STATE_TRANS(0, "device state",
+			 "current configuration", "modified configuration",
+			 "Device configuration changed by RPC command")
+		KAPI_STATE_TRANS_COND("RPC modifies device settings")
+	KAPI_STATE_TRANS_END
+
+	KAPI_STATE_TRANS(1, "kernel taint state",
+			 "untainted", "TAINT_FWCTL set",
+			 "Kernel marked as tainted due to firmware modification")
+		KAPI_STATE_TRANS_COND("First debug write operation")
+	KAPI_STATE_TRANS_END
+
+	KAPI_STATE_TRANS_COUNT(2)
+	},
+};
+
+/* Register all fwctl IOCTL specifications */
+KAPI_IOCTL_SPEC_DRIVER("fwctl", {
+	&fwctl_info_spec,
+	&fwctl_rpc_spec,
+})
+
 static void fwctl_device_release(struct device *device)
 {
 	struct fwctl_device *fwctl =
@@ -325,7 +605,7 @@ struct fwctl_device *_fwctl_alloc_device(struct device *parent,
 	if (!fwctl)
 		return NULL;
 
-	cdev_init(&fwctl->cdev, &fwctl_fops);
+	cdev_init(&fwctl->cdev, fwctl_fops);
 	/*
 	 * The driver module is protected by fwctl_register/unregister(),
 	 * unregister won't complete until we are done with the driver's module.
@@ -395,6 +675,9 @@ static int __init fwctl_init(void)
 {
 	int ret;
 
+	/* Initialize the wrapped file_operations */
+	kapi_init_fops_fwctl_fops();
+
 	ret = alloc_chrdev_region(&fwctl_dev, 0, FWCTL_MAX_DEVICES, "fwctl");
 	if (ret)
 		return ret;
@@ -402,8 +685,15 @@ static int __init fwctl_init(void)
 	ret = class_register(&fwctl_class);
 	if (ret)
 		goto err_chrdev;
+
+	ret = kapi_ioctl_specs_init();
+	if (ret)
+		goto err_class;
+
 	return 0;
 
+err_class:
+	class_unregister(&fwctl_class);
 err_chrdev:
 	unregister_chrdev_region(fwctl_dev, FWCTL_MAX_DEVICES);
 	return ret;
@@ -411,6 +701,7 @@ static int __init fwctl_init(void)
 
 static void __exit fwctl_exit(void)
 {
+	kapi_ioctl_specs_exit();
 	class_unregister(&fwctl_class);
 	unregister_chrdev_region(fwctl_dev, FWCTL_MAX_DEVICES);
 }
-- 
2.39.5



Return-Path: <linux-api+bounces-3923-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACEA3AD9D2C
	for <lists+linux-api@lfdr.de>; Sat, 14 Jun 2025 15:52:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67B5C3B05EA
	for <lists+linux-api@lfdr.de>; Sat, 14 Jun 2025 13:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCE472EACEE;
	Sat, 14 Jun 2025 13:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iSLwpMe+"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 930C12EACE4;
	Sat, 14 Jun 2025 13:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749908957; cv=none; b=R6//Mkbpc3nAxNj2AHY41iZcTT+6/t2nmcqSjBy3HatT9of/2mkhKI4iwIth1fiBOhIvWlP4uxr7XhHcUCJ/+25Vl/dWfx9kbZUqL5LYZZvhjl9iU/2MuroBGYkZCHwh6ioa8NjZELInSNJ4JjDMmaX/Or4ht6hahSF57MZ4wzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749908957; c=relaxed/simple;
	bh=xpm4SrrZ3ZJ0RDo4NgssIWkYzLDT+qKUSusys7hGU00=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=S3n6Vwpen301Yq6dBxwtq2Fwat9ecBJzyu50B6XNQ8gSSLvJAUS4fFwaJntHXIzKvrvuCYiftqq34E6d7VGYJe0J6cCYXSqahk8c8cAktHfYZgCdAuDarHRR0YSEapcKQGbxfbmPEKSF6atVSEqtRgf8ir3j5v1i17r61mYDBro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iSLwpMe+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1D28C4CEEB;
	Sat, 14 Jun 2025 13:49:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749908957;
	bh=xpm4SrrZ3ZJ0RDo4NgssIWkYzLDT+qKUSusys7hGU00=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iSLwpMe+c9grQy2zeI4BGb5WU9CWPXW37xmkpxdJDjTy1h4iSWx8JTOtc4kEYeJo9
	 iDbLKpCqShSy5OWO7WkfJq0cZ/InF9dehRFlma/Jo50OI1krLccuJ+ieXrT15UfyeM
	 ezCZRpSdgSaF9fMK6TXo/1QoHzS8FEUo9C6Px48HEwLHxWYICyFMf+Q4H9IahRksGQ
	 mBTbs6JL6d6UYBtL9gIU7yFfXphP/H/nC0W1RnRCNCGSxhr0NME2XGUDDRD/lxU8Dc
	 4aWe96Hlvt1V/YX39WwZe3hLtaVjNZEW8gBY8a1HhPpwtbiNdMAbEZP6JeJVyKpaOH
	 Ykbm5gMRma6HQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-api@vger.kernel.org,
	workflows@vger.kernel.org,
	tools@kernel.org,
	Sasha Levin <sashal@kernel.org>
Subject: [RFC 18/19] binder: add detailed IOCTL API specifications
Date: Sat, 14 Jun 2025 09:48:57 -0400
Message-Id: <20250614134858.790460-19-sashal@kernel.org>
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

Add kernel API specifications to the binder driver using the IOCTL
specification framework. This provides detailed documentation and
enables runtime validation of all binder IOCTL interfaces.

Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/android/binder.c | 758 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 758 insertions(+)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index c463ca4a8fff8..975f07216724b 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -67,6 +67,8 @@
 #include <linux/task_work.h>
 #include <linux/sizes.h>
 #include <linux/ktime.h>
+#include <linux/ioctl_api_spec.h>
+#include <linux/kernel_api_spec.h>
 
 #include <uapi/linux/android/binder.h>
 
@@ -6930,6 +6932,7 @@ static int transaction_log_show(struct seq_file *m, void *unused)
 	return 0;
 }
 
+/* Define the actual binder_fops structure */
 const struct file_operations binder_fops = {
 	.owner = THIS_MODULE,
 	.poll = binder_poll,
@@ -6941,6 +6944,751 @@ const struct file_operations binder_fops = {
 	.release = binder_release,
 };
 
+/* Define wrapper for KAPI validation */
+#ifdef CONFIG_KAPI_RUNTIME_CHECKS
+static struct file_operations __kapi_wrapped_binder_fops;
+static struct kapi_fops_wrapper __kapi_wrapper_binder_fops;
+
+static void kapi_init_fops_binder_fops(void)
+{
+	if (binder_fops.unlocked_ioctl) {
+		__kapi_wrapped_binder_fops = binder_fops;
+		__kapi_wrapper_binder_fops.real_fops = &binder_fops;
+		__kapi_wrapper_binder_fops.wrapped_fops = &__kapi_wrapped_binder_fops;
+		__kapi_wrapper_binder_fops.real_ioctl = binder_fops.unlocked_ioctl;
+		__kapi_wrapped_binder_fops.unlocked_ioctl = kapi_ioctl_validation_wrapper;
+		kapi_register_wrapper(&__kapi_wrapper_binder_fops);
+	}
+}
+#else
+static inline void kapi_init_fops_binder_fops(void) {}
+#endif
+
+/* IOCTL API Specifications for Binder */
+
+static const struct kapi_ioctl_spec binder_write_read_spec = {
+	.cmd = BINDER_WRITE_READ,
+	.cmd_name = "BINDER_WRITE_READ",
+	.input_size = sizeof(struct binder_write_read),
+	.output_size = sizeof(struct binder_write_read),
+	.file_ops_name = "binder_fops",
+	.api_spec = {
+		.name = "binder_write_read",
+	KAPI_DESCRIPTION("Perform read/write operations on binder")
+	KAPI_LONG_DESC("Main workhorse of binder IPC. Allows writing commands to "
+		       "binder driver and reading responses. Commands are encoded "
+		       "in a special protocol format. Both read and write operations "
+		       "can be performed in a single ioctl call.")
+	KAPI_CONTEXT(KAPI_CTX_PROCESS | KAPI_CTX_SLEEPABLE)
+
+	/* Parameters */
+	KAPI_PARAM(0, "write_size", "binder_size_t", "Bytes to write")
+		KAPI_PARAM_FLAGS(KAPI_PARAM_IN)
+		.type = KAPI_TYPE_UINT,
+		.constraint_type = KAPI_CONSTRAINT_RANGE,
+		.min_value = 0,
+		.max_value = SZ_4M,	/* Reasonable limit for IPC */
+	KAPI_PARAM_END
+
+	KAPI_PARAM(1, "write_consumed", "binder_size_t", "Bytes consumed by driver")
+		KAPI_PARAM_FLAGS(KAPI_PARAM_OUT)
+		.type = KAPI_TYPE_UINT,
+		.constraint_type = KAPI_CONSTRAINT_RANGE,
+		.min_value = 0,
+		.max_value = SZ_4M,
+	KAPI_PARAM_END
+
+	KAPI_PARAM(2, "write_buffer", "binder_uintptr_t", "User buffer with commands")
+		KAPI_PARAM_FLAGS(KAPI_PARAM_IN | KAPI_PARAM_USER)
+		.type = KAPI_TYPE_USER_PTR,
+		.size_param_idx = 0,
+	KAPI_PARAM_END
+
+	KAPI_PARAM(3, "read_size", "binder_size_t", "Bytes to read")
+		KAPI_PARAM_FLAGS(KAPI_PARAM_IN)
+		.type = KAPI_TYPE_UINT,
+		.constraint_type = KAPI_CONSTRAINT_RANGE,
+		.min_value = 0,
+		.max_value = SZ_4M,
+	KAPI_PARAM_END
+
+	KAPI_PARAM(4, "read_consumed", "binder_size_t", "Bytes consumed by driver")
+		KAPI_PARAM_FLAGS(KAPI_PARAM_OUT)
+		.type = KAPI_TYPE_UINT,
+		.constraint_type = KAPI_CONSTRAINT_RANGE,
+		.min_value = 0,
+		.max_value = SZ_4M,
+	KAPI_PARAM_END
+
+	KAPI_PARAM(5, "read_buffer", "binder_uintptr_t", "User buffer for responses")
+		KAPI_PARAM_FLAGS(KAPI_PARAM_OUT | KAPI_PARAM_USER)
+		.type = KAPI_TYPE_USER_PTR,
+		.size_param_idx = 3,
+	KAPI_PARAM_END
+
+	/* Return value */
+	KAPI_RETURN("int", "0 on success, negative errno on failure")
+		.type = KAPI_TYPE_INT,
+		.check_type = KAPI_RETURN_ERROR_CHECK,
+		.error_values = (const s64[]){-EFAULT, -EINVAL, -EAGAIN, -EINTR,
+					      -ENOMEM, -ECONNREFUSED},
+		.error_count = 6,
+	KAPI_RETURN_END
+
+	/* Errors */
+	KAPI_ERROR(0, -EFAULT, "EFAULT", "Failed to copy data to/from user space",
+		   "Check buffer pointers are valid user space addresses")
+	KAPI_ERROR(1, -EINVAL, "EINVAL", "Invalid parameters",
+		   "Buffer sizes or commands are invalid")
+	KAPI_ERROR(2, -EAGAIN, "EAGAIN", "Try again",
+		   "Non-blocking read with no data available")
+	KAPI_ERROR(3, -EINTR, "EINTR", "Interrupted by signal",
+		   "Operation interrupted, should be retried")
+	KAPI_ERROR(4, -ENOMEM, "ENOMEM", "Out of memory",
+		   "Unable to allocate memory for operation")
+	KAPI_ERROR(5, -ECONNREFUSED, "ECONNREFUSED", "Connection refused",
+		   "Process is being destroyed, no further operations allowed")
+
+	.error_count = 6,
+	.param_count = 6,
+	.since_version = "3.0",
+	.notes = "This is the primary interface for binder IPC. Most other "
+		 "ioctls are for configuration and management.",
+
+	/* Structure specifications */
+	KAPI_STRUCT_SPEC(0, binder_write_read, "Read/write operation structure")
+		KAPI_STRUCT_SIZE(sizeof(struct binder_write_read), __alignof__(struct binder_write_read))
+		KAPI_STRUCT_FIELD_COUNT(6)
+
+		KAPI_STRUCT_FIELD(0, "write_size", KAPI_TYPE_UINT, "binder_size_t",
+				  "Number of bytes to write")
+			KAPI_FIELD_OFFSET(offsetof(struct binder_write_read, write_size))
+			KAPI_FIELD_SIZE(sizeof(binder_size_t))
+		KAPI_STRUCT_FIELD_END
+
+		KAPI_STRUCT_FIELD(1, "write_consumed", KAPI_TYPE_UINT, "binder_size_t",
+				  "Number of bytes consumed by driver")
+			KAPI_FIELD_OFFSET(offsetof(struct binder_write_read, write_consumed))
+			KAPI_FIELD_SIZE(sizeof(binder_size_t))
+		KAPI_STRUCT_FIELD_END
+
+		KAPI_STRUCT_FIELD(2, "write_buffer", KAPI_TYPE_PTR, "binder_uintptr_t",
+				  "Pointer to write buffer")
+			KAPI_FIELD_OFFSET(offsetof(struct binder_write_read, write_buffer))
+			KAPI_FIELD_SIZE(sizeof(binder_uintptr_t))
+		KAPI_STRUCT_FIELD_END
+
+		KAPI_STRUCT_FIELD(3, "read_size", KAPI_TYPE_UINT, "binder_size_t",
+				  "Number of bytes to read")
+			KAPI_FIELD_OFFSET(offsetof(struct binder_write_read, read_size))
+			KAPI_FIELD_SIZE(sizeof(binder_size_t))
+		KAPI_STRUCT_FIELD_END
+
+		KAPI_STRUCT_FIELD(4, "read_consumed", KAPI_TYPE_UINT, "binder_size_t",
+				  "Number of bytes consumed by driver")
+			KAPI_FIELD_OFFSET(offsetof(struct binder_write_read, read_consumed))
+			KAPI_FIELD_SIZE(sizeof(binder_size_t))
+		KAPI_STRUCT_FIELD_END
+
+		KAPI_STRUCT_FIELD(5, "read_buffer", KAPI_TYPE_PTR, "binder_uintptr_t",
+				  "Pointer to read buffer")
+			KAPI_FIELD_OFFSET(offsetof(struct binder_write_read, read_buffer))
+			KAPI_FIELD_SIZE(sizeof(binder_uintptr_t))
+		KAPI_STRUCT_FIELD_END
+	KAPI_STRUCT_SPEC_END
+
+	KAPI_STRUCT_SPEC_COUNT(1)
+
+	/* Side effects */
+	KAPI_SIDE_EFFECT(0, KAPI_EFFECT_MODIFY_STATE | KAPI_EFFECT_NETWORK,
+			 "binder transaction queue",
+			 "Enqueues transactions or commands to target process")
+		KAPI_EFFECT_CONDITION("write_size > 0")
+	KAPI_SIDE_EFFECT_END
+
+	KAPI_SIDE_EFFECT(1, KAPI_EFFECT_MODIFY_STATE | KAPI_EFFECT_SCHEDULE,
+			 "process state",
+			 "May block waiting for incoming transactions")
+		KAPI_EFFECT_CONDITION("read_size > 0 && no data available")
+	KAPI_SIDE_EFFECT_END
+
+	KAPI_SIDE_EFFECT(2, KAPI_EFFECT_RESOURCE_CREATE,
+			 "binder nodes/refs",
+			 "May create or destroy binder nodes and references")
+		KAPI_EFFECT_CONDITION("specific commands")
+		KAPI_EFFECT_REVERSIBLE
+	KAPI_SIDE_EFFECT_END
+
+	KAPI_SIDE_EFFECT(3, KAPI_EFFECT_SIGNAL_SEND,
+			 "target process",
+			 "May trigger death notifications to linked processes")
+		KAPI_EFFECT_CONDITION("death notification")
+	KAPI_SIDE_EFFECT_END
+
+	KAPI_SIDE_EFFECT_COUNT(4)
+
+	/* State transitions */
+	KAPI_STATE_TRANS(0, "transaction",
+			 "pending in sender", "queued in target",
+			 "Transaction moves from sender to target's queue")
+		KAPI_STATE_TRANS_COND("BC_TRANSACTION command")
+	KAPI_STATE_TRANS_END
+
+	KAPI_STATE_TRANS(1, "thread state",
+			 "running", "waiting for work",
+			 "Thread blocks waiting for incoming transactions")
+		KAPI_STATE_TRANS_COND("read with no work available")
+	KAPI_STATE_TRANS_END
+
+	KAPI_STATE_TRANS(2, "binder ref",
+			 "active", "released",
+			 "Reference count decremented, may trigger cleanup")
+		KAPI_STATE_TRANS_COND("BC_RELEASE command")
+	KAPI_STATE_TRANS_END
+
+	KAPI_STATE_TRANS_COUNT(3)
+	},
+};
+
+static const struct kapi_ioctl_spec binder_set_max_threads_spec = {
+	.cmd = BINDER_SET_MAX_THREADS,
+	.cmd_name = "BINDER_SET_MAX_THREADS",
+	.input_size = sizeof(__u32),
+	.output_size = 0,
+	.file_ops_name = "binder_fops",
+	.api_spec = {
+		.name = "binder_set_max_threads",
+	KAPI_DESCRIPTION("Set maximum number of binder threads")
+	KAPI_LONG_DESC("Sets the maximum number of threads that the binder driver "
+		       "will request this process to spawn for handling incoming "
+		       "transactions. The driver sends BR_SPAWN_LOOPER when it needs "
+		       "more threads.")
+	KAPI_CONTEXT(KAPI_CTX_PROCESS | KAPI_CTX_SLEEPABLE)
+
+	/* Parameters */
+	KAPI_PARAM(0, "max_threads", "__u32", "Maximum number of threads")
+		KAPI_PARAM_FLAGS(KAPI_PARAM_IN)
+		.type = KAPI_TYPE_UINT,
+		.constraint_type = KAPI_CONSTRAINT_RANGE,
+		.min_value = 0,
+		.max_value = INT_MAX,
+	KAPI_PARAM_END
+
+	/* Return value */
+	KAPI_RETURN("int", "0 on success, negative errno on failure")
+		.type = KAPI_TYPE_INT,
+		.check_type = KAPI_RETURN_ERROR_CHECK,
+		.error_values = (const s64[]){-EINVAL, -EFAULT},
+		.error_count = 2,
+	KAPI_RETURN_END
+
+	/* Errors */
+	KAPI_ERROR(0, -EINVAL, "EINVAL", "Invalid thread count",
+		   "Thread count exceeds system limits")
+	KAPI_ERROR(1, -EFAULT, "EFAULT", "Failed to copy from user",
+		   "Invalid user pointer provided")
+
+	.error_count = 2,
+	.param_count = 1,
+	.since_version = "3.0",
+	},
+};
+
+static const struct kapi_ioctl_spec binder_set_context_mgr_spec = {
+	.cmd = BINDER_SET_CONTEXT_MGR,
+	.cmd_name = "BINDER_SET_CONTEXT_MGR",
+	.input_size = 0,
+	.output_size = 0,
+	.file_ops_name = "binder_fops",
+	.api_spec = {
+		.name = "binder_set_context_mgr",
+	KAPI_DESCRIPTION("Become the context manager (handle 0)")
+	KAPI_LONG_DESC("Registers the calling process as the context manager for "
+		       "this binder domain. The context manager has special handle 0 "
+		       "and typically implements the service manager. Only one process "
+		       "per binder domain can be the context manager.")
+	KAPI_CONTEXT(KAPI_CTX_PROCESS | KAPI_CTX_SLEEPABLE)
+
+	/* Return value */
+	KAPI_RETURN("int", "0 on success, negative errno on failure")
+		.type = KAPI_TYPE_INT,
+		.check_type = KAPI_RETURN_ERROR_CHECK,
+		.error_values = (const s64[]){-EBUSY, -EPERM, -ENOMEM},
+		.error_count = 3,
+	KAPI_RETURN_END
+
+	/* Errors */
+	KAPI_ERROR(0, -EBUSY, "EBUSY", "Context manager already set",
+		   "Another process is already the context manager")
+	KAPI_ERROR(1, -EPERM, "EPERM", "Permission denied",
+		   "Caller lacks permission or wrong UID")
+	KAPI_ERROR(2, -ENOMEM, "ENOMEM", "Out of memory",
+		   "Unable to allocate context manager node")
+
+	.error_count = 3,
+	.param_count = 0,
+	.since_version = "3.0",
+	.notes = "Requires CAP_SYS_NICE or proper SELinux permissions",
+	},
+};
+
+static const struct kapi_ioctl_spec binder_set_context_mgr_ext_spec = {
+	.cmd = BINDER_SET_CONTEXT_MGR_EXT,
+	.cmd_name = "BINDER_SET_CONTEXT_MGR_EXT",
+	.input_size = sizeof(struct flat_binder_object),
+	.output_size = 0,
+	.file_ops_name = "binder_fops",
+	.api_spec = {
+		.name = "binder_set_context_mgr_ext",
+	KAPI_DESCRIPTION("Become context manager with extended info")
+	KAPI_LONG_DESC("Extended version of BINDER_SET_CONTEXT_MGR that allows "
+		       "specifying additional properties of the context manager "
+		       "through a flat_binder_object structure.")
+	KAPI_CONTEXT(KAPI_CTX_PROCESS | KAPI_CTX_SLEEPABLE)
+
+	/* Parameters */
+	KAPI_PARAM(0, "object", "struct flat_binder_object", "Context manager properties")
+		KAPI_PARAM_FLAGS(KAPI_PARAM_IN)
+		.type = KAPI_TYPE_STRUCT,
+		.size = sizeof(struct flat_binder_object),
+	KAPI_PARAM_END
+
+	/* Return value */
+	KAPI_RETURN("int", "0 on success, negative errno on failure")
+		.type = KAPI_TYPE_INT,
+		.check_type = KAPI_RETURN_ERROR_CHECK,
+		.error_values = (const s64[]){-EINVAL, -EFAULT, -EBUSY, -EPERM, -ENOMEM},
+		.error_count = 5,
+	KAPI_RETURN_END
+
+	/* Errors */
+	KAPI_ERROR(0, -EINVAL, "EINVAL", "Invalid parameters",
+		   "Invalid flat_binder_object structure")
+	KAPI_ERROR(1, -EFAULT, "EFAULT", "Failed to copy from user",
+		   "Invalid user pointer provided")
+	KAPI_ERROR(2, -EBUSY, "EBUSY", "Context manager already set",
+		   "Another process is already the context manager")
+	KAPI_ERROR(3, -EPERM, "EPERM", "Permission denied",
+		   "Caller lacks permission or wrong UID")
+	KAPI_ERROR(4, -ENOMEM, "ENOMEM", "Out of memory",
+		   "Unable to allocate context manager node")
+
+	.error_count = 5,
+	.param_count = 1,
+	.since_version = "4.14",
+	},
+};
+
+static const struct kapi_ioctl_spec binder_thread_exit_spec = {
+	.cmd = BINDER_THREAD_EXIT,
+	.cmd_name = "BINDER_THREAD_EXIT",
+	.input_size = 0,
+	.output_size = 0,
+	.file_ops_name = "binder_fops",
+	.api_spec = {
+		.name = "binder_thread_exit",
+	KAPI_DESCRIPTION("Exit binder thread")
+	KAPI_LONG_DESC("Notifies the binder driver that this thread is exiting. "
+		       "The driver will clean up any pending transactions and "
+		       "remove the thread from the thread pool.")
+	KAPI_CONTEXT(KAPI_CTX_PROCESS | KAPI_CTX_SLEEPABLE)
+
+	/* Return value */
+	KAPI_RETURN("int", "0 on success, negative errno on failure")
+		.type = KAPI_TYPE_INT,
+		.check_type = KAPI_RETURN_ERROR_CHECK,
+		.error_values = (const s64[]){},
+		.error_count = 0,
+	KAPI_RETURN_END
+
+	.error_count = 0,
+	.param_count = 0,
+	.since_version = "3.0",
+	.notes = "Should be called before thread termination to ensure clean shutdown",
+	},
+};
+
+static const struct kapi_ioctl_spec binder_version_spec = {
+	.cmd = BINDER_VERSION,
+	.cmd_name = "BINDER_VERSION",
+	.input_size = 0,
+	.output_size = sizeof(struct binder_version),
+	.file_ops_name = "binder_fops",
+	.api_spec = {
+		.name = "binder_version",
+	KAPI_DESCRIPTION("Get binder protocol version")
+	KAPI_LONG_DESC("Returns the current binder protocol version supported "
+		       "by the driver. Used for compatibility checking.")
+	KAPI_CONTEXT(KAPI_CTX_PROCESS | KAPI_CTX_SLEEPABLE)
+
+	/* Parameters */
+	KAPI_PARAM(0, "protocol_version", "__s32", "Binder protocol version")
+		KAPI_PARAM_FLAGS(KAPI_PARAM_OUT)
+		.type = KAPI_TYPE_INT,
+		.constraint_type = KAPI_CONSTRAINT_ENUM,
+		.enum_values = (const s64[]){BINDER_CURRENT_PROTOCOL_VERSION},
+		.enum_count = 1,
+	KAPI_PARAM_END
+
+	/* Return value */
+	KAPI_RETURN("int", "0 on success, negative errno on failure")
+		.type = KAPI_TYPE_INT,
+		.check_type = KAPI_RETURN_ERROR_CHECK,
+		.error_values = (const s64[]){-EINVAL, -EFAULT},
+		.error_count = 2,
+	KAPI_RETURN_END
+
+	/* Errors */
+	KAPI_ERROR(0, -EINVAL, "EINVAL", "Invalid version structure",
+		   "Invalid user pointer for version structure")
+	KAPI_ERROR(1, -EFAULT, "EFAULT", "Failed to copy to user",
+		   "Unable to write version to user space")
+
+	.error_count = 2,
+	.param_count = 1,
+	.since_version = "3.0",
+	},
+};
+
+static const struct kapi_ioctl_spec binder_get_node_info_for_ref_spec = {
+	.cmd = BINDER_GET_NODE_INFO_FOR_REF,
+	.cmd_name = "BINDER_GET_NODE_INFO_FOR_REF",
+	.input_size = sizeof(struct binder_node_info_for_ref),
+	.output_size = sizeof(struct binder_node_info_for_ref),
+	.file_ops_name = "binder_fops",
+	.api_spec = {
+		.name = "binder_get_node_info_for_ref",
+	KAPI_DESCRIPTION("Get node information for a reference")
+	KAPI_LONG_DESC("Retrieves information about a binder node given its handle. "
+		       "Returns the current strong and weak reference counts.")
+	KAPI_CONTEXT(KAPI_CTX_PROCESS | KAPI_CTX_SLEEPABLE)
+
+	/* Parameters */
+	KAPI_PARAM(0, "handle", "__u32", "Binder handle")
+		KAPI_PARAM_FLAGS(KAPI_PARAM_IN)
+		.type = KAPI_TYPE_UINT,
+	KAPI_PARAM_END
+
+	KAPI_PARAM(1, "strong_count", "__u32", "Strong reference count")
+		KAPI_PARAM_FLAGS(KAPI_PARAM_OUT)
+		.type = KAPI_TYPE_UINT,
+	KAPI_PARAM_END
+
+	KAPI_PARAM(2, "weak_count", "__u32", "Weak reference count")
+		KAPI_PARAM_FLAGS(KAPI_PARAM_OUT)
+		.type = KAPI_TYPE_UINT,
+	KAPI_PARAM_END
+
+	/* Return value */
+	KAPI_RETURN("int", "0 on success, negative errno on failure")
+		.type = KAPI_TYPE_INT,
+		.check_type = KAPI_RETURN_ERROR_CHECK,
+		.error_values = (const s64[]){-EINVAL, -EFAULT, -ENOENT},
+		.error_count = 3,
+	KAPI_RETURN_END
+
+	/* Errors */
+	KAPI_ERROR(0, -EINVAL, "EINVAL", "Invalid parameters",
+		   "Reserved fields must be zero")
+	KAPI_ERROR(1, -EFAULT, "EFAULT", "Failed to copy data",
+		   "Invalid user pointer provided")
+	KAPI_ERROR(2, -ENOENT, "ENOENT", "Handle not found",
+		   "No node exists for the given handle")
+
+	.error_count = 3,
+	.param_count = 3,
+	.since_version = "4.14",
+	},
+};
+
+static const struct kapi_ioctl_spec binder_get_node_debug_info_spec = {
+	.cmd = BINDER_GET_NODE_DEBUG_INFO,
+	.cmd_name = "BINDER_GET_NODE_DEBUG_INFO",
+	.input_size = sizeof(struct binder_node_debug_info),
+	.output_size = sizeof(struct binder_node_debug_info),
+	.file_ops_name = "binder_fops",
+	.api_spec = {
+		.name = "binder_get_node_debug_info",
+	KAPI_DESCRIPTION("Get debug info for binder nodes")
+	KAPI_LONG_DESC("Iterates through all binder nodes in the process. "
+		       "Start with ptr=NULL to get first node, then use "
+		       "returned ptr for next call. Returns ptr=0 when done.")
+	KAPI_CONTEXT(KAPI_CTX_PROCESS | KAPI_CTX_SLEEPABLE)
+
+	/* Parameters */
+	KAPI_PARAM(0, "ptr", "binder_uintptr_t", "Node pointer (NULL for first)")
+		KAPI_PARAM_FLAGS(KAPI_PARAM_INOUT)
+		.type = KAPI_TYPE_PTR,
+	KAPI_PARAM_END
+
+	KAPI_PARAM(1, "cookie", "binder_uintptr_t", "Node cookie value")
+		KAPI_PARAM_FLAGS(KAPI_PARAM_OUT)
+		.type = KAPI_TYPE_UINT,
+	KAPI_PARAM_END
+
+	KAPI_PARAM(2, "has_strong_ref", "__u32", "Has strong references")
+		KAPI_PARAM_FLAGS(KAPI_PARAM_OUT)
+		.type = KAPI_TYPE_UINT,
+		.constraint_type = KAPI_CONSTRAINT_RANGE,
+		.min_value = 0,
+		.max_value = 1,
+	KAPI_PARAM_END
+
+	KAPI_PARAM(3, "has_weak_ref", "__u32", "Has weak references")
+		KAPI_PARAM_FLAGS(KAPI_PARAM_OUT)
+		.type = KAPI_TYPE_UINT,
+		.constraint_type = KAPI_CONSTRAINT_RANGE,
+		.min_value = 0,
+		.max_value = 1,
+	KAPI_PARAM_END
+
+	/* Return value */
+	KAPI_RETURN("int", "0 on success, negative errno on failure")
+		.type = KAPI_TYPE_INT,
+		.check_type = KAPI_RETURN_ERROR_CHECK,
+		.error_values = (const s64[]){-EFAULT, -EINVAL},
+		.error_count = 2,
+	KAPI_RETURN_END
+
+	/* Errors */
+	KAPI_ERROR(0, -EFAULT, "EFAULT", "Failed to copy data",
+		   "Invalid user pointer provided")
+	KAPI_ERROR(1, -EINVAL, "EINVAL", "Invalid node pointer",
+		   "Provided ptr is not a valid node")
+
+	.error_count = 2,
+	.param_count = 4,
+	.since_version = "4.14",
+	},
+};
+
+static const struct kapi_ioctl_spec binder_freeze_spec = {
+	.cmd = BINDER_FREEZE,
+	.cmd_name = "BINDER_FREEZE",
+	.input_size = sizeof(struct binder_freeze_info),
+	.output_size = 0,
+	.file_ops_name = "binder_fops",
+	.api_spec = {
+		.name = "binder_freeze",
+	KAPI_DESCRIPTION("Freeze or unfreeze a binder process")
+	KAPI_LONG_DESC("Controls whether a process can receive binder transactions. "
+		       "When frozen, new transactions are blocked. Can wait for "
+		       "existing transactions to complete with timeout.")
+	KAPI_CONTEXT(KAPI_CTX_PROCESS | KAPI_CTX_SLEEPABLE)
+
+	/* Parameters */
+	KAPI_PARAM(0, "pid", "__u32", "Process ID to freeze/unfreeze")
+		KAPI_PARAM_FLAGS(KAPI_PARAM_IN)
+		.type = KAPI_TYPE_UINT,
+		.constraint_type = KAPI_CONSTRAINT_RANGE,
+		.min_value = 1,
+		.max_value = PID_MAX_LIMIT,
+	KAPI_PARAM_END
+
+	KAPI_PARAM(1, "enable", "__u32", "1 to freeze, 0 to unfreeze")
+		KAPI_PARAM_FLAGS(KAPI_PARAM_IN)
+		.type = KAPI_TYPE_UINT,
+		.constraint_type = KAPI_CONSTRAINT_RANGE,
+		.min_value = 0,
+		.max_value = 1,
+	KAPI_PARAM_END
+
+	KAPI_PARAM(2, "timeout_ms", "__u32", "Timeout in milliseconds (0 = no wait)")
+		KAPI_PARAM_FLAGS(KAPI_PARAM_IN)
+		.type = KAPI_TYPE_UINT,
+		.constraint_type = KAPI_CONSTRAINT_RANGE,
+		.min_value = 0,
+		.max_value = 60000,	/* 1 minute max */
+	KAPI_PARAM_END
+
+	/* Return value */
+	KAPI_RETURN("int", "0 on success, negative errno on failure")
+		.type = KAPI_TYPE_INT,
+		.check_type = KAPI_RETURN_ERROR_CHECK,
+		.error_values = (const s64[]){-EINVAL, -EAGAIN, -EFAULT, -ENOMEM},
+		.error_count = 4,
+	KAPI_RETURN_END
+
+	/* Errors */
+	KAPI_ERROR(0, -EINVAL, "EINVAL", "Invalid process",
+		   "Process not found or invalid parameters")
+	KAPI_ERROR(1, -EAGAIN, "EAGAIN", "Timeout waiting for transactions",
+		   "Existing transactions did not complete within timeout")
+	KAPI_ERROR(2, -EFAULT, "EFAULT", "Failed to copy from user",
+		   "Invalid user pointer provided")
+	KAPI_ERROR(3, -ENOMEM, "ENOMEM", "Out of memory",
+		   "Unable to allocate memory for freeze operation")
+
+	.error_count = 4,
+	.param_count = 3,
+	.since_version = "5.9",
+	.notes = "Requires appropriate permissions to freeze other processes",
+	},
+};
+
+static const struct kapi_ioctl_spec binder_get_frozen_info_spec = {
+	.cmd = BINDER_GET_FROZEN_INFO,
+	.cmd_name = "BINDER_GET_FROZEN_INFO",
+	.input_size = sizeof(struct binder_frozen_status_info),
+	.output_size = sizeof(struct binder_frozen_status_info),
+	.file_ops_name = "binder_fops",
+	.api_spec = {
+		.name = "binder_get_frozen_info",
+	KAPI_DESCRIPTION("Get frozen status of a process")
+	KAPI_LONG_DESC("Queries whether a process is frozen and if it has "
+		       "received transactions while frozen. Useful for "
+		       "debugging frozen process issues.")
+	KAPI_CONTEXT(KAPI_CTX_PROCESS | KAPI_CTX_SLEEPABLE)
+
+	/* Parameters */
+	KAPI_PARAM(0, "pid", "__u32", "Process ID to query")
+		KAPI_PARAM_FLAGS(KAPI_PARAM_IN)
+		.type = KAPI_TYPE_UINT,
+		.constraint_type = KAPI_CONSTRAINT_RANGE,
+		.min_value = 1,
+		.max_value = PID_MAX_LIMIT,
+	KAPI_PARAM_END
+
+	KAPI_PARAM(1, "sync_recv", "__u32", "Sync transactions received while frozen")
+		KAPI_PARAM_FLAGS(KAPI_PARAM_OUT)
+		.type = KAPI_TYPE_UINT,
+		.constraints = "Bit 0: received after frozen, Bit 1: pending during freeze",
+	KAPI_PARAM_END
+
+	KAPI_PARAM(2, "async_recv", "__u32", "Async transactions received while frozen")
+		KAPI_PARAM_FLAGS(KAPI_PARAM_OUT)
+		.type = KAPI_TYPE_UINT,
+	KAPI_PARAM_END
+
+	/* Return value */
+	KAPI_RETURN("int", "0 on success, negative errno on failure")
+		.type = KAPI_TYPE_INT,
+		.check_type = KAPI_RETURN_ERROR_CHECK,
+		.error_values = (const s64[]){-EINVAL, -EFAULT},
+		.error_count = 2,
+	KAPI_RETURN_END
+
+	/* Errors */
+	KAPI_ERROR(0, -EINVAL, "EINVAL", "Process not found",
+		   "No binder process found with given PID")
+	KAPI_ERROR(1, -EFAULT, "EFAULT", "Failed to copy data",
+		   "Invalid user pointer provided")
+
+	.error_count = 2,
+	.param_count = 3,
+	.since_version = "5.9",
+	},
+};
+
+static const struct kapi_ioctl_spec binder_enable_oneway_spam_detection_spec = {
+	.cmd = BINDER_ENABLE_ONEWAY_SPAM_DETECTION,
+	.cmd_name = "BINDER_ENABLE_ONEWAY_SPAM_DETECTION",
+	.input_size = sizeof(__u32),
+	.output_size = 0,
+	.file_ops_name = "binder_fops",
+	.api_spec = {
+		.name = "binder_enable_oneway_spam_detection",
+	KAPI_DESCRIPTION("Enable/disable oneway spam detection")
+	KAPI_LONG_DESC("Controls whether the driver monitors for excessive "
+		       "oneway transactions that might indicate spam or abuse. "
+		       "When enabled, BR_ONEWAY_SPAM_SUSPECT is sent when threshold exceeded.")
+	KAPI_CONTEXT(KAPI_CTX_PROCESS | KAPI_CTX_SLEEPABLE)
+
+	/* Parameters */
+	KAPI_PARAM(0, "enable", "__u32", "1 to enable, 0 to disable")
+		KAPI_PARAM_FLAGS(KAPI_PARAM_IN)
+		.type = KAPI_TYPE_UINT,
+		.constraint_type = KAPI_CONSTRAINT_RANGE,
+		.min_value = 0,
+		.max_value = 1,
+	KAPI_PARAM_END
+
+	/* Return value */
+	KAPI_RETURN("int", "0 on success, negative errno on failure")
+		.type = KAPI_TYPE_INT,
+		.check_type = KAPI_RETURN_ERROR_CHECK,
+		.error_values = (const s64[]){-EFAULT},
+		.error_count = 1,
+	KAPI_RETURN_END
+
+	/* Errors */
+	KAPI_ERROR(0, -EFAULT, "EFAULT", "Failed to copy from user",
+		   "Invalid user pointer provided")
+
+	.error_count = 1,
+	.param_count = 1,
+	.since_version = "5.13",
+	},
+};
+
+static const struct kapi_ioctl_spec binder_get_extended_error_spec = {
+	.cmd = BINDER_GET_EXTENDED_ERROR,
+	.cmd_name = "BINDER_GET_EXTENDED_ERROR",
+	.input_size = 0,
+	.output_size = sizeof(struct binder_extended_error),
+	.file_ops_name = "binder_fops",
+	.api_spec = {
+		.name = "binder_get_extended_error",
+	KAPI_DESCRIPTION("Get extended error information")
+	KAPI_LONG_DESC("Retrieves detailed error information from the last "
+		       "failed binder operation on this thread. Clears the "
+		       "error after reading.")
+	KAPI_CONTEXT(KAPI_CTX_PROCESS | KAPI_CTX_SLEEPABLE)
+
+	/* Parameters */
+	KAPI_PARAM(0, "id", "__u32", "Error identifier")
+		KAPI_PARAM_FLAGS(KAPI_PARAM_OUT)
+		.type = KAPI_TYPE_UINT,
+	KAPI_PARAM_END
+
+	KAPI_PARAM(1, "command", "__u32", "Binder command that failed")
+		KAPI_PARAM_FLAGS(KAPI_PARAM_OUT)
+		.type = KAPI_TYPE_UINT,
+	KAPI_PARAM_END
+
+	KAPI_PARAM(2, "param", "__s32", "Error parameter (negative errno)")
+		KAPI_PARAM_FLAGS(KAPI_PARAM_OUT)
+		.type = KAPI_TYPE_INT,
+		.constraint_type = KAPI_CONSTRAINT_RANGE,
+		.min_value = -MAX_ERRNO,
+		.max_value = 0,
+	KAPI_PARAM_END
+
+	/* Return value */
+	KAPI_RETURN("int", "0 on success, negative errno on failure")
+		.type = KAPI_TYPE_INT,
+		.check_type = KAPI_RETURN_ERROR_CHECK,
+		.error_values = (const s64[]){-EFAULT},
+		.error_count = 1,
+	KAPI_RETURN_END
+
+	/* Errors */
+	KAPI_ERROR(0, -EFAULT, "EFAULT", "Failed to copy to user",
+		   "Invalid user pointer provided")
+
+	.error_count = 1,
+	.param_count = 3,
+	.since_version = "5.16",
+	.notes = "Error is cleared after reading, subsequent calls return BR_OK",
+	},
+};
+
+/* Register all binder IOCTL specifications */
+KAPI_IOCTL_SPEC_DRIVER("binder", {
+	&binder_write_read_spec,
+	&binder_set_max_threads_spec,
+	&binder_set_context_mgr_spec,
+	&binder_set_context_mgr_ext_spec,
+	&binder_thread_exit_spec,
+	&binder_version_spec,
+	&binder_get_node_info_for_ref_spec,
+	&binder_get_node_debug_info_spec,
+	&binder_freeze_spec,
+	&binder_get_frozen_info_spec,
+	&binder_enable_oneway_spam_detection_spec,
+	&binder_get_extended_error_spec,
+})
+
 DEFINE_SHOW_ATTRIBUTE(state);
 DEFINE_SHOW_ATTRIBUTE(state_hashed);
 DEFINE_SHOW_ATTRIBUTE(stats);
@@ -7050,6 +7798,13 @@ static int __init binder_init(void)
 	if (ret)
 		return ret;
 
+	/* Initialize the wrapped file_operations */
+	kapi_init_fops_binder_fops();
+
+	ret = kapi_ioctl_specs_init();
+	if (ret)
+		goto err_kapi_init;
+
 	atomic_set(&binder_transaction_log.cur, ~0U);
 	atomic_set(&binder_transaction_log_failed.cur, ~0U);
 
@@ -7102,6 +7857,9 @@ static int __init binder_init(void)
 
 err_alloc_device_names_failed:
 	debugfs_remove_recursive(binder_debugfs_dir_entry_root);
+	kapi_ioctl_specs_exit();
+
+err_kapi_init:
 	binder_alloc_shrinker_exit();
 
 	return ret;
-- 
2.39.5



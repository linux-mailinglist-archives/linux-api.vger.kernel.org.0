Return-Path: <linux-api+bounces-3979-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4814EAE6E46
	for <lists+linux-api@lfdr.de>; Tue, 24 Jun 2025 20:11:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2DA5188F277
	for <lists+linux-api@lfdr.de>; Tue, 24 Jun 2025 18:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C1CF2EF9B8;
	Tue, 24 Jun 2025 18:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BxeOQpMk"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A6B02EF673;
	Tue, 24 Jun 2025 18:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750788477; cv=none; b=JQv/nwX0xjB5e4bgfRZ2PYDetYlLSgJhoybmNQNOvu0omIQHCZLE+2LaZSyyo1AHboQN9j17bACgzvAtPU8JQleZKV4jrlaFDPgGeHMMNdNaBxCe0oN2663SBRJbAKwFI/84Sa3jniJzELLCyMJ1m3uOnmltyvc1817gkjcQgxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750788477; c=relaxed/simple;
	bh=UwfOCXIiRF5YjFm+GxSv5TFdTHHt7yu5YvUXTI5XzBw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EuUYRk5LFcFx2DCtPYEVIM0ywlfml+5tQqYiKbdeQYSZYezu68zRl7wNYwzRPe73YMr0OcoV9tz2MutKIuc54xOT8gk2287rGlKYKQHyWtjSGqezwAVqi9Si2sTOHdABTqhXJne8kozAYjgzYAdWHog0dNto54J9UQWhcmskz2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BxeOQpMk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86FD7C4CEF0;
	Tue, 24 Jun 2025 18:07:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750788476;
	bh=UwfOCXIiRF5YjFm+GxSv5TFdTHHt7yu5YvUXTI5XzBw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BxeOQpMkeHesCOwlgqnGL47pH1zuXSltfEHgkwNnR93apXTcGKgMta3yfEm8e5R/a
	 yt7vsIEvjo1LdB3lC3C+IsgQ3T9rzshql+GWwtJ8etDcWOdwG2tnzY4pUN+v7MDSEE
	 nhDRx2CuOvvH4bac6fF6AoGQYTKopd6gPrKAmu3/UAFOjFiAStwW2LGQee/lJsslns
	 YfXleYvf0BJIQMKrA4Jd5r5WlRDzLSa6CzgTO0H/hgaLcfJ/V0tWnrlrBHzBHlQrx0
	 r15Zs+PQTjxPo5/tcDsdnpkpoXVruCIs057CbnjbmHKmNPD4B7TvunHQ6s6QJZjLD7
	 wLYZDj+gHxfbA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-doc@vger.kernel.org,
	linux-api@vger.kernel.org,
	workflows@vger.kernel.org,
	tools@kernel.org,
	Sasha Levin <sashal@kernel.org>
Subject: [RFC v2 18/22] binder: add detailed IOCTL API specifications
Date: Tue, 24 Jun 2025 14:07:38 -0400
Message-Id: <20250624180742.5795-19-sashal@kernel.org>
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

Add kernel API specifications to the binder driver using the IOCTL
specification framework. This provides detailed documentation and
enables runtime validation of all binder IOCTL interfaces.

Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/android/binder.c        | 701 ++++++++++++++++++++++++++++++++
 include/linux/kernel_api_spec.h |   3 +
 2 files changed, 704 insertions(+)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index c463ca4a8fff8..8879263cdb061 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -67,6 +67,7 @@
 #include <linux/task_work.h>
 #include <linux/sizes.h>
 #include <linux/ktime.h>
+#include <linux/kernel_api_spec.h>
 
 #include <uapi/linux/android/binder.h>
 
@@ -6930,6 +6931,7 @@ static int transaction_log_show(struct seq_file *m, void *unused)
 	return 0;
 }
 
+/* Define the actual binder_fops structure */
 const struct file_operations binder_fops = {
 	.owner = THIS_MODULE,
 	.poll = binder_poll,
@@ -6941,6 +6943,695 @@ const struct file_operations binder_fops = {
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
+DEFINE_KAPI_IOCTL_SPEC(binder_write_read)
+	KAPI_IOCTL_CMD(BINDER_WRITE_READ)
+	KAPI_IOCTL_CMD_NAME("BINDER_WRITE_READ")
+	KAPI_IOCTL_INPUT_SIZE(sizeof(struct binder_write_read))
+	KAPI_IOCTL_OUTPUT_SIZE(sizeof(struct binder_write_read))
+	KAPI_IOCTL_FILE_OPS_NAME("binder_fops")
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
+		KAPI_PARAM_TYPE(KAPI_TYPE_UINT)
+		KAPI_PARAM_CONSTRAINT_TYPE(KAPI_CONSTRAINT_RANGE)
+		KAPI_PARAM_RANGE(0, SZ_4M)	/* Reasonable limit for IPC */
+	KAPI_PARAM_END
+
+	KAPI_PARAM(1, "write_consumed", "binder_size_t", "Bytes consumed by driver")
+		KAPI_PARAM_FLAGS(KAPI_PARAM_OUT)
+		KAPI_PARAM_TYPE(KAPI_TYPE_UINT)
+		KAPI_PARAM_CONSTRAINT_TYPE(KAPI_CONSTRAINT_RANGE)
+		KAPI_PARAM_RANGE(0, SZ_4M)
+	KAPI_PARAM_END
+
+	KAPI_IOCTL_PARAM_USER_BUF(2, "write_buffer", "User buffer with commands", 0)
+
+	KAPI_PARAM(3, "read_size", "binder_size_t", "Bytes to read")
+		KAPI_PARAM_FLAGS(KAPI_PARAM_IN)
+		KAPI_PARAM_TYPE(KAPI_TYPE_UINT)
+		KAPI_PARAM_CONSTRAINT_TYPE(KAPI_CONSTRAINT_RANGE)
+		KAPI_PARAM_RANGE(0, SZ_4M)
+	KAPI_PARAM_END
+
+	KAPI_PARAM(4, "read_consumed", "binder_size_t", "Bytes consumed by driver")
+		KAPI_PARAM_FLAGS(KAPI_PARAM_OUT)
+		KAPI_PARAM_TYPE(KAPI_TYPE_UINT)
+		KAPI_PARAM_CONSTRAINT_TYPE(KAPI_CONSTRAINT_RANGE)
+		KAPI_PARAM_RANGE(0, SZ_4M)
+	KAPI_PARAM_END
+
+	KAPI_IOCTL_PARAM_USER_OUT_BUF(5, "read_buffer", "User buffer for responses", 3)
+
+	/* Return value */
+	KAPI_RETURN("int", "0 on success, negative errno on failure")
+		KAPI_RETURN_TYPE(KAPI_TYPE_INT)
+		KAPI_RETURN_CHECK_TYPE(KAPI_RETURN_ERROR_CHECK)
+		KAPI_RETURN_ERROR_VALUES(((const s64[]){-EFAULT, -EINVAL, -EAGAIN, -EINTR,
+					      -ENOMEM, -ECONNREFUSED}))
+		KAPI_RETURN_ERROR_COUNT(6)
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
+	KAPI_ERROR_COUNT(6)
+	KAPI_PARAM_COUNT(6)
+	KAPI_SINCE_VERSION("3.0")
+	KAPI_NOTES("This is the primary interface for binder IPC. Most other "
+		   "ioctls are for configuration and management.")
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
+KAPI_END_SPEC;
+
+DEFINE_KAPI_IOCTL_SPEC(binder_set_max_threads)
+	KAPI_IOCTL_CMD(BINDER_SET_MAX_THREADS)
+	KAPI_IOCTL_CMD_NAME("BINDER_SET_MAX_THREADS")
+	KAPI_IOCTL_INPUT_SIZE(sizeof(__u32))
+	KAPI_IOCTL_OUTPUT_SIZE(0)
+	KAPI_IOCTL_FILE_OPS_NAME("binder_fops")
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
+		KAPI_PARAM_TYPE(KAPI_TYPE_UINT)
+		KAPI_PARAM_CONSTRAINT_TYPE(KAPI_CONSTRAINT_RANGE)
+		KAPI_PARAM_RANGE(0, INT_MAX)
+	KAPI_PARAM_END
+
+	/* Return value */
+	KAPI_RETURN("int", "0 on success, negative errno on failure")
+		KAPI_RETURN_TYPE(KAPI_TYPE_INT)
+		KAPI_RETURN_CHECK_TYPE(KAPI_RETURN_ERROR_CHECK)
+		KAPI_RETURN_ERROR_VALUES(((const s64[]){-EINVAL, -EFAULT}))
+		KAPI_RETURN_ERROR_COUNT(2)
+	KAPI_RETURN_END
+
+	/* Errors */
+	KAPI_ERROR(0, -EINVAL, "EINVAL", "Invalid thread count",
+		   "Thread count exceeds system limits")
+	KAPI_ERROR(1, -EFAULT, "EFAULT", "Failed to copy from user",
+		   "Invalid user pointer provided")
+
+	KAPI_ERROR_COUNT(2)
+	KAPI_PARAM_COUNT(1)
+	KAPI_SINCE_VERSION("3.0")
+KAPI_END_SPEC;
+
+DEFINE_KAPI_IOCTL_SPEC(binder_set_context_mgr)
+	KAPI_IOCTL_CMD(BINDER_SET_CONTEXT_MGR)
+	KAPI_IOCTL_CMD_NAME("BINDER_SET_CONTEXT_MGR")
+	KAPI_IOCTL_INPUT_SIZE(0)
+	KAPI_IOCTL_OUTPUT_SIZE(0)
+	KAPI_IOCTL_FILE_OPS_NAME("binder_fops")
+	KAPI_DESCRIPTION("Become the context manager (handle 0)")
+	KAPI_LONG_DESC("Registers the calling process as the context manager for "
+		       "this binder domain. The context manager has special handle 0 "
+		       "and typically implements the service manager. Only one process "
+		       "per binder domain can be the context manager.")
+	KAPI_CONTEXT(KAPI_CTX_PROCESS | KAPI_CTX_SLEEPABLE)
+
+	/* Return value */
+	KAPI_RETURN("int", "0 on success, negative errno on failure")
+		KAPI_RETURN_TYPE(KAPI_TYPE_INT)
+		KAPI_RETURN_CHECK_TYPE(KAPI_RETURN_ERROR_CHECK)
+		KAPI_RETURN_ERROR_VALUES(((const s64[]){-EBUSY, -EPERM, -ENOMEM}))
+		KAPI_RETURN_ERROR_COUNT(3)
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
+	KAPI_ERROR_COUNT(3)
+	KAPI_PARAM_COUNT(0)
+	KAPI_SINCE_VERSION("3.0")
+	KAPI_NOTES("Requires CAP_SYS_NICE or proper SELinux permissions")
+KAPI_END_SPEC;
+
+DEFINE_KAPI_IOCTL_SPEC(binder_set_context_mgr_ext)
+	KAPI_IOCTL_CMD(BINDER_SET_CONTEXT_MGR_EXT)
+	KAPI_IOCTL_CMD_NAME("BINDER_SET_CONTEXT_MGR_EXT")
+	KAPI_IOCTL_INPUT_SIZE(sizeof(struct flat_binder_object))
+	KAPI_IOCTL_OUTPUT_SIZE(0)
+	KAPI_IOCTL_FILE_OPS_NAME("binder_fops")
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
+		KAPI_RETURN_TYPE(KAPI_TYPE_INT)
+		KAPI_RETURN_CHECK_TYPE(KAPI_RETURN_ERROR_CHECK)
+		KAPI_RETURN_ERROR_VALUES(((const s64[]){-EINVAL, -EFAULT, -EBUSY, -EPERM, -ENOMEM}))
+		KAPI_RETURN_ERROR_COUNT(5)
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
+	KAPI_ERROR_COUNT(5)
+	KAPI_PARAM_COUNT(1)
+	KAPI_SINCE_VERSION("4.14")
+KAPI_END_SPEC;
+
+DEFINE_KAPI_IOCTL_SPEC(binder_thread_exit)
+	KAPI_IOCTL_CMD(BINDER_THREAD_EXIT)
+	KAPI_IOCTL_CMD_NAME("BINDER_THREAD_EXIT")
+	KAPI_IOCTL_INPUT_SIZE(0)
+	KAPI_IOCTL_OUTPUT_SIZE(0)
+	KAPI_IOCTL_FILE_OPS_NAME("binder_fops")
+	KAPI_DESCRIPTION("Exit binder thread")
+	KAPI_LONG_DESC("Notifies the binder driver that this thread is exiting. "
+		       "The driver will clean up any pending transactions and "
+		       "remove the thread from the thread pool.")
+	KAPI_CONTEXT(KAPI_CTX_PROCESS | KAPI_CTX_SLEEPABLE)
+
+	/* Return value */
+	KAPI_RETURN("int", "0 on success, negative errno on failure")
+		KAPI_RETURN_TYPE(KAPI_TYPE_INT)
+		KAPI_RETURN_CHECK_TYPE(KAPI_RETURN_ERROR_CHECK)
+		KAPI_RETURN_ERROR_VALUES((const s64[]){})
+		KAPI_RETURN_ERROR_COUNT(0)
+	KAPI_RETURN_END
+
+	KAPI_ERROR_COUNT(0)
+	KAPI_PARAM_COUNT(0)
+	KAPI_SINCE_VERSION("3.0")
+	KAPI_NOTES("Should be called before thread termination to ensure clean shutdown")
+KAPI_END_SPEC;
+
+DEFINE_KAPI_IOCTL_SPEC(binder_version)
+	KAPI_IOCTL_CMD(BINDER_VERSION)
+	KAPI_IOCTL_CMD_NAME("BINDER_VERSION")
+	KAPI_IOCTL_INPUT_SIZE(0)
+	KAPI_IOCTL_OUTPUT_SIZE(sizeof(struct binder_version))
+	KAPI_IOCTL_FILE_OPS_NAME("binder_fops")
+	KAPI_DESCRIPTION("Get binder protocol version")
+	KAPI_LONG_DESC("Returns the current binder protocol version supported "
+		       "by the driver. Used for compatibility checking.")
+	KAPI_CONTEXT(KAPI_CTX_PROCESS | KAPI_CTX_SLEEPABLE)
+
+	/* Parameters */
+	KAPI_PARAM(0, "protocol_version", "__s32", "Binder protocol version")
+		KAPI_PARAM_FLAGS(KAPI_PARAM_OUT)
+		KAPI_PARAM_TYPE(KAPI_TYPE_INT)
+		KAPI_PARAM_CONSTRAINT_TYPE(KAPI_CONSTRAINT_ENUM)
+		.enum_values = (const s64[]){BINDER_CURRENT_PROTOCOL_VERSION},
+		.enum_count = 1,
+	KAPI_PARAM_END
+
+	/* Return value */
+	KAPI_RETURN("int", "0 on success, negative errno on failure")
+		KAPI_RETURN_TYPE(KAPI_TYPE_INT)
+		KAPI_RETURN_CHECK_TYPE(KAPI_RETURN_ERROR_CHECK)
+		KAPI_RETURN_ERROR_VALUES(((const s64[]){-EINVAL, -EFAULT}))
+		KAPI_RETURN_ERROR_COUNT(2)
+	KAPI_RETURN_END
+
+	/* Errors */
+	KAPI_ERROR(0, -EINVAL, "EINVAL", "Invalid version structure",
+		   "Invalid user pointer for version structure")
+	KAPI_ERROR(1, -EFAULT, "EFAULT", "Failed to copy to user",
+		   "Unable to write version to user space")
+
+	KAPI_ERROR_COUNT(2)
+	KAPI_PARAM_COUNT(1)
+	KAPI_SINCE_VERSION("3.0")
+KAPI_END_SPEC;
+
+DEFINE_KAPI_IOCTL_SPEC(binder_get_node_info_for_ref)
+	KAPI_IOCTL_CMD(BINDER_GET_NODE_INFO_FOR_REF)
+	KAPI_IOCTL_CMD_NAME("BINDER_GET_NODE_INFO_FOR_REF")
+	KAPI_IOCTL_INPUT_SIZE(sizeof(struct binder_node_info_for_ref))
+	KAPI_IOCTL_OUTPUT_SIZE(sizeof(struct binder_node_info_for_ref))
+	KAPI_IOCTL_FILE_OPS_NAME("binder_fops")
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
+		KAPI_RETURN_TYPE(KAPI_TYPE_INT)
+		KAPI_RETURN_CHECK_TYPE(KAPI_RETURN_ERROR_CHECK)
+		KAPI_RETURN_ERROR_VALUES(((const s64[]){-EINVAL, -EFAULT, -ENOENT}))
+		KAPI_RETURN_ERROR_COUNT(3)
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
+	KAPI_ERROR_COUNT(3)
+	KAPI_PARAM_COUNT(3)
+	KAPI_SINCE_VERSION("4.14")
+KAPI_END_SPEC;
+
+DEFINE_KAPI_IOCTL_SPEC(binder_get_node_debug_info)
+	KAPI_IOCTL_CMD(BINDER_GET_NODE_DEBUG_INFO)
+	KAPI_IOCTL_CMD_NAME("BINDER_GET_NODE_DEBUG_INFO")
+	KAPI_IOCTL_INPUT_SIZE(sizeof(struct binder_node_debug_info))
+	KAPI_IOCTL_OUTPUT_SIZE(sizeof(struct binder_node_debug_info))
+	KAPI_IOCTL_FILE_OPS_NAME("binder_fops")
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
+		KAPI_PARAM_CONSTRAINT_TYPE(KAPI_CONSTRAINT_RANGE)
+		.min_value = 0,
+		.max_value = 1,
+	KAPI_PARAM_END
+
+	KAPI_PARAM(3, "has_weak_ref", "__u32", "Has weak references")
+		KAPI_PARAM_FLAGS(KAPI_PARAM_OUT)
+		.type = KAPI_TYPE_UINT,
+		KAPI_PARAM_CONSTRAINT_TYPE(KAPI_CONSTRAINT_RANGE)
+		.min_value = 0,
+		.max_value = 1,
+	KAPI_PARAM_END
+
+	/* Return value */
+	KAPI_RETURN("int", "0 on success, negative errno on failure")
+		KAPI_RETURN_TYPE(KAPI_TYPE_INT)
+		KAPI_RETURN_CHECK_TYPE(KAPI_RETURN_ERROR_CHECK)
+		KAPI_RETURN_ERROR_VALUES(((const s64[]){-EFAULT, -EINVAL}))
+		KAPI_RETURN_ERROR_COUNT(2)
+	KAPI_RETURN_END
+
+	/* Errors */
+	KAPI_ERROR(0, -EFAULT, "EFAULT", "Failed to copy data",
+		   "Invalid user pointer provided")
+	KAPI_ERROR(1, -EINVAL, "EINVAL", "Invalid node pointer",
+		   "Provided ptr is not a valid node")
+
+	KAPI_ERROR_COUNT(2)
+	KAPI_PARAM_COUNT(4)
+	KAPI_SINCE_VERSION("4.14")
+KAPI_END_SPEC;
+
+DEFINE_KAPI_IOCTL_SPEC(binder_freeze)
+	KAPI_IOCTL_CMD(BINDER_FREEZE)
+	KAPI_IOCTL_CMD_NAME("BINDER_FREEZE")
+	KAPI_IOCTL_INPUT_SIZE(sizeof(struct binder_freeze_info))
+	KAPI_IOCTL_OUTPUT_SIZE(0)
+	KAPI_IOCTL_FILE_OPS_NAME("binder_fops")
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
+		KAPI_PARAM_CONSTRAINT_TYPE(KAPI_CONSTRAINT_RANGE)
+		.min_value = 1,
+		.max_value = PID_MAX_LIMIT,
+	KAPI_PARAM_END
+
+	KAPI_PARAM(1, "enable", "__u32", "1 to freeze, 0 to unfreeze")
+		KAPI_PARAM_FLAGS(KAPI_PARAM_IN)
+		.type = KAPI_TYPE_UINT,
+		KAPI_PARAM_CONSTRAINT_TYPE(KAPI_CONSTRAINT_RANGE)
+		.min_value = 0,
+		.max_value = 1,
+	KAPI_PARAM_END
+
+	KAPI_PARAM(2, "timeout_ms", "__u32", "Timeout in milliseconds (0 = no wait)")
+		KAPI_PARAM_FLAGS(KAPI_PARAM_IN)
+		.type = KAPI_TYPE_UINT,
+		KAPI_PARAM_CONSTRAINT_TYPE(KAPI_CONSTRAINT_RANGE)
+		.min_value = 0,
+		.max_value = 60000,	/* 1 minute max */
+	KAPI_PARAM_END
+
+	/* Return value */
+	KAPI_RETURN("int", "0 on success, negative errno on failure")
+		KAPI_RETURN_TYPE(KAPI_TYPE_INT)
+		KAPI_RETURN_CHECK_TYPE(KAPI_RETURN_ERROR_CHECK)
+		KAPI_RETURN_ERROR_VALUES(((const s64[]){-EINVAL, -EAGAIN, -EFAULT, -ENOMEM}))
+		KAPI_RETURN_ERROR_COUNT(4)
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
+	KAPI_ERROR_COUNT(4)
+	KAPI_PARAM_COUNT(3)
+	KAPI_SINCE_VERSION("5.9")
+	KAPI_NOTES("Requires appropriate permissions to freeze other processes")
+KAPI_END_SPEC;
+
+DEFINE_KAPI_IOCTL_SPEC(binder_get_frozen_info)
+	KAPI_IOCTL_CMD(BINDER_GET_FROZEN_INFO)
+	KAPI_IOCTL_CMD_NAME("BINDER_GET_FROZEN_INFO")
+	KAPI_IOCTL_INPUT_SIZE(sizeof(struct binder_frozen_status_info))
+	KAPI_IOCTL_OUTPUT_SIZE(sizeof(struct binder_frozen_status_info))
+	KAPI_IOCTL_FILE_OPS_NAME("binder_fops")
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
+		KAPI_PARAM_CONSTRAINT_TYPE(KAPI_CONSTRAINT_RANGE)
+		.min_value = 1,
+		.max_value = PID_MAX_LIMIT,
+	KAPI_PARAM_END
+
+	KAPI_PARAM(1, "sync_recv", "__u32", "Sync transactions received while frozen")
+		KAPI_PARAM_FLAGS(KAPI_PARAM_OUT)
+		.type = KAPI_TYPE_UINT,
+		KAPI_PARAM_CONSTRAINT("Bit 0: received after frozen, Bit 1: pending during freeze")
+	KAPI_PARAM_END
+
+	KAPI_PARAM(2, "async_recv", "__u32", "Async transactions received while frozen")
+		KAPI_PARAM_FLAGS(KAPI_PARAM_OUT)
+		.type = KAPI_TYPE_UINT,
+	KAPI_PARAM_END
+
+	/* Return value */
+	KAPI_RETURN("int", "0 on success, negative errno on failure")
+		KAPI_RETURN_TYPE(KAPI_TYPE_INT)
+		KAPI_RETURN_CHECK_TYPE(KAPI_RETURN_ERROR_CHECK)
+		KAPI_RETURN_ERROR_VALUES(((const s64[]){-EINVAL, -EFAULT}))
+		KAPI_RETURN_ERROR_COUNT(2)
+	KAPI_RETURN_END
+
+	/* Errors */
+	KAPI_ERROR(0, -EINVAL, "EINVAL", "Process not found",
+		   "No binder process found with given PID")
+	KAPI_ERROR(1, -EFAULT, "EFAULT", "Failed to copy data",
+		   "Invalid user pointer provided")
+
+	KAPI_ERROR_COUNT(2)
+	KAPI_PARAM_COUNT(3)
+	KAPI_SINCE_VERSION("5.9")
+KAPI_END_SPEC;
+
+DEFINE_KAPI_IOCTL_SPEC(binder_enable_oneway_spam_detection)
+	KAPI_IOCTL_CMD(BINDER_ENABLE_ONEWAY_SPAM_DETECTION)
+	KAPI_IOCTL_CMD_NAME("BINDER_ENABLE_ONEWAY_SPAM_DETECTION")
+	KAPI_IOCTL_INPUT_SIZE(sizeof(__u32))
+	KAPI_IOCTL_OUTPUT_SIZE(0)
+	KAPI_IOCTL_FILE_OPS_NAME("binder_fops")
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
+		KAPI_PARAM_CONSTRAINT_TYPE(KAPI_CONSTRAINT_RANGE)
+		.min_value = 0,
+		.max_value = 1,
+	KAPI_PARAM_END
+
+	/* Return value */
+	KAPI_RETURN("int", "0 on success, negative errno on failure")
+		KAPI_RETURN_TYPE(KAPI_TYPE_INT)
+		KAPI_RETURN_CHECK_TYPE(KAPI_RETURN_ERROR_CHECK)
+		KAPI_RETURN_ERROR_VALUES(((const s64[]){-EFAULT}))
+		KAPI_RETURN_ERROR_COUNT(1)
+	KAPI_RETURN_END
+
+	/* Errors */
+	KAPI_ERROR(0, -EFAULT, "EFAULT", "Failed to copy from user",
+		   "Invalid user pointer provided")
+
+	KAPI_ERROR_COUNT(1)
+	KAPI_PARAM_COUNT(1)
+	KAPI_SINCE_VERSION("5.13")
+KAPI_END_SPEC;
+
+DEFINE_KAPI_IOCTL_SPEC(binder_get_extended_error)
+	KAPI_IOCTL_CMD(BINDER_GET_EXTENDED_ERROR)
+	KAPI_IOCTL_CMD_NAME("BINDER_GET_EXTENDED_ERROR")
+	KAPI_IOCTL_INPUT_SIZE(0)
+	KAPI_IOCTL_OUTPUT_SIZE(sizeof(struct binder_extended_error))
+	KAPI_IOCTL_FILE_OPS_NAME("binder_fops")
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
+		KAPI_PARAM_TYPE(KAPI_TYPE_INT)
+		KAPI_PARAM_CONSTRAINT_TYPE(KAPI_CONSTRAINT_RANGE)
+		.min_value = -MAX_ERRNO,
+		.max_value = 0,
+	KAPI_PARAM_END
+
+	/* Return value */
+	KAPI_RETURN("int", "0 on success, negative errno on failure")
+		KAPI_RETURN_TYPE(KAPI_TYPE_INT)
+		KAPI_RETURN_CHECK_TYPE(KAPI_RETURN_ERROR_CHECK)
+		KAPI_RETURN_ERROR_VALUES(((const s64[]){-EFAULT}))
+		KAPI_RETURN_ERROR_COUNT(1)
+	KAPI_RETURN_END
+
+	/* Errors */
+	KAPI_ERROR(0, -EFAULT, "EFAULT", "Failed to copy to user",
+		   "Invalid user pointer provided")
+
+	KAPI_ERROR_COUNT(1)
+	KAPI_PARAM_COUNT(3)
+	KAPI_SINCE_VERSION("5.16")
+	KAPI_NOTES("Error is cleared after reading, subsequent calls return BR_OK")
+KAPI_END_SPEC;
+
+static int kapi_ioctl_specs_init(void)
+{
+	return 0;
+}
+
+static void kapi_ioctl_specs_exit(void)
+{
+}
+
 DEFINE_SHOW_ATTRIBUTE(state);
 DEFINE_SHOW_ATTRIBUTE(state_hashed);
 DEFINE_SHOW_ATTRIBUTE(stats);
@@ -7050,6 +7741,13 @@ static int __init binder_init(void)
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
 
@@ -7102,6 +7800,9 @@ static int __init binder_init(void)
 
 err_alloc_device_names_failed:
 	debugfs_remove_recursive(binder_debugfs_dir_entry_root);
+	kapi_ioctl_specs_exit();
+
+err_kapi_init:
 	binder_alloc_shrinker_exit();
 
 	return ret;
diff --git a/include/linux/kernel_api_spec.h b/include/linux/kernel_api_spec.h
index 4be9636b19158..ee7371909d0e4 100644
--- a/include/linux/kernel_api_spec.h
+++ b/include/linux/kernel_api_spec.h
@@ -863,6 +863,9 @@ struct kernel_api_spec {
 		.enum_values = values, \
 		.enum_count = ARRAY_SIZE(values),
 
+#define KAPI_PARAM_SIZE_PARAM_IDX(idx) \
+		.size_param_idx = idx,
+
 #define KAPI_PARAM_END },
 
 /**
-- 
2.39.5



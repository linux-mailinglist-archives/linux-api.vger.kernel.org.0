Return-Path: <linux-api+bounces-6317-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IBeJA8hIA2qS2wEAu9opvQ
	(envelope-from <linux-api+bounces-6317-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Tue, 12 May 2026 17:35:36 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B357523C02
	for <lists+linux-api@lfdr.de>; Tue, 12 May 2026 17:35:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D64E4307EBDC
	for <lists+linux-api@lfdr.de>; Tue, 12 May 2026 15:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2E8F3BFAD7;
	Tue, 12 May 2026 15:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="IJXWkDy0"
X-Original-To: linux-api@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97BDB3C1F51
	for <linux-api@vger.kernel.org>; Tue, 12 May 2026 15:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778600034; cv=none; b=SvWsQvf4grxGimvuA9lYC85efnWjhSg5IW30DaM/ZdR7rR+pEoWjn1WRoqkcw1i7StHcFykQjoq1bwjJWWebbNKA5bKR8LEafR92PdeGfW/2sZOz32z6MQPe55NDdjZ+O4kbs7qfMS9JKG8bjSZR1xn/ZdSh8oekDX0Y5a0pwv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778600034; c=relaxed/simple;
	bh=GVcBoZUd3sk/en9vuMR4iOS9cIXyX/dPEqtB//tUV2M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H0i0933jSt9NE1AaQCeti6NeIXZH7tSVmLqoKMUssltbU9ZrXGHpC4nogwKBaRQQOQAgW9tb1sRqSlmid7BzyHsUJeSFMQzlnLAZpGMoRCrj7U+A52Oh+raT2IFiLWrtvE21ZZTZ1ktG06MHatu9MAvphaS65v0Jl5avxoE+Pk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=IJXWkDy0; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778600027;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/kOtXXNhPulMzZtQO/HDiSbQZJwg/kC9ES4tyUDwNuI=;
	b=IJXWkDy0jXjSDNGUtX6rVkKd67o6Btg9Fsm5XTVrn4k4ktmD8SLtce12NFMmOdA87xukIs
	0k04XohYWpe8ZBHrSlKgLCoZLAkJYstEoa1SNdyWvRGDNvGkVSqi1bfXAMiqWdplGJI5Lk
	MEoIL4cGreq0LCZ1hnxni2NF2pr+oy4=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Seth Forshee <sforshee@kernel.org>,
	Yuichiro Tsuji <yuichtsu@amazon.com>,
	Andrey Albershteyn <aalbersh@redhat.com>,
	Leon Hwang <leon.hwang@linux.dev>,
	Willem de Bruijn <willemb@google.com>,
	Jason Xing <kerneljasonxing@gmail.com>,
	Tao Chen <chen.dylane@linux.dev>,
	Mykyta Yatsenko <yatsenko@meta.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Anton Protopopov <a.s.protopopov@gmail.com>,
	Amery Hung <ameryhung@gmail.com>,
	Rong Tao <rongtao@cestc.cn>,
	linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kernel-patches-bot@fb.com
Subject: [PATCH bpf-next v14 1/8] bpf: Extend BPF syscall with common attributes support
Date: Tue, 12 May 2026 23:31:50 +0800
Message-ID: <20260512153157.28382-2-leon.hwang@linux.dev>
In-Reply-To: <20260512153157.28382-1-leon.hwang@linux.dev>
References: <20260512153157.28382-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: 7B357523C02
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,gmail.com,linux.dev,fomichev.me,google.com,amazon.com,redhat.com,meta.com,cestc.cn,vger.kernel.org,fb.com];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_TWELVE(0.00)[31];
	TAGGED_FROM(0.00)[bounces-6317-lists,linux-api=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon.hwang@linux.dev,linux-api@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-0.997];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-api];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,linux.dev:mid,linux.dev:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Add generic BPF syscall support for passing common attributes.

The initial set of common attributes includes:

1. 'log_buf': User-provided buffer for storing logs.
2. 'log_size': Size of the log buffer.
3. 'log_level': Log verbosity level.
4. 'log_true_size': Actual log size reported by kernel.

The common-attribute pointer and its size are passed as the 4th and 5th
syscall arguments. A new command bit, 'BPF_COMMON_ATTRS' ('1 << 16'),
indicates that common attributes are supplied.

This commit adds syscall and uapi plumbing. Command-specific handling is
added in follow-up patches.

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 include/linux/syscalls.h       |  3 ++-
 include/uapi/linux/bpf.h       |  8 ++++++++
 kernel/bpf/syscall.c           | 25 +++++++++++++++++++++----
 tools/include/uapi/linux/bpf.h |  8 ++++++++
 4 files changed, 39 insertions(+), 5 deletions(-)

diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index f5639d5ac331..50055ab73649 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -936,7 +936,8 @@ asmlinkage long sys_seccomp(unsigned int op, unsigned int flags,
 asmlinkage long sys_getrandom(char __user *buf, size_t count,
 			      unsigned int flags);
 asmlinkage long sys_memfd_create(const char __user *uname_ptr, unsigned int flags);
-asmlinkage long sys_bpf(int cmd, union bpf_attr __user *attr, unsigned int size);
+asmlinkage long sys_bpf(int cmd, union bpf_attr __user *attr, unsigned int size,
+			struct bpf_common_attr __user *attr_common, unsigned int size_common);
 asmlinkage long sys_execveat(int dfd, const char __user *filename,
 			const char __user *const __user *argv,
 			const char __user *const __user *envp, int flags);
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 552bc5d9afbd..aec171ccb6ef 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -994,6 +994,7 @@ enum bpf_cmd {
 	BPF_PROG_STREAM_READ_BY_FD,
 	BPF_PROG_ASSOC_STRUCT_OPS,
 	__MAX_BPF_CMD,
+	BPF_COMMON_ATTRS = 1 << 16, /* Indicate carrying syscall common attrs. */
 };
 
 enum bpf_map_type {
@@ -1500,6 +1501,13 @@ struct bpf_stack_build_id {
 	};
 };
 
+struct bpf_common_attr {
+	__aligned_u64 log_buf;
+	__u32 log_size;
+	__u32 log_level;
+	__u32 log_true_size;
+};
+
 #define BPF_OBJ_NAME_LEN 16U
 
 enum {
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 3b1f0ba02f61..354f6f471a08 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -6211,8 +6211,10 @@ static int prog_assoc_struct_ops(union bpf_attr *attr)
 	return ret;
 }
 
-static int __sys_bpf(enum bpf_cmd cmd, bpfptr_t uattr, unsigned int size)
+static int __sys_bpf(enum bpf_cmd cmd, bpfptr_t uattr, unsigned int size,
+		     bpfptr_t uattr_common, unsigned int size_common)
 {
+	struct bpf_common_attr attr_common;
 	union bpf_attr attr;
 	int err;
 
@@ -6226,6 +6228,20 @@ static int __sys_bpf(enum bpf_cmd cmd, bpfptr_t uattr, unsigned int size)
 	if (copy_from_bpfptr(&attr, uattr, size) != 0)
 		return -EFAULT;
 
+	memset(&attr_common, 0, sizeof(attr_common));
+	if (cmd & BPF_COMMON_ATTRS) {
+		err = bpf_check_uarg_tail_zero(uattr_common, sizeof(attr_common), size_common);
+		if (err)
+			return err;
+
+		cmd &= ~BPF_COMMON_ATTRS;
+		size_common = min_t(u32, size_common, sizeof(attr_common));
+		if (copy_from_bpfptr(&attr_common, uattr_common, size_common) != 0)
+			return -EFAULT;
+	} else {
+		size_common = 0;
+	}
+
 	err = security_bpf(cmd, &attr, size, uattr.is_kernel);
 	if (err < 0)
 		return err;
@@ -6361,9 +6377,10 @@ static int __sys_bpf(enum bpf_cmd cmd, bpfptr_t uattr, unsigned int size)
 	return err;
 }
 
-SYSCALL_DEFINE3(bpf, int, cmd, union bpf_attr __user *, uattr, unsigned int, size)
+SYSCALL_DEFINE5(bpf, int, cmd, union bpf_attr __user *, uattr, unsigned int, size,
+		struct bpf_common_attr __user *, uattr_common, unsigned int, size_common)
 {
-	return __sys_bpf(cmd, USER_BPFPTR(uattr), size);
+	return __sys_bpf(cmd, USER_BPFPTR(uattr), size, USER_BPFPTR(uattr_common), size_common);
 }
 
 static bool syscall_prog_is_valid_access(int off, int size,
@@ -6393,7 +6410,7 @@ BPF_CALL_3(bpf_sys_bpf, int, cmd, union bpf_attr *, attr, u32, attr_size)
 	default:
 		return -EINVAL;
 	}
-	return __sys_bpf(cmd, KERNEL_BPFPTR(attr), attr_size);
+	return __sys_bpf(cmd, KERNEL_BPFPTR(attr), attr_size, KERNEL_BPFPTR(NULL), 0);
 }
 
 
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 677be9a47347..37142e6d911a 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -994,6 +994,7 @@ enum bpf_cmd {
 	BPF_PROG_STREAM_READ_BY_FD,
 	BPF_PROG_ASSOC_STRUCT_OPS,
 	__MAX_BPF_CMD,
+	BPF_COMMON_ATTRS = 1 << 16, /* Indicate carrying syscall common attrs. */
 };
 
 enum bpf_map_type {
@@ -1500,6 +1501,13 @@ struct bpf_stack_build_id {
 	};
 };
 
+struct bpf_common_attr {
+	__aligned_u64 log_buf;
+	__u32 log_size;
+	__u32 log_level;
+	__u32 log_true_size;
+};
+
 #define BPF_OBJ_NAME_LEN 16U
 
 enum {
-- 
2.54.0



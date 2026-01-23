Return-Path: <linux-api+bounces-5728-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8AIUOoTqcmnQrAAAu9opvQ
	(envelope-from <linux-api+bounces-5728-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Fri, 23 Jan 2026 04:27:00 +0100
X-Original-To: lists+linux-api@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 67BEE70119
	for <lists+linux-api@lfdr.de>; Fri, 23 Jan 2026 04:27:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 49F233015A59
	for <lists+linux-api@lfdr.de>; Fri, 23 Jan 2026 03:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFC18346AFC;
	Fri, 23 Jan 2026 03:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VapBBXIa"
X-Original-To: linux-api@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33FFE2D5925
	for <linux-api@vger.kernel.org>; Fri, 23 Jan 2026 03:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769138781; cv=none; b=LhmaXdyvSNRVfCXJU9q7/Tvaf+CizlalzEFaqXgMLxUvyCzZk3sjaUkgqP6+ktszL1nuEnxfqEN5VeO3cQESkYtlQYxdvqjOUpQU8syyh62l/icDae2i4Wp3cdq++l2i67nHt1iq9EEkDFMVUC5NfEl+pFI86A+HjxKcBvATZ48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769138781; c=relaxed/simple;
	bh=D8VzSPttr4Hr5rWQCBVo/JsjJYyU/BRovQ+du6UErK0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ljlqmJTOv2c1dna/0WFNVkmrFVrz6FcM+Uk7Y6ARn+a8lkrBwGA+DFFNycQiXxURz+QA90zNs+xTkJjoBODbCbXf7sUvg6tvF7TCW/pnvpWfyR0yc5smoVHnFSP9mD/fCKY/eS0I46W147rxGhv8Kw2UPnrr7tiexgnjQu9fEi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VapBBXIa; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1769138771;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yJFWnLixWM26F/goIhXEZzpWInfDRjLykyliX7jQH+k=;
	b=VapBBXIa8HjXzbgLG2yt5RXYtg02hVQ7cBnleqVboMAb6MEHidZ9rgm1CnJFD7GDxHhm5R
	lHw2K3KlwWCXcIfgC+pyYSb/eNDAfSuf3fBWXYY2FVFAlZI5OErjweewH1qJQJYQxhpGr9
	kOrwrhGxX/MSINy0G5dLQVNEP2IJQz4=
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
Subject: [PATCH bpf-next v7 3/9] bpf: Refactor reporting log_true_size for prog_load
Date: Fri, 23 Jan 2026 11:24:39 +0800
Message-ID: <20260123032445.125259-4-leon.hwang@linux.dev>
In-Reply-To: <20260123032445.125259-1-leon.hwang@linux.dev>
References: <20260123032445.125259-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,gmail.com,linux.dev,fomichev.me,google.com,amazon.com,redhat.com,meta.com,cestc.cn,vger.kernel.org,fb.com];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_TWELVE(0.00)[31];
	TAGGED_FROM(0.00)[bounces-5728-lists,linux-api=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon.hwang@linux.dev,linux-api@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-0.957];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-api];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.dev:email,linux.dev:dkim,linux.dev:mid]
X-Rspamd-Queue-Id: 67BEE70119
X-Rspamd-Action: no action

The next commit will add support for reporting logs via extended common
attributes, including 'log_true_size'.

To prepare for that, refactor the 'log_true_size' reporting logic by
introducing a new struct bpf_log_attr to encapsulate log-related behavior:

 * bpf_prog_load_log_attr_init(): initialize the log fields, which will
   support extended common attributes in the next commit.
 * bpf_log_attr_finalize(): handle log finalization and write back
   'log_true_size' to userspace.

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 include/linux/bpf.h          | 19 ++++++++++++++++-
 include/linux/bpf_verifier.h | 11 ++++++++++
 kernel/bpf/log.c             | 40 ++++++++++++++++++++++++++++++++++++
 kernel/bpf/syscall.c         |  9 +++++++-
 kernel/bpf/verifier.c        | 19 ++++++-----------
 5 files changed, 83 insertions(+), 15 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 5936f8e2996f..3a525a7e8747 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2867,8 +2867,25 @@ int bpf_get_file_flag(int flags);
 int bpf_check_uarg_tail_zero(bpfptr_t uaddr, size_t expected_size,
 			     size_t actual_size);
 
+struct bpf_attrs {
+	const void *attr;
+	bpfptr_t uattr;
+	u32 size;
+};
+
+static inline void bpf_attrs_init(struct bpf_attrs *attrs, const void *attr, bpfptr_t uattr,
+				  u32 size)
+{
+	memset(attrs, 0, sizeof(*attrs));
+	attrs->attr = attr;
+	attrs->uattr = uattr;
+	attrs->size = size;
+}
+
 /* verify correctness of eBPF program */
-int bpf_check(struct bpf_prog **fp, union bpf_attr *attr, bpfptr_t uattr, u32 uattr_size);
+struct bpf_log_attr;
+int bpf_check(struct bpf_prog **fp, union bpf_attr *attr, bpfptr_t uattr,
+	      struct bpf_log_attr *log_attr);
 
 #ifndef CONFIG_BPF_JIT_ALWAYS_ON
 void bpf_patch_call_args(struct bpf_insn *insn, u32 stack_depth);
diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 8355b585cd18..4a0c5ef296b9 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -631,6 +631,17 @@ static inline bool bpf_verifier_log_needed(const struct bpf_verifier_log *log)
 	return log && log->level;
 }
 
+struct bpf_log_attr {
+	u64 log_buf;
+	u32 log_size;
+	u32 log_level;
+	struct bpf_attrs *attrs;
+	u32 offsetof_log_true_size;
+};
+
+int bpf_prog_load_log_attr_init(struct bpf_log_attr *log_attr, struct bpf_attrs *attrs);
+int bpf_log_attr_finalize(struct bpf_log_attr *log_attr, struct bpf_verifier_log *log);
+
 #define BPF_MAX_SUBPROGS 256
 
 struct bpf_subprog_arg_info {
diff --git a/kernel/bpf/log.c b/kernel/bpf/log.c
index a0c3b35de2ce..457b724c4176 100644
--- a/kernel/bpf/log.c
+++ b/kernel/bpf/log.c
@@ -863,3 +863,43 @@ void print_insn_state(struct bpf_verifier_env *env, const struct bpf_verifier_st
 	}
 	print_verifier_state(env, vstate, frameno, false);
 }
+
+static int bpf_log_attr_init(struct bpf_log_attr *log_attr, struct bpf_attrs *attrs, u64 log_buf,
+			     u32 log_size, u32 log_level, int offsetof_log_true_size)
+{
+	memset(log_attr, 0, sizeof(*log_attr));
+	log_attr->log_buf = log_buf;
+	log_attr->log_size = log_size;
+	log_attr->log_level = log_level;
+	log_attr->attrs = attrs;
+	log_attr->offsetof_log_true_size = offsetof_log_true_size;
+	return 0;
+}
+
+int bpf_prog_load_log_attr_init(struct bpf_log_attr *log_attr, struct bpf_attrs *attrs)
+{
+	const union bpf_attr *attr = attrs->attr;
+
+	return bpf_log_attr_init(log_attr, attrs, attr->log_buf, attr->log_size, attr->log_level,
+				 offsetof(union bpf_attr, log_true_size));
+}
+
+int bpf_log_attr_finalize(struct bpf_log_attr *log_attr, struct bpf_verifier_log *log)
+{
+	u32 log_true_size, off;
+	size_t size;
+	int err;
+
+	if (!log)
+		return 0;
+
+	err = bpf_vlog_finalize(log, &log_true_size);
+
+	size = sizeof(log_true_size);
+	off = log_attr->offsetof_log_true_size;
+	if (log_attr->attrs && log_attr->attrs->size >= off + size &&
+	    copy_to_bpfptr_offset(log_attr->attrs->uattr, off, &log_true_size, size))
+		err = -EFAULT;
+
+	return err;
+}
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 3564b5bf3689..8468baf545c5 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -2871,6 +2871,8 @@ static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr, u32 uattr_size)
 	struct bpf_prog *prog, *dst_prog = NULL;
 	struct btf *attach_btf = NULL;
 	struct bpf_token *token = NULL;
+	struct bpf_log_attr log_attr;
+	struct bpf_attrs attrs;
 	bool bpf_cap;
 	int err;
 	char license[128];
@@ -3082,8 +3084,13 @@ static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr, u32 uattr_size)
 	if (err)
 		goto free_prog_sec;
 
+	bpf_attrs_init(&attrs, attr, uattr, uattr_size);
+	err = bpf_prog_load_log_attr_init(&log_attr, &attrs);
+	if (err < 0)
+		goto free_used_maps;
+
 	/* run eBPF verifier */
-	err = bpf_check(&prog, attr, uattr, uattr_size);
+	err = bpf_check(&prog, attr, uattr, &log_attr);
 	if (err < 0)
 		goto free_used_maps;
 
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index c7f5234d5fd2..03d56d3d3f89 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -25593,12 +25593,12 @@ static int compute_scc(struct bpf_verifier_env *env)
 	return err;
 }
 
-int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u32 uattr_size)
+int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
+	      struct bpf_log_attr *log_attr)
 {
 	u64 start_time = ktime_get_ns();
 	struct bpf_verifier_env *env;
 	int i, len, ret = -EINVAL, err;
-	u32 log_true_size;
 	bool is_priv;
 
 	BTF_TYPE_EMIT(enum bpf_features);
@@ -25645,9 +25645,9 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u3
 	/* user could have requested verbose verifier output
 	 * and supplied buffer to store the verification trace
 	 */
-	ret = bpf_vlog_init(&env->log, attr->log_level,
-			    (char __user *) (unsigned long) attr->log_buf,
-			    attr->log_size);
+	ret = bpf_vlog_init(&env->log, log_attr->log_level,
+			    u64_to_user_ptr(log_attr->log_buf),
+			    log_attr->log_size);
 	if (ret)
 		goto err_unlock;
 
@@ -25797,17 +25797,10 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u3
 	env->prog->aux->verified_insns = env->insn_processed;
 
 	/* preserve original error even if log finalization is successful */
-	err = bpf_vlog_finalize(&env->log, &log_true_size);
+	err = bpf_log_attr_finalize(log_attr, &env->log);
 	if (err)
 		ret = err;
 
-	if (uattr_size >= offsetofend(union bpf_attr, log_true_size) &&
-	    copy_to_bpfptr_offset(uattr, offsetof(union bpf_attr, log_true_size),
-				  &log_true_size, sizeof(log_true_size))) {
-		ret = -EFAULT;
-		goto err_release_maps;
-	}
-
 	if (ret)
 		goto err_release_maps;
 
-- 
2.52.0



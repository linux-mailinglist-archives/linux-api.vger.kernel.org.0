Return-Path: <linux-api+bounces-6302-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6ExcAGH2AWoFmwEAu9opvQ
	(envelope-from <linux-api+bounces-6302-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Mon, 11 May 2026 17:31:45 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id BB42451134E
	for <lists+linux-api@lfdr.de>; Mon, 11 May 2026 17:31:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4DDEA3020C2A
	for <lists+linux-api@lfdr.de>; Mon, 11 May 2026 15:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EF163C1410;
	Mon, 11 May 2026 15:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TRV4IRH3"
X-Original-To: linux-api@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5EF23B38B7;
	Mon, 11 May 2026 15:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778513376; cv=none; b=t1jJKqlyhNJOpBnoYPGj2BKf7TPuAfgM+l5aFi4WXyremT0gMfR7tXHJSNDeHY+haGuK0l8lXnyUZ+t1YewiPBeEIHKEnSR5qaPrEJcAN1AyW00sDEIdXprTXoN39OSNIKmrCrTcXe81hYYBtByOhvI20dwP/NZ3ai1CJmXkvac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778513376; c=relaxed/simple;
	bh=5RYQRAf8xsLZ41CEgZ6EZL3AMYyJ/NKwBmjP5CBBBKc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t5xWkeMqiGyZomLslv0mQM5FduVRhcsqy6J1fcOkEFoCZWMW8b2Uwg07wSJCy8bhwSM1vbd+bv69qF2fk9SAM4ID87ayVcuaTLlonrWSbNU1NtV/wxK6FNkIzl+NbDkxTDe4Q77qZkKJinIpH0hh3mna8m80z/9gQFfRrnv2Du4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TRV4IRH3; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778513371;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7/f8B2tSB4jeX6KBQPynG6mkvUoBSg7sAMa1i1bpH00=;
	b=TRV4IRH3n+Ozi5ZBKvKERhEyNLz74IJ9G/Jcgx0kvxz7iw9JjVcZ/gGVfQgLLQQgHDCQYx
	/oAJqp0bMhadtVjeuJCgOnhKFlaFl0q2IvJ+ov1kJnRHQENrEQ9vPgwOcxn+1p7PtZYghQ
	hxOLrpqi5ClwShv/xxZTC5fDTxBqcBU=
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
Subject: [PATCH bpf-next v13 3/8] bpf: Refactor reporting log_true_size for prog_load
Date: Mon, 11 May 2026 23:28:12 +0800
Message-ID: <20260511152817.89191-4-leon.hwang@linux.dev>
In-Reply-To: <20260511152817.89191-1-leon.hwang@linux.dev>
References: <20260511152817.89191-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: BB42451134E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,gmail.com,linux.dev,fomichev.me,google.com,amazon.com,redhat.com,meta.com,cestc.cn,vger.kernel.org,fb.com];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_TWELVE(0.00)[31];
	TAGGED_FROM(0.00)[bounces-6302-lists,linux-api=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon.hwang@linux.dev,linux-api@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-0.994];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-api];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

The next commit will add support for reporting logs via extended common
attributes, including 'log_true_size'.

To prepare for that, refactor the 'log_true_size' reporting logic by
introducing a new struct bpf_log_attr to encapsulate log-related behavior:

 * bpf_log_attr_init(): initialize log fields, which will support
   extended common attributes in the next commit.
 * bpf_log_attr_finalize(): handle log finalization and write back
   'log_true_size' to userspace.

Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 include/linux/bpf.h          |  4 +++-
 include/linux/bpf_verifier.h | 12 ++++++++++++
 kernel/bpf/log.c             | 29 +++++++++++++++++++++++++++++
 kernel/bpf/syscall.c         | 12 +++++++++---
 kernel/bpf/verifier.c        | 17 ++++-------------
 5 files changed, 57 insertions(+), 17 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 715b6df9c403..b3a0cca92e54 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2919,7 +2919,9 @@ int bpf_check_uarg_tail_zero(bpfptr_t uaddr, size_t expected_size,
 			     size_t actual_size);
 
 /* verify correctness of eBPF program */
-int bpf_check(struct bpf_prog **fp, union bpf_attr *attr, bpfptr_t uattr, u32 uattr_size);
+struct bpf_log_attr;
+int bpf_check(struct bpf_prog **fp, union bpf_attr *attr, bpfptr_t uattr,
+	      struct bpf_log_attr *attr_log);
 
 #ifndef CONFIG_BPF_JIT_ALWAYS_ON
 void bpf_patch_call_args(struct bpf_insn *insn, u32 stack_depth);
diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 976e2b2f40e8..8d27ad1f9f94 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -755,6 +755,18 @@ static inline bool bpf_verifier_log_needed(const struct bpf_verifier_log *log)
 	return log && log->level;
 }
 
+struct bpf_log_attr {
+	char __user *ubuf;
+	u32 size;
+	u32 level;
+	u32 offsetof_true_size;
+	bpfptr_t uattr;
+};
+
+int bpf_log_attr_init(struct bpf_log_attr *log, u64 log_buf, u32 log_size, u32 log_level,
+		      u32 offsetof_log_true_size, bpfptr_t uattr);
+int bpf_log_attr_finalize(struct bpf_log_attr *attr, struct bpf_verifier_log *log);
+
 #define BPF_MAX_SUBPROGS 256
 
 struct bpf_subprog_arg_info {
diff --git a/kernel/bpf/log.c b/kernel/bpf/log.c
index 64566b86dd27..1b1efe75398b 100644
--- a/kernel/bpf/log.c
+++ b/kernel/bpf/log.c
@@ -825,3 +825,32 @@ void print_insn_state(struct bpf_verifier_env *env, const struct bpf_verifier_st
 	}
 	print_verifier_state(env, vstate, frameno, false);
 }
+
+int bpf_log_attr_init(struct bpf_log_attr *log, u64 log_buf, u32 log_size, u32 log_level,
+		      u32 offsetof_log_true_size, bpfptr_t uattr)
+{
+	char __user *ubuf = u64_to_user_ptr(log_buf);
+
+	memset(log, 0, sizeof(*log));
+	log->ubuf = ubuf;
+	log->size = log_size;
+	log->level = log_level;
+	log->offsetof_true_size = offsetof_log_true_size;
+	log->uattr = uattr;
+	return 0;
+}
+
+int bpf_log_attr_finalize(struct bpf_log_attr *attr, struct bpf_verifier_log *log)
+{
+	u32 log_true_size;
+	int err;
+
+	err = bpf_vlog_finalize(log, &log_true_size);
+
+	if (attr->offsetof_true_size &&
+	    copy_to_bpfptr_offset(attr->uattr, attr->offsetof_true_size, &log_true_size,
+				  sizeof(log_true_size)))
+		return -EFAULT;
+
+	return err;
+}
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 354f6f471a08..70b78ddcdedb 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -2861,7 +2861,7 @@ static int bpf_prog_mark_insn_arrays_ready(struct bpf_prog *prog)
 /* last field in 'union bpf_attr' used by this command */
 #define BPF_PROG_LOAD_LAST_FIELD keyring_id
 
-static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr, u32 uattr_size)
+static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr, struct bpf_log_attr *attr_log)
 {
 	enum bpf_prog_type type = attr->prog_type;
 	struct bpf_prog *prog, *dst_prog = NULL;
@@ -3079,7 +3079,7 @@ static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr, u32 uattr_size)
 		goto free_prog_sec;
 
 	/* run eBPF verifier */
-	err = bpf_check(&prog, attr, uattr, uattr_size);
+	err = bpf_check(&prog, attr, uattr, attr_log);
 	if (err < 0)
 		goto free_used_maps;
 
@@ -6215,6 +6215,8 @@ static int __sys_bpf(enum bpf_cmd cmd, bpfptr_t uattr, unsigned int size,
 		     bpfptr_t uattr_common, unsigned int size_common)
 {
 	struct bpf_common_attr attr_common;
+	u32 offsetof_log_true_size = 0;
+	struct bpf_log_attr attr_log;
 	union bpf_attr attr;
 	int err;
 
@@ -6266,7 +6268,11 @@ static int __sys_bpf(enum bpf_cmd cmd, bpfptr_t uattr, unsigned int size,
 		err = map_freeze(&attr);
 		break;
 	case BPF_PROG_LOAD:
-		err = bpf_prog_load(&attr, uattr, size);
+		if (size >= offsetofend(union bpf_attr, log_true_size))
+			offsetof_log_true_size = offsetof(union bpf_attr, log_true_size);
+		err = bpf_log_attr_init(&attr_log, attr.log_buf, attr.log_size, attr.log_level,
+					offsetof_log_true_size, uattr);
+		err = err ?: bpf_prog_load(&attr, uattr, &attr_log);
 		break;
 	case BPF_OBJ_PIN:
 		err = bpf_obj_pin(&attr);
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 11054ad89c14..0e654ef01ae0 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -19294,12 +19294,12 @@ int bpf_fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 	return 0;
 }
 
-int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u32 uattr_size)
+int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
+	      struct bpf_log_attr *attr_log)
 {
 	u64 start_time = ktime_get_ns();
 	struct bpf_verifier_env *env;
 	int i, len, ret = -EINVAL, err;
-	u32 log_true_size;
 	bool is_priv;
 
 	BTF_TYPE_EMIT(enum bpf_features);
@@ -19346,9 +19346,7 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u3
 	/* user could have requested verbose verifier output
 	 * and supplied buffer to store the verification trace
 	 */
-	ret = bpf_vlog_init(&env->log, attr->log_level,
-			    (char __user *) (unsigned long) attr->log_buf,
-			    attr->log_size);
+	ret = bpf_vlog_init(&env->log, attr_log->level, attr_log->ubuf, attr_log->size);
 	if (ret)
 		goto err_unlock;
 
@@ -19510,17 +19508,10 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u3
 	env->prog->aux->verified_insns = env->insn_processed;
 
 	/* preserve original error even if log finalization is successful */
-	err = bpf_vlog_finalize(&env->log, &log_true_size);
+	err = bpf_log_attr_finalize(attr_log, &env->log);
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
2.54.0



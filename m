Return-Path: <linux-api+bounces-5839-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uBYLK+U1k2mV2gEAu9opvQ
	(envelope-from <linux-api+bounces-5839-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Mon, 16 Feb 2026 16:21:09 +0100
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1451E1456D8
	for <lists+linux-api@lfdr.de>; Mon, 16 Feb 2026 16:21:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0B2E631D8687
	for <lists+linux-api@lfdr.de>; Mon, 16 Feb 2026 15:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98C4B31A568;
	Mon, 16 Feb 2026 15:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DqOKndYx"
X-Original-To: linux-api@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D95CC3191CF
	for <linux-api@vger.kernel.org>; Mon, 16 Feb 2026 15:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771254402; cv=none; b=SZMOwX3r4/CIIMntdcWgxJXlw0tromcoziAmN1IBW2v8uiSi3bKYMeBYyZk5jN5BhtjUQ0cCinhmfXkFev1gyjHo1+p0nTHYee3N2w2cqn300r755ru14NhziRK7q1vw44FV25JHEcQHH99W56paBdD9nrBHyDVvcOwZzJcshIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771254402; c=relaxed/simple;
	bh=vIb3WtV6muTrwY74mrd0aD9sE5NcgH/zI69x2P/K4OI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=USGK45OK6AZBeoBxNC1PV13UdAlhQaygMTj2dsgZCfecidVwz3lD9Gl9FBeVtBIVOqBxt/UtprSbvzTYsjjHxjLs4uxgyPtI1EaRBTsh8cz9wtyTm5pj7afwQyQN/bSqiM10MG6h0sZY4y0ZrBsL7niEGzOAE+c+WaXbAIFs3jU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DqOKndYx; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1771254397;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XUYvhzf4IP0hxOuyLi9vHfUxsMp6/UWnkq0DQeM7pl8=;
	b=DqOKndYxuuHAIuZm4J+AB1uVeyLSWtPOPLELVl5HlWciiMRZKzJ1t2IByXJPvm4UdbWt42
	SZ3qBlkfZz+AAx/q69E/IT88xtktLkkkIe/rjpxCIRhyh+h1JUZITAtGbV5Fg0OnBbGmAq
	HlyCkH7j5JOgK99Goh/CArCA/b4FsSg=
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
Subject: [PATCH bpf-next v11 3/8] bpf: Refactor reporting log_true_size for prog_load
Date: Mon, 16 Feb 2026 23:04:40 +0800
Message-ID: <20260216150445.68278-4-leon.hwang@linux.dev>
In-Reply-To: <20260216150445.68278-1-leon.hwang@linux.dev>
References: <20260216150445.68278-1-leon.hwang@linux.dev>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[31];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-5839-lists,linux-api=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,gmail.com,linux.dev,fomichev.me,google.com,amazon.com,redhat.com,meta.com,cestc.cn,vger.kernel.org,fb.com];
	DKIM_TRACE(0.00)[linux.dev:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon.hwang@linux.dev,linux-api@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-api];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:mid,linux.dev:dkim,linux.dev:email]
X-Rspamd-Queue-Id: 1451E1456D8
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
 include/linux/bpf_verifier.h | 11 +++++++++++
 kernel/bpf/log.c             | 25 +++++++++++++++++++++++++
 kernel/bpf/syscall.c         | 13 ++++++++++---
 kernel/bpf/verifier.c        | 17 ++++-------------
 5 files changed, 53 insertions(+), 17 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index cd9b96434904..d4dbcc7ad156 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2913,7 +2913,9 @@ int bpf_check_uarg_tail_zero(bpfptr_t uaddr, size_t expected_size,
 			     size_t actual_size);
 
 /* verify correctness of eBPF program */
-int bpf_check(struct bpf_prog **fp, union bpf_attr *attr, bpfptr_t uattr, u32 uattr_size);
+struct bpf_log_attr;
+int bpf_check(struct bpf_prog **fp, union bpf_attr *attr, bpfptr_t uattr,
+	      struct bpf_log_attr *attr_log);
 
 #ifndef CONFIG_BPF_JIT_ALWAYS_ON
 void bpf_patch_call_args(struct bpf_insn *insn, u32 stack_depth);
diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index c1e30096ea7b..b21cb7066f6f 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -634,6 +634,17 @@ static inline bool bpf_verifier_log_needed(const struct bpf_verifier_log *log)
 	return log && log->level;
 }
 
+struct bpf_log_attr {
+	char __user *log_buf;
+	u32 log_size;
+	u32 log_level;
+	u32 __user *log_true_size;
+};
+
+int bpf_log_attr_init(struct bpf_log_attr *log, u64 log_buf, u32 log_size, u32 log_level,
+		      u32 __user *log_true_size);
+int bpf_log_attr_finalize(struct bpf_log_attr *attr, struct bpf_verifier_log *log);
+
 #define BPF_MAX_SUBPROGS 256
 
 struct bpf_subprog_arg_info {
diff --git a/kernel/bpf/log.c b/kernel/bpf/log.c
index 37d72b052192..d4dbf2465620 100644
--- a/kernel/bpf/log.c
+++ b/kernel/bpf/log.c
@@ -865,3 +865,28 @@ void print_insn_state(struct bpf_verifier_env *env, const struct bpf_verifier_st
 	}
 	print_verifier_state(env, vstate, frameno, false);
 }
+
+int bpf_log_attr_init(struct bpf_log_attr *log, u64 log_buf, u32 log_size, u32 log_level,
+		      u32 __user *log_true_size)
+{
+	memset(log, 0, sizeof(*log));
+	log->log_buf = u64_to_user_ptr(log_buf);
+	log->log_size = log_size;
+	log->log_level = log_level;
+	log->log_true_size = log_true_size;
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
+	if (attr->log_true_size && copy_to_user(attr->log_true_size, &log_true_size,
+						sizeof(log_true_size)))
+		return -EFAULT;
+
+	return err;
+}
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index e7ab87908189..d6fa752401a9 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -2868,7 +2868,7 @@ static int bpf_prog_mark_insn_arrays_ready(struct bpf_prog *prog)
 /* last field in 'union bpf_attr' used by this command */
 #define BPF_PROG_LOAD_LAST_FIELD keyring_id
 
-static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr, u32 uattr_size)
+static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr, struct bpf_log_attr *attr_log)
 {
 	enum bpf_prog_type type = attr->prog_type;
 	struct bpf_prog *prog, *dst_prog = NULL;
@@ -3086,7 +3086,7 @@ static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr, u32 uattr_size)
 		goto free_prog_sec;
 
 	/* run eBPF verifier */
-	err = bpf_check(&prog, attr, uattr, uattr_size);
+	err = bpf_check(&prog, attr, uattr, attr_log);
 	if (err < 0)
 		goto free_used_maps;
 
@@ -6190,7 +6190,10 @@ static int prog_assoc_struct_ops(union bpf_attr *attr)
 static int __sys_bpf(enum bpf_cmd cmd, bpfptr_t uattr, unsigned int size,
 		     bpfptr_t uattr_common, unsigned int size_common)
 {
+	bool from_user = !bpfptr_is_kernel(uattr);
 	struct bpf_common_attr attr_common;
+	u32 __user *log_true_size = NULL;
+	struct bpf_log_attr attr_log;
 	union bpf_attr attr;
 	int err;
 
@@ -6242,7 +6245,11 @@ static int __sys_bpf(enum bpf_cmd cmd, bpfptr_t uattr, unsigned int size,
 		err = map_freeze(&attr);
 		break;
 	case BPF_PROG_LOAD:
-		err = bpf_prog_load(&attr, uattr, size);
+		if (from_user && size >= offsetofend(union bpf_attr, log_true_size))
+			log_true_size = uattr.user + offsetof(union bpf_attr, log_true_size);
+		err = bpf_log_attr_init(&attr_log, attr.log_buf, attr.log_size, attr.log_level,
+					log_true_size);
+		err = err ?: bpf_prog_load(&attr, uattr, &attr_log);
 		break;
 	case BPF_OBJ_PIN:
 		err = bpf_obj_pin(&attr);
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 0162f946032f..779cf863dc9a 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -25790,12 +25790,12 @@ static int compute_scc(struct bpf_verifier_env *env)
 	return err;
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
@@ -25842,9 +25842,7 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u3
 	/* user could have requested verbose verifier output
 	 * and supplied buffer to store the verification trace
 	 */
-	ret = bpf_vlog_init(&env->log, attr->log_level,
-			    (char __user *) (unsigned long) attr->log_buf,
-			    attr->log_size);
+	ret = bpf_vlog_init(&env->log, attr_log->log_level, attr_log->log_buf, attr_log->log_size);
 	if (ret)
 		goto err_unlock;
 
@@ -25994,17 +25992,10 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u3
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
2.52.0



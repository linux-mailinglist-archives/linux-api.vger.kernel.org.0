Return-Path: <linux-api+bounces-6321-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UBc6CY5JA2pU2wEAu9opvQ
	(envelope-from <linux-api+bounces-6321-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Tue, 12 May 2026 17:38:54 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C6CBE523D27
	for <lists+linux-api@lfdr.de>; Tue, 12 May 2026 17:38:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 87F2F3040036
	for <lists+linux-api@lfdr.de>; Tue, 12 May 2026 15:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D1163C2BBE;
	Tue, 12 May 2026 15:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SgNEMtK4"
X-Original-To: linux-api@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D263C1F37
	for <linux-api@vger.kernel.org>; Tue, 12 May 2026 15:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778600104; cv=none; b=qsl6nu69fS4btO3/Q8FllVgL1sUAY06Y2C0lWdWdkARMWiDdMF3iJ4Bxc6HM8p/ZasmD9MbY7KBd93j5ErfYCZAl1IweA1P17+53/MYCjZ7TqVRhpjUdMMM7NOwDI9MG0pM1VLPQ2rwWGhF6W+oNR3zCPr0EGAdDXxNgvHeriyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778600104; c=relaxed/simple;
	bh=ZXtR9brtAQpauPVOBjglOEsojrhklMH3KAIv7FIUYS4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UmXcbXiQltPw/VNdiOwxLYVWzLBiSMPUxQsdC9DKNtwrGS3mlk8pIauPMZR+lQw2/VnSmzQm8mHgqxM2Rsu3L3+kDxzud1n5iBa+6PuzKUO3MeprmrY16QFLXSx/q+6NtPKhFMXnf78JqxG0Y7QJZTpC5go2hzIrMPnuQUUuYtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SgNEMtK4; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778600099;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ynSP2A48WzsWhTdPKvWNw9pMY4CJlt6sNheaWuA4ZrI=;
	b=SgNEMtK4I5x4IyabdAFrkfXTXtDDgeRwdNo5dEHSyDD4AnsQR9xSdNyIgybkcjNdNA2VHV
	mG2X9hDTvtxU9iof+GJi7dmdHsQJNj8MXc2LKowsoH4EBggrMAJGuxYW621BWHnOVCtOJ0
	tbL8gIrpAfNKZam1z+rXiI+0RqCC9KM=
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
Subject: [PATCH bpf-next v14 5/8] bpf: Add syscall common attributes support for btf_load
Date: Tue, 12 May 2026 23:31:54 +0800
Message-ID: <20260512153157.28382-6-leon.hwang@linux.dev>
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
X-Rspamd-Queue-Id: C6CBE523D27
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
	TAGGED_FROM(0.00)[bounces-6321-lists,linux-api=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon.hwang@linux.dev,linux-api@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-0.996];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-api];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.dev:email,linux.dev:mid,linux.dev:dkim]
X-Rspamd-Action: no action

BPF_BTF_LOAD can now take log parameters from both union bpf_attr and
struct bpf_common_attr, with the same merge rules as BPF_PROG_LOAD:

- if both sides provide a complete log tuple (buf/size/level) and they
  match, use it;
- if only one side provides log parameters, use that one;
- if both sides provide complete tuples but they differ, return -EINVAL.

Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 include/linux/btf.h  |  3 ++-
 kernel/bpf/btf.c     | 30 +++++++-----------------------
 kernel/bpf/syscall.c | 11 ++++++++---
 3 files changed, 17 insertions(+), 27 deletions(-)

diff --git a/include/linux/btf.h b/include/linux/btf.h
index c82d0d689059..240401d9b25b 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -145,7 +145,8 @@ const char *btf_get_name(const struct btf *btf);
 void btf_get(struct btf *btf);
 void btf_put(struct btf *btf);
 const struct btf_header *btf_header(const struct btf *btf);
-int btf_new_fd(const union bpf_attr *attr, bpfptr_t uattr, u32 uattr_sz);
+struct bpf_log_attr;
+int btf_new_fd(const union bpf_attr *attr, bpfptr_t uattr, struct bpf_log_attr *attr_log);
 struct btf *btf_get_by_fd(int fd);
 int btf_get_info_by_fd(const struct btf *btf,
 		       const union bpf_attr *attr,
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 77af44d8a3ad..a6bf4781943c 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -5907,25 +5907,10 @@ static int btf_check_type_tags(struct btf_verifier_env *env,
 	return 0;
 }
 
-static int finalize_log(struct bpf_verifier_log *log, bpfptr_t uattr, u32 uattr_size)
-{
-	u32 log_true_size;
-	int err;
-
-	err = bpf_vlog_finalize(log, &log_true_size);
-
-	if (uattr_size >= offsetofend(union bpf_attr, btf_log_true_size) &&
-	    copy_to_bpfptr_offset(uattr, offsetof(union bpf_attr, btf_log_true_size),
-				  &log_true_size, sizeof(log_true_size)))
-		err = -EFAULT;
-
-	return err;
-}
-
-static struct btf *btf_parse(const union bpf_attr *attr, bpfptr_t uattr, u32 uattr_size)
+static struct btf *btf_parse(const union bpf_attr *attr, bpfptr_t uattr,
+			     struct bpf_log_attr *attr_log)
 {
 	bpfptr_t btf_data = make_bpfptr(attr->btf, uattr.is_kernel);
-	char __user *log_ubuf = u64_to_user_ptr(attr->btf_log_buf);
 	struct btf_struct_metas *struct_meta_tab;
 	struct btf_verifier_env *env = NULL;
 	struct btf *btf = NULL;
@@ -5942,8 +5927,7 @@ static struct btf *btf_parse(const union bpf_attr *attr, bpfptr_t uattr, u32 uat
 	/* user could have requested verbose verifier output
 	 * and supplied buffer to store the verification trace
 	 */
-	err = bpf_vlog_init(&env->log, attr->btf_log_level,
-			    log_ubuf, attr->btf_log_size);
+	err = bpf_vlog_init(&env->log, attr_log->level, attr_log->ubuf, attr_log->size);
 	if (err)
 		goto errout_free;
 
@@ -6008,7 +5992,7 @@ static struct btf *btf_parse(const union bpf_attr *attr, bpfptr_t uattr, u32 uat
 		}
 	}
 
-	err = finalize_log(&env->log, uattr, uattr_size);
+	err = bpf_log_attr_finalize(attr_log, &env->log);
 	if (err)
 		goto errout_free;
 
@@ -6020,7 +6004,7 @@ static struct btf *btf_parse(const union bpf_attr *attr, bpfptr_t uattr, u32 uat
 	btf_free_struct_meta_tab(btf);
 errout:
 	/* overwrite err with -ENOSPC or -EFAULT */
-	ret = finalize_log(&env->log, uattr, uattr_size);
+	ret = bpf_log_attr_finalize(attr_log, &env->log);
 	if (ret)
 		err = ret;
 errout_free:
@@ -8189,12 +8173,12 @@ static int __btf_new_fd(struct btf *btf)
 	return anon_inode_getfd("btf", &btf_fops, btf, O_RDONLY | O_CLOEXEC);
 }
 
-int btf_new_fd(const union bpf_attr *attr, bpfptr_t uattr, u32 uattr_size)
+int btf_new_fd(const union bpf_attr *attr, bpfptr_t uattr, struct bpf_log_attr *attr_log)
 {
 	struct btf *btf;
 	int ret;
 
-	btf = btf_parse(attr, uattr, uattr_size);
+	btf = btf_parse(attr, uattr, attr_log);
 	if (IS_ERR(btf))
 		return PTR_ERR(btf);
 
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index db893cae826c..2fa05ba8f161 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -5474,7 +5474,7 @@ static int bpf_obj_get_info_by_fd(const union bpf_attr *attr,
 
 #define BPF_BTF_LOAD_LAST_FIELD btf_token_fd
 
-static int bpf_btf_load(const union bpf_attr *attr, bpfptr_t uattr, __u32 uattr_size)
+static int bpf_btf_load(const union bpf_attr *attr, bpfptr_t uattr, struct bpf_log_attr *attr_log)
 {
 	struct bpf_token *token = NULL;
 
@@ -5501,7 +5501,7 @@ static int bpf_btf_load(const union bpf_attr *attr, bpfptr_t uattr, __u32 uattr_
 
 	bpf_token_put(token);
 
-	return btf_new_fd(attr, uattr, uattr_size);
+	return btf_new_fd(attr, uattr, attr_log);
 }
 
 #define BPF_BTF_GET_FD_BY_ID_LAST_FIELD fd_by_id_token_fd
@@ -6318,7 +6318,12 @@ static int __sys_bpf(enum bpf_cmd cmd, bpfptr_t uattr, unsigned int size,
 		err = bpf_raw_tracepoint_open(&attr);
 		break;
 	case BPF_BTF_LOAD:
-		err = bpf_btf_load(&attr, uattr, size);
+		if (size >= offsetofend(union bpf_attr, btf_log_true_size))
+			offsetof_log_true_size = offsetof(union bpf_attr, btf_log_true_size);
+		err = bpf_log_attr_init(&attr_log, attr.btf_log_buf, attr.btf_log_size,
+					attr.btf_log_level, offsetof_log_true_size, uattr,
+					&attr_common, uattr_common, size_common);
+		err = err ?: bpf_btf_load(&attr, uattr, &attr_log);
 		break;
 	case BPF_BTF_GET_FD_BY_ID:
 		err = bpf_btf_get_fd_by_id(&attr);
-- 
2.54.0



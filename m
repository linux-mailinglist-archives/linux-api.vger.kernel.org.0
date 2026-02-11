Return-Path: <linux-api+bounces-5827-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0FNSDLacjGmPrgAAu9opvQ
	(envelope-from <linux-api+bounces-5827-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Wed, 11 Feb 2026 16:13:58 +0100
X-Original-To: lists+linux-api@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6660E1257FF
	for <lists+linux-api@lfdr.de>; Wed, 11 Feb 2026 16:13:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9CAFB30046A2
	for <lists+linux-api@lfdr.de>; Wed, 11 Feb 2026 15:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDD1D2C0F6E;
	Wed, 11 Feb 2026 15:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="iYsP1oy3"
X-Original-To: linux-api@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 591A12C11F7
	for <linux-api@vger.kernel.org>; Wed, 11 Feb 2026 15:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770822832; cv=none; b=aidTZKXG8naMcuk3w5msSO9/+KmnBR3igqjpOH9MRZsF5VqwLKCPafPpyrTbEZK9bBwqwjJM1/bOKJwvUrlTBUHEtLHDf0xFqvvL94EUVE0zrsZ3lFw9RhOLc7sgweEeeMLCnCkv/p0Ih4l7uJmamcKmeT+QyNTlegDeRvdzXQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770822832; c=relaxed/simple;
	bh=wsNbnNrX/E0oUOQ/abuMeAPFytvjjexeGaGlGVLL/X0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gr6qezqO3Bx7J7iwzDlokwmjBMmFzHz4LY/aFRm4m5AOkX8PbUQtHLZ4VrQyCo2u7F7qVEoU4sFte5b0V1+3ylQwCCxm5SZtaBxQSxCzak+Vs/SzGRoMbnLmQo+BAI+Mq/c9dAgWECRwCrkvjVy2V1mlwNFEMWV78ReJcOJgrqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=iYsP1oy3; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770822828;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=daYcGmxvC1QIWnmveG7GEdqpmzD/le9h83f5BmM71Tk=;
	b=iYsP1oy3bjjK1xRAtleWVqSclVdnjMPk595F9m0jHXUWdoTu6DFag+6ymycL8kwssGW8cP
	tnAn1WDcI09KGYEYCckQqnrGDWGLAZxIJ4TPbusvq+/5JtGGWGJh3gCkfMOOZKOr3q8+Uc
	dAT4mEyq/r9jCSqakItB/xR5UaSDux4=
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
Subject: [PATCH bpf-next v10 6/8] bpf: Add syscall common attributes support for map_create
Date: Wed, 11 Feb 2026 23:11:13 +0800
Message-ID: <20260211151115.78013-7-leon.hwang@linux.dev>
In-Reply-To: <20260211151115.78013-1-leon.hwang@linux.dev>
References: <20260211151115.78013-1-leon.hwang@linux.dev>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[31];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-5827-lists,linux-api=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,gmail.com,linux.dev,fomichev.me,google.com,amazon.com,redhat.com,meta.com,cestc.cn,vger.kernel.org,fb.com];
	DKIM_TRACE(0.00)[linux.dev:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon.hwang@linux.dev,linux-api@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-api];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linux.dev:mid,linux.dev:dkim,linux.dev:email]
X-Rspamd-Queue-Id: 6660E1257FF
X-Rspamd-Action: no action

Many BPF_MAP_CREATE validation failures currently return -EINVAL without
any explanation to userspace.

Plumb common syscall log attributes into map_create(), create a verifier
log from bpf_common_attr::log_buf/log_size/log_level, and report
map-creation failure reasons through that buffer.

This improves debuggability by allowing userspace to inspect why map
creation failed and read back log_true_size from common attributes.

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 include/linux/bpf_verifier.h |  3 ++
 kernel/bpf/log.c             | 30 +++++++++++++++++
 kernel/bpf/syscall.c         | 65 ++++++++++++++++++++++++++++++------
 3 files changed, 88 insertions(+), 10 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 34f28d40022a..52627a93338f 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -645,6 +645,9 @@ struct bpf_log_attr {
 int bpf_log_attr_init(struct bpf_log_attr *log, u64 log_buf, u32 log_size, u32 log_level,
 		      u32 __user *log_true_size, struct bpf_common_attr *common, bpfptr_t uattr,
 		      u32 size);
+struct bpf_verifier_log *bpf_log_attr_create_vlog(struct bpf_log_attr *attr_log,
+						  struct bpf_common_attr *common, bpfptr_t uattr,
+						  u32 size);
 int bpf_log_attr_finalize(struct bpf_log_attr *attr, struct bpf_verifier_log *log);
 
 #define BPF_MAX_SUBPROGS 256
diff --git a/kernel/bpf/log.c b/kernel/bpf/log.c
index a2b41bf5e9cb..f7251217452e 100644
--- a/kernel/bpf/log.c
+++ b/kernel/bpf/log.c
@@ -904,6 +904,36 @@ int bpf_log_attr_init(struct bpf_log_attr *log, u64 log_buf, u32 log_size, u32 l
 	return 0;
 }
 
+
+struct bpf_verifier_log *bpf_log_attr_create_vlog(struct bpf_log_attr *attr_log,
+						  struct bpf_common_attr *common, bpfptr_t uattr,
+						  u32 size)
+{
+	struct bpf_verifier_log *log;
+	int err;
+
+	memset(attr_log, 0, sizeof(*attr_log));
+	if (size >= offsetofend(struct bpf_common_attr, log_true_size))
+		attr_log->log_true_size = uattr.user + offsetof(struct bpf_common_attr,
+								log_true_size);
+
+	if (!common->log_buf)
+		return NULL;
+
+	log = kzalloc_obj(*log, GFP_KERNEL);
+	if (!log)
+		return ERR_PTR(-ENOMEM);
+
+	err = bpf_vlog_init(log, common->log_level, u64_to_user_ptr(common->log_buf),
+			    common->log_size);
+	if (err) {
+		kfree(log);
+		return ERR_PTR(err);
+	}
+
+	return log;
+}
+
 int bpf_log_attr_finalize(struct bpf_log_attr *attr, struct bpf_verifier_log *log)
 {
 	u32 log_true_size;
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 6d727a4b5121..04bb4a905559 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -1365,7 +1365,7 @@ static int map_check_btf(struct bpf_map *map, struct bpf_token *token,
 
 #define BPF_MAP_CREATE_LAST_FIELD excl_prog_hash_size
 /* called via syscall */
-static int map_create(union bpf_attr *attr, bpfptr_t uattr)
+static int __map_create(union bpf_attr *attr, bpfptr_t uattr, struct bpf_verifier_log *log)
 {
 	const struct bpf_map_ops *ops;
 	struct bpf_token *token = NULL;
@@ -1377,8 +1377,10 @@ static int map_create(union bpf_attr *attr, bpfptr_t uattr)
 	int err;
 
 	err = CHECK_ATTR(BPF_MAP_CREATE);
-	if (err)
+	if (err) {
+		bpf_log(log, "Invalid attr.\n");
 		return -EINVAL;
+	}
 
 	/* check BPF_F_TOKEN_FD flag, remember if it's set, and then clear it
 	 * to avoid per-map type checks tripping on unknown flag
@@ -1387,17 +1389,25 @@ static int map_create(union bpf_attr *attr, bpfptr_t uattr)
 	attr->map_flags &= ~BPF_F_TOKEN_FD;
 
 	if (attr->btf_vmlinux_value_type_id) {
-		if (attr->map_type != BPF_MAP_TYPE_STRUCT_OPS ||
-		    attr->btf_key_type_id || attr->btf_value_type_id)
+		if (attr->map_type != BPF_MAP_TYPE_STRUCT_OPS) {
+			bpf_log(log, "btf_vmlinux_value_type_id can only be used with struct_ops maps.\n");
 			return -EINVAL;
+		}
+		if (attr->btf_key_type_id || attr->btf_value_type_id) {
+			bpf_log(log, "btf_vmlinux_value_type_id is mutually exclusive with btf_key_type_id and btf_value_type_id.\n");
+			return -EINVAL;
+		}
 	} else if (attr->btf_key_type_id && !attr->btf_value_type_id) {
+		bpf_log(log, "Invalid btf_value_type_id.\n");
 		return -EINVAL;
 	}
 
 	if (attr->map_type != BPF_MAP_TYPE_BLOOM_FILTER &&
 	    attr->map_type != BPF_MAP_TYPE_ARENA &&
-	    attr->map_extra != 0)
+	    attr->map_extra != 0) {
+		bpf_log(log, "Invalid map_extra.\n");
 		return -EINVAL;
+	}
 
 	f_flags = bpf_get_file_flag(attr->map_flags);
 	if (f_flags < 0)
@@ -1405,13 +1415,17 @@ static int map_create(union bpf_attr *attr, bpfptr_t uattr)
 
 	if (numa_node != NUMA_NO_NODE &&
 	    ((unsigned int)numa_node >= nr_node_ids ||
-	     !node_online(numa_node)))
+	     !node_online(numa_node))) {
+		bpf_log(log, "Invalid numa_node.\n");
 		return -EINVAL;
+	}
 
 	/* find map type and init map: hashtable vs rbtree vs bloom vs ... */
 	map_type = attr->map_type;
-	if (map_type >= ARRAY_SIZE(bpf_map_types))
+	if (map_type >= ARRAY_SIZE(bpf_map_types)) {
+		bpf_log(log, "Invalid map_type.\n");
 		return -EINVAL;
+	}
 	map_type = array_index_nospec(map_type, ARRAY_SIZE(bpf_map_types));
 	ops = bpf_map_types[map_type];
 	if (!ops)
@@ -1429,8 +1443,10 @@ static int map_create(union bpf_attr *attr, bpfptr_t uattr)
 
 	if (token_flag) {
 		token = bpf_token_get_from_fd(attr->map_token_fd);
-		if (IS_ERR(token))
+		if (IS_ERR(token)) {
+			bpf_log(log, "Invalid map_token_fd.\n");
 			return PTR_ERR(token);
+		}
 
 		/* if current token doesn't grant map creation permissions,
 		 * then we can't use this token, so ignore it and rely on
@@ -1513,8 +1529,10 @@ static int map_create(union bpf_attr *attr, bpfptr_t uattr)
 
 	err = bpf_obj_name_cpy(map->name, attr->map_name,
 			       sizeof(attr->map_name));
-	if (err < 0)
+	if (err < 0) {
+		bpf_log(log, "Invalid map_name.\n");
 		goto free_map;
+	}
 
 	preempt_disable();
 	map->cookie = gen_cookie_next(&bpf_map_cookie);
@@ -1537,6 +1555,7 @@ static int map_create(union bpf_attr *attr, bpfptr_t uattr)
 
 		btf = btf_get_by_fd(attr->btf_fd);
 		if (IS_ERR(btf)) {
+			bpf_log(log, "Invalid btf_fd.\n");
 			err = PTR_ERR(btf);
 			goto free_map;
 		}
@@ -1564,6 +1583,7 @@ static int map_create(union bpf_attr *attr, bpfptr_t uattr)
 		bpfptr_t uprog_hash = make_bpfptr(attr->excl_prog_hash, uattr.is_kernel);
 
 		if (attr->excl_prog_hash_size != SHA256_DIGEST_SIZE) {
+			bpf_log(log, "Invalid excl_prog_hash_size.\n");
 			err = -EINVAL;
 			goto free_map;
 		}
@@ -1579,6 +1599,7 @@ static int map_create(union bpf_attr *attr, bpfptr_t uattr)
 			goto free_map;
 		}
 	} else if (attr->excl_prog_hash_size) {
+		bpf_log(log, "Invalid excl_prog_hash_size.\n");
 		err = -EINVAL;
 		goto free_map;
 	}
@@ -1617,6 +1638,30 @@ static int map_create(union bpf_attr *attr, bpfptr_t uattr)
 	return err;
 }
 
+static int map_create(union bpf_attr *attr, bpfptr_t uattr, struct bpf_common_attr *attr_common,
+		      bpfptr_t uattr_common, u32 size_common)
+{
+	struct bpf_verifier_log *log;
+	struct bpf_log_attr attr_log;
+	int err, ret;
+
+	log = bpf_log_attr_create_vlog(&attr_log, attr_common, uattr_common, size_common);
+	if (IS_ERR(log))
+		return PTR_ERR(log);
+
+	err = __map_create(attr, uattr, log);
+	if (err >= 0)
+		goto free;
+
+	ret = bpf_log_attr_finalize(&attr_log, log);
+	if (ret)
+		err = ret;
+
+free:
+	kfree(log);
+	return err;
+}
+
 void bpf_map_inc(struct bpf_map *map)
 {
 	atomic64_inc(&map->refcnt);
@@ -6226,7 +6271,7 @@ static int __sys_bpf(enum bpf_cmd cmd, bpfptr_t uattr, unsigned int size,
 
 	switch (cmd) {
 	case BPF_MAP_CREATE:
-		err = map_create(&attr, uattr);
+		err = map_create(&attr, uattr, &attr_common, uattr_common, size_common);
 		break;
 	case BPF_MAP_LOOKUP_ELEM:
 		err = map_lookup_elem(&attr);
-- 
2.52.0



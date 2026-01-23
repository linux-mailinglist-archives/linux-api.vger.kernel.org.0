Return-Path: <linux-api+bounces-5729-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GEB1N4vqcmnQrAAAu9opvQ
	(envelope-from <linux-api+bounces-5729-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Fri, 23 Jan 2026 04:27:07 +0100
X-Original-To: lists+linux-api@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5228C70129
	for <lists+linux-api@lfdr.de>; Fri, 23 Jan 2026 04:27:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B07C43008D35
	for <lists+linux-api@lfdr.de>; Fri, 23 Jan 2026 03:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AD263815F0;
	Fri, 23 Jan 2026 03:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xakdCuCo"
X-Original-To: linux-api@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 768BF389450;
	Fri, 23 Jan 2026 03:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769138798; cv=none; b=ZycnLyjPRqfdj4EsHrSTyxw/jGk1xl+OhA/oBVFfaT/lroL3eOsWjvGXlzIew6V6tZBgCevE4wnRY0oD1AHSDatAngN2ROeLi5s6Z6S9G0Fv1u1Jx5ntykw02ihDOzJAVtBQsozDlHLKHE+TlK1yy4D+bQw4uY+Lyc5/c8ftg2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769138798; c=relaxed/simple;
	bh=3CDRb5TfBaaU8wObRpIAxISLoRybRiGI7jGZei7pTIw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XBHwzq4xBIJsR1tYvK9jByXPb/EYPswQdfyzyMZKILTAE/rIPcXvRw+mhfxXjDVIMBh7Cp5MBBGgDCLUyGp8anFgE34tSDgJCye1vElxIE0ZNdnwDYmikdl5eudIAjrs1RJcsjwndSjHusndLw7DEcAlr955cKmaUeILYSL67ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xakdCuCo; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1769138786;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v1mZt6DIO7MMOA55DtyJvBYGEgLMXpTZ3zAejg5xJ4o=;
	b=xakdCuCoh+5akxxwDX4cYCZVZsOHGMXt6/i1V6VGA7QDUGQCwaUvBHBM9P1eNQUEcSnD68
	v/L0+t8PRD7GD9dTFKvXWfCeOndme5Ww9fjqilAHyJWJWrHEMHMvLFqGvz0tMMOZhdj0gA
	qGrGWGQ5ixmHz5WbWMbcXva1g8YnsXQ=
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
Subject: [PATCH bpf-next v7 5/9] bpf: Refactor reporting btf_log_true_size for btf_load
Date: Fri, 23 Jan 2026 11:24:41 +0800
Message-ID: <20260123032445.125259-6-leon.hwang@linux.dev>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,gmail.com,linux.dev,fomichev.me,google.com,amazon.com,redhat.com,meta.com,cestc.cn,vger.kernel.org,fb.com];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_TWELVE(0.00)[31];
	TAGGED_FROM(0.00)[bounces-5729-lists,linux-api=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon.hwang@linux.dev,linux-api@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-0.960];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-api];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,linux.dev:dkim,linux.dev:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5228C70129
X-Rspamd-Action: no action

In the next commit, it will be able to report logs via extended common
attributes, which will report 'log_true_size' via the extended common
attributes meanwhile.

Therefore, refactor the way of 'btf_log_true_size' reporting in order to
report 'log_true_size' via the extended common attributes easily.

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 include/linux/bpf_verifier.h |  1 +
 include/linux/btf.h          |  3 ++-
 kernel/bpf/btf.c             | 32 +++++++++-----------------------
 kernel/bpf/log.c             |  9 +++++++++
 kernel/bpf/syscall.c         | 10 +++++++++-
 5 files changed, 30 insertions(+), 25 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 7eb024e83d2d..28e22a03ac84 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -642,6 +642,7 @@ struct bpf_log_attr {
 
 int bpf_prog_load_log_attr_init(struct bpf_log_attr *log_attr, struct bpf_attrs *attrs,
 				struct bpf_attrs *attrs_common);
+int bpf_btf_load_log_attr_init(struct bpf_log_attr *log_attr, struct bpf_attrs *attrs);
 int bpf_log_attr_finalize(struct bpf_log_attr *log_attr, struct bpf_verifier_log *log);
 
 #define BPF_MAX_SUBPROGS 256
diff --git a/include/linux/btf.h b/include/linux/btf.h
index 48108471c5b1..2812caa6c60e 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -145,7 +145,8 @@ const char *btf_get_name(const struct btf *btf);
 void btf_get(struct btf *btf);
 void btf_put(struct btf *btf);
 const struct btf_header *btf_header(const struct btf *btf);
-int btf_new_fd(const union bpf_attr *attr, bpfptr_t uattr, u32 uattr_sz);
+struct bpf_log_attr;
+int btf_new_fd(const union bpf_attr *attr, bpfptr_t uattr, struct bpf_log_attr *log_attr);
 struct btf *btf_get_by_fd(int fd);
 int btf_get_info_by_fd(const struct btf *btf,
 		       const union bpf_attr *attr,
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index d10b3404260f..136fdd8f73b2 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -5856,25 +5856,11 @@ static int btf_check_type_tags(struct btf_verifier_env *env,
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
+			     struct bpf_log_attr *log_attr)
 {
 	bpfptr_t btf_data = make_bpfptr(attr->btf, uattr.is_kernel);
-	char __user *log_ubuf = u64_to_user_ptr(attr->btf_log_buf);
+	char __user *log_ubuf = u64_to_user_ptr(log_attr->log_buf);
 	struct btf_struct_metas *struct_meta_tab;
 	struct btf_verifier_env *env = NULL;
 	struct btf *btf = NULL;
@@ -5891,8 +5877,8 @@ static struct btf *btf_parse(const union bpf_attr *attr, bpfptr_t uattr, u32 uat
 	/* user could have requested verbose verifier output
 	 * and supplied buffer to store the verification trace
 	 */
-	err = bpf_vlog_init(&env->log, attr->btf_log_level,
-			    log_ubuf, attr->btf_log_size);
+	err = bpf_vlog_init(&env->log, log_attr->log_level,
+			    log_ubuf, log_attr->log_size);
 	if (err)
 		goto errout_free;
 
@@ -5953,7 +5939,7 @@ static struct btf *btf_parse(const union bpf_attr *attr, bpfptr_t uattr, u32 uat
 		}
 	}
 
-	err = finalize_log(&env->log, uattr, uattr_size);
+	err = bpf_log_attr_finalize(log_attr, &env->log);
 	if (err)
 		goto errout_free;
 
@@ -5965,7 +5951,7 @@ static struct btf *btf_parse(const union bpf_attr *attr, bpfptr_t uattr, u32 uat
 	btf_free_struct_meta_tab(btf);
 errout:
 	/* overwrite err with -ENOSPC or -EFAULT */
-	ret = finalize_log(&env->log, uattr, uattr_size);
+	ret = bpf_log_attr_finalize(log_attr, &env->log);
 	if (ret)
 		err = ret;
 errout_free:
@@ -8134,12 +8120,12 @@ static int __btf_new_fd(struct btf *btf)
 	return anon_inode_getfd("btf", &btf_fops, btf, O_RDONLY | O_CLOEXEC);
 }
 
-int btf_new_fd(const union bpf_attr *attr, bpfptr_t uattr, u32 uattr_size)
+int btf_new_fd(const union bpf_attr *attr, bpfptr_t uattr, struct bpf_log_attr *log_attr)
 {
 	struct btf *btf;
 	int ret;
 
-	btf = btf_parse(attr, uattr, uattr_size);
+	btf = btf_parse(attr, uattr, log_attr);
 	if (IS_ERR(btf))
 		return PTR_ERR(btf);
 
diff --git a/kernel/bpf/log.c b/kernel/bpf/log.c
index c0b816e84384..f1ed24157d71 100644
--- a/kernel/bpf/log.c
+++ b/kernel/bpf/log.c
@@ -902,6 +902,15 @@ int bpf_prog_load_log_attr_init(struct bpf_log_attr *log_attr, struct bpf_attrs
 				 offsetof(union bpf_attr, log_true_size), attrs_common);
 }
 
+int bpf_btf_load_log_attr_init(struct bpf_log_attr *log_attr, struct bpf_attrs *attrs)
+{
+	const union bpf_attr *attr = attrs->attr;
+
+	return bpf_log_attr_init(log_attr, attrs, attr->btf_log_buf, attr->btf_log_size,
+				 attr->btf_log_level, offsetof(union bpf_attr, btf_log_true_size),
+				 NULL);
+}
+
 int bpf_log_attr_finalize(struct bpf_log_attr *log_attr, struct bpf_verifier_log *log)
 {
 	u32 log_true_size, off;
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 8f3e489667d7..6241ef35c164 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -5436,6 +5436,9 @@ static int bpf_obj_get_info_by_fd(const union bpf_attr *attr,
 static int bpf_btf_load(const union bpf_attr *attr, bpfptr_t uattr, __u32 uattr_size)
 {
 	struct bpf_token *token = NULL;
+	struct bpf_log_attr log_attr;
+	struct bpf_attrs attrs;
+	int err;
 
 	if (CHECK_ATTR(BPF_BTF_LOAD))
 		return -EINVAL;
@@ -5443,6 +5446,11 @@ static int bpf_btf_load(const union bpf_attr *attr, bpfptr_t uattr, __u32 uattr_
 	if (attr->btf_flags & ~BPF_F_TOKEN_FD)
 		return -EINVAL;
 
+	bpf_attrs_init(&attrs, attr, uattr, uattr_size);
+	err = bpf_btf_load_log_attr_init(&log_attr, &attrs);
+	if (err)
+		return err;
+
 	if (attr->btf_flags & BPF_F_TOKEN_FD) {
 		token = bpf_token_get_from_fd(attr->btf_token_fd);
 		if (IS_ERR(token))
@@ -5460,7 +5468,7 @@ static int bpf_btf_load(const union bpf_attr *attr, bpfptr_t uattr, __u32 uattr_
 
 	bpf_token_put(token);
 
-	return btf_new_fd(attr, uattr, uattr_size);
+	return btf_new_fd(attr, uattr, &log_attr);
 }
 
 #define BPF_BTF_GET_FD_BY_ID_LAST_FIELD fd_by_id_token_fd
-- 
2.52.0



Return-Path: <linux-api+bounces-5787-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eGV2JDK5gGl3AgMAu9opvQ
	(envelope-from <linux-api+bounces-5787-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Mon, 02 Feb 2026 15:48:18 +0100
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0658DCD95C
	for <lists+linux-api@lfdr.de>; Mon, 02 Feb 2026 15:48:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AAD7A309E17B
	for <lists+linux-api@lfdr.de>; Mon,  2 Feb 2026 14:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 741C036E466;
	Mon,  2 Feb 2026 14:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DUS2d9Dl"
X-Original-To: linux-api@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5640736CE08;
	Mon,  2 Feb 2026 14:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770043298; cv=none; b=XrayB7xg57q5NWIe0NGNy8/v7iuxnQlWCF5ICalOh5Ol0QSdEQupatr8DwqCNxGNxn7Voaq1LIMJBVJ5w4PZSZFALFeK3knL0NLOMnQtG6PWx/P6sccqJhQ6vWuhGgJuytMsegEbHoWO6hqdQTTESMlEvLZdqVEgmuQa41cFpu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770043298; c=relaxed/simple;
	bh=zaHeGo39l7aEuaZEfB56y1SA/o4IPg0uaFbgQja2DE8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hbOGOmJb9oc0R3uXxSD8KgyiaG7Z331DIEwX9gfkBxJm/cL1lOXUVx3FS5zPJlZQA+Y6S5Hy+FLfngUFA8vCUqnuxGHdCLAtEzXka+bViYe0g4BR+hidqzlxgGy8UtaFoqz8hO5+MIVOkuOtFWnMjMQTRwYY6iTD3JCxNAOxF3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DUS2d9Dl; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770043293;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gu+RSjY5ZXq9VFl4b21GzQKsHQDjqCZoGYucoG6n0Lw=;
	b=DUS2d9DljdUgomFx8gIdL3IroisXYzzO5lniXShtkR1i3rmcexzdM0/uzHAoZbXDog8rJn
	a9mOKCkGlztJ/TokmV98Tbk4AH6zk5PnyCmSh/3TZk7rbXvhgMw1o8MdDpaREKbj3cIird
	eff87aZvnKVn6tW/TJDB9N6ge1mD4Og=
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
Subject: [PATCH bpf-next v9 2/9] libbpf: Add support for extended bpf syscall
Date: Mon,  2 Feb 2026 22:40:39 +0800
Message-ID: <20260202144046.30651-3-leon.hwang@linux.dev>
In-Reply-To: <20260202144046.30651-1-leon.hwang@linux.dev>
References: <20260202144046.30651-1-leon.hwang@linux.dev>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,gmail.com,linux.dev,fomichev.me,google.com,amazon.com,redhat.com,meta.com,cestc.cn,vger.kernel.org,fb.com];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_TWELVE(0.00)[31];
	TAGGED_FROM(0.00)[bounces-5787-lists,linux-api=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon.hwang@linux.dev,linux-api@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-api];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:email,linux.dev:dkim,linux.dev:mid]
X-Rspamd-Queue-Id: 0658DCD95C
X-Rspamd-Action: no action

To support the extended BPF syscall introduced in the previous commit,
introduce the following internal APIs:

* 'sys_bpf_ext()'
* 'sys_bpf_ext_fd()'
  They wrap the raw 'syscall()' interface to support passing extended
  attributes.
* 'probe_sys_bpf_ext()'
  Check whether current kernel supports the BPF syscall common attributes.

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 tools/lib/bpf/bpf.c             | 36 +++++++++++++++++++++++++++++++++
 tools/lib/bpf/features.c        |  8 ++++++++
 tools/lib/bpf/libbpf_internal.h |  3 +++
 3 files changed, 47 insertions(+)

diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index 5846de364209..9d8740761b7a 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -69,6 +69,42 @@ static inline __u64 ptr_to_u64(const void *ptr)
 	return (__u64) (unsigned long) ptr;
 }
 
+static inline int sys_bpf_ext(enum bpf_cmd cmd, union bpf_attr *attr,
+			      unsigned int size,
+			      struct bpf_common_attr *attr_common,
+			      unsigned int size_common)
+{
+	cmd = attr_common ? (cmd | BPF_COMMON_ATTRS) : (cmd & ~BPF_COMMON_ATTRS);
+	return syscall(__NR_bpf, cmd, attr, size, attr_common, size_common);
+}
+
+static inline int sys_bpf_ext_fd(enum bpf_cmd cmd, union bpf_attr *attr,
+				 unsigned int size,
+				 struct bpf_common_attr *attr_common,
+				 unsigned int size_common)
+{
+	int fd;
+
+	fd = sys_bpf_ext(cmd, attr, size, attr_common, size_common);
+	return ensure_good_fd(fd);
+}
+
+int probe_sys_bpf_ext(void)
+{
+	const size_t attr_sz = offsetofend(union bpf_attr, prog_token_fd);
+	union bpf_attr attr;
+	int fd;
+
+	memset(&attr, 0, attr_sz);
+	fd = syscall(__NR_bpf, BPF_PROG_LOAD | BPF_COMMON_ATTRS, &attr, attr_sz, NULL,
+		     sizeof(struct bpf_common_attr));
+	if (fd >= 0) {
+		close(fd);
+		return -EINVAL;
+	}
+	return errno == EFAULT ? 1 : 0;
+}
+
 static inline int sys_bpf(enum bpf_cmd cmd, union bpf_attr *attr,
 			  unsigned int size)
 {
diff --git a/tools/lib/bpf/features.c b/tools/lib/bpf/features.c
index b842b83e2480..e0d646a9e233 100644
--- a/tools/lib/bpf/features.c
+++ b/tools/lib/bpf/features.c
@@ -506,6 +506,11 @@ static int probe_kern_arg_ctx_tag(int token_fd)
 	return probe_fd(prog_fd);
 }
 
+static int probe_bpf_syscall_common_attrs(int token_fd)
+{
+	return probe_sys_bpf_ext();
+}
+
 typedef int (*feature_probe_fn)(int /* token_fd */);
 
 static struct kern_feature_cache feature_cache;
@@ -581,6 +586,9 @@ static struct kern_feature_desc {
 	[FEAT_BTF_QMARK_DATASEC] = {
 		"BTF DATASEC names starting from '?'", probe_kern_btf_qmark_datasec,
 	},
+	[FEAT_BPF_SYSCALL_COMMON_ATTRS] = {
+		"BPF syscall common attributes support", probe_bpf_syscall_common_attrs,
+	},
 };
 
 bool feat_supported(struct kern_feature_cache *cache, enum kern_feature_id feat_id)
diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_internal.h
index fc59b21b51b5..aa16be869c4f 100644
--- a/tools/lib/bpf/libbpf_internal.h
+++ b/tools/lib/bpf/libbpf_internal.h
@@ -392,6 +392,8 @@ enum kern_feature_id {
 	FEAT_ARG_CTX_TAG,
 	/* Kernel supports '?' at the front of datasec names */
 	FEAT_BTF_QMARK_DATASEC,
+	/* Kernel supports BPF syscall common attributes */
+	FEAT_BPF_SYSCALL_COMMON_ATTRS,
 	__FEAT_CNT,
 };
 
@@ -757,4 +759,5 @@ int probe_fd(int fd);
 #define SHA256_DWORD_SIZE SHA256_DIGEST_LENGTH / sizeof(__u64)
 
 void libbpf_sha256(const void *data, size_t len, __u8 out[SHA256_DIGEST_LENGTH]);
+int probe_sys_bpf_ext(void);
 #endif /* __LIBBPF_LIBBPF_INTERNAL_H */
-- 
2.52.0



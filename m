Return-Path: <linux-api+bounces-6115-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YAZyHVtW5mktvAEAu9opvQ
	(envelope-from <linux-api+bounces-6115-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Mon, 20 Apr 2026 18:37:47 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1038842FBB3
	for <lists+linux-api@lfdr.de>; Mon, 20 Apr 2026 18:37:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AE90632F54B5
	for <lists+linux-api@lfdr.de>; Mon, 20 Apr 2026 15:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56C263BFE5C;
	Mon, 20 Apr 2026 14:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TcY7uWAh"
X-Original-To: linux-api@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 900843C0606
	for <linux-api@vger.kernel.org>; Mon, 20 Apr 2026 14:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776694772; cv=none; b=t1RfUU9xceXXMn3BVwqFUnO9GQUXYbK3pRYO7MkSjSWzbnvWypr3g4slkZt3ikfb+CUG32A6ej4AIi3oMDtY9XhOQZSdxcE7Y11F4jGW5aU/QEQE4TQekr26xicxHeIokevWpG2rVqxEQiFKuueTK8RDA32xrcb6o82+prnFOtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776694772; c=relaxed/simple;
	bh=0/KVBhsba/YONhyPIyhWHj1qyHpt99QzqFtbyRLusvw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YA9Bi4RkvN0tOsCLsaIJyANyHUp7RPlH55V8+aKRV0hlRUHLsYavUBRJleqSYZ33v/cTDTU09P4utKvJFvI9JQVuEaweneMmHBSRqK0KpVefddJ1DXTMTa4Tm1Yirk6bF5SQbalqLyDkFdVA1Bwaruu08KDxBjl6cuHBwzAL9EE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TcY7uWAh; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776694767;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6oRg7T8aX7RYdFqsiavhGpax9Doc0ST+f1G0sI408Lw=;
	b=TcY7uWAhLNdW7yZl15eN3ecQI9WveMMfrjdzXLxHwfwr+0VO2Usqet0YIO3Afb3RvAKoz3
	Re1pLqWoaU5qXZbzzcaDBKbXuBUuj2YdB0Qqx3McDHgppAgesHXph4Ak7HOndY12zwfvtX
	vmQ/vKI/iGQib10KroOKEpw1KXJQ3y8=
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
Subject: [PATCH bpf-next v12 4/8] bpf: Add syscall common attributes support for prog_load
Date: Mon, 20 Apr 2026 22:18:00 +0800
Message-ID: <20260420141804.27179-5-leon.hwang@linux.dev>
In-Reply-To: <20260420141804.27179-1-leon.hwang@linux.dev>
References: <20260420141804.27179-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,gmail.com,linux.dev,fomichev.me,google.com,amazon.com,redhat.com,meta.com,cestc.cn,vger.kernel.org,fb.com];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_TWELVE(0.00)[31];
	TAGGED_FROM(0.00)[bounces-6115-lists,linux-api=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon.hwang@linux.dev,linux-api@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-api];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linux.dev:email,linux.dev:dkim,linux.dev:mid]
X-Rspamd-Queue-Id: 1038842FBB3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

BPF_PROG_LOAD can now take log parameters from both union bpf_attr and
struct bpf_common_attr. The merge rules are:

- if both sides provide a complete log tuple (buf/size/level) and they
  match, use it;
- if only one side provides log parameters, use that one;
- if both sides provide complete tuples but they differ, return -EINVAL.

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 include/linux/bpf_verifier.h |  3 ++-
 kernel/bpf/log.c             | 34 +++++++++++++++++++++++++++-------
 kernel/bpf/syscall.c         |  3 ++-
 3 files changed, 31 insertions(+), 9 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 1162b5492841..9045dc88c5b6 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -656,7 +656,8 @@ struct bpf_log_attr {
 };
 
 int bpf_log_attr_init(struct bpf_log_attr *log, u64 log_buf, u32 log_size, u32 log_level,
-		      u32 offsetof_log_true_size, bpfptr_t uattr);
+		      u32 offsetof_log_true_size, bpfptr_t uattr, struct bpf_common_attr *common,
+		      bpfptr_t uattr_common, u32 size_common);
 int bpf_log_attr_finalize(struct bpf_log_attr *attr, struct bpf_verifier_log *log);
 
 #define BPF_MAX_SUBPROGS 256
diff --git a/kernel/bpf/log.c b/kernel/bpf/log.c
index 9c5c755d5972..dc8734e27752 100644
--- a/kernel/bpf/log.c
+++ b/kernel/bpf/log.c
@@ -13,17 +13,17 @@
 
 #define verbose(env, fmt, args...) bpf_verifier_log_write(env, fmt, ##args)
 
-static bool bpf_verifier_log_attr_valid(const struct bpf_verifier_log *log)
+static bool bpf_verifier_log_attr_valid(u32 log_level, char __user *log_buf, u32 log_size)
 {
 	/* ubuf and len_total should both be specified (or not) together */
-	if (!!log->ubuf != !!log->len_total)
+	if (!!log_buf != !!log_size)
 		return false;
 	/* log buf without log_level is meaningless */
-	if (log->ubuf && log->level == 0)
+	if (log_buf && log_level == 0)
 		return false;
-	if (log->level & ~BPF_LOG_MASK)
+	if (log_level & ~BPF_LOG_MASK)
 		return false;
-	if (log->len_total > UINT_MAX >> 2)
+	if (log_size > UINT_MAX >> 2)
 		return false;
 	return true;
 }
@@ -36,7 +36,7 @@ int bpf_vlog_init(struct bpf_verifier_log *log, u32 log_level,
 	log->len_total = log_size;
 
 	/* log attributes have to be sane */
-	if (!bpf_verifier_log_attr_valid(log))
+	if (!bpf_verifier_log_attr_valid(log_level, log_buf, log_size))
 		return -EINVAL;
 
 	return 0;
@@ -867,16 +867,36 @@ void print_insn_state(struct bpf_verifier_env *env, const struct bpf_verifier_st
 }
 
 int bpf_log_attr_init(struct bpf_log_attr *log, u64 log_buf, u32 log_size, u32 log_level,
-		      u32 offsetof_log_true_size, bpfptr_t uattr)
+		      u32 offsetof_log_true_size, bpfptr_t uattr, struct bpf_common_attr *common,
+		      bpfptr_t uattr_common, u32 size_common)
 {
+	char __user *ubuf_common = u64_to_user_ptr(common->log_buf);
 	char __user *ubuf = u64_to_user_ptr(log_buf);
 
+	if (!bpf_verifier_log_attr_valid(common->log_level, ubuf_common, common->log_size) ||
+	    !bpf_verifier_log_attr_valid(log_level, ubuf, log_size))
+		return -EINVAL;
+
+	if (ubuf && ubuf_common && (ubuf != ubuf_common || log_size != common->log_size ||
+				    log_level != common->log_level))
+		return -EINVAL;
+
 	memset(log, 0, sizeof(*log));
 	log->ubuf = ubuf;
 	log->size = log_size;
 	log->level = log_level;
 	log->offsetof_true_size = offsetof_log_true_size;
 	log->uattr = uattr;
+
+	if (!ubuf && ubuf_common) {
+		log->ubuf = ubuf_common;
+		log->size = common->log_size;
+		log->level = common->log_level;
+		log->uattr = uattr_common;
+		log->offsetof_true_size = 0;
+		if (size_common >= offsetofend(struct bpf_common_attr, log_true_size))
+			log->offsetof_true_size = offsetof(struct bpf_common_attr, log_true_size);
+	}
 	return 0;
 }
 
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index b560dab9bfa8..1eb15a51c7dc 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -6270,7 +6270,8 @@ static int __sys_bpf(enum bpf_cmd cmd, bpfptr_t uattr, unsigned int size,
 		if (size >= offsetofend(union bpf_attr, log_true_size))
 			offsetof_log_true_size = offsetof(union bpf_attr, log_true_size);
 		err = bpf_log_attr_init(&attr_log, attr.log_buf, attr.log_size, attr.log_level,
-					offsetof_log_true_size, uattr);
+					offsetof_log_true_size, uattr, &attr_common, uattr_common,
+					size_common);
 		err = err ?: bpf_prog_load(&attr, uattr, &attr_log);
 		break;
 	case BPF_OBJ_PIN:
-- 
2.53.0



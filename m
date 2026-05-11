Return-Path: <linux-api+bounces-6303-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sDGAEVz3AWqcmwEAu9opvQ
	(envelope-from <linux-api+bounces-6303-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Mon, 11 May 2026 17:35:56 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D7ABE5114BA
	for <lists+linux-api@lfdr.de>; Mon, 11 May 2026 17:35:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 37D7C308D19E
	for <lists+linux-api@lfdr.de>; Mon, 11 May 2026 15:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 602703D75C9;
	Mon, 11 May 2026 15:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XaoAYkAH"
X-Original-To: linux-api@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 572053BD241
	for <linux-api@vger.kernel.org>; Mon, 11 May 2026 15:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778513388; cv=none; b=YHsoGMLeHeJECuA6UBJ9SWnpnmgaJHTz/urNIt6m0v1QwnGr2DBo6bg+uaf3Jy3gpx53QrWOlzprlL16uAN5A58CRG1TE4m8qelX1c3+B9yeFic15QzzMi834dSxR12pw4Z09e+uTfc2RJcemLKYtpsrtVBw6tqMfQP3hv493Ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778513388; c=relaxed/simple;
	bh=QrIsoAFbDIw8/pbQk7nL2y2LJnuOWypRgy6XsFN9FFM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S4p/cVamW+oHcZc+14rZXKiETAGASCKHvg77nXAE/SUXYvqnsDuBurdbAbDB+P23nj61sUqByPIsj28/lyH1ItZaEzFROQB1EFyL4pAoa+R+ChSwEQj9qmIw6bV3A/KDCACo29+WMCC2KMVL7ZDwDKiMAcWChzW1BUzOfdJEFy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XaoAYkAH; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778513383;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QieqiYnkH52tJL/Berm7adx8M9q6M+/mk7yLpZSWToI=;
	b=XaoAYkAHgYvefDERIgiKLtRDYt8LNvI9pzeahGrguTxzHPvPVn0rmGlWYoDdxYOOCX4Yw2
	Zbyz+4BKqpnY76mRs92hfWfFLft6+bU2rRiT/EqJLhgrE4qaHaqesHyYvwNDo5E0Hgoimn
	JexrsE5u9mAVOt3dv6xpxdkxVAfkSvQ=
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
Subject: [PATCH bpf-next v13 4/8] bpf: Add syscall common attributes support for prog_load
Date: Mon, 11 May 2026 23:28:13 +0800
Message-ID: <20260511152817.89191-5-leon.hwang@linux.dev>
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
X-Rspamd-Queue-Id: D7ABE5114BA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,gmail.com,linux.dev,fomichev.me,google.com,amazon.com,redhat.com,meta.com,cestc.cn,vger.kernel.org,fb.com];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_TWELVE(0.00)[31];
	TAGGED_FROM(0.00)[bounces-6303-lists,linux-api=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-api];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,linux.dev:mid,linux.dev:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

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
index 8d27ad1f9f94..8433430dedb7 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -764,7 +764,8 @@ struct bpf_log_attr {
 };
 
 int bpf_log_attr_init(struct bpf_log_attr *log, u64 log_buf, u32 log_size, u32 log_level,
-		      u32 offsetof_log_true_size, bpfptr_t uattr);
+		      u32 offsetof_log_true_size, bpfptr_t uattr, struct bpf_common_attr *common,
+		      bpfptr_t uattr_common, u32 size_common);
 int bpf_log_attr_finalize(struct bpf_log_attr *attr, struct bpf_verifier_log *log);
 
 #define BPF_MAX_SUBPROGS 256
diff --git a/kernel/bpf/log.c b/kernel/bpf/log.c
index 1b1efe75398b..fd12ad5a0338 100644
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
@@ -827,16 +827,36 @@ void print_insn_state(struct bpf_verifier_env *env, const struct bpf_verifier_st
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
index 70b78ddcdedb..db893cae826c 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -6271,7 +6271,8 @@ static int __sys_bpf(enum bpf_cmd cmd, bpfptr_t uattr, unsigned int size,
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
2.54.0



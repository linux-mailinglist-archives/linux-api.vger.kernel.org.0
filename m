Return-Path: <linux-api+bounces-5825-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AG/LJOqcjGmPrgAAu9opvQ
	(envelope-from <linux-api+bounces-5825-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Wed, 11 Feb 2026 16:14:50 +0100
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 35F8112583C
	for <lists+linux-api@lfdr.de>; Wed, 11 Feb 2026 16:14:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 52FB73028829
	for <lists+linux-api@lfdr.de>; Wed, 11 Feb 2026 15:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5E8E2C237F;
	Wed, 11 Feb 2026 15:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lZdEwBuA"
X-Original-To: linux-api@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F3A22C08D0
	for <linux-api@vger.kernel.org>; Wed, 11 Feb 2026 15:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770822789; cv=none; b=ZAN7zUVcyuIMWvp0gKOL0w54+upDkfH6HToXIZjA356HyIolkLyPlo6Ti1c7F/Xm7mPuM7EFB4tcne34KBdww5q2Ni3kFyMDtoQrce9SMNwhTr1uJJYdEjjYR7kYImQNzrmGaw+HsiF/4sUuZhMArYK/qKD3LKbQJdogl5p2704=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770822789; c=relaxed/simple;
	bh=lthvPF/ml1r5EnR/35ExbPQFTtQQwu4vZfopkXTIPh4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ScK/4c2hoTq4J5LWtFHz253fz8pjEE4rgOOjPnZzWMNUzOB93aPtcRci0pta3jO4aroPxDz+xwtCnJA55HAVTjINRUC5tZZv4Pirc7UkXIRLB/6n4rUxMAJi8ACNbnyHLxxt3NVXuTI6bSb/smrLkfG5/qlPW1m0lBspgp30BlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lZdEwBuA; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770822785;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TBLB0j6NUT8VMW7VzB6bsjT1W7Y7IEGuaG2IDwLBHbk=;
	b=lZdEwBuAPEFhjY7hYEYui7erBbRIJSOcg2rRkbw/hHOQ2NAiRmHOVPeJy+nuGW7R1tBuVd
	spADLNm9GIRNPpCit6aTs1MBIOF9VBKe8I2QkcFPJGhlHlLB0BMLikT4PE3M8WCYTz5qNL
	0PppPaIz5v1jsvTQVgKWwxiO95+uf7c=
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
Subject: [PATCH bpf-next v10 4/8] bpf: Add syscall common attributes support for prog_load
Date: Wed, 11 Feb 2026 23:11:11 +0800
Message-ID: <20260211151115.78013-5-leon.hwang@linux.dev>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[31];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-5825-lists,linux-api=lfdr.de];
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
X-Rspamd-Queue-Id: 35F8112583C
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
 kernel/bpf/log.c             | 31 ++++++++++++++++++++++++++++++-
 kernel/bpf/syscall.c         |  2 +-
 3 files changed, 33 insertions(+), 3 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index dbd9bdb955b3..34f28d40022a 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -643,7 +643,8 @@ struct bpf_log_attr {
 };
 
 int bpf_log_attr_init(struct bpf_log_attr *log, u64 log_buf, u32 log_size, u32 log_level,
-		      u32 __user *log_true_size);
+		      u32 __user *log_true_size, struct bpf_common_attr *common, bpfptr_t uattr,
+		      u32 size);
 int bpf_log_attr_finalize(struct bpf_log_attr *attr, struct bpf_verifier_log *log);
 
 #define BPF_MAX_SUBPROGS 256
diff --git a/kernel/bpf/log.c b/kernel/bpf/log.c
index e31747b84fe2..a2b41bf5e9cb 100644
--- a/kernel/bpf/log.c
+++ b/kernel/bpf/log.c
@@ -864,14 +864,43 @@ void print_insn_state(struct bpf_verifier_env *env, const struct bpf_verifier_st
 	print_verifier_state(env, vstate, frameno, false);
 }
 
+static bool bpf_log_attrs_set(u64 log_buf, u32 log_size, u32 log_level)
+{
+	return log_buf && log_size && log_level;
+}
+
+static bool bpf_log_attrs_diff(struct bpf_common_attr *common, u64 log_buf, u32 log_size,
+			       u32 log_level)
+{
+	return bpf_log_attrs_set(log_buf, log_size, log_level) &&
+		bpf_log_attrs_set(common->log_buf, common->log_size, common->log_level) &&
+		(log_buf != common->log_buf || log_size != common->log_size ||
+		 log_level != common->log_level);
+}
+
 int bpf_log_attr_init(struct bpf_log_attr *log, u64 log_buf, u32 log_size, u32 log_level,
-		      u32 __user *log_true_size)
+		      u32 __user *log_true_size, struct bpf_common_attr *common, bpfptr_t uattr,
+		      u32 size)
 {
+	if (bpf_log_attrs_diff(common, log_buf, log_size, log_level))
+		return -EINVAL;
+
 	memset(log, 0, sizeof(*log));
 	log->log_buf = u64_to_user_ptr(log_buf);
 	log->log_size = log_size;
 	log->log_level = log_level;
 	log->log_true_size = log_true_size;
+
+	if (!log_buf && common->log_buf) {
+		log->log_buf = u64_to_user_ptr(common->log_buf);
+		log->log_size = common->log_size;
+		log->log_level = common->log_level;
+		if (size >= offsetofend(struct bpf_common_attr, log_true_size))
+			log->log_true_size = uattr.user +
+				offsetof(struct bpf_common_attr, log_true_size);
+		else
+			log->log_true_size = NULL;
+	}
 	return 0;
 }
 
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index e86674811996..17116603ff51 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -6247,7 +6247,7 @@ static int __sys_bpf(enum bpf_cmd cmd, bpfptr_t uattr, unsigned int size,
 		if (from_user && size >= offsetofend(union bpf_attr, log_true_size))
 			log_true_size = uattr.user + offsetof(union bpf_attr, log_true_size);
 		err = bpf_log_attr_init(&attr_log, attr.log_buf, attr.log_size, attr.log_level,
-					log_true_size);
+					log_true_size, &attr_common, uattr_common, size_common);
 		err = err ?: bpf_prog_load(&attr, uattr, &attr_log);
 		break;
 	case BPF_OBJ_PIN:
-- 
2.52.0



Return-Path: <linux-api+bounces-5791-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QGZoBSS6gGl3AgMAu9opvQ
	(envelope-from <linux-api+bounces-5791-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Mon, 02 Feb 2026 15:52:20 +0100
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AC10ACDA46
	for <lists+linux-api@lfdr.de>; Mon, 02 Feb 2026 15:52:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D6BF1302768C
	for <lists+linux-api@lfdr.de>; Mon,  2 Feb 2026 14:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7948736E46E;
	Mon,  2 Feb 2026 14:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZYUOd2vO"
X-Original-To: linux-api@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 122B236CDFA
	for <linux-api@vger.kernel.org>; Mon,  2 Feb 2026 14:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770043365; cv=none; b=oPQ6yK8fZ/F9abjBUPtUPXs+x0zCzLClNOvCA5D9B9K+CkGQkhA8HcicW6DWTJFTokA4keHLdE0aiyNkAgW9s82NzkP9dYKrwLLAvP7DIALLMdGJBxDoKKx2Esr9Lr/nKgi14KeVtkifbsGHCz4gC+f7jFDCNoSia7hncSr0TA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770043365; c=relaxed/simple;
	bh=DOE7kaq+YsBgs3BwWvd+pFxQeWCaAg9/JVuTk9RVsb0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tB4pawMAYsz8u3Gt8i/PaRSQeIfvl/ukxZMKrV6xGCuE6XhaIhZypUNZ8IQKleqfRQ66fTsPRT5suHX2QNormQcfx1MGM6CskjGQoemxPDcxjKvGqS9yRGb/H75NgEmdIZuZDkSAuSwgbK/YBb1RHEePt/HnlMYF/3EvY7qrMLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZYUOd2vO; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770043359;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JDqAozipUsrJaKHI0sk8XceuK1Rr2jyBiEFvHQN2kjg=;
	b=ZYUOd2vOwXkSO4tMHv56WeHY/ygcnYI80DKn1bfNvNrn+q1Jk33WrLQmpRZ0U5ofod1jOb
	zZGZHLBWZAYYrpMfEwoyRLiKNlDbcFcUwaiGeN1hACt5Je3pRA6N6s8wJBWnC8oWxcYD/t
	/X3Zt5egCIv3hrAESEkpWuI0vwMry7k=
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
Subject: [PATCH bpf-next v9 6/9] bpf: Add syscall common attributes support for btf_load
Date: Mon,  2 Feb 2026 22:40:43 +0800
Message-ID: <20260202144046.30651-7-leon.hwang@linux.dev>
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
	TAGGED_FROM(0.00)[bounces-5791-lists,linux-api=lfdr.de];
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
X-Rspamd-Queue-Id: AC10ACDA46
X-Rspamd-Action: no action

BPF_BTF_LOAD can now provide log parameters through both union bpf_attr
and bpf_common_attr. Apply the same conflict and precedence rules as
prog_load:

- if both are provided and btf_log_buf/btf_log_size/btf_log_level match,
  use them;
- if only one side provides a log buffer, use that one;
- if both provide log buffers but differ, return -EINVAL.

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 include/linux/bpf_verifier.h |  3 ++-
 kernel/bpf/log.c             | 18 ++++++++++++++++--
 kernel/bpf/syscall.c         |  3 ++-
 3 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index b6e33ee82f63..1144657bbc2f 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -641,7 +641,8 @@ int bpf_prog_load_log_attr_init(struct bpf_log_attr *attr_log, union bpf_attr *a
 				bpfptr_t uattr, u32 size, struct bpf_common_attr *attr_common,
 				bpfptr_t uattr_common, u32 size_common);
 int bpf_btf_load_log_attr_init(struct bpf_log_attr *attr_log, union bpf_attr *attr,
-			       bpfptr_t uattr, u32 size);
+			       bpfptr_t uattr, u32 size, struct bpf_common_attr *attr_common,
+			       bpfptr_t uattr_common, u32 size_common);
 int bpf_log_attr_finalize(struct bpf_log_attr *attr, struct bpf_verifier_log *log);
 
 #define BPF_MAX_SUBPROGS 256
diff --git a/kernel/bpf/log.c b/kernel/bpf/log.c
index 8ad88e4aa12c..db2716586f85 100644
--- a/kernel/bpf/log.c
+++ b/kernel/bpf/log.c
@@ -901,9 +901,23 @@ int bpf_prog_load_log_attr_init(struct bpf_log_attr *attr_log, union bpf_attr *a
 }
 
 int bpf_btf_load_log_attr_init(struct bpf_log_attr *attr_log, union bpf_attr *attr,
-			       bpfptr_t uattr, u32 size)
+			       bpfptr_t uattr, u32 size, struct bpf_common_attr *attr_common,
+			       bpfptr_t uattr_common, u32 size_common)
 {
-	bpf_log_attr_init(attr_log, offsetof(union bpf_attr, btf_log_true_size), uattr, size);
+	if (bpf_log_attrs_diff(attr_common, attr->btf_log_buf, attr->btf_log_size,
+			       attr->btf_log_level))
+		return -EINVAL;
+
+	if (!attr->btf_log_buf && attr_common->log_buf) {
+		attr->btf_log_buf = attr_common->log_buf;
+		attr->btf_log_size = attr_common->log_size;
+		attr->btf_log_level = attr_common->log_level;
+		bpf_log_attr_init(attr_log, offsetof(struct bpf_common_attr, log_true_size),
+				  uattr_common, size_common);
+	} else {
+		bpf_log_attr_init(attr_log, offsetof(union bpf_attr, btf_log_true_size), uattr,
+				  size);
+	}
 	return 0;
 }
 
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index b6e4ec641dc1..4a8933c1dd38 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -6279,7 +6279,8 @@ static int __sys_bpf(enum bpf_cmd cmd, bpfptr_t uattr, unsigned int size,
 		err = bpf_raw_tracepoint_open(&attr);
 		break;
 	case BPF_BTF_LOAD:
-		err = bpf_btf_load_log_attr_init(&attr_log, &attr, uattr, size);
+		err = bpf_btf_load_log_attr_init(&attr_log, &attr, uattr, size, &attr_common,
+						 uattr_common, size_common);
 		err = err ?: bpf_btf_load(&attr, uattr, &attr_log);
 		break;
 	case BPF_BTF_GET_FD_BY_ID:
-- 
2.52.0



Return-Path: <linux-api+bounces-5789-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mHjRE7y4gGl3AgMAu9opvQ
	(envelope-from <linux-api+bounces-5789-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Mon, 02 Feb 2026 15:46:20 +0100
X-Original-To: lists+linux-api@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C53CDCD8D4
	for <lists+linux-api@lfdr.de>; Mon, 02 Feb 2026 15:46:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9ED86306FBD3
	for <lists+linux-api@lfdr.de>; Mon,  2 Feb 2026 14:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C69B371058;
	Mon,  2 Feb 2026 14:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="A5Hy1nmO"
X-Original-To: linux-api@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB7A836CE08
	for <linux-api@vger.kernel.org>; Mon,  2 Feb 2026 14:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770043331; cv=none; b=uLV0+XDxQd4R5mFnWY5RTuPc3++5LUDEPu2tJuQLsbClMnsyKkbvm4tyXKcRScoGMbZZPgKF4sy0hTV0QgcSLonDZgSoXNACf+dGKj4Pj8P8I8u2i225IU9tmv2PEFjw/uCV0ZU74/F8CZufYNVSmvRwi6Vptaqh3SPW61kQVgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770043331; c=relaxed/simple;
	bh=2y0OYhFd00JT4fqJ7xOW3+N3GZskK/O/58Ra1R2Dofg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ulFYew2EnLLfQcNBj/DBXjhYqo9+Y/cvu+cj9cIO/HqPM8jhD1q1LmOhJOBUdH1kj6eAXMmEJUPBxVcDqduqNPiqY7/OiuTvOEwGsT1JrISFZRV+mEJACuWl0qCkIdHE0vZV7bw5AnaxPgi6CQcJMLLu6wVzmZQ5BYvpbl8yhNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=A5Hy1nmO; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770043326;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tld7ROmAyVXWaOhOfuRbQu/FqLENM5A62rTK6vgYo1c=;
	b=A5Hy1nmOsxosHhLcdOHZTH+IG29NSbdsOUPBglUYFlSH2jNgtZvhWFC/Sfb8BMwl3aWQuC
	K3oQgwf3/eFycT4bLykFdYUYhBOgV/5Db5GcEEqjI2d/YKp+lEo5QMvC7xhvC3xXv8iIJY
	+DXDo18xyxA663tFcTT8teldFDOyCOg=
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
Subject: [PATCH bpf-next v9 4/9] bpf: Add syscall common attributes support for prog_load
Date: Mon,  2 Feb 2026 22:40:41 +0800
Message-ID: <20260202144046.30651-5-leon.hwang@linux.dev>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,gmail.com,linux.dev,fomichev.me,google.com,amazon.com,redhat.com,meta.com,cestc.cn,vger.kernel.org,fb.com];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_TWELVE(0.00)[31];
	TAGGED_FROM(0.00)[bounces-5789-lists,linux-api=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-api];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,linux.dev:dkim,linux.dev:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C53CDCD8D4
X-Rspamd-Action: no action

BPF_PROG_LOAD can now provide log parameters through both union bpf_attr
and struct bpf_common_attr. Define clear conflict and precedence rules:

- if both are provided and log_buf/log_size/log_level match, use them;
- if only one side provides a log buffer, use that one;
- if both provide log buffers but differ, return -EINVAL.

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 include/linux/bpf_verifier.h |  3 ++-
 kernel/bpf/log.c             | 24 ++++++++++++++++++++++--
 kernel/bpf/syscall.c         |  3 ++-
 3 files changed, 26 insertions(+), 4 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index c805b85b6f7a..0d106fddbbc5 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -638,7 +638,8 @@ struct bpf_log_attr {
 };
 
 int bpf_prog_load_log_attr_init(struct bpf_log_attr *attr_log, union bpf_attr *attr,
-				bpfptr_t uattr, u32 size);
+				bpfptr_t uattr, u32 size, struct bpf_common_attr *attr_common,
+				bpfptr_t uattr_common, u32 size_common);
 int bpf_log_attr_finalize(struct bpf_log_attr *attr, struct bpf_verifier_log *log);
 
 #define BPF_MAX_SUBPROGS 256
diff --git a/kernel/bpf/log.c b/kernel/bpf/log.c
index ff579fcba36f..345005ba98dd 100644
--- a/kernel/bpf/log.c
+++ b/kernel/bpf/log.c
@@ -873,10 +873,30 @@ static void bpf_log_attr_init(struct bpf_log_attr *attr_log, int offsetof_true_s
 	attr_log->uattr = uattr;
 }
 
+static bool bpf_log_attrs_diff(struct bpf_common_attr *common, u64 log_buf, u32 log_size,
+			       u32 log_level)
+{
+	return log_buf && common->log_buf && (log_buf != common->log_buf ||
+					      log_size != common->log_size ||
+					      log_level != common->log_level);
+}
+
 int bpf_prog_load_log_attr_init(struct bpf_log_attr *attr_log, union bpf_attr *attr,
-				bpfptr_t uattr, u32 size)
+				bpfptr_t uattr, u32 size, struct bpf_common_attr *attr_common,
+				bpfptr_t uattr_common, u32 size_common)
 {
-	bpf_log_attr_init(attr_log, offsetof(union bpf_attr, log_true_size), uattr, size);
+	if (bpf_log_attrs_diff(attr_common, attr->log_buf, attr->log_size, attr->log_level))
+		return -EINVAL;
+
+	if (!attr->log_buf && attr_common->log_buf) {
+		attr->log_buf = attr_common->log_buf;
+		attr->log_size = attr_common->log_size;
+		attr->log_level = attr_common->log_level;
+		bpf_log_attr_init(attr_log, offsetof(struct bpf_common_attr, log_true_size),
+				  uattr_common, size_common);
+	} else {
+		bpf_log_attr_init(attr_log, offsetof(union bpf_attr, log_true_size), uattr, size);
+	}
 	return 0;
 }
 
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index e81199361241..7125ea445c6c 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -6232,7 +6232,8 @@ static int __sys_bpf(enum bpf_cmd cmd, bpfptr_t uattr, unsigned int size,
 		err = map_freeze(&attr);
 		break;
 	case BPF_PROG_LOAD:
-		err = bpf_prog_load_log_attr_init(&attr_log, &attr, uattr, size);
+		err = bpf_prog_load_log_attr_init(&attr_log, &attr, uattr, size, &attr_common,
+						  uattr_common, size_common);
 		err = err ?: bpf_prog_load(&attr, uattr, &attr_log);
 		break;
 	case BPF_OBJ_PIN:
-- 
2.52.0



Return-Path: <linux-api+bounces-5730-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UL3VMKnqcmnQrAAAu9opvQ
	(envelope-from <linux-api+bounces-5730-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Fri, 23 Jan 2026 04:27:37 +0100
X-Original-To: lists+linux-api@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E69B7015E
	for <lists+linux-api@lfdr.de>; Fri, 23 Jan 2026 04:27:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4A2BC301FABC
	for <lists+linux-api@lfdr.de>; Fri, 23 Jan 2026 03:26:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EE8629BD87;
	Fri, 23 Jan 2026 03:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LJ0jBzcU"
X-Original-To: linux-api@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 592EB34FF41
	for <linux-api@vger.kernel.org>; Fri, 23 Jan 2026 03:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769138803; cv=none; b=JVDiw2PIFRSVBXN7cKYOeJ21P+5ruatdK0OQBE+1WyZbVuMc2Sq3M2gGekuiFnavnPLmMl3o2MFlXf/lHKW8p8+RwwbCoavRqVJGzGlFbnNTVomVk9VMFKO1inBcMoGwdaizOE126FI5/y8JHc/iz5uL19XDlznyuHkaSmCgNiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769138803; c=relaxed/simple;
	bh=USSgFhIgNkJkCa3MhLwDzVL9wdU3Z47qDGqjnKZ+GeQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R0+IX/Abb10wR/agB9coV7xqLwxhK8v+g2M/2f5UjIV/fTUyYVFBydogDOwmSeYFcERkVUIrxKgIXgbUyILWSHDSGayMqWsn7nxTh9ZzLg4JF9zI6Q47NMyH6CPF7Gr07Soqb8Ch3xF99x+XVHw/j0tPp4YtxaG+aaTCg5XOhNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LJ0jBzcU; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1769138778;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4oNysg7eRr3NvRmo80BWS1H7XtTEokr9/t7DGX+DMqc=;
	b=LJ0jBzcUnbDsWuiYeK/Gw+Xw3UmsmU3sYL4we9sMddwhse2YXKlcUGwxnm3joRkgHwCAGL
	lXDNc4NrFFGC+i7BL/fIND9yt8I7KhNWIRR92gq+9ke8UbYFb5P9x9jdxmPK0BxKuL8n0S
	52SY1ouZtdJ/UQ09ivF0M21UOD/2YcA=
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
Subject: [PATCH bpf-next v7 4/9] bpf: Add syscall common attributes support for prog_load
Date: Fri, 23 Jan 2026 11:24:40 +0800
Message-ID: <20260123032445.125259-5-leon.hwang@linux.dev>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,gmail.com,linux.dev,fomichev.me,google.com,amazon.com,redhat.com,meta.com,cestc.cn,vger.kernel.org,fb.com];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_TWELVE(0.00)[31];
	TAGGED_FROM(0.00)[bounces-5730-lists,linux-api=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon.hwang@linux.dev,linux-api@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-0.947];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-api];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,linux.dev:dkim,linux.dev:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3E69B7015E
X-Rspamd-Action: no action

The log buffer of common attributes would be confusing with the one in
'union bpf_attr' for BPF_PROG_LOAD.

In order to clarify the usage of these two log buffers, they both can be
used for logging if:

* They are same, including 'log_buf', 'log_level' and 'log_size'.
* One of them is missing, then another one will be used for logging.

If they both have 'log_buf' but they are not same totally, return -EINVAL.

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 include/linux/bpf_verifier.h |  4 +++-
 kernel/bpf/log.c             | 29 ++++++++++++++++++++++++++---
 kernel/bpf/syscall.c         |  9 ++++++---
 3 files changed, 35 insertions(+), 7 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 4a0c5ef296b9..7eb024e83d2d 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -637,9 +637,11 @@ struct bpf_log_attr {
 	u32 log_level;
 	struct bpf_attrs *attrs;
 	u32 offsetof_log_true_size;
+	struct bpf_attrs *attrs_common;
 };
 
-int bpf_prog_load_log_attr_init(struct bpf_log_attr *log_attr, struct bpf_attrs *attrs);
+int bpf_prog_load_log_attr_init(struct bpf_log_attr *log_attr, struct bpf_attrs *attrs,
+				struct bpf_attrs *attrs_common);
 int bpf_log_attr_finalize(struct bpf_log_attr *log_attr, struct bpf_verifier_log *log);
 
 #define BPF_MAX_SUBPROGS 256
diff --git a/kernel/bpf/log.c b/kernel/bpf/log.c
index 457b724c4176..c0b816e84384 100644
--- a/kernel/bpf/log.c
+++ b/kernel/bpf/log.c
@@ -865,23 +865,41 @@ void print_insn_state(struct bpf_verifier_env *env, const struct bpf_verifier_st
 }
 
 static int bpf_log_attr_init(struct bpf_log_attr *log_attr, struct bpf_attrs *attrs, u64 log_buf,
-			     u32 log_size, u32 log_level, int offsetof_log_true_size)
+			     u32 log_size, u32 log_level, int offsetof_log_true_size,
+			     struct bpf_attrs *attrs_common)
 {
+	const struct bpf_common_attr *common = attrs_common ? attrs_common->attr : NULL;
+
 	memset(log_attr, 0, sizeof(*log_attr));
 	log_attr->log_buf = log_buf;
 	log_attr->log_size = log_size;
 	log_attr->log_level = log_level;
 	log_attr->attrs = attrs;
 	log_attr->offsetof_log_true_size = offsetof_log_true_size;
+	log_attr->attrs_common = attrs_common;
+
+	if (log_buf && common && common->log_buf &&
+		(log_buf != common->log_buf ||
+		 log_size != common->log_size ||
+		 log_level != common->log_level))
+		return -EINVAL;
+
+	if (!log_buf && common && common->log_buf) {
+		log_attr->log_buf = common->log_buf;
+		log_attr->log_size = common->log_size;
+		log_attr->log_level = common->log_level;
+	}
+
 	return 0;
 }
 
-int bpf_prog_load_log_attr_init(struct bpf_log_attr *log_attr, struct bpf_attrs *attrs)
+int bpf_prog_load_log_attr_init(struct bpf_log_attr *log_attr, struct bpf_attrs *attrs,
+				struct bpf_attrs *attrs_common)
 {
 	const union bpf_attr *attr = attrs->attr;
 
 	return bpf_log_attr_init(log_attr, attrs, attr->log_buf, attr->log_size, attr->log_level,
-				 offsetof(union bpf_attr, log_true_size));
+				 offsetof(union bpf_attr, log_true_size), attrs_common);
 }
 
 int bpf_log_attr_finalize(struct bpf_log_attr *log_attr, struct bpf_verifier_log *log)
@@ -901,5 +919,10 @@ int bpf_log_attr_finalize(struct bpf_log_attr *log_attr, struct bpf_verifier_log
 	    copy_to_bpfptr_offset(log_attr->attrs->uattr, off, &log_true_size, size))
 		err = -EFAULT;
 
+	off = offsetof(struct bpf_common_attr, log_true_size);
+	if (log_attr->attrs_common && log_attr->attrs_common->size >= off + size &&
+	    copy_to_bpfptr_offset(log_attr->attrs_common->uattr, off, &log_true_size, size))
+		err = -EFAULT;
+
 	return err;
 }
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 8468baf545c5..8f3e489667d7 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -2865,7 +2865,8 @@ static int bpf_prog_mark_insn_arrays_ready(struct bpf_prog *prog)
 /* last field in 'union bpf_attr' used by this command */
 #define BPF_PROG_LOAD_LAST_FIELD keyring_id
 
-static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr, u32 uattr_size)
+static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr, u32 uattr_size,
+			 struct bpf_attrs *attrs_common)
 {
 	enum bpf_prog_type type = attr->prog_type;
 	struct bpf_prog *prog, *dst_prog = NULL;
@@ -3085,7 +3086,7 @@ static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr, u32 uattr_size)
 		goto free_prog_sec;
 
 	bpf_attrs_init(&attrs, attr, uattr, uattr_size);
-	err = bpf_prog_load_log_attr_init(&log_attr, &attrs);
+	err = bpf_prog_load_log_attr_init(&log_attr, &attrs, attrs_common);
 	if (err < 0)
 		goto free_used_maps;
 
@@ -6174,6 +6175,7 @@ static int __sys_bpf(enum bpf_cmd cmd, bpfptr_t uattr, unsigned int size,
 		     bpfptr_t uattr_common, unsigned int size_common)
 {
 	struct bpf_common_attr attr_common;
+	struct bpf_attrs attrs_common;
 	union bpf_attr attr;
 	int err;
 
@@ -6225,7 +6227,8 @@ static int __sys_bpf(enum bpf_cmd cmd, bpfptr_t uattr, unsigned int size,
 		err = map_freeze(&attr);
 		break;
 	case BPF_PROG_LOAD:
-		err = bpf_prog_load(&attr, uattr, size);
+		bpf_attrs_init(&attrs_common, &attr_common, uattr_common, size_common);
+		err = bpf_prog_load(&attr, uattr, size, &attrs_common);
 		break;
 	case BPF_OBJ_PIN:
 		err = bpf_obj_pin(&attr);
-- 
2.52.0



Return-Path: <linux-api+bounces-5828-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gK0SLsGcjGmPrgAAu9opvQ
	(envelope-from <linux-api+bounces-5828-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Wed, 11 Feb 2026 16:14:09 +0100
X-Original-To: lists+linux-api@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 73AC2125811
	for <lists+linux-api@lfdr.de>; Wed, 11 Feb 2026 16:14:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B3B6C300613A
	for <lists+linux-api@lfdr.de>; Wed, 11 Feb 2026 15:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 748CB2D47EE;
	Wed, 11 Feb 2026 15:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="RvszaWut"
X-Original-To: linux-api@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B742C2C11E1
	for <linux-api@vger.kernel.org>; Wed, 11 Feb 2026 15:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770822847; cv=none; b=Kon9ZdYTmqOHR1oPLv78Q20SAYMChHSiGSfpuXtCh5DtsASWECP+yaODohDhsGwXRjR0uF3dXlwB3lwk1MtvDW041yAvrPYxBJwFiYTK04cMg5v0NZEsKGakYRQRD3Uh2wtcPjQKAmbrOemQ5dCxYoMPKybJ5+7iGCo7CV8oGcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770822847; c=relaxed/simple;
	bh=gnEMOtd8FWF1Mm8F80lXlNVgFhdShhiT2kKRS5dMM8c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zn7v83O3GsM+Cjbn+RbO7Mo10Tg6Zd2kVsHoxFgUheszFC8e7d6IK88+HaUwuFPxdAirqsI0QfnP2Vz6Z+Ban94beJp7BIO2QNKNLF/dvjfGFYPgNidOZwayG3jerLe5dQTVISZQpSx4KvEpmsmW0z6KSznGrLynnXh3WqUg3/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=RvszaWut; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770822842;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WEd1Tu6pzCQjp2hnQoKiK4JRxMafdGLudagS7tdkGr4=;
	b=RvszaWutwelRYGbPptNYWBQBsi2lb/jXpd8yhcWvs/LnCsb2gFvMisGfWlpsm2Pn1WN3oG
	akbPSzsaecHgEPsMHJtn2jlO8HBy1hqIyF0YCuAE+HoXSESLsG5zp3n1GlTg07toBFueUI
	fVJgykLXo11u5Rr8gYGF1R5CkMc4Vp8=
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
Subject: [PATCH bpf-next v10 7/8] libbpf: Add syscall common attributes support for map_create
Date: Wed, 11 Feb 2026 23:11:14 +0800
Message-ID: <20260211151115.78013-8-leon.hwang@linux.dev>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[31];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-5828-lists,linux-api=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,gmail.com,linux.dev,fomichev.me,google.com,amazon.com,redhat.com,meta.com,cestc.cn,vger.kernel.org,fb.com];
	DKIM_TRACE(0.00)[linux.dev:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon.hwang@linux.dev,linux-api@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-api];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:mid,linux.dev:dkim,linux.dev:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 73AC2125811
X-Rspamd-Action: no action

With the previous commit adding common attribute support for
BPF_MAP_CREATE, users can now retrieve detailed error messages when map
creation fails via the log_buf field.

Introduce struct bpf_log_opts with the following fields:
log_buf, log_size, log_level, and log_true_size.

Extend bpf_map_create_opts with a new field log_opts, allowing users to
capture and inspect log messages on map creation failures.

Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 tools/lib/bpf/bpf.c | 16 +++++++++++++++-
 tools/lib/bpf/bpf.h | 17 ++++++++++++++++-
 2 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index 9d8740761b7a..0c3e40844d80 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -209,6 +209,9 @@ int bpf_map_create(enum bpf_map_type map_type,
 		   const struct bpf_map_create_opts *opts)
 {
 	const size_t attr_sz = offsetofend(union bpf_attr, excl_prog_hash_size);
+	const size_t attr_common_sz = sizeof(struct bpf_common_attr);
+	struct bpf_common_attr attr_common;
+	struct bpf_log_opts *log_opts;
 	union bpf_attr attr;
 	int fd;
 
@@ -242,7 +245,18 @@ int bpf_map_create(enum bpf_map_type map_type,
 	attr.excl_prog_hash = ptr_to_u64(OPTS_GET(opts, excl_prog_hash, NULL));
 	attr.excl_prog_hash_size = OPTS_GET(opts, excl_prog_hash_size, 0);
 
-	fd = sys_bpf_fd(BPF_MAP_CREATE, &attr, attr_sz);
+	log_opts = OPTS_GET(opts, log_opts, NULL);
+	if (log_opts && feat_supported(NULL, FEAT_BPF_SYSCALL_COMMON_ATTRS)) {
+		memset(&attr_common, 0, attr_common_sz);
+		attr_common.log_buf = ptr_to_u64(OPTS_GET(log_opts, log_buf, NULL));
+		attr_common.log_size = OPTS_GET(log_opts, log_size, 0);
+		attr_common.log_level = OPTS_GET(log_opts, log_level, 0);
+		fd = sys_bpf_ext_fd(BPF_MAP_CREATE, &attr, attr_sz, &attr_common, attr_common_sz);
+		OPTS_SET(log_opts, log_true_size, attr_common.log_true_size);
+	} else {
+		fd = sys_bpf_fd(BPF_MAP_CREATE, &attr, attr_sz);
+		OPTS_SET(log_opts, log_true_size, 0);
+	}
 	return libbpf_err_errno(fd);
 }
 
diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
index 2c8e88ddb674..db834f09799e 100644
--- a/tools/lib/bpf/bpf.h
+++ b/tools/lib/bpf/bpf.h
@@ -37,6 +37,18 @@ extern "C" {
 
 LIBBPF_API int libbpf_set_memlock_rlim(size_t memlock_bytes);
 
+struct bpf_log_opts {
+	size_t sz; /* size of this struct for forward/backward compatibility */
+
+	char *log_buf;
+	__u32 log_size;
+	__u32 log_level;
+	__u32 log_true_size; /* out parameter set by kernel */
+
+	size_t :0;
+};
+#define bpf_log_opts__last_field log_true_size
+
 struct bpf_map_create_opts {
 	size_t sz; /* size of this struct for forward/backward compatibility */
 
@@ -57,9 +69,12 @@ struct bpf_map_create_opts {
 
 	const void *excl_prog_hash;
 	__u32 excl_prog_hash_size;
+
+	struct bpf_log_opts *log_opts;
+
 	size_t :0;
 };
-#define bpf_map_create_opts__last_field excl_prog_hash_size
+#define bpf_map_create_opts__last_field log_opts
 
 LIBBPF_API int bpf_map_create(enum bpf_map_type map_type,
 			      const char *map_name,
-- 
2.52.0



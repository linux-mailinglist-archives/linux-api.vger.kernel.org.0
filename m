Return-Path: <linux-api+bounces-6324-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MAcvFzRQA2pQ4QEAu9opvQ
	(envelope-from <linux-api+bounces-6324-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Tue, 12 May 2026 18:07:16 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 44D58524585
	for <lists+linux-api@lfdr.de>; Tue, 12 May 2026 18:07:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A3A3B3319AA2
	for <lists+linux-api@lfdr.de>; Tue, 12 May 2026 15:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 000763C3789;
	Tue, 12 May 2026 15:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BYTVz4cP"
X-Original-To: linux-api@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB4F3C1F37
	for <linux-api@vger.kernel.org>; Tue, 12 May 2026 15:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778600145; cv=none; b=OgY/G1AsyuLu2dbFdnb86KDfbkgF3AWGcviIskL+6v3SR5Wgzl2LxMZGuq15e/7SbzERJ/StZtTDS/UUnTpM2gsHmgkppl8eNAe8i4esK50o7oihm0CDZiAqnqdo61e0/xBAEb51dwyhuoo+k0EbRiBvpXb/ysWz/eM6797WBQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778600145; c=relaxed/simple;
	bh=sfKJZJ8ctcHAZCmfJQeymzJppmwIwJF9EO7P/NWJ/hQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q9U+PLyvipFwvIQvo4uGbYQbE9b5tTMzof/OSyooSuEjXHCAYAlMHWjSHAi1C+A31QXolFAggVYqY7djbwTotwO9xt59zd4VQS+5rL4OtuUcpdjLwIavADDXxfjRvr6KER8QMny4LJSYABGGFiExSft1zgeWGlI578PFlgpFIrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BYTVz4cP; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778600141;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UBCKOVce/S8UBOdaCxeu/letmftudNtjxh9CrdzjR3Q=;
	b=BYTVz4cPGcS6uiTu9C01WMSOS974p3UXQSRUMp09PpEczxCZHg1Qnu6EF85z0M0pDnaftR
	u36M32U8r9YomhO5JzaEQe4WPbIJLuH+HaF9dd3Bci9qyX82WYfK86whJTfldhg64wWqUz
	Jr+3rRm5ZvS9m18myqAX9SWeajvPU44=
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
Subject: [PATCH bpf-next v14 8/8] selftests/bpf: Add tests to verify map create failure log
Date: Tue, 12 May 2026 23:31:57 +0800
Message-ID: <20260512153157.28382-9-leon.hwang@linux.dev>
In-Reply-To: <20260512153157.28382-1-leon.hwang@linux.dev>
References: <20260512153157.28382-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: 44D58524585
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
	TAGGED_FROM(0.00)[bounces-6324-lists,linux-api=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon.hwang@linux.dev,linux-api@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-0.995];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-api];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:email,linux.dev:mid,linux.dev:dkim]
X-Rspamd-Action: no action

Add tests to verify that the kernel reports the expected error messages
and correct log_true_size when map creation fails.

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 .../selftests/bpf/prog_tests/map_init.c       | 166 ++++++++++++++++++
 1 file changed, 166 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/map_init.c b/tools/testing/selftests/bpf/prog_tests/map_init.c
index 14a31109dd0e..5c61c8e37306 100644
--- a/tools/testing/selftests/bpf/prog_tests/map_init.c
+++ b/tools/testing/selftests/bpf/prog_tests/map_init.c
@@ -212,3 +212,169 @@ void test_map_init(void)
 	if (test__start_subtest("pcpu_lru_map_init"))
 		test_pcpu_lru_map_init();
 }
+
+static void test_map_create(enum bpf_map_type map_type, const char *map_name,
+			    struct bpf_map_create_opts *opts, const char *exp_msg)
+{
+	const int key_size = 4, value_size = 4, max_entries = 1;
+	char log_buf[128];
+	int fd;
+	LIBBPF_OPTS(bpf_log_opts, log_opts);
+
+	log_buf[0] = '\0';
+	log_opts.buf = log_buf;
+	log_opts.size = sizeof(log_buf);
+	log_opts.level = 1;
+	opts->log_opts = &log_opts;
+	fd = bpf_map_create(map_type, map_name, key_size, value_size, max_entries, opts);
+	if (!ASSERT_LT(fd, 0, "bpf_map_create")) {
+		close(fd);
+		return;
+	}
+
+	ASSERT_STREQ(log_buf, exp_msg, "log_buf");
+	ASSERT_EQ(log_opts.true_size, strlen(exp_msg) + 1, "true_size");
+}
+
+static void test_map_create_array(struct bpf_map_create_opts *opts, const char *exp_msg)
+{
+	test_map_create(BPF_MAP_TYPE_ARRAY, "test_map_create", opts, exp_msg);
+}
+
+static void test_invalid_vmlinux_value_type_id_struct_ops(void)
+{
+	const char *msg = "btf_vmlinux_value_type_id can only be used with struct_ops maps.\n";
+	LIBBPF_OPTS(bpf_map_create_opts, opts,
+		    .btf_vmlinux_value_type_id = 1,
+	);
+
+	test_map_create_array(&opts, msg);
+}
+
+static void test_invalid_vmlinux_value_type_id_kv_type_id(void)
+{
+	const char *msg = "btf_vmlinux_value_type_id is mutually exclusive with btf_key_type_id and btf_value_type_id.\n";
+	LIBBPF_OPTS(bpf_map_create_opts, opts,
+		    .btf_vmlinux_value_type_id = 1,
+		    .btf_key_type_id = 1,
+	);
+
+	test_map_create(BPF_MAP_TYPE_STRUCT_OPS, "test_map_create", &opts, msg);
+}
+
+static void test_invalid_value_type_id(void)
+{
+	const char *msg = "Invalid btf_value_type_id.\n";
+	LIBBPF_OPTS(bpf_map_create_opts, opts,
+		    .btf_key_type_id = 1,
+	);
+
+	test_map_create_array(&opts, msg);
+}
+
+static void test_invalid_map_extra(void)
+{
+	const char *msg = "Invalid map_extra.\n";
+	LIBBPF_OPTS(bpf_map_create_opts, opts,
+		    .map_extra = 1,
+	);
+
+	test_map_create_array(&opts, msg);
+}
+
+static void test_invalid_numa_node(void)
+{
+	const char *msg = "Invalid numa_node.\n";
+	LIBBPF_OPTS(bpf_map_create_opts, opts,
+		    .map_flags = BPF_F_NUMA_NODE,
+		    .numa_node = 0xFF,
+	);
+
+	test_map_create_array(&opts, msg);
+}
+
+static void test_invalid_map_type(void)
+{
+	const char *msg = "Invalid map_type.\n";
+	LIBBPF_OPTS(bpf_map_create_opts, opts);
+
+	test_map_create(__MAX_BPF_MAP_TYPE, "test_map_create", &opts, msg);
+}
+
+static void test_invalid_token_fd(void)
+{
+	const char *msg = "Invalid map_token_fd.\n";
+	LIBBPF_OPTS(bpf_map_create_opts, opts,
+		    .map_flags = BPF_F_TOKEN_FD,
+		    .token_fd = 0xFF,
+	);
+
+	test_map_create_array(&opts, msg);
+}
+
+static void test_invalid_map_name(void)
+{
+	const char *msg = "Invalid map_name.\n";
+	LIBBPF_OPTS(bpf_map_create_opts, opts);
+
+	test_map_create(BPF_MAP_TYPE_ARRAY, "test-!@#", &opts, msg);
+}
+
+static void test_invalid_btf_fd(void)
+{
+	const char *msg = "Invalid btf_fd.\n";
+	LIBBPF_OPTS(bpf_map_create_opts, opts,
+		    .btf_fd = -1,
+		    .btf_key_type_id = 1,
+		    .btf_value_type_id = 1,
+	);
+
+	test_map_create_array(&opts, msg);
+}
+
+static void test_excl_prog_hash_size_1(void)
+{
+	const char *msg = "Invalid excl_prog_hash_size.\n";
+	const char *hash = "DEADCODE";
+	LIBBPF_OPTS(bpf_map_create_opts, opts,
+		    .excl_prog_hash = hash,
+	);
+
+	test_map_create_array(&opts, msg);
+}
+
+static void test_excl_prog_hash_size_2(void)
+{
+	const char *msg = "Invalid excl_prog_hash_size.\n";
+	LIBBPF_OPTS(bpf_map_create_opts, opts,
+		    .excl_prog_hash_size = 1,
+	);
+
+	test_map_create_array(&opts, msg);
+}
+
+void test_map_create_failure(void)
+{
+	if (test__start_subtest("invalid_vmlinux_value_type_id_struct_ops"))
+		test_invalid_vmlinux_value_type_id_struct_ops();
+	if (test__start_subtest("invalid_vmlinux_value_type_id_kv_type_id"))
+		test_invalid_vmlinux_value_type_id_kv_type_id();
+	if (test__start_subtest("invalid_value_type_id"))
+		test_invalid_value_type_id();
+	if (test__start_subtest("invalid_map_extra"))
+		test_invalid_map_extra();
+	if (test__start_subtest("invalid_numa_node"))
+		test_invalid_numa_node();
+	if (test__start_subtest("invalid_map_type"))
+		test_invalid_map_type();
+	if (test__start_subtest("invalid_token_fd"))
+		test_invalid_token_fd();
+	if (test__start_subtest("invalid_map_name"))
+		test_invalid_map_name();
+	if (test__start_subtest("invalid_btf_fd"))
+		test_invalid_btf_fd();
+	if (test__start_subtest("invalid_excl_prog_hash_size_1"))
+		test_excl_prog_hash_size_1();
+	if (test__start_subtest("invalid_excl_prog_hash_size_2"))
+		test_excl_prog_hash_size_2();
+}
-- 
2.54.0



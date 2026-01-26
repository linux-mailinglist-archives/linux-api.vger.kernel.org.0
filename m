Return-Path: <linux-api+bounces-5764-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QLxALKqFd2m9hgEAu9opvQ
	(envelope-from <linux-api+bounces-5764-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Mon, 26 Jan 2026 16:18:02 +0100
X-Original-To: lists+linux-api@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D18438A03C
	for <lists+linux-api@lfdr.de>; Mon, 26 Jan 2026 16:18:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9DF50300F1CA
	for <lists+linux-api@lfdr.de>; Mon, 26 Jan 2026 15:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0B8433B96A;
	Mon, 26 Jan 2026 15:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UGIom/7x"
X-Original-To: linux-api@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A68633E371;
	Mon, 26 Jan 2026 15:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769440606; cv=none; b=pSUfNqKl0HKT7wR/c4eXPWwDLRbngRczM7K2VnDjzGU44toWFt0nbrmF8KYuiB37RyfUGctk/pDbo8Tj7CQyFupRVLP9gTRHizurHvp+4h5dtJi1jDbZoNRvHzdQsXpCvU4RqjnhmZW5lPPHGWY+uFttTRQV/xPPbQJWJHaWvxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769440606; c=relaxed/simple;
	bh=lRMaXBCmuroYEA8EMWnl7dKsDl+uPc5spkCIVT8MdKg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Aq5rlv+8FM+sgxgI8hbPAYJVgzm3eMOUum2LSZ7/s/UJCWl/V6I0AwozD8leQx99rmGdJmoPTazeehJMlFVt7eMMjCNbMYqhj2ZXQ5MP06ai2rrOx8iySGlpIbCKPF6eGxI4qTbL+suBU35El24sjqsOyNIWIAAuEVdyCUGYSZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UGIom/7x; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1769440599;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bTUbEhqHJLhG8hIlAVdEqIlik/ffHI3gpe+iOi5xJpk=;
	b=UGIom/7xXk6iuFieLFg0kOOqCgjiSBRXqujSmBg/PrLQFX5hIX6UOOWOhmrm1NkyAdDsWG
	cJFPuOdmzyP/8Utv/2YsmHkiAW+dXPjr1+9Q4HVEbn0oJOZ2iV5q/j0ltzoBOmnZdb54qg
	bfLOXnx2muqc8fiptwdrts+y+29rIKg=
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
Subject: [PATCH bpf-next v8 9/9] selftests/bpf: Add tests to verify map create failure log
Date: Mon, 26 Jan 2026 23:14:09 +0800
Message-ID: <20260126151409.52072-10-leon.hwang@linux.dev>
In-Reply-To: <20260126151409.52072-1-leon.hwang@linux.dev>
References: <20260126151409.52072-1-leon.hwang@linux.dev>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,gmail.com,linux.dev,fomichev.me,google.com,amazon.com,redhat.com,meta.com,cestc.cn,vger.kernel.org,fb.com];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_TWELVE(0.00)[31];
	TAGGED_FROM(0.00)[bounces-5764-lists,linux-api=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon.hwang@linux.dev,linux-api@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-api];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,linux.dev:dkim,linux.dev:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D18438A03C
X-Rspamd-Action: no action

Add tests to verify that the kernel reports the expected error messages
when map creation fails.

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 .../selftests/bpf/prog_tests/map_init.c       | 168 ++++++++++++++++++
 1 file changed, 168 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/map_init.c b/tools/testing/selftests/bpf/prog_tests/map_init.c
index 14a31109dd0e..89e6daf2fcfd 100644
--- a/tools/testing/selftests/bpf/prog_tests/map_init.c
+++ b/tools/testing/selftests/bpf/prog_tests/map_init.c
@@ -212,3 +212,171 @@ void test_map_init(void)
 	if (test__start_subtest("pcpu_lru_map_init"))
 		test_pcpu_lru_map_init();
 }
+
+#define BPF_LOG_FIXED	8
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
+	log_opts.log_buf = log_buf;
+	log_opts.log_size = sizeof(log_buf);
+	log_opts.log_level = BPF_LOG_FIXED;
+	opts->log_opts = &log_opts;
+	fd = bpf_map_create(map_type, map_name, key_size, value_size, max_entries, opts);
+	if (!ASSERT_LT(fd, 0, "bpf_map_create")) {
+		close(fd);
+		return;
+	}
+
+	ASSERT_STREQ(log_buf, exp_msg, "log_buf");
+	ASSERT_EQ(log_opts.log_true_size, strlen(exp_msg) + 1, "log_true_size");
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
2.52.0



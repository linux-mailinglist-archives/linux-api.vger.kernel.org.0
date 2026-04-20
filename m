Return-Path: <linux-api+bounces-6111-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KCJyL4BC5mlutgEAu9opvQ
	(envelope-from <linux-api+bounces-6111-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Mon, 20 Apr 2026 17:13:04 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B52542DE9F
	for <lists+linux-api@lfdr.de>; Mon, 20 Apr 2026 17:13:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1808530D8519
	for <lists+linux-api@lfdr.de>; Mon, 20 Apr 2026 15:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2009C3BE141;
	Mon, 20 Apr 2026 14:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gp/LJD1x"
X-Original-To: linux-api@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 204103BD65A
	for <linux-api@vger.kernel.org>; Mon, 20 Apr 2026 14:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776694726; cv=none; b=BYA7ufqPlkp/RrWcsriyua2QjSGqX/dK7Sb+NM0Sz9FkDxkjKA6eL/2FPnRsMg3CfqwJuWEUBjpxxyeyp3sNeomHgabYfElj3Yj8+gBi0AlQKV+Z0uzDw2Q9EScwpKTezjNQ2Vl69LZt+75WMKx40ecp6NXAHKoRwekngWnSYQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776694726; c=relaxed/simple;
	bh=EWxipZ+oDs4F5xPYmtxH6oYUrOKrfAeNEA4GnhJp7Nw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hq9EU+NmlaRSQywN9qTqZPkBh02WfS/dIGj69/WnCsoeO9B0GCAAO/BCFz+mDGEj3A0ktw8iXHryNXKnfO609KvF2ApgnDpsMzLJcKBBSCCfcIQaxuSxv35NVPkkgsFuzEMn+qCiKCgb7AZxSm8TyBFaoJp1OynfPmieAm+8LpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gp/LJD1x; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776694720;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=H0srVNgnwH91e/1YYNJ3AyGtX1xlUnjy0Bmegh+gDZY=;
	b=gp/LJD1x5PQFW+h6FWzpwaJn1k3yIreJrjmW7OOmNxDxpbz1ThO0BeXw8xDc8oAY0d5y+Z
	7/ViQntqxwJUGxhCvWy4uBWp42phttMHmb2Wyb9dz4kYnU0l3+QBohkWgP2/xpeK4NFGbh
	Easp2DyDkK3ZFyfpfOFq8uQGcsh+EPY=
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
Subject: [PATCH bpf-next v12 0/8] bpf: Extend BPF syscall with common attributes support
Date: Mon, 20 Apr 2026 22:17:56 +0800
Message-ID: <20260420141804.27179-1-leon.hwang@linux.dev>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,gmail.com,linux.dev,fomichev.me,google.com,amazon.com,redhat.com,meta.com,cestc.cn,vger.kernel.org,fb.com];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_TWELVE(0.00)[31];
	TAGGED_FROM(0.00)[bounces-6111-lists,linux-api=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-api];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linux.dev:dkim,linux.dev:mid]
X-Rspamd-Queue-Id: 5B52542DE9F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This patch series builds upon the discussion in
"[PATCH bpf-next v4 0/4] bpf: Improve error reporting for freplace attachment failure" [1].

This patch series introduces support for *common attributes* in the BPF
syscall, providing a unified mechanism for passing shared metadata across
all BPF commands, initially used by BPF_PROG_LOAD, BPF_BTF_LOAD, and
BPF_MAP_CREATE.

The initial set of common attributes includes:

1. 'log_buf': User-provided buffer for storing log output.
2. 'log_size': Size of the provided log buffer.
3. 'log_level': Verbosity level for logging.
4. 'log_true_size': Actual log size reported by kernel.

With this extension, the BPF syscall will be able to return meaningful
error messages (e.g., map creation failures), improving debuggability
and user experience.

Links:
[1] https://lore.kernel.org/bpf/20250224153352.64689-1-leon.hwang@linux.dev/

Changes:
v11 -> v12:
* Drop "log_" prefix in struct bpf_log_attr in patch #3.
* Drop "log_" prefix in struct bpf_log_opts in patch #7.
* Copy log_true_size using copy_to_bpfptr_offset() in patch #3 (per Alexei).
* v11: https://lore.kernel.org/bpf/20260216150445.68278-1-leon.hwang@linux.dev/

v10 -> v11:
* Collect Acked-by from Andrii, thanks.
* Validate whether log_buf, log_size, and log_level are valid by reusing
  bpf_verifier_log_attr_valid() in patch #4 (per Andrii).
* v10: https://lore.kernel.org/bpf/20260211151115.78013-1-leon.hwang@linux.dev/

v9 -> v10:
* Collect Acked-by from Andrii, thanks.
* Address comments from Andrii:
  * Drop log NULL check in bpf_log_attr_finalize().
  * Return -EFAULT early in bpf_log_attr_finalize().
  * Validate whether log_buf, log_size, and log_level are set.
  * Keep log_buf, log_size, log_level, and user-pointer log_true_size in struct
    bpf_log_attr.
  * Make prog_load and btf_load work with the new struct bpf_log_attr.
  * Add comment to log_true_size of struct bpf_log_opts in libbpf.
* Address comment from Alexei:
  * Avoid using BPF_LOG_FIXED as log_level in tests.
* v9: https://lore.kernel.org/bpf/20260202144046.30651-1-leon.hwang@linux.dev/

v8 -> v9:
* Rework reporting 'log_true_size' for prog_load, btf_load, and map_create to
  simplify struct bpf_log_attr (per Alexei).
* v8: https://lore.kernel.org/bpf/20260126151409.52072-1-leon.hwang@linux.dev/

v7 -> v8:
* Return 0 when fd < 0 and errno != EFAULT in probe_sys_bpf_ext(), then simplify
  probe_bpf_syscall_common_attrs() (per Alexei and Andrii).
* v7: https://lore.kernel.org/bpf/20260123032445.125259-1-leon.hwang@linux.dev/

v6 -> v7:
* Return -errno when fd < 0 and errno != EFAULT in probe_sys_bpf_ext().
* Convert return value of probe_sys_bpf_ext() to bool in
  probe_bpf_syscall_common_attrs().
* Address comments from Andrii:
  * Drop the comment, and handle fd >= 0 case explicitly in
    probe_sys_bpf_ext().
  * Return an error when fd >= 0 in probe_sys_bpf_ext().
* v6: https://lore.kernel.org/bpf/20260120152424.40766-1-leon.hwang@linux.dev/

v5 -> v6:
* Address comments from Andrii:
  * Update some variables' name.
  * Drop unnecessary 'close(fd)' in libbpf.
  * Rename FEAT_EXTENDED_SYSCALL to FEAT_BPF_SYSCALL_COMMON_ATTRS with
    updated description in libbpf.
  * Use EINVAL instead of EUSERS, as EUSERS is not used in bpf yet.
  * Rename struct bpf_syscall_common_attr_opts to bpf_log_opts in libbpf.
  * Add 'OPTS_SET(log_opts, log_true_size, 0);' in libbpf's 'bpf_map_create()'.
* v5: https://lore.kernel.org/bpf/20260112145616.44195-1-leon.hwang@linux.dev/

v4 -> v5:
* Rework reporting 'log_true_size' for prog_load, btf_load, and map_create
  (per Alexei).
* v4: https://lore.kernel.org/bpf/20260106172018.57757-1-leon.hwang@linux.dev/

RFC v3 -> v4:
* Drop RFC.
* Address comments from Andrii:
  * Add parentheses in 'sys_bpf_ext()'.
  * Avoid creating new fd in 'probe_sys_bpf_ext()'.
  * Add a new struct to wrap log fields in libbpf.
* Address comments from Alexei:
  * Do not skip writing to user space when log_true_size is zero.
  * Do not use 'bool' arguments.
  * Drop the adding WARN_ON_ONCE()'s.
* v3: https://lore.kernel.org/bpf/20251002154841.99348-1-leon.hwang@linux.dev/

RFC v2 -> RFC v3:
* Rename probe_sys_bpf_extended to probe_sys_bpf_ext.
* Refactor reporting 'log_true_size' for prog_load.
* Refactor reporting 'btf_log_true_size' for btf_load.
* Add warnings for internal bugs in map_create.
* Check log_true_size in test cases.
* Address comment from Alexei:
  * Change kvzalloc/kvfree to kzalloc/kfree.
* Address comments from Andrii:
  * Move BPF_COMMON_ATTRS to 'enum bpf_cmd' alongside brief comment.
  * Add bpf_check_uarg_tail_zero() for extra checks.
  * Rename sys_bpf_extended to sys_bpf_ext.
  * Rename sys_bpf_fd_extended to sys_bpf_ext_fd.
  * Probe the new feature using NULL and -EFAULT.
  * Move probe_sys_bpf_ext to libbpf_internal.h and drop LIBBPF_API.
  * Return -EUSERS when log attrs are conflict between bpf_attr and
    bpf_common_attr.
  * Avoid touching bpf_vlog_init().
  * Update the reason messages in map_create.
  * Finalize the log using __cleanup().
  * Report log size to users.
  * Change type of log_buf from '__u64' to 'const char *' and cast type
    using ptr_to_u64() in bpf_map_create().
  * Do not return -EOPNOTSUPP when kernel doesn't support this feature
    in bpf_map_create().
  * Add log_level support for map creation for consistency.
* Address comment from Eduard:
  * Use common_attrs->log_level instead of BPF_LOG_FIXED.
* v2: https://lore.kernel.org/bpf/20250911163328.93490-1-leon.hwang@linux.dev/

RFC v1 -> RFC v2:
* Fix build error reported by test bot.
* Address comments from Alexei:
  * Drop new uapi for freplace.
  * Add common attributes support for prog_load and btf_load.
  * Add common attributes support for map_create.
* v1: https://lore.kernel.org/bpf/20250728142346.95681-1-leon.hwang@linux.dev/

Leon Hwang (8):
  bpf: Extend BPF syscall with common attributes support
  libbpf: Add support for extended BPF syscall
  bpf: Refactor reporting log_true_size for prog_load
  bpf: Add syscall common attributes support for prog_load
  bpf: Add syscall common attributes support for btf_load
  bpf: Add syscall common attributes support for map_create
  libbpf: Add syscall common attributes support for map_create
  selftests/bpf: Add tests to verify map create failure log

 include/linux/bpf.h                           |   4 +-
 include/linux/bpf_verifier.h                  |  16 ++
 include/linux/btf.h                           |   3 +-
 include/linux/syscalls.h                      |   3 +-
 include/uapi/linux/bpf.h                      |   8 +
 kernel/bpf/btf.c                              |  30 +---
 kernel/bpf/log.c                              |  91 +++++++++-
 kernel/bpf/syscall.c                          | 114 +++++++++---
 kernel/bpf/verifier.c                         |  17 +-
 tools/include/uapi/linux/bpf.h                |   8 +
 tools/lib/bpf/bpf.c                           |  52 +++++-
 tools/lib/bpf/bpf.h                           |  17 +-
 tools/lib/bpf/features.c                      |   8 +
 tools/lib/bpf/libbpf_internal.h               |   3 +
 .../selftests/bpf/prog_tests/map_init.c       | 166 ++++++++++++++++++
 15 files changed, 473 insertions(+), 67 deletions(-)

--
2.53.0



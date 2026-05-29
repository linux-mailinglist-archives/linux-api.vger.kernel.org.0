Return-Path: <linux-api+bounces-6465-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eLKXC7MiGmow1wgAu9opvQ
	(envelope-from <linux-api+bounces-6465-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Sat, 30 May 2026 01:35:15 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C9449609CA6
	for <lists+linux-api@lfdr.de>; Sat, 30 May 2026 01:35:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0F52F305BB3E
	for <lists+linux-api@lfdr.de>; Fri, 29 May 2026 23:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47C7B3FC5D6;
	Fri, 29 May 2026 23:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qxe1bqFi"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DAFB3C5546;
	Fri, 29 May 2026 23:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780097631; cv=none; b=ijWzPrKXhMXYHzqa4HeasaWvZegSbDvsAhVOYEhKhXDfbBe+kPkIPV//NoJesjQNXlNtdjiRRMHfVYBx/EuDzFp1JyP1ApoMFxFlHrXvWtlmlpSynRO4540mpb7t2f2ij59j/nMmjrkmsgzbNRWh8KlUhucAhh9Y2HQlgO+Y00I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780097631; c=relaxed/simple;
	bh=hXTACtBIV6hiJQgdeXIpXE8oX0VfwYXpGLrdPdwrSB0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TTMqRFntTERLYZjBiPP8P5NhyRP+8BEhx2p3+5HDfm3A/iZ7r0pS7zER5QGgDuUlULS/kKC3fiDSQDNl84jbvOs7Q0GueLH4Ax6ulAulhM0ZuMh91oXAgorVkp5MtMiFmzWr9hglVe+u4DSEELxKlx7F7hHqkP5GT4+zJmwq1bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qxe1bqFi; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 673CE1F00899;
	Fri, 29 May 2026 23:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780097629;
	bh=i5xoYOu+H/E2Qmd6vKoz6csEWSVaDrwB5J3ezvyhCxg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Qxe1bqFiXTODd2f4grnOICVXbhq2ocNkz+jxYbVEHDomrL78/pKUYx6CwgTDPf2vH
	 yYmEnf7cSymZUlV7TX73zpm92q33c6jgFedQoR+P139razqoNlh+Vqu2FbcDUi/1ei
	 aY5LEkRZvBGSGTExyqarQKrQAtrDiYkxXRa7Waa3cnrOC3qBH8L4aNhqW7VJWC1jAl
	 1s+e748Q14/FPA6VAOCaaexu3U1xzaXCgjTHrL1mjdt3aXzWqO+/TidI2GkfNCHHFJ
	 +lnMI48vCXplKCo+YH3PTS4B8U3HK6FmSkgl5VuEkIH2VPTy38q5sjCJA4KH8dNTWa
	 ZxJTWsYDgAo1g==
From: Sasha Levin <sashal@kernel.org>
To: linux-api@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: linux-doc@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kbuild@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	workflows@vger.kernel.org,
	tools@kernel.org,
	x86@kernel.org,
	Thomas Gleixner <tglx@kernel.org>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Dmitry Vyukov <dvyukov@google.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Cyril Hrubis <chrubis@suse.cz>,
	Kees Cook <kees@kernel.org>,
	Jake Edge <jake@lwn.net>,
	David Laight <david.laight.linux@gmail.com>,
	Gabriele Paoloni <gpaoloni@redhat.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Andrew Morton <akpm@linux-foundation.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Nathan Chancellor <nathan@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH v4 11/11] kernel/api: add syscall enter/exit tracepoints
Date: Fri, 29 May 2026 19:33:10 -0400
Message-ID: <20260529233311.1901670-12-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260529233311.1901670-1-sashal@kernel.org>
References: <20260529233311.1901670-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,linuxfoundation.org,lwn.net,google.com,infradead.org,suse.cz,gmail.com,redhat.com,zeniv.linux.org.uk,linux-foundation.org,arndb.de,goodmis.org,efficios.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[31];
	TAGGED_FROM(0.00)[bounces-6465-lists,linux-api=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,linux-api@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-api];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: C9449609CA6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add two tracepoints to the CONFIG_KAPI_RUNTIME_CHECKS syscall validation
path so the framework's behavior can be observed without the noise and
loss of pr_warn_ratelimited():

  kapi_syscall_enter - the spec name, the raw argument values, and a
                       rendered "name=value" list of the specified
                       parameters (pointer-like values in hex, integers
                       and file descriptors in decimal)
  kapi_syscall_exit  - the spec name, the return value, and whether it
                       matched the specification (spec_match)

Both fire only for syscalls that have a KAPI specification and live
inside the existing CONFIG_KAPI_RUNTIME_CHECKS region, so they exist
exactly when the runtime checks do; they compile to no-ops without
CONFIG_TRACEPOINTS and stay dormant until enabled. The parameter list
is rendered only when the enter tracepoint is enabled.

kapi_syscall_exit is also emitted on the parameter-validation rejection
path -- where the validator returns -EINVAL and the real handler is
skipped -- with spec_match=0, so every kapi_syscall_enter has a matching
exit.

Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Documentation/dev-tools/kernel-api-spec.rst | 29 ++++++++
 MAINTAINERS                                 |  1 +
 include/trace/events/kapi.h                 | 74 ++++++++++++++++++++
 kernel/api/kernel_api_spec.c                | 77 ++++++++++++++++++---
 4 files changed, 173 insertions(+), 8 deletions(-)
 create mode 100644 include/trace/events/kapi.h

diff --git a/Documentation/dev-tools/kernel-api-spec.rst b/Documentation/dev-tools/kernel-api-spec.rst
index 26598a98c0f69..561e7bff58379 100644
--- a/Documentation/dev-tools/kernel-api-spec.rst
+++ b/Documentation/dev-tools/kernel-api-spec.rst
@@ -285,6 +285,35 @@ custom validation functions via the ``validate`` field in the constraint spec:
     .type = KAPI_CONSTRAINT_CUSTOM,
     .validate = validate_buffer_size,
 
+Tracepoints
+-----------
+
+When ``CONFIG_KAPI_RUNTIME_CHECKS`` is enabled, the syscall validation path emits
+two ftrace tracepoints (in the ``kapi`` trace system) for every syscall that has a
+specification:
+
+- ``kapi_syscall_enter`` -- fired before parameter validation, recording the spec
+  name, the raw syscall argument values, and -- when the spec provides parameter
+  metadata -- a rendered ``name=value`` list: pointer-like values are shown in hex,
+  integers and file descriptors in decimal, and an unnamed parameter as ``arg``.
+- ``kapi_syscall_exit`` -- fired after the handler returns, or in place of the
+  handler when parameter validation rejects the call (the handler is skipped and
+  ``-EINVAL`` is returned). Records the spec name, the return value, and
+  ``spec_match``: 0 when the call did not conform to the spec -- the parameters were
+  rejected, or the return value was not one the spec allows -- and 1 otherwise.
+
+Unlike the ``pr_warn_ratelimited`` violation reports, the tracepoints capture every
+spec'd call rather than only violations, are lossless under load, and can be filtered
+with the usual ftrace facilities. They require ``CONFIG_TRACEPOINTS`` and stay dormant
+until enabled::
+
+    # echo 1 > /sys/kernel/tracing/events/kapi/enable
+    # cat /sys/kernel/tracing/trace
+     ...  kapi_syscall_enter: sys_read(fd=3, buf=0x7ffd46780b58, count=0x340)
+     ...  kapi_syscall_exit: sys_read = 832 spec_match=1
+     ...  kapi_syscall_enter: sys_open(filename=0x480300, flags=268435456, mode=0x0)
+     ...  kapi_syscall_exit: sys_open = -22 spec_match=0
+
 DebugFS Interface
 =================
 
diff --git a/MAINTAINERS b/MAINTAINERS
index ddfd9cad98916..48def631ad823 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13823,6 +13823,7 @@ L:	linux-api@vger.kernel.org
 S:	Maintained
 F:	Documentation/dev-tools/kernel-api-spec.rst
 F:	include/linux/kernel_api_spec.h
+F:	include/trace/events/kapi.h
 F:	kernel/api/
 F:	tools/kapi/
 F:	tools/lib/python/kdoc/kdoc_apispec.py
diff --git a/include/trace/events/kapi.h b/include/trace/events/kapi.h
new file mode 100644
index 0000000000000..47828f3338828
--- /dev/null
+++ b/include/trace/events/kapi.h
@@ -0,0 +1,74 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM kapi
+
+#if !defined(_TRACE_KAPI_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_KAPI_H
+
+#include <linux/tracepoint.h>
+
+/* Max length of the rendered "name=value, ..." parameter list. */
+#define KAPI_TP_PARAMS_LEN 256
+
+/*
+ * Emitted from the CONFIG_KAPI_RUNTIME_CHECKS syscall validation path for
+ * syscalls that have a KAPI specification: kapi_syscall_enter fires before
+ * parameter validation, kapi_syscall_exit after the handler returns.
+ * @name is the spec name, e.g. "sys_open".
+ *
+ * kapi_syscall_enter carries both the raw argument values (args[]) and, when
+ * the spec provides parameter metadata, a rendered "name=value" list (params,
+ * built by the caller): pointer-like values in hex, integers and fds in decimal.
+ */
+TRACE_EVENT(kapi_syscall_enter,
+
+	TP_PROTO(const char *name, int nargs, const s64 *args, const char *params),
+
+	TP_ARGS(name, nargs, args, params),
+
+	TP_STRUCT__entry(
+		__string(	name,	name	)
+		__field(	int,	nargs	)
+		__array(	u64,	args,	6	)
+		__string(	params,	params	)
+	),
+
+	TP_fast_assign(
+		__assign_str(name);
+		__entry->nargs = nargs;
+		memset(__entry->args, 0, sizeof(__entry->args));
+		if (args && nargs > 0)
+			memcpy(__entry->args, args,
+			       min_t(int, nargs, 6) * sizeof(__entry->args[0]));
+		__assign_str(params);
+	),
+
+	TP_printk("%s(%s)", __get_str(name), __get_str(params))
+);
+
+TRACE_EVENT(kapi_syscall_exit,
+
+	TP_PROTO(const char *name, long ret, bool spec_match),
+
+	TP_ARGS(name, ret, spec_match),
+
+	TP_STRUCT__entry(
+		__string(	name,		name		)
+		__field(	long,		ret		)
+		__field(	bool,		spec_match	)
+	),
+
+	TP_fast_assign(
+		__assign_str(name);
+		__entry->ret = ret;
+		__entry->spec_match = spec_match;
+	),
+
+	TP_printk("%s = %ld spec_match=%d",
+		  __get_str(name), __entry->ret, __entry->spec_match)
+);
+
+#endif /* _TRACE_KAPI_H */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
diff --git a/kernel/api/kernel_api_spec.c b/kernel/api/kernel_api_spec.c
index 1a9041a7f21a4..2aa8c04a5851e 100644
--- a/kernel/api/kernel_api_spec.c
+++ b/kernel/api/kernel_api_spec.c
@@ -659,6 +659,45 @@ EXPORT_SYMBOL_GPL(kapi_print_spec);
 
 #ifdef CONFIG_KAPI_RUNTIME_CHECKS
 
+#define CREATE_TRACE_POINTS
+#include <trace/events/kapi.h>
+
+/*
+ * Render a syscall's parameters as a "name=value, ..." string for the
+ * kapi_syscall_enter tracepoint.  Names come from the spec; pointer-like
+ * values are shown in hex, integers and file descriptors in decimal.
+ */
+static void kapi_trace_format_params(const struct kernel_api_spec *spec,
+				     const s64 *args, int nargs,
+				     char *buf, size_t size)
+{
+	int i, used = 0;
+
+	buf[0] = '\0';
+	/* Bound by the caller-supplied arg count; the spec arity may differ. */
+	for (i = 0; args && i < nargs && i < 6; i++) {
+		const char *name = "arg";
+		bool dec = false;
+
+		if (i < spec->param_count) {
+			const struct kapi_param_spec *ps = &spec->params[i];
+
+			if (ps->name)
+				name = ps->name;
+			dec = ps->type == KAPI_TYPE_INT || ps->type == KAPI_TYPE_FD;
+		}
+
+		used += scnprintf(buf + used, size - used, "%s%s=",
+				  i ? ", " : "", name);
+		if (dec)
+			used += scnprintf(buf + used, size - used, "%lld",
+					  (long long)args[i]);
+		else
+			used += scnprintf(buf + used, size - used, "0x%llx",
+					  (unsigned long long)args[i]);
+	}
+}
+
 /**
  * kapi_validate_fd - Validate that a file descriptor value is in valid range
  * @fd: File descriptor to validate
@@ -1154,16 +1193,24 @@ EXPORT_SYMBOL_GPL(kapi_validate_syscall_param);
 int kapi_validate_syscall_params(const struct kernel_api_spec *spec,
 				 const s64 *params, int param_count)
 {
-	int i;
+	int i, ret = 0;
 
 	if (!spec || !params)
 		return 0;
 
+	if (trace_kapi_syscall_enter_enabled()) {
+		char pbuf[KAPI_TP_PARAMS_LEN];
+
+		kapi_trace_format_params(spec, params, param_count, pbuf, sizeof(pbuf));
+		trace_kapi_syscall_enter(spec->name, param_count, params, pbuf);
+	}
+
 	/* Validate that we have the expected number of parameters */
 	if (param_count != spec->param_count) {
 		pr_warn_ratelimited("API %s: parameter count mismatch (expected %u, got %d)\n",
 			spec->name, spec->param_count, param_count);
-		return -EINVAL;
+		ret = -EINVAL;
+		goto out;
 	}
 
 	/* Validate each parameter with context */
@@ -1173,12 +1220,22 @@ int kapi_validate_syscall_params(const struct kernel_api_spec *spec,
 		if (!kapi_validate_param_with_context(param_spec, params[i], params, param_count)) {
 			if (strncmp(spec->name, "sys_", 4) == 0) {
 				/* For syscalls, we can return EINVAL to userspace */
-				return -EINVAL;
+				ret = -EINVAL;
+				goto out;
 			}
 		}
 	}
 
-	return 0;
+out:
+	/*
+	 * Emit the exit event on the rejection path too (the wrapper
+	 * short-circuits the handler on a non-zero return), so every
+	 * kapi_syscall_enter has a matching kapi_syscall_exit.
+	 */
+	if (ret)
+		trace_kapi_syscall_exit(spec->name, ret, false);
+
+	return ret;
 }
 EXPORT_SYMBOL_GPL(kapi_validate_syscall_params);
 
@@ -1301,14 +1358,18 @@ EXPORT_SYMBOL_GPL(kapi_validate_return_value);
  */
 int kapi_validate_syscall_return(const struct kernel_api_spec *spec, s64 retval)
 {
+	bool valid = true;
+
 	if (!spec)
 		return 0;
 
-	/* Skip return validation if return spec was not defined */
-	if (spec->return_magic != KAPI_MAGIC_RETURN)
-		return 0;
+	/* Validate against the return spec when one was defined */
+	if (spec->return_magic == KAPI_MAGIC_RETURN)
+		valid = kapi_validate_return_value(spec, retval);
+
+	trace_kapi_syscall_exit(spec->name, retval, valid);
 
-	if (!kapi_validate_return_value(spec, retval)) {
+	if (!valid) {
 		/* Log the violation but don't change the return value */
 		pr_warn_ratelimited("KAPI: Syscall %s returned unspecified value %lld\n",
 				    spec->name, retval);
-- 
2.53.0



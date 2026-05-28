Return-Path: <linux-api+bounces-6435-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qIbRLMMUGGrKbggAu9opvQ
	(envelope-from <linux-api+bounces-6435-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Thu, 28 May 2026 12:11:15 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 52F0D5F0423
	for <lists+linux-api@lfdr.de>; Thu, 28 May 2026 12:11:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CEBD130F38D8
	for <lists+linux-api@lfdr.de>; Thu, 28 May 2026 09:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A9753B47C4;
	Thu, 28 May 2026 09:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b="AZwYKVo1"
X-Original-To: linux-api@vger.kernel.org
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA20C3B47EC;
	Thu, 28 May 2026 09:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779962116; cv=pass; b=hSSdyRuoCMD6pP7PFdYSdjB/LoeTid+IS+i9X6qZsqwU4wgeaCj1KQt4gyAWFOVd8dubAJjxzGMCDbbds806Ir/Z7mDvkfibNubhOrlZxf7eZuBX1xgcIfoamXug3nbaAKgze910V1W1aA6+5/T+2xNCLHjUh6O6bV5T8V2J378=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779962116; c=relaxed/simple;
	bh=qwZ2vfx9YEVsfDJKQyu1dN9dxJddEvj8lgpCxBFjuq8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kA0H5RAneeo+PHw6WLA/1YV97J2OpJbLTFoFX88ZUB29WJ31JE0pRX/XsWRihoHqM9PD3ktoMrC8InT1oP8EhP4Ls3NOuNY73m+HgFGABaRv6Y9xsKurW72XGbBXxqBmy+LubSFdGtkYeeL8p0l0Q88brQhW+44I19R7Do9VFS4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.beauty; spf=pass smtp.mailfrom=linux.beauty; dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b=AZwYKVo1; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.beauty
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.beauty
ARC-Seal: i=1; a=rsa-sha256; t=1779962010; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=UJp74+WitwbRvyhSh1bqMHpblUO0MWbE7UlDr3begnbJB617OdDR2gfunQADEykfa5B0CE+3TWDnE40e3516+m/qPveTsAPszR0aajiboyNqWDPimeaX4e4lNNSkev3dWBbu2hyF2ts3NeqWS3N+u/DIbVIRjbgWGgs0eeTrIMQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1779962010; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Np1g+dFsamPmY41icpk+vIarybQaXo3ssE2KjyjvCss=; 
	b=F7bPn+uWftD68aLJkbRNnr397A+9eEYyvV2g2crEX+VJTQfeKVSDBvtI9IDVgcDvS193Ze2dUHGrKym8ulTYxWTaMq0lxaUcC2l3XndZUAvIGrG6ZwDXCNjXgaIYNJaLISjUYbh0DV9akOZOUQVclWuU4l0b866uCKCa1cB85Mc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=linux.beauty;
	spf=pass  smtp.mailfrom=me@linux.beauty;
	dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1779962010;
	s=zmail; d=linux.beauty; i=me@linux.beauty;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=Np1g+dFsamPmY41icpk+vIarybQaXo3ssE2KjyjvCss=;
	b=AZwYKVo12OW8IbAxRwRL7CFelimmkb7ycFOc6bfBdDKMfCWY/i7OrbyNEOJs02Gs
	EOFTusw+Sg+ZbqsMzB5Gz1dhRJ44nSHYnWrGTYjBw7Y9et5/2bGYYQ2uKbWeDPygQAh
	cOZyCXAyXl72jvaM82H6qpYb8hKnfM0GxlXMO8wo=
Received: by mx.zohomail.com with SMTPS id 1779962008110241.98298131178922;
	Thu, 28 May 2026 02:53:28 -0700 (PDT)
From: Li Chen <me@linux.beauty>
To: Christian Brauner <brauner@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org,
	linux-api@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-arch@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	x86@kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	Andy Lutomirski <luto@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Jan Kara <jack@suse.cz>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Li Chen <me@linux.beauty>
Subject: [RFC PATCH v1 04/13] exec: add spawn template UAPI definitions
Date: Thu, 28 May 2026 17:52:25 +0800
Message-ID: <20260528095235.2491226-5-me@linux.beauty>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260528095235.2491226-1-me@linux.beauty>
References: <20260528095235.2491226-1-me@linux.beauty>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.beauty,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.beauty:s=zmail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6435-lists,linux-api=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[me@linux.beauty,linux-api@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.beauty:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-api];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.beauty:email,linux.beauty:mid,linux.beauty:dkim]
X-Rspamd-Queue-Id: 52F0D5F0423
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add the userspace ABI structures and flags for creating a spawn
template and spawning a process from it. The ABI carries argv, envp,
and per-spawn fd actions while leaving policy decisions in userspace.

Signed-off-by: Li Chen <me@linux.beauty>
---
 MAINTAINERS                         |  1 +
 include/uapi/linux/spawn_template.h | 62 +++++++++++++++++++++++++++++
 2 files changed, 63 insertions(+)
 create mode 100644 include/uapi/linux/spawn_template.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 3dd58a16f06a9..d7b1191e33ca0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9739,6 +9739,7 @@ F:	include/linux/elf.h
 F:	include/uapi/linux/auxvec.h
 F:	include/uapi/linux/binfmts.h
 F:	include/uapi/linux/elf.h
+F:	include/uapi/linux/spawn_template.h
 F:	kernel/fork.c
 F:	mm/vma_exec.c
 F:	tools/testing/selftests/exec/
diff --git a/include/uapi/linux/spawn_template.h b/include/uapi/linux/spawn_template.h
new file mode 100644
index 0000000000000..84f026fdf9090
--- /dev/null
+++ b/include/uapi/linux/spawn_template.h
@@ -0,0 +1,62 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef _UAPI_LINUX_SPAWN_TEMPLATE_H
+#define _UAPI_LINUX_SPAWN_TEMPLATE_H
+
+#include <linux/openat2.h>
+#include <linux/types.h>
+
+#define SPAWN_TEMPLATE_CREATE_CLOEXEC		(1ULL << 0)
+#define SPAWN_TEMPLATE_SPAWN_INHERIT_FDS	(1ULL << 0)
+
+enum spawn_template_action_type {
+	SPAWN_TEMPLATE_ACTION_CLOSE = 0,
+	SPAWN_TEMPLATE_ACTION_DUP2 = 1,
+	SPAWN_TEMPLATE_ACTION_FCHDIR = 2,
+	SPAWN_TEMPLATE_ACTION_OPEN = 3,
+	SPAWN_TEMPLATE_ACTION_CLOSE_RANGE = 4,
+	SPAWN_TEMPLATE_ACTION_SIGMASK = 5,
+	SPAWN_TEMPLATE_ACTION_SIGDEFAULT = 6,
+};
+
+struct spawn_template_action {
+	__u32 type;
+	__u32 flags;
+	__s32 fd;
+	__s32 newfd;
+	__aligned_u64 arg;
+};
+
+struct spawn_template_open {
+	__aligned_u64 path;
+	struct open_how how;
+};
+
+struct spawn_template_sigset {
+	__aligned_u64 sigset;
+	__u64 sigsetsize;
+};
+
+struct spawn_template_create_args {
+	__aligned_u64 flags;
+	__s32 execfd;
+	__u32 exec_flags;
+	__aligned_u64 filename;
+	__aligned_u64 actions;
+	__aligned_u64 actions_len;
+	__aligned_u64 reserved[4];
+};
+
+struct spawn_template_spawn_args {
+	__aligned_u64 flags;
+	__aligned_u64 pidfd;
+	__aligned_u64 argv;
+	__aligned_u64 envp;
+	__aligned_u64 actions;
+	__aligned_u64 actions_len;
+	__aligned_u64 reserved[4];
+};
+
+#define SPAWN_TEMPLATE_CREATE_ARGS_SIZE_VER0	72
+#define SPAWN_TEMPLATE_SPAWN_ARGS_SIZE_VER0	80
+
+#endif /* _UAPI_LINUX_SPAWN_TEMPLATE_H */
-- 
2.52.0



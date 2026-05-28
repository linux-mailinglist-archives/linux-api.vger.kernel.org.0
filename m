Return-Path: <linux-api+bounces-6443-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sPy6Gt4UGGrKbggAu9opvQ
	(envelope-from <linux-api+bounces-6443-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Thu, 28 May 2026 12:11:42 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A998B5F0465
	for <lists+linux-api@lfdr.de>; Thu, 28 May 2026 12:11:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0A6C83035660
	for <lists+linux-api@lfdr.de>; Thu, 28 May 2026 09:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 710833B27DD;
	Thu, 28 May 2026 09:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b="hs9jAnFc"
X-Original-To: linux-api@vger.kernel.org
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BC0E38A73B;
	Thu, 28 May 2026 09:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779962331; cv=pass; b=AspiLSh9k7OGfr1c3Tde71D6nP3CLCtzgeJeQSY473lu6W1Jx+9gkY9tjWvOR3N2RpYOF99K9Bl6I5UdOePe1/omKHOok0u19CsN/iT0FSRDytTO98W0dFCZ24h6991CPhpP5JMnoDFh4WCDRCrAF0WcAGvtv+vRvEPRdN5EPug=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779962331; c=relaxed/simple;
	bh=NQuwJ0bwOiDTJ90aRko1yQGQwq034q6tsfagPPUJkvk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BOq5PuWbholjPhkfLxo/VH1DUJxFEO/afUxyw63s14lMmzfEFzmZ8MmJNKlbMjHXBsgZAEq2UJ2Bl/cxPThzsVTeESbH4uDNiFbc8zQ4TvS8vz8BOCQoQXk4RELau9JzQ2k3ZxILJPbMO129CmwtX5W2zh/BvW1mgQ2ROFFMieA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.beauty; spf=pass smtp.mailfrom=linux.beauty; dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b=hs9jAnFc; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.beauty
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.beauty
ARC-Seal: i=1; a=rsa-sha256; t=1779962078; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=W0w/mn2J1AYfM3IS7vZfMX0gJ8ZaymQK2XDEVIjpTpvOwgMEYhvZLwobodhV5irOmS8XeUKpxQfYjDUJIVqUB2STeoXKQYIai/08OX5v/5YaeyHDG6HdfNJMqG/CrlNQ5bbUIBEQdNIjhxZDHpU7XvDI0/CjZ7T/fG8z0cLkbxM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1779962078; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=LBP3jruN2RkIXP5r6tCnATnUH33LnY6Ig4uYaIj36zY=; 
	b=FnNdIqrmJXESp6ZdHOgHw7hif7sa6TuZIIpNebGnePeOrG8CiOZubbu0gMUo5fcjwkbLIJkzBWfYg54nVwE+8RvVYJRaIkFuH3cI9vrlNvR8d+FuiG9NrfchomBszf2xtYQcMNqKXRmnLL31MPkcg02cts6MI7MmtHCdyy4EstE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=linux.beauty;
	spf=pass  smtp.mailfrom=me@linux.beauty;
	dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1779962078;
	s=zmail; d=linux.beauty; i=me@linux.beauty;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=LBP3jruN2RkIXP5r6tCnATnUH33LnY6Ig4uYaIj36zY=;
	b=hs9jAnFcSis+pCZhFYCvTa0bWXgdCxYbVdlMupKZJ8yIlMw7s6ao28m9iC0adpex
	kxSyjfM4rCkyLSSGivfV3lc0J6qF85zRgXHX6GkmKKCPsUq+en4GUudCpv7v3oT21VC
	+m4xFhBxhOqNUd9SgBpgmr2mxUcTzWwh8/8Q/fwM=
Received: by mx.zohomail.com with SMTPS id 1779962074218341.93123023468877;
	Thu, 28 May 2026 02:54:34 -0700 (PDT)
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
Subject: [RFC PATCH v1 12/13] syscalls: add generic spawn template entries
Date: Thu, 28 May 2026 17:52:33 +0800
Message-ID: <20260528095235.2491226-13-me@linux.beauty>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.beauty:s=zmail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6443-lists,linux-api=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.beauty:email,linux.beauty:mid,linux.beauty:dkim,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: A998B5F0465
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add spawn_template_create() and spawn_template_spawn() to the generic
syscall table and asm-generic UAPI numbering. This lets architectures
using the generic table pick up the spawn-template ABI instead of
leaving the mechanism x86-only.

Signed-off-by: Li Chen <me@linux.beauty>
---
 arch/x86/entry/syscalls/syscall_64.tbl | 2 ++
 include/uapi/asm-generic/unistd.h      | 7 ++++++-
 scripts/syscall.tbl                    | 2 ++
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index d6c1667e8f3b8..e9dcfc6de79bc 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -396,6 +396,8 @@
 469	common	file_setattr		sys_file_setattr
 470	common	listns			sys_listns
 471	common	rseq_slice_yield	sys_rseq_slice_yield
+472	64	spawn_template_create	sys_spawn_template_create
+473	64	spawn_template_spawn	sys_spawn_template_spawn
 #
 # Due to a historical design error, certain syscalls are numbered differently
 # in x32 as compared to native x86_64.  These syscalls have numbers 512-547.
diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index a627acc8fb5fe..8589f2b9696a7 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -863,8 +863,13 @@ __SYSCALL(__NR_listns, sys_listns)
 #define __NR_rseq_slice_yield 471
 __SYSCALL(__NR_rseq_slice_yield, sys_rseq_slice_yield)
 
+#define __NR_spawn_template_create 472
+__SYSCALL(__NR_spawn_template_create, sys_spawn_template_create)
+#define __NR_spawn_template_spawn 473
+__SYSCALL(__NR_spawn_template_spawn, sys_spawn_template_spawn)
+
 #undef __NR_syscalls
-#define __NR_syscalls 472
+#define __NR_syscalls 474
 
 /*
  * 32 bit systems traditionally used different
diff --git a/scripts/syscall.tbl b/scripts/syscall.tbl
index 7a42b32b65776..7f8e74e866e48 100644
--- a/scripts/syscall.tbl
+++ b/scripts/syscall.tbl
@@ -412,3 +412,5 @@
 469	common	file_setattr			sys_file_setattr
 470	common	listns				sys_listns
 471	common	rseq_slice_yield		sys_rseq_slice_yield
+472	common	spawn_template_create		sys_spawn_template_create
+473	common	spawn_template_spawn		sys_spawn_template_spawn
-- 
2.52.0



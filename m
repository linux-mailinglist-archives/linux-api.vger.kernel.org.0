Return-Path: <linux-api+bounces-6438-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wPP+EKITGGrKbggAu9opvQ
	(envelope-from <linux-api+bounces-6438-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Thu, 28 May 2026 12:06:26 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 889395F02D3
	for <lists+linux-api@lfdr.de>; Thu, 28 May 2026 12:06:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8303B321E49F
	for <lists+linux-api@lfdr.de>; Thu, 28 May 2026 09:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3B7F3B47F9;
	Thu, 28 May 2026 09:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b="HwEjpNFq"
X-Original-To: linux-api@vger.kernel.org
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F53F3B2FE7;
	Thu, 28 May 2026 09:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779962192; cv=pass; b=TnBGvdYP/88zULMWEsYqphuOu7x3+dxGTsno0p3JE6H1VZTZJVWLQu8dtiKy7u4t+XJICD9o40GRuRv4xwBzy8iFqZ9c/OtexSyeWhei9vNLs71SkUALPg/Hf2f/cZSnoN7s4SShWlyYvcOWZskCLgIHV9lKswYLFUIiCuzjIA0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779962192; c=relaxed/simple;
	bh=4TII/AO692VsaNBmDYt+MddTcJzDnf8i/gccwjHmGhw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DgRm/gCszUYEsHXLJbciFAQ0Khs31zq7vLc/zrFNQTmHcQwESRr0WPqE1/YsyDFD4IiWN0n8TgeMNCkHkgbM3scEb1WI1CZ1+A08fIqgWPA9C2hcHcENXy2jhE3BJZ7FKnYLjkQcEmzcItvDXtFUuAg6XUPqm78yoG0ztGtmKWQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.beauty; spf=pass smtp.mailfrom=linux.beauty; dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b=HwEjpNFq; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.beauty
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.beauty
ARC-Seal: i=1; a=rsa-sha256; t=1779962035; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=mmg76vlXUMu7dlawi6NDHCp6O0oTFsQmfTVuLFxqSdUMbKfjEZbCh0KyTqCVHrmMYsde1TRtQGy3wcqhSv16ptcHBg7nYepm3KNUx8enEz/Pg9luF0HGRmje6Ffk3ChonbxRp8amRuih7xfjIR2x4Z2vO6iJ1E8b63xbnWSIMyQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1779962035; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=S3VNKxy6o+qZDgK0d9YYafZFNdtvAg1gG3GqRA4oDgQ=; 
	b=OzARIUo5Ve2WqOMw+nknkyJkrJSsCGrZPjykF/ig+lqyb/HwRdF9n0fix4/EF2gA8V4cCriSANsXKoMsZkB2ALbSAP2O22hTk9FSjSU16Jw0sOgHR8gOnw+ggT3GCA6dP2S8RyCkIP4bMmOO5yZxobeAbFp/ngZNWXbjSMVr07k=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=linux.beauty;
	spf=pass  smtp.mailfrom=me@linux.beauty;
	dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1779962035;
	s=zmail; d=linux.beauty; i=me@linux.beauty;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=S3VNKxy6o+qZDgK0d9YYafZFNdtvAg1gG3GqRA4oDgQ=;
	b=HwEjpNFqDcXQlndFpGcTxqSRdxdCivlSsAwWArDbUHbdDJDZ+pBR+x3Ams3MWFNm
	Q6KM6gmwzkFMLwIFWBsQhzwojPzLcDA8IoFAhesrq7q+JRiq3AhM0YIPVJdCxKZ10kR
	VzYR8BXEsUxAphMcHjtw/1e8rzidyACy8KlBd9Ps=
Received: by mx.zohomail.com with SMTPS id 1779962032692104.2223552851018;
	Thu, 28 May 2026 02:53:52 -0700 (PDT)
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
Subject: [RFC PATCH v1 07/13] exec: validate spawn template executable identity
Date: Thu, 28 May 2026 17:52:28 +0800
Message-ID: <20260528095235.2491226-8-me@linux.beauty>
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
	TAGGED_FROM(0.00)[bounces-6438-lists,linux-api=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.beauty:email,linux.beauty:mid,linux.beauty:dkim,cur.dev:url]
X-Rspamd-Queue-Id: 889395F02D3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Record a conservative executable identity key when a template is created:
device, inode, size, mode, owner, ctime, and mtime. Recheck it before
each spawn. For path-created templates, also reopen the path so a replaced
executable cannot silently reuse the old template fd.
Reject stale templates with ESTALE. Keep the check conservative by also
rechecking that the file remains a regular executable mapping target.

Signed-off-by: Li Chen <me@linux.beauty>
---
 MAINTAINERS                    |  1 +
 fs/spawn_template.c            | 75 ++++++++++++++++++++++++++++++++++
 include/linux/spawn_template.h | 25 ++++++++++++
 3 files changed, 101 insertions(+)
 create mode 100644 include/linux/spawn_template.h

diff --git a/MAINTAINERS b/MAINTAINERS
index d5441812825c3..ea4134a188779 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9737,6 +9737,7 @@ F:	fs/tests/binfmt_*_kunit.c
 F:	fs/tests/exec_kunit.c
 F:	include/linux/binfmts.h
 F:	include/linux/elf.h
+F:	include/linux/spawn_template.h
 F:	include/uapi/linux/auxvec.h
 F:	include/uapi/linux/binfmts.h
 F:	include/uapi/linux/elf.h
diff --git a/fs/spawn_template.c b/fs/spawn_template.c
index 8c3711929cffb..268f804227987 100644
--- a/fs/spawn_template.c
+++ b/fs/spawn_template.c
@@ -15,6 +15,7 @@
 #include <linux/sched/task.h>
 #include <linux/signal.h>
 #include <linux/slab.h>
+#include <linux/spawn_template.h>
 #include <linux/string.h>
 #include <linux/syscalls.h>
 #include <linux/uaccess.h>
@@ -27,6 +28,7 @@
 
 struct spawn_template {
 	struct file *exec_file;
+	struct spawn_template_file_key exec_key;
 	const struct cred *creator_cred;
 	char *filename;
 	bool deny_write;
@@ -40,6 +42,46 @@ struct spawn_template_spawn_context {
 
 static const struct file_operations spawn_template_fops;
 
+static bool spawn_template_file_exec_allowed(struct file *file);
+
+void spawn_template_fill_file_key(struct file *file,
+				  struct spawn_template_file_key *key)
+{
+	struct inode *inode = file_inode(file);
+	struct timespec64 ctime = inode_get_ctime(inode);
+	struct timespec64 mtime = inode_get_mtime(inode);
+
+	key->dev = inode->i_sb->s_dev;
+	key->ino = inode->i_ino;
+	key->size = i_size_read(inode);
+	key->mode = READ_ONCE(inode->i_mode);
+	key->uid = inode->i_uid;
+	key->gid = inode->i_gid;
+	key->ctime_sec = ctime.tv_sec;
+	key->ctime_nsec = ctime.tv_nsec;
+	key->mtime_sec = mtime.tv_sec;
+	key->mtime_nsec = mtime.tv_nsec;
+}
+
+bool spawn_template_file_key_matches(struct file *file,
+				     const struct spawn_template_file_key *key)
+{
+	struct spawn_template_file_key cur;
+
+	spawn_template_fill_file_key(file, &cur);
+
+	return cur.dev == key->dev &&
+	       cur.ino == key->ino &&
+	       cur.size == key->size &&
+	       cur.mode == key->mode &&
+	       uid_eq(cur.uid, key->uid) &&
+	       gid_eq(cur.gid, key->gid) &&
+	       cur.ctime_sec == key->ctime_sec &&
+	       cur.ctime_nsec == key->ctime_nsec &&
+	       cur.mtime_sec == key->mtime_sec &&
+	       cur.mtime_nsec == key->mtime_nsec;
+}
+
 static int spawn_template_exit_status(int err)
 {
 	switch (err) {
@@ -58,6 +100,32 @@ static bool spawn_template_cred_matches(struct spawn_template *tmpl)
 	return current_cred() == tmpl->creator_cred;
 }
 
+static bool spawn_template_key_matches(struct spawn_template *tmpl)
+{
+	bool matches;
+
+	if (tmpl->filename) {
+		struct file *file __free(fput) = NULL;
+		struct file *tmp;
+
+		tmp = open_exec(tmpl->filename);
+		if (IS_ERR(tmp))
+			return false;
+		file = tmp;
+
+		matches = spawn_template_file_key_matches(file,
+							  &tmpl->exec_key);
+		matches = matches && spawn_template_file_exec_allowed(file);
+		exe_file_allow_write_access(file);
+		if (!matches)
+			return false;
+	}
+
+	return spawn_template_file_exec_allowed(tmpl->exec_file) &&
+	       spawn_template_file_key_matches(tmpl->exec_file,
+					       &tmpl->exec_key);
+}
+
 static int spawn_template_copy_signal_set(const struct spawn_template_action *action,
 					  sigset_t *mask)
 {
@@ -433,6 +501,7 @@ SYSCALL_DEFINE2(spawn_template_create,
 						 &tmpl->deny_write);
 	if (ret)
 		goto out_free_tmpl;
+	spawn_template_fill_file_key(tmpl->exec_file, &tmpl->exec_key);
 
 	if (args.flags & SPAWN_TEMPLATE_CREATE_CLOEXEC)
 		fd_flags |= O_CLOEXEC;
@@ -507,6 +576,11 @@ SYSCALL_DEFINE3(spawn_template_spawn, int, template_fd,
 	if (ret)
 		goto out_free_ctx;
 
+	if (!spawn_template_key_matches(ctx->tmpl)) {
+		ret = -ESTALE;
+		goto out_free_actions;
+	}
+
 	kargs = (struct kernel_clone_args) {
 		.flags		= CLONE_VM | CLONE_VFORK | CLONE_PIDFD,
 		.pidfd		= u64_to_user_ptr(ctx->args.pidfd),
@@ -517,6 +591,7 @@ SYSCALL_DEFINE3(spawn_template_spawn, int, template_fd,
 
 	ret = kernel_clone(&kargs);
 
+out_free_actions:
 	kfree(ctx->actions);
 out_free_ctx:
 	kfree(ctx);
diff --git a/include/linux/spawn_template.h b/include/linux/spawn_template.h
new file mode 100644
index 0000000000000..f14a7749fe55b
--- /dev/null
+++ b/include/linux/spawn_template.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_SPAWN_TEMPLATE_H
+#define _LINUX_SPAWN_TEMPLATE_H
+
+#include <linux/fs.h>
+
+struct spawn_template_file_key {
+	dev_t dev;
+	ino_t ino;
+	loff_t size;
+	umode_t mode;
+	kuid_t uid;
+	kgid_t gid;
+	u64 ctime_sec;
+	u64 ctime_nsec;
+	u64 mtime_sec;
+	u64 mtime_nsec;
+};
+
+void spawn_template_fill_file_key(struct file *file,
+				  struct spawn_template_file_key *key);
+bool spawn_template_file_key_matches(struct file *file,
+				     const struct spawn_template_file_key *key);
+
+#endif /* _LINUX_SPAWN_TEMPLATE_H */
-- 
2.52.0



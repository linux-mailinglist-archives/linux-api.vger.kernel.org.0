Return-Path: <linux-api+bounces-6433-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AKVdINEQGGrmbQgAu9opvQ
	(envelope-from <linux-api+bounces-6433-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Thu, 28 May 2026 11:54:25 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A92F5EFFE7
	for <lists+linux-api@lfdr.de>; Thu, 28 May 2026 11:54:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E7459301363D
	for <lists+linux-api@lfdr.de>; Thu, 28 May 2026 09:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0EEF3B38B9;
	Thu, 28 May 2026 09:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b="FKKbwuBs"
X-Original-To: linux-api@vger.kernel.org
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D5339021A;
	Thu, 28 May 2026 09:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779962061; cv=pass; b=bx7X6ECKkaWOWEdml/4G9QdnRySfqOCwIkFOKqdzNb8qPzoAMosB1guhrJAI+wdwoZPsoHc59sksTuf33Eox2/xAGqkTewzra3rKWPU11x4F25PqCh7DolPNgONqNoDqE7p8ZKL0eNsl2W8b4eDMOgIf48nYQkVR9JlVhFYhfRg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779962061; c=relaxed/simple;
	bh=FhZzqTfOmRQA2ulX9Er1KOrTVIj/mj1vt5ktr+JES04=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kh3F7H7P8zvGiqyLz0ZcxnNSDBL55PVsrwHMZcTdqusg/3F4ybaLFiTehGOaqIa4h1V2DAboCnlY+MRxWO9FAmjkmd36RAClkbDLyhJRAwvceTCLn1lCuUdRLgfRccJRr6aNIaICvpuEDZbgfIebg38yGkhv0pC2kfFzmVKtyl4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.beauty; spf=pass smtp.mailfrom=linux.beauty; dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b=FKKbwuBs; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.beauty
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.beauty
ARC-Seal: i=1; a=rsa-sha256; t=1779961994; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=fDeGWFaxxrrcS1qDKS05XqYcZzPAF01/g6Ak+RwWXKG6FYNj6BVMIC2k1nfJlv9eCj/s0FbAfJpHieo3i1Swx5WlwiqRPBKygY5640jds3ncz/DYai8sGCYUrmxYIFgCE3yLzx5waC19lcH9Snx1b+7P7scuC6flfGDqY7Tn7gw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1779961994; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=uH9yEaUapIEKI2lfJ5G4DMQBlkpv8yAmGkbHJEgDnPY=; 
	b=i70+iVLUuxtknOMvAep6Ruv5rjjsgfLk1c82C16zVQh0uezSHlhefm7AlpayC8ym7VXJTsrbLgKE5mVPBifuDHpZOxFtAUIGqP190L18NuoWkmxR5oUvtGSlH315OORF34vvoWlGUaqpDsAws5MP5zQjsKir/NjNZVEuTQ+d+iY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=linux.beauty;
	spf=pass  smtp.mailfrom=me@linux.beauty;
	dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1779961994;
	s=zmail; d=linux.beauty; i=me@linux.beauty;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=uH9yEaUapIEKI2lfJ5G4DMQBlkpv8yAmGkbHJEgDnPY=;
	b=FKKbwuBsJ5SfWsLpJFnsM7vEveFkJV6vaylgo+rqg2tpHfGqwr57fWuWpcJm7bbJ
	qBZMhrSsxhYOglTquuejNbzWJlrPcY4tno/duHtpdTwL/pNStDGh69hDDzmS4J6rnm9
	b621M0QFh8R5OtuzBHeDxesjLPgFqUEPx3PnfBio=
Received: by mx.zohomail.com with SMTPS id 1779961991167186.94687791742058;
	Thu, 28 May 2026 02:53:11 -0700 (PDT)
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
Subject: [RFC PATCH v1 02/13] exec: add an internal helper for opened executables
Date: Thu, 28 May 2026 17:52:23 +0800
Message-ID: <20260528095235.2491226-3-me@linux.beauty>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linux.beauty:s=zmail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6433-lists,linux-api=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,linux.beauty:email,linux.beauty:mid,linux.beauty:dkim]
X-Rspamd-Queue-Id: 1A92F5EFFE7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Split alloc_bprm_file() from alloc_bprm() so internal callers can build
a linux_binprm from an executable file that they already opened.
Add kernel_execveat_file() for in-kernel users that need to execute an
opened file while still using the normal execve credential, LSM, and
binary-format path.

Signed-off-by: Li Chen <me@linux.beauty>
---
 fs/exec.c               | 78 +++++++++++++++++++++++++++++++++++------
 include/linux/binfmts.h |  4 +++
 2 files changed, 71 insertions(+), 11 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 53f7b18d2b1ea..5b91a9b208a77 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1392,16 +1392,13 @@ static void free_bprm(struct linux_binprm *bprm)
 	kfree(bprm);
 }
 
-static struct linux_binprm *alloc_bprm(int fd, struct filename *filename, int flags)
+static struct linux_binprm *alloc_bprm_file(struct file *file,
+					    struct filename *filename,
+					    int fd, int flags)
 {
 	struct linux_binprm *bprm;
-	struct file *file;
 	int retval = -ENOMEM;
 
-	file = do_open_execat(fd, filename, flags);
-	if (IS_ERR(file))
-		return ERR_CAST(file);
-
 	bprm = kzalloc_obj(*bprm);
 	if (!bprm) {
 		do_close_execat(file);
@@ -1463,6 +1460,17 @@ static struct linux_binprm *alloc_bprm(int fd, struct filename *filename, int fl
 	return ERR_PTR(retval);
 }
 
+static struct linux_binprm *alloc_bprm(int fd, struct filename *filename, int flags)
+{
+	struct file *file;
+
+	file = do_open_execat(fd, filename, flags);
+	if (IS_ERR(file))
+		return ERR_CAST(file);
+
+	return alloc_bprm_file(file, filename, fd, flags);
+}
+
 DEFINE_CLASS(bprm, struct linux_binprm *, if (!IS_ERR(_T)) free_bprm(_T),
 	alloc_bprm(fd, name, flags), int fd, struct filename *name, int flags)
 
@@ -1901,6 +1909,59 @@ int kernel_execve(const char *kernel_filename,
 	return bprm_execve(bprm);
 }
 
+static inline struct user_arg_ptr native_arg(const char __user *const __user *p)
+{
+	return (struct user_arg_ptr){.ptr.native = p};
+}
+
+static int do_execveat_file_common(struct file *file, struct filename *filename,
+				   struct user_arg_ptr argv,
+				   struct user_arg_ptr envp, int flags)
+{
+	struct linux_binprm *bprm;
+	struct file *exec_file;
+	int retval;
+
+	if (flags & ~AT_EMPTY_PATH)
+		return -EINVAL;
+
+	if ((current->flags & PF_NPROC_EXCEEDED) &&
+	    is_rlimit_overlimit(current_ucounts(), UCOUNT_RLIMIT_NPROC, rlimit(RLIMIT_NPROC)))
+		return -EAGAIN;
+
+	current->flags &= ~PF_NPROC_EXCEEDED;
+
+	retval = exe_file_deny_write_access(file);
+	if (retval)
+		return retval;
+	exec_file = get_file(file);
+
+	bprm = alloc_bprm_file(exec_file, filename, AT_FDCWD, flags);
+	if (IS_ERR(bprm))
+		return PTR_ERR(bprm);
+
+	retval = do_execveat_common_bprm(bprm, argv, envp);
+	free_bprm(bprm);
+	return retval;
+}
+
+int kernel_execveat_file(struct file *file, const char *filename,
+			 const void __user *argv,
+			 const void __user *envp,
+			 int flags)
+{
+	const char __user *const __user *user_argv;
+	const char __user *const __user *user_envp;
+
+	CLASS(filename_kernel, name)(filename);
+
+	user_argv = (const char __user *const __user *)argv;
+	user_envp = (const char __user *const __user *)envp;
+
+	return do_execveat_file_common(file, name, native_arg(user_argv),
+				       native_arg(user_envp), flags);
+}
+
 void set_binfmt(struct linux_binfmt *new)
 {
 	struct mm_struct *mm = current->mm;
@@ -1925,11 +1986,6 @@ void set_dumpable(struct mm_struct *mm, int value)
 	__mm_flags_set_mask_dumpable(mm, value);
 }
 
-static inline struct user_arg_ptr native_arg(const char __user *const __user *p)
-{
-	return (struct user_arg_ptr){.ptr.native = p};
-}
-
 SYSCALL_DEFINE3(execve,
 		const char __user *, filename,
 		const char __user *const __user *, argv,
diff --git a/include/linux/binfmts.h b/include/linux/binfmts.h
index 65abd5ab8836c..c0715678c9a06 100644
--- a/include/linux/binfmts.h
+++ b/include/linux/binfmts.h
@@ -141,6 +141,10 @@ extern int transfer_args_to_stack(struct linux_binprm *bprm,
 				  unsigned long *sp_location);
 extern int bprm_change_interp(const char *interp, struct linux_binprm *bprm);
 int copy_string_kernel(const char *arg, struct linux_binprm *bprm);
+int kernel_execveat_file(struct file *file, const char *filename,
+			 const void __user *argv,
+			 const void __user *envp,
+			 int flags);
 extern void set_binfmt(struct linux_binfmt *new);
 extern ssize_t read_code(struct file *, unsigned long, loff_t, size_t);
 
-- 
2.52.0



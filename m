Return-Path: <linux-api+bounces-6439-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2EouGBYVGGprcwgAu9opvQ
	(envelope-from <linux-api+bounces-6439-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Thu, 28 May 2026 12:12:38 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ED1655F04D9
	for <lists+linux-api@lfdr.de>; Thu, 28 May 2026 12:12:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B26AE327F2AB
	for <lists+linux-api@lfdr.de>; Thu, 28 May 2026 09:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9CD83B4EBC;
	Thu, 28 May 2026 09:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b="gBc4gfP8"
X-Original-To: linux-api@vger.kernel.org
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF713B4EA1;
	Thu, 28 May 2026 09:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779962222; cv=pass; b=S2BzuDEjDyMgvZMlDt6GCaHIGEXmHRMvDdTY/98Bm2LL8K3VEN0a597coKIr1XjHmAU+qT8WyMIPdSwFCcffMf7ZqMfx7nYhDtn8JlmmafJmT69fOQHhkUXifN5kKYtXDMCr97Xahb8HwbPFuGPd6rUynLWG2ea/arPcEWLTjGY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779962222; c=relaxed/simple;
	bh=rZBETlh1Itou/PYkHOUZfg2/d01S64VPomuKbb+POXE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u1Kt0vU12kMWVMonhNy/xf6I19lQXr819mfXbLtS5hyTHLL43NrqWh9Wm40I3Lb4M87z4CP9fxLbHCyQbCaQN1QJZjE0QlYa6DG7+331Le152MJ1Bwt397+Obc63XbOP21LJ8+feI1cmEH7e47m6kLHwAS/ni10csoRlsFc78ck=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.beauty; spf=pass smtp.mailfrom=linux.beauty; dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b=gBc4gfP8; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.beauty
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.beauty
ARC-Seal: i=1; a=rsa-sha256; t=1779962043; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=BnNntCmbUKf4NUh48Z2r0u2IDbjj/w0iXW15YeIPR3N1HywAeYCyfFnZd5x83MhJrXQmz7PV4E6mGhhUm474JPLKdAnmgsmbVmC6By4b04WqT5OrersWRpczrrTDx/O3ktho+0gMD/OK1tsjg/AAbcccCD0pCVyRT7ajLvzwSZE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1779962043; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=gAsVDJgosvCSWBsDL3XZWyaqruHWdvlD2MHsizjjyu4=; 
	b=Q6Y6o7FZPjZGdtqwAn7eoC+2aoaKOs70AFdyL2Pzv8tlY90T2Bja4pYJhKJqAPXvAUdAAEJngbsEldQdSYU5YElGtavfVHbDNF5sg0FRSnFQqJLX2sm04hy7kvtDXxs7+70au3M4MxAQdCRfb6eGrgMz0kfTX6170NjHpCnW4Ms=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=linux.beauty;
	spf=pass  smtp.mailfrom=me@linux.beauty;
	dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1779962043;
	s=zmail; d=linux.beauty; i=me@linux.beauty;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=gAsVDJgosvCSWBsDL3XZWyaqruHWdvlD2MHsizjjyu4=;
	b=gBc4gfP8vmf5W9WDs+8sX3GZrDS/QdsZE+7Y0xITrnMA3OpX9BSGes5iHF5x2Cgo
	clnpmBsdfo1m3nEvdS5hROyLCqwETTgs/BhyxYlCqjHJIWd8rKGqaSTOVitsQIoLJur
	o+I1htuKRtuAucOk60r19tVvY3gPfCLzAdT0sIz8=
Received: by mx.zohomail.com with SMTPS id 1779962041120952.1663272372527;
	Thu, 28 May 2026 02:54:01 -0700 (PDT)
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
Subject: [RFC PATCH v1 08/13] binfmt_elf: cache ELF metadata for spawn templates
Date: Thu, 28 May 2026 17:52:29 +0800
Message-ID: <20260528095235.2491226-9-me@linux.beauty>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.beauty:s=zmail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6439-lists,linux-api=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.beauty:email,linux.beauty:mid,linux.beauty:dkim]
X-Rspamd-Queue-Id: ED1655F04D9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Spawn templates keep an opened executable and revalidate its file identity
before every spawn. Add an ELF-side template object for the main
executable.
It caches the executable identity key, ELF header, program header table,
and program header count so repeated spawns can reuse validated metadata.
Do not cache interpreter metadata, shared-library dependency state, or
derived mapping-layout state in this RFC.
Keep the normal exec security path intact. The child still executes through
bprm_execve(), credentials, permissions, and LSM hooks. This only avoids
rereading immutable main-executable metadata after template creation and
revalidation.

Signed-off-by: Li Chen <me@linux.beauty>
---
 fs/binfmt_elf.c                | 104 ++++++++++++++++++++++++++++++++-
 fs/exec.c                      |  37 +++++++++++-
 fs/spawn_template.c            |  38 +++++++-----
 include/linux/binfmts.h        |   6 ++
 include/linux/spawn_template.h |  47 +++++++++++++++
 5 files changed, 213 insertions(+), 19 deletions(-)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 16a56b6b3f6ca..631dd029aeee7 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -48,6 +48,7 @@
 #include <linux/uaccess.h>
 #include <uapi/linux/rseq.h>
 #include <linux/rseq.h>
+#include <linux/spawn_template.h>
 #include <asm/param.h>
 #include <asm/page.h>
 
@@ -552,6 +553,89 @@ static struct elf_phdr *load_elf_phdrs(const struct elfhdr *elf_ex,
 	return elf_phdata;
 }
 
+#if !ELF_COMPAT
+void spawn_exec_template_put(struct spawn_exec_template *tmpl)
+{
+	if (!tmpl)
+		return;
+	if (!refcount_dec_and_test(&tmpl->refcount))
+		return;
+	kfree(tmpl->exec_phdrs);
+	kfree(tmpl);
+}
+
+struct spawn_exec_template *
+spawn_exec_template_get(struct spawn_exec_template *tmpl)
+{
+	refcount_inc(&tmpl->refcount);
+	return tmpl;
+}
+
+bool spawn_exec_template_matches(struct spawn_exec_template *tmpl,
+				 struct file *file)
+{
+	if (!tmpl)
+		return false;
+	if (!spawn_template_file_key_matches(file, &tmpl->exec_key))
+		return false;
+	if (!can_mmap_file(file))
+		return false;
+	return true;
+}
+
+int spawn_exec_template_create(struct file *file,
+			       struct spawn_exec_template **out)
+{
+	struct spawn_exec_template *tmpl;
+	loff_t pos = 0;
+	ssize_t nread;
+	int retval;
+
+	*out = NULL;
+
+	tmpl = kzalloc_obj(*tmpl, GFP_KERNEL);
+	if (!tmpl)
+		return -ENOMEM;
+	refcount_set(&tmpl->refcount, 1);
+
+	spawn_template_fill_file_key(file, &tmpl->exec_key);
+
+	nread = kernel_read(file, &tmpl->exec_ehdr, sizeof(tmpl->exec_ehdr),
+			    &pos);
+	if (nread < 0) {
+		retval = nread;
+		goto out_put_template;
+	}
+
+	retval = -ENOEXEC;
+	if (nread != sizeof(tmpl->exec_ehdr))
+		goto out_put_template;
+	if (memcmp(tmpl->exec_ehdr.e_ident, ELFMAG, SELFMAG) != 0)
+		goto out_put_template;
+	if (tmpl->exec_ehdr.e_type != ET_EXEC &&
+	    tmpl->exec_ehdr.e_type != ET_DYN)
+		goto out_put_template;
+	if (!elf_check_arch(&tmpl->exec_ehdr))
+		goto out_put_template;
+	if (elf_check_fdpic(&tmpl->exec_ehdr))
+		goto out_put_template;
+	if (!can_mmap_file(file))
+		goto out_put_template;
+
+	tmpl->exec_phdrs = load_elf_phdrs(&tmpl->exec_ehdr, file);
+	if (!tmpl->exec_phdrs)
+		goto out_put_template;
+	tmpl->exec_phnum = tmpl->exec_ehdr.e_phnum;
+
+	*out = tmpl;
+	return 0;
+
+out_put_template:
+	spawn_exec_template_put(tmpl);
+	return retval;
+}
+#endif
+
 #ifndef CONFIG_ARCH_BINFMT_ELF_STATE
 
 /**
@@ -832,6 +916,7 @@ static int parse_elf_properties(struct file *f, const struct elf_phdr *phdr,
 static int load_elf_binary(struct linux_binprm *bprm)
 {
 	struct file *interpreter = NULL; /* to shut gcc up */
+	struct spawn_exec_template *spawn_tmpl = bprm->spawn_template;
 	unsigned long load_bias = 0, phdr_addr = 0;
 	int first_pt_load = 1;
 	unsigned long error;
@@ -851,6 +936,12 @@ static int load_elf_binary(struct linux_binprm *bprm)
 	struct arch_elf_state arch_state = INIT_ARCH_ELF_STATE;
 	struct mm_struct *mm;
 	struct pt_regs *regs;
+	bool use_spawn_tmpl = spawn_exec_template_matches(spawn_tmpl, bprm->file);
+	bool free_elf_phdata = true;
+
+	if (use_spawn_tmpl)
+		memcpy(bprm->buf, &spawn_tmpl->exec_ehdr,
+		       sizeof(spawn_tmpl->exec_ehdr));
 
 	retval = -ENOEXEC;
 	/* First of all, some simple consistency checks */
@@ -866,7 +957,12 @@ static int load_elf_binary(struct linux_binprm *bprm)
 	if (!can_mmap_file(bprm->file))
 		goto out;
 
-	elf_phdata = load_elf_phdrs(elf_ex, bprm->file);
+	if (use_spawn_tmpl)
+		elf_phdata = spawn_tmpl->exec_phdrs;
+	else
+		elf_phdata = load_elf_phdrs(elf_ex, bprm->file);
+	if (use_spawn_tmpl)
+		free_elf_phdata = false;
 	if (!elf_phdata)
 		goto out;
 
@@ -1283,7 +1379,8 @@ static int load_elf_binary(struct linux_binprm *bprm)
 		}
 	}
 
-	kfree(elf_phdata);
+	if (free_elf_phdata)
+		kfree(elf_phdata);
 
 	set_binfmt(&elf_format);
 
@@ -1390,7 +1487,8 @@ static int load_elf_binary(struct linux_binprm *bprm)
 	if (interpreter)
 		fput(interpreter);
 out_free_ph:
-	kfree(elf_phdata);
+	if (free_elf_phdata)
+		kfree(elf_phdata);
 	goto out;
 }
 
diff --git a/fs/exec.c b/fs/exec.c
index 5b91a9b208a77..96b6f6274e0d3 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1914,9 +1914,12 @@ static inline struct user_arg_ptr native_arg(const char __user *const __user *p)
 	return (struct user_arg_ptr){.ptr.native = p};
 }
 
-static int do_execveat_file_common(struct file *file, struct filename *filename,
-				   struct user_arg_ptr argv,
-				   struct user_arg_ptr envp, int flags)
+static int do_execveat_file_template_common(struct file *file,
+					    struct filename *filename,
+					    struct user_arg_ptr argv,
+					    struct user_arg_ptr envp,
+					    int flags,
+					    struct spawn_exec_template *tmpl)
 {
 	struct linux_binprm *bprm;
 	struct file *exec_file;
@@ -1940,11 +1943,20 @@ static int do_execveat_file_common(struct file *file, struct filename *filename,
 	if (IS_ERR(bprm))
 		return PTR_ERR(bprm);
 
+	bprm->spawn_template = tmpl;
 	retval = do_execveat_common_bprm(bprm, argv, envp);
 	free_bprm(bprm);
 	return retval;
 }
 
+static int do_execveat_file_common(struct file *file, struct filename *filename,
+				   struct user_arg_ptr argv,
+				   struct user_arg_ptr envp, int flags)
+{
+	return do_execveat_file_template_common(file, filename, argv, envp,
+						flags, NULL);
+}
+
 int kernel_execveat_file(struct file *file, const char *filename,
 			 const void __user *argv,
 			 const void __user *envp,
@@ -1962,6 +1974,25 @@ int kernel_execveat_file(struct file *file, const char *filename,
 				       native_arg(user_envp), flags);
 }
 
+int kernel_execveat_file_template(struct file *file, const char *filename,
+				  const void __user *argv,
+				  const void __user *envp, int flags,
+				  struct spawn_exec_template *tmpl)
+{
+	const char __user *const __user *user_argv;
+	const char __user *const __user *user_envp;
+
+	CLASS(filename_kernel, name)(filename);
+
+	user_argv = (const char __user *const __user *)argv;
+	user_envp = (const char __user *const __user *)envp;
+
+	return do_execveat_file_template_common(file, name,
+						native_arg(user_argv),
+						native_arg(user_envp),
+						flags, tmpl);
+}
+
 void set_binfmt(struct linux_binfmt *new)
 {
 	struct mm_struct *mm = current->mm;
diff --git a/fs/spawn_template.c b/fs/spawn_template.c
index 268f804227987..a11a7ed676416 100644
--- a/fs/spawn_template.c
+++ b/fs/spawn_template.c
@@ -28,7 +28,7 @@
 
 struct spawn_template {
 	struct file *exec_file;
-	struct spawn_template_file_key exec_key;
+	struct spawn_exec_template *exec_template;
 	const struct cred *creator_cred;
 	char *filename;
 	bool deny_write;
@@ -36,6 +36,7 @@ struct spawn_template {
 
 struct spawn_template_spawn_context {
 	struct spawn_template *tmpl;
+	struct spawn_exec_template *exec_template;
 	struct spawn_template_spawn_args args;
 	struct spawn_template_action *actions;
 };
@@ -114,16 +115,16 @@ static bool spawn_template_key_matches(struct spawn_template *tmpl)
 		file = tmp;
 
 		matches = spawn_template_file_key_matches(file,
-							  &tmpl->exec_key);
+				&tmpl->exec_template->exec_key);
 		matches = matches && spawn_template_file_exec_allowed(file);
 		exe_file_allow_write_access(file);
 		if (!matches)
 			return false;
 	}
 
-	return spawn_template_file_exec_allowed(tmpl->exec_file) &&
-	       spawn_template_file_key_matches(tmpl->exec_file,
-					       &tmpl->exec_key);
+	if (!spawn_template_file_exec_allowed(tmpl->exec_file))
+		return false;
+	return spawn_exec_template_matches(tmpl->exec_template, tmpl->exec_file);
 }
 
 static int spawn_template_copy_signal_set(const struct spawn_template_action *action,
@@ -331,26 +332,29 @@ static int spawn_template_child(void *data)
 {
 	struct spawn_template_spawn_context *ctx = data;
 	struct spawn_template *tmpl = ctx->tmpl;
+	struct spawn_exec_template *exec_template = ctx->exec_template;
 	int ret;
 	u64 i;
 
 	for (i = 0; i < ctx->args.actions_len; i++) {
 		ret = spawn_template_apply_action(&ctx->actions[i]);
 		if (ret < 0)
-			goto out_exec_error;
+			goto out_put_exec_template;
 	}
 
 	if (!(ctx->args.flags & SPAWN_TEMPLATE_SPAWN_INHERIT_FDS)) {
 		ret = do_close_range(3, ~0U, 0);
 		if (ret < 0)
-			goto out_exec_error;
+			goto out_put_exec_template;
 	}
 
-	ret = kernel_execveat_file(tmpl->exec_file, "",
-				   u64_to_user_ptr(ctx->args.argv),
-				   u64_to_user_ptr(ctx->args.envp),
-				   AT_EMPTY_PATH);
-out_exec_error:
+	ret = kernel_execveat_file_template(tmpl->exec_file, "",
+					    u64_to_user_ptr(ctx->args.argv),
+					    u64_to_user_ptr(ctx->args.envp),
+					    AT_EMPTY_PATH,
+					    exec_template);
+out_put_exec_template:
+	spawn_exec_template_put(exec_template);
 	if (ret < 0)
 		do_exit(spawn_template_exit_status(ret));
 	return 0;
@@ -373,6 +377,7 @@ static int spawn_template_release(struct inode *inode, struct file *file)
 
 	if (tmpl->deny_write)
 		exe_file_allow_write_access(tmpl->exec_file);
+	spawn_exec_template_put(tmpl->exec_template);
 	fput(tmpl->exec_file);
 	put_cred(tmpl->creator_cred);
 	kfree(tmpl->filename);
@@ -501,7 +506,10 @@ SYSCALL_DEFINE2(spawn_template_create,
 						 &tmpl->deny_write);
 	if (ret)
 		goto out_free_tmpl;
-	spawn_template_fill_file_key(tmpl->exec_file, &tmpl->exec_key);
+
+	ret = spawn_exec_template_create(tmpl->exec_file, &tmpl->exec_template);
+	if (ret)
+		goto out_put_exec;
 
 	if (args.flags & SPAWN_TEMPLATE_CREATE_CLOEXEC)
 		fd_flags |= O_CLOEXEC;
@@ -514,6 +522,7 @@ SYSCALL_DEFINE2(spawn_template_create,
 	return ret;
 
 out_put_exec:
+	spawn_exec_template_put(tmpl->exec_template);
 	if (tmpl->deny_write)
 		exe_file_allow_write_access(tmpl->exec_file);
 	fput(tmpl->exec_file);
@@ -580,6 +589,7 @@ SYSCALL_DEFINE3(spawn_template_spawn, int, template_fd,
 		ret = -ESTALE;
 		goto out_free_actions;
 	}
+	ctx->exec_template = spawn_exec_template_get(ctx->tmpl->exec_template);
 
 	kargs = (struct kernel_clone_args) {
 		.flags		= CLONE_VM | CLONE_VFORK | CLONE_PIDFD,
@@ -590,6 +600,8 @@ SYSCALL_DEFINE3(spawn_template_spawn, int, template_fd,
 	};
 
 	ret = kernel_clone(&kargs);
+	if (ret < 0)
+		spawn_exec_template_put(ctx->exec_template);
 
 out_free_actions:
 	kfree(ctx->actions);
diff --git a/include/linux/binfmts.h b/include/linux/binfmts.h
index c0715678c9a06..4e76a94d331a8 100644
--- a/include/linux/binfmts.h
+++ b/include/linux/binfmts.h
@@ -9,6 +9,7 @@
 
 struct filename;
 struct coredump_params;
+struct spawn_exec_template;
 
 #define CORENAME_MAX_SIZE 128
 
@@ -53,6 +54,7 @@ struct linux_binprm {
 	struct file *executable; /* Executable to pass to the interpreter */
 	struct file *interpreter;
 	struct file *file;
+	struct spawn_exec_template *spawn_template;
 	struct cred *cred;	/* new credentials */
 	int unsafe;		/* how unsafe this exec is (mask of LSM_UNSAFE_*) */
 	unsigned int per_clear;	/* bits to clear in current->personality */
@@ -145,6 +147,10 @@ int kernel_execveat_file(struct file *file, const char *filename,
 			 const void __user *argv,
 			 const void __user *envp,
 			 int flags);
+int kernel_execveat_file_template(struct file *file, const char *filename,
+				  const void __user *argv,
+				  const void __user *envp, int flags,
+				  struct spawn_exec_template *tmpl);
 extern void set_binfmt(struct linux_binfmt *new);
 extern ssize_t read_code(struct file *, unsigned long, loff_t, size_t);
 
diff --git a/include/linux/spawn_template.h b/include/linux/spawn_template.h
index f14a7749fe55b..426413bc11eea 100644
--- a/include/linux/spawn_template.h
+++ b/include/linux/spawn_template.h
@@ -2,7 +2,9 @@
 #ifndef _LINUX_SPAWN_TEMPLATE_H
 #define _LINUX_SPAWN_TEMPLATE_H
 
+#include <linux/elf.h>
 #include <linux/fs.h>
+#include <linux/refcount.h>
 
 struct spawn_template_file_key {
 	dev_t dev;
@@ -17,9 +19,54 @@ struct spawn_template_file_key {
 	u64 mtime_nsec;
 };
 
+struct spawn_exec_template {
+	refcount_t refcount;
+	struct spawn_template_file_key exec_key;
+	struct elfhdr exec_ehdr;
+	struct elf_phdr *exec_phdrs;
+	unsigned int exec_phnum;
+};
+
 void spawn_template_fill_file_key(struct file *file,
 				  struct spawn_template_file_key *key);
 bool spawn_template_file_key_matches(struct file *file,
 				     const struct spawn_template_file_key *key);
 
+#ifdef CONFIG_BINFMT_ELF
+int spawn_exec_template_create(struct file *file,
+			       struct spawn_exec_template **out);
+struct spawn_exec_template *
+spawn_exec_template_get(struct spawn_exec_template *tmpl);
+void spawn_exec_template_put(struct spawn_exec_template *tmpl);
+bool spawn_exec_template_matches(struct spawn_exec_template *tmpl,
+				 struct file *file);
+#else
+static inline int spawn_exec_template_create(struct file *file,
+					     struct spawn_exec_template **out)
+{
+	(void)file;
+	(void)out;
+	return -ENOEXEC;
+}
+
+static inline void spawn_exec_template_put(struct spawn_exec_template *tmpl)
+{
+	(void)tmpl;
+}
+
+static inline struct spawn_exec_template *
+spawn_exec_template_get(struct spawn_exec_template *tmpl)
+{
+	return tmpl;
+}
+
+static inline bool spawn_exec_template_matches(struct spawn_exec_template *tmpl,
+					       struct file *file)
+{
+	(void)tmpl;
+	(void)file;
+	return false;
+}
+#endif
+
 #endif /* _LINUX_SPAWN_TEMPLATE_H */
-- 
2.52.0



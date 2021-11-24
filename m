Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 208E845B1E2
	for <lists+linux-api@lfdr.de>; Wed, 24 Nov 2021 03:13:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240667AbhKXCQj (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 23 Nov 2021 21:16:39 -0500
Received: from sonic315-27.consmr.mail.ne1.yahoo.com ([66.163.190.153]:35041
        "EHLO sonic315-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231596AbhKXCQi (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 23 Nov 2021 21:16:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1637720009; bh=9CzQ9uHdy4do/PNMLqTG82ebvy/4VhJrLPLfMtCcFBQ=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=chjqV0NlpJzct41szmGkgoYyH3DSCRdmIhyQg1OTBiWgCesfkE2pdtv5PEkxnQzsGTB0hnaeuEUTaL5Pw7Vfw3YuONmt6g5wtch9DwmLW6eWd9Dzx+wbsIlA7o3T2EisDgEU61lrT7PVE4NgwmnhcgNeWeASHPMSmJ8ybLfdEjblrjqg2AVbzP7QYr4IwaSJdZX4aFgmpA+l4Kk8KMRNdfXMDAR0tmkYplqMqCSYz5QE6ACqAfs6vjp4Q1KiuGfiwP+A6IijL5Lv+yeiP3XUTcqy5juyzK/3zcu6n+Mv1fWzrJXaAgMHJP2nGdjB54g/K2at+o8tacLXzAtT9OhICg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1637720009; bh=8z/AzwUIY2lRskZNKaFJQUzvZAMMTCozzFrXqsPm1tm=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=YbPxhaqpxt4VVK+B+iE5D0AMbWvkc+Ko6DWmRIuAh9SR2MicROyf4xcx1GvSFjXJbU4yU7ikhyPnNy5U676DLyBcJyPWzglDtJvkOTCIAjeuhq3FyhLCBzbxRf5qqRDQ9NsuhrNLjHl1oTdBdxzPVPmkwvwUo5tP7bGO3w2PiTYkohhYrRYbrz3Op82ansvZGZoUnoCqP0YgCM5qB6gWoqJ0jnj7g4XxQ/wC+6cO8cKjBJc7OHSal1ioYdb/K0+PFaD+tfjuKvRfHD3obDnBIKQz4XpgGg/Gx6zi7cG3vc0EHqKEn4UD/FYkt6FhgyuTVcWa9/+alzT31ePVfaY+Nw==
X-YMail-OSG: lFGB794VM1ldpuqp8mFwcE.bKpo78XErB9W6mO8sCrBmJZm7yNlMpWkQc.EhJTf
 iYt4a5eYnmEWoMAWpka05_p6Z8GrXNRuXAFKvRvdjo0MFCSg6wEoMh9ShIVWTps_5n.3BxotmtqP
 3KR0E0ftDmPncc0I9OSSzuWPU3D4yIpLj4SnAK8wsMVSDHQeOyjaTW4Qlx7D12JprZinDebCubWl
 Uixi3U7I9vm0i03nWcm_dijFQVZHxh6VH4E5y5sVk3N1hPh_CBf_9wrOPgITwQUNhnaP54_T0ksc
 dUV4O_ywqA17oJkIOAUn_dsG0bnyB1fCZRvlj9MdDJj2hVhBkf7_UMozmh83u5v2WVrw63aOxQpV
 bMAF6i.9j0xIQZTnNcyue2jk3PdI87cmLlRTF3JC.wzPzg9rLC.DEtsEFvEPZg66EHi5sJz_m9kG
 ESPXOLyo4cZErSz_BadJhhNw9HT1EgdQ3sQpFdygPXkD3tpsXMqM3zZwVJex03MAITw5ZoT5pIIw
 bQwjF7jY9w2bG6x.9fmtYN_kWrOwLlOiHEFjWA1d92L78aR53Riewk3kYSBZK_uWieIQSpTi2Yi4
 lZ0Sb7C4Keqv._cCmztLAqk10cPV2RkIh3.fB59b6lNzwuooGIojCuOLuVx0guKGrcNf3Fi8OvCo
 vhapLJDJ2b5ypplh4ygIvTBRe8Vw5eW9YHPAS4BUyDXJjdndAJ7jIGRU9yDVWILrLgXFlw.0EDq.
 pXgfUs45JGJbKw1TLpANOmdKT7TzcBROYIpUw4IyijYub2JxNCCQ7nGwkabJUko1XO0pqL1Hp0kh
 OFiz51vaQcaTxaLWqL3ebXAhC3FO2KRa9oISFDRCy9ByBqd356TyuN3h7EHt9DH9EvXVQuMwMpqr
 zcWJXf4jsFyqhK.21wXt2Y2v0do0_De.nD2GODk3qaWMAC2JPfAxHUkrbDdUVfYD1lbl.NnnBM6e
 2wNliEV3cCYkhWqVuYP2DmsnBcDWSeL8D80RmyWjJSM0LqRry9ECOMNN5k42ekL7d8IUYZL5XMBK
 ihwQuySoqH2oK4nBhnrDhGrfZJ1mX29fF2jcTDJxQixAn_Hq1kYZTYiPBLS2jWimd0Ysku_TYhMP
 MAZq_B3eeM_eimEoF_WC6fAcmTwWUxCsF9.66ySw.kz3gC7fjYpYAo.5xcKrqpVFARkPSQQjIBvs
 0usFVujGfSkzsJ6AcwRrNrNI6kj9iQfBkLGOBzyBhet93v_YCQ8KriHP6L_laIXti4wu.oOGYJRz
 r8ZAIpbPtD3NOsrwkxONnxo.Bs3tsZkDaksE2cvymMyH3Tbynay2QP1QROQq4jMGgtwbl.0_EAbm
 Ok3JCn37fclLv5aN0ss8.jbz6ufsvZHhyQB6uW.56WkuDe6HSio.2_WftrN9i4DbB26UDuWUGLGf
 4qr7N_NiW0cIe2rNargdR22WrN4zJRRS6KOTrjqcWA99nmLTbRWO8BIHyYYk07GiQfMcNlsYxmlj
 X1drG.TsTS0qhcg32f5fCwU8vFKhKduKm4PByQWjsoToYgXW2AaoBQOk0oHgzGy7I0VAJO5cOAW.
 _NuhAvujVzcFl3amF1eAh_7zin17aixcoOoDQ_NmTnaCIi2u.6k7cB7FsfX.RWiW17pFeke5aZwE
 ezHvyNq6XEeKdmkvt7M8OP6lwMBQx8wWfb8Q0rPjGLHTiNvqLQxJQT.Tv3dbK7alFNcjJ2oFwg2O
 x.9mO8tbPUDxWrSKG.sVJcYI71l59Tu323wLo1192wCsR78XogkM2B_k52aeh_Fad2K6Rzz_ErE6
 o5WH15yVbkDuiumc0qmwzDKLy1UCXDIUgRRTI5Gh7z9J5CaSk.zOsS099lVkhxForMRddNlBu33R
 bU28Hn9jMHw8Bt.ynMSDYgVZEpvXSWlNYp8U8Y2KVnH.19jkfqVfAO0unh1nbzbF9JdzPMsGjWyg
 eB2XuiMnTnNoGNHdCbHAkTVhJFm9z12CmB9U99oCSS8oxzqFILcLl4ityP2CxYNAT7wvJnPmmLl5
 zwEf7MIYAV6AmeYndf4zQdgphys1FyT_GT9s4GNRbVNsL._n2jqnUGCUw8TyUgLTx_l2ri3wr5A5
 i8vsn8U1.EdhAZh6pYE.zczs8Wk4TrwrIU3vl9hEEJQqUSgocCQGdX1.QYjrIZUpTm8MXXODefzQ
 CMmbrcY2orNacihIrXwftth.ZVC1biIvra4ig_7lghk30OJ2DIYbGRqqy7dvWp9ASy1bVXDjKWcK
 01RRwu0PiAnq4HWh0ZkUWs5XJwtboSf7vEBVhYaU02w--
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.ne1.yahoo.com with HTTP; Wed, 24 Nov 2021 02:13:29 +0000
Received: by kubenode524.mail-prod1.omega.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID fef1b8bbd5fbeb140c8e00bf0e5b2b51;
          Wed, 24 Nov 2021 02:13:24 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-doc@vger.kernel.org
Subject: [PATCH v30 27/28] LSM: Add /proc attr entry for full LSM context
Date:   Tue, 23 Nov 2021 17:43:31 -0800
Message-Id: <20211124014332.36128-28-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211124014332.36128-1-casey@schaufler-ca.com>
References: <20211124014332.36128-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Add an entry /proc/.../attr/context which displays the full
process security "context" in compound format:
        lsm1\0value\0lsm2\0value\0...
This entry is not writable.

A security module may decide that its policy does not allow
this information to be displayed. In this case none of the
information will be displayed.

Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
Cc: linux-api@vger.kernel.org
Cc: linux-doc@vger.kernel.org
---
 Documentation/security/lsm.rst       | 14 +++++
 fs/proc/base.c                       |  1 +
 include/linux/lsm_hooks.h            |  6 +++
 security/apparmor/include/procattr.h |  2 +-
 security/apparmor/lsm.c              |  8 ++-
 security/apparmor/procattr.c         | 22 ++++----
 security/security.c                  | 79 ++++++++++++++++++++++++++++
 security/selinux/hooks.c             |  2 +-
 security/smack/smack_lsm.c           |  2 +-
 9 files changed, 121 insertions(+), 15 deletions(-)

diff --git a/Documentation/security/lsm.rst b/Documentation/security/lsm.rst
index b77b4a540391..070225ae6ceb 100644
--- a/Documentation/security/lsm.rst
+++ b/Documentation/security/lsm.rst
@@ -143,3 +143,17 @@ separated list of the active security modules.
 The file ``/proc/pid/attr/interface_lsm`` contains the name of the security
 module for which the ``/proc/pid/attr/current`` interface will
 apply. This interface can be written to.
+
+The infrastructure does provide an interface for the special
+case where multiple security modules provide a process context.
+This is provided in compound context format.
+
+-  `lsm\0value\0lsm\0value\0`
+
+The `lsm` and `value` fields are NUL-terminated bytestrings.
+Each field may contain whitespace or non-printable characters.
+The NUL bytes are included in the size of a compound context.
+The context ``Bell\0Secret\0Biba\0Loose\0`` has a size of 23.
+
+The file ``/proc/pid/attr/context`` provides the security
+context of the identified process.
diff --git a/fs/proc/base.c b/fs/proc/base.c
index 50dbe5612a26..c90022027357 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -2829,6 +2829,7 @@ static const struct pid_entry attr_dir_stuff[] = {
 	ATTR(NULL, "keycreate",		0666),
 	ATTR(NULL, "sockcreate",	0666),
 	ATTR(NULL, "interface_lsm",	0666),
+	ATTR(NULL, "context",		0444),
 #ifdef CONFIG_SECURITY_SMACK
 	DIR("smack",			0555,
 	    proc_smack_attr_dir_inode_ops, proc_smack_attr_dir_ops),
diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 490545f0db6d..b919d5ab9120 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -1400,6 +1400,12 @@
  *	@pages contains the number of pages.
  *	Return 0 if permission is granted.
  *
+ * @getprocattr:
+ *	Provide the named process attribute for display in special files in
+ *	the /proc/.../attr directory.  Attribute naming and the data displayed
+ *	is at the discretion of the security modules.  The exception is the
+ *	"context" attribute, which will contain the security context of the
+ *	task as a nul terminated text string without trailing whitespace.
  * @ismaclabel:
  *	Check if the extended attribute specified by @name
  *	represents a MAC label. Returns 1 if name is a MAC
diff --git a/security/apparmor/include/procattr.h b/security/apparmor/include/procattr.h
index 31689437e0e1..03dbfdb2f2c0 100644
--- a/security/apparmor/include/procattr.h
+++ b/security/apparmor/include/procattr.h
@@ -11,7 +11,7 @@
 #ifndef __AA_PROCATTR_H
 #define __AA_PROCATTR_H
 
-int aa_getprocattr(struct aa_label *label, char **string);
+int aa_getprocattr(struct aa_label *label, char **string, bool newline);
 int aa_setprocattr_changehat(char *args, size_t size, int flags);
 
 #endif /* __AA_PROCATTR_H */
diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index 5ed40fd93ce9..28ed41a3ffcf 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -602,6 +602,7 @@ static int apparmor_getprocattr(struct task_struct *task, char *name,
 	const struct cred *cred = get_task_cred(task);
 	struct aa_task_ctx *ctx = task_ctx(current);
 	struct aa_label *label = NULL;
+	bool newline = true;
 
 	if (strcmp(name, "current") == 0)
 		label = aa_get_newest_label(cred_label(cred));
@@ -609,11 +610,14 @@ static int apparmor_getprocattr(struct task_struct *task, char *name,
 		label = aa_get_newest_label(ctx->previous);
 	else if (strcmp(name, "exec") == 0 && ctx->onexec)
 		label = aa_get_newest_label(ctx->onexec);
-	else
+	else if (strcmp(name, "context") == 0) {
+		label = aa_get_newest_label(cred_label(cred));
+		newline = false;
+	} else
 		error = -EINVAL;
 
 	if (label)
-		error = aa_getprocattr(label, value);
+		error = aa_getprocattr(label, value, newline);
 
 	aa_put_label(label);
 	put_cred(cred);
diff --git a/security/apparmor/procattr.c b/security/apparmor/procattr.c
index fde332e0ea7d..172550f67fc0 100644
--- a/security/apparmor/procattr.c
+++ b/security/apparmor/procattr.c
@@ -20,6 +20,7 @@
  * aa_getprocattr - Return the profile information for @profile
  * @profile: the profile to print profile info about  (NOT NULL)
  * @string: Returns - string containing the profile info (NOT NULL)
+ * @newline: Should a newline be added to @string.
  *
  * Requires: profile != NULL
  *
@@ -28,20 +29,21 @@
  *
  * Returns: size of string placed in @string else error code on failure
  */
-int aa_getprocattr(struct aa_label *label, char **string)
+int aa_getprocattr(struct aa_label *label, char **string, bool newline)
 {
 	struct aa_ns *ns = labels_ns(label);
 	struct aa_ns *current_ns = aa_get_current_ns();
+	int flags = FLAG_VIEW_SUBNS | FLAG_HIDDEN_UNCONFINED;
 	int len;
 
 	if (!aa_ns_visible(current_ns, ns, true)) {
 		aa_put_ns(current_ns);
 		return -EACCES;
 	}
+	if (newline)
+		flags |= FLAG_SHOW_MODE;
 
-	len = aa_label_snxprint(NULL, 0, current_ns, label,
-				FLAG_SHOW_MODE | FLAG_VIEW_SUBNS |
-				FLAG_HIDDEN_UNCONFINED);
+	len = aa_label_snxprint(NULL, 0, current_ns, label, flags);
 	AA_BUG(len < 0);
 
 	*string = kmalloc(len + 2, GFP_KERNEL);
@@ -50,19 +52,19 @@ int aa_getprocattr(struct aa_label *label, char **string)
 		return -ENOMEM;
 	}
 
-	len = aa_label_snxprint(*string, len + 2, current_ns, label,
-				FLAG_SHOW_MODE | FLAG_VIEW_SUBNS |
-				FLAG_HIDDEN_UNCONFINED);
+	len = aa_label_snxprint(*string, len + 2, current_ns, label, flags);
 	if (len < 0) {
 		aa_put_ns(current_ns);
 		return len;
 	}
 
-	(*string)[len] = '\n';
-	(*string)[len + 1] = 0;
+	if (newline) {
+		(*string)[len] = '\n';
+		(*string)[++len] = 0;
+	}
 
 	aa_put_ns(current_ns);
-	return len + 1;
+	return len;
 }
 
 /**
diff --git a/security/security.c b/security/security.c
index 1d28d25d0ade..83b588a87de2 100644
--- a/security/security.c
+++ b/security/security.c
@@ -802,6 +802,57 @@ static int lsm_superblock_alloc(struct super_block *sb)
 	return 0;
 }
 
+/**
+ * append_ctx - append a lsm/context pair to a compound context
+ * @ctx: the existing compound context
+ * @ctxlen: size of the old context, including terminating nul byte
+ * @lsm: new lsm name, nul terminated
+ * @new: new context, possibly nul terminated
+ * @newlen: maximum size of @new
+ *
+ * replace @ctx with a new compound context, appending @newlsm and @new
+ * to @ctx. On exit the new data replaces the old, which is freed.
+ * @ctxlen is set to the new size, which includes a trailing nul byte.
+ *
+ * Returns 0 on success, -ENOMEM if no memory is available.
+ */
+static int append_ctx(char **ctx, int *ctxlen, const char *lsm, char *new,
+		      int newlen)
+{
+	char *final;
+	size_t llen;
+	size_t nlen;
+	size_t flen;
+
+	llen = strlen(lsm) + 1;
+	/*
+	 * A security module may or may not provide a trailing nul on
+	 * when returning a security context. There is no definition
+	 * of which it should be, and there are modules that do it
+	 * each way.
+	 */
+	nlen = strnlen(new, newlen);
+
+	flen = *ctxlen + llen + nlen + 1;
+	final = kzalloc(flen, GFP_KERNEL);
+
+	if (final == NULL)
+		return -ENOMEM;
+
+	if (*ctxlen)
+		memcpy(final, *ctx, *ctxlen);
+
+	memcpy(final + *ctxlen, lsm, llen);
+	memcpy(final + *ctxlen + llen, new, nlen);
+
+	kfree(*ctx);
+
+	*ctx = final;
+	*ctxlen = flen;
+
+	return 0;
+}
+
 /*
  * The default value of the LSM hook is defined in linux/lsm_hook_defs.h and
  * can be accessed with:
@@ -2207,6 +2258,10 @@ int security_getprocattr(struct task_struct *p, const char *lsm, char *name,
 				char **value)
 {
 	struct security_hook_list *hp;
+	char *final = NULL;
+	char *cp;
+	int rc = 0;
+	int finallen = 0;
 	int ilsm = lsm_task_ilsm(current);
 	int slot = 0;
 
@@ -2234,6 +2289,30 @@ int security_getprocattr(struct task_struct *p, const char *lsm, char *name,
 		return -ENOMEM;
 	}
 
+	if (!strcmp(name, "context")) {
+		hlist_for_each_entry(hp, &security_hook_heads.getprocattr,
+				     list) {
+			rc = hp->hook.getprocattr(p, "context", &cp);
+			if (rc == -EINVAL)
+				continue;
+			if (rc < 0) {
+				kfree(final);
+				return rc;
+			}
+			rc = append_ctx(&final, &finallen, hp->lsmid->lsm,
+					cp, rc);
+			kfree(cp);
+			if (rc < 0) {
+				kfree(final);
+				return rc;
+			}
+		}
+		if (final == NULL)
+			return -EINVAL;
+		*value = final;
+		return finallen;
+	}
+
 	hlist_for_each_entry(hp, &security_hook_heads.getprocattr, list) {
 		if (lsm != NULL && strcmp(lsm, hp->lsmid->lsm))
 			continue;
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 6f790d96594d..cbacfdabbc30 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -6399,7 +6399,7 @@ static int selinux_getprocattr(struct task_struct *p,
 			goto bad;
 	}
 
-	if (!strcmp(name, "current"))
+	if (!strcmp(name, "current") || !strcmp(name, "context"))
 		sid = __tsec->sid;
 	else if (!strcmp(name, "prev"))
 		sid = __tsec->osid;
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 9832b5e5c9fd..e5437d72699b 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -3486,7 +3486,7 @@ static int smack_getprocattr(struct task_struct *p, char *name, char **value)
 	char *cp;
 	int slen;
 
-	if (strcmp(name, "current") != 0)
+	if (strcmp(name, "current") != 0 && strcmp(name, "context") != 0)
 		return -EINVAL;
 
 	cp = kstrdup(skp->smk_known, GFP_KERNEL);
-- 
2.31.1


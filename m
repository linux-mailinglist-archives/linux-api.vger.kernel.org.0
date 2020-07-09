Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C3AF219550
	for <lists+linux-api@lfdr.de>; Thu,  9 Jul 2020 02:42:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726268AbgGIAmK (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 8 Jul 2020 20:42:10 -0400
Received: from sonic312-28.consmr.mail.bf2.yahoo.com ([74.6.128.90]:39339 "EHLO
        sonic312-28.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726247AbgGIAmJ (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 8 Jul 2020 20:42:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1594255326; bh=4228W1GErw+E68Hl2vfceqMx2TcLqWF4MIJeyjEYwV0=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=uFT/YB64IqF0CMrc/Ymi+rPUWeEwAerBdw+9UwK5vUdu2mcSylFpymKznp2CvdFnRqMiPG38qQIgAdLtGn79F7XtdzSqmmBGabXzqWPqGTzVD1af8l6heFUeCS0mgViRq4bh7EVzulzgI9DcX2vYpzRhb0F181WTUy4aJzKLghBpSwQYE9pzAAEFexjslkYCg3kJE53HLP3d68YHp8x5+bD3MnK014+rXv7eIqhP47ZFd/d9LGqJtKytJPmLAeMopYN3JogtziWIw5yZZGdKoptYGu51iwoEAB4/15Rz6fxvV8iFlRs8nAxu8wtBkL10uu5N1M2Xk2lg8qKkL8kqyg==
X-YMail-OSG: sK6ZPEoVM1ngILtpNkSGjZigmcjHkHDkHwtUwUTZflU6LC5ZtCdnpifnwnoHyel
 veLljH7zWkrwJx9TdxXo00UT1Apev9v2LdumybdEfGBQpRL13lVZq3UehrpSQ3JO_NYaRKChrWch
 lG1YTtQKpf9rKZwG1TrNGsO7fg1UxSwTT74xja8gHjnC6ycOz6ITr1bsCz3oniezPWNAoZGdCGR6
 RG2it3dNAzGD03yce9btdGfmSprtcmMq6SfLeWZFzL7Y0dpludDbg6k9IzRZhp7m7T54kTRTsDYT
 qwr9BCmc6c2BE0BXIEGb27fxx.j.gWfqq8ZJaz48Rr8YWs__d9fI6uO69tynbOlLNyEaTEC_JLZG
 xLhckesPetDNPrWL7k1GpRq.xlAGtwDCD1pDn6xM6OpARqufkq7V1NoDGccRKWbIm6zHiuXor45N
 pfUVKy.4EQu2SYGsicY7a1iG0wrIuYFuOjyXthNTp4ZZyJjNfRRDL7faWSc1iJcLohQ79cxwnzcL
 TxObR1PEiVEl0_L7pZzslB01FsTZBWipjcExwXh9QvPJUIAEi729WqwIXN_D7YzhHM2ycnaPvE6X
 xpE7.XPPypqi1ZP4eGlH0ZXKahwUFppC7BOD1Yv8pYUA_rSYTVpn70CsYZmm9XYqsoyNj_y3ScJm
 N8y7AJmDLpeGX1h9nJlvCgRh5aSuFcd1O3096ShNBDDwGFvx07HRxRi4ljeksi9y5WcBCnTXvyD.
 zpmrAE0FvZx8sQv91yO3Q.OhaocCRU1oFlTEdJiC74lx8dEf8zzN9DV_CkhnGEzSB.dD7jR9vKpO
 r1I4lolyYm5ioJeZ6gogrrGbTuW23qHxRjl3xS5OgobJr9ZGQjgn57l_VlFt8RAd_JhP3QHAE9UH
 zRkoBPH8ZFw93y0YcSQiLKnyvUTZT24tEBWRSSylsyKj5dtSAl6i4w07LlMS9Xk1NLCCSYR_Yhc1
 ru_KvdCqjxYem_2FuT57JMQGRwVm0KLioKK1X2rBMEdM_HNqntmlWS0ZogSgOEWFyYGT4susxGGN
 Ec.Zv0QUV1MAViWPZODF2TBhm5JenowrGlpAGm8eGNX6A.lSV3cw66JBAtaNUToxpmwssO9CoZLE
 7rvPHdrbi3XOuI4FyTbl0ebkGxo4glQQD.JJemWZCe9KxaRPry64gM1H2pI15CJpw6nT6VmuRZWy
 nz.l57F.2cNThycGnMMP_XzmN_9yaaHs7Am3o6chnRL7sS6E49fFNx1YQ1ZoTHO312g5DLot3vba
 2eq_ZWXVVTzmPhJrIEtBTu_wac8EhqXJ.tJNyUaVKJv5KDgfhnKaiu2NuW36R345zzyuBfh6ozrm
 jxg4bPwRf0bVgsbqeFeRmpWQ_t1liK2Y7WXRsT_IoWfQLDsJP_T4xwx1Zz27eVT7eCZ8iXmqpf0W
 uxFGCvISRylUfNHV2yHEnXS10.WKh4RMnYfT4wg--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.bf2.yahoo.com with HTTP; Thu, 9 Jul 2020 00:42:06 +0000
Received: by smtp432.mail.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 6ae060fe271ab07d982a6b50be09ddd5;
          Thu, 09 Jul 2020 00:42:01 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov, linux-api@vger.kernel.org
Subject: [PATCH v18 22/23] LSM: Add /proc attr entry for full LSM context
Date:   Wed,  8 Jul 2020 17:12:33 -0700
Message-Id: <20200709001234.9719-23-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200709001234.9719-1-casey@schaufler-ca.com>
References: <20200709001234.9719-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Add an entry /proc/.../attr/context which displays the full
process security "context" in compound format:
        lsm1\0value\0lsm2\0value\0...
This entry is not writable.

Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
Cc: linux-api@vger.kernel.org
---
 Documentation/security/lsm.rst       | 28 +++++++++++++
 fs/proc/base.c                       |  1 +
 include/linux/lsm_hooks.h            |  6 +++
 security/apparmor/include/procattr.h |  2 +-
 security/apparmor/lsm.c              |  8 +++-
 security/apparmor/procattr.c         | 22 +++++-----
 security/security.c                  | 63 ++++++++++++++++++++++++++++
 security/selinux/hooks.c             |  2 +-
 security/smack/smack_lsm.c           |  2 +-
 9 files changed, 119 insertions(+), 15 deletions(-)

diff --git a/Documentation/security/lsm.rst b/Documentation/security/lsm.rst
index 6a2a2e973080..fd4c87358d54 100644
--- a/Documentation/security/lsm.rst
+++ b/Documentation/security/lsm.rst
@@ -129,3 +129,31 @@ to identify it as the first security module to be registered.
 The capabilities security module does not use the general security
 blobs, unlike other modules. The reasons are historical and are
 based on overhead, complexity and performance concerns.
+
+LSM External Interfaces
+=======================
+
+The LSM infrastructure does not generally provide external interfaces.
+The individual security modules provide what external interfaces they
+require.
+
+The file ``/sys/kernel/security/lsm`` provides a comma
+separated list of the active security modules.
+
+The file ``/proc/pid/attr/display`` contains the name of the security
+module for which the ``/proc/pid/attr/current`` interface will
+apply. This interface can be written to.
+
+The infrastructure does provide an interface for the special
+case where multiple security modules provide a process context.
+This is provided in compound context format.
+
+-  `lsm\0value\0lsm\0value\0`
+
+The `lsm` and `value` fields are nul terminated bytestrings.
+Each field may contain whitespace or non-printable characters.
+The nul bytes are included in the size of a compound context.
+The context ``Bell\0Secret\0Biba\0Loose\0`` has a size of 23.
+
+The file ``/proc/pid/attr/context`` provides the security
+context of the identified process.
diff --git a/fs/proc/base.c b/fs/proc/base.c
index 40471a12ced2..ba8b0316e999 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -2795,6 +2795,7 @@ static const struct pid_entry attr_dir_stuff[] = {
 	ATTR(NULL, "keycreate",		0666),
 	ATTR(NULL, "sockcreate",	0666),
 	ATTR(NULL, "display",		0666),
+	ATTR(NULL, "context",		0444),
 #ifdef CONFIG_SECURITY_SMACK
 	DIR("smack",			0555,
 	    proc_smack_attr_dir_inode_ops, proc_smack_attr_dir_ops),
diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index e6d72a010606..ceaba9d4792a 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -1359,6 +1359,12 @@
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
index 31a6f11890f1..7ce570b0f491 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -593,6 +593,7 @@ static int apparmor_getprocattr(struct task_struct *task, char *name,
 	const struct cred *cred = get_task_cred(task);
 	struct aa_task_ctx *ctx = task_ctx(current);
 	struct aa_label *label = NULL;
+	bool newline = true;
 
 	if (strcmp(name, "current") == 0)
 		label = aa_get_newest_label(cred_label(cred));
@@ -600,11 +601,14 @@ static int apparmor_getprocattr(struct task_struct *task, char *name,
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
index c929bf4a3df1..be3b083d9b74 100644
--- a/security/apparmor/procattr.c
+++ b/security/apparmor/procattr.c
@@ -20,6 +20,7 @@
  * aa_getprocattr - Return the profile information for @profile
  * @profile: the profile to print profile info about  (NOT NULL)
  * @string: Returns - string containing the profile info (NOT NULL)
+ * @newline: Should a newline be added to @string.
  *
  * Returns: length of @string on success else error on failure
  *
@@ -30,20 +31,21 @@
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
@@ -52,19 +54,19 @@ int aa_getprocattr(struct aa_label *label, char **string)
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
index 2b729d8c94b4..3469a387d6b0 100644
--- a/security/security.c
+++ b/security/security.c
@@ -754,6 +754,42 @@ static void __init lsm_early_task(struct task_struct *task)
 		panic("%s: Early task alloc failed.\n", __func__);
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
+	int llen;
+
+	llen = strlen(lsm) + 1;
+	newlen = strnlen(new, newlen) + 1;
+
+	final = kzalloc(*ctxlen + llen + newlen, GFP_KERNEL);
+	if (final == NULL)
+		return -ENOMEM;
+	if (*ctxlen)
+		memcpy(final, *ctx, *ctxlen);
+	memcpy(final + *ctxlen, lsm, llen);
+	memcpy(final + *ctxlen + llen, new, newlen);
+	kfree(*ctx);
+	*ctx = final;
+	*ctxlen = *ctxlen + llen + newlen;
+	return 0;
+}
+
 /*
  * The default value of the LSM hook is defined in linux/lsm_hook_defs.h and
  * can be accessed with:
@@ -2109,6 +2145,10 @@ int security_getprocattr(struct task_struct *p, const char *lsm, char *name,
 				char **value)
 {
 	struct security_hook_list *hp;
+	char *final = NULL;
+	char *cp;
+	int rc = 0;
+	int finallen = 0;
 	int display = lsm_task_display(current);
 	int slot = 0;
 
@@ -2136,6 +2176,29 @@ int security_getprocattr(struct task_struct *p, const char *lsm, char *name,
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
index c13c207c5da1..43d5c09b9a9e 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -6288,7 +6288,7 @@ static int selinux_getprocattr(struct task_struct *p,
 			goto bad;
 	}
 
-	if (!strcmp(name, "current"))
+	if (!strcmp(name, "current") || !strcmp(name, "context"))
 		sid = __tsec->sid;
 	else if (!strcmp(name, "prev"))
 		sid = __tsec->osid;
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 6f0cdb40addc..d7bb6442f192 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -3463,7 +3463,7 @@ static int smack_getprocattr(struct task_struct *p, char *name, char **value)
 	char *cp;
 	int slen;
 
-	if (strcmp(name, "current") != 0)
+	if (strcmp(name, "current") != 0 && strcmp(name, "context") != 0)
 		return -EINVAL;
 
 	cp = kstrdup(skp->smk_known, GFP_KERNEL);
-- 
2.24.1


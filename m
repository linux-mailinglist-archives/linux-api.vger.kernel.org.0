Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66E9B1D4129
	for <lists+linux-api@lfdr.de>; Fri, 15 May 2020 00:36:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728693AbgENWgA (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 14 May 2020 18:36:00 -0400
Received: from sonic309-27.consmr.mail.ne1.yahoo.com ([66.163.184.153]:40911
        "EHLO sonic309-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728691AbgENWgA (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 14 May 2020 18:36:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1589495758; bh=3beK+ogxBqm+QoaMAavdpBZfMsQV1hwY01hYye7ssKs=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=MGYzgafo2NJwSK7f/JpZJrNIH/gCyJh5WDBfARvS+fy2RLtyVhcBhjK8QMVkqz3Pbvs18fP5t4encSXy6gnzb0KKiebYacdmMPgj1uvo7tQhI0H7wQ4Qv6eQ80TXhyzlgEVN/HVdsi1Vk6E6wbNlm45U0exSDQUvxUHNGVi/z2CTWuJchNlDr+cI+bypYaX6AHrSkqUL04grejUHMBeC8pyfvVimKmF3jdscH1i8gIDXf953YGmxaZvCi3IEZ8Im87VgsEnawsHQxVUxJVT0xyGEXNYHlRwzVM8fFlLYfshIpcAGufEMmktXJpDtxBT0OKcDNKo9w3JRHHtGyDyesg==
X-YMail-OSG: q_aV3LIVM1ldjPsCrnbfbU8WqQLj6OhCpH4nrD.ozgPQfjlvpCPxf5vxdM_wb1o
 PY0GUGx.HBcPNjL2K9EnUikJQZY0TXoV3WRn01DV2UuYjDn4fR_6sXx_XQ9TtrVEVHJ6G2oqWCyb
 Z7SsYyRSMJJW4.fJluNnVCzlddO4C3S7R22G.nuODxQ1Jww_bAqiS2T7fYbH8ajSA7n8i1.Uv94d
 507yE_HVtK5q7C8.kR.4lqXo4PddHnI7vzgL_rlyUwdo7HBqPOUSY.eGj17FjodH9gqBB0gZThuD
 _QLMAy_WBD08yu7uE82whdkZ6LgMgxHVeTcdjsOW.TSItFJdQDJWqN_HOI.oKgUeg7ik0wIGC_uc
 OJN1CI5EsVEOKXYDv.FKl7kh_SVi._5Ld_Ra30_y3TuhPJl0Axmujqi6xD4zK5ZoBW7vUVJ1iuFj
 i1cNehU2CXbs7ExGqq0.YlIFY8AR.qq87DTMyoOy.B3_pG9pxnluuAQ55LPcLiVaQ28nQIXXYn04
 I3MUOHoC0UtlB91GXpVVY_407kLmZNJCMiruBn7KEhay_VQNnOCMukZa7u4pKch5hqHV1X9S5ABg
 3ENuyEl.mXELummv7gStL2MY4XOKRmXM3exovFLWgj7eTjIs45j2_1IEtGlUZUEqBCW2h6fBqobG
 xfu.E1OwFuR0DL82qfOMgob11iJtNEbLHyVcD9m2Z7e5CxaaZpgmkWIy0NQgYH6MQfWpOBH0wYqI
 auYLU6Pv5jJEmGzFj4oj2WgM1nDl2RC22MuEbAhozL_RASxPybDb_V8IL26racTaXnpPJfVLTYHu
 xbBT1SZZgrBPD3fr4S.OAvFThAr.k_kvtQ0bqDCIyPMSyfVTZHZatYtmCg4LYhU6C9yYOI3dod8D
 iM6UJ0kLuPWhZ1eZDtuY56k0slEiFiVbBfc2.kuCRTGrOBd_VCn6RakmcOsXy9loyYVbG8MvpdCX
 Ro1CJjRq.YYO5lRJ.NcuM.MawJvZMDj7EO7KYrpKamIkS3dZsoCNk6chS3ol0OuSGj2879MdgUvw
 VCzQmwSgbKe1afts1Uqw1dEq1Tpy9JcQQ54bppONwVX2lTf40i2EDPWB_PrYqrC0x0D8tDMEAx_F
 qx8eDHYGOceGv_8KM76OTORT4JEcoZSq5_mzdMLppwysiwOWFuxzN1hIQD6P5bsJA8TliIGD5ug7
 EUtGrvR1GRIs9K9puB.eBWoiJqKREst4qy_tkvPbLfCVPKR7809gXFeKpOnkJGdlC7hmkCldCUZQ
 j3.Ro.fn9ehF.0_y5kb2ATHKEy6Tur7mku_hPCawnPyF7.H3eaPHh.WFcm0Rgz.hhCpsS4UVnzwR
 f9O2mYdrBQ8vyCbJoXhn49fAW9I9TIum6HuDtPXwsuxsouCxoN3M4_sTkDYI2lDKWBYgBd_zGNpc
 te4.IuIzVPd9s3sxo7BxWqxAe32CQtS936wxUOcEEuJgg2LAQmso.
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.ne1.yahoo.com with HTTP; Thu, 14 May 2020 22:35:58 +0000
Received: by smtp432.mail.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 2b59ec49d81f9b4bef3661dd6598bdb2;
          Thu, 14 May 2020 22:35:54 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov, linux-audit@redhat.com,
        linux-api@vger.kernel.org
Subject: [PATCH v17 22/23] LSM: Add /proc attr entry for full LSM context
Date:   Thu, 14 May 2020 15:11:41 -0700
Message-Id: <20200514221142.11857-23-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200514221142.11857-1-casey@schaufler-ca.com>
References: <20200514221142.11857-1-casey@schaufler-ca.com>
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
index aadf47c808c0..304260778cab 100644
--- a/Documentation/security/lsm.rst
+++ b/Documentation/security/lsm.rst
@@ -199,3 +199,31 @@ capability-related fields:
 -  ``fs/nfsd/auth.c``::c:func:`nfsd_setuser()`
 
 -  ``fs/proc/array.c``::c:func:`task_cap()`
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
index 8217e2642096..3983b29316ea 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -2778,6 +2778,7 @@ static const struct pid_entry attr_dir_stuff[] = {
 	ATTR(NULL, "keycreate",		0666),
 	ATTR(NULL, "sockcreate",	0666),
 	ATTR(NULL, "display",		0666),
+	ATTR(NULL, "context",		0444),
 #ifdef CONFIG_SECURITY_SMACK
 	DIR("smack",			0555,
 	    proc_smack_attr_dir_inode_ops, proc_smack_attr_dir_ops),
diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 7799c6d2a63a..c986cd21cb4f 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -1342,6 +1342,12 @@
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
index 16b992235c11..02f305ab2c69 100644
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
index ed20d4c6ed93..691748cf1c50 100644
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
@@ -2092,6 +2128,10 @@ int security_getprocattr(struct task_struct *p, const char *lsm, char *name,
 				char **value)
 {
 	struct security_hook_list *hp;
+	char *final = NULL;
+	char *cp;
+	int rc = 0;
+	int finallen = 0;
 	int display = lsm_task_display(current);
 	int slot = 0;
 
@@ -2119,6 +2159,29 @@ int security_getprocattr(struct task_struct *p, const char *lsm, char *name,
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
index c13b130bda55..5a128f1f30be 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -6290,7 +6290,7 @@ static int selinux_getprocattr(struct task_struct *p,
 			goto bad;
 	}
 
-	if (!strcmp(name, "current"))
+	if (!strcmp(name, "current") || !strcmp(name, "context"))
 		sid = __tsec->sid;
 	else if (!strcmp(name, "prev"))
 		sid = __tsec->osid;
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 5bee05bd7a42..453923eee950 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -3479,7 +3479,7 @@ static int smack_getprocattr(struct task_struct *p, char *name, char **value)
 	char *cp;
 	int slen;
 
-	if (strcmp(name, "current") != 0)
+	if (strcmp(name, "current") != 0 && strcmp(name, "context") != 0)
 		return -EINVAL;
 
 	cp = kstrdup(skp->smk_known, GFP_KERNEL);
-- 
2.24.1


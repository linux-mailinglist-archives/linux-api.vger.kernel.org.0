Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90033253397
	for <lists+linux-api@lfdr.de>; Wed, 26 Aug 2020 17:25:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727883AbgHZPZq (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 26 Aug 2020 11:25:46 -0400
Received: from sonic312-29.consmr.mail.ne1.yahoo.com ([66.163.191.210]:39832
        "EHLO sonic312-29.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726905AbgHZPZp (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 26 Aug 2020 11:25:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1598455544; bh=oGmbUZxOaGUpfeZXVcrbXiCugXQ50XZLjMALbhSMJtA=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=Kw6gyQKsBDsT0ghahhOCULL/NfSp8NZHhD/vVf1N8HpYVOcp+2GBRQZlK0l2FJ1PdH3h+xB3FcGDMxql/8eedEhv0MnmZtr+KrdD8Xi6N3MGJB1CNdGJYepyI41WSBkqRxWTCbrNX4lHAT9YaZPLd88J1N9pp+20knMuSbi9egx2qTh+8Tw4z0Rb67pXbHW3sU7jM7tEz+8DIHIWE87zkwjSCFa0pS4x1H3b3710uuktsazSnoiIA/fIze33+sZrrX7eU86BT5xEtpq/asRrtklJB33Fjt+MyYmHrNvQut9k+YLqZutyrZmt5k/HzJfJ9I+EiAnvoFY1t6yhxkaPWA==
X-YMail-OSG: tLP2LBoVM1lmva4Fh.HuommPjmnmy5PBJ_2_UOrDXseqoUf1Ndj5Qplzivo2zZC
 0OOgMSGgKUmYX9ccUggcGMCbXAIrSeFPiVjVERZn6bWu_w7od2zFCKBCYyRa3kcdNMOGxXTARl48
 s6gCZ.vSaoPlOMzUynmC8a1AETpIh_NN1QqpmsIaakuYIs9IN_1TaHHk8R2wyHx1Bp5xK7Jmr4mn
 kXsykx2.ciScDn.TwlvGn9hwj60Bn2FenXB.bS0IK5GdUknj2Fw8yy7w4pDsUr_mXhor5oXKMGQd
 GKWEpoWd3R_sOMgv.YTzXH0RtUaw2goElGXls7dhi0NEsXIPsLybpRnX3phSXHNrMeESUR.uR1Nq
 _sHAYBlX0T5TvP3hAJScqbrVUQ_rB2bkb3tmqGB0bm3BvdUzPOuahmDvjj0wXk9R4m2ZygmORaqp
 jCrPSKN0s_MbL4D.zm2s8.PdrLFRyVnATqInB9QM1amYyXB7I3XBAiyiHnilPmRyR4U5EPKZYzbj
 XPEbb6RuPEXoNG8c323ULQqSqyveOLhkvhdnE4a25DPajgD_t7YdXFSjtuY0.8h8UpQmo9OoNaxR
 jRv2YpuAe.s1BITgzqylHA6NR2A_qoxUzq9VxUNzlo1x4JfeyyUh1gUvOs.SkvqDKqgP5KKC4oZj
 edOCbn.ee2Fx4eC2rOT8Aoa_Ez6LkCwRSM_2kITKdm.SBJMmTDEv3w_2ni5nQ55ymzhHx3MK8dld
 iDWrk84Nu.XLWz3hN1vKoFWjvaaREnGFDFyv7KkMrIuJBcOwGiYnHXc4j1vbfeGKxOTTROSnx_IU
 R6hAx3yBjkgiwAzMjdKY89y.Rcu7k6oO.RpPqlrr1AVnd_Vc.oF.6DF4S5JpbG08SznsbKz_NwWW
 _6PC4V_mnVPgzqQ4zq9UOetKMWqQuhzRM4oRj2GGOL.CSXCRUEcyzJg9DlqLlSwKBxgRdhSXnqkg
 O30eepWFTJyCyZCcxOsRec.5VE2UTzIrcvNcF9Ioqa8YL3j_H_hULy1ZwJ.ZLDDmubQCG5j_LdFB
 inaiN9P7xjb6J9HEutszPnO1gL9PGUrRvI08TbOco8dzVWgK9IvLoSXBB4ZSVqO2xeIj.RugNemD
 i26wSx.7Ffpd.jzr_utVXzSMo2026Us7h_2i6RvYBNGRnEyY0Gt44TB.PO2xXgD1WhbDcHW0SmzD
 qfTlxJ1tNcpirifpBiE4TO_ggVYTcXHEcNGdhndp8vnMkZZjgyg.nc6kAsVOmZdy4eUdiGd2GeYy
 Gv8CIqh62WRWJZt16z89awY9eZ.zNB_50DqYGRTgkCw4b5cL0W2RRKhZFuWdLBAiPF.qjdWeH13x
 VFNO21mClvV15StIkk_CYQ48nSQnDTvHKiGhHZjMhR83asQ71qMDUMRH09USYzbpmd7Pc6wkUBS2
 Lb79LzSXGaSL7EEmmQLXzIV8Zz21ejCnFNXbrsEIsl_hyyUYpxo1aIFWsdVkWM6zg0Vk1kK5pzH_
 uysqzFXfRGaFiqiilbT0AMI4strA2VcwLnlcd2M_SCaBgMBYxuGEKgR7lsMz_LdYvBYSNox_1Idl
 QThmHLbDXbnhUCNJsUKuqX3lzbGU-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.ne1.yahoo.com with HTTP; Wed, 26 Aug 2020 15:25:44 +0000
Received: by smtp404.mail.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 0602d58449b883c11c768e9e6a3c20f7;
          Wed, 26 Aug 2020 15:25:40 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov, linux-api@vger.kernel.org
Subject: [PATCH v20 22/23] LSM: Add /proc attr entry for full LSM context
Date:   Wed, 26 Aug 2020 07:52:46 -0700
Message-Id: <20200826145247.10029-23-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200826145247.10029-1-casey@schaufler-ca.com>
References: <20200826145247.10029-1-casey@schaufler-ca.com>
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

A security module may decide that its policy does not allow
this information to be displayed. In this case none of the
information will be displayed.

Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
Cc: linux-api@vger.kernel.org
---
 Documentation/security/lsm.rst       | 28 ++++++++++
 fs/proc/base.c                       |  1 +
 include/linux/lsm_hooks.h            |  6 +++
 security/apparmor/include/procattr.h |  2 +-
 security/apparmor/lsm.c              |  8 ++-
 security/apparmor/procattr.c         | 22 ++++----
 security/security.c                  | 79 ++++++++++++++++++++++++++++
 security/selinux/hooks.c             |  2 +-
 security/smack/smack_lsm.c           |  2 +-
 9 files changed, 135 insertions(+), 15 deletions(-)

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
index 2edb51d4c725..a6802573c238 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -2804,6 +2804,7 @@ static const struct pid_entry attr_dir_stuff[] = {
 	ATTR(NULL, "keycreate",		0666),
 	ATTR(NULL, "sockcreate",	0666),
 	ATTR(NULL, "display",		0666),
+	ATTR(NULL, "context",		0444),
 #ifdef CONFIG_SECURITY_SMACK
 	DIR("smack",			0555,
 	    proc_smack_attr_dir_inode_ops, proc_smack_attr_dir_ops),
diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index e559df1df169..b99d51c6771c 100644
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
index 4752291376bf..537df0839404 100644
--- a/security/security.c
+++ b/security/security.c
@@ -754,6 +754,57 @@ static void __init lsm_early_task(struct task_struct *task)
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
@@ -2124,6 +2175,10 @@ int security_getprocattr(struct task_struct *p, const char *lsm, char *name,
 				char **value)
 {
 	struct security_hook_list *hp;
+	char *final = NULL;
+	char *cp;
+	int rc = 0;
+	int finallen = 0;
 	int display = lsm_task_display(current);
 	int slot = 0;
 
@@ -2151,6 +2206,30 @@ int security_getprocattr(struct task_struct *p, const char *lsm, char *name,
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
index 89c22769506b..09379ea04fc4 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -6293,7 +6293,7 @@ static int selinux_getprocattr(struct task_struct *p,
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


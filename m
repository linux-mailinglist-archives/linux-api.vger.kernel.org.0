Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56775417AF2
	for <lists+linux-api@lfdr.de>; Fri, 24 Sep 2021 20:24:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348120AbhIXS0W (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 24 Sep 2021 14:26:22 -0400
Received: from sonic317-38.consmr.mail.ne1.yahoo.com ([66.163.184.49]:33565
        "EHLO sonic317-38.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1345344AbhIXS0V (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 24 Sep 2021 14:26:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1632507887; bh=kom9XAq0ZMiGSHlADnfpA7BS/DVlZZGZ9hW1JiZKK/Q=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=dyCAJzr5v9U4wZHgEhnWgpXox7VagcNMXZg3UubB4YYJetNOYA6hkqbEriTkN+4vqsxfDEkBy2j9/zeDicJYZ6WZ1w0BQ6JTxxIctUpdPKQRLR/2gaLEZnhsHCK2+SAVzSqZhnI76K+R9uVMyDRMykOuwUgOTvbJifjKw9kc+8Y9hXe8a44CqvVI3kfDlPnLGb/ixYQWyTMFdJMNfeLF2meEMOEuxC6engOIybZyv917UEpvScjiDgKLabf1wuimsAwPwkrgwkzlhuz51GwN9FQmqyUOc8Cjz3USOJsg9lTMYI9gTddSH1UAeYnbVv/+sTNwf0OMRKEiqfJk6aMo2Q==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1632507887; bh=AbM/J/EpKKzcJ7k7eWQgLH0kOXuxEHmN/5Fi+p1Q8SE=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=C0tfQ/WKGWwR3BMcnpJZlEdQHAw6z+NpqmalHLxgt5z0+cD3ODUD3leobh2Jb3deuAOVTtWQRMbUJUPT/ZE7iQp/MlBn4emfpJIC3xxCTLEPjb0Wtkvlp8zl7h56Y/goFzSIQiH5cIUhMBM20kq0IU6IXxcBsPWSOhz6B4w6jpZ+o7S2fzmuzWUntaUdo7rfOpnk+i3A46FMvNwSwTTMcIiT5WinStZJqfUN9APJ7iH0V5MkWY44OACk7RD89lG1hSc6Zr3qpkVWyPaPuMY4ZuC8A9Dszw+o4kp5QeCeF6t3N1PhZTVilQy0Ly0O6RgQ6M2j1au0VNoBilLaJCjKdw==
X-YMail-OSG: KLqmlQ0VM1n_plmRmYDLyOEGFurcrtCCFwmlmsg1y0zN9kP7w4aTOoSj7QI.UrK
 Th3I9lNjhDnc6AaZECDFe8I3D4ZU.4pnjFNjL.naN6IYIC6f5uLU77g.MVFp6X0yo8yAAN.JSrL7
 VFirR7jo8cBhDXkDDn.umHXIUKbG16Pzo6UunwD66iWvOt49kyM14KmchTkcBtfX7eDAcoZL4NUR
 ANokss8TrQSytZ.k01zGgRsNk9xKbxngek4cG5Vs5rhd.mJy.15yC5JJaYVwiTuSA3nncFE1bnnI
 QTwhogestwJ9ZlsmIUUFtl5Hev4iqb21VVIaBsSgX9LudVXEn8UiijX_rVuAI4.MHMqpt7bi6LaB
 de25xBSzrZ..wGthXak2ECyRDv4IP_3fLEv.bMzRpmtqa9l5UlaJVXdVMGtmr..UhL5m39fD54vP
 Vjx8q24yvD0lZbHgqH3exHBTaxoItgc9s3ZQm1Lrjp_RcnzW2f16XJ_zODDD3DWKHPzda85jejbM
 SrcnBlZMbtRiX9DzK1.1c4yLIib3ojSDZ_Nu4ifSbyhQIR2STPBRsLtM.MGDyQwLvwdwETnXuuDu
 k74yFbijMLPOM_oTRrvwRuQiYA_cLPJr81ipLKXeG9HX8I8FYXHJQJ4jYRt8zTDa33xQewdIn4Nn
 tnlZvIMaaPpb2gsXDsawuacjHw3KEQa0O.vO_PEbblmw9bxPzB3LBIUiHqCwmqlukzbcsdy3HuhD
 bJ.DAnQhdeQkoNpEwXh87jLzQ6Ld5almJ2gtzgXv_M5zJctI.0Pi84ZAA4c54cEVwLU7IB_NGQ.x
 8WxLkvoRpk0OEw68HAkrNoT6QXvIz_9AAoUQMVTHYVCRXV4cEOQuqYrdcHBojJMn1GXywdG7wgcu
 jhPbjBfhCE7ah7A8rcjXD0ycQkgmjP9Wj.n9gO_tACCS6LfdiS0OjCXgp23XVChd0MlnQ8zC8bYD
 nUVSdWoDWOSDLyfDbk.mPHARpXi3Efpie9iaKNDKV1efSJjPuIp1B0cpldwKiYQfeMFgU3rElEw5
 pLJh5RT1eg6Yys5Fjo0f1DVkL_KhQaPewJuhrMMOzgl7ynFZF_wtD7zYpZQa.l5nw6DdAvzb0XzO
 nJDRG1tOfAChWLkVf_g9kdZse9tj_Whab6YK9scclyZ_20zY6jE7qr..QEBdP6g0uzdYuKewDyCs
 91SGSlwzTv1M_j8sJQf9bw0gQ4rWI6q6UvektuIgPpH79zpJu6ysvFjPWNVsxbE87n0xK56nSL.C
 cwOjFLNHExkVq8x59h7GzvsC89rBGIzv9ZbEmwWLXZTEcY3C35IP8yNeTXq37PqwXHPS1nYr2Xcb
 ippEGIcN4_01mBdI72RusWIrtD4IHXsKMhevq1P31SyuWVo6MbrhPqkI3sQeAqvaewjU9yxCG_Kx
 KP2gNgIllJ7dC55_vgPbNyD0KazmNXR5TjTFxLLdbxeV_MVrt.itJVKm6xasmSLWCP2ztIm6xtMC
 qcJPHD_gbfLt_MOqylJMi2TgMEvRMK_uZE4r.6Q2kaaBjyiEivTPlcLVCHrqwyr0bGTg34e2tPJ0
 0FoOXmxXZ7ZJXi2QrGAgkPsR9.ypOsiqjI0teZB2X3PGuMABQwppfOQNMVuudeAkc6a.O.7USpX.
 UYyYPDr6_jyfSDPSR8YMRkJlp2xY3uE3eXPOmmpo50HOoUzo8elJMAcY_Lw7Wg7fR55OpJTSrkse
 UEXGPzvHmlfJ4.qUeiZidCFJnSW14kd453lmFgFH247vib3ShbrbHQHBWmqcH9RDaUO_Wz0cYfRh
 TkXhJGup9ohpcjDc1FhdKL9uWdXWWDGTGtUuaswCBoxvZefiEo5jQkOBhTULm8tyE1rwIMgQi6Yd
 .oVz41Iu3HO8rrQmkYWyBGlC.1kTuakwdQrUmMI8ijqNQ8x.ahchmAlcPCWHPSjhEfR27Vdumi1a
 SngqFX11nhBPvWdWsWAolLjA9dr1K0Vw9SHgymw1gISKQJw5jYLHn4sGe1rdFdAXhmElAi95WH4D
 d76g7drokEzyojGSTDpPefnmL6_Ryfn.KJLo.J8B7BXpmJjW3S3zFqnrOpiNqu.uoaUIdiNV5jVe
 3J3idqaeS0Ogc10J.vRl.n2qwMDRm4s1KIuWAwBgKHgOV2l6qtNVJJqwAeu8hjZIOONKpoXazUAE
 7OUbgffmaNZY5ZKHWQMeI9M2PiMwHqdOnh2gKDPO83eUbtT32_eYH9e07EX5D8s2xpHBs6ZYZlms
 E1zF_.w7jCz4bb_NJvG1DyVbcIx8S_4sg51p3Iiq7TOtcxJacky.PLmdTsswkBfBob3zqh2bzi2.
 YDaZwulbnp45eGWu5I045T6j0NQxJTMQBy2c-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.ne1.yahoo.com with HTTP; Fri, 24 Sep 2021 18:24:47 +0000
Received: by kubenode587.mail-prod1.omega.bf1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 47dcbe6fc345351ca859b00706a0fb25;
          Fri, 24 Sep 2021 18:24:42 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-doc@vger.kernel.org
Subject: [PATCH v29 27/28] LSM: Add /proc attr entry for full LSM context
Date:   Fri, 24 Sep 2021 10:54:40 -0700
Message-Id: <20210924175441.7943-28-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210924175441.7943-1-casey@schaufler-ca.com>
References: <20210924175441.7943-1-casey@schaufler-ca.com>
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
 Documentation/ABI/testing/procfs-attr-context | 14 ++++
 Documentation/security/lsm.rst                | 14 ++++
 fs/proc/base.c                                |  1 +
 include/linux/lsm_hooks.h                     |  6 ++
 security/apparmor/include/procattr.h          |  2 +-
 security/apparmor/lsm.c                       |  8 +-
 security/apparmor/procattr.c                  | 22 +++---
 security/security.c                           | 79 +++++++++++++++++++
 security/selinux/hooks.c                      |  2 +-
 security/smack/smack_lsm.c                    |  2 +-
 10 files changed, 135 insertions(+), 15 deletions(-)
 create mode 100644 Documentation/ABI/testing/procfs-attr-context

diff --git a/Documentation/ABI/testing/procfs-attr-context b/Documentation/ABI/testing/procfs-attr-context
new file mode 100644
index 000000000000..40da1c397c30
--- /dev/null
+++ b/Documentation/ABI/testing/procfs-attr-context
@@ -0,0 +1,14 @@
+What:		/proc/*/attr/context
+Contact:	linux-security-module@vger.kernel.org,
+Description:	The current security information used by all Linux
+		security module (LSMs) that are active on the system.
+		The details of permissions required to read from
+		this interface and hence obtain the security state
+		of the task identified is dependent on the LSMs that
+		are active on the system.
+		A process cannot write to this interface.
+		The data provided by this interface will have the form:
+			lsm_name\0lsm_data\0[lsm_name\0lsm_data\0]...
+		where lsm_name is the name of the LSM and the following
+		lsm_data is the process data for that LSM.
+Users:		LSM user-space
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
index 65da9d2f3060..b87977f0488b 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -2824,6 +2824,7 @@ static const struct pid_entry attr_dir_stuff[] = {
 	ATTR(NULL, "keycreate",		0666),
 	ATTR(NULL, "sockcreate",	0666),
 	ATTR(NULL, "interface_lsm",	0666),
+	ATTR(NULL, "context",		0444),
 #ifdef CONFIG_SECURITY_SMACK
 	DIR("smack",			0555,
 	    proc_smack_attr_dir_inode_ops, proc_smack_attr_dir_ops),
diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index d2c4bc94d47f..f6ffe8b069e2 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -1397,6 +1397,12 @@
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
index 4237536106aa..65a004597e53 100644
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
index 96b1d9c37d49..798e887b18fe 100644
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
@@ -2235,6 +2286,10 @@ int security_getprocattr(struct task_struct *p, const char *lsm, char *name,
 				char **value)
 {
 	struct security_hook_list *hp;
+	char *final = NULL;
+	char *cp;
+	int rc = 0;
+	int finallen = 0;
 	int ilsm = lsm_task_ilsm(current);
 	int slot = 0;
 
@@ -2262,6 +2317,30 @@ int security_getprocattr(struct task_struct *p, const char *lsm, char *name,
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
index c3e5fcedae0b..ec045d9e240a 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -6462,7 +6462,7 @@ static int selinux_getprocattr(struct task_struct *p,
 			goto bad;
 	}
 
-	if (!strcmp(name, "current"))
+	if (!strcmp(name, "current") || !strcmp(name, "context"))
 		sid = __tsec->sid;
 	else if (!strcmp(name, "prev"))
 		sid = __tsec->osid;
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 711fb49b4d5f..bd46921b9d28 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -3477,7 +3477,7 @@ static int smack_getprocattr(struct task_struct *p, char *name, char **value)
 	char *cp;
 	int slen;
 
-	if (strcmp(name, "current") != 0)
+	if (strcmp(name, "current") != 0 && strcmp(name, "context") != 0)
 		return -EINVAL;
 
 	cp = kstrdup(skp->smk_known, GFP_KERNEL);
-- 
2.31.1


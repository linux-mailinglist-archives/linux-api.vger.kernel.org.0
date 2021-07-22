Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07AE53D1B5E
	for <lists+linux-api@lfdr.de>; Thu, 22 Jul 2021 03:14:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbhGVAeK (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 21 Jul 2021 20:34:10 -0400
Received: from sonic314-27.consmr.mail.ne1.yahoo.com ([66.163.189.153]:33697
        "EHLO sonic314-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229621AbhGVAeJ (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 21 Jul 2021 20:34:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1626916485; bh=hUIEN/jkZKY8m2uzjLwNZCG83d2ZZblt6dRbcr8DXxA=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=EANc1bFP44hMnyOO2/dzZAihxfbH6QcYuZQGbhjM1WggjWYXZmyH0OFo1x8O5zArCnJGRrVQQ60DvOKWy/TP2w4yuvQ/zfkhFJ27yD1vUjZKlw9o/avWK9rJyR/scXm0IDAnDzV3Z0mapUWezA+ndEan01HY3Ptwnd7M3MZObDA8Ghk2V3/F6Ero5BsWOSrD0Ij7qocJ+RmWzW2/KmwCCxV3QDgZsSmD6d5o65wqfhdpjAefB2nobvZKjlzHnTjUZSEWhXtd63NKZEUyBElK/qIv74iYc5W9/GN19F2uVncicPNmZ7+68tcGFjdCZF8YaEYIFzLPmAmocGgmkXMukA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1626916485; bh=O/nnbz454/CSSydAFHr2zdhp/ev8vulWnObRXQFnUaa=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=rRvfNqWF9LMkEkjyu/EVLX9jxp6KgtDZo5opdC5RUpilDLVl7ncTeMmYaDA8lO97h6OVeeY+uWImgNMV2Mu0ONoKFFfPeHB8b8J9TuZI819V9gaTF7brgAfGkYEo8rUQ/+YdWUtoIF4Sh5UPUbQZC8MfC73RDz0c8dtLrQGBmdjombX8MD/MqfWmK0J+9NKf+nzZGU87Dbjjcgb3iz+61qGGi4vDGnYajbHnkxfxC4YMHOxeErzjv5KJB1sLOcDkgCTl9OoWuGr/w6/DVPfF++6mguByCvcB5rtza+sJQtqGLV3JYHmdIaaJLtW/dVRxWqwKQlPgkV3Kjw7Piu9SaA==
X-YMail-OSG: lKg6aNYVM1krbXvx3w4xcDJa35JUYwGpWg3TuZHlCcX_0mc.shpQ_0wrhuWwyIC
 _PSglAINUl07GOoW9SSQyMYumX6j5AoMRqaj1hSzXbpntmNh57MIqoL7iXsrovy_FPb7fHxvcaOk
 mFIohkaxGxeefBaX_xx.vBbDXqXHKZy60.fbgSZXJ4FD_hafdxd3XDLmw1KeyqkJRYjeKkZUzOYs
 AfF37r0cLDsMtvSupm14vl3Tf_mVx1RC8XoPzdJtPf64KuDVwkR2UGeenk8.tCr3WY.TeDD40bFU
 qqlWjJiJ_Xrv3YmQm6mUR8iyLKtEMPr7X4W0U41AwYnUWS8sL02H2upGbjl4BtKjVXrl_o1aE1U6
 b5VL06mHMadAfLVGnJYD5rIU8AacX4TSD_uTwFGpYmDnxlyk2ATnmrM1wLRWHlPQKMukBZIW_fY_
 Xg5FDVPhgwYrLqmqYWsRANX.Z4_9lf8YoijmOTNHXkYUTiAKkYO_qBfMmLNmurI_QcLeH7aHQLO0
 7TN4n.2BOL2UjgbNmfvkiOB1Ttkt8IsNzq7Hwxb6OV7BPhG3d7XG0ibYeZZB39_a2fcy4iLmgeFL
 YNCLoXUJExSJ9fb7oazdfPYU3C3TR2MStqGQeTP8ocEn6xwUswRXDLEeqIPTcve_7wAtiVN.GBp.
 gEyXfg5oRbX7skpwQ6ErP3sMQO.vwZrvtpKaZYeHqZgW3Rzbp.LP4fJqRXqm2UXIIDtOd1yJJHbQ
 7RydC_zGPf2mC.9fzfl2c9OMeNBPpFDDJreWxm3N9jCukR64l4qdP7j2vPjdeni1TJrSFInJVkH0
 rr_yoVxYhBPcLLOC0ynfBi27TfFDJLWjv4RQ_PTYlgSdqebdc4jBbAWpcdAHcdPmPjzHeoBvbFfX
 sE0nnGSmGd44NQHxwtyBM3T_.8xbDSJakwIq4_LptGfI4nolUPykCudDgA3avvOVsjhMq_0WDPsd
 TUWrBUDoIpQrTPVsnjRUMydflUuvSgrkW4WbOCWNCvOJ9KktS7P7_En3pvVIvdAaILFedr.f_pqJ
 rczBd.H5_5x2yI15.nXmT8pfRIiKnwUsxSvW07B8uXPGo3hCfW_llqV87NpvUx6mOZxD4dHLnD1V
 Fyh1r.p.KrorV9CdEyfnXy8O8B8vAdPkBrgnEdwofcQYOuILpyxhBn.Gb13PTGnU_QCTkQiD5XFk
 qPO1mU6Pfi2YqcCisk6eHrvAruxPVryPV4jPeZ4H_mwivWTwmk.g75SNrEe3QT5O93HsTvSf1UnZ
 x8NFvgcT1PZB803l0exypO_wDvMEWW0MvR0vIExTeoEOr2fNqzod55IskrVcKKg3JUA8QfQ6VETS
 WI3_zB.C_sv1AYJb_CvUMit0HgffZsjp5corBUtpPB2H2A5QvgAmHr4SR4KQWhY5SyiyJyUB9WIA
 csFa._ezo8WSMKqUi7oBldAnWT1Pnv0GhEuSRN6x33g3Jjmh.o9.3JGnpdR8nPqQWSRu4LfDTzx.
 uDdVHhtIMTseFBLHWekExyq9q.iWigxDg9aa1XwUx_tgoFABNKfYID_J71pmltazP2B5NaqRsOzn
 527U3YA6dvQYi4AbCnba8lI3qkf5vhXqlDCJX4IB1WsXNq4cv9vLF8xdQvAZ14OkUlmHh4ZeXSst
 v8bJSiaZiKTm2WVRAgU3oXBIWozsJpLwcdloSdnhtxpzT53UGkNBZeKKlDpxQHc9He5iDS6LivRj
 xo8i_IOB59YNzss9TBWrb08U1U7qAkhOf1EOdC9fgAZL.Khl5EMznpERuZn88IL5an1lRIWoo.Oc
 k3rT.hpT1To2EF82Ofy9XteibbJ647jRbHmKWJzIN35tM_ecjLUKy4krfStnqCZTDq1h7XknBiZq
 _zTMyBEicwBAcUbJFT2n8JsKRy_9s3c6434SUpEDRYFlRX4mbVsBlhqJrQd6mbGWRuEr3HpbphzX
 Abv9Wpjb435mQhP5iGRZKbe3.HSYfpNQYqOlzMpC9E8n66ugCWLTkLi6c1mnessmK6NWD2WM7J_d
 WOslzlFZdkScp_jlfrG2apD0ELVBS3KzohoxZ.Ger7gsqy7NTFbWaBaYeP203CmZHSVJCmFB1wHD
 3dMwMn53XUS4hdAPSTcAmX75t575jHSkMzoATH2O2_7l6oPmA06Q3i08M8GjiEma.C8IBc6VxDad
 R4FG_VKsfxgltmbWIcyz84ZdteTZKN3unXq4wmHZn1F78JTuSA0VWxv7WmGTN7xe0qZyodYdHQly
 aEEPoYcV6NGD_JXn8VSxUgW.QB8qkM6axtlwGHf51JcfWYKVnBejNKWQu.D17LAVw.sgx0EYsJc.
 HomuX1khQZLGtvxmMsug.UC63NkFmPT7trq03MbN_E5D85NH2ifMPHbdMEhodJOxw1Pz9KxH5EXR
 Wfzhz1kTw594bwACUyqOEonqKGpGP4G8ywf46S3eZ_jP7ZKiEVLUQjPMg..5O_apKYp5C.RRUjgs
 kO6JPisKyf1xPuLM.iK3XnZ2W52_PTx.CpbMGQ8COZYPdc_lwqX298us5bSS6VBY6KhgaZ8bCkid
 1FKohrMPxYTMQ.KD_pJ5CJLuTDHxT0JHQR89E05ah_gSGfxw3cGBZkFQWJCTyz6N9GDJCsYCqo.m
 sjTUwiBYx_baQR5ofQKgrIdYCKY0fDNqk0KBStuv358YFwvD3.Yxxr98QWKRU_vYNyQDDKfKk0Kg
 5jEUR7_HOdqAGQAR4jZTlrbeiR.CYO0CyNVOKcFEJ8OTOLhppROk574qyi03hTkir.M8N8vCaTGe
 o_zGbRKaEPEl1P2lGkWi_GjAQFf8LsUnr7zF6rSRR3of6Hu8XAYzxO5qBm2aOcP1YK.sTSZTGagu
 RBwE6zJreHXdZSNEAV6Uo9odBC4H8EVW5LlPXx6qKgjXcs_2hdQpIsrAfpv5CnrHmWBl3tqQqPzY
 u0YYJSTxxJMPVF.uTThOAFPgEe1FFpUtNfF9PiI6tAYkwsatLhHDAmCA1z7GK.BZ5W9BpG5WKye0
 3psOlsxg27x4G7M4BbylzEzI5pnpLC0lkPuGO_Ajia5k1xLbyth7wDSkJ8WSEGBPR09wv1yFYELr
 0Evbik.5kcpcfJCPymZHkmETDtHR0VBcpMe7IswtVGgG9pI9wv2QJTstyPFGiQfxSKFlbDKXyV1M
 9LhpehMjLHEIikq4HHkbInESQwXZWdpe1z9uSMpLGHPkIulHIMDLDL41meAIHroR.9XHcimwk9Zd
 Ffo4S.Aa0kbsYzbV_XxBA5cCl1__WWKlidsA_NKRYhyQ_l.l_jpi8yJYRreZ1HVY9Ts.S.kBUcbx
 _Um0Qj.EjmC4Xxl9PwWJy1JDY
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.ne1.yahoo.com with HTTP; Thu, 22 Jul 2021 01:14:45 +0000
Received: by kubenode577.mail-prod1.omega.bf1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 5053ca2438d7ae37367f534ca924a89a;
          Thu, 22 Jul 2021 01:14:42 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-doc@vger.kernel.org
Subject: [PATCH v28 24/25] LSM: Add /proc attr entry for full LSM context
Date:   Wed, 21 Jul 2021 17:47:57 -0700
Message-Id: <20210722004758.12371-25-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210722004758.12371-1-casey@schaufler-ca.com>
References: <20210722004758.12371-1-casey@schaufler-ca.com>
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
index f80ed1c40053..387627fd8313 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -2821,6 +2821,7 @@ static const struct pid_entry attr_dir_stuff[] = {
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
index 5d7fd982f84a..4572da4e27f7 100644
--- a/security/security.c
+++ b/security/security.c
@@ -801,6 +801,57 @@ static int lsm_superblock_alloc(struct super_block *sb)
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
@@ -2234,6 +2285,10 @@ int security_getprocattr(struct task_struct *p, const char *lsm, char *name,
 				char **value)
 {
 	struct security_hook_list *hp;
+	char *final = NULL;
+	char *cp;
+	int rc = 0;
+	int finallen = 0;
 	int ilsm = lsm_task_ilsm(current);
 	int slot = 0;
 
@@ -2261,6 +2316,30 @@ int security_getprocattr(struct task_struct *p, const char *lsm, char *name,
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
index 12ae311b7275..046570556e5a 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -6458,7 +6458,7 @@ static int selinux_getprocattr(struct task_struct *p,
 			goto bad;
 	}
 
-	if (!strcmp(name, "current"))
+	if (!strcmp(name, "current") || !strcmp(name, "context"))
 		sid = __tsec->sid;
 	else if (!strcmp(name, "prev"))
 		sid = __tsec->osid;
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index e65497a5c095..1618d7d6154b 100644
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


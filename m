Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DAB03329CF
	for <lists+linux-api@lfdr.de>; Tue,  9 Mar 2021 16:10:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231717AbhCIPJq (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 9 Mar 2021 10:09:46 -0500
Received: from sonic313-14.consmr.mail.ne1.yahoo.com ([66.163.185.37]:35948
        "EHLO sonic313-14.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231625AbhCIPJi (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 9 Mar 2021 10:09:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1615302577; bh=rDJf9+4nRrIWFVzaOQ72FlTSmGZwa9b8d8P0+0iYSY4=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=ZReGtS+vJ/mhdWoCwO888B0QqbyMcYLb9FozisvLYsvkDyb3t6LSHwnK9gO9wp2Z7kym9JEKk0vy1kD8Kjg80gkgf1g+GDMfqt+vP7DK0K+Stiu9uc6xglowJc/djdBaFOA6364+zAm1E0dCc8N/gq2ARzh9oERKvszbT6qqiiZbnjwdw/1vvRGrQNhgDDOkLZK4BdYMcgcbh7z1ZIvztJ/wXN91tp4YDA+d+XGQ8srDzTpMLc+v0rdYEIRVuiQK6Ceau/8xISU1SV2IipCiwaLXTDuiwRSKOd7eB3rTHWPubFnY53N2aeI7UV0vBaToc29FaTyLsQvIsIv4TcbXfg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1615302577; bh=gy+2/3icfcXU3Tj+8kIJxKxE7UFHVT1jQLWbKvBv2pk=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=brshlh97/TT6+BqPZ3aNlHll8Z2vCedynd9iThY0zz4Jx0RsFZR91Oc7M6o6yLc9ryMEa0xcjDVttvEPteltwqptGiN8DUchM7dMJgBxNVTrdN6n84LvcrXLv88CNBUQEV+xMZLfjcXN8myACleiLfhpEQZju1mlDo8p6wbK76SooBMJ3THCCBNIe8VA/v55vtmpZMvYb9LBMJtB31mcWg7HTthQ++GT8fK/BykON9OuiymxUEXezgO42q0zMNGGN3Bc8jPN4cipn5IJcuk8v+Yv+hFNv9urdpn00ekiU3ylokWDjHXn2nA2nw0Go2Vi/hIDo6aZSTWBQDbAFZwCJQ==
X-YMail-OSG: 1XO4MBcVM1mv_iw2yyJENWkCz3oDsq3GvuTqx2m5UNBgdnIJ1GSr4L3lRhalJFk
 cM2s127SkqtGunZbiqAmS8pg4UiaCvCKKaGHMmIb6U35HGN4mVWJbybYwxi6QKVspwPM6U1UUHdZ
 tZxZx5rfbOFjxrVi01swM_4m7RIy7C9Th869KSBweSLNseLVrGFqSisByvoZhESK0xLT6R5Yw1we
 jhvnCHuO.ZT4drdOfjgAw.CNE5qToxVwc.1qXUs7oA2NOM5CO0wK9QlFiv8IRm3zWMhTux0zWjEr
 GeWIwd.okS5W3otbaHgAePZ30ViUtCLFg2E9UvlwPB5IuMInTOzFSclaB3.qVNZmzC0lZS6xre.U
 jAU9N74nciLagdQugJutqIQADualyUa84glxHX9.btSPR21JN804misMB_ofDoVO6.xK.qfb5r6u
 cZe50HOk8mqrXaplvTWrfRpaNNMDRtzNHdsjPu.d4DpL1B5_OPX0vB4LtsAd_D4scQWh5iyRWhYz
 wpZguFis.9PVMQeJG0UhqKa0No2a2jlmEQgAS0YpNd3tXhWMt7nLha1sdXBxUsmSWs40K8AIWVCF
 Ch94oT7PoUsZBp_xsSv6zw7zcXdPjHK27UfnYasjlAsj0MjQd_et4AIPoM6VUqpjLwDnHYCDbm5h
 MKHwDBjJQTNd_Iscxafmm8R2wX7iP6XeLsmFkxIQGp09SStCFKJ..bglI8aqWtDarKld7MzRUv74
 yCpVxVjLoklkjDmYdCAqqYR_VRJtjwqQfGXd2k0z6lUTaW5IiTALgPFS9KIc31OSQ9OAh1QRt_Kc
 ffi.1FYIXitfrVCfhcYHl96hreXh__of.zyWiNOeVCF71zTB3eBWYWI7pR5mzDE1nIebh0zHlG2w
 _rT5PaHzECBz4maEQxoeycsh2jh8ukDV_Q8YpC3JfdPjlJ0yHkPgCU6Y6nrb_J3zob4so4bysH3Z
 GUUhknsVcGYv6Tc8RD4K8O2U.RUw8Ae4CpMGHKF9SIYiK8nwVXTuje4lrEuJvpucJAFuSB2ug543
 2vkfapxcJVvwaJx6J27vr5Mhhyrmy5pA.BqgtrcMR1rh.TlwnooH60r6qX7hy4hhtgcSSRSg8Hx1
 HTJSp1AxfCP3.Bo3oHFlQBbUOGLyHoGDrss6xwFc_Lg2OqDFJhlUYIoln_9lQTgDM6Xjpt4cayEE
 Q4bjE1qTvvzkMOJKM5SYSIOkGlGRKMBYCFVKZRi5GuJI5AocIG5oTqWyjmFoXajAEWqNhrx5bdL6
 YanUDJ.qrttTJ2Z3YP6arljscB2PmgxwYfF_dClOyag8HBY0Jxc1VsBLgyuMVu4E_1d4Fg2ZYvvt
 qtUE.nS68JUKCfCWzyG71FoL2a7WvNzL_D3OeJbU9qTAbLhtjfX9iqQOnWGRGpLRuNq9w0Bk7cl6
 fbcryEP_9cNV.OLrKUpCZNYBvzCHWmmqw_2LM7sOZM_.6TpruMgmAFOwfjlJdXKrnJO7ZjX4a_.G
 jFwZrGDpq_1FXX7A6PTJhnAM4MbqIma1zRkzzyxqvtooxtzRMCibDuY_91GhIW9PXtDMA6ySTgVZ
 e9jvp5nyFvqpJrPEiIHzPT3__kx7tLCHdhFvQ7tek4WMKIFnRORzFLqIAUV2C9OSUGoYfl9Yhoeh
 ND54moyREb2WBjn3a.3gJi5974uc.y.Tsu5r_0XNhyVHY2AGQt8noZdui6hfWhWb4Sa_FZ3AuxTf
 UgAPghAXmwoC9tQa3ep148xr6PD4A6TpdcDZfT1KwT0TnqMXMG5ULdVDba0bQF2hnAfbrwFPxv0g
 oqHTakRlwOToem5a669KESEceEPlbSTCN.lgtZZVsA2kWXOaU5gwNcGg0UmpIbOgwEuQd1NDD1hy
 Q9Y9rOcYt03dY8t1IWVfmdC0tieIjefJXVLg7RL6qQd70pvFCduBx6t1hYM_Vwf51vX68QWOMM9.
 wtLKueLSc8H2vrICoWX_q6iR3ldNvnlKMm4dMH0XOV_GoG04aLVgurjEePLrPLY1Rl_T8cJAI6.b
 z3WpR44NiKd8gI_DbNPa6buERgOlChIs8K1vYDgSaCrJGVgvN4QV8pQfHoTji42.5JBERISzr4m6
 ibnxceJJKcenWBJ6c7sVXJwA8SZbbqc7632q_YV2P5v2f50c..BOzI3zv1LJpsojUzVrK505hzPI
 YVaxNJzMnWIZ68G6yASlcUV24AuZV3Ady69Dy5ljLtziSy_XI0B.b1KDytWZnG1e13D8dwcD3q8N
 WGdgI8F20.sDWTcpq_xQS0Vj5wZnSIDbyW5f8CagLm0VB6CUVXK0.fzUNuKOypMoZFtMvkLNaIqL
 mvljiTbp6C8NQhw7pfBsenprFw0eEUD0PfOsm5EHaC3KbJWddr99D6OzD3zXh6QwupyJt7yyXgRd
 lV46M2JtrNU06oic.2FG1Dr85xl8HqR4nocz7pKAtBQNa._ggGsD8OleyNi.XmkS.9Pfzt_IPuiR
 dHmc.Tv8K9lU.eWBuUEMs1DX.yL8w1hIILF42z4bXw9j93ZHh7ywAOVGFla6UY48Hl.IFbSWncqM
 8Bo3vTTEtsI.skARPAmkWtmeMhJPEqHAm5e.mDDTWwvS66uzUR44smIiCuh200OgWCopeeur3Kkn
 Tdon_CbPgQnt4rnoWxEl97J5YQd_Qjn2HWa0HyfWELh93vXjJKNGfbg0AQ5X6gy06Y1o1VefnAN1
 hOIlxyNVrz5mP96FxTHpesdHZj4od3Z.IHXqlcde3yrKCo51LLHBPpPShM5gdv.0iRKl8KyiD0BW
 QBnZaNVnqm2vdkPvNKrk5ZVR87C1yV3DitVnYf55lXlh3fo6SzVbW_cLaQt2HmnKRpvjjbFelXK1
 n6finv8jzGYx4Z8gUv9gwp9zvcPPbH9VeLHT8_jvYyqkXEWkYRkaHKFslRlIQbOXLTotGLzVke.Z
 btNWTVMt0qr6a6Ir4xujHFfsEnS9DALYJOzs_AZ4TdbX9S7One4MiXSYM_rey1VZvJ5G44aBSE7d
 IDq_6qUGQK9DnZmSy11tB0MPbVOqdazWaRlFjOOr2.q7AgBaph3xWgdcpP9zHBgVsW2VHYR.wp.t
 AF0CaZCLyB43buGJ2ra1dCxnW8ZDjtBK_rHYj3RSrj09NbUfCq8KZO8vGWfp_MGWwQIKp.BrgaJD
 OVgGNKZDIIpDWsTEyicFlGvABqm8xQZmB1t.zJD_kfwtqoircb_DdPGPiuhOOic6yQbsuXJXQFCu
 Kn5g0KtB3PN4nAyO_._qLwgP0rR5myjsfGBzScNezcDMidaWQzpL.ng--
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.ne1.yahoo.com with HTTP; Tue, 9 Mar 2021 15:09:37 +0000
Received: by smtp412.mail.bf1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 6893aca5fa0d959d1b210b2d980336fe;
          Tue, 09 Mar 2021 15:09:33 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-doc@vger.kernel.org
Subject: [PATCH v25 24/25] LSM: Add /proc attr entry for full LSM context
Date:   Tue,  9 Mar 2021 06:42:42 -0800
Message-Id: <20210309144243.12519-25-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210309144243.12519-1-casey@schaufler-ca.com>
References: <20210309144243.12519-1-casey@schaufler-ca.com>
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
index 10de522f3112..23ebfc35435c 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -2808,6 +2808,7 @@ static const struct pid_entry attr_dir_stuff[] = {
 	ATTR(NULL, "keycreate",		0666),
 	ATTR(NULL, "sockcreate",	0666),
 	ATTR(NULL, "interface_lsm",	0666),
+	ATTR(NULL, "context",		0444),
 #ifdef CONFIG_SECURITY_SMACK
 	DIR("smack",			0555,
 	    proc_smack_attr_dir_inode_ops, proc_smack_attr_dir_ops),
diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index ab08da884b2f..8d554288c5a2 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -1382,6 +1382,12 @@
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
index 5bfd313a7cd5..16ccc4a002d0 100644
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
index 7d90f2f531b1..ba01df949163 100644
--- a/security/security.c
+++ b/security/security.c
@@ -776,6 +776,57 @@ static void __init lsm_early_task(struct task_struct *task)
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
@@ -2174,6 +2225,10 @@ int security_getprocattr(struct task_struct *p, const char *lsm, char *name,
 				char **value)
 {
 	struct security_hook_list *hp;
+	char *final = NULL;
+	char *cp;
+	int rc = 0;
+	int finallen = 0;
 	int ilsm = lsm_task_ilsm(current);
 	int slot = 0;
 
@@ -2201,6 +2256,30 @@ int security_getprocattr(struct task_struct *p, const char *lsm, char *name,
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
index 5ed2164ea0e4..d86cfdd84ecf 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -6392,7 +6392,7 @@ static int selinux_getprocattr(struct task_struct *p,
 			goto bad;
 	}
 
-	if (!strcmp(name, "current"))
+	if (!strcmp(name, "current") || !strcmp(name, "context"))
 		sid = __tsec->sid;
 	else if (!strcmp(name, "prev"))
 		sid = __tsec->osid;
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 1c14983f87c7..18f1635a5907 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -3480,7 +3480,7 @@ static int smack_getprocattr(struct task_struct *p, char *name, char **value)
 	char *cp;
 	int slen;
 
-	if (strcmp(name, "current") != 0)
+	if (strcmp(name, "current") != 0 && strcmp(name, "context") != 0)
 		return -EINVAL;
 
 	cp = kstrdup(skp->smk_known, GFP_KERNEL);
-- 
2.29.2


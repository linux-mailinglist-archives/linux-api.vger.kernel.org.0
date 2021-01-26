Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A4393053CD
	for <lists+linux-api@lfdr.de>; Wed, 27 Jan 2021 08:01:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S316729AbhA0BBO (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 26 Jan 2021 20:01:14 -0500
Received: from sonic302-28.consmr.mail.ne1.yahoo.com ([66.163.186.154]:33162
        "EHLO sonic302-28.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728248AbhAZRWL (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 26 Jan 2021 12:22:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1611681675; bh=nJCAs0BPXA4cnnZxBHu1T/lun2t0PzuXUvUDYXsxOrI=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=HqGQra11Nmw6Mau+3wazsndvlLln/n2Ph36YSogE+CeaBSSiGfSlh803Jl68ORV0ZnklO2Y4uotHqw/CkTrgPxRtPxVm/v43GIFn6Ph8bm7JWNWuj2ariPWMwE6ziyNdpBUo8qd5DPXuDsNqdhHH8grWA4la036SMKaPCTjjfNFHGSyN4+9bJNLtxFLhZMsj6mdJyGdYuteBBYUPnekHZU80s+kBkaqeUK4oE3gPl5F+EBBO14sKGKRLegSI/H3NKbILFTUYtw5k1/kU2ZVJ7Fk3K05xjJkHbQZ7cBFTfCJPiUVduzqDim3aT3qsMaJyGHgqve+73i7euL4Zt/6oQA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1611681675; bh=Nx5jcfVbuGTA88qEpZrzgcSQSVOIjrGtygtEIlEPG9v=; h=From:To:Subject:Date:From:Subject:Reply-To; b=dRtV2+1HfgpbBiONhYYBYQdxzX3PKrvNPO725ixNF7J1bVlYzHvtzo/vQIoajOLpKEiA5FNAE+xwJOb2usBsnMwafi3ohPxZa0s8SFtF0n8stUm11U89aEY5UXuMsDPSAUNHgAVOBI63WY18GofgqCGd7shX/dQzWQkQUqcCk3jmi/PYjcM5GjdNMufzOuP/01vLhd0R1rvcD8WkSLq1oEItAKP+9zMmW2ooO0rFMu3IS5QvdqXokltBgje4mc8pehdwbmOEd04HkaXgpTW1j3dYwmuKqO6toMAdJUA/Ay605yPiDkwaVFx66CMzwyoEqMvXp7SocLa0ZPVqljrfAA==
X-YMail-OSG: mb7CpHAVM1mZAuLufEAKKFykBLBgQA5uIBjHwZlsAZAspXe67WaO92TZxurtdKt
 FUBb6yZ8Hksx8DRRuyGrJsz9QLpqzpl6jQGtLwxj11fYU.oh.ZY7TONXtiqJv6vBxKRUDReAFkSw
 AllZU_ZzAYByPUHdbgO6xw2olVOLGVWv5H.jbr852Cw.ZGfOxLRwUWYMjc5DMVtAdMWhAfUHT3sP
 6py9es64ZvAsYTNvixKOiOYe71iVHP1X.P6s3Q6XxHoEsvaQYaVf1a9y1t2OSqlCIIumD5g43RF1
 KW.4VmmIbHyZJ4GduHn3qBNXOZAcaQ0HtsYqvKtN3a8OdQftWOH.ALBd0DE9WhOUWBAaCjQdMdjH
 kU3BC0eA5Oz.P.uJZTd4pGVBb5.vYVgIc0RUdYJ2TRVuXGWYZXBX4C8C7knoUGsgPp8MpWa5Va0g
 CamZQ8bR74lLfZDfXg0vvf2ZqNFG.ibQX2ALpHzH7QSHSWae.P7M_m3Xr7q5rquKPxjWtNKoL.bw
 884OAg8yol9._GXjcY6MBL8Wqmxdj2mqpUsUx5JjzBnzmTP_Tw6iJBZe6cCpzC.cV2DBEdr5hkhC
 STd403A4gEB5hCx4h9NRl.i_JEEyCHQBz.LHDxHPhn0Gfj.d0heVUUgTm46XBpRD2Tih5OnVnXcT
 9PzTPRj0N2d.lkv.llWUw5WAbYxJOD6FBz3dpW0dZHkx51DBYoPQIwUrQfqYtI97H.az0WXYI4lZ
 dTKiJF9bJHBU6rsgaoUOGy6BVhSU7BO0UJgFpeqJ_rwv4AcPf8auRCIRvu8_fYx7qtPDxiORZo.F
 n0OgT0ZdLMIDbiNm5zwg1cdZ008DuM7k0tZfgrvvZUlSnYUjaDhap3WLNg.VG.XeqmxL3HGDb2l3
 SXH1a92dSsKoBPpnyQFzFvVEL7vsLfhtDOWMZZu.KfIgQf_XYK6qCnNztD7XF0FvNFU6YQsHGMQt
 ZmNIP8ISRPlKpiCKFSxLXy7NAQZ4EDdfUPVt9JhyasEAcIv3pHc0atcuhiPu5jTrW.wCiP2P_W6l
 G_USvH12L_T_aIBuDhn2uUFpzzzY4S3PtSvhati2v2rgzlo8c_.bbXo0IGjpMtFRsCLbbeUNmIJN
 TA00YJy57a9uHRCmNvkr4XVCdgCXSQfUuA94mOfwhYLNW7Fzig83PUqEvGxoS32k1I2PpaNVUcB_
 JumE0OmjGjCfsq7NFuHexJTP_M1U_weaDPhdasVLNqSS4P9RamI15uHbZ3sXtXAsn9M1hrCv0kch
 IFxPdy_mRdSH0P47lP0fjYVY5EdYbuHALEaOi4MB2aw5dQ48WVtDbL1fPlBbCSejnmnv9ut28y2Z
 pqHuoHRkq1d_Uv6bMOVk_TnsFzfYYqcKbIFQER7be7uSf652L23IQX1NzZuwRIJ40mN2C7t72TKk
 L.3oRStKX8vPTdwD.oQoa82w0CXx0la9gm8HugUIOoI6GZslyPcbqxLK02HxemLRbUQsH8iMDELO
 3i.pGO_ixxkT8S0LduRaGpMWNaExP_sJliY_yOLmJSPnS553nwl65A44Cs_KF4oyPeCf3.akjCL2
 DrWw62y8cT0nNlvDep_4sUZsYKeywb8UrB3XJxVggfVhqQVXvm.nhrCdCcpPY0HgEK2COhkAD.MD
 HFnjJ2Uu_pZGfT3j7Au0kt.UGO1sNi2TQUJGbxMVryrfurO1MkJxdJkeBhUpWtT4vfBTx1tJMx0r
 ynu8cSHMhl1b4zQWd98EeJxSsJixqtlwBh7p4_6yGbzA.jlWe_r3SqGvsMyHsighWeWM.Z8gzjtx
 FJpPujAe6LpHsdcof_E8yzmYwlxk6WBgO0o7pdc32rPbq9oFQmoUBmNZX_D0IwO0RE5b4hjbkxLD
 fTNmm.DABkuaCtdhXdrFJStdJQ6xK02pMS9xKvgs6wV3Ca.yBQbay4DKS5.Wp7IgUCDMjrMNEXDU
 7lwEkIA7BmnVTLYN_WzC_jdJRGfX0lSs9r3HDBxkUqUA6u6icvgtoJIa0iWSqgwlmwqI1xLl0W3c
 Pqd2ay8pN.ew9iyPuVBhTMfSXCJUxdTpSXzUVm3y_yPK3q5b6d8q3x5nZmavwX50jKlwIsr5N8Cc
 zH0xQNeTQrQh1kD204273M4fuRHSjQ0lcpCZYf0RPrSfe4MDX75Y4RsXhY.WQ60me17K0gWl_p7m
 cZ8wWlTOqIHPfWK6.o7stRptPm1y3zBBAHiutn.9kBoOZkMXsOid55MeHlGW7ji.6JSEts_dDUaR
 ttqMlYqPBJUxVBUZcokqb3ULMm8foDyd8K_hlNYmDdS7hnc_RbnEeJbzlbdqN5YIYWzkhaQMYiLG
 Nyh5xjClxB7IaW3ux6etDWecKNy8khGSkV6_KQchxjuS3WwnhSjhouZo4rn6TRPyikcaEU6nEW3d
 cYibDiFEC9v.YBKpZY8QXI51JRDUpU2OkMd8debaq9MlDdAESlqTxiOG55uMq.g9f60aQH5JSMF4
 8BeKPJXvNLpMVnLCDGKEd8TDZciOBCEkT16gukD1dqwvyqrr0ZDmDOF_zyoLNj3pHzH_6em4jowY
 PJh0xIxDuj6OlXgwjdOIANuQ9Cv6.ZnPw__XcSakTIzDE.ICl5231H7W9rlq2p1tNDkT.kj4xuMu
 GtpJJEY9CnwckMmQ0vtC6x674hDfPj8I_3QDJM2OzR6GqUAdG1Wa6m4TI7EnThgMRgtY..xFY1HD
 GO04F6_yHE9Tr2YsTWLuITF75lHnI7Ki_bjLttT_IZW8CNb2MGKPGxK5S1aROhyyVYFdUlzzRQOx
 qOFBW7.QbX9HukJby8rBoChmCE4egY9pbwHrISNY_qgXFkeMTpE.kl5IH_q8NXWBE_AbCFIJ2KRT
 CoNkBj0RunCN.hL0GVUsN7ZX4Dm3DFu5Jr4ULF2H9qxUsy61a9w8Mg5OOWUZja7qf__lJ9t5ZEfz
 dB90bxTS2KT8_Gw1oc3R7z0UkQD9C7x0VOniwRDZ0k4PvExeRxY.fAYXB7ovaCSVMCz9mXR0plIG
 XeEn6sl.f.nEXatjjQKUgzk7vcVnmLPfOrWxSDjqR2j..X9DQIGx9T4DX6nNFuxgHQTpKzYsubjZ
 HHJBJ7kFjw_C5BJ2WI2k5pLlrWpfxaa4nSFKlUJ2UxJXKRhw_D7NIiLs2HdPWQPdV5ntK72rqa_0
 54ADNOaA94jpnpDCNQ5iyrN6a0xx.iVdouVv7DfwsizptueMWV3KpB_aTNT6lg7aQd1_8Ra_uS6I
 .bPAP6jOJp8Rzd3M_F4vbn0bnEQ--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.ne1.yahoo.com with HTTP; Tue, 26 Jan 2021 17:21:15 +0000
Received: by smtp416.mail.ne1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 22de447dea88977b0d341466450f4ca5;
          Tue, 26 Jan 2021 17:08:09 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-doc@vger.kernel.org
Subject: [PATCH v24 24/25] LSM: Add /proc attr entry for full LSM context
Date:   Tue, 26 Jan 2021 08:41:07 -0800
Message-Id: <20210126164108.1958-25-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20210126164108.1958-1-casey@schaufler-ca.com>
References: <20210126164108.1958-1-casey@schaufler-ca.com>
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
index 158771f87e94..bf23e2bb240a 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -2809,6 +2809,7 @@ static const struct pid_entry attr_dir_stuff[] = {
 	ATTR(NULL, "keycreate",		0666),
 	ATTR(NULL, "sockcreate",	0666),
 	ATTR(NULL, "interface_lsm",	0666),
+	ATTR(NULL, "context",		0444),
 #ifdef CONFIG_SECURITY_SMACK
 	DIR("smack",			0555,
 	    proc_smack_attr_dir_inode_ops, proc_smack_attr_dir_ops),
diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 28a036374834..5e7b2c3ab133 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -1372,6 +1372,12 @@
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
index bfcb78149e9c..4af0518b55d6 100644
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
index 9bb1fe69d310..50cf7c58fbbf 100644
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
@@ -2161,6 +2212,10 @@ int security_getprocattr(struct task_struct *p, const char *lsm, char *name,
 				char **value)
 {
 	struct security_hook_list *hp;
+	char *final = NULL;
+	char *cp;
+	int rc = 0;
+	int finallen = 0;
 	int ilsm = lsm_task_ilsm(current);
 	int slot = 0;
 
@@ -2188,6 +2243,30 @@ int security_getprocattr(struct task_struct *p, const char *lsm, char *name,
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
index 60e35d31cc4c..05a98dcf377c 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -6300,7 +6300,7 @@ static int selinux_getprocattr(struct task_struct *p,
 			goto bad;
 	}
 
-	if (!strcmp(name, "current"))
+	if (!strcmp(name, "current") || !strcmp(name, "context"))
 		sid = __tsec->sid;
 	else if (!strcmp(name, "prev"))
 		sid = __tsec->osid;
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 03a1c40174d7..363c2cb76936 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -3478,7 +3478,7 @@ static int smack_getprocattr(struct task_struct *p, char *name, char **value)
 	char *cp;
 	int slen;
 
-	if (strcmp(name, "current") != 0)
+	if (strcmp(name, "current") != 0 && strcmp(name, "context") != 0)
 		return -EINVAL;
 
 	cp = kstrdup(skp->smk_known, GFP_KERNEL);
-- 
2.25.4


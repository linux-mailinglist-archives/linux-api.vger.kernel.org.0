Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18C173A38C7
	for <lists+linux-api@lfdr.de>; Fri, 11 Jun 2021 02:31:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230329AbhFKAdX (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 10 Jun 2021 20:33:23 -0400
Received: from sonic312-31.consmr.mail.ne1.yahoo.com ([66.163.191.212]:35821
        "EHLO sonic312-31.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231175AbhFKAdW (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 10 Jun 2021 20:33:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1623371485; bh=PYOxDvZGvzLc0GWEGWLW6Y18A54vIQSomE5t+mL3eD4=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=TZyQb68La8iT7O1/axZec9QoF2VVJI+4MdVYbSKoM5PnHdRJk/RsPbhI7kH3y4MZCB5s1F85TiJPZnGSrI3Dt28xOmgrSGy3eZRjwnvalZ8v6njQD3Xl5xB9n+Nvgkh8FJj8BZ6Lmqymj6ptx7azrhLQS1tS6nJCN/YFjdRPS24nXW32+5ccCdHPzptDKAPiuCYkVpUFlAojI4B7a5guB+nF1KdHeVtMpzlJHuNlDS6mUJTaiyvbFxLoO6/sJty0d+hd/I7XFbPiLDS2yrGKFxADYb0JufMt69xob5XF4dTq2wibg7w9z38OmDYtVkSDPvVfsCvWw+LZRLZhUsW3GQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1623371485; bh=HqFEuIrit4ts+ebfOiOPOt/iEbG8+IRrQVMNTRLF97q=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=qJ5lcI2t1IM41VWaW7x6JRUoSAZNAgD3UqdpepuJ9zwYbU4VsmSqQE9gOrValagR7LZgJJbHg7qTDa2aR7ZqJIygSu2r+WmT/1Cu/yjcLKrxZafeD0lVw1lh5zPFp0EArJxBkLXZr0Q/WE4ig/4wmEqcBXX5f3nFmH31UgFk54KlFmq/6CGf7tqYdIKwwCGzDog8tdb0qGbg8pvxc8fcEbOTnWe5OXjKwyU7s6N6kLLaIznNZZ0q+mZxpBDCmLABWh3jmeEOvRexKrOE6ZL32+DsiLH0Scn7Uv1gUd8ZE05I7Gjo+YWR+tYco/aLJHoF4w7Dq0J1/EXRYFSxpubIAw==
X-YMail-OSG: sDlG9xQVM1kx_dBvpHrDYmEGbyXdSm_5fGskrH4nj_dZRRPKM96fIpLQZ4UbAif
 Ja6fYJUTzVqYo6uXDlX0Oct1Fd74XuoX8jlLepD9qRXgePfWQSbZeIr4jFNeaXXcjVz6TdtrT6ZY
 vQmT2V9wJcGvZ2k.MOR3vk2Dg.Sd1P_DTZloQvcLvJ2gZfiw2aWNy0bzfDHAAtnX5eRWJiSXRLWk
 ddZ2PNbzqzf3irQ5eo37vjmYB18AV2XZ9N9jibH46ksTE4YQALuOtkoCq4eouu8O2Vr4yNpPXF2N
 ZtbufjuDibgEW6xLjFaaxYTaNjlugUXMuouugJhuY9gmgdDXVYl6e9BEtqfUqxzbMr7TnGqZ8aO.
 Om3HbxIbwZglyLgbWjDOOtFWHzXN8ED2hsIwLgi9Llytmk_thlDrOyGRlrCgulNkQGTRaiGqF.MH
 AQj4oW0GGJZ.OVO2A6KWTHy31YBNsIycOiIfcTVfRurTQeDPKo7khS_AMmCo9hfPPErdmIwcjkP2
 mMCV4iyvMDiLN75TpmYeRgJHfI0REOb9ylFa3uQL16tSFlfilnWojYaGCN0vbel1EbVbi81dVJa6
 8.0jyMvbUhsKLT6E7joemVE1rkr77PTBWAhJGBaVb0uGBU91F56fRlXevWk8apoeWVUq4q_BGoec
 LLA7BvM66TojL85.7bGUQNwGq7bTNmUu5PpUWh0OfU7T5GfpZfeOH2xYxx0PXN.7fMdJIHosjJW7
 rmJyLIlJbDPIFs.lHekPO6j75_DigFNz85hAYr9E7V_EY_ncFqi3bzXCVOrjpln6kAYCwzqdxcwx
 Fz.5H6YPwRDzbFBqrMBC0k6arx0.tSAY33Fe5yrm2FjUCJXLMBUv013XvMm9AyHJxcsrJu0gnw3y
 iEH64_U22m3rwJrKvXw2lS2tJrnJiyIlWl2b7LKv6NCWh980sQfuxU2ggVxciqGWvCR4ZbnzE74T
 jvM12Nohzrkl4kJ7VNNy8DqnGsvgnP9l0bB.F4oS22kHxNB_sD.sED_SbdntjjkUKSxdK8AtizO0
 VW3RJhB6RgCUTdr6o.shC_DC_PlaeHoQKWx0HceNE92fBkgaz.K7cn2vl8TqX1vug7q0Gghe5qlR
 IfwqdNnfPMrjBkVgG6KWfWIkWKSRGeyPqaMA6fIiPa0c8PE4KNCVif3Lz0zFE4SNCNixWnIasKHS
 DsMGd2hnXiIvlgTHf2qLrt.ysYrj25JMrMEZ_dKg9fFGCN7kZdICTPuI6MYn2fgWrXnwpaOfIN64
 oNoBrsQO9I4Dbchf5IdyILf4cSic2dQMJd1nRKiuv54NhCEts5HMudi3woCaBg_G3svXUt7f_Xhb
 3o47_jzl18EmdAdsUmWolScmViMVbIDgN47nxHqDQBs61xrUq6ktOEh3oLV82GGx1att.E6asNSC
 2ysUWxBlx3pbGATXlp1bxL42vITZ_tciewznBxsa0DuONxr4c1OZznagnw7KeHvSD5NFu5AK.HbI
 B86PaqJF8QsVgARfdJD0pBONGTrBTvM4TNRYDb44D.6B0eQBx6no9dOk7JdD8pAQwZBPRW6oOMQL
 eujchl6_IYkRyzt87Yehm9hVk9a4iqRq0AmX1JOtMLYIRIw20vej37U8Dnb7harSMOB5Ht7kiiq6
 4tEu6jvnuPB14TD7Zzzq95xdbn6gnjEjBQudEvFGWen7rJ3C6AS6gFypBoIZUz.jhHnI3xFjgDwP
 BWWOP8tliU5TNVd6n59QkyHQ9jv2n_92iWcsXy3f_qwrI_a.rxZBNxRsveeM.OO8Gng9ylLaHUog
 891A4FxqdR768Kpn.cPIiGIusKERzG031wPteQjI82GUGDbYibKJ.Dk7bizUKUFguEX65aYC8jMC
 tUkxCNw0eEPr_RI5BO16LbTjvYX60bblbbH3KeUTWJMx7455bRpQg1Xy3VkjIRmUllWAbBXVck7B
 ljQQZeWZPptCZ5kMDV1RUkEdHUivWnrZwayITb3Ac2KJSeSJ6fICeXKpE1XIKDgfhlShh21FoGoj
 0yPl.h3iTEZrtIOD8neQoU1h7EtXaR2iyR7OiFvSN0QxF7Cnq_35oshtnr.MqJ8D_mWMW3IdJv3s
 irov0ZdoYESW8u7PVjCHAdMeo.QFCqrMaUOwcePDPX4Bq_.Cal.AbsJWRSk8CZRkqo_tnepI.UP7
 2Cl5IZJTw4qpk5kPMYKFMI23RBdwZb7TIVrK8qai4ccjO8plwIjbQIyMaaEzktu7tBAWTW7rh44C
 pzXK7SOSeiUqSs68XpHKi4nEt918lOAzMeBps4tCXpk7TEaOaxlC8qON34GyZcotqqLp25ovbQKh
 PLC_sVcLTcX_o.2Q0GWiRGavACUnNggLfW0mYIkBuAGyg2rzQlZH3cdVZ8msY1ei3RA2.N1nFgAX
 1HQYvA_jGkq4TfE3UZE28BPKg0.OHauASNy3qskMIWUsbHOfUBR215e3TzBbU8XYSc9lN0P6zWGQ
 ltEiMTTzL6EUzBeeLsP8jhZJEiYdrVC5Yv7cPYFxdoqH9aXZetwVja2TwlmhXMkJyGroJxQQf.aZ
 FPUbEOw5.YuvSuSDwxTh9f02RYWPXu8WjDYHIFerhCUR_YU3XkQKp3iyfE6SagKQ9tSYBvwtykD7
 tmMOjKpXi2u5z98IuVFtgBG5cY.xBgKBYYtM2dZpNivj5tzE77P3HODH65DfWpqMXKswhhPzRIZr
 K9x2fGrzuNnNyqAP.eCnV.E.6gz1l1MlEks8Cd2V.oY9h0i8paDelG.jXUgNmKa1BDtLPAB5wpvn
 DQAUk8lIiDrb4FSA1mZvhk_lqf3Cjx7E_pqJrZjPiqVhYepdk8WskQwFAoRzMI3KgTyW3.SFtMGK
 P_iQGMhxBSgu5Vh1NR.ozkf1Wt_gJsGoQ9IJY3p_qdqI2HPmT63MllZOADJ3rT1l0c_SXtgz8VVb
 vzbdKgcghUjerz.c0Aj5yBp0eR3fgHWJq7NvhHLs4h8l7JcPe4ZWOJNab7O8CfrF2dwoQmVNG35L
 V4PjAZ2tpjtV_AE.gSzscpOrMc7s5qiImziBbGOpcyNTo3He.opkf4ti0uV9GbmkulMYrcTFeIf2
 LhZfxOqH.YR2GVbY2nrPjxBdxejCQOacC66OWWuG.rbAu.l6aitjiHjZZfFVdmlB2.hnLV8s8AHp
 U_sOfhzgVxt_uGzw_tlvRz0nzTDLiB8Vie6_Y3Hoyowxd7cWpVz90AvEQP9KJrRD_FQQyNN6pd7G
 Cr0lfmJeZWtT3l3Ib79119NlpX3wYGPJUlnbRaREzFBMKJltRSCFX7FW3HzbFAKAP.Dpw2mWBqCb
 oZWYDlpLMsktSkDzcWMPjDLGv60Q-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.ne1.yahoo.com with HTTP; Fri, 11 Jun 2021 00:31:25 +0000
Received: by kubenode549.mail-prod1.omega.bf1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 9f0be996b7250d367351c85ca65abf5a;
          Fri, 11 Jun 2021 00:31:20 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-doc@vger.kernel.org
Subject: [PATCH v27 24/25] LSM: Add /proc attr entry for full LSM context
Date:   Thu, 10 Jun 2021 17:04:34 -0700
Message-Id: <20210611000435.36398-25-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210611000435.36398-1-casey@schaufler-ca.com>
References: <20210611000435.36398-1-casey@schaufler-ca.com>
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
index 81baa94092f4..89ac9cdf8005 100644
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
index b7800fa55a34..0a9af748f77c 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -6468,7 +6468,7 @@ static int selinux_getprocattr(struct task_struct *p,
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
2.29.2


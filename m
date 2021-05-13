Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6122C37FF40
	for <lists+linux-api@lfdr.de>; Thu, 13 May 2021 22:34:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233044AbhEMUf5 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 13 May 2021 16:35:57 -0400
Received: from sonic317-38.consmr.mail.ne1.yahoo.com ([66.163.184.49]:42784
        "EHLO sonic317-38.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232977AbhEMUf5 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 13 May 2021 16:35:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1620938087; bh=9nWli++yPqHl27Goa6bURc9CsVwE8MmqYdqxhZMz39A=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=gF4h0U2hoZaxyr/hyVPLzHkgLqnWX3gw7kldVffscVFo22ExlpS3CQikaJXirk2G1dusXaxXcu7DyYxl2bwSk9idInVPZ9vAQjVMzOiW2AmubHskePQ+46F7G8GHd5YTgs/4x/06Kykxf6O7u6di9Hs5RcBKo/n34HZBP8RsB/xaDvMEPVg5u2FVJLUyQQoLnTOwTr4BL77HH7GWj9jMmrYFNR6hf7PXMzp8kP2fufk4mL9T0QgvPjYMrxVRTGnZgkSh7x9zJa0mML0ygmP0ik9g9ENn6mRHnTUDMc6RRX7KsNDvZNSBY/23HrJRI12ogpIoJ3Rw8ROxDh/WvvRiXA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1620938087; bh=r7ZBJr3XdtjThE7Wr9BjH32WLz6tafr/HakW6IsEvpX=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=i/XDprN6yQUcSYHohVmag9yXwK5lo1++VdTuY0Zo0jDoH95bT0ur/OLB1xDEx9iRfjPA+cXTrWFkgGZYexc9YLKBSJ5PeCfWgy/+EJTygHjpWFLnZz0VZ99QKh1IBn10nfBhmcJ4ypq6Rgu/w++tVasZRI3DURKTMVwiv0DkBz4vm+40eW9tVb12PzAEdCtNczPVGVHJ5PWw/S6cIsqJ3RxOWehR0jrYDwSx3Uwg5bkC4aIWjd/+zU8WyjOdvXVaGgdAhTfJyPc6AZZGCL68a0aZm4D2LQBzNOh3EoMAAth+fK09aghvvSEOpqGYKMmi8NrNoGYOPdLdqO0Xe+qkiA==
X-YMail-OSG: t5xQN4oVM1lT6Dgs0u0LqeqtZZbA60HG2LV0x1NZDsEffWyoS7ip4fi01R_x7Bk
 lUu1P870ZTUkoLwh8A22c4QkFDwEnfhooYSvBXos2M5GxD9zluzeQhG6AGRGlhqp9w070hHm.Tjt
 Ri9XiWT4GYmuuXWXkY.ecRelc_6j_fQiXO9VnCvNrBse4iLXraZO0R3HE8SJpr6CASZtio9cPR3n
 Avg5Ba5upf12j2G9Fgc2rov__hr7AcQkY4fl4jDiN3w4NqPQRmgu9Vd9QrX_H3HInv9.rTWMl8jP
 2Tr8PCl4y5PzmfaohWvO_oM3AfcuXzh_KwORQTG18rgX2eBSMj2tDX19ZENQIcRQX9D7lT9m.p67
 elopRUjkPq7lDJjCTo2VjzzuR3LlEpulQNDUkTX3PyPF8hWhfRYKWsh4lgwJP1uSzVWjZAebS9eJ
 184XG.zkurjsvqpltd6OyVScTBp2WnRpqkAq2afov2IoSgd1gPqer8K6pHRWLjIRkUYwGHd_pi6j
 ZnJBBJem.In6m8Kgadq5gJW75_HlYUXwJCkwd0mblfR9uSTQHTc.EC20ZHpvxokRYTxuYVsuoZc.
 OBmZKTczkYhOqzed46Pwgk9r0QYvJAblkNC9feM1GBQL5S.JMz7mUHhMn56geHK6DbtKCQqJ_CYk
 L51jBTtTo8cyb7iAJEuLQ55.TsGsyvSRo..s8LtFLuDzgsgAu_9VbrGiIVkmGRxyEVSM2kVNZy5L
 _CUG6GYBnVKRzhkMo0SMyNJx0scoP26ze5WW5NPUeoWRVp3jeMj0rT8tmLXAenMRJXRcpdvquUgU
 X9GwcPCVJ0BNOpjfbwjkHolhaWkiTAettXyaF5esxxhNP07T_1MlmvSRvgFS58xkmxU3iWZJXH6O
 xbfPZkTK52vpMH4mJmpH7Ol6WnhmEZxUEhU.engU2EYNDod2yZWudIxneYDfUlXCRoRJmJN2epuu
 7tCQZKMDRxgAnKQQIqLwsu.DfmrWakAJ1iQ6pD59yu3U4ADYHNCGal3sSw1YTe3YmILoL59xYDqe
 K59qvGlCxTUecYwt0Dhif3wdRTAasjAusksDvA1ZlDMCaJNjXGnKh5dQ1X5HEh0z70.N0XYe2v29
 IfVDUQtqvt5vIrxwiAgv5_3AAWqrz08HggIkAqj6yQ6BED74zDnyp2R2.t1R2L0C35.Zpmw8qOOf
 .nm8QKgczS0Mx75Zkcn4S3nnQvLrOGdHaEvUm5P.I1pGRBBvjmEktEPqSW0aOdYq.ZapiRhpIfBt
 qxUk1fVwFCWWgyi5.lRYAsewC8wfTCzDwM4j3Rh31szjv63egVqJ7aSZy3D7jhSgiEAzaftSd85K
 ZV1M_yVlGqbuzbnBVREDjT13bpTUg9at0I3vqQIVxKNYiKj5Oxs2H4XBClY3gwz3kLWYRMfLjoLo
 lt6984_..i8SHVwhhteaDQffkFGP3yRie1yXjQgMmYdkBl0WM9wkbmKTYtjEHcPZR43Ph0La024d
 ArzR4NElbTpHxoDm_qjrADn.tuRliGJOyOZKxf.jZqFv8r_h435Jnci13JdygBNqzwOhjrn2zxwv
 JWluXj1LQ6DqSjQJKqq11CE2Luk5wJ5OgTMHAs_OLWqmR_oRjhnZ.LMww.NA5LM8s0LZk5lWNAwS
 b_i1r.5q3PCKHkycZFrvfrRZi8YKYTTO.J.bgdzknKRPdFOx8LhPOCnAeo2jkbFS8E7Ainaw5fhc
 Kg_Q91WzHeoDNk3.bgz5FcgK.6dJb0pe9JO1s8kV82xPUOtyiiCdKn5tzxUTpQwGqAssKf8Zydth
 GZ4aq4AbOqXBSm1Ybjn5J..0fHa7vG0Q9V.Dj0W09aBtnDEleGdzmJucXi2hgt8Ap9yaNX9pjhO1
 DIOR3Dv.BsiTV89gts1V6Fbnlpf37aWgzn5anet0Mo.5J171BXbRjiHmPlJzFzfyeklnQAYOxN2x
 h2PL2HZmKMZfNbPIV1GQcWWGib65VtkD6w.re1XR.44LAQKKTtXoJG.m6HgMX5TkDkRzsT0Le1W0
 AewxwBmJv5Fvmgga_E8apOdw6iypcyuIMUTIgEdYabDviucxXbsmW7q8_X7mNQhtoR69_46VSY14
 QKcU61KI.hV7RiNDNF8eYvq9fRaAWVGGyssNnlJY6wMHvhVwHYcVTTlf2Aemyy.AQSITbgz4JBdn
 1PiVGencE_70ehyUg2y4u5jx3roOhNrNrBH7viY0ZKsjbjVtY5Zs.ilaVUwnPBqbNEWTQPNH08dD
 lGEm5aDg08y0wUBEurDvHNDfWkDl3YP7G_TjwjpO5rJqDkeNlzJvlQ2xCk5UWuqdXbvGFO7totDt
 sqoU3wMLb5KKQzqPyrcZ9Wat0PfjmzNZKJgZxfVRB_wcEsPrKTM6oz09bbcOwGVk4tRRJcuOHQSk
 pYyYgbF6kSKDHQlmbbHqXcxj6sCQPgzpbtbdDLmVdqHBkNKeLqZa1L5rsTSX7zu8ygemvgD5HBNr
 mTtXj4k2OCxgMa2aUKzTYSRjKbneo57E_.6KBY.NlvwNkKSSWKg.Wb0Wqa_Eb9ac5k8TsFd4RlPp
 MlA.Lv9ksWDNvtI44Q_gBn4eQoHHVLcKqJkW8SMigoAvQpIW61XAWZsxhrrwsTNnexauCEfJKszL
 WA7BeasMm_g8yQaKXi4kssWTfBqsdDW9.ovXB0yK.6bz.y1ah3Ygwih.3pZsDCo90LeQ16zr2y97
 x4tDVBX8qRaMqZpJBnaB.Dsu3ALpd6xaQ7LQHGj5hrPrVcewj_Ug9rnSp_oiXS_D4UCYI5Kcmdb6
 iyH_lUeXTKon.VF7cNwCSt2Xn4PYDHePsTKA0klrRotLWJPnQV2PDhooN8kd.9Vubl5wO1.10ruq
 gVy6vjX.8J.F3kkIjj1L0UylsEpkspmfALbjZuPQ9tKN1s8p1yBl1vbeBIX8XWFntym_LmV2LgPN
 fl7h6_ghhfHMmUwFJNkg81J36pZ57YT6ln1X4AjgfFgG3gcgYnu_nP8odk_pec0jjaSSguKGV3DB
 as5RIquu3MSGzdr6gwB6zprMA5WJE33eo7KHzar9bpT0aGk.qHW3DLNCKiNM86uXu0F2hpwKPD23
 IiU8ahrZ6ejPBh9EmDCV44fO.OMuUowq.QMFFzsJFMILdGL1l0ijjBh.Dqd3j_Rqi9G9a2HCcXjL
 zuSfDwUmOjF8_Uas9gXmJ7DhEl_grK1P6xK7.pkJrkc_s.9_RGEiYz0GtmCcRarNEu83UQA_9s9G
 gDodeTqdP4Nj7d9atjLhG4Q3MqO0DViqERFSQCOyxMRKHe7U-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.ne1.yahoo.com with HTTP; Thu, 13 May 2021 20:34:47 +0000
Received: by kubenode575.mail-prod1.omega.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 20a8231ad8c3c41f8549f1ba05b8d168;
          Thu, 13 May 2021 20:34:45 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-doc@vger.kernel.org
Subject: [PATCH v26 24/25] LSM: Add /proc attr entry for full LSM context
Date:   Thu, 13 May 2021 13:08:06 -0700
Message-Id: <20210513200807.15910-25-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210513200807.15910-1-casey@schaufler-ca.com>
References: <20210513200807.15910-1-casey@schaufler-ca.com>
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
index bb4c7f6c62ec..d3ff61442877 100644
--- a/security/security.c
+++ b/security/security.c
@@ -799,6 +799,57 @@ static int lsm_superblock_alloc(struct super_block *sb)
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
@@ -2232,6 +2283,10 @@ int security_getprocattr(struct task_struct *p, const char *lsm, char *name,
 				char **value)
 {
 	struct security_hook_list *hp;
+	char *final = NULL;
+	char *cp;
+	int rc = 0;
+	int finallen = 0;
 	int ilsm = lsm_task_ilsm(current);
 	int slot = 0;
 
@@ -2259,6 +2314,30 @@ int security_getprocattr(struct task_struct *p, const char *lsm, char *name,
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


Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEAE92A74C2
	for <lists+linux-api@lfdr.de>; Thu,  5 Nov 2020 02:15:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732162AbgKEBPD (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 4 Nov 2020 20:15:03 -0500
Received: from sonic301-36.consmr.mail.ne1.yahoo.com ([66.163.184.205]:34466
        "EHLO sonic301-36.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729858AbgKEBPD (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 4 Nov 2020 20:15:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1604538902; bh=cp0DCD6sR/fCmz7OQoTopP1WWvh1I5Q2QST/3/jaLl8=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=oeQB7/twGp+s0c3BKZJmgBXGN3zMT9NH3RivxnS6Wa20G50NImp5sQKqio5eecX7okqZA6WoKMpgbrP6kVgymuq3rh7C2puqDa0/x4mNhQVFoMsn3u3E6ZobDDouJXj+6bqXFsyEHsYBuFKPraoN5wRVwljaMjNlUjY/SDWE3+954W5HntdhYXiTE6aUSBlmSm4BLf+XQwDyGdCh5kVjRfOFIzXQKMLg15/aG8zaKdvxrYM5KMyOV3UfP9OpfAJFQGz8hvvShkpHZ6yIAsrYdRee5wO6628lwInHdYhPy4lR51j65ZPoyEITc3NAqLjtC4Fknd36365wPmJLUqMM9Q==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1604538902; bh=e1oOwmy/U6ozGnj9qlIam3bKhAH7YCNZNTkoe3NgZFI=; h=From:To:Subject:Date; b=EMHWAC5s6RxPVNZ6eoQlGO809BfDKa8qJ4y1CXq0knqCLVtNwcQ5EFJU4HvlPcDGWTdBxdv8a54wxLSvsDNf2Jeo0XIynt0A5aleo0vMVjNFvh8VsE9eU6VQQT5udX/6GOD+9iNKQvGOvMQziuQH4jzWnTxPAj64XAYWV77hETlgSHv5aVVsfbwOZoDWF7g+6rzvb5nEsa3xuYdVVzbR4DGA7n/KWI0IMY2uUY4CtcXAh8EhKOZqX8fS3mHsp01+vS44Pq/AVTx2mbNx+OSUQY3iS7Eu2jGEc5mkREi6mSLse5uu9Oe0QLn7PqDWXZ2SiQee9jisDeW2o6Wk3X0vSQ==
X-YMail-OSG: L3SbxvEVM1mvmRoRHu2Oq1QvDqMwCO85WMq8_IkYIkz8PgucoP3Jj0R3v0aGrj0
 NPCO36XP_iYoxVktv4h_o8ycAzCQgbTv5s.zgOUewsPt6fwRdcn6Awyxy3OzGHppvZzwjcMakMG2
 q_m2a.Em3RkA7o5CNTPk4M9BbNnF2yKTK3u9aAH7wiuHohMaWrPtoAixGqK0o5FBw.P.lYQinDPL
 HwklMGkHrFcF5OU1GwHESGcUtCGybXNzSXuk5zXaADmW20mMFmpfqZRsilZ4rAUDhyU0OxLY5NFp
 mnYvVsIGYj0v4NkbEee7Z66KELv2dxaSpKBr69P.900qeRyYv8TZEFNzwwyKZfNiS1_hCo0fpKSR
 vgF6PI1RLpFZllxPAPqmKUPT1OKq2wnzZNliR7OdPTuMujMBbLivZE1bjxPNWy97xPcR9me20mQn
 HEREPLQiAJzamW_fi2BHY2D3OhpdhDx2ZhEhWVM.k8lEHkrTpVg0CLbbS0mIIJ.NEwQweIixCkQF
 so0NHP9Q7gAhlTmg16Jb.W1Si2a0tk1cTsrdHDOBQuCqq2Pocn_7PkayfIVPhLvA0yYtWesUAk5S
 8afMYaMpfrB9sVLvGia_D4zZmrZIYPMzJSykrHz.1Wb8duia3oq06jy8qhN6TmtUsmr4B19lIw.A
 44r1WcpDEiNFpLLQYy03PHsRGX8SwwyLqN_w3qJEeSPlrSI.ae1sHbYCK0Gsenpx_zg__q9XEUa_
 U3RkDvJ82PAzP.qs1ib_kdIg2gPNNhHzG7_ofpoVkBYL68EK72HtlP0NzHCuMDmAd1TCjUggwpxt
 vFkrHHXWehohHHRolreBmVfXKslQ1YHzKzYDPvu77J2vIVXy03kvudP_r3IeRxHK0yxxfJLfDRuh
 z4LDQ4aZ_hgCClS1gMPH7hXhHkj6d0YtVfA2RYfS48.GLTWugJGcVyBoLlyHHfs1JRGPxDCm4qH6
 .Ncw1pYZzbmG2fj0PJifsqaBRT4MBPukJXxQbP4XQdeJ_W8_aJzwkPDHzptDw_yGFQmcvYvnzBN1
 4gcdINMwTROOBnGeszLSUxg0naExAhLPidcA5updHrrm2qPlFI1vGQ9..wY00Xi.D6ir5yLzpocX
 MoBXCsxZwcTIOONZ2UQrMnrLsPptJF50T92v4Rwbi1d6nj4meSquzx8KU1nUvbdQbIRiXF4yKPGw
 VwKIfzTnecG1KKkwfCH2_4ZT7trDgY2Zn9BD4KtDnxi2vM3QqG7P.6.yETfAOiX1toxAFNgUdJ44
 2_FKDP.kaBbC3OJ24VQd4JldtdYxH0JE5ULGo7R8MZ9aL2ldIuAIU_5GgTynqf9KCbZIQRbqZjxU
 yDlSQLgGiksATNcYFtx0J2sp3XsT9IGG2fUiO.Vs4PVMgKBthlkwh48YE7e.baASoyX8vcRdvFbJ
 0O0C44epEQcGZLAtJQV53Fu8UPrNU4BdRcdUNucXa7CBLA31i9UEy6CSuNcv7FRCBI.6Mo4kQ7Ih
 my_G.aw23M8cXv8HLbJE5RHDs90qcXZwpLTdBQzTxXXzhgBlz3LWJ7y_z.H5qfYKWZl6i8NNtEtR
 In58UXWus72rCSaUiMNza4FoQLuO8Q8UmQ9PxTd9LkdGqkDMmxsdadrFebQWKk_r.gXCzpgQ9YLN
 RX6P4c.zZwuchNZYHvSVCn9joHQLRVRKYjJVFHwlYARKj20LepQ5PjzXMBU.TDSk_kVWtH8occGj
 TsmvS_R.G2wkwDl9IV_.1zCahhb8rvAeaJePtDW5b1bmTfiyYQmR3m6OUe5p9wXUVf3NzbmGsRsx
 os1ZcuioL._FCq_4zr8o2pnoYmsldS6Bwin3flxujeTGYpO5gyi09CJT6_dum15ndIUXg1QAU2ye
 ld8QS00vAadJuZCqSyOk2bbwbsv1GPV477vk_jS2RSrpo8kwHMfxUauM7MlPFUzW9LcOYCAlCjaf
 mZ8iVM6ipwN.Q4BthHr.eQxovmlLyehzRTjJhp8WUAWkyRP9VsfZQ7ik4vWwS9tRHvemF6M4ZEkh
 .BT6a45.0_IJkjSL4Q4Dbgo2PXrWL_iEdjI7BjWk8AYVGHszzhlNfdc.mBjGda04hWE3kU27fV0k
 fReYj73nq320p6jqAYdddsojASrObGv_U7.cnMvpUsBv0gkQI_1H0VNo7RNEDd98h3C9jyRb2bdx
 64esy1yb4BBHjogKnu0CPxX1MtZfFLZOFLAsIR74W2djKt80YRzdrJ_QLrYWBcwhSszWyOdEFaZ5
 v7OQP0Zha4gknEctz0GZA4E_CenQ_zmD7she.Q7Ua4T8fxwJlvf9iTz862gHMTGE29pDbtcgoYI1
 LfAw8Oo7RDpH5KAle2mIzoVHH5gt5LxD01.paKvKA8enuXD0KEmGVS1CShnOdHKnJWSQQ3LItesR
 Nnp2kNQf57RYT3Pi1tosfzIFUTbdiHM1B99IlQsyvWAqKQiLIu0Uye3u3oeWvD29XMCS.NWuRFKl
 b83yf.fcoTNLRH4_niFi8lX5fwFrxJyewGJgyfKauFFV4EOvyD9.Sz.y.PHQHIOQoIE1f6jzuzG5
 MW6aJv3pXxANxSdNBEv8puYL.6BEGYvbMuB9fJr2bjm_poQfPAzSY3KZdO_A4zUQu9nkfNY66us.
 _KdExkzCPU.pk9QNUPwmvk9.Z9TpGQXJk7KK8KzYk991l.vyasnU1d9cYyqMksSXfstQRGkvmqhF
 RRL9chRcin4QZ6UeCvlRH59XvABEIA29WJYudE889EChly8Hcq4my.zrZU4KS8cuz98PC9PQMylz
 9y3670ZCEOOtlE8wrfdH.wzBk9_KeoQxmHYZiGRQ.JpnG1h.jV_u0gSB_X12yD2fVJpxTrrcUlHs
 DDRp3VYoyXGotOWn11uVPg4QGGRibtp_YIrA8xsFPVCxq0Juwr5O2pacqa_lVmcjXcUPjRZTKO6O
 shyMvWSGEfIoBPPAifTXhQOUCj_OpHn5nkUzX9VkBizIF2DokFwKN5I_TWDPXHIRU6zqPsLRR_ti
 6CC8BMQePkJkqorOwFEv48O7IcWo1F6rFZpCRgLDGbVkSfEh1GMyRKlO.PxQT8oqtt84Lk_bRf2y
 RsQBYAGFeFw.Z9xHgCvt_0Z4JKjZ9FBEXDZhrOGx3wOG0mnw2E.irsbmtkRY4WjXVjYU73HMxXWj
 Thy40FTWd5uICBC1LkJvs8ar4dvcyZcOEMjd5aRtH1KptCKPxoWH9UUBplC.5uhhYgFIS44wsoNH
 mFy.C.8OJMx.s3.Ct9E5ZST_LNwebVL_sl55U_MEJ5PjGd9seGWyOYdBC4JWNS3C0UxyRMQ_3IJ5
 HZvweyOse_nezhVGaumIWGYNWlM5nINcrb3KaFrxTMb5P3vVuKQWb.NuNamNLoL.7dYy57js5aiE
 QyqrHTkcBHM3InSDMk7y6iJ6_GAaMn2xVcgBj5_9pM3T76Fggw0uI3MMvdj6cGOCqq4_Ivi6.May
 qL10Fsatk
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.ne1.yahoo.com with HTTP; Thu, 5 Nov 2020 01:15:02 +0000
Received: by smtp402.mail.ne1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 9fe69b678eb4b7b2f038209b84e862cc;
          Thu, 05 Nov 2020 01:15:00 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org
Subject: [PATCH v22 22/23] LSM: Add /proc attr entry for full LSM context
Date:   Wed,  4 Nov 2020 16:49:23 -0800
Message-Id: <20201105004924.11651-23-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20201105004924.11651-1-casey@schaufler-ca.com>
References: <20201105004924.11651-1-casey@schaufler-ca.com>
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
index 6a2a2e973080..3a1403b7cf10 100644
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
+The `lsm` and `value` fields are NUL-terminated bytestrings.
+Each field may contain whitespace or non-printable characters.
+The NUL bytes are included in the size of a compound context.
+The context ``Bell\0Secret\0Biba\0Loose\0`` has a size of 23.
+
+The file ``/proc/pid/attr/context`` provides the security
+context of the identified process.
diff --git a/fs/proc/base.c b/fs/proc/base.c
index 7432f24f0132..1894ed42a2a6 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -2807,6 +2807,7 @@ static const struct pid_entry attr_dir_stuff[] = {
 	ATTR(NULL, "keycreate",		0666),
 	ATTR(NULL, "sockcreate",	0666),
 	ATTR(NULL, "display",		0666),
+	ATTR(NULL, "context",		0444),
 #ifdef CONFIG_SECURITY_SMACK
 	DIR("smack",			0555,
 	    proc_smack_attr_dir_inode_ops, proc_smack_attr_dir_ops),
diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index c2f5adef0ad7..5218aae856e7 100644
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
index 1a78f7bb808b..e59a75e776cc 100644
--- a/security/security.c
+++ b/security/security.c
@@ -757,6 +757,57 @@ static void __init lsm_early_task(struct task_struct *task)
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
@@ -2142,6 +2193,10 @@ int security_getprocattr(struct task_struct *p, const char *lsm, char *name,
 				char **value)
 {
 	struct security_hook_list *hp;
+	char *final = NULL;
+	char *cp;
+	int rc = 0;
+	int finallen = 0;
 	int display = lsm_task_display(current);
 	int slot = 0;
 
@@ -2169,6 +2224,30 @@ int security_getprocattr(struct task_struct *p, const char *lsm, char *name,
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
index cb124671c15a..97568224e7d1 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -6292,7 +6292,7 @@ static int selinux_getprocattr(struct task_struct *p,
 			goto bad;
 	}
 
-	if (!strcmp(name, "current"))
+	if (!strcmp(name, "current") || !strcmp(name, "context"))
 		sid = __tsec->sid;
 	else if (!strcmp(name, "prev"))
 		sid = __tsec->osid;
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 913d41b4b96a..b4bb0f3676cf 100644
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
2.24.1


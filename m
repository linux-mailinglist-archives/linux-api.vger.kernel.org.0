Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 532B4304ECE
	for <lists+linux-api@lfdr.de>; Wed, 27 Jan 2021 02:35:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728772AbhA0BA6 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 26 Jan 2021 20:00:58 -0500
Received: from sonic307-15.consmr.mail.ne1.yahoo.com ([66.163.190.38]:40967
        "EHLO sonic307-15.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730308AbhAZRLL (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 26 Jan 2021 12:11:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1611680972; bh=1064QeSjoXoh6KJ0b0dAW6Z4LBv9C2GI6nFjGOrk9OA=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=UROxA5iuuFHpJ43CvnRzLzh/H19F3qXBXfWK1bmxeyGz6enqSP/A3zyjuOn9UgW3jvUBrafcw9SLBWCg07pFp+i+OGdfd5udYggkXCw2evXKvcy1/PFOCN34DFVxCdXcKOWjTaM5dN0bhl2LWfVSDYCgK5tDEM7eOvhxRVtnYJyxHxE7GVPKVjlo8NW2lTlnK8m4TX4KlP7S6IesApyHjLP+4o8+JEUqrl2gfw6LFXvXmzqTYFJ+Z2Sk1r306ScULyOASv73aKpylyE9koQ7P9W0Ia2pQE9cI/mfMMIqksSwqfBQNm5Z+zW8XaVz7Bk/7j9pi7tNt7/57//jLq9ZyA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1611680972; bh=tMi/y87a6wRC98OmK5slfGTPQaQOVzuBaazKc4dibSV=; h=From:To:Subject:Date:From:Subject:Reply-To; b=lEvO4RT6gZ1xg+/faIpVBlOB/8vNJVUalXEeFRwyb3QuccdCxU5EXTt4h0KVDub5CqKd+hmc2kKnLkRf1VCXq9o93KAjaUbHamm38DyWbMJ72fSC5RNOp4NzW3IF1QMweFhcZekawgpOtsbb4Jisd6Bz9utWYEeBMEIhjR1fCbD36KsrOENX6Y7IqBLVNWURq2aJWqs4zvszLUogzDhl+Uis2QMka6bRp4tByYqn0mRtRWpsTiWjLWg/WnYuUec//VFLotB6X53y/dPOvgRtTEiGt07FEergjsDrfW1zuKuvSnTniWwfjYSnpQgkq1p3pduPdgLer6B6MATlxmbqjQ==
X-YMail-OSG: CvSyBX4VM1nOBG__NGluiJUp2e.QHplnoYFMU9IDVPI6.i2rIbZWRpy3Xv65umm
 bK0rSJE3XLlNU.wB6XfV.smafsVxySrCCmRDfefnuKz8.YcJv7ZyuxUE2cHoosGCW3HhHdAGJdFd
 DDnznuIw6ejFtRnqRjhUg5ZMQlZgwEP5f8aqvik2LKUpzH0BGcaV_8uDt3uGUhOYVQajLWOcNT1Z
 40Ehi9wqO4u419HW3jxYJRwFyGJlHlstpfroaN7X.gek6.yPmKWvmWBe.innFbEk5fs4wzAgcCa2
 4WlNO7iHtzLxscPzbewhbws1EB3.LOefDb4UI6VzpLJz6FEwYcElOpwb6NU83ZFiwv6zEgWYl2Ov
 ErdZsD0h8hgCHG10Z7b.qrVNC8RPACSwaWbYKW_4UYbTFy6lX36cexZ1tXkF57ar52ztDeGO4Q6D
 OPZtyPaxAEXy6WlIjgKcWr6SfGFUnNcNkGAu90nF1yU_EUqXMCyqETTn0TE9AvH6GzXmsWRZWPmy
 axnOHhz0N2KgsvOao84Hd8Ux1GgMjvjRIKugylhSE0Hmv1s53nNlAI60q5EM31kQdtewWD2agc.x
 0tPG0lDZvkW_OgNgkoe88UtBvvLJtMV920EN9Ko9QV07NOaM8ol2ZbY6putngCGAdt_1fsjffCNJ
 RbdNWWJBRwrn0.kxN3gLXcG9ErLR063gJGCxOXEme0DGCK.b007dVEtKQtaUlfq_au2tbLFm.GIX
 n4Tq8ZT_vHRzyoJ7F544smRNnGlAUXyNWjskCX_k7qPt61sDRCnKL5mNRiMaDoAPsskuiWloDzmz
 WnGtEAhEHv0Ry2q_PRyQdG0kIJkvrAVnKgfEyealsVrLSKYndXTM5HyVAmHTQ0N5_Twy1HZRwFlb
 4segJ7HHc1DyqQmsP0Wgp4gfpvynoUhT0QUTFucejj5XlmVI89YMGQpR9BvTbCxvIOB0TYQehK.8
 EDdwaTCvZ48BKAgwIHgDYnH_fSXQVwYHCp0RnShTpX.ETKuG97Khywd1_sTzXHGog0.TWfm6.zGe
 aVOAWhqt68V3aECBaMV1G5fs38PSPJPeed_MnCh6Rj4MxiET.6800_tDkLZZ5X7IK9ublChsVRc.
 YPS8fU7o3ycotYOzRZzPEU2ASf6vZFDGC5NX_QXYMPpe2KwuqdY9tHGpYef1Sz5r3A9n_P3DlhOv
 Lerrvu5qeZkCMFdZBUbCC3w8VZN_Es6ucT94yK0V88ZM8TP.AphvnV6Q7PUs2Axzbgh_v8ZY8fn1
 j5itPJ2SYea9bJL9F_9B3O3KMRs7FRzcag67bVZQipYO3o5J_5VAxfQ1Yn1WFQhosdCM3XyBNREL
 7mUaEjY6IEsWN2Lk5PC.EZu24e06VV.ZPXMx3yUDDH8DN7SYdV35PI.qdTnrLzL0N7zlx2w5LJk.
 3PZSgVf5xmzUiSxEQa2m43aQXYMmaK_nrqHjyABT4ct2SSFFw.g9hGMqX0NYmNOtnJpLSTl2YYfN
 Js3OaEpw07A_rsez.7mcsIgj3go8kr8xq1suYthY42LAGLZXyRjG4q0h5RnxpLNm3LazxgmT2VPD
 M7yfsu141PkznP9YnmPPvhR139M1g70VtDb4Zcp0n_g3OdywkYtCZ96DtvcqegXjgfXEbXbihuKZ
 NF_AFlc81iyCPHnKwPhJLaPX2VRxKq_4ffthtpe2utU7po7RxiMxNaJmIgoklusbyVWyW.p4.bRt
 CfWODf_CUhR0KlevZNSrEC3x02IJpHDXuPe.QUaobOHgH3CqnBPfS.G2hJxeTpAYlrX3QCQGsJ3D
 2GQJtyCzB9Mfb6K.TfZGJuX3_j5UrVB7A5mXxKw2ht2HX70pnnUIw1bNspWgNKM9J8oC7wr7149d
 hxnROB6wW50A_YGonu1Xx21llEKsfDaVLgIZosB3hjaCI4BpsRAHqGh2T4Tsv2AddksO3KYXsAZg
 MAwf6wvfRVRJszUJCx9RcXDxf7Xkf.nTCeD9Y6.KGRYz0D08N2plJyMDpOzTaOah8fbnlWDgG9Mz
 Pf7EiaELS18XVhJSXzRcgQYe_fzwQLEOJ7IlV2xPnjIQguX9OvkK2mlb5t63iKOfWp2n.pHBdky0
 CJ5Pf9uvqDtsJXNLuUNk5DICh4gA3ntc4rGPAu7rsibKjGWQgt916VlJVDJemd6diMD9xPTzA.lO
 tKI7e2nqoZETZ1zqc2WO49yALYHEqxPz3wEvH6YOBwDz_ZpEMZ2ocjlXxyPs7iAJ5a1ZozzUSSFR
 ooFrM.zqB2YocG1kUwKWmoxIekM9GlcrfiwUbqCrG36dSlZZPBL6fm3K3y_QmS20i0DhKgQD7sOy
 O5dHfeWx8z3taHlwg.MqmvslURnvpLhlRfv5BbFg84RPVCM.F35Jzm92VXNWr0tG_DKdsHFsSEXA
 XxNuZiu1AYW2U3eRX4z8k5M2ggo3k8rdAEzjdlGJf4q1_FA4Ca7IZjk2w2pVhTgiBxeHyjJp2JQ8
 yjQu1d9NHUcimVchZ4GfwZ2TsXOjMVhtvanTefCFpeWrFYiMZoey_zPXeLyXssLLbCU2WuHd9AIV
 KQ3MSFuGiPiSlO4WtAJvk7qaiNLqptLL3Pvi6eQzEUJ8nKzv5vlDm4gKTKHfa6PhC._1EMD4PoOX
 11YBJTVTNPud3fpEwNT.yL3ICt8xWj0ZGk4NgD3rblJFQyV8FEaLD7UhpgQUPRiUGz1AlLStbDQ4
 FKGlcIOzaQiJvFF5ebZUEr7SUSdLSiJ5RytIvnU76MvH9HrNqJqlL4iUVfzHv2U9qIfHXWh.M4Pi
 6l2FgqSy0lI3PXmxAd74c3Qvh_laYmr7Gwd9ErbPRH13NyrbREwbVPEAoWHIcV_DNRhaziKPr9l7
 gDm698WTKcl_VwjhO3CI6_oD8Iy86rQRSoRKtby1x3mDrNEgeVeXfmaNK68M5s0LJ1OuDgZ90pb3
 5TzxnVweAJma6XKSxBz7IuHqQmSC_Xbv6CwRkjJJAbQnqG7SL8VD0rPkD7U4GfVq9al_aALok3c6
 _VUhUCsOa56gzJjDxyv_sPcR_a5XjQpp9yxv.JsEkrOldPufIPbfFm8Ej0ioJu35owrG8lni1Wo9
 y4MwfIxznL5HFSl7ncRsPrL1MsgSddmetZ8FymZj5mz7quO1d2d2RuuhKFA9UFAQXgVT2wQliqqj
 dXlXo99JdScD_8X4xpgcCxIy16TYyCi7RZ1NRhrOI7xyuqEhD1E4NKq8qOhaOBdvS48Hg4ITI.fI
 aLkrGRPAJSH.D0TFPJ63p_ssRowC3N.eP1V3iq84u_CyKVXNEFIkmN_RYZGJzZcBJ3cUY9Mk5ymZ
 ROrNBs5WUcHmOO_xIFQ8.LvxdCUgRLXSdb5Px8SihcnbmLHQ9wwiWxP0xj1M49VKHHrapw9CeXIJ
 i9Vs74XNdAbn8FpYz.PBl6Hv_.xFWSUZS0AL4cwfF0szb4uaZuL33o.ziVilmcKXSoJsin7LFWf0
 JO68-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.ne1.yahoo.com with HTTP; Tue, 26 Jan 2021 17:09:32 +0000
Received: by smtp410.mail.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID a49219c8931d2af0497d122144ec9b9f;
          Tue, 26 Jan 2021 16:56:43 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov, linux-kernel@vger.kernel.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-api@vger.kernel.org, linux-doc@vger.kernel.org
Subject: [PATCH v24 14/25] LSM: Specify which LSM to display
Date:   Tue, 26 Jan 2021 08:40:57 -0800
Message-Id: <20210126164108.1958-15-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20210126164108.1958-1-casey@schaufler-ca.com>
References: <20210126164108.1958-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Create a new entry "interface_lsm" in the procfs attr directory for
controlling which LSM security information is displayed for a
process. A process can only read or write its own display value.

The name of an active LSM that supplies hooks for
human readable data may be written to "interface_lsm" to set the
value. The name of the LSM currently in use can be read from
"interface_lsm". At this point there can only be one LSM capable
of display active. A helper function lsm_task_ilsm() is
provided to get the interface lsm slot for a task_struct.

Setting the "interface_lsm" requires that all security modules using
setprocattr hooks allow the action. Each security module is
responsible for defining its policy.

AppArmor hook provided by John Johansen <john.johansen@canonical.com>
SELinux hook provided by Stephen Smalley <stephen.smalley.work@gmail.com>

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: Paul Moore <paul@paul-moore.com>
Cc: John Johansen <john.johansen@canonical.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-api@vger.kernel.org
Cc: linux-doc@vger.kernel.org
---
 .../ABI/testing/procfs-attr-lsm_display       |  22 +++
 Documentation/security/lsm.rst                |  14 ++
 fs/proc/base.c                                |   1 +
 include/linux/lsm_hooks.h                     |  17 ++
 security/apparmor/include/apparmor.h          |   3 +-
 security/apparmor/lsm.c                       |  32 ++++
 security/security.c                           | 166 ++++++++++++++++--
 security/selinux/hooks.c                      |  11 ++
 security/selinux/include/classmap.h           |   2 +-
 security/smack/smack_lsm.c                    |   7 +
 10 files changed, 256 insertions(+), 19 deletions(-)
 create mode 100644 Documentation/ABI/testing/procfs-attr-lsm_display

diff --git a/Documentation/ABI/testing/procfs-attr-lsm_display b/Documentation/ABI/testing/procfs-attr-lsm_display
new file mode 100644
index 000000000000..0f60005c235c
--- /dev/null
+++ b/Documentation/ABI/testing/procfs-attr-lsm_display
@@ -0,0 +1,22 @@
+What:		/proc/*/attr/lsm_display
+Contact:	linux-security-module@vger.kernel.org,
+Description:	The name of the Linux security module (LSM) that will
+		provide information in the /proc/*/attr/current,
+		/proc/*/attr/prev and /proc/*/attr/exec interfaces.
+		The details of permissions required to read from
+		this interface are dependent on the LSMs active on the
+		system.
+		A process cannot write to this interface unless it
+		refers to itself.
+		The other details of permissions required to write to
+		this interface are dependent on the LSMs active on the
+		system.
+		The format of the data used by this interface is a
+		text string identifying the name of an LSM. The values
+		accepted are:
+			selinux		- the SELinux LSM
+			smack		- the Smack LSM
+			apparmor	- The AppArmor LSM
+		By convention the LSM names are lower case and do not
+		contain special characters.
+Users:		LSM user-space
diff --git a/Documentation/security/lsm.rst b/Documentation/security/lsm.rst
index 6a2a2e973080..b77b4a540391 100644
--- a/Documentation/security/lsm.rst
+++ b/Documentation/security/lsm.rst
@@ -129,3 +129,17 @@ to identify it as the first security module to be registered.
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
+The file ``/proc/pid/attr/interface_lsm`` contains the name of the security
+module for which the ``/proc/pid/attr/current`` interface will
+apply. This interface can be written to.
diff --git a/fs/proc/base.c b/fs/proc/base.c
index b3422cda2a91..158771f87e94 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -2808,6 +2808,7 @@ static const struct pid_entry attr_dir_stuff[] = {
 	ATTR(NULL, "fscreate",		0666),
 	ATTR(NULL, "keycreate",		0666),
 	ATTR(NULL, "sockcreate",	0666),
+	ATTR(NULL, "interface_lsm",	0666),
 #ifdef CONFIG_SECURITY_SMACK
 	DIR("smack",			0555,
 	    proc_smack_attr_dir_inode_ops, proc_smack_attr_dir_ops),
diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index fb32b502080b..28a036374834 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -1660,4 +1660,21 @@ static inline void security_delete_hooks(struct security_hook_list *hooks,
 
 extern int lsm_inode_alloc(struct inode *inode);
 
+/**
+ * lsm_task_ilsm - the "interface_lsm" for this task
+ * @task: The task to report on
+ *
+ * Returns the task's interface LSM slot.
+ */
+static inline int lsm_task_ilsm(struct task_struct *task)
+{
+#ifdef CONFIG_SECURITY
+	int *ilsm = task->security;
+
+	if (ilsm)
+		return *ilsm;
+#endif
+	return LSMBLOB_INVALID;
+}
+
 #endif /* ! __LINUX_LSM_HOOKS_H */
diff --git a/security/apparmor/include/apparmor.h b/security/apparmor/include/apparmor.h
index 1fbabdb565a8..b1622fcb4394 100644
--- a/security/apparmor/include/apparmor.h
+++ b/security/apparmor/include/apparmor.h
@@ -28,8 +28,9 @@
 #define AA_CLASS_SIGNAL		10
 #define AA_CLASS_NET		14
 #define AA_CLASS_LABEL		16
+#define AA_CLASS_DISPLAY_LSM	17
 
-#define AA_CLASS_LAST		AA_CLASS_LABEL
+#define AA_CLASS_LAST		AA_CLASS_DISPLAY_LSM
 
 /* Control parameters settable through module/boot flags */
 extern enum audit_mode aa_g_audit;
diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index 1dfb8648136e..bfcb78149e9c 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -612,6 +612,25 @@ static int apparmor_getprocattr(struct task_struct *task, char *name,
 	return error;
 }
 
+
+static int profile_interface_lsm(struct aa_profile *profile,
+				 struct common_audit_data *sa)
+{
+	struct aa_perms perms = { };
+	unsigned int state;
+
+	state = PROFILE_MEDIATES(profile, AA_CLASS_DISPLAY_LSM);
+	if (state) {
+		aa_compute_perms(profile->policy.dfa, state, &perms);
+		aa_apply_modes_to_perms(profile, &perms);
+		aad(sa)->label = &profile->label;
+
+		return aa_check_perms(profile, &perms, AA_MAY_WRITE, sa, NULL);
+	}
+
+	return 0;
+}
+
 static int apparmor_setprocattr(const char *name, void *value,
 				size_t size)
 {
@@ -623,6 +642,19 @@ static int apparmor_setprocattr(const char *name, void *value,
 	if (size == 0)
 		return -EINVAL;
 
+	/* LSM infrastructure does actual setting of interface_lsm if allowed */
+	if (!strcmp(name, "interface_lsm")) {
+		struct aa_profile *profile;
+		struct aa_label *label;
+
+		aad(&sa)->info = "set interface lsm";
+		label = begin_current_label_crit_section();
+		error = fn_for_each_confined(label, profile,
+					profile_interface_lsm(profile, &sa));
+		end_current_label_crit_section(label);
+		return error;
+	}
+
 	/* AppArmor requires that the buffer must be null terminated atm */
 	if (args[size - 1] != '\0') {
 		/* null terminate */
diff --git a/security/security.c b/security/security.c
index 45824239cb2f..517623ba81dc 100644
--- a/security/security.c
+++ b/security/security.c
@@ -77,7 +77,16 @@ static struct kmem_cache *lsm_file_cache;
 static struct kmem_cache *lsm_inode_cache;
 
 char *lsm_names;
-static struct lsm_blob_sizes blob_sizes __lsm_ro_after_init;
+
+/*
+ * The task blob includes the "interface_lsm" slot used for
+ * chosing which module presents contexts.
+ * Using a long to avoid potential alignment issues with
+ * module assigned task blobs.
+ */
+static struct lsm_blob_sizes blob_sizes __lsm_ro_after_init = {
+	.lbs_task = sizeof(long),
+};
 
 /* Boot-time LSM user choice */
 static __initdata const char *chosen_lsm_order;
@@ -667,6 +676,8 @@ int lsm_inode_alloc(struct inode *inode)
  */
 static int lsm_task_alloc(struct task_struct *task)
 {
+	int *ilsm;
+
 	if (blob_sizes.lbs_task == 0) {
 		task->security = NULL;
 		return 0;
@@ -675,6 +686,15 @@ static int lsm_task_alloc(struct task_struct *task)
 	task->security = kzalloc(blob_sizes.lbs_task, GFP_KERNEL);
 	if (task->security == NULL)
 		return -ENOMEM;
+
+	/*
+	 * The start of the task blob contains the "interface" LSM slot number.
+	 * Start with it set to the invalid slot number, indicating that the
+	 * default first registered LSM be displayed.
+	 */
+	ilsm = task->security;
+	*ilsm = LSMBLOB_INVALID;
+
 	return 0;
 }
 
@@ -1675,14 +1695,26 @@ int security_file_open(struct file *file)
 
 int security_task_alloc(struct task_struct *task, unsigned long clone_flags)
 {
+	int *oilsm = current->security;
+	int *nilsm;
 	int rc = lsm_task_alloc(task);
 
-	if (rc)
+	if (unlikely(rc))
 		return rc;
+
 	rc = call_int_hook(task_alloc, 0, task, clone_flags);
-	if (unlikely(rc))
+	if (unlikely(rc)) {
 		security_task_free(task);
-	return rc;
+		return rc;
+	}
+
+	if (oilsm) {
+		nilsm = task->security;
+		if (nilsm)
+			*nilsm = *oilsm;
+	}
+
+	return 0;
 }
 
 void security_task_free(struct task_struct *task)
@@ -2100,23 +2132,110 @@ int security_getprocattr(struct task_struct *p, const char *lsm, char *name,
 				char **value)
 {
 	struct security_hook_list *hp;
+	int ilsm = lsm_task_ilsm(current);
+	int slot = 0;
+
+	if (!strcmp(name, "interface_lsm")) {
+		/*
+		 * lsm_slot will be 0 if there are no displaying modules.
+		 */
+		if (lsm_slot == 0)
+			return -EINVAL;
+
+		/*
+		 * Only allow getting the current process' interface_lsm.
+		 * There are too few reasons to get another process'
+		 * interface_lsm and too many LSM policy issues.
+		 */
+		if (current != p)
+			return -EINVAL;
+
+		ilsm = lsm_task_ilsm(p);
+		if (ilsm != LSMBLOB_INVALID)
+			slot = ilsm;
+		*value = kstrdup(lsm_slotlist[slot]->lsm, GFP_KERNEL);
+		if (*value)
+			return strlen(*value);
+		return -ENOMEM;
+	}
 
 	hlist_for_each_entry(hp, &security_hook_heads.getprocattr, list) {
 		if (lsm != NULL && strcmp(lsm, hp->lsmid->lsm))
 			continue;
+		if (lsm == NULL && ilsm != LSMBLOB_INVALID &&
+		    ilsm != hp->lsmid->slot)
+			continue;
 		return hp->hook.getprocattr(p, name, value);
 	}
 	return LSM_RET_DEFAULT(getprocattr);
 }
 
+/**
+ * security_setprocattr - Set process attributes via /proc
+ * @lsm: name of module involved, or NULL
+ * @name: name of the attribute
+ * @value: value to set the attribute to
+ * @size: size of the value
+ *
+ * Set the process attribute for the specified security module
+ * to the specified value. Note that this can only be used to set
+ * the process attributes for the current, or "self" process.
+ * The /proc code has already done this check.
+ *
+ * Returns 0 on success, an appropriate code otherwise.
+ */
 int security_setprocattr(const char *lsm, const char *name, void *value,
 			 size_t size)
 {
 	struct security_hook_list *hp;
+	char *termed;
+	char *copy;
+	int *ilsm = current->security;
+	int rc = -EINVAL;
+	int slot = 0;
+
+	if (!strcmp(name, "interface_lsm")) {
+		/*
+		 * Change the "interface_lsm" value only if all the security
+		 * modules that support setting a procattr allow it.
+		 * It is assumed that all such security modules will be
+		 * cooperative.
+		 */
+		if (size == 0)
+			return -EINVAL;
+
+		hlist_for_each_entry(hp, &security_hook_heads.setprocattr,
+				     list) {
+			rc = hp->hook.setprocattr(name, value, size);
+			if (rc < 0)
+				return rc;
+		}
+
+		rc = -EINVAL;
+
+		copy = kmemdup_nul(value, size, GFP_KERNEL);
+		if (copy == NULL)
+			return -ENOMEM;
+
+		termed = strsep(&copy, " \n");
+
+		for (slot = 0; slot < lsm_slot; slot++)
+			if (!strcmp(termed, lsm_slotlist[slot]->lsm)) {
+				*ilsm = lsm_slotlist[slot]->slot;
+				rc = size;
+				break;
+			}
+
+		kfree(termed);
+		return rc;
+	}
 
 	hlist_for_each_entry(hp, &security_hook_heads.setprocattr, list) {
 		if (lsm != NULL && strcmp(lsm, hp->lsmid->lsm))
 			continue;
+		if (lsm == NULL && *ilsm != LSMBLOB_INVALID &&
+		    *ilsm != hp->lsmid->slot)
+			continue;
 		return hp->hook.setprocattr(name, value, size);
 	}
 	return LSM_RET_DEFAULT(setprocattr);
@@ -2136,15 +2255,15 @@ EXPORT_SYMBOL(security_ismaclabel);
 int security_secid_to_secctx(struct lsmblob *blob, char **secdata, u32 *seclen)
 {
 	struct security_hook_list *hp;
-	int rc;
+	int ilsm = lsm_task_ilsm(current);
 
 	hlist_for_each_entry(hp, &security_hook_heads.secid_to_secctx, list) {
 		if (WARN_ON(hp->lsmid->slot < 0 || hp->lsmid->slot >= lsm_slot))
 			continue;
-		rc = hp->hook.secid_to_secctx(blob->secid[hp->lsmid->slot],
-					      secdata, seclen);
-		if (rc != LSM_RET_DEFAULT(secid_to_secctx))
-			return rc;
+		if (ilsm == LSMBLOB_INVALID || ilsm == hp->lsmid->slot)
+			return hp->hook.secid_to_secctx(
+					blob->secid[hp->lsmid->slot],
+					secdata, seclen);
 	}
 
 	return LSM_RET_DEFAULT(secid_to_secctx);
@@ -2155,16 +2274,15 @@ int security_secctx_to_secid(const char *secdata, u32 seclen,
 			     struct lsmblob *blob)
 {
 	struct security_hook_list *hp;
-	int rc;
+	int ilsm = lsm_task_ilsm(current);
 
 	lsmblob_init(blob, 0);
 	hlist_for_each_entry(hp, &security_hook_heads.secctx_to_secid, list) {
 		if (WARN_ON(hp->lsmid->slot < 0 || hp->lsmid->slot >= lsm_slot))
 			continue;
-		rc = hp->hook.secctx_to_secid(secdata, seclen,
-					      &blob->secid[hp->lsmid->slot]);
-		if (rc != 0)
-			return rc;
+		if (ilsm == LSMBLOB_INVALID || ilsm == hp->lsmid->slot)
+			return hp->hook.secctx_to_secid(secdata, seclen,
+						&blob->secid[hp->lsmid->slot]);
 	}
 	return 0;
 }
@@ -2172,7 +2290,14 @@ EXPORT_SYMBOL(security_secctx_to_secid);
 
 void security_release_secctx(char *secdata, u32 seclen)
 {
-	call_void_hook(release_secctx, secdata, seclen);
+	struct security_hook_list *hp;
+	int ilsm = lsm_task_ilsm(current);
+
+	hlist_for_each_entry(hp, &security_hook_heads.release_secctx, list)
+		if (ilsm == LSMBLOB_INVALID || ilsm == hp->lsmid->slot) {
+			hp->hook.release_secctx(secdata, seclen);
+			return;
+		}
 }
 EXPORT_SYMBOL(security_release_secctx);
 
@@ -2313,8 +2438,15 @@ EXPORT_SYMBOL(security_sock_rcv_skb);
 int security_socket_getpeersec_stream(struct socket *sock, char __user *optval,
 				      int __user *optlen, unsigned len)
 {
-	return call_int_hook(socket_getpeersec_stream, -ENOPROTOOPT, sock,
-				optval, optlen, len);
+	int ilsm = lsm_task_ilsm(current);
+	struct security_hook_list *hp;
+
+	hlist_for_each_entry(hp, &security_hook_heads.socket_getpeersec_stream,
+			     list)
+		if (ilsm == LSMBLOB_INVALID || ilsm == hp->lsmid->slot)
+			return hp->hook.socket_getpeersec_stream(sock, optval,
+								 optlen, len);
+	return -ENOPROTOOPT;
 }
 
 int security_socket_getpeersec_dgram(struct socket *sock, struct sk_buff *skb,
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 49f721511b55..7bc9a043a30a 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -6342,6 +6342,17 @@ static int selinux_setprocattr(const char *name, void *value, size_t size)
 	/*
 	 * Basic control over ability to set these attributes at all.
 	 */
+
+	/*
+	 * For setting interface_lsm, we only perform a permission check;
+	 * the actual update to the interface_lsm value is handled by the
+	 * LSM framework.
+	 */
+	if (!strcmp(name, "interface_lsm"))
+		return avc_has_perm(&selinux_state,
+				    mysid, mysid, SECCLASS_PROCESS2,
+				    PROCESS2__SETDISPLAY, NULL);
+
 	if (!strcmp(name, "exec"))
 		error = avc_has_perm(&selinux_state,
 				     mysid, mysid, SECCLASS_PROCESS,
diff --git a/security/selinux/include/classmap.h b/security/selinux/include/classmap.h
index 40cebde62856..1858aa47b32a 100644
--- a/security/selinux/include/classmap.h
+++ b/security/selinux/include/classmap.h
@@ -53,7 +53,7 @@ struct security_class_mapping secclass_map[] = {
 	    "execmem", "execstack", "execheap", "setkeycreate",
 	    "setsockcreate", "getrlimit", NULL } },
 	{ "process2",
-	  { "nnp_transition", "nosuid_transition", NULL } },
+	  { "nnp_transition", "nosuid_transition", "setdisplay", NULL } },
 	{ "system",
 	  { "ipc_info", "syslog_read", "syslog_mod",
 	    "syslog_console", "module_request", "module_load", NULL } },
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 010f97c703aa..ef04029dcdf1 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -3509,6 +3509,13 @@ static int smack_setprocattr(const char *name, void *value, size_t size)
 	struct smack_known_list_elem *sklep;
 	int rc;
 
+	/*
+	 * Allow the /proc/.../attr/current and SO_PEERSEC "interface_lsm"
+	 * to be reset at will.
+	 */
+	if (strcmp(name, "interface_lsm") == 0)
+		return 0;
+
 	if (!smack_privileged(CAP_MAC_ADMIN) && list_empty(&tsp->smk_relabel))
 		return -EPERM;
 
-- 
2.25.4


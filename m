Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23B63417A9C
	for <lists+linux-api@lfdr.de>; Fri, 24 Sep 2021 20:10:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345908AbhIXSMF (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 24 Sep 2021 14:12:05 -0400
Received: from sonic308-15.consmr.mail.ne1.yahoo.com ([66.163.187.38]:43818
        "EHLO sonic308-15.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344874AbhIXSMF (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 24 Sep 2021 14:12:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1632507031; bh=Wi/0zGMkWBjm+whVPx9Ty+ICQl8YOy9900i+1+9VMkM=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=X3Fqp60Nt0Ye7ZI687yKJ0ZiAI7Pon/vF7wxT0krj2WchIksNVPWWnNmKz+xQLVegmXR092RN2s83xiY6lP2VORCi0WbeKc5GoBV8/tGEsUsD/v2pd9LCJH5WxoPeTjrd//If+Y7bgnLZy2dfg9VsBeU3ASOB65h1a+QxODNCCfV8xscmO9qTRQiWYq9pvMK2D0h+XYuUXno6ESBtd5vRgCOunVBYRvWfcbGRftm+zcB+UsFOdZoBsjj0xm1NwhWoGDTCtVkiQ1ZLpLs11TSJNq37upMarnMEFvFmHeOpG/3vylf3Q6UgiNt0Y8ADLE/19e88ZsNHEq8+8I8GTS5Gw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1632507031; bh=B5dpBKZWof/Qd6vXkiRxSBCsTLEG7cH/coaQDlTdXBF=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=EE/Vj6HHzfMMk/3AE7HaWJPjR0ydJPTgVGrwMH1LsoehjmQyHXPJicWpQmAI+i1UZCoJBvLkq+rhGtlETunVvIDDYss1e+qMUt37GkJOFH1WMPgp3Lqdlh3MUMDJGhq8IVMnqTJK1HaJdohOem/kJDGSghiPkCkvJZIJZcRdLz02IkeFHe/FT9f8hxNcljLoM93woD0zIj5bVmgl2tTk69NHi/qH+/DOUyuil4bj7li/HKjWcAevDrsKP5Dhg1kHRP7yL9g6fIY/btT9IDrjZDN4NWn+01FnZLn94tJCOk5WA4nEj2tP2YfcEJPHsYOOQ9N6krUJ4AuvEiUUZkxrgg==
X-YMail-OSG: OGS1aQ8VM1nD8QE5_8FUMPetz4NVvCCVSeznMVHX3TevXtoo8dhElHxSw_oWmfZ
 o5FuA5Ar3TejeruFbyojC62hdJ3pDi9sSpw3hD_fy1Cwy.ZuTDN2zUzjWYuQyxc1BYW_R3KSYzFj
 ZYN977S1l_nfjc8cPNmh5td8ayOgE7XNPaWWyicvLeglx1mm2reVvWlJbGsSY.reAMurLG_pdHWl
 .Jb_dmU0U2mlZkP6XiM5VikNgk6Q0Kd3gdRRAGVhTHqrkSJloemuhl6aQo2jOGvD7LZCfp4AYuOu
 4XCFaBrINz2Qi3VwMZRLS8I6QqwMrB8R7dR7HVPvVhjNZO.X7IeU5VO5XXxAK14s44W2l804lxHN
 AZw5ZtxXiHiKIVbF9QsqFQZdtZbcozlgRLdrEVdkRn5GDRBLRr.49i2s5Dt1YUyDSxfNZSDjcv4r
 e.qSUt4BR5jSQcLgNjT7bIdepY4LpbpRlO8Y_7.4qYHIudlECEyWqoZu8.tuSLCMaKn3tylZHGhk
 B0nLcFPM9YX99OScr_t_lUZ14_VVfi3zxCAV_cRNx8_qoh4ubPTtdgLGvpJJvdo4X.TTvnrXA8bd
 d948ORGUEpKVfCurvBU_0Ij8Z.4ejny1LBaB8IFwLUQv3g36tShYUrmHGq3cctidg6PnZCM0RKcb
 5oagpa8O6HTBDGHOVVAsywfjIxWCw2ubCQ4YwJYAQ3T238DQfRRhg.DsYDsNGj6rk50lCz9.KJcH
 .nJv13MC3Ep8kD5dXA.cDYk5kbDN98_TN4zfhfu8vHiVn_ZTsi05ghDsqfYTB86Gg3rhAVEG9HsN
 XasAON98Gi4CLaYadAgzD6QmZuBJib30ZelGphFhjR.QR.lA3ZfOwLu9fnDu7c7W3A7_y3II.kcK
 6YNXrUjGtCR4pqQyF9l4z8KPKAoBxbCy30eU3rIz.e_y3oveBZVRrUIG3MNEQKypqe2zO3VTAw1A
 Kfpp151nzYvHg_OoPQ9zn1TR5l.w2o8uQx2zl.wN5DpltPL7OBMkVVONq2hog32DF5hL0iE3g1hK
 INxF7jLgkCN8AByT_oPyMICkDwlWqsdKrSjsY6rn14lJ3Z685XOCh67rsSmsK9s74N_jiP6NGXVA
 JF3.LyqGtsqsBhzntIYKVUcN38jf0VDWUsyP8CTwOfU.CCsel4_UYRPIggTUqr7oySIvnjPzsoyt
 zZITIZeTfea9Yolxe7jTq_cC_d7CAQD.LWwhGFd1r9ZgApBfUF3QAnvXVzw9M08IG6VU2tnLnfJj
 FUUV9JKbw.H3JSFh5GawSSYtKB9SatDPsagw9m.bAA3MjXezbhWsTJgZEYcqEsruiyNCyDwg0z2M
 x0aST37TaV.rGaYqRFLcFHW4oes6nkl6pare.RN_mhZF2_6eXjD..rec0TJg8jPEJ46dhvC95Hol
 OSEhubUTTSOmpBOOUDa9DkCFk.5PLOYueSM1MxYNv.V6HsvPrgHtKFrAGJNK_CNlOugMo32q6bOF
 UHaatZHeH4IyVu4uupAtAy6EQa0k4R9KkcDp6fg53IXe0pQVNLQxIN3jO3J9ronp7mDWxQn0tnax
 K_eqDznPIllMEHHyK9hrK0_fBAcV8SgJxfxUIAs4c.A871lrIEGdW3ur1vl8EJOFSakfmI4g.92s
 Qc7I1yZOdXd9Q.CSqTosJAHpMZDllsjI2V.thni2qTmuR8yYLP8gohBlK0suFYB.3.ji8Ukya4Yo
 p6jtPGOpDH6sWzfW1NepDfNCds9z9v9GbtuiScj8OKNf297iMAgM.Q5o7ybbcJgTrv.RLniT2O65
 XX7UrbtzIgGL8Nha4KeRZ8zUFxhGUSIxbie4QO5IzIcPcexIBBF4wzIyWbOa5ad1MzLnftNceTX6
 XpiFJ1f57iaSc9EgWTOtCSsi1XD_NxOQBT5m4ZB8IfGDaeyeP0TAC.bcbv2iUDMveIJi823zluAU
 Atf1tLsLsTWXc.ItXuQPuGo.UnSZg9vAJj.sdSkTNI7InHMfW6L4FAB7UivH_bOzZ7ZPI6mAl.Nr
 wHcwQWioSh0UKizyRh1dn2sDlspcwiONjRg6VTuBHKPcKgN8CoD6xzasBXhUlyo3xAiRWZkIvuyb
 M7llRmx0d5WIxUzpi9rJf_L._v7PSK_zDgZnp4AuHSgtIuQ4FSNyFvgu05w7W6TSaVHwT51fajvb
 YeM86egwnftCnoXJz6PByB9E3M1y.4nbSEPSSpA2rZdftgUzGiESyeN31TTNzvxK9cOFNhQFP72v
 yQxZ_IYqbwg3mnnP4K0O2hCevlXs_Cn1RjLrUHZyiUP4iRWoIbJSSVmNyls2LII_vJu3bARIKi3N
 X3FLQexg6nU_1GeAX6pF3vMwj4xmwX27O_LYKUVRo
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.ne1.yahoo.com with HTTP; Fri, 24 Sep 2021 18:10:31 +0000
Received: by kubenode530.mail-prod1.omega.ne1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID fe57542e3a96f3613d965a321dacc17a;
          Fri, 24 Sep 2021 18:10:26 +0000 (UTC)
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
Subject: [PATCH v29 14/28] LSM: Specify which LSM to display
Date:   Fri, 24 Sep 2021 10:54:27 -0700
Message-Id: <20210924175441.7943-15-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210924175441.7943-1-casey@schaufler-ca.com>
References: <20210924175441.7943-1-casey@schaufler-ca.com>
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
index 533d5836eb9a..65da9d2f3060 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -2823,6 +2823,7 @@ static const struct pid_entry attr_dir_stuff[] = {
 	ATTR(NULL, "fscreate",		0666),
 	ATTR(NULL, "keycreate",		0666),
 	ATTR(NULL, "sockcreate",	0666),
+	ATTR(NULL, "interface_lsm",	0666),
 #ifdef CONFIG_SECURITY_SMACK
 	DIR("smack",			0555,
 	    proc_smack_attr_dir_inode_ops, proc_smack_attr_dir_ops),
diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index c61a16f0a5bc..d2c4bc94d47f 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -1686,4 +1686,21 @@ static inline void security_delete_hooks(struct security_hook_list *hooks,
 
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
index 392e25940d1f..4237536106aa 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -621,6 +621,25 @@ static int apparmor_getprocattr(struct task_struct *task, char *name,
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
@@ -632,6 +651,19 @@ static int apparmor_setprocattr(const char *name, void *value,
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
index f5e9f2eaf5da..863d6f77df2e 100644
--- a/security/security.c
+++ b/security/security.c
@@ -78,7 +78,16 @@ static struct kmem_cache *lsm_file_cache;
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
@@ -672,6 +681,8 @@ int lsm_inode_alloc(struct inode *inode)
  */
 static int lsm_task_alloc(struct task_struct *task)
 {
+	int *ilsm;
+
 	if (blob_sizes.lbs_task == 0) {
 		task->security = NULL;
 		return 0;
@@ -680,6 +691,15 @@ static int lsm_task_alloc(struct task_struct *task)
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
 
@@ -1735,14 +1755,26 @@ int security_file_open(struct file *file)
 
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
@@ -2174,23 +2206,110 @@ int security_getprocattr(struct task_struct *p, const char *lsm, char *name,
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
@@ -2210,15 +2329,15 @@ EXPORT_SYMBOL(security_ismaclabel);
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
@@ -2229,16 +2348,15 @@ int security_secctx_to_secid(const char *secdata, u32 seclen,
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
@@ -2246,7 +2364,14 @@ EXPORT_SYMBOL(security_secctx_to_secid);
 
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
 
@@ -2387,8 +2512,15 @@ EXPORT_SYMBOL(security_sock_rcv_skb);
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
index 824a0df03aca..06974ad48b9d 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -6504,6 +6504,17 @@ static int selinux_setprocattr(const char *name, void *value, size_t size)
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
index 084757ff4390..2c68408491c2 100644
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
index 9474fcdaf002..654b8a66df3c 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -3508,6 +3508,13 @@ static int smack_setprocattr(const char *name, void *value, size_t size)
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
2.31.1


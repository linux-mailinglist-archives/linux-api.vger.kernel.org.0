Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A785332966
	for <lists+linux-api@lfdr.de>; Tue,  9 Mar 2021 15:59:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbhCIO6b (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 9 Mar 2021 09:58:31 -0500
Received: from sonic309-26.consmr.mail.ne1.yahoo.com ([66.163.184.152]:38382
        "EHLO sonic309-26.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231534AbhCIO6Y (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 9 Mar 2021 09:58:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1615301904; bh=1bJns34HrbIVgMrEBletH0I1iECyE9FyLi/OCydtV7g=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=NF1IgvmNdxu4yp5RF7niLbKiHcN8SWhWo1KCrMhD5dtTMuuUgb+1Du2OfUvmCp55Xg6gc+RuQ3cltHsJZy4rZeZ0uf5EnUHmO3XKTZ/lesrByuoiLQVqC62Yf+gOj72GXrQR8DkazkHAwNwgbz9lwjnBpUMyq0N6msgXDwtt9hZVxOzCqJ/t5XyAkZ2hTbW3L+Ac090bsUKO9fX4ZiaedoeUIqo/aUybc2ErE5eh+68HVgdup+iIfi9CCmx6WNfRSDDE74SzKV2tteR+dLRwZRQFRDJlkEQoV9Dv2uElv1H48SqPfke49NudE6daxJRk2yMvsZPTONBOtdcpuoRM6A==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1615301904; bh=dNddzbjEkPGr5+OsOs+nxTmLkkOm8Bu4QEgdkg/Nf5L=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=dOzlH+BXxBNV9ADjiaBB0w2uC4XXfaJEU47jKA4jXf8iG6osNL3/PaFjZIQN84vW3ptxbVrZIcWMhtRDU7UnYhfSreYpXsAZpV75nJOtdG0c+JYXcJCETBaVX7IJ49tX+uC/WPYdlTdB/3Tniw8U9yXwaMj8X4uRb6zLrqTDBZuNxY7+EZ94c9xP87JwxDbTsN8KD4FycehZyP0r/iR6IPaoCyop+3zEHnBFdOB81Rit/NanthLhLgMOfFCpd4P2hHxuUZHAnWRA/tSMmoYpreSZMKNyr44qW/0LaPQf1O9vXo4BIVQs09fP9rNbYYeDAraHe6rTVR5rk6zpt4uteg==
X-YMail-OSG: h2.T5GgVM1ly89IbgrG5lCRSoYorRPwf._hW4ZNPVLw0wlE55LTrL8LxPaskVPW
 0HFxymRtWTEenx6eg5gyqy8.o98xrKCJhR6b0XpegiWQGKL3OW0d6AH03hteHjL.RB8I1.XlYuY0
 mYxok16cK0zRxEME5WwI.oWig7JL6jpnHWlWsdbxLZ.gmm.cnkePYTMt.BnPzNTaGSR3QcDAtXAC
 SGe0vfTsh_pTw0Q_zjOIXFjbq.7p7hDvUzRGggxphvF2bPopeZGgVe6LCkjoAMB2eDtzBU_ysWP6
 T916yye47UD6Xjnfn9kzoctJTIkiRJJyhN9k1QylLaK.7bE99M5hHn7eYmJZWnLQaSN2sGX759VK
 CiLTyUucCnkkLDUsoo_utRheV129BKwvMfRzRVC_teKubb_7Sryl6OrqATe4zW.PRyYUPBEa7Kqe
 VUwzXqQc9KaSUxZ8NobufUimjS1F4y6VDRz3o9uq6H9hZ1wxlPLIuo0JNwIdbhljFrC17r040l6X
 O1lw_JUlBda6tdXCz6OfZtNYrB_MaES36DaRxekWWAuadVzpS2EAFcivMV1h.ldrFkbjgMT0xtAf
 Up1b5zVsh4rMRyI21elS36P8.kiqkFUZDJgyuQK6MMDLORkIMtiiQrsK8yBznD9VqLmiePCEjMG6
 XN1UVR4yh8DjWOp52WJNvmwDsHaclkLkffCGWnCZsy_ksQrA64RED2wK1OuQ_2pxnipsjr2AdOSm
 5h0ULAheQfENqc9ipPOz9Llb6jVoTxDqsnJmI_jFl3K0nNm8Ff9WjNbCCZypgO_IbPcUthbWv5LZ
 0jzcdXPmJF4Qo89M4ozi4eUF_g_Y5DgJRMfG2pRV3FA.Dbk5w4PwSb4YAGhS5d_jvv_JTp4ppeAj
 QmKqPUQxKh1Bxpm09yTe35vKK4MPdAeR7wZ37r6.ofAhCsxmE_oMu_ZL8_X.aNsAnp7vpGnQW2GO
 Udyd4_XYirVgsN58hrUdMogm_s0DKeb59ahSthbxxxHocmegdt.yvQJv0AvF79Xk9DAEHGd34qa6
 sMAMjXKtZC69LSjc6eH_fZFxfS.KF4SPyTIvv8rSW9BOHXx_Ag.bphdr_0sL62gWMQuYVhrGvLS1
 YiIGUQPLOM.obLIqhpJqS0WXE72sE1hRXu3fX5CKoLO8C6DbxoduNHlK0lRNK8cWYbBeCO1EZN6P
 w8wiar70w12Ik.Dq8H61DkauB2hIlcMuCkST70KoJgDsPl8yNUa.QtxceocyQFQbGwwpfSqgQbxw
 S_QUqBme3R9rUQGXXoO80Yx8Z6Qg1roaceJnh.1D6MSYhksYU2hAuto_2TjTZr1KMpfgGoh4QkrF
 ERjbnE5ka7w7Y2YyEepoHEJwTBuaWStKGS3lOYI_oqOf1y9OYIE3CNylsfK1c78M3qwJJG9yhPmG
 twDYlz5kQ6WqPx_OIo_3cSJGLP1_zyOaiQFpDfuId_qyCYvHF6PXSOz9_iOCerMeeswmLRZg_QXc
 XYKo5VKE.p6zPc56_WhdaubxHfMVpl2QR5xKUN9zyeqxyWYLT0pFX0vu2UCjCP_ROQrwUUtKKQk6
 nBv7i4fqViKvW5S2dYkxjwzVgpNqSIyhpBLU_22L_B6fWPEmpnLSNhi8ZQpa00dr13uN1KkwBLKl
 RkoZbnzUAfBwUg7.AIr0zFL4E0yz8s5Zcb4A63WHdhdnrggEoK2yuHS3CWyLGjwD5QAxcffiunwQ
 w34B3iXBI9X2whLi.8.IJx90t8y.n0b.pCs6C8r832gp1pZ2_Z.BrcMhz7EQyT.QkdcNMH3l.b1X
 DWr.Ktfsgmo4jcobAk8THKnXjnfT43Gkj.bwJfe64QWkt0CjkQ.f4eRPkqnCxTzrloGCmIPj9ME2
 Jk5ER11NOGZo7M8gCL1_TXyndmOryyQC5Y8z71QDtV0raWNeuOrngqv3uuv9Jbvsn5fMKYabAFol
 N1bsOhmLNewUKRGMzjkz2Vj0zBNZbCfsl.OsGjZYt5c_1WX2CzA7og9rPYNgBAHEWTHk6JcnbmV_
 SfJJDez2CZR_a3tpNGxefcJQ5IVsPLJTqSf1qXhiarKoqOqxVdlWb4lO1tiKSAnPkZfHTii9Tbpv
 4q4kylRXbHk6WJV7xYJaF8Xj03A4Hb_MeA53DAj4lnmKWJGcVyRKlgDiHQvzPTqj6s4zQjPvCJx.
 HskMQnYRqD80AaSAZJwJ68BKQ0ZcLW3fkv5m95MQNIxOKSmTd9LEiIpcfTdZOj_88d3FXo9cRvn7
 doHhRK2w.KMn9BlV8DEQWtfn_bMZSmYKtYk2kSWIOUv_Zf.BsF6nOmZZyjFghIA3u_ht.umPZHzw
 Xa_p_.yy1s713fqryNp5eLOVdSlmxDysejXCtHx4nTg6tPbPPgh6FTVaQ.CDh84Hn6dNxUNhcTx1
 On1fCrO2GSXFfPV8x2PlxDdeNF8fU9f4QHvx60K5mTXyjqe84zjm8RXlOCbYOPM8g0bcHsxol1eu
 fHVk6XvYaCRaWggiU8hKVwp5pIJIWy6YHbAHZj_i9PVJ1xRp8I_SbwuqfU6kLl9sRu9zDRxoWCrI
 Ek7F4..AllmOHn1HxkRcrEg4v_25svlbMqjYmkOtn8IBDzD2nGKaHVCuQDRqk21t07oBSPurpQGw
 XSM7SuTSSgGiXvgb3I40Iv4wCT.hzabDcokQ0ofl9kqSjMNNaeSVQC3ZtJYl0GsgtZw71dZjpqwu
 pTI7oILTsl4kfP0xyu3UjgVokOWhEB1VOMzntVwy6twPgxCWNhIgI2Kczo6A4nJEmOms2ph1XNL5
 ofzAD16I.3Fynv0s8XUXCbI5ohLlKtl2QuyCxbf.B58nXSheevDomCXrkWcQczinkSWo0s0tN6qG
 E7Irr7guSVnu0lFEfJX..vQQ8A4kweUsyW2UntilH.q7gWgkQUKe4ankWNzxvDbbxbx68NAV_4fa
 YOp1Yx6glflj.4LAK4MU8YLWY2J1ZSDcxkw2cLUliEMAh37ws3.xuEwOMlEQWgbdBg8MwRBZiqpK
 iofG5vFXli_g0KltXezXgEDrm8gII3WKeiglQvl.VrpJb3DMzYB4tde6Mei3hGVDfZVS5qKn2Vkx
 kjOJZP8SojimXYmW_9nI7v3hDpuVWqjhSICe8fI15ryzvA1UQMJlT7kleqcGYYPNOp28IiMQqLK2
 FEUMOy6MSVjTVQVId8DV.mhF1GuUiYyOWijRUdsyrwhhxfDHnlrXiWBhxi2wC8z7C8HXi2gHJPnP
 hD8Ok8cOMGktV.lgKjHOKVEWzRwxpwkSKHfShR1jDp3h_oZMa_iEVFSBv66Ljb7lqqkmlPOhNbof
 iXiLjqhGQqYOGzq7mfFgk.nWRT6W4eomU4.AfX.qdJiR0brntWJIumsUaXk7LHytKZJ_xQJypR_R
 DbRLKptYurWk8ZTIJvadS5UwkiXaOY3erNUiWyUD5C99kdkYAyGSzYU_1w81tCbwJ795Dy4X1Jzc
 CLCFAzeHYFc1ILl78G_msf68oNdCbHA--
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.ne1.yahoo.com with HTTP; Tue, 9 Mar 2021 14:58:24 +0000
Received: by smtp407.mail.bf1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 1cb5fffb0b4bf4c1c5e9539df2a6bbd7;
          Tue, 09 Mar 2021 14:58:21 +0000 (UTC)
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
Subject: [PATCH v25 14/25] LSM: Specify which LSM to display
Date:   Tue,  9 Mar 2021 06:42:32 -0800
Message-Id: <20210309144243.12519-15-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210309144243.12519-1-casey@schaufler-ca.com>
References: <20210309144243.12519-1-casey@schaufler-ca.com>
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
index 3851bfcdba56..10de522f3112 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -2807,6 +2807,7 @@ static const struct pid_entry attr_dir_stuff[] = {
 	ATTR(NULL, "fscreate",		0666),
 	ATTR(NULL, "keycreate",		0666),
 	ATTR(NULL, "sockcreate",	0666),
+	ATTR(NULL, "interface_lsm",	0666),
 #ifdef CONFIG_SECURITY_SMACK
 	DIR("smack",			0555,
 	    proc_smack_attr_dir_inode_ops, proc_smack_attr_dir_ops),
diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 5509e4ed9829..ab08da884b2f 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -1670,4 +1670,21 @@ static inline void security_delete_hooks(struct security_hook_list *hooks,
 
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
index 7d5559b4c417..5bfd313a7cd5 100644
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
index 0d9a4b50f252..df51140a4d93 100644
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
 
@@ -1688,14 +1708,26 @@ int security_file_open(struct file *file)
 
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
@@ -2113,23 +2145,110 @@ int security_getprocattr(struct task_struct *p, const char *lsm, char *name,
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
@@ -2149,15 +2268,15 @@ EXPORT_SYMBOL(security_ismaclabel);
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
@@ -2168,16 +2287,15 @@ int security_secctx_to_secid(const char *secdata, u32 seclen,
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
@@ -2185,7 +2303,14 @@ EXPORT_SYMBOL(security_secctx_to_secid);
 
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
 
@@ -2326,8 +2451,15 @@ EXPORT_SYMBOL(security_sock_rcv_skb);
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
index 96c560760c4c..3141ed8544de 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -6434,6 +6434,17 @@ static int selinux_setprocattr(const char *name, void *value, size_t size)
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
index ba2e01a6955c..1b4a42150871 100644
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
index 023876c3f3a3..576f412b8616 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -3511,6 +3511,13 @@ static int smack_setprocattr(const char *name, void *value, size_t size)
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
2.29.2


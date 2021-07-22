Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07AD73D1B23
	for <lists+linux-api@lfdr.de>; Thu, 22 Jul 2021 03:03:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbhGVAXE (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 21 Jul 2021 20:23:04 -0400
Received: from sonic313-16.consmr.mail.ne1.yahoo.com ([66.163.185.39]:39904
        "EHLO sonic313-16.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229990AbhGVAXD (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 21 Jul 2021 20:23:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1626915819; bh=Pccl6zP/t0CxuewlyEafaxbC+zYjtgHMcdqr/hO082M=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=j+bD9hq/udDthyJ3CnJtbNEXa8M0nVn1kNxdLqv30kL155Jd4sjrgiP25AWBJiqXjzaVUWF6DFKztcWjLPr4zE5AVNb3GMnNEQdjhtSlFcPlVcQSXBDrm/u0xwbUXYmdSR8CnqmVjcT8Vlm3Rbf/VlDkggFpxa3NUOc9PbwdcDnFCsl1R6Dpje6yLl9eLyCEdSVApAJ977tx6574BJIxwiHEJfR/bqmBT8pw2ePrHRyeJbjVCa3LKf5nkkKotujAbQo2Kx5iStXvFOwHMXAAAovHQiTMeEB5Iz7kAJxqMWe6I+ntXtjeStIIUj1tmN67fYnVu45jwmSQSFBxakuV5A==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1626915819; bh=e4SAlGUa4Fe6pDBifEU3mVq8ZbrClWN5OmgrTYvgKMu=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=LI4UW0JPgR/aoAhZDJGZavRb31pcnzvLf3N0FpvgSN4DnmSe5H+5iHXNA8sahEwAOtRzV3LcPrQexbcPIwgXlR5PMnri0t1nY+hKNlF+WjA04DHZ0EM5KBInpWeNTTggxZGIVWJm4wQwWvRLlbssrbneohz3DYU3d58gs9aYDlEoGl3TD8BJ2G4ajJwrsWes9IGfSR645L/8Kn5gaYwxB2z6DBriHtOiCHMydaSLiXfH2AHML9ncriJNDT2IMXFCQkUcGIotoGt8ZE2bujrp1tRm/tccES8rrVru+5ddBjePcvCFYibTYj5mLF2YhwmIVIpNoNK1Zhw1A/a++1fP5w==
X-YMail-OSG: 4Kx2RA8VM1l5K9fCeqcrPB04.vBcfcAe0w6dW7II.ZewZ_.Unnv0DipgMFAfxZ4
 KFdxRhpYxN9MTEm4mWK7SlhUKWcnZENu3.zitm1obnbz0YGT5f3wQYEp3beMhzDt7gemRdsuKJdm
 K8JBtQ6sLDEqn5OWmpDFfw8g7D89T2B8vbu_AQFgk8WEFcxDlVkZHLxeptoS2o37Rtncqe09ESfK
 BMvvesKTo6KfylGnj5v1zQfZgOe5pway8fqqw9kU7g.aLAbe6lng4u9PWHwddUK3YFo0_fqSP2mG
 FZBLxSx0Uv2.enQB49plS8vi0S.sWWPXVONID.VpLoCGyQJPqkSaJj4TSUx2jrkrUK3VQQg7VEEO
 dzJ.SK87SW4_0R5yhmz6IR3GKtz.9_IEB2VVkM2tfv2fOc3UcliwnYjIA0eK9H3sT08aWRjuszN9
 eXTnE8TzBEhTwbjJrscPTMYYYvJXGLsbIRYmGCdRfkcJeC4HQG00yMVmUlMnCxsj6Lj85xSlK1HP
 odEYHOmXMMW27ZO09rKIlcunLINnSS.Xmdlcq7Gv52Qt_4eWbFWGkYCTGghwrBxz88F5ZA6fAY24
 aJ9obiGd14qTNxbpPEyHhglX.m65S_j.RjICndGs3Z8eRKPr32UhC2z7ALiLdw1M4Rab1TjgFNCk
 58IpCp8gEMvOmL.YxKZIAWLcsQQh6icYOcw6fTm1W1yIvqqu04XOrNx14x1ZpikUU0jG5J_jUIGg
 Ybp9g9JJMCQXFC01tjyfBdYxDsvCq.W1vyxR9w84vKTPuOajpYOeRTBqxSdN1zV.Fu2kxCaxitA3
 7XBzr1DiGtQzcVjzhsYCIZsDZpXPbDBxNg.PPMjvxeLoU_FbzIjYOgHOSsSsykTMxYpfCsE6R9wh
 PeXVxJ1yOEozaP1RcqKcsRbzQFThY9UO27w.ZmgcNGRb5wQKNit10p1qrWzENFgR5cN2AK4RuCvN
 ZpFRHVSoeRavkedtJ0XLPblv1DKdN7_28Hj8cJG3px4Kf_3EbE8wz9TEMas4w2o4.tF6I0rv6fyF
 SIuPAPYnqHKQ7SjV4mlbg5uctrFBFqJTSs_WYQwj3R1UYLEsK6Kdia5o1ozmdNvLxr.ydM9UIFe5
 KelZ3eyUWZRyn31eF1PVjmeiTgTlKF9DjXWN7OiUGOANMgtB62jtd9iqPon9FlaSpSa.Ma8Cn.7F
 eOBqgUYjy4GeZXjt_tsbhAUAlCr7RKUCXrZ49qIrSExXDMrKH2AHCCthsEeCbk_50UhwVJtt3mfk
 J1Jydl_69we99T1OTGTPQFXObtOFuE34sGgVlhrVoJtz4NSQBjqabHCY6_T4IttCGDgi.38On7.Y
 TT.Dzv5atxDmik7I6FylwZ71kxwAHjadKlGhN6hlo8oXzWs3a5.OzjRrcYIWbsewG4Fbn5GRcAJr
 dXSShZooxj970Jr6xUbwHs5qT6VwO.w_QskyuEOyl5DpmBp1U2i8FXq1B7fdId3kvtJBC0omfyGy
 X_upPtEB7xO2yJdPrWgbyAxsZkaLnX5GKtN_5e_wmvsCjlJmBM5C1Jh1eKORaA.7qGrz8ra5enbg
 bsre4dRoqFK86233mIuQKCMttco_2gPv3Kz5R_Hsp1ciSORwy9CUsoloilWITt1Autt3P2Dt0Ku3
 ddVmVRHJwNsfo1.CFTtrmysh6m8qt1zhYSrYYbsXfQGZ.ZZrUTRZKp1mzrupQnHx146X1wwbYuxe
 uF1gkpZrS0apjBOGUMy61SFri2tr0cLuVkCdv9NGWiK0dnCh2Yxkd_RcgZX8VcWz5l5kEtLwARka
 PqtNGaS.QPVvEG0Kue7itNJWoUyu7w2nZ7y0zjJ7XmGBp_vGCh6CkCDH6CNb0SsTZ7EHaPSDqYBl
 UmQvUeIflU.16bYHauq81RmS5aseMjdj6UhmpkmUtuiyArjmlmsx5kkmjBfzBG8hMGu6ocrDa.oj
 q6yoM.xMnHkomDjUEJiobBO431iEvOfNcU0BMfo.zSQ_NSSEZVN4JukFTeoGg7YS6M19BS5QTKte
 8Sejwj7lOIvQczU0thE_keWinP_C4.DeRoC3ctAzVWnO8mdaUeeHaU6QdJ30INx6hZqpbYslOH5A
 opctGsNJ0cM1ABRipMFbMmP.3VWDsCZ.D9zkI0LmnC6Tq4LQXwIFDclVo457jeE.3Oa5pLhOHkW_
 L7i3EnRUx9oxmDTc6elHrQjEL5EXOK9.DOVRpAAxNWKGfVDqgg71flIf5IuYv47m5FWkWdYdEyJV
 I1abYek1tpMz5AHz3EfgXkxjWquvN97kkcDe9TfVyT5QoxVg_QLaJa5WmYS4rSVseEE40_bEorFk
 NOl5YT.IBA0hX_YHmUyobvzk2GGUs8MJSGiHRF3VQoYOh_RiObbRj6LJnD5IDwc.d63hsDTiuBez
 YYxX5_39eTatpBrPBXDyFK1aC05PJW1QpU4JUw8kkn9Z.QlRH15eC7duUqNAQVcQYEbrZwTrGStg
 n5DR0ixjFi5W_9gWqKwdwTHwE2dgXrXNjrV1sQsNcYma7Bq8wX_VKY734Enc_CT9ErDo74O5ZCdx
 7e1Mk3IwnD5B4Fs21KwzDpwCMIL7tDnTLhbZNz8tvBigfMT_X4JZ.E7S_6A2x4BJ.zEudG42Ieia
 ZDn1XpPxLh_vLr50JmieQCz0er6r0utflhRiHzTm_yBnJLmzJjrDEV.5g.NmtS2YYOKJn3zPCDpG
 wePY6fetRdXh9zf5UBudDZHnPgwV.EVQjW3oMHO65mAhxyD.bfzEt_qGe5SNQIZJv8o7OfvlXpvg
 xk298yXUYncgjC_v2f_IuZJzjHEnhIBbtcodLtkWkqHf2ibUX_geo9pRU19udSmgoikWcvMEIai_
 4rywUPO9SCRaLhjRdd5BFOsGmIfNWUkMZWoZv1NBpNN8YcbLjDWPYsIxsiAvdus1UkJ9EbEY7Q14
 u875qEbL9XojIqGNvKF7SkdAFn0vo61gAUVV63CtYDn18DPdn98rHwRX9BzxylO.bZFrw7pTQQxi
 lwZOy5H8t2a_goOqwom4NrSXbS8UE1xh9dUBttqyR6wzCcOHFHyAARhmd21Ch0rZ6wqrLheX7qji
 GapFmUj4IdjpbPcL9xbzaJ_YEv4fCpgz14SgQ9Fc3Mr2PPOHg6sf.0IjjzwRm57XjtnoyxtBfpfZ
 eCncTD9Mrd2xX.mWKwzV4m_lTRYl1DnJWxeftxQR.h7o4lGrmms7r58AypzFhQKEM9Cq5kSOHx31
 WHzIR.6Rud_lBNbRPFwQcZVcOzRNWviIaJm5EOP_nnd3FEg31dzFcumLM0iRQQjY1vHvrjo4etVO
 8milFkqjwvsxvs0as4hQbBsdma9uY43mKIDMvEvvHzkf4MHE5Stg.CR0_1Ma5W6U0JgcbKoPCIbF
 VBPKNdIREbK3FaaiA3XS_qTobp.jzF8S50xSlenallN6za2tdUHOzwkRZvH9VsmA2kpYH1F5jx8y
 1q6B3hr1GmJV7bj1xLZakT61XmBeebdU2zAWcYBuqi1e54NhCLDhMii2qHwkD0tLc62Ct
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.ne1.yahoo.com with HTTP; Thu, 22 Jul 2021 01:03:39 +0000
Received: by kubenode548.mail-prod1.omega.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 975edf2d75cd54edf352b3c2fe720bd6;
          Thu, 22 Jul 2021 01:03:33 +0000 (UTC)
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
Subject: [PATCH v28 14/25] LSM: Specify which LSM to display
Date:   Wed, 21 Jul 2021 17:47:47 -0700
Message-Id: <20210722004758.12371-15-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210722004758.12371-1-casey@schaufler-ca.com>
References: <20210722004758.12371-1-casey@schaufler-ca.com>
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
index e5b5f7709d48..f80ed1c40053 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -2820,6 +2820,7 @@ static const struct pid_entry attr_dir_stuff[] = {
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
index b4a268c1aaec..7829b8f5d15f 100644
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
@@ -671,6 +680,8 @@ int lsm_inode_alloc(struct inode *inode)
  */
 static int lsm_task_alloc(struct task_struct *task)
 {
+	int *ilsm;
+
 	if (blob_sizes.lbs_task == 0) {
 		task->security = NULL;
 		return 0;
@@ -679,6 +690,15 @@ static int lsm_task_alloc(struct task_struct *task)
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
 
@@ -1734,14 +1754,26 @@ int security_file_open(struct file *file)
 
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
@@ -2173,23 +2205,110 @@ int security_getprocattr(struct task_struct *p, const char *lsm, char *name,
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
@@ -2209,15 +2328,15 @@ EXPORT_SYMBOL(security_ismaclabel);
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
@@ -2228,16 +2347,15 @@ int security_secctx_to_secid(const char *secdata, u32 seclen,
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
@@ -2245,7 +2363,14 @@ EXPORT_SYMBOL(security_secctx_to_secid);
 
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
 
@@ -2386,8 +2511,15 @@ EXPORT_SYMBOL(security_sock_rcv_skb);
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
index f84b6c274a10..3b95eb39a3bf 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -6500,6 +6500,17 @@ static int selinux_setprocattr(const char *name, void *value, size_t size)
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
index 62d19bccf3de..8f4b0dd6dd78 100644
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
index 5c10ad27be37..7aa7ea38f627 100644
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


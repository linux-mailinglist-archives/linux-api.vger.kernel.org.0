Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 126832A7354
	for <lists+linux-api@lfdr.de>; Thu,  5 Nov 2020 00:58:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733267AbgKDX4r (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 4 Nov 2020 18:56:47 -0500
Received: from sonic313-15.consmr.mail.ne1.yahoo.com ([66.163.185.38]:45228
        "EHLO sonic313-15.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1733151AbgKDX4A (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 4 Nov 2020 18:56:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1604534159; bh=N6iORuVgdJrnPiBRwx/E1Rjlds9E5M3v9taI9rMKSHk=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=AUwLlcAUU4dYbYzjs6ZmxVAC3bnbOkT+qHZQ/8snbXf8nO43a1nIbeYWZhHKNIEvdDcjcvMnNLcSl3E+GrzF/zrDaLoyr5SZq9GI572oVeE+UlEFnqHcxvMdyG9stJvaweo28bVkmRdbRbWusGO1UrSzG4RekOaOuSbiS4wovBkem6UKU8Oj9L8CsdpGn+xx7UX4xGarak1FMxTI5+UlFZZTJCZwN1fiyznlPckOltptKOsz3SqZDzHdTW2blxhBNZY1bNiDnWD3ebdymXpARoj8Z17Pm2qgNSCUdOlrkE+I5WjX5pF0hyMQsId0bCv2762SS5dzB/mQIGk7osbOAg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1604534159; bh=b1eOB3fuV9PbLUiKiWgjCLkmmpjaBZ/rAJV87FIEy8a=; h=From:To:Subject:Date; b=Dwc0a1bEBBuYOb2zH1cwP+g4Nkw6GYTWUA5locVoQpu9x3kwwPm7LF1QWfYnDLEcuTSYA+gp2bJUdXSrDfNA6jKBlfjNlOiLEbhz6eMWYu9YAX5hwcjBqdfmfTzqqBmaE9z2FFxYntLtNKmtkx+V/OWFvSHoRd32i6kuuqz4sPMnA6qi2OrfbCCoAdQFfvAI5HNtfrhX4di4yZxFRPoTzqWtJrr7/gqdePAx9Rfsi17e2NXLxDtJkBuj4T2ASB/JGj4suAB/j96HFfyNW4+WFYP/6kYI567TYifYUiW+xjGW4k11k6XA7Xk7adwIFx1Dm8Rp7MzpXHjO4AzrTz8QGQ==
X-YMail-OSG: SSL.yVoVM1njgWDgdrACv2KhMgEk4kdJFFamRTErETTasLWdag2myXk4ZSaqInh
 whu_0Of3cDrv8lfo81wqRyZ4iaN4OPLCK9TNLtH5HFvuqPodkzcJ_6j_7FVfRozmJr8I0jf0cez9
 RaqVNfE.dJ0KTk93SdsP5TvtIzJOgj5UQKp9nXnepVjwNxuodW2Tx_V1HLks2by9LwIRGo9KhhHu
 ijsDbWmlZ1ssPfEjO3aUaXH1m8kWapdBpUNEWRBmr6yK7DkpQ9brG3xrrpaWbjLyUkkPcpHtU7xJ
 A_M_wI4dwDQe8eO5hvyDs7bhqHQkyNGTqwYxoVbEtxIosRavypSNO132c2C7IPBiTHkr5l5BbpFt
 zAk0mla9kjbeYZnyB2i5pDWIOr_ncPjgoqsveW5RiIjTEYCduNAUftD7rTSmr.kO4awxd92PCA0f
 0.JUKeOLcVWi28a.19PW.q4o3.iAmEWhzWz9dO4YC1tomJ7L3D22igTsXQT7ogxNGA.aBrde.MnL
 Ul__nYpcJd9NlQp5Vd0egxcrNdVTAIOoODJZVexFl8eIEopw1_9ytbOxQM7ifJ1ScDS5u8msbrOv
 7Rv4kLoVMxnFymNcK2PymDm6YwFBQq0hvXpNCfrs4mYDCPSn29ZcLu_04Uxd9DJy1.1TdFefk.9p
 Vpw06fkgSfM._M4gdCmuwmYhWBg7J8eE3_gqekTkaY2zkl6_Y6P08JQ7Ob0e1NlAOsIph6fEtyEA
 Zm6GikeVbntXSGcCSMPIcje5DlRDVCoauDt5d.4qoQ5NnAom.o4LjlRkGZi4knrn9JsH0BKtRr92
 ANwWr97Avuw4_qiSZHC.aa8Ms0o301iB9ji_69Nh79tbHe0voGdsXjFYmzGvL3VVLH6rk4UU7o0j
 mU8FMR6DrjGIAcqzKnUU.XyiQySS_y8xE6kbF474DJmzJjYlUqmLZFFwMPRloIZUCDP7V_wGDdnS
 pDc5NcZQWk921jdHpaH0ZpX.6f7sdgvxjqhYh96OrFLdryopF_Lm4_VDrw69s9ihYAnZaudh2LGg
 NfMVu56V8kTUap2iiM9e5BoyIgACGiRaEMgQ4FhwZglGFD5J9lfU5YMzIVhXrtlyKBwpKfCW8Rtp
 pPxTIUDbe0gAUMZ.mXMhoE1.1cx.2.s1RccA1e.AOghw2c1e7yCUN5W4JbMX9Pw_wCn8RyiBhLRP
 ZULMZ3kxr_3oDgugVx.8PmIRvmI6WB0XD_rckMdAbEc6RjkaBPCxNFr.dSpcwpfERjN2mUK0yoTj
 Y21WFH.2Dvyz258UqQOcOEDXmGcujHjdvx405.wqWPeis6SJYt7LmWnxvATvDoHgOtwAqMuIcebt
 7UYcwqGO0rDvEUuS7Eo5Pqz4bLuEkdcuRlZUTPx4j0H83XNJzw4Un.mFyrURe2cfiTHCsCJ93yvG
 0KWpJ60dwcFiOR6AwPM8AlgaY91D.2oOOy8qsE9F.VTFlt_pGHBQZ5z37xRl9tBPx_gkDVE1S5wZ
 TT3nl5I8P4HDtmV6pFcYiJhv0rZQkSalaLCm_1.wmUwbDxhwDOD6GUM5hqouDAW2gpooPkCszuS0
 xvZObMHHer0S9uBMFRbQYQalqfdJC7cn3nRpDyaNC_H7kYYqH5jYr486veuJIGBwrr_qgV5NRJw6
 kqXZ6mPBcJWsYvYFndI0pMYZDAmYEXYwZe6wdEkVzigY1c3H3Bjc9NAsc9eEGgVjBx6XpbGGZW.D
 dvXdmGuNWvf3c69Zv1s_R3QN7LjvJfmLdChoylBUYQkJAPf4q3I04Reutg.7hCPEYmN81Oxn2pWc
 EpiTWAoVCmKGV5qfJDjmxzhNhG7p.w3iijm2j28jCWXO6vCav5Qpj03KeJtE9iSVTLZYLYL5RpPx
 48hDDR8bksclt2unv8UcstSBYCrivdlg5Y9nDdXfo_tfy8r2BaU7uRQDXDmf451Rfc_5yMd.D9Lp
 ubypx3J60FGRqr0peiAvtJqfdudrotC8E1j9QgFrpdYoAJRYRlPFHDGz2IW8VW8u9CJN3W4LsgvU
 PQv8FmkSfRjCfUx1l.nMhnICvOa0H0bvYyyN68bfSF3StGEnS2IK9wfL2M5oQSonQw__zBleyZsF
 WvyBCjsKQKNuJyHz6RhvlVtP5pMI9YGq9Azb3OtfTn9qBEnO7eBccnh2WlGCNMAlaXhGkbPOBs_7
 nqEd3EVJC.VdzZrOYZLyOow84yoadFXdJqO7lQYIf0efMRAJ4d90rdVXOp9mApw.YeVle_1GK59A
 QULvWODHkQDrJefAeNV8I6QGE640tK9EuC52SDcqdXqpchWopW2hXpwD4GdgVnvmfk3wMzrl2kWJ
 VKxbOv3pTIkN7bf9BcO1NwtP9sJjSo6mdl5SabP0F3RVtFifzyt.NIUK0wfBuVmtNlQqdGJyB8UG
 Lsf3FkVgHlsicKkwg669X84Xnc2M8BpuZTuSVylmB9sf2ezwI28vm.qlihh8q8lwibI.WOQhRtK.
 5gu9.t_GQJwf_7GrMyQZD.NkNmJfKXz49oyAtZdst.pL2Is9.oakdjFb9A4I2JkF7ussi5Y_BgYH
 1ds_ae_bhEmgvRF5_fPQRR74Fud9rpkTsAjg36k8Bj8FzzuAYDTEcC_kr29Cg.2TLCRTzJvwYdS4
 gGvzxlmsGEA4fkqK5UK2vScTps4mbk6jnjRaBIeixcWlKJ9gHl2C0gX06FJZq08eoRwSHOB1UVnY
 KN_71.Nl.A5WiK2TprgHDcX.AJKhqeERrU_aPeULZ9xrlhf6OEm7Z21j1s41Y6JB.Z7lH5zKLNd1
 9Pk6aX3nd6sJ_MGL39m8fGocWFE96PuX2NSDR3UtcjT9FlMHKIMbsWPPS5SAMPvq5jso0l8f713M
 ZbsNyem38WtdyIfrmXWM_aasZGKeKAXZw3wyDOOJzMFSy9cyp000P.UpPCuT7TB58H39l4MBoHx4
 mluW1U9VnfN9k.pWIOrssuDn4OW6CpGvbp6fZyoj.bWaT51GtRFZdQW6IosIv9QF_xxX5XxxxG82
 Q5.WVfMvjI.BW3f0IM0N70X2VZvvsXfL9xW7u8icEMLDkv5BbwA6iAXejdoKTgdY9RQPi8DH0FPq
 _EuXYiQDWIFBsl5OHM_ku5JzvUSalugli_82kFf.kRPE1kzD5n_6uBcvVCcHsuAF12Dpxqb.VYIr
 .H3sGtB9oUj35qG3Zqok1waWSbx1xVbVpyRYXpCg411h28iF7V9Gr0CTv00d78S_Tr2_UQySMBvx
 PzSPRREib5Nl4Z9h6Lbn2j4H72x1s4GL_gAj12OqphS6IFNieNONdticxIdoIrCEBy0MzSdppmnT
 JmXnyRTtdZj51RUqLx2.yY_tU8HxPukSJnFqjKRKKeoOs1S37x32.iIMPRmOENghhQ1l3CfRYl5P
 WKW73s0QuiBTCmvhsgB4pKT8eJnzeGOKZD4Hs_FoTtUWPI3W3kz0ojmBW7h7WBXONJr4eXoZFaAQ
 -
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.ne1.yahoo.com with HTTP; Wed, 4 Nov 2020 23:55:59 +0000
Received: by smtp422.mail.bf1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 4ee3430ab44837f61159983ac4fba4ec;
          Wed, 04 Nov 2020 23:55:52 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org
Subject: [PATCH v22 12/23] LSM: Specify which LSM to display
Date:   Wed,  4 Nov 2020 15:41:03 -0800
Message-Id: <20201104234114.11346-13-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20201104234114.11346-1-casey@schaufler-ca.com>
References: <20201104234114.11346-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Create a new entry "display" in the procfs attr directory for
controlling which LSM security information is displayed for a
process. A process can only read or write its own display value.

The name of an active LSM that supplies hooks for
human readable data may be written to "display" to set the
value. The name of the LSM currently in use can be read from
"display". At this point there can only be one LSM capable
of display active. A helper function lsm_task_display() is
provided to get the display slot for a task_struct.

Setting the "display" requires that all security modules using
setprocattr hooks allow the action. Each security module is
responsible for defining its policy.

AppArmor hook provided by John Johansen <john.johansen@canonical.com>
SELinux hook provided by Stephen Smalley <sds@tycho.nsa.gov>

Reviewed-by: Kees Cook <keescook@chromium.org>
Acked-by: Stephen Smalley <sds@tycho.nsa.gov>
Acked-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
Cc: linux-api@vger.kernel.org
---
 fs/proc/base.c                       |   1 +
 include/linux/lsm_hooks.h            |  17 +++
 security/apparmor/include/apparmor.h |   3 +-
 security/apparmor/lsm.c              |  32 +++++
 security/security.c                  | 169 ++++++++++++++++++++++++---
 security/selinux/hooks.c             |  11 ++
 security/selinux/include/classmap.h  |   2 +-
 security/smack/smack_lsm.c           |   7 ++
 8 files changed, 223 insertions(+), 19 deletions(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index 0f707003dda5..7432f24f0132 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -2806,6 +2806,7 @@ static const struct pid_entry attr_dir_stuff[] = {
 	ATTR(NULL, "fscreate",		0666),
 	ATTR(NULL, "keycreate",		0666),
 	ATTR(NULL, "sockcreate",	0666),
+	ATTR(NULL, "display",		0666),
 #ifdef CONFIG_SECURITY_SMACK
 	DIR("smack",			0555,
 	    proc_smack_attr_dir_inode_ops, proc_smack_attr_dir_ops),
diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index fe9203f15993..c2f5adef0ad7 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -1660,4 +1660,21 @@ static inline void security_delete_hooks(struct security_hook_list *hooks,
 
 extern int lsm_inode_alloc(struct inode *inode);
 
+/**
+ * lsm_task_display - the "display" LSM for this task
+ * @task: The task to report on
+ *
+ * Returns the task's display LSM slot.
+ */
+static inline int lsm_task_display(struct task_struct *task)
+{
+#ifdef CONFIG_SECURITY
+	int *display = task->security;
+
+	if (display)
+		return *display;
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
index 432915c1d427..31a6f11890f1 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -612,6 +612,25 @@ static int apparmor_getprocattr(struct task_struct *task, char *name,
 	return error;
 }
 
+
+static int profile_display_lsm(struct aa_profile *profile,
+			       struct common_audit_data *sa)
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
 
+	/* LSM infrastructure does actual setting of display if allowed */
+	if (!strcmp(name, "display")) {
+		struct aa_profile *profile;
+		struct aa_label *label;
+
+		aad(&sa)->info = "set display lsm";
+		label = begin_current_label_crit_section();
+		error = fn_for_each_confined(label, profile,
+					     profile_display_lsm(profile, &sa));
+		end_current_label_crit_section(label);
+		return error;
+	}
+
 	/* AppArmor requires that the buffer must be null terminated atm */
 	if (args[size - 1] != '\0') {
 		/* null terminate */
diff --git a/security/security.c b/security/security.c
index 78aeb2ae7010..f9d9f68d40cf 100644
--- a/security/security.c
+++ b/security/security.c
@@ -76,7 +76,16 @@ static struct kmem_cache *lsm_file_cache;
 static struct kmem_cache *lsm_inode_cache;
 
 char *lsm_names;
-static struct lsm_blob_sizes blob_sizes __lsm_ro_after_init;
+
+/*
+ * The task blob includes the "display" slot used for
+ * chosing which module presents contexts.
+ * Using a long to avoid potential alignment issues with
+ * module assigned task blobs.
+ */
+static struct lsm_blob_sizes blob_sizes __lsm_ro_after_init = {
+	.lbs_task = sizeof(long),
+};
 
 /* Boot-time LSM user choice */
 static __initdata const char *chosen_lsm_order;
@@ -471,8 +480,10 @@ static int lsm_append(const char *new, char **result)
 
 /*
  * Current index to use while initializing the lsmblob secid list.
+ * Pointers to the LSM id structures for local use.
  */
 static int lsm_slot __lsm_ro_after_init;
+static struct lsm_id *lsm_slotlist[LSMBLOB_ENTRIES];
 
 /**
  * security_add_hooks - Add a modules hooks to the hook lists.
@@ -492,6 +503,7 @@ void __init security_add_hooks(struct security_hook_list *hooks, int count,
 	if (lsmid->slot == LSMBLOB_NEEDED) {
 		if (lsm_slot >= LSMBLOB_ENTRIES)
 			panic("%s Too many LSMs registered.\n", __func__);
+		lsm_slotlist[lsm_slot] = lsmid;
 		lsmid->slot = lsm_slot++;
 		init_debug("%s assigned lsmblob slot %d\n", lsmid->lsm,
 			   lsmid->slot);
@@ -621,6 +633,8 @@ int lsm_inode_alloc(struct inode *inode)
  */
 static int lsm_task_alloc(struct task_struct *task)
 {
+	int *display;
+
 	if (blob_sizes.lbs_task == 0) {
 		task->security = NULL;
 		return 0;
@@ -629,6 +643,15 @@ static int lsm_task_alloc(struct task_struct *task)
 	task->security = kzalloc(blob_sizes.lbs_task, GFP_KERNEL);
 	if (task->security == NULL)
 		return -ENOMEM;
+
+	/*
+	 * The start of the task blob contains the "display" LSM slot number.
+	 * Start with it set to the invalid slot number, indicating that the
+	 * default first registered LSM be displayed.
+	 */
+	display = task->security;
+	*display = LSMBLOB_INVALID;
+
 	return 0;
 }
 
@@ -1629,14 +1652,26 @@ int security_file_open(struct file *file)
 
 int security_task_alloc(struct task_struct *task, unsigned long clone_flags)
 {
+	int *odisplay = current->security;
+	int *ndisplay;
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
+	if (odisplay) {
+		ndisplay = task->security;
+		if (ndisplay)
+			*ndisplay = *odisplay;
+	}
+
+	return 0;
 }
 
 void security_task_free(struct task_struct *task)
@@ -2054,23 +2089,110 @@ int security_getprocattr(struct task_struct *p, const char *lsm, char *name,
 				char **value)
 {
 	struct security_hook_list *hp;
+	int display = lsm_task_display(current);
+	int slot = 0;
+
+	if (!strcmp(name, "display")) {
+		/*
+		 * lsm_slot will be 0 if there are no displaying modules.
+		 */
+		if (lsm_slot == 0)
+			return -EINVAL;
+
+		/*
+		 * Only allow getting the current process' display.
+		 * There are too few reasons to get another process'
+		 * display and too many LSM policy issues.
+		 */
+		if (current != p)
+			return -EINVAL;
+
+		display = lsm_task_display(p);
+		if (display != LSMBLOB_INVALID)
+			slot = display;
+		*value = kstrdup(lsm_slotlist[slot]->lsm, GFP_KERNEL);
+		if (*value)
+			return strlen(*value);
+		return -ENOMEM;
+	}
 
 	hlist_for_each_entry(hp, &security_hook_heads.getprocattr, list) {
 		if (lsm != NULL && strcmp(lsm, hp->lsmid->lsm))
 			continue;
+		if (lsm == NULL && display != LSMBLOB_INVALID &&
+		    display != hp->lsmid->slot)
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
+	int *display = current->security;
+	int rc = -EINVAL;
+	int slot = 0;
+
+	if (!strcmp(name, "display")) {
+		/*
+		 * Change the "display" value only if all the security
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
+				*display = lsm_slotlist[slot]->slot;
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
+		if (lsm == NULL && *display != LSMBLOB_INVALID &&
+		    *display != hp->lsmid->slot)
+			continue;
 		return hp->hook.setprocattr(name, value, size);
 	}
 	return LSM_RET_DEFAULT(setprocattr);
@@ -2090,15 +2212,15 @@ EXPORT_SYMBOL(security_ismaclabel);
 int security_secid_to_secctx(struct lsmblob *blob, char **secdata, u32 *seclen)
 {
 	struct security_hook_list *hp;
-	int rc;
+	int display = lsm_task_display(current);
 
 	hlist_for_each_entry(hp, &security_hook_heads.secid_to_secctx, list) {
 		if (WARN_ON(hp->lsmid->slot < 0 || hp->lsmid->slot >= lsm_slot))
 			continue;
-		rc = hp->hook.secid_to_secctx(blob->secid[hp->lsmid->slot],
-					      secdata, seclen);
-		if (rc != LSM_RET_DEFAULT(secid_to_secctx))
-			return rc;
+		if (display == LSMBLOB_INVALID || display == hp->lsmid->slot)
+			return hp->hook.secid_to_secctx(
+					blob->secid[hp->lsmid->slot],
+					secdata, seclen);
 	}
 
 	return LSM_RET_DEFAULT(secid_to_secctx);
@@ -2109,16 +2231,15 @@ int security_secctx_to_secid(const char *secdata, u32 seclen,
 			     struct lsmblob *blob)
 {
 	struct security_hook_list *hp;
-	int rc;
+	int display = lsm_task_display(current);
 
 	lsmblob_init(blob, 0);
 	hlist_for_each_entry(hp, &security_hook_heads.secctx_to_secid, list) {
 		if (WARN_ON(hp->lsmid->slot < 0 || hp->lsmid->slot >= lsm_slot))
 			continue;
-		rc = hp->hook.secctx_to_secid(secdata, seclen,
-					      &blob->secid[hp->lsmid->slot]);
-		if (rc != 0)
-			return rc;
+		if (display == LSMBLOB_INVALID || display == hp->lsmid->slot)
+			return hp->hook.secctx_to_secid(secdata, seclen,
+						&blob->secid[hp->lsmid->slot]);
 	}
 	return 0;
 }
@@ -2126,7 +2247,14 @@ EXPORT_SYMBOL(security_secctx_to_secid);
 
 void security_release_secctx(char *secdata, u32 seclen)
 {
-	call_void_hook(release_secctx, secdata, seclen);
+	struct security_hook_list *hp;
+	int display = lsm_task_display(current);
+
+	hlist_for_each_entry(hp, &security_hook_heads.release_secctx, list)
+		if (display == LSMBLOB_INVALID || display == hp->lsmid->slot) {
+			hp->hook.release_secctx(secdata, seclen);
+			return;
+		}
 }
 EXPORT_SYMBOL(security_release_secctx);
 
@@ -2267,8 +2395,15 @@ EXPORT_SYMBOL(security_sock_rcv_skb);
 int security_socket_getpeersec_stream(struct socket *sock, char __user *optval,
 				      int __user *optlen, unsigned len)
 {
-	return call_int_hook(socket_getpeersec_stream, -ENOPROTOOPT, sock,
-				optval, optlen, len);
+	int display = lsm_task_display(current);
+	struct security_hook_list *hp;
+
+	hlist_for_each_entry(hp, &security_hook_heads.socket_getpeersec_stream,
+			     list)
+		if (display == LSMBLOB_INVALID || display == hp->lsmid->slot)
+			return hp->hook.socket_getpeersec_stream(sock, optval,
+								 optlen, len);
+	return -ENOPROTOOPT;
 }
 
 int security_socket_getpeersec_dgram(struct socket *sock, struct sk_buff *skb,
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 52a50d7ca534..9bfc1eea02de 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -6334,6 +6334,17 @@ static int selinux_setprocattr(const char *name, void *value, size_t size)
 	/*
 	 * Basic control over ability to set these attributes at all.
 	 */
+
+	/*
+	 * For setting display, we only perform a permission check;
+	 * the actual update to the display value is handled by the
+	 * LSM framework.
+	 */
+	if (!strcmp(name, "display"))
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
index f96be93d1a75..bd03020b3cad 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -3509,6 +3509,13 @@ static int smack_setprocattr(const char *name, void *value, size_t size)
 	struct smack_known_list_elem *sklep;
 	int rc;
 
+	/*
+	 * Allow the /proc/.../attr/current and SO_PEERSEC "display"
+	 * to be reset at will.
+	 */
+	if (strcmp(name, "display") == 0)
+		return 0;
+
 	if (!smack_privileged(CAP_MAC_ADMIN) && list_empty(&tsp->smk_relabel))
 		return -EPERM;
 
-- 
2.24.1


Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 905B02A7449
	for <lists+linux-api@lfdr.de>; Thu,  5 Nov 2020 02:03:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730945AbgKEBDb (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 4 Nov 2020 20:03:31 -0500
Received: from sonic313-16.consmr.mail.ne1.yahoo.com ([66.163.185.39]:35416
        "EHLO sonic313-16.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729971AbgKEBD3 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 4 Nov 2020 20:03:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1604538206; bh=N6iORuVgdJrnPiBRwx/E1Rjlds9E5M3v9taI9rMKSHk=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=Czmz6+QBKhKB+nZK1Nr5M8cuj1PR0iryqEXp1vHjzhlQWNB2IC6js5FlyHpIQ88n+3hFa+oxZrkl/n/WlS4BSc4Wch8xvZjtuvdSHDC0aTxAbekTzKFUzzr8VXoEWxoI/UhR6eLrejN9DKOG4DYYPcu6dO5agwou9aDSEzmIUwygY3z9igu9bh+X6Iil3f2hSq+itf9ZLm3I43xTHYH++5M3mOcvOT5m/hVteGFvrCoc9roMZPENpOGqt/YHjgIKrTt60bp2v+TxUlxux4woHa7jaNNQndeRcPRoF35gWOKcOz6tYiVjutYc4yNd3IRbUxeoGiq4SR6IrDuJrEyJ8Q==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1604538206; bh=FDJqlRO8SPgH/k8we5IgV0nYzqfzxAXd4Lzr4CDMzHl=; h=From:To:Subject:Date; b=ResnmcdFKjUayWavdNAhi3YlqeyYr/e+/V+X1C5NyCFZfek6lw2eMAcR8JnGf30fBE0OBKNdYiTwX9PBSLAzqt8ZrAFVQ6YWV8Lychg0UV8/zPSP+ls3QiI18DomQR3rCQ6GY07hMc306Ie+SJKOeQeGeMggYRpAOzBsCWgUqAiP+tc1WU1t+/Q4k15DarFBhaFLyl1CgvQqBIEX/G2oMXZcW+RoClGeKfbGO9aYOPM6WpV4S2huJlv1EHhpMl44yQAG4msql+rFKXm+sPRADMiha3QQ3QbVOS3mvgHXLBPCBD1INA7xFNqm1EvhyX//QyDIk6gh5CaXqJCg4lOO5Q==
X-YMail-OSG: eiwh_YkVM1lkgCfqEa1hk0iNAU5uIGR7zOl.Bx8_LlLrNhyW_hM9LCYMFYveelM
 LOko7CBlrFO5etynhBxRze3xsTNpe1Gk8JDSQgfKDA74j.b0xnWKDE.lkG2_y8xpsdliYK4cqYe5
 PzHBDgshlSB5jQC_icaPNv8XNzNNKz7TFI4WCwSu8byTb.cVOXacOQRTZOrGFqLJLAVMHeXsabyO
 4C.pX7s8ks2.1nhMONIgRur6gMvFVZwv_8_S5MQBpus.MeSXA0eHj_GjTY39VWun9ccN0_2i9uBD
 w2xgBB0A_geBsFiHw5EnDj3p3W3TcH0TCkl0g17S1OXzY28Q98gc.ksI2W4m3uAkHt64LhaDSaJ0
 KVfvsxho8N7WO.7iACOWkVl3mpET0kO7D899gST6E0EyawgSV_1NnPm1J45R9rO_djKnX4bnlNRl
 SeWoBIKv2EM8ZADfRw3galxvRy5qhk0qdf0HcTxEwyoknBC4mS3hOn6EHNu5BZFoHhpWcaYWGCOi
 Zc8sFNFCPOAOMym971G2PRaXTItnks.eyf3L8TH.UmgnnhSOBCcJAR3ORfunM4fGcPLVRuayrazY
 saZacRIVD3DIuwOOMgKknjIlaY7OOBaDLcZ7rbPPEXRW9MOt7nookvsDO2QOr.HdKqncFs_8E6kq
 Ouna1h7clB1Ezy9yJ2IU3fp6GbUgQfNINnU7xasJPT7vPsiGbkCzLvSbPliIubuOetJ2Vcnep74L
 35k0kV6113QKaH1gZFF2q5QXxlqBR9hioiBKsbgLHDsasKkFXUc7_doe_XYKElDsiKHQ9OakHjOR
 lDYfMGN7Qr6OVDOQ3gIZVf7vQwE8Qahfi2yWpBzKgYn4kcEo8jA92vqtiQleQdYKSta3Ey_YmhHu
 YrO86ruydWua5ceUiQlrRgZMAqnRuORL3ULJt2hQD.7xuYN5iLlBnJU57.jNZW578XMkAYqDPvTA
 X.hVZWjbQzSRnhfZltfA0alTEQjxhrPOmO0KIqbZi9ZRh1RPCKXYfrYv8q.og84he4GSmwR2GiYg
 OLwk0HddG4I4YQAiWJIz8iRj9rcdAv461DAdfnr_pLTL06NkHMpYGs41_X.KVhZVvlR2qPDfVqe.
 CgGXvzDlJi1w6kZmUt6orZEoSW6ym16syLcta1ddRJ68p33MdUK9kBS6VY1HNtWCTlSuhhEbBPRA
 ldzScy8wFDXmUggCGPXyUplfTUX9IXa91SvCQ_do.JJcCemm2kd_lDyxp32NPDRAHrl3AxzQmS0e
 LeWe_KwDI3MvtaO3tM0zUyKnBu7hwArM50s3fcmTVYRcUOQbAUcu_u4QD3oKwbfVfuwomd78Wlfu
 XzWsqU_fr4Uz7RFoDbLxigE5F0iQKRO4VzPQPJ8hxiesIj1BrNTqE2yjx1sCkXJML17z2YTWWv_D
 kt9mxkSk3VguYszxyhNN96lYUIAAZyp7Mk3UyqAtBTIYVjUOvlMZF0d_OEqpbsRNZlq7w53eraj7
 WcPfT9fXPOvkj0gLUkRPH_DZvVEBkCvEMd4wPyKqQZcZ5gGvzuzG.c2uFbIdZJYFX5EmGs0.5AW1
 t4i_uLwFpcw0UtQReQOH_jvJ5waK.4E1Wq7PB4tKoKxZzeMvkaoF9MIhXF24xvIjRfmontoF2_Jt
 7_qQRvAAaCafYl5BhH.NzPd9rSTqDhtGf9xacs1gevvrGJAJy_69nE.HHQTN09EFMLY7SH2hrWJl
 HH7pFKx1sco9wFE9vYUVGaIsJFFzVSWCgp2DNgcbTw6Qi030rTweYY5zyLicYsWw5VUHUbXjvyxL
 uwiROjacPFCr5QOu_I3xImQUWeGPZIYzcWYIYrDpc7r2trc_Vf0.a12VqMhgaLKog0N5gmHa8yje
 D6VstP01elj8HCbtE3Q77rZHrHpy_w.bI5sPrc3_B6yH7CtHdAB5DJcN9MGqmsZ5kufEA3kc3Q.e
 kV.ZqPdGnfIL8VTfkX33BTEk0PUvlM3iQziCjIrdhHTP_ApPpNG8YTeV6ugAUdFhA_qQaczH5wJ2
 jHAIzLF55Ozxkm6iJ0a5fgDoxpSpjNrqYvzWQf4W2a8qpvKZmhj_OhEiOmZQeZXa2WBvMVK.SGol
 fUDJxJLzZLNj4KhtOND0metvp6M4YZ2gejz3tHIL_mrbzDi1KC6Sn.xP8wSJs4N6PaeeN2rh9Twj
 iyuWfWPbKew_ZwS48X9xxj5FVqv8g5y8QvgjQ9HW8xuv0BcEPvs32n4fj3k2k3bQiNVWz5T2IsMF
 Zwlqzz4hSBB4xM0qoPgNZ8MvjwX8sV9QRtYjImkKDDMpI7fhr6lYclDkv_UJyNezycNMlAEuf2wx
 tDkq.2mQU0mAICFNqxpewe6eSuZRPvsMwJu.e4vvUxF39l15Ym6j8W4rRMSStBLX3YBq9QDNlrAR
 Z9oF5C1gcOrNXZ4t8hh4RB80BufGnhsfbuVcUandaXlmuhI90TjQ_WcqvFyAjOJtyetwhq71ooC_
 m5Xw4PILuHTX.JiJJYhN0n3IE602MuwU8vXYsYZYgw8K0D1jnjPtx4Wbj_g8DwwQczMlsResf3Oy
 rMZuYJUn3PYc_D9EoAKZhkiC39s24ovi4Rt8aldgMP7UaZ8iJiN8.b9vUkz22PysxPo1u_OOya0r
 vsitHuyzprhEnsCVDkhgYtdx0o.pwI4wP3gcuXboDvtcgCkuOF0Ab2CztDOgALGEvkjw0aYXDMxI
 JweoNqEBSoCzMNa93pUbgKZHxZHehWn6JprrQ_usuoZPvDtnLcQXpriG1DusZsHmcz6SbD5KqmHR
 zqZDoX26lk8mS8RHfq5vwKSh2onyjTZk.Xl5DpTnliq88hf7l38S_c0_zxVzBqJFLtcTK_Ohubkm
 gFb9PkFCFDohxP0q7vBmyAJSAVsgepoTyeI8a8ow_5dsGgUq25RBNHvC3ZPoAwulxQZSyKxHZCx8
 UVoIopoNhs5UxOEzhR.ntaip4JSyl9.ZW41x9BbSUtG0T58Kk8SoZb4FeZc89UxG_sYDfK9K375r
 zX7AceFzlUwFEITcTtNaUQQkkd3DLGsi9NB7krO8QoxofO6fKpNMTHTzeYjWtrcdA36m3dpBSlDy
 9KsY8vKRC1HMxeniHvq85UBTLi95_txc.9I8g8seaw44pwpx0jxsidB5mgf8w0jEoKaJRWsJ2org
 IiM5lq5qZTzwJ9YmDfmOXuMyAyzU0ZGveMPcVx_vR0IDqpekiwpXm1PX._ShofObq4.Qg5cAGKmQ
 t01Y2TzUMHFYsEukh2Jlvus4qiYrW19YJfPnrWPW95Vr6B0LUb9m1l2rExlzAwEZa7l3fS2WFu9_
 QMjhJfSOKwJc6n7pEa4qv3dLEa7Ot4PIEmMiBbQJeIbcTzIweE2UxFzAUjwFd4mUbMLEwIS38ORH
 ekh_8D6CLTFgERpDMlP942ecqxS5Mc0W.x4u_lDAHwDmkXGGrnnK2MRgiQHpODJ21fysEE096pBm
 XrF7DBL0-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.ne1.yahoo.com with HTTP; Thu, 5 Nov 2020 01:03:26 +0000
Received: by smtp408.mail.ne1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID d87a3b67bf49fe80de4e9c0841692f07;
          Thu, 05 Nov 2020 01:03:25 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org
Subject: [PATCH v22 12/23] LSM: Specify which LSM to display
Date:   Wed,  4 Nov 2020 16:49:13 -0800
Message-Id: <20201105004924.11651-13-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20201105004924.11651-1-casey@schaufler-ca.com>
References: <20201105004924.11651-1-casey@schaufler-ca.com>
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


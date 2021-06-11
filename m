Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40BB03A3886
	for <lists+linux-api@lfdr.de>; Fri, 11 Jun 2021 02:20:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230508AbhFKAWN (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 10 Jun 2021 20:22:13 -0400
Received: from sonic311-31.consmr.mail.ne1.yahoo.com ([66.163.188.212]:40469
        "EHLO sonic311-31.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230417AbhFKAWN (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 10 Jun 2021 20:22:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1623370816; bh=TTickymPzNZARqMdzU3cApCmBUWmU1mgn/SxUddGPQQ=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=sGHfN10Z1+VcAhMgfeM2p/Ft3K8oSTgFFlJzmWUH6Ck5SgwHnoT5+D35jhffDw37RQQY8hENj8DdUussNBj4in/E874uH2pl7YuEIbwZEM8gHTbj2dOeUmQ0ZuZja1QFqf/3Z3w12uRk5FyoNG9AJc9UCqu9sys6mvvHjV57RFlb/Vtf48qMcvBgb3TGZoLI4viuu/nSAvtQzxLMaTywd+MFyCp+6T0vpWd8dT3AXgRbCHFFwY2N9Juyq919NWU/JkK59vAH/PUv6ENGULFeQ/zQS9H7uSw8xMbqKG9itQ/faGhbX7WB5/MW5DWfrifrJJlHo1z4YaOK+IntwUWdng==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1623370816; bh=Y+rqYzyw+8KQa5+4caIu9EC9p759Mv97rsFhUbxSDxU=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=DwTcgmgE3Q4wP4JUsLhaQhECA95fAYgNZ1oaRntO3UER/yG5/vLQoxLze7k9BItUmHb+Nr5RCxJCGjMljREW/6WfmpiQXTygwGg6F1CSGmraaAg/YVek/3wgwNc3JTgo2RCfJ73w6K87Jj1HTVkei7M+xz86iD9dv0evfDb0kT7auDfXdH5bhhuSt5aO+O70bguVFS/5gTWltxiO6Mdmyruq8yjywg+2KTIWJ+Riy5JxRBr7y2xjUDP9ITPS1AP/uNCEaX+T4vBzxRBGblcQBhnqZsliDjOt0hnoUBLe6n8U5tBNT5er+bwvYBLnjQcwRYdP8P16GZNuXpnn701/uw==
X-YMail-OSG: jficeogVM1nAVXnni_ZWD40rnTdGGIn9x.Cbu1tghmFqtBkgwH46H0N3vyv1nuD
 h1VAg6ioiT_Ld_SumTC5BdaTFdDpBSZuLn9AE4fBVgiTZaTivkgsECRehroLTVD4zH8cVMUKP680
 HIKP06AAYdQl9LbgcEHui0o.HR50RXr0YC7VIlMvc84F34MTBYHlQg698mseceUzLg7h1AS2Xoe8
 gYMENkt6POgbthUVZ94BJjf5sDyqEJcNM9dOSFlU8jgf0mu4n5Lst07HD3Tp9yZ1a6OnfkafdBkR
 8gmp840wIyV_8XEneKJj1oqye4sMvAzO0mZe2BD17CN7y0h51MWNia.zflkwPcSBD9rs8eQuIM6T
 IFxZ.M_oJry1G5zHxfCXUfgtx79OJJU4OjkdoQk3o7xnrqh87LAdE1WwP5UvKWW88QyjK3ZOqeOe
 bWAGMcI_DU4wq5NwhsMxjgA2FOhgYDssoYMiL9ZS5B2GAtB18gUSba6pfbHJbfpowAyjlMho.ncG
 2KiPg0LDqYwsXJyXipti97ToW1MaILDpZ0js6_MZsV8I9xhxVYDU2kSuBNMGkfM_uhUjXooS5wzD
 DoFoWnStF1kOUljQdC3bCAikAb15Klme2loTHvdf36Q5Zd092VPbvRNnZ7XdStAinlIMhDrD5sUD
 UU.DK4fWTr8BJYA66vFA_pTPIA56nf6_VRfA1n8xI5oc56LGIXtf1to9eVbNVbl2.yQdQe92Un8O
 CljL214jF0iNIpfT7UuJ4jTXV4SfbQb6.HTwQY0v93kP3ysj6O5uprgPcyhzrRWSLbgEUFF6XUjn
 sMo0euj8tSra3jeWC0n05lwdF8P4HznvdslBGuYKoeyBhTiUKTbUZF_uR0PRzm1A8ZgxF92jPW_G
 RBpxtqdYmVTjLMhkYjGtqyhFgNTef7pTB3HNgtN9Jyu56rWsI7yUlUbrUYXxy8vHjvMs9k.7Y6uJ
 Zp._VbRhCPF0Hw3IKpoKC54tVUe.T8kgkwXImGk6GtqSLX2zy_FBwD6jiUU1uVXht.RKzNb2F6O0
 VhBKLlwvqbOx0ytTrhouqhcTdqMINHXvP.IgB_2DvGfeXxqqeT.xWQVgThrmDASWw90VJZwPDlkz
 Lj5eSMcOKvRbiObULUiDmYUroSDhsTQ71nLntJX9rl_McVDBDX7TSMatYgUzRFiOvl6sxieeqeUV
 l5mnBANFnLS56KoDNzx.Pr4wvnPLBik0NugOj2RQLaTba0dMIpFKoXbgrMF._4hST9D0ms28qzqr
 T5VN4MlXuKr2eAb0tl7St1QJh5uAp1ABefpfCX4zzlaY1kgXA_02OSQ_WA4CLAsIU3zHkVsb.QFl
 YpY8veLDsnAmKiIO1eEx9P1nL10yTszPIW192Dsz3.u.XnA2oAm_1Fb37pFFFEAa3FOfB3xF0r0X
 TU83BxlMLjL2RYT4ZHHBPKC4sx384devLLvyaGTEsAV3F8u08xaKkOV3XEXJYoEIDeIOGSBlmABy
 SsadDyrg11SIhpYeYgnb_6Int.z643cmNHBmGYQL6I75cc14ieyeBPNApEePxHERXdTJHonrz.1g
 MfiHUJOTxJWc8_Q78j8CHpf_Dr4UbC0Q6PEvf6xXPOhJ_1cnX4TUzfxFlbQtcP.l0MFCCMbNLzIp
 cYnBSkKDZzIZY74oguLptUHTFVkNSrkZpQ4t2a.hsGbczVa8trjH3X1zFKquQhxirT71nULxrbM8
 kZWNitujtwo.N7mjs.EjL9FI1tarknJYKRc0_c7pbdAQ2fzYVeju7k3PqVbLZJUd7UHH1rxms2xb
 4Tiub_3FVz8vd.c1rDYS.PzuUJqSY2GY.VFxmZRp7iALF27U5JtJ8dFQ8LRQazz4emXvGqYGdfrR
 qIERLo6uJhQ5f_4FfMtsVc5hR8bl6lfXXymK2IwknDWOYRmlOsEnpX0tlTRWVMIG3IXdvyEFkrKm
 jQkAc8mWhOcSUqU5JgpeeCw9wBrm6w.V54GAccLwUoJJfAPRJhkmKlFZMZiuL2fNH5_feAs1IQmr
 b7Y1xO5ZdPqGhGnRdCsvnqHmIRKQXPGIKFQbCYJlAFj35MDJzdYN0f9t4VIjd92qfegJtZmqSKhi
 6Sul_UNbKHKo.ILr0CRRLVo1pK8mt6ZDgYlmzXoieFQYcXn4E7GL0ZlJGqBfn1.RO6TNJe71Efgf
 I4v4olcpl8W.U0H3ADILDTKp5nnJ0fc0npBIR3bY.Uco36zMvi6i9QNLXZ7.6dV3itGcpY_8wvle
 DsYSQbXfzm8aBJJLFjt.s1aOjNy4tlaBdnRG26_U0YJttMhzepf0AJytgsFZCPHpOGApmp01K9NJ
 awQMzKp8pTy651J7m2cMMRMDEddixND6DX.5tsccwpu7xdUcWcgZZIzZd6DZCry9tT7OqLf5O9PR
 neBY8YiKymryUADTgy840Tb.kGQduqP1ysDbyaoLvLK2D.hMLNJT8learjG_bUdnihL.N9npBUUQ
 zl9qGA4Ick.nMbvGOOoVgxq_1y1NCp9abNCcq4GarHGc_AcH0Er3mJb2QNRK3n_Td3rYuRom5Kjq
 uEtYDTH61jIxK_Kj84J0RrbC52rRE7w_27iq6HCbldzcjf8beW9hghBEx2Xf_wZABVM551kc6K5F
 QlzqCAZF.yJOrU0kPU26D373w4DpEFoiZdR.aK6NZqnZ1wmXjEO2AOdYdtHIrelWL45BK4m2TC9N
 jhP.oAFk6A0ipXCFucA2RSjgo_3OR52o3PQyjLiGxWlTldv_yHaThNCsir6IcQE6xNSNF6mrPfkf
 2pLCH6qAy8j3TdTWL9SEdZ2qu8t3oAwwLRYtk1My9AeXxtmxski8NX9zXtZP7oibPL_n6ELsGvZn
 1k8tTcyGq9vUYwCbMVmGD4oY5jJ8wmNfS37bmW.fr2Z8MiN6mxZ2iJCEC8SUXCX3JSMh8tYPLl4f
 GyGVn7uokIgec3lpDYoOzb3_qTTgfvx8hfnic9MaEOLjZn2lIu6AMxFuXAwL5cw9HwdCNPfqezUk
 j.KhfYgJa8Fhsk17fBwbvz4E20sTnRg2_p69CGRtXstSAmQhrF.qsw0ndaqfNL1DKuTPUgzmFEa9
 LoQ0lb68o44ERg.MwbnfHoIA3pdVQ1WRR9CI4skgLC0FYut0W7icdpF9jaz9Oaa_A7twnCwyxx3L
 bFoF3VIMAIXlWHPJVomHxFYpKNocW_8nduhg9JAx6eekiNVjKi11dogFmfEbs1659Upwklq.icGH
 2rqMSPiZu0dmSYeCCMI229LdIO2mhQHh0lOF_OZhTtEtduA.HDA5QclaYqiUyaWiegOd_s4Az8YS
 sESs1l.KALruecR0.xbhGaIglHa69mnVDzgY7Pj52kE83.C0k.d60afQjBoGihx6n1JgHv5WUaYC
 9s6f7YI5fTvKU36B_D9.XSTJCEXvo8ffVRAdX9cHDLtBJHIR96CFiTFRF49vDkeSUAOpCJel15uF
 VuufI3PDjfxdneu5tJw--
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Fri, 11 Jun 2021 00:20:16 +0000
Received: by kubenode580.mail-prod1.omega.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID d5aadcf459a8ed5c45c8831c6afdd242;
          Fri, 11 Jun 2021 00:20:14 +0000 (UTC)
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
Subject: [PATCH v27 14/25] LSM: Specify which LSM to display
Date:   Thu, 10 Jun 2021 17:04:24 -0700
Message-Id: <20210611000435.36398-15-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210611000435.36398-1-casey@schaufler-ca.com>
References: <20210611000435.36398-1-casey@schaufler-ca.com>
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
index c2a5c50e913b..fe18c8d8bc22 100644
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
index 0133b142e938..dba867721336 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -6510,6 +6510,17 @@ static int selinux_setprocattr(const char *name, void *value, size_t size)
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
2.29.2


Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD24F742E0C
	for <lists+linux-api@lfdr.de>; Thu, 29 Jun 2023 22:01:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231949AbjF2T5b (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 29 Jun 2023 15:57:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232267AbjF2T50 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 29 Jun 2023 15:57:26 -0400
Received: from sonic314-27.consmr.mail.ne1.yahoo.com (sonic314-27.consmr.mail.ne1.yahoo.com [66.163.189.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B3FC2D7F
        for <linux-api@vger.kernel.org>; Thu, 29 Jun 2023 12:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1688068641; bh=MZMUg+XbbnzRTetKDpG7DwFCfO6NfPMYSVkBQ9EQDmU=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=QggH3JNLExMXi16QHmLJ5uh/WEFjN4EZhW7sB9daHOhPr4r606HtTrTDIx7qZG5qPeWDqat8VrC3WnjrLicQFSbY91lYWOwGcE6DmfG9szApduoCdj3gYgONHVVT8G4XRLJWMpcRwUOIedcobns3vmQELE/8LoAwlcQpN6Sng+D2Rob2z7B7DrwI+i67T9Cp6UT/Aj8UT8Sva9MTDmKFCgr9AVfCcbnSQuQuWttnK2BMnAzNOB2dV1wCjncnaM9rZ9L0TOOFMmlBGfpu/KTM2VvegHY1YrHe+JVM4PTx9PUW4UMtBUG+M6HtrEreJ07mCk/hcAGTpl9tz4v4QgE+Fg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1688068641; bh=yC3Sj7kAc+IpcMTxMfiBpb4Q9qlaVqtK2Inqtt1nJxa=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=Vup1IELBLdUlVZaRBJI8S8C5j0fCp5Zw8q8mh4DXuYqI5eYDj7QVUiT0hvOqLTS90HRAEaulMe+xnZ/ci5XNrBOUzDagrVxEdRyggJtfmD15IJIrw5XKnEbmGzFLumFVSNQDItQ2FbtacS+LjxMfvIikMhjpMIB1yd59bqJG+PF8jJd9qxUucgzEtDhlT/vAoe5oJxrU8gnFj5KpWRZT1Fsik9vUQHQRs7q/bJ3DKnJUX/kGvyMwKJmQCGrCE2g/s4Pp/n1CA2weTYonkzCQpDmPcIybPhovf/m3/yXdd2BqtbRyUe9kICNX78tlxyQiMNcEG3Tn8m7Je7Z66GFGbg==
X-YMail-OSG: QsvdtiIVM1msB77Pm3C6VkDtof0ExtZlwk9OgQoBr5Qon7blUeQwLqRIYDHHhc8
 QBsUoiKDBH2oa0b93lr2Tiqp4qgj6yK6mNsoz5B6hocdO7I8wbzKlQaxIeJKzMvLJD519742wSfO
 EGoAy_6I.GUUKxB14HZAcvfifsfv9Re4c2Rq3aO3msm7Skv7CDfxC68F3MaXLzIGH0eT5Df_OFC9
 SBgo6aRBlBN7hfa47CJIMnUFDU3EHuNkWu..5Nigr02GRxjOpYv41FUnHGSKDSAaeU075ES4PiuX
 h4AULdUOzui65oVFETolDbwiX1XDusDzylPR56t_zclgk4nzdq1RXdDzFdJewPLaoZAGGVTr9BMu
 cGGbK_TE.q7nB3UyVd4JJAJLQDFKI3azMecWNrdwWH8FIbcAe2bgSAMoXWdKO6UeFcuGdwqHIaZ.
 BBd2t2OwPeAXzlPFQOpD41NT0fh_TDo8QAfVIjewcvKA9_azWvds1wFGwC9eLdqS4o73l2oKLViY
 f2UqGz7sqju3mFJvTL75l2za416usGptgLo5muprzZEwJ4Gu.Wc2W.38vmonGNAnZr2DYroHQ9nm
 83WcRtK.TVuNXhJFhLssobt5pOlfdClObDKwXICZGjlqspdZnqIoME1NKxBldSGscNssyryfvY.6
 T1.iarD7qfM2dWeD7lEFqCSCW7Y8Eoz93053zoqlg.NJqud_3zk0FnKFuW12I3oeXZL5QXzU9F4E
 n0P2JPHeuGobVcVahAVcA1AfBlRp09BfBE7H58osvrtJpFnb4EnxjVCjaBg8mANT8AnEQsOlIlBA
 AvpWUNOfEsTWLuMo4IaHcnHLX.Z11V1wUOslXJTSJ8P7pzFlMHbLlQ0NE_8j6WrmRb4DpgpN1J_E
 nyAeVpALGzOeTMmCw3HYCHU3eSZntjoGjYISSZ0eMgJGJzST91oDd2lLlPxQdi5xr1FYO7Ard9x3
 wJh1cVTqb_P5oklfyz4HNsKJhWxLJ4BansprpLzCnp_JRikZazo3EW91jwblSpjycYGtOEWQWRHq
 wCWY3q9Kva1rhcnvUBmPScOPkfCts_.Uu6KfR8K3Ldko8C4S0fVS5AL_sdrqvVeUiMRpADin1jm0
 2BTZvjSOBwQChN4_hl5o_L2t4HFfPKZEBoU9j09C793yROXYKRk65se.urKdkA8S8gwPYSYPuPQl
 __EXTXh5O2kvuy8aKGDSBvCjXqUMh845XlH3zh01_iaubpPL7d9vzU9WYJJ9gx5uQDKxZ2xuSGEE
 G5KLDJlSuTAVCly_QquiWOriJPEA6EaiBKrzBJKCEOuKGPPTZ9bkfaqcEMT0h5Pb5uH.3d0y1ivp
 SabOlTp90Pvp1Nm1ZqGCT7nV91Nw3EYcZAn59_D4sHZwE0_.FiqlSQmq6RhFegBPGv_RemSMT48T
 Kpw7nKLgdrufdTFjOqQI4F2rx9MlSf7802T3Bi9TC2vrpSTwA8nuxb.bvArg0z3SyHC_OT.ztZrD
 UcC2BY9Za6ulQ6tCfRi5TGpmU.Sn7L5O5tiObW_Itp2JEy9aJpaVyKWGswD9ILPWUNM8KtVm7OTo
 awu0owxcOq3nE4TC5UrkxYcZKS.tpJmUhy5yi_25ttLoiE1iU_tDX0IZ1X7.iCXUcocal384190V
 0ZVu.R3QPbhXwjVol5lVuA6Ll7U1x7rNvr.6.JcETGalANrN3B8.uvlWhJ.qVbOzLMGG.KhLpNgA
 B6tHmNlL9X_RhPTU48.C13KvBjgK5C3kVnlHKOkC83iWwXZuGjX7QLnpxybVsAliNrY0CYpcJki5
 bCThzQd_eBy42hgNM6C8H.FriwOG.xmqI1oZkg7CTfB7j_vqCUs9jcyu7.WBHktCIuxbO9rHeuEu
 FivFWNfmGwRuYUoit06Axmp7nzISE74Auz29vIIPZc8GGylJyaFWMSI4O.99DLlWmxzMHxXxUiD.
 PzHk4EeNLKp2XuScjKJ52_ulSb54_qpDoYLwUqt4f0Png1mfrU3Jzb8OImF0kt9m7rOa32ZP3rtK
 VkSklBbFG13In3pDRb0NI3H6Kc1s2AbodiQJot5KNJxjADmii8NMBtmk18Cy_lPe8sdDiDpCeaPs
 ZO3pAJ6jJNYn8KybMYnDvgocu45hP1BYp7CVSqA3KbaWCkP14CCgncsMJXvGJW7.kblnZd1EqHZD
 JNFGrWo2WAKgnH4.X4U6BrziDQK3bRJDXMFGO_x9JYfRzOf4bME207yKhcYWO83LZdiZFgT7hflY
 aFvYd_RodFlskB31Zl_2IUlHDImNgsw8CCzwHjKHZu1XVzvMwrXk9XX9Ni86zbrZLzdtq7FHfTmj
 8XWue.XdAhZe.nxTknQ--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 110d219f-2dd0-4fd0-b9c0-c42288fa2e59
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.ne1.yahoo.com with HTTP; Thu, 29 Jun 2023 19:57:21 +0000
Received: by hermes--production-ne1-6d679867d5-xspjz (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 2b963465d429516eabd169bf0e2fe051;
          Thu, 29 Jun 2023 19:57:16 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey@schaufler-ca.com, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     jmorris@namei.org, serge@hallyn.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net
Subject: [PATCH v12 04/11] LSM: syscalls for current process attributes
Date:   Thu, 29 Jun 2023 12:55:28 -0700
Message-Id: <20230629195535.2590-5-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230629195535.2590-1-casey@schaufler-ca.com>
References: <20230629195535.2590-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Create a system call lsm_get_self_attr() to provide the security
module maintained attributes of the current process.
Create a system call lsm_set_self_attr() to set a security
module maintained attribute of the current process.
Historically these attributes have been exposed to user space via
entries in procfs under /proc/self/attr.

The attribute value is provided in a lsm_ctx structure. The structure
identifies the size of the attribute, and the attribute value. The format
of the attribute value is defined by the security module. A flags field
is included for LSM specific information. It is currently unused and must
be 0. The total size of the data, including the lsm_ctx structure and any
padding, is maintained as well.

struct lsm_ctx {
        __u64 id;
        __u64 flags;
        __u64 len;
        __u64 ctx_len;
        __u8 ctx[];
};

Two new LSM hooks are used to interface with the LSMs.
security_getselfattr() collects the lsm_ctx values from the
LSMs that support the hook, accounting for space requirements.
security_setselfattr() identifies which LSM the attribute is
intended for and passes it along.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Serge Hallyn <serge@hallyn.com>
---
 Documentation/userspace-api/lsm.rst |  15 ++++
 include/linux/lsm_hook_defs.h       |   4 +
 include/linux/lsm_hooks.h           |   1 +
 include/linux/security.h            |  19 +++++
 include/linux/syscalls.h            |   5 ++
 include/uapi/linux/lsm.h            |  36 +++++++++
 kernel/sys_ni.c                     |   4 +
 security/Makefile                   |   1 +
 security/lsm_syscalls.c             |  55 ++++++++++++++
 security/security.c                 | 112 ++++++++++++++++++++++++++++
 10 files changed, 252 insertions(+)
 create mode 100644 security/lsm_syscalls.c

diff --git a/Documentation/userspace-api/lsm.rst b/Documentation/userspace-api/lsm.rst
index 6ddf5506110b..e6c3f262addc 100644
--- a/Documentation/userspace-api/lsm.rst
+++ b/Documentation/userspace-api/lsm.rst
@@ -48,6 +48,21 @@ creating socket objects.
 The proc filesystem provides this value in ``/proc/self/attr/sockcreate``.
 This is supported by the SELinux security module.
 
+Kernel interface
+================
+
+Set a security attribute of the current process
+-----------------------------------------------
+
+.. kernel-doc:: security/lsm_syscalls.c
+    :identifiers: sys_lsm_set_self_attr
+
+Get the specified security attributes of the current process
+------------------------------------------------------------
+
+.. kernel-doc:: security/lsm_syscalls.c
+    :identifiers: sys_lsm_get_self_attr
+
 Additional documentation
 ========================
 
diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index 6bb55e61e8e8..f69a7863dbe2 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -261,6 +261,10 @@ LSM_HOOK(int, 0, sem_semop, struct kern_ipc_perm *perm, struct sembuf *sops,
 LSM_HOOK(int, 0, netlink_send, struct sock *sk, struct sk_buff *skb)
 LSM_HOOK(void, LSM_RET_VOID, d_instantiate, struct dentry *dentry,
 	 struct inode *inode)
+LSM_HOOK(int, -EOPNOTSUPP, getselfattr, unsigned int attr,
+	 struct lsm_ctx __user *ctx, size_t *size, u32 flags)
+LSM_HOOK(int, -EOPNOTSUPP, setselfattr, unsigned int attr,
+	 struct lsm_ctx __user *ctx, size_t size, u32 flags)
 LSM_HOOK(int, -EINVAL, getprocattr, struct task_struct *p, const char *name,
 	 char **value)
 LSM_HOOK(int, -EINVAL, setprocattr, const char *name, void *value, size_t size)
diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index fba8881d2bb5..9a3ae6b33d7b 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -25,6 +25,7 @@
 #ifndef __LINUX_LSM_HOOKS_H
 #define __LINUX_LSM_HOOKS_H
 
+#include <uapi/linux/lsm.h>
 #include <linux/security.h>
 #include <linux/init.h>
 #include <linux/rculist.h>
diff --git a/include/linux/security.h b/include/linux/security.h
index 945101b0d404..475d0abfebda 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -60,6 +60,7 @@ struct fs_parameter;
 enum fs_value_type;
 struct watch;
 struct watch_notification;
+struct lsm_ctx;
 
 /* Default (no) options for the capable function */
 #define CAP_OPT_NONE 0x0
@@ -470,6 +471,10 @@ int security_sem_semctl(struct kern_ipc_perm *sma, int cmd);
 int security_sem_semop(struct kern_ipc_perm *sma, struct sembuf *sops,
 			unsigned nsops, int alter);
 void security_d_instantiate(struct dentry *dentry, struct inode *inode);
+int security_getselfattr(unsigned int attr, struct lsm_ctx __user *ctx,
+			 size_t __user *size, u32 flags);
+int security_setselfattr(unsigned int attr, struct lsm_ctx __user *ctx,
+			 size_t size, u32 flags);
 int security_getprocattr(struct task_struct *p, int lsmid, const char *name,
 			 char **value);
 int security_setprocattr(int lsmid, const char *name, void *value, size_t size);
@@ -1331,6 +1336,20 @@ static inline void security_d_instantiate(struct dentry *dentry,
 					  struct inode *inode)
 { }
 
+static inline int security_getselfattr(unsigned int attr,
+				       struct lsm_ctx __user *ctx,
+				       size_t __user *size, u32 flags)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int security_setselfattr(unsigned int attr,
+				       struct lsm_ctx __user *ctx,
+				       size_t size, u32 flags)
+{
+	return -EOPNOTSUPP;
+}
+
 static inline int security_getprocattr(struct task_struct *p, int lsmid,
 				       const char *name, char **value)
 {
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 33a0ee3bcb2e..9a94c31bf6b6 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -71,6 +71,7 @@ struct clone_args;
 struct open_how;
 struct mount_attr;
 struct landlock_ruleset_attr;
+struct lsm_ctx;
 enum landlock_rule_type;
 
 #include <linux/types.h>
@@ -1058,6 +1059,10 @@ asmlinkage long sys_memfd_secret(unsigned int flags);
 asmlinkage long sys_set_mempolicy_home_node(unsigned long start, unsigned long len,
 					    unsigned long home_node,
 					    unsigned long flags);
+asmlinkage long sys_lsm_get_self_attr(unsigned int attr, struct lsm_ctx *ctx,
+				      size_t *size, __u32 flags);
+asmlinkage long sys_lsm_set_self_attr(unsigned int attr, struct lsm_ctx *ctx,
+				      size_t size, __u32 flags);
 
 /*
  * Architecture-specific system calls
diff --git a/include/uapi/linux/lsm.h b/include/uapi/linux/lsm.h
index f27c9a9cc376..eeda59a77c02 100644
--- a/include/uapi/linux/lsm.h
+++ b/include/uapi/linux/lsm.h
@@ -9,6 +9,36 @@
 #ifndef _UAPI_LINUX_LSM_H
 #define _UAPI_LINUX_LSM_H
 
+#include <linux/types.h>
+#include <linux/unistd.h>
+
+/**
+ * struct lsm_ctx - LSM context information
+ * @id: the LSM id number, see LSM_ID_XXX
+ * @flags: LSM specific flags
+ * @len: length of the lsm_ctx struct, @ctx and any other data or padding
+ * @ctx_len: the size of @ctx
+ * @ctx: the LSM context value
+ *
+ * The @len field MUST be equal to the size of the lsm_ctx struct
+ * plus any additional padding and/or data placed after @ctx.
+ *
+ * In all cases @ctx_len MUST be equal to the length of @ctx.
+ * If @ctx is a string value it should be nul terminated with
+ * @ctx_len equal to `strlen(@ctx) + 1`.  Binary values are
+ * supported.
+ *
+ * The @flags and @ctx fields SHOULD only be interpreted by the
+ * LSM specified by @id; they MUST be set to zero/0 when not used.
+ */
+struct lsm_ctx {
+	__u64 id;
+	__u64 flags;
+	__u64 len;
+	__u64 ctx_len;
+	__u8 ctx[];
+};
+
 /*
  * ID tokens to identify Linux Security Modules (LSMs)
  *
@@ -51,4 +81,10 @@
 #define LSM_ATTR_PREV		104
 #define LSM_ATTR_SOCKCREATE	105
 
+/*
+ * LSM_FLAG_XXX definitions identify special handling instructions
+ * for the API.
+ */
+#define LSM_FLAG_SINGLE	0x0001
+
 #endif /* _UAPI_LINUX_LSM_H */
diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
index 860b2dcf3ac4..d03c78ef1562 100644
--- a/kernel/sys_ni.c
+++ b/kernel/sys_ni.c
@@ -262,6 +262,10 @@ COND_SYSCALL_COMPAT(recvmsg);
 /* mm/nommu.c, also with MMU */
 COND_SYSCALL(mremap);
 
+/* security/lsm_syscalls.c */
+COND_SYSCALL(lsm_get_self_attr);
+COND_SYSCALL(lsm_set_self_attr);
+
 /* security/keys/keyctl.c */
 COND_SYSCALL(add_key);
 COND_SYSCALL(request_key);
diff --git a/security/Makefile b/security/Makefile
index 18121f8f85cd..59f238490665 100644
--- a/security/Makefile
+++ b/security/Makefile
@@ -7,6 +7,7 @@ obj-$(CONFIG_KEYS)			+= keys/
 
 # always enable default capabilities
 obj-y					+= commoncap.o
+obj-$(CONFIG_SECURITY) 			+= lsm_syscalls.o
 obj-$(CONFIG_MMU)			+= min_addr.o
 
 # Object file lists
diff --git a/security/lsm_syscalls.c b/security/lsm_syscalls.c
new file mode 100644
index 000000000000..ee3881159241
--- /dev/null
+++ b/security/lsm_syscalls.c
@@ -0,0 +1,55 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * System calls implementing the Linux Security Module API.
+ *
+ *  Copyright (C) 2022 Casey Schaufler <casey@schaufler-ca.com>
+ *  Copyright (C) 2022 Intel Corporation
+ */
+
+#include <asm/current.h>
+#include <linux/compiler_types.h>
+#include <linux/err.h>
+#include <linux/errno.h>
+#include <linux/security.h>
+#include <linux/stddef.h>
+#include <linux/syscalls.h>
+#include <linux/types.h>
+#include <linux/lsm_hooks.h>
+#include <uapi/linux/lsm.h>
+
+/**
+ * sys_lsm_set_self_attr - Set current task's security module attribute
+ * @attr: which attribute to set
+ * @ctx: the LSM contexts
+ * @size: size of @ctx
+ * @flags: reserved for future use
+ *
+ * Sets the calling task's LSM context. On success this function
+ * returns 0. If the attribute specified cannot be set a negative
+ * value indicating the reason for the error is returned.
+ */
+SYSCALL_DEFINE4(lsm_set_self_attr, unsigned int, attr, struct lsm_ctx __user *,
+		ctx, size_t, size, u32, flags)
+{
+	return security_setselfattr(attr, ctx, size, flags);
+}
+
+/**
+ * sys_lsm_get_self_attr - Return current task's security module attributes
+ * @attr: which attribute to set
+ * @ctx: the LSM contexts
+ * @size: size of @ctx, updated on return
+ * @flags: reserved for future use
+ *
+ * Returns the calling task's LSM contexts. On success this
+ * function returns the number of @ctx array elements. This value
+ * may be zero if there are no LSM contexts assigned. If @size is
+ * insufficient to contain the return data -E2BIG is returned and
+ * @size is set to the minimum required size. In all other cases
+ * a negative value indicating the error is returned.
+ */
+SYSCALL_DEFINE4(lsm_get_self_attr, unsigned int, attr, struct lsm_ctx __user *,
+		ctx, size_t __user *, size, u32, flags)
+{
+	return security_getselfattr(attr, ctx, size, flags);
+}
diff --git a/security/security.c b/security/security.c
index d942b0c8e32f..199db23581f1 100644
--- a/security/security.c
+++ b/security/security.c
@@ -3798,6 +3798,118 @@ void security_d_instantiate(struct dentry *dentry, struct inode *inode)
 }
 EXPORT_SYMBOL(security_d_instantiate);
 
+/**
+ * security_getselfattr - Read an LSM attribute of the current process.
+ * @attr: which attribute to return
+ * @ctx: the user-space destination for the information, or NULL
+ * @size: pointer to the size of space available to receive the data
+ * @flags: special handling options. LSM_FLAG_SINGLE indicates that only
+ * attributes associated with the LSM identified in the passed @ctx be
+ * reported
+ *
+ * Returns the number of attributes found on success, negative value
+ * on error. @size is reset to the total size of the data.
+ * If @size is insufficient to contain the data -E2BIG is returned.
+ */
+int security_getselfattr(unsigned int attr, struct lsm_ctx __user *ctx,
+			 size_t __user *size, u32 flags)
+{
+	struct security_hook_list *hp;
+	struct lsm_ctx lctx = { .id = LSM_ID_UNDEF, };
+	u8 __user *base = (u8 __user *)ctx;
+	size_t total = 0;
+	size_t entrysize;
+	size_t left;
+	bool toobig = false;
+	int count = 0;
+	int rc;
+
+	if (attr == LSM_ATTR_UNDEF)
+		return -EINVAL;
+	if (size == NULL)
+		return -EINVAL;
+	if (get_user(left, size))
+		return -EFAULT;
+
+	if ((flags & LSM_FLAG_SINGLE) == LSM_FLAG_SINGLE) {
+		if (!ctx)
+			return -EINVAL;
+		if (copy_struct_from_user(&lctx, sizeof(lctx), ctx, left))
+			return -EFAULT;
+		if (lctx.id == LSM_ID_UNDEF)
+			return -EINVAL;
+	} else if (flags) {
+		return -EINVAL;
+	}
+
+	hlist_for_each_entry(hp, &security_hook_heads.getselfattr, list) {
+		if (lctx.id != LSM_ID_UNDEF && lctx.id != hp->lsmid->id)
+			continue;
+		entrysize = left;
+		if (base)
+			ctx = (struct lsm_ctx __user *)(base + total);
+		rc = hp->hook.getselfattr(attr, ctx, &entrysize, flags);
+		if (rc == -EOPNOTSUPP) {
+			rc = 0;
+			continue;
+		}
+		if (rc == -E2BIG) {
+			toobig = true;
+			left = 0;
+			continue;
+		}
+		if (rc < 0)
+			return rc;
+
+		left -= entrysize;
+		total += entrysize;
+		count += rc;
+	}
+	if (put_user(total, size))
+		return -EFAULT;
+	if (toobig)
+		return -E2BIG;
+	if (count == 0)
+		return LSM_RET_DEFAULT(getselfattr);
+	return count;
+}
+
+/**
+ * security_setselfattr - Set an LSM attribute on the current process.
+ * @attr: which attribute to set
+ * @ctx: the user-space source for the information
+ * @size: the size of the data
+ * @flags: reserved for future use, must be 0
+ *
+ * Set an LSM attribute for the current process. The LSM, attribute
+ * and new value are included in @ctx.
+ *
+ * Returns 0 on success, -EINVAL if the input is inconsistent, -EFAULT
+ * if the user buffer is inaccessible or an LSM specific failure.
+ */
+int security_setselfattr(unsigned int attr, struct lsm_ctx __user *ctx,
+			 size_t size, u32 flags)
+{
+	struct security_hook_list *hp;
+	struct lsm_ctx lctx;
+
+	if (flags)
+		return -EINVAL;
+	if (size < sizeof(*ctx))
+		return -EINVAL;
+	if (copy_from_user(&lctx, ctx, sizeof(*ctx)))
+		return -EFAULT;
+	if (size < lctx.len || size < lctx.ctx_len + sizeof(ctx) ||
+	    lctx.len < lctx.ctx_len + sizeof(ctx))
+		return -EINVAL;
+
+	hlist_for_each_entry(hp, &security_hook_heads.setselfattr, list)
+		if ((hp->lsmid->id) == lctx.id)
+			return hp->hook.setselfattr(attr, ctx, size, flags);
+
+	return LSM_RET_DEFAULT(setselfattr);
+}
+
 /**
  * security_getprocattr() - Read an attribute for a task
  * @p: the task
-- 
2.40.1


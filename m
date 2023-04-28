Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC57F6F1F4B
	for <lists+linux-api@lfdr.de>; Fri, 28 Apr 2023 22:28:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346471AbjD1U2l (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 28 Apr 2023 16:28:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232045AbjD1U2j (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 28 Apr 2023 16:28:39 -0400
Received: from sonic307-15.consmr.mail.ne1.yahoo.com (sonic307-15.consmr.mail.ne1.yahoo.com [66.163.190.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B508D1FC3
        for <linux-api@vger.kernel.org>; Fri, 28 Apr 2023 13:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1682713716; bh=GgOjzkePkJSoFsz+QJcl7OzqBzn70cGDoNq07autlSU=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=eZfnYyxdEEkLKLI6s+4M8lGp/TZLVlf5vMoUXekm+I4s3ds+GiiyKCaSXUjJnvveNecXO6p9svU0v2P+Zf92RM787/c7+CbkUZ1ZN+FPxLlfjb2x2YIG/6DiQzh5ppH6rMLERUCL86xZIZKv1Tz5GDXHYZM0C6u9JLvmbDqHIhenEdUB5jPb37e2MlEowWzUkNknF3ZuwciIWXIeFoqR9hwOIokSzHcsudsq4lKjgzF4ngBFUY1G6MFz7lG5FhUNdnRUzeU4ZzPf0pWDlU+T1zChK3siBKlqYZ2GuvCELkDooxdKaSxln6kFr5PvXy3A6rK0zZbL6kD64i/+/ESsBQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1682713716; bh=hTr0T45f+8wTzYfALfKVept2XM0a7G58UdaDCaWFDjq=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=JY3XTEhr6hIfFZXs0HC4FDOh0aORhk1Zwiyr5GnBhCAK70/ecXWKUJC3RO7tU0J1254v3gy933trUuD6CEZAlCqRzZ0q/xl1UM52D2zEQYuE9aEe6B28pZZSQViodGK1BSN+q1s9w5e897r1KegWdsfnpnsoAxYkv2lskMX1mZhrdFV+kvBqSNXRBO7m/Lh9p6rjxd9RlZs12yQHSatt49zx3OofQocQ0jXpEOabnP/M+j2vxTmNCXMv1yvLgtHDiALKvV1UuKqZA6qAsREQOyE7lxxbPwQT1keMTTOGuoD9i+ASSxH1i4AekBcg3DHEre82GjeTw2LRPVjf1xmgZg==
X-YMail-OSG: PRPAWXoVM1l1l9.NGMNf6Y6WY7UMRq4j0R45pG9jbuMrdhyuOgxC_vQ6Tl798c0
 ThFUKz1OtimA9YvCDl.upTSDdnp.TN.Hco0oAO.an6554FbqaX7vm6dSjSkeWJHXqQsziYYTlapT
 yF7pS0SHNypKMKioFLOEV8vlN24vRDku9Cq4YslK6F59EAp4RXXrCX5OpyLRElpvzCHFUC5AgMhs
 pG9iWMgIzvqVcife_XCSaIEr7p0jm_dU2xTZoRGdXv_fDZ.DKZne30pXe195BwzJYFibpOPdETfE
 lQPWFLNIq6sQevY3IgD_EGPkQ7M2U.IqHmyaN5Vy2mzdtbvpD71lbhsPYfr9O.EdHcPLdOW4NK8L
 uWrHFrCPuGN1y5J99FVVjqm5a5GZecZRtoV6xbOHLtmHpYLO1XFw9EPvG80Q3CILU32TIhH7JgIR
 ENul_ceiTZHr6ZAk3m_HcBY4Qz1S3wkFBTE_cm8DhAHxbI_t8J6t61WMTVub2DrV2bj_iIlssdoN
 9th6S._e.YeJ_WCLIOJ7aaaYCWimYopGMDo1JRzM3feCTZYhMNQlh_.VsWBv_gmmGMHy.qWdJ04B
 K82JNksSd6wIkIBYNRHKjBmZRdsgBf1vJqkdse3Q6jHAD4LMkQoPS25odMF6vtQANSBefYSM.8yZ
 WOS8UAkJFJDdugxWw7ZREr69LG7C.AVpL5HmuvaRwZN5q8W0XoXMb1dkSNz2iuMLFp6tXIUTOXbJ
 UonT8Qk_Ce_v5gFI6fY8umaS.YJZrZqc5DGii7HTt.Hi.mCUSbeM4MHGKlkLyZnYV_6qAdJL_U9G
 7NVYyNyHgWZTGrxAUaOJQMjhNjZ9YUoAyWFy.4rTOClOBjJXqalNlv7YJpVKKVp3esYeNjw9yPab
 TRyIkqn3iIBv662ouas8j46a88vQTyWDFEA9wTGqe65P9qispaC37iSjBV7iUPSwFVuEeM2YYU.4
 1X64vOtfAafvYKxqkPivcxX9.50L4zNCKK3OoBdvMIVa9r5HYo5i5NxXPnbSm70hyBEpiQfTYk1t
 hCM1.Qt1fYQ2ZxjD56S.s32Qtd3_Bu8FtnNNeFy4fX5e3SePlSm1JCvp5lt9zr7PVreIIovTHtII
 FNFqHc3lim7V.AJ9W6bXj_NjV6o1Nfhk0lfGOrVz0UVhks_cSp.SyUXgTb_7sUGo2Of2II1ReXg8
 UOflCisAKd2o70yXpVva9_jYOqaBtrAnTWID9jT_FljzfBgymZQ65hKWT.LfBOtA0JoInJzC030X
 mgNlhnXcHYmUJ2WJ0RnjC55prxkeBwCmdiIAu7xSbnzBjYM9jJ7BjMHIjP6FzWlG.epO1tUyOsFx
 i_mRig6jWJ9FkVg.yGf5XKczshlUfCbUurmhDw9V0A3zjwt6AClEXcO6_RLNl9OBcRqokQ6hWAH2
 91b7W8BYz6TXj7d1vphK2QeodvX0wQQEw2t3yxuw.7uwug2GAlwRIaWT.o2ktj0NeJHfRhOvl1iz
 QHOAalBlYKLo0Lnzp1J6mp86jiyIuWQ3Qxd7GR8jKK2FW41RHNRWn5MiE3psok8FcjMAeRhZV9KM
 wnaRoETDHNEsQHoAALpa_iDYVIpiTuTkXHayOE98XEE7xE5DeNIJizieRzgwrdoSabDXzlbXG0Re
 4TooAwytqsRVsRHSKmV2Yojd_2FRjnOqM7ouzuQc8bDMxE1r69pkpO_rVNTsOisKSBthZHY6Edr0
 6JG._7ujttVRvC.I7RZF0NlVTDA.6nTptojpMT8mWXTfz2GFwPjPyc3Ez3nHHRL2KDqzlNrQQweR
 CErSaInYaTP6tndNbabnQW6vS06SSUyUW5iYJnzVOJQVnqLg47tpru6QaCFRbbvpABmPuB6hNm4u
 vHDhRLNbhMUn8h5JKi0_5HJaYgFjQELlZitK8bnlrNrnJaKaplZhbStqIAk66dOzcxJ6kw1_nszb
 BdMEd1d9cQvhCsIn45266tFOeW61jZs7xcPLDhg8LgMb2obQnEBYLKHwPthYiuER1FiaWES9b6.N
 EnfgdK3Nip1rZIr5XXM.0L9xue6z68QS8EJicXeR.wtFiLXh02p0lOmOw9nl1JLaWRybqMK_0NRW
 SEqGnZkTQ1yn0pgmjdHoSRtBBMaYkIIIsLwgTX99LTxE5gAxMasPNRsDdh2D9t2P2gK0_VFxUjFn
 fWewbBM.s2hBcEBCKKzo1zAIQpnIWPD9pV08GiamlavH74C8tFgWVUDBABFwN.TSCIl2rFEs7sem
 98ZbsxxhASEZkmSs1_a7oTE0xchG6peswFGQeV9rYbycxc9KzGWbM.cUDe_XLfo0cQUHNymxyY8a
 fk2L4LvzNAt.0uWe2rQ2s
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 911cc9cc-f14e-4911-b3fa-190742075097
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.ne1.yahoo.com with HTTP; Fri, 28 Apr 2023 20:28:36 +0000
Received: by hermes--production-ne1-7dbd98dd99-tcjjg (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID b58a5884cc254441b7169bc1ab603d8d;
          Fri, 28 Apr 2023 20:28:34 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey@schaufler-ca.com, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     jmorris@namei.org, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net
Subject: [PATCH v10 04/11] LSM: syscalls for current process attributes
Date:   Fri, 28 Apr 2023 13:26:44 -0700
Message-Id: <20230428202651.159828-5-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230428202651.159828-1-casey@schaufler-ca.com>
References: <20230428202651.159828-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
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
---
 Documentation/userspace-api/lsm.rst |  15 ++++
 include/linux/lsm_hook_defs.h       |   4 +
 include/linux/lsm_hooks.h           |   9 +++
 include/linux/security.h            |  19 +++++
 include/linux/syscalls.h            |   5 ++
 include/uapi/linux/lsm.h            |  36 +++++++++
 kernel/sys_ni.c                     |   4 +
 security/Makefile                   |   1 +
 security/lsm_syscalls.c             |  55 ++++++++++++++
 security/security.c                 | 112 ++++++++++++++++++++++++++++
 10 files changed, 260 insertions(+)
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
index 094b76dc7164..32104ff61999 100644
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
index c1f00d09033e..457ff953e331 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -25,6 +25,7 @@
 #ifndef __LINUX_LSM_HOOKS_H
 #define __LINUX_LSM_HOOKS_H
 
+#include <uapi/linux/lsm.h>
 #include <linux/security.h>
 #include <linux/init.h>
 #include <linux/rculist.h>
@@ -503,6 +504,14 @@
  *	and writing the xattrs as this hook is merely a filter.
  * @d_instantiate:
  *	Fill in @inode security information for a @dentry if allowed.
+ * @getselfattr:
+ *	Read attribute @attr for the current process and store it into @ctx.
+ *	Return 0 on success, -EOPNOTSUPP if the attribute is not supported,
+ *	or another negative value otherwise.
+ * @setselfattr:
+ *	Set attribute @attr for the current process.
+ *	Return 0 on success, -EOPNOTSUPP if the attribute is not supported,
+ *	or another negative value otherwise.
  * @getprocattr:
  *	Read attribute @name for process @p and store it into @value if allowed.
  *	Return the length of @value on success, a negative value otherwise.
diff --git a/include/linux/security.h b/include/linux/security.h
index 8faed81fc3b4..806bff425af9 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -60,6 +60,7 @@ struct fs_parameter;
 enum fs_value_type;
 struct watch;
 struct watch_notification;
+struct lsm_ctx;
 
 /* Default (no) options for the capable function */
 #define CAP_OPT_NONE 0x0
@@ -473,6 +474,10 @@ int security_sem_semctl(struct kern_ipc_perm *sma, int cmd);
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
@@ -1343,6 +1348,20 @@ static inline void security_d_instantiate(struct dentry *dentry,
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
index 5a48b1b539e5..94b78bfd06b9 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2176,6 +2176,118 @@ void security_d_instantiate(struct dentry *dentry, struct inode *inode)
 }
 EXPORT_SYMBOL(security_d_instantiate);
 
+/**
+ * security_getselfattr - Read an LSM attribute of the current process.
+ * @attr: which attribute to return
+ * @ctx: the user-space destination for the information, or NULL
+ * @size: the size of space available to receive the data
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
+	if (attr == 0)
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
 int security_getprocattr(struct task_struct *p, int lsmid, const char *name,
 			 char **value)
 {
-- 
2.39.2


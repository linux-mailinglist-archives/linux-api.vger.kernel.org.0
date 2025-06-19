Return-Path: <linux-api+bounces-3945-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D1CFCAE0CE8
	for <lists+linux-api@lfdr.de>; Thu, 19 Jun 2025 20:27:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F26EB1BC4350
	for <lists+linux-api@lfdr.de>; Thu, 19 Jun 2025 18:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94646296169;
	Thu, 19 Jun 2025 18:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="selsYYHG"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 042C7238173;
	Thu, 19 Jun 2025 18:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750357039; cv=none; b=F4yg25R6BU4GgdQOjYZQwdsdx28al0jZD3CiSmrQzCODUIm8dtT/KoGkBv5/jYu5x3cJY3UdYoKOHeU5qHlQRi2ufvkzwcM9es5H547I5uo2EvCsBTXLaA9HZeUtfez9YV4c5ZiMBTJIuDF92JWuvF5hXHLIJpewGwZTJJK1aHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750357039; c=relaxed/simple;
	bh=gSoP9vc2b3ZcXI6+Dfy+CmfL9TvJ1UGMURgWd4CbyXE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EKusUOzcxz09g9sjGAhHFflf4CTWV9g/dpli+QfaXfJj43crHQ/CjH9rXQ+6fYpij92rVB1lTFsVuZSNJjfQOW3PeZ3GPBIJTNhn1W/RreJLWffGi7Dy9oSkyH1PP9cEfQXNsG35k8XAEQrrQjDaiIdvlw0fzVtLUsCWq3DMzHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=selsYYHG; arc=none smtp.client-ip=185.125.188.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from sec2-plucky-amd64.. (lau06-h06-176-136-128-80.dsl.sta.abo.bbox.fr [176.136.128.80])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 7C0CB4018E;
	Thu, 19 Jun 2025 18:17:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1750357027;
	bh=iZZoFBKz+HmVVKRN/UBQo21sYc8IENA5QGF3j3MDWDs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type;
	b=selsYYHG34jeNSQsn6Qx6ySaOu3yD3ovcnSzlbNKho0Y0XBgXNZHlY7M2BQC9F+ab
	 v203em0m4zZcOwj+oY+dsGEwY0V9vLV6IxYxRUFU5G92n3/ZRUSH+sEd+2DO3k+stn
	 EJDnWRwpB5I4oAUtdalj/05NgUjTYrkNbpC2SFa+WgAS9mfXALU3LcfJcYPiUZn6YR
	 HGYjjXpWttFrW8my/Vvjr7DxOKXElVA6vh5kWLi2qM9VRRYg/i4lVNSMHdVmqVy/7v
	 Nob2l6GIIjls6KdFSQvxr4iCk53UYKZTs4mUx/QWjzV2ARe+cfj2UuqRM3Q6vIqm8a
	 mw21ZO7KZ/1Sg==
From: =?UTF-8?q?Maxime=20B=C3=A9lair?= <maxime.belair@canonical.com>
To: linux-security-module@vger.kernel.org
Cc: john.johansen@canonical.com,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com,
	mic@digikod.net,
	kees@kernel.org,
	stephen.smalley.work@gmail.com,
	casey@schaufler-ca.com,
	takedakn@nttdata.co.jp,
	penguin-kernel@I-love.SAKURA.ne.jp,
	song@kernel.org,
	linux-api@vger.kernel.org,
	apparmor@lists.ubuntu.com,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Maxime=20B=C3=A9lair?= <maxime.belair@canonical.com>
Subject: [PATCH v2 2/3] lsm: introduce security_lsm_config_*_policy hooks
Date: Thu, 19 Jun 2025 20:15:32 +0200
Message-ID: <20250619181600.478038-3-maxime.belair@canonical.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250619181600.478038-1-maxime.belair@canonical.com>
References: <20250619181600.478038-1-maxime.belair@canonical.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Define two new LSM hooks: security_lsm_config_self_policy and
security_lsm_config_system_policy and wire them into the corresponding
lsm_config_*_policy() syscalls so that LSMs can register a unified
interface for policy management. This initial, minimal implementation
only supports the LSM_POLICY_LOAD operation to limit changes.

Signed-off-by: Maxime Bélair <maxime.belair@canonical.com>
---
 include/linux/lsm_hook_defs.h |  4 ++
 include/linux/security.h      | 16 ++++++++
 include/uapi/linux/lsm.h      |  8 ++++
 security/Kconfig              | 22 +++++++++++
 security/lsm_syscalls.c       | 17 ++++++++-
 security/security.c           | 69 +++++++++++++++++++++++++++++++++++
 6 files changed, 134 insertions(+), 2 deletions(-)

diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index bf3bbac4e02a..fca490444643 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -464,3 +464,7 @@ LSM_HOOK(int, 0, bdev_alloc_security, struct block_device *bdev)
 LSM_HOOK(void, LSM_RET_VOID, bdev_free_security, struct block_device *bdev)
 LSM_HOOK(int, 0, bdev_setintegrity, struct block_device *bdev,
 	 enum lsm_integrity_type type, const void *value, size_t size)
+LSM_HOOK(int, -EINVAL, lsm_config_self_policy, u32 lsm_id, u32 op,
+	 void __user *buf, size_t size, u32 flags)
+LSM_HOOK(int, -EINVAL, lsm_config_system_policy, u32 lsm_id, u32 op,
+	 void __user *buf, size_t size, u32 flags)
diff --git a/include/linux/security.h b/include/linux/security.h
index cc9b54d95d22..c2158f2656fd 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -581,6 +581,11 @@ void security_bdev_free(struct block_device *bdev);
 int security_bdev_setintegrity(struct block_device *bdev,
 			       enum lsm_integrity_type type, const void *value,
 			       size_t size);
+int security_lsm_config_self_policy(u32 lsm_id, u32 op, void __user *buf,
+				    size_t size, u32 flags);
+int security_lsm_config_system_policy(u32 lsm_id, u32 op, void __user *buf,
+				      size_t size, u32 flags);
+
 #else /* CONFIG_SECURITY */
 
 /**
@@ -1603,6 +1608,17 @@ static inline int security_bdev_setintegrity(struct block_device *bdev,
 	return 0;
 }
 
+static int security_lsm_config_self_policy(u32 lsm_id, u32 op, void __user *buf,
+					   size_t size, u32 flags)
+
+	return -EOPNOTSUPP;
+}
+
+static int security_lsm_config_system_policy(u32 lsm_id, u32 op, void __user *buf,
+					     size_t size, u32 flags)
+
+	return -EOPNOTSUPP;
+}
 #endif	/* CONFIG_SECURITY */
 
 #if defined(CONFIG_SECURITY) && defined(CONFIG_WATCH_QUEUE)
diff --git a/include/uapi/linux/lsm.h b/include/uapi/linux/lsm.h
index 938593dfd5da..844279f819ce 100644
--- a/include/uapi/linux/lsm.h
+++ b/include/uapi/linux/lsm.h
@@ -90,4 +90,12 @@ struct lsm_ctx {
  */
 #define LSM_FLAG_SINGLE	0x0001
 
+/*
+ * LSM_POLICY_XXX definitions identify the different operations
+ * configure lsm policies
+ */
+
+#define LSM_POLICY_UNDEF	0
+#define LSM_POLICY_LOAD		100
+
 #endif /* _UAPI_LINUX_LSM_H */
diff --git a/security/Kconfig b/security/Kconfig
index 4816fc74f81e..958be7b49a9e 100644
--- a/security/Kconfig
+++ b/security/Kconfig
@@ -220,6 +220,28 @@ config STATIC_USERMODEHELPER_PATH
 	  If you wish for all usermode helper programs to be disabled,
 	  specify an empty string here (i.e. "").
 
+config LSM_CONFIG_SELF_POLICY_MAX_BUFFER_SIZE
+	int "Maximum buffer size for lsm_manage_policy"
+	range 16384 1073741824
+	depends on SECURITY
+	default 4194304
+	help
+	  The maximum size of the buffer argument of lsm_config_self_policy.
+
+	  The default value of 4194304 (4MiB) is reasonable and should be large
+	  enough to fit policies in for most cases.
+
+config LSM_CONFIG_SYSTEM_POLICY_MAX_BUFFER_SIZE
+	int "Maximum buffer size for lsm_manage_policy"
+	range 16384 1073741824
+	depends on SECURITY
+	default 4194304
+	help
+	  The maximum size of the buffer argument of lsm_config_system_policy.
+
+	  The default value of 4194304 (4MiB) is reasonable and should be large
+	  enough to fit policies in for most cases
+
 source "security/selinux/Kconfig"
 source "security/smack/Kconfig"
 source "security/tomoyo/Kconfig"
diff --git a/security/lsm_syscalls.c b/security/lsm_syscalls.c
index a3cb6dab8102..dd016ba6976c 100644
--- a/security/lsm_syscalls.c
+++ b/security/lsm_syscalls.c
@@ -122,11 +122,24 @@ SYSCALL_DEFINE3(lsm_list_modules, u64 __user *, ids, u32 __user *, size,
 SYSCALL_DEFINE5(lsm_config_self_policy, u32, lsm_id, u32, op, void __user *,
 		buf, u32 __user *, size, u32, flags)
 {
-	return 0;
+	size_t usize;
+
+	if (get_user(usize, size))
+		return -EFAULT;
+
+	return security_lsm_config_self_policy(lsm_id, op, buf, usize, flags);
 }
 
 SYSCALL_DEFINE5(lsm_config_system_policy, u32, lsm_id, u32, op, void __user *,
 		buf, u32 __user *, size, u32, flags)
 {
-	return 0;
+	size_t usize;
+
+	if (!capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
+	if (get_user(usize, size))
+		return -EFAULT;
+
+	return security_lsm_config_system_policy(lsm_id, op, buf, usize, flags);
 }
diff --git a/security/security.c b/security/security.c
index fb57e8fddd91..8efea2b6e967 100644
--- a/security/security.c
+++ b/security/security.c
@@ -5883,6 +5883,75 @@ int security_bdev_setintegrity(struct block_device *bdev,
 }
 EXPORT_SYMBOL(security_bdev_setintegrity);
 
+/**
+ * security_lsm_config_self_policy() - Manage caller's LSM policies
+ * @lsm_id: id of the LSM to target
+ * @op: Operation to perform (one of the LSM_POLICY_XXX values)
+ * @buf: userspace pointer to policy data
+ * @size: size of @buf
+ * @flags: lsm policy management flags
+ *
+ * Manage the policies of a LSM for the current domain/user. This notably allows
+ * to update them even when the lsmfs is unavailable is restricted. Currently,
+ * only LSM_POLICY_LOAD is supported.
+ *
+ * Return: Returns 0 on success, error on failure.
+ */
+int security_lsm_config_self_policy(u32 lsm_id, u32 op, void __user *buf,
+				 size_t size, u32 flags)
+{
+	int rc = LSM_RET_DEFAULT(lsm_config_self_policy);
+	struct lsm_static_call *scall;
+
+	if (size > (CONFIG_LSM_CONFIG_SELF_POLICY_MAX_BUFFER_SIZE))
+		return -E2BIG;
+
+	lsm_for_each_hook(scall, lsm_config_self_policy) {
+		if ((scall->hl->lsmid->id) == lsm_id) {
+			rc = scall->hl->hook.lsm_config_self_policy(lsm_id, op, buf, size, flags);
+			break;
+		}
+	}
+
+	return rc;
+}
+EXPORT_SYMBOL(security_lsm_config_self_policy);
+
+/**
+ * security_lsm_config_system_policy() - Manage system LSM policies
+ * @lsm_id: id of the lsm to target
+ * @op: Operation to perform (one of the LSM_POLICY_XXX values)
+ * @buf: userspace pointer to policy data
+ * @size: size of @buf
+ * @flags: lsm policy management flags
+ *
+ * Manage the policies of a LSM for the whole system. This notably allows
+ * to update them even when the lsmfs is unavailable is restricted. Currently,
+ * only LSM_POLICY_LOAD is supported.
+ *
+ * Return: Returns 0 on success, error on failure.
+ */
+int security_lsm_config_system_policy(u32 lsm_id, u32 op, void __user *buf,
+				   size_t size, u32 flags)
+{
+	int rc = LSM_RET_DEFAULT(lsm_config_system_policy);
+	struct lsm_static_call *scall;
+
+	if (size > (CONFIG_LSM_CONFIG_SYSTEM_POLICY_MAX_BUFFER_SIZE))
+		return -E2BIG;
+
+	lsm_for_each_hook(scall, lsm_config_system_policy) {
+		if ((scall->hl->lsmid->id) == lsm_id) {
+			rc = scall->hl->hook.lsm_config_system_policy(lsm_id, op, buf, size, flags);
+			break;
+		}
+	}
+
+	return rc;
+}
+EXPORT_SYMBOL(security_lsm_config_system_policy);
+
+
 #ifdef CONFIG_PERF_EVENTS
 /**
  * security_perf_event_open() - Check if a perf event open is allowed
-- 
2.48.1



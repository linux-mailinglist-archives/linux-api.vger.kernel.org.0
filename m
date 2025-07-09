Return-Path: <linux-api+bounces-4145-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A13EAFE1D4
	for <lists+linux-api@lfdr.de>; Wed,  9 Jul 2025 10:04:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06DA9543F52
	for <lists+linux-api@lfdr.de>; Wed,  9 Jul 2025 08:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E0CE235072;
	Wed,  9 Jul 2025 08:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="Nu0LqSoL"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B550233159;
	Wed,  9 Jul 2025 08:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752048200; cv=none; b=UmVhakk9CfkqQiukW8RK2P1syU6gVH03O+ExW851gNFHX6J52Uyg7qjM837os56OA7pq+iVR0U9mfeoX1Z7kWog+8g0WzF5QU9AjAD2x4EuKWeNUUJsqMb9ZhjNjp/jMOXGwci/QOHYcpHg5yW1Fjt4mOi2bvmOwTtyB3zf0QK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752048200; c=relaxed/simple;
	bh=x4XOJAz/xUompCbTQhi5sL3C9SX+0e1WQKFt5e8sQ2E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GMRRCKf3zYvyTe1hTtesLvcU7NLBS4Qj/osNGVXjyWNggdpQPnb02f5mVPUf6CjSTppKg77qS0EGAcqWkOJulQlU9GHri8k4G3T4F8lE4p/VeQI5A+f1Qs/MAqwuocPxiX7kGrhGPEmmTOBur7pYkKqp3eZS+vn2DY76294kAAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=Nu0LqSoL; arc=none smtp.client-ip=185.125.188.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from sec2-plucky-amd64.. (lau06-h06-176-136-128-80.dsl.sta.abo.bbox.fr [176.136.128.80])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 7FBB240B85;
	Wed,  9 Jul 2025 08:03:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1752048186;
	bh=0cdzeTEBt3pIUt8UGBPcseJlalWxX7P/3riB9g+Rsuk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type;
	b=Nu0LqSoLGPoVDsGA5S0odX1I/7KpAKeQvBDAmIQim9rqetGF6t2uWUhHOQlYX85yn
	 qO1mnaOE3jtDlRz/hBErhSLmGOPZh/xRdAyIAYqlwCPSo5uLdHA/D5Q3ApbLUAdX6C
	 SiaKU2E23kCa7QzNMxW8LKDHDBGAax9UrG5SQo8BmkI4ZUI2Euq81HnxFxxLKcdesZ
	 FRCYL0PuNN4/FJJ9UurFp7HFs5gRloQAmdd04ZP5sYP7Aj9RM7DRWQd3X3Nrj+2ooG
	 BVbETw3sdDHTS3rWCdBKChfXAVcBaNcuJ3nqy0WCroiMxDfrpAicjvz2iDabTFf5y3
	 W1Tg52aeh/FTw==
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
	rdunlap@infradead.org,
	linux-api@vger.kernel.org,
	apparmor@lists.ubuntu.com,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Maxime=20B=C3=A9lair?= <maxime.belair@canonical.com>
Subject: [PATCH v5 2/3] lsm: introduce security_lsm_config_*_policy hooks
Date: Wed,  9 Jul 2025 10:00:55 +0200
Message-ID: <20250709080220.110947-3-maxime.belair@canonical.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250709080220.110947-1-maxime.belair@canonical.com>
References: <20250709080220.110947-1-maxime.belair@canonical.com>
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
 include/linux/lsm_hook_defs.h |  4 +++
 include/linux/security.h      | 20 ++++++++++++
 include/uapi/linux/lsm.h      |  8 +++++
 security/lsm_syscalls.c       | 17 ++++++++--
 security/security.c           | 60 +++++++++++++++++++++++++++++++++++
 5 files changed, 107 insertions(+), 2 deletions(-)

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
index cc9b54d95d22..54acaee4a994 100644
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
@@ -1603,6 +1608,21 @@ static inline int security_bdev_setintegrity(struct block_device *bdev,
 	return 0;
 }
 
+static inline int security_lsm_config_self_policy(u32 lsm_id, u32 op,
+						  void __user *buf,
+						  size_t size, u32 flags)
+{
+
+	return -EOPNOTSUPP;
+}
+
+static inline int security_lsm_config_system_policy(u32 lsm_id, u32 op,
+						    void __user *buf,
+						    size_t size, u32 flags)
+{
+
+	return -EOPNOTSUPP;
+}
 #endif	/* CONFIG_SECURITY */
 
 #if defined(CONFIG_SECURITY) && defined(CONFIG_WATCH_QUEUE)
diff --git a/include/uapi/linux/lsm.h b/include/uapi/linux/lsm.h
index 938593dfd5da..2b9432a30cdc 100644
--- a/include/uapi/linux/lsm.h
+++ b/include/uapi/linux/lsm.h
@@ -90,4 +90,12 @@ struct lsm_ctx {
  */
 #define LSM_FLAG_SINGLE	0x0001
 
+/*
+ * LSM_POLICY_XXX definitions identify the different operations
+ * to configure LSM policies
+ */
+
+#define LSM_POLICY_UNDEF	0
+#define LSM_POLICY_LOAD		100
+
 #endif /* _UAPI_LINUX_LSM_H */
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
index fb57e8fddd91..166d7d9936d0 100644
--- a/security/security.c
+++ b/security/security.c
@@ -5883,6 +5883,66 @@ int security_bdev_setintegrity(struct block_device *bdev,
 }
 EXPORT_SYMBOL(security_bdev_setintegrity);
 
+/**
+ * security_lsm_config_self_policy() - Configure caller's LSM policies
+ * @lsm_id: id of the LSM to target
+ * @op: Operation to perform (one of the LSM_POLICY_XXX values)
+ * @buf: userspace pointer to policy data
+ * @size: size of @buf
+ * @flags: lsm policy configuration flags
+ *
+ * Configure the policies of a LSM for the current domain/user. This notably
+ * allows to update them even when the lsmfs is unavailable or restricted.
+ * Currently, only LSM_POLICY_LOAD is supported.
+ *
+ * Return: Returns 0 on success, error on failure.
+ */
+int security_lsm_config_self_policy(u32 lsm_id, u32 op, void __user *buf,
+				 size_t size, u32 flags)
+{
+	int rc = LSM_RET_DEFAULT(lsm_config_self_policy);
+	struct lsm_static_call *scall;
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
+
+/**
+ * security_lsm_config_system_policy() - Configure system LSM policies
+ * @lsm_id: id of the lsm to target
+ * @op: Operation to perform (one of the LSM_POLICY_XXX values)
+ * @buf: userspace pointer to policy data
+ * @size: size of @buf
+ * @flags: lsm policy configuration flags
+ *
+ * Configure the policies of a LSM for the whole system. This notably allows
+ * to update them even when the lsmfs is unavailable or restricted. Currently,
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
+	lsm_for_each_hook(scall, lsm_config_system_policy) {
+		if ((scall->hl->lsmid->id) == lsm_id) {
+			rc = scall->hl->hook.lsm_config_system_policy(lsm_id, op, buf, size, flags);
+			break;
+		}
+	}
+
+	return rc;
+}
+
 #ifdef CONFIG_PERF_EVENTS
 /**
  * security_perf_event_open() - Check if a perf event open is allowed
-- 
2.48.1



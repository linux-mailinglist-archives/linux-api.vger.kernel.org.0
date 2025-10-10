Return-Path: <linux-api+bounces-5078-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E9FE5BCD4B1
	for <lists+linux-api@lfdr.de>; Fri, 10 Oct 2025 15:35:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5E9C24ECF11
	for <lists+linux-api@lfdr.de>; Fri, 10 Oct 2025 13:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D0772F3C3A;
	Fri, 10 Oct 2025 13:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="m3WE9POt"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ED402F25EC;
	Fri, 10 Oct 2025 13:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760103307; cv=none; b=kHnzmktKDGFEA/7r/N9LFj1Yue9iQmPzcXnzPylvrKj9YSo6ez7yQ97PGcePagq9CR6Yh0lHttDA0NCHaN2z00WWtgsD9Qek5g1gLiz3/9tmpN0MUEcK/2aKCqHX581ngcnFWHFGElzckdVVpcvuUbLgSOzc8Tzo6TnVDR0BkTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760103307; c=relaxed/simple;
	bh=SQXc1K0Z1VZW3ROHzyxH21tIQGWnboXgdIyPoPiCp1A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IAf41nQjz6MY5yuel3x1ol5W7B+0YN5mqBI9488BgN+cKR7QqU8ZcPR3T3p5aTFVJB+gOv/h4BPKNEzcyE9+fJ/gpmGyPnfm8yE1dXzYDhpRlPKRCYylKpbTtddfE0X3XAfiTYqCJnB0t2TPcI8kb/CxN6l/6sKzNtSptIBZk80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=m3WE9POt; arc=none smtp.client-ip=185.125.188.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from sec2-plucky-amd64.. (176-136-128-80.abo.bbox.fr [176.136.128.80])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id A486842AC7;
	Fri, 10 Oct 2025 13:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1760102818;
	bh=7SW7X9yzS5dQaxg3ulKbD2ZXQwm+YDMDeeVSp63vB6Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type;
	b=m3WE9POtoKg+e501gTdMyJmeVBmxk0yBwuC1aiF15yUoQtczMg8a9fPw7iChuzdzM
	 wk0Rozy25trmNKb3ZEg8JTpaNfp+DvtQgp0zDbVZfgzoXhEMR0PJVxdQ1Q2MhTOSkl
	 ihQgdMs/TzMkkPebCrgtV7L6Hq5M2pXJiCOv90IV2Sw2lTOGHPuPutipldVimUa2mB
	 vW1KqUQw22SCSDthLTA5g5L28hvwS/hGYJ0piId+Z+MvGTDtVzWbKMnxbw5iAVBXne
	 b3m+WLi5eT32Gf0KoqnqMoGXCQq1qMC6n0HoMOx6zHC3ce6C4403SMZLJk0puN9TYf
	 cObzX5K/SatbBw3OXkD0HxKhyKU4B7L78bGONRj1YnAmg0RbsMWxQflOGEuolVucBW
	 cYTcHSVdW4bijeEohZJzGfpsWAHFiFYBv34jw7FrU9InJohuID1ih0Y0Vp9MYDlySY
	 DWcQptHPiZsPTZo7urRUtpFduZFuLAXmNJUmfbJUadQdWgpXH3OmL5S6Zx7DshU3aZ
	 p84HwR25NVBInI/pLyzudQqSj9Fy3ZwPNjK+lLFgkx8O6wuSvtdn384a5PsAI+yXsE
	 68McBHXXrM3LvyTWCCWbE6frtrkqMGIC1eJV+QMr3DSKaGdlDkP5XzbDkqhSQVTq0g
	 2M8UrKEbB7F8KMZgO5Ab/Ct4=
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
Subject: [PATCH v6 2/5] lsm: introduce security_lsm_config_*_policy hooks
Date: Fri, 10 Oct 2025 15:25:29 +0200
Message-ID: <20251010132610.12001-3-maxime.belair@canonical.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251010132610.12001-1-maxime.belair@canonical.com>
References: <20251010132610.12001-1-maxime.belair@canonical.com>
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
 security/lsm_syscalls.c       | 13 ++++++--
 security/security.c           | 60 +++++++++++++++++++++++++++++++++++
 5 files changed, 103 insertions(+), 2 deletions(-)

diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index bf3bbac4e02a..50b6e8aed787 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -464,3 +464,7 @@ LSM_HOOK(int, 0, bdev_alloc_security, struct block_device *bdev)
 LSM_HOOK(void, LSM_RET_VOID, bdev_free_security, struct block_device *bdev)
 LSM_HOOK(int, 0, bdev_setintegrity, struct block_device *bdev,
 	 enum lsm_integrity_type type, const void *value, size_t size)
+LSM_HOOK(int, -EINVAL, lsm_config_self_policy, u32 op, void __user *buf,
+	 size_t size, u32 flags)
+LSM_HOOK(int, -EINVAL, lsm_config_system_policy, u32 op,
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
index b02a7623dea6..0796673b6f19 100644
--- a/security/lsm_syscalls.c
+++ b/security/lsm_syscalls.c
@@ -122,11 +122,20 @@ SYSCALL_DEFINE3(lsm_list_modules, u64 __user *, ids, u32 __user *, size,
 SYSCALL_DEFINE6(lsm_config_self_policy, u32, lsm_id, u32, op, void __user *,
 		buf, u32 __user, size, u32, common_flags, u32, flags)
 {
-	return 0;
+	if (common_flags) // Reserved for future use
+		return -EINVAL;
+
+	return security_lsm_config_self_policy(lsm_id, op, buf, size, flags);
 }
 
 SYSCALL_DEFINE6(lsm_config_system_policy, u32, lsm_id, u32, op, void __user *,
 		buf, u32 __user, size, u32, common_flags, u32, flags)
 {
-	return 0;
+	if (common_flags) // Reserved for future use
+		return -EINVAL;
+
+	if (!capable(CAP_MAC_ADMIN))
+		return -EPERM;
+
+	return security_lsm_config_system_policy(lsm_id, op, buf, size, flags);
 }
diff --git a/security/security.c b/security/security.c
index fb57e8fddd91..eeb61b27cd56 100644
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
+			rc = scall->hl->hook.lsm_config_self_policy(op, buf, size, flags);
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
+			rc = scall->hl->hook.lsm_config_system_policy(op, buf, size, flags);
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



Return-Path: <linux-api+bounces-3702-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C15BAAC84C
	for <lists+linux-api@lfdr.de>; Tue,  6 May 2025 16:40:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CB351C41E03
	for <lists+linux-api@lfdr.de>; Tue,  6 May 2025 14:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0C252836A1;
	Tue,  6 May 2025 14:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="Vb66+m91"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1953B28312C;
	Tue,  6 May 2025 14:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746542408; cv=none; b=eoDAsYkCff5k2I2S/P2ImCoyKrdU6Wo+bKlQaQlPgZxYQZi1AaJMOawfVWwSQyRPOUvZB6/CICG183uAbb1baL6/kWJmiMYaqbhQNnxA3iQEPJuZOmFqrAMbbgbTSCwUjAeo94hgghCtwfW6GQNe16w4Lo++Hpp0wuxRGVtzE/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746542408; c=relaxed/simple;
	bh=oRtoK4OQ3pTc5bDcwGh+bbInmaqSKZ/gQFhJ0vvibzQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=prPDQFkQdpsW1R4xJRzO7aYGh1dS85+i8GY6hTz0wJSmoy3VdPh+KwDcmBCXLYOouuogRKVQScDNfuNFssQRGm7icaU9x+nJGWpC3ea4loF19l5pNzFuwLFScVTO/B3FD9PXbqhSA3RAm6Z0/twj040Fms+dJn+R78FqQMlrqW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=Vb66+m91; arc=none smtp.client-ip=185.125.188.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from sec2-plucky-amd64.. (lau06-h06-176-136-128-80.dsl.sta.abo.bbox.fr [176.136.128.80])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 33E1B3FA54;
	Tue,  6 May 2025 14:33:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1746542032;
	bh=hyvapAcLQdJMkeSi/2KEFS+jCT+8B4SCrMVpfLKAPCY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type;
	b=Vb66+m91neEuJpJWZPeg1h4V00CV3+LESm5ekiXTg5CSFH17/zL32vkHcVYnb/0un
	 8SHKfCEwvGvgtGXjMEgC9wgjWePCyD9dHiCHSG1T7KybQnxUw/xfrMVJRqzgqM/CCB
	 FeQe8rpgZKG0Ow0NmyCtAgXhDppkaJYDR7nkF3DZAgq64dSWrb3AiLQdvxU3LYG6xg
	 aj0wXcpORLvls0JCM5QLGkFY2exrZgKI2rn6UJLh9it+6z1zzrHiqANbJNqyJMiTb/
	 27BFDZWqx0/x4aviamZHEYhDu11V6lern2ZPfNAfB2GplQOWuF5bIdeyX/dTJVwnfD
	 qfn8WMgc0gm2g==
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
	linux-api@vger.kernel.org,
	apparmor@lists.ubuntu.com,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Maxime=20B=C3=A9lair?= <maxime.belair@canonical.com>
Subject: [PATCH 2/3] lsm: introduce security_lsm_manage_policy hook
Date: Tue,  6 May 2025 16:32:29 +0200
Message-ID: <20250506143254.718647-3-maxime.belair@canonical.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250506143254.718647-1-maxime.belair@canonical.com>
References: <20250506143254.718647-1-maxime.belair@canonical.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Define a new LSM hook security_lsm_manage_policy and wire it into the
lsm_manage_policy() syscall so that LSMs can register a unified interface
for policy management. This initial, minimal implementation only supports
the LSM_POLICY_LOAD operation to limit changes.

Signed-off-by: Maxime Bélair <maxime.belair@canonical.com>
---
 include/linux/lsm_hook_defs.h |  2 ++
 include/linux/security.h      |  7 +++++++
 include/uapi/linux/lsm.h      |  8 ++++++++
 security/lsm_syscalls.c       |  7 ++++++-
 security/security.c           | 21 +++++++++++++++++++++
 5 files changed, 44 insertions(+), 1 deletion(-)

diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index bf3bbac4e02a..04b6e34d5111 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -464,3 +464,5 @@ LSM_HOOK(int, 0, bdev_alloc_security, struct block_device *bdev)
 LSM_HOOK(void, LSM_RET_VOID, bdev_free_security, struct block_device *bdev)
 LSM_HOOK(int, 0, bdev_setintegrity, struct block_device *bdev,
 	 enum lsm_integrity_type type, const void *value, size_t size)
+LSM_HOOK(int, 0, lsm_manage_policy, u32 lsm_id, u32 op, void __user *buf,
+	 size_t size, u32 flags)
diff --git a/include/linux/security.h b/include/linux/security.h
index cc9b54d95d22..dab547ee691c 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -581,6 +581,8 @@ void security_bdev_free(struct block_device *bdev);
 int security_bdev_setintegrity(struct block_device *bdev,
 			       enum lsm_integrity_type type, const void *value,
 			       size_t size);
+int security_lsm_manage_policy(u32 lsm_id, u32 op, void __user *buf,
+			       size_t size, u32 flags);
 #else /* CONFIG_SECURITY */
 
 /**
@@ -1602,6 +1604,11 @@ static inline int security_bdev_setintegrity(struct block_device *bdev,
 {
 	return 0;
 }
+static int security_lsm_manage_policy(u32 lsm_id, u32 op, void __user *buf,
+				      size_t size, u32 flags)
+
+	return -EOPNOTSUPP;
+}
 
 #endif	/* CONFIG_SECURITY */
 
diff --git a/include/uapi/linux/lsm.h b/include/uapi/linux/lsm.h
index 938593dfd5da..7335f9723114 100644
--- a/include/uapi/linux/lsm.h
+++ b/include/uapi/linux/lsm.h
@@ -90,4 +90,12 @@ struct lsm_ctx {
  */
 #define LSM_FLAG_SINGLE	0x0001
 
+/*
+ * LSM_POLICY_XXX definition identifies operation to manage lsm
+ * policies
+ */
+
+#define LSM_POLICY_UNDEF	0
+#define LSM_POLICY_LOAD		100
+
 #endif /* _UAPI_LINUX_LSM_H */
diff --git a/security/lsm_syscalls.c b/security/lsm_syscalls.c
index dcaad8818679..b39e6635a7d5 100644
--- a/security/lsm_syscalls.c
+++ b/security/lsm_syscalls.c
@@ -122,5 +122,10 @@ SYSCALL_DEFINE3(lsm_list_modules, u64 __user *, ids, u32 __user *, size,
 SYSCALL_DEFINE5(lsm_manage_policy, u32, lsm_id, u32, op, void __user *, buf, u32
 		__user *, size, u32, flags)
 {
-	return 0;
+	size_t usize;
+
+	if (get_user(usize, size))
+		return -EFAULT;
+
+	return security_lsm_manage_policy(lsm_id, op, buf, usize, flags);
 }
diff --git a/security/security.c b/security/security.c
index fb57e8fddd91..256104e338b1 100644
--- a/security/security.c
+++ b/security/security.c
@@ -5883,6 +5883,27 @@ int security_bdev_setintegrity(struct block_device *bdev,
 }
 EXPORT_SYMBOL(security_bdev_setintegrity);
 
+/**
+ * security_lsm_manage_policy() - Manage the policies of LSMs
+ * @lsm_id: id of the lsm to target
+ * @op: Operation to perform (one of the LSM_POLICY_XXX values)
+ * @buf:  userspace pointer to policy data
+ * @size: size of @buf
+ * @flags: lsm policy management flags
+ *
+ * Manage the policies of a LSM. This notably allows to update them even when
+ * the lsmfs is unavailable is restricted. Currently, only LSM_POLICY_LOAD is
+ * supported.
+ *
+ * Return: Returns 0 on success, error on failure.
+ */
+int security_lsm_manage_policy(u32 lsm_id, u32 op, void __user *buf,
+			       size_t size, u32 flags)
+{
+	return call_int_hook(lsm_manage_policy, lsm_id, op, buf, size, flags);
+}
+EXPORT_SYMBOL(security_lsm_manage_policy);
+
 #ifdef CONFIG_PERF_EVENTS
 /**
  * security_perf_event_open() - Check if a perf event open is allowed
-- 
2.48.1



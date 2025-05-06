Return-Path: <linux-api+bounces-3700-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 141D0AAC844
	for <lists+linux-api@lfdr.de>; Tue,  6 May 2025 16:40:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 812AB507B93
	for <lists+linux-api@lfdr.de>; Tue,  6 May 2025 14:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 192B1281512;
	Tue,  6 May 2025 14:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="Nr80sW8I"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0235280006;
	Tue,  6 May 2025 14:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746542406; cv=none; b=D6zhiU7kMxYxuwYgWK2s3ZHcqRUo0gAbqdabcOkmPbKBTel3hQHfjgeAjLYtdz8rQxnzy7RWBxSOQBQjt/6EF7fSBe3Poc07T7oCUuCetsBEBJOfvTk+0o2FH2tmGriXl0jwh8kiFQzDny6S5XtSZvy2ZH94sfGvRaMA/K+L/2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746542406; c=relaxed/simple;
	bh=CpDqPR15XINePCz0T5fea7ZNvYPlFawZSkdPLQcnM0o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QYj+GPwae0jlBdRjN5NoziwFUb0uv4K+qtlbXWQezMuJC4rN0L4orCM4CzOQBSI/umP6/nQxDZi6PbZmFX2YPx9xTLpQBmPnrmIGrmTwJ4ZfVUC1J1uUdyUFWuaZXlBQXLmzrdeCC8vHEiV/l70Hv4HoiJb9v7nKZUSuACC8gAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=Nr80sW8I; arc=none smtp.client-ip=185.125.188.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from sec2-plucky-amd64.. (lau06-h06-176-136-128-80.dsl.sta.abo.bbox.fr [176.136.128.80])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 39E8B3FA5D;
	Tue,  6 May 2025 14:33:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1746542033;
	bh=EE/hxAf6fOA9290fF87sCjLhHGpuE+GnCvgTO+GiMH0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type;
	b=Nr80sW8IOjrZj6q50eFteQwabIZJFxpj0eu/PeKOboTrZaGeTJXU8a4lfnQkZ7fgC
	 VQGXLA5ZKJGpp9kwQvGU+w5/xNU7UG/79dHM9PZqzJuzZQx2nSVugMvUBhxe34GTmY
	 FPpImAIySXvKgW+mFWEzC+i/+ExmAsUE3oqOYJRIX93MBbKCuAujlLxnGBfQRudvgy
	 9GpGDoby9IqvFqYHbH+ydE3B3f6YoWA/xt6vaoJBRCVIt5I5tIJYIt66KvLunz8yxi
	 5USfYVTPnG3vte1iXdAZTenXnyop0EywIGQHRdhlbTN7u+VtBKPtYfbhaeEKifaEnB
	 VvxC9EFFlwjqQ==
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
Subject: [PATCH 3/3] AppArmor: add support for lsm_manage_policy
Date: Tue,  6 May 2025 16:32:30 +0200
Message-ID: <20250506143254.718647-4-maxime.belair@canonical.com>
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

Enable users to manage AppArmor policies through the new hook
lsm_manage_policy. Currently, policies can be added but not replaced
using this new mechanism, ensuring that this interface can only further
confine the system.

Signed-off-by: Maxime Bélair <maxime.belair@canonical.com>
---
 security/apparmor/apparmorfs.c         | 19 +++++++++++++++++++
 security/apparmor/include/apparmorfs.h |  3 +++
 security/apparmor/lsm.c                | 16 ++++++++++++++++
 3 files changed, 38 insertions(+)

diff --git a/security/apparmor/apparmorfs.c b/security/apparmor/apparmorfs.c
index 6039afae4bfc..9abb17e8fdd0 100644
--- a/security/apparmor/apparmorfs.c
+++ b/security/apparmor/apparmorfs.c
@@ -439,6 +439,25 @@ static ssize_t policy_update(u32 mask, const char __user *buf, size_t size,
 	return error;
 }
 
+/**
+ * aa_profile_load_current_ns - load a profile into the current namespace
+ * @buf buffer containing the user-provided policy
+ * @size size of @buf
+ * @ppos position pointer in the file
+ *
+ * Returns: 0 on success, negative value on error
+ */
+ssize_t aa_profile_load_current_ns(const void __user *buf, size_t size,
+				   loff_t *ppos)
+{
+	struct aa_ns *ns = aa_get_current_ns();
+	int error = policy_update(AA_MAY_LOAD_POLICY, buf, size, ppos, ns);
+
+	aa_put_ns(ns);
+
+	return error >= 0 ? 0 : error;
+}
+
 /* .load file hook fn to load policy */
 static ssize_t profile_load(struct file *f, const char __user *buf, size_t size,
 			    loff_t *pos)
diff --git a/security/apparmor/include/apparmorfs.h b/security/apparmor/include/apparmorfs.h
index 1e94904f68d9..ba2384e3fb93 100644
--- a/security/apparmor/include/apparmorfs.h
+++ b/security/apparmor/include/apparmorfs.h
@@ -112,6 +112,9 @@ int __aafs_profile_mkdir(struct aa_profile *profile, struct dentry *parent);
 void __aafs_ns_rmdir(struct aa_ns *ns);
 int __aafs_ns_mkdir(struct aa_ns *ns, struct dentry *parent, const char *name,
 		     struct dentry *dent);
+ssize_t aa_profile_load_current_ns(const void __user *buf, size_t size,
+				   loff_t *ppos);
+
 
 struct aa_loaddata;
 
diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index 9b6c2f157f83..21f3c4db0e4e 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -1275,6 +1275,20 @@ static int apparmor_socket_shutdown(struct socket *sock, int how)
 	return aa_sock_perm(OP_SHUTDOWN, AA_MAY_SHUTDOWN, sock);
 }
 
+static int apparmor_lsm_manage_policy(u32 lsm_id, u32 op, void __user *buf,
+				      size_t size, u32 flags)
+{
+	loff_t pos = 0; // Partial writing is not currently supported
+
+	if (lsm_id != LSM_ID_APPARMOR)
+		return 0;
+
+	if (op != LSM_POLICY_LOAD || flags)
+		return -EOPNOTSUPP;
+
+	return aa_profile_load_current_ns(buf, size, &pos);
+}
+
 #ifdef CONFIG_NETWORK_SECMARK
 /**
  * apparmor_socket_sock_rcv_skb - check perms before associating skb to sk
@@ -1483,6 +1497,8 @@ static struct security_hook_list apparmor_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(socket_getsockopt, apparmor_socket_getsockopt),
 	LSM_HOOK_INIT(socket_setsockopt, apparmor_socket_setsockopt),
 	LSM_HOOK_INIT(socket_shutdown, apparmor_socket_shutdown),
+
+	LSM_HOOK_INIT(lsm_manage_policy, apparmor_lsm_manage_policy),
 #ifdef CONFIG_NETWORK_SECMARK
 	LSM_HOOK_INIT(socket_sock_rcv_skb, apparmor_socket_sock_rcv_skb),
 #endif
-- 
2.48.1



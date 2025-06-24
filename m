Return-Path: <linux-api+bounces-3959-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 396E3AE6961
	for <lists+linux-api@lfdr.de>; Tue, 24 Jun 2025 16:46:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FA1116687A
	for <lists+linux-api@lfdr.de>; Tue, 24 Jun 2025 14:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62A802E88B4;
	Tue, 24 Jun 2025 14:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="WNsqZBDE"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B95932E6D0F;
	Tue, 24 Jun 2025 14:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750775637; cv=none; b=ZIAXYYYotg7Csk7ceTllTNfgujWttAVOkfaU2AFRDT/egs4ry0Wl9V7zLKiIXgb5NmALwyfR3kQWiqkEomaTou+CJ701fOwsHrXVrU1r6fKF1oHZPsjX78TbfPwKqmoRp+oTl+EubktBtn8O4HKSXz5RJDzVO5R2TiaVuWgB04s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750775637; c=relaxed/simple;
	bh=d5M/Hk14yChGkT7tf/L/6oDfqdz4CsH3WSwtJxG4I+o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mhN8jfWjAZ9ZsB7l4i5Ch/qLIzzrre8CXbqq9FIxQ9vcCT/znLb2NBaIPE6H013s5WSJCw0EtFsO0be7h4/DVaFuwkns8dH3ZZB4/QPexc/zObma8sFGU/pejiEazqSjDVNXxj9oi6c90RyPuhCB8depLDQL7PJMjYQp+mQ6Psw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=WNsqZBDE; arc=none smtp.client-ip=185.125.188.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from sec2-plucky-amd64.. (lau06-h06-176-136-128-80.dsl.sta.abo.bbox.fr [176.136.128.80])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 7A4BD4018F;
	Tue, 24 Jun 2025 14:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1750775629;
	bh=X3yVcB/5qVhKayZUa41FaUh8FIUjAjD/QoJab4XolZw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type;
	b=WNsqZBDEdQ49baJVa2zBQXXd77lSSOW1kTOl4Rm5hknAVwup7AwSx1eR6no8KGF8c
	 vA04/0hHt9mUrvgsGBjHmOsnz677LX/nJ5I4Os7wyOX9/tpG2cAPggiEZMR5WGrEpk
	 9qlhuhKtQYPtHVg4Q+CIynLrulYwLW6kqagQa/k86hwJVzU9g6fdFeWwYmbW2x5Y4E
	 meLRs/6jeLetM6BZsDA65Zd+dRLqhgBvKaGZHKDOaOV33bxdCPVwe32Y8H9YQlq+ko
	 9OTgkxOMHaiPVJ4TNRcmfiNqh9RQevXlff1WhT+3q5YmcUFQso5IXJHf2fe015KY5W
	 LY01HJdtwXg/Q==
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
	rdunlap@infraread.org,
	linux-api@vger.kernel.org,
	apparmor@lists.ubuntu.com,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Maxime=20B=C3=A9lair?= <maxime.belair@canonical.com>
Subject: [PATCH v3 3/3] AppArmor: add support for lsm_config_self_policy and lsm_config_system_policy
Date: Tue, 24 Jun 2025 16:30:42 +0200
Message-ID: <20250624143211.436045-4-maxime.belair@canonical.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250624143211.436045-1-maxime.belair@canonical.com>
References: <20250624143211.436045-1-maxime.belair@canonical.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Enable users to manage AppArmor policies through the new hooks
lsm_config_self_policy and lsm_config_system_policy.

lsm_config_self_policy allows stacking existing policies in the kernel.
This ensures that it can only further restrict the caller and can never
be used to gain new privileges.

lsm_config_system_policy allows loading or replacing AppArmor policies in
any AppArmor namespace.

Signed-off-by: Maxime Bélair <maxime.belair@canonical.com>
---
 security/apparmor/apparmorfs.c         | 31 +++++++++++
 security/apparmor/include/apparmorfs.h |  3 ++
 security/apparmor/lsm.c                | 71 ++++++++++++++++++++++++++
 3 files changed, 105 insertions(+)

diff --git a/security/apparmor/apparmorfs.c b/security/apparmor/apparmorfs.c
index 6039afae4bfc..6df43299b045 100644
--- a/security/apparmor/apparmorfs.c
+++ b/security/apparmor/apparmorfs.c
@@ -439,6 +439,37 @@ static ssize_t policy_update(u32 mask, const char __user *buf, size_t size,
 	return error;
 }
 
+/**
+ * aa_profile_load_ns_name - load a profile into the current namespace identified by name
+ * @name: The name of the namesapce to load the policy in. "" for root_ns
+ * @name_size: size of @name. 0 For root ns
+ * @buf: buffer containing the user-provided policy
+ * @size: size of @buf
+ * @ppos: position pointer in the file
+ *
+ * Returns: 0 on success, negative value on error
+ */
+ssize_t aa_profile_load_ns_name(char *name, size_t name_size, const void __user *buf,
+				size_t size, loff_t *ppos)
+{
+	struct aa_ns *ns;
+
+	if (name_size == 0)
+		ns = aa_get_ns(root_ns);
+	else
+		ns = aa_lookupn_ns(root_ns, name, name_size);
+
+	if (!ns)
+		return -EINVAL;
+
+	int error = policy_update(AA_MAY_LOAD_POLICY | AA_MAY_REPLACE_POLICY,
+				  buf, size, ppos, ns);
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
index 1e94904f68d9..fd415afb7659 100644
--- a/security/apparmor/include/apparmorfs.h
+++ b/security/apparmor/include/apparmorfs.h
@@ -112,6 +112,9 @@ int __aafs_profile_mkdir(struct aa_profile *profile, struct dentry *parent);
 void __aafs_ns_rmdir(struct aa_ns *ns);
 int __aafs_ns_mkdir(struct aa_ns *ns, struct dentry *parent, const char *name,
 		     struct dentry *dent);
+ssize_t aa_profile_load_ns_name(char *name, size_t name_len, const void __user *buf,
+				size_t size, loff_t *ppos);
+
 
 struct aa_loaddata;
 
diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index 9b6c2f157f83..7ca2eb8c0981 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -1275,6 +1275,73 @@ static int apparmor_socket_shutdown(struct socket *sock, int how)
 	return aa_sock_perm(OP_SHUTDOWN, AA_MAY_SHUTDOWN, sock);
 }
 
+/**
+ * apparmor_lsm_config_self_policy - Stack a profile
+ * @lsm_id: AppArmor ID (LSM_ID_APPARMOR). Unused here
+ * @op: operation to perform. Currently, only LSM_POLICY_LOAD is supported
+ * @buf: buffer containing the user-provided name of the profile to stack
+ * @size: size of @buf
+ * @flags: reserved for future use; must be zero
+ *
+ * Returns: 0 on success, negative value on error
+ */
+static int apparmor_lsm_config_self_policy(u32 lsm_id, u32 op, void __user *buf,
+				      size_t size, u32 flags)
+{
+	char *name = kvmalloc(size, GFP_KERNEL);
+	long name_size;
+	int ret;
+
+	if (!name)
+		return -ENOMEM;
+
+	if (op != LSM_POLICY_LOAD || flags)
+		return -EOPNOTSUPP;
+
+	name_size = strncpy_from_user(name, buf, size);
+	if (name_size < 0)
+		return name_size;
+
+	ret = aa_change_profile(name, AA_CHANGE_STACK);
+
+	kvfree(name);
+
+	return ret;
+}
+
+/**
+ * apparmor_lsm_config_system_policy - Load or replace a system policy
+ * @lsm_id: AppArmor ID (LSM_ID_APPARMOR). Unused here
+ * @op: operation to perform. Currently, only LSM_POLICY_LOAD is supported
+ * @buf: user-supplied buffer in the form "<ns>\0<policy>"
+ *        <ns> is the namespace to load the policy into (empty string for root)
+ *        <policy> is the policy to load
+ * @size: size of @buf
+ * @flags: reserved for future uses; must be zero
+ *
+ * Returns: 0 on success, negative value on error
+ */
+static int apparmor_lsm_config_system_policy(u32 lsm_id, u32 op, void __user *buf,
+				      size_t size, u32 flags)
+{
+	loff_t pos = 0; // Partial writing is not currently supported
+	char name[256];
+	long name_size;
+
+	if (op != LSM_POLICY_LOAD || flags)
+		return -EOPNOTSUPP;
+
+	name_size = strncpy_from_user(name, buf, 256);
+	if (name_size < 0)
+		return name_size;
+	else if (name_size == 256)
+		return -E2BIG;
+
+	return aa_profile_load_ns_name(name, name_size, buf + name_size + 1,
+				       size - name_size - 1, &pos);
+}
+
+
 #ifdef CONFIG_NETWORK_SECMARK
 /**
  * apparmor_socket_sock_rcv_skb - check perms before associating skb to sk
@@ -1483,6 +1550,10 @@ static struct security_hook_list apparmor_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(socket_getsockopt, apparmor_socket_getsockopt),
 	LSM_HOOK_INIT(socket_setsockopt, apparmor_socket_setsockopt),
 	LSM_HOOK_INIT(socket_shutdown, apparmor_socket_shutdown),
+
+	LSM_HOOK_INIT(lsm_config_self_policy, apparmor_lsm_config_self_policy),
+	LSM_HOOK_INIT(lsm_config_system_policy,
+		      apparmor_lsm_config_system_policy),
 #ifdef CONFIG_NETWORK_SECMARK
 	LSM_HOOK_INIT(socket_sock_rcv_skb, apparmor_socket_sock_rcv_skb),
 #endif
-- 
2.48.1



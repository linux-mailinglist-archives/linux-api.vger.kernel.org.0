Return-Path: <linux-api+bounces-5072-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B3EDBCD42B
	for <lists+linux-api@lfdr.de>; Fri, 10 Oct 2025 15:27:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 048BF4FD6B4
	for <lists+linux-api@lfdr.de>; Fri, 10 Oct 2025 13:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE3DE288C25;
	Fri, 10 Oct 2025 13:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="L4o+0sYf"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99EE9284893;
	Fri, 10 Oct 2025 13:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760102829; cv=none; b=byOPyRhip8MWwIk8EcNIBTT6ENLcZtf6ApR3JmNqcVQYgWd+7eXNYAM51ofWnazmMqk8iUK57fwkw8CqhdhIFbJ9Fc1zvObzjeTLuUtm3ofy39XSrHawXEWZoJM4Iv83mZZF2CTocIu8fe9h4jsqrL+lZQ2sSqjJrQN+CKy2qrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760102829; c=relaxed/simple;
	bh=Sqju36u31Al8dusP1hKtjOry3JIoKP8tolpuNZ+8w6M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QWfVCHqH1qXuUN4tNR2otObbC4UVlOussPrcdW/pGAsHo7GO7nO363I73RuCFz/iH9I0C5OKCZx8JX8WLFgvFDptc6oydfzOyPhOtrdG7gXlQywmyTJ46Nbj/91QN2gk0a/k6n/c/fPMePfcXHuqTtReEbrYLIrB65+Pa9m3CQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=L4o+0sYf; arc=none smtp.client-ip=185.125.188.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from sec2-plucky-amd64.. (176-136-128-80.abo.bbox.fr [176.136.128.80])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id E53B542ABE;
	Fri, 10 Oct 2025 13:26:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1760102820;
	bh=21Ej0bxpFACoQIzpnvpszcLFxcd87MwXCKY1pXAfvF4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type;
	b=L4o+0sYfURLqDWp6TBlMuUndaln4B9ioTdQ0F8OHohmz8C0MBMkaYEKv5rs4jIZMo
	 w6R3yHNzapTLKmqYey8oj1VouJwpTbSZS+U1bUp+4a1raDaWu5GXleT22sneLBV86Y
	 DQerpmnTTbfPVKP7HEI+mEg6Rlppb7bwh/YUeo5uEzr6xr0ym20AKw4MdigGtI96od
	 A75SxEhX2BKeFjpHzrEvo1HvVnwRA+BBRF7u13HD+YXRWBSyfh7xmURgZI5PT6YHBZ
	 wtFQ1vdvjkTQer4HqpQdCQyxm9NNjhneq92KuQ90cQs6B0CoHKEYkNxgTELSdKp48h
	 Pp/QAZScv8q8poHxZT489hjSfdWC4DdrSH/9aA0dhYqE3d+u/vzTYFRzknqCGlYh30
	 IWrDKvIhoL1FpE77XLdKQPrNxhwUu/upXA0MB3Dq8pHx2q3E/vY2uOG967OtlieNWJ
	 U9hqTtrm8VxKtz94PwjvOYyM3qAyIV1KU7Te9qCWwlskUiqSFzuSBdIeYdQvN3V9Jc
	 AOTTka5yZcvgMqKnH6kTA1fkU8rXqMCVmAqm8r8ranbZgnHOk/7+nN2SgZA2L0Iulk
	 EiUit8hRLwZr53X/hJWZMB0AkpGYCP/gOn/36sZRtRDMTYF8EEKnc4L9eonzlOQC/e
	 YfB/vM2BvHbt7nslsEIhRoZ0=
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
Subject: [PATCH v6 5/5] Smack: add support for lsm_config_self_policy and lsm_config_system_policy
Date: Fri, 10 Oct 2025 15:25:32 +0200
Message-ID: <20251010132610.12001-6-maxime.belair@canonical.com>
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

Enable users to manage Smack policies through the new hooks
lsm_config_self_policy and lsm_config_system_policy.

lsm_config_self_policy allows adding Smack policies for the current cred.
For now it remains restricted to CAP_MAC_ADMIN.

lsm_config_system_policy allows adding globabl Smack policies. This is
restricted to CAP_MAC_ADMIN.

Signed-off-by: Maxime Bélair <maxime.belair@canonical.com>
---
 security/smack/smack.h     |  8 +++++
 security/smack/smack_lsm.c | 73 ++++++++++++++++++++++++++++++++++++++
 security/smack/smackfs.c   |  2 +-
 3 files changed, 82 insertions(+), 1 deletion(-)

diff --git a/security/smack/smack.h b/security/smack/smack.h
index bf6a6ed3946c..3e3d30dfdcf7 100644
--- a/security/smack/smack.h
+++ b/security/smack/smack.h
@@ -275,6 +275,14 @@ struct smk_audit_info {
 #endif
 };
 
+/*
+ * This function is in smackfs.c
+ */
+ssize_t smk_write_rules_list(struct file *file, const char __user *buf,
+			     size_t count, loff_t *ppos,
+			     struct list_head *rule_list,
+			     struct mutex *rule_lock, int format);
+
 /*
  * These functions are in smack_access.c
  */
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 99833168604e..bf4bb2242768 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -5027,6 +5027,76 @@ static int smack_uring_cmd(struct io_uring_cmd *ioucmd)
 
 #endif /* CONFIG_IO_URING */
 
+/**
+ * smack_lsm_config_system_policy - Configure a system smack policy
+ * @op: operation to perform. Currently, only LSM_POLICY_LOAD is supported
+ * @buf: User-supplied buffer in the form "<fmt><policy>"
+ *        <fmt> is the 1-byte format of <policy>
+ *        <policy> is the policy to load
+ * @size: size of @buf
+ * @flags: reserved for future use; must be zero
+ *
+ * Returns: number of written rules on success, negative value on error
+ */
+static int smack_lsm_config_system_policy(u32 op, void __user *buf, size_t size,
+					  u32 flags)
+{
+	loff_t pos = 0;
+	u8 fmt;
+
+	if (op != LSM_POLICY_LOAD || flags)
+		return -EOPNOTSUPP;
+
+	if (size < 2)
+		return -EINVAL;
+
+	if (get_user(fmt, (uint8_t *)buf))
+		return -EFAULT;
+
+	return smk_write_rules_list(NULL, buf + 1, size - 1, &pos, NULL, NULL, fmt);
+}
+
+/**
+ * smack_lsm_config_self_policy - Configure a smack policy for the current cred
+ * @op: operation to perform. Currently, only LSM_POLICY_LOAD is supported
+ * @buf: User-supplied buffer in the form "<fmt><policy>"
+ *        <fmt> is the 1-byte format of <policy>
+ *        <policy> is the policy to load
+ * @size: size of @buf
+ * @flags: reserved for future use; must be zero
+ *
+ * Returns: number of written rules on success, negative value on error
+ */
+static int smack_lsm_config_self_policy(u32 op, void __user *buf, size_t size,
+					u32 flags)
+{
+	loff_t pos = 0;
+	u8 fmt;
+	struct task_smack *tsp;
+
+	if (op != LSM_POLICY_LOAD || flags)
+		return -EOPNOTSUPP;
+
+	if (size < 2)
+		return -EINVAL;
+
+	if (get_user(fmt, (uint8_t *)buf))
+		return -EFAULT;
+	/**
+	 * smk_write_rules_list could be used to gain privileges.
+	 * This function is thus restricted to CAP_MAC_ADMIN.
+	 * TODO: Ensure that the new rule does not give extra privileges
+	 * before dropping this CAP_MAC_ADMIN check.
+	 */
+	if (!capable(CAP_MAC_ADMIN))
+		return -EPERM;
+
+
+	tsp = smack_cred(current_cred());
+	return smk_write_rules_list(NULL, buf + 1, size - 1, &pos, &tsp->smk_rules,
+				    &tsp->smk_rules_lock, fmt);
+}
+
 struct lsm_blob_sizes smack_blob_sizes __ro_after_init = {
 	.lbs_cred = sizeof(struct task_smack),
 	.lbs_file = sizeof(struct smack_known *),
@@ -5203,6 +5273,9 @@ static struct security_hook_list smack_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(uring_sqpoll, smack_uring_sqpoll),
 	LSM_HOOK_INIT(uring_cmd, smack_uring_cmd),
 #endif
+	LSM_HOOK_INIT(lsm_config_self_policy, smack_lsm_config_self_policy),
+	LSM_HOOK_INIT(lsm_config_system_policy, smack_lsm_config_system_policy),
+
 };
 
 
diff --git a/security/smack/smackfs.c b/security/smack/smackfs.c
index 90a67e410808..ed1814588d56 100644
--- a/security/smack/smackfs.c
+++ b/security/smack/smackfs.c
@@ -441,7 +441,7 @@ static ssize_t smk_parse_long_rule(char *data, struct smack_parsed_rule *rule,
  *	"subject<whitespace>object<whitespace>
  *	 acc_enable<whitespace>acc_disable[<whitespace>...]"
  */
-static ssize_t smk_write_rules_list(struct file *file, const char __user *buf,
+ssize_t smk_write_rules_list(struct file *file, const char __user *buf,
 					size_t count, loff_t *ppos,
 					struct list_head *rule_list,
 					struct mutex *rule_lock, int format)
-- 
2.48.1



Return-Path: <linux-api+bounces-5075-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1C40BCD496
	for <lists+linux-api@lfdr.de>; Fri, 10 Oct 2025 15:35:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55B0C420155
	for <lists+linux-api@lfdr.de>; Fri, 10 Oct 2025 13:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 776782F39BC;
	Fri, 10 Oct 2025 13:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="ArKy1PzE"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EDC92F25F6;
	Fri, 10 Oct 2025 13:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760103306; cv=none; b=bPdq8a5Rcb2TYw/MHOTsRaX4KLC1ppan87B29FV0QUIHvaI/URN/FGhxZ0alZrcvzN0eYqpRgy28WKh75TO3RMNaZfGZPK58vkt+NityktBsohMFoJDypJVbXhP8POIWscfCtzRV7QwuDnBNEILgZeph3AwUaBUdfIS3g0ZBTPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760103306; c=relaxed/simple;
	bh=86IupXS7vJybzKeEqcu/apTr9ZsblsOH7kVcn69OVmk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eic0vHa3x7ehr3k5QapfDDPeeuNM7oA5573ho76QjZFk3Qs5Tfq5fyfXwBAMjgga+HJ/mnIWnbI2qg47kOTx31d3C+hC4zAsk8JjOcRgg0RR4K0sNAu2fVSYDRjqcbWkxqkZjzi1ZFCUHfH+LNyXV8Mi8fseDQOv6TwRqOUhIF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=ArKy1PzE; arc=none smtp.client-ip=185.125.188.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from sec2-plucky-amd64.. (176-136-128-80.abo.bbox.fr [176.136.128.80])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 7B78142ABC;
	Fri, 10 Oct 2025 13:26:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1760102819;
	bh=M2m06O/92yzIbKYKZQJQNk7bnRhXFzF181i5f3dRy1I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type;
	b=ArKy1PzETyeScQJJzKJyen23qk0N1d1UxX6gCuL1Z6SfQ9xAepj+LzfMLzMsGIoGZ
	 NTzbR1evH4BO43kzTXVTKphtuON1hU9d0KEe2sEy+ROAOOhtidmEaayAn4f+O3coZs
	 6gLXpUZdxlEwg+dU9wDdFuLr3wg+CW4ITFKO+FUVbbowGBzYJLlsFDd6Y++cLn1Gtl
	 vHaV6HHyvAZc2zWbCtPP79cgdzfO9FC7X7QSMstSLuC6dZi0xuoLOWTuJFfND5vKFv
	 IcwZ5I0EfnifurlCsODXltkiw2QG6imvjQrZx2nKfU2ikW/IFfRfL59kyl1HO2wrIB
	 LjWcOoEYokpItnkr1eocttDWvX8UacM2Ydo/bY2orKKHX3unPR4ZkG8UigF4nxqfKB
	 Pzhvg+we92xYBlHEbRCF9Nx4LgNJQ2HmctdI2sV5pZjTy/05RmPhn3EsP9rK3emP9h
	 nmNT5q4fGxp+bU6nW/iLKyDxusf1krY6iTj/bYkBK0pW0e3NTUDlzEnym5Sanz3ykT
	 ktCjwAYkbt6i/Rpx8NypYWokBo+MUe1ZR9vV9bJnDgRLylMF0CNtWeFjUKoegbLuTE
	 vxdesh9D1QuzGL5IeO7R6aJSb/eYVMIBF5rlZAaUm3fkDiGj/CZSe+EqSZM4P7K051
	 7wSKv/qqwUlE6GUXmUrZf3HY=
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
Subject: [PATCH v6 4/5] SELinux: add support for lsm_config_system_policy
Date: Fri, 10 Oct 2025 15:25:31 +0200
Message-ID: <20251010132610.12001-5-maxime.belair@canonical.com>
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

Enable users to manage SELinux policies through the new hook
lsm_config_system_policy. This feature is restricted to CAP_MAC_ADMIN.

Signed-off-by: Maxime Bélair <maxime.belair@canonical.com>
---
 security/selinux/hooks.c            | 27 +++++++++++++++++++++++++++
 security/selinux/include/security.h |  7 +++++++
 security/selinux/selinuxfs.c        | 16 ++++++++++++----
 3 files changed, 46 insertions(+), 4 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index e7a7dcab81db..3d14d4e47937 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -7196,6 +7196,31 @@ static int selinux_uring_allowed(void)
 }
 #endif /* CONFIG_IO_URING */
 
+/**
+ * selinux_lsm_config_system_policy - Manage a LSM policy
+ * @op: operation to perform. Currently, only LSM_POLICY_LOAD is supported
+ * @buf: User-supplied buffer
+ * @size: size of @buf
+ * @flags: reserved for future use; must be zero
+ *
+ * Returns: number of written rules on success, negative value on error
+ */
+static int selinux_lsm_config_system_policy(u32 op, void __user *buf,
+					    size_t size, u32 flags)
+{
+	loff_t pos = 0;
+
+	if (op != LSM_POLICY_LOAD || flags)
+		return -EOPNOTSUPP;
+
+	if (!selinux_null.dentry || !selinux_null.dentry->d_sb ||
+	    !selinux_null.dentry->d_sb->s_fs_info)
+		return -ENODEV;
+
+	return __sel_write_load(selinux_null.dentry->d_sb->s_fs_info, buf, size,
+				&pos);
+}
+
 static const struct lsm_id selinux_lsmid = {
 	.name = "selinux",
 	.id = LSM_ID_SELINUX,
@@ -7499,6 +7524,8 @@ static struct security_hook_list selinux_hooks[] __ro_after_init = {
 #ifdef CONFIG_PERF_EVENTS
 	LSM_HOOK_INIT(perf_event_alloc, selinux_perf_event_alloc),
 #endif
+	LSM_HOOK_INIT(lsm_config_system_policy, selinux_lsm_config_system_policy),
+
 };
 
 static __init int selinux_init(void)
diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
index e7827ed7be5f..7b779ea43cc3 100644
--- a/security/selinux/include/security.h
+++ b/security/selinux/include/security.h
@@ -389,7 +389,14 @@ struct selinux_kernel_status {
 extern void selinux_status_update_setenforce(bool enforcing);
 extern void selinux_status_update_policyload(u32 seqno);
 extern void selinux_complete_init(void);
+
+struct selinux_fs_info;
+
 extern struct path selinux_null;
+extern ssize_t __sel_write_load(struct selinux_fs_info *fsi,
+				const char __user *buf, size_t count,
+				loff_t *ppos);
+
 extern void selnl_notify_setenforce(int val);
 extern void selnl_notify_policyload(u32 seqno);
 extern int selinux_nlmsg_lookup(u16 sclass, u16 nlmsg_type, u32 *perm);
diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index 47480eb2189b..1f7e611d8300 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -567,11 +567,11 @@ static int sel_make_policy_nodes(struct selinux_fs_info *fsi,
 	return ret;
 }
 
-static ssize_t sel_write_load(struct file *file, const char __user *buf,
-			      size_t count, loff_t *ppos)
+ssize_t __sel_write_load(struct selinux_fs_info *fsi,
+			 const char __user *buf, size_t count,
+			 loff_t *ppos)
 
 {
-	struct selinux_fs_info *fsi;
 	struct selinux_load_state load_state;
 	ssize_t length;
 	void *data = NULL;
@@ -605,7 +605,6 @@ static ssize_t sel_write_load(struct file *file, const char __user *buf,
 		pr_warn_ratelimited("SELinux: failed to load policy\n");
 		goto out;
 	}
-	fsi = file_inode(file)->i_sb->s_fs_info;
 	length = sel_make_policy_nodes(fsi, load_state.policy);
 	if (length) {
 		pr_warn_ratelimited("SELinux: failed to initialize selinuxfs\n");
@@ -626,6 +625,15 @@ static ssize_t sel_write_load(struct file *file, const char __user *buf,
 	return length;
 }
 
+static ssize_t sel_write_load(struct file *file, const char __user *buf,
+			      size_t count, loff_t *ppos)
+{
+	struct selinux_fs_info *fsi = file_inode(file)->i_sb->s_fs_info;
+
+	return __sel_write_load(fsi, buf, count, ppos);
+}
+
+
 static const struct file_operations sel_load_ops = {
 	.write		= sel_write_load,
 	.llseek		= generic_file_llseek,
-- 
2.48.1



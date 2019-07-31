Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 587277D0DC
	for <lists+linux-api@lfdr.de>; Thu,  1 Aug 2019 00:19:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729651AbfGaWSb (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 31 Jul 2019 18:18:31 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:49995 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731395AbfGaWRb (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 31 Jul 2019 18:17:31 -0400
Received: by mail-pf1-f201.google.com with SMTP id 145so44177225pfw.16
        for <linux-api@vger.kernel.org>; Wed, 31 Jul 2019 15:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Ogy4z5xXdkGcZVx/gotBD44dFgIvUZxytASg1dmnrz4=;
        b=Bajk5gYeO0raa2iJAXLUTeo1rNux2thWTyxy5cP2BZX9rVUFcLLwBM1Ihyr4IW6Uxu
         OVe2hKqMjonh2PlJah6B/xRvCxOEBYAVBGbGtG5SxGXbvgbox/ljX9f23uTjmk8CdtHj
         OpACdBgg8QTDRBPMzNVaG3NusYWPWtzuSDBMG1K3yU06iS9f0IVwyo5+DUjxp1ZaqLKn
         2PqUsKDMn3y2VNU/ELITmp+dzRb2ku3sU7bSFIAZC3m3mAJLzfVbP0Edc+IQpH/qk47X
         2UowsAKC5Wju2BwdPCp4ZZhOFCQRE0tSdOQOXnHroYpPv2eDlt8O+buvUZBVcS1GIREQ
         Qz/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Ogy4z5xXdkGcZVx/gotBD44dFgIvUZxytASg1dmnrz4=;
        b=mj1lDvjAP7WoH3U+87rKxYAFDLZ0NPFPvVfQmtwJzsqvRpv01BnNLQWwCC+c9bk309
         LvC6IMwHmvlsvfgGdT97OGdmTpzGQnlT9c6WIF5Ol1NPcptOQP7+qjKdPHwul45Zs9TA
         omVtfA0Zp5roui0jBD1KxcFf6qvClWARZu74RM++G+4Wo8IpCm4+xz3n6bTEk7qDufJ4
         FbXRBIr/0I8HupfnvEZVbbzMzmUKUGgPQU9DlWUCxrsrOJ5bRnCNo4ArlhXgD3bi2kaj
         mJ+jYNB1CiqjNSDCzZ5groA+pvtHhYKgiruDlTEs3NWzQCrwX5l2OK4+ImK39N2tCyRl
         ggJQ==
X-Gm-Message-State: APjAAAWXkdNA8DvOOO3S33nZdzhzXqFZCTENgzro1k81Pxri7o+z0YV3
        mIGEBR4KGEeq3Z+TGYw4QaJxf/XXAI0BEAMhEDoS5w==
X-Google-Smtp-Source: APXvYqxZSsn4zOtqAMIbC8IIUJ8BgotlRvfyfmjrcz+Kzfba+ryUsIe0e+54iON0Ue9ORs3wFILRx4yWxTev9k6Xexi4Gg==
X-Received: by 2002:a63:6c7:: with SMTP id 190mr114475501pgg.7.1564611450073;
 Wed, 31 Jul 2019 15:17:30 -0700 (PDT)
Date:   Wed, 31 Jul 2019 15:16:13 -0700
In-Reply-To: <20190731221617.234725-1-matthewgarrett@google.com>
Message-Id: <20190731221617.234725-26-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190731221617.234725-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
Subject: [PATCH V37 25/29] kexec: Allow kexec_file() with appropriate IMA
 policy when locked down
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Matthew Garrett <matthewgarrett@google.com>,
        Matthew Garrett <mjg59@google.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Systems in lockdown mode should block the kexec of untrusted kernels.
For x86 and ARM we can ensure that a kernel is trustworthy by validating
a PE signature, but this isn't possible on other architectures. On those
platforms we can use IMA digital signatures instead. Add a function to
determine whether IMA has or will verify signatures for a given event type,
and if so permit kexec_file() even if the kernel is otherwise locked down.
This is restricted to cases where CONFIG_INTEGRITY_TRUSTED_KEYRING is set
in order to prevent an attacker from loading additional keys at runtime.

Signed-off-by: Matthew Garrett <mjg59@google.com>
Acked-by: Mimi Zohar <zohar@linux.ibm.com>
Cc: Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Cc: linux-integrity@vger.kernel.org
---
 include/linux/ima.h                 |  9 ++++++
 kernel/kexec_file.c                 | 12 +++++--
 security/integrity/ima/ima.h        |  2 ++
 security/integrity/ima/ima_main.c   |  2 +-
 security/integrity/ima/ima_policy.c | 50 +++++++++++++++++++++++++++++
 5 files changed, 72 insertions(+), 3 deletions(-)

diff --git a/include/linux/ima.h b/include/linux/ima.h
index a20ad398d260..1c37f17f7203 100644
--- a/include/linux/ima.h
+++ b/include/linux/ima.h
@@ -131,4 +131,13 @@ static inline int ima_inode_removexattr(struct dentry *dentry,
 	return 0;
 }
 #endif /* CONFIG_IMA_APPRAISE */
+
+#if defined(CONFIG_IMA_APPRAISE) && defined(CONFIG_INTEGRITY_TRUSTED_KEYRING)
+extern bool ima_appraise_signature(enum kernel_read_file_id func);
+#else
+static inline bool ima_appraise_signature(enum kernel_read_file_id func)
+{
+	return false;
+}
+#endif /* CONFIG_IMA_APPRAISE && CONFIG_INTEGRITY_TRUSTED_KEYRING */
 #endif /* _LINUX_IMA_H */
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index dd06f1070d66..13c9960a5860 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -228,9 +228,17 @@ kimage_file_prepare_segments(struct kimage *image, int kernel_fd, int initrd_fd,
 			goto out;
 		}
 
-		ret = security_locked_down(LOCKDOWN_KEXEC);
-		if (ret)
+		ret = 0;
+
+		/* If IMA is guaranteed to appraise a signature on the kexec
+		 * image, permit it even if the kernel is otherwise locked
+		 * down.
+		 */
+		if (!ima_appraise_signature(READING_KEXEC_IMAGE) &&
+		    security_locked_down(LOCKDOWN_KEXEC)) {
+			ret = -EPERM;
 			goto out;
+		}
 
 		break;
 
diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 011b91c79351..64dcb11cf444 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -113,6 +113,8 @@ struct ima_kexec_hdr {
 	u64 count;
 };
 
+extern const int read_idmap[];
+
 #ifdef CONFIG_HAVE_IMA_KEXEC
 void ima_load_kexec_buffer(void);
 #else
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 584019728660..b9f57503af2c 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -502,7 +502,7 @@ int ima_read_file(struct file *file, enum kernel_read_file_id read_id)
 	return 0;
 }
 
-static const int read_idmap[READING_MAX_ID] = {
+const int read_idmap[READING_MAX_ID] = {
 	[READING_FIRMWARE] = FIRMWARE_CHECK,
 	[READING_FIRMWARE_PREALLOC_BUFFER] = FIRMWARE_CHECK,
 	[READING_MODULE] = MODULE_CHECK,
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 6df7f641ff66..827f1e33fe86 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -1456,3 +1456,53 @@ int ima_policy_show(struct seq_file *m, void *v)
 	return 0;
 }
 #endif	/* CONFIG_IMA_READ_POLICY */
+
+#if defined(CONFIG_IMA_APPRAISE) && defined(CONFIG_INTEGRITY_TRUSTED_KEYRING)
+/*
+ * ima_appraise_signature: whether IMA will appraise a given function using
+ * an IMA digital signature. This is restricted to cases where the kernel
+ * has a set of built-in trusted keys in order to avoid an attacker simply
+ * loading additional keys.
+ */
+bool ima_appraise_signature(enum kernel_read_file_id id)
+{
+	struct ima_rule_entry *entry;
+	bool found = false;
+	enum ima_hooks func;
+
+	if (id >= READING_MAX_ID)
+		return false;
+
+	func = read_idmap[id] ?: FILE_CHECK;
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(entry, ima_rules, list) {
+		if (entry->action != APPRAISE)
+			continue;
+
+		/*
+		 * A generic entry will match, but otherwise require that it
+		 * match the func we're looking for
+		 */
+		if (entry->func && entry->func != func)
+			continue;
+
+		/*
+		 * We require this to be a digital signature, not a raw IMA
+		 * hash.
+		 */
+		if (entry->flags & IMA_DIGSIG_REQUIRED)
+			found = true;
+
+		/*
+		 * We've found a rule that matches, so break now even if it
+		 * didn't require a digital signature - a later rule that does
+		 * won't override it, so would be a false positive.
+		 */
+		break;
+	}
+
+	rcu_read_unlock();
+	return found;
+}
+#endif /* CONFIG_IMA_APPRAISE && CONFIG_INTEGRITY_TRUSTED_KEYRING */
-- 
2.22.0.770.g0f2c4a37fd-goog


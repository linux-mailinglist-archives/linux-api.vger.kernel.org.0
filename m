Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F2FAC6D558
	for <lists+linux-api@lfdr.de>; Thu, 18 Jul 2019 21:48:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391573AbfGRTqs (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 18 Jul 2019 15:46:48 -0400
Received: from mail-qk1-f201.google.com ([209.85.222.201]:57299 "EHLO
        mail-qk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391441AbfGRToZ (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 18 Jul 2019 15:44:25 -0400
Received: by mail-qk1-f201.google.com with SMTP id j81so24056233qke.23
        for <linux-api@vger.kernel.org>; Thu, 18 Jul 2019 12:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=f/RnEfWSrg+mjsb2cXMX4L7C/xNmjjOSgJcVU/cQXL4=;
        b=jsRInamEwvOW5gKVCPS6gAzLtaGfVBCHyt8GuZv9y/xonXNaTWjlDWyFRdEgikwvLi
         cqfuqEGIrHDApAZ+ysnScHx3BzvuZhJTkvlWbvXW6slZFCFZi5ys5kdQV27WLcB4HIG6
         5MgeZTgdoXbZacSFO0WDSN/WGEWkdZmIH7KKxmtyyUT12+w0/AL6N11eh7mwcq+livto
         DxlLdf1fOlHRcKsjg2IfnOAR4K6/0qWUPiGi//ucqWtIAooXzQb7AkF0TCMLewCJR832
         65FwlNREl7Mo/MVTYFwOBOM7CMnn5xO8NYd0MDaNmsG+IddKdneQQYOmHWOmzeKJXdcU
         5yJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=f/RnEfWSrg+mjsb2cXMX4L7C/xNmjjOSgJcVU/cQXL4=;
        b=TrZOA/oNa8BO10XhIZzdu3Z3p1HJ6AZnd8DM+FLS1X+L8seuAFSN/DdtPvrw8k4CxB
         AqcLAYeRiLtLZT16lNbg0cf/TnjLHhn5OEniadvb3GS4oyK+N1f4q4l2jw7BOW4LUJGU
         0mTsQhrv+dGqhBF+N4VfDfI3IUQXwKpy7/ylECNK+JP+BlnQggu00I8g+zuqnY23Hgku
         Vtpq23UVNGbmqQOd0L/MyrOhMg/yYnLrOue80gFpU/aReKnEeboJkGLxetDkQTmXLMQI
         t9gQD2XQQdUszRFy4lL5wrTNZgokUttiRzF9QzqoZKTYajNsmXB4LsCTcrHuNd1wq8da
         W3iw==
X-Gm-Message-State: APjAAAXNRq9QlKA+TOpGHZdKk6PIqSTALSBuwUCAb6q3ZkVqF95xiIx9
        fWt8y4i/+whIHBy5NjY/nDR+78EqSlur3BMF8PSYzA==
X-Google-Smtp-Source: APXvYqw+JsRBNHiAanPLyriUj70/+WJ5ZrVT82KeDFFh1TY+pdCGaJVMixIOL+mU07DfwWxGfCpqCo4opDBtRLVdkbbOiQ==
X-Received: by 2002:ac8:3f81:: with SMTP id d1mr34152373qtk.5.1563479063836;
 Thu, 18 Jul 2019 12:44:23 -0700 (PDT)
Date:   Thu, 18 Jul 2019 12:43:48 -0700
In-Reply-To: <20190718194415.108476-1-matthewgarrett@google.com>
Message-Id: <20190718194415.108476-3-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190718194415.108476-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.22.0.510.g264f2c817a-goog
Subject: [PATCH V36 02/29] security: Add a "locked down" LSM hook
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Matthew Garrett <matthewgarrett@google.com>,
        Matthew Garrett <mjg59@google.com>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Add a mechanism to allow LSMs to make a policy decision around whether
kernel functionality that would allow tampering with or examining the
runtime state of the kernel should be permitted.

Signed-off-by: Matthew Garrett <mjg59@google.com>
Acked-by: Kees Cook <keescook@chromium.org>
---
 include/linux/lsm_hooks.h |  2 ++
 include/linux/security.h  | 32 ++++++++++++++++++++++++++++++++
 security/security.c       |  6 ++++++
 3 files changed, 40 insertions(+)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index aebb0e032072..29c22cf40113 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -1807,6 +1807,7 @@ union security_list_options {
 	int (*bpf_prog_alloc_security)(struct bpf_prog_aux *aux);
 	void (*bpf_prog_free_security)(struct bpf_prog_aux *aux);
 #endif /* CONFIG_BPF_SYSCALL */
+	int (*locked_down)(enum lockdown_reason what);
 };
 
 struct security_hook_heads {
@@ -2046,6 +2047,7 @@ struct security_hook_heads {
 	struct hlist_head bpf_prog_alloc_security;
 	struct hlist_head bpf_prog_free_security;
 #endif /* CONFIG_BPF_SYSCALL */
+	struct hlist_head locked_down;
 } __randomize_layout;
 
 /*
diff --git a/include/linux/security.h b/include/linux/security.h
index 66a2fcbe6ab0..c2b1204e8e26 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -77,6 +77,33 @@ enum lsm_event {
 	LSM_POLICY_CHANGE,
 };
 
+/*
+ * These are reasons that can be passed to the security_locked_down()
+ * LSM hook. Lockdown reasons that protect kernel integrity (ie, the
+ * ability for userland to modify kernel code) are placed before
+ * LOCKDOWN_INTEGRITY_MAX.  Lockdown reasons that protect kernel
+ * confidentiality (ie, the ability for userland to extract
+ * information from the running kernel that would otherwise be
+ * restricted) are placed before LOCKDOWN_CONFIDENTIALITY_MAX.
+ *
+ * LSM authors should note that the semantics of any given lockdown
+ * reason are not guaranteed to be stable - the same reason may block
+ * one set of features in one kernel release, and a slightly different
+ * set of features in a later kernel release. LSMs that seek to expose
+ * lockdown policy at any level of granularity other than "none",
+ * "integrity" or "confidentiality" are responsible for either
+ * ensuring that they expose a consistent level of functionality to
+ * userland, or ensuring that userland is aware that this is
+ * potentially a moving target. It is easy to misuse this information
+ * in a way that could break userspace. Please be careful not to do
+ * so.
+ */
+enum lockdown_reason {
+	LOCKDOWN_NONE,
+	LOCKDOWN_INTEGRITY_MAX,
+	LOCKDOWN_CONFIDENTIALITY_MAX,
+};
+
 /* These functions are in security/commoncap.c */
 extern int cap_capable(const struct cred *cred, struct user_namespace *ns,
 		       int cap, unsigned int opts);
@@ -393,6 +420,7 @@ void security_inode_invalidate_secctx(struct inode *inode);
 int security_inode_notifysecctx(struct inode *inode, void *ctx, u32 ctxlen);
 int security_inode_setsecctx(struct dentry *dentry, void *ctx, u32 ctxlen);
 int security_inode_getsecctx(struct inode *inode, void **ctx, u32 *ctxlen);
+int security_locked_down(enum lockdown_reason what);
 #else /* CONFIG_SECURITY */
 
 static inline int call_blocking_lsm_notifier(enum lsm_event event, void *data)
@@ -1205,6 +1233,10 @@ static inline int security_inode_getsecctx(struct inode *inode, void **ctx, u32
 {
 	return -EOPNOTSUPP;
 }
+static inline int security_locked_down(enum lockdown_reason what)
+{
+	return 0;
+}
 #endif	/* CONFIG_SECURITY */
 
 #ifdef CONFIG_SECURITY_NETWORK
diff --git a/security/security.c b/security/security.c
index 90f1e291c800..ce6c945bf347 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2392,3 +2392,9 @@ void security_bpf_prog_free(struct bpf_prog_aux *aux)
 	call_void_hook(bpf_prog_free_security, aux);
 }
 #endif /* CONFIG_BPF_SYSCALL */
+
+int security_locked_down(enum lockdown_reason what)
+{
+	return call_int_hook(locked_down, 0, what);
+}
+EXPORT_SYMBOL(security_locked_down);
-- 
2.22.0.510.g264f2c817a-goog


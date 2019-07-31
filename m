Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 827BC7D106
	for <lists+linux-api@lfdr.de>; Thu,  1 Aug 2019 00:19:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731157AbfGaWQd (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 31 Jul 2019 18:16:33 -0400
Received: from mail-vk1-f202.google.com ([209.85.221.202]:43666 "EHLO
        mail-vk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731143AbfGaWQc (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 31 Jul 2019 18:16:32 -0400
Received: by mail-vk1-f202.google.com with SMTP id j140so29949691vke.10
        for <linux-api@vger.kernel.org>; Wed, 31 Jul 2019 15:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=WTiH4YTrH3kpcM05qpaK8fMoTjQf+8p0ghLlYf37sU8=;
        b=DERqYxz9wX0gHlQoGUJX0WknuNtCqhZOzrWycP+02aBufd6T659MgVCUVR5uC5/ByF
         v6eRY622zylM2F6tr3INtUyu+wE7R/907q/SSHHYUIYJRqc0m+zkLAX1/XHQjQLjy8Ss
         sE8JzGxbw+jOhyOLmLNF3PMNS4G0zEjzA1gw5Hq4gc6O8YHPliYN91vG8cQQJBwaf+2S
         u+3Ax6g7to46lAJRbMq7lMSe/jBas85IdWh6vxqiedomVTSl8mOvelUC3XrsmFtJkk3F
         nK1T4QgBHrtZAzA3LY5RSF+fLp1J2p0Lvog2tekRVJxNavlh4KolInczFKp5SP1J5z4c
         BK3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=WTiH4YTrH3kpcM05qpaK8fMoTjQf+8p0ghLlYf37sU8=;
        b=a44AwQycqT7vA/qottikrjgq1KmOvlvWJ/70b28/xA1Ox42g4UYkwNofP9TMhxJGKM
         lR2j1+L3TMaET8Q/P0zOcCMZ/tpy57EwhFyVipMVLkOmWBbc6bF+O0CW6xH8keHqwOQU
         2AeyV3OGldpIUc7BoF7nokAYJIJat63AQ7qaLvJBPynIKwfOKyxXFBhmeG/la0frfFpD
         Ax7KaRogbLTLd/B6uZEc9CaIjXsfdTT+am/mwMc60LRGq1lvoo1bYff8t7gD7gJ7M0Nq
         f76fnhTladGxCmapPnFFwivbkvX8GpkewkIehZe8yo3wtWmY0aO4HKPvpOguvUUepq4K
         1GrQ==
X-Gm-Message-State: APjAAAW2wOUrGK4g4V3UxvJBDJqGgi8t8uI77TlZnFrJJHBM/TfSyH+T
        rbMmK8XqAtQHW7SfEuexcjga+HCnJyqEZX28Lj8SNQ==
X-Google-Smtp-Source: APXvYqzAe54T0QiTUuxksPpviValfZJ3QvQR/H1/B1wsbrIBwM6cGdu9A0LY0uYRsuLqgvSRg078qub8agvdkMHIxjQx+A==
X-Received: by 2002:a67:f618:: with SMTP id k24mr80982528vso.66.1564611391373;
 Wed, 31 Jul 2019 15:16:31 -0700 (PDT)
Date:   Wed, 31 Jul 2019 15:15:50 -0700
In-Reply-To: <20190731221617.234725-1-matthewgarrett@google.com>
Message-Id: <20190731221617.234725-3-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190731221617.234725-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
Subject: [PATCH V37 02/29] security: Add a "locked down" LSM hook
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Matthew Garrett <matthewgarrett@google.com>,
        Matthew Garrett <mjg59@google.com>,
        Kees Cook <keescook@chromium.org>,
        Casey Schaufler <casey@schaufler-ca.com>
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
Acked-by: Casey Schaufler <casey@schaufler-ca.com>
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
2.22.0.770.g0f2c4a37fd-goog


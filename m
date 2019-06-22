Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF1044F261
	for <lists+linux-api@lfdr.de>; Sat, 22 Jun 2019 02:07:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726357AbfFVAEI (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 21 Jun 2019 20:04:08 -0400
Received: from mail-qt1-f202.google.com ([209.85.160.202]:48534 "EHLO
        mail-qt1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726212AbfFVAEH (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 21 Jun 2019 20:04:07 -0400
Received: by mail-qt1-f202.google.com with SMTP id z5so9771836qth.15
        for <linux-api@vger.kernel.org>; Fri, 21 Jun 2019 17:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=9daZa8/hqWzZuaGJLkwK103skAzbS3nFdoLOu7tsdHI=;
        b=Q/D1El3SijlLetTLADKIIte9tNRO98kykcjbvezzo8iX6ULzwvyyXXdR2qZPh+3i26
         1WbNkZ6l3vwcaw8ME7qaLeDwp41bwD8t/A4G9dsbhAxAbvpREcXGQ5PqicC98CXO/SXo
         8a73xkKgdAoHHhuRTn6JlCmlG9PTKLfbzl/vOxwt9G7grClG0hHLcwxVwxKwvl3J+SEk
         3mevF2DkRMytAztapn/3JDjXUkKUTvfId2XjFQ5pLAYBV0Xq7UVfKkb29LQ9TBVy2oCs
         hz0L+DiU6+PWc2LmT61ysG+fhiMaCTqt+tS+LRej/8oi9MH2EY+0zf/c+80BfhWsCciQ
         JlTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=9daZa8/hqWzZuaGJLkwK103skAzbS3nFdoLOu7tsdHI=;
        b=LNqXWsphBnc2ij7Uvf4fskrOe0v777E/vbtyGt0b6TwrzLCu6FaSPcOV6yz4sCyvG3
         f13UrfTZ53oXdU4lweN8hnAMT1DYC6fn88Lt1c0LDhuNAXZcB7zcnsXcSpvt/eev6sze
         qpsL81pdAwtpRYdUlZv82BHVOYFnZ7KgXSU6Y99V1IBsWmEnOvkW4fyJVtM2kWlwDXk8
         gtvdmUOGZsAC4IaYeXtd/LOTsJcceNifS/MEJelBcjzg9UJPYFpIVaDjQfuiMwDLvs8b
         bJhisuMXOoVr/FRnuaa8t4o5nFCLfRC5IndCnq8lf1e4Q//5JoyOCRbBB8bAIJTaUgsr
         9Blg==
X-Gm-Message-State: APjAAAXwwQTG9+zX5U0YFFL4blmlAEGhOZQBhUiKioB3TKNQJEMunXjg
        PoDActvu1PjT731928sSHx32MFiZONOqcrSj7BHzQQ==
X-Google-Smtp-Source: APXvYqwEm732Qi02MQbmz5tHeH6REx4WGkn9c9y7/nSYBQO4mNr3qvTP2Xoo1l1CqZZadwnLtOwC5reFPVHmU9iHyMc2Ng==
X-Received: by 2002:a05:6214:222:: with SMTP id j2mr45977128qvt.121.1561161846752;
 Fri, 21 Jun 2019 17:04:06 -0700 (PDT)
Date:   Fri, 21 Jun 2019 17:03:31 -0700
In-Reply-To: <20190622000358.19895-1-matthewgarrett@google.com>
Message-Id: <20190622000358.19895-3-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190622000358.19895-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH V34 02/29] security: Add a "locked down" LSM hook
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Matthew Garrett <matthewgarrett@google.com>,
        Matthew Garrett <mjg59@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Add a mechanism to allow LSMs to make a policy decision around whether
kernel functionality that would allow tampering with or examining the
runtime state of the kernel should be permitted.

Signed-off-by: Matthew Garrett <mjg59@google.com>
---
 include/linux/lsm_hooks.h |  2 ++
 include/linux/security.h  | 11 +++++++++++
 security/security.c       |  6 ++++++
 3 files changed, 19 insertions(+)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 66fd1eac7a32..df2aebc99838 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -1790,6 +1790,7 @@ union security_list_options {
 	int (*bpf_prog_alloc_security)(struct bpf_prog_aux *aux);
 	void (*bpf_prog_free_security)(struct bpf_prog_aux *aux);
 #endif /* CONFIG_BPF_SYSCALL */
+	int (*locked_down)(enum lockdown_reason what);
 };
 
 struct security_hook_heads {
@@ -2027,6 +2028,7 @@ struct security_hook_heads {
 	struct hlist_head bpf_prog_alloc_security;
 	struct hlist_head bpf_prog_free_security;
 #endif /* CONFIG_BPF_SYSCALL */
+	struct hlist_head locked_down;
 } __randomize_layout;
 
 /*
diff --git a/include/linux/security.h b/include/linux/security.h
index 1bb6fb2f1523..9eaf02e70707 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -76,6 +76,12 @@ enum lsm_event {
 	LSM_POLICY_CHANGE,
 };
 
+enum lockdown_reason {
+	LOCKDOWN_NONE,
+	LOCKDOWN_INTEGRITY_MAX,
+	LOCKDOWN_CONFIDENTIALITY_MAX,
+};
+
 /* These functions are in security/commoncap.c */
 extern int cap_capable(const struct cred *cred, struct user_namespace *ns,
 		       int cap, unsigned int opts);
@@ -389,6 +395,7 @@ void security_inode_invalidate_secctx(struct inode *inode);
 int security_inode_notifysecctx(struct inode *inode, void *ctx, u32 ctxlen);
 int security_inode_setsecctx(struct dentry *dentry, void *ctx, u32 ctxlen);
 int security_inode_getsecctx(struct inode *inode, void **ctx, u32 *ctxlen);
+int security_locked_down(enum lockdown_reason what);
 #else /* CONFIG_SECURITY */
 
 static inline int call_lsm_notifier(enum lsm_event event, void *data)
@@ -1189,6 +1196,10 @@ static inline int security_inode_getsecctx(struct inode *inode, void **ctx, u32
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
index 487e1f3eb2df..553f50e9a106 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2382,3 +2382,9 @@ void security_bpf_prog_free(struct bpf_prog_aux *aux)
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
2.22.0.410.gd8fdbe21b5-goog


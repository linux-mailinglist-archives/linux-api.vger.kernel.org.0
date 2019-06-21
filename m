Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 225904DEAD
	for <lists+linux-api@lfdr.de>; Fri, 21 Jun 2019 03:23:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726373AbfFUBW0 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 20 Jun 2019 21:22:26 -0400
Received: from mail-qt1-f201.google.com ([209.85.160.201]:36980 "EHLO
        mail-qt1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726225AbfFUBTw (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 20 Jun 2019 21:19:52 -0400
Received: by mail-qt1-f201.google.com with SMTP id g56so6132192qte.4
        for <linux-api@vger.kernel.org>; Thu, 20 Jun 2019 18:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=rLHZlHKZcfbaxVt+EZWYgUOfoYBVDdWFXT/fQo3GFRs=;
        b=AJS9vmKEqoRGrskfpv1ZR/l4YY3R5i1qXYpImrhmSLfic+tVJ7fyxJ0V/2RWzvULhC
         6nnwMuapG8U/xu8WMwR4GZrZP1tMILBBNe9Ar9qfMOoJvAAcrc+MCzx1OafPT3IL92Bl
         SnDt5GKVBU/BIPD6JCy24cNUh0tHmlUcV+I+TwgfRWdP/0AOtyIiYu7fmvFFDqD6xxe5
         VIhJ7oIVDfpoN+kY4sLMfmeO8zOseGMyYgQYFfI8TmdE3REOolSTzT2vNkNUT3jOA2Uk
         sPb8eJWssFndY2Kh/MUG/ZPl7eGDrF3e6BGecIDcM2qVMEhSLy5HrI0ZzvmWoSYaGJ2U
         wCqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=rLHZlHKZcfbaxVt+EZWYgUOfoYBVDdWFXT/fQo3GFRs=;
        b=HQJTLZLYIQS+v8QVAmLjkf6W4XliY+nxWASDAbxr69VWZhPt96WPPVU5lu21AHGfnz
         sJ24uSucW2NwtysLC0exOndHXwSktn/XwfUeXu7/wmnW3Rp7wEFSxC1yucCx47UR61zC
         z/Ehjr5hUfHdl3wtpGsaR3vKnn19J64YFI7AWdpwbIHQgEyfFlQRRELLJ3v3tbUHpEvL
         tytKhMlKMliH1p9oVBz7zP2miYpzPf5lspcKYS5kc6iRjgLKoI/pnDIPpwBoH8UThTQc
         ArlUi7+5DHBYsvT11pCUrPFJHmyT7Gx38CTc0eTE8zee+HeesbqNu2cLB17xfHsb7A2j
         W20g==
X-Gm-Message-State: APjAAAVdJEBMFLJbt9TvfWUQdjYMK+nHukmCjJZTmpK96kQNXZ0YUxYA
        XaFh0kZluC3I39RZjqjDFX0NnVtASdsu9w08Ce0VoQ==
X-Google-Smtp-Source: APXvYqzSODL/JZuXPUX2pex45Zk0jTE/YPkRLNRtv5ZmWjQFG6AT+6VzqSk3DKMP0LVsXjmJq2loJmwE01LU6FXLu8JiXw==
X-Received: by 2002:ae9:f101:: with SMTP id k1mr9349090qkg.337.1561079991648;
 Thu, 20 Jun 2019 18:19:51 -0700 (PDT)
Date:   Thu, 20 Jun 2019 18:19:13 -0700
In-Reply-To: <20190621011941.186255-1-matthewgarrett@google.com>
Message-Id: <20190621011941.186255-3-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190621011941.186255-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH V33 02/30] security: Add a "locked down" LSM hook
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org,
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
index 1bb6fb2f1523..b75941c811e6 100644
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
+int security_is_locked_down(enum lockdown_reason what);
 #else /* CONFIG_SECURITY */
 
 static inline int call_lsm_notifier(enum lsm_event event, void *data)
@@ -1189,6 +1196,10 @@ static inline int security_inode_getsecctx(struct inode *inode, void **ctx, u32
 {
 	return -EOPNOTSUPP;
 }
+static inline int security_is_locked_down(enum lockdown_reason what)
+{
+	return 0;
+}
 #endif	/* CONFIG_SECURITY */
 
 #ifdef CONFIG_SECURITY_NETWORK
diff --git a/security/security.c b/security/security.c
index 2a6672c9e72f..17c17d4d8552 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2378,3 +2378,9 @@ void security_bpf_prog_free(struct bpf_prog_aux *aux)
 	call_void_hook(bpf_prog_free_security, aux);
 }
 #endif /* CONFIG_BPF_SYSCALL */
+
+int security_is_locked_down(enum lockdown_reason what)
+{
+	return call_int_hook(locked_down, 0, what);
+}
+EXPORT_SYMBOL(security_is_locked_down);
-- 
2.22.0.410.gd8fdbe21b5-goog


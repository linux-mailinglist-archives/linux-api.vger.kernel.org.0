Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C7F7C69C49
	for <lists+linux-api@lfdr.de>; Mon, 15 Jul 2019 22:03:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730801AbfGOUCy (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 15 Jul 2019 16:02:54 -0400
Received: from mail-pg1-f201.google.com ([209.85.215.201]:45562 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732159AbfGOT77 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 15 Jul 2019 15:59:59 -0400
Received: by mail-pg1-f201.google.com with SMTP id n3so1256162pgh.12
        for <linux-api@vger.kernel.org>; Mon, 15 Jul 2019 12:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=f/RnEfWSrg+mjsb2cXMX4L7C/xNmjjOSgJcVU/cQXL4=;
        b=O3wJDTMnR9+H3RojAsFfUzZ287o93Xl/j+eBzr9xiJ7GSnL6wH09hswz5HkUJo5TO0
         zSIxrKaO7KxH1NGZU7OTkNwfKk0GwAeKc+MKisrrtdIClB8NctvgLH77qjBC5hKc/QNx
         90e0sVBG4jPv7BUvyWIiRJhlq59sTL/+jDBqvmkICOjjJPFXRubWcJBrG3bYXhIeJMTx
         WcdMWTeTFuVC1gX8BKQw0/+98YB4jYff2uID6Vz0O0yOW0JHGKEGXJHEzUU/7bJ8ovCB
         z1mfyjYl0jF0/UyMq87sSAtqXC8sIdTLF2q38qdJlTGG5wkbomCUUrM9ehm3vT5Nppbc
         C49g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=f/RnEfWSrg+mjsb2cXMX4L7C/xNmjjOSgJcVU/cQXL4=;
        b=o4cc1MjympCe0pCAUeVkNGi7UPBR4q8km7ZAWM1jT6tbMQYwRNBKzRSUain6uAu/ax
         rgoVEI8tP+f1hK3Xy+d08A4NAyzOOKRmtBeTm3147z0Zvo/VGQkftbatHC4LrK3hw3rX
         bOi1oyVK9552b30HiCkXX0l6SJPacaC95gtM5l/SimL2eptY0bTvCUpl+8GxpbU5Gnfz
         gfzXE0G3Ac01uR/3dtawuYrQ7M2OrAJGw0vZQTE+yyAHyJPOK8OOFBq/5DlgUtQTBoo3
         gKhy2C372BOefoNl+ClOn6P3nJdwWPsl0cz5cJMtgYG1DutGfSlV216WC6mItXuK4V/Z
         LgIQ==
X-Gm-Message-State: APjAAAU7ab9XSeI/XqVdhqojC4jc1OVt0pYJjMmUo+xd0hcakMLdPXHk
        sddcn08k1q/1RK4400TYIJFRpRI4PuNG8V5B2aQpiw==
X-Google-Smtp-Source: APXvYqwymNGgJxKQXYrvXHvEFFXosA7/epA7W3EwA368wSAhTsTwzUzG35fXHKoCej+cuEmSBj+RFWvwC9co2fGpXfPAiw==
X-Received: by 2002:a63:1310:: with SMTP id i16mr28407114pgl.187.1563220798084;
 Mon, 15 Jul 2019 12:59:58 -0700 (PDT)
Date:   Mon, 15 Jul 2019 12:59:19 -0700
In-Reply-To: <20190715195946.223443-1-matthewgarrett@google.com>
Message-Id: <20190715195946.223443-3-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190715195946.223443-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.22.0.510.g264f2c817a-goog
Subject: [PATCH V35 02/29] security: Add a "locked down" LSM hook
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


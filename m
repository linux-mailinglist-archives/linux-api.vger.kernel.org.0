Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6070A7089BA
	for <lists+linux-api@lfdr.de>; Thu, 18 May 2023 22:46:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230056AbjERUqF (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 18 May 2023 16:46:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbjERUqF (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 18 May 2023 16:46:05 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4ED0E7D
        for <linux-api@vger.kernel.org>; Thu, 18 May 2023 13:46:03 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 41be03b00d2f7-53487355877so163895a12.1
        for <linux-api@vger.kernel.org>; Thu, 18 May 2023 13:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684442763; x=1687034763;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=os7qSS/m4bQFZnkpMP/L7Wevy8wc/LYfrUdq+QtdCTg=;
        b=hbz4jZakYkUHyJ3bH0I6LaTNC8GCU/1RjtSiOlyFcWLPRiM0C4zw97ggug6R30s+gx
         lkkhZ1kzcfMVrKon/3D4upYuXicpFJn4uNbb2YSz4zFex+m9ZJYNbuplnm9O/kpNqty2
         niA+gRwcR2TpbvR8rqIPCO6/k0oJjQ5I811Ek=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684442763; x=1687034763;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=os7qSS/m4bQFZnkpMP/L7Wevy8wc/LYfrUdq+QtdCTg=;
        b=DFikxs7VZc+3HpDqRr5RRgfCtmdLIKf7DIrBqUZBJbQhf81hshdg/qTre6owlV7lpV
         fDWqX79u4NGk+xo9sDC2ew9UiOt8VxgtA+66DDVa6dPZK9GMXXaez4QHGzlgTwdApAno
         GUuSw/ivjmoyoXX2pxOnO3ZGQNVztgGddCSBh5mkdSazc83gSj9A7AgQjNZoaiHc7uCm
         +XXfVWXdRR/TPs55QPRIeX4w0stsfxioThwopF0i8xgWfg2Cqdw3tvhrTc8+xyru9ll7
         8SbhnW9ZnJxIUQb67wFpe9ez3pX7XmhHiF4IS2XVd3bg5GgxEVUKpF8NNrUKoJoeiFUR
         nb2g==
X-Gm-Message-State: AC+VfDzwqAKJKoVeFQzd2djtkY1J1SRuZ4A8kMRdJcRoEDZdypvF/yrw
        ZUzHHqrJDo8/uT3j+CHNieiSSg==
X-Google-Smtp-Source: ACHHUZ6ggR4soG8vb+luaw3zbN99oqAEaWuuBehqtbNYw2uEof6brxXzCArmM7sjiY322QPedXHD/w==
X-Received: by 2002:a17:902:82c4:b0:1ae:72fc:a625 with SMTP id u4-20020a17090282c400b001ae72fca625mr325645plz.37.1684442763184;
        Thu, 18 May 2023 13:46:03 -0700 (PDT)
Received: from enlightened2.mtv.corp.google.com ([2620:15c:9d:6:1d0:be0c:577f:1a49])
        by smtp.gmail.com with ESMTPSA id jj10-20020a170903048a00b001a2104d706fsm1859517plb.225.2023.05.18.13.46.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 13:46:02 -0700 (PDT)
From:   Shervin Oloumi <enlightened@chromium.org>
To:     mic@digikod.net
Cc:     linux-security-module@vger.kernel.org, jorgelo@chromium.org,
        keescook@chromium.org, groeck@chromium.org, jeffxu@chromium.org,
        allenwebb@chromium.org, gnoack3000@gmail.com, areber@redhat.com,
        criu@openvz.org, linux-api@vger.kernel.org, jannh@google.com,
        brauner@kernel.org, Shervin Oloumi <enlightened@chromium.org>
Subject: [PATCH v2] lsm: adds process attribute getter for Landlock
Date:   Thu, 18 May 2023 13:45:28 -0700
Message-ID: <20230518204549.3139044-1-enlightened@chromium.org>
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
In-Reply-To: <ce44fc98-1234-fa53-5067-cd624866f44a@digikod.net>
References: <ce44fc98-1234-fa53-5067-cd624866f44a@digikod.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Adds a new getprocattr hook function to the Landlock LSM, which tracks
the landlocked state of the process. This is invoked when user-space
reads /proc/[pid]/attr/domain to determine whether a given process is
sand-boxed using Landlock. When the target process is not sand-boxed,
the result is "none", otherwise the result is empty, as we still need to
decide what kind of domain information is best to provide in "domain".

The hook function also performs an access check. The request is rejected
if the tracing process is the same as the target process, or if the
tracing process domain is not an ancestor to the target process domain.

Adds a new directory for landlock under the process attribute
filesystem, and defines "domain" as a read-only process attribute entry
for landlock.

Signed-off-by: Shervin Oloumi <enlightened@chromium.org>
---
 fs/proc/base.c             | 11 +++++++++++
 security/landlock/fs.c     | 38 ++++++++++++++++++++++++++++++++++++++
 security/landlock/fs.h     |  1 +
 security/landlock/ptrace.c |  4 ++--
 security/landlock/ptrace.h |  3 +++
 5 files changed, 55 insertions(+), 2 deletions(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index 9e479d7d202b..b257ea704666 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -2851,6 +2851,13 @@ static const struct pid_entry apparmor_attr_dir_stuff[] = {
 LSM_DIR_OPS(apparmor);
 #endif
 
+#ifdef CONFIG_SECURITY_LANDLOCK
+static const struct pid_entry landlock_attr_dir_stuff[] = {
+	ATTR("landlock", "domain", 0444),
+};
+LSM_DIR_OPS(landlock);
+#endif
+
 static const struct pid_entry attr_dir_stuff[] = {
 	ATTR(NULL, "current",		0666),
 	ATTR(NULL, "prev",		0444),
@@ -2866,6 +2873,10 @@ static const struct pid_entry attr_dir_stuff[] = {
 	DIR("apparmor",			0555,
 	    proc_apparmor_attr_dir_inode_ops, proc_apparmor_attr_dir_ops),
 #endif
+#ifdef CONFIG_SECURITY_LANDLOCK
+	DIR("landlock",                  0555,
+	    proc_landlock_attr_dir_inode_ops, proc_landlock_attr_dir_ops),
+#endif
 };
 
 static int proc_attr_dir_readdir(struct file *file, struct dir_context *ctx)
diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index adcea0fe7e68..2f8b0837a0fd 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -1280,6 +1280,42 @@ static int hook_file_truncate(struct file *const file)
 	return -EACCES;
 }
 
+/* process attribute interfaces */
+
+/**
+ * landlock_getprocattr - Landlock process attribute getter
+ * @task: the object task
+ * @name: the name of the attribute in /proc/.../attr
+ * @value: where to put the result
+ *
+ * Performs access checks and writes any applicable results to value
+ *
+ * Returns the length of the result inside value or an error code
+ */
+static int landlock_getprocattr(struct task_struct *task, const char *name,
+				char **value)
+{
+	char *val = "";
+	int slen;
+
+	// If the tracing process is landlocked, ensure its domain is an
+	// ancestor to the target process domain.
+	if (landlocked(current))
+		if (current == task || !task_is_scoped(current, task))
+			return -EACCES;
+
+	// The only supported attribute is "domain".
+	if (strcmp(name, "domain") != 0)
+		return -EINVAL;
+
+	if (!landlocked(task))
+		val = "none";
+
+	slen = strlen(val);
+	*value = val;
+	return slen;
+}
+
 static struct security_hook_list landlock_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(inode_free_security, hook_inode_free_security),
 
@@ -1302,6 +1338,8 @@ static struct security_hook_list landlock_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(file_alloc_security, hook_file_alloc_security),
 	LSM_HOOK_INIT(file_open, hook_file_open),
 	LSM_HOOK_INIT(file_truncate, hook_file_truncate),
+
+	LSM_HOOK_INIT(getprocattr, landlock_getprocattr),
 };
 
 __init void landlock_add_fs_hooks(void)
diff --git a/security/landlock/fs.h b/security/landlock/fs.h
index 488e4813680a..64145e8b5537 100644
--- a/security/landlock/fs.h
+++ b/security/landlock/fs.h
@@ -13,6 +13,7 @@
 #include <linux/init.h>
 #include <linux/rcupdate.h>
 
+#include "ptrace.h"
 #include "ruleset.h"
 #include "setup.h"
 
diff --git a/security/landlock/ptrace.c b/security/landlock/ptrace.c
index 4c5b9cd71286..de943f0f3899 100644
--- a/security/landlock/ptrace.c
+++ b/security/landlock/ptrace.c
@@ -47,8 +47,8 @@ static bool domain_scope_le(const struct landlock_ruleset *const parent,
 	return false;
 }
 
-static bool task_is_scoped(const struct task_struct *const parent,
-			   const struct task_struct *const child)
+const bool task_is_scoped(const struct task_struct *const parent,
+			  const struct task_struct *const child)
 {
 	bool is_scoped;
 	const struct landlock_ruleset *dom_parent, *dom_child;
diff --git a/security/landlock/ptrace.h b/security/landlock/ptrace.h
index 265b220ae3bf..c6eb08951fc1 100644
--- a/security/landlock/ptrace.h
+++ b/security/landlock/ptrace.h
@@ -11,4 +11,7 @@
 
 __init void landlock_add_ptrace_hooks(void);
 
+const bool task_is_scoped(const struct task_struct *const parent,
+			  const struct task_struct *const child);
+
 #endif /* _SECURITY_LANDLOCK_PTRACE_H */
-- 
2.40.1.698.g37aff9b760-goog


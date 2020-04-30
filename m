Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF4F51C033D
	for <lists+linux-api@lfdr.de>; Thu, 30 Apr 2020 18:57:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726333AbgD3Q5d (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 30 Apr 2020 12:57:33 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:54552 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725844AbgD3Q5c (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 30 Apr 2020 12:57:32 -0400
Received: from ip5f5af183.dynamic.kabel-deutschland.de ([95.90.241.131] helo=wittgenstein.fritz.box)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jUCV6-0005V3-OC; Thu, 30 Apr 2020 16:57:28 +0000
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     linux-kernel@vger.kernel.org
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        =?UTF-8?q?St=C3=A9phane=20Graber?= <stgraber@ubuntu.com>,
        Linux Containers <containers@lists.linux-foundation.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Serge Hallyn <serge@hallyn.com>, Jann Horn <jannh@google.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Aleksa Sarai <cyphar@cyphar.com>, linux-api@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH v2 1/4] capability: add ns_capable_cred()
Date:   Thu, 30 Apr 2020 18:57:14 +0200
Message-Id: <20200430165717.1001605-1-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Add a simple capability helper which makes it possible to determine
whether a set of creds is ns capable wrt to the passed in credentials.
This is not something exciting it's just a more pleasant wrapper around
security_capable() by allowing ns_capable_common() to ake a const struct
cred argument. In ptrace_has_cap() for example, we're using
security_capable() directly. ns_capable_cred() will be used in the next
patch to check against the target credentials the caller is going to
switch to.

Cc: Eric W. Biederman <ebiederm@xmission.com>
Cc: Serge Hallyn <serge@hallyn.com>
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
/* v2 */
patch introduced
---
 include/linux/capability.h |  3 +++
 kernel/capability.c        | 17 +++++++++++------
 2 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/include/linux/capability.h b/include/linux/capability.h
index ecce0f43c73a..743a08d936fb 100644
--- a/include/linux/capability.h
+++ b/include/linux/capability.h
@@ -40,6 +40,7 @@ struct cpu_vfs_cap_data {
 struct file;
 struct inode;
 struct dentry;
+struct cred;
 struct task_struct;
 struct user_namespace;
 
@@ -209,6 +210,8 @@ extern bool has_ns_capability_noaudit(struct task_struct *t,
 				      struct user_namespace *ns, int cap);
 extern bool capable(int cap);
 extern bool ns_capable(struct user_namespace *ns, int cap);
+extern bool ns_capable_cred(const struct cred *cred,
+			    struct user_namespace *ns, int cap);
 extern bool ns_capable_noaudit(struct user_namespace *ns, int cap);
 extern bool ns_capable_setid(struct user_namespace *ns, int cap);
 #else
diff --git a/kernel/capability.c b/kernel/capability.c
index 1444f3954d75..84425781917e 100644
--- a/kernel/capability.c
+++ b/kernel/capability.c
@@ -361,8 +361,8 @@ bool has_capability_noaudit(struct task_struct *t, int cap)
 	return has_ns_capability_noaudit(t, &init_user_ns, cap);
 }
 
-static bool ns_capable_common(struct user_namespace *ns,
-			      int cap,
+static bool ns_capable_common(const struct cred *cred,
+			      struct user_namespace *ns, int cap,
 			      unsigned int opts)
 {
 	int capable;
@@ -372,7 +372,7 @@ static bool ns_capable_common(struct user_namespace *ns,
 		BUG();
 	}
 
-	capable = security_capable(current_cred(), ns, cap, opts);
+	capable = security_capable(cred, ns, cap, opts);
 	if (capable == 0) {
 		current->flags |= PF_SUPERPRIV;
 		return true;
@@ -393,10 +393,15 @@ static bool ns_capable_common(struct user_namespace *ns,
  */
 bool ns_capable(struct user_namespace *ns, int cap)
 {
-	return ns_capable_common(ns, cap, CAP_OPT_NONE);
+	return ns_capable_common(current_cred(), ns, cap, CAP_OPT_NONE);
 }
 EXPORT_SYMBOL(ns_capable);
 
+bool ns_capable_cred(const struct cred *cred, struct user_namespace *ns, int cap)
+{
+	return ns_capable_common(cred, ns, cap, CAP_OPT_NONE);
+}
+
 /**
  * ns_capable_noaudit - Determine if the current task has a superior capability
  * (unaudited) in effect
@@ -411,7 +416,7 @@ EXPORT_SYMBOL(ns_capable);
  */
 bool ns_capable_noaudit(struct user_namespace *ns, int cap)
 {
-	return ns_capable_common(ns, cap, CAP_OPT_NOAUDIT);
+	return ns_capable_common(current_cred(), ns, cap, CAP_OPT_NOAUDIT);
 }
 EXPORT_SYMBOL(ns_capable_noaudit);
 
@@ -430,7 +435,7 @@ EXPORT_SYMBOL(ns_capable_noaudit);
  */
 bool ns_capable_setid(struct user_namespace *ns, int cap)
 {
-	return ns_capable_common(ns, cap, CAP_OPT_INSETID);
+	return ns_capable_common(current_cred(), ns, cap, CAP_OPT_INSETID);
 }
 EXPORT_SYMBOL(ns_capable_setid);
 

base-commit: ae83d0b416db002fe95601e7f97f64b59514d936
-- 
2.26.2


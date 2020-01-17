Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 21DCC141088
	for <lists+linux-api@lfdr.de>; Fri, 17 Jan 2020 19:12:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729325AbgAQSMa (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 17 Jan 2020 13:12:30 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:52139 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729247AbgAQSM3 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 17 Jan 2020 13:12:29 -0500
Received: from ip5f5bd679.dynamic.kabel-deutschland.de ([95.91.214.121] helo=localhost.localdomain)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1isW6c-0005Yu-AA; Fri, 17 Jan 2020 18:12:26 +0000
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tejun Heo <tj@kernel.org>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Li Zefan <lizefan@huawei.com>, cgroups@vger.kernel.org
Subject: [PATCH v4 2/6] cgroup: add cgroup_get_from_file() helper
Date:   Fri, 17 Jan 2020 19:12:15 +0100
Message-Id: <20200117181219.14542-3-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200117181219.14542-1-christian.brauner@ubuntu.com>
References: <20200117181219.14542-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Add a helper cgroup_get_from_file(). The helper will be used in
subsequent patches to retrieve a cgroup while holding a reference to the
struct file it was taken from.

Cc: Tejun Heo <tj@kernel.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Li Zefan <lizefan@huawei.com>
Cc: cgroups@vger.kernel.org
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
/* v1 */
patch not present

/* v2 */
patch not present

/* v3 */
Link: https://lore.kernel.org/r/20200117002143.15559-3-christian.brauner@ubuntu.com
patch introduced
- Tejun Heo <tj@kernel.org>:
  - split cgroup_get_from_file() changes into separate commmit

/* v4 */
unchanged
---
 kernel/cgroup/cgroup.c | 30 +++++++++++++++++++-----------
 1 file changed, 19 insertions(+), 11 deletions(-)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index ad1f9fea5c14..f05efc2677c8 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -5882,6 +5882,24 @@ void cgroup_fork(struct task_struct *child)
 	INIT_LIST_HEAD(&child->cg_list);
 }
 
+static struct cgroup *cgroup_get_from_file(struct file *f)
+{
+	struct cgroup_subsys_state *css;
+	struct cgroup *cgrp;
+
+	css = css_tryget_online_from_dir(f->f_path.dentry, NULL);
+	if (IS_ERR(css))
+		return ERR_CAST(css);
+
+	cgrp = css->cgroup;
+	if (!cgroup_on_dfl(cgrp)) {
+		cgroup_put(cgrp);
+		return ERR_PTR(-EBADF);
+	}
+
+	return cgrp;
+}
+
 /**
  * cgroup_can_fork - called on a new task before the process is exposed
  * @child: the task in question.
@@ -6170,7 +6188,6 @@ EXPORT_SYMBOL_GPL(cgroup_get_from_path);
  */
 struct cgroup *cgroup_get_from_fd(int fd)
 {
-	struct cgroup_subsys_state *css;
 	struct cgroup *cgrp;
 	struct file *f;
 
@@ -6178,17 +6195,8 @@ struct cgroup *cgroup_get_from_fd(int fd)
 	if (!f)
 		return ERR_PTR(-EBADF);
 
-	css = css_tryget_online_from_dir(f->f_path.dentry, NULL);
+	cgrp = cgroup_get_from_file(f);
 	fput(f);
-	if (IS_ERR(css))
-		return ERR_CAST(css);
-
-	cgrp = css->cgroup;
-	if (!cgroup_on_dfl(cgrp)) {
-		cgroup_put(cgrp);
-		return ERR_PTR(-EBADF);
-	}
-
 	return cgrp;
 }
 EXPORT_SYMBOL_GPL(cgroup_get_from_fd);
-- 
2.25.0


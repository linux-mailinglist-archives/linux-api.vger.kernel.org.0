Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CC2E1BABF4
	for <lists+linux-api@lfdr.de>; Mon, 27 Apr 2020 20:05:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726457AbgD0SEv (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 27 Apr 2020 14:04:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:54558 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726230AbgD0SEu (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Mon, 27 Apr 2020 14:04:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id ED4C7AC22;
        Mon, 27 Apr 2020 18:04:47 +0000 (UTC)
From:   Vlastimil Babka <vbabka@suse.cz>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>
Cc:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-mm@kvack.org, Ivan Teterevkov <ivan.teterevkov@nutanix.com>,
        Michal Hocko <mhocko@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        "Guilherme G . Piccoli" <gpiccoli@canonical.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>
Subject: [PATCH v3 3/5] kernel/hung_task convert hung_task_panic boot parameter to sysctl
Date:   Mon, 27 Apr 2020 20:04:31 +0200
Message-Id: <20200427180433.7029-4-vbabka@suse.cz>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200427180433.7029-1-vbabka@suse.cz>
References: <20200427180433.7029-1-vbabka@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

We can now handle sysctl parameters on kernel command line and have
infrastructure to convert legacy command line options that duplicate sysctl
to become a sysctl alias.

This patch converts the hung_task_panic parameter. Note that the sysctl handler
is more strict and allows only 0 and 1, while the legacy parameter allowed
any non-zero value. But there is little reason anyone would not be using 1.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
Reviewed-by: Kees Cook <keescook@chromium.org>
Acked-by: Michal Hocko <mhocko@suse.com>
---
 Documentation/admin-guide/kernel-parameters.txt |  2 +-
 fs/proc/proc_sysctl.c                           |  1 +
 kernel/hung_task.c                              | 10 ----------
 3 files changed, 2 insertions(+), 11 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 73dbbf942431..1b6e710b7a8a 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1491,7 +1491,7 @@
 			[KNL] Should the hung task detector generate panics.
 			Format: <integer>
 
-			A nonzero value instructs the kernel to panic when a
+			A value of 1 instructs the kernel to panic when a
 			hung task is detected. The default value is controlled
 			by the CONFIG_BOOTPARAM_HUNG_TASK_PANIC build-time
 			option. The value selected by this boot parameter can
diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index 209ad03e1b82..e8f97bd65909 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -1710,6 +1710,7 @@ struct sysctl_alias {
  */
 static const struct sysctl_alias sysctl_aliases[] = {
 	{"numa_zonelist_order",		"vm.numa_zonelist_order" },
+	{"hung_task_panic",		"kernel.hung_task_panic" },
 	{ }
 };
 
diff --git a/kernel/hung_task.c b/kernel/hung_task.c
index 14a625c16cb3..b22b5eeab3cb 100644
--- a/kernel/hung_task.c
+++ b/kernel/hung_task.c
@@ -63,16 +63,6 @@ static struct task_struct *watchdog_task;
 unsigned int __read_mostly sysctl_hung_task_panic =
 				CONFIG_BOOTPARAM_HUNG_TASK_PANIC_VALUE;
 
-static int __init hung_task_panic_setup(char *str)
-{
-	int rc = kstrtouint(str, 0, &sysctl_hung_task_panic);
-
-	if (rc)
-		return rc;
-	return 1;
-}
-__setup("hung_task_panic=", hung_task_panic_setup);
-
 static int
 hung_task_panic(struct notifier_block *this, unsigned long event, void *ptr)
 {
-- 
2.26.0


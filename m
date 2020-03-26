Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3FB7A19465E
	for <lists+linux-api@lfdr.de>; Thu, 26 Mar 2020 19:16:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727803AbgCZSQZ (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 26 Mar 2020 14:16:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:45168 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728428AbgCZSQZ (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 26 Mar 2020 14:16:25 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id D7D36ADE2;
        Thu, 26 Mar 2020 18:16:22 +0000 (UTC)
From:   Vlastimil Babka <vbabka@suse.cz>
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>
Cc:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-mm@kvack.org, Ivan Teterevkov <ivan.teterevkov@nutanix.com>,
        Michal Hocko <mhocko@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        "Guilherme G . Piccoli" <gpiccoli@canonical.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: [RFC v3 2/2] kernel/sysctl: support handling command line aliases
Date:   Thu, 26 Mar 2020 19:16:06 +0100
Message-Id: <20200326181606.7027-2-vbabka@suse.cz>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200326181606.7027-1-vbabka@suse.cz>
References: <20200326181606.7027-1-vbabka@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

We can now handle sysctl parameters on kernel command line, but historically
some parameters introduced their own command line equivalent, which we don't
want to remove for compatibility reasons. We can however convert them to the
generic infrastructure with a table translating the legacy command line
parameters to their sysctl names, and removing the one-off param handlers.

This patch adds the support and makes the first conversion to demonstrate it,
on the (deprecated) numa_zonelist_order parameter.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
Changes in v3:
- constify some things according to Kees
- expand the comment of sysctl_aliases to note on different timings

 fs/proc/proc_sysctl.c | 48 ++++++++++++++++++++++++++++++++++++-------
 mm/page_alloc.c       |  9 --------
 2 files changed, 41 insertions(+), 16 deletions(-)

diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index 8ee3273e4540..3a861e0a7c7e 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -1729,6 +1729,37 @@ int __init proc_sys_init(void)
 
 struct vfsmount *proc_mnt = NULL;
 
+struct sysctl_alias {
+	const char *kernel_param;
+	const char *sysctl_param;
+};
+
+/*
+ * Historically some settings had both sysctl and a command line parameter.
+ * With the generic sysctl. parameter support, we can handle them at a single
+ * place and only keep the historical name for compatibility. This is not meant
+ * to add brand new aliases. When adding existing aliases, consider whether
+ * the possibly different moment of changing the value (e.g. from early_param
+ * to the moment do_sysctl_args() is called) is an issue for the specific
+ * parameter.
+ */
+static const struct sysctl_alias sysctl_aliases[] = {
+	{"numa_zonelist_order",		"vm.numa_zonelist_order" },
+	{ }
+};
+
+const char *sysctl_find_alias(char *param)
+{
+	const struct sysctl_alias *alias;
+
+	for (alias = &sysctl_aliases[0]; alias->kernel_param != NULL; alias++) {
+		if (strcmp(alias->kernel_param, param) == 0)
+			return alias->sysctl_param;
+	}
+
+	return NULL;
+}
+
 /* Set sysctl value passed on kernel command line. */
 static int process_sysctl_arg(char *param, char *val,
 			       const char *unused, void *arg)
@@ -1741,15 +1772,18 @@ static int process_sysctl_arg(char *param, char *val,
 	loff_t pos = 0;
 	ssize_t wret;
 
-	if (strncmp(param, "sysctl", sizeof("sysctl") - 1))
-		return 0;
-
-	param += sizeof("sysctl") - 1;
+	if (strncmp(param, "sysctl", sizeof("sysctl") - 1) == 0) {
+		param += sizeof("sysctl") - 1;
 
-	if (param[0] != '/' && param[0] != '.')
-		return 0;
+		if (param[0] != '/' && param[0] != '.')
+			return 0;
 
-	param++;
+		param++;
+	} else {
+		param = (char *) sysctl_find_alias(param);
+		if (!param)
+			return 0;
+	}
 
 	if (!proc_mnt) {
 		proc_fs_type = get_fs_type("proc");
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 3c4eb750a199..de7a134b1b8a 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5460,15 +5460,6 @@ static int __parse_numa_zonelist_order(char *s)
 	return 0;
 }
 
-static __init int setup_numa_zonelist_order(char *s)
-{
-	if (!s)
-		return 0;
-
-	return __parse_numa_zonelist_order(s);
-}
-early_param("numa_zonelist_order", setup_numa_zonelist_order);
-
 char numa_zonelist_order[] = "Node";
 
 /*
-- 
2.25.1


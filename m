Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 695C91927AC
	for <lists+linux-api@lfdr.de>; Wed, 25 Mar 2020 13:03:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727392AbgCYMD4 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 25 Mar 2020 08:03:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:50386 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727129AbgCYMD4 (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 25 Mar 2020 08:03:56 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 55912AC37;
        Wed, 25 Mar 2020 12:03:54 +0000 (UTC)
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
Subject: [RFC v2 2/2] kernel/sysctl: support handling command line aliases
Date:   Wed, 25 Mar 2020 13:03:45 +0100
Message-Id: <20200325120345.12946-2-vbabka@suse.cz>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200325120345.12946-1-vbabka@suse.cz>
References: <20200325120345.12946-1-vbabka@suse.cz>
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
 kernel/sysctl.c | 39 +++++++++++++++++++++++++++++++++++----
 mm/page_alloc.c |  9 ---------
 2 files changed, 35 insertions(+), 13 deletions(-)

diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 18c7f5606d55..fd72853396f9 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -1971,6 +1971,22 @@ static struct ctl_table dev_table[] = {
 	{ }
 };
 
+struct sysctl_alias {
+	char *kernel_param;
+	char *sysctl_param;
+};
+
+/*
+ * Historically some settings had both sysctl and a command line parameter.
+ * With the generic sysctl. parameter support, we can handle them at a single
+ * place and only keep the historical name for compatibility. This is not meant
+ * to add brand new aliases.
+ */
+static struct sysctl_alias sysctl_aliases[] = {
+	{"numa_zonelist_order",		"vm.numa_zonelist_order" },
+	{ }
+};
+
 int __init sysctl_init(void)
 {
 	struct ctl_table_header *hdr;
@@ -1980,6 +1996,18 @@ int __init sysctl_init(void)
 	return 0;
 }
 
+char *sysctl_find_alias(char *param)
+{
+	struct sysctl_alias *alias;
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
 int process_sysctl_arg(char *param, char *val,
 			       const char *unused, void *arg)
@@ -1990,10 +2018,13 @@ int process_sysctl_arg(char *param, char *val,
 	loff_t ppos = 0;
 	struct ctl_table *ctl, *found = NULL;
 
-	if (strncmp(param, "sysctl.", sizeof("sysctl.") - 1))
-		return 0;
-
-	param += sizeof("sysctl.") - 1;
+	if (strncmp(param, "sysctl.", sizeof("sysctl.") - 1) == 0) {
+		param += sizeof("sysctl.") - 1;
+	} else {
+		param = sysctl_find_alias(param);
+		if (!param)
+			return 0;
+	}
 
 	remaining = param;
 	ctl = &sysctl_base_table[0];
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


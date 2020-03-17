Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E54AA18854B
	for <lists+linux-api@lfdr.de>; Tue, 17 Mar 2020 14:21:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbgCQNVS (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 17 Mar 2020 09:21:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:45312 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726598AbgCQNVS (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Tue, 17 Mar 2020 09:21:18 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 4BE94AACA;
        Tue, 17 Mar 2020 13:21:14 +0000 (UTC)
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
        Vlastimil Babka <vbabka@suse.cz>
Subject: [RFC] kernel/sysctl: support setting sysctl parameters from kernel command line
Date:   Tue, 17 Mar 2020 14:21:05 +0100
Message-Id: <20200317132105.24555-1-vbabka@suse.cz>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

A recently proposed patch to add vm_swappiness command line parameter in
addition to existing sysctl [1] made me wonder why we don't have a general
support for passing sysctl parameters via command line. Googling found only
somebody else wondering the same [2], but I haven't found any prior discussion
with reasons why not to do this.

Settings the vm_swappiness issue aside (the underlying issue might be solved in
a different way), quick search of kernel-parameters.txt shows there are already
some that exist as both sysctl and kernel parameter - hung_task_panic,
nmi_watchdog, numa_zonelist_order, traceoff_on_warning. A general mechanism
would remove the need to add more of those one-offs and might be handy in
situations where configuration by e.g. /etc/sysctl.d/ is impractical.
Also after 61a47c1ad3a4 ("sysctl: Remove the sysctl system call") the only way
to set sysctl is via procfs, so this would eventually allow small systems to be
built without CONFIG_PROC_SYSCTL and still be able to change sysctl parameters.

Hence, this patch adds a new parse_args() pass that looks for parameters
prefixed by 'sysctl.' and searches for them in the sysctl ctl_tables. When
found, the respective proc handler is invoked. The search is just a naive
linear one, to avoid using the whole procfs layer. It should be acceptable,
as the cost depends on number of sysctl. parameters passed.

The main limitation of avoiding the procfs layer is however that sysctls
dynamically registered by register_sysctl_table() or register_sysctl_paths()
cannot be set by this method.

The processing is hooked right before the init process is loaded, as some
handlers might be more complicated than simple setters and might need some
subsystems to be initialized. At the moment the init process can be started and
eventually execute a process writing to /proc/sys/ then it should be also fine
to do that from the kernel.

[1] https://lore.kernel.org/linux-doc/BL0PR02MB560167492CA4094C91589930E9FC0@BL0PR02MB5601.namprd02.prod.outlook.com/
[2] https://unix.stackexchange.com/questions/558802/how-to-set-sysctl-using-kernel-command-line-parameter

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
Hi,

this is an early RFC so I can get feedback whether to pursue this idea further,
before trying the more complicated stuff with dynamically registered sysctls.
For those I have some unanswered questions:
- Support them at all?
- Do so by an internal procfs mount again, that was removed by 61a47c1ad3a4 ?
  Or try to keep it simple.
- If sysctls are dynamically registered at module load, process the command
  line sysctl arguments again? - this would be rather complicated I guess.

Vlastimil

 include/linux/sysctl.h |  1 +
 init/main.c            | 21 ++++++++++++++
 kernel/sysctl.c        | 66 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 88 insertions(+)

diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
index 02fa84493f23..62ae963a5c0c 100644
--- a/include/linux/sysctl.h
+++ b/include/linux/sysctl.h
@@ -206,6 +206,7 @@ struct ctl_table_header *register_sysctl_paths(const struct ctl_path *path,
 void unregister_sysctl_table(struct ctl_table_header * table);
 
 extern int sysctl_init(void);
+int process_sysctl_arg(char *param, char *val, const char *unused, void *arg);
 
 extern struct ctl_table sysctl_mount_point[];
 
diff --git a/init/main.c b/init/main.c
index ee4947af823f..74a094c6b8b9 100644
--- a/init/main.c
+++ b/init/main.c
@@ -1345,6 +1345,25 @@ void __weak free_initmem(void)
 	free_initmem_default(POISON_FREE_INITMEM);
 }
 
+static void do_sysctl_args(void)
+{
+#ifdef CONFIG_SYSCTL
+	size_t len = strlen(saved_command_line) + 1;
+	char *command_line;
+
+	command_line = kzalloc(len, GFP_KERNEL);
+	if (!command_line)
+		panic("%s: Failed to allocate %zu bytes\n", __func__, len);
+
+	strcpy(command_line, saved_command_line);
+
+	parse_args("Setting sysctl args", command_line,
+		   NULL, 0, -1, -1, NULL, process_sysctl_arg);
+
+	kfree(command_line);
+#endif
+}
+
 static int __ref kernel_init(void *unused)
 {
 	int ret;
@@ -1367,6 +1386,8 @@ static int __ref kernel_init(void *unused)
 
 	rcu_end_inkernel_boot();
 
+	do_sysctl_args();
+
 	if (ramdisk_execute_command) {
 		ret = run_init_process(ramdisk_execute_command);
 		if (!ret)
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index ad5b88a53c5a..0444656c259d 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -1980,6 +1980,72 @@ int __init sysctl_init(void)
 	return 0;
 }
 
+/* Set sysctl value passed on kernel command line. */
+int process_sysctl_arg(char *param, char *val,
+			       const char *unused, void *arg)
+{
+	size_t count;
+	char *tmp;
+	int err;
+	loff_t ppos = 0;
+	struct ctl_table *base, *child = NULL, *found = NULL;
+
+	if (strncmp(param, "sysctl.", sizeof("sysctl.") - 1))
+		return 0;
+
+	param += (sizeof("sysctl.") - 1);
+
+	tmp = strchr(param, '.');
+	if (!tmp) {
+		pr_warn("Invalid sysctl param '%s' on command line", param);
+		return 0;
+	}
+
+	*tmp = '\0';
+
+	for (base = &sysctl_base_table[0]; base->procname != 0; base++) {
+		if (strcmp(param, base->procname) == 0) {
+			child = base->child;
+			break;
+		}
+	}
+
+	if (!child) {
+		pr_warn("Unknown sysctl prefix '%s' on command line", param);
+		return 0;
+	}
+
+	tmp++;
+
+	for (; child->procname != 0; child++) {
+		if (strcmp(tmp, child->procname) == 0) {
+			found = child;
+			break;
+		}
+	}
+
+	if (!found) {
+		pr_warn("Unknown sysctl param '%s.%s' on command line", param, tmp);
+		return 0;
+	}
+
+	if (!(found->mode & 0200)) {
+		pr_warn("Cannot set sysctl '%s.%s=%s' from command line - not writable",
+			param, tmp, val);
+		return 0;
+	}
+
+
+	count = strlen(val);
+	err = found->proc_handler(found, 1, val, &count, &ppos);
+
+	if (err)
+		pr_warn("Error %d setting sysctl '%s.%s=%s' from command line",
+			err, param, tmp, val);
+
+	return 0;
+}
+
 #endif /* CONFIG_SYSCTL */
 
 /*
-- 
2.25.1


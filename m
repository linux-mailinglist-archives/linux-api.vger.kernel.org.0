Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 641582F33EC
	for <lists+linux-api@lfdr.de>; Tue, 12 Jan 2021 16:14:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405127AbhALPNj (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 12 Jan 2021 10:13:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57854 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2405080AbhALPNf (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 12 Jan 2021 10:13:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610464328;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=eYAwFL1bjtKuxrU7qTxXl+J5KIWZcpoUKayCM4CfTx4=;
        b=Pjd2fVMOZL7sYeEWxIHjT8EXtfa37Ljandr1UgNAufKm9nk28sGSh6c7EcL4XVxXjj6vbm
        wwtj+dFTq3cmOVAzXujySwD3H3frUollXKs/ghKRE6JXlpHqzM0Z6Z8YFAFQgjZNqk0EWv
        /f/92v9qCOqPc56h+XOF55kEDf4fIQ8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-585-iK-nb-EHMbicuqqU05FD5Q-1; Tue, 12 Jan 2021 10:12:04 -0500
X-MC-Unique: iK-nb-EHMbicuqqU05FD5Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CEE4C100C601;
        Tue, 12 Jan 2021 15:12:01 +0000 (UTC)
Received: from madcap2.tricolour.ca (unknown [10.10.110.8])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BB2325D9CD;
        Tue, 12 Jan 2021 15:11:55 +0000 (UTC)
From:   Richard Guy Briggs <rgb@redhat.com>
To:     Linux Containers List <containers@lists.linux-foundation.org>,
        Linux API <linux-api@vger.kernel.org>,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        Linux FSdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux NetDev Upstream Mailing List <netdev@vger.kernel.org>,
        Netfilter Devel List <netfilter-devel@vger.kernel.org>
Cc:     Neil Horman <nhorman@tuxdriver.com>,
        David Howells <dhowells@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Simo Sorce <simo@redhat.com>,
        Eric Paris <eparis@parisplace.org>, mpatel@redhat.com,
        Serge Hallyn <serge@hallyn.com>,
        Kees Cook <keescook@chromium.org>,
        Jens Axboe <axboe@kernel.dk>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Richard Guy Briggs <rgb@redhat.com>
Subject: [PATCH ghak90 v11 11/11] audit: add capcontid to set contid outside init_user_ns
Date:   Tue, 12 Jan 2021 10:09:39 -0500
Message-Id: <f535d3945bf0fccb3fd6278ec6bb2f0f01317fd3.1610399347.git.rgb@redhat.com>
In-Reply-To: <cover.1610399347.git.rgb@redhat.com>
References: <cover.1610399347.git.rgb@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Provide a mechanism similar to CAP_AUDIT_CONTROL to explicitly give a
process in a non-init user namespace the capability to set audit
container identifiers of individual children.

Provide the /proc/$PID/audit_capcontid interface to capcontid.
Valid values are: 1==enabled, 0==disabled

Writing a "1" to this special file for the target process $PID will
enable the target process to set audit container identifiers of its
descendants.

A process must already have CAP_AUDIT_CONTROL in the initial user
namespace or have had audit_capcontid enabled by a previous use of this
feature by its parent on this process in order to be able to enable it
for another process.  The target process must be a descendant of the
calling process.

Report this action in new message type AUDIT_SET_CAPCONTID 1022 with
fields opid= capcontid= old-capcontid=

Add an entry to Documentation/ABI.

Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
---
 .../ABI/testing/procfs-audit_containerid      | 16 +++++
 fs/proc/base.c                                | 54 +++++++++++++++
 include/linux/audit.h                         |  4 +-
 include/uapi/linux/audit.h                    |  1 +
 kernel/audit.c                                | 65 ++++++++++++++++++-
 5 files changed, 137 insertions(+), 3 deletions(-)

diff --git a/Documentation/ABI/testing/procfs-audit_containerid b/Documentation/ABI/testing/procfs-audit_containerid
index 30ea64790473..c697d7da0ad1 100644
--- a/Documentation/ABI/testing/procfs-audit_containerid
+++ b/Documentation/ABI/testing/procfs-audit_containerid
@@ -11,3 +11,19 @@ Description:
 		or have its own /proc/$pid/capcontainerid set to write
 		or read.
 
+
+What:		Capability to set or get the Audit Container Identifier
+Date:		2020-??
+KernelVersion:	5.10?
+Contact:	linux-audit@redhat.com
+Format:		u32
+Users:		auditd, libaudit, audit-testsuite, podman(?), container orchestrators
+Description:
+		The /proc/$pid/audit_capcontainerid pseudofile is
+		written to set and is read to get the capability of
+		process $pid to write or to read the /proc/$pid/containerid
+		audit container identifier of any of its descendants.
+		"1" allows and "0" denies that capability.  This
+		property is an extension to CAP_AUDIT_CONTROL outside of
+		the initial user namespace.
+
diff --git a/fs/proc/base.c b/fs/proc/base.c
index bf447e7932d2..7495eec1c73b 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -1383,6 +1383,58 @@ static const struct file_operations proc_contid_operations = {
 	.write		= proc_contid_write,
 	.llseek		= generic_file_llseek,
 };
+
+static ssize_t proc_capcontid_read(struct file *file, char __user *buf,
+				  size_t count, loff_t *ppos)
+{
+	struct inode *inode = file_inode(file);
+	struct task_struct *task = get_proc_task(inode);
+	ssize_t length;
+	char tmpbuf[TMPBUFLEN];
+
+	if (!task)
+		return -ESRCH;
+	length = audit_get_capcontid_proc(tmpbuf, TMPBUFLEN, task);
+	put_task_struct(task);
+	if (length < 0)
+		return length;
+	return simple_read_from_buffer(buf, count, ppos, tmpbuf, length);
+}
+
+static ssize_t proc_capcontid_write(struct file *file, const char __user *buf,
+				   size_t count, loff_t *ppos)
+{
+	struct inode *inode = file_inode(file);
+	u32 capcontid;
+	int rv;
+	struct task_struct *task = get_proc_task(inode);
+
+	if (!task)
+		return -ESRCH;
+	if (*ppos != 0) {
+		/* No partial writes. */
+		put_task_struct(task);
+		return -EINVAL;
+	}
+
+	rv = kstrtou32_from_user(buf, count, 10, &capcontid);
+	if (rv < 0) {
+		put_task_struct(task);
+		return rv;
+	}
+
+	rv = audit_set_capcontid(task, capcontid);
+	put_task_struct(task);
+	if (rv < 0)
+		return rv;
+	return count;
+}
+
+static const struct file_operations proc_capcontid_operations = {
+	.read		= proc_capcontid_read,
+	.write		= proc_capcontid_write,
+	.llseek		= generic_file_llseek,
+};
 #endif
 
 #ifdef CONFIG_FAULT_INJECTION
@@ -3286,6 +3338,7 @@ static const struct pid_entry tgid_base_stuff[] = {
 	REG("loginuid",   S_IWUSR|S_IRUGO, proc_loginuid_operations),
 	REG("sessionid",  S_IRUGO, proc_sessionid_operations),
 	REG("audit_containerid", S_IWUSR|S_IRUSR, proc_contid_operations),
+	REG("audit_capcontainerid", S_IWUSR|S_IRUSR, proc_capcontid_operations),
 #endif
 #ifdef CONFIG_FAULT_INJECTION
 	REG("make-it-fail", S_IRUGO|S_IWUSR, proc_fault_inject_operations),
@@ -3629,6 +3682,7 @@ static const struct pid_entry tid_base_stuff[] = {
 	REG("loginuid",  S_IWUSR|S_IRUGO, proc_loginuid_operations),
 	REG("sessionid",  S_IRUGO, proc_sessionid_operations),
 	REG("audit_containerid", S_IWUSR|S_IRUSR, proc_contid_operations),
+	REG("audit_capcontainerid", S_IWUSR|S_IRUSR, proc_capcontid_operations),
 #endif
 #ifdef CONFIG_FAULT_INJECTION
 	REG("make-it-fail", S_IRUGO|S_IWUSR, proc_fault_inject_operations),
diff --git a/include/linux/audit.h b/include/linux/audit.h
index 014f73296fec..3f5444393618 100644
--- a/include/linux/audit.h
+++ b/include/linux/audit.h
@@ -214,8 +214,10 @@ extern void audit_set_sessionid_iouring(unsigned int sessionid);
 
 extern int audit_get_contid_proc(char *tmpbuf, int TMPBUFLEN,
 				 struct task_struct *task);
-
+extern int audit_get_capcontid_proc(char *tmpbuf, int TMPBUFLEN,
+				 struct task_struct *task);
 extern int audit_set_contid(struct task_struct *tsk, u64 contid);
+extern int audit_set_capcontid(struct task_struct *tsk, u32 enable);
 
 extern void audit_copy_namespaces(struct net *net, struct task_struct *tsk);
 extern void audit_switch_task_namespaces(struct nsproxy *ns,
diff --git a/include/uapi/linux/audit.h b/include/uapi/linux/audit.h
index 66350e572e41..b7c7ab2e6a1d 100644
--- a/include/uapi/linux/audit.h
+++ b/include/uapi/linux/audit.h
@@ -73,6 +73,7 @@
 #define AUDIT_GET_FEATURE	1019	/* Get which features are enabled */
 #define AUDIT_CONTAINER_OP	1020	/* Define the container id and info */
 #define AUDIT_SIGNAL_INFO2	1021	/* Get info auditd signal sender */
+#define AUDIT_SET_CAPCONTID	1022	/* Set cap_contid of a task */
 
 #define AUDIT_FIRST_USER_MSG	1100	/* Userspace messages mostly uninteresting to kernel */
 #define AUDIT_USER_AVC		1107	/* We filter this differently */
diff --git a/kernel/audit.c b/kernel/audit.c
index d2e9d803e5fd..7e825305b3c2 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -238,6 +238,7 @@ struct audit_task_info {
 	kuid_t			loginuid;
 	unsigned int		sessionid;
 	struct audit_contobj	*cont;
+	u32			capcontid;
 #ifdef CONFIG_AUDITSYSCALL
 	struct audit_context	*ctx;
 #endif
@@ -308,6 +309,15 @@ static inline u64 audit_get_contid(struct task_struct *tsk)
 	return info->cont->id;
 }
 
+static inline u32 audit_get_capcontid(struct task_struct *tsk)
+{
+	struct audit_task_info *info = tsk->audit;
+
+	if (!info)
+		return 0;
+	return info->capcontid;
+}
+
 inline struct audit_context *_audit_context(struct task_struct *tsk)
 {
 	struct audit_task_info *info = tsk->audit;
@@ -420,6 +430,7 @@ static void audit_alloc_task(struct task_struct *tsk)
 	rcu_read_lock();
 	info->cont = _audit_contobj_get_bytask(current);
 	rcu_read_unlock();
+	info->capcontid = 0;
 	tsk->audit = info;
 }
 
@@ -2988,6 +2999,56 @@ static bool audit_contid_isnesting(struct task_struct *tsk)
 	return !isowner && ownerisparent;
 }
 
+int audit_set_capcontid(struct task_struct *tsk, u32 enable)
+{
+	u32 oldcapcontid;
+	int rc = 0;
+	struct audit_buffer *ab;
+	struct audit_task_info *info = tsk->audit;
+
+	if (!info)
+		return -ENOPROTOOPT;
+	oldcapcontid = audit_get_capcontid(tsk);
+	/* if task is not descendant, block */
+	if (tsk == current || !task_is_descendant(current, tsk))
+		rc = -EXDEV;
+	else if (current_user_ns() == &init_user_ns) {
+		if (!capable(CAP_AUDIT_CONTROL) &&
+		    !audit_get_capcontid(current))
+			rc = -EPERM;
+	}
+	if (!rc)
+		info->capcontid = enable;
+
+	if (!audit_enabled)
+		return rc;
+
+	ab = audit_log_start(audit_context(), GFP_KERNEL, AUDIT_SET_CAPCONTID);
+	if (!ab)
+		return rc;
+
+	audit_log_format(ab,
+			 "opid=%d capcontid=%u old-capcontid=%u",
+			 task_tgid_nr(tsk), enable, oldcapcontid);
+	audit_log_end(ab);
+	return rc;
+}
+
+int audit_get_capcontid_proc(char *tmpbuf, int TMPBUFLEN,
+			  struct task_struct *tsk)
+{
+	int length;
+
+	/* if we don't have caps, reject */
+	if (!capable(CAP_AUDIT_CONTROL) && !audit_get_capcontid(current)) {
+		length = -EPERM;
+		goto out;
+	}
+	length = scnprintf(tmpbuf, TMPBUFLEN, "%u", audit_get_capcontid(tsk));
+out:
+	return length;
+}
+
 /*
  * audit_set_contid - set current task's audit contid
  * @tsk: target task
@@ -3021,7 +3082,7 @@ int audit_set_contid(struct task_struct *tsk, u64 contid)
 	if (contid == AUDIT_CID_UNSET) {
 		/* Don't allow the contid to be unset */
 		rc = -EINVAL;
-	} else if (!capable(CAP_AUDIT_CONTROL)) {
+	} else if (!capable(CAP_AUDIT_CONTROL) && !audit_get_capcontid(current)) {
 		/* if we don't have caps, reject */
 		rc = -EPERM;
 	} else if (!list_empty(&tsk->children) ||
@@ -3111,7 +3172,7 @@ int audit_get_contid_proc(char *tmpbuf, int TMPBUFLEN,
 	int length;
 
 	/* if we don't have caps, reject */
-	if (!capable(CAP_AUDIT_CONTROL)) {
+	if (!capable(CAP_AUDIT_CONTROL) && !audit_get_capcontid(current)) {
 		length = -EPERM;
 		goto out;
 	}
-- 
2.18.4


Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D0978F0EB
	for <lists+linux-api@lfdr.de>; Thu, 15 Aug 2019 18:40:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732571AbfHOQjY (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 15 Aug 2019 12:39:24 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45886 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732519AbfHOQjY (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 15 Aug 2019 12:39:24 -0400
Received: by mail-wr1-f67.google.com with SMTP id q12so2735586wrj.12
        for <linux-api@vger.kernel.org>; Thu, 15 Aug 2019 09:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=J09zSsT9buOczVU+ulfFm+iTVDrcjeY6aYv1FEzzRB8=;
        b=KwcH8kHLb2Mq8kLic2tzi8Si105XplABl3sm8SKzpE6/lfjILP6Q7P8bwjJTO3CHnq
         ZAI+6u4NnqXrcCKnX09wfZC3qiZ9VSVQoQ9l9qEBeKrOn40mTHQ+Ue8t4PfmMcyZW0mi
         H9JM4y/VdJzCEV9YAY0ihHklJbpbgFcO5Nb1bC2fOSbPyDvEBK0iSx7hHcHuUQulTt3G
         HDzB1R9T3O/SAR3anaPwRzqiFF1f/t0v6sgm7+glCD9BKD9HL3DkwAnCq66m0Dz7VS1z
         zYYChhNr0k1t1C4THXwEEMWtZ4mLrgyuD2/ozbiAbRfdgpsfbSG+UFvg0OXQqA01eSxV
         lnPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J09zSsT9buOczVU+ulfFm+iTVDrcjeY6aYv1FEzzRB8=;
        b=uM/PQDGJYDTBPo8ZlIR2mnRpUPUkGGRlQo8903SXafQXmcEWPwxkPJMZa2y1xzN2+p
         HeEKw86aWqDKA3u1hhJKSW7ynpys4Bw3o1h7j+4S1doxnQiMo9XapJSDJOYbbMuBnjdb
         j+NjtZsCcT0OGcbgPAJSchpUdOCd9jxTE9xF8dP8u9S7DUNsgBB/MIvWx2Y/GnW0dBOj
         L+QvfdXPPRR2pcDk7507ITsWjoIfsT2Uw1tctaj1DlEo2eWsO6lE7rXohOhcwGUQGJWu
         UzY5CGF4j4metGKPJh7nhEeSP+NxrNBRzfJNssV74FdvLaPGlRO5E3jEIWb9lkeSzwFG
         PuzA==
X-Gm-Message-State: APjAAAWT1ZujLPhY4Q4XH5ijLEuEsd//a0ZvHuEDxndXsQX/5s2F/s4R
        26ubyuAxLBGTYm/gglW3rwSr4g==
X-Google-Smtp-Source: APXvYqwDLublf0r/YE7C+I7X82ZePMgpBruJaYY5GGqjg3iM93nraVxqgkauQL779woAtFFJG3ba2A==
X-Received: by 2002:adf:f18c:: with SMTP id h12mr6070689wro.47.1565887161033;
        Thu, 15 Aug 2019 09:39:21 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id f7sm5755046wrf.8.2019.08.15.09.39.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2019 09:39:20 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Andrei Vagin <avagin@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Adrian Reber <adrian@lisas.de>,
        Andrei Vagin <avagin@openvz.org>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jann Horn <jannh@google.com>, Jeff Dike <jdike@addtoit.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        containers@lists.linux-foundation.org, criu@openvz.org,
        linux-api@vger.kernel.org, x86@kernel.org
Subject: [PATCHv6 29/36] fs/proc: Introduce /proc/pid/timens_offsets
Date:   Thu, 15 Aug 2019 17:38:29 +0100
Message-Id: <20190815163836.2927-30-dima@arista.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190815163836.2927-1-dima@arista.com>
References: <20190815163836.2927-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

From: Andrei Vagin <avagin@gmail.com>

API to set time namespace offsets for children processes, i.e.:
echo "clockid off_ses off_nsec" > /proc/self/timens_offsets

Signed-off-by: Andrei Vagin <avagin@gmail.com>
Co-developed-by: Dmitry Safonov <dima@arista.com>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 fs/proc/base.c                 |  95 ++++++++++++++++++++++++++++++
 include/linux/time_namespace.h |  10 ++++
 kernel/time_namespace.c        | 104 +++++++++++++++++++++++++++++++++
 3 files changed, 209 insertions(+)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index ebea9501afb8..1d2007365e87 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -94,6 +94,7 @@
 #include <linux/sched/debug.h>
 #include <linux/sched/stat.h>
 #include <linux/posix-timers.h>
+#include <linux/time_namespace.h>
 #include <trace/events/oom.h>
 #include "internal.h"
 #include "fd.h"
@@ -1533,6 +1534,97 @@ static const struct file_operations proc_pid_sched_autogroup_operations = {
 
 #endif /* CONFIG_SCHED_AUTOGROUP */
 
+#ifdef CONFIG_TIME_NS
+static int timens_offsets_show(struct seq_file *m, void *v)
+{
+	struct task_struct *p;
+
+	p = get_proc_task(file_inode(m->file));
+	if (!p)
+		return -ESRCH;
+	proc_timens_show_offsets(p, m);
+
+	put_task_struct(p);
+
+	return 0;
+}
+
+static ssize_t
+timens_offsets_write(struct file *file, const char __user *buf,
+	    size_t count, loff_t *ppos)
+{
+	struct inode *inode = file_inode(file);
+	struct proc_timens_offset offsets[2];
+	char *kbuf = NULL, *pos, *next_line;
+	struct task_struct *p;
+	int ret, noffsets;
+
+	/* Only allow < page size writes at the beginning of the file */
+	if ((*ppos != 0) || (count >= PAGE_SIZE))
+		return -EINVAL;
+
+	/* Slurp in the user data */
+	kbuf = memdup_user_nul(buf, count);
+	if (IS_ERR(kbuf))
+		return PTR_ERR(kbuf);
+
+	/* Parse the user data */
+	ret = -EINVAL;
+	noffsets = 0;
+	for (pos = kbuf; pos; pos = next_line) {
+		struct proc_timens_offset *off = &offsets[noffsets];
+		int err;
+
+		/* Find the end of line and ensure we don't look past it */
+		next_line = strchr(pos, '\n');
+		if (next_line) {
+			*next_line = '\0';
+			next_line++;
+			if (*next_line == '\0')
+				next_line = NULL;
+		}
+
+		err = sscanf(pos, "%u %lld %lu", &off->clockid,
+				&off->val.tv_sec, &off->val.tv_nsec);
+		if (err != 3 || off->val.tv_nsec >= NSEC_PER_SEC)
+			goto out;
+		noffsets++;
+		if (noffsets == ARRAY_SIZE(offsets)) {
+			if (next_line)
+				count = next_line - kbuf;
+			break;
+		}
+	}
+
+	ret = -ESRCH;
+	p = get_proc_task(inode);
+	if (!p)
+		goto out;
+	ret = proc_timens_set_offset(file, p, offsets, noffsets);
+	put_task_struct(p);
+	if (ret)
+		goto out;
+
+	ret = count;
+out:
+	kfree(kbuf);
+	return ret;
+}
+
+static int timens_offsets_open(struct inode *inode, struct file *filp)
+{
+	return single_open(filp, timens_offsets_show, inode);
+}
+
+static const struct file_operations proc_timens_offsets_operations = {
+	.open		= timens_offsets_open,
+	.read		= seq_read,
+	.write		= timens_offsets_write,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+#endif /* CONFIG_TIME_NS */
+
 static ssize_t comm_write(struct file *file, const char __user *buf,
 				size_t count, loff_t *offset)
 {
@@ -3015,6 +3107,9 @@ static const struct pid_entry tgid_base_stuff[] = {
 #endif
 #ifdef CONFIG_SCHED_AUTOGROUP
 	REG("autogroup",  S_IRUGO|S_IWUSR, proc_pid_sched_autogroup_operations),
+#endif
+#ifdef CONFIG_TIME_NS
+	REG("timens_offsets",  S_IRUGO|S_IWUSR, proc_timens_offsets_operations),
 #endif
 	REG("comm",      S_IRUGO|S_IWUSR, proc_pid_set_comm_operations),
 #ifdef CONFIG_HAVE_ARCH_TRACEHOOK
diff --git a/include/linux/time_namespace.h b/include/linux/time_namespace.h
index 9ba9664ff0ab..3f4d457ff0dc 100644
--- a/include/linux/time_namespace.h
+++ b/include/linux/time_namespace.h
@@ -40,6 +40,16 @@ static inline void put_time_ns(struct time_namespace *ns)
 	kref_put(&ns->kref, free_time_ns);
 }
 
+extern void proc_timens_show_offsets(struct task_struct *p, struct seq_file *m);
+
+struct proc_timens_offset {
+	int clockid;
+	struct timespec64 val;
+};
+
+extern int proc_timens_set_offset(struct file *file, struct task_struct *p,
+				struct proc_timens_offset *offsets, int n);
+
 static inline void timens_add_monotonic(struct timespec64 *ts)
 {
 	struct timens_offsets *ns_offsets = current->nsproxy->time_ns->offsets;
diff --git a/kernel/time_namespace.c b/kernel/time_namespace.c
index a01c25fe76d5..1c3ba91873bc 100644
--- a/kernel/time_namespace.c
+++ b/kernel/time_namespace.c
@@ -8,6 +8,7 @@
 #include <linux/user_namespace.h>
 #include <linux/sched/signal.h>
 #include <linux/sched/task.h>
+#include <linux/seq_file.h>
 #include <linux/proc_ns.h>
 #include <linux/export.h>
 #include <linux/time.h>
@@ -251,6 +252,109 @@ static struct user_namespace *timens_owner(struct ns_common *ns)
 	return to_time_ns(ns)->user_ns;
 }
 
+static void show_offset(struct seq_file *m, int clockid, struct timespec64 *ts)
+{
+	seq_printf(m, "%d %lld %ld\n", clockid, ts->tv_sec, ts->tv_nsec);
+}
+
+void proc_timens_show_offsets(struct task_struct *p, struct seq_file *m)
+{
+	struct ns_common *ns;
+	struct time_namespace *time_ns;
+	struct timens_offsets *ns_offsets;
+
+	ns = timens_for_children_get(p);
+	if (!ns)
+		return;
+	time_ns = to_time_ns(ns);
+
+	if (!time_ns->offsets) {
+		put_time_ns(time_ns);
+		return;
+	}
+	ns_offsets = time_ns->offsets;
+
+	show_offset(m, CLOCK_MONOTONIC, &ns_offsets->monotonic);
+	show_offset(m, CLOCK_BOOTTIME, &ns_offsets->boottime);
+	put_time_ns(time_ns);
+}
+
+int proc_timens_set_offset(struct file *file, struct task_struct *p,
+			   struct proc_timens_offset *offsets, int noffsets)
+{
+	struct ns_common *ns;
+	struct time_namespace *time_ns;
+	struct timens_offsets *ns_offsets;
+	struct timespec64 *offset;
+	struct timespec64 tp;
+	int i, err;
+
+	ns = timens_for_children_get(p);
+	if (!ns)
+		return -ESRCH;
+	time_ns = to_time_ns(ns);
+
+	if (!time_ns->offsets || time_ns->initialized ||
+	    !file_ns_capable(file, time_ns->user_ns, CAP_SYS_TIME)) {
+		put_time_ns(time_ns);
+		return -EPERM;
+	}
+	ns_offsets = time_ns->offsets;
+
+	for (i = 0; i < noffsets; i++) {
+		struct proc_timens_offset *off = &offsets[i];
+
+		switch (off->clockid) {
+		case CLOCK_MONOTONIC:
+			ktime_get_ts64(&tp);
+			break;
+		case CLOCK_BOOTTIME:
+			ktime_get_boottime_ts64(&tp);
+			break;
+		default:
+			err = -EINVAL;
+			goto out;
+		}
+
+		err = -ERANGE;
+
+		if (off->val.tv_sec > KTIME_SEC_MAX || off->val.tv_sec < -KTIME_SEC_MAX)
+			goto out;
+
+		tp = timespec64_add(tp, off->val);
+		/*
+		 * KTIME_SEC_MAX is divided by 2 to be sure that KTIME_MAX is
+		 * still unreachable.
+		 */
+		if (tp.tv_sec < 0 || tp.tv_sec > KTIME_SEC_MAX / 2)
+			goto out;
+	}
+
+	err = 0;
+	/* don't report errors after this line */
+	for (i = 0; i < noffsets; i++) {
+		struct proc_timens_offset *off = &offsets[i];
+
+		switch (off->clockid) {
+		case CLOCK_MONOTONIC:
+			offset = &ns_offsets->monotonic;
+			break;
+		case CLOCK_BOOTTIME:
+			offset = &ns_offsets->boottime;
+			break;
+		default:
+			goto out;
+		}
+
+		*offset = off->val;
+	}
+
+out:
+	put_time_ns(time_ns);
+
+	return err;
+}
+
 const struct proc_ns_operations timens_operations = {
 	.name		= "time",
 	.type		= CLONE_NEWTIME,
-- 
2.22.0


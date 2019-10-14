Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7490ED6728
	for <lists+linux-api@lfdr.de>; Mon, 14 Oct 2019 18:22:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729889AbfJNQVg (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 14 Oct 2019 12:21:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34180 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388051AbfJNQVf (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Mon, 14 Oct 2019 12:21:35 -0400
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D268C3680A
        for <linux-api@vger.kernel.org>; Mon, 14 Oct 2019 16:21:34 +0000 (UTC)
Received: by mail-ed1-f71.google.com with SMTP id p55so10520324edc.5
        for <linux-api@vger.kernel.org>; Mon, 14 Oct 2019 09:21:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jxJEiUicI74qFOY0JqtAedGKYBHKAdl/AbcmF2fazs4=;
        b=KfS5T78GgPbfg/Jmxv5frKL2tK0tFIecxtIS7u7FyLc+aeHTVCl+SeYv0azyQbE1Qk
         dR1EycR7dm5lBfdiqob3Mezyz5R8Fdfyudjcab67/dGo/WflRxOuQsrdYdJfF+nGe9gg
         CDickdiBBPSvWAO6Eov44KIWmfYYRDI3b5hmC3alt+KMZP1k+V9VjuD0PlMLzTXiWn9p
         87ssB4Ii2OLHd3UkpT3Ocp9Mfj1rtOIdh1g3UByFMBRlFxWnxMtg/EGQwlELcufWAJ9V
         9HX5HqmybLi17WUXfqTdMI6GqjU4ivP0oig/THdQawaaLQl6pQ4gZImsfk4uUCFfZZ16
         2FXA==
X-Gm-Message-State: APjAAAXqn8C06MV3tJM0nvZtGlAqT4zcDi7tCqIdXV1ezIR2VzA5ETZs
        k0/upcQYruRtr2BuTb0DfBRDyfLWrbZJqnBXNgufgJF7pWOuxi9rXpU1i4gFRqE3w3IVsdVNeWH
        aL/FFt4V4uLDii5r/gEDd
X-Received: by 2002:a50:9fcd:: with SMTP id c71mr28967487edf.139.1571070093512;
        Mon, 14 Oct 2019 09:21:33 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyS0BF2XOi6OkeE1vgAAFwd+MqDj2BjN62Hn0mRr5YldhvLlYO8SB+mZW2bhY6FBZyMdUT7hQ==
X-Received: by 2002:a50:9fcd:: with SMTP id c71mr28967464edf.139.1571070093258;
        Mon, 14 Oct 2019 09:21:33 -0700 (PDT)
Received: from localhost ([2a02:2450:102e:d85:877d:43b4:dd8f:144d])
        by smtp.gmail.com with ESMTPSA id u11sm202672ejz.48.2019.10.14.09.21.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2019 09:21:32 -0700 (PDT)
From:   Christian Kellner <ckellner@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-api@vger.kernel.org, Jann Horn <jannh@google.com>,
        Christian Kellner <christian@kellner.me>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christian Brauner <christian@brauner.io>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Michal Hocko <mhocko@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Roman Gushchin <guro@fb.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Aleksa Sarai <cyphar@cyphar.com>,
        "Dmitry V. Levin" <ldv@altlinux.org>
Subject: [PATCH v4 1/2] pidfd: add NSpid entries to fdinfo
Date:   Mon, 14 Oct 2019 18:20:32 +0200
Message-Id: <20191014162034.2185-1-ckellner@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191011122323.7770-1-ckellner@redhat.com>
References: <20191011122323.7770-1-ckellner@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

From: Christian Kellner <christian@kellner.me>

Currently, the fdinfo file contains the Pid field which shows the
pid a given pidfd refers to in the pid namespace of the procfs
instance. If pid namespaces are configured, also show an NSpid field
for easy retrieval of the pid in all descendant pid namespaces. If
the pid namespace of the process is not a descendant of the pid
namespace of the procfs instance 0 will be shown as its first NSpid
entry and no other entries will be shown. Add a block comment to
pidfd_show_fdinfo with a detailed explanation of Pid and NSpid fields.

Co-developed-by: Christian Brauner <christian.brauner@ubuntu.com>
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
Signed-off-by: Christian Kellner <christian@kellner.me>
---
Changes in v4:
- Reworked to properly handle the case where the pidfd is from a
  different branch in the pid namespace hierarchy; also add block
  comment with an in-depth explanation (Christian Brauner)

 kernel/fork.c | 53 ++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 52 insertions(+), 1 deletion(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index bcdf53125210..782986962d47 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1695,12 +1695,63 @@ static int pidfd_release(struct inode *inode, struct file *file)
 }
 
 #ifdef CONFIG_PROC_FS
+/**
+ * pidfd_show_fdinfo - print information about a pidfd
+ * @m: proc fdinfo file
+ * @f: file referencing a pidfd
+ *
+ * Pid:
+ * This function will print the pid that a given pidfd refers to in the
+ * pid namespace of the procfs instance.
+ * If the pid namespace of the process is not a descendant of the pid
+ * namespace of the procfs instance 0 will be shown as its pid. This is
+ * similar to calling getppid() on a process whose parent is outside of
+ * its pid namespace.
+ *
+ * NSpid:
+ * If pid namespaces are supported then this function will also print
+ * the pid of a given pidfd refers to for all descendant pid namespaces
+ * starting from the current pid namespace of the instance, i.e. the
+ * Pid field and the first entry in the NSpid field will be identical.
+ * If the pid namespace of the process is not a descendant of the pid
+ * namespace of the procfs instance 0 will be shown as its first NSpid
+ * entry and no others will be shown.
+ * Note that this differs from the Pid and NSpid fields in
+ * /proc/<pid>/status where Pid and NSpid are always shown relative to
+ * the  pid namespace of the procfs instance. The difference becomes
+ * obvious when sending around a pidfd between pid namespaces from a
+ * different branch of the tree, i.e. where no ancestoral relation is
+ * present between the pid namespaces:
+ * - create two new pid namespaces ns1 and ns2 in the initial pid
+ *   namespace (also take care to create new mount namespaces in the
+ *   new pid namespace and mount procfs)
+ * - create a process with a pidfd in ns1
+ * - send pidfd from ns1 to ns2
+ * - read /proc/self/fdinfo/<pidfd> and observe that both Pid and NSpid
+ *   have exactly one entry, which is 0
+ */
 static void pidfd_show_fdinfo(struct seq_file *m, struct file *f)
 {
 	struct pid_namespace *ns = proc_pid_ns(file_inode(m->file));
 	struct pid *pid = f->private_data;
+	pid_t nr = pid_nr_ns(pid, ns);
+
+	seq_put_decimal_ull(m, "Pid:\t", nr);
 
-	seq_put_decimal_ull(m, "Pid:\t", pid_nr_ns(pid, ns));
+#ifdef CONFIG_PID_NS
+	seq_put_decimal_ull(m, "\nNSpid:\t", nr);
+	if (nr) {
+		int i;
+
+		/* If nr is non-zero it means that 'pid' is valid and that
+		 * ns, i.e. the pid namespace associated with the procfs
+		 * instance, is in the pid namespace hierarchy of pid.
+		 * Start at one below the already printed level.
+		 */
+		for (i = ns->level + 1; i <= pid->level; i++)
+			seq_put_decimal_ull(m, "\t", pid->numbers[i].nr);
+	}
+#endif
 	seq_putc(m, '\n');
 }
 #endif
-- 
2.21.0


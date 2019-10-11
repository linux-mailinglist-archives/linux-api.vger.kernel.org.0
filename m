Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE3F5D3F6A
	for <lists+linux-api@lfdr.de>; Fri, 11 Oct 2019 14:23:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728041AbfJKMXn (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 11 Oct 2019 08:23:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39386 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727709AbfJKMXn (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Fri, 11 Oct 2019 08:23:43 -0400
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C291A3CA20
        for <linux-api@vger.kernel.org>; Fri, 11 Oct 2019 12:23:42 +0000 (UTC)
Received: by mail-ed1-f69.google.com with SMTP id s29so5620724eds.21
        for <linux-api@vger.kernel.org>; Fri, 11 Oct 2019 05:23:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=H2MBbbJ40+7c+zCxtdMVPxmyJTAgLs4tX+z2yWBAoJY=;
        b=Nw/hCzQu7d1UvvWgrX2j4DkEt2N06gv8/juNC6PmF2NgHsPY93t6tJKb28iyRO1pk9
         yc+2GKiAp2Ysw1MUm8JoIlJq/G/s0a4hFFwqNrlF9CWyoZItegwgHX/Jq7zJlDJDwBbs
         0KdwtxjO6NkcBLVh1D9r6exF3LPhufXz1Z+A4HhIi/u/+qGnCawx4T3Wf/oZhi82MgXY
         l1xs4Dws8U7fLqmvFv4u4tfrTbm3I9a5gZuJ9Totr55LLt9Kqc9sQMUyjZDlf46dwj+0
         EzZLTC/1/9EdxYRC7b+858ZxMJbM/uF+P8lV0jojQMuuUQFp4SbuJNgzSuzJmKbbvLTt
         QhRQ==
X-Gm-Message-State: APjAAAUwLCydB68FATSs89CzAyw/DT6ntYzd+GB94bTMtL/wA8hFSN/D
        oq95dVsTkvBSIJ1H6o1uF+j84wMfruftOZBbvtrN54njELGs2h9XmMcFFca+4jMGx9ebX+Eqmww
        SUmRXgwHt90GyPZ0fkDuh
X-Received: by 2002:a17:906:5407:: with SMTP id q7mr13791847ejo.24.1570796621419;
        Fri, 11 Oct 2019 05:23:41 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxcuwNfu7eBCa+wJQza/bR/XzgJiVyFoOkqeJ3Q9NTMa95W6G9v3z1bhtpv9pyERQVnbX9Tyg==
X-Received: by 2002:a17:906:5407:: with SMTP id q7mr13791826ejo.24.1570796621125;
        Fri, 11 Oct 2019 05:23:41 -0700 (PDT)
Received: from localhost ([2a02:2450:102e:d85:877d:43b4:dd8f:144d])
        by smtp.gmail.com with ESMTPSA id lw23sm1095531ejb.68.2019.10.11.05.23.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2019 05:23:40 -0700 (PDT)
From:   Christian Kellner <ckellner@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-api@vger.kernel.org,
        Christian Kellner <christian@kellner.me>,
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
Subject: [PATCH v3 1/2] pidfd: show pids for nested pid namespaces in fdinfo
Date:   Fri, 11 Oct 2019 14:23:20 +0200
Message-Id: <20191011122323.7770-1-ckellner@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191009160532.20674-1-ckellner@redhat.com>
References: <20191009160532.20674-1-ckellner@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

From: Christian Kellner <christian@kellner.me>

The fdinfo file for a process file descriptor already contains the
pid of the process in the callers namespaces. Additionally, if pid
namespaces are configured, show the process ids of the process in
all nested namespaces in the same format as in the procfs status
file, i.e. "NSPid:\t%d\%d...". This allows the easy identification
of the processes in nested namespaces.

Signed-off-by: Christian Kellner <christian@kellner.me>
---

Changes in v2:
- Moved into separate function to avoid multiple ifdefs as suggested
  by Michal Hocko
Changes in v3:
- Helper function takes struct pid_namespace *ns param and got a new
  name

 kernel/fork.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/kernel/fork.c b/kernel/fork.c
index bcdf53125210..183950aad82b 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1695,12 +1695,27 @@ static int pidfd_release(struct inode *inode, struct file *file)
 }
 
 #ifdef CONFIG_PROC_FS
+static inline void print_pidfd_nspid(struct seq_file *m, struct pid *pid,
+				     struct pid_namespace *ns)
+{
+#ifdef CONFIG_PID_NS
+	int i;
+
+	seq_puts(m, "\nNSpid:");
+	for (i = ns->level; i <= pid->level; i++) {
+		ns = pid->numbers[i].ns;
+		seq_put_decimal_ull(m, "\t", pid_nr_ns(pid, ns));
+	}
+#endif
+}
+
 static void pidfd_show_fdinfo(struct seq_file *m, struct file *f)
 {
 	struct pid_namespace *ns = proc_pid_ns(file_inode(m->file));
 	struct pid *pid = f->private_data;
 
 	seq_put_decimal_ull(m, "Pid:\t", pid_nr_ns(pid, ns));
+	print_pidfd_nspid(m, pid, ns);
 	seq_putc(m, '\n');
 }
 #endif
-- 
2.21.0


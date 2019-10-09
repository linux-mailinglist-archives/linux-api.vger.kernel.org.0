Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73A33D13A8
	for <lists+linux-api@lfdr.de>; Wed,  9 Oct 2019 18:09:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731796AbfJIQJk (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 9 Oct 2019 12:09:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40158 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731795AbfJIQJj (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 9 Oct 2019 12:09:39 -0400
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9AF9287638
        for <linux-api@vger.kernel.org>; Wed,  9 Oct 2019 16:09:38 +0000 (UTC)
Received: by mail-ed1-f69.google.com with SMTP id a21so1702339edt.19
        for <linux-api@vger.kernel.org>; Wed, 09 Oct 2019 09:09:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yo8HgxFaUzFJT5aifHeLW47+7+qi0Gxu8+x3gkt5AcY=;
        b=JmBlVRgKEXsYMTKQ7Yc1N9I949kz5fEMYSqOPzt6jnbQrDIdBE1b2JpSfB11Lah5fP
         vVOUbEVnxdn5muoef1g9eyNL4Tq1LssFwCdR7vgA54BHyjZIU8ocMWVNt0cLkqD/A8i8
         O3rUzF48+/vnxp3HhqdRa/ITo6fdcecM2cWjAQs+DWCKAqfEI4UcqGqyj3ZSGJGZvuO9
         N6BBs25UHnMqc2Z3AMtnfA10PPRseQS5r6J90gOF+Pvzof8/4CN2KReLUVHw/MDaDgMe
         gCdYr9qrFFKOWGiBfNbVs/We46yyawSdKugreiIUSRe50wV3dMN4ryhxLQfjzcHoFKS1
         ezGg==
X-Gm-Message-State: APjAAAXD/ZL3DtJk39bdPw2d/37+mCn5XoRFDrT/WoaaUgUsWug8S/qm
        cV6aztHzEyLR6/ci2cTMr7azEPanC4axiBlvPQe70eJdiWykr0vCiKZg2fGA9tf9hrvKNzHJook
        wqDjJsE1tzfnPQGBEiwFj
X-Received: by 2002:a17:906:8598:: with SMTP id v24mr3576971ejx.328.1570637377271;
        Wed, 09 Oct 2019 09:09:37 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzIa1NlC5x/Y/DxrahdimMpGxXuvwAyvm2TeQKg29VSeDf6iUFdplanwS4MmX2Wk7mlZDp32A==
X-Received: by 2002:a17:906:8598:: with SMTP id v24mr3576934ejx.328.1570637377052;
        Wed, 09 Oct 2019 09:09:37 -0700 (PDT)
Received: from localhost ([2a02:2450:102e:d85:877d:43b4:dd8f:144d])
        by smtp.gmail.com with ESMTPSA id e52sm415148eda.36.2019.10.09.09.09.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2019 09:09:36 -0700 (PDT)
From:   Christian Kellner <ckellner@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-api@vger.kernel.org,
        Christian Kellner <christian@kellner.me>,
        Christian Brauner <christian@brauner.io>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Michal Hocko <mhocko@suse.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Roman Gushchin <guro@fb.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Dmitry V. Levin" <ldv@altlinux.org>
Subject: [PATCH v2 1/2] pidfd: show pids for nested pid namespaces in fdinfo
Date:   Wed,  9 Oct 2019 18:05:30 +0200
Message-Id: <20191009160532.20674-1-ckellner@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191008133641.23019-1-ckellner@redhat.com>
References: <20191008133641.23019-1-ckellner@redhat.com>
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

 kernel/fork.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/kernel/fork.c b/kernel/fork.c
index 5a0fd518e04e..f7a59ef046e9 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1681,12 +1681,27 @@ static int pidfd_release(struct inode *inode, struct file *file)
 }
 
 #ifdef CONFIG_PROC_FS
+static void pidfd_nspid(struct seq_file *m, struct pid *pid)
+{
+#ifdef CONFIG_PID_NS
+	struct pid_namespace *ns = proc_pid_ns(file_inode(m->file));
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
+	pidfd_nspid(m, pid);
 	seq_putc(m, '\n');
 }
 #endif
-- 
2.21.0


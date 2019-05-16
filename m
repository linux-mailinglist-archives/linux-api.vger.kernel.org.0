Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 103F7202C6
	for <lists+linux-api@lfdr.de>; Thu, 16 May 2019 11:43:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727035AbfEPJnB (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 16 May 2019 05:43:01 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35981 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727156AbfEPJmo (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 16 May 2019 05:42:44 -0400
Received: by mail-wm1-f65.google.com with SMTP id j187so2761549wmj.1
        for <linux-api@vger.kernel.org>; Thu, 16 May 2019 02:42:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZZGnY1AeO4vEIRNllzlClW+UmlSDLeAarYqLIOTY4ZI=;
        b=exS2QYSkEGL7OA0+vXEH/KXUJF2t+Mvao53bPNPoVxp4Uv0OsRixBtwJH3uBJ0RhY9
         NN3/QzOFPSN445FUfO6AHktjmrP4kfl30Hayjtb7TYlG7kku0loYEX+GGaY8+5OUZyca
         h2hnPXx55I/TgCfBWKfrhW4y79+ZjA1m6wQB5hq86XTKZOz2+hvndm/R7GPoNbUbJCpN
         odUl3xFdnh0BdqlSBMvoNaVY8QXGm0o98GiNlTxKYgxQDuF3yjuADGqUt3/IX3zA+x53
         PJ+djHwbNCqVafG0DL0JT6zcOE58JlWv7Q3vQMI/GocKRYFVdHn5S/peG5fGOKNUUps+
         +vVw==
X-Gm-Message-State: APjAAAU5yZs+4cqEj1PfIaSYysFPICerbeXegAVYaU73+tRtcAvhEEuj
        zAe3NvIahrdjQIUD0RLaV53X2g==
X-Google-Smtp-Source: APXvYqzGCZsfZTLnp32ZXX+p/N913HP7wOvaTxVvqZVz8kRuhkb2Lox0z5g/+tp8DehjQ+5iLc3ZLg==
X-Received: by 2002:a7b:c8d1:: with SMTP id f17mr14149157wml.45.1557999763188;
        Thu, 16 May 2019 02:42:43 -0700 (PDT)
Received: from localhost (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id s18sm4074000wmc.41.2019.05.16.02.42.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 16 May 2019 02:42:42 -0700 (PDT)
From:   Oleksandr Natalenko <oleksandr@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Kirill Tkhai <ktkhai@virtuozzo.com>,
        Hugh Dickins <hughd@google.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Greg KH <greg@kroah.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Timofey Titovets <nefelim4ag@gmail.com>,
        Aaron Tomlin <atomlin@redhat.com>,
        Grzegorz Halat <ghalat@redhat.com>, linux-mm@kvack.org,
        linux-api@vger.kernel.org
Subject: [PATCH RFC 4/5] mm/ksm, proc: introduce remote merge
Date:   Thu, 16 May 2019 11:42:33 +0200
Message-Id: <20190516094234.9116-5-oleksandr@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190516094234.9116-1-oleksandr@redhat.com>
References: <20190516094234.9116-1-oleksandr@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Use previously introduced remote madvise knob to mark task's
anonymous memory as mergeable.

To force merging task's VMAs, "merge" hint is used:

   # echo merge > /proc/<pid>/madvise

Force unmerging is done similarly:

   # echo unmerge > /proc/<pid>/madvise

To achieve this, previously introduced ksm_madvise_*() helpers
are used.

Signed-off-by: Oleksandr Natalenko <oleksandr@redhat.com>
---
 fs/proc/base.c | 52 +++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 51 insertions(+), 1 deletion(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index f69532d6b74f..6677580080ed 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -94,6 +94,8 @@
 #include <linux/sched/debug.h>
 #include <linux/sched/stat.h>
 #include <linux/posix-timers.h>
+#include <linux/mman.h>
+#include <linux/ksm.h>
 #include <trace/events/oom.h>
 #include "internal.h"
 #include "fd.h"
@@ -2960,15 +2962,63 @@ static int proc_stack_depth(struct seq_file *m, struct pid_namespace *ns,
 static ssize_t madvise_write(struct file *file, const char __user *buf,
 		size_t count, loff_t *ppos)
 {
+	/* For now, only KSM hints are implemented */
+#ifdef CONFIG_KSM
+	char buffer[PROC_NUMBUF];
+	int behaviour;
 	struct task_struct *task;
+	struct mm_struct *mm;
+	int err = 0;
+	struct vm_area_struct *vma;
+
+	memset(buffer, 0, sizeof(buffer));
+	if (count > sizeof(buffer) - 1)
+		count = sizeof(buffer) - 1;
+	if (copy_from_user(buffer, buf, count))
+		return -EFAULT;
+
+	if (!memcmp("merge", buffer, min(sizeof("merge")-1, count)))
+		behaviour = MADV_MERGEABLE;
+	else if (!memcmp("unmerge", buffer, min(sizeof("unmerge")-1, count)))
+		behaviour = MADV_UNMERGEABLE;
+	else
+		return -EINVAL;
 
 	task = get_proc_task(file_inode(file));
 	if (!task)
 		return -ESRCH;
 
+	mm = get_task_mm(task);
+	if (!mm) {
+		err = -EINVAL;
+		goto out_put_task_struct;
+	}
+
+	down_write(&mm->mmap_sem);
+	switch (behaviour) {
+	case MADV_MERGEABLE:
+	case MADV_UNMERGEABLE:
+		vma = mm->mmap;
+		while (vma) {
+			if (behaviour == MADV_MERGEABLE)
+				ksm_madvise_merge(vma->vm_mm, vma, &vma->vm_flags);
+			else
+				ksm_madvise_unmerge(vma, vma->vm_start, vma->vm_end, &vma->vm_flags);
+			vma = vma->vm_next;
+		}
+		break;
+	}
+	up_write(&mm->mmap_sem);
+
+	mmput(mm);
+
+out_put_task_struct:
 	put_task_struct(task);
 
-	return count;
+	return err ? err : count;
+#else
+	return -EINVAL;
+#endif /* CONFIG_KSM */
 }
 
 static const struct file_operations proc_madvise_operations = {
-- 
2.21.0


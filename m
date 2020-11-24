Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B0D32C1DA9
	for <lists+linux-api@lfdr.de>; Tue, 24 Nov 2020 06:40:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729128AbgKXFj4 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 24 Nov 2020 00:39:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729099AbgKXFjy (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 24 Nov 2020 00:39:54 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B135C0613CF
        for <linux-api@vger.kernel.org>; Mon, 23 Nov 2020 21:39:53 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id v12so26065106ybi.6
        for <linux-api@vger.kernel.org>; Mon, 23 Nov 2020 21:39:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=num0SQsxDIMRNuuSRBGQ+NlMxj/jOeSqEtVQ3GNIWyo=;
        b=YpxnqpYi239SbpxtHV+Vxz7w+h0AiAQYV1GookO796eyPdkf+79Unh1sSkTeYIGYlZ
         fYGtsTS/V0+StBRMMtQWYykHOSsxU8EHFJJMuz5OQum15tUzmoU4mIhQhDqV2nBEyqKs
         XK/KIZ2+zwBhcA+EzWiaCrqZe2Nb2x65s/Lfy+6uoLbUsHLsF3davJSBrpklz4sSUv4W
         /SQPXg6/uMywGKgpV3mVypJfITIHuhBrto6iRSwkpTUClCyA2efXPf7U0yXt3j1K5YKW
         p7TYHvw5CfC6xs5MJRByYXxoD6L1RnaBXJHLv7SbZb1BSqe2QO2ZMHreLbFH0hCJmgun
         cHmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=num0SQsxDIMRNuuSRBGQ+NlMxj/jOeSqEtVQ3GNIWyo=;
        b=hd9PmeQulpbIxqBTUJtELHXIYDV3OGkjPhHKcTluocHHLVus/keKrI1RmkMzGMkNbA
         TWYoEOY5CFaS81EJpYR/+jBrldv4wepWUAB3C3VruiaErihKGMuC9+OQp8yI/aVmaWq0
         EXIDdHiLW7hPpSVrh8IHhYinLiqN80FNG4Gbn56QM5I7NGa6X8CcD4J0Xb7AOIIBBy6y
         62/izSVoEF44vXkpqwWg8QYJwZ45MUYFHah8RVbvbQN9ZxYEsTwejyu+QyJlLp+8356p
         LsDkJTq4c6A7ziHm1yTqcvrDtuqEPhOzEA92XUZHU8cFjiWktTi19Jwj7Byffuy8EmTn
         1wCA==
X-Gm-Message-State: AOAM533Rte4UHb9c6omSb9RxHxN1QHzjnKl4Qw3rD1b9Aj0yjX5rcoyR
        5+h4nnQraTZ+sJA/vmtist7W3urmGA0=
X-Google-Smtp-Source: ABdhPJxzVVmlhMNlsCBIR68sN2RXwHt8UgDh7S4/lf5Z8gJWx8kRvBvH4P+J8Q+9qwpwIDF0oHGRYNLQQ5A=
Sender: "surenb via sendgmr" <surenb@surenb1.mtv.corp.google.com>
X-Received: from surenb1.mtv.corp.google.com ([2620:15c:211:200:f693:9fff:fef4:2055])
 (user=surenb job=sendgmr) by 2002:a25:cc0c:: with SMTP id l12mr5070405ybf.90.1606196392342;
 Mon, 23 Nov 2020 21:39:52 -0800 (PST)
Date:   Mon, 23 Nov 2020 21:39:43 -0800
In-Reply-To: <20201124053943.1684874-1-surenb@google.com>
Message-Id: <20201124053943.1684874-3-surenb@google.com>
Mime-Version: 1.0
References: <20201124053943.1684874-1-surenb@google.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [PATCH 2/2] mm/madvise: add process_madvise MADV_DONTNEER support
From:   Suren Baghdasaryan <surenb@google.com>
To:     surenb@google.com
Cc:     akpm@linux-foundation.org, mhocko@kernel.org, mhocko@suse.com,
        rientjes@google.com, willy@infradead.org, hannes@cmpxchg.org,
        guro@fb.com, riel@surriel.com, minchan@kernel.org,
        christian@brauner.io, oleg@redhat.com, timmurray@google.com,
        linux-api@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

In modern systems it's not unusual to have a system component monitoring
memory conditions of the system and tasked with keeping system memory
pressure under control. One way to accomplish that is to kill
non-essential processes to free up memory for more important ones.
Examples of this are Facebook's OOM killer daemon called oomd and
Android's low memory killer daemon called lmkd.
For such system component it's important to be able to free memory
quickly and efficiently. Unfortunately the time process takes to free
up its memory after receiving a SIGKILL might vary based on the state
of the process (uninterruptible sleep), size and OPP level of the core
the process is running.
In such situation it is desirable to be able to free up the memory of the
process being killed in a more controlled way.
Enable MADV_DONTNEED to be used with process_madvise when applied to a
dying process to reclaim its memory. This would allow userspace system
components like oomd and lmkd to free memory of the target process in
a more predictable way.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 mm/madvise.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/mm/madvise.c b/mm/madvise.c
index 1aa074a46524..11306534369e 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -29,6 +29,7 @@
 #include <linux/swapops.h>
 #include <linux/shmem_fs.h>
 #include <linux/mmu_notifier.h>
+#include <linux/oom.h>
 
 #include <asm/tlb.h>
 
@@ -995,6 +996,18 @@ process_madvise_behavior_valid(int behavior)
 	switch (behavior) {
 	case MADV_COLD:
 	case MADV_PAGEOUT:
+	case MADV_DONTNEED:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static bool madvise_destructive(int behavior)
+{
+	switch (behavior) {
+	case MADV_DONTNEED:
+	case MADV_FREE:
 		return true;
 	default:
 		return false;
@@ -1006,6 +1019,10 @@ static bool can_range_madv_lru_vma(struct vm_area_struct *vma, int behavior)
 	if (!can_madv_lru_vma(vma))
 		return false;
 
+	/* For destructive madvise skip shared file-backed VMAs */
+	if (madvise_destructive(behavior))
+		return vma_is_anonymous(vma) || !(vma->vm_flags & VM_SHARED);
+
 	return true;
 }
 
@@ -1239,6 +1256,23 @@ SYSCALL_DEFINE5(process_madvise, int, pidfd, const struct iovec __user *, vec,
 		goto release_task;
 	}
 
+	if (madvise_destructive(behavior)) {
+		/* Allow destructive madvise only on a dying processes */
+		if (!signal_group_exit(task->signal)) {
+			ret = -EINVAL;
+			goto release_mm;
+		}
+		/* Ensure no competition with OOM-killer to avoid contention */
+		if (unlikely(mm_is_oom_victim(mm)) ||
+		    unlikely(test_bit(MMF_OOM_SKIP, &mm->flags))) {
+			/* Already being reclaimed */
+			ret = 0;
+			goto release_mm;
+		}
+		/* Mark mm as unstable */
+		set_bit(MMF_UNSTABLE, &mm->flags);
+	}
+
 	/*
 	 * For range madvise only the entire address space is supported for now
 	 * and input iovec is ignored.
-- 
2.29.2.454.gaff20da3a2-goog


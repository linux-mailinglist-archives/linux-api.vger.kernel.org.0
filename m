Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C9102EF9C2
	for <lists+linux-api@lfdr.de>; Fri,  8 Jan 2021 22:01:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727845AbhAHVAL (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 8 Jan 2021 16:00:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727003AbhAHVAK (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 8 Jan 2021 16:00:10 -0500
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06880C061757
        for <linux-api@vger.kernel.org>; Fri,  8 Jan 2021 12:59:03 -0800 (PST)
Received: by mail-qv1-xf4a.google.com with SMTP id t18so9112768qva.6
        for <linux-api@vger.kernel.org>; Fri, 08 Jan 2021 12:59:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=pg2+obVmDdZw2cVJ7QAMiVijjbCTy6dUmk2h4J5JypM=;
        b=bGwlBNOlqsBerbH0/KNUcpimkFnfnQdqlYIwG/BNL3IRka1C9Q54SMbgiR+Ihs0Qqf
         PBF2zL6u4tLZSFtNLHF1Y0SodUbYkNODtyJVn/SXmybjq9qupbwXkiNw8G5ljf6WIAt8
         /901fZEST9OlaVA/TLox3tLuLqNOXg2+Gzuh5jXpQBI3rTiltYyjnxEjs7Oe1mrK7Wn8
         fnmaaRZKXRRVIOYHKaOXzCtrgHfvIEtCkST1wmua8yZ4JAe0h2Gq+ChYdP0EE4/76B7x
         nVdrfwoVbCqshvN6rbO9uFv5X4iQBwH5vAK+6sepxIIXUWCfOjOkubfSgSBhLwaFeQHh
         m9OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=pg2+obVmDdZw2cVJ7QAMiVijjbCTy6dUmk2h4J5JypM=;
        b=tEbg2wQKP8PaQqdjP/R5CWTUWQn0V1LfWm8r5QYYOEWcDEsI1hUue/5oLfmvo7tcIr
         g5TlbQ1Dbl0ZHO0pfV9Oks6tFM3c/HfDF8e8Nhb2HujvixAnenoLSHCtKafoL9Gee74Q
         lMEFJJG2UkHkC1pcO7qGYmBgOQKIBKDzwOTtGWkYYIMgmfwaZMmOxZ8SjvavVjaXsR7J
         CZCVmDsPX51lAvlSd5Ib/xnDOnv6E2OkCoc6J4D7cMX0WL4hrABui7pLKZW4lOpUz2Ug
         WjBZRYylA7h86uanqhs5x52pfoBusjQEd7EstIktYyHT78E5lvX416VKbI2lzH6KqPJl
         9rAA==
X-Gm-Message-State: AOAM533VKifjN2QYfEnc52JwD+qSNZVbm4S/NgwFVsKTOr+jzR6ZLLyz
        8xcpqz6rBiFZzuyInkBx3PBCGROA28k=
X-Google-Smtp-Source: ABdhPJzkhcWm36Y5z3eQqRcs4DfyJUCy0+z8bCk7zQYdPc0oJNglTollph0feYqWo91RO0orZmPxFLLqhs4=
Sender: "surenb via sendgmr" <surenb@surenb1.mtv.corp.google.com>
X-Received: from surenb1.mtv.corp.google.com ([100.98.240.136]) (user=surenb
 job=sendgmr) by 2002:ad4:4888:: with SMTP id bv8mr5409095qvb.0.1610139542143;
 Fri, 08 Jan 2021 12:59:02 -0800 (PST)
Date:   Fri,  8 Jan 2021 12:58:57 -0800
Message-Id: <20210108205857.1471269-1-surenb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [PATCH 1/1] mm/madvise: replace ptrace attach requirement for process_madvise
From:   Suren Baghdasaryan <surenb@google.com>
To:     akpm@linux-foundation.org
Cc:     jannh@google.com, keescook@chromium.org, jeffv@google.com,
        minchan@kernel.org, mhocko@suse.com, shakeelb@google.com,
        rientjes@google.com, edgararriaga@google.com, timmurray@google.com,
        linux-mm@kvack.org, selinux@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com, surenb@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

process_madvise currently requires ptrace attach capability.
PTRACE_MODE_ATTACH gives one process complete control over another
process. It effectively removes the security boundary between the
two processes (in one direction). Granting ptrace attach capability
even to a system process is considered dangerous since it creates an
attack surface. This severely limits the usage of this API.
The operations process_madvise can perform do not affect the correctness
of the operation of the target process; they only affect where the data
is physically located (and therefore, how fast it can be accessed).
What we want is the ability for one process to influence another process
in order to optimize performance across the entire system while leaving
the security boundary intact.
Replace PTRACE_MODE_ATTACH with a combination of PTRACE_MODE_READ
and CAP_SYS_NICE. PTRACE_MODE_READ to prevent leaking ASLR metadata
and CAP_SYS_NICE for influencing process performance.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 mm/madvise.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/mm/madvise.c b/mm/madvise.c
index 6a660858784b..c2d600386902 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -1197,12 +1197,22 @@ SYSCALL_DEFINE5(process_madvise, int, pidfd, const struct iovec __user *, vec,
 		goto release_task;
 	}
 
-	mm = mm_access(task, PTRACE_MODE_ATTACH_FSCREDS);
+	/* Require PTRACE_MODE_READ to avoid leaking ASLR metadata. */
+	mm = mm_access(task, PTRACE_MODE_READ_FSCREDS);
 	if (IS_ERR_OR_NULL(mm)) {
 		ret = IS_ERR(mm) ? PTR_ERR(mm) : -ESRCH;
 		goto release_task;
 	}
 
+	/*
+	 * Require CAP_SYS_NICE for influencing process performance. Note that
+	 * only non-destructive hints are currently supported.
+	 */
+	if (!capable(CAP_SYS_NICE)) {
+		ret = -EPERM;
+		goto release_task;
+	}
+
 	total_len = iov_iter_count(&iter);
 
 	while (iov_iter_count(&iter)) {
-- 
2.30.0.284.gd98b1dd5eaa7-goog


Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13DB6159CA8
	for <lists+linux-api@lfdr.de>; Tue, 11 Feb 2020 23:56:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727838AbgBKW4V (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 11 Feb 2020 17:56:21 -0500
Received: from mail-qt1-f201.google.com ([209.85.160.201]:39056 "EHLO
        mail-qt1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727860AbgBKW4U (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 11 Feb 2020 17:56:20 -0500
Received: by mail-qt1-f201.google.com with SMTP id p12so20898qtu.6
        for <linux-api@vger.kernel.org>; Tue, 11 Feb 2020 14:56:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to;
        bh=/wUiaE4lRYXVr4XT55eq69Fhu4cwbqd4vz3JObgWLSw=;
        b=umSesbTGPsu+nvuQqZ8fY1eTSikUabPzN6xXg7xZJNBVLypMGXMDDOtJRe0wHcws/7
         KVx131mQiaayMu32w+j2ucPHb9I5Eb8itpDFy9EHwUOdRgdnnhnKXgs7u72L/EpOwS2f
         JvJl3PKDTd9Y1naPldNOTFfg9IraAiaHTbUmM5seXxpMlK9aTnTnuqYp3Ud/ljRBeBkc
         WuPfeFuw2yoyip+1AA+8LQghHTNqWGHBzKnlUmuoOyGwGYsCIsIDAnf0JEf3eQDlIhI2
         yKiZaipNfTJ1ATmOxT4/Zj07VxlViiwp1X4wBvuGy6Hc65x02f0NtCx8qf1iy1MOde2k
         odTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to;
        bh=/wUiaE4lRYXVr4XT55eq69Fhu4cwbqd4vz3JObgWLSw=;
        b=MAzoQJ0oSZQSabxsc+u5PgS9R2UiHlQEQZMXN/Vb3rxpBVTDPRqEXiho450n9I4OoH
         KGa51lYrD4Cfrtpnq4SkfXPq1QJSFnUSqow0xUaEyYH1VWY6sWPBfsGWDg8FmuMJg6+B
         Y4u4AL+N8r42SO+hzpd9PGV3w7dwEw2m9xJs3e0utfIXi3fL+SFT3MvMPK56ULARUWkI
         rTkEt3mZlTKXmDJ35PmmZlHMcfdM+zXQbelKhr0qR6RReb4CWOl7mLzNskOFmyEQQLPb
         oEybbGbaagyOJieflYw/7Oz4cjOpdnabDxsYXzO5hg3bbM+836q+/9BXd09KXbW54wCg
         vdaA==
X-Gm-Message-State: APjAAAUnYdGQVtlFLBxeNpUJbDVlzWqNTIWKIKRZnuMvmde5eF3hWd1m
        UQRklQvRM0wrd9Ef7jC6g0eOEYhOQGA=
X-Google-Smtp-Source: APXvYqyZXCjauD7MRkh/uIhajsG5EI06HCT6AH+BThgzhc0Md1s+7ziwiBW5p3VuX5RjLJnrFmjTcG1OTEs=
X-Received: by 2002:ac8:34b2:: with SMTP id w47mr16528854qtb.142.1581461779511;
 Tue, 11 Feb 2020 14:56:19 -0800 (PST)
Date:   Tue, 11 Feb 2020 14:55:45 -0800
In-Reply-To: <20200211225547.235083-1-dancol@google.com>
Message-Id: <20200211225547.235083-5-dancol@google.com>
Mime-Version: 1.0
References: <20200211225547.235083-1-dancol@google.com>
X-Mailer: git-send-email 2.25.0.225.g125e21ebc7-goog
Subject: [PATCH v2 4/6] Wire UFFD up to SELinux
From:   Daniel Colascione <dancol@google.com>
To:     dancol@google.com, timmurray@google.com, nosh@google.com,
        nnk@google.com, lokeshgidra@google.com,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

This change gives userfaultfd file descriptors a real security
context, allowing policy to act on them.

Signed-off-by: Daniel Colascione <dancol@google.com>
---
 fs/userfaultfd.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 07b0f6e03849..11227b94a5a7 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -1020,6 +1020,8 @@ static int resolve_userfault_fork(struct userfaultfd_ctx *ctx,
 {
 	int fd;
 
+	/* Regular inode here is okay: only CAP_SYS_PTRACE callers
+	 * can monitor forks.  */
 	fd = anon_inode_getfd("[userfaultfd]", &userfaultfd_fops, new,
 			      O_RDWR | (new->flags & UFFD_SHARED_FCNTL_FLAGS));
 	if (fd < 0)
@@ -1972,8 +1974,9 @@ SYSCALL_DEFINE1(userfaultfd, int, flags)
 	/* prevent the mm struct to be freed */
 	mmgrab(ctx->mm);
 
-	fd = anon_inode_getfd("[userfaultfd]", &userfaultfd_fops, ctx,
-			      O_RDWR | (flags & UFFD_SHARED_FCNTL_FLAGS));
+	fd = anon_inode_getfd2("[userfaultfd]", &userfaultfd_fops, ctx,
+			       O_RDWR | (flags & UFFD_SHARED_FCNTL_FLAGS),
+			       ANON_INODE_SECURE);
 	if (fd < 0) {
 		mmdrop(ctx->mm);
 		kmem_cache_free(userfaultfd_ctx_cachep, ctx);
-- 
2.25.0.225.g125e21ebc7-goog


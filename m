Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2E923FE091
	for <lists+linux-api@lfdr.de>; Wed,  1 Sep 2021 19:01:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345421AbhIARC1 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 1 Sep 2021 13:02:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344671AbhIARCZ (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 1 Sep 2021 13:02:25 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C11DC061760
        for <linux-api@vger.kernel.org>; Wed,  1 Sep 2021 10:01:29 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id u13-20020a17090abb0db0290177e1d9b3f7so182543pjr.1
        for <linux-api@vger.kernel.org>; Wed, 01 Sep 2021 10:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fDYDxGn9/2hirkiSwWqbGb/jVR4QCNJAlyLf3pM01ag=;
        b=NCBcs+qXKkHXynAqh1mW+/LePxDKou5Akl96KUIGFBvHCvGcwuijM11gmUXbGWkzhh
         WFB3m1t2gkDrAWDWO4lswkiRdJO48zuuj/+9VEy0W06ckydyw3tYv83KR4fp0TO63TyU
         c7Dn3v1l8iJXBDF5GGW+g5FGGWXHhZLscA2GYKP1ksB5h1UJGRd51XmQjHl29xGPGtfD
         vWg5Gw/6s/nbcO3GMBx3mQIFFntR693iAJXmOLbOZ6hQEr4iLYri7wFPMAEtJr/U1BPf
         o894KXRSENnT6UtaXAdtZORO8pFTEDDCa1o4NQP6dUsPGhMc3LLe+yfQ94uuwHEU5BzS
         HVGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fDYDxGn9/2hirkiSwWqbGb/jVR4QCNJAlyLf3pM01ag=;
        b=uirZDMtln7PgyE+jvkMsoys7D4K/IejQpZiuU3xrj9Hn6ZXwDFD9E1vBIsM3juE04w
         FIQfUNhNg3DCy/cBwSS1+8Wvd5lG5zAIVozhqFlYfAlFGWdGTI/vKi0NXcp5RxloLB66
         YvQSZ10CY/hWQO6pPH+qQydLdRUCzWiu1haAcbPW8zTpDdrqrZ8wGYqn2Me2Qenc3FN4
         HPHQjNCCgaV/j41PujhSdhLxKqp3276m2ramBqI2gsQqkU9XgH5D+X1QiFackFAk/xBW
         lAOfpD74bh7KJncxrmvfdudBD21SESyRugo3kVT3rf7HI18/WMEWzCrnFe6uHcEtKLtC
         Xrzg==
X-Gm-Message-State: AOAM532iBdo3imPBZjDt6F4iJ8pNP2NHbQzHHYZ5X5g9oJiCFhX8bIEA
        /izv0d9jGCmQC+FWqvqvZPFPgA==
X-Google-Smtp-Source: ABdhPJxpE5Z1d7BoWuVU6QjIy0rSMp/5NJSJN3ZhXv+MK6qV6h34oeqdAKdSx7aLPesMJzl+sxlvvw==
X-Received: by 2002:a17:90b:601:: with SMTP id gb1mr392186pjb.96.1630515688503;
        Wed, 01 Sep 2021 10:01:28 -0700 (PDT)
Received: from relinquished.tfbnw.net ([2620:10d:c090:400::5:a2b2])
        by smtp.gmail.com with ESMTPSA id y7sm58642pff.206.2021.09.01.10.01.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Sep 2021 10:01:27 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org
Subject: [PATCH v11 01/14] fs: export rw_verify_area()
Date:   Wed,  1 Sep 2021 10:00:56 -0700
Message-Id: <9cd494dbd55c46a22f07c56ca42a399af78accd1.1630514529.git.osandov@fb.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <cover.1630514529.git.osandov@fb.com>
References: <cover.1630514529.git.osandov@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

I'm adding Btrfs ioctls to read and write compressed data, and rather
than duplicating the checks in rw_verify_area(), let's just export it.

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 fs/internal.h      | 5 -----
 fs/read_write.c    | 1 +
 include/linux/fs.h | 1 +
 3 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/fs/internal.h b/fs/internal.h
index 82e8eb32ff3d..f471894d87d4 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -165,11 +165,6 @@ extern char *simple_dname(struct dentry *, char *, int);
 extern void dput_to_list(struct dentry *, struct list_head *);
 extern void shrink_dentry_list(struct list_head *);
 
-/*
- * read_write.c
- */
-extern int rw_verify_area(int, struct file *, const loff_t *, size_t);
-
 /*
  * pipe.c
  */
diff --git a/fs/read_write.c b/fs/read_write.c
index 9db7adf160d2..0029ff2b0ca8 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -400,6 +400,7 @@ int rw_verify_area(int read_write, struct file *file, const loff_t *ppos, size_t
 	return security_file_permission(file,
 				read_write == READ ? MAY_READ : MAY_WRITE);
 }
+EXPORT_SYMBOL(rw_verify_area);
 
 static ssize_t new_sync_read(struct file *filp, char __user *buf, size_t len, loff_t *ppos)
 {
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 1751addcb36e..0de4d75339b9 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3274,6 +3274,7 @@ extern loff_t fixed_size_llseek(struct file *file, loff_t offset,
 		int whence, loff_t size);
 extern loff_t no_seek_end_llseek_size(struct file *, loff_t, int, loff_t);
 extern loff_t no_seek_end_llseek(struct file *, loff_t, int);
+extern int rw_verify_area(int, struct file *, const loff_t *, size_t);
 extern int generic_file_open(struct inode * inode, struct file * filp);
 extern int nonseekable_open(struct inode * inode, struct file * filp);
 extern int stream_open(struct inode * inode, struct file * filp);
-- 
2.33.0


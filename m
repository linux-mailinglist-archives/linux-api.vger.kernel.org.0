Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B39C5132DD7
	for <lists+linux-api@lfdr.de>; Tue,  7 Jan 2020 19:00:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728519AbgAGR7w (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 7 Jan 2020 12:59:52 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:41451 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728507AbgAGR7g (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 7 Jan 2020 12:59:36 -0500
Received: by mail-pl1-f195.google.com with SMTP id bd4so18132plb.8
        for <linux-api@vger.kernel.org>; Tue, 07 Jan 2020 09:59:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eB+H+wKtr9wg6rNJfWFUAgXbI+ShVm182xgfnmGZIDU=;
        b=lJ1N1mcaGLZP4bT4c0ZIaXqktcuv43wBr2iHYz2PFdsVMaokOo5disBOQMODE4/gRJ
         TCfcLK+HIdcvx4gEttetYlyl7ISnn6L+kXOuovJTpc3K9Tj66KpnZoRs7iQAH/qXezQk
         OPGSn5Qdjuy13zHtBoxyUf6dcQzQ1+DrpbfBI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eB+H+wKtr9wg6rNJfWFUAgXbI+ShVm182xgfnmGZIDU=;
        b=rx2kk1onUiGsWx4wH094Zvbtv0DTZlM84Epz3WxjYWPy9NYoa7HujXj7bAx6DcsYYN
         ZCTu/KLiR+f6/m9ocL50JFwt9YEfUxTjLdQI4vn7Mv9OD7q6yGTsLnFOH29y+SCn2+dF
         SErpfTM0L9ZB7kLmPuJlGV6PZz5m+fC5vJZHY8oHvOvqNQB7eYbniqYyD54celIUhWd5
         yLyr9UQT7WyqPP/mqwDUEzSdVt/7aCCF60NwewELVc7L1fEOnT4oUfYFCXgjrBXGJWon
         1rdUH7pb4c5jCyLfghOeZnNtDsEOvc/3/C2yPWrXmHJjI10xI+bumtexZugzBdfIgK5K
         F5Dg==
X-Gm-Message-State: APjAAAXsSJX6EveNsWc5UhzS92nwO3xCelZnxsSJAwZ2D1xccz98ohrP
        UKurAw8PguBd3DNI7oy5dXDKQgxnFGlI8Q==
X-Google-Smtp-Source: APXvYqzdAR63ZVO5XhAlHQOIPk6WtkC1AcpXSqF+PMoF3FqFiCO9B7Jtd9HGDax2x6bUwj+nV3DV2Q==
X-Received: by 2002:a17:902:8b89:: with SMTP id ay9mr845427plb.309.1578419975544;
        Tue, 07 Jan 2020 09:59:35 -0800 (PST)
Received: from ubuntu.netflix.com (166.sub-174-194-208.myvzw.com. [174.194.208.166])
        by smtp.gmail.com with ESMTPSA id g7sm210324pfq.33.2020.01.07.09.59.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 09:59:34 -0800 (PST)
From:   Sargun Dhillon <sargun@sargun.me>
To:     linux-kernel@vger.kernel.org,
        containers@lists.linux-foundation.org, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Cc:     Sargun Dhillon <sargun@sargun.me>, tycho@tycho.ws,
        jannh@google.com, cyphar@cyphar.com, christian.brauner@ubuntu.com,
        oleg@redhat.com, luto@amacapital.net, viro@zeniv.linux.org.uk,
        gpascutto@mozilla.com, ealvarez@mozilla.com, fweimer@redhat.com,
        jld@mozilla.com, arnd@arndb.de
Subject: [PATCH v9 1/4] vfs, fdtable: Add fget_task helper
Date:   Tue,  7 Jan 2020 09:59:24 -0800
Message-Id: <20200107175927.4558-2-sargun@sargun.me>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200107175927.4558-1-sargun@sargun.me>
References: <20200107175927.4558-1-sargun@sargun.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

This introduces a function which can be used to fetch a file, given an
arbitrary task. As long as the user holds a reference (refcnt) to the
task_struct it is safe to call, and will either return NULL on failure,
or a pointer to the file, with a refcnt.

This patch is based on Oleg Nesterov's (cf. [1]) patch from September
2018.

[1]: Link: https://lore.kernel.org/r/20180915160423.GA31461@redhat.com

Signed-off-by: Sargun Dhillon <sargun@sargun.me>
Suggested-by: Oleg Nesterov <oleg@redhat.com>
Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 fs/file.c            | 22 ++++++++++++++++++++--
 include/linux/file.h |  2 ++
 2 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/fs/file.c b/fs/file.c
index 2f4fcf985079..2fc5eeef54a4 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -706,9 +706,9 @@ void do_close_on_exec(struct files_struct *files)
 	spin_unlock(&files->file_lock);
 }
 
-static struct file *__fget(unsigned int fd, fmode_t mask, unsigned int refs)
+static struct file *__fget_files(struct files_struct *files, unsigned int fd,
+				 fmode_t mask, unsigned int refs)
 {
-	struct files_struct *files = current->files;
 	struct file *file;
 
 	rcu_read_lock();
@@ -729,6 +729,12 @@ static struct file *__fget(unsigned int fd, fmode_t mask, unsigned int refs)
 	return file;
 }
 
+static inline struct file *__fget(unsigned int fd, fmode_t mask,
+				  unsigned int refs)
+{
+	return __fget_files(current->files, fd, mask, refs);
+}
+
 struct file *fget_many(unsigned int fd, unsigned int refs)
 {
 	return __fget(fd, FMODE_PATH, refs);
@@ -746,6 +752,18 @@ struct file *fget_raw(unsigned int fd)
 }
 EXPORT_SYMBOL(fget_raw);
 
+struct file *fget_task(struct task_struct *task, unsigned int fd)
+{
+	struct file *file = NULL;
+
+	task_lock(task);
+	if (task->files)
+		file = __fget_files(task->files, fd, 0, 1);
+	task_unlock(task);
+
+	return file;
+}
+
 /*
  * Lightweight file lookup - no refcnt increment if fd table isn't shared.
  *
diff --git a/include/linux/file.h b/include/linux/file.h
index 3fcddff56bc4..c6c7b24ea9f7 100644
--- a/include/linux/file.h
+++ b/include/linux/file.h
@@ -16,6 +16,7 @@ extern void fput(struct file *);
 extern void fput_many(struct file *, unsigned int);
 
 struct file_operations;
+struct task_struct;
 struct vfsmount;
 struct dentry;
 struct inode;
@@ -47,6 +48,7 @@ static inline void fdput(struct fd fd)
 extern struct file *fget(unsigned int fd);
 extern struct file *fget_many(unsigned int fd, unsigned int refs);
 extern struct file *fget_raw(unsigned int fd);
+extern struct file *fget_task(struct task_struct *task, unsigned int fd);
 extern unsigned long __fdget(unsigned int fd);
 extern unsigned long __fdget_raw(unsigned int fd);
 extern unsigned long __fdget_pos(unsigned int fd);
-- 
2.20.1


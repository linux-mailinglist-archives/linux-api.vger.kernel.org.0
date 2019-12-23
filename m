Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 546FD129AF7
	for <lists+linux-api@lfdr.de>; Mon, 23 Dec 2019 22:08:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbfLWVI6 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 23 Dec 2019 16:08:58 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:39238 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726817AbfLWVI6 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 23 Dec 2019 16:08:58 -0500
Received: by mail-io1-f68.google.com with SMTP id c16so15950013ioh.6
        for <linux-api@vger.kernel.org>; Mon, 23 Dec 2019 13:08:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=CX/EMM8AnWfaI4rNz03pFAf5OWqiTpv8JaYTV9Mz/lc=;
        b=RP+Gp26fE7zmIx/lxWxOU5NDvBBwKUBVTvmluoGZdVoZzxmnL4q/jEUO/yoodyjEOY
         1RU3FU//wLSW9nuw4ZD4yQfAf3jRp+o+i16WGEI+t/COb11uGvU9g28RpLK132XrJGfu
         IUkx/apzaH4xHfJ/PGGgORat0xD2kMBRbRVi0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=CX/EMM8AnWfaI4rNz03pFAf5OWqiTpv8JaYTV9Mz/lc=;
        b=dS6OBkB3/Z5dCQab8bLX5FVFvD2kC7e4SNvjXQ8PSFnRmVxZKP3SSRA+D2eiTYZRaG
         xQyQgZEjD8rVwXiwsUJhPq0NwOiaUXoXo1ayp1kIpPeOXMevX25HjGgnhCF77rxM2uf/
         6RrOAojtHeFTVhBpKd4zy/XSsy1GcXjrrWU1UHvMA6YRmZUbwskn+HtBZrVFoEFmwZxn
         myyJOjIRALL3etan/R1X0UQnrF+nGO9RfJsLzkBVZJEnNEa4FlhJG3ZOb4X4DGY1FD82
         VMghh1lvqqPOAzr/J5Fl9rt1Ei5uYEsS4YwmC10KZwk6Cn3mVr1VDQ+6hoYBJPEEogYN
         7Kog==
X-Gm-Message-State: APjAAAWtCNyuRCriEpsYvI6u+eqfCk+836rn+WdvJ6ai0+n071v5aOTE
        qC9AFmvmnt2CdmW4nWNP7p5BnQ==
X-Google-Smtp-Source: APXvYqzmur0UBakToKLcoAZwt/TOPUgo1jerBZz8qPeOgEb/aozooaumeBPL4p3Dbg/jb27H7n4Cpg==
X-Received: by 2002:a5d:8b04:: with SMTP id k4mr22120558ion.229.1577135337433;
        Mon, 23 Dec 2019 13:08:57 -0800 (PST)
Received: from ircssh-2.c.rugged-nimbus-611.internal (80.60.198.104.bc.googleusercontent.com. [104.198.60.80])
        by smtp.gmail.com with ESMTPSA id s8sm6554840iom.46.2019.12.23.13.08.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Dec 2019 13:08:56 -0800 (PST)
Date:   Mon, 23 Dec 2019 21:08:55 +0000
From:   Sargun Dhillon <sargun@sargun.me>
To:     linux-kernel@vger.kernel.org,
        containers@lists.linux-foundation.org, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Cc:     tycho@tycho.ws, jannh@google.com, cyphar@cyphar.com,
        christian.brauner@ubuntu.com, oleg@redhat.com, luto@amacapital.net,
        viro@zeniv.linux.org.uk, gpascutto@mozilla.com,
        ealvarez@mozilla.com, fweimer@redhat.com, jld@mozilla.com,
        arnd@arndb.de
Subject: [PATCH v6 1/3] vfs, fdtable: Add get_task_file helper
Message-ID: <20191223210852.GA25101@ircssh-2.c.rugged-nimbus-611.internal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

This introduces a function which can be used to fetch a file, given an
arbitrary task. As long as the user holds a reference (refcnt) to the
task_struct it is safe to call, and will either return NULL on failure,
or a pointer to the file, with a refcnt.

Signed-off-by: Sargun Dhillon <sargun@sargun.me>
---
 fs/file.c            | 22 ++++++++++++++++++++--
 include/linux/file.h |  2 ++
 2 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/fs/file.c b/fs/file.c
index 2f4fcf985079..0ceeb046f4f3 100644
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
@@ -729,6 +729,11 @@ static struct file *__fget(unsigned int fd, fmode_t mask, unsigned int refs)
 	return file;
 }
 
+static struct file *__fget(unsigned int fd, fmode_t mask, unsigned int refs)
+{
+	return __fget_files(current->files, fd, mask, refs);
+}
+
 struct file *fget_many(unsigned int fd, unsigned int refs)
 {
 	return __fget(fd, FMODE_PATH, refs);
@@ -746,6 +751,19 @@ struct file *fget_raw(unsigned int fd)
 }
 EXPORT_SYMBOL(fget_raw);
 
+struct file *fget_task(struct task_struct *task, unsigned int fd)
+{
+	struct file *file = NULL;
+
+	task_lock(task);
+	if (task->files)
+		file = __fget_files(task->files, fd, 0, 1);
+
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


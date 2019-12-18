Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B185F125805
	for <lists+linux-api@lfdr.de>; Thu, 19 Dec 2019 00:53:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726700AbfLRXxb (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 18 Dec 2019 18:53:31 -0500
Received: from mail-il1-f194.google.com ([209.85.166.194]:45836 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726623AbfLRXxb (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 18 Dec 2019 18:53:31 -0500
Received: by mail-il1-f194.google.com with SMTP id p8so3222228iln.12
        for <linux-api@vger.kernel.org>; Wed, 18 Dec 2019 15:53:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=CX/EMM8AnWfaI4rNz03pFAf5OWqiTpv8JaYTV9Mz/lc=;
        b=xT1nyXIQt4g7KeMROF00XdFlDcMJlPPSB0k5I3q3zaze+uv9zHWUzpmF+Objzre2bE
         vj6o+i17XYxtdKTLbME0YHvc9u+93nCtPJgQvPOZ+HLlV8cTOfn1j4COrnt5tSc+hgVm
         YiVFjIW1ovFnH0ZdJLDUwO3b6oyVDhCnjPrSk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=CX/EMM8AnWfaI4rNz03pFAf5OWqiTpv8JaYTV9Mz/lc=;
        b=TvT7/vQbKOhVrTCGl+w8YVLd5bXM52EHQEPJssMWpP+nIvxvCcDQyh5bfgDAyv2Lmj
         Ov1S1reTzRDHUQPCDj7e98fvdEQEdRrp8+ZkllgpoAVnTKoYsyt6E9HpQESJt/+zcEZx
         +I/jh9mVO1LtiVGKczGla6OCwzUtQ5k/Wc6ens3aGd4t8KRLkIESL4LKpeH/9mkbHZBM
         49v0XXlE847s3AG48ZM8YQBiqCUHu3BuxtySQqz0plbK26Ube0ZPjfwmL1fgCTcogiDJ
         Dh/Ih8hFC2O+uNI13H94S7n4LVGVUOWT03lKpNUnTKJKaNCCHZSMRGLJZnqiLzFlA+6A
         2fSQ==
X-Gm-Message-State: APjAAAXQTTNic4lHlGHylmrgHLpNycgesIcdhBfpfzkVDFL8LDWkp5aP
        naNZkw0XxObq+Gw8iWdF0aaeRA==
X-Google-Smtp-Source: APXvYqyDAcI9Qp/Mf2NvtcZBmoftpN5CG8w3ekpYEYJZnQufCnCSCNtzHl+YOdbrHP7vL+XPt9RsIw==
X-Received: by 2002:a92:8307:: with SMTP id f7mr4208307ild.183.1576713210234;
        Wed, 18 Dec 2019 15:53:30 -0800 (PST)
Received: from ircssh-2.c.rugged-nimbus-611.internal (80.60.198.104.bc.googleusercontent.com. [104.198.60.80])
        by smtp.gmail.com with ESMTPSA id h6sm789370iom.43.2019.12.18.15.53.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Dec 2019 15:53:30 -0800 (PST)
Date:   Wed, 18 Dec 2019 23:53:28 +0000
From:   Sargun Dhillon <sargun@sargun.me>
To:     linux-kernel@vger.kernel.org,
        containers@lists.linux-foundation.org, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Cc:     tycho@tycho.ws, jannh@google.com, cyphar@cyphar.com,
        christian.brauner@ubuntu.com, oleg@redhat.com, luto@amacapital.net,
        viro@zeniv.linux.org.uk, gpascutto@mozilla.com,
        ealvarez@mozilla.com, fweimer@redhat.com, jld@mozilla.com,
        arnd@arndb.de
Subject: [PATCH v4 1/5] vfs, fdtable: Add get_task_file helper
Message-ID: <20191218235326.GA17265@ircssh-2.c.rugged-nimbus-611.internal>
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


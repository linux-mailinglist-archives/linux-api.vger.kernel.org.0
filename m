Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A03671149F3
	for <lists+linux-api@lfdr.de>; Fri,  6 Dec 2019 00:44:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726034AbfLEXo4 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 5 Dec 2019 18:44:56 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:37023 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725927AbfLEXo4 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 5 Dec 2019 18:44:56 -0500
Received: by mail-io1-f67.google.com with SMTP id k24so5510460ioc.4
        for <linux-api@vger.kernel.org>; Thu, 05 Dec 2019 15:44:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=O5y+I+NBTV3CYsi8Y0eKSA3qAmcKH+wARhoPSX/lhnU=;
        b=oWok4eKo4kO/M/ELZaLHBxd9249/uSGFdhIPYjEeFF4Um05+bE8V9+78fCtaYydNLU
         Jx9Koo3xkEW9jj2Y5REjKex5cZYRlAg4LsfPEfGnO/9bGoRu1oK1RQrTRlHTF5J3JdOe
         JTrJ4qXawbqoWFiUY1rT1Sf/uMCnVue7+QLZM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=O5y+I+NBTV3CYsi8Y0eKSA3qAmcKH+wARhoPSX/lhnU=;
        b=M4KrEmjm3lGUyIyO8xg7YETYuPu9rkmXdKzqTHSK8FUzZ0nHoN/NHXmxrDaQgf7f+U
         apjkjLoM2VLqwh2zxDV1rfx/59ZtqFAPSjSA3jLlo5CcFn/MY4K1aZMntd4gTRzaUlxc
         fn4UjS6Ba4fqUXwWxpHVQLhhdNgmfz8WnJKYo9vYRXXEg5gCnbN1H3o7N0w6L1m1Dmbl
         hwgB3qcU2C5g0ew0pkBX0lrfEzTab52sNn61PgB+IU8BWzaGT4++mgh/V976PwnAn5+c
         bHX5HVL4EOHH8cb7a02HDNKUudp/jokMeoblts4OzYV0oziFJEJS3UUf7Wv60KK+eYin
         NwTg==
X-Gm-Message-State: APjAAAVBTnt3P8SA43vVAb7+PQ/Xqcqgt4EjU5kPN/imkJUuN02zNPYL
        PeLmWCDBmKmw3lGTVS3U3HkNMw==
X-Google-Smtp-Source: APXvYqwnRRAq+TLqz5SE1Zz+x68VXcrj8pQ7JAvbG+lT0lizID/I+3Jkqy1EW+f2W2XeI4wMQQ5XVA==
X-Received: by 2002:a02:7086:: with SMTP id f128mr10927139jac.128.1575589495597;
        Thu, 05 Dec 2019 15:44:55 -0800 (PST)
Received: from ircssh-2.c.rugged-nimbus-611.internal (80.60.198.104.bc.googleusercontent.com. [104.198.60.80])
        by smtp.gmail.com with ESMTPSA id z26sm2699172ior.44.2019.12.05.15.44.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Dec 2019 15:44:55 -0800 (PST)
Date:   Thu, 5 Dec 2019 23:44:53 +0000
From:   Sargun Dhillon <sargun@sargun.me>
To:     linux-kernel@vger.kernel.org,
        containers@lists.linux-foundation.org, linux-api@vger.kernel.org
Cc:     tycho@tycho.ws
Subject: [RFC PATCH] ptrace: add PTRACE_GETFD request
Message-ID: <20191205234450.GA26369@ircssh-2.c.rugged-nimbus-611.internal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

PTRACE_GETFD is a generic ptrace API that allows the tracer to
get file descriptors from the traceee.

The primary reason to use this syscall is to allow sandboxers to
take action on an FD on behalf of the tracee. For example, this
can be combined with seccomp's user notification feature to extract
a file descriptor and call privileged syscalls, like binding
a socket to a privileged port.

Signed-off-by: Sargun Dhillon <sargun@sargun.me>
---
 include/uapi/linux/ptrace.h |  5 +++++
 kernel/ptrace.c             | 39 +++++++++++++++++++++++++++++++++++--
 2 files changed, 42 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/ptrace.h b/include/uapi/linux/ptrace.h
index a71b6e3b03eb..2b69f759826a 100644
--- a/include/uapi/linux/ptrace.h
+++ b/include/uapi/linux/ptrace.h
@@ -101,6 +101,11 @@ struct ptrace_syscall_info {
 	};
 };
 
+/* This gets a file descriptor from a running process. It doesn't require the
+ * process to be stopped.
+ */
+#define PTRACE_GETFD	0x420f
+
 /*
  * These values are stored in task->ptrace_message
  * by tracehook_report_syscall_* to describe the current syscall-stop.
diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index cb9ddcc08119..a1d7b289fe8e 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -31,6 +31,7 @@
 #include <linux/cn_proc.h>
 #include <linux/compat.h>
 #include <linux/sched/signal.h>
+#include <linux/fdtable.h>
 
 #include <asm/syscall.h>	/* for syscall_get_* */
 
@@ -994,6 +995,37 @@ ptrace_get_syscall_info(struct task_struct *child, unsigned long user_size,
 }
 #endif /* CONFIG_HAVE_ARCH_TRACEHOOK */
 
+static int ptrace_getfd(struct task_struct *child, unsigned long fd)
+{
+	struct files_struct *files;
+	struct file *file;
+	int ret = 0;
+
+	files = get_files_struct(child);
+	if (!files)
+		return -ENOENT;
+
+	spin_lock(&files->file_lock);
+	file = fcheck_files(files, fd);
+	if (!file)
+		ret = -EBADF;
+	else
+		get_file(file);
+	spin_unlock(&files->file_lock);
+	put_files_struct(files);
+
+	if (ret)
+		goto out;
+
+	ret = get_unused_fd_flags(0);
+	if (ret >= 0)
+		fd_install(ret, file);
+
+	fput(file);
+out:
+	return ret;
+}
+
 int ptrace_request(struct task_struct *child, long request,
 		   unsigned long addr, unsigned long data)
 {
@@ -1222,7 +1254,9 @@ int ptrace_request(struct task_struct *child, long request,
 	case PTRACE_SECCOMP_GET_METADATA:
 		ret = seccomp_get_metadata(child, addr, datavp);
 		break;
-
+	case PTRACE_GETFD:
+		ret = ptrace_getfd(child, data);
+		break;
 	default:
 		break;
 	}
@@ -1265,7 +1299,8 @@ SYSCALL_DEFINE4(ptrace, long, request, long, pid, unsigned long, addr,
 	}
 
 	ret = ptrace_check_attach(child, request == PTRACE_KILL ||
-				  request == PTRACE_INTERRUPT);
+				  request == PTRACE_INTERRUPT ||
+				  request == PTRACE_GETFD);
 	if (ret < 0)
 		goto out_put_task_struct;
 
-- 
2.20.1


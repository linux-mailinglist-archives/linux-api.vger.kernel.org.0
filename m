Return-Path: <linux-api+bounces-1432-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 397018B7B50
	for <lists+linux-api@lfdr.de>; Tue, 30 Apr 2024 17:19:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 583DF1C2241D
	for <lists+linux-api@lfdr.de>; Tue, 30 Apr 2024 15:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84FAD140E26;
	Tue, 30 Apr 2024 15:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="YieStm/f"
X-Original-To: linux-api@vger.kernel.org
Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4447A152799;
	Tue, 30 Apr 2024 15:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714490382; cv=none; b=p3z3fHhd/FJ/e8h0HGfjvXLai1yjf714QRNqJmblk+LkhMZWIIDN380zl1+NLvtopuI0gUnDZWyVYV6YZArByUbF90ZKnDGJfvdIdPuLQNWlFM57o6LO8bCIk64qHaxpvzfL5xIbG4kF9KrrReyiop2K5dqSrgcKLVdwm0Vm1NA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714490382; c=relaxed/simple;
	bh=3E7LMLmQaL5tGcWs1QA023J3ddzjIGbmnfR3mFYjJhE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WtwqxlFcnbg7ST2/cn+yyuaCwDTcGBBriYbjmCoXB97MuclcYWvyxCb0DsVJ/MtqCFD7bKt8tWmdDLC7Bvq+sbapjvE9huilppPST0gs4NvKdQ8vWLOyxCHjc2JwDJypYkEcRcLqa15yVmx346owRSpqfWTmsJlRppGc0OZb3cI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=YieStm/f; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1714490373;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=qUFnqnB6znIDj+q1NPyYoIZ8zE7Eb30cXcMkX9V8te8=;
	b=YieStm/fos4plj+5Ek/rF7kivqnOKzhbGlbaVKsjn1Gw+zNmiQIxJgveo8SWf6+AMwtCGN
	CeIaurK0s4NnFnCSnQm6e0Uj3qZqEgSxaTlX/yKMSVyYiJ6m1dGSpaowCotc2qGEKNJ9Uw
	qmlrZ8WYGQ0jrHHFUNVDOsO9PoDwA472NoV15Qu2vw/dl/ZpO5WWPyTW81vXdcFRjF3wU4
	oO1W6ZULxpa9NICTJEywCCI55em3Jw9m/1wKJ9deK/jKVecaoEWB9R1ajXaEL6Siu0bJc8
	12b4Ur1naQKhHOvtXwar45HEQXxD8fAACvVu9yf02oQo4k6TdXBlvaf3y+iORA==
To: brauner@kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
	Jan Kara <jack@suse.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Arnd Bergmann <arnd@arndb.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Kees Cook <keescook@chromium.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Casey Schaufler <casey@schaufler-ca.com>,
	"peterz@infradead.org" <peterz@infradead.org>,
	Sohil Mehta <sohil.mehta@intel.com>,
	Miklos Szeredi <mszeredi@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org
Subject: [PATCH] fs/xattr: unify *at syscalls
Date: Tue, 30 Apr 2024 17:19:14 +0200
Message-ID: <20240430151917.30036-1-cgoettsche@seltendoof.de>
Reply-To: cgzones@googlemail.com
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Christian Göttsche <cgzones@googlemail.com>

Use the same parameter ordering for all four newly added *xattrat
syscalls:

    dirfd, pathname, at_flags, ...

Also consistently use unsigned int as the type for at_flags.

Suggested-by: Jan Kara <jack@suse.com>
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 fs/xattr.c               | 36 +++++++++++++++++++-----------------
 include/linux/syscalls.h |  8 +++++---
 2 files changed, 24 insertions(+), 20 deletions(-)

diff --git a/fs/xattr.c b/fs/xattr.c
index 45603e74c632..454304046d7d 100644
--- a/fs/xattr.c
+++ b/fs/xattr.c
@@ -931,17 +931,18 @@ listxattr(struct dentry *d, char __user *list, size_t size)
 	return error;
 }
 
-static ssize_t do_listxattrat(int dfd, const char __user *pathname, char __user *list,
-			      size_t size, int flags)
+static ssize_t do_listxattrat(int dfd, const char __user *pathname,
+			      unsigned int at_flags,
+			      char __user *list, size_t size)
 {
 	struct path path;
 	ssize_t error = 0;
 	int lookup_flags;
 
-	if ((flags & ~(AT_SYMLINK_NOFOLLOW | AT_EMPTY_PATH)) != 0)
+	if ((at_flags & ~(AT_SYMLINK_NOFOLLOW | AT_EMPTY_PATH)) != 0)
 		return -EINVAL;
 
-	if (flags & AT_EMPTY_PATH && vfs_empty_path(dfd, pathname)) {
+	if (at_flags & AT_EMPTY_PATH && vfs_empty_path(dfd, pathname)) {
 		CLASS(fd, f)(dfd);
 
 		if (!f.file)
@@ -965,22 +966,23 @@ static ssize_t do_listxattrat(int dfd, const char __user *pathname, char __user
 	return error;
 }
 
-SYSCALL_DEFINE5(listxattrat, int, dfd, const char __user *, pathname, char __user *, list,
-		size_t, size, int, flags)
+SYSCALL_DEFINE5(listxattrat, int, dfd, const char __user *, pathname,
+		unsigned int, at_flags,
+		char __user *, list, size_t, size)
 {
-	return do_listxattrat(dfd, pathname, list, size, flags);
+	return do_listxattrat(dfd, pathname, at_flags, list, size);
 }
 
 SYSCALL_DEFINE3(listxattr, const char __user *, pathname, char __user *, list,
 		size_t, size)
 {
-	return do_listxattrat(AT_FDCWD, pathname, list, size, 0);
+	return do_listxattrat(AT_FDCWD, pathname, 0, list, size);
 }
 
 SYSCALL_DEFINE3(llistxattr, const char __user *, pathname, char __user *, list,
 		size_t, size)
 {
-	return do_listxattrat(AT_FDCWD, pathname, list, size, AT_SYMLINK_NOFOLLOW);
+	return do_listxattrat(AT_FDCWD, pathname, AT_SYMLINK_NOFOLLOW, list, size);
 }
 
 SYSCALL_DEFINE3(flistxattr, int, fd, char __user *, list, size_t, size)
@@ -1019,17 +1021,17 @@ removexattr(struct mnt_idmap *idmap, struct dentry *d,
 }
 
 static int do_removexattrat(int dfd, const char __user *pathname,
-			    const char __user *name, int flags)
+			    unsigned int at_flags, const char __user *name)
 {
 	struct path path;
 	int error;
 	int lookup_flags;
 
-	if ((flags & ~(AT_SYMLINK_NOFOLLOW | AT_EMPTY_PATH)) != 0)
+	if ((at_flags & ~(AT_SYMLINK_NOFOLLOW | AT_EMPTY_PATH)) != 0)
 		return -EINVAL;
 
-	lookup_flags = (flags & AT_SYMLINK_NOFOLLOW) ? 0 : LOOKUP_FOLLOW;
-	if (flags & AT_EMPTY_PATH)
+	lookup_flags = (at_flags & AT_SYMLINK_NOFOLLOW) ? 0 : LOOKUP_FOLLOW;
+	if (at_flags & AT_EMPTY_PATH)
 		lookup_flags |= LOOKUP_EMPTY;
 retry:
 	error = user_path_at(dfd, pathname, lookup_flags, &path);
@@ -1049,21 +1051,21 @@ static int do_removexattrat(int dfd, const char __user *pathname,
 }
 
 SYSCALL_DEFINE4(removexattrat, int, dfd, const char __user *, pathname,
-		const char __user *, name, int, flags)
+		unsigned int, at_flags, const char __user *, name)
 {
-	return do_removexattrat(dfd, pathname, name, flags);
+	return do_removexattrat(dfd, pathname, at_flags, name);
 }
 
 SYSCALL_DEFINE2(removexattr, const char __user *, pathname,
 		const char __user *, name)
 {
-	return do_removexattrat(AT_FDCWD, pathname, name, 0);
+	return do_removexattrat(AT_FDCWD, pathname, 0, name);
 }
 
 SYSCALL_DEFINE2(lremovexattr, const char __user *, pathname,
 		const char __user *, name)
 {
-	return do_removexattrat(AT_FDCWD, pathname, name, AT_SYMLINK_NOFOLLOW);
+	return do_removexattrat(AT_FDCWD, pathname, AT_SYMLINK_NOFOLLOW, name);
 }
 
 SYSCALL_DEFINE2(fremovexattr, int, fd, const char __user *, name)
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index e06fffc48535..ca3cba698602 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -356,15 +356,17 @@ asmlinkage long sys_fgetxattr(int fd, const char __user *name,
 			      void __user *value, size_t size);
 asmlinkage long sys_listxattr(const char __user *path, char __user *list,
 			      size_t size);
-asmlinkage long sys_listxattrat(int dfd, const char __user *path, char __user *list,
-			      size_t size, int flags);
+asmlinkage long sys_listxattrat(int dfd, const char __user *path,
+				unsigned int at_flags,
+				char __user *list, size_t size);
 asmlinkage long sys_llistxattr(const char __user *path, char __user *list,
 			       size_t size);
 asmlinkage long sys_flistxattr(int fd, char __user *list, size_t size);
 asmlinkage long sys_removexattr(const char __user *path,
 				const char __user *name);
 asmlinkage long sys_removexattrat(int dfd, const char __user *path,
-				const char __user *name, int flags);
+				  unsigned int at_flags,
+				  const char __user *name);
 asmlinkage long sys_lremovexattr(const char __user *path,
 				 const char __user *name);
 asmlinkage long sys_fremovexattr(int fd, const char __user *name);
-- 
2.43.0



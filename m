Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 64BAACA0BD
	for <lists+linux-api@lfdr.de>; Thu,  3 Oct 2019 16:56:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730319AbfJCO4W (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 3 Oct 2019 10:56:22 -0400
Received: from mx2.mailbox.org ([80.241.60.215]:11276 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726364AbfJCO4V (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 3 Oct 2019 10:56:21 -0400
Received: from smtp2.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id C800FA1DD9;
        Thu,  3 Oct 2019 16:56:18 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.240])
        by gerste.heinlein-support.de (gerste.heinlein-support.de [91.198.250.173]) (amavisd-new, port 10030)
        with ESMTP id sQCs1Y8x6r5z; Thu,  3 Oct 2019 16:56:15 +0200 (CEST)
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Michael Kerrisk <mtk.manpages@gmail.com>
Cc:     Aleksa Sarai <cyphar@cyphar.com>,
        Christian Brauner <christian@brauner.io>,
        Aleksa Sarai <asarai@suse.de>, linux-man@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH RFC 1/3] symlink.7: document magic-links more completely
Date:   Fri,  4 Oct 2019 00:55:39 +1000
Message-Id: <20191003145542.17490-2-cyphar@cyphar.com>
In-Reply-To: <20191003145542.17490-1-cyphar@cyphar.com>
References: <20191003145542.17490-1-cyphar@cyphar.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Traditionally, magic-links have not been a well-understood topic in
Linux. Given the new changes in their semantics (related to the link
mode of trailing magic-links), it seems like a good opportunity to shine
more light on magic-links and their semantics.

Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
---
 man7/path_resolution.7 | 15 +++++++++++++++
 man7/symlink.7         | 39 ++++++++++++++++++++++++++++++---------
 2 files changed, 45 insertions(+), 9 deletions(-)

diff --git a/man7/path_resolution.7 b/man7/path_resolution.7
index 07664ed8faec..46f25ec4cdfa 100644
--- a/man7/path_resolution.7
+++ b/man7/path_resolution.7
@@ -136,6 +136,21 @@ we are just creating it.
 The details on the treatment
 of the final entry are described in the manual pages of the specific
 system calls.
+.PP
+Since Linux 5.FOO, if the final entry is a "magic-link" (see
+.BR symlink (7)),
+and the user is attempting to
+.BR open (2)
+it, then there is an additional permission-related restriction applied to the
+operation: the requested access mode must not exceed the "link mode" of the
+magic-link (unlike ordinary symlinks, magic-links have their own file mode.)
+For example, if
+.I /proc/[pid]/fd/[num]
+has a link mode of
+.BR 0500 ,
+unprivileged users are not permitted to
+.BR open ()
+the magic-link for writing.
 .SS . and ..
 By convention, every directory has the entries "." and "..",
 which refer to the directory itself and to its parent directory,
diff --git a/man7/symlink.7 b/man7/symlink.7
index 9f5bddd5dc21..33f0ec703acd 100644
--- a/man7/symlink.7
+++ b/man7/symlink.7
@@ -84,6 +84,25 @@ as they are implemented on Linux and other systems,
 are outlined here.
 It is important that site-local applications also conform to these rules,
 so that the user interface can be as consistent as possible.
+.SS Magic-links
+There is a special class of symlink-like objects known as "magic-links" which
+can be found in certain pseudo-filesystems such as
+.BR proc (5)
+(examples include
+.IR /proc/[pid]/exe " and " /proc/[pid]/fd/* .)
+Unlike normal symlinks, magic-links are not resolved through
+pathname-expansion, but instead act as direct references to the kernel's own
+representation of a file handle. As such, these magic-links allow users to
+access files which cannot be referenced with normal paths (such as unlinked
+files still referenced by a running program.)
+.PP
+Because they can bypass ordinary
+.BR mount_namespaces (7)-based
+restrictions, magic-links have been used as attack vectors in various exploits.
+As such (since Linux 5.FOO), there are additional restrictions placed on the
+re-opening of magic-links (see
+.BR path_resolution (7)
+for more details.)
 .SS Symbolic link ownership, permissions, and timestamps
 The owner and group of an existing symbolic link can be changed
 using
@@ -99,16 +118,18 @@ of a symbolic link can be changed using
 or
 .BR lutimes (3).
 .PP
-On Linux, the permissions of a symbolic link are not used
-in any operations; the permissions are always
-0777 (read, write, and execute for all user categories),
 .\" Linux does not currently implement an lchmod(2).
-and can't be changed.
-(Note that there are some "magic" symbolic links in the
-.I /proc
-directory tree\(emfor example, the
-.IR /proc/[pid]/fd/*
-files\(emthat have different permissions.)
+On Linux, the permissions of an ordinary symbolic link are not used in any
+operations; the permissions are always 0777 (read, write, and execute for all
+user categories), and can't be changed.
+.PP
+However, magic-links do not follow this rule. They can have a non-0777 mode,
+which is used for permission checks when the final
+component of an
+.BR open (2)'s
+path is a magic-link (see
+.BR path_resolution (7).)
+
 .\"
 .\" The
 .\" 4.4BSD
-- 
2.23.0


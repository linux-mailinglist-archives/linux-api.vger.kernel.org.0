Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F2B23CA0BA
	for <lists+linux-api@lfdr.de>; Thu,  3 Oct 2019 16:56:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730090AbfJCO4U (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 3 Oct 2019 10:56:20 -0400
Received: from mx2.mailbox.org ([80.241.60.215]:11298 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729763AbfJCO4U (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 3 Oct 2019 10:56:20 -0400
Received: from smtp2.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:105:465:1:1:0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id F038FA2053;
        Thu,  3 Oct 2019 16:56:18 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.240])
        by spamfilter06.heinlein-hosting.de (spamfilter06.heinlein-hosting.de [80.241.56.125]) (amavisd-new, port 10030)
        with ESMTP id yutPT4LhNCyR; Thu,  3 Oct 2019 16:56:15 +0200 (CEST)
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Michael Kerrisk <mtk.manpages@gmail.com>
Cc:     Aleksa Sarai <cyphar@cyphar.com>,
        Christian Brauner <christian@brauner.io>,
        Aleksa Sarai <asarai@suse.de>, linux-man@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH RFC 2/3] open.2: add O_EMPTYPATH documentation
Date:   Fri,  4 Oct 2019 00:55:40 +1000
Message-Id: <20191003145542.17490-3-cyphar@cyphar.com>
In-Reply-To: <20191003145542.17490-1-cyphar@cyphar.com>
References: <20191003145542.17490-1-cyphar@cyphar.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Some of the wording around empty paths in path_resolution(7) also needed
to be reworked since it's now legal (if you pass O_EMPTYPATH).

Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
---
 man2/open.2            | 42 +++++++++++++++++++++++++++++++++++++++++-
 man7/path_resolution.7 | 17 ++++++++++++++++-
 2 files changed, 57 insertions(+), 2 deletions(-)

diff --git a/man2/open.2 b/man2/open.2
index b0f485b41589..7217fe056e5e 100644
--- a/man2/open.2
+++ b/man2/open.2
@@ -48,7 +48,7 @@
 .\" FIXME . Apr 08: The next POSIX revision has O_EXEC, O_SEARCH, and
 .\" O_TTYINIT.  Eventually these may need to be documented.  --mtk
 .\"
-.TH OPEN 2 2018-04-30 "Linux" "Linux Programmer's Manual"
+.TH OPEN 2 2019-10-03 "Linux" "Linux Programmer's Manual"
 .SH NAME
 open, openat, creat \- open and possibly create a file
 .SH SYNOPSIS
@@ -421,6 +421,21 @@ was followed by a call to
 .BR fdatasync (2)).
 .IR "See NOTES below" .
 .TP
+.BR O_EMPTYPATH " (since Linux 5.FOO)"
+If \fIpathname\fP is an empty string, re-open the the file descriptor given as
+the \fIdirfd\fP argument to
+.BR openat (2).
+This can be used with both ordinary (file and directory) and \fBO_PATH\fP file
+descriptors, but cannot be used with
+.BR AT_FDCWD
+(or as an argument to plain
+.BR open (2).) When re-opening an \fBO_PATH\fP file descriptor, the same "link
+mode" restrictions apply as with re-opening through
+.BR proc (5)
+(see
+.BR path_resolution "(7) and " symlink (7)
+for more details.)
+.TP
 .B O_EXCL
 Ensure that this call creates the file:
 if this flag is specified in conjunction with
@@ -668,6 +683,13 @@ with
 (or via procfs using
 .BR AT_SYMLINK_FOLLOW )
 even if the file is not a directory.
+You can even "re-open" (or upgrade) an
+.BR O_PATH
+file descriptor by using
+.BR O_EMPTYPATH
+(see the section for
+.BR O_EMPTYPATH
+for more details.)
 .IP *
 Passing the file descriptor to another process via a UNIX domain socket
 (see
@@ -958,6 +980,15 @@ is not allowed.
 (See also
 .BR path_resolution (7).)
 .TP
+.B EBADF
+.I pathname
+was an empty string (and
+.B O_EMPTYPATH
+was passed) with
+.BR open (2)
+(instead of
+.BR openat (2).)
+.TP
 .B EDQUOT
 Where
 .B O_CREAT
@@ -1203,6 +1234,15 @@ The following additional errors can occur for
 .I dirfd
 is not a valid file descriptor.
 .TP
+.B EBADF
+.I pathname
+was an empty string (and
+.B O_EMPTYPATH
+was passed), but the provided
+.I dirfd
+was an invalid file descriptor (or was
+.BR AT_FDCWD .)
+.TP
 .B ENOTDIR
 .I pathname
 is a relative pathname and
diff --git a/man7/path_resolution.7 b/man7/path_resolution.7
index 46f25ec4cdfa..85dd354e9a93 100644
--- a/man7/path_resolution.7
+++ b/man7/path_resolution.7
@@ -22,7 +22,7 @@
 .\" the source, must acknowledge the copyright and authors of this work.
 .\" %%%LICENSE_END
 .\"
-.TH PATH_RESOLUTION 7 2017-11-26 "Linux" "Linux Programmer's Manual"
+.TH PATH_RESOLUTION 7 2019-10-03 "Linux" "Linux Programmer's Manual"
 .SH NAME
 path_resolution \- how a pathname is resolved to a file
 .SH DESCRIPTION
@@ -198,6 +198,21 @@ successfully.
 Linux returns
 .B ENOENT
 in this case.
+.PP
+As of Linux 5.FOO, an empty path argument can be used to indicate the "re-open"
+an existing file descriptor if
+.B O_EMPTYPATH
+is passed as a flag argument to
+.BR openat (2),
+with the
+.I dfd
+argument indicating which file descriptor to "re-open". This is approximately
+equivalent to opening
+.I /proc/self/fd/$fd
+where
+.I $fd
+is the open file descriptor to be "re-opened".
+
 .SS Permissions
 The permission bits of a file consist of three groups of three bits; see
 .BR chmod (1)
-- 
2.23.0


Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9672424FDAB
	for <lists+linux-api@lfdr.de>; Mon, 24 Aug 2020 14:25:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726953AbgHXMZA (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 24 Aug 2020 08:25:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:43841 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726818AbgHXMY6 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 24 Aug 2020 08:24:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598271896;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+d95Pyxxs3w7EuizFdEpLYSASJLAlQyWQNxxnlomYro=;
        b=MMagacSVTGwZGzCgXqc1WTnhrm32FGVxVxZqJe9HN2d28KqOjrC7kZtxVyeqO073DEn5q8
        /Dt5f+IySIBh4LDm7lZ4kkqX5DEdFjLrn/dJV0A+bxQ6SxZCk5SOk8BIibJy7INteCBAvF
        Prfv/UAIonkofsL/lfyxRt3R6JtxsYc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-328-2iQFX1_IPnuZkCEVfhg__Q-1; Mon, 24 Aug 2020 08:24:54 -0400
X-MC-Unique: 2iQFX1_IPnuZkCEVfhg__Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6C3991084C89;
        Mon, 24 Aug 2020 12:24:52 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-127.rdu2.redhat.com [10.10.120.127])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0B06D10098AE;
        Mon, 24 Aug 2020 12:24:50 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 2/5] Add manpages for move_mount(2)
From:   David Howells <dhowells@redhat.com>
To:     mtk.manpages@gmail.com, viro@zeniv.linux.org.uk
Cc:     dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-man@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 24 Aug 2020 13:24:50 +0100
Message-ID: <159827189025.306468.4916341547843731338.stgit@warthog.procyon.org.uk>
In-Reply-To: <159827188271.306468.16962617119460123110.stgit@warthog.procyon.org.uk>
References: <159827188271.306468.16962617119460123110.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Add manual pages to document the move_mount() system call.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 man2/move_mount.2 |  267 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 267 insertions(+)
 create mode 100644 man2/move_mount.2

diff --git a/man2/move_mount.2 b/man2/move_mount.2
new file mode 100644
index 000000000..2ceb775d9
--- /dev/null
+++ b/man2/move_mount.2
@@ -0,0 +1,267 @@
+'\" t
+.\" Copyright (c) 2020 David Howells <dhowells@redhat.com>
+.\"
+.\" %%%LICENSE_START(VERBATIM)
+.\" Permission is granted to make and distribute verbatim copies of this
+.\" manual provided the copyright notice and this permission notice are
+.\" preserved on all copies.
+.\"
+.\" Permission is granted to copy and distribute modified versions of this
+.\" manual under the conditions for verbatim copying, provided that the
+.\" entire resulting derived work is distributed under the terms of a
+.\" permission notice identical to this one.
+.\"
+.\" Since the Linux kernel and libraries are constantly changing, this
+.\" manual page may be incorrect or out-of-date.  The author(s) assume no
+.\" responsibility for errors or omissions, or for damages resulting from
+.\" the use of the information contained herein.  The author(s) may not
+.\" have taken the same level of care in the production of this manual,
+.\" which is licensed free of charge, as they might when working
+.\" professionally.
+.\"
+.\" Formatted or processed versions of this manual, if unaccompanied by
+.\" the source, must acknowledge the copyright and authors of this work.
+.\" %%%LICENSE_END
+.\"
+.TH MOVE_MOUNT 2 2020-08-24 "Linux" "Linux Programmer's Manual"
+.SH NAME
+move_mount \- Move mount objects around the filesystem topology
+.SH SYNOPSIS
+.nf
+.B #include <sys/types.h>
+.B #include <sys/mount.h>
+.B #include <unistd.h>
+.BR "#include <fcntl.h>           " "/* Definition of AT_* constants */"
+.PP
+.BI "int move_mount(int " from_dirfd ", const char *" from_pathname ","
+.BI "               int " to_dirfd ", const char *" to_pathname ","
+.BI "               unsigned int " flags );
+.fi
+.PP
+.IR Note :
+There is no glibc wrapper for this system call.
+.SH DESCRIPTION
+The
+.BR move_mount ()
+call moves a mount from one place to another; it can also be used to attach an
+unattached mount that was created by
+.BR fsmount "() or " open_tree "() with " OPEN_TREE_CLONE .
+.PP
+If
+.BR move_mount ()
+is called repeatedly with a file descriptor that refers to a mount object,
+then the object will be attached/moved the first time and then moved
+repeatedly, detaching it from the previous mountpoint each time.
+.PP
+To access the source mount object or the destination mountpoint, no
+permissions are required on the object itself, but if either pathname is
+supplied, execute (search) permission is required on all of the directories
+specified in
+.IR from_pathname " or " to_pathname .
+.PP
+The caller does, however, require the appropriate privilege (Linux: the
+.B CAP_SYS_ADMIN
+capability) to move or attach mounts.
+.PP
+.BR move_mount ()
+uses
+.IR from_pathname ", " from_dirfd " and part of " flags
+to locate the mount object to be moved and
+.IR to_pathname ", " to_dirfd " and another part of " flags
+to locate the destination mountpoint.  Each lookup can be done in one of a
+variety of ways:
+.TP
+[*] By absolute path.
+The pathname points to an absolute path and the dirfd is ignored.  The file is
+looked up by name, starting from the root of the filesystem as seen by the
+calling process.
+.TP
+[*] By cwd-relative path.
+The pathname points to a relative path and the dirfd is
+.IR AT_FDCWD .
+The file is looked up by name, starting from the current working directory.
+.TP
+[*] By dir-relative path.
+The pathname points to relative path and the dirfd indicates a file descriptor
+pointing to a directory.  The file is looked up by name, starting from the
+directory specified by
+.IR dirfd .
+.TP
+[*] By file descriptor.  The pathname is an empty string (""), the dirfd
+points directly to the mount object to move or the destination mount point and
+the appropriate
+.B *_EMPTY_PATH
+flag is set.
+.PP
+.I flags
+can be used to influence a path-based lookup.  The value for
+.I flags
+is constructed by OR'ing together zero or more of the following constants:
+.TP
+.BR MOVE_MOUNT_F_EMPTY_PATH
+.\" commit 65cfc6722361570bfe255698d9cd4dccaf47570d
+If
+.I from_pathname
+is an empty string, operate on the file referred to by
+.IR from_dirfd
+(which may have been obtained using the
+.BR open (2)
+.B O_PATH
+flag or
+.BR open_tree ())
+If
+.I from_dirfd
+is
+.BR AT_FDCWD ,
+the call operates on the current working directory.
+In this case,
+.I from_dirfd
+can refer to any type of file, not just a directory.
+This flag is Linux-specific; define
+.B _GNU_SOURCE
+.\" Before glibc 2.16, defining _ATFILE_SOURCE sufficed
+to obtain its definition.
+.TP
+.B MOVE_MOUNT_T_EMPTY_PATH
+As above, but operating on
+.IR to_pathname " and " to_dirfd .
+.TP
+.B MOVE_MOUNT_F_AUTOMOUNTS
+Don't automount the terminal ("basename") component of
+.I from_pathname
+if it is a directory that is an automount point.  This allows a mount object
+that has an automount point at its root to be moved and prevents unintended
+triggering of an automount point.
+The
+.B MOVE_MOUNT_F_AUTOMOUNTS
+flag has no effect if the automount point has already been mounted over.  This
+flag is Linux-specific; define
+.B _GNU_SOURCE
+.\" Before glibc 2.16, defining _ATFILE_SOURCE sufficed
+to obtain its definition.
+.TP
+.B MOVE_MOUNT_T_AUTOMOUNTS
+As above, but operating on
+.IR to_pathname " and " to_dirfd .
+This allows an automount point to be manually mounted over.
+.TP
+.B MOVE_MOUNT_F_SYMLINKS
+If
+.I from_pathname
+is a symbolic link, then dereference it.  The default for
+.BR move_mount ()
+is to not follow symlinks.
+.TP
+.B MOVE_MOUNT_T_SYMLINKS
+As above, but operating on
+.IR to_pathname " and " to_dirfd .
+.SH RETURN VALUE
+On success, 0 is returned.  On error, \-1 is returned, and
+.I errno
+is set appropriately.
+.SH ERRORS
+.TP
+.B EACCES
+Search permission is denied for one of the directories
+in the path prefix of
+.IR pathname .
+(See also
+.BR path_resolution (7).)
+.TP
+.B EBADF
+.IR from_dirfd " or " to_dirfd
+is not a valid open file descriptor.
+.TP
+.B EFAULT
+.IR from_pathname " or " to_pathname
+is NULL or either one point to a location outside the process's accessible
+address space.
+.TP
+.B EINVAL
+Reserved flag specified in
+.IR flags .
+.TP
+.B ELOOP
+Too many symbolic links encountered while traversing the pathname.
+.TP
+.B ENAMETOOLONG
+.IR from_pathname " or " to_pathname
+is too long.
+.TP
+.B ENOENT
+A component of
+.IR from_pathname " or " to_pathname
+does not exist, or one is an empty string and the appropriate
+.B *_EMPTY_PATH
+was not specified in
+.IR flags .
+.TP
+.B ENOMEM
+Out of memory (i.e., kernel memory).
+.TP
+.B ENOTDIR
+A component of the path prefix of
+.IR from_pathname " or " to_pathname
+is not a directory or one or the other is relative and the appropriate
+.I *_dirfd
+is a file descriptor referring to a file other than a directory.
+.SH VERSIONS
+.BR move_mount ()
+was added to Linux in kernel 5.2.
+.SH CONFORMING TO
+.BR move_mount ()
+is Linux-specific.
+.SH NOTES
+Glibc does not (yet) provide a wrapper for the
+.BR move_mount ()
+system call; call it using
+.BR syscall (2).
+.SH EXAMPLES
+The
+.BR move_mount ()
+function can be used like the following:
+.PP
+.RS
+.nf
+move_mount(AT_FDCWD, "/a", AT_FDCWD, "/b", 0);
+.fi
+.RE
+.PP
+This would move the object mounted on "/a" to "/b".  It can also be used in
+conjunction with
+.BR open_tree "(2) or " open "(2) with " O_PATH :
+.PP
+.RS
+.nf
+fd = open_tree(AT_FDCWD, "/mnt", 0);
+move_mount(fd, "", AT_FDCWD, "/mnt2", MOVE_MOUNT_F_EMPTY_PATH);
+move_mount(fd, "", AT_FDCWD, "/mnt3", MOVE_MOUNT_F_EMPTY_PATH);
+move_mount(fd, "", AT_FDCWD, "/mnt4", MOVE_MOUNT_F_EMPTY_PATH);
+.fi
+.RE
+.PP
+This would attach the path point for "/mnt" to fd, then it would move the
+mount to "/mnt2", then move it to "/mnt3" and finally to "/mnt4".
+.PP
+It can also be used to attach new mounts:
+.PP
+.RS
+.nf
+sfd = fsopen("ext4", FSOPEN_CLOEXEC);
+fsconfig(sfd, FSCONFIG_SET_STRING, "source", "/dev/sda1", 0);
+fsconfig(sfd, FSCONFIG_SET_FLAG, "user_xattr", NULL, 0);
+fsconfig(sfd, FSCONFIG_CMD_CREATE, NULL, NULL, 0);
+mfd = fsmount(sfd, FSMOUNT_CLOEXEC, MOUNT_ATTR_NODEV);
+move_mount(mfd, "", AT_FDCWD, "/home", MOVE_MOUNT_F_EMPTY_PATH);
+.fi
+.RE
+.PP
+Which would open the Ext4 filesystem mounted on "/dev/sda1", turn on user
+extended attribute support and create a mount object for it.  Finally, the new
+mount object would be attached with
+.BR move_mount ()
+to "/home".
+.SH SEE ALSO
+.BR fsmount (2),
+.BR fsopen (2),
+.BR open_tree (2)



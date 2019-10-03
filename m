Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E41FECA0C0
	for <lists+linux-api@lfdr.de>; Thu,  3 Oct 2019 16:56:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730427AbfJCO42 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 3 Oct 2019 10:56:28 -0400
Received: from mx2.mailbox.org ([80.241.60.215]:11590 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726364AbfJCO41 (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 3 Oct 2019 10:56:27 -0400
Received: from smtp2.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id 3A0BEA34F4;
        Thu,  3 Oct 2019 16:56:24 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.240])
        by gerste.heinlein-support.de (gerste.heinlein-support.de [91.198.250.173]) (amavisd-new, port 10030)
        with ESMTP id F8iJo-L6HAKE; Thu,  3 Oct 2019 16:56:20 +0200 (CEST)
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Michael Kerrisk <mtk.manpages@gmail.com>
Cc:     Aleksa Sarai <cyphar@cyphar.com>,
        Christian Brauner <christian@brauner.io>,
        Aleksa Sarai <asarai@suse.de>, linux-man@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH RFC 3/3] openat2.2: document new openat2(2) syscall
Date:   Fri,  4 Oct 2019 00:55:41 +1000
Message-Id: <20191003145542.17490-4-cyphar@cyphar.com>
In-Reply-To: <20191003145542.17490-1-cyphar@cyphar.com>
References: <20191003145542.17490-1-cyphar@cyphar.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Rather than trying to merge the new syscall documentation into open.2
(which would probably result in the man-page being incomprehensible),
instead the new syscall gets its own dedicated page with links between
open(2) and openat2(2) to avoid duplicating information such as the list
of O_* flags or common errors.

Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
---
 man2/open.2            |   5 +
 man2/openat2.2         | 381 +++++++++++++++++++++++++++++++++++++++++
 man7/path_resolution.7 |  57 ++++--
 3 files changed, 426 insertions(+), 17 deletions(-)
 create mode 100644 man2/openat2.2

diff --git a/man2/open.2 b/man2/open.2
index 7217fe056e5e..a0b43394bbee 100644
--- a/man2/open.2
+++ b/man2/open.2
@@ -65,6 +65,10 @@ open, openat, creat \- open and possibly create a file
 .BI "int openat(int " dirfd ", const char *" pathname ", int " flags );
 .BI "int openat(int " dirfd ", const char *" pathname ", int " flags \
 ", mode_t " mode );
+.PP
+/* Docuented separately, in \fBopenat2\fP(2). */
+.BI "int openat2(int " dirfd ", const char *" pathname ", \
+const struct open_how *" how ", size_t " size ");
 .fi
 .PP
 .in -4n
@@ -1808,6 +1812,7 @@ will create a regular file (i.e.,
 .B O_DIRECTORY
 is ignored).
 .SH SEE ALSO
+.BR openat2 (2),
 .BR chmod (2),
 .BR chown (2),
 .BR close (2),
diff --git a/man2/openat2.2 b/man2/openat2.2
new file mode 100644
index 000000000000..c43c76046243
--- /dev/null
+++ b/man2/openat2.2
@@ -0,0 +1,381 @@
+.\" Copyright (C) 2019 Aleksa Sarai <cyphar@cyphar.com>
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
+.TH OPENAT2 2 2019-10-03 "Linux" "Linux Programmer's Manual"
+.SH NAME
+openat2 \- open and possibly create a file (extended)
+.SH SYNOPSIS
+.nf
+.B #include <sys/types.h>
+.B #include <sys/stat.h>
+.B #include <fcntl.h>
+.PP
+.BI "int openat2(int " dirfd ", const char *" pathname ", \
+const struct open_how *" how ", size_t " size ");
+.fi
+.PP
+.IR Note :
+There is no glibc wrapper for this system call; see NOTES.
+.SH DESCRIPTION
+The
+.BR openat2 ()
+system call is an extension of
+.BR openat (2)
+and provides a superset of its functionality. Rather than taking a single
+.I flag
+argument, an extensible structure (\fIhow\fP) is passed instead to allow for
+seamless future extensions.
+.PP
+.I size
+must be set to
+.IR "sizeof(struct open_how)" ,
+to facilitate future extensions (see the "Extensibility" section of the
+\fBNOTES\fP for more detail on how extensions are handled.)
+
+.SS The open_how structure
+The following structure indicates how
+.I pathname
+should be opened, and acts as a superset of the
+.IR flag " and " mode
+arguments to
+.BR openat (2).
+.PP
+.in +4n
+.EX
+struct open_how {
+    uint32_t flags;              /* open(2)-style O_* flags. */
+    union {
+        uint16_t mode;           /* File mode bits for new file creation. */
+        uint16_t upgrade_mask;   /* Restrict how O_PATHs may be re-opened. */
+    };
+    uint32_t resolve;            /* RESOLVE_* path-resolution flags. */
+};
+.EE
+.in
+.PP
+Any future extensions to
+.BR openat2 ()
+will be implemented as new fields appended to the above structure, with the
+zero value of the new fields acting as though the extension were not present.
+.PP
+The meaning of each field is as follows:
+.RS
+
+.I flags
+.RS
+The file creation and status flags to use for this operation. All of the
+.B O_*
+flags defined for
+.BR openat (2)
+are valid
+.BR openat2 ()
+flag values.
+.RE
+
+.I upgrade_mask
+.RS
+Restrict with which
+.I access modes
+the returned
+.B O_PATH
+descriptor may be re-opened (either through
+.B O_EMPTYPATH
+or
+.IR /proc/self/fd/ .)
+This field may only be set to a non-zero value if
+.I flags
+contains
+.BR O_PATH .
+By default, an
+.B O_PATH
+file descriptor of an ordinary file may be re-opened with with any access mode (but an
+.B O_PATH
+file descriptor of a magic-link may only be re-opened with access modes that
+the original magic-link possessed). The full list of
+.I upgrade_mask
+flags is given below.
+.TP
+.B UPGRADE_NOREAD
+Do not permit the
+.B O_PATH
+file descriptor to be re-opened for reading (i.e.
+.BR O_RDONLY " or " O_RDWR .)
+.TP
+.B UPGRADE_NOWRITE
+Do not permit the
+.B O_PATH
+file descriptor to be re-opened for writing (i.e.
+.BR O_WRONLY ", " O_RDWR ", or " O_APPEND .)
+.RE
+
+.I resolve
+.RS
+Change how the components of
+.I pathname
+will be resolved (see
+.BR path_resolution (7)
+for background information.) The primary use-case for these flags is to allow
+trusted programs to restrict how un-trusted paths (or paths inside un-trusted
+directories) are resolved. The full list of
+.I resolve
+flags is given below.
+.TP
+.B RESOLVE_NO_XDEV
+Disallow all mount-point crossings during path resolution (including
+all bind-mounts).
+
+Users of this flag are encouraged to make its use configurable (unless it is
+used for a specific security purpose), as bind-mounts are very widely used by
+end-users and thus enabling this flag globally may result in spurious errors on
+some systems.
+.TP
+.B RESOLVE_NO_SYMLINKS
+Disallow all symlink resolution during path resolution. If the trailing
+component is a symlink, and
+.I flags
+contains both
+.BR O_PATH " and " O_NOFOLLOW ","
+then an
+.B O_PATH
+file descriptor referencing the symlink will be returned. This option implies
+.BR RESOLVE_NO_MAGICLINKS .
+
+Users of this flag are encouraged to make its use configurable (unless it is
+used for a specific security purpose), as symlinks are very widely used by
+end-users and thus enabling this flag globally may result in spurious errors on
+some systems.
+.TP
+.B RESOLVE_NO_MAGICLINKS
+Disallow all magic-link resolution during path resolution. If the trailing
+component is a magic-link, and
+.I flags
+contains both
+.BR O_PATH " and " O_NOFOLLOW ","
+then an
+.B O_PATH
+file descriptor referencing the magic-link will be returned.
+
+Magic-links are symlink-like objects that are most notably found in
+.BR proc (5)
+(examples include
+.IR /proc/[pid]/exe " and " /proc/[pid]/fd/* .)
+Due to the potential danger of unknowingly opening these magic-links, it may be
+preferable for users to disable their resolution entirely (see
+.BR symlink (7)
+for more details.)
+.TP
+.B RESOLVE_BENEATH
+Do not permit the path resolution to succeed if any component of the resolution
+is not a descendant of the directory indicated by
+.IR dirfd .
+This results in absolute symlinks (and absolute values of
+.IR pathname )
+to be rejected. Magic-link resolution is also not permitted.
+
+.TP
+.B RESOLVE_IN_ROOT
+Temporarily treat
+.I dirfd
+as the root of the filesystem (as though the user called
+.BR chroot (2)
+with
+.IR dirfd
+as the argument.) Absolute symlinks and ".." path components will be scoped to
+.IR dirfd . Magic-link resolution is also not permitted.
+
+However, unlike
+.BR chroot (2)
+(which changes the filesystem root persistently for an entire thread-group),
+.B RESOLVE_IN_ROOT
+allows a program to efficiently restrict path resolution for only certain
+operations. It also has several hardening features (such as not permitting
+magic-link resolution) which
+.BR chroot (2)
+does not.
+.RE
+
+.RE
+
+.PP
+Unlike
+.BR openat (2),
+any unknown flags set in fields of
+.I how
+will result in an error, rather than being ignored. In addition, an error will
+be returned if the value of the
+.IR mode " and " upgrade_mask
+union is non-zero unless:
+.RS
+.IP * 3
+.I flags
+indicates that a new file will be created (it contains
+.BR O_CREAT " or " O_TMPFILE ),
+in which case
+.I mode
+may be any valid file mode.
+.IP *
+.I flags
+contains
+.BR O_PATH ,
+in which case
+.I upgrade_mask
+must only contain valid
+.B UPGRADE_*
+flags.
+.RE
+
+.SH RETURN VALUE
+On success, a new file descriptor is returned. On error, -1 is returned, and
+.I errno
+is set appropriately.
+
+.SH ERRORS
+The set of errors returned by
+.BR openat2 ()
+includes all of the errors returned by
+.BR openat (2),
+as well as the following additional errors:
+.TP
+.B EINVAL
+An unknown flag or invalid value was specified in
+.IR how .
+.TP
+.B EINVAL
+.I size
+was smaller than any known version of
+.IR "struct open_how" .
+.TP
+.B E2BIG
+An extension was specified in
+.IR how ,
+which the current kernel does not support (see the "Extensibility" section of
+the \fBNOTES\fP for more detail on how extensions are handled.)
+.TP
+.B EAGAIN
+.I resolve
+contains either
+.BR RESOLVE_IN_ROOT " or " RESOLVE_BENEATH ,
+and the kernel could not ensure that a ".." component didn't escape (due to a
+race condition or potential attack). Callers may choose to retry the
+.BR openat2 ()
+call.
+.TP
+.B EXDEV
+.I resolve
+contains either
+.BR RESOLVE_IN_ROOT " or " RESOLVE_BENEATH ,
+and a path component attempted to escape the root of the resolution.
+
+.TP
+.B EXDEV
+.I resolve
+contains
+.BR RESOLVE_NO_XDEV ,
+and a path component attempted to cross a mount-point.
+
+.TP
+.B ELOOP
+.I resolve
+contains
+.BR RESOLVE_NO_SYMLINKS ,
+and one of the path components was a symlink.
+.TP
+.B ELOOP
+.I resolve
+contains
+.BR RESOLVE_NO_MAGICLINKS ,
+and one of the path components was a magic-link.
+
+.SH VERSIONS
+.BR openat2 ()
+was added to Linux in kernel 5.FOO.
+
+.SH CONFORMING TO
+This system call is Linux-specific.
+
+The semantics of
+.B RESOLVE_BENEATH
+were modelled after FreeBSD's
+.BR O_BENEATH .
+
+.SH NOTES
+Glibc does not provide a wrapper for this system call; call it using
+.BR syscall (2).
+
+.SS Extensibility
+In order to allow for
+.I struct open_how
+to be extended in future kernel revisions,
+.BR openat2 ()
+requires userspace to specify what sized
+.I struct open_how
+structure they are passing. By providing this information, it is possible for
+.BR openat2 ()
+to provide both forwards- and backwards-compatibility \(em with
+.I size
+acting as an implicit version number (because new extension fields will always
+be appended, the size will always increase.) This extensibility design is very
+similar to other system calls such as
+.BR perf_setattr "(2), " perf_event_open "(2), and " clone (3).
+
+If we let
+.I usize
+be the size of the structure according to userspace and
+.I ksize
+be the size of the structure which the kernel supports, then there are only
+three cases to consider:
+
+.RS
+.IP * 3
+If
+.IR ksize " equals " usize ,
+then there is no version mismatch and
+.I how
+can be used verbatim.
+.IP *
+If
+.IR ksize " is larger than " usize ,
+then there are some extensions the kernel supports which the userspace program
+is unaware of. Because all extensions must have their zero values be a no-op,
+the kernel treats all of the extension fields not set by userspace to have zero
+values. This provides backwards-compatibility.
+.IP *
+If
+.IR ksize " is smaller than " usize ,
+then there are some extensions which the userspace program is aware of but the
+kernel does not support. Because all extensions must have their zero values be
+a no-op, the kernel can safely ignore the unsupported extension fields if they
+are all-zero. If any unsupported extension fields are non-zero, then an error
+is returned. This provides forwards-compatibility.
+.RE
+
+Therefore, most userspace programs will not need to have any special handling
+of extensions. However, if a userspace program wishes to determine what
+extensions the running kernel supports, they may conduct a binary search on
+.IR size
+(to find the largest value which doesn't produce an error.)
+
+.SH SEE ALSO
+.BR openat (2),
+.BR path_resolution (7),
+.BR symlink (7)
diff --git a/man7/path_resolution.7 b/man7/path_resolution.7
index 85dd354e9a93..3da3e5b614c8 100644
--- a/man7/path_resolution.7
+++ b/man7/path_resolution.7
@@ -29,17 +29,17 @@ path_resolution \- how a pathname is resolved to a file
 Some UNIX/Linux system calls have as parameter one or more filenames.
 A filename (or pathname) is resolved as follows.
 .SS Step 1: start of the resolution process
-If the pathname starts with the \(aq/\(aq character,
-the starting lookup directory
-is the root directory of the calling process.
-(A process inherits its
-root directory from its parent.
-Usually this will be the root directory
-of the file hierarchy.
-A process may get a different root directory
-by use of the
+If the pathname starts with the \(aq/\(aq character, the starting lookup
+directory is the root directory of the calling process. (A process inherits its
+root directory from its parent. Usually this will be the root directory of the
+file hierarchy. A process may get a different root directory by use of the
 .BR chroot (2)
-system call.
+system call, or may temporarily use a different root directory by using
+.BR openat2 (2)
+with the
+.B RESOLVE_IN_ROOT
+flag set.
+.PP
 A process may get an entirely private mount namespace in case
 it\(emor one of its ancestors\(emwas started by an invocation of the
 .BR clone (2)
@@ -48,16 +48,24 @@ system call that had the
 flag set.)
 This handles the \(aq/\(aq part of the pathname.
 .PP
-If the pathname does not start with the \(aq/\(aq character, the
-starting lookup directory of the resolution process is the current working
-directory of the process.
-(This is also inherited from the parent.
-It can be changed by use of the
+If the pathname does not start with the \(aq/\(aq character, the starting
+lookup directory of the resolution process is the current working directory of
+the process \(em or in the case of
+.BR openat (2)-style
+syscalls, the
+.I dfd
+argument (or the current working directory if
+.B AT_FDCWD
+is passed as the
+.I dfd
+argumnet). The current working directory is inherited from the parent, and can
+be changed by use of the
 .BR chdir (2)
-system call.)
+syscall.
 .PP
 Pathnames starting with a \(aq/\(aq character are called absolute pathnames.
 Pathnames not starting with a \(aq/\(aq are called relative pathnames.
+
 .SS Step 2: walk along the path
 Set the current lookup directory to the starting lookup directory.
 Now, for each nonfinal component of the pathname, where a component
@@ -124,6 +132,13 @@ the kernel's pathname-resolution code
 was reworked to eliminate the use of recursion,
 so that the only limit that remains is the maximum of 40
 resolutions for the entire pathname.
+.PP
+The resolution of syscalls during this stage can be blocked by using
+.BR openat2 (2),
+with the
+.B RESOLVE_NO_SYMLINKS
+flag set.
+
 .SS Step 3: find the final entry
 The lookup of the final component of the pathname goes just like
 that of all other components, as described in the previous step,
@@ -160,7 +175,8 @@ The path resolution process will assume that these entries have
 their conventional meanings, regardless of whether they are
 actually present in the physical filesystem.
 .PP
-One cannot walk down past the root: "/.." is the same as "/".
+One cannot walk up past the root: "/.." is the same as "/".
+
 .SS Mount points
 After a "mount dev path" command, the pathname "path" refers to
 the root of the filesystem hierarchy on the device "dev", and no
@@ -169,6 +185,13 @@ longer to whatever it referred to earlier.
 One can walk out of a mounted filesystem: "path/.." refers to
 the parent directory of "path",
 outside of the filesystem hierarchy on "dev".
+.PP
+Mount-point crossings can be blocked by using
+.BR openat2 (2),
+with the
+.B RESOLVE_NO_XDEV
+flag set (though note that this also restricts bind-mount crossings).
+
 .SS Trailing slashes
 If a pathname ends in a \(aq/\(aq, that forces resolution of the preceding
 component as in Step 2: it has to exist and resolve to a directory.
-- 
2.23.0


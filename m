Return-Path: <linux-api+bounces-1090-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EC91C86F4C0
	for <lists+linux-api@lfdr.de>; Sun,  3 Mar 2024 13:15:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 515D81F21DDE
	for <lists+linux-api@lfdr.de>; Sun,  3 Mar 2024 12:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4192DBE5B;
	Sun,  3 Mar 2024 12:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZS0/j6H/"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1714DBE4A;
	Sun,  3 Mar 2024 12:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709468113; cv=none; b=RnM9vc/GzdmV7A5KUW1q4WCatTnm+DC7ZDVwd9XTfodfFTihZQfIDs/7ruMHLMLBZ5MyFkyKLMrEAX7UspSlrrzzoZo3V5HaVDgn2egAUQveYF3HvEl/c04svPUpXtdYAmHQEEnDmK1OkkvWWVxac2vBJYPrUajvu0yXTRTEzb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709468113; c=relaxed/simple;
	bh=jCE40057QLznCiWIMYKHFa42kcryCmexqrVSiA5PtPc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NW+/n6NHRt8s8Lfgq26mdT/XpekTb9joR00eCBWFPUL/3pYEyIlWyWgP20rFBvs62sso5esW6mzeiGbznraVVtutJbJRXCjcInfuKtrbs8xAyGoh4krvR9l732p8wZj8N96+cHvCaNSv+qtjaWzzCHB3PmC7/B6GPsBhsgvy9Rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZS0/j6H/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4D7DC433C7;
	Sun,  3 Mar 2024 12:15:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709468112;
	bh=jCE40057QLznCiWIMYKHFa42kcryCmexqrVSiA5PtPc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZS0/j6H/0gbXZihW79n73tG/MX8jZR0AT/Ap4R2ifDvLKmFVx0mHZtWXlSlULMR9t
	 SK1dZWsXfdkBE08fHqUqOmGlULuzrASl0SmKRV7VCfL2+nl4jc6m6MW4R5uXQPYx+A
	 HZXdkp+G/xqPpZ7dWEheu/tR2bmzIIjqMoMokaGR3yADz4LZP6dHDrAUyO9XPfEDAf
	 duCopgBpmGqZI9eF7Pj46ZSPrLnGsF8DdD8GkfvVfDo46zwMRA20GiJEC9dPYSfoUf
	 ptlaOvLbmWzysS5uD2NoigtdVzWTd0Ikg65IgY4DmDHcnAmpe9AHhAbLk1xpJ3lPz0
	 pMIQ+jjCfrUvA==
Date: Sun, 3 Mar 2024 13:15:09 +0100
From: Alejandro Colomar <alx@kernel.org>
To: Elliott Hughes <enh@google.com>, Stefan Puiu <stefan.puiu@gmail.com>, 
	Bruno Haible <bruno@clisp.org>, linux-man@vger.kernel.org
Cc: Alejandro Colomar <alx@kernel.org>, 
	GNU C Library <libc-alpha@sourceware.org>, linux-api@vger.kernel.org
Subject: [PATCH 1/2] man*/: epoll_*(), fcntl(), flock(), ioctl(), msgctl(),
 *prctl(), ptrace(), quotactl(), reboot(), semctl(), shmctl(), lockf():
 Consistently use 'op' and 'operation'
Message-ID: <20240303121454.16994-2-alx@kernel.org>
X-Mailer: git-send-email 2.43.0
References: <ZUIlirG-ypudgpbK@debian>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yu57s6mkxtlasuqe"
Content-Disposition: inline
In-Reply-To: <ZUIlirG-ypudgpbK@debian>


--yu57s6mkxtlasuqe
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: [PATCH 1/2] man*/: epoll_*(), fcntl(), flock(), ioctl(), msgctl(),
 *prctl(), ptrace(), quotactl(), reboot(), semctl(), shmctl(), lockf():
 Consistently use 'op' and 'operation'
MIME-Version: 1.0

Reported-by: Bruno Haible <bruno@clisp.org>
Cc: Elliott Hughes <enh@google.com>
Cc: Stefan Puiu <stefan.puiu@gmail.com>
Signed-off-by: Alejandro Colomar <alx@kernel.org>
---
 man2/arch_prctl.2          | 12 +++---
 man2/epoll_wait.2          |  4 +-
 man2/fcntl.2               | 70 +++++++++++++++----------------
 man2/flock.2               |  6 +--
 man2/ioctl.2               | 30 +++++++-------
 man2/ioctl_console.2       |  8 ++--
 man2/ioctl_fideduperange.2 |  2 +-
 man2/ioctl_getfsmap.2      |  6 +--
 man2/ioctl_ns.2            |  2 +-
 man2/ioctl_tty.2           | 10 ++---
 man2/ioctl_userfaultfd.2   | 10 ++---
 man2/msgctl.2              | 16 ++++----
 man2/prctl.2               | 84 +++++++++++++++++++-------------------
 man2/ptrace.2              | 60 +++++++++++++--------------
 man2/quotactl.2            | 34 +++++++--------
 man2/reboot.2              | 19 +++++----
 man2/semctl.2              | 22 +++++-----
 man2/shmctl.2              | 20 +++++----
 man3/lockf.3               | 11 ++---
 19 files changed, 217 insertions(+), 209 deletions(-)

diff --git a/man2/arch_prctl.2 b/man2/arch_prctl.2
index bbb85866c..680d36395 100644
--- a/man2/arch_prctl.2
+++ b/man2/arch_prctl.2
@@ -14,8 +14,8 @@ .SH SYNOPSIS
 .BR "#include <sys/syscall.h>" "      /* Definition of " SYS_* " constants=
 */"
 .B #include <unistd.h>
 .P
-.BI "int syscall(SYS_arch_prctl, int " code ", unsigned long " addr );
-.BI "int syscall(SYS_arch_prctl, int " code ", unsigned long *" addr );
+.BI "int syscall(SYS_arch_prctl, int " op ", unsigned long " addr );
+.BI "int syscall(SYS_arch_prctl, int " op ", unsigned long *" addr );
 .fi
 .P
 .IR Note :
@@ -26,8 +26,8 @@ .SH SYNOPSIS
 .SH DESCRIPTION
 .BR arch_prctl ()
 sets architecture-specific process or thread state.
-.I code
-selects a subfunction
+.I op
+selects an operation
 and passes argument
 .I addr
 to it;
@@ -120,8 +120,8 @@ .SH ERRORS
 points to an unmapped address or is outside the process address space.
 .TP
 .B EINVAL
-.I code
-is not a valid subcommand.
+.I op
+is not a valid operation.
 .TP
 .B ENODEV
 .B ARCH_SET_CPUID
diff --git a/man2/epoll_wait.2 b/man2/epoll_wait.2
index 2a0ad6364..20af75075 100644
--- a/man2/epoll_wait.2
+++ b/man2/epoll_wait.2
@@ -173,8 +173,8 @@ .SS epoll_pwait2()
 .SH RETURN VALUE
 On success,
 .BR epoll_wait ()
-returns the number of file descriptors ready for the requested I/O, or zero
-if no file descriptor became ready during the requested
+returns the number of file descriptors ready for the requested I/O operati=
on,
+or zero if no file descriptor became ready during the requested
 .I timeout
 milliseconds.
 On failure,
diff --git a/man2/fcntl.2 b/man2/fcntl.2
index 4973ab028..1f9b2d430 100644
--- a/man2/fcntl.2
+++ b/man2/fcntl.2
@@ -54,21 +54,21 @@ .SH SYNOPSIS
 .nf
 .B #include <fcntl.h>
 .P
-.BI "int fcntl(int " fd ", int " cmd ", ... /* " arg " */ );"
+.BI "int fcntl(int " fd ", int " op ", ... /* " arg " */ );"
 .fi
 .SH DESCRIPTION
 .BR fcntl ()
 performs one of the operations described below on the open file descriptor
 .IR fd .
 The operation is determined by
-.IR cmd .
+.IR op .
 .P
 .BR fcntl ()
 can take an optional third argument.
 Whether or not this argument is required is determined by
-.IR cmd .
+.IR op .
 The required argument type is indicated in parentheses after each
-.I cmd
+.I op
 name (in most cases, the required type is
 .IR int ,
 and we identify the argument using the name
@@ -83,7 +83,7 @@ .SH DESCRIPTION
 a particular operation is to invoke
 .BR fcntl ()
 with the desired
-.I cmd
+.I op
 value and then test whether the call failed with
 .BR EINVAL ,
 indicating that the kernel does not recognize this value.
@@ -121,7 +121,7 @@ .SS Duplicating a file descriptor
 in
 .BR open (2).
 .SS File descriptor flags
-The following commands manipulate the flags associated with
+The following operations manipulate the flags associated with
 a file descriptor.
 Currently, only one such flag is defined:
 .BR FD_CLOEXEC ,
@@ -198,7 +198,7 @@ .SS File status flags
 in
 .I arg
 are ignored.
-On Linux, this command can change only the
+On Linux, this operation can change only the
 .BR O_APPEND ,
 .BR O_ASYNC ,
 .BR O_DIRECT ,
@@ -529,9 +529,9 @@ .SS Open file description locks (non-POSIX)
 By contrast with traditional record locks, the
 .I l_pid
 field of that structure must be set to zero
-when using the commands described below.
+when using the operations described below.
 .P
-The commands for working with open file description locks are analogous
+The operations for working with open file description locks are analogous
 to those used with traditional locks:
 .TP
 .BR F_OFD_SETLK " (\fIstruct flock *\fP)"
@@ -722,7 +722,7 @@ .SS Managing signals
 This is done by using the
 .BR fcntl ()
 .B F_SETFL
-command to set the
+operation to set the
 .B O_ASYNC
 file status flag on the file descriptor.
 Subsequently, a
@@ -732,7 +732,7 @@ .SS Managing signals
 The
 .BR fcntl ()
 .B F_SETSIG
-command can be used to obtain delivery of a signal other than
+operation can be used to obtain delivery of a signal other than
 .BR SIGIO .
 .IP
 Sending a signal to the owner process (group) specified by
@@ -1120,7 +1120,7 @@ .SS Leases
 then either remove or downgrade its lease.
 A lease is removed by performing an
 .B F_SETLEASE
-command specifying
+operation specifying
 .I arg
 as
 .BR F_UNLCK .
@@ -1130,7 +1130,7 @@ .SS Leases
 the lease to a read lease.
 This is done by performing an
 .B F_SETLEASE
-command specifying
+operation specifying
 .I arg
 as
 .BR F_RDLCK .
@@ -1179,11 +1179,11 @@ .SS Leases
 .BR SIGIO ,
 but this can be changed using the
 .B F_SETSIG
-command to
+operation to
 .BR fcntl ().
 If a
 .B F_SETSIG
-command is performed (even one specifying
+operation is performed (even one specifying
 .BR SIGIO ),
 and the signal
 handler is established using
@@ -1289,7 +1289,7 @@ .SS File and directory change notification (dnotify)
 .BR SIGIO ,
 but this can be changed using the
 .B F_SETSIG
-command to
+operation to
 .BR fcntl ().
 (Note that
 .B SIGIO
@@ -1639,7 +1639,7 @@ .SH RETURN VALUE
 for the inode referred to by
 .IR fd .
 .TP
-All other commands
+All other operations
 Zero.
 .P
 On error, \-1 is returned, and
@@ -1659,7 +1659,7 @@ .SH ERRORS
 is not an open file descriptor
 .TP
 .B EBADF
-.I cmd
+.I op
 is
 .B F_SETLK
 or
@@ -1668,7 +1668,7 @@ .SH ERRORS
 type of lock requested.
 .TP
 .B EBUSY
-.I cmd
+.I op
 is
 .B F_SETPIPE_SZ
 and the new pipe capacity specified in
@@ -1677,7 +1677,7 @@ .SH ERRORS
 used to store data in the pipe.
 .TP
 .B EBUSY
-.I cmd
+.I op
 is
 .BR F_ADD_SEALS ,
 .I arg
@@ -1689,14 +1689,14 @@ .SH ERRORS
 .B EDEADLK
 It was detected that the specified
 .B F_SETLKW
-command would cause a deadlock.
+operation would cause a deadlock.
 .TP
 .B EFAULT
 .I lock
 is outside your accessible address space.
 .TP
 .B EINTR
-.I cmd
+.I op
 is
 .B F_SETLKW
 or
@@ -1705,7 +1705,7 @@ .SH ERRORS
 .BR signal (7).
 .TP
 .B EINTR
-.I cmd
+.I op
 is
 .BR F_GETLK ,
 .BR F_SETLK ,
@@ -1719,11 +1719,11 @@ .SH ERRORS
 .TP
 .B EINVAL
 The value specified in
-.I cmd
+.I op
 is not recognized by this kernel.
 .TP
 .B EINVAL
-.I cmd
+.I op
 is
 .B F_ADD_SEALS
 and
@@ -1731,7 +1731,7 @@ .SH ERRORS
 includes an unrecognized sealing bit.
 .TP
 .B EINVAL
-.I cmd
+.I op
 is
 .B F_ADD_SEALS
 or
@@ -1741,7 +1741,7 @@ .SH ERRORS
 does not support sealing.
 .TP
 .B EINVAL
-.I cmd
+.I op
 is
 .B F_DUPFD
 and
@@ -1753,7 +1753,7 @@ .SH ERRORS
 .BR getrlimit (2)).
 .TP
 .B EINVAL
-.I cmd
+.I op
 is
 .B F_SETSIG
 and
@@ -1761,7 +1761,7 @@ .SH ERRORS
 is not an allowable signal number.
 .TP
 .B EINVAL
-.I cmd
+.I op
 is
 .BR F_OFD_SETLK ,
 .BR F_OFD_SETLKW ,
@@ -1772,7 +1772,7 @@ .SH ERRORS
 was not specified as zero.
 .TP
 .B EMFILE
-.I cmd
+.I op
 is
 .B F_DUPFD
 and the per-process limit on the number of open file descriptors
@@ -1785,13 +1785,13 @@ .SH ERRORS
 .B ENOTDIR
 .B F_NOTIFY
 was specified in
-.IR cmd ,
+.IR op ,
 but
 .I fd
 does not refer to a directory.
 .TP
 .B EPERM
-.I cmd
+.I op
 is
 .B F_SETPIPE_SZ
 and the soft or hard user pipe limit has been reached; see
@@ -1803,7 +1803,7 @@ .SH ERRORS
 flag on a file that has the append-only attribute set.
 .TP
 .B EPERM
-.I cmd
+.I op
 was
 .BR F_ADD_SEALS ,
 but
@@ -1897,7 +1897,7 @@ .SS File locking
 system call was added in Linux 2.4.
 The newer system call employs a different structure for file locking,
 .IR flock64 ,
-and corresponding commands,
+and corresponding operations,
 .BR F_GETLK64 ,
 .BR F_SETLK64 ,
 and
@@ -1940,7 +1940,7 @@ .SS Record locks
 system call was added in Linux 2.4.
 The newer system call employs a different structure for file locking,
 .IR flock64 ,
-and corresponding commands,
+and corresponding operations,
 .BR F_GETLK64 ,
 .BR F_SETLK64 ,
 and
diff --git a/man2/flock.2 b/man2/flock.2
index 279c983ad..9c8f5b3b7 100644
--- a/man2/flock.2
+++ b/man2/flock.2
@@ -22,13 +22,13 @@ .SH SYNOPSIS
 .nf
 .B #include <sys/file.h>
 .P
-.BI "int flock(int " fd ", int " operation );
+.BI "int flock(int " fd ", int " op );
 .fi
 .SH DESCRIPTION
 Apply or remove an advisory lock on the open file specified by
 .IR fd .
 The argument
-.I operation
+.I op
 is one of the following:
 .RS 4
 .TP 9
@@ -111,7 +111,7 @@ .SH ERRORS
 .BR signal (7).
 .TP
 .B EINVAL
-.I operation
+.I op
 is invalid.
 .TP
 .B ENOLCK
diff --git a/man2/ioctl.2 b/man2/ioctl.2
index c10a5e2ec..5b8c28a9c 100644
--- a/man2/ioctl.2
+++ b/man2/ioctl.2
@@ -20,8 +20,8 @@ .SH SYNOPSIS
 .nf
 .B #include <sys/ioctl.h>
 .P
-.BI "int ioctl(int " fd ", unsigned long " request ", ...);" "\f[R]  /* gl=
ibc, BSD */\f[]"
-.BI "int ioctl(int " fd ", int " request ", ...);" "\f[R]            /* mu=
sl, other UNIX */\f[]"
+.BI "int ioctl(int " fd ", unsigned long " op ", ...);" "\f[R]  /* glibc, =
BSD */\f[]"
+.BI "int ioctl(int " fd ", int " op ", ...);" "\f[R]            /* musl, o=
ther UNIX */\f[]"
 .fi
 .SH DESCRIPTION
 The
@@ -30,12 +30,12 @@ .SH DESCRIPTION
 In particular, many operating characteristics of character special files
 (e.g., terminals) may be controlled with
 .BR ioctl ()
-requests.
+operations.
 The argument
 .I fd
 must be an open file descriptor.
 .P
-The second argument is a device-dependent request code.
+The second argument is a device-dependent operation code.
 The third argument is an untyped pointer to memory.
 It's traditionally
 .BI "char *" argp
@@ -45,7 +45,7 @@ .SH DESCRIPTION
 .P
 An
 .BR ioctl ()
-.I request
+.I op
 has encoded in it whether the argument is an
 .I in
 parameter or
@@ -55,7 +55,7 @@ .SH DESCRIPTION
 in bytes.
 Macros and defines used in specifying an
 .BR ioctl ()
-.I request
+.I op
 are located in the file
 .IR <sys/ioctl.h> .
 See NOTES.
@@ -63,7 +63,7 @@ .SH RETURN VALUE
 Usually, on success zero is returned.
 A few
 .BR ioctl ()
-requests use the return value as an output parameter
+operations use the return value as an output parameter
 and return a nonnegative value on success.
 On error, \-1 is returned, and
 .I errno
@@ -79,7 +79,7 @@ .SH ERRORS
 references an inaccessible memory area.
 .TP
 .B EINVAL
-.I request
+.I op
 or
 .I argp
 is not valid.
@@ -89,7 +89,7 @@ .SH ERRORS
 is not associated with a character special device.
 .TP
 .B ENOTTY
-The specified request does not apply to the kind of object that the
+The specified operation does not apply to the kind of object that the
 file descriptor
 .I fd
 references.
@@ -106,7 +106,7 @@ .SH HISTORY
 .PD 0
 .in +4n
 .nf
-.BI "ioctl(int " fildes ", int " request ", struct sgttyb *" argp );
+.BI "ioctl(int " fildes ", int " op ", struct sgttyb *" argp );
 .fi
 .in
 .P
@@ -117,7 +117,7 @@ .SH HISTORY
 .BR stty (2)
 and
 .BR gtty (2),
-and is polymorphic by request type (like a
+and is polymorphic by operation type (like a
 .B void *
 would be, if it had been available)).
 .P
@@ -129,7 +129,7 @@ .SH HISTORY
 .PD 0
 .in +4n
 .nf
-.BI "ioctl(int " d ", unsigned long " request ", char *" argp );
+.BI "ioctl(int " d ", unsigned long " op ", char *" argp );
 .fi
 .in
 .P
@@ -143,7 +143,7 @@ .SH HISTORY
 .PD 0
 .in +4n
 .nf
-.BI "int ioctl(int " fildes ", int " request ", ... /* " arg " */);"
+.BI "int ioctl(int " fildes ", int " op ", ... /* " arg " */);"
 .fi
 .in
 .P
@@ -159,7 +159,9 @@ .SH NOTES
 .\"
 .SS ioctl structure
 .\" added two sections - aeb
-Ioctl command values are 32-bit constants.
+Ioctl
+.I op
+values are 32-bit constants.
 In principle these constants are completely arbitrary, but people have
 tried to build some structure into them.
 .P
diff --git a/man2/ioctl_console.2 b/man2/ioctl_console.2
index abc50b786..93a992264 100644
--- a/man2/ioctl_console.2
+++ b/man2/ioctl_console.2
@@ -25,8 +25,8 @@ .SH NAME
 .SH DESCRIPTION
 The following Linux-specific
 .BR ioctl (2)
-requests are supported for console terminals and virtual consoles.
-Each requires a third argument, assumed here to be
+operations are supported for console terminals and virtual consoles.
+Each operation requires a third argument, assumed here to be
 .IR argp .
 .TP
 .B KDGETLED
@@ -546,7 +546,7 @@ .SH DESCRIPTION
 struct vt_mode {
     char  mode;    /* vt mode */
     char  waitv;   /* if set, hang on writes if not active */
-    short relsig;  /* signal to raise on release req */
+    short relsig;  /* signal to raise on release op */
     short acqsig;  /* signal to raise on acquisition */
     short frsig;   /* unused (set to 0) */
 };
@@ -861,7 +861,7 @@ .SH ERRORS
 .TP
 .B ENOTTY
 The file descriptor is not associated with a character special device,
-or the specified request does not apply to it.
+or the specified operation does not apply to it.
 .TP
 .B EPERM
 Insufficient permission.
diff --git a/man2/ioctl_fideduperange.2 b/man2/ioctl_fideduperange.2
index 8f43a28cc..1942c8fd0 100644
--- a/man2/ioctl_fideduperange.2
+++ b/man2/ioctl_fideduperange.2
@@ -116,7 +116,7 @@ .SH DESCRIPTION
 and a status code for the deduplication operation is returned in
 .IR status .
 If even a single byte in the range does not match, the deduplication
-request will be ignored and
+operation request will be ignored and
 .I status
 set to
 .BR FILE_DEDUPE_RANGE_DIFFERS .
diff --git a/man2/ioctl_getfsmap.2 b/man2/ioctl_getfsmap.2
index 0b0546743..fa9d91894 100644
--- a/man2/ioctl_getfsmap.2
+++ b/man2/ioctl_getfsmap.2
@@ -124,7 +124,7 @@ .SS Keys
 .I fsmap_head.fmh_keys[0]
 must contain the low key and
 .I fsmap_head.fmh_keys[1]
-must contain the high key for the request.
+must contain the high key for the operation.
 .P
 For convenience, if
 .I fmr_length
@@ -328,10 +328,10 @@ .SH ERRORS
 was passed in one of the fields that must be zero.
 .TP
 .B ENOMEM
-Insufficient memory to process the request.
+Insufficient memory to process the operation.
 .TP
 .B EOPNOTSUPP
-The filesystem does not support this command.
+The filesystem does not support this operation.
 .TP
 .B EUCLEAN
 The filesystem metadata is corrupt and needs repair.
diff --git a/man2/ioctl_ns.2 b/man2/ioctl_ns.2
index 61a1afe65..958a686b0 100644
--- a/man2/ioctl_ns.2
+++ b/man2/ioctl_ns.2
@@ -20,7 +20,7 @@ .SS Discovering namespace relationships
 .P
 .in +4n
 .EX
-new_fd =3D ioctl(fd, request);
+new_fd =3D ioctl(fd, op);
 .EE
 .in
 .P
diff --git a/man2/ioctl_tty.2 b/man2/ioctl_tty.2
index 9f198b1d8..c458933a2 100644
--- a/man2/ioctl_tty.2
+++ b/man2/ioctl_tty.2
@@ -18,12 +18,12 @@ .SH SYNOPSIS
 .BR    "                               Bnnn" ", " BOTHER ", " CBAUD ", " C=
LOCAL ,
 .BR    "                               TC*" { FLUSH , ON , OFF "} and othe=
r constants */"
 .P
-.BI "int ioctl(int " fd ", int " cmd ", ...);"
+.BI "int ioctl(int " fd ", int " op ", ...);"
 .fi
 .SH DESCRIPTION
 The
 .BR ioctl (2)
-call for terminals and serial ports accepts many possible command argument=
s.
+call for terminals and serial ports accepts many possible operation argume=
nts.
 Most require a third argument, of varying type, here called
 .I argp
 or
@@ -735,7 +735,7 @@ .SS Kernel debugging
 .I tty_struct
 corresponding to
 .IR fd .
-This command was removed in Linux 2.5.67.
+This operation was removed in Linux 2.5.67.
 .\"     commit b3506a09d15dc5aee6d4bb88d759b157016e1864
 .\"     Author: Andries E. Brouwer <andries.brouwer@cwi.nl>
 .\"     Date:   Tue Apr 1 04:42:46 2003 -0800
@@ -764,10 +764,10 @@ .SH RETURN VALUE
 .SH ERRORS
 .TP
 .B EINVAL
-Invalid command parameter.
+Invalid operation parameter.
 .TP
 .B ENOIOCTLCMD
-Unknown command.
+Unknown operation.
 .TP
 .B ENOTTY
 Inappropriate
diff --git a/man2/ioctl_userfaultfd.2 b/man2/ioctl_userfaultfd.2
index a2380a670..cbd0c7978 100644
--- a/man2/ioctl_userfaultfd.2
+++ b/man2/ioctl_userfaultfd.2
@@ -17,7 +17,7 @@ .SH SYNOPSIS
 .BR "#include <linux/userfaultfd.h>" "  /* Definition of " UFFD* " constan=
ts */"
 .B #include <sys/ioctl.h>
 .P
-.BI "int ioctl(int " fd ", int " cmd ", ...);"
+.BI "int ioctl(int " fd ", int " op ", ...);"
 .fi
 .SH DESCRIPTION
 Various
@@ -28,18 +28,18 @@ .SH DESCRIPTION
 .P
 .in +4n
 .EX
-ioctl(fd, cmd, argp);
+ioctl(fd, op, argp);
 .EE
 .in
 .P
 In the above,
 .I fd
 is a file descriptor referring to a userfaultfd object,
-.I cmd
-is one of the commands listed below, and
+.I op
+is one of the operations listed below, and
 .I argp
 is a pointer to a data structure that is specific to
-.IR cmd .
+.IR op .
 .P
 The various
 .BR ioctl (2)
diff --git a/man2/msgctl.2 b/man2/msgctl.2
index 3e69eb600..70f4d1cf8 100644
--- a/man2/msgctl.2
+++ b/man2/msgctl.2
@@ -26,12 +26,12 @@ .SH SYNOPSIS
 .nf
 .B #include <sys/msg.h>
 .P
-.BI "int msgctl(int " msqid ", int " cmd ", struct msqid_ds *" buf );
+.BI "int msgctl(int " msqid ", int " op ", struct msqid_ds *" buf );
 .fi
 .SH DESCRIPTION
 .BR msgctl ()
 performs the control operation specified by
-.I cmd
+.I op
 on the System\ V message queue with identifier
 .IR msqid .
 .P
@@ -142,7 +142,7 @@ .SH DESCRIPTION
 Bits 0100, 0010, and 0001 (the execute bits) are unused by the system.
 .P
 Valid values for
-.I cmd
+.I op
 are:
 .TP
 .B IPC_STAT
@@ -320,7 +320,7 @@ .SH ERRORS
 .TP
 .B EACCES
 The argument
-.I cmd
+.I op
 is equal to
 .B IPC_STAT
 or
@@ -333,7 +333,7 @@ .SH ERRORS
 .TP
 .B EFAULT
 The argument
-.I cmd
+.I op
 has the value
 .B IPC_SET
 or
@@ -347,7 +347,7 @@ .SH ERRORS
 .TP
 .B EINVAL
 Invalid value for
-.I cmd
+.I op
 or
 .IR msqid .
 Or: for a
@@ -358,7 +358,7 @@ .SH ERRORS
 .TP
 .B EPERM
 The argument
-.I cmd
+.I op
 has the value
 .B IPC_SET
 or
@@ -402,7 +402,7 @@ .SH HISTORY
 (The kernel distinguishes old and new calls by an
 .B IPC_64
 flag in
-.IR cmd .)
+.IR op .)
 .SH NOTES
 The
 .BR IPC_INFO ,
diff --git a/man2/prctl.2 b/man2/prctl.2
index 31da22369..fad855832 100644
--- a/man2/prctl.2
+++ b/man2/prctl.2
@@ -46,7 +46,7 @@ .SH SYNOPSIS
 .nf
 .B #include <sys/prctl.h>
 .P
-.BI "int prctl(int " operation ", ..."
+.BI "int prctl(int " op ", ..."
 .BI "          \fR/*\fP unsigned long " arg2 ", unsigned long " arg3 ,
 .BI "          unsigned long " arg4 ", unsigned long " arg5 " \fR*/\fP );"
 .fi
@@ -2096,7 +2096,7 @@ .SH RETURN VALUE
 .B PR_GET_SECCOMP
 return the nonnegative values described above.
 All other
-.I operation
+.I op
 values return 0 on success.
 On error, \-1 is returned, and
 .I errno
@@ -2104,7 +2104,7 @@ .SH RETURN VALUE
 .SH ERRORS
 .TP
 .B EACCES
-.I operation
+.I op
 is
 .B PR_SET_SECCOMP
 and
@@ -2120,7 +2120,7 @@ .SH ERRORS
 above).
 .TP
 .B EACCES
-.I operation
+.I op
 is
 .BR PR_SET_MM ,
 and
@@ -2130,7 +2130,7 @@ .SH ERRORS
 the file is not executable.
 .TP
 .B EBADF
-.I operation
+.I op
 is
 .BR PR_SET_MM ,
 .I arg3
@@ -2141,7 +2141,7 @@ .SH ERRORS
 is not valid.
 .TP
 .B EBUSY
-.I operation
+.I op
 is
 .BR PR_SET_MM ,
 .I arg3
@@ -2156,7 +2156,7 @@ .SH ERRORS
 is an invalid address.
 .TP
 .B EFAULT
-.I operation
+.I op
 is
 .BR PR_SET_SECCOMP ,
 .I arg2
@@ -2169,7 +2169,7 @@ .SH ERRORS
 is an invalid address.
 .TP
 .B EFAULT
-.I operation
+.I op
 is
 .B PR_SET_SYSCALL_USER_DISPATCH
 and
@@ -2178,12 +2178,12 @@ .SH ERRORS
 .TP
 .B EINVAL
 The value of
-.I operation
+.I op
 is not recognized,
 or not supported on this system.
 .TP
 .B EINVAL
-.I operation
+.I op
 is
 .B PR_MCE_KILL
 or
@@ -2197,10 +2197,10 @@ .SH ERRORS
 .B EINVAL
 .I arg2
 is not valid value for this
-.IR operation .
+.IR op .
 .TP
 .B EINVAL
-.I operation
+.I op
 is
 .B PR_SET_SECCOMP
 or
@@ -2209,7 +2209,7 @@ .SH ERRORS
 .BR CONFIG_SECCOMP .
 .TP
 .B EINVAL
-.I operation
+.I op
 is
 .BR PR_SET_SECCOMP ,
 .I arg2
@@ -2219,7 +2219,7 @@ .SH ERRORS
 .BR CONFIG_SECCOMP_FILTER .
 .TP
 .B EINVAL
-.I operation
+.I op
 is
 .BR PR_SET_MM ,
 and one of the following is true
@@ -2259,7 +2259,7 @@ .SH ERRORS
 .RE
 .TP
 .B EINVAL
-.I operation
+.I op
 is
 .B PR_SET_PTRACER
 and
@@ -2269,7 +2269,7 @@ .SH ERRORS
 or the PID of an existing process.
 .TP
 .B EINVAL
-.I operation
+.I op
 is
 .B PR_SET_PDEATHSIG
 and
@@ -2277,7 +2277,7 @@ .SH ERRORS
 is not a valid signal number.
 .TP
 .B EINVAL
-.I operation
+.I op
 is
 .B PR_SET_DUMPABLE
 and
@@ -2288,7 +2288,7 @@ .SH ERRORS
 .BR SUID_DUMP_USER .
 .TP
 .B EINVAL
-.I operation
+.I op
 is
 .B PR_SET_TIMING
 and
@@ -2297,7 +2297,7 @@ .SH ERRORS
 .BR PR_TIMING_STATISTICAL .
 .TP
 .B EINVAL
-.I operation
+.I op
 is
 .B PR_SET_NO_NEW_PRIVS
 and
@@ -2311,7 +2311,7 @@ .SH ERRORS
 is nonzero.
 .TP
 .B EINVAL
-.I operation
+.I op
 is
 .B PR_GET_NO_NEW_PRIVS
 and
@@ -2323,7 +2323,7 @@ .SH ERRORS
 is nonzero.
 .TP
 .B EINVAL
-.I operation
+.I op
 is
 .B PR_SET_THP_DISABLE
 and
@@ -2334,7 +2334,7 @@ .SH ERRORS
 is nonzero.
 .TP
 .B EINVAL
-.I operation
+.I op
 is
 .B PR_GET_THP_DISABLE
 and
@@ -2346,7 +2346,7 @@ .SH ERRORS
 is nonzero.
 .TP
 .B EINVAL
-.I operation
+.I op
 is
 .B PR_CAP_AMBIENT
 and an unused argument
@@ -2371,7 +2371,7 @@ .SH ERRORS
 does not specify a valid capability.
 .TP
 .B EINVAL
-.I operation
+.I op
 was
 .B PR_GET_SPECULATION_CTRL
 or
@@ -2381,7 +2381,7 @@ .SH ERRORS
 are not 0.
 .TP
 .B EINVAL
-.I operation
+.I op
 is
 .B PR_PAC_RESET_KEYS
 and the arguments are invalid or unsupported.
@@ -2390,7 +2390,7 @@ .SH ERRORS
 above for details.
 .TP
 .B EINVAL
-.I operation
+.I op
 is
 .B PR_SVE_SET_VL
 and the arguments are invalid or unsupported,
@@ -2400,13 +2400,13 @@ .SH ERRORS
 above for details.
 .TP
 .B EINVAL
-.I operation
+.I op
 is
 .B PR_SVE_GET_VL
 and SVE is not available on this platform.
 .TP
 .B EINVAL
-.I operation
+.I op
 is
 .B PR_SET_SYSCALL_USER_DISPATCH
 and one of the following is true:
@@ -2428,7 +2428,7 @@ .SH ERRORS
 .RE
 .TP
 .B EINVAL
-.I operation
+.I op
 is
 .B PR_SET_TAGGED_ADDR_CTRL
 and the arguments are invalid or unsupported.
@@ -2437,7 +2437,7 @@ .SH ERRORS
 above for details.
 .TP
 .B EINVAL
-.I operation
+.I op
 is
 .B PR_GET_TAGGED_ADDR_CTRL
 and the arguments are invalid or unsupported.
@@ -2446,13 +2446,13 @@ .SH ERRORS
 above for details.
 .TP
 .B ENODEV
-.I operation
+.I op
 was
 .B PR_SET_SPECULATION_CTRL
 the kernel or CPU does not support the requested speculation misfeature.
 .TP
 .B ENXIO
-.I operation
+.I op
 was
 .B PR_MPX_ENABLE_MANAGEMENT
 or
@@ -2461,7 +2461,7 @@ .SH ERRORS
 Check that the kernel and processor have MPX support.
 .TP
 .B ENXIO
-.I operation
+.I op
 was
 .B PR_SET_SPECULATION_CTRL
 implies that the control of the selected speculation misfeature is not pos=
sible.
@@ -2470,7 +2470,7 @@ .SH ERRORS
 for the bit fields to determine which option is available.
 .TP
 .B EOPNOTSUPP
-.I operation
+.I op
 is
 .B PR_SET_FP_MODE
 and
@@ -2478,7 +2478,7 @@ .SH ERRORS
 has an invalid or unsupported value.
 .TP
 .B EPERM
-.I operation
+.I op
 is
 .BR PR_SET_SECUREBITS ,
 and the caller does not have the
@@ -2490,7 +2490,7 @@ .SH ERRORS
 .BR capabilities (7)).
 .TP
 .B EPERM
-.I operation
+.I op
 is
 .B PR_SET_SPECULATION_CTRL
 wherein the speculation was disabled with
@@ -2498,7 +2498,7 @@ .SH ERRORS
 and caller tried to enable it again.
 .TP
 .B EPERM
-.I operation
+.I op
 is
 .BR PR_SET_KEEPCAPS ,
 and the caller's
@@ -2508,7 +2508,7 @@ .SH ERRORS
 .BR capabilities (7)).
 .TP
 .B EPERM
-.I operation
+.I op
 is
 .BR PR_CAPBSET_DROP ,
 and the caller does not have the
@@ -2516,7 +2516,7 @@ .SH ERRORS
 capability.
 .TP
 .B EPERM
-.I operation
+.I op
 is
 .BR PR_SET_MM ,
 and the caller does not have the
@@ -2524,7 +2524,7 @@ .SH ERRORS
 capability.
 .TP
 .B EPERM
-.I operation
+.I op
 is
 .B PR_CAP_AMBIENT
 and
@@ -2539,7 +2539,7 @@ .SH ERRORS
 securebit has been set.
 .TP
 .B ERANGE
-.I operation
+.I op
 was
 .B PR_SET_SPECULATION_CTRL
 and
@@ -2559,7 +2559,7 @@ .SH VERSIONS
 .P
 .in +4n
 .EX
-.BI "ptrdiff_t prctl(int " operation ", int " arg2 ", int " arg3 );
+.BI "ptrdiff_t prctl(int " op ", int " arg2 ", int " arg3 );
 .EE
 .in
 .P
diff --git a/man2/ptrace.2 b/man2/ptrace.2
index 73afd3174..c6487656c 100644
--- a/man2/ptrace.2
+++ b/man2/ptrace.2
@@ -93,7 +93,7 @@ .SH SYNOPSIS
 .nf
 .B #include <sys/ptrace.h>
 .P
-.BI "long ptrace(enum __ptrace_request " request ", pid_t " pid ,
+.BI "long ptrace(enum __ptrace_request " op ", pid_t " pid ,
 .BI "            void *" addr ", void *" data );
 .fi
 .SH DESCRIPTION
@@ -155,7 +155,7 @@ .SH DESCRIPTION
 value containing information that indicates
 the cause of the stop in the tracee.
 While the tracee is stopped,
-the tracer can use various ptrace requests to inspect and modify the trace=
e.
+the tracer can use various ptrace operations to inspect and modify the tra=
cee.
 The tracer then causes the tracee to continue,
 optionally ignoring the delivered signal
 (or even delivering a different signal instead).
@@ -175,12 +175,12 @@ .SH DESCRIPTION
 .BR PTRACE_DETACH .
 .P
 The value of
-.I request
-determines the action to be performed:
+.I op
+determines the operation to be performed:
 .TP
 .B PTRACE_TRACEME
 Indicate that this process is to be traced by its parent.
-A process probably shouldn't make this request if its parent
+A process probably shouldn't make this operation if its parent
 isn't expecting to trace it.
 .RI ( pid ,
 .IR addr ,
@@ -190,12 +190,12 @@ .SH DESCRIPTION
 .IP
 The
 .B PTRACE_TRACEME
-request is used only by the tracee;
-the remaining requests are used only by the tracer.
-In the following requests,
+operation is used only by the tracee;
+the remaining operations are used only by the tracer.
+In the following operations,
 .I pid
 specifies the thread ID of the tracee to be acted on.
-For requests other than
+For operations other than
 .BR PTRACE_ATTACH ,
 .BR PTRACE_SEIZE ,
 .BR PTRACE_INTERRUPT ,
@@ -212,7 +212,7 @@ .SH DESCRIPTION
 .BR ptrace ()
 call.
 Linux does not have separate text and data address spaces,
-so these two requests are currently equivalent.
+so these two operations are currently equivalent.
 .RI ( data
 is ignored; but see NOTES.)
 .TP
@@ -246,7 +246,7 @@ .SH DESCRIPTION
 .B PTRACE_PEEKTEXT
 and
 .BR PTRACE_PEEKDATA ,
-these two requests are currently equivalent.
+these two operations are currently equivalent.
 .TP
 .B PTRACE_POKEUSER
 .\" PTRACE_POKEUSR in kernel source, but glibc uses PTRACE_POKEUSER,
@@ -740,7 +740,7 @@ .SH DESCRIPTION
 The
 .I addr
 argument is ignored.
-This request is currently
+This operation is currently
 .\" As of 4.19-rc2
 supported only on arm (and arm64, though only for backwards compatibility),
 .\" commit 27aa55c5e5123fa8b8ad0156559d34d7edff58ca
@@ -770,7 +770,7 @@ .SH DESCRIPTION
 The
 .I addr
 argument is ignored.
-These requests are currently
+These operations are currently
 .\" As at 3.7
 supported only on x86.
 .TP
@@ -1211,7 +1211,7 @@ .SS Death under ptrace
 .I waitpid(WNOHANG)
 may return 0 instead.
 In other words, the tracee may be "not yet fully dead",
-but already refusing ptrace requests.
+but already refusing ptrace operations.
 .P
 The tracer can't assume that the tracee
 .I always
@@ -1355,7 +1355,7 @@ .SS Signal-delivery-stop
 At this point, the signal is not yet delivered to the process,
 and can be suppressed by the tracer.
 If the tracer doesn't suppress the signal,
-it passes the signal to the tracee in the next ptrace restart request.
+it passes the signal to the tracee in the next ptrace restart operation.
 This second step of signal delivery is called
 .I "signal injection"
 in this manual page.
@@ -1390,7 +1390,7 @@ .SS Signal injection and suppression
 .P
 where
 .B PTRACE_restart
-is one of the restarting ptrace requests.
+is one of the restarting ptrace operations.
 If
 .I sig
 is 0, then a signal is not delivered.
@@ -1434,7 +1434,7 @@ .SS Signal injection and suppression
 .BR tgkill (2)
 instead.
 .P
-The fact that signal injection requests may be ignored
+The fact that signal injection operations may be ignored
 when restarting the tracee after
 ptrace stops that are not signal-delivery-stops
 is a cause of confusion among ptrace users.
@@ -1798,7 +1798,7 @@ .SS Syscall-stops
 etc.),
 expiration of a POSIX timer,
 change of state on a POSIX message queue,
-or completion of an asynchronous I/O request.
+or completion of an asynchronous I/O operation.
 .TP
 .IR si_code " =3D=3D SI_KERNEL (0x80)"
 .B SIGTRAP
@@ -2097,7 +2097,7 @@ .SS Attaching and detaching
 .B PTRACE_INTERRUPT
 command.
 .P
-The request
+The operation
 .P
 .in +4n
 .EX
@@ -2385,21 +2385,21 @@ .SS Real parent
 .SH RETURN VALUE
 On success, the
 .B PTRACE_PEEK*
-requests return the requested data (but see NOTES),
+operations return the requested data (but see NOTES),
 the
 .B PTRACE_SECCOMP_GET_FILTER
-request returns the number of instructions in the BPF program,
+operation returns the number of instructions in the BPF program,
 the
 .B PTRACE_GET_SYSCALL_INFO
-request returns the number of bytes available to be written by the kernel,
-and other requests return zero.
+operation returns the number of bytes available to be written by the kerne=
l,
+and other operations return zero.
 .P
-On error, all requests return \-1, and
+On error, all operations return \-1, and
 .I errno
 is set to indicate the error.
 Since the value returned by a successful
 .B PTRACE_PEEK*
-request may be \-1, the caller must clear
+operation may be \-1, the caller must clear
 .I errno
 before the call, and then check it afterward
 to determine whether or not an error occurred.
@@ -2423,11 +2423,11 @@ .SH ERRORS
 An attempt was made to set an invalid option.
 .TP
 .B EIO
-.I request
+.I op
 is invalid, or an attempt was made to read from or
 write to an invalid area in the tracer's or the tracee's memory,
 or there was a word-alignment violation,
-or an invalid signal was specified during a restart request.
+or an invalid signal was specified during a restart operation.
 .TP
 .B EPERM
 The specified process cannot be traced.
@@ -2445,7 +2445,7 @@ .SH ERRORS
 .B ESRCH
 The specified process does not exist, or is not currently being traced
 by the caller, or is not stopped
-(for requests that require a stopped tracee).
+(for operations that require a stopped tracee).
 .SH STANDARDS
 None.
 .SH HISTORY
@@ -2462,7 +2462,7 @@ .SH NOTES
 glibc currently declares
 .BR ptrace ()
 as a variadic function with only the
-.I request
+.I op
 argument fixed.
 It is recommended to always supply four arguments,
 even if the requested operation does not use them,
@@ -2829,7 +2829,7 @@ .SS C library/kernel differences
 .BR PTRACE_PEEKDATA ,
 and
 .B PTRACE_PEEKUSER
-requests have a different API: they store the result
+operations have a different API: they store the result
 at the address specified by the
 .I data
 parameter, and the return value is the error flag.
diff --git a/man2/quotactl.2 b/man2/quotactl.2
index d7ec80e7b..3807507e8 100644
--- a/man2/quotactl.2
+++ b/man2/quotactl.2
@@ -17,7 +17,7 @@ .SH SYNOPSIS
 " constants"
 .RB    "                        (or " <linux/dqblk_xfs.h> "; see NOTES) */"
 .P
-.BI "int quotactl(int " cmd ", const char *_Nullable " special ", int " id=
 ,
+.BI "int quotactl(int " op ", const char *_Nullable " special ", int " id ,
 .BI "             caddr_t " addr );
 .fi
 .SH DESCRIPTION
@@ -35,14 +35,14 @@ .SH DESCRIPTION
 .BR quotactl ()
 call manipulates disk quotas.
 The
-.I cmd
-argument indicates a command to be applied to the user or
+.I op
+argument indicates an operation to be applied to the user or
 group ID specified in
 .IR id .
 To initialize the
-.I cmd
+.I op
 argument, use the
-.I QCMD(subcmd, type)
+.I QCMD(subop, type)
 macro.
 The
 .I type
@@ -55,7 +55,7 @@ .SH DESCRIPTION
 .BR PRJQUOTA ,
 for project quotas.
 The
-.I subcmd
+.I subop
 value is described below.
 .P
 The
@@ -65,14 +65,14 @@ .SH DESCRIPTION
 .P
 The
 .I addr
-argument is the address of an optional, command-specific, data structure
+argument is the address of an optional, operation-specific, data structure
 that is copied in or out of the system.
 The interpretation of
 .I addr
 is given with each operation below.
 .P
 The
-.I subcmd
+.I subop
 value is one of the following operations:
 .TP
 .B Q_QUOTAON
@@ -649,7 +649,7 @@ .SH DESCRIPTION
 which identify what types of quota
 should be removed.
 (Note that the quota type passed in the
-.I cmd
+.I op
 argument is ignored, but should remain valid in order to pass preliminary
 quotactl syscall handler checks.)
 .IP
@@ -681,7 +681,7 @@ .SH RETURN VALUE
 .SH ERRORS
 .TP
 .B EACCES
-.I cmd
+.I op
 is
 .BR Q_QUOTAON ,
 and the quota file pointed to by
@@ -691,7 +691,7 @@ .SH ERRORS
 .IR special .
 .TP
 .B EBUSY
-.I cmd
+.I op
 is
 .BR Q_QUOTAON ,
 but another
@@ -705,20 +705,20 @@ .SH ERRORS
 is invalid.
 .TP
 .B EINVAL
-.I cmd
+.I op
 or
 .I type
 is invalid.
 .TP
 .B EINVAL
-.I cmd
+.I op
 is
 .BR Q_QUOTAON ,
 but the specified quota file is corrupted.
 .TP
 .BR EINVAL " (since Linux 5.5)"
 .\" 3dd4d40b420846dd35869ccc8f8627feef2cff32
-.I cmd
+.I op
 is
 .BR Q_XQUOTARM ,
 but
@@ -747,7 +747,7 @@ .SH ERRORS
 for the specified operation.
 .TP
 .B ERANGE
-.I cmd
+.I op
 is
 .BR Q_SETQUOTA ,
 but the specified limits are out of the range allowed by the quota format.
@@ -757,13 +757,13 @@ .SH ERRORS
 Quotas have not been turned on for this filesystem.
 .TP
 .B ESRCH
-.I cmd
+.I op
 is
 .BR Q_QUOTAON ,
 but the specified quota format was not found.
 .TP
 .B ESRCH
-.I cmd
+.I op
 is
 .B Q_GETNEXTQUOTA
 or
diff --git a/man2/reboot.2 b/man2/reboot.2
index e00ef20eb..6d106e3dc 100644
--- a/man2/reboot.2
+++ b/man2/reboot.2
@@ -21,7 +21,7 @@ .SH SYNOPSIS
 .BR "#include <sys/syscall.h>   " "/* Definition of " SYS_* " constants */"
 .B #include <unistd.h>
 .P
-.BI "int syscall(SYS_reboot, int " magic ", int " magic2 ", int " cmd ", v=
oid *" arg );
+.BI "int syscall(SYS_reboot, int " magic ", int " magic2 ", int " op ", vo=
id *" arg );
 .P
 /* Under glibc and most alternative libc's (including uclibc, dietlibc,
    musl and a few others), some of the constants involved have gotten
@@ -31,7 +31,7 @@ .SH SYNOPSIS
 .BR "#include <sys/reboot.h>    " "/* Definition of " RB_* " constants */"
 .B #include <unistd.h>
 .P
-.BI "int reboot(int " cmd );
+.BI "int reboot(int " op );
 .fi
 .SH DESCRIPTION
 The
@@ -66,7 +66,7 @@ .SH DESCRIPTION
 (The hexadecimal values of these constants are meaningful.)
 .P
 The
-.I cmd
+.I op
 argument can have the following values:
 .TP
 .B LINUX_REBOOT_CMD_CAD_OFF
@@ -157,7 +157,7 @@ .SS Behavior inside PID namespaces
 is called
 from a PID namespace other than the initial PID namespace
 with one of the
-.I cmd
+.I op
 values listed below,
 it performs a "reboot" of that namespace:
 the "init" process of the PID namespace is immediately terminated,
@@ -165,7 +165,7 @@ .SS Behavior inside PID namespaces
 .BR pid_namespaces (7).
 .P
 The values that can be supplied in
-.I cmd
+.I op
 when calling
 .BR reboot ()
 in this case are as follows:
@@ -191,7 +191,7 @@ .SS Behavior inside PID namespaces
 signal.
 .P
 For the other
-.I cmd
+.I op
 values,
 .BR reboot ()
 returns \-1 and
@@ -200,13 +200,13 @@ .SS Behavior inside PID namespaces
 .BR EINVAL .
 .SH RETURN VALUE
 For the values of
-.I cmd
+.I op
 that stop or restart the system,
 a successful call to
 .BR reboot ()
 does not return.
 For the other
-.I cmd
+.I op
 values, zero is returned on success.
 In all cases, \-1 is returned on failure, and
 .I errno
@@ -218,7 +218,8 @@ .SH ERRORS
 .BR LINUX_REBOOT_CMD_RESTART2 .
 .TP
 .B EINVAL
-Bad magic numbers or \fIcmd\fP.
+Bad magic numbers or
+.IR op .
 .TP
 .B EPERM
 The calling process has insufficient privilege to call
diff --git a/man2/semctl.2 b/man2/semctl.2
index 2dcb63559..243919c73 100644
--- a/man2/semctl.2
+++ b/man2/semctl.2
@@ -30,12 +30,12 @@ .SH SYNOPSIS
 .nf
 .B #include <sys/sem.h>
 .P
-.BI "int semctl(int " semid ", int " semnum ", int " cmd ", ...);"
+.BI "int semctl(int " semid ", int " semnum ", int " op ", ...);"
 .fi
 .SH DESCRIPTION
 .BR semctl ()
 performs the control operation specified by
-.I cmd
+.I op
 on the System\ V semaphore set identified by
 .IR semid ,
 or on the
@@ -44,7 +44,7 @@ .SH DESCRIPTION
 (The semaphores in a set are numbered starting at 0.)
 .P
 This function has three or four arguments, depending on
-.IR cmd .
+.IR op .
 When there are four, the fourth has the type
 .IR "union semun" .
 The \fIcalling program\fP must define this union as follows:
@@ -149,7 +149,7 @@ .SH DESCRIPTION
 Bits 0100, 0010, and 0001 (the execute bits) are unused by the system.
 .P
 Valid values for
-.I cmd
+.I op
 are:
 .TP
 .B IPC_STAT
@@ -380,7 +380,7 @@ .SH RETURN VALUE
 On success,
 .BR semctl ()
 returns a nonnegative value depending on
-.I cmd
+.I op
 as follows:
 .TP
 .B GETNCNT
@@ -422,7 +422,7 @@ .SH RETURN VALUE
 .BR SEM_STAT .
 .P
 All other
-.I cmd
+.I op
 values return 0 on success.
 .P
 On failure,
@@ -434,7 +434,7 @@ .SH ERRORS
 .TP
 .B EACCES
 The argument
-.I cmd
+.I op
 has one of the values
 .BR GETALL ,
 .BR GETPID ,
@@ -464,7 +464,7 @@ .SH ERRORS
 .TP
 .B EINVAL
 Invalid value for
-.I cmd
+.I op
 or
 .IR semid .
 Or: for a
@@ -475,7 +475,7 @@ .SH ERRORS
 .TP
 .B EPERM
 The argument
-.I cmd
+.I op
 has the value
 .B IPC_SET
 or
@@ -493,7 +493,7 @@ .SH ERRORS
 .TP
 .B ERANGE
 The argument
-.I cmd
+.I op
 has the value
 .B SETALL
 or
@@ -575,7 +575,7 @@ .SH HISTORY
 (The kernel distinguishes old and new calls by an
 .B IPC_64
 flag in
-.IR cmd .)
+.IR op .)
 .P
 In some earlier versions of glibc, the
 .I semun
diff --git a/man2/shmctl.2 b/man2/shmctl.2
index d13240647..986268957 100644
--- a/man2/shmctl.2
+++ b/man2/shmctl.2
@@ -34,12 +34,12 @@ .SH SYNOPSIS
 .nf
 .B #include <sys/shm.h>
 .P
-.BI "int shmctl(int " shmid ", int " cmd ", struct shmid_ds *" buf );
+.BI "int shmctl(int " shmid ", int " op ", struct shmid_ds *" buf );
 .fi
 .SH DESCRIPTION
 .BR shmctl ()
 performs the control operation specified by
-.I cmd
+.I op
 on the System\ V shared memory segment whose identifier is given in
 .IR shmid .
 .P
@@ -153,7 +153,7 @@ .SH DESCRIPTION
 flag.)
 .P
 Valid values for
-.I cmd
+.I op
 are:
 .TP
 .B IPC_STAT
@@ -309,7 +309,9 @@ .SH DESCRIPTION
 to obtain the same information).
 .P
 The caller can prevent or allow swapping of a shared
-memory segment with the following \fIcmd\fP values:
+memory segment with the following
+.I op
+values:
 .TP
 .BR SHM_LOCK " (Linux-specific)"
 Prevent swapping of the shared memory segment.
@@ -379,7 +381,7 @@ .SH ERRORS
 .TP
 .B EFAULT
 The argument
-.I cmd
+.I op
 has value
 .B IPC_SET
 or
@@ -392,8 +394,10 @@ .SH ERRORS
 \fIshmid\fP points to a removed identifier.
 .TP
 .B EINVAL
-\fIshmid\fP is not a valid identifier, or \fIcmd\fP
-is not a valid command.
+.I shmid
+is not a valid identifier, or
+.I op
+is not a valid operation.
 Or: for a
 .B SHM_STAT
 or
@@ -468,7 +472,7 @@ .SH HISTORY
 (The kernel distinguishes old and new calls by an
 .B IPC_64
 flag in
-.IR cmd .)
+.IR op .)
 .SH NOTES
 The
 .BR IPC_INFO ,
diff --git a/man3/lockf.3 b/man3/lockf.3
index accf8e771..7267587c4 100644
--- a/man3/lockf.3
+++ b/man3/lockf.3
@@ -17,7 +17,7 @@ .SH SYNOPSIS
 .nf
 .B #include <unistd.h>
 .P
-.BI "int lockf(int " fd ", int " cmd ", off_t " len );
+.BI "int lockf(int " fd ", int " op ", off_t " len );
 .fi
 .P
 .RS -4
@@ -37,7 +37,7 @@ .SH DESCRIPTION
 The file is specified by
 .IR fd ,
 a file descriptor open for writing, the action by
-.IR cmd ,
+.IR op ,
 and the section consists of byte positions
 .IR pos .. pos + len \-1
 if
@@ -118,7 +118,7 @@ .SH ERRORS
 .B EBADF
 .I fd
 is not an open file descriptor; or
-.I cmd
+.I op
 is
 .B F_LOCK
 or
@@ -128,7 +128,8 @@ .SH ERRORS
 is not a writable file descriptor.
 .TP
 .B EDEADLK
-The command was
+.I op
+was
 .B F_LOCK
 and this lock operation would cause a deadlock.
 .TP
@@ -139,7 +140,7 @@ .SH ERRORS
 .TP
 .B EINVAL
 An invalid operation was specified in
-.IR cmd .
+.IR op .
 .TP
 .B ENOLCK
 Too many segment locks open, lock table is full.
--=20
2.43.0


--yu57s6mkxtlasuqe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmXkac0ACgkQnowa+77/
2zIB0w/+I+l6ZU64u4w8m0ckXfotwDC7HuNndP7fA9Lcdm39M9LQ7pfbcKmAPmne
m6ZyvSv+36QP1eTuSl3HsZaJ8kasJDgGYNndk2CktoBCbI+5xO6+vHMUTld9ayA7
/2GgnCCXXipQtGYpjUsLcPUfrLNqyqBCqqR/xW4wTT4ZsEIILsVq+IRL0nFBkeSN
GvskkP17cliPjISw68cTAP4CZj+e4KLUui6q/8SswMJQh3xD96g7QS1T7Nf+qHej
c1BCmf87dBwLVB8USSyZQPVHdfUIXeBZTMy21nAO8hBFoOSvHRAfiKUXzX+YE3LQ
InMUwGukm1RAtPp7Z+5EnQxCE9j//8Z573Xn+dSWqfA2WmR0qV2yDTdX7pdZZsqv
QRqLoZdXccqu9ECbqAWdIA53R2AUsU5gWkXug9VEz/yz9lMYCqhpMpiz12vNMQyF
BovCwW/+m7bE8AYZe2HqnU/XNOSKa7OD81+c1mnQdg+Nq/KYplTqUSpxGPuVpv+0
PIvmNQ0uNChpOacU1hPsCcIi6qdj7E1TWDUe8Gv5qzh1y9cusGwEp9slBt8fqM/t
eSmlzIOe1/yeIjvS71nsehs42LocnX7A6cZwTVUVY58+jVYNhiqRipbn+xTqVLAA
pfhD7CkAY4+mEAHmnVar3YVIsOE2HHd2AebU10X1hpDJycS7iMg=
=rs5B
-----END PGP SIGNATURE-----

--yu57s6mkxtlasuqe--


Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 32ECBD09FC
	for <lists+linux-api@lfdr.de>; Wed,  9 Oct 2019 10:36:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725776AbfJIIg5 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 9 Oct 2019 04:36:57 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37694 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725440AbfJIIg5 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 9 Oct 2019 04:36:57 -0400
Received: by mail-wr1-f66.google.com with SMTP id p14so1717445wro.4;
        Wed, 09 Oct 2019 01:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=AThgnkIx+ZxhQhKBLB9iqetFMto8RPMCYWTufrT8ESI=;
        b=p0jXY9VhN1fk3Fw/EGAVrC5hx7sGDkeVeEsbHols1DwG57rALKxKYt7Z4iaP9axPwk
         qiq7PF01ZzXrFBX4SHzb2aNfGn77tdRyEe64N1OiZRYB78rUcB6Xs9wYSIQG6uxCAN3g
         mqt7ueoUXrXv4XK7xu8fBkCT1YKMH6k196ucbT3fzYaaQKOyThpGZyA0ZO5/TXuDQK6e
         R2WrPlwU1uU3eGrMm2tt00JncmscVyz2TXYCtfkWmhJY4tnItkmjx/+1GvN5Z8NJlc8M
         Mt2BhHsOujQD1v78LveQ4QEGn/4hSRgjlcqkolIn1rTkm0+3lrr27zaD4324ybTkcTyx
         z2Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AThgnkIx+ZxhQhKBLB9iqetFMto8RPMCYWTufrT8ESI=;
        b=e5P5n107VBIddtkGEPpicXVqPWDNtOBvesNbE0fhWXxKpE5O5jqRe89wc4E2Xrv9fj
         CRMwyUGLLGbmyn+3nAMKs1Ir2KIsaIP4d89ykFElmJVQAvVyp/cAoZ8eESl14OyXU2Vz
         MgmpLu7fUFhglJyVCQWME5xet3vUJEiq8hXFAXg9WOdqcROZOBcvE+f5gv1oG1JFNqxq
         YfgIFAWnegV39AnZwjiEqbgP2yWKTc9HpncJB+y+6nXrZs0IvAT4pPSFy8ceZ/T3NcKW
         AAOEwXplOSvUfm4quScoQxyQboNWrpx6DpJV8hDbpNuJzfFgIDvwGOdRhyV3UAwxjVfv
         Z8dQ==
X-Gm-Message-State: APjAAAXmQVUN4hy4HcODiDC/kZ21H7Rr5Amn92g6y/jv4Tpkrb/nHBfJ
        qP5oRmpFvISBali0ZghTEdreVryB
X-Google-Smtp-Source: APXvYqyXPD7lnk6woLAsFqUdPkqBCWle82graZyUR0RXIlBstwWoCbF4oCdvLY7L/uF8Eg2/0TA0jw==
X-Received: by 2002:a5d:6192:: with SMTP id j18mr1845218wru.63.1570610211726;
        Wed, 09 Oct 2019 01:36:51 -0700 (PDT)
Received: from [10.0.20.253] ([95.157.63.22])
        by smtp.gmail.com with ESMTPSA id n1sm1895670wrg.67.2019.10.09.01.36.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Oct 2019 01:36:50 -0700 (PDT)
Cc:     mtk.manpages@gmail.com, Christian Brauner <christian@brauner.io>,
        Aleksa Sarai <asarai@suse.de>, linux-man@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 3/3] openat2.2: document new openat2(2) syscall
To:     Aleksa Sarai <cyphar@cyphar.com>, Al Viro <viro@zeniv.linux.org.uk>
References: <20191003145542.17490-1-cyphar@cyphar.com>
 <20191003145542.17490-4-cyphar@cyphar.com>
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Message-ID: <b52e4a93-a3de-dcbf-3684-bb2c355f3f24@gmail.com>
Date:   Wed, 9 Oct 2019 10:36:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20191003145542.17490-4-cyphar@cyphar.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hello Aleksa,

Thanks for this. It's a great piece of documentation work!

I would prefer the path_resolution(7) piece as a separate patch.


On 10/3/19 4:55 PM, Aleksa Sarai wrote:
> Rather than trying to merge the new syscall documentation into open.2
> (which would probably result in the man-page being incomprehensible),
> instead the new syscall gets its own dedicated page with links between
> open(2) and openat2(2) to avoid duplicating information such as the list
> of O_* flags or common errors.

Yes, looking at the size of the proposed openat2(2) page,
this seems best.
> 
> Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
> ---
>  man2/open.2            |   5 +
>  man2/openat2.2         | 381 +++++++++++++++++++++++++++++++++++++++++
>  man7/path_resolution.7 |  57 ++++--
>  3 files changed, 426 insertions(+), 17 deletions(-)
>  create mode 100644 man2/openat2.2
> 
> diff --git a/man2/open.2 b/man2/open.2
> index 7217fe056e5e..a0b43394bbee 100644
> --- a/man2/open.2
> +++ b/man2/open.2
> @@ -65,6 +65,10 @@ open, openat, creat \- open and possibly create a file
>  .BI "int openat(int " dirfd ", const char *" pathname ", int " flags );
>  .BI "int openat(int " dirfd ", const char *" pathname ", int " flags \
>  ", mode_t " mode );
> +.PP
> +/* Docuented separately, in \fBopenat2\fP(2). */

Documented

> +.BI "int openat2(int " dirfd ", const char *" pathname ", \
> +const struct open_how *" how ", size_t " size ");
>  .fi
>  .PP
>  .in -4n
> @@ -1808,6 +1812,7 @@ will create a regular file (i.e.,
>  .B O_DIRECTORY
>  is ignored).
>  .SH SEE ALSO
> +.BR openat2 (2),

Entries here should into alphabetical order (within
sections).

>  .BR chmod (2),
>  .BR chown (2),
>  .BR close (2),
> diff --git a/man2/openat2.2 b/man2/openat2.2
> new file mode 100644
> index 000000000000..c43c76046243
> --- /dev/null
> +++ b/man2/openat2.2
> @@ -0,0 +1,381 @@
> +.\" Copyright (C) 2019 Aleksa Sarai <cyphar@cyphar.com>
> +.\"
> +.\" %%%LICENSE_START(VERBATIM)
> +.\" Permission is granted to make and distribute verbatim copies of this
> +.\" manual provided the copyright notice and this permission notice are
> +.\" preserved on all copies.
> +.\"
> +.\" Permission is granted to copy and distribute modified versions of this
> +.\" manual under the conditions for verbatim copying, provided that the
> +.\" entire resulting derived work is distributed under the terms of a
> +.\" permission notice identical to this one.
> +.\"
> +.\" Since the Linux kernel and libraries are constantly changing, this
> +.\" manual page may be incorrect or out-of-date.  The author(s) assume no
> +.\" responsibility for errors or omissions, or for damages resulting from
> +.\" the use of the information contained herein.  The author(s) may not
> +.\" have taken the same level of care in the production of this manual,
> +.\" which is licensed free of charge, as they might when working
> +.\" professionally.
> +.\"
> +.\" Formatted or processed versions of this manual, if unaccompanied by
> +.\" the source, must acknowledge the copyright and authors of this work.
> +.\" %%%LICENSE_END
> +.TH OPENAT2 2 2019-10-03 "Linux" "Linux Programmer's Manual"
> +.SH NAME
> +openat2 \- open and possibly create a file (extended)
> +.SH SYNOPSIS
> +.nf
> +.B #include <sys/types.h>
> +.B #include <sys/stat.h>
> +.B #include <fcntl.h>
> +.PP
> +.BI "int openat2(int " dirfd ", const char *" pathname ", \
> +const struct open_how *" how ", size_t " size ");
> +.fi
> +.PP
> +.IR Note :
> +There is no glibc wrapper for this system call; see NOTES.
> +.SH DESCRIPTION
> +The
> +.BR openat2 ()
> +system call is an extension of
> +.BR openat (2)
> +and provides a superset of its functionality. Rather than taking a single

Please start new sentences on new source lines. I recently added this
text in man-pages(7):

   Use semantic newlines
       In the source of a manual page, new sentences should be started on
       new  lines,  and  long sentences should split into lines at clause
       breaks (commas, semicolons, colons, and so on).  This  convention,
       sometimes known as "semantic newlines", makes it easier to see the
       effect of patches, which often operate at the level of  individual
       sentences or sentence clauses.

> +.I flag
> +argument, an extensible structure (\fIhow\fP) is passed instead to allow for
> +seamless future extensions.

s/seamless//

> +.PP
> +.I size
> +must be set to
> +.IR "sizeof(struct open_how)" ,
> +to facilitate future extensions (see the "Extensibility" section of the
> +\fBNOTES\fP for more detail on how extensions are handled.)
> +
> +.SS The open_how structure
> +The following structure indicates how
> +.I pathname
> +should be opened, and acts as a superset of the
> +.IR flag " and " mode
> +arguments to
> +.BR openat (2).
> +.PP
> +.in +4n
> +.EX
> +struct open_how {
> +    uint32_t flags;              /* open(2)-style O_* flags. */
> +    union {
> +        uint16_t mode;           /* File mode bits for new file creation. */
> +        uint16_t upgrade_mask;   /* Restrict how O_PATHs may be re-opened. */
> +    };
> +    uint32_t resolve;            /* RESOLVE_* path-resolution flags. */
> +};
> +.EE
> +.in
> +.PP
> +Any future extensions to
> +.BR openat2 ()
> +will be implemented as new fields appended to the above structure, with the
> +zero value of the new fields acting as though the extension were not present.
> +.PP
> +The meaning of each field is as follows:
> +.RS
> +
> +.I flags
> +.RSall
> +The file creation and status flags to use for this operation. All of the
> +.B O_*
> +flags defined for
> +.BR openat (2)
> +are valid
> +.BR openat2 ()
> +flag values.
> +.RE
> +
> +.I upgrade_mask
> +.RS
> +Restrict with which
> +.I access modes
> +the returned
> +.B O_PATH
> +descriptor may be re-opened (either through
> +.B O_EMPTYPATH
> +or
> +.IR /proc/self/fd/ .)
> +This field may only be set to a non-zero value if
> +.I flags
> +contains
> +.BR O_PATH .
> +By default, an
> +.B O_PATH
> +file descriptor of an ordinary file may be re-opened with with any access mode (but an
> +.B O_PATH
> +file descriptor of a magic-link may only be re-opened with access modes that
> +the original magic-link possessed). The full list of

magic link (throughout the page)

> +.I upgrade_mask
> +flags is given below.
> +.TP
> +.B UPGRADE_NOREAD
> +Do not permit the
> +.B O_PATH
> +file descriptor to be re-opened for reading (i.e.
> +.BR O_RDONLY " or " O_RDWR .)
> +.TP
> +.B UPGRADE_NOWRITE
> +Do not permit the
> +.B O_PATH
> +file descriptor to be re-opened for writing (i.e.
> +.BR O_WRONLY ", " O_RDWR ", or " O_APPEND .)
> +.RE
> +.I resolve
> +.RS
> +Change how the components of
> +.I pathname
> +will be resolved (see
> +.BR path_resolution (7)
> +for background information.) The primary use-case for these flags is to allow

use case

> +trusted programs to restrict how un-trusted paths (or paths inside un-trusted

untrusted

> +directories) are resolved. The full list of
> +.I resolve
> +flags is given below.
> +.TP
> +.B RESOLVE_NO_XDEV
> +Disallow all mount-point crossings during path resolution (including

I think better would be: "Disallow traversal of mount points". Do you 
agree?

> +all bind-mounts).

bind mounts

> +
> +Users of this flag are encouraged to make its use configurable (unless it is
> +used for a specific security purpose), as bind-mounts are very widely used by
> +end-users and thus enabling this flag globally may result in spurious errors on
> +some systems.
> +.TP
> +.B RESOLVE_NO_SYMLINKS
> +Disallow all symlink resolution during path resolution. If the trailing

Disallow resolution of symbolic links during path resolution

> +component is a symlink, and

symbolic link (throughout the page)

> +.I flags
> +contains both
> +.BR O_PATH " and " O_NOFOLLOW ","
> +then an
> +.B O_PATH
> +file descriptor referencing the symlink will be returned. This option implies
> +.BR RESOLVE_NO_MAGICLINKS .
> +
> +Users of this flag are encouraged to make its use configurable (unless it is
> +used for a specific security purpose), as symlinks are very widely used by
> +end-users and thus enabling this flag globally may result in spurious errors on
> +some systems.

It's not really clear what you mean by "enabling this flag globally".
Could you reword, or explain in a bit more detail?

> +.TP
> +.B RESOLVE_NO_MAGICLINKS
> +Disallow all magic-link resolution during path resolution. If the trailing
> +component is a magic-link, and
> +.I flags
> +contains both
> +.BR O_PATH " and " O_NOFOLLOW ","
> +then an
> +.B O_PATH
> +file descriptor referencing the magic-link will be returned.
> +
> +Magic-links are symlink-like objects that are most notably found in
> +.BR proc (5)
> +(examples include
> +.IR /proc/[pid]/exe " and " /proc/[pid]/fd/* .)
> +Due to the potential danger of unknowingly opening these magic-links, it may be
> +preferable for users to disable their resolution entirely (see
> +.BR symlink (7)
> +for more details.)
> +.TP
> +.B RESOLVE_BENEATH
> +Do not permit the path resolution to succeed if any component of the resolution
> +is not a descendant of the directory indicated by
> +.IR dirfd .
> +This results in absolute symlinks (and absolute values of
> +.IR pathname )
> +to be rejected. Magic-link resolution is also not permitted.

So, this flag implies RESOLVE_NO_MAGICLINKS? If yes,
it would be good to state that more explicitly,

> +
> +.TP
> +.B RESOLVE_IN_ROOT
> +Temporarily treat
> +.I dirfd
> +as the root of the filesystem (as though the user called

Perhaps better:

Treat
.I dirfd
as the root directory while resolving
.I pathname
(as though...)

> +.BR chroot (2)
> +with
> +.IR dirfd
> +as the argument.) Absolute symlinks and ".." path components will be scoped to
> +.IR dirfd . Magic-link resolution is also not permitted.

Insert a newline before "Magic" to fix a formatting problem.

So, this flag implies RESOLVE_NO_MAGICLINKS? If yes,
it would be good to state that more explicitly,

> +
> +However, unlike
> +.BR chroot (2)
> +(which changes the filesystem root persistently for an entire thread-group),

s/persistently for an entire thread-group/
 /permanently for a process/

> +.B RESOLVE_IN_ROOT
> +allows a program to efficiently restrict path resolution for only certain
> +operations. It also has several hardening features (such as not permitting
> +magic-link resolution) which
> +.BR chroot (2)
> +does not.
> +.RE
> +
> +.RE
> +
> +.PP
> +Unlike
> +.BR openat (2),
> +any unknown flags set in fields of
> +.I how
> +will result in an error, rather than being ignored. 

Thank you, thank you, thank you. It was sad
that openat() never fixed that antifeature.

> In addition, an error will
> +be returned if the value of the
> +.IR mode " and " upgrade_mask
> +union is non-zero unless:
> +.RS
> +.IP * 3
> +.I flags
> +indicates that a new file will be created (it contains
> +.BR O_CREAT " or " O_TMPFILE ),
> +in which case
> +.I mode
> +may be any valid file mode.
> +.IP *
> +.I flags
> +contains
> +.BR O_PATH ,
> +in which case
> +.I upgrade_mask
> +must only contain valid
> +.B UPGRADE_*
> +flags.
> +.RE
> +
> +.SH RETURN VALUE
> +On success, a new file descriptor is returned. On error, -1 is returned, and
> +.I errno
> +is set appropriately.
> +
> +.SH ERRORS
> +The set of errors returned by
> +.BR openat2 ()
> +includes all of the errors returned by
> +.BR openat (2),
> +as well as the following additional errors:
> +.TP
> +.B EINVAL
> +An unknown flag or invalid value was specified in
> +.IR how .
> +.TP
> +.B EINVAL
> +.I size
> +was smaller than any known version of
> +.IR "struct open_how" .
> +.TP
> +.B E2BIG
> +An extension was specified in
> +.IR how ,
> +which the current kernel does not support (see the "Extensibility" section of
> +the \fBNOTES\fP for more detail on how extensions are handled.)
> +.TP
> +.B EAGAIN
> +.I resolve
> +contains either
> +.BR RESOLVE_IN_ROOT " or " RESOLVE_BENEATH ,
> +and the kernel could not ensure that a ".." component didn't escape (due to a
> +race condition or potential attack). Callers may choose to retry the
> +.BR openat2 ()
> +call.
> +.TP
> +.B EXDEV
> +.I resolve
> +contains either
> +.BR RESOLVE_IN_ROOT " or " RESOLVE_BENEATH ,
> +and a path component attempted to escape the root of the resolution.
> +
> +.TP
> +.B EXDEV
> +.I resolve
> +contains
> +.BR RESOLVE_NO_XDEV ,
> +and a path component attempted to cross a mount-point.

mount point

> +
> +.TP
> +.B ELOOP
> +.I resolve
> +contains
> +.BR RESOLVE_NO_SYMLINKS ,
> +and one of the path components was a symlink.
> +.TP
> +.B ELOOP
> +.I resolve
> +contains
> +.BR RESOLVE_NO_MAGICLINKS ,
> +and one of the path components was a magic-link.
> +
> +.SH VERSIONS
> +.BR openat2 ()
> +was added to Linux in kernel 5.FOO.
> +
> +.SH CONFORMING TO
> +This system call is Linux-specific.
> +
> +The semantics of
> +.B RESOLVE_BENEATH
> +were modelled after FreeBSD's
> +.BR O_BENEATH .
> +
> +.SH NOTES
> +Glibc does not provide a wrapper for this system call; call it using
> +.BR syscall (2).
> +
> +.SS Extensibility
> +In order to allow for
> +.I struct open_how
> +to be extended in future kernel revisions,
> +.BR openat2 ()
> +requires userspace to specify what sized

s/what sized/the size of/

> +.I struct open_how
> +structure they are passing. By providing this information, it is possible for
> +.BR openat2 ()
> +to provide both forwards- and backwards-compatibility \(em with
> +.I size
> +acting as an implicit version number (because new extension fields will always
> +be appended, the size will always increase.) This extensibility design is very
> +similar to other system calls such as
> +.BR perf_setattr "(2), " perf_event_open "(2), and " clone (3).

The following explantion of uszie and ksize is great. Thanks for that.

> +If we let
> +.I usize
> +be the size of the structure according to userspace and
> +.I ksize
> +be the size of the structure which the kernel supports, then there are only
> +three cases to consider:
> +
> +.RS
> +.IP * 3
> +If
> +.IR ksize " equals " usize ,
> +then there is no version mismatch and
> +.I how
> +can be used verbatim.
> +.IP *
> +If
> +.IR ksize " is larger than " usize ,
> +then there are some extensions the kernel supports which the userspace program
> +is unaware of. Because all extensions must have their zero values be a no-op,
> +the kernel treats all of the extension fields not set by userspace to have zero
> +values. This provides backwards-compatibility.
> +.IP *
> +If
> +.IR ksize " is smaller than " usize ,
> +then there are some extensions which the userspace program is aware of but the
> +kernel does not support. Because all extensions must have their zero values be
> +a no-op, the kernel can safely ignore the unsupported extension fields if they
> +are all-zero. If any unsupported extension fields are non-zero, then an error
> +is returned. This provides forwards-compatibility.
> +.RE
> +
> +Therefore, most userspace programs will not need to have any special handling
> +of extensions. However, if a userspace program wishes to determine what
> +extensions the running kernel supports, they may conduct a binary search on
> +.IR size
> +(to find the largest value which doesn't produce an error.)
> +
> +.SH SEE ALSO
> +.BR openat (2),
> +.BR path_resolution (7),
> +.BR symlink (7)
> diff --git a/man7/path_resolution.7 b/man7/path_resolution.7
> index 85dd354e9a93..3da3e5b614c8 100644
> --- a/man7/path_resolution.7
> +++ b/man7/path_resolution.7
> @@ -29,17 +29,17 @@ path_resolution \- how a pathname is resolved to a file
>  Some UNIX/Linux system calls have as parameter one or more filenames.
>  A filename (or pathname) is resolved as follows.
>  .SS Step 1: start of the resolution process
> -If the pathname starts with the \(aq/\(aq character,
> -the starting lookup directory
> -is the root directory of the calling process.
> -(A process inherits its
> -root directory from its parent.
> -Usually this will be the root directory
> -of the file hierarchy.
> -A process may get a different root directory
> -by use of the
> +If the pathname starts with the \(aq/\(aq character, the starting lookup
> +directory is the root directory of the calling process. (A process inherits its
> +root directory from its parent. Usually this will be the root directory of the
> +file hierarchy. A process may get a different root directory by use of the
>  .BR chroot (2)
> -system call.
> +system call, or may temporarily use a different root directory by using
> +.BR openat2 (2)
> +with the
> +.B RESOLVE_IN_ROOT
> +flag set.
> +.PP
>  A process may get an entirely private mount namespace in case
>  it\(emor one of its ancestors\(emwas started by an invocation of the
>  .BR clone (2)
> @@ -48,16 +48,24 @@ system call that had the
>  flag set.)
>  This handles the \(aq/\(aq part of the pathname.
>  .PP
> -If the pathname does not start with the \(aq/\(aq character, the
> -starting lookup directory of the resolution process is the current working
> -directory of the process.
> -(This is also inherited from the parent.
> -It can be changed by use of the
> +If the pathname does not start with the \(aq/\(aq character, the starting
> +lookup directory of the resolution process is the current working directory of
> +the process \(em or in the case of
> +.BR openat (2)-style
> +syscalls, the

system calls

> +.I dfd
> +argument (or the current working directory if
> +.B AT_FDCWD
> +is passed as the
> +.I dfd
> +argumnet). The current working directory is inherited from the parent, and can

argument

> +be changed by use of the
>  .BR chdir (2)
> -system call.)
> +syscall.

"system call" please.

>  .PP
>  Pathnames starting with a \(aq/\(aq character are called absolute pathnames.
>  Pathnames not starting with a \(aq/\(aq are called relative pathnames.
> +

No blank line here.

>  .SS Step 2: walk along the path
>  Set the current lookup directory to the starting lookup directory.
>  Now, for each nonfinal component of the pathname, where a component
> @@ -124,6 +132,13 @@ the kernel's pathname-resolution code
>  was reworked to eliminate the use of recursion,
>  so that the only limit that remains is the maximum of 40
>  resolutions for the entire pathname.
> +.PP
> +The resolution of syscalls during this stage can be blocked by using

"resolution of syscall" seems wrong? "syscall" should be something 
else?

> +.BR openat2 (2),
> +with the
> +.B RESOLVE_NO_SYMLINKS
> +flag set.
> +
>  .SS Step 3: find the final entry
>  The lookup of the final component of the pathname goes just like
>  that of all other components, as described in the previous step,
> @@ -160,7 +175,8 @@ The path resolution process will assume that these entries have
>  their conventional meanings, regardless of whether they are
>  actually present in the physical filesystem.
>  .PP
> -One cannot walk down past the root: "/.." is the same as "/".
> +One cannot walk up past the root: "/.." is the same as "/".
> +

No blank line please.

>  .SS Mount points
>  After a "mount dev path" command, the pathname "path" refers to
>  the root of the filesystem hierarchy on the device "dev", and no
> @@ -169,6 +185,13 @@ longer to whatever it referred to earlier.
>  One can walk out of a mounted filesystem: "path/.." refers to
>  the parent directory of "path",
>  outside of the filesystem hierarchy on "dev".
> +.PP
> +Mount-point crossings can be blocked by using

Traversal of mount points can be disallowed by...

> +.BR openat2 (2),
> +with the
> +.B RESOLVE_NO_XDEV
> +flag set (though note that this also restricts bind-mount crossings).
> +

No blank line please.

>  .SS Trailing slashes
>  If a pathname ends in a \(aq/\(aq, that forces resolution of the preceding
>  component as in Step 2: it has to exist and resolve to a directory.
> 

Thanks,

Michael

-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/

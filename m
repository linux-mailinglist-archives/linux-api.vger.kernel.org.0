Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 68B1D19E4A4
	for <lists+linux-api@lfdr.de>; Sat,  4 Apr 2020 13:09:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726005AbgDDLI7 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sat, 4 Apr 2020 07:08:59 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43147 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbgDDLI7 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sat, 4 Apr 2020 07:08:59 -0400
Received: by mail-wr1-f65.google.com with SMTP id w15so5367743wrv.10;
        Sat, 04 Apr 2020 04:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=86fF0m4NPSBqHcDVuStRHfdwrOCLMsDM/UuY8splEIs=;
        b=jjAjuRYEFhGzvEzL3IiI8PhQpyuiVjb43T5WptALMCSrpK8KAE4pZfenpDPqtjp8Rq
         o01dIDSW1WOaqXoInZ1UNDilTn9AC9xCPsuhKbfvZ3t/FMIqUtwHarwGCWMojoc6PJU8
         al6z2Hv//p3EYVfcG+GYAJDf+48oEqdwngsI2dE9PiS9ApTrPuBerMLcv16BccTYSsv0
         nSXTqmZU1M+YPzVfgVVjPgL1DtoC7K/IK7BZI8R7hMZGgdlYJ0V8hfJ97KDGpIo3CBII
         bN9phQ9bP1ndvMHoTio8YVKdi+/XT79spG21aKQ8AA/QSwPUGxSIWFUge3FCzA6ZjB0Q
         mn5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=86fF0m4NPSBqHcDVuStRHfdwrOCLMsDM/UuY8splEIs=;
        b=mMNJbEicyDngz4Y93Flh9aFImak6m1qAdf620zgGa7jJXTQzba/yb5L0TSrZ6DHUqF
         8gmI6DDB+3L2NemCGMQrqZl8f4UPNt8EmaTUsdk0GH3iMzSajday/maJ3FJAWWnpaxFB
         Xn8n4+/q8eIvQAw3c9ak5Pnb6cvP7L+swP5TmX2aiKnYJzSF6BCCxdJLbOaHLu1sg6TO
         +M1uUte+/i03OLHdn+tNDJ3zZSAhd1/WE1VBvVcD9iKKmKfjW4nFU+4GQXRBJgzEGpVk
         RAJNs5mfm/RBjvCOwlbVc43lZX6cOQtBErvLMpvAzExW1Yi23vxln0NJ7FXoZOFNXSPl
         cq1Q==
X-Gm-Message-State: AGi0PubrOOOULwIsvVPF7ADMyuWY7RXj//VdSiVb6iRJ37T0udGKpUuy
        ok8+FNbn8rf6c4722MRVkj3iS40w
X-Google-Smtp-Source: APiQypLy6oqhpZWz2NZzaJQGbjFlFQBQSl5sXajve6Mgd2TYPM8ws975Nm5oUciyZ7obP69cJbHaFA==
X-Received: by 2002:a05:6000:a:: with SMTP id h10mr14674037wrx.226.1585998534207;
        Sat, 04 Apr 2020 04:08:54 -0700 (PDT)
Received: from ?IPv6:2001:a61:2482:101:3351:6160:8173:cc31? ([2001:a61:2482:101:3351:6160:8173:cc31])
        by smtp.gmail.com with ESMTPSA id b67sm15490030wmh.29.2020.04.04.04.08.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Apr 2020 04:08:53 -0700 (PDT)
Cc:     mtk.manpages@gmail.com, Christian Brauner <christian@brauner.io>,
        linux-man <linux-man@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Containers <containers@lists.linux-foundation.org>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Adrian Reber <adrian@lisas.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>
To:     Andrei Vagin <avagin@openvz.org>, Dmitry Safonov <dima@arista.com>
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Subject: RFC: time_namespaces(7) manual page
Message-ID: <7221df0a-435b-f8bc-ff91-c188af535e73@gmail.com>
Date:   Sat, 4 Apr 2020 13:08:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hello Dmitry, Andrei, et al.

I have written a manual page to document time namespaces.
Could you please take a look and let me know of any
corrections, improvements, etc.

The rendered page is shown below. Th epage source is at the foot of
this mail.

Thanks,

Michael


NAME
       time_namespaces - overview of Linux time namespaces

DESCRIPTION
       Time namespaces virtualize the values of two system clocks:

       · CLOCK_MONOTONIC   (and   likewise   CLOCK_MONOTONIC_COARSE   and
         CLOCK_MONOTONIC_RAW), a nonsettable clock that represents  mono‐
         tonic  time   since—as  described   by  POSIX—"some  unspecified
         point in the past".

       · CLOCK_BOOTTIME (and likewise CLOCK_BOOTTIME_ALARM), a clock that
         is  identical  to  CLOCK_MONOTONIC, except that it also includes
         any time that the system is suspended.

       Thus, the processes in a time namespace share per-namespace values
       for  these clocks.  This affects various APIs that measure against
       these   clocks,   including:   clock_nanosleep(2),   nanosleep(2),
       clock_gettime(2), and /proc/uptime.

       Currently,  the  only way to create a time namespace is by calling
       unshare(2) with the CLONE_NEWTIME flag.  This call creates  a  new
       time  namespace  but does not place the calling process in the new
       namespace.  Instead, the calling  process's  subsequently  created
       children  are placed in the new namespace.  This allows clock off‐
       sets (see below) for the new namespace to be set before the  first
       process      is      placed     in     the     namespace.      The
       /proc/[pid]/ns/time_for_children  symbolic  link  shows  the  time
       namespace in which the children of a process will be created.

   /proc/PID/timens_offsets
       Associated  with  each  time namespace are offsets, expressed with
       respect to the initial time namespace, that define the  values  of
       the  monotonic  and  boot clocks in that namespace.  These offsets
       are exposed via the file  /proc/PID/timens_offsets.   Within  this
       file,  the  offsets  are  expressed  as  lines consisting of three
       space-delimited fields:

           <clock-id> <offset-secs> <offset-nanosecs>

       The clock-id identifies the clock whose offsets are  being  shown.
       This field is either 1, for CLOCK_MONOTONIC, or 7, for CLOCK_BOOT‐
       TIME.  The remaining  fields  express  the  offset  (seconds  plus
       nanoseconds)  for the clock in this time namespace.  These offsets
       are expressed relative to the clock values  in  the  initial  time
       namespace.   In  the  initial time namespace, the contents of this
       file are as follows:

           $ cat /proc/self/timens_offsets
           1 0 0
           7 0 0

       In a new time namespace that has  had  no  member  processes,  the
       clock  offsets  can  be  modified  by  writing  newline-terminated
       records of the same form to the file.  The file can be written  to
       multiple times, but after the first process has been created in or
       has entered the namespace, write(2)s on this file  fail  with  the
       error  EACCES.   In  order  to write to the timens_offsets file, a
       process must have the CAP_SYS_TIME capability in the  user  names‐
       pace that owns the time namespace.

       In a new time namespace created by unshare(2), the contents of the
       timens_offsets file are inherited from the time namespace  of  the
       creating process.

NOTES
       Use  of  time namespaces requires a kernel that is configured with
       the CONFIG_TIME_NS option.

       Note that time namespaces do  not  virtualize  the  CLOCK_REALTIME
       clock.   Virtualization  of  this clock was avoided for reasons of
       complexity and overhead within the kernel.

       The motivation for adding time namespaces was to allow  the  mono‐
       tonic  and  boot-time  clocks to maintain consistent values during
       container migration and checkpoint/restore.

EXAMPLE
       The following shell session demonstrates  the  operation  of  time
       namespaces.   We  begin by displaying the inode number of the time
       namespace of a shell in the initial time namespace:

           $ readlink /proc/$$/ns/time
           time:[4026531834]

       Continuing in the initial time namespace, we  display  the  system
       uptime  using  uptime(1)  and  use the clock_times example program
       shown in clock_getres(2) to display the values of various clocks:

           $ uptime --pretty
           up 21 hours, 17 minutes
           $ ./clock_times
           CLOCK_REALTIME : 1585989401.971 (18356 days +  8h 36m 41s)
           CLOCK_TAI      : 1585989438.972 (18356 days +  8h 37m 18s)
           CLOCK_MONOTONIC:      56338.247 (15h 38m 58s)
           CLOCK_BOOTTIME :      76633.544 (21h 17m 13s)

       We then use unshare(1) to create a time namespace  and  execute  a
       bash(1)  shell.  From the new shell, we use the built-in echo com‐
       mand to write records to the  timens_offsets  file  adjusting  the
       offset for the CLOCK_MONOTONIC clock forward 2 days and the offset
       for the CLOCK_BOOTTIME clock forward 7 days:

           $ PS1="ns2# " sudo unshare -T -- bash --norc
           ns2# echo "1 $((2*24*60*60)) 0" > /proc/$$/timens_offsets
           ns2# echo "7 $((7*24*60*60)) 0" > /proc/$$/timens_offsets

       Above, we started the bash(1) shell with  the  --norc  options  so
       that  no  start-up  scripts  were  executed.  This ensures that no
       child processes are created from the shell before we have a chance
       to update the timens_offsets file.

       We  then  use cat(1) to display the contents of the timens_offsets
       file.  The execution of cat(1) creates the first  process  in  the
       new  time  namespace,  after  which further attempts to update the
       timens_offsets file produce an error.

           ns2# cat /proc/$$/timens_offsets
           1 172800 0
           7 604800 0
           ns2# echo "7 $((9*24*60*60)) 0" > /proc/$$/timens_offsets
           bash: echo: write error: Permission denied

       Continuing in the new namespace,  we  execute  uptime(1)  and  the
       clock_times example program:

           ns2# uptime --pretty
           up 1 week, 21 hours, 18 minutes
           ns2# ./clock_times
           CLOCK_REALTIME : 1585989457.056 (18356 days +  8h 37m 37s)
           CLOCK_TAI      : 1585989494.057 (18356 days +  8h 38m 14s)
           CLOCK_MONOTONIC:     229193.332 (2 days + 15h 39m 53s)
           CLOCK_BOOTTIME :     681488.629 (7 days + 21h 18m  8s)

       From the above output, we can see that the monotonic and boot-time
       clocks have new values in the new time namespace.

       Examining          the           /proc/[pid]/ns/time           and
       /proc/[pid]/ns/time_for_children  symbolic  links, we see that the
       shell is a member of the initial time namespace, but its  children
       are created in a different namespace.

           ns2# readlink /proc/$$/ns/time
           time:[4026531834]
           ns2# readlink /proc/$$/ns/time_for_children
           time:[4026532900]
           ns2# readlink /proc/self/ns/time   # Creates a child process
           time:[4026532900]

       Returning  to the shell in the initial time namespace, we see that
       the  monotonic  and  boot-time  clocks  are  unaffected   by   the
       timens_offsets changes that were made in the other time namespace:

           $ uptime --pretty
           up 21 hours, 19 minutes
           $ ./clock_times
           CLOCK_REALTIME : 1585989401.971 (18356 days +  8h 38m 51s)
           CLOCK_TAI      : 1585989438.972 (18356 days +  8h 39m 28s)
           CLOCK_MONOTONIC:      56338.247 (15h 41m  8s)
           CLOCK_BOOTTIME :      76633.544 (21h 19m 23s)

SEE ALSO
       nsenter(1),  unshare(1),  clock_settime(2).  setns(2), unshare(2),
       namespaces(7), time(7)

Linux                           2020-04-01             TIME_NAMESPACES(7)

========== Page source below ==========

.\" Copyright (c) 2020 by Michael Kerrisk <mtk.manpages@gmail.com>
.\"
.\" %%%LICENSE_START(VERBATIM)
.\" Permission is granted to make and distribute verbatim copies of this
.\" manual provided the copyright notice and this permission notice are
.\" preserved on all copies.
.\"
.\" Permission is granted to copy and distribute modified versions of this
.\" manual under the conditions for verbatim copying, provided that the
.\" entire resulting derived work is distributed under the terms of a
.\" permission notice identical to this one.
.\"
.\" Since the Linux kernel and libraries are constantly changing, this
.\" manual page may be incorrect or out-of-date.  The author(s) assume no
.\" responsibility for errors or omissions, or for damages resulting from
.\" the use of the information contained herein.  The author(s) may not
.\" have taken the same level of care in the production of this manual,
.\" which is licensed free of charge, as they might when working
.\" professionally.
.\"
.\" Formatted or processed versions of this manual, if unaccompanied by
.\" the source, must acknowledge the copyright and authors of this work.
.\" %%%LICENSE_END
.\"
.\"
.TH TIME_NAMESPACES 7 2020-04-01 "Linux" "Linux Programmer's Manual"
.SH NAME
time_namespaces \- overview of Linux time namespaces
.SH DESCRIPTION
Time namespaces virtualize the values of two system clocks:
.IP \(bu 2
.BR CLOCK_MONOTONIC
(and likewise
.BR CLOCK_MONOTONIC_COARSE
and
.BR CLOCK_MONOTONIC_RAW ),
a nonsettable clock that represents monotonic time  since\(emas
described  by  POSIX\(em"some  unspecified  point in the past".
.IP \(bu
.BR CLOCK_BOOTTIME 
(and likewise
.BR CLOCK_BOOTTIME_ALARM ),
a clock that is identical to
.BR CLOCK_MONOTONIC ,
except that it also includes any time that the system is suspended.
.PP
Thus, the processes in a time namespace share per-namespace values
for these clocks.
This affects various APIs that measure against these clocks, including:
.BR clock_nanosleep (2),
.BR nanosleep (2),
.BR clock_gettime (2),
and
.IR /proc/uptime .
.PP
Currently, the only way to create a time namespace is by calling
.BR unshare (2)
with the
.BR CLONE_NEWTIME
flag.
This call creates a new time namespace but does
.I not
place the calling process in the new namespace.
Instead, the calling process's
subsequently created children are placed in the new namespace.
This allows clock offsets (see below) for the new namespace
to be set before the first process is placed in the namespace.
The
.IR /proc/[pid]/ns/time_for_children
symbolic link shows the time namespace in which
the children of a process will be created.
.\"
.SS /proc/PID/timens_offsets
Associated with each time namespace are offsets,
expressed with respect to the initial time namespace,
that define the values of the monotonic and boot clocks in that namespace.
These offsets are exposed via the file
.IR /proc/PID/timens_offsets .
Within this file,
the offsets are expressed as lines consisting of
three space-delimited fields:
.PP
.in +4n
.EX
<clock-id> <offset-secs> <offset-nanosecs>
.EE
.in
.PP
The
.I clock-id
identifies the clock whose offsets are being shown.
This field is either 1, for
.BR CLOCK_MONOTONIC ,
or 7, for
.BR CLOCK_BOOTTIME .
The remaining fields express the offset (seconds plus nanoseconds) for the
clock in this time namespace.
These offsets are expressed relative to the clock values in
the initial time namespace.
In the initial time namespace, the contents of this file are as follows:
.PP
.in +4n
.EX
$ \fBcat /proc/self/timens_offsets\fP
1 0 0
7 0 0
.EE
.in
.PP
In a new time namespace that has had no member processes,
the clock offsets can be modified by writing newline-terminated
records of the same form to the file.
The file can be written to multiple times,
but after the first process has been created in or has entered the namespace,
.BR write (2)s
on this file fail with the error
.BR EACCES .
In order to write to the
.IR timens_offsets
file, a process must have the
.BR CAP_SYS_TIME
capability in the user namespace that owns the time namespace.
.PP
In a new time namespace created by
.BR unshare (2),
the contents of the
.I timens_offsets
file are inherited from the time namespace of the creating process.
.SH NOTES
.PP
Use of time namespaces requires a kernel that is configured with the
.B CONFIG_TIME_NS
option.
.PP
Note that time namespaces do not virtualize the
.BR CLOCK_REALTIME
clock.
Virtualization of this clock was avoided for reasons of complexity
and overhead within the kernel.
.PP
The motivation for adding time namespaces was to allow
the monotonic and boot-time clocks to maintain consistent values
during container migration and checkpoint/restore.
.SH EXAMPLE
.PP
The following shell session demonstrates the operation of time namespaces.
We begin by displaying the inode number of the time namespace
of a shell in the initial time namespace:
.PP
.in +4n
.EX
$ \fBreadlink /proc/$$/ns/time\fP
time:[4026531834]
.EE
.in
.PP
Continuing in the initial time namespace, we display the system uptime using
.BR uptime (1)
and use the
.I clock_times
example program shown in
.BR clock_getres (2)
to display the values of various clocks:
.PP
.in +4n
.EX
$ \fBuptime \-\-pretty\fP
up 21 hours, 17 minutes
$ \fB./clock_times\fP
CLOCK_REALTIME : 1585989401.971 (18356 days +  8h 36m 41s)
CLOCK_TAI      : 1585989438.972 (18356 days +  8h 37m 18s)
CLOCK_MONOTONIC:      56338.247 (15h 38m 58s)
CLOCK_BOOTTIME :      76633.544 (21h 17m 13s)
.EE
.in
.PP
We then use
.BR unshare (1)
to create a time namespace and execute a
.BR bash (1)
shell.
From the new shell, we use the built-in
.B echo
command to write records to the
.I timens_offsets
file adjusting the offset for the
.B CLOCK_MONOTONIC
clock forward 2 days
and the offset for the
.B CLOCK_BOOTTIME
clock forward 7 days:
.PP
.in +4n
.EX
$ \fBPS1="ns2# " sudo unshare \-T \-\- bash \-\-norc\fP
ns2# \fBecho "1 $((2*24*60*60)) 0" > /proc/$$/timens_offsets\fP
ns2# \fBecho "7 $((7*24*60*60)) 0" > /proc/$$/timens_offsets\fP
.EE
.in
.PP
Above, we started the
.BR bash (1)
shell with the
.B \-\-norc
options so that no start-up scripts were executed.
This ensures that no child processes are created from the
shell before we have a chance to update the
.I timens_offsets
file.
.PP
We then use
.BR cat (1)
to display the contents of the
.I timens_offsets
file.
The execution of
.BR cat (1)
creates the first process in the new time namespace,
after which further attempts to update the
.I timens_offsets
file produce an error.
.PP
.in +4n
.EX
ns2# \fBcat /proc/$$/timens_offsets\fP
1 172800 0
7 604800 0
ns2# \fBecho "7 $((9*24*60*60)) 0" > /proc/$$/timens_offsets\fP
bash: echo: write error: Permission denied
.EE
.in
.PP
Continuing in the new namespace, we execute
.BR uptime (1)
and the
.I clock_times
example program:
.PP
.in +4n
.EX
ns2# \fBuptime \-\-pretty\fP
up 1 week, 21 hours, 18 minutes
ns2# \fB./clock_times\fP
CLOCK_REALTIME : 1585989457.056 (18356 days +  8h 37m 37s)
CLOCK_TAI      : 1585989494.057 (18356 days +  8h 38m 14s)
CLOCK_MONOTONIC:     229193.332 (2 days + 15h 39m 53s)
CLOCK_BOOTTIME :     681488.629 (7 days + 21h 18m  8s)
.EE
.in
.PP
From the above output, we can see that the monotonic
and boot-time clocks have new values in the new time namespace.
.PP
Examining the
.I /proc/[pid]/ns/time
and
.I /proc/[pid]/ns/time_for_children
symbolic links, we see that the shell is a member of the initial time
namespace, but its children are created in a different namespace.

.PP
.in +4n
.EX
ns2# \fBreadlink /proc/$$/ns/time\fP
time:[4026531834]
ns2# \fBreadlink /proc/$$/ns/time_for_children\fP
time:[4026532900]
ns2# \fBreadlink /proc/self/ns/time\fP   # Creates a child process
time:[4026532900]
.EE
.in
.PP
Returning to the shell in the initial time namespace,
we see that the monotonic and boot-time clocks
are unaffected by the
.I timens_offsets
changes that were made in the other time namespace:
.PP
.in +4n
.EX
$ \fBuptime \-\-pretty\fP
up 21 hours, 19 minutes
$ \fB./clock_times\fP
CLOCK_REALTIME : 1585989401.971 (18356 days +  8h 38m 51s)
CLOCK_TAI      : 1585989438.972 (18356 days +  8h 39m 28s)
CLOCK_MONOTONIC:      56338.247 (15h 41m  8s)
CLOCK_BOOTTIME :      76633.544 (21h 19m 23s)
.EE
.in
.SH SEE ALSO
.BR nsenter (1),
.BR unshare (1),
.BR clock_settime (2).
.\" clone3() support for time namespaces is a work in progress
.\" .BR clone3 (2),
.BR setns (2),
.BR unshare (2),
.BR namespaces (7),
.BR time (7)

-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
